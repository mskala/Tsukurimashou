/* $Id: fsys.c 2939 2014-03-10 19:10:18Z mskala $ */
/* Copyright (C) 2000-2004 by George Williams */
/*
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * The name of the author may not be used to endorse or promote products
 * derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stdio.h>
#include "ustring.h"
#include "fileutil.h"
#include "gfile.h"
#include <sys/types.h>
#include <sys/stat.h>		/* for mkdir */
#include <unistd.h>
#include <glib.h>
#include <errno.h>		/* for mkdir_p */


#ifdef _WIN32
#   define MKDIR(A,B) mkdir(A)
#else
#   define MKDIR(A,B) mkdir(A,B)
#endif

static char dirname_[1024];

#if !defined(__MINGW32__)
#   include <pwd.h>
#else
#   include <windows.h>
#   include <shlobj.h>
#endif

#if defined(__MINGW32__)
static void _backslash_to_slash(char *c) {
   for (; *c; c++)
      if (*c == '\\')
	 *c = '/';
}
static void _u_backslash_to_slash(unichar_t * c) {
   for (; *c; c++)
      if (*c == '\\')
	 *c = '/';
}
#else
static void _backslash_to_slash(char *c) {
}
static void _u_backslash_to_slash(unichar_t * c) {
}
#endif

/* make directories.  make parent directories as needed,  with no error if
 * the path already exists */
int mkdir_p(const char *path, mode_t mode) {
   struct stat st;

   const char *e;

   char *p = NULL;

   char tmp[1024];

   size_t len;

   int r;

   /* ensure the path is valid */
   if (!(e = strrchr(path, '/')))
      return -EINVAL;
   /* ensure path is a directory */
   r = stat(path, &st);
   if (r == 0 && !S_ISDIR(st.st_mode))
      return -ENOTDIR;

   /* copy the pathname */
   snprintf(tmp, sizeof(tmp), "%s", path);
   len = strlen(tmp);
   if (tmp[len - 1] == '/')
      tmp[len - 1] = 0;

   /* iterate mkdir over the path */
   for (p = tmp + 1; *p; p++)
      if (*p == '/') {
	 *p = 0;
	 r = MKDIR(tmp, mode);
	 if (r < 0 && errno != EEXIST)
	    return -errno;
	 *p = '/';
      }

   /* try to make the whole path */
   r = MKDIR(tmp, mode);
   if (r < 0 && errno != EEXIST)
      return -errno;
   /* creation successful or the file already exists */
   return EXIT_SUCCESS;
}

char *GFileGetHomeDir(void) {
#if defined(__MINGW32__)
   char *dir = getenv("HOME");

   if (!dir)
      dir = getenv("USERPROFILE");
   if (dir) {
      char *buffer = copy(dir);

      _backslash_to_slash(buffer);
      return buffer;
   }
   return NULL;
#else
   static char *dir;

   int uid;

   struct passwd *pw;

   dir = getenv("HOME");
   if (dir != NULL)
      return (copy(dir));

   uid = getuid();
   while ((pw = getpwent()) != NULL) {
      if (pw->pw_uid == uid) {
	 dir = copy(pw->pw_dir);
	 endpwent();
	 return (dir);
      }
   }
   endpwent();
   return (NULL);
#endif
}

static void savestrcpy(char *dest, const char *src) {
   for (;;) {
      *dest = *src;
      if (*dest == '\0')
	 break;
      ++dest;
      ++src;
   }
}

char *GFileGetAbsoluteName(char *name, char *result, int rsiz) {
   /* result may be the same as name */
   char buffer[1000];

   if (!GFileIsAbsolute(name)) {
      char *pt, *spt, *rpt, *bpt;

      if (dirname_[0] == '\0') {
	 getcwd(dirname_, sizeof(dirname_));
      }
      strcpy(buffer, dirname_);
      if (buffer[strlen(buffer) - 1] != '/')
	 strcat(buffer, "/");
      strcat(buffer, name);
#if defined(__MINGW32__)
      _backslash_to_slash(buffer);
#endif

      /* Normalize out any .. */
      spt = rpt = buffer;
      while (*spt != '\0') {
	 if (*spt == '/') {
	    if (*++spt == '\0')
	       break;
	 }
	 for (pt = spt; *pt != '\0' && *pt != '/'; ++pt);
	 if (pt == spt)		/* Found // in a path spec, reduce to / (we've */
	    savestrcpy(spt, spt + 1);	/*  skipped past the :// of the machine name) */
	 else if (pt == spt + 1 && spt[0] == '.' && *pt == '/') {	/* Noop */
	    savestrcpy(spt, spt + 2);
	 } else if (pt == spt + 2 && spt[0] == '.' && spt[1] == '.') {
	    for (bpt = spt - 2; bpt > rpt && *bpt != '/'; --bpt);
	    if (bpt >= rpt && *bpt == '/') {
	       savestrcpy(bpt, pt);
	       spt = bpt;
	    } else {
	       rpt = pt;
	       spt = pt;
	    }
	 } else
	    spt = pt;
      }
      name = buffer;
      if (rsiz > sizeof(buffer))
	 rsiz = sizeof(buffer);	/* Else valgrind gets unhappy */
   }
   if (result != name) {
      strncpy(result, name, rsiz);
      result[rsiz - 1] = '\0';
#if defined(__MINGW32__)
      _backslash_to_slash(result);
#endif
   }
   return (result);
}

char *GFileMakeAbsoluteName(char *name) {
   char buffer[1025];

   GFileGetAbsoluteName(name, buffer, sizeof(buffer));
   return (copy(buffer));
}

char *GFileNameTail(const char *oldname) {
   char *pt;

   pt = strrchr(oldname, '/');
   if (pt != NULL)
      return (pt + 1);
   else
      return ((char *) oldname);
}

char *GFileAppendFile(char *dir, char *name, int isdir) {
   char *ret, *pt;

   ret = (char *) malloc((strlen(dir) + strlen(name) + 3));
   strcpy(ret, dir);
   pt = ret + strlen(ret);
   if (pt > ret && pt[-1] != '/')
      *pt++ = '/';
   strcpy(pt, name);
   if (isdir) {
      pt += strlen(pt);
      if (pt > ret && pt[-1] != '/') {
	 *pt++ = '/';
	 *pt = '\0';
      }
   }
   return (ret);
}

int GFileIsAbsolute(const char *file) {
#if defined(__MINGW32__)
   if ((file[1] == ':')
       && (('a' <= file[0] && file[0] <= 'z')
	   || ('A' <= file[0] && file[0] <= 'Z')))
      return (true);
#else
   if (*file == '/')
      return (true);
#endif
   if (strstr(file, "://") != NULL)
      return (true);

   return (false);
}

int GFileIsDir(const char *file) {
   struct stat info;

   if (stat(file, &info) == -1)
      return 0;
   else
      return (S_ISDIR(info.st_mode));
}

int GFileExists(const char *file) {
   return (access(file, 0) == 0);
}

int GFileReadable(char *file) {
   return (access(file, 04) == 0);
}

int GFileMkDir(char *name) {
   return (MKDIR(name, 0755));
}

char *_GFile_find_program_dir(char *prog) {
   char *pt, *path, *program_dir = NULL;

   char filename[2000];

#if defined(__MINGW32__)
   char *pt1 = strrchr(prog, '/');

   char *pt2 = strrchr(prog, '\\');

   if (pt1 < pt2)
      pt1 = pt2;
   if (pt1)
      program_dir = copyn(prog, pt1 - prog);
   else if ((path = getenv("PATH")) != NULL) {
      char *tmppath = copy(path);

      path = tmppath;
      for (;;) {
	 pt1 = strchr(path, ';');
	 if (pt1)
	    *pt1 = '\0';
	 sprintf(filename, "%s/%s", path, prog);
	 if (access(filename, 1) != -1) {
	    program_dir = copy(path);
	    break;
	 }
	 if (!pt1)
	    break;
	 path = pt1 + 1;
      }
      free(tmppath);
   }
#else
   if ((pt = strrchr(prog, '/')) != NULL)
      program_dir = copyn(prog, pt - prog);
   else if ((path = getenv("PATH")) != NULL) {
      while ((pt = strchr(path, ':')) != NULL) {
	 sprintf(filename, "%.*s/%s", (int) (pt - path), path, prog);
	 /* Under cygwin, applying access to "potrace" will find "potrace.exe" */
	 /*  no need for special check to add ".exe" */
	 if (access(filename, 1) != -1) {
	    program_dir = copyn(path, pt - path);
	    break;
	 }
	 path = pt + 1;
      }
      if (program_dir == NULL) {
	 sprintf(filename, "%s/%s", path, prog);
	 if (access(filename, 1) != -1)
	    program_dir = copy(path);
      }
   }
#endif

   if (program_dir == NULL)
      return (NULL);
   GFileGetAbsoluteName(program_dir, filename, sizeof(filename));
   free(program_dir);
   program_dir = copy(filename);
   return (program_dir);
}

static char *GResourceProgramDir = 0;

void FindProgDir(char *prog) {
#if defined(__MINGW32__)
   char path[MAX_PATH + 4];

   char *c = path;

   char *tail = 0;

   unsigned int len = GetModuleFileNameA(NULL, path, MAX_PATH);

   path[len] = '\0';
   for (; *c; *c++) {
      if (*c == '\\') {
	 tail = c;
	 *c = '/';
      }
   }
   if (tail)
      *tail = '\0';
   GResourceProgramDir = copy(path);
#else
   GResourceProgramDir = _GFile_find_program_dir(prog);
   if (GResourceProgramDir == NULL) {
      char filename[1025];

      GFileGetAbsoluteName(".", filename, sizeof(filename));
      GResourceProgramDir = copy(filename);
   }
#endif
}

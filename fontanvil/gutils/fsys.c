/* Copyright (C) 2000-2004 by George Williams */
/*
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.

 * Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.

 * The name of the author may not be used to endorse or promote products
 * derived from this software without specific prior written permission.

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
#include <errno.h>			/* for mkdir_p */


#ifdef _WIN32
#define MKDIR(A,B) mkdir(A)
#else
#define MKDIR(A,B) mkdir(A,B)
#endif

static char dirname_[1024];
#if !defined(__MINGW32__)
 #include <pwd.h>
#else
 #include <windows.h>
 #include <shlobj.h>
#endif

#if defined(__MINGW32__)
static void _backslash_to_slash(char* c){
    for(; *c; c++)
	if(*c == '\\')
	    *c = '/';
}
static void _u_backslash_to_slash(unichar_t* c){
    for(; *c; c++)
	if(*c == '\\')
	    *c = '/';
}
#else
static void _backslash_to_slash(char* c){
}
static void _u_backslash_to_slash(unichar_t* c){
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
	if(!(e = strrchr(path, '/')))
return -EINVAL;
	/* ensure path is a directory */
	r = stat(path, &st);
	if (r == 0 && !S_ISDIR(st.st_mode))
return -ENOTDIR;

	/* copy the pathname */
	snprintf(tmp, sizeof(tmp),"%s", path);
	len = strlen(tmp);
	if(tmp[len - 1] == '/')
	tmp[len - 1] = 0;

	/* iterate mkdir over the path */
	for(p = tmp + 1; *p; p++)
	if(*p == '/') {
		*p = 0;
		r = MKDIR(tmp, mode);
		if (r < 0 && errno != EEXIST)
return -errno;
		*p = '/';
	}

	/* try to make the whole path */
	r = MKDIR(tmp, mode);
	if(r < 0 && errno != EEXIST)
return -errno;
	/* creation successful or the file already exists */
return EXIT_SUCCESS;
}

/* Wrapper for formatted variable list printing. */
char *smprintf(char *fmt, ...) {
	va_list fmtargs;
	char *ret;
	int len;

	va_start(fmtargs, fmt);
	len = vsnprintf(NULL, 0, fmt, fmtargs);
	va_end(fmtargs);
	ret = malloc(++len);
	if (ret == NULL) {
	perror("malloc");
exit(EXIT_FAILURE);
	}

	va_start(fmtargs, fmt);
	vsnprintf(ret, len, fmt, fmtargs);
	va_end(fmtargs);
return ret;
}

char *GFileGetHomeDir(void) {
#if defined(__MINGW32__)
    char* dir = getenv("HOME");
    if(!dir)
	dir = getenv("USERPROFILE");
    if(dir){
	char* buffer = copy(dir);
	_backslash_to_slash(buffer);
return buffer;
    }
return NULL;
#else
    static char *dir;
    int uid;
    struct passwd *pw;

    dir = getenv("HOME");
    if ( dir!=NULL )
	return( copy(dir) );

    uid = getuid();
    while ( (pw=getpwent())!=NULL ) {
	if ( pw->pw_uid==uid ) {
	    dir = copy(pw->pw_dir);
	    endpwent();
return( dir );
	}
    }
    endpwent();
return( NULL );
#endif
}

static void savestrcpy(char *dest,const char *src) {
    for (;;) {
	*dest = *src;
	if ( *dest=='\0' )
    break;
	++dest; ++src;
    }
}

char *GFileGetAbsoluteName(char *name, char *result, int rsiz) {
    /* result may be the same as name */
    char buffer[1000];

     if ( ! GFileIsAbsolute(name) ) {
	char *pt, *spt, *rpt, *bpt;

	if ( dirname_[0]=='\0' ) {
	    getcwd(dirname_,sizeof(dirname_));
	}
	strcpy(buffer,dirname_);
	if ( buffer[strlen(buffer)-1]!='/' )
	    strcat(buffer,"/");
	strcat(buffer,name);
	#if defined(__MINGW32__)
	_backslash_to_slash(buffer);
	#endif

	/* Normalize out any .. */
	spt = rpt = buffer;
	while ( *spt!='\0' ) {
	    if ( *spt=='/' )  {
		if ( *++spt=='\0' )
	break;
	    }
	    for ( pt = spt; *pt!='\0' && *pt!='/'; ++pt );
	    if ( pt==spt )	/* Found // in a path spec, reduce to / (we've*/
		savestrcpy(spt,spt+1); /*  skipped past the :// of the machine name) */
	    else if ( pt==spt+1 && spt[0]=='.' && *pt=='/' ) {	/* Noop */
		savestrcpy(spt,spt+2);
	    } else if ( pt==spt+2 && spt[0]=='.' && spt[1]=='.' ) {
		for ( bpt=spt-2 ; bpt>rpt && *bpt!='/'; --bpt );
		if ( bpt>=rpt && *bpt=='/' ) {
		    savestrcpy(bpt,pt);
		    spt = bpt;
		} else {
		    rpt = pt;
		    spt = pt;
		}
	    } else
		spt = pt;
	}
	name = buffer;
	if ( rsiz>sizeof(buffer)) rsiz = sizeof(buffer);	/* Else valgrind gets unhappy */
    }
    if (result!=name) {
	strncpy(result,name,rsiz);
	result[rsiz-1]='\0';
	#if defined(__MINGW32__)
	_backslash_to_slash(result);
	#endif
    }
return(result);
}

char *GFileMakeAbsoluteName(char *name) {
    char buffer[1025];

    GFileGetAbsoluteName(name,buffer,sizeof(buffer));
return( copy(buffer));
}

char *GFileNameTail(const char *oldname) {
    char *pt;

    pt = strrchr(oldname,'/');
    if ( pt !=NULL )
return( pt+1);
    else
return( (char *)oldname );
}

char *GFileAppendFile(char *dir,char *name,int isdir) {
    char *ret, *pt;

    ret = (char *) malloc((strlen(dir)+strlen(name)+3));
    strcpy(ret,dir);
    pt = ret+strlen(ret);
    if ( pt>ret && pt[-1]!='/' )
	*pt++ = '/';
    strcpy(pt,name);
    if ( isdir ) {
	pt += strlen(pt);
	if ( pt>ret && pt[-1]!='/' ) {
	    *pt++ = '/';
	    *pt = '\0';
	}
    }
return(ret);
}

int GFileIsAbsolute(const char *file) {
#if defined(__MINGW32__)
    if( (file[1]==':') && (('a'<=file[0] && file[0]<='z') || ('A'<=file[0] && file[0]<='Z')) )
return ( true );
#else
    if ( *file=='/' )
return( true );
#endif
    if ( strstr(file,"://")!=NULL )
return( true );

return( false );
}

int GFileIsDir(const char *file) {
  struct stat info;
  if ( stat(file, &info)==-1 )
return 0;
  else
return( S_ISDIR(info.st_mode) );
}

int GFileExists(const char *file) {
return( access(file,0)==0 );
}

int GFileReadable(char *file) {
return( access(file,04)==0 );
}

int GFileMkDir(char *name) {
return( MKDIR(name,0755));
}

char *_GFile_find_program_dir(char *prog) {
    char *pt, *path, *program_dir=NULL;
    char filename[2000];

#if defined(__MINGW32__)
    char* pt1 = strrchr(prog, '/');
    char* pt2 = strrchr(prog, '\\');
    if(pt1<pt2) pt1=pt2;
    if(pt1)
	program_dir = copyn(prog, pt1-prog);
    else if( (path = getenv("PATH")) != NULL ){
	char* tmppath = copy(path);
	path = tmppath;
	for(;;){
	    pt1 = strchr(path, ';');
	    if(pt1) *pt1 = '\0';
	    sprintf(filename,"%s/%s", path, prog);
	    if ( access(filename,1)!= -1 ) {
		program_dir = copy(path);
		break;
	    }
	    if(!pt1) break;
	    path = pt1+1;
	}
	free(tmppath);
    }
#else
    if ( (pt = strrchr(prog,'/'))!=NULL )
	program_dir = copyn(prog,pt-prog);
    else if ( (path = getenv("PATH"))!=NULL ) {
	while ((pt = strchr(path,':'))!=NULL ) {
	  sprintf(filename,"%.*s/%s", (int)(pt-path), path, prog);
	    /* Under cygwin, applying access to "potrace" will find "potrace.exe" */
	    /*  no need for special check to add ".exe" */
	    if ( access(filename,1)!= -1 ) {
		program_dir = copyn(path,pt-path);
	break;
	    }
	    path = pt+1;
	}
	if ( program_dir==NULL ) {
	    sprintf(filename,"%s/%s", path, prog);
	    if ( access(filename,1)!= -1 )
		program_dir = copy(path);
	}
    }
#endif

    if ( program_dir==NULL )
return( NULL );
    GFileGetAbsoluteName(program_dir,filename,sizeof(filename));
    free(program_dir);
    program_dir = copy(filename);
return( program_dir );
}

static char *GResourceProgramDir = 0;

char* getGResourceProgramDir() {
    return GResourceProgramDir;
}


void FindProgDir(char *prog) {
#if defined(__MINGW32__)
    char  path[MAX_PATH+4];
    char* c = path;
    char* tail = 0;
    unsigned int  len = GetModuleFileNameA(NULL, path, MAX_PATH);
    path[len] = '\0';
    for(; *c; *c++){
    	if(*c == '\\'){
    	    tail=c;
    	    *c = '/';
    	}
    }
    if(tail) *tail='\0';
    GResourceProgramDir = copy(path);
#else
    GResourceProgramDir = _GFile_find_program_dir(prog);
    if ( GResourceProgramDir==NULL ) {
	char filename[1025];
	GFileGetAbsoluteName(".",filename,sizeof(filename));
	GResourceProgramDir = copy(filename);
    }
#endif
}

char *getShareDir(void) {
    static char *sharedir=NULL;
    static int set=false;
    char *pt;
    int len;

    if ( set )
	return( sharedir );

    set = true;

    pt = strstr(GResourceProgramDir,"/bin");
    if ( pt==NULL ) {
#ifdef SHAREDIR
	return( sharedir = SHAREDIR );
#elif defined( PREFIX )
	return( sharedir = PREFIX "/share" );
#else
	pt = GResourceProgramDir + strlen(GResourceProgramDir);
#endif
    }
    len = (pt-GResourceProgramDir)+strlen("/share/fontforge")+1;
    sharedir = malloc(len);
    strncpy(sharedir,GResourceProgramDir,pt-GResourceProgramDir);
    strcpy(sharedir+(pt-GResourceProgramDir),"/share/fontforge");
    return( sharedir );
}


char *getLocaleDir(void) {
    static char *sharedir=NULL;
    static int set=false;

    if ( set )
	return( sharedir );

    char* prefix = getShareDir();
    int len = strlen(prefix) + strlen("/../locale") + 2;
    sharedir = malloc(len);
    strcpy(sharedir,prefix);
    strcat(sharedir,"/../locale");
    set = true;
    return sharedir;
}

char *getPixmapDir(void) {
    static char *sharedir=NULL;
    static int set=false;

    if ( set )
	return( sharedir );

    char* prefix = getShareDir();
    int len = strlen(prefix) + strlen("/pixmaps") + 2;
    sharedir = malloc(len);
    strcpy(sharedir,prefix);
    strcat(sharedir,"/pixmaps");
    set = true;
    return sharedir;
}

char *getHelpDir(void) {
    static char *sharedir=NULL;
    static int set=false;

    if ( set )
	return( sharedir );

    char* prefix = getShareDir();
#if defined(DOCDIR)
    prefix = DOCDIR;
#endif
    char* postfix = "/../doc/fontforge/";
    int len = strlen(prefix) + strlen(postfix) + 2;
    sharedir = malloc(len);
    strcpy(sharedir,prefix);
    strcat(sharedir,postfix);
    set = true;
    return sharedir;
}

/* reimplementation of GFileGetHomeDir, avoiding copy().  Returns NULL if home
 * directory cannot be found */
char *getUserHomeDir(void) {
#if defined(__MINGW32__)
	char* dir = getenv("APPDATA");
	if( dir==NULL )
	dir = getenv("USERPROFILE");
	if( dir!=NULL ) {
	_backslash_to_slash(dir);
return dir;
	}
return NULL;
#else
	int uid;
	struct passwd *pw;
	char *home = getenv("HOME");

	if( home!=NULL )
return home;

	uid = getuid();
	while( (pw=getpwent())!=NULL ) {
	if ( pw->pw_uid==uid ) {
		home = pw->pw_dir;
		endpwent();
return home;
	}
	}
	endpwent();
return NULL;
#endif
}

/* Find the directory in which FontForge places all of its configurations and
 * save files.  On Unix-likes, the argument `dir` (see the below case switch,
 * enum in inc/gfile.h) determines which directory is returned according to the
 * XDG Base Directory Specification.  On Windows, the argument is ignored--the
 * home directory as obtained by getUserHomeDir() is returned.  On error, NULL
 * is returned.
 *
 * http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
 *
 * This function is retained temporarily, to help reduce incompatibility on
 * systems that have both FontForge and FontAnvil installed.  Placing this
 * code in libgutils at all is deprecated, and FontAnvil will eventually move
 * its home-dir-finding code elsewhere, and possibly stop using gutils at all.
 */
char *getFontForgeUserDir(int dir) {
	char *def, *home, *xdg;
	char *buf = NULL;

	/* find home directory first, it is needed if any of the xdg env vars are
	 * not set */
	if (!(home = getUserHomeDir())) {
	/* if getUserHomeDir returns NULL, pass NULL to calling function */
	fprintf(stderr, "%s\n", "cannot find home directory");
return NULL;
	}
#if defined(__MINGW32__)
	/* If we are on Windows, just use the home directory (%APPDATA% or
	 * %USERPROFILE% in that order) for everything */
return home;
#else
	/* Home directory exists, so check for environment variables.  For each of
	 * XDG_{CACHE,CONFIG,DATA}_HOME, assign `def` as the corresponding fallback
	 * for if the environment variable does not exist. */
	switch(dir) {
	  case Cache:
	xdg = getenv("XDG_CACHE_HOME");
	def = ".cache";
	  break;
	  case Config:
	xdg = getenv("XDG_CONFIG_HOME");
	def = ".config";
	  break;
	  case Data:
	xdg = getenv("XDG_DATA_HOME");
	def = ".local/share";
	  break;
	  default:
	/* for an invalid argument, return NULL */
	fprintf(stderr, "%s\n", "invalid input");
return NULL;
	}
	if(xdg != NULL)
	/* if, for example, XDG_CACHE_HOME exists, assign the value
	 * "$XDG_CACHE_HOME/fontforge" */
	buf = smprintf("%s/fontforge", xdg);
	else
	/* if, for example, XDG_CACHE_HOME does not exist, instead assign
	 * the value "$HOME/.cache/fontforge" */
	buf = smprintf("%s/%s/fontforge", home, def);
	if(buf != NULL) {
	/* try to create buf.  If creating the directory fails, return NULL
	 * because nothing will get saved into an inaccessible directory.  */
	if(mkdir_p(buf, 0755) != EXIT_SUCCESS)
return NULL;
return buf;
	}
return NULL;
#endif
}

long GFileGetSize(char *name) {
/* Get the binary file size for file 'name'. Return -1 if error. */
    struct stat buf;
    long rc;

    if ( (rc=stat(name,&buf)) )
	return( -1 );
    return( buf.st_size );
}

char *GFileReadAll(char *name) {
/* Read file 'name' all into one large string. Return 0 if error. */
    char *ret;
    long sz;

    if ( (sz=GFileGetSize(name))>=0 && \
	 (ret=calloc(1,sz+1))!=NULL ) {
	FILE *fp;
	if ( (fp=fopen(name,"rb"))!=NULL ) {
	    size_t bread=fread(ret,1,sz,fp);
	    fclose(fp);

	    if( bread==sz )
		return( ret );
	}
	free(ret);
    }
    return( 0 );
}

const char *getTempDir(void)
{
    return g_get_tmp_dir();
}

/* $Id: http.c 4286 2015-10-20 10:46:56Z mskala $ */
/* Copyright (C) 2007-2012  George Williams
 * Copyright (C) 2015  Matthew Skala
 *
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
#include "fontanvilvw.h"
#include <ustring.h>
#include <utype.h>

#if defined(__MINGW32__)
AFILE *URLToTempFile(char *url, void *_lock) {
   return NULL;
}
int URLFromFile(char *url, AFILE *from) {
   return false;
}
#else

#   include <stdio.h>
#   include <unistd.h>
#   include <sys/select.h>
#   include <sys/types.h>
#   include <sys/socket.h>
#   ifndef MSG_NOSIGNAL
#      define MSG_NOSIGNAL        0x0
				/* MSG_NOSIGNAL is POSIX.1-2008 (not implemented on Mac and Solaris) */
#   endif
#   include <netinet/in.h>
#   include <arpa/inet.h>
#   include <netdb.h>
#   include <string.h>
#   include <stdlib.h>
#   include <time.h>
#   include <sys/time.h>	/* BSDs hold "struct timeval" here */
#   include <errno.h>
#   include <pthread.h>

struct siteinfo {
   int cookie_cnt;
   char *cookies[30];
   int user_id;
   char *upload_id;
};

enum conversation_type { ct_savecookies, ct_slurpdata, ct_getuserid,
      ct_getuploadid };

static int findhost(struct sockaddr_in *addr,char *hostname) {
   struct hostent *hostent;
   int i;
   static int last_len;
   static char last_addr[40];
   static char *last_host=NULL;

   if (last_host != NULL && strcmp(last_host, hostname)==0) {
      memcpy(&addr->sin_addr, last_addr, last_len);
      return (1);
   } else {
      hostent=gethostbyname(hostname);
      if (hostent==NULL)
	 return (0);
   }
   for (i=0; hostent->h_addr_list[i] != NULL; ++i);
   memcpy(&addr->sin_addr,
	  hostent->h_addr_list[sfmt_genrand_uint32(&fa_sfmt)%i],
	  hostent->h_length);
   if (hostent->h_length < sizeof(last_addr)) {	/* Cache the last hostname, in case they ask for it again */
      free(last_host);
      last_host=fastrdup(hostname);
      last_len=hostent->h_length;
      memcpy(last_addr,
	     hostent->h_addr_list[sfmt_genrand_uint32(&fa_sfmt)%i],
	     hostent->h_length);
   }
   endhostent();
   return (1);
}

static pthread_mutex_t host_lock=PTHREAD_MUTEX_INITIALIZER;

static int findHTTPhost(struct sockaddr_in *addr,char *hostname,int port) {
   struct servent *servent;
   int ret;

   pthread_mutex_lock(&host_lock);
   memset(addr, 0, sizeof(*addr));
   addr->sin_family=AF_INET;
   if (port >= 0)
      addr->sin_port=htons(port);
   else if ((servent=getservbyname("http", "tcp")) != NULL)
      addr->sin_port=servent->s_port;	/* Already in server byteorder */
   else
      addr->sin_port=htons(80);
   endservent();
   ret=findhost(addr, hostname);
   pthread_mutex_unlock(&host_lock);
   return (ret);
}

static int findFTPhost(struct sockaddr_in *addr,char *hostname,int port) {
   struct servent *servent;
   int ret;

   pthread_mutex_lock(&host_lock);
   memset(addr, 0, sizeof(*addr));
   addr->sin_family=AF_INET;
   if (port >= 0)
      addr->sin_port=htons(port);
   else if ((servent=getservbyname("ftp", "tcp")) != NULL)
      addr->sin_port=servent->s_port;	/* Already in server byteorder */
   else
      addr->sin_port=htons(21);
   endservent();
   ret=findhost(addr, hostname);
   pthread_mutex_unlock(&host_lock);
   return (ret);
}

/* this excedingly complex routine tries to send data on a socket. */
/*  first it waits until the socket is ready to accept data (there is no time-*/
/*  out on send/write), checking to see if the user has aborted the operation */
/*  if an interrupt happens which kills the select call then restart the call */
/*  if we get an select error we assume the connection died. If we time-out we*/
/*  essentially assume the same. If the send fails, ditto. If everything succedes */
/*  record that we sent the command */
static int ftpsend(int ctl,char *cmd) {
   struct timeval tv;
   fd_set wts;
   int i=0, ret=0;

 restart:
   FD_ZERO(&wts);
   while (i < 60) {
      FD_SET(ctl, &wts);
      tv.tv_sec=4;
      tv.tv_usec=0;
      if ((ret=select(ctl + 1, NULL, &wts, NULL, &tv)) < 0) {
	 if (errno==EINTR)
	    goto restart;
	 return (-1);
      } else if (ret > 0)
	 break;
      ++i;
   }
   if (ret==0) {
      return (-1);
   }
   if (send(ctl, cmd, strlen(cmd), MSG_NOSIGNAL) <= 0) {
      if (errno==EINTR)	/* interrupted, try again */
	 goto restart;
      return (-1);
   }
   return (true);
}

/* Similar thing for read */
static int getresponse(int ctl,char *buf,int buflen) {
   struct timeval tv;
   fd_set rds;
   int len;
   int ret=false, i;
   char *pt, *start;

 restart:
   while (1) {
      FD_ZERO(&rds);
      i=0;
      while (i < 60) {
	 FD_SET(ctl, &rds);
	 tv.tv_sec=4;
	 tv.tv_usec=0;
	 if ((ret=select(ctl + 1, &rds, NULL, NULL, &tv)) < 0) {
	    if (errno==EINTR)
	       goto restart;
	    return (-1);
	 } else if (ret > 0)
	    break;
	 ++i;
      }
      if (ret==0)		/* Time out */
	 return (-1);
      len=read(ctl, buf, buflen);
      if (len==0)
	 return (-1);
      buf[len]='\0';
      start=buf;
      while ((pt=strchr(start, '\n')) != NULL) {
	 if (start[3]==' ')
	    return (start[0]=='2' || start[0]=='1');
	 start=pt + 1;
      }
   }
}

static int ftpsendr(int ctl,char *cmd,char *buf,int buflen) {

   if (ftpsend(ctl, cmd)==-1)
      return (-1);
   return (getresponse(ctl, buf, buflen));
}

static int ftpsendpassive(int ctl,struct sockaddr_in *data_addr,char *buf,
			  int buflen) {
   char *pt, *start;

   if (ftpsend(ctl, "PASV\r\n")==-1)
      return (-1);
   if (getresponse(ctl, buf, buflen)==-1)
      return (-1);

   start=buf;
   while ((pt=strchr(start, '\n')) != NULL) {
      if (start[3]==' ')
	 break;
      start=pt + 1;
   }
   if (strtol(buf, NULL, 10)==227) {
      /* 227 Entering Passive Mode (h1,h2,h3,h4,p1,p2) */
      int h1, h2, h3, h4, p1, p2;

      for (pt=buf + 4; !isdigit(*pt) && *pt != '\n'; ++pt);
      if (*pt=='\n')
	 return (-2);		/* can't parse it */
      sscanf(pt, "%d,%d,%d,%d,%d,%d", &h1, &h2, &h3, &h4, &p1, &p2);
      data_addr->sin_family=AF_INET;
      data_addr->sin_port=htons((p1 << 8) | p2);
      data_addr->sin_addr.s_addr =
	 htonl((h1 << 24) | (h2 << 16) | (h3 << 8) | h4);
      return (1);
   } else if (*start=='4' || *start=='5')
      return (0);

   return (0);			/* shouldn't get here */
}

static int getTCPsocket() {
   struct protoent *protoent;
   int proto;

   if ((protoent=getprotobyname("tcp")) != NULL)
      proto=protoent->p_proto;
   else
      proto=IPPROTO_TCP;
   endprotoent();

#   if MSG_NOSIGNAL!=0 || !defined(SO_NOSIGPIPE)
   return (socket(PF_INET, SOCK_STREAM, proto));
#   else
   {
      int soc=socket(PF_INET, SOCK_STREAM, proto);
      int value=1;
      socklen_t len=sizeof(value);

      if (soc != -1)
	 setsockopt(soc, SOL_SOCKET, SO_NOSIGPIPE, &value, len);
      return (soc);
   }
#   endif
}

static int makeConnection(struct sockaddr_in *addr) {
   int soc=getTCPsocket();

   if (soc==-1)
      return (-1);
   if (connect(soc, (struct sockaddr *) addr, sizeof(*addr))==-1) {
      perror("Connect failed?");
      close(soc);
      return (-1);
   }
   return (soc);
}

static void ChangeLine2_8(char *str) {
}

static char *decomposeURL(const char *url,char **host,int *port,
			  char **username, char **password) {
   char *pt, *pt2, *upt, *ppt;
   char *path;
   char proto[40];

   /* ftp://[user[:password]@]ftpserver[:port]/url-path */

   *username=NULL;
   *password=NULL;
   *port=-1;
   pt=strstr(url, "://");
   if (pt==NULL) {
      *host=NULL;
      return (fastrdup(url));
   }
   strncpy(proto, url, pt - url < sizeof(proto) ? pt - url : sizeof(proto));
   proto[(pt - url)]='\0';
   pt += 3;

   pt2=strchr(pt, '/');
   if (pt2==NULL) {
      pt2=pt + strlen(pt);
      path=fastrdup("/");
   } else {
      path=fastrdup(pt2);
   }

   upt=strchr(pt, '@');
   if (upt != NULL && upt < pt2) {
      ppt=strchr(pt, ':');
      if (ppt==NULL) {
	 *username=copyn(pt, upt - pt);
      } else {
	 *username=copyn(pt, ppt - pt);
	 *password=copyn(ppt + 1, upt - ppt - 1);
      }
      pt=upt + 1;
   }

   ppt=strchr(pt, ':');
   if (ppt != NULL && ppt < pt2) {
      char *temp=copyn(ppt + 1, pt2 - ppt - 1), *end;

      *port=strtol(temp, &end, 10);
      if (*end != '\0')
	 *port=-2;
      free(temp);
      pt2=ppt;
   }
   *host=copyn(pt, pt2 - pt);
   if (*username) {
      *password=GIO_PasswordCache(proto, *host, *username, *password);
      if (*password==NULL) {
	 *password="";
	 *password=GIO_PasswordCache(proto, *host, *username, *password);
      }
   }
   return (path);
}

static AFILE *HttpURLToTempFile(char *url,void *_lock) {
   pthread_mutex_t *lock=_lock;
   struct sockaddr_in addr;
   char *pt, *host, *filename, *username, *password;
   int port;
   AFILE *ret;
   char buffer[300];
   int first, code;
   int soc;
   int datalen, len;
   char *databuf;

   snprintf(buffer, sizeof(buffer), _("Downloading from %s"), url);

   if (strncasecmp(url, "http://", 7) != 0) {
      if (lock != NULL)
	 pthread_mutex_lock(lock);
      ErrorMsg(2,"Got something else when expecting an http URL\n");
      if (lock != NULL)
	 pthread_mutex_unlock(lock);
      return (NULL);
   }
   if (lock != NULL)
      pthread_mutex_lock(lock);
   filename=decomposeURL(url, &host, &port, &username, &password);
   /* I don't support username/passwords for http */
   free(username);
   free(password);
   if (lock != NULL)
      pthread_mutex_unlock(lock);

   /* This routine contains its own lock */
   if (!findHTTPhost(&addr, host, port)) {
      if (lock != NULL)
	 pthread_mutex_lock(lock);
      ErrorMsg(2,"Could not find host %s\n",host);
      free(host);
      free(filename);
      if (lock != NULL)
	 pthread_mutex_unlock(lock);
      return (false);
   }
   soc=makeConnection(&addr);
   if (soc==-1) {
      if (lock != NULL)
	 pthread_mutex_lock(lock);
      ErrorMsg(2,"Could not connect to host %s\n",host);
      free(host);
      free(filename);
      if (lock != NULL)
	 pthread_mutex_unlock(lock);
      return (false);
   }

   if (lock != NULL)
      pthread_mutex_lock(lock);
   datalen=8 * 8 * 1024;
   databuf=malloc(datalen + 1);
   if (lock != NULL)
      pthread_mutex_unlock(lock);
   else
      ChangeLine2_8(_("Requesting font..."));

   sprintf(databuf, "GET %s HTTP/1.1\r\n"
	   "Host: %s\r\n"
	   "User-Agent: FontAnvil\r\n"
	   "Connection: close\r\n\r\n", filename, host);
   if (write(soc, databuf, strlen(databuf))==-1) {
      if (lock != NULL)
	 pthread_mutex_lock(lock);
      ErrorMsg(2,"Could not send request to %s\n", host);
      close(soc);
      free(databuf);
      free(host);
      free(filename);
      free(host);
      free(filename);
      if (lock != NULL)
	 pthread_mutex_unlock(lock);
      return (NULL);
   }

   if (lock==NULL)
      ChangeLine2_8(_("Downloading font..."));

   if (lock != NULL)
      pthread_mutex_lock(lock);
   ret=atmpfile();
   if (lock != NULL)
      pthread_mutex_unlock(lock);

   first=1;
   code=404;
   while ((len=read(soc, databuf, datalen)) > 0) {
      if (first) {
	 databuf[len]='\0';
	 sscanf(databuf, "HTTP/%*f %d", &code);
	 first=0;
	 /* check for redirects */
	 if (code >= 300 && code < 399
	     && (pt=strstr(databuf, "Location: ")) != NULL) {
	    char *newurl=pt + strlen("Location: ");

	    pt=strchr(newurl, '\r');
	    if (*pt)
	       *pt='\0';
	    close(soc);
	    if (lock != NULL)
	       pthread_mutex_lock(lock);
	    afclose(ret);
	    free(host);
	    free(filename);
	    free(databuf);
	    if (lock != NULL)
	       pthread_mutex_unlock(lock);
	    ret=URLToTempFile(newurl, lock);
	    return (ret);
	 }
	 pt=strstr(databuf, "Content-Length: ");
	 if (lock==NULL && pt != NULL) {
	    pt += strlen("Content-Length: ");
	 }
	 pt=strstr(databuf, "\r\n\r\n");
	 if (pt != NULL) {
	    pt += strlen("\r\n\r\n");
	    afwrite(pt, 1, len - (pt - databuf), ret);
	 }
      } else {
	 afwrite(databuf, 1, len, ret);
      }
   }
   close(soc);
   free(databuf);
   if (lock != NULL)
      pthread_mutex_lock(lock);
   free(host);
   free(filename);
   if (len==-1) {
      ErrorMsg(2,"Could not download data.\n");
      afclose(ret);
      ret=NULL;
   } else if (code < 200 || code > 299) {
      ErrorMsg(2,"Could not download data, HTTP return code %d.\n",code);
      afclose(ret);
      ret=NULL;
   } else
      afseek(ret,0,SEEK_SET);
   if (lock != NULL)
      pthread_mutex_unlock(lock);
   return (ret);
}

static int FtpURLAndTempFile(char *url,AFILE ** to,AFILE *from) {
   struct sockaddr_in addr, data_addr;
   char *host, *filename, *username, *password;
   int port;
   AFILE *ret;
   char buffer[300];
   int soc, data;
   int datalen, len;
   char *databuf, *cmd;

   if (from==NULL) {
      snprintf(buffer, sizeof(buffer), _("Downloading from %s"), url);
      *to=NULL;
   } else
      snprintf(buffer, sizeof(buffer), _("Uploading to %s"), url);

   if (strncasecmp(url, "ftp://", 6) != 0) {
      ErrorMsg(2,"Got something else when expecting an ftp URL.\n");
      return (false);
   }
   filename=decomposeURL(url, &host, &port, &username, &password);

   if (!findFTPhost(&addr, host, port)) {
      ErrorMsg(2,"Could not find host %s\n",host);
      free(host);
      free(filename);
      return (false);
   }
   soc=makeConnection(&addr);
   if (soc==-1) {
      ErrorMsg(2,"Could not connect to host %s\n",host);
      free(host);
      free(filename);
      return (false);
   }

   datalen=8 * 8 * 1024;
   databuf=malloc(datalen + 1);
   cmd=databuf;

   ChangeLine2_8(_("Logging in..."));
   if (getresponse(soc, databuf, datalen)==-1) {	/* ftp servers say "Hi" when then connect */
      ErrorMsg(2,"Could not connect to host %s\n",host);
      free(host);
      free(filename);
      free(username);
      free(password);
      close(soc);
      return (false);
   }
   free(host);

   if (username==NULL) {
      username=fastrdup("anonymous");
      if (password==NULL)
	 password=fastrdup("FontAnvil");
   } else if (password==NULL)
      password=fastrdup("");

   sprintf(cmd, "USER %s\r\n", username);
   if (ftpsendr(soc, cmd, databuf, datalen)==-1) {
      close(soc);
      free(filename);
      free(databuf);
      free(username);
      free(password);
      return (false);
   }
   sprintf(cmd, "PASS %s\r\n", password);
   free(username);
   free(password);
   if (ftpsendr(soc, cmd, databuf, datalen) <= 0) {
      ErrorMsg(2,"Bad username/password\n");
      close(soc);
      free(filename);
      free(databuf);
      return (false);
   }

   if (ftpsendr(soc, "TYPE I\r\n", databuf, datalen)==-1) {	/* Binary */
      close(soc);
      free(filename);
      free(databuf);
      return (false);
   }

   if (from==NULL)
      ChangeLine2_8(_("Requesting font..."));
   else
      ChangeLine2_8(_("Transmitting font..."));

   if (ftpsendpassive(soc, &data_addr, databuf, datalen) <= 0) {
      close(soc);
      free(filename);
      free(databuf);
      return (false);
   }
   if ((data=socket(PF_INET, SOCK_STREAM, 0))==-1 ||
       connect(data, (struct sockaddr *) &data_addr,
	       sizeof(data_addr))==-1) {
      if (data != -1)
	 close(data);
      close(soc);
      free(filename);
      free(databuf);
      ErrorMsg(2,"FTP passive Data Connect failed\n");
      return (0);
   }

   if (from==NULL) {
      sprintf(cmd, "RETR %s\r\n", filename);
      if (ftpsendr(soc, cmd, databuf, datalen) <= 0) {
         ErrorMsg(2,"Could not download data\n");
	 close(data);
	 close(soc);
	 free(filename);
	 free(databuf);
	 return (false);
      }

      ChangeLine2_8(_("Downloading font..."));

      ret=atmpfile();

      while ((len=read(data, databuf, datalen)) > 0) {
	 afwrite(databuf, 1, len, ret);
      }
      *to=ret;
      afseek(ret,0,SEEK_SET);
   } else {
      sprintf(cmd, "STOR %s\r\n", filename);
      if (ftpsendr(soc, cmd, databuf, datalen) <= 0) {
         ErrorMsg(2,"Could not download data\n");
	 close(data);
	 close(soc);
	 free(filename);
	 free(databuf);
	 return (false);
      }

      ChangeLine2_8(_("Uploading font..."));

      afseek(from,0,SEEK_SET);
      while ((len=afread(databuf, 1, datalen, from)) > 0) {
	 if ((len=write(data, databuf, len)) < 0)
	    break;
      }
      ret=NULL;
   }
   close(soc);
   close(data);
   free(databuf);
   free(filename);
   if (len==-1) {
         ErrorMsg(2,"Could not transmit data\n");
      if (ret != NULL)
	 afclose(ret);
      return (false);
   }
   return (true);
}

AFILE *URLToTempFile(char *url, void *_lock) {
   AFILE *ret;

   if (strncasecmp(url, "http://", 7)==0)
      return (HttpURLToTempFile(url, _lock));
   else if (strncasecmp(url, "ftp://", 6)==0) {
      if (FtpURLAndTempFile(url, &ret, NULL))
	 return (ret);
      return (NULL);
   } else {
      ErrorMsg(2,"Could not parse URL\n");
      return (NULL);
   }
}

#endif /* !__MINGW32__ */

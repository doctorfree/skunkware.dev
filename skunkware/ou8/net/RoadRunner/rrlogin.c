/* San Diego Road Runner login program for Linux/BSDI/FreeBSD/Solaris
 * Copyright 1999 Phil Karn, KA9Q
 * This software may be used under the terms of the GNU Public License

 * To compile under Linux:
 * gcc -o rrlogin rrlogin.c

 * To compile under Solaris:
 * cc -o rrlogin rrlogin.c -lsocket -lnsl -lresolv

 * If you're running Linux with dhcpcd, rrlogin can automatically get
 * the TAS IP address from the file /etc/dhcpc/resolv.conf created by
 * dhcpcd. In that case, you invoke rrlogin like this:

 * rrlogin rr_login_name rr_password

 * If /etc/dhcpc/resolv.conf isn't readable, rrlogin will try the file
 * /etc/resolv.conf (running the risk that this file has been locally
 * modified).

 * If you know the IP address of your TAS, you can override all
 * these DHCP heuristics by specifying the TAS IP address on the command line like this:

 * rrlogin -h tas_ip_address rr_login_name rr_password

 * One way to determine the TAS IP address is to bring up W95/N5, run the WINIPCFG.EXE
 * utility and look for the name server provided with DHCP.

 * Revised 26 January 1999 to fix udp socket handle leak and smashed
   sockaddr struct (thanks lightner@lightner.net)

 * Revised 21 January 1999 to add check for unknown TAS IP address

 * Revised 19 January 1999 to add fallback to /etc/resolv.conf if -h is not given
 * and /etc/dhcpc/resolv.conf doesn't exist. Also reformatted indenting.

 * Revised 28 November 1998 to remove now-obsolete San Diego TAS table and to check
 * for invalid TAS address (e.g., loopback).

 * Now determines TAS IP address from -h option on command line or from DHCP-generated
 * resolver config file. If your system doesn't use the RR DNS server *and* is not
 * running dhcpcd (which creates /etc/dhcpc/resolv.conf) you MUST use the -h option.
 * If you don't know your TAS IP address, you can find it by bringing
 * up W95/98/NT (ugh) and running the WINIPCFG utility.

 * If you're outside San Diego I recommend using a closer "test host" with
 * the -p option. The default is the IP address of the MCI interface on the San Diego
 * RR router. This will usually work, but if your system ever has trouble reaching San
 * Diego, the program may re-login unnecessarily.

 * Revised 19 November 1998 to remove reference to sys_errlist[] that
 * is not available on Solaris
 *
 * Revised 3 August 1998 to revamp method for determining the
 * TAS IP address. It now works as follows:
 *
 * If the -h option is given, its argument is taken as the TAS IP
 * address.
 *
 * Else, look for the file /etc/dhcpc/resolv.conf. If it contains
 * a line beginning with "nameserver", use its argument as the IP
 * address of the TAS.
 *
 * Else, fall back to the previous table-driven method (which works
 * only in San Diego).
 *
 * This new method should work in any Road Runner system that uses
 * the Toshiba Authentication Server provided that you are using
 * dhcpcd or any other DHCP client that creates /etc/dhcpc/resolv.conf.
 *
 * Revised 9 July to rename Coronado entry
 *
 * Revised 30 June 1998 to add Coronado Road name to new TAS16 (thanks
 * Jim Fitzgerald).
 *
 * Revised 22 June 1998 to add entries for new address blocks
 * 204.210.58-62 allocated to handle overflows in Carmel Valley,
 * Scripps Ranch and UC/UTC.
 *
 * Revised 22 Feb 1998 to blank out command line login name and password
 * in ps listings for security on multi-user machines
 * Revised 3 Feb 1998 to create /var/run/rrlogin.pid file
 *
 * Revised 14 Jan 1998 to recover from DHCP reinitializations that change
 * the local RR IP address, also general cleanup of timeouts and retries.
 * Separated debug and verbose flags
 * Eliminated unnecessary -l flag
 * Eliminated redundant time field in syslog messages
 * Delinted mainly by adding #include files to declare library functions
 * Use outside San Diego now possible with -h option
 *
 * Revised 31 Dec 1997 to clean up initializations of sockaddr_in
 * structures to try to fix garbage local addresses in getsockname() calls
 * for certain shared versions of the Linux C library. Not yet verified.
 *
 * Revised 22 Aug 1997 to add null statement to default label
 * Revised: 19 July 1997 to update address of 7507 router
 *
 * Revised: 15 Jun 1997 P. Karn, karn@ka9q.ampr.org,
 * to automate determination of TAS IP address, to accept a TCP RST
 * from the test host as confirmation that we're still logged in,
 * to use SDRR's Cisco router as the test host instead of one of the
 * proxy servers, and to ignore SIGHUP and SIGPIPE.
 *
 * NB! This program is specifically designed to work with the *San Diego*
 * Road Runner network. RR networks in other cities use different IP
 * addresses and may use different login protocols. This program is
 * NOT designed to work outside San Diego. It will automatically detect
 * if this is the case and exit.
 *
 * This program now automatically determines the hub you're on
 * and the correct IP address of the TAS to use. If you wish to override
 * this, use the -h parameter.
 *
 * See <http://people.qualcomm.com/karn/rr/rrarch.html> for a listing
 * of San Diego hubs and TAS IP addresses.  */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <netdb.h>
#include <time.h>
#include <syslog.h>
#include <signal.h>
#include <errno.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

/* Port numbers for Toshiba authentication server */
#define TCPPORT 7283
#define UDPPORT 6284
#define L_UDPPORT 6285

/* Use the MCI interface on the Cisco 7507 as the login test host
 * This is the nearest interface we can reach with a TCP packet
 * to an unused port without being blocked by a RR firewall
 */
#define TESTHOST "166.48.172.14"
#define TESTPORT 8080

#define	DHCPFILE1 "/etc/dhcpc/resolv.conf"
#define DHCPFILE2 "/etc/resolv.conf"
#define PIDFILE	"/var/tmp/rrlogin.pid"

/* Sleep interval, in seconds, before retrying a failing operation */
#define	RETRY	300

int rdmsg(FILE *fp,char *buffer,int size);
void sndmsg(int s,char *buffer);
int Verbose = 0;
int Debug = 0;

int
main(int argc,char *argv[])
{
  int udp_s,tcp_s,r,lsize,c;
  char logname[10],password[10];
  struct sockaddr_in tas_tcp,tas_udp,local,server;
  char wbuffer[512];
  char rbuffer[100],*cp;
  char *authhost = NULL;
  char *testhost = TESTHOST;
  struct hostent *hp;
  FILE *fp,*net;
  extern char *optarg;
  extern int optind;
  /* The default timeout should probably be bigger, now that the
   * TAS timeout is 32760 minutes. But we don't want to make it too
   * long, as that delays detection of a TAS reboot during which time we're
   * off the air.
   */
  int timeout = 1000;
  time_t t;
  enum { down, up} state = down;

  server.sin_addr.s_addr = 0;
  while((c = getopt(argc,argv,"t:h:dvp:")) != EOF){
    switch(c){
    case 't':
      timeout = atoi(optarg);
      break;
    case 'h':
      authhost = optarg;
      break;
    case 'v':			
      Verbose++;
      break;
    case 'd':
      Debug++;
      break;
    case 'p': /* test server, for testing login state */
      testhost = optarg;
      break;
    }
  }
  /* If login name and/or password were not given on the command
   * line, prompt for them here
   */
  if(argc <= optind){
    printf("Enter roadrunner login name: ");
    fgets(logname,sizeof(logname),stdin);
  } else {
    strcpy(logname,argv[optind]);
    memset(argv[optind],0,strlen(argv[optind]));
  }
  if((cp = strchr(logname,'\n')) != NULL)
    *cp = '\0';

  if(argc <= optind+1){
    printf("Enter password: ");
    fgets(password,sizeof(password),stdin);
  } else {
    strcpy(password,argv[optind+1]);
    memset(argv[optind+1],0,strlen(argv[optind+1]));
  }
  if((cp = strchr(password,'\n')) != NULL)
    *cp = '\0';

  /* If the -h option is not used to manually specify the TAS, we look
   * for /etc/dhcpc/resolv.conf or /etc/resolv.conf, in that order,
   * extract the line specifying the nameserver and assume it is also
   * the TAS.

   * Although /etc/resolv.conf is often a symbolic link to
   * /etc/dhcpc/resolv.conf, we don't just look at /etc/resolv.conf
   * because it is the standard config file read by the resolver
   * library routines, e.g., gethostbyname(). If the local
   * administrator has chosen not to use the RR nameserver, e.g. if
   * the system runs its own nameserver, these will be separate files.
   * /etc/resolv.conf will contain the local configuration while
   * /etc/dhcpc/resolv.conf gives the RR nameserver given by
   * DHCP. We want the latter.

   * While /etc/resolv.conf is pretty much standard on all UNIX-like
   * systems, /etc/dhcpc/resolv.conf is not. Falling back to
   * /etc/resolv.conf does run the risk of getting the wrong TAS
   * address if another DHCP client is used *and* a local nameserver
   * has been configured in /etc/resolv.conf. It's hard to know if
   * there's a better solution than to just use the -h option, though.  */
  if(authhost == NULL){
    if((fp = fopen(DHCPFILE1,"r")) != NULL || (fp = fopen(DHCPFILE2,"r")) != NULL){
      char buf[512];

      while(fgets(buf,sizeof(buf),fp) != NULL){
	if((cp = strchr(buf,'\n')) != NULL)
	  *cp = '\0';
	if(strncmp(buf,"nameserver",strlen("nameserver")) == 0){
	  cp = buf+strlen("nameserver");
	  while(*cp == ' ' || *cp == '\t')
	    cp++;
	  authhost = strdup(cp);
	  break;
	}
      }
      fclose(fp);
    }
  }
  if(Debug){
    printf("TAS IP addr: %s\n",authhost);
  }
  if(authhost == NULL){
    perror("Cannot determine TAS address, try specifying it manually with -h");
    exit(0);
  }
  /* Open TCP connection to authentication server on TAS */
  tas_tcp.sin_family = AF_INET;
  inet_aton(authhost,&tas_tcp.sin_addr);
  tas_tcp.sin_port = htons(TCPPORT);

  if(tas_tcp.sin_addr.s_addr == INADDR_LOOPBACK){
    perror("Invalid TAS IP address, try specifying it manually with -h");
    exit(0);
  }

  /* If not running in foreground debug mode, fork off a child
   * and have the parent immediately exit (this is standard
   * practice for UNIX system daemons)
   */
  if(!Debug && fork() != 0)
    exit(0);

  signal(SIGHUP,SIG_IGN);
  signal(SIGPIPE,SIG_IGN);
  openlog("rrlogin",LOG_PID,LOG_DAEMON);
  if((fp = fopen(PIDFILE,"w")) != NULL){
    fprintf(fp,"%d\n",getpid());
    fclose(fp);
  }
 retry:;
  if((tcp_s = socket(AF_INET,SOCK_STREAM,IPPROTO_TCP)) == -1){
    syslog(LOG_ERR,"TCP socket call failed: %m");
    if(Debug)
      perror("TCP socket call failed");
    sleep(RETRY);
    goto retry;
  }
  if(connect(tcp_s,(void *)&tas_tcp,sizeof(tas_tcp)) == -1){
    syslog(LOG_ERR,"TCP connect to TAS failed: %m");
    if(Debug)
      perror("TCP connect to TAS failed");
    close(tcp_s);
    sleep(RETRY);
    goto retry;
  }
  lsize = sizeof(local);
  getsockname(tcp_s,(struct sockaddr *)&local,&lsize);
  /* Send TCP login sequence */
  sprintf(wbuffer,"01,01,0000,00000065,%-8s,%-8s,%-16s,%-8s,",
	  logname,password,inet_ntoa(local.sin_addr),"WIN-95");
  if(Debug)
    printf("sending TCP login msg...\n");
  sndmsg(tcp_s,wbuffer);

  net = fdopen(tcp_s,"r+");	/* Use stdio for receive */

  rdmsg(net,rbuffer,sizeof(rbuffer));

  sprintf(wbuffer,"02,03,0000,00000075,Linux   ,0 ,");

  sndmsg(tcp_s,wbuffer);

  rdmsg(net,rbuffer,sizeof(rbuffer));

  sprintf(wbuffer,"03,02,0000,00000021,");
  sndmsg(tcp_s,wbuffer);

  rdmsg(net,rbuffer,sizeof(rbuffer));

  fclose(net);	/* Done with the TCP connection */

  /* Using DNS should be OK now */
  if(server.sin_addr.s_addr == 0){	 /* Do it only once */
    if((hp = gethostbyname(testhost)) == NULL){
      syslog(LOG_ERR,"Can't resolve server host: %m");
      if(Debug)
	herror("Can't resolve server host");
      sleep(RETRY);
      goto retry;
    }
    server.sin_family = AF_INET;
    server.sin_port = htons(TESTPORT);
    memcpy(&server.sin_addr.s_addr,hp->h_addr_list[0],4);
    if(Debug)
      printf("server host: %s (%s)\n",testhost,
	     inet_ntoa(server.sin_addr));
  }

  /* Create UDP socket for keepalive messages */
  if((udp_s = socket(AF_INET,SOCK_DGRAM,IPPROTO_UDP)) == -1){
    syslog(LOG_ERR,"UDP socket call failed: %m");
    if(Debug)
      perror("UDP socket call failed");
    sleep(RETRY);
    goto retry;
  }
  local.sin_family = AF_INET;
  local.sin_port = htons(L_UDPPORT);
  /* local.sin_addr.s_addr still set from earlier getsockname() */
  bind(udp_s,(void *)&local,sizeof(local));

  tas_udp.sin_family = AF_INET;
  tas_udp.sin_port = htons(UDPPORT);
  inet_aton(authhost,&tas_udp.sin_addr);
  if(connect(udp_s,(void *)&tas_udp,sizeof(tas_udp)) == -1){
    syslog(LOG_ERR,"UDP connect to TAS failed: %m");
    if(Debug)
      perror("UDP connect to TAS failed");
    close(udp_s);
    sleep(RETRY);
    goto retry;
  }

  /* Send keepalives forever */
  for(;;){
    sprintf(wbuffer,"99,03,0000,00000038,%-16s,",
	    inet_ntoa(local.sin_addr));
    sndmsg(udp_s,wbuffer);

    /* Connect to head end server to verify
     * that we're still logged in
     */
    if((tcp_s = socket(AF_INET,SOCK_STREAM,IPPROTO_TCP)) == -1){
      close(udp_s);
      syslog(LOG_ERR,"TCP socket call failed: %m");
      if(Debug)
	perror("TCP socket call failed");
      sleep(RETRY);
      goto retry;
    }
    r = connect(tcp_s,(void *)&server,sizeof(server));
    close(tcp_s);
    if(r == -1 && errno != ECONNREFUSED){
      if(Debug){
	time(&t);
	printf("server test failed at %s\n",ctime(&t));
	perror("server connect");
      }
      if(state == up){
	state = down;
	syslog(LOG_INFO,"RR connection down");
      }
      close(udp_s);
      sleep(RETRY);
      goto retry;
    }
    if(Debug){
      time(&t);
      printf("server check OK at %s",ctime(&t));
    }

    /* Either the connect succeeded, or the server
     * refused it. Either way we know we're reaching it
     */
    if(state == down){
      state = up;
      syslog(LOG_INFO,"RR connection up");
    }
    sleep(timeout);
  }
}
/* Read a message from the stream, terminating after a null has been
 * transferred or when the size of the buffer has been reached
 */
int
rdmsg(FILE *fp,char *buffer,int size)
{
  char *cp;
  int count = 0;
  int c;

  cp = buffer;
  while((c = getc(fp)) != EOF && count < size){
    *cp++ = c;
    if(c == '\0')
      break;
  }
  if(Debug)
    printf("rx: %s\n",buffer);

  return count;
}
void
sndmsg(int s,char *buffer)
{
  if(Debug)
    printf("tx: %s\n",buffer);
  write(s,buffer,strlen(buffer)+1);
}

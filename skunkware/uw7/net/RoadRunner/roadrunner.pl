#!/usr/local/bin/perl 

#####
# Perl 5 RoadRunner UNIX login code
#	By Mark Trostler adapted from Phil Karn's C code
#	4/2/97
#
#	Revised 8/13/97 to send non-outdating commands ('Linux')
#		And got rid of keepalives...
#
#	Command line options:
#	-v = Verbose mode - Highly Recommended!
#	-p <Proxy Host IP address>
#	-t <timeout value> - Just leave it at 30 seconds which is 
#		the default
#	-h <Login Host IP address>
#	-l = Logout First - always a good idea!
#
#	Once you know these numbers I would hard-code them so you
#	don't need to type any command line options...
#	Check out lines 82 and 83.
#
#	You will be prompted for your login and password - which I'd
#	also hard code on lines 121 & 122.
#	
#	Enjoy!
####

###
# Maybe this isn't necessary - but ya need 5.0 at least for sure...
###
require 5.003;

###
# Get all the good Socket stuff
###
use Socket;

###
# For command line
###
use Getopt::Std;

###
# Get some cool FileHandle methods
#	autoflush being the best...
#	Better than stupid $|...
###
use FileHandle;

###
# Unbuffer STDOUT
###
STDOUT->autoflush(1);

###
# Send logout message
#	(Also use as a signal handler to logout via Ctrl-C)
###
sub logout {

	my($signal) = @_;

	if ($myip)
	{
		$wbuffer = sprintf("00,01,0000,00000038,%-16s,",$myip);
		print "Sending UDP logout message: $wbuffer\n" if ($DEBUG);
		&send_off(\*UDP_S,$wbuffer);
		sleep 3;
	}

	if ($signal)
	{
		print "Caught Ctrl-C: Logged Out at ".scalar(localtime)."\n"; 
		exit;
	}
}

##
# Catch Ctrl-C
##
$SIG{'INT'} = \&logout;

###
# My AUTHHOST and PROXYHOST for PB/MB area
#	Yours are different!!
###
$authhost = "204.210.7.5";
$proxyhost = "204.210.0.21";
$proxyport = 8080;
###
# Time between sending keepalives
###
$timeout = 32768;

####
# TCP we gotta connect to
####
$TCPPORT = 7283;

###
# UDP Port for keepalives on remote machine
###
$UDPPORT = 6284;

###
# Local port for UDP keepalives
###
$L_UDPPORT = 6285;


###
# Let's pretend we're Windows...
###
$os = "WIN-95";
$exec = "rrie95.exe";
$version = "1.0.0.1";

####
# My login and password
#	You should hard-code 'em here for quick access
#	if ya like...  If these have values you won't be prompted for 'em.
####
$login = "";
$password = "";

###
# Parse command line arguments
###
getopts('t:h:vp:l');
$DEBUG = 1 if ($opt_v);
$proxyhost = $opt_p if ($opt_p);
$timeout = $opt_t if ($opt_t);
$authhost = $opt_h if ($opt_h);

if (!$login)
{
	print "What's your login: ";
	$login = <STDIN>;
	chomp $login;
}

if (!$password)
{
	print "What's your password: ";
	$password = <STDIN>;
	chomp $password;
}

####
# Resolve authhost - which shouldn't be too difficult 
#	'cuz it's already an IP address!!
###
if (!($hp = gethostbyname($authhost)))
{
	###
	# If ya see this there's real problems
	#	because $authhost is already an IP address!!
	###
	die "Couldn't resolve $authhost!";
}

print "Authhost = $authhost is ".inet_ntoa($hp)."\n" if ($DEBUG);

RETRY: {
####
# Now create TCP socket to authhost
###
if (!socket(TCP_S,PF_INET,SOCK_STREAM,getprotobyname('tcp')))
{
	die "Couldn't create TCP socket!";
}
###
# And unbuffer that bad-boy
###
TCP_S->autoflush(1);

###
# Create the 'sockaddr_in' structures for 'connect'
#	for both the TCP and UDP connexion
###
$p_server = sockaddr_in($TCPPORT,$hp);	# $hp is resolved $authhost
$u_server = sockaddr_in($UDPPORT,$hp);	# which is just $authhost!

print "Going to connect...\n" if ($DEBUG);

if (!connect(TCP_S,$p_server))
{
	die "$!: Couldn't connect to authhost!";
}

print "TCP connexion to $authhost established!\n" if ($DEBUG);

###
# Figure out who the heck I am
#	If ya used DHCP this got assigned automagically
#	Else it's just hard-coded by 'ifconfig'
###
$p_local = getsockname(TCP_S);
($l_port, $iaddr) = unpack_sockaddr_in($p_local);
$myip = inet_ntoa($iaddr);

print "My IP address is $myip\n" if ($DEBUG);

###
# Now make a UDP socket for the keepalives
###
if (!socket(UDP_S,PF_INET,SOCK_DGRAM,getprotobyname('udp')))
{
	die "Couldn't make UDP socket!";
}

###
# And unbuffer that bad boy
###
UDP_S->autoflush(1);

###
# First bind to the local port
###
my $local_UDP_port = sockaddr_in($L_UDPPORT,INADDR_ANY);
if (!bind(UDP_S,$local_UDP_port))
{
	die "Couldn't bind to local UDP port $L_UDPPORT!";
}

###
# Now connect to remote UDP_S port on $authhost
###
if (!connect(UDP_S,$u_server))
{
	die "Couldn't make a UDP connexion to Server!";
}

print "UDP Connexion made to $authhost for keepalives!\n" if ($DEBUG);

###
# If we need to logoff first...
###
&logout if ($opt_l);
	
###
# Now for the interesting stuff
# 	Send TCP login sequence
###
print "Sending TCP login sequence\n" if ($DEBUG);

$wbuffer = sprintf("01,01,0000,00000065,%-8s,%-8s,%-16s,%-8s,",$login,$password,$myip,$os);
&send_off(\*TCP_S,$wbuffer);

###
# Suck in everything...
###
&suck_in(\*TCP_S);

###
# Make sure we got a valid response back
#	$in_buffer is a global variable that
#	'suck_in' fills...
#	If this first response doesn't contain your login
#	name then something went wrong...
###
if ($in_buffer !~ /$login/)
{
	print "Couldn't connect OR bad Username/Password\n";
	print "Try again!\n";
	exit;
}

###
# Send next string
###
#$wbuffer = sprintf("02,03,0000,00000075,%-8s,1 ,%-32s,%-8s,",$os,$exec,$version);
#$wbuffer = sprintf("02,03,0000,00000201,WIN-95  ,4 ,rrie95.exe                      ,1.0.0.2 ,login.new                       ,1.2.0.0 ,readme.txt                      ,1.2.0.0 ,modini.exe                      ,1.0.0.1 ,");
#$wbuffer = sprintf("02,03,0000,00000201,WIN-95  ,4 ,modini.exe                      ,1.0.0.2 ,rrie95.exe                      ,1.0.0.2 ,readme.txt                      ,1.2.0.0 ,login.new                       ,1.2.0.0 ,");
$wbuffer = sprintf("02,03,0000,00000201,WIN-95  ,4 ,modini.exe                      ,1.0.0.3 ,rrie95.exe                      ,1.0.0.2 ,readme.txt                      ,1.3.0.0 ,login.new                       ,1.3.0.0 ,");
$wbuffer = sprintf("02,03,0000,00000075,Linux   ,0 ,");
&send_off(\*TCP_S,$wbuffer);

###
# Suck in everything...
###
&suck_in(\*TCP_S);

####
# Send last string
####
$wbuffer = sprintf("03,02,0000,00000021,");
&send_off(\*TCP_S,$wbuffer);

###
# Suck in everything...
###
&suck_in(\*TCP_S);

###
# Done w/TCP...
###
close(TCP_S);

print "You are connected!\nCtrl-C to quit.\n";
###
# Now keep sending keepalives...
###
while(1)
{
	#
	# Don't need these anymore...
	#
	#$wbuffer = sprintf("99,03,0000,00000038,%-16s,",$myip);
	#&send_off(\*UDP_S,$wbuffer);
	sleep($timeout);

	###
	# Connect to proxy-server to make sure we're still good...
	###
	if (!socket(TCP_S,PF_INET,SOCK_STREAM,getprotobyname('tcp')))
	{
		die "Couldn't create TCP socket for Proxy Host check!";
	}

	$hp = gethostbyname($proxyhost);
	$k_server = sockaddr_in($proxyport,$hp);	
	if (!connect(TCP_S,$k_server))
	{
		print "Proxy text failed!\n" if ($DEBUG);
		close(TCP_S);
		close(UDP_S);
		redo RETRY;
	}
	else
	{
		print "Proxy check OK\n" if ($DEBUG);
		close(TCP_S);
	}
}

} #End RETRY


###
# Ship off string to a handle...
###
sub send_off {
	my($fh,$string) = @_;

	print "tx: $string\n" if ($DEBUG);

	$string .= "\0";	#NULL terminate that bad boy
	if (length($string) != syswrite($fh,$string,length($string)))
	{
		die "This is Bad: $!\n";
	}

}

###
# Read in up to 256 bytes from a handle...
###
sub suck_in {
	my($fh,$bytes) = @_;
		
	$bytes = sysread($fh,$in_buffer,256);

	print "rx: $in_buffer\n" if ($DEBUG);
}

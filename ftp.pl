#!/usr/bin/perl -w
use strict;
use WWW::Mechanize;
use WWW::Mechanize::FormFiller;
use URI::URL;
use Net::FTP;
use Getopt::Long;


#				 dumprequests =>1,
#				 dumpresponses => 1,
#				 verbose  =>1				 
my $pass=$ENV{ARCHIVE_ORG_PWD};
my $user=$ENV{ARCHIVE_ORG_UID};

my $newid;

my $host="items-uploads.archive.org";
my $file; ## file to upload
my $result = GetOptions ("user=s" => \$user,
		      "id=s" => \$newid,
		      "file=s" => \$file,
		      "pass=s" => \$pass); # flag

my $ftp = Net::FTP->new($host, Debug => 1)
 or die "Cannot connect to $host: $@";

$ftp->login("$user",$pass)
 or die "Cannot login ", $ftp->message;

print join ("\n",$ftp->ls()) . "\n";

$ftp->cwd("$newid")
 or die "Cannot change working directory $newid ", $ftp->message;

print join ("\n",$ftp->ls()) . "\n";

if ($file)
{
    warn "going to put the file";
    $ftp->put("$file") 
	or die "get failed ", $ftp->message;
}
print join ("\n",$ftp->ls()) . "\n";

 $ftp->quit;

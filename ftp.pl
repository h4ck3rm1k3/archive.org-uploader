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
my $pass='Udroth3i';
my $user='jamesmikedupont@googlemail.com';
my $newid;

my $host="items-uploads.archive.org";

my $result = GetOptions ("user=s" => \$user,
		      "id=s" => \$newid,
		      "pass=s" => \$pass); # flag

my $ftp = Net::FTP->new($host, Debug => 1)
 or die "Cannot connect to $host: $@";

$ftp->login("$user",$pass)
 or die "Cannot login ", $ftp->message;

print join ("\n",$ftp->ls()) . "\n";

$ftp->cwd("$newid")
 or die "Cannot change working directory $newid ", $ftp->message;

print join ("\n",$ftp->ls()) . "\n";
# $ftp->get("that.file")
# or die "get failed ", $ftp->message;

 $ftp->quit;

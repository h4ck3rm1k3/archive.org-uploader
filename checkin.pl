#!/usr/bin/perl -w
use strict;
use WWW::Mechanize;
use WWW::Mechanize::FormFiller;
use URI::URL;
use Getopt::Long;

my $agent = WWW::Mechanize->new( autocheck => 1 ,
    );
$agent->quiet(1); # turns off warnings
my $pass=$ENV{ARCHIVE_ORG_PWD};
my $user=$ENV{ARCHIVE_ORG_UID};


my $newid;

my $result = GetOptions ("user=s" => \$user,
		      "id=s" => \$newid,
		      "pass=s" => \$pass); # flag

my $formfiller = WWW::Mechanize::FormFiller->new();
$agent->env_proxy();
$agent->get('http://www.archive.org/account/login.php');
$agent->submit_form(
         form_number => 2,
    fields      => { 
	username => $user,
	password => $pass 
    },
    button => "submit"
    );
die unless ($agent->success);
$agent->save_content( "out_04_loginforchecking.html" );
## now we go to checking
my $uri="http://www.archive.org/checkin/$newid";
warn "getting $uri";
$agent->get($uri);
$agent->save_content( "out_04_checkin.html" );
$agent->dump_all( );

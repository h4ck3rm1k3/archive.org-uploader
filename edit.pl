#!/usr/bin/perl -w
use strict;
use WWW::Mechanize;
use WWW::Mechanize::FormFiller;
use URI::URL;
use Getopt::Long;

my $agent = WWW::Mechanize->new( autocheck => 1 ,
    );
$agent->quiet(1); # turns off warnings
my $pass='Udroth3i';
my $user='jamesmikedupont@googlemail.com';
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
## now we go to upload
my $uri="http://www.archive.org/edit/$newid";

#http://ia360700.us.archive.org/edit.php?identifier=archive_org_uploader_v001
warn "getting $uri";
$agent->get($uri);

$agent->save_content( "out_05_edit.html" );
$agent->follow_link('text' => 'change the files');

$agent->save_content( "out_051_edit2.html" );
$agent->dump_all( );

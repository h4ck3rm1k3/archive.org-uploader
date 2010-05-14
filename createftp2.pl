#!/usr/bin/perl -w
use strict;
use WWW::Mechanize;
use WWW::Mechanize::FormFiller;
use URI::URL;

use Getopt::Long;

 #!/usr/bin/perl -w
  use strict;
  use WWW::Mechanize::Shell;

my $agent = WWW::Mechanize::Shell->new("shell");




#my $agent = WWW::Mechanize->new( autocheck => 1 ,
#    );

#    $agent->quiet(1); # turns off warnings

#				 dumprequests =>1,
#				 dumpresponses => 1,
#				 verbose  =>1				 
my $pass='Udroth3i';
my $user='jamesmikedupont@googlemail.com';
my $newid;


my $result = GetOptions ("user=s" => \$user,
		      "id=s" => \$newid,
		      "pass=s" => \$pass); # flag

#my $formfiller = WWW::Mechanize::FormFiller->new();
#$agent->env_proxy();

$agent->{agent}->get('http://www.archive.org/account/login.php');
#   $agent->form_number(2) if $agent->forms and scalar @{$agent->forms};
#  { local $^W; $agent->current_form->value('username', $user); };
#  { local $^W; $agent->current_form->value('password', $pass); };
#  $agent->submit();
#  $agent->get('http://www.archive.org/catalog.php?history=1&justme=1');

$agent->{agent}->submit_form(
         form_number => 2,
    fields      => { 
	username => $user,
	password => $pass 
    },
    button => "submit"
    );
die unless ($agent->{agent}->success);

$agent->{agent}->save_content( "out_00_login.html" );


## now we go to upload

$agent->{agent}->get("http://www.archive.org/create.php?ftp=1");
$agent->{agent}->save_content( "out_01_create.html" );

$agent->cmdloop;

# #GET http://www.archive.org/create.php
# #  ftp=1                          (hidden readonly)
# #  identifier=                    (text)
# #  <NONAME>=Create item!          (submit)
# warn "identifier is $newid\n";
# $agent->submit_form(
#     fields      => { 
# 	ftp=>1,
# 	identifier => $newid
#     },
# #    button => "Create item!",
#     );
# die "failed $agent" unless ($agent->success);

# $agent->dump_all( );

# $agent->save_content( "out_02_ftpupload.html" );

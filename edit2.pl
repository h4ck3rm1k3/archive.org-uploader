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
my $pass='';
my $user='jamesmikedupont@googlemail.com';
my $newid;


my $result = GetOptions ("user=s" => \$user,
		      "id=s" => \$newid,
		      "pass=s" => \$pass); # flag

$agent->{agent}->get('http://www.archive.org/account/login.php');

warn "logging in";

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
my $uri="http://www.archive.org/edit/$newid";
warn "gettgin $uri";

$agent->{agent}->get($uri);
$agent->{agent}->save_content( "out_05_edit2.html" );

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

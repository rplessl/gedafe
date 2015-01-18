#!/usr/bin/perl5.18.2 -w

BEGIN {
  use Data::Dumper;
}

use lib "/home/gedafe/gedafe/thirdparty/lib/perl5";
use lib "/home/gedafe/gedafe/lib/perl";
use lib "/home/gedafe/gedafe/pearls";

use strict;
use CGI::Fast;
#use CGI::Carp qw(fatalsToBrowser);

use Gedafe::Start;

$|=1; # do not buffer output

while (my $q = new CGI::Fast) {

    Start( 
        $q, # fastcgi handler
        # no host ... we use the local socket
        # but specify socket directory (if not the default)

        db_datasource      => 'dbi:Pg:dbname=demo1',
        utf8               => 1,
        allow_javascript   => 1,
        admin_user         => 'demo1_master',
        templates          => '/home/gedafe/demo1/templates',
        pearl_dir          => '/home/gedafe/demo1/pearls',
        documentation_url  => '/~gedafe/docs',
        gedafe_compat      => '1.1',
        list_rows          => 20,
        list_buttons       => 'top',
    );
}

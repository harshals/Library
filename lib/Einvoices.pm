#
#===============================================================================
#
#         FILE:  Library.pm
#
#  DESCRIPTION:  
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Harshal Shah (Hs), <harshal.shah@gmail.com>
#      COMPANY:  MK Software
#      VERSION:  1.0
#      CREATED:  01/27/2011 19:16:57 IST
#     REVISION:  ---
#===============================================================================

package Einvoices;
use strict;
use warnings;


use Dancer ':syntax';

use App::Base;
use App::Base::Admin::Login;
use App::Base::Admin::Init;

my $schema = '';
my $user = '';
my $application = '';

my $my_schemas = {};
my $users = {};

get '/' => sub {

    template 'index';
};


get '/einvoices' => sub {
	
	return "Hello from App called Einvoices";
};
1;


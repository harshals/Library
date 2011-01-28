#
#===============================================================================
#
#         FILE:  Einvoices.pm
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

use App;
use App::Admin::Login;
use App::Admin::Init;

get '/' => sub {

	debug "From Einvoices";
    template 'index';
};


get '/einvoices' => sub {
	
	return "Hello from App called Einvoices ";
};

1;


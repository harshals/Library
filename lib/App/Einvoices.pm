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

load_app 'App';

get '/' => sub {

	debug "From Einvoices";
    template 'index';
};


get '/route1' => sub {
	
	return "Hello from App called Einvoices ";
};

1;


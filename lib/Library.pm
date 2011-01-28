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

package Library;
use strict;
use warnings;


use Dancer ':syntax';

use App;
use App::Admin::Login;
use App::Admin::Init;

get '/' => sub {
	
	debug "From Library";
    template 'index';
};


get '/library' => sub {
	
	return "Hello from App called Library ";
};
get '/einvoices' => sub {
	
	return "still from App called Library ";
};


1;


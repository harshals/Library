#
#===============================================================================
#
#         FILE:  App2.pm
#
#  DESCRIPTION:  
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Harshal Shah (Hs), <harshal.shah@gmail.com>
#      COMPANY:  MK Software
#      VERSION:  1.0
#      CREATED:  01/29/2011 18:37:35 IST
#     REVISION:  ---
#===============================================================================

package App2;
use strict;
use warnings;

use parent 'Dancer';
use Dancer ':syntax';

#setting 'apphandler' => "PSGI";
get '/' => sub {

	return "Hello from App2";
};
get '/app1' => sub {
	
	return "Route app1 called from App2";
};
get '/app2' => sub {
	
	return "Route app2 called from App2";
};
1;



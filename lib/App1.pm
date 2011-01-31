#
#===============================================================================
#
#         FILE:  App1.pm
#
#  DESCRIPTION:  
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Harshal Shah (Hs), <harshal.shah@gmail.com>
#      COMPANY:  MK Software
#      VERSION:  1.0
#      CREATED:  01/29/2011 18:36:04 IST
#     REVISION:  ---
#===============================================================================


package App1;
use strict;
use warnings;

use parent 'Dancer';
use Dancer ':syntax';

#setting 'apphandler' => "PSGI";
get '/' => sub {

	return "Hello from App1";
};


get '/app1' => sub {
	
	return "Route app1 called from App1";
};
get '/app2' => sub {
	
	return "Route app2 called from App1";
};


1;


#
#===============================================================================
#
#         FILE:  User1App.pm
#
#  DESCRIPTION:  
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Harshal Shah (Hs), <harshal.shah@gmail.com>
#      COMPANY:  MK Software
#      VERSION:  1.0
#      CREATED:  01/25/2011 16:15:54 IST
#     REVISION:  ---
#===============================================================================
package User1App;
use strict;
use warnings;

use Dancer ':syntax';

get '/api/user1' => sub {

	return { 'data' => 'I am User 1 route' };
};

1;

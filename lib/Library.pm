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


prefix '/a/1';

before sub {
	
	&App::authenticate(1);
};

get '/' => sub {
	
	debug "From Library";
    template 'index';
};


get '/route1' => sub {
	
	return "Hello from App called Library ";
};
get '/route2' => sub {
	
	return "still from App called Library ";
};


1;


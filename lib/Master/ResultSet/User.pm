package Master::ResultSet::User;

use strict;
use warnings;
use Moose;
use namespace::clean -except => 'meta';
use Carp;

extends qw/DBICx::Hybrid::ResultSet/;

sub authenticate {
	
	my $self = shift;
	
	my $params = shift;
	
	my $search_rs = $self->search_rs( { username => $params->{'username'} || $params->{'email'} , 
										password => $params->{'password'} || $params->{'pass'} });

	if($search_rs->count){

		return $search_rs->first;
	}else {
		return 0;
	}

}	


1;

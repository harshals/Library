package DB::Library::ResultSet::Book;

use strict;
use warnings;
use Moose;
use namespace::clean -except => 'meta';
use Carp;

extends qw/DB::Schema::ResultSet::Book/;

sub filter_by {
	
	my $self = shift;
	my $category = shift;

	return $self;
};


1;

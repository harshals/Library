package DB::Einvoices::ResultSet::Book;

use strict;
use warnings;
use Moose;
use namespace::clean -except => 'meta';
use Carp;

extends qw/DB::Schema::ResultSet::Book/;

sub crap_by {
	
	my $self = shift;
	my $category = shift;

	return $self;
};


1;

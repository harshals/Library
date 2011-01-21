package Schema::ResultSet::Book;

use strict;
use warnings;
use Moose;
use namespace::clean -except => 'meta';
use Carp;

extends qw/DBICx::Hybrid::ResultSet/;

override 'prefetch_related' => sub {

    my $self = shift;
	my $relationships = shift || [  'category' , { author_books=> 'author' }];

	croak "relatonships need to be an array ref " unless ref $relationships eq 'ARRAY';

	return $self->search_rs(undef, { prefetch =>   $relationships ,
									
									#include_columns => [qw/category.category author.first_name/],
	} );
};

around 'look_for' => sub {

	my $orig = shift;
	my $self = shift;

	my $params = shift;
	my $search  = shift;

	## my search parameters are title, publish_date, price and classification
	
	
	$search->{'publish_date'} = { '<=' , $params->{'to_date'} };
	$search->{'publish_date'} = { '>=' , $params->{'from_date'} };

	

	$self->$orig($search);
	
};

sub for_category {
	
	my $self = shift;
	my $category_id = shift;

	return $self->look_for( { category_id => $category_id});
}


1;

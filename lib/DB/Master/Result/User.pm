#
#===============================================================================
#
#         FILE:  User.pm
#
#  DESCRIPTION:  User Schema Result source
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Harshal Shah (Hs), <harshal.shah@gmail.com>
#      COMPANY:  MK Software
#      VERSION:  1.0
#      CREATED:  01/26/2011 11:50:46 IST
#     REVISION:  ---
#===============================================================================

package DB::Master::Result::User;

use strict;
use warnings;

use Moose;
use namespace::clean -except => 'meta';
extends qw/DBICx::Hybrid::Result/;

__PACKAGE__->table("user");
__PACKAGE__->add_columns(

		"username", { data_type => "VARCHAR(200)", is_nullable => 0 },
		"password", { data_type => "VARCHAR(200)", is_nullable => 0 },
		"application_id", { data_type => "INTEGER", is_nullable => 0 },
		"profile_id", { data_type => "INTEGER", is_nullable => 0 },
);

__PACKAGE__->add_base_columns;

__PACKAGE__->set_primary_key("id");


__PACKAGE__->belongs_to(
  "application",
  "DB::Master::Result::Application",
  { "foreign.id" => "self.application_id" },
);


## Force Array return
# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-08-13 21:11:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:obZUGgvkve3e6mzPk8GEEg

sub extra_columns {
    
    my $self = shift;

    return qw/notes/;
};

sub my_relations {

    my $self = shift;
	return qw/application /;
}

sub collegues {

	my $self = shift;

	my $params = shift;
	my $search  = {};

	## my search parameters are title, publish_date, price and classification
	
	$self->application->users;

};


# You can replace this text with custom content, and it will be preserved on regeneration


__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;

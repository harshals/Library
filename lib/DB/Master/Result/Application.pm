#
#===============================================================================
#
#         FILE:  Application.pm
#
#  DESCRIPTION:  Application Schema Result source
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

package DB::Master::Result::Application;

use strict;
use warnings;

use Moose;
use namespace::clean -except => 'meta';
extends qw/DBICx::Hybrid::Result/;

__PACKAGE__->table("application");
__PACKAGE__->add_columns(

		"name", { data_type => "VARCHAR(200)", is_nullable => 0 },
		"admin_id", { data_type => "INTEGER", is_nullable => 0 },
		"expiry", { data_type => "DATETIME", is_nullable => 0 },
		"schema_class", { data_type => "VARCHAR(200)", is_nullable => 0 },
		"db_name", { data_type => "VARCHAR(200)", is_nullable => 0 },
		"revision", { data_type => "VARCHAR(200)", is_nullable => 0 },
		"app_class", { data_type => "VARCHAR(200)", is_nullable => 0 },
);

__PACKAGE__->add_base_columns;

__PACKAGE__->set_primary_key("id");

__PACKAGE__->has_many(
  "users",
  "DB::Master::Result::User",
  { "foreign.application_id" => "self.id" },
);


## Force Array return
__PACKAGE__->has_one(
	"admin",
	"DB::Master::Result::User",
	{ "foreign.id" => "self.admin_id" }
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-08-13 21:11:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:obZUGgvkve3e6mzPk8GEEg

sub extra_columns {
    
    my $self = shift;

    return qw/db_user db_pass host port driver description/;
};

sub my_relations {

    my $self = shift;
	return qw/users/;
}

# You can replace this text with custom content, and it will be preserved on regeneration


__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;

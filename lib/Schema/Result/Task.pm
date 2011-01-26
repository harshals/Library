#
#===============================================================================
#
#         FILE:  Task.pm
#
#  DESCRIPTION:  Contact Schema Result source
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

package Schema::Result::Task;

use strict;
use warnings;

use Moose;
use namespace::clean -except => 'meta';
extends qw/DBICx::Hybrid::Result/;

__PACKAGE__->table("task");
__PACKAGE__->add_columns(

		"name", { data_type => "VARCHAR(200)", is_nullable => 0 },
		"assigned_by", { data_type => "INTEGER", is_nullable => 0 },
		"assigned_to", { data_type => "INTEGER", is_nullable => 0 },
		"place", { data_type => "VARCHAR(200)", is_nullable => 0 },
		"due_date", { data_type => "DATETIME", is_nullable => 0 },
		"category", { data_type => "VARCAHR(200)", is_nullable => 0 },
);

__PACKAGE__->add_base_columns;

__PACKAGE__->set_primary_key("id");

__PACKAGE__->belongs_to(
  "owner",
  "Schema::Result::Contact",
  { "foreign.id" => "self.assigned_to" },
);

__PACKAGE__->belongs_to(
  "created_by",
  "Schema::Result::Contact",
  { "foreign.id" => "self.assigned_by" },
);



## Force Array return

# Created by DBIx::Class::Schema::Loader v0.04006 @ 2009-08-13 21:11:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:obZUGgvkve3e6mzPk8GEEg

sub extra_columns {
    
    my $self = shift;

    return qw/notes description attachment tag_1 tag_2 tag_3 tag_4 tag_5 tag_6 tag_7 tag_8 tag_9 tag_10/;
};

sub my_relations {

    my $self = shift;
	return qw//;
}

# You can replace this text with custom content, and it will be preserved on regeneration


__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;

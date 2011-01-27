package DB::Library::Result::Book;

use strict;
use warnings;

use Moose;
use namespace::clean -except => 'meta';
extends qw/DB::Schema::Result::Book/;

__PACKAGE__->add_columns(

		"classification", { data_type => "VARCHAR(11)", is_nullable => 0 },
);

__PACKAGE__->resultset_class('DB::Library::ResultSet::Book');


# You can replace this text with custom content, and it will be preserved on regeneration


__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;

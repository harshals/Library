package User2::Result::Book;

use strict;
use warnings;

use Moose;
use namespace::clean -except => 'meta';
extends qw/Schema::Result::Book/;

__PACKAGE__->resultset_class('User2::ResultSet::Book');

# You can replace this text with custom content, and it will be preserved on regeneration


__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;

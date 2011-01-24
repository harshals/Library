package User1;

use strict;
use warnings;
use Dancer;
use Moose;
use namespace::clean -except => 'meta';
extends 'Schema';


__PACKAGE__->load_namespaces(
        result_namespace => 'Result',
        resultset_namespace => 'ResultSet',
        default_resultset_class => '+DBICx::Hybrid::ResultSet');




1;

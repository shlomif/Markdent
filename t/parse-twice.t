use strict;
use warnings;

use Test::More tests => 1;
use Test::Deep;

use File::Slurp qw( read_file );

use lib 't/lib';

use Test::Markdent;

my $markdown = read_file( 't/mdtest-data/Markdown Documentation - Basics.text' );

my $th1 = Markdent::Handler::MinimalTree->new();
my $th2 = Markdent::Handler::MinimalTree->new();

for my $handler ( $th1, $th2 ) {
    my $parser = Markdent::Parser->new( handler => $handler );
    $parser->parse( markdown => $markdown );
}

cmp_deeply(
    tree_from_handler($th1),
    tree_from_handler($th2),
    'make sure we get the same results from parsing the same string twice in a row'
);

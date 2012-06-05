#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Test::Cookbook;

use WebUtils qw(url_to_json);

my $mock = mock_object->new(
	is_success => 1,
	content => '{"hello": "world"}',
);
$mock->install_at('LWP::UserAgent::new');

my $response = url_to_json('http://0:8000/foo/bar');
deep_ok( $response, {hello => 'world'}, 'successfully decoded json' );

$mock->(is_success => 0);
ok( $mock->is_success == 0, 'set failure' );
$response = url_to_json('http://frob.ni.tz');
deep_ok( $response, {}, 'unsuccessful response is empty' );

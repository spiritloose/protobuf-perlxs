#!/usr/bin/perl

use strict;
use warnings;
use lib qw(blib/lib blib/arch/auto/Protobuf/Types);
use Time::HiRes qw(tv_interval gettimeofday);
use Data::Dumper;
use Protobuf::Types;

my $msg1 = Protobuf::Types->new(
    {
	req_double   => 1.01,
	req_float    => 2.06,
	req_int32    => 16777216,
	req_int64    => '123456789012345',
	req_uint32   => 16777217,
	req_uint64   => '123456789012346',
	req_sint32   => -16777217,
	req_sint64   => '-123456789012346',
	req_fixed32  => 16777218,
	req_fixed64  => '123456789012347',
	req_sfixed32 => -16777218,
	req_sfixed64 => '-123456789012347',
	req_bool     => 1,
	req_string   => "Hello, world!",
	req_bytes    => "Byte array",
	req_enum     => Protobuf::Types::Enum::value1,
	req_message  => { t_string => "embedded message" }
    });

my $msg2 = Protobuf::Types->new($msg1->pack);

print Dumper($msg2->to_hashref);

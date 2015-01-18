#!/usr/bin/perl

use strict;
use warnings;
use lib qw(blib/lib blib/arch/auto/Error);
use Error;

foreach (1 .. 10) {
    eval {
	my $error = Error->new({ field3 => 'foo' })->pack;
    };
    print $@ if ($@);
}

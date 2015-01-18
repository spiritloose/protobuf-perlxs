#!/usr/bin/perl

use strict;
use warnings;
use lib qw(blib/lib blib/arch/auto/String/Bytes);
use Time::HiRes qw(tv_interval gettimeofday);
use String::Bytes;

my $start;
my $elapsed;

# Test packing and unpacking of string and byte messages.

print "Messages with string member set:\n";

foreach ( 1 .. 128 ) {
    my $v = 'x' x $_;
    my $p = String::Bytes->new({ v_string => $v })->pack;
    my $l = length($p);
    my $q = String::Bytes->new($p)->v_string;
    my $m = length($q);
    my $n = $v cmp $q;
    printf("%3d: %3d bytes (%s)\n", $_, $l, ($n) ? "no" : "ok");
}

print "\n";

print "Messages with bytes member set:\n";

foreach ( 1 .. 128 ) {
    my $v = 'x' x $_;
    my $p = String::Bytes->new({ v_bytes => $v })->pack;
    my $l = length($p);
    my $q = String::Bytes->new($p)->v_bytes;
    my $m = length($q);
    my $n = $v cmp $q;
    printf("%3d: %3d bytes (%s)\n", $_, $l, ($n) ? "no" : "ok");
}

print "\n";

print "Messages with string and bytes member with embedded NULLs:\n";

my $v = "x\0\0\0\0\0\0\0\0y";
my $p = String::Bytes->new({ v_string => $v, v_bytes => $v })->pack;
my $u = String::Bytes->new($p);

foreach ( 'v_bytes', 'v_string' ) {
    printf("%8s: %s (%d)\n", $_, ($u->$_ eq $v) ? "ok" : "no", length($u->$_));
}

print "\n";

print "Messages with large string and bytes members:\n";

my $s = 'A' x (32 * 1024 * 1024);

$start = [gettimeofday];
my $m = String::Bytes->new({ v_string => $s });
$elapsed = tv_interval($start);

print "$elapsed seconds to construct 32 MB string message\n";

$start = [gettimeofday];
my $n = String::Bytes->new({ v_bytes => $s });
$elapsed = tv_interval($start);

print "$elapsed seconds to construct 32 MB bytes message\n";

$start = [gettimeofday];
my $a = $m->pack;
$elapsed = tv_interval($start);
my $al = length($a);

print "$elapsed seconds to pack 32 MB string message ($al bytes)\n";

$start = [gettimeofday];
my $b = $n->pack;
$elapsed = tv_interval($start);
my $bl = length($b);

print "$elapsed seconds to pack 32 MB bytes message ($bl bytes)\n";

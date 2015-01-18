#!/usr/bin/perl

use strict;
use warnings;
use lib qw(blib/lib blib/arch/auto/Local/Messages);
use Local::Messages;

my $m1 = Local::Messages::One->new({ id1 => 1 });
my $m2 = Local::Messages::Two->new({ id2 => 2 });
my $m3 = Local::Messages::Three->new({ id3 => 3 });

my $p1 = $m1->pack;
my $p2 = $m2->pack;
my $p3 = $m3->pack;

my $n1 = Local::Messages::One->new($p1);
my $n2 = Local::Messages::Two->new($p2);
my $n3 = Local::Messages::Three->new($p3);

my $q1 = $n1->id1;
my $q2 = $n2->id2;
my $q3 = $n3->id3;

print "$q1 $q2 $q3\n";


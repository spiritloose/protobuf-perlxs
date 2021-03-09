#!/usr/bin/perl
use strict;
use warnings;
use blib;

use Data::Dumper;
use Person;

my $p1 = Person->new({ age => 38 });
print "has_age\n" if $p1->has_age;
print "has_birth_year\n" if $p1->has_birth_year;
$p1->set_birth_year(1982);
print "has_age\n" if $p1->has_age;
print "has_birth_year\n" if $p1->has_birth_year;

my $p2 = Person->new($p1->pack);
print "has_age\n" if $p2->has_age;
print "has_birth_year\n" if $p2->has_birth_year;

print Dumper $p2->to_hashref;

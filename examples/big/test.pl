#!/usr/bin/perl

use strict;
use warnings;
use lib qw(blib/lib blib/arch/auto/Big/Message);
use Storable qw(freeze thaw);
use Time::HiRes qw(tv_interval gettimeofday);
use Data::Dumper;
use Big::Message;

my $start;
my $elapsed;

# Build 10 blobs, each 2 MB

my @data = map { 'a' x (1 << 21) } (1 .. 10);

$start = [gettimeofday];
my $message = Big::Message->new({ blob => \@data });
$elapsed = tv_interval($start);

print "$elapsed seconds to set 10 blob fields\n";

$start = [gettimeofday];
my $packed = $message->pack;
my $length = length($packed);
$elapsed = tv_interval($start);

print "$elapsed seconds to pack message of $length bytes\n";

$start = [gettimeofday];
my $unpacked = Big::Message->new($packed);
$elapsed = tv_interval($start);
print "$elapsed seconds to unpack packed message\n";

$start = [gettimeofday];
$packed = freeze({ blob => \@data });
$length = length($packed);
$elapsed = tv_interval($start);

print "$elapsed seconds to freeze message of $length bytes\n";

$start = [gettimeofday];
my $thawed = thaw($packed);
$elapsed = tv_interval($start);
print "$elapsed seconds to thaw frozen hashref\n";

#!/usr/bin/perl

use strict;
use warnings;
use lib qw(blib/lib blib/arch/auto/Apache2/Protobuf/Error);
use Data::Dumper;
use Sys::Hostname;
use Time::HiRes qw(tv_interval gettimeofday);
use Apache2::Protobuf::Error;

test_error(1);
test_error(2);

sub test_error {
    test_error_1(@_);
}

sub test_error_1 {
    test_error_2(@_);
}

sub test_error_2 {
    test_error_3(@_);
}

sub test_error_3 {
    test_error_4(@_);
}

sub test_error_4 {
    test_error_5(@_);
}

sub test_error_5 {
    test_error_6(@_);
}

sub test_error_6 {
    test_error_7(@_);
}

sub test_error_7 {
    test_error_8(@_);
}

sub test_error_8 {
    my $severity = Apache2::Protobuf::Error::Severity::WARN;
    my $message  = 'Here is a warning';

    if ( $_[0] == 1 ) {
	raise_error_1($severity, $message);
    } elsif ( $_[0] == 2 ) {
	raise_error_2($severity, $message);
    }
}

sub raise_error_1 {
    my ($severity, $message) = @_;

    my $now   = [gettimeofday];
    my $error = Apache2::Protobuf::Error->new;

    $error->set_datetime(time());
    $error->set_severity($severity);
    $error->set_message($message);
    $error->set_hostname(hostname());
    $error->set_pid($$);

    # Include full stack trace

    for ( my $i = 0; ; $i++ ) {
	my ($pack, $file, $line) = caller($i);
	if ( $pack ) {
	    my $frame = Apache2::Protobuf::Error::StackFrame->new;

	    $frame->set_file($file);
	    $frame->set_line($line);
	    $error->add_trace($frame);
	} else {
	    last;
	}
    }

    my $packed  = $error->pack;
    my $length  = length($packed);
    my $elapsed = tv_interval($now);

    print "Built/packed error of $length bytes in $elapsed seconds\n";

    print Dumper($error->to_hashref);
}


sub raise_error_2 {
    my ($severity, $message) = @_;

    my $now   = [gettimeofday];
    my $error = Apache2::Protobuf::Error->new({ datetime => time(),
						severity => $severity,
						message  => $message,
						hostname => hostname(),
						pid      => $$ });

    # Include full stack trace

    for ( my $i = 0; ; $i++ ) {
	my ($pack, $file, $line) = caller($i);
	if ( $pack ) {
	    $error->add_trace(Apache2::Protobuf::Error::StackFrame->new
			      ({ file => $file, line => $line }));
	} else {
	    last;
	}
    }

    my $packed  = $error->pack;
    my $length  = length($packed);
    my $elapsed = tv_interval($now);

    print "Built/packed error of $length bytes in $elapsed seconds\n";

    print Dumper($error->to_hashref);
}

#!/usr/bin/perl

# Updated on 01/28/17
# N_Adapters.pl to print out
# Nextera adapter sequences of 
# each clone in a population.

use strict;
use warnings;

# Declare and initialize variables
my $in_file_name = '';
my @AoA = ();
my $line_num = '';
my $i = '';
my $clone = '';
my $barcode_1 = '';
my $barcode_2 = '';
my $rc_barcode_2 = '';
my $out_file_name = '';
my $adapter_one = '';
my $rc_adapter_one = '';
my $adapter_two = '';
my $rc_adapter_two = '';

die "Usage: N_Adapters.pl <in_file_name>\n" if (@ARGV != 1);

# Read the specified setting
$in_file_name = $ARGV[0];

# Open the input file of the bar codes
open(IN, "<$in_file_name") || die(" There is no $in_file_name ");

# Read the file in a while loop, splitting the
# elements, and add an anonymous array to a
# two-dimensional array (@AoA)
@AoA = ();
$line_num = 0;
while(<IN>) {
	push @AoA, [split];
	$line_num++;
}

# Print out the line numbers in the
# input file
print "The number of lines in the input file is $line_num\n";

# Close the input file
close IN;

# Print out the adapter sequences and their 
# reverse complements for each clone
for ($i=1; $i<$line_num; ++$i) {
	$clone = $AoA[$i][0];
	$barcode_1 = $AoA[$i][1];
	$barcode_2 = $AoA[$i][2];
	# print "$clone\t$barcode_1\t$barcode_2\n";
	$out_file_name = $clone;
	$out_file_name .= '_Adapters.fa';
	# Open the output file
	open(OUT, ">$out_file_name") || die("Cannot make $out_file_name");
	print OUT ">$clone\_Adapter1\n";
	# print ">$clone\_Adapter1\n";
	$adapter_one = 'CTGTCTCTTATACACATCTCCGAGCCCACGAGAC';
	$adapter_one .= $barcode_1;
	$adapter_one .= 'ATCTCGTATGCCGTCTTCTGCTTG';
	print OUT "$adapter_one\n";
	# print "$adapter_one\n";
	$rc_adapter_one = reverse $adapter_one;
	$rc_adapter_one =~ tr/ACGTacgt/TGCAtgca/;
	print OUT ">$clone\_Adapter1_rc\n";
	# print ">$clone\_Adapter1_rc\n";
	print OUT "$rc_adapter_one\n";
	# print "$rc_adapter_one\n";
	$adapter_two = 'AATGATACGGCGACCACCGAGATCTACAC';
	$rc_barcode_2 = reverse $barcode_2;
	$rc_barcode_2 =~ tr/ACGTacgt/TGCAtgca/;
	$adapter_two .= $rc_barcode_2;
	$adapter_two .= 'TCGTCGGCAGCGTCAGATGTGTATAAGAGACAG';
	print OUT ">$clone\_Adapter2\n";
	# print ">$clone\_Adapter2\n";
	print OUT "$adapter_two\n";
	$rc_adapter_two = reverse $adapter_two;
	$rc_adapter_two =~ tr/ACGTacgt/TGCAtgca/;
	print OUT ">$clone\_Adapter2_rc\n";
        # print ">$clone\_Adapter2_rc\n";
	print OUT "$rc_adapter_two\n";	
}
		
exit;

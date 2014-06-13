#!/usr/bin/perl -T
#
# Developed by Phil DeMonaco
#
# Monitor Directory Contents
# ============================================================
#
# This script is to be used as a monitor command for nagios 
# to remotely determine whether the specified directory has 
# appropriate number of files within the correct time window.
#
# ============================================================
# Modfication List
# ============================================================
# 1.0  PAD - Initial version of the script
# ============================================================
#
# Variable definition ----------------------------------------
#

## Includes
use Getopt::Long;


## Constants
# Nagios Return Codes
my $state_ok         = 0;
my $state_warning    = 1;
my $state_critical   = 2;
my $state_unknown    = 3;
my $state_fullderp   = 4;
# Commands
my $grep = "/usr/bin/grep";
my $find = "/usr/bin/find";


## Parameters
# Thresholds
my $critical, $warning;
# Flags
my $mode;
# Settings
my $path, $pattern;


## Main Execution =============================================
# Enable bundling of single character options... risky business
Getopt::Long::Configure( "bundling" );

# Process Parameters
GetOptions( "mode|m"            => \$mode,
            "critical|crit|c=i" => \$critical,
            "warning|warn|w=i"  => \$warning) 
    or usage();

# All parameters are currently required
unless( defined $mode )     { die "The mode must be specified!"; }
unless( defined $critical ) { die "A critical threshold is required!"; }
unless( defined $warning )  { die "A warning threshold is required!"; }


## Usage ======================================================
# Trivial subroutine which prints a usage message
## ============================================================
sub usage() {

    print << "EOF";
Usage: check_dir -m MODE -w WARNING -c CRITICAL -d DIRECTORY -p PATTERN

--source    -s <path>   Path to the source data file

--target    -t <path>   Path to the target output file

--overwrite -o          Enable overwritting of the output file should it exist

--zeros     -z          Enable the enclusion of lines with zero quantity

EOF
}

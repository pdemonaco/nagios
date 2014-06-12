#!/usr/bin/perl -T
#
# Developed by Phil DeMonaco
#
# Monitor file system freespace
# ============================================================
#
# This script is to be used as a monitor command for nagios 
# to remotely determine whether the specified fs has the 
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
my $flag_mode;
# Settings
my $path, $pattern;


# Main Execution ---------------------------------------------
## Enable bundling of single character options... risky business
Getopt::Long::Configure( "bundling" );

## Process Parameters
GetOptions( "mode|m"            => \$flag_mode,
            "critical|crit|c=d" => \$critical,
            "warning|warn|w=d"  => \$warning);


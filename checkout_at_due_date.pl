#!/usr/bin/perl
use strict;

use Date::Parse; 


my $deadline = shift;
my $unix_deadline = str2time($deadline);
my $global_folder = shift;

my @ls = `ls -d $global_folder/*`;
foreach my $folder(@ls){ 
    chomp $folder;

    print("Checking $folder \n");
    continue if(!(-d $folder));
    my @logs = `cd $folder ;  git log --format="%h %at"`;

    foreach my $line(@logs){
        chomp $line;
        my @spl = split(/\s+/,$line);
        if($unix_deadline > $spl[1]){
            print "Checking out $spl[0] for $folder...\n";
            system("cd $folder ; git -c advice.detachedHead=false checkout $spl[0]");
            print "done\n";
            last;
        }
    }
}
#!/usr/bin/perl
use strict;
use warnings;
use Date::Parse; 

# intake of the deadline in any acceptable format an the base folder. 
my $deadline = shift;
my $global_folder = shift;

# converts the date/time to UNIX timetamps.
my $unix_deadline = str2time($deadline);

# lists the user folders, runs though them and ecludes any single files in the base folder.
my @ls = `ls -d $global_folder/*`;
foreach my $folder(@ls){ 
    chomp $folder;
    continue if(!(-d $folder));

    print("Checking $folder \n");

    # get the git logs in a custom format thats just the hash and the timestamp (in UNIX format).
    my @logs = `cd $folder ;  git log --format="%h %at"`;

    # itterate on the log from most recent till the first one is encountered that is before the dealdine. 
    foreach my $line(@logs){
        chomp $line;
        my @spl = split(/\s+/,$line);
        if($unix_deadline > $spl[1]){
            print "Checking out $spl[0] for $folder...\n";
            # checkout and suppress the warning that you're detatching from the HEAD pointer. 
            system("cd $folder ; git -c advice.detachedHead=false checkout $spl[0]");
            print "done\n";
            last;
        }
    }
}
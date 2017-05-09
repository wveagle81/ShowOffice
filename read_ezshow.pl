#!/perl/bin/perl
#
#	Read an EZ-Show National Report file and copy that data
#	to the member.txt and horse.txt and owner.txt files
#
#

chdir "showresults";

#
#	Open the horse and member files and read them into the
#	hashes before reading the EZ-Show data
#

open (FI, "../data/horse.txt") or die "Unable to open horse file:$!\n";
chomp(@horsedata = <FI>);
close(FI);
foreach $line (@horsedata) {
   ($hnum,$rest) = split(/~~/, $line, 2);
   $rest =~ tr/a-z/A-Z/;
   $horse{$hnum} = $rest;
}

open (FI, "../data/member.txt") or die "Unable to open member file:$!\n";
chomp(@memberdata = <FI>);
close(FI);
foreach $line (@memberdata) {
   ($mnum,$rest) = split(/~~/, $line, 2);
   $rest =~ tr/a-z/A-Z/;
   $member{$hnum} = $rest;
}


#
#	Go to the showresults dir and read the files
#	one at a time, extracting the data and adding
#	it to the hashes
#

while (defined($filename = <*>)) {
   next if ($filename =~ /^\./);
   
   open (FI, $filename) or die "Unable to open file $filename: $!\n";
   chomp(@file = <FI>);
   close(FI);
   
   @show = grep(/^D/, @file);
   foreach $line (@show) {
      if ($filename =~ /^98/) {
         $horsetype = substr($line, 23, 2);
         $horsenum  = substr($line, 25, 7);
         $horsename = substr($line, 32, 17);
         $horsefoal = substr($line, 49, 2);
         $horsefoal += 1900;
         
         $membertype = substr($line, 51, 1);
         $membernum  = substr($line, 52, 7);
         $membername = substr($line, 59, 25);
         $memberaddr = substr($line, 84, 25);
         $membercity = substr($line, 109, 15);
         $memberstate= substr($line, 124, 2);
         $memberzip  = substr($line, 126, 5);
      
         $ownername  = substr($line, 137, 25);
         $owneraddr  = substr($line, 162, 25);
         $ownercity  = substr($line, 187, 15);
         $ownerstate = substr($line, 120, 2);
         $ownerzip   = substr($line, 122, 5);
      } else {
         $horsetype = substr($line, 25, 2);
         $horsenum  = substr($line, 27, 7);
         $horsename = substr($line, 34, 17);
         $horsefoal = substr($line, 51, 4);
      
         $membertype = substr($line, 55, 1);
         $membernum  = substr($line, 56, 7);
         $membername = substr($line, 63, 25);
         $memberaddr = substr($line, 88, 25);
         $membercity = substr($line, 113, 15);
         $memberstate= substr($line, 128, 2);
         $memberzip  = substr($line, 130, 5);
      
         $ownername  = substr($line, 141, 25);
         $owneraddr  = substr($line, 166, 25);
         $ownercity  = substr($line, 191, 15);
         $ownerstate = substr($line, 124, 2);
         $ownerzip   = substr($line, 126, 5);
      }
      
      $horsetype =~ s/^ *//;
      $horsename =~ s/ *$//;
      $horsefoal =~ s/ *$//;

      $membertype =~ s/ *$//;
      $membername =~ s/ *$//;
      $memberaddr =~ s/ *$//;
      $membercity =~ s/ *$//;
      $memberstate=~ s/ *$//;
      $memberzip  =~ s/ *$//;
      ($memberlast, $memberfirst) = split(/, /, $membername);
      $memberinfo{$membername} = $membernum;

      $ownername  =~ s/ *$//;
      ($ownerlast, $ownerfirst) = split(/, /, $ownername);

      $horse{$horsenum}   = "${horsetype}~~${horsename}~~~~${horsefoal}~~~~~~~~";
      if (($membertype ne "P") && ($membertype ne "U") && ($membernum =~ /^\d+$/)) {
         $member{$membernum} = "${memberfirst}~~${memberlast}~~${memberaddr}~~${membercity}~~${memberstate}~~${memberzip}~~~~~~~~~~~~${membertype}";
      }
      $owner{$horsenum}   = $ownername;
#print "$horsenum~~$horse{$horsenum}\n";
#print "$membernum~~$member{$membernum}\n";
#sleep 2;
   }

}

#
#	Now write the hashes out to the end of the horse and  
#	member files
#

open (FI, ">>../data/horse.txt") or die "Unable to open horse file:$!\n";
foreach $key (sort keys %horse) {
   $ownernum = $memberinfo{$owner{$key}};
   print "${key}~~${horse{$key}}~~$ownernum\n";
   print FI "${key}~~${horse{$key}}~~$ownernum\n";
}
close(FL);
   
open (FI, ">>../data/member.txt") or die "Unable to open member file:$!\n";
foreach $key (sort keys %member) {
   print "${key}~~${member{$key}}\n";
   print FI "${key}~~${member{$key}}\n";
}
close(FL);

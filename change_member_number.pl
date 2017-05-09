#!/perl/bin/perl
#
#	Evaluate the member information file
#

use Term::ReadKey;
use File::Find;

open (M, "data/appaloosa.member.txt") or die "Unable to open member file: $!";
chomp(@members = <M>);
close (M);

open (M, "data/appaloosa.horse.txt") or die "Unable to open member file: $!";
chomp(@horses = <M>);
close (M);

print "\nChanging the Member Number\n\n";

print "Enter existing member number: ";
chomp($existing = ReadLine(0));

print "Enter new member number: ";
chomp($new = ReadLine(0));

#
#	See if entered numbers exist in the data file
#

@memberexist = grep(/^${existing}~~/, @members);
@membernew   = grep(/^${new}~~/, @members);
@ownerexist  = grep(/~~${existing}$/, @horses);
@ownernew    = grep(/~~${new}$/, @horses);

print "Old member found: $#memberexist\nNew member found = $#membernew\n";
print "Old owner found: $#ownerexist\nNew owner found = $#ownernew\n";

#
#	Check the existing numbers.  If both exist, we have a slight problem
#	and have to do more work.
#

if ($#memberexist < 0) {
   print "\nExisting Member number not found in data file\n";
   exit;
}

if ($#memberexist >= 0 && $#membernew < 0) {
   print "\nExisting number found - new number not found.\n";
   print "This is a good thing.\n\n";

   print "Changing existing number to new number in Member File\n";

   foreach $index (0 .. $#members) {
      chomp;
      ($ridernum, $riderlastname, $riderfirstname, $rideraddress, 
      $ridercity, $riderstate, $riderzip, $riderhomephone, 
      $riderworkphone, $rideremail, $ridersex, $rideryear, 
      $regtype, $ridernumberstatus) = split(/~~/, $members[$index]);

      if ($ridernum eq $existing) {
	 $members[$index] = "$new~~$riderlastname~~$riderfirstname~~$rideraddress~~$ridercity~~$riderstate~~$riderzip~~$riderhomephone~~$riderworkphone~~$rideremail~~$ridersex~~$rideryear~~$regtype~~$ridernumberstatus";
      }
   }

   foreach $index (0 .. $#horses) {
      ($regnum, $regtype, $name, $sex, $foaled, $color, $sire, $dam, $owner) = split(/~~/, $horses[$index]);

      if ($owner eq $existing) {
	 $horses[$index] = "$regnum~~$regtype~~$name~~$sex~~$foaled~~$color~~$sire~~$dam~~$new";
      }
   }

#
#	Write out the changed member and horse files
#

   open (M, ">data/appaloosa.member.txt") or die "Unable to create member file: $!";
   foreach $line (@members) {
      print M "$line\n";
   }
   close (M);

   open (M, ">data/appaloosa.horse.txt") or die "Unable to create horse file: $!";
   foreach $line (@horses) {
      print M "$line\n";
   }
   close (M);

}

if ($#memberexist >= 0 && $#membernew >= 0) {
   print "\nExisting number AND new number found.\n";
   print "This is not necessarily a good thing.\n\n";
   
   print "Removing existing number in Member File\n";
   
   foreach $index (0 .. $#members) {
      chomp;
      ($ridernum, $riderlastname, $riderfirstname, $rideraddress, 
      $ridercity, $riderstate, $riderzip, $riderhomephone, 
      $riderworkphone, $rideremail, $ridersex, $rideryear, 
      $regtype, $ridernumberstatus) = split(/~~/, $members[$index]);

      if ($ridernum ne $existing) {
	 push(@newmembers, $members[$index]);
      }
   }

   foreach $index (0 .. $#horses) {
      ($regnum, $regtype, $name, $sex, $foaled, $color, $sire, $dam, $owner) = split(/~~/, $horses[$index]);

      if ($owner eq $existing) {
	 $horses[$index] = "$regnum~~$regtype~~$name~~$sex~~$foaled~~$color~~$sire~~$dam~~$new";
      }
   }

#
#	Write out the changed member and horse files
#

   open (M, ">data/appaloosa.member.txt") or die "Unable to create member file: $!";
   foreach $line (@newmembers) {
      print M "$line\n";
   }
   close (M);

   open (M, ">data/appaloosa.horse.txt") or die "Unable to create horse file: $!";
   foreach $line (@horses) {
      print M "$line\n";
   }
   close (M);

}

#
#	Search for "extry.txt" in all directories.  When found, look for the
#	existing member number in the file and change it to the new member
#	number.
#

find(\&wanted, "show");
find(\&wanted, "Old Shows");


#
#	Subdirectory for the file find.
#
#	If the file found is "entry.txt" then we need to work on that file
#	to change the member number to the new member number.
#

sub wanted {
   
   $changed = 0;
   
   if ($_ eq "entry.txt") {
      print "Entry file found: $File::Find::name     ";

      open (M, "$_") or die "Unable to open entry file: $!";
      chomp(@entries = <M>);
      close (M);

      foreach $index (0 .. $#entries) {
         (${backnum}, ${horsenum}, ${ridernum}, ${rest})= split(/~~/, $entries[$index], 4);

         if ($ridernum eq $existing) {
  	    $changed++;
    	    $entries[$index] = "${backnum}~~${horsenum}~~${new}~~${rest}";
         }
      }
      print "Changed: $changed\n";

      open (M, ">entry.txt") or die "Unable to create entry file: $!";
      foreach $line (@entries) {
         print M "$line\n";
      }
      close (M);

   }
}


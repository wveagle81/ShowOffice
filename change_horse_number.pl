#!/perl/bin/perl
#
#	Evaluate the horse information file
#

use Term::ReadKey;
use File::Find;

open (M, "data/appaloosa.horse.txt") or die "Unable to open member file: $!";
chomp(@horses = <M>);
close (M);

print "\nChanging the Horse Number\n\n";

print "Enter existing horse number: ";
chomp($existing = ReadLine(0));

print "Enter new horse number: ";
chomp($new = ReadLine(0));

#
#	See if entered numbers exist in the data file
#

@horseexist = grep(/^${existing}~~/, @horses);
@horsenew   = grep(/^${new}~~/, @horses);

print "Old horse found: $#horseexist\nNew horse found = $#horsenew\n";

#
#	Check the existing numbers.  If both exist, we have a slight problem
#	and have to do more work.
#

if ($#horseexist < 0) {
   print "\nExisting Horse number not found in data file\n";
   exit;
}

if ($#horseexist >= 0 && $#horsenew < 0) {
   print "\nExisting number found - new number not found.\n";
   print "This is a good thing.\n\n";

   print "Changing existing number to new number in Member File\n";

   foreach $index (0 .. $#horses) {
      ($regnum, $regtype, $name, $sex, $foaled, $color, $sire, $dam, $owner) = split(/~~/, $horses[$index]);

      if ($regnum eq $existing) {
	 $horses[$index] = "$new~~$regtype~~$name~~$sex~~$foaled~~$color~~$sire~~$dam~~$owner";
      }
   }

#
#	Write out the changed horse file
#

   open (M, ">data/appaloosa.horse.txt") or die "Unable to create horse file: $!";
   foreach $line (@horses) {
      print M "$line\n";
   }
   close (M);

}

if ($#horseexist >= 0 && $#horsenew >= 0) {
   print "\nExisting number AND new number found.\n";
   print "This is not necessarily a good thing.\n\n";
   
   print "Removing existing number in Horse File\n";
   
   foreach $index (0 .. $#horses) {
      ($regnum, $regtype, $name, $sex, $foaled, $color, $sire, $dam, $owner) = split(/~~/, $horses[$index]);

      if ($regnum ne $existing) {
	 push(@newhorses, $horses[$index]);
      }
   }

#
#	Write out the changed horse file
#

   open (M, ">data/appaloosa.horse.txt") or die "Unable to create horse file: $!";
   foreach $line (@newhorses) {
      print M "$line\n";
   }
   close (M);

}

#
#	Search for "extry.txt" in all directories.  When found, look for the
#	existing horse number in the file and change it to the new horse
#	number.
#

find(\&wanted, "show");
find(\&wanted, "Old Shows");


#
#	Subdirectory for the file find.
#
#	If the file found is "entry.txt" then we need to work on that file
#	to change the horse number to the new horse number.
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

         if ($horsenum eq $existing) {
  	    $changed++;
    	    $entries[$index] = "${backnum}~~${new}~~${ridernum}~~${rest}";
         }
      }
      print "Changed: $changed\n";

      open (M, ">entry.new.txt") or die "Unable to create entry file: $!";
      foreach $line (@entries) {
         print M "$line\n";
      }
      close (M);

   }
}


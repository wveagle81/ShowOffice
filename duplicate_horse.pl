#!/perl/bin/perl
#
#	Look for duplicate horses
#

use Term::ReadKey;
use File::Find;

open (M, "data/appaloosa.horse.txt") or die "Unable to open horse file: $!";
chomp(@horses = <M>);
close (M);

print "\nLooking for the Duplicate horses\n\n";

%dhorses = ();

foreach $index (0 .. $#horses) {
   ($regnum, $regtype, $name, $sex, $foaled, $color, $sire, $dam, $owner) = split(/~~/, $horses[$index]);

   $key = "${name}";
   if (!$dhorses{$key}) {
      $dhorses{$key} = "${index}";
#      print "Key: $key   Hash: $dhorses{$key}\n";
   } else {
#      print "$riderlastname $riderfirstname Duplicate\n";
      $dhorses{$key} .= ":${index}";
#      print "Key: $key   Hash: $dhorses{$key}\n";
   }
}

open (M, ">data/duplicate.horse.txt") or die "Unable to open horse file: $!";
foreach $key (sort keys %dhorses) {
#   print "Key: $key   Hash: $dhorses{$key}\n";
   if ($dhorses{$key} =~ /\:/) {
      @index = split(/\:/, $dhorses{$key});
      printf M "%-25s  %s\n", $key, $dhorses{$key};
      foreach $index (@index) {
         ($regnum, $regtype, $name, $sex, $foaled, $color, $sire, $dam, $owner) = split(/~~/, $horses[$index]);
	 printf M "%-10s %s\n", $regnum, $name;
      }
      printf M "\n";
   }
}
close(M);

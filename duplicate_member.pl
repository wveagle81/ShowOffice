#!/perl/bin/perl
#
#	Look for duplicate members
#

use Term::ReadKey;
use File::Find;

open (M, "data/appaloosa.member.txt") or die "Unable to open member file: $!";
chomp(@members = <M>);
close (M);

print "\nLooking for the Duplicate Members\n\n";

%dmembers = ();

foreach $index (0 .. $#members) {
   ($ridernum, $riderlastname, $riderfirstname) = split(/~~/, $members[$index]);

   $key = "${riderlastname}.${riderfirstname}";
   if (!$dmembers{$key}) {
      $dmembers{$key} = "${index}";
#      print "Key: $key   Hash: $dmembers{$key}\n";
   } else {
#      print "$riderlastname $riderfirstname Duplicate\n";
      $dmembers{$key} .= ":${index}";
#      print "Key: $key   Hash: $dmembers{$key}\n";
   }
}

open (M, ">data/duplicate.member.txt") or die "Unable to open member file: $!";
foreach $key (sort keys %dmembers) {
#   print "Key: $key   Hash: $dmembers{$key}\n";
   if ($dmembers{$key} =~ /\:/) {
      @index = split(/\:/, $dmembers{$key});
      printf M "%-25s  %s\n", $key, $dmembers{$key};
      foreach $index (@index) {
         ($ridernum, $riderlastname, $riderfirstname) = split(/~~/, $members[$index]);
	 printf M "%-10s %s %s\n", $ridernum, $riderfirstname, $riderlastname;
      }
      printf M "\n";
   }
}
close(M);

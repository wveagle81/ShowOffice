##################################################################################
##################################################################################
#
#       Perl/TK Horse Show Program
#
#  Lookup Green Class eligibility of ALL horses in the Horse List.
#
##################################################################################
##################################################################################

use Cwd;

$| = 1;

$current_year = ((localtime(time))[5]) + 1900;

#
#	Read the horse file into an array
#

@horse_list = ();
open(ML, "data/appaloosa.horse.txt") or do {
   print "Unable to open member list file\n";
   exit;
};
chomp(@horse_list = <ML>);
close (ML);


#
#	Go thru the list one line at a time, looking up
#	the horse.
#
#	Do NOT do the lookup IF:
#	1. The member is temporary (has a "P" number)
#	2. The member is current (year >= current year)
#

my @hlist = ();

foreach $ii (@horse_list) {
   (${regnum},${regtype},${horsename},${horsesex},${yearfoaled},${horsecolor},${horsesire},${horsedam},${ownernum}) = split(/~~/, $ii);

   printf "%-10s%-45s", $regnum, $horsename;

   if ($regnum =~ /^P/) {
      print "Skipping Temporary Horse\n";
   } else {
      $result = is_green($regnum);
      $l = "${regnum}~~${result}";
      push (@hlist, $l);
   }

}

#
#	Write the file
#

print "\n\nWriting data to member file...\n";

open (HI, ">data/appaloosa.green.txt") or die "Unable to open horse information file for writing: $!";
foreach $line (@hlist) {
   print HI "${line}\n";
}
close (HI);


##################################################################################
##################################################################################
#
#       See if the horse is Green eligible and return the results
#

sub is_green {
   use WWW::Mechanize;

   my $mech = WWW::Mechanize->new();
 
   $url = 'http://www.appaloosa.com/web/HrsGreenVerify.aspx';

   $mech->get( $url );

   $mech->submit_form(
       form_name => 'Form1',
       fields    => { txtMemNumA  => $_[0], },
       button    => 'btnEnter'
   );

   @page = split(/\n/, $mech->content());
   $result  = "";
   for ($ii=0; $ii<=$#page; $ii++) {
      if ($page[$ii] =~ /"\>O-/) {
#         print "$page[$ii]\n";
	 $res = ($page[$ii] =~ "Eligible") ? "Y" : "N";
         $page[$ii] =~ s/<[^>]*>//gs;
#	 print "$page[$ii]\n";
	 (undef, $class) = split(/\s+/, $page[$ii]);
         $class =~ s/-//;
         $result .= "$class:$res~";
#  	 print "$class\t$res\n";
      }
   }
   chop($result);
   print "$result\n";
   
   return ($result);
}


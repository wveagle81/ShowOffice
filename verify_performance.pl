##################################################################################
##################################################################################
#
#       Perl/TK Horse Show Program
#
#  Lookup Preformance Permit eligibility of ALL horses in the Horse List.
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
#	1. The horse is temporary (has a "P" number)
#

my @hlist = ();

foreach $ii (@horse_list) {
   (${regnum},${regtype},${horsename},${horsesex},${yearfoaled},${horsecolor},${horsesire},${horsedam},${ownernum}) = split(/~~/, $ii);

   printf "%-10s%-45s", $regnum, $horsename;

   if ($regnum =~ /^P/) {
      print "Skipping Temporary Horse\n";
   } else {
      $result = is_performance($regnum);
      $l = "${regnum}~~${result}";
      push (@hlist, $l);
   }

}

#
#	Write the file
#

print "\n\nWriting data to member file...\n";

open (HI, ">data/appaloosa.performance.txt") or die "Unable to open horse information file for writing: $!";
foreach $line (@hlist) {
   print HI "${line}\n";
}
close (HI);


##################################################################################
##################################################################################
#
#       See if the horse is Green eligible and return the results
#

sub is_performance {
   use WWW::Mechanize;

   my $mech = WWW::Mechanize->new();
 
   $url = 'http://www.appaloosa.com/web/hrsverify.aspx';

   $mech->get( $url );

   $mech->submit_form(
       form_name => 'Form1',
       fields    => { txtMemNumA  => $_[0], },
       button    => 'btnEnter'
   );

   @page = split(/\n/, $mech->content());
   $result  = "";
   for ($ii=0; $ii<=$#page; $ii++) {
      if ($page[$ii] =~ /txtHRSSTS/) {
#         print "$page[$ii]\n";
	 next if ($page[$ii] !~ /Eligible/);
	 $res = ($page[$ii] =~ /Not Eligible/) ? "N" : "Y";
  	 print "$res\n";
      }
   }
   
   return ($res);
}


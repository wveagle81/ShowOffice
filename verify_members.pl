##################################################################################
##################################################################################
#
#       Perl/TK Horse Show Program
#
#  Lookup membership status of ALL members in the Membership List.
#  If the current membership status is missing or is not the current
#  year, do the lookup.
#
##################################################################################
##################################################################################

use Cwd;

$| = 1;

$current_year = ((localtime(time))[5]) + 1900;

#
#	Read the membership file into an array
#

@member_list = ();
open(ML, "data/appaloosa.member.txt") or do {
   print "Unable to open member list file\n";
   exit;
};
chomp(@member_list = <ML>);
close (ML);


#
#	Go thru the list one line at a time, looking up
#	the member if necessary.
#
#	Do NOT do the lookup IF:
#	1. The member is temporary (has a "P" number)
#	2. The member is current (year >= current year)
#

my @mlist = ();

foreach $ii (@member_list) {
   ($regnum,$riderlastname,$riderfirstname,$rideraddress,$ridercity,$riderstate,$riderzip,$riderhomephone,$riderworkphone,$rideremail,$ridersex,$rideryear,$ridertype,$ridernumberstatus,$expdate) = split(/~~/, $ii);

   $name    = $riderfirstname ." ". $riderlastname ." (". $expdate .")";
   printf "%-10s%-45s", $regnum, $name;

   if ($regnum =~ /^P/) {
      print "Skipping Temporary Member\n";
      $expdate = "Temporary";
   } else {
      if ($expdate !~ /Not/) {
         ($month, $day, $year) = split(/\//, $expdate);
#         if ($year >= $current_year) {
#            print "Skipping Current Member...\n";
#         } else {
            $result = is_member($regnum);
            print "$result\n";
#         }
      } else {
         $result = is_member($regnum);
         print "$result\n";
      }
   }

#   $l = "${regnum}~~${riderlastname}~~${riderfirstname}~~${rideraddress}~~${ridercity}~~${riderstate}~~${riderzip}~~${riderhomephone}~~${riderworkphone}~~${rideremail}~~${ridersex}~~${rideryear}~~${ridertype}~~${ridernumberstatus}~~${expdate}";
#   push (@mlist, $l);
}

#
#	Write the file
#

#print "\n\nWriting data to member file...\n";

#open (HI, ">data/appaloosa.member.NEW.txt") or die "Unable to open member information file for writing: $!";
#foreach $line (@mlist) {
#   print HI "${line}\n";
#}
#close (HI);


##################################################################################
##################################################################################
#
#       See if a person is an Appaloosa Member and return their exp date
#

sub is_member {
   use WWW::Mechanize;

   my $mech = WWW::Mechanize->new();
 
   $url = 'http://www.appaloosa.com/web/mbrverify.aspx';

   $mech->get( $url );

   $mech->submit_form(
       form_name => 'Form1',
       fields    => { txtMemNumA  => $_[0], },
       button    => 'btnEnter'
   );

   $np_eligible = "";
   @page = split(/\n/, $mech->content());

   for ($ii=0; $ii<=$#page; $ii++) {
      if ($page[$ii] =~ /txtPMBSTS/) {
         $page[$ii] =~ s/<[^>]*>//gs;
		 $status = $page[$ii];
		 $status =~ s/ //g;
		 chomp($status);
		 chop($status);
		 }
      if ($page[$ii] =~ /txtPMBEXP/) {
         $page[$ii] =~ s/<[^>]*>//gs;
		 $expdate = $page[$ii];
		 $expdate =~ s/ //g;
		 chomp($expdate);
		 chop($expdate);
      }
      if ($page[$ii] =~ /txtPNCARD/) {
         $page[$ii] =~ s/<[^>]*>//gs;
		 $nonpro = $page[$ii];
		 $nonpro =~ s/ //g;
		 chomp($nonpro);
		 chop($nonpro);
      }
      if ($page[$ii] =~ /txtPMBAGE/) {
         $page[$ii] =~ s/<[^>]*>//gs;
		 $age = $page[$ii];
		 $age =~ s/ //g;
		 chomp($age);
		 chop($age);
         ($age) = split(/-/, $age);
      }
      if ($page[$ii] =~ /\d Non-Pro /) {
         $page[$ii] =~ s/<[^>]*>//gs;
	     ($cls) = split(/ /, $page[$ii]);
		 $cls =~ s/-//;
		 $cls =~ s/\t//g;
         $res = ($page[$ii] =~ "Eligible") ? "Y" : "N";
		 $np_eligible .= "${cls}:${res}~";
	  }
}

   $result = "${status}~${expdate}~${nonpro}~${age}~${np_eligible}";
   chop($result);
   
   return ($result);
}


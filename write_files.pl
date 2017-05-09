##################################################################################
#
#       Common Write File Functions
#
##################################################################################


##################################################################################
##################################################################################
#
#       Write the ENTRY file
#

sub write_entry_file {
   my $showdir = $_[0];

   open(EL, "> $showdir/entry.txt") or do {
      print "Unable to open entry file: $!";
      exit;
   };

   foreach $key (sort keys %entries) {
      @e = @{$entries{$key}};
      for $ii (@e) {
#print "Writng: $ii\n";
         print EL "$ii\n";
      }
   }
   close(EL);
}


##################################################################################
##################################################################################
#
#       Write the CLASS file
#

sub write_class_file {
   my $showdir = $_[0];

   open(EL, "> $showdir/classes.txt") or do {
      print "Unable to open classes file: $!";
      exit;
   };

   foreach (@show_classes) {
      print EL "$_\n";
   }
   close(EL);
}


##################################################################################
##################################################################################
#
#       Save a single entry to the entry list.
#

sub save_one_entry {
   my $year = ((localtime(time))[5]) + 1900;
   my ($backnumber,$horsenum,$ridernum,$relation,$class) = @_;

   &open_member_file;
   &open_horse_file;
   &open_entry_file($showdir);
   my @ncl = grep /^${backnumber}~~/, @entry_list;

#
#	Check to see if the entry is already registered in the class
#
   if ($#ncl >= 0) {
      foreach $line (@ncl) {
         ($b, $h, $r, $l, $c, $j) = split(/~~/, $line);
print "Checking Back $b with Class $c against Back $backnumber in Class $class\n";
         if ($b == $backnumber && $c == $class) {
            $dialog = $msgdialog->DialogBox(-title => 'Rider Already In Class', -buttons => [ "Ok" ]);
            $dialog->add("Label", -text => "This horse/rider combination is already entered")->pack;
            $dialog->add("Label", -text => "in class number $class. Not added again.")->pack;
            $dialog->Show();
            return;
         }
      }
   }

   my @res = grep(/^${class}\) /, @show_classes);
   my ($cnum, $cname) = split(/\) /, $res[0]);
   my $rmin = $hmin = 0;
   my $rmax = $hmax = 999;
   if ($cname =~ /35 & Over/) {
      $rmin = 35;  $rmax = 999;
   }
   if ($cname =~ /Master/) {
      $rmin = 50;  $rmax = 999;
   }
   if ($cname =~ /(\d+) & Under/) {
      $rmin = 0;   $rmax = $1;
   }
   if ($cname =~ /(\d+) - (\d+)/) {
      $rmin = $1;  $rmax = $2;
   }
   if ($cname =~ /Weanling/) {
      $hmin = 0;   $hmax = 0;
   }
   if ($cname =~ /Yearling/) {
      $hmin = 1;   $hmax = 1;
   }
   if ($cname =~ /Two Year/) {
      $hmin = 2;   $hmax = 2;
   }
   if ($cname =~ /Three Year/) {
      $hmin = 3;   $hmax = 3;
   }
   if ($cname =~ /Aged/) {
      $hmin = 4;   $hmax = 999;
   }
   if ($cname =~ /- Junior/) {
      $hmin = 0;   $hmax = 5;
   }
   if ($cname =~ /- Senior/) {
      $hmin = 6;   $hmax = 999;
   }

print "Rider Min = $rmin\nRider Max = $rmax\nHorse Min = $hmin\nHorse Max = $hmax\n";


#
#	Check to see if the rider is of correct age for the class
#
   my @res = grep(/^${ridernum}~/, @member_list);
print "$res[0]\n";
   my ($rnum, $rstat, $rlastname, $rfirstname, $raddress, $rcity, $rstate, $rzip, $rhomephone, $rworkphone, $remail, $rsex, $ryear, $rtype, $rnumberstatus) = split(/~~/, $res[0]);
   $ryear = $year if ($ryear eq "");
   my $age = $year - $ryear - 1;
print "Rider Birth Year: $ryear\nRider Age: $age\n";
   if (($age < $rmin) || ($age > $rmax)) {
#      print "Rider is not of proper age\n";
      return;
   }

#
#	Check to see if the horse is of correct age for the class
#
   my @res = grep(/^${horsenum}~/, @horse_list);
print "$res[0]\n";
   my ($hnum, $htype, $hname, $hsex, $hyear, $hcolor, $hsire, $hdam, $ownernum) = split(/~~/, $res[0]);
   $hyear = $year if ($hyear eq "");
   my $age = $year - $hyear - 1;
print "Horse Foal Year: $hyear\nHorse Age: $age\n";
   if (($age < $hmin) || ($age > $hmax)) {
      print "Horse is not of proper age\n";
#      return;
   }

   if (-e "$showdir/entry.txt") {
      open (EN, ">>$showdir/entry.txt") or die "Unable to append to entry file: $!";
   } else {
      open (EN, ">$showdir/entry.txt") or die "Unable to create entry file: $!";
   }
   print EN "$backnumber~~$horsenum~~$ridernum~~$relation~~$class~~\n";
   close (EN);
}


##################################################################################
##################################################################################
#
#  Save the entered horse information and then close the window
#

sub save_horse_info {

#
#  If horse number or name are blank, tell the user
#  they must enter data before saving a horse
#
   if (($horsetype eq "") || ($horsenum eq "") || ($horsename eq "") || ($horsesex eq "") || ($yearfoaled eq "")) {
      $dialog = $msgdialog->DialogBox(-title => 'Not Enough Data', -buttons => [ "Ok" ]);
      $dialog->add("Label", -text => "You did not enter enough data to save a horse")->pack;
      $dialog->add("Label", -text => "You must provide the horse's number, registration type, name, sex and year foaled")->pack;
      $dialog->Show();
      return;
   }

#
#  Replace current horse information in hash, then
#  Save the horse information
#
   my ($t,$j) = split(/ /, $horsetype);
   $horse_list{$horsenum} = "${t}~~${horsename}~~${horsesex}~~${yearfoaled}~~${horsecolor}~~${horsesire}~~${horsedam}~~${ownernum}";

   open (HI, ">data/horse.txt") or die "Unable to horse information file for writing: $!";
   foreach $key (sort { $a <=> $b } keys %horse_list) {
      print HI "${key}~~$horse_list{$key}\n";
   }
   close (HI);
   $modify_text = "Horse / Owner Info Saved";

#
#  Reread the horse list
#
   &open_horse_file;


##################################################################################
##################################################################################
#
#  Save the entered owner information and then close the window
#

#
#  If owner number or name are blank, tell the user
#  they must enter data before saving a owner
#
   if (($ownernum eq "") || ($ownerfirstname eq "") || ($ownerlastname eq "")) {
      $dialog = $msgdialog->DialogBox(-title => 'Not Enough Data', -font => 'system 12', -buttons => [ "Ok" ]);
      $dialog->add("Label", -text => "You did not enter enough data to save a owner")->pack;
      $dialog->add("Label", -text => "You must provide the owner's number and name")->pack;
      $dialog->Show();
      return;
   }

#
#  Save the owner information
#
   $member_list{$ownernum} = "${ownerlastname}, ${ownerfirstname}~~${ownermemberstatus}~~${owneraddress}~~${ownercity}~~${ownerstate}~~${ownerzip}~~${ownerhomephone}~~${ownerworkphone}~~${owneremail}~~${ownersex}~~${owneryear}~~${ownertype}~~${ownernumberstatus}";

   open (HI, ">data/member.txt") or die "Unable to member information file for writing: $!";
   foreach $key (sort { $a <=> $b } keys %member_list) {
      ($ownername, $ostat, $ownerinfo) = split(/~~/, $member_list{$key}, 3);
      ($olname, $ofname) = split(/, /, $ownername);
      print HI "${key}~~${ostat}~~${olname}~~${ofname}~~${ownerinfo}\n";
   }
   close (HI);

#
#  Add the owner to the list
#
   &open_member_file;
}


##################################################################################
##################################################################################
#
#  Save the entered member information
#

sub save_member_info {

#
#  If rider number or name are blank, tell the user
#  they must enter data before saving a rider
#
   if (($ridernum eq "") || ($riderfirstname eq "") || ($riderlastname eq "")) {
      $dialog = $modify_info_window->DialogBox(-title => 'Not Enough Data', -font => 'system 12', -buttons => [ "Ok" ]);
      $dialog->add("Label", -text => "You did not enter enough data to save a rider")->pack;
      $dialog->add("Label", -text => "You must provide the rider's number and name")->pack;
      $dialog->Show();
      return;
   }

#
#  Save the rider information
#
   $member_list{$ridernum} = "${riderlastname}, ${riderfirstname}~~${ridermemberstatus}~~${rideraddress}~~${ridercity}~~${riderstate}~~${riderzip}~~${riderhomephone}~~${riderworkphone}~~${rideremail}~~${ridersex}~~${rideryear}~~${ridertype}~~${ridernumberstatus}";

   open (HI, ">data/member.txt") or die "Unable to open member information file for writing: $!";
   foreach $key (sort { $a <=> $b } keys %member_list) {
      ($ridername, $rstat, riderinfo) = split(/~~/, $member_list{$key}, 3);
      ($rlname, $rfname) = split(/, /, $ridername);
      print HI "${key}~~${rstat}~~${rlname}~~${rfname}~~${riderinfo}\n";
   }
   close (HI);
   $modify_text = "Member Info Saved";

#
#  Add the rider to the list
#
   &open_member_file;
}


1;

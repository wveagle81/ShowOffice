##################################################################################
#
#       Common Read/Write Functions
#
##################################################################################


##################################################################################
##################################################################################
#
#       Open the JUDGE file
#

sub open_judge_file {
print "Breed: $showbreed\n";
   open(JL, "data/${showbreed}.judge_list.txt") or do {
      print "Unable to open judge list file\n";
      exit;
   };
   chomp(@judge_list = <JL>);
   close (JL);

   foreach $ii (@judge_list) {
      ($judgenum, $jname) = split(/~~/, $ii);
      @judgename = split(/ /, $jname);
      @rjname = reverse @judgename;
      $jname = $rjname[0] .", ". $rjname[1];
      $jname = $rjname[0] .", ". $rjname[2] ." ". $rjname[1] if ($rjname[2]);
      $jname = $rjname[0] .", ". $rjname[2] ." ". $rjname[1] if ($rjname[3]);
      $judge_list{$judgenum} = $jname;
      $judge_name{$jname} = $judgenum;
   }
}


##################################################################################
##################################################################################
#
#       Open the NATIONAL CLASS LIST file
#

sub open_national_class_file {
print "Breed: $showbreed\n";
   open(CL, "data/${showbreed}.class_list.txt") or do {
      print "Unable to open class list file\n";
      exit;
   };
   chomp(@class_list = <CL>);
   close (CL);
}


##################################################################################
##################################################################################
#
#       Open the DIVISION LIST file
#

sub open_division_file {
   open(CL, "data/${showbreed}.division_list.txt") or do {
      print "Unable to open division list file\n";
      exit;
   };
   chomp(@division_list = <CL>);
   close (CL);
}


##################################################################################
##################################################################################
#
#       Open the LOCAL CLASS LIST file
#

sub open_local_class_file {
   open(CL, "data/${showbreed}.local_class_list.txt") or do {
      print "Unable to open local class list file\n";
      exit;
   };
   chomp(@local_class_list = <CL>);
   close (CL);
}


##################################################################################
##################################################################################
#
#       Open the HIGH POINT LIST file
#

sub open_high_point_file {
   open(CL, "data/${showbreed}.high_point_awards.txt") or do {
      print "op) Unable to open high point text file\n";
      exit;
   };
   chomp(@high_point_list = <CL>);
   close (CL);
}


##################################################################################
##################################################################################
#
#       Open the LOCAL POINT file
#

sub open_local_point_file {
   my $showdir = $_[0];

   open(CL, "${showdir}/local_points.txt") or do {
      print "Unable to local point list file: $shodwir\n";
      exit;
   };
   while (<CL>) {
      chomp;
      ($t, @pt) = split(/~~/);
      foreach $ii (0 .. $#pt) {
         $local_points{$t}[$ii] = $pt[$ii];
      }
   }
   close (CL);
}


##################################################################################
##################################################################################
#
#       Open the SHOW HIGH POINT LIST file
#

sub open_show_high_point_file {
   my $showdir = $_[0];
   my ($division, $type, $required, $hp_min_age, $hp_max_age, $classes, @cls, @sc, $cls, $n, $c);

print "Breed: $showbreed\n";

   %hp = ();
   open(CL, "${showdir}/high_point.txt") or do {
      print "Unable to open high point list file\n";
      exit;
   };

   while (<CL>) {
      my ($division, $type, $required, $hp_min_age, $hp_max_age, $classes) = split(/~~/, $_, 6);
      chomp($classes);
      $hp{$division}[0] = $type;
      $hp{$division}[1] = $required;
      $hp{$division}[3] = $hp_min_age;
      $hp{$division}[4] = $hp_max_age;
      (@cls) = split(/,/, $classes);
      foreach $cls (sort @cls) {
         @sc = grep(/$cls/, @show_classes);
         ($n, $c) = split(/\) /, $sc[0]);
         $hp{$division}[2] .= "${c}~~";
      }
      chop($highpoint{$division}[2]);
#print "DIVISION: $division   TYPE: $type   REQUIRED: $required   MIN/MAX: $hp_min_age / $hp_max_age   CLASSES: $hp{$division}[2]\n";
   }
   close (CL);
}


##################################################################################
##################################################################################
#
#       Open the SHOW HIGH POINT LIST file
#

sub open_report_high_point_file {
   my $showdir = $_[0];
   my ($division, $type, $required, $hp_min_age, $hp_max_age, $classes, @cls, @sc, $cls, $n, $c);

   %hp = ();
   open(CL, "${showdir}/high_point.txt") or do {
      print "Unable to open high point show file\n";
      exit;
   };

   while (<CL>) {
      my ($division, $type, $required, $hp_min_age, $hp_max_age, $classes) = split(/~~/, $_, 6);
      chomp($classes);
      $hp_report{$division}[0] = $type;
      $hp_report{$division}[1] = $required;
      $hp_report{$division}[2] = $classes;
      $hp_report{$division}[3] = $hp_min_age;
      $hp_report{$division}[4] = $hp_max_age;
print "DIVISION: $division   TYPE: $type   REQUIRED: $required   MIN/MAX: $hp_min_age / $hp_max_age   CLASSES: $classes\n";
   }
   close (CL);
}


##################################################################################
##################################################################################
#
#       Open the MEMBER file
#

sub open_member_file {
   %member_list = ();
   @mlist = ();
   @mlist2 = ();
   @m_n_list = ();
   open(ML, "data/${showbreed}.member.txt") or do {
      print "Unable to open member list file\n";
      exit;
   };
   chomp(@member_list = <ML>);
   close (ML);

   foreach $ii (@member_list) {
      ($mnum, $lname, $fname, $rest) = split(/~~/, $ii, 4);
      $name = "${lname}, ${fname}";
      $member_list{$mnum} = "${name}~~${rest}";
      push(@mlist, $name);
      push(@mlist2, "${name}|${mnum}");
   }

   foreach $ii (sort @mlist2) {
      $num = "      ";
      ($mname, $mnum) = split(/\|/, $ii);
      substr($num, -(length($mnum))) = $mnum;
      push(@m_n_list, "$num | $mname");
   }
}


##################################################################################
##################################################################################
#
#       Open the HORSE file
#

sub open_horse_file {
   %horse_list = ();
   @hlist = ();
   @hlist2 = ();
   @h_n_list = ();
   open(HL, "data/${showbreed}.horse.txt") or do {
      print "Unable to open horse list file\n";
      exit;
   };
   chomp(@horse_list = <HL>);
   close(HL);

   foreach $ii (@horse_list) {
      ($hnum, $htype, $name, $rest) = split(/~~/, $ii, 4);
      $horse_list{$hnum} = "${htype}~~${name}~~${rest}";
      push(@hlist, "$name");
      push(@hlist2, "${name}|${hnum}");
   }

   foreach $ii (sort @hlist2) {
      $num = "      ";
      ($hname, $hnum) = split(/\|/, $ii);
      substr($num, -(length($hnum))) = $hnum;
      push(@h_n_list, "$num | $hname");
   }
}


##################################################################################
##################################################################################
#
#       Open the SHOW INFO, CLASSES, LOCAL POINT, and HIGHPOINT files
#

sub open_showinfo_file {
   my $showdir = $_[0];

   open(SF, "${showdir}/showinfo.txt") or do {
      print "Unable to open show file: $!";
      exit;
   };
   chomp($openshowdata = <SF>);
   close(SF);

   open(SF, "${showdir}/classes.txt") or do {
      print "Unable to open show classes file: $!";
      exit;
   };
   chomp(@show_classes = <SF>);
   close(SF);

   foreach $ii (@show_classes) {
      ($mnum, $name) = split(/\) /, $ii);
      $show_class_list{$mnum} = $name;
   }

   (${showname},${showdate},${shownumber[0]},${shownumber[1]},${shownumber[2]},${shownumber[3]},${judgeinfo[0]},${judgeinfo[2]},${judgeinfo[4]},${judgeinfo[6]},${maxplace},${showbreed},${showlocation}) = split(/~~/, $openshowdata);

   &open_local_point_file($showdir);
   &open_local_class_file();

   open (BF, "${showdir}/billing.txt") or warn "Unable to open billing file: $!";
   chomp(@billing = <BF>);
   close BF;
print "Billing Info: $billing[0]\n";

   (${opencost},${nonprocost},${youthcost},${leadlinecost},${localcost},${jumpfee},${cattlefee},${o_point},${np_point},${y_point},${officefee},${stallfee1},${stallfee2},${tieoutfee},${rvfee},${shavingsfee}) = split(/~~/, $billing[0]);
}


##################################################################################
##################################################################################
#
#       Open the ENTRY file
#

sub open_entry_file {
   my $showdir = $_[0];
   my %horsecount = ();

   open(EL, "${showdir}/entry.txt") or do {
      print "Unable to open entry file: $!";
      exit;
   };
   chomp(@entry_list = <EL>);
   close(EL);

   $entry_count=0;
   %entries = ();
   foreach $ii (@entry_list) {
      my ($b, $h, $r, $rl, $c, $j) = split(/~~/, $ii);
      push (@{$entries{$c}}, $ii);
      $entry_count++ if ($c !~ /^G/);
      $horsecount{$h} = 1;
   }
   $horse_count = keys %horsecount;
print "Entry: $entry_count\n";
print "Horse: $horse_count\n";
}


##################################################################################
##################################################################################
#
#       Open the GRAND/RESERVE files
#

sub open_grand_file {
   my $showdir = $_[0];

   open(GR, "${showdir}/gr_stallion.txt") or do {
      print "Unable to open GR Stallion file: $!";
      exit;
   };
   chomp(@gs_list = <GR>);
   close(GR);

   open(GR, "${showdir}/gr_gelding.txt") or do {
      print "Unable to open GR Gelding file: $!";
      exit;
   };
   chomp(@gg_list = <GR>);
   close(GR);

   open(GR, "${showdir}/gr_mare.txt") or do {
      print "Unable to open GR Mare file: $!";
      exit;
   };
   chomp(@gm_list = <GR>);
   close(GR);
}


##################################################################################
##################################################################################
#
#       Write the ENTRY file
#

sub write_entry_file {
   my $showdir = $_[0];

   open(EL, "> ${showdir}/entry.txt") or do {
      print "Unable to open entry file: $!";
      exit;
   };

   foreach $key (sort keys %entries) {
      @e = @{$entries{$key}};
      for $ii (@e) {
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

   open(EL, "> ${showdir}/classes.txt") or do {
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
#  Check to see if the entry is already registered in the class
#
   if ($#ncl >= 0) {
      foreach $line (@ncl) {
         ($b, $h, $r, $l, $c, $j) = split(/~~/, $line);
print "Checking Back $b with Class $c against Back $backnumber in Class $class\n";
         if ($b == $backnumber && $c eq $class) {
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
   if ($cname =~ /Hackamore/) {
      $hmin = 0;   $hmax = 5;
   }

print "Rider Min = $rmin\nRider Max = $rmax\nHorse Min = $hmin\nHorse Max = $hmax\n";


#
#  Check to see if the rider is of correct age for the class
#
   my @res = grep(/^${ridernum}~/, @member_list);
print "$res[0]\n";
   my ($rnum, $rlastname, $rfirstname, $raddress, $rcity, $rstate, $rzip, $rhomephone, $rworkphone, $remail, $rsex, $ryear, $rtype, $rnumberstatus, $rexp) = split(/~~/, $res[0]);
   $ryear = $year if ($ryear eq "");
   my $age = $year - $ryear - 1;
print "Rider Birth Year: $ryear\nRider Age: $age\n";
   if (($ryear != $year) && ($age < $rmin) || ($age > $rmax)) {
      print "Rider is not of proper age\n";
      display_message("Exhibitor is not the proper age for class $class", 1, "e");
      return;
   }

#
#  Check to see if the horse is of correct age for the class
#
   my @res = grep(/^${horsenum}~/, @horse_list);
print "$res[0]\n";
   my ($hnum, $hmem, $hname, $hsex, $hyear, $hcolor, $hsire, $hdam, $ownernum) = split(/~~/, $res[0]);
   $hyear = $year if ($hyear eq "");
   my $age = $year - $hyear;
print "Horse Foal Year: $hyear\nHorse Age: $age\n";
   if (($hyear != $year) && ($age < $hmin) || ($age > $hmax)) {
      print "Horse is not of proper age\n";
      display_message("Horse is not the proper age for class $class", 1, "e");
      return;
   }


   if (-e "${showdir}/entry.txt") {
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
#  If the horse number changed, delete the old horse info
#

   if ($original_horse_num != $horsenum) {
      delete($horse_list{$original_horse_num});
   }

#
#  Replace current horse information in hash, then
#  Save the horse information
#
   my ($t,$j) = split(/ /, $horsetype);

   $horse_list{$horsenum} = "${t}~~${horsename}~~${horsesex}~~${yearfoaled}~~${horsecolor}~~${horsesire}~~${horsedam}~~${ownernum}";
   open (HI, ">data/${showbreed}.horse.txt") or die "Unable to horse information file for writing: $!";
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
#  If the owner number changed, delete the old rider info
#

   if ($original_owner_num != $ownernum) {
      delete($member_list{$original_owner_num});
   }

#
#  Save the owner information
#
#   $ownerexpdate = is_member(${ownernum});
   $member_list{$ownernum} = "${ownerlastname}, ${ownerfirstname}~~${owneraddress}~~${ownercity}~~${ownerstate}~~${ownerzip}~~${ownerhomephone}~~${ownerworkphone}~~${owneremail}~~${ownersex}~~${owneryear}~~${ownertype}~~${ownernumberstatus}~~${ownerexpdate}";
   open (HI, ">data/${showbreed}.member.txt") or die "Unable to member information file for writing: $!";
   foreach $key (sort { $a <=> $b } keys %member_list) {
      ($oname, $oinfo) = split(/~~/, $member_list{$key}, 2);
      ($olname, $ofname) = split(/, /, $oname);
      print HI "${key}~~${olname}~~${ofname}~~${oinfo}\n";
   }
   close (HI);

#
#  Display horse information
#
print "Redisplaying horse info:\n";
   my $hsex=substr($horsesex, 0, 1);
   $horseinfolabel = "Foaled: $yearfoaled  Sex: $hsex  Sire: $horsesire  Dam: $horsedam\nOwner: $ownername\nAddress : $owneraddress, $ownercity, $ownerstate $ownerzip";
print "$horseinfolabel\n";

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
#  If the rider number changed, delete the old rider info
#
   if ($original_rider_num != $ridernum) {
      delete($member_list{$original_rider_num});
   }

#
#  Save the rider information
#
#   $riderexpdate = is_member($ridernum);
   $member_list{$ridernum} = "${riderlastname}, ${riderfirstname}~~${rideraddress}~~${ridercity}~~${riderstate}~~${riderzip}~~${riderhomephone}~~${riderworkphone}~~${rideremail}~~${ridersex}~~${rideryear}~~${ridertype}~~${ridernumberstatus}~~${riderexpdate}";
   open (HI, ">data/${showbreed}.member.txt") or die "Unable to open member information file for writing: $!";
   foreach $key (sort { $a <=> $b } keys %member_list) {
      ($rname, $rinfo) = split(/~~/, $member_list{$key}, 2);
      ($rlname, $rfname) = split(/, /, $rname);
      print HI "${key}~~${rlname}~~${rfname}~~${rinfo}\n";
   }
   close (HI);
   $modify_text = "Member Info Saved";

#
#  Display new rider info
#
print "Redisplaying rider info:\n";
   my $rsex=substr($ridersex, 0, 1);
   $riderinfolabel = "Born: $rideryear  Sex: $rsex\nAddress: $rideraddress, $ridercity, $riderstate $riderzip\nExpiration: $riderexpdate";
print "$riderinfolabel\n";

#
#  Add the rider to the list
#
   &open_member_file;
}


1;

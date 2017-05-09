##################################################################################
#
#       Lookup Functions
#
##################################################################################

##################################################################################
##################################################################################
#
#  Look up a back number in the entry list based on back number.  If found,
#  display the horse number and name, and if there is more than one rider
#  listed, change the option menu to hold the names
#

sub lookup_existing_back_number {
print "lookup_existing_back_number\n";
   &open_entry_file($showdir) if (-e "${showdir}/entry.txt");
   @bnresult = grep(/^${backnumber}~~/, @entry_list);

   if ($#bnresult >= 0) {
      ($backnumber, $horsenum) = split(/~~/, $bnresult[0]);
      ($horsetype, $horsename) = split(/~~/, $horse_list{$horsenum});
   }

   undef(%rn);
   foreach (@bnresult) {
      (undef, undef, $rn, undef, undef, undef) = split(/~~/, $_);
      $rn{$rn}++;
   }

   return if ($rflag eq "IB" || $rflag eq "IE");

   @rider_names = ();
   foreach $key (sort { $a <=> $b } keys %rn) {
      ($ridername) = split(/~~/, $member_list{$key});
      my $r = sprintf "%7s : %s", $key, $ridername;
      push(@rider_names, "$r");
   }

   if (keys %rn > 1) {
print "Displaying rider list\n";
      $rl_names_lb->delete(0, 'end');
      $rl_names_lb->insert('end', @rider_names);
      if ($#rider_names <= 12) {
         $rl_names_lb->configure(-height => ($#ridernames+2));
      } else {
         $rl_names_lb->configure(-height => 12);
      }
      $rider_list_window->update();
      $rider_list_window->deiconify();
      $rider_list_window->raise();
   }
   else {
      ($ridernum,$ridername) = split(/ : /, $rider_names[0]);
      $ridernum =~ s/ //g;
   }

   find_rider_horse_info();
}


sub find_rider_horse_info {
   if (defined $horse_list{$horsenum}) {
      ($horsetype, $horsename, $horsesex, $yearfoaled, $horsecolor, $horsesire, $horsedam, $ownernum) = split(/~~/, $horse_list{$horsenum});
   }
   if (defined $member_list{$ownernum}) {
      ($ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $ownerhomephone, $ownerworkphone, $owneremail, $ownersex, $owneryear, $ownertype, $ownernumberstatus, $ownerexpdate) = split(/~~/, $member_list{$ownernum});
   }
   if (defined $member_list{$ridernum}) {
      ($ridername, $rideraddress, $ridercity, $riderstate, $riderzip, $riderhomephone, $riderworkphone, $rideremail, $ridersex, $rideryear, $ridertype, $ridernumberstatus, $riderexpdate) = split(/~~/, $member_list{$ridernum});
   }

   $hsex=substr($horsesex, 0, 1);
   $horseinfolabel = "Foaled: $yearfoaled  Sex: $hsex  Sire: $horsesire  Dam: $horsedam\nRegistration: $ownernum\nOwner: $ownername\nAddress : $owneraddress, $ownercity, $ownerstate $ownerzip\nExpiration Date: $ownerexpdate";
   $rsex=substr($ridersex, 0, 1);
   $riderinfolabel = "Born: $rideryear  Sex: $rsex\nAddress: $rideraddress, $ridercity, $riderstate $riderzip\nExpiration Date: $riderexpdate";

print "Here after rider is known...\n";

   @clist = ();
   @bnresult = grep(/^${backnumber}~~${horsenum}~~${ridernum}~~/, @entry_list);
   foreach $jj (@bnresult) {
      ($bn, $hn, $rn, undef, $cn, undef) = split(/~~/, $jj);
      push (@clist, $cn);
   }

   $backclasses = "";
   foreach $jj (sort { $a <=> $b } @clist) {
      $backclasses .= "$jj  ";
   }
}


##################################################################################
##################################################################################
#
#  Look up information when changing back numbers and riders
#


sub lookup_fromexisting_back_number {
   &open_entry_file($showdir) if (-e "${showdir}/entry.txt");
   @bnresult = grep(/^${frombacknumber}~~/, @entry_list);

   if ($#bnresult >= 0) {
      ($frombacknumber, $fromhorsenum) = split(/~~/, $bnresult[0]);
      ($fromhorsetype, $fromhorsename) = split(/~~/, $horse_list{$fromhorsenum});
   }

   undef(%rn);
   foreach (@bnresult) {
      (undef, undef, $rn, undef, undef, undef) = split(/~~/, $_);
      $rn{$rn}++;
   }

   @rider_names = ();
   foreach $key (sort { $a <=> $b } keys %rn) {
      ($fromridername) = split(/~~/, $member_list{$key});
      my $r = sprintf "%7s : %s", $key, $fromridername;
      push(@rider_names, "$r");
   }
}

sub lookup_toback_number {
   &open_entry_file($showdir) if (-e "${showdir}/entrytxt");
   my @bnresult = grep(/^${tobacknumber}~~/, @entry_list);

   if ($#bnresult >= 0) {
      $mw = MainWindow->new();
      $mw->withdraw;
      my $dialog = $mw->Dialog(-title => 'Invalid Back Number',
                  -text => "Back number $tobacknumber already exists.",
                  -buttons => [ "Ok" ]);
      my $pressed = $dialog->Show();
      $mw->focus();
      $tobacknumber = "";
   }

   $change_back_window->update();
   $tobacknumentry->focus();
}

sub lookup_torider_number {
   my $found = 0;
   &open_member_file;

   if (defined $member_list{$toridernumber}) {
      ($toridername, $j) = split(/~~/, $member_list{$toridernumber});
   }
}

sub lookup_change_entry {
   my $cn;
   my @class_entries = ();
print "In Lookup Given: Class: $classnumber Back: $backnumber\n";
   foreach $jj (@entry_list) {
      ($bn, $hn, $rn, undef, $cn, undef) = split(/~~/, $jj);
      last if ($cn eq $fromclassnumber && $bn eq $frombacknumber);
   }
   my @classinfo = grep(/^${cn}\) /, @show_classes);
   ($fromclassnum, $fromclassname) = split(/\) /, $classinfo[0]);
   $fromridernumber = $rn;
   $fromhorsenumber = $hn;
   ($fromridername, $j) = split(/~~/, $member_list{$fromridernumber});
}


##################################################################################
##################################################################################
#
#  Look up information in the entry list based on back number and class
#  number.
#

sub lookup_existing_entry {
print "In Lookup: Class: $classnumber Back: $classplace{$judge}[$place-1] Place: $place  National Points: $n_points{$classplace{$judge}[$place-1]}[$place-1]\n";

   @bnresult = grep(/^$classplace{$judge}[$place-1]~~\d~~\d~~$classnumber~~/, @entry_list);

   ($backnumber, $horsenum, $ridernum, $relation, $classnumber) = split(/~~/, $bnresult[0]);
}


##################################################################################
##################################################################################
#
#  Look up information in the entry list based on back number and class
#  number.
#

sub lookup_given_entry {
   my $cn;
   my @class_entries = ();
print "In Lookup Given: Class: $classnumber Back: $backnumber\n";
   foreach $jj (@entry_list) {
      ($bn, $hn, $rn, undef, $cn, undef) = split(/~~/, $jj);
      last if ($cn eq $classnumber && $bn eq $backnumber);
   }
   $ridernumber = $rn;
   $horsenumber = $hn;
}


##################################################################################
##################################################################################
#
#  Look up a horse in the horse list based on horse number.  If not found
#  display the window asking for horse information
#

sub lookup_horse_number {
   my $found = 0;
   &open_horse_file;
   if (defined $horse_list{$horsenum}) {
      ($horsetype, $horsename, $horsesex, $yearfoaled, $horsecolor, $horsesire, $horsedam, $ownernum) = split(/~~/, $horse_list{$horsenum});
      $found = 1;
   }

   return $found;
}


##################################################################################
##################################################################################
#
#  Look up a pending horse number
#

sub lookup_pending_horse_number {
   my $found = 0;
   my $pending = 0;
   &open_horse_file;
   foreach $key (sort keys %horse_list) {
      next if ($key !~ /^P/);
      $pending = substr($key, 1);
   }
   $pending++;
   $horsenum = "P00000";
   substr($horsenum, (length($pending)*-1)) = $pending;
   return $found;
}


##################################################################################
##################################################################################
#
#  Look up a rider in the rider list based on rider number.  If not
#  found, display the window for entering information to be saved
#

sub lookup_rider_number {
   my $found = 0;
   &open_member_file;

   if (defined $member_list{$ridernum}) {
      ($ridername, $rideraddress, $ridercity, $riderstate, $riderzip, $riderhomephone, $riderworkphone, $rideremail, $ridersex, $rideryear, $ridertype, $ridernumberstatus, $riderexpdate) = split(/~~/, $member_list{$ridernum});
      ($riderlastname, $riderfirstname) = split(/, /, $ridername);
      $found = 1;
   }

   return $found;
}


##################################################################################
##################################################################################
#
#  Look up a rider in the rider list based on a given rider number.
#

sub lookup_given_rider_number {
   my $found = 0;
   my $ridernum = $_[0];
   &open_member_file;

   if (defined $member_list{$ridernum}) {
      ($ridername, $rideraddress, $ridercity, $riderstate, $riderzip, $riderhomephone, $riderworkphone, $rideremail, $ridersex, $rideryear, $ridertype, $ridernumberstatus, $riderexpdate) = split(/~~/, $member_list{$ridernum});
      ($riderlastname, $riderfirstname) = split(/, /, $ridername);
      $found = 1;
   }

   return $found;
}


##################################################################################
##################################################################################
#
#  Look up a pending rider number
#

sub lookup_pending_rider_number {
   my $found = 0;
   my $pending = 0;
   &open_member_file;
   foreach $key (sort keys %member_list) {
      next if ($key !~ /^P/);
      $pending = substr($key, 1);
   }
   $pending++;
   $ridernum = "P00000";
   substr($ridernum, (length($pending)*-1)) = $pending;
   return $found;
}


##################################################################################
##################################################################################
#
#  Display a list of high point divisions
#

sub high_point_list {
   &open_show_high_point_file($showdir);

   $hp_names_lb->delete(0, 'end');
   foreach $key (sort keys %hp) {
      $hp_names_lb->insert('end', $key);
   }
   $hp_names_lb->configure(-width => 0);
   $hp_list_window->update();
   $hp_list_window->deiconify();
   $hp_list_window->raise();
}


##################################################################################
##################################################################################
#
#  Display a list of high point divisions
#

sub combine_list {
   $combine_names_lb->delete(0, 'end');
   foreach (@show_classes) {
      $combine_names_lb->insert('end', $_);
   }
   $combine_names_lb->configure(-width => 0);
   $combine_list_window->update();
   $combine_list_window->deiconify();
   $combine_list_window->raise();
}


1;

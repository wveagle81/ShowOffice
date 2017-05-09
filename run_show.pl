#!/perl/bin/perl -w
##################################################################################
##################################################################################
#
#       Perl/TK Horse Show Program
#
#  Run Show program:
#
##################################################################################
##################################################################################

use Tk;
require Tk::TopLevel;
require Tk::DialogBox;
require Tk::Optionmenu;
require Tk::Scrollbar;

require "common.pl";
require "read_write.pl";
require "lookup.pl";
require "run_show_toplevel.pl";
require "open_show.pl";


$showdate = $ARGV[0];
$window_type = "run";
$year = ((localtime(time))[5]) + 1900;
$main_window_label = "Show Name and Date - $year";
$relation = "Select Relationship of Owner To Exhibitor";


##################################################################################
#
#       Work with entries in the show
#
##################################################################################


&create_toplevel();


##################################################################################
##################################################################################
#
#  Display the window to open existing shows
#

&open_existing_show();

MainLoop;

exit;


##################################################################################
##################################################################################
#
#  Look up a horse in the horse list based on horse number.  If not found
#  display the window asking for horse information
#
#  If horse number is 99999, then it's a pending or unknown.  Look up the
#  last unknown and one-up it's number
#

sub check_existing_horse_number {
   return if (!$horsenum);
   local $found;
   if ($horsenum == 99999) {
      $found = &lookup_pending_horse_number;
   } else {
      $found = &lookup_horse_number;
   }

   if (!$found) {
      $horsetype = $horsename = $horsesex = $yearfoaled = $horsecolor = $horsesire = $horsedam = $ownernum = "";
      $enter_horse_window->deiconify();
      $enter_horse_window->raise();
      $newhorseentry->focus();
   } else {
      &open_entry_file($showdir) if (-e "${showdir}/entry.txt");
      foreach (@entry_list) {
         if (/^(\d{1,})~~${horsenum}~~/) {
            if ($backnumber != $1) {
               my $dialog = $msgdialog->DialogBox(-title => 'Horse Already Entered', -buttons => [ "Ok" ]);
               $dialog->add("Label", -text => "The chosen horse already has back number $1")->pack;
               $dialog->add("Label", -text => "One horse cannot have more than one back number")->pack;
               $dialog->Show();
               return;
            }
         }
      }
   }

   if (defined $member_list{$ownernum}) {
      ($ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $ownerhomephone, $ownerworkphone, $owneremail, $ownersex, $owneryear, $ownertype, $ownernumberstatus, $ownerexpdate) = split(/~~/, $member_list{$ownernum});
   }
   $hsex=substr($horsesex, 0, 1);
   $horseinfolabel = "Foaled: $yearfoaled  Sex: $hsex  Sire: $horsesire  Dam: $horsedam\nOwner: $ownername\nAddress : $owneraddress, $ownercity, $ownerstate $ownerzip\nExpiration: $ownerexpdate";
}


##################################################################################
##################################################################################
#
#  Look up a rider in the rider list based on rider number.  If not
#  found, display the window for entering information to be saved
#

sub check_existing_rider_number {
   return if (!$ridernum);
   local $found;
   if ($ridernum == 99999) {
      $found = &lookup_pending_rider_number;
   } else {
      $found = &lookup_rider_number;
#      $expdate = is_member($ridernum);   
   }

   if (!$found) {
      $ridername = $rideraddress = $ridercity = $riderstate = $riderzip = $riderhomephone = $riderworkphone = $rideremail = $ridersex = $rideryear = $ridertype = $ridernumberstatus = "";
      $enter_rider_window->deiconify();
      $enter_rider_window->raise();
      $enter_rider_window->focus();
   } else {
      $ridername = $riderlastname .", ". $riderfirstname;
      if ($ownernum == $ridernum) {
         $relation = "SELF";
      }
   }

   $rsex=substr($ridersex, 0, 1);
   $riderinfolabel = "Born: $rideryear  Sex: $rsex\nAddress: $rideraddress, $ridercity, $riderstate $riderzip\nExpiration: $riderexpdate";
}


##################################################################################
##################################################################################
#
#  Look up a owner in the rider list based on owner number.  If not
#  found, display the window for entering information to be saved
#

sub lookup_owner_number {
   my $found = 0;
   &open_member_file($showdir);
   if (defined $member_list{$ownernum}) {
      ($ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $ownerhomephone, $ownerworkphone, $owneremail, $ownersex, $owneryear, $ownertype, $ownernumberstatus, $ownerexpdate) = split(/~~/, $member_list{$ownernum});
      ($ownerlastname, $ownerfirstname) = split(/, /, $ownername);
      $found = 1;
   }

   if (!$found) {
      $ownername = $owneraddress = $ownercity = $ownerstate = $ownerzip = $ownerhomephone = $ownerworkphone = $owneremail = $ownersex = $owneryear = $ownertype = $ownernumberstatus = "";
      $enter_owner_window->deiconify();
      $enter_owner_window->raise();
      $enter_owner_window->focus();
   } else {
      $ownername = $ownerlastname .", ". $ownerfirstname;
      $ehw_os->configure(-text => $ownernumberstatus);
      $ehw_ot->configure(-text => $ownertype);
      $ehw_ox->configure(-text => $ownersex);
   }
}


##################################################################################
##################################################################################
#
#  Display the list of horses
#

sub select_horse {
   $miw_lb->delete(0, 'end');
   $miw_lb->insert('end', @h_n_list);
   $miw_lb->configure(-width => 35);
   $miw_lb->configure(-height => 25);
   $displayed = "horse";

   $name_list_window->deiconify();
   $name_list_window->raise();
   $name_list_window->focus();
}


##################################################################################
##################################################################################
#
#  Display the list of members
#

sub select_member {
   $miw_lb->delete(0, 'end');
   $miw_lb->insert('end', @m_n_list);
   $miw_lb->configure(-width => 35);
   $miw_lb->configure(-height => 25);
   $displayed = "member";

   $name_list_window->deiconify();
   $name_list_window->raise();
   $name_list_window->focus();
}


##################################################################################
##################################################################################
#
#  Look up a horse/member based on the search text.
#

sub search_name_list {
   my ($entry, $key) = @_;
   return if ($key =~ /backspace/i);
   return if ($oldsearch eq $search);

   @list = $miw_lb->get(0, 'end');
   foreach (0 .. $#list) {
      if ($list[$_] =~ /$search/i) {
         $miw_lb->see($_);
         $miw_lb->selectionClear(0, "end");
         $miw_lb->selectionSet($_);
         last;
      }
   }
   $oldsearch = $search;
}


##################################################################################
##################################################################################
#
#  Look up a horse/member based on the listbox selection.
#

sub select_name {
   $nlist = $miw_lb->get($miw_lb->curselection);
   ($num, $name) = split(/ \| /, $nlist);
   $num =~ s/ //g;

print "Selected\nList: $nlist\nNum: $num\nName: $name\n";

   if ($displayed eq "horse") {
      foreach $ii (@horse_list) {
         ($hnum, $htype, $hname, $hsex, $hfoal, $hcolor, $hsire, $hdam, $howner) = split(/~~/, $ii);
         if (($name eq $hname) && ($num eq $hnum)) {
            $horsenum = $hnum;
            $horsename = $hname;
            if (!$hfoal) {
               my $dialog = $msgdialog->DialogBox(-title => 'No Foal Year On File', -buttons => [ "Ok" ]);
               $dialog->add("Label", -text => "There is no foal year on file for this horse.")->pack;
               $dialog->add("Label", -text => "No age checking is possible for junior and halter classes.")->pack;
               $dialog->Show();
            }
            last;
         }
      }
   }
   else {
      foreach $ii (@member_list) {
         ($rnum, $rlname, $rfname, $raddress, $rcity, $rstate, $rzip, $rhphone, $rwphone, $remail, $rsex, $ryear, $rtype, $rstatus, $rexpdate) = split(/~~/, $ii);
         if (($name eq "$rlname, $rfname") && ($num eq $rnum)) {
            $ridernum = $rnum;
            $ridername = "$rlname, $rfname";
#            if (!$ryear) {
#               my $dialog = $msgdialog->DialogBox(-title => 'No Birth Year On File', -buttons => [ "Ok" ]);
#               $dialog->add("Label", -text => "There is no birth year on file for this rider.")->pack;
#               $dialog->add("Label", -text => "No age checking is possible for youth and non-pro classes.")->pack;
#               $dialog->Show();
#            }
            last;
         }
      }
   }
   $search = $oldsearch = "";

   find_rider_horse_info();

   $name_list_window->withdraw();
}


##################################################################################
##################################################################################
#
#  Save the entered horse information and then close the window
#

sub save_new_horse_info {

#
#  If horse number or name are blank, tell the user
#  they must enter data before saving a horse
#
   ($horsetype) = split(/ /, $horsetype);
print "Regtype : $horsetype\nHorsenum : $horsenum\nHorsename : $horsename\nHorsesex : $horsesex\nYearFoaled : $yearfoaled\n";
   if (($horsetype eq "") || ($horsenum eq "") || ($horsename eq "") || ($horsesex eq "") || ($yearfoaled eq "")) {
      my $dialog = $enter_horse_window->DialogBox(-title => 'Not Enough Data', -buttons => [ "Ok" ]);
      $dialog->add("Label", -text => "You did not enter enough data to save a horse")->pack;
      $dialog->add("Label", -text => "You must provide the horse's number, registration type, name, sex and year foaled")->pack;
      $dialog->Show();
      return;
   }

#
#  Save the horse information
#
   if (-e "data/${showbreed}.horse.txt") {
      open (HI, ">>data/${showbreed}.horse.txt") or die "Unable to open horse information file for appending: $!";
   } else {
      open (HI, ">data/${showbreed}.horse.txt") or die "Unable to open horse information file for writing: $!";
   }
   print HI uc("${horsenum}~~${horsetype}~~${horsename}~~${horsesex}~~${yearfoaled}~~${horsecolor}~~${horsesire}~~${horsedam}~~${ownernum}\n");
   close (HI);

#
#  Display horse information
#
print "Redisplaying horse info:\n";
   my $hsex=substr($horsesex, 0, 1);
   $horseinfolabel = "Foaled: $yearfoaled  Sex: $hsex  Sire: $horsesire  Dam: $horsedam\nOwner: $ownername\nAddress : $owneraddress, $ownercity, $ownerstate $ownerzip";
print "$horseinfolabel\n";

#
#  Reread the horse list
#
   &open_horse_file($showdir);
   $enter_horse_window->withdraw();
}

##################################################################################
##################################################################################
#
#  Save the entered owner information and then close the window
#

sub save_new_owner_info {

#
#  If owner number or name are blank, tell the user
#  they must enter data before saving a owner
#
   if (($ownernum eq "") || ($ownerfirstname eq "") || ($ownerlastname eq "")) {
      my $dialog = $new_owner_window->DialogBox(-title => 'Not Enough Data', -font => 'system 12', -buttons => [ "Ok" ]);
      $dialog->add("Label", -text => "You did not enter enough data to save a owner")->pack;
      $dialog->add("Label", -text => "You must provide the owner's number and name")->pack;
      $dialog->Show();
      return;
   }

#
#  Save the owner information
#
   if (-e "data/${showbreed}.member.txt") {
      open (HI, ">>data/${showbreed}.member.txt") or die "Unable to open member information file for appending: $!";
   } else {
      open (HI, ">data/${showbreed}.member.txt") or die "Unable to open member information file for writing: $!";
   }
   print HI uc("${ownernum}~~${ownerlastname}~~${ownerfirstname}~~${owneraddress}~~${ownercity}~~${ownerstate}~~${ownerzip}~~${ownerhomephone}~~${ownerworkphone}~~${owneremail}~~${ownersex}~~${owneryear}~~${ownertype}~~${ownernumberstatus}~~${ownerexpdate}\n");
   $ownername = "${ownerlastname}, ${ownerfirstname}";
   close (HI);

#
#  Add the owner to the list
#
   &open_member_file($showdir);
   $enter_owner_window->withdraw();
}


##################################################################################
##################################################################################
#
#  Save the entered rider information and then close the window
#

sub save_new_rider_info {

#
#  If rider number or name are blank, tell the user
#  they must enter data before saving a rider
#
   if (($ridernum eq "") || ($riderfirstname eq "") || ($riderlastname eq "")) {
      my $dialog = $new_rider_window->DialogBox(-title => 'Not Enough Data', -font => 'system 12', -buttons => [ "Ok" ]);
      $dialog->add("Label", -text => "You did not enter enough data to save a rider")->pack;
      $dialog->add("Label", -text => "You must provide the rider's number and name")->pack;
      $dialog->Show();
      return;
   }

#
#  Save the rider information
#
   if (-e "data/${showbreed}.member.txt") {
      open (HI, ">>data/${showbreed}.member.txt") or die "Unable to open member information file for appending: $!";
   } else {
      open (HI, ">data/${showbreed}.member.txt") or die "Unable to open member information file for writing: $!";
   }
   print HI uc("${ridernum}~~${riderlastname}~~${riderfirstname}~~${rideraddress}~~${ridercity}~~${riderstate}~~${riderzip}~~${riderhomephone}~~${riderworkphone}~~${rideremail}~~${ridersex}~~${rideryear}~~${ridertype}~~${ridernumberstatus}~${riderexpdate}\n");
   $ridername = "${riderlastname}, ${riderfirstname}";
   close (HI);

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
   &open_member_file($showdir);
   $enter_rider_window->withdraw();
}


##################################################################################
##################################################################################
#
#  Display the horse information and allow changes
#

sub modify_horse {
   (${horsetype}, ${horsename}, ${horsesex}, ${yearfoaled}, ${horsecolor}, ${horsesire}, ${horsedam}, ${ownernum}) = split(/~~/, $horse_list{$horsenum});
   if ($horsetype) {
      $ht->configure(-text => $horsetype);
   } else {
      $ht->configure(-text => "Select Registration Type");
   }
   if ($horsesex) {
      $hs->configure(-text => $horsesex);
   } else {
      $hs->configure(-text => "Select Horse Sex");
   }

   (${ownername}, ${owneraddress}, ${ownercity}, ${ownerstate}, ${ownerzip}, ${ownerhomephone}, ${ownerworkphone}, ${owneremail}, ${ownersex}, ${owneryear}, ${ownertype}, ${ownernumberstatus}, ${ownerexpdate}) = split(/~~/, $member_list{$ownernum});
   (${ownerlastname}, ${ownerfirstname}) = split(/, /, $ownername);
   if ($ownertype) {
      $os->configure(-text => $ownernumberstatus);
   } else {
      $os->configure(-text => "Select Registration Status");
   }
   if ($ownertype) {
      $ot->configure(-text => $ownertype);
   } else {
      $ot->configure(-text => "Select Registration Type");
   }
   if ($ownersex) {
      $ox->configure(-text => $ownersex);
   } else {
      $ox->configure(-text => "Select Owner Sex");
   }

   $modify_horse_window->deiconify();
   $modify_horse_window->raise();
}


##################################################################################
##################################################################################
#
#  Display the member information and allow changes
#

sub modify_rider {
   (${ridername}, ${rideraddress}, ${ridercity}, ${riderstate}, ${riderzip}, ${riderhomephone}, ${riderworkphone}, ${rideremail}, ${ridersex}, ${rideryear}, ${ridertype}, ${ridernumberstatus}, ${riderexpdate}) = split(/~~/, $member_list{$ridernum});
   (${riderlastname}, ${riderfirstname}) = split(/, /, $ridername);
   if ($ridernumberstatus) {
      $rs->configure(-text => $ridernumberstatus);
   } else {
      $rs->configure(-text => "Select Registration Status");
   }
   if ($ridertype) {
      $rt->configure(-text => $ridertype);
   } else {
      $rt->configure(-text => "Select Registration Type");
   }
   if ($ridersex) {
      $rx->configure(-text => $ridersex);
   } else {
      $rx->configure(-text => "Select Rider Sex");
   }

   $modify_member_window->deiconify();
   $modify_member_window->raise();
}


##################################################################################
##################################################################################
#
#  Save the class entry information to the array and
#  to the entry file
#

sub save_entry_info {
   for ($ii=0; $ii<=$#rider_class; $ii++) {
      if (defined $rider_class[$ii]) {
print "Class: ..." . $rider_class[$ii] . "...\n";
         next if ($rider_class[$ii] !~ /\w/);

         $rider_class[$ii] =~ s/ //g;
         $relation = "NONE" if ($relation =~ /^Select/);

print "Back: $backnumber\nHorse: $horsenum\nRider: $ridernum\nRelation: $relation\nClass: $rider_class[$ii]\n";

         check_rider_age($ridernum, $rider_class[$ii]);
         
         &save_one_entry($backnumber, $horsenum, $ridernum, $relation, $rider_class[$ii]);
      }
   }
   &open_entry_file($showdir);
   $current_entries_label  = "Current # Entries : " . $entry_count . "        ";
   $current_entries_label .= "Current # Horses : " . $horse_count;

   &clear_all_data;
   $backnumentry->focus();
}


##################################################################################
##################################################################################
#
#  Check the rider's age against the entered classes
#

sub check_rider_age {
   
   $ridernum = $_[0];
   $classnum = $_[1];
   
   print "Checking age for rider: $ridernum in class $classnum\n";
   
}


##################################################################################
##################################################################################
#
#  Scratch classes for an entry
#

sub scratch_entry {
   &open_entry_file($showdir) if (-e "${showdir}/entry.txt");
   for ($ii=0; $ii<=$#rider_class; $ii++) {
      next if ((!defined $rider_class[$ii]) || ($rider_class[$ii] !~ /\w/));
      $rider_class[$ii] =~ s/ //g;

      @ncl = grep !/^${backnumber}~~${horsenum}~~${ridernum}~~.*~~$rider_class[$ii]~~/, @entry_list;
      @entry_list = @ncl;
   }

   %entries = ();
   foreach $ii (@entry_list) {
      my ($b, $h, $r, $rl, $c, $j) = split(/~~/, $ii);
      push (@{$entries{$c}}, $ii);
   }
   &write_entry_file($showdir);

   &open_entry_file($showdir) if (-e "${showdir}/entry.txt");
   $current_entries_label  = "Current # Entries : " . $entry_count . "        ";
   $current_entries_label .= "Current # Horses : " . $horse_count;
   $run_show_window->update();

   &clear_all_data;
   $backnumentry->focus();
}


##################################################################################
##################################################################################
#
#  Once a rider is selected from the list, put that name in the rider button
#

sub rider_select {
print "rider_select\n";
   &open_entry_file($showdir) if (-e "${showdir}/entry.txt");
   my $rl = $rl_names_lb->get($rl_names_lb->curselection);
   $rl =~ s/ //g;
   ($ridernum, $ridername) = split(/\:/, $rl);
   $ridernum =~ s/ //g;

   find_rider_horse_info();

   $rider_list_window->withdraw();
}


##################################################################################
##################################################################################
#
#  Display the window to change an existing back number
#

sub change_back {
   $backnumber = "";
   $horsename    = "";
   $ridername    = "";
   $tobacknumber = "";

   $change_back_window->update();
   $change_back_window->deiconify();
   $change_back_window->raise();
   $change_back_window->focus();
   $frombacknumentry->focus();
}


##################################################################################
##################################################################################
#
#  Change the back number
#

sub change_back_number {
   &open_entry_file($showdir) if (-e "${showdir}/entry.txt");

   %entries = ();
   foreach $ii (@entry_list) {
      ($b, $j) = split(/~~/, $ii, 2);
      if ($b eq $frombacknumber) {
         $ii = "$tobacknumber~~$j";
      }
      push (@{$entries{$c}}, $ii);
   }
   &write_entry_file($showdir);
   &open_entry_file($showdir) if (-e "${showdir}/entry.txt");

   $change_back_window->withdraw();
}


##################################################################################
##################################################################################
#
#  Display the window to change an existing rider number
#

sub change_rider {
   $frombacknumber = "";
   $fromhorsename  = "";
   $fromridername  = "";
   $tobacknumber   = "";

   $change_rider_window->update();
   $change_rider_window->deiconify();
   $change_rider_window->raise();
   $change_rider_window->focus();
   $frombacknumentry->focus();
}


##################################################################################
##################################################################################
#
#  Change the rider number
#

sub change_rider_number {
   &open_entry_file($showdir) if (-e "${showdir}/entry.txt");

   %entries = ();
   foreach $ii (@entry_list) {
      ($b, $j) = split(/~~/, $ii, 2);
      if ($b eq $frombacknumber) {
         $ii = "$tobacknumber~~$j";
      }
      push (@{$entries{$c}}, $ii);
   }
   &write_entry_file($showdir);
   &open_entry_file($showdir) if (-e "${showdir}/entry.txt");

   $change_rider_window->withdraw();
}


##################################################################################
##################################################################################
#
#  Once classes are selected from the list, confirm selection
#

sub combine_select {
   @c_array = ();
   $confirm_list = "\n";
   @chosen = $combine_names_lb->curselection();
   foreach $entry (@chosen) {
      $chosen = $combine_names_lb->get($entry);
      ($classnumber, $classname) = split(/\) /, $chosen);
      push(@c_array, $classname);
      $confirm_list .= "$classnumber - $classname\n";
   }
   $c_confirm_list_window->update();
   $c_confirm_list_window->deiconify();
   $c_confirm_list_window->raise();
   $combine_list_window->withdraw();
}


##################################################################################
##################################################################################
#
#  Once combined classes are confirmed, show list of related
#  national classes for the new class name
#
#  @c_array contains:  selected class names
#  @class_list contains:  national #, class name
#

sub select_related {
   &open_national_class_file;

   my @r = grep(/$c_array[0]/, @class_list);
   my $compare = substr($r[0], 0, 3);
   my @cl = grep(/^$compare/, @class_list);

   $related_names_lb->delete(0, 'end');
   foreach (@cl) {
      my ($j, $c_name) = split(/~/);
      $related_names_lb->insert('end', $c_name);
   }

   $related_names_lb->configure(-width => 0);
   $related_list_window->update();
   $related_list_window->deiconify();
   $related_list_window->raise();
   $c_confirm_list_window->withdraw();
}


##################################################################################
##################################################################################
#
#  Now, combine the classes.  Steps:
#
#  1. Change last selected class name to new class name
#  2. Record class numbers to delete, and last class number
#  3. Remove other selected class names from the list
#  4. Change all entries for selected classes to first class number
#
#  $new_number   -> New combined class number
#  $new_name     -> New combined class name
#
#
sub combine_classes {
   my $new_name = $related_names_lb->get($related_names_lb->curselection);

#
#  Find existing last class in the list
#
   $last_class = $#c_array;
print "Last: $last_class\nClass: $c_array[$last_class]\n";
   foreach $count (0 .. $#show_classes) {
      ($new_number, $cnm) = split(/\) /, $show_classes[$count]);
      if ($cnm eq $c_array[$last_class]) {
         $show_classes[$count] = "${new_number}) $new_name";
         last;
      }
   }

#
#  Remove last class from the selected array
#
   pop(@c_array);

#
#  Search thru the class list and record the index and class numbers
#  of the other classes to be combined.  Put non-combined classes
#  into a new array
#
   @new_classes = ();
   @deleted_classes = ();
   foreach $count (0 .. $#show_classes) {
      ($cn, $cnm) = split(/\) /, $show_classes[$count]);
      my @res = grep(/$cnm/, @c_array);
      if ($#res < 0) {
         push(@new_classes, $show_classes[$count]);
      } else {
         push(@deleted_classes, $cn) if ($cn =~ /\d/);
      }
   }
   @show_classes = @new_classes;

#
#  Now, change the class number in the entry file for each entry
#  that is in one of the deleted classes
#
   foreach $ii (0 .. $#entry_list) {
      my ($b, $h, $r, $rl, $c, $j) = split(/~~/, $entry_list[$ii], 6);
      foreach (@deleted_classes) {
         if ($c eq $_) {
            $entry_list[$ii] = "$b~~$h~~$r~~$rl~~$new_number~~$j";
         }
      }
   }

#
#  Rebuild the entry hash
#
   %entries = ();
   foreach $ii (@entry_list) {
      my ($b, $h, $r, $rl, $c, $j) = split(/~~/, $ii);
      push (@{$entries{$c}}, $ii);
   }

#
#  Finally, write out the class list and the entry file
#
   &write_entry_file($showdir);
   &write_class_file($showdir);

   $related_list_window->withdraw();
   $combined_finish_window->deiconify();
   $combined_finish_window->raise();
}


##################################################################################
##################################################################################
#
#  Clear all data from the forms
#

sub clear_all_data {
   $backnumber = $horseinfolabel = $riderinfolabel = "";
   $horsenum = $horsetype = $horsename = $horsesex = $yearfoaled = $horsecolor = $horsesire = $horsedam = "";
   $ridernum = $ridername = $riderfirstname = $riderlastname = $rideraddress = $ridercity = $riderstate = $riderzip = $riderhomephone = $riderworkphone = $rideremail = $ridersex = $rideryear = $ridertype = $ridernumberstatus = $riderexpdate = "";
   $ownernum = $ownername = $ownerfirstname = $ownerlastname = $owneraddress = $ownercity = $ownerstate = $ownerzip = $ownerhomephone = $ownerworkphone = $owneremail = $ownersex = $owneryear = $ownertype = $ownernumberstatus = $ownerexpdate = "";

   for ($ii=0; $ii<$class_index; $ii++) { $rider_class[$ii] = ""; }
   $relation          = "Select Relationship of Owner To Exhibitor";
   $horsetype         = "Select Registration Type";
   $horsesex          = "Select Horse Sex";
   $ownernumberstatus = "Select Registration Status";
   $ownertype         = "Select Registration Type";
   $ownersex          = "Select Owner Sex";
   $ridernumberstatus = "Select Registration Status";
   $ridertype         = "Select Registration Type";
   $ridersex          = "Select Rider Sex";
   $backclasses       = "";

   $run_show_window->update();
}

1;

__END__

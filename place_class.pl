#!/perl/bin/perl -w
##################################################################################
##################################################################################
#
#       Perl/TK Horse Show Program
#
#  Place a Class
#
#  Display a window with classes and a blank class number field.
#  When "Ok" is clicked, display a window with placing blocks for each
#     judge.
#  As each back number is entered, check it against the entries in the
#     class.  If not in the class, ask to add it or ignore
#  If add, look up the back number and add the entry
#  Once all are in and the user clicks Ok, calculate National points
#     and update the entry file
#
##################################################################################
##################################################################################

use Tk;
require Tk::Event;
require Tk::TopLevel;
require Tk::Dialog;
require Tk::DialogBox;

require "common.pl";
require "lookup.pl";
require "read_write.pl";
require "place_class_toplevel.pl";
require "open_show.pl";


$showdate = $ARGV[0];
$classnumber = "";
$window_type = "place";
$showdate = $ARGV[0] if ($#ARGV > -1);
$year = ((localtime(time))[5]) + 1900;
$main_window_label = "Show Name and Date - $year";

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
#  Given a class number, display the class placing window
#

sub place_class {
   &open_showinfo_file($showdir);
   &open_entry_file($showdir);
   &open_member_file;
   &open_horse_file;

   if (!$classnumber) {
      $chosen = $class_lb->get($class_lb->curselection);
      if ($chosen =~ /Grand/) {
         $classname = $chosen;
         $choose_class_window->withdraw();
         $place_gr_window->update();
         $place_gr_window->deiconify();
         $place_gr_window->raise();
         $place_gr_window->focusForce;
         $pgr_frame[0]->focusForce;
         $pgr_frame[0]->focusNext;
         return;
      } else {
         ($classnumber, $cname) = split(/\) /, $chosen);
         ($classname) = split(/~~/, $cname);
      }
   } else {
      $cname = $show_class_list{$classnumber};
      ($classname) = split(/~~/, $cname);
   }

   @backs = ();
   @class_entries = ();
   $entrieslabel2 = "";
   $total_class_entries = 0;
   foreach $ii (@entry_list) {
      ($back, undef, undef, undef, $cn, undef) = split(/~~/, $ii);
      if ($cn eq $classnumber) {
         $total_class_entries++;
         push(@class_entries, $ii);
         push(@backs, $back);
      }
   }

   $count = 0;
   foreach $ii (sort { $a <=> $b } @backs) {
      if ($count % 15 == 0 && $count > 0) { $entrieslabel2 .= "\n"; };
      $entrieslabel2 .= $ii . ", ";
      $count++;
   }
   chop($entrieslabel2);
   chop($entrieslabel2);
   $entrieslabel = "Class Entries ($total_class_entries): ";

   if ($total_class_entries == 1) {
      ($back, undef, undef, undef, undef, undef) = split(/~~/, $class_entries[0]);
      for $judge (0 .. $numjudges-1) {
         $classplace{$judge}[0] = $back;
      }
   }

   $choose_class_window->withdraw();
   $place_class_window->update();
   $place_class_window->deiconify();
   $place_class_window->raise();
   $place_class_window->focusForce;
   $pcw_frame[0]->focusForce;
   $pcw_frame[0]->focusNext;
}


##################################################################################
##################################################################################
#
#  Display the window for adding ties
#

sub add_tie_info {
   foreach $key (keys %classtie) {
      foreach $ii (0 .. 2) { $classtie{$key}[$ii] = ""; }
   }
   $tie_window->update();
   $tie_window->deiconify();
   $tie_window->raise();
}


##################################################################################
##################################################################################
#
#  Check to see if a back number is registered in a class,
#  and check to see if it was already given a place
#

sub check_entry {
   for $judge (0 .. $numjudges-1) {
      local %already_placed = ();
      for $place (0 .. $maxplaces-1) {
         if ($classplace{$judge}[$place]) {
            if (!$already_placed{$classplace{$judge}[$place]}) {
               $already_placed{$classplace{$judge}[$place]}++;
            } else {
               $mw = MainWindow->new();
               $mw->withdraw;
               $dialog = $mw->Dialog(-title => 'Invalid Entry',
                           -text => "Back number $classplace{$judge}[$place] already placed for this judge", -buttons => [ "Ok" ]);
               $pressed = $dialog->Show();
               $classplace{$judge}[$place] = "";
               next;
            }

            if (!grep /^$classplace{$judge}[$place]~~/, @class_entries) {
               $mw = MainWindow->new();
               $mw->withdraw;
               my $dialog = $mw->Dialog(-title => 'Invalid Entry',
                           -text => "Back number $classplace{$judge}[$place] is not registered for this class\nClick 'Add' to add this entry, or 'Ok' to ignore",
                           -buttons => [ "Add", "Ok" ]);
               my $pressed = $dialog->Show();

               if ($pressed eq "Add") {
                  $backnumber = $classplace{$judge}[$place];
                  &lookup_existing_back_number();
               } else {
                  $classplace{$judge}[$place] = "";
               }
            }
         }
      }
   }
}


##################################################################################
##################################################################################
#
#  If the user presses Insert key while placing a class, copy the
#  placings from the previous judge and place to the current judge
#  and place
#

sub fill_placing {
   for $judge (1 .. $numjudges-1) {
      for $place (0 .. $maxplaces-1) {
         if ($classplace{$judge-1}[$place]) {
            $classplace{$judge}[$place] = $classplace{$judge-1}[$place];
            $place_class_window->update();
         }
      }
   }
}


##################################################################################
##################################################################################
#
#  Calculate National points for each place, and save that info
#  in the entry file
#

sub save_placing_info {
print "Class: $classnumber  # Entries: $total_class_entries\n";
   if ($showbreed eq "appaloosa") {
      if ($total_class_entries <= 1)   { @natpoints = ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ); }   elsif
         ($total_class_entries <= 2)   { @natpoints = ( 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 7)   { @natpoints = ( 1, 0.5, 0, 0, 0, 0, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 12)  { @natpoints = ( 2, 1, 0.5, 0, 0, 0, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 17)  { @natpoints = ( 3, 2, 1, 0.5, 0, 0, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 22)  { @natpoints = ( 4, 3, 2, 1, 0.5, 0, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 27)  { @natpoints = ( 5, 4, 3, 2, 1, 0.5, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 999) { @natpoints = ( 6, 5, 4, 3, 2, 1, 0.5, 0, 0, 0 ); }
   }

   if ($showbreed eq "buckskin") {
      if ($total_class_entries <= 2)   { @natpoints = ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 5)   { @natpoints = ( 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 8)   { @natpoints = ( 2, 1, 0, 0, 0, 0, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 11)  { @natpoints = ( 3, 2, 1, 0, 0, 0, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 14)  { @natpoints = ( 4, 3, 2, 1, 0, 0, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 17)  { @natpoints = ( 5, 4, 3, 2, 1, 0, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 999) { @natpoints = ( 6, 5, 4, 3, 2, 1, 0, 0, 0, 0 ); }
   }

   if ($showbreed eq "nsba") {
      if ($total_class_entries <= 1)   { @natpoints = ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ); }   elsif
         ($total_class_entries <= 2)   { @natpoints = ( 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 7)   { @natpoints = ( 1, 0.5, 0, 0, 0, 0, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 12)  { @natpoints = ( 2, 1, 0.5, 0, 0, 0, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 17)  { @natpoints = ( 3, 2, 1, 0.5, 0, 0, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 22)  { @natpoints = ( 4, 3, 2, 1, 0.5, 0, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 27)  { @natpoints = ( 5, 4, 3, 2, 1, 0.5, 0, 0, 0, 0 ); } elsif
         ($total_class_entries <= 999) { @natpoints = ( 6, 5, 4, 3, 2, 1, 0.5, 0, 0, 0 ); }
   }

#
#  Open the entry file, and set the placing information for
#  each entry in the class
#
   &open_entry_file($showdir) if (-e "${showdir}/entry.txt");
   for $ii (0 .. $#{$entries{$classnumber}}) {
      my (@entryinfo) = split(/~~/, ${$entries{$classnumber}}[$ii], 6);
print "Entry[0]: $entryinfo[0]\n";
print "Entry[1]: $entryinfo[1]\n";
print "Entry[2]: $entryinfo[2]\n";
print "Entry[3]: $entryinfo[3]\n";
print "Entry[4]: $entryinfo[4]\n";
print "Entry[5]: $entryinfo[5]\n\n";
      $entryinfo[5] = "~~0~~F~~0~~0~~F~~0~~0~~F~~0~~0~~F~~0";
      ${$entries{$classnumber}}[$ii] = "$entryinfo[0]~~$entryinfo[1]~~$entryinfo[2]~~$entryinfo[3]~~$entryinfo[4]$entryinfo[5]";
   }

#
#  Calculate NATIONAL points for each entry in the class, then add that
#  information to the class entry
#
   my %n_points = ();
   my $j_index = 5;
   for $judge (0 .. $numjudges-1) {
      my $tieplace = 0;

      for $place (1 .. $maxplaces) {
         my $backentry = $classplace{$judge}[$place-1];
         next if (!$backentry);

         for $ii (@{$entries{$classnumber}}) {
            if (($classplace{$judge}[$place-1]) &&
                ($ii =~ /^$backentry~~/)) {

               my (@entryinfo) = split(/~~/, $ii);
               $entryinfo[$j_index] = $place;
               $entryinfo[$j_index+1] = "F";
               $entryinfo[$j_index+2] = $natpoints[$place-1];
               $ii = join("~~", @entryinfo);

               last;
            }
         }
      }
      $j_index += 3;
   }

#
#  Write out the entry file, then read it in again?
#
   &write_entry_file($showdir);
   &open_entry_file($showdir);

#
#  Clear out the previous placings
#
   for $judge (0 .. $numjudges-1) {
      for $place (0 .. $maxplaces-1) {
         $classplace{$judge}[$place] = "";
      }
   }
   $classnumber = "";
   $choose_class_window->update();
   $place_class_window->update();

   $choose_class_window->deiconify();
   $choose_class_window->raise();
   $place_class_window->withdraw();
}


##################################################################################
##################################################################################
#
#  Calculate National points for each place (figuring out number of horses in each
#  halter class type for that Grand and Reserve place), and save that info
#  in the grand and reserve champion file
#

sub save_gr_placing_info {
#   if ($total_class_entries <= 1)   { @natpoints = ( 0, 0, 0, 0, 0, 0, 0 ); }   elsif
#      ($total_class_entries <= 2)   { @natpoints = ( 0.5, 0, 0, 0, 0, 0, 0 ); } elsif
#      ($total_class_entries <= 7)   { @natpoints = ( 1, 0.5, 0, 0, 0, 0, 0 ); } elsif
#      ($total_class_entries <= 12)  { @natpoints = ( 2, 1, 0.5, 0, 0, 0, 0 ); } elsif
#      ($total_class_entries <= 17)  { @natpoints = ( 3, 2, 1, 0.5, 0, 0, 0 ); } elsif
#      ($total_class_entries <= 22)  { @natpoints = ( 4, 3, 2, 1, 0.5, 0, 0 ); } elsif
#      ($total_class_entries <= 27)  { @natpoints = ( 5, 4, 3, 2, 1, 0.5, 0 ); } elsif
#      ($total_class_entries <= 999) { @natpoints = ( 6, 5, 4, 3, 2, 1, 0.5 ); }

#
#  Find which classes compose this Grand/Reserve class
#
   if ($classname =~ /stallion/i) {  $classnumber = "GS";  $file = "gr_stallion.txt";  }
   if ($classname =~ /gelding/i)  {  $classnumber = "GG";  $file = "gr_gelding.txt";   }
   if ($classname =~ /mare/i)     {  $classnumber = "GM";  $file = "gr_mare.txt";      }
   if ($classname =~ /stallion/i && $classname =~ /open/i) {  $classnumber = "OS";  $file = "op_stallion.txt";  }
   if ($classname =~ /gelding/i  && $classname =~ /open/i) {  $classnumber = "OG";  $file = "op_gelding.txt";   }
   if ($classname =~ /mare/i     && $classname =~ /open/i) {  $classnumber = "OM";  $file = "op_mare.txt";      }
   if ($classname =~ /color/i    && $classname =~ /open/i) {  $classnumber = "OC";  $file = "op_color.txt";      }

   open (GR, "${showdir}/${file}") or do {
      print "Unable to open file ${showdir}/${file}: $!\n";
      return;
   };
   chomp(@gr_classes = <GR>);
   close(GR);

print "\n\nClasses in G/R: @gr_classes\n";


#
#  Now, find out how large the largest of these classes was,
#  and create a hash with just the back numbers that were
#  in those classes
#
#  In this hash entry we need to save the entry's number of
#  points earned because for Grand and Reserve they only get
#  the number of points necessary to take them to the max points
#  for the sex class plus 1 (grand) or 1/2 (reserve).
#
   &open_entry_file($showdir) if (-e "${showdir}/entry.txt");

   $nclass = 0;
   $large = 0;
   @grclasses = ();
   undef(%grentries);
   foreach $class (@gr_classes) {
      if ($entries{$class}) {
         $class_entries = $#{$entries{$class}} + 1;
print "For class $class, num entries was ", $class_entries, "\n";
         $nclass++ if ($class_entries > 0);
         if ($class_entries > 0) {
            $nclass++;
            foreach $ii (@{$entries{$class}}) {
print "Checking: $ii\n";
               ($bnum, $hnum, $rnum, undef, $cnum, $place1, $tie1, $points1, $place2, $tie2, $points2, $place3, $tie3, $points3, $place4, $tie4, $points4) = split(/~~/, $ii);
               $grback{$bnum} = "${hnum}~~${rnum}~~${place1}~~${points1}~~${place2}~~${points2}~~${place3}~~${points3}~~${place4}~~${points4}";
print "GRBack $bnum: $grback{$bnum}\n";
            }
         }
         $large = $class_entries if ($large < $class_entries);
      }
   }

print "Number of classes with at least one entry = $nclass\n";
print "Large = $large\n";

   if (($showbreed eq "appaloosa") && (($nclass == 1) && ($large <= 1))) {
      print "No points awarded in this class\n";
      return;
  }

   if ($showbreed eq "appaloosa") {
      if ($large <= 1)   { @natpoints = ( 1,   0.5 ); } elsif
         ($large <= 2)   { @natpoints = ( 1.5, 1.0 ); } elsif
         ($large <= 7)   { @natpoints = ( 2,   1.5 ); } elsif
         ($large <= 12)  { @natpoints = ( 3,   2.5 ); } elsif
         ($large <= 17)  { @natpoints = ( 4,   3.5 ); } elsif
         ($large <= 22)  { @natpoints = ( 5,   4.5 ); } elsif
         ($large <= 27)  { @natpoints = ( 6,   5.5 ); } elsif
         ($large <= 999) { @natpoints = ( 7,   6.5 ); }
   } else {
      $natpoints[0] = 2;
      $natpoints[1] = 1;
   }

   print "Grand: $natpoints[0]   \tReserve: $natpoints[1]\n";

foreach $key (sort keys %grback) {
   print "Back In Class: $key .. $grback{$key}\n";
}

#
#  Since the entries hash is empty for Grand/Reserve classes, we
#  have to fill it with those entries who placed under each judge
#
#  For each judge, look at the back numbers they placed
#  Get the entry information for that back number,
#     Split out the fields
#     Add to the entries hash
#
#print "1 Class: $classnumber   \tJudges: $numjudges\n";
   undef(%grentry);
   for $judge (0 .. $numjudges-1) {
      for $place (1 .. 2) {
         $back = $classplace{$judge}[$place-1];
#print "Back: $back\n";
#print "Line: $grback{$back}\n";
         ($hnum, $rnum, $eplace1, $epoints1, $eplace2, $epoints2, $eplace3, $epoints3, $eplace4, $epoints4) = split(/~~/, $grback{$back});
         $found = 0;
         for $ii (0 .. $#{$entries{$classnumber}}) {
#print "2 Class: $entries{$classnumber}[$ii]\n";
            ($bn, $hn, $rn, $j, $cn) = split(/~~/, $entries{$classnumber}[$ii], 5);
#            $entries{$classnumber}[$ii] = "${bn}~~${hn}~~${rn}~~~~${cn}";
#print "Entries: $entries{$classnumber}[$ii]\n";
            $found = 1 if ($entries{$classnumber}[$ii] =~ /^$back~~/);
         }
         if (!$found) {
            $num1 = $#{$entries{$classnumber}} + 1;
            $entries{$classnumber}[$num1] = "$back~~$hnum~~$rnum~~$large~~$classnumber~~$eplace1~~$epoints1~~$eplace2~~$epoints2~~$eplace3~~$epoints3~~$eplace4~~$epoints4~~";
#print "Adding: $entries{$classnumber}[$num1]\n";
         }
      }
   }

for $ii (0 .. $#{$entries{$classnumber}}) {
   print "Debug Entry: $entries{$classnumber}[$ii]\n";
}

#
#  Calculate NATIONAL points for each entry in the class, then append that
#  information to the class entry
#

   undef(%n_points);
   for $judge (0 .. $numjudges-1) {
print "\nJudge: $judge\n";
      for $ii (0 .. $#{$entries{$classnumber}}) {
         ($b, $hn, $rn, $j, $c, $pl[0], $p[0], $pl[1], $p[1], $pl[2], $p[2], $pl[3], $p[3]) = split(/~~/, $entries{$classnumber}[$ii]);

         $placed = 0;
         $n_points = 0;
         for $place (1 .. 2) {
            if ($classplace{$judge}[$place-1]) {
               if ($b == $classplace{$judge}[$place-1]) {
print "Back: $b\nGR Place: $place\nGR Points: $natpoints[$place-1]\nPlace: $pl[0] / $p[0]\nPlace: $pl[1] / $p[1]\nPlace: $pl[2] / $p[2]\nPlace: $pl[3] / $p[3]\n\n";
                  $placed = $place;
                  $n_points = 2 if ($place == 1);
                  $n_points = 1 if ($place == 2);
               }
            }
         }
print "Class: $classnumber Back: $b National Points: $n_points\n";
         $newentries{$classnumber}[$ii] .= "~~$placed~~F~~$n_points";
      }
   }

print "CLASS: $classnumber\n@{$entries{$classnumber}}\n";
   for $ii (0 .. $#{$entries{$classnumber}}) {
      ($b, $hn, $rn, $j, $c) = split(/~~/, $entries{$classnumber}[$ii]);
      $entries{$classnumber}[$ii] = "$b~~$hn~~$rn~~$j~~${c}$newentries{$classnumber}[$ii]";
      print "Line: $entries{$classnumber}[$ii]\n";
   }

   &write_entry_file($showdir);
   &open_entry_file($showdir);


#
#  Clear out the previous placings
#
   for $judge (0 .. $numjudges-1) {
      for $place (0 .. $maxplaces-1) {
         $classplace{$judge}[$place] = "";
      }
   }
   $classnumber = "";
   $choose_class_window->update();
   $place_gr_window->update();

   $choose_class_window->deiconify();
   $choose_class_window->raise();
   $place_gr_window->withdraw();
}


##################################################################################
##################################################################################
#
#  Once a rider is selected from the list, put that name on the window label
#  and put their classes in the class listbox
#

sub rider_select {
   ($ridernum, $ridername) = split(/ : /, $rl_names_lb->get($rl_names_lb->curselection));
   $rider_list_window->withdraw();
   &save_one_entry($classnumber);
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
   if (($regtype eq "") || ($horsenum eq "") || ($horsename eq "") || ($horsesex eq "") || ($yearfoaled eq "")) {
      $dialog = $new_horse_window->DialogBox(-title => 'Not Enough Data', -font => 'system 12', -buttons => [ "Ok" ]);
      $dialog->add("Label", -text => "You did not enter enough data to save a horse")->pack;
      $dialog->add("Label", -text => "You must provide the horse's number, registration type, name, sex and year foaled")->pack;
      $dialog->Show();
      return;
   }

#
#  Save the horse information
#
   &lock_file("horse");
   if (-e "data/horse.txt") {
      open (HI, ">>data/horse.txt") or die "Unable to horse information file for appending: $!";
   } else {
      open (HI, ">data/horse.txt") or die "Unable to horse information file for writing: $!";
   }
   print HI "${horsenum}~~${regtype}~~${horsememberstatus}~~${horsename}~~${horsesex}~~${yearfoaled}~~${horsecolor}~~${horsesire}~~${horsedam}~~${ownernum}\n";
   close (HI);
   &unlock_file("horse");

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

sub save_owner_info {

#
#  If owner number or name are blank, tell the user
#  they must enter data before saving a owner
#
   if (($ownernum eq "") || ($ownername eq "")) {
      $dialog = $new_owner_window->DialogBox(-title => 'Not Enough Data', -font => 'system 12', -buttons => [ "Ok" ]);
      $dialog->add("Label", -text => "You did not enter enough data to save a owner")->pack;
      $dialog->add("Label", -text => "You must provide the owner's number and name")->pack;
      $dialog->Show();
      return;
   }

#
#  Save the owner information
#
   &lock_file("member");
   if (-e "data/member.txt") {
      open (HI, ">>data/member.txt") or die "Unable to member information file for appending: $!";
   } else {
      open (HI, ">data/member.txt") or die "Unable to member information file for writing: $!";
   }
   print HI "${ownernum}~~${ownermemberstatus}~~${ownerlastname}~~${ownerfirstname}~~${owneraddress}~~${ownercity}~~${ownerstate}~~${ownerzip}~~${ownerhomephone}~~${ownerworkphone}~~${owneremail}~~~~${ownernumberstatus}\n";
   close (HI);
   &unlock_file("member");

#
#  Add the owner to the list
#
   &open_member_file($showdir);
   $new_owner_window->withdraw();
}


##################################################################################
##################################################################################
#
#  Save the entered rider information and then close the window
#

sub save_rider_info {

#
#  If rider number or name are blank, tell the user
#  they must enter data before saving a rider
#
   if (($ridernum eq "") || ($ridername eq "")) {
      $dialog = $new_rider_window->DialogBox(-title => 'Not Enough Data', -font => 'system 12', -buttons => [ "Ok" ]);
      $dialog->add("Label", -text => "You did not enter enough data to save a rider")->pack;
      $dialog->add("Label", -text => "You must provide the rider's number and name")->pack;
      $dialog->Show();
      return;
   }

#
#  Save the rider information
#
   &lock_file("member");
   if (-e "data/member.txt") {
      open (HI, ">>data/member.txt") or die "Unable to open member information file for appending: $!";
   } else {
      open (HI, ">data/member.txt") or die "Unable to open member information file for writing: $!";
   }
   print HI "${ridernum}~~${ridermemberstatus}~~${riderlastname}~~${riderfirstname}~~${rideraddress}~~${ridercity}~~${riderstate}~~${riderstate}~~${riderzip}~~${riderhomephone}~~${riderworkphone}~~${rideremail}~~${ridersex}~~${regtype}\n";
   close (HI);
   &unlock_file("member");

#
#  Add the rider to the list
#
   &open_member_file($showdir);
   $enter_rider_window->withdraw();
}

1;

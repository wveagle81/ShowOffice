#!/perl/bin/perl
##################################################################################
##################################################################################
#
#       Perl/TK Horse Show Program
#
#  Create Show program:
#
#  1. Manage Show Setup
#  2. Entry Processing
#  3. Placings
#  4. Reports
#  5. Options
#  6. Exit
#
##################################################################################
##################################################################################

use Tk;
use Tk::Optionmenu;
use File::Copy;
require Tk::Event;
require Tk::TopLevel;
require Tk::DialogBox;

require "common.pl";
require "read_write.pl";
require "create_show_toplevel.pl";
require "open_show.pl";

%hp = ();

$showdate = $ARGV[0];
$year = ((localtime(time))[5]) + 1900;
$main_window_label = "Show Name and Date - $year";
$show_class_index = 0;
$hp_required = 1;
$window_type = "create";

##################################################################################
#
#       Create The New Show
#
##################################################################################

##################################################################################
##################################################################################
#
#  Create the windows
#

&create_toplevel();

##################################################################################
##################################################################################
#
#  Check to see if a show date was given beforehand
#

&check_date_format if ($showdate);

##################################################################################
##################################################################################
#
#  Display the window to create a new show
#

&clear_show_info;

$new_show_window->deiconify();
$new_show_window->raise();
$new_show_window->focus();
$shownameentry->focus();

MainLoop;

exit;


##################################################################################
##################################################################################
#
#  Check to make sure the date is in the proper format
#  If not, display dialog box and tell the user
#

sub lookup_show {

#
# See if a show for that date exists.  If it does, retrieve the
# show and display the data
#
   my $sd = $showdate;
   $sd =~ s/\///g;
   if (-e "show/${sd}/showinfo.txt") {
      open_showinfo_file("show/$sd");

#
# Fill in judges
#
      &open_judge_file;
      if ($judgeinfo[0]) {
         $j_select_lb->insert('end', "$judge_list{$judgeinfo[0]} : $judgeinfo[0]");
      }
      if ($judgeinfo[2]) {
         $j_select_lb->insert('end', "$judge_list{$judgeinfo[2]} : $judgeinfo[2]");
      }
      if ($judgeinfo[4]) {
         $j_select_lb->insert('end', "$judge_list{$judgeinfo[4]} : $judgeinfo[4]");
      }
      if ($judgeinfo[6]) {
         $j_select_lb->insert('end', "$judge_list{$judgeinfo[6]} : $judgeinfo[6]");
      }

#
# Fill in selected class list
#
      &open_national_class_file;
      &open_division_file;
      &open_local_class_file;
      &read_grand_reserve_files;

      $cl_select_lb->delete(0, 'end');
      $cl_select_lb->insert('end', @show_classes);
      ($show_class_index) = split(/\)/, $show_classes[$#show_classes]);
print "Index: $show_class_index\n";
print "Class: $show_classes[$#show_classes]\n";
#      $show_class_index++;
      $showdir = "show/$sd";

#
# Read the high point file and populate the window
#
      &open_show_high_point_file("show/$sd");
   }
}


##################################################################################
##################################################################################
#
#  Look up a judge in the judge list based on judge number
#

sub lookup_judge_number {
   my $chosen = $judges_lb->get($judges_lb->curselection);
   my ($jname, $jnum) = split(/\s{2,}/, $chosen);

   my $found = 0;
   for ($index=0; $index<=$#judgeinfo; $index+=2) {
      if ($judgeinfo[$index] eq $jnum) {
         $judgeinfo[$index] = "";
         $judgeinfo[$index+1] = "";
         $found = 1;
         last;
      }
   }

   if (!$found) {
   for ($index=0; $index<=$#judgeinfo; $index+=2) {
         if (!$judgeinfo[$index]) {
            $judgeinfo[$index] = $jnum;
            $judgeinfo[$index+1] = $jname;
            last;
         }
      }
   }
}


##################################################################################
##################################################################################
#
#  Look up a judge based on the search text.
#

sub search_judge_list {
   my ($entry, $key) = @_;
   return if ($key =~ /backspace/i);

print "Input search character: $key\n";

   @list = $judges_lb->get(0, 'end');
   foreach (0 .. $#list) {
print "Searching for $key in list entry $_ : $list[$_]\n";
      if ($list[$_] =~ /^$key/i) {
         $judges_lb->see($_);
         $judges_lb->selectionClear(0, "end");
         last;
      }
   }
}


##################################################################################
##################################################################################
#
#  Display the judge select window and fill in the list
#

sub do_select_judges {
   &open_judge_file;

   $judges_lb->delete(0, 'end');
   foreach $key (sort keys %judge_name) {
      $judges_lb->insert('end', "$key : $judge_name{$key}");
   }

   $judge_window->update();
   $judge_window->deiconify();
   $judge_window->raise();
}


##################################################################################
##################################################################################
#
#  If a judge is selected from the List, add it to the Selected
#  Judge List
#

sub judge_select {
   my @selected = $judges_lb->curselection;
   my $selected = $judges_lb->get($selected[0]);
   $j_select_lb->insert('end', $selected);
   $j_select_lb->see('end');
}


##################################################################################
##################################################################################
#
#  If a judge is selected from the Selected Judge List, delete it from
#  the list
#

sub judge_delete {
   my @selected = $j_select_lb->curselection;
   $j_select_lb->delete($selected[0]);
}


##################################################################################
##################################################################################
#
#  Display the class select window and fill in the division list
#

sub do_select_classes {
   &open_national_class_file;
   &open_division_file;
   &open_local_class_file;
   &read_grand_reserve_files;

   foreach $ii (@division_list) {
      if ($ii =~ /^D/) {
         chomp($division{$dname}) if (defined $division{$dname});
         ($dn, $dname) = split(/~/, $ii);
      }
      else {
         $ii =~ s/~/ =\> /;
         $division{$dname} .= "$ii:";
      }
   }
   chop($division{$dname}) if (defined $division{$dname});

   @local = ();
   foreach $ii (@local_class_list) {
      ($num, $yn, $name) = split(/~/, $ii);
      $local{$name} = $num;
      push (@local, $name);
   }

   foreach $ii (sort keys %division) { $cl_div_lb->insert('end', $ii); }
   $cl_local_lb->delete(0, 'end');
   $cl_local_lb->insert('end', @local);

   $cl_window->update();
   $cl_window->deiconify();
   $cl_window->raise();
}


##################################################################################
##################################################################################
#
#  If a division is selected from the Division List, get the list of
#  classes from the hash and insert them into the scrolled list
#

sub division_display {
   @classes = ();
   $cl_class_lb->delete(0, 'end');

   @selected = $cl_div_lb->curselection;
   $divname = $cl_div_lb->get($selected[0]);

   (@classes) = split(/:/, $division{$divname});
   foreach $ii (@classes) {
      ($clnum, $clname) = split(/ =\> /, $ii);
      $cl_class_lb->insert('end', $clname);
   }
}


##################################################################################
##################################################################################
#
#  If a class is selected from the Division Class List, add it to the
#  Selected Class List, inserting the current index in front of
#  the name first
#

sub division_class_select {
   my @selected = $cl_class_lb->curselection;
   my $cl = $cl_class_lb->get($selected[0]);
   $show_class_index++;
   $selected = "${show_class_index}) $cl";
   $cl_select_lb->insert('end', $selected);
   $cl_select_lb->see('end');
}


##################################################################################
##################################################################################
#
#  If a class is selected from the Local Class List, add it to the
#  Selected Class List, inserting the current index in front of
#  the name first
#

sub local_class_select {

   @selected = $cl_local_lb->curselection;
   $cl = $cl_local_lb->get($selected[0]);
   foreach $ii (@local_class_list) {
      ($num, $yn, $name) = split(/~/, $ii);
      if ($name eq $cl) {
         if ($yn eq "Y") {
            $show_class_index++;
            $selected = "${show_class_index}) $cl";
         } else {
            $selected = $cl;
         }
      }
   }
   $cl_select_lb->insert('end', $selected);
   $cl_select_lb->see('end');
}


##################################################################################
##################################################################################
#
#  If a class is selected from the Selected Class List, delete it from
#  the list and decrement the current index
#

sub select_class_select {
   @selected = $cl_select_lb->curselection;
   $show_class_index-- if ($cl_select_lb->get($selected[0]) =~ /^\d/);
   $cl_select_lb->delete($selected[0]);
}


##################################################################################
##################################################################################
#
#  Save the entered show information and then close the new
#  show window
#

sub save_show_info_ok {

#
#  If show name, date, or number is blank, tell the user
#  they must enter data before saving a show
#
print "Show Name: $showname\n";
print "Show Date: $showdate\n";
print "Show Num : $shownumber[0]\n";
print "Judge Num: ", $j_select_lb->size(), "\n";
print "Max Place: $maxplace\n";
print "Classes  : ", $cl_select_lb->size(), "\n";

   if (($showname eq "") || ($showdate eq "") || ($shownumber[0] eq "") ||
       ($maxplace eq "") || ($j_select_lb->size() <= 0) || ($cl_select_lb->size() <= 0)) {
      my $dialog = $new_show_window->DialogBox(-title => 'Not Enough Data', -buttons => [ "Ok" ]);
      $dialog->add("Label", -text => "You did not enter enough data to establish a show")->pack;
      $dialog->add("Label", -text => "You must provide all fields, including a class list and")->pack;
      $dialog->add("Label", -text => "at least one show number and one judge.")->pack;
      $dialog->Show();
      return;
   }

#
#  Make directory for show - base dir name on show date
#
   my $showdir = $showdate;
   $showdir =~ s/\///g;
   if (! -d "show/$showdir") {
      mkdir ("show/$showdir", 0750) or die "Unable to make show directory $showdir: $!";
   }

#
#  Copy necessary files
#
   copy("data/${showbreed}.local_points.txt", "show/${showdir}/local_points.txt") if (! -f "show/${showdir}/local_points.txt");
   copy("data/empty.txt", "show/${showdir}/entry.txt") if (! -f "show/${showdir}/entry.txt");

#
#  Get the judge information
#
   @judgeinfo = ();
   my @jlist = $j_select_lb->get(0, 'end');
   foreach $line (@jlist) {
print "Judge Info: $line\n";
      ($jname, $jnum) = split(/ : /, $line);
print "Judge Name: $jname\n";
print "Judge Num : $jnum\n";
      push(@judgeinfo, $jnum);
   }

#
#  Save the show information
#
   open (C1, ">show/${showdir}/showinfo.txt") or die "Unable to create show information file: $!";
   print C1 "${showname}~~${showdate}~~${shownumber[0]}~~${shownumber[1]}~~${shownumber[2]}~~${shownumber[3]}~~${judgeinfo[0]}~~${judgeinfo[1]}~~${judgeinfo[2]}~~${judgeinfo[3]}~~${maxplace}~~${showbreed}~~${showlocation}\n";
   close (C1);

#
#  Save the class information
#
   open (C1, ">show/$showdir/classes.txt") or die "Unable to create show class file: $!";
   open (CS, ">show/$showdir/gr_stallion.txt") or die "Unable to create grand/reserve stallion file: $!";
   open (CM, ">show/$showdir/gr_mare.txt") or die "Unable to create grand/reserve mare file: $!";
   open (CG, ">show/$showdir/gr_gelding.txt") or die "Unable to create grand/reserve gelding file: $!";
   my @selected = $cl_select_lb->get(0, 'end');
   foreach $class (@selected) {
      my ($n, $c) = split(/\) /, $class);
      $selected{$c} = $n;
      print C1 "$class\n";

      @resS = grep (/$c/i, @grand_stallion_classes);
      @resM = grep (/$c/i, @grand_mare_classes);
      @resG = grep (/$c/i, @grand_gelding_classes);

      if ($#resS >= 0) {
         print CS "$n\n";
      }

      if ($#resM >= 0) {
         print CM "$n\n";
      }

      if ($#resG >= 0) {
         print CG "$n\n";
      }
   }
   close (C1);
   close (EN);
   close (CS);
   close (CM);
   close (CG);

#
#  Save the high point information
#
   open (C1, ">show/${showdir}/high_point.txt") or die "Unable to create high point file: $!\n";
   &save_highpoint;
   close (C1);

#
#  Save the local point information
#
   open (LOCALHP, ">show/${showdir}/local_points.txt") or die "Unable to create local point file: $!";
   foreach $ii (sort keys %local_points) {
      print LOCALHP "$ii";
      foreach $jj (0 .. 7) {
         print LOCALHP "~~$local_points{$ii}[$jj]";
      }
      print LOCALHP "\n";
   }
   close LOCALHP;

#
#  Save the billing information
#
   &save_billing_info;

#
#  Create necessary dirs
#
   mkdir ("show/$showdir/bills", 0750) or die "Unable to make billing directory: $!";

#
#  Clear the data fields
#
   &clear_show_info;
}


##################################################################################
##################################################################################
#
#  Clear the fields in the new show window, including the list
#  of selected classes
#

sub clear_show_info {
   $showname = $showdate = $maxplace = "";
   for $swi (0 .. 7) {
      $shownumber[$swi] = $judgeinfo[$swi] = "";
   }

   $show_class_index = 0;
   $opencost     = "0.00";
   $nonprocost   = "0.00";
   $youthcost    = "0.00";
   $leadlinecost = "0.00";
   $localcost    = "0.00";
   $jumpfee      = "0.00";
   $cattlefee    = "0.00";
   $o_point      = "0.00";
   $np_point     = "0.00";
   $y_point      = "0.00";
   $officefee    = "0.00";
   $stallfee1    = "0.00";
   $stallfee2    = "0.00";
   $tieoutfee    = "0.00";
   $rvfee        = "0.00";
   $shavingsfee  = "0.00";
}


##################################################################################
##################################################################################
#
#  Display the high point window
#

sub do_highpoint {
   my $ii, $key, $dialog;

   foreach $ii ($hp_select_lb->get(0, 'end')) {
      push (@show_classes, $ii);
   }
   if (scalar(@show_classes) <= 0) {
      $dialog = $new_show_window->DialogBox(-title => 'No Classes Chosen', -buttons => [ "Ok" ]);
      $dialog->add("Label", -text => "You did not choose any classes for this show.")->pack;
      $dialog->add("Label", -text => "You must select your class list before you")->pack;
      $dialog->add("Label", -text => "can set up the high points.")->pack;
      $dialog->Show();
      return;
   }

#
#  Put class list into listbox
#
   my @show_classes = $cl_select_lb->get(0, 'end');
   $hp_select_lb->delete(0, 'end');
   $hp_select_lb->insert('end', @show_classes);

#
#  Put existing high point divisions into listbox
#
   open_high_point_file();
   $hp_standard_lb->delete(0, 'end');
   foreach $line (@high_point_list) {
      (undef, $key) = split(/~~/, $line);
      $hp_standard_lb->insert('end', $key);
   }

   $high_point_window->update();
   $high_point_window->deiconify();
   $high_point_window->raise();
}


##################################################################################
##################################################################################
#
#  Add the high point division the user entered
#

sub select_text_hp {
   my $ii, $division, $highpoint, @c;

#
#  Save the currently displayed list
#
   @c = $cl_setup_lb->get(0, 'end');
   if ($#c >= 0) {
      $hp{$division}[0] = substr($hp_type, 0, 1);
      $hp{$division}[1] = "";
      foreach $ii (@c) {
         $hp{$division}[1] .= "${ii}~~";
      }
   }

#
#  Get the new high point division name
#
   $division = $highpoint;
   $highpoint = "";
   $hp_standard_lb->insert('end', $division);

   $hp{$division}[0] = substr($hp_type, 0, 1);
   $hp{$division}[1] = "";

#
#  Insert the division name into the list
#
   $hp_setup_lb->insert('end', $division);
   $hp_setup_lb->see('end');

#
#  Create the class list for the high point division
#

   $cl_setup_lb->delete(0, 'end');

   print "$division -> $hp{$division}[0]\n";
   print "$division -> $hp{$division}[1]\n";
}


##################################################################################
##################################################################################
#
#  Select a standard highpoint division, and populate the
#  class number list
#

sub select_standard_hp {
   my $ii, $division, $cl, $j, $class, $cls, @c, @cls;

print "\nIN SELECT_STANDARD_HP\n\n";

#
#  Save the currently displayed list
#
   @c = $cl_setup_lb->get(0, 'end');
   if ($#c >= 0) {
print "Saving the following information...\n";
      $hp{$division}[0] = substr($hp_type, 0, 1);
      $hp{$division}[1] = $hp_required;
      $hp{$division}[2] = "";
print "$hp{$division}[0]\n";
print "$hp{$division}[1]\n";
      foreach $ii (@c) {
         $hp{$division}[2] .= "${ii}~~";
      }
print "$hp{$division}[2]\n";
   }

#
#  Get the new high point division name
#
   $division = $hp_standard_lb->get($hp_standard_lb->curselection);
print "\nNew Division Name: $division\n\n";

#
#  If the division is already defined, skip the class
#  list analysis
#
#   goto SETUP_HP_CLASSES if (defined $hp{$division}[1]);

   $hp{$division}[0] = substr($hp_type, 0, 1);
   $hp{$division}[1] = $hp_required;
   $hp{$division}[2] = "";

#
#  Analyze the class list for "normal" classes in
#  a high point division
#
   if ($division =~ "GAMES") {
print "GAMES\n";
      foreach $cl (@show_classes) {
         next if ($cl !~ /^\d/);
         ($j, $class) = split(/\) /, $cl);
         if (($class =~ /STUMP/i)   || ($class =~ /STAKE/i) ||
             ($class =~ /KEYHOLE/i) || ($class =~ /ROPE RACE/i)) {
            $hp{$division}[2] .= "${class}~~";
         }
      }
   }

   if ($division =~ /19/) {
print "19 & OVER\n";
      foreach $cl (@show_classes) {
         ($j, $class) = split(/\) /, $cl);
         if (($class !~ /^AMATEUR/i) && ($class !~ /^YOUTH/i)) {
            $hp{$division}[2] .= "${class}~~";
         }
      }
   }

   if ($division =~ "AMATEUR") {
print "AMATEUR\n";
      foreach $cl (@show_classes) {
         (undef, $class) = split(/\) /, $cl);
print "Class: $class\n";
         if ($class =~ /AMATEUR/i) {
            $hp{$division}[2] .= "${class}~~";
         }
      }
   }

   if ($division =~ "NON-PRO" && $division !~ "35" && $division !~ "MASTERS" && $division !~ "NOVICE" && $division !~ "WALK-TROT") {
print "NON-PRO\n";
      foreach $cl (@show_classes) {
         ($j, $class) = split(/\) /, $cl);
         if (($class =~ /^NP/i)   && ($class !~ /NOVICE/i)  &&
             ($class !~ /35 \&/i) && ($class !~ /MASTERS/i) &&
             ($class !~ /W\/T/i)) {
            $hp{$division}[2] .= "${class}~~";
         }
      }
   }

   if ($division =~ "NON-PRO 35 & OVER") {
print "35 & OVER\n";
      foreach $cl (@show_classes) {
         ($j, $class) = split(/\) /, $cl);
         if (($class =~ /^NP/i) && ($class =~ /35 \&/i)) {
            $hp{$division}[2] .= "${class}~~";
         }
      }
   }

   if ($division =~ "NON-PRO MASTERS") {
print "NOVICE NP\n";
      foreach $cl (@show_classes) {
         ($j, $class) = split(/\) /, $cl);
         if (($class =~ /MASTERS/i) && ($class =~ /^NP/i)) {
            $hp{$division}[2] .= "${class}~~";
         }
      }
   }

   if ($division =~ "NON-PRO NOVICE") {
print "NOVICE NP\n";
      foreach $cl (@show_classes) {
         ($j, $class) = split(/\) /, $cl);
         if (($class =~ /NOVICE/i) && ($class =~ /^NP/i)) {
            $hp{$division}[2] .= "${class}~~";
         }
      }
   }

   if ($division =~ "NON-PRO WALK-TROT") {
print "WALK-TROT NP\n";
      foreach $cl (@show_classes) {
         ($j, $class) = split(/\) /, $cl);
         if (($class =~ /W\/T/i) && ($class =~ /^NP/i)) {
            $hp{$division}[2] .= "${class}~~";
         }
      }
   }

   if ($division =~ "OPEN") {
print "OPEN\n";
      foreach $cl (@show_classes) {
         ($j, $class) = split(/\) /, $cl);
         if (($class !~ /YOUTH/i)      && ($class !~ /WALK/i)          &&
             ($class !~ /NON-PRO/i)    && ($class !~ /AMATEUR/i)       &&
             ($class !~ /NP /i)        && ($class !~ /35/i)            &&
             ($class !~ /13/i)         && ($class !~ /14/i)            &&
             ($class !~ /15/i)         && ($class !~ /16/i)            &&
             ($class !~ /18/i)         && ($class !~ /W\/R/i)          &&
             ($class !~ /UNDER$/i)     && ($class !~ /[0-9]$/i)        &&
             ($class !~ /EQUITATION/i) && ($class !~ /HORSEMANSHIP/i)) {
print "Adding: ${class}\n";
            $hp{$division}[2] .= "${class}~~";
         }
      }
   }

   if ($division =~ "PERFORMANCE") {
print "PERFORM\n";
      foreach $cl (@show_classes) {
         ($j, $class) = split(/\) /, $cl);
         if (($class !~ /STALLION/i) && ($class !~ /MARE/i)     &&
             ($class !~ /GELDING/i)  && ($class !~ /LONGE/i)    &&
             ($class !~ /FILLIES/i)  && ($class !~ /COLORFUL/i) &&
             ($class !~ /PRODUCE/i)  && ($class !~ /HALTER/i)   &&
             ($class !~ /^NP/i)      && ($class !~ /W\/R/i)     &&
             ($class !~ /UNDER$/i)   && ($class !~ /[0-9]$/i)) {
            $hp{$division}[2] .= "${class}~~";
         }
      }
   }

   if ($division =~ "YOUTH" && $division !~ "NOVICE" && $division !~ "WALK" &&
       $division !~ "13" && $division !~ "14") {
print "YOUTH\n";
      foreach $cl (@show_classes) {
         ($j, $class) = split(/\) /, $cl);
         if ((($class !~ /NOVICE/i) && ($class !~ /^NP/i) &&
              ($class !~ /W\/T/i)) &&
             (($class =~ /YOUTH/i) || ($class =~ /UNDER$/i) || ($class =~ /[0-9]$/i))) {
            $hp{$division}[2] .= "${class}~~";
         }
      }
   }

   if ($division =~ "YOUTH NOVICE 18 & UNDER") {
print "NOVICE Y\n";
      foreach $cl (@show_classes) {
         ($j, $class) = split(/\) /, $cl);
         if (($class =~ /NOVICE/i) &&
            (($class =~ /UNDER$/i) || ($class =~ /[0-9]$/i))) {
            $hp{$division}[2] .= "${class}~~";
         }
      }
   }

   if ($division =~ "YOUTH WALK-TROT") {
print "YOUTH WT\n";
      foreach $cl (@show_classes) {
         ($j, $class) = split(/\) /, $cl);
         if (($class =~ /W\/T/i) && ($class =~ /10 \& UNDER$/i)) {
            $hp{$division}[2] .= "${class}~~";
         }
      }
   }

   if ($division =~ "YOUTH 13 & UNDER") {
print "YOUTH 13\n";
      foreach $cl (@show_classes) {
         ($j, $class) = split(/\) /, $cl);
         if (($class !~ /NOVICE/i) &&
            ($class =~ /13 \& UNDER/i || $class =~ /18 \& UNDER/i)) {
            $hp{$division}[2] .= "${class}~~";
         }
      }
   }

   if ($division =~ "YOUTH 18 & UNDER") {
print "YOUTH 13\n";
      foreach $cl (@show_classes) {
         ($j, $class) = split(/\) /, $cl);
         if (($class !~ /NOVICE/i) &&
            ($class =~ /YOUTH/i || $class =~ /18 \& UNDER/i)) {
            $hp{$division}[2] .= "${class}~~";
         }
      }
   }

   if ($division =~ "YOUTH 14 - 18") {
print "YOUTH 14\n";
      foreach $cl (@show_classes) {
         ($j, $class) = split(/\) /, $cl);
         if (($class !~ /NOVICE/i) &&
            ($class =~ /14 - 18/i || $class =~ /18 \& UNDER/i)) {
            $hp{$division}[2] .= "${class}~~";
         }
      }
   }

#
#  Insert the division name into the list
#
   $hp_setup_lb->insert('end', $division);
   $hp_setup_lb->see('end');

#
#  Create the class list for the high point division
#
SETUP_HP_CLASSES:
   $cl_setup_lb->delete(0, 'end');
   (@cls) = split(/~~/, $hp{$division}[2]);
   foreach $cls (sort @cls) {
      $cl_setup_lb->insert('end', $cls);
   }

print "HP{$division}[0] = $hp{$division}[0]\n";
print "HP{$division}[1] = $hp{$division}[1]\n";
print "HP{$division}[2] = $hp{$division}[2]\n";
}

##################################################################################
##################################################################################
#
#  Select a class from the class list and add it to the
#  classes in the high point list
#

sub select_class_for_hp {
   @selected = $hp_select_lb->curselection;
   $selected = $hp_select_lb->get($selected[0]);
   ($j, $class) = split(/\) /, $selected);

   $cl_setup_lb->insert('end', $class);
   $cl_setup_lb->see('end');
}


##################################################################################
##################################################################################
#
#  Delete a class from the high point list
#

sub delete_hp_class {
   @selected = $cl_setup_lb->curselection;
   $cl_setup_lb->delete($selected[0]);
}


##################################################################################
##################################################################################
#
#  Delete an already defined high point
#

sub delete_existing_hp {
   @selected = $hp_setup_lb->curselection;
   $selected = $hp_setup_lb->get($selected[0]);
   $hp_setup_lb->delete($selected[0]);
   undef $hp{$selected};
}

##################################################################################
##################################################################################
#
#  View an already defined high point
#

sub view_existing_hp {
   my @selected, @cls, $selected, $class;

   @selected = $hp_setup_lb->curselection;
   $selected = $hp_setup_lb->get($selected[0]);

   $cl_setup_lb->delete(0, 'end');
   (@cls) = split(/~~/, $hp{$selected}[2]);
   foreach $class (@cls) {
      $cl_setup_lb->insert('end', $class);
      $cl_setup_lb->see('end');
   }
}

##################################################################################
##################################################################################
#
#  Save the existing high point information
#

sub save_highpoint {
   @c = $cl_setup_lb->get(0, 'end');
   if ($#c >= 0) {
      $hp{$division}[0] = "R" if ($hp_type eq "RIDER ONLY");
      $hp{$division}[0] = "H" if ($hp_type eq "HORSE ONLY");
      $hp{$division}[0] = "P" if ($hp_type eq "HIGHEST PLACING HORSE");
      $hp{$division}[0] = "B" if ($hp_type eq "BOTH RIDER AND HORSE");
      $hp{$division}[1] = $hp_required;
      $hp{$division}[2] = "";
      foreach $ii (@c) {
         $hp{$division}[2] .= "${ii}~~";
      }
   }

   foreach $division (sort keys %hp) {
print "Division: $division\n";
      next if ($division eq "");
      if ($division eq "OPEN PERFORMANCE")        { $min = 0;  $max = 999; }
      if ($division eq "NON-PRO")                 { $min = 19; $max = 999; }
      if ($division eq "NON-PRO 35 & OVER")       { $min = 35; $max = 999; }
      if ($division eq "NON-PRO MASTERS")         { $min = 50; $max = 999; }
      if ($division eq "NON-PRO NOVICE")          { $min = 19; $max = 999; }
      if ($division eq "NON-PRO WALK-TROT")       { $min = 19; $max = 999; }
      if ($division eq "YOUTH")                   { $min = 0;  $max = 18;  }
      if ($division eq "YOUTH 18 & UNDER")        { $min = 0;  $max = 18;  }
      if ($division eq "YOUTH 13 & UNDER")        { $min = 0;  $max = 13;  }
      if ($division eq "YOUTH 14 - 18")           { $min = 14; $max = 18;  }
      if ($division eq "YOUTH NOVICE 18 & UNDER") { $min = 0;  $max = 18;  }
      if ($division eq "YOUTH WALK-TROT")         { $min = 0;  $max = 10;  }
print "Min: $min\tMax: $max\n";

      $highpoint{$division} = "${division}~~$hp{$division}[0]~~$hp{$division}[1]~~${min}~~${max}~~";
#      $highpoint{$division} = "${division}~~$hp{$division}[0]~~$hp{$division}[1]~~";

      my @hpl = ();
      (@cls) = split(/~~/, $hp{$division}[2]);
      foreach $cls (@cls) {
print "$cls\n";
         @sc = grep(/$cls/, @show_classes);
         ($n, $c) = split(/\) /, $sc[0]);
         push(@hpl, $n);
      }

      foreach $cls (sort {$a <=> $b} @hpl) {
         $highpoint{$division} .= "${cls},";
      }
      chop($highpoint{$division});
      print C1 "$highpoint{$division}\n";
   }
}


##################################################################################
##################################################################################
#
#  Read the Grand/Reserve data files
#

sub read_grand_reserve_files {
   open(JL, "data/${showbreed}.grand_gelding_list.txt") or do {
      print "Unable to open grand/reserve gelding list file\n";
      exit;
   };
   chomp(@grand_gelding_classes = <JL>);
   close (JL);

   open(JL, "data/${showbreed}.grand_mare_list.txt") or do {
      print "Unable to open grand/reserve mare list file\n";
      exit;
   };
   chomp(@grand_mare_classes = <JL>);
   close (JL);

   open(JL, "data/${showbreed}.grand_stallion_list.txt") or do {
      print "Unable to open grand/reserve stallion list file\n";
      exit;
   };
   chomp(@grand_stallion_classes = <JL>);
   close (JL);
}


##################################################################################
##################################################################################
#
#  Display the local point window and fill in the points
#

sub do_local_points {
   my $nic, @pts, $ii;

   if (-e "$showdir/${showbreed}.local_points.txt" && $showdir ne "") {
      &open_local_point_file($showdir);
   } else {
      open (LOCALHP, "data/${showbreed}.local_points.txt") or do {
         print "Unable to open local point file: $!\n";
         exit;
      };
      while (<LOCALHP>) {
         ($nic, @pts) = split(/~~/);
         foreach $ii (0 .. $#pts) {
            $local_points{$nic}[$ii] = $pts[$ii];
         }
      }
      close LOCALHP;
   }

   $local_point_window->update();
   $local_point_window->deiconify();
   $local_point_window->raise();
}


##################################################################################
##################################################################################
#
#  Display the local class window
#

sub do_local_classes {
   $localclassnum = "";
   $localclassname = "";

   open (LOCALCL, "data/${showbreed}.local_class_list.txt") or die "Unable to open local class file: $!";
   chomp(my @local_classes = <LOCALCL>);
   close LOCALCL;

   $local_classes_lb->delete(0, 'end');
   foreach (@local_classes) {
      ($cnum, $yn, $cname) = split(/~/);
      $local_classes_lb->insert('end', $cname);
   }

   $local_class_window->update();
   $local_class_window->deiconify();
   $local_class_window->raise();
}


##################################################################################
##################################################################################
#
#  Add the local class to the file
#

sub add_local_class {
   return if (($localclassnum eq "") || ($yesno eq "") || ($localclassname eq ""));

   open (LOCALCL, ">>data/${showbreed}.local_class_list.txt") or die "Unable to open local class file: $!";
   print LOCALCL "${localclassnum}~${yesno}~${localclassname}\n";
   close LOCALCL;

   $local_classes_lb->insert('end', $localclassname);

   $yesno = "";
   $localclassnum = "";
   $localclassname = "";
   $local_class_window->update();
   $local_class_window->focus();
   $localclnum->focus();
}


##################################################################################
##################################################################################
#
#  Delete a local classes
#

sub delete_local_class {
   @selected = $local_classes_lb->curselection;
   $local_classes_lb->delete($selected[0]);

   open (LOCALCL, "data/${showbreed}.local_class_list.txt") or die "Unable to open local class file: $!";
   chomp(my @local_classes = <LOCALCL>);
   close LOCALCL;

print ("Delete: $selected[0]\n");
   my @local = ();
   foreach $ii (0 .. $#local_classes) {
      (my $cnum, my $cname) = split(/~/, $local_classes[$ii]);
      push (@local, "$cnum~$cname\n") if ($ii != $selected[0]);
   }

   open (LOCALCL, ">data/${showbreed}.local_class_list.txt") or die "Unable to open local class file: $!";
   foreach (@local) {
      print LOCALCL $_;
   }
   close LOCALCL;
}


##################################################################################
##################################################################################
#
#  Set up the billing information
#

sub do_billing {

   billing_toplevel();

print "Billing Line: ...${billing[0]}\n";

   ($opencost, $nonprocost, $youthcost, $localcost, $jumpfee, $cattlefee, $officefee, $tieoutfee, $stall1day, $stall2day, $shavings, $rvcost) = split(/~~/, $billing[0]);

   $opencost   = 0.00 if (! $opencost);
   $nonprocost = 0.00 if (! $nonprocost);
   $youthcost  = 0.00 if (! $youthcost);
   $localcost  = 0.00 if (! $localcost);
   $jumpfee    = 0.00 if (! $jumpfee);
   $cattlefee  = 0.00 if (! $cattlefee);
   $officefee  = 0.00 if (! $officefee);
   $tieoutfee  = 0.00 if (! $tieoutfee);
   $stall1day  = 0.00 if (! $stall1day);
   $stall2day  = 0.00 if (! $stall1day);
   $shavings   = 0.00 if (! $shavings);
   $rvcost     = 0.00 if (! $rvcost);

   @bill_classes = ();
   @bwl_fee      = ();
   @bwl_cattle   = ();
   @bwl_jump     = ();

   my @selected = $cl_select_lb->get(0, 'end');
   foreach $class (@selected) {
      my ($n, $c) = split(/\) /, $class);
      chomp($c);
      if ($n !~ /Grand/) {
         push(@bill_classes, $c);
      }
   }

   &update_class_fees;

   print "Back from top level create\n";

   $billing_window->update();
   $billing_window->deiconify();
   $billing_window->raise();
}


##################################################################################
##################################################################################
#
#  Update the Class Fee display
#

sub update_class_fees {
   print "Open  : $opencost\n";
   print "NonPro: $nonprocost\n";
   print "Youth : $youthcost\n";
   print "Local : $localcost\n";
   print "Jumps : $jumpfee\n";
   print "Cattle: $cattlefee\n";
   print "Office: $officefee\n";
   print "TieOut: $tieoutfee\n";
   print "Stall1: $stall1day\n";
   print "Stall2: $stall2day\n";
   print "Shave : $shavings\n";
   print "RV    : $rvcost\n";

   for ($count=0; $count<=$#bill_classes; $count++) {
#print "Class: ...${$bill_classes[$count]}...   ";

      if ($bill_classes[$count] =~ /^NP/) {
         $bwl_fee[$count] = $nonprocost;
#print "Nonpro ";
      } else {
         if ($bill_classes[$count] =~ /18 & Under/ || $bill_classes[$count] =~ /13 & Under/ ||
             $bill_classes[$count] =~ /14 - 18/    || $bill_classes[$count] =~ /12 & Under/ ||
             $bill_classes[$count] =~ /13 - 15/    || $bill_classes[$count] =~ /16 - 18/) {
            $bwl_fee[$count] = $youthcost;
#print "Youth  ";
         } else {
            $bwl_fee[$count] = $opencost;
#print "Open   ";
         }
      }

      if ($bill_classes[$count] =~ /Heading/ || $bill_classes[$count] =~ /Heeling/ ||
          $bill_classes[$count] =~ /Cutting/ || $bill_classes[$count] =~ /Cow/     ||
          $bill_classes[$count] =~ /Calf/    || $bill_classes[$count] =~ /Steer/   ||
          $bill_classes[$count] =~ /Penning/ || $bill_classes[$count] =~ /Roping/) {
         $bwl_cattle[$count] = $cattlefee;
#print "Cattle ";
      }

      if ($bill_classes[$count] =~ /Fence/       || $bill_classes[$count] =~ /Jumping/        ||
          $bill_classes[$count] =~ /Hunter Hack/ || $bill_classes[$count] =~ /Working Hunter/ ||
          $bill_classes[$count] =~ /Green/) {
         $bwl_jump[$count] = $jumpfee;
#print "Jump   ";
      }

      foreach $ii (@local_class_list) {
         ($num, $yn, $name) = split(/~/, $ii);
         chomp($name);
         if ($bill_classes[$count] eq $name) {
            $bwl_fee[$count] = $localcost;
#print "Local  ";
         }
      }
#print "\n";
   }
   $billing_window->update() if (Exists($billing_window));

}


##################################################################################
##################################################################################
#
#  Save the billing information
#

sub save_billing_info {
   open (BF, ">${showdir}/billing.txt") or die "Unable to open billing file: $!";
   my $bill = "${opencost}~~${nonprocost}~~${youthcost}~~${localcost}~~${jumpfee}~~${cattlefee}~~${officefee}~~${tieoutfee}~~${stall1day}~~${stall2day}~~${shavings}~~${rvcost}";
   print BF "$bill\n";

   for ($index=0; $index<=$#bill_classes; $index++) {
      print BF "$bill_classes[$index]~~$bwl_fee[$index]~~$bwl_jump[$index]~~$bwl_cattle[$index]\n";
   }
   close BF;
}


##################################################################################
##################################################################################
#
#  Convert an entered date
#

sub convert_date {

   my $datestr = shift(@_);
   my $ncy = 2000;

   my ($cm, $cd, $cy) = split(/\//, ${datestr});
   my $ncm = sprintf("%02d", ${cm});
   my $ncd = sprintf("%02d", ${cd});
   substr($ncy,-(length($cy))) = "${cy}";

   if (($ncm >= 1 && $ncm <= 12) &&
       ($ncd >= 1 && $ncd <= 31) &&
       ($ncy >= 2000)) {
      return("${ncm}/${ncd}/${ncy}");
   }
   else {
#print "Trying to display an error message\n";

      $error_message_text = "\nYou entered your Date in an invalid format\nFormat must be MM/DD/YYYY\n";
      $mw->Dialog(
              -title          => "Invalid Date",
              -text           => ${error_message_text},
              -default_button => "Ok",
              -buttons        => [ 'Ok' ],
              -bitmap         => 'error')
          ->Show();
      return;
   }

}


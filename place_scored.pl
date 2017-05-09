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
require "place_scored_toplevel.pl";
require "open_show.pl";


$showdate = $ARGV[0];
$classnumber = "";
$window_type = "scored";
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
      ($classnumber, $cname) = split(/\) /, $chosen);
      ($classname) = split(/~~/, $cname);
   } else {
      $cname = $show_class_list{$classnumber};
      ($classname) = split(/~~/, $cname);
   }
print "Class Number: $classnumber\n";
print "Class Name  : $classname\n";

   %back_list = ();
   $total_class_entries = 0;
   foreach $ii (@entry_list) {
      ($back, $hnum, $rnum, undef, $cn, undef) = split(/~~/, $ii);
      if ($cn eq $classnumber) {
         $total_class_entries++;
         (undef, $horse, undef) = split(/~~/, $horse_list{$hnum});
         ($rider, undef) = split(/~~/, $member_list{$rnum});
         $back_list{$back} = "$horse / $rider";
print "Entry: $back : $back_list{$back}\n";
      }
   }

   &place_class_toplevel();

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
#  Sort the results for each Judge to find the placings
#

sub sort_results {

print "Class: $classnumber  # Entries: $total_class_entries\n";
   if ($total_class_entries <= 1)   { @natpoints = ( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ); }   elsif
      ($total_class_entries <= 2)   { @natpoints = ( 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0 ); } elsif
      ($total_class_entries <= 7)   { @natpoints = ( 1, 0.5, 0, 0, 0, 0, 0, 0, 0, 0 ); } elsif
      ($total_class_entries <= 12)  { @natpoints = ( 2, 1, 0.5, 0, 0, 0, 0, 0, 0, 0 ); } elsif
      ($total_class_entries <= 17)  { @natpoints = ( 3, 2, 1, 0.5, 0, 0, 0, 0, 0, 0 ); } elsif
      ($total_class_entries <= 22)  { @natpoints = ( 4, 3, 2, 1, 0.5, 0, 0, 0, 0, 0 ); } elsif
      ($total_class_entries <= 27)  { @natpoints = ( 5, 4, 3, 2, 1, 0.5, 0, 0, 0, 0 ); } elsif
      ($total_class_entries <= 999) { @natpoints = ( 6, 5, 4, 3, 2, 1, 0.5, 0, 0, 0 ); }

   $class_index = 0;
   for $judge_index (1 .. $numjudges) {
      @sort_list = ();
      $back_index = 0;
      for $back (sort { $a <=> $b } keys %back_list) {
print "Results For ... $back ... $judge_index : $classplace{$back_index}[($judge_index-1)]\n";
         push(@sort_list, "${classplace{$back_index}[($judge_index-1)]}.${back}");
         $back_index++;
      }
      $class_index++;

      $place = 1;
      foreach $line (sort { $a <=> $b } @sort_list) {
print "Line: $line\n";
         ($score, $back) = split(/\./, $line);
         save_placing_info($back, $place, $score, $judge_index);
         $place++;
      }
   }

   $classnumber = "";
   $choose_class_window->update();
   $choose_class_window->deiconify();
   $choose_class_window->raise();
}


##################################################################################
##################################################################################
#
#  Calculate National points for each place, and save that info
#  in the entry file
#

sub save_placing_info {

   my $back  = $_[0];
   my $place = $_[1];
   my $score = $_[2];
   my $judge = $_[3];

#
#  Open the entry file, and set the placing information for
#  the back number passed in
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
#      $entryinfo[5] = "~~0~~F~~0~~0~~F~~0~~0~~F~~0~~0~~F~~0";
      ${$entries{$classnumber}}[$ii] = "$entryinfo[0]~~$entryinfo[1]~~$entryinfo[2]~~$entryinfo[3]~~$entryinfo[4]~~$entryinfo[5]";
   }

#
#  Calculate NATIONAL points for each entry in the class, then add that
#  information to the class entry
#
   $j_index =  5  if ($judge == 1);
   $j_index =  8  if ($judge == 2);
   $j_index = 11  if ($judge == 3);
   $j_index = 14  if ($judge == 4);

   for $ii (@{$entries{$classnumber}}) {
print "II: $ii\n";
      my (@entryinfo) = split(/~~/, $ii);
      next if ($entryinfo[0] != $back);

      $entryinfo[$j_index] = $place;
      $entryinfo[$j_index+1] = $score;
      $entryinfo[$j_index+2] = $natpoints[$place-1];
      $ii = join("~~", @entryinfo);
print "II: $ii\n";

      last;
   }

#
#  Write out the entry file, then read it in again?
#
   &write_entry_file($showdir);
   &open_entry_file($showdir);

}


1;

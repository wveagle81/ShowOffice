#!/perl/bin/perl
##################################################################################
##################################################################################
#
#       Perl/TK Horse Show Program
#
#  Main program has one window with buttons which run other main programs:
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
require Tk::TopLevel;
require Tk::DialogBox;

require "common.pl";
require "read_write.pl";
require "create_main.pl";


##################################################################################
##################################################################################
#
#       Create the main window and menus
#

$year = ((localtime(time))[5]) + 1900;
$main_window_label = "\nShow Name and Date - $year\n";


&create_main;
&create_error_message_dialog;


##################################################################################
##################################################################################
#
#       Update the main screen - allows us to get the width and height
#       for future use
#

$mw->update();
$screen_width  = $mw->screenwidth();
$main_width    = $mw->width();
$main_x_pos    = int(($screen_width - $main_width) / 2);


##################################################################################
##################################################################################
#
#       Move the main window to the center top
#
$mw->geometry("+$main_x_pos+0");
$mw->deiconify();
$mw->raise();

MainLoop;


##################################################################################
##################################################################################
#
#       Check the format of the input date.  If it matches an existing
#       show, fill in the show name on the main window.
#

sub check_date_format {
   if (defined $showdateinput) {
      if ($showdateinput !~ m#^\d{1,2}/?\d{1,2}/?\d{4}$#) {
         $error_message_text = "\n  You entered your Show Date in an invalid format.  \nFormat must be MM/DD/YYYY\n";
         &error_message();
      }
   }

#
# See if a show for that date exists.  If it does, retrieve the
# show and display the data
#
   my $sd = $showdateinput;
   $sd =~ s/\///g;
   if (-e "show/$sd/showinfo.txt") {
      open_showinfo_file("show/$sd");
      (${showname},${showdate},${shownumber[0]},${shownumber[1]},${shownumber[2]},${shownumber[3]},${judgeinfo[0]},${judgeinfo[2]},${judgeinfo[4]},${judgeinfo[6]},${maxplace}) = split(/~~/, $openshowdata);
      $main_window_label = "\n$showname - $showdate\n";
      $showdateinput = "";
   }
}

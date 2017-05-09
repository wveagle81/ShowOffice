##################################################################################
##################################################################################
#
#       Perl/TK Horse Show Program
#
#  Perform Reports
#
##################################################################################
##################################################################################

use Tk;
use Cwd;
require Tk::Text;
require Tk::Event;
require Tk::Scrollbar;
require Tk::TopLevel;
require Tk::Dialog;
require Tk::DialogBox;
require Win32::OLE;

#perl2exe_include "Tk/Text.pm";
#perl2exe_include "Tk/Event.pm";
#perl2exe_include "Tk/Scrollbar.pm";
#perl2exe_include "Tk/TopLevel.pm";
#perl2exe_include "Tk/Dialog.pm";
#perl2exe_include "Tk/DialogBox.pm";
#perl2exe_include "Win32/OLE.pm";

require "common.pl";
require "lookup.pl";
require "read_write.pl";
require "reports_toplevel.pl";
require "open_show.pl";
require "report_formats.pl";

$| = 1;

$showdate = $ARGV[0];
$classnumber = "";
$window_type = "report";
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

$cwd = getcwd();
print "Current Dir: ${cwd}\n";

MainLoop;

exit;


##################################################################################
#
#       Reports
#
##################################################################################


##################################################################################
##################################################################################
#
#       Member List By Lastname
#

sub members_by_lastname {
   &open_member_file($showdir);

   $reporttype = "MEMBER LIST BY LAST NAME";

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;
   &member_header_html;

   @mlist = ();
   foreach $ii (@member_list) {
      ($regnum,$riderlastname,$riderfirstname,$rideraddress,$ridercity,$riderstate,$riderzip,$riderhomephone,$riderworkphone,$rideremail,$ridersex,$ridernumberstatus) = split(/~~/, $ii);
      $name    = $riderfirstname ." ". $riderlastname;
      $address = $rideraddress ."<BR>". $ridercity .", ". $riderstate ."<BR>". $riderzip;
      $phone   = "Home: $riderhomephone<BR>Work: $riderworkphone";
      $l       = $riderlastname . $riderfirstname . "~~" . $regnum . "~~" . $name . "~~" . $address . "~~" . $phone;
      push (@mlist, $l);
   }

   foreach $ii (sort @mlist) {
      ($j, $regnum, $name, $address, $phone) = split(/~~/, $ii);
      &member_list_html;
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


##################################################################################
##################################################################################
#
#       Member List By Registration Number
#

sub members_by_regnum {
   &open_member_file($showdir);

   $reporttype = "MEMBER LIST BY REGISTRATION NUMBER";

   @mlist = ();

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;
   &member_header_html;

   @mlist = ();
   foreach $ii (@member_list) {
      ($regnum,$riderlastname,$riderfirstname,$rideraddress,$ridercity,$riderstate,$riderzip,$riderhomephone,$riderworkphone,$rideremail,$ridersex,$ridernumberstatus) = split(/~~/, $ii);
      $name    = $riderfirstname ." ". $riderlastname;
      $address = $rideraddress ."<BR>". $ridercity .", ". $riderstate ."<BR>". $riderzip;
      $phone   = "Home: $riderhomephone<BR>Work: $riderworkphone";
      $l       = $regnum . "~~" . $name . "~~" . $address . "~~" . $phone;
      push (@mlist, $l);
   }

#   foreach $ii (sort { $a cmp $b } @mlist) {
   foreach $ii (sort @mlist) {
      ($regnum, $name, $address, $phone) = split(/~~/, $ii);
      &member_list_html;
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


##################################################################################
##################################################################################
#
#       Horse List By Name
#
# 450966~~#~~A DREAM COME TRUE~~GELDING~~1986~~BAY ROAN~~BABY BAR PATCH~~FRANZA BAR~~739559
#

sub horses_by_name {
   &open_horse_file($showdir);
   &open_member_file($showdir);

   $reporttype = "HORSE LIST BY NAME";

   @mlist = ();

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;
   &horse_header_html;

   @mlist = ();
   foreach $ii (@horse_list) {
      ($regnum, $regtype, $name, $sex, $foaled, $color, $sire, $dam, $owner) = split(/~~/, $ii);
      $l = $name ."~~". $regnum ."~~". $regtype ."~~". $foaled ."~~". $color ."~~". $sex ."~~". $sire ."~~". $dam ."~~". $owner;
      push (@mlist, $l);
   }

   foreach $ii (sort @mlist) {
      ($name, $regnum, $type, $year, $color, $sex, $sire, $dam, $owner) = split(/~~/, $ii);
      &horse_list_html;
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


##################################################################################
##################################################################################
#
#       Horse List By Registration Number
#

sub horses_by_regnum {
   &open_horse_file($showdir);

   $reporttype = "HORSE LIST BY REGISTRATION NUMBER";

   @mlist = ();

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;
   &horse_header_html;

   @mlist = ();
   foreach $ii (@horse_list) {
      ($regnum, $regtype, $name, $sex, $foaled, $color, $sire, $dam, $owner) = split(/~~/, $ii);
      $l = $regnum ."~~". $name ."~~". $regtype ."~~". $foaled ."~~". $color ."~~". $sex ."~~". $sire ."~~". $dam ."~~". $owner;
      push (@mlist, $l);
   }

   foreach $ii (sort {$a cmp $b} @mlist) {
      ($regnum, $name, $type, $year, $color, $sex, $sire, $dam, $owner) = split(/~~/, $ii);
      &horse_list_html;
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


##################################################################################
##################################################################################
#
#       Horse List By Sex
#

sub horses_by_sex {
   &open_horse_file($showdir);

   $reporttype = "HORSE LIST BY SEX";

   @mlist = ();

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;
   &horse_header_html;

   @mlist = ();
   foreach $ii (@horse_list) {
      ($regnum, $regtype, $name, $sex, $foaled, $color, $sire, $dam, $owner) = split(/~~/, $ii);
      $l = $sex . $name ."~~". $regnum ."~~". $name ."~~". $foaled ."~~". $color ."~~". $sex ."~~". $sire ."~~". $dam ."~~". $owner;
      push (@mlist, $l);
   }

   foreach $ii (sort {$a cmp $b} @mlist) {
      ($sort, $regnum, $name, $type, $year, $color, $sex, $sire, $dam, $owner) = split(/~~/, $ii);
      &horse_list_html;
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


##################################################################################
##################################################################################
#
#       Class List
#

sub class_list {
   &open_showinfo_file($showdir);

   $reporttype = "CLASS LIST";

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;
   &classlist_header_html;

   foreach $ii (@show_classes) {
      if ($ii !~ /\d/) {
         $classnum  = "&nbsp;";
         $classname = $ii;
      } else {
         ($classnum, $classname) = split(/\) /, $ii);
      }
      &class_list_html;
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


##################################################################################
##################################################################################
#
#       Back Number List
#

sub back_number {
   &open_showinfo_file($showdir);
   &open_entry_file($showdir);
   &open_member_file($showdir);
   &open_horse_file($showdir);

   $reporttype = "BACK NUMBER LIST";

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;
   &backnumber_header_html;

   %blist = ();
   foreach $ii (@entry_list) {
      ($back, $horse, $rider, $relation, $class, $rest) = split(/~~/, $ii, 6);
      $backrider = $back ."~". $rider;
      $blist{$backrider}[$#{$blist{$backrider}}+1] = $class ."~~". $horse;
   }

   foreach $backrider (sort { $a <=> $b } keys %blist) {
      @classes = ();
      $classes = "";
      ($backnum, $ridernum) = split(/~/, $backrider);
      foreach $ii (@{$blist{$backrider}}) {
         ($classnum, $horsenum) = split(/~~/, $ii);
         push (@classes, $classnum);
      }
      $classes = join(", ", (sort { $a <=> $b } @classes));
      ($regtype, $horsename, $rest) = split(/~~/, $horse_list{$horsenum});
      ($ridername) = split(/~~/, $member_list{$ridernum});

      &backnumber_list_html;
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}




##################################################################################
##################################################################################
#
#       National Back Number List
#

sub national_back_number {
   &open_showinfo_file($showdir);
   &open_entry_file($showdir);
   &open_member_file;
   &open_horse_file;

   $reporttype = "MASTERLIST OF BACK NUMBERS";

   %blist = ();
   foreach $ii (@entry_list) {
      ($back, $horse, $rider, $relation, $class, $rest) = split(/~~/, $ii, 6);
      $backrider = $back ."~". $rider;
      $blist{$backrider} = $ii;
   }

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;
   &national_backnumber_header_html;

   foreach $backrider (sort { $a <=> $b } keys %blist) {
      ($backnum, $ridernum) = split(/~/, $backrider);
      ($back, $horsenum, $ridernum, $relation, $class, $rest) = split(/~~/, $blist{$backrider}, 6);
      ($regtype, $horsename, $horsesex, $yearfoaled, $horsecolor, $horsesire, $horsedam, $ownernum) = split(/~~/, $horse_list{$horsenum});
      ($ridername, $rideraddress, $ridercity, $riderstate, $riderzip, $riderhomephone, $riderworkphone, $rideremail, $ridersex, $rideryear, $regtype, $ridernumberstatus) = split(/~~/, $member_list{$ridernum});
      ($ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $ownerhomephone, $ownerworkphone, $owneremail, $ownersex, $owneryear, $regtype, $ownernumberstatus) = split(/~~/, $member_list{$ownernum});
      $horseinfo = "${horsename} / ${horsenum} / ${yearfoaled}";
      $riderinfo = "${ridername} / ${ridernum}<br>${rideraddress}<br>${ridercity}, ${riderstate} ${riderzip}";
      $ownerinfo = "${ownername} / ${ownernum}<br>${owneraddress}<br>${ownercity}, ${ownerstate} ${ownerzip}";

      &national_backnumber_list_html;
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


##################################################################################
##################################################################################
#
#       Class List with Number of Entries in Each Class
#

sub class_list_with_entries {
   &open_showinfo_file($showdir);
   &open_entry_file($showdir);

   @tm = localtime(time);

   $reporttime = sprintf("%02d%02d", $tm[2], $tm[1]);

   $total_entries = scalar(grep !/~~G[SMG]~~/, @entry_list) + 1;
   $reporttype = "CLASS LIST WITH ENTRY COUNTS";

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;
   &entrycount_header_html;

   foreach $ii (@show_classes) {
      @class_entries = ();
      if ($ii =~ /Grand/) {
         $entries   = "&nbsp;";
         $classnum  = "&nbsp;";
         $classname = $ii;
      } else {
         ($classnum, $classname) = split(/\) /, $ii);

         foreach $jj (@entry_list) {
               (undef, undef, undef, undef, $cn, undef) = split(/~~/, $jj);
               push(@class_entries, $jj) if ($cn eq $classnum);
         }
         $entries = $#class_entries+1;
      }

      &entrycount_list_html;
   }

   &entrycount_footer_html;
   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


##################################################################################
##################################################################################
#
#       Class List (Select The Class To Report)
#

sub one_class_list {
   $flag = $_[0];

   @tm = localtime(time);
   $month = $tm[4] + 1;
   $year  = $tm[5] + 1900;

   if    ($flag eq "single") { $reporttype = "CLASS ENTRIES"; }
   elsif ($flag eq "random") { $reporttype = "CLASS ENTRIES IN RANDOM ORDER"; }
   elsif ($flag eq "winner") { $reporttype = "CLASS WINNER"; }
   else                      { $reporttype = "CLASS PLACINGS"; }

   $reportdate = sprintf("%02d/%02d/%4d", $month, $tm[3], $year);
   $reporttime = sprintf("%02d%02d", $tm[2], $tm[1]);
print "Date: $reportdate\nTime: $reporttime\n";

   &open_showinfo_file($showdir) if (-e "$showdir/entry.txt");
   &open_entry_file($showdir) if (-e "$showdir/entry.txt");

   &open_horse_file($showdir);
   &open_member_file($showdir);

   $current_entries_label  = "Current # Entries : " . $entry_count . "                     ";
   $current_entries_label .= "Current # Horses : " . $horse_count;

   $class_lb->delete(0, 'end');
   $class_lb->insert('end', @show_classes);

   $class_list_window->deiconify();
   $class_list_window->raise();
}


##################################################################################
##################################################################################
#
#       Report On The Chosen Class
#

sub report_one_class {
   &open_member_file($showdir);
   &open_horse_file($showdir);
   $class_list_window->withdraw();

   $pages = 1;

print "Report Type: ...$reporttype...\n";
   if ($reporttype eq "CLASS WINNER") {
print "Doing class winner\n";
      class_winner();
   } else {

      $textwindow->configure(-background  => 'white',
                          -foreground  => 'navy',
                          -borderwidth => '2',
                          -exportselection => 1,
                          -font        => 'courier 10',
                          -height      => 30,
                          -padx        => 1,
                          -pady        => 1,
                          -width       => 80);

      if (!$classnumber) {
         @chosen = $class_lb->curselection();
         foreach $entry (@chosen) {
            $chosen = $class_lb->get($entry);
            ($classnumber, $classname) = split(/\) /, $chosen);
print "Class Num: $classnumber\nClass Nam: $classname\n";

            open (CLASSENTRIES, ">temp/reportfile$$_${classnumber}.txt") or die "Unable to open temp file: $!";
            print CLASSENTRIES "";
            close CLASSENTRIES;

            if ($classnumber =~ /Grand/) {
               if ($classnumber =~ /Mare/ && $classnumber !~ /Open/) {
                  $classname = $classnumber;
                  $classnumber = "GM";
               } elsif ($showbreed eq "buckskin" && $classnumber =~ /Mare/ && $classnumber =~ /Open/) {
                  $classname = $classnumber;
                  $classnumber = "OM";
               }
               if ($classnumber =~ /Gelding/ && $classnumber !~ /Open/) {
                  $classname = $classnumber;
                  $classnumber = "GG";
               } elsif ($showbreed eq "buckskin" && $classnumber =~ /Gelding/ && $classnumber =~ /Open/) {
                  $classname = $classnumber;
                  $classnumber = "OG";
               }
               if ($classnumber =~ /Stallion/ && $classnumber !~ /Open/) {
                  $classname = $classnumber;
                  $classnumber = "GS";
               } elsif ($showbreed eq "buckskin" && $classnumber =~ /Stallion/ && $classnumber =~ /Open/) {
                  $classname = $classnumber;
                  $classnumber = "OS";
               }
               if ($showbreed eq "buckskin" && $classnumber =~ /Color/ && $classnumber =~ /Open/) {
                  $classname = $classnumber;
                  $classnumber = "OC";
               }
            }
            &do_one_class_report($classnumber, $classname);
         }
      } else {
         $classname = $show_class_list{$classnumber};
         &do_one_class_report($classnumber, $classname);
      }

      open (CLASSENTRIES, "temp/reportfile$$_${classnumber}.txt");
      foreach $ii (<CLASSENTRIES>) {
         $textwindow->insert('end', $ii);
      }
      close(CLASSENTRIES);
   }

   $classnumber = "";
}


sub do_one_class_report {
   $classnumber = $_[0];
   $classname   = $_[1];

print "Do One Class Report\n";

#
#  Get judge info for printout
#
   (undef,undef,$shownum1,$shownum2,$shownum3,$shownum4,$judge1,$judge2,$judge3,$judge4,$maxplace) = split(/~~/, $openshowdata);
   $judgeinfo1 = sprintf("%-20s", $judge_list{$judge1}) if ($judge1);
   $judgeinfo2 = sprintf("%-20s", $judge_list{$judge2}) if ($judge2);
   $judgeinfo3 = sprintf("%-20s", $judge_list{$judge3}) if ($judge3);
   $judgeinfo4 = sprintf("%-20s", $judge_list{$judge4}) if ($judge4);

   @class_entries = ();
   foreach $ii (@entry_list) {
      (undef, undef, undef, undef, $cn, undef) = split(/~~/, $ii);
      push(@class_entries, $ii) if ($cn eq $classnumber);
   }
   $total_class_entries = $#class_entries+1;

   @mlist = ();

   open (HTML_REPORT, ">c:/temp/reportfile$$_${classnumber}.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;
   &judges_html;
   &classinfo_html;
   $header = 0;

   if (($flag eq "single") || ($flag eq "placing")) {
print "Flag = $flag\n";
      if ($total_class_entries <= 0) {
         $backnumber = 0;
         $horsename = "THERE ARE NO ENTRIES IN THIS CLASS";
         $ridername = "";
         $place1 = $place2 = $place3 = $place4 = "";
         &class_entries_header_html;
         &class_entries_html;
      } else {
         foreach $ii (sort { $a <=> $b } @class_entries) {
print "Line1: $ii\n";
            ($backnumber, $horsenum, $ridernum, $relation, $class, $place1, $tie1, $points1, $place2, $tie2, $points2, $place3, $tie3, $points3, $place4, $tie4, $points4) = split(/~~/, $ii);
            ($regtype, $horsename) = split(/~~/, $horse_list{$horsenum});
            ($ridername) = split(/~~/, $member_list{$ridernum});

            if ($tie1 ne "F") {
               $scored = 1;
               $score1 = $tie1;
               $score2 = $tie2;
               $score3 = $tie3;
               $score4 = $tie4;
            } else {
               $scored = 0;
            }

            if ($flag ne "placing") { $place1 = $place2 = $place3 = $place4 = "___"; }

#print "Places : $place1 / $place2 / $place3 / $place4\n";
#print "Scores : $score1 / $score2 / $score3 / $score4\n";

            if (!$header) {
               &class_entries_header_html;
               $header = 1;
            }

            &class_entries_html;
         }
      }
   }
   else {
      $number_class_entries = $#class_entries + 1;
      if ($number_class_entries <= 0) {
         $backnumber = 0;
         $horsename = "THERE ARE NO ENTRIES IN THIS CLASS";
         $ridername = "";
         $place1 = $place2 = $place3 = $place4 = "";
         &class_entries_header_html;
         &class_entries_html;
      } else {
         while ($number_class_entries > 0) {
            $index = int rand ($#class_entries+1);
            if ($class_entries[$index]) {
print "Line2 = $class_entries[$index]\n";
               ($backnumber, $horsenum, $ridernum, $reltation, $class, $place1, $tie1, $points1, $place2, $tie2, $points2, $place3, $tie3, $points3, $place4, $tie4, $points4) = split(/~~/, $class_entries[$index]);
               ($regtype, $horsename) = split(/~~/, $horse_list{$horsenum});
               ($ridername) = split(/~~/, $member_list{$ridernum});

               if ($tie1 ne "F") {
                  $scored = 1;
                  $score1 = $tie1;
                  $score2 = $tie2;
                  $score3 = $tie3;
                  $score4 = $tie4;
               } else {
                  $scored = 0;
               }

               if ($flag ne "placing") { $place1 = $place2 = $place3 = $place4 = "___"; }

               if (!$header) {
                  &class_entries_header_html;
                  $header = 1;
               }

               &class_entries_html;

               undef $class_entries[$index];
               $number_class_entries--;
            }
         }
      }
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$_${classnumber}.html");
   display_webpage("file://c:/temp/reportfile$$_${classnumber}.html");
}


##################################################################################
##################################################################################
#
#       Show Results For One Back Number
#

#
#  Choose Back Number
#
sub choose_back_number {
   $back_number_window->update();
   $back_number_window->deiconify();
   $back_number_window->raise();
}


#
#  Results For Back Number
#
sub entry_results {
   $back_number_window->withdraw();
   &open_entry_file($showdir);
   &open_judge_file($showdir);
   &open_showinfo_file($showdir);

   $reporttype = "NATIONAL POINTS FOR ENTRY";

#
#  Get judge info for printout
#
   (undef,undef,$shownum1,$shownum2,$shownum3,$shownum4,$judge1,$judge2,$judge3,$judge4,$maxplace) = split(/~~/, $openshowdata);
   $judgeinfo1 = sprintf("%-20s", $judge_list{$judge1}) if ($judge1);
   $judgeinfo2 = sprintf("%-20s", $judge_list{$judge2}) if ($judge2);
   $judgeinfo3 = sprintf("%-20s", $judge_list{$judge3}) if ($judge3);
   $judgeinfo4 = sprintf("%-20s", $judge_list{$judge4}) if ($judge4);

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;

#
#  Get all entries for this back number
#
   %cle = ();
   %back_entries = ();
   @back_entries = grep(/^${backnumber}~~/, @entry_list);
   foreach $entry (@back_entries) {
      ($back, $horse, $rider, $j, $class) = split(/~~/, $entry);
print "Back: $back   Rider: $rider\n";
      $key = "${back}:${rider}";
      $back_entries{$key} .= "$class:";
print "Entry: $back_entries{$key}\n";
   }

   &pointsheet_judge_html;

#
#   Retrieve the Horse information
#
   ($regtype, $horsename, $horsesex, $yearfoaled, $horsecolor, $horsesire, $horsedam, $ownernum) = split(/~~/, $horse_list{$horsenum});
   ($ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $ownerhomephone, $ownerworkphone, $owneremail, $ownersex, $owneryear, $regtype, $ownernumberstatus) = split(/~~/, $member_list{$ownernum});

   foreach $key (sort { $a <=> $b } keys %back_entries) {
      ($backnum, $ridernum) = split(/:/, $key);
      ($ridername, $rideraddress, $ridercity, $riderstate, $riderzip, $riderhomephone, $riderworkphone, $rideremail, $ridersex, $rideryear, $regtype, $ridernumberstatus) = split(/~~/, $member_list{$ridernum});
      $riderinfo = "$ridername\n$rideraddress\n${ridercity}, $riderstate $riderzip";

      &pointsheet_header_html;

print "Classes: $back_entries{$key}\n";
      @classes = split(/:/, $back_entries{$key});

      foreach $classnumber (sort { $a <=> $b } @classes) {
         $total_entries = scalar(grep (/^[a-zA-Z0-9- ]*~~[a-zA-Z0-9- ]*~~[a-zA-Z0-9- ]*~~[a-zA-Z0-9- ]*~~${classnumber}~~/, @entry_list));
print "Class Num: $classnumber   ";
         @ce = grep(/^${backnum}~~${horsenum}~~${ridernum}~~[a-zA-Z0-9- ]*~~${classnumber}~~/, @entry_list);
print "Entry Line: $ce[0]\n";
         (undef, undef, undef, undef, undef, $place1, undef, $points1, $place2, undef, $points2, $place3, undef, $points3, $place4, undef, $points4) = split(/~~/, $ce[0]);

         next if ($classnumber eq "SW" || $classnumber eq "SE" || $classnumber eq "JP");

         $national_points = 0;
         if ($classnumber =~ /^[GO]/) {
            if ($classnumber eq "GG") { $classinfo = "GRAND / RESERVE GELDINGS";       }
            if ($classnumber eq "GM") { $classinfo = "GRAND / RESERVE MARES";          }
            if ($classnumber eq "GS") { $classinfo = "GRAND / RESERVE STALLIONS";      }
            if ($classnumber eq "OG") { $classinfo = "OPEN GRAND / RESERVE GELDINGS";  }
            if ($classnumber eq "OM") { $classinfo = "OPEN GRAND / RESERVE MARES";     }
            if ($classnumber eq "OS") { $classinfo = "OPEN GRAND / RESERVE STALLIONS"; }
         } else {
            $classinfo = sprintf("# %4.4s - %s", $classnumber, $show_class_list{$classnumber});
         }

         if ($place1) { $snum1 = $shownum1; $natl_points1 = $points1; $national_points += $natl_points1; }
         else         { $snum1 = $place1 = $points1 = "&nbsp;"; }
         if ($place2) { $snum2 = $shownum2; $natl_points2 = $points2; $national_points += $natl_points2; }
         else         { $snum2 = $place2 = $points2 = "&nbsp;"; }
         if ($place3) { $snum3 = $shownum3; $natl_points3 = $points3; $national_points += $natl_points3; }
         else         { $snum3 = $place3 = $points3 = "&nbsp;"; }
         if ($place4) { $snum4 = $shownum4; $natl_points4 = $points4; $national_points += $natl_points4; }
         else         { $snum4 = $place4 = $points4 = "&nbsp;"; }
         $total_points += $national_points;

         &pointsheet_list_html;
      }

      print HTML_REPORT "</TABLE><BR><BR>";
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


#
#  Results For Back Number using Local Point structure
#
sub entry_local_results {
   $back_number_window->withdraw();
   &open_entry_file($showdir);
   &open_judge_file($showdir);
   &open_showinfo_file($showdir);

   $reporttype = "LOCAL POINTS FOR ENTRY";

   open(CL, "${showdir}/local_points.txt") or do {
      print "Unable to local point list file\n";
      exit;
   };
   while (<CL>) {
      ($t, @pt) = split(/~~/);
      $local_points{$t} = join(":", @pt);
   }
   close (CL);

#
#  Get judge info for printout
#
   (undef,undef,$shownum1,$shownum2,$shownum3,$shownum4,$judge1,$judge2,$judge3,$judge4,$maxplace) = split(/~~/, $openshowdata);
   $judgeinfo1 = sprintf("%-20s", $judge_list{$judge1}) if ($judge1);
   $judgeinfo2 = sprintf("%-20s", $judge_list{$judge2}) if ($judge2);
   $judgeinfo3 = sprintf("%-20s", $judge_list{$judge3}) if ($judge3);
   $judgeinfo4 = sprintf("%-20s", $judge_list{$judge4}) if ($judge4);

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;

#
#  Get all entries for this back number
#
   %cle = ();
   %back_entries = ();
   @back_entries = grep(/^${backnumber}~~/, @entry_list);
   foreach $entry (@back_entries) {
      ($back, $horse, $rider, $j, $class) = split(/~~/, $entry);
print "Back: $back   Rider: $rider\n";
      $key = "${back}:${rider}";
      $back_entries{$key} .= "$class:";
print "Entry: $back_entries{$key}\n";
   }

   &pointsheet_judge_html;

#
#   Retrieve the Horse information
#
   ($regtype, $horsename, $horsesex, $yearfoaled, $horsecolor, $horsesire, $horsedam, $ownernum) = split(/~~/, $horse_list{$horsenum});
   ($ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $ownerhomephone, $ownerworkphone, $owneremail, $ownersex, $owneryear, $regtype, $ownernumberstatus) = split(/~~/, $member_list{$ownernum});

   foreach $key (sort { $a <=> $b } keys %back_entries) {
      ($backnum, $ridernum) = split(/:/, $key);
      ($ridername, $rideraddress, $ridercity, $riderstate, $riderzip, $riderhomephone, $riderworkphone, $rideremail, $ridersex, $rideryear, $regtype, $ridernumberstatus) = split(/~~/, $member_list{$ridernum});
      $riderinfo = "$ridername\n$rideraddress\n${ridercity}, $riderstate $riderzip";

      &pointsheet_header_html;

print "Classes: $back_entries{$key}\n";
      @classes = split(/:/, $back_entries{$key});

      foreach $classnumber (sort { $a <=> $b } @classes) {
         $total_entries = scalar(grep (/^[a-zA-Z0-9- ]*~~[a-zA-Z0-9- ]*~~[a-zA-Z0-9- ]*~~[a-zA-Z0-9- ]*~~${classnumber}~~/, @entry_list));
print "Class Num: $classnumber   ";
         @ce = grep(/^${backnum}~~${horsenum}~~${ridernum}~~[a-zA-Z0-9- ]*~~${classnumber}~~/, @entry_list);
print "Entry Line: $ce[0]\n";
         (undef, undef, undef, undef, undef, $place1, undef, $points1, $place2, undef, $points2, $place3, undef, $points3, $place4, undef, $points4) = split(/~~/, $ce[0]);

print "Place1: $place1\n";
print "Place2: $place2\n";
print "Place3: $place3\n";
print "Place4: $place4\n";

         next if ($classnumber eq "SW" || $classnumber eq "SE" || $classnumber eq "JP" || $classnumber eq "WJ");

         $local_points = 0;
         next if ($classnumber =~ /^[GO]/);

         $classinfo = sprintf("# %4.4s - %s", $classnumber, $show_class_list{$classnumber});

         local $total = ($total_entries > scalar(keys %local_points)) ? keys %local_points : $total_entries;
         local (@local) = split(/:/, $local_points{$total});

print "Local P: $local_points{$total}\n";
print "Total E: $total_entries\n";
print "Total M: $total\n";

         $local_points = 0;
         if ($place1) { $snum1 = $shownum1; $local_points1 = $local[(${place1}-1)]; $local_points += $local_points1; }
         else         { $snum1 = $place1 = $points1 = "&nbsp;"; }
         if ($place2) { $snum2 = $shownum2; $local_points2 = $local[(${place2}-1)]; $local_points += $local_points2; }
         else         { $snum2 = $place2 = $points2 = "&nbsp;"; }
         if ($place3) { $snum3 = $shownum3; $local_points3 = $local[(${place3}-1)]; $local_points += $local_points3; }
         else         { $snum3 = $place3 = $points3 = "&nbsp;"; }
         if ($place4) { $snum4 = $shownum4; $local_points4 = $local[(${place4}-1)]; $local_points += $local_points4; }
         else         { $snum4 = $place4 = $points4 = "&nbsp;"; }
         $total_points += $local_points;

print "Placing1: $placing_info1\n";
print "Placing2: $placing_info2\n";
print "Placing3: $placing_info3\n";
print "Placing4: $placing_info4\n";

         &pointsheet_local_list_html;
      }

      print HTML_REPORT "</TABLE><BR><BR>";
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}




#
#  Results For Back Number using National and Local Point structure
#
sub entry_natl_local_results {
   $back_number_window->withdraw();
   &open_entry_file($showdir);
   &open_judge_file($showdir);
   &open_showinfo_file($showdir);

   $reporttype = "NATIONAL AND LOCAL POINTS FOR ENTRY";

   open(CL, "${showdir}/local_points.txt") or do {
      print "Unable to local point list file\n";
      exit;
   };
   while (<CL>) {
      ($t, @pt) = split(/~~/);
      $local_points{$t} = join(":", @pt);
   }
   close (CL);

   $judgeinfo1 = $judgeinfo2 = $judgeinfo3 = $judgeinfo4 = "&nbsp;";

#
#  Get judge info for printout
#
   (undef,undef,$shownum1,$shownum2,$shownum3,$shownum4,$judge1,$judge2,$judge3,$judge4,$maxplace) = split(/~~/, $openshowdata);
   $judgeinfo1 = sprintf("%-20s", $judge_list{$judge1}) if ($judge1);
   $judgeinfo2 = sprintf("%-20s", $judge_list{$judge2}) if ($judge2);
   $judgeinfo3 = sprintf("%-20s", $judge_list{$judge3}) if ($judge3);
   $judgeinfo4 = sprintf("%-20s", $judge_list{$judge4}) if ($judge4);

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;

#
#  Get all entries for this back number
#
   %cle = ();
   %back_entries = ();
   @back_entries = grep(/^${backnumber}~~/, @entry_list);
   foreach $entry (@back_entries) {
      ($back, $horse, $rider, $j, $class) = split(/~~/, $entry);
print "Back: $back   Rider: $rider\n";
      $key = "${back}:${rider}";
      $back_entries{$key} .= "$class:";
print "Entry: $back_entries{$key}\n";
   }

   &pointsheet_judge_html;

#
#   Retrieve the Horse information
#
   ($regtype, $horsename, $horsesex, $yearfoaled, $horsecolor, $horsesire, $horsedam, $ownernum) = split(/~~/, $horse_list{$horsenum});
   ($ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $ownerhomephone, $ownerworkphone, $owneremail, $ownersex, $owneryear, $regtype, $ownernumberstatus) = split(/~~/, $member_list{$ownernum});

   foreach $key (sort { $a <=> $b } keys %back_entries) {
      ($backnum, $ridernum) = split(/:/, $key);
      ($ridername, $rideraddress, $ridercity, $riderstate, $riderzip, $riderhomephone, $riderworkphone, $rideremail, $ridersex, $rideryear, $regtype, $ridernumberstatus) = split(/~~/, $member_list{$ridernum});
      $riderinfo = "$ridername\n$rideraddress\n${ridercity}, $riderstate $riderzip";

      &pointsheet_nl_header_html;

print "Classes: $back_entries{$key}\n";
      @classes = split(/:/, $back_entries{$key});

      foreach $classnumber (sort { $a <=> $b } @classes) {
         $total_entries = scalar(grep (/^[a-zA-Z0-9- ]*~~[a-zA-Z0-9- ]*~~[a-zA-Z0-9- ]*~~[a-zA-Z0-9- ]*~~${classnumber}~~/, @entry_list));
print "Class Num: $classnumber   ";
         @ce = grep(/^${backnum}~~${horsenum}~~${ridernum}~~[a-zA-Z0-9- ]*~~${classnumber}~~/, @entry_list);
print "Entry Line: $ce[0]\n";
         (undef, undef, undef, undef, undef, $place1, undef, $points1, $place2, undef, $points2, $place3, undef, $points3, $place4, undef, $points4) = split(/~~/, $ce[0]);

print "Place1: $place1\n";
print "Place2: $place2\n";
print "Place3: $place3\n";
print "Place4: $place4\n";

         next if ($classnumber eq "SW" || $classnumber eq "SE" || $classnumber eq "JP" || $classnumber eq "WJ");

         $classinfo = sprintf("# %4.4s - %s", $classnumber, $show_class_list{$classnumber});

         if ($classnumber =~ /^[GO]/) {
            if ($classnumber eq "GG") { $classinfo = "GRAND / RESERVE GELDINGS";       }
            if ($classnumber eq "GM") { $classinfo = "GRAND / RESERVE MARES";          }
            if ($classnumber eq "GS") { $classinfo = "GRAND / RESERVE STALLIONS";      }
            if ($classnumber eq "OG") { $classinfo = "OPEN GRAND / RESERVE GELDINGS";  }
            if ($classnumber eq "OM") { $classinfo = "OPEN GRAND / RESERVE MARES";     }
            if ($classnumber eq "OS") { $classinfo = "OPEN GRAND / RESERVE STALLIONS"; }
         } else {
            $classinfo = sprintf("# %3.3s - %s", $classnumber, $show_class_list{$classnumber});
         }

#         $nplacing_info1 = $nplacing_info2 = $nplacing_info3 = $nplacing_info4 = "&nbsp;";
#         $lplacing_info1 = $lplacing_info2 = $lplacing_info3 = $lplacing_info4 = "&nbsp;";

#         $natl_points1 = $points1 if ($place1);
#         $natl_points2 = $points2 if ($place2);
#         $natl_points3 = $points3 if ($place3);
#         $natl_points4 = $points4 if ($place4);

         $national_points = 0;
         if ($place1) { $natl_points1 = $points1; $national_points += $natl_points1; }
         else         { $natl_points1 = "&nbsp;"; }
         if ($place2) { $natl_points2 = $points2; $national_points += $natl_points2; }
         else         { $natl_points2 = "&nbsp;"; }
         if ($place3) { $natl_points3 = $points3; $national_points += $natl_points3; }
         else         { $natl_points3 = "&nbsp;"; }
         if ($place4) { $natl_points4 = $points4; $national_points += $natl_points4; }
         else         { $natl_points4 = "&nbsp;"; }

#         if ($place1) { $nplacing_info1 = sprintf("%-5s %5s %6s", substr($shownum1, 4), $place1, $natl_points1); $national_points += $natl_points1; }
#         else         { $nplacing_info1 = sprintf("%-5s            0", substr($shownum1, 4)); }
#         if ($place2) { $nplacing_info2 = sprintf("%-5s %5s %6s", substr($shownum2, 4), $place2, $natl_points2); $national_points += $natl_points2; }
#         else         { $nplacing_info2 = sprintf("%-5s            0", substr($shownum2, 4)); }
#         if ($place3) { $nplacing_info3 = sprintf("%-5s %5s %6s", substr($shownum3, 4), $place3, $natl_points3); $national_points += $natl_points3; }
#         else         { $nplacing_info3 = sprintf("%-5s            0", substr($shownum3, 4)); }
#         if ($place4) { $nplacing_info4 = sprintf("%-5s %5s %6s", substr($shownum4, 4), $place4, $natl_points4); $national_points += $natl_points4; }
#         else         { $nplacing_info4 = sprintf("%-5s            0", substr($shownum4, 4)); }

print "Placing1: $nplacing_info1\n";
print "Placing2: $nplacing_info2\n";
print "Placing3: $nplacing_info3\n";
print "Placing4: $nplacing_info4\n";

         next if ($classnumber =~ /^[GO]/);

         local $total = ($total_entries > scalar(keys %local_points)) ? keys %local_points : $total_entries;
         local (@local) = split(/:/, $local_points{$total});

print "Local P: $local_points{$total}\n";
print "Total E: $total_entries\n";
print "Total M: $total\n";

#         $local_points1 = $local[(${place1}-1)] if ($place1);
#         $local_points2 = $local[(${place2}-1)] if ($place2);
#         $local_points3 = $local[(${place3}-1)] if ($place3);
#         $local_points4 = $local[(${place4}-1)] if ($place4);

         $local_points = 0;
         if ($place1) { $snum1 = $shownum1; $local_points1 = $local[(${place1}-1)]; $local_points += $local_points1; }
         else         { $snum1 = $place1 = "&nbsp;"; $local_points1 = "&nbsp;"; }
         if ($place2) { $snum2 = $shownum2; $local_points2 = $local[(${place2}-1)]; $local_points += $local_points2; }
         else         { $snum2 = $place2 = "&nbsp;"; $local_points2 = "&nbsp;"; }
         if ($place3) { $snum3 = $shownum3; $local_points3 = $local[(${place3}-1)]; $local_points += $local_points3; }
         else         { $snum3 = $place3 = "&nbsp;"; $local_points3 = "&nbsp;"; }
         if ($place4) { $snum4 = $shownum4; $local_points4 = $local[(${place4}-1)]; $local_points += $local_points4; }
         else         { $snum4 = $place4 = "&nbsp;"; $local_points4 = "&nbsp;"; }

#         if ($place1) { $lplacing_info1 = sprintf("%-5s %5s %6s", substr($shownum1, 4), $place1, $local_points1); $local_points += $local_points1; }
#         else         { $lplacing_info1 = sprintf("%-5s            0", " "); }
#         if ($place2) { $lplacing_info2 = sprintf("%-5s %5s %6s", substr($shownum2, 4), $place2, $local_points2); $local_points += $local_points2; }
#         else         { $lplacing_info2 = sprintf("%-5s            0", " "); }
#         if ($place3) { $lplacing_info3 = sprintf("%-5s %5s %6s", substr($shownum3, 4), $place3, $local_points3); $local_points += $local_points3; }
#         else         { $lplacing_info3 = sprintf("%-5s            0", " "); }
#         if ($place4) { $lplacing_info4 = sprintf("%-5s %5s %6s", substr($shownum4, 4), $place4, $local_points4); $local_points += $local_points4; }
#         else         { $lplacing_info4 = sprintf("%-5s            0", " "); }

print "Placing1: $lplacing_info1\n";
print "Placing2: $lplacing_info2\n";
print "Placing3: $lplacing_info3\n";
print "Placing4: $lplacing_info4\n";

         &pointsheet_natl_local_list_html;
      }

      print HTML_REPORT "</TABLE><BR><BR>";
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


#
#  National Points for Grand & Reserve
#
sub grand_points {
}


#
#  Classes For Back Number
#
sub entry_classes {
   $back_number_window->withdraw();
   &open_entry_file($showdir);
   &open_judge_file($showdir);
   &open_horse_file($showdir);

   $reporttype = "INDIVIDUAL CLASSES";

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;

#
#  Get all entries for this back number
#

   %back_entries = ();
   @back_entries = grep(/^${backnumber}~~/, @entry_list);
   foreach $entry (@back_entries) {
      ($back, $horse, $rider, $j, $class) = split(/~~/, $entry);
print "Back: $back   Rider: $rider\n";
      $key = "${back}:${rider}";
      $back_entries{$key} .= "$class:";
print "Entry: $back_entries{$key}\n";
   }

#
#   Retrieve the Horse information
#
   ($regtype, $horsename, $horsesex, $yearfoaled, $horsecolor, $horsesire, $horsedam, $ownernum) = split(/~~/, $horse_list{$horsenum});
   ($ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $ownerhomephone, $ownerworkphone, $owneremail, $ownersex, $owneryear, $regtype, $ownernumberstatus) = split(/~~/, $member_list{$ownernum});

   foreach $key (sort { $a <=> $b } keys %back_entries) {
      ($backnum, $ridernum) = split(/:/, $key);
      ($ridername, $rideraddress, $ridercity, $riderstate, $riderzip, $riderhomephone, $riderworkphone, $rideremail, $ridersex, $rideryear, $regtype, $ridernumberstatus) = split(/~~/, $member_list{$ridernum});
      $riderinfo = "$ridername\n$rideraddress\n${ridercity}, $riderstate $riderzip";

      &riderentries_header_html;

      @classes = split(/:/, $back_entries{$key});

      foreach $classnumber (sort { $a <=> $b } @classes) {

         if ($classnumber =~ /^G/ || $classnumber =~ /^O/) {
            if ($classnumber eq "GG") { $classname = "GRAND / RESERVE GELDINGS"; }
            if ($classnumber eq "GM") { $classname = "GRAND / RESERVE MARES"; }
            if ($classnumber eq "GS") { $classname = "GRAND / RESERVE STALLIONS"; }
            if ($classnumber eq "OG") { $classinfo = "OPEN GRAND / RESERVE GELDINGS";  }
            if ($classnumber eq "OM") { $classinfo = "OPEN GRAND / RESERVE MARES";     }
            if ($classnumber eq "OS") { $classinfo = "OPEN GRAND / RESERVE STALLIONS"; }
         } else {
            $classname =  $show_class_list{$classnumber};
         }

         &riderentries_list_html;
      }

      print HTML_REPORT "</TABLE><BR><BR><BR>";
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


##################################################################################
##################################################################################
#
#  Once a rider is selected from the list, put that name on the window label
#  and put their classes in the class listbox
#

sub rider_select {
   ($ridernum, $ridername) = split(/ : /, $rl_names_lb->get($rl_names_lb->curselection));
   $ridernum =~ s/^\s*(.*?)\s*$/$1/g;
   $rider_list_window->withdraw();
   &save_one_entry($classnumber) if ($rflag ne "IR");
}


##################################################################################
##################################################################################
#
#  Once a rider is selected from the list, put that name on the window label
#  and put their classes in the class listbox
#

sub hp_select {
   my $hp_name = $hp_names_lb->get($hp_names_lb->curselection);
   $hp_list_window->withdraw();
   print "Selected division: $hp_name\n";
   &high_point_results($hp_name);
}


##################################################################################
##################################################################################
#
#  Count up the number of entries, then break them out into
#  Open, Non-Pro, and Youth entries
#

sub final_entry_count {
   &open_showinfo_file($showdir);
   &open_entry_file($showdir);
   &open_local_class_file();

   $open_entries = $nonpro_entries = $youth_entries = 0;

#
#  Remove Local classes and Grand/Reserve from the class list
#  @show_classes is a list of all the classes in the show
#  @entry_list   is a list of the entries in the show
#
   my @locl = grep !/~~G[GMS]~~/, @entry_list;
   @entry_list = @locl;

   foreach $ll (@local_class_list) {
      my ($ln, $j, $lc) = split(/~/, $ll);

      my @sloc = grep /$lc/, @show_classes;
      ($cn, $j) = split(/\)/, $sloc[0]);
      my @locl = grep !/^\d+~~[P]{0,1}\d+~~[P]{0,1}\d+~~[a-zA-Z- ]*~~$cn~~/, @entry_list;
      @entry_list = @locl;

      my @list = grep !/$lc/, @show_classes;
      @show_classes = @list;
   }

#
#  Count up the entries
#
   $total_entries = $#entry_list + 1;
   $entry_count = $#entry_list + 1;
print "Total Entries: $total_entries\n";

   $reporttype = "CLASS LIST WITH ENTRY COUNTS AND DIVISION TOTALS";

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;
   &finalcount_header_html;

print "Classes: ", scalar(@show_classes), "\n";

   foreach $ii (@show_classes) {
print "II = $ii\n";
      @class_entries = ();
      ($classnum, $classname) = split(/\) /, $ii);
      foreach $jj (@entry_list) {
         (undef, undef, undef, undef, $cn, undef) = split(/~~/, $jj);
         push(@class_entries, $jj) if ($cn eq $classnum);
      }
      $entries = $#class_entries+1;

      if ($classname =~ /NP /) {
         $nonpro_entries += $entries;
      } else {
         if (($classname =~ /& Under$/) || ($classname =~ /\d$/)) {
            $youth_entries += $entries;
         } else {
            $open_entries += $entries;
         }
      }
      &finalcount_list_html;
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


##################################################################################
##################################################################################
#
#       High Point Report
#

sub high_point_results {
   &open_showinfo_file($showdir);
   &open_entry_file($showdir);
   &open_member_file($showdir);
   &open_horse_file($showdir);
   &open_report_high_point_file($showdir);

   open (LOG, ">${showdir}/highpoint.log");

   $reporttype = "HIGH POINT RESULTS";

   open(CL, "${showdir}/local_points.txt") or do {
      print "Unable to local point list file\n";
      exit;
   };
   while (<CL>) {
      ($t, @pt) = split(/~~/);
      $local_points{$t} = join(":", @pt);
   }
   close (CL);


#
#  FOR THE SELECTED HIGH POINT DIVISION, COMPUTE THE HIGH POINTS
#

print LOG "Selected Division: $_[0]\n";

   $hp_division = $_[0];
   $hp_type     = $hp_report{$hp_division}[0];
   $hp_required = $hp_report{$hp_division}[1];
   $hpc         = $hp_report{$hp_division}[2];
   $hp_min_age  = $hp_report{$hp_division}[3];
   $hp_max_age  = $hp_report{$hp_division}[4];

print LOG "Type: $hp_type\n";
print LOG "Reqd: $hp_required\n";
print LOG "Min/Max: $hp_min_age/$hp_max_age\n";
print LOG "Classes: $hpc\n";

#      ($hp_division, $hp_type, $hpc) = split(/~~/, $ii);
#      ($hp_division, $hp_min_age, $hp_max_age, $hp_type, $hpc) = split(/~~/, $ii);
   (@hp_classes) = split(/\,/, $hpc);

print LOG "\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n";
print LOG "DIVISION: $hp_division\n";
print LOG "CLASSES : @hp_classes\n\n";
   %by_rider = ();
   %by_horse = ();
   %by_both = ();


   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;
   &highpoint_header_html;


#
#  FOR EACH CLASS IN THE DIVISION
#

   foreach $hp_class (@hp_classes) {
      chomp($hp_class);
      @total_entries = ();
print LOG "-----------------\n";
print LOG "CLASS   : $hp_class\n";

#
#  GET ENTRIES IN THE CLASS
#

      @cl_entry = grep (/^[a-zA-Z0-9- ]*~~[a-zA-Z0-9- ]*~~[a-zA-Z0-9- ]*~~[a-zA-Z0-9- ]*~~$hp_class~~/, @entry_list);
      @total_entries = (@total_entries, @cl_entry);
      my $total = (scalar(@total_entries) > scalar(keys %local_points)) ? keys %local_points : @total_entries;
      my (@local) = split(/:/, $local_points{$total});

print LOG "ENTRIES : $total : ", scalar(@total_entries), " (real)\n";
print LOG "POINTS  : $local_points{$total}\n";
foreach (@total_entries) {
   print LOG "$_\n";
}


#
#  FOR EACH RIDER IN THE CLASS
#

      foreach (@total_entries) {
         $n_firsts = $n_seconds = $n_thirds = $n_points = 0;
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);

#
#  FIRST, CHECK THE AGE OF THE RIDER IF THE
#  HIGH POINT DIVISION HAS AN AGE REQUIREMENT
#

         if (($hp_min_age >= 0) || ($hp_max_age >= 0)) {
            ($j, $j, $j, $j, $j, $j, $j, $j, $j, $birthyear, $j, $j) = split(/~~/, $member_list{$r});
#print LOG "INFO: $member_list{$r}\n";
#ROBERTS, KIRSTEN~~3546 PR 2562~~ROYSE CITY~~TX~~75189~~972-636-2189~~~~~~FEMALE~~1994~~NOVICE YOUTH~~CURRENT
#
print LOG "RIDER HAS NO BIRTH YEAR\n" if (! $birthyear);
            if ($birthyear) {
               $age = $year - $birthyear - 1;
print LOG "MIN AGE: $hp_min_age\n";
print LOG "MAX AGE: $hp_max_age\n";
print LOG "CHECKING: $r\tYEAR: $birthyear\tAGE: $age\n";
               next if (($age < $hp_min_age) || ($age > $hp_max_age));
            }
         }

         $n_firsts++  if (($p1) && ($p1 == 1));
         $n_firsts++  if (($p2) && ($p2 == 1));
         $n_firsts++  if (($p3) && ($p3 == 1));
         $n_firsts++  if (($p4) && ($p4 == 1));
         $n_seconds++ if (($p1) && ($p1 == 2));
         $n_seconds++ if (($p2) && ($p2 == 2));
         $n_seconds++ if (($p3) && ($p3 == 2));
         $n_seconds++ if (($p4) && ($p4 == 2));
         $n_thirds++  if (($p1) && ($p1 == 3));
         $n_thirds++  if (($p2) && ($p2 == 3));
         $n_thirds++  if (($p3) && ($p3 == 3));
         $n_thirds++  if (($p4) && ($p4 == 3));
         $n_points += $local[$p1-1] if ($p1);
         $n_points += $local[$p2-1] if ($p2);
         $n_points += $local[$p3-1] if ($p3);
         $n_points += $local[$p4-1] if ($p4);

         if (defined($by_rider{$r})) {
print LOG "By Rider: $r\n";
print LOG "Points: $n_points\n";
            $by_rider{$r}[0] ++;
            $by_rider{$r}[1] += $n_points;
            $by_rider{$r}[2] += $n_firsts;
            $by_rider{$r}[3] += $n_seconds;
            $by_rider{$r}[4] += $n_thirds;
         } else {
print LOG "By Rider: $r\n";
print LOG "Points: $n_points\n";
            $by_rider{$r}[0] = 1;
            $by_rider{$r}[1] = $n_points;
            $by_rider{$r}[2] = $n_firsts;
            $by_rider{$r}[3] = $n_seconds;
            $by_rider{$r}[4] = $n_thirds;
         }

         if (defined($by_horse{$h})) {
print LOG "By Horse: $h\n";
print LOG "Points: $n_points\n";
            $by_horse{$h}[0] ++;
            $by_horse{$h}[1] += $n_points;
            $by_horse{$h}[2] += $n_firsts;
            $by_horse{$h}[3] += $n_seconds;
            $by_horse{$h}[4] += $n_thirds;
         } else {
print LOG "By Horse: $h\n";
print LOG "Points: $n_points\n";
            $by_horse{$h}[0] = 1;
            $by_horse{$h}[1] = $n_points;
            $by_horse{$h}[2] = $n_firsts;
            $by_horse{$h}[3] = $n_seconds;
            $by_horse{$h}[4] = $n_thirds;
         }

         $k = "${r}~${h}";
         if (defined($by_both{$k})) {
print LOG "By Both: $k\n";
print LOG "Points: $n_points\n";
            $by_both{$k}[0] ++;
            $by_both{$k}[1] += $n_points;
            $by_both{$k}[2] += $n_firsts;
            $by_both{$k}[3] += $n_seconds;
            $by_both{$k}[4] += $n_thirds;
         } else {
print LOG "By Both: $k\t";
print LOG "Points: $n_points\n";
            $by_both{$k}[0] = 1;
            $by_both{$k}[1] = $n_points;
            $by_both{$k}[2] = $n_firsts;
            $by_both{$k}[3] = $n_seconds;
            $by_both{$k}[4] = $n_thirds;
         }
      }
   }

#
#  Place the resulting data into an array
#
   @hp_data = ();
   if ($hp_type eq "R") {
      foreach $key (sort keys %by_rider) {
print LOG "By rider: $hp_required ... $by_rider{$key}[0]\n";
         next if ($by_rider{$key}[0] < $hp_required);
         $hp_sorter = ($by_rider{$key}[1]+10) * 100000;
         $hp_sorter += ($by_rider{$key}[2]*10000) + ($by_rider{$key}[3]*1000) + ($by_rider{$key}[4]*100) + ($by_rider{$key}[0]*10);
         $ii = $hp_sorter ."~~". $by_rider{$key}[1] ."~~". $by_rider{$key}[2] ."~~". $by_rider{$key}[3] ."~~". $by_rider{$key}[4] ."~~". $by_rider{$key}[0] ."~~". $key;
print LOG "INTO R: $ii\n";
         push(@hp_data, $ii);
      }
   } elsif ($hp_type eq "H") {
      foreach $key (sort keys %by_horse) {
print LOG "By horse: $hp_required ... $by_horse{$key}[0]\n";
         next if ($by_horse{$key}[0] < $hp_required);
         $hp_sorter = ($by_horse{$key}[1]+10) * 100000;
         $hp_sorter += ($by_horse{$key}[2]*10000) + ($by_horse{$key}[3]*1000) + ($by_horse{$key}[4]*100) + ($by_horse{$key}[0]*10);
         $ii = $hp_sorter ."~~". $by_horse{$key}[1] ."~~". $by_horse{$key}[2] ."~~". $by_horse{$key}[3] ."~~". $by_horse{$key}[4] ."~~". $by_horse{$key}[0] ."~~". $key;
print LOG "INTO H: $ii\n";
         push(@hp_data, $ii);
      }
   } elsif ($hp_type eq "B") {
      foreach $key (sort keys %by_both) {
print LOG "By both: $hp_required ... $by_both{$key}[0]\n";
         next if ($by_both{$key}[0] < $hp_required);
         $hp_sorter = ($by_both{$key}[1]+10) * 100000;
         $hp_sorter += ($by_both{$key}[2]*10000) + ($by_both{$key}[3]*1000) + ($by_both{$key}[4]*100) + ($by_both{$key}[0]*10);
         $ii = $hp_sorter ."~~". $by_both{$key}[1] ."~~". $by_both{$key}[2] ."~~". $by_both{$key}[3] ."~~". $by_both{$key}[4] ."~~". $by_both{$key}[0] ."~~". $key;
print LOG "INTO B: $ii\n";
         push(@hp_data, $ii);
      }
   }

   foreach $ii (sort { $b <=> $a } @hp_data) {
print LOG "HP DATA: $ii\n";
      ($hp_sorter, $hp_points, $hp_firsts, $hp_seconds, $hp_thirds, $hp_numclasses, $hp_num) = split(/~~/, $ii);
      if ($hp_type eq "R") {
         ($hp_name, $j, $j, $j, $j, $j, $j, $j, $j, $birthyear, $j, $j) = split(/~~/, $member_list{$hp_num});
         $hp_name = $hp_name . " **" if (! $birthyear);
      } elsif ($hp_type eq "H") {
#         ($ht, $hms, $hp_name) = split(/~~/, $horse_list{$hp_num});
         ($ht, $hp_name) = split(/~~/, $horse_list{$hp_num});
      } elsif ($hp_type eq "B") {
    ($hp_num1, $hp_num2) = split(/~/, $hp_num);
         ($hpm) = split(/~~/, $member_list{$hp_num1});
         ($hpt, $hph) = split(/~~/, $horse_list{$hp_num2});
         $hp_name = "${hpm} / ${hph}";
      }
print LOG "Writing $reporttype to file\n";

      &highpoint_list_html;
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


##################################################################################
##################################################################################
#
#       National Show Report
#

sub national_results {
   appaloosa_national_results() if ($showbreed eq "appaloosa");
   buckskin_national_results()  if ($showbreed eq "buckskin");
   nsba_national_results()      if ($showbreed eq "nsba");
}


##################################################################################
##################################################################################
#
#       APPALOOSA
#
#       National Show Report
#

sub appaloosa_national_results {
   &display_message("Compiling National Show Results Files - Please Be Patient!", 0, "i");

   open (LOG, ">temp/logfile.txt") or die "Unable to open temp file: $!";
   select ((select(LOG), $| = 1)[0]);

   &open_showinfo_file($showdir);
   &open_entry_file($showdir);
   &open_judge_file;
   &open_member_file;
   &open_horse_file;
   &open_division_file;
   &open_national_class_file;

   open(GR, "${showdir}/gr_stallion.txt") or do {
      print "Unable to open GR Stallion file: $!";
      exit;
   };
   chomp(@gs_list = <GR>);
   close(GR);
print "GS List: @gs_list\n";

   open(GR, "${showdir}/gr_gelding.txt") or do {
      print "Unable to open GR Gelding file: $!";
      exit;
   };
   chomp(@gg_list = <GR>);
   close(GR);
print "GG List: @gg_list\n";

   open(GR, "${showdir}/gr_mare.txt") or do {
      print "Unable to open GR Mare file: $!";
      exit;
   };
   chomp(@gm_list = <GR>);
   close(GR);
print "GM List: @gm_list\n";

   @div_list = grep(!/^D/i, @division_list);
   open(SF, "${showdir}/classes.txt") or do {
      print "Unable to open show classes file: $!";
      exit;
   };
   foreach $ii (<SF>) {
      chomp($ii);
      ($lcnum, $cname) = split(/\) /, $ii);
print "LCNum: $lcnum <=> CName: $cname <=> ";
      @res = grep(/${cname}$/i, @div_list);
      ($ncnum, $ncname) = split(/~/, @res[0]);
print "NCNum: $ncnum\n";

      if ($ncnum =~ /^A/) {
         $ac{$ncnum}[0] = $lcnum;
         $ac{$ncnum}[1] = $ncname;
print "AC: $ac{$ncnum}[0] <=> $ac{$ncnum}[1]\n";
      }
      if ($ncnum =~ /^N/) {
         $nc{$ncnum}[0] = $lcnum;
         $nc{$ncnum}[1] = $cname;
print "NC: $nc{$ncnum}[0] <=> $nc{$ncnum}[1]\n";
      }
      if ($ncnum =~ /^O/) {
         $oc{$ncnum}[0] = $lcnum;
         $oc{$ncnum}[1] = $ncname;
print "OC: $oc{$ncnum}[0] <=> $oc{$ncnum}[1]\n";
      }
      if ($ncnum =~ /^Y/) {
         $yc{$ncnum}[0] = $lcnum;
         $yc{$ncnum}[1] = $cname;
print "YC: $yc{$ncnum}[0] <=> $yc{$ncnum}[1]\n";
      }
   }
   close(SF);

   @gs = grep(/~~GS~~/, @entry_list);
print "Grand Stallion: @gs\n";
   @gg = grep(/~~GG~~/, @entry_list);
print "Grand Gelding : @gg\n";
   @gm = grep(/~~GM~~/, @entry_list);
print "Grand Mare    : @gm\n";

#   $oc{'GS00'}[0] = "GS";
#   $oc{'GS00'}[1] = "Grand \& Reserve Champion Stallions";
#   $oc{'GM00'}[0] = "GM";
#   $oc{'GM00'}[1] = "Grand \& Reserve Champion Mares";
#   $oc{'GG00'}[0] = "GG";
#   $oc{'GG00'}[1] = "Grand \& Reserve Champion Geldings";

   ($showname,$showdate,$shownum[0],$shownum[1],$shownum[2],$shownum[3],$judge[0],$judge[1],$judge[2],$judge[3],$maxplace,$breed,$showlocation) = split(/~~/, $openshowdata);

#
#  Ok, do this for each defined show
#
   foreach $index (0 .. $#shownum) {
      next if (!$shownum[$index]);
print LOG "Show: $shownum[$index]\n";

#
#  Create temp file for show results
#
      open (RESULTS, ">showresults/$shownum[$index].txt") or die "Unable to open temp file: $!";
      select ((select(RESULTS), $| = 1)[0]);

#
#  JUDGE INFORMATION
#
      $jnum = sprintf("%07d", $judge[$index]);
      $line = sprintf("J%-9.9s", $shownum[$index]);
      $line .= " "x46;
      $line .= sprintf("%7s%-25.25s", $jnum, $judge_list{$judge[$index]});
      print RESULTS "$line\n";

#
#  DETAIL LISTING (CHAPS)
#
      foreach $key (sort keys %ac) {
         $class = $ac{$key}[0];
         @cl_entry = grep (/^[0-9]+~~[A-Z]?[0-9]+~~[A-Z]?[0-9]+~~[A-Z-]*~~$class~~/, @entry_list);
         $tiecount[0] = grep (/^[0-9]+~~[A-Z]?[0-9]+~~[A-Z]?[0-9]+~~[a-zA-Z-]*~~[0-9]+~~[0-9]+~~T~~/, @cl_entry);
         $tiecount[1] = grep (/^[0-9]+~~[A-Z]?[0-9]+~~[A-Z]?[0-9]+~~[a-zA-Z-]*~~[0-9]+~~[0-9]+~~T~~[0-9]+~~T~~/, @cl_entry);
         $tiecount[2] = grep (/^[0-9]+~~[A-Z]?[0-9]+~~[A-Z]?[0-9]+~~[a-zA-Z-]*~~[0-9]+~~[0-9]+~~T~~[0-9]+~~T~~[0-9]+~~T~~/, @cl_entry);
         $tiecount[3] = grep (/^[0-9]+~~[A-Z]?[0-9]+~~[A-Z]?[0-9]+~~[a-zA-Z-]*~~[0-9]+~~[0-9]+~~T~~[0-9]+~~T~~[0-9]+~~T~~[0-9]+~~T~~/, @cl_entry);
         $num_entries = $#cl_entry + 1;
         next if ($num_entries < 0);

 print LOG "Class: $key  $ac{$key}[0]  $ac{$key}[1]\n";
         $ckey = $key;
         $linestart = sprintf("D%-9.9s%4s%03d", $shownum[$index], $ckey, $num_entries);

#
#  Display each entry in the class, placed up to 8
#
         foreach $cle (@cl_entry) {
            $line = $linestart;
            $tiecount = 0;
            $relation = " ";
            $champ = " ";
            ($b, $h, $r, $rl, $c, $p[0], $t[0], $po[0], $p[1], $t[1], $po[1], $p[2], $t[2], $po[2], $p[3], $t[3], $po[3]) = split(/~~/, $cle);
            ($horseregtype, $horsename, undef, $horsefoalyear, $horsecolor, $horsesire, $horsedam, $horseowner) = split(/~~/, $horse_list{$h});
            ($ridername, $rideraddress, $ridercity, $riderstate, $riderzip, $riderhomephone, $riderworkphone, $rideremail, $ridersex, $rideryear, $ridertype, $ridernumberstatus) = split(/~~/, $member_list{$r});
            ($ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $ownerhomephone, $ownerworkphone, $owneremail, $ownersex, $owneryear, $ownertype, $ownernumberstatus) = split(/~~/, $member_list{$horseowner});
            $pend      = " " if ($ridernumberstatus eq "CURRENT");
            if ($r =~ /^U/) {
               $pend      = "U" ;
               $rnum = sprintf("%07d", (substr($r, 1)));
            } else {
               if ($r =~ /^P/) {
                  $pend      = "P";
                  $rnum = sprintf("%07d", (substr($r, 1)));
               } else {
                  $rnum = sprintf("%07d", $r);
               }
            }
            $hnum = sprintf("%07d", $h);

printf LOG "Entry: %-5dHorse: %-25.25sRider: %-30.30s\n", $b, $horsename, $ridername;
print LOG "$cle\n";
            $tiecount  = $tiecount[$index] if ($t[$index] eq "T");
            if (grep(/$c/, @gs_list)) {
print LOG "Class is in GS List\n";
               foreach $grand (@gs) {
                  ($gb, $gh, $gr, $grl, $gc, $gp[0], $gt[0], $gpo[0], $gp[1], $gt[1], $gpo[1], $gp[2], $gt[2], $gpo[2], $gp[3], $gt[3], $gpo[3]) = split(/~~/, $grand);
                  if ($gb eq $b) {
                     $champ = "G" if ($gp[$index] == 1);
                     $champ = "R" if ($gp[$index] == 2);
                  }
               }
            }
            if (grep(/$c/, @gm_list)) {
print LOG "Class is in GM List\n";
               foreach $grand (@gm) {
                  ($gb, $gh, $gr, $grl, $gc, $gp[0], $gt[0], $gpo[0], $gp[1], $gt[1], $gpo[1], $gp[2], $gt[2], $gpo[2], $gp[3], $gt[3], $gpo[3]) = split(/~~/, $grand);
                  if ($gb eq $b) {
                     $champ = "G" if ($gp[$index] == 1);
                     $champ = "R" if ($gp[$index] == 2);
                  }
               }
            }
            if (grep(/$c/, @gg_list)) {
print LOG "Class is in GG List\n";
               foreach $grand (@gg) {
                  ($gb, $gh, $gr, $grl, $gc, $gp[0], $gt[0], $gpo[0], $gp[1], $gt[1], $gpo[1], $gp[2], $gt[2], $gpo[2], $gp[3], $gt[3], $gpo[3]) = split(/~~/, $grand);
                  if ($gb eq $b) {
                     $champ = "G" if ($gp[$index] == 1);
                     $champ = "R" if ($gp[$index] == 2);
                  }
               }
            }

            $line .= sprintf("%02d%1d%1s%04d", $p[$index], $tiecount, $champ, $b);
            $line .= sprintf("%2.2s%7s%-17.17s%4d", $horseregtype, $hnum, $horsename, $horsefoalyear);
            $line .= sprintf("%1.1s%7s%-25.25s%-25.25s%-15.15s%-2.2s%-11.11s", $pend, $rnum, $ridername, $rideraddress, $ridercity, $riderstate, $riderzip);
            $line .= sprintf("%-25.25s%-25.25s%-15.15s%-2.2s%-11.11s%-15.15s", $ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $relation);
print LOG "$line\n";

            print RESULTS uc($line) ."\n" if ($p[$index] != 0);
         }
print LOG "\n";
      }


#
#  Display each entry in the class, placed up to 8
#
         foreach $cle (@cl_entry) {
            $line = $linestart;
            $tiecount = 0;
            $relation = " ";
            $champ = " ";
            ($b, $h, $r, $rl, $c, $p[0], $t[0], $po[0], $p[1], $t[1], $po[1], $p[2], $t[2], $po[2], $p[3], $t[3], $po[3]) = split(/~~/, $cle);
            ($horseregtype, $horsename, undef, $horsefoalyear, $horsecolor, $horsesire, $horsedam, $horseowner) = split(/~~/, $horse_list{$h});
            ($ridername, $rideraddress, $ridercity, $riderstate, $riderzip, $riderhomephone, $riderworkphone, $rideremail, $ridersex, $rideryear, $ridertype, $ridernumberstatus) = split(/~~/, $member_list{$r});
            ($ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $ownerhomephone, $ownerworkphone, $owneremail, $ownersex, $owneryear, $ownertype, $ownernumberstatus) = split(/~~/, $member_list{$horseowner});
            $pend      = " " if ($ridernumberstatus eq "CURRENT");
            if ($r =~ /^U/) {
               $pend      = "U" ;
               $rnum = sprintf("%07d", (substr($r, 1)));
            } else {
               if ($r =~ /^P/) {
                  $pend      = "P";
                  $rnum = sprintf("%07d", (substr($r, 1)));
               } else {
                  $rnum = sprintf("%07d", $r);
               }
            }
            $hnum = sprintf("%07d", $h);

printf LOG "Entry: %-5dHorse: %-25.25sRider: %-30.30s\n", $b, $horsename, $ridername;
print LOG "$cle\n";
            $tiecount  = $tiecount[$index] if ($t[$index] eq "T");
            if (grep(/$c/, @gs_list)) {
print LOG "Class is in GS List\n";
               foreach $grand (@gs) {
                  ($gb, $gh, $gr, $grl, $gc, $gp[0], $gt[0], $gpo[0], $gp[1], $gt[1], $gpo[1], $gp[2], $gt[2], $gpo[2], $gp[3], $gt[3], $gpo[3]) = split(/~~/, $grand);
                  if ($gb eq $b) {
                     $champ = "G" if ($gp[$index] == 1);
                     $champ = "R" if ($gp[$index] == 2);
                  }
               }
            }
            if (grep(/$c/, @gm_list)) {
print LOG "Class is in GM List\n";
               foreach $grand (@gm) {
                  ($gb, $gh, $gr, $grl, $gc, $gp[0], $gt[0], $gpo[0], $gp[1], $gt[1], $gpo[1], $gp[2], $gt[2], $gpo[2], $gp[3], $gt[3], $gpo[3]) = split(/~~/, $grand);
                  if ($gb eq $b) {
                     $champ = "G" if ($gp[$index] == 1);
                     $champ = "R" if ($gp[$index] == 2);
                  }
               }
            }
            if (grep(/$c/, @gg_list)) {
print LOG "Class is in GG List\n";
               foreach $grand (@gg) {
                  ($gb, $gh, $gr, $grl, $gc, $gp[0], $gt[0], $gpo[0], $gp[1], $gt[1], $gpo[1], $gp[2], $gt[2], $gpo[2], $gp[3], $gt[3], $gpo[3]) = split(/~~/, $grand);
                  if ($gb eq $b) {
                     $champ = "G" if ($gp[$index] == 1);
                     $champ = "R" if ($gp[$index] == 2);
                  }
               }
            }

            $line .= sprintf("%02d%1d%1s%04d", $p[$index], $tiecount, $champ, $b);
            $line .= sprintf("%2.2s%7s%-17.17s%4d", $horseregtype, $hnum, $horsename, $horsefoalyear);
            $line .= sprintf("%1.1s%7s%-25.25s%-25.25s%-15.15s%-2.2s%-11.11s", $pend, $rnum, $ridername, $rideraddress, $ridercity, $riderstate, $riderzip);
            $line .= sprintf("%-25.25s%-25.25s%-15.15s%-2.2s%-11.11s%-15.15s", $ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $relation);
print LOG "$line\n";

            print RESULTS uc($line) ."\n" if ($p[$index] != 0);
         }
print LOG "\n";
      }


#
#  DETAIL LISTING (NON-PRO)
#
      foreach $key (sort keys %nc) {
         $class = $nc{$key}[0];
         @cl_entry = grep (/^[0-9]+~~[A-Z]?[0-9]+~~[A-Z]?[0-9]+~~[a-zA-Z-]*~~$class~~/, @entry_list);
         $tiecount[0] = grep (/^[0-9]+~~[A-Z]?[0-9]+~~[A-Z]?[0-9]+~~[a-zA-Z-]*~~[0-9]+~~[0-9]+~~T~~/, @cl_entry);
         $tiecount[1] = grep (/^[0-9]+~~[A-Z]?[0-9]+~~[A-Z]?[0-9]+~~[a-zA-Z-]*~~[0-9]+~~[0-9]+~~T~~[0-9]+~~T~~/, @cl_entry);
         $tiecount[2] = grep (/^[0-9]+~~[A-Z]?[0-9]+~~[A-Z]?[0-9]+~~[a-zA-Z-]*~~[0-9]+~~[0-9]+~~T~~[0-9]+~~T~~[0-9]+~~T~~/, @cl_entry);
         $tiecount[3] = grep (/^[0-9]+~~[A-Z]?[0-9]+~~[A-Z]?[0-9]+~~[a-zA-Z-]*~~[0-9]+~~[0-9]+~~T~~[0-9]+~~T~~[0-9]+~~T~~[0-9]+~~T~~/, @cl_entry);
         $num_entries = $#cl_entry + 1;
         next if ($num_entries < 0);

print LOG "Class: $key  $nc{$key}[0]  $nc{$key}[1]\n";
         $linestart = sprintf("D%-9.9s%4s%03d", $shownum[$index], $key, $num_entries);

#
#  Display each entry in the class, placed up to 8
#
         foreach $cle (@cl_entry) {
            $line = $linestart;
            $tiecount = 0;
            $relation = " ";
            $champ = " ";
            ($b, $h, $r, $rl, $c, $p[0], $t[0], $po[0], $p[1], $t[1], $po[1], $p[2], $t[2], $po[2], $p[3], $t[3], $po[3]) = split(/~~/, $cle);
            ($horseregtype, $horsename, undef, $horsefoalyear, $horsecolor, $horsesire, $horsedam, $horseowner) = split(/~~/, $horse_list{$h});
            ($ridername, $rideraddress, $ridercity, $riderstate, $riderzip, $riderhomephone, $riderworkphone, $rideremail, $ridersex, $rideryear, $ridertype, $ridernumberstatus) = split(/~~/, $member_list{$r});
            ($ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $ownerhomephone, $ownerworkphone, $owneremail, $ownersex, $owneryear, $ownertype, $ownernumberstatus) = split(/~~/, $member_list{$horseowner});
            $pend      = " " if ($ridernumberstatus eq "CURRENT");
            if ($r =~ /^U/) {
               $pend      = "U" ;
               $rnum = sprintf("%07d", (substr($r, 1)));
            } else {
               if ($r =~ /^P/) {
                  $pend      = "P";
                  $rnum = sprintf("%07d", (substr($r, 1)));
               } else {
                  $rnum = sprintf("%07d", $r);
               }
            }
            $hnum = sprintf("%07d", $h);
printf LOG "Entry: %-5dHorse: %-25.25sRider: %-30.30s\n", $b, $horsename, $ridername;

            $relation  = $rl;
            $tiecount  = $tiecount[$index] if ($t[$index] eq "T");

            $line .= sprintf("%02d%1d%1s%04d", $p[$index], $tiecount, $champ, $b);
            $line .= sprintf("%2.2s%7s%-17.17s%4d", $horseregtype, $hnum, $horsename, $horsefoalyear);
            $line .= sprintf("%1.1s%7s%-25.25s%-25.25s%-15.15s%-2.2s%-11.11s", $pend, $rnum, $ridername, $rideraddress, $ridercity, $riderstate, $riderzip);
            $line .= sprintf("%-25.25s%-25.25s%-15.15s%-2.2s%-11.11s%-15.15s", $ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $relation);

            print RESULTS uc($line) ."\n" if ($p[$index] != 0);
         }
print LOG "\n";
      }


#
#  DETAIL LISTING (YOUTH)
#
      foreach $key (sort keys %yc) {
         $class = $yc{$key}[0];
         @cl_entry = grep (/^[0-9]+~~[A-Z]?[0-9]+~~[A-Z]?[0-9]+~~[a-zA-Z-]*~~$class~~/, @entry_list);
         $tiecount[0] = grep (/^[0-9]+~~[A-Z]?[0-9]+~~[A-Z]?[0-9]+~~[a-zA-Z-]*~~[0-9]+~~[0-9]+~~T~~/, @cl_entry);
         $tiecount[1] = grep (/^[0-9]+~~[A-Z]?[0-9]+~~[A-Z]?[0-9]+~~[a-zA-Z-]*~~[0-9]+~~[0-9]+~~T~~[0-9]+~~T~~/, @cl_entry);
         $tiecount[2] = grep (/^[0-9]+~~[A-Z]?[0-9]+~~[A-Z]?[0-9]+~~[a-zA-Z-]*~~[0-9]+~~[0-9]+~~T~~[0-9]+~~T~~[0-9]+~~T~~/, @cl_entry);
         $tiecount[3] = grep (/^[0-9]+~~[A-Z]?[0-9]+~~[A-Z]?[0-9]+~~[a-zA-Z-]*~~[0-9]+~~[0-9]+~~T~~[0-9]+~~T~~[0-9]+~~T~~[0-9]+~~T~~/, @cl_entry);
         $num_entries = $#cl_entry + 1;
         next if ($num_entries < 0);

print LOG "Class: $key  $yc{$key}[0]  $yc{$key}[1]\n";
         $linestart = sprintf("D%-9.9s%4s%03d", $shownum[$index], $key, $num_entries);

#
#  Display each entry in the class, placed up to 8
#
         foreach $cle (@cl_entry) {
print LOG "Class Line: $cle\n";
            $line = $linestart;
            $tiecount = 0;
            $relation = " ";
            $champ = " ";
            ($b, $h, $r, $rl, $c, $p[0], $t[0], $po[0], $p[1], $t[1], $po[1], $p[2], $t[2], $po[2], $p[3], $t[3], $po[3]) = split(/~~/, $cle);
print LOG "Horse: $h\tRider: $r\n";
            ($horseregtype, $horsename, undef, $horsefoalyear, $horsecolor, $horsesire, $horsedam, $horseowner) = split(/~~/, $horse_list{$h});
            ($ridername, $rideraddress, $ridercity, $riderstate, $riderzip, $riderhomephone, $riderworkphone, $rideremail, $ridersex, $rideryear, $ridertype, $ridernumberstatus) = split(/~~/, $member_list{$r});
            ($ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $ownerhomephone, $ownerworkphone, $owneremail, $ownersex, $owneryear, $ownertype, $ownernumberstatus) = split(/~~/, $member_list{$horseowner});

            $relation  = $rl;
            $pend      = " " if ($ridernumberstatus eq "CURRENT");
            if ($r =~ /^U/) {
               $pend      = "U" ;
               $rnum = sprintf("%07d", (substr($r, 1)));
            } else {
               if ($r =~ /^P/) {
                  $pend      = "P";
                  $rnum = sprintf("%07d", (substr($r, 1)));
               } else {
                  $rnum = sprintf("%07d", $r);
               }
            }
            $hnum = sprintf("%07d", $h);

            $tiecount  = $tiecount[$index] if ($t[$index] eq "T");

printf LOG "Entry: %-5dHNum: %-10dHorse: %-20.20sRNum: %-10dRider: %-20.20s\n", $b, $hnum, $horsename, $rnum, $ridername;

            $line .= sprintf("%02d%1d%1s%04d", $p[$index], $tiecount, $champ, $b);
            $line .= sprintf("%2.2s%7s%-17.17s%4d", $horseregtype, $hnum, $horsename, $horsefoalyear);
            $line .= sprintf("%1.1s%7s%-25.25s%-25.25s%-15.15s%-2.2s%-11.11s", $pend, $rnum, $ridername, $rideraddress, $ridercity, $riderstate, $riderzip);
            $line .= sprintf("%-25.25s%-25.25s%-15.15s%-2.2s%-11.11s%-15.15s", $ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $relation);

            print RESULTS uc($line) ."\n" if ($p[$index] != 0);
         }
print LOG "\n";
      }
print LOG "Closing Show Results File\n-----------------------------------------------------------\n";
      close (RESULTS);
   }
close LOG;

   $msgdialog->withdraw();
   $national_finished_window->deiconify();
   $national_finished_window->raise();
}


##################################################################################
##################################################################################
#
#       BUCKSKIN
#
#       National Show Report
#

sub buckskin_national_results {
   &open_showinfo_file($showdir);
   &open_entry_file($showdir);
   &open_judge_file;
   &open_member_file;
   &open_horse_file;
   &open_division_file;
   &open_national_class_file;


   $reporttype = "IBHA NATIONAL SHOW RESULTS REPORT";

   ($showname,$showdate,$shownum[0],$shownum[1],$shownum[2],$shownum[3],$judge[0],$judge[1],$judge[2],$judge[3],$maxplace,$breed,$showlocation) = split(/~~/, $openshowdata);

#
#  Ok, do this for each defined show
#
   foreach $index (0 .. $#shownum) {
      next if (!$shownum[$index]);

#
#  HEADER INFORMATION
#
      $judgeinfo    = "$judge[$index] : $judge_list{$judge[$index]}";

#      $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

      open (HTML_REPORT, ">c:/temp/reportfile.${index}$$.html") or die "Unable to open temp file: $!";

      &report_header_html;
      &buckskin_results_header;

#
#  GRAND/RESERVE CLASSES
#

      foreach $local (@show_classes) {
         ($cnum, $classname) = split(/\) /, $local, 2);
print "Class Info: $cnum   $classname\n";
         if ($cnum =~ /^Grand/) {
            if (($cnum =~ /^Grand/) && ($cnum =~ /Stallion/)) {
               $cnum      = "GS";
               $classname = "Grand & Reserve Champion Stallions";
               $national_num  = "GS";
               $national_name = "Grand & Reserve Champion Stallions";
            }
            if (($cnum =~ /^Grand/) && ($cnum =~ /Mares/)) {
               $cnum      = "GM";
               $classname = "Grand & Reserve Champion Mares";
               $national_num  = "GM";
               $national_name = "Grand & Reserve Champion Mares";
            }
            if (($cnum =~ /^Grand/) && ($cnum =~ /Gelding/)) {
               $cnum      = "GG";
               $classname = "Grand & Reserve Champion Geldings";
               $national_num  = "GG";
               $national_name = "Grand & Reserve Champion Geldings";
            }

            local @cl_entry = grep (/^[0-9]+~~[A-Z]{0,1}[-0-9]+~~P{0,1}[0-9]+~~[A-Z-]*~~${cnum}~~/, @entry_list);
            next if ($#cl_entry < 0);
            $entries = $#cl_entry + 1;

            &buckskin_results_class_header;

            @c_data = ();
            foreach (@cl_entry) {
               ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);
               push(@c_data, "${p1}~${h}~${r}") if ($index == 0);
               push(@c_data, "${p2}~${h}~${r}") if ($index == 1);
               push(@c_data, "${p3}~${h}~${r}") if ($index == 2);
               push(@c_data, "${p4}~${h}~${r}") if ($index == 3);
            }

            foreach $c_data (sort @c_data) {
               ($place, $horsenum, $ridernum) = split(/~/, $c_data, 3);
               next if ($place == 0);
               ($j, $horsename, $j, $j, $j, $j, $j, $ownernum) = split(/~~/, $horse_list{$horsenum});
               ($ownername, $rest)       = split(/~~/, $member_list{$ownernum}, 2);
               ($j, $ocity, $ostate, $j) = split(/~~/, $rest);
               $oaddr                    = "$ocity, $ostate";
               ($ridername, $rest)       = split(/~~/, $member_list{$ridernum}, 2);
               ($j, $rcity, $rstate, $j) = split(/~~/, $rest);
               $raddr                    = "$rcity, $rstate";

               $ownerinfo = "$ownername<BR>$oaddr";
               $riderinfo = "$ridername<BR>$raddr";
               &buckskin_results_html;
            }

            foreach $c_data (sort @c_data) {
               ($place, $horsenum, $ridernum) = split(/~/, $c_data, 4);
               next if ($place != 0);
               ($j, $horsename, $j, $j, $j, $j, $j, $ownernum) = split(/~~/, $horse_list{$horsenum});
               ($ownername, $rest)       = split(/~~/, $member_list{$ownernum}, 2);
               ($j, $ocity, $ostate, $j) = split(/~~/, $rest);
               $oaddr                    = "$ocity, $ostate";
               ($ridername, $rest)       = split(/~~/, $member_list{$ridernum}, 2);
               ($j, $rcity, $rstate, $j) = split(/~~/, $rest);
               $raddr                    = "$rcity, $rstate";

               $ownerinfo = "$ownername<BR>$oaddr";
               $riderinfo = "$ridername<BR>$raddr";
               &buckskin_results_html;
            }
         }
         print HTML_REPORT "</TABLE>";
      }


#
#  ALL OTHER CLASSES
#
      foreach $classdata (@class_list) {

         local ($national_num, $national_name) = split(/~/, $classdata);
print "Looking: $national_num - $national_name\n";

#
#  See if the national class appears in the class list for this show
#
         foreach $local (@show_classes) {
            ($cnum, $classname) = split(/\) /, $local, 2);
#print "Class Info: $cnum  $classname\n";
            if ($national_name eq $classname) {
               local @cl_entry = grep (/^[0-9]+~~[A-Z]{0,1}[-0-9]+~~P{0,1}[0-9]+~~[A-Z-]*~~${cnum}~~/, @entry_list);
               next if ($#cl_entry < 0);
               $entries = $#cl_entry + 1;

               &buckskin_results_class_header;

               @c_data = ();
               foreach (@cl_entry) {
                  ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);
                  push(@c_data, "${p1}~${h}~${r}") if ($index == 0);
                  push(@c_data, "${p2}~${h}~${r}") if ($index == 1);
                  push(@c_data, "${p3}~${h}~${r}") if ($index == 2);
                  push(@c_data, "${p4}~${h}~${r}") if ($index == 3);
               }

               foreach $c_data (sort @c_data) {
                 ($place, $horsenum, $ridernum) = split(/~/, $c_data, 3);
                  next if ($place == 0);
                  ($j, $horsename, $j, $j, $j, $j, $j, $ownernum) = split(/~~/, $horse_list{$horsenum});
                  ($ownername, $rest)       = split(/~~/, $member_list{$ownernum}, 2);
                  ($j, $ocity, $ostate, $j) = split(/~~/, $rest);
                  $oaddr                    = "$ocity, $ostate";
                  ($ridername, $rest)       = split(/~~/, $member_list{$ridernum}, 2);
                  ($j, $rcity, $rstate, $j) = split(/~~/, $rest);
                  $raddr                    = "$rcity, $rstate";

                  $ownerinfo = "$ownername<BR>$oaddr";
                  $riderinfo = "$ridername<BR>$raddr";
                  &buckskin_results_html;
               }

               foreach $c_data (sort @c_data) {
                  ($place, $horsenum, $ridernum) = split(/~/, $c_data, 4);
                  next if ($place != 0);
                  ($j, $horsename, $j, $j, $j, $j, $j, $ownernum) = split(/~~/, $horse_list{$horsenum});
                  ($ownername, $rest)       = split(/~~/, $member_list{$ownernum}, 2);
                  ($j, $ocity, $ostate, $j) = split(/~~/, $rest);
                  $oaddr                    = "$ocity, $ostate";
                  ($ridername, $rest)       = split(/~~/, $member_list{$ridernum}, 2);
                  ($j, $rcity, $rstate, $j) = split(/~~/, $rest);
                  $raddr                    = "$rcity, $rstate";

                  $ownerinfo = "$ownername<BR>$oaddr";
                  $riderinfo = "$ridername<BR>$raddr";
                  &buckskin_results_html;
               }
            }
         }
         print HTML_REPORT "</TABLE>";
      }
      &report_footer_html();

      close (HTML_REPORT);

#      $IE->{visible} = 1;
#      $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
      display_webpage("file://c:/temp/reportfile$$.html");
   }
}


##################################################################################
##################################################################################
#
#       NATIONAL SNAFFLE BIT ASSOCIATION
#
#       National Show Report
#

sub nsba_national_results {
   &open_showinfo_file($showdir);
   &open_entry_file($showdir);
   &open_judge_file;
   &open_member_file;
   &open_horse_file;
   &open_division_file;
   &open_national_class_file;


   $reporttype = "NSBA NATIONAL SHOW RESULTS REPORT";

   ($showname,$showdate,$shownum[0],$shownum[1],$shownum[2],$shownum[3],$judge[0],$judge[1],$judge[2],$judge[3],$maxplace,$breed,$showlocation) = split(/~~/, $openshowdata);

#
#  Ok, do this for each defined show
#
   foreach $index (0 .. $#shownum) {
      next if (!$shownum[$index]);

#
#  HEADER INFORMATION
#
      $judgename = "$judge_list{$judge[$index]}";

#      $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

      open (HTML_REPORT, ">c:/temp/reportfile.${index}$$.html") or die "Unable to open temp file: $!";
print "Writing to: ${cwd}/temp/reportfile.${index}$$.html\n";

      &report_header_html;
      &nsba_results_header;

#
#  RESULTS DATA
#

      foreach $classdata (@class_list) {

         local ($national_num, $national_name) = split(/~/, $classdata);
print "Looking: $national_num - $national_name\n";

#
#  See if the national class appears in the class list for this show
#
         foreach $local (@show_classes) {
            ($cnum, $classname) = split(/\) /, $local, 2);
            if ($national_name eq $classname) {
               local @cl_entry = grep (/^[0-9]+~~[A-Z]{0,1}[-0-9]+~~[A-Z]{0,1}[0-9]+~~[A-Z-]*~~${cnum}~~/, @entry_list);
               next if ($#cl_entry < 0);
               $entries = $#cl_entry + 1;

foreach $line (@cl_entry) {
   print "$line\n";
}
print "\n";

               &nsba_results_class_header;

               @c_data = ();
               foreach (@cl_entry) {
                  ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);
                  push(@c_data, "${p1}~${h}~${r}") if ($index == 0);
                  push(@c_data, "${p2}~${h}~${r}") if ($index == 1);
                  push(@c_data, "${p3}~${h}~${r}") if ($index == 2);
                  push(@c_data, "${p4}~${h}~${r}") if ($index == 3);
               }

               foreach $c_data (sort @c_data) {
                 ($place, $horsenum, $ridernum) = split(/~/, $c_data, 3);
                  next if ($place == 0);
                  ($j, $horsename, $j, $j, $j, $j, $j, $ownernum) = split(/~~/, $horse_list{$horsenum});
                  ($ownername, $rest)       = split(/~~/, $member_list{$ownernum}, 2);
                  ($j, $ocity, $ostate, $j) = split(/~~/, $rest);
                  $oaddr                    = "$ocity, $ostate";
                  ($ridername, $rest)       = split(/~~/, $member_list{$ridernum}, 2);
                  ($j, $rcity, $rstate, $j) = split(/~~/, $rest);
                  $raddr                    = "$rcity, $rstate";

                  $horseinfo = "$horsenum<BR>$horsename";
                  $ownerinfo = "$ownernum<BR>$ownername<BR>$oaddr";
                  $riderinfo = "$ridernum<BR>$ridername<BR>$raddr";
                  &nsba_results_html;
               }

               foreach $c_data (sort @c_data) {
                  ($place, $horsenum, $ridernum) = split(/~/, $c_data, 4);
                  next if ($place != 0);
                  ($j, $horsename, $j, $j, $j, $j, $j, $ownernum) = split(/~~/, $horse_list{$horsenum});
                  ($ownername, $rest)       = split(/~~/, $member_list{$ownernum}, 2);
                  ($j, $ocity, $ostate, $j) = split(/~~/, $rest);
                  $oaddr                    = "$ocity, $ostate";
                  ($ridername, $rest)       = split(/~~/, $member_list{$ridernum}, 2);
                  ($j, $rcity, $rstate, $j) = split(/~~/, $rest);
                  $raddr                    = "$rcity, $rstate";

                  $horseinfo = "$horsenum<BR>$horsename";
                  $ownerinfo = "$ownernum<BR>$ownername<BR>$oaddr";
                  $riderinfo = "$ridernum<BR>$ridername<BR>$raddr";
                  &nsba_results_html;
               }
            }
         }
         print HTML_REPORT "</TABLE>";
      }
      &report_footer_html();

      close (HTML_REPORT);

#      $IE->{visible} = 1;
#      $IE->Navigate("file:///${cwd}/temp/reportfile.${index}$$.html");
      display_webpage("file://c:/temp/reportfile.${index}$$.html");
   }
}


##################################################################################
##################################################################################
#
#       Write The National Reports To Disk
#

sub write_to_disk {
   foreach $shownumber (@shownum) {
      next if (!$shownumber);
      chomp($shownumber);
      open (RF, "temp/$shownumber.txt") or do {
         &display_message("Unable to open show results file", 5, "e");
         $national_finished_window->withdraw();
         return;
      };
      open (DF, ">A:$shownumber") or do {
         &display_message("Unable to open new file on diskette", 5, "e");
         $national_finished_window->withdraw();
         return;
      };
      foreach $line (<RF>) {
         print DF $line;
      }
      close DF;
      close RF;
   }
   $national_finished_window->withdraw();
}


##################################################################################
##################################################################################
#
#       Local Point Result By Horse
#

sub local2_point_report {
   appaloosa2_local_point_report() if ($showbreed eq "appaloosa");
   buckskin_local_point_report()  if ($showbreed eq "buckskin");
}


sub appaloosa2_local_point_report {
   &open_showinfo_file($showdir);
   &open_entry_file($showdir);
   &open_member_file($showdir);
   &open_horse_file($showdir);
   &open_division_file;
   &open_national_class_file;

   $reporttype = "REPORT BY CLASS FOR HORSES";

   @div_list = grep(!/^D/i, @division_list);
   foreach $ii (@show_classes) {
      ($lcnum, $cname) = split(/\) /, $ii);
      next if ($ii =~ /Grand/);
      @res = grep(/$cname/i, @div_list);
      ($ncnum) = split(/~/, @res[0]);

      if ($ncnum =~ /^A/) {
         $ac{$ncnum}[0] = $lcnum;
         $ac{$ncnum}[1] = $cname;
      }
      if ($ncnum =~ /^N/) {
         $nc{$ncnum}[0] = $lcnum;
         $nc{$ncnum}[1] = $cname;
      }
      if ($ncnum =~ /^O/) {
         $oc{$ncnum}[0] = $lcnum;
         $oc{$ncnum}[1] = $cname;
      }
      if ($ncnum =~ /^Y/) {
         $yc{$ncnum}[0] = $lcnum;
         $yc{$ncnum}[1] = $cname;
      }
   }

   ($showname,$showdate) = split(/~~/, $openshowdata);

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;

   open (LOCALHP, "$showdir/local_points.txt") or die "Unable to open local point file: $!";
   while (<LOCALHP>) {
      ($nic, @pts) = split(/~~/);
      $local_points{$nic} = join(":", @pts);
   }
   close LOCALHP;

#
#  FOR EACH POINT TYPE, COMPUTE THE TOTAL LOCAL POINTS
#  FOR EACH HORSE IN THE CLASS
#

#
#  OPEN CLASSES
#
   local $reporttype2 = "FOR OPEN CLASSES";
   &localpoints_header_html;

   open (GR, "${showdir}/gr_stallion.txt") or do {
      print "Unable to open file ${showdir}/gr_stallion.txt: $!\n";
      return;
   };
   chomp(@gr_stallion_classes = <GR>);
   close(GR);

   open (GR, "${showdir}/gr_gelding.txt") or do {
      print "Unable to open file ${showdir}/gr_gelding.txt: $!\n";
      return;
   };
   chomp(@gr_gelding_classes = <GR>);
   close(GR);

   open (GR, "${showdir}/gr_mare.txt") or do {
      print "Unable to open file ${showdir}/gr_mare.txt: $!\n";
      return;
   };
   chomp(@gr_mare_classes = <GR>);
   close(GR);


   foreach $national_num (sort { $a cmp $b } keys %oc) {
      local $class = $oc{$national_num}[0];
      local $class_name = $oc{$national_num}[1];
      local $national_num = substr($national_num, 1);
      local @cl_entry = grep (/^[0-9]+~~[A-Z0-9-]*~~[A-Z0-9-]*~~[A-Z0-9-]*~~$class~~/, @entry_list);
      local @gr_entry = grep (/^[0-9]+~~[A-Z0-9-]*~~[A-Z0-9-]*~~[A-Z0-9-]*~~G[SGM]~~/, @entry_list);
      next if ($#cl_entry < 0);

      local $total = (scalar(@cl_entry) > scalar(keys %local_points)) ? keys %local_points : @cl_entry;
      local (@local) = split(/:/, $local_points{$total});

      %points = ();
      foreach (@cl_entry) {
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);

print "Class: $c Horse: $h   Rider: $r   Place: $p1 $p2 $p3 $p4  ";
         $points{$h} += $local[$p1-1] if ($p1);
         $points{$h} += $local[$p2-1] if ($p2);
         $points{$h} += $local[$p3-1] if ($p3);
         $points{$h} += $local[$p4-1] if ($p4);
         $rider{$h} = $r;
print "Points: $points{$h}\n";

#
#  Now check for Grand/Reserve
#
         $gr_class = "NA";
         $gr_class = "GS" if (scalar(grep(/^${c}$/, @gr_stallion_classes)) > 0);
         $gr_class = "GG" if (scalar(grep(/^${c}$/, @gr_gelding_classes)) > 0);
         $gr_class = "GM" if (scalar(grep(/^${c}$/, @gr_mare_classes)) > 0);

         if ($gr_class ne "NA") {
print "This is a Grand/Reserve (${gr_class}) Class\n";
            local @grclass = grep (/^${b}~~[A-Z0-9-]*~~[A-Z0-9-]*~~[A-Z0-9-]*~~${gr_class}~~/, @gr_entry);
            local ($b, $h, $r, $max, $c, $gp1, $t1, $gpo1, $gp2, $t2, $gpo2, $gp3, $t3, $gpo3, $gp4, $t4, $gpo4) = split(/~~/, $grclass[0]);
print "Max Entries: $max\n";
print "GR Places  : $gp1 / $gp2 / $gp3 / $gp4\n";
            local $max = ($max > scalar(keys %local_points)) ? keys %local_points : $max;

print "New Max: $max\n";
print "Points Added: ";
            local (@grlocal) = split(/:/, $local_points{$max});
            $points{$h} += $grlocal[0] + 2 - $local[$p1-1] if ($gp1 == 1);
print "$grlocal[0]+2-$local[$p1-1] //1//1// " if ($gp1 == 1);
            $points{$h} += $grlocal[0] + 1 - $local[$p1-1] if ($gp1 == 2);
print "$grlocal[0]+1-$local[$p1-1] //1//2// " if ($gp1 == 2);
            $points{$h} += $grlocal[0] + 2 - $local[$p2-1] if ($gp2 == 1);
print "$grlocal[0]+2-$local[$p2-1] //2//1// " if ($gp2 == 1);
            $points{$h} += $grlocal[0] + 1 - $local[$p2-1] if ($gp2 == 2);
print "$grlocal[0]+1-$local[$p2-1] //2//2// " if ($gp2 == 2);
            $points{$h} += $grlocal[0] + 2 - $local[$p3-1] if ($gp3 == 1);
print "$grlocal[0]+2-$local[$p3-1] //3//1// " if ($gp3 == 1);
            $points{$h} += $grlocal[0] + 1 - $local[$p3-1] if ($gp3 == 2);
print "$grlocal[0]+1-$local[$p3-1] //3//2// " if ($gp3 == 2);
            $points{$h} += $grlocal[0] + 2 - $local[$p4-1] if ($gp4 == 1);
print "$grlocal[0]+2-$local[$p4-1] //4//1// " if ($gp4 == 1);
            $points{$h} += $grlocal[0] + 1 - $local[$p4-1] if ($gp4 == 2);
print "$grlocal[0]+1-$local[$p4-1] //4//2// " if ($gp4 == 2);
print "\n";

($j, $horsename, $j, $j, $j, $j, $j, $j) = split(/~~/, $horse_list{$h});
print "Points: $horsename - $points{$h}\n\n";
         }

      }

      $point_data = $horseinfo = $riderinfo = $points = "";
      foreach $horsenum (sort { $points{$b} <=> $points{$a} || $a <=> $b } keys %points) {
         ($j, $horsename, $j, $j, $j, $j, $j, $ownernum) = split(/~~/, $horse_list{$horsenum});
         ($oname) = split(/~~/, $member_list{$ownernum});
         ($rname) = split(/~~/, $member_list{$rider{$horsenum}});
         $point_data .= sprintf("%-20.20s %-20.20s %4d\n", $horsename, $oname, $points{$horsenum});
         $point_data .= sprintf("%-20.20s %-20.20s     \n", $horsenum, $ownernum);

         $horseinfo = "$horsenum - $horsename<BR>";
         $ownerinfo = "$ownernum - $oname";
         $riderinfo = "$rider{$horsenum} - $rname";
         $points    = "$points{$horsenum}";
         &localpoints_list_html();

#         $national_num = "&nbsp";
#         $class_name = "&nbsp";
      }
      print HTML_REPORT <<EOF;
<TR>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
</TR>
EOF
   }
   print HTML_REPORT "</TABLE>";

#
#  CHAPS CLASSES
#
   local $reporttype2 = "FOR CHAPS CLASSES";
   &localpoints_header_html;

   foreach $national_num (sort { $a cmp $b } keys %ac) {
      local $class = $ac{$national_num}[0];
      local $class_name = $ac{$national_num}[1];
      local $national_num = substr($national_num, 1);
      local @cl_entry = grep (/^[0-9]+~~P{0,1}[0-9]+~~P{0,1}[0-9]+~~[A-Z-]*~~$class~~/, @entry_list);
      next if ($#cl_entry < 0);

      local $total = (scalar(@cl_entry) > scalar(keys %local_points)) ? keys %local_points : @cl_entry;
      local (@local) = split(/:/, $local_points{$total});

      %points = ();
      %rider = ();
      foreach (@cl_entry) {
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);
         $points{$h} += $local[$p1-1] if ($p1);
         $points{$h} += $local[$p2-1] if ($p2);
         $points{$h} += $local[$p3-1] if ($p3);
         $points{$h} += $local[$p4-1] if ($p4);
         $rider{$h} = $r;
      }

      $point_data = $horseinfo = $riderinfo = $points = "";
      foreach $horsenum (sort { $points{$b} <=> $points{$a} || $a <=> $b } keys %points) {
         ($j, $horsename, $j, $j, $j, $j, $j, $ownernum) = split(/~~/, $horse_list{$horsenum});
         ($oname) = split(/~~/, $member_list{$ownernum});
         ($rname) = split(/~~/, $member_list{$rider{$horsenum}});
         $point_data .= sprintf("%-20.20s %-20.20s %4d\n", $horsename, $rname, $points{$horsenum});
         $point_data .= sprintf("%-20.20s %-20.20s     \n", $horsenum, $rider{$horsenum});

         $horseinfo = "$horsenum - $horsename<BR>";
         $ownerinfo = "$ownernum - $oname";
         $riderinfo = "$rider{$horsenum} - $rname";
         $points    = "$points{$horsenum}";
         &localpoints_list_html();

#         $national_num = "&nbsp";
#         $class_name = "&nbsp";
      }
      print HTML_REPORT <<EOF;
<TR>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
</TR>
EOF
   }
   print HTML_REPORT "</TABLE>";
   
#
#  NON-PRO CLASSES
#
   local $reporttype2 = "FOR NON-PRO CLASSES";
   &localpoints_header_html;

   foreach $national_num (sort { $a cmp $b } keys %nc) {
      local $class = $nc{$national_num}[0];
      local $class_name = $nc{$national_num}[1];
      local $national_num = substr($national_num, 1);
      local @cl_entry = grep (/^[0-9]+~~P{0,1}[0-9]+~~P{0,1}[0-9]+~~[A-Z-]*~~$class~~/, @entry_list);
      next if ($#cl_entry < 0);

      local $total = (scalar(@cl_entry) > scalar(keys %local_points)) ? keys %local_points : @cl_entry;
      local (@local) = split(/:/, $local_points{$total});

      %points = ();
      %rider = ();
      foreach (@cl_entry) {
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);
         $points{$h} += $local[$p1-1] if ($p1);
         $points{$h} += $local[$p2-1] if ($p2);
         $points{$h} += $local[$p3-1] if ($p3);
         $points{$h} += $local[$p4-1] if ($p4);
         $rider{$h} = $r;
      }

      $point_data = $horseinfo = $riderinfo = $points = "";
      foreach $horsenum (sort { $points{$b} <=> $points{$a} || $a <=> $b } keys %points) {
         ($j, $horsename, $j, $j, $j, $j, $j, $ownernum) = split(/~~/, $horse_list{$horsenum});
         ($oname) = split(/~~/, $member_list{$ownernum});
         ($rname) = split(/~~/, $member_list{$rider{$horsenum}});
         $point_data .= sprintf("%-20.20s %-20.20s %4d\n", $horsename, $rname, $points{$horsenum});
         $point_data .= sprintf("%-20.20s %-20.20s     \n", $horsenum, $rider{$horsenum});

         $horseinfo = "$horsenum - $horsename<BR>";
         $ownerinfo = "$ownernum - $oname";
         $riderinfo = "$rider{$horsenum} - $rname";
         $points    = "$points{$horsenum}";
         &localpoints_list_html();

#         $national_num = "&nbsp";
#         $class_name = "&nbsp";
      }
      print HTML_REPORT <<EOF;
<TR>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
</TR>
EOF
   }
   print HTML_REPORT "</TABLE>";

#
#  YOUTH CLASSES
#
   local $reporttype2 = "FOR YOUTH CLASSES";
   &localpoints_header_html;

   foreach $national_num (sort { $a cmp $b } keys %yc) {
      local $class = $yc{$national_num}[0];
      local $class_name = $yc{$national_num}[1];
      local $national_num = substr($national_num, 1);
      local @cl_entry = grep (/^[0-9]+~~P{0,1}[0-9]+~~P{0,1}[0-9]+~~[A-Z-]*~~$class~~/, @entry_list);
      next if ($#cl_entry < 0);

      local $total = (scalar(@cl_entry) > scalar(keys %local_points)) ? keys %local_points : @cl_entry;
      local (@local) = split(/:/, $local_points{$total});

      %points = ();
      %rider = ();
      foreach (@cl_entry) {
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);
         $points{$h} += $local[$p1-1] if ($p1);
         $points{$h} += $local[$p2-1] if ($p2);
         $points{$h} += $local[$p3-1] if ($p3);
         $points{$h} += $local[$p4-1] if ($p4);
         $rider{$h} = $r;
      }

      $point_data = $horseinfo = $riderinfo = $points = "";
      foreach $horsenum (sort { $points{$b} <=> $points{$a} || $a <=> $b } keys %points) {
         ($j, $horsename, $j, $j, $j, $j, $j, $ownernum) = split(/~~/, $horse_list{$horsenum});
         ($oname) = split(/~~/, $member_list{$ownernum});
         ($rname) = split(/~~/, $member_list{$rider{$horsenum}});
         $point_data .= sprintf("%-20.20s %-20.20s %4d\n", $horsename, $rname, $points{$horsenum});
         $point_data .= sprintf("%-20.20s %-20.20s     \n", $horsenum, $rider{$horsenum});

         $horseinfo = "$horsenum - $horsename<BR>";
         $ownerinfo = "$ownernum - $oname";
         $riderinfo = "$rider{$horsenum} - $rname";
         $points    = "$points{$horsenum}";
         &localpoints_list_html();

#         $national_num = "&nbsp";
#         $class_name = "&nbsp";
      }
      print HTML_REPORT <<EOF;
<TR>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
</TR>
EOF
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


##################################################################################
##################################################################################
#
#       Local Point Result By Horse
#

sub local_point_report {
   appaloosa_local_point_report() if ($showbreed eq "appaloosa");
   buckskin_local_point_report()  if ($showbreed eq "buckskin");
}


sub appaloosa_local_point_report {
   &open_showinfo_file($showdir);
   &open_entry_file($showdir);
   &open_member_file($showdir);
   &open_horse_file($showdir);
   &open_division_file;
   &open_national_class_file;

   $reporttype = "REPORT BY CLASS FOR HORSES";

   @div_list = grep(!/^D/i, @division_list);
   foreach $ii (@show_classes) {
      ($lcnum, $cname) = split(/\) /, $ii);
      next if ($ii =~ /Grand/);
      @res = grep(/$cname/i, @div_list);
      ($ncnum) = split(/~/, @res[0]);

      if ($ncnum =~ /^A/) {
         $ac{$ncnum}[0] = $lcnum;
         $ac{$ncnum}[1] = $cname;
      }
      if ($ncnum =~ /^N/) {
         $nc{$ncnum}[0] = $lcnum;
         $nc{$ncnum}[1] = $cname;
      }
      if ($ncnum =~ /^O/) {
         $oc{$ncnum}[0] = $lcnum;
         $oc{$ncnum}[1] = $cname;
      }
      if ($ncnum =~ /^Y/) {
         $yc{$ncnum}[0] = $lcnum;
         $yc{$ncnum}[1] = $cname;
      }
   }

   ($showname,$showdate) = split(/~~/, $openshowdata);

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;

   open (LOCALHP, "$showdir/local_points.txt") or die "Unable to open local point file: $!";
   while (<LOCALHP>) {
      ($nic, @pts) = split(/~~/);
      $local_points{$nic} = join(":", @pts);
   }
   close LOCALHP;

#
#  FOR EACH POINT TYPE, COMPUTE THE TOTAL LOCAL POINTS
#  FOR EACH HORSE IN THE CLASS
#

#
#  OPEN CLASSES
#
   local $reporttype2 = "FOR OPEN CLASSES";
   &localpoints_header_html;

   open (GR, "${showdir}/gr_stallion.txt") or do {
      print "Unable to open file ${showdir}/gr_stallion.txt: $!\n";
      return;
   };
   chomp(@gr_stallion_classes = <GR>);
   close(GR);

   open (GR, "${showdir}/gr_gelding.txt") or do {
      print "Unable to open file ${showdir}/gr_gelding.txt: $!\n";
      return;
   };
   chomp(@gr_gelding_classes = <GR>);
   close(GR);

   open (GR, "${showdir}/gr_mare.txt") or do {
      print "Unable to open file ${showdir}/gr_mare.txt: $!\n";
      return;
   };
   chomp(@gr_mare_classes = <GR>);
   close(GR);


   foreach $national_num (sort { $a cmp $b } keys %oc) {
      local $class = $oc{$national_num}[0];
      local $class_name = $oc{$national_num}[1];
      local $national_num = substr($national_num, 1);
      local @cl_entry = grep (/^[0-9]+~~[A-Z0-9-]*~~[A-Z0-9-]*~~[A-Z0-9-]*~~$class~~/, @entry_list);
      local @gr_entry = grep (/^[0-9]+~~[A-Z0-9-]*~~[A-Z0-9-]*~~[A-Z0-9-]*~~G[SGM]~~/, @entry_list);
      next if ($#cl_entry < 0);

      local $total = (scalar(@cl_entry) > scalar(keys %local_points)) ? keys %local_points : @cl_entry;
      local (@local) = split(/:/, $local_points{$total});

      %points = ();
      %rider = ();
      foreach (@cl_entry) {
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);

print "Class: $c Horse: $h   Rider: $r   Place: $p1 $p2 $p3 $p4  ";
         $points{$h} += $local[$p1-1] if ($p1);
         $points{$h} += $local[$p2-1] if ($p2);
         $points{$h} += $local[$p3-1] if ($p3);
         $points{$h} += $local[$p4-1] if ($p4);
         $rider{$h} = $r;
print "Points: $points{$h}\n";

#
#  Now check for Grand/Reserve
#
         $gr_class = "NA";
         $gr_class = "GS" if (scalar(grep(/^${c}$/, @gr_stallion_classes)) > 0);
         $gr_class = "GG" if (scalar(grep(/^${c}$/, @gr_gelding_classes)) > 0);
         $gr_class = "GM" if (scalar(grep(/^${c}$/, @gr_mare_classes)) > 0);

         if ($gr_class ne "NA") {
print "This is a Grand/Reserve (${gr_class}) Class\n";
            local @grclass = grep (/^${b}~~[A-Z0-9-]*~~[A-Z0-9-]*~~[A-Z0-9-]*~~${gr_class}~~/, @gr_entry);
            local ($b, $h, $r, $max, $c, $gp1, $t1, $gpo1, $gp2, $t2, $gpo2, $gp3, $t3, $gpo3, $gp4, $t4, $gpo4) = split(/~~/, $grclass[0]);
print "Max Entries: $max\n";
print "GR Places  : $gp1 / $gp2 / $gp3 / $gp4\n";
            local $max = ($max > scalar(keys %local_points)) ? keys %local_points : $max;

print "New Max: $max\n";
print "Points Added: ";
            local (@grlocal) = split(/:/, $local_points{$max});
            $points{$h} += $grlocal[0] + 2 - $local[$p1-1] if ($gp1 == 1);
print "$grlocal[0]+2-$local[$p1-1] //1//1// " if ($gp1 == 1);
            $points{$h} += $grlocal[0] + 1 - $local[$p1-1] if ($gp1 == 2);
print "$grlocal[0]+1-$local[$p1-1] //1//2// " if ($gp1 == 2);
            $points{$h} += $grlocal[0] + 2 - $local[$p2-1] if ($gp2 == 1);
print "$grlocal[0]+2-$local[$p2-1] //2//1// " if ($gp2 == 1);
            $points{$h} += $grlocal[0] + 1 - $local[$p2-1] if ($gp2 == 2);
print "$grlocal[0]+1-$local[$p2-1] //2//2// " if ($gp2 == 2);
            $points{$h} += $grlocal[0] + 2 - $local[$p3-1] if ($gp3 == 1);
print "$grlocal[0]+2-$local[$p3-1] //3//1// " if ($gp3 == 1);
            $points{$h} += $grlocal[0] + 1 - $local[$p3-1] if ($gp3 == 2);
print "$grlocal[0]+1-$local[$p3-1] //3//2// " if ($gp3 == 2);
            $points{$h} += $grlocal[0] + 2 - $local[$p4-1] if ($gp4 == 1);
print "$grlocal[0]+2-$local[$p4-1] //4//1// " if ($gp4 == 1);
            $points{$h} += $grlocal[0] + 1 - $local[$p4-1] if ($gp4 == 2);
print "$grlocal[0]+1-$local[$p4-1] //4//2// " if ($gp4 == 2);
print "\n";

($j, $horsename, $j, $j, $j, $j, $j, $j) = split(/~~/, $horse_list{$h});
print "Points: $horsename - $points{$h}\n\n";
         }

      }

      $point_data = $horseinfo = $riderinfo = $points = "";
      foreach $horsenum (sort { $points{$b} <=> $points{$a} || $a <=> $b } keys %points) {
         ($j, $horsename, $j, $j, $j, $j, $j, $ownernum) = split(/~~/, $horse_list{$horsenum});
         ($oname) = split(/~~/, $member_list{$ownernum});
         ($rname) = split(/~~/, $member_list{$rider{$horsenum}});
         $point_data .= sprintf("%-20.20s %-20.20s %4d\n", $horsename, $oname, $points{$horsenum});
         $point_data .= sprintf("%-20.20s %-20.20s     \n", $horsenum, $ownernum);

         $horseinfo = "$horsenum - $horsename<BR>";
         $ownerinfo = "$ownernum - $oname";
         $riderinfo = "$rider{$horsenum} - $rname";
         $points    = "$points{$horsenum}";
         &localpoints_list_html();

         $national_num = "&nbsp";
         $class_name = "&nbsp";
      }
      print HTML_REPORT <<EOF;
<TR>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
</TR>
EOF
   }
   print HTML_REPORT "</TABLE>";

#
#  CHAPS CLASSES
#
   local $reporttype2 = "FOR CHAPS CLASSES";
   &localpoints_header_html;

   foreach $national_num (sort { $a cmp $b } keys %ac) {
      local $class = $ac{$national_num}[0];
      local $class_name = $ac{$national_num}[1];
      local $national_num = substr($national_num, 1);
      local @cl_entry = grep (/^[0-9]+~~P{0,1}[0-9]+~~P{0,1}[0-9]+~~[A-Z-]*~~$class~~/, @entry_list);
      next if ($#cl_entry < 0);

      local $total = (scalar(@cl_entry) > scalar(keys %local_points)) ? keys %local_points : @cl_entry;
      local (@local) = split(/:/, $local_points{$total});

      %points = ();
      %rider = ();
      foreach (@cl_entry) {
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);
         $points{$h} += $local[$p1-1] if ($p1);
         $points{$h} += $local[$p2-1] if ($p2);
         $points{$h} += $local[$p3-1] if ($p3);
         $points{$h} += $local[$p4-1] if ($p4);
         $rider{$h} = $r;
      }

      $point_data = $horseinfo = $riderinfo = $points = "";
      foreach $horsenum (sort { $points{$b} <=> $points{$a} || $a <=> $b } keys %points) {
         ($j, $horsename, $j, $j, $j, $j, $j, $ownernum) = split(/~~/, $horse_list{$horsenum});
         ($oname) = split(/~~/, $member_list{$ownernum});
         ($rname) = split(/~~/, $member_list{$rider{$horsenum}});
         $point_data .= sprintf("%-20.20s %-20.20s %4d\n", $horsename, $rname, $points{$horsenum});
         $point_data .= sprintf("%-20.20s %-20.20s     \n", $horsenum, $rider{$horsenum});

         $horseinfo = "$horsenum - $horsename<BR>";
         $ownerinfo = "$ownernum - $oname";
         $riderinfo = "$rider{$horsenum} - $rname";
         $points    = "$points{$horsenum}";
         &localpoints_list_html();

         $national_num = "&nbsp";
         $class_name = "&nbsp";
      }
      print HTML_REPORT <<EOF;
<TR>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
</TR>
EOF
   }
   print HTML_REPORT "</TABLE>";

#
#  NON-PRO CLASSES
#
   local $reporttype2 = "FOR NON-PRO CLASSES";
   &localpoints_header_html;

   foreach $national_num (sort { $a cmp $b } keys %nc) {
      local $class = $nc{$national_num}[0];
      local $class_name = $nc{$national_num}[1];
      local $national_num = substr($national_num, 1);
      local @cl_entry = grep (/^[0-9]+~~P{0,1}[0-9]+~~P{0,1}[0-9]+~~[A-Z-]*~~$class~~/, @entry_list);
      next if ($#cl_entry < 0);

      local $total = (scalar(@cl_entry) > scalar(keys %local_points)) ? keys %local_points : @cl_entry;
      local (@local) = split(/:/, $local_points{$total});

      %points = ();
      %rider = ();
      foreach (@cl_entry) {
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);
         $points{$h} += $local[$p1-1] if ($p1);
         $points{$h} += $local[$p2-1] if ($p2);
         $points{$h} += $local[$p3-1] if ($p3);
         $points{$h} += $local[$p4-1] if ($p4);
         $rider{$h} = $r;
      }

      $point_data = $horseinfo = $riderinfo = $points = "";
      foreach $horsenum (sort { $points{$b} <=> $points{$a} || $a <=> $b } keys %points) {
         ($j, $horsename, $j, $j, $j, $j, $j, $ownernum) = split(/~~/, $horse_list{$horsenum});
         ($oname) = split(/~~/, $member_list{$ownernum});
         ($rname) = split(/~~/, $member_list{$rider{$horsenum}});
         $point_data .= sprintf("%-20.20s %-20.20s %4d\n", $horsename, $rname, $points{$horsenum});
         $point_data .= sprintf("%-20.20s %-20.20s     \n", $horsenum, $rider{$horsenum});

         $horseinfo = "$horsenum - $horsename<BR>";
         $ownerinfo = "$ownernum - $oname";
         $riderinfo = "$rider{$horsenum} - $rname";
         $points    = "$points{$horsenum}";
         &localpoints_list_html();

         $national_num = "&nbsp";
         $class_name = "&nbsp";
      }
      print HTML_REPORT <<EOF;
<TR>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
</TR>
EOF
   }
   print HTML_REPORT "</TABLE>";

#
#  YOUTH CLASSES
#
   local $reporttype2 = "FOR YOUTH CLASSES";
   &localpoints_header_html;

   foreach $national_num (sort { $a cmp $b } keys %yc) {
      local $class = $yc{$national_num}[0];
      local $class_name = $yc{$national_num}[1];
      local $national_num = substr($national_num, 1);
      local @cl_entry = grep (/^[0-9]+~~P{0,1}[0-9]+~~P{0,1}[0-9]+~~[A-Z-]*~~$class~~/, @entry_list);
      next if ($#cl_entry < 0);

      local $total = (scalar(@cl_entry) > scalar(keys %local_points)) ? keys %local_points : @cl_entry;
      local (@local) = split(/:/, $local_points{$total});

      %points = ();
      %rider = ();
      foreach (@cl_entry) {
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);
         $points{$h} += $local[$p1-1] if ($p1);
         $points{$h} += $local[$p2-1] if ($p2);
         $points{$h} += $local[$p3-1] if ($p3);
         $points{$h} += $local[$p4-1] if ($p4);
         $rider{$h} = $r;
      }

      $point_data = $horseinfo = $riderinfo = $points = "";
      foreach $horsenum (sort { $points{$b} <=> $points{$a} || $a <=> $b } keys %points) {
         ($j, $horsename, $j, $j, $j, $j, $j, $ownernum) = split(/~~/, $horse_list{$horsenum});
         ($oname) = split(/~~/, $member_list{$ownernum});
         ($rname) = split(/~~/, $member_list{$rider{$horsenum}});
         $point_data .= sprintf("%-20.20s %-20.20s %4d\n", $horsename, $rname, $points{$horsenum});
         $point_data .= sprintf("%-20.20s %-20.20s     \n", $horsenum, $rider{$horsenum});

         $horseinfo = "$horsenum - $horsename<BR>";
         $ownerinfo = "$ownernum - $oname";
         $riderinfo = "$rider{$horsenum} - $rname";
         $points    = "$points{$horsenum}";
         &localpoints_list_html();

         $national_num = "&nbsp";
         $class_name = "&nbsp";
      }
      print HTML_REPORT <<EOF;
<TR>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
</TR>
EOF
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


sub buckskin_local_point_report {
   &open_showinfo_file($showdir);
   &open_entry_file($showdir);
   &open_member_file($showdir);
   &open_horse_file($showdir);
   &open_division_file;
   &open_national_class_file;

   $reporttype = "REPORT BY CLASS FOR HORSES";

   @div_list = grep(!/^D/i, @division_list);
   foreach $ii (@show_classes) {
      ($lcnum, $cname) = split(/\) /, $ii);
      next if ($ii =~ /Grand/);
      next if ($cname =~ /^Open/);
print "Class Num & Name: $lcnum - $cname\n";
      @res = grep(/$cname/i, @div_list);
      ($ncnum) = split(/~/, @res[0]);
print "Nat Class Num : $ncnum\t";
      if ($cname =~ /Amateur/i) {
print "Adding amateur class\n";
         $nc{$ncnum}[0] = $lcnum;
         $nc{$ncnum}[1] = $cname;
      } else {
         if ($cname =~ /Youth/i) {
print "Adding youth class\n";
            $yc{$ncnum}[0] = $lcnum;
            $yc{$ncnum}[1] = $cname;
         } else {
            if ($cname !~ /Open/i) {
print "Adding open class\n";
               $oc{$ncnum}[0] = $lcnum;
               $oc{$ncnum}[1] = $cname;
            }
         }
      }
   }

   ($showname,$showdate) = split(/~~/, $openshowdata);

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;

   open (LOCALHP, "$showdir/local_points.txt") or die "Unable to open local point file: $!";
   while (<LOCALHP>) {
      ($nic, @pts) = split(/~~/);
      $local_points{$nic} = join(":", @pts);
   }
   close LOCALHP;

#
#  FOR EACH POINT TYPE, COMPUTE THE TOTAL LOCAL POINTS
#  FOR EACH HORSE IN THE CLASS
#

#
#  GRAND & RESERVE CLASSES
#
   local $reporttype2 = "FOR GRAND & RESERVE CLASSES";
   &localpoints_header_html;

   foreach $national_num (GS, GM, GG) {
print "National Class (GR): $national_num\n";
      local $class = ${national_num};
      local $class_name = "Grand/Reserve Stallions" if (${national_num} eq "GS");
      local $class_name = "Grand/Reserve Mares"     if (${national_num} eq "GM");
      local $class_name = "Grand/Reserve Geldings"  if (${national_num} eq "GG");
      local @gr_entry = grep (/^[0-9]+~~[A-Z0-9-]*~~[A-Z0-9-]*~~[A-Z0-9-]*~~${national_num}~~/, @entry_list);
      next if ($#gr_entry < 0);

      %points = ();
      foreach (@gr_entry) {
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);

#print "Class: $c Horse: $h   Rider: $r   Place: $p1 $p2 $p3 $p4  ";
         $points{$h} += 2 if ($p1 == 1);
         $points{$h} += 1 if ($p1 == 2);
         $points{$h} += 2 if ($p2 == 1);
         $points{$h} += 1 if ($p2 == 2);
         $points{$h} += 2 if ($p3 == 1);
         $points{$h} += 1 if ($p3 == 2);
         $points{$h} += 2 if ($p4 == 1);
         $points{$h} += 1 if ($p4 == 2);
#print "Points: $points{$h}\n";
      }

      $point_data = $horseinfo = $riderinfo = $points = "";
      foreach $horsenum (sort { $points{$b} <=> $points{$a} || $a <=> $b } keys %points) {
         ($j, $horsename, $j, $j, $j, $j, $j, $ownernum) = split(/~~/, $horse_list{$horsenum});
         ($oname) = split(/~~/, $member_list{$ownernum});
         $point_data .= sprintf("%-20.20s %-20.20s %4d\n", $horsename, $oname, $points{$horsenum});
         $point_data .= sprintf("%-20.20s %-20.20s     \n", $horsenum, $ownernum);

         $horseinfo = "$horsenum - $horsename<BR>";
         $riderinfo = "$ownernum - $oname";
         $points    = "$points{$horsenum}";
         &localpoints_list_html();

#         $national_num = "&nbsp";
#         $class_name = "&nbsp";
      }
      print HTML_REPORT <<EOF;
<TR>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
</TR>
EOF
   }
   print HTML_REPORT "</TABLE>";

#
#  OPEN CLASSES
#
   local $reporttype2 = "FOR OPEN CLASSES";
   &localpoints_header_html;

   foreach $national_num (sort { $a cmp $b } keys %oc) {
print "National Class (OP): $national_num\n";
      local $class = $oc{$national_num}[0];
      local $class_name = $oc{$national_num}[1];
      local @cl_entry = grep (/^[0-9]+~~[A-Z0-9-]*~~[A-Z0-9-]*~~[A-Z0-9-]*~~$class~~/, @entry_list);
      local @gr_entry = grep (/^[0-9]+~~[A-Z0-9-]*~~[A-Z0-9-]*~~[A-Z0-9-]*~~G[SGM]~~/, @entry_list);
      next if ($#cl_entry < 0);

      local $total = (scalar(@cl_entry) > scalar(keys %local_points)) ? keys %local_points : @cl_entry;
      local (@local) = split(/:/, $local_points{$total});

      %points = ();
      foreach (@cl_entry) {
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);

#print "Class: $c Horse: $h   Rider: $r   Place: $p1 $p2 $p3 $p4  ";
         $points{$h} += $local[$p1-1] if ($p1);
         $points{$h} += $local[$p2-1] if ($p2);
         $points{$h} += $local[$p3-1] if ($p3);
         $points{$h} += $local[$p4-1] if ($p4);
#print "Points: $points{$h}\n";

#
#  Now check for Grand/Reserve
#
         $gr_class = "NA";
         $gr_class = "GS" if (scalar(grep(/^${c}$/, @gr_stallion_classes)) > 0);
         $gr_class = "GG" if (scalar(grep(/^${c}$/, @gr_gelding_classes)) > 0);
         $gr_class = "GM" if (scalar(grep(/^${c}$/, @gr_mare_classes)) > 0);

         if ($gr_class ne "NA") {
#print "This is a Grand/Reserve (${gr_class}) Class\n";
            local @grclass = grep (/^${b}~~[A-Z0-9-]*~~[A-Z0-9-]*~~[A-Z0-9-]*~~${gr_class}~~/, @gr_entry);
            local ($b, $h, $r, $max, $c, $gp1, $t1, $gpo1, $gp2, $t2, $gpo2, $gp3, $t3, $gpo3, $gp4, $t4, $gpo4) = split(/~~/, $grclass[0]);
#print "Max Entries: $max\n";
#print "GR Places  : $gp1 / $gp2 / $gp3 / $gp4\n";
            local $max = ($max > scalar(keys %local_points)) ? keys %local_points : $max;

#print "New Max: $max\n";
#print "Points Added: ";
            local (@grlocal) = split(/:/, $local_points{$max});
            $points{$h} += 2 if ($gp1 == 1);
#print "$grlocal[0]+2-$local[$p1-1] //1//1// " if ($gp1 == 1);
            $points{$h} += 1 if ($gp1 == 2);
#print "$grlocal[0]+1-$local[$p1-1] //1//2// " if ($gp1 == 2);
            $points{$h} += 2 if ($gp2 == 1);
#print "$grlocal[0]+2-$local[$p2-1] //2//1// " if ($gp2 == 1);
            $points{$h} += 1 if ($gp2 == 2);
#print "$grlocal[0]+1-$local[$p2-1] //2//2// " if ($gp2 == 2);
            $points{$h} += 2 if ($gp3 == 1);
#print "$grlocal[0]+2-$local[$p3-1] //3//1// " if ($gp3 == 1);
            $points{$h} += 1 if ($gp3 == 2);
#print "$grlocal[0]+1-$local[$p3-1] //3//2// " if ($gp3 == 2);
            $points{$h} += 2 if ($gp4 == 1);
#print "$grlocal[0]+2-$local[$p4-1] //4//1// " if ($gp4 == 1);
            $points{$h} += 1 if ($gp4 == 2);
#print "$grlocal[0]+1-$local[$p4-1] //4//2// " if ($gp4 == 2);
#print "\n";

($j, $horsename, $j, $j, $j, $j, $j, $j) = split(/~~/, $horse_list{$h});
#print "Points: $horsename - $points{$h}\n\n";
         }

      }

      $point_data = $horseinfo = $riderinfo = $points = "";
      foreach $horsenum (sort { $points{$b} <=> $points{$a} || $a <=> $b } keys %points) {
         ($j, $horsename, $j, $j, $j, $j, $j, $ownernum) = split(/~~/, $horse_list{$horsenum});
         ($oname) = split(/~~/, $member_list{$ownernum});
         $point_data .= sprintf("%-20.20s %-20.20s %4d\n", $horsename, $oname, $points{$horsenum});
         $point_data .= sprintf("%-20.20s %-20.20s     \n", $horsenum, $ownernum);

         $horseinfo = "$horsenum - $horsename<BR>";
         $riderinfo = "$ownernum - $oname";
         $points    = "$points{$horsenum}";
         &localpoints_list_html();

         $national_num = "&nbsp";
         $class_name = "&nbsp";
      }
      print HTML_REPORT <<EOF;
<TR>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
</TR>
EOF
   }
   print HTML_REPORT "</TABLE>";

#
#  AMATEUR CLASSES
#
   local $reporttype2 = "FOR AMATEUR CLASSES";
   &localpoints_header_html;

   foreach $national_num (sort { $a cmp $b } keys %nc) {
print "National Class (AM): $national_num\n";
      local $class = $nc{$national_num}[0];
      local $class_name = $nc{$national_num}[1];
      local @cl_entry = grep (/^[0-9]+~~[A-Z0-9-]*~~[A-Z0-9-]*~~[A-Z0-9-]*~~$class~~/, @entry_list);
      next if ($#cl_entry < 0);

      local $total = (scalar(@cl_entry) > scalar(keys %local_points)) ? keys %local_points : @cl_entry;
      local (@local) = split(/:/, $local_points{$total});

      %points = ();
      %rider = ();
      foreach (@cl_entry) {
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);
         $points{$h} += $local[$p1-1] if ($p1);
         $points{$h} += $local[$p2-1] if ($p2);
         $points{$h} += $local[$p3-1] if ($p3);
         $points{$h} += $local[$p4-1] if ($p4);
         $rider{$h} = $r;
      }

      $point_data = $horseinfo = $riderinfo = $points = "";
      foreach $horsenum (sort { $points{$b} <=> $points{$a} || $a <=> $b } keys %points) {
         ($j, $horsename, $j, $j, $j, $j, $j, $j) = split(/~~/, $horse_list{$horsenum});
         ($rname) = split(/~~/, $member_list{$rider{$horsenum}});
         $point_data .= sprintf("%-20.20s %-20.20s %4d\n", $horsename, $rname, $points{$horsenum});
         $point_data .= sprintf("%-20.20s %-20.20s     \n", $horsenum, $rider{$horsenum});

         $horseinfo = "$horsenum - $horsename<BR>";
         $riderinfo = "$rider{$horsenum} - $rname";
         $points    = "$points{$horsenum}";
         &localpoints_list_html();

         $national_num = "&nbsp";
         $class_name = "&nbsp";
      }
      print HTML_REPORT <<EOF;
<TR>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
</TR>
EOF
   }
   print HTML_REPORT "</TABLE>";

#
#  YOUTH CLASSES
#
   local $reporttype2 = "FOR YOUTH CLASSES";
   &localpoints_header_html;

   foreach $national_num (sort { $a cmp $b } keys %yc) {
print "National Class (YT): $national_num\n";
      local $class = $yc{$national_num}[0];
      local $class_name = $yc{$national_num}[1];
      local @cl_entry = grep (/^[0-9]+~~[A-Z0-9-]*~~[A-Z0-9-]*~~[A-Z-]*~~$class~~/, @entry_list);
      next if ($#cl_entry < 0);

      local $total = (scalar(@cl_entry) > scalar(keys %local_points)) ? keys %local_points : @cl_entry;
      local (@local) = split(/:/, $local_points{$total});

      %points = ();
      %rider = ();
      foreach (@cl_entry) {
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);
         $points{$h} += $local[$p1-1] if ($p1);
         $points{$h} += $local[$p2-1] if ($p2);
         $points{$h} += $local[$p3-1] if ($p3);
         $points{$h} += $local[$p4-1] if ($p4);
         $rider{$h} = $r;
      }

      $point_data = $horseinfo = $riderinfo = $points = "";
      foreach $horsenum (sort { $points{$b} <=> $points{$a} || $a <=> $b } keys %points) {
         ($j, $horsename, $j, $j, $j, $j, $j, $j) = split(/~~/, $horse_list{$horsenum});
         ($rname) = split(/~~/, $member_list{$rider{$horsenum}});
         $point_data .= sprintf("%-20.20s %-20.20s %4d\n", $horsename, $rname, $points{$horsenum});
         $point_data .= sprintf("%-20.20s %-20.20s     \n", $horsenum, $rider{$horsenum});

         $horseinfo = "$horsenum - $horsename<BR>";
         $riderinfo = "$rider{$horsenum} - $rname";
         $points    = "$points{$horsenum}";
         &localpoints_list_html();

         $national_num = "&nbsp";
         $class_name = "&nbsp";
      }
      print HTML_REPORT <<EOF;
<TR>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
</TR>
EOF
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}




##################################################################################
##################################################################################
#
#       National Point Result By Horse
#

sub national_point_report {
   appaloosa_national_point_report() if ($showbreed eq "appaloosa");
}


sub appaloosa_national_point_report {
   &open_showinfo_file($showdir);
   &open_entry_file($showdir);
   &open_member_file($showdir);
   &open_horse_file($showdir);
   &open_division_file;
   &open_national_class_file;

   $reporttype = "REPORT BY CLASS FOR HORSES";

   @div_list = grep(!/^D/i, @division_list);
   foreach $ii (@show_classes) {
      ($lcnum, $cname) = split(/\) /, $ii);
      next if ($ii =~ /Grand/);
      @res = grep(/$cname/i, @div_list);
      ($ncnum) = split(/~/, @res[0]);

      if ($ncnum =~ /^A/) {
         $ac{$ncnum}[0] = $lcnum;
         $ac{$ncnum}[1] = $cname;
      }
      if ($ncnum =~ /^N/) {
         $nc{$ncnum}[0] = $lcnum;
         $nc{$ncnum}[1] = $cname;
      }
      if ($ncnum =~ /^O/) {
         $oc{$ncnum}[0] = $lcnum;
         $oc{$ncnum}[1] = $cname;
      }
      if ($ncnum =~ /^Y/) {
         $yc{$ncnum}[0] = $lcnum;
         $yc{$ncnum}[1] = $cname;
      }
   }

   ($showname,$showdate) = split(/~~/, $openshowdata);

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;

#
#  FOR EACH POINT TYPE, COMPUTE THE TOTAL LOCAL POINTS
#  FOR EACH HORSE IN THE CLASS
#

#
#  OPEN CLASSES
#
   local $reporttype2 = "FOR OPEN CLASSES";
   &nationalpoints_header_html;

   open (GR, "${showdir}/gr_stallion.txt") or do {
      print "Unable to open file ${showdir}/gr_stallion.txt: $!\n";
      return;
   };
   chomp(@gr_stallion_classes = <GR>);
   close(GR);

   open (GR, "${showdir}/gr_gelding.txt") or do {
      print "Unable to open file ${showdir}/gr_gelding.txt: $!\n";
      return;
   };
   chomp(@gr_gelding_classes = <GR>);
   close(GR);

   open (GR, "${showdir}/gr_mare.txt") or do {
      print "Unable to open file ${showdir}/gr_mare.txt: $!\n";
      return;
   };
   chomp(@gr_mare_classes = <GR>);
   close(GR);


   foreach $national_num (sort { $a cmp $b } keys %oc) {
      local $class = $oc{$national_num}[0];
      local $class_name = $oc{$national_num}[1];
      local $national_num = substr($national_num, 1);
      local @cl_entry = grep (/^[0-9]+~~[A-Z0-9-]*~~[A-Z0-9-]*~~[A-Z0-9-]*~~$class~~/, @entry_list);
      local @gr_entry = grep (/^[0-9]+~~[A-Z0-9-]*~~[A-Z0-9-]*~~[A-Z0-9-]*~~G[SGM]~~/, @entry_list);
      next if ($#cl_entry < 0);

      local $total = (scalar(@cl_entry) > scalar(keys %local_points)) ? keys %local_points : @cl_entry;
      local (@local) = split(/:/, $local_points{$total});

      %points = ();
      foreach (@cl_entry) {
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);

print "Class: $c Horse: $h   Rider: $r   Place: $p1 $p2 $p3 $p4  ";
         $points{$h} += $po1 if ($p1);
         $points{$h} += $po2 if ($p2);
         $points{$h} += $po3 if ($p3);
         $points{$h} += $po4 if ($p4);
print "Points: $points{$h}\n";

#
#  Now check for Grand/Reserve
#
         $gr_class = "NA";
         $gr_class = "GS" if (scalar(grep(/^${c}$/, @gr_stallion_classes)) > 0);
         $gr_class = "GG" if (scalar(grep(/^${c}$/, @gr_gelding_classes)) > 0);
         $gr_class = "GM" if (scalar(grep(/^${c}$/, @gr_mare_classes)) > 0);

#         if ($gr_class ne "NA") {
#print "This is a Grand/Reserve (${gr_class}) Class\n";
#            local @grclass = grep (/^${b}~~[A-Z0-9-]*~~[A-Z0-9-]*~~[A-Z0-9-]*~~${gr_class}~~/, @gr_entry);
#            local ($b, $h, $r, $max, $c, $gp1, $t1, $gpo1, $gp2, $t2, $gpo2, $gp3, $t3, $gpo3, $gp4, $t4, $gpo4) = split(/~~/, $grclass[0]);
#print "Max Entries: $max\n";
#print "GR Places  : $gp1 / $gp2 / $gp3 / $gp4\n";
#            local $max = ($max > scalar(keys %local_points)) ? keys %local_points : $max;
#
#print "New Max: $max\n";
#print "Points Added: ";
#            local (@grlocal) = split(/:/, $local_points{$max});
#            $points{$h} += $grlocal[0] + 2 - $local[$p1-1] if ($gp1 == 1);
#print "$grlocal[0]+2-$local[$p1-1] //1//1// " if ($gp1 == 1);
#            $points{$h} += $grlocal[0] + 1 - $local[$p1-1] if ($gp1 == 2);
#print "$grlocal[0]+1-$local[$p1-1] //1//2// " if ($gp1 == 2);
#            $points{$h} += $grlocal[0] + 2 - $local[$p2-1] if ($gp2 == 1);
#print "$grlocal[0]+2-$local[$p2-1] //2//1// " if ($gp2 == 1);
#            $points{$h} += $grlocal[0] + 1 - $local[$p2-1] if ($gp2 == 2);
#print "$grlocal[0]+1-$local[$p2-1] //2//2// " if ($gp2 == 2);
#            $points{$h} += $grlocal[0] + 2 - $local[$p3-1] if ($gp3 == 1);
#print "$grlocal[0]+2-$local[$p3-1] //3//1// " if ($gp3 == 1);
#            $points{$h} += $grlocal[0] + 1 - $local[$p3-1] if ($gp3 == 2);
#print "$grlocal[0]+1-$local[$p3-1] //3//2// " if ($gp3 == 2);
#            $points{$h} += $grlocal[0] + 2 - $local[$p4-1] if ($gp4 == 1);
#print "$grlocal[0]+2-$local[$p4-1] //4//1// " if ($gp4 == 1);
#            $points{$h} += $grlocal[0] + 1 - $local[$p4-1] if ($gp4 == 2);
#print "$grlocal[0]+1-$local[$p4-1] //4//2// " if ($gp4 == 2);
#print "\n";
#
#($j, $horsename, $j, $j, $j, $j, $j, $j) = split(/~~/, $horse_list{$h});
#print "Points: $horsename - $points{$h}\n\n";
#         }

      }

      $point_data = $horseinfo = $riderinfo = $points = "";
      foreach $horsenum (sort { $points{$b} <=> $points{$a} || $a <=> $b } keys %points) {
         ($j, $horsename, $j, $j, $j, $j, $j, $ownernum) = split(/~~/, $horse_list{$horsenum});
         ($oname) = split(/~~/, $member_list{$ownernum});
         $point_data .= sprintf("%-20.20s %-20.20s %4d\n", $horsename, $oname, $points{$horsenum});
         $point_data .= sprintf("%-20.20s %-20.20s     \n", $horsenum, $ownernum);

         $horseinfo = "$horsenum - $horsename<BR>";
         $riderinfo = "$ownernum - $oname";
         $points    = "$points{$horsenum}";
         &nationalpoints_list_html();

         $national_num = "&nbsp";
         $class_name = "&nbsp";
      }
      print HTML_REPORT <<EOF;
<TR>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
</TR>
EOF
   }
   print HTML_REPORT "</TABLE>";

#
#  CHAPS CLASSES
#
   local $reporttype2 = "FOR CHAPS CLASSES";
   &nationalpoints_header_html;

   foreach $national_num (sort { $a cmp $b } keys %ac) {
      local $class = $ac{$national_num}[0];
      local $class_name = $ac{$national_num}[1];
      local $national_num = substr($national_num, 1);
      local @cl_entry = grep (/^[0-9]+~~P{0,1}[0-9]+~~P{0,1}[0-9]+~~[A-Z-]*~~$class~~/, @entry_list);
      next if ($#cl_entry < 0);

      local $total = (scalar(@cl_entry) > scalar(keys %local_points)) ? keys %local_points : @cl_entry;
      local (@local) = split(/:/, $local_points{$total});

      %points = ();
      %rider = ();
      foreach (@cl_entry) {
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);
         $points{$h} += $po1 if ($p1);
         $points{$h} += $po2 if ($p2);
         $points{$h} += $po3 if ($p3);
         $points{$h} += $po4 if ($p4);
         $rider{$h} = $r;
      }

      $point_data = $horseinfo = $riderinfo = $points = "";
      foreach $horsenum (sort { $points{$b} <=> $points{$a} || $a <=> $b } keys %points) {
         ($j, $horsename, $j, $j, $j, $j, $j, $j) = split(/~~/, $horse_list{$horsenum});
         ($rname) = split(/~~/, $member_list{$rider{$horsenum}});
         $point_data .= sprintf("%-20.20s %-20.20s %4d\n", $horsename, $rname, $points{$horsenum});
         $point_data .= sprintf("%-20.20s %-20.20s     \n", $horsenum, $rider{$horsenum});

         $horseinfo = "$horsenum - $horsename<BR>";
         $riderinfo = "$rider{$horsenum} - $rname";
         $points    = "$points{$horsenum}";
         &nationalpoints_list_html();

         $national_num = "&nbsp";
         $class_name = "&nbsp";
      }
      print HTML_REPORT <<EOF;
<TR>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
</TR>
EOF
   }
   print HTML_REPORT "</TABLE>";

#
#  NON-PRO CLASSES
#
   local $reporttype2 = "FOR NON-PRO CLASSES";
   &nationalpoints_header_html;

   foreach $national_num (sort { $a cmp $b } keys %nc) {
      local $class = $nc{$national_num}[0];
      local $class_name = $nc{$national_num}[1];
      local $national_num = substr($national_num, 1);
      local @cl_entry = grep (/^[0-9]+~~P{0,1}[0-9]+~~P{0,1}[0-9]+~~[A-Z-]*~~$class~~/, @entry_list);
      next if ($#cl_entry < 0);

      local $total = (scalar(@cl_entry) > scalar(keys %local_points)) ? keys %local_points : @cl_entry;
      local (@local) = split(/:/, $local_points{$total});

      %points = ();
      %rider = ();
      foreach (@cl_entry) {
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);
         $points{$h} += $po1 if ($p1);
         $points{$h} += $po2 if ($p2);
         $points{$h} += $po3 if ($p3);
         $points{$h} += $po4 if ($p4);
         $rider{$h} = $r;
      }

      $point_data = $horseinfo = $riderinfo = $points = "";
      foreach $horsenum (sort { $points{$b} <=> $points{$a} || $a <=> $b } keys %points) {
         ($j, $horsename, $j, $j, $j, $j, $j, $j) = split(/~~/, $horse_list{$horsenum});
         ($rname) = split(/~~/, $member_list{$rider{$horsenum}});
         $point_data .= sprintf("%-20.20s %-20.20s %4d\n", $horsename, $rname, $points{$horsenum});
         $point_data .= sprintf("%-20.20s %-20.20s     \n", $horsenum, $rider{$horsenum});

         $horseinfo = "$horsenum - $horsename<BR>";
         $riderinfo = "$rider{$horsenum} - $rname";
         $points    = "$points{$horsenum}";
         &nationalpoints_list_html();

         $national_num = "&nbsp";
         $class_name = "&nbsp";
      }
      print HTML_REPORT <<EOF;
<TR>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
</TR>
EOF
   }
   print HTML_REPORT "</TABLE>";

#
#  YOUTH CLASSES
#
   local $reporttype2 = "FOR YOUTH CLASSES";
   &nationalpoints_header_html;

   foreach $national_num (sort { $a cmp $b } keys %yc) {
      local $class = $yc{$national_num}[0];
      local $class_name = $yc{$national_num}[1];
      local $national_num = substr($national_num, 1);
      local @cl_entry = grep (/^[0-9]+~~P{0,1}[0-9]+~~P{0,1}[0-9]+~~[A-Z-]*~~$class~~/, @entry_list);
      next if ($#cl_entry < 0);

      local $total = (scalar(@cl_entry) > scalar(keys %local_points)) ? keys %local_points : @cl_entry;
      local (@local) = split(/:/, $local_points{$total});

      %points = ();
      %rider = ();
      foreach (@cl_entry) {
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);
         $points{$h} += $po1 if ($p1);
         $points{$h} += $po2 if ($p2);
         $points{$h} += $po3 if ($p3);
         $points{$h} += $po4 if ($p4);
         $rider{$h} = $r;
      }

      $point_data = $horseinfo = $riderinfo = $points = "";
      foreach $horsenum (sort { $points{$b} <=> $points{$a} || $a <=> $b } keys %points) {
         ($j, $horsename, $j, $j, $j, $j, $j, $j) = split(/~~/, $horse_list{$horsenum});
         ($rname) = split(/~~/, $member_list{$rider{$horsenum}});
         $point_data .= sprintf("%-20.20s %-20.20s %4d\n", $horsename, $rname, $points{$horsenum});
         $point_data .= sprintf("%-20.20s %-20.20s     \n", $horsenum, $rider{$horsenum});

         $horseinfo = "$horsenum - $horsename<BR>";
         $riderinfo = "$rider{$horsenum} - $rname";
         $points    = "$points{$horsenum}";
         &nationalpoints_list_html();

         $national_num = "&nbsp";
         $class_name = "&nbsp";
      }
      print HTML_REPORT <<EOF;
<TR>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
<TD>&nbsp;</TD>
</TR>
EOF
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


##################################################################################
##################################################################################
#
#       Class Winner based on Local Points
#

sub class_winner {
   &open_showinfo_file($showdir);
   &open_entry_file($showdir);
   &open_member_file($showdir);
   &open_horse_file($showdir);
   &open_division_file;
   &open_national_class_file;
   &open_local_point_file($showdir);

   $reporttype = "CLASS WINNER";

   open (LOCALHP, "$showdir/local_points.txt") or die "Unable to open local point file: $!";
   while (<LOCALHP>) {
      ($nic, @pts) = split(/~~/);
      $local_points{$nic} = join(":", @pts);
   }
   close LOCALHP;

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;

   if (!$classnumber) {
      @chosen = $class_lb->curselection();
      foreach $entry (@chosen) {
         $chosen = $class_lb->get($entry);
         ($classnumber, $classname) = split(/\) /, $chosen);
print "Class Num: $classnumber\nClass Nam: $classname\n";
         if ($classnumber =~ /Grand/) {
            if ($classnumber =~ /Mare/) {
          $classname = $classnumber;
          $classnumber = "GM";
            } elsif ($classnumber =~ /Geld/) {
          $classname = $classnumber;
          $classnumber = "GG";
            } elsif ($classnumber =~ /Stal/) {
          $classname = $classnumber;
          $classnumber = "GS";
            }
         }
         do_class_winner();
      }
   } else {
      $classname = $show_class_list{$classnumber};
      do_class_winner();
   }
}


sub do_class_winner {
   local @cl_entry = grep (/^[0-9]+~~P{0,1}[0-9]+~~P{0,1}[0-9]+~~[A-Z-]*~~$classnumber~~/, @entry_list);
   $total_class_entries = scalar(@cl_entry) - 1;
   next if ($#cl_entry < 0);

   local $total = (scalar(@cl_entry) > scalar(keys %local_points)) ? keys %local_points : @cl_entry;
   local (@local) = split(/:/, $local_points{$total});

   $total_class_entries = $#cl_entry + 1;
   &classwinner_header_html;

   %points = ();
   foreach (@cl_entry) {
      ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);
      $e = "$b:$h:$r";
print "Class: $c  Horse: $h   Rider: $r   Place: $p1 $p2 $p3 $p4  ";
      $points{$e} += $local[$p1-1] if ($p1);
      $points{$e} += $local[$p2-1] if ($p2);
      $points{$e} += $local[$p3-1] if ($p3);
      $points{$e} += $local[$p4-1] if ($p4);
print "Points: $points{$e}\n";
   }

   $point_data = "";
   foreach $key (sort { $points{$b} <=> $points{$a} || $a <=> $b } keys %points) {
      ($backnumber, $horsenum, $ridernum) = split(/:/, $key);
      ($j, $horsename, $j, $j, $j, $j, $j, $j) = split(/~~/, $horse_list{$horsenum});
      ($ridername) = split(/~~/, $member_list{$ridernum});
      $win_points = $points{$key};

      &classwinner_list_html;
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


##################################################################################
##################################################################################
#
#       BUCKSKIN
#
#       National Master Horse List (Can also be used for Appaloosa)
#

sub national_master {
   &open_showinfo_file($showdir);
   &open_entry_file($showdir);
   &open_judge_file;
   &open_member_file;
   &open_horse_file;
   &open_division_file;
   &open_local_class_file;
   &open_national_class_file;

   $reporttype = "SHOW RESULTS MASTER HORSE LIST";

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   ($showname,$showdate,$shownum[0],$shownum[1],$shownum[2],$shownum[3],$judge[0],$judge[1],$judge[2],$judge[3],$maxplace) = split(/~~/, $openshowdata);

   &report_header_html;

#
#  Get the judge names
#
   $judgeinfo = "";
   foreach $index (0 .. $#shownum) {
      next if (!$shownum[$index]);
      if (!$judgeinfo) {
    $judgeinfo .= "$judge_list{$judge[$index]}";
      } else {
    $judgeinfo .= " : $judge_list{$judge[$index]}";
      }
   }

#
#  Look at the class lists and pull out the unique horses
#
   $entry_count = 0;
   foreach $local (@show_classes) {
      ($cnum, $classname) = split(/\) /, $local, 2);
      next if ($cnum !~ /^Grand/);

print "Cnum: $cnum\n";
      $cnum = "GS" if (($cnum =~ /^Grand/) && ($cnum =~ /Stallion/));
      $cnum = "GM" if (($cnum =~ /^Grand/) && ($cnum =~ /Mare/));
      $cnum = "GG" if (($cnum =~ /^Grand/) && ($cnum =~ /Gelding/));

      local @cl_entry = grep (/^[0-9]+~~[A-Z]{0,1}[-0-9]+~~P{0,1}[0-9]+~~[A-Z-]*~~${cnum}~~/, @entry_list);
      next if ($#cl_entry < 0);
      $entry_count += $#cl_entry + 1;
print "Entries: ", ($#cl_entry + 1), "\n";

      foreach $line (@cl_entry) {
         ($b, $horsenum, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/, $line);
         ($j, $horsename, $j, $foaldate, $j) = split(/~~/, $horse_list{$horsenum});
         $hl{$horsenum} = "${horsenum}:${horsename}:${foaldate}";
      }
   }

print "Horses : ", scalar(keys %hl), "\n";
print "Entries: $entry_count\n";

   foreach $classdata (@class_list) {
      local ($national_num, $national_name) = split(/~/, $classdata);
      foreach $local (@show_classes) {
         ($cnum, $classname) = split(/\) /, $local, 2);
         if ($national_name eq $classname) {
            local @cl_entry = grep (/^[0-9]+~~[A-Z]{0,1}[-0-9]+~~P{0,1}[0-9]+~~[A-Z-]*~~${cnum}~~/, @entry_list);
            next if ($#cl_entry < 0);
            $entry_count += $#cl_entry + 1;

            foreach $line (@cl_entry) {
               ($b, $horsenum, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/, $line);
               ($j, $horsename, $j, $foaldate, $j) = split(/~~/, $horse_list{$horsenum});
               $hl{$horsenum} = "${horsenum}:${horsename}:${foaldate}";
       }
         }
      }
   }


#
#  Count up the entries and horses
#
   $horse_count = keys %hl;


#
#  HEADER INFORMATION
#
   if ($showbreed eq "buckskin")  { &buckskin_master_list_header; }
   if ($showbreed eq "appaloosa") { &appaloosa_master_list_header; }


#
#  Create the horse array (for simplicity)
#
   foreach $key (sort keys %hl) {
      push (@hl, $hl{$key});
   }


#
#  Now print the data
#
   while ($#hl >= 0) {
      $horsedata = shift(@hl);
      if (defined $horsedata) { ($horsenum1, $horsename1, $foaldate1) = split(/:/, $horsedata); }
      $horsedata = shift(@hl);
      if (defined $horsedata) {
         ($horsenum2, $horsename2, $foaldate2) = split(/:/, $horsedata);
      } else {
         $horsenum2 = $horsename2 = $foaldate2 = "";
      }

      &buckskin_master_list_html;
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


##################################################################################
#
#  Using Excel to print the billing form
#
#
sub billing_form {
   appaloosa_billing_form() if ($showbreed eq "appaloosa");
   buckskin_billing_form()  if ($showbreed eq "buckskin");
print "Back from form\n";
}


sub appaloosa_billing_form {
   print "Back Number For Form: $backnumber\n";

   $back_number_window->withdraw();
   &open_entry_file($showdir);
   &open_judge_file($showdir);
   &open_showinfo_file($showdir);
   &open_national_class_file;


#
#  Get all entries for this back number
#
   undef(@back_entries);
   undef(%back_entries);

   @back_entries = grep(/^${backnumber}~~/, @entry_list);
   foreach $entry (@back_entries) {
      ($back, $horse, $rider, $j, $class) = split(/~~/, $entry);
print "Back: $back   Rider: $rider\n";
      $key = "${back}:${rider}";
      $back_entries{$key} .= "$class:";
print "Entry: $back_entries{$key}\n";
   }

#
#  Open the excel application
#

   $excel = Win32::OLE->new('Excel.Application', sub {$_[0]->Quit;}) || die "Could not start Excel.Application\n";
   $excel->{visible} = 1;

#
#   Retrieve the Horse information
#
   ($regtype, $horsename, $horsesex, $yearfoaled, $horsecolor, $horsesire, $horsedam, $ownernum) = split(/~~/, $horse_list{$horsenum});
   ($ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $ownerhomephone, $ownerworkphone, $owneremail, $ownersex, $owneryear, $regtype, $ownernumberstatus) = split(/~~/, $member_list{$ownernum});


#
#   Open the existing blank worksheet
#
print "File Name: ${cwd}\\${showdir}\\bills\\${backnumber}.xls\n";

   if (-f "${cwd}\\${showdir}\\bills\\${backnumber}.xls") {
      $openfile = "${cwd}\\${showdir}\\bills\\${backnumber}.xls";
   } else {
      $openfile = "${cwd}\\EntryForm.xls";
   }
   my $book = $excel->Workbooks->Open($openfile);

#
#   Start writing data...
#
   $sheet = $book->Worksheets(1);

###############################################################
#
#           TEXAS ENTRY FORM
#
   $sheet->Range(A2)->{Value} = "$horsename";
   $sheet->Range(E2)->{Value} = "$horsenum";
   $sheet->Range(G2)->{Value} = "$yearfoaled";
   $sheet->Range(I2)->{Value} = "$horsesex";
   $sheet->Range(L2)->{Value} = "$showdate";
   $sheet->Range(N2)->{Value} = "$backnumber";
   $sheet->Range(A4)->{Value} = "$ownername";
   $sheet->Range(E4)->{Value} = "$ownernum";
   $sheet->Range(J3)->{Value} = "${owneraddress}\n${ownercity}, ${ownerstate} ${ownerzip}";
   $sheet->Range(N4)->{Value} = "$ownerhomephone";


   $open         = 0;
   $open_index   = 0;
   @open_rider   = ("J6", "J9");
   @open_num     = ("N6", "N9");
   @open_cell    = ("B6", "C6", "D6", "E6", "F6", "G6", "H6",
                    "B7", "C7", "D7", "E7", "F7", "G7", "H7",
                    "B8", "C8", "D8", "E8", "F8", "G8", "H8",
                    "B9", "C9", "D9", "E9", "F9", "G9", "H9",
                    "B10", "C10", "D10", "E10", "F10", "G10", "H10",
                    "B11", "C11", "D11", "E11", "F11", "G11", "H11");

   $nonpro       = 0;
   $nonpro_index = 0;
   @nonpro_rider = ("J12", "J15");
   @nonpro_num   = ("N12", "N15");
   @nonpro_rel   = ("L14", "L17");
   @nonpro_year  = ("O14", "O17");
   @nonpro_cell  = ("B12", "C12", "D12", "E12", "F12", "G12", "H12",
                    "B13", "C13", "D13", "E13", "F13", "G13", "H13",
                    "B14", "C14", "D14", "E14", "F14", "G14", "H14",
                    "B15", "C15", "D15", "E15", "F15", "G15", "H15",
                    "B16", "C16", "D16", "E16", "F16", "G16", "H16",
                    "B17", "C17", "D17", "E17", "F17", "G17", "H17");

   $youth        = 0;
   $youth_index  = 0;
   @youth_rider  = ("J18", "J21");
   @youth_num    = ("N18", "N21");
   @youth_rel    = ("L20", "L23");
   @youth_year   = ("O20", "O23");
   @youth_cell   = ("B18", "C18", "D18", "E18", "F18", "G18", "H18",
                    "B19", "C19", "D19", "E19", "F19", "G19", "H19",
                    "B20", "C20", "D20", "E20", "F20", "G20", "H20",
                    "B21", "C21", "D21", "E21", "F21", "G21", "H21",
                    "B22", "C22", "D22", "E22", "F22", "G22", "H22",
                    "B23", "C23", "D23", "E23", "F23", "G23", "H23");

   $local        = 0;
   $local_index  = 0;
   @local_cell   = ("B6", "C6", "D6", "E6", "F6", "G6", "H6",
                    "B7", "C7", "D7", "E7", "F7", "G7", "H7",
                    "B8", "C8", "D8", "E8", "F8", "G8", "H8");

   $special       = 0;
   $special_index = 0;
   @special_rider = ("J21");
   @special_num   = ("N21");
   @special_cell  = ("B21", "C21", "D21", "E21", "F21", "G21");

   $lead_cell    = "B24";
   $lead_rider   = "D24";
   $lead_rel     = "L24";
   $lead_num     = "L24";
   $lead_year    = "O24";
   $open_max    = int($#open_cell / 2) + 1;
   $nonpro_max  = int($#nonpro_cell / 2) + 1;
   $youth_max   = int($#youth_cell / 2) + 1;
   $special_max = int($#special_cell / 2) + 1;

#
###############################################################



###############################################################
#
#           TEXAS ENTRY FORM (WITH NSBA)
#
#   $sheet->Range(A2)->{Value} = "$horsename";
#   $sheet->Range(F2)->{Value} = "$horsenum";
#   $sheet->Range(H2)->{Value} = "$yearfoaled";
#   $sheet->Range(J2)->{Value} = "$horsesex";
#   $sheet->Range(M2)->{Value} = "$showdate";
#   $sheet->Range(O2)->{Value} = "$backnumber";
#   $sheet->Range(A4)->{Value} = "$ownername";
#   $sheet->Range(F4)->{Value} = "$ownernum";
#   $sheet->Range(K3)->{Value} = "${owneraddress}\n${ownercity}, ${ownerstate} ${ownerzip}";
#   $sheet->Range(O4)->{Value} = "$ownerhomephone";
#
#
#   $open         = 0;
#   $open_index   = 0;
#   @open_rider   = ("K6", "K10");
#   @open_num     = ("O6", "O10");
#   @open_cell    = ("B6", "C6", "D6", "E6", "F6", "G6", "H6", "I6",
#                    "B7", "C7", "D7", "E7", "F7", "G7", "H7", "I7",
#                    "B8", "C8", "D8", "E8", "F8", "G8", "H8", "I8",
#                    "B10", "C10", "D10", "E10", "F10", "G10", "H10", "I10",
#                    "B11", "C11", "D11", "E11", "F11", "G11", "H11", "I11",
#                    "B12", "C12", "D12", "E12", "F12", "G12", "H12", "I12");
#
#   $nonpro       = 0;
#   $nonpro_index = 0;
#   @nonpro_rider = ("K14", "K18");
#   @nonpro_num   = ("O14", "O18");
#   @nonpro_rel   = ("M17", "M21");
#   @nonpro_year  = ("P17", "P21");
#   @nonpro_cell  = ("B14", "C14", "D14", "E14", "F14", "G14", "H14", "I14",
#                    "B15", "C15", "D15", "E15", "F15", "G15", "H15", "I15",
#                    "B16", "C16", "D16", "E16", "F16", "G16", "H16", "I16",
#                    "B18", "C18", "D18", "E18", "F18", "G18", "H18", "I18",
#                    "B19", "C19", "D19", "E19", "F19", "G19", "H19", "I19",
#                    "B20", "C20", "D20", "E20", "F20", "G20", "H20", "I20");
#
#   $youth        = 0;
#   $youth_index  = 0;
#   @youth_rider  = ("K22", "K26");
#   @youth_num    = ("O22", "O26");
#   @youth_rel    = ("M25", "M28");
#   @youth_year   = ("P25", "P28");
#   @youth_cell   = ("B22", "C22", "D22", "E22", "F22", "G22", "H22", "I22",
#                    "B23", "C23", "D23", "E23", "F23", "G23", "H23", "I23",
#                    "B24", "C24", "D24", "E24", "F24", "G24", "H24", "I24",
#                    "B26", "C26", "D26", "E26", "F26", "G26", "H26", "I26",
#                    "B27", "C27", "D27", "E27", "F27", "G27", "H27", "I27",
#                    "B28", "C28", "D28", "E28", "F28", "G28", "H28", "I28");
#
#   $nsba_o       = 0;
#   $nsba_o_index = 0;
#   @nsba_o_rider = ("K6", "K10");
#   @nsba_o_num   = ("O9", "O13");
#   @nsba_o_cell  = ("B9", "C9", "D9", "E9", "F9", "G9", "H9", "I9",
#                    "B13", "C13", "D13", "E13", "F13", "G13", "H13", "I13");
#
#   $nsba_n       = 0;
#   $nsba_n_index = 0;
#   @nsba_n_rider = ("K14", "K18");
#   @nsba_n_num   = ("O16", "O20");
#   @nsba_n_year  = ("P17", "P21");
#   @nsba_n_cell  = ("B17", "C17", "D17", "E17", "F17", "G17", "H17", "I17",
#                    "B21", "C21", "D21", "E21", "F21", "G21", "H21", "I21");
#
#   $nsba_y       = 0;
#   $nsba_y_index = 0;
#   @nsba_y_rider = ("K22", "K26");
#   @nsba_y_num   = ("O24", "O28");
#   @nsba_y_year  = ("P25", "P29");
#   @nsba_y_cell  = ("B25", "C25", "D25", "E25", "F25", "G25", "H25", "I25",
#                    "B29", "C29", "D29", "E29", "F29", "G29", "H29", "I29");
#
#   $local        = 0;
#   $local_index  = 0;
#   @local_cell   = ("B6", "C6", "D6", "E6", "F6", "G6", "H6",
#                    "B7", "C7", "D7", "E7", "F7", "G7", "H7",
#                    "B8", "C8", "D8", "E8", "F8", "G8", "H8");
#
#   $special       = 0;
#   $special_index = 0;
#   @special_rider = ("J25");
#   @special_num   = ("N25");
#   @special_cell  = ("B25");
#
#   $lead_cell    = "B26";
#   $lead_rider   = "K26";
#   $lead_num     = "026";
#   $lead_rel     = "M29";
#   $lead_year    = "P29";
#
#   $open_max    = int($#open_cell / 2) + 1;
#   $nonpro_max  = int($#nonpro_cell / 2) + 1;
#   $youth_max   = int($#youth_cell / 2) + 1;
#   $special_max = int($#special_cell / 2) + 1;
#
#
#
###############################################################



###############################################################
#
#
#           DAL-WORTH ENTRY FORM
#
#
#   $sheet->Range(B1)->{Value} = "$horsename";
#   $sheet->Range(J1)->{Value} = "$horsenum";
#   $sheet->Range(Q1)->{Value} = "$yearfoaled";
#   $sheet->Range(M1)->{Value} = "$horsesex";
#   $sheet->Range(C2)->{Value} = "$ownername";
#   $sheet->Range(N2)->{Value} = "$ownernum";
#   $sheet->Range(C3)->{Value} = "${owneraddress}";
#   $sheet->Range(K3)->{Value} = "${ownercity}";
#   $sheet->Range(O3)->{Value} = "${ownerstate}";
#   $sheet->Range(Q3)->{Value} = "${ownerzip}";
#   $sheet->Range(C4)->{Value} = "$ownerhomephone";
#   $sheet->Range(H4)->{Value} = "$owneremail";
#
#   $open         = 0;
#   $open_index   = 0;
#   @open_rider   = ("C6", "C9");
#   @open_num     = ("L6", "L9");
#   @open_address = ("C7", "C10");
#   @open_city    = ("K7", "K10");
#   @open_state   = ("O7", "O10");
#   @open_zip     = ("Q7", "Q10");
#   @open_cell    = ("D5", "E5", "F5", "G5", "H5", "I5", "J5", "K5", "L5", "M5", "N5", "O5", "P5", "Q5",
#                    "D8", "E8", "F8", "G8", "H8", "I8", "J8", "K8", "L8", "M8", "N8", "O8", "P8", "Q8");
#
#   $nonpro         = 0;
#   $nonpro_index   = 0;
#   @nonpro_rider   = ("C12", "C16");
#   @nonpro_num     = ("N12", "N16");
#   @nonpro_rel     = ("G13", "G17");
#   @nonpro_year    = ("N13", "N17");
#   @nonpro_address = ("C14", "C18");
#   @nonpro_city    = ("K14", "K18");
#   @nonpro_state   = ("O14", "O18");
#   @nonpro_zip     = ("Q14", "Q18");
#   @nonpro_cell    = ("D11", "E11", "F11", "G11", "H11", "I11", "J11", "K11", "L11", "M11", "N11", "O11", "P11", "Q11",
#                      "D15", "E15", "F15", "G15", "H15", "I15", "J15", "K15", "L15", "M15", "N15", "O15", "P15", "Q15");
#
#   $youth         = 0;
#   $youth_index   = 0;
#   @youth_rider   = ("C20", "J24");
#   @youth_num     = ("N20", "N24");
#   @youth_rel     = ("G21", "G25");
#   @youth_year    = ("N21", "N25");
#   @youth_address = ("C22", "C26");
#   @youth_city    = ("K22", "K26");
#   @youth_state   = ("O22", "O26");
#   @youth_zip     = ("Q22", "Q26");
#   @youth_cell    = ("D19", "E19", "F19", "G19", "H19", "I19", "J19", "K19", "L19", "M19", "N19", "O19", "P19", "Q19",
#                     "D23", "E23", "F23", "G23", "H23", "I23", "J23", "K23", "L23", "M23", "N23", "O23", "P23", "Q23");
#
#   $local        = 0;
#   $local_index  = 0;
#   @local_cell   = ("B6", "C6", "D6", "E6", "F6", "G6", "H6",
#                    "B7", "C7", "D7", "E7", "F7", "G7", "H7",
#                    "B8", "C8", "D8", "E8", "F8", "G8", "H8");
#
#   $special       = 0;
#   $special_index = 0;
#   @special_rider = ("J17", "J20");
#   @special_num   = ("N18", "N21");
#   @special_year  = ("O19", "O22");
#   @special_cell  = ("B17", "C17", "D17", "E17", "F17", "G17", "H17",
#                     "B18", "C18", "D18", "E18", "F18", "G18", "H18",
#                     "B19", "C19", "D19", "E19", "F19", "G19", "H19",
#                     "B20", "C20", "D20", "E20", "F20", "G20", "H20",
#                     "B21", "C21", "D21", "E21", "F21", "G21", "H21",
#                     "B22", "C22", "D22", "E22", "F22", "G22", "H22");
#
#   $lead_cell    = "D23";
#   $lead_rider   = "C24";
#   $lead_num     = "N24";
#   $lead_year    = "N25";
#
#   $open_max    = int($#open_cell / 2) + 1;
#   $nonpro_max  = int($#nonpro_cell / 2) + 1;
#   $youth_max   = int($#youth_cell / 2) + 1;
#   $special_max = int($#special_cell / 2) + 1;
#
#
###############################################################



###############################################################
#
#
#           DAL-WORTH SIMPLIFIED ENTRY FORM
#
#
#   $sheet->Range(B2)->{Value} = "$horsename";
#   $sheet->Range(I2)->{Value} = "$horsenum";
#   $sheet->Range(O2)->{Value} = "$yearfoaled";
#   $sheet->Range(L2)->{Value} = "$horsesex";
#   $sheet->Range(C4)->{Value} = "$ownername";
#   $sheet->Range(N4)->{Value} = "$ownernum";
#   $sheet->Range(B5)->{Value} = "${owneraddress}";
#   $sheet->Range(B6)->{Value} = "${ownercity}";
#   $sheet->Range(I6)->{Value} = "${ownerstate}";
#   $sheet->Range(K6)->{Value} = "${ownerzip}";
#   $sheet->Range(M6)->{Value} = "$ownerhomephone";
#   $sheet->Range(C9)->{Value} = "$owneremail";
#
#   $open         = 0;
#   $open_index   = 0;
#   @open_rider   = ("C6", "C9");
#   @open_num     = ("L6", "L9");
#   @open_address = ("C7", "C10");
#   @open_city    = ("K7", "K10");
#   @open_state   = ("O7", "O10");
#   @open_zip     = ("Q7", "Q10");
#   @open_cell    = ("D5", "E5", "F5", "G5", "H5", "I5", "J5", "K5", "L5", "M5", "N5", "O5", "P5", "Q5",
#                    "D8", "E8", "F8", "G8", "H8", "I8", "J8", "K8", "L8", "M8", "N8", "O8", "P8", "Q8");
#
#   $nonpro         = 0;
#   $nonpro_index   = 0;
#   @nonpro_rider   = ("C12", "C16");
#   @nonpro_num     = ("N12", "N16");
#   @nonpro_rel     = ("G13", "G17");
#   @nonpro_year    = ("N13", "N17");
#   @nonpro_address = ("C14", "C18");
#   @nonpro_city    = ("K14", "K18");
#   @nonpro_state   = ("O14", "O18");
#   @nonpro_zip     = ("Q14", "Q18");
#   @nonpro_cell    = ("D11", "E11", "F11", "G11", "H11", "I11", "J11", "K11", "L11", "M11", "N11", "O11", "P11", "Q11",
#                      "D15", "E15", "F15", "G15", "H15", "I15", "J15", "K15", "L15", "M15", "N15", "O15", "P15", "Q15");
#
#   $youth         = 0;
#   $youth_index   = 0;
#   @youth_rider   = ("C20", "J24");
#   @youth_num     = ("N20", "N24");
#   @youth_rel     = ("G21", "G25");
#   @youth_year    = ("N21", "N25");
#   @youth_address = ("C22", "C26");
#   @youth_city    = ("K22", "K26");
#   @youth_state   = ("O22", "O26");
#   @youth_zip     = ("Q22", "Q26");
#   @youth_cell    = ("D19", "E19", "F19", "G19", "H19", "I19", "J19", "K19", "L19", "M19", "N19", "O19", "P19", "Q19",
#                     "D23", "E23", "F23", "G23", "H23", "I23", "J23", "K23", "L23", "M23", "N23", "O23", "P23", "Q23");
#
#   $local        = 0;
#   $local_index  = 0;
#   @local_cell   = ("B6", "C6", "D6", "E6", "F6", "G6", "H6",
#                    "B7", "C7", "D7", "E7", "F7", "G7", "H7",
#                    "B8", "C8", "D8", "E8", "F8", "G8", "H8");
#
#   $special       = 0;
#   $special_index = 0;
#   @special_rider = ("J17", "J20");
#   @special_num   = ("N18", "N21");
#   @special_year  = ("O19", "O22");
#   @special_cell  = ("B17", "C17", "D17", "E17", "F17", "G17", "H17",
#                     "B18", "C18", "D18", "E18", "F18", "G18", "H18",
#                     "B19", "C19", "D19", "E19", "F19", "G19", "H19",
#                     "B20", "C20", "D20", "E20", "F20", "G20", "H20",
#                     "B21", "C21", "D21", "E21", "F21", "G21", "H21",
#                     "B22", "C22", "D22", "E22", "F22", "G22", "H22");
#
#   $lead_cell    = "D23";
#   $lead_rider   = "C24";
#   $lead_num     = "N24";
#   $lead_year    = "N25";
#
#
###############################################################


print "CWD = $cwd\n";

   foreach $cell (@open_rider)     { print "Clearing Open Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@open_num)       { print "Clearing Open Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@open_cell)      { print "Clearing Open Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nonpro_rider)   { print "Clearing NonP Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nonpro_num)     { print "Clearing NonP Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nonpro_rel)     { print "Clearing NonP Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nonpro_year)    { print "Clearing NonP Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nonpro_cell)    { print "Clearing NonP Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@youth_rider)    { print "Clearing Yout Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@youth_num)      { print "Clearing Yout Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@youth_rel)      { print "Clearing Yout Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@youth_year)     { print "Clearing Yout Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@youth_cell)     { print "Clearing Yout Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@special_cell)   { print "Clearing Spec Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nsba_o_rider)   { print "Clearing NSBA Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nsba_o_num)     { print "Clearing NSBA Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nsba_o_cell)    { print "Clearing NSBA Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nsba_n_rider)   { print "Clearing NSBA Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nsba_n_num)     { print "Clearing NSBA Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nsba_n_rel)     { print "Clearing NSBA Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nsba_n_year)    { print "Clearing NSBA Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nsba_n_cell)    { print "Clearing NSBA Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nsba_y_rider)   { print "Clearing NSBA Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nsba_y_num)     { print "Clearing NSBA Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nsba_y_rel)     { print "Clearing NSBA Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nsba_y_year)    { print "Clearing NSBA Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nsba_y_cell)    { print "Clearing NSBA Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
#   print "Clearing Lead Cell: $cell\n"; $sheet->Range($lead_cell)->{Value}  = "";
#   print "Clearing Lead Cell: $cell\n"; $sheet->Range($lead_rider)->{Value} = "";
#   print "Clearing Lead Cell: $cell\n"; $sheet->Range($lead_num)->{Value}   = "";
#   print "Clearing Lead Cell: $cell\n"; $sheet->Range($lead_year)->{Value}  = "";

#
#  Look at each class and put in it's proper place
#
   foreach $key (sort { $a <=> $b } keys %back_entries) {
      ($backnum, $ridernum) = split(/:/, $key);
      ($ridername, $rideraddress, $ridercity, $riderstate, $riderzip, $riderhomephone, $riderworkphone, $rideremail, $ridersex, $rideryear, $regtype, $ridernumberstatus) = split(/~~/, $member_list{$ridernum});
      $riderinfo = "${ridername}\n${rideraddress}\n${ridercity}, ${riderstate} ${riderzip}";

print "\nFirst Back/Rider: $key\n";
print "Classes: $back_entries{$key}\n";
print "Rider: $ridername\n";

      @classes = split(/:/, $back_entries{$key});
foreach $cn (@classes) {
   print "Class: $cn\n";
}

      foreach $classnum (sort { $a <=> $b } @classes) {
         @rel = grep(/^${backnum}~~${horsenum}~~${ridernum}~~.*~~${classnum}~~/, @entry_list);
         ($j, $j, $j, $relation, $k) = split(/~~/, $rel[0]);
         next if ($classnum =~ /^G/);
print "Checking: $classnum\n";
#print "Relation: $relation\n";

#
#  NSBA Classes Now Done on the Same Form as Regular Classes
#

         if ($classnum =~ /N$/) {

            $classnum =~ s/N$//;

            if (is_open_class($classnum)) {
#print "Open class\n";
print "Adding NSBA Open Class To Cell ", ${nsba_o_cell}[$nsba_o_index], " For Open Rider #${nsba_o}\n";
               $sheet->Range(${nsba_o_cell}[$nsba_o_index])->{Value} = "${classnum}";
               $sheet->Range(${nsba_o_num}[$nsba_o])->{Value}        = "$ridernum";

               if (${nsba_o_address}[$nsba_o] ne "") {
                  $sheet->Range(${nsba_o_rider}[$nsba_o])->{Value}    = "$ridername";
                  $sheet->Range(${nsba_o_address}[$nsba_o])->{Value}  = "$rideraddress";
                  $sheet->Range(${nsba_o_city}[$nsba_o])->{Value}     = "$ridercity";
                  $sheet->Range(${nsba_o_state}[$nsba_o])->{Value}    = "$riderstate";
                  $sheet->Range(${nsba_o_zip}[$nsba_o])->{Value}      = "$riderzip";
               } else {
                  $sheet->Range(${nsba_o_rider}[$nsba_o])->{Value}    = "$riderinfo";
               }

               $nsba_o_index++;
            } else {
               if (is_nonpro_class($classnum)) {
#print "NonPro class\n\n";
print "Adding NSBA NonPro Class To Cell ", ${nsba_n_cell}[$nsba_n_index], " For NonPro Rider #${nsba_n}\n";
                  $sheet->Range(${nsba_n_cell}[$nsba_n_index])->{Value} = "${classnum}";
                  $sheet->Range(${nsba_n_num}[$nsba_n])->{Value}        = "$ridernum";
                  $sheet->Range(${nsba_n_year}[$nsba_n])->{Value}       = "$rideryear";

                  if (${nsba_n_address}[$nsba_n] ne "") {
                     $sheet->Range(${nsba_n_rider}[$nsba_n])->{Value}    = "$ridername";
                     $sheet->Range(${nsba_n_address}[$nsba_n])->{Value}  = "$rideraddress";
                     $sheet->Range(${nsba_n_city}[$nsba_n])->{Value}     = "$ridercity";
                     $sheet->Range(${nsba_n_state}[$nsba_n])->{Value}    = "$riderstate";
                     $sheet->Range(${nsba_n_zip}[$nsba_n])->{Value}      = "$riderzip";
                  } else {
                     $sheet->Range(${nsba_n_rider}[$nsba_n])->{Value}    = "$riderinfo";
                  }

                  $nsba_n_index++;
               } else {
                  if (is_youth_class($classnum)) {
#print "Youth class\n\n";
print "Adding NSBA Youth Class To Cell ", ${nsba_y_cell}[$nsba_y_index], " For Youth Rider #${youth}\n";
                     $sheet->Range(${nsba_y_cell}[$nsba_y_index])->{Value} = "${classnum}";
                     $sheet->Range(${nsba_y_num}[$nsba_y])->{Value}        = "$ridernum";
                     $sheet->Range(${nsba_y_year}[$nsba_y])->{Value}       = "$rideryear";

                     if (${nsba_y_address}[$nsba_y] ne "") {
                        $sheet->Range(${nsba_y_rider}[$nsba_y])->{Value}    = "$ridername";
                        $sheet->Range(${nsba_y_address}[$nsba_y])->{Value}  = "$rideraddress";
                        $sheet->Range(${nsba_y_city}[$nsba_y])->{Value}     = "$ridercity";
                        $sheet->Range(${nsba_y_state}[$nsba_y])->{Value}    = "$riderstate";
                        $sheet->Range(${nsba_y_zip}[$nsba_y])->{Value}      = "$riderzip";
                     } else {
                        $sheet->Range(${nsba_y_rider}[$nsba_y])->{Value}    = "$riderinfo";
                     }

                     $nsba_y_index++;
                  }
               }
            }

            next;
         }

#
#  Regular Classes Below Here
#

         if (is_open_class($classnum)) {
#print "Open class\n";
print "Adding Open Class To Cell ", ${open_cell}[$open_index], " For Open Rider #${open}\n";
            $sheet->Range(${open_cell}[$open_index])->{Value} = "$classnum";
            $sheet->Range(${open_num}[$open])->{Value}        = "$ridernum";

            if (${open_address}[$open] ne "") {
               $sheet->Range(${open_rider}[$open])->{Value}    = "$ridername";
               $sheet->Range(${open_address}[$open])->{Value}  = "$rideraddress";
               $sheet->Range(${open_city}[$open])->{Value}     = "$ridercity";
               $sheet->Range(${open_state}[$open])->{Value}    = "$riderstate";
               $sheet->Range(${open_zip}[$open])->{Value}      = "$riderzip";
            } else {
               $sheet->Range(${open_rider}[$open])->{Value}    = "$riderinfo";
            }

            $open_index++;
#            $nsba_o_index++ if ($nsba_o_index == 0);
         } else {
            if (is_nonpro_class($classnum)) {
#print "NonPro class\n";
print "Adding NonPro Class To Cell ", ${nonpro_cell}[$nonpro_index], " For NonPro Rider #${nonpro}\n";
               $sheet->Range(${nonpro_cell}[$nonpro_index])->{Value} = "$classnum";
               $sheet->Range(${nonpro_num}[$nonpro])->{Value}        = "$ridernum";
               $sheet->Range(${nonpro_year}[$nonpro])->{Value}       = "$rideryear";
               $sheet->Range(${nonpro_rel}[$nonpro])->{Value}        = "$relation";

               if (${nonpro_address}[$nonpro] ne "") {
                  $sheet->Range(${nonpro_rider}[$nonpro])->{Value}    = "$ridername";
                  $sheet->Range(${nonpro_address}[$nonpro])->{Value}  = "$rideraddress";
                  $sheet->Range(${nonpro_city}[$nonpro])->{Value}     = "$ridercity";
                  $sheet->Range(${nonpro_state}[$nonpro])->{Value}    = "$riderstate";
                  $sheet->Range(${nonpro_zip}[$nonpro])->{Value}      = "$riderzip";
               } else {
                  $sheet->Range(${nonpro_rider}[$nonpro])->{Value}    = "$riderinfo";
               }

               $nonpro_index++;
#               $nsba_n_index++ if ($nsba_n_index == 0);
            } else {
               if (is_leadline_class($classnum)) {
#print "Leadline class\n";
print "Adding Leadline Class To Cell ", ${lead_cell}, " For Leadline Rider\n";
                  $sheet->Range(${lead_cell})->{Value}  = "$classnum";
                  $sheet->Range(${lead_rider})->{Value} = "$ridername";
                  $sheet->Range(${lead_rel})->{Value}   = "$relation";
                  $sheet->Range(${lead_num})->{Value}   = "$ridernum";
                  $sheet->Range(${lead_year})->{Value}  = "$rideryear";
               } else {
                  if (is_youth_class($classnum)) {
#print "Youth class\n";
print "Adding Youth Class To Cell ", ${youth_cell}[$youth_index], " For Youth Rider #${youth}\n";
                     $sheet->Range(${youth_cell}[$youth_index])->{Value} = "$classnum";
                     $sheet->Range(${youth_num}[$youth])->{Value}        = "$ridernum";
                     $sheet->Range(${youth_year}[$youth])->{Value}       = "$rideryear";
                     $sheet->Range(${youth_rel}[$youth])->{Value}        = "$relation";

                     if (${youth_address}[$youth] ne "") {
                        $sheet->Range(${youth_rider}[$youth])->{Value}    = "$ridername";
                        $sheet->Range(${youth_address}[$youth])->{Value}  = "$rideraddress";
                        $sheet->Range(${youth_city}[$youth])->{Value}     = "$ridercity";
                        $sheet->Range(${youth_state}[$youth])->{Value}    = "$riderstate";
                        $sheet->Range(${youth_zip}[$youth])->{Value}      = "$riderzip";
                     } else {
                        $sheet->Range(${youth_rider}[$youth])->{Value}    = "$riderinfo";
                     }

                     $youth_index++;
#                     $nsba_y_index++ if ($nsba_y_index == 0);
                  } else {
#                     if (is_local_class($classnum)) {
#print "Local class\n\n";
#                        $local_index++;
#                     } else {
#print "Special class\n";
print "Adding Special Class To Cell ", ${special_cell}[$special_index], " For Rider #${special}\n";
                        $sheet->Range(${special_cell}[$special_index])->{Value} = "$classnum";
                        $sheet->Range(${special_rider}[$special])->{Value}      = "$ridername";
                        $sheet->Range(${special_num}[$special])->{Value}        = "$ridernum";
                        $special_index++;
#                     }
                  }
               }
            }
         }
      }

print "Checking Indexes\n";

      if ($open_index > 0 && $open_index != $open_max) {
         $open++;
         $open_index = $open_max;
print "Open $open Index = $open_index\n";
      }
      if ($nonpro_index > 0 && $nonpro_index != $nonpro_max) {
         $nonpro++;
         $nonpro_index = $nonpro_max;
print "NonPro $nonpro Index = $nonpro_index\n";
      }
      if ($youth_index > 0 && $youth_index != $youth_max) {
         $youth++;
         $youth_index = $youth_max;
print "Youth $youth Index = $youth_index\n";
      }
      if ($special_index > 0 && $special_index != $special_max) {
         $special++;
         $special_index = $special_max;
print "Special $special Index = $special_index\n";
      }
      if ($nsba_o_index > 0 && $nsba_o_index != 8) {
         $nsba_o++;
         $nsba_o_index = 8;
print "NSBA Open $nsba_o Index = $nsba_o_index\n";
      }
      if ($nsba_n_index > 0 && $nsba_n_index != 8) {
         $nsba_n++;
         $nsba_n_index = 8;
print "NSBA NonPro $nsba_n Index = $nsba_n_index\n";
      }
      if ($nsba_y_index > 0 && $nsba_y_index != 8) {
         $nsba_y++;
         $nsba_y_index = 8;
print "NSBA Youth $nsba_y Index = $nsba_y_index\n";
      }

   }


#
#  Save the file and exit
#
print "Saving: ${cwd}\\${showdir}\\bills\\${backnumber}.xls\n";
   $book->SaveAs("${cwd}\\${showdir}\\bills\\${backnumber}.xls");
#   $excel->Exit;
#   undef $book;
#   undef $excel;
}


sub buckskin_billing_form {
   print "Back Number For Form: $backnumber\n";

   $back_number_window->withdraw();
   &open_entry_file($showdir);
   &open_judge_file($showdir);
   &open_showinfo_file($showdir);
   &open_national_class_file;


#
#  Get all entries for this back number
#
   undef(@back_entries);
   undef(%back_entries);

   @back_entries = grep(/^${backnumber}~~/, @entry_list);
   foreach $entry (@back_entries) {
      ($back, $horse, $rider, $j, $class) = split(/~~/, $entry);
print "Back: $back   Rider: $rider\n";
      $key = "${back}:${rider}";
      $back_entries{$key} .= "$class:";
print "Entry: $back_entries{$key}\n";
   }

#
#  Open the excel application
#

   $excel = Win32::OLE->new('Excel.Application', sub {$_[0]->Quit;}) || die "Could not start Excel.Application\n";
   $excel->{visible} = 1;

#
#   Retrieve the Horse information
#
   ($regtype, $horsename, $horsesex, $yearfoaled, $horsecolor, $horsesire, $horsedam, $ownernum) = split(/~~/, $horse_list{$horsenum});
   ($ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $ownerhomephone, $ownerworkphone, $owneremail, $ownersex, $owneryear, $regtype, $ownernumberstatus) = split(/~~/, $member_list{$ownernum});


#
#   Open the existing blank worksheet
#
   if (-f "${cwd}\\${showdir}\\bills\\${backnumber}.xls") {
      $openfile = "${cwd}\\${showdir}\\bills\\${backnumber}.xls";
   } else {
      $openfile = "${cwd}\\BuckskinEntryForm.xls";
   }
   my $book = $excel->Workbooks->Open($openfile);

#
#   Start writing data...
#
   $sheet = $book->Worksheets(1);

#
#   Write Horse Data...
#
   $sheet->Range(C1)->{Value} = "$horsename";
   $sheet->Range(K1)->{Value} = "$horsenum";
   $sheet->Range(S1)->{Value} = "$yearfoaled";
   $sheet->Range(P1)->{Value} = substr("$horsesex", 0, 1);
   $sheet->Range(U2)->{Value} = "$backnumber";
   $sheet->Range(C2)->{Value} = "$ownername";
   $sheet->Range(C3)->{Value} = "${owneraddress}";
   $sheet->Range(N3)->{Value} = "${ownercity}, ${ownerstate} ${ownerzip}";

#
#   Write Class Entries for each Rider
#
   $open         = 0;
   $open_index   = 0;
   @open_rider   = ("N5", "N8");
   @open_num     = ("K5", "K8");
   @open_cell    = ("C5",  "D5",  "E5",  "F5",
                    "C6",  "D6",  "E6",  "F6",
                    "C7",  "D7",  "E7",  "F7",
                    "C8",  "D8",  "E8",  "F8",
                    "C9",  "D9",  "E9",  "F9",
                    "C10", "D10", "E10", "F10" );

   $nonpro       = 0;
   $nonpro_index = 0;
   @nonpro_rider = ("N11", "N14");
   @nonpro_num   = ("K11", "K14");
   @nonpro_rel   = ("P13", "P16");
   @nonpro_cell  = ("C11", "D11", "E11", "F11",
                    "C12", "D12", "E12", "F12",
                    "C13", "D13", "E13", "F13",
                    "C14", "D14", "E14", "F14",
                    "C15", "D15", "E15", "F15",
                    "C16", "D16", "E16", "F16" );

   $youth        = 0;
   $youth_index  = 0;
   @youth_rider  = ("N17", "N20");
   @youth_num    = ("K17", "K20");
   @youth_rel    = ("P19", "P22");
   @youth_cell   = ("C17", "D17", "E17", "F17",
                    "C18", "D18", "E18", "F18",
                    "C19", "D19", "E19", "F19",
                    "C20", "D20", "E20", "F20",
                    "C21", "D21", "E21", "F21",
                    "C22", "D22", "E22", "F22" );

   $breed        = 0;
   $breed_index  = 0;
   @breed_rider  = ("N23", "N26");
   @breed_cell   = ("C23", "D23", "E23", "F23",
                    "C24", "D24", "E24", "F24",
                    "C25", "D25", "E25", "F25",
                    "C26", "D26", "E26", "F26",
                    "C27", "D27", "E27", "F27",
                    "C28", "D28", "E28", "F28" );

   $school       = 0;
   $school_index = 0;
   @school_rider = ("N29", "N30");
   @school_cell  = ("C29", "D29", "E29", "F29",
                    "C30", "D30", "E30", "F30" );

print "CWD = $cwd\n";

#
#  Clear The Cells
#

   foreach $cell (@open_rider)    { print "Clearing Open   Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@open_num)      { print "Clearing Open   Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@open_cell)     { print "Clearing Open   Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nonpro_rider)  { print "Clearing NonPro Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nonpro_num)    { print "Clearing NonPro Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@nonpro_cell)   { print "Clearing NonPro Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@youth_rider)   { print "Clearing Youth  Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@youth_num)     { print "Clearing Youth  Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@youth_cell)    { print "Clearing Youth  Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@breed_rider)   { print "Clearing Breed  Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@breed_num)     { print "Clearing Breed  Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@breed_cell)    { print "Clearing Breed  Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@school_rider)  { print "Clearing School Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }
   foreach $cell (@school_cell)   { print "Clearing School Cell: $cell\n"; $sheet->Range($cell)->{Value} = ""; }

#
#  Look at each class and put in it's proper place
#
   foreach $key (sort { $a <=> $b } keys %back_entries) {
      ($backnum, $ridernum) = split(/:/, $key);
      ($ridername, $rideraddress, $ridercity, $riderstate, $riderzip, $riderhomephone, $riderworkphone, $rideremail, $ridersex, $rideryear, $regtype, $ridernumberstatus) = split(/~~/, $member_list{$ridernum});
      $riderinfo = "$ridername\n$rideryear";

print "\nFirst Back/Rider: $key\n";
print "Classes: $back_entries{$key}\n";
print "Rider: $ridername\n";

      @classes = split(/:/, $back_entries{$key});
foreach $cn (@classes) {
   print "Class: $cn\n";
}
      foreach $classnum (sort { $a <=> $b } @classes) {
         @rel = grep(/^${backnum}~~${horsenum}~~${ridernum}~~.*~~${classnum}~~/, @entry_list);
         ($j, $j, $j, $relation, $k) = split(/~~/, $rel[0]);

         next if ($classnum =~ /^GS/ || $classnum =~ /^GG/ || $classnum =~ /^GM/ ||
                  $classnum =~ /^OS/ || $classnum =~ /^OG/ || $classnum =~ /^OM/ ||
                  $classnum =~ /^OC/);
print "Checking: $classnum\n";
print "Relation: $relation\n";

         if (is_open_buckskin_class($classnum)) {
print "Open class\n";
print "Adding Open Class To Cell ", ${open_cell}[$open_index], " For Open Rider #${open}\n";
            $sheet->Range(${open_cell}[$open_index++])->{Value} = "$classnum";
            $sheet->Range(${open_rider}[$open])->{Value}      = "$riderinfo";
            $sheet->Range(${open_num}[$open])->{Value}        = "$ridernum";
         } else {
            if (is_nonpro_buckskin_class($classnum)) {
print "Amateur class\n\n";
print "Adding Amateur Class To Cell ", ${nonpro_cell}[$nonpro_index], " For NonPro Rider #${nonpro}\n";
               $sheet->Range(${nonpro_cell}[$nonpro_index++])->{Value} = "$classnum";
               $sheet->Range(${nonpro_rider}[$nonpro])->{Value}      = "$riderinfo";
               $sheet->Range(${nonpro_num}[$nonpro])->{Value}        = "$ridernum";
               $sheet->Range(${nonpro_rel}[$nonpro])->{Value}        = "$relation";
            } else {
               if (is_breed_buckskin_class($classnum)) {
print "All-Breed class\n\n";
print "Adding All-Breed Class To Cell ", ${breed_cell}[$breed_index], " For All-Breed Rider\n";
                  $sheet->Range(${breed_cell}[$breed_index++])->{Value}  = "$classnum";
                  $sheet->Range(${breed_rider}[$breed])->{Value} = "$riderinfo";
               } else {
                  if (is_youth_buckskin_class($classnum)) {
print "Youth class\n\n";
print "Adding Youth Class To Cell ", ${youth_cell}[$youth_index], " For Youth Rider #${youth}\n";
                     $sheet->Range(${youth_cell}[$youth_index++])->{Value} = "$classnum";
                     $sheet->Range(${youth_rider}[$youth])->{Value}      = "$riderinfo";
                     $sheet->Range(${youth_num}[$youth])->{Value}        = "$ridernum";
                     $sheet->Range(${youth_rel}[$youth])->{Value}        = "$relation";
                  } else {
                     if (is_school_buckskin_class($classnum)) {
print "Schooling class\n\n";
print "Adding Schooling Class To Cell ", ${school_cell}[$school_index], " For Rider #${school}\n";
                        $sheet->Range(${school_cell}[$school_index++])->{Value} = "$classnum";
                        $sheet->Range(${school_rider}[$school])->{Value}      = "$ridername";
                     }
                  }
               }
            }
         }
      }

      if ($open_index > 0) {
         $open++;
         $open_index = 12;
      }
      if ($nonpro_index > 0) {
         $nonpro++;
         $nonpro_index = 12;
      }
      if ($youth_index > 0) {
         $youth++;
         $youth_index = 12;
      }
      if ($breed_index > 0) {
         $breed++;
         $breed_index = 12;
      }
      if ($school_index > 0) {
         $school++;
         $school_index = 4;
      }
   }
print "Finished\n";

#
#  Save the file and exit
#
   $book->SaveAs("${cwd}\\${showdir}\\bills\\${backnumber}.xls");
   $book->Exit;
#   undef $book;
#   undef $excel;
}


##################################################################################
#
#  Print the billing receipt
#
#
sub billing_receipt() {
   $back_number_window->withdraw();
   &open_entry_file($showdir);
   &open_judge_file($showdir);
   &open_showinfo_file($showdir);


   $reporttype = "BILLING RECEIPT";

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;


#
#  Get all entries for this back number
#
   undef(%cle);
   @back_entries = grep(/^${backnumber}~~${horsenum}~~/, @entry_list);

#
#   Retrieve the Horse and Billing information
#
   ($regtype, $horsename, $horsesex, $yearfoaled, $horsecolor, $horsesire, $horsedam, $ownernum) = split(/~~/, $horse_list{$horsenum});
   ($opencost, $nonprocost, $youthcost, $localcost, $jumpfee, $cattlefee, $officefee, $tieoutfee, $stall1day, $stall2day, $shavings, $rvcost) = split(/~~/, $billing[0]);

#
#  Now get all of the entries for the back number
#
   foreach $ii (@back_entries) {
      (undef, undef, $ridernum, undef, $classnumber, undef) = split(/~~/, $ii);
      $cle{$classnumber} = $ridernum;
print "Found: $classnumber - $ridernum\n";
   }

   &billing_header_html;

#
#  Figure out all of the details for each class
#
   $totalclass = 0;
   foreach $key (sort { $a <=> $b } keys %cle) {
      @classinfo = grep(/^${key}\) /, @show_classes);
      ($classnum, $classname) = split(/\) /, $classinfo[0]);
      @billinginfo = grep(/^${classname}~~/, @billing);
      ($classname, $cost, $jump, $cattle) = split(/~~/, $billinginfo[0]);
      $class_cost = $cost + $jump + $cattle;
      $totalclass += $class_cost;
      ($ridername, $rideraddress, $ridercity, $riderstate, $riderzip, $riderhomephone, $riderworkphone, $rideremail, $ridersex, $rideryear, $regtype, $ridernumberstatus) = split(/~~/, $member_list{$cle{$key}});

      &billing_list_html;
   }

#
#  Print the totals
#

   print  HTML_REPORT "<TR><TD>&nbsp;</TD><TD>&nbsp;</TD><TD>&nbsp;</TD><TD><HR></TD></TR>";
   printf HTML_REPORT "<TR><TD>&nbsp;</TD><TD>&nbsp;</TD><TD>CLASS TOTAL</TD><TD ALIGN=MIDDLE>$totalclass</TD></TR>";
   printf HTML_REPORT "<TR><TD>&nbsp;</TD><TD>&nbsp;</TD><TD>OFFICE FEE</TD><TD ALIGN=MIDDLE>$officefee</TD></TR>";
   printf HTML_REPORT "<TR><TD>&nbsp;</TD><TD>&nbsp;</TD><TD>TIE OUT FEE</TD><TD ALIGN=MIDDLE>$tieoutfee</TD></TR>";
   printf HTML_REPORT "<TR><TD>&nbsp;</TD><TD>&nbsp;</TD><TD>STALL (1 DAY)</TD><TD ALIGN=MIDDLE>$stall1day</TD></TR>";
   printf HTML_REPORT "<TR><TD>&nbsp;</TD><TD>&nbsp;</TD><TD>STALL (2 DAY)</TD><TD ALIGN=MIDDLE>$stall2day</TD></TR>";
   printf HTML_REPORT "<TR><TD>&nbsp;</TD><TD>&nbsp;</TD><TD>SHAVINGS</TD><TD ALIGN=MIDDLE>$shavings</TD></TR>";
   printf HTML_REPORT "<TR><TD>&nbsp;</TD><TD>&nbsp;</TD><TD>RV SPACE</TD><TD ALIGN=MIDDLE>$rvfee</TD></TR>";

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


sub display_webpage {
   $url = $_[0];
   
#   $cmd = "start chrome.exe ${url}";
#   system($cmd);

   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";
   $IE->{visible} = 1;
   $IE->Navigate("${url}");

#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");

}


1;

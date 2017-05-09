##################################################################################
#
#       Open Existing Shows
#
##################################################################################


##################################################################################
##################################################################################
#
#  Display the window to open existing shows
#

sub open_existing_show {

#
#  If a show was passed in, go right to proper sub
#
   if ($showdate) {
      &selected_show;
      return;
   }

#
#  Get the show names from the show dir
#
   my @showlist = ();
   opendir (SHOW, "show") or do { print "Unable to open show directory: $!\n"; exit; };
   my @files = grep(/^[0-9]/, readdir(SHOW));
   closedir(SHOW);
print "Show Files: ", @files, "\n";

   foreach $file (sort { $b <=> $a } @files) {
print "File: $file\n";
      open (SI, "show/${file}/showinfo.txt") or die "Unable to open show information file for $file: $!\n";
      chomp($showdata = <SI>);
      close (SI);
      ($sname, $sdate) = split(/~~/, $showdata);
      my $show = "$sdate   $sname";
      push (@showlist, $show);
   }

#
#  Insert the show numbers in the listbox, changing the size
#  of the box if the number of shows is less than 12
#
   $os_shows_lb->delete(0, 'end');
   $os_shows_lb->insert('end', @showlist);
   $os_shows_lb->configure(-height => 16);
   $open_show_window->update();

#
#  Determine geometry of open show window
#
   my $screen_width = $open_show_window->screenwidth();
   my $screen_height = $open_show_window->screenheight();
   my $x_pos = int(($screen_width - $open_show_window->width()) / 2);
   my $y_pos = int(($screen_height - $open_show_window->height()) / 2);
   $open_show_window->geometry("+$x_pos+$y_pos");

#
#  Display the show selector window
#
   $open_show_window->update();
   $open_show_window->deiconify();
   $open_show_window->raise();
}


##################################################################################
##################################################################################
#
#  If a show is selected from the list, run the appropriate routine
#  based on the window_type variable
#

sub selected_show {
   if (!$showdate) {
      $showinfo = $os_shows_lb->get($os_shows_lb->curselection);
      ($showdate) = split(/   /, $showinfo);
      $showdate =~ s/\///g;
   }
   $showdate =~ s/\///g;
   $showdir = "show/$showdate";

#
#  Break out the show information
#
   &open_showinfo_file($showdir);
   &open_judge_file($showdir);
   ($showname, $showdate, $shownumber[0], $shownumber[1], $shownumber[2], $shownumber[3], $judgenumber[0], $judgenumber[1], $judgenumber[2], $judgenumber[3], $maxplaces, $showbreed) = split(/~~/, $openshowdata);
   $main_window_label = $showinfo = "$showdate   $showname";
   $showbreed = "appaloosa" if (! $showbreed);

#
#  Call the appropriate show routine
#
   if    ($window_type eq "run")    { &run_show_select;           }
   elsif ($window_type eq "place")  { &place_class_select;        }
   elsif ($window_type eq "scored") { &place_scored_class_select; }
   elsif ($window_type eq "report") { &report_show_select;        }
   elsif ($window_type eq "create") { &copy_existing_show;        }
}


##################################################################################
##################################################################################
#
#  If a show is selected from the list, extract the show date and convert it into
#  the show directory and open the show info file.  Take the show info and break
#  it out into the needed parts.
#

sub run_show_select {
#
#  Display the main title and close the show select window
#
   $open_show_window->withdraw();

#
#  Display the window to add entries to the show
#
   &open_entry_file($showdir) if (-e "$showdir/entry.txt");
   &open_horse_file($showdir);
   &open_member_file($showdir);

   $current_entries_label  = "Current # Entries : " . $entry_count . "        ";
   $current_entries_label .= "Current # Horses : " . $horse_count;

   $run_show_window->deiconify();
   $run_show_window->raise();
   $backnumentry->focus();
}


##################################################################################
##################################################################################
#
#  Copy an existing show when creating a new show
#

sub copy_existing_show{
#
#  Display the main title and close the show select window
#
   $open_show_window->withdraw();

#
#  Display the window to add entries to the show
#
   &open_entry_file($showdir) if (-e "$showdir/entry.txt");
   &open_horse_file($showdir);
   &open_member_file($showdir);

   $current_entries_label  = "Current # Entries : " . $entry_count . "        ";
   $current_entries_label .= "Current # Horses : " . $horse_count;

   $run_show_window->deiconify();
   $run_show_window->raise();
   $backnumentry->focus();
}


##################################################################################
##################################################################################
#
#  If a show is selected from the list, extract the show date and convert it into
#  the show directory and open the show info file.  Take the show info and break
#  it out into the needed parts.
#

sub place_class_select {
   $numjudges = 0;
   foreach $ii (@judgenumber) {
      $numjudges++ if ($ii);
   }

   &place_class_toplevel();
   &place_grandreserve_toplevel();
   &tie_toplevel;

#
#  Display the main title and close the show select window
#
   $open_show_window->withdraw();

#
#  Display the window to select a class to place
#
   &open_entry_file($showdir) if (-e "$showdir/entry.txt");
   &open_horse_file($showdir);
   &open_member_file($showdir);

   $current_entries_label  = "Current # Entries : " . $entry_count . "        ";
   $current_entries_label .= "Current # Horses : " . $horse_count;

   $class_lb->delete(0, 'end');
   $class_lb->insert('end', @show_classes);
   $class_lb->configure(-height => 15);
#   $class_lb->configure(-width => $maxwidth);

   $choose_class_window->deiconify();
   $choose_class_window->raise();
}


##################################################################################
##################################################################################
#
#  If a show is selected from the list, extract the show date and convert it into
#  the show directory and open the show info file.  Take the show info and break
#  it out into the needed parts.
#

sub place_scored_class_select {
   $numjudges = 0;
   foreach $ii (@judgenumber) {
      $numjudges++ if ($ii);
   }

#
#  Display the main title and close the show select window
#
   $open_show_window->withdraw();

#
#  Display the window to select a class to place
#
   &open_entry_file($showdir) if (-e "$showdir/entry.txt");
   &open_horse_file($showdir);
   &open_member_file($showdir);

   $current_entries_label  = "Current # Entries : " . $entry_count . "        ";
   $current_entries_label .= "Current # Horses : " . $horse_count;

   $class_lb->delete(0, 'end');
   $class_lb->insert('end', @show_classes);
   $class_lb->configure(-height => 15);
#   $class_lb->configure(-width => $maxwidth);

   $choose_class_window->deiconify();
   $choose_class_window->raise();
}


##################################################################################
##################################################################################
#
#  If a show is selected from the list, extract the show date and convert it into
#  the show directory and open the show info file.  Take the show info and break
#  it out into the needed parts.
#

sub report_show_select {
#
#  Display the main title and close the show select window
#
   $open_show_window->withdraw();

#
#  Display the window to run reports
#
   &open_entry_file($showdir) if (-e "$showdir/entry.txt");
   &open_horse_file($showdir);
   &open_member_file($showdir);

   $current_entries_label  = "Current # Entries : " . $entry_count . "        ";
   $current_entries_label .= "Current # Horses : " . $horse_count;

   $report_main_window->deiconify();
   $report_main_window->raise();
}


##################################################################################
##################################################################################
#
#  If the user cancels the select, remove show names from
#  the active show array and from the list on the main window
#

sub cancel_show_select {
   $openshowdata = "";
   $main_window_label = " ";
   $open_show_window->withdraw();
}


##################################################################################
##################################################################################
#
#  If a show is selected from the list, extract the show date and convert it into
#  the show directory and open the show info file.  Take the show info and break
#  it out into the needed parts.  Fill in the Create window with the new information
#

sub copy_existing_show {

#
#  Display the main title and close the show select window
#
   $open_show_window->withdraw();

#
#  Clear some needed variables
#

   $showdate = "";
   $shownumber[0] = $shownumber[1] = $shownumber[2] = $shownumber[3] = "";

#
#  Insert the Class information
#

   foreach $line (@show_classes) {
      $cl_select_lb->insert('end', $line);
   }

#
#  Insert the High Point information
#
#      $show_class_list{$mnum} = $rest;
#

   open_report_high_point_file($showdir);

   foreach my $division (sort keys %hp_report) {
      $hp{$division}[0] = $hp_report{$division}[0];
      $hp{$division}[1] = $hp_report{$division}[1];
      $hp{$division}[2] = "";

      my (@cls) = split(/,/, $hp_report{$division}[2]);
      foreach my $classnum (@cls) {
         $hp{$division}[2] .= "${classnum}) $show_class_list{$classnum}~~";
      }

      $hp_setup_lb->insert('end', $division);
   }


}


1;

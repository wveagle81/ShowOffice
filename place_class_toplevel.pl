##################################################################################
##################################################################################
#
#       Create The Toplevel windows
#

sub create_toplevel {

   &create_message_dialog;
#   &display_message("Initializing Horse Show Office Windows - Please Be Patient!", 0, "i");

   &open_show_toplevel;
   &choose_class_toplevel;
   &add_new_entry_toplevel;
   &delete_entry_toplevel;
   &rider_list_toplevel;

   $msgdialog->withdraw();
}


##################################################################################
##################################################################################
#
#  Choose the class to place
#

sub choose_class_toplevel {

   if (!Exists($choose_class_window)) {
      $choose_class_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Choose A Class To Place');

      $choose_class_window->Label(-textvariable => \$showinfo,
                              -anchor       => 'center',
                              -background   => 'navy',
                              -foreground   => 'yellow',
                              -borderwidth  => '2',
                              -relief       => 'groove',
                              -justify      => 'center')->pack(-side => 'top', -fill => 'x');

#
#  Class Number
#
      $cc_frame1 = $choose_class_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $cc_frame1->Label(-text        => "Class Number",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'left')->pack(-side => 'left');
      $classentry = $cc_frame1->Entry(-textvariable => \$classnumber,
                         -background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 6) -> pack(-side => 'left');

#
#  Class Scrolled List
#

      $cc_frame2 = $choose_class_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $class_lb   = $cc_frame2->Scrolled("Listbox", -scrollbars => 'oe',
                              -selectmode => 'single',
                              -width => 50)->pack(-side => 'top');


#
#  Buttons
#
      $cc_frame3 = $choose_class_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $cc_frame3->Button(-text => "Ok", -command => \&place_class)->pack(-side => "left", -padx => 30, -pady => 5);
      $cc_frame3->Button(-text => "Exit", -command => sub { exit; })->pack(-side => "right", -padx => 30, -pady => 5);

      $choose_class_window->withdraw();
      $choose_class_window->update();

      $classentry->bind("<Return>", \&place_class);
      $classentry->bind("<Tab>", \&place_class);
      $classentry->bind("<Shift-Tab>", \&place_class);
      $class_lb->bind("<Double-Button-1>", \&place_class);

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $choose_class_window->width()) / 2;
      $y_pos = ($screen_height - $choose_class_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $choose_class_window->geometry("+$x_pos+$y_pos");
   }
}


##################################################################################
##################################################################################
#
#  Place The Chosen Class
#
#  This is run after the show is opened. It relies on max number of places and
#  the judges to create the proper format of the window
#

sub place_class_toplevel {

   if (!Exists($place_class_window)) {
      $place_class_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Place A Class');

      $place_class_window->Label(-textvariable => \$showname,
                              -anchor       => 'center',
                              -background   => 'navy',
                              -foreground   => 'yellow',
                              -borderwidth  => '2',
                              -relief       => 'groove',
                              -justify      => 'center')->pack(-side => 'top', -fill => 'x');

#
#  Class Information
#
      $pcw_frame1 = $place_class_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $pcw_frame1->Label(-text        => "Class Information:",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');

      $pcw_frame1->Label(-textvariable => \$classnumber,
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'black',
                         -borderwidth => '0',
                         -width       =>  5,
                         -justify     => 'left')->pack(-side => 'left');

      $pcw_frame1->Label(-textvariable => \$classname,
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'black',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');

#
#  Class Placings Header
#
      $pcw_frame2 = $place_class_window->
                       Frame(-background  => 'black',
                             -borderwidth => 1,
                             -relief      => 'raised')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $pcw_frame2->Label(-text        => " JUDGE NAMES",
                         -anchor      => 'w',
                         -background  => 'black',
                         -foreground  => 'yellow',
                         -borderwidth => '0',
                         -justify     => 'left',
                         -width       => 25)->pack(-side => 'left');

      for $ii (1 .. $maxplaces) {
#         $pcw_frame2->Label(-text        => " $ii      T      ",
         $pcw_frame2->Label(-text        => " $ii         ",
                            -anchor      => 'w',
                            -background  => 'black',
                            -foreground  => 'yellow',
                            -borderwidth => '0',
                            -justify     => 'left',
                            )->pack(-side => 'left');
      }

      $class_index = 0;
      for $judge (0 .. $numjudges-1) {
         $pcw_frame[$judge] = $place_class_window->
                                   Frame(-background  => 'grey',
                                         -borderwidth => 5,
                                         -relief      => 'flat')->
                                      pack(-side   => 'top',
                                           -fill   => 'x',
                                           -expand => 1,
                                           -anchor => 'n');

         $pcw_frame[$judge]->Label(-textvariable => \$judge_list{$judgenumber[$judge]},
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'black',
                         -borderwidth => '0',
                         -justify     => 'left',
                         -width       => 25)->pack(-side => 'left');

         for $ii (0 .. $maxplaces-1) {
            $classentered[$class_index] = $pcw_frame[$judge]->Entry(-background => 'white',
                               -foreground   => 'black',
                               -takefocus    => 1,
                               -width        => 3,
                               -textvariable => \$classplace{$judge}[$ii]) -> pack(-side => 'left');
            $pcw_frame[$judge]->Label(-anchor => 'w',
                               -background   => 'grey',
                               -foreground   => 'navy',
                               -borderwidth  => '0',
                               -width        =>  2,
                               -justify      => 'left')->pack(-side => 'left');
#            $pcw_frame[$judge]->Checkbutton(-anchor => 'w',
#                               -background   => 'grey',
#                               -foreground   => 'navy',
#                               -borderwidth  => '0',
#                               -variable     => \$classtie{$judge}[$ii])->pack(-side => 'left');
            $class_index++;
         }
      }


#
#  Buttons
#
      $pcw_frame8 = $place_class_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $pcw_frame8->Label(-text => "Enter placings in the text boxes above. To repeat placings for every judge, press the Insert key",
                              -anchor       => 'n',
                              -background   => 'black',
                              -foreground   => 'white',
                              -borderwidth  => '0',
                              -justify      => 'left')->pack(-side => 'top', -fill => 'x');
      $pcw_frame8->Label(-textvariable => \$entrieslabel,
                              -anchor       => 'n',
                              -background   => 'black',
                              -foreground   => 'yellow',
                              -borderwidth  => '0',
                              -justify      => 'left')->pack(-side => 'left', -fill => 'x');
      $pcw_frame8->Label(-textvariable => \$entrieslabel2,
                              -anchor       => 'n',
                              -background   => 'black',
                              -foreground   => 'cyan',
                              -borderwidth  => '0',
                              -justify      => 'left')->pack(-side => 'left', -fill => 'x');

      $pcw_frame9 = $place_class_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $pcw_frame9->Button(-text => "Ok",  -command => \&save_placing_info )->pack(-side => "left", -padx => 30, -pady => 5);
#      $pcw_frame9->Button(-text => "Tie", -command => \&add_tie_info)->pack(-side => "left", -padx => 30, -pady => 5);
      $pcw_frame9->Button(-text => "Cancel", -command => sub { $classnumber = "";
                                                               $choose_class_window->update();
                                                               $choose_class_window->deiconify();
                                                               $choose_class_window->raise();
                                                               $place_class_window->withdraw(); })->pack(-side => "right", -padx => 30, -pady => 5);

      $place_class_window->withdraw();
      $place_class_window->update();

      for $place (0 .. $class_index-1) {
         $classentered[$place]->bind("<Return>", \&check_entry);
         $classentered[$place]->bind("<Tab>", \&check_entry);
         $classentered[$place]->bind("<Shift-Tab>", \&check_entry);
         $classentered[$place]->bind("<Insert>", \&fill_placing);
      }

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $place_class_window->width()) / 2;
      $y_pos = ($screen_height - $place_class_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $place_class_window->geometry("+$x_pos+0");
   }
}




##################################################################################
##################################################################################
#
#  Create Tie Information
#
#  If there is a tie, then the user can click on the places
#  that were tied.
#
#  One problem, though.  What if there are two or more places tied?  For
#  example, what if 1st & 2nd tied, and 4th $5th tied?  Hmmm....
#

sub tie_toplevel {

   if (!Exists(tie_window)) {
      $tie_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Enter Tie Info');

      $tie_window->Label(-textvariable => \$showname,
                         -anchor       => 'center',
                         -background   => 'navy',
                         -foreground   => 'yellow',
                         -borderwidth  => '2',
                         -relief       => 'groove',
                         -justify      => 'center')->pack(-side => 'top', -fill => 'x');

#
#  Class Information
#
      $tw_frame1 = $tie_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $tw_frame1->Label(-text        => "Class Information:",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');

      $tw_frame1->Label(-textvariable => \$classnumber,
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'black',
                         -borderwidth => '0',
                         -width       =>  5,
                         -justify     => 'left')->pack(-side => 'left');

      $tw_frame1->Label(-textvariable => \$classname,
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'black',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');

#
#  Class Placings Header
#
      $tw_frame2 = $tie_window->
                       Frame(-background  => 'black',
                             -borderwidth => 1,
                             -relief      => 'raised')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $tw_frame2->Label(-text        => " JUDGE NAMES",
                         -anchor      => 'w',
                         -background  => 'black',
                         -foreground  => 'yellow',
                         -borderwidth => '0',
                         -justify     => 'left',
                         -width       => 25)->pack(-side => 'left');

      $tw_frame2->Label(-text        => " TIED PLACES",
                         -anchor      => 'w',
                         -background  => 'black',
                         -foreground  => 'yellow',
                         -borderwidth => '0',
                         -justify     => 'left',
                         -width       => 25)->pack(-side => 'left');

      for $judge (0 .. $numjudges-1) {
         $tw_frame[$judge] = $tie_window->
                                   Frame(-background  => 'grey',
                                         -borderwidth => 5,
                                         -relief      => 'flat')->
                                      pack(-side   => 'top',
                                           -fill   => 'x',
                                           -expand => 1,
                                           -anchor => 'n');

         $tw_frame[$judge]->Label(-textvariable => \$judge_list{$judgenumber[$judge]},
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'black',
                         -borderwidth => '0',
                         -justify     => 'left',
                         -width       => 25)->pack(-side => 'left');

         $tw_frame[$judge]->Entry(-background => 'white',
                            -foreground   => 'black',
                            -takefocus    => 1,
                            -width        => 5,
                            -textvariable => \$classtie{$judge}[0]) -> pack(-side => 'left');
         $tw_frame[$judge]->Label(-anchor => 'w',
                            -background   => 'grey',
                            -foreground   => 'navy',
                            -borderwidth  => '0',
                            -width        =>  2,
                            -justify      => 'left')->pack(-side => 'left');
         $tw_frame[$judge]->Entry(-background => 'white',
                            -foreground   => 'black',
                            -takefocus    => 1,
                            -width        => 5,
                            -textvariable => \$classtie{$judge}[1]) -> pack(-side => 'left');
         $tw_frame[$judge]->Label(-anchor => 'w',
                            -background   => 'grey',
                            -foreground   => 'navy',
                            -borderwidth  => '0',
                            -width        =>  2,
                            -justify      => 'left')->pack(-side => 'left');
         $tw_frame[$judge]->Entry(-background => 'white',
                            -foreground   => 'black',
                            -takefocus    => 1,
                            -width        => 5,
                            -textvariable => \$classtie{$judge}[2]) -> pack(-side => 'left');
         $tw_frame[$judge]->Label(-anchor => 'w',
                            -background   => 'grey',
                            -foreground   => 'navy',
                            -borderwidth  => '0',
                            -width        =>  2,
                            -justify      => 'left')->pack(-side => 'left');
      }


#
#  Buttons
#
      $tw_frame8 = $tie_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $tw_frame8->Button(-text => "Ok",  -command => sub { $tie_window->withdraw(); })->pack(-side => "left", -padx => 30, -pady => 5);
      $tw_frame8->Button(-text => "Cancel", -command => sub { $tie_window->withdraw(); })->pack(-side => "right", -padx => 30, -pady => 5);

      $tie_window->withdraw();
      $tie_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $tie_window->width()) / 2;
      $y_pos = ($screen_height - $tie_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $tie_window->geometry("+$x_pos+0");
   }
}


##################################################################################
##################################################################################
#
#  Place Grand and Reserve Classes
#

sub place_grandreserve_toplevel {

   if (!Exists($place_gr_window)) {
      $place_gr_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Place A Class');

      $place_gr_window->Label(-textvariable => \$showname,
                              -anchor       => 'center',
                              -background   => 'navy',
                              -foreground   => 'yellow',
                              -borderwidth  => '2',
                              -relief       => 'groove',
                              -justify      => 'center')->pack(-side => 'top', -fill => 'x');

#
#  Class Information
#
      $pgr_frame1 = $place_gr_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $pgr_frame1->Label(-text        => "Class Information:",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');

      $pgr_frame1->Label(-textvariable => \$classname,
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'black',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');

#
#  Class Placings Header
#
      $pgr_frame2 = $place_gr_window->
                       Frame(-background  => 'black',
                             -borderwidth => 1,
                             -relief      => 'raised')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $pgr_frame2->Label(-text        => " JUDGE NAMES",
                         -anchor      => 'w',
                         -background  => 'black',
                         -foreground  => 'yellow',
                         -borderwidth => '0',
                         -justify     => 'left',
                         -width       => 22)->pack(-side => 'left');

      $pgr_frame2->Label(-text        => " 1            2",
                         -anchor      => 'w',
                         -background  => 'black',
                         -foreground  => 'yellow',
                         -borderwidth => '0',
                         -justify     => 'left',
                         )->pack(-side => 'left');

      $class_index = 0;
      for $judge (0 .. $numjudges-1) {
         $pgr_frame[$judge] = $place_gr_window->
                                   Frame(-background  => 'grey',
                                         -borderwidth => 5,
                                         -relief      => 'flat')->
                                      pack(-side   => 'top',
                                           -fill   => 'x',
                                           -expand => 1,
                                           -anchor => 'n');

         $pgr_frame[$judge]->Label(-textvariable => \$judge_list{$judgenumber[$judge]},
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'black',
                         -borderwidth => '0',
                         -justify     => 'left',
                         -width       => 20)->pack(-side => 'left');

         $classentered[0] = $pgr_frame[$judge]->Entry(-background => 'white',
                            -foreground   => 'black',
                            -takefocus    => 1,
                            -width        => 3,
                            -textvariable => \$classplace{$judge}[0]) -> pack(-side => 'left');
         $pgr_frame[$judge]->Label(-anchor => 'w',
                            -background   => 'grey',
                            -foreground   => 'navy',
                            -borderwidth  => '0',
                            -width        =>  3,
                            -justify      => 'left')->pack(-side => 'left');
         $classentered[1] = $pgr_frame[$judge]->Entry(-background => 'white',
                            -foreground   => 'black',
                            -takefocus    => 1,
                            -width        => 3,
                            -textvariable => \$classplace{$judge}[1]) -> pack(-side => 'left');
      }


#
#  Buttons
#
      $pgr_frame8 = $place_gr_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $pgr_frame8->Button(-text => "Ok", -command => \&save_gr_placing_info )->pack(-side => "left", -padx => 30, -pady => 5);
      $pgr_frame8->Button(-text => "Cancel", -command => sub { $choose_class_window->deiconify();
                                                               $choose_class_window->raise();
                                                               $choose_class_window->focusForce;
                                                               $place_gr_window->withdraw(); })->pack(-side => "right", -padx => 30, -pady => 5);

      $place_gr_window->withdraw();
      $place_gr_window->update();

#      for $place (0 .. $class_index-1) {
#         $classentered[$place]->bind("<Return>", \&check_entry);
#         $classentered[$place]->bind("<Tab>", \&check_entry);
#         $classentered[$place]->bind("<Shift-Tab>", \&check_entry);
#      }

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $place_gr_window->width()) / 2;
      $y_pos = ($screen_height - $place_gr_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $place_gr_window->geometry("+$x_pos+0");
   }
}


##################################################################################
##################################################################################
#
#  Create the toplevel window for adding a complete entry to a show
#

sub run_show_toplevel {

   if (!Exists($run_show_window)) {
      if (-e "data/member.txt") {
         &open_member_file;
      } else {
         %member_list = ();
      }

      if (-e "data/horse.txt") {
         &open_horse_file;
      } else {
         %horse_list = ();
      }

      $run_show_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Add Show Entries');

      $run_show_window->Label(-textvariable => \$showname,
                              -anchor       => 'center',
                              -background   => 'navy',
                              -foreground   => 'yellow',
                              -borderwidth  => '2',
                              -relief       => 'groove',
                              -justify      => 'center')->pack(-side => 'top', -fill => 'x');

#
#  Back Number
#
      $rsw_frame1 = $run_show_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $rsw_frame1->Label(-text        => "Back Number",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'left')->pack(-side => 'left');
      $backnumentry = $rsw_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 6,
                         -textvariable => \$backnumber) -> pack(-side => 'left');

#
#  Horse ApHC Membership Number
#
      $rsw_frame2 = $run_show_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $rsw_frame2->Label(-text        => "Horse ApHC Number",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'left')->pack(-side => 'left');
      $hn = $rsw_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 15,
                         -textvariable => \$horsenum) -> pack(-side => 'left');
      $rsw_frame2->Label(-anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  5,
                         -justify      => 'left')->pack(-side => 'left');
      $rsw_frame2->Label(-textvariable => \$horsename,
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  25,
                         -justify      => 'left')->pack(-side => 'left');

#
#  Rider ApHC Membership Number
#
      $rsw_frame3 = $run_show_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $rsw_frame3->Label(-text        => "Exhibitor ApHC Number",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'left')->pack(-side => 'left');
      $rn = $rsw_frame3->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 15,
                         -textvariable => \$ridernum) -> pack(-side => 'left');
      $rsw_frame3->Label(-anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  5,
                         -justify      => 'left')->pack(-side => 'left');
      $rsw_frame3->Label(-textvariable => \$ridername,
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  25,
                         -justify      => 'left')->pack(-side => 'left');

#
#  Class Numbers
#
      $run_show_window->Label(-text        => "Classes Entered",
                              -anchor      => 'center',
                              -background  => 'grey',
                              -foreground  => 'navy',
                              -borderwidth => '0',
                              -justify     => 'center')->pack(-side => 'top', -fill => 'x');

      $class_index = 0;
      for $cl_index (0 .. 2) {
         $rsw_frame[$cl_index] = $run_show_window->
                                   Frame(-background  => 'grey',
                                         -borderwidth => 5,
                                         -relief      => 'flat')->
                                      pack(-side   => 'top',
                                           -fill   => 'x',
                                           -expand => 1,
                                           -anchor => 'n');
            $rsw_frame[$cl_index]->Label(-anchor       => 'w',
                               -background   => 'grey',
                               -foreground   => 'navy',
                               -borderwidth  => '0',
                               -justify      => 'left')->pack(-side => 'left');

         for $ii (0 .. 9) {
            $classentered[$class_index] = $rsw_frame[$cl_index]->Entry(-background => 'white',
                               -foreground   => 'black',
                               -takefocus    => 1,
                               -width        => 3,
                               -textvariable => \$rider_class[$class_index]) -> pack(-side => 'left');
            $rsw_frame[$cl_index]->Label(-anchor       => 'w',
                               -background   => 'grey',
                               -foreground   => 'navy',
                               -borderwidth  => '0',
                               -width        =>  3,
                               -justify      => 'left')->pack(-side => 'left');
            $class_index++;
         }
      }


#
#  Buttons
#
      $rsw_frame8 = $run_show_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $rsw_frame8->Button(-text => "Ok", -command => \&save_entry_info )->pack(-side => "left", -padx => 30, -pady => 5);
      $rsw_frame8->Button(-text => "Add", -command => \&add_new_entry )->pack(-side => "left", -padx => 30, -pady => 5);
      $rsw_frame8->Button(-text => "Scratch", -command => \&scratch_entry )->pack(-side => "left", -padx => 30, -pady => 5);
      $rsw_frame8->Button(-text => "Cancel", -command => sub { exit; })->pack(-side => "right", -padx => 30, -pady => 5);

      $backnumentry->bind("<Return>", \&lookup_back_number);
      $backnumentry->bind("<Tab>", \&lookup_back_number);
      $backnumentry->bind("<Shift-Tab>", \&lookup_back_number);
      $hn->bind("<Return>", \&lookup_horse_number);
      $hn->bind("<Tab>", \&lookup_horse_number);
      $hn->bind("<Shift-Tab>", \&lookup_horse_number);
      $rn->bind("<Return>", \&lookup_rider_number);
      $rn->bind("<Tab>", \&lookup_rider_number);
      $rn->bind("<Shift-Tab>", \&lookup_rider_number);

      $run_show_window->withdraw();
      $run_show_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $run_show_window->width()) / 2;
      $y_pos = ($screen_height - $run_show_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $run_show_window->geometry("+$x_pos+0");
   }
}


##################################################################################
##################################################################################
#
#  Create the toplevel window for adding a horse's information
#

sub add_horse_information_toplevel {

   if (!Exists($enter_horse_window)) {
      $enter_horse_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Enter New Horse Information');


#
#  Horse ApHC Number
#
      $ehw_frame1 = $enter_horse_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame1->Label(-text        => "Horse ApHC Number",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $newhorseentry = $ehw_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$horsenum) -> pack(-side => 'left');
      $ehw_frame1->Label(-text        => "    Year Foaled",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 4,
                         -textvariable => \$yearfoaled) -> pack(-side => 'left');
      $ehw_frame1->Label(-text        => "    Sex",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  10,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame1->Optionmenu(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -textvariable => \$horsesex,
                         -options => ["Stallion", "Gelding", "Mare"]) -> pack(-side => 'left');
      $ehw_frame1->Label(-text        => "    Color",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  10,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$horsecolor) -> pack(-side => 'left');

      $ehw_frame11 = $enter_horse_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame11->Label(-text        => "Registration Type",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame11->Optionmenu(-background   => 'grey',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -textvariable => \$regtype,
                         -options => ["# - Regular",
                                      "T - Tentative",
                                      "N - Non-Characteristic",
                                      "CN - Certified Pedigree Option",
                                      "F - Foundation",
                                      "BT - Breeding Stock (Tentative)",
                                      "B# - Breeding Stock (Permanent)",
                                      "BN - Breeding Stock (Non-Characteristic)",
                                      "ID - Identification System",
                                      "PC - Pedigree Certificate"]) -> pack(-side => 'left');


#
#  Horse Name
#
      $ehw_frame2 = $enter_horse_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame2->Label(-text        => "Horse Name",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 25,
                         -textvariable => \$horsename) -> pack(-side => 'left');

#
#  Horse Sire and Dam
#
      $ehw_frame3 = $enter_horse_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame3->Label(-text        => "Sire and Dam",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame3->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 25,
                         -textvariable => \$horsesire) -> pack(-side => 'left');
      $ehw_frame3->Label(-anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  5,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame3->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 25,
                         -textvariable => \$horsedam) -> pack(-side => 'left');

#
#  Owner ApHC Number
#
      $ehw_frame4 = $enter_horse_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame4->Label(-text        => "Owner ApHC Number",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $on = $ehw_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$ownernum) -> pack(-side => 'left');

#
#  Owner Information
#
      $ehw_frame5 = $enter_horse_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame5->Label(-text        => "Owner Name",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame5->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 45,
                         -textvariable => \$ownername) -> pack(-side => 'left');

#
#  Owner Information
#
      $ehw_frame6 = $enter_horse_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame6->Label(-text        => "Address",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame6->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$owneraddress) -> pack(-side => 'left');

#
#  Owner Information
#
      $ehw_frame7 = $enter_horse_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame7->Label(-text        => "City/State",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame7->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$ownercity) -> pack(-side => 'left');
      $ehw_frame7->Label(-text        => "    Zip Code",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  10,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame7->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$ownerzip) -> pack(-side => 'left');

#
#  Buttons
#
      $ehw_frame4 = $enter_horse_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $ehw_frame4->Button(-text => "Ok", -command => \&save_horse_info )->pack(-side => "left", -padx => 30, -pady => 5);
      $ehw_frame4->Button(-text => "Cancel", -command => sub { $enter_horse_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 5);

      $on->bind("<Return>", \&lookup_owner_number);
      $on->bind("<FocusOut>", \&lookup_owner_number);

      $enter_horse_window->withdraw();
      $enter_horse_window->update();

      $x_pos = ($screen_width - $enter_horse_window->width()) / 2;
      $y_pos = ($screen_height - $enter_horse_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;
#      $enter_horse_window->geometry("+$x_pos+$y_pos");
   }
}


##################################################################################
##################################################################################
#
#  Create the toplevel window for adding an owner's information
#

sub add_owner_information_toplevel {

   if (!Exists($enter_owner_window)) {
      $enter_owner_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Enter New Owner Information');


#
#  Owner ApHC Number
#
      $ehw_frame1 = $enter_owner_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame1->Label(-text        => "Owner ApHC Number",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $newownerentry = $ehw_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$ownernum) -> pack(-side => 'left');
      $ehw_frame1->Label(-text        => "    Registration Status",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame1->Optionmenu(-background   => 'grey',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -textvariable => \$ownernumberstatus,
                         -options => ["Current", "Pending", "Unknown", "Not Member"]) -> pack(-side => 'left');

#
#  Owner Name
#
      $ehw_frame2 = $enter_owner_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame2->Label(-text        => "Owner Name",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 25,
                         -textvariable => \$ownername) -> pack(-side => 'left');

#
#  Owner Information
#
      $ehw_frame3 = $enter_owner_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame3->Label(-text        => "Address",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame3->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$owneraddress) -> pack(-side => 'left');

#
#  Owner Information
#
      $ehw_frame4 = $enter_owner_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame4->Label(-text        => "City/State/Country",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$ownercity) -> pack(-side => 'left');
      $ehw_frame4->Label(-text        => " Postal Code",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  10,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$ownerzip) -> pack(-side => 'left');

#
#  Owner Information
#
      $ehw_frame5 = $enter_owner_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame5->Label(-text        => "Home Phone",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame5->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$ownerhomephone) -> pack(-side => 'left');
      $ehw_frame5->Label(-text        => "    Work Phone",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame5->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$ownerworkphone) -> pack(-side => 'left');

#
#  Owner Information
#
      $ehw_frame6 = $enter_owner_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame6->Label(-text        => "Email Address",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame6->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$owneremail) -> pack(-side => 'left');

#
#  Buttons
#
      $ehw_frame7 = $enter_owner_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $ehw_frame7->Button(-text => "Ok", -command => \&save_owner_info )->pack(-side => "left", -padx => 30, -pady => 10);
      $ehw_frame7->Button(-text => "Cancel", -command => sub { $enter_owner_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

      $enter_owner_window->withdraw();
      $enter_owner_window->update();

      $x_pos = ($screen_width - $enter_owner_window->width()) / 2;
      $y_pos = ($screen_height - $enter_owner_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;
#      $enter_owner_window->geometry("+$x_pos+$y_pos");
   }
}


##################################################################################
##################################################################################
#
#  Create the toplevel window for adding a rider's information
#

sub add_rider_information_toplevel {

   if (!Exists($enter_rider_window)) {
      $enter_rider_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Enter New Rider Information');


#
#  Rider ApHC Number
#
      $erw_frame1 = $enter_rider_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $erw_frame1->Label(-text        => "Rider ApHC Number",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $newriderentry = $erw_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$ridernum) -> pack(-side => 'left');
      $erw_frame1->Label(-text        => "    Registration Status",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');
      $erw_frame1->Optionmenu(-background   => 'grey',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -textvariable => \$ridernumberstatus,
                         -options => ["Current", "Pending", "Unknown", "Not Member"]) -> pack(-side => 'left');

      $erw_frame1->Label(-text        => "    Sex",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');
      $erw_frame1->Optionmenu(-background   => 'grey',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -textvariable => \$ridersex,
                         -options => ["Female", "Male"]) -> pack(-side => 'left');

#
#  Registration Type
#
      $erw_frame11 = $enter_rider_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $erw_frame11->Label(-text        => "Registration Type",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $erw_frame11->Optionmenu(-background => 'grey',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -textvariable => \$ridertype,
                         -options => ["Open", "Non Pro", "Novice Non Pro", "Youth", "Novice Youth"]) -> pack(-side => 'left');

#
#  Rider Name
#
      $erw_frame2 = $enter_rider_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $erw_frame2->Label(-text        => "Rider Name (First)",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $erw_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 15,
                         -textvariable => \$riderfirstname) -> pack(-side => 'left');
      $erw_frame2->Label(-text        => " (Last) ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  10,
                         -justify     => 'left')->pack(-side => 'left');
      $erw_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 25,
                         -textvariable => \$riderlastname) -> pack(-side => 'left');

#
#  Rider Information
#
      $erw_frame3 = $enter_rider_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $erw_frame3->Label(-text        => "Address",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $erw_frame3->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$rideraddress) -> pack(-side => 'left');

#
#  Address Information
#
      $erw_frame4 = $enter_rider_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $erw_frame4->Label(-text        => "City",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $erw_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$ridercity) -> pack(-side => 'left');
      $erw_frame4->Label(-text        => "State",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  10,
                         -justify     => 'left')->pack(-side => 'left');
      $erw_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 2,
                         -textvariable => \$ridercity) -> pack(-side => 'left');
      $erw_frame4->Label(-text        => " Postal Code",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  10,
                         -justify     => 'left')->pack(-side => 'left');
      $erw_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$riderzip) -> pack(-side => 'left');

#
#  Phone Information
#
      $erw_frame5 = $enter_rider_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $erw_frame5->Label(-text        => "Home Phone",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $erw_frame5->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$riderhomephone) -> pack(-side => 'left');
      $erw_frame5->Label(-text        => "    Work Phone",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $erw_frame5->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$riderworkphone) -> pack(-side => 'left');

#
#  Email Information
#
      $erw_frame6 = $enter_rider_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $erw_frame6->Label(-text        => "Email Address",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $erw_frame6->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$rideremail) -> pack(-side => 'left');

#
#  Buttons
#
      $ehw_frame7 = $enter_rider_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $ehw_frame7->Button(-text => "Ok", -command => \&save_rider_info )->pack(-side => "left", -padx => 30, -pady => 10);
      $ehw_frame7->Button(-text => "Cancel", -command => sub { $enter_rider_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

      $enter_rider_window->withdraw();
      $enter_rider_window->update();

      $x_pos = ($screen_width - $enter_rider_window->width()) / 2;
      $y_pos = ($screen_height - $enter_rider_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;
#      $enter_rider_window->geometry("+$x_pos+$y_pos");
   }
}


##################################################################################
##################################################################################
#
#  Create the toplevel window for adding a a class to an existing entry
#

sub add_new_entry_toplevel {

   if (!Exists($add_class_window)) {
      $add_class_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Add A Class To An Existing Entry');

      $add_class_window->Label(-textvariable => \$showinfo,
                              -anchor       => 'center',
                              -background   => 'navy',
                              -foreground   => 'yellow',
                              -borderwidth  => '2',
                              -relief       => 'groove',
                              -justify      => 'center')->pack(-side => 'top', -fill => 'x');

      $acw_topframe = $add_class_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
#                               -expand => 1,
                               -anchor => 'n');
      $acw_topleft  = $acw_topframe->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'left',
                               -fill   => 'x',
#                               -expand => 1,
                               -anchor => 'n');
      $acw_topright = $acw_topframe->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'right',
                               -fill   => 'x',
#                               -expand => 1,
                               -anchor => 'n');
#
#  Back Number
#
      $acw_frame1 = $acw_topleft->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $acw_frame1->Label(-text        => "Back Number:",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  13,
                         -justify     => 'left')->pack(-side => 'left');
      $addbacknumentry = $acw_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 6,
                         -textvariable => \$backnumber) -> pack(-side => 'left');

#
#  Horse Information
#
      $acw_frame2 = $acw_topleft->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $acw_frame2->Label(-text        => "Horse: ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  13,
                         -justify     => 'left')->pack(-side => 'left');
      $acw_frame2->Label(-textvariable => \$horsename,
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  22,
                         -justify      => 'left')->pack(-side => 'left');

#
#  Rider Information
#
      $acw_frame3 = $acw_topleft->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $acw_frame3->Label(-text => "Exhibitor:",
                              -anchor => 'w',
                              -background => 'grey',
                              -foreground => 'navy',
                              -borderwidth => '0',
                              -width =>  13,
                              -justify => 'left')->pack(-side => 'left');
      $acw_frame3->Label(-textvariable => \$ridername,
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  30,
                         -justify      => 'left')->pack(-side => 'left');

#
#  Existing Class Numbers
#
      $acw_frame11 = $acw_topright->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $acw_class_lb    = $acw_frame11->Scrolled("Listbox", -scrollbars => 'oe',
                              -selectmode => 'none',
                              -height => 7,
                              -width => 40)->pack(-side => 'top');

#
#  Class Numbers
#
      $add_class_window->Label(-text        => "New Classes Entered",
                              -anchor      => 'center',
                              -background  => 'grey',
                              -foreground  => 'navy',
                              -borderwidth => '0',
                              -justify     => 'center')->pack(-side => 'top', -fill => 'x');

      $acw_frame = $add_class_window->Frame(-background  => 'grey',
                                         -borderwidth => 5,
                                         -relief      => 'flat')->
                                      pack(-side   => 'top',
                                           -fill   => 'x',
                                           -expand => 1,
                                           -anchor => 'n');
      $acw_frame->Label(-anchor       => 'w',
                               -background   => 'grey',
                               -foreground   => 'navy',
                               -borderwidth  => '0',
                               -width        =>  5,
                               -justify      => 'left')->pack(-side => 'left');

      for $ii (0 .. 9) {
         $classentered[$ii] = $acw_frame->Entry(-background => 'white',
                            -foreground   => 'black',
                            -takefocus    => 1,
                            -width        => 3,
                            -textvariable => \$add_rider_class[$ii]) -> pack(-side => 'left');
         $acw_frame->Label(-anchor       => 'w',
                            -background   => 'grey',
                            -foreground   => 'navy',
                            -borderwidth  => '0',
                            -width        =>  5,
                            -justify      => 'left')->pack(-side => 'left');
      }

#
#  Buttons
#
      $acw_frame8 = $add_class_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $acw_frame8->Button(-text => "Ok", -command => \&add_class_entry)->pack(-side => "left", -padx => 30, -pady => 10);
      $acw_frame8->Button(-text => "Cancel", -command => sub { $add_class_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

      $addbacknumentry->bind("<Return>", \&lookup_existing_back_number);
      $addbacknumentry->bind("<Tab>", \&lookup_existing_back_number);
      $addbacknumentry->bind("<Shift-Tab>", \&lookup_existing_back_number);

      $add_class_window->withdraw();
      $add_class_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $add_class_window->width()) / 2;
      $y_pos = ($screen_height - $add_class_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $add_class_window->geometry("+$x_pos+$y_pos");
   }
}


##################################################################################
##################################################################################
#
#  Create the toplevel window for deleting a class from an existing entry
#

sub delete_entry_toplevel {

   if (!Exists($scratch_class_window)) {
      $scratch_class_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Delete A Class From An Existing Entry');

      $scratch_class_window->Label(-textvariable => \$showinfo,
                              -anchor       => 'center',
                              -background   => 'navy',
                              -foreground   => 'yellow',
                              -borderwidth  => '2',
                              -relief       => 'groove',
                              -justify      => 'center')->pack(-side => 'top', -fill => 'x');

#
#  Back Number
#
      $scw_frame1 = $scratch_class_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $scw_frame1->Label(-text        => "Back Number",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'left')->pack(-side => 'left');
      $delbacknumentry = $scw_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 6,
                         -textvariable => \$backnumber) -> pack(-side => 'left');

#
#  Horse Information
#
      $scw_frame2 = $scratch_class_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $scw_frame2->Label(-text        => "Horse: ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'left')->pack(-side => 'left');
      $scw_frame2->Label(-textvariable => \$horsename,
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  35,
                         -justify      => 'left')->pack(-side => 'left');

#
#  Rider Information
#
      $scw_frame3 = $scratch_class_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $scw_frame3->Label(-text => "Exhibitor:", -anchor => 'w', -background => 'grey', -foreground => 'navy', -borderwidth => '0', -width =>  25, -justify => 'left')
                               ->pack(-side => 'left');
      $scw_frame3->Label(-textvariable => \$ridername,
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  35,
                         -justify      => 'left')->pack(-side => 'left');

#
#  Class Numbers
#

      $scw_frame4 = $scratch_class_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $scw_frame4->Label(-text   => "Click on a Class to Scratch",
                              -anchor      => 'center',
                              -background  => 'grey',
                              -foreground  => 'navy',
                              -borderwidth => '0',
                              -justify     => 'center')->pack(-side => 'top', -fill => 'x');

      $rid_class_lb    = $scw_frame4->Scrolled("Listbox", -scrollbars => 'oe',
                              -selectmode => 'multiple',
                              -width => 50)->pack(-side => 'top');


#
#  Buttons
#
      $scw_frame8 = $scratch_class_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $scw_frame8->Button(-text => "Ok", -command => \&scratch_class_entry)->pack(-side => "left", -padx => 30, -pady => 5);
      $scw_frame8->Button(-text => "Cancel", -command => sub { $scratch_class_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 5);

      $delbacknumentry->bind("<Return>", \&lookup_existing_back_number);
      $delbacknumentry->bind("<Tab>", \&lookup_existing_back_number);
      $delbacknumentry->bind("<Shift-Tab>", \&lookup_existing_back_number);

      $scratch_class_window->withdraw();
      $scratch_class_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $scratch_class_window->width()) / 2;
      $y_pos = ($screen_height - $scratch_class_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $scratch_class_window->geometry("+$x_pos+$y_pos");
   }
}


##################################################################################
##################################################################################
#
#  Display a list of riders for selection
#

sub rider_list_toplevel {

   if (!Exists($rider_list_window)) {
      $rider_list_window = MainWindow->new(-background  => 'grey',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Select Exhibitor');

      $rider_list_window->Label(-text => "Select The Rider/Exhibitor For This Horse",
                        -anchor      => 'center',
                        -background  => 'navy',
                        -foreground  => 'yellow',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $rl_names_frame      = $rider_list_window->Frame->pack(-side => 'top', -fill => 'x');
      $rl_names_buttons   = $rider_list_window->Frame(-background => 'black')->pack(-side => 'bottom', -fill => 'x');

#      $rl_names_frame->Label(-textvariable => \$year)->pack(-side => 'top', -fill => 'x');

      $rl_names_lb = $rl_names_frame->Scrolled("Listbox", -scrollbars => 'oe', -selectmode => 'single')->pack;

      $rl_names_buttons->Button(-text => "Select", -command => sub { rider_select() } )->pack(-side => "left", -padx => 30, -pady => 10);
      $rl_names_buttons->Button(-text => "Cancel", -command => sub { $rider_list_window->withdraw(); } )->pack(-side => "right", -padx => 30, -pady => 10);

      $rider_list_window->withdraw();
      $rider_list_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $rider_list_window->width()) / 2;
      $y_pos = ($screen_height - $rider_list_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $rider_list_window->geometry("+$x_pos+$y_pos");
   }

}


1;

__END__
sub class_list_toplevel {

   if (!Exists($class_list_window)) {
      $sl = 0;
      $show_index = 1;

      &open_national_class_file;

      @open_list   = grep(/^O/, @class_list);
      @nonpro_list = grep(/^N/, @class_list);
      @youth_list  = grep(/^Y/, @class_list);

      &open_local_class_file;
      @local_list  = grep(/^L/, @local_class_list);

      foreach $ii (@open_list) {
         ($num, $name) = split(/~/, $ii);
         $open{$name} = $num;
         push (@open, $name);
         $sl = length($name) if ($sl < length($name));
      }

      foreach $ii (@nonpro_list) {
         ($num, $name) = split(/~/, $ii);
         $nonpro{$name} = $num;
         push (@nonpro, $name);
         $sl = length($name) if ($sl < length($name));
      }

      foreach $ii (@youth_list) {
         ($num, $name) = split(/~/, $ii);
         $youth{$name} = $num;
         push (@youth, $name);
         $sl = length($name) if ($sl < length($name));
      }

      foreach $ii (@local_list) {
         ($num, $name) = split(/~/, $ii);
         $local{$name} = $num;
         push (@local, $name);
         $sl = length($name) if ($sl < length($name));
      }

      $cl_window = MainWindow->new(-background  => 'grey',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Select Classes');

      $cl_window->Label(-text        => "Select The Classes IN ORDER OF APPEARANCE\nTo unselect a class, click on it in the Selected Classes list",
                        -anchor      => 'center',
                        -background  => 'navy',
                        -font        => 'system 12',
                        -foreground  => 'yellow',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $cl_window_scrollbar = $cl_window->Scrollbar();
      $cl_classes_frame  = $cl_window->Frame->pack(-side => 'top', -fill => 'x');
      $cl_window_buttons = $cl_window->Frame(
                              -background => 'black')->pack(-side => 'bottom', -fill => 'x');

      $ft_classes_frame  = $cl_window->Frame->pack(-side => 'top', -fill => 'x');
      $st_classes_frame  = $cl_window->Frame->pack(-side => 'top', -fill => 'x');
      $tt_classes_frame  = $cl_window->Frame->pack(-side => 'top', -fill => 'x');

      $cl_open_frame   = $ft_classes_frame->Frame->pack(-side => 'left', -fill => 'y');
      $cl_nonpro_frame = $ft_classes_frame->Frame->pack(-side => 'left', -fill => 'y');
      $cl_youth_frame  = $st_classes_frame->Frame->pack(-side => 'left', -fill => 'y');
      $cl_local_frame  = $st_classes_frame->Frame->pack(-side => 'left', -fill => 'y');
      $cl_select_frame = $tt_classes_frame->Frame->pack(-side => 'top',  -fill => 'y');

      $cl_open_frame->Label(-text => "Open\nClasses")->pack(-side => 'top', -fill => 'x');
      $cl_nonpro_frame->Label(-text => "Non-Pro\nClasses")->pack(-side => 'top', -fill => 'x');
      $cl_youth_frame->Label(-text => "Youth\nClasses")->pack(-side => 'top', -fill => 'x');
      $cl_local_frame->Label(-text => "Local\nClasses")->pack(-side => 'top', -fill => 'x');
      $cl_select_frame->Label(-text => "Selected\nClasses")->pack(-side => 'top', -fill => 'x');

      $cl_open_lb   = $cl_open_frame->Scrolled("Listbox",
                          -font        => 'system 12',
                          -height     => 8,
                          -width      => $sl,
                          -scrollbars => 'e',
                          -selectmode => 'single')->pack;
      $cl_nonpro_lb = $cl_nonpro_frame->Scrolled("Listbox",
                          -font        => 'system 12',
                          -height     => 8,
                          -width      => $sl,
                          -scrollbars => 'e',
                          -selectmode => 'single')->pack;
      $cl_youth_lb  = $cl_youth_frame->Scrolled("Listbox",
                          -font        => 'system 12',
                          -height     => 8,
                          -width      => $sl,
                          -scrollbars => 'e',
                          -selectmode => 'single')->pack;
      $cl_local_lb  = $cl_local_frame->Scrolled("Listbox",
                          -font        => 'system 12',
                          -height     => 8,
                          -width      => $sl,
                          -scrollbars => 'e',
                          -selectmode => 'single')->pack;
      $cl_select_lb = $cl_select_frame->Scrolled("Listbox",
                          -font        => 'system 12',
                          -height     => 8,
                          -width      => $sl+6,
                          -scrollbars => 'e',
                          -selectmode => 'single')->pack;

      $cl_open_lb->insert('end', @open);
      $cl_nonpro_lb->insert('end', @nonpro);
      $cl_youth_lb->insert('end', @youth);
      $cl_local_lb->insert('end', @local);

      $cl_open_lb->bind("<Button-1>", \&open_class_select);
      $cl_nonpro_lb->bind("<Button-1>", \&nonpro_class_select);
      $cl_youth_lb->bind("<Button-1>", \&youth_class_select);
      $cl_local_lb->bind("<Button-1>", \&local_class_select);
      $cl_select_lb->bind("<Button-1>", \&select_class_select);

      $cl_window_buttons->Button(-text => "Ok", -font => 'system 12', -command => sub { $cl_window->withdraw })->pack(-side => "left", -padx => 30, -pady => 10);
      $cl_window_buttons->Button(-text => "Cancel", -font => 'system 12', -command => sub { $cl_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

      $cl_window->withdraw();
      $cl_window->update();

#      $cl_window->geometry("+$main_x_pos+0");
   }

}




sub open_show_toplevel {

   if (!Exists($open_show_window)) {
      $open_show_window = MainWindow->new(-background  => 'grey',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Open Existing Show');

      $open_show_window->Label(-text => "Select The Show To Be Used",
                        -anchor      => 'center',
                        -background  => 'navy',
                        -foreground  => 'yellow',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $rl_shows_frame      = $open_show_window->Frame->pack(-side => 'top', -fill => 'x');
      $rl_window_buttons   = $open_show_window->Frame(-background => 'black')->pack(-side => 'bottom', -fill => 'x');

#      $rl_shows_frame->Label(-textvariable => \$year)->pack(-side => 'top', -fill => 'x');

      $rl_shows_lb = $rl_shows_frame->Scrolled("Listbox", -scrollbars => 'oe', -selectmode => 'single')->pack;

      $rl_window_buttons->Button(-text => "Select", -command => sub { show_select() } )->pack(-side => "left", -padx => 30, -pady => 10);
      $rl_window_buttons->Button(-text => "Exit", -command => sub { exit; } )->pack(-side => "right", -padx => 30, -pady => 10);

      $open_show_window->withdraw();
      $open_show_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $open_show_window->width()) / 2;
      $y_pos = ($screen_height - $open_show_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $open_show_window->geometry("+$x_pos+$y_pos");
   }

}

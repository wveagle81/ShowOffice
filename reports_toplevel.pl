##################################################################################
##################################################################################
#
#       Create The Toplevel windows
#

sub create_toplevel {
   $program = "reports";

   &create_message_dialog;
#   &display_message("Initializing Show Office Windows - Please Be Patient!", 0, "i");

   &report_toplevel;
   &open_show_toplevel;
   &report_window_toplevel;
   &choose_class_toplevel;
   &back_number_toplevel;
   &rider_list_toplevel;
   &entry_count_toplevel;
   &high_point_list_toplevel;
   &national_finished_toplevel;

   $msgdialog->withdraw();
}


##################################################################################
##################################################################################
#
#  Create the toplevel window for doing reports
#

sub report_toplevel {

   if (!Exists($report_main_window)) {
      $report_main_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Do Reports');

      $report_main_window->Label(-textvariable => \$showinfo,
                              -anchor       => 'center',
                              -background   => 'navy',
                              -foreground   => 'yellow',
                              -borderwidth  => '2',
                              -relief       => 'groove',
                              -justify      => 'center')->pack(-side => 'top', -fill => 'x');

      $rmw_main_frame1 = $report_main_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $rmw_main_frame2 = $report_main_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

#
#  Member/Horse Reports
#
      $rmw_frame1 = $rmw_main_frame1->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'raised')->
                          pack(-side   => 'left',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $rmw_lframe1 = $rmw_frame1->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $rmw_lframe1->Label(-text        => "Member and Horse Reports",
                         -anchor      => 'w',
                         -background  => 'black',
                         -foreground  => 'yellow',
                         -borderwidth => '0',
                         -justify     => 'center')->pack(-side => 'top');

      $rmw_bframe1 = $rmw_frame1->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $rmw_bframe1->Button(-text => "Members By Lastname", -width => 20,
                           -command => sub { &members_by_lastname(); })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe1->Button(-text => "Members By Reg Num", -width => 20,
                           -command => sub { &members_by_regnum(); })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe1->Button(-text => "Horses By Name", -width => 20,
                           -command => sub { &horses_by_name(); })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe1->Button(-text => "Horses By Reg Num", -width => 20,
                           -command => sub { &horses_by_regnum(); })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe1->Button(-text => "Horses By Sex / Name", -width => 20,
                           -command => sub { &horses_by_sex(); })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe1->Button(-text => "Class Entries", -width => 20,
                           -command => sub { $rflag = "IE"; &choose_back_number; })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe1->Button(-text => "National Point Results", -width => 20,
                           -command => sub { $rflag = "IR"; &choose_back_number; })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe1->Button(-text => "Local Point Results", -width => 20,
                           -command => sub { $rflag = "IL"; &choose_back_number; })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe1->Button(-text => "Nat'l/Local Point Results", -width => 20,
                           -command => sub { $rflag = "NL"; &choose_back_number; })
                           ->pack(-side => "top", -padx => 3, -pady => 1);

#
#  Entry/Class Reports
#
      $rmw_frame2 = $rmw_main_frame1->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'raised')->
                          pack(-side   => 'left',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $rmw_lframe2 = $rmw_frame2->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $rmw_lframe2->Label(-text        => "Class and Entry Reports",
                         -anchor      => 'w',
                         -background  => 'black',
                         -foreground  => 'yellow',
                         -borderwidth => '0',
                         -justify     => 'center')->pack(-side => 'top');

      $rmw_bframe2 = $rmw_frame2->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $rmw_bframe2->Button(-text => "Class List", -width => 20,
                           -command => sub { &class_list(); })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe2->Button(-text => "Back Number List", -width => 20,
                           -command => sub { &back_number(); })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe2->Button(-text => "Class Entry Count", -width => 20,
                           -command => sub { &class_list_with_entries(); })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe2->Button(-text => "Class Entries", -width => 20,
                           -command => sub { &one_class_list("single"); })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe2->Button(-text => "Class Entries Random", -width => 20,
                           -command => sub { &one_class_list("random"); })
                           ->pack(-side => "top", -padx => 3, -pady => 1);

#
#  Show Results
#
      $rmw_frame3 = $rmw_main_frame1->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'raised')->
                          pack(-side   => 'left',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $rmw_lframe3 = $rmw_frame3->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $rmw_lframe3->Label(-text        => "Show Results",
                         -anchor      => 'w',
                         -background  => 'black',
                         -foreground  => 'yellow',
                         -borderwidth => '0',
                         -justify     => 'center')->pack(-side => 'top');

      $rmw_bframe3 = $rmw_frame3->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $rmw_bframe3->Button(-text => "Class Results", -width => 20,
                           -command => sub { &one_class_list("placing"); })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe3->Button(-text => "Class Winner", -width => 20,
                           -command => sub { &one_class_list("winner"); })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe3->Button(-text => "Billing Form", -width => 20,
                           -command => sub { $rflag = "IB"; &choose_back_number; })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe3->Button(-text => "Billing Receipt", -width => 20,
                           -command => sub { $rflag = "BR"; &choose_back_number; })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe3->Button(-text => "High Point Results", -width => 20,
                           -command => sub { &high_point_list; })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe3->Button(-text => "Local Point Report", -width => 20,
                           -command => sub { &local_point_report; })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe3->Button(-text => "Local Point Report 2", -width => 20,
                           -command => sub { &local2_point_report; })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe3->Button(-text => "National Point Report", -width => 20,
                           -command => sub { &national_point_report; })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe3->Button(-text => "Final Entry Count", -width => 20,
                           -command => sub { &final_entry_count(); })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe3->Button(-text => "National Back # Report", -width => 20,
                           -command => sub { &national_back_number(); })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe3->Button(-text => "National Results", -width => 20,
                           -command => sub { &national_results; })
                           ->pack(-side => "top", -padx => 3, -pady => 1);
      $rmw_bframe3->Button(-text => "National Results Master List", -width => 20,
                           -command => sub { &national_master; })
                           ->pack(-side => "top", -padx => 3, -pady => 1);

#
#  Mailing Labels
#
#      $rmw_frame4 = $rmw_main_frame1->
#                       Frame(-background  => 'black',
#                             -borderwidth => 5,
#                             -relief      => 'raised')->
#                          pack(-side   => 'left',
#                               -fill   => 'x',
#                               -expand => 1,
#                               -anchor => 'n');
#      $rmw_lframe4 = $rmw_frame4->
#                       Frame(-background  => 'black',
#                             -borderwidth => 5,
#                             -relief      => 'flat')->
#                          pack(-side   => 'top',
#                               -fill   => 'x',
#                               -expand => 1,
#                               -anchor => 'n');
#      $rmw_lframe4->Label(-text        => "Mailing Labels",
#                         -anchor      => 'w',
#                         -background  => 'black',
#                         -foreground  => 'yellow',
#                         -borderwidth => '0',
#                         -justify     => 'center')->pack(-side => 'top');
#
#      $rmw_bframe4 = $rmw_frame4->
#                       Frame(-background  => 'black',
#                             -borderwidth => 5,
#                             -relief      => 'flat')->
#                          pack(-side   => 'top',
#                               -fill   => 'x',
#                               -expand => 1,
#                               -anchor => 'n');
#      $rmw_bframe4->Button(-text => "By Zip Code", -width => 20, -command => sub { exit; })
#                           ->pack(-side => "top", -padx => 3, -pady => 1);
#      $rmw_bframe4->Button(-text => "By Zip State", -width => 20, -command => sub { exit; })
#                           ->pack(-side => "top", -padx => 3, -pady => 1);

#
#  Buttons
#
      $rmw_frame11 = $rmw_main_frame2->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'bottom',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $rmw_frame11->Button(-text => "Exit", -command => sub { exit; })->pack(-side => "left", -padx => 30, -pady => 5);


      $report_main_window->withdraw();
      $report_main_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $report_main_window->width()) / 2;
      $y_pos = ($screen_height - $report_main_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $report_main_window->geometry("+$x_pos+$y_pos");
   }
}


##################################################################################
##################################################################################
#
#  Choose the class for reports
#

sub choose_class_toplevel {

   if (!Exists($class_list_window)) {
      $class_list_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Choose A Class For Class Entry List');

      $class_list_window->Label(-textvariable => \$showinfo,
                              -anchor       => 'center',
                              -background   => 'navy',
                              -foreground   => 'yellow',
                              -borderwidth  => '2',
                              -relief       => 'groove',
                              -justify      => 'center')->pack(-side => 'top', -fill => 'x');

#
#  Class Number
#
      $cc_frame1 = $class_list_window->
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

      $cc_frame2 = $class_list_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $class_lb   = $cc_frame2->Scrolled("Listbox", -scrollbars => 'oe',
                              -selectmode => 'extended',
                              -height     => 15,
                              -width      => 50)->pack(-side => 'top');


#
#  Buttons
#
      $cc_frame3 = $class_list_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $cc_frame3->Button(-text => "Ok", -command => \&report_one_class)->pack(-side => "left", -padx => 30, -pady => 5);
      $cc_frame3->Button(-text => "Cancel", -command => sub { $class_list_window->withdraw(); })->pack(-side => "right", -padx => 30, -pady => 5);

      $class_list_window->Label(-textvariable => \$current_entries_label,
                              -anchor       => 'w',
                              -background   => 'black',
                              -foreground   => 'white',
                              -borderwidth  => '0',
                              -justify      => 'left')->pack(-side => 'bottom', -fill => 'x');

      $class_list_window->withdraw();
      $class_list_window->update();

      $classentry->bind("<Return>", \&report_one_class);
      $classentry->bind("<Tab>", \&report_one_class);
      $classentry->bind("<Shift-Tab>", \&report_one_class);
      $class_lb->bind("<Double-Button-1>", \&report_one_class);

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $class_list_window->width()) / 2;
      $y_pos = ($screen_height - $class_list_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $class_list_window->geometry("+$x_pos+$y_pos");
   }
}


##################################################################################
##################################################################################
#
#  Select Back Number For Report
#

sub back_number_toplevel {

   if (!Exists($back_number_window)) {
      $back_number_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Select Back Number');

      $back_number_window->Label(-textvariable => \$showinfo,
                              -anchor       => 'center',
                              -background   => 'navy',
                              -foreground   => 'yellow',
                              -borderwidth  => '2',
                              -relief       => 'groove',
                              -justify      => 'center')->pack(-side => 'top', -fill => 'x');

#
#  Back Number
#
      $bnw_frame1 = $back_number_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $bnw_frame1->Label(-text        => "Back Number",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'left')->pack(-side => 'left');
      $backnumentry = $bnw_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 6,
                         -textvariable => \$backnumber) -> pack(-side => 'left');

#
#  Horse ApHC Membership Number
#
      $bnw_frame2 = $back_number_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $bnw_frame2->Label(-text        => "Horse ApHC Number",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'left')->pack(-side => 'left');
      $hn = $bnw_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 15,
                         -textvariable => \$horsenum) -> pack(-side => 'left');
      $bnw_frame2->Label(-anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  5,
                         -justify      => 'left')->pack(-side => 'left');
      $bnw_frame2->Label(-textvariable => \$horsename,
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  25,
                         -justify      => 'left')->pack(-side => 'left');

#
#  Rider ApHC Membership Number
#
      $bnw_frame3 = $back_number_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $bnw_frame3->Label(-text        => "Exhibitor ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'left')->pack(-side => 'left');
      $rn = $bnw_frame3->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 15,
                         -textvariable => \$ridernum) -> pack(-side => 'left');
      $bnw_frame3->Label(-anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  5,
                         -justify      => 'left')->pack(-side => 'left');
      $bnw_frame3->Label(-textvariable => \$ridername,
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  25,
                         -justify      => 'left')->pack(-side => 'left');

#
#  Buttons
#
      $bnw_frame8 = $back_number_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $bnw_frame8->Button(-text => "Ok", -command => sub { if ($rflag eq "IR") {
                                                              print "Calling Entry_Results\n";
                                                              &entry_results();
                                                           } elsif ($rflag eq "IL") {
                                                              print "Calling Entry_Local_Results\n";
                                                              &entry_local_results();
                                                           } elsif ($rflag eq "NL") {
                                                              print "Calling Entry_Natl_Local_Results\n";
                                                              &entry_natl_local_results();
                                                           } elsif ($rflag eq "IB") {
                                                              print "Filling out billing form\n";
                                                              &billing_form();
                                                           } elsif ($rflag eq "PP") {
                                                              print "Filling out billing form\n";
                                                              &billing_form_prepaid();
                                                           } elsif ($rflag eq "BR") {
                                                              print "Filling out billing receipt\n";
                                                              &billing_receipt();
                                                           } else {
                                                              print "Calling Entry_Classes\n";
                                                              &entry_classes();
                                                           } })->pack(-side => "left", -padx => 30, -pady => 5);
      $bnw_frame8->Button(-text => "Exit", -command => sub { $back_number_window->withdraw(); })->pack(-side => "right", -padx => 30, -pady => 5);

      $backnumentry->bind("<Return>", \&lookup_existing_back_number);
      $backnumentry->bind("<Tab>", \&lookup_existing_back_number);
      $backnumentry->bind("<Shift-Tab>", \&lookup_existing_back_number);
      $hn->bind("<Return>", \&lookup_horse_number);
      $hn->bind("<Tab>", \&lookup_horse_number);
      $hn->bind("<Shift-Tab>", \&lookup_horse_number);
      $rn->bind("<Return>", \&lookup_rider_number);
      $rn->bind("<Tab>", \&lookup_rider_number);
      $rn->bind("<Shift-Tab>", \&lookup_rider_number);

      $back_number_window->withdraw();
      $back_number_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $back_number_window->width()) / 2;
      $y_pos = ($screen_height - $back_number_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $back_number_window->geometry("+$x_pos+0");
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

      $rl_names_lb = $rl_names_frame->Scrolled("Listbox", -scrollbars => 'oe', -selectmode => 'single')->pack;

      $rl_names_buttons->Button(-text => "Select", -command => sub { rider_select() } )->pack(-side => "left", -padx => 30, -pady => 10);
      $rl_names_buttons->Button(-text => "Cancel", -command => sub { $rider_list_window->withdraw(); } )->pack(-side => "right", -padx => 30, -pady => 10);

      $rl_names_lb->bind("<Double-Button-1>", \&rider_select);

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


##################################################################################
##################################################################################
#
#  Display a list of high point divisions for selection
#

sub high_point_list_toplevel {

   if (!Exists($hp_list_window)) {
      $hp_list_window = MainWindow->new(-background  => 'grey',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Select High Point');

      $hp_list_window->Label(-text => "Select The High Point Division",
                        -anchor      => 'center',
                        -background  => 'navy',
                        -foreground  => 'yellow',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $hp_names_frame     = $hp_list_window->Frame->pack(-side => 'top', -fill => 'x');
      $hp_names_buttons   = $hp_list_window->Frame(-background => 'black')->pack(-side => 'bottom', -fill => 'x');

      $hp_names_lb = $hp_names_frame->Scrolled("Listbox", -scrollbars => 'oe', -selectmode => 'single')->pack;

      $hp_names_buttons->Button(-text => "Select", -command => sub { hp_select() } )->pack(-side => "left", -padx => 30, -pady => 10);
      $hp_names_buttons->Button(-text => "Cancel", -command => sub { $hp_list_window->withdraw(); } )->pack(-side => "right", -padx => 30, -pady => 10);

      $hp_names_lb->bind("<Double-Button-1>", \&hp_select);

      $hp_list_window->withdraw();
      $hp_list_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $hp_list_window->width()) / 2;
      $y_pos = ($screen_height - $hp_list_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $hp_list_window->geometry("+$x_pos+$y_pos");
   }

}


##################################################################################
##################################################################################
#
#  Generic Window For Report Results
#

sub report_window_toplevel {

   if (!Exists($report_results_window)) {
      $report_results_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Report Results');

      $report_results_window->Label(-textvariable => \$showinfo,
                              -anchor       => 'center',
                              -background   => 'navy',
                              -foreground   => 'yellow',
                              -borderwidth  => '2',
                              -relief       => 'groove',
                              -justify      => 'center')->pack(-side => 'top', -fill => 'x');
      $report_results_window->Label(-textvariable => \$reporttype,
                              -anchor       => 'center',
                              -background   => 'navy',
                              -foreground   => 'yellow',
                              -borderwidth  => '2',
                              -relief       => 'groove',
                              -justify      => 'center')->pack(-side => 'top', -fill => 'x');

#
#  Text Window For Report
#
      $rr_frame1 = $report_results_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $textwindow = $rr_frame1->Scrolled("Text")
                              ->pack(-side => 'left', -fill => 'both', -expand => 1);

#
#  Buttons
#
      $rr_frame2 = $report_results_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $rr_frame2->Button(-text => "Ok", -command => sub { $textwindow->delete('1.0', 'end');
                                                          $report_results_window->withdraw();
                                                          unlink("reportfile$$"); })->pack(-side => "left", -padx => 30, -pady => 5);
      $rr_frame2->Label(-text => "Number of Copies:  ",
                        -foreground => "white",
                        -background => "black")->pack(-side => "left", -padx => 80, -pady => 5);
      $rr_frame2->Entry(-textvariable => \$number_of_copies,
                        -foreground => "black",
                        -background => 'white',
                        -width      => 5)->pack(-side => "left");
      $rr_frame2->Button(-text => "Print", -command => sub { &print_report(); } )->pack(-side => "right", -padx => 30, -pady => 5);

      $report_results_window->withdraw();
      $report_results_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $report_results_window->width()) / 2;
      $y_pos = ($screen_height - $report_results_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $report_results_window->geometry("+$x_pos+0");
   }
}


#################################################################################
##################################################################################
#
#  Create the toplevel window for displaying counts
#

sub entry_count_toplevel {

   if (!Exists($entry_count_window)) {
      $entry_count_window = MainWindow->new(-background  => 'grey',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Show Entry Counts');

      $entry_count_window->Label(-text => "\n           Show Entry Counts           \n",
                        -anchor      => 'center',
                        -background  => 'navy',
                        -foreground  => 'yellow',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $entry_count_window->Label(-textvariable => \$print_entry_count,
                        -anchor      => 'center',
                        -background  => 'navy',
                        -foreground  => 'white',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $nf_shows_frame      = $entry_count_window->Frame->pack(-side => 'top', -fill => 'x');
      $nf_window_buttons   = $entry_count_window->Frame(-background => 'black')->pack(-side => 'bottom', -fill => 'x');

      $nf_window_buttons->Button(-text => "Ok", -command => sub { $entry_count_window->withdraw(); } )->pack(-side => "bottom",);

      $entry_count_window->withdraw();
      $entry_count_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $entry_count_window->width()) / 2;
      $y_pos = ($screen_height - $entry_count_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $entry_count_window->geometry("+$x_pos+$y_pos");
   }
}


#################################################################################
##################################################################################
#
#  Create the toplevel window for when finished with National results
#

sub national_finished_toplevel {

   if (!Exists($national_finished_window)) {
      $national_finished_window = MainWindow->new(-background  => 'grey',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Finished With National Results');

      $national_finished_window->Label(-text => "National Results Completed\n\nResults Files Written To\n'ShowResults' Directory",
                        -anchor      => 'center',
                        -background  => 'navy',
                        -foreground  => 'yellow',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $nf_shows_frame      = $national_finished_window->Frame->pack(-side => 'top', -fill => 'x');
      $nf_window_buttons   = $national_finished_window->Frame(-background => 'black')->pack(-side => 'bottom', -fill => 'x');

      $nf_window_buttons->Button(-text => "Ok", -command => sub { $national_finished_window->withdraw(); } )->pack(-side => "bottom");

      $national_finished_window->withdraw();
      $national_finished_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $national_finished_window->width()) / 2;
      $y_pos = ($screen_height - $national_finished_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $national_finished_window->geometry("+$x_pos+$y_pos");
   }
}

1;

__END__

#################################################################################
##################################################################################
#
#  Create the toplevel window for opening existing shows
#

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

      $os_shows_frame      = $open_show_window->Frame->pack(-side => 'top', -fill => 'x');
      $os_window_buttons   = $open_show_window->Frame(-background => 'black')->pack(-side => 'bottom', -fill => 'x');

#      $os_shows_frame->Label(-textvariable => \$year)->pack(-side => 'top', -fill => 'x');

      $os_shows_lb = $os_shows_frame->Scrolled("Listbox", -scrollbars => 'oe', -selectmode => 'single')->pack;

      $os_window_buttons->Button(-text => "Select", -command => sub { report_show_select() } )->pack(-side => "left", -padx => 30, -pady => 10);
      $os_window_buttons->Button(-text => "Exit", -command => sub { exit; } )->pack(-side => "right", -padx => 30, -pady => 10);

      $open_show_window->withdraw();
      $open_show_window->update();

      $os_shows_lb->bind("<Double-Button-1>", \&report_show_select);

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $open_show_window->width()) / 2;
      $y_pos = ($screen_height - $open_show_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $open_show_window->geometry("+$x_pos+$y_pos");
   }
}

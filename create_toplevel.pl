##################################################################################
##################################################################################
#
#       Create The Toplevel windows
#

sub create_toplevel {

   &create_message_dialog;

   &create_new_show_toplevel;
   &class_list_toplevel;
   &open_show_toplevel;
   &run_show_toplevel;
   &add_horse_information_toplevel;
   &add_owner_information_toplevel;
   &add_rider_information_toplevel;
   &add_new_entry_toplevel;
   &delete_entry_toplevel;
   &high_point_toplevel;

   $msgdialog->withdraw();
}


##################################################################################
##################################################################################
#
#       Create The Toplevel windows
#

sub create_message_dialog {
   $msgdialog = MainWindow->new(-background => 'black', -borderwidth => 2, -relief => 'raised',
                              -title => 'Initializing Windows');
   $msgdl = $msgdialog->Label(-textvariable => \$msgdialogtext, -anchor => 'w', -borderwidth => '0',
                     -justify => 'center', -font => 'system 12')
                     ->pack(-side => 'top', -fill => 'both', -expand => 1);
   $msgdialog->withdraw();
}


##################################################################################
##################################################################################
#
#  Create the toplevel window for creating a new show
#

sub create_new_show_toplevel {

   if (!Exists($new_show_window)) {
      $create_show_label = "Now Using Show Numbers: ";

      $new_show_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Create A New Show');
#
#  Show Name
#
      $nsw_frame1 = $new_show_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $nsw_frame1->Label(-text        => "Show Name   ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $shownameentry = $nsw_frame1->Entry(-background   => 'white',
                         -font         => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 50,
                         -textvariable => \$showname) -> pack(-side => 'left');

#
#  Show Date
#
      $nsw_frame2 = $new_show_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $nsw_frame2->Label(-text        => "Show Dates  ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $sd1 = $nsw_frame2->Entry(-background   => 'white',
                         -font         => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$showdate1) -> pack(-side => 'left');
      $nsw_frame2->Label(-text        => "  Format: mm/dd/yyyy",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 20,
                         -justify     => 'left')->pack(-side => 'left', -fill => 'x');
      $sd2 = $nsw_frame2->Entry(-background   => 'white',
                         -font         => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$showdate2) -> pack(-side => 'left');
      $nsw_frame2->Label(-text        => "  Format: mm/dd/yyyy",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left', -fill => 'x');

#
#  Show Number
#
      $nsw_frame3 = $new_show_window->Frame(-background  => 'grey', -borderwidth => 5, -relief => 'flat')-> pack(-side => 'top', -fill => 'x', -expand => 1, -anchor => 'n');
      $nsw_frame3->Label(-text => "Show Numbers", -font => 'system 12', -anchor => 'w', -background  => 'grey', -foreground  => 'navy', -borderwidth => '0', -width =>  15, -justify => 'left')->pack(-side => 'left');
      $nsw_frame3->Entry(-background  => 'white',
                         -font        => 'system 12',
                         -foreground  => 'black',
                         -takefocus   => 1,
                         -width       => 10,
                         -textvariable => \$shownumber[0]) -> pack(-side => 'left');
      $nsw_frame3->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 2,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame3->Entry(-background  => 'white',
                         -font        => 'system 12',
                         -foreground  => 'black',
                         -takefocus   => 1,
                         -width       => 10,
                         -textvariable => \$shownumber[1]) -> pack(-side => 'left');
      $nsw_frame3->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 7,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame3->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$shownumber[4]) -> pack(-side => 'left');
      $nsw_frame3->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 2,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame3->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$shownumber[5]) -> pack(-side => 'left');

      $nsw_frame4 = $new_show_window->Frame(-background  => 'grey', -borderwidth => 5, -relief => 'flat')-> pack(-side => 'top', -fill => 'x', -expand => 1, -anchor => 'n');
      $nsw_frame4->Label(-font => 'system 12', -anchor => 'w', -background  => 'grey', -foreground  => 'navy', -borderwidth => '0', -width =>  15, -justify => 'left')->pack(-side => 'left');
      $nsw_frame4->Entry(-background  => 'white',
                         -font        => 'system 12',
                         -foreground  => 'black',
                         -takefocus   => 1,
                         -width       => 10,
                         -textvariable => \$shownumber[2]) -> pack(-side => 'left');
      $nsw_frame4->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 2,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame4->Entry(-background  => 'white',
                         -font        => 'system 12',
                         -foreground  => 'black',
                         -takefocus   => 1,
                         -width       => 10,
                         -textvariable => \$shownumber[3]) -> pack(-side => 'left');
      $nsw_frame4->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 7,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame4->Entry(-background  => 'white',
                         -font        => 'system 12',
                         -foreground  => 'black',
                         -takefocus   => 1,
                         -width       => 10,
                         -textvariable => \$shownumber[6]) -> pack(-side => 'left');
      $nsw_frame4->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 2,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame4->Entry(-background  => 'white',
                         -font        => 'system 12',
                         -foreground  => 'black',
                         -takefocus   => 1,
                         -width       => 10,
                         -textvariable => \$shownumber[7]) -> pack(-side => 'left');

#
#  Judge Number
#
      $nsw_frame5 = $new_show_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $nsw_frame5->Label(-text        => "Judge Numbers",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $jnum[0] = $nsw_frame5->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$judgenumber[0]) -> pack(-side => 'left');
      $nsw_frame5->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 2,
                         -justify     => 'left')->pack(-side => 'left');
      $jnum[1] = $nsw_frame5->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$judgenumber[1]) -> pack(-side => 'left');
      $nsw_frame5->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 7,
                         -justify     => 'left')->pack(-side => 'left');
      $jnum[4] = $nsw_frame5->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$judgenumber[4]) -> pack(-side => 'left');
      $nsw_frame5->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 2,
                         -justify     => 'left')->pack(-side => 'left');
      $jnum[5] = $nsw_frame5->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$judgenumber[5]) -> pack(-side => 'left');

#
#  Judge Name
#
      $nsw_frame6 = $new_show_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $nsw_frame6->Label(-text        => "Judge Names",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame6->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$judgename[0]) -> pack(-side => 'left');
      $nsw_frame6->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 2,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame6->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$judgename[1]) -> pack(-side => 'left');
      $nsw_frame6->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 7,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame6->Entry(-background  => 'white',
                         -font        => 'system 12',
                         -foreground  => 'black',
                         -takefocus   => 1,
                         -width       => 10,
                         -textvariable => \$judgename[4]) -> pack(-side => 'left');
      $nsw_frame6->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 2,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame6->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$judgename[5]) -> pack(-side => 'left');


#
#  Judge Number
#
      $nsw_frame7 = $new_show_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $nsw_frame7->Label(-text        => "Judge Numbers",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $jnum[2] = $nsw_frame7->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$judgenumber[2]) -> pack(-side => 'left');
      $nsw_frame7->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 2,
                         -justify     => 'left')->pack(-side => 'left');
      $jnum[3] = $nsw_frame7->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$judgenumber[3]) -> pack(-side => 'left');
      $nsw_frame7->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 7,
                         -justify     => 'left')->pack(-side => 'left');
      $jnum[6] = $nsw_frame7->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$judgenumber[6]) -> pack(-side => 'left');
      $nsw_frame7->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 2,
                         -justify     => 'left')->pack(-side => 'left');
      $jnum[7] = $nsw_frame7->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$judgenumber[7]) -> pack(-side => 'left');

#
#  Judge Name
#
      $nsw_frame8 = $new_show_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $nsw_frame8->Label(-text        => "Judge Names",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame8->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$judgename[2]) -> pack(-side => 'left');
      $nsw_frame8->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 2,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame8->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$judgename[3]) -> pack(-side => 'left');
      $nsw_frame8->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 7,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame8->Entry(-background  => 'white',
                         -font        => 'system 12',
                         -foreground  => 'black',
                         -takefocus   => 1,
                         -width       => 10,
                         -textvariable => \$judgename[6]) -> pack(-side => 'left');
      $nsw_frame8->Label(-background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 2,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame8->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$judgename[7]) -> pack(-side => 'left');

#
#  Max Placings Per Class
#
      $nsw_frame9 = $new_show_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $nsw_frame9->Label(-text        => "Max Places/Class",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame9->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$maxplace) -> pack(-side => 'left');

#
#  Select Classes For Show
#
      $nsw_frame10 = $new_show_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $nsw_frame10->Button(-text        => "Select Classes For Show",
                          -anchor      => 'w',
                          -background  => 'grey',
                          -font        => 'system 12',
                          -foreground  => 'navy',
                          -borderwidth => '2',
                          -command     => sub { $cl_window->deiconify();  $cl_window->raise(); })->pack(-side => 'left');

      $nsw_frame10->Button(-text        => "Set Up High Point Awards",
                          -anchor      => 'w',
                          -background  => 'grey',
                          -font        => 'system 12',
                          -foreground  => 'navy',
                          -borderwidth => '2',
                          -command     => sub { $hp_window->deiconify();  $hp_window->raise(); })->pack(-side => 'right');

      $nsw_frame11 = $new_show_window->
                       Frame(-background  => 'black',
                             -borderwidth => 0,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $nsw_frame11->Button(-text => "Ok", -font => 'system 12', -command => \&save_show_info_ok )->pack(-side => "left", -padx => 30, -pady => 10);
      $nsw_frame11->Button(-text => "Cancel", -font => 'system 12', -command => sub { $new_show_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

      $sd1->bind("<Return>", \&check_date_format);
      $sd1->bind("<Tab>", \&check_date_format);
      $sd1->bind("<Shift-Tab>", \&check_date_format);
      $sd2->bind("<Return>", \&check_date_format);
      $sd2->bind("<Tab>", \&check_date_format);
      $sd2->bind("<Shift-Tab>", \&check_date_format);
      $jnum[0]->bind("<Return>",   sub { &lookup_judge_number($judgenumber[0], 0) } );
      $jnum[0]->bind("<Tab>", sub { &lookup_judge_number($judgenumber[0], 0) } );
      $jnum[0]->bind("<Shift-Tab>", sub { &lookup_judge_number($judgenumber[0], 0) } );
      $jnum[1]->bind("<Return>",   sub { &lookup_judge_number($judgenumber[1], 1) } );
      $jnum[1]->bind("<Tab>", sub { &lookup_judge_number($judgenumber[1], 1) } );
      $jnum[1]->bind("<Shift-Tab>", sub { &lookup_judge_number($judgenumber[1], 1) } );
      $jnum[2]->bind("<Return>",   sub { &lookup_judge_number($judgenumber[2], 2) } );
      $jnum[2]->bind("<Tab>", sub { &lookup_judge_number($judgenumber[2], 2) } );
      $jnum[2]->bind("<Shift-Tab>", sub { &lookup_judge_number($judgenumber[2], 2) } );
      $jnum[3]->bind("<Return>",   sub { &lookup_judge_number($judgenumber[3], 3) } );
      $jnum[3]->bind("<Tab>", sub { &lookup_judge_number($judgenumber[3], 3) } );
      $jnum[3]->bind("<Shift-Tab>", sub { &lookup_judge_number($judgenumber[3], 3) } );
      $jnum[4]->bind("<Return>",   sub { &lookup_judge_number($judgenumber[4], 4) } );
      $jnum[4]->bind("<Tab>", sub { &lookup_judge_number($judgenumber[4], 4) } );
      $jnum[4]->bind("<Shift-Tab>", sub { &lookup_judge_number($judgenumber[4], 4) } );
      $jnum[5]->bind("<Return>",   sub { &lookup_judge_number($judgenumber[5], 5) } );
      $jnum[5]->bind("<Tab>", sub { &lookup_judge_number($judgenumber[5], 5) } );
      $jnum[5]->bind("<Shift-Tab>", sub { &lookup_judge_number($judgenumber[5], 5) } );
      $jnum[6]->bind("<Return>",   sub { &lookup_judge_number($judgenumber[6], 6) } );
      $jnum[6]->bind("<Tab>", sub { &lookup_judge_number($judgenumber[6], 6) } );
      $jnum[6]->bind("<Shift-Tab>", sub { &lookup_judge_number($judgenumber[6], 6) } );
      $jnum[7]->bind("<Return>",   sub { &lookup_judge_number($judgenumber[7], 7) } );
      $jnum[7]->bind("<Tab>", sub { &lookup_judge_number($judgenumber[7], 7) } );
      $jnum[7]->bind("<Shift-Tab>", sub { &lookup_judge_number($judgenumber[7], 7) } );

      $new_show_window->withdraw();
      $new_show_window->update();

#      $y_pos = $;
#      $new_show_window->geometry("+$main_x_pos+$y_pos");
   }
}


##################################################################################
##################################################################################
#
#  Create the toplevel window for choosing classes
#

sub class_list_toplevel {

   $font = "{arial narrow bold} 10";

   if (!Exists($class_list_window)) {
      $sl = 0;
      $show_index = 1;

      &open_national_class_file;
      &open_division_file;
      &open_local_class_file;

      foreach $ii (@division_list) {
         chomp($ii);
         if ($ii =~ /^D/) {
            chop($division{$dname}) if (defined $division{$dname});
            ($dn, $dname) = split(/~/, $ii);
         }
         else {
            $ii =~ s/~/ =\> /;
            $sl = (length($ii)-8) if ((length($ii)-8) > $sl);
            $division{$dname} .= "$ii:";
         }
      }
      chop($division{$dname}) if (defined $division{$dname});

      foreach $ii (@local_class_list) {
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
                        -font        => $font,
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

      $cl_div_frame    = $ft_classes_frame->Frame->pack(-side => 'left', -fill => 'y');
      $cl_class_frame  = $ft_classes_frame->Frame->pack(-side => 'left', -fill => 'y');
      $cl_local_frame  = $st_classes_frame->Frame->pack(-side => 'left', -fill => 'y');
      $cl_select_frame = $st_classes_frame->Frame->pack(-side => 'left', -fill => 'y');

      $cl_div_frame->Label(-text => "Division List", -font => $font)->pack(-side => 'top', -fill => 'x');
      $cl_class_frame->Label(-text => "Division Classes", -font => $font)->pack(-side => 'top', -fill => 'x');
      $cl_local_frame->Label(-text => "Local Classes", -font => $font)->pack(-side => 'top', -fill => 'x');
      $cl_select_frame->Label(-text => "Selected Classes", -font => $font)->pack(-side => 'top', -fill => 'x');

      $cl_div_lb    = $cl_div_frame->Scrolled("Listbox",
                          -font       => $font,
                          -height     => 8,
                          -width      => $sl,
                          -scrollbars => 'e',
                          -selectmode => 'single')->pack;
      $cl_class_lb  = $cl_class_frame->Scrolled("Listbox",
                          -font       => $font,
                          -height     => 8,
                          -width      => $sl,
                          -scrollbars => 'e',
                          -selectmode => 'single')->pack;
      $cl_local_lb  = $cl_local_frame->Scrolled("Listbox",
                          -font       => $font,
                          -height     => 8,
                          -width      => $sl,
                          -scrollbars => 'e',
                          -selectmode => 'single')->pack;
      $cl_select_lb = $cl_select_frame->Scrolled("Listbox",
                          -font       => $font,
                          -height     => 8,
                          -width      => $sl+6,
                          -scrollbars => 'e',
                          -selectmode => 'single')->pack;

      foreach $ii (sort keys %division) { $cl_div_lb->insert('end', $ii); }
      $cl_local_lb->insert('end', @local);

      $cl_div_lb->bind("<Button-1>", \&division_display);
      $cl_class_lb->bind("<Button-1>", \&division_class_select);
      $cl_local_lb->bind("<Button-1>", \&local_class_select);
      $cl_select_lb->bind("<Button-1>", \&select_class_select);

      $cl_window_buttons->Button(-text => "Ok", -font => $font, -command => sub { $cl_window->withdraw })->pack(-side => "left", -padx => 30, -pady => 10);
      $cl_window_buttons->Button(-text => "Cancel", -font => $font, -command => sub { $cl_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

      $cl_window->withdraw();
      $cl_window->update();

#      $cl_window->geometry("+$main_x_pos+0");
   }

}


##################################################################################
##################################################################################
#
#  Create the toplevel window for setting up high point awards
#

sub high_point_toplevel {

   $font = "{arial narrow bold} 10";

   if (!Exists($hp_window)) {
      $sl = 0;
      $show_index = 1;

      &open_national_class_file;
      &open_division_file;
      &open_high_point_file;

      foreach $ii (@division_list) {
         chomp($ii);
         if ($ii =~ /^D/) {
            chop($division{$dname}) if (defined $division{$dname});
            ($dn, $dname) = split(/~/, $ii);
         }
         else {
            $ii =~ s/~/ =\> /;
            $sl = (length($ii)-8) if ((length($ii)-8) > $sl);
            $division{$dname} .= "$ii:";
         }
      }
      chop($division{$dname}) if (defined $division{$dname});

      foreach $ii (@high_point_list) {
         ($num, $name) = split(/~~/, $ii);
         $highpoint{$name} = $num;
         push (@highpoint, $name);
         $sl = length($name) if ($sl < length($name));
      }

      $hp_window = MainWindow->new(-background  => 'grey',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Select Classes');

      $hp_window->Label(-text        => "Select The Classes For High Point Awards\nSelect The Award First, Then Select The Classes\nClick 'Save' When Done With An Award",
                        -anchor      => 'center',
                        -background  => 'navy',
                        -font        => $font,
                        -foreground  => 'yellow',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $hp_window_scrollbar = $hp_window->Scrollbar();
      $hp_classes_frame  = $hp_window->Frame->pack(-side => 'top', -fill => 'x');
      $hp_window_buttons = $hp_window->Frame(
                              -background => 'black')->pack(-side => 'bottom', -fill => 'x');

      $ft_classes_frame  = $hp_window->Frame->pack(-side => 'top', -fill => 'x');
      $st_classes_frame  = $hp_window->Frame->pack(-side => 'top', -fill => 'x');

      $hp_div_frame    = $ft_classes_frame->Frame->pack(-side => 'left', -fill => 'y');
      $hp_class_frame  = $ft_classes_frame->Frame->pack(-side => 'left', -fill => 'y');
      $hp_high_frame   = $st_classes_frame->Frame->pack(-side => 'left', -fill => 'y');
      $hp_select_frame = $st_classes_frame->Frame->pack(-side => 'left', -fill => 'y');

      $hp_div_frame->Label(-text => "Division List", -font => $font)->pack(-side => 'top', -fill => 'x');
      $hp_class_frame->Label(-text => "Division Classes", -font => $font)->pack(-side => 'top', -fill => 'x');
      $hp_high_frame->Label(-text => "High Point Awards", -font => $font)->pack(-side => 'top', -fill => 'x');
      $hp_select_frame->Label(-text => "Selected Classes", -font => $font)->pack(-side => 'top', -fill => 'x');

      $hp_div_lb    = $hp_div_frame->Scrolled("Listbox",
                          -font       => $font,
                          -height     => 8,
                          -width      => $sl,
                          -scrollbars => 'e',
                          -selectmode => 'single')->pack;
      $hp_class_lb  = $hp_class_frame->Scrolled("Listbox",
                          -font       => $font,
                          -height     => 8,
                          -width      => $sl,
                          -scrollbars => 'e',
                          -selectmode => 'single')->pack;
      $hp_high_lb   = $hp_high_frame->Scrolled("Listbox",
                          -font       => $font,
                          -height     => 8,
                          -width      => $sl,
                          -scrollbars => 'e',
                          -selectmode => 'single')->pack;
      $hp_select_lb = $hp_select_frame->Scrolled("Listbox",
                          -font       => $font,
                          -height     => 8,
                          -width      => $sl+6,
                          -scrollbars => 'e',
                          -selectmode => 'single')->pack;

      foreach $ii (sort keys %division) { $hp_div_lb->insert('end', $ii); }
      $hp_high_lb->insert('end', @highpoint);

      $hp_div_lb->bind("<Button-1>", \&hp_division_display);
      $hp_class_lb->bind("<Button-1>", \&hp_division_class_select);
      $hp_high_lb->bind("<Button-1>", \&high_class_select);
      $hp_select_lb->bind("<Button-1>", \&hp_select_class_select);

      $hp_window_buttons->Button(-text => "Ok", -font => $font, -command => sub { $hp_window->withdraw })->pack(-side => "left", -padx => 30, -pady => 10);
      $hp_window_buttons->Button(-text => "Cancel", -font => $font, -command => sub { $hp_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

      $hp_window->withdraw();
      $hp_window->update();

#      $hp_window->geometry("+$main_x_pos+0");
   }
}


##################################################################################
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

      $open_show_window->Label(-text        => "Select The Show To Be Used",
                        -anchor      => 'center',
                        -background  => 'navy',
                        -font        => 'system 12',
                        -foreground  => 'yellow',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $os_shows_frame      = $open_show_window->Frame->pack(-side => 'top', -fill => 'x');
      $os_window_buttons   = $open_show_window->Frame(-background => 'black')->pack(-side => 'bottom', -fill => 'x');

      $os_shows_frame->Label(-font => 'system 12', -textvariable => \$year)->pack(-side => 'top', -fill => 'x');

      $os_shows_lb = $os_shows_frame->Scrolled("Listbox", -scrollbars => 'oe', -font => 'system 12', -selectmode => 'single')->pack;

      $os_window_buttons->Button(-text => "Ok", -font => 'system 12', -command => \&show_select )->pack(-side => "left", -padx => 30, -pady => 10);
      $os_window_buttons->Button(-text => "Cancel", -font => 'system 12', -command => \&cancel_show_select )->pack(-side => "right", -padx => 30, -pady => 10);

      $open_show_window->withdraw();
      $open_show_window->update();

      $x_pos = ($screen_width - $open_show_window->width()) / 2;
      $y_pos = ($screen_height - $open_show_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;
#      $open_show_window->geometry("+$x_pos+$y_pos");
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

      $current_entries_label = "Current # Entries: 0";

      $run_show_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Add Show Entries');

      $run_show_window->Label(-textvariable => \$showinfo,
                              -anchor       => 'center',
                              -background   => 'navy',
                              -font        => 'system 12',
                              -foreground   => 'yellow',
                              -borderwidth  => '2',
                              -relief       => 'groove',
                              -justify      => 'center')->pack(-side => 'top', fill => 'x');

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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'left')->pack(-side => 'left');
      $backnumentry = $rsw_frame1->Entry(-background   => 'white',
                         -font        => 'system 12',
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'left')->pack(-side => 'left');
      $hn = $rsw_frame2->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 15,
                         -textvariable => \$horsenum) -> pack(-side => 'left');
      $rsw_frame2->Label(-anchor       => 'w',
                         -background   => 'grey',
                         -font        => 'system 12',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  5,
                         -justify      => 'left')->pack(-side => 'left');
      $rsw_frame2->Label(-textvariable => \$horsename,
                         -anchor       => 'w',
                         -background   => 'grey',
                         -font        => 'system 12',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  35,
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'left')->pack(-side => 'left');
      $rn = $rsw_frame3->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 15,
                         -textvariable => \$ridernum) -> pack(-side => 'left');
      $rsw_frame3->Label(-anchor       => 'w',
                         -background   => 'grey',
                         -font        => 'system 12',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  5,
                         -justify      => 'left')->pack(-side => 'left');
      $rsw_frame3->Label(-textvariable => \$ridername,
                         -anchor       => 'w',
                         -background   => 'grey',
                         -font        => 'system 12',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  35,
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
                               -font        => 'system 12',
                               -foreground   => 'navy',
                               -borderwidth  => '0',
                               -width        =>  5,
                               -justify      => 'left')->pack(-side => 'left');

         for $ii (0 .. 9) {
            $classentered[$class_index] = $rsw_frame[$cl_index]->Entry(-background => 'white',
                               -font        => 'system 12',
                               -foreground   => 'black',
                               -takefocus    => 1,
                               -width        => 3,
                               -textvariable => \$rider_class[$class_index]) -> pack(-side => 'left');
            $rsw_frame[$cl_index]->Label(-anchor       => 'w',
                               -background   => 'grey',
                               -font        => 'system 12',
                               -foreground   => 'navy',
                               -borderwidth  => '0',
                               -width        =>  5,
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

      $rsw_frame8->Button(-text => "Ok", -font => 'system 12', -command => \&save_entry_info )->pack(-side => "left", -padx => 30, -pady => 10);
      $rsw_frame8->Button(-text => "Cancel", -font => 'system 12', -command => sub { $run_show_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

      $run_show_window->Label(-textvariable => \$current_entries_label,
                              -anchor       => 'w',
                              -background   => 'black',
                              -font        => 'system 12',
                              -foreground   => 'white',
                              -borderwidth  => '0',
                              -justify      => 'left')->pack(-side => 'bottom', -fill => 'x');

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

      $y_pos = $main_height + 25;
#      $run_show_window->geometry("+$main_x_pos+$y_pos");
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $newhorseentry = $ehw_frame1->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$horsenum) -> pack(-side => 'left');
      $ehw_frame1->Label(-text        => "    Year Foaled",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame1->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 4,
                         -textvariable => \$yearfoaled) -> pack(-side => 'left');
      $ehw_frame1->Label(-text        => "    Sex",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  10,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame1->Optionmenu(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -textvariable => \$horsesex,
                         -options => ["Stallion", "Gelding", "Mare"]) -> pack(-side => 'left');
      $ehw_frame1->Label(-text        => "    Color",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  10,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame1->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$horsecolor) -> pack(-side => 'left');

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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame2->Entry(-background   => 'white',
                         -font        => 'system 12',
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame3->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 25,
                         -textvariable => \$horsesire) -> pack(-side => 'left');
      $ehw_frame3->Label(-anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  5,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame3->Entry(-background   => 'white',
                         -font        => 'system 12',
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $on = $ehw_frame4->Entry(-background   => 'white',
                         -font        => 'system 12',
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame5->Entry(-background   => 'white',
                         -font        => 'system 12',
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame6->Entry(-background   => 'white',
                         -font        => 'system 12',
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame7->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$ownercity) -> pack(-side => 'left');
      $ehw_frame7->Label(-text        => "    Zip Code",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  10,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame7->Entry(-background   => 'white',
                         -font        => 'system 12',
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

      $ehw_frame4->Button(-text => "Ok", -font => 'system 12', -command => \&save_horse_info )->pack(-side => "left", -padx => 30, -pady => 10);
      $ehw_frame4->Button(-text => "Cancel", -font => 'system 12', -command => sub { $enter_horse_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

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
#  Create the toplevel window for adding a owner's information
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $newownerentry = $ehw_frame1->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$ownernum) -> pack(-side => 'left');

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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame2->Entry(-background   => 'white',
                         -font        => 'system 12',
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame3->Entry(-background   => 'white',
                         -font        => 'system 12',
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame4->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$ownercity) -> pack(-side => 'left');
      $ehw_frame4->Label(-text        => " Postal Code",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  10,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame4->Entry(-background   => 'white',
                         -font        => 'system 12',
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame5->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$ownerhomephone) -> pack(-side => 'left');
      $ehw_frame5->Label(-text        => "    Work Phone",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame5->Entry(-background   => 'white',
                         -font        => 'system 12',
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame6->Entry(-background   => 'white',
                         -font        => 'system 12',
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

      $ehw_frame7->Button(-text => "Ok", -font => 'system 12', -command => \&save_owner_info )->pack(-side => "left", -padx => 30, -pady => 10);
      $ehw_frame7->Button(-text => "Cancel", -font => 'system 12', -command => sub { $enter_owner_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

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
      $ehw_frame1 = $enter_rider_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame1->Label(-text        => "Rider ApHC Number",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $newriderentry = $ehw_frame1->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$ridernum) -> pack(-side => 'left');
#      $ehw_frame1->Label(-text        => "    Sex",
#                         -anchor      => 'w',
#                         -background  => 'grey',
#                         -font        => 'system 12',
#                         -foreground  => 'navy',
#                         -borderwidth => '0',
#                         -width       =>  10,
#                         -justify     => 'left')->pack(-side => 'left');
#      $ehw_frame1->Optioinmenu(-background   => 'white',
#                         -font        => 'system 12',
#                         -foreground   => 'black',
#                         -takefocus    => 1,
#                         -textvariable => \$ridersex,
#                         -options => ["Female", "Male"]) -> pack(-side => 'left');

#
#  Rider Name
#
      $ehw_frame2 = $enter_rider_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame2->Label(-text        => "Rider Name",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame2->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 25,
                         -textvariable => \$ridername) -> pack(-side => 'left');

#
#  Rider Information
#
      $ehw_frame3 = $enter_rider_window->
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame3->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$rideraddress) -> pack(-side => 'left');

#
#  Owner Information
#
      $ehw_frame4 = $enter_rider_window->
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame4->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$ridercity) -> pack(-side => 'left');
      $ehw_frame4->Label(-text        => " Postal Code",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  10,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame4->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$riderzip) -> pack(-side => 'left');

#
#  Rider Information
#
      $ehw_frame5 = $enter_rider_window->
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame5->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$riderhomephone) -> pack(-side => 'left');
      $ehw_frame5->Label(-text        => "    Work Phone",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame5->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$riderworkphone) -> pack(-side => 'left');

#
#  Rider Information
#
      $ehw_frame6 = $enter_rider_window->
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame6->Entry(-background   => 'white',
                         -font        => 'system 12',
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

      $ehw_frame7->Button(-text => "Ok", -font => 'system 12', -command => \&save_rider_info )->pack(-side => "left", -padx => 30, -pady => 10);
      $ehw_frame7->Button(-text => "Cancel", -font => 'system 12', -command => sub { $enter_rider_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

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
                              -font        => 'system 12',
                              -foreground   => 'yellow',
                              -borderwidth  => '2',
                              -relief       => 'groove',
                              -justify      => 'center')->pack(-side => 'top', fill => 'x');

#
#  Back Number
#
      $acw_frame1 = $add_class_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $acw_frame1->Label(-text        => "Back Number",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'left')->pack(-side => 'left');
      $addbacknumentry = $acw_frame1->Entry(-background   => 'white',
                         -font        => 'system 12',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 6,
                         -textvariable => \$backnumber) -> pack(-side => 'left');

#
#  Horse Information
#
      $acw_frame2 = $add_class_window->
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'left')->pack(-side => 'left');
      $acw_frame2->Label(-textvariable => \$horsename,
                         -anchor       => 'w',
                         -font        => 'system 12',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  35,
                         -justify      => 'left')->pack(-side => 'left');

#
#  Rider Information
#
      $acw_frame3 = $add_class_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $acw_frame3->Label(-text => "Exhibitor:", -font => 'system 12', -anchor => 'w', -background => 'grey', -foreground => 'navy', -borderwidth => '0', -width =>  25, -justify => 'left')
                               ->pack(-side => 'left');
      $rn_option = $acw_frame3->Optionmenu(-textvariable => \$rideroptioninfo)->pack(-side => 'left');

#
#  Class Numbers
#
      $add_class_window->Label(-text        => "New Classes Entered",
                              -anchor      => 'center',
                              -background  => 'grey',
                              -font        => 'system 12',
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
                               -font        => 'system 12',
                               -foreground   => 'navy',
                               -borderwidth  => '0',
                               -width        =>  5,
                               -justify      => 'left')->pack(-side => 'left');

      for $ii (0 .. 9) {
         $classentered[$ii] = $acw_frame->Entry(-background => 'white',
                            -font        => 'system 12',
                            -foreground   => 'black',
                            -takefocus    => 1,
                            -width        => 3,
                            -textvariable => \$add_rider_class[$ii]) -> pack(-side => 'left');
         $acw_frame->Label(-anchor       => 'w',
                            -background   => 'grey',
                            -font        => 'system 12',
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

      $acw_frame8->Button(-text => "Ok", -font => 'system 12', -command => \&add_class_entry)->pack(-side => "left", -padx => 30, -pady => 10);
      $acw_frame8->Button(-text => "Cancel", -font => 'system 12', -command => sub { $add_class_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

      $add_class_window->Label(-textvariable => \$current_entries_label,
                              -anchor       => 'w',
                              -background   => 'black',
                              -font        => 'system 12',
                              -foreground   => 'white',
                              -borderwidth  => '0',
                              -justify      => 'left')->pack(-side => 'bottom', -fill => 'x');

      $addbacknumentry->bind("<Return>", \&lookup_existing_back_number);
      $addbacknumentry->bind("<Tab>", \&lookup_existing_back_number);
      $addbacknumentry->bind("<Shift-Tab>", \&lookup_existing_back_number);

      $add_class_window->withdraw();
      $add_class_window->update();

      $y_pos = $main_height + 25;
#      $add_class_window->geometry("+$main_x_pos+$y_pos");
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
                              -font        => 'system 12',
                              -foreground   => 'yellow',
                              -borderwidth  => '2',
                              -relief       => 'groove',
                              -justify      => 'center')->pack(-side => 'top', fill => 'x');

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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'left')->pack(-side => 'left');
      $delbacknumentry = $scw_frame1->Entry(-background   => 'white',
                         -font        => 'system 12',
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
                         -font        => 'system 12',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'left')->pack(-side => 'left');
      $scw_frame2->Label(-textvariable => \$horsename,
                         -anchor       => 'w',
                         -background   => 'grey',
                         -font        => 'system 12',
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
      $scw_frame3->Label(-text => "Exhibitor:", -font => 'system 12', -anchor => 'w', -background => 'grey', -foreground => 'navy', -borderwidth => '0', -width =>  25, -justify => 'left')
                               ->pack(-side => 'left');
      $rn_option = $scw_frame3->Optionmenu(-textvariable => \$rideroptioninfo)->pack(-side => 'left');

#
#  Class Numbers
#
      $scratch_class_window->Label(-text   => "Current Classes Entered",
                              -anchor      => 'center',
                              -background  => 'grey',
                              -font        => 'system 12',
                              -foreground  => 'navy',
                              -borderwidth => '0',
                              -justify     => 'center')->pack(-side => 'top', -fill => 'x');

      $scw_frame = $scratch_class_window->Frame(-background  => 'grey',
                                                -borderwidth => 5,
                                                -relief      => 'flat')->
                                          pack(-side   => 'top',
                                               -fill   => 'x',
                                               -expand => 1,
                                               -anchor => 'n');
      $scw_frame->Label(-anchor       => 'w',
                        -background   => 'grey',
                        -font        => 'system 12',
                        -foreground   => 'navy',
                        -borderwidth  => '0',
                        -width        =>  5,
                        -justify      => 'left')->pack(-side => 'left');

      for $ii (0 .. 9) {
         $classentered[$ii] = $scw_frame->Entry(-background => 'white',
                            -font        => 'system 12',
                            -foreground   => 'black',
                            -takefocus    => 1,
                            -width        => 3,
                            -textvariable => \$current_rider_class[$ii]) -> pack(-side => 'left');
         $scw_frame->Label(-anchor       => 'w',
                            -background   => 'grey',
                            -font        => 'system 12',
                            -foreground   => 'navy',
                            -borderwidth  => '0',
                            -width        =>  5,
                            -justify      => 'left')->pack(-side => 'left');
      }

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

      $scw_frame8->Button(-text => "Ok", -font => 'system 12', -command => \&scratch_class_entry)->pack(-side => "left", -padx => 30, -pady => 10);
      $scw_frame8->Button(-text => "Cancel", -font => 'system 12', -command => sub { $scratch_class_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

      $scratch_class_window->Label(-textvariable => \$current_entries_label,
                              -anchor       => 'w',
                              -background   => 'black',
                              -font        => 'system 12',
                              -foreground   => 'white',
                              -borderwidth  => '0',
                              -justify      => 'left')->pack(-side => 'bottom', -fill => 'x');

      $delbacknumentry->bind("<Return>", \&lookup_existing_back_number);
      $delbacknumentry->bind("<Tab>", \&lookup_existing_back_number);
      $delbacknumentry->bind("<Shift-Tab>", \&lookup_existing_back_number);

      $scratch_class_window->withdraw();
      $scratch_class_window->update();

      $y_pos = $main_height + 25;
#      $scratch_class_window->geometry("+$main_x_pos+$y_pos");
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

##################################################################################
##################################################################################
#
#       Create The Toplevel windows
#

sub create_toplevel {

   &create_message_dialog;

   &open_show_toplevel;
   &create_new_show_toplevel;
   &judge_list_toplevel;
   &class_list_toplevel;
   &local_class_toplevel;
   &high_point_toplevel;
   &local_point_toplevel;
   &billing_toplevel;

   &create_error_message_dialog;
   $msgdialog->withdraw();
}


##################################################################################
##################################################################################
#
#       Create The Toplevel windows
#
##################################################################################
##################################################################################


##################################################################################
##################################################################################
#
#  Create a standard message window
#
##################################################################################
##################################################################################

sub create_message_dialog {
   $msgdialog = MainWindow->new(-background => 'black',
                                -borderwidth => 2,
                                -relief => 'raised',
                                -title => 'Information Message');
   $msgdl = $msgdialog->Label(-textvariable => \$msgdialogtext, -anchor => 'w', -borderwidth => '0',
                     -justify => 'center')
                     ->pack(-side => 'top', -fill => 'both', -expand => 1);
   $msgdialog->withdraw();
}


##################################################################################
##################################################################################
#
#  Create a standard message window with a button
#
##################################################################################
##################################################################################

sub create_error_message_dialog {
   $errmsgdialog = MainWindow->new(-background => 'black',
                     -borderwidth => 2,
                     -relief => 'raised',
                     -title => 'Error Message');
   $msgl1 = $errmsgdialog->Label(-textvariable => \$error_message_text,
                     -anchor => 'w',
                     -background => 'navy',
                     -borderwidth => '0',
                     -foreground => 'goldenrod',
                     -justify => 'center',)
                     ->pack(-side => 'top', -fill => 'both', -expand => 1);
   $msgb1 = $errmsgdialog->Button(-text => '  Ok  ',
                     -anchor => 's',
                     -justify => 'center',
                     -command => sub { $errmsgdialog->withdraw(); },)
                     ->pack(-side => 'bottom', -expand => 1);
   $errmsgdialog->withdraw();
   $errmsgdialog->update();
}

sub error_message {
   $errmsgdialog->update();

   $screen_width  = $errmsgdialog->screenwidth();
   $main_width    = $errmsgdialog->width();
   $main_x_pos    = int(($screen_width - $main_width) / 2);
   $screen_height = $errmsgdialog->screenheight();
   $main_height   = $errmsgdialog->height();
   $main_y_pos    = int(($screen_height - $main_height) / 2);
   $errmsgdialog->geometry("+$main_x_pos+$main_y_pos");

   $errmsgdialog->deiconify();
   $errmsgdialog->raise();
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
      $nsw_frame1->Label(-text        => "Show Name     ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  18,
                         -justify     => 'left')->pack(-side => 'left');
      $shownameentry = $nsw_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 50,
                         -textvariable => \$showname) -> pack(-side => 'left');

#
#  Show Location
#
      $nsw_frame7 = $new_show_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $nsw_frame7->Label(-text        => "Show Location ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  18,
                         -justify     => 'left')->pack(-side => 'left');
      $showloceentry = $nsw_frame7->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 50,
                         -textvariable => \$showlocation) -> pack(-side => 'left');

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
      $nsw_frame2->Label(-text        => "Show Date     ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  18,
                         -justify     => 'left')->pack(-side => 'left');
      $sd1 = $nsw_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$showdate) -> pack(-side => 'left');
      $nsw_frame2->Label(-text        => "  Format: mm/dd/yyyy or mmddyyyy",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 40,
                         -justify     => 'left')->pack(-side => 'left', -fill => 'x');

#
#  Show Number
#
      $nsw_frame3 = $new_show_window->Frame(-background  => 'grey', -borderwidth => 5, -relief => 'flat')-> pack(-side => 'top', -fill => 'x', -expand => 1, -anchor => 'n');
      $nsw_frame3->Label(-text        => "Show Numbers  ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  18,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame3->Entry(-background  => 'white',
                         -foreground  => 'black',
                         -takefocus   => 1,
                         -width       => 10,
                         -textvariable => \$shownumber[0]) -> pack(-side => 'left');
      $nsw_frame3->Label(-background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 2,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame3->Entry(-background  => 'white',
                         -foreground  => 'black',
                         -takefocus   => 1,
                         -width       => 10,
                         -textvariable => \$shownumber[1]) -> pack(-side => 'left');
      $nsw_frame3->Label(-background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 2,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame3->Entry(-background  => 'white',
                         -foreground  => 'black',
                         -takefocus   => 1,
                         -width       => 10,
                         -textvariable => \$shownumber[2]) -> pack(-side => 'left');
      $nsw_frame3->Label(-background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       => 2,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame3->Entry(-background  => 'white',
                         -foreground  => 'black',
                         -takefocus   => 1,
                         -width       => 10,
                         -textvariable => \$shownumber[3]) -> pack(-side => 'left');

#
#  Breed Type
#
      $nsw_frame4 = $new_show_window->Frame(-background  => 'grey', -borderwidth => 5, -relief => 'flat')-> pack(-side => 'top', -fill => 'x', -expand => 1, -anchor => 'n');
      $nsw_frame4->Label(-text        => "Breed Type",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  18,
                         -justify => 'left')->pack(-side => 'left');
      $nsw_frame4->Radiobutton(-background  => 'grey',
                         -foreground  => 'black',
                         -takefocus   => 1,
                         -width       => 10,
                         -variable    => \$showbreed,
                         -value       => "appaloosa",
                         -text        => "Appaloosa") -> pack(-side => 'left');
      $nsw_frame4->Radiobutton(-background  => 'grey',
                         -foreground  => 'black',
                         -takefocus   => 1,
                         -width       => 10,
                         -variable    => \$showbreed,
                         -value       => "buckskin",
                         -text        => "Buckskin") -> pack(-side => 'left');
      $nsw_frame4->Radiobutton(-background  => 'grey',
                         -foreground  => 'black',
                         -takefocus   => 1,
                         -width       => 10,
                         -variable    => \$showbreed,
                         -value       => "nsba",
                         -text        => "NSBA") -> pack(-side => 'left');


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
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  18,
                         -justify     => 'left')->pack(-side => 'left');
      $nsw_frame9->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 3,
                         -textvariable => \$maxplace) -> pack(-side => 'left');

#
#  Various Buttons
#
      $nsw_frame10 = $new_show_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $nsw_frame10->Button(-text        => " Judges ",
                          -background  => 'grey',
                          -foreground  => 'navy',
                          -borderwidth => '2',
                          -command     => \&do_select_judges)->grid(
      $nsw_frame10->Button(-text        => " Classes ",
                          -background  => 'grey',
                          -foreground  => 'navy',
                          -borderwidth => '2',
                          -command     => \&do_select_classes),
      $nsw_frame10->Button(-text        => " Local Points ",
                          -background  => 'grey',
                          -foreground  => 'navy',
                          -borderwidth => '2',
                          -command     => \&do_local_points),
      $nsw_frame10->Button(-text        => " Local Classes ",
                          -background  => 'grey',
                          -foreground  => 'navy',
                          -borderwidth => '2',
                          -command     => \&do_local_classes),
      $nsw_frame10->Button(-text        => " High Points ",
                          -background  => 'grey',
                          -foreground  => 'navy',
                          -borderwidth => '2',
                          -command     => \&do_highpoint),
      $nsw_frame10->Button(-text        => " Billing ",
                          -background  => 'grey',
                          -foreground  => 'navy',
                          -borderwidth => '2',
                          -command     => \&do_billing));

#
#  Buttons
#
      $nsw_frame12 = $new_show_window->
                       Frame(-background  => 'black',
                             -borderwidth => 0,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $nsw_frame12->Button(-text => " Save ", -command => \&save_show_info_ok )->pack(-side => "left", -padx => 30, -pady => 10);
      $nsw_frame12->Button(-text => " Copy Existing Show ", -command => \&open_existing_show )->pack(-side => "left", -padx => 30, -pady => 10);
      $nsw_frame12->Button(-text => " Exit ", -command => sub { exit; })->pack(-side => "right", -padx => 30, -pady => 10);

      $sd1->bind("<Return>",    sub { $showdate = &convert_date($showdate); lookup_show; });
      $sd1->bind("<Tab>",       sub { $showdate = &convert_date($showdate); lookup_show; });
      $sd1->bind("<Shift-Tab>", sub { $showdate = &convert_date($showdate); lookup_show; });

      $new_show_window->withdraw();
      $new_show_window->update();

      $screen_width  = $new_show_window->screenwidth();
      $main_width    = $new_show_window->width();
      $main_x_pos    = int(($screen_width - $main_width) / 2);
      $new_show_window->geometry("+$main_x_pos+0");
   }
}



##################################################################################
##################################################################################
#
#  Create the toplevel window for choosing judges
#

sub judge_list_toplevel {
   if (!Exists($judge_window)) {
      $judge_window = MainWindow->new(-background  => 'grey',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Select Judges');

      $judge_window->Label(-text     => "Select The Judges IN ORDER",
                        -anchor      => 'center',
                        -background  => 'navy',
                        -foreground  => 'yellow',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

#
#  Judge Number
#
      $j_frame1 = $judge_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $j_frame1->Label(  -text        => "\nDouble-Click To Select A Judge\n",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  30,
                         -justify     => 'center')->pack(-side => 'top');
      $judges_lb = $j_frame1->Scrolled("Listbox",
                             -font       => "courier 10",
                             -scrollbars => 'oe',
                             -selectmode => 'single',
                             -height     => 10,
                             -width      => 25)->pack;

      $j_frame2 = $judge_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $j_frame2->Label(  -text        => "\nDouble-Click To Unselect A Judge\n",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  30,
                         -justify     => 'center')->pack(-side => 'top');
      $j_select_lb = $j_frame2->Scrolled("Listbox",
                             -font       => "courier 10",
                             -scrollbars => 'oe',
                             -selectmode => 'single',
                             -height     => 10,
                             -width      => 25)->pack;

      $judges_lb->bind("<Double-Button-1>",  \&judge_select);
      $judges_lb->bind("<Key>", [ \&search_judge_list, Ev("K") ]);
      $j_select_lb->bind("<Double-Button-1>",  \&judge_delete);

      $judge_window_buttons = $judge_window->Frame(-background => 'black')->pack(-side => 'bottom', -fill => 'x');
      $judge_window_buttons->Button(-text => "Ok", -command => sub { $judge_window->withdraw })->pack(-side => "left", -padx => 30, -pady => 10);
      $judge_window_buttons->Button(-text => "Cancel", -command => sub { $judge_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

      $judge_window->withdraw();
      $judge_window->update();
   }
}


##################################################################################
##################################################################################
#
#  Create the toplevel window for choosing classes
#

sub class_list_toplevel {
   if (!Exists($cl_window)) {
      $cl_window = MainWindow->new(-background  => 'grey',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Select Classes');

      $cl_window->Label(-text        => "Select The Classes IN ORDER OF APPEARANCE\nTo unselect a class, click on it in the Selected Classes list",
                        -anchor      => 'center',
                        -background  => 'navy',
                        -foreground  => 'yellow',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $cl_classes_frame  = $cl_window->Frame->pack(-side => 'top', -fill => 'x');
      $cl_window_buttons = $cl_window->Frame(-background => 'black')->pack(-side => 'bottom', -fill => 'x');

      $ft_classes_frame  = $cl_window->Frame->pack(-side => 'top', -fill => 'x');
      $st_classes_frame  = $cl_window->Frame->pack(-side => 'top', -fill => 'x');

      $cl_div_frame    = $ft_classes_frame->Frame->pack(-side => 'left', -fill => 'y');
      $cl_class_frame  = $ft_classes_frame->Frame->pack(-side => 'left', -fill => 'y');
      $cl_local_frame  = $st_classes_frame->Frame->pack(-side => 'left', -fill => 'y');
      $cl_select_frame = $st_classes_frame->Frame->pack(-side => 'left', -fill => 'y');

      $cl_div_frame->Label(-text => "Division List")->pack(-side => 'top', -fill => 'x');
      $cl_class_frame->Label(-text => "Division Classes")->pack(-side => 'top', -fill => 'x');
      $cl_local_frame->Label(-text => "Local Classes")->pack(-side => 'top', -fill => 'x');
      $cl_select_frame->Label(-text => "Selected Classes")->pack(-side => 'top', -fill => 'x');

      $cl_div_lb    = $cl_div_frame->Scrolled("Listbox",
                          -height     => 15,
                          -font       => 'arial 9',
                          -width      => 30,
                          -scrollbars => 'se',
                          -selectmode => 'single')->pack;
      $cl_class_lb  = $cl_class_frame->Scrolled("Listbox",
                          -height     => 15,
                          -font       => 'arial 9',
                          -width      => 36,
                          -scrollbars => 'se',
                          -selectmode => 'single')->pack;
      $cl_local_lb  = $cl_local_frame->Scrolled("Listbox",
                          -height     => 15,
                          -font       => 'arial 9',
                          -width      => 30,
                          -scrollbars => 'se',
                          -selectmode => 'single')->pack;
      $cl_select_lb = $cl_select_frame->Scrolled("Listbox",
                          -height     => 15,
                          -font       => 'arial 9',
                          -width      => 36,
                          -scrollbars => 'se',
                          -selectmode => 'single')->pack;

      $cl_div_lb->bind("<Double-Button-1>", \&division_display);
      $cl_class_lb->bind("<Double-Button-1>", \&division_class_select);
      $cl_local_lb->bind("<Double-Button-1>", \&local_class_select);
      $cl_select_lb->bind("<Double-Button-1>", \&select_class_select);

      $cl_window_buttons->Button(-text => "Ok", -command => sub { $cl_window->withdraw })->pack(-side => "left", -padx => 30, -pady => 10);
      $cl_window_buttons->Button(-text => "Cancel", -command => sub { $cl_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

      $cl_window->withdraw();
      $cl_window->update();
   }

}




##################################################################################
##################################################################################
#
#  Create the toplevel window for choosing classes
#

sub class_list_toplevel {
   if (!Exists($cl_window)) {
      $cl_window = MainWindow->new(-background  => 'grey',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Select Classes');

      $cl_window->Label(-text        => "Select The Classes IN ORDER OF APPEARANCE\nTo unselect a class, click on it in the Selected Classes list",
                        -anchor      => 'center',
                        -background  => 'navy',
                        -foreground  => 'yellow',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $cl_classes_frame  = $cl_window->Frame->pack(-side => 'top', -fill => 'x');
      $cl_window_buttons = $cl_window->Frame(-background => 'black')->pack(-side => 'bottom', -fill => 'x');

      $ft_classes_frame  = $cl_window->Frame->pack(-side => 'top', -fill => 'x');
      $st_classes_frame  = $cl_window->Frame->pack(-side => 'top', -fill => 'x');

      $cl_div_frame    = $ft_classes_frame->Frame->pack(-side => 'left', -fill => 'y');
      $cl_class_frame  = $ft_classes_frame->Frame->pack(-side => 'left', -fill => 'y');
      $cl_local_frame  = $st_classes_frame->Frame->pack(-side => 'left', -fill => 'y');
      $cl_select_frame = $st_classes_frame->Frame->pack(-side => 'left', -fill => 'y');

      $cl_div_frame->Label(-text => "Division List")->pack(-side => 'top', -fill => 'x');
      $cl_class_frame->Label(-text => "Division Classes")->pack(-side => 'top', -fill => 'x');
      $cl_local_frame->Label(-text => "Local Classes")->pack(-side => 'top', -fill => 'x');
      $cl_select_frame->Label(-text => "Selected Classes")->pack(-side => 'top', -fill => 'x');

      $cl_div_lb    = $cl_div_frame->Scrolled("Listbox",
                          -height     => 15,
                          -font       => 'arial 9',
                          -width      => 30,
                          -scrollbars => 'se',
                          -selectmode => 'single')->pack;
      $cl_class_lb  = $cl_class_frame->Scrolled("Listbox",
                          -height     => 15,
                          -font       => 'arial 9',
                          -width      => 36,
                          -scrollbars => 'se',
                          -selectmode => 'single')->pack;
      $cl_local_lb  = $cl_local_frame->Scrolled("Listbox",
                          -height     => 15,
                          -font       => 'arial 9',
                          -width      => 30,
                          -scrollbars => 'se',
                          -selectmode => 'single')->pack;
      $cl_select_lb = $cl_select_frame->Scrolled("Listbox",
                          -height     => 15,
                          -font       => 'arial 9',
                          -width      => 36,
                          -scrollbars => 'se',
                          -selectmode => 'single')->pack;

      $cl_div_lb->bind("<Double-Button-1>", \&division_display);
      $cl_class_lb->bind("<Double-Button-1>", \&division_class_select);
      $cl_local_lb->bind("<Double-Button-1>", \&local_class_select);
      $cl_select_lb->bind("<Double-Button-1>", \&select_class_select);

      $cl_window_buttons->Button(-text => "Ok", -command => sub { $cl_window->withdraw })->pack(-side => "left", -padx => 30, -pady => 10);
      $cl_window_buttons->Button(-text => "Cancel", -command => sub { $cl_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

      $cl_window->withdraw();
      $cl_window->update();
   }

}


##################################################################################
##################################################################################
#
#  Create the toplevel window for setting up high point awards
#

sub high_point_toplevel {
   if (!Exists($high_point_window)) {
      $high_point_window = MainWindow->new(-background  => 'grey',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Set Up High Points');

#
#  Frames
#
      $hp_main = $high_point_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side      => 'top',
                               -fill      => 'x',
                               -expand    => 1,
                               -anchor    => 'n');
      $hp_top = $high_point_window->                           # For highpoint variables
                       Frame(-background  => 'grey',
                             -borderwidth => 2,
                             -relief      => 'groove')->
                          pack(-side      => 'top',
                               -fill      => 'x',
                               -expand    => 1,
                               -anchor    => 'n');
      $hp_bottom = $high_point_window->                        # For lists
                       Frame(-background  => 'grey',
                             -borderwidth => 2,
                             -relief      => 'groove')->
                          pack(-side      => 'top',
                               -fill      => 'x',
                               -expand    => 1,
                               -anchor    => 'n');
      $hp_mframe1 = $hp_bottom->                               # High point divisions and classes
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side      => 'left',
                               -fill      => 'x',
                               -expand    => 1,
                               -anchor    => 'n');
      $hp_mframe2 = $hp_bottom->                               # Selected divisions and classes
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side      => 'right',
                               -fill      => 'x',
                               -expand    => 1,
                               -anchor    => 'n');

      $hp_mframe12 = $hp_top->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side      => 'left',
                               -fill      => 'x',
                               -expand    => 1,
                               -anchor    => 'n');
      $hp_mframe12->Label(-text         => "Based On:",
                        -anchor        => 'w',
                        -background    => 'grey',
                        -foreground    => 'navy',
                        -borderwidth   => '2',
                        -justify       => 'left',
                        -relief        => 'flat') -> pack(-side => 'top');
      $hp_mframe12->Optionmenu(-background => 'grey',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 15,
                         -textvariable => \$hp_type,
                         -options => ["HIGHEST PLACING HORSE",
									  "RIDER ONLY",
                                      "HORSE ONLY",
                                      "BOTH RIDER AND HORSE"]) -> pack(-side => 'top');

      $hp_mframe13 = $hp_top->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side      => 'right',
                               -fill      => 'x',
                               -expand    => 1,
                               -anchor    => 'n');
      $hp_mframe13->Label(-text        => "Required to Enter # Classes:",
                        -anchor        => 'w',
                        -background    => 'grey',
                        -foreground    => 'navy',
                        -borderwidth   => '2',
                        -justify       => 'left',
                        -relief        => 'flat') -> pack(-side => 'top', -fill => 'x');
      $hp_text = $hp_mframe13->Entry(-background   => 'white',
                        -foreground    => 'black',
                        -takefocus     => 1,
                        -width         => 3,
                        -justify       => 'left',
                        -textvariable  => \$hp_required) -> pack(-side => 'top');

      $hp_mframe1->Label(-text         => "\nSelect High Point Division\n",
                        -anchor        => 'w',
                        -background    => 'grey',
                        -foreground    => 'navy',
                        -borderwidth   => '2',
#                        -width         => 30,
                        -justify       => 'center',
                        -relief        => 'flat') -> pack(-side => 'top');
       $hp_standard_lb  = $hp_mframe1->Scrolled("Listbox",
                          -height      => 15,
                          -width       => 36,
                          -scrollbars  => 'e',
                          -selectmode  => 'single')->pack(-side => 'top');
      $hp_mframe1->Label(-text         => "\nSelect Classes For This Highpoint\n",
                        -anchor        => 'w',
                        -background    => 'grey',
                        -foreground    => 'navy',
                        -borderwidth   => '2',
#                        -width         => 30,
                        -justify       => 'center',
                        -relief        => 'flat') -> pack(-side => 'top');
      $hp_select_lb = $hp_mframe1->Scrolled("Listbox",
                          -height      => 15,
                          -width       => 36,
                          -scrollbars  => 'e',
                          -selectmode  => 'single')->pack;

#
#  High Points Already Set Up
#
      $hp_mframe2->Label(-text        => "\nExisting Highpoint Divisions\n(Single-Click To View) - (Double-Click To Delete)\n",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '2',
                         -justify     => 'center',
                         -relief      => 'flat') -> pack(-side => 'top');
      $hp_setup_lb  = $hp_mframe2->Scrolled("Listbox",
                         -height      => 15,
                         -width       => 36,
                         -scrollbars  => 'se',
                         -selectmode  => 'single')->pack(-side => 'top');
      $hp_mframe2->Label(-text        => "\nClasses For Existing Highpoint\n(Double-Click To Delete)\n",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '2',
                         -justify     => 'center',
                         -relief      => 'flat') -> pack(-side => 'top');
      $cl_setup_lb  = $hp_mframe2->Scrolled("Listbox",
                          -height     => 15,
                          -width      => 36,
                          -scrollbars => 'se',
                          -selectmode => 'single')->pack(-side => 'top');

#
#  Buttons
#
      $hp_main3  = $high_point_window->Frame(
                             -background  => 'black',
                             -borderwidth => 0,
                             -relief      => 'flat')->pack(-side => 'top', -fill => 'x');
      $hp_main3->Button(-text => "Ok", -command => sub { $high_point_window->withdraw })->pack(-side => "left", -padx => 30, -pady => 10);
      $hp_main3->Button(-text => "Cancel", -command => sub { $high_point_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

#      $hp_text->bind("<Return>",    \&select_text_hp);
#      $hp_text->bind("<Tab>",       \&select_text_hp);
#      $hp_text->bind("<Shift-Tab>", \&select_text_hp);

      $hp_standard_lb->bind("<Double-Button-1>", \&select_standard_hp);
      $hp_select_lb->bind("<Double-Button-1>",   \&select_class_for_hp);
      $hp_setup_lb->bind("<Button-1>",           \&view_existing_hp);
      $hp_setup_lb->bind("<Double-Button-1>",    \&delete_existing_hp);
      $cl_setup_lb->bind("<Double-Button-1>",    \&delete_hp_class);

      $hp_standard_lb->delete(0, 'end');
      $hp_standard_lb->insert('end', sort @standard_hp);

      $high_point_window->withdraw();
      $high_point_window->update();
   }
}


##################################################################################
##################################################################################
#
#  Set up local point structure
#

sub local_point_toplevel {

   my $ii, $num_h;

   if (!Exists($local_point_window)) {
      $local_point_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Local Point Setup');

      $local_point_window->Label(-text        => "Fill in the table below with point values.\nRows represent number of horses in a class,\nand columns represent the place.",
                        -anchor      => 'center',
                        -background  => 'navy',
                        -foreground  => 'yellow',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

#
#  Table Header
#
      $lpw_frame2 = $local_point_window->
                       Frame(-background  => 'black',
                             -borderwidth => 1,
                             -relief      => 'raised')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $lpw_frame2->Label(-text        => " NUM HORSES",
                         -anchor      => 'w',
                         -background  => 'black',
                         -foreground  => 'yellow',
                         -borderwidth => '0',
                         -justify     => 'left',
                         -width       => 15)->pack(-side => 'left');

      for $ii (1 .. 8) {
         $lpw_frame2->Label(-text        => " $ii          ",
                            -anchor      => 'w',
                            -background  => 'black',
                            -foreground  => 'yellow',
                            -borderwidth => '0',
                            -justify     => 'left',
                            )->pack(-side => 'left');
      }

      $index = 0;
      for $num_h (1 .. 6) {
         $lpw_frame[$num_h] = $local_point_window->
                                   Frame(-background  => 'grey',
                                         -borderwidth => 5,
                                         -relief      => 'flat')->
                                      pack(-side   => 'top',
                                           -fill   => 'x',
                                           -expand => 1,
                                           -anchor => 'n');

         $lpw_frame[$num_h]->Label(-text => "$num_h",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'black',
                         -borderwidth => '0',
                         -justify     => 'left',
                         -width       => 15)->pack(-side => 'left');

         for $ii (0 .. 7) {
            $local_points[$index] = $lpw_frame[$num_h]->Entry(-background => 'white',
                               -foreground   => 'black',
                               -takefocus    => 1,
                               -width        => 3,
                               -textvariable => \$local_points{$num_h}[$ii]) -> pack(-side => 'left');
            $lpw_frame[$num_h]->Label(-anchor => 'w',
                               -background   => 'grey',
                               -foreground   => 'navy',
                               -borderwidth  => '0',
                               -width        =>  2,
                               -justify      => 'left')->pack(-side => 'left');
            $index++;
         }
      }


#
#  Buttons
#
      $lpw_frame9 = $local_point_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $lpw_frame9->Button(-text => "Ok",  -command => sub { $local_point_window->withdraw(); })->pack(-side => "left", -padx => 30, -pady => 5);
      $lpw_frame9->Button(-text => "Cancel", -command => sub { $local_point_window->withdraw(); })->pack(-side => "right", -padx => 30, -pady => 5);

      $local_point_window->Label(-textvariable => \$current_entries_label,
                              -anchor       => 'w',
                              -background   => 'black',
                              -foreground   => 'white',
                              -borderwidth  => '0',
                              -justify      => 'left')->pack(-side => 'bottom', -fill => 'x');

      $local_point_window->withdraw();
      $local_point_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $local_point_window->width()) / 2;
      $y_pos = ($screen_height - $local_point_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $local_point_window->geometry("+$x_pos+0");
   }
}


##################################################################################
##################################################################################
#
#  Set up local classes
#

sub local_class_toplevel {

   if (!Exists($local_class_window)) {
      $local_class_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Local Class Setup');

      $local_class_window->Label(-text => "Enter the class number and name below.\nEnter Y if the class is to get a real\nclass number or N if it does not.\nClick 'Add' to add the class and continue.\nClick 'Ok' to add thc class and quit.",
                        -anchor      => 'center',
                        -background  => 'navy',
                        -foreground  => 'yellow',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $lclw_frame2 = $local_class_window->
                       Frame(-background  => 'black',
                             -borderwidth => 1,
                             -relief      => 'raised')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $lclw_frame2->Label(-text        => "CLASS #",
                         -anchor      => 'w',
                         -background  => 'black',
                         -foreground  => 'yellow',
                         -borderwidth => '0',
                         -justify     => 'left',
                         -width       => 9)->pack(-side => 'left');

      $lclw_frame2->Label(-text        => "   Y/N",
                         -anchor      => 'w',
                         -background  => 'black',
                         -foreground  => 'yellow',
                         -borderwidth => '0',
                         -justify     => 'left',
                         -width       => 9)->pack(-side => 'left');

      $lclw_frame2->Label(-text        => " CLASS NAME",
                         -anchor      => 'w',
                         -background  => 'black',
                         -foreground  => 'yellow',
                         -borderwidth => '0',
                         -justify     => 'left',
                         -width       => 30)->pack(-side => 'left');

      $lclw_frame3 = $local_class_window->
                         Frame(-background  => 'grey',
                               -borderwidth => 5,
                               -relief      => 'flat')->
                               pack(-side   => 'top',
                                    -fill   => 'x',
                                    -expand => 1,
                                    -anchor => 'n');

      $localclnum  = $lclw_frame3->Entry(-background => 'white',
                               -foreground   => 'black',
                               -takefocus    => 1,
                               -width        => 5,
                               -textvariable => \$localclassnum) -> pack(-side => 'left');

      $lclw_frame3->Label(-text       => " ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -borderwidth => '0',
                         -justify     => 'left',
                         -width       => 3)->pack(-side => 'left');

      $yesnotext  = $lclw_frame3->Entry(-background => 'white',
                               -foreground   => 'black',
                               -takefocus    => 1,
                               -width        => 5,
                               -textvariable => \$yesno) -> pack(-side => 'left');

      $lclw_frame3->Label(-text       => " ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -borderwidth => '0',
                         -justify     => 'left',
                         -width       => 3)->pack(-side => 'left');

      $localclname = $lclw_frame3->Entry(-background => 'white',
                               -foreground   => 'black',
                               -takefocus    => 1,
                               -width        => 30,
                               -textvariable => \$localclassname) -> pack(-side => 'left');

      $lclw_frame4 = $local_class_window->
                         Frame(-background  => 'grey',
                               -borderwidth => 5,
                               -relief      => 'flat')->
                               pack(-side   => 'top',
                                    -fill   => 'x',
                                    -expand => 1,
                                    -anchor => 'n');

       $lclw_frame4->Label(-text     => "Current Local Classes",
                        -anchor      => 'w',
                        -background  => 'grey',
                        -foreground  => 'navy',
                        -borderwidth => '2',
                        -width        => 30,
                        -justify     => 'center',
                        -relief      => 'flat') -> pack(-side => 'top', -fill => 'x');
      $local_classes_lb  = $lclw_frame4->Scrolled("Listbox",
                          -height     => 10,
                          -width      => 36,
                          -scrollbars => 'e',
                          -selectmode => 'single')->pack(-side => 'top');
#
#  Buttons
#
      $lclw_frame9 = $local_class_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $lclw_frame9->Button(-text => "Ok",  -command => sub { &add_local_class; $local_class_window->withdraw(); })->pack(-side => "left", -padx => 30, -pady => 5);
      $lclw_frame9->Button(-text => "Add",  -command => sub { &add_local_class;  $localclassnum = "";  $localclassname = ""; })->pack(-side => "left", -padx => 30, -pady => 5);
      $lclw_frame9->Button(-text => "Cancel", -command => sub { $local_class_window->withdraw(); })->pack(-side => "right", -padx => 30, -pady => 5);

      $local_classes_lb->bind("<Double-Button-1>", \&delete_local_class);

      $local_class_window->withdraw();
      $local_class_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $local_class_window->width()) / 2;
      $y_pos = ($screen_height - $local_class_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $local_class_window->geometry("+$x_pos+0");
   }
}


##################################################################################
##################################################################################
#
#  Create the toplevel window for adding billing
#

sub billing_toplevel_old {

   if (!Exists($billing_window)) {
      $billing_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Show Billing');

      $billing_window->Label(-textvariable => \$showname,
                              -anchor       => 'center',
                              -background   => 'navy',
                              -foreground   => 'yellow',
                              -borderwidth  => '2',
                              -relief       => 'groove',
                              -justify      => 'center')->pack(-side => 'top', -fill => 'x');

#
#  Open Classes
#
      $bw_frame1 = $billing_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $bw_frame1->Label(-text         => "Open Classes",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $opencost = $bw_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$opencost) -> pack(-side => 'left');

#
#  NonPro Classes
#
      $bw_frame1->Label(-text         => "   NonPro Classes",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -font        => 'arial 9',
                         -borderwidth => '0',
                         -width       =>  15,
                         -justify     => 'right')->pack(-side => 'left');
      $nonprocost = $bw_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$nonprocost) -> pack(-side => 'left');

#
#  Youth Classes
#
      $bw_frame1->Label(-text         => "   Youth Classes",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  15,
                         -justify     => 'right')->pack(-side => 'left');
      $youthcost = $bw_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$youthcost) -> pack(-side => 'left');

#
#  Leadline Class
#
      $bw_frame2 = $billing_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $bw_frame2->Label(-text         => "Leadline Class",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $leadlinecost = $bw_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$leadlinecost) -> pack(-side => 'left');

#
#  Local Classes
#
      $bw_frame2->Label(-text         => "   Local Classes",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  15,
                         -justify     => 'right')->pack(-side => 'left');
      $localcost = $bw_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$localcost) -> pack(-side => 'left');

#
#  Jump Fee
#
      $bw_frame3 = $billing_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $bw_frame3->Label(-text         => "Jump Fee",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $jumpfee = $bw_frame3->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$jumpfee) -> pack(-side => 'left');

#
#  Cattle Fee
#
      $bw_frame3->Label(-text         => "   Cattle Fee",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $cattlefee = $bw_frame3->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$cattlefee) -> pack(-side => 'left');

#
#  Office Fee
#
      $bw_frame4 = $billing_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $bw_frame4->Label(-text         => "Office Fee",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $officefee = $bw_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$officefee) -> pack(-side => 'left');

#
#  Stall Fee
#
      $bw_frame5 = $billing_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $bw_frame5->Label(-text         => "Stalls (1 Day)",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $stallfee1 = $bw_frame5->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$stallfee1) -> pack(-side => 'left');

#
#  Stall Fee
#
      $bw_frame5->Label(-text         => "   Stalls (2 Days)",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $stallfee2 = $bw_frame5->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$stallfee2) -> pack(-side => 'left');

#
#  Shavings Fee
#
      $bw_frame5->Label(-text         => "   Shavings (Bag)",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $shavingsfee = $bw_frame5->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$shavingsfee) -> pack(-side => 'left');

#
#  Tie-Out Fee
#
      $bw_frame6 = $billing_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $bw_frame6->Label(-text         => "   Tie-Out Fee",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $tieoutfee = $bw_frame6->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$tieoutfee) -> pack(-side => 'left');

#
#  RV Fee
#
      $bw_frame6->Label(-text         => "   RV Fee",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  15,
                         -justify     => 'left')->pack(-side => 'left');
      $rvfee = $bw_frame6->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$rvfee) -> pack(-side => 'left');

#
#  Buttons
#
      $bw_frame8 = $billing_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $bw_frame8->Button(-text => "Ok", -command => sub{ $billing_window->withdraw(); } )->pack(-side => "left", -padx => 15, -pady => 5);
      $bw_frame8->Button(-text => "Cancel", -command => sub { $billing_window->withdraw(); } )->pack(-side => "right", -padx => 15, -pady => 5);

      $billing_window->withdraw();
      $billing_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $billing_window->width()) / 2;
      $y_pos = ($screen_height - $billing_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $billing_window->geometry("+$x_pos+0");
   }
}


##################################################################################
##################################################################################
#
#  Create the toplevel window for adding billing
#

sub billing_toplevel {

   if (!Exists($billing_window)) {
      $billing_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Show Billing');

      $billing_window->Label(-textvariable => \$showname,
                              -anchor       => 'center',
                              -background   => 'navy',
                              -foreground   => 'yellow',
                              -borderwidth  => '2',
                              -relief       => 'groove',
                              -justify      => 'center')->pack(-side => 'top', -fill => 'x');

#
#  Fee Labels
#
      $bw_frame1 = $billing_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $bw_frame1->Label(-text         => "   Open",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  10,
                         -justify     => 'left')->pack(-side => 'left');
      $bw_frame1->Label(-text         => "   NonPro",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -font        => 'arial 9',
                         -borderwidth => '0',
                         -width       =>  10,
                         -justify     => 'right')->pack(-side => 'left');
      $bw_frame1->Label(-text         => "   Youth",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  10,
                         -justify     => 'right')->pack(-side => 'left');
      $bw_frame1->Label(-text         => "   Local",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  10,
                         -justify     => 'right')->pack(-side => 'left');
      $bw_frame1->Label(-text         => "   Jump",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  10,
                         -justify     => 'right')->pack(-side => 'left');
      $bw_frame1->Label(-text         => "   Cattle",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  10,
                         -justify     => 'right')->pack(-side => 'left');

#
#  Fee Text Boxes
#
      $bw_frame2  = $billing_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $bw_frame2->Label(-text         => " ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  1,
                         -justify     => 'right')->pack(-side => 'left');
      $ofee   = $bw_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 5,
                         -textvariable => \$opencost) -> pack(-side => 'left');
      $bw_frame2->Label(-text         => "     ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  5,
                         -justify     => 'right')->pack(-side => 'left');
      $nfee = $bw_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 5,
                         -textvariable => \$nonprocost) -> pack(-side => 'left');
      $bw_frame2->Label(-text         => "      ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  5,
                         -justify     => 'right')->pack(-side => 'left');
      $yfee  = $bw_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 5,
                         -textvariable => \$youthcost) -> pack(-side => 'left');
      $bw_frame2->Label(-text         => "      ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  4,
                         -justify     => 'right')->pack(-side => 'left');
      $lfee  = $bw_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 5,
                         -textvariable => \$localcost) -> pack(-side => 'left');
      $bw_frame2->Label(-text         => "      ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  5,
                         -justify     => 'right')->pack(-side => 'left');
      $jfee    = $bw_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 5,
                         -textvariable => \$jumpfee) -> pack(-side => 'left');
      $bw_frame2->Label(-text         => "      ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  5,
                         -justify     => 'right')->pack(-side => 'left');
      $cfee = $bw_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 5,
                         -textvariable => \$cattlefee) -> pack(-side => 'left');

#
#  Fee Labels
#
      $bw_frame3 = $billing_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $bw_frame3->Label(-text         => "   Office",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  10,
                         -justify     => 'left')->pack(-side => 'left');
      $bw_frame3->Label(-text         => "   TieOut",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  10,
                         -justify     => 'left')->pack(-side => 'left');
      $bw_frame3->Label(-text         => "   Stall (1 Day)",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -font        => 'arial 9',
                         -borderwidth => '0',
                         -width       =>  13,
                         -justify     => 'right')->pack(-side => 'left');
      $bw_frame3->Label(-text         => " Stall (2 Day)",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  13,
                         -justify     => 'right')->pack(-side => 'left');
      $bw_frame3->Label(-text         => " Shavings",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  12,
                         -justify     => 'right')->pack(-side => 'left');
      $bw_frame3->Label(-text         => "   RV",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  10,
                         -justify     => 'right')->pack(-side => 'left');

#
#  Fee Text Boxes
#
      $bw_frame4  = $billing_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $bw_frame4->Label(-text         => " ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  1,
                         -justify     => 'right')->pack(-side => 'left');
      $offee = $bw_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 5,
                         -textvariable => \$officefee) -> pack(-side => 'left');
      $bw_frame4->Label(-text         => "     ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  5,
                         -justify     => 'right')->pack(-side => 'left');
      $tfee = $bw_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 5,
                         -textvariable => \$tieoutfee) -> pack(-side => 'left');
      $bw_frame4->Label(-text         => "     ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  7,
                         -justify     => 'right')->pack(-side => 'left');
      $s1day = $bw_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 5,
                         -textvariable => \$stall1day) -> pack(-side => 'left');
      $bw_frame4->Label(-text         => "      ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  7,
                         -justify     => 'right')->pack(-side => 'left');
      $s2day = $bw_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 5,
                         -textvariable => \$stall2day) -> pack(-side => 'left');
      $bw_frame4->Label(-text         => "      ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  7,
                         -justify     => 'right')->pack(-side => 'left');
      $shave  = $bw_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 5,
                         -textvariable => \$shavings) -> pack(-side => 'left');
      $bw_frame4->Label(-text         => "      ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  5,
                         -justify     => 'right')->pack(-side => 'left');
      $rv    = $bw_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 5,
                         -textvariable => \$rvcost) -> pack(-side => 'left');

#
#  Class List Frame
#
      $bw_frame7  = $billing_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $bw_frame7->Label(-text => "   Class Name",
                      -anchor      => 'w',
                      -background  => 'black',
                      -foreground  => 'yellow',
                      -borderwidth => '0',
                      -font        => 'arial 9',
                      -width       =>  35,
                      -justify     => 'right')->pack(-side => 'left');
      $bw_frame7->Label(-text => "Class",  -anchor => 'w', -background => 'black',
                      -foreground  => 'yellow', -borderwidth => '0', -font => 'arial 9',
                      -width => 8, -justify => 'right')->pack(-side => 'left');
      $bw_frame7->Label(-text => "  Jump",   -anchor => 'w', -background => 'black',
                      -foreground  => 'yellow', -borderwidth => '0', -font => 'arial 9',
                      -width => 7, -justify => 'right')->pack(-side => 'left');
      $bw_frame7->Label(-text => "    Cattle", -anchor => 'w', -background => 'black',
                      -foreground  => 'yellow', -borderwidth => '0', -font => 'arial 9',
                      -width => 10, -justify => 'right')->pack(-side => 'left');


      $bw_frame8  = $billing_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $bw_scroll = $bw_frame8->Scrolled("Text", -height => 30, -width => 50, -wrap => 'none',
                                         -background => 'grey', -scrollbars => 'e')->pack(-expand => 1, -fill => 'both');

#
#  Frames For Classes
#
#print "Number of classes in the show... $#classes\n";

      for $ii (0 .. $#bill_classes) {
#print "Class added: $bill_classes[$ii]\n";
         $w = $bw_scroll->Label(-text => $bill_classes[$ii],
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -relief      => 'groove',
                         -width       =>  35,
                         -font        => 'arial 9',
                         -justify     => 'right')->pack(-side => 'left');
         $bw_scroll->windowCreate('end', -window => $w);
         $w = $bw_scroll->Entry(-background => 'white',
                            -foreground   => 'black',
                            -takefocus    => 1,
                            -width        => 3,
                            -textvariable => \$bwl_fee[$ii]) -> pack(-side => 'left');
         $bw_scroll->windowCreate('end', -window => $w);
         $w = $bw_scroll->Label(-text => "   ", -anchor => 'w', -background => 'grey',
                         -foreground  => 'navy', -borderwidth => '0', -font => 'arial 9',
                         -width => 5, -justify => 'right')->pack(-side => 'left');
         $bw_scroll->windowCreate('end', -window => $w);
         $w = $bw_scroll->Entry(-background => 'white',
                            -foreground   => 'black',
                            -takefocus    => 1,
                            -width        => 3,
                            -textvariable => \$bwl_jump[$ii]) -> pack(-side => 'left');
         $bw_scroll->windowCreate('end', -window => $w);
         $w = $bw_scroll->Label(-text => "   ", -anchor => 'w', -background => 'grey',
                         -foreground  => 'navy', -borderwidth => '0', -font => 'arial 9',
                         -width => 5, -justify => 'right')->pack(-side => 'left');
         $bw_scroll->windowCreate('end', -window => $w);
         $w = $bw_scroll->Entry(-background => 'white',
                            -foreground   => 'black',
                            -takefocus    => 1,
                            -width        => 3,
                            -textvariable => \$bwl_cattle[$ii]) -> pack(-side => 'left');
         $bw_scroll->windowCreate('end', -window => $w);
         $w = $bw_scroll->Label(-text => "   ", -anchor => 'w', -background => 'grey',
                         -foreground  => 'navy', -borderwidth => '0', -font => 'arial 9',
                         -width => 3, -justify => 'right')->pack(-side => 'left');
         $bw_scroll->windowCreate('end', -window => $w);
         $bw_scroll->insert('end', "\n");
      }

      $bw_scroll->configure(-state => 'disabled');

#
#  Buttons
#
      $bw_frame9 = $billing_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $bw_frame9->Button(-text => "Ok", -command => sub{ $billing_window->withdraw(); } )->pack(-side => "left", -padx => 15, -pady => 5);
      $bw_frame9->Button(-text => "Cancel", -command => sub { $billing_window->withdraw(); } )->pack(-side => "right", -padx => 15, -pady => 5);

      $ofee->bind("<Return>",      \&update_class_fees);
      $ofee->bind("<Tab>",      \&update_class_fees);
      $ofee->bind("<Shift-Tab>",  \&update_class_fees);
      $nfee->bind("<Return>",      \&update_class_fees);
      $nfee->bind("<Tab>",      \&update_class_fees);
      $nfee->bind("<Shift-Tab>",  \&update_class_fees);
      $yfee->bind("<Return>",      \&update_class_fees);
      $yfee->bind("<Tab>",      \&update_class_fees);
      $yfee->bind("<Shift-Tab>",  \&update_class_fees);
      $lfee->bind("<Return>",      \&update_class_fees);
      $lfee->bind("<Tab>",      \&update_class_fees);
      $lfee->bind("<Shift-Tab>",  \&update_class_fees);
      $jfee->bind("<Return>",      \&update_class_fees);
      $jfee->bind("<Tab>",      \&update_class_fees);
      $jfee->bind("<Shift-Tab>",  \&update_class_fees);
      $cfee->bind("<Return>",      \&update_class_fees);
      $cfee->bind("<Tab>",      \&update_class_fees);
      $cfee->bind("<Shift-Tab>",  \&update_class_fees);

      $billing_window->withdraw();
      $billing_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $billing_window->width()) / 2;
      $y_pos = ($screen_height - $billing_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $billing_window->geometry("+$x_pos+0");
   }
}

1;

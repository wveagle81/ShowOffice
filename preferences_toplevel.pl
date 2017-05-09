##################################################################################
##################################################################################
#
#       Create The Toplevel windows
#

sub create_toplevel {
   $program = "run";

   &create_message_dialog;
   &display_message("Initializing Horse Show Office Windows - Please Be Patient!", 0, "i");

   &open_show_toplevel;
   &run_show_toplevel;
   &name_list_toplevel;
   &add_horse_information_toplevel;
   &add_owner_information_toplevel;
   &add_rider_information_toplevel;
   &rider_list_toplevel;
   &modify_horse_toplevel;
   &modify_member_toplevel;
   &combine_list_toplevel;
   &combine_confirm_toplevel;
   &combine_related_toplevel;
   &combine_finished_toplevel;
   &change_back_toplevel;

   $msgdialog->withdraw();
}


##################################################################################
##################################################################################
#
#  Create the toplevel window for adding a complete entry to a show
#

sub run_show_toplevel {

   if (!Exists($run_show_window)) {
      $current_entries_label = "Current # Entries: 0";
      $relation = "Select Relationship of Owner To Exhibitor";

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
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -font        => 'arial 9',
                         -width       =>  21,
                         -justify     => 'left')->pack(-side => 'left');
      $backnumentry = $rsw_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 4,
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
                         -font        => 'arial 9',
                         -borderwidth => '0',
                         -width       =>  21,
                         -justify     => 'left')->pack(-side => 'left');
      $hn = $rsw_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 8,
                         -textvariable => \$horsenum) -> pack(-side => 'left');
      $rsw_frame2->Button(-text => " Horse List ", -width => 12, -font => 'arial 9', -command => \&select_horse)->pack(-side => "left", -padx => 30, -pady => 5);
      $rsw_frame2->Button(-textvariable => \$horsename,
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => 1,
                         -width        =>  25,
                         -relief       => 'ridge',
                         -command      => sub { modify_horse() },
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
                         -font        => 'arial 9',
                         -width       =>  21,
                         -justify     => 'left')->pack(-side => 'left');
      $rn = $rsw_frame3->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 8,
                         -textvariable => \$ridernum) -> pack(-side => 'left');
      $rsw_frame3->Button(-text => " Rider List ", -width => 12, -font => 'arial 9', -command => \&select_member)->pack(-side => "left", -padx => 30, -pady => 5);
      $rsw_frame3->Button(-textvariable => \$ridername,
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => 1,
                         -width        =>  25,
                         -relief       => 'ridge',
                         -command      => sub { modify_rider() },
                         -justify      => 'left')->pack(-side => 'left');
#
#  Rider Relation To Owner Of Horse
#
      $rsw_frame4 = $run_show_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $rsw_frame4->Label(-text        => "Exhibitor Relationship",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -font        => 'arial 9',
                         -borderwidth => '0',
                         -width       =>  21,
                         -justify     => 'left')->pack(-side => 'left');
      $rl = $rsw_frame4->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'black',
                         -relief       => 'raised',
                         -indicatoron  => 0,
                         -textvariable => \$relation,
                         -options      => [["Select Relationship of Owner To Exhibitor", ""],
                                           ["SELF",         "SELF"],
                                           ["HUSBAND",      "HUSBAND"],
                                           ["WIFE",         "WIFE"],
                                           ["PARENT",       "PARENT"],
                                           ["STEP-PARENT",  "STEP-PARENT"],
                                           ["SON",          "SON"],
                                           ["DAUGHTER",     "DAUGHTER"],
                                           ["STEP-CHILD",   "STEP-CHILD"],
                                           ["BROTHER",      "BROTHER"],
                                           ["SISTER",       "SISTER"],
                                           ["HALF-BROTHER", "HALF-BROTHER"],
                                           ["HALF-SISTER",  "HALF-SISTER"],
                                           ["UNCLE",        "UNCLE"],
                                           ["AUNT",         "AUNT"],
                                           ["NIECE",        "NIECE"],
                                           ["NEPHEW",       "NEPHEW"],
                                           ["COUSIN",       "COUSIN"],
                                           ["GRANDCHILD",   "GRANDCHILD"],
                                           ["IN-LAW",       "IN-LAW"]]) -> pack(-side => 'left');
      $rsw_frame4->Label(-anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  5,
                         -justify      => 'left')->pack(-side => 'left');
      $rsw_frame4->Label(-text         => "(Exhibitor to Horse Owner)\nOnly Used If Youth Or Non-Pro",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
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
#                               -width        =>  5,
                               -justify      => 'left')->pack(-side => 'left');

         for $ii (0 .. 9) {
            $classentered[$class_index] = $rsw_frame[$cl_index]->Entry(-background => 'white',
                               -foreground   => 'black',
                               -takefocus    => 1,
                               -width        => 3,
                               -textvariable => \$rider_class[$class_index]) -> pack(-side => 'left');
            $rsw_frame[$cl_index]->Label(-anchor => 'w',
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

      $rsw_frame8->Button(-text => "Add", -command => \&save_entry_info )->pack(-side => "left", -padx => 15, -pady => 5);
      $rsw_frame8->Button(-text => "Scratch", -command => \&scratch_entry )->pack(-side => "left", -padx => 15, -pady => 5);
      $rsw_frame8->Button(-text => "Modify Back #", -command => \&change_back )->pack(-side => "left", -padx => 15, -pady => 5);
      $rsw_frame8->Button(-text => "Combine Classes", -command => \&combine_list )->pack(-side => "left", -padx => 15, -pady => 5);
      $rsw_frame8->Button(-text => "Cancel", -command => sub { exit; })->pack(-side => "right", -padx => 15, -pady => 5);

      $run_show_window->Label(-textvariable => \$current_entries_label,
                              -anchor       => 'w',
                              -background   => 'black',
                              -foreground   => 'white',
                              -borderwidth  => '0',
                              -justify      => 'left')->pack(-side => 'bottom', -fill => 'x');

      $backnumentry->bind("<Return>", \&lookup_existing_back_number);
      $backnumentry->bind("<Tab>", \&lookup_existing_back_number);
      $backnumentry->bind("<Shift-Tab>", \&lookup_existing_back_number);
      $hn->bind("<Return>", \&check_existing_horse_number);
      $hn->bind("<Tab>", \&check_existing_horse_number);
      $hn->bind("<Shift-Tab>", \&check_existing_horse_number);
      $rn->bind("<Return>", \&check_existing_rider_number);
      $rn->bind("<Tab>", \&check_existing_rider_number);
      $rn->bind("<Shift-Tab>", \&check_existing_rider_number);

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
#  Create the toplevel window for displaying horse/rider lists
#

sub name_list_toplevel {

   if (!Exists($name_list_window)) {
      $name_list_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Horse/Rider Name List');

      $name_list_window->Label(-text => "Horse or Rider Selector",
                         -anchor       => 'n',
                         -background   => 'navy',
                         -foreground   => 'yellow',
                         -borderwidth  => '0',
                         -justify      => 'center')->pack(-side => 'top', -fill => 'x');


#
#  Main frames
#
      $name_frame  = $name_list_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 2,
                             -relief      => 'raised')->
                          pack(-side   => 'top',
                               -fill   => 'both',
                               -expand => 1,
                               -anchor => 'n');
      $n_frame0 = $name_frame->
                       Frame(-background  => 'grey',
                             -borderwidth => 2,
                             -relief      => 'raised')->
                          pack(-side   => 'top',
                               -fill   => 'both',
                               -expand => 1,
                               -anchor => 'n');
      $n_frame1 = $name_frame->
                       Frame(-background  => 'grey',
                             -borderwidth => 2,
                             -relief      => 'raised')->
                          pack(-side   => 'top',
                               -fill   => 'both',
                               -expand => 1,
                               -anchor => 'n');

#
#  Frame 0 - Name search
#

      $n_frame0->Label(-text        => "Search: ",
                         -anchor      => 'n',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');
      $sr = $n_frame0->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 13,
                         -textvariable => \$search) -> pack(-side => 'left');

#
#  Frame 1 - Member/Horse Selector
#

#
#  List Box
#
      $miw_scrollframe = $n_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $miw_lb          = $miw_scrollframe->Scrolled("Listbox", -scrollbars => 'oe', -selectmode => 'single')->pack;

#
#  Buttons
#
      $miw_buttonframe = $n_frame1->Frame->pack(-side => 'top', -fill => 'x', -expand => 1, -anchor => 's');
      $miw_buttonframe->Button(-text => "Cancel", -command => sub { $name_list_window->withdraw(); } )->pack(-side => "right", -padx => 5, -pady => 5);

      $sr->bind("<Key>", [ \&search_name_list, Ev("K") ]);
      $miw_lb->bind("<Double-Button-1>", \&select_name);

      $name_list_window->withdraw();
      $name_list_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $name_list_window->width()) / 2;
      $y_pos = ($screen_height - $name_list_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $name_list_window->geometry("+0+0");
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
      $ehw_frame1->Label(-text        => "  Year Foaled  ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 4,
                         -textvariable => \$yearfoaled) -> pack(-side => 'left');
      $ehw_frame1->Label(-text        => "  Sex  ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');
      $n_hs = $ehw_frame1->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 0,
                         -textvariable => \$horsesex,
                         -options      => [["Select Horse Sex", ""],
                                           ["STALLION", "STALLION"],
                                           ["GELDING",  "GELDING"],
                                           ["MARE",     "MARE"]]) -> pack(-side => 'left');
      $ehw_frame1->Label(-text        => "  Color  ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$horsecolor) -> pack(-side => 'left');

      $ehw_frame10 = $enter_horse_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame10->Label(-text        => "Club Member",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $n_hms = $ehw_frame10->Optionmenu(
                         -background => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$horsememberstatus,
                         -options      => [["Select Membership Status", ""],
                                           ["YES", "YES"],
                                           ["NO",  "NO"]]) -> pack(-side => 'left');

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
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $n_ht = $ehw_frame11->Optionmenu(
                         -background => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$horsetype,
                         -options      => [["Select Registration Type", ""],
                                           ["# - Regular",                              "#"],
                                           ["T - Tentative",                            "T"],
                                           ["N - Non-Characteristic",                   "N"],
                                           ["CN - Certified Pedigree Option",           "CN"],
                                           ["F - Foundation",                           "F"],
                                           ["BT - Breeding Stock (Tentative)",          "BT"],
                                           ["B# - Breeding Stock (Permanent)",          "B#"],
                                           ["BN - Breeding Stock (Non-Characteristic)", "BN"],
                                           ["ID - Identification System",               "IC"],
                                           ["PC - Pedigree Certificate",                "PC"]]) -> pack(-side => 'left');

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

      $ehw_frame40 = $enter_horse_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame40->Label(-text        => "Club Member",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $ehw_oms = $ehw_frame40->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 0,
                         -textvariable => \$ownermemberstatus,
                         -options      => [["Select Membership Status", ""],
                                           ["YES", "YES"],
                                           ["NO",  "NO"]]) -> pack(-side => 'left');

      $ehw_frame41 = $enter_horse_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame41->Label(-text        => "Registration Status",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $ehw_os = $ehw_frame41->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 0,
                         -textvariable => \$ownernumberstatus,
                         -options      => [["Select Registration Status", ""],
                                           ["CURRENT",    "CURRENT"],
                                           ["PENDING",    "PENDING"],
                                           ["UNKNOWN",    "UNKNOWN"],
                                           ["NOT MEMBER", "NOT MEMBER"]]) -> pack(-side => 'left');

      $ehw_frame41->Label(-text        => "  Registration Type ",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -justify      => 'left')->pack(-side => 'left');
      $ehw_ot = $ehw_frame41->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$ownertype,
                         -options      => [["Select Registration Type", ""],
                                           ["OPEN          ", "OPEN"],
                                           ["NON PRO       ", "NON PRO"],
                                           ["NOVICE NON PRO", "NOVICE NON PRO"],
                                           ["YOUTH         ", "YOUTH"],
                                           ["NOVICE YOUTH  ", "NOVICE YOUTH"]]) -> pack(-side => 'left');

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
      $ehw_frame5->Label(-text        => "Owner Name (F/L)",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame5->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 15,
                         -textvariable => \$ownerfirstname) -> pack(-side => 'left');
      $ehw_frame5->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 25,
                         -textvariable => \$ownerlastname) -> pack(-side => 'left');

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
      $ehw_frame7->Label(-text        => "City",
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
      $ehw_frame7->Label(-text        => "  State  ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');
      $ehw_frame7->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 2,
                         -textvariable => \$ownerstate) -> pack(-side => 'left');
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
#  Owner Information
#
      $ehw_frame8 = $enter_horse_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame8->Label(-text        => " Sex",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $ehw_ox = $ehw_frame8->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 0,
                         -textvariable => \$ownersex,
                         -options      => [["Select Owner Sex", ""],
                                           ["FEMALE", "FEMALE"],
                                           ["MALE",   "MALE"]]) -> pack(-side => 'left');
      $ehw_frame8->Label(-text         => "  Birth Year  ",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -justify      => 'left')->pack(-side => 'left');
      $ehw_frame8->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 4,
                         -textvariable => \$owneryear) -> pack(-side => 'left');

#
#  Owner Information
#
      $ehw_frame9 = $enter_horse_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame9->Label(-text        => "Home Phone",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $ehw_frame9->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$ownerhomephone) -> pack(-side => 'left');

      $ehw_frame10 = $enter_horse_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame10->Label(-text       => "Work Phone",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $ehw_frame10->Entry(-background => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$ownerworkphone) -> pack(-side => 'left');

      $ehw_frame11 = $enter_horse_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $ehw_frame11->Label(-text       => "Email Address",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $ehw_frame11->Entry(-background => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$owneremail) -> pack(-side => 'left');

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

      $ehw_frame4->Button(-text => "Ok", -command => \&save_new_horse_info )->pack(-side => "left", -padx => 30, -pady => 5);
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
      $eow_frame1 = $enter_owner_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $eow_frame1->Label(-text        => "Owner ApHC Number",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $newownerentry = $eow_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$ownernum) -> pack(-side => 'left');

      $eow_frame40 = $enter_owner_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $eow_frame40->Label(-text        => "Club Member",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $n_oms = $eow_frame40->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$ownermemberstatus,
                         -options      => [["Select Membership Status", ""],
                                           ["YES", "YES"],
                                           ["NO",  "NO"]]) -> pack(-side => 'left');

      $eow_frame41 = $enter_owner_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $eow_frame41->Label(-text        => "Registration Status",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $n_os = $eow_frame41->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$ownernumberstatus,
                         -options      => [["Select Registration Status", ""],
                                           ["CURRENT",    "CURRENT"],
                                           ["PENDING",    "PENDING"],
                                           ["UNKNOWN",    "UNKNOWN"],
                                           ["NOT MEMBER", "NOT MEMBER"]]) -> pack(-side => 'left');

      $eow_frame41->Label(-text        => "  Registration Type ",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -justify      => 'left')->pack(-side => 'left');
      $n_ot = $eow_frame41->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$ownertype,
                         -options      => [["Select Registration Type", ""],
                                           ["OPEN",           "OPEN"],
                                           ["NON PRO",        "NON PRO"],
                                           ["NOVICE NON PRO", "NOVICE NON PRO"],
                                           ["YOUTH",          "YOUTH"],
                                           ["NOVICE YOUTH",   "NOVICE YOUTH"]]) -> pack(-side => 'left');

#
#  Owner Name
#
      $eow_frame2 = $enter_owner_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $eow_frame2->Label(-text        => "Owner Name (F/L)",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $eow_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 15,
                         -textvariable => \$ownerfirstname) -> pack(-side => 'left');
      $eow_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 25,
                         -textvariable => \$ownerlastname) -> pack(-side => 'left');

#
#  Owner Information
#
      $eow_frame3 = $enter_owner_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $eow_frame3->Label(-text        => "Address",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $eow_frame3->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$owneraddress) -> pack(-side => 'left');

#
#  Owner Information
#
      $eow_frame4 = $enter_owner_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $eow_frame4->Label(-text        => "City",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $eow_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$ownercity) -> pack(-side => 'left');
      $eow_frame4->Label(-text        => "  State  ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');
      $eow_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 2,
                         -textvariable => \$ownerstate) -> pack(-side => 'left');
      $eow_frame4->Label(-text        => "  Zip Code  ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');
      $eow_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$ownerzip) -> pack(-side => 'left');

#
#  Owner Information
#
      $eow_frame41 = $enter_owner_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $eow_frame41->Label(-text        => " Sex",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $n_ox = $eow_frame41->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$ownersex,
                         -options      => [["Select Owner Sex", ""],
                                           ["FEMALE", "FEMALE"],
                                           ["MALE",   "MALE"]]) -> pack(-side => 'left');
      $eow_frame41->Label(-text         => "  Birth Year  ",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -justify      => 'left')->pack(-side => 'left');
      $eow_frame41->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 4,
                         -textvariable => \$owneryear) -> pack(-side => 'left');

      $eow_frame5 = $enter_owner_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $eow_frame5->Label(-text        => "Home Phone",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $eow_frame5->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$ownerhomephone) -> pack(-side => 'left');

      $eow_frame51 = $enter_owner_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
     $eow_frame51->Label(-text        => "Work Phone",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $eow_frame51->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$ownerworkphone) -> pack(-side => 'left');

#
#  Owner Information
#
      $eow_frame6 = $enter_owner_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $eow_frame6->Label(-text        => "Email Address",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $eow_frame6->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$owneremail) -> pack(-side => 'left');

#
#  Buttons
#
      $eow_frame7 = $enter_owner_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $eow_frame7->Button(-text => "Ok",     -command => \&save_new_owner_info )->pack(-side => "left", -padx => 30, -pady => 10);
      $eow_frame7->Button(-text => "Cancel", -command => sub { $enter_owner_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

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
      $erw_frame10 = $enter_rider_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $erw_frame10->Label(-text        => "Club Member",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $n_rms = $erw_frame10->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$ridermemberstatus,
                         -options      => [["Select Membership Status", ""],
                                           ["YES", "YES"],
                                           ["NO",  "NO"]]) -> pack(-side => 'left');
      $erw_frame11 = $enter_rider_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $erw_frame11->Label(-text        => "Registration Status",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $n_rs = $erw_frame11->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$ridernumberstatus,
                         -options      => [["Select Registration Status", ""],
                                           ["CURRENT",    "CURRENT"],
                                           ["PENDING",    "PENDING"],
                                           ["UNKNOWN",    "UNKNOWN"],
                                           ["NOT MEMBER", "NOT MEMBER"]]) -> pack(-side => 'left');
      $erw_frame11->Label(-text        => "  Registration Type  ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');
      $n_rt = $erw_frame11->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$ridertype,
                         -options      => [["Select Registration Type", ""],
                                           ["OPEN",           "OPEN"],
                                           ["NON PRO",        "NON PRO"],
                                           ["NOVICE NON PRO", "NOVICE NON PRO"],
                                           ["YOUTH",          "YOUTH"],
                                           ["NOVICE YOUTH",   "NOVICE YOUTH"]]) -> pack(-side => 'left');

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
      $erw_frame2->Label(-text        => "Rider Name (F/L)",
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
      $erw_frame4->Label(-text        => "  State  ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');
      $erw_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 2,
                         -textvariable => \$riderstate) -> pack(-side => 'left');
      $erw_frame4->Label(-text        => "  Zip Code  ",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');
      $erw_frame4->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$riderzip) -> pack(-side => 'left');

      $erw_frame41 = $enter_rider_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $erw_frame41->Label(-text        => "Sex",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $n_rx = $erw_frame41->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$ridersex,
                         -options      => [["Select Rider Sex", ""],
                                           ["FEMALE", "FEMALE"],
                                           ["MALE",   "MALE"]]) -> pack(-side => 'left');

      $erw_frame41->Label(-text         => "  Birth Year  ",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -justify      => 'left')->pack(-side => 'left');
      $erw_frame41->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 4,
                         -textvariable => \$rideryear) -> pack(-side => 'left');

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
      $erw_frame51 = $enter_rider_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $erw_frame51->Label(-text        => "Work Phone",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  20,
                         -justify     => 'left')->pack(-side => 'left');
      $erw_frame51->Entry(-background   => 'white',
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
      $erw_frame7 = $enter_rider_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $erw_frame7->Button(-text => "Ok",     -command => \&save_new_rider_info )->pack(-side => "left", -padx => 30, -pady => 10);
      $erw_frame7->Button(-text => "Cancel", -command => sub { $enter_rider_window->withdraw })->pack(-side => "right", -padx => 30, -pady => 10);

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

      $rl_names_frame   = $rider_list_window->Frame->pack(-side => 'top', -fill => 'x');
      $rl_names_buttons = $rider_list_window->Frame(-background => 'black')->pack(-side => 'bottom', -fill => 'x');

      $rl_names_lb = $rl_names_frame->Scrolled("Listbox", -width => 60, -font => 'courier 10', -scrollbars => 'oe', -selectmode => 'single')->pack;

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
#  Create the toplevel window for displaying horse information
#

sub modify_horse_toplevel {

   if (!Exists($modify_horse_window)) {
      $modify_horse_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Modify Horse Information');

#
#  Main frames
#
      $mhw_frame1 = $modify_horse_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 2,
                             -relief      => 'raised')->
                          pack(-side   => 'top',
                               -fill   => 'both',
                               -expand => 1,
                               -anchor => 'n');

#
#  Frame 1 - Horse Information
#
      $mhw_frame1->Label(-text        => "Horse Information",
                         -anchor      => 'n',
                         -background  => 'navy',
                         -foreground  => 'yellow',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'center')->pack(-side => 'top', -fill => 'x');

      $mhw_hframe1  = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe2  = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe20 = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe3  = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe4  = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe5  = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe6  = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe7  = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe70 = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe8  = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe9  = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe10 = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe11 = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe12 = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe13 = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe14 = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe15 = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe16 = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe17 = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');

      $mhw_hframe1->Label(-text        => " Horse ApHC Number",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $hn = $mhw_hframe1->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 13,
                         -textvariable => \$horsenum) -> pack(-side => 'left');
      $mhw_hframe1->Label(-text        => "    Year Foaled",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  15,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe1->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 4,
                         -textvariable => \$yearfoaled) -> pack(-side => 'left');

      $mhw_hframe2->Label(-text        => " Sex",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $hs = $mhw_hframe2->Optionmenu(
                         -background => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$horsesex,
                         -options      => [["Select Horse Sex", ""],
                                           ["STALLION", "STALLION"],
                                           ["GELDING",  "GELDING"],
                                           ["MARE",     "MARE"]]) -> pack(-side => 'left');
      $mhw_hframe2->Label(-text        => "    Color",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  10,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe2->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$horsecolor) -> pack(-side => 'left');

      $mhw_hframe20->Label(-text        => " Club Member",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $hms = $mhw_hframe20->Optionmenu(
                         -background => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$horsememberstatus,
                         -options      => [["Select Membership Status", ""],
                                           ["YES", "YES"],
                                           ["NO",  "NO"]]) -> pack(-side => 'left');

      $mhw_hframe3->Label(-text        => " Registration Type",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $ht = $mhw_hframe3->Optionmenu(
                         -background => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$horsetype,
                         -options      => [["Select Registration Type", ""],
                                           ["# - Regular",                              "#"],
                                           ["T - Tentative",                            "T"],
                                           ["N - Non-Characteristic",                   "N"],
                                           ["CN - Certified Pedigree Option",           "CN"],
                                           ["F - Foundation",                           "F"],
                                           ["BT - Breeding Stock (Tentative)",          "BT"],
                                           ["B# - Breeding Stock (Permanent)",          "B#"],
                                           ["BN - Breeding Stock (Non-Characteristic)", "BN"],
                                           ["ID - Identification System",               "IC"],
                                           ["PC - Pedigree Certificate",                "PC"]]) -> pack(-side => 'left');

      $mhw_hframe4->Label(-text        => " Horse Name",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe4->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 25,
                         -textvariable => \$horsename) -> pack(-side => 'left');
      $mhw_hframe5->Label(-text        => " Sire Name",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe5->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 25,
                         -textvariable => \$horsesire) -> pack(-side => 'left');
      $mhw_hframe6->Label(-text        => " Dam Name",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe6->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 25,
                         -textvariable => \$horsedam) -> pack(-side => 'left');
      $mhw_hframe7->Label(-text        => " Owner ApHC Number",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $on = $mhw_hframe7->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$ownernum) -> pack(-side => 'left');

      $mhw_hframe70->Label(-text       => " Club Member",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $os = $mhw_hframe70->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 0,
                         -textvariable => \$ownermemberstatus,
                         -options      => [["Select Membership Status", ""],
                                           ["YES", "YES"],
                                           ["NO",  "NO"]]) -> pack(-side => 'left');

      $mhw_hframe8->Label(-text        => " Registration Status",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $os = $mhw_hframe8->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 0,
                         -textvariable => \$ownernumberstatus,
                         -options      => [["Select Registration Status", ""],
                                           ["CURRENT",    "CURRENT"],
                                           ["PENDING",    "PENDING"],
                                           ["UNKNOWN",    "UNKNOWN"],
                                           ["NOT MEMBER", "NOT MEMBER"]]) -> pack(-side => 'left');
      $mhw_hframe9->Label(-text        => " Registration Type",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $ot = $mhw_hframe9->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$ownertype,
                         -options      => [["Select Registration Type", ""],
                                           ["OPEN          ", "OPEN"],
                                           ["NON PRO       ", "NON PRO"],
                                           ["NOVICE NON PRO", "NOVICE NON PRO"],
                                           ["YOUTH         ", "YOUTH"],
                                           ["NOVICE YOUTH  ", "NOVICE YOUTH"]]) -> pack(-side => 'left');
      $mhw_hframe10->Label(-text       => " Sex",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $ox = $mhw_hframe10->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 0,
                         -textvariable => \$ownersex,
                         -options      => [["Select Owner Sex", ""],
                                           ["FEMALE", "FEMALE"],
                                           ["MALE",   "MALE"]]) -> pack(-side => 'left');
      $mhw_hframe10->Label(-text        => "  Birth Year",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  12,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe10->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 4,
                         -textvariable => \$owneryear) -> pack(-side => 'left');

      $mhw_hframe11->Label(-text        => " Owner Name",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe11->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 15,
                         -textvariable => \$ownerfirstname) -> pack(-side => 'left');
      $mhw_hframe11->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 25,
                         -textvariable => \$ownerlastname) -> pack(-side => 'left');

      $mhw_hframe12->Label(-text        => " Address",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe12->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$owneraddress) -> pack(-side => 'left');

      $mhw_hframe13->Label(-text       => " City",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe13->Entry(-background => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$ownercity) -> pack(-side => 'left');

      $mhw_hframe14->Label(-text       => " State",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe14->Entry(-background => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 3,
                         -textvariable => \$ownerstate) -> pack(-side => 'left');
      $mhw_hframe14->Label(-text       => "    Zip Code",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  12,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe14->Entry(-background => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$ownerzip) -> pack(-side => 'left');

      $mhw_hframe15->Label(-text        => "Home Phone",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe15->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$ownerhomephone) -> pack(-side => 'left');

      $mhw_hframe16->Label(-text       => "Work Phone",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe16->Entry(-background => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$ownerworkphone) -> pack(-side => 'left');

      $mhw_hframe17->Label(-text       => "Email Address",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe17->Entry(-background => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$owneremail) -> pack(-side => 'left');


#
#  Buttons
#
      $mhw_frame2 = $modify_horse_window->
                       Frame(-background  => 'black',
                             -borderwidth => 2,
                             -relief      => 'flat')->
                          pack(-side   => 'bottom',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 's');

      $mhw_frame2->Label(-textvariable => \$modify_text,
                         -anchor       => 'n',
                         -background   => 'black',
                         -foreground   => 'white',
                         -borderwidth  => '0',
                         -justify      => 'center')->pack(-side => 'left', -fill => 'x');

      $mhw_frame2->Button(-text => "Cancel", -command => sub { $modify_horse_window->withdraw(); })->pack(-side => "right", -padx => 30, -pady => 5);
      $mhw_frame2->Button(-text => "Save", -command => \&save_horse_info )->pack(-side => "right", -padx => 90, -pady => 5);

      $on->bind("<Return>", \&lookup_owner_number);
      $on->bind("<FocusOut>", \&lookup_owner_number);
      $hn->bind("<Return>", \&lookup_horse_number);
      $hn->bind("<Tab>", \&lookup_horse_number);
      $hn->bind("<Shift-Tab>", \&lookup_horse_number);

      $modify_horse_window->withdraw();
      $modify_horse_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = $run_show_window->width() / 2;
      $y_pos = ($screen_height - $modify_horse_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $modify_horse_window->geometry("+$x_pos+0");
   }
}


##################################################################################
##################################################################################
#
#  Create the toplevel window for displaying member information
#

sub modify_member_toplevel {

   if (!Exists($modify_member_window)) {
      $modify_member_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Modify Member Information');

#
#  Main frames
#
      $mmw_frame1 = $modify_member_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 2,
                             -relief      => 'raised')->
                          pack(-side   => 'top',
                               -fill   => 'both',
                               -expand => 1,
                               -anchor => 'n');

#
#  Frame 1 - Horse Information
#
      $mmw_frame1->Label(-text        => "Member Information",
                         -anchor      => 'n',
                         -background  => 'navy',
                         -foreground  => 'yellow',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'center')->pack(-side => 'top', -fill => 'x');

      $mmw_mframe1  = $mmw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mmw_mframe14 = $mmw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mmw_mframe2  = $mmw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mmw_mframe3  = $mmw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mmw_mframe4  = $mmw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mmw_mframe5  = $mmw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mmw_mframe6  = $mmw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mmw_mframe7  = $mmw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mmw_mframe8  = $mmw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mmw_mframe9  = $mmw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mmw_mframe10 = $mmw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mmw_mframe11 = $mmw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mmw_mframe12 = $mmw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mmw_mframe13 = $mmw_frame1->Frame->pack(-side => 'top', -fill => 'x');

      $mmw_mframe1->Label(-text        => " Rider ApHC Number",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $rn = $mmw_mframe1->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$ridernum) -> pack(-side => 'left');

      $mmw_mframe14->Label(-text       => " Club Member",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $rms = $mmw_mframe14->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$ridermemberstatus,
                         -options      => [["Select MembershipStatus", ""],
                                           ["YES", "YES"],
                                           ["NO",  "NO"]]) -> pack(-side => 'left');

      $mmw_mframe2->Label(-text        => " Registration Status",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $rs = $mmw_mframe2->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$ridernumberstatus,
                         -options      => [["Select Registration Status", ""],
                                           ["CURRENT",    "CURRENT"],
                                           ["PENDING",    "PENDING"],
                                           ["UNKNOWN",    "UNKNOWN"],
                                           ["NOT MEMBER", "NOT MEMBER"]]) -> pack(-side => 'left');

      $mmw_mframe3->Label(-text        => " Sex",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $rx = $mmw_mframe3->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$ridersex,
                         -options      => [["Select Rider Sex", ""],
                                           ["FEMALE", "FEMALE"],
                                           ["MALE",   "MALE"]]) -> pack(-side => 'left');
      $mmw_mframe3->Label(-text        => "  Birth Year",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  12,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe3->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 4,
                         -textvariable => \$rideryear) -> pack(-side => 'left');

      $mmw_mframe4->Label(-text        => " Registration Type",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $rt = $mmw_mframe4->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$ridertype,
                         -options      => [["Select Registration Type", ""],
                                           ["OPEN",           "OPEN"],
                                           ["NON PRO",        "NON PRO"],
                                           ["NOVICE NON PRO", "NOVICE NON PRO"],
                                           ["YOUTH",          "YOUTH"],
                                           ["NOVICE YOUTH",   "NOVICE YOUTH"]]) -> pack(-side => 'left');

      $mmw_mframe5->Label(-text        => " Rider Name (F/L)",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe5->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 15,
                         -textvariable => \$riderfirstname) -> pack(-side => 'left');
      $mmw_mframe5->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 25,
                         -textvariable => \$riderlastname) -> pack(-side => 'left');

      $mmw_mframe6->Label(-text        => " Address",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe6->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$rideraddress) -> pack(-side => 'left');

      $mmw_mframe7->Label(-text        => " City",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe7->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$ridercity) -> pack(-side => 'left');
      $mmw_mframe8->Label(-text        => " State",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe8->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 3,
                         -textvariable => \$riderstate) -> pack(-side => 'left');
      $mmw_mframe8->Label(-text        => "    Zip Code",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  12,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe8->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$riderzip) -> pack(-side => 'left');

      $mmw_mframe9->Label(-text        => "Home Phone",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe9->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$riderhomephone) -> pack(-side => 'left');
      $mmw_mframe10->Label(-text       => "Work Phone",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe10->Entry(-background => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$riderworkphone) -> pack(-side => 'left');

      $mmw_mframe11->Label(-text       => "Email Address",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe11->Entry(-background => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$rideremail) -> pack(-side => 'left');


#
#  Buttons
#
      $mmw_frame2 = $modify_member_window->
                       Frame(-background  => 'black',
                             -borderwidth => 2,
                             -relief      => 'flat')->
                          pack(-side   => 'bottom',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 's');

      $mmw_frame2->Label(-textvariable => \$modify_text,
                         -anchor       => 'n',
                         -background   => 'black',
                         -foreground   => 'white',
                         -borderwidth  => '0',
                         -justify      => 'center')->pack(-side => 'left', -fill => 'x');

      $mmw_frame2->Button(-text => "Cancel", -command => sub { $modify_member_window->withdraw(); })->pack(-side => "right", -padx => 30, -pady => 5);
      $mmw_frame2->Button(-text => "Save", -command => \&save_member_info )->pack(-side => "right", -padx => 90, -pady => 5);

      $rn->bind("<Return>", \&lookup_rider_number);
      $rn->bind("<Tab>", \&lookup_rider_number);
      $rn->bind("<Shift-Tab>", \&lookup_rider_number);

      $modify_member_window->withdraw();
      $modify_member_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = $run_show_window->width() / 2;
      $y_pos = ($screen_height - $modify_member_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $modify_member_window->geometry("+$x_pos+0");
   }
}


##################################################################################
##################################################################################
#
#  Display a list of high point divisions for selection
#

sub combine_list_toplevel {

   if (!Exists($combine_list_window)) {
      $combine_list_window = MainWindow->new(-background  => 'grey',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Select Classes');

      $combine_list_window->Label(-text => "Select The Classes To Combine",
                        -anchor      => 'center',
                        -background  => 'navy',
                        -foreground  => 'yellow',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $combine_names_frame     = $combine_list_window->Frame->pack(-side => 'top', -fill => 'x');
      $combine_names_buttons   = $combine_list_window->Frame(-background => 'black')->pack(-side => 'bottom', -fill => 'x');

      $combine_names_lb = $combine_names_frame->Scrolled("Listbox", -scrollbars => 'oe', -selectmode => 'extended')->pack;

      $combine_names_buttons->Button(-text => "Select", -command => sub { combine_select() } )->pack(-side => "left", -padx => 30, -pady => 10);
      $combine_names_buttons->Button(-text => "Cancel", -command => sub { $combine_list_window->withdraw(); } )->pack(-side => "right", -padx => 30, -pady => 10);

      $combine_list_window->withdraw();
      $combine_list_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $combine_list_window->width()) / 2;
      $y_pos = ($screen_height - $combine_list_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $combine_list_window->geometry("+$x_pos+$y_pos");
   }

}


##################################################################################
##################################################################################
#
#  Display the selected classes and ask for comfirmation
#

sub combine_confirm_toplevel {

   if (!Exists($c_confirm_list_window)) {
      $c_confirm_list_window = MainWindow->new(-background  => 'grey',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Confirm Classes');

      $c_confirm_list_window->Label(-text => "Confirm Selected Classes",
                        -anchor      => 'center',
                        -background  => 'navy',
                        -foreground  => 'yellow',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $c_confirm_names_frame     = $c_confirm_list_window->Frame->pack(-side => 'top', -fill => 'x');
      $c_confirm_names_buttons   = $c_confirm_list_window->Frame(-background => 'black')->pack(-side => 'bottom', -fill => 'x');

      $c_confirm_names_frame->Label(-textvariable => \$confirm_list,
                        -anchor      => 'center',
                        -background  => 'grey',
                        -foreground  => 'red',
                        -borderwidth => '2',
                        -font        => 'System 9 bold',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $c_confirm_names_frame->Label(-text => "The above classes will be combined\nClick OK to combine,\nCancel to abort",
                        -anchor      => 'center',
                        -background  => 'grey',
                        -foreground  => 'navy',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $c_confirm_names_buttons->Button(-text => "OK", -command => sub { select_related() } )->pack(-side => "left", -padx => 30, -pady => 10);
      $c_confirm_names_buttons->Button(-text => "Cancel", -command => sub { $c_confirm_list_window->withdraw(); } )->pack(-side => "right", -padx => 30, -pady => 10);

      $c_confirm_list_window->withdraw();
      $c_confirm_list_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $c_confirm_list_window->width()) / 2;
      $y_pos = ($screen_height - $c_confirm_list_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $c_confirm_list_window->geometry("+$x_pos+$y_pos");
   }

}


##################################################################################
##################################################################################
#
#  Display a list of related classes for new name
#

sub combine_related_toplevel {

   if (!Exists($related_list_window)) {
      $related_list_window = MainWindow->new(-background  => 'grey',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Select Class');

      $related_list_window->Label(-text => "Select The New Class Name",
                        -anchor      => 'center',
                        -background  => 'navy',
                        -foreground  => 'yellow',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $related_names_frame     = $related_list_window->Frame->pack(-side => 'top', -fill => 'x');
      $related_names_buttons   = $related_list_window->Frame(-background => 'black')->pack(-side => 'bottom', -fill => 'x');

      $related_names_lb = $related_names_frame->Scrolled("Listbox", -scrollbars => 'oe', -selectmode => 'single')->pack;

      $related_names_buttons->Button(-text => "Select", -command => sub { combine_classes() } )->pack(-side => "left", -padx => 30, -pady => 10);
      $related_names_buttons->Button(-text => "Cancel", -command => sub { $related_list_window->withdraw(); } )->pack(-side => "right", -padx => 30, -pady => 10);

      $related_names_lb->bind("<Double-Button-1>", \&combine_classes);

      $related_list_window->withdraw();
      $related_list_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $related_list_window->width()) / 2;
      $y_pos = ($screen_height - $related_list_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $related_list_window->geometry("+$x_pos+$y_pos");
   }

}


##################################################################################
##################################################################################
#
#  Display a warning when finished combining
#

sub combine_finished_toplevel {

   if (!Exists($combined_finish_window)) {
      $combined_finish_window = MainWindow->new(-background  => 'grey',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Combine Finished');

      $combined_finish_window->Label(-text => "Combine Classes Finished",
                        -anchor      => 'center',
                        -background  => 'navy',
                        -foreground  => 'yellow',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $c_finish_names_frame     = $combined_finish_window->Frame->pack(-side => 'top', -fill => 'x');
      $c_finish_names_buttons   = $combined_finish_window->Frame(-background => 'black')->pack(-side => 'bottom', -fill => 'x');

      $c_finish_names_frame->Label(-text => "\n  Combining of classes is complete!  \n  Be sure to close and re-open all other  \n  programs that use the class list or entry list!  \n",
                        -anchor      => 'center',
                        -background  => 'grey',
                        -foreground  => 'red',
                        -font        => 'System 9 bold',
                        -borderwidth => '2',
                        -justify     => 'center',
                        -relief      => 'raised') -> pack(-fill => 'x');

      $c_finish_names_buttons->Button(-text => "Ok", -command => sub { $combined_finish_window->withdraw(); } )->pack;

      $combined_finish_window->withdraw();
      $combined_finish_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $combined_finish_window->width()) / 2;
      $y_pos = ($screen_height - $combined_finish_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $combined_finish_window->geometry("+$x_pos+$y_pos");
   }

}


##################################################################################
##################################################################################
#
#  Select Back Number For Report
#

sub change_back_toplevel {

   if (!Exists($change_back_window)) {
      $change_back_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Change Back Number');

      $change_back_window->Label(-textvariable => \$showinfo,
                              -anchor       => 'center',
                              -background   => 'navy',
                              -foreground   => 'yellow',
                              -borderwidth  => '2',
                              -relief       => 'groove',
                              -justify      => 'center')->pack(-side => 'top', fill => 'x');

#
#  From Back Number
#
      $bnw_frame1 = $change_back_window ->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $bnw_frame1->Label(-text         => "From Back Number",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  25,
                         -justify      => 'left')->pack(-side => 'left');
      $frombacknumentry = $bnw_frame1->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 6,
                         -textvariable => \$backnumber) -> pack(-side => 'left');
      $bnw_frame1->Label(-text         => " ",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  5,
                         -justify      => 'left')->pack(-side => 'left');
      $bnw_frame1->Label(-textvariable => \$horsename,
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  25,
                         -justify      => 'left')->pack(-side => 'left');
      $bnw_frame1->Label(-textvariable => \$ridername,
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  25,
                         -justify      => 'left')->pack(-side => 'left');

#
#  To Back Number
#
      $bnw_frame2 = $change_back_window ->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $bnw_frame2->Label(-text        => "To Back Number",
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -width       =>  25,
                         -justify     => 'left')->pack(-side => 'left');
      $tobacknumentry = $bnw_frame2->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 6,
                         -textvariable => \$tobacknumber) -> pack(-side => 'left');

#
#  Buttons
#
      $bnw_frame8 = $change_back_window ->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $bnw_frame8->Button(-text => "Ok", -command => sub { &change_back_number(); })->pack(-side => "left", -padx => 30, -pady => 5);
      $bnw_frame8->Button(-text => "Cancel", -command => sub { $change_back_window->withdraw(); })->pack(-side => "right", -padx => 30, -pady => 5);

      $frombacknumentry->bind("<Return>", \&lookup_existing_back_number);
      $frombacknumentry->bind("<Tab>", \&lookup_existing_back_number);
      $frombacknumentry->bind("<Shift-Tab>", \&lookup_existing_back_number);
      $tobacknumentry->bind("<Return>", \&lookup_toback_number);
      $tobacknumentry->bind("<Tab>", \&lookup_toback_number);
      $tobacknumentry->bind("<Shift-Tab>", \&lookup_toback_number);

      $change_back_window->withdraw();
      $change_back_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $change_back_window->width()) / 2;
      $y_pos = ($screen_height - $change_back_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $change_back_window->geometry("+$x_pos+0");
   }
}


1;

__END__

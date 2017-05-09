##################################################################################
##################################################################################
#
#       Create The Toplevel windows
#

sub create_toplevel {

   &create_message_dialog;
   &display_message("Initializing Horse Show Office Windows - Please Be Patient!", 0, "i");

   &modify_info_toplevel;
   &modify_horse_toplevel;
   &modify_member_toplevel;

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
                     -justify => 'center')
                     ->pack(-side => 'top', -fill => 'both', -expand => 1);
   $msgdialog->withdraw();
}


##################################################################################
##################################################################################
#
#  Create the toplevel window for displaying horse/rider lists
#

sub modify_info_toplevel {

   if (!Exists($modify_info_window)) {
      $modify_info_window = MainWindow->new(-background  => 'black',
                                       -borderwidth => 2,
                                       -relief      => 'raised',
                                       -title       => 'Horse and Rider List');

      $modify_info_window->Label(-text => "Horse/Rider Selector",
                         -anchor       => 'n',
                         -background   => 'navy',
                         -foreground   => 'yellow',
                         -borderwidth  => '0',
                         -justify      => 'center')->pack(-side => 'top', -fill => 'x');


#
#  Main frames
#
      $mod_frame  = $modify_info_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 2,
                             -relief      => 'raised')->
                          pack(-side   => 'top',
                               -fill   => 'both',
                               -expand => 1,
                               -anchor => 'n');
      $miw_frame0 = $mod_frame->
                       Frame(-background  => 'grey',
                             -borderwidth => 2,
                             -relief      => 'raised')->
                          pack(-side   => 'top',
                               -fill   => 'both',
                               -expand => 1,
                               -anchor => 'n');
      $miw_frame1 = $mod_frame->
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

      $miw_frame0->Label(-text        => "Search: ",
                         -anchor      => 'n',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -justify     => 'left')->pack(-side => 'left');
      $sr = $miw_frame0->Entry(-background  => 'white',
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
      $miw_scrollframe = $miw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $miw_lb          = $miw_scrollframe->Scrolled("Listbox", -scrollbars => 'oe', -selectmode => 'single')->pack;

#
#  Buttons
#
      $miw_buttonframe = $miw_frame1->Frame->pack(-side => 'top', -fill => 'x', -expand => 1, -anchor => 's');
      $miw_buttonframe->Button(-text => "Horse", -command => \&fill_horse )->pack(-side => "left", -padx => 5, -pady => 5);
      $miw_buttonframe->Button(-text => "Member", -command => \&fill_member )->pack(-side => "left", -padx => 5, -pady => 5);
      $miw_buttonframe->Button(-text => "Exit", -command => sub { exit; } )->pack(-side => "right", -padx => 5, -pady => 5);

      $sr->bind("<Key>", [ \&search_list, Ev("K") ]);
      $miw_lb->bind("<Double-Button-1>", \&display_current_info);

      $modify_info_window->withdraw();
      $modify_info_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $modify_info_window->width()) / 2;
      $y_pos = ($screen_height - $modify_info_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $modify_info_window->geometry("+0+0");
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
      $mhw_hframe3  = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe4  = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe5  = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe6  = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe7  = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
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
      $mhw_hframe18 = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe19 = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');
      $mhw_hframe20 = $mhw_frame1->Frame->pack(-side => 'top', -fill => 'x');

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
      $mhw_hframe3->Label(-text        => " Sex",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $hs = $mhw_hframe3->Optionmenu(
                         -background => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$horsesex,
                         -options      => [["STALLION", "STALLION"],
                                           ["GELDING",  "GELDING"],
                                           ["MARE",     "MARE"]]) -> pack(-side => 'left');
      $mhw_hframe3->Label(-text        => "    Color",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  10,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe3->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$horsecolor) -> pack(-side => 'left');

      $mhw_hframe4->Label(-text        => " Registration Type",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $ht = $mhw_hframe4->Optionmenu(
                         -background => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$horsetype,
                         -options      => [["# - Regular",                              "#"],
                                           ["T - Tentative",                            "T"],
                                           ["N - Non-Characteristic",                   "N"],
                                           ["CN - Certified Pedigree Option",           "CN"],
                                           ["F - Foundation",                           "F"],
                                           ["BT - Breeding Stock (Tentative)",          "BT"],
                                           ["B# - Breeding Stock (Permanent)",          "B#"],
                                           ["BN - Breeding Stock (Non-Characteristic)", "BN"],
                                           ["ID - Identification System",               "IC"],
                                           ["PC - Pedigree Certificate",                "PC"]]) -> pack(-side => 'left');

      $mhw_hframe5->Label(-text        => " Horse Name",
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
                         -textvariable => \$horsename) -> pack(-side => 'left');
      $mhw_hframe6->Label(-text        => " Sire Name",
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
                         -textvariable => \$horsesire) -> pack(-side => 'left');
      $mhw_hframe7->Label(-text        => " Dam Name",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe7->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 25,
                         -textvariable => \$horsedam) -> pack(-side => 'left');
      $mhw_hframe8->Label(-text        => " Owner ApHC Number",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe8->Entry(-background   => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$ownernum) -> pack(-side => 'left');

      $mhw_hframe9->Label(-text        => " Registration Status",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $os = $mhw_hframe9->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 0,
                         -textvariable => \$ownernumberstatus,
                         -options      => [["CURRENT",    "CURRENT"],
                                           ["PENDING",    "PENDING"],
                                           ["UNKNOWN",    "UNKNOWN"],
                                           ["NOT MEMBER", "NOT MEMBER"]]) -> pack(-side => 'left');
      $mhw_hframe10->Label(-text        => " Club Member",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $ou = $mhw_hframe10->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 0,
                         -textvariable => \$ownermemberstatus,
                         -options      => [["YES", "YES"],
                                           ["NO",  "NO"]]) -> pack(-side => 'left');
      $mhw_hframe11->Label(-text        => " Registration Type",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $ot = $mhw_hframe11->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$ownertype,
                         -options      => [["OPEN          ", "OPEN"],
                                           ["NON PRO       ", "NON PRO"],
                                           ["NOVICE NON PRO", "NOVICE NON PRO"],
                                           ["YOUTH         ", "YOUTH"],
                                           ["NOVICE YOUTH  ", "NOVICE YOUTH"]]) -> pack(-side => 'left');
      $mhw_hframe12->Label(-text       => " Sex",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $ox = $mhw_hframe12->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 0,
                         -textvariable => \$ownersex,
                         -options      => [["FEMALE", "FEMALE"],
                                           ["MALE",   "MALE"]]) -> pack(-side => 'left');
      $mhw_hframe13->Label(-text        => " Birth Year",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe13->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 4,
                         -textvariable => \$owneryear) -> pack(-side => 'left');

      $mhw_hframe14->Label(-text        => " Owner Name",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe14->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 15,
                         -textvariable => \$ownerfirstname) -> pack(-side => 'left');
      $mhw_hframe14->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 25,
                         -textvariable => \$ownerlastname) -> pack(-side => 'left');

      $mhw_hframe15->Label(-text        => " Address",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe15->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$owneraddress) -> pack(-side => 'left');

      $mhw_hframe16->Label(-text       => " City",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe16->Entry(-background => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$ownercity) -> pack(-side => 'left');

      $mhw_hframe17->Label(-text       => " State",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe17->Entry(-background => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 3,
                         -textvariable => \$ownerstate) -> pack(-side => 'left');
      $mhw_hframe17->Label(-text       => "    Zip Code",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  12,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe17->Entry(-background => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$ownerzip) -> pack(-side => 'left');

      $mhw_hframe18->Label(-text        => "Home Phone",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe18->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$ownerhomephone) -> pack(-side => 'left');

      $mhw_hframe19->Label(-text       => "Work Phone",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe19->Entry(-background => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$ownerworkphone) -> pack(-side => 'left');

      $mhw_hframe20->Label(-text       => "Email Address",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mhw_hframe20->Entry(-background => 'white',
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

      $mhw_frame2->Button(-text => "Cancel", -command => sub { exit; })->pack(-side => "right", -padx => 30, -pady => 5);
      $mhw_frame2->Button(-text => "Delete", -command => \&delete_horse_info )->pack(-side => "right", -padx => 30, -pady => 5);
      $mhw_frame2->Button(-text => "Save", -command => \&save_horse_info )->pack(-side => "right", -padx => 90, -pady => 5);

      $hn->bind("<Return>", \&lookup_horse_number);
      $hn->bind("<Tab>", \&lookup_horse_number);
      $hn->bind("<Shift-Tab>", \&lookup_horse_number);

      $modify_horse_window->withdraw();
      $modify_horse_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = $modify_info_window->width()+30;
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
      $mmw_mframe14 = $mmw_frame1->Frame->pack(-side => 'top', -fill => 'x');

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
                         -options      => [["CURRENT",    "CURRENT"],
                                           ["PENDING",    "PENDING"],
                                           ["UNKNOWN",    "UNKNOWN"],
                                           ["NOT MEMBER", "NOT MEMBER"]]) -> pack(-side => 'left');
      $mmw_mframe4->Label(-text        => " Sex",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $rx = $mmw_mframe4->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$ridersex,
                         -options      => [["FEMALE", "FEMALE"],
                                           ["MALE",   "MALE"]]) -> pack(-side => 'left');
      $mmw_mframe5->Label(-text        => " Birth Year",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        => 20,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe5->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 4,
                         -textvariable => \$rideryear) -> pack(-side => 'left');

      $mmw_mframe6->Label(-text        => " Registration Type",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $rt = $mmw_mframe6->Optionmenu(
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -relief       => 'raised',
                         -indicatoron  => 1,
                         -textvariable => \$ridertype,
                         -options      => [["OPEN",           "OPEN"],
                                           ["NON PRO",        "NON PRO"],
                                           ["NOVICE NON PRO", "NOVICE NON PRO"],
                                           ["YOUTH",          "YOUTH"],
                                           ["NOVICE YOUTH",   "NOVICE YOUTH"]]) -> pack(-side => 'left');

      $mmw_mframe7->Label(-text        => " Rider Name (F/L)",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe7->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 15,
                         -textvariable => \$riderfirstname) -> pack(-side => 'left');
      $mmw_mframe7->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 25,
                         -textvariable => \$riderlastname) -> pack(-side => 'left');

      $mmw_mframe8->Label(-text        => " Address",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe8->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$rideraddress) -> pack(-side => 'left');

      $mmw_mframe9->Label(-text        => " City",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe9->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 30,
                         -textvariable => \$ridercity) -> pack(-side => 'left');
      $mmw_mframe10->Label(-text        => " State",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe10->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 3,
                         -textvariable => \$riderstate) -> pack(-side => 'left');
      $mmw_mframe10->Label(-text        => "    Zip Code",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  12,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe10->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 10,
                         -textvariable => \$riderzip) -> pack(-side => 'left');

      $mmw_mframe11->Label(-text        => "Home Phone",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe11->Entry(-background  => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$riderhomephone) -> pack(-side => 'left');
      $mmw_mframe12->Label(-text       => "Work Phone",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe12->Entry(-background => 'white',
                         -foreground   => 'black',
                         -takefocus    => 1,
                         -width        => 14,
                         -textvariable => \$riderworkphone) -> pack(-side => 'left');

      $mmw_mframe13->Label(-text       => "Email Address",
                         -anchor       => 'w',
                         -background   => 'grey',
                         -foreground   => 'navy',
                         -borderwidth  => '0',
                         -width        =>  20,
                         -justify      => 'left')->pack(-side => 'left');
      $mmw_mframe13->Entry(-background => 'white',
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

      $mmw_frame2->Button(-text => "Cancel", -command => sub { exit; })->pack(-side => "right", -padx => 30, -pady => 5);
      $mmw_frame2->Button(-text => "Delete", -command => \&delete_member_info )->pack(-side => "right", -padx => 30, -pady => 5);
      $mmw_frame2->Button(-text => "Save", -command => \&save_member_info )->pack(-side => "right", -padx => 90, -pady => 5);

      $rn->bind("<Return>", \&lookup_rider_number);
      $rn->bind("<Tab>", \&lookup_rider_number);
      $rn->bind("<Shift-Tab>", \&lookup_rider_number);

      $modify_member_window->withdraw();
      $modify_member_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = $modify_info_window->width()+30;
      $y_pos = ($screen_height - $modify_member_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $modify_member_window->geometry("+$x_pos+0");
   }
}


1;

__END__

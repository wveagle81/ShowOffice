##################################################################################
##################################################################################
#
#       Create The Toplevel windows
#

sub create_toplevel {

   &create_message_dialog;
   &display_message("Initializing Horse Show Office Windows - Please Be Patient!", 0, "i");

   &open_show_toplevel;
   &choose_class_toplevel;

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
                                       -title       => 'Choose A Scored Class To Place');

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
      $cc_frame3->Button(-text => "Cancel", -command => sub { exit; })->pack(-side => "right", -padx => 30, -pady => 5);

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
#  Since this is a scored class, the window will contain the list of
#  entries in the class, and boxes for the scores of each judge.
#

sub place_class_toplevel {

   if (!Exists($place_class_window)) {
      $place_class_window = MainWindow->new(-background  => 'black',
                                            -borderwidth => 2,
                                            -relief      => 'raised',
                                            -title       => 'Place A Scored Class');

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
                        pack(-side        => 'top',
                             -fill        => 'x',
                             -expand      => 1,
                             -anchor      => 'n');

      $class_info = "$classnumber - $classname";

      $pcw_frame1->Label(-text        => $class_info,
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '2',
                         -font        => 'arial 14 bold',
                         -width       =>  length($class_info),
                         -justify     => 'center')->pack(-side => 'top');

#
#  Judge Information
#
      $pcw_frame2 = $place_class_window->
                       Frame(-background  => 'grey',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $judgeinfo = "";
      for $judge (0 .. $numjudges-1) {
         $judgeinfo .= substr($shownumber[$judge],4) . " : $judge_list{$judgenumber[$judge]}\n";
      }
#      chomp($judgeinfo);

      $pcw_frame2->Label(-text        => "$judgeinfo",
                         -anchor      => 'n',
                         -background  => 'grey',
                         -foreground  => 'navy',
                         -borderwidth => '0',
                         -relief      => 'groove',
                         -font        => 'arial 10',
                         -width       =>  length($judgeinfo),
                         -justify     => 'center')->pack(-side => 'top');

#
#  Class Placings Header
#
      $pcw_frame3 = $place_class_window->
                       Frame(-background  => 'black',
                             -borderwidth => 1,
                             -relief      => 'raised')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');
      $pcw_frame3->Label(-text        => " CLASS ENTRIES ( $total_class_entries )",
                         -anchor      => 'w',
                         -background  => 'black',
                         -foreground  => 'yellow',
                         -borderwidth => '0',
                         -justify     => 'left',
                         -width       => 55)->pack(-side => 'left');

      for $ii (1 .. $numjudges) {
         $pcw_frame3->Label(-text        => substr($shownumber[($ii-1)],4) . "           ",
                            -anchor      => 'w',
                            -background  => 'black',
                            -foreground  => 'yellow',
                            -borderwidth => '0',
                            -justify     => 'left',
                            )->pack(-side => 'left');
      }

      $back_index = 0;
      $class_index = 0;
      for $back (sort { $a <=> $b } keys %back_list) {

         $pcw_frame[$back_index] = $place_class_window->
                                   Frame(-background  => 'grey',
                                         -borderwidth => 5,
                                         -relief      => 'flat')->
                                      pack(-side   => 'top',
                                           -fill   => 'x',
                                           -expand => 1,
                                           -anchor => 'n');

         $einfo = "$back : $back_list{$back}";
         $pcw_frame[$back_index]->Label(-text => $einfo,
                         -anchor      => 'w',
                         -background  => 'grey',
                         -foreground  => 'black',
                         -borderwidth => '0',
                         -justify     => 'left',
                         -width       => 55)->pack(-side => 'left');

         for $ii (0 .. $numjudges-1) {
            $classentered[$class_index] = $pcw_frame[$back_index]->Entry(-background => 'white',
                               -foreground   => 'black',
                               -takefocus    => 1,
                               -width        => 5,
                               -textvariable => \$classplace{$back_index}[$ii]) -> pack(-side => 'left');

            $pcw_frame[$back_index]->Label(-anchor => 'w',
                               -background   => 'grey',
                               -foreground   => 'navy',
                               -borderwidth  => '0',
                               -width        =>  4,
                               -justify      => 'left')->pack(-side => 'left');
            $class_index++;
         }
         $back_index++;
      }


#
#  Buttons
#

      $pcw_frame9 = $place_class_window->
                       Frame(-background  => 'black',
                             -borderwidth => 5,
                             -relief      => 'flat')->
                          pack(-side   => 'top',
                               -fill   => 'x',
                               -expand => 1,
                               -anchor => 'n');

      $pcw_frame9->Button(-text => "Ok",  -command => sub { $place_class_window->destroy();
                                                            &sort_results })->pack(-side => "left", -padx => 30, -pady => 5);
      $pcw_frame9->Button(-text => "Cancel", -command => sub { $classnumber = "";
                                                               $place_class_window->destroy();
                                                               $choose_class_window->update();
                                                               $choose_class_window->deiconify();
                                                               $choose_class_window->raise(); })->pack(-side => "right", -padx => 30, -pady => 5);

      $place_class_window->withdraw();
      $place_class_window->update();

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $place_class_window->width()) / 2;
      $y_pos = ($screen_height - $place_class_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $place_class_window->geometry("+$x_pos+0");
   }
}


1;

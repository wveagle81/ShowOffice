
##################################################################################
#
#       Create the error message window
#
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
                     ->pack(-side => 'bottom', -expand => 1, -pady => 5);
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
#
#       Create the main window and menu
#
##################################################################################

sub create_main {

   $mw = MainWindow->new(-title => "The Horse Show Office");


##################################################################################
##################################################################################
#
#       Create the welcome label
#

   $mw->Label(-text        => "Welcome to The Horse Show Office!",
              -anchor      => 'center',
              -background  => 'navy',
              -font        => 'system 12',
              -foreground  => 'yellow',
              -borderwidth => '2',
              -justify     => 'center',
              -width       => 80,
              -relief      => 'groove') -> pack;


##################################################################################
##################################################################################
#
#       Create the button box for system program buttons
#

   $frame1      = $mw->Frame(-background => 'black',
                     -borderwidth      => 2,
                     -relief           => 'groove',
                     ) -> pack(-fill => 'x');

   $frame2      = $mw->Frame(-background => 'black',
                     -borderwidth      => 2,
                     -relief           => 'groove',
                     ) -> pack(-fill => 'x');

   $frame3      = $mw->Frame(-background => 'black',
                     -borderwidth      => 2,
                     -relief           => 'groove',
                     ) -> pack(-fill => 'x');

   $frame4      = $mw->Frame(-background => 'black',
                     -borderwidth      => 2,
                     -relief           => 'groove',
                     ) -> pack(-fill => 'x');

   $frame5      = $mw->Frame(-background => 'black',
                     -borderwidth      => 2,
                     -relief           => 'groove',
                     ) -> pack(-fill => 'x');

   $frame6      = $mw->Frame(-background => 'black',
                     -borderwidth      => 2,
                     -relief           => 'groove',
                     ) -> pack(-fill => 'x');

   $frame7      = $mw->Frame(-background => 'black',
                     -borderwidth      => 2,
                     -relief           => 'groove',
                     ) -> pack(-fill => 'x');

   $frame8      = $mw->Frame(-background => 'black',
                     -borderwidth      => 2,
                     -relief           => 'groove',
                     ) -> pack(-fill => 'x');

   $show_b      = $frame1->Button(-text => 'Create and Modify Shows',
                     -activebackground => 'steelblue4',
                     -activeforeground => 'white',
                     -anchor           => 'center',
                     -background       => 'navy',
                     -borderwidth      => 2,
                     -font             => 'system 9',
                     -foreground       => 'yellow',
                     -padx             => 2,
                     -pady             => 2,
                     -relief           => 'raised',
                     -width            => 25,
                     -command          => sub { &create_show(); },
                     )->pack(-side => 'left', -padx => 10, -pady => 5);

   $frame1->Label(-text    => "Create a new show with class lists, high point awards,\ndivision awards, local classes, and more.",
              -anchor      => 'center',
              -background  => 'black',
              -font        => 'system 9',
              -foreground  => 'white',
              -justify     => 'center') -> pack(-pady => 5);

   $entries_b  = $frame2->Button(-text => 'Show Entries',
                     -activebackground => 'steelblue4',
                     -activeforeground => 'white',
                     -anchor           => 'center',
                     -background       => 'navy',
                     -borderwidth      => 2,
                     -font             => 'system 9',
                     -foreground       => 'yellow',
                     -padx             => 2,
                     -pady             => 2,
                     -relief           => 'raised',
                     -width            => 25,
                     -command          => sub { &run_show(); },
                     ) -> pack(-side => 'left', -padx => 10, -pady => 5);

   $frame2->Label(-text    => "Add and scratch show entries, count entries, view\nentry lists, and more.",
              -anchor      => 'center',
              -background  => 'black',
              -font        => 'system 9',
              -foreground  => 'white',
              -justify     => 'center') -> pack(-pady => 5);

   $placings_b  = $frame3->Button(-text => 'Class Placings',
                     -activebackground => 'steelblue4',
                     -activeforeground => 'white',
                     -anchor           => 'center',
                     -background       => 'navy',
                     -borderwidth      => 2,
                     -font             => 'system 9',
                     -foreground       => 'yellow',
                     -padx             => 2,
                     -pady             => 2,
                     -relief           => 'raised',
                     -width            => 25,
                     -command          => sub { &place_show(); },
                     ) -> pack(-side => 'left', -padx => 10, -pady => 5);

   $frame3->Label(-text    => "Place classes, show class entries, and class\nresults",
              -anchor      => 'center',
              -background  => 'black',
              -font        => 'system 9',
              -foreground  => 'white',
              -justify     => 'center') -> pack(-pady => 5);

   $report_b    = $frame4->Button(-text => 'Show Reports',
                     -activebackground => 'steelblue4',
                     -activeforeground => 'white',
                     -anchor           => 'center',
                     -background       => 'navy',
                     -borderwidth      => 2,
                     -font             => 'system 9',
                     -foreground       => 'yellow',
                     -padx             => 2,
                     -pady             => 2,
                     -relief           => 'raised',
                     -width            => 25,
                     -command          => sub { &do_reports(); },
                     ) -> pack(-side => 'left', -padx => 10, -pady => 5);

   $frame4->Label(-text    => "Class lists, high point, gate lists, show results,\nnational class results, and more.",
              -anchor      => 'center',
              -background  => 'black',
              -font        => 'system 9',
              -foreground  => 'white',
              -justify     => 'center') -> pack(-pady => 5);

#   $options_b   = $frame5->Button(-text => 'Setup Preferences',
#                     -activebackground => 'steelblue4',
#                     -activeforeground => 'white',
#                     -anchor           => 'center',
#                     -background       => 'navy',
#                     -borderwidth      => 2,
#                     -font             => 'system 9',
#                     -foreground       => 'yellow',
#                     -padx             => 2,
#                     -pady             => 2,
#                     -relief           => 'raised',
#                     -width            => 25,
#                     -command          => sub { &show_options(); },
#                     ) -> pack(-side => 'left', -padx => 10, -pady => 5);
#
#   $frame5->Label(-text    => "Set up judge lists, local class names, program\nproperties.",
#              -anchor      => 'center',
#              -background  => 'black',
#              -font        => 'system 9',
#              -foreground  => 'white',
#              -justify     => 'center') -> pack(-pady => 5);

   $modify_b   = $frame6->Button(-text => 'Modify Horse/Member Info',
                     -activebackground => 'steelblue4',
                     -activeforeground => 'white',
                     -anchor           => 'center',
                     -background       => 'navy',
                     -borderwidth      => 2,
                     -font             => 'system 9',
                     -foreground       => 'yellow',
                     -padx             => 2,
                     -pady             => 2,
                     -relief           => 'raised',
                     -width            => 25,
                     -command          => sub { &modify_info(); },
                     ) -> pack(-side => 'left', -padx => 10, -pady => 5);

   $frame6->Label(-text    => "Modify horse, member, and owner information.",
              -anchor      => 'center',
              -background  => 'black',
              -font        => 'system 9',
              -foreground  => 'white',
              -justify     => 'center') -> pack(-pady => 5);

   $exit_b      = $frame7->Button(-text => 'Exit Program',
                     -activebackground => 'steelblue4',
                     -activeforeground => 'white',
                     -anchor           => 'center',
                     -background       => 'navy',
                     -borderwidth      => 2,
                     -font             => 'system 9',
                     -foreground       => 'yellow',
                     -padx             => 2,
                     -pady             => 2,
                     -relief           => 'raised',
                     -width            => 25,
                     -command          => sub { exit; },
                     ) -> pack(-side => 'left', -padx => 10, -pady => 5);

   $frame7->Label(-text    => "Exit the program.",
              -anchor      => 'center',
              -background  => 'black',
              -font        => 'system 9',
              -foreground  => 'white',
              -justify     => 'center') -> pack(-pady => 5);

#   $frame9 = $frame8->Frame(-background => 'black',
#                     -borderwidth      => 0,
#                     ) -> pack(-side => 'left', -fill => 'x');

   $sd1 = $frame8->Entry(-textvariable => \$showdateinput,
              -background       => 'steelblue4',
              -takefocus        => 1,
              -font             => 'system 9',
              -foreground       => 'yellow',
              -width            => 10) -> pack(-side => 'top', -pady => 5);

   $frame8->Label(-text    => "Enter the date of the show you want to work with.\nUse the format mm/dd/yyyy.",
              -anchor      => 'center',
              -background  => 'black',
              -font        => 'system 9',
              -foreground  => 'white',
              -justify     => 'center') -> pack(-side => 'bottom', -fill => 'x', -pady => 5);


##################################################################################
##################################################################################
#
#       Create the welcome label
#

   $mw->Label(-textvariable => \$main_window_label,
              -anchor       => 'center',
              -background   => 'black',
              -font         => 'system 12',
              -foreground   => 'white',
              -borderwidth  => '2',
              -justify      => 'center',
              -width        => 80,
              -relief       => 'groove') -> pack(-side => 'bottom');

   $sd1->bind("<Return>", \&check_date_format);
   $sd1->bind("<Tab>", \&check_date_format);
   $sd1->bind("<Shift-Tab>", \&check_date_format);

   $mw->withdraw();
}


##################################################################################
##################################################################################
#
#  Run the subprograms
#

use Win32::Process;

sub create_show() {
   run_program("create_show.exe");
}

sub run_show() {
   run_program("run_show.exe");
}

sub place_show() {
   run_program("place_class.exe");
}

sub do_reports() {
   run_program("reports.exe");
}

sub modify_info() {
   run_program("modify_info.exe");
}

sub run_program() {
   $i = Win32::Process::Create($PObj,
        "$_[0]", # perl path
        "$_[0] $showdate",
        0,
        $Win32::Process::DETACHED_PROCESS
      + $Win32::Process::CREATE_NO_WINDOW,
        ".")|| die "Can not create process : " , Win32::GetLastError(), "\n";
}


1;

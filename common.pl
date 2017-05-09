##################################################################################
#
#       Common Functions
#
##################################################################################


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

      $os_shows_lb = $os_shows_frame->Scrolled("Listbox", -scrollbars => 'oe', -width => 60, -selectmode => 'single')->pack;

      $os_window_buttons->Button(-text => "Select", -command => sub { selected_show() } )->pack(-side => "left", -padx => 30, -pady => 10);
      $os_window_buttons->Button(-text => "Exit", -command => sub { exit; } )->pack(-side => "right", -padx => 30, -pady => 10);

      $open_show_window->withdraw();
      $open_show_window->update();

      $os_shows_lb->bind("<Double-Button-1>", \&selected_show);

      $screen_width = $msgdialog->screenwidth();
      $screen_height = $msgdialog->screenheight();
      $x_pos = ($screen_width - $open_show_window->width()) / 2;
      $y_pos = ($screen_height - $open_show_window->height()) / 2;
      $x_pos =~ s/\..*//;
      $y_pos =~ s/\..*//;

      $open_show_window->geometry("+$x_pos+$y_pos");
   }
}


##################################################################################
##################################################################################
#
#       Display a message to the user.  Takes three arguments:
#
#       1. message text
#       2. number of seconds to display
#       3. flag for type of message (i, e, w)
#          i -> Informational
#          e -> Error
#          w -> Warning
#

sub display_message {
   $msgdialogtext = "\n\n   $_[0]   \n\n";
   $msgdialogtime = $_[1];
   $msgdialogflag = $_[2];

   if ($msgdialogflag eq "i") {
      $msgdialog->messageBox(-default => 'Ok', -icon => 'info', -message => "$msgdialogtext", -title => "Show Information", -type => "Ok");
   } elsif ($msgdialogflag eq "e") {
      $msgdialog->messageBox(-default => 'Ok', -icon => 'error', -message => "$msgdialogtext", -title => "Show Error", -type => "Ok");
   } else {
      $msgdialog->messageBox(-default => 'Ok', -icon => 'error', -message => "$msgdialogtext", -title => "Show Warning", -type => "Ok");
   }

   if ($msgdialogflag eq "i") {
      $back = "navy";
      $fore = "goldenrod";
   } elsif ($msgdialogflag eq "e") {
      $back = "red";
      $fore = "white";
   } else {
      $back = "forest green";
      $fore = "yellow";
   }

   $screen_width = $msgdialog->screenwidth();
   $screen_height = $msgdialog->screenheight();

   $msgdl->configure(-foreground => $fore, -background => $back);
   $msgdialog->update();
   $x_pos = int(($screen_width - $msgdialog->width()) / 2);
   $y_pos = int(($screen_height - $msgdialog->height()) / 2);
   $msgdialog->geometry("+$x_pos+$y_pos");

   $msgdialog->update();
   $msgdialog->deiconify();
   $msgdialog->raise();
   $msgdialog->update();

   if ($msgdialogtime > 0) {
      sleep($msgdialogtime);
      $msgdialog->withdraw();
   }
}


##################################################################################
##################################################################################
#
#       Get the national class number
#

sub get_national_num {
   $class = $_[0];

   my @classes = grep(/^${class}\) /, @show_classes);
   my ($cn, $cname) = split(/\) /, $classes[0]);

   if ($cname =~ /\(NSBA\)/) {
      $cname =~ s/ \(NSBA\)//;
   }

   my @class   = grep(/${cname}/, @class_list);
   my ($natnum, $j) = split(/~/, $class[0]);

   return $natnum;
}


##################################################################################
##################################################################################
#
#       See if a class is an Open class
#

sub is_open_class {
   $class = $_[0];

   $natnum = get_national_num($class);

   if ($natnum =~ /^O/ || $natnum =~ /^A/) { return 1; }
   else { return 0; }
}


##################################################################################
##################################################################################
#
#       See if a class is a NonPro class
#

sub is_nonpro_class {
   $class = $_[0];

print "Checking Class: $class\n";

   $natnum = get_national_num($class);

print "Class Number: $natnum\n";

   if ($natnum =~ /^N/) { return 1; }
   else { return 0; }
}


##################################################################################
##################################################################################
#
#       See if a class is a Youth class
#

sub is_youth_class {
   $class = $_[0];

   $natnum = get_national_num($class);

   if ($natnum =~ /^Y/) { return 1; }
   else { return 0; }
}


##################################################################################
##################################################################################
#
#       See if a class is a Local class
#

sub is_local_class {
   $class = $_[0];

   $natnum = get_national_num($class);

   if ($natnum == "") { return 1; }
   else { return 0; }
}


##################################################################################
##################################################################################
#
#       See if a class is a Leadline class
#

sub is_leadline_class {
   $class = $_[0];

   $natnum = get_national_num($class);

   if ($natnum =~ /Y300/) { return 1; }
   else { return 0; }
}


##################################################################################
##################################################################################
#
#       See if a class is an Open class
#

sub is_open_buckskin_class {
   $class = $_[0];

   my $name = $show_class_list{$class};
print "Name: $name\n";

   if ($name !~ /^Youth/ && $name !~ /^Amateur/ && $name !~ /^Open/ && $class !~ /^S/ ) { return 1; }
   else { return 0; }
}


##################################################################################
##################################################################################
#
#       See if a class is a NonPro class
#

sub is_nonpro_buckskin_class {
   $class = $_[0];

   my $name = $show_class_list{$class};
print "Name: $name\n";

   if ($name =~ /^Amateur/) { return 1; }
   else { return 0; }
}


##################################################################################
##################################################################################
#
#       See if a class is a Youth class
#

sub is_youth_buckskin_class {
   $class = $_[0];

   my $name = $show_class_list{$class};
print "Name: $name\n";

   if ($name =~ /^Youth/) { return 1; }
   else { return 0; }
}


##################################################################################
##################################################################################
#
#       See if a class is a Open Breed class
#

sub is_breed_buckskin_class {
   $class = $_[0];

   my $name = $show_class_list{$class};
print "Name: $name\n";

   if ($name =~ /^Open/) { return 1; }
   else { return 0; }
}


##################################################################################
##################################################################################
#
#       See if a class is a Schooling class
#

sub is_school_buckskin_class {
   $class = $_[0];

   if ($class == "SW" || $class == "SE") { return 1; }
   else { return 0; }
}


##################################################################################
##################################################################################
#
#       See if a person is an Appaloosa Member and return their exp date
#

sub is_member {
   use WWW::Mechanize;

   my $mech = WWW::Mechanize->new();
 
   $url = 'http://www.appaloosa.com/web/mbrverify.aspx';

   $mech->get( $url );

   $mech->submit_form(
       form_name => 'Form1',
       fields    => { txtMemNumA  => $_[0], },
       button    => 'btnEnter'
   );

   @page = split(/\n/, $mech->content());

   for ($ii=0; $ii<=$#page; $ii++) {
      if ($page[$ii] =~ /txtPMBEXP/) {
         @elements = split(/\</, $page[$ii]);
         foreach $part (@elements) {
            if ($part =~ /^font/) {
               (undef, $expdate) = split(/\>/, $part);
            }
         }
      }
   }
   
   return ($expdate);
}


1;

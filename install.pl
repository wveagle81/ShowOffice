#!\perl\bin\perl
#
#  Install the software
#

use Tk;
use File::Copy;

require Tk::TopLevel;
require Tk::Dialog;

if ($^O eq "MSWin32") {
   $dirname = "C:\\HorseShowManager";
} else {
   $dirname = "/usr/local/bin/horseshow";
}
$message = "";

create_main();
create_message();

MainLoop;

exit;


##################################################################################
##################################################################################
#
#       Install the Program
#

sub install() {
   if (! -d "${dirname}") {
      mkdir "${dirname}" or do {
         $message = "\nUnable to create directory ${dirname}\n";
         &display_message;
         exit;
      };
   }

   if (! -d "${dirname}/data") {
      mkdir "${dirname}/data" or do {
         $message = "\nUnable to create directory ${dirname}\\data\n";
         &display_message;
      };
   }
   if (! -d "${dirname}/show") {
      mkdir "${dirname}/show" or do {
         $message = "\nUnable to create directory ${dirname}\\show\n";
         &display_message;
      };
   }
   if (! -d "${dirname}/showresults") {
      mkdir "${dirname}/showshowresults" or do {
         $message = "\nUnable to create directory ${dirname}\\showresults\n";
         &display_message;
      };
   }
   if (! -d "${dirname}/temp") {
      mkdir "${dirname}/temp" or do {
         $message = "\nUnable to create directory ${dirname}\\temp\n";
         &display_message;
      };
   }

   copy("data/appaloosa.class_list.txt", "${dirname}/data/appaloosa.class_list.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\appaloosa.class_list.txt\n";
         &display_message;
      };
   copy("data/appaloosa.division_list.txt", "${dirname}/data/appaloosa.division_list.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\appaloosa.division_list.txt\n";
         &display_message;
      };
   copy("data/appaloosa.grand_gelding_list.txt", "${dirname}/data/appaloosa.grand_gelding_list.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\appaloosa.grand_gelding_list.txt\n";
         &display_message;
      };
   copy("data/appaloosa.grand_mare_list.txt", "${dirname}/data/appaloosa.grand_mare_list.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\appaloosa.grand_mare_list.txt\n";
         &display_message;
      };
   copy("data/appaloosa.grand_stallion_list.txt", "${dirname}/data/appaloosa.grand_stallion_list.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\appaloosa.grand_stallion_list.txt\n";
         &display_message;
      };
   copy("data/appaloosa.high_point_awards.txt", "${dirname}/data/appaloosa.high_point_awards.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\appaloosa.high_point_awards.txt\n";
         &display_message;
      };
   copy("data/empty.txt", "${dirname}/data/appaloosa.horse.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\appaloosa.horse.txt\n";
         &display_message;
      };
   copy("data/empty.txt", "${dirname}/data/appaloosa.member.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\appaloosa.member.txt\n";
         &display_message;
      };
   copy("data/appaloosa.judge_list.txt", "${dirname}/data/appaloosa.judge_list.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\appaloosa.judge_list.txt\n";
         &display_message;
      };
   copy("data/appaloosa.local_class_list.txt", "${dirname}/data/appaloosa.local_class_list.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\appaloosa.local_class_list.txt\n";
         &display_message;
      };
   copy("data/appaloosa.local_points.txt", "${dirname}/data/appaloosa.local_points.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\appaloosa.local_points.txt\n";
         &display_message;
      };
   copy("data/appaloosa.standard_highpoints.txt", "${dirname}/data/appaloosa.standard_highpoints.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\appaloosa.standard_highpoints.txt\n";
         &display_message;
      };
   copy("data/buckskin.class_list.txt", "${dirname}/data/buckskin.class_list.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\buckskin.class_list.txt\n";
         &display_message;
      };
   copy("data/buckskin.division_list.txt", "${dirname}/data/buckskin.division_list.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\buckskin.division_list.txt\n";
         &display_message;
      };
   copy("data/buckskin.grand_gelding_list.txt", "${dirname}/data/buckskin.grand_gelding_list.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\buckskin.grand_gelding_list.txt\n";
         &display_message;
      };
   copy("data/buckskin.grand_mare_list.txt", "${dirname}/data/buckskin.grand_mare_list.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\buckskin.grand_mare_list.txt\n";
         &display_message;
      };
   copy("data/buckskin.grand_stallion_list.txt", "${dirname}/data/buckskin.grand_stallion_list.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\buckskin.grand_stallion_list.txt\n";
         &display_message;
      };
   copy("data/buckskin.high_point_awards.txt", "${dirname}/data/buckskin.high_point_awards.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\buckskin.high_point_awards.txt\n";
         &display_message;
      };
   copy("data/empty.txt", "${dirname}/data/buckskin.horse.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\buckskin.horse.txt\n";
         &display_message;
      };
   copy("data/empty.txt", "${dirname}/data/buckskin.member.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\buckskin.member.txt\n";
         &display_message;
      };
   copy("data/buckskin.judge_list.txt", "${dirname}/data/buckskin.judge_list.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\buckskin.judge_list.txt\n";
         &display_message;
      };
   copy("data/buckskin.local_class_list.txt", "${dirname}/data/buckskin.local_class_list.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\buckskin.local_class_list.txt\n";
         &display_message;
      };
   copy("data/buckskin.local_points.txt", "${dirname}/data/buckskin.local_points.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\buckskin.local_points.txt\n";
         &display_message;
      };
   copy("data/buckskin.standard_highpoints.txt", "${dirname}/data/buckskin.standard_highpoints.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\buckskin.standard_highpoints.txt\n";
         &display_message;
      };
   copy("data/relation.txt", "${dirname}/data/relation.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\\relation.txt\n";
         &display_message;
      };
   copy("data/states.txt", "${dirname}/data/states.txt") or do {
         $message = "\nUnable to copy file ${dirname}\\data\states.txt\n";
         &display_message;
      };
   copy("install.exe", "${dirname}/install.exe") or do {
         $message = "\nUnable to copy run_show.exe\n";
         &display_message;
      };
   copy("show.exe", "${dirname}/show.exe") or do {
         $message = "\nUnable to copy run_show.exe\n";
         &display_message;
      };
   copy("create_show.exe", "${dirname}/create_show.exe") or do {
         $message = "\nUnable to copy run_show.exe\n";
         &display_message;
      };
   copy("modify_info.exe", "${dirname}/modify_info.exe") or do {
         $message = "\nUnable to copy run_show.exe\n";
         &display_message;
      };
   copy("place_class.exe", "${dirname}/place_class.exe") or do {
         $message = "\nUnable to copy run_show.exe\n";
         &display_message;
      };
   copy("reports.exe", "${dirname}/reports.exe") or do {
         $message = "\nUnable to copy run_show.exe\n";
         &display_message;
      };
   copy("run_show.exe", "${dirname}/run_show.exe") or do {
         $message = "\nUnable to copy run_show.exe\n";
         &display_message;
      };
   copy("p2x561.dll", "${dirname}/p2x561.dll") or do {
         $message = "\nUnable to copy p2x561.dll\n";
         &display_message;
      };

   $mw->withdraw();
   $message = "Horse Show Manager\n\nInstall Complete!\n\nThank You";
   &display_message;
}


##################################################################################
##################################################################################
#
#       Create the Main Window
#

sub create_main() {
   $mw = MainWindow->new(-title => "The Horse Show Manager");


   $mw->Label(-text        => "Welcome to The Horse Show Manager!",
              -anchor      => 'center',
              -background  => 'navy',
              -font        => 'system 12',
              -foreground  => 'yellow',
              -borderwidth => '2',
              -justify     => 'center',
              -width       => 50,
              -relief      => 'groove') -> pack;

   $frame1    = $mw->Frame(-background => 'black',
                           -borderwidth      => 0,
                           -relief           => 'groove',
                          ) -> pack(-fill => 'x');

   $frame1->Label(-text        => "\n\nEnter Target Install Directory\n\n",
                  -anchor      => 'w',
                  -background  => 'black',
                  -foreground  => 'white',
                  -font        => 'arial 12',
                  -borderwidth => '0',
                  -justify     => 'center')->pack(-side => 'top');

   $frame2    = $mw->Frame(-background => 'black',
                           -borderwidth      => 0,
                           -relief           => 'groove',
                          ) -> pack(-fill => 'x');

   $frame2->Entry(-background  => 'white',
                  -foreground   => 'black',
                  -takefocus    => 1,
                  -width        => 50,
                  -textvariable => \$dirname) -> pack(-side => 'top');

   $frame3    = $mw->Frame(-background  => 'black',
                           -borderwidth => 5,
                           -relief      => 'flat'
                          ) -> pack(-side   => 'bottom',
                                    -fill   => 'x',
                                    -expand => 1,
                                    -anchor => 'n');

   $frame3->Button(-text => "Install", -command => sub { \&install(); })->pack(-side => "left", -padx => 30, -pady => 10);
   $frame3->Button(-text => "Exit",    -command => sub { exit; })->pack(-side => "right", -padx => 30, -pady => 10);


   $mw->withdraw();
   $mw->update();
   $screen_width  = $mw->screenwidth();
   $screen_height = $mw->screenheight();
   $main_width    = $mw->width();
   $main_x_pos    = int(($screen_width - $main_width) / 2);
   $main_y_pos    = int($screen_height / 2);
   $mw->geometry("+$main_x_pos+$main_y_pos");
   $mw->deiconify();
   $mw->raise();
}


##################################################################################
##################################################################################
#
#       Create the Message Window
#

sub create_message() {
   $mw2 = $mw->Dialog(-title          => "Install Message",
                      -textvariable   => \$message,
                      -buttons        => [ "Exit" ],
                      -default_button => "Exit");
}


##################################################################################
##################################################################################
#
#       Display the Message Window
#

sub display_message() {
   $mw2->Show;
   exit;
}

#!/perl/bin/perl -w
##################################################################################
##################################################################################
#
#       Perl/TK Horse Show Program
#
#  Run Show program:
#
##################################################################################
##################################################################################

use Tk;
require Tk::TopLevel;
require Tk::DialogBox;
require Tk::Optionmenu;

require "common.pl";
require "read_write.pl";
require "lookup.pl";
require "modify_info_toplevel.pl";

$showbreed = "appaloosa";

$year = ((localtime(time))[5]) + 1900;
$main_window_label = "Show Name and Date - $year";

##################################################################################
#
#       Work with entries in the show
#
##################################################################################


&create_toplevel();


##################################################################################
##################################################################################
#
#  Display the window to modify information
#

&open_horse_file;
&open_member_file;

&fill_horse;

$modify_info_window->deiconify();
$modify_info_window->raise();

MainLoop;

exit;


##################################################################################
##################################################################################
#
#  Fill the scrolled list with horse names
#

sub fill_horse {
   $displayed = "horse";
   $search = "";
   $modify_text = " ";
   &open_horse_file;

   $miw_lb->delete(0, 'end');
   $miw_lb->insert('end', sort @hlist);
   $miw_lb->configure(-width => 26);
   $miw_lb->configure(-height => 15);

   $modify_info_window->update();
   $modify_member_window->withdraw();

   $modify_horse_window->deiconify();
   $modify_horse_window->raise();
}


##################################################################################
##################################################################################
#
#  Fill the scrolled list with member names
#

sub fill_member {
   $displayed = "member";
   $search = "";
   $modify_text = " ";
   &open_member_file;

   $miw_lb->delete(0, 'end');
   $miw_lb->insert('end', sort @mlist);
   $miw_lb->configure(-width => 25);
   $miw_lb->configure(-height => 14);

   $modify_info_window->update();
   $modify_horse_window->withdraw();

   $modify_member_window->deiconify();
   $modify_member_window->raise();
}


##################################################################################
##################################################################################
#
#  Look up a horse/member based on the name selected from the list.
#

sub display_current_info {
   my $name = $miw_lb->get($miw_lb->curselection);
   $modify_text = " ";

   if ($displayed eq "horse") {
      my @hn = grep /^.*~~.*~~$name~~/, @horse_list;
      ($horsenum, $horsetype, $horsename, $horsesex, $yearfoaled, $horsecolor, $horsesire, $horsedam, $ownernum) = split(/~~/, $hn[0]);

      ($ownername, $owneraddress, $ownercity, $ownerstate, $ownerzip, $ownerhomephone, $ownerworkphone, $owneremail, $ownersex, $owneryear, $ownertype, $ownernumberstatus) = split(/~~/, $member_list{$ownernum});
      ($ownerlastname, $ownerfirstname) = split(/, /, $ownername);

      $original_horse_num = $horsenum;
      $original_owner_num = $ownernum;
   }
   else {
      my ($rlname, $rfname) = split(/, /, $name);
      my @rn = grep /^.*~~$rlname~~$rfname~~/, @member_list;
      ($ridernum, $riderlastname, $riderfirstname, $rideraddress, $ridercity, $riderstate, $riderzip, $riderhomephone, $riderworkphone, $rideremail, $ridersex, $rideryear, $ridertype, $ridernumberstatus) = split(/~~/, $rn[0]);

      $original_rider_num = $ridernum;
   }

print "Rider Num: $ridernum\nOriginal: $original_rider_num\n";
}


##################################################################################
##################################################################################
#
#  Look up a horse/member based on the search text.
#

sub search_list {
   my ($entry, $key) = @_;
   return if ($key =~ /backspace/i);
   return if ($oldsearch eq $search);

   @list = $miw_lb->get(0, 'end');
   foreach (0 .. $#list) {
      if ($list[$_] =~ /^$search/i) {
         $miw_lb->see($_);
         $miw_lb->selectionClear(0, "end");
         last;
      }
   }
   $oldsearch = $search;
}


1;

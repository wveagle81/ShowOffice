
##################################################################################
##################################################################################
#
#       High Point Report
#

use Data::Dumper;

sub high_point_results {
   &open_showinfo_file($showdir);
   &open_entry_file($showdir);
   &open_member_file($showdir);
   &open_horse_file($showdir);
   &open_report_high_point_file($showdir);

   open (LOG, ">${showdir}/highpoint.log");

   $reporttype = "HIGH POINT RESULTS";

   open(CL, "${showdir}/local_points.txt") or do {
      print "Unable to local point list file\n";
      exit;
   };
   while (<CL>) {
      ($t, @pt) = split(/~~/);
      $local_points{$t} = join(":", @pt);
   }
   close (CL);


#
#  FOR THE SELECTED HIGH POINT DIVISION, COMPUTE THE HIGH POINTS
#

print LOG "Selected Division: $_[0]\n";

   $hp_division = $_[0];
   $hp_type     = $hp_report{$hp_division}[0];
   $hp_required = $hp_report{$hp_division}[1];
   $hpc         = $hp_report{$hp_division}[2];
   $hp_min_age  = $hp_report{$hp_division}[3];
   $hp_max_age  = $hp_report{$hp_division}[4];

print LOG "Type: $hp_type\n";
print LOG "Reqd: $hp_required\n";
print LOG "Min/Max: $hp_min_age/$hp_max_age\n";
print LOG "Classes: $hpc\n";

#      ($hp_division, $hp_type, $hpc) = split(/~~/, $ii);
#      ($hp_division, $hp_min_age, $hp_max_age, $hp_type, $hpc) = split(/~~/, $ii);
   (@hp_classes) = split(/\,/, $hpc);

print LOG "\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n";
print LOG "DIVISION: $hp_division\n";
print LOG "CLASSES : @hp_classes\n\n";
   %by_rider = ();
   %by_horse = ();
   %by_both = ();
   %by_points = ();
   %by_points_key = ();

   open (HTML_REPORT, ">c:/temp/reportfile$$.html") or die "Unable to open temp file: $!";

#   $IE = Win32::OLE->new('InternetExplorer.Application') || die "Could not start Internet Explorer.Application\n";

   &report_header_html;
   &highpoint_header_html;


#
#  FOR EACH CLASS IN THE DIVISION
#

   foreach $hp_class (@hp_classes) {
      chomp($hp_class);
      @total_entries = ();
print LOG "-----------------\n";
print LOG "CLASS   : $hp_class\n";

#
#  GET ENTRIES IN THE CLASS
#

      @cl_entry = grep (/^[a-zA-Z0-9- ]*~~[a-zA-Z0-9- ]*~~[a-zA-Z0-9- ]*~~[a-zA-Z0-9- ]*~~$hp_class~~/, @entry_list);
      @total_entries = (@total_entries, @cl_entry);
      my $total = (scalar(@total_entries) > scalar(keys %local_points)) ? keys %local_points : @total_entries;
      my (@local) = split(/:/, $local_points{$total});

print LOG "ENTRIES : $total : ", scalar(@total_entries), " (real)\n";
print LOG "POINTS  : $local_points{$total}\n";
foreach (@total_entries) {
   print LOG "$_\n";
}


#
#  FOR EACH ENTRY IN THE CLASS
#

      foreach (@total_entries) {
         $n_firsts = $n_seconds = $n_thirds = $n_points = $n_beat = 0;
         ($b, $h, $r, $rel, $c, $p1, $t1, $po1, $p2, $t2, $po2, $p3, $t3, $po3, $p4, $t4, $po4) = split(/~~/);

#
#  FIRST, CHECK THE AGE OF THE RIDER IF THE
#  HIGH POINT DIVISION HAS AN AGE REQUIREMENT
#

         if (($hp_min_age >= 0) || ($hp_max_age >= 0)) {
            ($j, $j, $j, $j, $j, $j, $j, $j, $j, $birthyear, $j, $j) = split(/~~/, $member_list{$r});
#print LOG "INFO: $member_list{$r}\n";
#ROBERTS, KIRSTEN~~3546 PR 2562~~ROYSE CITY~~TX~~75189~~972-636-2189~~~~~~FEMALE~~1994~~NOVICE YOUTH~~CURRENT
#
print LOG "RIDER HAS NO BIRTH YEAR\n" if (! $birthyear);
            if ($birthyear) {
               $age = $year - $birthyear - 1;
print LOG "MIN AGE: $hp_min_age\n";
print LOG "MAX AGE: $hp_max_age\n";
print LOG "CHECKING: $r\tYEAR: $birthyear\tAGE: $age\n";
               next if (($age < $hp_min_age) || ($age > $hp_max_age));
            }
         }

		 # Judge 1
         $n_firsts++  if (($p1) && ($p1 == 1));
         $n_seconds++ if (($p1) && ($p1 == 2));
         $n_thirds++  if (($p1) && ($p1 == 3));
         $n_points += $local[$p1-1] if ($p1);
         $n_beat   += (scalar(@total_entries) - $p1) if ($p1);
print LOG "Judge 1 - Total: " . scalar(@total_entries) . " - Place: $p1 - Points: $n_points - Beat: $n_beat\n";
		 # Judge 2
         $n_firsts++  if (($p2) && ($p2 == 1));
         $n_seconds++ if (($p2) && ($p2 == 2));
         $n_thirds++  if (($p2) && ($p2 == 3));
         $n_points += $local[$p2-1] if ($p2);
         $n_beat   += (scalar(@total_entries) - $p2) if ($p2);
print LOG "Judge 2 - Total: " . scalar(@total_entries) . " - Place: $p2 - Points: $n_points - Beat: $n_beat\n";
		 # Judge 3
         $n_firsts++  if (($p3) && ($p3 == 1));
         $n_seconds++ if (($p3) && ($p3 == 2));
         $n_thirds++  if (($p3) && ($p3 == 3));
         $n_points += $local[$p3-1] if ($p3);
         $n_beat   += (scalar(@total_entries) - $p3) if ($p3);
print LOG "Judge 3 - Total: " . scalar(@total_entries) . " - Place: $p3 - Points: $n_points - Beat: $n_beat\n";
		 # Judge 4
         $n_firsts++  if (($p4) && ($p4 == 1));
         $n_seconds++ if (($p4) && ($p4 == 2));
         $n_thirds++  if (($p4) && ($p4 == 3));
         $n_points += $local[$p4-1] if ($p4);
         $n_beat   += (scalar(@total_entries) - $p4) if ($p4);
print LOG "Judge 4 - Total: " . scalar(@total_entries) . " - Place: $p4 - Points: $n_points - Beat: $n_beat\n";

         if (defined($by_rider{$r})) {
print LOG "By Rider: $r\n";
print LOG "Points: $n_points\n";
            $by_rider{$r}[0] ++;
            $by_rider{$r}[1] += $n_points;
            $by_rider{$r}[2] += $n_firsts;
            $by_rider{$r}[3] += $n_seconds;
            $by_rider{$r}[4] += $n_thirds;
            $by_rider{$r}[5] += $n_beat;
         } else {
print LOG "By Rider: $r\n";
print LOG "Points: $n_points\n";
            $by_rider{$r}[0] = 1;
            $by_rider{$r}[1] = $n_points;
            $by_rider{$r}[2] = $n_firsts;
            $by_rider{$r}[3] = $n_seconds;
            $by_rider{$r}[4] = $n_thirds;
            $by_rider{$r}[5] += $n_beat;
         }

         if (defined($by_horse{$h})) {
print LOG "By Horse: $h\n";
print LOG "Points: $n_points\n";
            $by_horse{$h}[0] ++;
            $by_horse{$h}[1] += $n_points;
            $by_horse{$h}[2] += $n_firsts;
            $by_horse{$h}[3] += $n_seconds;
            $by_horse{$h}[4] += $n_thirds;
            $by_horse{$h}[5] += $n_beat;
         } else {
print LOG "By Horse: $h\n";
print LOG "Points: $n_points\n";
            $by_horse{$h}[0] = 1;
            $by_horse{$h}[1] = $n_points;
            $by_horse{$h}[2] = $n_firsts;
            $by_horse{$h}[3] = $n_seconds;
            $by_horse{$h}[4] = $n_thirds;
            $by_horse{$h}[5] += $n_beat;
         }

         $pk = "${r}~${hp_class}";
         if (defined($by_points_key{$pk})) {
print LOG "By Points: $pk\n";
print LOG "Rider is already pointed in this class.\n";
print LOG "Existing Points: $by_points_key{$pk}[1]\n";
print LOG "New Points     : $n_points\n";
			if ($by_points_key{$pk}[1] < $n_points) {
				$by_points_key{$pk}[0] = 1;
				$by_points_key{$pk}[1] = $n_points;
				$by_points_key{$pk}[2] = $n_firsts;
				$by_points_key{$pk}[3] = $n_seconds;
				$by_points_key{$pk}[4] = $n_thirds;
				$by_points_key{$pk}[5] = $n_beat;
			}
         } else {
print LOG "By Points: $pk\n";
print LOG "Points: $n_points\n";
            $by_points_key{$pk}[0] = 1;
            $by_points_key{$pk}[1] = $n_points;
            $by_points_key{$pk}[2] = $n_firsts;
            $by_points_key{$pk}[3] = $n_seconds;
            $by_points_key{$pk}[4] = $n_thirds;
            $by_points_key{$pk}[5] += $n_beat;
         }

         $k = "${r}~${h}";
         if (defined($by_both{$k})) {
print LOG "By Both: $k\n";
print LOG "Points: $n_points\n";
            $by_both{$k}[0] ++;
            $by_both{$k}[1] += $n_points;
            $by_both{$k}[2] += $n_firsts;
            $by_both{$k}[3] += $n_seconds;
            $by_both{$k}[4] += $n_thirds;
            $by_both{$k}[5] += $n_beat;
         } else {
print LOG "By Both: $k\t";
print LOG "Points: $n_points\n";
            $by_both{$k}[0] = 1;
            $by_both{$k}[1] = $n_points;
            $by_both{$k}[2] = $n_firsts;
            $by_both{$k}[3] = $n_seconds;
            $by_both{$k}[4] = $n_thirds;
            $by_both{$k}[5] += $n_beat;
         }
      }
   }

   if ($hp_type eq "P") {
      foreach $key (keys %by_points_key) {
	     ($r) = split(/~/, $key);
         $by_points{$r}[0] += $by_points_key{$key}[0];
         $by_points{$r}[1] += $by_points_key{$key}[1];
         $by_points{$r}[2] += $by_points_key{$key}[2];
         $by_points{$r}[3] += $by_points_key{$key}[3];
         $by_points{$r}[4] += $by_points_key{$key}[4];
         $by_points{$r}[5] += $by_points_key{$key}[5];
      }
   }
   
   print LOG Dumper(%by_points_key);
   print LOG Dumper(%by_points);
   
#
#  Place the resulting data into an array
#
   @hp_data = ();
   if ($hp_type eq "R") {
      foreach $key (sort keys %by_rider) {
print LOG "By rider: $hp_required ... $by_rider{$key}[0]\n";
         next if ($by_rider{$key}[0] < $hp_required);
         $hp_sorter = ($by_rider{$key}[1]+10) * 100000;
         $hp_sorter += ($by_rider{$key}[2]*10000) + ($by_rider{$key}[3]*1000) + ($by_rider{$key}[4]*100) + ($by_rider{$key}[0]*10);
         $ii = $hp_sorter ."~~". $by_rider{$key}[1] ."~~". $by_rider{$key}[2] ."~~". $by_rider{$key}[3] ."~~". $by_rider{$key}[4] ."~~". $by_rider{$key}[5] ."~~". $by_rider{$key}[0] ."~~". $key;
print LOG "INTO R: $ii\n";
         push(@hp_data, $ii);
      }
   } elsif ($hp_type eq "H") {
      foreach $key (sort keys %by_horse) {
print LOG "By horse: $hp_required ... $by_horse{$key}[0]\n";
         next if ($by_horse{$key}[0] < $hp_required);
         $hp_sorter = ($by_horse{$key}[1]+10) * 100000;
         $hp_sorter += ($by_horse{$key}[2]*10000) + ($by_horse{$key}[3]*1000) + ($by_horse{$key}[4]*100) + ($by_horse{$key}[0]*10);
         $ii = $hp_sorter ."~~". $by_horse{$key}[1] ."~~". $by_horse{$key}[2] ."~~". $by_horse{$key}[3] ."~~". $by_horse{$key}[4] ."~~". $by_horse{$key}[5] ."~~". $by_horse{$key}[0] ."~~". $key;
print LOG "INTO H: $ii\n";
         push(@hp_data, $ii);
      }
   } elsif ($hp_type eq "B") {
      foreach $key (sort keys %by_both) {
print LOG "By both: $hp_required ... $by_both{$key}[0]\n";
         next if ($by_both{$key}[0] < $hp_required);
         $hp_sorter = ($by_both{$key}[1]+10) * 100000;
         $hp_sorter += ($by_both{$key}[2]*10000) + ($by_both{$key}[3]*1000) + ($by_both{$key}[4]*100) + ($by_both{$key}[0]*10);
         $ii = $hp_sorter ."~~". $by_both{$key}[1] ."~~". $by_both{$key}[2] ."~~". $by_both{$key}[3] ."~~". $by_both{$key}[4] ."~~". $by_both{$key}[5] ."~~". $by_both{$key}[0] ."~~". $key;
print LOG "INTO B: $ii\n";
         push(@hp_data, $ii);
      }
   } elsif ($hp_type eq "P") {
      foreach $key (sort keys %by_points) {
print LOG "By points: $hp_required ... $by_points{$key}[0]\n";
         next if ($by_points{$key}[0] < $hp_required);
         $hp_sorter = ($by_points{$key}[1]+10) * 100000;
         $hp_sorter += ($by_points{$key}[2]*10000) + ($by_points{$key}[3]*1000) + ($by_points{$key}[4]*100) + ($by_points{$key}[0]*10);
         $ii = $hp_sorter ."~~". $by_points{$key}[1] ."~~". $by_points{$key}[2] ."~~". $by_points{$key}[3] ."~~". $by_points{$key}[4] ."~~". $by_points{$key}[5] ."~~". $by_points{$key}[0] ."~~". $key;
print LOG "INTO B: $ii\n";
         push(@hp_data, $ii);
      }
   }

   foreach $ii (sort { $b <=> $a } @hp_data) {
print LOG "HP DATA: $ii\n";
      ($hp_sorter, $hp_points, $hp_firsts, $hp_seconds, $hp_thirds, $hp_beat, $hp_numclasses, $hp_num) = split(/~~/, $ii);
      if ($hp_type eq "R") {
         ($hp_name, $j, $j, $j, $j, $j, $j, $j, $j, $birthyear, $j, $j) = split(/~~/, $member_list{$hp_num});
         $hp_name = $hp_name . " **" if (! $birthyear);
      } elsif ($hp_type eq "H") {
#         ($ht, $hms, $hp_name) = split(/~~/, $horse_list{$hp_num});
         ($ht, $hp_name) = split(/~~/, $horse_list{$hp_num});
      } elsif ($hp_type eq "B") {
         ($hp_num1, $hp_num2) = split(/~/, $hp_num);
         ($hpm) = split(/~~/, $member_list{$hp_num1});
         ($hpt, $hph) = split(/~~/, $horse_list{$hp_num2});
         $hp_name = "${hpm} / ${hph}";
      } elsif ($hp_type eq "P") {
         ($hp_name, $j, $j, $j, $j, $j, $j, $j, $j, $birthyear, $j, $j) = split(/~~/, $member_list{$hp_num});
         $hp_name = $hp_name . " **" if (! $birthyear);
      }
print LOG "Writing $reporttype to file\n";

      &highpoint_list_html;
   }

   &report_footer_html();

   close (HTML_REPORT);

#   $IE->{visible} = 1;
#   $IE->Navigate("file:///${cwd}/temp/reportfile$$.html");
   display_webpage("file://c:/temp/reportfile$$.html");
}


1;

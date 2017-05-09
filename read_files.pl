##################################################################################
#
#       Common Read File Functions
#
##################################################################################


##################################################################################
##################################################################################
#
#       Open the JUDGE file
#

sub open_judge_file {
   open(JL, "data/judge_list.txt") or do {
      print "Unable to open judge list file\n";
      exit;
   };
   chomp(@judge_list = <JL>);
   close (JL);

   foreach $ii (@judge_list) {
      ($judgenum, $jname) = split(/~~/, $ii);
      @judgename = split(/ /, $jname);
      @rjname = reverse @judgename;
      $jname = $rjname[0] .", ". $rjname[1];
      $jname = $rjname[0] .", ". $rjname[2] ." ". $rjname[1] if ($rjname[2]);
      $judge_list{$judgenum} = $jname;
      $judge_name{$jname} = $judgenum;
   }
}


##################################################################################
##################################################################################
#
#       Open the NATIONAL CLASS LIST file
#

sub open_national_class_file {
   open(CL, "data/class_list.txt") or do {
      print "Unable to open class list file\n";
      exit;
   };
   chomp(@class_list = <CL>);
   close (CL);
}


##################################################################################
##################################################################################
#
#       Open the DIVISION LIST file
#

sub open_division_file {
   open(CL, "data/division_list.txt") or do {
      print "Unable to open division list file\n";
      exit;
   };
   chomp(@division_list = <CL>);
   close (CL);
}


##################################################################################
##################################################################################
#
#       Open the LOCAL CLASS LIST file
#

sub open_local_class_file {
   open(CL, "data/${showbreed}.local_class_list.txt") or do {
      print "Unable to open local class list file\n";
      exit;
   };
   chomp(@local_class_list = <CL>);
   close (CL);
}


##################################################################################
##################################################################################
#
#       Open the HIGH POINT LIST file
#

sub open_high_point_file {
   open(CL, "data/${showbreed}.high_point_awards.txt") or do {
      print "Unable to open high point list file\n";
      exit;
   };
   chomp(@high_point_list = <CL>);
   close (CL);
}


##################################################################################
##################################################################################
#
#       Open the LOCAL POINT file
#

sub open_local_point_file {
   my $showdir = $_[0];

   open(CL, "${showdir}/local_points.txt") or do {
      print "Unable to local point list file\n";
      exit;
   };
   while (<CL>) {
      chomp;
      ($t, @pt) = split(/~~/);
      foreach $ii (0 .. $#pt) {
         $local_points{$t}[$ii] = $pt[$ii];
      }
   }
   close (CL);
}


##################################################################################
##################################################################################
#
#       Open the SHOW HIGH POINT LIST file
#

sub open_show_high_point_file {
   my $showdir = $_[0];
   my ($division, $type, $classes, @cls, @sc, $cls, $n, $c);

   %hp = ();
   open(CL, "${showdir}/high_point.txt") or do {
      print "Unable to open high point text file\n";
      exit;
   };

   while (<CL>) {
      my ($division, $type, $classes) = split(/~~/, $_, 3);
      chomp($classes);
      $hp{$division}[0] = $type;
      $hp{$division}[1] = $classes;
#      (@cls) = split(/,/, $classes);
#      foreach $cls (sort @cls) {
#         @sc = grep(/$cls/, @show_classes);
#         ($n, $c) = split(/\) /, $sc[0]);
#         $hp{$division}[1] .= "${c}~~";
#      }
      chop($highpoint{$division}[1]);
print "DIVISION: $division   TYPE: $type   CLASSES: $hp{$division}[1]\n";
   }
   close (CL);
}


##################################################################################
##################################################################################
#
#       Open the MEMBER file
#

sub open_member_file {
   %member_list = ();
   @mlist = ();
   open(ML, "data/member.txt") or do {
      print "Unable to open member list file\n";
      exit;
   };
   chomp(@member_list = <ML>);
   close (ML);

   foreach $ii (@member_list) {
      ($mnum, $mstat, $lname, $fname, $rest) = split(/~~/, $ii, 5);
      $name = "${lname}, ${fname}";
      $member_list{$mnum} = "${name}~~${rest}";
      push(@mlist, $name);
   }
}


##################################################################################
##################################################################################
#
#       Open the HORSE file
#

sub open_horse_file {
   %horse_list = ();
   @hlist = ();
   open(HL, "data/horse.txt") or do {
      print "Unable to open horse list file\n";
      exit;
   };
   chomp(@horse_list = <HL>);
   close(HL);

   foreach $ii (@horse_list) {
      ($hnum, $htype, $name, $rest) = split(/~~/, $ii, 4);
      $horse_list{$hnum} = "${htype}~~${name}~~${rest}";
      push(@hlist, "$name");
   }
}


##################################################################################
##################################################################################
#
#       Open the SHOW INFO, CLASSES, LOCAL POINT, and HIGHPOINT files
#

sub open_showinfo_file {
   my $showdir = $_[0];

   open(SF, "$showdir/showinfo.txt") or do {
      print "Unable to open show file: $!";
      exit;
   };
   chomp($openshowdata = <SF>);
   close(SF);

   open(SF, "$showdir/classes.txt") or do {
      print "Unable to open show classes file: $!";
      exit;
   };
   chomp(@show_classes = <SF>);
   close(SF);

   foreach $ii (@show_classes) {
      ($mnum, $rest) = split(/\) /, $ii, 2);
      $show_class_list{$mnum} = $rest;
   }

   &open_local_point_file($showdir);

#   open(SF, "$showdir/high_point.txt") or do {
#      print "Unable to open show high points file: $!";
#      exit;
#   };
#   chomp(@highpoints = <SF>);
#   close(SF);
}


##################################################################################
##################################################################################
#
#       Open the ENTRY file
#

sub open_entry_file {
   my $showdir = $_[0];

   open(EL, "$showdir/entry.txt") or do {
      print "Unable to open entry file: $!";
      exit;
   };
   chomp(@entry_list = <EL>);
   close(EL);

   $entry_count=0;
   %entries = ();
   foreach $ii (@entry_list) {
      my ($b, $h, $r, $rl, $c, $j) = split(/~~/, $ii);
      push (@{$entries{$c}}, $ii);
      $entry_count++ if ($c !~ /^G/);
   }
print "Entry: $entry_count\n";
}


1;

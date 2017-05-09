#!/perl/bin/perl
#
#	Modify the class list file to add horse and rider ages
#

##################################################################################
##################################################################################
#
#       Open the NATIONAL CLASS LIST file
#

open(CL, "data/class_list.txt") or do {
   print "Unable to open class list file\n";
   exit;
};
chomp(@class_list = <CL>);
close (CL);


open(CL2, ">data/class_list_age.txt") or do {
   print "Unable to open class list file\n";
   exit;
};

foreach $ii (@class_list) {
   ($id, $name) = split(/\~/, $ii);

   print "Class: $id	Name: $name\n";
   $line = "${id}~${name}~~0~99~0~999~Y~1";
   if ($name =~ /Weanling/) {
      $line = "${id}~${name}~~0~0~0~999~Y~1";
   }
   if ($name =~ /Yearling/) {
      $line = "${id}~${name}~~1~1~0~999~Y~1";
   }
   if ($name =~ /Two Year/) {
      $line = "${id}~${name}~~2~2~0~999~Y~1";
   }
   if ($name =~ /Three Year/) {
      $line = "${id}~${name}~~3~3~0~999~Y~1";
   }
   if ($name =~ /Aged/) {
      $line = "${id}~${name}~~4~99~0~999~Y~1";
   }
   if ($name =~ /Junior/) {
      $line = "${id}~${name}~~0~5~0~999~Y~1";
   }
   if ($name =~ /Senior/) {
      $line = "${id}~${name}~~6~99~0~999~Y~1";
   }
   if ($name =~ /35/) {
      $line = "${id}~${name}~~0~99~35~999~Y~1";
   }
   if ($name =~ /Master/) {
      $line = "${id}~${name}~~0~99~50~999~Y~1";
   }
   if ($name =~ /18 & Under/) {
      $line = "${id}~${name}~~0~99~0~18~Y~1";
   }
   if ($name =~ /12 & Under/) {
      $line = "${id}~${name}~~0~99~0~12~Y~1";
   }
   if ($name =~ /13 & Under/) {
      $line = "${id}~${name}~~0~99~0~13~Y~1";
   }
   if ($name =~ /13 - 15/) {
      $line = "${id}~${name}~~0~99~13~15~Y~1";
   }
   if ($name =~ /16 - 18/) {
      $line = "${id}~${name}~~0~99~16~18~Y~1";
   }
   if ($name =~ /14 - 18/) {
      $line = "${id}~${name}~~0~99~14~18~Y~1";
   }
   if ($name =~ /W\/T/) {
      $line = "${id}~${name}~~0~99~0~10~Y~1";
   }
   if ($name =~ /Leadline/) {
      $line = "${id}~${name}~~0~99~0~6~Y~1";
   }

   print CL2 "$line\n";
}

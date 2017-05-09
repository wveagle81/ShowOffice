#!/perl/bin/perl
#
#	Evaluate the member information file
#

open (M, "data/member.txt") or die "Unable to open member file: $!";
open (LOG, "> member.log");

foreach (<M>) {
   chomp;
   ($ridernum, $riderlastname, $riderfirstname, $rideraddress, 
   $ridercity, $riderstate, $riderzip, $riderhomephone, 
   $riderworkphone, $rideremail, $ridersex, $rideryear, 
   $regtype, $ridernumberstatus) = split(/~~/);
   write LOG;
}
close LOG;
close M;


format LOG =
NUM     NAME                               ADDRESS
------- ---------------------------------- ------------------------------
@###### @<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$ridernum, $riderfirstname, $riderlastname, $rideraddress
PHONE: @<<<<<<<<<<<<<<                     @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
       $riderhomephone,                    $ridercity
       @<<<<<<<<<<<<<<                     @<<<<< @<<<<<<<<<<<<<<<
       $riderworkphone,                    $riderstate, $riderzip
EMAIL: @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< SEX: @<<<<< BIRTHYEAR: @###
       $rideremail,                        $ridersex,  $rideryear
REG TYPE: @<<<<<<<<<<<<<<                  REG STATUS: @<<<<<<<<<<<<<<
       $regtype,                           $ridernumberstatus

.

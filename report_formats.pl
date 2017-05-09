######################################################################################
######################################################################################
#
#  MEMBER LIST FORMATS
#

format MEMBERLIST_TOP =
@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| @<<<<<<<<<
$showinfo, $reportdate
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$reporttype

Reg Num Member Name               Address                        Phone Number   Expiration
------- ------------------------- ------------------------------ -------------- ---------- 
.

format MEMBERLIST =
@<<<<<< @<<<<<<<<<<<<<<<<<<<<<<<< ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<< @<<<<<<<<<<<<< @<<<<<<<<<
$regnum, $name, $address, $riderphone, $riderexpdate
~~                                ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$address
.


######################################################################################
######################################################################################
#
#  HORSE LIST FORMATS
#

format HORSELIST_TOP =
@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| @<<<<<<<<<
$showinfo, $reportdate
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$reporttype

Reg Num Horse Name           Foaled / Color / Sex      Sire / Dam
------- -------------------- ------------------------- -------------------
.

format HORSELIST =
@<<<<<< @<<<<<<<<<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<
$regnum, $name, $data, $sire
                                                       @<<<<<<<<<<<<<<<<<<
$dam
.


######################################################################################
######################################################################################
#
#  CLASS LIST FORMATS
#

#
#  List of Classes
#
format CLASSLIST_TOP =
@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| @<<<<<<<<<
$showinfo, $reportdate
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$reporttype

Class Num  Class Name
---------  ------------------------------------------------------------------
.

format CLASSLIST =
@>>>>>>>>  @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$classnum, $classname
.


#
#  Local Back Number Report
#
format BACKLIST_TOP =
@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| @<<<<<<<<<
$showinfo, $reportdate
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$reporttype

Back #  Horse Name            Exhibitor Name             Classes Entered
------  --------------------  -------------------------  ----------------------
.

format BACKLIST =
@#####  @<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<<<<<<<  ^<<<<<<<<<<<<<<<<<<<<<
$backnum, $horsename, $ridername, $classes
~~                                                       ^<<<<<<<<<<<<<<<<<<<<<
$classes
.


#
#  National Back Number Report
#
format NATIONAL_BACKLIST_TOP =
@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| @<<<<<<<<<
$showinfo, $reportdate
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$reporttype

Back Horse/Reg #/Foal Yr  Exhibitor/Reg #         Owner/Reg #         Relation
---- -------------------- ----------------------- ------------------- ---------
.

format NATIONAL_BACKLIST =
@### ^<<<<<<<<<<<<<<<<<<< ^<<<<<<<<<<<<<<<<<<<<<< ^<<<<<<<<<<<<<<<<<< @<<<<<<<
$backnum, $horseinfo, $riderinfo, $ownerinfo, $relation
~~   ^<<<<<<<<<<<<<<<<<<< ^<<<<<<<<<<<<<<<<<<<<<< ^<<<<<<<<<<<<<<<<<<
$horseinfo, $riderinfo, $ownerinfo
.


#
#  List of Classes With Entry Count
#
format CLASSLISTENTRIES_TOP =
@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| @<<<<<<<<<
$showinfo, $reportdate
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$reporttype

Total Entries for This Show: @####
$entry_count

Report Printed At: @<<<<<<<<<<
$reporttime

Entries  Class Num  Class Name
-------  ---------  ---------------------------------------------------------
.

format CLASSLISTENTRIES =
@######  @>>>>>>>>  @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$entries, $classnum, $classname
.


#
#  List of Classes With Entry Count and Division Totals
#
format DIVENTRIES_TOP =
@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| @<<<<<<<<<
$showinfo, $reportdate
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$reporttype

Total Entries for This Show: @####
$entry_count

Entries  Open NonPro Youth  Class Num  Class Name
-------  ---- ------ -----  ---------  ----------------------------------------
.

format DIVENTRIES =
@######  @### @##### @####  @>>>>>>>>  @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$entries, $open_entries, $nonpro_entries, $youth_entries, $classnum, $classname
.


#
#  Class Entries
#
format CLASSENTRIES_TOP =
@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| @<<<<<<<<<
$showinfo, $reportdate
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$reporttype

@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<     @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$judgeinfo1, $judgeinfo2
@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<     @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$judgeinfo3, $judgeinfo4

Class: @<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<        Entries: @##
$classnumber, $classname, $total_class_entries

 J1  J2  J3  J4  Back #  Horse Name            Exhibitor Name
---------------  ------  --------------------  ------------------------------
.

format CLASSENTRIES =
@<<<<<<<<<<<<<<  @#####  @<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$place, $backnumber, $horsename, $ridername
.


#
#  Class Entries For Back #
#
format INDIVIDUAL_TOP =
@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| @<<<<<<<<<
$showinfo, $reportdate
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$reporttype

HORSE : @<<<<<<<<<<<<<<<<<<<<          EXHIBITOR: @<<<<<<<<<<<<<<<<<<<<<<<<
$horsename, $ridername

CLASS NUMBER AND NAME
------------------------------------------------------------------------------
.

format INDIVIDUAL =
 @>>  @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$classnumber, $classname
.


######################################################################################
######################################################################################
#
#  FINAL SHOW REPORTS
#


#
#  Point Sheet For Back #
#
format POINTSHEET_TOP =
@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| @<<<<<<<<<
$showinfo, $reportdate
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$reporttype

HORSE : @<<<<<<<<<<<<<<<<<<<<          EXHIBITOR: @<<<<<<<<<<<<<<<<<<<<<<<<
$horsename, $ridername

@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<     @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$judgeinfo1, $judgeinfo2
@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<     @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$judgeinfo3, $judgeinfo4

                                                            SHOW# PLACE POINTS
------------------------------------------------------------------------------
.

format POINTSHEET =
^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<
$classinfo, $placing_info1
NUMBER OF ENTRIES IN THIS CLASS : @<<<<<                    @<<<<<<<<<<<<<<<<<<
$total_entries, $placing_info2
NATIONAL POINTS FOR THIS CLASS  : @<<<<<                    @<<<<<<<<<<<<<<<<<<
$national_points, $placing_info3
TOTAL NATIONAL PTS FOR THIS SHOW: @<<<<<                    @<<<<<<<<<<<<<<<<<<
$total_points, $placing_info4


.


#
#  Youth and Non-Pro High Point Report
#
format HIGHPOINT_TOP =
@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| @<<<<<<<<<
$showinfo, $reportdate
                 HIGH POINT RESULTS - @<<<<<<<<<<<<<<<<<<<<<<<<<<
$hp_division

REQUIRED TO SHOW IN @## CLASSES TO QUALIFY
$hp_required

EXHIBITOR/HORSE                              #CLASSES  1ST  2ND  3RD  BEAT  POINTS
----------------------------------------------------------------------------------
.

format HIGHPOINT =
@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  @######   @##  @##  @##  @###   @###.#
$hp_name, $hp_numclasses, $hp_firsts, $hp_seconds, $hp_thirds, $np_beat, $hp_points
.


#
#  Open Classes High Point Report
#
format OPEN_HIGHPOINT_TOP =
@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| @<<<<<<<<<
$showinfo, $reportdate
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$reporttype

REQUIRED TO SHOW IN @## CLASSES TO QUALIFY
$hp_required

DIVISION                     EXHIBITOR                     CLASSES        POINTS
--------------------------------------------------------------------------------
.

format OPEN_HIGHPOINT =
CLASS INFO    : @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<<<
$classinfo, $placing_info1
CLASS ENTRIES : @###                                       @<<<<<<<<<<<<<<<<<<<<
$total_entries, $placing_info2
NATIONAL PTS  : @#.#                                       @<<<<<<<<<<<<<<<<<<<<
$total_points, $placing_info3
                                                           @<<<<<<<<<<<<<<<<<<<<
$placing_info4


.


#
#  Show Point Reports
#
format LOCALPOINTS_TOP =
@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| @<<<<<<<<<
$showinfo, $reportdate
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$reporttype
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$reporttype2

NATL
CLS# CLASS NAME                  HORSE NAME           OWNER/RIDER NAME      PTS
-------------------------------------------------------------------------------
.

format LOCALPOINTS =
@##  ^<<<<<<<<<<<<<<<<<<<<<<<<<  ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$national_num, $class_name, $point_data
~~   ^<<<<<<<<<<<<<<<<<<<<<<<<<  ^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$class_name, $point_data

.


#
#  Class Winner
#
format CLASSWINNER_TOP =
@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| @<<<<<<<<<
$showinfo, $reportdate
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$reporttype


Class: @<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<        Entries: @##
$classnumber, $classname, $total_class_entries

Back #  Horse Name            Exhibitor Name                  Points
------  --------------------  ------------------------------  ------
.

format CLASSWINNER =
@#####  @<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  @#####
$backnumber, $horsename, $ridername, $win_points
.


#
#  Billing Receipt
#
format BILLING_TOP =
@||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| @<<<<<<<<<
$showinfo, $reportdate
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$reporttype

Back# : @<<<<<
$backnumber
Horse : @<<<<<<<<<<<<<<<<<<<<
$horsename

Cls#  Class Name                                  Exhibitor Name         Cost
----  ------------------------------------------  ---------------------  -----
.

format BILLING =
@>>>  @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<<<  @####
$classnum, $classname, $ridername, $class_cost
.


########################################################################################
#
#                       HTML REPORT FORMATS
#
########################################################################################
#
#  HTML Header
#

sub report_header_html {
   print HTML_REPORT <<EOF;
<HTML>
<HEAD>
<TITLE>$showinfo</TITLE>
</HEAD>
<BODY>
<TABLE BORDER=0 WIDTH=100%>
<TR>
<TD WIDTH=50>&nbsp;</TD>
<TD>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="3" CELLSPACING="0">
<TR>
   <TD VALIGN="MIDDLE" ALIGN="CENTER" WIDTH="150">&nbsp;</TD>
   <TH VALIGN="MIDDLE" ALIGN="CENTER"><H2><B>$showname</B><BR><B>$reporttype</B></H2></TH>
   <TH VALIGN="MIDDLE" ALIGN="CENTER" WIDTH="150"><H3>$showdate</H3></TH>
</TR>
</TABLE>
EOF

}

#
#  HTML Header
#

sub report_footer_html {
   print HTML_REPORT <<EOF;
</TABLE>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>
EOF

}


########################################################################################
#
#  Member List
#

sub member_header_html {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH><U>Registration<BR>Number</U></TH>
   <TH ALIGN="LEFT"><U>Member Name</U></TD>
   <TH ALIGN="LEFT"><U>Address</U></TD>
   <TH ALIGN="LEFT"><U>Phone Number</U></TD>
</TR>
EOF
}

sub member_list_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD ALIGN="CENTER">$regnum</TD>
   <TD>$name</TD>
   <TD>$address</TD>
   <TD>$phone</TD>
</TR>
EOF
}


########################################################################################
#
#  Horse List
#

sub horse_header_html {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH><U>Registration<BR>Number</U></TH>
   <TH ALIGN="LEFT"><U>Horse Name</U></TD>
   <TH ALIGN="LEFT"><U>Foaled / Color / Sex</U></TD>
   <TH ALIGN="LEFT"><U>Sire / Dam</U></TD>
   <TH ALIGN="LEFT"><U>Owner Info</U></TD>
</TR>
EOF
}

sub horse_list_html {
   ($ownername,$owneraddress,$ownercity,$ownerstate,$ownerzip) = split(/~~/, $member_list{$owner});

   print HTML_REPORT <<EOF;
<TR>
   <TD ALIGN="CENTER">$type$regnum</TD>
   <TD>$name</TD>
   <TD>$year / $color / $sex</TD>
   <TD>$sire<BR>$dam</TD>
   <TD>$ownername<BR>$ownercity, $ownerstate</TD>
</TR>
EOF
}


########################################################################################
#
#  Class List
#

sub classlist_header_html {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=10%><U>Class<BR>Number</U></TH>
   <TH ALIGN="LEFT"><U>Class Name</U></TD>
</TR>
EOF
}

sub class_list_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD ALIGN="CENTER">$classnum</TD>
   <TD>$classname</TD>
</TR>
EOF
}

########################################################################################
#
#  Back Number List
#

sub backnumber_header_html {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="3" CELLSPACING="0">
<TR>
   <TH WIDTH=10%><U>Back<BR>Number</U></TH>
   <TH WIDTH=30% ALIGN="LEFT"><U>Horse Name</U></TD>
   <TH WIDTH=30% ALIGN="LEFT"><U>Exhibitor Name</U></TD>
   <TH WIDTH=30% ALIGN="LEFT"><U>Classes Entered</U></TD>
</TR>
</TABLE>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="3" CELLSPACING="0">
EOF
}

sub backnumber_list_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD WIDTH=10% ALIGN="CENTER">$backnum</TD>
   <TD WIDTH=30%>$horsename</TD>
   <TD WIDTH=30%>$ridername</TD>
   <TD WIDTH=30%>$classes</TD>
</TR>
EOF
}


########################################################################################
#
#  National Back Number List
#

sub national_backnumber_header_html {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="3" CELLSPACING="0">
<TR>
   <TH WIDTH=10%><U>Back<BR>Number</U></TH>
   <TH WIDTH=30% ALIGN="LEFT"><U>Horse/Reg #/Foal Yr</U></TD>
   <TH WIDTH=30% ALIGN="LEFT"><U>Exhibitor/Reg #</U></TD>
   <TH WIDTH=30% ALIGN="LEFT"><U>Owner/Reg #</U></TD>
</TR>
</TABLE>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="3" CELLSPACING="0">
EOF
}

sub national_backnumber_list_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD WIDTH=10% ALIGN="CENTER">$backnum</TD>
   <TD WIDTH=30%>$horseinfo</TD>
   <TD WIDTH=30%>$riderinfo</TD>
   <TD WIDTH=30%>$ownerinfo</TD>
</TR>
EOF
}


########################################################################################
#
#  Class Entry Count List
#

sub entrycount_header_html {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH>Total Entries for This Show: $entry_count</TD>
   <TH>Report Printed At: $reporttime</TD>
</TR>
</TABLE>
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=10%><U>Number<BR>Entries</U></TH>
   <TH WIDTH=10%><U>Class<BR>Number</U></TD>
   <TH ALIGN="LEFT"><U>Class Name</U></TD>
</TR>
EOF
}

sub entrycount_list_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD ALIGN="CENTER">$entries</TD>
   <TD ALIGN="CENTER">$classnum</TD>
   <TD>$classname</TD>
</TR>
EOF
}

sub entrycount_footer_html {
   print HTML_REPORT <<EOF;
<TR>
   <TH WIDTH=10%><U>Number<BR>Entries</U></TH>
   <TH WIDTH=10%><U>Class<BR>Number</U></TD>
   <TH ALIGN="LEFT"><U>Class Name</U></TD>
</TR>
EOF
}


########################################################################################
#
#  Judge Info HTML
#

sub judges_html {
   print HTML_REPORT <<EOF;
<BR><BR>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH VALIGN="MIDDLE" ALIGN="CENTER"><B>Judge 1</B></TH>
   <TH VALIGN="MIDDLE" ALIGN="CENTER"><B>$judgeinfo1</B></TH>
   <TH VALIGN="MIDDLE" ALIGN="CENTER"><B>Judge 2</B></TH>
   <TH VALIGN="MIDDLE" ALIGN="CENTER"><B>$judgeinfo2</B></TH>
</TR>
EOF

if ($judge3) {
   print HTML_REPORT <<EOF;
<TR>
   <TH VALIGN="MIDDLE" ALIGN="CENTER"><B>Judge 3</B></TH>
   <TH VALIGN="MIDDLE" ALIGN="CENTER"><B>$judgeinfo3</B></TH>
EOF

   if ($judge4) {
      print HTML_REPORT "<TH VALIGN='MIDDLE' ALIGN='CENTER'><B>Judge 4</B></TH>\n";
      print HTML_REPORT "<TH VALIGN='MIDDLE' ALIGN='CENTER'><B>$judgeinfo4</B></TH>\n";
   } else {
      print HTML_REPORT "<TH VALIGN='MIDDLE' ALIGN='CENTER'>&nbsp;</TH>\n";
      print HTML_REPORT "<TH VALIGN='MIDDLE' ALIGN='CENTER'>&nbsp;</TH>\n";
   }
}

print HTML_REPORT "</TR></TABLE>\n";

}


#
#  Class Info HTML
#

sub classinfo_html {
   print HTML_REPORT <<EOF;
<BR><BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=10% VALIGN="MIDDLE" ALIGN="CENTER"><B><U>Class</U><BR><H3>$classnumber</H3></B></TH>
   <TH WIDTH=80% VALIGN="MIDDLE" ALIGN="CENTER"><H3><B>$classname</B></H3></TH>
   <TH WIDTH=10% VALIGN="MIDDLE" ALIGN="CENTER"><B><U>Entries</U><BR><H3>$total_class_entries</H3></B></H2></TH>
</TR>
</TABLE>
EOF

}


#
#  Class Entries
#

sub class_entries_header_html {
   if ($scored) {
      print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TD VALIGN="MIDDLE" ALIGN="CENTER" WIDTH="3%"><U>J1</U></TD>
   <TD VALIGN="MIDDLE" ALIGN="CENTER" WIDTH="3%"><U>J2</U></TD>
EOF
#   <TD VALIGN="MIDDLE" ALIGN="CENTER" WIDTH="3%"><U>Score</U></TD>
#   <TD VALIGN="MIDDLE" ALIGN="CENTER" WIDTH="3%"><U>Score</U></TD>

      if ($judge3) {
         print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER' WIDTH='3%'><U>J3</U></TD>\n";
#         print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER' WIDTH='3%'><U>Score</U></TD>\n";

         if ($judge4) {
            print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER' WIDTH='3%'><U>J4</U></TD>\n";
#            print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER' WIDTH='3%'><U>Score</U></TD>\n";
         } else {
            print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER' WIDTH='3%'>&nbsp;</TD>\n";
#            print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER' WIDTH='3%'>&nbsp;</TD>\n";
         }
      }

      print HTML_REPORT <<EOF;
      <TH WIDTH="10%"><U>Back #</U></TH>
      <TD><U>Horse Name</U></TD>
      <TD><U>Exhibitor Name</U></TD>
   </TR>
EOF
   } else {
      print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TD VALIGN="MIDDLE" ALIGN="CENTER" WIDTH="3%"><U>J1</U></TD>
   <TD VALIGN="MIDDLE" ALIGN="CENTER" WIDTH="3%"><U>J2</U></TD>
EOF

      if ($judge3) {
         print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER' WIDTH=\"3%\"><U>J3</U></TD>\n";

         if ($judge4) {
            print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER' WIDTH=\"3%\"><U>J4</U></TD>\n";
         } else {
            print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER' WIDTH=\"3%\">&nbsp;</TD>\n";
         }
      }

      print HTML_REPORT <<EOF;
      <TH WIDTH="10%"><U>Back #</U></TH>
      <TD><U>Horse Name</U></TD>
      <TD><U>Exhibitor Name</U></TD>
   </TR>
EOF
   }
}


#
#  Class Entries
#

sub class_entries_html {
   if ($scored) {
      print HTML_REPORT <<EOF;
<TR>
   <TD VALIGN="MIDDLE" ALIGN="CENTER">$place1</TD>
   <TD VALIGN="MIDDLE" ALIGN="CENTER">$place2</TD>
EOF
#   <TD VALIGN="MIDDLE" ALIGN="CENTER">$score1</TD>
#   <TD VALIGN="MIDDLE" ALIGN="CENTER">$score2</TD>

      if ($judge3) {
         print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER'>$place3</TD>\n";
#         print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER'>$score3</TD>\n";

         if ($judge4) {
            print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER'>$place4</TD>\n";
#            print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER'>$score4</TD>\n";
         } else {
            print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER'>&nbsp;</TD>\n";
#            print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER'>&nbsp;</TD>\n";
         }
      }
   } else {
      print HTML_REPORT <<EOF;
<TR>
   <TD VALIGN="MIDDLE" ALIGN="CENTER">$place1</TD>
   <TD VALIGN="MIDDLE" ALIGN="CENTER">$place2</TD>
EOF

      if ($judge3) {
         print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER'>$place3</TD>\n";

         if ($judge4) {
            print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER'>$place4</TD>\n";
         } else {
            print HTML_REPORT "<TD VALIGN='MIDDLE' ALIGN='CENTER'>&nbsp;</TD>\n";
         }
      }
   }

   print HTML_REPORT <<EOF;
   <TH>$backnumber</TH>
   <TD>$horsename</TD>
   <TD>$ridername</TD>
</TR>
EOF
}


########################################################################################
#
#  Class Entry Count List
#

sub entrycount_header_html {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH>Total Entries for This Show: $entry_count</TD>
   <TH>Report Printed At: $reporttime</TD>
</TR>
</TABLE>
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=10%><U>Number<BR>Entries</U></TH>
   <TH WIDTH=10%><U>Class<BR>Number</U></TD>
   <TH ALIGN="LEFT"><U>Class Name</U></TD>
</TR>
</TABLE>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
EOF
}

sub entrycount_list_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD WIDTH=10% ALIGN="CENTER">$entries</TD>
   <TD WIDTH=10% ALIGN="CENTER">$classnum</TD>
   <TD>$classname</TD>
</TR>
EOF
}


########################################################################################
#
#  Classes For Entry
#

sub riderentries_header_html {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=20%>$backnumber</TD>
   <TH WIDTH=40%>HORSE: $horsename</TD>
   <TH WIDTH=40%>EXHIBITOR: $ridername</TD>
</TR>
</TABLE>
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=10%><U>Class<BR>Number</U></TD>
   <TH ALIGN="LEFT"><U>Class Name</U></TD>
</TR>
EOF
}

sub riderentries_list_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD ALIGN="CENTER">$classnumber</TD>
   <TD>$classname</TD>
</TR>
EOF
}


########################################################################################
#
#  Class Winner
#

sub classwinner_header_html {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=15%><U>Class<BR>Number</U></TD>
   <TH><U>Class Name</U></TD>
   <TH WIDTH=15%><U>Number<BR>Entries</U></TD>
</TR>
<TR>
   <TH WIDTH=15%>$classnumber</TD>
   <TH>$classname</TD>
   <TH WIDTH=15%>$total_class_entries</TD>
</TR>
</TABLE>
<BR>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=15%><U>Back<BR>Number</U></TD>
   <TH ALIGN="LEFT"><U>Horse Name</U></TD>
   <TH ALIGN="LEFT"><U>Exhibitor Name</U></TD>
   <TH WIDTH=15%><U>Points</U></TD>
</TR>
EOF
}

sub classwinner_list_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD ALIGN="CENTER">$backnumber</TD>
   <TD>$horsename</TD>
   <TD>$ridername</TD>
   <TD ALIGN="CENTER">$win_points</TD>
</TR>
EOF
}


########################################################################################
#
#  Class Winner
#

sub pointsheet_header_html {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH><U>Horse</U>:</TH>
   <TH>$horsename</TH>
   <TH><U>Exhibitor</U>:</TD>
   <TH>$ridername</TD>
</TR>
</TABLE>
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=70%><U>Class and Point Information</U></TD>
   <TH WIDTH=10%><U>Judge</U></TD>
   <TH WIDTH=10%><U>Place</U></TD>
   <TH WIDTH=10%><U>Points</U></TD>
</TR>
EOF
}


sub pointsheet_nl_header_html {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH><U>Horse</U>:</TH>
   <TH>$horsename</TH>
   <TH><U>Exhibitor</U>:</TD>
   <TH>$ridername</TD>
</TR>
</TABLE>
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=60% COLSPAN=2><U>Class and Point Information</U></TD>
   <TH WIDTH=10%><U>Judge</U></TD>
   <TH WIDTH=10%><U>Place</U></TD>
   <TH WIDTH=10%><U>National<BR>Points</U></TD>
   <TH WIDTH=10%><U>Local<BR>Points</U></TD>
</TR>
EOF
}


sub pointsheet_judge_html {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH VALIGN="MIDDLE" ALIGN="CENTER"><B>$shownum1</B></TH>
   <TH VALIGN="MIDDLE" ALIGN="CENTER"><B>$judgeinfo1</B></TH>
   <TH VALIGN="MIDDLE" ALIGN="CENTER"><B>$shownum2</B></TH>
   <TH VALIGN="MIDDLE" ALIGN="CENTER"><B>$judgeinfo2</B></TH>
</TR>
EOF

   if ($judge3) {
      print HTML_REPORT <<EOF;
<TR>
   <TH VALIGN="MIDDLE" ALIGN="CENTER"><B>$shownum3</B></TH>
   <TH VALIGN="MIDDLE" ALIGN="CENTER"><B>$judgeinfo3</B></TH>
EOF

      if ($judge4) {
         print HTML_REPORT "<TH VALIGN='MIDDLE' ALIGN='CENTER'><B>$shownum4</B></TH>\n";
         print HTML_REPORT "<TH VALIGN='MIDDLE' ALIGN='CENTER'><B>$judgeinfo4</B></TH>\n";
      } else {
         print HTML_REPORT "<TH VALIGN='MIDDLE' ALIGN='CENTER'>&nbsp;</TH>\n";
         print HTML_REPORT "<TH VALIGN='MIDDLE' ALIGN='CENTER'>&nbsp;</TH>\n";
      }
   }

   print HTML_REPORT "</TR></TABLE>\n";

}


sub pointsheet_list_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD>$classinfo</TD>
   <TD ALIGN="MIDDLE">$snum1</TD>
   <TD ALIGN="MIDDLE">$place1</TD>
   <TD ALIGN="MIDDLE">$points1</TD>
</TR>
<TR>
   <TD>Number Of Entries In This Class: <B>$total_entries</B></TD>
   <TD ALIGN="MIDDLE">$snum2</TD>
   <TD ALIGN="MIDDLE">$place2</TD>
   <TD ALIGN="MIDDLE">$points2</TD>
</TR>
<TR>
   <TD>National Points For This Class: <B>$national_points</B></TD>
   <TD ALIGN="MIDDLE">$snum3</TD>
   <TD ALIGN="MIDDLE">$place3</TD>
   <TD ALIGN="MIDDLE">$points3</TD>
</TR>
<TR>
   <TD>&nbsp;</TD>
   <TD ALIGN="MIDDLE">$snum4</TD>
   <TD ALIGN="MIDDLE">$place4</TD>
   <TD ALIGN="MIDDLE">$points4</TD>
</TR>
EOF
}


sub pointsheet_local_list_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD>$classinfo</TD>
   <TD ALIGN="MIDDLE">$snum1</TD>
   <TD ALIGN="MIDDLE">$place1</TD>
   <TD ALIGN="MIDDLE">$points1</TD>
</TR>
<TR>
   <TD>Number Of Entries In This Class: <B>$total_entries</B></TD>
   <TD ALIGN="MIDDLE">$snum2</TD>
   <TD ALIGN="MIDDLE">$place2</TD>
   <TD ALIGN="MIDDLE">$points2</TD>
</TR>
<TR>
   <TD>Local Points For This Class: <B>$local_points</B></TD>
   <TD ALIGN="MIDDLE">$snum3</TD>
   <TD ALIGN="MIDDLE">$place3</TD>
   <TD ALIGN="MIDDLE">$points3</TD>
</TR>
<TR>
   <TD>&nbsp;</TD>
   <TD ALIGN="MIDDLE">$snum4</TD>
   <TD ALIGN="MIDDLE">$place4</TD>
   <TD ALIGN="MIDDLE">$points4</TD>
</TR>
EOF
}


sub pointsheet_natl_local_list_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD COLSPAN=2>$classinfo</TD>
   <TD ALIGN="MIDDLE">$snum1</TD>
   <TD ALIGN="MIDDLE">$place1</TD>
   <TD ALIGN="MIDDLE">$natl_points1</TD>
   <TD ALIGN="MIDDLE">$local_points1</TD>
</TR>
<TR>
   <TD COLSPAN=2>Number Of Entries In This Class: <B>$total_entries</B></TD>
   <TD ALIGN="MIDDLE">$snum2</TD>
   <TD ALIGN="MIDDLE">$place2</TD>
   <TD ALIGN="MIDDLE">$natl_points2</TD>
   <TD ALIGN="MIDDLE">$local_points2</TD>
</TR>
<TR>
   <TD>National Points: <B>$national_points</B></TD>
   <TD>Local Points: <B>$local_points</B></TD>
   <TD ALIGN="MIDDLE">$snum3</TD>
   <TD ALIGN="MIDDLE">$place3</TD>
   <TD ALIGN="MIDDLE">$natl_points3</TD>
   <TD ALIGN="MIDDLE">$local_points3</TD>
</TR>
<TR>
   <TD COLSPAN=2>&nbsp;</TD>
   <TD ALIGN="MIDDLE">$snum4</TD>
   <TD ALIGN="MIDDLE">$place4</TD>
   <TD ALIGN="MIDDLE">$natl_points4</TD>
   <TD ALIGN="MIDDLE">$local_points4</TD>
</TR>
EOF
}


########################################################################################
#
#  High Point Results
#

sub highpoint_header_html {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH><H2>$hp_division</H2></TH>
</TR>
</TABLE>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH>REQUIRED TO SHOW IN $hp_required CLASSES TO QUALIFY</TH>
</TR>
</TABLE>
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=40%><U>EXHIBITOR / HORSE</U></TD>
   <TH WIDTH=10%><U># CLASSES</U></TD>
   <TH WIDTH=10%><U>1ST</U></TD>
   <TH WIDTH=10%><U>2ND</U></TD>
   <TH WIDTH=10%><U>3RD</U></TD>
   <TH WIDTH=10%><U>BEAT</U></TD>
   <TH WIDTH=10%><U>POINTS</U></TD>
</TR>
EOF
}


sub highpoint_list_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD>$hp_name</TD>
   <TD ALIGN="MIDDLE">$hp_numclasses</TD>
   <TD ALIGN="MIDDLE">$hp_firsts</TD>
   <TD ALIGN="MIDDLE">$hp_seconds</TD>
   <TD ALIGN="MIDDLE">$hp_thirds</TD>
   <TD ALIGN="MIDDLE">$hp_beat</TD>
   <TD ALIGN="MIDDLE">$hp_points</TD>
</TR>
EOF
}


########################################################################################
#
#  Final Entry Count
#

sub finalcount_header_html {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH>TOTAL ENTRIES FOR THIS SHOW: $entry_count</TH>
</TR>
</TABLE>
<BR>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=10%><U>ENTRIES</U></TD>
   <TH WIDTH=10%><U>OPEN</U></TD>
   <TH WIDTH=10%><U>NONPRO</U></TD>
   <TH WIDTH=10%><U>YOUTH</U></TD>
   <TH WIDTH=10%><U>CLASSNUM</U></TD>
   <TH WIDTH=50%><U>CLASS NAME</U></TD>
</TR>
EOF
}


sub finalcount_list_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD ALIGN="MIDDLE">$entries</TD>
   <TD ALIGN="MIDDLE">$open_entries</TD>
   <TD ALIGN="MIDDLE">$nonpro_entries</TD>
   <TD ALIGN="MIDDLE">$youth_entries</TD>
   <TD ALIGN="MIDDLE">$classnum</TD>
   <TD>$classname</TD>
</TR>
EOF
}


########################################################################################
#
#  Local Point Report
#

sub localpoints_header_html {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH VALIGN="CENTER"><H2>$reporttype2</H2></TH>
</TR>
</TABLE>
<BR>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=5%><U>NATL#</U></TD>
   <TH WIDTH=20%><U>CLASS NAME</U></TD>
   <TH WIDTH=20% ALIGN="LEFT"><U>HORSE INFO</U></TD>
   <TH WIDTH=25% ALIGN="LEFT"><U>OWNER INFO</U></TD>
   <TH WIDTH=25% ALIGN="LEFT"><U>EXHIBITOR INFO</U></TD>
   <TH WIDTH=5%><U>POINTS</U></TD>
</TR>
EOF
}


sub localpoints_list_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD ALIGN="MIDDLE">$national_num</TD>
   <TD ALIGN="MIDDLE">$class_name</TD>
   <TD ALIGN="LEFT">$horseinfo</TD>
   <TD ALIGN="LEFT">$ownerinfo</TD>
   <TD ALIGN="LEFT">$riderinfo</TD>
   <TD ALIGN="MIDDLE">$points</TD>
</TR>
EOF
}


########################################################################################
#
#  National Point Report
#

sub nationalpoints_header_html {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH VALIGN="CENTER"><H2>$reporttype2</H2></TH>
</TR>
</TABLE>
<BR>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=5%><U>NATL#</U></TD>
   <TH WIDTH=30%><U>CLASS NAME</U></TD>
   <TH WIDTH=30% ALIGN="LEFT"><U>HORSE INFO</U></TD>
   <TH WIDTH=30% ALIGN="LEFT"><U>OWNER/RIDER INFO</U></TD>
   <TH WIDTH=5%><U>POINTS</U></TD>
</TR>
EOF
}


sub nationalpoints_list_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD ALIGN="MIDDLE">$national_num</TD>
   <TD ALIGN="MIDDLE">$class_name</TD>
   <TD ALIGN="LEFT">$horseinfo</TD>
   <TD ALIGN="LEFT">$riderinfo</TD>
   <TD ALIGN="MIDDLE">$points</TD>
</TR>
EOF
}


########################################################################################
#
#  Billing Receipt
#

sub billing_header_html {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=15%>Back Number:</TH>
   <TH ALIGN="LEFT">$backnumber</TH>
</TR>
<TR>
   <TH WIDTH=15%>Horse Name:</TH>
   <TH ALIGN="LEFT">$horsename</TH>
</TR>
</TABLE>
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=20%><U>CLASS#</U></TD>
   <TH WIDTH=30%><U>CLASS NAME</U></TD>
   <TH WIDTH=30%><U>EXHIBITOR NAME</U></TD>
   <TH WIDTH=20%><U>COST</U></TD>
</TR>
EOF
}


sub billing_list_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD ALIGN="MIDDLE">$classnum</TD>
   <TD ALIGN="LEFT">$classname</TD>
   <TD ALIGN="LEFT">$ridername</TD>
   <TD ALIGN="MIDDLE">$class_cost</TD>
</TR>
EOF
}


########################################################################################
#
#  Buckskin Final Show Results
#

sub buckskin_results_header {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TD WIDTH=20%><B>SHOW NAME</B></TD>
   <TD WIDTH=80%>$showname</TD>
</TR>
<TR>
   <TD><B>CITY / STATE</B></TD>
   <TD>$showlocation</TD>
</TR>
<TR>
   <TD><B>SHOW DATE</B></TD>
   <TD>$showdate</TD>
</TR>
<TR>
   <TD><B>JUDGE INFO</B></TD>
   <TD>$judgeinfo</TD>
</TR>
</TABLE>
EOF
}

sub buckskin_results_class_header {
   print HTML_REPORT <<EOF;
<BR>
<HR>
<BR>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=10% VALIGN=middle><H3><B>CLASS:</H3></B></TD>
   <TH WIDTH=10% VALIGN=middle><H3>$national_num</H3></TD>
   <TH WIDTH=60% VALIGN=middle><H3>$national_name</H3></TD>
   <TH WIDTH=15% VALIGN=middle><H3><B>ENTRIES:</B></H3></TD>
   <TH WIDTH=5% VALIGN=middle><H3>$entries</H3></TD>
</TR>
</TABLE>
<HR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=5%><U>PLACE</U></TD>
   <TH WIDTH=10%><U>REGNUM</U></TD>
   <TH WIDTH=25%><U>HORSE NAME</U></TD>
   <TH WIDTH=30%><U>OWNER INFORMATION</U></TD>
   <TH WIDTH=30%><U>EXHIBITOR INFORMATION</U></TD>
</TR>
EOF
}

sub buckskin_results_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD ALIGN="LEFT">$place</TD>
   <TD ALIGN="LEFT">$horsenum</TD>
   <TD ALIGN="LEFT">$horsename</TD>
   <TD ALIGN="LEFT">$ownerinfo</TD>
   <TD ALIGN="LEFT">$riderinfo</TD>
</TR>
EOF
}


########################################################################################
#
#  Buckskin Master Horse List
#

sub buckskin_master_list_header {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TD WIDTH=10%><B>SHOW NAME</B></TD>
   <TD WIDTH=60%>$showname</TD>
   <TD WIDTH=20%><B>HORSES SHOWN</B></TD>
   <TD WIDTH=10%>$horse_count</TD>
</TR>
<TR>
   <TD><B>CITY / STATE</B></TD>
   <TD>$showlocation</TD>
</TR>
<TR>
   <TD><B>SHOW DATE</B></TD>
   <TD>$showdate</TD>
   <TD><B>NUM ENTRIES</B></TD>
   <TD>$entry_count</TD>
</TR>
<TR>
   <TD><B>JUDGE INFO</B></TD>
   <TD>$judgeinfo</TD>
</TR>
</TABLE>
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=10%><U>REGNUM</U></TD>
   <TH WIDTH=30%><U>HORSE NAME</U></TD>
   <TH WIDTH=10%><U>FOAL</U></TD>
   <TH WIDTH=10%><U>REGNUM</U></TD>
   <TH WIDTH=30%><U>HORSE NAME</U></TD>
   <TH WIDTH=10%><U>FOAL</U></TD>
</TR>
EOF
}


sub buckskin_master_list_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD ALIGN="LEFT">$horsenum1</TD>
   <TD ALIGN="LEFT">$horsename1</TD>
   <TD ALIGN="LEFT">$foaldate1</TD>
   <TD ALIGN="LEFT">$horsenum2</TD>
   <TD ALIGN="LEFT">$horsename2</TD>
   <TD ALIGN="LEFT">$foaldate2</TD>
</TR>
EOF
}


sub appaloosa_master_list_header {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TD WIDTH=10%><B>SHOW NAME</B></TD>
   <TD WIDTH=60%>$showname</TD>
   <TD WIDTH=20%><B>HORSES SHOWN</B></TD>
   <TD WIDTH=10%>$horse_count</TD>
</TR>
<TR>
   <TD><B>CITY / STATE</B></TD>
   <TD>$showlocation</TD>
</TR>
<TR>
   <TD><B>SHOW DATE</B></TD>
   <TD>$showdate</TD>
   <TD><B>NUM ENTRIES</B></TD>
   <TD>$entry_count</TD>
</TR>
<TR>
   <TD><B>JUDGE INFO</B></TD>
   <TD>$judgeinfo</TD>
</TR>
</TABLE>
<BR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=10%><U>REGNUM</U></TD>
   <TH WIDTH=30%><U>HORSE NAME</U></TD>
   <TH WIDTH=10%><U>FOAL</U></TD>
   <TH WIDTH=10%><U>REGNUM</U></TD>
   <TH WIDTH=30%><U>HORSE NAME</U></TD>
   <TH WIDTH=10%><U>FOAL</U></TD>
</TR>
EOF
}


########################################################################################
#
#  NSBA Final Show Results
#

sub nsba_results_header {
   print HTML_REPORT <<EOF;
<BR>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TD WIDTH=20%><B>SHOW NAME</B></TD>
   <TD WIDTH=80%>$showname</TD>
</TR>
<TR>
   <TD><B>CITY / STATE</B></TD>
   <TD>$showlocation</TD>
</TR>
<TR>
   <TD><B>SHOW DATE</B></TD>
   <TD>$showdate</TD>
</TR>
<TR>
   <TD><B>JUDGE</B></TD>
   <TD>$judgename</TD>
</TR>
</TABLE>
EOF
}

sub nsba_results_class_header {
   print HTML_REPORT <<EOF;
<BR>
<HR>
<BR>
<TABLE WIDTH="100%" BORDER="0" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=10% VALIGN=middle><H3><B>CLASS:</H3></B></TD>
   <TH WIDTH=10% VALIGN=middle><H3>$national_num</H3></TD>
   <TH WIDTH=60% VALIGN=middle><H3>$national_name</H3></TD>
   <TH WIDTH=15% VALIGN=middle><H3><B>ENTRIES:</B></H3></TD>
   <TH WIDTH=5% VALIGN=middle><H3>$entries</H3></TD>
</TR>
</TABLE>
<HR>
<TABLE WIDTH="100%" BORDER="1" CELLPADDING="5" CELLSPACING="0">
<TR>
   <TH WIDTH=5%><U>PLACE</U></TD>
   <TH WIDTH=10%><U>PAYOUT</U></TD>
   <TH WIDTH=25%><U>HORSE INFORMATION</U></TD>
   <TH WIDTH=30%><U>OWNER INFORMATION</U></TD>
   <TH WIDTH=30%><U>EXHIBITOR INFORMATION</U></TD>
</TR>
EOF
}

sub nsba_results_html {
   print HTML_REPORT <<EOF;
<TR>
   <TD ALIGN="LEFT">$place</TD>
   <TD ALIGN="LEFT">&nbsp;</TD>
   <TD ALIGN="LEFT">$horseinfo</TD>
   <TD ALIGN="LEFT">$ownerinfo</TD>
   <TD ALIGN="LEFT">$riderinfo</TD>
</TR>
EOF
}

1;

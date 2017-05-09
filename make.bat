rem
rem     Make all show office programs
rem
..\perl2exe\perl2exe -small -gui -o=create_show.exe create_show.pl
..\perl2exe\perl2exe -small -gui -o=modify_info.exe modify_info.pl
..\perl2exe\perl2exe -small -gui -o=place_class.exe place_class.pl
..\perl2exe\perl2exe -small -gui -o=install.exe install.pl
..\perl2exe\perl2exe -small -gui -o=reports.exe reports.pl
..\perl2exe\perl2exe -small -gui -o=run_show.exe run_show.pl
..\perl2exe\perl2exe -small -gui -o=show.exe show.pl


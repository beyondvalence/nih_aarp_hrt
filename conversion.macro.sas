/***********************************************************************
* NIH-AARP File Conversions 
* From UNIX format to Windows
* To bypass cross-environment data access
*
* v20150211 WTL
* updated 20150406WTL for new risk factor exposure dataset
************************************************************************/
title1 'NIH-AARP UVR File Conversions';

*** create file input and output locations;
libname inlib cvp 'C:\REB\AARP_HRTandMelanoma\Data\anchovy';
libname outlib 'C:\REB\AARP_HRTandMelanoma\Data\converted' outencoding='wlatin1';

** convert (copy using wlatin1 Windows encoding from latin1 Linux);
proc copy noclone in=inlib out=outlib;
	select out09jan14 exp05jun14 rout09jan14 rexp05jun14;
run;

proc contents data=outlib.out09jan14;
run;

** convert newest riskfactor exposure dataset (2015 Feb 16);
** (copy using wlatin1 Windows encoding from latin1 Linux);
proc copy noclone in=inlib out=outlib;
	select rexp16feb15;
run;

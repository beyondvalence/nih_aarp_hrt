/*****************************************************************************;
#             NIH-AARP UVR- Reproductive Factors- Melanoma Study
******************************************************************************;
#
# Model Building Master File: Runs all the Models
# !!!! for both baseline and riskfactor datasets !!!!
#
# uses the conv.melan, conv.melan_r datasets
#
# Set to run: Model all
# with updated menostat_c, no premeno and no unknowns and no radchem
#
# Created: June 29 2015 WTL
# Updated: v20150715WED WTL
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************************/


libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
libname results 'C:\REB\AARP_HRTandMelanoma\Results';


******************************************************************************;
** formats;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\formats.20150714.base.sas';
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\formats.20150714.risk.sas';
run;


******************************************************************************;
/** test;
data use_r;
	set conv.melan_r;
run;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\tempp.risk.20150629.sas';
**/


******************************************************************************;
** Model A;
** melanoma ~ ME;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\Model.A.v3.sas';


******************************************************************************;
** Model B;
** melanoma ~ ME+uvrq+educ_c+bmi_c+smoke_former;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\Model.B.v3.sas';


******************************************************************************;
** Model C;
** melanoma ~ ME+uvrq+educ_c+bmi_c+smoke_former+parity;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\Model.C.v3.sas';


******************************************************************************;
** Model D;
** melanoma ~ ME+uvrq+educ_c+bmi_c+smoke_former+parity+fmenstr;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\Model.D.v3.sas';


******************************************************************************;
** Model E;
** melanoma ~ ME+uvrq+educ_c+bmi_c+smoke_former+parity+fmenstr+flb_age_c;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\Model.E.v3.sas';


******************************************************************************;
** Model F;
** only riskfactor, with hospital indicator: colo_sig_any;
** melanoma ~ ME+uvrq+educ_c+bmi_c+smoke_former+parity+fmenstr+flb_age_c+colo_sig_any;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\Model.F.v3.sas';


******************************************************************************;
** Model B2;
** melanoma ~ ME+uvrq+educ_c+bmi_c+smoke_former+phys_c+etoh_c+coffee_c+smoke_dose+smoke_quit;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\Model.B2.v3.sas';

******************************************************************************;
** Model B3;
** melanoma ~ ME+uvrq+educ_c+bmi_c+smoke_former+rel_1d_cancer+marriage+colo_sig_any+mht_ever;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\Model.B3.v2.sas';


ods _all_ close;
ods html;

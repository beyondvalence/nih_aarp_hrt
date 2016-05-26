/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
#
# Model building v1, interactions, uvrq~menopause age
# !!!! for baseline dataset !!!!
#
# uses the conv.melan datasets
#
# Created: May 24, 2016
# Updated: v20160524TUE WTL
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************/

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\formats.20150714.base.sas';

data use;
	set conv.melan;
run;

*******************************************************************************;
** Base: UVRQ Analysis by MENOPAGE3                     ***********************;
*******************************************************************************;
*******************************************************************;
** menopage3 1 INS **;
** updated 20160524TUE WTL;
** with menop_age_3c with <45, 45-54, 55+;
title1 'HRT interaction uvrq~menopage3-1'; 
title2 'uvrq continuous ';
proc freq data=use;
 table menop_age_3c*melanoma_c;
run;
proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	where menop_age_3c=1;
	ods output ParameterEstimates=uvrq_menopage1;
run;

data bin_uvrq_menopage1; set uvrq_menopage1;
	where Parameter='uvrq_c';
	variable="bin_uvrq_menopage1    ";
run;

title1 'HRT interaction uvrq~menopage3-1'; 
title2 'uvrq_c cat';
proc phreg data = use multipass;
	class uvrq_c (ref='176.095 to 186.918')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	where menop_age_3c=1;
	ods output ParameterEstimates=uvrq_c_menopage1;
run;

data bin_uvrq_c_menopage1; set uvrq_c_menopage1;
	where Parameter='uvrq_c';
	variable="bin_uvrq_c_menopage1    ";
run;

** menopage3 2 INS **;
title1 'HRT interaction uvrq~menopage3-2'; 
title2 'uvrq continuous ';
proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	where menop_age_3c=2;
	ods output ParameterEstimates=uvrq_menopage2;
run;

data bin_uvrq_menopage2; set uvrq_menopage2;
	where Parameter='uvrq_c';
	variable="bin_uvrq_menopage2    ";
run;

title1 'HRT interaction uvrq~menopage3-2'; 
title2 'uvrq_c cat';
proc phreg data = use multipass;
	class uvrq_c (ref='176.095 to 186.918')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	where menop_age_3c=2;
	ods output ParameterEstimates=uvrq_c_menopage2;
run;

data bin_uvrq_c_menopage2; set uvrq_c_menopage2;
	where Parameter='uvrq_c';
	variable="bin_uvrq_c_menopage2    ";
run;

** menopage3 3 INS **;
title1 'HRT interaction uvrq~menopage3-3'; 
title2 'uvrq continuous ';
proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	where menop_age_3c=3;
	ods output ParameterEstimates=uvrq_menopage3;
run;

data bin_uvrq_menopage3; set uvrq_menopage3;
	where Parameter='uvrq_c';
	variable="bin_uvrq_menopage3    ";
run;

title1 'HRT interaction uvrq~menopage3-3'; 
title2 'uvrq_c cat';
proc phreg data = use multipass;
	class uvrq_c (ref='176.095 to 186.918')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	where menop_age_3c=3;
	ods output ParameterEstimates=uvrq_c_menopage3;
run;

data bin_uvrq_c_menopage3; set uvrq_c_menopage3;
	where Parameter='uvrq_c';
	variable="bin_uvrq_c_menopage3    ";
run;

** menopage all3 INS **;
data bin_uvrq_c_menopage3all;
	set bin_uvrq_menopage1
		bin_uvrq_c_menopage1
		bin_uvrq_menopage2
		bin_uvrq_c_menopage2
		bin_uvrq_menopage3
		bin_uvrq_c_menopage3;
run;

*******************************************************************;
** menopage3 1 MAL **;
** updated 20160524TUE WTL;
** with menop_age_3c with <45, 45-54, 55+;
title1 'HRT interaction uvrq~menopage3-1'; 
title2 'uvrq continuous ';
proc freq data=use;
 table menop_age_3c*melanoma_c;
run;
proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	where menop_age_3c=1;
	ods output ParameterEstimates=uvrq_menopage1;
run;

data bma_uvrq_menopage1; set uvrq_menopage1;
	where Parameter='uvrq_c';
	variable="bma_uvrq_menopage1    ";
run;

title1 'HRT interaction uvrq~menopage3-1'; 
title2 'uvrq_c cat';
proc phreg data = use multipass;
	class uvrq_c (ref='176.095 to 186.918')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	where menop_age_3c=1;
	ods output ParameterEstimates=uvrq_c_menopage1;
run;

data bma_uvrq_c_menopage1; set uvrq_c_menopage1;
	where Parameter='uvrq_c';
	variable="bma_uvrq_c_menopage1    ";
run;

** menopage3 2 MAL **;
title1 'HRT interaction uvrq~menopage3-2'; 
title2 'uvrq continuous ';
proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	where menop_age_3c=2;
	ods output ParameterEstimates=uvrq_menopage2;
run;

data bma_uvrq_menopage2; set uvrq_menopage2;
	where Parameter='uvrq_c';
	variable="bma_uvrq_menopage2    ";
run;

title1 'HRT interaction uvrq~menopage3-2'; 
title2 'uvrq_c cat';
proc phreg data = use multipass;
	class uvrq_c (ref='176.095 to 186.918')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	where menop_age_3c=2;
	ods output ParameterEstimates=uvrq_c_menopage2;
run;

data bma_uvrq_c_menopage2; set uvrq_c_menopage2;
	where Parameter='uvrq_c';
	variable="bma_uvrq_c_menopage2    ";
run;

** menopage3 3 MAL **;
title1 'HRT interaction uvrq~menopage3-3'; 
title2 'uvrq continuous ';
proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	where menop_age_3c=3;
	ods output ParameterEstimates=uvrq_menopage3;
run;

data bma_uvrq_menopage3; set uvrq_menopage3;
	where Parameter='uvrq_c';
	variable="bma_uvrq_menopage3    ";
run;

title1 'HRT interaction uvrq~menopage3-3'; 
title2 'uvrq_c cat';
proc phreg data = use multipass;
	class uvrq_c (ref='176.095 to 186.918')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	where menop_age_3c=3;
	ods output ParameterEstimates=uvrq_c_menopage3;
run;

data bma_uvrq_c_menopage3; set uvrq_c_menopage3;
	where Parameter='uvrq_c';
	variable="bma_uvrq_c_menopage3    ";
run;

** menopage all3 MAL **;
data bma_uvrq_c_menopage3all;
	set bma_uvrq_menopage1
		bma_uvrq_c_menopage1
		bma_uvrq_menopage2
		bma_uvrq_c_menopage2
		bma_uvrq_menopage3
		bma_uvrq_c_menopage3;
run;

data base_uvrq_c_menopage3all (keep=Parameter ClassVal0 variable HazardRatio HRLowerCL HRUpperCL); 
	title1 'AARP Melanoma Baseline';
	title2 'Hazard Ratios for UVRQ';
	title3 'By Age at Menopause3 and UVQR quartile';
	title4 '20160524TUE WTL';
	set bin_uvrq_c_menopage3all 
		bma_uvrq_c_menopage3all; 
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\interactions\base.uvrq.menopage3.v20160524.xls' style=minimal;
proc print data= base_uvrq_c_menopage3all; run;
ods _all_ close; ods html; title;

** P-interaction for UVR * menop_age_3c;
title1 'HRT interaction uvrq~menopage3-Pint';
proc phreg data = use multipass;
	class menop_age_3c (ref='1. <45')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			uvrq_c menop_age_3c menop_age_3c*uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq_menopage3_pint_ins;
run;
proc phreg data = use multipass;
	class menop_age_3c (ref='1. <45')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			uvrq_c menop_age_3c menop_age_3c*uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq_menopage3_pint_mal;
run;

ods _all_ close; ods html; title;

** P-interaction for UVR * menop_age_3c;
title1 'HRT interaction uvrq5~menopage3-Pint';
proc phreg data = use multipass;
	class menop_age_3c (ref='1. <45')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			uvrq_5c menop_age_3c menop_age_3c*uvrq_5c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq5_menopage3_pint_ins;
run;
proc phreg data = use multipass;
	class menop_age_3c (ref='1. <45')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			uvrq_5c menop_age_3c menop_age_3c*uvrq_5c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq5_menopage3_pint_mal;
run;
title;

/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
#
# Model building v1, interactions, ME: menopause age, UVRQ
# !!!! for baseline dataset !!!!
#
# uses the conv.melan datasets
#
# Created: May 19 2016
# Updated: v20160617FRI WTL
# Used IMS: anchovy
*******************************************************************/

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\formats.20150714.base.sas';

data use;
	set conv.melan;
run;
proc sort data=use; by uvrq_c; run;
proc means data=use;
	var exposure_jul_78_05;
	by uvrq_c;
run; /** 185.01, 212.36, 245.63, 265.17 **/

*******************************************************************************;
** Base: UVRQ Analysis by MENOPAGE                      ***********************;
*******************************************************************************;

** menopage 1 INSITU **;
title1 'HRT interaction menopage3-1'; 
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
	where menop_age_c=1;
	ods output ParameterEstimates=uvrq_menopage1;
run;

data bin_uvrq_menopage1; set uvrq_menopage1;
	where Parameter='uvrq_c';
	variable="bin_uvrq_menopage1    ";
run;

title1 'HRT interaction menopage3-1'; 
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
	where menop_age_c=1;
	ods output ParameterEstimates=uvrq_c_menopage1;
run;

data bin_uvrq_c_menopage1; set uvrq_c_menopage1;
	where Parameter='uvrq_c';
	variable="bin_uvrq_c_menopage1    ";
run;

** menopage 2 INSITU **;
title1 'HRT interaction menopage3-2'; 
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
	where menop_age_c=2;
	ods output ParameterEstimates=uvrq_menopage2;
run;

data bin_uvrq_menopage2; set uvrq_menopage2;
	where Parameter='uvrq_c';
	variable="bin_uvrq_menopage2    ";
run;

title1 'HRT interaction menopage3-2'; 
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
	where menop_age_c=2;
	ods output ParameterEstimates=uvrq_c_menopage2;
run;

data bin_uvrq_c_menopage2; set uvrq_c_menopage2;
	where Parameter='uvrq_c';
	variable="bin_uvrq_c_menopage2    ";
run;

** menopage 3 INSITU **;
title1 'HRT interaction menopage3-3'; 
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
	where menop_age_c=3;
	ods output ParameterEstimates=uvrq_menopage3;
run;

data bin_uvrq_menopage3; set uvrq_menopage3;
	where Parameter='uvrq_c';
	variable="bin_uvrq_menopage3    ";
run;

title1 'HRT interaction menopage3-3'; 
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
	where menop_age_c=3;
	ods output ParameterEstimates=uvrq_c_menopage3;
run;

data bin_uvrq_c_menopage3; set uvrq_c_menopage3;
	where Parameter='uvrq_c';
	variable="bin_uvrq_c_menopage3    ";
run;


** menopage all3 INSITU **;
data bin_uvrq_c_menopageall;
	set bin_uvrq_menopage1 
		bin_uvrq_c_menopage1
		bin_uvrq_menopage2
		bin_uvrq_c_menopage2
		bin_uvrq_menopage3
		bin_uvrq_c_menopage3;
run;


** menopage 1 MAL **;
title1 'HRT interaction menopage3-1'; 
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
	where menop_age_c=1;
	ods output ParameterEstimates=uvrq_menopage1;
run;

data bma_uvrq_menopage1; set uvrq_menopage1;
	where Parameter='uvrq_c';
	variable="bma_uvrq_menopage1    ";
run;

title1 'HRT interaction menopage3-1'; 
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
	where menop_age_c=1;
	ods output ParameterEstimates=uvrq_c_menopage1;
run;

data bma_uvrq_c_menopage1; set uvrq_c_menopage1;
	where Parameter='uvrq_c';
	variable="bma_uvrq_c_menopage1    ";
run;

** menopage 2 MAL **;
title1 'HRT interaction menopage3-2'; 
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
	where menop_age_c=2;
	ods output ParameterEstimates=uvrq_menopage2;
run;

data bma_uvrq_menopage2; set uvrq_menopage2;
	where Parameter='uvrq_c';
	variable="bma_uvrq_menopage2    ";
run;

title1 'HRT interaction menopage3-2'; 
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
	where menop_age_c=2;
	ods output ParameterEstimates=uvrq_c_menopage2;
run;

data bma_uvrq_c_menopage2; set uvrq_c_menopage2;
	where Parameter='uvrq_c';
	variable="bma_uvrq_c_menopage2    ";
run;

** menopage 3 MAL **;
title1 'HRT interaction menopage3-3'; 
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
	where menop_age_c=3;
	ods output ParameterEstimates=uvrq_menopage3;
run;

data bma_uvrq_menopage3; set uvrq_menopage3;
	where Parameter='uvrq_c';
	variable="bma_uvrq_menopage3    ";
run;

title1 'HRT interaction menopage3-3'; 
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
	where menop_age_c=3;
	ods output ParameterEstimates=uvrq_c_menopage3;
run;

data bma_uvrq_c_menopage3; set uvrq_c_menopage3;
	where Parameter='uvrq_c';
	variable="bma_uvrq_c_menopage3    ";
run;

** menopage all3 MAL **;
data bma_uvrq_c_menopageall;
	set bma_uvrq_menopage1
		bma_uvrq_c_menopage1
		bma_uvrq_menopage2
		bma_uvrq_c_menopage2
		bma_uvrq_menopage3
		bma_uvrq_c_menopage3;
run;

data base_uvrq_c_menopageall (keep=Parameter ClassVal0 variable HazardRatio HRLowerCL HRUpperCL); 
	title1 'AARP Melanoma Baseline';
	title2 'Hazard Ratios for UVRQ';
	title3 'By Age at Menopause and UVQR quartile';
	title4 '20160519THU WTL';
	set bin_uvrq_c_menopageall
		bma_uvrq_c_menopageall; 
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\interactions\base.uvrq.menopage.v20160519.xls' style=minimal;
proc print data= base_uvrq_c_menopageall; run;
ods _all_ close; ods html; title;

** P-interaction for UVR * menop_age_c;
title1 'HRT interaction uvr-menopage-P-int';
proc phreg data = use multipass;
	class menop_age_c (ref='1. <45')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			uvrq_c menop_age_c menop_age_c*uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq_c_menopage3;
run;
proc phreg data = use multipass;
	class menop_age_c (ref='1. <45')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			uvrq_c menop_age_c menop_age_c*uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq_c_menopage3;
run;

*******************************************************************;
** menopage4 1 MAL **;
** updated 20160520FRI WTL;
** with menop_age_4c with <45, 45-49, 50-54, 55+;
title1 'HRT interaction menopage4-1'; 
title2 'uvrq continuous ';
proc freq data=use;
 table menop_age_4c*melanoma_c;
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
	where menop_age_4c=1;
	ods output ParameterEstimates=uvrq_menopage1;
run;

data bma_uvrq_menopage1; set uvrq_menopage1;
	where Parameter='uvrq_c';
	variable="bma_uvrq_menopage1    ";
run;

title1 'HRT interaction menopage4-1'; 
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
	where menop_age_4c=1;
	ods output ParameterEstimates=uvrq_c_menopage1;
run;

data bma_uvrq_c_menopage1; set uvrq_c_menopage1;
	where Parameter='uvrq_c';
	variable="bma_uvrq_c_menopage1    ";
run;

** menopage4 2 MAL **;
title1 'HRT interaction menopage4-2'; 
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
	where menop_age_4c=2;
	ods output ParameterEstimates=uvrq_menopage2;
run;

data bma_uvrq_menopage2; set uvrq_menopage2;
	where Parameter='uvrq_c';
	variable="bma_uvrq_menopage2    ";
run;

title1 'HRT interaction menopage4-2'; 
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
	where menop_age_4c=2;
	ods output ParameterEstimates=uvrq_c_menopage2;
run;

data bma_uvrq_c_menopage2; set uvrq_c_menopage2;
	where Parameter='uvrq_c';
	variable="bma_uvrq_c_menopage2    ";
run;

** menopage4 3 MAL **;
title1 'HRT interaction menopage4-3'; 
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
	where menop_age_4c=3;
	ods output ParameterEstimates=uvrq_menopage3;
run;

data bma_uvrq_menopage3; set uvrq_menopage3;
	where Parameter='uvrq_c';
	variable="bma_uvrq_menopage3    ";
run;

title1 'HRT interaction menopage4-3'; 
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
	where menop_age_4c=3;
	ods output ParameterEstimates=uvrq_c_menopage3;
run;

data bma_uvrq_c_menopage3; set uvrq_c_menopage3;
	where Parameter='uvrq_c';
	variable="bma_uvrq_c_menopage3    ";
run;

** menopage4 4 MAL **;
title1 'HRT interaction menopage4-4'; 
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
	where menop_age_4c=4;
	ods output ParameterEstimates=uvrq_menopage4;
run;

data bma_uvrq_menopage4; set uvrq_menopage4;
	where Parameter='uvrq_c';
	variable="bma_uvrq_menopage4    ";
run;

title1 'HRT interaction menopage4-4'; 
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
	where menop_age_4c=4;
	ods output ParameterEstimates=uvrq_c_menopage4;
run;

data bma_uvrq_c_menopage4; set uvrq_c_menopage4;
	where Parameter='uvrq_c';
	variable="bma_uvrq_c_menopage4    ";
run;

** menopage all4 MAL **;
data bma_uvrq_c_menopage4all;
	set bma_uvrq_menopage1
		bma_uvrq_c_menopage1
		bma_uvrq_menopage2
		bma_uvrq_c_menopage2
		bma_uvrq_menopage3
		bma_uvrq_c_menopage3
		bma_uvrq_menopage4
		bma_uvrq_c_menopage4;
run;

data base_uvrq_c_menopage4all (keep=Parameter ClassVal0 variable HazardRatio HRLowerCL HRUpperCL); 
	title1 'AARP Melanoma Baseline';
	title2 'Hazard Ratios for UVRQ';
	title3 'By Age at Menopause4 and UVQR quartile';
	title4 '20160520FRI WTL';
	set bma_uvrq_c_menopage4all; 
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\interactions\base.uvrq.menopage4.v20160520.xls' style=minimal;
proc print data= base_uvrq_c_menopage4all; run;
ods _all_ close; ods html; title;

** P-interaction for UVR * menop_age_4c;
title1 'HRT interaction uvrq-menopage4-Pint';
proc phreg data = use multipass;
	class menop_age_4c (ref='1. <45')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			uvrq_c menop_age_4c menop_age_4c*uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq_menopage4_pint_ins;
run;
proc phreg data = use multipass;
	class menop_age_4c (ref='1. <45')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			uvrq_c menop_age_4c menop_age_4c*uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq_menopage4_pint_mal;
run;

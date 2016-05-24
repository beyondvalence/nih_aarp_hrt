/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
#
# Model building v1, interactions, ME: ever take hormones
# !!!! for baseline dataset !!!!
#
# uses the conv.melan datasets
#
# Created: May 19 2016
# Updated: v20160524TUE WTL
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************/

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\formats.20150714.base.sas';

data use;
	set conv.melan;
run;
proc sort data=use; by uvrq_c; run;
proc means data=use;
	var exposure_jul_78_05;
	by uvrq_c;
run; /** 185.01, 212.36, 245.63, 265.17 **/

*******************************************************************************;
** Base: UVRQ Analysis by FMENSTR                       ***********************;
*******************************************************************************;

** fmenstr 1 INSITU **;
title1 'HRT interaction fmenstr4-1'; 
title2 'uvrq continuous ';
proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_ins(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_c=0;
	ods output ParameterEstimates=uvrq_fmenstr1;
run;

data bin_uvrq_fmenstr1; set uvrq_fmenstr1;
	where Parameter='uvrq_c';
	variable="bin_uvrq_fmenstr1    ";
run;

title1 'HRT interaction fmenstr4-1'; 
title2 'uvrq_c cat';
proc phreg data = use multipass;
	class uvrq_c (ref='176.095 to 186.918')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_ins(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_c=0;
	ods output ParameterEstimates=uvrq_c_fmenstr1;
run;

data bin_uvrq_c_fmenstr1; set uvrq_c_fmenstr1;
	where Parameter='uvrq_c';
	variable="bin_uvrq_c_fmenstr1    ";
run;

** fmenstr 2 INSITU **;
title1 'HRT interaction fmenstr4-2'; 
title2 'uvrq continuous ';
proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_ins(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_c=1;
	ods output ParameterEstimates=uvrq_fmenstr2;
run;

data bin_uvrq_fmenstr2; set uvrq_fmenstr2;
	where Parameter='uvrq_c';
	variable="bin_uvrq_fmenstr2    ";
run;

title1 'HRT interaction fmenstr4-2'; 
title2 'uvrq_c cat';
proc phreg data = use multipass;
	class uvrq_c (ref='176.095 to 186.918')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_ins(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_c=1;
	ods output ParameterEstimates=uvrq_c_fmenstr2;
run;

data bin_uvrq_c_fmenstr2; set uvrq_c_fmenstr2;
	where Parameter='uvrq_c';
	variable="bin_uvrq_c_fmenstr2    ";
run;

** fmenstr 3 INSITU **;
title1 'HRT interaction fmenstr4-3'; 
title2 'uvrq continuous ';
proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_ins(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_c=2;
	ods output ParameterEstimates=uvrq_fmenstr3;
run;

data bin_uvrq_fmenstr3; set uvrq_fmenstr3;
	where Parameter='uvrq_c';
	variable="bin_uvrq_fmenstr3    ";
run;

title1 'HRT interaction fmenstr4-3'; 
title2 'uvrq_c cat';
proc phreg data = use multipass;
	class uvrq_c (ref='176.095 to 186.918')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_ins(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_c=2;
	ods output ParameterEstimates=uvrq_c_fmenstr3;
run;

data bin_uvrq_c_fmenstr3; set uvrq_c_fmenstr3;
	where Parameter='uvrq_c';
	variable="bin_uvrq_c_fmenstr3    ";
run;

** fmenstr 4 INSITU **;
title1 'HRT interaction fmenstr4-4'; 
title2 'uvrq continuous ';
proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_ins(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_c=3;
	ods output ParameterEstimates=uvrq_fmenstr4;
run;

data bin_uvrq_fmenstr4; set uvrq_fmenstr4;
	where Parameter='uvrq_c';
	variable="bin_uvrq_fmenstr4    ";
run;

title1 'HRT interaction fmenstr4-4'; 
title2 'uvrq_c cat';
proc phreg data = use multipass;
	class uvrq_c (ref='176.095 to 186.918')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_ins(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_c=3;
	ods output ParameterEstimates=uvrq_c_fmenstr4;
run;

data bin_uvrq_c_fmenstr4; set uvrq_c_fmenstr4;
	where Parameter='uvrq_c';
	variable="bin_uvrq_c_fmenstr4    ";
run;

** fmenstr all4 INSITU **;
data bin_uvrq_c_fmenstrall;
	set bin_uvrq_fmenstr1 
		bin_uvrq_c_fmenstr1
		bin_uvrq_fmenstr2
		bin_uvrq_c_fmenstr2
		bin_uvrq_fmenstr3
		bin_uvrq_c_fmenstr3
		bin_uvrq_fmenstr4
		bin_uvrq_c_fmenstr4;
run;


** fmenstr 1 MAL **;
title1 'HRT interaction fmenstr4-1'; 
title2 'uvrq continuous ';
proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_c=0;
	ods output ParameterEstimates=uvrq_fmenstr1;
run;

data bma_uvrq_fmenstr1; set uvrq_fmenstr1;
	where Parameter='uvrq_c';
	variable="bma_uvrq_fmenstr1    ";
run;

title1 'HRT interaction fmenstr4-1'; 
title2 'uvrq_c cat';
proc phreg data = use multipass;
	class uvrq_c (ref='176.095 to 186.918')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_c=0;
	ods output ParameterEstimates=uvrq_c_fmenstr1;
run;

data bma_uvrq_c_fmenstr1; set uvrq_c_fmenstr1;
	where Parameter='uvrq_c';
	variable="bma_uvrq_c_fmenstr1    ";
run;

** fmenstr 2 MAL **;
title1 'HRT interaction fmenstr4-2'; 
title2 'uvrq continuous ';
proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_c=1;
	ods output ParameterEstimates=uvrq_fmenstr2;
run;

data bma_uvrq_fmenstr2; set uvrq_fmenstr2;
	where Parameter='uvrq_c';
	variable="bma_uvrq_fmenstr2    ";
run;

title1 'HRT interaction fmenstr4-2'; 
title2 'uvrq_c cat';
proc phreg data = use multipass;
	class uvrq_c (ref='176.095 to 186.918')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_c=1;
	ods output ParameterEstimates=uvrq_c_fmenstr2;
run;

data bma_uvrq_c_fmenstr2; set uvrq_c_fmenstr2;
	where Parameter='uvrq_c';
	variable="bma_uvrq_c_fmenstr2    ";
run;

** fmenstr 3 MAL **;
title1 'HRT interaction fmenstr4-3'; 
title2 'uvrq continuous ';
proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_c=2;
	ods output ParameterEstimates=uvrq_fmenstr3;
run;

data bma_uvrq_fmenstr3; set uvrq_fmenstr3;
	where Parameter='uvrq_c';
	variable="bma_uvrq_fmenstr3    ";
run;

title1 'HRT interaction fmenstr4-3'; 
title2 'uvrq_c cat';
proc phreg data = use multipass;
	class uvrq_c (ref='176.095 to 186.918')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_c=2;
	ods output ParameterEstimates=uvrq_c_fmenstr3;
run;

data bma_uvrq_c_fmenstr3; set uvrq_c_fmenstr3;
	where Parameter='uvrq_c';
	variable="bma_uvrq_c_fmenstr3    ";
run;

** fmenstr 4 MAL **;
title1 'HRT interaction fmenstr4-4'; 
title2 'uvrq continuous ';
proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_c=3;
	ods output ParameterEstimates=uvrq_fmenstr4;
run;

data bma_uvrq_fmenstr4; set uvrq_fmenstr4;
	where Parameter='uvrq_c';
	variable="bma_uvrq_fmenstr4    ";
run;

title1 'HRT interaction fmenstr4-4'; 
title2 'uvrq_c cat';
proc phreg data = use multipass;
	class uvrq_c (ref='176.095 to 186.918')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_c=3;
	ods output ParameterEstimates=uvrq_c_fmenstr4;
run;

data bma_uvrq_c_fmenstr4; set uvrq_c_fmenstr4;
	where Parameter='uvrq_c';
	variable="bma_uvrq_c_fmenstr4    ";
run;

** fmenstr all4 MAL **;
data bma_uvrq_c_fmenstrall;
	set bma_uvrq_fmenstr1
		bma_uvrq_c_fmenstr1
		bma_uvrq_fmenstr2
		bma_uvrq_c_fmenstr2
		bma_uvrq_fmenstr3
		bma_uvrq_c_fmenstr3
		bma_uvrq_fmenstr4
		bma_uvrq_c_fmenstr4;
run;

data base_uvrq_c_fmenstrall (keep=Parameter ClassVal0 variable HazardRatio HRLowerCL HRUpperCL); 
	title1 'AARP Melanoma Baseline';
	title2 'Hazard Ratios for UVRQ';
	title3 'By Age at Menarche and UVQR quartile';
	title4 '20160524TUE WTL';
	set bin_uvrq_c_fmenstrall
		bma_uvrq_c_fmenstrall; 
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\interactions\base.uvrq.fmenstr.v20160524.xls' style=minimal;
proc print data= base_uvrq_c_fmenstrall; run;
ods _all_ close; ods html;

********************************************************************************;
** Pint for fmenstr;
proc phreg data = use multipass;
	class fmenstr_me (ref='4. 15+')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_ins(0)= 
			uvrq_c fmenstr_me uvrq_c*fmenstr_me
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq_fmenstr4_pint_ins;
run;
proc phreg data = use multipass;
	class fmenstr_me (ref='4. 15+')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			uvrq_c fmenstr_me uvrq_c*fmenstr_me
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq_fmenstr4_pint_mal;
run;


*********************************************************************************;
** age at menarche 2 categories, <=10 and 11+;
** fmenstr2 1 MAL **;
title1 'HRT interaction fmenstr2-1'; 
title2 'uvrq continuous ';
proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_2c=0;
	ods output ParameterEstimates=uvrq_fmenstr1;
run;

data bma_uvrq_fmenstr1; set uvrq_fmenstr1;
	where Parameter='uvrq_c';
	variable="bma_uvrq_fmenstr1    ";
run;

title1 'HRT interaction fmenstr2-1'; 
title2 'uvrq_c cat';
proc phreg data = use multipass;
	class uvrq_c (ref='176.095 to 186.918')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_2c=0;
	ods output ParameterEstimates=uvrq_c_fmenstr1;
run;

data bma_uvrq_c_fmenstr1; set uvrq_c_fmenstr1;
	where Parameter='uvrq_c';
	variable="bma_uvrq_c_fmenstr1    ";
run;

** fmenstr2 2 MAL **;
title1 'HRT interaction fmenstr2-2'; 
title2 'uvrq continuous ';
proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_2c=1;
	ods output ParameterEstimates=uvrq_fmenstr2;
run;

data bma_uvrq_fmenstr2; set uvrq_fmenstr2;
	where Parameter='uvrq_c';
	variable="bma_uvrq_fmenstr2    ";
run;

title1 'HRT interaction fmenstr2-2'; 
title2 'uvrq_c cat';
proc phreg data = use multipass;
	class uvrq_c (ref='176.095 to 186.918')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			uvrq_c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where fmenstr_2c=1;
	ods output ParameterEstimates=uvrq_c_fmenstr2;
run;

data bma_uvrq_c_fmenstr2; set uvrq_c_fmenstr2;
	where Parameter='uvrq_c';
	variable="bma_uvrq_c_fmenstr2    ";
run;

** fmenstr2 2 MAL **;
data bma_uvrq_c_fmenstr2all;
	set bma_uvrq_fmenstr1
		bma_uvrq_c_fmenstr1
		bma_uvrq_fmenstr2
		bma_uvrq_c_fmenstr2;
run;

data base_uvrq_c_fmenstr2all (keep=Parameter ClassVal0 variable HazardRatio HRLowerCL HRUpperCL); 
	title1 'AARP Melanoma Baseline';
	title2 'Hazard Ratios for UVRQ';
	title3 'By Age at Menarche 2CAT and UVQR quartile';
	title4 '20160520FRI WTL';
	set bma_uvrq_c_fmenstr2all; 
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\interactions\base.uvrq.fmenstr2.v20160520.xls' style=minimal;
proc print data= base_uvrq_c_fmenstr2all; run;
ods _all_ close; ods html; title;

** P-interaction for UVR * fmenstr_2c;
title1 'HRT interaction fmenstr2-Pint';
proc phreg data = use multipass;
	class fmenstr_2c (ref='2. 11+')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			uvrq_c fmenstr_2c uvrq_c*fmenstr_2c
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq_c_fmenstr2;
run;

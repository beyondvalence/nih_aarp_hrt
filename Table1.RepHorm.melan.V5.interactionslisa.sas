/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
#
# Model building v1, interactions, ME: ever take hormones
# !!!! for baseline dataset !!!!
#
# uses the conv.melan datasets
#
# Created: April 22 2015
# Updated: v20160517TUE WTL
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************/

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
libname results 'C:\REB\AARP_HRTandMelanoma\Results\baseline\mht';


********************************************************************************;
** Interactions ****************************************************************;
********************************************************************************;
** Analysis of 1 Potential Confounder ******************************************;
********************************************************************************;

ods _all_ close; ods html;

%include 'C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\formats.20150714.base.sas';

data use;
	set conv.melan;
run;

*******************************************************************************;
** Base: FMENSTR Analysis by UVRQ                       ***********************;
*******************************************************************************;
** UVRQ = 1 ****************************;
** uvrq_c * fmenstr;
proc phreg data = use multipass;
	class fmenstr_me (ref='4. 15+')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_ins(0)= 
			fmenstr_me
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where uvrq_c=1;
	ods output ParameterEstimates=fmenstr_uvrq1;
run;
data bin_fmenstr_uvrq1; set fmenstr_uvrq1;
	where Parameter='fmenstr_me';
	variable="bin_fmenstr_uvrq1    ";
run;

** uvrq_c * fmenstr;
proc phreg data = use multipass;
	class fmenstr_me (ref='4. 15+')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			fmenstr_me
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where uvrq_c=1;
	ods output ParameterEstimates=fmenstr_uvrq1;
run;
data bma_fmenstr_uvrq1; set fmenstr_uvrq1;
	where Parameter='fmenstr_me';
	variable="bma_fmenstr_uvrq1    ";
	uvr = 'UVRQ 1';
run;

** UVRQ = 2 ****************************;
** uvrq_c * fmenstr;
proc phreg data = use multipass;
	class fmenstr_me (ref='4. 15+')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_ins(0)= 
			fmenstr_me
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where uvrq_c=2;
	ods output ParameterEstimates=fmenstr_uvrq2;
run;
data bin_fmenstr_uvrq2; set fmenstr_uvrq2;
	where Parameter='fmenstr_me';
	variable="bin_fmenstr_uvrq2    ";
run;

** uvrq_c * fmenstr;
proc phreg data = use multipass;
	class fmenstr_me (ref='4. 15+')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			fmenstr_me
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where uvrq_c=2;
	ods output ParameterEstimates=fmenstr_uvrq2;
run;
data bma_fmenstr_uvrq2; set fmenstr_uvrq2;
	where Parameter='fmenstr_me';
	variable="bma_fmenstr_uvrq2    ";
	uvr = 'UVRQ 2';
run;

** UVRQ = 3 ****************************;
** uvrq_c * fmenstr;
proc phreg data = use multipass;
	class fmenstr_me (ref='4. 15+')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_ins(0)= 
			fmenstr_me
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where uvrq_c=3;
	ods output ParameterEstimates=fmenstr_uvrq3;
run;
data bin_fmenstr_uvrq3; set fmenstr_uvrq3;
	where Parameter='fmenstr_me';
	variable="bin_fmenstr_uvrq3    ";
run;

** uvrq_c * fmenstr;
proc phreg data = use multipass;
	class fmenstr_me (ref='4. 15+')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			fmenstr_me
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where uvrq_c=3;
	ods output ParameterEstimates=fmenstr_uvrq3;
run;
data bma_fmenstr_uvrq3; set fmenstr_uvrq3;
	where Parameter='fmenstr_me';
	variable="bma_fmenstr_uvrq3    ";
	uvr = 'UVRQ 3';
run;

** UVRQ = 4 ****************************;
** uvrq_c * fmenstr;
proc phreg data = use multipass;
	class fmenstr_me (ref='4. 15+')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_ins(0)= 
			fmenstr_me
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where uvrq_c=4;
	ods output ParameterEstimates=fmenstr_uvrq4;
run;
data bin_fmenstr_uvrq4; set fmenstr_uvrq4;
	where Parameter='fmenstr_me';
	variable="bin_fmenstr_uvrq4    ";
run;

** uvrq_c * fmenstr;
proc phreg data = use multipass;
	class fmenstr_me (ref='4. 15+')
			educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') 
			smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') 
			colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='1. <45');
	model exit_age*melanoma_mal(0)= 
			fmenstr_me
			educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c
			/ entry = entry_age RL; 
	where uvrq_c=4;
	ods output ParameterEstimates=fmenstr_uvrq4;
run;
data bma_fmenstr_uvrq4; set fmenstr_uvrq4;
	where Parameter='fmenstr_me';
	variable="bma_fmenstr_uvrq4    ";
	uvr = 'UVRQ 4';
run;

ods _all_ close; ods html;
*Combine and output to Excel;
data base_fmenstr_uvrq (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set bin_fmenstr_uvrq1
		bma_fmenstr_uvrq1
		bin_fmenstr_uvrq2
		bma_fmenstr_uvrq2
		bin_fmenstr_uvrq3
		bma_fmenstr_uvrq3
		bin_fmenstr_uvrq4
		bma_fmenstr_uvrq4
	; 
run;
** use this one, without in situ;
data base_fmenstr_uvrq_mal (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set bma_fmenstr_uvrq1
		bma_fmenstr_uvrq2
		bma_fmenstr_uvrq3
		bma_fmenstr_uvrq4
	; 
run;
data base_fmenstr_uvrqt (keep=Parameter ClassVal0 A_HR A_LL A_UL uvr); 
	title1 'AARP Melanoma Baseline';
	title2 'Hazard Ratios for Age at Menarche <=10 vs 15+';
	title3 'By UVQR quartile';
	title4 '20160517TUE WTL';
	set base_fmenstr_uvrq_mal; 
	where ClassVal0='1. 10>=';
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\interactions\base.fmenstr.uvrq.v3.xls' style=minimal;
proc print data= base_fmenstr_uvrqt; run;
ods _all_ close; ods html;

*******************************************************************************;
** fmenstri Analysis by UVRQ  base                       ***********************;
*******************************************************************************;
** UVRQ = 1 ****************************;
** uvrq_me * fmenstri;
proc phreg data = use multipass;
	class fmenstri_me (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_ins(0)= 
			fmenstri_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=1;
	ods output ParameterEstimates=fmenstri_uvrq1;
run;
data bin_fmenstri_uvrq1; set fmenstri_uvrq1;
	where Parameter='fmenstri_me';
	variable="bin_fmenstri_uvrq1    ";
run;

** uvrq_me * fmenstri;
proc phreg data = use multipass;
	class fmenstri_me (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			fmenstri_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=1;
	ods output ParameterEstimates=fmenstri_uvrq1;
run;
data bma_fmenstri_uvrq1; set fmenstri_uvrq1;
	where Parameter='fmenstri_me';
	variable="bma_fmenstri_uvrq1    ";
	uvr = 'UVRQ 1';
run;

** UVRQ = 2 ****************************;
** uvrq_me * fmenstri;
proc phreg data = use multipass;
	class fmenstri_me (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_ins(0)= 
			fmenstri_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=2;
	ods output ParameterEstimates=fmenstri_uvrq2;
run;
data bin_fmenstri_uvrq2; set fmenstri_uvrq2;
	where Parameter='fmenstri_me';
	variable="bin_fmenstri_uvrq2    ";
run;

** uvrq_me * fmenstri;
proc phreg data = use multipass;
	class fmenstri_me (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			fmenstri_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=2;
	ods output ParameterEstimates=fmenstri_uvrq2;
run;
data bma_fmenstri_uvrq2; set fmenstri_uvrq2;
	where Parameter='fmenstri_me';
	variable="bma_fmenstri_uvrq2    ";
	uvr = 'UVRQ 2';
run;

** UVRQ = 3 ****************************;
** uvrq_me * fmenstri;
proc phreg data = use multipass;
	class fmenstri_me (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_ins(0)= 
			fmenstri_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=3;
	ods output ParameterEstimates=fmenstri_uvrq3;
run;
data bin_fmenstri_uvrq3; set fmenstri_uvrq3;
	where Parameter='fmenstri_me';
	variable="bin_fmenstri_uvrq3    ";
run;

** uvrq_me * fmenstri;
proc phreg data = use multipass;
	class fmenstri_me (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			fmenstri_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=3;
	ods output ParameterEstimates=fmenstri_uvrq3;
run;
data bma_fmenstri_uvrq3; set fmenstri_uvrq3;
	where Parameter='fmenstri_me';
	variable="bma_fmenstri_uvrq3    ";
	uvr = 'UVRQ 3';
run;

** UVRQ = 4 ****************************;
** uvrq_me * fmenstri;
proc phreg data = use multipass;
	class fmenstri_me (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_ins(0)= 
			fmenstri_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=4;
	ods output ParameterEstimates=fmenstri_uvrq4;
run;
data bin_fmenstri_uvrq4; set fmenstri_uvrq4;
	where Parameter='fmenstri_me';
	variable="bin_fmenstri_uvrq4    ";
run;

** uvrq_me * fmenstri;
proc phreg data = use multipass;
	class fmenstri_me (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			fmenstri_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=4;
	ods output ParameterEstimates=fmenstri_uvrq4;
run;
data bma_fmenstri_uvrq4; set fmenstri_uvrq4;
	where Parameter='fmenstri_me';
	variable="bma_fmenstri_uvrq4    ";
	uvr = 'UVRQ 4';
run;

ods _all_ close; ods html;
*Combine and output to excel;
data base_fmenstri_uvrq (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set bin_fmenstri_uvrq1
		bma_fmenstri_uvrq1
		bin_fmenstri_uvrq2
		bma_fmenstri_uvrq2
		bin_fmenstri_uvrq3
		bma_fmenstri_uvrq3
		bin_fmenstri_uvrq4
		bma_fmenstri_uvrq4
	; 
run;
** use this one, without in situ;
data base_fmenstri_uvrq_mal (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set bma_fmenstri_uvrq1
		bma_fmenstri_uvrq2
		bma_fmenstri_uvrq3
		bma_fmenstri_uvrq4
	; 
run;
data base_fmenstri_uvrqt (keep=Parameter ClassVal0 A_HR A_LL A_UL uvr); 
	title1 'AARP Melanoma Baseline';
	title2 'Hazard Ratios for Age at Menarche <=10 vs 15+ (only)';
	title3 'By UVQR quartile';
	title4 '20150806THU WTL';
	title5 'new menop coding to include both 50+ age ranges';
	set base_fmenstri_uvrq_mal; 
	where ClassVal0='<=10';
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\interactions\base.fmenstri.uvrq.v2.xls' style=minimal;
proc print data= base_fmenstri_uvrqt; run;
ods _all_ close; ods html;

*******************************************************************************;
** fmenstri Analysis by UVRQ  base  trend               ***********************;
*******************************************************************************;
** UVRQ = 1 ****************************;
** uvrq_me * fmenstri;
ods output TrendTest=Table1Trd  
	(keep=Table Name1 cValue1 rename=(cValue1=TrendPvalue) 
	where=(Name1='P2_TREND'));
proc freq data = use;
	tables melanoma_ins *( 
			fmenstri_me
			)
			/ trend nocol nopercent scores=table; 
	where uvrq=1;
run;
data bin_fmenstri_uvrq1; 
	set Table1Trd (keep=Table TrendPvalue); 
run;


** uvrq_me * fmenstri;
ods output TrendTest=Table1Trd  
	(keep=Table Name1 cValue1 rename=(cValue1=TrendPvalue) 
	where=(Name1='P2_TREND'));
proc freq data = use;
	tables melanoma_mal *( 
			fmenstri_me
			)
			/ trend nocol nopercent scores=table; 
	where uvrq=1;
run;
data bma_fmenstri_uvrq1; 
	set Table1Trd (keep=Table TrendPvalue); 
	uvr = 'UVRQ 1';
run;

** UVRQ = 2 ****************************;
** uvrq_me * fmenstri;
ods output TrendTest=Table1Trd  
	(keep=Table Name1 cValue1 rename=(cValue1=TrendPvalue) 
	where=(Name1='P2_TREND'));
proc freq data = use;
	tables melanoma_ins *( 
			fmenstri_me
			)
			/ trend nocol nopercent scores=table; 
	where uvrq=2;
run;
data bin_fmenstri_uvrq2; 
	set Table1Trd (keep=Table TrendPvalue); 
run;

ods output TrendTest=Table1Trd  
	(keep=Table Name1 cValue1 rename=(cValue1=TrendPvalue) 
	where=(Name1='P2_TREND'));
proc freq data = use;
	tables melanoma_mal *( 
			fmenstri_me
			)
			/ trend nocol nopercent scores=table; 
	where uvrq=2;
run;
data bma_fmenstri_uvrq2; 
	set Table1Trd (keep=Table TrendPvalue); 
	uvr = 'UVRQ 2';
run;

** UVRQ = 3 ****************************;
** uvrq_me * fmenstri;
ods output TrendTest=Table1Trd  
	(keep=Table Name1 cValue1 rename=(cValue1=TrendPvalue) 
	where=(Name1='P2_TREND'));
proc freq data = use;
	tables melanoma_ins *( 
			fmenstri_me
			)
			/ trend nocol nopercent scores=table; 
	where uvrq=3;
run;
data bin_fmenstri_uvrq3; 
	set Table1Trd (keep=Table TrendPvalue); 
run;

ods output TrendTest=Table1Trd  
	(keep=Table Name1 cValue1 rename=(cValue1=TrendPvalue) 
	where=(Name1='P2_TREND'));
proc freq data = use;
	tables melanoma_mal *( 
			fmenstri_me
			)
			/ trend nocol nopercent scores=table; 
	where uvrq=3;
run;
data bma_fmenstri_uvrq3; 
	set Table1Trd (keep=Table TrendPvalue); 
	uvr = 'UVRQ 3';
run;

** UVRQ = 4 ****************************;
** uvrq_me * fmenstri;
ods output TrendTest=Table1Trd  
	(keep=Table Name1 cValue1 rename=(cValue1=TrendPvalue) 
	where=(Name1='P2_TREND'));
proc freq data = use;
	tables melanoma_ins *( 
			fmenstri_me
			)
			/ trend nocol nopercent scores=table; 
	where uvrq=4;
run;
data bin_fmenstri_uvrq4; 
	set Table1Trd (keep=Table TrendPvalue); 
run;

ods output TrendTest=Table1Trd  
	(keep=Table Name1 cValue1 rename=(cValue1=TrendPvalue) 
	where=(Name1='P2_TREND'));
proc freq data = use;
	tables melanoma_mal *( 
			fmenstri_me
			)
			/ trend nocol nopercent scores=table; 
	where uvrq=4;
run;
data bma_fmenstri_uvrq4; 
	set Table1Trd (keep=Table TrendPvalue); 
	uvr = 'UVRQ 4';
run;

ods _all_ close; ods html;
*Combine and output to excel;
data base_fmenstri_uvrq (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set bin_fmenstri_uvrq1
		bma_fmenstri_uvrq1
		bin_fmenstri_uvrq2
		bma_fmenstri_uvrq2
		bin_fmenstri_uvrq3
		bma_fmenstri_uvrq3
		bin_fmenstri_uvrq4
		bma_fmenstri_uvrq4
	; 
run;
** use this one, without in situ;
data base_fmenstri_uvrq_mal; 
	set bma_fmenstri_uvrq1
		bma_fmenstri_uvrq2
		bma_fmenstri_uvrq3
		bma_fmenstri_uvrq4
	; 
run;
data base_fmenstri_uvrqt; 
	title1 'AARP Melanoma Baseline';
	title2 'P Trends for Age at Menarche <=10 vs 15+, only';
	title3 'By UVQR quartile';
	title4 '20150806THU WTL';
	set base_fmenstri_uvrq_mal; 
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\interactions\base.fmenstri.uvrq.ptrend.v1.xls' style=minimal;
proc print data= base_fmenstri_uvrqt; run;
ods _all_ close; ods html;


data use_r;
	set conv.melan_r;
run;

*******************************************************************************;
** FMENSTR Analysis by UVRQ  risk                       ***********************;
*******************************************************************************;
** UVRQ = 1 ****************************;
** uvrq_me * fmenstr;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_ins(0)= 
			fmenstr_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=1;
	ods output ParameterEstimates=fmenstr_uvrq1;
run;
data rin_fmenstr_uvrq1; set fmenstr_uvrq1;
	where Parameter='fmenstr_me';
	variable="rin_fmenstr_uvrq1    ";
run;

** uvrq_me * fmenstr;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			fmenstr_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=1;
	ods output ParameterEstimates=fmenstr_uvrq1;
run;
data rma_fmenstr_uvrq1; set fmenstr_uvrq1;
	where Parameter='fmenstr_me';
	variable="rma_fmenstr_uvrq1    ";
	uvr = 'UVRQ 1';
run;

** UVRQ = 2 ****************************;
** uvrq_me * fmenstr;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_ins(0)= 
			fmenstr_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=2;
	ods output ParameterEstimates=fmenstr_uvrq2;
run;
data rin_fmenstr_uvrq2; set fmenstr_uvrq2;
	where Parameter='fmenstr_me';
	variable="rin_fmenstr_uvrq2    ";
run;

** uvrq_me * fmenstr;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			fmenstr_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=2;
	ods output ParameterEstimates=fmenstr_uvrq2;
run;
data rma_fmenstr_uvrq2; set fmenstr_uvrq2;
	where Parameter='fmenstr_me';
	variable="rma_fmenstr_uvrq2    ";
	uvr = 'UVRQ 2';
run;

** UVRQ = 3 ****************************;
** uvrq_me * fmenstr;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_ins(0)= 
			fmenstr_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=3;
	ods output ParameterEstimates=fmenstr_uvrq3;
run;
data rin_fmenstr_uvrq3; set fmenstr_uvrq3;
	where Parameter='fmenstr_me';
	variable="rin_fmenstr_uvrq3    ";
run;

** uvrq_me * fmenstr;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			fmenstr_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=3;
	ods output ParameterEstimates=fmenstr_uvrq3;
run;
data rma_fmenstr_uvrq3; set fmenstr_uvrq3;
	where Parameter='fmenstr_me';
	variable="rma_fmenstr_uvrq3    ";
	uvr = 'UVRQ 3';
run;

** UVRQ = 4 ****************************;
** uvrq_me * fmenstr;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_ins(0)= 
			fmenstr_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=4;
	ods output ParameterEstimates=fmenstr_uvrq4;
run;
data rin_fmenstr_uvrq4; set fmenstr_uvrq4;
	where Parameter='fmenstr_me';
	variable="rin_fmenstr_uvrq4    ";
run;

** uvrq_me * fmenstr;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			fmenstr_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=4;
	ods output ParameterEstimates=fmenstr_uvrq4;
run;
data rma_fmenstr_uvrq4; set fmenstr_uvrq4;
	where Parameter='fmenstr_me';
	variable="rma_fmenstr_uvrq4    ";
	uvr = 'UVRQ 4';
run;

ods _all_ close; ods html;
*Comrine and output to excel;
data risk_fmenstr_uvrq (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set rin_fmenstr_uvrq1
		rma_fmenstr_uvrq1
		rin_fmenstr_uvrq2
		rma_fmenstr_uvrq2
		rin_fmenstr_uvrq3
		rma_fmenstr_uvrq3
		rin_fmenstr_uvrq4
		rma_fmenstr_uvrq4
	; 
run;
** use this one, without in situ;
data risk_fmenstr_uvrq_mal (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set rma_fmenstr_uvrq1
		rma_fmenstr_uvrq2
		rma_fmenstr_uvrq3
		rma_fmenstr_uvrq4
	; 
run;
data risk_fmenstr_uvrqt (keep=Parameter ClassVal0 A_HR A_LL A_UL uvr); 
	title1 'AARP Melanoma risk';
	title2 'Hazard Ratios for Age at Menarche <=10 vs 15+';
	title3 'By UVQR quartile';
	title4 '20150806THU WTL';
	set risk_fmenstr_uvrq_mal; 
	where ClassVal0='<=10';
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\interactions\risk.fmenstr.uvrq.v1.xls' style=minimal;
proc print data= risk_fmenstr_uvrqt; run;
ods _all_ close; ods html;

*******************************************************************************;
** flbage Analysis by UVRQ                             ***********************;
*******************************************************************************;
** UVRQ = 1 ****************************;
** uvrq_me * flbage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_ins(0)= 
			flb_age_c_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=1;
	ods output ParameterEstimates=flbage_uvrq1;
run;
data bin_flbage_uvrq1; set flbage_uvrq1;
	where Parameter='flb_age_c_me';
	variable="bin_flbage_uvrq1    ";
run;

** uvrq_me * flbage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			flb_age_c_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=1;
	ods output ParameterEstimates=flbage_uvrq1;
run;
data bma_flbage_uvrq1; set flbage_uvrq1;
	where Parameter='flb_age_c_me';
	variable="bma_flbage_uvrq1    ";
	uvr = 'UVRQ 1';
run;

** UVRQ = 2 ****************************;
** uvrq_me * flbage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_ins(0)= 
			flb_age_c_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=2;
	ods output ParameterEstimates=flbage_uvrq2;
run;
data bin_flbage_uvrq2; set flbage_uvrq2;
	where Parameter='flb_age_c_me';
	variable="bin_flbage_uvrq2    ";
run;

** uvrq_me * flbage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			flb_age_c_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=2;
	ods output ParameterEstimates=flbage_uvrq2;
run;
data bma_flbage_uvrq2; set flbage_uvrq2;
	where Parameter='flb_age_c_me';
	variable="bma_flbage_uvrq2    ";
	uvr = 'UVRQ 2';
run;

** UVRQ = 3 ****************************;
** uvrq_me * flbage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_ins(0)= 
			flb_age_c_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=3;
	ods output ParameterEstimates=flbage_uvrq3;
run;
data bin_flbage_uvrq3; set flbage_uvrq3;
	where Parameter='flb_age_c_me';
	variable="bin_flbage_uvrq3    ";
run;

** uvrq_me * flbage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			flb_age_c_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=3;
	ods output ParameterEstimates=flbage_uvrq3;
run;
data bma_flbage_uvrq3; set flbage_uvrq3;
	where Parameter='flb_age_c_me';
	variable="bma_flbage_uvrq3    ";
	uvr = 'UVRQ 3';
run;

** UVRQ = 4 ****************************;
** uvrq_me * flbage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_ins(0)= 
			flb_age_c_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=4;
	ods output ParameterEstimates=flbage_uvrq4;
run;
data bin_flbage_uvrq4; set flbage_uvrq4;
	where Parameter='flb_age_c_me';
	variable="bin_flbage_uvrq4    ";
run;

** uvrq_me * flbage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			flb_age_c_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=4;
	ods output ParameterEstimates=flbage_uvrq4;
run;
data bma_flbage_uvrq4; set flbage_uvrq4;
	where Parameter='flb_age_c_me';
	variable="bma_flbage_uvrq4    ";
	uvr = 'UVRQ 4';
run;

ods _all_ close; ods html;
*Combine and output to excel;
data base_flbage_uvrq (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set bin_flbage_uvrq1
		bma_flbage_uvrq1
		bin_flbage_uvrq2
		bma_flbage_uvrq2
		bin_flbage_uvrq3
		bma_flbage_uvrq3
		bin_flbage_uvrq4
		bma_flbage_uvrq4
	; 
run;
** use this one, without in situ;
data base_flbage_uvrq_mal (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set bma_flbage_uvrq1
		bma_flbage_uvrq2
		bma_flbage_uvrq3
		bma_flbage_uvrq4
	; 
run;
data base_flbage_uvrqt (keep=Parameter ClassVal0 A_HR A_LL A_UL uvr); 
	title1 'AARP Melanoma Baseline';
	title2 'Hazard Ratios for Age at First Live Birth';
	title3 'By UVQR quartile';
	title4 '20150806THU WTL';
	set base_flbage_uvrq_mal; 
	*where ClassVal0='30s';
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\interactions\base.flbage.uvrq.v1.xls' style=minimal;
proc print data= base_flbage_uvrqt; run;
ods _all_ close; ods html;

*******************************************************************************;
** menostat Analysis by UVRQ                             ***********************;
*******************************************************************************;
** UVRQ = 1 ****************************;
** uvrq_me * menostat;
proc phreg data = use multipass;
	class menostat_c (ref='natural menopause')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_ins(0)= 
			menostat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=1;
	ods output ParameterEstimates=menostat_uvrq1;
run;
data bin_menostat_uvrq1; set menostat_uvrq1;
	where Parameter='menostat_c';
	variable="bin_menostat_uvrq1    ";
run;

** uvrq_me * menostat;
proc phreg data = use multipass;
	class menostat_c (ref='natural menopause')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			menostat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=1;
	ods output ParameterEstimates=menostat_uvrq1;
run;
data bma_menostat_uvrq1; set menostat_uvrq1;
	where Parameter='menostat_c';
	variable="bma_menostat_uvrq1    ";
	uvr = 'UVRQ 1';
run;

** UVRQ = 2 ****************************;
** uvrq_me * menostat;
proc phreg data = use multipass;
	class menostat_c (ref='natural menopause')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_ins(0)= 
			menostat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=2;
	ods output ParameterEstimates=menostat_uvrq2;
run;
data bin_menostat_uvrq2; set menostat_uvrq2;
	where Parameter='menostat_c';
	variable="bin_menostat_uvrq2    ";
run;

** uvrq_me * menostat;
proc phreg data = use multipass;
	class menostat_c (ref='natural menopause')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			menostat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=2;
	ods output ParameterEstimates=menostat_uvrq2;
run;
data bma_menostat_uvrq2; set menostat_uvrq2;
	where Parameter='menostat_c';
	variable="bma_menostat_uvrq2    ";
	uvr = 'UVRQ 2';
run;

** UVRQ = 3 ****************************;
** uvrq_me * menostat;
proc phreg data = use multipass;
	class menostat_c (ref='natural menopause')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_ins(0)= 
			menostat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=3;
	ods output ParameterEstimates=menostat_uvrq3;
run;
data bin_menostat_uvrq3; set menostat_uvrq3;
	where Parameter='menostat_c';
	variable="bin_menostat_uvrq3    ";
run;

** uvrq_me * menostat;
proc phreg data = use multipass;
	class menostat_c (ref='natural menopause')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			menostat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=3;
	ods output ParameterEstimates=menostat_uvrq3;
run;
data bma_menostat_uvrq3; set menostat_uvrq3;
	where Parameter='menostat_c';
	variable="bma_menostat_uvrq3    ";
	uvr = 'UVRQ 3';
run;

** UVRQ = 4 ****************************;
** uvrq_me * menostat;
proc phreg data = use multipass;
	class menostat_c (ref='natural menopause')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_ins(0)= 
			menostat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=4;
	ods output ParameterEstimates=menostat_uvrq4;
run;
data bin_menostat_uvrq4; set menostat_uvrq4;
	where Parameter='menostat_c';
	variable="bin_menostat_uvrq4    ";
run;

** uvrq_me * menostat;
proc phreg data = use multipass;
	class menostat_c (ref='natural menopause')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			menostat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	where uvrq=4;
	ods output ParameterEstimates=menostat_uvrq4;
run;
data bma_menostat_uvrq4; set menostat_uvrq4;
	where Parameter='menostat_c';
	variable="bma_menostat_uvrq4    ";
	uvr = 'UVRQ 4';
run;

ods _all_ close; ods html;
*Combine and output to excel;
data base_menostat_uvrq (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set bin_menostat_uvrq1
		bma_menostat_uvrq1
		bin_menostat_uvrq2
		bma_menostat_uvrq2
		bin_menostat_uvrq3
		bma_menostat_uvrq3
		bin_menostat_uvrq4
		bma_menostat_uvrq4
	; 
run;
** use this one, without in situ;
data base_menostat_uvrq_mal (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set bma_menostat_uvrq1
		bma_menostat_uvrq2
		bma_menostat_uvrq3
		bma_menostat_uvrq4
	; 
run;
data base_menostat_uvrqt (keep=Parameter ClassVal0 A_HR A_LL A_UL uvr); 
	title1 'AARP Melanoma Baseline';
	title2 'Hazard Ratios for Menopausal Reason';
	title3 'By UVQR quartile';
	title4 '20150806THU WTL';
	set base_menostat_uvrq_mal; 
	*where ClassVal0='30s';
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\interactions\base.menostat.uvrq.v1.xls' style=minimal;
proc print data= base_menostat_uvrqt; run;
ods _all_ close; ods html;


*******************************************************************************;
** UVRQ Interaction Analysis with menostat and fmenstr ***********************;
** both continuous ;
*******************************************************************************;
** uvrq_me * fmenstr;
proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45') menostat_c ;
	model exit_age*melanoma_mal(0)= 
			uvrq_me*menostat_c uvrq_me fmenstr_me educ_c bmi_c smoke_former rel_1d_cancer marriage 
			colo_sig_any mht_ever  menostat_c
			/ entry = entry_age RL; 

run;

proc freq data=use; tables menop_age/missing; run;

proc phreg data = use multipass;
	class 
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			uvrq_me fmenstr_me uvrq_me*fmenstr_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	*where uvrq=1;
	ods output Type3=uvrq_fmenstri;
run;
data bmal_uvrq_fmenstr; set uvrq_fmenstri;
	if Effect='uvrq_me*fmenstr_me';
	variable="uvrq_fmenstri_bmal     ";
run;

*******************************************************************************;
** UVRQ Interaction Analysis with menop_age and fmenstr ***********************;
** Lisa test ******************************************************************;
*******************************************************************************;
** uvrq_me * fmenstr;
proc phreg data = use multipass;
	class   fmenstr_me (ref='<=10')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			uvrq_me fmenstr_me uvrq_me*fmenstr_me
			educ_c bmi_c 
			/ entry = entry_age RL; 
title 'switched reference, basic model';

run;
proc phreg data = use multipass;
	class   fmenstr (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			uvrq_me fmenstr uvrq_me*fmenstr
			educ_c bmi_c smoke_former rel_1d_cancer mht_ever menop_age marriage colo_sig_any
			/ entry = entry_age RL; 
title 'full model, include missings';
run;
proc phreg data = use multipass;
	class   fmenstr (ref='<=10')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			uvrq_me fmenstr uvrq_me*fmenstr
			educ_c bmi_c smoke_former rel_1d_cancer mht_ever menop_age marriage colo_sig_any
			/ entry = entry_age RL; 
title 'switched reference, include missings';
run;
proc phreg data = use multipass;
	class   fmenstr (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			uvrq_me fmenstr uvrq_me*fmenstr
			educ_c bmi_c 
			/ entry = entry_age RL; 
title 'basic model, include missings';
run;

proc phreg data = use multipass;
	class   fmenstr (ref='15+')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') menop_age (ref='<45');
	model exit_age*melanoma_mal(0)= 
			uvrq_me fmenstr uvrq_me*fmenstr 
			educ_c bmi_c 
			/ entry = entry_age RL; 
title 'basic model, include missings';
run;

*******************************************************************************;
** menopage Analysis by UVRQ  base                       **********************;
** for all menop_age_me by all 4 UVR quartile *********************************;
*******************************************************************************;
** UVRQ = 1 ****************************;
** uvrq_me * menopage;
proc phreg data = use multipass;
	class menop_age_me (ref='<45')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			menop_age_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever 
			/ entry = entry_age RL; 
	where uvrq=1;
	ods output ParameterEstimates=menopage_uvrq1;
run;
data bin_menopage_uvrq1; set menopage_uvrq1;
	where Parameter='menop_age_me';
	variable="bin_menopage_uvrq1    ";
run;

** uvrq_me * menopage;
proc phreg data = use multipass;
	class menop_age_me (ref='<45')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			menop_age_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever 
			/ entry = entry_age RL; 
	where uvrq=1;
	ods output ParameterEstimates=menopage_uvrq1;
run;
data bma_menopage_uvrq1; set menopage_uvrq1;
	where Parameter='menop_age_me';
	variable="bma_menopage_uvrq1    ";
	uvr = 'UVRQ 1';
run;

** UVRQ = 2 ****************************;
** uvrq_me * menopage;
proc phreg data = use multipass;
	class menop_age_me (ref='<45')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			menop_age_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever 
			/ entry = entry_age RL; 
	where uvrq=2;
	ods output ParameterEstimates=menopage_uvrq2;
run;
data bin_menopage_uvrq2; set menopage_uvrq2;
	where Parameter='menop_age_me';
	variable="bin_menopage_uvrq2    ";
run;

** uvrq_me * menopage;
proc phreg data = use multipass;
	class menop_age_me (ref='<45')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			menop_age_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever 
			/ entry = entry_age RL; 
	where uvrq=2;
	ods output ParameterEstimates=menopage_uvrq2;
run;
data bma_menopage_uvrq2; set menopage_uvrq2;
	where Parameter='menop_age_me';
	variable="bma_menopage_uvrq2    ";
	uvr = 'UVRQ 2';
run;

** UVRQ = 3 ****************************;
** uvrq_me * menopage;
proc phreg data = use multipass;
	class menop_age_me (ref='<45')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			menop_age_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever 
			/ entry = entry_age RL; 
	where uvrq=3;
	ods output ParameterEstimates=menopage_uvrq3;
run;
data bin_menopage_uvrq3; set menopage_uvrq3;
	where Parameter='menop_age_me';
	variable="bin_menopage_uvrq3    ";
run;

** uvrq_me * menopage;
proc phreg data = use multipass;
	class menop_age_me (ref='<45')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			menop_age_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever 
			/ entry = entry_age RL; 
	where uvrq=3;
	ods output ParameterEstimates=menopage_uvrq3;
run;
data bma_menopage_uvrq3; set menopage_uvrq3;
	where Parameter='menop_age_me';
	variable="bma_menopage_uvrq3    ";
	uvr = 'UVRQ 3';
run;

** UVRQ = 4 ****************************;
** uvrq_me * menopage;
proc phreg data = use multipass;
	class menop_age_me (ref='<45')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			menop_age_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever 
			/ entry = entry_age RL; 
	where uvrq=4;
	ods output ParameterEstimates=menopage_uvrq4;
run;
data bin_menopage_uvrq4; set menopage_uvrq4;
	where Parameter='menop_age_me';
	variable="bin_menopage_uvrq4    ";
run;

** uvrq_me * menopage;
proc phreg data = use multipass;
	class menop_age_me (ref='<45')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			menop_age_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever 
			/ entry = entry_age RL; 
	where uvrq=4;
	ods output ParameterEstimates=menopage_uvrq4;
run;
data bma_menopage_uvrq4; set menopage_uvrq4;
	where Parameter='menop_age_me';
	variable="bma_menopage_uvrq4    ";
	uvr = 'UVRQ 4';
run;

ods _all_ close; ods html;
*Combine and output to excel;
data base_menopage_uvrq (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set bin_menopage_uvrq1
		bma_menopage_uvrq1
		bin_menopage_uvrq2
		bma_menopage_uvrq2
		bin_menopage_uvrq3
		bma_menopage_uvrq3
		bin_menopage_uvrq4
		bma_menopage_uvrq4
	; 
run;
** use this one, without in situ;
data base_menopage_uvrq_mal (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set bma_menopage_uvrq1
		bma_menopage_uvrq2
		bma_menopage_uvrq3
		bma_menopage_uvrq4
	; 
run;
data base_menopage_uvrqt (keep=Parameter ClassVal0 A_HR A_LL A_UL uvr); 
	title1 'AARP Melanoma Baseline';
	title2 'Hazard Ratios for Age at Menopause <=45 vs 55+';
	title3 'By UVQR quartile';
	title4 '20150813THU WTL';
	title5 '';
	set base_menopage_uvrq_mal; 
	*where ClassVal0='55+';
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\interactions\base.menopage.uvrq.v1.xls' style=minimal;
proc print data= base_menopage_uvrqt; run;
ods _all_ close; ods html;

*******************************************************************************;
** parity Analysis by UVRQ  base                       ***********************;
*******************************************************************************;
** UVRQ = 1 ****************************;
** uvrq_me * parity;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			parity_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever 
			/ entry = entry_age RL; 
	where uvrq=1;
	ods output ParameterEstimates=parity_uvrq1;
run;
data bin_parity_uvrq1; set parity_uvrq1;
	where Parameter='parity_me';
	variable="bin_parity_uvrq1    ";
run;

** uvrq_me * parity;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			parity_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever 
			/ entry = entry_age RL; 
	where uvrq=1;
	ods output ParameterEstimates=parity_uvrq1;
run;
data bma_parity_uvrq1; set parity_uvrq1;
	where Parameter='parity_me';
	variable="bma_parity_uvrq1    ";
	uvr = 'UVRQ 1';
run;

** UVRQ = 2 ****************************;
** uvrq_me * parity;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			parity_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever 
			/ entry = entry_age RL; 
	where uvrq=2;
	ods output ParameterEstimates=parity_uvrq2;
run;
data bin_parity_uvrq2; set parity_uvrq2;
	where Parameter='parity_me';
	variable="bin_parity_uvrq2    ";
run;

** uvrq_me * parity;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			parity_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever 
			/ entry = entry_age RL; 
	where uvrq=2;
	ods output ParameterEstimates=parity_uvrq2;
run;
data bma_parity_uvrq2; set parity_uvrq2;
	where Parameter='parity_me';
	variable="bma_parity_uvrq2    ";
	uvr = 'UVRQ 2';
run;

** UVRQ = 3 ****************************;
** uvrq_me * parity;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			parity_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever 
			/ entry = entry_age RL; 
	where uvrq=3;
	ods output ParameterEstimates=parity_uvrq3;
run;
data bin_parity_uvrq3; set parity_uvrq3;
	where Parameter='parity_me';
	variable="bin_parity_uvrq3    ";
run;

** uvrq_me * parity;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			parity_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever 
			/ entry = entry_age RL; 
	where uvrq=3;
	ods output ParameterEstimates=parity_uvrq3;
run;
data bma_parity_uvrq3; set parity_uvrq3;
	where Parameter='parity_me';
	variable="bma_parity_uvrq3    ";
	uvr = 'UVRQ 3';
run;

** UVRQ = 4 ****************************;
** uvrq_me * parity;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') ;
	model exit_age*melanoma_ins(0)= 
			parity_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever 
			/ entry = entry_age RL; 
	where uvrq=4;
	ods output ParameterEstimates=parity_uvrq4;
run;
data bin_parity_uvrq4; set parity_uvrq4;
	where Parameter='parity_me';
	variable="bin_parity_uvrq4    ";
run;

** uvrq_me * parity;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never') ;
	model exit_age*melanoma_mal(0)= 
			parity_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever 
			/ entry = entry_age RL; 
	where uvrq=4;
	ods output ParameterEstimates=parity_uvrq4;
run;
data bma_parity_uvrq4; set parity_uvrq4;
	where Parameter='parity_me';
	variable="bma_parity_uvrq4    ";
	uvr = 'UVRQ 4';
run;

ods _all_ close; ods html;
*Combine and output to excel;
data base_parity_uvrq (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set bin_parity_uvrq1
		bma_parity_uvrq1
		bin_parity_uvrq2
		bma_parity_uvrq2
		bin_parity_uvrq3
		bma_parity_uvrq3
		bin_parity_uvrq4
		bma_parity_uvrq4
	; 
run;
** use this one, without in situ;
data base_parity_uvrq_mal (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set bma_parity_uvrq1
		bma_parity_uvrq2
		bma_parity_uvrq3
		bma_parity_uvrq4
	; 
run;
data base_parity_uvrqt (keep=Parameter ClassVal0 A_HR A_LL A_UL uvr); 
	title1 'AARP Melanoma Baseline';
	title2 'Hazard Ratios for Parity, 1-2 ref';
	title3 'By UVQR quartile';
	title4 '20150813THU WTL';
	title5 '';
	set base_parity_uvrq_mal; 
	*where ClassVal0='55+';
run;
proc sort data=base_parity_uvrqt;
	by ClassVal0 uvr;
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\interactions\base.parity.uvrq.v1.xls' style=minimal;
proc print data= base_parity_uvrqt; run;
ods _all_ close; ods html;










data uvrq_fmenstri_bmal; set uvrqfmenstri;
	if Effect='uvrq_me*fmenstr_me';
	variable="uvrq_fmenstr_bmal     ";
run;


***********************************************************;
** interaction tests 20150813THU WTL;
** uvrq_me * menopi_age;
** but now try to menopi_age with the 50+ rather than 55+;
** and also continuous uvr;
proc phreg data = use multipass;
	title1 'baseline - malignant melanoma';
	title2 'uvr continuous vs menopi_age interaction';
	class uvrq_me (ref='0 to 186.918') menopi_age_me (ref='<45')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never');
	model exit_age*melanoma_mal(0)= 
			uvrq_me menopi_age_me uvrq_me*menopi_age_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever
			/ entry = entry_age RL; 
	*where uvrq=1;
	ods output Type3=uvrmenopi;
run;
data uvr_menopiage_bmal; set uvrmenopi;
	if Effect='uvrq_me*menopi_age_m';
	variable="uvrq_menopiage_bmal    ";
run;
** and also with categorical uvrq, edit 20150813THU WTL;
** uvrq_me * menop_age;
proc phreg data = use multipass;
	title1 'baseline - malignant melanoma';
	title2 'uvrq cat vs menopi_age interaction';
	class uvrq_me (ref='0 to 186.918') menopi_age_me (ref='<45')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever (ref='Never');
	model exit_age*melanoma_mal(0)= 
			uvrq_me menopi_age_me uvrq_me*menopi_age_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever
			/ entry = entry_age RL; 
	*where uvrq=1;
	ods output Type3=uvrqmenopi;
run;
data uvrq_menopiage_bmal; set uvrqmenopi;
	if Effect='uvrq_me*menopi_age_m';
	variable="uvrq_menopiage_bmal    ";
run;

ods _all_ close; ods html;
*Combine and output to excel;
data base_uvrq_int_testing; 
	set uvrq_fmenstri_bins
		uvrq_fmenstri_bmal
		uvrq_menopage_bins
		uvrq_menopage_bmal
	; 
run;
data base_uvrq_int_testing; 
	set base_uvrq_int_testing
	(Keep= variable ProbChiSq ); 
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\interactions\interaction.base.uvrq.v1.xls' style=minimal;
proc print data= base_uvrq_int_testing; run;
ods _all_ close; ods html;


********************************************************************************;
** baseline, melanoma, exp: MHTever, in situ, educ_c, bmic_, 3 conf **;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, in situ';
	title2 'Exposure: MHTever';
	title3 'interactions';
	title4 '20150804TUE WTL';
	class mht_ever_me  (ref='Never') menostat_c (ref='natural menopause') 
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			mht_ever_me menostat_c mht_ever_me*menostat_c
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=mhtmenoi;
run;
data mhtmenoi; set mhtmenoi;
	if Effect='mht_ever_*menostat_c';
	variable="mhtmenoi          ";
run;

** menop_age * menostat;
proc phreg data = use multipass;
	class menop_age_me (ref='<45') menostat_c (ref='natural menopause') 
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever  (ref='Never');
	model exit_age*melanoma_ins(0)= 
			menop_age_me menostat_c menop_age_me*menostat_c
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=menopagei;
run;
data menopagei; set menopagei;
	if Effect='menop_age*menostat_c';
	variable="menopagei";
run;

** menop_age * menostat, no cat;
proc phreg data = use multipass;
	class menostat_c (ref='natural menopause') 
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever  (ref='Never');
	model exit_age*melanoma_ins(0)= 
			menop_age_me menostat_c menop_age_me*menostat_c
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=menopagei2;
run;
data menopagei2; set menopagei2;
	if Effect='menop_age*menostat_c';
	variable="menopagei2";
run;

** mht_ever * parity;
proc phreg data = use multipass;
	class mht_ever_me  (ref='Never') parity (ref='1-2 live children') 
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			mht_ever_me parity mht_ever_me*parity
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=mhtparityi;
run;
data mhtparityi; set mhtparityi;
	if Effect='mht_ever_me*parity';
	variable="mhtparityi";
run;

** mht_ever * fmenstr;
proc phreg data = use multipass;
	class mht_ever_me  (ref='Never') fmenstr (ref='<=10')
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			mht_ever_me fmenstr mht_ever_me*fmenstr
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=mhtfmenstri;
run;
data mhtfmenstri; set mhtfmenstri;
	if Effect='mht_ever_me*fmenstr';
	variable="mhtfmenstri";
run;

** mht_ever * flb_age_c;
proc phreg data = use multipass;
	class mht_ever_me  (ref='Never') flb_age_c (ref='< 20 years old')
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			mht_ever_me flb_age_c mht_ever_me*flb_age_c
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=mhtflbi;
run;
data mhtflbi; set mhtflbi;
	if Effect='mht_ever_m*flb_age_c';
	variable="mhtflbi";
run; 

** mht_ever * oralbc_dur_c;
proc phreg data = use multipass;
	class mht_ever_me (ref='Never') oralbc_dur_c (ref='Never/<1yr')
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			mht_ever_me oralbc_dur_c mht_ever_me*oralbc_dur_c
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=mhtoralbci;
run;
data mhtoralbci; set mhtoralbci;
	if Effect='mht_ever_*oralbc_dur';
	variable="mhtoralbci";
run;

** start UVRQ vs all main effects;
** uvrq_me * mht_ever;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') mht_ever (ref='Never')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			uvrq_me mht_ever uvrq_me*mht_ever
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmhti;
run;
data uvrqmhti; set uvrqmhti;
	if Effect='uvrq_me*mht_ever';
	variable="uvrqmhti";
run;

** uvrq_me * fmenstr;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') fmenstr (ref='<=10')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			uvrq_me fmenstr uvrq_me*fmenstr
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqfmenstri;
run;
data uvrqfmenstri; set uvrqfmenstri;
	if Effect='uvrq_me*fmenstr';
	variable="uvrqfmenstri";
run;

** uvrq_me * menostat_c;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') menostat_c (ref='natural menopause')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			uvrq_me menostat_c uvrq_me*menostat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmenosti;
run;
data uvrqmenosti; set uvrqmenosti;
	if Effect='uvrq_me*menostat_c';
	variable="uvrqmenosti";
run;

** uvrq_me * ovarystat;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') ovarystat_c (ref='both removed')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			uvrq_me ovarystat_c uvrq_me*ovarystat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqovaryi;
run;
data uvrqovaryi; set uvrqovaryi;
	if Effect='uvrq_me*ovarystat_c';
	variable="uvrqovaryi";
run;

** uvrq_me * menop_age;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') menop_age (ref='<45')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			uvrq_me menop_age uvrq_me*menop_age
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmenopi;
run;
data uvrqmenopi; set uvrqmenopi;
	if Effect='uvrq_me*menop_age';
	variable="uvrqmenopi";
run;

** uvrq_me * parity;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') parity (ref='1-2 live children')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			uvrq_me parity uvrq_me*parity
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqparityi;
run;
data uvrqparityi; set uvrqparityi;
	if Effect='uvrq_me*parity';
	variable="uvrqparityi";
run;

** uvrq_me * flb_age_c;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') flb_age_c (ref='< 20 years old')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			uvrq_me flb_age_c uvrq_me*flb_age_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqflbai;
run;
data uvrqflbai; set uvrqflbai;
	if Effect='uvrq_me*flb_age_c';
	variable="uvrqflbai";
run;

** uvrq_me * oralbc_dur;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') oralbc_dur_c (ref='Never/<1yr')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			uvrq_me oralbc_dur_c uvrq_me*oralbc_dur_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqoralbci;
run;
data uvrqoralbci; set uvrqoralbci;
	if Effect='uvrq_me*oralbc_dur_c';
	variable="uvrqoralbci";
run;

******************;

ods _all_ close; ods html;
*Combine and output to excel;
data base_int_testing_ins; 
	set mhtmenoi
		menopagei
		menopagei2
		mhtparityi
		mhtfmenstri
		mhtflbi
		mhtoralbci

		uvrqmhti
		uvrqfmenstri
		uvrqmenosti
		uvrqovaryi
		uvrqmenopi
		uvrqparityi
		uvrqflbai
		uvrqoralbci
	; 
run;
data base_int_testing_ins; 
	set base_int_testing_ins
	(Keep= variable ProbChiSq); 
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\interactions\interaction.base.ins.v2.xls' style=minimal;
proc print data= base_int_testing_ins; run;
ods _all_ close; ods html;

********************************************************************************;
** baseline, melanoma, exp: hormever, malignant, educ_c, bmic_, 3 conf **;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, malignant';
	title2 'Exposure: MHTever';
	title3 'interactions';
	title4 '20150728TUE WTL';
	class mht_ever_me  (ref='Never') menostat_c (ref='natural menopause') 
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			mht_ever_me menostat_c mht_ever_me*menostat_c
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=mhteveri;
run;
data mhteveri; set mhteveri;
	if Effect='mht_ever_*menostat_c';
	variable="mhteveri";
run;
** menop_age * menostat;
proc phreg data = use multipass;
	class menop_age_me (ref='<45') menostat_c (ref='natural menopause') 
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever  (ref='Never');
	model exit_age*melanoma_mal(0)= 
			menop_age_me menostat_c menop_age_me*menostat_c
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=menopagei;
run;
data menopagei; set menopagei;
	if Effect='menop_age*menostat_c';
	variable="menopagei";
run;
** menop_age * menostat, no cat;
proc phreg data = use multipass;
	class menostat_c (ref='natural menopause') 
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever  (ref='Never');
	model exit_age*melanoma_mal(0)= 
			menop_age_me menostat_c menop_age_me*menostat_c
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=menopagei2;
run;
data menopagei2; set menopagei2;
	if Effect='menop_age*menostat_c';
	variable="menopagei2";
run;
** start UVRQ vs all main effects;
** uvrq_me * mht_ever;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') mht_ever (ref='Never')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me mht_ever uvrq_me*mht_ever
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmhti;
run;
data uvrqmhti; set uvrqmhti;
	if Effect='uvrq_me*mht_ever';
	variable="uvrqmhti";
run;

** uvrq_me * fmenstr;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') fmenstr (ref='<=10')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me fmenstr uvrq_me*fmenstr
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqfmenstri;
run;
data uvrqfmenstri; set uvrqfmenstri;
	if Effect='uvrq_me*fmenstr';
	variable="uvrqfmenstri";
run;

** uvrq_me * menostat_c;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') menostat_c (ref='natural menopause')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me menostat_c uvrq_me*menostat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmenosti;
run;
data uvrqmenosti; set uvrqmenosti;
	if Effect='uvrq_me*menostat_c';
	variable="uvrqmenosti";
run;

** uvrq_me * ovarystat;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') ovarystat_c (ref='both removed')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me ovarystat_c uvrq_me*ovarystat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqovaryi;
run;
data uvrqovaryi; set uvrqovaryi;
	if Effect='uvrq_me*ovarystat_c';
	variable="uvrqovaryi";
run;

** uvrq_me * menop_age;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') menop_age (ref='<45')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me menop_age uvrq_me*menop_age
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmenopi;
run;
data uvrqmenopi; set uvrqmenopi;
	if Effect='uvrq_me*menop_age';
	variable="uvrqmenopi";
run;

** uvrq_me * parity;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') parity (ref='1-2 live children')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me parity uvrq_me*parity
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqparityi;
run;
data uvrqparityi; set uvrqparityi;
	if Effect='uvrq_me*parity';
	variable="uvrqparityi";
run;

** uvrq_me * flb_age_c;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') flb_age_c (ref='< 20 years old')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me flb_age_c uvrq_me*flb_age_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqflbai;
run;
data uvrqflbai; set uvrqflbai;
	if Effect='uvrq_me*flb_age_c';
	variable="uvrqflbai";
run;

** uvrq_me * oralbc_dur;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') oralbc_dur_c (ref='Never/<1yr')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me oralbc_dur_c uvrq_me*oralbc_dur_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqoralbci;
run;
data uvrqoralbci; set uvrqoralbci;
	if Effect='uvrq_me*oralbc_dur_c';
	variable="uvrqoralbci";
run;

******************;

ods _all_ close; ods html;
*Combine and output to excel;
data base_int_testing_mal; 
	set mhtmenoi
		menopagei
		menopagei2
		mhtparityi
		mhtfmenstri
		mhtflbi
		mhtoralbci

		uvrqmhti
		uvrqfmenstri
		uvrqmenosti
		uvrqovaryi
		uvrqmenopi
		uvrqparityi
		uvrqflbai
		uvrqoralbci
	; 
run;

ods html close; ods _all_ close; ods html;

data base_int_testing_mal; 
	set base_int_testing_mal
	(Keep= variable ProbChiSq); 
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\interactions\interaction.base.mal.v2.xls' style=minimal;
proc print data= base_int_testing_mal; run;
ods _all_ close; ods html;

** for riskfactor ;
data use_r;
	set conv.melan_r;
run;

********************************************************************************;
** rfq, melanoma, exp: MHTever, in situ, educ_c, bmic_, 3 conf **;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP rfq: melanoma, in situ';
	title2 'Exposure: MHTever';
	title3 'interactions';
	title4 '20150729WED WTL';
	class mht_ever_me  (ref='Never') menostat_c (ref='natural menopause') 
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			mht_ever_me menostat_c mht_ever_me*menostat_c
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=mhtmenoi;
run;
data mhtmenoi; set mhtmenoi;
	if Effect='mht_ever_*menostat_c';
	variable="mhtmenoi";
run;

** menop_age * menostat;
proc phreg data = use_r multipass;
	class menop_age_me (ref='<45') menostat_c (ref='natural menopause') 
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever  (ref='Never');
	model exit_age*melanoma_ins(0)= 
			menop_age_me menostat_c menop_age_me*menostat_c
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=menopagei;
run;
data menopagei; set menopagei;
	if Effect='menop_age*menostat_c';
	variable="menopagei";
run;

** menop_age * menostat, no cat;
proc phreg data = use_r multipass;
	class menostat_c (ref='natural menopause') 
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever  (ref='Never');
	model exit_age*melanoma_ins(0)= 
			menop_age_me menostat_c menop_age_me*menostat_c
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=menopagei2;
run;
data menopagei2; set menopagei2;
	if Effect='menop_age*menostat_c';
	variable="menopagei2";
run;

** mht_ever * parity;
proc phreg data = use_r multipass;
	class mht_ever_me  (ref='Never') parity (ref='1-2 live children') 
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			mht_ever_me parity mht_ever_me*parity
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=mhtparityi;
run;
data mhtparityi; set mhtparityi;
	if Effect='mht_ever_me*parity';
	variable="mhtparityi";
run;

** mht_ever * fmenstr;
proc phreg data = use_r multipass;
	class mht_ever_me  (ref='Never') fmenstr (ref='<=10')
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			mht_ever_me fmenstr mht_ever_me*fmenstr
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=mhtfmenstri;
run;
data mhtfmenstri; set mhtfmenstri;
	if Effect='mht_ever_me*fmenstr';
	variable="mhtfmenstri";
run;

** mht_ever * flb_age_c;
proc phreg data = use_r multipass;
	class mht_ever_me  (ref='Never') flb_age_c (ref='< 20 years old')
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			mht_ever_me flb_age_c mht_ever_me*flb_age_c
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=mhtflbi;
run;
data mhtflbi; set mhtflbi;
	if Effect='mht_ever_m*flb_age_c';
	variable="mhtflbi";
run; 

** mht_ever * oralbc_dur_c;
proc phreg data = use_r multipass;
	class mht_ever_me (ref='Never') oralbc_dur_c (ref='Never/<1yr')
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			mht_ever_me oralbc_dur_c mht_ever_me*oralbc_dur_c
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=mhtoralbci;
run;
data mhtoralbci; set mhtoralbci;
	if Effect='mht_ever_*oralbc_dur';
	variable="mhtoralbci";
run;

** start UVRQ vs all main effects;
** uvrq_me * mht_ever;
proc phreg data = use_r multipass;
	class uvrq_me (ref='0 to 186.918') mht_ever (ref='Never')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			uvrq_me mht_ever uvrq_me*mht_ever
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmhti;
run;
data uvrqmhti; set uvrqmhti;
	if Effect='uvrq_me*mht_ever';
	variable="uvrqmhti";
run;

** uvrq_me * fmenstr;
proc phreg data = use_r multipass;
	class uvrq_me (ref='0 to 186.918') fmenstr (ref='<=10')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			uvrq_me fmenstr uvrq_me*fmenstr
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqfmenstri;
run;
data uvrqfmenstri; set uvrqfmenstri;
	if Effect='uvrq_me*fmenstr';
	variable="uvrqfmenstri";
run;

** uvrq_me * menostat_c;
proc phreg data = use_r multipass;
	class uvrq_me (ref='0 to 186.918') menostat_c (ref='natural menopause')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			uvrq_me menostat_c uvrq_me*menostat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmenosti;
run;
data uvrqmenosti; set uvrqmenosti;
	if Effect='uvrq_me*menostat_c';
	variable="uvrqmenosti";
run;

** uvrq_me * ovarystat;
proc phreg data = use_r multipass;
	class uvrq_me (ref='0 to 186.918') ovarystat_c (ref='both removed')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			uvrq_me ovarystat_c uvrq_me*ovarystat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqovaryi;
run;
data uvrqovaryi; set uvrqovaryi;
	if Effect='uvrq_me*ovarystat_c';
	variable="uvrqovaryi";
run;

** uvrq_me * menop_age;
proc phreg data = use_r multipass;
	class uvrq_me (ref='0 to 186.918') menop_age (ref='<45')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			uvrq_me menop_age uvrq_me*menop_age
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmenopi;
run;
data uvrqmenopi; set uvrqmenopi;
	if Effect='uvrq_me*menop_age';
	variable="uvrqmenopi";
run;

** uvrq_me * parity;
proc phreg data = use_r multipass;
	class uvrq_me (ref='0 to 186.918') parity (ref='1-2 live children')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			uvrq_me parity uvrq_me*parity
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqparityi;
run;
data uvrqparityi; set uvrqparityi;
	if Effect='uvrq_me*parity';
	variable="uvrqparityi";
run;

** uvrq_me * flb_age_c;
proc phreg data = use_r multipass;
	class uvrq_me (ref='0 to 186.918') flb_age_c (ref='< 20 years old')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			uvrq_me flb_age_c uvrq_me*flb_age_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqflbai;
run;
data uvrqflbai; set uvrqflbai;
	if Effect='uvrq_me*flb_age_c';
	variable="uvrqflbai";
run;

** uvrq_me * oralbc_dur;
proc phreg data = use_r multipass;
	class uvrq_me (ref='0 to 186.918') oralbc_dur_c (ref='Never/<1yr')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)= 
			uvrq_me oralbc_dur_c uvrq_me*oralbc_dur_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqoralbci;
run;
data uvrqoralbci; set uvrqoralbci;
	if Effect='uvrq_me*oralbc_dur_c';
	variable="uvrqoralbci";
run;

******************;

ods _all_ close; ods html;
*Combine and output to excel;
data risk_int_testing_ins; 
	set mhtmenoi
		menopagei
		menopagei2
		mhtparityi
		mhtfmenstri
		mhtflbi
		mhtoralbci

		uvrqmhti
		uvrqfmenstri
		uvrqmenosti
		uvrqovaryi
		uvrqmenopi
		uvrqparityi
		uvrqflbai
		uvrqoralbci
	; 
run;
data risk_int_testing_ins; 
	set risk_int_testing_ins
	(Keep= variable ProbChiSq); 
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\interactions\interaction.risk.ins.v1.xls' style=minimal;
proc print data= risk_int_testing_ins; run;
ods _all_ close; ods html;

********************************************************************************;
** rfq, melanoma, exp: hormever, malignant, educ_c, bmic_, 3 conf **;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP rfq: melanoma, malignant';
	title2 'Exposure: MHTever';
	title3 'interactions';
	title4 '20150729WED WTL';
	class mht_ever_me  (ref='Never') menostat_c (ref='natural menopause') 
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			mht_ever_me menostat_c mht_ever_me*menostat_c
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=mhteveri;
run;
data mhteveri; set mhteveri;
	if Effect='mht_ever_*menostat_c';
	variable="mhteveri";
run;
** menop_age * menostat;
proc phreg data = use_r multipass;
	class menop_age_me (ref='<45') menostat_c (ref='natural menopause') 
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever  (ref='Never');
	model exit_age*melanoma_mal(0)= 
			menop_age_me menostat_c menop_age_me*menostat_c
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=menopagei;
run;
data menopagei; set menopagei;
	if Effect='menop_age*menostat_c';
	variable="menopagei";
run;
** menop_age * menostat, no cat;
proc phreg data = use_r multipass;
	class menostat_c (ref='natural menopause') 
			uvrq (ref='0 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No') mht_ever  (ref='Never');
	model exit_age*melanoma_mal(0)= 
			menop_age_me menostat_c menop_age_me*menostat_c
			uvrq educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=menopagei2;
run;
data menopagei2; set menopagei2;
	if Effect='menop_age*menostat_c';
	variable="menopagei2";
run;
** start UVRQ vs all main effects;
** uvrq_me * mht_ever;
proc phreg data = use_r multipass;
	class uvrq_me (ref='0 to 186.918') mht_ever (ref='Never')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me mht_ever uvrq_me*mht_ever
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmhti;
run;
data uvrqmhti; set uvrqmhti;
	if Effect='uvrq_me*mht_ever';
	variable="uvrqmhti";
run;

** uvrq_me * fmenstr;
proc phreg data = use_r multipass;
	class uvrq_me (ref='0 to 186.918') fmenstr (ref='<=10')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me fmenstr uvrq_me*fmenstr
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqfmenstri;
run;
data uvrqfmenstri; set uvrqfmenstri;
	if Effect='uvrq_me*fmenstr';
	variable="uvrqfmenstri";
run;

** uvrq_me * menostat_c;
proc phreg data = use_r multipass;
	class uvrq_me (ref='0 to 186.918') menostat_c (ref='natural menopause')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me menostat_c uvrq_me*menostat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmenosti;
run;
data uvrqmenosti; set uvrqmenosti;
	if Effect='uvrq_me*menostat_c';
	variable="uvrqmenosti";
run;

** uvrq_me * ovarystat;
proc phreg data = use_r multipass;
	class uvrq_me (ref='0 to 186.918') ovarystat_c (ref='both removed')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me ovarystat_c uvrq_me*ovarystat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqovaryi;
run;
data uvrqovaryi; set uvrqovaryi;
	if Effect='uvrq_me*ovarystat_c';
	variable="uvrqovaryi";
run;

** uvrq_me * menop_age;
proc phreg data = use_r multipass;
	class uvrq_me (ref='0 to 186.918') menop_age (ref='<45')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me menop_age uvrq_me*menop_age
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmenopi;
run;
data uvrqmenopi; set uvrqmenopi;
	if Effect='uvrq_me*menop_age';
	variable="uvrqmenopi";
run;

** uvrq_me * parity;
proc phreg data = use_r multipass;
	class uvrq_me (ref='0 to 186.918') parity (ref='1-2 live children')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me parity uvrq_me*parity
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqparityi;
run;
data uvrqparityi; set uvrqparityi;
	if Effect='uvrq_me*parity';
	variable="uvrqparityi";
run;

** uvrq_me * flb_age_c;
proc phreg data = use_r multipass;
	class uvrq_me (ref='0 to 186.918') flb_age_c (ref='< 20 years old')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me flb_age_c uvrq_me*flb_age_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqflbai;
run;
data uvrqflbai; set uvrqflbai;
	if Effect='uvrq_me*flb_age_c';
	variable="uvrqflbai";
run;

** uvrq_me * oralbc_dur;
proc phreg data = use_r multipass;
	class uvrq_me (ref='0 to 186.918') oralbc_dur_c (ref='Never/<1yr')
			educ_c (ref='Less than high school') bmi_c (ref='18.5 to <25') 
			smoke_former (ref='Never smoked') rel_1d_cancer (ref='No') marriage (ref='Married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me oralbc_dur_c uvrq_me*oralbc_dur_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqoralbci;
run;
data uvrqoralbci; set uvrqoralbci;
	if Effect='uvrq_me*oralbc_dur_c';
	variable="uvrqoralbci";
run;

******************;

ods _all_ close; ods html;
*Combine and output to excel;
data risk_int_testing_mal; 
	set mhtmenoi
		menopagei
		menopagei2
		mhtparityi
		mhtfmenstri
		mhtflbi
		mhtoralbci

		uvrqmhti
		uvrqfmenstri
		uvrqmenosti
		uvrqovaryi
		uvrqmenopi
		uvrqparityi
		uvrqflbai
		uvrqoralbci
	; 
run;

ods html close; ods _all_ close; ods html;

data risk_int_testing_mal; 
	set risk_int_testing_mal
	(Keep= variable ProbChiSq); 
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\interactions\interaction.risk.mal.v1.xls' style=minimal;
proc print data= risk_int_testing_mal; run;
ods _all_ close; ods html;


************************************************;
* * *                                      * * *;
* * *                                      * * *;
************** *************** *****************;
************** deprecated code *****************;
************** *************** *****************;
* * *                                      * * *;
* * *                                      * * *;
************************************************;


********************************************************************************;
** baseline, melanoma, exp: hormever, in situ, uvrq 1 conf **;
** for interactions with horm_ever_me ;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, in situ';
	title2 'Exposure: hormever';
	title3 'uvrq, interactions';
	title4 '20150602TUE';
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)= horm_ever_me uvrq horm_ever_me*UVRQ
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqi;
run;
data uvrqi; set uvrqi;
	if Effect='horm_ever_me*UVRQ';
	variable="uvrqi";
run;

********************************************************************************;
*** Demographics for interaction ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq educ_c horm_ever_me*educ_c
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=educationi;
run;
data educationi; set educationi;
	if Effect='horm_ever_me*educ_c';
	variable="educ_ci";
run;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq bmi_c horm_ever_me*bmi_c
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=bmi_ci;
run;
data bmi_ci; set bmi_ci;
	if Effect='horm_ever_me*bmi_c';
	variable="bmi_ci";
run;

** physcial activity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq physic_c horm_ever_me*physic_c
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=physic_ci;
run;
data physic_ci; set physic_ci;
	if Effect='horm_ever_m*physic_c';
	variable="physic_ci";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq parity horm_ever_me*parity
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=parityi;
run;
data parityi; set parityi;
	if Effect='horm_ever_me*parity';
	variable="parityi";
run;

** age at menarche;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq fmenstr horm_ever_me*fmenstr
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=fmenstri;
run;
data fmenstri; set fmenstri;
	if Effect='horm_ever_me*FMENSTR';
	variable="fmenstri";
run;

** oral bc duration;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq oralbc_dur_c horm_ever_me*oralbc_dur_c
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output Type3=oralbc_dur_ci;
run;
data oralbc_dur_ci; set oralbc_dur_ci;
	if Effect='horm_ever*oralbc_dur';
	variable="oralbc_dur_ci";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq flb_age_c horm_ever_me*flb_age_c
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=flb_age_ci;
run;
data flb_age_ci; set flb_age_ci;
	if Effect='horm_ever_*flb_age_c';
	variable="flb_age_ci";
run;

** smoke_former;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918')  
		smoke_former (ref='Never smoked');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq smoke_former horm_ever_me*smoke_former
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output Type3=smoke_formeri;
run;
data smoke_formeri; set smoke_formeri;
	if Effect='horm_ever*SMOKE_FORM';
	variable="smoke_formeri";
run;

** coffee drinking;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq coffee_c horm_ever_me*coffee_c
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output Type3=coffee_ci;
run;
data coffee_ci; set coffee_ci;
	if Effect='horm_ever_m*coffee_c';
	variable="coffee_ci";
run;

** etoh drinking;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq etoh_c horm_ever_me*etoh_c
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=etoh_ci;
run;
data etoh_ci; set etoh_ci;
	if Effect='horm_ever_me*etoh_c';
	variable="etoh_ci";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq rel_1d_cancer horm_ever_me*rel_1d_cancer
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=rel_1d_canceri;
run;
data rel_1d_canceri; set rel_1d_canceri;
	if Effect='horm_ever*REL_1D_CAN';
	variable="rel_1d_canceri";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		marriage (ref='Married');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq marriage horm_ever_me*marriage
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output Type3=marriagei;
run;
data marriagei; set marriagei;
	if Effect='horm_ever_m*MARRIAGE';
	variable="marriagei";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data base_hormever_ins_uvr_1confi; 
	set 
		uvrqi educationi
		physic_ci 
		parityi flb_age_ci fmenstri
		oralbc_dur_ci smoke_formeri coffee_ci 
		etoh_ci rel_1d_canceri marriagei; 
run;
data base_hormever_ins_uvr_1confi; 
	set base_hormever_ins_uvr_1confi
	(Keep= variable ProbChiSq);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\mht\base_hormever_ins_uvr_1conf1i.xls' style=minimal;
proc print data= base_hormever_ins_uvr_1confi; run;
ods _all_ close;ods html;

********************************************************************************;
** baseline, melanoma, exp: hormever, malignant, uvrq 1 conf **;
** for interactions with horm_ever_me ;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, malignant';
	title2 'Exposure: hormever';
	title3 'uvrq, interactions';
	title4 '20150602TUE';
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)= horm_ever_me uvrq horm_ever_me*UVRQ
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqi;
run;
data uvrqi; set uvrqi;
	if Effect='horm_ever_me*UVRQ';
	variable="uvrqi";
run;

********************************************************************************;
*** Demographics for interaction ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq educ_c horm_ever_me*educ_c
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=educationi;
run;
data educationi; set educationi;
	if Effect='horm_ever_me*educ_c';
	variable="educ_ci";
run;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq bmi_c horm_ever_me*bmi_c
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=bmi_ci;
run;
data bmi_ci; set bmi_ci;
	if Effect='horm_ever_me*bmi_c';
	variable="bmi_ci";
run;

** physcial activity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq physic_c horm_ever_me*physic_c
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=physic_ci;
run;
data physic_ci; set physic_ci;
	if Effect='horm_ever_m*physic_c';
	variable="physic_ci";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq parity horm_ever_me*parity
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=parityi;
run;
data parityi; set parityi;
	if Effect='horm_ever_me*parity';
	variable="parityi";
run;

** age at menarche;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq fmenstr horm_ever_me*fmenstr
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=fmenstri;
run;
data fmenstri; set fmenstri;
	if Effect='horm_ever_me*FMENSTR';
	variable="fmenstri";
run;

** oral bc duration;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq oralbc_dur_c horm_ever_me*oralbc_dur_c
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output Type3=oralbc_dur_ci;
run;
data oralbc_dur_ci; set oralbc_dur_ci;
	if Effect='horm_ever*oralbc_dur';
	variable="oralbc_dur_ci";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq flb_age_c horm_ever_me*flb_age_c
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=flb_age_ci;
run;
data flb_age_ci; set flb_age_ci;
	if Effect='horm_ever_*flb_age_c';
	variable="flb_age_ci";
run;

** smoke_former;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918')  
		smoke_former (ref='Never smoked');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq smoke_former horm_ever_me*smoke_former
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output Type3=smoke_formeri;
run;
data smoke_formeri; set smoke_formeri;
	if Effect='horm_ever*SMOKE_FORM';
	variable="smoke_formeri";
run;

** coffee drinking;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq coffee_c horm_ever_me*coffee_c
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output Type3=coffee_ci;
run;
data coffee_ci; set coffee_ci;
	if Effect='horm_ever_m*coffee_c';
	variable="coffee_ci";
run;

** etoh drinking;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq etoh_c horm_ever_me*etoh_c
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=etoh_ci;
run;
data etoh_ci; set etoh_ci;
	if Effect='horm_ever_me*etoh_c';
	variable="etoh_ci";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq rel_1d_cancer horm_ever_me*rel_1d_cancer
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=rel_1d_canceri;
run;
data rel_1d_canceri; set rel_1d_canceri;
	if Effect='horm_ever*REL_1D_CAN';
	variable="rel_1d_canceri";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		marriage (ref='Married');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq marriage horm_ever_me*marriage
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output Type3=marriagei;
run;
data marriagei; set marriagei;
	if Effect='horm_ever_m*MARRIAGE';
	variable="marriagei";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data base_hormever_mal_uvr_1confi; 
	set 
		uvrqi educationi
		physic_ci 
		parityi flb_age_ci fmenstri
		oralbc_dur_ci smoke_formeri coffee_ci 
		etoh_ci rel_1d_canceri marriagei; 
run;
data base_hormever_mal_uvr_1confi; 
	set base_hormever_mal_uvr_1confi
	(Keep= variable ProbChiSq);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\mht\base_hormever_mal_uvr_1conf1i.xls' style=minimal;
proc print data= base_hormever_mal_uvr_1confi; run;
ods _all_ close;ods html;


*****************************************************************************************;
******   Model Building Table  **********************************************************;
*****************************************************************************************;

* baseline, melanoma malignant, exposure: horm_ever_me;
*A = unadjusted, except for age*;
title;
proc phreg data = use;
	class  horm_ever_me  (ref='Never');
	model exit_age*melanoma_ins(0)= horm_ever_me / entry = entry_age RL; 
	ods output ParameterEstimates=A_horm_ever_me;
run;
data A_horm_ever_me; 
	set A_horm_ever_me ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used');
	model exit_age*melanoma_ins(0)=horm_yrs_me / entry = entry_age RL; 
	ods output ParameterEstimates=A_horm_yrs_me;
run;
data A_horm_yrs_me; 
	set A_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data A_TOT_ins (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_horm_ever_me A_horm_yrs_me ;
run;
data A_TOT_ins (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); 
	set A_TOT_ins; 
run;
data A_TOT_ins ; 
	set A_TOT_ins; 
	model='Total'; 
run;

** natural menopause reason;

proc phreg data = use;
	class  horm_ever_me  (ref='Never');
	model exit_age*melanoma_ins(0)= horm_ever_me / entry = entry_age RL; 
	ods output ParameterEstimates=A_horm_ever_nm;
	where menostat_c=1;
run;
data A_horm_ever_nm; 
	set A_horm_ever_nm ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used');
	model exit_age*melanoma_ins(0)=horm_yrs_me / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_horm_yrs_nm;
run;
data A_horm_yrs_nm; 
	set A_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data A_NM_ins (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_horm_ever_nm A_horm_yrs_nm ;
run;
data A_NM_ins (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); 
	set A_NM_ins ;
run;
data A_NM_ins ; 
	set A_NM_ins; 
	model='Natur'; 
run;

** surgical menopause reason;

proc phreg data = use;
	class  horm_ever_me (ref='Never') ;
	model exit_age*melanoma_ins(0)=horm_ever_me / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_horm_ever_sm;
run;
data A_horm_ever_sm; 
	set A_horm_ever_sm ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used');
	model exit_age*melanoma_ins(0)=horm_yrs_me / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_horm_yrs_sm;
run;
data A_horm_yrs_sm; set A_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data A_SM_ins (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_horm_ever_sm A_horm_yrs_sm ;
run;
data A_SM_ins (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); 
	set A_SM_ins ;
run;
data A_SM_ins ; 
	set A_SM_ins; 
	model='Surgi'; 
run;
** merge hormever total, natural, and surgical menopause;
data A_All_ins ; 
	set A_TOT_ins A_NM_ins A_SM_ins; 
run;

*B = adjusted for UVR*;

proc phreg data = use;
	class  horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq/ entry = entry_age RL; 
	ods output ParameterEstimates=B_horm_ever_me;
run;
data B_horm_ever_me; 
	set B_horm_ever_me ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=horm_yrs_me uvrq/ entry = entry_age RL; 
	ods output ParameterEstimates=B_horm_yrs_me;
run;
data B_horm_yrs_me; 
	set B_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data B_TOT_ins (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_horm_ever_me B_horm_yrs_me ;
run;
data B_TOT_ins (keep=Parameter ClassVal0 Sortvar B_HR B_LL B_UL); 
	set B_TOT_ins; 
run;
data B_TOT_ins ; 
	set B_TOT_ins; 
	model='Total'; 
run;

** natural menopause;

proc phreg data = use;
	class  horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=B_horm_ever_nm;
run;
data B_horm_ever_nm; 
	set B_horm_ever_nm ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2; 
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=horm_yrs_me  uvrq / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=B_horm_yrs_nm;
run;
data B_horm_yrs_nm; 
	set B_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data B_NM_ins (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_horm_ever_nm B_horm_yrs_nm ;
run;
data B_NM_ins (keep=Parameter ClassVal0 Sortvar B_HR B_LL B_UL); 
	set B_NM_ins ;
run;
data B_NM_ins ; 
	set B_NM_ins; 
	model='Natur'; 
run;

** ins_ Surgical menopause;

proc phreg data = use;
	class  horm_ever_me (ref='Never') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=B_horm_ever_sm;
run;
data B_horm_ever_sm; 
	set B_horm_ever_sm ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=horm_yrs_me uvrq / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=B_horm_yrs_sm;
run;
data B_horm_yrs_sm; 
	set B_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data B_SM_ins (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_horm_ever_sm B_horm_yrs_sm ;
run;
data B_SM_ins (keep=Parameter ClassVal0 Sortvar B_HR B_LL B_UL); 
	set B_SM_ins ;
run;
data B_SM_ins ; 
	set B_SM_ins; 
	model='Surgi'; 
run;

data B_All_ins ; 
	set B_TOT_ins B_NM_ins B_SM_ins; 
run;

** C = adjusted for age, UVR, educ_c;

proc phreg data = use;
	class  horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=C_horm_ever_me;
run;
data C_horm_ever_me; 
	set C_horm_ever_me ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2; 
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=horm_yrs_me uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=C_horm_yrs_me;
run;
data C_horm_yrs_me; 
	set C_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data C_TOT_ins (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_horm_ever_me C_horm_yrs_me ;
run;
data C_TOT_ins (keep=Parameter ClassVal0 Sortvar C_HR C_LL C_UL); 
	set C_TOT_ins; 
run;
data C_TOT_ins ; 
	set C_TOT_ins; 
	model='Total'; 
run;

** natural menopause;

proc phreg data = use;
	class  horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq educ_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=C_horm_ever_nm;
run;
data C_horm_ever_nm; 
	set C_horm_ever_nm ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=horm_yrs_me  uvrq educ_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=C_horm_yrs_nm;
run;
data C_horm_yrs_nm; 
	set C_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data C_NM_ins (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_horm_ever_nm C_horm_yrs_nm ;
run;
data C_NM_ins (keep=Parameter ClassVal0 Sortvar C_HR C_LL C_UL); 
	set C_NM_ins ;
run;
data C_NM_ins ; 
	set C_NM_ins; 
	model='Natur'; 
run;

** ins_ Surgical menopause;

proc phreg data = use;
	class  horm_ever_me (ref='Never') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq educ_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=C_horm_ever_sm;
run;
data C_horm_ever_sm; 
	set C_horm_ever_sm ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=horm_yrs_me uvrq educ_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=C_horm_yrs_sm;
run;
data C_horm_yrs_sm; 
	set C_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data C_SM_ins (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_horm_ever_sm C_horm_yrs_sm ;
run;
data C_SM_ins (keep=Parameter ClassVal0 Sortvar C_HR C_LL C_UL); 
	set C_SM_ins ;
run;
data C_SM_ins ; 
	set C_SM_ins; 
	model='Surgi'; 
run;

data C_All_ins ; 
	set C_TOT_ins C_NM_ins C_SM_ins; 
run;

*D = adjusted for age, UVR quartile, educ_c, bmi_c;

proc phreg data = use;
	class  horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq educ_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=D_horm_ever_me;
run;
data D_horm_ever_me; 
	set D_horm_ever_me ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_ins(0)=horm_yrs_me uvrq educ_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=D_horm_yrs_me;
run;
data D_horm_yrs_me; 
	set D_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data D_TOT_ins (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_horm_ever_me D_horm_yrs_me ;
run;
data D_TOT_ins (keep=Parameter ClassVal0 Sortvar D_HR D_LL D_UL); 
	set D_TOT_ins; 
run;
data D_TOT_ins ; 
	set D_TOT_ins; 
	model='Total'; 
run;

** natural menopause;

proc phreg data = use;
	class  horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=D_horm_ever_nm;
run;
data D_horm_ever_nm; 
	set D_horm_ever_nm ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_ins(0)=horm_yrs_me  uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=D_horm_yrs_nm;
run;
data D_horm_yrs_nm; 
	set D_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data D_NM_ins (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_horm_ever_nm D_horm_yrs_nm ;
run;
data D_NM_ins (keep=Parameter ClassVal0 Sortvar D_HR D_LL D_UL); 
	set D_NM_ins ;
run;
data D_NM_ins ; 
	set D_NM_ins; 
	model='Natur'; 
run;

** ins_ Surgical menopause;

proc phreg data = use;
	class  horm_ever_me (ref='Never') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=D_horm_ever_sm;
run;
data D_horm_ever_sm; 
	set D_horm_ever_sm ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_ins(0)=horm_yrs_me uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=D_horm_yrs_sm;
run;
data D_horm_yrs_sm; 
	set D_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data D_SM_ins (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_horm_ever_sm D_horm_yrs_sm ;
run;
data D_SM_ins (keep=Parameter ClassVal0 Sortvar D_HR D_LL D_UL); 
	set D_SM_ins ;
run;
data D_SM_ins ; 
	set D_SM_ins; 
	model='Surgi'; 
run;

data D_All_ins ; 
	set D_TOT_ins D_NM_ins D_SM_ins; 
run;

** sort and merge all 4 models together;

proc sort data=A_All_ins  out=A_All_ins; by model sortvar ; run;
proc sort data=B_All_ins  out=B_All_ins; by model sortvar ; run;
proc sort data=C_All_ins  out=C_All_ins; by model sortvar ; run;
proc sort data=D_All_ins  out=D_All_ins; by model sortvar ; run;
proc print data=B_All_ins;
run;

data ModelBuilding_ins_hormever ; 
	title1 underlin=1 'AARP Baseline: melanoma, malignant';
	title2 'Exposure: hormever';
	title3 'uvrq, educ_c, bmi_c as confounders';
	title4 'Modelbuilding Table';
	title5 '20150601MON';
	title6 'Menostat Recode';
	MERGE A_ALL_ins B_ALL_ins C_ALL_ins D_ALL_ins; 
	BY model sortvar;
run; 
*DATA ModelBuilding (drop=Sortvar); *RUN; 
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\mht\base_ins_hormever2.xls' style=minimal;
proc print data= ModelBuilding_ins_hormever ; run;
ods _all_ close;ods html;

*****************************************************************************************;
******   Model Building Table  **********************************************************;
*****************************************************************************************;

* baseline, melanoma malignant, exposure: horm_ever_me;
*A = unadjusted, except for age*;
title;
proc phreg data = use;
	class  horm_ever_me  (ref='Never');
	model exit_age*melanoma_mal(0)= horm_ever_me / entry = entry_age RL; 
	ods output ParameterEstimates=A_horm_ever_me;
run;
data A_horm_ever_me; 
	set A_horm_ever_me ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used');
	model exit_age*melanoma_mal(0)=horm_yrs_me / entry = entry_age RL; 
	ods output ParameterEstimates=A_horm_yrs_me;
run;
data A_horm_yrs_me; 
	set A_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data A_TOT_mal (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_horm_ever_me A_horm_yrs_me ;
run;
data A_TOT_mal (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); 
	set A_TOT_mal; 
run;
data A_TOT_mal ; 
	set A_TOT_mal; 
	model='Total'; 
run;

** natural menopause reason;

proc phreg data = use;
	class  horm_ever_me  (ref='Never');
	model exit_age*melanoma_mal(0)= horm_ever_me / entry = entry_age RL; 
	ods output ParameterEstimates=A_horm_ever_nm;
	where menostat_c=1;
run;
data A_horm_ever_nm; 
	set A_horm_ever_nm ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used');
	model exit_age*melanoma_mal(0)=horm_yrs_me / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_horm_yrs_nm;
run;
data A_horm_yrs_nm; 
	set A_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data A_NM_mal (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_horm_ever_nm A_horm_yrs_nm ;
run;
data A_NM_mal (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); 
	set A_NM_mal ;
run;
data A_NM_mal ; 
	set A_NM_mal; 
	model='Natur'; 
run;

** surgical menopause reason;

proc phreg data = use;
	class  horm_ever_me (ref='Never') ;
	model exit_age*melanoma_mal(0)=horm_ever_me / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_horm_ever_sm;
run;
data A_horm_ever_sm; 
	set A_horm_ever_sm ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used');
	model exit_age*melanoma_mal(0)=horm_yrs_me / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_horm_yrs_sm;
run;
data A_horm_yrs_sm; set A_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data A_SM_mal (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_horm_ever_sm A_horm_yrs_sm ;
run;
data A_SM_mal (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); 
	set A_SM_mal ;
run;
data A_SM_mal ; 
	set A_SM_mal; 
	model='Surgi'; 
run;
** merge hormever total, natural, and surgical menopause;
data A_All_mal ; 
	set A_TOT_mal A_NM_mal A_SM_mal; 
run;

*B = adjusted for UVR*;

proc phreg data = use;
	class  horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq/ entry = entry_age RL; 
	ods output ParameterEstimates=B_horm_ever_me;
run;
data B_horm_ever_me; 
	set B_horm_ever_me ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=horm_yrs_me uvrq/ entry = entry_age RL; 
	ods output ParameterEstimates=B_horm_yrs_me;
run;
data B_horm_yrs_me; 
	set B_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data B_TOT_mal (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_horm_ever_me B_horm_yrs_me ;
run;
data B_TOT_mal (keep=Parameter ClassVal0 Sortvar B_HR B_LL B_UL); 
	set B_TOT_mal; 
run;
data B_TOT_mal ; 
	set B_TOT_mal; 
	model='Total'; 
run;

** natural menopause;

proc phreg data = use;
	class  horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=B_horm_ever_nm;
run;
data B_horm_ever_nm; 
	set B_horm_ever_nm ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=horm_yrs_me  uvrq / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=B_horm_yrs_nm;
run;
data B_horm_yrs_nm; 
	set B_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data B_NM_mal (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_horm_ever_nm B_horm_yrs_nm ;
run;
data B_NM_mal (keep=Parameter ClassVal0 Sortvar B_HR B_LL B_UL); 
	set B_NM_mal ;
run;
data B_NM_mal ; 
	set B_NM_mal; 
	model='Natur'; 
run;

** ins_ Surgical menopause;

proc phreg data = use;
	class  horm_ever_me (ref='Never') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=B_horm_ever_sm;
run;
data B_horm_ever_sm; 
	set B_horm_ever_sm ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=horm_yrs_me uvrq / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=B_horm_yrs_sm;
run;
data B_horm_yrs_sm; 
	set B_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data B_SM_mal (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_horm_ever_sm B_horm_yrs_sm ;
run;
data B_SM_mal (keep=Parameter ClassVal0 Sortvar B_HR B_LL B_UL); 
	set B_SM_mal ;
run;
data B_SM_mal ; 
	set B_SM_mal; 
	model='Surgi'; 
run;

data B_All_mal ; 
	set B_TOT_mal B_NM_mal B_SM_mal; 
run;

** C = adjusted for age, UVR, educ_c;

proc phreg data = use;
	class  horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=C_horm_ever_me;
run;
data C_horm_ever_me; 
	set C_horm_ever_me ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=horm_yrs_me uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=C_horm_yrs_me;
run;
data C_horm_yrs_me; 
	set C_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data C_TOT_mal (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_horm_ever_me C_horm_yrs_me ;
run;
data C_TOT_mal (keep=Parameter ClassVal0 Sortvar C_HR C_LL C_UL); 
	set C_TOT_mal; 
run;
data C_TOT_mal ; 
	set C_TOT_mal; 
	model='Total'; 
run;

** natural menopause;

proc phreg data = use;
	class  horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq educ_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=C_horm_ever_nm;
run;
data C_horm_ever_nm; 
	set C_horm_ever_nm ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=horm_yrs_me  uvrq educ_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=C_horm_yrs_nm;
run;
data C_horm_yrs_nm; 
	set C_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data C_NM_mal (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_horm_ever_nm C_horm_yrs_nm ;
run;
data C_NM_mal (keep=Parameter ClassVal0 Sortvar C_HR C_LL C_UL); 
	set C_NM_mal ;
run;
data C_NM_mal ; 
	set C_NM_mal; 
	model='Natur'; 
run;

** ins_ Surgical menopause;

proc phreg data = use;
	class  horm_ever_me (ref='Never') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq educ_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=C_horm_ever_sm;
run;
data C_horm_ever_sm; 
	set C_horm_ever_sm ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=horm_yrs_me uvrq educ_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=C_horm_yrs_sm;
run;
data C_horm_yrs_sm; 
	set C_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data C_SM_mal (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_horm_ever_sm C_horm_yrs_sm ;
run;
data C_SM_mal (keep=Parameter ClassVal0 Sortvar C_HR C_LL C_UL); 
	set C_SM_mal ;
run;
data C_SM_mal ; 
	set C_SM_mal; 
	model='Surgi'; 
run;

data C_All_mal ; 
	set C_TOT_mal C_NM_mal C_SM_mal; 
run;

*D = adjusted for age, UVR quartile, educ_c, bmi_c;

proc phreg data = use;
	class  horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq educ_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=D_horm_ever_me;
run;
data D_horm_ever_me; 
	set D_horm_ever_me ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_mal(0)=horm_yrs_me uvrq educ_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=D_horm_yrs_me;
run;
data D_horm_yrs_me; 
	set D_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data D_TOT_mal (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_horm_ever_me D_horm_yrs_me ;
run;
data D_TOT_mal (keep=Parameter ClassVal0 Sortvar D_HR D_LL D_UL); 
	set D_TOT_mal; 
run;
data D_TOT_mal ; 
	set D_TOT_mal; 
	model='Total'; 
run;

** natural menopause;

proc phreg data = use;
	class  horm_ever_me  (ref='Never') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=D_horm_ever_nm;
run;
data D_horm_ever_nm; 
	set D_horm_ever_nm ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_mal(0)=horm_yrs_me  uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=D_horm_yrs_nm;
run;
data D_horm_yrs_nm; 
	set D_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data D_NM_mal (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_horm_ever_nm D_horm_yrs_nm ;
run;
data D_NM_mal (keep=Parameter ClassVal0 Sortvar D_HR D_LL D_UL); 
	set D_NM_mal ;
run;
data D_NM_mal ; 
	set D_NM_mal; 
	model='Natur'; 
run;

** mal_ Surgical menopause;

proc phreg data = use;
	class  horm_ever_me (ref='Never') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=D_horm_ever_sm;
run;
data D_horm_ever_sm; 
	set D_horm_ever_sm ; 
	where Parameter='horm_ever_me';
	if Classval0='former'		then Sortvar=1; 
	if Classval0='current'		then Sortvar=2;
run;
proc phreg data = use;
	class  horm_yrs_me (ref='Never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_mal(0)=horm_yrs_me uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=D_horm_yrs_sm;
run;
data D_horm_yrs_sm; 
	set D_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
data D_SM_mal (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_horm_ever_sm D_horm_yrs_sm ;
run;
data D_SM_mal (keep=Parameter ClassVal0 Sortvar D_HR D_LL D_UL); 
	set D_SM_mal ;
run;
data D_SM_mal ; 
	set D_SM_mal; 
	model='Surgi'; 
run;

data D_All_mal ; 
	set D_TOT_mal D_NM_mal D_SM_mal; 
run;

** sort and merge all 4 models together;

proc sort data=A_All_mal  out=A_All_mal; by model sortvar ; run;
proc sort data=B_All_mal  out=B_All_mal; by model sortvar ; run;
proc sort data=C_All_mal  out=C_All_mal; by model sortvar ; run;
proc sort data=D_All_mal  out=D_All_mal; by model sortvar ; run;
proc print data=B_All_mal;
run;

data ModelBuilding_mal_hormever ; 
	title1 underlin=1 'AARP Baseline: melanoma, malignant';
	title2 'Exposure: hormever';
	title3 'uvrq, educ_c, bmi_c as confounders';
	title4 'Modelbuilding Table';
	title5 '20150601MON';
	title6 'Menostat Recode';
	MERGE A_ALL_mal B_ALL_mal C_ALL_mal D_ALL_mal; 
	BY model sortvar;
run; 
*DATA ModelBuilding (drop=Sortvar); *RUN; 
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\mht\base_mal_hormever2.xls' style=minimal;
proc print data= ModelBuilding_mal_hormever ; run;
ods _all_ close;ods html;

********************************************************************************;
*** horm_ever, hormone ever, malignant **;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title 'crude model - hormone ever, mal, base';
	class horm_ever_me  (ref='Never') ;
	model exit_age*melanoma_mal(0)= horm_ever_me  / entry = entry_age RL; 
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

data entryage; set entryage;
	if Parameter='horm_ever_me';
	variable="agecat_me";
run;

** birth cohort;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort_me (ref='1925-1928');
	model exit_age*melanoma_mal(0)=horm_ever_me birth_cohort_me/ entry = entry_age RL; 
	ods output ParameterEstimates=birthcohort;
run;
data birthcohort; set birthcohort;
	if Parameter='horm_ever_me';
	variable="birthcohort_me";
run;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') educ_c_me (ref='highschool or less');
	model exit_age*melanoma_mal(0)=horm_ever_me educ_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='horm_ever_me';
	variable="educ_c_me";
run;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') bmi_c_me (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_mal(0)=horm_ever_me bmi_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c_me;
run;
data bmi_c_me; set bmi_c_me;
	if Parameter='horm_ever_me';
	variable="bmi_c_me";
run;

** physcial activity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') physic_c_me (ref='rarely');
	model exit_age*melanoma_mal(0)=horm_ever_me physic_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c_me;
run;
data physic_c_me; set physic_c_me;
	if Parameter='horm_ever_me';
	variable="physic_c_me";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') parity_me (ref='nulliparous');
	model exit_age*melanoma_mal(0)=horm_ever_me parity_me/ entry = entry_age RL; 
	ods output ParameterEstimates=parity_me;
run;
data parity_me; set parity_me;
	if Parameter='horm_ever_me';
	variable="parity_me";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') flb_age_c_me (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=horm_ever_me flb_age_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c_me;
run;
data flb_age_c_me; set flb_age_c_me;
	if Parameter='horm_ever_me';
	variable="flb_age_c_me";
run;

** age at menarche;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') fmenstr_me (ref='<=10');
	model exit_age*melanoma_mal(0)=horm_ever_me fmenstr_me/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr_me;
run;
data fmenstr_me; set fmenstr_me;
	if Parameter='horm_ever_me';
	variable="fmenstr_me";
run;

** oral bc duration;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') oralbc_dur_c_me (ref='Never');
	model exit_age*melanoma_mal(0)=horm_ever_me oralbc_dur_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=oralbc_dur_c_me;
run;
data oralbc_dur_c_me; set oralbc_dur_c_me;
	if Parameter='horm_ever_me';
	variable="oralbc_dur_c_me";
run;

** UVR quartiles;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') uvrq_me (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq_me/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq_me;
run;
data uvrq_me; set uvrq_me;
	if Parameter='horm_ever_me';
	variable="uvrq_me";
run;

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') smoke_former_me (ref='Never smoked');
	model exit_age*melanoma_mal(0)=horm_ever_me smoke_former_me/ entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former_me;
run;
data smoke_former_me; set smoke_former_me;
	if Parameter='horm_ever_me';
	variable="smoke_former_me";
run;

** coffee drinking;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') coffee_c_me (ref='none');
	model exit_age*melanoma_mal(0)=horm_ever_me coffee_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c_me;
run;
data coffee_c_me; set coffee_c_me;
	if Parameter='horm_ever_me';
	variable="coffee_c_me";
run;

** etoh drinking;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') etoh_c_me (ref='none');
	model exit_age*melanoma_mal(0)=horm_ever_me etoh_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c_me;
run;
data etoh_c_me; set etoh_c_me;
	if Parameter='horm_ever_me';
	variable="etoh_c_me";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') rel_1d_cancer_me (ref='No');
	model exit_age*melanoma_mal(0)=horm_ever_me rel_1d_cancer_me/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer_me;
run;
data rel_1d_cancer_me; set rel_1d_cancer_me;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer_me";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') marriage (ref='Married');
	model exit_age*melanoma_mal(0)=horm_ever_me marriage/ entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder1_base_mal_hormever; 
	set 
		crude birthcohort
		education bmi_c_me physic_c_me
		parity_me flb_age_c_me fmenstr_me
		oralbc_dur_c_me uvrq_me smoke_former_me coffee_c_me 
		etoh_c_me rel_1d_cancer_me marriage; 
run;
data confounder1_base_mal_hormever; 
	set confounder1_base_mal_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\confounder1_testing_mal_hormever.xls' style=minimal;
proc print data= confounder1_base_mal_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 2 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR- malignant, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, ins, base';
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='horm_ever_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='horm_ever_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** meno_age_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=meno_age_c;
run;
data meno_age_c; set meno_age_c;
	if Parameter='horm_ever_me';
	variable="meno_age_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') smoke_former (ref='Never smoked');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') marriage (ref='Married');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder2_base_ins_hormever; 
	set 
		null education bmi_c physic_c meno_age_c 
		parity flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder2_base_ins_hormever; 
	set confounder2_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder2_base_ins_hormever.xls' style=minimal;
proc print data= confounder2_base_ins_hormever; run;
ods _all_ close;ods html;

********************************************************************************;
*** horm_ever, BC, UVR- mal, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, mal, base';
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='horm_ever_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='horm_ever_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** meno_age_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=meno_age_c;
run;
data meno_age_c; set meno_age_c;
	if Parameter='horm_ever_me';
	variable="meno_age_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') smoke_former (ref='Never smoked');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') marriage (ref='Married');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder2_base_mal_hormever; 
	set 
		null education bmi_c physic_c meno_age_c 
		parity flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder2_base_mal_hormever; 
	set confounder2_base_mal_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder2_base_mal_hormever.xls' style=minimal;
proc print data= confounder2_base_mal_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 3 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR, menoage- malignant, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, menoage, ins, base';
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort meno_age_c uvrq / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='horm_ever_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='horm_ever_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') smoke_former (ref='Never smoked');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') marriage (ref='Married');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder3_base_ins_hormever; 
	set 
		null education bmi_c physic_c 
		parity flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder3_base_ins_hormever; 
	set confounder3_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder3_base_ins_hormever.xls' style=minimal;
proc print data= confounder3_base_ins_hormever; run;
ods _all_ close;ods html;

********************************************************************************;
*** horm_ever, BC, UVR, menoage- mal, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, menoage, mal, base';
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='horm_ever_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='horm_ever_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') smoke_former (ref='Never smoked');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') marriage (ref='Married');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder3_base_mal_hormever; 
	set 
		null education bmi_c physic_c 
		parity flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder3_base_mal_hormever; 
	set confounder3_base_mal_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder3_base_mal_hormever.xls' style=minimal;
proc print data= confounder3_base_mal_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 4 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR menoage, educ_c- malignant, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, menoage, educ_c, ins, base';
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort meno_age_c uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='horm_ever_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') smoke_former (ref='Never smoked');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder4_base_ins_hormever; 
	set 
		null bmi_c physic_c 
		parity flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder4_base_ins_hormever; 
	set confounder4_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder4_base_ins_hormever.xls' style=minimal;
proc print data= confounder4_base_ins_hormever; run;
ods _all_ close;ods html;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, BMI- mal, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, menoage, BMI, mal, base';
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq bmi_c meno_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='horm_ever_me';
	variable="educ_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') smoke_former (ref='Never smoked');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') marriage (ref='Married');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder4_base_mal_hormever; 
	set 
		null education physic_c 
		parity flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder4_base_mal_hormever; 
	set confounder4_base_mal_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder4_base_mal_hormever.xls' style=minimal;
proc print data= confounder4_base_mal_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 5 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR menoage, educ_c, marriage- malignant, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, menoage, educ_c, marriage, ins, base';
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort meno_age_c uvrq educ_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='horm_ever_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') smoke_former (ref='Never smoked');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder5_base_ins_hormever; 
	set 
		null bmi_c physic_c 
		parity flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer; 
run;
data confounder5_base_ins_hormever; 
	set confounder5_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder5_base_ins_hormever.xls' style=minimal;
proc print data= confounder5_base_ins_hormever; run;
ods _all_ close;ods html;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, BMI, fmenstr- mal, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, menoage, BMI, mal, base';
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq bmi_c meno_age_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='horm_ever_me';
	variable="educ_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') smoke_former (ref='Never smoked');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') marriage (ref='Married');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder5_base_mal_hormever; 
	set 
		null education physic_c 
		parity flb_age_c smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder5_base_mal_hormever; 
	set confounder5_base_mal_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder5_base_mal_hormever.xls' style=minimal;
proc print data= confounder5_base_mal_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 6 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, educ_c, marriage, bmi_c- malignant, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, menoage, educ_c, marriage, bmi, ins, base';
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married')
		bmi_c (ref='18.5 to 18.5 to <25');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') ;
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity  / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married')
		bmi_c (ref='18.5 to 18.5 to <25') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') smoke_former (ref='Never smoked');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder6_base_ins_hormever; 
	set 
		null physic_c parity
		flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer; 
run;
data confounder6_base_ins_hormever; 
	set confounder6_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder6_base_ins_hormever.xls' style=minimal;
proc print data= confounder6_base_ins_hormever; run;
ods _all_ close;ods html;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, BMI, fmenstr, smoke_former- mal, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, menoage, BMI, fmenstr, smoke_former, mal, base';
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10')
		smoke_former (ref='Never smoked');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq bmi_c meno_age_c fmenstr smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='horm_ever_me';
	variable="educ_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** etoh_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked')  etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former etoh_c  / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') marriage (ref='Married');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder6_base_mal_hormever; 
	set 
		null education physic_c 
		parity flb_age_c coffee_c etoh_c
		rel_1d_cancer marriage; 
run;
data confounder6_base_mal_hormever; 
	set confounder6_base_mal_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder6_base_mal_hormever.xls' style=minimal;
proc print data= confounder6_base_mal_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 7 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, educ_c, marriage, bmi_c, parity- malignant, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - 7 - horm_ever, birthcohort, UVR, menoage, educ_c, marriage, bmi_c, parity, ins, base';
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married')
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married')
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') smoke_former (ref='Never smoked');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder7_base_ins_hormever; 
	set 
		null physic_c
		flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer; 
run;
data confounder7_base_ins_hormever; 
	set confounder7_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder7_base_ins_hormever.xls' style=minimal;
proc print data= confounder7_base_ins_hormever; run;
ods _all_ close;ods html;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, BMI, fmenstr, smoke_former, educ_c- mal, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - 7 - horm_ever, birthcohort, UVR, menoage, BMI, fmenstr, smoke_former, educ_c, mal, base';
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10')
		smoke_former (ref='Never smoked') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq bmi_c meno_age_c fmenstr smoke_former educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') educ_c (ref='highschool or less') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') educ_c (ref='highschool or less') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') educ_c (ref='highschool or less') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** etoh_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') educ_c (ref='highschool or less') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c etoh_c  / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') educ_c (ref='highschool or less') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') educ_c (ref='highschool or less') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') educ_c (ref='highschool or less') marriage (ref='Married');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder7_base_mal_hormever; 
	set 
		null physic_c 
		parity flb_age_c coffee_c etoh_c
		rel_1d_cancer marriage; 
run;
data confounder7_base_mal_hormever; 
	set confounder7_base_mal_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder7_base_mal_hormever.xls' style=minimal;
proc print data= confounder7_base_mal_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 8 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, educ_c, marriage, bmi_c, parity, fmenstr- malignant, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - 8 - horm_ever, birthcohort, UVR, menoage, educ_c, marriage, bmi_c, parity, fmenstr, ins, base';
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married')
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c parity fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married')
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='Never smoked');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder8_base_ins_hormever; 
	set 
		null physic_c
		flb_age_c smoke_former coffee_c etoh_c 
		rel_1d_cancer; 
run;
data confounder8_base_ins_hormever; 
	set confounder8_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder8_base_ins_hormever.xls' style=minimal;
proc print data= confounder8_base_ins_hormever; run;
ods _all_ close;ods html;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, BMI, fmenstr, smoke_former, educ_c, - mal, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - 8 - horm_ever, birthcohort, UVR, menoage, BMI, fmenstr, smoke_former, educ_c, marriage, mal, base';
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10')
		smoke_former (ref='Never smoked') educ_c (ref='highschool or less')
		marriage (ref='Married');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq bmi_c meno_age_c fmenstr smoke_former educ_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') educ_c (ref='highschool or less') 
		marriage (ref='Married') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') educ_c (ref='highschool or less') 
		marriage (ref='Married') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') educ_c (ref='highschool or less') 
		marriage (ref='Married') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** etoh_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') educ_c (ref='highschool or less') 
		marriage (ref='Married') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage etoh_c  / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') educ_c (ref='highschool or less') 
		marriage (ref='Married') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 18.5 to <25') fmenstr (ref='<=10') 
		smoke_former (ref='Never smoked') educ_c (ref='highschool or less') 
		marriage (ref='Married') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder8_base_mal_hormever; 
	set 
		null physic_c 
		parity flb_age_c coffee_c etoh_c
		rel_1d_cancer; 
run;
data confounder8_base_mal_hormever; 
	set confounder8_base_mal_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder8_base_mal_hormever.xls' style=minimal;
proc print data= confounder8_base_mal_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 9 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, educ_c, marriage, bmi_c, parity, fmenstr, smoke_former- malignant, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - 8 - horm_ever, birthcohort, UVR, menoage, educ_c, marriage, bmi_c, parity, fmenstr, smoke_former, ins, base';
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married')
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') fmenstr (ref='<=10')
		smoke_former (ref='Never smoked');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c parity fmenstr smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='Never smoked') physic_c (ref='rarely') ;
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married')
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='Never smoked') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='Never smoked') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='Never smoked') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='Never smoked') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder9_base_ins_hormever; 
	set 
		null physic_c
		flb_age_c coffee_c etoh_c 
		rel_1d_cancer; 
run;
data confounder9_base_ins_hormever; 
	set confounder9_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder9_base_ins_hormever.xls' style=minimal;
proc print data= confounder9_base_ins_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 10 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, educ_c, marriage, bmi_c, parity, fmenstr, smoke_former, flb_age_c- malignant, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - 10 - horm_ever, birthcohort, UVR, menoage, educ_c, marriage, bmi_c, parity, fmenstr, smoke_former,, flb_age_c ins, base';
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married')
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') fmenstr (ref='<=10')
		smoke_former (ref='Never smoked') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='Never smoked') flb_age_c (ref='< 20 years old') physic_c (ref='rarely') ;
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='Never smoked') flb_age_c (ref='< 20 years old') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='Never smoked') flb_age_c (ref='< 20 years old') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='Never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='Married') 
		bmi_c (ref='18.5 to 18.5 to <25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='Never smoked') flb_age_c (ref='< 20 years old') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder10_base_ins_hormever; 
	set 
		null physic_c
		coffee_c etoh_c 
		rel_1d_cancer; 
run;
data confounder10_base_ins_hormever; 
	set confounder10_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder10_base_ins_hormever.xls' style=minimal;
proc print data= confounder10_base_ins_hormever; run;
ods _all_ close;ods html;

/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
# creates Table 1 descriptives
# with SAS output to MS Excel
# uses melan dataset
# for v6, baseline to FUP
# 
# Created: April 1 2015
# Updated: v20150916WED WTL
# Used IMS: anchovy
# Code based off of Lisa's Horm.Rep and BCC study
#
*******************************************************************/

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';

data use;
	set conv.melan;
run;

** reset the results ods output;
ods html close; 
ods html;

***************************;
** Study sample info    ***;
***************************;

proc means data=use n sum mean stddev;
	title 'baseline frequencies';
	var entry_age personyrs;
	*where melanoma_c=2;
run; 
proc freq data = use;
	tables 
		/*menostat_c*(meno_age_c surg_age_c)*/
		menostat_c*horm_surg_c
	/missing ;
run;

proc freq data = use;
	tables 
		oralbc_yn_c*melanoma_agg
		hormever*melanoma_agg
		oralbc_yn_c*melanoma_c
		hormever*melanoma_c
	/missing ;
run;

proc freq data=use;
	tables
		melanoma_c*melanoma_agg
		melanoma_c*cancer_behv
		melanoma_agg*cancer_behv
		melanoma_ins*melanoma_c
		melanoma_mal*melanoma_c
	/missing ;
run;

proc tabulate data=use missing;
	title;
	class melanoma_c parity;
	tables
		parity, (melanoma_c)*(N colpctn);
run;
** double check to see if any non-melanoma_c were counted as melanoma_agg cases with behav='2';
*** fixed with or parenthesis;
proc print data=use (obs=30);
	title 'print cases';
	where melanoma_c=0 and cancer_behv='2';
	var westatid melanoma_c melanoma_agg cancer_behv cancer_seergroup cancer_siterec3;
run;

ods _all_ close; 
ods html;
****************************;
** Confounder -> outcome  **;
****************************;

****************************; 
** Table 1: Baseline *******;
****************************;
/* variables:
melanoma_agg
melanom_c
melanoma_ins
melanoma_mal
personyrs
attained_age
birth_cohort

agecat
race_c
educ_c
bmi_c
physic_c

fmenstr
menostat_c
meno_age_c
surg_age_c

parity
flb_age_c
oralbc_dur_c

uvrq

smoke_former

coffee_c
etoh_c
rel_1d_cancer
marriage
*/

** Categorical variables in table 1;
ods _all_ close;
ods htmlcss file='C:\REB\AARP_HRTandMelanoma\Results\misc\T1\Table1.v14.xls' style=minimal;
proc tabulate data=use missing;
	title1 'AARP-Baseline, Table 1';
	title2 'melanoma in situ and malignant';
	title3 '20150916WED WTL v14';
	class melanoma_c
		educ_c bmi_c physic_c  
		fmenstr menostat_c ovarystat_c 
		menop_age menopi_age parity flb_age_c 
		oralbc_yn_c oralbc_dur_c 
		mht_ever horm_ever
		horm_yrs_nat_c horm_yrs_surg_c 
		uvrq marriage
		smoke_former smoke_quit smoke_dose 
		coffee_c etoh_c rel_1d_cancer
	; 
	table
		educ_c bmi_c physic_c  
		fmenstr menostat_c ovarystat_c 
		menop_age menopi_age parity flb_age_c 
		oralbc_yn_c oralbc_dur_c 
		mht_ever horm_ever
		horm_yrs_nat_c horm_yrs_surg_c 
		uvrq marriage
		smoke_former smoke_quit smoke_dose 
		coffee_c etoh_c rel_1d_cancer
		,
		(melanoma_c)* (N colpctn='Percent') /nocellmerge
	;  *;
run; 
ods htmlcss close;
ods html;

*******************************************************************************;
** categorical, chi-squared and trend;
** for in situ;
*******************************************************************************;

ods output ChiSq=Table1Chi      
	(keep=Table Statistic Prob rename=(prob=Chi2Pvalue)    
	where=(Statistic='Chi-Square'));
ods output TrendTest=Table1Trd  
	(keep=Table Name1 cValue1 rename=(cValue1=TrendPvalue) 
	where=(Name1='P2_TREND'));

proc freq data=use;
	title 'freq for melanoma_ins';
	tables melanoma_ins * (
		agecat attained_age birth_cohort
		educ_c bmi_c physic_c  
		fmenstr menostat_c ovarystat_c 
		menop_age menopi_age mht_ever horm_ever
		parity flb_age_c oralbc_yn_c oralbc_dur_c 
		horm_yrs_nat_c horm_yrs_surg_c 
		uvrq marriage
		smoke_former smoke_dose smoke_quit
		coffee_c etoh_c rel_1d_cancer
		)	  
		/chisq trend nocol nopercent scores=table ;
run;
data Table1Chi; 
	set Table1Chi (keep=Table Chi2Pvalue); run;
data Table1Trd; 
	set Table1Trd (keep=Table TrendPvalue); run;
proc sort data=Table1Chi; 
	by Table; run;
proc sort data=Table1Trd; 
	by Table; run;
data Table1ap; 
	set Table1Chi Table1Trd; by Table; run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\misc\T1\Table1ap_ins.xls' style=minimal;
proc print data= Table1ap; 
	title1 'AARP Baseline, In situ';
	title2 'print chi2 and trend for melanoma_ins';
run; 
ods html close;

*******************************************************************************;
*******************************************************************************;


** Continuous;
ods html body='C:\REB\AARP_HRTandMelanoma\Results\misc\T1\Table1b_ins.xls' style=minimal;
proc tabulate data=use;
	title 'tab continuous melanoma_ins';
	class melanoma_ins;
	var entry_age exit_age personyrs bmi_cur mped_a_bev exposure_jul_78_05;
	table (entry_age exit_age personyrs bmi_cur mped_a_bev exposure_jul_78_05),
	(melanoma_ins)* (mean='Mean' stddev='SD');
run; 
ods html close;

*******************************************************************************;
*******************************************************************************;

ods output Ttests=Table1T ;
ods html;

proc ttest data=use;
	title 'ttest melanoma_ins';
	class melanoma_ins;
	var entry_age exit_age personyrs bmi_cur mped_a_bev exposure_jul_78_05;
run;

ods html file='C:\REB\AARP_HRTandMelanoma\Results\misc\T1\Table1bp_ins.xls' style=minimal;
proc print data= Table1T (keep=Variable Variances Probt rename=(Probt=TPvalue)
	where=(Variances='Unequal') ); 
run;
ods html close;

*******************************************************************************;
** categorical, chi-squared and trend;
** for malignant;
*******************************************************************************;

ods output ChiSq=Table1Chi      
	(keep=Table Statistic Prob rename=(prob=Chi2Pvalue)    
	where=(Statistic='Chi-Square'));
ods output TrendTest=Table1Trd  
	(keep=Table Name1 cValue1 rename=(cValue1=TrendPvalue) 
	where=(Name1='P2_TREND'));
ods html;
proc freq data=use;
	title 'freq for melanoma_mal';
	tables melanoma_mal * (
		agecat attained_age birth_cohort
		educ_c bmi_c physic_c  
		fmenstr menostat_c ovarystat_c 
		menop_age menopi_age mht_ever horm_ever
		parity flb_age_c oralbc_yn_c oralbc_dur_c 
		horm_yrs_nat_c horm_yrs_surg_c 
		uvrq marriage
		smoke_former smoke_dose smoke_quit
		coffee_c etoh_c rel_1d_cancer
		)	  
		/chisq trend nocol nopercent scores=table;
run;
data Table1Chi; 
	set Table1Chi (keep=Table Chi2Pvalue); run;
data Table1Trd; 
	set Table1Trd (keep=Table TrendPvalue); run;
proc sort data=Table1Chi; 
	by Table; run;
proc sort data=Table1Trd; 
	by Table; run;
data Table1ap; 
	set Table1Chi Table1Trd; by Table; run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\misc\T1\Table1ap_mal.xls' style=minimal;
proc print data= Table1ap; 
	title1 'AARP Baseline Malignant';
	title2 'print chi2 and trend for melanoma_mal';
run; 
ods html close; ods html;

*******************************************************************************;
*******************************************************************************;


** Continuous;
ods html body='C:\REB\AARP_HRTandMelanoma\Results\misc\T1\Table1b_mal.xls' style=minimal;
proc tabulate data=use;
	title 'tab continuous melanoma_mal';
	class melanoma_mal;
	var entry_age personyrs bmi_cur mped_a_bev exposure_jul_78_05;
	table (entry_age personyrs bmi_cur mped_a_bev exposure_jul_78_05),
	(melanoma_mal)* (mean='Mean' stddev='SD');
run; 
ods html close;

*******************************************************************************;
*******************************************************************************;

ods output Ttests=Table1T ;
ods html;

proc ttest data=use;
	title 'ttest melanoma_mal';
	class melanoma_mal;
	var entry_age personyrs bmi_cur mped_a_bev exposure_jul_78_05;
run;

ods html file='C:\REB\AARP_HRTandMelanoma\Results\misc\T1\Table1bp_mal.xls' style=minimal;
proc print data= Table1T (keep=Variable Variances Probt rename=(Probt=TPvalue)
	where=(Variances='Unequal') ); 
run;
ods html close;

*******************************************************************************;
** categorical, chi-squared and trend;
** for in situ;
** with main effect -9's coded as missing;
*******************************************************************************;

*******************************************************************************;
*******************************************************************************;

** Continuous;
ods output ChiSq=Table1Chi      
	(keep=Table Statistic Prob rename=(prob=Chi2Pvalue)    
	where=(Statistic='Chi-Square'));
ods output TrendTest=Table1Trd  
	(keep=Table Name1 cValue1 rename=(cValue1=TrendPvalue) 
	where=(Name1='P2_TREND'));

proc freq data=use;
	title 'freq for melanoma_ins';
	tables melanoma_ins * (
		agecat attained_age birth_cohort
		race_c educ_c bmi_c physic_c  
		fmenstr meno_reason meno_age_c surg_age_c
		parity flb_age_c oralbc_dur_c horm_nat_c  
		horm_surg_c uvrq
		smoke_former coffee_c etoh_c rel_1d_cancer
		)	  
		/chisq trend nocol nopercent scores=table ;
run;
data Table1Chi; 
	set Table1Chi (keep=Table Chi2Pvalue); run;
data Table1Trd; 
	set Table1Trd (keep=Table TrendPvalue); run;
proc sort data=Table1Chi; 
	by Table; run;
proc sort data=Table1Trd; 
	by Table; run;
data Table1ap; 
	set Table1Chi Table1Trd; by Table; run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\misc\T1\Table1ap_ins.xls' style=minimal;
proc print data= Table1ap; 
	title 'print chi2 and trend for melanoma_ins';
run; 
ods html close;

/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
# creates Table 1 descriptives
# with SAS output to MS Excel
# use_rs melan_r dataset
# for v6, riskfactor to FUP
# 
# Created: April 1 2015
# Updated: v20151009FRI WTL
# removed rf_physic
# Used IMS: anchovy
# Code based off of Lisa's Horm.Rep and BCC study
#
*******************************************************************/

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';


data use_r;
	set conv.melan_r;
run;

** reset the results ods output;
ods html close; 
ods html;

***************************;
** Study sample info    ***;
***************************;

proc means data=use_r n sum mean stddev;
	title 'riskfactor frequencies';
	var entry_age personyrs;
	where melanoma_c=2;
run; 

** Categorical variables in table 1;
ods _all_ close;
ods htmlcss file='C:\REB\AARP_HRTandMelanoma\Results\misc\T1\rTable1.v16.xls' style=minimal;
proc tabulate data=use_r missing;
	title1 'AARP Riskfactor Melanoma';
	title2 'Table 1 output';
	title3 '20151022THU WTL';
	title4 'v16';
	class melanoma_c 
		educ_c bmi_c physic_c  
		fmenstr_c menostat_c ovarystat_c 
		menop_age_c parity_c flb_age_c 
		oralbc_yn_c oralbc_dur_c mht_ever_c hormstat_c
		horm_yrs_nat_c horm_yrs_surg_c 
		uvrq_c marriage_c
		smoke_former_c smoke_dose_c smoke_quit_c
		coffee_c etoh_c rel_1d_cancer_c
		/* Lacey EPT below */
		ht_nat_ever_c ht_nat_c
		ht_surg_ever_c ht_surg_c
		l_eptcurrent_ever_c l_eptcurrent_c
		l_eptdose_c l_eptdur_c
		/* Lacey ET below */
		l_etcurrent_ever_c l_etcurrent_c
		l_etdose_c l_etdur_c l_etfreq_c
		/* hospital utilization */
		colo_sig_any
	; 
	table
		educ_c bmi_c physic_c  
		fmenstr_c menostat_c ovarystat_c 
		menop_age_c parity_c flb_age_c 
		oralbc_yn_c oralbc_dur_c mht_ever_c hormstat_c
		horm_yrs_nat_c horm_yrs_surg_c 
		uvrq_c marriage_c
		smoke_former_c smoke_dose_c smoke_quit_c
		coffee_c etoh_c rel_1d_cancer_c
		/* Lacey EPT below */
		ht_nat_ever_c ht_nat_c
		ht_surg_ever_c ht_surg_c
		l_eptcurrent_ever_c l_eptcurrent_c
		l_eptdose_c l_eptdur_c
		/* Lacey ET below */
		l_etcurrent_ever_c l_etcurrent_c
		l_etdose_c l_etdur_c l_etfreq_c
		/* hospital utilization */
		colo_sig_any
		,
		(melanoma_c)* (N colpctn='Percent') /nocellmerge
	; 
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

proc freq data=use_r;
	title 'freq for melanoma_ins';
	tables melanoma_ins* (
		agecat attained_age birth_cohort
		educ_c bmi_c physic_c
		fmenstr menostat_c ovarystat_c 
		menop_age
		parity flb_age_c oralbc_yn_c oralbc_dur_c 
		horm_nat_ever_c horm_nat_c 
		horm_surg_ever_c horm_surg_c 
		horm_yrs_nat_c horm_yrs_surg_c 
		uvrq marriage
		smoke_former smoke_dose smoke_quit
		coffee_c etoh_c rel_1d_cancer
		/* Lacey EPT below */
		ht_type_nat_ever ht_type_nat 
		ht_type_surg_ever ht_type_surg 
		lacey_eptcurrent_ever lacey_eptcurrent 
		lacey_eptdose lacey_eptdur
		/* Lacey ET below */
		lacey_etcurrent_ever lacey_etcurrent 
		lacey_etdose lacey_etdur lacey_etfreq
		/* hospital utilization */
		colo_sig_any
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
	set Table1Chi Table1Trd ; by Table; run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\table1\rTable1ap_ins.xls' style=minimal;
proc print data= Table1ap; 
	title 'print chi2 and trend for melanoma_ins'; run; 
ods html close;

*******************************************************************************;
*******************************************************************************;

** Continuous;
ods html body='C:\REB\AARP_HRTandMelanoma\Results\T1\rTable1b_ins.xls' style=minimal;
proc tabulate data=use_r;
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

proc ttest data=use_r;
	title 'ttest melanoma_ins';
	class melanoma_ins;
	var entry_age exit_age personyrs bmi_cur mped_a_bev exposure_jul_78_05;
run;

ods html file='C:\REB\AARP_HRTandMelanoma\Results\T1\rTable1bp_ins.xls' style=minimal;
proc print data= Table1T (keep=Variable Variances Probt rename=(Probt=TPvalue)
	where=(Variances='Unequal') ); 
run;
ods html close;
ods html;


*******************************************************************************;
*
*
*******************************************************************************;
*
*
*******************************************************************************;


*******************************************************************************;
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

proc freq data=use_r;
	title 'freq for melanoma_mal';
	tables melanoma_mal* (
		agecat attained_age birth_cohort
		educ_c bmi_c physic_c rf_physic_c
		fmenstr menostat_c ovarystat_c 
		menop_age
		parity flb_age_c oralbc_yn_c oralbc_dur_c 
		horm_nat_ever_c horm_nat_c 
		horm_surg_ever_c horm_surg_c 
		horm_yrs_nat_c horm_yrs_surg_c 
		uvrq marriage
		smoke_former smoke_dose smoke_quit
		coffee_c etoh_c rel_1d_cancer
		/* Lacey EPT below */
		ht_type_nat_ever ht_type_nat 
		ht_type_surg_ever ht_type_surg 
		lacey_eptcurrent_ever lacey_eptcurrent 
		lacey_eptdose lacey_eptdur
		/* Lacey ET below */
		lacey_etcurrent_ever lacey_etcurrent 
		lacey_etdose lacey_etdur lacey_etfreq
		/* hospital utilization */
		colo_sig_any
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
	set Table1Chi Table1Trd ; by Table; run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\table1\rTable1ap_mal.xls' style=minimal;
proc print data= Table1ap; 
	title 'print chi2 and trend for melanoma_mal'; run; 
ods html close;

*******************************************************************************;
*******************************************************************************;

** Continuous;
ods html body='C:\REB\AARP_HRTandMelanoma\Results\T1\rTable1b_mal.xls' style=minimal;
proc tabulate data=use_r;
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

proc ttest data=use_r;
	title 'ttest melanoma_mal';
	class melanoma_mal;
	var entry_age exit_age personyrs bmi_cur mped_a_bev exposure_jul_78_05;
run;

ods html file='C:\REB\AARP_HRTandMelanoma\Results\T1\rTable1bp_mal.xls' style=minimal;
proc print data= Table1T (keep=Variable Variances Probt rename=(Probt=TPvalue)
	where=(Variances='Unequal') ); 
run;
ods html close;
ods html;

/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
# creates Table 1 descriptives
# with SAS output to MS Excel
# uses melan_r dataset
# for v3, riskfactor to FUP
# 
# Created: April 1 2015
# Updated: v20150427 WTL
# Used IMS: anchovy
# Code based off of Lisa's Horm.Rep and BCC study
#
*******************************************************************/

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';


data use;
	set conv.melan_r (where = (race_c=0) );
run;

** reset the results ods output;
ods html close; 
ods html;

***************************;
** Study sample info    ***;
***************************;

proc means data=use n sum mean stddev;
	title 'baseline frequencies';
	var personyrs entry_age exit_age;
run; 
proc freq data = use;
	tables 
		melanoma_agg melanoma_c oralbc_yn_c hormever 
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
** double check to see if any non-melanoma_c were counted as melanoma_agg cases with behav='2';
*** fixed with or parenthesis;
proc print data=use (obs=30);
	title 'print cases';
	where melanoma_c=0 and cancer_behv='2';
	var westatid melanoma_c melanoma_agg cancer_behv cancer_seergroup cancer_siterec3;
run;

ods _all_ close; 
ods html;
*******************************************************************************;
*******************************************************************************;

****************************;
** Confounder -> outcome  **;
****************************;

*************; 
** Table 1 **;
*************;
/* variables:
melanoma_agg
melanoma_ins
melanoma_mal
personyrs
attained_age
birth_cohort

agecat
race_c
educ_c
bmi_fc
physic_c

fmenstr
menostat_c
meno_age_c
hyst_age_c

parity
flb_age_c

oralbc_dur_c
horm_nat_c
horm_hyst_c
uvrq

smoke_former

coffee_c
etoh_c
rel_1d_cancer

* *hormone vars, split into Est, Pro, and E&P
*/
*******************************************************************************;
*******************************************************************************;

** Categorical variables in table 1;

ods htmlcss file='C:\REB\AARP_HRTandMelanoma\Results\T1\rTable1.v4.xls' style=minimal;
proc tabulate data=use missing;
	title 'tabu melanoma_c';
	class melanoma_c total
		agecat attained_age birth_cohort
		race_c educ_c bmi_c physic_c  rf_physic_c
		fmenstr menostat_c meno_age_c hyst_age_c
		parity flb_age_c oralbc_dur_c horm_nat_c  
		horm_hyst_c uvrq
		smoke_former coffee_c etoh_c rel_1d_cancer
		/* Lacey EPT below */
		ht_type_nat ht_type_hyst lacey_eptcurdur2 
		lacey_eptdose lacey_eptregdose lacey_eptregyrs
		/* Lacey ET below */
		lacey_etcurdur lacey_etdose lacey_etfreq
		/* hospital utilization */
		colo_sig_any
	; 
	table
		agecat attained_age birth_cohort
		race_c educ_c bmi_c physic_c  rf_physic_c
		fmenstr menostat_c meno_age_c hyst_age_c
		parity flb_age_c oralbc_dur_c horm_nat_c  
		horm_hyst_c uvrq
		smoke_former coffee_c etoh_c rel_1d_cancer
		/* Lacey EPT below */
		ht_type_nat ht_type_hyst lacey_eptcurdur2 
		lacey_eptdose lacey_eptregdose lacey_eptregyrs
		/* Lacey ET below */
		lacey_etcurdur lacey_etdose lacey_etfreq
		/* hospital utilization */
		colo_sig_any

		,
		(total melanoma_c)* (colpctn='Percent') /nocellmerge
	; 
run; 
ods _all_ close;
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
	tables melanoma_ins* (
		agecat attained_age birth_cohort
		race_c educ_c bmi_c physic_c  rf_physic_c
		fmenstr menostat_c meno_age_c hyst_age_c
		parity flb_age_c oralbc_dur_c horm_nat_c  
		horm_hyst_c uvrq
		smoke_former coffee_c etoh_c rel_1d_cancer
		/* Lacey EPT below */
		ht_type_nat ht_type_hyst lacey_eptcurdur2 
		lacey_eptdose lacey_eptregdose lacey_eptregyrs
		/* Lacey ET below */
		lacey_etcurdur lacey_etdose lacey_etfreq
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
ods html file='C:\REB\AARP_HRTandMelanoma\Results\T1\rTable1ap_ins.xls' style=minimal;
proc print data= Table1ap; 
	title 'print chi2 and trend for melanoma_ins'; run; 
ods html close;

*******************************************************************************;
*******************************************************************************;

** Continuous;
ods html body='C:\REB\AARP_HRTandMelanoma\Results\T1\rTable1b_ins.xls' style=minimal;
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

proc ttest data=use;
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

proc freq data=use;
	title 'freq for melanoma_mal';
	tables melanoma_mal* (
		agecat attained_age birth_cohort
		race_c educ_c bmi_c physic_c  rf_physic_c
		fmenstr menostat_c meno_age_c hyst_age_c
		parity flb_age_c oralbc_dur_c horm_nat_c  
		horm_hyst_c uvrq
		smoke_former coffee_c etoh_c rel_1d_cancer
		/* Lacey EPT below */
		ht_type_nat ht_type_hyst lacey_eptcurdur2 
		lacey_eptdose lacey_eptregdose lacey_eptregyrs
		/* Lacey ET below */
		lacey_etcurdur lacey_etdose lacey_etfreq
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
ods html file='C:\REB\AARP_HRTandMelanoma\Results\T1\rTable1ap_mal.xls' style=minimal;
proc print data= Table1ap; 
	title 'print chi2 and trend for melanoma_mal'; run; 
ods html close;

*******************************************************************************;
*******************************************************************************;

** Continuous;
ods html body='C:\REB\AARP_HRTandMelanoma\Results\T1\rTable1b_mal.xls' style=minimal;
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

proc ttest data=use;
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

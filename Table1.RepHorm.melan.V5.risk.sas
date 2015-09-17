/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
# creates Table 1 descriptives
# with SAS output to MS Excel
# use_rs melan_r dataset
# for v6, riskfactor to FUP
# 
# Created: April 1 2015
# Updated: v20150825TUE WTL
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
proc freq data = use_r;
	tables 
		melanoma_c parity flb_age_c menostat_c meno_reason
	/missing ;
run;

proc freq data = use_r;
	title;
	tables 
		/*menostat_c*(meno_age_c surg_age_c)*/
		menostat_c*ht_type_surg
	/missing ;
run;

proc freq data = use_r;
	tables 
		oralbc_yn_c*melanoma_agg
		hormever*melanoma_agg
		oralbc_yn_c*melanoma_c
		hormever*melanoma_c
	/missing ;
run;

proc freq data=use_r;
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
proc print data=use_r (obs=30);
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
ods _all_ close;
ods htmlcss file='C:\REB\AARP_HRTandMelanoma\Results\misc\T1\rTable1.v14.xls' style=minimal;
proc tabulate data=use_r missing;
	title1 'AARP Riskfactor Melanoma';
	title2 'Table 1 output';
	title3 '20150825TUE WTL';
	title4 'v14';
	class melanoma_c 
		agecat attained_age birth_cohort
		educ_c bmi_c physic_c  
		fmenstr menostat_c ovarystat_c 
		menopi_age mht_ever horm_ever
		parity flb_age_c oralbc_yn_c oralbc_dur_c 
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
	; 
	table
		agecat attained_age birth_cohort
		educ_c bmi_c physic_c  
		fmenstr menostat_c ovarystat_c 
		menopi_age mht_ever horm_ever
		parity flb_age_c oralbc_yn_c oralbc_dur_c 
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

/******************************************************************
#      NIH-AARP HRT- UVR- Reproductive Factors- Melanoma Study
*******************************************************************
# creates Table 2 descriptives
# with SAS output to MS Excel
# uses melan_r dataset
# for v3, riskfactor to FUP
# 
# Created: April 14 2015
# Updated: v20150414 WTL
# Used IMS: anchovy
# Code based off of Lisa's Horm.Rep and BCC study
#
*******************************************************************/

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';


data use;
	set conv.melan_r;
run;

** reset the results ods output;
ods html close; 
ods html;

***************************;
** Study sample info    ***;
***************************;

proc means data=use n sum mean stddev;
	title 'baseline frequencies';
	var personyrs entry_age;
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

*******************************************************************************;
*******************************************************************************;

*****************************;
** Confounder -> exposure  **;
*****************************;

*************; 
** Table 1 **;
*************;
/* variables:
melanoma_agg
melanom_c
personyrs

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
horm_c
uvrq

smoke_former
smoke_quit
smoke_dose
smoke_quit_dose

coffee_c
etoh_c
rel_1d_cancer

* *hormone vars, split into Est, Pro, and E&P
*/
*******************************************************************************;
*******************************************************************************;

** Categorical variables in table 1;

ods htmlcss file='C:\REB\AARP_HRTandMelanoma\Results\T2\rTable2.v1.xls' style=minimal;
proc tabulate data=use missing;
	title 'tabu melanoma_c';
	class melanoma_c
		agecat race_c educ_c bmi_fc physic_c rf_physic_c 
		fmenstr menostat_c meno_age_c hyst_age_c
		parity flb_age_c oralbc_dur_c horm_c  uvrq
		smoke_f_c smoke_quit smoke_dose
		smoke_quit_dose coffee_c etoh_c rel_1d_cancer
		/* Lacey EPT below */
		lacey_ht_type lacey_eptcurdur2 lacey_eptdose lacey_eptregdose lacey_eptregyrs
		/* Lacey ET below */
		lacey_etcurdur lacey_etdose lacey_etfreq
	; 
	table
		agecat race_c educ_c bmi_fc physic_c rf_physic_c
		fmenstr menostat_c meno_age_c hyst_age_c
		parity flb_age_c oralbc_dur_c horm_c  uvrq
		smoke_f_c smoke_quit smoke_dose
		smoke_quit_dose coffee_c etoh_c rel_1d_cancer
		/* Lacey EPT below */
		lacey_ht_type lacey_eptcurdur2 lacey_eptdose lacey_eptregdose lacey_eptregyrs
		/* Lacey ET below */
		lacey_etcurdur lacey_etdose lacey_etfreq
		,
		(melanoma_c)* (colpctn='Percent')
	; 
run; 
ods _all_ close;

*******************************************************************************;
*******************************************************************************;

ods output ChiSq=Table1Chi  
	(keep=Table Statistic Prob rename=(prob=Chi2Pvalue)	where=(Statistic='Chi-Square'));
ods output TrendTest=Table1Trd 
	(keep=Table Name1 cValue1 rename=(cValue1=TrendPvalue) where=(Name1='P2_TREND'));

proc freq data=use;
	tables melanoma_agg* (
		agecat race_c educ_c bmi_fc physic_c rf_physic_c
		fmenstr menostat_c meno_age_c hyst_age_c
		parity flb_age_c oralbc_dur_c horm_c  uvrq
		smoke_f_c smoke_quit smoke_dose
		smoke_quit_dose coffee_c etoh_c rel_1d_cancer
		/* Lacey EPT below */
		lacey_ht_type lacey_eptcurdur2 lacey_eptdose lacey_eptregdose lacey_eptregyrs
		/* Lacey ET below */
		lacey_etcurdur lacey_etdose lacey_etfreq
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
ods html file='C:\REB\AARP_HRTandMelanoma\Results\T2\rTable2ap.xls' style=minimal;
proc print data= Table1ap; 
	title 'print chi2 and trend for melanoma_agg'; run; 
ods html close;

*******************************************************************************;
*******************************************************************************;

** Continuous;
ods html body='C:\REB\AARP_HRTandMelanoma\Results\T2\rTable2b.xls' style=minimal;
proc tabulate data=use;
	title 'tab continuous melanoma_c';
	class melanoma_c;
	var entry_age personyrs ;
	table (entry_age personyrs ),
	(melanoma_c)* (mean='Mean' stddev='SD');
run; 
ods html close;

*******************************************************************************;
*******************************************************************************;

ods output Ttests=Table1T ;

** could use anova for melanoma_c;
proc ttest data=use;
	title 'ttest melanoma_agg';
	class melanoma_agg;
	var entry_age personyrs ;
run;

proc anova data=use;
	title 'anova melanoma_c';
	class melanoma_c;
	model entry_age personyrs = melanoma_c;
	means melanoma_c;
run;

ods html file='C:\REB\AARP_HRTandMelanoma\Results\T2\rTable2bp.xls' style=minimal;
proc print data= Table1T (keep=Variable Variances Probt rename=(Probt=TPvalue)
	where=(Variances='Unequal') ); 
run;
ods html close;
ods html;

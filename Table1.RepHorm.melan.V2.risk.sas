/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
# creates Table 1 descriptives
# with SAS output to MS Excel
# uses melan dataset
# for v2, riskfactor to FUP
# 
# Created: April 1 2015
# Updated: v20150406 WTL
# Used IMS: anchovy
# Code based off of Lisa's Horm.Rep and BCC study
#
*******************************************************************/

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
** reset the results ods output;
ods html close; 
ods html;

***************************;
** Study sample info    ***;
***************************;

proc means data=conv.melan_r n sum mean stddev;
	title 'baseline frequencies';
	var personyrs entry_age;
run; 
proc freq data = conv.melan_r;
	tables 
		melanoma_agg melanoma_c oralbc_yn_c hormever 
	/missing ;
run;

proc freq data = conv.melan_r;
	tables 
		oralbc_yn_c*melanoma_agg
		hormever*melanoma_agg
		oralbc_yn_c*melanoma_c
		hormever*melanoma_c
	/missing ;
run;

proc freq data=conv.melan_r;
	tables
		melanoma_c*melanoma_agg
		melanoma_c*cancer_behv
		melanoma_agg*cancer_behv
	/missing ;
run;
** double check to see if any non-melanoma_c were counted as melanoma_agg cases with behav='2';
*** fixed with or parenthesis;
proc print data=conv.melan (obs=30);
	title 'print cases';
	where melanoma_c=0 and cancer_behv='2';
	var westatid melanoma_c melanoma_agg cancer_behv cancer_seergroup cancer_siterec3;
run;

ods _all_ close; 
ods html;
****************************;
** Confounder -> outcome  **;
****************************;

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
smoke_f_c
perstop_surg
menostat_c
meno_age_c
flb_age_c
parity_c
horm_c
oralbc_dur_c
uvrq
*/

** Categorical variables in table 1;
ods _all_ close;
ods htmlcss file='C:\REB\AARP_HRTandMelanoma\Results\table1r.v2.xls' style=minimal;
proc tabulate data=conv.melan_r missing;
	title 'tabu melanoma_c';
	class melanoma_c
		agecat race_c educ_c bmi_fc physic_c smoke_f_c 
		perstop_surg menostat_c meno_age_c
		flb_age_c parity horm_c oralbc_dur_c uvrq
	; 
	table
		agecat race_c educ_c bmi_fc physic_c smoke_f_c 
		perstop_surg menostat_c meno_age_c
		flb_age_c parity horm_c oralbc_dur_c uvrq
		,
		(melanoma_c)* (colpctn='Percent')
	; 
run; 
ods htmlcss close;
ods output ChiSq=Table1Chi      
	(keep=Table Statistic Prob rename=(prob=Chi2Pvalue)    
	where=(Statistic='Chi-Square'));
ods output TrendTest=Table1Trd  
	(keep=Table Name1 cValue1 rename=(cValue1=TrendPvalue) 
	where=(Name1='P2_TREND'));

proc freq data=conv.melan;
	title 'freq for melanoma_agg';
	tables melanoma_agg* (
		agecat race_c educ_c bmi_fc physic_c smoke_f_c 
		perstop_surg menostat_c meno_age_c
		flb_age_c parity horm_c oralbc_dur_c uvrq
		)	  
		/chisq trend nocol nopercent scores=table;
	  run;

data Table1Chi; 
	set Table1Chi (keep=Table Chi2Pvalue) ;
run;

data Table1Trd; 
	set Table1Trd (keep=Table TrendPvalue) ;
run;

proc sort data=Table1Chi; 
	by Table;
run;

proc sort data=Table1Trd; 
	by Table;
run;

data Table1ap; 
	set Table1Chi Table1Trd ; 
	by Table; 
run;

ods html file='C:\REB\AARP_HRTandMelanoma\Results\Table1ap.xls' style=minimal;
proc print data= Table1ap; 
	title 'print chi2 and trend for melanoma_agg';
run; 
ods html close;

*Continuous;
ods html body='C:\REB\AARP_HRTandMelanoma\Results\Table1b.xls' style=minimal;
proc tabulate data=conv.melan;
	title 'tab continuous melanoma_c';
	class melanoma_c;
	var entry_age personyrs ;
	table (entry_age personyrs ),
	(melanoma_c)* (mean='Mean' stddev='SD');
run; 
ods html close;

ods output Ttests=Table1T ;

** could use anova for melanoma_c;
proc ttest data=conv.melan;
	title 'ttest melanoma_agg';
	class melanoma_agg;
	var entry_age personyrs ;
run;

proc anova data=conv.melan;
	title 'anova melanoma_c';
	class melanoma_c;
	model entry_age personyrs = melanoma_c;
	means melanoma_c;
run;

ods html file='C:\REB\AARP_HRTandMelanoma\Results\Table1bp.xls' style=minimal;
proc print data= Table1T (keep=Variable Variances Probt rename=(Probt=TPvalue)
	where=(Variances='Unequal') ); 
run;
ods html close;
ods html;

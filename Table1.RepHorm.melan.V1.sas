/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
# creates Table 1 descriptives
# with SAS output to MS Excel
# uses melan dataset
# for v1, baseline to FUP
# 
# Created: April 1 2015
# Updated: v20150401 WTL
# Used IMS: anchovy
# Code based off of Lisa's Horm.Rep and BCC study
#
*******************************************************************/

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';

***************************;
** Study sample info    ***;
***************************;

proc means data=conv.melan n sum mean stddev;
	var personyrs entry_age;
run; 
proc freq data = conv.melan;
	tables 
		melanoma_c oralbc_yn_c hormever 
	/missing ;
run;

proc freq data = conv.melan;
	tables 
		oralbc_yn_c*melanoma_c
		hormever*melanoma_c
	/missing ;
run;

ods _all_ close; ods html;
****************************;
** Confounder -> outcome  **;
****************************;

*************; 
** Table 1 **;
*************;

ods _all_ close;ods html;
*Categorical;
ods html body= 'C:\REB\AARP_HRTandMelanoma\Results\table.1' style=minimal;
proc tabulate data=conv.melan missing;
	class melanoma_c 
		educ_c LQ2_MARSTAT LQ2_SMK_CUR alcohol bmi_cat diur_ever
		LQ2_Q70_1716 eye hair  LQ2_Q81_1803 uvtoms305q
	; 
	table
		education LQ2_MARSTAT LQ2_SMK_CUR alcohol bmi_cat diur_ever
		LQ2_Q70_1716 eye hair  LQ2_Q81_1803 uvtoms305q
		,
		(EVENT_BCC)* (colpctn='Percent')
	; 
run; 
ods html close;
ods output ChiSq=Table1Chi      
	(keep=Table Statistic Prob rename=(prob=Chi2Pvalue)    
	where=(Statistic='Chi-Square'));
ods output TrendTest=Table1Trd  
	(keep=Table Name1 cValue1 rename=(cValue1=TrendPvalue) 
	where=(Name1='P2_TREND'));
proc freq data=conv.melan;
tables EVENT_BCC* (
LQ2_SMK_CUR alcohol bmi_cat ex_stren diur_ever
LQ2_Q70_1716 eye hair  LQ2_Q81_1803 uvtoms305q
  
)	  /chisq trend nocol nopercent scores=table;
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
run; 
ods html close;

*Continuous;
ods html body='C:\REB\AARP_HRTandMelanoma\Results\Table1b.xls' style=minimal;
proc tabulate data=conv.melan;
	class melanoma_c;
	var entry_age personyrs ;
	table (entry_age personyrs ),
	(melanoma_c)* (mean='Mean' stddev='SD');
run; ods html close;

ods output Ttests=Table1T ;
proc ttest data=conv.melan;
	class melanoma_c;
	var entry_age personyrs ;
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\Table1bp.xls' style=minimal;
proc print data= Table1T 
	(keep=Variable Variances Probt rename=(Probt=TPvalue)
	where=(Variances='Unequal') ); 
run;
ods html close;

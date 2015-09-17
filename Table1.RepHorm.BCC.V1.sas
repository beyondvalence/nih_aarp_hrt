LIBNAME Data 'E:\NCI\HRT OC and BCC in USRT\Data';

***************************;
** Study sample info    ***;
***************************;
proc means data=use n sum mean stddev;
var followup entry_age;
run; 
proc freq data = use;
tables EVENT_BCC oc_evr_me hrt_evr_me /missing ;
run;

proc freq data = use;
tables 
oc_evr_me*EVENT_BCC
hrt_evr_me*EVENT_BCC
/missing ;
run;

ods _all_ close;ods html;
****************************;
** Confounder -> outcome  **;
****************************;

*************; 
** Table 1 **;
*************;

ods _all_ close;ods html;
*Categorical;
ods html body= 'E:\NCI\HRT OC and BCC in USRT\Results\Table1a.xls' style=minimal;
proc tabulate data=use missing;
class EVENT_BCC 
education LQ2_MARSTAT LQ2_SMK_CUR alcohol bmi_cat diur_ever
LQ2_Q70_1716 eye hair  LQ2_Q81_1803 uvtoms305q
; 
table
education LQ2_MARSTAT LQ2_SMK_CUR alcohol bmi_cat diur_ever
LQ2_Q70_1716 eye hair  LQ2_Q81_1803 uvtoms305q
,
(EVENT_BCC)* (colpctn='Percent'); 
run; 
ods html close;
ods output ChiSq=Table1Chi      (keep=Table Statistic Prob rename=(prob=Chi2Pvalue)    where=(Statistic='Chi-Square'));
ods output TrendTest=Table1Trd  (keep=Table Name1 cValue1 rename=(cValue1=TrendPvalue) where=(Name1='P2_TREND'));
proc freq data=use;
tables EVENT_BCC* (
LQ2_SMK_CUR alcohol bmi_cat ex_stren diur_ever
LQ2_Q70_1716 eye hair  LQ2_Q81_1803 uvtoms305q
  
)	  /chisq trend nocol nopercent scores=table;
	  run;
data Table1Chi; set Table1Chi (keep=Table Chi2Pvalue) ;run;
data Table1Trd; set Table1Trd (keep=Table TrendPvalue) ;run;
proc sort data=Table1Chi; by Table;run;
proc sort data=Table1Trd; by Table;run;
data Table1ap; set Table1Chi Table1Trd ; by Table; run;
ods html file='E:\NCI\HRT OC and BCC in USRT\Results\Table1ap.xls' style=minimal;
proc print data= Table1ap; run; 
ods html close;

*Continuous;
ods html body='E:\NCI\HRT OC and BCC in USRT\Results\Table1b.xls' style=minimal;
proc tabulate data=use;
class EVENT_BCC;
var entry_age followup ;
table (entry_age followup ),
(EVENT_BCC)* (mean='Mean' stddev='SD');
run; ods html close;

ods output Ttests=Table1T ;
proc ttest data=use;
class EVENT_BCC;
var entry_age followup ;
run;
ods html file='E:\NCI\HRT OC and BCC in USRT\Results\Table1bp.xls' style=minimal;
proc print data= Table1T (keep=Variable Variances Probt rename=(Probt=TPvalue)where=(Variances='Unequal') ); run;
ods html close;

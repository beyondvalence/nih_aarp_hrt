/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
# creates Table 1 descriptives
#
# uses melan dataset
# 
# Created: February 18 2015
# Updated: v20150327 WTL
# Used IMS: anchovy
#
*******************************************************************/

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';

/***************************************************************************************/
****Table1 macro;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\anchovy\q5.table1.macro.sas' ;

/***************************************************************************************/
**** Quantile macro to create quintiles;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\anchovy\quantile.macro.w.sas';

** Study Sample Info for person years and entry age;
/***************************************************************************************/
** person years;
%quantile(conv.melan, personyrs, personyrsQ, 5, 0);
** cases;
%category(conv.melan, melanoma_c, hormstat);
** age;
%category(conv.melan, agecat, melanoma_c);
** race;
%category(conv.melan, race_c, melanoma_c);
** BMI;
%category(conv.melan, bmi_fc, melanoma_c);
** education;
%category(conv.melan, educ_c, melanoma_c);
** physical activity;
%category(conv.melan, physic_c, melanoma_c);
** smoking;
%category(conv.melan, smoke_f_c, melanoma_c);
** hysterectomy;
%category(conv.melan, perstop_surg, melanoma_c);
** postmenopausal;
%category(conv.melan, menostat, melanoma_c);
** age at first live birth;
%category(conv.melan, flb_age_c, melanoma_c);
** parity;
%category(conv.melan, parity, melanoma_c);
** oralbc duration;
%category(conv.melan, oralbc_dur_c, melanoma_c);
** hormone therapy;
%category(conv.melan, horm_c, melanoma_c);
** any estrogen;
%category(conv.melan, rf_estrogen, melanoma_c);
** any progestin;
%category(conv.melan, rf_progestin, melanoma_c);
** ;

proc means data=conv.melan n sum mean stddev;
	var personyrs entry_age;
run;

proc freq data=conv.melan;
	tables melanoma_c /missing;
run;
/***************************************************************************************/
** check the hormone use variables;
/***************************************************************************************/
proc means data=conv.melan;
	title 'melanoma frequencies - hormone use';
	var daugh_estonly_calc_mo daugh_estonly_calc_mo_2002 
		daugh_estprg_calc_mo daugh_estprg_calc_mo_2002
		daugh_est_calc_mo daugh_est_calc_mo_2002
		daugh_prgonly_calc_mo daugh_prgonly_calc_mo_2002
		daugh_prg_calc_mo daugh_prg_calc_mo_2002
	;
run;
/***************************************************************************************/
**                                                                       ;
/***************************************************************************************/
proc sort data=conv.melan;
	by melanoma_c;
run;

proc means data=conv.melan;
	title 'covariate means by melanoma_c status';
	var entry_age BMI_CUR ;
	by melanoma_c;
run;

proc freq data=conv.melan;
	title 'covariate sums by melanoma_c status';
	table BF_SMOKE_EVER BF_SMOKE_FORMER Q45 Q32 physic mped_a_bev oralbc_yrs;
	by melanoma_c;
run;

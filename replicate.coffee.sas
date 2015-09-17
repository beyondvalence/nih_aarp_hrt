/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
#
# recreates exclusions from the Loftfield coffee paper
#
# uses the analysis dataset
#
# Created: February 19 2015
# Updated: v20150219 WTL
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************/

/***************************************************************************************/
libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';

**** Exclusions macros;
* both using same cancer files- first cancer and all cancer exclusions;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\anchovy\exclusions.first.primary.macro.sas';
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\anchovy\outbox.macro.sas';

***************************************************************************************;
** Check for exclusions from Loftfield Coffee paper;
** total of n=566398;
** excluded proxy-responders, n=15760 check;
** excluded cancer (ignore nnmsc) prior to baseline, n=51234;
** excluded death record only, n=2354;
** excluded race or ethnicity other than white nonhispanic, n=44600;
** excluded missing coffee intake, n=1781;
** excluded 2xIQR beyond high75%/low25% calorie intake, n=3283, use the outbox macro;
** excluded zero followup years, n=29;
** after exclusions, resulted in 447,357;
*** end coffee paper checks;
/***************************************************************************************/
data analysis;
	set conv.analysis(keep= westatid
							sex
							cancer_seergroup
							entry_age
							fl_proxy 		/*for proxy responders*/
							cancer 
							cancer_behv
							cancer_siterec3
							DODSource 
							racem 			/*for race*/
							qp12b			/*for missing coffee*/
							calories		/*for extreme caloric intakes*/
							skin_dxdt
							dod
							raadate
							f_dob
							entry_dt
							self_prostate
							self_breast
							self_colon
							self_other
							health
							renal
							);

	*Chooses the earliest of 4 possible exit dates;
	exit_dt = min(mdy(12,31,2006), skin_dxdt, dod, raadate); 
    exit_age = round(((exit_dt-f_dob)/365.25),.001);
	personyrs = round(((exit_dt-entry_dt)/365.25),.001);
	** mark the negative person-years;
	pyr_f=.;
	if personyrs > 0 then pyr_f=1;
	else if personyrs <0 then pyr_f=-1;
	else if personyrs =0 then pyr_f=0;
	format f_dob entry_dt exit_dt dod raadate cancer_dxdt Date9.;

	****** Define melanoma - pulled from allcancer-coffee analysis ******; 
	melanoma_c = 0;
    if cancer=1 and cancer_behv='2' and cancer_seergroup = 18 and cancer_siterec3=25010 then melanoma_c = 1;
    	else if cancer=1 and cancer_behv='3' and cancer_seergroup = 18 and cancer_siterec3=25010 then melanoma_c = 2;  
		else melanoma_c = 0;
    	*if cancer=1 and cancer_behv in ('2','3') and cancer_seergroup = 18 and cancer_siterec3=25010 then melanoma_c = 1;  *else melanoma_c = 0;

run;

/***************************************************************************************/
proc freq data=analysis;
	tables pyr_f cancer melanoma_c;
run;

proc contents data=analysis;
run;
/***************************************************************************************/
****  Create exit date, exit age, and person years for First Primary Cancer;
/* 
for DODSource
B = Buccal Cell Study Responses
C = Cancer Registry Returns, Version 2
F = Followup Questionnaire Responses
N = National Death Index
M = Missing
P = Pilot Study Followup Quex, Box B
R = RFQ Box A
S = SSA Death Match File
U = Known Date, Unknown Source.

for calories,
use the outbox
*/

********************************************************************************************;
** Use the exclusion macro to make "standard" exclusions and get counts of excluded subjects;
** for first cancer;
%exclude(data            = analysis,
         ex_proxy        = 1,
         ex_sex          = ,
         ex_selfprostate = 1,
         ex_selfbreast   = 1,
         ex_selfcolon    = 1,
         ex_selfother    = 1,
         ex_health       = ,
         ex_renal        = 0,
         ex_prevcan      = 1,
         ex_deathcan     = 1);

/***************************************************************************************/ 
/*   Exclude if not 'non-Hispanic White'                                                */
/***************************************************************************************/      
data analysis excl_race;
   set analysis;
   if racem in (2,3,4,9) then output excl_race;
   else output analysis;
run;

/***************************************************************************************/ 
/*   Exclude if 'no info on coffee use'                                                */
/***************************************************************************************/      
data analysis excl_misscoffee;
   set analysis;
   if qp12b in ('E','M','') then output excl_misscoffee;
   else output analysis;
run;

/***************************************************************************************/ 
/*   Exclude if low or high caloric consumption                                        */
/***************************************************************************************/      
* Define outliers for total energy;
%outbox(data     = analysis,
        id       = westatid,
        by       = sex,
        comb_by  = ,
        var      = calories,
        cutoff1  = 3,
        cutoff2  = 2,
        keepzero = N,
        lambzero = Y,
        print    = N,
        step     = 0.01,
        addlog   = 0);

data analysis excl_kcal;
   set analysis;
   if noout_calories <= .z  then output excl_kcal;
   else output analysis;
run;

/***************************************************************************************/ 
/*   Exclude if person-years = 0                                                       */
/***************************************************************************************/      
data analysis excl_py_zero;
   set analysis;
   if personyrs <= 0 then output excl_py_zero;
   else output analysis;
run;

proc freq data=analysis;
	tables fl_proxy cancer_seergroup DODSource racem qp12b /missing;
run;

/***************************************************************************************/
** output the summary data of personyears to check;
proc means data=analysis noprint nway;
	var personyrs;
	output 	out = summary
			mean =
			n =
			median =
			max =
			min = /autoname;
run;
proc print data=summary;
	title 'summary data for personyears - firstc';
	*title 'summary data for personyears - allcan';
run;

***************************************************;

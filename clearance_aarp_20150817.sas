/*****************************************************************************;
#             NIH-AARP UVR- Reproductive Factors- Melanoma Study             *;
******************************************************************************;
#
# NIH-AARP Diet and Health Study clearance form:
# !!!! do not run, clearance form code only !!!!
# includes code for new variables and code to generate tables and listings
#
# uses the conv.melan, conv.melan_r datasets
#
# Created: August 17 2015 WTL
# Updated: v20151001THU WTL
# <under git version control>
******************************************************************************/

** import the UVR with file extension v9x from the anchovy folder;
proc cimport data=uv_pub1 infile=uv_pub; 
run;

** keep the july UVR data only;
data conv.uv_pub1;
	set uv_pub1; 
	keep	westatid
			exposure_jul_78_05;
run;

data analysis_use;
	set analysis_use;
	****  Create exit date, exit age, and person years for First Primary Cancer;
	** with first primary cancer as skin cancer;
	** Chooses the earliest of 4 possible exit dates for skin cancer;
  	exit_dt = min(mdy(12,31,2006), skin_dxdt, dod, raadate); 
  	exit_age = round(((exit_dt-f_dob)/365.25),.001);
  	personyrs = round(((exit_dt-entry_dt)/365.25),.001);

	format exit_dt entry_date f_dob dod skin_dxdt raadate Date9.;
run;

data melan; ** name the output of the first primary analysis include to melan;
	set conv.analysis_use;
/* check point for merging the exposure and outcome data */
** copy and save the analysis_use dataset to the converted folder;

	** create the melanoma case variable from the ICD-O-3 and SEER coding of 25010;
	melanoma_c = .;
	* in situ melanoma =1;
    if cancer_behv='2' and cancer_seergroup = 18 and cancer_siterec3=25010 
		then melanoma_c = 1;
	* malignant melanoma =2;
	else if cancer_behv='3' and cancer_seergroup = 18 and cancer_siterec3=25010 
		then melanoma_c = 2;  
	else melanoma_c = 0;

	melanoma_agg = .;
	* melanoma including in situ and malignant;
	if (cancer_behv='2' or cancer_behv='3') and cancer_seergroup=18 and cancer_siterec3=25010
		then melanoma_agg = 1;
	else melanoma_agg = 0;

	melanoma_ins=.;
	** melanoma in situ;
	if 	 melanoma_c=1 	then melanoma_ins=1;
	else melanoma_ins=0;

	melanoma_mal=.;
	** melanoma malignant;
	if	 melanoma_c=2	then melanoma_mal=1;
	else melanoma_mal=0;
run;

** merge the melan dataset with the UV data;
data melan;
	merge melan conv.uv_pub1;
	by westatid;
run;

** copy and save the melan dataset to the converted folder;
proc copy noclone in=Work out=conv;
	select melan;
run;

**** Exclusions macro;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\anchovy\exclusions.first.primary.macro.sas';
ods _all_ close; ods html;
%exclude(data            = conv.melan,
         ex_proxy        = 1,
         ex_sex          = 0,
         ex_selfprostate = 1,
         ex_selfbreast   = 1,
         ex_selfcolon    = 1,
         ex_selfother    = 1,
         ex_health       = ,
         ex_renal        = 0,
         ex_prevcan      = 1,
         ex_deathcan     = 1);

/***************************************************************************************/ 
/*   Exclude if non-whites, racem = 1
**	 Edit: 20150901TUE WTL;
/*	 excl_1_nonwhite 																   
/*   Extract year from DOB 			                                                   
/***************************************************************************************/ 
data conv.melan;
	title 'Ex 1. exclude non whites, excl_1_nonwhite';
	set conv.melan;
	dob_year = YEAR(F_DOB);
	excl_1_nonwhite=0;
	if racem NE 1 then excl_1_nonwhite=1;
run;
proc freq data=conv.melan;
	tables excl_1_nonwhite 
			excl_1_nonwhite*melanoma_c /missing;
run;

/***************************************************************************************/ 
/*   Exclude if pre-menopausal, perstop_nostop = 1 
/*	 Exclusions Edit: 20150901TUE WTL
/*   excl_2_premeno
/*   should account for menop_age = 6 as well? Yes, use OR - Lisa
/***************************************************************************************/ 
data conv.melan;
	title 'Ex 2. exclude premenopausal women, excl_2_premeno';
	set conv.melan;
	excl_2_premeno=0;
	if perstop_nostop=1 | menop_age=6 then excl_2_premeno=1;
	where excl_1_nonwhite=0;
run;
proc freq data=conv.melan;
	tables excl_1_nonwhite*excl_2_premeno 
			excl_2_premeno*melanoma_c /missing;
run;

/***************************************************************************************/ 
/*   Exclude if self-reported periods stopped due to radchem                           */ 
**	 exclude: excl_3_radchem;
**   edit: 20150929TUE WTL;
/***************************************************************************************/ 
data conv.melan;
	title 'Ex 3. exclude women whose periods stopped due to rad/chem, excl_3_radchem';
	set conv.melan;
	excl_3_radchem=0;
	if perstop_radchem=1 then excl_3_radchem=1;
	where excl_2_premeno=0;
run;
proc freq data=conv.melan;
	tables excl_2_premeno*excl_3_radchem 
			excl_3_radchem*melanoma_c /missing;
run;

/***************************************************************************************/ 
/*   Exclude if younger than 60 and with no menopause reason                           */ 
**   edit 20151002FRI WTL;
/***************************************************************************************/ 
data conv.melan;
	title 'Ex 4. exclude those younger than 60 and with no menopause reason, excl_4_npostmeno';
	set conv.melan;
	excl_4_npostmeno=0;
	if entry_age < 60 & (perstop_menop NE 1 & perstop_surg NE 1 & ovarystat NE 1 & hyststat NE 1) then excl_4_npostmeno=1;
	where excl_3_radchem=0;
run;
proc freq data=conv.melan;
	tables excl_3_radchem*excl_4_npostmeno 
			excl_4_npostmeno*melanoma_c /missing;
run;
proc freq data=conv.melan;
	tables postmeno*melanoma_c /missing;
run;

/***************************************************************************************/ 
data conv.melan;
	title;
	set conv.melan;

/* for baseline */
	** UVR TOMS quantiles;
	UVRQ=.;
	if      0       < exposure_jul_78_05 <= 186.918 then UVRQ=1;
	else if 186.918 < exposure_jul_78_05 <= 239.642 then UVRQ=2;
	else if 239.642 < exposure_jul_78_05 <= 253.731 then UVRQ=3;
	else if 253.731 < exposure_jul_78_05            then UVRQ=4;
	else UVRQ=-9;

	** physical exercise cat;
	physic_c=.;
	if      physic in (0,1)	then physic_c=0; /* rarely */
	else if physic=2 	 	then physic_c=1; /* 1-3 per month */
	else if physic=3 	 	then physic_c=2; /* 1-2 per week */
	else if physic=4     	then physic_c=3; /* 3-4 per week */
	else if physic=5     	then physic_c=4; /* 5+ per week */
	else if physic=9	 	then physic_c=-9; /* missing */

	** oral contraceptive duration cat;
	oralbc_dur_c=.;
	if      oralbc_yrs=0		then oralbc_dur_c=0; /* none */
	else if oralbc_yrs=1		then oralbc_dur_c=1; /* 1-4 years */
	else if oralbc_yrs=2		then oralbc_dur_c=2; /* 5-9 years */
	else if oralbc_yrs=3 		then oralbc_dur_c=3; /* 10+ years */
	else if oralbc_yrs in (8,9)	then oralbc_dur_c=-9; /* missing */

	** oral contraceptive yes/no;
	oralbc_yn_c=.;
	if      oralbc_yrs=0 	then oralbc_yn_c=0; /* no oc */
	else if 0<oralbc_yrs<8	then oralbc_yn_c=1; /* yes oc */
	else if oralbc_yrs>7	then oralbc_yn_c=-9; /* missing */

	** age at menarche cat;
	if      fmenstr=1	then fmenstr=0; /* <=10 years old */
	else if fmenstr=2	then fmenstr=1; /* 11-12 years old */
	else if fmenstr=3	then fmenstr=2; /* 13-14 years old */
	else if fmenstr=4	then fmenstr=3; /* 15+ years old */
	else if fmenstr>4	then fmenstr=-9; /* missing */

	** education cat;
	educ_c=.;
	if 		educm=1 		then educ_c=0; /* less highschool */
	else if educm=2			then educ_c=1; /* highschool grad */
	else if educm in (3,4)	then educ_c=2; /* some college */
	else if educm=5			then educ_c=3; /* college and grad */
	else if educm=9			then educ_c=-9; /* missing */

	** race cat;
	race_c=.;
	if      racem=1			then race_c=0; /* non hispanic white */
	else if racem=2			then race_c=1; /* non hispanic black */
	else if racem in (3,4) 	then race_c=2; /* hispanic, asian PI AIAN */
	else if racem=9			then race_c=-9; /* missing */

	** age at first live birth cat;
	flb_age_c=9;
	if 		age_flb in (1,2)	then flb_age_c=1; /* < 20 years old */
	else if age_flb in (3,4)	then flb_age_c=2; /* 20s */
	else if age_flb in (5,6,7)	then flb_age_c=3; /* 30s */
	else if age_flb in (0,8,9)	then flb_age_c=-9; /* missing */

	** menopause reason, 20150901 edit;
	** 1 natural, 2 surgical;
	menostat_c=.;
	if		perstop_surg=1 | hyststat=1 | ovarystat=1		then menostat_c=2; /* surgical */
	else if	perstop_menop=1									then menostat_c=1; /* natural */

	** menopausal age recoded;
	if 		menop_age in (6,9)						then menop_age=9; /* missing */
	else if menop_age in (1,2)						then menop_age=1; /* <45 */
	else if menop_age=3								then menop_age=2; /* 45-49 */
	else if menop_age=4								then menop_age=3; /* 50-54 */
	else if menop_age=5								then menop_age=4; /* 55+ */
	menop_age_me = menop_age;
	if 		menop_age_me=9							then menop_age_me=.; /* missing for main effect */

	** menopausal age recoded with merged higher age groups;
	** for interaction;
	menopi_age = menop_age;
	if menopi_age = 4								then menopi_age=3; /* 50<= */
	menopi_age_me = menopi_age;
	if menopi_age_me = 9							then menopi_age_me=.; /* missing for main effect */

	** ovary status among surgical menopause;
	ovarystat_c=.;
	if 		ovarystat=1 & menostat_c=2				then ovarystat_c=1; /* both removed */
	else if ovarystat=2 & menostat_c=2				then ovarystat_c=2; /* both intact */
	else if ovarystat in (3,9) & menostat_c=2		then ovarystat_c=-9; /* invalids are missing */

	** former smoker status cat;
	smoke_f_c=.;
	if      bf_smoke_former=0				then smoke_f_c=0; /* never smoke */
	else if bf_smoke_former=1				then smoke_f_c=1; /* former smoker (ever)*/
	else if bf_smoke_former=2				then smoke_f_c=1; /* current smoker? (ever)*/
	else if bf_smoke_former=9				then smoke_f_c=-9; /* missing */
	else smoke_f_c=-9;

	** hormone former or current user;
	horm_ever_me=.;
	if		hormstat=0						then horm_ever_me=0;   /* never horm */
	else if hormstat=1						then horm_ever_me=1;   /* former horm */
	else if hormstat=2						then horm_ever_me=2;   /* current horm */
	else 	horm_ever_me=.;							   				/* missing horm */

	horm_ever = horm_ever_me;
	if horm_ever_me=.						then horm_ever=-9;

	** MHT ever variable;
	mht_ever=horm_ever;
	if		mht_ever=2						then mht_ever=1;
	mht_ever_me = mht_ever;
	if mht_ever_me = -9						then mht_ever_me=.;

	** live child parity cat;
	parity=.;
	if 		livechild=0						then parity=0; /* no live children (nulliparous) */
	else if livechild in (1,2) 				then parity=1; /* 1 to 2 live children */
	else if livechild in (3,4,5) 			then parity=2; /* >=3 live children */
	else if livechild in (8,9)				then parity=-9; /* missing */

	parity_ever=parity;
	if parity_ever in (1,2)					then parity_ever=1;

	** cancer grade cat;
	cancer_g_c=.;
	if 	    cancer_grade=1					then cancer_g_c=0; 
	else if cancer_grade=2					then cancer_g_c=1;
	else if cancer_grade=3					then cancer_g_c=2;
	else if cancer_grade=4					then cancer_g_c=3;
	else if cancer_grade=9					then cancer_g_c=-9; /* missing */

	********************************************;
	** bmi categories;

	** bmi three categories;
	bmi_c=-9;
	if      0<=bmi_cur<25					then bmi_c=1; /* < 25 */
   	else if 25<=bmi_cur<30 					then bmi_c=2; /* 25 to <30*/
   	else if bmi_cur>=30 					then bmi_c=3; /* >=30*/ 
	else if bmi_cur=.						then bmi_c=-9;

	** continuous bmi;
	bmi_cont=bmi_cur/5;

	** first primary cancer stage;
	stage_c=.;
	if      cancer_ss_stg=0 				then stage_c=0; /* in situ */
	else if cancer_ss_stg=1 				then stage_c=1; /* localized */
	else if cancer_ss_stg in (2,3,4,5)		then stage_c=2; /* regional */
	else if cancer_ss_stg=7					then stage_c=3; /* distant metastases */
	else if cancer_ss_stg in (8,9)			then stage_c=-9; /* not abstracted, unstaged */
	else if cancer_ss_stg=. 				then stage_c=-9; /* missing */

	** coffee drinking;
	coffee_c=.;
	if		qp12b='0'							then coffee_c=0; 	/* none */
	else if qp12b in ('1','2','3','4','5','6')	then coffee_c=1; 	/* <=1/day */
	else if qp12b='7'							then coffee_c=2; 	/* 2-3/day */
	else if qp12b in ('8','9')					then coffee_c=3; 	/* >=4/day */
	else if qp12b in ('E','M')					then coffee_c=-9;	/* missing */
	else	coffee_c=-9; 											/* missing */

	** total alcohol per day;
	etoh_c=.;
	if 		mped_a_bev=0					then etoh_c=0;		/* none */
	else if 0<mped_a_bev<=1					then etoh_c=1;		/* <=1 */
	else if 1<mped_a_bev<=3 				then etoh_c=2;		/* >1 and =<3 */
	else if 3<mped_a_bev					then etoh_c=3;		/* >3 */
	else 	etoh_c=-9;											/* missing */

	** total, for summary measures;
	total=1;

	** smoking missings recode;
	if smoke_former=9 						then smoke_former=-9;
	if smoke_quit=9 						then smoke_quit=-9;
	if smoke_dose=9							then smoke_dose=-9;
	if smoke_quit_dose=9					then smoke_quit_dose=-9;

	** marriage;
	if marriage in (3,4)					then marriage=3; /* divorced and separated together */

	** hormone duration;
	horm_yrs_c = horm_yrs;
	if		horm_yrs in (8,9)				then horm_yrs_c=-9; /* missing */

	** hormone duration split meno/surg reasons;
	horm_yrs_nat_c=.;
	if menostat_c=1 						then horm_yrs_nat_c=horm_yrs_c;
	else if menostat_c NE 1					then horm_yrs_nat_c=.;
	horm_yrs_surg_c=.;
	if menostat_c=2							then horm_yrs_surg_c=horm_yrs_c;
	else if menostat_c NE 2					then horm_yrs_surg_c=.;

run;


/***************************************************************************************/ 
/*   Exclude if missing info on cause of menopause                                     */ 
**   exclude: excl_5_unkmenop;
**   edit: 20150901TUE WTL;
/***************************************************************************************/ 
data conv.melan ;
	title 'Ex 5. exclude women with missing menopause cause, excl_5_unkmenop';
	set conv.melan;
	** no hysterectomy, oopherectomy, surgical or natural menopause reason;
	** rad/chem was excluded above;
	excl_5_unkmenop=0;
	if ( hyststat NE 1 & ovarystat NE 1 & perstop_surg NE 1 & perstop_menop NE 1 ) then excl_5_unkmenop=1;
	where excl_4_radchem=0;
run;
proc freq data=conv.melan;
	tables excl_4_radchem*excl_5_unkmenop 
			excl_5_unkmenop*melanoma_c /missing;
run;

/***************************************************************************************/ 
/*   Exclude if person-years <= 0                                                      */
**   exclude: excl_6_pyzero;
**   edit: 20150901TUE WTL;
/***************************************************************************************/      
data conv.melan;
	title 'Ex 6. exclude women with zero or less person years, excl_6_pyzero';
	set conv.melan;
    excl_6_pyzero=0;
   	if personyrs <= 0 then excl_6_pyzero=1;
   	where excl_5_unkmenop=0;
run;
proc freq data=conv.melan;
	tables excl_5_unkmenop*excl_6_pyzero 
			excl_6_pyzero*melanoma_c /missing;
run; 
data conv.melan;
	title;
	set conv.melan;
	where excl_6_pyzero=0;
run;

data conv.melan;
	set conv.melan;
	** recode parity and flb_age_c to consolidate contradicting missings in each;
	** if nulliparous or missing number of births, then age at birth should be missing;
	*** -9 in flb_age means missing to begin with;
	*** whereas 9 in flb_age means they were coerced to be missing due to missing parity;
	if		parity in (1,2) & flb_age_c=9	then flb_age_c=-9; 
	else if parity=2 & flb_age_c=9			then flb_age_c=-9;
	if 		parity in (0,-9)					then flb_age_c=9;
run;

**************************;
***** Start2 here ********;
**************************;

/* for riskfactor */

	** (rf) physical exercise how often participate mod-vig activites in past 10 years;
	** use this one;
	rf_physic_c=.;
	if		rf_phys_modvig_curr in (0,1)	then rf_physic_c=0;	/* none-rarely */
	else if rf_phys_modvig_curr=2			then rf_physic_c=1; /* <1 hr/week */
	else if rf_phys_modvig_curr=3			then rf_physic_c=2; /* 1-3 hr/week */
	else if rf_phys_modvig_curr=4			then rf_physic_c=3; /* 4-7 hr/week */
	else if rf_phys_modvig_curr=5			then rf_physic_c=4; /* >7 hr/week */
	else if rf_phys_modvig_curr=9			then rf_physic_c=-9; /* missing */
	else rf_physic_c=-9;

	** lacey hormone type by natural menopause and surgery;
	** edited 20150708WED WTL;
	ht_type_nat=9;
	if 		lacey_ht_type = 0 & menostat_c=1		then ht_type_nat=0; /* no ht */
	else if	lacey_ht_type = 1 &	menostat_c=1		then ht_type_nat=1; /* et */
	else if	lacey_ht_type = 2 &	menostat_c=1		then ht_type_nat=2; /* ept */
	else if	lacey_ht_type = 3 & menostat_c=1		then ht_type_nat=3; /* unk type */
	else if lacey_ht_type = 9 & menostat_c=1		then ht_type_nat=9; /* unknown */
	else if menostat_c NE 1							then ht_type_nat=.;

	ht_type_nat_ever=ht_type_nat;
	if ht_type_nat_ever in (1,2,3)					then ht_type_nat_ever=1; /* ever HT */

	ht_type_surg=9;
	if 		lacey_ht_type = 0 & menostat_c=2			then ht_type_surg=0; /* no ht */
	else if	lacey_ht_type = 1 &	menostat_c=2			then ht_type_surg=1; /* et */
	else if	lacey_ht_type = 2 &	menostat_c=2			then ht_type_surg=2; /* ept */
	else if	lacey_ht_type = 3 & menostat_c=2			then ht_type_surg=3; /* unk type */
	else if lacey_ht_type = 9 & menostat_c=2			then ht_type_surg=9; /* unknown */
	else if menostat_c NE 2								then ht_type_surg=.;

	ht_type_surg_ever=ht_type_surg;
	if ht_type_surg_ever in (1,2,3)						then ht_type_surg_ever=1; /* ever HT */

	/* colonoscopy and sigmoidoscopy rf_Q15* */
	colo_sig_any=-9;
	if rf_Q15E=1		then colo_sig_any=0;
	else if rf_Q15E=0	then colo_sig_any=1;

	*******************************************************************************************;
	*************** HRT variables *************************************************************;
	*******************************************************************************************;
	** use Jim Lacey's coding of the variables *********;
	** recode for main effects *************************;
	** updated 20150708WED WTL **;
	****************************************************;
	** EPT current ***************;
	lacey_eptcurrent_ever = lacey_eptcurrent;
	if lacey_eptcurrent_ever in (1,2)		then lacey_eptcurrent_ever=1; /* ever EPT */
	lacey_eptcurrent_ever_me = lacey_eptcurrent_ever;
	if lacey_eptcurrent_ever_me=4			then lacey_eptcurrent_ever_me=.;
	lacey_eptcurrent_me = lacey_eptcurrent;
	if lacey_eptcurrent=4					then lacey_eptcurrent_me=.;

	** EPT dose ***************;
	lacey_eptdose_c=.;
	if lacey_eptcurrent in (1,2) & lacey_eptdose in (1,2,3,4) then lacey_eptdose_c=lacey_eptdose;
	else lacey_eptdose_c=-9;
	lacey_eptdose_me = lacey_eptdose_c;
	if lacey_eptdose_c=-9						then lacey_eptdose_me=.;

	** EPT duration ***************;
	lacey_eptdur_c = .;
	if lacey_eptcurrent in (1,2) & lacey_eptdur in (1,2,3) then lacey_eptdur_c=lacey_eptdur;
	else lacey_eptdur_c=-9;
	lacey_eptdur_me = lacey_eptdur_c;
	if lacey_eptdur_c=-9						then lacey_eptdur_me=.;
	
	** ET current ***************;
	lacey_etcurrent_ever = lacey_etcurrent;
	if lacey_etcurrent_ever in (1,2)		then lacey_etcurrent_ever=1; /* ever ET */
	lacey_etcurrent_ever_me = lacey_etcurrent_ever;
	if lacey_etcurrent_ever_me=4			then lacey_etcurrent_ever_me=.;
	lacey_etcurrent_me = lacey_etcurrent;
	if lacey_etcurrent=4					then lacey_etcurrent_me=.;

	** ET dose ***************;
	lacey_etdose_c=.;
	if lacey_etcurrent in (1,2) & lacey_etdose in (1,2,3) then lacey_etdose_c=lacey_etdose;
	else lacey_etdose_c=-9;
	lacey_etdose_me = lacey_etdose_c;
	if lacey_etdose_c=-9						then lacey_etdose_me=.;

	** ET duration ***************;
	lacey_etdur_c=.;
	if lacey_etcurrent in (1,2) & lacey_etdur in (1,2) then lacey_etdur_c=lacey_etdur;
	else lacey_etdur_c=-9;
	lacey_etdur_me = lacey_etdur_c;
	if lacey_etdur_c=-9						then lacey_etdur_me=.;

	** ET freq ***************;
	lacey_etfreq_c=.;
	if lacey_etcurrent in (1,2) & lacey_etfreq in (1,2,3) then lacey_etfreq_c=lacey_etfreq;
	else lacey_etfreq_c=-9;
	lacey_etfreq_me = lacey_etfreq_c;
	if lacey_etfreq_c=-9						then lacey_etfreq_me=.;

	** finished HRT variables;
	*******************************************************************************************;
run;
** below, generates tables;

ods _all_ close; ods html;
proc freq data=use;
	title;
	tables	
		educ_c*educm 
		educ_c*melanoma_c / missing nocol norow nopercent;
run;
proc means data=use missing;
	class bmi_c;
	var bmi_cur;
run;
proc freq data=use;
	tables
		bmi_c*melanoma_c
		physic_c*physic
		physic_c*melanoma_c
		fmenstr_c*melanoma_c / missing nocol norow nopercent;
run;
proc freq data=use;
	title1 'perstop_menop: periods stop due to natural menopause?';
	title2 'perstop_surg: periods stop due to surgery?';
	title3 'hystat: hyterectomy status';
	title4 'ovarystat: ovary status';
	tables
		menostat_c*perstop_menop*perstop_surg*hyststat*ovarystat / missing list nopercent nocum;
	where melanoma_c=0;
run;
proc freq data=use;
	title;
	tables
		menostat_c*melanoma_c
		ovarystat_c*menostat_c
		ovarystat_c*ovarystat
		ovarystat_c*melanoma_c
		menopi_age*menop_age
		menopi_age*melanoma_c
		parity*parity_ever
		parity*livechild
		parity*melanoma_c
		flb_age_c*age_flb
		flb_age_c*melanoma_c
		oralbc_yn_c*oralbc_yrs
		oralbc_yn_c*melanoma_c
		oralbc_dur_c*melanoma_c
		mht_ever*hormstat
		mht_ever*melanoma_c
		horm_ever*melanoma_c
		horm_yrs_c*melanoma_c / missing nocol norow nopercent;
run;
proc means data=use missing;
	title 'based on current study population';
	class uvrq;
	var exposure_jul_78_05;
run;
proc freq data=use;
	title;
	tables
		uvrq*melanoma_c
		marriage_c*marriage
		marriage_c*melanoma_c
		smoke_dose_c*melanoma_c
		smoke_quit_c*melanoma_c / missing nocol norow nopercent;
run;
proc means data=use missing;
	class etoh_c;
	var mped_a_bev;
run;
proc freq data=use;
	tables
		etoh_c*melanoma_c
		rel_1d_cancer_c*melanoma_c/ missing nocol norow nopercent;
run;

ods _all_ close; ods html;
proc freq data=use_r;
	title;
	tables	
		rf_physic_c*rf_phys_modvig_curr
		rf_physic_c*melanoma_c
		ht_type_nat*menostat_c
		ht_type_nat*lacey_ht_type
		ht_type_nat*melanoma_c
		ht_type_surg*menostat_c
		ht_type_surg*lacey_ht_type 
		ht_type_surg*melanoma_c / missing nocol norow nopercent;
run;
proc freq data=use_r;
	title1 "Q15E: No colorectal procedure in past three years?";
	tables
		any_screen*rf_Q15E*rf_Q15A*rf_Q15B*rf_Q15C*rf_Q15D / missing nocol norow nopercent list;
run;
proc freq data=use_r;
	title;
	tables
		any_screen*rf_Q15E
		any_screen*melanoma_c
		lacey_eptcurrent_ever*lacey_eptcurrent
		lacey_eptcurrent_ever*melanoma_c
		lacey_eptdose_c*lacey_eptdose
		lacey_eptdose_c*melanoma_c
		lacey_eptdur_c*lacey_eptdur
		lacey_eptdur_c*melanoma_c
		lacey_etcurrent_ever*lacey_etcurrent
		lacey_etcurrent_ever*melanoma_c
		lacey_etdose_c*lacey_etdose
		lacey_etdose_c*melanoma_c
		lacey_etdur_c*lacey_etdur
		lacey_etdur_c*melanoma_c
		lacey_etfreq_c*lacey_etfreq 
		lacey_etfreq_c*melanoma_c / missing nocol norow nopercent;
run;

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
# Updated: v20150819WED WTL
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

	****  Create exit date, exit age, and person years for First Primary Cancer;
	** with first primary cancer as skin cancer;
	** Chooses the earliest of 4 possible exit dates for skin cancer;
  	exit_dt = min(mdy(12,31,2006), skin_dxdt, dod, raadate); 
  	exit_age = round(((exit_dt-f_dob)/365.25),.001);
  	personyrs = round(((exit_dt-entry_dt)/365.25),.001);

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

/* for baseline */
	** UVR TOMS quantiles;
	UVRQ=.;
	if      0       < exposure_jul_78_05 <= 186.918 then UVRQ=1;
	else if 186.918 < exposure_jul_78_05 <= 239.642 then UVRQ=2;
	else if 239.642 < exposure_jul_78_05 <= 253.731 then UVRQ=3;
	else if 253.731 < exposure_jul_78_05            then UVRQ=4;
	else UVRQ=-9;

	** birth cohort date of birth quintile;
	birth_cohort=.;
	if      1925 <= dob_year < 1929  	then birth_cohort=1;
	else if 1929 <= dob_year < 1933  	then birth_cohort=2;
	else if 1933 <= dob_year < 1935  	then birth_cohort=3;
	else if 1935 <= dob_year < 1939  	then birth_cohort=4;
	else if 1939 <= dob_year         	then birth_cohort=5;

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

** menopause status recoded;
	** use the perstop_surg (hyststat and ovarystat) and perstop_radchem;
	menostat_c=.;
	if 		perstop_surg=1 | hyststat=1 | ovarystat=1				then menostat_c=2; /* surgical/hyst menopause */
	else if perstop_menop=1											then menostat_c=1; /* natural menopause */
	else if perstop_nostop=0 | perstop_menop=0 | perstop_surg=0		then menostat_c=.; /* missing */
	else 	menostat_c=-9;

	** menopausal age recoded;
	if 		menop_age in (6,9)						then menop_age=9; /* missing */
	else if menop_age in (1,2)						then menop_age=1; /* <45 */
	else if menop_age=3								then menop_age=2; /* 45-49 */
	else if menop_age=4								then menop_age=3; /* 50-54 */
	else if menop_age=5								then menop_age=4; /* 55+ */
	menop_age_me = menop_age;
	if 		menop_age_me=9							then menop_age_me=.; /* missing for main effect */

	** menopausal age recoded with merged higher age groups;
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

	** bmi five categories;
	if      18.5<=bmi_cur<25 				then bmi_fc=1; /* normal bmi */
   	else if 25<=bmi_cur<30 					then bmi_fc=2; /* overweight bmi */
   	else if 30<=bmi_cur<35 					then bmi_fc=3; /* obese bmi */
	else if 35<=bmi_cur<40 					then bmi_fc=4; /* morbid obesity bmi */
   	else if bmi_cur>=40 					then bmi_fc=5; /* highest valid bmi */
	else 	bmi_fc=-9;

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

data conv.melan;
	set conv.melan (where = (menostat_c NE . ));

	** recode parity and flb_age_c to consolidate contradicting missings in each;
	** if nulliparous or missing number of births, then age at birth should be missing;
	if parity in (0,-9)						then flb_age_c=9;
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
	if rf_Q15A=1 		then colo_sig_any=1;
	if rf_Q15B=1		then colo_sig_any=1;
	if rf_Q15C=1		then colo_sig_any=1;
	if rf_Q15D=1		then colo_sig_any=1;
	if rf_Q15E=1		then colo_sig_any=0;

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
	if lacey_eptcurrent in (0,1,2) & lacey_eptdose in (0,1,2,3,4,5) then lacey_eptdose_c=lacey_eptdose;
	else lacey_eptdose_c=-9;
	lacey_eptdose_me = lacey_eptdose_c;
	if lacey_eptdose_c=-9						then lacey_eptdose_me=.;

	** EPT duration ***************;
	lacey_eptdur_c = .;
	if lacey_eptcurrent in (0,1,2) & lacey_eptdur in (0,1,2,3,9) then lacey_eptdur_c=lacey_eptdur;
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
	if lacey_etcurrent in (0,1,2) & lacey_etdose in (0,1,2,3) then lacey_etdose_c=lacey_etdose;
	else lacey_etdose_c=-9;
	lacey_etdose_me = lacey_etdose_c;
	if lacey_etdose_c=-9						then lacey_etdose_me=.;

	** ET duration ***************;
	lacey_etdur_c=.;
	if lacey_etcurrent in (0,1,2) & lacey_etdur in (0,1,2,9) then lacey_etdur_c=lacey_etdur;
	else lacey_etdur_c=-9;
	lacey_etdur_me = lacey_etdur_c;
	if lacey_etdur_c=-9						then lacey_etdur_me=.;

	** ET freq ***************;
	lacey_etfreq_c=.;
	if lacey_etcurrent in (0,1,2) & lacey_etfreq in (0,1,2,3) then lacey_etfreq_c=lacey_etfreq;
	else lacey_etfreq_c=-9;
	lacey_etfreq_me = lacey_etfreq_c;
	if lacey_etfreq_c=-9						then lacey_etfreq_me=.;

	** finished HRT variables;
	*******************************************************************************************;

** below, generates tables;

ods _all_ close; ods html;
proc freq data=use;
	title;
	tables	
		educ_c*educm / missing nocol norow nopercent;
run;
proc means data=use missing;
	class bmi_c;
	var bmi_cur;
run;
proc freq data=use;
	tables
		physic_c*physic
		fmenstr_c*fmenstr / missing nocol norow nopercent;
run;
proc freq data=use;
	title1 'perstop_menop: periods stop due to natural menopause?';
	title2 'perstop_surg: periods stop due to surgery?';
	title3 'hystat: hyterectomy status';
	title4 'ovarystat: ovary status';
	tables
		menostat_c*perstop_menop*perstop_surg*hyststat*ovarystat / missing list;
run;
proc freq data=use;
	title;
	tables
		ovarystat_c*ovarystat
		menopi_age*menop_age
		parity*livechild
		flb_age_c*age_flb
		oralbc_yn_c*oralbc_yrs
		oralbc_dur_c*oralbc_yrs
		mht_ever*hormstat
		horm_ever*hormstat
		horm_yrs_c*horm_yrs / missing nocol norow nopercent;
run;
proc means data=use missing;
	class uvrq;
	var exposure_jul_78_05;
run;
proc freq data=use;
	tables
		marriage_c*marriage
		smoke_dose_c*smoke_dose
		smoke_quit_c*smoke_quit / missing nocol norow nopercent;
run;
proc means data=use missing;
	class etoh_c;
	var mped_a_bev;
run;
proc freq data=use;
	tables
		rel_1d_cancer_c*rel_1d_cancer / missing nocol norow nopercent;
run;

proc freq data=use_r;
	title;
	tables	
		rf_physic_c*rf_phys_modvig_curr
		ht_type_nat*lacey_ht_type
		ht_type_surg*lacey_ht_type / missing nocol norow nopercent;
run;
proc freq data=use_r;
	title1 "Q15A: Sigmoidoscopy in past three years?";
	title2 "Q15B: Colonoscopy in past three years?";
	title3 "Q15C: Proctoscopy in past three years?";
	title4 "Q15D: Unknown colorectal procedure in past three years?";
	title5 "Q15E: No colorectal procedure in past three years?";
	tables
		colo_sig_any*rf_Q15A*rf_Q15B*rf_Q15C*rf_Q15D*rf_Q15E / missing list;
run;
proc freq data=use_r;
	title;
	tables
		lacey_eptcurrent_ever*lacey_eptcurrent
		lacey_eptdose_c*lacey_eptdose
		lacey_eptdur_c*lacey_eptdur
		lacey_etcurrent_ever*lacey_etcurrent
		lacey_etdose_c*lacey_etdose
		lacey_etdur_c*lacey_etdur
		lacey_etfreq_c*lacey_etfreq / missing nocol norow nopercent;
run;

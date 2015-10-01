**************************;
***** Start2 here ********;
**************************;
** uses the pre-created analysis_use from above checkpoint;
data melan_r; ** name the output of the first primary analysis include to melan_r;
	set conv.ranalysis;
	****** Define melanoma - pulled from allcancer-coffee analysis ******; 
	** create the melanoma case variable from the cancer ICD-O-3 and SEER coding of 25010;
	** contains both melanoma subtypes;
	melanoma_c = .;
	* in situ melanoma =1;
    if cancer_behv='2' and cancer_seergroup = 18 and cancer_siterec3=25010 
		then melanoma_c = 1;
	* malignant melanoma =2;
	else if cancer_behv='3' and cancer_seergroup = 18 and cancer_siterec3=25010 
		then melanoma_c = 2;  
	else melanoma_c = 0;
	
	** create melanoma indicator Y/N;
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

*******************************************************;
/* Check for exclusions from Loftfield Coffee paper;
** total of n=566398;
proc copy noclone in=Work out=conv;
	select analysis;
run;
*/
*******************************************************;

ods html close;
ods html;

** merge the melan_r dataset with the UV data;
data melan_r;
	merge melan_r (in=frodo) conv.uv_pub1 ;
	by westatid;
	if frodo;
run;

** copy and save the melan dataset to the converted folder;
proc copy noclone in=Work out=conv;
	select melan_r;
run;

**** Exclusions risk macro;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\anchovy\exclusions.first.primary.risk.macro.sas';

**** Outbox macro for use with outliers;
*%include 'C:\REB\AARP_HRTandMelanoma\Analysis\anchovy\outbox.macro.sas';

**** Use the exclusion macro to make "standard" exclusions and get counts of excluded subjects;

%exclude(data            	= conv.melan_r,
         ex_proxy        	= 1,
		 ex_rf_proxy	 	= 1,
         ex_sex          	= 0,
         ex_rf_selfbreast   = 1,
		 ex_rf_selfovary	= 1,
         ex_selfother    	= 1,
         ex_health       	= ,
         ex_prevcan      	= 1,
         ex_deathcan     	= 1);

/***************************************************************************************/ 
/*   Exclude if non-whites, racem = 1
**	 Edit: 20150901TUE WTL;
/*	 excl_1_nonwhite 																   
/*   Extract year from DOB 			                                                   
/***************************************************************************************/ 
data conv.melan_r;
	title 'Ex 1. exclude non whites, excl_1_nonwhite';
	set conv.melan_r;
	dob_year = YEAR(F_DOB);
	excl_1_nonwhite=0;
	if racem NE 1 then excl_1_nonwhite=1;
run;
proc freq data=conv.melan_r;
	tables excl_1_nonwhite 
			excl_1_nonwhite*melanoma_c /missing;
run;

/***************************************************************************************/ 
/*   Exclude if pre-menopausal, perstop_nostop = 1 
/*	 Exclusions Edit: 20150901TUE WTL
/*   excl_2_premeno
/*   should account for menop_age = 6 as well? Yes, use OR - Lisa
/***************************************************************************************/ 
data conv.melan_r;
	title 'Ex 2. exclude premenopausal women, excl_2_premeno';
	set conv.melan_r;
	excl_2_premeno=0;
	if perstop_nostop=1 | menop_age=6 then excl_2_premeno=1;
	where excl_1_nonwhite=0;
run;
proc freq data=conv.melan_r;
	tables excl_1_nonwhite*excl_2_premeno 
			excl_2_premeno*melanoma_c /missing;
run;

	** need to change the exposure percentiles after exclusions;
	** uvr exposure;
	** p10     p20     p25     p30     p40     p50     p60     p70     p75     p80     p90 ;
	** 185.266 186.255 186.255 192.716 215.622 239.642 245.151 250.621 253.731 257.14  267.431 ;
	** birth cohort;
	** p10     p20     p25     p30     p40     p50     p60     p70     p75     p80     p90 ;
	** -11897  -11330  -11040  -10760  -10194  -9583   -8920   -8203   -7834   -7431   -6408;
	** year of birth;
	** p10     p20     p25     p30     p40     p50     p60     p70     p75     p80     p90 ;
	** 1927	   1928    1929    1930    1932    1933    1935    1937    1938    1939    1942;

/***************************************************************************************/ 
/*   Exclude if self-reported periods stopped due to radchem                           */ 
**	 exclude: excl_3_radchem;
**   edit: 20150929TUE WTL;
/***************************************************************************************/ 
data conv.melan_r excl_radchem;
	title 'Ex 3. exclude women whose periods stopped due to rad/chem, excl_3_radchem';
	set conv.melan_r;
	excl_3_radchem=0;
	if perstop_radchem=1 then excl_3_radchem=1;
	where excl_2_premeno=0;
run;
proc freq data=conv.melan_r;
	tables excl_2_premeno*excl_3_radchem 
			excl_3_radchem*melanoma_c /missing;
run;

/******************************************************************************************/
** creates the new imputed postmenopausal variable;
** excl_4_npostmeno;
** edit 20150901TUE WTL;
/******************************************************************************************/
data conv.melan_r;
	title;
	set conv.melan_r;
	** new postmenopause status recoded;
	** is postmenopausal: 1,2,;
	** is not postmenopausal: 99;
	** edit 20150929TUE WTL;
	postmeno=.;
	if  	(perstop_menop=1 | perstop_surg=1)    						/* reported periods stopped due to nat or surg or */
			| (ovarystat=1 | hyststat=1)								then postmeno=1; /* surgery */

	else if entry_age>=60												then postmeno=2; /* 60 or older considered postmeno */  	
 
	else postmeno=99;
run;
/***************************************************************************************/ 
/*   Exclude non-postmenopausal from above postmeno variable                           */ 
**   edit 20150901TUE WTL;
/***************************************************************************************/ 
data conv.melan_r;
	title 'Ex 4. exclude those not post-menopausal, excl_4_npostmeno';
	set conv.melan_r;
	excl_4_npostmeno=0;
	if postmeno=99 then excl_4_npostmeno=1;
	where excl_3_radchem=0;
run;
proc freq data=conv.melan_r;
	tables excl_3_radchem*excl_4_npostmeno 
			excl_4_npostmeno*melanoma_c /missing;
run;
proc freq data=conv.melan_r;
	tables postmeno*melanoma_c /missing;
run;

/******************************************************************************************/
** create the UVR, and confounder variables by quintile/categories;
** for both baseline and riskfactor questionnaire variables;
/* cat=categorical ************************************************************************/
data conv.melan_r;
	set conv.melan_r;

/* for baseline */

	** UVR TOMS quintile;
	UVRQ=.;
	if      0       < exposure_jul_78_05 <= 186.255 then UVRQ=1;
	else if 186.255 < exposure_jul_78_05 <= 239.642 then UVRQ=2;
	else if 239.642 < exposure_jul_78_05 <= 253.731 then UVRQ=3;
	else if 253.731 < exposure_jul_78_05 			then UVRQ=4;
	else UVRQ=-9;

	** physical exercise cat;
	physic_c=.;
	if      physic in (0,1)	then physic_c=0; /* rarely */
	else if physic=2 	 	then physic_c=1; /* 1-3 per month */
	else if physic=3 	 	then physic_c=2; /* 1-2 per week */
	else if physic=4     	then physic_c=3; /* 3-4 per week */
	else if physic=5     	then physic_c=4; /* 5+ per week */
	else if physic=9	 	then physic_c=-9; /* missing */

	** physical exercise ages 15..18 cat;
	physic_1518_c=.;
	if      physic_1518 in (0,1)	then physic_1518_c=0; /* rarely */
	else if physic_1518=2	 	 	then physic_1518_c=1; /* 1-3 per month */
	else if physic_1518=3 		 	then physic_1518_c=2; /* 1-2 per week */
	else if physic_1518=4   	  	then physic_1518_c=3; /* 3-4 per week */
	else if physic_1518=5	     	then physic_1518_c=4; /* 5+ per week */
	else if physic_1518=9		 	then physic_1518_c=-9; /* missing */

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
	if      fmenstr=1	then fmenstr_c=0; /* <=10 years old */
	else if fmenstr=2	then fmenstr_c=1; /* 11-12 years old */
	else if fmenstr=3	then fmenstr_c=2; /* 13-14 years old */
	else if fmenstr=4	then fmenstr_c=3; /* 15+ years old */
	else if fmenstr>4	then fmenstr_c=-9; /* missing */
	fmenstr=fmenstr_c;

	** education cat;
	educ_c=.;
	if 		educm=1 		then educ_c=0; /* less highschool */
	else if educm=2			then educ_c=1; /* highschool grad*/
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

*******************************************************************************************;
/** recode menopause status to include hysterectomy and oophorectomy **/
*******************************************************************************************;
	/** menopause status recoded;
	** use the perstop_surgery (hyststat and ovarystat) and perstop_radchem;

	menostat_c=.;
	if 		perstop_nostop=1								then menostat_c=0; * premenopausal ;
	else if perstop_menop=1									then menostat_c=1; * natural menopause ;
	else if perstop_surg=1 & (hyststat=1 & ovarystat=1)		then menostat_c=2; * hysterectomy, removed 2 ovaries ;
	else if perstop_surg=1 & (hyststat=1 & ovarystat=3) 	then menostat_c=3; * hysterectomy, surgery to ovaries ;
	else if perstop_surg=1 & (hyststat=1 & ovarystat=2) 	then menostat_c=4; * hysterectomy, ovaries intact ;
	else if perstop_surg=1 & (hyststat=1 & ovarystat=9) 	then menostat_c=5; * hysterectomy, ovaries unknown ;
	else if perstop_radchem=1								then menostat_c=6; * radiation or chemotherapy ;
	else if perstop_menop=0 & perstop_surg=0 & perstop_radchem=0
															then menostat_c=7; * other reason ;
	else if perstop_nostop=9 | perstop_menop=9				then menostat_c=-9; * missing ;
	else 	menostat_c=-9;
	*/

	** menopause reason, 20150901 edit;
	** 1 natural, 2 surgical;
	menostat_c=.;
	if		perstop_surg=1 | hyststat=1 | ovarystat=1		then menostat_c=2; /* surgical */
	else if	perstop_menop=1									then menostat_c=1; /* natural */

	** natural menopause reason age, 20150702THU edit; 
	meno_age_c=.;
	if 		menostat_c=1 & menop_age in (1,2,3)		then meno_age_c=1; /* <50 */
	else if menostat_c=1 & menop_age=4			   	then meno_age_c=2; /* 50-54 */
	else if menostat_c=1 & menop_age=5				then meno_age_c=3; /* 55+ */
	else if menostat_c=1 & menop_age in (8,9)		then meno_age_c=-9; /* missing */
	else if menostat_c NE 1							then meno_age_c=.;
	else 	meno_age_c=-9;

	** surgery reason age, 20150729WED edit;
	surg_age_c=.;
	if 		menostat_c=2 & menop_age in (1,2)		then surg_age_c=1; /* <45 */
	else if menostat_c=2 & menop_age=3				then surg_age_c=2; /* 45-49 */
	else if menostat_c=2 & menop_age in (5,6)		then surg_age_c=3; /* 50+ */
	else if menostat_c=2 & menop_age in (8,9)		then surg_age_c=-9; /* missing */
	else if menostat_c NE 2							then surg_age_c=.;
	else	surg_age_c=-9;

	** menopausal age recoded;
	** edit 20150729WED WTL;
	if 		menop_age in (6,9)						then menop_age=9; /* missing */
	else if menop_age in (1,2)						then menop_age=1; /* <44 */
	else if menop_age=3								then menop_age=2; /* 45-49 */
	else if menop_age=4								then menop_age=3; /* 50-54 */
	else if menop_age=5								then menop_age=4; /* 55+ */
	menop_age_me = menop_age;
	if 		menop_age_me=9							then menop_age_me=.; /* missing for main effect */

	** menopausal age recoded with merged higher age groups;
	** edit 20150817MON WTL;
	menopi_age = menop_age;
	if menopi_age = 4								then menopi_age=3; /* 50<= */
	menopi_age_me = menopi_age;
	if menopi_age_me = 9							then menopi_age_me=.; /* missing for main effect */

	** ovary status, 20150708WED edit;
	ovarystat_c=.;
	if 		ovarystat=1 & menostat_c=2				then ovarystat_c=1; /* both removed */
	else if ovarystat=2 & menostat_c=2				then ovarystat_c=2; /* both intact */
	else if ovarystat in (3,9) & menostat_c=2		then ovarystat_c=-9; /* invalids are missing */

	** former smoker status cat;
	smoke_f_c=.;
	if      bf_smoke_former=0	then smoke_f_c=0; /* never smoke */
	else if bf_smoke_former=1	then smoke_f_c=1; /* former smoker (ever)*/
	else if bf_smoke_former=2	then smoke_f_c=1; /* current smoker? (ever)*/
	else if bf_smoke_former=9	then smoke_f_c=-9; /* missing */
	else smoke_f_c=-9;

	** hormonal status cat, 20150708WED edit;
	*** natural meno;
	horm_nat_c=.;
	if      hormstat=0 & menostat_c=1		then horm_nat_c=0; /* never hormones */
	else if hormstat=1 & menostat_c=1		then horm_nat_c=1; /* former */
	else if hormstat=2 & menostat_c=1		then horm_nat_c=2; /* current */
	else if menostat_c NE 1					then horm_nat_c=.;
	else 	horm_nat_c=-9; 									   /* missing */
	
	*** natural meno, ever horm;
	horm_nat_ever_c=horm_nat_c;
	if horm_nat_c=2							then horm_nat_ever_c=1; /* yes hormones */

	*** surgical/hyst meno;
	horm_surg_c=.;
	if      hormstat=0 & menostat_c=2		then horm_surg_c=0; /* never hormones */
	else if hormstat=1 & menostat_c=2		then horm_surg_c=1; /* former */
	else if hormstat=2 & menostat_c=2		then horm_surg_c=2; /* current */
	else if menostat_c NE 2					then horm_surg_c=.;
	else 	horm_surg_c=-9; 									/* missing */

	*** surgical/hyst meno, ever horm;
	horm_surg_ever_c=horm_surg_c;
	if horm_surg_c=2						then horm_surg_ever_c=1; /* yes hormones */

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
	if livechild=0					then parity=0; /* no live children (nulliparous) */
	else if livechild in (1,2) 		then parity=1; /* 1 to 2 live children */
	else if livechild in (3,4,5)	then parity=2; /* >=3 live children */
	else if livechild in (8,9)		then parity=-9; /* missing */

	parity_ever=parity;
	if parity_ever in (1,2)					then parity_ever=1;

	** cancer grade cat;
	cancer_g_c=.;
	if 	    cancer_grade=1		then cancer_g_c=0; 
	else if cancer_grade=2		then cancer_g_c=1;
	else if cancer_grade=3		then cancer_g_c=2;
	else if cancer_grade=4		then cancer_g_c=3;
	else if cancer_grade=9		then cancer_g_c=-9; /* missing */

	*******************************************************************************************;
	** bmi categories *************************************************************************;
	*******************************************************************************************;
	** bmi_c new categories;
	** use this new one, (like Sara), edit 20150825TUE WTL;
	if      18.5<bmi_cur<25 				then bmi_c=1; /* 18.5 up to 25 */
   	else if 25<=bmi_cur<30 					then bmi_c=2; /* 25 up to 30 */
   	else if 30<=bmi_cur<60 					then bmi_c=3; /* 30 up to 60 */
	else 										 bmi_c=-9; /* missing or extreme */

	** continuous bmi;
	bmi_cont=bmi_cur/5;
	* finish bmi;
	***************************************************************************;

	** first primary cancer stage;
	stage_c=.;
	if      cancer_ss_stg=0 				then stage_c=0;
	else if cancer_ss_stg=1 				then stage_c=1;
	else if cancer_ss_stg in (2,3,4,5)		then stage_c=2;
	else if cancer_ss_stg=7					then stage_c=3;
	else if cancer_ss_stg in (8,9)			then stage_c=4;
	else if cancer_ss_stg=. 				then stage_c=-9;	

	** total alcohol per day;
	etoh_c=.;
	if 		mped_a_bev=0			then etoh_c=0;		/* none */
	else if 0<mped_a_bev<=1			then etoh_c=1;		/* <=1 */
	else if 1<mped_a_bev<=3 		then etoh_c=2;		/* >1 and =<3 */
	else if 3<mped_a_bev			then etoh_c=3;		/* >3 */
	else 	etoh_c=-9;									/* missing */

/* for riskfactor */

	** risk physical exercise ages 15..18 cat;
	rphysic_1518_c=.;
	if      rf_phys_modvig_15_18 in (0,1)	then rf_physic_1518_c=0; /* rarely */
	else if rf_phys_modvig_15_18=2 	 		then rf_physic_1518_c=1; /* <1 hour/week */
	else if rf_phys_modvig_15_18=3 	 		then rf_physic_1518_c=2; /* 1-3 hours/week */
	else if rf_phys_modvig_15_18=4     		then rf_physic_1518_c=3; /* 4-7 hours/week */
	else if rf_phys_modvig_15_18=5     		then rf_physic_1518_c=4; /* >7 hours/week */
	else if rf_phys_modvig_15_18=9	 		then rf_physic_1518_c=-9; /* missing */
	else rphysic_1518=-9;

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

	** total;
	total=1;

	** smoking recode;
	if smoke_former=9 			then smoke_former=-9;
	if smoke_quit=9 			then smoke_quit=-9;
	if smoke_dose=9				then smoke_dose=-9;
	if smoke_quit_dose=9		then smoke_quit_dose=-9;

	** attained age cat;
	if 		50<=exit_age<55			then attained_age=0;  
	else if 55<=exit_age<60			then attained_age=1;
	else if 60<=exit_age<65			then attained_age=2;
	else if 65<=exit_age<70			then attained_age=3;
	else if 70<=exit_age			then attained_age=4;
	else 	attained_age=-9;								/* missing */

	** marriage;
	marriage_c=marriage;
	if marriage in (3,4)					then marriage_c=3;

	** hormone duration;
	horm_yrs_c = horm_yrs;
	if		horm_yrs in (8,9)				then horm_yrs_c=-9;

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

	any_screen=colo_sig_any;
	if rf_Q15E = "0"	then rf_Q15E=0;
	if rf_Q15E = "1"	then rf_Q15E=1;

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
	if lacey_etcurrent in (1,2) & lacey_etdose in (1,2) then lacey_etdose_c=lacey_etdose;
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
	if lacey_etcurrent in (1,2) & lacey_etfreq in (1,2) then lacey_etfreq_c=lacey_etfreq;
	else lacey_etfreq_c=-9;
	lacey_etfreq_me = lacey_etfreq_c;
	if lacey_etfreq_c=-9						then lacey_etfreq_me=.;

	** finished HRT variables;
	*******************************************************************************************;run;

/***************************************************************************************/ 
/*   Exclude if person-years <= 0                                                      */
**   exclude: excl_5_pyzero;
**   edit: 20150901TUE WTL;
/***************************************************************************************/      
data conv.melan_r;
	title 'Ex 5. exclude women with zero or less person years, excl_5_pyzero';
	set conv.melan_r;
    excl_5_pyzero=0;
   	if personyrs <= 0 then excl_5_pyzero=1;
   	where excl_4_npostmeno=0;
run;
proc freq data=conv.melan_r;
	tables excl_4_npostmeno*excl_5_pyzero 
			excl_5_pyzero*melanoma_c /missing;
run; 
data conv.melan_r;
	title;
	set conv.melan_r;
	where excl_5_pyzero=0;
run;

data conv.melan_r;
	set conv.melan_r;
	** recode parity and flb_age_c to consolidate contradicting missings in each;
	** if nulliparous or missing number of births, then age at birth should be missing;
	*** -9 in flb_age means missing to begin with;
	*** whereas 9 in flb_age means they were coerced to be missing due to missing parity;
	if		parity in (1,2) & flb_age_c=9	then flb_age_c=-9; 
	else if parity=2 & flb_age_c=9			then flb_age_c=-9;
	if 		parity in (0,-9)					then flb_age_c=9;
run;

ods html close;
ods html;

/* recode the variables for main effect */
/* such that missings (9, -9) are coded as missing (.), so they are not counted */
data conv.melan_r;
	set conv.melan_r;

	agecat_me = agecat;
	if	agecat_me in (9,-9)				then agecat_me=.;
	attained_age_me = attained_age;
	if	attained_age_me in (9,-9)		then attained_age_me=.;
	birth_cohort_me = birth_cohort;
	if	birth_cohort_me in (9,-9)		then birth_cohort_me=.;
	race_c_me = race_c;
	if	race_c_me in (9,-9)				then race_c_me=.;
	educ_c_me = educ_c;
	if	educ_c_me in (9,-9)				then educ_c_me=.;
	bmi_c_me = bmi_c;
	if	bmi_c_me in (9,-9)				then bmi_c_me=.;
	physic_c_me = physic_c;
	if	physic_c_me  in (9,-9)			then physic_c_me=.;

	fmenstr_me = fmenstr;
	if	fmenstr_me in (9,-9)			then fmenstr_me=.;
	menostat_c_me = menostat_c;
	if	menostat_c_me in (9,-9) 		then menostat_c_me=.;
	meno_age_c_me = meno_age_c;
	if	meno_age_c_me in (9,-9)			then meno_age_c_me=.;
	surg_age_c_me = surg_age_c;
	if	surg_age_c_me in (9,-9)			then surg_age_c_me=.;
	parity_me=parity;
	if	parity_me in (9,-9)				then parity_me=.;
	flb_age_c_me = flb_age_c;
	if	flb_age_c_me  in (9,-9)			then flb_age_c_me=.;
	oralbc_dur_c_me = oralbc_dur_c;
	if	oralbc_dur_c_me in (9,-9)		then oralbc_dur_c_me=.;
	oralbc_yn_c_me = oralbc_yn_c;
	if oralbc_yn_c_me in (9,-9)			then oralbc_yn_c_me=.;
	horm_nat_c_me = horm_nat_c;
	if	horm_nat_c_me  in (9,-9)		then horm_nat_c_me=.;
	horm_nat_ever_me = horm_nat_ever_c;
	if horm_nat_ever_me in (9,-9)		then horm_nat_ever_me=.;
	horm_surg_c_me = horm_surg_c;
	if	horm_surg_c_me in (9,-9)		then horm_surg_c_me=.;
	horm_surg_ever_me = horm_surg_ever_c;
	if horm_surg_ever_me in (9,-9)	then horm_surg_ever_me=.;

	uvrq_me = uvrq;
	if	uvrq_me in (9,-9)				then uvrq_me=.;
	smoke_former_me = smoke_former;
	if	smoke_former_me  in (9,-9)		then smoke_former_me=.;
	coffee_c_me = coffee_c;
	if	coffee_c_me in (9,-9) 			then coffee_c_me=.;
	etoh_c_me = etoh_c;
	if	etoh_c_me in (9,-9)				then etoh_c_me=.;
	rel_1d_cancer_me = rel_1d_cancer;
	if	rel_1d_cancer_me in (9,-9)		then rel_1d_cancer_me=.;

	horm_cur_me = horm_cur;
	if	horm_cur_me in (9,-9)			then horm_cur_me=.;
	horm_yrs_me = horm_yrs;
	if	horm_yrs_me in (9,-9)			then horm_yrs_me=.;
	horm_yrs_nat_me = horm_yrs_nat_c;
	if horm_yrs_nat_me in (9,-9)		then horm_yrs_nat_me=.;
	horm_yrs_surg_me = horm_yrs_surg_c;
	if horm_yrs_surg_me in (9,-9)		then horm_yrs_surg_me=.;

	ht_type_nat_me = ht_type_nat;
	if ht_type_nat_me in (9, -9)		then ht_type_nat_me=.;
	ht_type_nat_ever_me = ht_type_nat_ever;
	if ht_type_nat_ever_me in (9,-9)	then ht_type_nat_ever_me=.;
	ht_type_surg_me = ht_type_surg;
	if ht_type_surg_me in (9, -9)		then ht_type_surg_me=.;
	ht_type_surg_ever_me=ht_type_surg_ever;
	if ht_type_surg_ever_me in (9,-9)	then ht_type_surg_ever_me=.;

	ovarystat_c_me = ovarystat_c;
	if ovarystat_c_me in (9,-9)			then ovarystat_c_me=.;
run;

** add labels;
proc datasets library=conv;
	modify melan_r;
	
	** set variable labels;
	label 	/* melanoma outcomes */
			melanoma_agg = "Melanoma indicator"
			melanoma_c = "Melanoma indicator by type"
			melanoma_ins = "Melanoma in situ"
			melanoma_mal = "malignant Melanoma"

			/* for baseline */
			birth_cohort = "Year of birth quantiles"
			uvrq = "TOMS AVGLO-UVR measures in quartiles"
			oralbc_dur_c = "birth control duration"
			oralbc_yn_c = "birth control yes/no"
			fmenstr = "menarche age"
			educ_c = "education level"
			race_c = "race split into 3"
			attained_age = "Attained Age"
			flb_age_c = "Age at first live birth among parous women"
			fmenstr = "Age at menarche"
			menostat_c = "menopause status"
			meno_age_c ="age at natural menopause"
			menostat_c ="menopause status"
			physic_c = "level of physical activity"	
			horm_nat_c = "hormone usage, natural menopause"
			horm_surg_c = "hormone usage, surgical menopause"
			parity = "total number of live births"
			cancer_g_c = "cancer grade"
			bmi_c = "bmi, rough"
			stage_c = "stage of first primary cancer"
			physic_1518_c = "level of physical activity at ages 15-18 (base)"

			smoke_former ="Smoking Status"
			smoke_quit = 'Quit smoking status'
			smoke_dose = 'Smoking dose'
			smoke_quit_dose = 'Smoking status and dose combined'
			rel_1d_cancer = 'Family History of Cancer'
			coffee_c = 'Coffee drinking'
			etoh_c = 'Total alchohol per day including food sources'
			colo_sig_any = "Colonoscopy or Sigmoidoscopy in past 3 years?"
			any_screen = "Colonoscopy or Sigmoidoscopy in past 3 years?"

			horm_cur = 'Current Hormone Use'
			horm_yrs = 'Hormone Use Duration'
			horm_yrs_nat_c = 'Hormone Use Duration, only nat meno'
			horm_yrs_surg_c = 'Hormone Use Duration, only surg meno'
			mht_ever = " Menopausal Hormone Therapy, ever"


			/* for riskfactor */
			rf_physic_1518_c = "level of physical activity at ages 15-18 (rf)"
			rf_physic_c = "Times engaged in moderate-vigorous physical activity"
			rf_1d_cancer = "Family History of Cancer"
			rf_Q15A = "Sigmoidoscopy in past three years?"
			rf_Q15B = "Colonoscopy in past three years?"
			rf_Q15C = "Proctoscopy in past three years?"
			rf_Q15D = "Unknown colorectal procedure in past three years?"
			rf_Q15E = "No colorectal procedure in past three years?"

				/* for the MHT variables */
			lacey_afterrfq = "ET therapy started before or after RFQ?"
			lacey_eptcurdur = "Estrogen/progestin therapy duration combined with current/former use (1st definition)"
			lacey_eptcurdur2 = "Estrogen/progestin therapy duration combined with current/former use (2nd definition)"
			lacey_eptcurrent = "Current/former EPT user"
			lacey_eptdose = "Estrogen/progestin therapy dose"
			lacey_eptdur = "Estrogen/progestin therapy duration (1st definition)"
			lacey_eptreg = "EPT regimen"
			lacey_eptregdose = "Dose of EPT by regimen (1st definition)"
			lacey_eptregyrs = "Duration of EPT use by regimen (1st definition)"
			lacey_epttype = "Estrogen/progestin therapy type"
			lacey_est_vs_prg = "Estrogen vs progestin duration"
			lacey_et_ept_et = "Estrogen therapy followed by estrogen/progestin therapy followed by more estrogen therapy?"

			lacey_etcurdur = "Estrogen therapy duration combined with current/former use"
			lacey_etcurrent = "Current/former estrogen therapy user"
			lacey_etdose = "Estrogen therapy dose"
			lacey_etdur = "Estrogen therapy only duration (1st definition)"
			lacey_etfreq = "Estrogen therapy frequency"
			lacey_ettype = "Estrogen therapy type"

			lacey_fl_dosereg = "EPT dose/reg flag"
			lacey_ht_formulation = "Hormone therapy formulation"
			lacey_ht_type = "Hormone therapy type"
			lacey_sameduration = "EPT-only users - same reported dates EP?"
			lacey_samestart44 = "Classifies estrogen and progestin therapy in terms of when each was started relative to the other"
			lacey_sameyears = "EPT-only users - same reported duration EP?"

			ht_type_nat="lacey Hormone therapy type, natural meno"
			ht_type_surg="lacey Hormone therapy type, surgical meno"
			
	;
	** set variable value labels;
	format	skin_dxdt dod raadate f_dob entry_dt rf_entry_dt Date9.
			/* for outcomes */
			melanoma_c melanfmt. melanoma_agg melanomafmt. 
			melanoma_ins melanomainsfmt. melanoma_mal melanomamalfmt.

			/* for baseline*/
			uvrq_me uvrqfmt. oralbc_dur_c_me oralbcdurfmt. educ_c_me educfmt. race_c_me racefmt. 
			hormever hormeverfmt. attained_age_me attainedagefmt. marriage marriagefmt.
			birth_cohort_me birthcohortfmt. flb_age_c_me flbagefmt. fmenstr_me fmenstrfmt. 
			meno_age_c_me menoagefmt. menostat_c_me menostatfmt. surg_age_c_me surgagefmt.
			physic_c physic_1518_c physic_c_me physicfmt. 
			horm_nat_c_me horm_surg_c_me horm_ever_me hormstatfmt. parity_me parityfmt. 
			horm_cur_me hormcurfmt. 
			horm_yrs_c horm_yrs_me horm_yrs_nat_c horm_yrs_surg_c horm_yrs_nat_me horm_yrs_surg_me hormyrsfmt.
			bmi_fc bmi_c_me bmifmt. agecat_me agecatfmt.
			smoke_former_me smokeformerfmt. smoke_dose smokedosefmt.
			rel_1d_cancer_me relativefmt. coffee_c_me coffeefmt. etoh_c_me etohfmt.
			ovarystat_c_me ovarystatfmt. oralbc_yn_c_me oralbcynfmt.
			horm_nat_ever_me horm_surg_ever_me hormeverfmt.

			uvrq uvrqfmt. oralbc_dur_c oralbcdurfmt. educ_c educfmt. race_c racefmt. 
			hormever hormeverfmt. attained_age attainedagefmt. marriage marriagefmt.
			birth_cohort birthcohortfmt. flb_age_c flbagefmt. fmenstr fmenstrfmt. 
			meno_age_c menoagefmt. menostat_c menostatfmt. surg_age_c surgagefmt.
			physic_c physic_1518_c physic_c physicfmt. 
			horm_nat_c horm_surg_c horm_ever hormstatfmt. parity parityfmt. 
			horm_cur hormcurfmt.
			bmi_fc bmi_c bmifmt. agecat agecatfmt.
			smoke_former smokeformerfmt. smoke_quit smokequitfmt.
			rel_1d_cancer relativefmt. coffee_c coffeefmt. etoh_c etohfmt.
			ovarystat_c ovarystatfmt. oralbc_yn_c oralbcynfmt.
			horm_nat_ever_c horm_surg_ever_c hormeverfmt.
			mht_ever mht_ever_me mhteverfmt.
			menop_age menop_age_me menopagefmt.
			menopi_age menopi_age_me menopiagefmt.
			
			/* for riskfactor */
			rf_physic_1518_c rfphysicfmt. rf_physic_c rfphysicfmt. rf_1d_cancer relativefmt.
			rf_phys_modvig_curr rfphysfmt.
			rf_hormtype rfhormtype.

			/* for MHT */
			lacey_afterrfq l_afterrfq. lacey_eptcurdur l_eptcurdur. 
			lacey_eptcurdur2 l_eptcurdurr. 
			lacey_eptcurrent lacey_eptcurrent_me l_eptcurrent. 
			lacey_eptdose lacey_eptdose_me lacey_eptdose_c l_eptdose. lacey_eptdur lacey_eptdur_me lacey_eptdur_c l_eptdur.
			lacey_eptregdose l_eptregdose. lacey_eptregyrs l_eptregyrs. lacey_eptreg l_eptreg.
			lacey_epttype l_epttype. lacey_est_vs_prg l_estvsprg. lacey_et_ept_et l_et_ept_et.

			lacey_etcurdur l_eptcurdur. lacey_etcurrent lacey_etcurrent_me l_eptcurrent. 
			lacey_etdose lacey_etdose_me lacey_etdose_c l_etdose. 
			lacey_etdur lacey_etdur_me lacey_etdur_c l_etdur. 
			lacey_etfreq lacey_etfreq_me lacey_etfreq_c l_etfreq. lacey_ettype l_ettype.

			lacey_fl_dosereg l_fldosereg. lacey_ht_formulation l_htformulation. 
			lacey_ht_type ht_type_nat ht_type_surg ht_type_nat_me ht_type_surg_me l_httype.
			lacey_sameduration l_sameduration. lacey_samestart44 l_samestart. 
			lacey_sameyears colo_sig_any any_screen l_sameyear.
			lacey_eptcurrent_ever_me lacey_eptcurrent_ever l_eptcurrentvr.
			lacey_etcurrent_ever_me lacey_etcurrent_ever l_etcurrentvr.
			ht_type_nat_ever ht_type_surg_ever ht_type_nat_ever_me ht_type_surg_ever_me l_httypevr.

			rf_est_cur rf_prg_cur rf_est_cur.
	;
run;
/******************************************************************************************/
ods html close;
ods html;
data use_r;
	set conv.melan_r;
run;

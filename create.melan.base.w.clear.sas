**************************;
***** Start2 here ********;
**************************;
** uses the pre-created analysis_use from above checkpoint;
data melan; ** name the output of the first primary analysis include to melan;
	set conv.analysis_use;
	****** Define melanoma - pulled from allcancer-coffee analysis ******; 
	** create the melanoma case variable from the cancer ICD-O-3 and SEER coding of 25010;
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

*******************************************************;
/* Check for exclusions from Loftfield Coffee paper;
** total of n=566398;
proc copy noclone in=Work out=conv;
	select analysis;
run;
*/
*******************************************************;
/*
proc contents data=conv.rexp05jun14;
	title 'risk exposure contents';
run;
*/
/**
create and merge the HRT variables from the risk factor dataset
to the working melan dataset 
** also include bmi, physical exercise;
data rexposure;
  set conv.rexp05jun14
	(keep=	westatid 
			riskfactor characteristics variables
			rf_agecat
			rf_phys_modvig_15_18

			hormone variables
			RF_ESTNAME_ESTRACE RF_ESTNAME_ESTRATAB RF_ESTNAME_OGEN
			RF_ESTNAME_OTHER RF_ESTNAME_PREMARIN RF_ESTNAME_UNSURE
			RF_ESTONLY_CALC_MO RF_ESTPRG_CALC_MO RF_ESTROGEN RF_EST_CALC_MO
			RF_EST_CUR RF_EST_DATEFLAG RF_EST_DOSE RF_EST_DUR
			RF_EST_FREQ RF_EST_START_DT RF_EST_STOP_DT

			RF_PRGNAME_CYCRIN RF_PRGNAME_MEDRO RF_PRGNAME_OTHER RF_PRGNAME_PROVERA
			RF_PRGNAME_UNSURE RF_PRGONLY_CALC_MO RF_PRG_CALC_MO RF_PRG_CUR
			RF_PRG_DATEFLAG RF_PRG_DOSE RF_PRG_DUR RF_PRG_FREQ
			RF_PRG_START_DT RF_PRG_STOP_DT RF_PROGESTIN	
		);
run;

** the HRT variables to the melan set;
data melan;
	merge melan rexposure;
	by westatid;
run;
**/
** merge the melan dataset with the UV data;
data melan;
	merge melan conv.uv_pub1;
	by westatid;
run;

** copy and save the melan dataset to the converted folder;
proc copy noclone in=Work out=conv;
	select melan;
run;
** quick checks on the conv.melan file;
** especially for the seer ICD-O-3 codes;
** melanoma code is 25010;
** check to see if the melanoma was coded correctly;
proc freq data=conv.melan;
	table cancer_siterec3*sex;
	table cancer_siterec3*cancer_seergroup /nopercent norow nocol;
run;

**** Exclusions macro;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\anchovy\exclusions.first.primary.macro.sas';

**** Outbox macro for use with outliers;
*%include 'C:\REB\AARP_HRTandMelanoma\Analysis\anchovy\outbox.macro.sas';

**** Use the exclusion macro to make "standard" exclusions and get counts of excluded subjects;
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

/**************************************************************************************      
* Define outliers for total energy;
%outbox(data     = conv.melan,
        id       = westatid,
        by       = ,
        comb_by  = ,
        var      = calories,
        cutoff1  = 3,
        cutoff2  = 2,
        keepzero = N,
        lambzero = Y,
        print    = N,
        step     = 0.01,
        addlog   = 0);

data conv.melan excl_kcal;
   set conv.melan;
   if noout_calories <= .z  then output excl_kcal;
   else output conv.melan;
run; */

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

** need to change the exposure percentiles after exclusions;
** uvr exposure;
** p10     p20     p25     p30     p40     p50     p60     p70     p75     p80     p90 ;
** 185.266 186.255 186.918 192.716 215.622 239.642 245.151 250.621 253.731 257.14  267.431 ;
** birth cohort;
** p10     p20     p25     p30     p40     p50     p60     p70     p75     p80     p90 ;
** -11887  -11303  -11009  -10728  -10149  -9511   -8834   -8111   -7744   -7330   -6414;
** etoh;
** p10     p20     p25     p30     p40     p50     p60     p70     p75     p80     p90 ;
** 0       0       0       0.01    0.04    0.06    0.1     0.22    0.32    0.52    1.12;
** year of birth;
** p10     p20     p25     p30     p40     p50     p60     p70     p75     p80     p90 ;
** 1927	   1929    1929    1930    1933    1935    1935    1937    1938    1939    1942;


/******************************************************************************************/
** creates the new imputed postmenopausal variable;
** excl_3_npostmeno;
** edit 20150901TUE WTL;
/******************************************************************************************/
data conv.melan;
	title;
	set conv.melan;
	** new postmenopause status recoded;
	** is postmenopausal: 1,2,3,4;
	** is not postmenopausal: 99;
	** use Sara Schonfeld's impuation method;
	** edit 20150902WED WTL;
	postmeno=.;
	if  	(perstop_menop=1 | perstop_surg=1 | perstop_radchem=1)    	/*reported periods stopped due to nat, surg, or rad/chem and */
																		then postmeno=1; 

	else if entry_age>=58												/*women>=57 and */                                                                       
			& ( menop_age<6 											/*have a menopausal age or */
			| (perstop_menop=1 | perstop_surg=1 | perstop_radchem=1)	/*have a reason for menopause or */                              
			| hormever=1 ) 												then postmeno=2; /*took MHT */       

	else if entry_age<=58												/*women<=57 and */
			& (ovarystat=1 | hyststat=1)                                /*had ovary or hyst surgery and */
			& (menop_age<6 | perstop_nostop=0)							then postmeno=3; /*had age at last period or said periods stopped */

	else if entry_age<=58 												/*women<=57 and */
			& perstop_nostop=1											/*periods did not stop and */
			& (perstop_menop=1 & hormever=1)							then postmeno=4; /*natural menopause and took MHT */

else postmeno=99;
run;
/***************************************************************************************/ 
/*   Exclude non-postmenopausal from above postmeno variable                           */
**   edit 20150901TUE WTL;
/***************************************************************************************/ 
data conv.melan;
	title 'Ex 3. exclude those not post-menopausal, excl_3_npostmeno';
	set conv.melan;
	excl_3_npostmeno=0;
	if postmeno=99 then excl_3_npostmeno=1;
	where excl_2_premeno=0;
run;
proc freq data=conv.melan;
	tables excl_2_premeno*excl_3_npostmeno 
			excl_3_npostmeno*melanoma_c /missing;
run;
proc freq data=conv.melan;
	tables postmeno*melanoma_c /missing;
run;

/******************************************************************************************/
** create the UVR, and confounder variables by quintile/categories;
** for both baseline and riskfactor questionnaire variables;
/* cat=categorical */
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

	** birth cohort date of birth quintile;
	birth_cohort=.;
	if      1925 <= dob_year < 1929  	then birth_cohort=1;
	else if 1929 <= dob_year < 1932  	then birth_cohort=2;
	else if 1932 <= dob_year < 1935  	then birth_cohort=3;
	else if 1935 <= dob_year < 1939  	then birth_cohort=4;
	else if 1939 <= dob_year         	then birth_cohort=5;

	** birth cohort dates by every 5 years;
	birth_cohort2=.;
	if		1925 <= dob_year < 1930		then birth_cohort2=1;
	else if 1930 <= dob_year < 1935		then birth_cohort2=2;
	else if 1935 <= dob_year < 1940		then birth_cohort2=3;
	else if 1940 <= dob_year < 1945		then birth_cohort2=4;
	else if 1945 <= dob_year < 1950		then birth_cohort2=5;

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

	** age at menarche cat, for clearance;
	if      fmenstr=1	then fmenstr_c=0; /* <=10 years old */
	else if fmenstr=2	then fmenstr_c=1; /* 11-12 years old */
	else if fmenstr=3	then fmenstr_c=2; /* 13-14 years old */
	else if fmenstr=4	then fmenstr_c=3; /* 15+ years old */
	else if fmenstr>4	then fmenstr_c=-9; /* missing */	

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
	else if age_flb in (8,9)	then flb_age_c=-9; /* missing */
	else if age_flb in (0)		then flb_age_c=9; /* nulliparous */
	else 	flb_age_c=.;

	
/** recode menopause status to include hysterectomy and oophorectomy **/
	
	/*
	menostat=-1;
	if LQ2_MENO_EVER=0                                                        then menostat=0; *Reference for models;
	if LQ2_MENO_EVER=1 and LQ2_Q37_713=1                                      then menostat=1; *Natural menopause, no hysterectomy;
	if LQ2_MENO_EVER=1 and LQ2_Q37_712=1 and LQ2_Q38_717=1                    then menostat=2; *Hysterectomy, 2 ovaries removed;
	if LQ2_MENO_EVER=1 and LQ2_Q37_712=1 and LQ2_Q38_717=2                    then menostat=3; *Hysterectomy, 1 ovary removed;
	if LQ2_MENO_EVER=1 and LQ2_Q37_712=1 and LQ2_Q38_717=3                    then menostat=4; *Hysterectomy, 0 ovaries removed;
	if LQ2_MENO_EVER=1 and LQ2_Q37_712=1 and (LQ2_38_717<0 or LQ2_Q38_717=4)  then menostat=5; *Hysterectomy, ovaries unknown;
	if LQ2_MENO_EVER=1 and (LQ2_Q37_714=1 or LQ2_Q37_715=1 or LQ2_Q37_716=1)  then menostat=6; *Other reasons for menopause;

	nmeno_age=-1;
	if LQ2_MENO_EVER=0                                   then nmeno_age=0;
	if LQ2_Q36_710>0   AND LQ2_Q36_710<50 AND menostat=1 then nmeno_age=1;
	if LQ2_Q36_710>=50 AND LQ2_Q36_710<55 AND menostat=1 then nmeno_age=2;*Reference for models;
	if LQ2_Q36_710>=55 AND LQ2_Q36_710<80 AND menostat=1 then nmeno_age=3;

	hmeno_age=-1;
	if LQ2_MENO_EVER=0                                                     then hmeno_age=0;
	if LQ2_Q36_710>0   AND LQ2_Q36_710<45 AND menostat>=2 AND menostat<=5  then hmeno_age=1;*Reference for models;
	if LQ2_Q36_710>=45 AND LQ2_Q36_710<50 AND menostat>=2 AND menostat<=5  then hmeno_age=2;
	if LQ2_Q36_710>=50 AND LQ2_Q36_710<80 AND menostat>=2 AND menostat<=5  then hmeno_age=3;
	*/

	** menopause status recoded;
	** use the perstop_surg (hyststat and ovarystat) and perstop_radchem;
	** fixed 20150715WED WTL;
	menostat_c=.;
	if 		perstop_surg=1 | hyststat=1 | ovarystat=1				then menostat_c=2; /* surgical/hyst menopause */
	*else if perstop_radchem=1										then menostat_c=4; /* radiation or chemotherapy */
	else if perstop_menop=1											then menostat_c=1; /* natural menopause */
	*else if perstop_nostop=1										then menostat_c=-9; /* premenopausal */
	*else if perstop_menop=0 & perstop_surg=0 & perstop_radchem=0	then menostat_c=4; /* other reason */
	else if perstop_nostop=0 | perstop_menop=0 | perstop_surg=0		then menostat_c=.; /* missing */
	else 	menostat_c=-9;

	** natural menopause reason age, 20150702 edit; 
	meno_age_c=.;
	if 		menostat_c=1 & menop_age in (1,2,3)		then meno_age_c=1; /* <50 */
	else if menostat_c=1 & menop_age=4			   	then meno_age_c=2; /* 50-54 */
	else if menostat_c=1 & menop_age=5				then meno_age_c=3; /* 55+ */
	else if menostat_c=1 & menop_age in (8,9)		then meno_age_c=-9; /* missing */
	else if menostat_c NE 1							then meno_age_c=.;
	else 	meno_age_c=-9;

	** surgery reason age, 20150721TUE WTL edit;
	surg_age_c=.;
	if 		menostat_c=2 & menop_age in (1,2)		then surg_age_c=1; /* <45 */
	else if menostat_c=2 & menop_age=3				then surg_age_c=2; /* 45-49 */
	else if menostat_c=2 & menop_age in (4,5)		then surg_age_c=3; /* 50+ */
	else if menostat_c=2 & menop_age in (8,9)		then surg_age_c=-9; /* missing */
	else if menostat_c NE 2							then surg_age_c=.;
	else	surg_age_c=-9;

	** menopausal age recoded;
	** edit 20150727MON WTL;
	if 		menop_age in (6,9)						then menop_age=9; /* missing */
	else if menop_age in (1,2)						then menop_age=1; /* <45 */
	else if menop_age=3								then menop_age=2; /* 45-49 */
	else if menop_age=4								then menop_age=3; /* 50-54 */
	else if menop_age=5								then menop_age=4; /* 55+ */
	menop_age_me = menop_age;
	if 		menop_age_me=9							then menop_age_me=.; /* missing for main effect */

	** menopausal age recoded with merged higher age groups;
	** edit 20150813THU WTL;
	menopi_age = menop_age;
	if menopi_age = 4								then menopi_age=3; /* 50<= */
	menopi_age_me = menopi_age;
	if menopi_age_me = 9							then menopi_age_me=.; /* missing for main effect */

	** ovary status, 20150708WED edit;
	ovarystat_c=.;
	if 		ovarystat=1 & menostat_c=2				then ovarystat_c=1; /* both removed */
	else if ovarystat=2 & menostat_c=2				then ovarystat_c=2; /* both intact */
	else if ovarystat in (3,9) & menostat_c=2		then ovarystat_c=-9; /* invalids are missing */

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
	else if hormstat=1						then horm_ever_me=1;   /* current horm */
	else if hormstat=2						then horm_ever_me=2;   /* former horm */
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
	** use this one (like Erikka), edit 20150708WED WTL;
	bmi_c=-9;
	if      0<=bmi_cur<25					then bmi_c=1; /* <25 */
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

	** first primary cancer stage, edit 20150817MON WTL;
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

	** total;
	total=1;

	** smoking recode;
	if smoke_former=9 						then smoke_former=-9;
	smoke_quit_c=smoke_quit;
	if smoke_quit=9 						then smoke_quit_c=-9;
	smoke_dose_c=smoke_dose;
	if smoke_dose=9							then smoke_dose_c=-9;
	if smoke_quit_dose=9					then smoke_quit_dose=-9;

	** attained age cat;
	if 		50<=exit_age<55					then attained_age=0;  
	else if 55<=exit_age<60					then attained_age=1;
	else if 60<=exit_age<65					then attained_age=2;
	else if 65<=exit_age<70					then attained_age=3;
	else if 70<=exit_age					then attained_age=4;
	else 	attained_age=-9;								/* missing */

	** marriage;
	marriage_c=marriage;
	if marriage in (3,4)					then marriage_c=3;

	** hormone duration;
	horm_yrs_c = horm_yrs;
	if		horm_yrs in (8,9)				then horm_yrs_c=-9;

	** hormone duration split meno/surg reasons;
	horm_yrs_nat_c=.;
	if menostat_c=1 						then horm_yrs_nat_c=horm_yrs_c;
	else if menostat_c NE 1					then horm_yrs_nat_c=.;
	horm_yrs_surg_c=.;
	if menostat_c=2							then horm_yrs_surg_c=horm_yrs_c;
	else if menostat_c NE 2					then horm_yrs_surg_c=.;
	
	rel_1d_cancer_c=rel_1d_cancer;
	if rel_1d_cancer_c=9					then rel_1d_cancer_c=-9;
run;

/***************************************************************************************/ 
/*   Exclude if self-reported periods stopped due to radchem                           */ 
**	 exclude: excl_4_radchem;
**   edit: 20150901TUE WTL;
/***************************************************************************************/ 
data conv.melan excl_radchem;
	title 'Ex 4. exclude women whose periods stopped due to rad/chem, excl_4_radchem';
	set conv.melan;
	excl_4_radchem=0;
	if perstop_radchem=1 then excl_4_radchem=1;
	where excl_3_npostmeno=0;
run;
proc freq data=conv.melan;
	tables excl_3_npostmeno*excl_4_radchem 
			excl_4_radchem*melanoma_c /missing;
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

/* recode the variables for main effect */
/* such that missings (9, -9) are coded as missing (.), so they are not counted when used as the main effect */
data conv.melan;
	set conv.melan;

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
	if parity>0 & flb_age_c=-9			then flb_age_c_me=.;
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
	if horm_surg_ever_me in (9,-9)		then horm_surg_ever_me=.;

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
	horm_yrs_me = horm_yrs_c;
	if	horm_yrs_me in (9,-9)			then horm_yrs_me=.;
	horm_yrs_nat_me = horm_yrs_nat_c;
	if horm_yrs_nat_me in (9,-9)		then horm_yrs_nat_me=.;
	horm_yrs_surg_me = horm_yrs_surg_c;
	if horm_yrs_surg_me in (9,-9)		then horm_yrs_surg_me=.;

	ovarystat_c_me = ovarystat_c;
	if ovarystat_c_me in (9,-9)			then ovarystat_c_me=.;
run;

** add in colo_sig_any as hospital indicator from riskfactor dataset;
** 20150721TUE WTL;

data conv.melan;
	merge conv.melan (in=snsd) conv.melan_hosp;
	by westatid;
	if snsd;
	if colo_sig_any = . 				then colo_sig_any=-9;
run;

ods html close;
ods html;

** add labels;
proc datasets library=conv;
	modify melan;
	
	** set variable labels;
	label 	/* melanoma outcomes */
			melanoma_agg = "Melanoma indicator"
			melanoma_c = "Melanoma indicator by type"
			melanoma_ins = "Melanoma in situ"
			melanoma_mal = "malignant Melanoma"

			/* for baseline */
			agecat = "Entry age category"
			uvrq = "TOMS AVGLO-UVR measures in quartiles"
			oralbc_dur_c = "birth control duration"
			oralbc_yn_c = "birth control yes/no"
			birth_cohort = "Year of birth, quantiles"
			birth_cohort2= "Year of birth, 5 year segments"
			educ_c = "education level"
			race_c = "race split into 3"
			attained_age = "Attained Age"
			flb_age_c = "Age at first live birth among parous women"
			fmenstr = "Age at menarche"
			menostat_c = "menopause status"
			menop_age = "Menopausal age"
			menop_age_me = "Menopausal age, ME"
			meno_age_c ="age at natural menopause"
			surg_age_c ="age at surgical menopause"
			menostat_c ="menopause status"
			physic_c = "level of physical activity"	
			horm_nat_c = "hormone usage, natural menopause"
			horm_surg_c = "hormone usage, surgical menopause"
			horm_ever_me = "Ever take replacement hormones"
			parity = "total number of live births"
			cancer_g_c = "cancer grade"
			bmi_c = "bmi, three"
			bmi_fc = "bmi, 5"
			stage_c = "stage of first primary cancer"
			physic_1518_c = "level of physical activity at ages 15-18 (base)"
			marriage = "marriage status"

			smoke_former ="Smoking Status"
			smoke_quit = 'Quit smoking status'
			smoke_dose = 'Smoking dose'
			smoke_quit_dose = 'Smoking status and dose combined'
			rel_1d_cancer = 'Family History of Cancer'
			coffee_c = 'Coffee drinking'
			etoh_c = 'Total alchohol per day including food sources'
			colo_sig_any = "Colonoscopy or Sigmoidoscopy in past 3 years?"

			horm_cur = 'Current Hormone Use'
			horm_yrs_c = 'Hormone Use Duration'
			horm_yrs_nat_c = 'Hormone Use Duration, only nat meno'
			horm_yrs_surg_c = 'Hormone Use Duration, only surg meno'

			/* for main effects */
			horm_ever_me = 'Replacement hormones ever _me'
			flb_age_c_me = 'Age at first live birth _me'

			perstop_menop = 'Periods stop due to natural menopause?'
			perstop_surg = 'Periods stop due to surgery?'
			hyststat = 'Hysterectomy Status'


			/* for riskfactor */
	;
	** set variable value labels;
	format	/* for outcomes */
			melanoma_c melanfmt. melanoma_agg melanomafmt. melanoma_ins melanomainsfmt. 
			melanoma_mal melanomamalfmt.

			/* for baseline*/
			uvrq_me uvrqfmt. oralbc_dur_c_me oralbcdurfmt. educ_c_me educfmt. race_c_me racefmt. 
			hormever hormeverfmt. attained_age_me attainedagefmt. marriage marriage_c marriagefmt.
			birth_cohort_me birthcohortfmt. flb_age_c_me flbagefmt. fmenstr_me fmenstrcfmt. 
			meno_age_c_me menoagefmt. menostat_c_me menostatfmt. surg_age_c_me surgagefmt.
			physic_c physic_c_me physiccfmt. 
			physic physicfmt.
			horm_nat_c_me horm_surg_c_me horm_ever_me  hormstatfmt. parity_me parityfmt. 
			horm_cur_me hormcurfmt. horm_yrs_me hormyrsfmt.
			bmi_c_me bmifmt. agecat_me agecatfmt.
			smoke_former_me smokeformerfmt. 
			rel_1d_cancer_me relativefmt. coffee_c_me coffeefmt. etoh_c_me etohfmt.
			ovarystat_c_me ovarystatfmt. oralbc_yn_c_me oralbcynfmt.
			horm_nat_ever_me horm_surg_ever_me hormeverfmt.

			uvrq uvrqfmt. oralbc_dur_c oralbcdurfmt. educ_c educfmt. race_c racefmt. 
			hormever hormeverfmt. attained_age attainedagefmt. marriage  marriagefmt. marriage_c marriagecfmt.
			birth_cohort birthcohortfmt. flb_age_c flbagefmt. fmenstr  fmenstrfmt. fmenstr_c fmenstrcfmt.
			meno_age_c menoagefmt. menostat_c menostatfmt. surg_age_c surgagefmt.
			physic physicfmt. physic_c physiccfmt.
			horm_nat_c horm_surg_c horm_ever hormstat hormstatfmt. parity parityfmt. 
			horm_cur hormcurfmt. 
			horm_yrs_c horm_yrs_me horm_yrs_nat_c horm_yrs_surg_c horm_yrs_nat_me horm_yrs_surg_me horm_yrs hormyrsfmt.
			bmi_c bmifmt. agecat agecatfmt.
			smoke_former bf_smoke_former smokeformerfmt. smoke_dose smoke_dose_c smokedosefmt. smoke_quit smoke_quit_c smokequitfmt.
			rel_1d_cancer rel_1d_cancer_c relativefmt. coffee_c coffeefmt. etoh_c etohfmt.
			ovarystat_c ovarystat ovarystatfmt.
			oralbc_yn_c oralbcynfmt.
			horm_nat_ever_c horm_surg_ever_c hormeverfmt.
			colo_sig_any colosigfmt.
			menop_age menop_age_me menopagefmt.
			mht_ever mht_ever_me mhteverfmt.
			menopi_age menopi_age_me menopiagefmt.
			educm educmfmt.
			livechild livechildfmt.
			age_flb ageflbfmt.
			oralbc_yrs oralbcyrsfmt.
			perstop_menop perstopmenopfmt.
			perstop_surg perstopsurgfmt.
			hyststat hyststatfmt.
	;
run;
/******************************************************************************************/
ods html close;
ods html;
data use;
	set conv.melan;
run;

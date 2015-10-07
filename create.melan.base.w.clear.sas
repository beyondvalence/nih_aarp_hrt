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

/******************************************************************************************/
** create the UVR, and confounder variables by quintile/categories;
** for both baseline and riskfactor questionnaire variables;
/* cat=categorical */
data conv.melan;
	title;
	set conv.melan;

/* for baseline */
	** education cat;
	educ_c=.;
	if 		educm=1 		then educ_c=0; /* less highschool */
	else if educm=2			then educ_c=1; /* highschool grad */
	else if educm in (3,4)	then educ_c=2; /* some college */
	else if educm=5			then educ_c=3; /* college and grad */
	else if educm=9			then educ_c=-9; /* missing */

	** bmi three categories;
	bmi_c=-9;
	if      0<=bmi_cur<25					then bmi_c=1; /* < 25 */
   	else if 25<=bmi_cur<30 					then bmi_c=2; /* 25 to <30*/
   	else if bmi_cur>=30 					then bmi_c=3; /* >=30*/ 
	else if bmi_cur=.						then bmi_c=-9;

	** physical exercise cat;
	physic_c=.;
	if      physic in (0,1)	then physic_c=0; /* rarely */
	else if physic=2 	 	then physic_c=1; /* 1-3 per month */
	else if physic=3 	 	then physic_c=2; /* 1-2 per week */
	else if physic=4     	then physic_c=3; /* 3-4 per week */
	else if physic=5     	then physic_c=4; /* 5+ per week */
	else if physic=9	 	then physic_c=-9; /* missing */

	** age at menarche cat;
	fmenstr_c=.;
	if      fmenstr=1	then fmenstr_c=0; /* <=10 years old */
	else if fmenstr=2	then fmenstr_c=1; /* 11-12 years old */
	else if fmenstr=3	then fmenstr_c=2; /* 13-14 years old */
	else if fmenstr=4	then fmenstr_c=3; /* 15+ years old */
	else if fmenstr>4	then fmenstr_c=-9; /* missing */

	** menopause reason, 20150901 edit;
	** 1 natural, 2 surgical;
	menostat_c=.;
	if		perstop_surg=1 | hyststat=1 | ovarystat=1		then menostat_c=2; /* surgical */
	else if	perstop_menop=1									then menostat_c=1; /* natural */
	else menostat_c =-9;

	** ovary status among surgical menopause;
	ovarystat_c=.;
	if 		ovarystat=1 & menostat_c=2				then ovarystat_c=1; /* both removed */
	else if ovarystat=2 & menostat_c=2				then ovarystat_c=2; /* both intact */
	else if ovarystat in (3,9) & menostat_c=2		then ovarystat_c=-9; /* invalids are missing */

	** menopausal age recoded;
	menop_age_c=.;
	if 		menop_age in (6,9)						then menop_age_c=-9; /* missing */
	else if menop_age in (1,2)						then menop_age_c=1; /* <45 */
	else if menop_age=3								then menop_age_c=2; /* 45-49 */
	else if menop_age=4								then menop_age_c=3; /* 50-54 */
	else if menop_age=5								then menop_age_c=4; /* 55+ */

	** live child parity cat;
	parity_c=.;
	if 		livechild=0						then parity_c=0; /* no live children (nulliparous) */
	else if livechild in (1,2) 				then parity_c=1; /* 1 to 2 live children */
	else if livechild in (3,4,5) 			then parity_c=2; /* >=3 live children */
	else if livechild in (8,9)				then parity_c=-9; /* missing */

	parity_ever=parity_c;
	if parity_ever in (1,2)					then parity_ever=1;

	** age at first live birth cat;
	flb_age_c=9;
	if 		age_flb in (1,2)	then flb_age_c=1; /* < 20 years old */
	else if age_flb in (3,4)	then flb_age_c=2; /* 20s */
	else if age_flb in (5,6,7)	then flb_age_c=3; /* 30s */
	else if age_flb in (0,8,9)	then flb_age_c=-9; /* missing */

	** oral contraceptive yes/no;
	oralbc_yn_c=.;
	if      oralbc_yrs=0 	then oralbc_yn_c=0; /* no oc */
	else if 0<oralbc_yrs<8	then oralbc_yn_c=1; /* yes oc */
	else if oralbc_yrs>7	then oralbc_yn_c=-9; /* missing */

	** oral contraceptive duration cat;
	oralbc_dur_c=.;
	if      oralbc_yrs=0		then oralbc_dur_c=0; /* none */
	else if oralbc_yrs=1		then oralbc_dur_c=1; /* 1-4 years */
	else if oralbc_yrs=2		then oralbc_dur_c=2; /* 5-9 years */
	else if oralbc_yrs=3 		then oralbc_dur_c=3; /* 10+ years */
	else if oralbc_yrs in (8,9)	then oralbc_dur_c=-9; /* missing */

	** MHT ever variable;
	mht_ever_c=hormstat;
	if		mht_ever=2						then mht_ever_c=1;

	** hormone former or current user;
	hormstat_c=.;
	if		hormstat=0						then hormstat_c=0;   /* never horm */
	else if hormstat=1						then hormstat_c=1;   /* current horm */
	else if hormstat=2						then hormstat_c=2;   /* former horm */
	else if hormstat=9						then hormstat_c=-9;	/* missing horm */
	else hormstat_c=.;

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

	** UVR TOMS quantiles;
	uvrq_c=.;
	if      0       < exposure_jul_78_05 <= 186.918 then uvrq_c=1;
	else if 186.918 < exposure_jul_78_05 <= 239.642 then uvrq_c=2;
	else if 239.642 < exposure_jul_78_05 <= 253.731 then uvrq_c=3;
	else if 253.731 < exposure_jul_78_05            then uvrq_c=4;
	else uvrq=-9;

	** marriage;
	marriage_c = marriage;
	if marriage in (3,4)					then marriage_c=3; /* divorced and separated together */

	** smoking missings recode;
	smoke_former_c=smoke_former;
	if smoke_former_c=9 					then smoke_former_c=-9;
	smoke_quit_c=smoke_quit;
	if smoke_quit_c=9 						then smoke_quit_c=-9;
	smoke_dose_c=smoke_dose;
	if smoke_dose_c=9						then smoke_dose_c=-9;

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

	** relatives with cancer;
	rel_1d_cancer_c=rel_1d_cancer;
	if rel_1d_cancer_c=9					then rel_1d_cancer_c=-9;
run;

/***************************************************************************************/ 
/*   Exclude if person-years <= 0                                                      */
**   exclude: excl_5_pyzero;
**   edit: 20151001THU WTL;
/***************************************************************************************/      
data conv.melan;
	title 'Ex 5. exclude women with zero or less person years, excl_6_pyzero';
	set conv.melan;
    excl_5_pyzero=0;
   	if personyrs <= 0 then excl_5_pyzero=1;
   	where excl_4_npostmeno=0;
run;
proc freq data=conv.melan;
	tables excl_4_npostmeno*excl_5_pyzero 
			excl_5_pyzero*melanoma_c /missing;
run; 
data conv.melan;
	title;
	set conv.melan;
	where excl_5_pyzero=0;
run;

data conv.melan;
	set conv.melan;
	** recode parity and flb_age_c to consolidate contradicting missings in each;
	** if nulliparous or missing number of births, then age at birth should be missing;
	*** -9 in flb_age means missing to begin with;
	*** whereas 9 in flb_age means they were coerced to be missing due to missing parity;
	if		parity_c in (1,2) & flb_age_c=9		then flb_age_c=-9; 
	else if parity_c=2 & flb_age_c=9			then flb_age_c=-9;
	if 		parity_c in (0,-9)					then flb_age_c=9;
run;

/* recode the variables for main effect */
/* such that missings (9, -9) are coded as missing (.), so they are not counted when used as the main effect */
data conv.melan;
	set conv.melan;

	** main effects;
	educ_me = educ_c;
	if	educ_me in (9,-9)				then educ_me=.;
	bmi_me = bmi_c;
	if	bmi_me in (9,-9)				then bmi_me=.;
	physic_me = physic_c;
	if	physic_me  in (9,-9)			then physic_me=.;

	fmenstr_me = fmenstr_c;
	if	fmenstr_me in (9,-9)			then fmenstr_me=.;
	menostat_me = menostat_c;
	if	menostat_me in (9,-9) 			then menostat_me=.;
	ovarystat_me=ovarystat_c;
	if ovarystat_me in (9,-9)			then ovarystat_me=.;
	menop_age_me = menop_age_c;
	if menop_age_me in (9,-9)			then menop_age_me=.;
	parity_me=parity_c;
	if	parity_me in (9,-9)				then parity_me=.;
	flb_age_me = flb_age_c;
	if	flb_age_me  in (9,-9)			then flb_age_me=.;
	if parity_c>0 & flb_age_c=-9		then flb_age_me=.;
	oralbc_yn_me = oralbc_yn_c;
	if oralbc_yn_me in (9,-9)			then oralbc_yn_me=.;
	oralbc_dur_me = oralbc_dur_c;
	if	oralbc_dur_me in (9,-9)			then oralbc_dur_me=.;

	mht_ever_me = mht_ever_c;
	if mht_ever_me in (9,-9)			then mht_ever_me=.;
	hormstat_me = hormstat_c;
	if hormstat_me in (9,-9)			then hormstat_me=.;
	horm_yrs_me = horm_yrs_c;
	if	horm_yrs_me in (9,-9)			then horm_yrs_me=.;
	horm_yrs_nat_me = horm_yrs_nat;
	if horm_yrs_nat_me in (9,-9)		then horm_yrs_nat_me=.;
	horm_yrs_surg_me = horm_yrs_surg;
	if horm_horm_yrs_surg_me in (9,-9)	then horm_yrs_surg_me=.;

	uvrq_me = uvrq_c;
	if	uvrq_me in (9,-9)				then uvrq_me=.;
	rel_1d_cancer_me = rel_1d_cancer_c;
	if	rel_1d_cancer_me in (9,-9)		then rel_1d_cancer_me=.;
run;

** add in colo_sig_any as hospital indicator from riskfactor dataset;
** 20150721TUE WTL;

data conv.melan;
	merge conv.melan (in=snsd) conv.melan_hosp;
	by westatid;
	if snsd;
	if colo_sig_any = . 				then colo_sig_any=-9;
	any_screen=colo_sig_any;
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
			uvrq_c = "TOMS AVGLO-UVR measures in quartiles"
			oralbc_dur_c = "birth control duration"
			oralbc_yn_c = "birth control yes/no"
			educ_c = "education level"
			flb_age_c = "Age at first live birth among parous women"
			fmenstr_c = "Age at menarche"
			menostat_c = "menopause status"
			menop_age_c = "Menopausal age"
			menop_age_me = "Menopausal age, ME"
			physic_c = "level of physical activity"	
			hormstat_c = "hormone current/former use"
			parity_c = "total number of live births"
			bmi_c = "bmi, three"
			marriage_c = "marriage status"

			smoke_former_c ="Smoking Status"
			smoke_quit_c = 'Quit smoking status'
			smoke_dose_c = 'Smoking dose'
			smoke_quit_dose = 'Smoking status and dose combined'
			rel_1d_cancer_c = 'Family History of Cancer'
			coffee_c = 'Coffee drinking'
			etoh_c = 'Total alchohol per day including food sources'
			colo_sig_any = "Colonoscopy or Sigmoidoscopy in past 3 years?"

			horm_cur = 'Current Hormone Use'
			horm_yrs_c = 'Hormone Use Duration'
			horm_yrs_nat_c = 'Hormone Use Duration, only nat meno'
			horm_yrs_surg_c = 'Hormone Use Duration, only surg meno'

			/* for main effects */
			hormstat_me = 'Replacement hormones ever _me'
			flb_age_me = 'Age at first live birth _me'

			perstop_menop = 'Periods stop due to natural menopause?'
			perstop_surg = 'Periods stop due to surgery?'
			hyststat = 'Hysterectomy Status'
			ovarystat = 'oophorectomy status'


			/* for riskfactor */
	;
	** set variable value labels;
	format	/* for outcomes */
			melanoma_c melanfmt. melanoma_agg melanomafmt. melanoma_ins melanomainsfmt. 
			melanoma_mal melanomamalfmt.

			/* for baseline main effect */
			educ_me educfmt.
			bmi_me bmifmt. 
			physic_me physiccfmt. 
			fmenstr_me fmenstrcfmt.
			menostat_me menostatfmt.
			ovarystat_me ovarystatfmt.
			menop_age_me menopagefmt.
			parity_me parityfmt. 
			flb_age_me flbagefmt.  
			oralbc_yn_me oralbcynfmt.
			oralbc_dur_me oralbcdurfmt. 
			mht_ever_me mhteverfmt.
			hormstat_me  hormstatfmt.
			horm_yrs_me hormyrsfmt.
			horm_yrs_nat_me horm_yrs_surg_me hormyrsfmt.
			uvrq_me uvrqfmt.			

			/* baseline regular variables*/
			educ_c educfmt. educm educmfmt.
			bmi_c bmifmt.
			physic physicfmt. physic_c physiccfmt.
			fmenstr  fmenstrfmt. fmenstr_c fmenstrcfmt.
			perstop_menop perstopmenopfmt. perstop_surg perstopsurgfmt. hyststat hyststatfmt.
			menostat_c menostatfmt.
			ovarystat_c ovarystat ovarystatfmt.
			menop_age_c menopagefmt. menop_age agemenofmt.
			parity_c parityfmt.
			livechild livechildfmt.
			flb_age_c flbagefmt. 
			age_flb ageflbfmt.
			oralbc_yn_c oralbcynfmt.
			oralbc_dur_c oralbc_yrs oralbcdurfmt. 
			mht_ever_c  parity_ever mhteverfmt.
			hormstat_c hormeverfmt. hormstat hormstatfmt. 
			horm_yrs_c horm_yrs_me horm_yrs_nat_c horm_yrs_surg_c  horm_yrs hormyrsfmt.
			uvrq_c uvrqfmt.
			marriage  marriagefmt. marriage_c marriagecfmt.
			smoke_former_c smoke_former smokeformerfmt.
			smoke_quit smoke_quit_c smokequitfmt.
			smoke_dose smoke_dose_c smokedosefmt. 
			coffee_c coffeefmt. etoh_c etohfmt.
			rel_1d_cancer rel_1d_cancer_c relativefmt. 
	;
run;
/******************************************************************************************/
ods html close;
ods html;
data use;
	set conv.melan;
run;

**************************;
***** Start2 here ********;
**************************;
** uses the pre-created analysis_use from above checkpoint;
libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\formats.20150714.risk.sas';
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
data conv.melan_r;
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

/***************************************************************************************/ 
/*   Exclude if younger than 60 and with no menopause reason                           */ 
**   edit 20151002FRI WTL;
/***************************************************************************************/ 
data conv.melan_r;
	title 'Ex 4. exclude those younger than 60 and with no menopause reason, excl_4_npostmeno';
	set conv.melan_r;
	excl_4_npostmeno=0;
	if entry_age < 60 & (perstop_menop NE 1 & perstop_surg NE 1 & ovarystat NE 1 & hyststat NE 1) then excl_4_npostmeno=1;
	where excl_3_radchem=0;
run;
proc freq data=conv.melan_r;
	tables excl_3_radchem*excl_4_npostmeno 
			excl_4_npostmeno*melanoma_c /missing;
run;

/******************************************************************************************/
** create the UVR, and confounder variables by quintile/categories;
** for both baseline and riskfactor questionnaire variables;
/* cat=categorical ************************************************************************/
data conv.melan_r;
	set conv.melan_r;

/* for baseline */

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
	if		mht_ever_c=2						then mht_ever_c=1;
	else if mht_ever_c=9						then mht_ever_c=-9;

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
	else uvrq_c=-9;

	** marriage;
	marriage_c = marriage;
	if 		marriage in (3,4)					then marriage_c=3; /* divorced and separated together */
	else if marriage=9							then marriage_c=-9; /* */

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

	** total;
	total=1;

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
	ht_nat_c=-9;
	if 		lacey_ht_type = 0 & menostat_c=1		then ht_nat_c=0; /* no ht */
	else if	lacey_ht_type = 1 &	menostat_c=1		then ht_nat_c=1; /* et */
	else if	lacey_ht_type = 2 &	menostat_c=1		then ht_nat_c=2; /* ept */
	else if	lacey_ht_type = 3 & menostat_c=1		then ht_nat_c=3; /* unk type */
	else if lacey_ht_type = 9 & menostat_c=1		then ht_nat_c=-9; /* unknown */
	else if menostat_c NE 1							then ht_nat_c=.;

	ht_nat_me = ht_nat_c;
	if ht_nat_me in (9, -9)				then ht_nat_me=.;

	ht_nat_ever_c=ht_nat_c;
	if ht_nat_ever_c in (1,2,3)						then ht_nat_ever_c=1; /* ever HT */

	ht_nat_ever_me = ht_nat_ever_c;
	if ht_nat_ever_me in (9,-9)			then ht_nat_ever_me=.;

	ht_surg_c=-9;
	if 		lacey_ht_type = 0 & menostat_c=2			then ht_surg_c=0; /* no ht */
	else if	lacey_ht_type = 1 &	menostat_c=2			then ht_surg_c=1; /* et */
	else if	lacey_ht_type = 2 &	menostat_c=2			then ht_surg_c=2; /* ept */
	else if	lacey_ht_type = 3 & menostat_c=2			then ht_surg_c=3; /* unk type */
	else if lacey_ht_type = 9 & menostat_c=2			then ht_surg_c=-9; /* unknown */
	else if menostat_c NE 2								then ht_surg_c=.;

	ht_surg_me = ht_surg_c;
	if ht_surg_me in (9, -9)			then ht_surg_me=.;

	ht_surg_ever_c=ht_surg_c;
	if ht_surg_ever_c in (1,2,3)						then ht_surg_ever_c=1; /* ever HT */

	ht_surg_ever_me=ht_surg_ever_c;
	if ht_surg_ever_me in (9,-9)		then ht_surg_ever_me=.;

	*******************************************************************************************;
	*************** HRT variables *************************************************************;
	*******************************************************************************************;
	** use Jim Lacey's coding of the variables *********;
	** recode for main effects *************************;
	** updated 20151008THU WTL **;
	****************************************************;
	** EPT current ***************;
	l_eptcurrent_ever_c = lacey_eptcurrent;
	if l_eptcurrent_ever_c in (1,2,3)		then l_eptcurrent_ever_c=1; /* ever EPT */
	else if l_eptcurrent_ever_c = 4			then l_eptcurrent_ever_c=-9;
	l_eptcurrent_ever_me = l_eptcurrent_ever_c;
	if l_eptcurrent_ever_me=-9				then l_eptcurrent_ever_me=.;
	l_eptcurrent_c = lacey_eptcurrent;
	if l_eptcurrent_c=4						then l_eptcurrent_c=-9;
	l_eptcurrent_me = l_eptcurrent_c;
	if l_eptcurrent_me = -9					then l_eptcurrent_me=.;

	** EPT dose ***************;
	l_eptdose_c=.;
	if l_eptcurrent_ever_c=1 & lacey_eptdose in (1,2,3,4) then l_eptdose_c=lacey_eptdose;
	else l_eptdose_c=-9;
	l_eptdose_me = l_eptdose_c;
	if l_eptdose_me=-9						then l_eptdose_me=.;

	** EPT duration ***************;
	l_eptdur_c = .;
	if l_eptcurrent_ever_c=1 & lacey_eptdur in (1,2,3) then l_eptdur_c=lacey_eptdur;
	else l_eptdur_c=-9;
	l_eptdur_me = l_eptdur_c;
	if l_eptdur_me=-9						then l_eptdur_me=.;
	
	** ET current ***************;
	l_etcurrent_ever_c = lacey_etcurrent;
	if l_etcurrent_ever_c in (1,2,3)		then l_etcurrent_ever_c=1; /* ever ET */
	else if l_etcurrent_ever_c=4			then l_etcurrent_ever_c=-9;
	l_etcurrent_ever_me = l_etcurrent_ever_c;
	if l_etcurrent_ever_me=-9				then l_etcurrent_ever_me=.;
	l_etcurrent_c = lacey_etcurrent;
	if l_etcurrent_c=4						then l_etcurrent_c=-9;
	l_etcurrent_me = l_etcurrent_c;
	if l_etcurrent_me=-9					then l_etcurrent_me=.;

	** ET dose ***************;
	l_etdose_c=.;
	if l_etcurrent_ever_c=1 & lacey_etdose in (1,2) then l_etdose_c=lacey_etdose;
	else l_etdose_c=-9;
	l_etdose_me = l_etdose_c;
	if l_etdose_me=-9						then l_etdose_me=.;

	** ET duration ***************;
	l_etdur_c=.;
	if l_etcurrent_ever_c=1 & lacey_etdur in (1,2) then l_etdur_c=lacey_etdur;
	else l_etdur_c=-9;
	l_etdur_me = l_etdur_c;
	if l_etdur_me=-9						then l_etdur_me=.;

	** ET freq ***************;
	l_etfreq_c=.;
	if l_etcurrent_ever_c=1 & lacey_etfreq in (1,2) then l_etfreq_c=lacey_etfreq;
	else l_etfreq_c=-9;
	l_etfreq_me = l_etfreq_c;
	if l_etfreq_me=-9						then l_etfreq_me=.;

	** finished HRT variables;
	*******************************************************************************************;

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

run;

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
	if		parity_c in (1,2) & flb_age_c=9		then flb_age_c=-9; 
	else if parity_c=2 & flb_age_c=9			then flb_age_c=-9;
	if 		parity_c in (0,-9)					then flb_age_c=9;
run;

ods html close;
ods html;

/* recode the variables for main effect */
/* such that missings (9, -9) are coded as missing (.), so they are not counted */
data conv.melan_r;
	set conv.melan_r;

	fmenstr_me = fmenstr_c;
	if	fmenstr_me in (9,-9)			then fmenstr_me=.;
	menostat_me = menostat_c;
	if	menostat_me in (9,-9) 			then menostat_me=.;
	menop_age_me = menop_age_c;
	if	menop_age_me in (9,-9)			then meno_age_me=.;
	parity_me=parity_c;
	if	parity_me in (9,-9)				then parity_me=.;
	flb_age_me = flb_age_c;
	if	flb_age_me  in (9,-9)			then flb_age_me=.;
	oralbc_dur_me = oralbc_dur_c;
	if	oralbc_dur_me in (9,-9)			then oralbc_dur_me=.;
	oralbc_yn_me = oralbc_yn_c;
	if oralbc_yn_me in (9,-9)			then oralbc_yn_me=.;
	mht_ever_me = mht_ever_c;
	if mht_ever_me in (9,-9)			then mht_ever_me=.;
	hormstat_me = hormstat_c;
	if hormstat_me in (9,-9)			then hormstat_me=.;
	horm_nat_me = horm_nat_c;
	if	horm_nat_me  in (9,-9)			then horm_nat_me=.;
	horm_nat_ever_me = horm_nat_ever_c;
	if horm_nat_ever_me in (9,-9)		then horm_nat_ever_me=.;
	horm_surg_me = horm_surg_c;
	if	horm_surg_me in (9,-9)			then horm_surg_me=.;
	horm_surg_ever_me = horm_surg_ever_c;
	if horm_surg_ever_me in (9,-9)	then horm_surg_ever_me=.;

	uvrq_me = uvrq_c;
	if	uvrq_me in (9,-9)				then uvrq_me=.;

	horm_yrs_me = horm_yrs_c;
	if	horm_yrs_me in (9,-9)			then horm_yrs_me=.;
	horm_yrs_nat_me = horm_yrs_nat_c;
	if horm_yrs_nat_me in (9,-9)		then horm_yrs_nat_me=.;
	horm_yrs_surg_me = horm_yrs_surg_c;
	if horm_yrs_surg_me in (9,-9)		then horm_yrs_surg_me=.;

	ovarystat_me = ovarystat_c;
	if ovarystat_me in (9,-9)			then ovarystat_me=.;
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
			uvrq_c = "TOMS AVGLO-UVR measures in quartiles"
			oralbc_dur_c = "birth control duration"
			oralbc_yn_c = "birth control yes/no"
			fmenstr_c = "menarche age"
			educ_c = "education level"
			flb_age_c = "Age at first live birth among parous women"
			menostat_c = "menopause status"
			menop_age_c ="age at natural menopause"
			physic_c = "level of physical activity"	
			horm_nat_c = "hormone usage, natural menopause"
			horm_surg_c = "hormone usage, surgical menopause"
			parity_c = "total number of live births"
			bmi_c = "bmi, rough"

			smoke_former_c ="Smoking Status"
			smoke_quit_c = 'Quit smoking status'
			smoke_dose_c = 'Smoking dose'
			rel_1d_cancer_c = 'Family History of Cancer'
			coffee_c = 'Coffee drinking'
			etoh_c = 'Total alchohol per day including food sources'
			colo_sig_any = "Colonoscopy or Sigmoidoscopy in past 3 years?"
			any_screen = "Colonoscopy or Sigmoidoscopy in past 3 years?"

			horm_cur = 'Current Hormone Use'
			horm_yrs_c = 'Hormone Use Duration'
			horm_yrs_nat_c = 'Hormone Use Duration, only nat meno'
			horm_yrs_surg_c = 'Hormone Use Duration, only surg meno'
			mht_ever_c = " Menopausal Hormone Therapy, ever"


			/* for riskfactor */
			rf_physic_c = "Times engaged in moderate-vigorous physical activity"
			rf_1d_cancer = "Family History of Cancer"
			rf_Q15A = "Sigmoidoscopy in past three years?"
			rf_Q15B = "Colonoscopy in past three years?"
			rf_Q15C = "Proctoscopy in past three years?"
			rf_Q15D = "Unknown colorectal procedure in past three years?"
			rf_Q15E = "No colorectal procedure in past three years?"

				/* for the MHT variables */
			l_eptcurrent_c = "Current/former EPT user"
			l_eptdose_c = "Estrogen/progestin therapy dose"
			l_eptdur_c = "Estrogen/progestin therapy duration (1st definition)"

			l_etcurrent_c = "Current/former estrogen therapy user"
			l_etdose_c = "Estrogen therapy dose"
			l_etdur_c = "Estrogen therapy only duration (1st definition)"
			l_etfreq_c = "Estrogen therapy frequency"

			lacey_sameduration = "EPT-only users - same reported dates EP?"
			lacey_samestart44 = "Classifies estrogen and progestin therapy in terms of when each was started relative to the other"
			lacey_sameyears = "EPT-only users - same reported duration EP?"

			ht_nat_c="lacey Hormone therapy type, natural meno"
			ht_surg_c="lacey Hormone therapy type, surgical meno"
			
	;
	** set variable value labels;
	format	skin_dxdt dod raadate f_dob entry_dt rf_entry_dt Date9.
			/* for outcomes */
			melanoma_c melanfmt. melanoma_agg melanomafmt. 
			melanoma_ins melanomainsfmt. melanoma_mal melanomamalfmt.

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
			hormstat_c hormstat hormstatfmt. 
			horm_yrs_c horm_yrs_me horm_yrs_nat_c horm_yrs_surg_c  horm_yrs hormyrsfmt.
			uvrq_c uvrqfmt.
			marriage  marriagefmt. marriage_c marriagecfmt.
			smoke_former_c smoke_former smokeformerfmt.
			smoke_quit smoke_quit_c smokequitfmt.
			smoke_dose smoke_dose_c smokedosefmt. 
			coffee_c coffeefmt. qp12b $qp12bfmt. etoh_c etohfmt.
			rel_1d_cancer rel_1d_cancer_c relativefmt. 

			/* for MHT & riskfactors */
			rf_phys_modvig_curr rfphysfmt.
			rf_physic_c rfphysicfmt.
			lacey_ht_type l_httype.
			ht_nat_c ht_nat_me l_httype.
			ht_nat_ever_c ht_nat_ever_me l_httypevr.
			ht_surg_c ht_surg_me l_httype.
			ht_surg_ever_c ht_surg_ever_me l_httypevr.

			l_eptcurrent_ever_c l_eptcurrent_ever_me l_eptcurrentvr.
			l_eptcurrent_c l_eptcurrent_me lacey_eptcurrent l_eptcurrent. 

			l_eptdose_c l_eptdose_me lacey_eptdose l_eptdose.
			l_eptdur_c l_eptdur_me lacey_eptdur l_eptdur.

			l_etcurrent_ever_c l_etcurrent_ever_me  l_etcurrentvr.
			l_etcurrent_c l_etcurrent_me lacey_etcurrent l_eptcurrent. 

			l_etdose_c l_etdose_me lacey_etdose l_etdose.
			l_etdur_c l_etdur_me lacey_etdur l_etdur. 
			l_etfreq_c l_etfreq_me lacey_etfreq l_etfreq.

			colo_sig_any colosigfmt. 
			rf_Q15A $rfq15afmt.
			rf_Q15B $rfq15bfmt.
			rf_Q15C $rfq15cfmt.
			rf_Q15D $rfq15dfmt. 
			rf_Q15E $rfq15efmt.
	;
run;
/******************************************************************************************/
ods html close;
ods html;
data use_r;
	set conv.melan_r;
run;

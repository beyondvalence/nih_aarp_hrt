/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
#
# creates the melanoma file with cancer, smoking,
# reproductive, hormonal, contraceptives, UVR variables
# !!!! for baseline dataset !!!!
#
# new recodes include: new BMI and imputed menopause status
# and new exclusion coding with indicator vairables
#
# uses the uv_public, out09jan14, exp05jun14 datasets
#
# Created: February 06 2015
# Updated: v20151001THU WTL
# <under git version control>
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************/

ods html close;
ods html;
options nocenter yearcutoff=1900 errors=1;
title1 'NIH-AARP UVR Melanoma Study';

libname uvr 'C:\REB\AARP_HRTandMelanoma\Data\anchovy';
libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';

filename uv_pub 'C:\REB\AARP_HRTandMelanoma\Data\anchovy\uv_public.v9x';
ods html close;
ods html;

** import the UVR with file extension v9x from the anchovy folder;
proc cimport data=uv_pub1 infile=uv_pub; 
run;
/***************************************************/
** use baseline census tract for higher resolution;
proc means data=uv_pub1;
	title "Comparing UVR exposure means";
	var exposure_jul_78_93 exposure_jul_96_05 exposure_jul_78_05;
	var exposure_net_78_93 exposure_net_96_05 exposure_net_78_05;
run;

** keep the july UVR data only;
data conv.uv_pub1;
	set uv_pub1; 
	keep	westatid
			exposure_jul_78_05;
run;

** input: first primary cancer; 
** output: analysis_use;
** uses exp05jun14, out09jan14, uv_pub1;
** baseline dataset;
* %include 'C:\REB\AARP_HRTandMelanoma\Analysis\anchovy\first.primary.analysis.include.sas';
data analysis_use;
	merge conv.exp05jun14 conv.out09jan14;
	by westatid;

	keep	westatid
			entry_dt
			f_dob
			AGECAT
			racem /* for race exclusions */
			SEX
			raadate /* date moved outside of Registry Ascertainment Area */
			entry_age
			cancer
			cancer_dxdt
			cancer_seergroup
			cancer_ss_stg /* summary stage: first cancer */
			cancer_behv /* for cancer staging */
			cancer_siterec3
			cancer_grade
			skincan
			skin_behv
			skin_dxconf
			skin_dxdt
			skin_grade
			skin_hist
			skin_tnmclinm /* clinical metastases, ex bcc, scc */
			skin_tnmclinn /* clinical nodes, ex bcc, scc */
			skin_tnmclint /* clinical tumor, ex bcc, scc */
			skin_tnmpathm /* pathologic metastases, ex bcc, scc */
			skin_tnmpathn /* pathologic nodes, ex bcc, scc */
			skin_tnmpatht /* pathologic tumor, ex bcc, scc */

			/* for self reported cancers */
			self_prostate
			self_breast
			self_colon
			self_other

			health
			renal
			DODSource
			DOD
			EDUCM
			fl_proxy /* for proxy responder exclusions */

			/* smoking */
			smoke_former
			smoke_quit
			smoke_dose
			smoke_quit_dose

			BF_COMB_SELF_CANCER
			BF_HORMEVER
			BF_HORMTYPE
			BF_SMOKE_EVER
			BF_SMOKE_FORMER

			/* estrogen & progestin with cutoff at 2002, prior to follow up questionnaire FUQ */
			DAUGH_ESTONLY_CALC_MO_2002 		/* Duration of estrogen-only pill use (in months) */
			DAUGH_ESTPRG_CALC_MO_2002 		/* Duration of combined estrogen & progestin pill use (in months)  */
			DAUGH_EST_CALC_MO_2002 			/* Duration of overall estrogen pill use (in months)  */
			DAUGH_PRGONLY_CALC_MO_2002 		/* Duration of progestin-only pill use (in months)  */
			DAUGH_PRG_CALC_MO_2002 			/* Duration of overall progestin pill use (in months)  */
			FMENSTR							/* Age at menarche */
			HORMEVER 						/* Did participant ever take female hormones pills? */
			HORMSTAT						/* Hormone Status */
			HORM_CUR						/* Currently taking replacement hormones? */
			HORM_YRS						/* Total years used replacement hormones */

			/** follow up reproductive factors 
			FUQ_ESTPRG
			FUQ_ESTPRG_BRAND
			FUQ_ESTPRG_CUR
			FUQ_ESTPRG_DUR
			FUQ_ESTPRG_STOP
			FUQ_ESTROGEN
			FUQ_EST_BRAND
			FUQ_EST_CUR
			FUQ_EST_DUR
			FUQ_EST_STOP
			FUQ_EVER_BBD
			FUQ_EVER_MAMMOGRAM
			FUQ_HORMEVER
			FUQ_HORMONES
			**/

			LACEY_NATL_MENO
			AGE_FLB					/* age at first live birth */
			LIVECHILD
			MARRIAGE
			MENOP_AGE				/* menopause age */
			MENOSTAT
			ORALBC_YRS
			PERSTOP_MENOP
			PERSTOP_NOSTOP
			PERSTOP_RADCHEM
			PERSTOP_SURG
			hyststat
			ovarystat
			rel_1d_cancer			/* family history of cancer - any 1st degree relatives ever diagnosed with cancer (nnmsc)*/

			/* add more variables here */
			BMI_CUR
			qp12b 					/* coffee drinking */
			calories 				/* calories consumed */
			Q45 					/* pipe-cigar smoking */
			Q32 					/* current physical activity */
			physic 					/* physical activity >=20 min in past 12 months */
			physic_1518				/* physical activity >=20 min in past 12 months during ages 15-18 */
			physic_work				/* physical activity at work */
			mped_a_bev 				/* total alcohol per day including food sources */
	;
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
/* check point for merging the exposure and outcome data */
** copy and save the analysis_use dataset to the converted folder;
proc copy noclone in=Work out=conv;
	select analysis_use;
run;

/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
#
# creates formats for the master model building file
# baseline
#
#
# Created: June 29 2015
# Updated: v20150818TUE WTL
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************/
libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
libname results 'C:\REB\AARP_HRTandMelanoma\Results\baseline\mht';

proc format;
	value sexfmt 0 = 'Male' 1 = 'Female';
	value melanfmt 0 = 'no melanoma' 1 = 'in situ' 2 = 'malignant';
	value melanomafmt 0 = 'no melanoma' 1 = 'melanoma';
	value melanomainsfmt 0 = 'no melanoma' 1='melanoma in situ';
	value melanomamalfmt 0 = 'no melanoma' 1='malignant melanoma';

	value agecatfmt 1 = '50-55 years' 2 = '55-59 years' 3 = '60-64 years' 4 = '65-69 years' 5 = '>=70 years';
	value birthcohortfmt 1='1925-1928' 2='1929-1931' 3='1932-1934' 4='1935-1938' 5='1939-1945';
	value attainedagefmt -9='missing' 0='>=50 to <55' 1='>=55 to <60' 2='>=60 to <65' 3='>=65 to <70' 4='70+';
	value racefmt -9='missing' 0='non-Hispanic white' 1='non-Hispanic black' 2='Hispanic, Asian, PI, AIAN';
	value educfmt -9='missing' 0='Less than high school' 1='High school graduate' 2='some college' 3='college or graduate school';
	value educmfmt -9='missing' 1='Less than high school' 2='High school graduate' 3='Post high school' 4='Some college' 5='College or post graduate' 9='Unknown';
	value bmifmt -9='missing' 1='< 25' 2='25 to < 30' 3='>=30';
	value bminewfmt -9='missing or extreme' 1='18.5 to <25' 2='25 to <30' 3='30 to <60';
	value physicfmt -9='missing' 0='Never/rarely' 1='1-3 per month' 2='1-2 per week' 3='3-4 per week' 4='5+ per week';
	value smokingfmt -9='missing' 0='never smoked' 1='ever smoke';
	value marriagefmt 1='married' 2='widowed' 3='divorced/separated' 5='never married' 9='unknown';

	** fmenstr, menopause status recoded 20150721WTL;
	value fmenstrfmt -9='missing' 0='10>=' 1='11-12' 2='13-14' 3='15+';
	value menostatfmt -9='missing' 9='pre-menopausal' 1='natural menopause' 2='surgical/hyst menopause'
						3='radiation or chemotherapy' 4='other reason';
	value menopagefmt 9='missing' 1='<45' 2='45-49' 3='50-54' 4='>=55' 5='still menstruating';
	value menopiagefmt 9='missing' 1='<45' 2='45-49' 3='50+' 5='still menstruating';
	value menoagefmt -9='missing' 1='<50' 2='50-54' 3='55+' 4='periods did not stop';
	value surgagefmt -9='missing' 1='<45' 2='45-49' 3='50+' 4='periods did not stop';
	value flbagefmt -9='missing' 1='< 20 years old' 2='20s' 3='30s' 9='nulliparous/missing parity';
	value parityfmt -9='missing' 0='Nulliparous' 1='1-2 live children' 2='>=3 live children';
	value hormstatfmt -9='missing' 0='Never' 1='Current' 2='Former' 9='Unknown';
	value hormeverfmt -9='missing' 0='Never' 1='Ever';
	value hormcurfmt 9='missing' 0='No' 1='Yes currently';
	value hormyrsfmt -9='missing' 0='Never used' 1='1. <5 years' 2='2. 5-9 years' 3='3. >=10 years';
	value oralbcdurfmt -9='missing' 0='Never/<1yr' 1='1-4 years' 2='5-9 years' 3='10+ years';
	value oralbcynfmt -9='missing' 0='Never/<1yr' 1='ever';
	value uvrqfmt -9='missing' 1='0 to 186.918' 2='186.918 to 239.642' 3='239.642 to 253.731' 
					4='253.731 to 289.463';
	value rphysicfmt -9='missing' 1='Rarely' 2='<1 hour/week' 3='1-3 hours/week' 4='4-7 hours/week' 5='>7 hours/week';
	value relativefmt 9='Unknown' 0='No' 1='Yes' -9='missing';

	** menopause reason edit 20150723THU WTL;
	value menoreasonfmt 3='rad/chem meno reason' 2='surgical meno reason' 1='natural meno reason'
						0='periods did not stop';
	value natmenofmt -9='missing' 0='periods did not stop' 1='natural meno reason';
	value surgmenofmt -9='missing' 0='periods did not stop' 1='surgical meno reason';
	value radchemmenofmt -9='missing' 0='periods did not stop' 1='radchem meno reason';
	value ovarystatfmt -9='missing' 1='both removed' 2='both intact';
	value mhteverfmt -9='missing' 0='never' 1='ever';
	value postmenofmt 99='not postmeno' 1='postmeno1' 2='postmeno2' 3='postmeno3' 4='postmeno4' 5='postmeno5';

	** smoking;
	value smokeformerfmt -9='missing' 0='never smoked' 1='former smoker' 2='current smoker' 9='Unknown';
	value smokequitfmt -9='missing' 0='never smoked' 1='stopped 10+ years ago' 2='stopped 5-9 years ago'
						3='stopped 1-4 years ago' 4='stopped within last year' 5='currently smoking'
						9='Unknown';
	value smokedosefmt -9='missing' 0='never smoked' 1='1-10 cigs a day' 2='11-20 cigs a day' 
						3='21-30 cigs a day' 4='31-40 cigs a day' 5='41-60 cigs a day' 
						6='61+ cigs a day' 9='Unknown';
	value smokequitdosefmt -9='missing' 0='never smoked' 1='quit, <=20 cigs/day' 2='quit, >20 cigs/day'
							3='currently smoking, <=20 cigs/day' 4='currently smoking, >20 cigs/day';
	value coffeefmt -9='missing' 0='none' 1='<=1 cup/day' 2='2-3 cups/day' 3='>=4 cups/day';
	value etohfmt -9='missing' 0='none' 1='<=1' 2='>1 and <=3' 3='>3';
	value colosigfmt 1 = 'Yes' 0 = 'No' -9='Missing';
	value l_sameyear 1 = 'Yes' 0 = 'No' -9='Missing';
run;


**************************;
***** Start2 here ********;
**************************;
** uses the pre-created analysis_use from above checkpoint;
ods _all_ close; ods html;
data melan; ** name the output of the first primary analysis include to melan;
	title;
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
/*proc freq data=conv.melan;
	table cancer_siterec3*sex;
	table cancer_siterec3*cancer_seergroup /nopercent norow nocol;
run;
*/
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

/***************************************************************************************/ 
/*   Exclude unknown menopausal statuses, menostat = 9?
/*	 Exclusions Edit: 20150828FRI WTL
/*   Do not use, will be captured by the postmeno inclusions (Lisa) 20150831MON;
/***************************************************************************************/ 
/*
data conv.melan excl_unkmenostat; 
	set conv.melan; 
	if menostat=9
		then output excl_unkmenostat;
	else output conv.melan;
run; 
*/

/** find the cutoffs for the percentiles of UVR- exposure_jul_78_05 mped_a_bev;
proc univariate data=conv.melan;
	var F_DOB;  dob_year; dob_year;exposure_jul_78_05;
	output 	out=siriusblack
			pctlpts= 10 20 25 30 40 50 60 70 75 80 90 
			pctlpre=p;
run;*/
*proc print data=siriusblack; 
	*title 'uvr exposure percentiles';
	*title 'DOB exposure percentiles';
*run; 

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
data conv.melan excl_radchem;
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
	if      0       < exposure_jul_78_05 <= 186.918 	then UVRQ=1;
	else if 186.918 < exposure_jul_78_05 <= 239.642 	then UVRQ=2;
	else if 239.642 < exposure_jul_78_05 <= 253.731		then UVRQ=3;
	else if 253.731 < exposure_jul_78_05           		then UVRQ=4;
	else UVRQ=-9;

	** physical exercise cat;
	physic_c=.;
	if      physic in (0,1)					then physic_c=0; /* rarely */
	else if physic=2 	 					then physic_c=1; /* 1-3 per month */
	else if physic=3 	 					then physic_c=2; /* 1-2 per week */
	else if physic=4     					then physic_c=3; /* 3-4 per week */
	else if physic=5     					then physic_c=4; /* 5+ per week */
	else if physic=9	 					then physic_c=-9; /* missing */

	** physical exercise ages 15..18 cat;
	physic_1518_c=.;
	if      physic_1518 in (0,1)			then physic_1518_c=0; /* rarely */
	else if physic_1518=2	 	 			then physic_1518_c=1; /* 1-3 per month */
	else if physic_1518=3 		 			then physic_1518_c=2; /* 1-2 per week */
	else if physic_1518=4   	  			then physic_1518_c=3; /* 3-4 per week */
	else if physic_1518=5	     			then physic_1518_c=4; /* 5+ per week */
	else if physic_1518=9		 			then physic_1518_c=-9; /* missing */

	** oral contraceptive duration cat;
	oralbc_dur_c=.;
	if      oralbc_yrs=0					then oralbc_dur_c=0; /* none */
	else if oralbc_yrs=1					then oralbc_dur_c=1; /* 1-4 years */
	else if oralbc_yrs=2					then oralbc_dur_c=2; /* 5-9 years */
	else if oralbc_yrs=3 					then oralbc_dur_c=3; /* 10+ years */
	else if oralbc_yrs in (8,9)				then oralbc_dur_c=-9; /* missing */

	** oral contraceptive yes/no;
	oralbc_yn_c=.;
	if      oralbc_yrs=0 					then oralbc_yn_c=0; /* no oc */
	else if 0<oralbc_yrs<8					then oralbc_yn_c=1; /* yes oc */
	else if oralbc_yrs>7					then oralbc_yn_c=-9; /* missing */

	** age at menarche cat, for clearance;
	if      fmenstr=1						then fmenstr_c=0; /* <=10 years old */
	else if fmenstr=2						then fmenstr_c=1; /* 11-12 years old */
	else if fmenstr=3						then fmenstr_c=2; /* 13-14 years old */
	else if fmenstr=4						then fmenstr_c=3; /* 15+ years old */
	else if fmenstr>4						then fmenstr_c=-9; /* missing */	

	** age at menarche cat;
	if      fmenstr=1						then fmenstr=0; /* <=10 years old */
	else if fmenstr=2						then fmenstr=1; /* 11-12 years old */
	else if fmenstr=3						then fmenstr=2; /* 13-14 years old */
	else if fmenstr=4						then fmenstr=3; /* 15+ years old */
	else if fmenstr>4						then fmenstr=-9; /* missing */

	** education cat;
	educ_c=.;
	if 		educm=1 						then educ_c=0; /* less highschool */
	else if educm=2							then educ_c=1; /* highschool grad */
	else if educm in (3,4)					then educ_c=2; /* some college */
	else if educm=5							then educ_c=3; /* college and grad */
	else if educm=9							then educ_c=-9; /* missing */

	** race cat;
	race_c=.;
	if      racem=1							then race_c=0; /* non hispanic white */
	else if racem=2							then race_c=1; /* non hispanic black */
	else if racem in (3,4) 					then race_c=2; /* hispanic, asian PI AIAN */
	else if racem=9							then race_c=-9; /* missing */

	** age at first live birth cat;
	flb_age_c=9;
	if 		age_flb in (1,2)				then flb_age_c=1; /* < 20 years old */
	else if age_flb in (3,4)				then flb_age_c=2; /* 20s */
	else if age_flb in (5,6,7)				then flb_age_c=3; /* 30s+ */
	else if age_flb in (8,9)				then flb_age_c=-9; /* missing */
	else if age_flb in (0)					then flb_age_c=9; /* nulliparous */
	else	flb_age_c=.;

	** menopause reason, 20150901 edit;
	** 1 natural, 2 surgical;
	menostat_c=.;
	if		perstop_surg=1 | hyststat=1 | ovarystat=1		then menostat_c=2; /* surgical */
	else if	perstop_menop=1									then menostat_c=1; /* natural */

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

	** ovary status, 20150901TUE edit;
	** revise ovarystat with new menopause recoding, no need for menostat;
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

	** hormonal status cat, 20150708WED edit;
	*** natural meno;
	horm_nat_c=.;
	if      hormstat=0 & menostat_c=1		then horm_nat_c=0; /* never hormones */
	else if hormstat=1 & menostat_c=1		then horm_nat_c=1; /* current */
	else if hormstat=2 & menostat_c=1		then horm_nat_c=2; /* former */
	else if menostat_c NE 1					then horm_nat_c=.;
	else 	horm_nat_c=-9; 									   /* missing */
	
	*** natural meno, ever horm;
	horm_nat_ever_c=horm_nat_c;
	if horm_nat_c=2							then horm_nat_ever_c=1; /* yes hormones */

	*** surgical/hyst meno;
	horm_surg_c=.;
	if      hormstat=0 & menostat_c=2		then horm_surg_c=0; /* never hormones */
	else if hormstat=1 & menostat_c=2		then horm_surg_c=1; /* current */
	else if hormstat=2 & menostat_c=2		then horm_surg_c=2; /* former */
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
	** bmi_c new categories;
	** use this new one, (like Sara), edit 20150825TUE WTL;
	if      18.5<bmi_cur<25 				then bmi_c=1; /* 18.5 up to 25 */
   	else if 25<=bmi_cur<30 					then bmi_c=2; /* 25 up to 30 */
   	else if 30<=bmi_cur<60 					then bmi_c=3; /* 30 up to 60 */
	else 										 bmi_c=-9; /* missing or extreme */

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
	if smoke_quit=9 						then smoke_quit=-9;
	if smoke_dose=9							then smoke_dose=-9;
	if smoke_quit_dose=9					then smoke_quit_dose=-9;

	** attained age cat;
	if 		50<=exit_age<55					then attained_age=0;  
	else if 55<=exit_age<60					then attained_age=1;
	else if 60<=exit_age<65					then attained_age=2;
	else if 65<=exit_age<70					then attained_age=3;
	else if 70<=exit_age					then attained_age=4;
	else 	attained_age=-9;								/* missing */

	** marriage;
	if marriage in (3,4)					then marriage=3;

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

/* for riskfactor */
run;

/***************************************************************************************/ 
/*   Exclude if person-years <= 0                                                      */
**   exclude: excl_5_pyzero;
**   edit: 20150901TUE WTL;
/***************************************************************************************/      
data conv.melan;
	title 'Ex 5. exclude women with zero or less person years, excl_5_pyzero';
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
			bmi_c = "body mass index, with extremes"
			stage_c = "stage of first primary cancer"
			physic_1518_c = "level of physical activity at ages 15-18 (base)"
			marriage = "marriage status"
			postmeno = "Postmenopausal status"

			smoke_f_c = "ever smoking status"
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


			/* for riskfactor */
	;
	** set variable value labels;
	format	/* for outcomes */
			melanoma_c melanfmt. melanoma_agg melanomafmt. melanoma_ins melanomainsfmt. 
			melanoma_mal melanomamalfmt.

			/* for baseline*/
			uvrq_me uvrqfmt. oralbc_dur_c_me oralbcdurfmt. educ_c_me educfmt. race_c_me racefmt. 
			hormever hormeverfmt. attained_age_me attainedagefmt. marriage marriagefmt.
			birth_cohort_me birthcohortfmt. flb_age_c_me flbagefmt. fmenstr_me fmenstrfmt. 
			meno_age_c_me menoagefmt. menostat_c_me menostatfmt. surg_age_c_me surgagefmt.
			physic_c physic_c_me physicfmt. 
			horm_nat_c_me horm_surg_c_me horm_ever_me hormstatfmt. parity_me parityfmt. 
			horm_cur_me hormcurfmt. horm_yrs_me hormyrsfmt.
			bmi_c_me bminewfmt. agecat_me agecatfmt.
			smoke_former_me smokeformerfmt. 
			rel_1d_cancer_me relativefmt. coffee_c_me coffeefmt. etoh_c_me etohfmt.
			ovarystat_c_me ovarystatfmt. oralbc_yn_c_me oralbcynfmt.
			horm_nat_ever_me horm_surg_ever_me hormeverfmt.

			uvrq uvrqfmt. oralbc_dur_c oralbcdurfmt. educ_c educfmt. race_c racefmt. 
			hormever hormeverfmt. attained_age attainedagefmt. marriage marriagefmt.
			birth_cohort birthcohortfmt. flb_age_c flbagefmt. fmenstr fmenstrfmt. 
			meno_age_c menoagefmt. menostat_c menostatfmt. surg_age_c surgagefmt.
			physic_c physic_c physicfmt. 
			hormstat horm_ever horm_ever_me horm_nat_c horm_surg_c hormstatfmt. parity parityfmt. 
			horm_cur hormcurfmt. 
			horm_yrs_c horm_yrs_me horm_yrs_nat_c horm_yrs_surg_c horm_yrs_nat_me horm_yrs_surg_me hormyrsfmt.
			bmi_c bminewfmt. agecat agecatfmt.
			smoke_former smokeformerfmt. smoke_dose smokedosefmt. smoke_quit smokequitfmt.
			rel_1d_cancer relativefmt. coffee_c coffeefmt. etoh_c etohfmt.
			ovarystat_c ovarystatfmt. oralbc_yn_c oralbcynfmt.
			horm_nat_ever_c horm_surg_ever_c hormeverfmt.
			colo_sig_any colosigfmt.
			menop_age menop_age_me menopagefmt.
			mht_ever mht_ever_me mhteverfmt.
			menopi_age menopi_age_me menopiagefmt.
			postmeno postmenofmt.
	;
run;
/******************************************************************************************/
data use;
	set conv.melan;
run;

** check the contents of the created melan other;
proc contents data=conv.melan;
	title 'melanoma content';
run;

proc freq data=conv.melan;
	table horm_yrs_me*melanoma_c /missing;
run;

** check that the melanoma cases were properly created;
proc freq data=conv.melan;
	title 'melanoma frequencies';
	table cancer_siterec3*melanoma_c /nopercent norow nocol;
	table cancer_seergroup /nopercent norow nocol;
	table agecat UVRQ birth_cohort UVRQ*birth_cohort UVRQ*agecat /nopercent norow;
	table melanoma_c*sex /nopercent norow; * verify only females;
run;

** check the repro and hormone vars ;
proc freq data=conv.melan;
	title 'hormone frequencies';
	*table DAUGH_ESTONLY_CALC_MO_2002 DAUGH_ESTPRG_CALC_MO_2002 DAUGH_EST_CALC_MO_2002 
	DAUGH_PRGONLY_CALC_MO_2002 DAUGH_PRG_CALC_MO_2002;
	table FMENSTR HORMEVER*HORMSTAT melanoma_c*HORM_CUR melanoma_c*HORMSTAT HORM_YRS;
run;

** check coffee and alcohol variables;
ods html close;
ods html;
proc freq data=conv.melan;
	title 'coffee, alchohol, meno_age, surg_age_c, attained age';
	table coffee_c etoh_c meno_age_c surg_age_c attained_age smoke_former birth_cohort;
run;

proc freq data=melan;
	title 'checking main effect coding';
	table surg_age_c*surg_age_c_me rel_1d_cancer*rel_1d_cancer_me bmi_c*bmi_c_me;
run;
** check new natural and surgical menopause reason variables, 20150512 edit;
proc freq data=conv.melan;
	table meno_age_c*nat_meno_reason 
			surg_age_c*surg_meno_reason /missing;
run;

proc freq data=conv.melan;
	table meno_reason nat_meno_reason 
			surg_meno_reason radchem_meno_reason 
			meno_age_c surg_age_c /missing;
run;
ods html close;
/*****************************************************
#
#
proc phreg data=conv.melan;
	title 'melanoma HR with UVR quintiles';
	class agecat(ref='1') UVRQ(ref='1');
	model (entry_age, exit_age)*melan_case(0) = agecat UVRQ /rl;

run;
*****************************************************/

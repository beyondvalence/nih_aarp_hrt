/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
#
# creates the merged set from outcomes and exposure IMS sets
# !!!! for baseline dataset !!!!
#
# uses the uv_public, exp23feb16 out25mar16 datasets
#
# Created: February 06 2015
# Updated: v20160617FRI WTL
# <under git version control>
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************/

ods html close;
ods html;
options nocenter yearcutoff=1900 errors=1;
title1 'NIH-AARP UVR Melanoma Study';

libname anchovy 'C:\REB\AARP_HRTandMelanoma\Data\anchovy';
libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';

filename uv_pub 'C:\REB\AARP_HRTandMelanoma\Data\anchovy\uv_public.v9x';
ods html;

** import the UVR with file extension v9x from the anchovy folder;
proc cimport data=uv_pub1 infile=uv_pub; 
run;
/***************************************************/
** use baseline census tract for higher resolution;
proc means data=uv_pub1;
	title2 "Comparing UVR exposure means";
	var exposure_jul_78_93 exposure_jul_96_05 exposure_jul_78_05;
	var exposure_net_78_93 exposure_net_96_05 exposure_net_78_05;
run;

** keep the july UVR data only;
data conv.uv_pub1;
	set uv_pub1; 
	keep	westatid
			exposure_jul_78_05;
run;

** input: exp23feb16, out25mar16; 
** output: analysis_use;
** baseline dataset;
* %include 'C:\REB\AARP_HRTandMelanoma\Analysis\anchovy\first.primary.analysis.include.sas';
title2 'merge exp23feb16 and out25mar16 to analysis_use';
data analysis_use;
	merge anchovy.exp23feb16 anchovy.out25mar16;
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

			QP2B1					/* freq: orange juice or grapefruit juice */
			f_orangjce				/* freq/day [0..7], orange or grapefruit juice */
			QP2B2					/* size: orange juice or grapefruit juice */
			g_orangjce				/* grams/day [0..3238.6] orange or grapefruit juice */
	;
run;

/* check point for merging the exposure and outcome data */
** copy and save the analysis_use dataset to the converted folder for variable creation;
proc copy noclone in=Work out=conv;
	select analysis_use;
run;
title;

/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
#
# creates the melanoma file with cancer, smoking,
# reproductive, hormonal, contraceptives, UVR variables
# !!!! for risk factors dataset !!!!!
#
# uses the uv_public, rout25mar16, rexp23feb16 datasets
# note: using new rexp dataset above
#
# Created: April 03 2015
# Updated: v20160505THU WTL
# <under git version control>
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************/

ods html close;
ods html;
options nocenter yearcutoff=1900 errors=1;
title1 'NIH-AARP UVR Melanoma Study _riskfactor';

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
libname anchovy 'C:\REB\AARP_HRTandMelanoma\Data\anchovy';

filename uv_pub 'C:\REB\AARP_HRTandMelanoma\Data\anchovy\uv_public.v9x';

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
ods html close;
ods html;
** input: first primary cancer _risk; 
** output: ranalysis;
** riskfactor dataset;
* %include 'C:\REB\AARP_HRTandMelanoma\Analysis\anchovy\first.primary.analysis.risk.include.sas';
data ranalysis;
  merge anchovy.rout25mar16 (in=ino)
        anchovy.rexp23feb16 (in=ine);
  by westatid;
  keep		westatid
			rf_entry_dt
			rf_entry_age
			f_dob
			AGECAT
			racem /* for race exclusions */
			SEX
			raadate /* date moved outside of Registry Ascertainment Area */
			entry_age
			entry_dt
			cancer
			cancer_dxdt
			cancer_seergroup
			cancer_ss_stg /* summary stage: first cancer */
			cancer_behv /* for cancer staging */
			cancer_siterec3
			cancer_grade
			skincan
			skin_dxdt

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
			PERSTOP_SURG			/* surgical menopause? */
			hyststat
			ovarystat
			rel_1d_cancer			/* family history of cancer - any 1st degree relatives ever diagnosed with cancer (nnmsc)*/


			/* add more variables here */
			BMI_CUR					/* current bmi kg/m2 */
			qp12b 					/* coffee drinking */
			calories 				/* calories consumed */
			Q45 					/* pipe-cigar smoking */
			Q32 					/* current physical activity */
			physic 					/* physical activity >=20 min in past 12 months */
			physic_1518				/* physical activity >=20 min in past 12 months during ages 15-18 */
			mped_a_bev 				/* total alcohol per day including food sources */

		/******** riskfactor characteristics variables ********/
			rf_agecat
			rf_phys_modvig_15_18
			rf_phys_modvig_curr
			rf_1d_cancer
			/* necessary for exclusions */
			fl_rf_proxy
			rf_q23_2_1a
			rf_q23_2_2a

			/** Lacey hormone variables ******/
			lacey_afterRFQ
			lacey_eptcurdur 				/* +/- 5 yrs */
			lacey_eptcurdur2				/* +/- 10 yrs */
			lacey_eptcurrent
			lacey_eptdose
			lacey_eptdur
			lacey_eptreg
			lacey_eptregdose
			lacey_eptregyrs
			lacey_eptType
			lacey_est_vs_prg
			lacey_et_ept_et

			lacey_etcurdur
			lacey_etcurrent
			lacey_etdose
			lacey_etdur
			lacey_etfreq
			lacey_etType
			lacey_fl_dosereg
			lacey_ht_formulation
			lacey_ht_type

			lacey_sameDuration
			lacey_samestart44
			lacey_sameyears

			rf_Q15A					/* flexible sigmoidoscopy */
			rf_Q15B					/* colonoscopy */
			rf_Q15C					/* proctoscopy */
			rf_Q15D					/* yes, type unknown */
			rf_Q15E					/* no */


			RF_HORMTYPE
			
			RF_ESTROGEN						/* est ever y/n */
			RF_EST_CUR						/* est current y/n *
			RF_EST_DUR						/* est years taken *
			RF_EST_CALC_MO					/* est overall duration taken *
			RF_ESTONLY_CALC_MO 				/* est only overall duration taken */
			RF_EST_DOSE						/* est dose taken *
			RF_EST_FREQ						/* est frequency taken *
			RF_EST_DATEFLAG					/* est start and stop date (intact) indicator *
			RF_EST_START_DT RF_EST_STOP_DT 	/* est start and end dates *

			RF_ESTPRG_CALC_MO  				/* est&prog overall duration taken */

			RF_PROGESTIN					/* prog ever y/n */
			RF_PRG_CUR						/* prog current y/n *
			RF_PRG_DUR						/* prog years taken *
			RF_PRG_CALC_MO					/* prog overall duration taken *
			RF_PRGONLY_CALC_MO  			/* prog only overall duration taken *
			RF_PRG_DOSE						/* prog dose taken *
			RF_PRG_FREQ						/* prog frequency taken *
			RF_PRG_DATEFLAG   				/* prog start and stop date (intact) indicator *
			RF_PRG_START_DT RF_PRG_STOP_DT 	/* prog start and end dates */
	;
	format skin_dxdt dod raadate f_dob entry_dt rf_entry_dt Date9.;
run;


/* check point for merging the exposure and outcome data */
** copy and save the analysis_use dataset to the converted folder;
proc copy noclone in=Work out=conv;
	select ranalysis;
run;
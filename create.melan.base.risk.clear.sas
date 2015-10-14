** Creates uv_pub1 (exposure_jul_78_05) dataset, analysis_use, and ranalysis;
** for baseline and riskfactor datasets;
** this script pulls only certain variables from the exposure and outcome datasets (faster);
** modify PATHS and run first, prior to the other scripts,
** (which create the final melan and melan_r datasets);

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
filename uv_pub 'C:\REB\AARP_HRTandMelanoma\Data\anchovy\uv_public.v9x';


** import the UVR with file extension v9x from the anchovy folder;
proc cimport data=uv_pub1 infile=uv_pub; 
run;
data conv.uv_pub1;
	set uv_pub1; 
	keep	westatid
			exposure_jul_78_05;
run;
** input: first primary cancer; 
** output: analysis_use;
** uses exp05jun14, out09jan14, uv_pub1;
** creates baseline dataset;
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

/*****************************************************************************/

data ranalysis;
  merge conv.rout09jan14 (in=ino)
        conv.rexp05jun14 (in=ine);
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
			RF_ESTONLY_CALC_MO 				/* est only overall duration taken *
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

** create exit dates, exit ages, person years and rf_person years;
** and recode coffee drinking;
data ranalysis;
	set ranalysis;
	****  Create exit date, exit age, and person years for First Primary Cancer;
	** with first primary cancer as skin cancer;
	* Chooses the earliest of 4 possible exit dates for skin cancer;
  	exit_dt = min(mdy(12,31,2006), skin_dxdt, dod, raadate); 
  	exit_age = round(((exit_dt-f_dob)/365.25),.001);
  	personyrs = round(((exit_dt-entry_dt)/365.25),.001);
	rf_personyrs = round(((exit_dt-rf_entry_dt)/365.25),.001);
	
	** coffee drinking;
	coffee_c=.;
	
	if		qp12b='0'							then coffee_c=0; 	/* none */
	else if qp12b in ('1','2','3','4','5','6')	then coffee_c=1; 	/* <=1/day */
	else if qp12b='7'							then coffee_c=2; 	/* 2-3/day */
	else if qp12b in ('8','9')					then coffee_c=3; 	/* >=4/day */
	else if qp12b='M' or qp12b='E'				then coffee_c=-9;	/* missing */
	else	coffee_c=-9; 											/* missing */
	
	format exit_dt Date9.;

	label 	exit_dt="Exit Date"
			exit_age="Exit Age"
			personyrs="Person Years from Baseline"
			rf_personyrs="Person Years from Riskfactor";
run;
/* check point for merging the exposure and outcome data */
** copy and save the analysis_use dataset to the converted folder;
proc copy noclone in=Work out=conv;
	select ranalysis;
run;

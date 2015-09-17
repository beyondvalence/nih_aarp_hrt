/*****************************************************************************;
#             NIH-AARP UVR- Reproductive Factors- Melanoma Study
******************************************************************************;
#
# Model Building A v1:
# = ME
# !!!! for both baseline and riskfactor datasets !!!!
#
# uses the conv.melan, conv.melan_r datasets
#
# Created: June 26 2015 WTL
# Updated: v20150630 WTL
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************/

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
libname results 'C:\REB\AARP_HRTandMelanoma\Results';

******************************************************************************;
** Analysis of Model A
** in situ and malignant melanoma
** Includes: ME

****** ME baseline: 		
****01 flb_age_c			flb_age_c_me (ref='< 20 years old') 
****02 horm_ever			horm_ever_me (ref='never')
****03 parity				parity_me (ref='1-2 live children')
****04 fmenstr				fmenstr_me (ref='<=10')
****05 oralbc_dur_c			oralbc_dur_c_me (ref='none')
****06 menostat_c 			menostat_c_me (ref='pre-menopausal')
****07 meno_age_c			meno_age_c_me (ref='50-54')
****08 surg_age_c			surg_age_c_me (ref='50-54')

****** ME riskfactor:
****01 lacey_eptcurrent		lacey_eptcurrent_me (ref='No HT')
****02 lacey_eptdur			lacey_eptdur_me (ref='No HT')
****03 lacey_eptdose		lacey_eptdose_me (ref='No HT')

****04 lacey_etcurrent		lacey_etcurrent_me (ref='No HT')
****05 lacey_etdur			lacey_etdur_me (ref='No HT')
****06 lacey_etdose			lacey_etdose_me (ref='No HT')

****07 flb_age_c			flb_age_c_me (ref='< 20 years old')
****08 parity				parity_me (ref='1-2 live children')
****09 fmenstr				fmenstr_me (ref='<=10')
****10 oralbc_dur_c			oralbc_dur_c_me (ref='none')
****11 menostat_c			menostat_c_me (ref='pre-menopausal')
****12 meno_age_c			meno_age_c_me (ref='50-54')
****13 surg_age_c			surg_age_c_me (ref='50-54')

Finished to: R13
Working on: ---
******************************************************************************;

ods _all_ close;
ods html;
******************************************************************************;
******************************************************************************;
************************** BASELINE ******************************************;
******************************************************************************;
******************************************************************************;
data use;
	set conv.melan;
run;

******************************************************************************;
********************************************************************************;
** B01i
** ME: flb_age_c, 
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, _ins';
	title2 'Exposure: flb_age_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class flb_age_c_me (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= flb_age_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='flb_age_c_me';
	variable="MainE_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=flb_age_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='flb_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=flb_age_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='flb_age_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=flb_age_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=flb_age_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=flb_age_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='flb_age_c_me';
	variable="fmenstr";
run;

/** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=flb_age_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;
**/
** oral bc duration;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=flb_age_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='flb_age_c_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=flb_age_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='flb_age_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=flb_age_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=flb_age_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=flb_age_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=flb_age_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='flb_age_c_me';
	variable="marriage";
run;

** hormever;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			horm_ever (ref='never') ;
	model exit_age*melanoma_ins(0)=flb_age_c_me horm_ever
			/ entry = entry_age RL;
	ods output ParameterEstimates=hormever;
run;
data hormever; set hormever;
	if Parameter='flb_age_c_me';
	variable="hormever";
run;

** uvrq;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='flb_age_c_me';
	variable="uvrq";
run;

ods _all_ close;ods html;

*Combine and output to excel;
data base_flb_ins_A; 
	set 
		crude
		physic_c hormever
		parity  
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c marriage smoke_former fmenstr ; 
		* flb_age_c;
run;
data base_flb_ins_A; 
	set base_flb_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelA\base_flb_ins_A.xls' style=minimal;
proc print data= base_flb_ins_A; run;
ods _all_ close;ods html;

******************************************************************************;
********************************************************************************;
** B01m
** ME: flb_age_c, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, _mal';
	title2 'Exposure: flb_age_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class flb_age_c_me (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= flb_age_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='flb_age_c_me';
	variable="MainE_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=flb_age_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='flb_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=flb_age_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='flb_age_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=flb_age_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=flb_age_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=flb_age_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='flb_age_c_me';
	variable="fmenstr";
run;

/** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=flb_age_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;
**/

** oral bc duration;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=flb_age_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='flb_age_c_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=flb_age_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='flb_age_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=flb_age_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=flb_age_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=flb_age_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') marriage (ref='married');
	model exit_age*melanoma_mal(0)=flb_age_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='flb_age_c_me';
	variable="marriage";
run;

** hormever;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			horm_ever (ref='never') ;
	model exit_age*melanoma_mal(0)=flb_age_c_me horm_ever
			/ entry = entry_age RL;
	ods output ParameterEstimates=hormever;
run;
data hormever; set hormever;
	if Parameter='flb_age_c_me';
	variable="hormever";
run;

** uvrq;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='flb_age_c_me';
	variable="uvrq";
run;

ods _all_ close;ods html;

*Combine and output to excel;
data base_flb_mal_A; 
	set 
		crude
		physic_c 
		parity 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr hormever; 
		* flb_age_c;
run;
data base_flb_mal_A; 
	set base_flb_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelA\base_flb_mal_A.xls' style=minimal;
proc print data= base_flb_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** B02i
** ME: horm_ever, 
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, _ins';
	title2 'Exposure: horm_ever_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class horm_ever_me  (ref='never');
	model exit_age*melanoma_ins(0)= horm_ever_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='horm_ever_me';
	variable="MainE_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=horm_ever_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='horm_ever_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=horm_ever_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='horm_ever_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=horm_ever_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=horm_ever_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=horm_ever_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=horm_ever_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=horm_ever_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='horm_ever_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=horm_ever_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=horm_ever_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=horm_ever_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=horm_ever_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=horm_ever_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
	variable="marriage";
run;

/** hormever;
proc phreg data = use multipass;
	class horm_ever_me (ref='never') 
		horm_ever (ref='never');
	model exit_age*melanoma_ins(0)=horm_ever_me horm_ever
			/ entry = entry_age RL;
	ods output ParameterEstimates=hormever;
run;
data hormever; set hormever;
	if Parameter='horm_ever_me';
	variable="hormever";
run;
**/

** uvrq;
proc phreg data = use multipass;
	class horm_ever_me (ref='never') 
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='horm_ever_me';
	variable="uvrq";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data base_hormever_ins_A; 
	set 
		crude
		physic_c 
		parity flb_age_c 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr ; 
		* hormever;
run;
data base_hormever_ins_A; 
	set base_hormever_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelA\base_hormever_ins_A.xls' style=minimal;
proc print data= base_hormever_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** B02m
** ME: horm_ever, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, _mal';
	title2 'Exposure: horm_ever_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class horm_ever_me  (ref='never');
	model exit_age*melanoma_mal(0)= horm_ever_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='horm_ever_me';
	variable="MainE_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=horm_ever_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='horm_ever_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=horm_ever_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='horm_ever_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=horm_ever_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=horm_ever_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=horm_ever_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=horm_ever_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=horm_ever_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='horm_ever_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=horm_ever_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=horm_ever_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=horm_ever_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=horm_ever_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=horm_ever_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
	variable="marriage";
run;


/** hormever;
proc phreg data = use multipass;
	class horm_ever_me (ref='never') 
			horm_ever (ref='never');
	model exit_age*melanoma_mal(0)=horm_ever_me horm_ever
			/ entry = entry_age RL;
	ods output ParameterEstimates=hormever;
run;
data hormever; set hormever;
	if Parameter='horm_ever_me';
	variable="hormever";
run;
**/

** uvrq;
proc phreg data = use multipass;
	class horm_ever_me (ref='never') 
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='horm_ever_me';
	variable="uvrq";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data base_hormever_mal_A; 
	set 
		crude
		physic_c 
		parity flb_age_c 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr ; 
		* hormever;
run;
data base_hormever_mal_A; 
	set base_hormever_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelA\base_hormever_mal_A.xls' style=minimal;
proc print data= base_hormever_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** B03i
** ME: parity_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, _ins';
	title2 'Exposure: parity_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class parity_me (ref='1-2 live children');
	model exit_age*melanoma_ins(0)= parity_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='parity_me';
	variable="MainE_parity_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=parity_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='parity_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=parity_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='parity_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=parity_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='parity_me';
	variable="physic_c";
run;

/** parity;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=parity_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='parity_me';
	variable="parity";
run;
**/
** age at menarche;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=parity_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='parity_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=parity_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='parity_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=parity_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='parity_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=parity_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='parity_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=parity_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='parity_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=parity_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='parity_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=parity_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='parity_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=parity_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='parity_me';
	variable="marriage";
run;

** hormever;
proc phreg data = use multipass;
	class parity_me (ref='never') 
		horm_ever (ref='never') ;
	model exit_age*melanoma_ins(0)=parity_me horm_ever
			/ entry = entry_age RL;
	ods output ParameterEstimates=hormever;
run;
data hormever; set hormever;
	if Parameter='parity_me';
	variable="hormever";
run;

** uvrq;
proc phreg data = use multipass;
	class parity_me (ref='never')  
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=parity_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='parity_me';
	variable="uvrq";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data base_parity_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr hormever; 
		*  parity;
run;
data base_parity_ins_A; 
	set base_parity_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelA\base_parity_ins_A.xls' style=minimal;
proc print data= base_parity_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** B03m
** ME: parity_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, _mal';
	title2 'Exposure: parity_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class parity_me (ref='1-2 live children');
	model exit_age*melanoma_mal(0)= parity_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='parity_me';
	variable="MainE_parity_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=parity_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='parity_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=parity_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='parity_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=parity_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='parity_me';
	variable="physic_c";
run;

/** parity;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
		parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=parity_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='parity_me';
	variable="parity";
run;
**/
** age at menarche;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=parity_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='parity_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=parity_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='parity_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=parity_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='parity_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=parity_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='parity_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=parity_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='parity_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=parity_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='parity_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=parity_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='parity_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class parity_me (ref='1-2 live children') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=parity_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='parity_me';
	variable="marriage";
run;


** hormever;
proc phreg data = use multipass;
	class parity_me (ref='never') 
			horm_ever (ref='never');
	model exit_age*melanoma_mal(0)=parity_me horm_ever
			/ entry = entry_age RL;
	ods output ParameterEstimates=hormever;
run;
data hormever; set hormever;
	if Parameter='parity_me';
	variable="hormever";
run;

** uvrq;
proc phreg data = use multipass;
	class parity_me (ref='never')  
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=parity_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='parity_me';
	variable="uvrq";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data base_parity_mal_A; 
	set 
		crude
		physic_c 
		 flb_age_c 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr hormever; 
		* parity ;
run;
data base_parity_mal_A; 
	set base_parity_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelA\base_parity_mal_A.xls' style=minimal;
proc print data= base_parity_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** B04i
** ME: fmenstr_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, _ins';
	title2 'Exposure: fmenstr_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class fmenstr_me (ref='<=10');
	model exit_age*melanoma_ins(0)= fmenstr_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='fmenstr_me';
	variable="MainE_fmenstr_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=fmenstr_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='fmenstr_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=fmenstr_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='fmenstr_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=fmenstr_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='fmenstr_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') 
		parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=fmenstr_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='fmenstr_me';
	variable="parity";
run;

/** age at menarche;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=fmenstr_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='fmenstr_me';
	variable="fmenstr";
run;
**/
** first live birth age;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=fmenstr_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='fmenstr_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=fmenstr_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='fmenstr_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=fmenstr_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='fmenstr_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=fmenstr_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='fmenstr_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=fmenstr_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='fmenstr_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=fmenstr_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='fmenstr_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=fmenstr_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='fmenstr_me';
	variable="marriage";
run;

** hormever;
proc phreg data = use multipass;
	class fmenstr_me (ref='never') 
			horm_ever (ref='never') ;
	model exit_age*melanoma_ins(0)=fmenstr_me horm_ever
			/ entry = entry_age RL;
	ods output ParameterEstimates=hormever;
run;
data hormever; set hormever;
	if Parameter='fmenstr_me';
	variable="hormever";
run;

** uvrq;
proc phreg data = use multipass;
	class fmenstr_me (ref='never')  
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=fmenstr_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='fmenstr_me';
	variable="uvrq";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data base_fmenstr_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former hormever parity; 
		* fmenstr ;
run;
data base_fmenstr_ins_A; 
	set base_fmenstr_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelA\base_fmenstr_ins_A.xls' style=minimal;
proc print data= base_fmenstr_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** B04m
** ME: fmenstr_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, _mal';
	title2 'Exposure: fmenstr_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class fmenstr_me (ref='<=10');
	model exit_age*melanoma_mal(0)= fmenstr_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='fmenstr_me';
	variable="MainE_fmenstr_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=fmenstr_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='fmenstr_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=fmenstr_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='fmenstr_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10')
		physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=fmenstr_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='fmenstr_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') 
		parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=fmenstr_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='fmenstr_me';
	variable="parity";
run;

/** age at menarche;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=fmenstr_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='fmenstr_me';
	variable="fmenstr";
run;
**/
** first live birth age;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=fmenstr_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='fmenstr_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=fmenstr_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='fmenstr_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=fmenstr_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='fmenstr_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=fmenstr_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='fmenstr_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=fmenstr_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='fmenstr_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=fmenstr_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='fmenstr_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class fmenstr_me (ref='<=10') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=fmenstr_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='fmenstr_me';
	variable="marriage";
run;


** hormever;
proc phreg data = use multipass;
	class fmenstr_me (ref='never') 
			horm_ever (ref='never');
	model exit_age*melanoma_mal(0)=fmenstr_me horm_ever
			/ entry = entry_age RL;
	ods output ParameterEstimates=hormever;
run;
data hormever; set hormever;
	if Parameter='fmenstr_me';
	variable="hormever";
run;

** uvrq;
proc phreg data = use multipass;
	class fmenstr_me (ref='never')  
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=fmenstr_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='fmenstr_me';
	variable="uvrq";
run;


ods _all_ close;ods html;
*Combine and output to excel;
data base_fmenstr_mal_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former hormever parity; 
		* fmenstr  ;
run;
data base_fmenstr_mal_A; 
	set base_fmenstr_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelA\base_fmenstr_mal_A.xls' style=minimal;
proc print data= base_fmenstr_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** B05i
** ME: oralbc_dur_c_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, _ins';
	title2 'Exposure: oralbc_dur_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class oralbc_dur_c_me (ref='none');
	model exit_age*melanoma_ins(0)= oralbc_dur_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='oralbc_dur_c_me';
	variable="MainE_oralbc_dur_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='oralbc_dur_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='oralbc_dur_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='oralbc_dur_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='oralbc_dur_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='oralbc_dur_c_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='oralbc_dur_c_me';
	variable="flb_age_c";
run;

/** oral bc duration;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='oralbc_dur_c_me';
	variable="oralbc_dur_c";
run;
**/
** smoke_former;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='oralbc_dur_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='oralbc_dur_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='oralbc_dur_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='oralbc_dur_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='oralbc_dur_c_me';
	variable="marriage";
run;

** hormever;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='never') 
			horm_ever (ref='never') ;
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me horm_ever
			/ entry = entry_age RL;
	ods output ParameterEstimates=hormever;
run;
data hormever; set hormever;
	if Parameter='oralbc_dur_c_me';
	variable="hormever";
run;

** uvrq;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='never')  
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='oralbc_dur_c_me';
	variable="uvrq";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data base_oralbc_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr hormever parity; 
		* oralbc_dur_c;
run;
data base_oralbc_ins_A; 
	set base_oralbc_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelA\base_oralbc_ins_A.xls' style=minimal;
proc print data= base_oralbc_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** B05m
** ME: oralbc_dur_c_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, _mal';
	title2 'Exposure: oralbc_dur_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class oralbc_dur_c_me (ref='none');
	model exit_age*melanoma_mal(0)= oralbc_dur_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='oralbc_dur_c_me';
	variable="MainE_oralbc_dur_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** education;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='oralbc_dur_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='oralbc_dur_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='oralbc_dur_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='oralbc_dur_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='oralbc_dur_c_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none')
		flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='oralbc_dur_c_me';
	variable="flb_age_c";
run;

/** oral bc duration;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none')	oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='oralbc_dur_c_me';
	variable="oralbc_dur_c";
run;
**/
** smoke_former;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='oralbc_dur_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='oralbc_dur_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='oralbc_dur_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='oralbc_dur_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='none') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='oralbc_dur_c_me';
	variable="marriage";
run;

** hormever;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='never') 
			horm_ever (ref='never');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me horm_ever
			/ entry = entry_age RL;
	ods output ParameterEstimates=hormever;
run;
data hormever; set hormever;
	if Parameter='oralbc_dur_c_me';
	variable="hormever";
run;

** uvrq;
proc phreg data = use multipass;
	class oralbc_dur_c_me (ref='never')  
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='oralbc_dur_c_me';
	variable="uvrq";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data base_oralbc_mal_A; 
	set 
		crude
		physic_c 
		 flb_age_c 
		  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr hormever parity; 
		* oralbc_dur_c ;
run;
data base_oralbc_mal_A; 
	set base_oralbc_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelA\base_oralbc_mal_A.xls' style=minimal;
proc print data= base_oralbc_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** B06i
** ME: menostat_c_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, _ins';
	title2 'Exposure: menostat_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class menostat_c_me (ref='pre-menopausal');
	model exit_age*melanoma_ins(0)= menostat_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='menostat_c_me';
	variable="MainE_menostat_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=menostat_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='menostat_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=menostat_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='menostat_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=menostat_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='menostat_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
		parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=menostat_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='menostat_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=menostat_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='menostat_c_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=menostat_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='menostat_c_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=menostat_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='menostat_c_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=menostat_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='menostat_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=menostat_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='menostat_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=menostat_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='menostat_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=menostat_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='menostat_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=menostat_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='menostat_c_me';
	variable="marriage";
run;

** hormever;
proc phreg data = use multipass;
	class menostat_c_me (ref='never') 
			horm_ever (ref='never') ;
	model exit_age*melanoma_ins(0)=menostat_c_me horm_ever
			/ entry = entry_age RL;
	ods output ParameterEstimates=hormever;
run;
data hormever; set hormever;
	if Parameter='menostat_c_me';
	variable="hormever";
run;

** uvrq;
proc phreg data = use multipass;
	class menostat_c_me (ref='never')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=menostat_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='menostat_c_me';
	variable="uvrq";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data base_menostat_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr hormever parity oralbc_dur_c; 
		* ;
run;
data base_menostat_ins_A; 
	set base_menostat_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelA\base_menostat_ins_A.xls' style=minimal;
proc print data= base_menostat_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** B06m
** ME: menostat_c_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, _mal';
	title2 'Exposure: menostat_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class menostat_c_me (ref='pre-menopausal');
	model exit_age*melanoma_mal(0)= menostat_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='menostat_c_me';
	variable="MainE_menostat_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** education;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=menostat_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='menostat_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=menostat_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='menostat_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=menostat_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='menostat_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=menostat_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='menostat_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=menostat_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='menostat_c_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=menostat_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='menostat_c_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=menostat_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='menostat_c_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=menostat_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='menostat_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=menostat_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='menostat_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=menostat_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='menostat_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=menostat_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='menostat_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class menostat_c_me (ref='pre-menopausal') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=menostat_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='menostat_c_me';
	variable="marriage";
run;

** hormever;
proc phreg data = use multipass;
	class menostat_c_me (ref='never') 
			horm_ever (ref='never');
	model exit_age*melanoma_mal(0)=menostat_c_me horm_ever
			/ entry = entry_age RL;
	ods output ParameterEstimates=hormever;
run;
data hormever; set hormever;
	if Parameter='menostat_c_me';
	variable="hormever";
run;

** uvrq;
proc phreg data = use multipass;
	class menostat_c_me (ref='never')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=menostat_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='menostat_c_me';
	variable="uvrq";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data base_menostat_mal_A; 
	set 
		crude
		physic_c 
		 flb_age_c 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former hormever parity fmenstr; 
		*  ;
run;
data base_menostat_mal_A; 
	set base_menostat_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelA\base_menostat_mal_A.xls' style=minimal;
proc print data= base_menostat_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** B07i
** ME: meno_age_c_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, _ins';
	title2 'Exposure: meno_age_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class meno_age_c_me (ref='50-54');
	model exit_age*melanoma_ins(0)= meno_age_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='meno_age_c_me';
	variable="MainE_meno_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=meno_age_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='meno_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=meno_age_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='meno_age_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=meno_age_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='meno_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
		parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=meno_age_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='meno_age_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=meno_age_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='meno_age_c_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=meno_age_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='meno_age_c_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=meno_age_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='meno_age_c_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=meno_age_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='meno_age_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=meno_age_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='meno_age_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=meno_age_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='meno_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=meno_age_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='meno_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=meno_age_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='meno_age_c_me';
	variable="marriage";
run;

** hormever;
proc phreg data = use multipass;
	class meno_age_c_me (ref='never') 
			horm_ever (ref='never') ;
	model exit_age*melanoma_ins(0)=meno_age_c_me horm_ever
			/ entry = entry_age RL;
	ods output ParameterEstimates=hormever;
run;
data hormever; set hormever;
	if Parameter='meno_age_c_me';
	variable="hormever";
run;

** uvrq;
proc phreg data = use multipass;
	class meno_age_c_me (ref='never')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=meno_age_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='meno_age_c_me';
	variable="uvrq";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data base_menoage_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr hormever parity oralbc_dur_c; 
		* ;
run;
data base_menoage_ins_A; 
	set base_menoage_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelA\base_menoage_ins_A.xls' style=minimal;
proc print data= base_menoage_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** B07m
** ME: meno_age_c_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, _mal';
	title2 'Exposure: meno_age_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class meno_age_c_me (ref='50-54');
	model exit_age*melanoma_mal(0)= meno_age_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='meno_age_c_me';
	variable="MainE_meno_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=meno_age_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='meno_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=meno_age_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='meno_age_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=meno_age_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='meno_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=meno_age_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='meno_age_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=meno_age_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='meno_age_c_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=meno_age_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='meno_age_c_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=meno_age_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='meno_age_c_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=meno_age_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='meno_age_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=meno_age_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='meno_age_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=meno_age_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='meno_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=meno_age_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='meno_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class meno_age_c_me (ref='50-54') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=meno_age_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='meno_age_c_me';
	variable="marriage";
run;

** hormever;
proc phreg data = use multipass;
	class meno_age_c_me (ref='never') 
			horm_ever (ref='never');
	model exit_age*melanoma_mal(0)=meno_age_c_me horm_ever
			/ entry = entry_age RL;
	ods output ParameterEstimates=hormever;
run;
data hormever; set hormever;
	if Parameter='meno_age_c_me';
	variable="hormever";
run;

** uvrq;
proc phreg data = use multipass;
	class meno_age_c_me (ref='never')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=meno_age_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='meno_age_c_me';
	variable="uvrq";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data base_menoage_mal_A; 
	set 
		crude
		physic_c 
		 flb_age_c 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former hormever parity fmenstr; 
		*  ;
run;
data base_menoage_mal_A; 
	set base_menoage_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelA\base_menoage_mal_A.xls' style=minimal;
proc print data= base_menoage_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** B08i
** ME: surg_age_c_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, _ins';
	title2 'Exposure: surg_age_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class surg_age_c_me (ref='50-54');
	model exit_age*melanoma_ins(0)= surg_age_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='surg_age_c_me';
	variable="MainE_surg_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=surg_age_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='surg_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=surg_age_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='surg_age_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=surg_age_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='surg_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
		parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=surg_age_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='surg_age_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=surg_age_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='surg_age_c_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=surg_age_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='surg_age_c_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=surg_age_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='surg_age_c_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=surg_age_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='surg_age_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=surg_age_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='surg_age_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=surg_age_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='surg_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=surg_age_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='surg_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=surg_age_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='surg_age_c_me';
	variable="marriage";
run;

** hormever;
proc phreg data = use multipass;
	class surg_age_c_me (ref='never') 
			horm_ever (ref='never') ;
	model exit_age*melanoma_ins(0)=surg_age_c_me horm_ever
			/ entry = entry_age RL;
	ods output ParameterEstimates=hormever;
run;
data hormever; set hormever;
	if Parameter='surg_age_c_me';
	variable="hormever";
run;

** uvrq;
proc phreg data = use multipass;
	class surg_age_c_me (ref='never')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=surg_age_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='surg_age_c_me';
	variable="uvrq";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data base_surgage_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr hormever parity oralbc_dur_c; 
		* ;
run;
data base_surgage_ins_A; 
	set base_surgage_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelA\base_surgage_ins_A.xls' style=minimal;
proc print data= base_surgage_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** B08m
** ME: surg_age_c_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, _mal';
	title2 'Exposure: surg_age_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class surg_age_c_me (ref='50-54');
	model exit_age*melanoma_mal(0)= surg_age_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='surg_age_c_me';
	variable="MainE_surg_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=surg_age_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='surg_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=surg_age_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='surg_age_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=surg_age_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='surg_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=surg_age_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='surg_age_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=surg_age_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='surg_age_c_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=surg_age_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='surg_age_c_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=surg_age_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='surg_age_c_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=surg_age_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='surg_age_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=surg_age_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='surg_age_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=surg_age_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='surg_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=surg_age_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='surg_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class surg_age_c_me (ref='50-54') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=surg_age_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='surg_age_c_me';
	variable="marriage";
run;

** hormever;
proc phreg data = use multipass;
	class surg_age_c_me (ref='never') 
			horm_ever (ref='never');
	model exit_age*melanoma_mal(0)=surg_age_c_me horm_ever
			/ entry = entry_age RL;
	ods output ParameterEstimates=hormever;
run;
data hormever; set hormever;
	if Parameter='surg_age_c_me';
	variable="hormever";
run;

** uvrq;
proc phreg data = use multipass;
	class surg_age_c_me (ref='never')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=surg_age_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='surg_age_c_me';
	variable="uvrq";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data base_surgage_mal_A; 
	set 
		crude
		physic_c 
		 flb_age_c 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former hormever parity fmenstr; 
		*  ;
run;
data base_surgage_mal_A; 
	set base_surgage_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelA\base_surgage_mal_A.xls' style=minimal;
proc print data= base_surgage_mal_A; run;
ods _all_ close;ods html;

******************************************************************************;
******************************************************************************;
************************** RISKFACTOR ****************************************;
******************************************************************************;
******************************************************************************;

data use_r;
	set conv.melan_r;
run;

********************************************************************************;
** R01i
** ME: lacey_eptcurrent_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _ins';
	title2 'Exposure: lacey_eptcurrent_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class lacey_eptcurrent_me (ref='No HT');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='lacey_eptcurrent_me';
	variable="MainE_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='lacey_eptcurrent_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_eptcurrent_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptcurrent_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_eptcurrent_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='lacey_eptcurrent_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptcurrent_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_eptcurrent_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='lacey_eptcurrent_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

/** eptcurrent;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='lacey_eptcurrent_me';
	variable="eptcurrent";
run;
**/

** eptdur;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='lacey_eptcurrent_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='lacey_eptcurrent_me';
	variable="eptdose";
run;

/** etcurrent;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='lacey_eptcurrent_me';
	variable="etcurrent";
run;
**/
** etdur;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='lacey_eptcurrent_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='lacey_eptcurrent_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_eptcur_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr  parity oralbc_dur_c

		eptdur eptdose
		etdur etdose; 
		* eptcurrent etcurrent hormever;
run;
data risk_eptcur_ins_A; 
	set risk_eptcur_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_eptcur_ins_A.xls' style=minimal;
proc print data= risk_eptcur_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R01m
** ME: lacey_eptcurrent_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _mal';
	title2 'Exposure: lacey_eptcurrent_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class lacey_eptcurrent_me (ref='No HT');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='lacey_eptcurrent_me';
	variable="MainE_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='lacey_eptcurrent_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_eptcurrent_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptcurrent_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_eptcurrent_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='lacey_eptcurrent_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptcurrent_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_eptcurrent_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='lacey_eptcurrent_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

/** eptcurrent;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='lacey_eptcurrent_me';
	variable="eptcurrent";
run;
**/

** eptdur;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='lacey_eptcurrent_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='lacey_eptcurrent_me';
	variable="eptdose";
run;

/** etcurrent;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='lacey_eptcurrent_me';
	variable="etcurrent";
run;
**/
** etdur;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='lacey_eptcurrent_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='lacey_eptcurrent_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_eptcur_mal_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former  parity fmenstr

		eptdur eptdose
		etdur etdose; 
		*  eptcurrent etcurrent hormever;
run;
data risk_eptcur_mal_A; 
	set risk_eptcur_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_eptcur_mal_A.xls' style=minimal;
proc print data= risk_eptcur_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R02i
** ME: lacey_eptdur_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _ins';
	title2 'Exposure: lacey_eptdur_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class lacey_eptdur_me (ref='No HT');
	model exit_age*melanoma_ins(0)= lacey_eptdur_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='lacey_eptdur_me';
	variable="MainE_lacey_eptdur_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=lacey_eptdur_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='lacey_eptdur_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=lacey_eptdur_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_eptdur_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=lacey_eptdur_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptdur_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_eptdur_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptdur_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=lacey_eptdur_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_eptdur_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=lacey_eptdur_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptdur_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_eptdur_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='lacey_eptdur_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=lacey_eptdur_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptdur_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_eptdur_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptdur_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_eptdur_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptdur_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=lacey_eptdur_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptdur_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=lacey_eptdur_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_eptdur_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=lacey_eptdur_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='lacey_eptdur_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptdur_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='lacey_eptdur_me';
	variable="eptcurrent";
run;

/** eptdur;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptdur_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='lacey_eptdur_me';
	variable="eptdur";
run;
**/
** eptdose;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptdur_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='lacey_eptdur_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptdur_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='lacey_eptdur_me';
	variable="etcurrent";
run;

/** etdur;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptdur_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='lacey_eptdur_me';
	variable="etdur";
run;
**/
** etdose;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptdur_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='lacey_eptdur_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_eptdur_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr  parity oralbc_dur_c

		eptcurrent  eptdose
		etcurrent  etdose; 
		* eptdur etdur hormever;
run;
data risk_eptdur_ins_A; 
	set risk_eptdur_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_eptdur_ins_A.xls' style=minimal;
proc print data= risk_eptdur_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R02m
** ME: lacey_eptdur_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _mal';
	title2 'Exposure: lacey_eptdur_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class lacey_eptdur_me (ref='No HT');
	model exit_age*melanoma_mal(0)= lacey_eptdur_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='lacey_eptdur_me';
	variable="MainE_lacey_eptdur_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=lacey_eptdur_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='lacey_eptdur_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=lacey_eptdur_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_eptdur_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=lacey_eptdur_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptdur_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_eptdur_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptdur_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=lacey_eptdur_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_eptdur_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=lacey_eptdur_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptdur_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_eptdur_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='lacey_eptdur_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=lacey_eptdur_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptdur_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_eptdur_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptdur_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_eptdur_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptdur_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=lacey_eptdur_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptdur_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=lacey_eptdur_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_eptdur_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=lacey_eptdur_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='lacey_eptdur_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptdur_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='lacey_eptdur_me';
	variable="eptcurrent";
run;

/** eptdur;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptdur_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='lacey_eptdur_me';
	variable="eptdur";
run;
**/
** eptdose;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptdur_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='lacey_eptdur_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptdur_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='lacey_eptdur_me';
	variable="etcurrent";
run;

/** etdur;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptdur_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='lacey_eptdur_me';
	variable="etdur";
run;
**/
** etdose;
proc phreg data = use_r multipass;
	class lacey_eptdur_me (ref='No HT') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptdur_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='lacey_eptdur_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_eptdur_mal_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former  parity fmenstr

		eptcurrent eptdose
		etcurrent  etdose; 
		* eptdur etdur hormever;
run;
data risk_eptdur_mal_A; 
	set risk_eptdur_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_eptdur_mal_A.xls' style=minimal;
proc print data= risk_eptdur_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R03i
** ME: lacey_eptdose_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _ins';
	title2 'Exposure: lacey_eptdose_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class lacey_eptdose_me (ref='No HT');
	model exit_age*melanoma_ins(0)= lacey_eptdose_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='lacey_eptdose_me';
	variable="MainE_lacey_eptdose_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=lacey_eptdose_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='lacey_eptdose_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=lacey_eptdose_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_eptdose_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=lacey_eptdose_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptdose_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_eptdose_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptdose_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=lacey_eptdose_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_eptdose_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=lacey_eptdose_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptdose_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_eptdose_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='lacey_eptdose_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=lacey_eptdose_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptdose_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_eptdose_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptdose_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_eptdose_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptdose_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=lacey_eptdose_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptdose_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=lacey_eptdose_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_eptdose_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=lacey_eptdose_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='lacey_eptdose_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptdose_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='lacey_eptdose_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptdose_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='lacey_eptdose_me';
	variable="eptdur";
run;

/** eptdose;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptdose_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='lacey_eptdose_me';
	variable="eptdose";
run;
**/
** etcurrent;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptdose_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='lacey_eptdose_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptdose_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='lacey_eptdose_me';
	variable="etdur";
run;

/** etdose;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_eptdose_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='lacey_eptdose_me';
	variable="etdose";
run;
**/

ods _all_ close;ods html;
*Combine and output to excel;
data risk_eptdose_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr  parity oralbc_dur_c

		eptcurrent eptdur 
		etcurrent etdur ; 
		* eptdose etdose hormever;
run;
data risk_eptdose_ins_A; 
	set risk_eptdose_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_eptdose_ins_A.xls' style=minimal;
proc print data= risk_eptdose_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R03m
** ME: lacey_eptdose_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _mal';
	title2 'Exposure: lacey_eptdose_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class lacey_eptdose_me (ref='No HT');
	model exit_age*melanoma_mal(0)= lacey_eptdose_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='lacey_eptdose_me';
	variable="MainE_lacey_eptdose_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=lacey_eptdose_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='lacey_eptdose_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=lacey_eptdose_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_eptdose_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=lacey_eptdose_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptdose_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_eptdose_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptdose_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=lacey_eptdose_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_eptdose_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=lacey_eptdose_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptdose_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_eptdose_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='lacey_eptdose_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=lacey_eptdose_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptdose_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_eptdose_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptdose_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_eptdose_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptdose_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=lacey_eptdose_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptdose_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=lacey_eptdose_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_eptdose_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=lacey_eptdose_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='lacey_eptdose_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptdose_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='lacey_eptdose_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptdose_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='lacey_eptdose_me';
	variable="eptdur";
run;

/** eptdose;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptdose_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='lacey_eptdose_me';
	variable="eptdose";
run;
**/
** etcurrent;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptdose_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='lacey_eptdose_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptdose_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='lacey_eptdose_me';
	variable="etdur";
run;

/** etdose;
proc phreg data = use_r multipass;
	class lacey_eptdose_me (ref='No HT') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_eptdose_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='lacey_eptdose_me';
	variable="etdose";
run;
**/
ods _all_ close;ods html;
*Combine and output to excel;
data risk_eptdose_mal_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former  parity fmenstr

		eptcurrent eptdur 
		etcurrent etdur ; 
		* eptdose etdose hormever;
run;
data risk_eptdose_mal_A; 
	set risk_eptdose_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_eptdose_mal_A.xls' style=minimal;
proc print data= risk_eptdose_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R04i
** ME: lacey_etcurrent_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _ins';
	title2 'Exposure: lacey_etcurrent_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class lacey_etcurrent_me (ref='No HT');
	model exit_age*melanoma_ins(0)= lacey_etcurrent_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='lacey_etcurrent_me';
	variable="MainE_lacey_etcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='lacey_etcurrent_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_etcurrent_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_etcurrent_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_etcurrent_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_etcurrent_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_etcurrent_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='lacey_etcurrent_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_etcurrent_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_etcurrent_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_etcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_etcurrent_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_etcurrent_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='lacey_etcurrent_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

/** eptcurrent;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='lacey_etcurrent_me';
	variable="eptcurrent";
run;
**/
** eptdur;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='lacey_etcurrent_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='lacey_etcurrent_me';
	variable="eptdose";
run;

/** etcurrent;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='lacey_etcurrent_me';
	variable="etcurrent";
run;
**/
** etdur;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='lacey_etcurrent_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='lacey_etcurrent_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_etcur_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr  parity oralbc_dur_c

		 eptdur eptdose
		 etdur etdose; 
		* eptcurrent etcurrent hormever;
run;
data risk_etcur_ins_A; 
	set risk_etcur_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_etcur_ins_A.xls' style=minimal;
proc print data= risk_etcur_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R04m
** ME: lacey_etcurrent_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _mal';
	title2 'Exposure: lacey_etcurrent_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class lacey_etcurrent_me (ref='No HT');
	model exit_age*melanoma_mal(0)= lacey_etcurrent_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='lacey_etcurrent_me';
	variable="MainE_lacey_etcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='lacey_etcurrent_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_etcurrent_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_etcurrent_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_etcurrent_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_etcurrent_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_etcurrent_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='lacey_etcurrent_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_etcurrent_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_etcurrent_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_etcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_etcurrent_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_etcurrent_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='lacey_etcurrent_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

/** eptcurrent;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='lacey_etcurrent_me';
	variable="eptcurrent";
run;
**/
** eptdur;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='lacey_etcurrent_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='lacey_etcurrent_me';
	variable="eptdose";
run;

/** etcurrent;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='lacey_etcurrent_me';
	variable="etcurrent";
run;
**/
** etdur;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='lacey_etcurrent_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class lacey_etcurrent_me (ref='No HT') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='lacey_etcurrent_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_etcur_mal_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former  parity fmenstr

		 eptdur eptdose
		 etdur etdose; 
		* eptcurrent etcurrent hormever;
run;
data risk_etcur_mal_A; 
	set risk_etcur_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_etcur_mal_A.xls' style=minimal;
proc print data= risk_etcur_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R05i
** ME: lacey_etdur_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _ins';
	title2 'Exposure: lacey_etdur_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class lacey_etdur_me (ref='No HT');
	model exit_age*melanoma_ins(0)= lacey_etdur_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='lacey_etdur_me';
	variable="MainE_lacey_etdur_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=lacey_etdur_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='lacey_etdur_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=lacey_etdur_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_etdur_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=lacey_etdur_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_etdur_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etdur_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_etdur_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=lacey_etdur_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_etdur_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=lacey_etdur_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_etdur_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_etdur_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='lacey_etdur_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=lacey_etdur_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_etdur_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_etdur_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_etdur_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_etdur_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_etdur_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=lacey_etdur_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_etdur_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=lacey_etdur_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_etdur_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=lacey_etdur_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='lacey_etdur_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etdur_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='lacey_etdur_me';
	variable="eptcurrent";
run;

/** eptdur;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etdur_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='lacey_etdur_me';
	variable="eptdur";
run;
**/
** eptdose;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etdur_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='lacey_etdur_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etdur_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='lacey_etdur_me';
	variable="etcurrent";
run;

/** etdur;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etdur_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='lacey_etdur_me';
	variable="etdur";
run;
**/
** etdose;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etdur_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='lacey_etdur_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_etdur_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr  parity oralbc_dur_c

		eptcurrent  eptdose
		etcurrent  etdose; 
		* eptdur etdur hormever;
run;
data risk_etdur_ins_A; 
	set risk_etdur_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_etdur_ins_A.xls' style=minimal;
proc print data= risk_etdur_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R05m
** ME: lacey_etdur_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _mal';
	title2 'Exposure: lacey_etdur_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class lacey_etdur_me (ref='No HT');
	model exit_age*melanoma_mal(0)= lacey_etdur_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='lacey_etdur_me';
	variable="MainE_lacey_etdur_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=lacey_etdur_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='lacey_etdur_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=lacey_etdur_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_etdur_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=lacey_etdur_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_etdur_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etdur_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_etdur_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=lacey_etdur_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_etdur_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=lacey_etdur_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_etdur_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_etdur_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='lacey_etdur_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=lacey_etdur_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_etdur_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_etdur_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_etdur_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_etdur_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_etdur_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=lacey_etdur_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_etdur_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=lacey_etdur_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_etdur_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=lacey_etdur_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='lacey_etdur_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etdur_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='lacey_etdur_me';
	variable="eptcurrent";
run;

/** eptdur;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etdur_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='lacey_etdur_me';
	variable="eptdur";
run;
**/
** eptdose;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etdur_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='lacey_etdur_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etdur_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='lacey_etdur_me';
	variable="etcurrent";
run;

/** etdur;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etdur_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='lacey_etdur_me';
	variable="etdur";
run;
**/
** etdose;
proc phreg data = use_r multipass;
	class lacey_etdur_me (ref='No HT') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etdur_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='lacey_etdur_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_etdur_mal_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former  parity fmenstr

		eptcurrent  eptdose
		etcurrent  etdose; 
		* eptdur etdur hormever;
run;
data risk_etdur_mal_A; 
	set risk_etdur_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_etdur_mal_A.xls' style=minimal;
proc print data= risk_etdur_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R06i
** ME: lacey_etdose_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _ins';
	title2 'Exposure: lacey_etdose_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class lacey_etdose_me (ref='No HT');
	model exit_age*melanoma_ins(0)= lacey_etdose_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='lacey_etdose_me';
	variable="MainE_lacey_etdose_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=lacey_etdose_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='lacey_etdose_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=lacey_etdose_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_etdose_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=lacey_etdose_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_etdose_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etdose_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_etdose_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=lacey_etdose_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_etdose_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=lacey_etdose_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_etdose_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_etdose_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='lacey_etdose_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=lacey_etdose_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_etdose_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_etdose_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_etdose_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=lacey_etdose_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_etdose_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=lacey_etdose_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_etdose_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=lacey_etdose_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_etdose_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=lacey_etdose_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='lacey_etdose_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etdose_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='lacey_etdose_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etdose_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='lacey_etdose_me';
	variable="eptdur";
run;

/** eptdose;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etdose_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='lacey_etdose_me';
	variable="eptdose";
run;
**/
** etcurrent;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etdose_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='lacey_etdose_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etdose_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='lacey_etdose_me';
	variable="etdur";
run;

/** etdose;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=lacey_etdose_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='lacey_etdose_me';
	variable="etdose";
run;
**/
ods _all_ close;ods html;
*Combine and output to excel;
data risk_etdose_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr  parity oralbc_dur_c

		eptcurrent eptdur 
		etcurrent etdur ; 
		* eptdose etdose hormever;
run;
data risk_etdose_ins_A; 
	set risk_etdose_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_etdose_ins_A.xls' style=minimal;
proc print data= risk_etdose_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R06m
** ME: lacey_etdose_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _mal';
	title2 'Exposure: lacey_etdose_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class lacey_etdose_me (ref='No HT');
	model exit_age*melanoma_mal(0)= lacey_etdose_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='lacey_etdose_me';
	variable="MainE_lacey_etdose_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=lacey_etdose_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='lacey_etdose_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=lacey_etdose_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_etdose_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=lacey_etdose_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_etdose_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etdose_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_etdose_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=lacey_etdose_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_etdose_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=lacey_etdose_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_etdose_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_etdose_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='lacey_etdose_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=lacey_etdose_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_etdose_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_etdose_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_etdose_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_etdose_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_etdose_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=lacey_etdose_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_etdose_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=lacey_etdose_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_etdose_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=lacey_etdose_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='lacey_etdose_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etdose_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='lacey_etdose_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etdose_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='lacey_etdose_me';
	variable="eptdur";
run;

/** eptdose;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etdose_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='lacey_etdose_me';
	variable="eptdose";
run;
**/
** etcurrent;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etdose_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='lacey_etdose_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etdose_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='lacey_etdose_me';
	variable="etdur";
run;

/** etdose;
proc phreg data = use_r multipass;
	class lacey_etdose_me (ref='No HT') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=lacey_etdose_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='lacey_etdose_me';
	variable="etdose";
run;
**/
ods _all_ close;ods html;
*Combine and output to excel;
data risk_etdose_mal_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former  parity fmenstr

		eptcurrent eptdur 
		etcurrent etdur ; 
		* eptdose etdose hormever;
run;
data risk_etdose_mal_A; 
	set risk_etdose_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_etdose_mal_A.xls' style=minimal;
proc print data= risk_etdose_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R07i
** ME: flb_age_c_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _ins';
	title2 'Exposure: flb_age_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class flb_age_c_me (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= flb_age_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='flb_age_c_me';
	variable="MainE_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=flb_age_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='flb_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=flb_age_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='flb_age_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=flb_age_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=flb_age_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=flb_age_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='flb_age_c_me';
	variable="fmenstr";
run;

/** first live birth age;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=flb_age_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;
**/
** oral bc duration;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=flb_age_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='flb_age_c_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=flb_age_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='flb_age_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=flb_age_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=flb_age_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=flb_age_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=flb_age_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='flb_age_c_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='flb_age_c_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=flb_age_c_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='flb_age_c_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=flb_age_c_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='flb_age_c_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=flb_age_c_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='flb_age_c_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=flb_age_c_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='flb_age_c_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=flb_age_c_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='flb_age_c_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=flb_age_c_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='flb_age_c_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_flb_ins_A; 
	set 
		crude
		physic_c 
		 
		coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr  parity oralbc_dur_c

		eptcurrent eptdur eptdose
		etcurrent etdur etdose; 
		* flb_age_c  hormever;
run;
data risk_flb_ins_A; 
	set risk_flb_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_flb_ins_A.xls' style=minimal;
proc print data= risk_flb_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R07m
** ME: flb_age_c_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _mal';
	title2 'Exposure: flb_age_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class flb_age_c_me (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= flb_age_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='flb_age_c_me';
	variable="MainE_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=flb_age_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='flb_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=flb_age_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='flb_age_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=flb_age_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=flb_age_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=flb_age_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='flb_age_c_me';
	variable="fmenstr";
run;

/** first live birth age;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=flb_age_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;
**/
** oral bc duration;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=flb_age_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='flb_age_c_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=flb_age_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='flb_age_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=flb_age_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=flb_age_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=flb_age_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=flb_age_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='flb_age_c_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='flb_age_c_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=flb_age_c_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='flb_age_c_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=flb_age_c_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='flb_age_c_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=flb_age_c_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='flb_age_c_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=flb_age_c_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='flb_age_c_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=flb_age_c_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='flb_age_c_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class flb_age_c_me (ref='< 20 years old') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=flb_age_c_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='flb_age_c_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_flb_mal_A; 
	set 
		crude
		physic_c 
		 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former  parity fmenstr

		eptcurrent eptdur eptdose
		etcurrent etdur etdose; 
		* flb_age_c  hormever;
run;
data risk_flb_mal_A; 
	set risk_flb_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_flb_mal_A.xls' style=minimal;
proc print data= risk_flb_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R08i
** ME: parity_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _ins';
	title2 'Exposure: parity_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class parity_me (ref='1-2 live children');
	model exit_age*melanoma_ins(0)= parity_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='parity_me';
	variable="MainE_parity_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=parity_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='parity_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=parity_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='parity_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=parity_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='parity_me';
	variable="physic_c";
run;

/** parity;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=parity_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='parity_me';
	variable="parity";
run;
**/
** age at menarche;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=parity_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='parity_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=parity_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='parity_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=parity_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='parity_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=parity_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='parity_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=parity_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='parity_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=parity_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='parity_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=parity_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='parity_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=parity_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='parity_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=parity_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='parity_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=parity_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='parity_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=parity_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='parity_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=parity_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='parity_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=parity_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='parity_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=parity_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='parity_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=parity_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='parity_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_parity_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr   oralbc_dur_c

		eptcurrent eptdur eptdose
		etcurrent etdur etdose; 
		* parity  hormever;
run;
data risk_parity_ins_A; 
	set risk_parity_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_parity_ins_A.xls' style=minimal;
proc print data= risk_parity_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R08m
** ME: parity_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _mal';
	title2 'Exposure: parity_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class parity_me (ref='1-2 live children');
	model exit_age*melanoma_mal(0)= parity_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='parity_me';
	variable="MainE_parity_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=parity_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='parity_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=parity_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='parity_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=parity_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='parity_me';
	variable="physic_c";
run;

/** parity;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=parity_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='parity_me';
	variable="parity";
run;
**/
** age at menarche;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=parity_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='parity_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=parity_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='parity_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=parity_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='parity_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=parity_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='parity_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=parity_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='parity_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=parity_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='parity_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=parity_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='parity_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=parity_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='parity_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=parity_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='parity_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=parity_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='parity_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=parity_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='parity_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=parity_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='parity_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=parity_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='parity_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=parity_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='parity_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class parity_me (ref='1-2 live children') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=parity_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='parity_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_parity_mal_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former   fmenstr

		eptcurrent eptdur eptdose
		etcurrent etdur etdose; 
		* parity  hormever;
run;
data risk_parity_mal_A; 
	set risk_parity_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_parity_mal_A.xls' style=minimal;
proc print data= risk_parity_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R09i
** ME: fmenstr_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _ins';
	title2 'Exposure: fmenstr_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class fmenstr_me (ref='<=10');
	model exit_age*melanoma_ins(0)= fmenstr_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='fmenstr_me';
	variable="MainE_fmenstr_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=fmenstr_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='fmenstr_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=fmenstr_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='fmenstr_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=fmenstr_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='fmenstr_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=fmenstr_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='fmenstr_me';
	variable="parity";
run;

/** age at menarche;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=fmenstr_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='fmenstr_me';
	variable="fmenstr";
run;
**/
** first live birth age;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=fmenstr_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='fmenstr_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=fmenstr_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='fmenstr_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=fmenstr_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='fmenstr_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=fmenstr_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='fmenstr_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=fmenstr_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='fmenstr_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=fmenstr_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='fmenstr_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=fmenstr_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='fmenstr_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=fmenstr_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='fmenstr_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=fmenstr_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='fmenstr_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=fmenstr_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='fmenstr_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=fmenstr_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='fmenstr_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=fmenstr_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='fmenstr_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=fmenstr_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='fmenstr_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=fmenstr_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='fmenstr_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_fmenstr_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former   parity oralbc_dur_c

		eptcurrent eptdur eptdose
		etcurrent etdur etdose; 
		* fmenstr  hormever;
run;
data risk_fmenstr_ins_A; 
	set risk_fmenstr_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_fmenstr_ins_A.xls' style=minimal;
proc print data= risk_fmenstr_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R09m
** ME: fmenstr_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _mal';
	title2 'Exposure: fmenstr_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class fmenstr_me (ref='<=10');
	model exit_age*melanoma_mal(0)= fmenstr_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='fmenstr_me';
	variable="MainE_fmenstr_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=fmenstr_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='fmenstr_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=fmenstr_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='fmenstr_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=fmenstr_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='fmenstr_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=fmenstr_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='fmenstr_me';
	variable="parity";
run;

/** age at menarche;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=fmenstr_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='fmenstr_me';
	variable="fmenstr";
run;
**/
** first live birth age;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=fmenstr_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='fmenstr_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=fmenstr_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='fmenstr_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=fmenstr_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='fmenstr_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=fmenstr_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='fmenstr_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=fmenstr_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='fmenstr_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=fmenstr_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='fmenstr_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=fmenstr_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='fmenstr_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=fmenstr_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='fmenstr_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=fmenstr_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='fmenstr_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=fmenstr_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='fmenstr_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=fmenstr_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='fmenstr_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=fmenstr_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='fmenstr_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=fmenstr_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='fmenstr_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class fmenstr_me (ref='<=10') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=fmenstr_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='fmenstr_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_fmenstr_mal_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former parity  

		eptcurrent eptdur eptdose
		etcurrent etdur etdose; 
		* fmenstr  hormever;
run;
data risk_fmenstr_mal_A; 
	set risk_fmenstr_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_fmenstr_mal_A.xls' style=minimal;
proc print data= risk_fmenstr_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R10i
** ME: oralbc_dur_c_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _ins';
	title2 'Exposure: oralbc_dur_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class oralbc_dur_c_me (ref='none');
	model exit_age*melanoma_ins(0)= oralbc_dur_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='oralbc_dur_c_me';
	variable="MainE_oralbc_dur_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='oralbc_dur_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='oralbc_dur_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='oralbc_dur_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='oralbc_dur_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='oralbc_dur_c_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='oralbc_dur_c_me';
	variable="flb_age_c";
run;

/** oral bc duration;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='oralbc_dur_c_me';
	variable="oralbc_dur_c";
run;
**/
** smoke_former;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='oralbc_dur_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='oralbc_dur_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='oralbc_dur_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='oralbc_dur_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='oralbc_dur_c_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='oralbc_dur_c_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='oralbc_dur_c_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='oralbc_dur_c_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='oralbc_dur_c_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='oralbc_dur_c_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='oralbc_dur_c_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='oralbc_dur_c_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_oralbc_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr  parity 

		eptcurrent eptdur eptdose
		etcurrent etdur etdose; 
		* oralbc_dur_c  hormever;
run;
data risk_oralbc_ins_A; 
	set risk_oralbc_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_oralbc_ins_A.xls' style=minimal;
proc print data= risk_oralbc_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R10m
** ME: oralbc_dur_c_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _mal';
	title2 'Exposure: oralbc_dur_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class oralbc_dur_c_me (ref='none');
	model exit_age*melanoma_mal(0)= oralbc_dur_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='oralbc_dur_c_me';
	variable="MainE_oralbc_dur_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='oralbc_dur_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='oralbc_dur_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='oralbc_dur_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='oralbc_dur_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='oralbc_dur_c_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='oralbc_dur_c_me';
	variable="flb_age_c";
run;

/** oral bc duration;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='oralbc_dur_c_me';
	variable="oralbc_dur_c";
run;
**/
** smoke_former;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='oralbc_dur_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='oralbc_dur_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='oralbc_dur_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='oralbc_dur_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='oralbc_dur_c_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='oralbc_dur_c_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='oralbc_dur_c_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='oralbc_dur_c_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='oralbc_dur_c_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='oralbc_dur_c_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='oralbc_dur_c_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class oralbc_dur_c_me (ref='none') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='oralbc_dur_c_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_oralbc_mal_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		  coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former parity fmenstr 

		eptcurrent eptdur eptdose
		etcurrent etdur etdose; 
		* oralbc_dur_c  hormever;
run;
data risk_oralbc_mal_A; 
	set risk_oralbc_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_oralbc_mal_A.xls' style=minimal;
proc print data= risk_oralbc_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R11i
** ME: menostat_c_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _ins';
	title2 'Exposure: menostat_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class menostat_c_me (ref='pre-menopausal');
	model exit_age*melanoma_ins(0)= menostat_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='menostat_c_me';
	variable="MainE_menostat_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=menostat_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='menostat_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=menostat_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='menostat_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=menostat_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='menostat_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=menostat_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='menostat_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=menostat_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='menostat_c_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=menostat_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='menostat_c_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=menostat_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='menostat_c_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=menostat_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='menostat_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=menostat_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='menostat_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=menostat_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='menostat_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=menostat_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='menostat_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=menostat_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='menostat_c_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=menostat_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='menostat_c_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=menostat_c_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='menostat_c_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=menostat_c_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='menostat_c_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=menostat_c_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='menostat_c_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=menostat_c_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='menostat_c_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=menostat_c_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='menostat_c_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=menostat_c_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='menostat_c_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_menostat_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr oralbc_dur_c parity 

		eptcurrent eptdur eptdose
		etcurrent etdur etdose; 
		*   hormever;
run;
data risk_menostat_ins_A; 
	set risk_menostat_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_menostat_ins_A.xls' style=minimal;
proc print data= risk_menostat_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R11m
** ME: menostat_c_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _mal';
	title2 'Exposure: menostat_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class menostat_c_me (ref='pre-menopausal');
	model exit_age*melanoma_mal(0)= menostat_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='menostat_c_me';
	variable="MainE_menostat_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=menostat_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='menostat_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=menostat_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='menostat_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=menostat_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='menostat_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=menostat_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='menostat_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=menostat_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='menostat_c_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=menostat_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='menostat_c_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=menostat_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='menostat_c_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=menostat_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='menostat_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=menostat_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='menostat_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=menostat_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='menostat_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=menostat_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='menostat_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=menostat_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='menostat_c_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=menostat_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='menostat_c_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=menostat_c_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='menostat_c_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=menostat_c_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='menostat_c_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=menostat_c_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='menostat_c_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=menostat_c_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='menostat_c_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=menostat_c_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='menostat_c_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class menostat_c_me (ref='pre-menopausal') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=menostat_c_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='menostat_c_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_menostat_mal_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		oralbc_dur_c coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former parity fmenstr 

		eptcurrent eptdur eptdose
		etcurrent etdur etdose; 
		*   hormever;
run;
data risk_menostat_mal_A; 
	set risk_menostat_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_menostat_mal_A.xls' style=minimal;
proc print data= risk_menostat_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R12i
** ME: meno_age_c_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _ins';
	title2 'Exposure: meno_age_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class meno_age_c_me (ref='50-54');
	model exit_age*melanoma_ins(0)= meno_age_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='meno_age_c_me';
	variable="MainE_meno_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=meno_age_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='meno_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=meno_age_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='meno_age_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=meno_age_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='meno_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=meno_age_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='meno_age_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=meno_age_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='meno_age_c_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=meno_age_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='meno_age_c_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=meno_age_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='meno_age_c_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=meno_age_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='meno_age_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=meno_age_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='meno_age_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=meno_age_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='meno_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=meno_age_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='meno_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=meno_age_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='meno_age_c_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=meno_age_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='meno_age_c_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=meno_age_c_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='meno_age_c_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=meno_age_c_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='meno_age_c_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=meno_age_c_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='meno_age_c_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=meno_age_c_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='meno_age_c_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=meno_age_c_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='meno_age_c_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=meno_age_c_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='meno_age_c_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_menoage_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr oralbc_dur_c parity 

		eptcurrent eptdur eptdose
		etcurrent etdur etdose; 
		*   hormever;
run;
data risk_menoage_ins_A; 
	set risk_menoage_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_menoage_ins_A.xls' style=minimal;
proc print data= risk_menoage_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R12m
** ME: meno_age_c_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _mal';
	title2 'Exposure: meno_age_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class meno_age_c_me (ref='50-54');
	model exit_age*melanoma_mal(0)= meno_age_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='meno_age_c_me';
	variable="MainE_meno_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=meno_age_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='meno_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=meno_age_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='meno_age_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=meno_age_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='meno_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=meno_age_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='meno_age_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=meno_age_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='meno_age_c_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=meno_age_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='meno_age_c_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=meno_age_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='meno_age_c_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=meno_age_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='meno_age_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=meno_age_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='meno_age_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=meno_age_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='meno_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=meno_age_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='meno_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=meno_age_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='meno_age_c_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=meno_age_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='meno_age_c_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=meno_age_c_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='meno_age_c_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=meno_age_c_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='meno_age_c_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=meno_age_c_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='meno_age_c_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=meno_age_c_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='meno_age_c_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=meno_age_c_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='meno_age_c_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class meno_age_c_me (ref='50-54') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=meno_age_c_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='meno_age_c_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_menoage_mal_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		oralbc_dur_c coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former parity fmenstr 

		eptcurrent eptdur eptdose
		etcurrent etdur etdose; 
		*   hormever;
run;
data risk_menoage_mal_A; 
	set risk_menoage_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_menoage_mal_A.xls' style=minimal;
proc print data= risk_menoage_mal_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R13i
** ME: surg_age_c_me
** melanoma: _ins, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _ins';
	title2 'Exposure: surg_age_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class surg_age_c_me (ref='50-54');
	model exit_age*melanoma_ins(0)= surg_age_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='surg_age_c_me';
	variable="MainE_surg_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=surg_age_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='surg_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=surg_age_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='surg_age_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54')
			physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=surg_age_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='surg_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=surg_age_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='surg_age_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=surg_age_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='surg_age_c_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=surg_age_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='surg_age_c_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_ins(0)=surg_age_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='surg_age_c_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=surg_age_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='surg_age_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=surg_age_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='surg_age_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=surg_age_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='surg_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=surg_age_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='surg_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			marriage (ref='married');
	model exit_age*melanoma_ins(0)=surg_age_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='surg_age_c_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_ins(0)=surg_age_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='surg_age_c_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=surg_age_c_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='surg_age_c_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=surg_age_c_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='surg_age_c_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=surg_age_c_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='surg_age_c_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=surg_age_c_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='surg_age_c_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=surg_age_c_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='surg_age_c_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_ins(0)=surg_age_c_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='surg_age_c_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_surgage_ins_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former fmenstr oralbc_dur_c parity 

		eptcurrent eptdur eptdose
		etcurrent etdur etdose; 
		*   hormever;
run;
data risk_surgage_ins_A; 
	set risk_surgage_ins_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_surgage_ins_A.xls' style=minimal;
proc print data= risk_surgage_ins_A; run;
ods _all_ close;ods html;

********************************************************************************;
** R13m
** ME: surg_age_c_me, 
** melanoma: _mal, 
** variables: 1 conf;
********************************************************************************;
** crude **;
proc phreg data = use_r multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, _mal';
	title2 'Exposure: surg_age_c_me';
	title3 '+ 1 confounder';
	title4 'revised parity and flb variables';
	class surg_age_c_me (ref='50-54');
	model exit_age*melanoma_mal(0)= surg_age_c_me
			/ entry = entry_age RL;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='surg_age_c_me';
	variable="MainE_surg_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=surg_age_c_me educ_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='surg_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=surg_age_c_me bmi_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='surg_age_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54')
			physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=surg_age_c_me physic_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='surg_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=surg_age_c_me parity
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='surg_age_c_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=surg_age_c_me fmenstr 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='surg_age_c_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=surg_age_c_me flb_age_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='surg_age_c_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54')	
			oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=surg_age_c_me oralbc_dur_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='surg_age_c_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=surg_age_c_me smoke_former 
			/ entry = entry_age RL;
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='surg_age_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=surg_age_c_me coffee_c 
			/ entry = entry_age RL;
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='surg_age_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=surg_age_c_me etoh_c
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='surg_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=surg_age_c_me rel_1d_cancer
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='surg_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			marriage (ref='married');
	model exit_age*melanoma_mal(0)=surg_age_c_me marriage
			/ entry = entry_age RL;
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='surg_age_c_me';
	variable="marriage";
run;

** uvrq;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54')
			uvrq (ref='0 to 186.918') ;
	model exit_age*melanoma_mal(0)=surg_age_c_me uvrq
			/ entry = entry_age RL;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='surg_age_c_me';
	variable="uvrq";
run;

/** hormever (from baseline);
removed due to more detailed MHT variables in riskfactor analysis **/

** Begin new riskfactor variables, Lacey ;

** eptcurrent;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			lacey_eptcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=surg_age_c_me lacey_eptcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptcurrent;
run;
data eptcurrent; set eptcurrent;
	if Parameter='surg_age_c_me';
	variable="eptcurrent";
run;

** eptdur;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			lacey_eptdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=surg_age_c_me lacey_eptdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdur;
run;
data eptdur; set eptdur;
	if Parameter='surg_age_c_me';
	variable="eptdur";
run;

** eptdose;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			lacey_eptdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=surg_age_c_me lacey_eptdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=eptdose;
run;
data eptdose; set eptdose;
	if Parameter='surg_age_c_me';
	variable="eptdose";
run;

** etcurrent;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			lacey_etcurrent (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=surg_age_c_me lacey_etcurrent
			/ entry = entry_age RL;
	ods output ParameterEstimates=etcurrent;
run;
data etcurrent; set etcurrent;
	if Parameter='surg_age_c_me';
	variable="etcurrent";
run;

** etdur;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			lacey_etdur (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=surg_age_c_me lacey_etdur
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdur;
run;
data etdur; set etdur;
	if Parameter='surg_age_c_me';
	variable="etdur";
run;

** etdose;
proc phreg data = use_r multipass;
	class surg_age_c_me (ref='50-54') 
			lacey_etdose (ref='No HT')  ;
	model exit_age*melanoma_mal(0)=surg_age_c_me lacey_etdose
			/ entry = entry_age RL;
	ods output ParameterEstimates=etdose;
run;
data etdose; set etdose;
	if Parameter='surg_age_c_me';
	variable="etdose";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_surgage_mal_A; 
	set 
		crude
		physic_c 
		flb_age_c 
		oralbc_dur_c coffee_c 
		etoh_c rel_1d_cancer uvrq education bmi_c 
		marriage smoke_former parity fmenstr 

		eptcurrent eptdur eptdose
		etcurrent etdur etdose; 
		*   hormever;
run;
data risk_surgage_mal_A; 
	set risk_surgage_mal_A
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelA\risk_surgage_mal_A.xls' style=minimal;
proc print data= risk_surgage_mal_A; run;
ods _all_ close;ods html;

/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
#
# Model building v1, Main Effect: Age at first live birth
# !!!! for baseline dataset !!!!
#
# uses the conv.melan datasets
#
# Created: April 22 2015
# Updated: v20150603 WTL
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************/

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
libname results 'C:\REB\AARP_HRTandMelanoma\Results\baseline\mht';


********************************************************************************;
** Analysis of ME: age at first live birth *************************************;
********************************************************************************;

ods _all_ close;
ods html;

data use;
	set conv.melan;
run;

********************************************************************************;
** baseline, melanoma, in situ, ME: flb_age_c_me, 
** uvrq + educ_c + parity + smoke_former + 1 conf **;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, in situ';
	title2 'Exposure: age first birth';
	title3 'uvrq + educ_c + bmi_c + parity + smoke_former + 1 confounder';
	title4 '20150622MON';
	title5 'revised flb and parity';
	class flb_age_c_me (ref='< 20 years old')
			uvrq (ref='0 to 186.918')
			educ_c (ref='highschool or less')
			bmi_c (ref='18.5 to < 25')
			parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)= flb_age_c_me uvrq educ_c bmi_c parity 
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='flb_age_c_me';
	variable="MainE_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


/** education;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
		educ_c (ref='highschool or less')
		uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=flb_age_c_me educ_c uvrq
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='flb_age_c_me';
	variable="educ_c";
run;
**/

/** bmi;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
		uvrq (ref='0 to 186.918')
		bmi_c (ref='18.5 to < 25')
		educ_c (ref='highschool or less');
		*parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq bmi_c educ_c
			/entry = entry_age RL; 
	*where menostat_c=1;
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='flb_age_c_me';
	variable="bmi_c";
run;
**/
** physcial activity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
		uvrq (ref='0 to 186.918')
		physic_c (ref='rarely')
		educ_c (ref='highschool or less')
		bmi_c (ref='18.5 to < 25')
		parity (ref='1-2 live children')
		smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= flb_age_c_me uvrq physic_c educ_c bmi_c parity
									smoke_former
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

/** parity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
		uvrq (ref='0 to 186.918')
		parity (ref='1-2 live children')
		educ_c (ref='highschool or less')
		bmi_c (ref='18.5 to < 25')
		*parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq parity educ_c bmi_c parity
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;
**/

** age at menarche;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
		uvrq (ref='0 to 186.918')
		fmenstr (ref='<=10')
		educ_c (ref='highschool or less')
		bmi_c (ref='18.5 to < 25')
		parity (ref='1-2 live children')
		smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq fmenstr educ_c bmi_c parity
									smoke_former
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='flb_age_c_me';
	variable="fmenstr";
run;

/** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
			uvrq (ref='0 to 186.918') 
			educ_c (ref='highschool or less') 
			bmi_c (ref='18.5 to < 25')
			flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c bmi_c flb_age_c
			/ entry = entry_age RL; 
	*where menostat_c=1;
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
		uvrq (ref='0 to 186.918')
		oralbc_dur_c (ref='none')
		educ_c (ref='highschool or less')
		bmi_c (ref='18.5 to < 25')
		parity (ref='1-2 live children')
		smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= flb_age_c_me uvrq oralbc_dur_c educ_c bmi_c parity
									smoke_former
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='flb_age_c_me';
	variable="oralbc_dur_c";
run;

/** smoke_former;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
		uvrq (ref='0 to 186.918')
		smoke_former (ref='never smoked')
		educ_c (ref='highschool or less')
		bmi_c (ref='18.5 to < 25')
		parity (ref='1-2 live children')
		fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= flb_age_c_me uvrq smoke_former educ_c bmi_c parity
									fmenstr
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='flb_age_c_me';
	variable="smoke_former";
run;
**/
** coffee drinking;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')  
		uvrq (ref='0 to 186.918')
		coffee_c (ref='none')
		educ_c (ref='highschool or less')
		bmi_c (ref='18.5 to < 25')
		parity (ref='1-2 live children')
		smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= flb_age_c_me uvrq coffee_c educ_c bmi_c parity
									smoke_former
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
		uvrq (ref='0 to 186.918')
		etoh_c (ref='none')
		educ_c (ref='highschool or less')
		bmi_c (ref='18.5 to < 25')
		parity (ref='1-2 live children')
		smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= flb_age_c_me uvrq etoh_c educ_c bmi_c parity
									smoke_former
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
		uvrq (ref='0 to 186.918')
		rel_1d_cancer (ref='No')
		educ_c (ref='highschool or less')
		bmi_c (ref='18.5 to < 25')
		parity (ref='1-2 live children')
		smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= flb_age_c_me uvrq rel_1d_cancer educ_c bmi_c parity
									smoke_former
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')  
		uvrq (ref='0 to 186.918')
		marriage (ref='married')
		educ_c (ref='highschool or less')
		bmi_c (ref='18.5 to < 25')
		parity (ref='1-2 live children')
		smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= flb_age_c_me uvrq marriage educ_c bmi_c parity
									smoke_former
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='flb_age_c_me';
	variable="marriage";
run;

/** uvrq;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
		uvrq (ref='0 to 186.918')
		educ_c (ref='highschool or less')
		parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c parity 
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='flb_age_c_me';
	variable="uvrq";
run;
**/
ods _all_ close;ods html;
*Combine and output to excel;
data base_flb_ins_uvr_5conf; 
	set 
		crude 
		physic_c  
		oralbc_dur_c  coffee_c 
		etoh_c rel_1d_cancer meno_age_c surg_age_c marriage; 
		* uvrq education bmi_c parity fmenstr smoke_former;
run;
data base_flb_ins_uvr_5conf; 
	set base_flb_ins_uvr_5conf
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\flb_age\base_flb_ins_uvr_5conf.xls' style=minimal;
proc print data= base_flb_ins_uvr_5conf; run;
ods _all_ close;ods html;

********************************************************************************;
** baseline, melanoma, malignant, ME: flb_age_c_me, 
** variables: uvrq + parity + educ_c + fmenstr + 1 conf **;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, malignant';
	title2 'Exposure: age first birth';
	title3 'uvrq + parity + educ_c + fmenstr + 1 confounder';
	title4 '20150623TUE';
	title5 'revised flb and parity';
	class flb_age_c_me (ref='< 20 years old')
		uvrq (ref='0 to 186.918')
		parity (ref='1-2 live children')
		educ_c (ref='highschool or less')
		fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= flb_age_c_me uvrq parity educ_c fmenstr
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='flb_age_c_me';
	variable="MainE_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

/** education;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
		educ_c (ref='highschool or less')
		uvrq (ref='0 to 186.918')
		parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=flb_age_c_me educ_c uvrq parity
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='flb_age_c_me';
	variable="educ_c";
run;
**/
** bmi;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
		bmi_c (ref='18.5 to < 25')
		uvrq (ref='0 to 186.918')
		parity (ref='1-2 live children')
		educ_c (ref='highschool or less')
		fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=flb_age_c_me bmi_c uvrq parity educ_c fmenstr
			/entry = entry_age RL; 
	*where menostat_c=1;
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='flb_age_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
		physic_c (ref='rarely')
		uvrq (ref='0 to 186.918')
		parity (ref='1-2 live children')
		educ_c (ref='highschool or less')
		fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=flb_age_c_me physic_c uvrq parity educ_c fmenstr
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

/** parity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
		parity (ref='1-2 live children')
		uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=flb_age_c_me parity uvrq 
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;
**/
/** age at menarche;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
		fmenstr (ref='<=10')
		uvrq (ref='0 to 186.918')
		parity (ref='1-2 live children')
		educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=flb_age_c_me fmenstr uvrq parity educ_c
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='flb_age_c_me';
	variable="fmenstr";
run;
**/
/** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25')
		flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq educ_c bmi_c flb_age_c
			/ entry = entry_age RL; 
	*where menostat_c=1;
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
		oralbc_dur_c (ref='none')
		uvrq (ref='0 to 186.918')
		parity (ref='1-2 live children')
		educ_c (ref='highschool or less')
		fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=flb_age_c_me oralbc_dur_c uvrq parity educ_c fmenstr
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='flb_age_c_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')
		smoke_former (ref='never smoked')
		uvrq (ref='0 to 186.918')
		parity (ref='1-2 live children')
		educ_c (ref='highschool or less')
		fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=flb_age_c_me smoke_former uvrq parity educ_c fmenstr
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='flb_age_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')  
		coffee_c (ref='none')
		uvrq (ref='0 to 186.918')
		parity (ref='1-2 live children')
		educ_c (ref='highschool or less')
		fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=flb_age_c_me coffee_c uvrq parity educ_c fmenstr
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
		etoh_c (ref='none')
		uvrq (ref='0 to 186.918')
		parity (ref='1-2 live children')
		educ_c (ref='highschool or less')
		fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=flb_age_c_me etoh_c uvrq parity educ_c fmenstr
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') 
		rel_1d_cancer (ref='No')
		uvrq (ref='0 to 186.918')
		parity (ref='1-2 live children')
		educ_c (ref='highschool or less')
		fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=flb_age_c_me rel_1d_cancer uvrq parity educ_c fmenstr
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old')  
		marriage (ref='married')
		uvrq (ref='0 to 186.918')
		parity (ref='1-2 live children')
		educ_c (ref='highschool or less')
		fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=flb_age_c_me marriage uvrq parity educ_c fmenstr
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='flb_age_c_me';
	variable="marriage";
run;

/** uvrq;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq
			/ entry = entry_age RL;
	*where menostat_c=1; 
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='flb_age_c_me';
	variable="uvrq";
run;
**/
ods _all_ close;ods html;
*Combine and output to excel;
data base_flb_mal_uvr_4conf; 
	set 
		crude  bmi_c
		physic_c 
		 
		oralbc_dur_c smoke_former coffee_c 
		etoh_c rel_1d_cancer marriage; 
		*uvrq parity education fmenstr;
run;
data base_flb_mal_uvr_4conf; 
	set base_flb_mal_uvr_4conf
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\flb_age\base_flb_mal_uvr_4conf.xls' style=minimal;
proc print data= base_flb_mal_uvr_4conf; run;
ods _all_ close;ods html;

*****************************************************************************************;
******   Model Building Table  **********************************************************;
*****************************************************************************************;
* final baseline model, in situ, flb ~ uvrq + educ_c + bmi_c + parity + smoke_former;
* baseline, melanoma in situ, exposure: flb_age_c_me;
*A = unadjusted, except for age*;
title;
proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= flb_age_c_me / entry = entry_age RL; 
	ods output ParameterEstimates=A_flb_age_c_me;
run;
data A_flb_age_c_me; 
	set A_flb_age_c_me ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used');
	model exit_age*melanoma_ins(0)=horm_yrs_me / entry = entry_age RL; 
	ods output ParameterEstimates=A_horm_yrs_me;
run;
data A_horm_yrs_me; 
	set A_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data A_TOT_ins (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_flb_age_c_me;
run;
data A_TOT_ins (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); 
	set A_TOT_ins; 
run;

data A_TOT_ins;
	set A_TOT_ins;
	model='Total';
run;

** natural menopause reason;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= flb_age_c_me / entry = entry_age RL; 
	ods output ParameterEstimates=A_flb_age_c_nm;
	where menostat_c=1;
run;
data A_flb_age_c_nm; 
	set A_flb_age_c_nm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used');
	model exit_age*melanoma_ins(0)=horm_yrs_me / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_horm_yrs_nm;
run;
data A_horm_yrs_nm; 
	set A_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data A_NM_ins (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_flb_age_c_nm;
run;
data A_NM_ins (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); 
	set A_NM_ins ;
run;

data A_NM_ins;
	set A_NM_ins;
	model='Natur';
run;

** surgical menopause reason;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') ;
	model exit_age*melanoma_ins(0)=flb_age_c_me / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_flb_age_c_sm;
run;
data A_flb_age_c_sm; 
	set A_flb_age_c_sm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used');
	model exit_age*melanoma_ins(0)=horm_yrs_me / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_horm_yrs_sm;
run;
data A_horm_yrs_sm; set A_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data A_SM_ins (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_flb_age_c_sm;
run;
data A_SM_ins (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); 
	set A_SM_ins ;
run;

data A_SM_ins;
	set A_SM_ins;
	model='Surgi';
run;

** merge hormever total, natural, and surgical menopause;
data A_All_ins ; 
	set A_TOT_ins A_NM_ins A_SM_ins; 
run;

*B = adjusted for UVR*;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq/ entry = entry_age RL; 
	ods output ParameterEstimates=B_flb_age_c_me;
run;
data B_flb_age_c_me; 
	set B_flb_age_c_me ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=horm_yrs_me uvrq/ entry = entry_age RL; 
	ods output ParameterEstimates=B_horm_yrs_me;
run;
data B_horm_yrs_me; 
	set B_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data B_TOT_ins (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_flb_age_c_me ;
run;
data B_TOT_ins (keep=Parameter ClassVal0 Sortvar B_HR B_LL B_UL); 
	set B_TOT_ins; 
run;
data B_TOT_ins ; 
	set B_TOT_ins; 
	model='Total'; 
run;

** natural menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=B_flb_age_c_nm;
run;
data B_flb_age_c_nm; 
	set B_flb_age_c_nm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2; 
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=horm_yrs_me  uvrq / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=B_horm_yrs_nm;
run;
data B_horm_yrs_nm; 
	set B_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data B_NM_ins (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_flb_age_c_nm ;
run;
data B_NM_ins (keep=Parameter ClassVal0 Sortvar B_HR B_LL B_UL); 
	set B_NM_ins ;
run;
data B_NM_ins ; 
	set B_NM_ins; 
	model='Natur'; 
run;

** ins_ Surgical menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=B_flb_age_c_sm;
run;
data B_flb_age_c_sm; 
	set B_flb_age_c_sm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=horm_yrs_me uvrq / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=B_horm_yrs_sm;
run;
data B_horm_yrs_sm; 
	set B_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data B_SM_ins (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_flb_age_c_sm ;
run;
data B_SM_ins (keep=Parameter ClassVal0 Sortvar B_HR B_LL B_UL); 
	set B_SM_ins ;
run;
data B_SM_ins ; 
	set B_SM_ins; 
	model='Surgi'; 
run;

data B_All_ins ; 
	set B_TOT_ins B_NM_ins B_SM_ins; 
run;

** C = adjusted for age, UVR, educ_c;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=C_flb_age_c_me;
run;
data C_flb_age_c_me; 
	set C_flb_age_c_me ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2; 
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=horm_yrs_me uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=C_horm_yrs_me;
run;
data C_horm_yrs_me; 
	set C_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data C_TOT_ins (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_flb_age_c_me ;
run;
data C_TOT_ins (keep=Parameter ClassVal0 Sortvar C_HR C_LL C_UL); 
	set C_TOT_ins; 
run;
data C_TOT_ins ; 
	set C_TOT_ins; 
	model='Total'; 
run;

** natural menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=C_flb_age_c_nm;
run;
data C_flb_age_c_nm; 
	set C_flb_age_c_nm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=horm_yrs_me  uvrq educ_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=C_horm_yrs_nm;
run;
data C_horm_yrs_nm; 
	set C_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data C_NM_ins (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_flb_age_c_nm ;
run;
data C_NM_ins (keep=Parameter ClassVal0 Sortvar C_HR C_LL C_UL); 
	set C_NM_ins ;
run;
data C_NM_ins ; 
	set C_NM_ins; 
	model='Natur'; 
run;

** ins_ Surgical menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=C_flb_age_c_sm;
run;
data C_flb_age_c_sm; 
	set C_flb_age_c_sm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=horm_yrs_me uvrq educ_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=C_horm_yrs_sm;
run;
data C_horm_yrs_sm; 
	set C_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data C_SM_ins (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_flb_age_c_sm ;
run;
data C_SM_ins (keep=Parameter ClassVal0 Sortvar C_HR C_LL C_UL); 
	set C_SM_ins ;
run;
data C_SM_ins ; 
	set C_SM_ins; 
	model='Surgi'; 
run;

data C_All_ins ; 
	set C_TOT_ins C_NM_ins C_SM_ins; 
run;

*D = adjusted for age, UVR quartile, educ_c, bmi_c;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=D_flb_age_c_me;
run;
data D_flb_age_c_me; 
	set D_flb_age_c_me ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=horm_yrs_me uvrq educ_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=D_horm_yrs_me;
run;
data D_horm_yrs_me; 
	set D_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data D_TOT_ins (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_flb_age_c_me ;
run;
data D_TOT_ins (keep=Parameter ClassVal0 Sortvar D_HR D_LL D_UL); 
	set D_TOT_ins; 
run;
data D_TOT_ins ; 
	set D_TOT_ins; 
	model='Total'; 
run;

** natural menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=D_flb_age_c_nm;
run;
data D_flb_age_c_nm; 
	set D_flb_age_c_nm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=horm_yrs_me  uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=D_horm_yrs_nm;
run;
data D_horm_yrs_nm; 
	set D_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data D_NM_ins (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_flb_age_c_nm  ;
run;
data D_NM_ins (keep=Parameter ClassVal0 Sortvar D_HR D_LL D_UL); 
	set D_NM_ins ;
run;
data D_NM_ins ; 
	set D_NM_ins; 
	model='Natur'; 
run;

** ins_ Surgical menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=D_flb_age_c_sm;
run;
data D_flb_age_c_sm; 
	set D_flb_age_c_sm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=horm_yrs_me uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=D_horm_yrs_sm;
run;
data D_horm_yrs_sm; 
	set D_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data D_SM_ins (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_flb_age_c_sm ;
run;
data D_SM_ins (keep=Parameter ClassVal0 Sortvar D_HR D_LL D_UL); 
	set D_SM_ins ;
run;
data D_SM_ins ; 
	set D_SM_ins; 
	model='Surgi'; 
run;

data D_All_ins ; 
	set D_TOT_ins D_NM_ins D_SM_ins; 
run;

*E = adjusted for age, UVR quartile, educ_c, bmi_c, parity;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25')
		parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c bmi_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=E_flb_age_c_me;
run;
data E_flb_age_c_me; 
	set E_flb_age_c_me ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=horm_yrs_me uvrq educ_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=E_horm_yrs_me;
run;
data E_horm_yrs_me; 
	set E_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data E_TOT_ins (rename=(HazardRatio=E_HR HRLowerCL=E_LL HRUpperCL=E_UL )); 
	set E_flb_age_c_me ;
run;
data E_TOT_ins (keep=Parameter ClassVal0 Sortvar E_HR E_LL E_UL); 
	set E_TOT_ins; 
run;
data E_TOT_ins ; 
	set E_TOT_ins; 
	model='Total'; 
run;

** natural menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25')
		parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c bmi_c parity/ entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=E_flb_age_c_nm;
run;
data E_flb_age_c_nm; 
	set E_flb_age_c_nm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=horm_yrs_me  uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=E_horm_yrs_nm;
run;
data E_horm_yrs_nm; 
	set E_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data E_NM_ins (rename=(HazardRatio=E_HR HRLowerCL=E_LL HRUpperCL=E_UL )); 
	set E_flb_age_c_nm  ;
run;
data E_NM_ins (keep=Parameter ClassVal0 Sortvar E_HR E_LL E_UL); 
	set E_NM_ins ;
run;
data E_NM_ins ; 
	set E_NM_ins; 
	model='Natur'; 
run;

** ins_ Surgical menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25')
		parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c bmi_c parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=E_flb_age_c_sm;
run;
data E_flb_age_c_sm; 
	set E_flb_age_c_sm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=horm_yrs_me uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=E_horm_yrs_sm;
run;
data E_horm_yrs_sm; 
	set E_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data E_SM_ins (rename=(HazardRatio=E_HR HRLowerCL=E_LL HRUpperCL=E_UL )); 
	set E_flb_age_c_sm ;
run;
data E_SM_ins (keep=Parameter ClassVal0 Sortvar E_HR E_LL E_UL); 
	set E_SM_ins ;
run;
data E_SM_ins ; 
	set E_SM_ins; 
	model='Surgi'; 
run;

data E_All_ins ; 
	set E_TOT_ins E_NM_ins E_SM_ins; 
run;

*F = adjusted for age, UVR quartile, educ_c, bmi_c, parity, smoke_former;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25')
		parity (ref='1-2 live children') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c bmi_c parity smoke_former/ entry = entry_age RL; 
	ods output ParameterEstimates=F_flb_age_c_me;
run;
data F_flb_age_c_me; 
	set F_flb_age_c_me ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=horm_yrs_me uvrq educ_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=F_horm_yrs_me;
run;
data F_horm_yrs_me; 
	set F_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data F_TOT_ins (rename=(HazardRatio=F_HR HRLowerCL=F_LL HRUpperCL=F_UL )); 
	set F_flb_age_c_me ;
run;
data F_TOT_ins (keep=Parameter ClassVal0 Sortvar F_HR F_LL F_UL); 
	set F_TOT_ins; 
run;
data F_TOT_ins ; 
	set F_TOT_ins; 
	model='Total'; 
run;

** natural menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25')
		parity (ref='1-2 live children') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c bmi_c parity smoke_former / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=F_flb_age_c_nm;
run;
data F_flb_age_c_nm; 
	set F_flb_age_c_nm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=horm_yrs_me  uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=F_horm_yrs_nm;
run;
data F_horm_yrs_nm; 
	set F_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data F_NM_ins (rename=(HazardRatio=F_HR HRLowerCL=F_LL HRUpperCL=F_UL )); 
	set F_flb_age_c_nm  ;
run;
data F_NM_ins (keep=Parameter ClassVal0 Sortvar F_HR F_LL F_UL); 
	set F_NM_ins ;
run;
data F_NM_ins ; 
	set F_NM_ins; 
	model='Natur'; 
run;

** ins_ Surgical menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25')
		parity (ref='1-2 live children') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c bmi_c parity smoke_former / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=F_flb_age_c_sm;
run;
data F_flb_age_c_sm; 
	set F_flb_age_c_sm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=horm_yrs_me uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=F_horm_yrs_sm;
run;
data F_horm_yrs_sm; 
	set F_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data F_SM_ins (rename=(HazardRatio=F_HR HRLowerCL=F_LL HRUpperCL=F_UL )); 
	set F_flb_age_c_sm ;
run;
data F_SM_ins (keep=Parameter ClassVal0 Sortvar F_HR F_LL F_UL); 
	set F_SM_ins ;
run;
data F_SM_ins ; 
	set F_SM_ins; 
	model='Surgi'; 
run;

data F_All_ins ; 
	set F_TOT_ins F_NM_ins F_SM_ins; 
run;

** sort and merge all 6 models together;

proc sort data=A_All_ins  out=A_All_ins; by model sortvar ; run;
proc sort data=B_All_ins  out=B_All_ins; by model sortvar ; run;
proc sort data=C_All_ins  out=C_All_ins; by model sortvar ; run;
proc sort data=D_All_ins  out=D_All_ins; by model sortvar ; run;
proc sort data=E_All_ins  out=E_All_ins; by model sortvar ; run;
proc sort data=F_All_ins  out=F_All_ins; by model sortvar ; run;
proc print data=B_All_ins;
run;

data ModelBuilding_ins_hormever ; 
	title1 underlin=1 'AARP Baseline: melanoma, in situ';
	title2 'Exposure: flb_age_c_me';
	title3 'uvrq, educ_c, bmi_c, parity, smoke_former as confounders';
	title4 'Modelbuilding Table';
	title5 '20150624WED';
	title6 'revised parity and flb variables';
	MERGE A_ALL_ins B_ALL_ins C_ALL_ins D_ALL_ins E_All_ins F_All_ins; 
	BY model sortvar;
run; 
*DATA ModelBuilding (drop=Sortvar); *RUN; 
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\flb_age\base_ins_flb_modelbuilding1.xls' style=minimal;
proc print data= ModelBuilding_ins_hormever ; run;
ods _all_ close;ods html;

*****************************************************************************************;
******   Model Building Table  **********************************************************;
*****************************************************************************************;

* baseline, melanoma malignant, exposure: flb_age_c_me;
*A = unadjusted, except for age*;
title;
proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= flb_age_c_me / entry = entry_age RL; 
	ods output ParameterEstimates=A_flb_age_c_me;
run;
data A_flb_age_c_me; 
	set A_flb_age_c_me ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used');
	model exit_age*melanoma_mal(0)=horm_yrs_me / entry = entry_age RL; 
	ods output ParameterEstimates=A_horm_yrs_me;
run;
data A_horm_yrs_me; 
	set A_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data A_TOT_mal (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_flb_age_c_me ;
run;
data A_TOT_mal (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); 
	set A_TOT_mal; 
run;
data A_TOT_mal ; 
	set A_TOT_mal; 
	model='Total'; 
run;

** natural menopause reason;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= flb_age_c_me / entry = entry_age RL; 
	ods output ParameterEstimates=A_flb_age_c_nm;
	where menostat_c=1;
run;
data A_flb_age_c_nm; 
	set A_flb_age_c_nm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used');
	model exit_age*melanoma_mal(0)=horm_yrs_me / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_horm_yrs_nm;
run;
data A_horm_yrs_nm; 
	set A_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data A_NM_mal (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_flb_age_c_nm ;
run;
data A_NM_mal (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); 
	set A_NM_mal ;
run;
data A_NM_mal ; 
	set A_NM_mal; 
	model='Natur'; 
run;

** surgical menopause reason;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') ;
	model exit_age*melanoma_mal(0)=flb_age_c_me / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_flb_age_c_sm;
run;
data A_flb_age_c_sm; 
	set A_flb_age_c_sm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used');
	model exit_age*melanoma_mal(0)=horm_yrs_me / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_horm_yrs_sm;
run;
data A_horm_yrs_sm; set A_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data A_SM_mal (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_flb_age_c_sm ;
run;
data A_SM_mal (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); 
	set A_SM_mal ;
run;
data A_SM_mal ; 
	set A_SM_mal; 
	model='Surgi'; 
run;
** merge hormever total, natural, and surgical menopause;
data A_All_mal ; 
	set A_TOT_mal A_NM_mal A_SM_mal; 
run;

*B = adjusted for UVR*;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq/ entry = entry_age RL; 
	ods output ParameterEstimates=B_flb_age_c_me;
run;
data B_flb_age_c_me; 
	set B_flb_age_c_me ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=horm_yrs_me uvrq/ entry = entry_age RL; 
	ods output ParameterEstimates=B_horm_yrs_me;
run;
data B_horm_yrs_me; 
	set B_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data B_TOT_mal (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_flb_age_c_me ;
run;
data B_TOT_mal (keep=Parameter ClassVal0 Sortvar B_HR B_LL B_UL); 
	set B_TOT_mal; 
run;
data B_TOT_mal ; 
	set B_TOT_mal; 
	model='Total'; 
run;

** natural menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=B_flb_age_c_nm;
run;
data B_flb_age_c_nm; 
	set B_flb_age_c_nm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=horm_yrs_me  uvrq / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=B_horm_yrs_nm;
run;
data B_horm_yrs_nm; 
	set B_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data B_NM_mal (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_flb_age_c_nm ;
run;
data B_NM_mal (keep=Parameter ClassVal0 Sortvar B_HR B_LL B_UL); 
	set B_NM_mal ;
run;
data B_NM_mal ; 
	set B_NM_mal; 
	model='Natur'; 
run;

** ins_ Surgical menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=B_flb_age_c_sm;
run;
data B_flb_age_c_sm; 
	set B_flb_age_c_sm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=horm_yrs_me uvrq / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=B_horm_yrs_sm;
run;
data B_horm_yrs_sm; 
	set B_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data B_SM_mal (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_flb_age_c_sm ;
run;
data B_SM_mal (keep=Parameter ClassVal0 Sortvar B_HR B_LL B_UL); 
	set B_SM_mal ;
run;
data B_SM_mal ; 
	set B_SM_mal; 
	model='Surgi'; 
run;

data B_All_mal ; 
	set B_TOT_mal B_NM_mal B_SM_mal; 
run;

** C = adjusted for age, UVR, parity;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq parity / entry = entry_age RL; 
	ods output ParameterEstimates=C_flb_age_c_me;
run;
data C_flb_age_c_me; 
	set C_flb_age_c_me ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=horm_yrs_me uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=C_horm_yrs_me;
run;
data C_horm_yrs_me; 
	set C_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data C_TOT_mal (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_flb_age_c_me ;
run;
data C_TOT_mal (keep=Parameter ClassVal0 Sortvar C_HR C_LL C_UL); 
	set C_TOT_mal; 
run;
data C_TOT_mal ; 
	set C_TOT_mal; 
	model='Total'; 
run;

** natural menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=C_flb_age_c_nm;
run;
data C_flb_age_c_nm; 
	set C_flb_age_c_nm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=horm_yrs_me  uvrq educ_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=C_horm_yrs_nm;
run;
data C_horm_yrs_nm; 
	set C_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data C_NM_mal (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_flb_age_c_nm ;
run;
data C_NM_mal (keep=Parameter ClassVal0 Sortvar C_HR C_LL C_UL); 
	set C_NM_mal ;
run;
data C_NM_mal ; 
	set C_NM_mal; 
	model='Natur'; 
run;

** ins_ Surgical menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=C_flb_age_c_sm;
run;
data C_flb_age_c_sm; 
	set C_flb_age_c_sm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=horm_yrs_me uvrq educ_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=C_horm_yrs_sm;
run;
data C_horm_yrs_sm; 
	set C_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data C_SM_mal (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_flb_age_c_sm ;
run;
data C_SM_mal (keep=Parameter ClassVal0 Sortvar C_HR C_LL C_UL); 
	set C_SM_mal ;
run;
data C_SM_mal ; 
	set C_SM_mal; 
	model='Surgi'; 
run;

data C_All_mal ; 
	set C_TOT_mal C_NM_mal C_SM_mal; 
run;

*D = adjusted for age, UVR quartile, parity, educ_c;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') 
		parity (ref='1-2 live children') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq parity educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=D_flb_age_c_me;
run;
data D_flb_age_c_me; 
	set D_flb_age_c_me ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=horm_yrs_me uvrq educ_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=D_horm_yrs_me;
run;
data D_horm_yrs_me; 
	set D_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data D_TOT_mal (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_flb_age_c_me ;
run;
data D_TOT_mal (keep=Parameter ClassVal0 Sortvar D_HR D_LL D_UL); 
	set D_TOT_mal; 
run;
data D_TOT_mal ; 
	set D_TOT_mal; 
	model='Total'; 
run;

** natural menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') 
		parity (ref='1-2 live children') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=D_flb_age_c_nm;
run;
data D_flb_age_c_nm; 
	set D_flb_age_c_nm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=horm_yrs_me  uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=D_horm_yrs_nm;
run;
data D_horm_yrs_nm; 
	set D_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data D_NM_mal (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_flb_age_c_nm ;
run;
data D_NM_mal (keep=Parameter ClassVal0 Sortvar D_HR D_LL D_UL); 
	set D_NM_mal ;
run;
data D_NM_mal ; 
	set D_NM_mal; 
	model='Natur'; 
run;

** mal_ Surgical menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') 
		parity (ref='1-2 live children') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=D_flb_age_c_sm;
run;
data D_flb_age_c_sm; 
	set D_flb_age_c_sm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=horm_yrs_me uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=D_horm_yrs_sm;
run;
data D_horm_yrs_sm; 
	set D_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data D_SM_mal (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_flb_age_c_sm ;
run;
data D_SM_mal (keep=Parameter ClassVal0 Sortvar D_HR D_LL D_UL); 
	set D_SM_mal ;
run;
data D_SM_mal ; 
	set D_SM_mal; 
	model='Surgi'; 
run;

data D_All_mal ; 
	set D_TOT_mal D_NM_mal D_SM_mal; 
run;

*E = adjusted for age, UVR quartile, parity, educ_c, fmenstr;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') 
		parity (ref='1-2 live children') educ_c (ref='highschool or less')
		fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq parity educ_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=E_flb_age_c_me;
run;
data E_flb_age_c_me; 
	set E_flb_age_c_me ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=horm_yrs_me uvrq educ_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=E_horm_yrs_me;
run;
data E_horm_yrs_me; 
	set E_horm_yrs_me ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data E_TOT_mal (rename=(HazardRatio=E_HR HRLowerCL=E_LL HRUpperCL=E_UL )); 
	set E_flb_age_c_me ;
run;
data E_TOT_mal (keep=Parameter ClassVal0 Sortvar E_HR E_LL E_UL); 
	set E_TOT_mal; 
run;
data E_TOT_mal ; 
	set E_TOT_mal; 
	model='Total'; 
run;

** natural menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') 
		parity (ref='1-2 live children') educ_c (ref='highschool or less')
		fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq parity educ_c fmenstr / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=E_flb_age_c_nm;
run;
data E_flb_age_c_nm; 
	set E_flb_age_c_nm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=horm_yrs_me  uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=E_horm_yrs_nm;
run;
data E_horm_yrs_nm; 
	set E_horm_yrs_nm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data E_NM_mal (rename=(HazardRatio=E_HR HRLowerCL=E_LL HRUpperCL=E_UL )); 
	set E_flb_age_c_nm ;
run;
data E_NM_mal (keep=Parameter ClassVal0 Sortvar E_HR E_LL E_UL); 
	set E_NM_mal ;
run;
data E_NM_mal ; 
	set E_NM_mal; 
	model='Natur'; 
run;

** mal_ Surgical menopause;

proc phreg data = use;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') 
		parity (ref='1-2 live children') educ_c (ref='highschool or less')
		fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq parity educ_c fmenstr / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=E_flb_age_c_sm;
run;
data E_flb_age_c_sm; 
	set E_flb_age_c_sm ; 
	where Parameter='flb_age_c_me';
	if Classval0='20s'		then Sortvar=1; 
	if Classval0='30s'		then Sortvar=2;
run;
/**
proc phreg data = use;
	class  horm_yrs_me (ref='never used') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=horm_yrs_me uvrq educ_c bmi_c / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=E_horm_yrs_sm;
run;
data E_horm_yrs_sm; 
	set E_horm_yrs_sm ; 
	where Parameter='horm_yrs_me';
	if Classval0='<5 years'  		then Sortvar=3;
	if Classval0='5-9 years'  		then Sortvar=4;
	if Classval0='>=10 years'		then Sortvar=5;
run;
**/
data E_SM_mal (rename=(HazardRatio=E_HR HRLowerCL=E_LL HRUpperCL=E_UL )); 
	set E_flb_age_c_sm ;
run;
data E_SM_mal (keep=Parameter ClassVal0 Sortvar E_HR E_LL E_UL); 
	set E_SM_mal ;
run;
data E_SM_mal ; 
	set E_SM_mal; 
	model='Surgi'; 
run;

data E_All_mal ; 
	set E_TOT_mal E_NM_mal E_SM_mal; 
run;

** sort and merge all 4 models together;

proc sort data=A_All_mal  out=A_All_mal; by model sortvar ; run;
proc sort data=B_All_mal  out=B_All_mal; by model sortvar ; run;
proc sort data=C_All_mal  out=C_All_mal; by model sortvar ; run;
proc sort data=D_All_mal  out=D_All_mal; by model sortvar ; run;
proc sort data=E_All_mal  out=E_All_mal; by model sortvar ; run;
proc print data=B_All_mal;
run;

data ModelBuilding_mal_hormever ; 
	title1 underlin=1 'AARP Baseline: melanoma, malignant';
	title2 'Exposure: flb_age_c_me';
	title3 'uvrq, parity, educ_c, fmenstr as confounders';
	title4 'Modelbuilding Table';
	title5 '20150624WED';
	title6 'revised parity and flb variables';
	MERGE A_All_mal B_All_mal C_All_mal D_All_mal E_All_mal; 
	BY model sortvar;
run; 
*DATA ModelBuilding (drop=Sortvar); *RUN; 
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\mht\base_mal_flb_modelbuilding1.xls' style=minimal;
proc print data= ModelBuilding_mal_hormever ; run;
ods _all_ close;ods html;

********************************************************************************;
*** horm_ever, hormone ever, malignant **;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title 'crude model - hormone ever, mal, base';
	class flb_age_c_me (ref='< 20 years old') ;
	model exit_age*melanoma_mal(0)= flb_age_c_me  / entry = entry_age RL; 
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='flb_age_c_me';
	variable="Null_Model_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

data entryage; set entryage;
	if Parameter='flb_age_c_me';
	variable="agecat_me";
run;

** birth cohort;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort_me (ref='1925-1928');
	model exit_age*melanoma_mal(0)=flb_age_c_me birth_cohort_me/ entry = entry_age RL; 
	ods output ParameterEstimates=birthcohort;
run;
data birthcohort; set birthcohort;
	if Parameter='flb_age_c_me';
	variable="birthcohort_me";
run;

** education;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') educ_c_me (ref='highschool or less');
	model exit_age*melanoma_mal(0)=flb_age_c_me educ_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='flb_age_c_me';
	variable="educ_c_me";
run;

** bmi;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') bmi_c_me (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=flb_age_c_me bmi_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c_me;
run;
data bmi_c_me; set bmi_c_me;
	if Parameter='flb_age_c_me';
	variable="bmi_c_me";
run;

** physcial activity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') physic_c_me (ref='rarely');
	model exit_age*melanoma_mal(0)=flb_age_c_me physic_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c_me;
run;
data physic_c_me; set physic_c_me;
	if Parameter='flb_age_c_me';
	variable="physic_c_me";
run;

** parity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') parity_me (ref='missing');
	model exit_age*melanoma_mal(0)=flb_age_c_me parity_me/ entry = entry_age RL; 
	ods output ParameterEstimates=parity_me;
run;
data parity_me; set parity_me;
	if Parameter='flb_age_c_me';
	variable="parity_me";
run;

** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') flb_age_c_me (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=flb_age_c_me flb_age_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c_me;
run;
data flb_age_c_me; set flb_age_c_me;
	if Parameter='flb_age_c_me';
	variable="flb_age_c_me";
run;

** age at menarche;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') fmenstr_me (ref='<=10');
	model exit_age*melanoma_mal(0)=flb_age_c_me fmenstr_me/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr_me;
run;
data fmenstr_me; set fmenstr_me;
	if Parameter='flb_age_c_me';
	variable="fmenstr_me";
run;

** oral bc duration;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') oralbc_dur_c_me (ref='never');
	model exit_age*melanoma_mal(0)=flb_age_c_me oralbc_dur_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=oralbc_dur_c_me;
run;
data oralbc_dur_c_me; set oralbc_dur_c_me;
	if Parameter='flb_age_c_me';
	variable="oralbc_dur_c_me";
run;

** UVR quartiles;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') uvrq_me (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq_me/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq_me;
run;
data uvrq_me; set uvrq_me;
	if Parameter='flb_age_c_me';
	variable="uvrq_me";
run;

** smoking status;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') smoke_former_me (ref='never smoked');
	model exit_age*melanoma_mal(0)=flb_age_c_me smoke_former_me/ entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former_me;
run;
data smoke_former_me; set smoke_former_me;
	if Parameter='flb_age_c_me';
	variable="smoke_former_me";
run;

** coffee drinking;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') coffee_c_me (ref='none');
	model exit_age*melanoma_mal(0)=flb_age_c_me coffee_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c_me;
run;
data coffee_c_me; set coffee_c_me;
	if Parameter='flb_age_c_me';
	variable="coffee_c_me";
run;

** etoh drinking;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') etoh_c_me (ref='none');
	model exit_age*melanoma_mal(0)=flb_age_c_me etoh_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c_me;
run;
data etoh_c_me; set etoh_c_me;
	if Parameter='flb_age_c_me';
	variable="etoh_c_me";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') rel_1d_cancer_me (ref='No');
	model exit_age*melanoma_mal(0)=flb_age_c_me rel_1d_cancer_me/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer_me;
run;
data rel_1d_cancer_me; set rel_1d_cancer_me;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer_me";
run;

** marriage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') marriage (ref='married');
	model exit_age*melanoma_mal(0)=flb_age_c_me marriage/ entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='flb_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder1_base_mal_hormever; 
	set 
		crude birthcohort
		education bmi_c_me physic_c_me
		parity_me flb_age_c_me fmenstr_me
		oralbc_dur_c_me uvrq_me smoke_former_me coffee_c_me 
		etoh_c_me rel_1d_cancer_me marriage; 
run;
data confounder1_base_mal_hormever; 
	set confounder1_base_mal_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\confounder1_testing_mal_hormever.xls' style=minimal;
proc print data= confounder1_base_mal_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 2 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR- in situ, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, ins, base';
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='flb_age_c_me';
	variable="Null_Model_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='flb_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='flb_age_c_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** meno_age_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=meno_age_c;
run;
data meno_age_c; set meno_age_c;
	if Parameter='flb_age_c_me';
	variable="meno_age_c";
run;

** parity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') parity (ref='missing');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='flb_age_c_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='flb_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') marriage (ref='married');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='flb_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder2_base_ins_hormever; 
	set 
		null education bmi_c physic_c meno_age_c 
		parity flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder2_base_ins_hormever; 
	set confounder2_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder2_base_ins_hormever.xls' style=minimal;
proc print data= confounder2_base_ins_hormever; run;
ods _all_ close;ods html;

********************************************************************************;
*** horm_ever, BC, UVR- mal, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, mal, base';
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='flb_age_c_me';
	variable="Null_Model_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='flb_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='flb_age_c_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** meno_age_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=meno_age_c;
run;
data meno_age_c; set meno_age_c;
	if Parameter='flb_age_c_me';
	variable="meno_age_c";
run;

** parity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') parity (ref='missing');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='flb_age_c_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='flb_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') marriage (ref='married');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='flb_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder2_base_mal_hormever; 
	set 
		null education bmi_c physic_c meno_age_c 
		parity flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder2_base_mal_hormever; 
	set confounder2_base_mal_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder2_base_mal_hormever.xls' style=minimal;
proc print data= confounder2_base_mal_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 3 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR, menoage- in situ, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, menoage, ins, base';
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort meno_age_c uvrq / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='flb_age_c_me';
	variable="Null_Model_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='flb_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='flb_age_c_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') parity (ref='missing');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='flb_age_c_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='flb_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') marriage (ref='married');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='flb_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder3_base_ins_hormever; 
	set 
		null education bmi_c physic_c 
		parity flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder3_base_ins_hormever; 
	set confounder3_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder3_base_ins_hormever.xls' style=minimal;
proc print data= confounder3_base_ins_hormever; run;
ods _all_ close;ods html;

********************************************************************************;
*** horm_ever, BC, UVR, menoage- mal, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, menoage, mal, base';
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='flb_age_c_me';
	variable="Null_Model_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='flb_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='flb_age_c_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') parity (ref='missing');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='flb_age_c_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='flb_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') marriage (ref='married');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='flb_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder3_base_mal_hormever; 
	set 
		null education bmi_c physic_c 
		parity flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder3_base_mal_hormever; 
	set confounder3_base_mal_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder3_base_mal_hormever.xls' style=minimal;
proc print data= confounder3_base_mal_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 4 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR menoage, educ_c- in situ, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, menoage, educ_c, ins, base';
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort meno_age_c uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='flb_age_c_me';
	variable="Null_Model_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** bmi;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='flb_age_c_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') parity (ref='missing');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='flb_age_c_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='flb_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='flb_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder4_base_ins_hormever; 
	set 
		null bmi_c physic_c 
		parity flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder4_base_ins_hormever; 
	set confounder4_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder4_base_ins_hormever.xls' style=minimal;
proc print data= confounder4_base_ins_hormever; run;
ods _all_ close;ods html;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, BMI- mal, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, menoage, BMI, mal, base';
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq bmi_c meno_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='flb_age_c_me';
	variable="Null_Model_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='flb_age_c_me';
	variable="educ_c";
run;

** physic_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') parity (ref='missing');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='flb_age_c_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='flb_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') marriage (ref='married');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='flb_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder4_base_mal_hormever; 
	set 
		null education physic_c 
		parity flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder4_base_mal_hormever; 
	set confounder4_base_mal_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder4_base_mal_hormever.xls' style=minimal;
proc print data= confounder4_base_mal_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 5 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR menoage, educ_c, marriage- in situ, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, menoage, educ_c, marriage, ins, base';
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort meno_age_c uvrq educ_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='flb_age_c_me';
	variable="Null_Model_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** bmi;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='flb_age_c_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') parity (ref='missing');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='flb_age_c_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='flb_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder5_base_ins_hormever; 
	set 
		null bmi_c physic_c 
		parity flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer; 
run;
data confounder5_base_ins_hormever; 
	set confounder5_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder5_base_ins_hormever.xls' style=minimal;
proc print data= confounder5_base_ins_hormever; run;
ods _all_ close;ods html;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, BMI, fmenstr- mal, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, menoage, BMI, mal, base';
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq bmi_c meno_age_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='flb_age_c_me';
	variable="Null_Model_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='flb_age_c_me';
	variable="educ_c";
run;

** physic_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') parity (ref='missing');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;

** smoking status;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='flb_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') marriage (ref='married');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='flb_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder5_base_mal_hormever; 
	set 
		null education physic_c 
		parity flb_age_c smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder5_base_mal_hormever; 
	set confounder5_base_mal_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder5_base_mal_hormever.xls' style=minimal;
proc print data= confounder5_base_mal_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 6 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, educ_c, marriage, bmi_c- in situ, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, menoage, educ_c, marriage, bmi, ins, base';
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='flb_age_c_me';
	variable="Null_Model_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') ;
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity  / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='flb_age_c_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='flb_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder6_base_ins_hormever; 
	set 
		null physic_c parity
		flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer; 
run;
data confounder6_base_ins_hormever; 
	set confounder6_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder6_base_ins_hormever.xls' style=minimal;
proc print data= confounder6_base_ins_hormever; run;
ods _all_ close;ods html;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, BMI, fmenstr, smoke_former- mal, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - horm_ever, birthcohort, UVR, menoage, BMI, fmenstr, smoke_former, mal, base';
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10')
		smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq bmi_c meno_age_c fmenstr smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='flb_age_c_me';
	variable="Null_Model_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='flb_age_c_me';
	variable="educ_c";
run;

** physic_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') parity (ref='missing');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;

** etoh_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked')  etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former etoh_c  / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run; 

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') marriage (ref='married');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='flb_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder6_base_mal_hormever; 
	set 
		null education physic_c 
		parity flb_age_c coffee_c etoh_c
		rel_1d_cancer marriage; 
run;
data confounder6_base_mal_hormever; 
	set confounder6_base_mal_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder6_base_mal_hormever.xls' style=minimal;
proc print data= confounder6_base_mal_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 7 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, educ_c, marriage, bmi_c, parity- in situ, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - 7 - horm_ever, birthcohort, UVR, menoage, educ_c, marriage, bmi_c, parity, ins, base';
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25') parity (ref='missing');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='flb_age_c_me';
	variable="Null_Model_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25') parity (ref='missing') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='flb_age_c_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='flb_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder7_base_ins_hormever; 
	set 
		null physic_c
		flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer; 
run;
data confounder7_base_ins_hormever; 
	set confounder7_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder7_base_ins_hormever.xls' style=minimal;
proc print data= confounder7_base_ins_hormever; run;
ods _all_ close;ods html;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, BMI, fmenstr, smoke_former, educ_c- mal, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - 7 - horm_ever, birthcohort, UVR, menoage, BMI, fmenstr, smoke_former, educ_c, mal, base';
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10')
		smoke_former (ref='never smoked') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq bmi_c meno_age_c fmenstr smoke_former educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='flb_age_c_me';
	variable="Null_Model_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** physic_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') parity (ref='missing');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;

** etoh_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c etoh_c  / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run; 

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') marriage (ref='married');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='flb_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder7_base_mal_hormever; 
	set 
		null physic_c 
		parity flb_age_c coffee_c etoh_c
		rel_1d_cancer marriage; 
run;
data confounder7_base_mal_hormever; 
	set confounder7_base_mal_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder7_base_mal_hormever.xls' style=minimal;
proc print data= confounder7_base_mal_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 8 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, educ_c, marriage, bmi_c, parity, fmenstr- in situ, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - 8 - horm_ever, birthcohort, UVR, menoage, educ_c, marriage, bmi_c, parity, fmenstr, ins, base';
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25') parity (ref='missing') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c parity fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='flb_age_c_me';
	variable="Null_Model_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') 
		fmenstr (ref='<=10') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25') parity (ref='missing') 
		fmenstr (ref='<=10') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;

** smoking status;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='flb_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') 
		fmenstr (ref='<=10') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') 
		fmenstr (ref='<=10') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') 
		fmenstr (ref='<=10') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder8_base_ins_hormever; 
	set 
		null physic_c
		flb_age_c smoke_former coffee_c etoh_c 
		rel_1d_cancer; 
run;
data confounder8_base_ins_hormever; 
	set confounder8_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder8_base_ins_hormever.xls' style=minimal;
proc print data= confounder8_base_ins_hormever; run;
ods _all_ close;ods html;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, BMI, fmenstr, smoke_former, educ_c, - mal, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - 8 - horm_ever, birthcohort, UVR, menoage, BMI, fmenstr, smoke_former, educ_c, marriage, mal, base';
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10')
		smoke_former (ref='never smoked') educ_c (ref='highschool or less')
		marriage (ref='married');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq bmi_c meno_age_c fmenstr smoke_former educ_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='flb_age_c_me';
	variable="Null_Model_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** physic_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') parity (ref='missing');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='flb_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;

** etoh_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage etoh_c  / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run; 

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= flb_age_c_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder8_base_mal_hormever; 
	set 
		null physic_c 
		parity flb_age_c coffee_c etoh_c
		rel_1d_cancer; 
run;
data confounder8_base_mal_hormever; 
	set confounder8_base_mal_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder8_base_mal_hormever.xls' style=minimal;
proc print data= confounder8_base_mal_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 9 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, educ_c, marriage, bmi_c, parity, fmenstr, smoke_former- in situ, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - 8 - horm_ever, birthcohort, UVR, menoage, educ_c, marriage, bmi_c, parity, fmenstr, smoke_former, ins, base';
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25') parity (ref='missing') fmenstr (ref='<=10')
		smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c parity fmenstr smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='flb_age_c_me';
	variable="Null_Model_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') physic_c (ref='rarely') ;
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** first live birth age;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25') parity (ref='missing') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='flb_age_c_me';
	variable="flb_age_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder9_base_ins_hormever; 
	set 
		null physic_c
		flb_age_c coffee_c etoh_c 
		rel_1d_cancer; 
run;
data confounder9_base_ins_hormever; 
	set confounder9_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder9_base_ins_hormever.xls' style=minimal;
proc print data= confounder9_base_ins_hormever; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 10 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** horm_ever, BC, UVR, menoage, educ_c, marriage, bmi_c, parity, fmenstr, smoke_former, flb_age_c- in situ, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - 10 - horm_ever, birthcohort, UVR, menoage, educ_c, marriage, bmi_c, parity, fmenstr, smoke_former,, flb_age_c ins, base';
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25') parity (ref='missing') fmenstr (ref='<=10')
		smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='flb_age_c_me';
	variable="Null_Model_flb_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old') physic_c (ref='rarely') ;
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='flb_age_c_me';
	variable="physic_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='flb_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='flb_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class flb_age_c_me (ref='< 20 years old') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='missing') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= flb_age_c_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='flb_age_c_me';
	variable="rel_1d_cancer";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder10_base_ins_hormever; 
	set 
		null physic_c
		coffee_c etoh_c 
		rel_1d_cancer; 
run;
data confounder10_base_ins_hormever; 
	set confounder10_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder10_base_ins_hormever.xls' style=minimal;
proc print data= confounder10_base_ins_hormever; run;
ods _all_ close;ods html;

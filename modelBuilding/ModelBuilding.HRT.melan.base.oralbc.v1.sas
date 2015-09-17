/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
#
# Model building v1
# !!!! for baseline dataset !!!!
#
# uses the conv.melan datasets
#
# Created: April 22 2015
# Updated: v20150505 WTL
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************/

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
libname results 'C:\REB\AARP_HRTandMelanoma\Results\modelBuilding';


********************************************************************************;
** Analysis of 1 Potential Confounder ******************************************;
********************************************************************************;

ods _all_ close;
ods html;

data use;
	set conv.melan;
run;

********************************************************************************;
** oralbc_dur_c_me, oral contraceptive duration, in situ **;
********************************************************************************;
** crude **;
proc phreg data = use;
	title 'crude model - oralbc, in situ, base';
	class oralbc_dur_c_me  (ref='none') ;
	model exit_age*melanoma_ins(0)= oralbc_dur_c_me  / entry = entry_age RL; 
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='oralbc_dur_c_me';
	variable="Null_Model_oralbc_dur_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** birth cohort;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me birth_cohort_me/ entry = entry_age RL; 
	ods output ParameterEstimates=birthcohort;
run;
data birthcohort; set birthcohort;
	if Parameter='oralbc_dur_c_me';
	variable="birthcohort_me";
run;

** education;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') educ_c_me (ref='highschool or less');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me educ_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='oralbc_dur_c_me';
	variable="educ_c_me";
run;

** bmi;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') bmi_c_me (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me bmi_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c_me;
run;
data bmi_c_me; set bmi_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="bmi_c_me";
run;

** physcial activity;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') physic_c_me (ref='rarely');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me physic_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c_me;
run;
data physic_c_me; set physic_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="physic_c_me";
run;

** menopause age;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') meno_age_c_me (ref='50-54');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me meno_age_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=meno_age_c_me;
run;
data meno_age_c_me; set meno_age_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="meno_age_c_me";
run;

** hyst age;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') hyst_age_c_me (ref='<45');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me hyst_age_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=hyst_age_c_me;
run;
data hyst_age_c_me; set hyst_age_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="hyst_age_c_me";
run;

** parity;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') parity_me (ref='nulliparous');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me parity_me/ entry = entry_age RL; 
	ods output ParameterEstimates=parity_me;
run;
data parity_me; set parity_me;
	if Parameter='oralbc_dur_c_me';
	variable="parity_me";
run;

** first live birth age;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') flb_age_c_me (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me flb_age_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c_me;
run;
data flb_age_c_me; set flb_age_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="flb_age_c_me";
run;

** menarche age;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') fmenstr_me (ref='<=10');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me fmenstr_me/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr_me;
run;
data fmenstr_me; set fmenstr_me;
	if Parameter='oralbc_dur_c_me';
	variable="fmenstr_me";
run;

** hormever;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') horm_ever_me (ref='never');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me horm_ever_me/ entry = entry_age RL; 
	ods output ParameterEstimates=horm_ever_me;
run;
data horm_ever_me; set horm_ever_me;
	if Parameter='oralbc_dur_c_me';
	variable="horm_ever_me";
run;

** UVR quartiles;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') uvrq_me (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me uvrq_me/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq_me;
run;
data uvrq_me; set uvrq_me;
	if Parameter='oralbc_dur_c_me';
	variable="uvrq_me";
run;

** smoking status;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') smoke_former_me (ref='none smoked');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me smoke_former_me/ entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former_me;
run;
data smoke_former_me; set smoke_former_me;
	if Parameter='oralbc_dur_c_me';
	variable="smoke_former_me";
run;

** coffee drinking;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') coffee_c_me (ref='none');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me coffee_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c_me;
run;
data coffee_c_me; set coffee_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="coffee_c_me";
run;

** etoh drinking;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') etoh_c_me (ref='none');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me etoh_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c_me;
run;
data etoh_c_me; set etoh_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="etoh_c_me";
run;

** family cancer history;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') rel_1d_cancer_me (ref='No');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me rel_1d_cancer_me/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer_me;
run;
data rel_1d_cancer_me; set rel_1d_cancer_me;
	if Parameter='oralbc_dur_c_me';
	variable="rel_1d_cancer_me";
run;

** marriage;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') marriage (ref='married');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me marriage/ entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='oralbc_dur_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder1_base_ins_oralbc_dur; 
	set 
		crude birthcohort
		education bmi_c_me physic_c_me 
		horm_ever_me parity_me flb_age_c_me fmenstr_me
		uvrq_me smoke_former_me coffee_c_me 
		etoh_c_me rel_1d_cancer_me marriage; 
run;
data confounder1_base_ins_oralbc_dur; 
	set confounder1_base_ins_oralbc_dur
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\confounder1_base_ins_oralbc_dur.xls ' style=minimal;
proc print data= confounder1_base_ins_oralbc_dur; run;
ods _all_ close;ods html;

********************************************************************************;
*** oralbc_dur_c_me, oral contraceptive duration, malignant **;
********************************************************************************;
** crude **;
proc phreg data = use;
	title 'crude model - oralbc, mal, base';
	class oralbc_dur_c_me  (ref='none') ;
	model exit_age*melanoma_mal(0)= oralbc_dur_c_me  / entry = entry_age RL; 
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='oralbc_dur_c_me';
	variable="Null_Model_oralbc_dur_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

data entryage; set entryage;
	if Parameter='oralbc_dur_c_me';
	variable="agecat_me";
run;

** birth cohort;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me birth_cohort_me/ entry = entry_age RL; 
	ods output ParameterEstimates=birthcohort;
run;
data birthcohort; set birthcohort;
	if Parameter='oralbc_dur_c_me';
	variable="birthcohort_me";
run;

** education;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') educ_c_me (ref='highschool or less');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me educ_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='oralbc_dur_c_me';
	variable="educ_c_me";
run;

** bmi;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') bmi_c_me (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me bmi_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c_me;
run;
data bmi_c_me; set bmi_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="bmi_c_me";
run;

** physcial activity;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') physic_c_me (ref='rarely');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me physic_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c_me;
run;
data physic_c_me; set physic_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="physic_c_me";
run;

** parity;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') parity_me (ref='nulliparous');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me parity_me/ entry = entry_age RL; 
	ods output ParameterEstimates=parity_me;
run;
data parity_me; set parity_me;
	if Parameter='oralbc_dur_c_me';
	variable="parity_me";
run;

** menarche age;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') fmenstr_me (ref='<=10');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me fmenstr_me/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr_me;
run;
data fmenstr_me; set fmenstr_me;
	if Parameter='oralbc_dur_c_me';
	variable="fmenstr_me";
run;

** first live birth age;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') flb_age_c_me (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me flb_age_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c_me;
run;
data flb_age_c_me; set flb_age_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="flb_age_c_me";
run;

** hormever;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') horm_ever_me (ref='never');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me horm_ever_me/ entry = entry_age RL; 
	ods output ParameterEstimates=horm_ever_me;
run;
data horm_ever_me; set horm_ever_me;
	if Parameter='oralbc_dur_c_me';
	variable="horm_ever_me";
run;

** UVR quartiles;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') uvrq_me (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me uvrq_me/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq_me;
run;
data uvrq_me; set uvrq_me;
	if Parameter='oralbc_dur_c_me';
	variable="uvrq_me";
run;

** smoking status;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') smoke_former_me (ref='never smoked');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me smoke_former_me/ entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former_me;
run;
data smoke_former_me; set smoke_former_me;
	if Parameter='oralbc_dur_c_me';
	variable="smoke_former_me";
run;

** coffee drinking;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') coffee_c_me (ref='none');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me coffee_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c_me;
run;
data coffee_c_me; set coffee_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="coffee_c_me";
run;

** etoh drinking;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') etoh_c_me (ref='none');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me etoh_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c_me;
run;
data etoh_c_me; set etoh_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="etoh_c_me";
run;

** family cancer history;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') rel_1d_cancer_me (ref='No');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me rel_1d_cancer_me/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer_me;
run;
data rel_1d_cancer_me; set rel_1d_cancer_me;
	if Parameter='oralbc_dur_c_me';
	variable="rel_1d_cancer_me";
run;

** marriage;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') marriage (ref='married');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me marriage/ entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='oralbc_dur_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder1_base_mal_oralbc_dur; 
	set 
		crude birthcohort
		education bmi_c_me physic_c_me
		horm_ever_me parity_me flb_age_c_me fmenstr_me
		uvrq_me smoke_former_me coffee_c_me 
		etoh_c_me rel_1d_cancer_me marriage; 
run;
data confounder1_base_mal_oralbc_dur; 
	set confounder1_base_mal_oralbc_dur
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\confounder1_base_mal_oralbc_dur.xls' style=minimal;
proc print data= confounder1_base_mal_oralbc_dur; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 1 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** oralbc, BC, UVR- in situ, base **;
********************************************************************************;
** null **;
proc phreg data = use;
	title 'null model - oralbc, birthcohort, UVR, ins, base';
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928') uvrq_me (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)= oralbc_dur_c_me birth_cohort_me uvrq_me / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='oralbc_dur_c_me';
	variable="Null_Model_oralbc_dur_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928') uvrq_me (ref='0 to 186.918') educ_c_me (ref='highschool or less');
	model exit_age*melanoma_ins(0)= oralbc_dur_c_me birth_cohort_me uvrq_me educ_c_me / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c_me;
run;
data education; set educ_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="educ_c_me";
run;

** bmi;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928') uvrq_me (ref='0 to 186.918') bmi_c_me (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)= oralbc_dur_c_me birth_cohort_me uvrq_me bmi_c_me / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c_me;
run;
data bmi_c_me; set bmi_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="bmi_c_me";
run;

** first live birth age;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928') uvrq_me (ref='0 to 186.918') flb_age_c_me (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= oralbc_dur_c_me birth_cohort_me uvrq_me flb_age_c_me / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c_me;
run;
data flb_age_c_me; set flb_age_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="flb_age_c_me";
run;

** hormever;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928') uvrq_me (ref='0 to 186.918') horm_ever_me (ref='never');
	model exit_age*melanoma_ins(0)= oralbc_dur_c_me birth_cohort_me uvrq_me horm_ever_me / entry = entry_age RL; 
	ods output ParameterEstimates=horm_ever_me;
run;
data horm_ever_me; set horm_ever_me;
	if Parameter='oralbc_dur_c_me';
	variable="horm_ever_me";
run;

** alchohol;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928') uvrq_me (ref='0 to 186.918') etoh_c_me (ref='none');
	model exit_age*melanoma_ins(0)= oralbc_dur_c_me birth_cohort_me uvrq_me etoh_c_me / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c_me;
run;
data etoh_c_me; set etoh_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="etoh_c_me";
run;

** smoking status;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928') uvrq_me (ref='0 to 186.918') smoke_former_me (ref='never smoked');
	model exit_age*melanoma_ins(0)= oralbc_dur_c_me birth_cohort_me uvrq_me smoke_former_me / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former_me;
run;
data smoke_former_me; set smoke_former_me;
	if Parameter='oralbc_dur_c_me';
	variable="smoke_former_me";
run;

** family cancer history;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928') uvrq_me (ref='0 to 186.918') rel_1d_cancer_me (ref='No');
	model exit_age*melanoma_ins(0)= oralbc_dur_c_me birth_cohort_me uvrq_me rel_1d_cancer_me / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer_me;
run;
data rel_1d_cancer_me; set rel_1d_cancer_me;
	if Parameter='oralbc_dur_c_me';
	variable="rel_1d_cancer_me";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder2_base_ins_oralbc; 
	set 
		null education horm_ever_me 
		bmi_c_me flb_age_c_me etoh_c_me smoke_former_me
		rel_1d_cancer_me; 
run;
data confounder2_base_ins_oralbc; 
	set confounder2_base_ins_oralbc
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\confounder2_base_ins_oralbc.xls' style=minimal;
proc print data= confounder2_base_ins_oralbc; run;
ods _all_ close;ods html;

********************************************************************************;
*** oralbc, BC, UVR- mal, base **;
********************************************************************************;
** null **;
proc phreg data = use;
	title 'null model - oralbc, birthcohort, UVR, mal, base';
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928') uvrq_me (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)= oralbc_dur_c_me birth_cohort_me uvrq_me / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='oralbc_dur_c_me';
	variable="Null_Model_oralbc_dur_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928') uvrq_me (ref='0 to 186.918') educ_c_me (ref='highschool or less');
	model exit_age*melanoma_mal(0)= oralbc_dur_c_me birth_cohort_me uvrq_me educ_c_me / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c_me;
run;
data education; set educ_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="educ_c_me";
run;

** bmi;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928') uvrq_me (ref='0 to 186.918') bmi_c_me (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)= oralbc_dur_c_me birth_cohort_me uvrq_me bmi_c_me / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c_me;
run;
data bmi_c_me; set bmi_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="bmi_c_me";
run;

** first live birth age;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928') uvrq_me (ref='0 to 186.918') flb_age_c_me (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= oralbc_dur_c_me birth_cohort_me uvrq_me flb_age_c_me / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c_me;
run;
data flb_age_c_me; set flb_age_c_me;
	if Parameter='oralbc_dur_c_me';
	variable="flb_age_c_me";
run;

** hormever;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928') uvrq_me (ref='0 to 186.918') horm_ever_me (ref='never');
	model exit_age*melanoma_mal(0)= oralbc_dur_c_me birth_cohort_me uvrq_me horm_ever_me / entry = entry_age RL; 
	ods output ParameterEstimates=horm_ever_me;
run;
data horm_ever_me; set horm_ever_me;
	if Parameter='oralbc_dur_c_me';
	variable="horm_ever_me";
run;

** smoking status;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928') uvrq_me (ref='0 to 186.918') smoke_former_me (ref='never smoked');
	model exit_age*melanoma_mal(0)= oralbc_dur_c_me birth_cohort_me uvrq_me smoke_former_me / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former_me;
run;
data smoke_former_me; set smoke_former_me;
	if Parameter='oralbc_dur_c_me';
	variable="smoke_former_me";
run;

** family cancer history;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928') uvrq_me (ref='0 to 186.918') rel_1d_cancer_me (ref='No');
	model exit_age*melanoma_mal(0)= oralbc_dur_c_me birth_cohort_me uvrq_me rel_1d_cancer_me / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer_me;
run;
data rel_1d_cancer_me; set rel_1d_cancer_me;
	if Parameter='oralbc_dur_c_me';
	variable="rel_1d_cancer_me";
run;

** marriage;
proc phreg data = use;
	class oralbc_dur_c_me  (ref='none') birth_cohort_me (ref='1925-1928') uvrq_me (ref='0 to 186.918') marriage (ref='married');
	model exit_age*melanoma_mal(0)= oralbc_dur_c_me birth_cohort_me uvrq_me marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='oralbc_dur_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder2_base_mal_oralbc; 
	set 
		null education horm_ever_me 
		bmi_c_me flb_age_c_me smoke_former_me 
		rel_1d_cancer_me marriage; 
run;
data confounder2_base_mal_oralbc; 
	set confounder2_base_mal_oralbc
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\confounder2_base_mal_oralbc.xls' style=minimal;
proc print data= confounder2_base_mal_oralbc; run;
ods _all_ close;ods html;

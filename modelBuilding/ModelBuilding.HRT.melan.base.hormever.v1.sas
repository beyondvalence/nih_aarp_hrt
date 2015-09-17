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
** horm_ever, hormone ever, in situ **;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title 'crude model - hormone ever, in situ, base';
	class horm_ever_me  (ref='never') ;
	model exit_age*melanoma_ins(0)= horm_ever_me  / entry = entry_age RL; 
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** birth cohort;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort_me (ref='1925-1928');
	model exit_age*melanoma_ins(0)=horm_ever_me birth_cohort_me/ entry = entry_age RL; 
	ods output ParameterEstimates=birthcohort;
run;
data birthcohort; set birthcohort;
	if Parameter='horm_ever_me';
	variable="birthcohort_me";
run;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') educ_c_me (ref='highschool or less');
	model exit_age*melanoma_ins(0)=horm_ever_me educ_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='horm_ever_me';
	variable="educ_c_me";
run;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') bmi_c_me (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=horm_ever_me bmi_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c_me;
run;
data bmi_c_me; set bmi_c_me;
	if Parameter='horm_ever_me';
	variable="bmi_c_me";
run;

** physcial activity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') physic_c_me (ref='rarely');
	model exit_age*melanoma_ins(0)=horm_ever_me physic_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c_me;
run;
data physic_c_me; set physic_c_me;
	if Parameter='horm_ever_me';
	variable="physic_c_me";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') parity_me (ref='nulliparous');
	model exit_age*melanoma_ins(0)=horm_ever_me parity_me/ entry = entry_age RL; 
	ods output ParameterEstimates=parity_me;
run;
data parity_me; set parity_me;
	if Parameter='horm_ever_me';
	variable="parity_me";
run;

** age at menarche;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') fmenstr_me (ref='<=10');
	model exit_age*melanoma_ins(0)=horm_ever_me fmenstr_me/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr_me;
run;
data fmenstr_me; set fmenstr_me;
	if Parameter='horm_ever_me';
	variable="fmenstr_me";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') flb_age_c_me (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=horm_ever_me flb_age_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c_me;
run;
data flb_age_c_me; set flb_age_c_me;
	if Parameter='horm_ever_me';
	variable="flb_age_c_me";
run;

** oral bc duration;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') oralbc_dur_c_me (ref='never');
	model exit_age*melanoma_ins(0)=horm_ever_me oralbc_dur_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=oralbc_dur_c_me;
run;
data oralbc_dur_c_me; set oralbc_dur_c_me;
	if Parameter='horm_ever_me';
	variable="oralbc_dur_c_me";
run;

** UVR quartiles;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') uvrq_me (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq_me/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq_me;
run;
data uvrq_me; set uvrq_me;
	if Parameter='horm_ever_me';
	variable="uvrq_me";
run;

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') smoke_former_me (ref='never smoked');
	model exit_age*melanoma_ins(0)=horm_ever_me smoke_former_me/ entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former_me;
run;
data smoke_former_me; set smoke_former_me;
	if Parameter='horm_ever_me';
	variable="smoke_former_me";
run;

** coffee drinking;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') coffee_c_me (ref='none');
	model exit_age*melanoma_ins(0)=horm_ever_me coffee_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c_me;
run;
data coffee_c_me; set coffee_c_me;
	if Parameter='horm_ever_me';
	variable="coffee_c_me";
run;

** etoh drinking;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') etoh_c_me (ref='none');
	model exit_age*melanoma_ins(0)=horm_ever_me etoh_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c_me;
run;
data etoh_c_me; set etoh_c_me;
	if Parameter='horm_ever_me';
	variable="etoh_c_me";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') rel_1d_cancer_me (ref='No');
	model exit_age*melanoma_ins(0)=horm_ever_me rel_1d_cancer_me/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer_me;
run;
data rel_1d_cancer_me; set rel_1d_cancer_me;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer_me";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') marriage (ref='married');
	model exit_age*melanoma_ins(0)=horm_ever_me marriage/ entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder1_base_ins_hormever; 
	set 
		crude birthcohort
		education bmi_c_me physic_c_me 
		parity_me flb_age_c_me fmenstr_me
		oralbc_dur_c_me uvrq_me smoke_former_me coffee_c_me 
		etoh_c_me rel_1d_cancer_me marriage; 
run;
data confounder1_base_ins_hormever; 
	set confounder1_base_ins_hormever
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\confounder1_testing_ins_hormever.xls' style=minimal;
proc print data= confounder1_base_ins_hormever; run;
ods _all_ close;ods html;

********************************************************************************;
*** horm_ever, hormone ever, malignant **;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title 'crude model - hormone ever, mal, base';
	class horm_ever_me  (ref='never') ;
	model exit_age*melanoma_mal(0)= horm_ever_me  / entry = entry_age RL; 
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

data entryage; set entryage;
	if Parameter='horm_ever_me';
	variable="agecat_me";
run;

** birth cohort;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort_me (ref='1925-1928');
	model exit_age*melanoma_mal(0)=horm_ever_me birth_cohort_me/ entry = entry_age RL; 
	ods output ParameterEstimates=birthcohort;
run;
data birthcohort; set birthcohort;
	if Parameter='horm_ever_me';
	variable="birthcohort_me";
run;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') educ_c_me (ref='highschool or less');
	model exit_age*melanoma_mal(0)=horm_ever_me educ_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='horm_ever_me';
	variable="educ_c_me";
run;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') bmi_c_me (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=horm_ever_me bmi_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c_me;
run;
data bmi_c_me; set bmi_c_me;
	if Parameter='horm_ever_me';
	variable="bmi_c_me";
run;

** physcial activity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') physic_c_me (ref='rarely');
	model exit_age*melanoma_mal(0)=horm_ever_me physic_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c_me;
run;
data physic_c_me; set physic_c_me;
	if Parameter='horm_ever_me';
	variable="physic_c_me";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') parity_me (ref='nulliparous');
	model exit_age*melanoma_mal(0)=horm_ever_me parity_me/ entry = entry_age RL; 
	ods output ParameterEstimates=parity_me;
run;
data parity_me; set parity_me;
	if Parameter='horm_ever_me';
	variable="parity_me";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') flb_age_c_me (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=horm_ever_me flb_age_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c_me;
run;
data flb_age_c_me; set flb_age_c_me;
	if Parameter='horm_ever_me';
	variable="flb_age_c_me";
run;

** age at menarche;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') fmenstr_me (ref='<=10');
	model exit_age*melanoma_mal(0)=horm_ever_me fmenstr_me/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr_me;
run;
data fmenstr_me; set fmenstr_me;
	if Parameter='horm_ever_me';
	variable="fmenstr_me";
run;

** oral bc duration;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') oralbc_dur_c_me (ref='never');
	model exit_age*melanoma_mal(0)=horm_ever_me oralbc_dur_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=oralbc_dur_c_me;
run;
data oralbc_dur_c_me; set oralbc_dur_c_me;
	if Parameter='horm_ever_me';
	variable="oralbc_dur_c_me";
run;

** UVR quartiles;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') uvrq_me (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq_me/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq_me;
run;
data uvrq_me; set uvrq_me;
	if Parameter='horm_ever_me';
	variable="uvrq_me";
run;

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') smoke_former_me (ref='never smoked');
	model exit_age*melanoma_mal(0)=horm_ever_me smoke_former_me/ entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former_me;
run;
data smoke_former_me; set smoke_former_me;
	if Parameter='horm_ever_me';
	variable="smoke_former_me";
run;

** coffee drinking;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') coffee_c_me (ref='none');
	model exit_age*melanoma_mal(0)=horm_ever_me coffee_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c_me;
run;
data coffee_c_me; set coffee_c_me;
	if Parameter='horm_ever_me';
	variable="coffee_c_me";
run;

** etoh drinking;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') etoh_c_me (ref='none');
	model exit_age*melanoma_mal(0)=horm_ever_me etoh_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c_me;
run;
data etoh_c_me; set etoh_c_me;
	if Parameter='horm_ever_me';
	variable="etoh_c_me";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') rel_1d_cancer_me (ref='No');
	model exit_age*melanoma_mal(0)=horm_ever_me rel_1d_cancer_me/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer_me;
run;
data rel_1d_cancer_me; set rel_1d_cancer_me;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer_me";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') marriage (ref='married');
	model exit_age*melanoma_mal(0)=horm_ever_me marriage/ entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
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
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='horm_ever_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='horm_ever_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** meno_age_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=meno_age_c;
run;
data meno_age_c; set meno_age_c;
	if Parameter='horm_ever_me';
	variable="meno_age_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') marriage (ref='married');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
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
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='horm_ever_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='horm_ever_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** meno_age_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=meno_age_c;
run;
data meno_age_c; set meno_age_c;
	if Parameter='horm_ever_me';
	variable="meno_age_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') marriage (ref='married');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
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
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort meno_age_c uvrq / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='horm_ever_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='horm_ever_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') marriage (ref='married');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
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
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='horm_ever_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='horm_ever_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') marriage (ref='married');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
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
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort meno_age_c uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='horm_ever_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
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
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq bmi_c meno_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='horm_ever_me';
	variable="educ_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') marriage (ref='married');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
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
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort meno_age_c uvrq educ_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** bmi;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='horm_ever_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
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
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq bmi_c meno_age_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='horm_ever_me';
	variable="educ_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') marriage (ref='married');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
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
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') ;
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity  / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
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
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10')
		smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq bmi_c meno_age_c fmenstr smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='horm_ever_me';
	variable="educ_c";
run;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** etoh_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked')  etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former etoh_c  / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') marriage (ref='married');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
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
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='horm_ever_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
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
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10')
		smoke_former (ref='never smoked') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq bmi_c meno_age_c fmenstr smoke_former educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** etoh_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c etoh_c  / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') marriage (ref='married');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='horm_ever_me';
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
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c parity fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** smoking status;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='horm_ever_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
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
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10')
		smoke_former (ref='never smoked') educ_c (ref='highschool or less')
		marriage (ref='married');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq bmi_c meno_age_c fmenstr smoke_former educ_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='horm_ever_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** etoh_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage etoh_c  / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to < 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= horm_ever_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
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
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') fmenstr (ref='<=10')
		smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c parity fmenstr smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') physic_c (ref='rarely') ;
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** first live birth age;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='horm_ever_me';
	variable="flb_age_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
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
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') fmenstr (ref='<=10')
		smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='horm_ever_me';
	variable="Null_Model_horm_ever_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old') physic_c (ref='rarely') ;
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='horm_ever_me';
	variable="physic_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='horm_ever_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='horm_ever_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class horm_ever_me  (ref='never') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to < 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= horm_ever_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='horm_ever_me';
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

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
# Updated: v20150507 WTL
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
** meno_age_c_me, age at natural menopause, in situ **;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title 'crude model - menoage, in situ, base';
	class meno_age_c_me  (ref='50-54') ;
	model exit_age*melanoma_ins(0)= meno_age_c_me  / entry = entry_age RL; 
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='meno_age_c_me';
	variable="Null_Model_meno_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** birth cohort;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928');
	model exit_age*melanoma_ins(0)=meno_age_c_me birth_cohort/ entry = entry_age RL; 
	ods output ParameterEstimates=birthcohort;
run;
data birthcohort; set birthcohort;
	if Parameter='meno_age_c_me';
	variable="birthcohort";
run;

** education;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=meno_age_c_me educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='meno_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)=meno_age_c_me bmi_c/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='meno_age_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)=meno_age_c_me physic_c/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='meno_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)=meno_age_c_me parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='meno_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)=meno_age_c_me flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='meno_age_c_me';
	variable="flb_age_c";
run;

** menarche age;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)=meno_age_c_me fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='meno_age_c_me';
	variable="fmenstr";
run;

** hormever;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') horm_ever (ref='never');
	model exit_age*melanoma_ins(0)=meno_age_c_me horm_ever / entry = entry_age RL; 
	ods output ParameterEstimates=horm_ever;
run;
data horm_ever; set horm_ever;
	if Parameter='meno_age_c_me';
	variable="horm_ever";
run;

** UVR quartiles;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=meno_age_c_me uvrq / entry = entry_age RL; 
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='meno_age_c_me';
	variable="uvrq";
run;

** smoking status;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)=meno_age_c_me smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='meno_age_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)=meno_age_c_me coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='meno_age_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)=meno_age_c_me etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='meno_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)=meno_age_c_me rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='meno_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') marriage (ref='married');
	model exit_age*melanoma_ins(0)=meno_age_c_me marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='meno_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder1_base_ins_menoage; 
	set 
		crude birthcohort
		education bmi_c physic_c 
		horm_ever parity flb_age_c fmenstr
		uvrq smoke_former coffee_c 
		etoh_c rel_1d_cancer marriage; 
run;
data confounder1_base_ins_menoage; 
	set confounder1_base_ins_menoage
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder1_base_ins_menoage3.xls ' style=minimal;
proc print data= confounder1_base_ins_menoage; run;
ods _all_ close;ods html;

********************************************************************************;
*** meno_age_c_me, age at menopause, malignant **;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title 'crude model - menoage, mal, base';
	class meno_age_c_me  (ref='50-54') ;
	model exit_age*melanoma_mal(0)= meno_age_c_me  / entry = entry_age RL; 
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='meno_age_c_me';
	variable="Null_Model_meno_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** birth cohort;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928');
	model exit_age*melanoma_mal(0)=meno_age_c_me birth_cohort/ entry = entry_age RL; 
	ods output ParameterEstimates=birthcohort;
run;
data birthcohort; set birthcohort;
	if Parameter='meno_age_c_me';
	variable="birthcohort";
run;

** education;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=meno_age_c_me educ_c/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='meno_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)=meno_age_c_me bmi_c/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='meno_age_c_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=meno_age_c_me physic_c/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='meno_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)=meno_age_c_me parity/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='meno_age_c_me';
	variable="parity";
run;

** menarche age;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=meno_age_c_me fmenstr/ entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='meno_age_c_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=meno_age_c_me flb_age_c/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='meno_age_c_me';
	variable="flb_age_c";
run;

** hormever;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') horm_ever (ref='never');
	model exit_age*melanoma_mal(0)=meno_age_c_me horm_ever/ entry = entry_age RL; 
	ods output ParameterEstimates=horm_ever;
run;
data horm_ever; set horm_ever;
	if Parameter='meno_age_c_me';
	variable="horm_ever";
run;

** UVR quartiles;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=meno_age_c_me uvrq/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='meno_age_c_me';
	variable="uvrq";
run;

** smoking status;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=meno_age_c_me smoke_former/ entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='meno_age_c_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=meno_age_c_me coffee_c/ entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='meno_age_c_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=meno_age_c_me etoh_c/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='meno_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=meno_age_c_me rel_1d_cancer/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='meno_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') marriage (ref='married');
	model exit_age*melanoma_mal(0)=meno_age_c_me marriage/ entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='meno_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder1_base_mal_menoage; 
	set 
		crude birthcohort
		education bmi_c physic_c
		horm_ever parity flb_age_c fmenstr
		uvrq smoke_former coffee_c 
		etoh_c rel_1d_cancer marriage; 
run;
data confounder1_base_mal_menoage; 
	set confounder1_base_mal_menoage
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder1_base_malnoage3.xls' style=minimal;
proc print data= confounder1_base_mal_menoage; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 2 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** menoage, BC, UVR- in situ, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - menoage, birthcohort, UVR, ins, base';
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='meno_age_c_me';
	variable="Null_Model_meno_age_c";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='meno_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='meno_age_c_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='meno_age_c_me';
	variable="physic_c";
run;

** horm_ever;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever / entry = entry_age RL; 
	ods output ParameterEstimates=horm_ever;
run;
data horm_ever; set horm_ever;
	if Parameter='meno_age_c_me';
	variable="horm_ever";
run;

** parity;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='meno_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='meno_age_c_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data fmenstr; set fmenstr;
	if Parameter='meno_age_c_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='meno_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='meno_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='meno_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='meno_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') marriage (ref='married');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='meno_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder2_base_ins_menoage; 
	set 
		null education bmi_c physic_c horm_ever 
		parity flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder2_base_ins_menoage; 
	set confounder2_base_ins_menoage
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder2_base_ins_menoage.xls' style=minimal;
proc print data= confounder2_base_ins_menoage; run;
ods _all_ close;ods html;

********************************************************************************;
*** menoage, BC, UVR- mal, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - menoage, birthcohort, UVR, mal, base';
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='meno_age_c_me';
	variable="Null_Model_meno_age_c";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='meno_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='meno_age_c_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='meno_age_c_me';
	variable="physic_c";
run;

** horm_ever;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq horm_ever / entry = entry_age RL; 
	ods output ParameterEstimates=horm_ever;
run;
data horm_ever; set horm_ever;
	if Parameter='meno_age_c_me';
	variable="horm_ever";
run;

** parity;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='meno_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='meno_age_c_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='meno_age_c_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='meno_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='meno_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='meno_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='meno_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') marriage (ref='married');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='meno_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder2_base_mal_menoage; 
	set 
		null education bmi_c physic_c horm_ever 
		parity flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder2_base_mal_menoage; 
	set confounder2_base_mal_menoage
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder2_base_mal_menoage.xls' style=minimal;
proc print data= confounder2_base_mal_menoage; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 3 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** menoage, BC, UVR, horm_ever- in situ, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - menoage, birthcohort, UVR, horm_ever, ins, base';
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='meno_age_c_me';
	variable="Null_Model_meno_age_c";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='meno_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='meno_age_c_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='meno_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='meno_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='meno_age_c_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='meno_age_c_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='meno_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='meno_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='meno_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='meno_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') marriage (ref='married');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='meno_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder3_base_ins_menoage; 
	set 
		null education bmi_c physic_c
		parity flb_age_c fmenstr smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder3_base_ins_menoage; 
	set confounder3_base_ins_menoage
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder3_base_ins_menoage.xls' style=minimal;
proc print data= confounder3_base_ins_menoage; run;
ods _all_ close;ods html;

********************************************************************************;
*** menoage, BC, UVR, fmenstr- mal, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - menoage, birthcohort, UVR, fmenstr, mal, base';
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='meno_age_c_me';
	variable="Null_Model_meno_age_c";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq educ_c fmenstr / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='meno_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq fmenstr bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='meno_age_c_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq fmenstr physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='meno_age_c_me';
	variable="physic_c";
run;

** horm_ever;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10') horm_ever (ref='never');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq fmenstr horm_ever / entry = entry_age RL; 
	ods output ParameterEstimates=horm_ever;
run;
data horm_ever; set horm_ever;
	if Parameter='meno_age_c_me';
	variable="horm_ever";
run;

** parity;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq fmenstr parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='meno_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq fmenstr flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='meno_age_c_me';
	variable="flb_age_c";
run;

** smoking status;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10') smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq fmenstr smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='meno_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq fmenstr coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='meno_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq fmenstr etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='meno_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq fmenstr rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='meno_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10') marriage (ref='married');
	model exit_age*melanoma_mal(0)= meno_age_c_me birth_cohort uvrq fmenstr marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='meno_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder3_base_mal_menoage; 
	set 
		null education bmi_c physic_c horm_ever 
		parity flb_age_c smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder3_base_mal_menoage; 
	set confounder3_base_mal_menoage
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder3_base_mal_menoage.xls' style=minimal;
proc print data= confounder3_base_mal_menoage; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 4 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** menoage, BC, UVR, horm_ever, fmenstr- in situ, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - menoage, birthcohort, UVR, horm_ever, fmenstr, ins, base';
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr/ entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='meno_age_c_me';
	variable="Null_Model_meno_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='meno_age_c_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c / entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='meno_age_c_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='meno_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='meno_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='meno_age_c_me';
	variable="flb_age_c";
run;

** smoking status;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='meno_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='meno_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='meno_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='meno_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') marriage (ref='married');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='meno_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder4_base_ins_menoage; 
	set 
		null education bmi_c physic_c
		parity flb_age_c smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder4_base_ins_menoage; 
	set confounder4_base_ins_menoage
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder4_base_ins_menoage.xls' style=minimal;
proc print data= confounder4_base_ins_menoage; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 5 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** menoage, BC, UVR, horm_ever, fmenstr, bmi_c- in situ, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - menoage, birthcohort, UVR, horm_ever, fmenstr, bmi_c, ins, base';
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c/ entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='meno_age_c_me';
	variable="Null_Model_meno_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever bmi_c fmenstr educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='meno_age_c_me';
	variable="educ_c";
run;

** physic_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='meno_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='meno_age_c_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='meno_age_c_me';
	variable="flb_age_c";
run;

** smoking status;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='meno_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='meno_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='meno_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;MHT
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='meno_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') marriage (ref='married');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='meno_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder5_base_ins_menoage; 
	set 
		null education physic_c
		parity flb_age_c smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder5_base_ins_menoage; 
	set confounder5_base_ins_menoage
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder5_base_ins_menoage.xls' style=minimal;
proc print data= confounder5_base_ins_menoage; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 6 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** menoage, BC, UVR, horm_ever, fmenstr, bmi_c, flb- in situ, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - menoage, birthcohort, UVR, horm_ever, fmenstr, bmi_c, flb_age_c, ins, base';
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr flb_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='meno_age_c_me';
	variable="Null_Model_meno_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever bmi_c fmenstr flb_age_c educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='meno_age_c_me';
	variable="educ_c";
run;

** physic_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='meno_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='meno_age_c_me';
	variable="parity";
run;

** smoking status;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='meno_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='meno_age_c_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='meno_age_c_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='meno_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') marriage (ref='married');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='meno_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder6_base_ins_menoage; 
	set 
		null education physic_c
		parity smoke_former coffee_c etoh_c 
		rel_1d_cancer marriage; 
run;
data confounder6_base_ins_menoage; 
	set confounder6_base_ins_menoage
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder6_base_ins_menoage.xls' style=minimal;
proc print data= confounder6_base_ins_menoage; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 7 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** menoage, BC, UVR, horm_ever, fmenstr, bmi_c, flb, etoh_c- in situ, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - menoage, birthcohort, UVR, horm_ever, fmenstr, bmi_c, flb_age_c, etoh_c, ins, base';
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr flb_age_c etoh_c / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='meno_age_c_me';
	variable="Null_Model_meno_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') etoh_c (ref='none') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever bmi_c fmenstr flb_age_c etoh_c educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='meno_age_c_me';
	variable="educ_c";
run;

** physic_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') etoh_c (ref='none') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c etoh_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='meno_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') etoh_c (ref='none') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c etoh_c parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='meno_age_c_me';
	variable="parity";
run;

** smoking status;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') etoh_c (ref='none') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c etoh_c smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='meno_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') etoh_c (ref='none') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c etoh_c coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='meno_age_c_me';
	variable="coffee_c";
run; 

** family cancer history;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') etoh_c (ref='none') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c etoh_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='meno_age_c_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') etoh_c (ref='none') marriage (ref='married');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c etoh_c marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='meno_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder7_base_ins_menoage; 
	set 
		null education physic_c
		parity smoke_former coffee_c  
		rel_1d_cancer marriage; 
run;
data confounder7_base_ins_menoage; 
	set confounder7_base_ins_menoage
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder7_base_ins_menoage.xls' style=minimal;
proc print data= confounder7_base_ins_menoage; run;
ods _all_ close;ods html;

****************************************************************************************;
** Analysis of BC+UVR, 8 Potential Confounders *****************************************;
****************************************************************************************;

********************************************************************************;
*** menoage, BC, UVR, horm_ever, fmenstr, bmi_c, flb, etoh_c, rel_1d_cancer- in situ, base **;
********************************************************************************;
** null **;
proc phreg data = use multipass;
	title 'null model - menoage, birthcohort, UVR, horm_ever, fmenstr, bmi_c, flb_age_c, etoh_c, rel_1d_cancer ins, base';
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') etoh_c (ref='none')
		rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr flb_age_c etoh_c rel_1d_cancer / entry = entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='meno_age_c_me';
	variable="Null_Model_meno_age_c_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') 
		etoh_c (ref='none') rel_1d_cancer (ref='No') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever bmi_c fmenstr flb_age_c etoh_c rel_1d_cancer educ_c / entry = entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='meno_age_c_me';
	variable="educ_c";
run;

** physic_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') 
		etoh_c (ref='none') rel_1d_cancer (ref='No') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c etoh_c rel_1d_cancer physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='meno_age_c_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') 
		etoh_c (ref='none') rel_1d_cancer (ref='No') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c etoh_c rel_1d_cancer parity / entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='meno_age_c_me';
	variable="parity";
run;

** smoking status;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') 
		etoh_c (ref='none') rel_1d_cancer (ref='No') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c etoh_c rel_1d_cancer smoke_former / entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='meno_age_c_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') 
		etoh_c (ref='none') rel_1d_cancer (ref='No') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c etoh_c rel_1d_cancer coffee_c / entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='meno_age_c_me';
	variable="coffee_c";
run; 

** marriage;
proc phreg data = use multipass;
	class meno_age_c_me  (ref='50-54') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		horm_ever (ref='never') fmenstr (ref='<=10') bmi_c (ref='18.5 to < 25') flb_age_c (ref='< 20 years old') 
		etoh_c (ref='none') rel_1d_cancer (ref='No') marriage (ref='married');
	model exit_age*melanoma_ins(0)= meno_age_c_me birth_cohort uvrq horm_ever fmenstr bmi_c flb_age_c etoh_c rel_1d_cancer marriage / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='meno_age_c_me';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data confounder8_base_ins_menoage; 
	set 
		null education physic_c
		parity smoke_former coffee_c  
		marriage; 
run;
data confounder8_base_ins_menoage; 
	set confounder8_base_ins_menoage
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\modelBuilding\step\confounder8_base_ins_menoage.xls' style=minimal;
proc print data= confounder8_base_ins_menoage; run;
ods _all_ close;ods html;

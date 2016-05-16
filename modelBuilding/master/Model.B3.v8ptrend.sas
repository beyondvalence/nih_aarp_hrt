/*****************************************************************************;
#             NIH-AARP UVR- Reproductive Factors- Melanoma Study
/*****************************************************************************;
#
# Model Building B3v8 p-trends:
# Main Effect= ME
# !!!! for both baseline and riskfactor datasets !!!!
#
# uses the conv.melan, conv.melan_r datasets
#
# Created: May 09 2016 WTL
# Updatedv8: v20160516MON WTL
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
******************************************************************************/

libname conv "C:\REB\AARP_HRTandMelanoma\Data\converted";
libname results "C:\REB\AARP_HRTandMelanoma\Results";
ods _all_ close;
ods html;

******************************************************************************;
******************************************************************************;
************************** BASELINE ******************************************;
******************************************************************************;
******************************************************************************;
%include "C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\formats.20150714.base.sas";
data use;
	set conv.melan;
run;

title1 "base table2 ptrends";

******************************************************************************;
********************************************************************************;
** B01_ins_mal
** ME: fmenstr_me (ref="15+")  
** melanoma: _ins_mal, 
********************************************************************************;
title2 "fmenstr_me ";
proc phreg data = use multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never") menop_age_c (ref="1. <45");
	model exit_age*melanoma_ins(0)=fmenstr_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c / entry = entry_age RL; 
run;

proc phreg data = use multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never") menop_age_c (ref="1. <45");
	model exit_age*melanoma_mal(0)=fmenstr_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c / entry = entry_age RL; 
run;

******************************************************************************;
********************************************************************************;
** B02_ins_mal
** ME: menop_age_me (ref="<45")
** melanoma: _ins_mal, 
********************************************************************************;
title2 'menop_age_me ';
proc phreg data = use multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never") menostat_c (ref="Natural menopause");
	model exit_age*melanoma_ins(0)=menop_age_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menostat_c / entry = entry_age RL; 
run;

proc phreg data = use multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never") menostat_c (ref="Natural menopause");
	model exit_age*melanoma_mal(0)=menop_age_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menostat_c / entry = entry_age RL; 
run;

******************************************************************************;
********************************************************************************;
** B03_ins_mal
** ME: parity_me (ref="1-2 live children")  
** melanoma: _ins_mal, 
********************************************************************************;
title2 'parity_me ';
proc phreg data = use multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never");
	model exit_age*melanoma_ins(0)=parity_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
run;

proc phreg data = use multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never");
	model exit_age*melanoma_mal(0)=parity_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
run;

******************************************************************************;
********************************************************************************;
** B04_ins_mal
** ME: flb_age_me (ref="< 20 years old")  
** melanoma: _ins_mal, 
********************************************************************************;
title2 'flb_age_me ';
proc phreg data = use multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never");
	model exit_age*melanoma_ins(0)=flb_age_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
run;

proc phreg data = use multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never");
	model exit_age*melanoma_mal(0)=flb_age_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
run;

******************************************************************************;
********************************************************************************;
** B05_ins_mal
** ME: oralbc_dur_me (ref="Never/<1yr")  
** melanoma: _ins_mal, 
********************************************************************************;
title2 'oralbc_dur_me ';
proc phreg data = use multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never");
	model exit_age*melanoma_ins(0)=oralbc_dur_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
run;

proc phreg data = use multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never");
	model exit_age*melanoma_mal(0)=oralbc_dur_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
run;

******************************************************************************;
********************************************************************************;
** B06_ins_mal
** ME: horm_yrs_me (ref="Never used")  
** melanoma: _ins_mal, 
********************************************************************************;
title2 'horm_yrs_me';
proc phreg data = use multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No");
	model exit_age*melanoma_ins(0) = horm_yrs_me fmenstr uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL;
run;

proc phreg data = use multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No");
	model exit_age*melanoma_mal(0) = horm_yrs_me fmenstr uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL;
run;
ods _all_ close;
ods html;

******************************************************************************;
******************************************************************************;
************************** RISKFACTOR ****************************************;
******************************************************************************;
******************************************************************************;
%include "C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\formats.20150714.risk.sas";
data use_r;
	set conv.melan_r;
run;

title1 "risk table2 ptrends";

******************************************************************************;
********************************************************************************;
** R01_ins_mal
** ME: fmenstr_me (ref="15+")  
** melanoma: _ins_mal, 
********************************************************************************;
title2 "fmenstr_me ";
proc phreg data = use_r multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never") menop_age_c;
	model exit_age*melanoma_ins(0)=fmenstr_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c / entry = entry_age RL; 
run;

proc phreg data = use_r multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never") menop_age_c;
	model exit_age*melanoma_mal(0)=fmenstr_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c / entry = entry_age RL; 
run;

******************************************************************************;
********************************************************************************;
** R02_ins_mal
** ME: menop_age_me (ref="<45")
** melanoma: _ins_mal, 
********************************************************************************;
title2 'menop_age_me ';
proc phreg data = use_r multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never") menostat_c (ref="Natural menopause");
	model exit_age*melanoma_ins(0)=menop_age_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menostat_c / entry = entry_age RL; 
run;

proc phreg data = use_r multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never") menostat_c (ref="Natural menopause");
	model exit_age*melanoma_mal(0)=menop_age_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menostat_c / entry = entry_age RL; 
run;

******************************************************************************;
********************************************************************************;
** R03_ins_mal
** ME: parity_me (ref="1-2 live children")  
** melanoma: _ins_mal, 
********************************************************************************;
title2 'parity_me ';
proc phreg data = use_r multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never");
	model exit_age*melanoma_ins(0)=parity_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
run;

proc phreg data = use_r multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never");
	model exit_age*melanoma_mal(0)=parity_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
run;

******************************************************************************;
********************************************************************************;
** R04_ins_mal
** ME: flb_age_me (ref="< 20 years old")  
** melanoma: _ins_mal, 
********************************************************************************;
title2 'flb_age_me ';
proc phreg data = use_r multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never");
	model exit_age*melanoma_ins(0)=flb_age_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
run;

proc phreg data = use_r multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never");
	model exit_age*melanoma_mal(0)=flb_age_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
run;

******************************************************************************;
********************************************************************************;
** R05_ins_mal
** ME: oralbc_dur_me (ref="Never/<1yr")  
** melanoma: _ins_mal, 
********************************************************************************;
title2 'oralbc_dur_me ';
proc phreg data = use_r multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never");
	model exit_age*melanoma_ins(0)=oralbc_dur_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
run;

proc phreg data = use_r multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No") mht_ever_c (ref="Never");
	model exit_age*melanoma_mal(0)=oralbc_dur_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
run;

******************************************************************************;
********************************************************************************;
** R06_ins_mal
** ME: horm_yrs_me (ref="Never used")  
** melanoma: _ins_mal, 
********************************************************************************;
title2 'horm_yrs_me ';
proc phreg data = use_r multipass;
	class uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No");
	model exit_age*melanoma_ins(0) = horm_yrs_me fmenstr uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL;
run;

proc phreg data = use_r multipass;
	class uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No");
	model exit_age*melanoma_mal(0) = horm_yrs_me fmenstr uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL;
run;
******************************************************************************;
********************************************************************************;
** R07_ins_mal
** ME: l_eptdose_me (ref="<1")  
** melanoma: _ins_mal,
********************************************************************************;
title2 'l_eptdose_me ';
proc phreg data = use_r multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No");
	model exit_age*melanoma_ins(0)=l_eptdose_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
run;

proc phreg data = use_r multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No");
	model exit_age*melanoma_mal(0)=l_eptdose_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
run;
******************************************************************************;
********************************************************************************;
** R08_ins_mal
** ME: l_eptdur_me (ref="<5")  
** melanoma: _ins_mal, 
********************************************************************************;
title2 'l_eptdur_me ';
proc phreg data = use_r multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No");
	model exit_age*melanoma_ins(0)=l_eptdur_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
run;

proc phreg data = use_r multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No");
	model exit_age*melanoma_mal(0)=l_eptdur_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_eptdur NObs = obs;
run;

******************************************************************************;
********************************************************************************;
** R09_ins_mal
** ME: l_etdose_me (ref="1. 0.3 mg")  
** melanoma: _ins_mal, 
********************************************************************************;
title2 'l_etdose_me';
proc phreg data = use_r multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No");
	model exit_age*melanoma_ins(0)=l_etdose_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
run;

proc phreg data = use_r multipass;
	class  uvrq_c (ref="176.095 to 186.918") educ_c (ref="Less than high school") bmi_c (ref=">18.5 to < 25") smoke_former_c (ref="Never smoked") rel_1d_cancer_c (ref="No") marriage_c (ref="Married") colo_sig_any (ref="No");
	model exit_age*melanoma_mal(0)=l_etdose_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
run;

ods _all_ close; ods html; title;

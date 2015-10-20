/*****************************************************************************;
#             NIH-AARP UVR- Reproductive Factors- Melanoma Study
******************************************************************************;
#
# Model Building B v4:
# Main Effect= ME
# !!!! for both baseline and riskfactor datasets !!!!
#
# uses the conv.melan, conv.melan_r datasets
#
# Created: July 02 2015 WTL
# Updated: v20150813THU WTL
# Updated1: v20151015THU WTL
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
******************************************************************************/

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
libname results 'C:\REB\AARP_HRTandMelanoma\Results';

******************************************************************************;
** Analysis of Model B3, v5
** in situ and malignant melanoma
** with marriage_c, family history of cancer
** and menop_age_c for menostat_c
** new clearance variables;

****** ME baseline: 				ME coded variable (ref= value)	
****01 fmenstr_c					fmenstr_me (ref='15+')
****02 menostat_c 					menostat_me (ref='Natural menopause') 
****03 ovarystat_c					ovarystat_me (ref='Both removed')
****04 menop_age_c					menop_age_me (ref='<45')
****05 parity_c						parity_me (ref='1-2 live children')
****06 flb_age_c					flb_age_me (ref='< 20 years old')
****07 oralbc_yn_c					oralbc_yn_me (ref='Never/<1yr')
****08 oralbc_dur_c					oralbc_dur_me (ref='Never/<1yr')
****09 mht_ever_c					mht_ever_me (ref='Never')
****10 hormstat_c					hormstat_me (ref='Never')
****11 horm_yrs_c					horm_yrs_me (ref='Never used')
****12 horm_yrs_nat_c				horm_yrs_nat_me (ref='Never')
****13 horm_yrs_surg_c				horm_yrs_surg_me (ref='Never') 


****** ME riskfactor:				ME coded variable (ref= value) 
****01 fmenstr_c					fmenstr_me (ref='15+')
****02 menostat_c 					menostat_me (ref='Natural menopause') 
****03 ovarystat_c					ovarystat_me (ref='Both removed')
****04 menop_age_c					menop_age_me (ref='<45')
****05 parity_c						parity_me (ref='1-2 live children')
****06 flb_age_c					flb_age_me (ref='< 20 years old')
****07 oralbc_yn_c					oralbc_yn_me (ref='Never/<1yr')
****08 oralbc_dur_c					oralbc_dur_me (ref='Never/<1yr')
****09 mht_ever_c					mht_ever_me (ref='Never')
****10 hormstat_c					hormstat_me (ref='Never')

****14 ht_nat_c						ht_nat_me (ref='No HT')
****15 ht_nat_ever					ht_nat_ever_me (ref='No HT')
****16 ht_surg_c					ht_surg_me (ref='No HT')
****17 ht_surg_ever					ht_surg_ever_me (ref='No HT')

****18 l_eptcurrent_ever_c			l_eptcurrent_ever_me (ref='No HT') 
****19 l_eptcurrent_c				l_eptcurrent_me (ref='No HT')
****20 l_eptdose_c					l_eptdose_me (ref='<1')
****21 l_eptdur_c					l_eptdur_me (ref='<5')

****22 l_etcurrent_ever_c			l_etcurrent_ever (ref='No HT')
****23 l_etcurrent_c				l_etcurrent_me (ref='No HT')
****24 l_etdose_c					l_etdose_me (ref='.625')
****25 l_etdur_c					l_etdur_me (ref='<10')

****26 l_etfreq						l_etfreq_me (ref='Daily')

****27 menopi_age					menopi_age_me (ref='<45')


** menopi_age (ref='<45')
** rel_1d_cancer_c (ref='No')
** marriage_c (ref='Married')
** colo_sig_any (ref='No')

Finished to: R0f
Working on: ---
******************************************************************************;

ods _all_ close;
ods html;

******************************************************************************;
******************************************************************************;
************************** BASELINE ******************************************;
******************************************************************************;
******************************************************************************;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\formats.20150714.base.sas';
data use;
	set conv.melan;
run;

******************************************************************************;
********************************************************************************;
** B01_ins
** ME: flb_age_me (ref='< 20 years old')  
** melanoma: _ins, 
** variables: ME+uvrq_c+educ_c+bmi_c+smoke_former_c+rel_d1_cancer+marriage_c+colo_sig_any+mht_ever_c;
** uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry
** ') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked');
** ') rel_1d_cancer_c (ref='No') marriage_c (ref='Married');
** ') colo_sig_any (ref='No');
** ') mht_ever_c (ref='Never');
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  flb_age_me (ref='< 20 years old') 
			uvrq_c (ref='176.095 to 186.918') 
			educ_c (ref='Less than high school') 
			bmi_c (ref='>18.5 to < 25') 
			smoke_former_c (ref='Never smoked') 
			rel_1d_cancer_c (ref='No') 
			marriage_c (ref='Married') 
			colo_sig_any (ref='No') 
			mht_ever_c (ref='Never');
	model exit_age*melanoma_ins(0)=flb_age_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_flb NObs = obs;
run;

data A_flb; 
	set A_flb ; 
	where Parameter='flb_age_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_flb obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_flb_age_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** B01_mal
** ME: flb_age_me (ref='< 20 years old')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  flb_age_me (ref='< 20 years old')
			uvrq_c (ref='176.095 to 186.918') 
			educ_c (ref='Less than high school') 
			bmi_c (ref='>18.5 to < 25') 
			smoke_former_c (ref='Never smoked') 
			rel_1d_cancer_c (ref='No') 
			marriage_c (ref='Married') 
			colo_sig_any (ref='No') 
			mht_ever_c (ref='Never');
	model exit_age*melanoma_mal(0)=flb_age_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_flb NObs = obs;
run;

data A_flb; 
	set A_flb ; 
	where Parameter='flb_age_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_flb obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_flb_age_me_mal ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** B02_ins
** ME: hormstat_me (ref='Never')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  hormstat_me (ref='Never') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=hormstat_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_horm NObs = obs;
run;

data A_horm; 
	set A_horm ; 
	where Parameter='hormstat_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_horm obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_hormstat_me_ins ; 
	set A_TOT ; 
run;

********************************************************************************;
********************************************************************************;
** B02_mal
** ME: hormstat_me (ref='Never')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  hormstat_me (ref='Never') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=hormstat_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_horm NObs = obs;
run;

data A_horm; 
	set A_horm ; 
	where Parameter='hormstat_me';
	Sortvar=1;
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_horm obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_hormstat_me_mal ; 
	set A_TOT ; 
run;

******************************************************************************;
********************************************************************************;
** B03_ins
** ME: parity_me (ref='1-2 live children')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  parity_me (ref='1-2 live children') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_ins(0)=parity_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_parity NObs = obs;
run;

data A_parity; 
	set A_parity ; 
	where Parameter='parity_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_parity obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_parity_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** B03_mal
** ME: parity_me (ref='1-2 live children')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  parity_me (ref='1-2 live children') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_mal(0)=parity_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_parity NObs = obs;
run;

data A_parity; 
	set A_parity ; 
	where Parameter='parity_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_parity obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_parity_me_mal ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** B04_ins
** ME: fmenstr_me (ref='15+')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  fmenstr_me (ref='15+') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='<45');
	model exit_age*melanoma_ins(0)=fmenstr_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_fmenstr NObs = obs;
run;

data A_fmenstr; 
	set A_fmenstr ; 
	where Parameter='fmenstr_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_fmenstr obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_fmenstr_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** B04_mal
** ME: fmenstr_me (ref='15+')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  fmenstr_me (ref='15+') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='<45');
	model exit_age*melanoma_mal(0)=fmenstr_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_fmenstr NObs = obs;
run;

data A_fmenstr; 
	set A_fmenstr ; 
	where Parameter='fmenstr_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_fmenstr obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_fmenstr_me_mal ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** B05_ins
** ME: oralbc_dur_me (ref='Never/<1yr')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  oralbc_dur_me (ref='Never/<1yr') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_ins(0)=oralbc_dur_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_oralbc NObs = obs;
run;

data A_oralbc; 
	set A_oralbc ; 
	where Parameter='oralbc_dur_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_oralbc obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_oralbc_dur_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** B05_mal
** ME: oralbc_dur_me (ref='Never/<1yr')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  oralbc_dur_me (ref='Never/<1yr') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_mal(0)=oralbc_dur_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_oralbc NObs = obs;
run;

data A_oralbc; 
	set A_oralbc ; 
	where Parameter='oralbc_dur_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_oralbc obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_oralbc_dur_me_mal ; 
	set A_TOT; 
run;

********************************************************************************;
********************************************************************************;
** B06_ins
** ME: menostat_me (ref='Natural menopause')
** melanoma: _ins,
** variables: ME
** menop_age_c (ref='1')
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  menostat_me (ref='Natural menopause') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_ins(0)=menostat_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL;
	ods output ParameterEstimates=A_menostat NObs = obs;
run;

data A_menostat;
	set A_menostat; 
	where Parameter='menostat_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_menostat obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_menostat_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** B06_mal
** ME: menostat_me (ref='Natural menopause')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  menostat_me (ref='Natural menopause') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_mal(0)=menostat_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_menostat NObs = obs;
run;

data A_menostat; 
	set A_menostat ; 
	where Parameter='menostat_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_menostat obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_menostat_me_mal ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** B07_ins
** ME: menop_age_me (ref='<45')
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  menop_age_me (ref='<45') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never') menostat_c (ref='Natural menopause');
	model exit_age*melanoma_ins(0)=menop_age_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menostat_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_menopage NObs = obs;
run;

data A_menopage; 
	set A_menopage ; 
	where Parameter='menop_age_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_menopage obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_menop_age_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** B07_mal
** ME: menop_age_me (ref='<45')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  menop_age_me (ref='<45') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never') menostat_c (ref='Natural menopause');
	model exit_age*melanoma_mal(0)=menop_age_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menostat_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_menopage NObs = obs;
run;

data A_menopage; 
	set A_menopage ; 
	where Parameter='menop_age_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_menopage obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_menop_age_me_mal ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** B0c_ins
** ME: oralbc_yn_me (ref='Never/<1yr')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use multipass;
	class  oralbc_yn_me (ref='Never/<1yr') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_ins(0)=oralbc_yn_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_oralbcyn NObs = obs;
run;

data A_oralbcyn; 
	set A_oralbcyn ; 
	where Parameter='oralbc_yn_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_oralbcyn obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_oralbc_yn_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** B0c_mal
** ME: oralbc_yn_me (ref='Never/<1yr')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use multipass;
	class  oralbc_yn_me (ref='Never/<1yr') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_mal(0)=oralbc_yn_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_oralbcyn NObs = obs;
run;

data A_oralbcyn; 
	set A_oralbcyn ; 
	where Parameter='oralbc_yn_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_oralbcyn obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_oralbc_yn_me_mal ; 
	set A_TOT; 
run;
******************************************************************************;
********************************************************************************;
** B0d_ins
** ME: ovarystat_me (ref='Both removed')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  ovarystat_me (ref='Both removed') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_ins(0)=ovarystat_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_ovaryst NObs = obs;
run;

data A_ovaryst; 
	set A_ovaryst ; 
	where Parameter='ovarystat_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_ovaryst obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_ovarystat_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** B0d_mal
** ME: ovarystat_me (ref='Both removed')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  ovarystat_me (ref='Both removed') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_mal(0)=ovarystat_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_ovaryst NObs = obs;
run;

data A_ovaryst; 
	set A_ovaryst ; 
	where Parameter='ovarystat_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_ovaryst obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_ovarystat_me_mal ; 
	set A_TOT; 
run;
********************************************************************************;
********************************************************************************;
** B0g_ins
** ME: mht_ever_me (ref='Never')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  mht_ever_me (ref='Never') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=mht_ever_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_mht NObs = obs;
run;

data A_mht; 
	set A_mht ; 
	where Parameter='mht_ever_me';
	Sortvar=1;
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_mht obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_mht_ever_me_ins ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

********************************************************************************;
********************************************************************************;
** B0g_mal
** ME: mht_ever_me (ref='Never')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  mht_ever_me (ref='Never') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=mht_ever_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_mht NObs = obs;
run;

data A_mht; 
	set A_mht ; 
	where Parameter='mht_ever_me';
	Sortvar=1;
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_mht obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_mht_ever_me_mal ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

******************************************************************************;
********************************************************************************;
** B0i_ins
** ME: horm_yrs_me (ref='Never used')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

proc phreg data = use multipass;
	class horm_yrs_me (ref='Never used') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0) = horm_yrs_me fmenstr uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL;
	ods output ParameterEstimates=A_horm_yrs3 NObs=obs;
run;

data A_horm_yrs3; 
	set A_horm_yrs3 ; 
	where Parameter='horm_yrs_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_horm_yrs3 obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_horm_yrs_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** B0i_mal
** ME: horm_yrs_me (ref='Never used')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

proc phreg data = use multipass;
	class horm_yrs_me (ref='Never used') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0) = horm_yrs_me fmenstr uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL;
	ods output ParameterEstimates=A_horm_yrs4 NObs=obs;
run;

data A_horm_yrs4; 
	set A_horm_yrs4 ; 
	where Parameter='horm_yrs_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_horm_yrs4 obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_horm_yrs_me_mal ; 
	set A_TOT; 
run;
******************************************************************************;
********************************************************************************;
** B0i_ins
** ME: horm_yrs_nat_me (ref='Never')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

proc phreg data = use multipass;
	class horm_yrs_nat_me (ref='Never used') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0) = horm_yrs_nat_me fmenstr uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL;
	ods output ParameterEstimates=A_horm_yrs_nat NObs=obs;
run;

data A_horm_yrs_nat; 
	set A_horm_yrs_nat ; 
	where Parameter='horm_yrs_nat_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_horm_yrs_nat obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_horm_yrs_nat_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** B0i_mal
** ME: horm_yrs_nat_me (ref='Never')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

proc phreg data = use multipass;
	class horm_yrs_nat_me (ref='Never used') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0) = horm_yrs_nat_me fmenstr uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL;
	ods output ParameterEstimates=A_horm_yrs_nat NObs=obs;
run;

data A_horm_yrs_nat; 
	set A_horm_yrs_nat ; 
	where Parameter='horm_yrs_nat_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_horm_yrs_nat obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_horm_yrs_nat_me_mal ; 
	set A_TOT; 
run;
******************************************************************************;
********************************************************************************;
** B0i_ins
** ME: horm_yrs_surg_me (ref='Never')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

proc phreg data = use multipass;
	class horm_yrs_surg_me (ref='Never used') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0) = horm_yrs_surg_me fmenstr uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL;
	ods output ParameterEstimates=A_horm_yrs_surg NObs=obs;
run;

data A_horm_yrs_surg; 
	set A_horm_yrs_surg ; 
	where Parameter='horm_yrs_surg_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_horm_yrs_surg obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_horm_yrs_surg_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** B0i_mal
** ME: horm_yrs_surg_me (ref='Never')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

proc phreg data = use multipass;
	class horm_yrs_surg_me (ref='Never used') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0) = horm_yrs_surg_me fmenstr uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL;
	ods output ParameterEstimates=A_horm_yrs_surg NObs=obs;
run;

data A_horm_yrs_surg; 
	set A_horm_yrs_surg ; 
	where Parameter='horm_yrs_surg_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_horm_yrs_surg obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_horm_yrs_surg_me_mal ; 
	set A_TOT; 
run;

******************************************************************************;

ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelB\base_model_B3v5.xls' style=minimal;

** put prints here;
proc print data=A_All_fmenstr_me_ins;
	title1 underlin=1 'AARP Baseline:';
	title2 'Model B3v5';
	title3 '20151016FRI WTL';
	title4 'Age at Menarche';
run;
proc print data=A_All_fmenstr_me_mal;
	title;
run;
proc print data=A_All_menostat_me_ins;
	title1 'Menopause Status';
run;
proc print data=A_All_menostat_me_mal;
	title;
run;
proc print data=A_All_ovarystat_me_ins;
	title1 'Ovary Status, among surg/hyst meno';
run;
proc print data=A_All_ovarystat_me_mal;
	title;
run;
proc print data=A_All_menop_age_me_ins;
	title1 'Age at Menopause, new 20150810MON';
run;
proc print data=A_All_menop_age_me_mal;
	title;
run;
proc print data=A_All_parity_me_ins;
	title1 'Parity';
run;
proc print data=A_All_parity_me_mal;
	title;
run;
proc print data=A_All_flb_age_me_ins;
	title1 'Age at First Live Birth';
run;
proc print data=A_All_flb_age_me_mal;
	title;
run;
proc print data=A_All_oralbc_yn_me_ins;
	title1 'Oral Birth Control Ever';
run;
proc print data=A_All_oralbc_yn_me_mal;
	title;
run;
proc print data=A_All_oralbc_dur_me_ins;
	title1 'Oral Birth Control Duration';
run;
proc print data=A_All_oralbc_dur_me_mal;
	title;
run;
proc print data=A_mht_ever_me_ins;
	title1 'MHT Ever';
run;
proc print data=A_mht_ever_me_mal;
	title;
run; 
proc print data=A_All_hormstat_me_ins;
	title1 'MHT Use Status';
run;
proc print data=A_All_hormstat_me_mal;
	title;
run; 
proc print data=A_horm_yrs_me_ins;
	title1 'Hormone Duration';
run;
proc print data=A_horm_yrs_me_mal;
	title1;
run;
proc print data=A_horm_yrs_nat_me_ins;
	title1 'Hormone Duration -Natural Meno';
run;
proc print data=A_horm_yrs_nat_me_mal;
	title1;
run;
proc print data=A_horm_yrs_surg_me_ins;
	title1 'Hormone Duration -Surgical Meno';
run;
proc print data=A_horm_yrs_surg_me_mal;
	title1;
run;
ods _all_ close;
ods html;
***BASEBASEEND***;
***RISKRISKSTART***;
******************************************************************************;
******************************************************************************;
************************** RISKFACTOR ****************************************;
******************************************************************************;
******************************************************************************;
%include 'C:\REB\AARP_HRTandMelanoma\Analysis\modelBuilding\master\formats.20150714.risk.sas';
data use_r;
	set conv.melan_r;
run;

******************************************************************************;
********************************************************************************;
** R01_ins
** ME: l_eptcurrent_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME+uvrq_c+educ_c+bmi_c+smoke_former_c;
** uvrq_c educ_c bmi_c smoke_former_c / entry
** ') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked');

********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_eptcurrent_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=l_eptcurrent_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_eptcur NObs = obs;
run;

data A_eptcur; 
	set A_eptcur ; 
	where Parameter='l_eptcurrent_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_eptcur obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_eptcurrent_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R01_mal
** ME: l_eptcurrent_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_eptcurrent_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=l_eptcurrent_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_eptcur NObs = obs;
run;

data A_eptcur; 
	set A_eptcur ; 
	where Parameter='l_eptcurrent_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_eptcur obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_eptcurrent_me_mal ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R02_ins
** ME: l_eptdur_me (ref='<5')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_eptdur_me (ref='<5') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=l_eptdur_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_eptdur NObs = obs;
run;

data A_eptdur; 
	set A_eptdur ; 
	where Parameter='l_eptdur_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_eptdur obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_eptdur_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R02_mal
** ME: l_eptdur_me (ref='<5')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_eptdur_me (ref='<5') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=l_eptdur_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_eptdur NObs = obs;
run;

data A_eptdur; 
	set A_eptdur ; 
	where Parameter='l_eptdur_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_eptdur obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_eptdur_me_mal ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R03_ins
** ME: l_eptdose_me (ref='<1')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_eptdose_me (ref='<1') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=l_eptdose_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_eptdose NObs = obs;
run;

data A_eptdose; 
	set A_eptdose ; 
	where Parameter='l_eptdose_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_eptdose obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_eptdose_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R03_mal
** ME: l_eptdose_me (ref='<1')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_eptdose_me (ref='<1') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=l_eptdose_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_eptdose NObs = obs;
run;

data A_eptdose; 
	set A_eptdose ; 
	where Parameter='l_eptdose_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_eptdose obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_eptdose_me_mal ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R04_ins
** ME: l_etcurrent_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_etcurrent_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=l_etcurrent_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_etcur NObs = obs;
run;

data A_etcur; 
	set A_etcur ; 
	where Parameter='l_etcurrent_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_etcur obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_etcurrent_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R04_mal
** ME: l_etcurrent_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_etcurrent_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=l_etcurrent_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_etcur NObs = obs;
run;

data A_etcur; 
	set A_etcur ; 
	where Parameter='l_etcurrent_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_etcur obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;
 
data A_All_etcurrent_me_mal ; 
	set A_TOT; 
run;
******************************************************************************;
********************************************************************************;
** R05_ins
** ME: l_etdur_me (ref='<10')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_etdur_me (ref='<10') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=l_etdur_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_etdur NObs = obs;
run;

data A_etdur; 
	set A_etdur ; 
	where Parameter='l_etdur_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_etdur obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_etdur_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R05_mal
** ME: l_etdur_me (ref='<10')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_etdur_me (ref='<10') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=l_etdur_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_etdur NObs = obs;
run;

data A_etdur; 
	set A_etdur ; 
	where Parameter='l_etdur_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_etdur obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_etdur_me_mal ; 
	set A_TOT; 
run;
******************************************************************************;
********************************************************************************;
** R06_ins
** ME: l_etdose_me (ref='.625')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_etdose_me (ref='.625') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=l_etdose_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_etdose NObs = obs;
run;

data A_etdose; 
	set A_etdose ; 
	where Parameter='l_etdose_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_etdose obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_etdose_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R06_mal
** ME: l_etdose_me (ref='.625')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_etdose_me (ref='.625') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=l_etdose_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_etdose NObs = obs;
run;

data A_etdose; 
	set A_etdose ; 
	where Parameter='l_etdose_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_etdose obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_etdose_me_mal ; 
	set A_TOT; 
run;
******************************************************************************;
********************************************************************************;
** R07_ins
** ME: flb_age_me (ref='< 20 years old')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  flb_age_me (ref='< 20 years old') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_ins(0)=flb_age_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_flb NObs = obs;
run;

data A_flb; 
	set A_flb ; 
	where Parameter='flb_age_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_flb obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_flb_age_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R07_mal
** ME: flb_age_me (ref='< 20 years old')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  flb_age_me (ref='< 20 years old') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_mal(0)=flb_age_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_flb NObs = obs;
run;

data A_flb; 
	set A_flb ; 
	where Parameter='flb_age_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_flb obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_flb_age_me_mal ; 
	set A_TOT; 
run;
******************************************************************************;
********************************************************************************;
** R08_ins
** ME: parity_me (ref='1-2 live children')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  parity_me (ref='1-2 live children') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_ins(0)=parity_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_parity NObs = obs;
run;

data A_parity; 
	set A_parity ; 
	where Parameter='parity_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_parity obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_parity_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R08_mal
** ME: parity_me (ref='1-2 live children')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  parity_me (ref='1-2 live children') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_mal(0)=parity_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_parity NObs = obs;
run;

data A_parity; 
	set A_parity ; 
	where Parameter='parity_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_parity obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_parity_me_mal ; 
	set A_TOT; 
run;
******************************************************************************;
********************************************************************************;
** R09_ins
** ME: fmenstr_me (ref='15+')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  fmenstr_me (ref='15+') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='<45');
	model exit_age*melanoma_ins(0)=fmenstr_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_fmenstr NObs = obs;
run;

data A_fmenstr; 
	set A_fmenstr ; 
	where Parameter='fmenstr_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_fmenstr obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_fmenstr_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R09_mal
** ME: fmenstr_me (ref='15+')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  fmenstr_me (ref='13-14') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='<45');
	model exit_age*melanoma_mal(0)=fmenstr_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_fmenstr NObs = obs;
run;

data A_fmenstr; 
	set A_fmenstr ; 
	where Parameter='fmenstr_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_fmenstr obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_fmenstr_me_mal ; 
	set A_TOT; 
run;
******************************************************************************;
********************************************************************************;
** R10_ins
** ME: oralbc_dur_me (ref='Never/<1yr')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  oralbc_dur_me (ref='Never/<1yr') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_ins(0)=oralbc_dur_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_oralbc NObs = obs;
run;

data A_oralbc; 
	set A_oralbc ; 
	where Parameter='oralbc_dur_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_oralbc obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_oralbc_dur_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R10_mal
** ME: oralbc_dur_me (ref='Never/<1yr')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  oralbc_dur_me (ref='Never/<1yr') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_mal(0)=oralbc_dur_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_oralbc NObs = obs;
run;

data A_oralbc; 
	set A_oralbc ; 
	where Parameter='oralbc_dur_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_oralbc obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_oralbc_dur_me_mal ; 
	set A_TOT; 
run;
******************************************************************************;
********************************************************************************;
** R11_ins
** ME: menostat_me (ref='Natural menopause')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  menostat_me (ref='Natural menopause') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_ins(0)=menostat_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_menostat NObs = obs;
run;

data A_menostat; 
	set A_menostat ; 
	where Parameter='menostat_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_menostat obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_menostat_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R11_mal
** ME: menostat_me (ref='Natural menopause')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  menostat_me (ref='Natural menopause') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_mal(0)=menostat_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_menostat NObs = obs;
run;

data A_menostat; 
	set A_menostat ; 
	where Parameter='menostat_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_menostat obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_menostat_me_mal ; 
	set A_TOT; 
run;
******************************************************************************;
********************************************************************************;
** R12_ins
** ME: menop_age_me (ref='<45')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  menop_age_me (ref='<45') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never') menostat_c (ref='Natural menopause');
	model exit_age*melanoma_ins(0)=menop_age_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menostat_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_menopage NObs = obs;
run;

data A_menopage; 
	set A_menopage ; 
	where Parameter='menop_age_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_menopage obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_menop_age_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R12_mal
** ME: menop_age_me (ref='<45')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  menop_age_me (ref='<45') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never') menostat_c (ref='Natural menopause');
	model exit_age*melanoma_mal(0)=menop_age_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menostat_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_menopage NObs = obs;
run;

data A_menopage; 
	set A_menopage ; 
	where Parameter='menop_age_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_menopage obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_menop_age_me_mal ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R14_ins
** ME: ht_nat_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  ht_nat_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=ht_nat_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_htnat NObs = obs;
run;

data A_htnat; 
	set A_htnat ; 
	where Parameter='ht_nat_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_htnat obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

** for natural menopause;
proc phreg data = use_r multipass;
	class  ht_nat_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=ht_nat_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_htnat_NM NObs = obs;
run;
data A_htnat_NM; 
	set A_htnat_NM ; 
	where Parameter='ht_nat_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_htnat_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

data A_All_ht_nat_me_ins ; 
	set A_TOT A_NM; 
run;

******************************************************************************;
********************************************************************************;
** R14_mal
** ME: ht_nat_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  ht_nat_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=ht_nat_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_htnat NObs = obs;
run;

data A_htnat; 
	set A_htnat ; 
	where Parameter='ht_nat_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_htnat obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

** for natural menopause;
proc phreg data = use_r multipass;
	class  ht_nat_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=ht_nat_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_htnat_NM NObs = obs;
run;
data A_htnat_NM; 
	set A_htnat_NM ; 
	where Parameter='ht_nat_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_htnat_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

data A_All_ht_nat_me_mal ; 
	set A_TOT A_NM; 
run;
******************************************************************************;
********************************************************************************;
** R15_ins
** ME: ht_surg_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  ht_surg_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=ht_surg_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_htsurg NObs = obs;
run;

data A_htsurg; 
	set A_htsurg ; 
	where Parameter='ht_surg_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_htsurg obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  ht_surg_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=ht_surg_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_htsurg_SR NObs = obs;
run;
data A_htsurg_SR; 
	set A_htsurg_SR ; 
	where Parameter='ht_surg_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_htsurg_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_ht_surg_me_ins ; 
	set A_TOT A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R15_mal
** ME: ht_surg_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  ht_surg_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=ht_surg_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_htsurg NObs = obs;
run;

data A_htsurg; 
	set A_htsurg ; 
	where Parameter='ht_surg_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_htsurg obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  ht_surg_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=ht_surg_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_htsurg_SR NObs = obs;
run;
data A_htsurg_SR; 
	set A_htsurg_SR ; 
	where Parameter='ht_surg_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_htsurg_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_ht_surg_me_mal ; 
	set A_TOT A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R16_ins
** ME: l_etfreq_me (ref='Daily') 
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_etfreq_me (ref='Daily') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=l_etfreq_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_etfreq NObs = obs;
run;

data A_etfreq; 
	set A_etfreq ; 
	where Parameter='l_etfreq_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_etfreq obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_etfreq_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R16_mal
** ME: l_etfreq_me (ref='Daily') 
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_etfreq_me (ref='Daily') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=l_etfreq_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_etfreq NObs = obs;
run;

data A_etfreq; 
	set A_etfreq ; 
	where Parameter='l_etfreq_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_etfreq obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_etfreq_me_mal ; 
	set A_TOT; 
run;
******************************************************************************;
********************************************************************************;
** R0a_ins
** ME: l_eptcurrent_ever_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_eptcurrent_ever_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=l_eptcurrent_ever_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_eptcurvr NObs = obs;
run;

data A_eptcurvr; 
	set A_eptcurvr ; 
	where Parameter='l_eptcurrent_ever_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_eptcurvr obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_eptcurrent_ever_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R0a_mal
** ME: l_eptcurrent_ever_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_eptcurrent_ever_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=l_eptcurrent_ever_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_eptcurvr NObs = obs;
run;

data A_eptcurvr; 
	set A_eptcurvr ; 
	where Parameter='l_eptcurrent_ever_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_eptcurvr obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_eptcurrent_ever_me_mal ; 
	set A_TOT; 
run;
******************************************************************************;
********************************************************************************;
** R0b_ins
** ME: l_etcurrent_ever_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_etcurrent_ever_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=l_etcurrent_ever_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_etcurvr NObs = obs;
run;

data A_etcurvr; 
	set A_etcurvr ; 
	where Parameter='l_etcurrent_ever_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_etcurvr obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_etcurrent_ever_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R0b_mal
** ME: l_etcurrent_ever_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use_r multipass;
	class  l_etcurrent_ever_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=l_etcurrent_ever_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_etcurvr NObs = obs;
run;

data A_etcurvr; 
	set A_etcurvr ; 
	where Parameter='l_etcurrent_ever_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_etcurvr obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_etcurrent_ever_me_mal ; 
	set A_TOT; 
run;
******************************************************************************;
********************************************************************************;
** R0c_ins
** ME: oralbc_yn_me (ref='Never/<1yr')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use_r multipass;
	class  oralbc_yn_me (ref='Never/<1yr') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_ins(0)=oralbc_yn_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_oralbcyn NObs = obs;
run;

data A_oralbcyn; 
	set A_oralbcyn ; 
	where Parameter='oralbc_yn_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_oralbcyn obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_oralbc_yn_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R0c_mal
** ME: oralbc_yn_me (ref='Never/<1yr')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use_r multipass;
	class  oralbc_yn_me (ref='Never/<1yr') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_mal(0)=oralbc_yn_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_oralbcyn NObs = obs;
run;

data A_oralbcyn; 
	set A_oralbcyn ; 
	where Parameter='oralbc_yn_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_oralbcyn obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_oralbc_yn_me_mal ; 
	set A_TOT; 
run;
******************************************************************************;
********************************************************************************;
** R0d_ins
** ME: ht_nat_ever_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use_r multipass;
	class  ht_nat_ever_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=ht_nat_ever_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_htnatvr NObs = obs;
run;

data A_htnatvr; 
	set A_htnatvr ; 
	where Parameter='ht_nat_ever_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_htnatvr obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

** for nat menopause;
proc phreg data = use_r multipass;
	class  ht_nat_ever_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=ht_nat_ever_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_htnatvr_NM NObs = obs;
run;
data A_htnatvr_NM; 
	set A_htnatvr_NM ; 
	where Parameter='ht_nat_ever_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_htnatvr_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='surgur'; 
run;

data A_All_ht_nat_ever_me_ins ; 
	set A_TOT A_NM; 
run;

******************************************************************************;
********************************************************************************;
** R0d_mal
** ME: ht_nat_ever_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  ht_nat_ever_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=ht_nat_ever_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_htnatvr NObs = obs;
run;

data A_htnatvr; 
	set A_htnatvr ; 
	where Parameter='ht_nat_ever_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_htnatvr obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

** for natural menopause;
proc phreg data = use_r multipass;
	class  ht_nat_ever_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=ht_nat_ever_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_htnatvr_NM NObs = obs;
run;
data A_htnatvr_NM; 
	set A_htnatvr_NM ; 
	where Parameter='ht_nat_ever_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_htnatvr_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='surgur'; 
run;

data A_All_ht_nat_ever_me_mal ; 
	set A_TOT A_NM; 
run;
******************************************************************************;
********************************************************************************;
** R0e_ins
** ME: ht_surg_ever_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  ht_surg_ever_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=ht_surg_ever_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_htsurgvr NObs = obs;
run;

data A_htsurgvr; 
	set A_htsurgvr ; 
	where Parameter='ht_surg_ever_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_htsurgvr obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  ht_surg_ever_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_ins(0)=ht_surg_ever_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_htsurgvr_SR NObs = obs;
run;
data A_htsurgvr_SR; 
	set A_htsurgvr_SR ; 
	where Parameter='ht_surg_ever_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_htsurgvr_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_ht_surg_ever_me_ins ; 
	set A_TOT A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R0e_mal
** ME: ht_surg_ever_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  ht_surg_ever_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=ht_surg_ever_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	ods output ParameterEstimates=A_htsurgvr NObs = obs;
run;

data A_htsurgvr; 
	set A_htsurgvr ; 
	where Parameter='ht_surg_ever_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_htsurgvr obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  ht_surg_ever_me (ref='No HT') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)=ht_surg_ever_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_htsurgvr_SR NObs = obs;
run;
data A_htsurgvr_SR; 
	set A_htsurgvr_SR ; 
	where Parameter='ht_surg_ever_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_htsurgvr_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_ht_surg_ever_me_mal ; 
	set A_TOT A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R0f_ins
** ME: ovarystat_me (ref='Both removed')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  ovarystat_me (ref='Both removed') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_ins(0)=ovarystat_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_ovaryst NObs = obs;
run;

data A_ovaryst; 
	set A_ovaryst ; 
	where Parameter='ovarystat_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_ovaryst obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

data A_All_ovarystat_me_ins ; 
	set A_TOT; 
run;

******************************************************************************;
********************************************************************************;
** R0f_mal
** ME: ovarystat_me (ref='Both removed')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  ovarystat_me (ref='Both removed') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never');
	model exit_age*melanoma_mal(0)=ovarystat_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_ovaryst NObs = obs;
run;

data A_ovaryst; 
	set A_ovaryst ; 
	where Parameter='ovarystat_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_ovaryst obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

data A_All_ovarystat_me_mal ; 
	set A_TOT; 
run;


******************************************************************************;
ods _all_ close;ods html;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelB\risk_model_B3v5.xls' style=minimal;


proc print data=A_All_fmenstr_me_ins;
	title1 underlin=1 'AARP Riskfactor:';
	title2 'Model B3v5';
	title3 '20151019MON WTL';
	title4 'Age at Menarche';
run;
proc print data=A_All_fmenstr_me_mal;
	title;
run;
proc print data=A_All_menostat_me_ins;
	title1 'Menopausal Status';
run;
proc print data=A_All_menostat_me_mal;
	title;
run;
proc print data=A_All_ovarystat_me_ins;
	title1 'Ovary Status';
run;
proc print data=A_All_ovarystat_me_mal;
	title;
run;
proc print data=A_All_menop_age_me_ins;
	title1 'Age at Menopause';
run;
proc print data=A_All_menop_age_me_mal;
	title;
run;
proc print data=A_All_parity_me_ins;
	title1 'Parity';
run;
proc print data=A_All_parity_me_mal;
	title;
run;
proc print data=A_All_flb_age_me_ins;
	title1 'Age at First Live Birth';
run;
proc print data=A_All_flb_age_me_mal;
	title;
run;
proc print data=A_All_oralbc_yn_me_ins;
	title1 'Oral birth control ever';
run;
proc print data=A_All_oralbc_yn_me_mal;
	title;
run;
proc print data=A_All_oralbc_dur_me_ins;
	title1 'Oral Contraceptive Duration';
run;
proc print data=A_All_oralbc_dur_me_mal;
	title;
run;
proc print data=A_All_ht_nat_ever_me_ins;
	title1 'lacey horm ever, nat meno';
run;
proc print data=A_All_ht_nat_ever_me_mal;
	title;
run;
proc print data=A_All_ht_nat_me_ins;
	title1 'HT Type Among Natural Menopause, Lacey';
run;
proc print data=A_All_ht_nat_me_mal;
	title;
run;
proc print data=A_All_ht_surg_ever_me_ins;
	title1 'lacey horm ever, surg meno';
run;
proc print data=A_All_ht_surg_ever_me_mal;
	title;
run;
proc print data=A_All_ht_surg_me_ins;
	title1 'HT Type Among Surgical Menopause, Lacey';
run;
proc print data=A_All_ht_surg_me_mal;
	title;
run;
proc print data=A_All_eptcurrent_ever_me_ins;
	title1 'EPT current ever';
run;
proc print data=A_All_eptcurrent_ever_me_mal;
	title;
run;
proc print data=A_All_eptcurrent_me_ins;
	title 'Estrogen-Progestin Current';
run;
proc print data=A_All_eptcurrent_me_mal;
	title;
run;
proc print data=A_All_eptdose_me_ins;
	title1 'Estrogen-Progestin Dose';
run;
proc print data=A_All_eptdose_me_mal;
	title;
run;
proc print data=A_All_eptdur_me_ins;
	title1 'Estrogen-Progestin Duration';
run;
proc print data=A_All_eptdur_me_mal;
	title;
run;
proc print data=A_All_etcurrent_ever_me_ins;
	title1 'ET only current ever';
run;
proc print data=A_All_etcurrent_ever_me_mal;
	title;
run;
proc print data=A_All_etcurrent_me_ins;
	title1 'Estrogen Current';
run;
proc print data=A_All_etcurrent_me_mal;
	title;
run;
proc print data=A_All_etdose_me_ins;
	title1 'Estrogen Dose';
run;
proc print data=A_All_etdose_me_mal;
	title;
run;
proc print data=A_All_etdur_me_ins;
	title1 'Estrogen Duration';
run;
proc print data=A_All_etdur_me_mal;
	title;
run;
proc print data=A_All_etfreq_me_ins;
	title1 'Estrogen Therapy Frequency, Lacey';
run;
proc print data=A_All_etfreq_me_mal;
	title;
run;
ods _all_ close;ods html;

/*****************************************************************************;
#             NIH-AARP UVR- Reproductive Factors- Melanoma Study
******************************************************************************;
#
# Model Building C v3:
# = ME
# !!!! for both baseline and riskfactor datasets !!!!
#
# uses the conv.melan, conv.melan_r datasets
#
# Created: July 02 WTL
# Updated: v20150709THU WTL
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************/

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
libname results 'C:\REB\AARP_HRTandMelanoma\Results';

******************************************************************************;
** Analysis of Model C
** in situ and malignant melanoma

****** ME baseline: 				ME coded variable (ref= value)	
****01 flb_age_c					flb_age_c_me (ref='< 20 years old')
****0a horm_nat_ever_me				horm_nat_ever_me (ref='never')
****0b horm_surg_ever_me			horm_surg_ever_me (ref='never') 
****02 horm_ever					horm_ever_me (ref='never')
****03 parity						parity_me (ref='1-2 live children')
****04 fmenstr						fmenstr_me (ref='<=10')
****0c oralbc_yn_c					oralbc_yn_c_me (ref='never/<1yr')
****05 oralbc_dur_c					oralbc_dur_c_me (ref='never/<1yr')
****06 menostat_c 					menostat_c_me (ref='natural menopause')
****07 meno_age_c					meno_age_c_me (ref='50-54')
****08 surg_age_c					surg_age_c_me (ref='50-54')
****0d ovarystat_c					ovarystat_c_me (ref='both removed')

****** ME riskfactor:				ME coded variable (ref= value)
****0a lacey_eptcurrent_ever		lacey_eptcurrent_ever_me (ref='No HT')
****01 lacey_eptcurrent				lacey_eptcurrent_me (ref='No HT')
****02 lacey_eptdur					lacey_eptdur_me (ref='No HT')
****03 lacey_eptdose				lacey_eptdose_me (ref='No HT')

****0b lacey_etcurrent_ever			lacey_etcurrent_ever (ref='No HT')
****04 lacey_etcurrent				lacey_etcurrent_me (ref='No HT')
****05 lacey_etdur					lacey_etdur_me (ref='No HT')
****06 lacey_etdose					lacey_etdose_me (ref='No HT')

****07 flb_age_c					flb_age_c_me (ref='< 20 years old')
****08 parity						parity_me (ref='1-2 live children')
****09 fmenstr						fmenstr_me (ref='<=10')
****0c oralbc_yn_c					oralbc_yn_c_me (ref='never/<1yr')
****10 oralbc_dur_c					oralbc_dur_c_me (ref='never/<1yr')
****11 menostat_c					menostat_c_me (ref='natural menopause')
****12 meno_age_c					meno_age_c_me (ref='50-54')
****13 surg_age_c					surg_age_c_me (ref='50-54')

****0d ht_type_nat_ever				ht_type_nat_ever_me (ref='No HT')
****14 ht_type_nat					ht_type_nat_me (ref='No HT')
****0e ht_type_surg_ever			ht_type_surg_ever_me (ref='No HT')
****15 ht_type_surg					ht_type_surg_me (ref='No HT')
****16 lacey_etfreq					lacey_etfreq_me (ref='No HT')
****0f ovarystat_c					ovarystat_c_me (ref='both removed')

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
** B01_ins
** ME: flb_age_c_me (ref='< 20 years old')  
** melanoma: _ins, 
** variables: ME+uvrq+educ_c+bmi_c+smoke_former+parity;
** uvrq educ_c bmi_c smoke_former parity / entry
** B: ') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked');
** C: ') parity (ref='1-2 live children');
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_flb NObs = obs;
run;

data A_flb; 
	set A_flb ; 
	where Parameter='flb_age_c_me';
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

** for natural menopause;
proc phreg data = use multipass;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_flb_NM NObs = obs;
run;
data A_flb_NM; 
	set A_flb_NM ; 
	where Parameter='flb_age_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_flb_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_flb_SR NObs = obs;
run;
data A_flb_SR; 
	set A_flb_SR ; 
	where Parameter='flb_age_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_flb_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_flb_age_c_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B01_mal
** ME: flb_age_c_me (ref='< 20 years old')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_flb NObs = obs;
run;

data A_flb; 
	set A_flb ; 
	where Parameter='flb_age_c_me';
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

** for natural menopause;
proc phreg data = use multipass;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_flb_NM NObs = obs;
run;
data A_flb_NM; 
	set A_flb_NM ; 
	where Parameter='flb_age_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_flb_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_flb_SR NObs = obs;
run;
data A_flb_SR; 
	set A_flb_SR ; 
	where Parameter='flb_age_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_flb_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_flb_age_c_me_mal ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B02_ins
** ME: horm_ever_me (ref='never')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  horm_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_horm NObs = obs;
run;

data A_horm; 
	set A_horm ; 
	where Parameter='horm_ever_me';
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

** for natural menopause;
proc phreg data = use multipass;
	class  horm_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_horm_NM NObs = obs;
run;
data A_horm_NM; 
	set A_horm_NM ; 
	where Parameter='horm_ever_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_horm_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  horm_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=horm_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_horm_SR NObs = obs;
run;
data A_horm_SR; 
	set A_horm_SR ; 
	where Parameter='horm_ever_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_horm_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_horm_ever_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B02_mal
** ME: horm_ever_me (ref='never')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  horm_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_horm NObs = obs;
run;

data A_horm; 
	set A_horm ; 
	where Parameter='horm_ever_me';
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

** for natural menopause;
proc phreg data = use multipass;
	class  horm_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_horm_NM NObs = obs;
run;
data A_horm_NM; 
	set A_horm_NM ; 
	where Parameter='horm_ever_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_horm_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  horm_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=horm_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_horm_SR NObs = obs;
run;
data A_horm_SR; 
	set A_horm_SR ; 
	where Parameter='horm_ever_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_horm_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_horm_ever_me_mal ; 
	set A_TOT A_NM A_SR; 
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
	class  parity_me (ref='1-2 live children') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=parity_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
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

** for natural menopause;
proc phreg data = use multipass;
	class  parity_me (ref='1-2 live children') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=parity_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_parity_NM NObs = obs;
run;
data A_parity_NM; 
	set A_parity_NM ; 
	where Parameter='parity_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_parity_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  parity_me (ref='1-2 live children') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=parity_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_parity_SR NObs = obs;
run;
data A_parity_SR; 
	set A_parity_SR ; 
	where Parameter='parity_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_parity_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_parity_me_ins ; 
	set A_TOT A_NM A_SR; 
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
	class  parity_me (ref='1-2 live children') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=parity_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
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

** for natural menopause;
proc phreg data = use multipass;
	class  parity_me (ref='1-2 live children') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=parity_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_parity_NM NObs = obs;
run;
data A_parity_NM; 
	set A_parity_NM ; 
	where Parameter='parity_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_parity_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  parity_me (ref='1-2 live children') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=parity_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_parity_SR NObs = obs;
run;
data A_parity_SR; 
	set A_parity_SR ; 
	where Parameter='parity_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_parity_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_parity_me_mal ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B04_ins
** ME: fmenstr_me (ref='<=10')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  fmenstr_me (ref='<=10') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=fmenstr_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
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

** for natural menopause;
proc phreg data = use multipass;
	class  fmenstr_me (ref='<=10') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=fmenstr_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_fmenstr_NM NObs = obs;
run;
data A_fmenstr_NM; 
	set A_fmenstr_NM ; 
	where Parameter='fmenstr_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_fmenstr_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  fmenstr_me (ref='<=10') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=fmenstr_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_fmenstr_SR NObs = obs;
run;
data A_fmenstr_SR; 
	set A_fmenstr_SR ; 
	where Parameter='fmenstr_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_fmenstr_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_fmenstr_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B04_mal
** ME: fmenstr_me (ref='<=10')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  fmenstr_me (ref='<=10') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=fmenstr_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
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

** for natural menopause;
proc phreg data = use multipass;
	class  fmenstr_me (ref='<=10') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=fmenstr_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_fmenstr_NM NObs = obs;
run;
data A_fmenstr_NM; 
	set A_fmenstr_NM ; 
	where Parameter='fmenstr_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_fmenstr_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  fmenstr_me (ref='<=10') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=fmenstr_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_fmenstr_SR NObs = obs;
run;
data A_fmenstr_SR; 
	set A_fmenstr_SR ; 
	where Parameter='fmenstr_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_fmenstr_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_fmenstr_me_mal ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B05_ins
** ME: oralbc_dur_c_me (ref='never/<1yr')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  oralbc_dur_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_oralbc NObs = obs;
run;

data A_oralbc; 
	set A_oralbc ; 
	where Parameter='oralbc_dur_c_me';
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

** for natural menopause;
proc phreg data = use multipass;
	class  oralbc_dur_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_oralbc_NM NObs = obs;
run;
data A_oralbc_NM; 
	set A_oralbc_NM ; 
	where Parameter='oralbc_dur_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_oralbc_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  oralbc_dur_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_oralbc_SR NObs = obs;
run;
data A_oralbc_SR; 
	set A_oralbc_SR ; 
	where Parameter='oralbc_dur_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_oralbc_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_oralbc_dur_c_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B05_mal
** ME: oralbc_dur_c_me (ref='never/<1yr')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  oralbc_dur_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_oralbc NObs = obs;
run;

data A_oralbc; 
	set A_oralbc ; 
	where Parameter='oralbc_dur_c_me';
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

** for natural menopause;
proc phreg data = use multipass;
	class  oralbc_dur_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_oralbc_NM NObs = obs;
run;
data A_oralbc_NM; 
	set A_oralbc_NM ; 
	where Parameter='oralbc_dur_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_oralbc_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  oralbc_dur_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_oralbc_SR NObs = obs;
run;
data A_oralbc_SR; 
	set A_oralbc_SR ; 
	where Parameter='oralbc_dur_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_oralbc_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_oralbc_dur_c_me_mal ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B06_ins
** ME: menostat_c_me (ref='natural menopause')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  menostat_c_me (ref='natural menopause') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=menostat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_menostat NObs = obs;
run;

data A_menostat; 
	set A_menostat ; 
	where Parameter='menostat_c_me';
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

** for natural menopause;
proc phreg data = use multipass;
	class  menostat_c_me (ref='natural menopause') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=menostat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_menostat_NM NObs = obs;
run;
data A_menostat_NM; 
	set A_menostat_NM ; 
	where Parameter='menostat_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_menostat_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  menostat_c_me (ref='natural menopause') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=menostat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_menostat_SR NObs = obs;
run;
data A_menostat_SR; 
	set A_menostat_SR ; 
	where Parameter='menostat_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_menostat_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_menostat_c_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B06_mal
** ME: menostat_c_me (ref='natural menopause')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  menostat_c_me (ref='natural menopause') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=menostat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_menostat NObs = obs;
run;

data A_menostat; 
	set A_menostat ; 
	where Parameter='menostat_c_me';
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

** for natural menopause;
proc phreg data = use multipass;
	class  menostat_c_me (ref='natural menopause') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=menostat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_menostat_NM NObs = obs;
run;
data A_menostat_NM; 
	set A_menostat_NM ; 
	where Parameter='menostat_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_menostat_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  menostat_c_me (ref='natural menopause') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=menostat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_menostat_SR NObs = obs;
run;
data A_menostat_SR; 
	set A_menostat_SR ; 
	where Parameter='menostat_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_menostat_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_menostat_c_me_mal ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B07_ins
** ME: meno_age_c_me (ref='50-54')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  meno_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=meno_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_menoage NObs = obs;
run;

data A_menoage; 
	set A_menoage ; 
	where Parameter='meno_age_c_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_menoage obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

** for natural menopause;
proc phreg data = use multipass;
	class  meno_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=meno_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_menoage_NM NObs = obs;
run;
data A_menoage_NM; 
	set A_menoage_NM ; 
	where Parameter='meno_age_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_menoage_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  meno_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=meno_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_menoage_SR NObs = obs;
run;
data A_menoage_SR; 
	set A_menoage_SR ; 
	where Parameter='meno_age_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_menoage_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_meno_age_c_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B07_mal
** ME: meno_age_c_me (ref='50-54')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  meno_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=meno_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_menoage NObs = obs;
run;

data A_menoage; 
	set A_menoage ; 
	where Parameter='meno_age_c_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_menoage obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

** for natural menopause;
proc phreg data = use multipass;
	class  meno_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=meno_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_menoage_NM NObs = obs;
run;
data A_menoage_NM; 
	set A_menoage_NM ; 
	where Parameter='meno_age_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_menoage_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  meno_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=meno_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_menoage_SR NObs = obs;
run;
data A_menoage_SR; 
	set A_menoage_SR ; 
	where Parameter='meno_age_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_menoage_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_meno_age_c_me_mal ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B08_ins
** ME: surg_age_c_me (ref='50-54')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  surg_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=surg_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_surgage NObs = obs;
run;

data A_surgage; 
	set A_surgage ; 
	where Parameter='surg_age_c_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_surgage obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

** for natural menopause;
proc phreg data = use multipass;
	class  surg_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=surg_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_surgage_NM NObs = obs;
run;
data A_surgage_NM; 
	set A_surgage_NM ; 
	where Parameter='surg_age_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_surgage_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  surg_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=surg_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_surgage_SR NObs = obs;
run;
data A_surgage_SR; 
	set A_surgage_SR ; 
	where Parameter='surg_age_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_surgage_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_surg_age_c_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B08_mal
** ME: surg_age_c_me (ref='50-54')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  surg_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=surg_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_surgage NObs = obs;
run;

data A_surgage; 
	set A_surgage ; 
	where Parameter='surg_age_c_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_surgage obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

** for natural menopause;
proc phreg data = use multipass;
	class  surg_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=surg_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_surgage_NM NObs = obs;
run;
data A_surgage_NM; 
	set A_surgage_NM ; 
	where Parameter='surg_age_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_surgage_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  surg_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=surg_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_surgage_SR NObs = obs;
run;
data A_surgage_SR; 
	set A_surgage_SR ; 
	where Parameter='surg_age_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_surgage_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_surg_age_c_me_mal ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B0a_ins
** ME: horm_nat_ever_me (ref='never')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  horm_nat_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=horm_nat_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_hormnatvr NObs = obs;
run;

data A_hormnatvr; 
	set A_hormnatvr ; 
	where Parameter='horm_nat_ever_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_hormnatvr obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

** for natural menopause;
proc phreg data = use multipass;
	class  horm_nat_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=horm_nat_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_hormnatvr_NM NObs = obs;
run;
data A_hormnatvr_NM; 
	set A_hormnatvr_NM ; 
	where Parameter='horm_nat_ever_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_hormnatvr_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  horm_nat_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=horm_nat_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_hormnatvr_SR NObs = obs;
run;
data A_hormnatvr_SR; 
	set A_hormnatvr_SR ; 
	where Parameter='horm_nat_ever_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_hormnatvr_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_horm_nat_ever_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B0a_mal
** ME: horm_nat_ever_me (ref='never')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  horm_nat_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=horm_nat_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_hormnatvr NObs = obs;
run;

data A_hormnatvr; 
	set A_hormnatvr ; 
	where Parameter='horm_nat_ever_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_hormnatvr obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

** for natural menopause;
proc phreg data = use multipass;
	class  horm_nat_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=horm_nat_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_hormnatvr_NM NObs = obs;
run;
data A_hormnatvr_NM; 
	set A_hormnatvr_NM ; 
	where Parameter='horm_nat_ever_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_hormnatvr_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  horm_nat_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=horm_nat_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_hormnatvr_SR NObs = obs;
run;
data A_hormnatvr_SR; 
	set A_hormnatvr_SR ; 
	where Parameter='horm_nat_ever_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_hormnatvr_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_horm_nat_ever_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** B0b_ins
** ME: horm_surg_ever_me (ref='never')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use multipass;
	class  horm_surg_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=horm_surg_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_hormsurgvr NObs = obs;
run;

data A_hormsurgvr; 
	set A_hormsurgvr ; 
	where Parameter='horm_surg_ever_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_hormsurgvr obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

** for surgural menopause;
proc phreg data = use multipass;
	class  horm_surg_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=horm_surg_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_hormsurgvr_NM NObs = obs;
run;
data A_hormsurgvr_NM; 
	set A_hormsurgvr_NM ; 
	where Parameter='horm_surg_ever_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_hormsurgvr_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  horm_surg_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=horm_surg_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_hormsurgvr_SR NObs = obs;
run;
data A_hormsurgvr_SR; 
	set A_hormsurgvr_SR ; 
	where Parameter='horm_surg_ever_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_hormsurgvr_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_horm_surg_ever_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B0b_mal
** ME: horm_surg_ever_me (ref='never')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use multipass;
	class  horm_surg_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=horm_surg_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_hormsurgvr NObs = obs;
run;

data A_hormsurgvr; 
	set A_hormsurgvr ; 
	where Parameter='horm_surg_ever_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_hormsurgvr obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

** for surgural menopause;
proc phreg data = use multipass;
	class  horm_surg_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=horm_surg_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_hormsurgvr_NM NObs = obs;
run;
data A_hormsurgvr_NM; 
	set A_hormsurgvr_NM ; 
	where Parameter='horm_surg_ever_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_hormsurgvr_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  horm_surg_ever_me (ref='never') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=horm_surg_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_hormsurgvr_SR NObs = obs;
run;
data A_hormsurgvr_SR; 
	set A_hormsurgvr_SR ; 
	where Parameter='horm_surg_ever_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_hormsurgvr_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_horm_surg_ever_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** B0c_ins
** ME: oralbc_yn_c_me (ref='never/<1yr')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use multipass;
	class  oralbc_yn_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=oralbc_yn_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_oralbcyn NObs = obs;
run;

data A_oralbcyn; 
	set A_oralbcyn ; 
	where Parameter='oralbc_yn_c_me';
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

** for surgural menopause;
proc phreg data = use multipass;
	class  oralbc_yn_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=oralbc_yn_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_oralbcyn_NM NObs = obs;
run;
data A_oralbcyn_NM; 
	set A_oralbcyn_NM ; 
	where Parameter='oralbc_yn_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_oralbcyn_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  oralbc_yn_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=oralbc_yn_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_oralbcyn_SR NObs = obs;
run;
data A_oralbcyn_SR; 
	set A_oralbcyn_SR ; 
	where Parameter='oralbc_yn_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_oralbcyn_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_oralbc_yn_c_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B0c_mal
** ME: oralbc_yn_c_me (ref='never/<1yr')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use multipass;
	class  oralbc_yn_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=oralbc_yn_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_oralbcyn NObs = obs;
run;

data A_oralbcyn; 
	set A_oralbcyn ; 
	where Parameter='oralbc_yn_c_me';
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

** for surgural menopause;
proc phreg data = use multipass;
	class  oralbc_yn_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=oralbc_yn_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_oralbcyn_NM NObs = obs;
run;
data A_oralbcyn_NM; 
	set A_oralbcyn_NM ; 
	where Parameter='oralbc_yn_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_oralbcyn_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  oralbc_yn_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=oralbc_yn_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_oralbcyn_SR NObs = obs;
run;
data A_oralbcyn_SR; 
	set A_oralbcyn_SR ; 
	where Parameter='oralbc_yn_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_oralbcyn_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_oralbc_yn_c_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** B0d_ins
** ME: ovarystat_c_me (ref='both removed')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  ovarystat_c_me (ref='both removed') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ovarystat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_ovaryst NObs = obs;
run;

data A_ovaryst; 
	set A_ovaryst ; 
	where Parameter='ovarystat_c_me';
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

** for surgural menopause;
proc phreg data = use multipass;
	class  ovarystat_c_me (ref='both removed') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ovarystat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_ovaryst_NM NObs = obs;
run;
data A_ovaryst_NM; 
	set A_ovaryst_NM ; 
	where Parameter='ovarystat_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_ovaryst_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  ovarystat_c_me (ref='both removed') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ovarystat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_ovaryst_SR NObs = obs;
run;
data A_ovaryst_SR; 
	set A_ovaryst_SR ; 
	where Parameter='ovarystat_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_ovaryst_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_ovarystat_c_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B0d_mal
** ME: ovarystat_c_me (ref='both removed')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  ovarystat_c_me (ref='both removed') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ovarystat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_ovaryst NObs = obs;
run;

data A_ovaryst; 
	set A_ovaryst ; 
	where Parameter='ovarystat_c_me';
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

** for surgural menopause;
proc phreg data = use multipass;
	class  ovarystat_c_me (ref='both removed') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ovarystat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_ovaryst_NM NObs = obs;
run;
data A_ovaryst_NM; 
	set A_ovaryst_NM ; 
	where Parameter='ovarystat_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_ovaryst_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  ovarystat_c_me (ref='both removed') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ovarystat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_ovaryst_SR NObs = obs;
run;
data A_ovaryst_SR; 
	set A_ovaryst_SR ; 
	where Parameter='ovarystat_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_ovaryst_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_ovarystat_c_me_mal ; 
	set A_TOT A_NM A_SR; 
run;


******************************************************************************;

ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\modelC\base_model_C.xls' style=minimal;

** put prints here;
proc print data=A_All_flb_age_c_me_ins;
	title1 underlin=1 'AARP Baseline:';
	title2 'Model C';
	title3 '20150709THU WTL';
	title4 'Age at First Live Birth';
run;
proc print data=A_All_flb_age_c_me_mal;
	title;
run;
proc print data=A_All_horm_nat_ever_me_ins;
	title1 'Hormone Ever, natural meno';
run;
proc print data=A_All_horm_nat_ever_me_mal;
	title;
run;
proc print data=A_All_horm_surg_ever_me_ins;
	title1 'Hormone Ever, surg/hyst meno';
run;
proc print data=A_All_horm_surg_ever_me_mal;
	title;
run;
proc print data=A_All_horm_ever_me_ins;
	title1 'Hormone Ever';
run;
proc print data=A_All_horm_ever_me_mal;
	title;
run;
proc print data=A_All_parity_me_ins;
	title1 'Parity';
run;
proc print data=A_All_parity_me_mal;
	title;
run;
proc print data=A_All_fmenstr_me_ins;
	title1 'Age at Menarche';
run;
proc print data=A_All_fmenstr_me_mal;
	title;
run;
proc print data=A_All_oralbc_yn_c_me_ins;
	title1 'Oral Birth Control Ever';
run;
proc print data=A_All_oralbc_yn_c_me_mal;
	title;
run;
proc print data=A_All_oralbc_dur_c_me_ins;
	title1 'Oral Birth Control Duration';
run;
proc print data=A_All_oralbc_dur_c_me_mal;
	title;
run;
proc print data=A_All_menostat_c_me_ins;
	title1 'Menopause Status';
run;
proc print data=A_All_menostat_c_me_mal;
	title;
run;
proc print data=A_All_ovarystat_c_me_ins;
	title1 'Ovary Status, among surg/hyst meno';
run;
proc print data=A_All_ovarystat_c_me_mal;
	title;
run;
proc print data=A_All_meno_age_c_me_ins;
	title1 'Age at Natural Menopause';
run;
proc print data=A_All_meno_age_c_me_mal;
	title;
run;
proc print data=A_All_surg_age_c_me_ins;
	title1 'Age at Surgical Menopause';
run;
proc print data=A_All_surg_age_c_me_mal;
	title;
run;

ods _all_ close;
ods html;

******************************************************************************;
******************************************************************************;
************************** RISKFACTOR ****************************************;
******************************************************************************;
******************************************************************************;

data use_r;
	set conv.melan_r;
run;

******************************************************************************;
********************************************************************************;
** R01_ins
** ME: lacey_eptcurrent_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME+uvrq+educ_c+bmi_c+smoke_former+parity;
** uvrq educ_c bmi_c smoke_former parity / entry
** B: ') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked');
** C: ') parity (ref='1-2 live children');

********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_eptcur NObs = obs;
run;

data A_eptcur; 
	set A_eptcur ; 
	where Parameter='lacey_eptcurrent_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_eptcur_NM NObs = obs;
run;
data A_eptcur_NM; 
	set A_eptcur_NM ; 
	where Parameter='lacey_eptcurrent_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_eptcur_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_eptcur_SR NObs = obs;
run;
data A_eptcur_SR; 
	set A_eptcur_SR ; 
	where Parameter='lacey_eptcurrent_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_eptcur_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_eptcurrent_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R01_mal
** ME: lacey_eptcurrent_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_eptcur NObs = obs;
run;

data A_eptcur; 
	set A_eptcur ; 
	where Parameter='lacey_eptcurrent_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_eptcur_NM NObs = obs;
run;
data A_eptcur_NM; 
	set A_eptcur_NM ; 
	where Parameter='lacey_eptcurrent_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_eptcur_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_eptcur_SR NObs = obs;
run;
data A_eptcur_SR; 
	set A_eptcur_SR ; 
	where Parameter='lacey_eptcurrent_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_eptcur_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_eptcurrent_me_mal ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R02_ins
** ME: lacey_eptdur_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_eptdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_eptdur_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_eptdur NObs = obs;
run;

data A_eptdur; 
	set A_eptdur ; 
	where Parameter='lacey_eptdur_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  lacey_eptdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_eptdur_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_eptdur_NM NObs = obs;
run;
data A_eptdur_NM; 
	set A_eptdur_NM ; 
	where Parameter='lacey_eptdur_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_eptdur_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_eptdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_eptdur_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_eptdur_SR NObs = obs;
run;
data A_eptdur_SR; 
	set A_eptdur_SR ; 
	where Parameter='lacey_eptdur_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_eptdur_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_eptdur_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R02_mal
** ME: lacey_eptdur_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_eptdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_eptdur_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_eptdur NObs = obs;
run;

data A_eptdur; 
	set A_eptdur ; 
	where Parameter='lacey_eptdur_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  lacey_eptdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_eptdur_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_eptdur_NM NObs = obs;
run;
data A_eptdur_NM; 
	set A_eptdur_NM ; 
	where Parameter='lacey_eptdur_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_eptdur_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_eptdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_eptdur_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_eptdur_SR NObs = obs;
run;
data A_eptdur_SR; 
	set A_eptdur_SR ; 
	where Parameter='lacey_eptdur_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_eptdur_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_eptdur_me_mal ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R03_ins
** ME: lacey_eptdose_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_eptdose_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_eptdose_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_eptdose NObs = obs;
run;

data A_eptdose; 
	set A_eptdose ; 
	where Parameter='lacey_eptdose_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  lacey_eptdose_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_eptdose_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_eptdose_NM NObs = obs;
run;
data A_eptdose_NM; 
	set A_eptdose_NM ; 
	where Parameter='lacey_eptdose_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_eptdose_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_eptdose_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_eptdose_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_eptdose_SR NObs = obs;
run;
data A_eptdose_SR; 
	set A_eptdose_SR ; 
	where Parameter='lacey_eptdose_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_eptdose_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_eptdose_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R03_mal
** ME: lacey_eptdose_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_eptdose_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_eptdose_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_eptdose NObs = obs;
run;

data A_eptdose; 
	set A_eptdose ; 
	where Parameter='lacey_eptdose_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  lacey_eptdose_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_eptdose_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_eptdose_NM NObs = obs;
run;
data A_eptdose_NM; 
	set A_eptdose_NM ; 
	where Parameter='lacey_eptdose_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_eptdose_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_eptdose_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_eptdose_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_eptdose_SR NObs = obs;
run;
data A_eptdose_SR; 
	set A_eptdose_SR ; 
	where Parameter='lacey_eptdose_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_eptdose_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_eptdose_me_mal ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R04_ins
** ME: lacey_etcurrent_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_etcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_etcur NObs = obs;
run;

data A_etcur; 
	set A_etcur ; 
	where Parameter='lacey_etcurrent_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  lacey_etcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_etcur_NM NObs = obs;
run;
data A_etcur_NM; 
	set A_etcur_NM ; 
	where Parameter='lacey_etcurrent_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etcur_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_etcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_etcur_SR NObs = obs;
run;
data A_etcur_SR; 
	set A_etcur_SR ; 
	where Parameter='lacey_etcurrent_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etcur_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_etcurrent_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R04_mal
** ME: lacey_etcurrent_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_etcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_etcur NObs = obs;
run;

data A_etcur; 
	set A_etcur ; 
	where Parameter='lacey_etcurrent_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  lacey_etcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_etcur_NM NObs = obs;
run;
data A_etcur_NM; 
	set A_etcur_NM ; 
	where Parameter='lacey_etcurrent_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etcur_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_etcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_etcur_SR NObs = obs;
run;
data A_etcur_SR; 
	set A_etcur_SR ; 
	where Parameter='lacey_etcurrent_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etcur_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_etcurrent_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R05_ins
** ME: lacey_etdur_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_etdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etdur_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_etdur NObs = obs;
run;

data A_etdur; 
	set A_etdur ; 
	where Parameter='lacey_etdur_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  lacey_etdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etdur_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_etdur_NM NObs = obs;
run;
data A_etdur_NM; 
	set A_etdur_NM ; 
	where Parameter='lacey_etdur_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etdur_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_etdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etdur_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_etdur_SR NObs = obs;
run;
data A_etdur_SR; 
	set A_etdur_SR ; 
	where Parameter='lacey_etdur_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etdur_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_etdur_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R05_mal
** ME: lacey_etdur_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_etdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etdur_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_etdur NObs = obs;
run;

data A_etdur; 
	set A_etdur ; 
	where Parameter='lacey_etdur_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  lacey_etdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etdur_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_etdur_NM NObs = obs;
run;
data A_etdur_NM; 
	set A_etdur_NM ; 
	where Parameter='lacey_etdur_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etdur_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_etdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etdur_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_etdur_SR NObs = obs;
run;
data A_etdur_SR; 
	set A_etdur_SR ; 
	where Parameter='lacey_etdur_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etdur_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_etdur_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R06_ins
** ME: lacey_etdose_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_etdose_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etdose_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_etdose NObs = obs;
run;

data A_etdose; 
	set A_etdose ; 
	where Parameter='lacey_etdose_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  lacey_etdose_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etdose_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_etdose_NM NObs = obs;
run;
data A_etdose_NM; 
	set A_etdose_NM ; 
	where Parameter='lacey_etdose_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etdose_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_etdose_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etdose_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_etdose_SR NObs = obs;
run;
data A_etdose_SR; 
	set A_etdose_SR ; 
	where Parameter='lacey_etdose_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etdose_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_etdose_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R06_mal
** ME: lacey_etdose_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_etdose_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etdose_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_etdose NObs = obs;
run;

data A_etdose; 
	set A_etdose ; 
	where Parameter='lacey_etdose_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  lacey_etdose_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etdose_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_etdose_NM NObs = obs;
run;
data A_etdose_NM; 
	set A_etdose_NM ; 
	where Parameter='lacey_etdose_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etdose_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_etdose_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etdose_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_etdose_SR NObs = obs;
run;
data A_etdose_SR; 
	set A_etdose_SR ; 
	where Parameter='lacey_etdose_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etdose_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_etdose_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R07_ins
** ME: flb_age_c_me (ref='< 20 years old')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_flb NObs = obs;
run;

data A_flb; 
	set A_flb ; 
	where Parameter='flb_age_c_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_flb_NM NObs = obs;
run;
data A_flb_NM; 
	set A_flb_NM ; 
	where Parameter='flb_age_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_flb_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=flb_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_flb_SR NObs = obs;
run;
data A_flb_SR; 
	set A_flb_SR ; 
	where Parameter='flb_age_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_flb_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_flb_age_c_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R07_mal
** ME: flb_age_c_me (ref='< 20 years old')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_flb NObs = obs;
run;

data A_flb; 
	set A_flb ; 
	where Parameter='flb_age_c_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_flb_NM NObs = obs;
run;
data A_flb_NM; 
	set A_flb_NM ; 
	where Parameter='flb_age_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_flb_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  flb_age_c_me (ref='< 20 years old') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=flb_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_flb_SR NObs = obs;
run;
data A_flb_SR; 
	set A_flb_SR ; 
	where Parameter='flb_age_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_flb_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_flb_age_c_me_mal ; 
	set A_TOT A_NM A_SR; 
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
	class  parity_me (ref='1-2 live children') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=parity_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  parity_me (ref='1-2 live children') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=parity_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_parity_NM NObs = obs;
run;
data A_parity_NM; 
	set A_parity_NM ; 
	where Parameter='parity_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_parity_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  parity_me (ref='1-2 live children') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=parity_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_parity_SR NObs = obs;
run;
data A_parity_SR; 
	set A_parity_SR ; 
	where Parameter='parity_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_parity_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_parity_me_ins ; 
	set A_TOT A_NM A_SR; 
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
	class  parity_me (ref='1-2 live children') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=parity_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  parity_me (ref='1-2 live children') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=parity_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_parity_NM NObs = obs;
run;
data A_parity_NM; 
	set A_parity_NM ; 
	where Parameter='parity_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_parity_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  parity_me (ref='1-2 live children') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=parity_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_parity_SR NObs = obs;
run;
data A_parity_SR; 
	set A_parity_SR ; 
	where Parameter='parity_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_parity_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_parity_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R09_ins
** ME: fmenstr_me (ref='<=10')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  fmenstr_me (ref='<=10') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=fmenstr_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  fmenstr_me (ref='<=10') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=fmenstr_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_fmenstr_NM NObs = obs;
run;
data A_fmenstr_NM; 
	set A_fmenstr_NM ; 
	where Parameter='fmenstr_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_fmenstr_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  fmenstr_me (ref='<=10') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=fmenstr_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_fmenstr_SR NObs = obs;
run;
data A_fmenstr_SR; 
	set A_fmenstr_SR ; 
	where Parameter='fmenstr_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_fmenstr_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_fmenstr_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R09_mal
** ME: fmenstr_me (ref='<=10')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  fmenstr_me (ref='<=10') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=fmenstr_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  fmenstr_me (ref='<=10') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=fmenstr_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_fmenstr_NM NObs = obs;
run;
data A_fmenstr_NM; 
	set A_fmenstr_NM ; 
	where Parameter='fmenstr_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_fmenstr_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  fmenstr_me (ref='<=10') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=fmenstr_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_fmenstr_SR NObs = obs;
run;
data A_fmenstr_SR; 
	set A_fmenstr_SR ; 
	where Parameter='fmenstr_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_fmenstr_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_fmenstr_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R10_ins
** ME: oralbc_dur_c_me (ref='never/<1yr')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  oralbc_dur_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_oralbc NObs = obs;
run;

data A_oralbc; 
	set A_oralbc ; 
	where Parameter='oralbc_dur_c_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  oralbc_dur_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_oralbc_NM NObs = obs;
run;
data A_oralbc_NM; 
	set A_oralbc_NM ; 
	where Parameter='oralbc_dur_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_oralbc_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  oralbc_dur_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=oralbc_dur_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_oralbc_SR NObs = obs;
run;
data A_oralbc_SR; 
	set A_oralbc_SR ; 
	where Parameter='oralbc_dur_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_oralbc_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_oralbc_dur_c_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R10_mal
** ME: oralbc_dur_c_me (ref='never/<1yr')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  oralbc_dur_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_oralbc NObs = obs;
run;

data A_oralbc; 
	set A_oralbc ; 
	where Parameter='oralbc_dur_c_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  oralbc_dur_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_oralbc_NM NObs = obs;
run;
data A_oralbc_NM; 
	set A_oralbc_NM ; 
	where Parameter='oralbc_dur_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_oralbc_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  oralbc_dur_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=oralbc_dur_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_oralbc_SR NObs = obs;
run;
data A_oralbc_SR; 
	set A_oralbc_SR ; 
	where Parameter='oralbc_dur_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_oralbc_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_oralbc_dur_c_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R11_ins
** ME: menostat_c_me (ref='natural menopause')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  menostat_c_me (ref='natural menopause') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=menostat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_menostat NObs = obs;
run;

data A_menostat; 
	set A_menostat ; 
	where Parameter='menostat_c_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  menostat_c_me (ref='natural menopause') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=menostat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_menostat_NM NObs = obs;
run;
data A_menostat_NM; 
	set A_menostat_NM ; 
	where Parameter='menostat_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_menostat_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  menostat_c_me (ref='natural menopause') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=menostat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_menostat_SR NObs = obs;
run;
data A_menostat_SR; 
	set A_menostat_SR ; 
	where Parameter='menostat_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_menostat_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_menostat_c_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R11_mal
** ME: menostat_c_me (ref='natural menopause')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  menostat_c_me (ref='natural menopause') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=menostat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_menostat NObs = obs;
run;

data A_menostat; 
	set A_menostat ; 
	where Parameter='menostat_c_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  menostat_c_me (ref='natural menopause') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=menostat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_menostat_NM NObs = obs;
run;
data A_menostat_NM; 
	set A_menostat_NM ; 
	where Parameter='menostat_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_menostat_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  menostat_c_me (ref='natural menopause') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=menostat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_menostat_SR NObs = obs;
run;
data A_menostat_SR; 
	set A_menostat_SR ; 
	where Parameter='menostat_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_menostat_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_menostat_c_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R12_ins
** ME: meno_age_c_me (ref='50-54')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  meno_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=meno_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_menoage NObs = obs;
run;

data A_menoage; 
	set A_menoage ; 
	where Parameter='meno_age_c_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_menoage obs;
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
	class  meno_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=meno_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_menoage_NM NObs = obs;
run;
data A_menoage_NM; 
	set A_menoage_NM ; 
	where Parameter='meno_age_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_menoage_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  meno_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=meno_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_menoage_SR NObs = obs;
run;
data A_menoage_SR; 
	set A_menoage_SR ; 
	where Parameter='meno_age_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_menoage_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_meno_age_c_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R12_mal
** ME: meno_age_c_me (ref='50-54')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  meno_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=meno_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_menoage NObs = obs;
run;

data A_menoage; 
	set A_menoage ; 
	where Parameter='meno_age_c_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_menoage obs;
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
	class  meno_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=meno_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_menoage_NM NObs = obs;
run;
data A_menoage_NM; 
	set A_menoage_NM ; 
	where Parameter='meno_age_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_menoage_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  meno_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=meno_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_menoage_SR NObs = obs;
run;
data A_menoage_SR; 
	set A_menoage_SR ; 
	where Parameter='meno_age_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_menoage_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_meno_age_c_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R13_ins
** ME: surg_age_c_me (ref='50-54')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  surg_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=surg_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_surgage NObs = obs;
run;

data A_surgage; 
	set A_surgage ; 
	where Parameter='surg_age_c_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_surgage obs;
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
	class  surg_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=surg_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_surgage_NM NObs = obs;
run;
data A_surgage_NM; 
	set A_surgage_NM ; 
	where Parameter='surg_age_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_surgage_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  surg_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=surg_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_surgage_SR NObs = obs;
run;
data A_surgage_SR; 
	set A_surgage_SR ; 
	where Parameter='surg_age_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_surgage_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_surg_age_c_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R13_mal
** ME: surg_age_c_me (ref='50-54')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  surg_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=surg_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_surgage NObs = obs;
run;

data A_surgage; 
	set A_surgage ; 
	where Parameter='surg_age_c_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_surgage obs;
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
	class  surg_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=surg_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_surgage_NM NObs = obs;
run;
data A_surgage_NM; 
	set A_surgage_NM ; 
	where Parameter='surg_age_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_surgage_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  surg_age_c_me (ref='50-54') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=surg_age_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_surgage_SR NObs = obs;
run;
data A_surgage_SR; 
	set A_surgage_SR ; 
	where Parameter='surg_age_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_surgage_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_surg_age_c_me_mal ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R14_ins
** ME: ht_type_nat_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  ht_type_nat_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ht_type_nat_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_htnat NObs = obs;
run;

data A_htnat; 
	set A_htnat ; 
	where Parameter='ht_type_nat_me';
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
	class  ht_type_nat_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ht_type_nat_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_htnat_NM NObs = obs;
run;
data A_htnat_NM; 
	set A_htnat_NM ; 
	where Parameter='ht_type_nat_me';
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

** for surgical menopause;
proc phreg data = use_r multipass;
	class  ht_type_nat_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ht_type_nat_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_htnat_SR NObs = obs;
run;
data A_htnat_SR; 
	set A_htnat_SR ; 
	where Parameter='ht_type_nat_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_htnat_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_ht_type_nat_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R14_mal
** ME: ht_type_nat_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  ht_type_nat_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ht_type_nat_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_htnat NObs = obs;
run;

data A_htnat; 
	set A_htnat ; 
	where Parameter='ht_type_nat_me';
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
	class  ht_type_nat_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ht_type_nat_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_htnat_NM NObs = obs;
run;
data A_htnat_NM; 
	set A_htnat_NM ; 
	where Parameter='ht_type_nat_me';
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

** for surgical menopause;
proc phreg data = use_r multipass;
	class  ht_type_nat_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ht_type_nat_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_htnat_SR NObs = obs;
run;
data A_htnat_SR; 
	set A_htnat_SR ; 
	where Parameter='ht_type_nat_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_htnat_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_ht_type_nat_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R15_ins
** ME: ht_type_surg_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  ht_type_surg_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ht_type_surg_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_htsurg NObs = obs;
run;

data A_htsurg; 
	set A_htsurg ; 
	where Parameter='ht_type_surg_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  ht_type_surg_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ht_type_surg_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_htsurg_NM NObs = obs;
run;
data A_htsurg_NM; 
	set A_htsurg_NM ; 
	where Parameter='ht_type_surg_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_htsurg_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  ht_type_surg_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ht_type_surg_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_htsurg_SR NObs = obs;
run;
data A_htsurg_SR; 
	set A_htsurg_SR ; 
	where Parameter='ht_type_surg_me';
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

data A_All_ht_type_surg_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R15_mal
** ME: ht_type_surg_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  ht_type_surg_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ht_type_surg_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_htsurg NObs = obs;
run;

data A_htsurg; 
	set A_htsurg ; 
	where Parameter='ht_type_surg_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  ht_type_surg_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ht_type_surg_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_htsurg_NM NObs = obs;
run;
data A_htsurg_NM; 
	set A_htsurg_NM ; 
	where Parameter='ht_type_surg_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_htsurg_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  ht_type_surg_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ht_type_surg_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_htsurg_SR NObs = obs;
run;
data A_htsurg_SR; 
	set A_htsurg_SR ; 
	where Parameter='ht_type_surg_me';
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

data A_All_ht_type_surg_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R16_ins
** ME: lacey_etfreq_me (ref='No HT') 
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_etfreq_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etfreq_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_etfreq NObs = obs;
run;

data A_etfreq; 
	set A_etfreq ; 
	where Parameter='lacey_etfreq_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  lacey_etfreq_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etfreq_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_etfreq_NM NObs = obs;
run;
data A_etfreq_NM; 
	set A_etfreq_NM ; 
	where Parameter='lacey_etfreq_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etfreq_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_etfreq_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etfreq_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_etfreq_SR NObs = obs;
run;
data A_etfreq_SR; 
	set A_etfreq_SR ; 
	where Parameter='lacey_etfreq_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etfreq_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_etfreq_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R16_mal
** ME: lacey_etfreq_me (ref='No HT') 
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_etfreq_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etfreq_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_etfreq NObs = obs;
run;

data A_etfreq; 
	set A_etfreq ; 
	where Parameter='lacey_etfreq_me';
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

** for natural menopause;
proc phreg data = use_r multipass;
	class  lacey_etfreq_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etfreq_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_etfreq_NM NObs = obs;
run;
data A_etfreq_NM; 
	set A_etfreq_NM ; 
	where Parameter='lacey_etfreq_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etfreq_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_etfreq_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etfreq_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_etfreq_SR NObs = obs;
run;
data A_etfreq_SR; 
	set A_etfreq_SR ; 
	where Parameter='lacey_etfreq_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etfreq_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_etfreq_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R0a_ins
** ME: lacey_eptcurrent_ever_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_eptcurrent_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_eptcurvr NObs = obs;
run;

data A_eptcurvr; 
	set A_eptcurvr ; 
	where Parameter='lacey_eptcurrent_eve';
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

** for surgural menopause;
proc phreg data = use_r multipass;
	class  lacey_eptcurrent_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_eptcurvr_NM NObs = obs;
run;
data A_eptcurvr_NM; 
	set A_eptcurvr_NM ; 
	where Parameter='lacey_eptcurrent_eve';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_eptcurvr_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_eptcurrent_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_eptcurvr_SR NObs = obs;
run;
data A_eptcurvr_SR; 
	set A_eptcurvr_SR ; 
	where Parameter='lacey_eptcurrent_eve';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_eptcurvr_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_eptcurrent_ever_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R0a_mal
** ME: lacey_eptcurrent_ever_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_eptcurrent_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_eptcurvr NObs = obs;
run;

data A_eptcurvr; 
	set A_eptcurvr ; 
	where Parameter='lacey_eptcurrent_eve';
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

** for surgural menopause;
proc phreg data = use_r multipass;
	class  lacey_eptcurrent_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_eptcurvr_NM NObs = obs;
run;
data A_eptcurvr_NM; 
	set A_eptcurvr_NM ; 
	where Parameter='lacey_eptcurrent_eve';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_eptcurvr_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_eptcurrent_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_eptcurvr_SR NObs = obs;
run;
data A_eptcurvr_SR; 
	set A_eptcurvr_SR ; 
	where Parameter='lacey_eptcurrent_eve';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_eptcurvr_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_eptcurrent_ever_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R0b_ins
** ME: lacey_etcurrent_ever_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_etcurrent_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_etcurvr NObs = obs;
run;

data A_etcurvr; 
	set A_etcurvr ; 
	where Parameter='lacey_etcurrent_ever';
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

** for surgural menopause;
proc phreg data = use_r multipass;
	class  lacey_etcurrent_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_etcurvr_NM NObs = obs;
run;
data A_etcurvr_NM; 
	set A_etcurvr_NM ; 
	where Parameter='lacey_etcurrent_ever';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etcurvr_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_etcurrent_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=lacey_etcurrent_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_etcurvr_SR NObs = obs;
run;
data A_etcurvr_SR; 
	set A_etcurvr_SR ; 
	where Parameter='lacey_etcurrent_ever';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etcurvr_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_etcurrent_ever_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R0b_mal
** ME: lacey_etcurrent_ever_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_etcurrent_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_etcurvr NObs = obs;
run;

data A_etcurvr; 
	set A_etcurvr ; 
	where Parameter='lacey_etcurrent_ever';
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

** for surgural menopause;
proc phreg data = use_r multipass;
	class  lacey_etcurrent_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_etcurvr_NM NObs = obs;
run;
data A_etcurvr_NM; 
	set A_etcurvr_NM ; 
	where Parameter='lacey_etcurrent_ever';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etcurvr_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_etcurrent_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=lacey_etcurrent_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_etcurvr_SR NObs = obs;
run;
data A_etcurvr_SR; 
	set A_etcurvr_SR ; 
	where Parameter='lacey_etcurrent_ever';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etcurvr_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_etcurrent_ever_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R0c_ins
** ME: oralbc_yn_c_me (ref='never/<1yr')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use_r multipass;
	class  oralbc_yn_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=oralbc_yn_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_oralbcyn NObs = obs;
run;

data A_oralbcyn; 
	set A_oralbcyn ; 
	where Parameter='oralbc_yn_c_me';
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

** for surgural menopause;
proc phreg data = use_r multipass;
	class  oralbc_yn_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=oralbc_yn_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_oralbcyn_NM NObs = obs;
run;
data A_oralbcyn_NM; 
	set A_oralbcyn_NM ; 
	where Parameter='oralbc_yn_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_oralbcyn_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  oralbc_yn_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=oralbc_yn_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_oralbcyn_SR NObs = obs;
run;
data A_oralbcyn_SR; 
	set A_oralbcyn_SR ; 
	where Parameter='oralbc_yn_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_oralbcyn_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_oralbc_yn_c_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R0c_mal
** ME: oralbc_yn_c_me (ref='never/<1yr')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use_r multipass;
	class  oralbc_yn_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=oralbc_yn_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_oralbcyn NObs = obs;
run;

data A_oralbcyn; 
	set A_oralbcyn ; 
	where Parameter='oralbc_yn_c_me';
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

** for surgural menopause;
proc phreg data = use_r multipass;
	class  oralbc_yn_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=oralbc_yn_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_oralbcyn_NM NObs = obs;
run;
data A_oralbcyn_NM; 
	set A_oralbcyn_NM ; 
	where Parameter='oralbc_yn_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_oralbcyn_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  oralbc_yn_c_me (ref='never/<1yr') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=oralbc_yn_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_oralbcyn_SR NObs = obs;
run;
data A_oralbcyn_SR; 
	set A_oralbcyn_SR ; 
	where Parameter='oralbc_yn_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_oralbcyn_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_oralbc_yn_c_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R0d_ins
** ME: ht_type_nat_ever_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use_r multipass;
	class  ht_type_nat_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ht_type_nat_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_htnatvr NObs = obs;
run;

data A_htnatvr; 
	set A_htnatvr ; 
	where Parameter='ht_type_nat_ever_me';
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

** for surgural menopause;
proc phreg data = use_r multipass;
	class  ht_type_nat_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ht_type_nat_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_htnatvr_NM NObs = obs;
run;
data A_htnatvr_NM; 
	set A_htnatvr_NM ; 
	where Parameter='ht_type_nat_ever_me';
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

** for surgical menopause;
proc phreg data = use_r multipass;
	class  ht_type_nat_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ht_type_nat_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_htnatvr_SR NObs = obs;
run;
data A_htnatvr_SR; 
	set A_htnatvr_SR ; 
	where Parameter='ht_type_nat_ever_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_htnatvr_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_ht_type_nat_ever_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R0d_mal
** ME: ht_type_nat_ever_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (surgural + surgical menopause);
proc phreg data = use_r multipass;
	class  ht_type_nat_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ht_type_nat_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_htnatvr NObs = obs;
run;

data A_htnatvr; 
	set A_htnatvr ; 
	where Parameter='ht_type_nat_ever_me';
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

** for surgural menopause;
proc phreg data = use_r multipass;
	class  ht_type_nat_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ht_type_nat_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_htnatvr_NM NObs = obs;
run;
data A_htnatvr_NM; 
	set A_htnatvr_NM ; 
	where Parameter='ht_type_nat_ever_me';
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

** for surgical menopause;
proc phreg data = use_r multipass;
	class  ht_type_nat_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ht_type_nat_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_htnatvr_SR NObs = obs;
run;
data A_htnatvr_SR; 
	set A_htnatvr_SR ; 
	where Parameter='ht_type_nat_ever_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_htnatvr_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_ht_type_nat_ever_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R0e_ins
** ME: ht_type_surg_ever_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  ht_type_surg_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ht_type_surg_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_htsurgvr NObs = obs;
run;

data A_htsurgvr; 
	set A_htsurgvr ; 
	where Parameter='ht_type_surg_ever_me';
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

** for surgural menopause;
proc phreg data = use_r multipass;
	class  ht_type_surg_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ht_type_surg_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_htsurgvr_NM NObs = obs;
run;
data A_htsurgvr_NM; 
	set A_htsurgvr_NM ; 
	where Parameter='ht_type_surg_ever_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_htsurgvr_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  ht_type_surg_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ht_type_surg_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_htsurgvr_SR NObs = obs;
run;
data A_htsurgvr_SR; 
	set A_htsurgvr_SR ; 
	where Parameter='ht_type_surg_ever_me';
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

data A_All_ht_type_surg_ever_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R0e_mal
** ME: ht_type_surg_ever_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  ht_type_surg_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ht_type_surg_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_htsurgvr NObs = obs;
run;

data A_htsurgvr; 
	set A_htsurgvr ; 
	where Parameter='ht_type_surg_ever_me';
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

** for surgural menopause;
proc phreg data = use_r multipass;
	class  ht_type_surg_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ht_type_surg_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_htsurgvr_NM NObs = obs;
run;
data A_htsurgvr_NM; 
	set A_htsurgvr_NM ; 
	where Parameter='ht_type_surg_ever_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_htsurgvr_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  ht_type_surg_ever_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ht_type_surg_ever_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_htsurgvr_SR NObs = obs;
run;
data A_htsurgvr_SR; 
	set A_htsurgvr_SR ; 
	where Parameter='ht_type_surg_ever_me';
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

data A_All_ht_type_surg_ever_me_mal ; 
	set A_TOT A_NM A_SR; 
run;
******************************************************************************;
********************************************************************************;
** R0f_ins
** ME: ovarystat_c_me (ref='both removed')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  ovarystat_c_me (ref='both removed') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ovarystat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_ovaryst NObs = obs;
run;

data A_ovaryst; 
	set A_ovaryst ; 
	where Parameter='ovarystat_c_me';
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

** for surgural menopause;
proc phreg data = use_r multipass;
	class  ovarystat_c_me (ref='both removed') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ovarystat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_ovaryst_NM NObs = obs;
run;
data A_ovaryst_NM; 
	set A_ovaryst_NM ; 
	where Parameter='ovarystat_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_ovaryst_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  ovarystat_c_me (ref='both removed') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_ins(0)=ovarystat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_ovaryst_SR NObs = obs;
run;
data A_ovaryst_SR; 
	set A_ovaryst_SR ; 
	where Parameter='ovarystat_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_ovaryst_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_ovarystat_c_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R0f_mal
** ME: ovarystat_c_me (ref='both removed')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  ovarystat_c_me (ref='both removed') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ovarystat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	ods output ParameterEstimates=A_ovaryst NObs = obs;
run;

data A_ovaryst; 
	set A_ovaryst ; 
	where Parameter='ovarystat_c_me';
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

** for surgural menopause;
proc phreg data = use_r multipass;
	class  ovarystat_c_me (ref='both removed') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ovarystat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_ovaryst_NM NObs = obs;
run;
data A_ovaryst_NM; 
	set A_ovaryst_NM ; 
	where Parameter='ovarystat_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_ovaryst_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  ovarystat_c_me (ref='both removed') uvrq (ref='0 to 186.918') educ_c (ref='less than highschool') bmi_c (ref='< 25') smoke_former (ref='never smoked') parity (ref='1-2 live children');
	model exit_age*melanoma_mal(0)=ovarystat_c_me uvrq educ_c bmi_c smoke_former parity / entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_ovaryst_SR NObs = obs;
run;
data A_ovaryst_SR; 
	set A_ovaryst_SR ; 
	where Parameter='ovarystat_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_ovaryst_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_ovarystat_c_me_mal ; 
	set A_TOT A_NM A_SR; 
run;


******************************************************************************;
ods _all_ close;ods html;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\master\modelC\risk_model_C.xls' style=minimal;

proc print data=A_All_eptcurrent_ever_me_ins;
	title1 underlin=1 'AARP Riskfactor:';
	title2 'Model C';
	title3 '20150709THU WTL';
	title4 'EPT current ever';
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
proc print data=A_All_eptdur_me_ins;
	title1 'Estrogen-Progestin Duration';
run;
proc print data=A_All_eptdur_me_mal;
	title;
run;
proc print data=A_All_eptdose_me_ins;
	title1 'Estrogen-Progestin Dose';
run;
proc print data=A_All_eptdose_me_mal;
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
proc print data=A_All_etdur_me_ins;
	title1 'Estrogen Duration';
run;
proc print data=A_All_etdur_me_mal;
	title;
run;
proc print data=A_All_etdose_me_ins;
	title1 'Estrogen Dose';
run;
proc print data=A_All_etdose_me_mal;
	title;
run;
proc print data=A_All_flb_age_c_me_ins;
	title1 'Age at First Live Birth';
run;
proc print data=A_All_flb_age_c_me_mal;
	title;
run;
proc print data=A_All_parity_me_ins;
	title1 'Parity';
run;
proc print data=A_All_parity_me_mal;
	title;
run;
proc print data=A_All_fmenstr_me_ins;
	title1 'Age at Menarche';
run;
proc print data=A_All_fmenstr_me_mal;
	title;
run;
proc print data=A_All_oralbc_yn_c_me_ins;
	title1 'Oral birth control ever';
run;
proc print data=A_All_oralbc_yn_c_me_mal;
	title;
run;
proc print data=A_All_oralbc_dur_c_me_ins;
	title1 'Oral Contraceptive Duration';
run;
proc print data=A_All_oralbc_dur_c_me_mal;
	title;
run;
proc print data=A_All_menostat_c_me_ins;
	title1 'Menopausal Status';
run;
proc print data=A_All_menostat_c_me_mal;
	title;
run;
proc print data=A_All_ovarystat_c_me_ins;
	title1 'Ovary Status, among surg/hyst meno';
run;
proc print data=A_All_ovarystat_c_me_mal;
	title;
run;
proc print data=A_All_meno_age_c_me_ins;
	title1 'Age at Natural Menopause';
run;
proc print data=A_All_meno_age_c_me_mal;
	title;
run;
proc print data=A_All_surg_age_c_me_ins;
	title1 'Age at Surgical Menopause';
run;
proc print data=A_All_surg_age_c_me_mal;
	title;
run;
proc print data=A_All_ht_type_nat_ever_me_ins;
	title1 'lacey horm ever, nat meno';
run;
proc print data=A_All_ht_type_nat_ever_me_mal;
	title;
run;
proc print data=A_All_ht_type_nat_me_ins;
	title1 'HT Type Among Natural Menopause, Lacey';
run;
proc print data=A_All_ht_type_nat_me_mal;
	title;
run;
proc print data=A_All_ht_type_surg_ever_me_ins;
	title1 'lacey horm ever, surg meno';
run;
proc print data=A_All_ht_type_surg_ever_me_mal;
	title;
run;
proc print data=A_All_ht_type_surg_me_ins;
	title1 'HT Type Among Surgical Menopause, Lacey';
run;
proc print data=A_All_ht_type_surg_me_mal;
	title;
run;
proc print data=A_All_etfreq_me_ins;
	title1 'Estrogen Therapy Frequency, Lacey';
run;
proc print data=A_All_etfreq_me_mal;
	title;
run;
ods _all_ close;ods html;

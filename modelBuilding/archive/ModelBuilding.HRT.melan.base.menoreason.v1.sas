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
# Updated: v20150626 WTL
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
** meno_reason, menopause reason, in situ melanoma **;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Baseline: melanoma, in situ';
	title2 'Exposure: menopause reason';
	title3 'uvrq + 1 confounder';
	title4 'revised parity and flb variables';
	class meno_reason  (ref='natural meno reason') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)= meno_reason uvrq 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='meno_reason';
	variable="Null_Model_meno_reason";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class meno_reason (ref='natural meno reason') educ_c (ref='highschool or less')
			uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=meno_reason educ_c uvrq 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='meno_reason';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class meno_reason  (ref='natural meno reason') bmi_c (ref='18.5 to < 25')
			uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=meno_reason bmi_c uvrq 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='meno_reason';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class meno_reason  (ref='natural meno reason') physic_c (ref='rarely')
			uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=meno_reason physic_c uvrq 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='meno_reason';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class meno_reason  (ref='natural meno reason') parity (ref='nulliparous')
			uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=meno_reason parity uvrq 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='meno_reason';
	variable="parity";
run;

** age at menarche;
proc phreg data = use multipass;
	class meno_reason  (ref='natural meno reason') fmenstr (ref='<=10')
			uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=meno_reason fmenstr uvrq
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='meno_reason';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use multipass;
	class meno_reason  (ref='natural meno reason') flb_age_c (ref='< 20 years old')
			uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=meno_reason flb_age_c uvrq 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='meno_reason';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use multipass;
	class meno_reason  (ref='natural meno reason') oralbc_dur_c (ref='none')
			uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=meno_reason oralbc_dur_c uvrq 
			/ entry = entry_age RL; 
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='meno_reason';
	variable="oralbc_dur_c";
run;

** hormone status, ever;
proc phreg data = use multipass;
	class meno_reason  (ref='natural meno reason') horm_ever (ref='never')
			uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=meno_reason horm_ever uvrq
			/ entry = entry_age RL; 
	ods output ParameterEstimates=horm_ever;
run;
data horm_ever; set horm_ever;
	if Parameter='meno_reason';
	variable="horm_ever";
run;

/** UVR quartiles;
proc phreg data = use multipass;
	class meno_reason  (ref='natural meno reason') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=meno_reason uvrq
			/ entry = entry_age RL; 
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='meno_reason';
	variable="uvrq";
run;
**/
** smoking status;
proc phreg data = use multipass;
	class meno_reason  (ref='natural meno reason') smoke_former (ref='never smoked')
			uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=meno_reason smoke_former uvrq
			/ entry = entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='meno_reason';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class meno_reason  (ref='natural meno reason') coffee_c (ref='none')
			uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=meno_reason coffee_c uvrq
			/ entry = entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='meno_reason';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class meno_reason  (ref='natural meno reason') etoh_c (ref='none')
			uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=meno_reason etoh_c uvrq
			/ entry = entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='meno_reason';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class meno_reason  (ref='natural meno reason') rel_1d_cancer (ref='No')
			uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=meno_reason rel_1d_cancer uvrq
			/ entry = entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='meno_reason';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class meno_reason  (ref='natural meno reason') marriage (ref='married')
			uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=meno_reason marriage uvrq / entry = entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='meno_reason';
	variable="marriage";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data base_menoreason_ins_uvr_1conf; 
	set 
		crude
		education bmi_c physic_c parity flb_age_c
		oralbc_dur_c fmenstr
		horm_ever  smoke_former coffee_c 
		etoh_c rel_1d_cancer marriage; 
		* uvrq;
run;
data base_menoreason_ins_uvr_1conf; 
	set base_menoreason_ins_uvr_1conf
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\menostat\base_menoreason_ins_uvr_1conf.xls' style=minimal;
proc print data= base_menoreason_ins_uvr_1conf; run;
ods _all_ close;ods html;



*****************************************************************************************;
** Analysis of BC, UV + 1 Potential Confounder ******************************************;
*****************************************************************************************;

*** Demographics ***;

proc phreg data = use multipass;
	title '';
	class meno_reason  (ref='1') birth_cohort (ref='1') uvrq (ref='1');
	model exit_age*melanoma_ins(0)=meno_reason birth_cohort uvrq / entry = entry_age RL; 
	ods output ParameterEstimates=crude1;
run;
data crude1; set crude1;
	if Parameter='meno_reason';
	variable="null_model_BC_uvr";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') bmi_cat (ref='1') ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q bmi_cat/ entry = entry_age RL; 
ods output ParameterEstimates=bmi_cat;
run;
data bmi_cat; set bmi_cat;
if Parameter='hrt_evr';
variable="bmi_cat";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_BMI/ entry = entry_age RL; 
ods output ParameterEstimates=bmi_cont;
run;
data bmi_cont; set bmi_cont;
if Parameter='hrt_evr';
variable="bmi_cont";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_HEIGHT/ entry = entry_age RL; 
ods output ParameterEstimates=lq2_height;
run;
data lq2_height; set lq2_height;
if Parameter='hrt_evr';
variable="lq2_height";
run;

*** Behavioral ***;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_SMK_EVER (ref='0');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_SMK_EVER/ entry = entry_age RL; 
ods output ParameterEstimates=smoking;
run;
data smoking; set smoking;
if Parameter='hrt_evr';
variable="smoking";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') alcohol  (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q alcohol/ entry = entry_age RL; 
ods output ParameterEstimates=alcohol;
run;
data alcohol; set alcohol ;
if Parameter='hrt_evr';
variable="alcohol";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') exercize (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q exercize/ entry = entry_age RL; 
ods output ParameterEstimates=exercize;
run;
data exercize; set exercize;
if Parameter='hrt_evr';
variable="exercize";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') ex_stren (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q ex_stren/ entry = entry_age RL; 
ods output ParameterEstimates=ex_stren;
run;
data ex_stren; set ex_stren;
if Parameter='hrt_evr';
variable="ex_stren";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') selfhealth (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q selfhealth/ entry = entry_age RL; 
ods output ParameterEstimates=selfhealth;
run;
data selfhealth; set selfhealth;
if Parameter='hrt_evr';
variable="selfhealth";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q67_DIURETICS (ref='0');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q67_DIURETICS/ entry = entry_age RL; 
ods output ParameterEstimates=diuretics;
run;
data diuretics; set diuretics;
if Parameter='hrt_evr';
variable="diuretics";
run;
*** Constitutional Factors ***;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') eye (ref='3') ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q eye/ entry = entry_age RL; 
ods output ParameterEstimates=eye;
run;
data eye; set eye;
if Parameter='hrt_evr';
variable="eye";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q70_1716 (ref='3');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q70_1716/ entry = entry_age RL;
ods output ParameterEstimates=skin;
run;
data skin; set skin;
if Parameter='hrt_evr';
variable="skin";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') hair (ref='3');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q hair/ entry = entry_age RL; 
ods output ParameterEstimates=hair;
run;
data hair; set hair;
if Parameter='hrt_evr';
variable="hair";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803/ entry = entry_age RL; 
ods output ParameterEstimates=celtic;
run;
data celtic; set celtic;
if Parameter='hrt_evr';
variable="celtic";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') Hispanic (ref='1') ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q Hispanic/ entry = entry_age RL; 
ods output ParameterEstimates=Hispanic;
run;
data Hispanic; set Hispanic;
if Parameter='hrt_evr';
variable="Hispanic";
run;

*** Radiation **;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') hndoseq  (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q hndoseq/ entry = entry_age RL; 
ods output ParameterEstimates=hndoseq;
run;
data hndoseq; set hndoseq;
if Parameter='hrt_evr';
variable="hndoseq";
run;

*** Reproductive factors **;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q numpreg/ entry = entry_age RL; 
ods output ParameterEstimates=numpreg;
run;
data numpreg; set numpreg;
if Parameter='hrt_evr';
variable="numpreg";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1')BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_BRTH_NUM/ entry = entry_age RL; 
ods output ParameterEstimates=LQ2_BRTH_NUM;
run;
data LQ2_BRTH_NUM; set LQ2_BRTH_NUM;
if Parameter='hrt_evr';
variable="LQ2_BRTH_NUM";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q oc_evr_c/ entry = entry_age RL; 
ods output ParameterEstimates=oc_evr_c;
run;
data oc_evr_c; set oc_evr_c;
if Parameter='hrt_evr';
variable="oc_evr_c";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1')BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q34_707/ entry = entry_age RL; 
ods output ParameterEstimates=menarche_age;
run;
data menarche_age; set menarche_age;
if Parameter='hrt_evr';
variable="menarche_age";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2NO_EVER/ entry = entry_age RL; 
ods output ParameterEstimates=LQ2NO_EVER;
run;
data LQ2NO_EVER; set LQ2NO_EVER;
if Parameter='hrt_evr';
variable="LQ2NO_EVER";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q36_710/ entry = entry_age RL; 
ods output ParameterEstimates=menoage_cont;
run;
data menoage_cont; set menoage_cont;
if Parameter='hrt_evr';
variable="menoage_cont";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') meno_age (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q meno_age/ entry = entry_age RL; 
ods output ParameterEstimates=menoage_cat;
run;
data menoage_cat; set menoage_cat;
if Parameter='hrt_evr';
variable="menoage_cat";
run;
proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') hyster(ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q hyster/ entry = entry_age RL; 
ods output ParameterEstimates=hysterectomy;
run;
data hysterectomy ; set hysterectomy ;
if Parameter='hrt_evr';
variable="hysterectomy";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') natmeno(ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q natmeno/ entry = entry_age RL; 
ods output ParameterEstimates=natmeno;
run;
data natmeno ; set natmeno ;
if Parameter='hrt_evr';
variable="natmeno";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') ovaries(ref='3');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q ovaries/ entry = entry_age RL; 
ods output ParameterEstimates=ovaries;
run;
data ovaries ; set ovaries ;
if Parameter='hrt_evr';
variable="ovaries";
run;

ods html close;ods _all_ close;ods html;
*Combine and output to excel;
data confounder2_testing; 
set 
null bmi_cat bmi_cont lq2_height
smoking alcohol 
exercize ex_stren selfhealth diuretics
eye skin hair celtic Hispanic
hndoseq 
numpreg LQ2_BRTH_NUM oc_evr_c menarche_age 
LQ2NO_EVER menoage_cat menoage_cont hysterectomy natmeno ovaries
; run;
data confounder2_testing; set confounder2_testing
(Keep= variable HazardRatio HRLowerCL HRUpperCL); Parameter=log(HazardRatio);run;
ods html file='E:\NCI\HRT OC and BCC in USRT\Results\HRT\confounder2_testing.xls' style=minimal;
proc print data= confounder2_testing; run;
ods html close;ods _all_ close;ods html;

*****************************************************************************************;
** Analysis of BC, UV, celtic, + 1 Potential Confounder ******************************************;
*****************************************************************************************;

*** Demographics ***;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 / entry = entry_age RL; 
ods output ParameterEstimates=null;
run;
data null; set null;
if Parameter='hrt_evr';
variable="nullBCUVcelt";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') meno_age (ref='1')LQ2_Q81_1803 (ref='1') bmi_cat (ref='1') ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 bmi_cat/ entry = entry_age RL; 
ods output ParameterEstimates=bmi_cat;
run;
data bmi_cat; set bmi_cat;
if Parameter='hrt_evr';
variable="bmi_cat";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803  LQ2_BMI/ entry = entry_age RL; 
ods output ParameterEstimates=bmi_cont;
run;
data bmi_cont; set bmi_cont;
if Parameter='hrt_evr';
variable="bmi_cont";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1') ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 LQ2_HEIGHT/ entry = entry_age RL; 
ods output ParameterEstimates=lq2_height;
run;
data lq2_height; set lq2_height;
if Parameter='hrt_evr';
variable="lq2_height";
run;

*** Behavioral ***;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1') LQ2_SMK_EVER (ref='0');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 LQ2_SMK_EVER/ entry = entry_age RL; 
ods output ParameterEstimates=smoking;
run;
data smoking; set smoking;
if Parameter='hrt_evr';
variable="smoking";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1') alcohol  (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 alcohol/ entry = entry_age RL; 
ods output ParameterEstimates=alcohol;
run;
data alcohol; set alcohol ;
if Parameter='hrt_evr';
variable="alcohol";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1') exercize (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 exercize/ entry = entry_age RL; 
ods output ParameterEstimates=exercize;
run;
data exercize; set exercize;
if Parameter='hrt_evr';
variable="exercize";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1') ex_stren (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 ex_stren/ entry = entry_age RL; 
ods output ParameterEstimates=ex_stren;
run;
data ex_stren; set ex_stren;
if Parameter='hrt_evr';
variable="ex_stren";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1') selfhealth (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 selfhealth/ entry = entry_age RL; 
ods output ParameterEstimates=selfhealth;
run;
data selfhealth; set selfhealth;
if Parameter='hrt_evr';
variable="selfhealth";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1') LQ2_Q67_DIURETICS (ref='0');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 LQ2_Q67_DIURETICS/ entry = entry_age RL; 
ods output ParameterEstimates=diuretics;
run;
data diuretics; set diuretics;
if Parameter='hrt_evr';
variable="diuretics";
run;
*** Constitutional Factors ***;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1') eye (ref='3') ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 eye/ entry = entry_age RL; 
ods output ParameterEstimates=eye;
run;
data eye; set eye;
if Parameter='hrt_evr';
variable="eye";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1') LQ2_Q70_1716 (ref='3');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 LQ2_Q70_1716/ entry = entry_age RL;
ods output ParameterEstimates=skin;
run;
data skin; set skin;
if Parameter='hrt_evr';
variable="skin";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1') hair (ref='3');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 hair/ entry = entry_age RL; 
ods output ParameterEstimates=hair;
run;
data hair; set hair;
if Parameter='hrt_evr';
variable="hair";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1') Hispanic (ref='1') ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 Hispanic/ entry = entry_age RL; 
ods output ParameterEstimates=Hispanic;
run;
data Hispanic; set Hispanic;
if Parameter='hrt_evr';
variable="Hispanic";
run;

*** Radiation **;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1') hndoseq  (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 hndoseq/ entry = entry_age RL; 
ods output ParameterEstimates=hndoseq;
run;
data hndoseq; set hndoseq;
if Parameter='hrt_evr';
variable="hndoseq";
run;

*** Reproductive factors **;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 numpreg/ entry = entry_age RL; 
ods output ParameterEstimates=numpreg;
run;
data numpreg; set numpreg;
if Parameter='hrt_evr';
variable="numpreg";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1')BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1') ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 LQ2_BRTH_NUM/ entry = entry_age RL; 
ods output ParameterEstimates=LQ2_BRTH_NUM;
run;
data LQ2_BRTH_NUM; set LQ2_BRTH_NUM;
if Parameter='hrt_evr';
variable="LQ2_BRTH_NUM";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 oc_evr_c/ entry = entry_age RL; 
ods output ParameterEstimates=oc_evr_c;
run;
data oc_evr_c; set oc_evr_c;
if Parameter='hrt_evr';
variable="oc_evr_c";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1')BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1') ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 LQ2_Q34_707/ entry = entry_age RL; 
ods output ParameterEstimates=menarche_age;
run;
data menarche_age; set menarche_age;
if Parameter='hrt_evr';
variable="menarche_age";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 LQ2NO_EVER/ entry = entry_age RL; 
ods output ParameterEstimates=LQ2NO_EVER;
run;
data LQ2NO_EVER; set LQ2NO_EVER;
if Parameter='hrt_evr';
variable="LQ2NO_EVER";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 LQ2_Q36_710/ entry = entry_age RL; 
ods output ParameterEstimates=menoage_cont;
run;
data menoage_cont; set menoage_cont;
if Parameter='hrt_evr';
variable="menoage_cont";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1') meno_age (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 meno_age/ entry = entry_age RL; 
ods output ParameterEstimates=menoage_cat;
run;
data menoage_cat; set menoage_cat;
if Parameter='hrt_evr';
variable="menoage_cat";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1') hyster(ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 hyster/ entry = entry_age RL; 
ods output ParameterEstimates=hysterectomy;
run;
data hysterectomy ; set hysterectomy ;
if Parameter='hrt_evr';
variable="hysterectomy";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q  (ref='1') LQ2_Q81_1803 (ref='1') natmeno(ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 natmeno/ entry = entry_age RL; 
ods output ParameterEstimates=natmeno;
run;
data natmeno ; set natmeno ;
if Parameter='hrt_evr';
variable="natmeno";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT (ref='1') UVTOMS305q (ref='1') LQ2_Q81_1803 (ref='1') ovaries(ref='3');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 ovaries/ entry = entry_age RL; 
ods output ParameterEstimates=ovaries;
run;
data ovaries ; set ovaries ;
if Parameter='hrt_evr';
variable="ovaries";
run;

ods html close;ods _all_ close;ods html;
*Combine and output to excel;
data confounder3_testing; 
set 
null bmi_cat bmi_cont lq2_height
smoking alcohol exercize ex_stren selfhealth diuretics
eye skin hair Hispanic
hndoseq 
numpreg LQ2_BRTH_NUM oc_evr_c menarche_age 
LQ2NO_EVER menoage_cont menoage_cat hysterectomy natmeno ovaries
; run;
data confounder3_testing; set confounder3_testing
(Keep= variable HazardRatio HRLowerCL HRUpperCL); Parameter=log(HazardRatio);run;
ods html file='E:\NCI\HRT OC and BCC in USRT\Results\HRT\confounder3_testing.xls' style=minimal;
proc print data= confounder3_testing; run;
ods html close;ods _all_ close;ods html;


********************************************************************************************************;
********   INTERACTION                                                                             *****;
********************************************************************************************************;

*** Demographics ***;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803;
model  exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS  LQ2_Q81_1803 hrt_evr*BIRTH_COHORT/ entry = entry_age RL; 
ods output Type3=birthcohorti;
run;
data birthcohorti; set birthcohorti;
if Effect='hrt_evr_m*BIRTH_COHO';
variable="BIRTH_COHORT";
run; 

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT  LQ2_Q81_1803 BMI_CAT (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 BMI_CAT hrt_evr*BMI_CAT/ entry = entry_age RL; 
ods output Type3=bmi_cati;
run;
data bmi_cati; set bmi_cati;
if Effect='hrt_evr*bmi_cat';
variable="BMI_CAT";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803 ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 LQ2_HEIGHT hrt_evr*LQ2_HEIGHT/ entry = entry_age RL; 
ods output Type3=LQ2_HEIGHTi;
run;
data LQ2_HEIGHTi; set LQ2_HEIGHTi;
if Effect='LQ2_HEIGH*hrt_evr';
variable="LQ2_HEIGHT";
run;

*** Behavioral ***;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803 LQ2_SMK_EVER (ref='0') ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 LQ2_SMK_EVER hrt_evr*LQ2_SMK_EVER/ entry = entry_age RL; 
ods output Type3=smokingi;
run;
data smokingi; set smokingi;
if Effect='hrt_evr_m*LQ2_SMK_EV';
variable="smoking";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803 alcohol ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 alcohol hrt_evr*alcohol/ entry = entry_age RL; 
ods output Type3=alcoholi;
run;
data alcoholi; set alcoholi;
if Effect='hrt_evr*alcohol';
variable="alcohol";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803 exercize  (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 exercize hrt_evr*exercize/ entry = entry_age RL; 
ods output Type3=exercizei;
run;
data exercizei; set exercizei;
if Effect='hrt_evr*exercize';
variable="exercize";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT  LQ2_Q81_1803 ex_stren  (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 ex_stren hrt_evr*ex_stren/ entry = entry_age RL; 
ods output Type3=ex_streni;
run;
data ex_streni; set ex_streni;
if Effect='hrt_evr*ex_stren';
variable="ex_stren";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803 selfhealth  (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 selfhealth hrt_evr*selfhealth/ entry = entry_age RL; 
ods output Type3=selfhealthi;
run;
data selfhealthi; set selfhealthi;
if Effect='hrt_evr_m*selfhealth';
variable="selfhealth";
run;

*** Constitutional Factors ***;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT  LQ2_Q81_1803 eye ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 eye hrt_evr*eye/ entry = entry_age RL; 
ods output Type3=eyei;
run;
data eyei; set eyei;
if Effect='hrt_evr*eye';
variable="eye";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803 LQ2_Q70_1716  ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 LQ2_Q70_1716 hrt_evr*LQ2_Q70_1716/ entry = entry_age RL; 
ods output Type3=skini;
run;
data skini; set skini;
if Effect='hrt_evr_m*LQ2_Q70_17';
variable="skin";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803  hair ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 hair hrt_evr*hair/ entry = entry_age RL; 
ods output Type3=hairi;
run;
data hairi; set hairi;
if Effect='hrt_evr*hair';
variable="hair";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803 ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 hrt_evr*LQ2_Q81_1803/ entry = entry_age RL; 
ods output Type3=celtici;
run;
data celtici; set celtici;
if Effect='hrt_evr_m*LQ2_Q81_18';
variable="celtic";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803  Hispanic  ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 Hispanic hrt_evr*Hispanic/ entry = entry_age RL; 
ods output Type3=Hispanici;
run;
data Hispanici; set Hispanici;
if Effect='hrt_evr*HISPANIC';
variable="Hispanic";
run;

*** Radiation **;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT UVTOMS305q  LQ2_Q81_1803 ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS305q LQ2_Q81_1803 hrt_evr*UVTOMS305q/ entry = entry_age RL; 
ods output Type3=UVTOMS305qi;
run;
data UVTOMS305qi; set UVTOMS305qi;
if Effect='hrt_evr_m*uvtoms305q';
variable="UVTOMS305q";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803  hndoseq  ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT LQ2_Q81_1803 hndoseq hrt_evr*hndoseq/ entry = entry_age RL; 
ods output Type3=hndoseqi;
run;
data hndoseqi; set hndoseqi;
if Effect='hrt_evr*hndoseq';
variable="hndoseq";
run;

*** Reproductive factors **;
proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803 LQ2NO_EVER;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 LQ2NO_EVER hrt_evr*LQ2NO_EVER/ entry = entry_age RL; 
ods output Type3=LQ2NO_EVERi;
run;
data LQ2NO_EVERi; set LQ2NO_EVERi;
if Effect='hrt_evr_m*LQ2NO_E';
variable="LQ2NO_E";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT  LQ2_Q81_1803  numpreg;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 numpreg hrt_evr*numpreg/ entry = entry_age RL; 
ods output Type3=numpregi;
run;
data numpregi; set numpregi;
if Effect='hrt_evr*numpreg';
variable="numpreg";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803  LQ2_BRTH_NUM;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 LQ2_BRTH_NUM hrt_evr*LQ2_BRTH_NUM/ entry = entry_age RL; 
ods output Type3=LQ2_BRTH_NUMi;
run;
data LQ2_BRTH_NUMi; set LQ2_BRTH_NUMi;
if Effect='hrt_evr_m*LQ2_BRTH_N';
variable="LQ2_BRTH_N";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803  oc_evr_c ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 oc_evr_c hrt_evr*oc_evr_c/ entry = entry_age RL; 
ods output Type3=oc_evr_ci;
run;
data oc_evr_ci; set oc_evr_ci;
if Effect='hrt_evr*oc_evr_c';
variable="oc_evr_c";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803  menarche_age;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 menarche_age hrt_evr*menarche_age/ entry = entry_age RL; 
ods output Type3=menarche_agei;
run;
data menarche_agei; set menarche_agei;
if Effect='hrt_evr_m*menarche_a';
variable="menarche_a";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803  ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 LQ2_Q36_710 hrt_evr*LQ2_Q36_710/ entry = entry_age RL; 
ods output Type3=menoage_conti;
run;
data menoage_conti; set menoage_conti;
if Effect='LQ2_Q36_7*hrt_evr';
variable="menoage_cont";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803  meno_age ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 meno_age hrt_evr*meno_age/ entry = entry_age RL; 
ods output Type3=menoage_cati;
run;
data menoage_cati; set menoage_cati;
if Effect='hrt_evr*meno_age';
variable="menoage_cat";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803 hyster;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 hyster hrt_evr*hyster/ entry = entry_age RL; 
ods output Type3=hysterectomyi;
run;
data hysterectomyi; set hysterectomyi;
if Effect='hrt_evr*hyster';
variable="hysterectomy";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803  natmeno;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 natmeno hrt_evr*natmeno/ entry = entry_age RL; 
ods output Type3=natmenoi;
run;
data natmenoi; set natmenoi;
if Effect='hrt_evr*natmeno';
variable="natmeno";
run;

proc phreg data = use multipass;
class hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803 ovaries;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803 ovaries hrt_evr*ovaries/ entry = entry_age RL; 
ods output Type3=ovariesi;
run;
data ovariesi; set ovariesi;
if Effect='hrt_evr*ovaries';
variable="ovaries";
run;

ods html close; ods _all_ close; ods html;
*Combine and output to excel;
data interaction_testing; 
set 
birthcohorti bmi_cati lq2_heighti
smokingi alcoholi 
exercizei ex_streni selfhealthi
eyei skini hairi celtici Hispanici
hndoseqi UVTOMS305qi
numpregi LQ2_BRTH_NUMi oc_evr_ci menarche_agei 
LQ2NO_EVERi menoage_conti menoage_cati hysterectomyi natmenoi ovariesi; run;
data interaction_testing; 
set interaction_testing
(Keep= variable ProbChiSq); run;
ods html file='E:\NCI\HRT OC and BCC in USRT\Results\HRT\interaction_testing.xls' style=minimal;
proc print data= interaction_testing; run;
ods html close; ods _all_ close; ods html;


*****************************************************************************************;
******   Model Building Table  **********************************************************;
*****************************************************************************************;


*A = unadjusted, except for age*;

proc phreg data = use multipass;
class  hrt_evr  (ref='1');
model exit_age*EVENT_BCC(0)=hrt_evr/ entry = entry_age RL; 
ods output ParameterEstimates=A_HRT;
run;
data A_HRT; set A_HRT ; where Parameter='hrt_evr';Sortvar=1; run;
proc phreg data = use multipass;
class  hrt_dur0 (ref='0');
model exit_age*EVENT_BCC(0)=hrt_dur0/ entry = entry_age RL; 
ods output ParameterEstimates=A_HRTdur;
run;
data A_HRTdur; set A_HRTdur ; where Parameter='hrt_dur0';
if Classval0=1  then Sortvar=2;
if Classval0=2  then Sortvar=3;
if Classval0=3  then Sortvar=4;
if Classval0=4  then Sortvar=5;
if Classval0=5  then Sortvar=6;
run;
data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); set A_HRT A_HRTdur ;run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); set A_TOT; run;
data A_TOT ; set A_TOT; model='Total'; run;

proc phreg data = use multipass;
class  hrt_evr (ref='1') ;
model exit_age*EVENT_BCC(0)=hrt_evr/ entry = entry_age RL; 
where natmeno=2;
ods output ParameterEstimates=A_HRT_NM;
run;
data A_HRT_NM; set A_HRT_NM ; where Parameter='hrt_evr';Sortvar=1; run;
proc phreg data = use multipass;
class  hrt_dur0 (ref='0');
model exit_age*EVENT_BCC(0)=hrt_dur0 / entry = entry_age RL; 
where natmeno=2;
ods output ParameterEstimates=A_HRTdur_NM;
run;
data A_HRTdur_NM; set A_HRTdur_NM ; where Parameter='hrt_dur0';
if Classval0=1  then Sortvar=2;
if Classval0=2  then Sortvar=3;
if Classval0=3  then Sortvar=4;
if Classval0=4  then Sortvar=5;
if Classval0=5  then Sortvar=6;
run;
data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); set A_HRT_NM A_HRTdur_NM ;run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); set A_NM ;run;
data A_NM ; set A_NM; model='Natmeno'; run;

proc phreg data = use multipass;
class  hrt_evr (ref='1') ;
model exit_age*EVENT_BCC(0)=hrt_evr/ entry = entry_age RL; 
where hyster=2;
ods output ParameterEstimates=A_HRT_HY;
run;
data A_HRT_Hy; set A_HRT_HY ; where Parameter='hrt_evr';Sortvar=1; run;
proc phreg data = use multipass;
class  hrt_dur0 (ref='0');
model exit_age*EVENT_BCC(0)=hrt_dur0/ entry = entry_age RL; 
where hyster=2;
ods output ParameterEstimates=A_HRTdur_HY;
run;
data A_HRTdur_HY; set A_HRTdur_HY ; where Parameter='hrt_dur0';
if Classval0=1  then Sortvar=2;
if Classval0=2  then Sortvar=3;
if Classval0=3  then Sortvar=4;
if Classval0=4  then Sortvar=5;
if Classval0=5  then Sortvar=6;
run;
data A_HY (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); set A_HRT_HY A_HRTdur_HY ;run;
data A_HY (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); set A_HY ;run;
data A_HY ; set A_HY; model='Hyster'; run;

data A_All ; set A_TOT A_NM A_HY; run;

*B = adjusted for age, bc*;

proc phreg data = use multipass;
class  hrt_evr  (ref='1') BIRTH_COHORT;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT/ entry = entry_age RL; 
ods output ParameterEstimates=B_HRT;
run;
data B_HRT; set B_HRT ; where Parameter='hrt_evr';Sortvar=1; run;
proc phreg data = use multipass;
class  hrt_dur0 (ref='0') BIRTH_COHORT;
model exit_age*EVENT_BCC(0)=hrt_dur0 BIRTH_COHORT/ entry = entry_age RL; 
ods output ParameterEstimates=B_HRTdur;
run;
data B_HRTdur; set B_HRTdur ; where Parameter='hrt_dur0';
if Classval0=1  then Sortvar=2;
if Classval0=2  then Sortvar=3;
if Classval0=3  then Sortvar=4;
if Classval0=4  then Sortvar=5;
if Classval0=5  then Sortvar=6;
run;
data B_TOT (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); set B_HRT B_HRTdur ;run;
data B_TOT (keep=Parameter ClassVal0 Sortvar B_HR B_LL B_UL); set B_TOT; run;
data B_TOT ; set B_TOT; model='Total'; run;

proc phreg data = use multipass;
class  hrt_evr (ref='1')BIRTH_COHORT;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT/ entry = entry_age RL; 
where natmeno=2;
ods output ParameterEstimates=B_HRT_NM;
run;
data B_HRT_NM; set B_HRT_NM ; where Parameter='hrt_evr';Sortvar=1; run;
proc phreg data = use multipass;
class  hrt_dur0 (ref='0') BIRTH_COHORT;
model exit_age*EVENT_BCC(0)=hrt_dur0  BIRTH_COHORT/ entry = entry_age RL; 
where natmeno=2;
ods output ParameterEstimates=B_HRTdur_NM;
run;
data B_HRTdur_NM; set B_HRTdur_NM ; where Parameter='hrt_dur0';
if Classval0=1  then Sortvar=2;
if Classval0=2  then Sortvar=3;
if Classval0=3  then Sortvar=4;
if Classval0=4  then Sortvar=5;
if Classval0=5  then Sortvar=6;
run;
data B_NM (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); set B_HRT_NM B_HRTdur_NM ;run;
data B_NM (keep=Parameter ClassVal0 Sortvar B_HR B_LL B_UL); set B_NM ;run;
data B_NM ; set B_NM; model='Natmeno'; run;

proc phreg data = use multipass;
class  hrt_evr (ref='1')  BIRTH_COHORT;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT/ entry = entry_age RL; 
where hyster=2;
ods output ParameterEstimates=B_HRT_HY;
run;
data B_HRT_Hy; set B_HRT_HY ; where Parameter='hrt_evr';Sortvar=1; run;
proc phreg data = use multipass;
class  hrt_dur0 (ref='0') BIRTH_COHORT;
model exit_age*EVENT_BCC(0)=hrt_dur0 BIRTH_COHORT/ entry = entry_age RL; 
where hyster=2;
ods output ParameterEstimates=B_HRTdur_HY;
run;
data B_HRTdur_HY; set B_HRTdur_HY ; where Parameter='hrt_dur0';
if Classval0=1  then Sortvar=2;
if Classval0=2  then Sortvar=3;
if Classval0=3  then Sortvar=4;
if Classval0=4  then Sortvar=5;
if Classval0=5  then Sortvar=6;
run;
data B_HY (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); set B_HRT_HY B_HRTdur_HY ;run;
data B_HY (keep=Parameter ClassVal0 Sortvar B_HR B_LL B_UL); set B_HY ;run;
data B_HY ; set B_HY; model='Hyster'; run;

data B_All ; set B_TOT B_NM B_HY; run;

*C) adjusted for age, bc, UV;

proc phreg data = use multipass;
class  hrt_evr  (ref='1') BIRTH_COHORT  ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS/ entry = entry_age RL; 
ods output ParameterEstimates=C_HRT;
run;
data C_HRT; set C_HRT ; where Parameter='hrt_evr';Sortvar=1; run;
proc phreg data = use multipass;
class  hrt_dur0 (ref='0') BIRTH_COHORT;
model exit_age*EVENT_BCC(0)=hrt_dur0 BIRTH_COHORT UVTOMS/ entry = entry_age RL; 
ods output ParameterEstimates=C_HRTdur;
run;
data C_HRTdur; set C_HRTdur ; where Parameter='hrt_dur0';
if Classval0=1  then Sortvar=2;
if Classval0=2  then Sortvar=3;
if Classval0=3  then Sortvar=4;
if Classval0=4  then Sortvar=5;
if Classval0=5  then Sortvar=6;
run;
data C_TOT (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); set C_HRT C_HRTdur ;run;
data C_TOT (keep=Parameter ClassVal0 Sortvar C_HR C_LL C_UL); set C_TOT; run;
data C_TOT ; set C_TOT; model='Total'; run;

proc phreg data = use multipass;
class  hrt_evr (ref='1')BIRTH_COHORT;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS/ entry = entry_age RL; 
where natmeno=2;
ods output ParameterEstimates=C_HRT_NM;
run;
data C_HRT_NM; set C_HRT_NM ; where Parameter='hrt_evr';Sortvar=1; run;
proc phreg data = use multipass;
class  hrt_dur0 (ref='0') BIRTH_COHORT;
model exit_age*EVENT_BCC(0)=hrt_dur0  BIRTH_COHORT UVTOMS/ entry = entry_age RL; 
where natmeno=2;
ods output ParameterEstimates=C_HRTdur_NM;
run;
data C_HRTdur_NM; set C_HRTdur_NM ; where Parameter='hrt_dur0';
if Classval0=1  then Sortvar=2;
if Classval0=2  then Sortvar=3;
if Classval0=3  then Sortvar=4;
if Classval0=4  then Sortvar=5;
if Classval0=5  then Sortvar=6;
run;
data C_NM (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); set C_HRT_NM C_HRTdur_NM ;run;
data C_NM (keep=Parameter ClassVal0 Sortvar C_HR C_LL C_UL); set C_NM ;run;
data C_NM ; set C_NM; model='Natmeno'; run;

proc phreg data = use multipass;
class  hrt_evr (ref='1')  BIRTH_COHORT;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS/ entry = entry_age RL; 
where hyster=2;
ods output ParameterEstimates=C_HRT_HY;
run;
data C_HRT_Hy; set C_HRT_HY ; where Parameter='hrt_evr';Sortvar=1; run;
proc phreg data = use multipass;
class  hrt_dur0 (ref='0') BIRTH_COHORT;
model exit_age*EVENT_BCC(0)=hrt_dur0 BIRTH_COHORT UVTOMS/ entry = entry_age RL; 
where hyster=2;
ods output ParameterEstimates=C_HRTdur_HY;
run;
data C_HRTdur_HY; set C_HRTdur_HY ; where Parameter='hrt_dur0';
if Classval0=1  then Sortvar=2;
if Classval0=2  then Sortvar=3;
if Classval0=3  then Sortvar=4;
if Classval0=4  then Sortvar=5;
if Classval0=5  then Sortvar=6;
run;
data C_HY (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); set C_HRT_HY C_HRTdur_HY ;run;
data C_HY (keep=Parameter ClassVal0 Sortvar C_HR C_LL C_UL); set C_HY ;run;
data C_HY ; set C_HY; model='Hyster'; run;

data C_All ; set C_TOT C_NM C_HY; run;

*D) adjusted for age, bc, UV quartile, celtic (LQ2_Q81_1803);

proc phreg data = use multipass;
class  hrt_evr  (ref='1') BIRTH_COHORT LQ2_Q81_1803 ;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803/ entry = entry_age RL; 
ods output ParameterEstimates=D_HRT;
run;
data D_HRT; set D_HRT ; where Parameter='hrt_evr';Sortvar=1; run;
proc phreg data = use multipass;
class  hrt_dur0 (ref='0') BIRTH_COHORT LQ2_Q81_1803;
model exit_age*EVENT_BCC(0)=hrt_dur0 BIRTH_COHORT UVTOMS LQ2_Q81_1803/ entry = entry_age RL; 
ods output ParameterEstimates=D_HRTdur;
run;
data D_HRTdur; set D_HRTdur ; where Parameter='hrt_dur0';
if Classval0=1  then Sortvar=2;
if Classval0=2  then Sortvar=3;
if Classval0=3  then Sortvar=4;
if Classval0=4  then Sortvar=5;
if Classval0=5  then Sortvar=6;
run;
data D_TOT (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); set D_HRT D_HRTdur ;run;
data D_TOT (keep=Parameter ClassVal0 Sortvar D_HR D_LL D_UL); set D_TOT; run;
data D_TOT ; set D_TOT; model='Total'; run;

proc phreg data = use multipass;
class  hrt_evr (ref='1')BIRTH_COHORT LQ2_Q81_1803;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803/ entry = entry_age RL; 
where natmeno=2;
ods output ParameterEstimates=D_HRT_NM;
run;
data D_HRT_NM; set D_HRT_NM ; where Parameter='hrt_evr';Sortvar=1; run;
proc phreg data = use multipass;
class  hrt_dur0 (ref='0') BIRTH_COHORT LQ2_Q81_1803;
model exit_age*EVENT_BCC(0)=hrt_dur0  BIRTH_COHORT UVTOMS LQ2_Q81_1803/ entry = entry_age RL; 
where natmeno=2;
ods output ParameterEstimates=D_HRTdur_NM;
run;
data D_HRTdur_NM; set D_HRTdur_NM ; where Parameter='hrt_dur0';
if Classval0=1  then Sortvar=2;
if Classval0=2  then Sortvar=3;
if Classval0=3  then Sortvar=4;
if Classval0=4  then Sortvar=5;
if Classval0=5  then Sortvar=6;
run;
data D_NM (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); set D_HRT_NM D_HRTdur_NM ;run;
data D_NM (keep=Parameter ClassVal0 Sortvar D_HR D_LL D_UL); set D_NM ;run;
data D_NM ; set D_NM; model='Natmeno'; run;

proc phreg data = use multipass;
class  hrt_evr (ref='1') BIRTH_COHORT LQ2_Q81_1803;
model exit_age*EVENT_BCC(0)=hrt_evr BIRTH_COHORT UVTOMS LQ2_Q81_1803/ entry = entry_age RL; 
where hyster=2;
ods output ParameterEstimates=D_HRT_HY;
run;
data D_HRT_Hy; set D_HRT_HY ; where Parameter='hrt_evr';Sortvar=1; run;
proc phreg data = use multipass;
class  hrt_dur0 (ref='0') BIRTH_COHORT LQ2_Q81_1803;
model exit_age*EVENT_BCC(0)=hrt_dur0 BIRTH_COHORT UVTOMS LQ2_Q81_1803/ entry = entry_age RL; 
where hyster=2;
ods output ParameterEstimates=D_HRTdur_HY;
run;
data D_HRTdur_HY; set D_HRTdur_HY ; where Parameter='hrt_dur0';
if Classval0=1  then Sortvar=2;
if Classval0=2  then Sortvar=3;
if Classval0=3  then Sortvar=4;
if Classval0=4  then Sortvar=5;
if Classval0=5  then Sortvar=6;
run;
data D_HY (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); set D_HRT_HY D_HRTdur_HY ;run;
data D_HY (keep=Parameter ClassVal0 Sortvar D_HR D_LL D_UL); set D_HY ;run;
data D_HY ; set D_HY; model='Hyster'; run;

data D_All ; set D_TOT D_NM D_HY; run;



proc sort data=A_All  out=A_All; by model sortvar ; run;
proc sort data=B_All  out=B_All; by model sortvar ; run;
proc sort data=C_All  out=C_All; by model sortvar ; run;
proc sort data=D_All  out=D_All; by model sortvar ; run;


DATA ModelBuilding ; 
  MERGE A_ALL B_ALL C_ALL D_ALL ; BY model sortvar;
RUN; 
*DATA ModelBuilding (drop=Sortvar); *RUN; 
ods html file='E:\NCI\HRT OC and BCC in USRT\Results\HRT\ModelBuilding.xls' style=minimal;
proc print data= ModelBuilding ; run;
quit;
ods html close;ods _all_ close;ods html;


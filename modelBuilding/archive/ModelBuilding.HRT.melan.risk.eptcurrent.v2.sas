/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
#
# Model building v1
# !!!! for baseline dataset !!!!
#
# uses the conv.melan_r datasets
#
# Created: April 22 2015
# Updated: v20150526 WTL
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************/

libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
libname results 'C:\REB\AARP_HRTandMelanoma\Results\baseline';


********************************************************************************;
** Analysis of 3 Potential Confounders ******************************************;
********************************************************************************;

ods _all_ close;
ods html;

data use;
	set conv.melan_r;
run;

********************************************************************************;
** riskfactor, melanoma in situ, exp: eptcurrent, uvrq, educ_c, bmi_c + 1 conf **;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, in situ';
	title2 'Exposure: current/former EPT User';
	title3 'Among those with Natural Menopause Reason';
	title4 'uvrq + educ_c + bmi_c + 1 confounder';
	title5 '20150526TUE';
	class lacey_eptcurrent_me (ref='No HT') 
			uvrq (ref='0 to 186.918') educ_c (ref='highschool or less')
			bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me 
			uvrq educ_c bmi_c
			/ entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='lacey_eptcurrent_me';
	variable="MainE_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

/** education;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			educ_c (ref='highschool or less') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me educ_c
			uvrq
			/ entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='lacey_eptcurrent_me';
	variable="educ_c";
run;
**/
/** bmi;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT')
			bmi_c (ref='18.5 to 25') uvrq (ref='0 to 186.918')
			educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me bmi_c
			uvrq educ_c 
			/ entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_eptcurrent_me';
	variable="bmi_c";
run;
**/
** physcial activity;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT')
		physic_c (ref='rarely') uvrq (ref='0 to 186.918')
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me physic_c
			uvrq educ_c bmi_c 
			/ entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT')
		parity (ref='nulliparous') uvrq (ref='0 to 186.918')
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me parity
			uvrq educ_c bmi_c
			/ entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptcurrent_me';
	variable="parity";
run;

** age at menarche;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT')
		fmenstr (ref='<=10') uvrq (ref='0 to 186.918')
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me fmenstr 
			uvrq educ_c bmi_c
			/ entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_eptcurrent_me';
	variable="fmenstr";
run;

** first live birth age;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT')
		flb_age_c (ref='< 20 years old') uvrq (ref='0 to 186.918')
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me flb_age_c
			uvrq educ_c bmi_c
			/ entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** oral bc duration;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT')
		oralbc_dur_c (ref='none') uvrq (ref='0 to 186.918')
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me oralbc_dur_c 
			uvrq educ_c bmi_c 
			/ entry = rf_entry_age RL;
	where nat_meno_reason=1; 
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='lacey_eptcurrent_me';
	variable="oralbc_dur_c";
run;

** smoke_former;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT')
		smoke_former (ref='never smoked') uvrq (ref='0 to 186.918')
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me smoke_former 
			uvrq educ_c bmi_c
			/ entry = rf_entry_age RL;
	where nat_meno_reason=1; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptcurrent_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') 
		coffee_c (ref='none') uvrq (ref='0 to 186.918')
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me coffee_c 
			uvrq educ_c bmi_c 
			/ entry = rf_entry_age RL;
	where nat_meno_reason=1; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			etoh_c (ref='none') uvrq (ref='0 to 186.918')
			educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me etoh_c
			uvrq educ_c bmi_c 
			/ entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

/** uvrq;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT')
		uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me uvrq
			/ entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='lacey_eptcurrent_me';
	variable="uvrq";
run;
**/

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT')
		rel_1d_cancer (ref='No') uvrq (ref='0 to 186.918')
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me rel_1d_cancer
			uvrq educ_c bmi_c 
			/ entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') 
			marriage (ref='married') uvrq (ref='0 to 186.918')
			educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me  marriage
			uvrq educ_c bmi_c
			/ entry = rf_entry_age RL;
	where nat_meno_reason=1; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_eptcurrent_me';
	variable="marriage";
run;

** colonoscopy or sigmoidoscopy;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') colo_sig_any (ref='0')
			uvrq (ref='0 to 186.918') educ_c (ref='highschool or less')
			bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me  colo_sig_any 
			uvrq educ_c bmi_c
			/ entry = rf_entry_age RL;
	where nat_meno_reason=1; 
	ods output ParameterEstimates=colo_sig_any;
run;
data colo_sig_any; set colo_sig_any;
	if Parameter='lacey_eptcurrent_me';
	variable="colo_sig_any";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_eptcurrent_ins_4conf; 
	set 
		crude 
		physic_c 
		parity flb_age_c fmenstr
		oralbc_dur_c smoke_former coffee_c 
		etoh_c  rel_1d_cancer marriage
		colo_sig_any; 
		*uvrq education bmi_c;
run;
data risk_eptcurrent_ins_4conf; 
	set risk_eptcurrent_ins_4conf
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\mht\risk_eptcurrent_ins_4conf.xls' style=minimal;
proc print data= risk_eptcurrent_ins_4conf; run;
ods _all_ close;ods html;

*****************************************************************************************;
******   Model Building Table  **********************************************************;
*****************************************************************************************;

* riskfactor, melanoma in situ, exposure: lacey_eptcurrent_me;
*A = unadjusted, except for age*;
title;
proc phreg data = use;
	class  lacey_eptcurrent_me (ref='No HT');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me / entry = rf_entry_age RL; 
	ods output ParameterEstimates=A_lacey_eptcurrent_me;
run;
data A_lacey_eptcurrent_me; 
	set A_lacey_eptcurrent_me ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT');
	model exit_age*melanoma_ins(0)=lacey_eptcurdur_me / entry = rf_entry_age RL; 
	ods output ParameterEstimates=A_lacey_eptcurdur_me;
run;
data A_lacey_eptcurdur_me; 
	set A_lacey_eptcurdur_me ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data A_TOT_ins (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_lacey_eptcurrent_me A_lacey_eptcurdur_me ;
run;
data A_TOT_ins (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); 
	set A_TOT_ins; 
run;
data A_TOT_ins ; 
	set A_TOT_ins; 
	model='Total'; 
run;

** natural menopause reason;

proc phreg data = use;
	class  lacey_eptcurrent_me (ref='No HT');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me / entry = rf_entry_age RL; 
	ods output ParameterEstimates=A_lacey_eptcurrent_me;
	where nat_meno_reason=1;
run;
data A_lacey_eptcurrent_nm; 
	set A_lacey_eptcurrent_me ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT');
	model exit_age*melanoma_ins(0)=lacey_eptcurdur_me / entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=A_lacey_eptcurdur_me;
run;
data A_lacey_eptcurdur_nm; 
	set A_lacey_eptcurdur_me ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data A_NM_ins (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_lacey_eptcurrent_nm A_lacey_eptcurdur_nm ;
run;
data A_NM_ins (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); 
	set A_NM_ins ;
run;
data A_NM_ins ; 
	set A_NM_ins; 
	model='Natur'; 
run;

** surgical menopause reason;

proc phreg data = use;
	class  lacey_eptcurrent_me (ref='No HT') ;
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me / entry = rf_entry_age RL; 
	where surg_meno_reason=1;
	ods output ParameterEstimates=A_lacey_eptcurrent_me;
run;
data A_lacey_eptcurrent_sm; 
	set A_lacey_eptcurrent_me ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class lacey_eptcurdur_me (ref='No HT');
	model exit_age*melanoma_ins(0)=lacey_eptcurdur_me / entry = rf_entry_age RL; 
	where surg_meno_reason=1;
	ods output ParameterEstimates=A_lacey_eptcurdur_me;
run;
data A_lacey_eptcurdur_sm; 
	set A_lacey_eptcurdur_me ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data A_SM_ins (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_lacey_eptcurrent_sm A_lacey_eptcurdur_sm ;
run;
data A_SM_ins (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL); 
	set A_SM_ins ;
run;
data A_SM_ins ; 
	set A_SM_ins; 
	model='Surgi'; 
run;
** merge hormever total, natural, and surgical menopause;
data A_All_ins ; 
	set A_TOT_ins A_NM_ins A_SM_ins; 
run;

*B = adjusted for UVR*;

proc phreg data = use;
	class lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me uvrq/ entry = rf_entry_age RL; 
	ods output ParameterEstimates=B_lacey_eptcurrent_me;
run;
data B_lacey_eptcurrent_me; 
	set B_lacey_eptcurrent_me ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=lacey_eptcurdur_me uvrq/ entry = rf_entry_age RL; 
	ods output ParameterEstimates=B_lacey_eptcurdur_me;
run;
data B_lacey_eptcurdur_me; 
	set B_lacey_eptcurdur_me ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data B_TOT_ins (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_lacey_eptcurrent_me B_lacey_eptcurdur_me ;
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
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me uvrq / entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=B_lacey_eptcurrent_nm;
run;
data B_lacey_eptcurrent_nm; 
	set B_lacey_eptcurrent_nm ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=lacey_eptcurdur_me  uvrq / entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=B_lacey_eptcurdur_nm;
run;
data B_lacey_eptcurdur_nm; 
	set B_lacey_eptcurdur_nm ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data B_NM_ins (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_lacey_eptcurrent_nm B_lacey_eptcurdur_nm ;
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
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me uvrq / entry = rf_entry_age RL; 
	where surg_meno_reason=1;
	ods output ParameterEstimates=B_lacey_eptcurrent_sm; 
run;
data B_lacey_eptcurrent_sm; 
	set B_lacey_eptcurrent_sm ; 
	where Parameter='lacey_eptcurrent_me'; 
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run; 
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)=lacey_eptcurdur_me uvrq / entry = rf_entry_age RL; 
	where surg_meno_reason=1;
	ods output ParameterEstimates=B_lacey_eptcurdur_sm;
run;
data B_lacey_eptcurdur_sm; 
	set B_lacey_eptcurdur_sm ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data B_SM_ins (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_lacey_eptcurrent_sm B_lacey_eptcurdur_sm ;
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
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me uvrq educ_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=C_lacey_eptcurrent_me;
run;
data C_lacey_eptcurrent_me; 
	set C_lacey_eptcurrent_me ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=lacey_eptcurdur_me uvrq educ_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=C_lacey_eptcurdur_me;
run;
data C_lacey_eptcurdur_me; 
	set C_lacey_eptcurdur_me ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data C_TOT_ins (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_lacey_eptcurrent_me C_lacey_eptcurdur_me ;
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
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me uvrq educ_c / entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=C_lacey_eptcurrent_nm;
run;
data C_lacey_eptcurrent_nm; 
	set C_lacey_eptcurrent_nm ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3; 
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=lacey_eptcurdur_me  uvrq educ_c / entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=C_lacey_eptcurdur_nm;
run;
data C_lacey_eptcurdur_nm; 
	set C_lacey_eptcurdur_nm ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data C_NM_ins (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_lacey_eptcurrent_nm C_lacey_eptcurdur_nm ;
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
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me uvrq educ_c / entry = rf_entry_age RL; 
	where surg_meno_reason=1;
	ods output ParameterEstimates=C_lacey_eptcurrent_sm;
run;
data C_lacey_eptcurrent_sm; 
	set C_lacey_eptcurrent_sm ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)=lacey_eptcurdur_me uvrq educ_c / entry = rf_entry_age RL; 
	where surg_meno_reason=1;
	ods output ParameterEstimates=C_lacey_eptcurdur_sm;
run;
data C_lacey_eptcurdur_sm; 
	set C_lacey_eptcurdur_sm ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data C_SM_ins (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_lacey_eptcurrent_sm C_lacey_eptcurdur_sm ;
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
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me uvrq educ_c bmi_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=D_lacey_eptcurrent_me;
run;
data D_lacey_eptcurrent_me; 
	set D_lacey_eptcurrent_me ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurdur_me uvrq educ_c bmi_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=D_lacey_eptcurdur_me;
run;
data D_lacey_eptcurdur_me; 
	set D_lacey_eptcurdur_me ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data D_TOT_ins (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_lacey_eptcurrent_me D_lacey_eptcurdur_me ;
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
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me uvrq educ_c bmi_c / entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=D_lacey_eptcurrent_nm;
run;
data D_lacey_eptcurrent_nm; 
	set D_lacey_eptcurrent_nm ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurdur_me  uvrq educ_c bmi_c / entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=D_lacey_eptcurdur_nm;
run;
data D_lacey_eptcurdur_nm; 
	set D_lacey_eptcurdur_nm ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data D_NM_ins (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_lacey_eptcurrent_nm D_lacey_eptcurdur_nm ;
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
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurrent_me uvrq educ_c bmi_c / entry = rf_entry_age RL; 
	where surg_meno_reason=1;
	ods output ParameterEstimates=D_lacey_eptcurrent_sm;
run;
data D_lacey_eptcurrent_sm; 
	set D_lacey_eptcurrent_sm ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)=lacey_eptcurdur_me uvrq educ_c bmi_c / entry = rf_entry_age RL; 
	where surg_meno_reason=1;
	ods output ParameterEstimates=D_lacey_eptcurdur_sm;
run;
data D_lacey_eptcurdur_sm; 
	set D_lacey_eptcurdur_sm ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data D_SM_ins (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_lacey_eptcurrent_sm D_lacey_eptcurdur_sm ;
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

** sort and merge all 4 models together;

proc sort data=A_All_ins  out=A_All_ins; by model sortvar ; run;
proc sort data=B_All_ins  out=B_All_ins; by model sortvar ; run;
proc sort data=C_All_ins  out=C_All_ins; by model sortvar ; run;
proc sort data=D_All_ins  out=D_All_ins; by model sortvar ; run;
proc print data=B_All_ins;
run;

data ModelBuilding_risk_ins_laceyEPT ; 
	title1 underlin=1 'AARP Riskfactor: melanoma, in situ';
	title2 'Exposures: EPTcurrent, EPTcurrentduration';
	title3 'uvrq, educ_c, bmi_c as confounders';
	title4 'Modelbuilding Table';
	title5 '20150528THU';
	MERGE A_ALL_ins B_ALL_ins C_ALL_ins D_ALL_ins; 
	BY model sortvar;
run; 
*DATA ModelBuilding (drop=Sortvar); *RUN; 
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\mht\ModelBuilding_risk_ins_laceyEPT2.xls' style=minimal;
proc print data= ModelBuilding_risk_ins_laceyEPT ; run;
ods _all_ close;ods html;

*****************************************************************************************;
******   Model Building Table  **********************************************************;
*****************************************************************************************;

* riskfactor, melanoma malignant, exposure: lacey_eptcurrent_me lacey_eptcurdur_me;
*A = unadjusted, except for age*;
title;
proc phreg data = use;
	class  lacey_eptcurrent_me (ref='No HT');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me / entry = rf_entry_age RL; 
	ods output ParameterEstimates=A_lacey_eptcurrent_me;
run;
data A_lacey_eptcurrent_me; 
	set A_lacey_eptcurrent_me ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT');
	model exit_age*melanoma_mal(0)=lacey_eptcurdur_me / entry = rf_entry_age RL; 
	ods output ParameterEstimates=A_lacey_eptcurdur_me;
run;
data A_lacey_eptcurdur_me; 
	set A_lacey_eptcurdur_me ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data A_TOT_mal (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_lacey_eptcurrent_me A_lacey_eptcurdur_me ;
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
	class  lacey_eptcurrent_me (ref='No HT');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me / entry = rf_entry_age RL; 
	ods output ParameterEstimates=A_lacey_eptcurrent_me;
	where nat_meno_reason=1;
run;
data A_lacey_eptcurrent_nm; 
	set A_lacey_eptcurrent_me ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3; 
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT');
	model exit_age*melanoma_mal(0)=lacey_eptcurdur_me / entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=A_lacey_eptcurdur_me;
run;
data A_lacey_eptcurdur_nm; 
	set A_lacey_eptcurdur_me ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data A_NM_mal (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_lacey_eptcurrent_nm A_lacey_eptcurdur_nm ;
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
	class  lacey_eptcurrent_me (ref='No HT') ;
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me / entry = rf_entry_age RL; 
	where surg_meno_reason=1;
	ods output ParameterEstimates=A_lacey_eptcurrent_me;
run;
data A_lacey_eptcurrent_sm; 
	set A_lacey_eptcurrent_me ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class lacey_eptcurdur_me (ref='No HT');
	model exit_age*melanoma_mal(0)=lacey_eptcurdur_me / entry = rf_entry_age RL; 
	where surg_meno_reason=1;
	ods output ParameterEstimates=A_lacey_eptcurdur_me;
run;
data A_lacey_eptcurdur_sm; 
	set A_lacey_eptcurdur_me ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data A_SM_mal (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_lacey_eptcurrent_sm A_lacey_eptcurdur_sm ;
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
	class lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me uvrq/ entry = rf_entry_age RL; 
	ods output ParameterEstimates=B_lacey_eptcurrent_me;
run;
data B_lacey_eptcurrent_me; 
	set B_lacey_eptcurrent_me ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=lacey_eptcurdur_me uvrq/ entry = rf_entry_age RL; 
	ods output ParameterEstimates=B_lacey_eptcurdur_me;
run;
data B_lacey_eptcurdur_me; 
	set B_lacey_eptcurdur_me ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data B_TOT_mal (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_lacey_eptcurrent_me B_lacey_eptcurdur_me ;
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
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me uvrq / entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=B_lacey_eptcurrent_nm;
run;
data B_lacey_eptcurrent_nm; 
	set B_lacey_eptcurrent_nm ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=lacey_eptcurdur_me  uvrq / entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=B_lacey_eptcurdur_nm;
run;
data B_lacey_eptcurdur_nm; 
	set B_lacey_eptcurdur_nm ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data B_NM_mal (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_lacey_eptcurrent_nm B_lacey_eptcurdur_nm ;
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
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me uvrq / entry = rf_entry_age RL; 
	where surg_meno_reason=1;
	ods output ParameterEstimates=B_lacey_eptcurrent_sm; 
run;
data B_lacey_eptcurrent_sm; 
	set B_lacey_eptcurrent_sm ; 
	where Parameter='lacey_eptcurrent_me'; 
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run; 
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=lacey_eptcurdur_me uvrq / entry = rf_entry_age RL; 
	where surg_meno_reason=1;
	ods output ParameterEstimates=B_lacey_eptcurdur_sm;
run;
data B_lacey_eptcurdur_sm; 
	set B_lacey_eptcurdur_sm ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data B_SM_mal (rename=(HazardRatio=B_HR HRLowerCL=B_LL HRUpperCL=B_UL )); 
	set B_lacey_eptcurrent_sm B_lacey_eptcurdur_sm ;
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

** C = adjusted for age, UVR, educ_c;

proc phreg data = use;
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me uvrq educ_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=C_lacey_eptcurrent_me;
run;
data C_lacey_eptcurrent_me; 
	set C_lacey_eptcurrent_me ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=lacey_eptcurdur_me uvrq educ_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=C_lacey_eptcurdur_me;
run;
data C_lacey_eptcurdur_me; 
	set C_lacey_eptcurdur_me ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data C_TOT_mal (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_lacey_eptcurrent_me C_lacey_eptcurdur_me ;
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
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me uvrq educ_c / entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=C_lacey_eptcurrent_nm;
run;
data C_lacey_eptcurrent_nm; 
	set C_lacey_eptcurrent_nm ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=lacey_eptcurdur_me  uvrq educ_c / entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=C_lacey_eptcurdur_nm;
run;
data C_lacey_eptcurdur_nm; 
	set C_lacey_eptcurdur_nm ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data C_NM_mal (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_lacey_eptcurrent_nm C_lacey_eptcurdur_nm ;
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
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me uvrq educ_c / entry = rf_entry_age RL; 
	where surg_meno_reason=1;
	ods output ParameterEstimates=C_lacey_eptcurrent_sm;
run;
data C_lacey_eptcurrent_sm; 
	set C_lacey_eptcurrent_sm ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=lacey_eptcurdur_me uvrq educ_c / entry = rf_entry_age RL; 
	where surg_meno_reason=1;
	ods output ParameterEstimates=C_lacey_eptcurdur_sm;
run;
data C_lacey_eptcurdur_sm; 
	set C_lacey_eptcurdur_sm ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data C_SM_mal (rename=(HazardRatio=C_HR HRLowerCL=C_LL HRUpperCL=C_UL )); 
	set C_lacey_eptcurrent_sm C_lacey_eptcurdur_sm ;
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

*D = adjusted for age, UVR quartile, educ_c, bmi_c;

proc phreg data = use;
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me uvrq educ_c bmi_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=D_lacey_eptcurrent_me;
run;
data D_lacey_eptcurrent_me; 
	set D_lacey_eptcurrent_me ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_mal(0)=lacey_eptcurdur_me uvrq educ_c bmi_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=D_lacey_eptcurdur_me;
run;
data D_lacey_eptcurdur_me; 
	set D_lacey_eptcurdur_me ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data D_TOT_mal (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_lacey_eptcurrent_me D_lacey_eptcurdur_me ;
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
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me uvrq educ_c bmi_c / entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=D_lacey_eptcurrent_nm;
run;
data D_lacey_eptcurrent_nm; 
	set D_lacey_eptcurrent_nm ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_mal(0)=lacey_eptcurdur_me  uvrq educ_c bmi_c / entry = rf_entry_age RL; 
	where nat_meno_reason=1;
	ods output ParameterEstimates=D_lacey_eptcurdur_nm;
run;
data D_lacey_eptcurdur_nm; 
	set D_lacey_eptcurdur_nm ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data D_NM_mal (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_lacey_eptcurrent_nm D_lacey_eptcurdur_nm ;
run;
data D_NM_mal (keep=Parameter ClassVal0 Sortvar D_HR D_LL D_UL); 
	set D_NM_mal ;
run;
data D_NM_mal ; 
	set D_NM_mal; 
	model='Natur'; 
run;

** ins_ Surgical menopause;

proc phreg data = use;
	class  lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me uvrq educ_c bmi_c / entry = rf_entry_age RL; 
	where surg_meno_reason=1;
	ods output ParameterEstimates=D_lacey_eptcurrent_sm;
run;
data D_lacey_eptcurrent_sm; 
	set D_lacey_eptcurrent_sm ; 
	where Parameter='lacey_eptcurrent_me';
	if Classval0='Former'				then Sortvar=1; 
	if Classval0='Current'				then Sortvar=2;
	if Classval0='Other/Unknown HT'		then Sortvar=3;
run;
proc phreg data = use;
	class  lacey_eptcurdur_me (ref='No HT') uvrq (ref='0 to 186.918') 
		educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_mal(0)=lacey_eptcurdur_me uvrq educ_c bmi_c / entry = rf_entry_age RL; 
	where surg_meno_reason=1;
	ods output ParameterEstimates=D_lacey_eptcurdur_sm;
run;
data D_lacey_eptcurdur_sm; 
	set D_lacey_eptcurdur_sm ; 
	where Parameter='lacey_eptcurdur_me';
	if Classval0='<5 Former'  			then Sortvar=4;
	if Classval0='5+ Former'			then Sortvar=5;
	if Classval0='Unknown Former'		then Sortvar=6;

	if Classval0='<5 Current'  			then Sortvar=7;
	if Classval0='5+ Current'			then Sortvar=8;	
	if Classval0='Unknown Current'		then Sortvar=9;

	if Classval0='<5 Unknown'			then Sortvar=10;	
	if Classval0='5+ Unknown'			then Sortvar=11;
run;
data D_SM_mal (rename=(HazardRatio=D_HR HRLowerCL=D_LL HRUpperCL=D_UL )); 
	set D_lacey_eptcurrent_sm D_lacey_eptcurdur_sm ;
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

** sort and merge all 4 models together;

proc sort data=A_All_mal  out=A_All_mal; by model sortvar ; run;
proc sort data=B_All_mal  out=B_All_mal; by model sortvar ; run;
proc sort data=C_All_mal  out=C_All_mal; by model sortvar ; run;
proc sort data=D_All_mal  out=D_All_mal; by model sortvar ; run;
proc print data=B_All_mal;
run;

data ModelBuilding_risk_mal_laceyEPT ; 
	title1 underlin=1 'AARP Riskfactor: melanoma, malignant';
	title2 'Exposures: EPTcurrent, EPTcurrentduration';
	title3 'uvrq, educ_c, bmi_c as confounders';
	title4 'Modelbuilding Table';
	title5 '20150528THU';
	MERGE A_ALL_mal B_ALL_mal C_ALL_mal D_ALL_mal; 
	BY model sortvar;
run; 
*DATA ModelBuilding (drop=Sortvar); *RUN; 
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\mht\ModelBuilding_risk_mal_laceyEPT2.xls' style=minimal;
proc print data= ModelBuilding_risk_mal_laceyEPT ; run;
ods _all_ close;ods html;


********************************************************************************;
*** risk, malignant, lacey_eptcurrent_me **;
********************************************************************************;
** crude **;
proc phreg data = use multipass;
	title1 underlin=1 'AARP Riskfactor: melanoma, malignant';
	title2 'Exposures: EPTcurrent, EPTcurrentduration';
	title3 '1 confounder';
	title5 '20150526TUE';
	class lacey_eptcurrent_me (ref='No HT') ;
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me  / entry = rf_entry_age RL; 
	ods output ParameterEstimates=crude;
run;
data crude; set crude;
	if Parameter='lacey_eptcurrent_me';
	variable="Null_Model_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me educ_c/ entry = rf_entry_age RL; 
	ods output ParameterEstimates=education;
run;
data education; set education;
	if Parameter='lacey_eptcurrent_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me bmi_c/ entry = rf_entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_eptcurrent_me';
	variable="bmi_c";
run;

** physcial activity;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me physic_c/ entry = rf_entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me parity/ entry = rf_entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptcurrent_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me flb_age_c/ entry = rf_entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** age at menarche;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me fmenstr/ entry = rf_entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_eptcurrent_me';
	variable="fmenstr";
run;

** oral bc duration;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') oralbc_dur_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me oralbc_dur_c/ entry = rf_entry_age RL; 
	ods output ParameterEstimates=oralbc_dur_c;
run;
data oralbc_dur_c; set oralbc_dur_c;
	if Parameter='lacey_eptcurrent_me';
	variable="oralbc_dur_c";
run;

** UVR quartiles;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me uvrq/ entry = rf_entry_age RL; 
	ods output ParameterEstimates=uvrq;
run;
data uvrq; set uvrq;
	if Parameter='lacey_eptcurrent_me';
	variable="uvrq";
run;

** smoking status;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me smoke_former/ entry = rf_entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptcurrent_me';
	variable="smoke_former";
run;

** coffee drinking;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me coffee_c/ entry = rf_entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run;

** etoh drinking;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me etoh_c/ entry = rf_entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me rel_1d_cancer/ entry = rf_entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') marriage (ref='married');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me marriage/ entry = rf_entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_eptcurrent_me';
	variable="marriage";
run;

** colonoscopy or sigmoidoscopy;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') colo_sig_any (ref='0');
	model exit_age*melanoma_mal(0)=lacey_eptcurrent_me  colo_sig_any 
			/ entry = rf_entry_age RL;
	*where nat_meno_reason=1; 
	ods output ParameterEstimates=colo_sig_any;
run;
data colo_sig_any; set colo_sig_any;
	if Parameter='lacey_eptcurrent_me';
	variable="colo_sig_any";
run;

ods _all_ close;ods html;
*Combine and output to excel;
data risk_eptcurrent_mal_1conf; 
	set 
		crude birthcohort
		education bmi_c physic_c
		parity flb_age_c fmenstr
		oralbc_dur_c uvrq smoke_former coffee_c 
		etoh_c rel_1d_cancer marriage; 
run;
data risk_eptcurrent_mal_1conf; 
	set risk_eptcurrent_mal_1conf
		(Keep= variable HazardRatio HRLowerCL HRUpperCL); 
		Parameter=log(HazardRatio);
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\mht\risk_eptcurrent_mal_1conf.xls' style=minimal;
proc print data= risk_eptcurrent_mal_1conf; run;
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
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq / entry = rf_entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='lacey_eptcurrent_me';
	variable="Null_Model_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq educ_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='lacey_eptcurrent_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq bmi_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_eptcurrent_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq physic_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** meno_age_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=meno_age_c;
run;
data meno_age_c; set meno_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="meno_age_c";
run;

** parity;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq parity / entry = rf_entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptcurrent_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq flb_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq fmenstr / entry = rf_entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_eptcurrent_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq smoke_former / entry = rf_entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptcurrent_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq coffee_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq etoh_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq rel_1d_cancer / entry = rf_entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') marriage (ref='married');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq marriage / entry = rf_entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_eptcurrent_me';
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
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq / entry = rf_entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='lacey_eptcurrent_me';
	variable="Null_Model_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq educ_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='lacey_eptcurrent_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq bmi_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_eptcurrent_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq physic_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** meno_age_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=meno_age_c;
run;
data meno_age_c; set meno_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="meno_age_c";
run;

** parity;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq parity / entry = rf_entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptcurrent_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq flb_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq fmenstr / entry = rf_entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_eptcurrent_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq smoke_former / entry = rf_entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptcurrent_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq coffee_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq etoh_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq rel_1d_cancer / entry = rf_entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') marriage (ref='married');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq marriage / entry = rf_entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_eptcurrent_me';
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
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort meno_age_c uvrq / entry = rf_entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='lacey_eptcurrent_me';
	variable="Null_Model_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='lacey_eptcurrent_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_eptcurrent_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c physic_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c parity / entry = rf_entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptcurrent_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c flb_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c fmenstr / entry = rf_entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_eptcurrent_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c smoke_former / entry = rf_entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptcurrent_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c coffee_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c etoh_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c rel_1d_cancer / entry = rf_entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') marriage (ref='married');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c marriage / entry = rf_entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_eptcurrent_me';
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
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='lacey_eptcurrent_me';
	variable="Null_Model_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='lacey_eptcurrent_me';
	variable="educ_c";
run;

** bmi;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_eptcurrent_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c physic_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c parity / entry = rf_entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptcurrent_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c flb_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c fmenstr / entry = rf_entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_eptcurrent_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c smoke_former / entry = rf_entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptcurrent_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c coffee_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c etoh_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c rel_1d_cancer / entry = rf_entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') marriage (ref='married');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c marriage / entry = rf_entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_eptcurrent_me';
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
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort meno_age_c uvrq educ_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='lacey_eptcurrent_me';
	variable="Null_Model_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** bmi;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c bmi_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_eptcurrent_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c physic_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c parity / entry = rf_entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptcurrent_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c flb_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c fmenstr / entry = rf_entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_eptcurrent_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c smoke_former / entry = rf_entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptcurrent_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c coffee_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c etoh_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c rel_1d_cancer / entry = rf_entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage / entry = rf_entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_eptcurrent_me';
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
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq bmi_c meno_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='lacey_eptcurrent_me';
	variable="Null_Model_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c educ_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='lacey_eptcurrent_me';
	variable="educ_c";
run;

** physic_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c physic_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c parity / entry = rf_entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptcurrent_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c flb_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr / entry = rf_entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_eptcurrent_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c smoke_former / entry = rf_entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptcurrent_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c coffee_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c etoh_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c rel_1d_cancer / entry = rf_entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') marriage (ref='married');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c marriage / entry = rf_entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_eptcurrent_me';
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
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort meno_age_c uvrq educ_c marriage / entry = rf_entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='lacey_eptcurrent_me';
	variable="Null_Model_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** bmi;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=bmi_c;
run;
data bmi_c; set bmi_c;
	if Parameter='lacey_eptcurrent_me';
	variable="bmi_c";
run;

** physic_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage physic_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage parity / entry = rf_entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptcurrent_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage flb_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage fmenstr / entry = rf_entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_eptcurrent_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage smoke_former / entry = rf_entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptcurrent_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage coffee_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage etoh_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage rel_1d_cancer / entry = rf_entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
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
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq bmi_c meno_age_c fmenstr / entry = rf_entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='lacey_eptcurrent_me';
	variable="Null_Model_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr educ_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='lacey_eptcurrent_me';
	variable="educ_c";
run;

** physic_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr physic_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr parity / entry = rf_entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptcurrent_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr flb_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** smoking status;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former / entry = rf_entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptcurrent_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr coffee_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr etoh_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr rel_1d_cancer / entry = rf_entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') marriage (ref='married');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr marriage / entry = rf_entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_eptcurrent_me';
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
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to 25');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='lacey_eptcurrent_me';
	variable="Null_Model_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c physic_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') ;
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity  / entry = rf_entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptcurrent_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to 25') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c flb_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c fmenstr / entry = rf_entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_eptcurrent_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c smoke_former / entry = rf_entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptcurrent_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c coffee_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c etoh_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c rel_1d_cancer / entry = rf_entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
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
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10')
		smoke_former (ref='never smoked');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq bmi_c meno_age_c fmenstr smoke_former / entry = rf_entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='lacey_eptcurrent_me';
	variable="Null_Model_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** education;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=educ_c;
run;
data education; set educ_c;
	if Parameter='lacey_eptcurrent_me';
	variable="educ_c";
run;

** physic_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former physic_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former parity / entry = rf_entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptcurrent_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former flb_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** etoh_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked')  etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former etoh_c  / entry = rf_entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former coffee_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run; 

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former rel_1d_cancer / entry = rf_entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') marriage (ref='married');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former marriage / entry = rf_entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_eptcurrent_me';
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
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c parity / entry = rf_entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='lacey_eptcurrent_me';
	variable="Null_Model_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity physic_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** first live birth age;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity flb_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** fmenstr;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr / entry = rf_entry_age RL; 
	ods output ParameterEstimates=fmenstr;
run;
data fmenstr; set fmenstr;
	if Parameter='lacey_eptcurrent_me';
	variable="fmenstr";
run; 

** smoking status;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity smoke_former / entry = rf_entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptcurrent_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity coffee_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity etoh_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity rel_1d_cancer / entry = rf_entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
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
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10')
		smoke_former (ref='never smoked') educ_c (ref='highschool or less');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq bmi_c meno_age_c fmenstr smoke_former educ_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='lacey_eptcurrent_me';
	variable="Null_Model_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** physic_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c physic_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c parity / entry = rf_entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptcurrent_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c flb_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** etoh_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c etoh_c  / entry = rf_entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c coffee_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run; 

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c rel_1d_cancer / entry = rf_entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
	variable="rel_1d_cancer";
run;

** marriage;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') marriage (ref='married');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage / entry = rf_entry_age RL; 
	ods output ParameterEstimates=marriage;
run;
data marriage; set marriage;
	if Parameter='lacey_eptcurrent_me';
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
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') fmenstr (ref='<=10');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c parity fmenstr / entry = rf_entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='lacey_eptcurrent_me';
	variable="Null_Model_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') physic_c (ref='rarely');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr physic_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** first live birth age;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr flb_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** smoking status;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former / entry = rf_entry_age RL; 
	ods output ParameterEstimates=smoke_former;
run;
data smoke_former; set smoke_former;
	if Parameter='lacey_eptcurrent_me';
	variable="smoke_former";
run;

** coffee_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr coffee_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr etoh_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr rel_1d_cancer / entry = rf_entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
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
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10')
		smoke_former (ref='never smoked') educ_c (ref='highschool or less')
		marriage (ref='married');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq bmi_c meno_age_c fmenstr smoke_former educ_c marriage / entry = rf_entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='lacey_eptcurrent_me';
	variable="Null_Model_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;

** physic_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') physic_c (ref='rarely');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage physic_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** parity;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') parity (ref='nulliparous');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage parity / entry = rf_entry_age RL; 
	ods output ParameterEstimates=parity;
run;
data parity; set parity;
	if Parameter='lacey_eptcurrent_me';
	variable="parity";
run;

** first live birth age;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage flb_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** etoh_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') etoh_c (ref='none');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage etoh_c  / entry = rf_entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') coffee_c (ref='none');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage coffee_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run; 

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') bmi_c (ref='18.5 to 25') fmenstr (ref='<=10') 
		smoke_former (ref='never smoked') educ_c (ref='highschool or less') 
		marriage (ref='married') rel_1d_cancer (ref='No');
	model exit_age*melanoma_mal(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c bmi_c fmenstr smoke_former educ_c marriage rel_1d_cancer / entry = rf_entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
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
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') fmenstr (ref='<=10')
		smoke_former (ref='never smoked');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c parity fmenstr smoke_former / entry = rf_entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='lacey_eptcurrent_me';
	variable="Null_Model_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') physic_c (ref='rarely') ;
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former physic_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** first live birth age;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=flb_age_c;
run;
data flb_age_c; set flb_age_c;
	if Parameter='lacey_eptcurrent_me';
	variable="flb_age_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former coffee_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former etoh_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former rel_1d_cancer / entry = rf_entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
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
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married')
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') fmenstr (ref='<=10')
		smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort meno_age_c uvrq educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=null;
run;
data null; set null;
	if Parameter='lacey_eptcurrent_me';
	variable="Null_Model_lacey_eptcurrent_me";
run;

********************************************************************************;
*** Demographics ***;
********************************************************************************;


** physic_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old') physic_c (ref='rarely') ;
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c physic_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=physic_c;
run;
data physic_c; set physic_c;
	if Parameter='lacey_eptcurrent_me';
	variable="physic_c";
run;

** coffee_c;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old') coffee_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c coffee_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=coffee_c;
run;
data coffee_c; set coffee_c;
	if Parameter='lacey_eptcurrent_me';
	variable="coffee_c";
run; 

** alchohol;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old') etoh_c (ref='none');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c etoh_c / entry = rf_entry_age RL; 
	ods output ParameterEstimates=etoh_c;
run;
data etoh_c; set etoh_c;
	if Parameter='lacey_eptcurrent_me';
	variable="etoh_c";
run;

** family cancer history;
proc phreg data = use multipass;
	class lacey_eptcurrent_me (ref='No HT') birth_cohort (ref='1925-1928') uvrq (ref='0 to 186.918') 
		meno_age_c (ref='50-54') educ_c (ref='highschool or less') marriage (ref='married') 
		bmi_c (ref='18.5 to 25') parity (ref='nulliparous') 
		fmenstr (ref='<=10') smoke_former (ref='never smoked') flb_age_c (ref='< 20 years old') rel_1d_cancer (ref='No');
	model exit_age*melanoma_ins(0)= lacey_eptcurrent_me birth_cohort uvrq meno_age_c educ_c marriage bmi_c parity fmenstr smoke_former flb_age_c rel_1d_cancer / entry = rf_entry_age RL; 
	ods output ParameterEstimates=rel_1d_cancer;
run;
data rel_1d_cancer; set rel_1d_cancer;
	if Parameter='lacey_eptcurrent_me';
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

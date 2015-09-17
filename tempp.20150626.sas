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
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\base_surgage_ins_A.xls' style=minimal;
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
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\base_surgage_mal_A.xls' style=minimal;
proc print data= base_surgage_mal_A; run;
ods _all_ close;ods html;

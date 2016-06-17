*********************************************;
**** AARP HRT Baseline;
**** OJ Grapfruit juice tests;
**** updated 20160617FRI;
*********************************************;

ods html close; ods html;
proc freq data=use;
	table (QP2B1 f_orangjce QP2B2 g_orangjce)*melanoma_c;
run;

proc freq data=use;
	table QP2B1_me*melanoma_c;
run;

ods html close; ods html;
title 'for raw OJ freq, basic model';
proc phreg data = use multipass;
	class  QP2B1_me (ref='Never')
			educ_c (ref='1. Less than high school') 
			bmi_c (ref='>18.5 to < 25') 
			smoke_former_c (ref='Never smoked') 
			physic_c (ref='Never/rarely');
	model exit_age*melanoma_mal(0)=QP2B1_me uvrq_c educ_c bmi_c smoke_former_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=B_QP2B1 NObs = obs;
run;

title 'for raw OJ freq, full model';
proc phreg data = use multipass;
	class  QP2B1_me (ref='Never')
			educ_c (ref='1. Less than high school') 
			bmi_c (ref='>18.5 to < 25') 
			smoke_former_c (ref='Never smoked') 
			marriage_c (ref='1. Married') 
			colo_sig_any (ref='No') 
			mht_ever_c (ref='Never') physic_c (ref='Never/rarely');
	model exit_age*melanoma_mal(0)=QP2B1_me uvrq_c educ_c bmi_c smoke_former_c marriage_c colo_sig_any mht_ever_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=B_QP2B1 NObs = obs;
run;

title 'for derived OJ freq, basic model';
proc phreg data = use multipass;
	class  
			educ_c (ref='1. Less than high school') 
			bmi_c (ref='>18.5 to < 25') 
			smoke_former_c (ref='Never smoked') 
			physic_c (ref='Never/rarely');
	model exit_age*melanoma_mal(0)=f_orangjce uvrq_c educ_c bmi_c smoke_former_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=B_QP2B1 NObs = obs;
run;

title 'for derived OJ freq, highest UVR quartile';
proc phreg data = use multipass;
	class  
			educ_c (ref='1. Less than high school') 
			bmi_c (ref='>18.5 to < 25') 
			smoke_former_c (ref='Never smoked') 
			physic_c (ref='Never/rarely');
	model exit_age*melanoma_mal(0)=f_orangjce educ_c bmi_c smoke_former_c physic_c / entry = entry_age RL; 
	ods output ParameterEstimates=B_QP2B1 NObs = obs;
	where uvrq_c=4;
run;

************************************************************************;

title 'for derived OJ grams, just grams in model';
* null;
proc phreg data = use multipass;
	class  
			educ_c (ref='1. Less than high school') 
			bmi_c (ref='>18.5 to < 25') 
			smoke_former_c (ref='Never smoked') 
			physic_c (ref='Never/rarely');
	model exit_age*melanoma_mal(0)=g_orangjce uvrq_c /*educ_c bmi_c smoke_former_c physic_c*/ / entry = entry_age RL; 
	ods output ParameterEstimates=B_QP2B2 NObs = obs;
	*where uvrq_c=4;
run;

title 'for derived OJ grams, just grams in model, highest UVR quartile';
*null;
proc phreg data = use multipass;
	class  
			educ_c (ref='1. Less than high school') 
			bmi_c (ref='>18.5 to < 25') 
			smoke_former_c (ref='Never smoked') 
			physic_c (ref='Never/rarely');
	model exit_age*melanoma_mal(0)=g_orangjce /*educ_c bmi_c smoke_former_c physic_c*/ / entry = entry_age RL; 
	ods output ParameterEstimates=B_QP2B2 NObs = obs;
	where uvrq_c=4;
run;

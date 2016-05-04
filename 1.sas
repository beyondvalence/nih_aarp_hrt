ods graphics on;
proc lifetest data=use plots=(hazard, s, lls) noprint;
	strata fmenstr_me;
	time personyrs*melanoma_mal(0);
run;
proc phreg data = use multipass;
	class  fmenstr_me (ref='15+') uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='<45');
	model exit_age*melanoma_mal(0)=fmenstr_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c / entry = entry_age RL; 
	ods output ParameterEstimates=A_fmenstr NObs = obs;
run;

proc phreg data = use multipass;
	model personyrs*melanoma_mal(0) = exit_age fmenstr_me uvrq_c educ_c bmi_c fmenstr_met uvrq_ct educ_ct bmi_ct;
	fmenstr_met=fmenstr_me*log(personyrs);
	uvrq_ct=uvrq_c*log(personyrs);
	educ_ct=educ_c*log(personyrs);
	bmi_ct=bmi_c*log(personyrs);
	proportionality_test: test fmenstr_met, uvrq_ct, educ_ct, bmi_ct;
run;

proc surveyphreg data= use;
	class  uvrq_c (ref='176.095 to 186.918') educ_c (ref='Less than high school') bmi_c (ref='>18.5 to < 25') smoke_former_c (ref='Never smoked') rel_1d_cancer_c (ref='No') marriage_c (ref='Married') colo_sig_any (ref='No') mht_ever_c (ref='Never') menop_age_c (ref='<45');
	model exit_age*melanoma_mal(0)=fmenstr_me uvrq_c educ_c bmi_c smoke_former_c rel_1d_cancer_c marriage_c colo_sig_any mht_ever_c menop_age_c fmenstr_met; 
	strata fmenstr_me;
	fmenstr_met = exit_age*fmenstr_met;
run;

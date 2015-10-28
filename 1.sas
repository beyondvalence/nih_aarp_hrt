ods graphics on;
proc lifetest data=use plots=hazard;
	strata fmenstr_c;
	time exit_age*melanoma_mal(0);
run;

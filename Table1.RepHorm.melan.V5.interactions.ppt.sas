** for the fellows seminar powerpoint on 20150812WED;
** Created 20150810MON WTL;

** start UVRQ vs all main effects;
** uvrq_me * mht_ever;
proc phreg data = use multipass;
title 'uvr interaction, categorical';
	class uvrq_me (ref='0 to 186.918') mht_ever (ref='never')
			educ_c (ref='less than highschool') bmi_c (ref='< 25') 
			smoke_former (ref='never smoked') rel_1d_cancer (ref='No') marriage (ref='married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me mht_ever uvrq_me*mht_ever
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmhti;
run;
data uvrqmhti; set uvrqmhti;
	if Effect='uvrq_me*mht_ever';
	variable="uvrqmhti";
run;

** uvrq_me * fmenstr;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') fmenstr (ref='<=10')
			educ_c (ref='less than highschool') bmi_c (ref='< 25') 
			smoke_former (ref='never smoked') rel_1d_cancer (ref='No') marriage (ref='married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me fmenstr uvrq_me*fmenstr
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqfmenstri;
run;
data uvrqfmenstri; set uvrqfmenstri;
	if Effect='uvrq_me*fmenstr';
	variable="uvrqfmenstri";
run;

** uvrq_me * menostat_c;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') menostat_c (ref='natural menopause')
			educ_c (ref='less than highschool') bmi_c (ref='< 25') 
			smoke_former (ref='never smoked') rel_1d_cancer (ref='No') marriage (ref='married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me menostat_c uvrq_me*menostat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmenosti;
run;
data uvrqmenosti; set uvrqmenosti;
	if Effect='uvrq_me*menostat_c';
	variable="uvrqmenosti";
run;

** uvrq_me * ovarystat;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') ovarystat_c (ref='both removed')
			educ_c (ref='less than highschool') bmi_c (ref='< 25') 
			smoke_former (ref='never smoked') rel_1d_cancer (ref='No') marriage (ref='married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me ovarystat_c uvrq_me*ovarystat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqovaryi;
run;
data uvrqovaryi; set uvrqovaryi;
	if Effect='uvrq_me*ovarystat_c';
	variable="uvrqovaryi";
run;

** uvrq_me * menop_age;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') menop_age (ref='<45')
			educ_c (ref='less than highschool') bmi_c (ref='< 25') 
			smoke_former (ref='never smoked') rel_1d_cancer (ref='No') marriage (ref='married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me menop_age uvrq_me*menop_age
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmenopi;
run;
data uvrqmenopi; set uvrqmenopi;
	if Effect='uvrq_me*menop_age';
	variable="uvrqmenopi";
run;

** uvrq_me * parity;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') parity (ref='1-2 live children')
			educ_c (ref='less than highschool') bmi_c (ref='< 25') 
			smoke_former (ref='never smoked') rel_1d_cancer (ref='No') marriage (ref='married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me parity uvrq_me*parity
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqparityi;
run;
data uvrqparityi; set uvrqparityi;
	if Effect='uvrq_me*parity';
	variable="uvrqparityi";
run;

** uvrq_me * flb_age_c;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') flb_age_c (ref='< 20 years old')
			educ_c (ref='less than highschool') bmi_c (ref='< 25') 
			smoke_former (ref='never smoked') rel_1d_cancer (ref='No') marriage (ref='married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me flb_age_c uvrq_me*flb_age_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqflbai;
run;
data uvrqflbai; set uvrqflbai;
	if Effect='uvrq_me*flb_age_c';
	variable="uvrqflbai";
run;

** uvrq_me * oralbc_dur;
proc phreg data = use multipass;
	class uvrq_me (ref='0 to 186.918') oralbc_dur_c (ref='never/<1yr')
			educ_c (ref='less than highschool') bmi_c (ref='< 25') 
			smoke_former (ref='never smoked') rel_1d_cancer (ref='No') marriage (ref='married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me oralbc_dur_c uvrq_me*oralbc_dur_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqoralbci;
run;
data uvrqoralbci; set uvrqoralbci;
	if Effect='uvrq_me*oralbc_dur_c';
	variable="uvrqoralbci";
run;

******************;

ods _all_ close; ods html;
*Combine and output to excel;
data base_int_testing_mal_cat; 
	set 
		uvrqfmenstri
		uvrqparityi
		uvrqflbai
		uvrqmenosti
		uvrqovaryi
		uvrqmenopi
		uvrqoralbci
		uvrqmhti
	; 
run;
data base_int_testing_mal_cat; 
	set base_int_testing_mal_cat
	(Keep= variable ProbChiSq); 
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\interactions\ppt.base.mal.cat.xls' style=minimal;
proc print data= base_int_testing_mal_cat; run;
ods _all_ close; ods html;









*********************************************************************************;


** start UVRQ vs all main effects;
** uvrq_me * mht_ever;
proc phreg data = use multipass;
title 'uvr interaction, continuous';
title2 'continuous for both interaction terms';
	class 
			educ_c (ref='less than highschool') bmi_c (ref='< 25') 
			smoke_former (ref='never smoked') rel_1d_cancer (ref='No') marriage (ref='married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me mht_ever_me uvrq_me*mht_ever_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmhti;
run;
data uvrqmhti; set uvrqmhti;
	if Effect='uvrq_me*mht_ever_me';
	variable="uvrqmhti";
run;

** uvrq_me * fmenstr;
** tempchange, both needs to be continuous;
proc phreg data = use multipass;
	class 
			educ_c (ref='less than highschool') bmi_c (ref='< 25') 
			smoke_former (ref='never smoked') rel_1d_cancer (ref='No') marriage (ref='married') 
			colo_sig_any (ref='No') mht_ever(ref='never') menop_age(ref='<45');
	model exit_age*melanoma_mal(0)= 
			uvrq_me fmenstr_me uvrq_me*fmenstr_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any mht_ever menop_age
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqfmenstri;
run;
data uvrqfmenstri; set uvrqfmenstri;
	if Effect='uvrq_me*fmenstr_me';
	variable="uvrqfmenstri";
run;

** uvrq_me * menostat_c;
proc phreg data = use multipass;
	class 
			educ_c (ref='less than highschool') bmi_c (ref='< 25') 
			smoke_former (ref='never smoked') rel_1d_cancer (ref='No') marriage (ref='married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me menostat_c uvrq_me*menostat_c
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmenosti;
run;
data uvrqmenosti; set uvrqmenosti;
	if Effect='uvrq_me*menostat_c';
	variable="uvrqmenosti";
run;

** uvrq_me * ovarystat;
proc phreg data = use multipass;
	class 
			educ_c (ref='less than highschool') bmi_c (ref='< 25') 
			smoke_former (ref='never smoked') rel_1d_cancer (ref='No') marriage (ref='married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me ovarystat_c_me uvrq_me*ovarystat_c_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqovaryi;
run;
data uvrqovaryi; set uvrqovaryi;
	if Effect='uvrq_me*ovarystat_c_';
	variable="uvrqovaryi";
run;

** uvrq_me * menop_age;
proc phreg data = use multipass;
	class 
			educ_c (ref='less than highschool') bmi_c (ref='< 25') 
			smoke_former (ref='never smoked') rel_1d_cancer (ref='No') marriage (ref='married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me menop_age_me uvrq_me*menop_age_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqmenopi;
run;
data uvrqmenopi; set uvrqmenopi;
	if Effect='uvrq_me*menop_age_me';
	variable="uvrqmenopi";
run;

** uvrq_me * parity;
proc phreg data = use multipass;
	class 
			educ_c (ref='less than highschool') bmi_c (ref='< 25') 
			smoke_former (ref='never smoked') rel_1d_cancer (ref='No') marriage (ref='married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me parity_me uvrq_me*parity_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqparityi;
run;
data uvrqparityi; set uvrqparityi;
	if Effect='uvrq_me*parity_me';
	variable="uvrqparityi";
run;

** uvrq_me * flb_age_c;
proc phreg data = use multipass;
	class 
			educ_c (ref='less than highschool') bmi_c (ref='< 25') 
			smoke_former (ref='never smoked') rel_1d_cancer (ref='No') marriage (ref='married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me flb_age_c_me uvrq_me*flb_age_c_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqflbai;
run;
data uvrqflbai; set uvrqflbai;
	if Effect='uvrq_me*flb_age_c_me';
	variable="uvrqflbai";
run;

** uvrq_me * oralbc_dur;
proc phreg data = use multipass;
	class 
			educ_c (ref='less than highschool') bmi_c (ref='< 25') 
			smoke_former (ref='never smoked') rel_1d_cancer (ref='No') marriage (ref='married') 
			colo_sig_any (ref='No');
	model exit_age*melanoma_mal(0)= 
			uvrq_me oralbc_dur_c_me uvrq_me*oralbc_dur_c_me
			educ_c bmi_c smoke_former rel_1d_cancer marriage colo_sig_any
			/ entry = entry_age RL; 
	*where menostat_c=1;
	ods output Type3=uvrqoralbci;
run;
data uvrqoralbci; set uvrqoralbci;
	if Effect='uvrq_me*oralbc_dur_c';
	variable="uvrqoralbci";
run;

******************;

ods _all_ close; ods html;
*Combine and output to excel;
data base_int_testing_mal_cont; 
	set 
		uvrqfmenstri
		uvrqparityi
		uvrqflbai
		uvrqmenosti
		uvrqovaryi
		uvrqmenopi
		uvrqoralbci
		uvrqmhti
	; 
run;
data base_int_testing_mal_cont; 
	set base_int_testing_mal_cont
	(Keep= variable ProbChiSq); 
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\master\interactions\ppt.base.mal.cont.xls' style=minimal;
proc print data= base_int_testing_mal_cont; run;
ods _all_ close; ods html;

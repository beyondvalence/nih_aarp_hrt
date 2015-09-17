proc freq data=use;
	title 'parity and flb';
	table horm_ever_me
		/missing;
run;
ods close; ods html;
proc freq data=conv.melan;
	title;
	table parity_me*flb_age_c
		/missing;
run;

proc print data=crude;
	title;
run;

data test;
	set conv.melan;
	if flb_age_c=-9	& parity in (0,1,2,-9)		then parity=-9; 
	if parity=0									then flb_age_c=-9;
	if parity=-9								then flb_age_c=-9;
run;

** Analysis of Model A
** in situ and malignant melanoma
** Includes: ME

** Analysis of Model A
** in situ and malignant melanoma
** unadjusted except for age (time scale)
** Includes: ME

****** ME baseline: 				ME coded variable (ref= value)	
****01 flb_age_c					flb_age_c_me (ref='< 20 years old')
****0a horm_nat_ever_me				horm_nat_ever_me (ref='never')
****0b horm_surg_ever_me			horm_surg_ever_me (ref='never') 
****02 horm_ever					horm_ever_me (ref='never')
****03 parity						parity_me (ref='1-2 live children')
****04 fmenstr						fmenstr_me (ref='<=10')
****0c oralbc_yn_c					oralbc_yn_c_me (ref='never/<1yr')
****05 oralbc_dur_c					oralbc_dur_c_me (ref='never/<1yr')
****06 menostat_c 					menostat_c_me (ref='pre-menopausal')
****07 meno_age_c					meno_age_c_me (ref='50-54')
****08 surg_age_c					surg_age_c_me (ref='50-54')
****0d ovarystat_c					ovarystat_c_me (ref='both removed')

****** ME riskfactor:				ME coded variable (ref= value)
****0a lacey_eptcurrent_ever		lacey_eptcurrent_ever_me (ref='No HT')
****01 lacey_eptcurrent				lacey_eptcurrent_me (ref='No HT')
****02 lacey_eptdur					lacey_eptdur_me (ref='<5')
****03 lacey_eptdose				lacey_eptdose_me (ref='<1')

****0b lacey_etcurrent_ever			lacey_etcurrent_ever (ref='No HT')
****04 lacey_etcurrent				lacey_etcurrent_me (ref='No HT')
****05 lacey_etdur					lacey_etdur_me (ref='<10')
****06 lacey_etdose					lacey_etdose_me (ref='.625')

****07 flb_age_c					flb_age_c_me (ref='< 20 years old')
****08 parity						parity_me (ref='1-2 live children')
****09 fmenstr						fmenstr_me (ref='<=10')
****0c oralbc_yn_c					oralbc_yn_c_me (ref='never/<1yr')
****10 oralbc_dur_c					oralbc_dur_c_me (ref='never/<1yr')
****11 menostat_c					menostat_c_me (ref='pre-menopausal')
****12 meno_age_c					meno_age_c_me (ref='50-54')
****13 surg_age_c					surg_age_c_me (ref='50-54')

****0d ht_type_nat_ever				ht_type_nat_ever_me (ref='No HT')
****14 ht_type_nat					ht_type_nat_me (ref='No HT')
****0e ht_type_surg_ever			ht_type_surg_ever_me (ref='No HT')
****15 ht_type_surg					ht_type_surg_me (ref='No HT')
****16 lacey_etfreq					lacey_etfreq_me (ref='Daily')
****0f ovarystat_c					ovarystat_c_me (ref='both removed')

Finished to: R0f

 


uvrq (ref='0 to 186.918')
marriage (ref='married')
educ_c (ref='highschool or less')
bmi_c (ref='18.5 to < 25')
parity_me (ref='1-2 live children')
smoke_former (ref='never smoked')

** make data dictionary;
proc contents data=use;
run;


proc summary data=use print;
	title;
	var;
run;

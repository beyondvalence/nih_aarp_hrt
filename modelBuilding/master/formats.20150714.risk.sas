/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
#
# creates formats for the master model building file
# risk

#
# Created: June 29 2015
# Updated: v20150721TUE WTL
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************/

* for riskfactor dataset;
proc format;
	value sexfmt 0 = 'Male' 1 = 'Female';
	value melanfmt 0 = 'no melanoma' 1 = 'in situ melanoma' 2 = 'malignant melanoma';
	value melanomafmt 0 = 'no melanoma' 1 = 'melanoma';
	value melanomainsfmt 0 = 'no melanoma' 1='melanoma in situ';
	value melanomamalfmt 0 = 'no melanoma' 1='malignant melanoma';

	value agecatfmt 1 = '50-55 years' 2 = '55-59 years' 3 = '60-64 years' 4 = '65-69 years' 5 = '>=70 years';
	value birthcohortfmt 1='1925-1928' 2='1929-1932' 3='1933-1934' 4='1935-1938' 5='1939-1945';
	value attainedagefmt -9='missing' 0='>=50 to <55' 1='>=55 to <60' 2='<=60 to <65' 3='<=65 to <70' 4='70+';
	value racefmt -9='missing' 0='non-Hispanic white' 1='non-Hispanic black' 2='Hispanic, Asian, PI, AIAN';
	value educfmt -9='missing' 0='less than highschool' 1='Highschool graduate' 2='some college' 3='college or graduate school';
	value bmifmt -9='missing' 1='< 25' 2='25 to 30' 3='>=30';
	value bminewfmt -9='missing or extreme' 1='18.5 to <25' 2='25 to <30' 3='30 to <60';
	value physicfmt -9='missing' 0='rarely' 1='1-3 per month' 2='1-2 per week' 3='3-4 per week' 4='5+ per week';
	value smokingfmt -9='missing' 0='never smoked' 1='ever smoke';
	value marriagefmt 1='married' 2='widowed' 3='divorced/separated' 5='never married' 9='unknown';

	** menopause status recoded;
	value fmenstrfmt -9='missing' 0='<=10' 1='11-12' 2='13-14' 3='15+';
	value menostatfmt -9='missing' 9='pre-menopausal' 1='natural menopause' 2='surgical/hyst menopause'
						3='radiation or chemotherapy' 4='other reason';
	value menopagefmt 9='missing' 1='<45' 2='45-49' 3='50-54' 4='>=55' 5='still menstruating';
	value menopiagefmt 9='missing' 1='<45' 2='45-49' 3='50+' 5='still menstruating';
	value menoagefmt -9='missing' 1='<50' 2='50-54' 3='55+' 4='periods did not stop';
	value surgagefmt -9='missing' 1='<45' 2='45-49' 3='50+' 4='periods did not stop';
	value flbagefmt -9='missing' 1='< 20 years old' 2='20s' 3='30s' 9='nulliparous/missing parity';
	value parityfmt -9='missing' 0='nulliparous' 1='1-2 live children' 2='>=3 live children';
	value hormstatfmt -9='missing' 0='never' 1='former' 2='current';
	value hormeverfmt -9='missing' 0='never' 1='ever';
	value hormcurfmt 9='missing' 0='No' 1='Yes Currently';
	value hormyrsfmt -9='missing' 0='never used' 1='<5 years' 2='5-9 years' 3='>=10 years';
	value oralbcdurfmt -9='missing' 0='never/<1yr' 1='1-4 years' 2='5-9 years' 3='10+ years';
	value oralbcynfmt -9='missing' 0='never/<1yr' 1='ever';
	value uvrqfmt -9='missing' 1='0 to 186.918' 2='186.918 to 239.642' 3='239.642 to 253.731' 
					4='253.731 to 289.463';
	value relativefmt -9='missing' 0='No' 1='Yes';
	value ovarystatfmt -9='missing' 1='both removed' 2='both intact';
	value mhteverfmt -9='missing' 0='never' 1='ever';

/* :::risk factors::: */
	** smoking;
	value smokeformerfmt -9='missing' 0='never smoked' 1='former smoker' 2='current smoker';
	value smokequitfmt -9='missing' 0='never smoked' 1='stopped 10+ years ago' 2='stopped 5-9 years ago'
						3='stopped 1-4 years ago' 4='stopped within last year' 5='currently smoking';
	value smokedosefmt -9='missing' 0='never smoked' 1='1-10 cigs a day' 2='11-20 cigs a day' 3='21-30 cigs a day'
						4='31-40 cigs a day' 5='41-60 cigs a day' 6='61+ cigs a day';
	value smokequitdosefmt -9='missing' 0='never smoked' 1='quit, <=20 cigs/day' 2='quit, >20 cigs/day'
							3='currently smoking, <=20 cigs/day' 4='currently smoking, >20 cigs/day';
	value coffeefmt -9='missing' 0='none' 1='<=1 cup/day' 2='2-3 cups/day' 3='>=4 cups/day';
	value etohfmt -9='missing' 0='none' 1='<=1' 2='>1 and <=3' 3='>3';
	value rfphysicfmt -9='missing' 0='Never/rarely' 1='<1 hr/week' 2='1-3 hr/week' 3='4-7 hr/week' 4='>7 hr/week';
	value rfphysfmt 9='Unknown' 0='Never' 1='Rarely' 2='<1 hr/week' 3='1-3 hr/week' 4='4-7 hr/week' 5='>7 hr/week';
	value rfhormtype 9='missing' 0='never' 1='estrogen only' 2='progestin only' 3=' both estrogen and progestin' 4='unknown type' 8='NA'; 

	** Lacey - MHT encodings;
	value l_afterRfq 9='missing' 0='ET-only started before RFQ' 1 = 'ET-only started at/after RFQ' 8 = 'N/A' ;
	value l_eptcurdur 10='missing' 9='missing' 0='No HT' 1 = '<5 Former' 2 = '<5 Current' 3 = '5+ Former'
						4 = '5+ Current' 5 = 'Unknown Former' 6 = 'Unknown Current' 7 = '<5 Unknown'
						8 = '5+ Unknown';
	value l_eptcurdurr 10='missing' 9='missing' 0='No HT' 1 = '<10 Former' 2 = '<10 Current' 3 = '10+ Former'
						4 = '10+ Current' 5 = 'Unknown Former' 6 = 'Unknown Current' 7 = '<10 Unknown'
						8 = '10+ Unknown';
	value l_eptcurrent 4 = 'Other/Unknown HT' 3 = 'Unknown' 2 = 'Current' 1 = 'Former' 0 = 'No HT';
	value l_eptcurrentvr 4 = 'Other/Unknown HT' 3 = 'Unknown' 1 = 'Ever EPT' 0 = 'No HT';
	value l_eptdose -9='missing' 9 = 'Unknown HT' 8 = 'ET' 5 = 'Unknown dose' 4 = '10' 3 = '5' 2 = '2.5' 1 = '<1' 0 = 'No HT';
	value l_eptdur -9='missing' 99 = 'Unknown HT' 88 = 'ET' 9 = 'DK' 3 = '10+' 2 = '5-9' 1 = '<5' 0 = 'No HT';
	value l_eptregdose 99 = 'Unknown HT' 88 = 'ET only' 13 = '15-25 d/m or unknown EPT regimen' 12 = 'CEPT and unknown dose'
							11 = 'CEPT & other dose' 10 = 'CEPT & 10 mg' 9 = 'CEPT & 5 mg' 8 = 'CEPT & 2.5 mg'
							7 = 'CEPT & <1 mg' 6 = 'SEPT and unknown dose' 5 = 'SEPT & other dose' 4 = 'SEPT & 10 mg'
							3 = 'SEPT & 5 mg' 2 = 'SEPT & 2.5 mg' 1 = 'SEPT & <1 mg' 0 = 'No HT';
	value l_eptregyrs 99 = 'Unknown HT' 88 = 'ET only' 9 = 'Unknown EPT regimen' 8 = '15-25 days PT per month, known duration'
							7 = 'SEPT or CEPT with unknown yrs' 6 = 'CEPT & 5+ yrs' 5 = 'CEPT & 2-4 yrs' 4 = 'CEPT & <=1 yr'
							3 = 'SEPT & 5+ yrs' 2 = 'SEPT & 2-4 yrs' 1 = 'SEPT & <=1 yr' 0 = 'No HT';
	value l_epttype 9 = 'Unknown HT' 8 = 'ET' 5 = 'Uns' 4 = 'Other' 3 = 'Cycrin' 2 = 'Medro' 1 = 'Provera' 0 = 'No HT';
	value l_estvsprg 9 = 'N/A' 8 = 'Unknown' 2 = 'E<P' 1 = 'E>P' 0 = 'E=P';
	value l_eptreg 9 = 'Unknown HT' 0 = 'No HT' 1 = 'Sequential' 2 = '15-25 d/m' 3 = 'Continuous' 4 = 'Unknown regimen' 8 = 'ET';

	value l_et_ept_et 9 = 'N/A' 2 = 'Other' 1 = 'Yes' 0 = 'No';
	value l_etcurdur;
	value l_etcurrent;
	value l_etcurrentvr 4 = 'Other/Unknown HT' 3 = 'Uknown' 1 = 'Ever ET' 0 = 'No HT';
	value l_etdose -9='missing' 9 = 'Unk HT' 3 = 'Unknown' 2 = 'Other' 1 = '.625' 0 = 'No HT';
	value l_etdur -9='missing' 99 = 'Unknown HT' 88 = 'EPT or Other/Unknown HT type' 9 = 'DK' 2 = '10+' 1 = '<10' 0 = 'No HT';
	value l_etfreq -9='missing' 9 = 'Unknown HT' 3 = 'Unknown' 2 = 'Other' 1 = 'Daily' 0 = 'No HT';
	value l_ettype 9 = 'Unknown HT' 6 = 'Unsure' 5 = 'Other' 4 = 'Estratab' 3 = 'Estrace' 2 = 'Ogen' 1 = 'Premarin' 0 = 'No HT';
	value l_fldosereg 99 = 'No EPT' 9 = 'Unknown regimen' 8 = 'Other dose & regimen' 7 = 'Unknown dose' 6 = 'Unknown dose'
						5 = 'SEPT/CEPT w/other dose' 4 = 'SEPT/CEPT w/other dose' 3 = 'High' 2 = 'Low' 1 = 'Low' 0 = 'OK';
	value l_htformulation 99 = 'DK' 10 = 'Other/Unknown type' 9 = 'Unknown start date for ET and/or PT' 8 = 'EPT-ET'
							7 = 'EPT-PT' 6 = 'PT-ET' 5 = 'ET-PT' 4 = 'PT-EPT' 3 = 'EPT' 2 = 'ET-EPT' 1 = 'ET' 0 = 'No HT';
	value l_httype 9 = 'Unknown' 3 = 'Other/Unknown type' 2 = 'EPT' 1 = 'ET' 0 = 'No HT';
	value l_httypevr 9 = 'Unknown' 3 = 'Other/Unknown type' 1 = 'Ever HT' 0 = 'No HT';
	value l_sameduration 1 = 'Yes' 0 = 'No';
	value l_samestart 9 = 'NA' 8 = 'Unknown' 6 = 'EPT-ET' 5 = 'EPT-PT' 4 = 'PT-ET' 3 = 'ET-PT' 
						2 = 'PT-EPT' 1 = 'EPT-only' 0 = 'ET-EPT';
	value l_sameyear 1 = 'Yes' 0 = 'No' -9='Missing';
	value rf_est_cur 9='Unknown' 8='NA' 1='Yes' 0='No';
	value rfq15afmt 0='No' 1='Sigmoidoscopy';
	value rfq15bfmt 0='No' 1='Colonoscopy';
	value rfq15cfmt 0='No' 1='Proctoscopy';
	value rfq15dfmt 0='No' 1='Unknown type';
	value rfq15efmt 0='0' 1='No procedures';
  
run;

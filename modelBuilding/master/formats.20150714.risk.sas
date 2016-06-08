/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
#
# creates formats for the master model building file
# risk

#
# Created: June 29 2015
# Updated: v20160516MON WTL
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************/

* for riskfactor dataset;
proc format;
	value sexfmt 0 = 'Male' 1 = 'Female';
	value melanfmt 0 = 'No melanoma' 1 = 'In situ melanoma' 2 = 'Malignant melanoma';
	value melanomafmt 0 = 'No melanoma' 1 = 'Melanoma';
	value melanomainsfmt 0 = 'No melanoma' 1='Melanoma in situ';
	value melanomamalfmt 0 = 'No melanoma' 1='Malignant melanoma';

	value agecatfmt 1 = '50-55 years' 
						2 = '55-59 years' 
						3 = '60-64 years' 
						4 = '65-69 years' 
						5 = '>=70 years';
	value birthcohortfmt 1='1925-1928' 
						2='1929-1932' 
						3='1933-1934' 
						4='1935-1938' 
						5='1939-1945';
	value attainedagefmt -9='Missing' 
						0='>=50 to <55' 
						1='>=55 to <60' 
						2='>=60 to <65' 
						3='>=65 to <70' 
						4='70+';
	value educfmt -9='Missing' 
						0='1. Less than high school' 
						1='2. High school graduate' 
						2='3. Some college' 
						3='4. College or graduate school';
	value educmfmt -9='Missing' 
						1='Less than high school' 
						2='High school graduate' 
						3='Post high school' 
						4='Some college' 
						5='College or post graduate';
	value bmifmt -9='Missing' 
						1='>18.5 to < 25' 
						2='25 to < 30' 
						3='30 to < 60';
	value bminewfmt -9='Missing or extreme' 
						1='>18.5 to < 25' 
						2='25 to < 30' 
						3='30 to < 60';
	value physiccfmt -9='Missing' 
						0='Never/rarely' 
						1='1-3 per month' 
						2='1-2 per week' 
						3='3-4 per week' 
						4='5+ per week';
	value physicfmt -9='Missing' 
						0='Never' 
						1='Rarely' 
						2='1-3 per month' 
						3='1-2 per week' 
						4='3-4 per week' 
						5='5+ per week' 
						9='Unknown';
	value smokingfmt -9='Missing' 
						0='Never smoked' 
						1='Ever smoke';
	value marriagefmt 1='Married' 
						2='Widowed' 
						3='Divorced' 
						4='Separated' 
						5='Never married' 
						9='Unknown';
	value marriagecfmt 1='1. Married' 
						2='2. Widowed' 
						3='3. Divorced/separated' 
						5='4. Never married' 
						9='Missing';

	** fmenstr, menopause status recoded 20150721WTL;
	value fmenstrcfmt -9='Missing' 
						0='1. 10>=' 
						1='2. 11-12' 
						2='3. 13-14' 
						3='4. 15+';
	value fmenstrfmt -9='Missing' 
						1='10>=' 
						2='11-12' 
						3='13-14' 
						4='15+' 
						9='Unknown';
	value menostatfmt -9='Missing' 
						9='Pre-menopausal' 
						1='Natural menopause' 
						2='Surgical/hyst menopause'
						3='Radiation or chemotherapy' 
						4='Other reason';
	value agemenofmt 1='<40' 
						2='40-44' 
						3='45-49' 
						4='50-54' 
						5='>55' 
						6='Still menstruating' 
						9='Unknown';
	value menopagefmt -9='Missing' 
						1='<45' 
						2='45-49' 
						3='50-54' 
						4='>=55' 
						5='Still menstruating';
	value menopiagefmt -9='Missing' 
						1='1. <45' 
						2='2. 45-49' 
						3='3. 50+' 
						5='4. Still menstruating';
	value menoagefmt -9='Missing' 
						1='1. <50' 
						2='2. 50-54' 
						3='3. 55+' 
						4='Periods did not stop';
	value menopage4fmt 9='Missing' 
						1='1. <40' 
						2='2. 40-44' 
						3='3. 45-49' 
						4='4. 50+';
	value flbagefmt -9='Missing' 
						1='< 20 years old' 
						2='2. 20-29' 
						3='3. 30+' 
						4='Nulliparous/Missing parity';
	value ageflbfmt -9='Unknown' 
						0='Never gave birth' 
						1='<16' 
						2='16-19' 
						3='20-24' 
						4='25-29' 
						5='30-34' 
						6='35-39' 
						7='>=40';
	value parityfmt -9='Missing' 
						0='1. Nulliparous' 
						1='1-2 live children' 
						2='3. >=3 live children';
	value livechildfmt -9='Unknown' 
						0='Never had a child' 
						1='1' 
						2='2' 
						3='3-4' 
						4='5-9' 
						5='>=10';
	value hormstatfmt -9='Missing' 
						0='Never' 
						1='Current' 
						2='Former' 
						9='Unknown';
	value hormeverfmt -9='Missing' 
						0='Never' 
						1='Ever';
	value hormcurfmt -9='Missing' 
						0='No' 
						1='Yes currently';
	value hormyrsfmt -9='Missing' 
						0='Never used' 
						1='1. <5 years' 
						2='2. 5-9 years' 
						3='3. >=10 years' 
						9='Unknown';
	value oralbcdurfmt -9='Missing' 
						0='Never/<1yr' 
						1='2. 1-4 years' 
						2='3. 5-9 years' 
						3='4. 10+ years' 
						9='Unknown';
	value oralbcynfmt -9='Missing' 0='Never/<1yr' 1='Ever';
	value oralbcyrsfmt -9='Unknown' 
						0='Never/<1yr' 
						1='2. 1-4 years' 
						2='3. 5-9 years' 
						3='4. 10+ years';
	value uvrqfmt -9='Missing' 
						1='176.095 to 186.918' 
						2='186.918 to 239.642' 
						3='239.642 to 253.731' 
						4='253.731 to 289.463';
	value rphysicfmt -9='Missing' 
						1='Rarely' 
						2='<1 hour/week' 
						3='1-3 hours/week' 
						4='4-7 hours/week' 
						5='>7 hours/week';
	value relativefmt -9='Missing' 
						0='No' 
						1='Yes' 
						9='Missing';

	** menopause reason edit 20150723THU WTL;
	value menoreasonfmt 3='Rad/chem meno reason' 
						2='Surgical meno reason' 
						1='Natural meno reason'
						0='Periods did not stop';
	value natmenofmt -9='Missing' 
						0='Periods did not stop' 
						1='Natural meno reason';
	value surgmenofmt -9='Missing' 
						0='Periods did not stop' 
						1='Surgical meno reason';
	value radchemmenofmt -9='Missing' 
						0='Periods did not stop' 
						1='Radchem meno reason';
	value ovarystatfmt -9='Missing' 
						1='Both removed' 
						2='Both intact' 
						3='Other surgery to ovaries' 
						9='Unknown';
	value mhteverfmt -9='Missing' 
						0='Never' 
						1='Ever';
	value perstopmenopfmt 0='No' 
						1='Yes' 
						9='Unknown';
	value perstopsurgfmt 0='No' 			
						1='Yes' 
						9='Unknown';
	value hyststatfmt 0='No Hyst' 
						1='Hysterectomy' 
						9='Unknown';

	** smoking;
	value smokeformerfmt -9='Missing' 
						0='Never smoked' 
						1='Former smoker' 
						2='Current smoker' 
						9='Unknown';
	value smokequitfmt -9='Missing' 
						0='Never smoked' 
						1='Stopped 10+ years ago' 
						2='Stopped 5-9 years ago'
						3='Stopped 1-4 years ago' 
						4='Stopped within last year' 
						5='Currently smoking'
						9='Unknown';
	value smokedosefmt -9='Missing' 
						0='Never smoked' 
						1='1-10 cigs a day' 
						2='11-20 cigs a day' 
						3='21-30 cigs a day' 
						4='31-40 cigs a day' 
						5='41-60 cigs a day' 
						6='61+ cigs a day' 
						9='Unknown';
	value smokequitdosefmt -9='Missing' 
						0='Never smoked' 
						1='Quit, <=20 cigs/day' 
						2='Quit, >20 cigs/day'
						3='Currently smoking, <=20 cigs/day' 
						4='Currently smoking, >20 cigs/day'
						9='Unknown';
	value coffeefmt -9='Missing' 
						0='None' 
						1='<=1 cup/day' 
						2='2-3 cups/day' 
						3='>=4 cups/day';
	value $qp12bfmt 	'0'='None' 
						'1'='Less than 1 cup per month' 
						'2'='1-3 cups per month'
						'3'='1-2 cups per week'
						'4'='3-4 cups per week'
						'5'='5-6 cups per week'
						'6'='1 cup per day'
						'7'='2-3 cups per day'
						'8'='4-5 cups per day'
						'9'='6+ cups per day'
						'E'='Error'
						'M'='Missing';
	value etohfmt -9='Missing' 
						0='None' 
						1='<=1' 
						2='>1 and <=3' 
						3='>3';
	value colosigfmt 1 = 'Yes' 
						0 = 'No' 
						9='Missing';
	value l_sameyear 1 = 'Yes' 
						0 = 'No' 
						9='Missing';

	value rfphysicfmt -9='Missing' 
						0='Never/rarely' 
						1='<1 hr/week' 
						2='1-3 hr/week' 
						3='4-7 hr/week' 
						4='>7 hr/week';
	value rfphysfmt -9='Unknown' 
						0='Never' 
						1='Rarely' 
						2='<1 hr/week' 
						3='1-3 hr/week' 
						4='4-7 hr/week' 
						5='>7 hr/week';
	value rfhormtype 9='Missing' 
						0='Never' 
						1='Estrogen only' 
						2='Progestin only' 
						3=' Both estrogen and progestin' 
						4='Unknown type' 
						8='NA'; 

	** Lacey - MHT encodings;
	value l_afterRfq 9='Missing' 
						0='ET-only started before RFQ' 
						1 = 'ET-only started at/after RFQ' 
						8 = 'N/A' ;
	value l_eptcurdur 10='Missing' 
						9='Missing' 
						0='No HT' 
						1 = '<5 Former' 
						2 = '<5 Current' 
						3 = '5+ Former'
						4 = '5+ Current' 
						5 = 'Unknown Former' 
						6 = 'Unknown Current' 
						7 = '<5 Unknown'
						8 = '5+ Unknown';
	value l_eptcurdurr 10='Missing' 
						9='Missing' 
						0='No HT' 
						1 = '<10 Former' 
						2 = '<10 Current' 
						3 = '10+ Former'
						4 = '10+ Current' 
						5 = 'Unknown Former' 
						6 = 'Unknown Current' 
						7 = '<10 Unknown'
						8 = '10+ Unknown';
	value l_eptcurrent 4 = 'Other/Unknown HT' 
						3 = '4. Unknown' 
						2 = '3. Current' 
						1 = '2. Former' 
						0 = 'No HT' 
						9='Missing';
	value l_eptcurrentvr 1 = 'Ever EPT' 
						0 = 'No HT' 
						9='Missing';
	value l_eptdose -9='Missing' 
						9 = 'Unknown HT' 
						8 = 'ET' 
						5 = 'Unknown dose' 
						4 = '4. 10' 
						3 = '3. 5' 
						2 = '2. 2.5' 
						1 = '<1' 
						0 = 'No HT';
	value l_eptdur -9='Missing' 
						99 = 'Unknown HT' 
						88 = 'ET' 
						9 = 'DK' 
						3 = '3. 10+' 
						2 = '2. 5-9' 
						1 = '<5' 
						0 = 'No HT';
	value l_eptregdose 99 = 'Unknown HT' 
						88 = 'ET only' 
						13 = '15-25 d/m or unknown EPT regimen' 
						12 = 'CEPT and unknown dose'
						11 = 'CEPT & other dose' 
						10 = 'CEPT & 10 mg' 
						9 = 'CEPT & 5 mg' 
						8 = 'CEPT & 2.5 mg'
						7 = 'CEPT & <1 mg' 
						6 = 'SEPT and unknown dose' 
						5 = 'SEPT & other dose' 
						4 = 'SEPT & 10 mg'
						3 = 'SEPT & 5 mg' 
						2 = 'SEPT & 2.5 mg' 
						1 = 'SEPT & <1 mg' 
						0 = 'No HT';
	value l_eptregyrs 99 = 'Unknown HT' 
						88 = 'ET only' 
						9 = 'Unknown EPT regimen' 
						8 = '15-25 days PT per month, known duration'
						7 = 'SEPT or CEPT with unknown yrs' 
						6 = 'CEPT & 5+ yrs' 
						5 = 'CEPT & 2-4 yrs' 
						4 = 'CEPT & <=1 yr'
						3 = 'SEPT & 5+ yrs' 
						2 = 'SEPT & 2-4 yrs' 
						1 = 'SEPT & <=1 yr' 
						0 = 'No HT';
	value l_epttype 9 = 'Unknown HT' 
						8 = 'ET' 
						5 = 'Uns' 
						4 = 'Other' 
						3 = 'Cycrin' 
						2 = 'Medro' 
						1 = 'Provera' 
						0 = 'No HT';
	value l_estvsprg 9 = 'N/A' 8 = 'Unknown' 2 = 'E<P' 1 = 'E>P' 0 = 'E=P';
	value l_eptreg 9 = 'Unknown HT' 
						0 = '1. No HT' 
						8 = '2. ET' 
						1 = '3. Sequential' 
						2 = '4. 15-25 d/m' 
						3 = '5. Continuous' 
						4 = '6. Unknown regimen' 
						-9='Missing';

	value l_et_ept_et -9 = 'N/A' 
						2 = 'Other' 
						1 = 'Yes' 
						0 = 'No';
	value l_etcurdur;
	value l_etcurrent 4 = 'Other/Unknown HT' 
						3 = '4. Unknown' 
						2 = '3. Current' 
						1='2. Former' 
						0 = 'No HT' 
						9='Missing';
	value l_etcurrentvr 1 = 'Ever ET' 
						0 = 'No HT' 
						9='Missing';
	value l_etdose -9='Missing' 
						9 = 'Unk HT' 
						3 = 'Unknown' 
						2 = 'Other' 
						1 = '.625' 
						0 = 'No HT';
	value l_estdose -9='Missing' 
						1='1. 0.3 mg' 
						2='2. 0.625 mg' 
						3='3. 1.250 mg' 
						4='4. Other';
	value l_etdur -9='Missing' 
						99 = 'Unknown HT' 
						88 = 'EPT or Other/Unknown HT type' 
						9 = 'DK' 
						2 = '2. 10+' 
						1 = '<10' 
						0 = 'No HT';
	value l_etfreq -9='Missing' 
						9 = 'Unknown HT' 
						3 = 'Unknown' 
						2 = '2. Other' 
						1 = 'Daily' 
						0 = 'No HT';
	value l_ettype 9 = 'Unknown HT' 
						6 = 'Unsure' 
						5 = 'Other' 
						4 = 'Estratab' 
						3 = 'Estrace' 
						2 = 'Ogen' 
						1 = 'Premarin' 
						0 = 'No HT';
	value l_fldosereg 99 = 'No EPT' 
						9 = 'Unknown regimen' 
						8 = 'Other dose & regimen' 
						7 = 'Unknown dose' 
						6 = 'Unknown dose'
						5 = 'SEPT/CEPT w/other dose' 
						4 = 'SEPT/CEPT w/other dose' 
						3 = 'High' 
						2 = 'Low' 
						1 = 'Low' 
						0 = 'OK';
	value l_htformulation 99 = 'DK' 
						10 = 'Other/Unknown type' 
						9 = 'Unknown start date for ET and/or PT' 
						8 = 'EPT-ET'
						7 = 'EPT-PT' 
						6 = 'PT-ET' 
						5 = 'ET-PT' 
						4 = 'PT-EPT' 
						3 = 'EPT' 
						2 = 'ET-EPT' 
						1 = 'ET' 
						0 = 'No HT';
	value l_httype 9 = 'Unknown' 
					3 = '4. Other/Unknown type' 
					2 = '3. EPT' 
					1 = '2. ET' 
					0 = 'No HT' 
					-9='Missing';
	value l_httypevr 9 = 'Unknown' 
						3 = 'Other/Unknown type' 
						1 = 'Ever HT' 
						0 = 'No HT' 
						-9='Missing';
	value l_sameduration 1 = 'Yes' 
						0 = 'No';
	value l_samestart -9 = 'NA' 
						8 = 'Unknown' 
						6 = 'EPT-ET' 
						5 = 'EPT-PT' 
						4 = 'PT-ET' 
						3 = 'ET-PT' 
						2 = 'PT-EPT' 
						1 = 'EPT-only' 
						0 = 'ET-EPT';
	value colosigfmt 1 = 'Yes' 
						0 = 'No' 
						9='Missing';
	value rf_est_cur 9='Unknown' 
						8='NA' 
						1='Yes' 
						0='No';
	value $rfq15afmt '0'='No' 
						'1'='Sigmoidoscopy';
	value $rfq15bfmt '0'='No' 
						'1'='Colonoscopy';
	value $rfq15cfmt '0'='No' 
						'1'='Proctoscopy';
	value $rfq15dfmt '0'='No' 
						'1'='Unknown type';
	value $rfq15efmt '0'='NA' 
						'1'='None';
  
run;

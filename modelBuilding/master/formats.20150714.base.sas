/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
#
# creates formats for the master model building file
# baseline
#
#
# Created: June 29 2015
# Updated: v20160616THU WTL
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************/
libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
libname results 'C:\REB\AARP_HRTandMelanoma\Results\baseline\mht';

proc format;
	value sexfmt 0 = 'Male' 
					1 = 'Female';
	value melanfmt 0 = 'No melanoma' 
					1 = 'In situ melanoma' 
					2 = 'Malignant melanoma';
	value melanomafmt 0 = 'No melanoma' 
					1 = 'Melanoma';
	value melanomainsfmt 0 = 'No melanoma' 
					1='Melanoma in situ';
	value melanomamalfmt 0 = 'No melanoma' 
					1='Malignant melanoma';

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
					1='1. Less than high school' 
					2='2. High school graduate' 
					3='3. Post high school' 
					4='4. Some college' 
					5='5. College or post graduate';
	value bmifmt -9='Missing' 
					1='>18.5 to < 25' 
					2='25 to < 30' 
					3='30 to < 60';
	value bminewfmt -9='Missing or extreme' 
					1='18.5 to <25' 
					2='25 to <30' 
					3='30 to <60';
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
	** added 2 cat fmenstr_2c for interactions, 20160520 WTL;
	value fmenstr2cfmt 0='1. 10>=' 
					1='2. 11+';
	value fmenstrcfmt -9='Missing' 
					0='1. 10>=' 
					1='2. 11-12' 
					2='3. 13-14' 
					3='4. 15+';
	value fmenstrfmt -9='Missing' 
					1='1. 10>=' 
					2='2. 11-12' 
					3='3. 13-14' 
					4='4. 15+' 
					9='Unknown';
	value menostatfmt -9='Missing' 
					9='Pre-menopausal' 
					1='Natural menopause' 
					2='Surgical/hyst menopause'
					3='Radiation or chemotherapy' 
					4='Other reason';
	value agemenofmt 1='1. <40' 
					2='2. 40-44' 
					3='3. 45-49' 
					4='4. 50-54' 
					5='5. >55' 
					6='6. Still menstruating' 
					9='7. Unknown';
	value menopagefmt -9='Missing' 
					1='1. <45' 
					2='2. 45-49' 
					3='3. 50-54' 
					4='4. >=55' 
					5='Still menstruating';
	value menopage3fmt 1='1. <45' 
					2='2. 45-54' 
					3='3. 55+' ;
	value menopiagefmt -9='Missing' 
					1='1. <45' 
					2='2. 45-49' 
					3='3. 50+' 
					5='Still menstruating';
	value menoagefmt -9='Missing' 
					1='1. <50' 
					2='2. 50-54' 
					3='3. 55+' 
					4='Periods did not stop';
	value menopage4fmt 9='Missing' 
					1='1. <40' 
					2='2. 40-44' 
					3='3. 45-49'
					4='4. 50+' ;
	value flbagefmt -9='Missing' 
					1='1. < 20 years old' 
					2='2. 20-29' 
					3='3. 30+' 
					9='4. Nulliparous/missing parity';
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
					0='Nulliparous' 
					1='1-2 live children' 
					2='>=3 live children';
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
					0='1. Never used' 
					1='2. <5 years' 
					2='3. 5-9 years' 
					3='4. >=10 years';
	value oralbcdurfmt -9='Missing' 
					0='1. Never/<1yr' 
					1='2. 1-4 years' 
					2='3. 5-9 years' 
					3='4. 10+ years' 
					9='Unknown';
	value oralbcynfmt -9='Missing' 
					0='Never/<1yr' 
					1='Ever';
	value oralbcyrsfmt -9='Unknown' 
					0='1. Never/<1yr' 
					1='2. 1-4 years' 
					2='3. 5-9 years' 
					3='4. 10+ years';
	value uvrqfmt -9='Missing' 
					1='176.095 to 186.918' 
					2='186.918 to 239.642' 
					3='239.642 to 253.731' 
					4='253.731 to 289.463';
	value uvrq5cfmt 1='176.095 to 186.255'
					2='186.255 to 215.622'
					3='215.622 to 245.151'
					4='245.151 to 257.140'
					5='257.140 to 289.463';
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
	value $qp12bfmt '0'='None' 
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
	value $qp2b1fmt '0'='Never' 
					'1'='1 time per month or less' 
					'2'='2-3 times per month'
					'3'='1-2 times per week'
					'4'='3-4 times per week'
					'5'='5-6 times per week'
					'6'='1 time per day'
					'7'='2-3 times per day'
					'8'='4-5 times per day'
					'9'='6+ times per day'
					'E'='Error'
					'M'='Missing';
	value $qp2b2fmt '0'='Less than 3/4 cup'
					'1'='3/4 to 1 cup'
					'2'='More than 1 cup'
					'M'='Missing'
					'E'='Error';
run;

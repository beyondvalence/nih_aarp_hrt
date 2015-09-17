/******************************************************************
#      NIH-AARP UVR- Reproductive Factors- Melanoma Study
*******************************************************************
#
# creates formats for the master model building file
# baseline
#
#
# Created: June 29 2015
# Updated: v20150908TUE WTL
# Used IMS: anchovy
# Warning: original IMS datasets are in LINUX latin1 encoding
*******************************************************************/
libname conv 'C:\REB\AARP_HRTandMelanoma\Data\converted';
libname results 'C:\REB\AARP_HRTandMelanoma\Results\baseline\mht';

proc format;
	value sexfmt 0 = 'Male' 1 = 'Female';
	value melanfmt 0 = 'no melanoma' 1 = 'in situ melanoma' 2 = 'malignant melanoma';
	value melanomafmt 0 = 'no melanoma' 1 = 'melanoma';
	value melanomainsfmt 0 = 'no melanoma' 1='melanoma in situ';
	value melanomamalfmt 0 = 'no melanoma' 1='malignant melanoma';

	value agecatfmt 1 = '50-55 years' 2 = '55-59 years' 3 = '60-64 years' 4 = '65-69 years' 5 = '>=70 years';
	value birthcohortfmt 1='1925-1928' 2='1929-1932' 3='1933-1934' 4='1935-1938' 5='1939-1945';
	value attainedagefmt -9='missing' 0='>=50 to <55' 1='>=55 to <60' 2='>=60 to <65' 3='>=65 to <70' 4='70+';
	value racefmt -9='missing' 0='non-Hispanic white' 1='non-Hispanic black' 2='Hispanic, Asian, PI, AIAN';
	value educfmt -9='missing' 0='Less than high school' 1='High school graduate' 2='Some college' 3='College or graduate school';
	value educmfmt -9='missing' 1='Less than high school' 2='High school graduate' 3='Post high school' 4='Some college' 5='College or post graduate' 9='Unknown';
	value bmifmt -9='missing' 1='< 25' 2='25 to < 30' 3='>=30';
	value bminewfmt -9='missing or extreme' 1='18.5 to <25' 2='25 to <30' 3='30 to <60';
	value physiccfmt -9='missing' 0='Never/rarely' 1='1-3 per month' 2='1-2 per week' 3='3-4 per week' 4='5+ per week';
	value physicfmt -9='missing' 0='never' 1='rarely' 2='1-3 per month' 3='1-2 per week' 4='3-4 per week' 5='5+ per week' 9='Unknown';
	value smokingfmt -9='missing' 0='never smoked' 1='ever smoke';
	value marriagefmt 1='Married' 2='Widowed' 3='Divorced' 4='Separated' 5='Never married' 9='Unknown';
	value marriagecfmt 1='Married' 2='Widowed' 3='Divorced/separated' 5='Never married' 9='Unknown';

	** fmenstr, menopause status recoded 20150721WTL;
	value fmenstrcfmt -9='missing' 0='10>=' 1='11-12' 2='13-14' 3='15+';
	value fmenstrfmt -9='missing' 0='10>=' 1='11-12' 2='13-14' 3='15+' 9='unknown';
	value menostatfmt -9='missing' 9='pre-menopausal' 1='natural menopause' 2='surgical/hyst menopause'
						3='radiation or chemotherapy' 4='other reason';
	value menopagefmt 9='missing' 1='<45' 2='45-49' 3='50-54' 4='>=55' 5='still menstruating';
	value menopiagefmt 9='missing' 1='<45' 2='45-49' 3='50+' 5='still menstruating';
	value menoagefmt -9='missing' 1='<50' 2='50-54' 3='55+' 4='periods did not stop';
	value surgagefmt -9='missing' 1='<45' 2='45-49' 3='50+' 4='periods did not stop';
	value flbagefmt -9='missing' 1='< 20 years old' 2='20s' 3='30s' 9='nulliparous/missing parity';
	value ageflbfmt 9='Unknown' 0='Never gave birth' 1='<16' 2='16-19' 3='20-24' 4='25-29' 5='30-34' 6='35-39' 7='>=40';
	value parityfmt -9='missing' 0='Nulliparous' 1='1-2 live children' 2='>=3 live children';
	value livechildfmt 9='unknown' 0='Never had a child' 1='1' 2='2' 3='3-4' 4='5-9' 5='>=10';
	value hormstatfmt -9='missing' 0='Never' 1='Current' 2='Former' 9='Unknown';
	value hormeverfmt -9='missing' 0='Never' 1='Ever';
	value hormcurfmt 9='missing' 0='No' 1='Yes Currently';
	value hormyrsfmt -9='missing' 0='never used' 1='1. <5 years' 2='2. 5-9 years' 3='3. >=10 years' 9='Unknown';
	value oralbcdurfmt -9='missing' 0='Never/<1yr' 1='1-4 years' 2='5-9 years' 3='10+ years';
	value oralbcynfmt -9='missing' 0='Never/<1yr' 1='Ever';
	value oralbcyrsfmt 9='Unknown' 0='Never/<1yr' 1='1-4 years' 2='5-9 years' 3='10+ years';
	value uvrqfmt -9='missing' 1='0 to 186.918' 2='186.918 to 239.642' 3='239.642 to 253.731' 
					4='253.731 to 289.463';
	value rphysicfmt -9='missing' 1='rarely' 2='<1 hour/week' 3='1-3 hours/week' 4='4-7 hours/week' 5='>7 hours/week';
	value relativefmt 9='missing' 0='No' 1='Yes' -9='missing';
	value postmenofmt 99='not postmeno' 1='postmeno' 2='postmeno' 3='postmeno' 4='postmeno' 5='postmeno';

	** menopause reason edit 20150723THU WTL;
	value menoreasonfmt 3='rad/chem meno reason' 2='surgical meno reason' 1='natural meno reason'
						0='periods did not stop';
	value natmenofmt -9='missing' 0='periods did not stop' 1='natural meno reason';
	value surgmenofmt -9='missing' 0='periods did not stop' 1='surgical meno reason';
	value radchemmenofmt -9='missing' 0='periods did not stop' 1='radchem meno reason';
	value ovarystatfmt -9='missing' 1='Both removed' 2='Both intact' 3='Other surgery to ovaries' 9='Unknown';
	value mhteverfmt -9='missing' 0='Never' 1='ever';
	value perstopmenopfmt 0='No' 1='Yes' 9='Unknown';
	value perstopsurgfmt 0='No' 1='Yes' 9='Unknown';
	value hyststatfmt 0='No Hyst' 1='Hysterectomy' 9='Unknown';

	** smoking;
	value smokeformerfmt -9='missing' 0='Never smoked' 1='Former smoker' 2='Current smoker' 9='Unknown';
	value smokequitfmt -9='missing' 0='never smoked' 1='stopped 10+ years ago' 2='stopped 5-9 years ago'
						3='stopped 1-4 years ago' 4='stopped within last year' 5='currently smoking'
						9='Unknown';
	value smokedosefmt -9='missing' 0='never smoked' 1='1-10 cigs a day' 2='11-20 cigs a day' 
						3='21-30 cigs a day' 4='31-40 cigs a day' 5='41-60 cigs a day' 
						6='61+ cigs a day' 9='Unknown';
	value smokequitdosefmt -9='missing' 0='never smoked' 1='quit, <=20 cigs/day' 2='quit, >20 cigs/day'
							3='currently smoking, <=20 cigs/day' 4='currently smoking, >20 cigs/day'
							9='Unknown';
	value coffeefmt -9='missing' 0='none' 1='<=1 cup/day' 2='2-3 cups/day' 3='>=4 cups/day';
	value etohfmt -9='missing' 0='none' 1='<=1' 2='>1 and <=3' 3='>3';
	value colosigfmt 1 = 'Yes' 0 = 'No' -9='Missing';
	value l_sameyear 1 = 'Yes' 0 = 'No' -9='Missing';
run;

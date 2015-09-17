LIBNAME Data 'E:\NCI\HRT OC and BCC in USRT\Data';
LIBNAME LQ3Data 'E:\NCI\UV and skin cancer in USRT\USRT data';

data useMAIN; set Data.analysis_20140630
(KEEP=
COHORTID CA_SELFRPT	CA_OBTAINED	BIRTH_COHORT ENTRY_AGE EXIT_AGE FOLLOWUP EVENT_BCC	BIRTH_DATE NUMSEX 
LQ2_HEIGHT LQ2_WEIGHT LQ2_BMI LQ2_SMK_PACK_YEARS_V2 LQ2_SMK_EVER LQ2_SMK_CUR LQ2_ALCOHOL LQ2_Q67_DIURETICS QX3_EDUC LQ2_MARSTAT
HNDOSE_LQ2	TYW_LQ2    															
LQ2_Q69_1715 LQ2_Q70_1716 LQ2_Q71_1717  LQ2_Q81_1803 HISPANIC                 												
LQ2_Q34_707	LQ2_MENO_EVER	LQ2_Q36_710	LQ2_Q37_712	LQ2_Q37_713	LQ2_Q37_714	LQ2_Q37_715	LQ2_Q37_716	LQ2_Q38_717									
LQ2_ORAL_BC_EVER LQ2_Q40_719	LQ2_HORM_EVER	LQ2_Q42_721	LQ2_Q43_723 LQ2_Q44_724	LQ2_Q45_725 LQ2_DES_EVER LQ2_Q47_727 									
LQ2_Q53_796	LQ2_Q54_797	LQ2_Q54_798	LQ2_Q54_799	LQ2_Q54_800	LQ2_Q54_801	LQ2_Q54_802	LQ2_Q54_803	LQ2_BRTH_NUM LQ2_NUM_STILL	LQ2_NUM_MISCARRIAGE	LQ2_NUM_ABORTION						
LQ2_Q78_1798 LQ2_Q78_1799 LQ2_Q78_1800 LQ2_Q79_1801 LQ2_Q80_1802													
);
run;

data useUVR; set Data.usrt_uv_weather_wideV2;
ann3051 = mean(Jan3051,Feb3051,Mar3051,Apr3051,May3051,Jun3051,Jul3051,Aug3051,Sep3051,Oct3051,Nov3051,Dec3051);
ann3052 = mean(Jan3052,Feb3052,Mar3052,Apr3052,May3052,Jun3052,Jul3052,Aug3052,Sep3052,Oct3052,Nov3052,Dec3052);
ann3053 = mean(Jan3053,Feb3053,Mar3053,Apr3053,May3053,Jun3053,Jul3053,Aug3053,Sep3053,Oct3053,Nov3053,Dec3053);
ann3054 = mean(Jan3054,Feb3054,Mar3054,Apr3054,May3054,Jun3054,Jul3054,Aug3054,Sep3054,Oct3054,Nov3054,Dec3054);
ann3055 = mean(Jan3055,Feb3055,Mar3055,Apr3055,May3055,Jun3055,Jul3055,Aug3055,Sep3055,Oct3055,Nov3055,Dec3055);
run;
data useUVR; set useUVR
(KEEP=COHORTID Ann3051 Ann3052 Ann3053 Ann3054 Ann3055);
run;

data useLQ3vars; set LQ3Data.rpt011_skin_expanded_dataset
(KEEP=COHORTID LQ3_WKSUNEXP_U13	LQ3_WKSUNEXP_13_19 LQ3_WKSUNEXP_20_39 LQ3_WKSUNEXP_40_64 LQ3_WKSUNEXP_65OV);
run;

data usereprosum; set Data.reprosum
(KEEP=COHORTID flbage_q2 nopreg2_q2);
run;



******************************;
*** Merge in new variables ***;
******************************;
proc sort data=useMAIN;by COHORTID;run;
proc sort data=useUVR;by COHORTID;run;
proc sort data=useLQ3vars;by COHORTID;run;

data use; 
merge useMAIN useUVR useLQ3vars usereprosum;by COHORTID ;
run;

data use; set use;
if FOLLOWUP<0 then delete;
run;

data use; set use;
if numsex=1 then delete;
run;

*********************;
*** New variables ***;
*********************;

data use; set use;

**** DEMOGRAPHIC VARIABLES ****;

age_cat=1;
if ENTRY_AGE>39.9999 then age_cat=2;
if ENTRY_AGE>49.9999 then age_cat=3;
if ENTRY_AGE>59.9999 then age_cat=4;

birth_cohortd=.;
if BIRTH_COHORT=1  then birth_cohortd=1;
if BIRTH_COHORT=2  then birth_cohortd=2;
if BIRTH_COHORT=3  then birth_cohortd=2;
if BIRTH_COHORT=4  then birth_cohortd=3;
if BIRTH_COHORT=5  then birth_cohortd=3;
if BIRTH_COHORT=6  then birth_cohortd=4;
if BIRTH_COHORT=7  then birth_cohortd=4;
if BIRTH_COHORT=8  then birth_cohortd=5;
if BIRTH_COHORT=9  then birth_cohortd=5;

bmi_cat=-1;
if LQ2_BMI>0         and LQ2_BMI<=18.499999 then bmi_cat=1;
if LQ2_BMI>18.499999 and LQ2_BMI<=24.999999 then bmi_cat=2;
if LQ2_BMI>24.999999 and LQ2_BMI<=29.999999 then bmi_cat=3;
if LQ2_BMI>29.999999                        then bmi_cat=4;	  

overweight=.;
if LQ2_BMI>18.499999 and LQ2_BMI<=24.999999 then overweight=1;
if LQ2_BMI>24.999999                        then overweight=2;

alcohol=-1;
if LQ2_ALCOHOL=0                     then alcohol=1;
if LQ2_ALCOHOL>0  and LQ2_ALCOHOL<1  then alcohol=2;
if LQ2_ALCOHOL>=1 and LQ2_ALCOHOL<7  then alcohol=3;
if LQ2_ALCOHOL>=7                    then alcohol=4;

diur_ever=-1;
if LQ2_Q67_DIURETICS=0 then diur_ever=1;
if LQ2_Q67_DIURETICS=1 then diur_ever=2;

education=-1;
if QX3_EDUC=1 or QX3_EDUC=2 or QX3_EDUC=3 or QX3_EDUC=4 then education=1;
if QX3_EDUC=5 or QX3_EDUC=6                             then education=2;

cohabit=-1;
if LQ2_MARSTAT=1 or LQ2_MARSTAT=4 or LQ2_MARSTAT=5 or LQ2_MARSTAT=6 then cohabit=1;
if LQ2_MARSTAT=2 or LQ2_MARSTAT=3                                   then cohabit=2;

**** EXERCISE ****;

exercize=-1;
if LQ2_Q78_1798=1 then exercize=1; 
if LQ2_Q78_1798>1 then exercize=2; 

ex_stren=-1;
if LQ2_Q78_1798=1 														then ex_stren=1; 
if LQ2_Q78_1798=2 														then ex_stren=2;
if LQ2_Q78_1798=3           											then ex_stren=3;
if LQ2_Q78_1798=4 or LQ2_Q78_1798=5 or LQ2_Q78_1798=6 or LQ2_Q78_1798=7 then ex_stren=4; 

walk_hike=-1;
if LQ2_Q78_1799=1 														then walk_hike=1;
if LQ2_Q78_1799=2 														then walk_hike=2; 
if LQ2_Q78_1799=3 														then walk_hike=3; 
if LQ2_Q78_1799=4 or LQ2_Q78_1799=5 or LQ2_Q78_1799=6 or LQ2_Q78_1799=7 then walk_hike=4;

walk_howo=-1;
if LQ2_Q78_1800=1 														then walk_howo=1;
if LQ2_Q78_1800=2 														then walk_howo=2;
if LQ2_Q78_1800=3 														then walk_howo=3;
if LQ2_Q78_1800=4 or LQ2_Q78_1800=5 or LQ2_Q78_1800=6 or LQ2_Q78_1800=7 then walk_howo=4;

selfhealth=-1;
if LQ2_Q80_1802=3 or LQ2_Q80_1802=4 then selfhealth=1;
if LQ2_Q80_1802=2                   then selfhealth=2;
if LQ2_Q80_1802=1                   then selfhealth=3;

**** SKIN SENSITIVITY VARIABLES ****;

eye=-1;
if LQ2_Q69_1715=1 or LQ2_Q69_1715=3 or LQ2_Q69_1715=5 then eye=1;
if LQ2_Q69_1715=4                                     then eye=2;
if LQ2_Q69_1715=2 or LQ2_Q69_1715=6                   then eye=3;
                                                       
hair=-1;
if LQ2_Q71_1717=1 or LQ2_Q71_1717=4  then hair=1;
if LQ2_Q71_1717=2 or LQ2_Q71_1717=3  then hair=2;
if LQ2_Q71_1717=5                    then hair=3;

sunsens1=-1;
if hair>1 and eye>1 and LQ2_Q70_1716>1 then sunsens1=1;
if hair=1 or  eye=1 or  LQ2_Q70_1716=1 then sunsens1=2;

sunsens2=-1;
if hair>1 or  eye>1 or  LQ2_Q70_1716>1  then sunsens2=1;
if hair=1 and eye=1 and LQ2_Q70_1716=1  then sunsens2=2;

run;
**** 305 UV EXPOSURE ****;
data use; set use;

YRS13=.; if ann3051>0 and  EXIT_AGE>13                  then YRS13=13;
YRS19=.; if ann3052>0 and  EXIT_AGE>19                  then YRS19=7;
YRS39=.; if ann3053>0 and  EXIT_AGE>39                  then YRS39=20; 
         if ann3053>0 and (EXIT_AGE>19 and EXIT_AGE<39) then YRS39=EXIT_AGE-20;
YRS64=.; if ann3054>0 and  EXIT_AGE>64                  then YRS64=25; 
         if ann3054>0 and (EXIT_AGE>39 and EXIT_AGE<64) then YRS64=EXIT_AGE-40;
YRS65=.; if ann3055>0 and  EXIT_AGE>65                  then YRS65=EXIT_AGE-65;

UVTOMS13=ann3051*YRS13;
UVTOMS19=ann3052*YRS19;
UVTOMS39=ann3053*YRS39;
UVTOMS64=ann3054*YRS64;
UVTOMS65=ann3055*YRS65;

SUM_UVTOMS=sum (UVTOMS13,UVTOMS19,UVTOMS39,UVTOMS64,UVTOMS65);
YRS= sum(YRS13, YRS19, YRS39, YRS64, YRS65);

UVTOMS=.;
if YRS>0 then UVTOMS=SUM_UVTOMS/YRS;


/*proc univariate data=use;var UVTOMS;
output out=bla pctlpts=25 50 75 pctlpre=p; run;
proc print; run;24.6809 27.7677 36.2585 
*/

uvtoms305q=-1;
if UVTOMS>-1    and UVTOMS<=24.7 then UVTOMS305q=1;
if UVTOMS>24.7  and UVTOMS<=27.8 then UVTOMS305q=2;
if UVTOMS>27.8  and UVTOMS<=36.2 then UVTOMS305q=3;
if UVTOMS>36.2                   then UVTOMS305q=4;

run;
**** Time outdoors ****;	   
data use; set use;
YRS13=.; if ann3051>0 and  EXIT_AGE>13                  then YRS13=13;
YRS19=.; if ann3052>0 and  EXIT_AGE>19                  then YRS19=7;
YRS39=.; if ann3053>0 and  EXIT_AGE>39                  then YRS39=20; 
         if ann3053>0 and (EXIT_AGE>19 and EXIT_AGE<39) then YRS39=EXIT_AGE-20;
YRS64=.; if ann3054>0 and  EXIT_AGE>64                  then YRS64=25; 
         if ann3054>0 and (EXIT_AGE>39 and EXIT_AGE<64) then YRS64=EXIT_AGE-40;
YRS65=.; if ann3055>0 and  EXIT_AGE>65                  then YRS65=EXIT_AGE-65;

TO13=LQ3_WKSUNEXP_U13*YRS13;
TO19=LQ3_WKSUNEXP_13_19*YRS19;
TO39=LQ3_WKSUNEXP_20_39*YRS39;
TO64=LQ3_WKSUNEXP_40_64*YRS64;
TO65=LQ3_WKSUNEXP_65OV*YRS65;

SUM_TO=sum (TO13,TO19,TO39,TO64,TO65);
YRS= sum(YRS13, YRS19, YRS39, YRS64, YRS65);

TO=.;
if YRS>0 then TO=SUM_TO/YRS;
run;

proc univariate data=use;var TO;
output out=bla pctlpts=25 50 75 pctlpre=p; run;
proc print; run;
/*10.2992 15.0119 20.5415 */
data use; set use;
TOq=-1;
if TO>-1    and TO<=10.3 then TOq=1;
if TO>10.3  and TO<=15.0 then TOq=2;
if TO>15.0  and TO<=20.5 then TOq=3;
if TO>20.5               then TOq=4;

**** Occupational radiation ****;
/*proc univariate data=use;var HNDOSE_LQ2;
output out=bla pctlpts=25 50 75 pctlpre=p; run;
proc print; run;26.8635 46.26 77.958 
*/

hndoseq=-1;
if HNDOSE_LQ2>-1    and HNDOSE_LQ2<=26.9 then hndoseq=1;
if HNDOSE_LQ2>26.9  and HNDOSE_LQ2<=46.3 then hndoseq=2;
if HNDOSE_LQ2>46.3  and HNDOSE_LQ2<=80   then hndoseq=3;
if HNDOSE_LQ2>80                         then hndoseq=4;	 

**** Hormonal/reproductive factors ****;

menarche_age=-1;
if LQ2_Q34_707>0  AND LQ2_Q34_707<12 then menarche_age=1;*Reference for models;
if LQ2_Q34_707=12 OR  LQ2_Q34_707=13 then menarche_age=2;
if LQ2_Q34_707=14 OR  LQ2_Q34_707=15 then menarche_age=3;
if LQ2_Q34_707>=16                   then menarche_age=4;

meno_age=-1;
if LQ2_MENO_EVER=0                    then meno_age=0;
if LQ2_Q36_710>0   AND LQ2_Q36_710<40 then meno_age=1;
if LQ2_Q36_710>=40 AND LQ2_Q36_710<50 then meno_age=2;
if LQ2_Q36_710>=50                    then meno_age=3;

parity_cat=-1;
if LQ2_BRTH_NUM=0                   then parity_cat=1;
if LQ2_BRTH_NUM=1 or LQ2_BRTH_NUM=2 then parity_cat=2; *Reference for models;
if LQ2_BRTH_NUM=3 or LQ2_BRTH_NUM=4 then parity_cat=3;
if LQ2_BRTH_NUM>4                   then parity_cat=4;

parity_evr=-1;
if LQ2_BRTH_NUM=0 then parity_evr=1;*Reference for models;
if LQ2_BRTH_NUM>0 then parity_evr=2; 

numpreg=sum(LQ2_BRTH_NUM,LQ2_NUM_STILL,LQ2_NUM_MISCARRIAGE,LQ2_NUM_ABORTION);

flbage_cat=-1;
if LQ2_BRTH_NUM=0                 then LQ2_BRTH_NUM=0;
if flbage_q2>0   AND flbage_q2<20 then flbage_cat=1; *Reference for models;
if flbage_q2>=20 AND flbage_q2<25 then flbage_cat=2;
if flbage_q2>=25 AND flbage_q2<30 then flbage_cat=3;
if flbage_q2>=30                  then flbage_cat=4;

nopreg=-1;
if nopreg2_q2=0 then nopreg=1;
if nopreg2_q2=1 then nopreg=2;

meno_evr=-1;
if LQ2_MENO_EVER=0  then meno_evr=1;
if LQ2_MENO_EVER=1  then meno_evr=2;

natmeno=-1;
if LQ2_Q37_713=0 then natmeno=1;
if LQ2_Q37_713=1 then natmeno=2;

hyster=-1;
if LQ2_Q37_712=0 then hyster=1;
if LQ2_Q37_712=1 then hyster=2;

ovaries=-1;
if LQ2_Q38_717=3 then ovaries=1;*0 removed;
if LQ2_Q38_717=2 then ovaries=2;*1 removed;
if LQ2_Q38_717=1 then ovaries=3;*Both;
if LQ2_Q38_717=4 then ovaries=4;*DK;

menostat=-1;
if LQ2_MENO_EVER=0                                     					  then menostat=0; *Reference for models;
if LQ2_MENO_EVER=1 and LQ2_Q37_713=1                   					  then menostat=1; *Natural menopause;
if LQ2_MENO_EVER=1 and LQ2_Q37_712=1 and LQ2_Q38_717=1 					  then menostat=2; *Hysterectomy, 2 ovaries removed;
if LQ2_MENO_EVER=1 and LQ2_Q37_712=1 and LQ2_Q38_717=2 					  then menostat=3; *Hysterectomy, 1 ovary removed;
if LQ2_MENO_EVER=1 and LQ2_Q37_712=1 and LQ2_Q38_717=3                    then menostat=4; *Hysterectomy, 0 ovaries removed;
if LQ2_MENO_EVER=1 and LQ2_Q37_712=1 and (LQ2_Q38_717<0 or LQ2_Q38_717=4) then menostat=5; *Hysterectomy, ovaries unknown;
if LQ2_MENO_EVER=1 and (LQ2_Q37_714=1 or LQ2_Q37_715=1 or LQ2_Q37_716=1)  then menostat=6; *Other reasons for menopause;

nmeno_age=-1;
if LQ2_MENO_EVER=0                                                          then nmeno_age=0;
if LQ2_Q36_710>0   AND LQ2_Q36_710<50 AND menostat=1 then nmeno_age=1;
if LQ2_Q36_710>=50 AND LQ2_Q36_710<55 AND menostat=1 then nmeno_age=2;*Reference for models;
if LQ2_Q36_710>=55 AND LQ2_Q36_710<80 AND menostat=1 then nmeno_age=3;

hmeno_age=-1;
if LQ2_MENO_EVER=0                                      then hmeno_age=0;
if LQ2_Q36_710>0   AND LQ2_Q36_710<45 AND menostat>=2 AND menostat<=5  then hmeno_age=1;*Reference for models;
if LQ2_Q36_710>=45 AND LQ2_Q36_710<50 AND menostat>=2 AND menostat<=5  then hmeno_age=2;
if LQ2_Q36_710>=50 AND LQ2_Q36_710<80 AND menostat>=2 AND menostat<=5  then hmeno_age=3;

mdes_evr=-1;
if LQ2_Q47_727=1 then mdes_evr=1;
if LQ2_Q47_727=2 then mdes_evr=2;

**** OC  ****;

oc_evr_me=.;
if LQ2_ORAL_BC_EVER=0 then oc_evr_me=1;
if LQ2_ORAL_BC_EVER=1 then oc_evr_me=2;

oc_evr_c=-1;
if LQ2_ORAL_BC_EVER=0 then oc_evr_c=1;
if LQ2_ORAL_BC_EVER=1 then oc_evr_c=2;

oc_dur_me0=.;
if LQ2_ORAL_BC_EVER=0 then oc_dur_me0=0;
if LQ2_Q40_719=1    then oc_dur_me0=1;
if LQ2_Q40_719=2    then oc_dur_me0=2;
if LQ2_Q40_719=3    then oc_dur_me0=3;
if LQ2_Q40_719=4    then oc_dur_me0=4;
if LQ2_Q40_719=5    then oc_dur_me0=5;

oc_dur_me1=.;
if LQ2_Q40_719=1   then oc_dur_me1=1;
if LQ2_Q40_719=2   then oc_dur_me1=2;
if LQ2_Q40_719=3   then oc_dur_me1=3;
if LQ2_Q40_719=4   then oc_dur_me1=4;
if LQ2_Q40_719=5   then oc_dur_me1=5;

oc_dur_c=-1;
if LQ2_Q40_719='.D' then oc_dur_c=-2;
if LQ2_ORAL_BC_EVER=0 then oc_dur_c=0;
if LQ2_Q40_719=1    then oc_dur_c=1;
if LQ2_Q40_719=2    then oc_dur_c=2;
if LQ2_Q40_719=3    then oc_dur_c=3;
if LQ2_Q40_719=4    then oc_dur_c=4;
if LQ2_Q40_719=5    then oc_dur_c=5;

**** HRT/Estrogen ****;

hrt_cur_me=.;
if LQ2_Q44_724=1 then hrt_cur_me=1;
if LQ2_Q44_724=2 then hrt_cur_me=2;

hrt_cur_c=-1;
if LQ2_Q44_724=1 then hrt_cur_c=1;
if LQ2_Q44_724=2 then hrt_cur_c=2;

hrt_evr_me=.;
if LQ2_HORM_EVER=0 then hrt_evr_me=1;
if LQ2_HORM_EVER=1 then hrt_evr_me=2;

hrt_evr_c=-1;
if LQ2_HORM_EVER=0 then hrt_evr_c=1;
if LQ2_HORM_EVER=1 then hrt_evr_c=2;


hrt_npc_me=.;
if LQ2_HORM_EVER=0                   then hrt_npc_me=1;
if LQ2_HORM_EVER=1 and LQ2_Q44_724=1 then hrt_npc_me=2;
if LQ2_HORM_EVER=1 and LQ2_Q44_724=2 then hrt_npc_me=3;

hrt_npc_c=-1;
if LQ2_HORM_EVER=0                   then hrt_npc_c=1;
if LQ2_HORM_EVER=1 and LQ2_Q44_724=1 then hrt_npc_c=2;
if LQ2_HORM_EVER=1 and LQ2_Q44_724=2 then hrt_npc_c=3;

hrt_dur_me0=.;
if LQ2_HORM_EVER=0  then hrt_dur_me0=0;
if LQ2_Q43_723=1    then hrt_dur_me0=1;
if LQ2_Q43_723=2    then hrt_dur_me0=2;
if LQ2_Q43_723=3    then hrt_dur_me0=3;
if LQ2_Q43_723=4    then hrt_dur_me0=4;
if LQ2_Q43_723=5    then hrt_dur_me0=5;

hrt_dur_me1=.;
if LQ2_Q43_723=1    then hrt_dur_me1=1;
if LQ2_Q43_723=2    then hrt_dur_me1=2;
if LQ2_Q43_723=3    then hrt_dur_me1=3;
if LQ2_Q43_723=4    then hrt_dur_me1=4;
if LQ2_Q43_723=5    then hrt_dur_me1=5;

hrt_dur_c=-1;
if LQ2_Q43_723='.D' then hrt_dur_c=-2;
if LQ2_HORM_EVER=0  then hrt_dur_c=0;
if LQ2_Q43_723=1    then hrt_dur_c=1;
if LQ2_Q43_723=2    then hrt_dur_c=2;
if LQ2_Q43_723=3    then hrt_dur_c=3;
if LQ2_Q43_723=4    then hrt_dur_c=4;
if LQ2_Q43_723=5    then hrt_dur_c=5;

prog_evr_me=.;
if LQ2_HORM_EVER=0                      then prog_evr_me=1;*No HRT;
if LQ2_Q45_725=1                        then prog_evr_me=2;*Estrogen only;
if LQ2_Q45_725=2                        then prog_evr_me=3;*Est and prog;
if LQ2_Q45_725='.C' or LQ2_Q45_725='.D' then prog_evr_me=4;*Unknown if prog;


run;

/*

proc freq data=use ;
tables
sunsens1*eye
sunsens1*hair
sunsens1*LQ2_Q70_1716

sunsens2*eye
sunsens2*hair
sunsens2*LQ2_Q70_1716

LQ2_BRTH_NUM*parity_cat

LQ2_ORAL_BC_EVER*oc_evr_me
LQ2_ORAL_BC_EVER*oc_evr_c

LQ2_Q40_719*oc_dur_me0
LQ2_Q40_719*oc_dur_me1
LQ2_Q40_719*oc_dur_c

LQ2_HORM_EVER*hrt_evr_me
LQ2_HORM_EVER*hrt_evr_c  

LQ2_Q43_723*hrt_dur_me0
LQ2_Q43_723*hrt_dur_me1
LQ2_Q43_723*hrt_dur_c 
 
LQ2_Q44_724*hrt_cur_me
LQ2_Q44_724*hrt_cur_c

LQ2_Q45_725*prog_evr_me

numpreg*LQ2_NUM_ABORTION

LQ2_MENO_EVER*hrt_evr_me
LQ2_MENO_EVER*LQ2_Q37_712
LQ2_MENO_EVER*LQ2_Q37_713
LQ2_MENO_EVER*LQ2_Q37_714
LQ2_MENO_EVER*LQ2_Q37_715
LQ2_MENO_EVER*LQ2_Q37_716
LQ2_MENO_EVER*LQ2_Q38_717

/missing;
run;

proc freq data=use ;
tables
hrt_npc_c*LQ2_HORM_EVER*LQ2_Q44_724;run;

proc univariate data=use noprint;
   histogram LQ2_Q36_710 LQ2_Q34_707 ;
where LQ2_MENO_EVER=1;
run;

proc univariate data=use noprint;
   histogram hrt_dur_me0 ;
where LQ2_MENO_EVER=1;
run;
*/

ods html close;ods _all_ close;ods html;
proc freq data=use ;
tables
nmeno_age*menostat
hmeno_age*menostat; run;

proc freq data=use ;
tables
LQ2_Q37_712
LQ2_Q37_713
LQ2_MENO_EVER
LQ2_Q38_717
menostat
LQ2_Q38_717*menostat; run;

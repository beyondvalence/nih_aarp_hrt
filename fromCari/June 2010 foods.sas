options nocenter yearcutoff=1900 errors=1;

title1 'Food groups in AARP';

proc format;
  value sexfmt 0 = 'Male'
               1 = 'Female';

**** Macro which reads in newest version of First Primary Cancer Analysis File;
%include '/prj/aarppublic/includes/first.primary.analysis.include.sas';


 (keep=westatid


entry_dt
                        f_dob
                        dod
                        raadate
                        entry_age
                        cancer
                        cancer_dxdt
                        cancer_seergroup
                        cancer_behv
                        cancer_dxconf
                        cancer_hist
                       
                        cancer_site
                        cancer_siterec3
                        cancer_dxdt
                        
                       
                        cancer_ss_stg
                      
                        underlyingcod_icd
                        cancer_tnmclint
                        cancer_tnmpatht
                        cancer_tnmclinn
                        cancer_tnmpathn
                        cancer_tnmclinm
                        cancer_tnmpathm

                        sex        
                        fl_proxy
                        self_prostate
                        self_breast
                        self_colon
                        self_other
                        health
                        renal
                      
                        calories
    					marriage 
						marstat
                        agecat
                        sex
                        bmi_cur
                        bmilev8_cur
                        ht_cur
                        educm educ
                        rel_1D_cancer
                        racem
                        menostat
                        hyststat
                        ovarystat
                        hormstat
                        horm_cur
                        hormever
                        physic
                        smoke_dose
                        smoke_ever
                        smoke_former
                        smoke_quit
                        smoke_quit_dose
                        alcohol
						selenium
						sup_selenium
						sup_iron
						iron
						Sup_VitAIU
						Sup_VitARE
						VitAActivity_NDSR
						VitaminAIU_CSFII
						VitaminARAE_CSFII
						mped_m_egg
						mped_m_fish_hi
						mped_m_fish_lo
						mped_m_frank
						mped_m_mpf
						mped_m_meat
						mped_m_nutsd
						mped_m_organ
						mped_m_poult
						mped_m_soy
						mped_redmeat
						mped_procmeat
						mped_a_beer
						mped_a_bev
						mped_a_liquor
						mped_a_wine
						mped_add_sug
						mped_d_milk
						mped_d_total
						mped_d_yogurt
						mped_discfat_oil
						mped_discfat_solid
						mped_g_nwhl
						mped_g_total
						mped_g_whl
						mped_legumes
mped_f_citmlb 
q27 q28a q28b q28c q29d q40g q40b q40c q30E1 
                        q42 q43 q44 q45 Q29A Q29C Q30A1 Q30A2 
						q18a6
						
mped_f_juice                                                                                                  
mped_f_nojuice mped_f_other mped_f_total mped_fruit_banana mped_fruit_cucur mped_fruit_grape                                                           
mped_fruit_rosac mped_fruit_rutac mped_fruit_veg_yellow mped_veg_cruc2 mped_veg_corn mped_veg_cheno 
mped_v_total mped_v_tomato mped_v_starcy mped_v_potato mped_v_other mped_v_orange 
mped_v_drkgr mped_whitemeat mped_veg_green_leafy mped_veg_legum 
mped_veg_lettuce mped_veg_solan mped_veg_sweet_potato mped_veg_umbel         

flav50_apigenin770
flav50_catechin749
flav50_catechin3795
flav50_cyanidin731
flav50_delphinidin741
flav50_epicatechin751
flav50_epicatechin752
flav50_epigallocatechin750
flav50_epigallocatechin753
flav50_eriodictyol758
flav50_gallocatechin794
flav50_hesperetin759
flav50_isorhamnetin785
flav50_kaempferol786
flav50_luteolin773
flav50_malvidin742
flav50_myricetin788
flav50_myricetin788
flav50_naringenin762
flav50_pelargonidin743
flav50_peonidin745
flav50_petunidin746
flav50_quercetin789
flav50_theaflavin755
flav50_theaflavin791
flav50_theaflavin792
flav50_theaflavin793
flav50_thearubigins756
isoflav50_daidzein710 
isoflav50_genistein711
isoflav50_glycitein712
isoflav50_coumestrol715
isoflav50_formononeti720
isoflav50_biochaninA721

diabetes
glycemicindex glycemicload

);

fam_cancer=REL_1D_CANCER;
****  Create exit date, exit age, and person years for First Primary Cancer;
  exit_dt = min(mdy(12,31,2006), cancer_dxdt, dod, raadate); *Chooses the earliest of 4 possible exit dates;
  exit_age = round(((exit_dt-f_dob)/365.25),.001);
  personyrs = round(((exit_dt-entry_dt)/365.25),.001);

**** Exclusions macro;
%include '/prj/aarppublic/macros/exclusions.first.primary.macro.sas';

**** Outbox macro for use with outliers;
%include '/prj/aarppublic/macros/outbox.macro.sas';

**** Quantile macro to create quintiles;
%include '/prj/aarppublic/macros/quantile.macro.sas';

****Table1 macro;
%include '/prj/aarppublic/macros/q5.table1.macro.sas' ;

**** Rename dataset;
data foods;
  set analysis;

proc datasets;
  delete analysis; *Delete large input file;

data foods;
  set foods;


thyroid=0; allthyroid=0; pap=0; foll=0; med=0; ana=0;

  if cancer=1 and cancer_behv=3 then do; 
  if cancer_seergroup = 33 and cancer_siterec3=32010 then Thyroid = 1;
  if endocrinecan=1 and endocrine_site in ('C739') then allthyroid=1;
  if thyroid =1 and cancer_hist in (8050, 8052, 8130, 8260, 8340, 8341, 8342, 8343, 8344, 8450, 8452) then pap=1; 
  if thyroid =1 and cancer_hist in (8290, 8330, 8331, 8332, 8335) then foll=1;
  if thyroid =1 and cancer_hist in (8345, 8346, 8510) then med=1;
  if thyroid =1 and cancer_hist in (8021) then ana=1;   

end;

label
thyroid = 'case status - thyroid cancer';

proc freq data=foods;
  table sex*cancer /list missing;
  format sex sexfmt.;
  title4 'Initial frequency of sex by first primary cancer status BEFORE exclusions';

**** Use the exclusion macro to make "standard" exclusions and get counts of excluded subjects;
/*brisa you can ask me about this macro if you need help adjusting it for your particular standard exclusions*/
%exclude(data            = foods,
         ex_proxy        = 1,
         ex_sex          = ,
         ex_selfprostate = 1,
         ex_selfbreast   = 1,
         ex_selfcolon    = 1,
         ex_selfother    = 1,
         ex_health       = 0,
         ex_renal        = 1,
         ex_prevcan      = 1,
         ex_deathcan     = 1);

proc freq data=foods;
  table sex*cancer /list missing;
  format sex sexfmt.;
  title4 'Frequency of sex by first primary cancer status AFTER standard exclusions';


**** Remove calorie outliers before other outliers are calculated.
**** Special SAS missing values are used in noout_ variables.
****      .L = value too low
****      .H = value too high;
%outbox(data     = foods,
        id       = westatid,
        by       = sex,
        comb_by  = ,
        var      = calories,
        cutoff1  = 3,
        cutoff2  = 2,
        keepzero = N,
        lambzero = Y,
        print    = N,
        step     = 0.01,
        addlog   = 0);

**** Delete special missing values by deleting noout_ values <= .Z;
data foods;
  set foods;
  if noout_calories <= .Z then delete;

data foods;
  set foods;


****Education;
  if  educm in (1,2)      then edu = 1; /*Less than 12 yrs*/
  else if educm = 3        then edu = 2; /*High school graduate*/
  else if educm = 4        then edu = 3; /*Some college*/
  else if educm = 5        then edu = 4; /*College graduate*/
  else if educm = 9 or educm = . then edu = 5 ; /*missing*/

  edu_1 = 0;
  edu_2 = 0;
  edu_3 = 0;
  edu_4 = 0;
  edu_5= 0;

  if      edu = 1 then edu_1 = 1; *Reference;
  else if edu = 2 then edu_2 = 1;
  else if edu = 3 then edu_3 = 1;
  else if edu =4 then edu_4 =1;
  else if edu = 5 then edu_5= 1;


****Marital Status;

  if marriage in (2,3,4,5) then marstatus = 0; *Not married;
  else if marriage = 1       then marstatus = 1; *Married;
  else if marriage =9         then marstatus=2; *missing;


  ****Physical activity;
  if physic in (0,1) then act = 1; *Never or Rarely;
  else if physic = 2 then act = 2; *1-3 time per month;
  else if physic = 3 then act = 3; *1-2 times per week;
  else if physic = 4 then act = 4; *3-4 times per week;
  else if physic = 5 then act = 5; *5 or more times per week;
  else if physic = 9 then act = 6; *Unknown;


  act_1 = 0;
  act_2 = 0;
  act_3 = 0;
  act_4 = 0;
  act_5 = 0;
  act_6 = 0;

  if      act = 1 then act_1 = 1; *Reference;
  else if act = 2 then act_2 = 1;
  else if act = 3 then act_3 = 1;
  else if act = 4 then act_4 = 1;
  else if act = 5 then act_5 = 1;
  else if act = 6 then act_6 = 1;


  ****Race;
  if      racem = 1 then rac = 1; *White;
  else if racem = 2 then rac = 2; *Black;
  else if racem  in (3,4) then rac = 3; *other;
  else if racem = 9 or racem = . then rac = 4; /*missing*/

  rac_1 = 0;
  rac_2 = 0;
  rac_3 = 0;
  rac_4 = 0;


  if      rac = 1 then rac_1 = 1; *Reference;
  else if rac = 2 then rac_2 = 1;
  else if rac = 3 then rac_3 = 1;
  else if rac= 4 then rac_4=  1;

***bmi;

if 0< bmi_cur <25 then bmicat=1;
   else if 25<=bmi_cur<30 then bmicat=2;
   else if 30<=bmi_cur<35 then bmicat=3;
   else if bmi_cur ge 35 then bmicat=4;
   else if bmi_cur = . then bmicat=5;

bmicat1= 0;
bmicat2=0;
bmicat3=0;
bmicat4=0;
bmicat5=0;

if bmicat=1 then bmicat1=1;
   else if bmicat=2 then bmicat2=1;
   else if bmicat=3 then bmicat3=1;
   else if bmicat=4 then bmicat4=1;
   else if bmicat=5 then bmicat5=1;



 /* family history*/

if fam_cancer= 0 then famhistory= 0; *no;
   else if fam_cancer=1 then famhistory=1; *yes;
   else if fam_cancer >1 then famhistory=2; *unknown/missing;

famhistory_0 =0;
famhistory_1  =0;
famhistory_2  =0;

if famhistory=0 then famhistory_0=1;
else if famhistory=1 then famhistory_1=1;
else if famhistory=2 then famhistory_2=1;

/* smoking 6 level variable- smoke quit dose*/

smkqd1=0; smkqd2=0; smkqd3=0; smkqd4=0; smkqd5=0; smkqd6=0;


  if smoke_quit_dose = 0 then smkqd1 = 1; /*never*/
    else if smoke_quit_dose = 1 then smkqd2 = 1; /*quit <=20 cg/d*/
    else if smoke_quit_dose = 2 then smkqd3 = 1; /*quit 20+ cg/d*/
    else if smoke_quit_dose = 3 then smkqd4 = 1; /*current <=20 cg/d*/
    else if smoke_quit_dose = 4 then smkqd5 = 1; /*current 20+ cg/d*/
    else if smoke_quit_dose = 9 then smkqd6 = 1; /*unknown*/





/*hormone replacement therapy use*/

hormstat0=0; hormstat1=0; hormstat2=0; hormstat3=0;
  if hormstat=0 then hormstat0=1;
  else if hormstat=1 then hormstat1=1;
  else if hormstat=2 then hormstat2=1;
  else if hormstat>2 then hormstat3=1; *missing/unknown;




if sex = 0 or 1 then output foods;






libname thyroid '/home/meinholc/thyroid';

data thyroid.foods6182010; set foods; 
run;

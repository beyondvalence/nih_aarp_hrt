/***************************************************************************************/
/* Program: /prj/aarppublic/macros/exclusions.all.cancer.risk.macro.sas                */
/* Created: February 2006                                                              */
/* Updated:                                                                            */
/***************************************************************************************/


/***************************************************************************************/
/*                                                                                     */
/*  Use the exclusion macro to make "standard" exclusions and get counts of            */
/*  excluded subjects.  Each parameter excludes subjects with that condition.          */
/*                                                                                     */
/*  The macro must be included with the statement:                                     */
/*  %include '/prj/aarppublic/macros/exclusions.all.cancer.risk.macro.sas';            */
/*                                                                                     */
/*  Then the macro could be called with any or all of the following parameters:        */
/*                                                                                     */
/*  data            = name of SAS dataset containing the analysis cohort data          */
/*  ex_proxy        = remove proxy (Box B) respondents (default=yes)                   */
/*  ex_rf_proxy     = remove RFQ proxy (RFQ Box B) respondents (default=yes)           */
/*  ex_sex          = remove specific gender (0=male, 1=female - default=keep both)    */
/*  ex_selfother**  = remove self-reported other cancer* on baseline qx (default=no)   */
/*  ex_rf_selfbreast= remove self-reported breast cancer on RFQ (default=no)           */
/*  ex_rf_selfovary = remove self-reported ovarian cancer on RFQ (default=no)          */
/*  ex_health       = remove self-reported poor health on baseline qx  (default=no)    */
/*  ex_prevCOI      = remove prevalent COI (give case variable name if yes, blank if no)  */   
/*  ex_deathCOI     = remove death only reports of COI (give case variable name if yes)   */   
/*  ex_prevcan      = remove subjects with any* prevalent cancer (yes/no)  (default=yes)  */                          
/*  ex_deathcan     = remove subjects with death only reports of any* cancer(default=no)  */ 
/*         * any cancer does not include non-melanoma skin cancers                     */
/*                                                                                     */
/*        ** Note: subjects with Baseline self reports of prostate, breast, and colon  */
/*           cancer were not sent RFQ's, so these exclusions are not present here      */
/*                                                                                     */
/*  An example run of the macro would be:                                              */
/*  %exclude(data            = analysis,                                               */
/*           ex_proxy        = 1,                                                      */
/*           ex_rf_proxy     = 1,                                                      */
/*           ex_sex          = 1,                                                      */
/*           ex_selfother    = 1,                                                      */
/*           ex_rf_selfbreast= 1,                                                      */
/*           ex_rf_selfovary = 1,                                                      */
/*           ex_prevCOI      = remove prevalent COI (give case variable name if yes, blank if no) */   
/*           ex_deathCOI     = remove death only reports of COI (give case variable name if yes)  */   
/*           ex_health       = 1,                                                      */
/*           ex_prevcan      = 1,                                                      */
/*           ex_deathcan     = 1);                                                     */
/*                                                                                     */
/*                                                                                     */
/*   NOTE:  The following variables must be KEPT in your dataset prior to running      */
/*          the Exclusions Macro:                                                      */
/*          westatid                                                                   */
/*          rf_personyrs                                                               */
/*          rf_entry_dt                                                                */
/*          exit_dt                                                                    */
/*          cancer                                                                     */
/*          cancer_dxdt                                                                */
/*                                                                                     */
/*          To make certain exclusions work, certain other variables must be KEPT:     */
/*               EXCLUSION                NECESSARY VARIABLE                           */
/*               ex_proxy        = 1          fl_proxy                                 */
/*               ex_rf_proxy     = 1          fl_rf_proxy                              */
/*               ex_sex          = 1          sex                                      */
/*               ex_selfother    = 1          self_other                               */
/*               ex_rf_selfbreast= 1          rf_Q23_2_1A                              */
/*               ex_rf_selfovary = 1          rf_Q23_2_2A                              */
/*               ex_health       = 1          health                                   */
/*                                                                                     */
/*                                                                                     */
/***************************************************************************************/
            
            
            
%macro exclude(data            = ,
               ex_proxy        = 1,
               ex_rf_proxy     = 1,
               ex_sex          = ,
               ex_selfother    = 0,
               ex_rf_selfbreast= 0,
               ex_rf_selfovary = 0,
               ex_health       = 0,
               ex_prevCOI      = ,
               ex_deathCOI     = ,
               ex_prevcan      = 1,
               ex_deathcan     = 0);

proc format;
  value exflagf
    2 = 'Proxy (Box B) exclusion'
    2.5='RFQ Proxy (RFQ Box B) exclusion'
    3 = 'Sex exclusion'
    7 = 'Self-reported other cancer on Baseline Qx' 
    7.1='Self-reported breast cancer on RFQ  '
    7.2='Self-reported ovarian cancer on RFQ'
    8 = 'Self-reported poor health on Baseline Qx'  
   10 = 'Cancer of Interest dx before entry'
   11 = 'Death only for Cancer of Interest'
   12 = 'Any cancer dx before RFQ entry'
   13 = 'Death only for any cancer'
   14 = 'RF_personyrs < 0 - determine problem';

data &data exclusions;
  set &data;
  
/************************************************************************************/ 
/************************************************************************************/
/*         Exclude proxy (Box B) respondents                                        */
  %if &ex_proxy = 1 %then %do;
     if fl_proxy = 1 then do;
        ex_flag = 2;
        output exclusions;
     end;
  %end;

  %else %if &ex_proxy = 0 %then %do;
     if 0 then do;
     end;
  %end;

   
/************************************************************************************/
/*         Exclude RFQ proxy (RFQ Box B) respondents                                */
  %if &ex_rf_proxy = 1 %then %do;
     else if fl_rf_proxy = 1 then do;
        ex_flag = 2.5;
        output exclusions;
     end;
  %end;
   
/************************************************************************************/

/*         Limit analysis for gender-specific cancers                               */
  %if &ex_sex ne %str() %then %do;
     else if sex=&ex_sex then do;           /*  exclude 0=males, 1=females  */
        ex_flag=3;
        output exclusions; 
     end;
  %end;           

/************************************************************************************/
/*         Exclude self-reported health problems reported on baseline questionnaire */
/*         These exclusions mimic exclusions that were formerly done in DietAARP    */
/*         Note that Baseline self reports of prostate, breast, and colon           */
/*         were not sent RFQ's, so these exclusions are not present here            */
/*   exclude subjects with one of the four self-reported cancers on the baseline qx */
  
  %if &ex_selfother = 1 %then %do;
     else if self_other = 1 then do;
        ex_flag=7;
        output exclusions;
     end;
  %end;
  %if &ex_rf_selfbreast = 1 %then %do;
     else if rf_Q23_2_1A = "1" then do;
        ex_flag=7.1;
        output exclusions;
     end;
  %end;
  %if &ex_rf_selfovary = 1 %then %do;
     else if rf_Q23_2_2A = "1" then do;
        ex_flag=7.2;
        output exclusions;
     end;
  %end;




/*   exclude poor health reported on baseline qx         */
  %if &ex_health = 1 %then %do;
     else if health = 5 then do;       /* poor health */
        ex_flag=8;
        output exclusions;
     end;
  %end;   

/************************************************************************************/
/*         exclude cancers of interest before baseline                            */
  %if &ex_prevCOI ne %str() %then %do;
     else if &ex_prevCOI in (4,9) then do;
        ex_flag=10;
        output exclusions;
     end;
  %end;
  
/************************************************************************************/
/*         exclude "death only report" of cancer of interest                        */
  %if &ex_deathCOI ne %str() %then %do;
     else if &ex_deathCOI in (2,8) and .<dod<=mdy(12,31,2006) then do;
        ex_flag=11;
        output exclusions;
     end;
  %end;
    
/************************************************************************************/
/*         exclude any diagnosis before baseline                                  */
/* Note, there are no cancer=1 subjects with cancer_dxdt < rf_entry_dt--they are changed to cancer=4*/
  %if &ex_prevcan=1 %then %do;
     else if cancer in (1,4,9) and .Z < cancer_dxdt < rf_entry_dt then do;  
        ex_flag=12;
        output exclusions;
     end;     
  %end;                       

/************************************************************************************/
/*         exclude subjects with death only report of any cancer                    */
  %if &ex_deathcan=1 %then %do;
      else if cancer in (2,8) and .<dod<=mdy(12,31,2006) then do;
         ex_flag=13; 
         output exclusions;  
      end;
  %end;                                       

/************************************************************************************/
/*         exclude any subject with person-years < 0                                */
/*         This exclusion is only a precaution and should NOT exclude anyone        */
/*         - if it does, check your code to find out why                            */
  else if rf_personyrs < 0 then do;
     ex_flag=14;
     output exclusions;
  end;
  
  else output &data;
  
run;
  
proc freq data=exclusions;
  tables ex_flag;
  format ex_flag exflagf.;
  title4 'Exclusions made from original cohort';

proc sort data=exclusions;
  by rf_personyrs;
    
proc print data=exclusions;
  where ex_flag=14;
  var westatid rf_personyrs rf_entry_dt exit_dt  cancer cancer_dxdt;
  format rf_entry_dt exit_dt cancer_dxdt mmddyy10.;
  title4 'Subjects excluded for rf_personyrs < 0 - determine problem';



 data _null_;
 title4;
 
%mend;
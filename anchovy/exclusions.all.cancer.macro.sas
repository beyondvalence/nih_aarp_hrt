/***************************************************************************************/
/* Program: /prj/aarppublic/macros/exclusions.all.cancer.macro.sas                     */
/* Created: 14feb06                                                                    */

/***************************************************************************************/


/***************************************************************************************/
/*                                                                                     */
/*  Use the exclusion macro to make "standard" exclusions and get counts of            */
/*  excluded subjects.  Each parameter excludes subjects with that condition.          */
/*                                                                                     */
/*  The macro must be included with the statement:                                     */
/*  %include '/prj/aarppublic/macros/exclusions.all.cancer.macro.sas';                 */
/*                                                                                     */
/*  Then the macro could be called with any or all of the following parameters:        */
/*                                                                                     */
/*  data            = name of SAS dataset containing the analysis cohort data          */
/*  ex_proxy        = remove proxy (Box B) respondents (default=yes)                   */
/*  ex_sex          = remove specific gender (0=male, 1=female - default=keep both)    */
/*  ex_selfprostate = remove self-reported prostate cancer on baseline qx (default=no) */
/*  ex_selfbreast   = remove self-reported breast cancer on baseline qx (default=no)   */
/*  ex_selfcolon    = remove self-reported colon cancer on baseline qx (default=no)    */
/*  ex_selfother    = remove self-reported other cancer* on baseline qx (default=no)   */
/*  ex_health       = remove self-reported poor health on baseline qx  (default=no)    */
/*  ex_renal        = remove self-reported end-stage renal disease (default=no)        */           
/*  ex_prevCOI     =  remove prevalent COI (give case variable name if yes, blank if no) */   
/*  ex_deathCOI     = remove death only reports of COI (give case variable name if yes)  */   
/*  ex_prevcan      = remove subjects with any* prevalent cancer (yes/no)  (default=no)  */                          
/*  ex_deathcan     = remove subjects with death only reports of any* cancer(default=no) */ 
/*         * any cancer does not include non-melanoma skin cancers                     */
/*                                                                                     */
/*  To run this macro, first include it with the statement:                            */
/*  %include '/prj/aarppublic/macros/exclusions.all.cancer.macro.sas';                 */
/*                                                                                     */
/*  Then an example run of the macro would be:                                         */
/*  %exclude(data            = core,                                                   */
/*           ex_proxy        = 1,                                                      */
/*           ex_sex          = 1,                                                      */
/*           ex_selfprostate = 1,                                                      */
/*           ex_selfbreast   = 1,                                                      */
/*           ex_selfcolon    = 1,                                                      */
/*           ex_selfother    = 1,                                                      */
/*           ex_health       = 1,                                                      */
/*           ex_renal        = 1,                                                      */
/*           ex_prevCOI      = breastcan,                                              */
/*           ex_deathCOI     = breastcan,                                              */
/*           ex_prevcan      = 1,                                                      */
/*           ex_deathcan     = 1);                                                     */
/*                                                                                     */
/*                                                                                     */
/*   NOTE:  The following variables must be KEPT in your dataset prior to running      */
/*          the Exclusions Macro:                                                      */
/*          westatid                                                                   */
/*          personyrs                                                                  */
/*          dod                                                                        */
/*          raadate                                                                    */
/*          entry_dt                                                                   */
/*          exit_dt                                                                    */
/*          cancer                                                                     */
/*          cancer_dxdt                                                                */
/*                                                                                     */
/*          To make certain exclusions work, certain other variables must be KEPT:     */
/*               EXCLUSION                NECESSARY VARIABLE                           */
/*               ex_proxy        = 1          fl_proxy                                 */
/*               ex_sex          = 1          sex                                      */
/*               ex_selfprostate = 1          self_prostate                            */
/*               ex_selfbreast   = 1          self_breast                              */
/*               ex_selfcolon    = 1          self_colon                               */
/*               ex_selfother    = 1          self_other                               */
/*               ex_health       = 1          health                                   */
/*               ex_renal        = 1          renal                                    */
/*                                                                                     */
/*                                                                                     */
/***************************************************************************************/



%macro exclude(data            = ,
               ex_proxy        = 1,
               ex_sex          = ,
               ex_selfbreast   = 0,
               ex_selfcolon    = 0,
               ex_selfprostate = 0,
               ex_selfother    = 0,
               ex_health       = 0,
               ex_renal        = 0,
               ex_prevCOI      = ,
               ex_deathCOI     = ,
               ex_prevcan      = 0,
               ex_deathcan     = 0);

proc format;
  value exflagf
    2 = 'Proxy (Box B) exclusion'
    3 = 'Sex exclusion'
    4 = 'Self-reported prostate cancer on Baseline Qx' 
    5 = 'Self-reported breast cancer on Baseline Qx' 
    6 = 'Self-reported colon cancer on Baseline Qx' 
    7 = 'Self-reported other cancer on Baseline Qx' 
    8 = 'Self-reported poor health on Baseline Qx' 
    9 = 'Self-reported end-stage renal disease on Baseline Qx' 
   10 = 'Cancer of Interest dx before entry'
   11 = 'Death only for Cancer of Interest'
   12 = 'Any cancer dx before entry'
   13 = 'Death only for any cancer'
   14 = 'Personyrs < 0 - determine problem';
run;

data &data exclusions;
  set &data;
  
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

/*   exclude subjects with one of the four self-reported cancers on the baseline qx */

  %if &ex_selfprostate = 1 %then %do;                
     else if self_prostate = 1 then do;              
        ex_flag=4;                                   
        output exclusions;                           
     end;                                            
  %end;                                              
                                                   
  %if &ex_selfbreast = 1 %then %do;
     else if self_breast = 1 then do;
        ex_flag=5;
        output exclusions;
     end;
  %end;
  
  %if &ex_selfcolon = 1 %then %do;
     else if self_colon = 1 then do;
        ex_flag=6;
        output exclusions;
     end;
  %end;
    
  %if &ex_selfother = 1 %then %do;
     else if self_other = 1 then do;
        ex_flag=7;
        output exclusions;
     end;
  %end;


/*   exclude poor health or end-stage renal disease reported on baseline qx         */
  %if &ex_health = 1 %then %do;
     else if health = 5 then do;       /* poor health */
        ex_flag=8;
        output exclusions;
     end;
  %end;   
    
  %if &ex_renal = 1 %then %do;
     else if renal = 1 then do;       /* end-stage renal disease */
        ex_flag=9;
        output exclusions;
     end;
  %end;       


/************************************************************************************/
/*         exclude cancers of interest before baseline                            */
  %if &ex_prevCOI ne %str() %then %do;
     else if &ex_prevCOI in(4,9) then do;
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
  %if &ex_prevcan=1 %then %do;
     else if cancer in (4,9) then do;  
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
  else if personyrs < 0 then do;
     ex_flag=14;
     output exclusions;
  end;

  else output &data;
  
run;
  
proc freq data=exclusions;
  tables ex_flag;
  format ex_flag exflagf.;
  title4 'Exclusions made from original cohort';
run;

proc sort data=exclusions;
  by personyrs;
run;
    
proc print data=exclusions;
  where ex_flag=14;
  var westatid personyrs &ex_prevCOI &ex_deathCOI entry_dt exit_dt  cancer cancer_dxdt;
  format entry_dt exit_dt cancer_dxdt mmddyy10.;
  title4 'Subjects excluded for personyrs < 0 - determine problem';
run;


data _null_;
 title4;
run;

%mend;
/********************************************************************************************************/
/*   Filename: /prj/aarppublic/examples/sample.first.primary.program.begin.sas                          */
/*   Created:  11/14/05                                                                                 */
/*   Purpose:  To include first primary analysis file, keep necessary variables, and perform exclusions */
/*                                                                                                      */
/********************************************************************************************************/

/********************************************************************************************************/
/*                                                                                                      */
/*   Sample code to include first primary analysis file, keep necessary variables,                      */
/*   and perform exclusions with the first primary exclusion macro                                      */
/*                                                                                                      */
/*   ***IMPORTANT!***                                                                                   */  
/*   Please note that the only change that can be made in the next section of code is the addition      */  
/*   of variables to the keep statement.  Any other change may crash the program and/or                 */  
/*   alter the SAS library.                                                                               */
/********************************************************************************************************/


title1 "DietAARP First Primary Cancer Analysis file";
title2 "Baseline Cohort";


%include '/prj/aarppublic/includes/first.primary.analysis.include.sas';
/****** DO NOT INSERT ANY CODE HERE                                                *****/
(keep=westatid entry_dt f_dob dod raadate cancer cancer_dxdt fl_proxy sex self_prostate
                    self_breast self_colon self_other health renal);

/***************************************************************************************/
/*  Create exit date, exit age, and person years for First Primary Cancer              */
/*                                                                                     */
/***************************************************************************************/
  exit_dt=min(mdy(12,31,2006), cancer_dxdt, dod, raadate); /*Chooses the earliest of 4 possible exit dates*/
  personyrs=round(((exit_dt-entry_dt)/365.25),.001);
  exit_age=entry_age+personyrs;



/***************************************************************************************/ 
/*   Implement first primary cancer exclusion macro:                                   */
/*   (code below is copied from the first primary exclusion macro)                     */
/*                                                                                     */             
/*                                                                                     */             
/* Program: /prj/aarppublic/macros/exclusions.first.primary.macro.sas                  */
/* Created: November 2005                                                              */
/* Updated:                                                                            */
/***************************************************************************************/


/***************************************************************************************/
/*                                                                                     */
/*  Use the exclusion macro to make "standard" exclusions and get counts of            */
/*  excluded subjects.  Each parameter excludes subjects with that condition.          */
/*                                                                                     */
/*  The macro must be included with the statement:                                     */
/*  %include '/prj/aarppublic/macros/exclusions.first.primary.macro.sas';              */
/*                                                                                     */
/*  Then the macro could be called with any or all of the following parameters:        */
/*                                                                                     */
/*  data            = name of SAS dataset containing the analysis cohort data          */
/*  ex_proxy        = remove proxy (Box B) respondents (default=yes)                   */
/*  ex_sex          = remove specific gender (0=male, 1=female - default=keep both)    */
/*  ex_selfprostate = remove self-reported prostate cancer on baseline qx (default=no) */
/*  ex_selfbreast   = remove self-reported breast cancer on baseline qx (default=no)   */
/*  ex_selfcolon    = remove self-reported colon cancer on baseline qx (default=no)    */
/*  ex_selfother    = remove self-reported other cancer on baseline qx (default=no)    */
/*  ex_health       = remove self-reported poor health on baseline qx  (default=no)    */
/*  ex_renal        = remove self-reported end-stage renal disease (default=no)        */             
/*  ex_prevcan      = remove subjects with any* prevalent cancer (yes/no)  (default=yes)  */                          
/*  ex_deathcan     = remove subjects with death only reports of any* cancer(default=no) */ 
/*         * any cancer does not include non-melanoma skin cancers                     */
/*                                                                                     */
/*                                                                                     */
/*  An example run of the macro would be:                                              */
/*  %exclude(data            = analysis,                                                   */
/*           ex_proxy        = 1,                                                      */
/*           ex_sex          = 1,                                                      */
/*           ex_selfprostate = 1,                                                      */
/*           ex_selfbreast   = 1,                                                      */
/*           ex_selfcolon    = 1,                                                      */
/*           ex_selfother    = 1,                                                      */
/*           ex_health       = 1,                                                      */
/*           ex_renal        = 1,                                                      */
/*           ex_prevcan      = 1,                                                      */
/*           ex_deathcan     = 1);                                                     */
/*                                                                                     */
/*                                                                                     */
/*   NOTE:  The following variables must be KEPT in your dataset prior to running      */
/*          the Exclusions Macro:                                                      */
/*          westatid                                                                   */
/*          personyrs                                                                  */
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
            


%include '/prj/aarppublic/macros/exclusions.first.primary.macro.sas'; 

%exclude(data            = analysis,
         ex_proxy        = 1,
         ex_sex          = 1,
         ex_selfprostate = 1,
         ex_selfbreast   = 1,
         ex_selfcolon    = 1,
         ex_selfother    = 1,
         ex_health       = 1,
         ex_renal        = 1,
         ex_prevcan      = 1,
         ex_deathcan     = 1);


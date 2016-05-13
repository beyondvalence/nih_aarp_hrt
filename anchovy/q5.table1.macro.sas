
/******************************************************************************
* FILENAME:   /prj/aarppublic/macros/q5.table1.macro.sas                      *
* PROGRAMMER: STEPHANIE WEINSTEIN                                             *
* DATE:       NOV 19, 2004                                                    *
*                                                                             *
* PURPOSE:    THIS FILE HAS CODE TO CREATE THE TABLE 1 DATA BY QUANTILE OF    *
              A VARIABLE SIMPLY BY MEANS AND FREQUENCIES, NO AGE-ADJUSTMENT   *
*                                                                             *
*             SUGGESTIONS ON WAYS TO AGE-ADJUST ARE INCLUDED                  *
*                                                                             *
* &DATASET  IS THE NAME OF YOUR DATA                                          *
* &TABLEVAR IS THE VARIABLE YOU ARE FINDING THE MEAN FOR, FOR EXAMPLE,        *
*           AGE, SMOKING, EDUCATION, KCAL ETC.                                *
* &CLASSVAR IS THE VARIABLE YOU HAVE CLASSIFIED INTO QUANTILES                *
*           (CREATED FROM THE QUANTILE MACRO)                                 *
* &CLASSVARM IS THE MEDIAN FOR EACH QUANTILE, CREATED FROM THE QUANTILE MACRO *
*                                                                             *
* THERE ARE DIFFERENT METHODS IF THE OUTCOME VARIABLE IS CONTINUOUS OR        *
* CATEGORICAL:                                                                *
*    USE %TABLE1 FOR CONTINUOUS VARIABLES OR CATEGORICAL VARIABLES            *
*        THAT ARE ORDINAL AND MORE THAN TWO LEVELS.                           *
*    USE %CATEGORY FOR CATEGORICAL VARIABLES.                                 *
*                                                                             *
* BASED ON EMAIL BY DOUG MIDTHUNE TO DIETAARP-L ON NOV 19                     *
*                                                                             *
* To run either of these two macros, first include them with the statement:   * 
*     %include '/prj/aarppublic/macros/q5.table1.macro.sas';                  * 
*                                                                             * 
* Then example runs of the two macros included here would be:                 * 
*     %TABLE1 (COHORT01, BMI, Q5SFOL, Q5SFOLM);                               * 
*     %CATEGORY (COHORT01, MARRIED, Q5SFOL);                                  *
*                                                                             *
*******************************************************************************/

/*THE MACRO "TABLE1" IS FOR CONTINUOUS VARIABLES OR CATEGORICAL VARIABLES THAT ARE ORDINAL AND MORE THAN TWO LEVELS*/

/*USING PROC MEANS INSTEAD OF PROC GLM IN ORDER TO GET THE STANDARD ERRORS*/

%MACRO TABLE1 (DATASET, TABLEVAR, CLASSVAR, CLASSVARM);
PROC MEANS DATA=&DATASET N MEAN STDERR MIN MAX;
VAR &TABLEVAR;
CLASS &CLASSVAR;
RUN;

/*  NOTE: YOU CAN USE PROC GLM INSTEAD, IT GIVES THE SAME MEANS BUT NO STANDARD ERRORS*/
/*
PROC GLM DATA=&DATASET;
CLASS &CLASSVAR;
MODEL &TABLEVAR=&CLASSVAR ;
LSMEANS &CLASSVAR;
RUN;
*/

/*TREND TEST USES PROC GLM*/
PROC GLM DATA=&DATASET;
MODEL &TABLEVAR=&CLASSVARM ;
RUN;
QUIT;
%MEND TABLE1;


/*THE MACRO "CATEGORY" IS FOR CATEGORICAL VARIABLES*/
%MACRO CATEGORY (DATASET, TABLEVAR, CLASSVAR);
PROC FREQ DATA=&DATASET;
TABLES &TABLEVAR*&CLASSVAR / TREND;  /*THIS USES THE COCHRAN-ARMITAGE TEST FOR LINEARITY OF OBSERVED PROPORTIONS*/
RUN;
%MEND CATEGORY;
/*NOTE: TO CALCULATE STANDARD ERRORS FOR CATEGORICAL VARIABLES, BASED ON BERNOULLI ASSUMPTIONS, USE: SQUARE ROOT OF p*(1-p/n)*/



/******************************************************************************************/
/*         EXAMPLES OF RUNNING THE MACROS                                                 */
/*                                                                                        */   
/*         %TABLE1 (COHORT01, BMI, Q5SFOL, Q5SFOLM);                                      */
/*         %CATEGORY (COHORT01, MARRIED, Q5SFOL);                                         */
/*                                                                                        */
/******************************************************************************************/


/*************************
* TO ADJUST FOR AGE      *
**************************/

/*TO ADJUST FOR AGE, HERE IS WHAT DOUG AND VICTOR RECOMMEND:

"WHEN DOING AGE-ADJUSTMENT FOR EITHER CONTINUOUS OR 0/1 VARIABLES, WE WOULD RECOMMEND TO AGE-ADJUST THE MAIN EXPOSURE AS A CONTINUOUS VARIABLE
(AGE COULD BE EITHER CONTINUOUS OR CATEGORIZED), CATEGORIZE THE RESIDUAL INTO QUINTILES AND THEN APPLY THE SAME PROCEDURES AS ABOVE.  THE
DELICATE QUESTIONS HERE IS WHAT SCALE TO USE WHEN CALCULATING THE LINEAR REGRESSION OF THE MAIN EXPOSURE ON AGE."

*/




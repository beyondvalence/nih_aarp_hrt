/***************************************************************************************/ 
/*   Baseline exclusions:                                                              */
/***************************************************************************************/      
%exclude(data          =analysis,
         ex_proxy       =1,
         ex_sex         =,
         ex_selfprostate=1,
         ex_selfbreast  =1,
         ex_selfcolon   =1,
         ex_selfother   =1,
         ex_health      =,
         ex_renal       =0,
         ex_prevcan     =1,
         ex_deathcan    =1);

/***************************************************************************************/ 
/*   Exclude if not 'non-Hispanic White'                                               */
/***************************************************************************************/      
data analysis excl_race;
   set analysis;
   if racem in (2,3,4,9) then output excl_race;
   else output analysis;
run;

/***************************************************************************************/ 
/*   Exclude if 'no info on coffee use'                                                */
/***************************************************************************************/      
data analysis excl_misscoffee;
   set analysis;
   if qp12b in ('E','M','') then output excl_misscoffee;
   else output analysis;
run;

proc sort data=analysis;
   by sex;
run;

/***************************************************************************************/ 
/*   Exclude if low or high caloric consumption                                        */
/***************************************************************************************/      
* Define outliers for total energy;
%outbox(data     = analysis,
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

data analysis excl_kcal;
   set analysis;
   if noout_calories <= .z  then output excl_kcal;
   else output analysis;
run;


/***************************************************************************************/ 
/*   Exclude if person-years = 0                                                       */
/***************************************************************************************/      
data analysis excl_py_zero;
   set analysis;
   if personyrs <= 0 then output excl_py_zero;
   else output analysis;
run;


output:

est Contents                                                                                                  10:50 Wednesday, December 4, 2013   1

The CONTENTS Procedure

Data Set Name        WORK.AARP                                                Observations          565709
Member Type          DATA                                                     Variables             19    
Engine               V9                                                       Indexes               0     
Created              Wed, Dec 04, 2013 10:55:28 AM                            Observation Length    160   
Last Modified        Wed, Dec 04, 2013 10:55:28 AM                            Deleted Observations  0     
Protection                                                                    Compressed            NO    
Data Set Type                                                                 Sorted                YES   
Label                                                                                                     
Data Representation  SOLARIS_X86_64, LINUX_X86_64, ALPHA_TRU64, LINUX_IA64                                
Encoding             latin1  Western (ISO)                                                                


Exclusions made from original cohort

The FREQ Procedure

                                                                                 Cumulative    Cumulative
                                             EX_FLAG    Frequency     Percent     Frequency      Percent
---------------------------------------------------------------------------------------------------------
Proxy (Box B) exclusion                                    15760       22.73         15760        22.73  
Self-reported prostate cancer on Baseline Qx               10640       15.34         26400        38.07  
Self-reported breast cancer on Baseline Qx                 10875       15.68         37275        53.75  
Self-reported colon cancer on Baseline Qx                   4584        6.61         41859        60.36  
Self-reported other cancer on Baseline Qx                  23219       33.48         65078        93.84  
Any cancer dx before entry                                  1916        2.76         66994        96.60  
Death only for any cancer                                   2354        3.39         69348       100.00  
Personyrs < 0 - determine problem                              1        0.00         69349       100.00  
_Test Contents                                                                                                  10:50 Wednesday, December 4, 2013   3


*subjects excluded if race other than NHW, no coffee data


Step 1: Initial Removal of Outliers (Untransformed Data)

Quartiles of Sample Distributions

Sex=0

The MEANS Procedure

                    Analysis Variable : CALORIES Food energy - kcal

                                 Lower                           Upper
     N         Minimum        Quartile          Median        Quartile         Maximum
--------------------------------------------------------------------------------------
272722      39.8700000         1443.64         1875.74         2426.88        65822.84
--------------------------------------------------------------------------------------


Sex=1

                    Analysis Variable : CALORIES Food energy - kcal

                                 Lower                           Upper
     N         Minimum        Quartile          Median        Quartile         Maximum
--------------------------------------------------------------------------------------
177947      67.4000000         1119.35         1455.07         1878.32        50534.94
--------------------------------------------------------------------------------------
_Test Contents                                                                                                  10:50 Wednesday, December 4, 2013   5


Step 1: Initial Removal of Outliers (Untransformed Data)

Outlier Cutoff Values: min = Q1 - 3*(Q3-Q1), max = Q3 + 3*(Q3-Q1)

Sex=0

The MEANS Procedure

Analysis Variable : CALORIES 
 
     Minimum         Maximum
----------------------------
    -1506.08         5376.60
----------------------------


Sex=1

Analysis Variable : CALORIES 
 
     Minimum         Maximum
----------------------------
    -1157.56         4155.23
----------------------------
_Test Contents                                                                                                  10:50 Wednesday, December 4, 2013   6


Step 1: Initial Removal of Outliers (Untransformed Data)

Number of Outliers

Sex=0 TYPE_OUTLIER=< Minimum

The MEANS Procedure

Analysis Variable : CALORIES Food energy - kcal

   N
----
   0
----


Sex=0 TYPE_OUTLIER=> Maximum

Analysis Variable : CALORIES Food energy - kcal

   N
----
2948
----


Sex=0 TYPE_OUTLIER=Either

Analysis Variable : CALORIES Food energy - kcal

   N
----
2948
----


Sex=1 TYPE_OUTLIER=< Minimum

Analysis Variable : CALORIES Food energy - kcal

   N
----
   0
----


Sex=1 TYPE_OUTLIER=> Maximum

Analysis Variable : CALORIES Food energy - kcal

   N
----
1480
----


_Test Contents                                                                                                  10:50 Wednesday, December 4, 2013   7


Step 1: Initial Removal of Outliers (Untransformed Data)

Number of Outliers

Sex=1 TYPE_OUTLIER=Either

The MEANS Procedure

Analysis Variable : CALORIES Food energy - kcal

   N
----
1480
----
_Test Contents                                                                                                  10:50 Wednesday, December 4, 2013   8


Step 2: Find Best Box-Cox Transformation After Initial Removal of Outliers

Lambdas that Maximize the Shapiro-Wilk Statistic

SEX    LAMBDA1

0     0.15000
1     0.18000
_Test Contents                                                                                                  10:50 Wednesday, December 4, 2013   9


Step 4: Final Removal of Outliers (Box-Cox Transformed Data)

Quartiles of Sample Distributions

Sex=0 LAMBDA_CALORIES=0.15

The MEANS Procedure

                         Analysis Variable : BOXCOX_CALORIES 
 
                                 Lower                           Upper
     N         Minimum        Quartile          Median        Quartile         Maximum
--------------------------------------------------------------------------------------
272722       4.9212583      13.1863989      13.9816493      14.7951256      28.5432692
--------------------------------------------------------------------------------------


Sex=1 LAMBDA_CALORIES=0.18

                         Analysis Variable : BOXCOX_CALORIES 
 
                                 Lower                           Upper
     N         Minimum        Quartile          Median        Quartile         Maximum
--------------------------------------------------------------------------------------
177947       6.2990273      14.1025362      15.0529545      16.0221876      33.4722390
--------------------------------------------------------------------------------------
_Test Contents                                                                                                  10:50 Wednesday, December 4, 2013  10


Step 4: Final Removal of Outliers (Box-Cox Transformed Data)

Outlier Cutoff Values: min = Q1 - 2*(Q3-Q1), max = Q3 + 2*(Q3-Q1)

Sex=0 LAMBDA_CALORIES=0.15

The MEANS Procedure

Analysis Variable : BOXCOX_CALORIES 
 
     Minimum         Maximum
----------------------------
   9.9689456      18.0125789
----------------------------


Sex=1 LAMBDA_CALORIES=0.18

Analysis Variable : BOXCOX_CALORIES 
 
     Minimum         Maximum
----------------------------
  10.2632333      19.8614905
----------------------------
_Test Contents                                                                                                  10:50 Wednesday, December 4, 2013  11


Step 4: Final Removal of Outliers (Box-Cox Transformed Data)

Number of Outliers

Sex=0 LAMBDA_CALORIES=0.15 TYPE_OUTLIER=< Minimum

The MEANS Procedure

Analysis Variable : BOXCOX_CALORIES 
 
   N
----
462
----


Sex=0 LAMBDA_CALORIES=0.15 TYPE_OUTLIER=> Maximum

Analysis Variable : BOXCOX_CALORIES 
 
   N
----
1568
----


Sex=0 LAMBDA_CALORIES=0.15 TYPE_OUTLIER=Either

Analysis Variable : BOXCOX_CALORIES 
 
   N
----
2030
----


Sex=1 LAMBDA_CALORIES=0.18 TYPE_OUTLIER=< Minimum

Analysis Variable : BOXCOX_CALORIES 
 
   N
----
346
----


Sex=1 LAMBDA_CALORIES=0.18 TYPE_OUTLIER=> Maximum

Analysis Variable : BOXCOX_CALORIES 
 
   N
----
907
----


_Test Contents                                                                                                  10:50 Wednesday, December 4, 2013  12


Step 4: Final Removal of Outliers (Box-Cox Transformed Data)

Number of Outliers

Sex=1 LAMBDA_CALORIES=0.18 TYPE_OUTLIER=Either

The MEANS Procedure

Analysis Variable : BOXCOX_CALORIES 
 
   N
----
1253
----

/************************************************************/
/*  program: /prj/aarppublic/macros/outbox.macro.sas        */
/*  author: Doug Midthune                                   */
/*  created: 7/2004                                         */
/*  updated: 11/2004 to keep all zero values                */
/*           2/2005  to deal with zero lambdas              */
/************************************************************/

/***********************************************************
 *                                                          *
 * Macro OUTBOX -                                           *
 *                                                          *
 * Macro OUTBOX removes outliers of a continuous variable   *
 * after Box-Cox transforming the variable to approximate   *
 * a normal distribution.                                   *
 *                                                          *
 * Outliers are defined as values outside the range         *
 *   [q1 - cutoff * (q3 - q1), q3 + cutoff * (q3 - q1)]     *
 * where q1 and q3 are the first and third quartiles of     *
 * the distribution of the variable, and cutoff is          *
 * specified by the user.                                   *
 *                                                          *
 * Macro OUTBOX performs the following procedure:           *
 *   1) remove outliers of the untransformed data,          *
 *      using cutoff = cutoff1.                             *
 *   2) find the best Box-Cox transformation of the         *
 *      remaining data (find the transformation that        *
 *      maximizes the Shapiro-Wilk test statistic).         *
 *   3) Box-Cox transform all the values (after adding      *
 *      back previously removed outliers).                  *
 *   4) remove outliers of the Box-Cox transformed data,    *
 *      using cutoff = cutoff2.                             *
 *      Outliers are removed by assigning a special missing *
 *      value: .L for outliers < q1 - cutoff * (q3 - q1);   *
 *      .H for outliers > q3 + cutoff * (q3 - q1).          *
 *   5) back-transform the remaining data to their          *
 *      original values.                                    *
 *                                                          *
 * Required macro parameters:                               *
 *   DATA    = name of SAS data set containing the data.    *
 *   VAR     = name of variable for which outliers are to   *
 *             be removed.                                  *
 *                                                          *
 * Optional macro parameters:                               *
 *   ID      = subject ID variable.                         *
 *   BY      = list of by-variables; macro will determine   *
 *             outliers separately within each by-group.    *
 *   COMB_BY = list of by-variables; macro will determine   *
 *             outliers by combining values in each by-group*
 *   CUTOFF1 = cutoff value for determining outliers in     *
 *             step 1); default = 3.                        *
 *   CUTOFF2 = cutoff value for determining outliers in     *
 *             step 4); default = 2.                        *
 *   KEEPZERO = "Y" to treat zero values as valid values,   *
 *              not subject to exclusion as outliers;       *
 *              "N" to treat zero values like any other     *
 *              value, i.e., subject to exclusion as        *
 *              outliers; default = "N".                    *
 *   LAMBZERO = "Y" to allow Box-Cox transformation         *
 *             parameter lambda to equal zero; "N" to not   *
 *             allow lambda to equal zero; used when there  *
 *             are zero values in the data, but one wants   *
 *             to treat zero values like any other value    *
 *             (KEEPZERO = N).  Alternatively, one could    *
 *             specify a small nonzero ADDLOG value (e.g.,  *
 *             ADDLOG = 0.001) to be added to each value;   *
 *             default = "Y".                               *
 *   PRINT   = "Y" to print subjects remvoved as outliers   *
 *             "N" to suppress printing; default = "N".     *
 *   STEP    = step size for grid search to find best       *
 *             Box-Cox transformation; default = 0.01.      *
 *   ADDLOG  = number to add to each value when doing log   *
 *             transformation in box-cox search; needed if  *
 *             any values equal zero and one specifies      *
 *             KEEPZERO = N and LAMBZERO = Y; default = 0.  *
 *                                                          *
 * The following variables are added to data set &DATA:     *
 *   lambda_&var   = selected box-cox tranformation         *
 *                   parameter lambda                       *
 *   boxcox_&var   = box-cox transformed variable after     *
 *                   removing outliers                      *
 *   noout_&var    = original variable after removing       *
 *                   outliers                               *
 *                                                          *
 * note: macro OUTBOX calls macros OUTLIERS and BOXCOX2.    *
 *                                                          *
 * To run this macro, first include it with the statement:  *
 *   %include /prj/aarppublic/macros/outbox.macro.sas       *
 *                                                          *
 * An example of how to implement this macro would be:      *
 *                                                          *
 *   %outbox  (data     = analysis,                         *
 *             id       = westatid,                         *
 *             by       = sex,                              *
 *             comb_by  = ,                                 *
 *             var      = calories,                         *
 *             cutoff1  = 3,                                *
 *             cutoff2  = 2,                                *
 *             keepzero = N,                                *
 *             lambzero = Y,                                *
 *             print    = N,                                *
 *             step     = 0.01,                             *
 *             addlog   = 0);                               *
 *                                                          *
 * The variables boxcox_&var and noout_&var will contain    *
 * the values .L (too low value) and .H (too high value)    *
 * when a subject has an outlier value.                     *
 *                                                          *
 * All SAS procedures will ignore these special missing     *
 * values.  They will not be used in any output.            *
 *                                                          *
 * To REMOVE SUBJECTS with these values, use the statement: *
 *   if noout_&var <= .Z then delete;                       *
 * (Please note: Using this statement will change your N.)  *
 *                                                          *
 *                                                          *
 *                                                          *
 ***********************************************************/

%macro outbox (data     = analysis_use,
               id       = westatid,
               by       = sex,
               comb_by  = ,
               var      = ,
               cutoff1  = 3,
               cutoff2  = 2,
               keepzero = N,
               lambzero = Y,
               print    = Y,
               step     = 0.01,
               addlog   = 0);

%LET PRINT    = %UPCASE(%SUBSTR(&PRINT,1,1));
%LET KEEPZERO = %UPCASE(%SUBSTR(&KEEPZERO,1,1));
%LET LAMBZERO = %UPCASE(%SUBSTR(&LAMBZERO,1,1));

/* Change from LambZero to AddLog options specificed by Doug Midthune, email 8/12/05 */
/*%IF (&KEEPZERO = Y) %THEN %LET LAMBZERO = N; */
%IF (&KEEPZERO = Y) and &LAMBZERO ne N and &ADDLOG = 0 %THEN %LET ADDLOG = .001;

%if (&by ^= %str() | &comb_by ^= %str() | &id ^= %str()) %then %do;
  proc sort data=&data;  by &by &comb_by &id;  run;
  %end;

%IF (&ID = %STR()) %THEN %LET ID = _OBS_;

%let nvar = 1;

data _data0 (keep=&id &by &comb_by &var original_&var _zero bookmark);
  set &data end=eof;
  _OBS_ = _N_;
  BOOKMARK = 1;
  original_&var = &var;
  if (&var = 0) then _zero = 1;

  IF (EOF) THEN DO;
    _NSTEP = 1 / &STEP;
    CALL SYMPUT("NSTEP",TRIM(LEFT(PUT(_NSTEP,6.))));
    END;
  run;


title4 "Original Untransformed Data, Before Removing Outliers";

%if (&print = Y) %then %do;
proc univariate data=_data0 normal plot nobyplot nextrobs=10 nextrval=10;
  %if (&by ^= %str() | &comb_by ^= %str()) %then by &by &comb_by%str(;);
  %if (&id ^= %str()) %then id &id%str(;);
  var &var;
  run;
  %end;

%if (&keepzero = Y) %then %do;
  data _data0;
    set _data0;
    if (_zero = 1) then &var = .;
    run;
  %end;


%if (&keepzero = Y) %then %do;
  title4 "Step 1: Initial Removal of Non-Zero Outliers in Upper Tail (Untransformed Data)";
  %end;
%else %do;
  title4 "Step 1: Initial Removal of Outliers (Untransformed Data)";
  %end;

 /* call macro OUTLIERS to remove outliers. */

%OUTLIERS2 (data     = _data0,
           id       = &id,
           by       = &by &comb_by,
           var      = &var,
           nvar     = &nvar,
           cutoff   = &cutoff1,
           keepzero = &keepzero,
           print    = &print);

%if (&print = Y) %then %do;
proc univariate data=_data0 normal plot nobyplot nextrobs=10 nextrval=10;
  %if (&by ^= %str() | &comb_by ^= %str()) %then by &by &comb_by%str(;);
  %if (&id ^= %str()) %then id &id%str(;);
  var &var;
  run;
  %end;

%if (&keepzero = Y) %then %do;
  title4 "Step 2: Find Best Box-Cox Transformation of Non-Zero Values After Initial Removal of Outliers";
  %end;
%else %do;
  title4 "Step 2: Find Best Box-Cox Transformation After Initial Removal of Outliers";
  %end;

 /*** call macro BOXCOX to find best box-cox transformation. ***/

%BOXCOX2 (data    = _data0,
         id      = &id,
         by      = &by,
         comb_by = &comb_by,
         var     = &var,
         nvar    = &nvar,
         step    = &step,
         nstep   = &nstep,
         addlog  = &addlog,
         lambzero = &lambzero,
         print   = &print);

data _data0;
  merge _data0 lambdas (rename=(lambda1=lambda_&var));
    by &by bookmark;
  run;

%if (&print = Y) %then %do;
proc univariate data=_data0 normal plot nobyplot nextrobs=10 nextrval=10;
  by &by &comb_by lambda_&var;
  %if (&id ^= %str()) %then id &id%str(;);
  var &var;
  run;
  %end;


%if (&keepzero = Y) %then %do;
  title4 "Step 3: Box-Cox Transform All Non-Zero Data (after adding back previously removed outliers)";
  %end;
%else %do;
  title4 "Step 3: Box-Cox Transform All Data (after adding back previously removed outliers)";
  %end;

data _data0;
  set _data0;

  &var = original_&var;
  %if (&keepzero = Y) %then if (_zero = 1) then &var = .%str(;);

  if (lambda_&var = 0 & &var > .Z) then boxcox_&var = log(&var + &addlog);   /* box-cox transformation */
  else if (&var > .Z) then boxcox_&var = (&var**lambda_&var - 1) / lambda_&var;
  else boxcox_&var = &var;
  run;

%if (&print = Y) %then %do;
proc univariate data=_data0 normal plot nobyplot nextrobs=10 nextrval=10;
  by &by &comb_by lambda_&var;
  %if (&id ^= %str()) %then id &id%str(;);
  var boxcox_&var;
  run;
  %end;


%if (&keepzero = Y) %then %do;
  title4 "Step 4: Final Removal of Non-Zero Outliers in Upper Tail (Box-Cox Transformed Data)";
  %end;
%else %do;
  title4 "Step 4: Final Removal of Outliers (Box-Cox Transformed Data)";
  %end;

 /* call macro OUTLIERS to remove outliers. */

%OUTLIERS2 (data     = _data0,
           id       = &id,
           by       = &by &comb_by lambda_&var,
           var      = boxcox_&var,
           nvar     = &nvar,
           cutoff   = &cutoff2,
           keepzero = &keepzero,
           print    = &print);

%if (&print = Y) %then %do;
proc univariate data=_data0 normal plot nobyplot nextrobs=10 nextrval=10;
  by &by &comb_by lambda_&var;
  %if (&id ^= %str()) %then id &id%str(;);
  var boxcox_&var;
  run;
  %end;


title4 "Step 5: Back-Transform to Original Values, After Final Removal of Outliers";

data &data (drop=_zero);
  merge &data _data0(keep=&id &by &comb_by lambda_&var boxcox_&var _zero);
    by &by &comb_by &id;

  %if (&keepzero = Y) %then %do;
    if (_zero = 1 & lambda_&var = 0) then boxcox_&var = log(&addlog);
    else if (_zero = 1) then boxcox_&var = -1 / lambda_&var;
    %end;

  if (boxcox_&var <= .Z) then noout_&var = boxcox_&var;
  else noout_&var = &var;
  run;

%if (&print = Y) %then %do;
proc univariate data=&data normal plot nobyplot nextrobs=10 nextrval=10;
  %if (&by ^= %str() | &comb_by ^= %str()) %then by &by &comb_by%str(;);
  %if (&id ^= %str()) %then id &id%str(;);
  var noout_&var;
  run;
  %end;

%mend outbox;

 /***********************************************************
 *                                                          *
 * Macro OUTLIERS -                                         *
 *                                                          *
 * Macro OUTLIERS removes outliers for selected variables.  *
 *                                                          *
 * Outliers are defined as values outside the range         *
 *   [q1 - cutoff * (q3 - q1), q3 + cutoff * (q3 - q1)]     *
 * where q1 and q3 are the first and third quartiles of     *
 * the sample distribution of the variable,                 *
 * and cutoff is specified by the user.                     *
 *                                                          *
 * Required macro parameters:                               *
 *   DATA   = name of SAS data set containing the data.     *
 *   VAR    = variable list of selected variables.          *
 *                                                          *
 * Optional macro parameters:                               *
 *   ID     = subject ID variable.                          *
 *   BY      = list of by-variables; macro will determine   *
 *             outliers separately within each by-group.    *
 *   CUTOFF = cutoff value for determining outliers;        *
 *            default = 2.                                  *
 *   WEIGHT = sampling weights. If weights are specified,   *
 *            the macro calculates quartiles q1 and q3      *
 *            from a weighted sample distribution.          *
 *   PRINT  = "Y" to print records having outliers,         *
 *            "N" to suppress printing; default = "N".      *
 *                                                          *
 ***********************************************************/

%macro outliers2 (data     = ,
                 var      = ,
                 nvar     = ,
                 cutoff   = 2,
                 id       = ,
                 by       = ,
                 weight   = ,
                 keepzero = N,
                 print    = Y);

 /* identify outliers: x < q1 - cutoff*(q3-q1) or x > q3 + cutoff*(q3-q1). */

%if (&print = Q) %then %let noprint = noprint;
%else %let noprint = ;

proc means data=&data n min q1 median q3 max &noprint;
  %if (&by ^= %str()) %then by &by%str(;);
  %if (&weight ^= %str()) %then weight &weight%str(;);
  var &var;
  output out=_outmeans q1=q1_1-q1_&nvar q3=q3_1-q3_&nvar;
  title6 "Quartiles of Sample Distributions";
  run;

data _outmeans(drop=i iqr q1_1-q1_&nvar q3_1-q3_&nvar);
  set _outmeans;
  BOOKMARK = 1;

  array _q1 (*) q1_1-q1_&nvar;
  array _q3 (*) q3_1-q3_&nvar;
  array _c1 (*) c1_1-c1_&nvar;
  array _c2 (*) c2_1-c2_&nvar;

  do i = 1 to dim(_q1);
    q1i = _q1(i);
    q3i = _q3(i);
    iqr = q3i - q1i;

    if (iqr > 0) then do;
      _c1(i) = q1i - &cutoff * iqr;
      _c2(i) = q3i + &cutoff * iqr;
      end;
    end;
  run;

 /* print outlier cutoff values. */

data _outmeans2;
  set _outmeans;

  array _x  (*) &var;
  array _c1 (*) c1_1-c1_&nvar;
  array _c2 (*) c2_1-c2_&nvar;

  do i = 1 to dim(_x);
    _x(i) = _c1(i);
    end;
  output;

  do i = 1 to dim(_x);
    _x(i) = _c2(i);
    end;
  output;
  run;

%if (&print ^= Q) %then %do;
proc means data=_outmeans2 min max;
  %if (&by ^= ) %then by &by%str(;);
  var &var;
  title6 "Outlier Cutoff Values: min = Q1 - &cutoff*(Q3-Q1), max = Q3 + &cutoff*(Q3-Q1)";
  run;
  %end;
 
 /* print number of outliers. */

data _nout (keep=&by type_outlier &var);
  merge &data _outmeans;
    by &by bookmark;

  array _x  (*) &var;
  array _x2 (*) x2_1-x2_&nvar;
  array _c1 (*) c1_1-c1_&nvar;
  array _c2 (*) c2_1-c2_&nvar;

  do i = 1 to dim(_x);
    _x2(i) = _x(i);
    end;

  %if (&keepzero ^= Y) %then %do;
  type_outlier = 1;
  do i = 1 to dim(_x);
    if (_x2(i) > .Z & _c1(i) ^= . & _x2(i) < _c1(i)) then _x(i) = 1;
    else _x(i) = .;
    end;
  if (n(of &var) > 0 | first.bookmark) then output;
  %end;

  type_outlier = 2;
  do i = 1 to dim(_x);
    if (_x2(i) > .Z & _c2(i) ^= . & _x2(i) > _c2(i)) then _x(i) = 1;
    else _x(i) = .;
    end;
  if (n(of &var) > 0 | first.bookmark) then output;

  %if (&keepzero ^= Y) %then %do;
  type_outlier = 3;
  do i = 1 to dim(_x);
    if (_x2(i) > .Z & _c1(i) ^= . & _c2(i) ^= . & (_x2(i) < _c1(i) | _x2(i) > _c2(i))) then _x(i) = 1;
    else _x(i) = .;
    end;
  if (n(of &var) > 0 | first.bookmark) then output;
  run;
  %end;

proc sort data=_nout;  by &by type_outlier;  run;

%if (&print ^= Q) %then %do;
proc format;
  value type_out
    1 = " < Minimum"
    2 = " > Maximum"
    3 = " Either";
  run;

proc means data=_nout n;
  %if (&by = %str()) %then by type_outlier%str(;);
  %else by &by type_outlier%str(;);
  var &var;
  format type_outlier type_out.;
  title6 "Number of Outliers";
  run;
  %end;

 /* print outliers. */

%IF (&PRINT = V) %THEN %DO;

data outliers (drop=&var);
  merge &data _outmeans;
    by &by bookmark;

  length _v1-_v&nvar $10;

  array _x  (*) &var;
  array _v  (*) _v1-_v&nvar;
  array _c1 (*) c1_1-c1_&nvar;
  array _c2 (*) c2_1-c2_&nvar;

  _any = 0;
  do i = 1 to dim(_x);
    _v(i) = put(_x(i),best8.) || " ";

    %if (&keepzero = Y) %then %do;
    if (_x(i) ^= . & _c2(i) ^= . & _x(i) > _c2(i)) then do;
    %end;
    %else %do;
    if (_x(i) ^= . & ((_c1(i) ^= . & _x(i) < _c1(i)) | (_c2(i) ^= . & _x(i) > _c2(i)))) then do;
    %end;
      _any = 1;
      _v(i) = trim(_v(i)) || "*";
      end;
    end;

  if (_any = 1) then output;
  run;

data outliers;
  set outliers;

  length &var $10;

  array _x  (*) &var;
  array _v  (*) _v1-_v&nvar;

  do i = 1 to dim(_x);
    _x(i) = _v(i);
    end;
  run;

proc print data=outliers;
  %IF (&BY ^= %str()) %THEN by &by%STR(;);
  id &id;
  var &var;
  title6 "Excluded Outliers (indicated by asterisk): x < Q1 - &cutoff*(Q3-Q1) or x > Q3 + &cutoff*(Q3-Q1)";
  run;

  %END;   /* %if (&print = V) %then %do */

title6;

 /* exclude outliers. */

data &data (drop=i c1_1-c1_&nvar c2_1-c2_&nvar);
  merge &data _outmeans;
    by &by bookmark;

  array _x  (*) &var;
  array _c1 (*) c1_1-c1_&nvar;
  array _c2 (*) c2_1-c2_&nvar;

  do i = 1 to dim(_x);
    %if (&keepzero ^= Y) %then %do;
    if (_x(i) > .Z & _c1(i) ^= . & _c2(i) ^= . & _x(i) < _c1(i)) then _x(i) = .L;
    %end;
    if (_x(i) > .Z & _c1(i) ^= . & _c2(i) ^= . & _x(i) > _c2(i)) then _x(i) = .H;
    end;
  run;

%mend outliers2;

 /***********************************************************
 *                                                          *
 * Macro BOXCOX -                                           *
 *                                                          *
 * Macro BOXCOX finds the Box-Cox transformation that       *
 * maximizes the Shapiro-Wilk test statistic (n <= 2000)    *
 * or minimizes the Kolmorogov-Smirnov test statistic       *
 * (n > 2000) for normality.                                *
 *                                                          *
 * The Box-Cox transformation is                            *
 *    (x**lambda - 1) / lambda     if lambda ^= 0,          *
 *    log(x)                       if lambda  = 0.          *
 * The macro performs a grid search (from 0 to 1) to find   *
 * the lambda that maximizes/minimizes the test statistic.  *
 *                                                          *
 * macro parameters:                                        *
 *   DATA   = name of SAS data set containing the data.     *
 *   ID     = subject ID variable.                          *
 *   BY     = by-variables.  if by-variables are specified  *
 *            the macro will find the best box-cox          *
 *            transformation within each by-group.          *
 *   VAR    = variable list of variables to be transformed. *
 *   TVAR   = names of transformed variables to be created. *
 *            if TVAR is not specified, the VAR variables   *
 *            are replaced by their transformed values.     *
 *   STEP   = step size for grid search (default = .01).    *
 *   ADDLOG = number to add to each value when doing the    *
 *            log transformation.  this is necessary if any *
 *            values equal zero.  default is ADDLOG = 0.    *
 *   PRINT  = "Y" to print distributions of transformed     *
 *            variables, "N" to suppress printing.          *
 *            default is PRINT = "N".                       *
 *                                                          *
 ***********************************************************/

%MACRO BOXCOX2 (DATA    =,
               ID      =,
               BY      =,
               COMB_BY =,
               VAR     =,
               NVAR    =,
               TVAR    =,
               STEP    = 0.01,
               NSTEP   =,
               ADDLOG  = 0,
               LAMBZERO = Y,
               PRINT   = N);

  %IF (&TVAR = %STR()) %THEN %LET TVAR = &VAR;

 /* perform grid search to find best box-cox transformation. */

  %IF (&LAMBZERO = N) %THEN %LET MINLAM = 1;
  %ELSE %LET MINLAM = 0;

  %DO LAMBDA = &MINLAM %TO &NSTEP;

  %if (&lambda ^= &minlam) %then options nonotes%str(;);

 /* box-cox transform the values using current lambda. */

    DATA _BOXCOX (KEEP=&BY &COMB_BY BOOKMARK LAMBDA _T1-_T&NVAR);                                                                      
      SET &DATA END=EOF;                                                      
      LAMBDA = &LAMBDA / &NSTEP;

      ARRAY _S (*) &VAR;
      ARRAY _T (*) _T1-_T&NVAR;

      DO I = 1 TO DIM(_S);
        IF (LAMBDA = 0 & _S(I) > .Z) THEN _T(I) = LOG(_S(I) + &ADDLOG);
        ELSE IF (_S(I) > .Z) THEN _T(I) = (_S(I)**LAMBDA - 1) / LAMBDA;
        ELSE _T(I) = .;
        END;
      RUN;

 /* if combining by-groups, standardize to have same mean and variance. */

    %if (&comb_by ^= %str()) %then %do;
      proc standard data=_boxcox mean=0 std=1 out=_boxcox;
        by &by &comb_by bookmark lambda;
        var _t1-_t&nvar;
        run;
      %end;

    PROC UNIVARIATE DATA=_BOXCOX NOPRINT;
      BY &BY BOOKMARK LAMBDA;
      VAR _T1-_T&NVAR;
      OUTPUT OUT=_SW NORMAL=_SW1-_SW&NVAR PROBN=_P1-_P&NVAR N=_N1-_N&NVAR;
      RUN;

    DATA _ALLSW;
      SET %IF (&LAMBDA > &MINLAM) %THEN _ALLSW; _SW;
        BY &BY BOOKMARK;
      RUN;

    %END;  /* do lambda = 1 to nstep */

  options notes;

  /* find transformation that maximizes Shapiro-Wilk (n <= 2000) */
  /* or minimizes Kolmorogov-Smirnov (n > 2000) statistic.       */

  DATA _ALLSW;
    SET _ALLSW;
    ARRAY _SW (*) _SW1-_SW&NVAR;
    ARRAY _N  (*) _N1-_N&NVAR;

    DO I = 1 TO DIM(_SW);
      IF (_N(I) > 2000) THEN _SW(I) = -_SW(I);
      END;
    RUN;

  PROC UNIVARIATE DATA=_ALLSW NOPRINT;
    BY &BY BOOKMARK;
    VAR _SW1-_SW&NVAR;
    OUTPUT OUT=_MAXSW MAX=_MAXSW1-_MAXSW&NVAR;
    RUN;

  DATA LAMBDAS (KEEP = LAMBDA1-LAMBDA&NVAR &BY BOOKMARK);
    RETAIN LAMBDA1-LAMBDA&NVAR;
    MERGE _ALLSW _MAXSW;
      BY &BY BOOKMARK;
    
    ARRAY _SW (*) _SW1-_SW&NVAR;
    ARRAY _MAXSW (*) _MAXSW1-_MAXSW&NVAR;
    ARRAY _L (*) LAMBDA1-LAMBDA&NVAR;

    IF (FIRST.BOOKMARK) THEN DO I = 1 TO DIM(_L);
	  _L(I) = .;
	  END;

    DO I = 1 TO DIM(_SW);
      IF (_SW(I) = _MAXSW(I)) THEN _L(I) = LAMBDA;
      END;

    IF (LAST.BOOKMARK) THEN OUTPUT;
    RUN;

  %IF (&PRINT ^= Q) %THEN %DO;
    PROC PRINT DATA=LAMBDAS;
      %IF (&BY ^= %str()) %THEN ID &BY%STR(;);
      VAR LAMBDA1-LAMBDA&NVAR;
      FORMAT LAMBDA1-LAMBDA&NVAR 7.5;
      title6 "Lambdas that Maximize the Shapiro-Wilk Statistic";
      RUN;
    %END;

 /* box-cox transform the data using the best lambda. */

  DATA &DATA (DROP=LAMBDA1-LAMBDA&NVAR);
    MERGE &DATA LAMBDAS;
      BY &BY BOOKMARK;

    ARRAY _S (*) &VAR;
    ARRAY _T (*) &TVAR;
    ARRAY _L (*) LAMBDA1-LAMBDA&NVAR;

    DO I = 1 TO DIM(_S);
      IF (_L(I) = 0 & _S(I) > .Z) THEN _T(I) = LOG(_S(I) + &ADDLOG);
      ELSE IF (_S(I) > .Z) THEN _T(I) = (_S(I)**_L(I) - 1) / _L(I);
      ELSE _T(I) = _S(I);
      END;
    RUN;    

  title6;

%MEND BOXCOX2;

 /*** end of macro BOXCOX ***************************************/

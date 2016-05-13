/******************************************************************************
 Program:  /prj/aarppublic/macros/quantile.macro.sas
 Created:  5/22/98
 Purpose:  To create trend and dummy variables for the specified quantiles of a variable.
 One of the trend variables is scored (i.e. having values 1,2,3,4,...) and the other
 contains the median of each quantile.
 Updated:  6/7/99 to allow the quantiles to be based upon only non-zero values.
 Updated:  7/18/00 to allow running the macro with or without a parameter for the non-zero option.

 &dataset = The name of the SAS dataset in which the analysis variable resides and to which the
            new variables will be added.
 &var     = The analysis variable for which the quantiles should be determined.
 &qvar    = The name to use for the new trend and dummy variables.  Note, this must be less than
            8 characters long so that other characters can be appended to it to create new names.
            For example, if &qvar="Q" then the scored trend variable will be named "Q", the median
            trend variable will be "QM", and the dummies will be "Q1", "Q2", "Q3" etc.
 &groups  = The number of quantile groupings (i.e. 4 for quartiles, 5 for quintiles).
 &zero    = Include zero values in quantiles (1=yes,0=no).  "Yes" is assumed if not specified.
 
 To run this macro, first include it with the statement:
   %include '/prj/aarppublic/macros/quantile.macro.sas';

 Then an example run of the macro would be:
   %quantile(COHORT,ALC,ALC_CAT,4,0);
*******************************************************************************/

%macro QUANTILE(dataset,var,qvar,groups,zero);

%if &groups=2 %then %let quantile = median-split;
%else %if &groups=3 %then %let quantile = tertile;
%else %if &groups=4 %then %let quantile = quartile;
%else %if &groups=5 %then %let quantile = quintile;
%else %if &groups=10 %then %let quantile = decile;
%else %let quantile = quantile;

%if &zero^=0 %then %let zero = 1;



%if &zero=0 %then %do;
DATA &dataset;
  SET &dataset;
  IF &var=0 THEN &var = .Z;
RUN;
%end;

PROC RANK DATA=&dataset OUT=&dataset GROUPS=&groups;
  VAR &var;
  RANKS &qvar;
RUN;

DATA &dataset;
  SET &dataset;
  IF &qvar>.Z THEN &qvar = &qvar + 1;
  ELSE IF &qvar=.Z THEN DO; &var = 0; &qvar = 0; END;
  LABEL &qvar = "&var &quantile scored trends";
RUN;

PROC UNIVARIATE NOPRINT DATA=&dataset;
  BY &qvar;
  VAR &var;
  OUTPUT OUT=TEMPSTAT MEDIAN=MEDIAN MIN=MINIMUM MAX=MAXIMUM NOBS=NOBS;
RUN;

PROC PRINT NOOBS LABEL DATA=TEMPSTAT;
  VAR &qvar NOBS MINIMUM MEDIAN MAXIMUM;
RUN;

DATA &dataset;
  MERGE &dataset TEMPSTAT(KEEP=&qvar MEDIAN RENAME=(MEDIAN=&qvar.M));
  BY &qvar;
  IF &qvar>. THEN DO;
    %do i = &zero %to &groups;
      &qvar.&i = (&qvar=&i);
      %end;
    END;
  LABEL
    &qvar.M = "&var &quantile median trends"
    %do i = &zero %to &groups;
      &qvar.&i = "&var &quantile &i"
      %end;
    ;
RUN;
%mend QUANTILE;


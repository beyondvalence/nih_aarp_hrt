libname analysis 'C:\REB\AARP_HRTandMelanoma\Data\converted\';

data outcome;
  set analysis.rout09jan14;
run;
data exposure;
  set analysis.rexp05jun14;
run;     
data analysis;
  merge outcome (in=ino)
        exposure (in=ine);
  by westatid;
run; 
proc datasets;
  delete outcome exposure;   
/* prints the contents of the merged risk factor exposure and outcome datasets
ods html  close;
ods html;
proc contents data=analysis;
run;
ods html close;
ods html;
*/
data ranalysis;  
  set analysis 







libname analysis 'C:\REB\AARP_HRTandMelanoma\Data\converted\';

data outcome;
  set analysis.out09jan14;

data exposure;
  set analysis.exp05jun14;
run;

data analysis;
  merge outcome (in=ino)
        exposure (in=ine);
  by westatid;   
run;  
proc datasets;
  delete outcome exposure;  
run;  
data analysis_use;  
  set analysis












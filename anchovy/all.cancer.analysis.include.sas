libname analysis '/prj/aarppublic/analysis/allcan';

data outcome;
  set analysis.out09jan14;

data exposure;
  set analysis.exp05jun14;
     
data analysis;
  merge outcome (in=ino)
        exposure (in=ine);
  by westatid;   
  
proc datasets;
  delete outcome exposure;  
  
data analysis;  
  set analysis













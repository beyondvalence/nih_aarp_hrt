data use;
	set conv.melan;
run;

* baseline p-trend, model A;
ods output TrendTest=Table1Trd
	(keep=Table Name1 cValue1 rename=(cValue1=TrendPvalue) 
	where=(Name1='P2_TREND'));
ods html;
proc freq data=use;
	title 'freq for melanoma_mal';
	tables melanoma_ins * (  
		fmenstr_me  meno_age_c_me surg_age_c_me
		parity_me flb_age_c_me oralbc_dur_c_me
		)	  
		/chisq trend nocol nopercent scores=tablei;
run;
proc sort data=Table1Trd; 
	by Table; 
run;
ods html file='C:\REB\AARP_HRTandMelanoma\Results\baseline\table2\modelA\table2.trend.base.ins.v2.xls' style=minimal;
proc print data= Table1Trd; 
	title 'print chi2 and trend for melanoma_ins';
run; 
ods html close;

* risk factor p-trend;

data use_r;
	set conv.melan_r;
run;

ods output TrendTest=Table1Trd 
	(keep=Table Name1 cValue1 rename=(cValue1=TrendPvalue) 
	where=(Name1='P2_TREND'));

proc freq data=use_r;
	title 'freq for melanoma_mal';
	tables melanoma_mal* (
		fmenstr_me meno_age_c_me surg_age_c_me
		parity_me flb_age_c_me oralbc_dur_c_me 
		/* Lacey EPT below */
		lacey_eptcurrent_me 
		lacey_eptdose_me lacey_eptdur_me
		/* Lacey ET below */
		lacey_etcurrent_me lacey_etdose_me lacey_etdur 
		lacey_etfreq
		)	  
		/chisq trend nocol nopercent scores=table ;
	  run;

data Table1Trd; 
	set Table1Trd (keep=Table TrendPvalue); run;
proc sort data=Table1Trd; 	
	by Table; run;

ods html file='C:\REB\AARP_HRTandMelanoma\Results\rfq\table2\modelA\Table2.trend.risk_mal.v1.xls' style=minimal;
proc print data= Table1Trd; 
	title 'print trend for melanoma_mal, risk'; run; 
ods html close;

******************************************************************************;
********************************************************************************;
** R16_ins
** ME: lacey_etfreq_me (ref='No HT')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_etfreq_me (ref='No HT');
	model exit_age*melanoma_ins(0)=lacey_etfreq_me/ entry = entry_age RL; 
	ods output ParameterEstimates=A_etfreq NObs = obs;
run;

data A_etfreq; 
	set A_etfreq ; 
	where Parameter='lacey_etfreq_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_etfreq obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

** for natural menopause;
proc phreg data = use_r multipass;
	class  lacey_etfreq_me (ref='No HT') ;
	model exit_age*melanoma_ins(0)=lacey_etfreq_me/ entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_etfreq_NM NObs = obs;
run;
data A_etfreq_NM; 
	set A_etfreq_NM ; 
	where Parameter='lacey_etfreq_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etfreq_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_etfreq_me (ref='No HT') ;
	model exit_age*melanoma_ins(0)=lacey_etfreq_me/ entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_etfreq_SR NObs = obs;
run;
data A_etfreq_SR; 
	set A_etfreq_SR ; 
	where Parameter='lacey_etfreq_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etfreq_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_lacey_etfreq_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** R16_mal
** ME: lacey_etfreq_me (ref='No HT')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use_r multipass;
	class  lacey_etfreq_me (ref='No HT');
	model exit_age*melanoma_mal(0)=lacey_etfreq_me/ entry = entry_age RL; 
	ods output ParameterEstimates=A_etfreq NObs = obs;
run;

data A_etfreq; 
	set A_etfreq ; 
	where Parameter='lacey_etfreq_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_etfreq obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

** for natural menopause;
proc phreg data = use_r multipass;
	class  lacey_etfreq_me (ref='No HT') ;
	model exit_age*melanoma_mal(0)=lacey_etfreq_me/ entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_etfreq_NM NObs = obs;
run;
data A_etfreq_NM; 
	set A_etfreq_NM ; 
	where Parameter='lacey_etfreq_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etfreq_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='Natur'; 
run;

** for surgical menopause;
proc phreg data = use_r multipass;
	class  lacey_etfreq_me (ref='No HT') ;
	model exit_age*melanoma_mal(0)=lacey_etfreq_me/ entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_etfreq_SR NObs = obs;
run;
data A_etfreq_SR; 
	set A_etfreq_SR ; 
	where Parameter='lacey_etfreq_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_etfreq_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_lacey_etfreq_me_mal ; 
	set A_TOT A_NM A_SR; 
run;

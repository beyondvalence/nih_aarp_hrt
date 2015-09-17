******************************************************************************;
********************************************************************************;
** B0d_ins
** ME: ovarystat_c_me (ref='both removed')  
** melanoma: _ins, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  ovarystat_c_me (ref='both removed');
	model exit_age*melanoma_ins(0)=ovarystat_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=A_ovaryst NObs = obs;
run;

data A_ovaryst; 
	set A_ovaryst ; 
	where Parameter='ovarystat_c_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_ovaryst obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_ins'; model='Total'; 
run;

** for surgural menopause;
proc phreg data = use multipass;
	class  ovarystat_c_me (ref='both removed') ;
	model exit_age*melanoma_ins(0)=ovarystat_c_me/ entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_ovaryst_NM NObs = obs;
run;
data A_ovaryst_NM; 
	set A_ovaryst_NM ; 
	where Parameter='ovarystat_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_ovaryst_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_ins'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  ovarystat_c_me (ref='both removed') ;
	model exit_age*melanoma_ins(0)=ovarystat_c_me/ entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_ovaryst_SR NObs = obs;
run;
data A_ovaryst_SR; 
	set A_ovaryst_SR ; 
	where Parameter='ovarystat_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_ovaryst_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_ins'; model='Surg'; 
run;

data A_All_ovarystat_c_me_ins ; 
	set A_TOT A_NM A_SR; 
run;

******************************************************************************;
********************************************************************************;
** B0d_mal
** ME: ovarystat_c_me (ref='both removed')  
** melanoma: _mal, 
** variables: ME;
********************************************************************************;

** overall (natural + surgical menopause);
proc phreg data = use multipass;
	class  ovarystat_c_me (ref='both removed');
	model exit_age*melanoma_mal(0)=ovarystat_c_me/ entry = entry_age RL; 
	ods output ParameterEstimates=A_ovaryst NObs = obs;
run;

data A_ovaryst; 
	set A_ovaryst ; 
	where Parameter='ovarystat_c_me';
	Sortvar=1; 
run;

data A_TOT (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL)); 
	set A_ovaryst obs;
run;
data A_TOT (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_TOT; 
run;
data A_TOT ; 
	set A_TOT; 
	type='_mal'; model='Total'; 
run;

** for surgural menopause;
proc phreg data = use multipass;
	class  ovarystat_c_me (ref='both removed') ;
	model exit_age*melanoma_mal(0)=ovarystat_c_me/ entry = entry_age RL; 
	where menostat_c=1;
	ods output ParameterEstimates=A_ovaryst_NM NObs = obs;
run;
data A_ovaryst_NM; 
	set A_ovaryst_NM ; 
	where Parameter='ovarystat_c_me';
	Sortvar=1; 
run;

data A_NM (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_ovaryst_NM obs;
run;
data A_NM (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_NM;
run;
data A_NM; 
	set A_NM; 
	type='_mal'; model='surgur'; 
run;

** for surgical menopause;
proc phreg data = use multipass;
	class  ovarystat_c_me (ref='both removed') ;
	model exit_age*melanoma_mal(0)=ovarystat_c_me/ entry = entry_age RL; 
	where menostat_c=2;
	ods output ParameterEstimates=A_ovaryst_SR NObs = obs;
run;
data A_ovaryst_SR; 
	set A_ovaryst_SR ; 
	where Parameter='ovarystat_c_me';
	Sortvar=1; 
run;

data A_SR (rename=(HazardRatio=A_HR HRLowerCL=A_LL HRUpperCL=A_UL )); 
	set A_ovaryst_SR obs;
run;
data A_SR (keep=Parameter ClassVal0 Sortvar A_HR A_LL A_UL NObsUsed NObsRead); 
	set A_SR;
run;
data A_SR ; 
	set A_SR; 
	type='_mal'; model='Surg'; 
run;

data A_All_ovarystat_c_me_mal ; 
	set A_TOT A_NM A_SR; 
run;

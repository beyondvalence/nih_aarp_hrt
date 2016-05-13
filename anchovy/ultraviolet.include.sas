libname analysis 'C:\REB\AARP_HRTandMelanoma\Data\anchovy';
filename uv_pub pipe 'gzip -dc C:\REB\AARP_HRTandMelanoma\Data\anchovy\uv_public.v9x.gz' lrecl=80;
proc cimport data=uv_pub infile=uv_pub;














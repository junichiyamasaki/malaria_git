foreach X in AMBALAHASINA AMBODIBONARA MAROFARIA NAMAHOAKA{
insheet using `X'_89_OK.xls_E08.csv,clear
save `X'_89_OK_E08,replace
insheet using `X'_89_OK.xls_E09.csv,clear
save `X'_89_OK_E09,replace
insheet using `X'_90_OK.xls_E09.csv,clear
save `X'_90_OK_E09,replace
insheet using `X'_90_OK.xls_E10.csv,clear
save `X'_90_OK_E10,replace
}


insheet using  MAHATSARA_90_OK.xls_E09.csv,clear
replace ideleve = 11190011 in 11
save MAHATSARA_90_OK_E09,replace
insheet using MAHATSARA_90_OK.xls_E10.csv,clear
save MAHATSARA_90_OK_E10,replace

insheet using "ELEVES FREQUENTANT HORS ZONE.xls_E09.csv",clear
gen beyond=1
save "ELEVES FREQUENTANT HORS ZONE_E09",replace

insheet using "ELEVES FREQUENTANT HORS ZONE.xls_E10.csv",clear
gen beyond=1
save "ELEVES FREQUENTANT HORS ZONE_E10",replace

insheet using SALAFAINA_90_OK.xls_E09.csv,clear
save SALAFAINA_90_OK_E09, replace

insheet using SALAFAINA_90_OK.xls_E10.csv,clear
save SALAFAINA_90_OK_E10, replace

use AMBALAHASINA_89_OK_E08
append using AMBALAHASINA_89_OK_E09 AMBALAHASINA_90_OK_E09 AMBALAHASINA_90_OK_E10 AMBODIBONARA_89_OK_E08 AMBODIBONARA_89_OK_E09 AMBODIBONARA_90_OK_E09 AMBODIBONARA_90_OK_E10 "ELEVES FREQUENTANT HORS ZONE_E09" "ELEVES FREQUENTANT HORS ZONE_E10" MAHATSARA_90_OK_E09 MAHATSARA_90_OK_E10  NAMAHOAKA_89_OK_E08 NAMAHOAKA_89_OK_E09 NAMAHOAKA_90_OK_E09 NAMAHOAKA_90_OK_E10 MAROFARIA_89_OK_E08 MAROFARIA_89_OK_E09 MAROFARIA_90_OK_E09 MAROFARIA_90_OK_E10  SALAFAINA_90_OK_E09 SALAFAINA_90_OK_E10


drop if cecole==.
drop v*
gen id=_n
drop if ideleve==.
reshape long m, i(id) s
save dailyattendancedata_2nd, replace
split _j  ,parse(j) destring
rename _j1 month
rename _j2 day
gen year=2008
replace year=2009 if (annee==89&month>=1&month<=8)|annee==90
replace year=2010 if annee==90&month>=1&month<=8
generate time=mdy(month, day, year)

save dailyattendancedata_2nd, replace	
drop if m==.
duplicates drop ideleve time m,force
drop if beyond==1
tsset ideleve time,d

label define m 0 absent 1 present 8 "teacher absent" 9 "holiday" 
label value m m

gen absent=(m==0)
replace absent=. if m>2
gen G=0
replace G=1  if cecole==2| cecole== 1| cecole== 6|cecole== 7| cecole== 9

save dailyattendancedata_2nd, replace	
end 




rename tot_a tot_autre

foreach name in "sept" "oct" "nov"  "dec" "jan" "fev" "mar" "avr" "mai" "juin" "aout" "tot" {
                label var `name'_0 "absent in `name'"
		label var `name'_1 "present in `name'"
		label var `name'_8 "absence of teacher in `name'"
		label var `name'_9 "holiday in `name'"
		label var `name'_autre "other in `name'"
        }
gen G=0
replace G=1  if cecole==2| cecole== 1| cecole== 6|cecole== 7| cecole== 9
save dailyattendancedata_2nd, replace
exit

exit

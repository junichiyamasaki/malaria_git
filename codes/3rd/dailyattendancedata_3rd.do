cd $localdata/Malaria/3rd

foreach X in EPP_AMBALAHASINA EPP_AMBODIBONARA EPP_FKL_SALAFAINA EPP_HOTSIKA EPP_MAHATSARA EPP_MAROFARIHY EPP_NAMAHOAKA FJKM_FOULPOINTE{
insheet using `X'_90_01.xls_E01.csv,clear
drop id_individu
save `X'_90_01_E01,replace
insheet using `X'_90_01.xls_E90.csv,clear
drop id_individu
save `X'_90_01_E90,replace
}

foreach X in CEG_MAHAMBO CEG_PRIVE_CHRETIEN_LALAINA{
insheet using `X'_01.xls_E01.csv,clear
drop id_individu
save `X'_01_E01,replace
}


use CEG_MAHAMBO_01_E01,clear
append using CEG_PRIVE_CHRETIEN_LALAINA_01_E01

foreach X in EPP_AMBALAHASINA EPP_AMBODIBONARA EPP_FKL_SALAFAINA EPP_HOTSIKA EPP_MAHATSARA EPP_MAROFARIHY EPP_NAMAHOAKA FJKM_FOULPOINTE{
append using `X'_90_01_E01  `X'_90_01_E90
}

drop if cecole==.
drop v*
gen id3rd=_n
drop if ideleve==.
reshape long m, i(id3rd) s
save dailyattendancedata_3rd, replace


use dailyattendancedata_3rd,clear
split _j  ,parse(j) destring
rename _j1 month
rename _j2 day

gen year=2010
*this data should be 2010/7 - 2010/12

generate time=mdy(month, day, year)

save dailyattendancedata_3rd, replace	
drop if m==.

* for some reason cecole is labeld as 98 for three different schools
replace cecole = 97 if lecole=="FKL SALAFAINA"
replace cecole = 96 if lecole=="FJKM FOULPOINTE"

replace ideleve = ideleve - 10000000 if cecole ==97
replace ideleve = ideleve - 20000000 if cecole ==96
replace ideleve = ideleve*10

duplicates drop ideleve time,force
tsset ideleve time,d

label define m 0 absent 1 present 8 "teacher absent" 9 "holiday" 
label value m m

gen absent=(m==0)
replace absent=. if m>2

gen cecolenew = cecole

replace cecole = .
replace cecole = 1 if lecole == "EPP MAHATSARA"
replace cecole = 2 if lecole == "EPP AMBALAHASINA"
replace cecole = 3 if lecole == "EPP NAMAHOAKA"
replace cecole = 4 if lecole == "EPP SALAFAINA"
replace cecole = 5 if lecole == "EPP AMBODIBONARA"
replace cecole = 6 if lecole == "EPP MAROFARIHY"

drop if cecole ==.

gen G=0
replace G=1  if cecole==2| cecole== 1| cecole== 6|cecole== 7| cecole== 9

save dailyattendancedata_3rd, replace	
end 




* rename tot_a tot_autre

* foreach name in "sept" "oct" "nov"  "dec" "jan" "fev" "mar" "avr" "mai" "juin" "aout" "tot" {
*                 label var `name'_0 "absent in `name'"
* 		label var `name'_1 "present in `name'"
* 		label var `name'_8 "absence of teacher in `name'"
* 		label var `name'_9 "holiday in `name'"
* 		label var `name'_autre "other in `name'"
*         }
* gen G=0
* replace G=1  if cecole==2| cecole== 1| cecole== 6|cecole== 7| cecole== 9
* save dailyattendancedata_2nd, replace
* exit

* exit

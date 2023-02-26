insheet using AMBALAHASINA_89_OK.csv,clear
save AMBALAHASINA_89_OK,replace
insheet using AMBALAHASINA_90_OK.csv,clear
save AMBALAHASINA_90_OK,replace
insheet using AMBODIBONARA_89_OK.csv,clear
save AMBODIBONARA_89_OK,replace
insheet using AMBODIBONARA_90_OK.csv,clear
save AMBODIBONARA_90_OK,replace
insheet using "ELEVES FREQUENTANT HORS ZONE.csv",clear
save "ELEVES FREQUENTANT HORS ZONE",replace
insheet using MAHATSARA_90_OK.csv,clear
save MAHATSARA_90_OK,replace
insheet using NAMAHOAKA_89_OK.csv,clear
save NAMAHOAKA_89_OK,replace
insheet using NAMAHOAKA_90_OK.csv,clear
save NAMAHOAKA_90_OK,replace
insheet using MAROFARIA_89_OK.csv,clear
save MAROFARIA_89_OK, replace
insheet using SALAFAINA_90_OK.csv,clear
save SALAFAINA_90_OK, replace

use AMBALAHASINA_89_OK
append using AMBALAHASINA_90_OK AMBODIBONARA_89_OK AMBODIBONARA_90_OK "ELEVES FREQUENTANT HORS ZONE" MAHATSARA_90_OK NAMAHOAKA_89_OK NAMAHOAKA_90_OK MAROFARIA_89_OK SALAFAINA_90_OK

drop if cecole==.
drop v*
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
save attendancedata_2nd, replace
exit

exit

insheet using EPP_AMBALAHASINA_90_01.csv,clear
destring id_individu,replace  ignore(" ")
save EPP_AMBALAHASINA_90_01,replace
insheet using CEG_PRIVE_CHRETIEN_LALAINA_01.csv,clear
destring id_individu,replace  ignore(" ")
save CEG_PRIVE_CHRETIEN_LALAINA_01,replace
insheet using EPP_AMBODIBONARA_90_01.csv,clear
destring id_individu,replace  ignore(" ")
save EPP_AMBODIBONARA_90_01,replace
insheet using EPP_MAHATSARA_90_01.csv,clear
destring id_individu,replace  ignore(" ")
save EPP_MAHATSARA_90_01,replace
insheet using EPP_NAMAHOAKA_90_01.csv,clear
destring id_individu,replace  ignore(" ")
save EPP_NAMAHOAKA_90_01,replace
insheet using EPP_MAROFARIHY_90_01.csv,clear
destring id_individu,replace  ignore(" ")
save EPP_MAROFARIHY_90_01,replace
*MAROFARIHYÇ∆MAROFARIAÇÕàÍèè
insheet using EPP_FKL_SALAFAINA_90_01.csv,clear
destring id_individu,replace  ignore(" ")
save EPP_FKL_SALAFAINA_90_01,replace
insheet using FJKM_FOULPOINTE_90_01.csv,clear
destring id_individu,replace  ignore(" ")
save FJKM_FOULPOINTE_90_01,replace
insheet using CEG_PRIVE_CHRETIEN_LALAINA_01.csv,clear
destring id_individu,replace  ignore(" ")
save   CEG_PRIVE_CHRETIEN_LALAINA_01,replace
insheet using EPP_HOTSIKA_90_01.csv,clear
destring id_individu,replace  ignore(" ")
save EPP_HOTSIKA_90_01,replace


use EPP_AMBALAHASINA_90_01,clear
append using CEG_PRIVE_CHRETIEN_LALAINA_01 EPP_AMBODIBONARA_90_01 EPP_FKL_SALAFAINA_90_01 EPP_HOTSIKA_90_01 EPP_MAHATSARA_90_01 EPP_MAROFARIHY_90_01 EPP_NAMAHOAKA_90_01 FJKM_FOULPOINTE_90_01

drop if cecole==.
rename tot_a tot_autre

foreach name in "oct" "nov"  "dec"  "tot" {
                label var `name'_0 "absent in `name'"
		label var `name'_1 "present in `name'"
		label var `name'_8 "absence of teacher in `name'"
		label var `name'_9 "holiday in `name'"
		label var `name'_autre "other in `name'"
        }


gen cecole2=cecole
replace cecole=31 if cecole2==1
replace cecole=32 if cecole2==2
replace cecole=33 if cecole2==3
replace cecole=34 if cecole2==4
replace cecole=2 if cecole2==5
replace cecole=5 if cecole2==6
replace cecole=37 if cecole2==7
replace cecole=38 if cecole2==8
replace cecole=1 if cecole2==9
replace cecole=6 if cecole2==10
replace cecole=3 if cecole2==11
replace cecole=312 if cecole2==12
replace cecole=4 if cecole2==13
replace cecole=7 if cecole2==14
replace cecole=9 if cecole2==15
replace cecole=8 if cecole2==16
replace cecole=0 if cecole2==98

gen G=0
replace G=1 if cecole==2| cecole==2| cecole== 1| cecole== 6|cecole== 7| cecole== 9
save attendancedata_3rd, replace
exit


exit
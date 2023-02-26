use LISTE_INFRA_VILLAGE_2nd

label var vi1 "common code"
label var vicom "city name"
label var vi2 "code fokontany"
label var vifkt "name fokontany"
label var vhgrap "cluster code (city / local)"
label var viloc "name the place"
label var vinb "number infrastructures"
label var vinum "id infrastructure"
label var viid "nick"
label var vitype "type infrastructure"
label var vilib "wording infrastructure"
label var vipoint "gps item number"
label var vilatd "latitude_degre"
label var vilatm "latitude_minute"
label var vilond "longitude_degre"
label var vilonm "longitude_minute"
label var vialt "altitude"
label var vilat "latitude in decimal degree"
label var vilon "longitude in decimal degree"
label var vhi "end section"

 label define vitype 01 "joint office" 02 "office fokontany" 03 "tranompokonolona" 04 "epp" 05 "ceg" 06 "csb1" 07 "csb2" 08 "bridge" 09 "pharmacy" 10 "church" 11 "seecaline" 99 "missing"
 label define vilatd 99 "missing"
 label define vilond 999 "missing"
 label define vialtis 9999 "missing"

 label value vitype vitype
 label value vilatd vilatd
 label value vilatm vilatd
 label value vilond vilond
 label value vilonm vilonm
 label value vialt vialt

foreach v of varlist vitype vilatd vilatm vilond vilonm vialt {
replace `v'=. if `v'=="missing":`v'
}

save e_LISTE_INFRA_VILLAGE_2nd,replace
exit

 label define vilonm 99,999 "missing"
 label define vilatm 99,999 "missing"
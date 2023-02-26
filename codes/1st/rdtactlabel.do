use LISTE_INDIVIDU_ACT_RDT.dta,replace


label var fl1 "common code"
label var flcom "city name"
label var fl2 "code fokontany"
label var flfkt "name fokontany"
label var flgrap "cluster code (city / local)"
label var flloc "name the place"
label var fl3 "household number"
label var fhid "household identification"
label var flid "individual identification"
label var tail "number of persons residing in the household"
label var flr0 "line number"
label var flr2 "sex"
label var flag "age"
label var flr5 "submitted to rtd
label var flr6 "caught in the act"
label var flr7a "mosquito bites on his face"
label var flr7b "number of times stung on the face"
label var flr8a "mosquito bites on his neck"
label var flr8b "number of times stung on the neck"
label var flr9a "mosquito bites on his right arm"
label var flr9b "number of times bitten on his right arm"
label var flr10a "mosquito bites on his left arm"
label var flr10b "number of times stung on the left arm"
label var flr11a "mosquito bites on the right foot"
label var flr11b "number of times stung on the right foot"
label var flr12a "mosquito bites on his left foot"
label var flr12b "number of times stung on the left foot"
label var flr13a "mosquito bites on other parties"
label var flr13b "number of times stung on other parties"
label var fhl "end section"


label define flr2 1 "male" 2 "female" 9 "missing"
label define flag 97 "if> = 97 years" 98 "dk" 99 "missing"
label define flr5 1 "positive" 2 "negative" 3 "refusal" 4 "other" 9 "missing"
label define yesno 1 "yes" 2 "no" 9 "missing"
label define ifdk 8 "if> = 8" 9 "dk"

label value flr2 flr2
label value flag flag
label value flr5 flr5
label value flr6 flr7a flr8a flr9a flr10a flr11a flr12a flr13a yesno
label value flr7b flr8b flr9b flr10b flr11b flr12b flr13b ifdk

replace flr6=0 if flr5==2| flr5==3

foreach v of varlist flr2 flag flr5 {
replace `v'=. if `v'=="missing":`v'
}
foreach v of varlist flr6 flr7a flr8a flr9a flr10a flr11a flr12a flr13a {
replace `v'=. if `v'=="missing":yesno
}
foreach v of varlist  flr7b flr8b flr9b flr10b flr11b flr12b flr13b {
replace `v'=. if `v'=="missing":ifdk
}

save  e_LISTE_INDIVIDU_ACT_RDT.dta,replace
exit

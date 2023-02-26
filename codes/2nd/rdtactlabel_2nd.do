use LISTE_INDIVIDU_ACT_RDT_2nd.dta,replace

replace flid09 = 320203 in 854
replace flid09 = 320202 in 855
replace flid = 3202003 in 854
replace flid = 3202002 in 855


// 2nd‚Å‚ÌŽå‚È•t‚¯‰Á‚¦
label var flext "code extension"
label var flr0cx "old member"
label var flid09 "Individual ID in 1st"
label var flhid09 "household ID in 1st"
label var flage "age"
label var flr4x "actual member"
label var flr14x "Number of hours under the net"
label var flr15x "Activity when out of screen"


label define flr0cx 1 "old member" 2 "new member"
label value flr0cx flr0cx
label define flr5x  2 "negative" 3 "refusal" 4 "other" 5"positive pf" 6 "positive nonpf" 7 "positive mix" 9 "missing"
label define flr15x  1 "Working elsewhere" 2 "Working at home" 3 "Play / walk outside (includes meals)" 4 "Play at Home"  5 "Sleeping outside the net" 6 "I was under the net all night" 9 "MISSING"
label value flr15x flr15x
replace flr15x=. if flr15x==9
rename flr5 flr5y

//1st

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

save  e_LISTE_INDIVIDU_ACT_RDT_2nd.dta,replace
exit

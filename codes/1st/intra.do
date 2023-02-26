use e_LISTE_INDIVIDU_ACT_RDT,replace

//rdtのポジネガ追加
gen rdt=.
replace rdt=1 if flr5==1
replace rdt=0 if flr5==2
label define rdt 1 "positive" 0 "negative"
label value rdt rdt

sort flloc
by flloc: egen rdtrate=mean(rdt)
rename flid miid

save e_LISTE_INDIVIDU_ACT_RDT2,replace

do mosquitonet

//マッチしてマージ
use e_LISTE_INDIVIDU_MENAGE.dta, clear
merge 1:1  miid using e_LISTE_INDIVIDU_ACT_RDT2
merge m:1 mhid using e_MENAGE,generate(_merge2)
merge 1:m mhid hl1 using MQNCONVERT, generate(_merge3)
replace mqnid=0 if h1==2
replace llitnid=0 if h1==2
replace ntllitnid=0 if h1==2
drop if _merge3==2


//treated or not
gen d=1 if  mi1==170
replace d=0 if mi1==50

set more off

sort mhid
by mhid: egen hhsize=count(mhid)

gen fe1=e2 if (r3==1&r2==1)
gen fe2=e2 if (r3==2&r2==1)
egen fe3=rowtotal(fe1 fe2),m
by mhid: egen fe=max(fe3)

gen me1=e2 if (r3==1&r2==2)
gen me2=e2 if (r3==2&r2==2)
egen me3=rowtotal(me1 me2),m
by mhid: egen me=max(me3)

reg  ntllitnid fe me r4 h2 hhsize if (r3==1&r2==1)|(r3==2&r2==1)
reg  ntllitnid fe me r4 h2 hhsize if (r3==1&r2==2)|(r3==2&r2==2)
reg  ntllitnid fe me r4 h2 hhsize if r4<=12
exit



exit
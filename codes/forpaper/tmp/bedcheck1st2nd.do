*1stと2ndで一緒に寝ている人が変わったかチェック

*new memberをあぶり出す
use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\2nd\e_crosssection_2nd,clear
keep r0cx mhid hl1 
keep if r0cx==2
egen newid=seq(), by(mhid )
rename hl1 newmemberid
reshape wide newmemberid, i(mhid) j(newid)
save newmembers_2nd,replace

*old memberをあぶり出す

use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\2nd\e_crosssection_2nd,clear
drop if phase==1
keep r0dx mhid hl1 
replace r0dx=2 if r0dx>2&r0dx<98
keep if r0dx==2
egen oldid=seq(), by(mhid )
rename hl1 oldmemberid
reshape wide oldmemberid, i(mhid) j(oldid)
save oldmembers_2nd,replace



*absenceなメンバーをあぶり出す
use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\1st\e_combine,clear
keep r8 mhid hl1 
keep if r8==2
egen newid=seq(), by(mhid )
rename hl1 absence1stid
reshape wide absence1stid, i(mhid) j(newid)
save absencemembers_1st,replace

*absenceなメンバーをあぶり出す2nd
use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\2nd\e_combine_2nd,clear
keep r8 mhid hl1 
keep if r8==2
egen newid=seq(), by(mhid )
rename hl1 absence2ndid
reshape wide absence2ndid, i(mhid) j(newid)
save absencemembers_2nd,replace


use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\2nd\e_crosssection_2nd,clear
merge m:1 mhid using newmembers_2nd,gen(newmembermerge)

drop if newmembermerge==2
merge m:1 mhid using oldmembers_2nd,gen(oldmembermerge)
drop if oldmembermerge==2
merge m:1 mhid using absencemembers_2nd,gen(absencemember2ndmerge)
drop if absencemember2ndmerge==2
merge m:1 mhid using absencemembers_1st,gen(absencemember1stmerge)
drop if absencemember1stmerge==2

sort miid09 phase
*新しい人は落とす

drop if phase==2&(r0cx==2|r0dx!=1)
xtset miid09 phase

for num 1/5: gen mqnw1stX=L.mqnwX
for num 1/5: gen mqnw2ndX=mqnwX

for num 1/5 :replace mqnw1stX=. if (mqnw1stX==oldmemberid1|mqnw1stX==oldmemberid2|mqnw1stX==oldmemberid3|mqnw1stX==oldmemberid4|mqnw1stX==oldmemberid5)

for num 1/5 :replace mqnw1stX=. if (mqnw1stX==absence1stid1|mqnw1stX==absence1stid2|mqnw1stX==absence1stid3|mqnw1stX==absence1stid4|mqnw1stX==absence1stid5)

for num 1/5 :replace mqnw2ndX=. if (mqnw1stX==newmemberid1|mqnw1stX==newmemberid2|mqnw1stX==newmemberid3)

for num 1/5 :replace mqnw2ndX=. if (mqnw2ndX==absence2ndid1|mqnw2ndX==absence2ndid2|mqnw2ndX==absence2ndid3|mqnw2ndX==absence2ndid4|mqnw2ndX==absence2ndid5)




for num 1/5:replace mqnw1stX=. if mqnw1stX==0
for num 1/5:replace mqnw2ndX=. if mqnw2ndX==0
rowsort mqnw1st1-mqnw1st5, generate(sortmqnw1st1-sortmqnw1st5)
rowsort mqnw2nd1-mqnw2nd5, generate(sortmqnw2nd1-sortmqnw2nd5)

save bedcheck1st2nd,replace
forvalues X = 1/5{
use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\1st\e_combine,clear
rename r4 withage1st`X'
rename r3 withrelation1st`X'
rename hl1 sortmqnw1st`X'
rename mhid mhid09
keep phase mhid09 sortmqnw1st`X'  withage1st`X' withrelation1st`X'
save with`X'.dta, replace
use bedcheck1st2nd,clear
merge m:1 mhid09 sortmqnw1st`X' using with`X'.dta,gen(with`X'merge) keep(master match)
erase with`X'.dta
save bedcheck1st2nd, replace
 }

sort miid09 phase
replace mqnid=. if r8==2
gen lmqnid=L.mqnid
gen teen=(r4>12&r4<20)
egen  teenhh=max(teen), by(mhid09 phase)

gen net=h2
replace net=0 if h1==2
gen netu=h3
replace netu=0 if h1==2
gen dnet=D.net
gen dnetu=D.netu

gen lnwith=L.nwith
gen dnwith=D.nwith


keep if phase==2
keep miid09 mhid09 mhid hhsize  phase  r3 r4 teen teenhh mqnid lmqnid micom migrap miloc sortmqnw1st1-sortmqnw1st5  sortmqnw2nd1-sortmqnw2nd5 mqnid lmqnid h1 h2 h3  dnet dnetu  nwith dnwith lnwith withage1st1-withage1st5 withrelation1st1-withrelation1st5 D


for num 1/5: gen mark12X=1 if (sortmqnw1stX==sortmqnw2ndX)|(lmqnid==0)|mqnid==0
gen mark12=(mark121==1&mark122==1&mark123==1&mark124==1&mark125==1) 
egen mark12hh=min(mark12), by (mhid09)
rename dnwith adjustdnwith
rename nwith adjustnwith2nd
rename lnwith adjustnwith1st

gen adjustparentswith1=1 if (withrelation1st1==1|withrelation1st1==2)
gen adjustparentswith2=1 if (withrelation1st2==1|withrelation1st2==2)
gen adjustparentswith3=1 if (withrelation1st3==1|withrelation1st3==2)
gen adjustparentswith4=1 if (withrelation1st4==1|withrelation1st4==2)
gen adjustparentswith5=1 if (withrelation1st5==1|withrelation1st5==2)
egen adjustparentwith1st=rowtotal(adjustparentswith1-adjustparentswith5)

gen adjustadultwith1=1 if (withage1st1>=20&withage1st1<99)
gen adjustadultwith2=1 if (withage1st2>=20&withage1st2<99)
gen adjustadultwith3=1 if (withage1st3>=20&withage1st3<99)
gen adjustadultwith4=1 if (withage1st4>=20&withage1st4<99)
gen adjustadultwith5=1 if (withage1st5>=20&withage1st5<99)
egen adjustadultwith1st=rowtotal( adjustadultwith1- adjustadultwith5)
save bedcheck1st2nd,replace

gen age60=r4
replace age60=60 if r4>60&r4!=.
gen underteen=(r4<=12&r4>=6)

label var adjustdnwith "$\Delta$ n. sleep with"
label var mark12 "no member change"
label var adjustnwith1st "n. sleep with at the 1st"
label var adjustparentwith1st "n. parents sleep with at the 1st"


graph twoway lpolyci adjustdnwith age60 if dnet>0
graph export  dnwith_and_age60.eps , replace

graph twoway lpolyci adjustnwith1st age60 
graph export  nwith_and_age60.eps , replace

eststo clear
reg adjustdnwith teen underteen adjustnwith1st if mqnid==1&lmqnid==1&dnet>0
eststo
reg mark12 teen underteen adjustnwith1st if mqnid==1&lmqnid==1&dnet>0
eststo

reg adjustdnwith adjustnwith1st adjustparentwith1st  if mqnid==1&lmqnid==1&dnet>0&teen==1&r3==3
eststo
reg mark12 adjustnwith1st adjustparentwith1st  if mqnid==1&lmqnid==1&dnet>0&teen==1&r3==3
eststo	d
reg adjustdnwith adjustnwith1st adjustparentwith1st  if mqnid==1&lmqnid==1&dnet>0&underteen==1&r3==3
eststo
reg mark12 adjustnwith1st adjustparentwith1st  if mqnid==1&lmqnid==1&dnet>0&underteen==1&r3==3
eststo
esttab using netwith1st2nd,   p  replace  label  varwidth(6) wrap tex  mlabel(,depvar)  addnotes(We only used those who used net at the1st and the 2nd both. Column 1 and 2 use full sample, 3 and 4 use teenager children, 5 and 6 use 6-12 years old children.)  

exit
drop if markhh==0
*drop if mqnid==.
*drop if lmqnid==.
*drop if l2mqnid==.

save bedcheck.dta, replace

codebook mhid09 if r3==1&hhsize>2&(migrap==3|migrap==4|migrap==13|migrap==14|migrap==15)
tab teenhh if r3==1&hhsize>2&(migrap==3|migrap==4|migrap==13|migrap==14|migrap==15)
tab teen l2mqnid  if hhsize>2&(migrap==3|migrap==4|migrap==13|migrap==14|migrap==15)
tab teen mqnid  if hhsize>2&(migrap==3|migrap==4|migrap==13|migrap==14|migrap==15)
 
probit mqnid teen hhsize bedid nwithsleep , vce(cluster mhid09)
probit lmqnid teen hhsize bedid nwithsleep if migrap >10, vce(cluster mhid09)
probit l2mqnid teen hhsize bedid nwithsleep, vce(cluster mhid09)
egen test=count(r4>=0 ), by(mhid09)

tab hhsize test
tab mhid09 if (hhsize!=test)& (r3==1&hhsize>2&(migrap==3|migrap==4|migrap==13|migrap==14|migrap==15))
tab mhid09 if (hhsize2!=test)& (r3==1&hhsize>2&(migrap==3|migrap==4|migrap==13|migrap==14|migrap==15))

gen teennotmqn=(teen==1&mqnid==0)
egen teennotmqnhh=total(teennotmqn), by (mhid09)
codebook mhid09 if  (migrap==3|migrap==4|migrap==13|migrap==14|migrap==15)
exit

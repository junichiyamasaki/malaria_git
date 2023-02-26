*2nd3rdでconsistentかチェック
*new memberをあぶり出す
use e_crosssection_3rd,clear
drop if phase!=3
keep r0cx mhid hl1 
keep if r0cx==2
egen newid=seq(), by(mhid )
rename hl1 newmemberid
reshape wide newmemberid, i(mhid) j(newid)
save newmembers_3rd,replace

*old memberをあぶり出す

use e_crosssection_3rd,clear
drop if phase!=3
keep r0dx mhid hl1 
replace r0dx=2 if r0dx>2&r0dx<98
keep if r0dx==2
egen oldid=seq(), by(mhid )
rename hl1 oldmemberid
reshape wide oldmemberid, i(mhid) j(oldid)
save oldmembers_3rd,replace


use e_panel_3rd,clear
merge m:1 mhid using newmembers_3rd,gen(newmembermerge)

drop if newmembermerge==2
merge m:1 mhid using oldmembers_3rd,gen(oldmembermerge)
drop if oldmembermerge==2

sort miid09 phase
xtset miid09 phase
for num 1/5 :replace spwX=. if (spwX==newmemberid1|spwX==newmemberid2|spwX==newmemberid3)

drop if phase==1

for num 1/5: gen mqnw2ndX=L.mqnwX

for num 1/5 :replace mqnw2ndX=. if (mqnw2ndX==oldmemberid1|mqnw2ndX==oldmemberid2|mqnw2ndX==oldmemberid3|mqnw2ndX==oldmemberid4|mqnw2ndX==oldmemberid5)

gen abs=0
replace abs=1 if r8==2
egen  abshh=total(abs), by(mhid09 phase)
gen hhsize2=hhsize-abshh

drop if abshh>=1

for num 1/5:replace mqnw2ndX=. if mqnw2ndX==0
for num 1/5: replace mqnwX=. if mqnwX==0
for num 1/5: replace spwX=. if spwX==0
rowsort spw1-spw5, generate(sortspw1-sortspw5)
rowsort mqnw2nd1-mqnw2nd5, generate(sortmqnw2nd1-sortmqnw2nd5)
rowsort mqnw1-mqnw5, generate( sortmqnw1-sortmqnw5)

replace mqnid=. if r8==2
gen lmqnid=L.mqnid
gen teen=(r4>9&r4<20)
egen  teenhh=max(teen), by(mhid09 phase)

gen notmqnhh=hhsize2-mqnhh
gen lnotmqnhh=L.notmqnhh


keep if phase==3
keep miid09 mhid09 mhid hhsize  hhsize2 bedid nwithsleep  r3 r4 teen teenhh mqnid lmqnid  notmqnhh lnotmqnhh  micom migrap miloc sortspw1-sortspw5 sortmqnw1-sortmqnw5  sortmqnw2nd1-sortmqnw2nd5 mqnid lmqnid 

for num 1/5: gen markX=1 if (sortspwX==sortmqnwX&sortmqnw2ndX==sortspwX)|(mqnid==0&sortmqnw2ndX==sortspwX)|(sortspwX==sortmqnwX&lmqnid==0)|(mqnid==0&lmqnid==0)

gen mark=(mark1==1&mark2==1&mark3==1&mark4==1&mark5==1) 
egen markhh=min(mark), by (mhid09)

drop if markhh==0
*drop if mqnid==.
*drop if lmqnid==.
*drop if l2mqnid==.

save bedcheck2nd3rd.dta, replace

codebook mhid09 if r3==1&hhsize>2&(migrap==3|migrap==4|migrap==13|migrap==14|migrap==15)
tab teenhh if r3==1&hhsize>2&(migrap==3|migrap==4|migrap==13|migrap==14|migrap==15)

tab teen mqnid  if hhsize>2&(migrap==3|migrap==4|migrap==13|migrap==14|migrap==15)

probit mqnid teen hhsize bedid nwithsleep , vce(cluster mhid09)
probit lmqnid teen hhsize bedid nwithsleep if migrap >10, vce(cluster mhid09)


tab hhsize test
tab mhid09 if (hhsize!=test)& (r3==1&hhsize>2&(migrap==3|migrap==4|migrap==13|migrap==14|migrap==15))
tab mhid09 if (hhsize2!=test)& (r3==1&hhsize>2&(migrap==3|migrap==4|migrap==13|migrap==14|migrap==15))


exit
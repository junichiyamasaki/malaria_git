*new member‚ð‚ ‚Ô‚èo‚·
use e_crosssection_3rd,clear
keep r0cx mhid hl1 
keep if r0cx==2
egen newid=seq(), by(mhid )
rename hl1 newmemberid
reshape wide newmemberid, i(mhid) j(newid)
save newmembers_3rd,replace

*old member‚ð‚ ‚Ô‚èo‚·

use e_crosssection_3rd,clear
drop if phase==1
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
for num 1/5 :replace spwX=. if (spwX==newmemberid1|spwX==newmemberid2|spwX==newmemberid3|spwX==newmemberid4)

for num 1/5: gen mqnw1stX=L2.mqnwX
for num 1/5: gen mqnw2ndX=L.mqnwX

for num 1/5 :replace mqnw1stX=. if (mqnw1stX==oldmemberid1|mqnw1stX==oldmemberid2|mqnw1stX==oldmemberid3|mqnw1stX==oldmemberid4|mqnw1stX==oldmemberid5)


gen abs=0
replace abs=1 if r8==2
egen  abshh=total(abs), by(mhid09 phase)
gen hhsize2=hhsize-abshh

drop if abshh>=1

for num 1/5:replace mqnw1stX=. if mqnw1stX==0
for num 1/5:replace mqnw2ndX=. if mqnw2ndX==0
for num 1/5: replace mqnwX=. if mqnwX==0
for num 1/5: replace spwX=. if spwX==0
rowsort spw1-spw5, generate(sortspw1-sortspw5)
rowsort mqnw1st1-mqnw1st5, generate(sortmqnw1st1-sortmqnw1st5)
rowsort mqnw2nd1-mqnw2nd5, generate(sortmqnw2nd1-sortmqnw2nd5)
rowsort mqnw1-mqnw5, generate( sortmqnw1-sortmqnw5)

replace mqnid=. if r8==2
gen lmqnid=L.mqnid
gen l2mqnid=L2.mqnid
gen teen=(r4>9&r4<20)
egen  teenhh=max(teen), by(mhid09 phase)

gen notmqnhh=hhsize2-mqnhh
gen l2notmqnhh=L2.notmqnhh
gen lnotmqnhh=L.notmqnhh
gen dh2=D.h2
gen ldh2=L.dh2


keep if phase==3
keep miid09 mhid09 mhid hhsize  hhsize2 bedid nwithsleep  r3 r4 teen teenhh mqnid lmqnid l2mqnid  notmqnhh lnotmqnhh l2notmqnhh micom migrap miloc sortspw1-sortspw5 sortmqnw1-sortmqnw5 sortmqnw1st1-sortmqnw1st5  sortmqnw2nd1-sortmqnw2nd5 mqnid lmqnid l2mqnid h1 h2 h3 ldh2

for num 1/5: gen markX=1 if (sortspwX==sortmqnwX&sortmqnwX==sortmqnw1stX&sortmqnw1stX==sortmqnw2ndX&sortmqnw2ndX==sortspwX)|(mqnid==0&sortmqnw1stX==sortmqnw2ndX&sortmqnw2ndX==sortspwX)|(sortspwX==sortmqnwX&l2mqnid==0&sortmqnwX==sortmqnw2ndX&sortmqnw2ndX==sortspwX)|(sortspwX==sortmqnwX&lmqnid==0&sortmqnwX==sortmqnw1stX&sortmqnw1stX==sortspwX)|(mqnid==0&lmqnid==0&sortmqnw1stX==sortspwX)|(l2mqnid==0&lmqnid==0&sortmqnw1stX==sortspwX)|(l2mqnid==0&lmqnid==0&mqnid==0)

gen mark=(mark1==1&mark2==1&mark3==1&mark4==1&mark5==1) 
egen markhh=min(mark), by (mhid09)


for num 1/5: gen mark12X=1 if (sortmqnw1stX==sortmqnw2ndX)|(l2mqnid==0)|lmqnid==0
gen mark12=(mark121==1&mark122==1&mark123==1&mark124==1&mark125==1) 
egen mark12hh=min(mark12), by (mhid09)

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
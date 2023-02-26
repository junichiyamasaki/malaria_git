use e_panel_3rd,clear


for num 1/5: gen mqnw1stX=L2.mqnwX
for num 1/5: gen mqnw2ndX=L.mqnwX

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
gen lmqnid=L.mqnid
gen l2mqnid=L2.mqnid
gen teen=(r4>9&r4<20)
egen  teenhh=max(teen), by(mhid09 phase)

gen notmqnhh=hhsize2-mqnhh
gen l2notmqnhh=L2.notmqnhh
gen lnotmqnhh=L.notmqnhh


keep if phase==3
keep miid09 mhid09 hhsize  hhsize2 bedid nwithsleep  r3 r4 teen teenhh mqnid lmqnid l2mqnid  notmqnhh lnotmqnhh l2notmqnhh micom migrap miloc sortspw1-sortspw5 sortmqnw1-sortmqnw5 sortmqnw1st1-sortmqnw1st5  sortmqnw2nd1-sortmqnw2nd5 mqnid lmqnid l2mqnid

for num 1/5: gen markX=1 if (sortspwX==sortmqnwX&sortmqnwX==sortmqnw1stX&sortmqnw1stX==sortmqnw2ndX&sortmqnw2ndX==sortspwX)|(mqnid==0&sortmqnw1stX==sortmqnw2ndX&sortmqnw2ndX==sortspwX)|(sortspwX==sortmqnwX&l2mqnid==0&sortmqnwX==sortmqnw2ndX&sortmqnw2ndX==sortspwX)|(sortspwX==sortmqnwX&lmqnid==0&sortmqnwX==sortmqnw1stX&sortmqnw1stX==sortspwX)|(mqnid==0&lmqnid==0&sortmqnw1stX==sortspwX)|(l2mqnid==0&lmqnid==0&sortmqnw1stX==sortspwX)|(l2mqnid==0&lmqnid==0&mqnid==0)

gen mark=(mark1==1&mark2==1&mark3==1&mark4==1&mark5==1) 
egen markhh=min(mark), by (mhid09)

drop if markhh==0
*drop if mqnid==.
*drop if lmqnid==.
*drop if l2mqnid==.

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

exit
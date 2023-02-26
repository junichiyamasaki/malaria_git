
use e_crosssection_3rd,clear

*メンバーの加減や分割があったのは落とす
gen newmember=(r0cx==2)
replace newmember=0 if phase==1
gen gonemember=(r0dx!=1)
replace gonemember=0 if phase==1
gen split=(miex!=0)
replace split=0 if phase==1

egen newhh=max(newmember), by(mhid09) 
egen gonehh=max(gonemember), by(mhid09)
egen splithh=max(split) , by(mhid09)
drop if newhh>0
drop if gonehh>0
drop if split>0

keep mhid09
 duplicates drop mhid09,force
save originalmembers_3rd,replace

*今度は寝ているメンバーが一緒かチェックしてく
use e_panel_3rd,clear
merge m:1 mhid09 using originalmembers_3rd,nogen keep(match) 
erase  "originalmembers_3rd.dta"

sort miid09 phase

for num 1/5: gen mqnw1stX=L2.mqnwX
for num 1/5: gen mqnw2ndX=L.mqnwX


gen abs=0
replace abs=1 if r8==2
egen  abshh=total(abs), by(mhid09 phase)
gen hhsize2=hhsize-abshh

*たまたまいなかったやつがいたらおとす
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


keep if phase==3
keep miid09 mhid09 mhid hhsize  hhsize2 bedid nwithsleep  r3 r4 teen teenhh mqnid lmqnid l2mqnid  notmqnhh lnotmqnhh l2notmqnhh micom migrap miloc sortspw1-sortspw5 sortmqnw1-sortmqnw5 sortmqnw1st1-sortmqnw1st5  sortmqnw2nd1-sortmqnw2nd5 mqnid lmqnid l2mqnid

for num 1/5: gen markX=1 if (sortspwX==sortmqnwX&sortmqnwX==sortmqnw1stX&sortmqnw1stX==sortmqnw2ndX&sortmqnw2ndX==sortspwX)|(mqnid==0&sortmqnw1stX==sortmqnw2ndX&sortmqnw2ndX==sortspwX)|(sortspwX==sortmqnwX&l2mqnid==0&sortmqnwX==sortmqnw2ndX&sortmqnw2ndX==sortspwX)|(sortspwX==sortmqnwX&lmqnid==0&sortmqnwX==sortmqnw1stX&sortmqnw1stX==sortspwX)|(mqnid==0&lmqnid==0&sortmqnw1stX==sortspwX)|(l2mqnid==0&lmqnid==0&sortmqnw1stX==sortspwX)|(l2mqnid==0&lmqnid==0&mqnid==0)

gen mark=(mark1==1&mark2==1&mark3==1&mark4==1&mark5==1) 
egen markhh=min(mark), by (mhid09)
drop if markhh==0
*drop if mqnid==.
*drop if lmqnid==.
*drop if l2mqnid==.
drop if mhid09==13260
exit
duplicates mhid09 ,force
save bedcheckfordemand.dta, replace

exit
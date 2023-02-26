set more off
do mosquitonetlabel

// 個人個人が蚊帳で寝ているかどうか
for num 1/15: gen mqnidX=0
for num 1/15: replace mqnidX=1 if h71==X|h72==X|h73==X|h74==X|h75==X
for num 1/15: bysort  mhid: egen mqnidhX =total( mqnidX )

//個人個人がLLITNで寝ているか
for num 1/15: gen llitnidX=0
for num 1/15: replace llitnidX=1 if (h71==X&h10<=5)|(h72==X&h10<=5)|(h73==X&h10<=5)|(h74==X&h10<=5)|(h75==X&h10<=5)
for num 1/15: bysort  mhid: egen llitnidhX =total( llitnidX )

//個人個人が破れていない蚊帳で寝ているかどうか
for num 1/15: gen ntmqnidX=0
for num 1/15: replace ntmqnidX=1 if (h71==X&h9==2&h10<=5)|(h72==X&h9==2)|(h73==X&h9==2)|(h74==X&h9==2)|(h75==X&h9==2)
for num 1/15: bysort  mhid: egen ntmqnidhX =total( ntmqnidX )

//個人個人が破れていないLLITNで寝ているかどうか
for num 1/15: gen ntllitnidX=0
for num 1/15: replace ntllitnidX=1 if (h71==X&h9==2&h10<=5)|(h72==X&h9==2&h10<=5)|(h73==X&h9==2&h10<=5)|(h74==X&h9==2&h10<=5)|(h75==X&h9==2&h10<=5)
for num 1/15: bysort  mhid: egen ntllitnidhX =total( ntllitnidX )

//いつ買った蚊帳で寝ているか
for num 1/15: gen netyearidX=.
for num 1/15: replace netyearidX=h4 if h71==X|h72==X|h73==X|h74==X|h75==X
for num 1/15: bysort  mhid: egen netyearhX =max( netyearidX )

////追加分
//もらった蚊帳で寝ているか
for num 1/15: gen freemqnX=.
for num 1/15: replace freemqnX=h5 if h71==X|h72==X|h73==X|h74==X|h75==X
for num 1/15: bysort  mhid: egen freemqnhX =max( freemqnX )


//どこで買った蚊帳で寝ているか
for num 1/15: gen mqnshopX=.
for num 1/15: replace mqnshopX=h6 if h71==X|h72==X|h73==X|h74==X|h75==X
for num 1/15: bysort  mhid: egen mqnshophX =max( mqnshopX )

////ここまで

// 個人個人が誰と寝ているか
for num 1/15: gen mqnw1X=0
for num 1/15: replace mqnw1X=h71 if h71==X|h72==X|h73==X|h74==X|h75==X
for num 1/15: gen mqnw2X=0
for num 1/15: replace mqnw2X=h72 if h71==X|h72==X|h73==X|h74==X|h75==X
for num 1/15: gen mqnw3X=0
for num 1/15: replace mqnw3X=h73 if h71==X|h72==X|h73==X|h74==X|h75==X
for num 1/15: gen mqnw4X=0
for num 1/15: replace mqnw4X=h74 if h71==X|h72==X|h73==X|h74==X|h75==X
for num 1/15: gen mqnw5X=0
for num 1/15: replace mqnw5X=h75 if h71==X|h72==X|h73==X|h74==X|h75==X

collapse (max) mqnidh1-mqnidh15 llitnidh1-llitnidh15 ntmqnidh1-ntmqnidh15 ntllitnidh1-ntllitnidh15 netyearh1-netyearh15  mqnw11-mqnw115 mqnw21-mqnw215 mqnw31-mqnw315 mqnw41-mqnw415 mqnw51-mqnw515 freemqnh* mqnshoph*, by (mhid)


reshape long mqnidh llitnidh ntmqnidh ntllitnidh netyearh mqnw1 mqnw2 mqnw3 mqnw4 mqnw5 freemqnh mqnshoph, i(mhid) j(hl1)
rename mqnidh mqnid
label var mqnid "sleep in a net"
rename llitnidh llitnid
label var llitnid "sleep in a LLITN"
rename ntllitnidh ntllitnid
label var ntmqnid "sleep in a not broken net"
rename ntmqnidh ntmqnid
label var ntllitnid "sleep in a not broken LLITN"
rename netyearh netyear
label var netyear "when the net you sleeping in was bought"
rename freemqnh freemqn
label var freemqn "Free or purchased net"
rename mqnshoph mqnshop

label define freemqn 1 "purchased" 2 "free" 9 "missing"
label value freemqn freemqn
label var mqnshop "Using net come from"
label define mqnshop 1 "health center" 2 "pharmacy / shop / ngo" 3 "city / community room or house" 4 "issued by ngos" 5 "issued by midwife" 6 "parents / friends" 7 "other" 8 "do not know" 9 "missing"
label value mqnshop mqnshop


save e_MQNCONVERT,replace


*家計ごと
use e_MOUSTIQUAIRE,clear 
gen noftorned=.
replace noftorned=1 if h9==1


*クリニックもしくは助産婦に貰ったもの
gen nofpregnet=.
replace nofpregnet=1 if h6==1|h6==5


 collapse (sum) noftorned nofpregnet, by (mhid)
label define noftorned 0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7
label value noftorned nofpregnet noftorned
save e_MQNHHCONVERT,replace
exit
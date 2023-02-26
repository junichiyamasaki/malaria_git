use data/rawdata/3rd/e_LISTE_INDIVIDU_ACT_RDT_3rd,replace
set more off




//rdtのポジネガ追加
gen rdt=.
replace rdt=1 if flr5y==5|flr5y==6|flr5y==7
replace rdt=0 if flr5y==2
label define rdt 1 "positive" 0 "negative"
label value rdt rdt
label var rdt "RDT +"


//各部位に刺された箇所を作る　noはゼロ、dkはmissingにする

forval X= 7/13 { 
gen flr`X'c=flr`X'b
}
forval X= 7/13 { 
replace flr`X'c=. if flr`X'b==9
}
forval X= 7/13 { 
replace flr`X'c=0 if flr`X'a==2
}
gen flr= (flr7c+flr8c+flr9c+flr10c+flr11c+flr12c+flr13c)
label var flr "N. of bites"

// if bited=1
gen bite=.

replace bite=0 if flr7a==2&flr8a==2&flr9a==2&flr10a==2&flr11a==2&flr12a==2&flr13a==2
replace bite=1 if flr7a==1|flr8a==1|flr9a==1|flr10a==1|flr11a==1|flr12a==1|flr13a==1

label var bite "bite "
label define bite 1 "bited last night" 0 "not bited last night"
label value bite bite

sort flloc
by flloc: egen rdtrate=mean(rdt)
rename flid miid

save data/intermediate/3rd/e_LISTE_INDIVIDU_ACT_RDT2_3rd,replace


do codes/3rd/mosquitonet_3rd
do codes/3rd/sleep_arrangement_3rd

//マッチしてマージ
use data/rawdata/3rd/e_LISTE_INDIVIDU_MENAGE_3rd.dta, clear
merge 1:1  miid using data/intermediate/3rd/e_LISTE_INDIVIDU_ACT_RDT2_3rd
merge m:1 mhid using data/rawdata/3rd/e_MENAGE_3rd,generate(_merge2)
merge 1:m mhid hl1 using data/rawdata/3rd/e_MQNCONVERT_3rd, generate(_merge3)
merge 1:m mhid hl1 using data/rawdata/3rd/e_sleep_arrangementcov_3rd, generate(_mergesleep)
replace mqnid=0 if h1==2
replace llitnid=0 if h1==2
replace ntllitnid=0 if h1==2
drop if _merge3==2

//蚊帳に関する家計ごとの情報
merge m:1 mhid using data/rawdata/3rd/e_MQNHHCONVERT_3rd, generate(_merge4)
replace campnet=0 if h1==2
replace noftorned=0 if h1==2

gen phase=3

//# of hh member
sort mhid
by mhid: egen hhsize=count(mhid)


//agecategory
gen agec=0
replace agec=1 if r4>=7
replace agec=2 if r4>=13
label define agec 0 "0-6 years old" 1 "7-12 years old" 2 "more than 13 years old"
label value agec agec



//両親である人のid表示
gen fatheridd=.
replace fatheridd=hl1 if (r3==1|r3==2)&(r2==1)
bysort mhid phase: egen fatherid=max(fatheridd)
drop fatheridd

gen motheridd=.
replace motheridd=hl1 if (r3==1|r3==2)&(r2==2)
bysort mhid phase: egen motherid=max(motheridd)
drop motheridd

forvalues i = 1/15{
gen childrenidd`i'=.
replace childrenidd`i'=`i' if r3==3&hl1==`i'
bysort mhid phase: egen childrenid`i'=max(childrenidd`i')
drop childrenidd`i'
}

//赤ちゃんと両親が寝ているケース
gen babyandparents=0
replace babyandparents=1 if (mqnid==1&r4<=3&(mqnw1==fatherid|mqnw2==fatherid|mqnw3==fatherid|mqnw4==fatherid|mqnw5==fatherid)&(mqnw1==motherid|mqnw2==motherid|mqnw3==motherid|mqnw4==motherid|mqnw5==motherid))

gen babyandmother=0
replace babyandmother=1 if (mqnid==1&r4<=3&(mqnw1==motherid|mqnw2==motherid|mqnw3==motherid|mqnw4==motherid|mqnw5==motherid))

gen babyandfather=0
replace babyandfather=1 if (mqnid==1&r4<=3&(mqnw1==fatherid|mqnw2==fatherid|mqnw3==fatherid|mqnw4==fatherid|mqnw5==fatherid))

bysort mhid: egen babyandparentshh=max(babyandparents)
bysort mhid: egen babyandmotherhh=max(babyandmother)
bysort mhid: egen babyandfathershh=max(babyandfather)

//一緒に蚊帳に寝ている人の数
gen nwith=.
replace nwith=1 if mqnid==1
replace nwith=2 if mqnw2>0&mqnw2<=20
replace nwith=3 if mqnw3>0&mqnw3<=20
replace nwith=4 if mqnw4>0&mqnw4<=20
replace nwith=5 if mqnw5>0&mqnw5<=20

gen nwith2=.
replace nwith2=0 if nwith==1
replace nwith2=1 if (5>=nwith)&(nwith>=2)

gen nwithparent1=1 if mqnw1>0&mqnw1<=20&(mqnw1==fatherid|mqnw1==motherid)
gen nwithparent2=1 if mqnw2>0&mqnw2<=20&(mqnw2==fatherid|mqnw2==motherid)
gen nwithparent3=1 if mqnw3>0&mqnw3<=20&(mqnw3==fatherid|mqnw3==motherid)
gen nwithparent4=1 if mqnw4>0&mqnw4<=20&(mqnw4==fatherid|mqnw4==motherid)
gen nwithparent5=1 if mqnw5>0&mqnw5<=20&(mqnw5==fatherid|mqnw5==motherid)
egen nwithparent=rowtotal(nwithparent1-nwithparent5)

gen nwithchild1=.
replace nwithchild1=0 if mqnid==1
replace nwithchild1=1 if mqnw1>0&mqnw1<=20&(mqnw1==childrenid1|mqnw1==childrenid2|mqnw1==childrenid3|mqnw1==childrenid4|mqnw1==childrenid5|mqnw1==childrenid6|mqnw1==childrenid7|mqnw1==childrenid8|mqnw1==childrenid9|mqnw1==childrenid10|mqnw1==childrenid11|mqnw1==childrenid12|mqnw1==childrenid13|mqnw1==childrenid14|mqnw1==childrenid15)

gen nwithchild2=.
replace nwithchild2=0 if mqnid==1
replace nwithchild2=1 if mqnw2>0&mqnw2<=20&(mqnw2==childrenid1|mqnw2==childrenid2|mqnw2==childrenid3|mqnw2==childrenid4|mqnw2==childrenid5|mqnw2==childrenid6|mqnw2==childrenid7|mqnw2==childrenid8|mqnw2==childrenid9|mqnw2==childrenid10|mqnw2==childrenid11|mqnw2==childrenid12|mqnw2==childrenid13|mqnw2==childrenid14|mqnw2==childrenid15)

gen nwithchild3=.
replace nwithchild3=0 if mqnid==1
replace nwithchild3=1 if mqnw3>0&mqnw3<=20&(mqnw3==childrenid1|mqnw3==childrenid2|mqnw3==childrenid3|mqnw3==childrenid4|mqnw3==childrenid5|mqnw3==childrenid6|mqnw3==childrenid7|mqnw3==childrenid8|mqnw3==childrenid9|mqnw3==childrenid10|mqnw3==childrenid11|mqnw3==childrenid12|mqnw3==childrenid13|mqnw3==childrenid14|mqnw3==childrenid15)

gen nwithchild4=.
replace nwithchild4=0 if mqnid==1
replace nwithchild4=1 if mqnw4>0&mqnw4<=20&(mqnw4==childrenid1|mqnw4==childrenid2|mqnw4==childrenid3|mqnw4==childrenid4|mqnw4==childrenid5|mqnw4==childrenid6|mqnw4==childrenid7|mqnw4==childrenid8|mqnw4==childrenid9|mqnw4==childrenid10|mqnw4==childrenid11|mqnw4==childrenid12|mqnw4==childrenid13|mqnw4==childrenid14|mqnw4==childrenid15)

gen nwithchild5=.
replace nwithchild5=0 if mqnid==1
replace nwithchild5=1 if mqnw5>0&mqnw5<=20&(mqnw5==childrenid1|mqnw5==childrenid2|mqnw5==childrenid3|mqnw5==childrenid4|mqnw5==childrenid5|mqnw5==childrenid6|mqnw5==childrenid7|mqnw5==childrenid8|mqnw5==childrenid9|mqnw5==childrenid10|mqnw5==childrenid11|mqnw5==childrenid12|mqnw5==childrenid13|mqnw5==childrenid14|mqnw5==childrenid15)

gen nwithchild=nwithchild1+nwithchild2+nwithchild3+nwithchild4+nwithchild5
//treated or not
gen d=1 if  mi1==170
replace d=0 if mi1==50
label define d 1 "treated group" 0 "untreated group"
label value d d




//医療費支出
gen ea32=ea3
replace ea32=0 if ea1==0
gen ea42=ea4
replace ea42=0 if (ea1==0|ea2==0)

gen eb32=eb3
replace eb32=0 if eb1==0
gen eb42=eb4
replace eb42=0 if (eb1==0|eb2==0)

gen ec32=ec3
replace ec32=0 if ec1==0
gen ec42=ec4
replace ec42=0 if (ec1==0|ec2==0)

gen ecax32=ecax3
replace ecax32=0 if ecax1==0
gen ecax42=ecax4
replace ecax42=0 if (ecax1==0|ecax2==0)

gen ed32=ed3
replace ed32=0 if ed1==0
gen ed42=ed4
replace ed42=0 if (ed1==0|ed2==0)

gen mediex12=ea32+eb32+ec32+ecax32+ed32
gen mediex6=ea42+eb42+ec42+ecax42+ed42
label var mediex6 "Medical expences last 6 months"
label var mediex12 "Medical expences last 12 months"

//蚊帳に寝ているメンバーの数
bysort mhid: egen mqnhh=total(mqnid)

save data/intermediate/3rd/e_combine_3rd,replace



forvalues X = 1/5{
use data/rawdata/3rd/e_MOUSTIQUAIRE_3rd,clear

renpfix h h_`X'
rename h_`X'7`X' hl1
drop if hl1==.
save data/intermediate/3rd/mqntemp`X', replace

use data/intermediate/3rd/e_combine_3rd,clear

merge m:1 mhid hl1 using data/intermediate/3rd/mqntemp`X'.dta,gen(mqntemp`X') keep(master match)
erase data/intermediate/3rd/mqntemp`X'.dta
save data/intermediate/3rd/e_combine_3rd, replace
}

foreach X in 4 4ax 5yy 5ax 6 6ax 6bx 8 9 10 11 12 13{
egen h`X'=rowmax(h_1`X' h_2`X' h_3`X' h_4`X' h_5`X') 
}

label var h4 "year of obtaining the net "
label var h5yy "mosquito net bought or received free"
label var h6 "where did you get the net"
label var h8 "state of the net"
label var h9 "torn mosquito net"
label var h10 "brand of the net "
label var h11 "treated mosquito net over the last 6 months"
label var h12 "frequency of cleaning the screen"
label var h13 "using screen worn"
label values h4 h4
label values h5yy h5yy
label values h6 h6
label values h8 h8
label values h9 h9
label values h10 h10
label values h11 h11
label values h12 h12
label values h13 h13


label var h4ax "month of obtaing the net"
label var h5ax "price of the net"
label var h6ax "Usually, does anyone sleep under each net?"
label var h6bx " Whether the net is hung from a ceiling"

label value h4ax h4ax
label value h6ax h6ax
label value h6bx h6bx

drop mq1-mqntemp5
save data/intermediate/3rd/e_combine_3rd,replace

gen nwithsleep=1
replace nwithsleep=2 if spw2>0&spw2<=20
replace nwithsleep=3 if spw3>0&spw3<=20
replace nwithsleep=4 if spw4>0&spw4<=20
replace nwithsleep=5 if spw5>0&spw5<=20

save data/intermediate/3rd/e_combine_3rd, replace



//一緒に蚊帳に寝ている人のid
forvalue i =1/5{
gen mqnw`i'id=string(mhid)+"0"+string(mqnw`i') if mqnw`i'<10&mqnw`i'>=1
replace mqnw`i'id=string(mhid)+string(mqnw`i') if mqnw`i'>=10&mqnw`i'<99
destring mqnw`i'id, replace
replace mqnw`i'id=. if mqnw`i'==hl1
}
rowsort mqnw1id mqnw2id mqnw3id mqnw4id mqnw5id, generate(mqnw1ids mqnw2ids mqnw3ids mqnw4ids mqnw5ids)   missing(999999)

save data/intermediate/3rd/e_combine_3rd, replace

forvalue i =1/5{
use  data/rawdata/3rd/e_LISTE_INDIVIDU_MENAGE_3rd.dta,replace
rename miid mqnw`i'ids
rename r4 mqnw`i'age
rename r2 mqnw`i'sex
rename r3 mqnw`i'relation
keep mqnw`i'id mqnw`i'age mqnw`i'sex mqnw`i'relation
save  data/intermediate/3rd/e_LISTE_INDIVIDU_MENAGE_3rd_`i'.dta,replace

use data/intermediate/3rd/e_combine_3rd, replace
merge m:1 mqnw`i'ids using data/intermediate/3rd/e_LISTE_INDIVIDU_MENAGE_3rd_`i'.dta,gen(_wmerge`i') keep(master match) 
save data/intermediate/3rd/e_combine_3rd, replace
erase "data/intermediate/3rd/e_LISTE_INDIVIDU_MENAGE_3rd_`i'.dta"
}
sort miid


//一緒に寝ている人のid
forvalue i =1/5{
gen spw`i'id=string(mhid)+"0"+string(spw`i') if spw`i'<10&spw`i'>=1
replace spw`i'id=string(mhid)+string(spw`i') if spw`i'>=10&spw`i'<99
destring spw`i'id, replace
replace spw`i'id=. if spw`i'==hl1
}
rowsort spw1id spw2id spw3id spw4id spw5id, generate(spw1ids spw2ids spw3ids spw4ids spw5ids)   missing(999999)

save data/intermediate/3rd/e_combine_3rd, replace

forvalue i =1/5{
use  data/rawdata/3rd/e_LISTE_INDIVIDU_MENAGE_3rd.dta,replace
rename miid spw`i'ids
rename r4 spw`i'age
rename r2 spw`i'sex
rename r3 spw`i'relation
keep spw`i'id spw`i'age spw`i'sex spw`i'relation
save  data/intermediate/3rd/e_LISTE_INDIVIDU_MENAGE_3rd_`i'.dta,replace

use data/intermediate/3rd/e_combine_3rd, replace
merge m:1 spw`i'ids using data/intermediate/3rd/e_LISTE_INDIVIDU_MENAGE_3rd_`i'.dta,gen(_spwmerge`i') keep(master match) 
save data/intermediate/3rd/e_combine_3rd, replace
erase "data/intermediate/3rd/e_LISTE_INDIVIDU_MENAGE_3rd_`i'.dta"
}
sort miid


rowsort mqnw1age mqnw2age mqnw3age mqnw4age mqnw5age, generate(mqnw1ages mqnw2ages mqnw3ages mqnw4ages mqnw5ages)   missing(999999)
rowsort spw1age spw2age spw3age spw4age spw5age, generate(spw1ages spw2ages spw3ages spw4ages spw5ages)   missing(999999)
label define bedid 1 "bed" 2 "floor" 3 "other"
label value bedid bedid



gen G=1 if  mi1==170
replace G=0 if mi1==50






//寝ている人がいるベッドの数
merge m:1 mhid using data/intermediate/3rd/nofbed_3rd,nogen

save data/intermediate/3rd/e_combine_3rd, replace


* do C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\3rd\spaweight_3rd
* save spaweight_3rd,replace
* use e_combine_3rd,clear
* merge m:1 miid09 using spaweight_3rd,  nogenerate
* save e_combine_3rd ,replace

* exit



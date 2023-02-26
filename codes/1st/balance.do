use e_LISTE_INDIVIDU_ACT_RDT,replace

//rdtのポジネガ追加
gen rdt=.
replace rdt=1 if flr5==1
replace rdt=0 if flr5==2
label define rdt 1 "positive" 0 "negative"
label value rdt rdt


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
label var flr "number of mosquito bite last night"
// if bited=1
gen bite=.

replace bite=0 if flr7a==2&flr8a==2&flr9a==2&flr10a==2&flr11a==2&flr12a==2&flr13a==2
replace bite=1 if flr7a==1|flr8a==1|flr9a==1|flr10a==1|flr11a==1|flr12a==1|flr13a==1

label var bite "mosquito bite last night"
label define bite 1 "bited last night" 0 "not bited last night"
label value bite bite

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
bysort mhid: egen fatherid=max(fatheridd)

gen motheridd=.
replace motheridd=hl1 if (r3==1|r3==2)&(r2==2)
bysort mhid: egen motherid=max(motheridd)

//

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

//一緒に寝ている人の数
gen nwith=.
replace nwith=1 if mqnid==1
replace nwith=2 if mqnw2>0&mqnw2<=20
replace nwith=3 if mqnw3>0&mqnw3<=20
replace nwith=4 if mqnw4>0&mqnw4<=20
replace nwith=5 if mqnw5>0&mqnw5<=20

gen nwith2=.
replace nwith2=0 if nwith==1
replace nwith2=1 if (5>=nwith)&(nwith>=2)

save balance, replace
exit

reg hhsize d if hl1==1
outreg2 using balance,  excel replace label

local balancing=" r4 e2 rdt mqnid llitnid ntllitnid"

foreach x of local balancing {
reg `x' d
outreg2 using balance,  excel append label
}


xi: reg hhsize i.miloc if hl1==1
outreg2 using balance2,  excel replace label

foreach x of local balancing {
xi: reg `x' i.miloc
outreg2 using balance2,  excel append label
}

//SAHAMANDOTRA16,MAHATSARA17,ROND POINT18,marovato9,anivorano5,anivorano sud6,tanambao fanifarana3,AMBATOMALAMA1 (all possible)
reg hhsize d if (hl1==1)&(migrap==16|migrap==17|migrap==18|migrap==9|migrap==5|migrap==6|migrap==3|migrap==1)
outreg2 using balance3,  excel replace label

foreach x of local balancing {
reg `x' d if migrap==16|migrap==17|migrap==18|migrap==9|migrap==5|migrap==6|migrap==3|migrap==1
outreg2 using balance3,  excel append label
}

reg hhsize d if (hl1==1)&(migrap!=16&migrap!=17&migrap!=18&migrap!=9&migrap!=5&migrap!=6&migrap!=3&migrap!=1)
outreg2 using balance3,  excel append label

foreach x of local balancing {
reg `x' d if migrap!=16&migrap!=17&migrap!=18&migrap!=9&migrap!=5&migrap!=6&migrap!=3&migrap!=1
outreg2 using balance3,  excel append label
}


//SAHAMANDOTRA16,MAHATSARA17,ROND POINT18,marovato9,tanambao fanifarana3 (omit 5,6,1)
reg  hhsize d if (hl1==1)&(migrap==16|migrap==17|migrap==18|migrap==9|migrap==3)
outreg2 using balance4,  excel replace label

foreach x of local balancing {
reg `x' d if migrap==16|migrap==17|migrap==18|migrap==9|migrap==3
outreg2 using balance4,  excel append label
}
reg hhsize d if (hl1==1)&(migrap!=16&migrap!=17&migrap!=18&migrap!=9&migrap!=3)
outreg2 using balance4,  excel append label

foreach x of local balancing {
reg `x' d if migrap!=16&migrap!=17&migrap!=18&migrap!=9&migrap!=3
outreg2 using balance4,  excel append label
}

//SAHAMANDOTRA16,MAHATSARA17,ROND POINT18,anivorano5,anivorano sud6,tanambao fanifarana3,AMBATOMALAMA1 (omit 9)
reg hhsize d if (hl1==1)&(migrap==16|migrap==17|migrap==18|migrap==5|migrap==6|migrap==3|migrap==1)
outreg2 using balance5,  excel replace label

foreach x of local balancing {
reg `x' d if migrap==16|migrap==17|migrap==18|migrap==5|migrap==6|migrap==3|migrap==1
outreg2 using balance5,  excel append label
}

reg  hhsize d if (hl1==1)&(migrap!=16&migrap!=17&migrap!=18&migrap!=5&migrap!=6&migrap!=3&migrap!=1)
outreg2 using balance5,  excel append label

foreach x of local balancing {
reg `x' d if migrap!=16&migrap!=17&migrap!=18&migrap!=5&migrap!=6&migrap!=3&migrap!=1
outreg2 using balance5,  excel append label
}


//SAHAMANDOTRA16,MAHATSARA17,ROND POINT18,marovato9,anivorano5,anivorano sud6,tanambao fanifarana3,AMBATOMALAMA1 (omit 9,1)
reg hhsize d if (hl1==1)&(migrap==16|migrap==17|migrap==18|migrap==5|migrap==6|migrap==3)
outreg2 using balance6,  excel replace label

foreach x of local balancing {
reg `x' d if migrap==16|migrap==17|migrap==18|migrap==5|migrap==6|migrap==3
outreg2 using balance6,  excel append label
}

reg hhsize d if (hl1==1)&(migrap!=16&migrap!=17&migrap!=18&migrap!=5&migrap!=6&migrap!=3)
outreg2 using balance6,  excel append label

foreach x of local balancing {
reg `x' d if migrap!=16&migrap!=17&migrap!=18&migrap!=5&migrap!=6&migrap!=3
outreg2 using balance6,  excel append label
}

//Pastuer Ambalahasina13 Sahamandotra16 Tanambao Fanifarana3 Ambodibonara12 
reg hhsize d if (hl1==1)&(migrap==13|migrap==16|migrap==3|migrap==12)
outreg2 using balance7,  excel replace label

foreach x of local balancing {
reg `x' d if migrap==13|migrap==16|migrap==3|migrap==12
outreg2 using balance7,  excel append label
}

reg hhsize d if (hl1==1)&(migrap!=16&migrap!=13&migrap!=3&migrap!=12)
outreg2 using balance7,  excel append label

foreach x of local balancing {
reg `x' d if migrap!=16&migrap!=13&migrap!=3&migrap!=12
outreg2 using balance7,  excel append label
}

//道沿いambatomalama1, fanambao fanifarana3, namahoaka4, ambalahashina13, ambodiampalibe15, mahatsara I17,rondpoint18
reg hhsize d if (hl1==1)&(migrap==1|migrap==3|migrap==4|migrap==13|migrap==15|migrap==17|migrap==18)
outreg2 using balance8,  excel replace label

foreach x of local balancing {
reg `x' d if migrap==1|migrap==3|migrap==4|migrap==13|migrap==15|migrap==17|migrap==18
outreg2 using balance8,  excel append label
}

reg hhsize d if (hl1==1)&(migrap!=1&migrap!=3&migrap!=4&migrap!=13&migrap!=15&migrap!=17&migrap!=18)
outreg2 using balance8,  excel append label

foreach x of local balancing {
reg `x' d if migrap!=1&migrap!=3&migrap!=4&migrap!=13&migrap!=15&migrap!=17&migrap!=18
outreg2 using balance8,  excel append label
}

//道沿いfanambao fanifarana3, namahoaka4, ambalahashina13, ambodiampalibe15, mahatsara I17,rondpoint18 (omit 1)
reg hhsize d if (hl1==1)&(migrap==3|migrap==4|migrap==13|migrap==15|migrap==17|migrap==18)
outreg2 using balance9,  excel replace label

foreach x of local balancing {
reg `x' d if migrap==3|migrap==4|migrap==13|migrap==15|migrap==17|migrap==18
outreg2 using balance9,  excel append label
}
reg hhsize d if (hl1==1)&(migrap!=3&migrap!=4&migrap!=13&migrap!=15&migrap!=17&migrap!=18)
outreg2 using balance9,  excel append label

foreach x of local balancing {
reg `x' d if migrap!=3&migrap!=4&migrap!=13&migrap!=15&migrap!=17&migrap!=18
outreg2 using balance9,  excel append label
}


//道沿いambatomalama1,fanambao fanifarana3, namahoaka4, mahatsara I17,rondpoint18 (omit 13,15)
reg hhsize d if (hl1==1)&(migrap==1|migrap==3|migrap==4|migrap==17|migrap==18)
outreg2 using balance10,  excel replace label

foreach x of local balancing {
reg `x' d if migrap==1|migrap==3|migrap==4|migrap==17|migrap==18
outreg2 using balance10,  excel append label
}

reg hhsize d if (hl1==1)&(migrap!=3&migrap!=4&migrap!=13&migrap!=15&migrap!=17&migrap!=18)
outreg2 using balance10,  excel append label

foreach x of local balancing {
reg `x' d if migrap!=3&migrap!=4&migrap!=13&migrap!=15&migrap!=17&migrap!=18
outreg2 using balance10,  excel append label
}

//道沿いfanambao fanifarana3, namahoaka4, mahatsara I17,rondpoint18 (omit 1,13,15)
reg hhsize d if (hl1==1)&(migrap==3|migrap==4|migrap==17|migrap==18)
outreg2 using balance11,  excel replace label

foreach x of local balancing {
reg `x' d if migrap==3|migrap==4|migrap==17|migrap==18
outreg2 using balance11,  excel append label
}
reg hhsize d if (hl1==1)&(migrap!=3&migrap!=4&migrap!=17&migrap!=18)
outreg2 using balance11,  excel append label

foreach x of local balancing {
reg `x' d if migrap!=3&migrap!=4&migrap!=17&migrap!=18
outreg2 using balance11,  excel append label
}

//道沿いambatomalama1,fanambao fanifarana3, namahoaka4, sahamandotra16,mahatsara I17,rondpoint18 (omit 13,15, +16)
reg hhsize d if (hl1==1)&(migrap==1|migrap==3|migrap==4|migrap==16|migrap==17|migrap==18)
outreg2 using balance12,  excel replace label

foreach x of local balancing {
reg `x' d if migrap==1|migrap==3|migrap==4|migrap==16|migrap==17|migrap==18
outreg2 using balance12,  excel append label
}

reg hhsize d if (hl1==1)&(migrap!=1&migrap!=3&migrap!=4&migrap!=16&migrap!=17&migrap!=18)
outreg2 using balance12,  excel append label

foreach x of local balancing {
reg `x' d if migrap!=1&migrap!=3&migrap!=4&migrap!=16&migrap!=17&migrap!=18
outreg2 using balance12,  excel append label
}


//道沿い fanambao fanifarana3, namahoaka4, sahamandotra16,mahatsara I17,rondpoint18 (omit 1,13,15, +16)
reg hhsize d if (hl1==1)&(migrap==3|migrap==4|migrap==16|migrap==17|migrap==18)
outreg2 using balance13,  excel replace label


foreach x of local balancing {
reg `x' d if migrap==3|migrap==4|migrap==16|migrap==17|migrap==18
outreg2 using balance13,  excel append label
}


reg hhsize d if (hl1==1)&(migrap!=3&migrap!=4&migrap!=16&migrap!=17&migrap!=18)
outreg2 using balance13,  excel append label

foreach x of local balancing {
reg `x' d if migrap!=3&migrap!=4&migrap!=16&migrap!=17&migrap!=18
outreg2 using balance13,  excel append label
}

save balance, replace

exit

foreach x of local balancing {
ksmirnov `x' if migrap==3|migrap==4|migrap==16|migrap==17|migrap==18, by (d)
}
exit

collapse  d hhsize , by (mhid mi1 migrap)
reg hhsize d
outreg2 using balancehh1, excel replace


//SAHAMANDOTRA16,MAHATSARA17,ROND POINT18,marovato9,anivorano5,anivorano sud6,tanambao fanifarana3,AMBATOMALAMA1 (all possible)
reg hhsize d if migrap==16|migrap==17|migrap==18|migrap==9|migrap==5|migrap==6|migrap==3|migrap==1
outreg2 using balancehh1, excel append

//SAHAMANDOTRA16,MAHATSARA17,ROND POINT18,marovato9,tanambao fanifarana3 (omit 5,6,1)
reg hhsize d if migrap==16|migrap==17|migrap==18|migrap==9|migrap==3
outreg2 using balancehh1, excel append

//SAHAMANDOTRA16,MAHATSARA17,ROND POINT18,anivorano5,anivorano sud6,tanambao fanifarana3,AMBATOMALAMA1 (omit 9)
reg hhsize d if migrap==16|migrap==17|migrap==18|migrap==5|migrap==6|migrap==3|migrap==1
outreg2 using balancehh1, excel append

//SAHAMANDOTRA16,MAHATSARA17,ROND POINT18,marovato9,anivorano5,anivorano sud6,tanambao fanifarana3,AMBATOMALAMA1 (omit 9,1)
reg hhsize d if migrap==16|migrap==17|migrap==18|migrap==5|migrap==6|migrap==3
outreg2 using balancehh1, excel append

//pasteur
reg hhsize d if migrap==13|migrap==16|migrap==3|migrap==12
outreg2 using balancehh1, excel append



exit

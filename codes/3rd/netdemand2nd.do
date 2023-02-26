*2ndのデータに関するnetdemandの整形
*priceベクトルを付けないといけない
use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\2nd\e_MOUSTIQUAIRE_2nd.dta,clear
replace h4=1990 if (h4==9998|h4==.)


replace h4ax=0 if h4ax==.

replace h4ax=0 if h4<2009

sort mhid h4 h4ax
by mhid: gen id=_n

gen price=h5ax
replace price=0 if h5==2
replace price=3000 if h5==.
keep mhid id price
reshape wide price, i(mhid) j(id)
forvalue i=1/7{
replace price`i'=3000 if price`i'==.
}
save price_2nd,replace


*ここから本編
use distribution_to_sleep_3rd.dta,clear
set more off

label drop _all 
label define sp31 1 " bed " 2 " floor " 3 " other " 4 " no one sleeps in the room " 9 " missing "
label define sp51 1 " YES " 2 " NO " 8 " Don't know " 9 " MISSING " 
label define sp32 1 " bed " 2 " floor " 3 " other " 4 " no one sleeps in the room " 9 " missing " 
label define sp52 1 " YES " 2 " NO " 8 " Don't know " 9 " MISSING " 
label define sp33 1 " bed " 2 " floor " 3 " other " 4 " no one sleeps in the room " 9 " missing " 
label define sp53 1 " YES " 2 " NO " 8 " Don't know " 9 " MISSING " 
label define sp34 1 " bed " 2 " floor " 3 " other " 4 " no one sleeps in the room " 9 " missing " 
label define sp54 1 " YES " 2 " NO " 8 " Don't know " 9 " MISSING "

label value  sp31  sp31
label value  sp32  sp32
label value  sp33  sp33 
label value  sp54  sp54 
label value  sp34  sp34 
label value  sp53  sp53 
label value  sp51  sp51
label value  sp52  sp52

mvdecode sp31 sp32 sp33 sp34 sp51 sp52 sp53 sp54, mv(9)

*誰も寝てないところはsp3を4に
forvalue i = 1/4{
replace sp3`i'=4 if sp4a`i'==.&sp4b`i'==.&sp4c`i'==.&sp4d`i'==.&sp4e`i'==.&sp4f`i'==.&sp4g`i'==.
replace sp5`i'=. if sp3`i'==4 
}

keep mhid sp1a sp31-sp54
reshape wide   sp31-sp54 ,i(mhid) j(sp1a)
save e_netdemand_2nd, replace

*詰めて成型
forvalue j=1/6{
forvalue i = 1/4{
foreach a in a b c d e f g{
gen str2 sp4`a'`i'`j'string="99"
replace sp4`a'`i'`j'string=string(sp4`a'`i'`j') if sp4`a'`i'`j'>=10&sp4`a'`i'`j'<99
replace sp4`a'`i'`j'string="0"+string(sp4`a'`i'`j') if sp4`a'`i'`j'<10
}

gen str16 X`i'`j'= string(sp5`i'`j')+string(sp3`i'`j')+sp4a`i'`j'string+sp4b`i'`j'string+sp4c`i'`j'string+sp4d`i'`j'string+sp4e`i'`j'string+sp4f`i'`j'string
replace X`i'`j'= "." if X`i'`j'=="..999999999999" |X`i'`j'==".4999999999999" 
}
}
rowsort  X*, gen (Xsort1-Xsort24) descending

forvalues i=1/24{
gen mqn`i'= substr(Xsort`i',1,1)
gen bed`i'= substr(Xsort`i',2,1)
gen with1`i'= substr(Xsort`i',3,2)
gen with2`i'= substr(Xsort`i',5,2)
gen with3`i'= substr(Xsort`i',7,2)
gen with4`i'= substr(Xsort`i',9,2)
gen with5`i'= substr(Xsort`i',11,2)
gen with6`i'= substr(Xsort`i',13,2)
gen with7`i'= substr(Xsort`i',15,2)
}
destring mqn* bed* with*, replace 

*jがひと、iが場所
forvalues i=1/24{
forvalues j=1/7{
replace bed`j'=. if bed`j'==4
replace with`j'`i'= . if with`j'`i'==99
}
}
drop mqn8-with724


save e_netdemand_2nd, replace

forvalue j =1/7{
forvalue i =1/7{
use  C:\Users\J.YAMASAKI\Documents\stata11data\malaria\3rd\e_crosssection_3rd.dta,clear
rename hl1 with`j'`i'
rename r4 with`j'`i'age
rename r2 with`j'`i'sex
rename r3 with`j'`i'relation
rename mqnid with`j'`i'mqnid
rename bedid with`j'`i'bedid
drop if phase!=3
keep mhid with`j'`i' with`j'`i'age with`j'`i'sex with`j'`i'relation with`j'`i'mqnid with`j'`i'bedid
save  e_crosssection_3rd_`j'`i'.dta,replace


use e_netdemand_2nd, replace
merge m:1 mhid with`j'`i' using e_crosssection_3rd_`j'`i'.dta, nogen keep(master match)     noreport   
save e_netdemand_2nd, replace
erase e_crosssection_3rd_`j'`i'.dta
}
}


forvalue j=1/7{
forvalue i =1/7{
gen with`j'`i'teen =(with`j'`i'age>12&with`j'`i'age<20)
replace with`j'`i'teen=. if with`j'`i'age==.
gen with`j'`i'floor=(with`j'`i'bedid==2) 
replace with`j'`i'floor=. if with`j'`i'bedid==.
gen with`j'`i'female=(with`j'`i'sex==2) 
replace with`j'`i'female=. if with`j'`i'sex==.
}
}

foreach X in floor teen female{
forvalue i =1/7{
egen with`i'`X'=rowtotal(with1`i'`X'  with2`i'`X' with3`i'`X' with4`i'`X' with5`i'`X' with6`i'`X' with7`i'`X')      
}
}

forvalue i=1/7{
egen bedmember`i'=rownonmiss(with1`i' with2`i' with3`i' with4`i' with5`i' with6`i' with7`i' ) 
}



*家計レベルの一人当たり所得と村ダミーなどを付ける
save e_netdemand_2nd.dta,replace
use C:\Users\J.YAMASAKI\Documents\stata11data\malaria\2nd\e_LISTE_INDIVIDU_MENAGE_2nd, clear
sort mhid
by mhid: egen hhsize=count(mhid)
gen HHincome6_0=(HH_salary_6_0+HH_self_6_0)/(hhsize)
keep mhid HHincome6_0 migrap
duplicates drop  mhid, force 
save HHincome_2nd,replace
use e_netdemand_2nd.dta,clear
merge 1:1 mhid using  HHincome_2nd, nogen
erase  HHincome_2nd.dta

save e_netdemand_2nd.dta,replace
*プライスも付ける
merge 1:1 mhid using  price_2nd, nogen keep(match)
*高度を付ける
merge 1:1 mhid using C:\Users\J.YAMASAKI\Documents\stata11data\malaria\2nd\e_MENAGE_2nd, nogen

save e_netdemand_2nd.dta,replace
*キャンペーンでもらった枚数を把握 後でチェック
*use e_MOUSTIQUAIRE_3rd.dta,clear
*gen camp=(h5yy==3)
*egen campnet=total(camp), by(mhid)
*duplicates  drop mhid, force
*save campnet_3rd,replace

use e_netdemand_2nd.dta,clear
*merge 1:1 mhid using  campnet_3rd, nogen
*erase  campnet_3rd.dta

*ここ注意。with1 floor以降しか残していない。
keep mhid migrap mhalt mqn1-with77 with1floor-price7 bedmember* 

gen bednumber=1
forvalues i=2/7{
replace bednumber=`i' if bed`i'==1|bed`i'==2|bed`i'==3
}

forvalues i=1/7{
replace mqn`i'=0 if mqn`i'==2
}


*ここからlmqnの作成

forvalue i=1/4{
forvalue j =1/7{
gen with`j'`i'id =mhid
tostring with`j'`i'id ,replace
replace with`j'`i'id = with`j'`i'id + string(with`j'`i') if with`j'`i' >=10&with`j'`i' <99
replace with`j'`i'id = with`j'`i'id +"0"+ string(with`j'`i') if with`j'`i' <=9
replace with`j'`i'id="." if with`j'`i'==.
destring with`j'`i'id,replace
}
}
save e_netdemand_2nd.dta,replace
	
forvalue i=1/4{
forvalue j =1/7{
use C:\Users\J.YAMASAKI\Documents\stata11data\malaria\2nd\e_combine_2nd,clear
replace mqnid=. if r8==2
keep miid mqnid r0cx r4 r2 
rename miid with`j'`i'id 
rename mqnid lmqnid`j'`i'
rename r4 age`j'`i'
rename r2 sex`j'`i'
rename r0cx r0cx`j'`i'
drop if with`j'`i'id ==.
save lmqnid`j'`i'.dta,replace
use e_netdemand_2nd.dta,clear
merge m:1 with`j'`i'id using lmqnid`j'`i'.dta, nogen keep(match master)
erase lmqnid`j'`i'.dta
replace with`j'`i'id=. if r0cx`j'`i'==2
replace lmqnid`j'`i'=. if r0cx`j'`i'==2 
replace sex`j'`i'=. if r0cx`j'`i'==2 
replace age`j'`i'=. if r0cx`j'`i'==2 
gen female2nd`j'`i'=(sex`j'`i'==2)
gen teen2nd`j'`i'=(age`j'`i'>=13&age`j'`i'<=19)
gen baby2nd`j'`i'=(age`j'`i'<5)
gen femalebaby2nd`j'`i'=(age`j'`i'<5|sex`j'`i'==2)
save e_netdemand_2nd.dta,replace
}
}

forvalue i=1/4{
egen lmqn`i'=rowmean(lmqnid1`i' lmqnid2`i' lmqnid3`i' lmqnid4`i' lmqnid5`i' lmqnid6`i' lmqnid7`i')
gen lmqn01`i'=.
replace lmqn01`i'=1 if lmqn`i'>0&lmqn`i'<99
replace lmqn01`i'=0 if lmqn`i'==0

egen bedmember2nd`i'=rownonmiss(with1`i'id  with2`i'id with3`i'id with4`i'id with5`i'id with6`i'id with7`i'id) 
gen bedmember012nd`i'=.
replace bedmember012nd`i'=1 if bedmember2nd`i'>0&bedmember2nd`i'<99
replace bedmember012nd`i'=0 if bedmember2nd`i'==0
}

egen bednumber2nd=rowtotal(bedmember012nd1 bedmember012nd2 bedmember012nd3 bedmember012nd4) 

*ベットの数だけちゃんと情報があるかチェック

gen numbermatch=0
replace numbermatch=1 if lmqn1!=.&bednumber2nd==1
replace numbermatch=1 if lmqn1!=.&lmqn2!=.&bednumber2nd==2
replace numbermatch=1 if lmqn1!=.&lmqn2!=.&lmqn3!=.&bednumber2nd==3
replace numbermatch=1 if lmqn1!=.&lmqn2!=.&lmqn3!=.&lmqn4!=.&bednumber2nd==4

gen G=(mhid>=130000)

*最後に2nd3rdでconsistentな家計を集める
save e_netdemand_2nd.dta,replace
use bedcheck2nd3rd.dta,clear
keep mhid
duplicates drop mhid, force
save bedcheck2nd3rdformatch,replace

use  e_netdemand_2nd.dta,clear
merge 1:1 mhid using bedcheck2nd3rdformatch, nogen keep(match)

drop if bednumber2nd>3
drop if HHincome==.
drop if numbermatch==0

*lmqnをmqnに、floorなどのメンバー数調整
forvalue i=1/4{
replace mqn`i'=lmqn`i'
gen floor`i'2nd=bedmember`i' if with`i'floor!=0
replace  floor`i'2nd=0 if with`i'floor==0
egen teen`i'2nd=rowtotal(teen2nd1`i' teen2nd2`i' teen2nd3`i' teen2nd4`i')
egen baby`i'2nd=rowtotal(baby2nd1`i' baby2nd2`i' baby2nd3`i' baby2nd4`i')
egen female`i'2nd=rowtotal(female2nd1`i' female2nd2`i' female2nd3`i' female2nd4`i')
egen femalebaby`i'2nd=rowtotal(femalebaby2nd1`i' femalebaby2nd2`i' femalebaby2nd3`i' femalebaby2nd4`i')
}

forvalue i=1/7{
forvalue j=1/4{
gen floor2nd`i'`j'=(with`i'`j'!=.&floor`j'2nd==1)
}
}
save e_netdemand_2nd.dta,replace

*2ndからメンバーが減った家計は削る。だれとどういう所で寝ていたか分らないので・・・。
*2ndで既にいなかった人は二回ともr0dx!=1になっているのが問題かも。
 use  C:\Users\J.YAMASAKI\Documents\stata11data\malaria\3rd\e_crosssection_3rd.dta,replace
drop if phase==1
 drop if miid==.
tsset miid phase
gen drop2nd3rd=(((r0dx!=1&r0dx!=.)&L.r0dx==1)|((r0dx!=1&r0dx!=.)&L.r0cx==2))
replace drop2nd3rd=0 if r0cx==2
collapse (max) drop2nd3rd, by(mhid)
keep if drop2nd3rd==1
save drop2nd3rd.dta,replace
	
use e_netdemand_2nd.dta,clear
merge 1:1 mhid using drop2nd3rd, nogen keep(master)
erase drop2nd3rd.dta

*パレートウェイトのを作る
use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\2nd\e_MOUSTIQUAIRE_2nd.dta,clear
gen csb=(h6==1)
gen csbfree=(h6==1&h5==2)

collapse (max) csb csbfree, by(mhid)
save pareto.dta, replace


use e_netdemand_2nd.dta,clear
merge 1:1 mhid using pareto, nogen
erase pareto.dta

forvalue i=1/4{
gen csbfemalebaby`i'2nd=femalebaby`i'2nd if csb>0
replace csbfemalebaby`i'2nd=0 if csb==0
gen csbfreefemalebaby`i'2nd=femalebaby`i'2nd if csbfree>0
replace csbfemalebaby`i'2nd=0 if csbfree==0
gen csbfemale`i'2nd=female`i'2nd if csb>0
replace csbfemale`i'2nd=0 if csb==0
gen csbbaby`i'2nd=baby`i'2nd if csb>0
replace csbbaby`i'2nd=0 if csb==0
}
forvalue i=1/7{
forvalue j=1/4{
gen csbfemale2nd`i'`j'=female2nd`i'`j' if csb>0
replace csbfemale2nd`i'`j'=0 if csb==0
gen csbbaby2nd`i'`j'=baby2nd`i'`j' if csb>0
replace csbbaby2nd`i'`j'=0 if csb==0
}
}

*所得が妙に高い人は除く
drop if HHincome6>500000
gen decision=1
replace decision=2 if mqn1==1&bednumber2nd==1

replace decision=2 if mqn1==0&mqn2==1&bednumber2nd==2
replace decision=3 if mqn1==1&mqn2==0&bednumber2nd==2
replace decision=4 if mqn1==1&mqn2==1&bednumber2nd==2


replace decision=2 if mqn1==0&mqn2==0&mqn3==1&bednumber2nd==3
replace decision=3 if mqn1==0&mqn2==1&mqn3==0&bednumber2nd==3
replace decision=4 if mqn1==0&mqn2==1&mqn3==1&bednumber2nd==3
replace decision=5 if mqn1==1&mqn2==0&mqn3==0&bednumber2nd==3
replace decision=6 if mqn1==1&mqn2==0&mqn3==0&bednumber2nd==3
replace decision=7 if mqn1==1&mqn2==1&mqn3==0&bednumber2nd==3
replace decision=8 if mqn1==1&mqn2==1&mqn3==1&bednumber2nd==3



replace decision=2 if mqn1==0&mqn2==0&mqn3==0&mqn4==1&bednumber2nd==4
replace decision=3 if mqn1==0&mqn2==0&mqn3==1&mqn4==0&bednumber2nd==4
replace decision=4 if mqn1==0&mqn2==0&mqn3==1&mqn4==1&bednumber2nd==4
replace decision=5 if mqn1==0&mqn2==1&mqn3==0&mqn4==0&bednumber2nd==4
replace decision=6 if mqn1==0&mqn2==1&mqn3==0&mqn4==1&bednumber2nd==4
replace decision=7 if mqn1==0&mqn2==1&mqn3==1&mqn4==0&bednumber2nd==4
replace decision=8 if mqn1==0&mqn2==1&mqn3==1&mqn4==1&bednumber2nd==4
replace decision=9 if mqn1==1&mqn2==0&mqn3==0&mqn4==0&bednumber2nd==4
replace decision=10 if mqn1==1&mqn2==0&mqn3==0&mqn4==1&bednumber2nd==4
replace decision=11 if mqn1==1&mqn2==0&mqn3==1&mqn4==0&bednumber2nd==4
replace decision=12 if mqn1==1&mqn2==0&mqn3==1&mqn4==1&bednumber2nd==4
replace decision=13 if mqn1==1&mqn2==1&mqn3==0&mqn4==0&bednumber2nd==4
replace decision=14 if mqn1==1&mqn2==1&mqn3==0&mqn4==1&bednumber2nd==4
replace decision=15 if mqn1==1&mqn2==1&mqn3==1&mqn4==0&bednumber2nd==4
replace decision=16 if mqn1==1&mqn2==1&mqn3==1&mqn4==1&bednumber2nd==4


egen hhid=group(mhid)
egen mqn=rowtotal(mqn1 mqn2 mqn3 mqn4)

save e_netdemand_2nd.dta,replace


drop if G==1

 foreach v in teen female floor baby csbfemale csbbaby {
forvalue i=1/4{
outsheet `v'2nd1`i'  `v'2nd2`i' `v'2nd3`i' `v'2nd4`i' `v'2nd5`i'  `v'2nd6`i'  `v'2nd7`i' using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand/`v'`i'2nd.csv, comma nolabel noname replace
}
}

outsheet teen12nd teen22nd  teen32nd using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\teen2nd.csv , comma nolabel noname replace

outsheet floor12nd floor22nd floor32nd using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\floor2nd.csv , comma nolabel noname replace

outsheet female12nd female22nd female32nd using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\female2nd.csv , comma nolabel noname replace


outsheet csbfemalebaby12nd csbfemalebaby22nd  csbfemalebaby32nd  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\csbfemalebaby2nd.csv , comma nolabel noname replace


outsheet csbfemale12nd csbfemale22nd  csbfemale32nd  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\csbfemale2nd.csv , comma nolabel noname replace

outsheet hhid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\hhid2nd.csv , comma nolabel noname replace

outsheet bednumber2nd using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\bednumber2nd.csv , comma nolabel noname replace

outsheet bedmember2nd1 bedmember2nd2 bedmember2nd3 bedmember2nd4 using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\bedmember2nd.csv , comma nolabel noname replace

outsheet HHincome6 using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\hhincome2nd.csv , comma nolabel noname replace

outsheet decision using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\decision2nd.csv , comma nolabel noname replace

outsheet price1-price7 using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\price2nd.csv , comma nolabel noname replace
exit

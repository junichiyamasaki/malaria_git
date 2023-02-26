*3rdのデータに関するnetdemandの整形
*priceベクトルを付けないといけない
use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\3rd\e_MOUSTIQUAIRE_3rd.dta,clear
replace h4=1990 if (h4==9998|h4==.)&h5yy!=3
replace h4ax=11 if (mq1==50&h5yy==3)&(h4ax==.|h4ax==98)	
replace h4ax=12 if (mq1==170&h5yy==3)&(h4ax==.|h4ax==98)


replace h4ax=10 if (mq1==50&h5yy!=3)&(h4==2010|h4ax==98)
replace h4ax=0 if (mq1==50&h5yy!=3)&(h4==2009|h4ax==98)	
replace h4ax=11 if (mq1==170&h5yy!=3)&(h4==2009|h4ax==98)
replace h4ax=0 if (mq1==170&h5yy!=3)&(h4==2010|h4ax==98)

replace h4ax=0 if h4<2009

sort mhid h4 h4ax
by mhid: gen id=_n

gen price=h5ax
replace price=0 if h5yy==2|h5yy==3
replace price=3000 if h5yy==.
keep mhid id price
reshape wide price, i(mhid) j(id)
forvalue i=1/7{
replace price`i'=3000 if price`i'==.
}
save price_3rd,replace


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
save e_netdemand_3rd, replace

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


save e_netdemand_3rd, replace

forvalue j =1/7{
forvalue i =1/7{
use  e_crosssection_3rd.dta,replace
rename hl1 with`j'`i'
rename r4 with`j'`i'age
rename r2 with`j'`i'sex
rename r3 with`j'`i'relation
rename mqnid with`j'`i'mqnid
rename bedid with`j'`i'bedid
drop if phase!=3
keep mhid with`j'`i' with`j'`i'age with`j'`i'sex with`j'`i'relation with`j'`i'mqnid with`j'`i'bedid
save  e_crosssection_3rd_`j'`i'.dta,replace


use e_netdemand_3rd, replace
merge m:1 mhid with`j'`i' using e_crosssection_3rd_`j'`i'.dta, nogen keep(master match)     noreport   
save e_netdemand_3rd, replace
erase e_crosssection_3rd_`j'`i'.dta
}
}


forvalue j=1/7{
forvalue i =1/7{
gen with`j'`i'teen =(with`j'`i'age>12&with`j'`i'age<20)
replace with`j'`i'teen=. if with`j'`i'age==.
gen with`j'`i'floor=(with`j'`i'bedid==2) 
replace with`j'`i'floor=. if with`j'`i'bedid==.
}
}

foreach X in floor teen {
forvalue i =1/7{
egen with`i'`X'=rowtotal(with1`i'`X'  with2`i'`X' with3`i'`X' with4`i'`X' with5`i'`X' with6`i'`X' with7`i'`X')      
}
}

forvalue i=1/7{
egen bedmember`i'=rownonmiss(with1`i' with2`i' with3`i' with4`i' with5`i' with6`i' with7`i' ) 
}



*家計レベルの一人当たり所得と村ダミーなどを付ける
save e_netdemand_3rd.dta,replace
use e_LISTE_INDIVIDU_MENAGE_3rd, clear
sort mhid
by mhid: egen hhsize=count(mhid)
gen HHincome6_0=(HH_salary_6_0+HH_self_6_0)/(hhsize)
keep mhid HHincome6_0 migrap
duplicates drop  mhid, force 
save HHincome_3rd,replace
use e_netdemand_3rd.dta,clear
merge 1:1 mhid using  HHincome_3rd, nogen
erase  HHincome_3rd.dta

save e_netdemand_3rd.dta,replace
*プライスも付ける
merge 1:1 mhid using  price_3rd, nogen keep(match)
*高度を付ける
merge 1:1 mhid using e_MENAGE_3rd, nogen

save e_netdemand_3rd.dta,replace
*キャンペーンでもらった枚数を把握
use e_MOUSTIQUAIRE_3rd.dta,clear
gen camp=(h5yy==3)
egen campnet=total(camp), by(mhid)
duplicates  drop mhid, force
save campnet_3rd,replace

use e_netdemand_3rd.dta,clear
merge 1:1 mhid using  campnet_3rd, nogen
erase  campnet_3rd.dta

*ここ注意。with1 floor以降しか残していない。
keep mhid migrap mhalt campnet mqn1-with77 with1floor-price7 bedmember* 

gen bednumber=1
forvalues i=2/7{
replace bednumber=`i' if bed`i'==1|bed`i'==2|bed`i'==3
}

forvalues i=1/7{
replace mqn`i'=0 if mqn`i'==2
}

drop if bednumber>4
drop if HHincome==.

gen decision=1
replace decision=2 if mqn1==1&bednumber==1

replace decision=2 if mqn1==0&mqn2==1&bednumber==2
replace decision=3 if mqn1==1&mqn2==0&bednumber==2
replace decision=4 if mqn1==1&mqn2==1&bednumber==2


replace decision=2 if mqn1==0&mqn2==0&mqn3==1&bednumber==3
replace decision=3 if mqn1==0&mqn2==1&mqn3==0&bednumber==3
replace decision=4 if mqn1==0&mqn2==1&mqn3==1&bednumber==3
replace decision=5 if mqn1==1&mqn2==0&mqn3==0&bednumber==3
replace decision=6 if mqn1==1&mqn2==0&mqn3==0&bednumber==3
replace decision=7 if mqn1==1&mqn2==1&mqn3==0&bednumber==3
replace decision=8 if mqn1==1&mqn2==1&mqn3==1&bednumber==3



replace decision=2 if mqn1==0&mqn2==0&mqn3==0&mqn4==1&bednumber==4
replace decision=3 if mqn1==0&mqn2==0&mqn3==1&mqn4==0&bednumber==4
replace decision=4 if mqn1==0&mqn2==0&mqn3==1&mqn4==1&bednumber==4
replace decision=5 if mqn1==0&mqn2==1&mqn3==0&mqn4==0&bednumber==4
replace decision=6 if mqn1==0&mqn2==1&mqn3==0&mqn4==1&bednumber==4
replace decision=7 if mqn1==0&mqn2==1&mqn3==1&mqn4==0&bednumber==4
replace decision=8 if mqn1==0&mqn2==1&mqn3==1&mqn4==1&bednumber==4
replace decision=9 if mqn1==1&mqn2==0&mqn3==0&mqn4==0&bednumber==4
replace decision=10 if mqn1==1&mqn2==0&mqn3==0&mqn4==1&bednumber==4
replace decision=11 if mqn1==1&mqn2==0&mqn3==1&mqn4==0&bednumber==4
replace decision=12 if mqn1==1&mqn2==0&mqn3==1&mqn4==1&bednumber==4
replace decision=13 if mqn1==1&mqn2==1&mqn3==0&mqn4==0&bednumber==4
replace decision=14 if mqn1==1&mqn2==1&mqn3==0&mqn4==1&bednumber==4
replace decision=15 if mqn1==1&mqn2==1&mqn3==1&mqn4==0&bednumber==4
replace decision=16 if mqn1==1&mqn2==1&mqn3==1&mqn4==1&bednumber==4


egen hhid=group(mhid)
egen mqn=rowtotal(mqn1 mqn2 mqn3 mqn4)
outsheet with1teen-with4teen using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\teen.csv , comma nolabel noname replace

outsheet with1floor-with4floor using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\floor.csv , comma nolabel noname replace

outsheet hhid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\hhid.csv , comma nolabel noname replace

outsheet bednumber using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\bednumber.csv , comma nolabel noname replace

outsheet bedmember1-bedmember4 using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\bedmember.csv , comma nolabel noname replace

outsheet HHincome6 using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\hhincome.csv , comma nolabel noname replace

outsheet decision using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\decision.csv , comma nolabel noname replace

outsheet price1-price7 using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\price.csv , comma nolabel noname replace
exit

* In e_panel_3rd

* cd  $dropbox\Malaria\forpaper

use data/intermediate/3rd/e_panel_3rd,clear
set more off

eststo clear

label define phase 1 "1st" 2 "2nd" 3"3rd"
label value phase phase


gen holiday=0
replace holiday=1 if (mh4j==12|mh4j==13|mh4j==19|mh4j==20|mh4j==26|mh4j==27)&mh4a==2010

gen HHincome12_6=(HH_salary_12_6+HH_self_12_6)/(hhsize*180)
gen HHincome6_0=(HH_salary_6_0+HH_self_6_0)/(hhsize*180)


*3rdで年齢統一(これはまずいか)
replace r4=F.r4 if phase==2
replace r4=F2.r4 if phase==1

gen lrdt=L.rdt
gen outside=r8-1
gen doutside=D.outside
egen outsidehh=total(outside) , by (mhid09 phase)
gen nmqnhh=hhsize-mqnhh-outsidehh
gen mqnhhother=(mqnhh-mqnid)/hhsize
gen campnetper=campnet/L.nmqnhh
gen campnetper01=(campnetper>0&campnetper<1)
gen campnetper12=(campnetper>=1&campnetper<2)
gen campnetper1=(campnetper>=1&campnetper<99)
gen campnetper2=(campnetper>=2&campnetper<99)
gen campnetper0=(campnetper>0&campnetper<99)

gen work_6_0=((9999999>salary_6_0&salary_6_0>0)|(9999999>self_6_0&self_6_0>0))
gen work_12_6=((9999999>salary_12_6&salary_12_6>0)|(9999999>self_12_6&self_12_6>0))
gen work=(work_6_0==1|work_12_6==1)

gen age19=r4
replace age19=19 if r4>=19&r4<99
label define age19 1 "older than 19"
label value age19 age19

gen schoolage=(r4>=6&r4<=16)
gen adult=(r4>=20&r4!=.)
gen baby=(r4<=5)
gen underteen=(r4>=6&r4<=12)
gen teen=(r4>=13&r4<=19) 
gen lteen=(r4>=13&r4<=15) 
gen hteen=(r4>=16&r4<=19) 
gen ljuv=(r4>=6&r4<=9)
gen hjuv=(r4>=10&r4<=12)

gen pregnant=(h31==1)
gen female=(r2==2)


label define female 0 "male" 1 "female"
label value female female

egen rdthhtotal=total(rdt) , by (mhid09 phase) 
gen rdtotherhh=rdthhtotal-rdt



egen mqnhhtotal=total(mqnid) , by (mhid09 phase) 
gen mqnotherhhs=(mqnhhtotal-mqnid)/hhsize

gen cschool=(e3==1) if e3!=.
label define cschool 0 "no school" 1 "school"
label value cschool cschool

*help says: xtprobit fits random-effects and population-averaged probit models.    There is no command for a conditional fixed-effects model, as there does not exist a sufficient statistic allowing the fixed effects to be conditioned out of the likelihood.  Unconditional fixed-effects probit models may be fit with probit command with indicator variables for the panels.  However, unconditional fixed-effects estimates are biased.

gen inactivefever=h18b
replace inactivefever=0 if h18a==2
label var inactivefever "Fever inactive(6m)"

gen fathernwith=nwith if (r3==1&r2==1)|(r3==2&r2==1)
egen fathernwithhh=max(fathernwith), by (mhid09 phase)
gen mothernwith=nwith if (r3==1&r2==2)|(r3==2&r2==2)
egen mothernwithhh=max(mothernwith), by (mhid09 phase)
gen parentnwith=nwith if (r3==1|r3==2)
egen parentnwithhh=min(parentnwith), by (mhid09 phase)


gen bound=(migrap==4|migrap==5|migrap==6|migrap==9|migrap==13|migrap==14|migrap==15|migrap==16)
replace bound=1 if migrap!=2&migrap!=7&migrap!=8&migrap!=9&migrap!=10&migrap!=11&migrap!=12
*replace bound=0 if migrap==1|migrap==5|migrap==6|migrap==9|migrap==13|migrap==14|migrap==16

gen road=(migrap==3|migrap==4|migrap==13|migrap==15|migrap==17|migrap==18)

*nwithsleepを通期
replace nwithsleep=F.nwithsleep if phase==2
replace nwithsleep=F2.nwithsleep if phase==1

* age60の作成
gen age60=r4
replace age60=60 if r4>=60&r4<=98
label define age60  0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 11 11 12 12 13 13 14 14 15 15 16 16 17 17 18 18 19 19 20 20 21 21 22 22 23 23 24 24 25 25 26 26 27 27 28 28 29 29 30 30 31 31 32 32 33 33 34 34 35 35 36 36 37 37 38 38 39 39 40 40 41 41 42 42 43 43 44 44 45 45 46 46 47 47 48 48 49 49 50 50 51 51 52 52 53 53 54 54 55 55 56 56 57 57 58 58 59 59 60 "over 60"
label value age60 age60


gen age20=r4
replace age20=20 if r4>=20&r4<=98
label value age20 age60

gen age05=(r4<=5&r4>=0)
gen age612=(r4<=12&r4>5)
gen age1318=(r4<=18&r4>12)
gen age1924=(r4<=24&r4>18)
gen age2540=(r4<=40&r4>24)
gen age41=(r4<=98&r4>=41)


gen age04=(r4<=4&r4>=0)
gen age57=(r4<=7&r4>4)
gen age810=(r4<=10&r4>7)
gen age1113=(r4<=13&r4>10)
gen age1416=(r4<=16&r4>13)
gen age1719=(r4<=19&r4>16)
gen age2024=(r4<=24&r4>19)

gen agecategory=1 if r4>=0&r4<=5
replace agecategory=2 if r4>=6&r4<=8
replace agecategory=3 if r4>=9&r4<=11
replace agecategory=4 if r4>=12&r4<=14
replace agecategory=5 if r4>=15&r4<=17
replace agecategory=6 if r4>=18&r4<=20
replace agecategory=7 if r4>=21&r4<=25
replace agecategory=8 if r4>=26&r4<=40
replace agecategory=9 if r4>=41&r4<=98
label define agecategory 1 "0-5" 2 "6-8" 3 "9-11" 4 "12-14" 5 "15-17" 6 "18-20" 7"21-25" 8"26-40" 9"41-"
label value agecategory agecategory 

gen agecategory2=1 if r4>=0&r4<=5
replace agecategory2=2 if r4>=6&r4<=12
replace agecategory2=3 if r4>=13&r4<=19
replace agecategory2=4 if r4>=20&r4<=40
replace agecategory2=5 if r4>=41&r4<=98
label define agecategory2 1 "0-5" 2 "6-12" 3 "13-19" 4 "20-40" 5 "41-" 
label value agecategory2 agecategory2 

gen age68=(r4<=8&r4>5)
gen age911=(r4<=11&r4>7)
gen age1214=(r4<=14&r4>11)
gen age1517=(r4<=17&r4>14)
gen age1820=(r4<=20&r4>17)
gen age2125=(r4<=25&r4>20)
gen age2640=(r4<=40&r4>25)


replace cschool=0 if e1==2
replace cschool=0 if agecategory>=8

* *年齢によるrdt、蚊帳、蚊に刺されるへの効果の関係
* *まずはグラフ作成
* graph bar mqnid , over(age60, label(labsize(tiny) angle(vertical) alternate)) by(G phase)
* * graph export  age60_and_mosquitonet.eps,replace
* * graph export  draft/age60_and_mosquitonet.eps,replace
* graph export  age60_and_mosquitonet.pdf,replace
* graph bar mqnid if r8==1, over(age60, label(labsize(tiny) angle(vertical) alternate)) by(G phase)
* * graph export age60_and_mosquitonet_ifslept.eps,replace
* * graph export  draft/age60_and_mosquitonet_ifslept.eps,replace
* graph export age60_and_mosquitonet_ifslept.pdf,replace


* graph bar mqnid if phase<=2, over(age60, label(labsize(tiny) angle(vertical) alternate)) by(G phase)
* * graph export  draft/age60_and_mosquitonet_2nd.eps,replace
* graph export  age60_and_mosquitonet.pdf,replace
* graph bar mqnid if phase<=2&r8==1, over(age60, label(labsize(tiny) angle(vertical) alternate)) by(G phase)
* * graph export  draft/age60_and_mosquitonet_ifslept_2nd.eps,replace


* graph bar rdt , over(age60, label(labsize(tiny) angle(vertical) alternate) )  by(G phase) 
* * graph export  age60_and_rdt.eps,replace
* * graph export  draft/age60_and_rdt.eps,replace
* graph export  age60_and_rdt.pdf,replace
* graph bar rdt if r8==1, over(age60, label(labsize(tiny) angle(vertical) alternate) )by(G phase)  
* * graph export  age60_and_rdt_ifslept.eps,replace
* graph export  age60_and_rdt_ifslept.pdf,replace

* graph bar rdt if r8==1, over(mqnid, label(labsize(tiny) angle(vertical) alternate) )by(G phase)  
* * graph export  mqnid_and_rdt_ifslept.eps,replace
* graph export  mqnid_and_rdt_ifslept.pdf,replace


* graph bar llitnid  , over(age60, label(labsize(tiny) angle(vertical) alternate)) by(G phase) 
* graph export age60_and_llitn_3rd.eps,replace
* graph export age60_and_llitn_3rd.pdf,replace
* graph twoway lpolyci inactive age60  ,by(rdt) degree(2) 
* graph export age60_and_fever.eps,replace
* graph export age60_and_fever.pdf,replace
* graph twoway lpolyci outside age60, by(female)
* graph export age60_and_outside.eps,replace

*gen drdt=D.rdt
*graph bar  drdt, over(age60, label(labsize(tiny) angle(vertical) alternate) by(G)
*graph export age60_and_drdt_3rd.eps,replace
*graph export age60_and_drdt_3rd.pdf,replace
*graph bar drdt if L.mqnid==0&mqnid==1, over(age60, label(labsize(tiny) angle(vertical) alternate)) by(G)

drop D
gen D=0
replace D=1 if phase==2&G==1
replace D=1 if phase==3&G==0

gen age60sq=age60^2
gen age60cu=age60^3
gen Dandage60=D*age60
gen Dandage60sq=D*age60sq
gen Dandage60cu=D*age60cu

gen Dandage04=D*age04
gen Dandage57=D*age57
gen Dandage810=D*age810
gen Dandage1113=D*age1113
gen Dandage1416=D*age1416
gen Dandage1719=D*age1719
gen Dandage2024=D*age2024


gen Dandage05=D*age05
gen Dandage612=D*age612
gen Dandage1318=D*age1318
gen Dandage1924=D*age1924
gen Dandage2540=D*age2540
gen Dandage41=D*age41

gen Danddmqnid1=(D==1&D.mqnid==1)
gen Danddmqnid0=(D==1&D.mqnid==0)

gen Dandschoolage=D*schoolage
gen Dandbaby=D*baby
gen Dandteen=D*teen
gen Dandunderteen=D*underteen
gen Dandhteen=D*hteen
gen Dandlteen=D*lteen
gen Dandhjuv=D*hjuv
gen Dandljuv=D*ljuv

gen logHHincome6_0at1st=log(HHincome12_6) if phase==2
replace logHHincome6_0at1st=L.logHHincome6_0at1st if phase==3
replace logHHincome6_0at1st=F.logHHincome6_0at1st if phase==1
gen DandlogHHincome6_0at1st=D*logHHincome6_0at1st
gen mqnidandlogHHincome6_0at1st=mqnid*logHHincome6_0at1st

label var logHHincome6_0at1st "HH Log Income Level at the 1st" 
label var DandlogHHincome6_0at1st "D * HH Log Income Level at the 1st" 

gen diarrhea = (h19a==1) if h19a!=.
gen dizzy = (h20a==1) if h20a!=.
gen fever = (h18a==1) if h18a!=.

*欠席日数 
replace e7=e7y if phase==3

gen absence=e6
replace absence=0 if e5==2
gen absence2=absence
replace absence2=0 if e7!=2
replace absence2=. if e5==.

label var absence "Absence  Last Month"
label var absence2  "Sick Absence Last Month"

gen absence6=e9
replace absence6=0 if e8==2
gen absence62=absence6
replace absence62=0 if e10!=2
replace absence62=. if e8==.


label var absence6 "Absence 6 months"
label var absence62  "Sick Absence 6 months"

label var D "Distributed"


*家計レベルでの所得の変化
gen D_HH_salary_6_0=HH_salary_6_0-HH_salary_12_6
gen D_HH_self_6_0=HH_self_6_0-HH_self_12_6


*個人レベルでの所得
gen D_salary_6_0=salary_6_0-salary_12_6
gen D_self_6_0=self_6_0-self_12_6


*医療費支出への効果
gen dHH_salary_6_0=D.HH_salary_6_0
gen dHH_self_6_0=D.HH_salary_6_0

eststo clear

 
foreach X in rdt mqnid bite flr absence2 inactivefever  {
gen d`X' =D.`X' 
reg d`X'   Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024   Dandage2540 Dandage41 age04 age57 age810 age1113 age1416 age1719 age2024  age2540 age41 if phase==2, noconstant     vce(cluster migrap)
eststo
reg d`X'   Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024   Dandage2540 Dandage41 age04 age57 age810 age1113 age1416 age1719 age2024  age2540 age41 if phase==3, noconstant     vce(cluster migrap)
eststo
}

label var drdt "$\Delta$ RDT +"
label var dmqnid "$\Delta$ Net Use"
label var dbite "$\Delta$ Bite" 
label var dflr "$\Delta$ N. of bites" 
label var dabsence2 "$\Delta$ Sick Absence (1m)" 

label var dinactivefever "$\Delta$ Inacitive Day in (6m)"

* esttab using DD.tex,   p  replace  addnotes( p-values are caliculated by cluster robust standard errors (village level).Odd columns are about the 2nd phase. Even columns are about the 3rd phase.) mlabels(,depvars) label
* eststo clear



* foreach X in rdt mqnid bite flr absence2  inactivefever  {
* reg d`X'   Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024   Dandage2540 Dandage41 age04 age57 age810 age1113 age1416 age1719 age2024  age2540 age41 if phase==2&bound==1, noconstant     vce(cluster migrap)
* eststo
* reg d`X'   Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024   Dandage2540 Dandage41 age04 age57 age810 age1113 age1416 age1719 age2024  age2540 age41 if phase==3&bound==1, noconstant     vce(cluster migrap)
* eststo
* }

* esttab using DD_b.tex,   p  replace  addnotes( Not-inland villages are used. p-values are caliculated by cluster robust standard errors (village level).Odd columns are about the 2nd phase. Even columns are about the 3rd phase.) mlabels(,depvars) label
* eststo clear




foreach X in twork  thhtask tschool  tsickrest  trest  tcare salary_6_0 self_6_0 {
gen d`X' =D.`X' 
reg d`X'   Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024   Dandage2540 Dandage41 age04 age57 age810 age1113 age1416 age1719 age2024  age2540 age41 if phase==3, noconstant     vce(cluster migrap)
eststo
}


label var dtwork "$\Delta$ hours when he was working yesterday"
label var dthhtask "$\Delta$ hours when he was doing househol task yesterday"
label var dtschool "$\Delta$ hours when he was going school yesterday"
label var dtsickrest "$\Delta$ hours when he was rest because of sick yesterday"
label var dtrest "$\Delta$ hours when he was rest not because of sick yesterday"
label var dtcare "$\Delta$ hours when he was taking care of sick members yesterday"
label var dsalary_6_0 "$\Delta$ salaly income during the last 6 months"
label var dself_6_0 "$\Delta$ self production income during the last 6 months"

* esttab using DD2.tex,   p  replace   mlabels(,depvars) addnotes( p-values are caliculated by cluster robust standard errors (village level). All columns are about the 3rd phase.) 
* eststo clear

* graph twoway lpolyci diarrhea logHHincome6_0 if phase==1&underteen==1,xtitle(Log of Last 6 Month HH Income) ytitle("Inactive due to Diarrhea in 6 Months") legend(off) name(a,replace)
* graph twoway lpolyci fever logHHincome6_0 if phase==1&underteen==1,xtitle(Log of Last 6 Month HH Income) ytitle("Inactive due to Fever in 6 Months") legend(off) name(b,replace)
* graph twoway lpolyci dizzy logHHincome6_0 if phase==1&underteen==1,xtitle(Log of Last 6 Month HH Income) ytitle("Inactive due to Dizziness in 6 Months") legend(off) name(c,replace)
* graph twoway lpolyci rdt logHHincome6_0 if phase==1&underteen==1,xtitle(Log of Last 6 Month HH Income) ytitle("RDT +") legend(off)name(d,replace)
* graph export /Users/J_YAMASAKI/Dropbox/Madagascar_LLIN/presentation/costtarget.pdf,replace

* gr combine a b c d 



* foreach X in twork  thhtask tschool  tsickrest  trest  tcare salary_6_0 self_6_0 {

* reg d`X'   Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024   Dandage2540 Dandage41 age04 age57 age810 age1113 age1416 age1719 age2024  age2540 age41 if phase==3&bound==1, noconstant     vce(cluster migrap)
* eststo
* }

* esttab using DD2_b.tex,   p  replace   mlabels(,depvars) label addnotes(Not-inland villages are used. p-values are caliculated by cluster robust standard errors (village level). All columns are about the 3rd phase.) 
* eststo clear

* foreach X in mediex6{
* gen d`X' =D.`X' 
* reg d`X'   D if phase==3&r3==1,     vce(cluster migrap)
* eststo
* }


* label var dmediex6 "$\Delta$ Medical Expenses in these 6 Months"
* esttab using DD3.tex,   p  replace   mlabels(,depvars) label addnotes( p-values are caliculated by cluster robust standard errors (village level). All columns are about the 3rd phase.) 
* eststo clear


* foreach X in mediex6{
* reg d`X'   D if phase==3&r3==1&bound==1,     vce(cluster migrap)
* eststo
* }


* foreach X in rdt  bite flr absence2 mediex6 inactivefever  {
* gen mqnidandl`X'=mqnid*L.`X'
* gen Dandl`X'=D*L.`X'
* ivregress 2sls `X'  (mqnid = D) if phase==2, vce(cluster migrap)
* eststo
* ivregress 2sls `X'  (mqnid = D) if phase==3, vce(cluster migrap)
* eststo
* ivregress 2sls `X' L.`X'   (mqnid mqnidandl`X' = D Dandl`X') if phase==2, vce(cluster migrap)
* eststo
* ivregress 2sls `X' L.`X'   (mqnid mqnidandl`X' = D Dandl`X') if phase==3, vce(cluster migrap)
* eststo
* ivregress 2sls d`X'  (mqnid = D) if phase==2, vce(cluster migrap)
* eststo
* ivregress 2sls d`X'  (mqnid = D) if phase==3, vce(cluster migrap)
* eststo
* }
* esttab using 2sls1.tex, indicate(Control lagged dependent variable=L.*)  p  replace  addnotes( p-values are caliculated by cluster robust standard errors (village level).Odd columns are about the 2nd phase. Even columns are about the 3rd phase.) mlabels(,depvars) label
* eststo clear

* foreach X in rdt  bite flr absence2 mediex6 inactivefever  {
* ivregress 2sls `X'  (mqnid = D) if phase==2&bound==1, vce(cluster migrap)
* eststo
* ivregress 2sls `X'  (mqnid = D) if phase==3&bound==1, vce(cluster migrap)
* eststo
* ivregress 2sls `X' L.`X'   (mqnid mqnidandl`X' = D Dandl`X') if phase==2&bound==1, vce(cluster migrap)
* eststo
* ivregress 2sls `X' L.`X'   (mqnid mqnidandl`X' = D Dandl`X') if phase==3&bound==1, vce(cluster migrap)
* eststo
* ivregress 2sls d`X'  (mqnid = D) if phase==2&bound==1, vce(cluster migrap)
* eststo
* ivregress 2sls d`X'  (mqnid = D) if phase==3&bound==1, vce(cluster migrap)
* eststo
* }
* esttab using 2sls1_b.tex, indicate(Control lagged dependent variable=L.*)  p  replace    addnotes(Not-inland villages are used. p-values are caliculated by cluster robust standard errors (village level).Odd columns are about the 2nd phase. Even columns are about the 3rd phase.) mlabels(,depvars) label
* eststo clear


* foreach X in  twork  thhtask tschool  tsickrest  trest  tcare salary_6_0 self_6_0 {
* gen mqnidandl`X'=mqnid*L.`X'
* gen Dandl`X'=D*L.`X'
* ivregress 2sls `X'  (mqnid = D) if phase==2, vce(cluster migrap)
* eststo
* ivregress 2sls `X'  (mqnid = D) if phase==3, vce(cluster migrap)
* eststo

* ivregress 2sls `X' L.`X'   (mqnid mqnidandl`X' = D Dandl`X') if phase==3, vce(cluster migrap)
* eststo
* ivregress 2sls d`X'  (mqnid = D) if phase==3, vce(cluster migrap)
* eststo
* }

* esttab using 2sls2.tex, indicate(Control lagged dependent variable=L.*)  p  replace   addnotes( p-values are caliculated by cluster robust standard errors (village level).The First columns of each variable are about the 2nd phase. Other columns are about the mqnidd3rd phase.) mlabels(,depvars) label
* eststo clear


* foreach X in  twork  thhtask tschool  tsickrest  trest  tcare salary_6_0 self_6_0 {
* ivregress 2sls `X'  (mqnid = D) if phase==2&bound==1, vce(cluster migrap)
* eststo
* ivregress 2sls `X'  (mqnid = D) if phase==3&bound==1, vce(cluster migrap)
* eststo

* ivregress 2sls `X' L.`X'   (mqnid mqnidandl`X' = D Dandl`X') if phase==3&bound==1, vce(cluster migrap)
* eststo
* ivregress 2sls d`X'  (mqnid = D) if phase==3&bound==1, vce(cluster migrap)
* eststo
* }

* esttab using 2sls2_b.tex, indicate(Control lagged dependent variable=L.*)  p  replace    addnotes(Not-inland villages are used. p-values are caliculated by cluster robust standard errors (village level).The First columns of each variable are about the 2nd phase. Other columns are about the 3rd phase.) mlabels(,depvars) label
* eststo clear


* foreach X in mediex6 HH_salary_6_0 HH_self_6_0  {
* ivregress 2sls `X'  (mqnid = D ) if phase==2&r3==1, vce(cluster migrap)
* eststo
* ivregress 2sls `X'  (mqnid = D ) if phase==3&r3==1, vce(cluster migrap)
* eststo
* ivregress 2sls d`X'  (mqnid = D) if phase==3&r3==1, vce(cluster migrap)
* eststo
* }


* esttab using 2sls3.tex,  p  replace    addnotes( p-values are caliculated by cluster robust standard errors (village level).The First columns of each variable are about the 2nd phase. Other columns are about the 3rd phase.) mlabels(,depvars) label
* eststo clear




* foreach X in mediex6 HH_salary_6_0 HH_self_6_0  {
* ivregress 2sls `X'  (mqnid = D ) if phase==2&r3==1&bound==1, vce(cluster migrap)
* eststo
* ivregress 2sls `X'  (mqnid = D ) if phase==3&r3==1&bound==1, vce(cluster migrap)
* eststo
* ivregress 2sls d`X'  (mqnid = D) if phase==3&r3==1&bound==1, vce(cluster migrap)
* eststo
* }


* esttab using 2sls3_b.tex,  p  replace    addnotes(Not-inland villages are used. p-values are caliculated by cluster robust standard errors (village level).The First columns of each variable are about the 2nd phase. Other columns are about the 3rd phase.) mlabels(,depvars) label
* eststo clear


gen secondsettle=r0ca
replace secondsettle=F.r0ca if phase==2
replace secondsettle=F2.r0ca if phase==1

gen secondsettle01=r0ca
replace secondsettle01=1 if r0ca>=1&r0ca!=.

gen thirdsettle=r0fa
replace thirdsettle=F.r0fa if phase==2
replace thirdsettle=F2.r0fa if phase==1

gen thirdsettle01=r0fa
replace thirdsettle01=1 if r0fa>=1&r0fa!=.


gen floor=0 

replace floor=1 if bedid==2
replace floor=1 if F.bedid==2
replace floor=1 if F2.bedid==2

replace floor=. if bedid==.&phase==3
replace floor=. if F.bedid==.&phase==2
replace floor=. if F2.bedid==.&phase==1

gen nwithsleepid=nwithsleep
replace nwithsleepid=F.nwithsleep if phase==2
replace nwithsleepid=F2.nwithsleep if phase==1

gen nwithsleepidsq=nwithsleepid^2
eststo clear
replace HHincome6_0 =F.HHincome12_6  if phase==1
* probit mqnid floor teen HHincome6_0  nwithsleepid if  phase==3&L.mqnid==1&G==0
* eststo
* probit mqnid floor teen HHincome6_0 nwithsleepid if  phase==3&L.mqnid==0&G==0
* eststo

* probit mqnid floor teen HHincome6_0 nwithsleepid if  phase==3&L.mqnid==1&G==1
* eststo
* probit mqnid floor teen HHincome6_0 nwithsleepid  if  phase==3&L.mqnid==0&G==1
* eststo

* probit mqnid floor teen HHincome6_0 nwithsleepid if  phase==2&L.mqnid==1&G==0
* eststo
* probit mqnid floor teen HHincome6_0  nwithsleepid if  phase==2&L.mqnid==0&G==0
* eststo

* probit mqnid floor teen HHincome6_0 nwithsleepid if  phase==2&L.mqnid==1&G==1
* eststo
* probit mqnid floor teen HHincome6_0 nwithsleepid if  phase==2&L.mqnid==0&G==1
* eststo


* probit mqnid floor teen HHincome6_0 nwithsleepid if  phase==1&G==1
* eststo
* probit mqnid floor teen HHincome6_0 nwithsleepid if  phase==1&G==0
* eststo

* esttab using mqnid_3rd.tex, p  replace    mtitles(p3g0used p3g0noused p3g1used p3g1noused p2g0used p2g0noused p2g1used p2g1noused p1g1 p1g0)
* eststo clear

* probit mqnid floor teen HHincome6_0  if nwithsleepid<2&phase==3&L.mqnid==1&G==0
* eststo
* probit mqnid floor teen HHincome6_0  if nwithsleepid<2&phase==3&L.mqnid==0&G==0
* eststo

* probit mqnid floor teen HHincome6_0  if nwithsleepid<2&phase==3&L.mqnid==1&G==1
* eststo
* probit mqnid floor teen HHincome6_0  if nwithsleepid<2&phase==3&L.mqnid==0&G==1
* eststo

* probit mqnid floor teen HHincome6_0  if nwithsleepid<2&phase==2&L.mqnid==1&G==0
* eststo
* probit mqnid floor teen HHincome6_0  if nwithsleepid<2&phase==2&L.mqnid==0&G==0
* eststo

* probit mqnid floor teen HHincome6_0  if nwithsleepid<2&phase==2&L.mqnid==1&G==1
* eststo
* probit mqnid floor teen HHincome6_0  if nwithsleepid<2&phase==2&L.mqnid==0&G==1
* eststo


* probit mqnid floor teen HHincome6_0  if nwithsleepid<2&phase==1&G==1
* eststo
* probit mqnid floor teen HHincome6_0  if nwithsleepid<2&phase==1&G==0
* eststo

* esttab using mqnid1_3rd.tex, p  replace    mtitles(p3g0 p3g0 p3g1 p3g1 p2g0 p2g0 p2g1 p2g1 p1g1 p1g0)
* eststo clear

* probit mqnid floor teen HHincome6_0  if nwithsleepid==2&phase==3&L.mqnid==1&G==0
* eststo
* probit mqnid floor teen HHincome6_0  if nwithsleepid==2&phase==3&L.mqnid==0&G==0
* eststo

* probit mqnid floor teen HHincome6_0  if nwithsleepid==2&phase==3&L.mqnid==1&G==1
* eststo
* probit mqnid floor teen HHincome6_0  if nwithsleepid==2&phase==3&L.mqnid==0&G==1
* eststo

* probit mqnid floor teen HHincome6_0  if nwithsleepid==2&phase==2&L.mqnid==1&G==0
* eststo
* probit mqnid floor teen HHincome6_0  if nwithsleepid==2&phase==2&L.mqnid==0&G==0
* eststo

* probit mqnid floor teen HHincome6_0  if nwithsleepid==2&phase==2&L.mqnid==1&G==1
* eststo
* probit mqnid floor teen HHincome6_0  if nwithsleepid==2&phase==2&L.mqnid==0&G==1
* eststo


* probit mqnid floor teen HHincome6_0  if nwithsleepid==2&phase==1&G==1
* eststo
* probit mqnid floor teen HHincome6_0  if nwithsleepid==2&phase==1&G==0
* eststo

* esttab using mqnid2_3rd.tex, p  replace    mtitles(p3g0 p3g0 p3g1 p3g1 p2g0 p2g0 p2g1 p2g1 p1g1 p1g0)
* eststo clear

* probit mqnid floor teen HHincome6_0  if nwithsleepid==3&phase==3&L.mqnid==1&G==0
* eststo
* probit mqnid floor teen HHincome6_0  if nwithsleepid==3&phase==3&L.mqnid==0&G==0
* eststo

* probit mqnid floor teen HHincome6_0  if nwithsleepid==3&phase==3&L.mqnid==1&G==1
* eststo
* probit mqnid floor teen HHincome6_0  if nwithsleepid==3&phase==3&L.mqnid==0&G==1
* eststo

* probit mqnid floor teen HHincome6_0  if nwithsleepid==3&phase==2&L.mqnid==1&G==0
* eststo
* probit mqnid floor teen HHincome6_0  if nwithsleepid==3&phase==2&L.mqnid==0&G==0
* eststo

* probit mqnid floor teen HHincome6_0  if nwithsleepid==3&phase==2&L.mqnid==1&G==1
* eststo
* probit mqnid floor teen HHincome6_0  if nwithsleepid==3&phase==2&L.mqnid==0&G==1
* eststo


* probit mqnid floor teen HHincome6_0  if nwithsleepid==3&phase==1&G==1
* eststo
* probit mqnid floor teen HHincome6_0  if nwithsleepid==3&phase==1&G==0
* eststo

*  esttab using mqnid3_3rd.tex, p  replace    mtitles(p3g0 p3g0 p3g1 p3g1 p2g0 p2g0 p2g1 p2g1 p1g1 p1g0)





*蚊帳の感染へのLATE効果

gen lmqnid=L.mqnid
gen dmqnidandage04=dmqnid*age04
gen dmqnidandage57=dmqnid*age57
gen dmqnidandage810=dmqnid*age810
gen dmqnidandage1113=dmqnid*age1113
gen dmqnidandage1416=dmqnid*age1416
gen dmqnidandage1719=dmqnid*age1719
gen dmqnidandage2024=dmqnid*age2024
gen dmqnidandage2540=dmqnid*age2540
gen dmqnidandage41=dmqnid*age41

gen dntllitn=D.ntllitnid
gen dntllitnandage04=dntllitn*age04
gen dntllitnandage57=dntllitn*age57
gen dntllitnandage810=dntllitn*age810
gen dntllitnandage1113=dntllitn*age1113
gen dntllitnandage1416=dntllitn*age1416
gen dntllitnandage1719=dntllitn*age1719
gen dntllitnandage2024=dntllitn*age2024
gen dntllitnandage2540=dntllitn*age2540
gen dntllitnandage41=dmqnid*age41


gen mqnidandage04=mqnid*age04
gen mqnidandage57=mqnid*age57
gen mqnidandage810=mqnid*age810
gen mqnidandage1113=mqnid*age1113
gen mqnidandage1416=mqnid*age1416
gen mqnidandage1719=mqnid*age1719
gen mqnidandage2024=mqnid*age2024
gen mqnidandage2540=mqnid*age2540
gen mqnidandage41=mqnid*age41

gen dmqnidandage60=dmqnid*age60
gen dmqnidandage60sq=dmqnid*age60sq
gen dmqnidandage60cu=dmqnid*age60cu


gen dmqnidandfemale=D.mqnid*female
gen dmqnidandcschool=D.mqnid*cschool
gen dmqnidandschoolage=D.mqnid*schoolage
gen dmqnidandteen=D.mqnid*teen
gen dmqnidandunderteen =D.mqnid*underteen
gen dmqnidandbaby=D.mqnid*baby
gen dmqnidandhteen=D.mqnid*hteen
gen dmqnidandlteen=D.mqnid*lteen
gen dmqnidandhjuv=D.mqnid*hjuv
gen dmqnidandljuv=D.mqnid*ljuv


gen mqnidandfemale=mqnid*female
gen mqnidandcschool=mqnid*cschool
gen mqnidandschoolage=mqnid*schoolage
gen mqnidandteen=mqnid*teen
gen mqnidandbaby=mqnid*baby
gen mqnidandhteen=mqnid*hteen
gen mqnidandlteen=mqnid*lteen
gen mqnidandhjuv=mqnid*hjuv
gen mqnidandljuv=mqnid*ljuv
gen mqnidandunderteen =mqnid*underteen
gen mqnidandlmqnid=mqnid*lmqnid
label var mqnid "Sleep in a Net"
label var lmqnid "Sleep in a Net in the Last Phase"
label var mqnidandfemale "Sleep in a Net * School Female"
label var mqnidandcschool "Sleep in a Net * School Enrollment"
label var mqnidandteen  "Sleep in a Net * 13-19 years old"
label var mqnidandunderteen  "Sleep in a Net * 6-12 years old "
label var mqnidandhteen  "Sleep in a Net * 16-19 years old "
label var mqnidandlteen  "Sleep in a Net * 13-15 years old "
label var mqnidandhjuv  "Sleep in a Net * 10-12 years old "
label var mqnidandljuv  "Sleep in a Net * 6-9 years old "
label var mqnidandlmqnid "Sleep in a Net * Sleep in a Net in the Last Phase "



label var cschool "School Enrollment"
label var teen "13-19 years old"
label var underteen  "6-12 years old "
label var hteen  "16-19 years old "
label var lteen  "13-15 years old "
label var hjuv  "10-12 years old "
label var ljuv  "6-9 years old "


gen ntmqnidandfemale=ntmqnid*female
gen ntmqnidandcschool=ntmqnid*cschool
gen ntmqnidandschoolage=ntmqnid*schoolage
gen ntmqnidandteen=ntmqnid*teen
gen ntmqnidandunderteen =ntmqnid*underteen

gen lrdtotherhh=L.rdtotherhh
gen mqnidandrdtotherhh=rdtotherhh*mqnid
gen mqnidandlrdtotherhh=lrdtotherhh*mqnid

label var lrdtotherhh "No. of infected members of the HH in the Last Phase"
label var mqnidandlrdtotherhh "Net use * No. of infected members of the HH in the Last Phase"

gen goout=.
replace goout=1 if outside==1|L.outside==1
replace goout=0 if outside==0&L.outside==0 
gen dmqnidandgoout=dmqnid*goout
gen mqnidandgoout=mqnid*goout
gen Gandgoout=G*goout

gen innet=flr14x
gen mqnidandinnet=mqnid*innet
gen dmqnidandinnet=dmqnid*innet
gen Dandinnet=D*innet
gen Dandfemale=D*female
gen Dandcschool=D*cschool
gen Dandlmqnid=D*lmqnid



gen Dandrdtotherhh=rdtotherhh*D


label var Dandfemale "Distributed * School Female"
label var Dandcschool "Distributed * School Enrollment"
label var Dandteen  "Distributed * 13-19 years old"
label var Dandunderteen  "Distributed * 6-12 years old "
label var Dandhteen  "Distributed * 16-19 years old "
label var Dandlteen  "Distributed * 13-15 years old "
label var Dandhjuv  "Distributed * 10-12 years old "
label var Dandljuv  "Distributed * 6-9 years old "
label var Dandlmqnid "Distributed * Sleep in a Net in the Last Phase "

label var dmqnidandfemale "$\Delta$ Sleep in a Net * School Female"
label var dmqnidandcschool "$\Delta$ Sleep in a Net * School Enrollment"
label var dmqnidandteen  "$\Delta$ Sleep in a Net * 13-19 years old"
label var dmqnidandunderteen  "$\Delta$ Sleep in a Net * 6-12 years old "
label var dmqnidandhteen  "$\Delta$ Sleep in a Net * 16-19 years old "
label var dmqnidandlteen  "$\Delta$ Sleep in a Net * 13-15 years old "
label var dmqnidandhjuv  "$\Delta$ Sleep in a Net * 10-12 years old "
label var dmqnidandljuv  "$\Delta$ Sleep in a Net * 6-9 years old "
gen Dandlrdtotherhh=lrdtotherhh*D


label var Dandlrdtotherhh "Treatment * No. of Infected Members of the HH in the Last Phase"
eststo clear


* //その前にmqnidを右辺にしたDD

* foreach X in rdt bite flr absence2  inactivefever  {
* reg d`X'   dmqnidandage04 dmqnidandage57 dmqnidandage810 dmqnidandage1113 dmqnidandage1416 dmqnidandage1719 dmqnidandage2024   dmqnidandage2540 dmqnidandage41 age04 age57 age810 age1113 age1416 age1719 age2024  age2540 age41 if phase==2, noconstant     vce(cluster migrap)
* eststo
* reg d`X'   dmqnidandage04 dmqnidandage57 dmqnidandage810 dmqnidandage1113 dmqnidandage1416 dmqnidandage1719 dmqnidandage2024   dmqnidandage2540 dmqnidandage41 age04 age57 age810 age1113 age1416 age1719 age2024  age2540 age41 if phase==3, noconstant     vce(cluster migrap)
* eststo
* }

* esttab using DD_mqnid.tex,   p  replace   varwidth(6) wrap addnotes( Not-inland villages are used. p-values are caliculated by cluster robust standard errors (village level).Odd columns are about the 2nd phase. Even columns are about the 3rd phase.) mlabels(,depvars) label
* eststo clear

* foreach X in rdt bite flr absence2  inactivefever  {
* reg d`X'   dmqnidandage04 dmqnidandage57 dmqnidandage810 dmqnidandage1113 dmqnidandage1416 dmqnidandage1719 dmqnidandage2024   dmqnidandage2540 dmqnidandage41 age04 age57 age810 age1113 age1416 age1719 age2024  age2540 age41 if phase==2&bound==1, noconstant     vce(cluster migrap)
* eststo
* reg d`X'   dmqnidandage04 dmqnidandage57 dmqnidandage810 dmqnidandage1113 dmqnidandage1416 dmqnidandage1719 dmqnidandage2024   dmqnidandage2540 dmqnidandage41 age04 age57 age810 age1113 age1416 age1719 age2024  age2540 age41 if phase==3&bound==1, noconstant     vce(cluster migrap)
* eststo
* }

* esttab using DD_mqnid_b.tex,   p  replace   varwidth(6) wrap addnotes( Not-inland villages are used. p-values are caliculated by cluster robust standard errors (village level).Odd columns are about the 2nd phase. Even columns are about the 3rd phase.) mlabels(,depvars) label
* eststo clear


* label var dmediex6 "$\Delta$ Medical Expenses in these 6 Months"
* esttab using DD3_b.tex,   p  replace   mlabels(,depvars) label addnotes(Not-inland villages are used. p-values are caliculated by cluster robust standard errors (village level). All columns are about the 3rd phase.) 
* eststo clear

* foreach X in  rdt{
* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==2&r8==1 ,vce(cluster migrap)
* eststo
* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==3&r8==1 ,vce(cluster migrap)
* eststo

* ivregress 2sls `X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==2&r8==1&L.`X'==0 ,vce(cluster migrap)
* eststo
* ivregress 2sls `X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==2&r8==1 ,vce(cluster migrap)
* eststo

* esttab using `X'2sls.tex,   p  replace   varwidth(6) wrap  addnotes( p-values are caliculated by cluster robust standard errors (village level).The first, third, and fourth columns are about the 2nd phase. The fourth column use people who were not infected in the 1st phase. The second column is about the 3rd phase.) mlabels(,depvars) label
* eststo clear
* }

* foreach X in  rdt{
* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==2&r8==1&bound==1 ,vce(cluster migrap)
* eststo
* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==3&r8==1&bound==1,vce(cluster migrap)
* eststo

* ivregress 2sls `X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==2&r8==1&L.`X'==0&bound==1,vce(cluster migrap)
* eststo
* ivregress 2sls `X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==2&r8==1&bound==1 ,vce(cluster migrap)
* eststo

* esttab using `X'2sls_b.tex,   p  replace   varwidth(6) wrap  addnotes(Not-inland villages are used. p-values are caliculated by cluster robust standard errors (village level).The first, third, and fourth columns are about the 2nd phase. The fourth column use people who were not infected in the 1st phase. The second column is about the 3rd phase.) mlabels(,depvars) label
* eststo clear
* }


* foreach X in  flr bite{
* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid = Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid) teen underteen female cschool lmqnid if phase==2&r8==1 ,vce(cluster migrap)
* eststo
* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid = Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid) teen underteen female cschool lmqnid if phase==3&r8==1 ,vce(cluster migrap)
* eststo
* ivregress 2sls `X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid = Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid) teen underteen female cschool lmqnid if phase==2&r8==1 ,vce(cluster migrap)
* eststo


* esttab using `X'2sls.tex,   p  replace    varwidth(6) wrap addnotes( p-values are caliculated by cluster robust standard errors (village level).The First and third column is about the 2nd phase. The second column is about the 3rd phase.) mlabels(,depvars) label
* eststo clear
* }


* foreach X in  flr bite{
* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid = Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid) teen underteen female cschool lmqnid if phase==2&r8==1&bound==1 ,vce(cluster migrap)
* eststo
* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid = Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid) teen underteen female cschool lmqnid if phase==3&r8==1&bound==1 ,vce(cluster migrap)
* eststo
* ivregress 2sls `X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid = Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid) teen underteen female cschool lmqnid if phase==2&r8==1&bound==1 ,vce(cluster migrap)
* eststo


* esttab using `X'2sls_b.tex,   p  replace   varwidth(6) wrap  addnotes(Not-inland villges are used. p-values are caliculated by cluster robust standard errors (village level).The First and third column is about the 2nd phase. The second column is about the 3rd phase.) mlabels(,depvars) label
* eststo clear
* }




* foreach X in rdt {
* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==2&r8==1&secondsettle==6 ,vce(cluster migrap)
* eststo
* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==3&r8==1&secondsettle==6 ,vce(cluster migrap)
* eststo
* ivregress 2sls `X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==3&r8==1&secondsettle==6 ,vce(cluster migrap)
* eststo
* ivregress 2sls `X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==2&r8==1&secondsettle==6&L.`X'==0 ,vce(cluster migrap)
* eststo

* esttab using `X'2slsifalways.tex,   p  replace    varwidth(6) wrap addnotes( p-values are caliculated by cluster robust standard errors (village level).The First, third, and fourth columns are about the 2nd phase. The fourth column use people who were not infected in the 1st phase.  The second column is about the 3rd phase.) mlabels(,depvars) label
* eststo clear
* }

* foreach X in rdt{
* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==2&r8==1&(flr14x==10|flr14x==11),vce(cluster migrap)
* eststo

* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==3&r8==1&(flr14x==10|flr14x==11) ,vce(cluster migrap)
* eststo
* ivregress 2sls `X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==2&r8==1&(flr14x==10|flr14x==11)&L.`X'==0 ,vce(cluster migrap)
* eststo
* ivregress 2sls `X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==2&r8==1&(flr14x==10|flr14x==11) ,vce(cluster migrap)

* eststo

* esttab using `X'2sls1011.tex,   p  replace   varwidth(6) wrap  addnotes( p-values are caliculated by cluster robust standard errors (village level).The first, third, and fourth columns are about the 2nd phase. The fourth column use people who were not infected in the 1st phase. The second column is about the 3rd phase. The second column is about the 3rd phase.) mlabels(,depvars) label
* eststo clear
* }

* foreach X in bite flr{
* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid = Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid) teen underteen female cschool lmqnid if phase==2&r8==1&(flr14x==10|flr14x==11),vce(cluster migrap)
* eststo

* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid = Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid) teen underteen female cschool lmqnid if phase==3&r8==1&(flr14x==10|flr14x==11) ,vce(cluster migrap)
* eststo
* ivregress 2sls `X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid = Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid) teen underteen female cschool lmqnid if phase==2&r8==1&(flr14x==10|flr14x==11) ,vce(cluster migrap)

* eststo

* esttab using `X'2sls1011.tex,   p  replace   varwidth(6) wrap  addnotes( p-values are caliculated by cluster robust standard errors (village level).The First and third column is about the 2nd phase. The second column is about the 3rd phase.) mlabels(,depvars) label
* eststo clear
* }



* foreach X in rdt {
* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==2&r8==1&secondsettle==6&bound==1 ,vce(cluster migrap)
* eststo
* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==3&r8==1&secondsettle==6&bound==1 ,vce(cluster migrap)
* eststo
* ivregress 2sls `X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==3&r8==1&secondsettle==6&bound==1,vce(cluster migrap)
* eststo
* ivregress 2sls `X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==2&r8==1&secondsettle==6&L.`X'==0&bound==1,vce(cluster migrap)
* eststo

* esttab using `X'2slsifalways_b.tex,   p  replace   varwidth(6) wrap addnotes(Not-inland villages are used. p-values are caliculated by cluster robust standard errors (village level).The First, third, and fourth columns are about the 2nd phase. The fourth column use people who were not infected in the 1st phase.  The second column is about the 3rd phase.) mlabels(,depvars) label
* eststo clear
* }

* foreach X in rdt{
* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==2&r8==1&(flr14x==10|flr14x==11)&bound==1,vce(cluster migrap)
* eststo

* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==3&r8==1&(flr14x==10|flr14x==11) &bound==1,vce(cluster migrap)
* eststo
* ivregress 2sls `X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==2&r8==1&(flr14x==10|flr14x==11)&L.`X'==0&bound==1 ,vce(cluster migrap)
* eststo
* ivregress 2sls `X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh= Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) teen underteen female cschool lmqnid lrdtotherhh if phase==2&r8==1&(flr14x==10|flr14x==11)&bound==1 ,vce(cluster migrap)

* eststo

* esttab using `X'2sls1011_b.tex,   p  replace   varwidth(6) wrap  addnotes(Not-inland villages are used. p-values are caliculated by cluster robust standard errors (village level).The first, third, and fourth columns are about the 2nd phase. The fourth column use people who were not infected in the 1st phase. The second column is about the 3rd phase. The second column is about the 3rd phase.) mlabels(,depvars) label
* eststo clear
* }

* foreach X in bite flr{
* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid = Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid) teen underteen female cschool lmqnid if phase==2&r8==1&(flr14x==10|flr14x==11)&bound==1,vce(cluster migrap)
* eststo

* ivregress 2sls d`X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid = Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid) teen underteen female cschool lmqnid if phase==3&r8==1&(flr14x==10|flr14x==11)&bound==1 ,vce(cluster migrap)
* eststo
* ivregress 2sls `X' (mqnid mqnidandteen mqnidandunderteen mqnidandfemale mqnidandcschool mqnidandlmqnid = Dandteen Dandunderteen D Dandfemale Dandcschool Dandlmqnid) teen underteen female cschool lmqnid if phase==2&r8==1&(flr14x==10|flr14x==11)&bound==1 ,vce(cluster migrap)

* eststo

* esttab using `X'2sls1011_b.tex,   p  replace    varwidth(6) wrap addnotes(Not-inland villages are used. p-values are caliculated by cluster robust standard errors (village level).The First and third column is about the 2nd phase. The second column is about the 3rd phase.) mlabels(,depvars) label
* eststo clear
* }


forvalues x =1/15{
gen hhsize`x'=(hhsize==`x')
label var hhsize`x' " members in the HH"
}
gen lmqnhh=L.mqnhh
gen lnoftorn=L.noftorn

gen campnet01=.
replace campnet01=1 if campnet>0&campnet!=.
replace campnet01=0 if campnet==0
label var campnet "No. of owned nets distributed by the campaing"
label var campnet01 "Owned nets distributed by the campaing dummy"

label var lmqnhh "No. of owned nets in the Last Phase"
label var lnoftorn "No. of  owend torn nets in the Last Phase "

* eststo clear
* reg campnet  hhsize* lmqnhh lnoftorn i.migrap if phase==2&G==1&r3==1&campnet>0
* eststo
* probit campnet01  hhsize* lmqnhh lnoftorn  i.migrap  if phase==2&G==1&r3==1
* eststo

* esttab using  campaingnet2nd.tex,   p  replace   varwidth(6) wrap  addnotes(The first column uses household which owned at lease one nets distributed by the campaing dummy (OLS), while the second column uses all households (probit).) mlabels(,depvars) label 
* eststo clear

* reg campnet  hhsize* lmqnhh lnoftorn i.migrap if phase==3&G==0&r3==1&campnet>0
* eststo
* probit campnet01  hhsize* lmqnhh lnoftorn  i.migrap  if phase==3&G==0&r3==1
* eststo

* esttab using  campaingnet3rd.tex,   p  replace   varwidth(6) wrap  addnotes(The first column uses household which owned at lease one nets distributed by the campaing dummy (OLS), while the second column uses all households (probit).) mlabels(,depvars) label 
* eststo clear


gen nofnet=h2
replace nofnet=0 if h1==2

gen nofshort=nofbed-nofnet 
replace nofshort=0 if nofbed-nofnet>0

gen netminusbed=nofnet-nofbed 

gen nofover=nofnet-nofbed
replace nofover=0 if nofbed-nofnet<0

gen nofover_teen=nofover*teen
gen nofshort_teen=nofshort*teen

gen netminusbed_teen=netminusbed*teen

gen G_teen=G*teen

gen G_nofover=G*nofover
gen G_nofover_teen=G*nofover*teen
gen G_nofshort_teen=G*nofshort*teen

gen hdist180=ea6-179
replace hdist180=0 if hdist180<0
gen hdisthour=0 if ea6<60
replace hdisthour=1 if ea6>=60&ea6<120
replace hdisthour=2 if ea6>=120&ea6<180
replace hdisthour=3 if ea6>=180&ea6<240
replace hdisthour=4 if ea6>=240&ea6<300
replace hdisthour=5 if ea6>=300&ea6<360
replace hdisthour=6 if ea6>=360&ea6<420
replace hdisthour=7 if ea6>=420&ea6<480
replace hdisthour=8 if ea6>=480&ea6<560





forvalues i=1/7{
gen G_nofbed`i'=(nofbed==`i'&G==1)
}

forvalues i=1/7{
gen netminusbed`i'=(netminusbed==`i')
}


forvalues i=1/7{
gen netminusbedminus`i'=(netminusbed==-`i')
}


* ivregress 2sls mqnid (netminusbed netminusbed_teen = G  G_teen) teen if phase==2,cluster(mhid)

* ivregress 2sls mqnid (netminusbedminus2 netminusbedminus1 netminusbed1 netminusbed2  = G   G_nofbed1 G_nofbed2 G_nofbed3 G_nofbed4 G_nofbed5 G_nofbed7) if phase==2&L.mqnid==0,cluster(mhid)

* ivregress 2sls mqnid (netminusbed  = G  hdisthour ) stay2 if phase==2&netminusbed <0&r8==1,cluster(mhid)

* ivregress 2sls mqnid (netminusbed  = G  hdisthour ) stay2 if phase==2&netminusbed>=0&r8==1,cluster(mhid)


* *実験内容分析
* gen onechangemoney=.
* replace onechangemoney=0 if e1c1!=.
* replace onechangemoney=1 if (e1c1==0&e1c2==0&e1c3==0&e1c4==0)|(e1c1==0&e1c2==0&e1c3==0&e1c4==1)|(e1c1==0&e1c2==0&e1c3==1&e1c4==1)|(e1c1==0&e1c2==1&e1c3==1&e1c4==1)|(e1c1==1&e1c2==1&e1c3==1&e1c4==1)

* gen onechangehealth=.
* replace onechangehealth=0 if e2c1!=.
* replace onechangehealth=1 if (e2c1==0&e2c2==0&e2c3==0&e2c4==0)|(e2c1==0&e2c2==0&e2c3==0&e2c4==1)|(e2c1==0&e2c2==0&e2c3==1&e2c4==1)|(e2c1==0&e2c2==1&e2c3==1&e2c4==1)|(e2c1==1&e2c2==1&e2c3==1&e2c4==1)

* graph twoway lpolyci e1c1 age60 if phase==3
* graph export age60_and_e1c1.eps,replace
* graph twoway lpolyci e2c1 age60 if phase==3
* graph export age60_and_e2c1.eps,replace
* graph twoway lpolyci money age60 if phase==3
* graph export age60_and_money.eps,replace
* graph twoway lpolyci health age60 if phase==3
* graph export age60_and_money.eps,replace

* eststo clear

* gen workr7=(r7<30)
* replace workr7=1 if r7y<30

* gen onechange=.
* replace onechange=1 if (onechangem==1&onechangeh==1)
* replace onechange=0 if (onechangem==0|onechangeh==0)

* gen rainef01=(rainef>0)
* gen dryef01=(dryef>0)


* foreach X in moneyfc e1c1 healthfc e2c1 q1 q2 q3 q4 q5{
* reg `X' teen if r8==1&phase==1, cluster(mhid09)
* eststo
* reg `X' teen if r8==1&phase==1&onechangeh==1&onechangem==1, cluster(mhid09)
* eststo
* }

* esttab using experiment_covariates.tex,   p  replace   varwidth(6) wrap addnotes( p-values are caliculated by cluster robust standard errors (HH level)) mlabels(,depvars) label
* eststo clear


* reg mqnid   floor teen nwithsleep HHincome6 workr7 if r8==1&phase==1, cluster(mhid09)
* eststo 
* reg mqnid  dryef i.money i.health  q5  floor teen nwithsleep HHincome6 workr7 if r8==1&phase==1, cluster(mhid09)
* eststo 
* reg mqnid  dryef i.money i.health  q5  floor teen nwithsleep HHincome6 workr7 if r8==1&phase==1&onechangeh==1&onechangem==1, cluster(mhid09)
* eststo 
* reg mqnid  dryef e1c1 e2c1  q5  floor teen nwithsleep HHincome6 workr7  if r8==1&phase==1, cluster(mhid09)
* eststo 
* reg mqnid  dryef e1c1 e2c1  q5  floor teen nwithsleep HHincome6 workr7  if r8==1&phase==1&onechangeh==1&onechangem==1, cluster(mhid09)
* eststo 
*  reg mqnid  dryef e1c1 e2c1  q5  floor teen nwithsleep HHincome6 workr7  F2.r8b if r8==1&phase==1&onechangeh==1&onechangem==1, cluster(mhid09)
* eststo



* reg mqnid     floor teen nwithsleep HHincome6 workr7 campnet if r8==1&phase==2, cluster(mhid09)
* eststo 
* reg mqnid  rainef i.money i.health  q5  floor teen nwithsleep HHincome6 workr7 campnet if r8==1&phase==2, cluster(mhid09)
* eststo 
* reg mqnid  rainef i.money i.health  q5  floor teen nwithsleep HHincome6 workr7 campnet if r8==1&phase==2&onechangeh==1&onechangem==1, cluster(mhid09)
* eststo 
* reg mqnid  rainef i.money i.health  q5  floor teen nwithsleep HHincome6 workr7  if r8==1&phase==2&onechangeh==1&onechangem==1&D==0, cluster(mhid09)
* eststo 
* reg mqnid  rainef i.money i.health  q5  floor teen nwithsleep HHincome6 workr7  F.r8b if r8==1&phase==2&onechangeh==1&onechangem==1&D==0, cluster(mhid09)
* eststo 


* reg mqnid  rainef e1c1 e2c1  q5  floor teen nwithsleep HHincome6 workr7 campnet  if r8==1&phase==2, cluster(mhid09)
* eststo 
* reg mqnid  rainef e1c1 e2c1  q5  floor teen nwithsleep HHincome6 workr7  campnet if r8==1&phase==2&onechangeh==1&onechangem==1, cluster(mhid09)
* eststo 
* reg mqnid  rainef e1c1 e2c1  q5  floor teen nwithsleep HHincome6 workr7  if r8==1&phase==2&onechangeh==1&onechangem==1&D==0, cluster(mhid09)
* eststo 
* reg mqnid  rainef e1c1 e2c1  q5  floor teen nwithsleep HHincome6 workr7 F.r8b if r8==1&phase==2&onechangeh==1&onechangem==1&D==0, cluster(mhid09)
* eststo 
* reg mqnid  rainef e1c1 e2c1  q5  floor teen nwithsleep HHincome6 workr7 F.r8b if r8==1&phase==2&onechangeh==1&onechangem==1&D==0&L.mqnid==0&L.r8==1, cluster(mhid09)
* eststo 



* reg mqnid     floor teen nwithsleep HHincome6 workr7 r8b if r8==1&phase==3, cluster(mhid09)
* eststo 
* reg mqnid  dryef i.money i.health  q5  floor teen nwithsleep HHincome6 workr7 r8b if r8==1&phase==3, cluster(mhid09)
* eststo 
* reg mqnid  dryef i.money i.health  q5  floor teen nwithsleep HHincome6 workr7 r8b if r8==1&phase==3&onechangeh==1&onechangem==1, cluster(mhid09)
* eststo 
* reg mqnid  dryef e1c1 e2c1  q5  floor teen nwithsleep HHincome6 workr7 r8b if r8==1&phase==3, cluster(mhid09)
* eststo 
* reg mqnid  dryef e1c1 e2c1  q5  floor teen nwithsleep HHincome6 workr7 r8b  if r8==1&phase==3&onechangeh==1&onechangem==1, cluster(mhid09)
* eststo 

* esttab using experiment_mqnid.tex,   p  replace   varwidth(6) wrap addnotes(Column 3,5,6,9,10,11,13-16,19,21 use restrited sample who answered in a proper way. .p-values are caliculated by cluster robust standard errors (HH level)) mlabels(,depvars) label mgroup("The 1st phase" "The 2nd phase" "Untreated"  "Untreated" "Untreated" "Untreated" "Untreated andNot used" "The 3rd phase", pattern(1 0 0 0 0 0 1  0 0 1 1 0 0 1 1 1 1 0 0 0 0 0 0 0))

eststo clear
*
save data/intermediate/forpaper/allcheck.dta,replace
*use allcheck.dta,clear
* merge 1:1 miid09 phase using data/intermediate/forpaper/bedcheck1st2nd, generate(bedcheck1st2nd)
* sort miid09 phase
* keep if phase==2|phase==1

* gen notmqnid=(mqnid==0&r8==1)
* gen notmqnidandteen=(mqnid==0&r8==1&teen==1)
* gen notmqnid1st2nd=(lmqnid==0&mqnid==0&r8==1&L.r8==1)

* gen dh2=D.h2
*  reg adjustdnwith dh2 if mqnid==1&L.mqnid==1
* *collapse (sum) mqnid notmqnid mqnidandteen notmqnidandteen (max) campnet mark12 campnetnotuse  notmqnid1st2nd (min) adjustdnwith D, by(mhid09 phase)

* * histogram flr if phase==1&mqnid==0&outside==1&flr<=10, by(agecategory2) frac
* * graph export bitesnomqn_1st.eps,replace
* * histogram flr if phase==1&mqnid==0&outside==0&flr<=10, by(agecategory2) frac
* * graph export bitesout_1st.eps,replace
* * histogram flr if phase==1&mqnid==1&outside==0&flr<=10, by(agecategory2) frac
* * graph export bitesmqn_1st.eps,replace

use data/intermediate/forpaper/allcheck,clear
*externality

gen latdN=mhlat if mh1==50
replace latdN=0 if mh1==170 
gen latdS=mhlat if mh1==170
replace latdS=0 if mh1==50
gen mqnidandlatdN= mqnid*latdN
gen mqnidandlatdS= mqnid*latdS
gen DandlatdN= D*latdN
gen DandlatdS= D*latdS
* ivregress 2sls rdt (mqnid mqnidandlatdN mqnidandlatdS=D latdN latdS) if phase==2&L.rdt==0&(migrap==3|migrap==4|migrap==13|migrap==15)


* estpost tab r4 e2a if e3==1&phase==2&r4<20, nototal
* esttab using ageandclass_2nd, cell(b) collabels(freq.) eqlabel(,lhs(age)) tex unstack  noobs nonumber addnotes(We used those who are student at the 2nd phase.) replace
* estpost tab r4 e2a if e3==1&phase==2&r4<20&(e2a>=1&e2a<=5), nototal
* esttab using draft/ageandclass_2nd, cell(b) collabels(freq.) eqlabel(,lhs(age)) tex unstack  noobs nonumber addnotes(We used those who are student at the 2nd phase.) replace


*spatial

gen spatialmqnid1prop=spatialmqnid11/pop1
gen spatialmqnid2prop=spatialmqnid21/pop2
gen spatialmqnid3prop=spatialmqnid31/pop3
gen spatialrdt1prop=spatialrdt11/pop1
gen spatialrdt2prop=spatialrdt21/pop2
gen spatialrdt3prop=spatialrdt31/pop3
label var spatialrdt1prop "Malaria infection rate within 500m"
label var spatialrdt2prop "Malaria infection rate within 1000m"
label var spatialrdt3prop "Malaria infection rate within 2000m"

label var spatialmqnid1prop "Usage rate within 500m"
label var spatialmqnid2prop "Usage rate within 1000m"
label var spatialmqnid3prop "Usage rate within 2000m"

* save data/intermediate/forpaper/allcheck, replace

* use data/rawdata\1st\distance2border,clear
* rename mhid mhid09
* save distance2border,replace
* use data/intermediate/forpaper/allcheck,clear
* merge m:1 mhid09 using distance2border,generate(dist2bord)

* gen near_dist2=(near_dist^2)^(1/2)

* eststo clear
* ivregress 2sls rdt (mqnid spatialmqnid1prop = D near_dist) if phase==2&bound==1, cluster(migrap) first
* eststo
* ivregress 2sls rdt (mqnid spatialmqnid2prop=D near_dist) if phase==2&bound==1, cluster(migrap) first
* eststo
* ivregress 2sls rdt (mqnid spatialmqnid3prop=D near_dist) if phase==2&bound==1, cluster(migrap) first
* eststo
* reg rdt mqnid spatialmqnid1prop  if phase==1&bound==1, cluster(migrap) 
* eststo
* reg rdt mqnid spatialmqnid1prop  if phase==2&bound==1, cluster(migrap) 
* eststo
* reg rdt mqnid spatialmqnid2prop  if phase==1&bound==1, cluster(migrap) 
* eststo
* reg rdt mqnid spatialmqnid2prop  if phase==2&bound==1, cluster(migrap) 
* eststo
* reg rdt mqnid spatialmqnid3prop  if phase==1&bound==1, cluster(migrap) 
* eststo
* reg rdt mqnid spatialmqnid3prop  if phase==2&bound==1, cluster(migrap) 
* eststo

* esttab using spatialmqnid_2nd,   p  replace  label  varwidth(6) wrap tex addnotes( p-values are caliculated by cluster robust standard errors. Column 4, 6 and 8 use 1st phase and the others use 2nd phase.) mlabels(2SLS 2SLS 2SLS OLS OLS OLS  OLS OLS OLS)


* eststo clear
* ivregress 2sls rdt (mqnid spatialrdt1prop = D near_dist) if phase==2&bound==1, cluster(migrap) first
* eststo
* ivregress 2sls rdt (mqnid spatialrdt2prop=D near_dist) if phase==2&bound==1, cluster(migrap) first
* eststo
* ivregress 2sls rdt (mqnid spatialrdt3prop=D near_dist) if phase==2&bound==1, cluster(migrap) first
* eststo

* esttab using spatialrdt_2nd,   p  replace  label  varwidth(6) wrap tex addnotes( p-values are caliculated by cluster robust standard errors ) mlabels(,depvars)

eststo clear
sort miid09 phase



gen mqntime10=(flr14>=10)
gen mqntime10andbaby=mqntime10*baby
gen mqntime10andteen=mqntime10*teen
gen mqntime10andunderteen=mqntime10*underteen
gen mqntime10andhjuv=mqntime10*hjuv
gen mqntime10andljuv=mqntime10*ljuv
gen mqntime10andhteen=mqntime10*hteen
gen mqntime10andlteen=mqntime10*lteen




label var mqntime10  "used 10+ h"
label var mqntime10andunderteen  "used 10+ h * 6-12 years old "
label var mqntime10andteen  "used 10+ h * 13-19 years old "
label var mqntime10andlteen   "used 10+ h * 13-15 years old "
label var mqntime10andhteen   "used 10+ h* 16-19 years old "
label var mqntime10andljuv  "used 10+ h * 6-9 years old "
label var mqntime10andhjuv  "used 10+ h* 10-12 years old "


gen femaleteen=female*teen
gen mqnidandfemaleteen=mqnid*femaleteen
gen Dandfemaleteen=D*femaleteen

* eststo clear
* reg outside ljuv hjuv lteen hteen , cluster(migrap)
* eststo
* reg secondsettle ljuv hjuv lteen hteen , cluster(migrap)
* eststo
* reg flr14 ljuv hjuv lteen hteen , cluster(migrap)
* eststo
* esttab using gooutandage,   p  replace  label  varwidth(6) wrap tex  
* eststo clear

* *notprecise

* ivregress 2sls rdt ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen outside if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen outside if phase==2&bound==1&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen outside mqntime10 if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen outside mqntime10 if phase==2&bound==1&secondsettle==6, cluster(migrap) 
* eststo

* ivregress 2sls rdt (mqntime10 mqntime10andunderteen mqntime10andteen  = D Dandunderteen Dandteen) teen underteen outside  if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls rdt (mqntime10 mqntime10andunderteen mqntime10andteen  = D Dandunderteen Dandteen) teen underteen outside  if phase==2&bound==1&secondsettle==6, cluster(migrap)   
* eststo
* esttab using rdtandout_2nd,  p  replace  label  varwidth(6) wrap tex  mlabels(full seaside full seaside  full seaside )  addnotes(p-values are caliculated by cluster robust standard errors. We only used those who stayed 6 months from the 1st to the 2nd.)  
* eststo clear

* ivregress 2sls rdt ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen outside if phase==2&L.rdt==0&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen outside if phase==2&bound==1&L.rdt==0&secondsettle==6, cluster(migrap)
* eststo
* ivregress 2sls rdt ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen outside mqntime10 if phase==2&L.rdt==0&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen outside mqntime10 if phase==2&bound==1&L.rdt==0&secondsettle==6, cluster(migrap)
* eststo
* ivregress 2sls rdt (mqntime10 mqntime10andunderteen mqntime10andteen  = D Dandunderteen Dandteen) teen underteen outside  if phase==2&L.rdt==0&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls rdt (mqntime10 mqntime10andunderteen mqntime10andteen  = D Dandunderteen Dandteen) teen underteen outside  if phase==2&bound==1&L.rdt==0&secondsettle==6, cluster(migrap)   
* eststo
* esttab using rdtandoutnotinfected_2nd,   p  replace  label  varwidth(6) wrap tex  mlabels(full seaside full seaside  full seaside)  addnotes(p-values are caliculated by cluster robust standard errors. We only used those who stayed 6 months from the 1st to the 2nd.)  
* eststo clear



* ivregress 2sls bite ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen outside if phase==2, cluster(migrap) 
* eststo
* ivregress 2sls bite ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen outside if phase==2&bound==1, cluster(migrap) 
* eststo

* ivregress 2sls bite ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen  mqntime10 if phase==2, cluster(migrap) 
* eststo
* ivregress 2sls bite ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen  mqntime10 if phase==2&bound==1, cluster(migrap) 
* eststo
* ivregress 2sls bite (mqntime10 mqntime10andunderteen mqntime10andteen  = D Dandunderteen Dandteen) teen underteen outside if phase==2, cluster(migrap) 
* eststo
* ivregress 2sls bite (mqntime10 mqntime10andunderteen mqntime10andteen  = D Dandunderteen Dandteen) teen underteen outside if phase==2&bound==1, cluster(migrap) 
* eststo

* ivregress 2sls bite ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen  if phase==2&L.bite==1, cluster(migrap) 
* eststo
* ivregress 2sls bite ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen  if phase==2&bound==1&L.bite==1, cluster(migrap) 
* eststo
* ivregress 2sls bite (mqntime10 mqntime10andunderteen mqntime10andteen  = D Dandunderteen Dandteen) teen underteen outside if phase==2&L.bite==1, cluster(migrap) 
* eststo
* ivregress 2sls bite (mqntime10 mqntime10andunderteen mqntime10andteen  = D Dandunderteen Dandteen) teen underteen outside if phase==2&bound==1&L.bite==1, cluster(migrap) 
* eststo


* esttab using biteandout_2nd,  p  replace  label  varwidth(6) wrap tex mlabels(full seaside full "seaside" full "seaside" "full" "seaside " "full" "seaside " )  addnotes( p-values are caliculated by cluster robust standard errors. From column 7, we only used people who had mosquito bite at the 1st phase. )  
 
 

 
*  eststo clear

* ivregress 2sls flr ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen  outside if phase==2, cluster(migrap) 
* eststo
* ivregress 2sls flr ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen  outside if phase==2&bound==1, cluster(migrap) 
* eststo

* ivregress 2sls flr ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen  mqntime10 if phase==2, cluster(migrap) 
* eststo
* ivregress 2sls flr ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen  mqntime10 if phase==2&bound==1, cluster(migrap) 
* eststo
* ivregress 2sls flr (mqntime10 mqntime10andunderteen mqntime10andteen  = D Dandunderteen Dandteen) teen underteen outside if phase==2, cluster(migrap) 
* eststo
* ivregress 2sls flr (mqntime10 mqntime10andunderteen mqntime10andteen  = D Dandunderteen Dandteen) teen underteen outside if phase==2&bound==1, cluster(migrap) 
* eststo
* esttab using flrandout_2nd ,  p  replace  label  varwidth(6) wrap tex mlabels(full seaside full "seaside" "10+ hours" "10+ hours +seaside" )  addnotes( p-values are caliculated by cluster robust standard errors ) 

* eststo clear



* ivregress 2sls absence2 (mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen  if phase==2&r4<=19&r4>=6, noconstant cluster(migrap) 
* eststo
* ivregress 2sls absence2 (mqnidandunderteen mqnidandteen  = Dandunderteen  Dandteen) underteen teen  if phase==2&bound==1&r4<=19&r4>=6, noconstant cluster(migrap) 
* eststo
* ivregress 2sls absence62 (mqnidandunderteen mqnidandteen  = Dandunderteen  Dandteen) underteen teen  if phase==2&r4<=19&r4>=6, noconstant cluster(migrap) 
* eststo
* ivregress 2sls absence62 (mqnidandunderteen mqnidandteen  = Dandunderteen  Dandteen) underteen teen  if phase==2&bound==1&r4<=19&r4>=6,  noconstant cluster(migrap) 
* eststo
* ivregress 2sls inactivefever (mqnidandunderteen mqnidandteen  = Dandunderteen  Dandteen) underteen teen  if phase==2&r4<=19&r4>=6,noconstant  cluster(migrap) 
* eststo
* ivregress 2sls inactivefever (mqnidandunderteen mqnidandteen  = Dandunderteen  Dandteen) underteen teen  if phase==2&bound==1&r4<=19&r4>=6,noconstant cluster(migrap) 
* eststo
* esttab using absence2andfever_2nd,   p  replace  tex label  varwidth(6) wrap   addnotes( p-values are caliculated by cluster robust standard errors. The 2nd, 4th, and 6th column use seaside villages only. ) 
* eststo clear


* *precise

* ivregress 2sls rdt (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen  outside if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls rdt (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen  outside if phase==2&bound==1&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls rdt (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen  outside mqntime10 if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls rdt (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen  outside mqntime10 if phase==2&bound==1&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls rdt (mqntime10 mqntime10andljuv mqntime10andhjuv mqntime10andlteen mqntime10andhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside  if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls rdt (mqntime10 mqntime10andljuv mqntime10andhjuv mqntime10andlteen mqntime10andhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside  if phase==2&bound==1&secondsettle==6, cluster(migrap)   
* eststo
* esttab using rdtandout_2ndp,  p  replace  label  varwidth(6) wrap tex  mlabels(full seaside full seaside full seaside)  addnotes(p-values are caliculated by cluster robust standard errors. We only used those who stayed 6 months from the 1st to the 2nd.)  
* eststo clear

* ivregress 2sls rdt (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside if phase==2&L.rdt==0&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls rdt (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside if phase==2&bound==1&L.rdt==0&secondsettle==6, cluster(migrap)
* eststo
* ivregress 2sls rdt (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside mqntime10 if phase==2&L.rdt==0&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls rdt (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside mqntime10 if phase==2&bound==1&L.rdt==0&secondsettle==6, cluster(migrap)
* eststo
* ivregress 2sls rdt (mqntime10 mqntime10andljuv mqntime10andhjuv mqntime10andlteen mqntime10andhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside  if phase==2&L.rdt==0&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls rdt (mqntime10 mqntime10andljuv mqntime10andhjuv mqntime10andlteen mqntime10andhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside  if phase==2&bound==1&L.rdt==0&secondsettle==6, cluster(migrap)   
* eststo
* esttab using rdtandoutnotinfected_2ndp,   p  replace  label  varwidth(6) wrap tex  mlabels(full seaside full seaside  full seaside  )  addnotes(p-values are caliculated by cluster robust standard errors. We only used those who stayed 6 months from the 1st to the 2nd.)  
* eststo clear



* ivregress 2sls bite (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside if phase==2, cluster(migrap) 
* eststo
* ivregress 2sls bite (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside if phase==2&bound==1, cluster(migrap) 
* eststo

* ivregress 2sls bite (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen  mqntime10 if phase==2, cluster(migrap) 
* eststo
* ivregress 2sls bite (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen  mqntime10 if phase==2&bound==1, cluster(migrap) 
* eststo
* ivregress 2sls bite (mqntime10 mqntime10andljuv mqntime10andhjuv mqntime10andlteen mqntime10andhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside if phase==2, cluster(migrap) 
* eststo
* ivregress 2sls bite (mqntime10 mqntime10andljuv mqntime10andhjuv mqntime10andlteen mqntime10andhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside if phase==2&bound==1, cluster(migrap) 
* eststo

* ivregress 2sls bite (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside if phase==2&L.bite==1, cluster(migrap) 
* eststo
* ivregress 2sls bite (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside if phase==2&bound==1&L.bite==1, cluster(migrap) 
* eststo
* ivregress 2sls bite (mqntime10 mqntime10andljuv mqntime10andhjuv mqntime10andlteen mqntime10andhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside if phase==2&L.bite==1, cluster(migrap) 
* eststo
* ivregress 2sls bite (mqntime10 mqntime10andljuv mqntime10andhjuv mqntime10andlteen mqntime10andhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside if phase==2&bound==1&L.bite==1, cluster(migrap) 
* eststo


* esttab using biteandout_2ndp,  p  replace  label  varwidth(6) wrap tex mlabels(full seaside full "seaside" full "seaside" "full" "seaside " "full" "seaside " )  addnotes( p-values are caliculated by cluster robust standard errors. From column 7, we only used people who had mosquito bite at the 1st phase. )  
 
 

 
*  eststo clear

* ivregress 2sls flr (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside if phase==2, cluster(migrap) 
* eststo
* ivregress 2sls flr (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside if phase==2&bound==1, cluster(migrap) 
* eststo

* ivregress 2sls flr (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen  mqntime10 if phase==2, cluster(migrap) 
* eststo
* ivregress 2sls flr (mqnid  mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen  mqntime10 if phase==2&bound==1, cluster(migrap) 
* eststo
* ivregress 2sls flr (mqntime10 mqntime10andljuv mqntime10andhjuv mqntime10andlteen mqntime10andhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside if phase==2, cluster(migrap) 
* eststo
* ivregress 2sls flr (mqntime10 mqntime10andljuv mqntime10andhjuv mqntime10andlteen mqntime10andhteen  = D Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen outside if phase==2&bound==1, cluster(migrap) 
* eststo



* esttab using flrandout_2ndp ,  p  replace  label  varwidth(6) wrap tex mlabels(full seaside full "seaside" "10+ hours" "10+ hours +seaside" )  addnotes( p-values are caliculated by cluster robust standard errors ) 

* eststo clear
* ivregress 2sls absence2 (mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen  if phase==2&r4<=19&r4>=6, noconstant cluster(migrap) 
* eststo
* ivregress 2sls absence2 (mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen  if phase==2&bound==1&r4<=19&r4>=6, noconstant cluster(migrap) 
* eststo
* ivregress 2sls absence62 (mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen  if phase==2&r4<=19&r4>=6, noconstant cluster(migrap) 
* eststo
* ivregress 2sls absence62 (mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = Dandljuv Dandhjuv Dandhteen Dandlteen) ljuv hjuv lteen hteen  if phase==2&bound==1&r4<=19&r4>=6,  noconstant cluster(migrap) 
* eststo
* ivregress 2sls inactivefever (mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = Dandljuv Dandhjuv Dandhteen Dandlteen)  ljuv hjuv lteen hteen  if phase==2&r4<=19&r4>=6,noconstant  cluster(migrap) 
* eststo
* ivregress 2sls inactivefever (mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen  = Dandljuv Dandhjuv Dandhteen Dandlteen)  ljuv hjuv lteen hteen  if phase==2&bound==1&r4<=19&r4>=6,noconstant cluster(migrap) 
* eststo
* esttab using absence2andfever_2ndp,   p  replace  tex label  varwidth(6) wrap   addnotes( p-values are caliculated by cluster robust standard errors. The 2nd, 4th, and 6th column use seaside villages only. ) 

* gen lflr=L.flr
* label var dflr "$\Delta$  N. of bites"
* label var lflr "L. N. of bites"


* eststo clear
* sqreg  flr lflr dmqnid dmqnidandteen doutside if phase==2&bound==1,r(50) q(90 95)
* eststo
* sqreg  dflr  dmqnid dmqnidandteen doutside if phase==2&bound==1,r(50) q(90 95)
* eststo
* sqreg  dflr lflr dmqnid dmqnidandteen doutside if phase==2&bound==1,r(50) q(90 95)
* eststo

* esttab using flrandoutq_2nd,   p  replace  label  varwidth(6) wrap tex addnotes( p-values are caliculated 50 bootstrap. )  

* eststo clear

* sort miid09 phase


* *notprecise
* foreach X in  rdt {
* version 10: reg d`X'   dmqnid  dmqnidandunderteen dmqnidandteen   underteen teen if phase==2,    vce(cluster migrap)
* eststo
* version 10: reg d`X'   dmqnid  dmqnidandunderteen dmqnidandteen   underteen teen if phase==3,    vce(cluster migrap)
* eststo
* version 10: reg `X'   dmqnid  dmqnidandunderteen dmqnidandteen   underteen teen if phase==2&L.`X'==0,    vce(cluster migrap)
* eststo
* version 10: reg `X'   dmqnid  dmqnidandunderteen dmqnidandteen   underteen teen if phase==3&L.`X'==0,    vce(cluster migrap)
* eststo
* }

* foreach X in  bite {
* version 10: reg d`X'   dmqnid  dmqnidandunderteen dmqnidandteen   underteen teen if phase==2,    vce(cluster migrap)
* eststo
* version 10: reg d`X'   dmqnid  dmqnidandunderteen dmqnidandteen   underteen teen if phase==3,    vce(cluster migrap)
* eststo
* version 10: reg `X'   dmqnid  dmqnidandunderteen dmqnidandteen   underteen teen if phase==2&L.`X'==0,    vce(cluster migrap)
* eststo
* version 10: reg `X'   dmqnid  dmqnidandunderteen dmqnidandteen   underteen teen if phase==3&L.`X'==0,    vce(cluster migrap)
* eststo
* }

* esttab using DDmqnid,    p  replace label  varwidth(6) wrap tex addnotes( Odd columns use the 2nd phase and even columns use the 3rd phase. p-values are caliculated 50 bootstrap. )  
* eststo clear

* foreach X in  rdt {
* version 10: reg d`X'   dmqnid  dmqnidandunderteen dmqnidandteen   underteen teen if phase==2&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg d`X'   dmqnid  dmqnidandunderteen dmqnidandteen   underteen teen if phase==3&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg `X'   dmqnid  dmqnidandunderteen dmqnidandteen   underteen teen if phase==2&L.`X'==0&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg `X'   dmqnid  dmqnidandunderteen dmqnidandteen   underteen teen if phase==3&L.`X'==0&bound==1,    vce(cluster migrap)
* eststo
* }

* foreach X in  bite {
* version 10: reg d`X'   dmqnid  dmqnidandunderteen dmqnidandteen   underteen teen if phase==2&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg d`X'   dmqnid  dmqnidandunderteen dmqnidandteen   underteen teen if phase==3&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg `X'   dmqnid  dmqnidandunderteen dmqnidandteen   underteen teen if phase==2&L.`X'==0&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg `X'   dmqnid  dmqnidandunderteen dmqnidandteen   underteen teen if phase==3&L.`X'==0&bound==1,    vce(cluster migrap)
* eststo
* }

* esttab using DDmqnid_b,    p  replace label  varwidth(6) wrap tex addnotes( Odd columns use the 2nd phase and even columns use the 3rd phase.  )  
* eststo clear


* foreach X in   absence2  inactivefever  {
* version 10: reg d`X'   dmqnidandunderteen dmqnidandteen  underteen teen if phase==2&r4<20&r4>5,  noconstant  vce(cluster migrap)
* eststo
* version 10: reg d`X'   dmqnidandunderteen dmqnidandteen  underteen teen if phase==3&r4<20&r4>5,  noconstant  vce(cluster migrap)
* eststo
* }

* esttab using DDmqnid2,    p  replace   varwidth(6) wrap tex addnotes(We used only under 19 years old. Odd columns use the 2nd phase and even columns use the 3rd phase. )  

* eststo clear
* foreach X in  absence2 inactivefever {
* version 10: reg d`X'  dmqnidandunderteen dmqnidandteen  underteen teen if phase==2&bound==1&r4<20&r4>5, noconstant   vce(cluster migrap)
* eststo
* version 10: reg d`X'  dmqnidandunderteen dmqnidandteen  underteen teen if phase==3&bound==1&r4<20&r4>5, noconstant   vce(cluster migrap)
* eststo
* }

* esttab using DDmqnid2_b,    p  replace   varwidth(6) wrap tex addnotes(We used only under 19 years old. Odd columns use the 2nd phase and even columns use the 3rd phase.  )  
*  eststo clear
 
 
* foreach X in  rdt {
* version 10: reg d`X'   D Dandunderteen Dandteen  underteen teen if phase==2,    vce(cluster migrap)
* eststo
* version 10: reg d`X'   D Dandunderteen Dandteen  underteen teen if phase==3,    vce(cluster migrap)
* eststo
* version 10: reg `X'   D Dandunderteen Dandteen  underteen teen if phase==2&L.`X'==0,    vce(cluster migrap)
* eststo
* version 10: reg `X'   D Dandunderteen Dandteen  underteen teen if phase==3&L.`X'==0,    vce(cluster migrap)
* eststo
* }

* foreach X in  bite {
* version 10: reg d`X'   D Dandunderteen Dandteen  underteen teen if phase==2,    vce(cluster migrap)
* eststo
* version 10: reg d`X'   D Dandunderteen Dandteen  underteen teen if phase==3,    vce(cluster migrap)
* eststo
* version 10: reg `X'   D Dandunderteen Dandteen  underteen teen if phase==2&L.`X'==0,    vce(cluster migrap)
* eststo
* version 10: reg `X'   D Dandunderteen Dandteen  underteen teen if phase==3&L.`X'==0,    vce(cluster migrap)
* eststo
* }

* esttab using DDD,    p  replace label  varwidth(6) wrap tex addnotes( Odd columns use the 2nd phase and even columns use the 3rd phase.  )  
* eststo clear

* foreach X in  rdt {
* version 10: reg d`X'   D Dandunderteen Dandteen  underteen teen if phase==2&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg d`X'   D Dandunderteen Dandteen  underteen teen if phase==3&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg `X'   D Dandunderteen Dandteen  underteen teen if phase==2&L.`X'==0&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg `X'   D Dandunderteen Dandteen  underteen teen if phase==3&L.`X'==0&bound==1,    vce(cluster migrap)
* eststo
* }

* foreach X in  bite {
* version 10: reg d`X'   D Dandunderteen Dandteen  underteen teen if phase==2&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg d`X'   D Dandunderteen Dandteen  underteen teen if phase==3&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg `X'   D Dandunderteen Dandteen  underteen teen if phase==2&L.`X'==0&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg `X'   D Dandunderteen Dandteen  underteen teen if phase==3&L.`X'==0&bound==1,    vce(cluster migrap)
* eststo
* }

* esttab using DDD_b,    p  replace label  varwidth(6) wrap tex addnotes( Odd columns use the 2nd phase and even columns use the 3rd phase.  )  
* eststo clear


* foreach X in   absence2  inactivefever  {
* version 10: reg d`X'     Dandunderteen Dandteen  underteen teen if phase==2&r4<20&r4>5,  noconstant  vce(cluster migrap)
* eststo
* version 10: reg d`X'     Dandunderteen Dandteen  underteen teen if phase==3&r4<20&r4>5,  noconstant  vce(cluster migrap)
* eststo
* }

* esttab using DDD2,    p  replace   varwidth(6) wrap tex addnotes(We used only 6-19 years old. Odd columns use the 2nd phase and even columns use the 3rd phase.)
* eststo clear
* foreach X in   absence2 inactivefever {
* version 10: reg d`X'      Dandunderteen Dandteen  underteen teen if phase==2&bound==1&r4<20&r4>5, noconstant   vce(cluster migrap)
* eststo
* version 10: reg d`X'     Dandunderteen Dandteen  underteen teen if phase==3&bound==1&r4<20&r4>5, noconstant   vce(cluster migrap)
* eststo
* }

* esttab using DDD2_b,    p  replace   varwidth(6) wrap tex addnotes(We used only under 19 years old. Odd columns use the 2nd phase and even columns use the 3rd phase.)  
*  eststo clear

* *precise

* foreach X in  rdt {
* version 10: reg d`X'   dmqnid  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==2,    vce(cluster migrap)
* eststo
* version 10: reg d`X'   dmqnid  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==3,    vce(cluster migrap)
* eststo
* version 10: reg `X'   dmqnid  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==2&L.`X'==0,    vce(cluster migrap)
* eststo
* version 10: reg `X'   dmqnid  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==3&L.`X'==0,    vce(cluster migrap)
* eststo
* }

* foreach X in  bite {
* version 10: reg d`X'   dmqnid  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==2,    vce(cluster migrap)
* eststo
* version 10: reg d`X'   dmqnid  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==3,    vce(cluster migrap)
* eststo
* version 10: reg `X'   dmqnid  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==2&L.`X'==0,    vce(cluster migrap)
* eststo
* version 10: reg `X'   dmqnid  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==3&L.`X'==0,    vce(cluster migrap)
* eststo
* }

* esttab using DDmqnidp,    p  replace label  varwidth(6) wrap tex addnotes( Odd columns use the 2nd phase and even columns use the 3rd phase. p-values are caliculated 50 bootstrap. )  
* eststo clear

* foreach X in  rdt {
* version 10: reg d`X'   dmqnid  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==2&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg d`X'   dmqnid  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==3&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg `X'   dmqnid  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==2&L.`X'==0&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg `X'   dmqnid  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==3&L.`X'==0&bound==1,    vce(cluster migrap)
* eststo
* }

* foreach X in  bite {
* version 10: reg d`X'   dmqnid  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==2&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg d`X'   dmqnid  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==3&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg `X'   dmqnid  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==2&L.`X'==0&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg `X'   dmqnid  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==3&L.`X'==0&bound==1,    vce(cluster migrap)
* eststo
* }

* esttab using DDmqnid_bp,    p  replace label  varwidth(6) wrap tex addnotes( Odd columns use the 2nd phase and even columns use the 3rd phase.  )  
* eststo clear


* foreach X in   absence2  inactivefever  {
* version 10: reg d`X'   dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==2&r4<20&r4>5,  noconstant  vce(cluster migrap)
* eststo
* version 10: reg d`X'   dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==3&r4<20&r4>5,  noconstant  vce(cluster migrap)
* eststo
* }

* esttab using DDmqnid2p,    p  replace   varwidth(6) wrap tex addnotes(We used only under 19 years old. Odd columns use the 2nd phase and even columns use the 3rd phase. )  

* eststo clear
* foreach X in  absence2 inactivefever {
* version 10: reg d`X'  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==2&bound==1&r4<20&r4>5, noconstant   vce(cluster migrap)
* eststo
* version 10: reg d`X'  dmqnidandljuv dmqnidandhjuv dmqnidandlteen dmqnidandhteen   ljuv hjuv lteen hteen if phase==3&bound==1&r4<20&r4>5, noconstant   vce(cluster migrap)
* eststo
* }

* esttab using DDmqnid2_bp,    p  replace   varwidth(6) wrap tex addnotes(We used only under 19 years old. Odd columns use the 2nd phase and even columns use the 3rd phase.  )  
*  eststo clear
 
 
 
 
 
* foreach X in  rdt {
* version 10: reg d`X'   D  Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==2,    vce(cluster migrap)
* eststo
* version 10: reg d`X'   D  Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==3,    vce(cluster migrap)
* eststo
* version 10: reg `X'   D  Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==2&L.`X'==0,    vce(cluster migrap)
* eststo
* version 10: reg `X'   D  Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==3&L.`X'==0,    vce(cluster migrap)
* eststo
* }

* foreach X in  bite {
* version 10: reg d`X'   D  Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==2,    vce(cluster migrap)
* eststo
* version 10: reg d`X'   D  Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==3,    vce(cluster migrap)
* eststo
* version 10: reg `X'   D  Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==2&L.`X'==0,    vce(cluster migrap)
* eststo
* version 10: reg `X'   D  Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==3&L.`X'==0,    vce(cluster migrap)
* eststo
* }

* esttab using DDD,    p  replace label  varwidth(6) wrap tex addnotes( Odd columns use the 2nd phase and even columns use the 3rd phase.  )  
* eststo clear

* foreach X in  rdt {
* version 10: reg d`X'   D  Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==2&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg d`X'   D  Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==3&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg `X'   D  Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==2&L.`X'==0&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg `X'   D  Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==3&L.`X'==0&bound==1,    vce(cluster migrap)
* eststo
* }

* foreach X in  bite {
* version 10: reg d`X'   D  Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==2&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg d`X'   D  Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==3&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg `X'   D  Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==2&L.`X'==0&bound==1,    vce(cluster migrap)
* eststo
* version 10: reg `X'   D  Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==3&L.`X'==0&bound==1,    vce(cluster migrap)
* eststo
* }

* esttab using DDD_bp,    p  replace label  varwidth(6) wrap tex addnotes( Odd columns use the 2nd phase and even columns use the 3rd phase.  )  
* eststo clear


* foreach X in   absence2  inactivefever  {
* version 10: reg d`X'    Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==2&r4<20&r4>5,  noconstant  vce(cluster migrap)
* eststo
* version 10: reg d`X'    Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==3&r4<20&r4>5,  noconstant  vce(cluster migrap)
* eststo
* }

* esttab using DDD2p,    p  replace   varwidth(6) wrap tex addnotes(We used only 6-19 years old. Odd columns use the 2nd phase and even columns use the 3rd phase.)
* eststo clear
* foreach X in   absence2 inactivefever {
* version 10: reg d`X'     Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==2&bound==1&r4<20&r4>5, noconstant   vce(cluster migrap)
* eststo
* version 10: reg d`X'    Dandljuv Dandhjuv Dandlteen Dandhteen   ljuv hjuv lteen hteen if phase==3&bound==1&r4<20&r4>5, noconstant   vce(cluster migrap)
* eststo
* }

* esttab using DDD2_bp,    p  replace   varwidth(6) wrap tex addnotes(We used only under 19 years old. Odd columns use the 2nd phase and even columns use the 3rd phase.)  
*  eststo clear





* *kudo 

* reg rdt mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==1 , cluster(migrap) 
* eststo
* reg rdt mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==2 , cluster(migrap) 
* eststo
* reg rdt mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==3 , cluster(migrap) 
* eststo
* reg bite mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==1 , cluster(migrap) 
* eststo
* reg bite mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==2 , cluster(migrap) 
* eststo
* reg bite mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==3 , cluster(migrap) 
* eststo
* esttab using OLS,    p  replace   varwidth(6) wrap tex addnotes(p-value are caliculated by cluster robust standard error. Column 1 and 4 are 1st phase, 2 and 5 are 2nd phase, and 3 and 6 are 3rd phase.)  
* eststo clear

* reg rdt mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==1&bound==1 , cluster(migrap) 
* eststo
* reg rdt mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==2&bound==1 , cluster(migrap) 
* eststo
* reg rdt mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==3&bound==1 , cluster(migrap) 
* eststo
* reg bite mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==1&bound==1 , cluster(migrap) 
* eststo
* reg bite mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==2&bound==1 , cluster(migrap) 
* eststo
* reg bite mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==3&bound==1 , cluster(migrap) 
* eststo
* esttab using OLS_b,    p  replace   varwidth(6) wrap tex addnotes(p-value are caliculated by cluster robust standard error. Column 1 and 4 are 1st phase, 2 and 5 are 2nd phase, and 3 and 6 are 3rd phase.)
* eststo clear


* probit rdt mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==1 , cluster(migrap) 
* eststo
* probit rdt mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==2 , cluster(migrap) 
* eststo
* probit rdt mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==3 , cluster(migrap) 
* eststo
* probit bite mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==1 , cluster(migrap) 
* eststo
* probit bite mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==2 , cluster(migrap) 
* eststo
* probit bite mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==3 , cluster(migrap) 
* eststo
* esttab using probit,    p  replace   varwidth(6) wrap tex addnotes(p-value are caliculated by cluster robust standard error. Column 1 and 4 are 1st phase, 2 and 5 are 2nd phase, and 3 and 6 are 3rd phase.)  
* eststo clear

* probit rdt mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==1&bound==1 , cluster(migrap) 
* eststo
* probit rdt mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==2&bound==1 , cluster(migrap) 
* eststo
* probit rdt mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==3&bound==1 , cluster(migrap) 
* eststo
* probit bite mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==1&bound==1 , cluster(migrap) 
* eststo
* probit bite mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==2&bound==1 , cluster(migrap) 
* eststo
* probit bite mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==3&bound==1 , cluster(migrap) 
* eststo
* esttab using probit_b,    p  replace   varwidth(6) wrap tex addnotes(p-value are caliculated by cluster robust standard error. Column 1 and 4 are 1st phase, 2 and 5 are 2nd phase, and 3 and 6 are 3rd phase.)
* eststo clear


* *kudo precise

* reg rdt mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==1 , cluster(migrap) 
* eststo
* reg rdt mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==2 , cluster(migrap) 
* eststo
* reg rdt mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==3 , cluster(migrap) 
* eststo
* reg bite mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==1 , cluster(migrap) 
* eststo
* reg bite mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==2 , cluster(migrap) 
* eststo
* reg bite mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==3 , cluster(migrap) 
* eststo
* esttab using OLS_p,    p  replace   varwidth(6) wrap tex addnotes(p-value are caliculated by cluster robust standard error. Column 1 and 4 are 1st phase, 2 and 5 are 2nd phase, and 3 and 6 are 3rd phase.)  
* eststo clear

* reg rdt mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==1&bound==1 , cluster(migrap) 
* eststo
* reg rdt mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==2&bound==1 , cluster(migrap) 
* eststo
* reg rdt mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==3&bound==1 , cluster(migrap) 
* eststo
* reg bite mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==1&bound==1 , cluster(migrap) 
* eststo
* reg bite mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==2&bound==1 , cluster(migrap) 
* eststo
* reg bite mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==3&bound==1 , cluster(migrap) 
* eststo
* esttab using OLS_bp,    p  replace   varwidth(6) wrap tex addnotes(p-value are caliculated by cluster robust standard error. Column 1 and 4 are 1st phase, 2 and 5 are 2nd phase, and 3 and 6 are 3rd phase.)
* eststo clear


* probit rdt mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==1 , cluster(migrap) 
* eststo
* probit rdt mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==2 , cluster(migrap) 
* eststo
* probit rdt mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==3 , cluster(migrap) 
* eststo
* probit bite mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==1 , cluster(migrap) 
* eststo
* probit bite mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==2 , cluster(migrap) 
* eststo
* probit bite mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==3 , cluster(migrap) 
* eststo
* esttab using probit_p,    p  replace   varwidth(6) wrap tex addnotes(p-value are caliculated by cluster robust standard error. Column 1 and 4 are 1st phase, 2 and 5 are 2nd phase, and 3 and 6 are 3rd phase.)  
* eststo clear

* probit rdt mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==1&bound==1 , cluster(migrap) 
* eststo
* probit rdt mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==2&bound==1 , cluster(migrap) 
* eststo
* probit rdt mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==3&bound==1 , cluster(migrap) 
* eststo
* probit bite mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==1&bound==1 , cluster(migrap) 
* eststo
* probit bite mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==2&bound==1 , cluster(migrap) 
* eststo
* probit bite mqnid mqnidandljuv mqnidandhjuv mqnidandlteen mqnidandhteen ljuv hjuv lteen hteen outside if phase==3&bound==1 , cluster(migrap) 
* eststo
* esttab using probit_bp,    p  replace   varwidth(6) wrap tex addnotes(p-value are caliculated by cluster robust standard error. Column 1 and 4 are 1st phase, 2 and 5 are 2nd phase, and 3 and 6 are 3rd phase.)
* eststo clear
* save allcheck,replace
* *kudo 2
* graph bar rdt, by(phase mqnid) over(age60, label(labsize(tiny) angle(vertical) alternate) )
* graph export rdtandmqnid.pdf,replace

* eststo clear
* ivregress 2sls rdt ( mqnid  = D )   outside if phase==2&secondsettle==6&underteen==1, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid  = D )   outside if phase==2&secondsettle==6&teen==1, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid  = D )   outside if phase==2&secondsettle==6&teen==0&underteen==0, cluster(migrap) 
* eststo
* ivregress 2sls absence62 ( mqnid  = D )  if phase==2&secondsettle==6&underteen==1, cluster(migrap) 
* eststo
* ivregress 2sls absence62 ( mqnid  = D )  if phase==2&secondsettle==6&teen==1, cluster(migrap) 
* eststo
* reg absence62 mqnidandunderteen mqnidandteen underteen teen if phase==2&(teen==1|underteen==1) , noconstant cluster(migrap) 
* eststo

* esttab using OLS_a, p  replace   varwidth(6) wrap tex addnotes(p-value are caliculated by cluster robust standard error. Column 1 and 4 are 6-12 years old, 2 and 5 are 13-19 years old, and 3 is the others.) label


* ivregress 2sls absence62 (  mqnidandunderteen mqnidandteen  =  D Dandteen) teen outside if phase==2&secondsettle==6&r4>=6&r4<=19, cluster(migrap)
* eststo
* ivregress 2sls absence62 (  mqnidandunderteen mqnidandteen  =  D Dandteen) teen  if phase==2&secondsettle==6&r4>=6&r4<=19, cluster(migrap)
* eststo
* reg absence62   mqnidandunderteen mqnidandteen  teen  if phase==2&secondsettle==6&r4>=6&r4<=19, cluster(migrap)
* eststo
* reg absence62  mqnidandunderteen mqnidandteen teen outside if phase==2&secondsettle==6&r4>=6&r4<=19, cluster(migrap)
* eststo

* esttab using OLS_a2, p  replace   varwidth(6) wrap tex addnotes(p-value are caliculated by cluster robust standard error. Column 1 and 4 are 6-12 years old, 2 and 5 are 13-19 years old, and 3 is the others.) label

* eststo clear

* *kudo final
* gen outsideandteen=outside*teen
* gen outsideandunderteen=outside*underteen
* gen outsideandbaby=outside*baby

* label var outsideandbaby "outside $\times$ -5 years old"
* label var outsideandteen "outside $\times$ 13-19 years old"
* label var outsideandunderteen "outside $\times$ 6-12 years old"

* ivregress 2sls rdt ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen  if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen outside if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen outside outsideandunderteen outsideandteen if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* regress rdt  mqnid mqnidandunderteen mqnidandteen underteen teen  if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* regress rdt  mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* regress rdt  mqnid mqnidandunderteen mqnidandteen underteen teen outside outsideandunderteen outsideandteen if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* esttab using summary_rdt,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label  mlabel("2SLS" "2SLS""2SLS""OLS""OLS""OLS")


* eststo clear

* ivregress 2sls rdt ( mqnid = D )  if phase==2&secondsettle==6&teen==0&underteen==0, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid = D ) outside if phase==2&secondsettle==6&teen==0&underteen==0, cluster(migrap) 
* eststo

* ivregress 2sls rdt ( mqnid = D )  if phase==2&secondsettle==6&baby==1, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid = D ) outside if phase==2&secondsettle==6&baby==1, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid = D )  if phase==2&secondsettle==6&baby==0&teen==0&underteen==0, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid = D ) outside if phase==2&secondsettle==6&baby==0&teen==0&underteen==0, cluster(migrap) 
* eststo


* ivregress 2sls rdt ( mqnid = D )  if phase==2&secondsettle==6&underteen==1, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid = D ) outside if phase==2&secondsettle==6&underteen==1, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid = D )  if phase==2&secondsettle==6&teen==1, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid = D ) outside if phase==2&secondsettle==6&teen==1, cluster(migrap) 
* eststo
* esttab using summary_rdtbyi,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label  mlabel("-5\&20+" "-5\&20+" "-5" "-5" "20+" "20+" "6-12"  "6-12""13-19"  "13-19")

* eststo clear


* ivregress 2sls rdt ( mqnid = D )  if phase==2&baby==1, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid = D )  if phase==2&adult==1, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid = D )  if phase==2&underteen==1, cluster(migrap) 
* eststo
* ivregress 2sls rdt ( mqnid = D )  if phase==2&teen==1, cluster(migrap) 
* eststo
* esttab using summary_rdtbyinotomit,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label  mlabel("-5" "20+"  "6-12"    "13-19")
* eststo clear

* regress rdt mqnid if phase==2&secondsettle==6&teen==0&underteen==0, cluster(migrap) 
* eststo
* regress rdt mqnid outside if phase==2&secondsettle==6&teen==0&underteen==0, cluster(migrap) 
* eststo

* regress rdt mqnid  if phase==2&secondsettle==6&baby==1, cluster(migrap) 
* eststo
* regress rdt mqnid outside if phase==2&secondsettle==6&baby==1, cluster(migrap) 
* eststo
* regress rdt mqnid  if phase==2&secondsettle==6&baby==0&teen==0&underteen==0, cluster(migrap) 
* eststo
* regress rdt mqnid outside if phase==2&secondsettle==6&baby==0&teen==0&underteen==0, cluster(migrap) 
* eststo


* regress rdt mqnid if phase==2&secondsettle==6&underteen==1, cluster(migrap) 
* eststo
* regress rdt mqnid outside if phase==2&secondsettle==6&underteen==1, cluster(migrap) 
* eststo
* regress rdt mqnid  if phase==2&secondsettle==6&teen==1, cluster(migrap) 
* eststo
* regress rdt mqnid outside if phase==2&secondsettle==6&teen==1, cluster(migrap) 
* eststo
* esttab using summary_rdtbyo,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label  mlabel("-5\&20+" "-5\&20+" "-5" "-5" "20+" "20+" "6-12"  "6-12""13-19"  "13-19")



* eststo clear

* ivregress 2sls absence62 ( mqnid mqnidandteen= D Dandteen) teen if phase==2&secondsettle==6&r4>=6&r4<=19, cluster(migrap) 
* eststo
* ivregress 2sls absence62 ( mqnid mqnidandteen= D Dandteen) teen outside if phase==2&secondsettle==6&r4>=6&r4<=19&absence62<=10, cluster(migrap) 
* eststo
* ivregress 2sls absence62 ( mqnid mqnidandteen= D Dandteen) teen outside outsideandteen if phase==2&secondsettle==6&r4>=6&r4<=19&absence62<=10, cluster(migrap) 
* eststo
* regress absence62 mqnid mqnidandteen teen  if phase==2&secondsettle==6&r4>=6&r4<=19, cluster(migrap) 
* eststo
* regress absence62 mqnid mqnidandteen teen outside if phase==2&secondsettle==6&r4>=6&r4<=19&absence62<=10, cluster(migrap) 
* eststo
* regress absence62 mqnid mqnidandteen teen outside outsideandteen if phase==2&secondsettle==6&r4>=6&r4<=19&absence62<=10, cluster(migrap) 
* eststo
* esttab using summary_ab,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label  mlabel("2SLS" "2SLS""2SLS""OLS""OLS""OLS")

* eststo clear
* ivregress 2sls absence62 ( mqnid =D)  if phase==2&secondsettle==6&underteen==1, cluster(migrap) 
* eststo
* ivregress 2sls absence62 ( mqnid =D)  if phase==2&secondsettle==6&teen==1, cluster(migrap) 
* eststo
* ivregress 2sls absence62 ( mqnid =D) outside  if phase==2&secondsettle==6&underteen==1&absence62<=10, cluster(migrap) 
* eststo
* ivregress 2sls absence62 ( mqnid =D) outside if phase==2&secondsettle==6&teen==1&absence62<=10, cluster(migrap) 
* eststo


* esttab using summary_abbyi,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label  mlabel("6-12" "13-19" "6-12" "13-19")


* eststo clear
* regress absence62 mqnid   if phase==2&secondsettle==6&underteen==1, cluster(migrap) 
* eststo
* regress absence62 mqnid   if phase==2&secondsettle==6&teen==1, cluster(migrap) 
* eststo
* regress absence62 mqnid  outside if phase==2&secondsettle==6&underteen==1&absence62<=10, cluster(migrap) 
* eststo
* regress absence62 mqnid  outside if phase==2&secondsettle==6&teen==1&absence62<=10, cluster(migrap) 
* eststo

* esttab using summary_abbyo,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label  mlabel("6-12" "13-19" "6-12" "13-19")


* eststo clear
* ivregress 2sls inactivefever ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen  if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls inactivefever ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen outside if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* ivregress 2sls inactivefever ( mqnid mqnidandunderteen mqnidandteen  = D Dandunderteen  Dandteen) underteen teen outside outsideandunderteen outsideandteen if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* regress inactivefever  mqnid mqnidandunderteen mqnidandteen underteen teen  if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* regress inactivefever  mqnid mqnidandunderteen mqnidandteen underteen teen outside if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* regress inactivefever  mqnid mqnidandunderteen mqnidandteen underteen teen outside outsideandunderteen outsideandteen if phase==2&secondsettle==6, cluster(migrap) 
* eststo
* esttab using summary_fever,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label  mlabel("2SLS" "2SLS""2SLS""OLS""OLS""OLS")


* eststo clear
* ivregress 2sls inactivefever ( mqnid = D )  if phase==2&secondsettle==6&teen==0&underteen==0, cluster(migrap) 
* eststo
* ivregress 2sls inactivefever ( mqnid = D ) outside if phase==2&secondsettle==6&teen==0&underteen==0, cluster(migrap) 
* eststo

* ivregress 2sls inactivefever ( mqnid = D )  if phase==2&secondsettle==6&baby==1, cluster(migrap) 
* eststo
* ivregress 2sls inactivefever ( mqnid = D ) outside if phase==2&secondsettle==6&baby==1, cluster(migrap) 
* eststo
* ivregress 2sls inactivefever ( mqnid = D )  if phase==2&secondsettle==6&baby==0&teen==0&underteen==0, cluster(migrap) 
* eststo
* ivregress 2sls inactivefever ( mqnid = D ) outside if phase==2&secondsettle==6&baby==0&teen==0&underteen==0, cluster(migrap) 
* eststo

* ivregress 2sls inactivefever ( mqnid = D )  if phase==2&secondsettle==6&underteen==1, cluster(migrap) 
* eststo
* ivregress 2sls inactivefever ( mqnid = D ) outside if phase==2&secondsettle==6&underteen==1, cluster(migrap) 
* eststo
* ivregress 2sls inactivefever ( mqnid = D )  if phase==2&secondsettle==6&teen==1, cluster(migrap) 
* eststo
* ivregress 2sls inactivefever ( mqnid = D ) outside if phase==2&secondsettle==6&teen==1, cluster(migrap) 
* eststo
* esttab using summary_feverbyi,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label  mlabel("-5\&20+" "-5\&20+" "-5" "-5" "20+" "20+" "6-12"  "6-12""13-19"  "13-19")

* eststo clear


* regress inactivefever mqnid if phase==2&secondsettle==6&teen==0&underteen==0, cluster(migrap) 
* eststo
* regress inactivefever mqnid outside if phase==2&secondsettle==6&teen==0&underteen==0, cluster(migrap) 
* eststo

* regress inactivefever mqnid if phase==2&secondsettle==6&baby==1, cluster(migrap) 
* eststo
* regress inactivefever mqnid outside if phase==2&secondsettle==6&baby==1, cluster(migrap) 
* eststo
* regress inactivefever mqnid if phase==2&secondsettle==6&baby==0&teen==0&underteen==0, cluster(migrap) 
* eststo
* regress inactivefever mqnid outside if phase==2&secondsettle==6&baby==0&teen==0&underteen==0, cluster(migrap) 
* eststo

* regress inactivefever mqnid if phase==2&secondsettle==6&underteen==1, cluster(migrap) 
* eststo
* regress inactivefever mqnid outside if phase==2&secondsettle==6&underteen==1, cluster(migrap) 
* eststo
* regress inactivefever mqnid  if phase==2&secondsettle==6&teen==1, cluster(migrap) 
* eststo
* regress inactivefever mqnid outside if phase==2&secondsettle==6&teen==1, cluster(migrap) 
* eststo
* esttab using summary_feverbyo,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label  mlabel("-5\&20+" "-5\&20+" "-5" "-5" "20+" "20+" "6-12"  "6-12""13-19"  "13-19")
* eststo clear


* regress mqnid D  if phase==2&secondsettle==6&teen==0&underteen==0, cluster(migrap)
* eststo
* regress mqnid D  if phase==2&secondsettle==6&baby==1, cluster(migrap)
* eststo

* regress mqnid D  if phase==2&secondsettle==6&teen==0&underteen==0&baby==0, cluster(migrap)
* eststo
* regress mqnid D  if phase==2&secondsettle==6&underteen==1, cluster(migrap)
* eststo
* regress mqnid D  if phase==2&secondsettle==6&teen==1, cluster(migrap)
* eststo
* regress mqnid D outside if phase==2&secondsettle==6&teen==0&underteen==0, cluster(migrap)
* eststo
* regress mqnid D outside if phase==2&secondsettle==6&baby==1, cluster(migrap)
* eststo

* regress mqnid D outside if phase==2&secondsettle==6&teen==0&underteen==0&baby==0, cluster(migrap)
* eststo
* regress mqnid D outside if phase==2&secondsettle==6&underteen==1, cluster(migrap)
* eststo
* regress mqnid D outside if phase==2&secondsettle==6&teen==1, cluster(migrap)
* eststo
* esttab using summary_first,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label  mlabel("-5\&20+" "-5" "20+""6-12" "13-19""-5\&20+" "-5" "20+""6-12" "13-19")
* eststo clear

* regress mqnid D  if phase==2&baby==1, cluster(migrap)
* eststo

* regress mqnid D  if phase==2&adult==1, cluster(migrap)
* eststo
* regress mqnid D  if phase==2&underteen==1, cluster(migrap)
* eststo
* regress mqnid D  if phase==2&teen==1, cluster(migrap)
* eststo
* esttab using summary_firstnotomit,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label  mlabel("-5" "20+""6-12" "13-19")
* eststo clear
* gen campnet01andteen=campnet01*teen
* gen campnet01andunderteen=campnet01*underteen
* gen campnet01andbaby=campnet01*baby


* label var campnet01 "Distributed HH"
* label var campnet01andteen "Distributed HH $\times$ 13-19 years old"
* label var campnet01andunderteen "Distributed HH $\times$ 6-12 years old"
* label var campnet01andbaby "Distributed HH $\times$ -5 years old"

* regress rdt D Dandunderteen Dandteen underteen teen if phase==2&secondsettle==6, cluster(migrap)
* eststo
* regress rdt D Dandunderteen Dandteen underteen teen outside if phase==2&secondsettle==6, cluster(migrap)
* eststo
* regress rdt D Dandunderteen Dandteen underteen teen outside outsideandunderteen outsideandteen if phase==2&secondsettle==6, cluster(migrap)
* eststo
* regress rdt campnet01 campnet01andunderteen campnet01andteen underteen teen if phase==2&secondsettle==6, cluster(migrap)
* eststo
* regress rdt campnet01 campnet01andunderteen campnet01andteen underteen teen outside if phase==2&secondsettle==6, cluster(migrap)
* eststo
* regress rdt campnet01 campnet01andunderteen campnet01andteen underteen teen outside outsideandunderteen outsideandteen if phase==2&secondsettle==6, cluster(migrap)
* eststo
* esttab using summary_distef,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label  
* eststo clear

* regress rdt D Dandbaby Dandunderteen Dandteen baby underteen teen if phase==2&secondsettle==6, cluster(migrap)
* eststo
* regress rdt D Dandbaby Dandunderteen Dandteen baby underteen teen outside if phase==2&secondsettle==6, cluster(migrap)
* eststo
* regress rdt D Dandbaby Dandunderteen Dandteen baby underteen teen outside outsideandbaby outsideandunderteen outsideandteen if phase==2&secondsettle==6, cluster(migrap)
* eststo
* regress rdt campnet01 campnet01andbaby campnet01andunderteen campnet01andteen baby underteen teen if phase==2&secondsettle==6, cluster(migrap)
* eststo
* regress rdt campnet01 campnet01andbaby campnet01andunderteen campnet01andteen baby underteen teen outside if phase==2&secondsettle==6, cluster(migrap)
* eststo
* regress rdt campnet01 campnet01andbaby campnet01andunderteen campnet01andteen baby underteen teen outside outsideandbaby outsideandunderteen outsideandteen if phase==2&secondsettle==6, cluster(migrap)
* eststo
* esttab using summary_distef2,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label  
* eststo clear

* regress rdt D if phase==2&secondsettle==6&baby==1, cluster(migrap)
* eststo
* regress rdt D outside if phase==2&secondsettle==6&baby==1, cluster(migrap)
* eststo
* regress rdt D if phase==2&secondsettle==6&underteen==1, cluster(migrap)
* eststo
* regress rdt D outside if phase==2&secondsettle==6&underteen==1, cluster(migrap)
* eststo
* regress rdt D if phase==2&secondsettle==6&teen==1, cluster(migrap)
* eststo
* regress rdt D outside if phase==2&secondsettle==6&teen==1, cluster(migrap)
* eststo
* regress rdt D if phase==2&secondsettle==6&baby==0&underteen==0&teen==0, cluster(migrap)
* eststo
* regress rdt D outside if phase==2&secondsettle==6&baby==0&underteen==0&teen==0, cluster(migrap)
* eststo
* esttab using summary_distef3,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label   mlabel("-5" "-5" "6-12"  "6-12""13-19"  "13-19" "20+" "20+" )
* eststo clear

* regress rdt D if phase==2&baby==1, cluster(migrap)
* eststo

* regress rdt D if phase==2&underteen==1, cluster(migrap)
* eststo
* regress rdt D if phase==2&teen==1, cluster(migrap)
* eststo
* regress rdt D if phase==2&adult==1, cluster(migrap)
* eststo

* esttab using summary_distef3notomit,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label   mlabel("-5"   "6-12""13-19" "20+" )
* eststo clear

* regress rdt campnet01 if phase==2&secondsettle==6&baby==1, cluster(migrap)
* eststo
* regress rdt campnet01 outside if phase==2&secondsettle==6&baby==1, cluster(migrap)
* eststo
* regress rdt campnet01 if phase==2&secondsettle==6&underteen==1, cluster(migrap)
* eststo
* regress rdt campnet01 outside if phase==2&secondsettle==6&underteen==1, cluster(migrap)
* eststo
* regress rdt campnet01 if phase==2&secondsettle==6&teen==1, cluster(migrap)
* eststo
* regress rdt campnet01 outside if phase==2&secondsettle==6&teen==1, cluster(migrap)
* eststo
* regress rdt campnet01 if phase==2&secondsettle==6&baby==0&underteen==0&teen==0, cluster(migrap)
* eststo
* regress rdt campnet01 outside if phase==2&secondsettle==6&baby==0&underteen==0&teen==0, cluster(migrap)
* eststo
* esttab using summary_distef4,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label  mlabel("-5" "-5" "6-12"  "6-12""13-19"  "13-19" "20+" "20+" )

* eststo clear
* eststo clear


* *Whether nets are distributed or bought affect behavior?

* gen mqnhhper=mqnhhtotal/hhsize
* gen mqnhhperb=mqnhhtotal/nofbed
* gen netposper=h2/hhsize
* gen netposperb=h2/nofbed
* gen ntnetposper=noftorn/hhsize
* gen ntnetposperb=noftorn/nofbed

* gen women18=(r2==2&r4>=18)
* gen women18mqn=(r2==2&r4>=18&mqnid==1)
* egen nofwomen18=total(women18), by(phase mhid09)
* egen nofwomen18mqn=total(women18mqn), by(phase mhid09)

* gen mqnwomen18hhper=nofwomen18mqn/nofwomen18

* gen nofpregnet01=.
* replace nofpregnet01=1 if nofpregnet>0&nofpregnet!=.
* replace nofpregnet01=0 if nofpregnet==0

* graph twoway lpolyci mqnhhper netposper if phase==2&D==0&hl1==1&hhsize<=5,ciplot(rline) || lpolyci mqnhhper netposper if phase==2&D==1&hl1==1&hhsize<=5, ciplot(rline)  lpattern(dash)  legend(label( 2 "North") label( 4 "South"))
* graph export usagerateandnetpermember_2nd.eps,replace
* graph twoway lpolyci mqnhhper ntnetposper if phase==2&D==0&hl1==1&hhsize<=5,ciplot(rline) || lpolyci mqnhhper ntnetposper if phase==2&D==1&hl1==1&hhsize<=5, ciplot(rline)  lpattern(dash)  legend(label( 2 "North") label( 4 "South"))
* graph export usagerateandntnetpermember_2nd.eps,replace

* graph twoway lpolyci mqnhhper netposperb if phase==2&D==0&hl1==1&hhsize<=5,ciplot(rline) || lpolyci mqnhhper netposperb if phase==2&D==1&hl1==1&hhsize<=5, ciplot(rline)  lpattern(dash)  legend(label( 2 "North") label( 4 "South"))
* graph export usagerateandnetperbed_2nd.eps,replace
* graph twoway lpolyci mqnhhper ntnetposperb if phase==2&D==0&hl1==1&hhsize<=5,ciplot(rline) || lpolyci mqnhhper ntnetposperb if phase==2&D==1&hl1==1&hhsize<=5, ciplot(rline)  lpattern(dash)  legend(label( 2 "North") label( 4 "South"))
* graph export usagerateandntnetperbed_2nd.eps,replace

* graph bar mqnhh  if phase==2&hl1==1&hhsize==4,over(h2) over(G) 
* graph export mqnhhandh2_4.eps,replace
* graph bar mqnhh  if phase==2&hl1==1&hhsize==5,over(h2) over(G) 
* graph export mqnhhandh2_5.eps,replace
* graph bar mqnhh  if phase==2&hl1==1&hhsize==6,over(h2) over(G) 
* graph export mqnhhandh2_6.eps,replace


* ivregress 2sls absence62 (rdt=D) if phase==2,vce(cluster migrap)
* eststo
* ivregress 2sls absence62 (rdt=D) if phase==2&bound==1,vce(cluster migrap)
* eststo
* ivregress 2sls absence62 (rdt=D) if phase==2&underteen==1,vce(cluster migrap)
* eststo
* ivregress 2sls absence62 (rdt=D) if phase==2&underteen==1&bound==1,vce(cluster migrap)
* eststo
* esttab using absence62andrdt,  replace se   varwidth(6) wrap tex addnotes(Cluster robust standard error. ) label  mlabel("Full" "Boundary" "-12" "-12 \& Boundary" )

* gen labsence2=L.absence2
* label define lrdt 	0 "L.negative" 1 "L.positive"
* label value lrdt lrdt

* gen absence2_01=0
* replace absence2_01=1 if absence2>0&absence2!=.
* replace absence2_01=0 if absence2==0


* gen labsence2_01=0
* replace labsence2_01=1 if labsence2>0&labsence2!=.
* replace labsence2_01=0 if labsence2==0

* gen infstatus=.
* replace infstatus=3 if rdt==1&L.rdt==1
* replace infstatus=2 if rdt==1&L.rdt==0
* replace infstatus=1 if rdt==0&L.rdt==1
* replace infstatus=0 if rdt==0&L.rdt==0

* gen absence2_01_twoperiod=.
* replace absence2_01_twoperiod=3 if absence2_01==1&labsence2_01==1
* replace absence2_01_twoperiod=2 if absence2_01==1&labsence2_01==0
* replace absence2_01_twoperiod=1 if absence2_01==0&labsence2_01==1
* replace absence2_01_twoperiod=0 if absence2_01==0&labsence2_01==0



* label define infstatus 	0 "neg_to_neg" 1 "pos_to_neg" 2    "neg_to_pos"  3 "pos_to_pos"
* label value infstatus infstatus



* label define absence2_01_twoperiod 	0 "pre_to_pre" 1 "abs_to_pre" 2    "pre_to_abs"  3 "abs_to_abs"
* label value absence2_01_twoperiod absence2_01_twoperiod

* hist labsence2 if labsence2>0&phase==2,by(infstatus)  d w(1) xscale(r(30))
* graph export labsence2.pdf,replace

* hist absence2 if absence2>0&phase==2,by(infstatus)  d w(1) 
* graph export absence2.pdf,replace

* hist dabsence2 if phase==2,by(infstatus)  d w(1)
* graph export dabsence2_0.pdf,replace

save data/intermediate/forpaper/foranalysis,replace



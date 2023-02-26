use e_panel_2nd,clear
set more off

eststo clear

label define phase 1 "1st" 2 "2nd"
label value phase phase

gen HHincome12_6=(HH_salary_12_6+HH_self_12_6)/(hhsize*180)
gen HHincome6_0=(HH_salary_6_0+HH_self_6_0)/(hhsize*180)


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
label define age19 19 "older than 19"
label value age19 age19

gen schoolage=(r4>=6&r4<=16)
gen underteen=(r4>=6&r4<=12)
gen teen=(r4>=13&r4<=19) 

gen pregnant=(h31==1)
gen female=(r2==2)


label define female 0 "male" 1 "female"
label value female female

egen rdthhtotal=total(rdt) , by (mhid09 phase) 
gen rdtotherhh=rdthhtotal-rdt
gen lrdtotherhh=L.rdtotherhh
gen mqnidandrdtotherhh=rdtotherhh*mqnid
gen mqnidandlrdtotherhh=lrdtotherhh*mqnid
gen Dandrdtotherhh=rdtotherhh*D
gen Dandlrdtotherhh=lrdtotherhh*D





egen mqnhhtotal=total(mqnid) , by (mhid09 phase) 
gen mqnotherhhs=(mqnhhtotal-mqnid)/hhsize

gen cschool=(e3==1)
label define cschool 0 "no school" 1 "school"
label value cschool cschool

*help says: xtprobit fits random-effects and population-averaged probit models.    There is no command for a conditional fixed-effects model, as there does not exist a sufficient statistic allowing the fixed effects to be conditioned out of the likelihood.  Unconditional fixed-effects probit models may be fit with probit command with indicator variables for the panels.  However, unconditional fixed-effects estimates are biased.


gen inactivefever=h18b
replace inactivefever=0 if h18a==2

gen fathernwith=nwith if (r3==1&r2==1)|(r3==2&r2==1)
egen fathernwithhh=max(fathernwith), by (mhid09 phase)
gen mothernwith=nwith if (r3==1&r2==2)|(r3==2&r2==2)
egen mothernwithhh=max(mothernwith), by (mhid09 phase)
gen parentnwith=nwith if (r3==1|r3==2)
egen parentnwithhh=min(parentnwith), by (mhid09 phase)


*
outsheet mhid09 rdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\X.csv  if phase==1&mhlon!=.&mhlat!=. , comma nolabel noname replace
outsheet mhid09 mhlon mhlat using C:\Users\J.YAMASAKI\Documents\MATLAB\master\dist.csv  if phase==1&mhlon!=.&mhlat!=., comma nolabel noname replace
*ã´äEÇ…çiÇÈ
gen bound=(migrap==4|migrap==5|migrap==6|migrap==9|migrap==13|migrap==14|migrap==15|migrap==16)
replace bound=1 if migrap!=2&migrap!=7&migrap!=8&migrap!=9&migrap!=10&migrap!=11&migrap!=12

* age60ÇÃçÏê¨
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

gen age68=(r4<=8&r4>5)
gen age911=(r4<=11&r4>7)
gen age1214=(r4<=14&r4>11)
gen age1517=(r4<=17&r4>14)
gen age1820=(r4<=20&r4>17)
gen age2125=(r4<=25&r4>20)
gen age2640=(r4<=40&r4>25)


replace cschool=0 if e1==2
replace cschool=0 if agecategory>=8

*îNóÓÇ…ÇÊÇÈrdtÅAâ·í†ÅAâ·Ç…éhÇ≥ÇÍÇÈÇ÷ÇÃå¯â ÇÃä÷åW
*Ç‹Ç∏ÇÕÉOÉâÉtçÏê¨
graph bar mqnid , over(age60, label(labsize(tiny) angle(vertical) alternate) ) by(G phase) 
graph export age60_and_mosquitonet_2nd.eps,replace
graph export age60_and_mosquitonet_2nd.wmf,replace
graph bar mqnid if r8==1, over(age60, label(labsize(tiny) angle(vertical) alternate) ) by(G phase)  
graph export age60_and_mosquitonet_ifslept_2nd.eps,replace
graph bar rdt, over(age60, label(labsize(tiny) angle(vertical) alternate) ) by(G phase) 
graph export age60_and_rdt_2nd.eps,replace
graph export age60_and_rdt_2nd.wmf,replace
graph bar rdt if r8==1, over(age60, label(labsize(tiny) angle(vertical) alternate) ) by(G phase)  
graph export age60_and_rdt_ifslept_2nd.eps,replace
graph bar llitnid , over(age60, label(labsize(tiny) angle(vertical) alternate) ) by(G phase) 
graph export age60_and_llitn_2nd.eps,replace
graph twoway lpolyci inactive age60,by(rdt) degree(2)
graph export age60_and_fever_2nd.eps,replace
graph export age60_and_fever_2nd.wmf,replace

*gen drdt=D.rdt
*graph bar  drdt, over(age60, label(labsize(tiny) angle(vertical) alternate)) by(G)
*graph export age60_and_drdt_2nd.eps,replace
*graph bar drdt if L.mqnid==0&mqnid==1, over(age60, label(labsize(tiny) angle(vertical) alternate)) by(G)


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
gen Dandteen=D*teen
gen Dandunderteen=D*underteen

*rdtâÒãAï™êÕÇ∆couterfactualçÏê¨
reg D.rdt Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41  D.outside,  vce(cluster migrap)
eststo 

reg D.rdt Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41  D.outside i.migrap ,  robust
eststo

reg D.rdt Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41  D.outside if L.rdt==0,  vce(cluster migrap)
eststo
reg D.rdt Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41  D.outside i.agecategory if L.rdt==0,  vce(cluster migrap)
eststo


reg D.rdt Dandage04 Dandage57 Dandage810 Dandage1113  Dandage1719 Dandage2024  Dandage2540 Dandage41  D  D.outside ,  vce(cluster migrap)
eststo 


reg D.rdt Dandage04 Dandage57 Dandage810 Dandage1113  Dandage1719 Dandage2024  Dandage2540 Dandage41  D  D.outside if L.rdt==0,  vce(cluster migrap)
eststo 

reg D.rdt Dandage04 Dandage57 Dandage810 Dandage1113  Dandage1719 Dandage2024  Dandage2540 Dandage41  D  D.outside i.agecategory if L.rdt==0,  vce(cluster migrap)
eststo 

reg D.rdt D Danddmqnid1 Danddmqnid0 ,  vce(cluster migrap)
eststo

esttab using rdt_and_treat_2nd.tex,  dropped indicate(village FE = *.migrap)  style(tex) p  replace    nodepvar mtitles("D.rdt"  "D.rdt" "L.rdt=0"  "L.rdt=0" "D.rdt" "L.rdt=0"  "L.rdt=0"  "D.rdt")
eststo clear

*boundaryÇ≈ÇÃrdtâÒãAï™êÕ
reg D.rdt Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41  D.outside if bound==1,  vce(cluster migrap)
eststo 

reg D.rdt Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41  D.outside i.migrap if bound==1,  robust
eststo

reg D.rdt Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41  D.outside if L.rdt==0&bound==1,  vce(cluster migrap)
eststo
reg D.rdt Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41  D.outside i.agecategory if L.rdt==0&bound==1,  vce(cluster migrap)
eststo

reg D.rdt Dandage04 Dandage57 Dandage810 Dandage1113  Dandage1719 Dandage2024  Dandage2540 Dandage41  D  D.outside if bound==1,  vce(cluster migrap)
eststo 


reg D.rdt Dandage04 Dandage57 Dandage810 Dandage1113  Dandage1719 Dandage2024  Dandage2540 Dandage41  D  D.outside if L.rdt==0&bound==1,  vce(cluster migrap)
eststo 

reg D.rdt Dandage04 Dandage57 Dandage810 Dandage1113  Dandage1719 Dandage2024  Dandage2540 Dandage41  D  D.outside i.agecategory if L.rdt==0&bound==1,  vce(cluster migrap)
eststo 

reg D.rdt D Danddmqnid1 Danddmqnid0 if bound==1 ,  vce(cluster migrap)
eststo

esttab using rdt_and_treat_bound_2nd.tex,  dropped indicate(village FE = *.migrap) style(tex) p  replace   nodepvar mtitles("D.rdt"  "D.rdt" "L.rdt=0" "L.rdt=0" "D.rdt" "L.rdt=0" "L.rdt=0" "D.rdt")
eststo clear



*reg D.inactivefever Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside ,  vce(cluster migrap)
*outreg2 using rdt_and_treat_2nd.tex,append  tex(frag)
*reg D.inactivefever Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41  D.outside if L.mqnid==0,  vce(cluster migrap)
*outreg2 using rdt_and_treat_2nd.tex,append  tex(frag) 

*mqnidâÒãAï™êÕÇ∆couterfactualçÏê¨

reg D.mqnid Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside ,  vce(cluster migrap)
eststo 

reg D.mqnid Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside i.migrap,  vce(cluster migrap)
eststo 

reg D.mqnid Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside i.agecategory,  vce(cluster migrap)
eststo


reg D.ntllitnid Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside ,  vce(cluster migrap)
eststo 

reg D.ntllitnid Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside i.migrap,  robust
eststo 

reg D.ntllitnid Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside i.agecategory,  vce(cluster migrap)
eststo


esttab using mqnid_and_treat_2nd , dropped indicate(village FE = *.migrap)  style(tex) p  replace   mtitles("D.mqnid" "D.mqnid" "D.mqnid" "D.ntllitnid" "D.ntllitnid" "D.ntllitnid" )

eststo clear



reg D.mqnid Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside if bound==1 ,  vce(cluster migrap)
eststo 

reg D.mqnid Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside i.migrap if bound==1,  vce(cluster migrap)
eststo 

reg D.mqnid Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside i.agecategory if bound==1,  vce(cluster migrap)
eststo


reg D.ntllitnid Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside if bound==1 ,  vce(cluster migrap)
eststo 

reg D.ntllitnid Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside i.migrap if bound==1,  robust
eststo 

reg D.ntllitnid Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside i.agecategory if bound==1,  vce(cluster migrap)
eststo


esttab using mqnid_and_treat_bound_2nd.tex,  dropped indicate(village FE = *.migrap)  style(tex) p  replace   mtitles("D.mqnid" "D.mqnid" "D.mqnid" "D.ntllitnid" "D.ntllitnid" "D.ntllitnid" )

eststo clear




*reg D.llitnid Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside ,  vce(cluster migrap)
*outreg2 using mqnid_and_treat_2nd.tex,append  tex(frag) 

*reg D.ntmqnid Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside ,  vce(cluster migrap)
*outreg2 using mqnid_and_treat_2nd.tex,append  tex(frag) 

*reg D.ntllitnid Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside ,  vce(cluster migrap)
*outreg2 using mqnid_and_treat_2nd.tex,append  tex(frag) 

reg D.bite Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside ,  vce(cluster migrap)
eststo
reg D.bite Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside i.migrap,  vce(cluster migrap)
eststo

reg D.bite Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside i.agecategory,  vce(cluster migrap)
eststo


reg D.flr Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside ,  vce(cluster migrap)
eststo
reg D.flr Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside i.migrap,   vce(cluster migrap)
eststo

reg D.flr Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside i.agecategory,  vce(cluster migrap)
eststo

esttab using bite_and_treat_2nd.tex,  dropped indicate(village FE = *.migrap)   style(tex) p  replace  
eststo clear


reg D.bite Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside if bound==1,  vce(cluster migrap)
eststo
reg D.bite Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside i.migrap  if bound==1,  vce(cluster migrap)
eststo

reg D.bite Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside i.agecategory  if bound==1,  vce(cluster migrap)
eststo


reg D.flr Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside  if bound==1,  vce(cluster migrap)
eststo
reg D.flr Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside i.migrap  if bound==1,  robust
eststo

reg D.flr Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside i.agecategory  if bound==1,  vce(cluster migrap)
eststo

esttab using bite_and_treat_bound_2nd.tex,  dropped indicate(village FE = *.migrap)style(tex) p  replace  
eststo clear

*outreg2 using bite_and_treat_2nd.tex,append ctitle(D.num of bite) tex(frag) 
*reg D.flr Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside if L.mqnid==0 ,  vce(cluster migrap)
*outreg2 using bite_and_treat_2nd.tex,append ctitle(D.num of bite) tex(frag) 
reg D.bite Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside if L.mqnid==1 ,  vce(cluster migrap)
*outreg2 using bite_and_treat_2nd.tex,append  tex(frag) 

*îMÇ≈ìÆÇØÇ»Ç©Ç¡ÇΩì˙

reg D.inactivefever Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside ,  vce(cluster migrap)
eststo

reg D.inactivefever Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside i.migrap, vce(cluster migrap)
eststo

reg D.inactivefever Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 D.outside if bound==1,  vce(cluster migrap)
eststo

esttab using fever_and_treat_2nd.tex,  dropped indicate(village FE = *.migrap) style(tex) p  replace  mtitles("D.inactive" "D.inactive" "boundary")
eststo clear


*îjÇÍÇƒÇ¢ÇÈâ·í†ÇªÇ§Ç≈Ç»Ç¢â·í†Ç≈rdtÇ…ëŒÇ∑ÇÈâeãø?
reg rdt mqnid ntmqnid llitnid ntllitnid age04 age57 age810 age1113 age1416 age1719 age2024 age2540   i.migrap if phase==1, 
outreg2 using torn_and_rdt_2nd.tex,replace ctitle(rdt(1st)) tex(frag)

reg rdt mqnid ntmqnid llitnid ntllitnid age04 age57 age810 age1113 age1416 age1719 age2024 age2540   i.migrap if phase==2,  
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(2nd)) tex(frag)

ivregress 2sls  rdt age04 age57 age810 age1113 age1416 age1719 age2024 age2540   (mqnid=D)  if phase==2
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(2nd)IV) tex(frag)
ivregress 2sls  rdt  age04 age57 age810 age1113 age1416 age1719 age2024 age2540   (ntmqnid=D)  if phase==2
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(2nd)IV) tex(frag)
ivregress 2sls  rdt  age04 age57 age810 age1113 age1416 age1719 age2024 age2540   (llitnid=D)  if phase==2
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(2nd)IV) tex(frag)
ivregress 2sls  rdt  age04 age57 age810 age1113 age1416 age1719 age2024 age2540   (ntllitnid=D)  if phase==2
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(2nd)IV) tex(frag)

*åáê»ì˙êî 
gen absence=e6
replace absence=0 if e5==2
gen absence2=absence
replace absence2=0 if e7!=2
replace absence2=. if e5==.


gen absence6=e9
replace absence6=0 if e8==2
gen absence62=absence6
replace absence62=0 if e10!=2
replace absence62=. if e8==.

reg D.absence Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage17 , vce(cluster migrap)
outreg2 using absence_2nd.tex, replace  tex(frag)

reg D.absence2 Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage17 , vce(cluster migrap)
outreg2 using absence_2nd.tex, append  tex(frag)

reg D.mqnid Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage17 if absence2!=.&L.absence2!=. , vce(cluster migrap) 
outreg2 using absence_2nd.tex, append  tex(frag)
reg D.rdt Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage17 if absence2!=.&L.absence2!=. , vce(cluster migrap) 
outreg2 using absence_2nd.tex, append  tex(frag)
reg D.inactivefever Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage17 if absence2!=.&L.absence2!=. , vce(cluster migrap) 
outreg2 using absence_2nd.tex, append  tex(frag)


*ÉlÉbÉgÇÃñáêî
gen nofnet=h2
replace nofnet=0 if h1==2

*îjÇÍÇΩâ·í†ÇÃñáêîÇ∆ÇªÇÃï\
rename noftorned noftorn
label value noftorn nofnet campnet 
latab noftorn nofnet if phase==1&r3==1
*îjÇÍÇƒÇ¢Ç»Ç¢â·í†ÇÃñáêî
gen nofnottorn=nofnet-noftorn

*îzÇÁÇÍÇΩÉlÉbÉgÇÃñáêîÇÕÅH
label define hhsize 0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 11 11 12 12 13 13 14 14 15 15 16 16 17 17
label value hhsize hhsize
latab campnet G if r3==1
latab campnet hhsize if G==1&r3==1

gen hhsize3=.
replace hhsize3=1 if hhsize>=1
replace hhsize3=2 if hhsize>=4
replace hhsize3=3 if hhsize>=7
replace hhsize3=4 if hhsize>=10
replace hhsize3=5 if hhsize>=13
replace hhsize3=6 if hhsize>=16&hhsize<99

gen hhsize_lnofnet=hhsize*L.nofnet
gen hhsize_lnoftorn=hhsize*L.noftorn
gen hhsize_lnofnottorn=hhsize*L.nofnottorn

gen hhsize3_lnofnet=hhsize3*L.nofnet
gen hhsize3_lnoftorn=hhsize3*L.noftorn
gen hhsize3_lnofnottorn=hhsize3*L.nofnottorn
gen campnet01=(campnet>0&campnet!=.)

egen flrmean=mean(flr), by (mhid09 phase)
egen flrmax=max(flr), by (mhid09 phase)



eststo clear

*tobit campnet L.hhsize3 L.noftorn L.nofnottorn hhsize3_lnoftorn hhsize3_lnofnottorn i.migrap if G==1&r3==1,ll(0)
*outreg2 using distribution_2nd.tex,append ctitle(campnet) tex(frag)
*tobit campnet L.hhsize L.noftorn L.nofnottorn hhsize_lnoftorn hhsize_lnofnottorn i.migrap if G==1&r3==1&campnet0912==0,ll(0)
*outreg2 using distribution_2nd.tex,append ctitle(campnet10) tex(frag)
*tobit campnet L.hhsize L.noftorn L.nofnottorn hhsize_lnoftorn hhsize_lnofnottorn i.migrap if G==1&r3==1&campnet1001==0,ll(0)
*outreg2 using distribution_2nd.tex,append ctitle(campnet09) tex(frag)
 


*å√Ç¢â·í†ÇéÃÇƒÇΩÇ©Ç«Ç§Ç©
latab h15 if r3==1 &phase==2

*â∆åvÉåÉxÉãÇ≈ÇÃèäìæÇÃïœâª
gen D_HH_salary_6_0=HH_salary_6_0-HH_salary_12_6
gen D_HH_self_6_0=HH_self_6_0-HH_self_12_6

reg D_HH_salary_6_0 D if r3==1, vce(cluster migrap)
outreg2 using income_2nd.tex,replace ctitle(D.SalaryHH) tex(frag)

reg D_HH_self_6_0 D HH_self_12_6 if r3==1, vce(cluster migrap)
outreg2 using income_2nd.tex,append ctitle(D.Self employmentHH) tex(frag)

*å¬êlÉåÉxÉãÇ≈ÇÃèäìæ
gen D_salary_6_0=salary_6_0-salary_12_6
gen D_self_6_0=self_6_0-self_12_6


reg D_salary_6_0 D , vce(cluster migrap)
outreg2 using income_2nd.tex,append ctitle(D.Salary) tex(frag)
reg D_salary_6_0 D if L.mqnid==0 , vce(cluster migrap)
outreg2 using income_2nd.tex,append ctitle(D.Salary) tex(frag)
reg D_self_6_0 D , vce(cluster migrap)
outreg2 using income_2nd.tex,append ctitle(D.Self employment) tex(frag)
reg D_self_6_0 D self_12_6  if L.mqnid==0 , vce(cluster migrap)
outreg2 using income_2nd.tex,append ctitle(D.Self employment) tex(frag)

*à„ó√îÔéxèoÇ÷ÇÃå¯â 
reg D.mediex6 G   hhsize if r3==1,vce(cluster migrap)
outreg2 using mediex6_and_treat_2nd.tex,replace  tex(frag) 

*îjÇÍÇΩâ·í†ÇÃñáêîÇ≈å¯â ÇÃà·Ç¢
gen nofnet2=nofnet
replace nofnet2=L.nofnet if phase==2
gen noftorn2=noftorn
replace noftorn2=L.noftorn if phase==2
gen nofnottorn2=nofnottorn
replace nofnottorn2=L.nofnottorn if phase==2
gen hhsize32=hhsize3
replace hhsize32=L.hhsize3 if phase==2
gen wtp3000=(h17==2)
replace wtp3000=L.wtp3000 if phase==2



gen nofnet2sq=nofnet2^2
gen noftorn2sq=noftorn2^2
gen nofnottorn2sq=nofnottorn2^2
gen Dandnofnet=D*nofnet2
gen Dandnofnetsq=D*nofnet2sq
gen Dandnoftorn=D*noftorn2
gen Dandnoftornsq=D*noftorn2sq
gen Dandnofnottorn=D*nofnottorn2
gen Dandnofnottornsq=D*nofnottorn2sq

*replace Dandnofnet=0 if phase==1
*replace Dandnofnetsq=0 if phase==1
*replace Dandnoftorn=0 if phase==1
*replace Dandnoftornsq=0 if phase==1
*replace Dandhhsize=0 if phase==1

gen Dandnofnethhsize3=Dandnofnet/hhsize32
gen Dandnoftornhhsize3=Dandnoftorn/hhsize32
gen Dandnofnottornhhsize3=Dandnofnottorn/hhsize32
gen Dandnoftornhhsize32=Dandnoftornhhsize3
replace Dandnoftornhhsize32=0 if Dandnofnottornhhsize3<1

gen nofnethhsize3=nofnet/hhsize3
gen noftornhhsize3=noftorn/hhsize3
gen nofnottornhhsize3=nofnottorn/hhsize3


*xtprobit rdt G phase D Dandnofnet Dandnofnetsq Dandnoftorn Dandnoftornsq  i.migrap 

*ivregress 2sls D.rdt  (D.nofnethhsize=D) D.outside i.migrap, vce(cluster migrap)
*outreg2 using rdt_and_treat_2nd.tex,append ctitle(Delta rdt) tex(frag)


*1stÇ≈îjÇÍÇΩâ·í†Ç…êQÇƒÇ¢ÇΩÇ©Ç≈å¯â ÇÃà·Ç¢

gen mqnid2=mqnid
replace mqnid2=L.mqnid if phase==2
gen ntmqnid2=ntmqnid
replace ntmqnid2=L.ntmqnid if phase==2

gen Dandmqnid2=D*mqnid2
gen Dandntmqnid2=D*ntmqnid2

gen Dandnmqnid2=.
replace Dandnmqnid2=1 if Dandmqnid2==0&D==1
replace Dandnmqnid2=0 if Dandmqnid2==1|D==0

gen Dandage04andmqn = Dandage04*Dandmqnid2
gen Dandage57andmqn = Dandage57*Dandmqnid2
gen Dandage810andmqn = Dandage810*Dandmqnid2
gen Dandage1113andmqn= Dandage1113*Dandmqnid2
gen Dandage1416andmqn= Dandage1416*Dandmqnid2
gen Dandage1719andmqn= Dandage1719*Dandmqnid2
gen Dandage2024andmqn= Dandage2024*Dandmqnid2
gen Dandage2540andmqn= Dandage2540*Dandmqnid2
gen Dandage41andmqn= Dandage41*Dandmqnid2

gen Dandage04andnmqn = Dandage04*Dandnmqnid2
gen Dandage57andnmqn = Dandage57*Dandnmqnid2
gen Dandage810andnmqn = Dandage810*Dandnmqnid2
gen Dandage1113andnmqn= Dandage1113*Dandnmqnid2
gen Dandage1416andnmqn= Dandage1416*Dandnmqnid2
gen Dandage1719andnmqn= Dandage1719*Dandnmqnid2
gen Dandage2024andnmqn= Dandage2024*Dandnmqnid2
gen Dandage2540andnmqn= Dandage2540*Dandnmqnid2
gen Dandage41andnmqn= Dandage41*Dandnmqnid2



*xtprobit rdt G phase D Dandmqnid2 Dandntmqnid2 outside i.migrap 
*outreg2 using rdt_and_treat_2nd.tex,append ctitle(rdt) tex(frag)

*xtprobit mqnid  G phase D Dandmqnid2  outside i.migrap 
*outreg2 using mqnid_and_treat_2nd.tex,append ctitle(mqnid) tex(frag) 

*ócéôéÄñSó¶
label value h34x h35x h36x campnet
latab h34x h35x
latab h34x h36x

*íméØÇÃïœâª
reg D.k14g G L.k14g  if r3==1, vce(cluster migrap)
outreg2 using cap_and_treat_2nd.tex,replace  tex(frag)
reg D.k14g G   if r3==1, vce(cluster migrap)
outreg2 using cap_and_treat_2nd.tex,append  tex(frag)

*éûä‘îzï™
reg twork G i.migrap if phase==2,robust
outreg2 using time_and_treat_2nd.tex,replace  tex(frag)
reg thhtask G i.migrap if phase==2,robust
outreg2 using time_and_treat_2nd.tex,append tex(frag)
reg tschool G i.migrap if e3==1&phase==2,robust
outreg2 using time_and_treat_2nd.tex,append  tex(frag)
reg tsickrest G i.migrap if phase==2,robust
outreg2 using time_and_treat_2nd.tex,append  tex(frag)
reg trest G i.migrap if phase==2,robust
outreg2 using time_and_treat_2nd.tex,append  tex(frag)
reg tcare G i.migrap if phase==2,robust
outreg2 using time_and_treat_2nd.tex,append  tex(frag)

*â·í†Ç…êQÇƒÇ¢ÇΩéûä‘Çâ·í†ÇÃéÌóﬁï Ç…
gen mqntime=flr14x
gen ntmqntime=flr14x
replace ntmqntime=0 if ntmqnid==0
gen llitntime=flr14x
replace llitntime=0 if llitnid==0
gen ntllitntime=flr14x
replace ntllitntime=0 if ntllitnid==0

*âΩåÃé·é“Ç…å¯â Ç™Ç»Ç¢ÇÃÇ©ÅH

graph bar mqntime if mqnid==1, over(age60, label(labsize(tiny) angle(vertical) alternate) ) by(G) 
graph export age60_and_mqntime_2nd.eps,replace

graph twoway lpolyci outside  age60, by(cschool female) degree(2)
graph export age60_and_goout_2nd.eps,replace

latab agecategory flr15x

reg flr mqntime ntmqntime llitntime ntllitntime  age04 age57 age810 age1113 age1416 age1719 age2024 age2540,vce(cluster migrap)
outreg2 using outcome_and_young_2nd.tex, replace ctitle(num of bites) tex(frag)

ivregress 2sls flr (ntllitntime=D)   age04 age57 age810 age1113 age1416 age1719 age2024 age2540 if phase==2,vce(cluster migrap)
outreg2 using outcome_and_young_2nd.tex, append ctitle(num of bites) tex(frag)



reg rdt mqntime ntmqntime llitntime ntllitntime  age04 age57 age810 age1113 age1416 age1719 age2024 age2540,vce(cluster migrap)
outreg2 using outcome_and_young_2nd.tex,append  tex(frag)

ivregress 2sls rdt (ntllitntime=D) age04 age57 age810 age1113 age1416 age1719 age2024 age2540 if phase==2,vce(cluster migrap)
outreg2 using outcome_and_young_2nd.tex, append  tex(frag)


*â·Ç…éhÇ≥ÇÍÇÈÇ±Ç∆Ç∆rdtÇÃä÷åW
reg rdt flr bite, vce(cluster migrap)
outreg2 using rdt_and_bite_2nd.tex, replace  tex(frag)


*éÄñSó¶ÇÃåvéZ
*total(h35x)/total(h34x)
*display total(h36x)/total(h34x)

*êeÇ∆àÍèèÇ…êQÇƒÇ¢ÇÈéqãü
graph twoway lpolyci nwithparent age19 if r4<=19&r3==3&L.outside==0&L.mqnid==1,degree(2)
graph export age60_and_nwithparent_2nd.eps,replace
graph bar nwithchild  if r4<=19&r3==3, over(age19, label(labsize(small) angle(vertical) alternate) ) by(G phase)

graph bar nwithparent  if r4<=19&r3==3&D==1&D.mqnid==1&r2==1, over(age19, label(labsize(small) angle(vertical) alternate) )


*spatial
gen mhlatc=(mhlat+17.59158)/0.0242924
gen mhlonc=(mhlon-49.45678)/0.0205137

gen mhlat2=mhlatc^2
gen mhlon2=mhlonc^2
gen mhlat3=mhlatc^3
gen mhlon3=mhlonc^3
gen mhlat4=mhlatc^4
gen mhlon4=mhlonc^4
gen mhlat5=mhlatc^5
gen mhlon5=mhlonc^5
gen mhlonmhlat=mhlonc*mhlatc
gen mhlon2mhlat=mhlon2*mhlatc
gen mhlonmhlat2=mhlonc*mhlat2
gen mhlon3mhlat=mhlon3*mhlatc
gen mhlon3mhlat2=mhlon3*mhlat2
gen mhlonmhlat3=mhlonc*mhlat3
gen mhlon2mhlat3=mhlon2*mhlat3
gen mhlon4mhlat=mhlon4*mhlatc
gen mhlon4mhlat2=mhlon4*mhlat2
gen mhlon4mhlat3=mhlon4*mhlat3
gen mhlonmhlat4=mhlonc*mhlat4
gen mhlon2mhlat4=mhlon2*mhlat4
gen mhlon3mhlat4=mhlon3*mhlat4




geodist mhlat mhlon -17.5924000000 49.4664833333, generate(dist) 
gen dist2=dist^2
gen dist3=dist^3
gen road=(migrap==1|migrap==3|migrap==4|migrap==13|migrap==14|migrap==15|migrap==17|migrap==18)
gen roaddist=road*dist
gen roaddist2=road*dist2
gen roaddist3=road*dist3



reg D.rdt mhlatc mhlonc mhlat2 mhlon2 mhlat3 mhlon3 mhlat4 mhlon4 mhlat5 mhlon5 mhlonmhlat mhlonmhlat2 mhlon2mhlat mhlon2mhlat2 mhlonmhlat3 mhlon2mhlat3 mhlon3mhlat mhlon3mhlat2 mhlon4mhlat  mhlonmhlat4  G


reg D.mqnid dist dist2 dist3 roaddist roaddist2 roaddist3  G, vce(cluster migrap)

*forvalues X=1:9 {
*}

*3 period 
gen phase1=(phase==1)
gen phase2=(phase==2)
gen Gandphase1=G*phase1
gen Gandphase2=G*phase2
gen Gandphase=G*phase

reg t2 Gandphase1 Gandphase2, vce(cluster migrap)
outreg2 using 3period_2nd.tex,replace  tex(frag) 

gen mediexch=D.mediex6
replace mediexch=mediex6-(mediex12-mediex6) if phase==1
reg mediexch Gandphase1 Gandphase2 if r3==1, vce(cluster migrap)
outreg2 using 3period_2nd.tex,append tex(frag) 

gen h25a=h25
replace h25a=0 if h24==0
gen rdttakech=D.h25a
replace rdttakech=h25a-(h24-h25a)
reg rdttakech Gandphase1 Gandphase2, vce(cluster migrap)
outreg2 using 3period_2nd.tex,append tex(frag)


*Ç‡ÇÁÇ¡ÇΩñáêî
probit   campnet01    i.L.hhsize L.mqnhh L.noftorn L.nofnottorn hhsize_lnoftorn hhsize_lnofnottorn  i.migrap if G==1&r3==1
eststo 

reg campnet  i.L.hhsize L.mqnhh L.noftorn L.nofnottorn hhsize_lnoftorn hhsize_lnofnottorn i.migrap if G==1&r3==1&campnet01==1
eststo 

esttab using distribution_2nd.tex,  dropped  style(tex) p  replace 

*scoreçÏê¨

*äKç∑ÇÇ∆ÇÈïKóvÇ™Ç†ÇÈÇ‡ÇÃ

foreach X in rdt mqnid bite flr absence2 mediex6 inactivefever {
gen d`X'=D.`X'
egen d`X'sd0=sd(d`X')  if G==0
egen d`X'sd1=sd(d`X')  if G==1
egen d`X'sd=min(d`X'sd0) 

egen d`X'm0=mean(d`X') if G==0
egen d`X'm1=mean(d`X') if G==1
egen d`X'm=min(d`X'm0) 

gen d`X'sc=(d`X'-d`X'm)/(d`X'sd)
}

*Ç»Ç¢Ç‡ÇÃ
foreach X in D_salary_6_0 D_self_6_0 {
egen `X'sd0=sd(`X')  if G==0
egen `X'sd1=sd(`X')  if G==1
egen `X'sd=min(`X'sd0) 

egen `X'm0=mean(`X') if G==0
egen `X'm1=mean(`X') if G==1
egen `X'm=min(`X'm0) 
gen `X'sc=(`X'-`X'm)/(`X'sd)
}

gen step1=dmqnidsc+dbitesc+dflrsc
gen step2=drdtsc
gen step3=dmediex6sc+dinactivefeversc+D_salary_6_0sc+D_self_6_0sc
gen step3child=dmediex6sc+dinactivefeversc+dabsence2sc

reg step1  Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 ,  vce(cluster migrap)
outreg2 using score_2nd.tex,replace  tex(frag) 


reg step2   Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 Dandage1719 Dandage2024  Dandage2540 Dandage41 ,  vce(cluster migrap)
outreg2 using score_2nd.tex,append tex(frag) 

reg step3  Dandage1719 Dandage2024  Dandage2540 Dandage41 if r4>=17 ,  vce(cluster migrap)
outreg2 using score_2nd.tex,append tex(frag)

reg step3child  Dandage04 Dandage57 Dandage810 Dandage1113 Dandage1416 if r4<17 ,vce(cluster migrap)
outreg2 using score_2nd.tex,append tex(frag)

*â·í†ÇÃñáêîÇ™â·í†Ç…êQÇÈÇ©Ç÷ÇÃå¯â 
reg D.mqnid D.nofnet D.outside,  vce(cluster migrap)

gen increaseofnet=(D.nofnet>0&D.nofnet!=.)
replace increaseofnet=0 if D.nofnet<=0

reg D.mqnid increaseofnet D.outside,  vce(cluster migrap)

ivregress 2sls mqnid (D.nofnet=D) if L.mqnid==0
ivregress 2sls mqnid (increaseofnet=D) if L.mqnid==0



*â·í†ÇÃä¥êıÇ÷ÇÃLATEå¯â 
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


gen mqnidandfemale=mqnid*female
gen mqnidandcschool=mqnid*cschool
gen mqnidandschoolage=mqnid*schoolage
gen mqnidandteen=mqnid*teen
gen mqnidandunderteen =mqnid*underteen


gen ntmqnidandfemale=ntmqnid*female
gen ntmqnidandcschool=ntmqnid*cschool
gen ntmqnidandschoolage=ntmqnid*schoolage
gen ntmqnidandteen=ntmqnid*teen
gen ntmqnidandunderteen =ntmqnid*underteen

gen goout=.
replace goout=1 if outside==1|L.outside==1
replace goout=0 if outside==0&L.outside==0 
gen dmqnidandgoout=dmqnid*goout
gen mqnidandgoout=mqnid*goout
gen Dandgoout=D*goout

gen innet=flr14x
gen mqnidandinnet=mqnid*innet
gen dmqnidandinnet=dmqnid*innet
gen Dandinnet=D*innet
gen Dandfemale=D*female
gen Dandcschool=D*cschool

*

ivregress 2sls D.rdt (dmqnid dmqnidandteen dmqnidandunderteen dmqnidandfemale dmqnidandcschool = Dandteen Dandunderteen D Dandfemale Dandcschool outside L.outside) ,vce(cluster migrap)
eststo
ivregress 2sls D.rdt (dmqnid dmqnidandteen dmqnidandunderteen dmqnidandfemale dmqnidandcschool = Dandteen Dandunderteen D Dandfemale Dandcschool outside L.outside) teen female cschool ,vce(cluster migrap)
eststo

ivregress 2sls D.rdt (dmqnid dmqnidandteen dmqnidandunderteen dmqnidandfemale dmqnidandcschool = Dandteen Dandunderteen D Dandfemale Dandcschool outside L.outside)  if lrdt==0,vce(cluster migrap)
eststo
ivregress 2sls D.rdt (dmqnid dmqnidandteen dmqnidandunderteen dmqnidandfemale dmqnidandcschool = Dandteen Dandunderteen D Dandfemale Dandcschool outside L.outside) teen female cschool if lrdt==0 ,vce(cluster migrap)
eststo




esttab using dtmqnidiv_2nd.tex,  dropped style(tex) p  replace     mtitles("D.rdt""D.rdt" "L.rdt=0""L.rdt=0" ) 
eststo clear


*bound
ivregress 2sls D.rdt (dmqnid dmqnidandteen dmqnidandunderteen dmqnidandfemale dmqnidandcschool = Dandteen Dandunderteen D Dandfemale Dandcschool outside L.outside) if bound==1,vce(cluster migrap)
eststo
ivregress 2sls D.rdt (dmqnid dmqnidandteen dmqnidandunderteen dmqnidandfemale dmqnidandcschool = Dandteen Dandunderteen D Dandfemale Dandcschool outside L.outside) teen female cschool if bound==1 ,vce(cluster migrap)
eststo

ivregress 2sls D.rdt (dmqnid dmqnidandteen dmqnidandunderteen dmqnidandfemale dmqnidandcschool = Dandteen Dandunderteen D Dandfemale Dandcschool outside L.outside)  if lrdt==0&bound==1,vce(cluster migrap)
eststo
ivregress 2sls D.rdt (dmqnid dmqnidandteen dmqnidandunderteen dmqnidandfemale dmqnidandcschool = Dandteen Dandunderteen D Dandfemale Dandcschool outside L.outside) teen female cschool if lrdt==0&bound==1 ,vce(cluster migrap)
eststo


esttab using dtmqnidiv_bound_2nd.tex,  dropped style(tex) p  replace      mtitles("D.rdt""D.rdt" "L.rdt=0""L.rdt=0" ) 
eststo clear



*restricted sample

ivregress 2sls D.rdt (dmqnid = D  ) teen female cschool if outside==0&L.outside==0&dmqnid>=0 ,vce(cluster migrap)
eststo
ivregress 2sls D.rdt (dmqnid = D  ) female cschool if outside==0&L.outside==0&teen==0&dmqnid>=0 ,vce(cluster migrap)
eststo

matrix bnotteen=e(b)
gen bnotteen1=bnotteen[1,1]

matrix vnotteen=e(V)
gen vnotteen1=vnotteen[1,1]
gen nnotteen=e(N)


ivregress 2sls D.rdt (dmqnid = D  ) female cschool if outside==0&L.outside==0&teen==1&dmqnid>=0 ,vce(cluster migrap)
eststo


matrix bteen=e(b)
gen bteen1=bteen[1,1]

matrix vteen=e(V)
gen vteen1=vteen[1,1]
gen nteen=e(N)



ivregress 2sls D.rdt (dmqnid = D) teen female cschool  if outside==0&L.outside==0&lrdt==0&dmqnid>=0 ,vce(cluster migrap)
eststo
ivregress 2sls D.rdt (dmqnid = D ) female cschool if outside==0&L.outside==0&teen==0&lrdt==0&dmqnid>=0 ,vce(cluster migrap)
eststo

matrix bnotteenl=e(b)
gen bnotteen1l=bnotteenl[1,1]

matrix vnotteenl=e(V)
gen vnotteen1l=vnotteenl[1,1]
gen nnotteenl=e(N)

ivregress 2sls D.rdt (dmqnid = D ) female cschool if outside==0&L.outside==0&teen==1&lrdt==0&dmqnid>=0 ,vce(cluster migrap)
eststo



matrix bteenl=e(b)
gen bteen1l=bteenl[1,1]

matrix vteenl=e(V)
gen vteen1l=vteenl[1,1]
gen nteenl=e(N)


gen teentest=(bnotteen1-bteen1)/((vnotteen1+vteen1)^(1/2))
gen teentestl=(bnotteen1l-bteen1l)/((vnotteen1l+vteen1l)^(1/2))



esttab using rdtmqnidlate_2nd.tex,  dropped style(tex) p  replace  mtitles("D.rdt" "not teen " "teen" "L.rdt=0""not teen and L.rdt=0" "teen and L.rdt=0")
eststo clear





*restricted sample on bound

ivregress 2sls D.rdt (dmqnid = D ) teen female cschool  if outside==0&L.outside==0&dmqnid>=0&bound==1 ,vce(cluster migrap)
eststo
ivregress 2sls D.rdt (dmqnid = D ) female cschool  if outside==0&L.outside==0&teen==0&dmqnid>=0&bound==1 ,vce(cluster migrap)
eststo

matrix bnotteenb=e(b)
gen bnotteen1b=bnotteenb[1,1]

matrix vnotteenb=e(V)
gen vnotteen1b=vnotteenb[1,1]
gen nnotteenb=e(N)

ivregress 2sls D.rdt (dmqnid = D )  female cschool if outside==0&L.outside==0&teen==1&dmqnid>=0&bound==1 ,vce(cluster migrap)
eststo


matrix bteenb=e(b)
gen bteen1b=bteenb[1,1]

matrix vteenb=e(V)
gen vteen1b=vteenb[1,1]
gen nteenb=e(N)

ivregress 2sls D.rdt (dmqnid = D  outside L.outside) teen female cschool  if lrdt==0&dmqnid>=0&bound==1 ,vce(cluster migrap)
eststo
ivregress 2sls D.rdt (dmqnid = D  outside L.outside) female cschool  if teen==0&lrdt==0&dmqnid>=0&bound==1 ,vce(cluster migrap)
eststo


matrix bnotteenlb=e(b)
gen bnotteen1lb=bnotteenlb[1,1]

matrix vnotteenlb=e(V)
gen vnotteen1lb=vnotteenlb[1,1]
gen nnotteenlb=e(N)

ivregress 2sls D.rdt (dmqnid = D  outside L.outside)  female cschool  if teen==1&lrdt==0&dmqnid>=0&bound==1 ,vce(cluster migrap)
eststo


matrix bteenlb=e(b)
gen bteen1lb=bteenlb[1,1]

matrix vteenlb=e(V)
gen vteen1lb=vteenlb[1,1]
gen nteenlb=e(N)


gen teentestb=(bnotteen1b-bteen1b)/((vnotteen1b+vteen1b)^(1/2))
gen teentestlb=(bnotteen1lb-bteen1lb)/((vnotteen1lb+vteen1lb)^(1/2))




esttab using rdtmqnidlate_bound_2nd.tex,  dropped style(tex) p  replace  mtitles("D.rdt""not teen ""teen" "L.rdt=0""not teen and L.rdt=0" "teen and L.rdt=0")
eststo clear
*ãLèqìùåv
gen age=r4
gen educ=e1
replace educ=0 if e1==2

estpost ttest age educ rdt mqnid  inactivefever   if phase==1,by(G)
esttab using descriptive_2nd.tex,cell("mu_1(label(Untreated region)) mu_2(label(Treated region)) b(label(Diff)) se(label(s.e.)) N_1(label(Untreated region N)) N_2(label(Treated region N))") nonumber replace
eststo clear

estpost ttest age educ rdt mqnid  inactivefever   if phase==1&bound==1,by(G)
esttab using descriptiveb_2nd.tex,cell("mu_1(label(Untreated region)) mu_2(label(Treated region)) b(label(Diff)) se(label(s.e.)) N_1(label(Untreated region N)) N_2(label(Treated region N)) ") nonumber replace
eststo clear

replace HHincome12_6=F.HHincome12_6 if phase==1

gen info=k14g
replace info=0 if k14g==2

estpost ttest nofnet hhsize mqnhh info mhalt   if phase==1&r3==1,by(G)
esttab using descriptiveh_2nd.tex, cell("mu_1(label(Untreated region)) mu_2(label(Treated region)) b(label(Diff)) se(label(s.e.)) N_1(label(Untreated region N)) N_2(label(Treated region N))") nonumber replace
eststo clear

estpost ttest nofnet hhsize mqnhh info mhalt  if phase==1&r3==1&bound==1,by(G)
esttab using descriptivehb_2nd.tex,cell("mu_1(label(Untreated region)) mu_2(label(Treated region)) b(label(Diff)) se(label(s.e.)) N_1(label(Untreated region N)) N_2(label(Treated region N))") nonumber replace
eststo clear


*ñáêîï ÇÃï™êÕ


gen lmqnhh=L.mqnhh
gen lhhsize=L.hhsize
tabulate lhhsize, gen(lhhsize)
rename lhhsize11 lhhsize15

gen lnoftorn=L.noftorn
gen lnofnottorn=L.nofnottorn

gen campnetper01andage04=campnetper01*age04
gen campnetper01andage57=campnetper01*age57
gen campnetper01andage810=campnetper01*age810
gen campnetper01andage1113=campnetper01*age1113
gen campnetper01andage1416=campnetper01*age1416
gen campnetper01andage1719=campnetper01*age1719
gen campnetper01andage2024=campnetper01*age2024
gen campnetper01andage2540=campnetper01*age2540
gen campnetper01andage41=campnetper01*age41

gen campnetper1andage04=campnetper1*age04
gen campnetper1andage57=campnetper1*age57
gen campnetper1andage810=campnetper1*age810
gen campnetper1andage1113=campnetper1*age1113
gen campnetper1andage1416=campnetper1*age1416
gen campnetper1andage1719=campnetper1*age1719
gen campnetper1andage2024=campnetper1*age2024
gen campnetper1andage2540=campnetper1*age2540
gen campnetper1andage41=campnetper1*age41

gen campnetper0andage04=campnetper0*age04
gen campnetper0andage57=campnetper0*age57
gen campnetper0andage810=campnetper0*age810
gen campnetper0andage1113=campnetper0*age1113
gen campnetper0andage1416=campnetper0*age1416
gen campnetper0andage1719=campnetper0*age1719
gen campnetper0andage2024=campnetper0*age2024
gen campnetper0andage2540=campnetper0*age2540
gen campnetper0andage41=campnetper0*age41

gen campnetper1ob=(campnet>1)
replace campnetper1ob=. if campnet==0

reg D.mqnid campnetper0andage04 campnetper0andage57 campnetper0andage810 campnetper0andage1113 campnetper0andage1416 campnetper0andage1719 campnetper0andage2024  campnetper0andage2540 campnetper0andage41  campnetper1andage04 campnetper1andage57 campnetper1andage810 campnetper1andage1113 campnetper1andage1416 campnetper1andage1719 campnetper1andage2024  campnetper1andage2540 campnetper1andage41 D.outside ,  vce(cluster migrap)
eststo


reg D.mqnid campnetper01andage04 campnetper01andage57 campnetper01andage810 campnetper01andage1113 campnetper01andage1416 campnetper01andage1719 campnetper01andage2024  campnetper01andage2540 campnetper01andage41  campnetper1andage04 campnetper1andage57 campnetper1andage810 campnetper1andage1113 campnetper1andage1416 campnetper1andage1719 campnetper1andage2024  campnetper1andage2540 campnetper1andage41 D.outside,  vce(cluster migrap)
eststo

esttab using campnet_and_mqnid_2nd.tex,  dropped  style(tex) p  replace 
eststo clear

gen mqnhh_lnoftorn=L.mqnhh*lnoftorn
gen mqnhh_lnofnottorn=L.mqnhh*lnofnottorn 


pscore campnetper1ob lhhsize lmqnhh lnoftorn lnofnottorn hhsize_lnoftorn hhsize_lnofnottorn mqnhh_lnoftorn mqnhh_lnofnottorn if r3==1 , pscore(props) comsup level(0.1) 



graph bar nwithparent  if r4<=19&r3==3&L.outside==0&dmqnid==1&D==1, over(age19, label(labsize(small) angle(vertical) alternate) )
graph export nwithparent_dmqnid1_2nd.eps,replace
graph bar nwithchild  if r4<=19&r3==3&L.outside==0&dmqnid==1&D==1, over(age19, label(labsize(small) angle(vertical) alternate) ) 
graph export nwithchild_dmqnid1_2nd.eps,replace

*ç◊Ç©Ç¢ï™êÕ
reg D.mqnid c.D#i.agecategory#i.cschool i.agecategory#i.cschool , vce(cluster migrap)
eststo
reg D.mqnid c.D#i.agecategory#i.cschool i.agecategory#i.cschool if bound==1, vce(cluster migrap)
eststo
reg D.rdt c.D#i.agecategory#i.cschool i.agecategory#i.cschool  if lrdt==0, vce(cluster migrap)
eststo
reg D.rdt c.D#i.agecategory#i.cschool i.agecategory#i.cschool if bound==1&lrdt==0, vce(cluster migrap)
eststo
reg D.rdt c.D#i.agecategory#i.cschool i.agecategory#i.cschool D.outside if lrdt==0, vce(cluster migrap)
eststo
esttab using precise_2nd.tex,  dropped  style(tex) p   substitute(# and)   indicate(X = *.agecategory*.cschool) replace
eststo clear


reg outside i.agecategory cschool female, vce(cluster migrap)
eststo
reg outside i.agecategory cschool  female if bound==1, vce(cluster migrap)
eststo
reg outside i.agecategory cschool female if phase==2 , vce(cluster migrap)
eststo
reg outside i.agecategory cschool female if phase==2&bound==1, vce(cluster migrap)
eststo
esttab using outside_2nd.tex,  dropped  style(tex) p   substitute(# and) mtitle(outside bound phase2 phase2andbound)   replace
eststo clear

reg D.mqnid c.D#i.agecategory#i.cschool i.agecategory#i.cschool if e4ax!=7&e4ax!=8&e4ax!=9, vce(cluster migrap)
eststo
reg D.mqnid c.D#i.agecategory#i.cschool i.agecategory#i.cschool  if bound==1&e4ax!=7&e4ax!=8&e4ax!=9, vce(cluster migrap)
eststo
reg D.rdt c.D#i.agecategory#i.cschool i.agecategory#i.cschool if e4ax!=7&e4ax!=8&e4ax!=9, vce(cluster migrap)
eststo
reg D.rdt c.D#i.agecategory#i.cschool i.agecategory#i.cschool if bound==1&e4ax!=7&e4ax!=8&e4ax!=9, vce(cluster migrap)
eststo
reg D.rdt c.D#i.agecategory#i.cschool i.agecategory#i.cschool D.outside if e4ax!=7&e4ax!=8&e4ax!=9, vce(cluster migrap)
eststo
reg D.rdt c.D#i.agecategory#i.cschool i.agecategory#i.cschool  D.outside  if bound==1&e4ax!=7&e4ax!=8&e4ax!=9, vce(cluster migrap)
eststo
esttab using precise2_2nd.tex,  dropped  style(tex) p  indicate(X = *.agecategory*.cschool)  substitute(# and)  replace
eststo clear


reg D.mqnid c.D#i.agecategory c.D#i.female c.D#cschool i.female i.cschool i.agecategory , vce(cluster migrap)


reg outside i.agecategory cschool  if e4ax!=7&e4ax!=8&e4ax!=9, vce(cluster migrap)
eststo
reg outside i.agecategory cschool  if bound==1&e4ax!=7&e4ax!=8&e4ax!=9, vce(cluster migrap)
eststo
reg outside i.agecategory cschool if phase==2& e4ax!=7&e4ax!=8&e4ax!=9 , vce(cluster migrap)
eststo
reg outside i.agecategory cschool  if phase==2&bound==1& e4ax!=7&e4ax!=8&e4ax!=9, vce(cluster migrap)
eststo
esttab using outside2_2nd.tex,  dropped  style(tex) p    replace
eststo clear

reg mqnid  i.agecategory c.female#i.agecategory c.cschool#i.agecategory  if phase==1&outside==0, vce(cluster migrap)
eststo
reg mqnid  i.agecategory c.female#i.agecategory c.cschool#i.agecategory  if phase==1&bound==1&outside==0, vce(cluster migrap)
eststo
esttab using mqnid1st_2nd.tex, style(tex) p  substitute(# and) mtitle(mqnid "on boundary") replace wide

eststo clear


*mqnidÇ‚ÇËíºÇµ

gen  dntllitnid = D.ntllitnid


reg dmqnid c.age05#c.D c.age68#c.D c.age911#c.D c.age1214#c.D c.age1517#c.D c.age1820#c.D c.age2125#c.D c.age2640#c.D c.age41#c.D c.female#c.D c.cschool#c.D  age68 age911 age1214 age1517 age1820 age2125 age2640 age41 female cschool if outside==0&L.outside==0&L.mqnid==0 , vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo


*reg dmqnid i.agecategory#c.D c.female#c.D c.cschool#c.D i.agecategory female cschool if outside==0&L.outside==0&L.mqnid==0 , vce(bootstrap, seed(1) cluster(migrap) idcluster(newid)group(miid09))
*eststo 

reg dmqnid c.age05#c.D c.age68#c.D c.age911#c.D c.age1214#c.D c.age1517#c.D c.age1820#c.D c.age2125#c.D c.age2640#c.D c.age41#c.D c.female#c.D c.cschool#c.D  age68 age911 age1214 age1517 age1820 age2125 age2640 age41 female cschool  if outside==0&L.outside==0&L.mqnid==1 , vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo 


reg dmqnid c.age05#c.D c.age68#c.D c.age911#c.D c.age1214#c.D c.age1517#c.D c.age1820#c.D c.age2125#c.D c.age2640#c.D c.age41#c.D c.female#c.D c.cschool#c.D  age68 age911 age1214 age1517 age1820 age2125 age2640 age41 female cschool if outside==0&L.outside==0&L.mqnid==0&bound==1 , vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo 

reg dmqnid c.age05#c.D c.age68#c.D c.age911#c.D c.age1214#c.D c.age1517#c.D c.age1820#c.D c.age2125#c.D c.age2640#c.D c.age41#c.D c.female#c.D c.cschool#c.D  age68 age911 age1214 age1517 age1820 age2125 age2640 age41 female cschool if outside==0&L.outside==0&L.mqnid==1&bound==1 , vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo 

esttab using mqnid_and_treat_2nd2.tex,  dropped style(tex) p  replace   substitute(# and) note(p-value in parentheses. It is calculated by bootstrap of 50 iterations) mtitles(   "L.mqnid=0" "L.mqnid=1"  "L.mqnid=0" "L.mqnid=1"  )
eststo clear
	


reg dmqnid i.agecategory#c.D c.female#c.D c.cschool#c.D i.agecategory female cschool if outside==0&L.outside==0&bound==1, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo 


reg dntllitnid  i.agecategory#c.D c.female#c.D c.cschool#c.D i.agecategory female cschool if outside==0&L.outside==0&bound==1, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo 

esttab using mqnid_and_treat_bound_2nd2.tex,  dropped indicate(trend by covariates= *.agecategory female cschool ) style(tex) p  replace    substitute(# and) note(p-value in parentheses. It is calculated by bootstrap of 50 iterations) 
eststo clear


*rdtÇ‚ÇËÇ»Ç®Çµ


reg drdt c.age05#c.D c.age68#c.D c.age911#c.D c.age1214#c.D c.age1517#c.D c.age1820#c.D c.age2125#c.D c.age2640#c.D D c.female#c.D c.cschool#c.D  age68 age911 age1214 age1517 age1820 age2125 age2640 age41 female cschool  , vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo

reg drdt c.age05#c.D c.age68#c.D c.age911#c.D c.age1214#c.D c.age1517#c.D c.age1820#c.D c.age2125#c.D c.age2640#c.D D c.female#c.D c.cschool#c.D  age68 age911 age1214 age1517 age1820 age2125 age2640 age41 female cschool if lrdt==0  , vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo

reg drdt  c.mqnid#c.D c.lrdtotherhh#c.D D mqnid lrdtotherhh,  vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo 

esttab using rdt_and_treat_2nd2.tex,  dropped style(tex) p  replace  nodepvar mtitles("D.rdt"   "L.rdt=0" "D.rdt") substitute(# and) note(p-value in parentheses. It is calculated by bootstrap of 50 iterations)  indicate(trend by covariates= age** age*** age**** female cschool)
eststo clear

reg drdt c.age05#c.D c.age68#c.D c.age911#c.D c.age1214#c.D c.age1517#c.D c.age1820#c.D c.age2125#c.D c.age2640#c.D D c.female#c.D c.cschool#c.D  age68 age911 age1214 age1517 age1820 age2125 age2640 age41 female cschool  if bound==1, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo



reg drdt c.age05#c.D c.age68#c.D c.age911#c.D c.age1214#c.D c.age1517#c.D c.age1820#c.D c.age2125#c.D c.age2640#c.D D c.female#c.D c.cschool#c.D  age68 age911 age1214 age1517 age1820 age2125 age2640 age41 female cschool if lrdt==0&bound==1  , vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo

reg drdt  c.mqnid#c.D c.lrdtotherhh#c.D D mqnid lrdtotherhh if bound==1,  vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo 

esttab using rdt_and_treat_bound_2nd2.tex,  dropped  p  replace   nodepvar mtitles("D.rdt"  "L.rdt=0" "D.rdt" ) note(p-value in parentheses. It is calculated by bootstrap of 50 iterations) substitute(# and)  indicate(trend by covariates= age** age*** age**** female cschool)
eststo clear



*D==0Ç≈ÇÃmqnid
reg mqnid i.agecategory female cschool doutside if D==0&L.mqnid==0, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))

reg mqnid i.agecategory female cschool doutside if D==0&bound==1&L.mqnid==0,  vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo 

esttab using mqnid_without_2nd.tex,  dropped replace  nodepvar mtitles("mqnid" "bound")

*bite flrÇ‚ÇËÇ»Ç®Çµ

eststo clear

drop dbite
drop dflr
gen dbite=D.bite
gen dflr=D.flr

reg dbite i.agecategory#c.D c.female#c.D c.cschool#c.D i.agecategory female cschool doutside,  vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo 

reg dbite i.agecategory#c.D c.female#c.D c.cschool#c.D doutside,  vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo 

reg dflr i.agecategory#c.D c.female#c.D c.cschool#c.D i.agecategory female cschool doutside,  vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo 

reg dflr i.agecategory#c.D c.female#c.D c.cschool#c.D doutside,  vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo 


esttab using bite_and_treat_2nd2.tex,  dropped indicate(trend by covariates= *.agecategory female cschool) style(tex) p  replace   substitute(# and)
eststo clear

reg dbite i.agecategory#c.D c.female#c.D c.cschool#c.D i.agecategory female cschool doutside if bound==1,  vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo 

reg dbite i.agecategory#c.D c.female#c.D c.cschool#c.D doutside if bound==1,  vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo 

reg dflr i.agecategory#c.D c.female#c.D c.cschool#c.D i.agecategory female cschool doutside if bound==1,  vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo 

reg dflr i.agecategory#c.D c.female#c.D c.cschool#c.D doutside if bound==1,  vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo 


esttab using bite_and_treat_bound_2nd2.tex,  dropped indicate(trend by covariates= *.agecategory female cschool) style(tex) p  replace  substitute(# and)
eststo clear



*inactiveÇ∆absenceÇ‚ÇËÇ»Ç®Çµ


reg D.inactive (i.agecategory c.female c.cschool)#c.D i.agecategory female cschool,  vce(cluster migrap) 
eststo 

reg D.inactive (i.agecategory c.female c.cschool)#c.D ,  vce(cluster migrap)
eststo 

reg D.inactive (i.agecategory c.female c.cschool)#c.D i.agecategory female cschool if bound==1,  vce(cluster migrap) 
eststo 

reg D.inactive (i.agecategory c.female c.cschool)#c.D if bound==1,  vce(cluster migrap)
eststo 


esttab using fever_and_treat_2nd2.tex,  dropped indicate(trend by covariates= *.agecategory female cschool) style(tex) p  replace  substitute(# and)  mtitles("D.inactive" "D.inactive" "boundary" "boundary")
eststo clear



reg D.absence (i.agecategory c.female)#c.D  , vce(cluster migrap)
eststo 


reg D.absence (i.agecategory c.female)#c.D i.agecategory c.female , vce(cluster migrap)
eststo 

reg D.absence2 (i.agecategory c.female)#c.D   , vce(cluster migrap)
eststo
reg D.absence2 (i.agecategory c.female)#c.D i.agecategory c.female  , vce(cluster migrap)
eststo

esttab using absence_2nd2.tex,  dropped indicate(trend by covariates= *.agecategory female) style(tex) p  replace  substitute(# and)  mtitles("D.absence" "D.absence" "D.absence2" "D.absence2")
eststo clear


tab teentest
tab teentestl
tab teentestb
tab teentestlb

gen migrap2=migrap
replace migrap2=13 if migrap==14
replace migrap2=14 if migrap==15
replace migrap2=15 if migrap==16
replace migrap2=16 if migrap==17
replace migrap2=17 if migrap==18

gen torn=.
replace torn=1 if mqnid==1
replace torn=0 if ntmqnid==1
gen loutside=L.outside
graph twoway lpolyci mqnid age60 if outside==0&loutside==0&phase==2,degree(2)|| lpolyci torn age60 if outside==0&loutside==0&phase==2,  by(G cschool female) degree(2)
graph export torn_and_mqnid_2nd.eps,replace




gen mqnidandlmqnid=mqnid*L.mqnid
gen lmqnid=L.mqnid
gen lmqn_mqn_teen=mqnid*L.mqnid*teen
egen villagerdt=mean(rdt) ,by (migrap phase)
gen lvillagerdt=L.villagerdt
gen mqnidandvillagerdt=mqnid*villagerdt
gen mqnidandlvillagerdt=mqnid*lvillagerdt
gen Dandlvillagerdt=D*lvillagerdt
gen Dandvillagerdt=D*villagerdt
gen Dandlmqnid=D*L.mqnid

gen nofnet01=1 if nofnet>1&nofnet<98
replace nofnet01=0 if nofnet==1
label define nofnet01 0 "#ofnet=1" 1 "#ofnet>1"
label value nofnet01 nofnet01
graph bar (count)mqnid  if teen==1&r3==3&outside==0, by(nofnet01) over(parentnwithhh,label(labsize(small) angle(vertical) alternate) )
graph export parentnwithhh_and_mqnid_2nd.eps,replace

gen ntmqnidandlntmqnid=ntmqnid*L.ntmqnid
gen lntmqnid=L.ntmqnid
gen ntmqnidandrdtotherhh=ntmqnid*rdtotherhh



save pre_2nd,replace


*bootstrap

reg drdt c.D#i.agecategory#i.r2 if L.rdt==0&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
reg drdt c.D#i.agecategory c.D#i.agecategory#r2 if L.rdt==0&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
reg drdt c.D#i.agecategory#i.r2 if L.rdt==1&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09) reps(500))
eststo
reg drdt c.D#i.agecategory c.D#i.agecategory#r2 if L.rdt==1&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09) reps(500))
eststo
esttab using rdt_and_treat_sex_bs_2nd.tex,  dropped  style(tex) p  replace
eststo clear


reg dmqnid c.D#i.agecategory#i.r2 if L.mqnid==0&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
reg dmqnid c.D#i.agecategory c.D#i.agecategory#r2 if L.mqnid==0&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
reg dmqnid c.D#i.agecategory#i.r2 if L.mqnid==1&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
reg dmqnid c.D#i.agecategory c.D#i.agecategory#r2 if L.mqnid==1&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
esttab using mqnid_and_treat_sex_bs_2nd.tex,  dropped  style(tex) p  replace

eststo clear


reg drdt c.D#i.agecategory  if L.rdt==0&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
reg drdt i.D c.D#i.agecategory if L.rdt==0&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
reg drdt c.D#i.agecategory  if L.rdt==1&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09) reps(500))
eststo
reg drdt i.D c.D#i.agecategory if L.rdt==1&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09) reps(500))
eststo
esttab using rdt_and_treat_bs_2nd.tex,  dropped  style(tex) p  replace

eststo clear

reg dmqnid c.D#i.agecategory  if L.mqnid==0&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
reg dmqnid i.D c.D#i.agecategory if L.mqnid==0&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
reg dmqnid c.D#i.agecategory  if L.mqnid==1&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
reg dmqnid i.D c.D#i.agecategory if L.mqnid==1&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
esttab using mqnid_and_treat_bs_2nd.tex,  dropped  style(tex) p  replace

eststo clear


reg drdt c.D#i.agecategory#i.cschool if L.rdt==0&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
reg drdt c.D#i.agecategory c.D#i.agecategory#i.cschool if L.rdt==0&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
reg drdt c.D#i.agecategory#i.cschool if L.rdt==1&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09) reps(500))
eststo
reg drdt c.D#i.agecategory c.D#i.agecategory#i.cschool if L.rdt==1&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09)reps(500))
eststo
esttab using rdt_and_treat_cschool_bs_2nd.tex,  dropped  style(tex) p  replace
eststo clear


reg dmqnid c.D#i.agecategory#i.cschool if L.mqnid==0&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
reg dmqnid c.D#i.agecategory c.D#i.agecategory#i.cschool if L.mqnid==0&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
reg dmqnid c.D#i.agecategory#i.cschool if L.mqnid==1&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
reg dmqnid c.D#i.agecategory c.D#i.agecategory#cschool if L.mqnid==1&e4ax!=7&e4ax!=8&e4ax!=9, vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09))
eststo
esttab using mqnid_and_treat_cschool_bs_2nd.tex,  dropped  style(tex) p  replace

save pre_2nd, replace
exit
*kappa
*probit D lmqnid teen  cschool female rdtotherhh  if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& *dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. 
*predict pr 
*rename pr PZ1
*gen kappa1=.
*replace kappa1=1 if phase==2&((mqnid==1&D==1)|(mqnid==0&D==0))
*replace kappa1=(1-1/(1-PZ1))-0.5  if phase==2&(mqnid==1&D==0)
*replace kappa1=(1-(1/PZ1))-0.5 if phase==2&(mqnid==0&D==1)
*foreach  i in rdt lmqnid teen  cschool female rdtotherhh mqnid  mqnidandlmqnid  mqnidandteen  mqnidandcschool mqnidandfemale mqnidandlrdtotherhh{
*gen `i'copy=`i'
*replace `i'=`i'*kappa1
*}
*reg rdt lmqnid teen  cschool female rdtotherhh  mqnid mqnidandlmqnid  mqnidandteen  mqnidandcschool mqnidandfemale mqnidandlrdtotherhh, *vce(bootstrap, seed(1) cluster(migrap) idcluster(newid) group(miid09) reps(500))
*foreach  i in rdt lmqnid teen  cschool female rdtotherhh  mqnidandlmqnid  mqnidandteen  mqnidandcschool mqnidandfemale mqnidandlrdtotherhh{
*replace `i'=`i'copy
*drop `i'copy
}


eststo clear
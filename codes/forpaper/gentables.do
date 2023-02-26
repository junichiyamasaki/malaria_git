
* *****
* *forpaper
use data/intermediate/forpaper/foranalysis,clear

estpost tab r4 e2a if e3==1&phase==2&r4<20&(e2a>=1&e2a<=5), nototal
esttab using draft/ageandclass_2nd, cell(b) collabels(freq.) eqlabel(,lhs(age)) tex unstack  noobs nonumber addnotes(We used those who are student at the 2nd phase.) replace


tab phase, gen(phase_)

gen cons=1
gen logHHincome6_0=log(HHincome6_0)
egen rdthh=mean(rdt),by(phase mhid09)
gen rdthh_1st=rdthh
replace rdthh_1st=L.rdthh if phase==2
replace rdthh_1st=L2.rdthh if phase==3


egen rdtvillage=mean(rdt),by(phase migrap)
gen rdtvillage_1st=rdtvillage
replace rdtvillage_1st=L.rdtvillage if phase==2
replace rdtvillage_1st=L2.rdtvillage if phase==3

gen rdt_1st=rdt
replace rdt_1st=L.rdt if phase==2
replace rdt_1st=L2.rdt if phase==3

label define G 0 "Control" 1 "Treatment"
label value G G
gen dD=D
gen dDandunderteen=dD*underteen
gen dDandteen=dD*teen
replace D=1 if phase==3
foreach n in 2 3{
gen phase`n'=(phase==`n')
gen D_phase`n'=D*phase`n'
gen mqnid_phase`n'=mqnid*phase`n'
gen dmqnid_phase`n'=dmqnid*phase`n'
gen Dandunderteen_phase`n'=Dandunderteen*phase`n'
gen Dandteen_phase`n'=Dandteen*phase`n'
gen dD_phase`n'=dD*phase`n'
gen dDandunderteen_phase`n'=dDandunderteen*phase`n'
gen dDandteen_phase`n'=dDandteen*phase`n'
gen underteen_phase`n'=underteen*phase`n'
gen teen_phase`n'=teen*phase`n'
}

gen know = 0  
replace know = 1 if h17dxx== 2 & phase==3

replace know = F.know if  phase == 2
replace know = F.know if  phase == 1

gen nmqnid = 0
replace nmqnid = 1 if mqnid ==0

gen nmqnhh2=hhsize-mqnhh
gen nmqnhhprop=(hhsize-mqnhh-outsidehh)/(hhsize-outsidehh)
gen nmqnhhprop2=hhsize-mqnhh/(hhsize)

gen nmqnothhh=hhsize - 1  - mqnhh + mqnid -outsidehh + outside
gen nmqnothhh2=hhsize -1 -mqnhh + nmqnid
gen nmqnothhhprop=(hhsize- nmqnid -outside-mqnhh-outsidehh)/(hhsize- 1 +outside-outsidehh)
gen nmqnothhhprop2=(hhsize-mqnhh- nmqnid)/(hhsize - 1)

gen nmqnothhhprop3=(hhsize-mqnhh-outsidehh)/(hhsize -outsidehh)
gen nmqnothhhprop3_temp = nmqnothhhprop3 if phase==1
egen nmqnothhhprop31st = max(nmqnothhhprop3),by(mhid09)



gen mqnid1st=mqnid if phase==1
replace mqnid1st=L.mqnid if phase==2
replace mqnid1st=L.mqnid if phase==3

gen nofnet1st=nofnet if phase==1
replace nofnet1st=L.nofnet if phase==2
replace nofnet1st=L.nofnet if phase==3

gen hhsize1st=hhsize if phase==1
replace hhsize1st=L.hhsize if phase==2
replace hhsize1st=L.hhsize if phase==3

gen nofnetper1st = nofnet1st/hhsize1st

gen nofnetper1st_20 = nofnetper1st<0.20
gen nofnetper1st_2050 = nofnetper1st>=0.20&nofnetper1st<0.5
gen nofnetper1st_50 = nofnetper1st>=0.5

foreach var of varlist nofnetper1st_*{
	gen D_`var' = D*`var'
}

foreach var of varlist nofnetper1st_*{
	foreach i of numlist 1/3{
	gen `var'_phase_`i' = `var'*phase_`i'
}
}

foreach var of varlist nofnetper1st{
	gen D_`var' = D*`var'
}

foreach var of varlist nofnetper1st{
	foreach i of numlist 1/3{
	gen `var'_phase_`i' = `var'*phase_`i'
}
}



gen mqnid2nd=mqnid if phase==2
replace mqnid2nd=F.mqnid if phase==1
replace mqnid2nd=L.mqnid if phase==3


gen mqnid3rd=mqnid if phase==3
replace mqnid3rd=F.mqnid if phase==2
replace mqnid3rd=F2.mqnid if phase==1


gen Dandmqnid1st = D*mqnid1st
gen Gandmqnid1st = G*mqnid1st

gen child = 0
replace child =1 if age60 <=19
gen mqnidchild=0
replace mqnidchild=1 if mqnid==1&age60<=19

gen outsidechild=0
replace outsidechild=1 if outside==1&age60<=19

egen mqnhhchild = total(mqnidchild), by(mhid09 phase)
egen hhsizechild= total(child), by(mhid09 phase)
egen outsidechildhh= total(outsidechild), by(mhid09 phase)
gen nmqnhhchild = hhsizechild - mqnhhchild
gen nmqnhhchild2 = hhsizechild - mqnhhchild - outsidechildhh
gen nmqnhhchildprop = (hhsizechild - mqnhhchild) /  hhsizechild
gen nmqnhhchildprop2 = (hhsizechild - outsidechildhh - mqnhhchild) /  (hhsizechild - outsidechildhh)


gen nmqnothhhchild = hhsizechild - child - mqnhhchild + mqnidchild
gen nmqnothhhchild2 = hhsizechild - child - mqnhhchild + mqnidchild - outsidechildhh  + outsidechild
gen nmqnothhhchildprop = (hhsizechild - child - mqnhhchild + mqnidchild) /  (hhsizechild - child)
gen nmqnothhhchildprop2 = (hhsizechild - child - mqnhhchild + mqnidchild - outsidechildhh  + outsidechild) /  (hhsizechild - child - outsidechildhh + outsidechild)

egen vilrdt = mean(rdt),by(migrap phase)
gen vilrdttemp = vilrdt if phase==1
egen vilrdtfirst = max(vilrdttemp),by(migrap)


gen absence2temp = absence2 if phase==1
egen absence2first = max(absence2temp),by(miid09)


gen highrdtfirst = vilrdtfirst> 0.085
gen mosquitocite = migrap==3|migrap==4|migrap==5|migrap==9|migrap==12|migrap==13|migrap==16|migrap==18
gen enroll = e3
replace enroll = 0 if e3==2
replace enroll = 0 if e1!=1

gen enrolltemp = enroll if phase==1
egen enrollfirst = max(enrolltemp),by(miid09)

egen vilbite = mean(bite),by(migrap phase)

gen vilbitetemp = vilbite if phase==1
egen vilbitefirst = max(vilbitetemp),by(miid09)

foreach phase in 1 2 3{
gen vilbitefirst_phase_`phase' = vilbitefirst*phase_`phase'
}

foreach phase in 1 2 3{
gen enrollfirst_phase_`phase' = enrollfirst*phase_`phase'
}

foreach phase in 1 2 3{
gen highrdtfirst_phase_`phase' = highrdtfirst*phase_`phase'
}
foreach phase in 1 2 3{
gen vilrdtfirst_phase_`phase' = vilrdtfirst*phase_`phase'
}
egen vilmqnid = mean(mqnid),by(migrap phase)
gen vilmqnidtemp = vilmqnid if phase==1
egen vilmqnidfirst = max(vilmqnidtemp),by(migrap)
foreach phase in 1 2 3{
gen vilmqnidfirst_phase_`phase' = vilmqnidfirst*phase_`phase'
}
egen vilabsence = mean(absence2),by(migrap phase)
gen vilabsencetemp = vilabsence if phase==1
egen vilabsencefirst = max(vilabsencetemp),by(migrap)
foreach phase in 1 2 3{
gen vilabsencefirst_phase_`phase' = vilabsencefirst*phase_`phase'
}
egen vilenroll = mean(enroll),by(migrap phase)
gen vilenrolltemp = vilenroll if phase==1
egen vilenrollfirst = max(vilenrolltemp),by(migrap)
foreach phase in 1 2 3{
gen vilenrollfirst_phase_`phase' = vilenrollfirst*phase_`phase'
}

egen hhtotal=total(cons) , by (mhid09 phase) 

gen rdthhshare = rdthhtotal/hhtotal
gen rdthhshare1sttemp = rdthhshare if phase==1
egen rdthhshare1st = max(rdthhshare1sttemp),by(mhid09)

foreach phase in 1 2 3{
gen rdthhshare1st_phase_`phase' = rdthhshare1st*phase_`phase'
}

foreach phase in 1 2 3{
gen nmqnothhhprop31st_phase_`phase' = nmqnothhhprop31st*phase_`phase'
}

gen  Dandnmqnothhhprop31st = D*nmqnothhhprop31st

gen  Dandrdthhshare1st = D*rdthhshare1st

gen dabsence6 = D.absence6
gen dabsence62 = D.absence62

foreach type in "" child{
foreach n in "" 2 {
gen nmqnothhh`type'`n'1st=nmqnothhh`type'`n' if phase==1
replace nmqnothhh`type'`n'1st=L.nmqnothhh`type'`n' if phase==2
replace nmqnothhh`type'`n'1st=L2.nmqnothhh`type'`n' if phase==3

gen Dandnmqnothhh`type'`n'1st = D*nmqnothhh`type'`n'1st
gen Gandnmqnothhh`type'`n'1st = G*nmqnothhh`type'`n'1st

gen nmqnothhh`type'prop`n'1st=nmqnothhh`type'prop`n' if phase==1
replace nmqnothhh`type'prop`n'1st=L.nmqnothhh`type'prop`n' if phase==2
replace nmqnothhh`type'prop`n'1st=L2.nmqnothhh`type'prop`n' if phase==3

gen Dandnmqnothhh`type'prop`n'1st = D*nmqnothhh`type'prop`n'1st
gen Gandnmqnothhh`type'prop`n'1st = G*nmqnothhh`type'prop`n'1st
}
}

gen  abook = 1  if e4c=="EPP AMBALAHASINA"|e4c=="EPP AMBODIBONARA"|e4c=="EPP MAHATSARA I"|e4c=="EPP MAROFARIHY"|e4c=="EPP NAMAHOAKA"|e4c=="EPP SALAFAINA"
egen abookall = max(abook==1),by(miid09)

gen dDandnmqnothhh1st = D.Dandnmqnothhh1st



foreach phase in 1 2 3 {
gen nmqnothhh1st_phase_`phase' = nmqnothhh1st*phase_`phase'
}


label var D_phase3 "Distributed * 3rd Wave"
label var phase3 "3rd Wave"
label var Dandunderteen_phase3 "D * 6--12 Years Old * 3rd Wave"
label var Dandteen_phase3 "D * 13--19 Years Old * 3rd Wave"
label var dmqnid "$\Delta$ Using a Net"
label var dmqnid_phase3 "$\Delta$ Using a Net * 3rd Wave"
label var dD "Distribution"
label var dD_phase3 "Distribution * 3rd Wave"
label var dDandunderteen "Distribution * 6--12 Years Old"
label var dDandteen "Distribution * 13--19 Years Old"
label var dDandunderteen_phase3 "$\Delta$  * 6--12 Years Old * 3rd Wave"
label var dDandteen_phase3 "$\Delta$  * 13--19 Years Old * 3rd Wave"
label var phase3 "3rd Wave"
label var underteen_phase3 "6--12 Years Old * 3rd Wave"
label var teen_phase3 "13--19 Years Old * 3rd Wave"
label var flr14x 
label var G Treatment 
label var nmqnothhh1st "Other Non-User in the HH at the 1st"
label var dDandnmqnothhh1st "Distribution * Other Non-User in the HH at the 1st"
label var dabsence6 "$\Delta$ Absence 6 Months"
label var dabsence62 "$\Delta$ Sick Absence 6 Months"
label var vilrdtfirst "Village Level Infection in the 1st"
label var vilabsencefirst "Village Level Sick Absence in the 1st"


gen alt = mhalt if mhalt!=.

foreach phase of numlist 1/3{
	gen alt_phase_`phase' = alt * phase_`phase'
}
gen labsence62 = L.absence62
gen mqnidpattern = .
replace mqnidpattern =1 if mqnid==1&L.mqnid==0
replace mqnidpattern =2 if mqnid==1&L.mqnid==1
replace mqnidpattern =3 if mqnid==0&L.mqnid==0
replace mqnidpattern =4 if mqnid==0&L.mqnid==1
label define mqnidpattern 1 "NO USE -> USE" 2"USE -> USE" 3"NO USE -> NO USE" 4 "USE -> NO USE"
label value mqnidpattern mqnidpattern

gen llitnidpattern = .
replace llitnidpattern =1 if llitnid==1&L.llitnid==0
replace llitnidpattern =2 if llitnid==1&L.llitnid==1
replace llitnidpattern =3 if llitnid==0&L.llitnid==0
replace llitnidpattern =4 if llitnid==0&L.llitnid==1

label value  llitnidpattern mqnidpattern

gen miid09head = miid09 if underteen==0 & r3==1
egen minidhh = min(miid09head),by(mhid09 phase)
gen mqnid_base = mqnid if minidhh==miid09
gen rdt_base = rdt if minidhh==miid09
egen mqnid_base2 = min(mqnid_base),by(mhid09 phase)
egen rdt_base2 = min(rdt_base),by(mhid09 phase)

gen mqnid_hhdiff = mqnid - mqnid_base2 if minidhh!=miid09
gen rdt_hhdiff = rdt - rdt_base2 if minidhh!=miid09

gen labsence = L.absence


gen nwithsleepother = nwithsleep-1
replace nwithparent = F.nwithparent if phase==2
replace nwithparent = F2.nwithparent if phase==1
gen floorunderteen = floor*underteen
gen nwithsleepotherunderteen = nwithsleepother*underteen

gen nwithparentunderteen = nwithparent*underteen



* label var floor "Sleep On Floor"
* label var floorunderteen "Sleep On Floor * 6--12 Years Old"
* label var nwithsleepotherunderteen "No.of Household Members Sleep With * 6--12 Years Old"
* label var nwithsleepother "No.of Household Members Sleep With"
* label var nwithparentunderteen "No.of Parents Sleep With * 6--12 Years Old"
* label var nwithparent "No.of Parents Sleep With"
* **After a meeting with Ichimura sensei

graph twoway lpolyci rdt age60 if phase==1|| lpolyci mqnid age60 if phase==1,legend(label(2 "Malaria Infection (RDT +)") label(3 "Sleep under a Net")) xtitle("Age (topcoded at 60)")
graph export  "draft/dips.pdf",replace

eststo clear
eststo: ivreg2 mqnid underteen  if floor!=.&nwithsleepother!=.&phase==1,cluster(migrap) small
eststo: ivreg2 mqnid underteen  floor if floor!=.&nwithsleepother!=.&phase==1,cluster(migrap) small
eststo: ivreg2 mqnid underteen  nwithparent if floor!=.&nwithparent!=.&phase==1,cluster(migrap) small
eststo: ivreg2 mqnid underteen floor nwithparent if floor!=.&nwithparent!=.&phase==1,cluster(migrap) small
eststo: ivreg2 mqnid underteen floor floorunderteen nwithparent nwithparentunderteen if nwithsleep!=.&phase==1,cluster(migrap) small

* eststo: ivreg2 mqnid underteen floor floorunderteen nwithsleepother nwithsleepotherunderteen if nwithsleep!=.&phase==1,cluster(migrap) small
* eststo: ivreg2 mqnid underteen floor floorunderteen nwithsleepother nwithsleepotherunderteen if nwithsleep!=.&phase==1&r3==3&age60<=20,cluster(migrap) small
* eststo: ivreg2 mqnid underteen floor  nwithparent  if nwithsleep!=.&phase==1&r3==3&age60<=20,cluster(migrap) small
* eststo: ivreg2 mqnid underteen floor floorunderteen nwithparent nwithparentunderteen if nwithsleep!=.&phase==1&r3==3&age60<=20,cluster(migrap) small

esttab using "draft/floornetusing.csv", csv se label addnote("Cluster robust SEs (village level). " ) replace  star(+ .10 * .05  ** .01 *** .001) 
esttab using "draft/floornetusing.tex", tex se label addnote("Cluster robust SEs (village level). " ) replace  star(+ .10 * .05  ** .01 *** .001) 



eststo clear
ivreg2 rdt (mqnid = G)  if phase==2&underteen==1,cluster(migrap) small
eststo
test mqnid
estadd scalar p = r(p)
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


ivreg2 rdt_hhdiff (mqnid_hhdiff = G )  if phase==2&underteen==1,cluster(migrap) small 
eststo
test mqnid
estadd scalar p = r(p)
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


ivreg2 rdt_hhdiff (mqnid_hhdiff = G cons)  if phase==2&underteen==1,cluster(migrap) small nocons
eststo
test mqnid
estadd scalar p = r(p)
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

ivreg2 rdt (mqnid = G) highrdtfirst if phase==2&underteen==1,cluster(migrap) small
eststo
test mqnid
estadd scalar p = r(p)
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

ivreg2 rdt_hhdiff (mqnid_hhdiff = G) highrdtfirst if phase==2&underteen==1,cluster(migrap) small 
eststo
test mqnid
estadd scalar p = r(p)
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


ivreg2 rdt_hhdiff (mqnid_hhdiff = G cons) highrdtfirst if phase==2&underteen==1,cluster(migrap) small nocons
eststo
test mqnid
estadd scalar p = r(p)
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


* esttab using "draft/externality_withinhh", csv se label scalar("bootp Wild Bootstrap p-value " ) addnote("Cluster robust SEs (village level). We used only 6--12 aged people. " ) replace  star(+ .10 * .05  ** .01 *** .001) 
esttab using "draft/externality_withinhh.tex", se label scalar("bootp Wild Bootstrap p-value " ) addnote("Cluster robust SEs (village level). We used only 6--12 aged people. " ) replace  star(+ .10 * .05  ** .01 *** .001) 


eststo clear

xtivreg2 rdt D  Dandnmqnothhhprop31st phase_* nmqnothhhprop31st_phase* if underteen==1, fe small cluster(migrap)
eststo
xtivreg2 rdt D  Dandnmqnothhhprop31st phase_* nmqnothhhprop31st_phase* highrdtfirst_phase_* if underteen==1, fe small cluster(migrap)
eststo
xtivreg2 rdt D  Dandrdthhshare1st phase_* rdthhshare1st_phase* if underteen==1, fe small cluster(migrap)
eststo
xtivreg2 rdt D  Dandrdthhshare1st phase_* rdthhshare1st_phase* highrdtfirst_phase_* if underteen==1, fe small cluster(migrap)
eststo
esttab using draft/externality_child, tex drop(o.*  _cons,relax) indicate( "Individual FE and Wave FE =  phase*" "Pre High Malaria Risk Village * Wave FE= highrdtfirst_phase_*" "Pre HH level Infection or Usage Rate * Wave FE= rdthhshare1st*  nmqnothhhprop31st*"  )   se label addnote("Cluster robust SEs (village level). We used only 6--19 aged people. " ) replace  star(+ .10 * .05  ** .01 *** .001) mgroups("$\Delta $ RDT +", pattern(1 0 0 0 )  span prefix(\multicolumn{@span}{c}{) suffix(}) )




eststo clear
* xtivreg2 absence6 D phase_*  if phase>=2&underteen==1,fe cluster(migrap) small
* eststo
* test D
* estadd scalar t =  `r(F)'^(1/2) 
* boottest D,cluster(migrap) small noci seed(12345678)
* estadd scalar boott =  abs(`r(t)') 
* xtivreg2 absence6 D vilabsencefirst_phase_* phase_* if phase>=2&underteen==1,fe cluster(migrap) small
* eststo
* test D
* estadd scalar t =  `r(F)'^(1/2) 
* boottest D,cluster(migrap) small noci seed(12345678)
* estadd scalar boott =  abs(`r(t)') 
* xtivreg2 absence6 D vilabsencefirst_phase_* phase_* highrdtfirst_phase_* if phase>=2&underteen==1,fe cluster(migrap) small
* eststo
* test D
* estadd scalar t =  `r(F)'^(1/2) 
* boottest D,cluster(migrap) small noci seed(12345678)
* estadd scalar boott =  abs(`r(t)') 
xtivreg2 absence62 D phase_*  if phase>=2&underteen==1,fe cluster(migrap) small
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

xtivreg2 absence62 D vilabsencefirst_phase_* phase_*  if phase>=2&underteen==1,fe cluster(migrap) small
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

xtivreg2 absence62 D vilabsencefirst_phase_* phase_*  highrdtfirst_phase_* if phase>=2&underteen==1,fe cluster(migrap) small
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

esttab using draft/absence3rd_questionnaire_child, tex cells(b(fmt(a3) star) se(par fmt(a3)) ci(fmt(a3))) label scalar("bootCI_H Wild Bootstrap 95% CI" "bootCI_L Wild Bootstrap 95% CI ") drop(o.*  _cons,relax) indicate( "Individual FE and Wave FE =  phase*" "Pre Village-level Absence * Wave FE= vilabsencefirst*"  "Pre High Malaria Risk Village = highrdtfirst*")   addnote("Cluster robust SEs (village level)." "Estimation is done by OLS using 2nd and 3rd phase.")  replace  star(+ .10 * .05  ** .01 *** .001) 


eststo clear
xtivreg2 absence62 D phase_*  if phase>=2&underteen==1,fe cluster(migrap) small
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

xtivreg2 absence62 D vilabsencefirst_phase_* phase_* highrdtfirst_phase_* vilmqnidfirst_phase_* if phase>=2&underteen==1,fe cluster(migrap) small
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

xtivreg2 absence62 D vilabsencefirst_phase_* phase_* highrdtfirst_phase_* vilmqnidfirst_phase_* alt_phase_* if phase>=2&underteen==1,fe cluster(migrap) small
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

xtivreg2 absence6 D phase_*  if phase>=2&underteen==1,fe cluster(migrap) small
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

xtivreg2 absence6 D vilabsencefirst_phase_* phase_* highrdtfirst_phase_* vilmqnidfirst_phase_* if phase>=2&underteen==1,fe cluster(migrap) small
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

xtivreg2 absence6 D vilabsencefirst_phase_* phase_* highrdtfirst_phase_* vilmqnidfirst_phase_* alt_phase_* if phase>=2&underteen==1,fe cluster(migrap) small
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

esttab using draft/absence3rd_questionnaire_child_app.tex, cells(b(fmt(a3) star) se(fmt(a3))  p(fmt(3)))   scalar("bootp Wild Bootstrap p-value " )  sfmt(3) indicate( "Individual FE and Wave FE =  phase*" "Pre Village-level Absence * Wave FE= vilabsencefirst*"  "Pre High Malaria Risk Village = highrdtfirst*")   addnote("Cluster robust SEs (village level)." "Estimation is done by OLS using 2nd and 3rd phase.")  replace  star(+ .10 * .05  ** .01 *** .001) 


* eststo clear

xtivreg2 enroll D phase_*  if underteen==1,fe cluster(migrap) small
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

xtivreg2 enroll D vilenrollfirst_phase_* phase_*  if underteen==1,fe cluster(migrap) small
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

xtivreg2 enroll D vilenrollfirst_phase_* phase_*  highrdtfirst_phase_* if underteen==1,fe cluster(migrap) small
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

esttab using draft/absence3rd_questionnaire_child2.tex,cells(b(fmt(a3) star) se(fmt(a3))  p(fmt(3)))   scalar("bootp Wild Bootstrap p-value " )  sfmt(3) drop(o.*  _cons,relax) indicate( "Individual FE and Wave FE =  phase*" "Pre Village-level Absence * Wave FE= vilabsencefirst*"  "Pre High Malaria Risk Village = highrdtfirst*")   addnote("Cluster robust SEs (village level)." "Estimation is done by OLS using 2nd and 3rd phase.")  replace  star(+ .10 * .05  ** .01 *** .001)



eststo clear
ivreg2  rdt (mqnid=D)if phase==2&underteen==1, small cluster(migrap)
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

ivreg2  rdt (mqnid=D) highrdtfirst if phase==2&underteen==1, small cluster(migrap)
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

ivreg2  rdt (mqnid=D) vilrdtfirst highrdtfirst if phase==2&underteen==1, small cluster(migrap)
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

xtivreg2  rdt (mqnid=D) phase_* if underteen==1, small cluster(migrap) fe
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

xtivreg2  rdt (mqnid=D) phase_* highrdtfirst_phase_* if underteen==1, small cluster(migrap) fe
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

xtivreg2  rdt (mqnid=D) phase_* vilrdtfirst_phase_* highrdtfirst_phase_* if underteen==1, small cluster(migrap) fe
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

esttab using draft/laterdt_child.tex, cells(b(fmt(a3) star) se(fmt(a3))  p(fmt(3)))   scalar("bootp Wild Bootstrap p-value " )  sfmt(3) drop(o.*  _cons,relax) indicate( "Individual FE and Wave FE =  phase*" "Pre Village-level Infection Rate * Wave FE= vilrdtfirst*" "Pre High Malaria Risk Village = highrdtfirst_phase_*")  addnote("Cluster robust SEs (village level). Column 3 and 4 use seaside samples." "Estimation is by 2sls, using distribution as a instrument.") replace  star(+ .10 * .05  ** .01 *** .001)  mgroups("RDT +", pattern(1 0 0 0 ) span prefix(\multicolumn{@span}{c}{) suffix(}) )


eststo clear
ivreg2  rdt (mqnid=D)if phase==2&underteen==1, small cluster(migrap)
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


ivreg2  rdt (mqnid=D) highrdtfirst vilabsencefirst_phase_* vilmqnidfirst_phase_* alt_phase_* if phase==2&underteen==1, small cluster(migrap)
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


ivreg2  rdt (mqnid=D) vilrdtfirst highrdtfirst vilabsencefirst_phase_* vilmqnidfirst_phase_* alt_phase_* if phase==2&underteen==1, small cluster(migrap)
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


xtivreg2  rdt (mqnid=D) phase_* if underteen==1, small cluster(migrap) fe
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


xtivreg2  rdt (mqnid=D) phase_* vilrdtfirst_phase_* vilabsencefirst_phase_* vilmqnidfirst_phase_* alt_phase_* if underteen==1, small cluster(migrap) fe
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


xtivreg2  rdt (mqnid=D) phase_* vilrdtfirst_phase_* highrdtfirst_phase_* vilabsencefirst_phase_* vilmqnidfirst_phase_* alt_phase_* if underteen==1, small cluster(migrap) fe
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


esttab using draft/laterdt_child_app.tex,cells(b(fmt(a3) star) se(fmt(a3))  p(fmt(3)))   scalar("bootp Wild Bootstrap p-value " )  sfmt(3) label drop(o.*  _cons,relax) indicate( "Individual FE and Wave FE =  phase*" "Pre Village-level Infection Rate * Wave FE= vilrdtfirst*" "Pre High Malaria Risk Village = highrdtfirst_phase_*")  addnote("Cluster robust SEs (village level). Column 3 and 4 use seaside samples." "Estimation is by 2sls, using distribution as a instrument.") replace  star(+ .10 * .05  ** .01 *** .001)  mgroups("RDT +", pattern(1 0 0 0 ) span prefix(\multicolumn{@span}{c}{) suffix(}) )



eststo clear

xtivreg2  mqnid D phase_* if phase<=3,small cluster(migrap) fe
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

xtivreg2  mqnid D phase_* vilmqnidfirst_phase_* if phase<=3,small cluster(migrap) fe
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


xtivreg2  mqnid D phase_* if phase<=3&underteen==1,small cluster(migrap) fe
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


xtivreg2  mqnid D phase_* vilmqnidfirst_phase_* if phase<=3&underteen==1,small cluster(migrap) fe
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


esttab using draft/mqnidd3rd_child.tex,  drop(o.*  _cons,relax)  cells(b(fmt(a3) star) se(fmt(a3))  p(fmt(a3)))   scalar("bootp Wild Bootstrap p-value " )  sfmt(3) indicate( "Individual FE and Wave FE =  phase*" "Pre Village-level Net Usage Rate * Wave FE= vilmqnidfirst*" ) tex se label addnote("Cluster robust SEs (village level). Column 1 uses only the 2nd Wave.") replace star(+ .10 * .05  ** .01 *** .001) 


eststo clear

xtivreg2  mqnid D phase_* if phase<=3,small cluster(migrap) fe
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)
xtivreg2  mqnid D phase_* vilmqnidfirst_phase_* highrdtfirst_phase_* alt_phase_* vilabsencefirst_phase_* if phase<=3,small cluster(migrap) fe
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)
xtivreg2  mqnid D phase_* if underteen==1,small cluster(migrap) fe
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)
xtivreg2  mqnid D phase_* vilmqnidfirst_phase_* highrdtfirst_phase_* alt_phase_* vilabsencefirst_phase_* if underteen==1&phase<=3,small cluster(migrap) fe
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)
esttab using draft/mqnidd3rd_child_app.tex, drop(o.*  _cons,relax) cells(b(fmt(a3) star) se(fmt(a3))  p(fmt(3)))   scalar("bootp Wild Bootstrap p-value " )  sfmt(3) indicate( "Individual FE and Wave FE =  phase*" "Pre Village-level Net Usage Rate * Wave FE= vilmqnidfirst*" ) tex se label addnote("Cluster robust SEs (village level). Column 1 uses only the 2nd Wave.") replace star(+ .10 * .05  ** .01 *** .001) 


eststo clear

xtivreg2  mqnid D phase_* if nofnetper1st>0.5&nofnetper1st!=.&phase<=3,small cluster(migrap) fe
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

xtivreg2  mqnid D phase_* vilmqnidfirst_phase_* if nofnetper1st>0.5&nofnetper1st!=.&phase<=3,small cluster(migrap) fe
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


xtivreg2  mqnid D phase_* if nofnetper1st>0.5&nofnetper1st!=.&phase<=3&underteen==1,small cluster(migrap) fe
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


xtivreg2  mqnid D phase_* vilmqnidfirst_phase_* if nofnetper1st>0.5&nofnetper1st!=.&phase<=3&underteen==1,small cluster(migrap) fe
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)
esttab using "draft/mqnidd3rd_child_panelB.tex",  drop(o.*  _cons,relax)  cells(b(fmt(a3) star) se(fmt(a3))  p(fmt(a3)))   scalar("bootp Wild Bootstrap p-value " )  sfmt(3) indicate( "Individual FE and Wave FE =  phase*" "Pre Village-level Net Usage Rate * Wave FE= vilmqnidfirst*" ) tex se label addnote("Cluster robust SEs (village level). Column 1 uses only the 2nd Wave.") replace star(+ .10 * .05  ** .01 *** .001) 



eststo clear

eststo clear
xtivreg2  rdt D phase_* if age60>=20&age60!=.,small cluster(migrap) fe
eststo
xtivreg2  rdt D phase_* vilrdtfirst_phase_* if age60>=20&age60!=.,small cluster(migrap) fe
eststo
tempfile origin
save `origin',replace
 
duplicates drop  phase mhid09 migrap G HHincome6_0,force
collapse (sum) HHincome6_0 (max) D phase_*,by(phase mhid09 migrap G)

xtset mhid09 phase

gen logHHincome6_0 = log(HHincome6_0)
gen logHHincome6_0at1sttemp = logHHincome6_0 if phase==1
egen logHHincome6_0at1st = max(logHHincome6_0at1sttemp) ,by(mhid09)

foreach phase in 1 2 3{
	gen logHHincome6_0at1st_phase_`phase' = logHHincome6_0at1st*phase_`phase'
}


eststo:xtivreg2  logHHincome6_0 D phase_*  ,small fe cluster(migrap)
eststo:xtivreg2  logHHincome6_0 D phase_* logHHincome6_0at1st_phase_* ,small fe cluster(migrap)

use `origin',clear   


esttab using draft/adultrdt, tex drop(o.*  _cons,relax) indicate( "Individual FE and Wave FE =  phase*" "Pre Village-level Infection Rate * Wave FE= vilrdtfirst_phase_*" "Pre Household Log Income * Wave FE= logHHincome6_0at1st**" ) se label addnote("Cluster robust SEs (village level). We only use over 20 years old sample." "Column 2 uses seaside sample.") replace star(+ .10 * .05  ** .01 *** .001) 




eststo clear
ivregress 2sls absence62 (mqnid=D)if phase==2&underteen==1,small cluster(migrap)
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)

ivregress 2sls absence62 (mqnid=D) vilabsencefirst if phase==2&underteen==1,small cluster(migrap)
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


ivregress 2sls absence62 (mqnid=D) vilabsencefirst highrdtfirst if phase==2&underteen==1,small cluster(migrap)
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


xtivreg2 absence62 (mqnid=D) phase_* if phase>=2&underteen==1,small cluster(migrap) fe
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


xtivreg2 absence62 (mqnid=D) phase_*  vilabsencefirst_phase_* if phase>=2&underteen==1,small cluster(migrap) fe
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


xtivreg2 absence62 (mqnid=D) phase_*  vilabsencefirst_phase_* highrdtfirst_phase_* if phase>=2&underteen==1,small cluster(migrap) fe
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)


esttab using draft/latemqnabsence62_child.tex,  cells(b(fmt(a3) star) se(fmt(a3))  p(fmt(a3)))   scalar("bootp Wild Bootstrap p-value " )   sfmt(3) drop(o.*  _cons,relax) indicate( "Individual FE and Wave FE =  phase*" "Pre Village-level Absence * Wave FE= vilabsencefirst*" "Pre High Malaria Risk Village * Wave FE = highrdtfirst*") addnote("Cluster robust SEs (village level). Column 3 and 4 use seaside samples." "Estimation is by 2sls, using distribution as a instrument.") replace star(+ .10 * .05  ** .01 *** .001)   mgroups("Sick Absence 6 Months", pattern(1 0 0 0 ) span prefix(\multicolumn{@span}{c}{) suffix(}) )






eststo clear
*** iv vs ols
ivreg2 rdt mqnid vilrdtfirst if phase==2&underteen==1,small cluster(migrap)
eststo
ivreg2 rdt (mqnid=D) vilrdtfirst if phase==2&underteen==1,small cluster(migrap)
eststo

ivreg2 absence62 mqnid vilabsencefirst if phase==2&underteen==1,small cluster(migrap)
eststo
ivreg2  absence62 (mqnid=D) vilabsencefirst if phase==2&underteen==1,small cluster(migrap)
eststo

esttab using draft/ivandols, tex se label addnote("Cluster robust SEs (village level). " " In column 2, estimation is by 2sls, using distribution as a instrument.") replace star(+ .10 * .05  ** .01 *** .001)   mgroups("Sick Absence 6 Months [OLS]" "Sick Absence 6 Months [IV]", pattern(1 1 ) span prefix(\multicolumn{@span}{c}{) suffix(}) )

eststo clear
*** restrict sample who did not know

xtivreg2  absence62  D phase_* if underteen==1&phase>=2&know==0,fe small cluster(migrap)
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)
xtivreg2  mqnid D phase_* if underteen==1&know==0,fe small cluster(migrap)
eststo
boottest D,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)
xtivreg2  rdt (mqnid=D) phase_*  if underteen==1&know==0,fe small cluster(migrap)
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)
xtivreg2  absence62 (mqnid=D) phase_* if phase>=2&underteen==1&know==0,fe small cluster(migrap)
eststo
boottest mqnid,cluster(migrap) small seed(12345678) noci
estadd scalar bootp =  r(p)
esttab using draft/distributionknow.tex, cells(b(fmt(a3) star) se(fmt(a3))  p(fmt(3)))   scalar("bootp Wild Bootstrap p-value " )  sfmt(3) addnote("Cluster robust SEs (village level). " "In column 1, we used the 2nd - 3rd waves and in column 2, we use all the waves." "In column 3 - 4, estimation is by 2sls, using distribution as a instrument.") replace  star(+ .10 * .05  ** .01 *** .001)  


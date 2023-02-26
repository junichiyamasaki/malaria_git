use balance,clear

gen michi=0
replace michi=1 if (migrap==1|migrap==3|migrap==4|migrap==13|migrap==15|migrap==17|migrap==18)

gen h2a=h2
replace h2a=3 if h2>=3
label define h2a 1"1" 2"2" 3"3 0ver"
label var h2a h2a

replace r8=0 if r8==2

egen rdtm1=mean (rdt),by (r4)
egen rdtm2=mean (rdt),by (r4 mqnid)
egen rdtm3=mean (rdt),by (r4 mqnid michi)
egen mqnm1=mean (mqnid), by (r4)
egen mqnm2=mean (mqnid), by (r4 h2a)
egen mqnm3=mean (mqnid),by (r4 michi)
egen nwith2m=mean (nwith2)  , by (r4 )
egen bitem=mean(bite), by( r4 mqnid)
egen bitem2=mean(bite), by( r4 r2 mqnid)
egen flrm=mean(flr), by (r4 mqnid)
egen flrm2=mean(flr), by (r4 r2 mqnid)
egen rdtm4=mean (rdt), by (bite)
egen r8m=mean (r8), by (r4)

gen mqnyid=.
replace mqnyid=1 if (mqnid==1&r4<=20)
replace mqnyid=0 if (mqnid==1&r4>21)
replace mqnyid=0 if (mqnid==0)
bysort mhid: egen mqny=max(mqnyid) 
label var mqny "there is an under 20 member who did not sleep under a net"

gen mqnyid2=mqnyid
replace mqnyid2=0 if (mqnid==1&r4<=5)
bysort mhid: egen mqny2=max(mqnyid2) 
label var mqny2 "there is an age 6-20 member who did not sleep under a net"

//lowess rdt r4, ytitle(RDT positive rate) xtitle(age) gen(lowess) 
//lowess mqnid r4, ytitle(slept in a net last night) xtitle(age) gen(lowess2)
//lowess rdt r4, ytitle(slept in a net last night) xtitle(age) by(mqnid) gen(lowess3)
//lowess rdt r4, ytitle(slept in a net last night) xtitle(age) by(mqnid r2) gen(lowess4)


graph twoway bar  rdtm1 r4  if r4<=60 || lpolyci rdt r4 if r4<=60, fc(none) alc(gray) clw(thick) ytitle(RDT positive rate) xtitle(age) 
graph export rdt_by_age.wmf, replace

graph twoway bar  mqnm1 r4  if r4<=60   || lpolyci mqnid r4 if r4<=60, fc(none) alc(gray) clw(thick) ytitle(sleep in a net) xtitle(age) 
graph export mqn_by_age.wmf, replace

graph twoway bar  rdtm2 r4  if r4<=60 , by(mqnid)  || lpolyci rdt r4 if r4<=60, by(mqnid)  fc(none) alc(gray) clw(thick) ytitle(RDT positive rate) xtitle(age) 
graph export rdt_by_age_and_mqn.wmf, replace

graph twoway bar  mqnm2 r4  if r4<=60, by(h2a)  || lpolyci mqnid r4 if r4<=60, by(h2a) fc(none) alc(gray) clw(thick) 
graph export mqn_by_age_and_nofnet.wmf, replace

graph twoway bar  mqnm3 r4  if r4<=60, by(michi)  || lpolyci mqnid r4 if r4<=60, by(michi) fc(none) alc(gray) clw(thick) 
graph export mqn_by_age_and_michi.wmf, replace

graph twoway bar  bitem r4  if r4<=60, by(mqnid) || lpolyci bite r4 if r4<=60, by(mqnid) fc(none) alc(gray) clw(thick)
graph export bite_by_age_and_mqn.wmf, replace

graph twoway bar  bitem2 r4  if r4<=60, by(mqnid) || lpolyci bite r4 if r4<=60, by(mqnid r2) fc(none) alc(gray) clw(thick) 
graph export bite_by_age_and_mqn_and_sex.wmf, replace

graph twoway bar  flrm r4  if r4<=60, by(mqnid) || lpolyci flr r4 if r4<=60, by(mqnid) fc(none) alc(gray) clw(thick)
graph export flr_by_age_and_mqn.wmf, replace

graph twoway bar  flrm2 r4  if r4<=60, by(mqnid) || lpolyci flr r4 if r4<=60, by(mqnid r2) fc(none) alc(gray) clw(thick)
graph export flr_by_age_and_mqn_and_sex.wmf, replace

graph bar  rdtm4, over (bite) ytitle(mean of RDT positive rate)
graph export rdt_by_bite.wmf, replace

graph twoway bar  nwith2m r4  if r4<=60  || lpolyci nwith2 r4 if r4<=60, fc(none) alc(gray) clw(thick) ytitle(sleep in a net with some one) xtitle(age) 
graph export nwith_by_age.wmf, replace

graph twoway bar  r8m r4  if r4<=60  || lpolyci r8 r4 if r4<=60 ,fc(none) alc(gray) clw(thick) ytitle(sleep in the house) xtitle(age) 
graph export sleepinthehouse_by_age.wmf, replace


replace h16=0 if h16==2
probit h16 mqny if hl1==1  
probit h16 mqny2 if hl1==1


tab babyandparentshh mqnid if (r4<=20&r4>=4)
exit


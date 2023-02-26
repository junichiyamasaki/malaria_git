use allcheck,clear
gen mqnoutside=. 
replace mqnoutside=1 if mqnid==0
replace mqnoutside=2 if mqnid==1
replace mqnoutside=0 if outside==1
label define mqnoutside 2 "used" 1 "not used" 0 "outside"
label value mqnoutside mqnoutside
gen agegroup=.
replace agegroup=1 if age60<=5
replace agegroup=2 if age60>=6&age60<=12
replace agegroup=3 if age60>=13&age60<=19
replace agegroup=4 if age60>=20&age60!=.
replace  agegroup=. if agegroup==0
label define agegroup 1 "-5" 2 "6-12" 3 "13-19" 4 "20-"
label value agegroup agegroup
label define G 1 "South" 0 "North"
label value G G

gen absence6201=(absence62>0&absence62!=.)
replace absence6201=0 if absence62==0

gen absence201=(absence2>0&absence2!=.)
replace absence201=0 if absence2==0

label define absence01 1 "sick absence" 0 "no absence"
label value absence6201 absence201 absence01 
label var absence201 "sick absense last month (dummy)"
label var absence6201 "sick absense 6 month (dummy)"
set more off
log using des,replace
bysort agegroup phase:tab rdt mqnoutside, col  m
bysort agegroup phase:tab absence201 mqnoutside , col m
bysort agegroup phase:tab absence6201 mqnoutside , col m
bysort agegroup phase:tabulate  mqnoutside ,summarize (absence2) means standard freq 
bysort agegroup phase:tabulate  mqnoutside ,summarize (absence62) means standard freq 

bysort G agegroup phase :tab rdt mqnoutside, col   m
bysort G agegroup phase :tab absence62 mqnoutside , col  m
bysort G agegroup phase :tabulate  mqnoutside ,summarize (absence62) means standard freq 


log close 
log2html des,replace 
replace mqnshop=. if freemqn==3&phase==3
log using des3,replace
bysort agegroup phase:tab mqnshop freemqn if mqnid==1,m col
bysort agegroup phase G:tab mqnshop freemqn if mqnid==1,m col
log close 
log2html des3, replace

*WTP
gen wtp1st=h17
gen wtp2nd3rd=h17
replace wtp2nd3rd=2 if h17==2&h17ax==1
replace wtp2nd3rd=3 if h17==2&h17ax==2&h17bx==1
replace wtp2nd3rd=4 if h17==2&h17ax==2&h17bx==2
replace wtp2nd3rd=. if (h17==2&h17ax==.)|((h17==2&h17ax==2&h17bx==.))
label var wtp1st "Want to buy one more net for 3000 Ariary"
label var wtp2nd3rd "Willingness to pay for one more net"
label define wtp1st 1 "Yes" 2 "No"
label define wtp2nd3rd 1 "3000" 2 "2000" 3"1000" 4"0"
label val wtp1st wtp1st
label val wtp2nd3rd wtp2nd3rd

log using des6,replace
bysort G: tab wtp1st if r3==1,m
bysort phase G: tab wtp2nd3rd if r3==1&phase!=1,m

bysort G: tab wtp1st if r3==1&bound==1,m
bysort phase G: tab wtp2nd3rd if r3==1&phase!=1&bound==1,m
log close
log2html des6, replace

gen llitnornot=.
replace llitnornot=1 if mqnid==1
replace llitnornot=2 if llitnid==1
replace llitnornot=0 if mqnid==0
label define llitnornot 0 "No use" 1 "not LLIN" 2 "LLIN"
label val llitnornot llitnornot
label var llitnornot "LLIN or Not"
log using des8, replace
bysort G phase: tab rdt llitnornot  ,m col
log close
log2html des8, replace

log using des10, replace
bysort G phase: tab  h10 rdt ,m row
log close
log2html des10, replace


use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\3rd\e_MOUSTIQUAIRE_3rd.dta, clear
append using C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\2nd\e_MOUSTIQUAIRE_2nd.dta
append using C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\1st\e_MOUSTIQUAIRE.dta
log using des2,replace
bysort phase h5:tab h6 if h5!=.,m
tab h5yy if phase==3,m
bysort phase h5yy:tab h6 if h5yy==1|h5yy==2,m
log close 
log2html des2, replace


gen G=.
replace G=0 if mq1==50
replace G=1 if mq1==170

label define G 1 "South" 0 "North"
label value G G

gen use=0
replace use=1 if h71!=.|h72!=.|h73!=.|h74!=.|h75!=.

label define use 1 "someone use" 0 "no one use"
label value use use
gen h5f=h5
replace h5f=h5yy if phase==3
label val h5f h5yy 
log using des4,replace
bysort phase:tab h6 h5f,m col
bysort phase G:tab h6 h5f,m col
bysort phase use:tab h6 h5f,m col
bysort phase G use:tab h6 h5f,m col
log close 
log2html des4, replace

log using des5, replace
bysort phase G: tab h10 h5f, m col
log close
log2html des5, replace

replace h6=. if h6==0
log using des7, replace
bysort phase G h5f: tab h6 h10,m col 
log close
log2html des7, replace



log using des9, replace
bysort phase G: tab h10 h4 if h71!=.,m col
log close
log2html des9, replace

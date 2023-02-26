use e_panel_2nd,clear

* age60
gen age60=r4
replace age60=60 if r4>=60&r4<=98
label define age60  0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 11 11 12 12 13 13 14 14 15 15 16 16 17 17 18 18 19 19 20 20 21 21 22 22 23 23 24 24 25 25 26 26 27 27 28 28 29 29 30 30 31 31 32 32 33 33 34 34 35 35 36 36 37 37 38 38 39 39 40 40 41 41 42 42 43 43 44 44 45 45 46 46 47 47 48 48 49 49 50 50 51 51 52 52 53 53 54 54 55 55 56 56 57 57 58 58 59 59 60 "over 60"
label value age60 age60

*’Ç¯’Îð’¤Èrdt’¡¢’²ã’Ä¢’¤Ê’¤É’¤Î’´Ø’·¸
graph bar mqnid , over(age60, label(labsize(tiny) angle(vertical) alternate) ) by(d phase) 
graph export age60_and_mosquitonet_2nd.ps,replace
graph bar mqnid if r8==1, over(age60, label(labsize(tiny) angle(vertical) alternate) ) by(d phase)  
graph export age60_and_mosquitonet_ifslept_2nd.ps,replace
graph bar rdt, over(age60, label(labsize(tiny) angle(vertical) alternate) ) by(d phase) 
graph export age60_and_rdt_2nd.ps,replace

*’ÇË’¤ì’¤Æ’¤¤’¤ë’²ã’Ä¢’¤½’¤¦’¤Ç’¤Ê’¤¤’²ã’Ä¢’¤Çrdt’¤Ë’ÂÐ’¤¹’¤ë’±Æ’¶Á?
probit rdt mqnid ntmqnid if phase==1, robust 
outreg2 using torn_and_rdt_2nd.tex,replace ctitle(rdt(1st)) tex(frag) 
probit rdt mqnid ntmqnid i.migrap if phase==1, robust 
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(1st)) tex(frag)

probit rdt mqnid ntmqnid if phase==2, robust 
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(2nd)) tex(frag)
probit rdt mqnid ntmqnid i.migrap if phase==2, robust 
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(2nd)) tex(frag)



*’·ç’ÀÊ’Æü’¿ô
gen absence=e6
replace absence=0 if e5==2
outreg2 using absence_2nd.tex, replace ctitle(delta_absence) tex(frag):reg D.absence d L.absence, robust
outreg2 using absence_2nd.tex, append ctitle(delta_absence) tex(frag):reg D.absence d, robust


*’¥Í’¥Ã’¥È’¤Î’Ëç’¿ô
gen nofnet=h2
replace nofnet=0 if h1==2

*’ÇÛ’¤é’¤ì’¤¿’¥Í’¥Ã’¥È’¤Î’Ëç’¿ô’¤Ï’¡©
label define hhsize 0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 11 11 12 12 13 13 14 14 15 15 16 16 17 17
label value hhsize hhsize
latab campnet d if d==1
latab campnet hhsize if d==1

gen hhsize3=.
replace hhsize3=1 if hhsize>=1
replace hhsize3=2 if hhsize>=4
replace hhsize3=3 if hhsize>=7
replace hhsize3=4 if hhsize>=10
replace hhsize3=5 if hhsize>=13
replace hhsize3=6 if hhsize>=16&hhsize<99

gen hhsize3_lnofnet=hhsize3*L.nofnet
tobit campnet hhsize3 L.nofnet hhsize3_lnofnet i.migrap if d==1, ll(0)
outreg2 using distribution_2nd.tex,replace ctitle(# of distributed nets) tex(frag)
 
*’ÇË’¤ì’¤¿’²ã’Ä¢’¤Î’Ëç’¿ô
label value noftorned nofnet campnet 
latab noftorned nofnet if phase==1&hl1==1
*’ÇË’¤ì’¤Æ’¤¤’¤Ê’¤¤’²ã’Ä¢’¤Î’Ëç’¿ô
gen nofnottorned=nofnet-noftorned


*’¼Î’¤Æ’¤ë’¤«’¤É’¤¦’¤«
latab h15 if hl1==1 &phase==2

*’²È’·×’¥ì’¥Ù’¥ë’¤Ç’¤Î’½ê’ÆÀ’¤Î’ÊÑ’²½
gen D_HH_salary_May10=HH_salary_May10-HH_salary_Dec09
gen D_HH_self_May10=HH_self_May10-HH_self_Dec09

reg D_HH_salary_May10 d HH_salary_Dec09 i.migrap if hl1==1
outreg2 using income_2nd.tex,replace ctitle(Salary change) tex(frag)
reg D_HH_salary_May10 d i.migrap if hl1==1
outreg2 using income_2nd.tex,append ctitle(Salary change) tex(frag)

reg D_HH_self_May10 d HH_self_Dec09 i.migrap if hl1==1
outreg2 using income_2nd.tex,append ctitle(Self employment change) tex(frag)
reg D_HH_self_May10 d  i.migrap if hl1==1
outreg2 using income_2nd.tex,append ctitle(Self employment change) tex(frag)

*
exit
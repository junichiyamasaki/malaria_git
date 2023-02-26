use e_panel_2nd,clear
set more off


*help says: xtprobit fits random-effects and population-averaged probit models.    There is no command for a conditional fixed-effects model, as there does not exist a sufficient statistic allowing the fixed effects to be conditioned out of the likelihood.  Unconditional fixed-effects probit models may be fit with probit command with indicator variables for the panels.  However, unconditional fixed-effects estimates are biased.


gen inactivefever=h18b
replace inactivefever=0 if h18a==2

* age60‚Ìì¬
gen age60=r4
replace age60=60 if r4>=60&r4<=98
label define age60  0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 11 11 12 12 13 13 14 14 15 15 16 16 17 17 18 18 19 19 20 20 21 21 22 22 23 23 24 24 25 25 26 26 27 27 28 28 29 29 30 30 31 31 32 32 33 33 34 34 35 35 36 36 37 37 38 38 39 39 40 40 41 41 42 42 43 43 44 44 45 45 46 46 47 47 48 48 49 49 50 50 51 51 52 52 53 53 54 54 55 55 56 56 57 57 58 58 59 59 60 "over 60"
label value age60 age60

gen age20=r4
replace age20=20 if r4>=20&r4<=98
label value age20 age60

gen age05=(r4<=5)
gen age612=(r4<=12&r4>5)
gen age1318=(r4<=18&r4>12)
gen age1924=(r4<=24&r4>18)
gen age2540=(r4<=40&r4>24)
gen age41=(r4<99&r4>40)

gen agecategory=1 if age05==1
replace agecategory=2 if age612==1
replace agecategory=3 if age1318==1
replace agecategory=4 if age1924==1
replace agecategory=5 if age2540==1
replace agecategory=6 if age41==1
label define agecategory 1 "0-5" 2 "6-12" 3 "13-18" 4 "19-24" 5 "25-40" 6 "41-"
label value agecategory agecategory 

gen age04=(r4<=4&r4>=0)
gen age57=(r4<=7&r4>4)
gen age810=(r4<=10&r4>7)
gen age1113=(r4<=13&r4>10)
gen age1416=(r4<=16&r4>13)
gen age17=(r4>16)


gen outside=r8-1

*”N—î‚É‚æ‚érdtA‰á’ A‰á‚ÉŽh‚³‚ê‚é‚Ö‚ÌŒø‰Ê‚ÌŠÖŒW
*‚Ü‚¸‚ÍƒOƒ‰ƒtì¬
graph bar mqnid , over(age60, label(labsize(tiny) angle(vertical) alternate) ) by(G phase) 
graph export age60_and_mosquitonet_2nd.ps,replace
graph bar mqnid if r8==1, over(age60, label(labsize(tiny) angle(vertical) alternate) ) by(G phase)  
graph export age60_and_mosquitonet_ifslept_2nd.ps,replace
graph bar rdt, over(age60, label(labsize(tiny) angle(vertical) alternate) ) by(G phase) 
graph export age60_and_rdt_2nd.ps,replace
graph bar rdt if r8==1, over(age60, label(labsize(tiny) angle(vertical) alternate) ) by(G phase)  
graph export age60_and_rdt_ifslept_2nd.ps,replace
graph bar llitnid , over(age60, label(labsize(tiny) angle(vertical) alternate) ) by(G phase) 
graph export age60_and_llitn_2nd.ps,replace
graph bar inactive, over(age60, label(labsize(tiny) angle(vertical) alternate) ) by(rdt)
graph export age60_and_fever_2nd.ps,replace

gen drdt=D.rdt
graph bar  drdt, over(age60, label(labsize(tiny) angle(vertical) alternate)) by(G)
graph export age60_and_drdt_2nd.ps,replace

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
gen Dandage17=D*age17


gen Dandage05=D*age05
gen Dandage612=D*age612
gen Dandage1318=D*age1318
gen Dandage1924=D*age1924
gen Dandage2540=D*age2540
gen Dandage41=D*age41

*rdt‰ñ‹A•ªÍ‚Æcouterfactualì¬
reg D.rdt Dandage05 Dandage612 Dandage1318 Dandage1924 Dandage2540 Dandage41  ,  vce(cluster migrap)
outreg2 using rdt_and_treat_2nd.tex,replace  tex(frag)

reg D.rdt Dandage05 Dandage612 Dandage1318 Dandage1924 Dandage2540 Dandage41  if L.mqnid==0,  vce(cluster migrap)
outreg2 using rdt_and_treat_2nd.tex,append  tex(frag) 
reg D.rdt Dandage05 Dandage612 Dandage1318 Dandage1924 Dandage2540 Dandage41  if L.mqnid==0,  vce(cluster migrap)
outreg2 using rdt_and_treat_2nd.tex,append  tex(frag) 

*mqnid‰ñ‹A•ªÍ‚Æcouterfactualì¬

reg D.mqnid Dandage05 Dandage612 Dandage1318 Dandage1924 Dandage2540 Dandage41 D.outside ,  vce(cluster migrap)
outreg2 using mqnid_and_treat_2nd.tex,replace  tex(frag) 


reg D.llitnid Dandage05 Dandage612 Dandage1318 Dandage1924 Dandage2540 Dandage41 D.outside ,  vce(cluster migrap)
outreg2 using mqnid_and_treat_2nd.tex,append  tex(frag) 

reg D.ntmqnid Dandage05 Dandage612 Dandage1318 Dandage1924 Dandage2540 Dandage41 D.outside ,  vce(cluster migrap)
outreg2 using mqnid_and_treat_2nd.tex,append  tex(frag) 

reg D.ntllitnid Dandage05 Dandage612 Dandage1318 Dandage1924 Dandage2540 Dandage41 D.outside ,  vce(cluster migrap)
outreg2 using mqnid_and_treat_2nd.tex,append  tex(frag) 

reg D.bite Dandage05 Dandage612 Dandage1318 Dandage1924 Dandage2540 Dandage41 D.outside ,  vce(cluster migrap)
outreg2 using bite_and_treat_2nd.tex,replace  tex(frag) 

reg D.bite Dandage05 Dandage612 Dandage1318 Dandage1924 Dandage2540 Dandage41 D.outside if L.mqnid==0 ,  vce(cluster migrap)
outreg2 using bite_and_treat_2nd.tex,append  tex(frag) 
reg D.flr Dandage05 Dandage612 Dandage1318 Dandage1924 Dandage2540 Dandage41 D.outside ,  vce(cluster migrap)
outreg2 using bite_and_treat_2nd.tex,append ctitle(D.num of bite) tex(frag) 
reg D.flr Dandage05 Dandage612 Dandage1318 Dandage1924 Dandage2540 Dandage41 D.outside if L.mqnid==0 ,  vce(cluster migrap)
outreg2 using bite_and_treat_2nd.tex,append ctitle(D.num of bite) tex(frag) 


*”M‚Å“®‚¯‚È‚©‚Á‚½“ú

reg D.inactivefever Dandage05 Dandage612 Dandage1318 Dandage1924 Dandage2540 Dandage41 D.outside ,  vce(cluster migrap)
outreg2 using fever_and_treat_2nd.tex,replace ctitle(mqnid) tex(frag) 

*”j‚ê‚Ä‚¢‚é‰á’ ‚»‚¤‚Å‚È‚¢‰á’ ‚Årdt‚É‘Î‚·‚é‰e‹¿?
reg rdt mqnid ntmqnid llitnid ntllitnid age05 age612 age1318 age1924 age2540   i.migrap if phase==1, 
outreg2 using torn_and_rdt_2nd.tex,replace ctitle(rdt(1st)) tex(frag)

reg rdt mqnid ntmqnid llitnid ntllitnid age05 age612 age1318 age1924 age2540   i.migrap if phase==2,  
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(2nd)) tex(frag)

ivregress 2sls  rdt age05 age612 age1318 age1924 age2540   (mqnid=D)  if phase==2
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(2nd)IV) tex(frag)
ivregress 2sls  rdt  age05 age612 age1318 age1924 age2540   (ntmqnid=D)  if phase==2
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(2nd)IV) tex(frag)
ivregress 2sls  rdt  age05 age612 age1318 age1924 age2540   (llitnid=D)  if phase==2
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(2nd)IV) tex(frag)
ivregress 2sls  rdt  age05 age612 age1318 age1924 age2540   (ntllitnid=D)  if phase==2
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(2nd)IV) tex(frag)

*Œ‡È“ú” 
gen absence=e6
replace absence=0 if e5==2
gen absence2=absence
replace absence2=0 if e7!=2
replace absence2=. if e5==.

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


*ƒlƒbƒg‚Ì–‡”
gen nofnet=h2
replace nofnet=0 if h1==2

*”j‚ê‚½‰á’ ‚Ì–‡”‚Æ‚»‚Ì•\
rename noftorned noftorn
label value noftorn nofnet campnet 
latab noftorn nofnet if phase==1&hl1==1
*”j‚ê‚Ä‚¢‚È‚¢‰á’ ‚Ì–‡”
gen nofnottorn=nofnet-noftorn

*”z‚ç‚ê‚½ƒlƒbƒg‚Ì–‡”‚ÍH
label define hhsize 0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 11 11 12 12 13 13 14 14 15 15 16 16 17 17
label value hhsize hhsize
latab campnet G if hl1==1
latab campnet hhsize if G==1&hl1==1

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

tobit campnet L.hhsize L.noftorn L.nofnottorn hhsize_lnoftorn hhsize_lnofnottorn i.migrap if G==1&hl1==1,ll(0)
outreg2 using distribution_2nd.tex,replace ctitle(campnet) tex(frag)
*tobit campnet L.hhsize3 L.noftorn L.nofnottorn hhsize3_lnoftorn hhsize3_lnofnottorn i.migrap if G==1&hl1==1,ll(0)
*outreg2 using distribution_2nd.tex,append ctitle(campnet) tex(frag)
tobit campnet L.hhsize L.noftorn L.nofnottorn hhsize_lnoftorn hhsize_lnofnottorn i.migrap if G==1&hl1==1&campnet0912==0,ll(0)
outreg2 using distribution_2nd.tex,append ctitle(campnet10) tex(frag)
*tobit campnet L.hhsize3 L.noftorn L.nofnottorn hhsize3_lnoftorn hhsize3_lnofnottorn i.migrap if G==1&hl1==1&campnet0912==0,ll(0)
*outreg2 using distribution_2nd.tex,append ctitle(campnet10) tex(frag)
tobit campnet L.hhsize L.noftorn L.nofnottorn hhsize_lnoftorn hhsize_lnofnottorn i.migrap if G==1&hl1==1&campnet1001==0,ll(0)
outreg2 using distribution_2nd.tex,append ctitle(campnet09) tex(frag)
 


*ŒÃ‚¢‰á’ ‚ðŽÌ‚Ä‚½‚©‚Ç‚¤‚©
latab h15 if hl1==1 &phase==2

*‰ÆŒvƒŒƒxƒ‹‚Å‚ÌŠ“¾‚Ì•Ï‰»
gen D_HH_salary_May10=HH_salary_May10-HH_salary_Dec09
gen D_HH_self_May10=HH_self_May10-HH_self_Dec09

reg D_HH_salary_May10 D if hl1==1, vce(cluster migrap)
outreg2 using income_2nd.tex,replace ctitle(D.SalaryHH) tex(frag)

reg D_HH_self_May10 D HH_self_Dec09 if hl1==1, vce(cluster migrap)
outreg2 using income_2nd.tex,append ctitle(D.Self employmentHH) tex(frag)

*ŒÂlƒŒƒxƒ‹‚Å‚ÌŠ“¾
gen D_salary_May10=salary_May10-salary_Dec09
gen D_self_May10=self_May10-self_Dec09


reg D_salary_May10 D , vce(cluster migrap)
outreg2 using income_2nd.tex,append ctitle(D.Salary) tex(frag)
reg D_salary_May10 D if L.mqnid==0 , vce(cluster migrap)
outreg2 using income_2nd.tex,append ctitle(D.Salary) tex(frag)
reg D_self_May10 D , vce(cluster migrap)
outreg2 using income_2nd.tex,append ctitle(D.Self employment) tex(frag)
reg D_self_May10 D self_Dec09  if L.mqnid==0 , vce(cluster migrap)
outreg2 using income_2nd.tex,append ctitle(D.Self employment) tex(frag)

*ˆã—Ã”ïŽxo‚Ö‚ÌŒø‰Ê
reg D.mediex6 G   hhsize if hl1==1,vce(cluster migrap)
outreg2 using mediex6_and_treat_2nd.tex,replace  tex(frag) 

*”j‚ê‚½‰á’ ‚Ì–‡”‚ÅŒø‰Ê‚Ìˆá‚¢
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


*1st‚Å”j‚ê‚½‰á’ ‚ÉQ‚Ä‚¢‚½‚©‚ÅŒø‰Ê‚Ìˆá‚¢

gen mqnid2=mqnid
replace mqnid2=L.mqnid if phase==2
gen ntmqnid2=ntmqnid
replace ntmqnid2=L.ntmqnid if phase==2

gen Dandmqnid2=D*mqnid2
gen Dandntmqnid2=D*ntmqnid2
*xtprobit rdt G phase D Dandmqnid2 Dandntmqnid2 outside i.migrap 
*outreg2 using rdt_and_treat_2nd.tex,append ctitle(rdt) tex(frag)

*xtprobit mqnid  G phase D Dandmqnid2  outside i.migrap 
*outreg2 using mqnid_and_treat_2nd.tex,append ctitle(mqnid) tex(frag) 

*—cŽ™Ž€–S—¦
label value h34x h35x h36x campnet
latab h34x h35x
latab h34x h36x

*’mŽ¯‚Ì•Ï‰»
reg D.k14g G L.k14g  if hl1==1, vce(cluster migrap)
outreg2 using cap_and_treat_2nd.tex,replace  tex(frag)
reg D.k14g G   if hl1==1, vce(cluster migrap)
outreg2 using cap_and_treat_2nd.tex,append  tex(frag)

*ŽžŠÔ”z•ª
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

*‰á’ ‚ÉQ‚Ä‚¢‚½ŽžŠÔ‚ð‰á’ ‚ÌŽí—Þ•Ê‚É
gen mqntime=flr14x
gen ntmqntime=flr14x
replace ntmqntime=0 if ntmqnid==0
gen llitntime=flr14x
replace llitntime=0 if llitnid==0
gen ntllitntime=flr14x
replace ntllitntime=0 if ntllitnid==0

*‰½ŒÌŽáŽÒ‚ÉŒø‰Ê‚ª‚È‚¢‚Ì‚©H

graph bar mqntime , over(age60, label(labsize(tiny) angle(vertical) alternate) ) by(G) 
graph export age60_and_mqntime_2nd.ps,replace

graph bar outside , over(age60, label(labsize(tiny) angle(vertical) alternate) ) by(G) 
graph export age60_and_goout_2nd.ps,replace

latab agecategory flr15x

reg flr mqntime ntmqntime llitntime ntllitntime  age05 age612 age1318 age1924 age2540,vce(cluster migrap)
outreg2 using outcome_and_young_2nd.tex, replace ctitle(num of bites) tex(frag)

ivregress 2sls flr (ntllitntime=D)   age05 age612 age1318 age1924 age2540 if phase==2,vce(cluster migrap)
outreg2 using outcome_and_young_2nd.tex, append ctitle(num of bites) tex(frag)



reg rdt mqntime ntmqntime llitntime ntllitntime  age05 age612 age1318 age1924 age2540,vce(cluster migrap)
outreg2 using outcome_and_young_2nd.tex,append  tex(frag)

ivregress 2sls rdt (ntllitntime=D) age05 age612 age1318 age1924 age2540 if phase==2,vce(cluster migrap)
outreg2 using outcome_and_young_2nd.tex, append  tex(frag)


*‰á‚ÉŽh‚³‚ê‚é‚±‚Æ‚Ærdt‚ÌŠÖŒW
reg rdt flr bite, vce(cluster migrap)
outreg2 using rdt_and_bite_2nd.tex, replace  tex(frag)


*Ž€–S—¦‚ÌŒvŽZ
 total(h35x)/total(h34x)
display total(h36x)/total(h34x)

*e‚Æˆê‚ÉQ‚Ä‚¢‚éŽq‹Ÿ
graph bar nwithparent  if r4<=19&hl1==3, over(r4, label(labsize(small) angle(vertical) alternate) ) over(phase)
graph export age60_and_nwithparent_2nd.ps,replace

save pre_2nd,replace
exit
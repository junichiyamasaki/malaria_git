use e_panel_2nd,clear
set more off


*help says: xtprobit fits random-effects and population-averaged probit models.    There is no command for a conditional fixed-effects model, as there does not exist a sufficient statistic allowing the fixed effects to be conditioned out of the likelihood.  Unconditional fixed-effects probit models may be fit with probit command with indicator variables for the panels.  However, unconditional fixed-effects estimates are biased.

* age60‚Ìì¬
gen age60=r4
replace age60=60 if r4>=60&r4<=98
label define age60  0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 11 11 12 12 13 13 14 14 15 15 16 16 17 17 18 18 19 19 20 20 21 21 22 22 23 23 24 24 25 25 26 26 27 27 28 28 29 29 30 30 31 31 32 32 33 33 34 34 35 35 36 36 37 37 38 38 39 39 40 40 41 41 42 42 43 43 44 44 45 45 46 46 47 47 48 48 49 49 50 50 51 51 52 52 53 53 54 54 55 55 56 56 57 57 58 58 59 59 60 "over 60"
label value age60 age60

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

gen drdt=D.rdt
graph bar  drdt, over(age60, label(labsize(tiny) angle(vertical) alternate)) by(G)
graph export age60_and_drdt_2nd.ps,replace

gen age60sq=age60^2
gen age60cu=age60^3
gen Dandage60=D*age60
gen Dandage60sq=D*age60sq
gen Dandage60cu=D*age60cu

*rdt‰ñ‹A•ªÍ‚Æcouterfactualì¬
xtprobit rdt G phase D Dandage60 Dandage60sq Dandage60cu age60 age60sq age60cu i.migrap r8,
outreg2 using rdt_and_treat_2nd.tex,replace ctitle(rdt) tex(frag) 

matrix rdtbeta=e(b)
gen rdtbetaD=rdtbeta[1,3]
gen rdtbetaDandage60=rdtbeta[1,4]
gen rdtbetaDandage60sq=rdtbeta[1,5]
gen rdtbetaDandage60cu=rdtbeta[1,6]
predict rdtxb, xb
gen rdtwithoutD=normal(rdtxb-rdtbetaD*D-rdtbetaDandage60*Dandage60-rdtbetaDandage60sq*Dandage60sq-rdtbetaDandage60sq)
predict rdttreat, pu0
graph twoway scatter rdttreat age60 if r8==1&D==1&migrap==17 || scatter rdtwithoutD age60 if r8==1&D==1&migrap==17
graph export age60_and_rdt_reg_2nd.ps,replace

*logitversion
logit rdt  G phase D Dandage60 Dandage60sq Dandage60cu age60 age60sq age60cu  i.migrap r8, robust 
*outreg2 using rdt_and_treat_2nd.tex,append ctitle(rdt logit) tex(frag) 
matrix rdtbetaL=e(b)
gen rdtbetaDL=rdtbetaL[1,3]
gen rdtbetaDandage60L=rdtbetaL[1,4]
gen rdtbetaDandage60sqL=rdtbetaL[1,5]
gen rdtbetaDandage60cuL=rdtbetaL[1,6]
predict rdtxbL, xb
gen rdtwithoutDL=exp(rdtxbL-rdtbetaDL*D-rdtbetaDandage60L*Dandage60-rdtbetaDandage60sqL*Dandage60sq-rdtbetaDandage60cuL*Dandage60cu)/(1+exp(rdtxbL-rdtbetaDL*D-rdtbetaDandage60L*Dandage60-rdtbetaDandage60sqL*Dandage60sq-rdtbetaDandage60cuL*Dandage60cu))
predict rdttreatL, pr
graph twoway scatter rdttreatL age60 if r8==1&D==1&migrap==17 || scatter rdtwithoutDL age60 if  r8==1&D==1&migrap==17


*mqnid‰ñ‹A•ªÍ‚Æcouterfactualì¬

xtprobit mqnid  G phase D Dandage60 Dandage60sq Dandage60cu age60 age60sq age60cu r8 i.migrap , 
outreg2 using mqnid_and_treat_2nd.tex,replace ctitle(mqnid) tex(frag) 
matrix mqnidbeta=e(b)
gen mqnidbetaD=mqnidbeta[1,3]
gen mqnidbetaDandage60=mqnidbeta[1,4]
gen mqnidbetaDandage60sq=mqnidbeta[1,5]
gen mqnidbetaDandage60cu=mqnidbeta[1,6]
predict mqnidxb, xb
gen mqnidwithoutD=normal(mqnidxb-mqnidbetaD*D-mqnidbetaDandage60*Dandage60-mqnidbetaDandage60sq*Dandage60sq-mqnidbetaDandage60cu*Dandage60cu)

predict mqnidtreat, pu0
graph twoway scatter mqnidtreat age60 if r8==1&D==1&migrap==17 || scatter mqnidwithoutD age60 if  r8==1&D==1&migrap==17
graph export age60_and_mosquitonet_reg_2nd.ps,replace




*logitversion
logit mqnid  G phase D Dandage60 Dandage60sq Dandage60cu age60 age60sq age60cu  i.migrap r8, robust 
*outreg2 using mqnid_and_treat_2nd.tex,append ctitle(mqnid logit) tex(frag) 
matrix mqnidbetaL=e(b)
gen mqnidbetaDL=mqnidbetaL[1,3]
gen mqnidbetaDandage60L=mqnidbetaL[1,4]
gen mqnidbetaDandage60sqL=mqnidbetaL[1,5]
gen mqnidbetaDandage60cuL=mqnidbetaL[1,6]
predict mqnidxbL, xb
gen mqnidwithoutDL=exp(mqnidxbL-mqnidbetaDL*D-mqnidbetaDandage60L*Dandage60-mqnidbetaDandage60sqL*Dandage60sq-mqnidbetaDandage60cuL*Dandage60cu)/(1+exp(mqnidxbL-mqnidbetaDL*D-mqnidbetaDandage60L*Dandage60-mqnidbetaDandage60sqL*Dandage60sq-mqnidbetaDandage60cuL*Dandage60cu))
predict mqnidtreatL, pr
graph twoway scatter mqnidtreatL age60 if r8==1&D==1&migrap==17 || scatter mqnidwithoutDL age60 if  r8==1&D==1&migrap==17



xtprobit bite G phase D Dandage60 Dandage60sq Dandage60cu age60 age60sq age60cu i.migrap
outreg2 using bite_and_treat_2nd.tex,replace ctitle(bite or not) tex(frag) 
xttobit flr G phase D Dandage60 Dandage60sq Dandage60cu age60 age60sq age60cu i.migrap, ll(0)
outreg2 using bite_and_treat_2nd.tex,append ctitle(num of bite) tex(frag) 

*”j‚ê‚Ä‚¢‚é‰á’ ‚»‚¤‚Å‚È‚¢‰á’ ‚Årdt‚É‘Î‚·‚é‰e‹¿?
probit rdt mqnid ntmqnid if phase==1,  
outreg2 using torn_and_rdt_2nd.tex,replace ctitle(rdt(1st)) tex(frag) 
probit rdt mqnid ntmqnid i.migrap if phase==1, 
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(1st)) tex(frag)

probit rdt mqnid ntmqnid if phase==2,  
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(2nd)) tex(frag)
probit rdt mqnid ntmqnid i.migrap if phase==2,  
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(2nd)) tex(frag)
ivregress 2sls  rdt age60 age60sq age60cu  i.migrap (mqnid=D)  if phase==2
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(2nd)IV) tex(frag)
ivregress 2sls  rdt  age60 age60sq age60cu i.migrap (ntmqnid=D)  if phase==2
outreg2 using torn_and_rdt_2nd.tex,append ctitle(rdt(2nd)IV) tex(frag)

*Œ‡È“ú” 
gen absence=e6
replace absence=0 if e5==2
reg D.absence G L.absence i.migrap, robust
outreg2 using absence_2nd.tex, replace ctitle(delta_absence) tex(frag)
reg D.absence G i.migrap, robust
outreg2 using absence_2nd.tex, append ctitle(delta_absence) tex(frag)
xttobit absence G phase D Dandage60 Dandage60sq Dandage60cu age60 age60sq age60cu i.migrap, ll(0)
outreg2 using absence_2nd.tex, append ctitle(delta_absence) tex(frag)



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

gen hhsize3_lnofnet=hhsize3*L.nofnet
gen hhsize3_lnoftorn=hhsize3*L.noftorn
gen hhsize3_lnofnottorn=hhsize3*L.nofnottorn
tobit campnet L.hhsize3 L.noftorn L.nofnottorn hhsize3_lnoftorn hhsize3_lnofnottorn i.migrap if G==1&hl1==1, ll(0)
outreg2 using distribution_2nd.tex,replace ctitle(# of distributed nets) tex(frag)
 


*ŒÃ‚¢‰á’ ‚ðŽÌ‚Ä‚½‚©‚Ç‚¤‚©
latab h15 if hl1==1 &phase==2

*‰ÆŒvƒŒƒxƒ‹‚Å‚ÌŠ“¾‚Ì•Ï‰»
gen D_HH_salary_May10=HH_salary_May10-HH_salary_Dec09
gen D_HH_self_May10=HH_self_May10-HH_self_Dec09

reg D_HH_salary_May10 G HH_salary_Dec09 i.migrap if hl1==1
outreg2 using income_2nd.tex,replace ctitle(Salary change) tex(frag)
reg D_HH_salary_May10 G i.migrap if hl1==1
outreg2 using income_2nd.tex,append ctitle(Salary change) tex(frag)

reg D_HH_self_May10 G HH_self_Dec09 i.migrap if hl1==1
outreg2 using income_2nd.tex,append ctitle(Self employment change) tex(frag)
reg D_HH_self_May10 G  i.migrap if hl1==1
outreg2 using income_2nd.tex,append ctitle(Self employment change) tex(frag)

*”M‚Å“®‚¯‚È‚©‚Á‚½“ú
gen inactivefever=h18b
replace inactivefever=0 if h18a==.

xttobit inactivefever  G phase D Dandage60 Dandage60sq Dandage60cu age60 age60sq age60cu i.migrap , ll(0)
outreg2 using fever_and_treat_2nd.tex,replace ctitle(mqnid) tex(frag) 

*ˆã—Ã”ïŽxo‚Ö‚ÌŒø‰Ê
xttobit mediex6 G phase D  i.migrap hhsize if hl1==1, ll(0)
outreg2 using mediex6_and_treat_2nd.tex,replace ctitle(Medical expenditure) tex(frag) 

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


*xtprobit rdt G phase D Dandnofnet Dandnofnetsq Dandnoftorn Dandnoftornsq  i.migrap 

xtprobit rdt G phase D Dandnoftornhhsize3 r8 i.migrap
outreg2 using rdt_and_treat_2nd.tex,append ctitle(rdt) tex(frag)
xtprobit rdt G phase D Dandnofnottornhhsize3 Dandnoftornhhsize3 r8 i.migrap
outreg2 using rdt_and_treat_2nd.tex,append ctitle(rdt) tex(frag)


*1st‚Å”j‚ê‚½‰á’ ‚ÉQ‚Ä‚¢‚½‚©‚ÅŒø‰Ê‚Ìˆá‚¢

gen mqnid2=mqnid
replace mqnid2=L.mqnid if phase==2
gen ntmqnid2=ntmqnid
replace ntmqnid2=L.ntmqnid if phase==2

gen Dandmqnid2=D*mqnid2
gen Dandntmqnid2=D*ntmqnid2
xtprobit rdt G phase D Dandmqnid2 Dandntmqnid2 r8 i.migrap 
outreg2 using rdt_and_treat_2nd.tex,append ctitle(rdt) tex(frag)

xtprobit mqnid  G phase D Dandmqnid2  r8 i.migrap 
outreg2 using mqnid_and_treat_2nd.tex,append ctitle(mqnid) tex(frag) 

*—cŽ™Ž€–S—¦
label value h34x h35x h36x campnet
latab h34x h35x
latab h34x h36x

save pre_2nd,replace
exit
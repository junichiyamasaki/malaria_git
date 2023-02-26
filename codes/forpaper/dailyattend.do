 global   localdata "/Users/J_YAMASAKI/Documents/statadata"
use $localdata/Malaria/2nd/dailyattendancedata_2nd.dta,clear
label define G 1 Treatment 0 Control
label value G G
set more off


egen abrateG=mean(absent), by (G time)
egen abrateclass=mean(absent), by (lclasse cecole time)
graph twoway tsline abrateG if time>=td(01jan2008)&abrateG<=0.5, by(G) tlabel(#10, angle(vertical)) yscale(r(0 0.5))

*We have been informed that the distribution of nets took place from 14th December to 24th December in all Atsinanana region. The distribution of nets in Ambalahasina and Mahatsara fokontany was done on 22nd December after the survey team completed its work. 
*2nd interview was held on 20 JUN at the latest
gen phase=0
replace phase=1 if time>=td(24SEP2009)
replace phase=2 if time>=td(24DEC2009)
replace phase=3 if time>=td(20JUN2010)

gen D=0
replace D=1 if (G==1&phase==2)
replace D=1 if phase==3

gen bound=(cecole==2|cecole==3)


gen holiday=(m==9)
egen holidaycheck=mean(holiday), by( cecole annee lclasse time) 
egen tabsencecheck=mean(holiday), by( cecole annee lclasse time) 
gen classe33low=(classe<=33)
gen Dandclasse33low=D*classe33low
gen classe34high=(classe>=34)
gen Dandclasse34high=D*classe34high

gen m2=m
replace m2=9 if holidaycheck>0&holidaycheck<1
replace m2=8 if tabsencecheck>0&tabsencecheck<1


gen chance=(m==1|m==0)
egen chancecheck=mean(chance), by( cecole annee lclasse time) 

egen chancetotal=total(chance), by(phase G annee lclasse id) 
gen chance2=(m2==1|m2==0)
egen chance2total=total(chance2), by(phase G annee lclasse id) 

reg chancetotal  classe33low  if phase==2&G==1
reg chancetotal  classe33low  if phase==2&G==1&bound==1
reg chance2total  classe33low  if phase==2&G==1
reg chance2total  classe33low  if phase==2&G==1&bound==1

gen absent2=0
replace absent2=1 if m2==0
replace absent2=. if m2==8
replace absent2=. if m2==9


graph twoway tsline abrateclass if abrateclass<=0.5, by(G) tlabel(#10, angle(vertical)) yscale(r(0 0.5))
graph export dailyattendance.eps, replace
graph twoway tsline abrateclass if bound==1&abrateclass<=0.5, by(G) tlabel(#10, angle(vertical)) yscale(r(0 0.5))
graph export dailyattendance_b.eps, replace

graph twoway tsline abrateclass if abrateclass<=0.5&classe<=33, by(G) tlabel(#10, angle(vertical)) yscale(r(0 0.5))
graph export dailyattendance_33.eps, replace
graph twoway tsline abrateclass if bound==1&abrateclass<=0.5&classe<=33, by(G) tlabel(#10, angle(vertical)) yscale(r(0 0.5))
graph export dailyattendance_33b.eps, replace

tab   cecole,     generate(cecolei)

forvalues x = 1/12{
gen month`x'=(month==`x')
gen Dandmonth`x'=D*month`x'
gen cecole1andmonth`x'=cecolei1*month`x'
gen cecole2andmonth`x'=cecolei2*month`x'
gen cecole3andmonth`x'=cecolei3*month`x'
gen cecole4andmonth`x'=cecolei4*month`x'
gen cecole5andmonth`x'=cecolei5*month`x'
gen cecole6andmonth`x'=cecolei6*month`x'
}



tab time,gen(timei)
forvalues x = 1/585{
gen Dandtime`x'=D*timei`x'
}


gen onemonth=((time>=td(23NOV2009)&time<=td(23DEC2009))|(time>=td(15APR2010)&time<=td(15MAY2010)))
gen absent2_onemonth=absent2*onemonth

gen chance_onemonth=chance*onemonth
gen absent2per=absent2

egen cluster1=group(cecole classe)



label var D "Distributed"
label var classe33low "Under 3rd"
label var Dandclasse33low "D * Under_3rd"
label var absent2 "Absence"

save $localdata/Malaria/forpaper/dailyattend_forpaper_2nd.dta, replace
use $localdata/Malaria/forpaper/dailyattend_forpaper_2nd.dta,clear

eststo clear
	
*** First, see month level regression using full sample
collapse  (sum) absent absent2 (mean) D Dandclasse33low classe33low  Dandclasse34high classe34high bound cecole classe annee,  by(ideleve G year month phase cluster1)

label var D "Distributed"
label var classe33low "Under 3rd"
label var Dandclasse33low "D * Under_3rd"
label var classe34high "Above 3rd"
label var Dandclasse34high "D * Above 3rd"
label var absent2 "Absence per Month"

egen month_cecole=group(month cecole)
egen year_cecole=group(year cecole)
tab cecole,gen(cecole_dummy)
tab year,gen(year_dummy)
tab month_cecole,gen(month_cecole_dummy)
tab year_cecole,gen(year_cecole_dummy)

forvalues x = 1/6{
	gen cecole_`x'=(cecole==`x')
}

forvalues x = 1/12{
gen month_`x'=(month==`x')
gen Dandmonth`x'=D*month_`x'
gen cecoleandmonth_1_`x'=cecole_1*month_`x'
gen cecoleandmonth_2_`x'=cecole_2*month_`x'
gen cecoleandmonth_3_`x'=cecole_3*month_`x'
gen cecoleandmonth_4_`x'=cecole_4*month_`x'
gen cecoleandmonth_5_`x'=cecole_5*month_`x'
gen cecoleandmonth_6_`x'=cecole_6*month_`x'
}

forvalues x = 2008/2010{
gen year_`x'=(year==`x')
gen cecoleandyear_1_`x'=cecole_1*year_`x'
gen cecoleandyear_2_`x'=cecole_2*year_`x'
gen cecoleandyear_3_`x'=cecole_3*year_`x'
gen cecoleandyear_4_`x'=cecole_4*year_`x'
gen cecoleandyear_5_`x'=cecole_5*year_`x'
gen cecoleandyear_6_`x'=cecole_6*year_`x'
}


gen ytrend = year-2009

gen cecoleandytrend1=cecole_1*ytrend
gen cecoleandytrend2=cecole_2*ytrend
gen cecoleandytrend3=cecole_3*ytrend
gen cecoleandytrend4=cecole_4*ytrend
gen cecoleandytrend5=cecole_5*ytrend
gen cecoleandytrend6=cecole_6*ytrend

eststo clear

	*reg absent2  D Dandclasse33low classe33low  cecole_dummy*  cecoleandyear* cecoleandmonth*   if phase<=2,cluster(cluster1)
/*
reg absent2  D Dandclasse33low classe33low  cecole_dummy*  year_cecole_dummy* month_cecole_dummy*  if phase<=2,cluster(cluster1)
eststo
test D+Dandclasse33low=0
estadd scalar totaleffect=r(p)
reg absent2  D Dandclasse33low classe33low  cecole_dummy*  year_cecole_dummy* month_cecole_dummy*  if phase<=2*bound==1,cluster(cluster1)
eststo
test D+Dandclasse33low=0
estadd scalar totaleffect=r(p)
esttab using $dropbox/Madagascar_LLIN/presentation/olsabsence_dailyattend_monthly, tex se label replace ///
indicate("Year*School FE = year_cecole_dummy*" "School FE = cecole_dummy*" "Month*School FE =  month_cecole_dummy*") ///
addnote("Class level cluster robust SEs. Estimation is by OLS." "Column 1 uses all schools while Column 2 uses only seaside schools." "{\it Net Effect of Under 3rd} shows p-value of testing"  "whether the effect for classes under 3rd is zero or not." ) ///
star(+ .10 * .05  ** .01 *** .001) drop(o.*) ///
stats(N  totaleffect, labels(Observations "Net Effect of Under 3rd"))
*/
reg absent2  D Dandclasse34high classe34high  cecole_dummy*  year_cecole_dummy* month_cecole_dummy*  if phase<=2,cluster(cluster1)
eststo
test D+Dandclasse34high=0
estadd scalar totaleffect=r(p)
reg absent2  D Dandclasse34high classe34high  cecole_dummy*  year_cecole_dummy* month_cecole_dummy*  if phase<=2*bound==1,cluster(cluster1)
eststo
test D+Dandclasse34high=0
estadd scalar totaleffect=r(p)
esttab using $dropbox/Madagascar_LLIN/presentation/olsabsence_dailyattend_monthly, tex se label replace ///
indicate("Year FE * School FE = year_cecole_dummy*" "School FE = cecole_dummy*" "Month*School FE =  month_cecole_dummy*") ///
addnote("Class level cluster robust SEs. Estimation is by OLS." "Column 1 uses all schools while Column 2 uses only seaside schools." "{\it Net Effect of Above 3rd} shows p-value of testing"  "whether the effect for classes above the 3rd is zero or not." ) ///
star(+ .10 * .05  ** .01 *** .001) drop(o.*) ///
stats(N  totaleffect, labels(Observations "Net Effect of Over 3rd"))

reg absent2  D Dandclasse34high classe34high  cecole_dummy*  cecoleandytrend*  if phase<=2*bound==1,cluster(cluster1)
eststo
test D+Dandclasse34high=0
estadd scalar totaleffect=r(p)

esttab est1 est3 est2 using $dropbox/Madagascar_LLIN/presentation/olsabsence_dailyattend_monthly_withytrend, tex se label replace ///
indicate("Linear Trend * School FE = cecoleandytrend*" "Year FE *School FE = year_cecole_dummy*" "School FE = cecole_dummy*" "Month*School FE =  month_cecole_dummy*") ///
addnote("Class level cluster robust SEs. Estimation is by OLS." "Column 1 uses all schools while Column 2 uses only seaside schools." "{\it Net Effect of Above 3rd} shows p-value of testing"  "whether the effect for classes above the 3rd is zero or not." ) ///
star(+ .10 * .05  ** .01 *** .001)  ///
stats(N  totaleffect, labels(Observations "Net Effect of Over 3rd"))


*** Next, mimic the  questionnaire analaysi
use $localdata/Malaria/forpaper/dailyattend_forpaper_2nd.dta,clear
*drop if time<td(23NOV2009)
*drop if time>=td(23DEC2009)&time<=td(15MAY2010)
*drop if time>=td(23DEC2009)&time<=td(19MAY2010)
*drop if time>=td(20JUN2010)



collapse (sum) absent absent2 absent2_onemonth chance_onemonth (mean) absent2per classe33low Dandclasse33low classe34high Dandclasse34high D bound cecole classe annee,  by(ideleve G phase cluster1)

label var D "Distributed"
label var classe33low "Under 3rd"
label var Dandclasse33low "D * Under_3rd"
label var absent2 "Absence"

label var classe34high "Above 3rd"
label var Dandclasse34high "D * Above 3rd"

gen absent2per_onemonth=absent2_onemonth/chance_onemonth
tsset ideleve phase

reg D.absent classe33low D Dandclasse33low if phase==2
reg D.absent classe33low D Dandclasse33low if phase==2&bound==1

reg D.absent2 classe33low D Dandclasse33low if phase==2
reg D.absent2 classe33low D Dandclasse33low if phase==2&bound==1


gen dabsent2=D.absent2
gen dabsent2per=D.absent2per

label var dabsent2 "$\Delta$ Absence"
label var absent2_onemonth "Absence 1 month"
label var absent2per_onemonth "Absence Ratio (1 month)"
label var absent2per "Absence Ratio"
label var dabsent2per "$\Delta$ Absence Ratio"


hist absent2 if phase==1,by(G)
graph export "$dropbox/Madagascar_LLIN/presentation/schoolabsence_balance.pdf",replace

hist absent2 if phase==1&bound==1,by(G)
graph export "$dropbox/Madagascar_LLIN/presentation/schoolabsence_balance_b.pdf",replace

estpost ttest absent2   absent2per  absent2_onemonth   absent2per_onemonth if phase==1,by(G)
esttab using "$dropbox/Madagascar_LLIN/presentation/descriptiveattendance.tex",cell("mu_1(label(Untreated)) mu_2(label(Treated)) b(label(Diff)) se(label(s.e.)) N_1(label(Untreated region N)) N_2(label(Treated region N))") nonumber label replace
eststo clear

estpost ttest absent2   absent2per  absent2_onemonth   absent2per_onemonth  if phase==1&bound==1,by(G)
esttab using "$dropbox/Madagascar_LLIN/presentation/descriptiveattendance_b.tex",cell("mu_1(label(Untreated)) mu_2(label(Treated)) b(label(Diff)) se(label(s.e.)) N_1(label(Untreated region N)) N_2(label(Treated region N))") nonumber label replace
eststo clear


estpost ttest absent2   absent2per   if phase==0,by(G)
esttab using "$dropbox/Madagascar_LLIN/presentation/descriptiveattendancephase0.tex",cell("mu_1(label(Untreated)) mu_2(label(Treated)) b(label(Diff)) se(label(s.e.)) N_1(label(Untreated region N)) N_2(label(Treated region N))") nonumber label replace
eststo clear

estpost ttest absent2   absent2per   if phase==0&bound==1,by(G)
esttab using "$dropbox/Madagascar_LLIN/presentation/descriptiveattendancephase0_b.tex",cell("mu_1(label(Untreated)) mu_2(label(Treated)) b(label(Diff)) se(label(s.e.)) N_1(label(Untreated region N)) N_2(label(Treated region N))") nonumber label replace
eststo clear

***descriptiveattendance should use cluster robust.

reg absent2 G if phase==1,cluster(cluster1)
eststo
reg absent2per G if phase==1,cluster(cluster1)
eststo
reg absent2 G if phase==0,cluster(cluster1)
eststo
reg absent2per G if phase==0,cluster(cluster1)
eststo
esttab using $dropbox/Madagascar_LLIN/presentation/descriptive_dailyattend_presentation, tex se label replace ///
addnote("Class level cluster robust SEs. Estimation is by OLS."  ) star(+ .10 * .05  ** .01 *** .001) ///
mgroups("{\it Oct/09-Dec/09}" "{\it Sep/08-Oct/09}", pattern(1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}))


eststo clear
reg dabsent2 D if phase==2&classe33low==1,
eststo
reg dabsent2 D if phase==2&classe33low==0,
eststo
reg absent2 D if phase==2&classe33low==1,
eststo
reg absent2 D if phase==2&classe33low==0,
eststo
eststo clear
reg dabsent2 D if phase==2,cluster(cluster1)
eststo
reg absent2 D if phase==2,cluster(cluster1)
eststo
esttab using $dropbox/Madagascar_LLIN/presentation/olsabsence_dailyattend, tex se label replace ///
addnote("Class level cluster robust SEs. Estimation is by OLS." "Column 1 uses the difference between the 2nd phase and the 1st phase as LHS," "while column 2 uses the 2nd waive as LHS simply." ) star(+ .10 * .05  ** .01 *** .001) 


eststo clear



reg dabsent2 D Dandclasse34high  classe34high if phase==2,cluster(cluster1)
eststo
reg absent2 D Dandclasse34high  classe34high if phase==2,cluster(cluster1)
eststo
esttab using $dropbox/Madagascar_LLIN/presentation/olsabsence_dailyattend_hetero, tex se label replace ///
addnote("Class level cluster robust SEs. Estimation is by OLS." "Column 1 uses the difference between the 2nd phase and the 1st phase as LHS," "while column 2 uses the 2nd waive as LHS simply." ) star(+ .10 * .05  ** .01 *** .001) 


eststo clear
reg dabsent2per D if phase==2&classe33low==1,
eststo
reg dabsent2per D if phase==2&classe33low==0,		
eststo
reg absent2per D if phase==2&classe33low==1,
eststo
reg absent2per D if phase==2&classe33low==0,
eststo
eststo clear
reg dabsent2per D if phase==2,cluster(cluster1)
eststo
reg absent2per D if phase==2,cluster(cluster1)
eststo
esttab using $dropbox/Madagascar_LLIN/presentation/olsabsencep_dailyattend, tex se  label replace ///
addnote("Class level cluster robust SEs. Estimation is by OLS."  "Column 1 uses the difference between the 2nd phase and the 1st phase as LHS," "while column 2 uses the 2nd waive as LHS simply."  ) star(+ .10 * .05  ** .01 *** .001) 

label var absent2 " The Difference of Absence"

hist dabsent2, by(G)
graph export $dropbox/Madagascar_LLIN/presentation/distribution_dabsence_book.pdf,replace
/*

use dailyattend_forpaper_2nd.dta, clear

foreach x in "" "2"{
felsdvreg absent`x'  D cecolei* if time<td(1JUN2010)&annee==90,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  D cecolei* if time<td(1JUN2010)&annee==90&classe<=33,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  D cecolei* if time<td(1JUN2010)&annee==90&classe>33,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  D cecolei* if time<td(1JUN2010)&annee==90&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  D cecolei* if time<td(1JUN2010)&annee==90&classe<=33&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  D cecolei* if time<td(1JUN2010)&annee==90&classe>33&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo


felsdvreg absent`x'  Dandmonth* cecolei* if time<td(1JUN2010)&annee==90,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  Dandmonth* cecolei* if time<td(1JUN2010)&annee==90&classe<=33,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  Dandmonth* cecolei* if time<td(1JUN2010)&annee==90&classe>33,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  Dandmonth* cecolei* if time<td(1JUN2010)&annee==90&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  Dandmonth* cecolei* if time<td(1JUN2010)&annee==90&classe<=33&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  Dandmonth* cecolei* if time<td(1JUN2010)&annee==90&classe>33&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo



esttab using dailyabsent`x'ols_2nd90.csv, p  label addnote(1-3 use all schools and 4-6 only use seaside schools. ) replace mtitle(full "1st-3rd" "4th-" full "1st-3rd" "4th-")

eststo clear

felsdvreg absent`x'  D cecole*andmonth* if time<td(1JUN2010),ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  D cecole*andmonth* if time<td(1JUN2010)&classe<=33,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  D cecole*andmonth* if time<td(1JUN2010)&classe>33,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  D cecole*andmonth* if time<td(1JUN2010)&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  D cecole*andmonth* if time<td(1JUN2010)&classe<=33&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  D cecole*andmonth* if time<td(1JUN2010)&classe>33&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo




felsdvreg absent`x'  Dandmonth* cecole*andmonth* if time<td(1JUN2010),ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  Dandmonth* cecole*andmonth* if time<td(1JUN2010)&classe<=33,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  Dandmonth* cecole*andmonth* if time<td(1JUN2010)&classe>33,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  Dandmonth* cecole*andmonth* if time<td(1JUN2010)&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  Dandmonth* cecole*andmonth* if time<td(1JUN2010)&classe<=33&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent`x'  Dandmonth* cecole*andmonth* if time<td(1JUN2010)&classe>33&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo



esttab using dailyabsent`x'ols_2nd.csv, p  label addnote(1-3 use all schools and 4-6 only use seaside schools. ) replace mtitle(full "1st-3rd" "4th-" full "1st-3rd" "4th-")
eststo clear
}
/*

felsdvreg absent  D Dandtime* if time<td(1JUN2010),ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent  D Dandtime* if time<td(1JUN2010)&classe<=33,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent  D Dandtime* if time<td(1JUN2010)&classe>33,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo

felsdvreg absent  D Dandtime* if time<td(1JUN2010)&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent  D Dandtime* if time<td(1JUN2010)&classe<=33&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent  D Dandtime* if time<td(1JUN2010)&classe>33&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo


esttab using dailyabsentols_dailyeffect_2nd.csv, p  label addnote(1-3 use all schools and 4-6 use seaside schools. ) replace mtitle(full "1st-3rd" "4th-" full "1st-3rd" "4th-")
eststo clear

felsdvreg absent  Dandtime* if time<td(1JUN2010),ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent  Dandtime* if time<td(1JUN2010)&classe<=33,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent  Dandtime* if time<td(1JUN2010)&classe>33,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo

felsdvreg absent  Dandtime* if time<td(1JUN2010)&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent  Dandtime* if time<td(1JUN2010)&classe<=33&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo
felsdvreg absent  Dandtime* if time<td(1JUN2010)&classe>33&bound==1,ivar(ideleve) jvar(time) xb(xb) peff(phat) feff(fhat) res(res) mover(mover) mnum(mnum) pobs(pobs) group(group) 
eststo


esttab using dailyabsentols_dailyeffect2_2nd.csv, p  label addnote(1-3 use all schools and 4-6 use seaside schools. ) replace mtitle(full "1st-3rd" "4th-" full "1st-3rd" "4th-")
eststo clear


/*xtlogit absent Dandmonth1-Dandmonth12 if time<td(1JUN2010)&bound==1,fe 
eststo
xtlogit absent Dandmonth1-Dandmonth12 if time<td(1JUN2010)&classe<=33&bound==1,fe 
eststo
xtlogit absent Dandmonth1-Dandmonth12 if time<td(1JUN2010)&classe>33&bound==1,fe
eststo

xtlogit absent Dandmonth1-Dandmonth12 if time<td(1JUN2010)&time>=td(1SEP2009)&bound==1,fe 
eststo
xtlogit absent Dandmonth1-Dandmonth12 if time<td(1JUN2010)&time>=td(1SEP2009)&classe<=33&bound==1,fe 
eststo
xtlogit absent Dandmonth1-Dandmonth12 if time<td(1JUN2010)&time>=td(1SEP2009)&classe>33&bound==1,fe
eststo

esttab using dailyabsentlogit_b_2nd.tex, p  label addnote(1-3 use Sep 2008 - May 2010 and 4-6 use Sep 2009 - May 2010. ) replace mtitle(full "1st-3rd" "4th-" full "1st-3rd" "4th-")
eststo clear 
*/ 


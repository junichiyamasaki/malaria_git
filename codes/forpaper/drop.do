*cd $localdata/Malaria/1st
*do combine
*cd $localdata/Malaria/2nd
*do combine_2nd
use data/intermediate/forpaper/allcheck.dta,clear
gen second = (phase==2)
tab second
egen maxsecond = max(second),by(miid09)

gen third = (phase==3)
egen maxthird = max(third),by(miid09)

gen seconddrop = (maxsecond == 0)
gen thirddrop = (maxthird == 0)

label var hhsize "HH size"
label var thirddrop "Dropped at the 3rd"
label var seconddrop "Dropped at the 2nd"
label var mqnid "Sleep in a Net"
label var absence "Absence Last Month"

gen anydrop = 0 
replace anydrop = 1 if seconddrop==1|thirddrop==1



eststo clear



ivreg2 anydrop rdt if phase==1&underteen==1,cluster(migrap) small
eststo

ivreg2 anydrop mqnid if phase==1&underteen==1,cluster(migrap) small
eststo

ivreg2 anydrop absence if phase==1&underteen==1,cluster(migrap) small
eststo

ivreg2 anydrop hhsize if phase==1&underteen==1,cluster(migrap) small
eststo

ivreg2 anydrop rdt mqnid absence hhsize if phase==1&underteen==1,cluster(migrap) small
eststo
estadd scalar F_test = e(F)

esttab using draft/drop_2nd3rd_child.tex, star(+ .10 * .05  ** .01 *** .001)  tex replace   se  addnote(Village-level cluster robust SEs.) label stats(N F_test)
eststo clear



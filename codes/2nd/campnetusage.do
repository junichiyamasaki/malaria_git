
cd ..
cd 2nd 
use e_MOUSTIQUAIRE_2nd,clear 
gen campnet=0
replace campnet=1 if (h5==2&(h6==1|h6==3)&h4==2009&h4ax==12)|(h5==2&(h6==1|h6==3)&h4==2010&h4ax==1)
gen campnetuse=0
replace campnetuse=1 if campnet==1&(h71!=.|h72!=.|h73!=.|h74!=.|h75!=. )
gen campnetnotuse=0
replace campnetnotuse=1 if campnet==1&(h71==.&h72==.&h73==.&h74==.&h75==. )
egen bedmember=rownonmiss(h71 h72 h73 h74 h75)
collapse (sum) campnetuse campnetnotuse,by(mhid)
save campnetusage_2nd,replace

*campnetが使われていない家計に寝ていない人がどれだけいるのか

use e_combine_2nd,clear
gen notmqnid=(mqnid==0&r8==1)
gen notmqnidandteen=(mqnid==0&r8==1&r4>=13&r4<=19)
collapse (sum) notmqnid notmqnidandteen (max) mi1 migrap, by(mhid)
merge m:1 mhid using campnetusage_2nd,nogenerate
label var campnetnotuse "The number of distributed nets which no one used last night  for each household (2nd)"
label var notmqnid "The number of member who did not use a mosquito net last night (2nd)"
gen campnetnotuse01=(campnetnotuse>=1)
replace campnetnotuse01=. if mi1!=170|campnet==0
label define campnetnotuse01 0 "All distributed nets are used" 1 "Some distributed nets are not used"
label value  campnetnotuse01 campnetnotuse01
estpost tabulate notmqnid campnetnotuse01 if mi1==170
esttab using campnetandnotmqnid.csv, cell("b(label())" ) unstack noobs label nonumber nomtitle collabels(none)  eqlabels(`e(eqlabels)', lhs("# of members not using nets")) title(Does not each household use distributed nets even if some members do not use nets? )     replace note(All variable is about the second phase and treated group who received at least one nets in the campaign. )  

exit
*更新に使われたか、新しい人に使われたか
use e_panel_2nd,clear
merge m:1 mhid using campnetusage_2nd,nogenerate
sort miid09 phase
gen lmqnid=L.mqnid
label define lmqnid 0 "Not use (1st)"  1 "Use (1st)"
label value lmqnid lmqnid
gen campmqnid2=campmqnid
replace campmqnid2=-1 if mqnid==0&phase==2
label define campmqnid2 -1 "Not Use (2nd)"  0 "Use a non-distibuted net (2nd)" 1 "Use a distributed net(2nd)" 
label value campmqnid2 campmqnid2
estpost tabulate  lmqnid  campmqnid2 if mi1==170&(campnet!=.&campnet>0)
esttab using campnetandlmqnid.csv, cell("b(label())" ) unstack noobs label nonumber nomtitle eqlabels(`e(eqlabels)') collabels(none) title(Who uses distributed nets?) note(We used treated group who received at least one nets in the campaign only. ) replace
//Note that Use (1st) means  he used mosquito net at the night before the  interview day in the first phase, while Not use (1st) means he did not. Used a non-distibuted net (2nd) means he used a net the night before the interview day, but it is not nets distributed in the campaign.   Used a distibuted net (2nd) means he used distributed nets  the night before the interview day.


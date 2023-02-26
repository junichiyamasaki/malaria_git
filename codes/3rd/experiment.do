use e_panel_3rd,clear

replace mqnid=. if r8==2
gen mqnid1st=L2.mqnid
gen mqnid2nd=L.mqnid
keep if phase==3
keep miid mqnid1st mqnid2nd

save mqnidrecord_3rd,replace

use e_combine_3rd,clear
merge m:1 miid using mqnidrecord_3rd,gen(mqnidrecord)
erase mqnidrecord_3rd.dta

gen teen=.
replace teen=1 if r4>12&r4<20
replace teen=0 if (r4<=12|r4>=20)&r4!=.
gen floor=.
replace floor=1 if bedid==2
replace floor=0 if bedid==1


replace mqnid=. if r8==2

gen teennotmqn=(teen==1&mqnid==0)
gen teennotmqnbed=(teen==1&bedmqn==2)
gen teennotfloornotmqnbed=(teen==1&bedmqn==2&floor==1)
egen teennotmqnhh=total(teennotmqn), by(mhid)
egen teennotmqnbedhh=total(teennotmqnbed), by(mhid)
egen teenhh=total(teen),by(mhid)
egen floorhh=total(floor),by(mhid)

gen notbedmqn=.
replace notbedmqn=1 if bedmqn==2
replace notbedmqn=0 if bedmqn==1
egen notbedmqnhh=max(notbedmqn),by(mhid)

gen teen01=(teenhh>0&teenhh<99)
gen floor01=(floorhh>0&floorhh<99)

keep if (migrap==3|migrap==4|migrap==13|migrap==14|migrap==15)
keep if r0dx==1
codebook mhid if  teennotmqn>0&(migrap==3|migrap==4|migrap==13|migrap==14|migrap==15)
codebook mhid if  teenhh>0&teennotmqn==0&(migrap==3|migrap==4|migrap==13|migrap==14|migrap==15)

codebook mhid if  teennotmqnbed>0&(migrap==3|migrap==4|migrap==13|migrap==14|migrap==15)
codebook mhid if  teenhh>0&teennotmqnbed==0&(migrap==3|migrap==4|migrap==13|migrap==14|migrap==15)

codebook mhid 
tab G if (notbedmqnhh==1|teenhh>0)&r4>12
tab bedmqn if (notbedmqnhh==1|teenhh>0)&r4>12
tab mqnid1st mqnid2nd  if (notbedmqnhh==1|teenhh>0)&r4>12

keep miloc mhid miid mi3dx r0bx r2 r3 r4 bedmqn mqnid1st mqnid2nd mhlat mhlon migrap notbedmqnhh teenhh
bysort migrap: egen lat1=pctile(mhlat),p(25) 
bysort migrap: egen lat2=pctile(mhlat),p(45) 
bysort migrap: egen lat3=pctile(mhlat),p(75) 

bysort migrap: egen latm=median(mhlat)

replace mhlat=mhlat+10^(-7)*(-1+2*runiform()) if mhlat==latm

gen group=.
replace group=1 if mhlat<=lat1
replace group=2 if mhlat>lat1&mhlat<=lat2
replace group=3 if mhlat>lat2&mhlat<=lat3
replace group=4 if mhlat>lat3

gen targethh=0
replace targethh=1 if notbedmqnhh>0
replace targethh=1 if teenhh>0


gen important=bedmqn 
label define bedmqn 1 "Yes" 2 "No"
label value bedmqn bedmqn

drop if r4<=12
replace group=1 if group==2
replace group=2 if group==3
replace group=2 if group==4

 outsheet miloc group miid mi3dx r0bx r2 r4  if targethh==1&group==1 using C:\Users\J.YAMASAKI\Documents\malaria\4th\list1.csv,      comma   replace

 outsheet miloc group miid mi3dx r0bx r2 r4 if targethh==1&group==2 using C:\Users\J.YAMASAKI\Documents\malaria\4th\list2.csv,      comma   replace


forvalues i=1/2{

graph twoway scatter mhlat mhlon if group==`i'&targethh==1&migrap!=14&migrap<=4, by(miloc, rescale) mlabel(mhid)
graph export C:\Users\J.YAMASAKI\Documents\malaria\4th\mapnorth`i'.wmf,replace

graph twoway scatter mhlat mhlon if group==`i'&targethh==1&migrap!=14&migrap>4, by(miloc, rescale) mlabel(mhid)
graph export C:\Users\J.YAMASAKI\Documents\malaria\4th\mapsouth`i'.wmf,replace
}
exit

graph twoway scatter mhlat mhlon if migrap==3&group==`i'&targethh==1,mlabel(mhid)
graph export C:\Users\J.YAMASAKI\Documents\malaria\4th\3migrap`i'.png,replace

graph twoway scatter mhlat mhlon if migrap==4&group==`i'&targethh==1,mlabel(mhid)
graph export C:\Users\J.YAMASAKI\Documents\malaria\4th\4migrap`i'.png,replace

graph twoway scatter mhlat mhlon if migrap==13&group==`i'&targethh==1,mlabel(mhid)
graph export C:\Users\J.YAMASAKI\Documents\malaria\4th\13migrap`i'.png,replace

graph twoway scatter mhlat mhlon if migrap==15&group==`i'&targethh==1,mlabel(mhid)
graph export C:\Users\J.YAMASAKI\Documents\malaria\4th\15migrap`i'.png,replace
}
exit
graph twoway scatter mhlat mhlon if migrap==4&group==1 || scatter mhlat mhlon if migrap==4&group==2|| scatter mhlat mhlon if migrap==4&group==3|| scatter mhlat mhlon if migrap==4&group==4&targethh==1,mlabel(mhid)

collapse (max) notbedmqnhh teennotfloornotmqnbed teennotmqnhh mhlat mllon teennotmqnbedhh teen01 floor01 migrap, by(mhid)

exit
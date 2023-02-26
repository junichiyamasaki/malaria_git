
use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\1st\e_MENAGE,clear
gen phase=1
set more off
append using C:\Users\J.YAMASAKI\Documents\stata11data\malaria\2nd\e_MENAGE_2nd ,generate(_2nd)

replace phase=2 if _2nd==1

replace mhid=mhid09 if phase==2


merge m:1 mhid using C:\Users\J.YAMASAKI\Documents\stata11data\malaria\1st\distance2border, generate(distance_merge)

gen seg=(seg_east==1)
replace seg=2 if seg_mideast==1
replace seg=3 if seg_midwest==1
replace seg=4 if seg_west==1

gen G=(mh1==170)
replace G=0 if mh1==50

gen nofnet=h2
replace nofnet=0 if h1==2

gen nofnet2=h3
replace nofnet2=0 if h1==2
egen mmhlat=mean(mhlat) ,by(phase)
egen mmhlon=mean(mhlon) ,by(phase)

gen mhlatc=mhlat-mmhlat
gen mhlonc=mhlon-mmhlon



eststo clear
foreach i of numlist 500 750 1000 1250 1500 3000{
reg  nofnet (c.mhlatc c.mhlonc)##(c.mhlatc c.mhlonc)##(c.mhlatc c.mhlonc)##i.G G i.seg if phase==1&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo

reg  nofnet (c.mhlatc c.mhlonc)##(c.mhlatc c.mhlonc)##(c.mhlatc c.mhlonc)##i.G G i.seg if phase==2&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo
}
esttab using C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\forpaper\rd_g_h2.csv,  dropped indicate( *.mh* mhlatc mhlonc)  replace   mtitles("500m1st" "500m2nd" "750m1st""750m2nd""1000m1st""1000m2nd""1250m1st""1250m2nd""1500m1st""1500m2nd""3000m1st""3000m2nd") p

eststo clear

foreach i of numlist 500 750 1000 1250 1500 3000{
reg  nofnet   i.G##c.near_dist  i.seg if phase==1&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo
reg  nofnet  i.G##c.near_dist  i.seg if phase==2&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo
}
esttab using C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\forpaper\rd_l_h2.csv,  dropped indicate( )  replace   mtitles("500m1st" "500m2nd" "750m1st""750m2nd""1000m1st""1000m2nd""1250m1st""1250m2nd""1500m1st""1500m2nd""3000m1st""3000m2nd") p


eststo clear
foreach i of numlist 500 750 1000 1250 1500 3000{
reg  nofnet2 (c.mhlatc c.mhlonc)##(c.mhlatc c.mhlonc)##(c.mhlatc c.mhlonc)##i.G G i.seg if phase==1&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo
reg  nofnet2 (c.mhlatc c.mhlonc)##(c.mhlatc c.mhlonc)##(c.mhlatc c.mhlonc)##i.G G i.seg if phase==2&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo
}
esttab using C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\forpaper\rd_g_h3.csv,  dropped indicate( *.mh* mhlatc mhlonc)  replace   mtitles("500m1st" "500m2nd" "750m1st""750m2nd""1000m1st""1000m2nd""1250m1st""1250m2nd""1500m1st""1500m2nd""3000m1st""3000m2nd") p

eststo clear
foreach i of numlist 500 750 1000 1250 1500 3000{
reg  nofnet2   i.G##c.near_dist  i.seg if phase==1&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo

reg  nofnet2  i.G##c.near_dist  i.seg if phase==2&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo
}
esttab using C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\forpaper\rd_l_h3.csv,  dropped indicate( )  replace   mtitles("500m1st" "500m2nd" "750m1st""750m2nd""1000m1st""1000m2nd""1250m1st""1250m2nd""1500m1st""1500m2nd""3000m1st""3000m2nd") p


use  C:\Users\J.YAMASAKI\Documents\stata11data\malaria\2nd\pre_2nd, clear
eststo clear 

reg campnet i.hhsize L.mqnhh L.noftorn i.mhgrap if D==1&r3==1&campnet!=0,vce(cluster mhgrap)
eststo
probit campnet01 i.hhsize L.mqnhh L.noftorn i.mhgrap if D==1&r3==1,vce(cluster mhgrap)
*eststo
*esttab using campnet.csv, dropped indicate( )  replace



use C:\Users\J.YAMASAKI\Documents\stata11data\malaria\2nd\e_panel_2nd,clear
gen lmqnid=L.mqnid
drop if phase==1
keep miid09 lmqnid
rename miid09 miid
save lmqnid_2nd,replace

use C:\Users\J.YAMASAKI\Documents\stata11data\malaria\1st\e_combine, clear
append using C:\Users\J.YAMASAKI\Documents\stata11data\malaria\2nd\e_combine_2nd ,generate(_2nd)


replace mhid=mhid09 if phase==2
replace miid=miid09 if phase==2


merge m:1 mhid using C:\Users\J.YAMASAKI\Documents\stata11data\malaria\1st\distance2border, generate(distance_merge)
gen G=(mh1==170)
replace G=0 if mh1==50

gen seg=(seg_east==1)
replace seg=2 if seg_mideast==1
replace seg=3 if seg_midwest==1
replace seg=4 if seg_west==1
gen abs_dist=abs(near_dist)

egen mmhlat=mean(mhlat) ,by(phase)
egen mmhlon=mean(mhlon) ,by(phase)

gen mhlatc=mhlat-mmhlat
gen mhlonc=mhlon-mmhlon



eststo clear
foreach i of numlist 500 750 1000 1250 1500 3000{
reg  mqnid (c.mhlatc c.mhlonc)##(c.mhlatc c.mhlonc)##(c.mhlatc c.mhlonc)##i.G  i.seg if phase==1&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo


reg  mqnid (c.mhlatc c.mhlonc)##(c.mhlatc c.mhlonc)##(c.mhlatc c.mhlonc)##i.G  i.seg if phase==2&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo

}
esttab using rd_g_mqnid.csv,  dropped indicate( *.mh* mhlatc mhlonc)  replace   mtitles("500m1st"  "500m2nd" "750m1st""750m2nd""1000m1st""1000m2nd""1250m1st""1250m2nd""1500m1st""1500m2nd""3000m1st""3000m2nd") p


eststo clear
foreach i of numlist 500 750 1000 1250 1500 3000{
reg  mqnid   i.G##c.near_dist  i.seg if phase==1&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo

reg  mqnid i.G c.near_dist  i.seg if phase==1&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo


reg  mqnid i.G i.seg if phase==1&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo

reg  mqnid i.G##c.near_dist  i.seg if phase==2&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo

reg  mqnid i.G c.near_dist  i.seg if phase==2&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo

reg  mqnid i.G i.seg if phase==2&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo
}
esttab using rd_l_mqnid.csv,  dropped indicate( )  replace   mtitles("500m1st" "500m1st" "500m1st" "500m2nd" "500m2nd" "500m2nd" "750m1st""750m1st""750m1st""750m2nd""750m2nd""750m2nd""1000m1st""1000m1st""1000m1st""1000m2nd""1000m2nd""1000m2nd""1250m1st""1250m1st""1250m1st""1250m2nd""1250m2nd""1250m2nd""1500m1st""1500m1st""1500m1st""1500m2nd""1500m2nd""1500m2nd""3000m1st""3000m1st""3000m1st""3000m2nd""3000m2nd""3000m2nd") p


use C:\Users\J.YAMASAKI\Documents\stata11data\malaria\2nd\e_panel_2nd,clear
gen mhidnew=mhid
replace mhid =mhid09
merge m:1 mhid using C:\Users\J.YAMASAKI\Documents\stata11data\malaria\1st\distance2border, generate(distance_merge)
tsset miid09 phase


gen seg=(seg_east==1)
replace seg=2 if seg_mideast==1
replace seg=3 if seg_midwest==1
replace seg=4 if seg_west==1
gen abs_dist=abs(near_dist)

egen mmhlat=mean(mhlat) ,by(phase)
egen mmhlon=mean(mhlon) ,by(phase)

gen mhlatc=mhlat-mmhlat
gen mhlonc=mhlon-mmhlon

eststo clear

foreach i of numlist 500 750 1000 1250 1500 3000{

reg  mqnid (c.mhlatc c.mhlonc)##(c.mhlatc c.mhlonc)##(c.mhlatc c.mhlonc)##i.G  i.seg if L.mqnid==0&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo


reg  mqnid i.G##c.near_dist  i.seg if L.mqnid==0&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo

reg  mqnid i.G c.near_dist  i.seg if L.mqnid==0&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo

reg  mqnid i.G  i.seg if L.mqnid==0&abs(near_dist)<=`i' , vce(cluster mhgrap)
eststo

}
esttab using rd_lmqnid.csv,  dropped   replace   mtitles("500mglobal" "500mlocal" "500mlocal" "500mlocal""750mglobal""750mlocal""750mlocal""750mlocal""1000mglobal""1000mlocal""1000mlocal""1000mlocal""1250mglobal""1250mlocal""1250mlocal""1250mlocal""1500mglobal""1500mlocal""1500mlocal""1500mlocal""3000mglobal""3000mlocal""3000mlocal""3000mlocal") p indicate( *.mh* mhlatc mhlonc) 


use C:\Users\J.YAMASAKI\Documents\stata11data\malaria\2nd\e_panel_2nd ,clear

replace mhid=mhid09

merge m:1 mhid using C:\Users\J.YAMASAKI\Documents\stata11data\malaria\1st\distance2border, generate(distance_merge)

gen seg=(seg_east==1)
replace seg=2 if seg_mideast==1
replace seg=3 if seg_midwest==1
replace seg=4 if seg_west==1



egen mmhlat=mean(mhlat) ,by(phase)
egen mmhlon=mean(mhlon) ,by(phase)

gen mhlatc=mhlat-mmhlat
gen mhlonc=mhlon-mmhlon
sort miid09 phase
gen notmqnhh=hhsize-mqnhh
gen notmqnhhother=notmqnhh
replace notmqnhhother=notmqnhh-1 if mqnid==0
gen tornmqnid=mqnid
replace tornmqnid=0 if ntmqnid==1
gen ltornmqnid=L.tornmqnid
gen lllitnid=L.llitnid
gen lmqnid=L.mqnid
label var notmqnhhother "The number of other members who do not use a net"
gen lnotmqnhhother=L.notmqnhhother 
label var lnotmqnhhother "The number of other members who do not use a net in the last phase"
label var lllitnid "LLITN use in the last phase"
label var lmqnid "Net use in the last phase"
label var ltornmqnid "Torn net use in the last phase"



gen lnotmqnhhother_lllitnid=L.notmqnhhother*lllitnid
gen lnotmqnhhother_lmqnid=L.notmqnhhother*lmqnid
gen lnotmqnhhother_ltornmqnid=L.notmqnhhother*ltornmqnid
gen teen=.
replace teen=0 if (r4<13|r4>19)&r4!=.
replace teen=1 if r4>=13&r4<=19
gen campnethhsize=campnet/hhsize
gen hhsize3=1
replace hhsize3=2 if hhsize>=4&hhsize<7
replace hhsize3=3 if hhsize>=7&hhsize<10
replace hhsize3=4 if hhsize>=10&hhsize<13
replace hhsize3=5 if hhsize>=13&hhsize<16
gen hhsize4=1
replace hhsize4=2 if hhsize>=5&hhsize<9
replace hhsize4=3 if hhsize>=9&hhsize<13
replace hhsize4=4 if hhsize>=13&hhsize<17
gen campnethhsize3=campnet/hhsize3
gen campnethhsize4=campnet/hhsize4
gen female=(r2==2)
label var lnotmqnhhother_lllitnid "No. of other no-use members in the last phase*LLITN use in the last phase"
label var lnotmqnhhother_lmqnid "No. of other no-use members in the last phase*Net use in the last phase"
label var lnotmqnhhother_ltornmqnid "No. of other no-use members in the last phase*Torn net use in the last phase"
label var campnethhsize "No. of received net in the campaign per capita"
label var campnethhsize3 "No. of received net in the campaign per 3 members"
label var teen "Teenager"
label var female "Female"
label var near_dist "Distance from the boarder"
eststo clear

foreach i of numlist 500 750 1000 1250 1500 3000{
reg campmqnid lmqnid lllitnid ltornmqnid lnotmqnhhother_lmqnid teen  campnethhsize3 near_dist  if campnethhsize>0&abs(near_dist)<=`i',vce(cluster migrap) noomitted noconstant
eststo

reg campmqnid lmqnid lllitnid ltornmqnid lnotmqnhhother_lmqnid teen  campnethhsize3 near_dist  if campnethhsize3<=1&campnethhsize>0&abs(near_dist)<=`i',vce(cluster migrap) noomitted noconstant
eststo
}
esttab using C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\forpaper\campnetid.csv,  dropped indicate( near_dist)  replace   mtitles("500m" "500m" "750m" "750m"  "1000m" "1000m"  "1250m" "1250m" "1500m""1500m" "3000m""3000m")   label  varwidth(100) addnotes(Cluster-robust (village) standard error. We only used the households which received at least one net in the campaign. Even columns excludes household which received more than one nets per member.) se
eststo clear

foreach i of numlist 500 750 1000 1250 1500 3000{
reg campmqnid lmqnid lllitnid ltornmqnid lnotmqnhhother_lmqnid teen  campnethhsize4 near_dist  if campnethhsize>0&abs(near_dist)<=`i',vce(cluster migrap) noomitted noconstant
eststo

reg campmqnid lmqnid lllitnid ltornmqnid lnotmqnhhother_lmqnid teen  campnethhsize4 near_dist  if campnethhsize4<=1&campnethhsize>0&abs(near_dist)<=`i',vce(cluster migrap) noomitted noconstant
eststo
}
esttab using C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\forpaper\campnetid4.csv,  dropped indicate( near_dist)  replace   mtitles("500m" "500m" "750m" "750m"  "1000m" "1000m"  "1250m" "1250m" "1500m""1500m" "3000m""3000m")   label  varwidth(100) addnotes(Cluster-robust (village) standard error. We only used the households which received at least one net in the campaign.) se


*externality

exit
lnotmqnhhother_lllitnid lnotmqnhhother_ltornmqnid  seg_east seg_west seg_mideast seg_midwest
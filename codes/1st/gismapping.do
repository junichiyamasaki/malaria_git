* For gis mapping HH level
use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\1st\e_combine, clear
gen under5rdt=rdt*(r4<=5)
gen under5=(r4<=5)

collapse (sum) rdt under5rdt under5 (mean) hhsize migrap mhlon mhlat, by(mhid)
label var rdt "The number of malaria infected member "
label var under5 "The number of under 5 years old member"
label var under5rdt "The number of infected and under 5 years old member"
label var hhsize "Household size"
label var migrap "cluster"
label var mhlon "Longitude"
label var mhlat "Latitude"
label var mhid "Household ID"
rename rdt rdtHH
rename under5rdt under5rdtHH
rename under5 under5HH

save HHlevel_1st,replace

use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\2nd\e_combine_2nd, clear
gen under5rdt=rdt*(r4<=5)
gen under5=(r4<=5)

drop if mh3ax!=1

collapse (sum) rdt under5rdt under5 (mean) mhid09 hhsize migrap mhlon mhlat, by(mhid)
label var rdt "The number of malaria infected member "
label var under5 "The number of under 5 years old member"
label var under5rdt "The number of infected and under 5 years old member"
label var hhsize "Household size"
label var migrap "cluster"
label var mhlon "Longitude"
label var mhlat "Latitude"
label var mhid09 "Household ID in the 1st"
label var mhid "Household ID"
rename rdt rdtHH
rename under5rdt under5rdtHH
rename under5 under5HH
save HHlevel_2nd,replace
exit
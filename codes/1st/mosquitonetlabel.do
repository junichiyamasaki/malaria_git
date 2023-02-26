use MOUSTIQUAIRE ,clear
label var mq1 "common code"
label var mqcom "common name"
label var mq2 "code fokontany"
label var mqfkt "name fokontany"
label var mqgrap "cluster code (city / local)"
label var mqloc "name the place"
label var mq3 "household number"
label var mhid "household identification"
label var mqid "individual identification"
label var mqnb "number nets"
label var mtq "net number"
label var h4 "year of obtaining the net "
label var h5 "mosquito net bought or received free"
label var h6 "where did you get the net"
label var h71 "line no. 1 to the individual who slept the night before under the net"
label var h72 "line no. 2 to the individual who slept the night before under the net"
label var h73 "line no. 3 of the individual who slept the night before under the net"
label var h74 "line no. 4 to the individual who slept the night before under the net"
label var h75 "line no. 5 to the individual who slept the night before under the net"
label var h8 "state of the net"
label var h9 "torn mosquito net"
label var h10 "brand of the net "
label var h11 "treated mosquito net over the last 6 months"
label var h12 "frequency of cleaning the screen"
label var h13 "using screen worn"
label var mqfin "end section"


label define h4 9998 "dk" 9999 "missing"
label define h5 1 "purchased" 2 "free" 9 "missing"
label define h6 1 "health center" 2 "pharmacy, shop, ngo" 3 "community house" 4 "delivered by ngos" 5 "delivered by midwife" 6 "parents/friends" 7 "other" 8 "do not know" 9 "missing"
label define  h8 1 "good" 2 "medium" 3 "poor" 9 "missing"
 label define h9 1 "yes" 2 "no" 9 "missing"  
label define h10 1 "olyset (net permanent)" 2 "supermanet (net permanent)" 3 "super moustiquaire (net permanent)" 4 "milay (net permanent)" 5 "other (net permanent)" 6 "any mark (pre-treated mosquito net)" 7 "other (pre-treated mosquito net)" 8 "traditional" 9 "dk"
label define  h11 1 "yes" 2 "no" 9 "missing"
 label define h12 1 "per month" 2 "2 times a year" 3 "per year" 4 "depends on the dirt" 5 "no" 8 "do not know" 9 "missing"
 label define h13 1 "throw" 2 "given to someone" 3 "used for something else" 4 "other" 9 "missing"

label values h4 h4
label values h5 h5
label values h6 h6
label values h8 h8
label values h9 h9
label values h10 h10
label values h11 h11
label values h12 h12
label values h13 h13

gen phase=1

foreach v of varlist h4 h5 h6 h8 h9 h10 h11 h12 h13 {
replace `v'=. if `v'=="missing":`v'
}

save e_MOUSTIQUAIRE,replace
exit
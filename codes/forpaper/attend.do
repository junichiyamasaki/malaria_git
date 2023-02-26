use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\2nd\attendancedata_2nd.dta,clear
*distribution was held on Dec and Jun
foreach x in  0 1  8 9{
gen phase1_`x'=sept_`x'+oct_`x'+nov_`x'+dec_`x'
gen phase2_`x'=jan_`x'+fev_`x'+mar_`x'+avr_`x'+mai_`x'+juin_`x'
gen diff_`x'=phase2_`x'-phase1_`x'
gen diff2_`x'=jan_`x'-dec_`x'
gen diff4_`x'=jan_`x'+fev_`x'-dec_`x'-nov_`x'

}

foreach x in sept oct nov dec jan fev mar avr mai juin{
gen prop`x'=`x'_0/(`x'_0+`x'_1)
}

gen prop= phase2_0/(phase2_0+phase2_1)-phase1_0/(phase1_0+phase1_1)
gen prop2=jan_0/(jan_0+jan_1)-dec_0/(dec_0+dec_1)
gen prop4=(jan_0+fev_0)/(jan_0+jan_1+fev_0+fev_1)-(dec_0+nov_0)/(dec_0+dec_1+nov_0+nov_1)

foreach x in jan fev mar avr mai juin{
gen prop`x'minus=prop`x'-propdec
}



gen epph=(classe>30&classe!=.)
gen eppl=(classe<30)


gen Gandclass1=(G==1&(classe==11|classe==12))
gen Gandclass2=(G==1&classe==22)
gen Gandclass3=(G==1&(classe==33|classe==34))
gen Gandclass4=(G==1&(classe==44|classe==45))
gen Gandclass5=(G==1&(classe==55))

gen Gandclass1b=(G==1&(classe==11))
gen Gandclass2b=(G==1&(classe==12|classe==22))
gen Gandclass3b=(G==1&(classe==33))
gen Gandclass4b=(G==1&(classe==44|classe==34))
gen Gandclass5b=(G==1&(classe==55|classe==45))

gen class1b=(classe==11)
gen class2b=(classe==12|classe==22)
gen class3b=(classe==33)
gen class4b=(classe==44|classe==34)
gen class5b=(classe==55|classe==45)


gen class1=(classe==11|classe==12)
gen class2=(classe==22)
gen class3=(classe==33|classe==34)
gen class4=(classe==44|classe==45)
gen class5=(classe==55)
foreach x in  1 2 3 4 5{
label var class`x' "EPP Class `x'"
label var Gandclass`x' "G $\times$ EPP Class `x'"
}


gen classe2=(class1==1)

gen classe2b=(class1b==1)
foreach x in   2 3 4 5{
replace classe2=`x' if class`x'==1
replace classe2b=`x' if class`x'b==1
}

drop if classe==88
egen ecocla=group(cecole classe2)

egen ecoclab=group(cecole classe2b)

gen bound=(cecole<=3)

reg diff_0 Gandclass1 Gandclass2 Gandclass3 Gandclass4 Gandclass5 class1 class2 class3 class4 class5, cluster(ecocla) noconstant
reg diff2_0 Gandclass1 Gandclass2 Gandclass3 Gandclass4 Gandclass5 class1 class2 class3 class4 class5, cluster(ecocla) noconstant
reg diff4_0 Gandclass1 Gandclass2 Gandclass3 Gandclass4 Gandclass5 class1 class2 class3 class4 class5, cluster(ecocla) noconstant
reg diff_1 Gandclass1 Gandclass2 Gandclass3 Gandclass4 Gandclass5 class1 class2 class3 class4 class5, cluster(ecocla) noconstant
reg diff2_1 Gandclass1 Gandclass2 Gandclass3 Gandclass4 Gandclass5 class1 class2 class3 class4 class5, cluster(ecocla) noconstant
reg diff4_1 Gandclass1 Gandclass2 Gandclass3 Gandclass4 Gandclass5 class1 class2 class3 class4 class5, cluster(ecocla) noconstant

eststo clear
reg prop Gandclass1 Gandclass2 Gandclass3 Gandclass4 Gandclass5 class1 class2 class3 class4 class5, cluster(ecocla) noconstant
eststo 
reg prop2 Gandclass1 Gandclass2 Gandclass3 Gandclass4 Gandclass5 class1 class2 class3 class4 class5, cluster(ecocla) noconstant
eststo 
reg prop4 Gandclass1 Gandclass2 Gandclass3 Gandclass4 Gandclass5 class1 class2 class3 class4 class5, cluster(ecocla) noconstant
eststo
reg prop Gandclass1 Gandclass2 Gandclass3 Gandclass4 Gandclass5 class1 class2 class3 class4 class5, cluster(cecole) noconstant
eststo 
reg prop2 Gandclass1 Gandclass2 Gandclass3 Gandclass4 Gandclass5 class1 class2 class3 class4 class5, cluster(cecole) noconstant
eststo 
reg prop4 Gandclass1 Gandclass2 Gandclass3 Gandclass4 Gandclass5 class1 class2 class3 class4 class5, cluster(cecole) noconstant
eststo

label var prop "$\Delta$ absence rate (all)"
label var prop2 "$\Delta$ absence rate (2m)"
label var prop4 "$\Delta$ absence rate (4m)" 
 
*reg prop Gandclass1b Gandclass2b Gandclass3b Gandclass4b Gandclass5b class1b class2b class3b class4b class5b, cluster(ecoclab) noconstant
*eststo 
*reg prop2 Gandclass1b Gandclass2b Gandclass3b Gandclass4b Gandclass5b class1b class2b class3b class4b class5b, cluster(ecoclab) noconstant
*eststo 
*reg prop4 Gandclass1b Gandclass2b Gandclass3b Gandclass4b Gandclass5b class1b class2b class3b class4b class5b, cluster(ecoclab) noconstant
*eststo 
*reg prop Gandclass1b Gandclass2b Gandclass3b Gandclass4b Gandclass5b class1b class2b class3b class4b class5b, cluster(cecole) noconstant
*eststo
*reg prop2 Gandclass1b Gandclass2b Gandclass3b Gandclass4b Gandclass5b class1b class2b class3b class4b class5b, cluster(cecole) noconstant
*eststo 
*reg prop4 Gandclass1b Gandclass2b Gandclass3b Gandclass4b Gandclass5b class1b class2b class3b class4b class5b, cluster(cecole) noconstant
*eststo 

esttab using absencesh_2nd.tex, p  label addnote(p-value is caliculated by cluster robust se at school-class level. All means Sep-Dec rate minus Jun-Dec rate, 2m means Jan rate minus Dec rate, 4m means Jan-Feb minus Nov-Dec rate.) replace 
eststo clear


gen id=_n
drop phase1_0-prop4
reshape long @_0 @_1 @_8 @_9 @_autre, i(id) j(month) s

drop if month=="tot"
gen  time=.
replace time=1 if month=="sept"
replace time=2 if month=="oct"
replace time=3 if month=="nov"
replace time=4 if month=="dec"
replace time=5 if month=="jan"
replace time=6 if month=="fev"
replace time=7 if month=="mar"
replace time=8 if month=="avr"
replace time=9 if month=="mai"
replace time=10 if month=="juin"
replace time=11 if month=="juil"
replace time=12 if month=="aout"
gen time2 = tm(2008m9) + time - 1
format time2 %tm

label define time 1 08_09 2 08_10 3 08_11  4 08_12 5 09_01 6 09_02  7 09_03 8 09_04 9 09_05 10 09_06 11 09_07 12 09_08 
label val time time 
gen totaldays=_0+_1
label var _0  "absent"
label var _1 "present"
label var _8 "teacher absent"
label var _9 "holiday"
label var totaldays "total"

gen absence_rate=_0/totaldays

gen class=.
replace class=1 if class1==1
replace class=2 if class2==1
replace class=3 if class3==1
replace class=4 if class4==1
replace class=5 if class5==1
gen teenclass=.
replace teenclass=1 if class>=4&class!=.
replace teenclass=0 if class<4
gen Gandteenclass=G*teenclass
label define G 0 North 1 South
label val G G
tsset id time
gen phase=1 if time<=4
replace phase=2 if time>4&time!=.

graph bar absence_rate, over(time, label( angle(vertical)))  by(G) nofill
graph export absence_rate.wmf, replace 
graph bar absence_rate if class==1, over(time, label( angle(vertical)))  by(G) nofill
graph export absence_rate_class1.wmf, replace


graph bar absence_rate if bound==1, over(time, label( angle(vertical)))  by(G) nofill
graph export absence_rate_road.wmf, replace 
graph bar absence_rate if class==1&bound==1, over(time, label( angle(vertical)))  by(G) nofill
graph export absence_rate_class1_road.wmf, replace

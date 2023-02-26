use village_3rd,replace

//2ndÇ≈ÇÃïœçXÇêÊÇ…Ç‹Ç∆ÇﬂÇÈ
label var q1ax "Number of households in 2009 who are no longer present"
label var q1bx "Number of new households"
label var    q2ax "Changing the number of primary school"
label var    q3ax "Changing the number of high school first cycle"
label var    q4ax "Changing the number of secondary school second cycle"
label var q7ax "Changing the number of microfinance service / branch"
label var   q8ax "Changing the number of public health center"
label var    q9ax "Changing the number of private health center"
label var    q10ax "Changing the number of midwife free"
label var    q11ax "Changing the number of practitioners Tra" 

label define  q5a 01 "independent: agriculture" 02 "independent: fisheries" 03 "independent industries" 04 "independent: commerce" 05 "independent: service" 06 "employee: agriculture" 07 "employee: fisheries" 08 "employee: industries" 09 "employee: commerce" 10 "employee: service" 11 "others"     12 "Logging independent"    13 "Logging employee"  99 "missing"
label values q5a q5b q5a 
rename q5a q5ay
rename q5b q5by

label define q2ax 1 "+2"  2 "1"  3 "0"    4 "-1"  5 "-2"   9 "Missing" 
label values q2ax q2ax q3ax q4ax q7ax q8ax q9ax q10ax q11ax 

foreach v of varlist  q2ax q3ax q4ax q7ax q8ax q9ax q10ax q11ax  {
replace `v'=. if `v'=="Missing":q2ax
}





label var vh1 "Common Code"
label var vhcom "City Name"
label var vh2 "Code Fokontany"
label var vhfkt "Name Fokontany"
label var vhgrap "Cluster Code (City / Local)"
label var vhloc "Name the place"
label var vh4j "Interview Day"
label var vh4m "Interview Month"
label var vh4a "Year Interview "
label var vh5dh "Start Time"
label var vh5dm "Start Minute"
label var vh5fh "Heur End"
label var vh5fm "Last Minute"
label var vh6t "Officer Land Code"
label var vh6s "Enter Agent Code"
label var vh7a "Role informant)"
label var vh7b "Role Informant b)"
label var vh7c "Role Informant c)"
label var vhpoint "GPS Item Number"
label var vhlatd "Latitude_Degre"
label var vhlatm "Latitude_Minute"
label var vhlond "Longitude_Degre"
label var vhlonm "Longitude_Minute"
label var vhalt "Altitude"
label var vhlat "Latitude in Decimal Degree"
label var vhlon "Longitude in Decimal Degree"
label var vhnbinf "Number Infrastructures"
//label var q1 "Household Employees"
//label var q2 "Existence Primary School"
//label var q3 "Existence Secondary school 1st cycle"
//label var q4 "Existence Secondary School 2nd cycle"
label var q5a "1st principal activity"
label var q5b "2nd principal activity"
label var q61a "Cult.Subsistance: Upland"
label var q61b "Cult.Subsitance: Irrigated Rice"
label var q61c "Cult.Subsitance: mais"
label var q61d "Cult.Rente: Cassava"
label var q62a "Cultlabel var .Rente: Coffee"
label var q62b "Cult.Rente: Clove"
label var q62c "Cult.Rente: Vanilla"
label var q62d "Cult.Rente: Banana"
//label var q7 "Existence microfinance Service / branch"
//label var q8 "Many public health centers"
//label var q9 "Many private health centers"
//label var q10 "Number Wise Free Women"
//label var q11 "Number Tradi practitioners"
label var q12 "How to obtain the drugs against malaria"
label var q13 "The cost of a tablet"
label var q14 "Current cost of a kilo of rice"
label var q15 "Proportion of households possessing mosquito net"
label var q16 "Average number of nets among households"
label var q17 "mosquito net at a price of 3.000ar"
label var q18 "Existence NGOs health activities"
label var vhnb "Most distributors / sellers"
label var vhh "Filters: Distributors"
label var vhfin "End Section"


label define vh1 050 "Mahambo" 170 "AMPASIMBE Onibi"
label values vh1 vh1
label define vh2 01 "NAMAHOAKA" 02 "AMBALAHASINA" 03 "I MAHATSARA" 04 "Ambodibonara"
label values vh2 vh2
label define vhgrap 1 "AMBATOMALAMA" 2 "AMBOHIMIAKATRA" 3 "Tanambao FANIFARANA" 4 "NAMAHOAKA" 5 "Anivorano" 6 "SOUTH Anivorano" 7 "AMBODINONOKA" 8 "SALAFAINA" 9 "Marovato"10 "AMBODIMANGAMAZAVA"11 "AMBALAKAFE"12 "Ambodibonara"13 "AMBALAHASINA"14 "AMBODITAVIA"15 "AMBODIAMPALIBE"16 "SAHAMANDOTRA"17 "I MAHATSARA"18 "ROUND POINT (AMBODIPONT)"
label define  vh4j 99 "missing"
label values  vh4j vh4j
label define  vh4m 99 "missing"
label values  vh4m vh4m
label define  vh4a 9999 "missing"
label values  vh4a vh4a
label define vh5dh 99 "missing"
label values  vh5dh vh5dh
label define vh5dm 99 "missing"
label values  vh5dm vh5dm
label define vh5fh 99 "missing"
label values  vh5fh vh5fh
label define  vh5fm 99 "missing"
label values  vh5fm vh5fm
label define vh7a 1 "village chief / fkt " 2 "village elder" 3 "community health worker" 4 "health officer" 5 "teacher"6 "other" 9 "missing"
label values  vh7a vh7a
label define vh7b 1 "village chief / fkt " 2 "village elder" 3 "community health worker" 4 "health officer" 5 "teacher"6 "other" 9 "missing"
label values vh7b vh7b
label define vh7c 1 "village chief / fkt " 2 "village elder" 3 "community health worker" 4 "health officer" 5 "teacher"6 "other" 9 "missing" 
label values vh7c vh7c
label define vhlatd 99 "missing"
label values vhlatd vhlatd
label define vhlond 999 "missing"
label values vhlond vhlond

label define vhalt 9999 "missing"
label values vhalt vhalt
 
label define q2  1 "yes" 2 "no" 9 "missing"
label values q2 q3 q4 q7 q2



label define  q61a 01 "january" 02 "february" 03 "mars" 04 "april" 05 "may" 06 "june" 07 "july" 08 "august" 09 "september" 10 "october" 11 "november" 12 "december" 22 "all year" 97 "do not grow" 99 "missing"
label values  q61a q61b q61c q61d q62a q62b q62c q62d q61a

label define  q12 1 "buy" 2 "free" 3 "sometimes free" 8 "do not know" 9 "missing"
label values  q12 q12

label define  q15 1 "more than 70%" 2 "40% - 70%" 3 "10% - 40%" 4 "0% - 10%" 9 "missing"
label values  q15 q15

label define  q17  1 "yes" 2 "no" 8 "dk" 9 "missing"
label values q17 q18 q17

foreach v of varlist vh1 vh2 vh4j vh4m vh4a vh5dh vh5dm vh5fh vh5fm vh7a vh7b vh7c vhlatd vhlond vhalt q12 q15 {
replace `v'=. if `v'=="missing":`v'
}
foreach v of varlist q2 q3 q4 q7 {
replace `v'=. if `v'=="missing":q2
}
foreach v of varlist q5a q5b {
replace `v'=. if `v'=="missing":q5a
}
foreach v of varlist q61a q61b q61c q61d q62a q62b q62c q62d  {
replace `v'=. if `v'=="missing":q61a
}
foreach v of varlist q17 q18 {
replace `v'=. if `v'=="missing":q17
}

save e_VILLAGE_3rd,replace
exit

label define vhlatm 99.999 "missing"
label values vhlatm vhlatm
label define vhlonm 99.999 "missing"
label values vhlonm vhlonm
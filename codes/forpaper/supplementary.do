use "data/rawdata/aux/cbsmalaria.dta" ,clear
tsline rdt_f rdt_m,ytitle("Malaria Cases") legend(label(1 "Foulpointe (South)") label(2 "Mahambo (North)")) xlabel(576 582 588 594,valuelabel) recast(connected)
graph export draft/cbsmalariacase.pdf,replace


use "data/rawdata/aux/jpal_yos_new_updated.dta" ,clear

graph hbar  yos,  over(program2,label(labsize( vsmall) ))  leg(off)    ytitle("Years of Schooling per 100 US dollars")  
graph hbar  yos,  over(program2,relabel( 11 `" "Madagascar, Free LLIN Distribution," "Targeted to HHs with 6-12 Old Children Only (This Study)" "' 12 `" "Madagascar, Free LLIN Distribution," "(This Study)" "'  13 `" "Madagascar, Under Assumption of Perfect Targeting" "to Compliers (This Study, Lower Bound)" "' 14 `" "Madagascar, Under Assumption of Perfect Targeting" "to Compliers (This Study, Upper Bound)" "'  ) label(labsize( vsmall) ))  leg(off)    ytitle("Years of Schooling per 100 US dollars") 
graph export draft/jpal_yos_new_updated.pdf,replace


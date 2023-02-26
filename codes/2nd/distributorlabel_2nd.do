use LISTE_DISTRIBUTEUR_VILLAGE_2nd.dta 


label var vl1 "common code"
label var vlcom "common name"
label var vl2 "code fokontany"
label var vlfkt "name fokontany"
label var vhgrap "cluster code (city / local)"
label var vlloc "name the place"
label var vlnb "most distributors / sellers"
label var q19 "number distributor"
label var vlid "distributor identifier"
label var q20a "existence (olyset)"
label var q21am "month early distribution (olyset)"
label var q21aa "year early distribution (olyset) "
label var q22am "month end distribution (olyset)"
label var q22aa "year end distribution (olyset) "
label var q23a "number distributed (olyset)"
label var q24a "unit price (olyset)"
label var q20b "existence (permanet)"
label var q21bm "month early distribution (permanet)"
label var q21ba "year early distribution (permanet) "
label var q22bm "month end distribution (permanet)"
label var q22ba "year end distribution (permanet) "
label var q23b "number distributed (permanet)"
label var q24b "unit price (permanet)"
label var q20c "existence (super screen)"
label var q21cm "month early distribution (super screen)"
label var q21ca "year early distribution (super screen) "
label var q22cm "month end distribution (super screen)"
label var q22ca "year end distribution (super screen) "
label var q23c "number distributed (super screen)"
label var q24c "unit price (super screen)"
label var q20d "existence (milay)"
label var q21dm "month early distribution (milay)"
label var q21da "year early distribution (milay) "
label var q22dm "month end distribution (milay)"
label var q22da "year end distribution (milay) "
label var q23d "number distributed (milay)"
label var q24d "unit price (milay)"
label var q20e "existence (any brand)"
label var q21em "early distribution month (any brand)"
label var q21ea "year early distribution (any brand) "
label var q22em "month end distribution (any brand)"
label var q22ea "year end distribution (any brand) "
label var q23e "number distributed (any brand)"
label var q24e "price per unit (any brand)"
label var q20f "existence (anything else))"
label var q21fm "month early distribution (other products)"
label var q21fa "year early distribution (other products) "
label var q22fm "month end distribution (other products)"
label var q22fa "year end distribution (other products) "
label var q23f "number distributed (another product)"
label var q24f "price per unit (other products)"
label var q20g "existence (act)"
label var q21gm "month early distribution (act)"
label var q21ga "year early distribution (act) "
label var q22gm "month end distribution (act)"
label var q22ga "year end distribution (act) "
label var q23g "number distributed (act)"
label var q24g "price per unit (act)"
label var vhl "end section


label define q20a 1 "yes" 2 "no" 9 "missing"
label define q21am 98 "dk" 99 "missing"  
label define q22am 97 "active" 98 "dk" 99 "missing"
label define q24a 0000 "free" 
label define q20b 1 "yes" 2 "no" 9 "missing"
label define q21bm 98 "dk" 99 "missing"
label define q22bm 97 "active" 98 "dk" 99 "missing"
label define q24b 0000 "free" 
label define q20c 1 "yes" 2 "no" 9 "missing"
label define q21cm 98 "dk" 99 "missing"
label define q22cm 97 "active" 98 "dk" 99 "missing"
label define q24c 0000 "free"
label define q20d 1 "yes" 2 "no" 9 "missing"
label define q21dm 98 "dk" 99 "missing"
label define q22dm 97 "active" 98 "dk" 99 "missing"
label define q24d 0000 "free"  
label define q20e 1 "yes" 2 "no" 9 "missing"
label define q21em 98 "dk" 99 "missing"
label define q22em 97 "active" 98 "dk" 99 "missing"
label define q24e 0000 "free"
label define q20f 1 "yes" 2 "no" 9 "missing"
label define q21fm 98 "dk" 99 "missing"
label define q22fm 97 "active" 98 "dk" 99 "missing"
label define q24f 0000 "free"
label define q20g 1 "yes" 2 "no" 9 "missing"
label define q21gm 98 "dk" 99 "missing"
label define q22gm 97 "active" 98 "dk" 99 "missing"
label define q24g 0000 "free"

label value q20a q20a
label value q21am q21am
label value q22am q22am
label value q24a q24a
label value q20b q20b
label value q21bm q21bm
label value q22bm q22bm
label value q24b q24b
label value q20c q20c
label value q21cm q21cm
label value q22cm q22cm
label value q24c q24c
label value q20d q20d
label value q21dm q21dm
label value q22dm q22dm
label value q24d q24d
label value q20e q20e
label value q21em q21em
label value q22em q22em
label value q24e q24e
label value q20f q20f
label value q21fm q21fm
label value q22fm q22fm
label value q24f q24f
label value q20g q20g
label value q21gm q21gm
label value q22gm q22gm
label value q24g q24g

foreach v of varlist q20a q21am q22am q24a q20b q21bm q22bm q24b q20c q21cm q22cm q24c q20d q21dm q22dm q24d q20e q21em q22em q24e q20f q21fm q22fm q24f q20g q21gm q22gm q24g {
replace `v'=. if `v'=="missing":`v'
}

save  e_LISTE_DISTRIBUTEUR_VILLAGE_2nd,replace
exit
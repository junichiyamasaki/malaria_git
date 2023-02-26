use distribution_to_sleep_3rd.dta,clear

label drop _all 
label define sp31 1 " bed " 2 " floor " 3 " other " 4 " no one sleeps in the room " 9 " missing "
label define sp51 1 " YES " 2 " NO " 8 " Don't know " 9 " MISSING " 
label define sp32 1 " bed " 2 " floor " 3 " other " 4 " no one sleeps in the room " 9 " missing " 
label define sp52 1 " YES " 2 " NO " 8 " Don't know " 9 " MISSING " 
label define sp33 1 " bed " 2 " floor " 3 " other " 4 " no one sleeps in the room " 9 " missing " 
label define sp53 1 " YES " 2 " NO " 8 " Don't know " 9 " MISSING " 
label define sp34 1 " bed " 2 " floor " 3 " other " 4 " no one sleeps in the room " 9 " missing " 
label define sp54 1 " YES " 2 " NO " 8 " Don't know " 9 " MISSING "

label value  sp31  sp31
label value  sp32  sp32
label value  sp33  sp33 
label value  sp54  sp54 
label value  sp34  sp34 
label value  sp53  sp53 
label value  sp51  sp51
label value  sp52  sp52

mvdecode sp31 sp32 sp33 sp34 sp51 sp52 sp53 sp54, mv(9)

reshape  long sp3 sp4a sp4b sp4c sp4d sp4e sp4f sp4g sp5 sp5a sp2a,i(spid) j(sp1_ex) 

save e_sleep_arrangement_3rd.dta,replace
exit
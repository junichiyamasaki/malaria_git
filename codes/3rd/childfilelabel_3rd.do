use childfile_3rd.dta,clear

label drop _all 

label var cch        "Commune code"
label var chcom   "Commune name"
label var fch        "Fokontany code"
label var chfkt  "Fokontany name"
label var chgrap     "Cluster code"
label var chloc  "Village name"
label var chm        "Household number"
label var chext    "Extension code"
label var mhid     "Household identification"
label var miid     "Household member identification"
label var chid  "Child identification"
label var chnb       "Children number"
label var mere  "Mother line number"
label var ch0  "Child line number"
label var ch2v  "Child year of birth"
label var ch2m  "Child month of birth"
label var ch3   "Died or alive (Yes/No)"
label var ch4v "Child Year of death"
label var ch4m  "Child month of death"
label var chfin "End of child questionnarie"

label define  ch2v 9999  "missing"
label define ch2m  98  "Don't know"  99  "missing"
label define ch3  1  "yes" 2  "no" 9  "missing"
label define ch4v 9999  "missing"
label define ch4m  98  "Don't know" 99  "missing"

label value ch2v ch2v
label value ch2m ch2m
label value ch3 ch3
label value ch4v ch4v
label value ch4m ch4m


mvdecode ch2v ch4v, mv(9999)
mvdecode ch2m ch4m, mv(99)
mvdecode ch3, mv(9)

save e_childfile_3rd.dta,replace
exit
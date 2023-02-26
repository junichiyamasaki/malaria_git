use individual_list_household_3rd.dta,clear

replace idold = 414103 in 1277
replace r0bx = "NIRINA" in 1277

*3rd

label drop _all

rename idold miid09

rename r0cax r0caxx
label var r0caxx " Length of residence from Dec 2009 to May 2010"
rename r0fax r0faxx
label var r0faxx " Length of residence from June 2010 to Nov 2010" 

rename r8bx r8bxx
label var r8bxx " Number of nights during these 7 days when he slept in the house" 
rename r8cx r8cxx 
label var r8cxx " Why he didn't sleep in the house" 
label define r8cxx 1 " to work (to the village) "  2 " to play (to the village) " 3 " to study (to the village) "  4 " other reasons (to the village) "  5 " to work (out village) "  6 " to play (out village) "  7 " to study (out village) "  8 " other (out village) "  9 " missing " 
label value  r8cxx r8cxx

gen e7y=e7
replace e7=7 if e7==8 

rename h33a h33axx
rename h33b h33bxx
rename h33c h33cxx
rename h33d h33dxx

label var h33axx " 1st medicine took to warn the malaria " 
label var h33bxx " 2nd medicine took to warn the malaria " 
label var h33cxx " 3rd medicine took to warn the malaria " 
label var h33dxx " 4th medicine took to warn the malaria " 
label define h33axx 1 " CHLOROQUINE "  2 " FANSIDAR " 3 " QUININE " 6 " COARSUCAM " 7 " TAMBAVY " 8 " ACTIPAL " 4 " UNKNOWN  MEDICINE" 5 " OTHER " 9 " MISSING " 
label value h33axx h33bxx h33cxx h33dxx h33axx


replace r4a=. if r4a==9
 mvdecode h33axx h33bxx h33cxx h33dxx e7y r8cxx, mv(9)

replace e7y=. if e7y==9 

//ã≥àÁêÖèÄÇÃí≤êÆ
//recode e2 (0=1)(1=2)(2=3)(3=4)(4=5)
//replace e2=0 if e1==2

label var mi1 "common code"
label var micom "city name"
label var mi2 "code fokontany"
label var mifkt "name fokontany"
label var migrap "cluster code (city / local)"
label var miloc "name the place"
label var mi3 "household number"
label var mhid "household identification"
label var miid "identifying individual"
label var tail "household size"
label var hl1 "person number"
label var r2 "sex"
label var r3 "relationship"
label var r4 "age"
label var r5 "rdt result"
label var r6 "caught in the act"
label var r7 "main job during the current season"
label var r8 "slept in the household last night"
//label var r9 "main activity from december 2008 to may 2009"
//label var r10 "main activity from june 2009 to november 2009"
label var e1 "Have you ever attended school?"
label var e2 "highest level of education completed"
label var e3 "Are you currently enrolled in school?"
//label var e4a "school code"
//label var e4b "code instead school"
//label var e4c "libelle school"
label var e5 "away from school during the last month"
label var e6 "number of days of absence during the last month"
label var e7 "main reason of absence"
label var hl2 "number person"
label var t1 "current health"
label var t2 "state of health compared with 6 months ago"
label var t3 "in bed from 9 am to noon (yesterday)"
label var t4 "in bed at noon to 6pm (yesterday)"
label var t5 "in bed from 9am to noon (before yesterday)"
label var t6 "in bed at noon to 6pm (before yesterday)"
label var t7 "in bed from 9am to noon (3rd day before)"
label var t8 "in bed at noon to 6pm (3rd day before)"
label var t9 "in bed from 9am to noon (4th day before)"
label var t10 "in bed at noon to 6pm (4th day before)"
label var t11 "in bed from 9am to noon (5th day before)"
label var t12 "in bed at noon to 6pm (5th day before)"
label var t13 "in bed from 9am to noon (6th day before)"
label var t14 "in bed at noon to 6pm (6th day before)"
label var t15 "in bed from 9am to noon (7th day before)"
label var t16 "in bed at noon to 6pm (7th day before)"
label var hl3 "number person"
label var h18a "inactive because of fever (in these 6 months) "
label var h18b "duration of inactivity caused by fever (in these 6 months)"
label var h19a "inactive because of diarrhea (in these 6 months) "
label var h19b "duration of inactivity caused by diarrhea (in these 6 months)"
label var h20a "inactive because of dizziness (in these 6 months) "
label var h20b "duration of inactivity caused by dizziness (in these 6 months)"
label var h21 "looked counseling / treatment"
label var h22 "where seek advice / treatment"
label var h23 "received and took medication or injection"
label var h24 "number rdt for 12 months"
label var h25 "number rdt for 6 months"
label var h26 "taking act for 12 months (number)"
label var h27 "taking act for 6 months (number)"
label var h28 "infected with malaria during the last month"
label var h29 "recognition of infection"
label var hl4 "number person"
label var h31 "are you pregnant now?"
label var h32 "taking anti-malarial drugs during pregnancy"
label var h33a "drug taken to prevent malaria"
label var h33b "b. drug taken to prevent malaria"
label var h33c "c. drug taken to prevent malaria"
label var h33d "d. drug taken to prevent malaria"
label var xmi "end section"



label define r2 1 "male" 2 "female" 9 "missing"
label define r3 01 "head of household" 02 "male / husband" 03 "child / adopted child" 04 "petit-fils/fille" 05 "niece / nephew" 06 "father / mother" 07 "sister / brother" 08 "beautiful son / daughter belle" 09 "good brother / sister belle" 10 "grand father / grand mother" 11 "stepfather / stepmother" 12 "others" 99 "missing"
label define r4 97 "more than 100 years" 98 "dk" 99 "missing"
//label define r5 1 "positive" 2 "negative" 3 "refusal" 4 "other" 9 "missing"
label define yesno 1 "yes" 2 "no" 9 "missing"
//label define r7 11 "agriculture (independent)" 12 "hunting (independent)" 13 "craft (independent)" 14 "industry (independent)" 15 "carpenter (independent)" 16 "trade and service (independent)" 17 "other activity (independent)" 21 "agriculture (employee)" 22 "hunting (employee)" 23 "craft (employee)" 24 "industry (employee)" 25 "construction (employee)" 26 "trade and service (employee)" 27 "government or ngos (employee)" 28 "other paid employment (employee)" 31 "no work (no work)" 32 "student (not working)" 33 "housewife (jobless)" 34 "other (not work)" 99 "missing"
*label define r9 01 "work" 02 "community work" 03 "task domestic" 04 "student" 05 "play" 06 "sleep / stay at home (sick)" 07 "sleep / stay at home (other than patient)" 08 "caring for a sick person" 09 "retired and can not work" 10 "other" 11 "do not remember" 99 "missing"
label define r9 01 "work" 02 "community work" 03 "task domestic" 04 "student" 05 "play" 06 "sleep / stay at home (sick)" 07 "sleep / stay at home (other than patient)" 08 "caring for a sick person" 09 "retired and can not work" 10 "other" 11 "do not remember" 13 "Not concerned (born between June and December 2010)Åc13" 99 "missing"
label define r10 01 "work" 02 "community work" 03 "domestic work" 04 "student" 05 "play" 06 "sleep / stay at home (sick)" 07 "sleep / stay at home (other than patient)" 08 "caring for a sick person" 09 "retired and can not work" 10 "other" 11 "do not remember" 99 "missing"

label define e2 0 "Not ever" 1 "preschool" 2 "primary" 3 "secondary i." 4 "secondary ii" 5 "higher" 9 "missing"
label define e3 1 "yes" 2 "no" 9 "missing"
label define e4a 1 "epp" 2 "ceg" 3 "college" 4 "highschool" 5 "technical high school" 6 "university" 8 "other" 0 "missing"
label define e4b 04 "namahoaka" 08 "salafaina" 12 "ambodibonara" 13 "ambalahasina" 17 "i mahatsara" 19 "ambatobe" 20 "ampasimbe onibi" 21 "antsikafoka" 22 "beampy" 23 "fener is" 24 "foulpointe" 25 "hotsika" 26 "mahambo" 27 "marofarihy" 28 "toamasina" 29 "vohimalaza" 00 "missing"
label define e6 00 "less than one day"
label define e7 1 "cost" 2 "health problem" 3 "poor performance" 4 "lazy" 5 "no teacher" 6 "school holidays / school closed" 7 "other" 9 "missing"
label define t1 1 "excellent" 2 "very good" 3 "good" 4 "poor" 5 "very poor" 9 "missing"
label define t2 1 "improved" 2 "same" 3 "degrade" 9 "missing"
label define h22 1 "traditional doctor / healer" 2 "public health center" 3 "private doctor" 4 "pharmacy" 5 "other" 9 "missing"
label define h29 1 "according test rdt" 2 "according to doctor's diagnosis" 3 "from diagnosis of the traditional healer" 4 "according to your own diagnosis" 9 "missing"
label define h33a 1 "chloroquine" 2 "fansidar" 3 "quinine" 4 "unknown drug" 5 "other" 9 "missing"
label define h33b 1 "chloroquine" 2 "fansidar" 3 "quinine" 4 "unknown drug" 5 "other" 9 "missing"
label define h33c 1 "chloroquine" 2 "fansidar" 3 "quinine" 4 "unknown drug" 5 "other" 9 "missing"
label define h33d 1 "chloroquine" 2 "fansidar" 3 "quinine" 4 "unknown drug" 5 "other" 9 "missing"


label value r6 r8 e1 e3 e5 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 h18a h19a h20a h21 h23 h28 h31 h32 yesno


label value r2 r2
label value r3 r3
label value r4 r4
//label value r5 r5
label value r7 r7
label value r9 r9
label value r10 r10
label value e2 e2
label value e3 e3
//label value e4a e4a
//label value e4b e4b
label value e6 e6
*label value e7 e7
label value t1 t1
label value t2 t2
label value h22 h22
label value h29 h29
label value h33a h33a
label value h33b h33b
label value h33c h33c
label value h33d h33d

label define missing99 99 "missing"
label value h24 h25 h26 h27 missing99
replace h25=0 if h24==0
replace h26=0 if h24==0 | h26==.
replace h27=0 if h26==0
*rename h33a h33
*drop h33b h33c h33d



foreach v of varlist r2 r3 r4 r5 r7 r9 r10 e2 e3  e6 e7 t1 t2 h22 h29   {
replace `v'=. if `v'=="missing":`v'
}
foreach v of varlist  r6 r8 e1 e3 e5 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 h18a h19a h20a h21 h23 h28 h31 h32  {
replace `v'=. if `v'=="missing":yesno
}
foreach v of varlist  h24 h25 h26 h27 {
replace `v'=. if `v'=="missing":missing99
}

//2ndÇ≈ÇÃïœçX
rename e4ax e4axyy
label var miext "Code Extension"
*label var mihid09 "household ID in 1st" 
label var r0cx "Old member"
*label var miid09 "Indiidual ID in 1st"
label var r0bx "Name of the individual"
label var r0dx "Current Member"
label var r0emx "Month of join"
label var r0eax "Year of join"
label var r0fx "Old residence" 
label var r7ax "secondary job during the current season"
label var r8ax "Number of the net"
label var r9 "First activity (6 months from 1 year ago)"
label var r9ax "Second Activity (6 months from 1 year ago)"
label var r10 "First Activity (this 6 months)"
label var r10ax "Second Activity (this 6 months)" 
label var  r11a1x "activity outside the household yesterday"
label var r11a2x "Number of hours"
label var r11b1x "Activity housewife yesterday"
label var r11b2x "Number of hours"
label var r11c1x "At school yesterday"
label var r11c2x "Number of hours"
label var r11d1x "Stay at home because of illness yesterday"
label var r11d2x "Number of hours"
label var r11e1x "Staying Healthy House yesterday"
label var r11e2x "Number of hours"
label var r11f1x "Caring for a sick yesterday"
label var r11f2x "Number of hours"
label var r12ax "activity outside the household a week ago"
label var r12bx "Activity housewife one week ago"
label var r12cx "At school one week ago"
label var r12dx "Stay at home due to illness one week ago"
label var r12ex "Staying Healthy House one week ago"
label var r12fx "Caring for a sick one week ago"
label var r13ax "activity outside the household during this month"
label var r13bx "housewife Activity during this month"
label var r13cx "At school during this month"
label var r13dx "Stay at home because of illness during this month"
label var r13ex "Staying Healthy House during this month"
label var r13fx "Caring for a patient during this month" 
label var e8x "absence in the last six months"
label var  e9x "Number of days of absence during the last six months"
label var  e10x "reason for his absence during the last six months" 

label var e2ax "The highest grade completed" 
label var e4ax "School type"
label var e4bx "School name"
label var  i1x "Source of income during the last six months"
label var i2x "Total income during the last six months"
label var i3x "Source of Income during "
label var i4ax "Change source of income"
label var i4bx "Total income during the six months from 1 year ago"
label var i5x "Source of income (professional) during the last six months"
label var i6x "Total income (professional) during the last six months"
label var i7x "Part of the individual (in percentage) during the last six months"
label var i8x "Source of income (professional) during the six months from 1 year ago"
label var i9ax "Change source of income"
label var i9bx "Total income"
label var i10x "Part of the individual (in percentage) ofduring the six months from 1 year ago"  
label var h34x "How many children have you given birth to? (including the ones who already died)"
label var h35x "Out of h34x, how many childrens died during one month and 5 years old?"
label var h36x "Out of h35x, how many childrens died because of malaria?"


label define r0cx 1 "FORMER MEMBER " 2 "NEW MEMBER"
label define r0dx 1 "YES" 2 "NO MOVING" 3 "NO, DIED" 4 "NO OTHER" 9 "MISSING"
label define r0emx 99 "MISSING"
label define r0eax 9999 "MISSING"
label define r0fx 1 "THE SAME VILLAGE" 2 "THE SAME REGION" 3 "OTHER REGION" 4 "NOT NEW" 9 "MISSING" 
label define r7  11 "Agriculture (Independent)" 12 "Fishing (Independent)"    13 "Craft (Independent)"    14 "Industry (Independent)"    15 "Carpenter (Independent)"    16 "Trade and Service (Independent)"    17 "Other Activity (Independent)"    18 "Logging (Independent)"    21 "Agriculture (Employee)"    22 "Fishing (Employee)"    23 "Craft (Employee)"    24 "Industry (Employee)"    25 "Construction (Employee)"    26 "Trade and Service (Employee)"    27 "Government or NGOs (Employee)"    28 "Other paid employment (Employee)"    29 "Logging (Employee)"    31 "Not Working (Unemployed)"    32 "Student (Unemployed)"    33 "Housewife (Unemployed)"    99 "MISSING" 
label define r11a1x    1 "YES" 2 "NO"  3 "Do not remember / DK" 9 "MISSING" 
label define e2ax    00 "Preschool"    01 "T1"    02 "T2"    03 "T3"    04 "T4"    05 "T5"    06 "T6"    07 "T7"    08 "T8"    09 "T9"    10 "T10 = 2nd"    11 "T11 = first"    12 "T12 = Terminal"    13 "first year"    14 "2nd year"    15 "3rd Year"    16 "4th year"    17 "Grade 5 and above"    98 "DK" 
label define e4axyy    0 "Missing / Other"    1 "EPP MAHATSARA "    2 "EPP AMBALAHASINA"    3 "EPP NAMAHOAKA"    4 "EPP SALAFAINA"    5 "EPP Ambodibonara"    6 "EPP MAROFARIHY"    7 "CEG AMPASIMBE ONIBE"    8 "CEG Mahambo"    9 "CEG Foulpointe"  10 " EPP MAROFARIHY " 11 " EPP NAMAHOAKA " 12 " EPP RANOMENA " 13 " EPP SALAFAINA " 14 " CEG AMPASIMBE ONIBE " 15 " CEG FOULPOINTE "  16 " CEG MAHAMBO " 98 " OTHER " 99 " missing " 


label define i4ax 0 "MISSING"    1 "50% AND MORE (UP)"    2 "20% to 50% (UP)"    3 "0% to 20% (UP)"    4 "THE SAME"    5 "0% to 20% (DOWN)"    6 "20% to 50% (DOWN)"    7 "50% AND MORE (DOWN)"    8 "I1X = NO"    9 "DK" 
label define r5  2 "negative" 3 "refusal" 4 "other" 5"positive pf" 6 "positive nonpf" 7 "positive mix" 9 "missing"
label define e7y 1 "cost" 2 "health problem" 3 "poor performance" 4 "lazy" 5 "no teacher" 6 "school holidays / school closed" 7 "other" 8 "Participe to harvest or other productive activity" 9 "missing"
label value r0cx r0cx
label value r0dx r0dx
label value r0emx r0eax
label value e2ax e2ax
label value e4axyy e4axyy
label value e7y e7y
label value r5 r5

label value r7 r7ax r7 
label value r9ax r9
label value r11a1x r11b1x r11c1x r11d1x r11e1x r11f1x r12ax r12bx r12cx r12dx r12ex r12fx  r13ax r13bx r13cx r13dx r13ex r13fx r11a1x

label value e5 e8x e3
label value e10x e7y
label value  i1x i3x i5x i8x  yesno
label value i4ax i9ax i4ax

rename r5 r5y
label copy r5 r5y
label var r5y r5y
rename r7 r7y
label copy r7 r7y
label var r7y r7y

mvdecode r0emx,mv(99)  
mvdecode r0eax,mv(9999)

mvdecode r11* r12* r13* e8x i1x i3x i5x i8x,mv(9)
replace e7y=. if e7y==9
replace r7y=. if r7y==99
replace e4axyy=. if e4axyy==99 

//ïÉÇ∆ïÍÇÃã≥àÁêÖèÄ HHheadÇ‡ÇµÇ≠ÇÕÇªÇÃîzãÙé“ÇÃÇ›Ç…å¿ÇÈ
gen e2f=e2 if r2==1 & (r3==1 | r3==2) 
bysort mhid: egen e2ff=total (e2f), m

gen e2m=e2 if r2==2 & (r3==1 | r3==2) 
bysort mhid: egen e2mm=total (e2m), m


tostring miid09, gen(miid09st)
gen mhid09= reverse(substr(reverse(miid09st),3,.))
destring  mhid09,replace

//èäìæä÷åW
gen salary_12_6=i2x
replace salary_12_6=0 if i1x==2 |(i1x==1&i2x==.)
gen salary_6_0=i4bx
replace salary_6_0=0 if i3x==2 |(i3x==1&i4bx==.)
gen dsalary_12_6_6_0=salary_6_0-salary_12_6

egen HH_self_12_6=max(i6x), by(mhid09)  
gen self_12_6=HH_self_12_6*i7x/100
replace self_12_6=0 if i5x==2 
egen HH_self_6_0=max(i9bx), by(mhid09)  
gen self_6_0=HH_self_6_0*i10x/100
replace self_6_0=0 if i8x==2 
gen dself_12_6_6_0=self_6_0-self_12_6

egen HH_salary_12_6=total(salary_12_6), by (mhid09) 
gen proportion_salary_12_6=salary_12_6/HH_salary_12_6

egen HH_salary_6_0=total(salary_6_0), by (mhid09) 
gen proportion_salary_6_0=salary_6_0/HH_salary_6_0
label var salary_6_0 "Salary income during the last 6 months"
label var salary_12_6 "Salary income during the 6 months from 12 months ago "

label var HH_self_6_0 "Self production income during the last 6 months as household"
label var HH_self_12_6 "Self production income during the 6 months from 12 months ago as household "
label var self_6_0 "Self production income during the last 6 months"
label var self_12_6 "Self production income during the 6 months from 12 months ago "

label var HH_self_6_0 "Self production income during the last 6 months as household"
label var HH_self_12_6 "Self production income during the 6 months from 12 months ago as household "



//time allicationä÷åW
gen twork=r11a2x
replace twork=0 if r11a1x==2
gen thhtask=r11b2x
replace thhtask=0 if r11b1x==2
gen tschool=r11c2x
replace tschool=0 if r11c1x==2
gen tsickrest=r11d2
replace tsickrest=0 if r11d1x==2
gen trest=r11e2
replace trest=0 if r11e1x==2
gen tcare=r11f2
replace tcare=0 if r11f1x==2


label var twork "Hours when he was working yesterday"
label var thhtask "Hours when he was doing househol task yesterday"
label var tschool "Hours when he was going school yesterday"
label var tsickrest "Hours when he was rest because of sick yesterday"
label var trest "Hours when he was rest not because of sick yesterday"
label var tcare "Hours when he was taking care of sick members yesterday"


save e_LISTE_INDIVIDU_MENAGE_3rd,replace
exit
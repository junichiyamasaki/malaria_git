use LISTE_INDIVIDU_MENAGE,clear

replace r2 = 2 in 732
//ã≥àÁêÖèÄÇÃí≤êÆ
recode e2 (0=1)(1=2)(2=3)(3=4)(4=5)
replace e2=0 if e1==2

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
label var r9 "First activity (6 months from 1 year ago)"
label var r10 "First Activity (this 6 months)"
label var e1 "Have you ever attended school?"
label var e2 "highest level of education completed"
label var e3 "Are you currently enrolled in school?"
label var e4a "school type"
label var e4b "school place"
label var e4c "school name"
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
label define r5 1 "positive" 2 "negative" 3 "refusal" 4 "other" 9 "missing"
label define yesno 1 "yes" 2 "no" 9 "missing"
label define r7 11 "agriculture (independent)" 12 "hunting (independent)" 13 "craft (independent)" 14 "industry (independent)" 15 "carpenter (independent)" 16 "trade and service (independent)" 17 "other activity (independent)" 21 "agriculture (employee)" 22 "hunting (employee)" 23 "craft (employee)" 24 "industry (employee)" 25 "construction (employee)" 26 "trade and service (employee)" 27 "government or ngos (employee)" 28 "other paid employment (employee)" 31 "no work (no work)" 32 "student (not working)" 33 "housewife (jobless)" 34 "other (not work)" 99 "missing"
label define r9 01 "work" 02 "community work" 03 "task domestic" 04 "student" 05 "play" 06 "sleep / stay at home (sick)" 07 "sleep / stay at home (other than patient)" 08 "caring for a sick person" 09 "retired and can not work" 10 "other" 11 "do not remember" 99 "missing"
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
label value r5 r5
label value r7 r7
label value r9 r9
label value r10 r10
label value e2 e2
label value e3 e3
label value e4a e4a
label value e4b e4b
label value e6 e6
label value e7 e7
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
rename h33a h33
drop h33b h33c h33d



foreach v of varlist r2 r3 r4 r5 r7 r9 r10 e2 e3 e4a e4b e6 e7 t1 t2 h22 h29 h33  {
replace `v'=. if `v'=="missing":`v'
}
foreach v of varlist  r6 r8 e1 e3 e5 t3 t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 h18a h19a h20a h21 h23 h28 h31 h32  {
replace `v'=. if `v'=="missing":yesno
}
foreach v of varlist  h24 h25 h26 h27 {
replace `v'=. if `v'=="missing":missing99
}

//ïÉÇ∆ïÍÇÃã≥àÁêÖèÄ HHheadÇ‡ÇµÇ≠ÇÕÇªÇÃîzãÙé“ÇÃÇ›Ç…å¿ÇÈ
gen e2f=e2 if r2==1 & (r3==1 | r3==2) 
bysort mhid: egen e2ff=total (e2f), m

gen e2m=e2 if r2==2 & (r3==1 | r3==2) 
bysort mhid: egen e2mm=total (e2m), m


save e_LISTE_INDIVIDU_MENAGE,replace
exit
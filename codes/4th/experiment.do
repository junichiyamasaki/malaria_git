use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\4th\experiment, clear

replace aq5=. if aq4==1
replace aq61=. if aq4==0
replace aq62=. if aq4==0
replace aq63=. if aq4==0
replace aq64=. if aq4==0
replace aq65=. if aq4==0
replace aq66=. if aq4==0
replace aq67=. if aq4==0
replace aq68=. if aq4==0
replace aq69=. if aq4==0
replace aq610=. if aq4==0
replace aq611=. if aq4==0


gen moneyfc=e1c1
replace moneyfc=2 if moneyfc==0&e1c2==1
replace moneyfc=3 if moneyfc==0&e1c3==1
replace moneyfc=4 if moneyfc==0&e1c4==1
replace moneyfc=5 if moneyfc==0&e1c4==0

gen healthfc=e2c1
replace healthfc=2 if healthfc==0&e2c2==1
replace healthfc=3 if healthfc==0&e2c3==1
replace healthfc=4 if healthfc==0&e2c4==1
replace healthfc=5 if healthfc==0&e2c4==0

gen rainef=q1-q2
gen dryef=q3-q4

label var q3 "dry season without nets"
label var q4 "dry season with nets"
label var q1 "rainy season without nets"
label var q2 "rainy season with nets"
label var aq1 "If you are infected by malaria, will you take any medicine?"
label var aq2 "Will you want a mosquito net for 3000 Ariary?"
label var aq3 "Did you have any mosquito bite yesterday?"
label var aq4 "Did you use any mosquito net last night?"
label var aq5 "Was it one distributed by the big campaign?"
label var aq61 "It gets hotter"
label var aq62 "There are no enough nets in my house"
label var aq63 "It is bothersome to hang on a net"
label var aq64 "Mosquito net is useless for mosquito repellent
label var aq65 "My house is too small to hang on a net
label var aq66 "I use the other instrument for mosquito repellent like mosquito coils
label var aq67 "I feel a sense of oppression
label var aq68 "I was outside the house
label var aq69 "There seemed no mosquitoes
label var aq610 "My net was torn"
label var aq611 "other"
label var q5 "Subjective no. of incative dates when infected"

label define risk 0 "sure" 1 "lottery"
label value e1c1 e1c2 e1c3 e1c4 e2c1 e2c2 e2c3 e2c4 risk

save C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\4th\experimentcoded, replace
exit
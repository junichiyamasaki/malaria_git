use menage_2nd,replace


//h2h3ÇÃÉ[ÉçñÑÇﬂ
replace h2=0 if h1==.
replace h3=0 if h1==.

label var mh1 "common code"
label var mhcom "city name"
label var mh2 "code fokontany"
label var mhfkt "name fokontany"
label var mhgrap "cluster code (city / local)"
label var mhloc "name the place"
label var mh3 "household number"
label var mhid "household identification"
label var mh4j "interview day"
label var mh4m "interview month"
label var mh4a "year interview "
label var mh6t "officer land code"
label var mh6s "enter agent code"
label var mh5dh "start time service"
label var mh5dm "top maintenance minute"
label var mh5fh "end time service"
label var mh5fm "last minute interview"
label var mhpoint "gps item number"
label var mhlatd "latitude_degre"
label var mhlatm "latitude_minute"
label var mhlond "longitude_degre"
label var mhlonm "longitude_minute"
label var mhalt "altitude"
label var mhlat "latitude in decimal degree"
label var mhlon "longitude in decimal degree"
label var taille "household size"
label var xmh "towards table housewares
label var k1 "ever heard of malaria"
label var k2a "a. friend"
label var k2b "b. family member"
label var k2c "c. posters / display"
label var k2d "d. newspapers"
label var k2e "e radio"
label var k2f "f. tv"
label var k2g "g. at school"
label var k2h "h. at the church"
label var k2i "i. community meeting"
label var k2j "d. health center"
label var k2k "k. community health worker (rhm)"
label var k2l "l. website malaria (malaria camp) "
label var k2m "m. other"
label var k3a "a. mosquito"
label var k3b "b. blood"
label var k3c "v. ill person"
label var k3d "d. with food"
label var k3e "e. the wind"
label var k3f "f. other"
label var k3g "g. do not know"
label var k4 "untreated malaria can be fatal"
label var k5a "a. migraine (headache)"
label var k5b "b. high temperature / fever"
label var k5c "c. chill"
label var k5d "d. tremor"
label var k5e "e. vomiting"
label var k5f "f. fatigue"
label var k5g "g. delirium"
label var k5h "h. no appetite"
label var k5i "i. vertigo"
label var k5j "other days"
label var k5x "x. do not know"
label var k6 "sufficient knowledge about malaria"
label var k7a "a. on the treatment"
label var k7b "b. in control"
label var k7c "c. the prevention"
label var k7d "d. nature of illness"
label var k7e "e. all information provided"
label var k7f "f. other"
label var k7g "g. signs and symptoms"
label var k7x "x. do not know"
label var k8a "a. friend"
label var k8b "b. church"
label var k8c "v. radio"
label var k8d "d. tv"
label var k8e "e. posters / displays"
label var k8f "f. newspapers"
label var k8g "g. health service"
label var k8h "h. traditional healers (traditional healer)"
label var k8i "i. community meeting"
label var k8j "d. community health worker (rhm)"
label var k8k "k. other"
label var k8x "x. do not know"
label var k8z "z. not applicable"
label var k9 "attitude in the presence of signs / symptoms"
label var k10 "how soon after infection would you seek treatment?"
label var k11 "attitude, if immediate treatment could not be done"
label var k12 "malaria can be proactive?"
label var k13a "a. using the net"
label var k13b "b. clearing / filling puddles"
label var k13c "c. streamers"
label var k13d "d. vaccination of children"
label var k13e "e. chemoprophylaxis"
label var k13f "f. other"
label var k14a "a. using insect repellent"
label var k14b "b. mosquito coil"
label var k14c "c. remove standing water"
label var k14d "d. brushing area"
label var k14e "e. close the door and windows"
label var k14f "f. installation of anti-mosquito screen to the window"
label var k14g "g. using nets"
label var k14h "h. other"
label var k14i "i. do nothing"
label var h1 "possession nets"
label var h2 "number nets"
label var h3 "number used nets the night before"
label var h14 "Did you have other screens in the past?"
label var h15 "if yes, what happend to the net?"
label var h16 "mosquito nets obtained at the price of 3000 ariary?"
label var h17 "purchase of net additional cost 3,000 ariary?"
label var ea1 "frequency of expenditure for medical care / health center (12 last. months)"
label var ea2 "frequency of expenditure for medical care / health center (last 6. months)"
label var ea3 "value spending for medical care in health center (12 dern.mois"
label var ea4 "value spending for medical care in health center (last 6. months)"
label var ea5 "means of travel for medical care in health center"
label var ea6 "time travel for medical care in health center"
label var eb1 "frequency estimates for traditional medical care (12 last. months)"
label var eb2 "frequency estimates for traditional medical care (last 6. months)"
label var eb3 "value spending for traditional medical care (12 last. months)"
label var eb4 "value spending for traditional medical care (last 6. months)"
label var eb5 "means of travel to traditional medical care"
label var eb6 "time travel to traditional medical care"
label var ec1 "frequency of expenditure for purchase of medicine (12 last. months)"
label var ec2 "frequency of expenditure for purchase of medicine (last 6. months)"
label var ec3 "value spending buying drugs (12 last. months)"
label var ec4 "value spending for purchase of drugs (last 6. months)"
label var ec5 "means of travel to purchase medicine"
label var ec6 "time travel to purchase medicine"
label var ed1 "frequency other medical expenses (12 last. months)"
label var ed2 "other medical expenses frequency (last 6. months)"
label var ed3 "value other medical expenses (12 last. months)"
label var ed4 "value other medical expenses (last 6. months)"
label var c1 "type place to cook"
label var c2 "type of cooking fuel"
label var a1 "construction (existence)"
label var a2 "farm (existence)"
label var a3 "farmland (are)"
label var a4 "chair (number)"
label var a5 "marmite (number)"
label var a6 "agricultural tools (existence)"
label var a7 "bureau (number) "
label var a8 "chickens (number)"
label var a9 "pigs (number)"
label var a10 "zebu (number)"
label var a11 "cows / bulls (number) "
label var a12 "horses / donkeys / mules (number)"
label var a13 "goats (number)"
label var a14 "sheep (number) "
label var a15 "ducks / geese (number)"
label var a16 "bijoux (existence) "
label var a17 "electronic apparatus or generator (existence)"
label var a18 "bicycle (number)"
label var a19 "motorcycle (number)"
label var a20 "television (number) "
label var a21 "radio (number) "
label var a22 "sewing machine (number)"
label var a23 "lamps, lighting (number)"
label var a24 "phone - mobile (number)"
label var a25 "clock / wrist watch (number)"
label var a26 "charrette - grows (number)"
label var a27 "boat / canoe (number)"
label var a28 "deposit to the bank or other micro finance institutions (available)"
label var mhfin "end section"

label define mh1 050 "mahambo" 170 "ampasimbe onibi" ,replace 
label define  mh2 01 "namahoaka" 02 "ambalahasina" 03 "i mahatsara" 04 "ambodibonara" ,replace 
label define  mhgrap 01 "ambatomalama" 02 "ambohimiakatra" 03 "tanambao fanifarana" 04 "namahoaka" 05 "anivorano" 06 "south anivorano" 07 "ambodinonoka" 08 "salafaina" 09 "marovato" 10 "ambodimangamazava" 11 "ambalakafe" 12 "ambodibonara" 13 "ambalahasina" 14 "amboditavia" 15 "ambodiampalibe" 16 "sahamandotra" 17 "i mahatsara" 18 "round point (ambodipont)" ,replace 
label define  mh4j 99 "missing" ,replace 
label define  mh4m 99 "missing" ,replace 
label define  mh4a 9999 "missing" ,replace 
label define  mh5dh 99 "missing" ,replace 
label define  mh5dm 99 "missing" ,replace 
label define  mh5fh 99 "missing" ,replace 
label define  mh5fm 99 "missing" ,replace 
label define  mhlatd 99 "missing" ,replace 
label define  mhlond 999 "missing" ,replace 
label define  mhalt 9999 "missing" ,replace 
label define yesno  1 "yes" 2 "no" 9 "missing"  ,replace 
label define yesnodk 1 "yes" 2 "no" 8 "dk" 9 "missing" ,replace 
label define  k9 1 "service health" 2 "traditional healer" 3 "pharmacy" 4 "nothing" 5 "other" 8 "do not know" 9 "missing" ,replace 
label define  k10 1 "day (within 24 hours) " 2 "2-3 days" 3 "4-6 days" 4 "7 days or more" 9 "missing" ,replace 
label define  k11 1 "service health" 2 "traditional healer" 3 "pharmacy" 4 "nothing" 5 "other" 8 "do not know" 9 "missing" ,replace 
label define  h14 1 "yes" 2 "no" 9 "missing" ,replace 
label define  h15 1 "throw" 2 "given to someone" 3 "used for something else" 4 "other" 9 "missing" ,replace 
label define  ea5 1 "walking" 2 "a bicycle" 3 "by car" 4 "a canoe" 5 "other" 8 "dk" 9 "missing" ,replace 
label define  eb5 1 "walking" 2 "a bicycle" 3 "by car" 4 "a canoe" 5 "other" 8 "dk" 9 "missing" ,replace 
label define  ec5 1 "walking" 2 "a bicycle" 3 "by car" 4 "a canoe" 5 "other" 8 "dk" 9 "missing" ,replace 
replace ea5=8 if ea5==7
replace eb5=8 if eb5==7
replace ec5=8 if ec5==7
label define  c1 1 "in house" 2 "in a separate building" 3 "outdoor" 9 "missing" ,replace 
label define c2 1 "electricity" 02 "liquefied propane gas" 03 "natural gas" 04 "biogas" 05 "kerosene" 06 "coal, lignite" 07 "charcoal" 08 "wood" 09 "straw / branches / herbs" 10 "agricultural residues" 11 "bouse" 12 "no meals prepared in housewares" 13 "other" 99 "missing"   ,replace 



label value mh1 mh1
label value  mh2 mh2
label value  mhgrap mhgrap
label value  mh4j mh4j
label value  mh4m mh4m
label value  mh4a mh4a
label value  mh5dh mh5dh
label value  mh5dm mh5dm
label value  mh5fh mh5fh
label value  mh5fm mh5fm
label value  mhlatd mhlatd
label value  mhlatm mhlatm
label value  mhlond mhlond
label value  mhlonm mhlonm
label value  mhalt mhalt
label value  k9 k9
label value  k10 k10
label value  k11 k11
label value  h14 h14
label value  h15 h15
label value  ea5 ea5
label value  eb5 eb5
label value  ec5 ec5
label value  c1 c1
label value c2 c2
label value  k1 k2a k2b k2c k2d k2e k2f k2g k2h k2i k2j k2k k2l k2m k3a k3b k3c k3d k3e k3f k3g k5a k5b k5c k5d k5e k5f k5g k5h k5i k5j k5x k7a k7b k7c k7d k7e k7f k7g k7x k8a k8b k8c k8d k8e k8f k8g k8h k8i k8j k8k k8x k8z k13a k13b k13c k13d k13e k13f k14a k14b k14c k14d k14e k14f k14g k14h k14i h1 h16 h17 a1 a2 a6 a16 a17 a28 yesno
label value k4 k6 k12 yesnodk

label define a3 9999 "missing"
label value a3 a3

label define a8 999 "missing"
label value a8 a9 a10 a11 a12 a13 a14 a15 a8
label define a4 99 "missing"
label value a4 a5 a18 a23 a24 a25 a26 a27 a4
label define a7 9 "missing"
label value a3 a7 a19 a20 a21 a22 a7 a3
mvdecode a8 a9 a10 a11 a12 a13 a14 a15 mhlond, mv(999)
mvdecode a4 a5 a18 a23 a24 a25 a26 a27 mh4j mh4m mh5dh mh5dm mh5fh mh5fm mhlatd c2,mv(99)
mvdecode a7 a19 a20 a21 a22 k9 k10 k11 h14 h15 ea5 eb5 ec5 c1 k4 k6 k12 k1 k2a k2b k2c k2d k2e k2f k2g k2h k2i k2j k2k k2l k2m k3a k3b k3c k3d k3e k3f k3g k5a k5b k5c k5d k5e k5f k5g k5h k5i k5j k5x k7a k7b k7c k7d k7e k7f k7g k7x k8a k8b k8c k8d k8e k8f k8g k8h k8i k8j k8k k8x k8z k13a k13b k13c k13d k13e k13f k14a k14b k14c k14d k14e k14f k14g k14h k14i h1 h16 h17 a1 a2 a6 a16 a17 a28, mv(9)
mvdecode ea3 ea4 eb3 eb4 ec3 ec4 ecax3 ecax4 ed3 ed4, mv(9999999)


//2ndÇ≈ÇÃïœçXÇ»Ç« 
label var mext "extension code"
label var mhid09 "Household ID in 1st"
label var mh2ax "Name of head of household in 2009"
label var mh3ax "Existence of a partner"
label var mh3bx "Reason for absence from the household"
label var mh3cx "Even the head of household in 2009"
label var mh3dx "Name of Head of Household 2010
label var mh3ex "Line number of the interviewee"
label var mh3fx "Same person interviewed in 2009"
label var h17ax "buying power from a net of 2000 Ariary"
label var h17bx "buying power from a net 1,000 Ariary"
label var ea7x "Price of the net in a health center"
label var ec7x "Price of the net in a pharmacy / drug depot"
label var ecax1 "Frequency of expenditure for purchase of medicines in a place other than pharmacy / drug filing (last 12. Months)"
label var ecax2 "Frequency of expenditure for purchase of medicines in a place other than pharmacy / drug filing (last 6. Months)"
label var ecax3 "Amount spent for purchase of medicines in a place other than pharmacy / drug filing (last 12. Months)"
label var ecax4 "Overall expenditure for purchase of medicines in a place other than pharmacy / drug filing (last 6. Months)"
label var ecax5 "Means of travel to purchase drugs in a place other than pharmacy / drug depot"
label var ecax6 "Time travel to purchase drugs in a place other than pharmacy / drug depot"
label var eca7x "Price of the net in a place other than pharmacy / drug depot"
label var a1ax "Number of nature of local construction materials"
label var a1bx "Number of building stone, brick, cinder block"
label var a1cx "Number concrete building"
label var a1dx "Existence of toilets (WC)"
label var a1ex "Existence of electricity"
label var a3ax "Possession of agricultural land"
label var a27ax "Number of boat / canoe with motor"
label var a27bx "Number of non-motorized canoe"
label var a29x "Number of cars"

label define mh3bx 1 "temporary absence during the investigation" 2 "Moved to another village"    3 "Died" 4 "Other" 9 "Missing"
label value mh3bx mh3bx
label define h1ax 1 "Too expensive"    2 "Not available in stores"  3 "Screen damaged"    4 "Other reason" 9 "MISSING"
label value h1ax h1ax

label define mh3ax 1 "yes" 2 "no" 3 "yes, refused"
label value mh3ax mh3ax

label value  mh3cx mh3fx a1dx a1ex a3ax yesno
mvdecode  mh3cx mh3fx a1dx a1ex a3ax mh3bx h1ax, mv(9)

save e_MENAGE_2nd,replace
exit


label define  mhlatm 99.999 "missing" ,replace 
label define  mhlonm 99.999 "missing" ,replace 
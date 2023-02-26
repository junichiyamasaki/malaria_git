 use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\3rd\e_sleep_arrangement_3rd.dta,clear
save C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\forpaper\netdemand.dta,replace

foreach n in a b c d e f g{
use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\3rd\e_combine_3rd.dta,clear

rename hl1 sp4`n'
rename r2 r2`n'
rename r4a r4aa
rename r4 r4`n'
rename r7y r7`n'
keep mhid sp4`n' r2`n'  r4`n' r7`n'
save C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\3rd\mqnid`n',replace

use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\forpaper\netdemand.dta,clear

merge m:1  mhid  sp4`n' using  C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\3rd\mqnid`n',nogen

erase  C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\3rd\mqnid`n'.dta

save C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\forpaper\netdemand.dta,replace
}

foreach n in a b c d e f g{
gen teen`n'=(r4`n'<=19&r4`n'>=13)
gen baby`n'=(r4`n'<=3)
gen female`n'=(r2`n'==2)
gen workr7`n'=(r7`n'<=30)
}
drop if spid==.



foreach x in teen baby female workr7{
egen `x'bed=rowtotal(`x'a `x'b `x'c `x'd `x'e `x'f `x'g)

sort mhid spid
by mhid: egen `x'total=total(`x'bed)
gen `x'other=`x'total-`x'bed
}


drop if sp3!=1&sp3!=2
gen mqnbed=(sp5==1)
gen floor=(sp3==2)

egen  bedmember=rownonmiss(sp4a-sp4g)
gen floor_bedmember=floor*bedmember

save C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\forpaper\netdemand.dta,replace

use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\3rd\e_combine_3rd.dta ,clear

collapse (max) HH_salary_6 HH_self_6  tail campnet, by(mhid)
gen incomepercapita=(HH_salary+HH_self)/tail

keep mhid incomepercapita campnet

save income.dta,replace

use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\forpaper\netdemand.dta,clear

merge m:1 mhid using income.dta
erase income.dta

gen incomeperbed=incomepercapita*bedmember

save C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\forpaper\netdemand.dta,replace


hetprob mqnbed bedmember teenbed femalebed  babybed workr7bed floor_bedmember teenother femaleother babyother workr7other  incomeperbed campnet i.spgrap, het(bedmember )

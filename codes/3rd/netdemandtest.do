clear all
local N=100
local K=3
local a=10
local sigma=1
set obs `N'
gen hhid=_n
gen bednumber= 1+int((`K'-1+1)*runiform())
*gen bednumber= 1
forval i=1/`K'{
gen bedmember`i'=1+int((4-1+1)*runiform())
}

forval i=1/`K'{
replace bedmember`i'=. if bednumber<`i'
}

egen hhsize=rowtotal(bedmember1-bedmember`K')

forval i=1/`K'{
gen bedX`i'=int((bedmember`i'+1)*runiform())
}

gen var=`sigma'/hhsize
forval i=1/`K'{
drawnorm bede`i', cov(`sigma')
replace bede`i'=bede`i'*(bedmember`i'/hhsize)^0.5
}

local p=9

gen hhincome= 9.001+int((20-9+1)*runiform())
*gen hhincomesq=`a'*hhincome^0.5
*gen hhincome1psq=`a'*(hhincome-`p'/hhsize)^0.5
*gen hhincome2psq=`a'*(hhincome-2*`p'/hhsize)^0.5
gen hhincome3psq=`a'*(hhincome-3*`p'/hhsize)^0.5

gen lhhincome=`a'*log(hhincome)
gen lhhincome1=`a'*log(hhincome-`p'/hhsize)
gen lhhincome2=`a'*log(hhincome-2*`p'/hhsize)
gen lhhincome3=`a'*log(hhincome-3*`p'/hhsize)

gen V21=0 if bednumber==2
gen V22=bedX2+bede2+lhhincome1- lhhincome if bednumber==2
gen V23=bedX1+bede1+lhhincome1- lhhincome if bednumber==2
gen V24=bedX1+bede1+bedX2+bede2+lhhincome2- lhhincome if bednumber==2
egen maxV2=rowmax(V21 V22 V23 V24)

gen V31=0 if bednumber==3
gen V32=bedX3+bede3+lhhincome1- lhhincome if bednumber==3
gen V33=bedX2+bede2+lhhincome1- lhhincome if bednumber==3
gen V34=bedX2+bede2+bedX3+bede3+lhhincome2- lhhincome if bednumber==3
gen V35=bedX1+bede1+lhhincome1- lhhincome if bednumber==3
gen V36=bedX1+bede1+bedX3+bede3+lhhincome2- lhhincome if bednumber==3
gen V37=bedX1+bede1+bedX2+bede2+lhhincome2- lhhincome if bednumber==3
gen V38=bedX1+bede1+bedX2+bede2+bedX3+bede3+lhhincome3- lhhincome if bednumber==3
egen maxV3=rowmax(V31-V38)


gen decision1 =2 if bednumber==1& bedX1+bede1+lhhincome1- lhhincome>=0
replace decision1=1 if bednumber==1&bedX1+bede1+lhhincome1 - lhhincome<0

gen decision2=.
forvalue i=1/4{
replace decision2=`i' if  bednumber==2&maxV2==V2`i' 
}
gen decision3=.
forvalue i=1/8{
replace decision3=`i' if  bednumber==3&maxV3==V3`i' 
}

egen decision=rowmax(decision1-decision3)

outsheet bedX1-bedX3 using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\Xtest.csv , comma nolabel noname replace

outsheet bednumber using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\bednumbertest.csv , comma nolabel noname replace
outsheet bedmember1-bedmember3 using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\bedmembertest.csv , comma nolabel noname replace
outsheet hhincome using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\hhincometest.csv , comma nolabel noname replace

outsheet decision using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\decisiontest.csv , comma nolabel noname replace

outsheet hhid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\netdemand\hhid.csv , comma nolabel noname replace

exit
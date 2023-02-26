clear all
set more off
set obs 1000
gen x=runiform()
gen ex=exp(-x)
drawnorm e,n(1000)
gen y=x+ex+1+e

forval i=5/100{
reg y if abs((x-0.5)/(`i'/100))<1, robust
matrix cb`i'=e(b)
gen c`i'=cb`i'[1,1]
reg y x ex if abs((x-0.5)/(`i'/100))<1, robust
matrix lb`i'=e(b)
gen b1`i'=lb`i'[1,1]
gen b2`i'=lb`i'[1,2]
gen b3`i'=lb`i'[1,3]
gen l`i'=b3`i'+0.5*b1`i'+exp(-0.5)*b2`i'
}

keep in 1
drop x ex e y 

gen k=1
reshape long l c ,i(k) j(n)
graph twoway line l n || line c n


exit
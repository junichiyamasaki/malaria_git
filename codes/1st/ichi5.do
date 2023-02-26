clear all
set more off
set matsize 10000
drawnorm e,n(1000)
drawnorm x1,n(1000)
drawnorm x2,n(1000)
gen y=1+x1+x2+e
replace y=0 if y<=0

clad y x1 x2

exit


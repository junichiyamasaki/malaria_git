clear all
set more off
set obs 1000
gen x=runiform()
gen ex=exp(-x)+x
drawnorm e,n(1000)
gen y=ex+1+e
gen y2=ex+1


graph twoway scatter y2 ex ||lowess y ex, bwidth(0.2)  lpattern(  solid)||lowess y ex, bwidth(0.4) lpattern(  dash)||lowess y ex, bwidth(0.6) lpattern(dot)||lowess y ex, bwidth(0.8) lwidth(thick)lpattern(dash_dot)||lowess y ex, bwidth(1.0) lwidth(thick) lpattern(shortdash)||,legend(label(1 "actual")label(2 "0.2")label(3 "0.4")label(4 "0.6")label(5 "0.8")label(6 "1.0"))       

exit
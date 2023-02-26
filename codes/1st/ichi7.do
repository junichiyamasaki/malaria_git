clear all
set matsize 10000
set memory 1g

local N=1000
drawnorm e,n(`N')
gen x1= runiform()
gen x2= runiform()
gen y=exp(x1+x2)+e
etime, start
nl sim @ y x1 x2, parameter(b2) initial(b2 0.9)
etime

exit
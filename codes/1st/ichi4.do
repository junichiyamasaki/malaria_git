clear all
set more off
set matsize 10000
drawnorm e,n(1000)
drawnorm x1,n(1000)
drawnorm x2,n(1000)
drawnorm x3,n(1000)
gen y=1+x1+2*x2+3*x2*x3+e

mkmat x2 x3

forvalue i =1/1000{

gen x2c`i'=(x2-x2[`i',1])
gen x3c`i'=(x3-x3[`i',1])
gen weight`i'=normalden(x2c`i')*normalden(x3c`i')
quietly:reg y x2c`i' x3c`i' [iweight=weight`i']
predict yhat`i', residual
quietly:reg x1 x2c`i' x3c`i' [iweight=weight`i']
predict x1hat`i', residual
drop weight`i' x2c`i' x3c`i'
}

mkmat yhat*, matrix(yhat)
mkmat x1hat*, matrix(x1hat)

matrix yhatdiag=(vecdiag(yhat))'
matrix x1hatdiag=(vecdiag(x1hat))'

svmat yhatdiag
svmat x1hatdiag

reg yhatdiag1 x1hatdiag1,noconstant



exit
clear
set more off
drawnorm x,n(100)
drawnorm e,n(100)
gen y=x+1+e
gen k=1

forval i=2/1000{
reg y x, vce(bootstrap, reps(`i'))
matrix mv`i'=e(V)
gen v1`i'=mv`i'[1,1]
gen v2`i'=mv`i'[2,2]
}

keep in 1
drop x y e

reshape long v1 v2,i(k) j(n)
graph twoway line v1 n || line v2 n

exit
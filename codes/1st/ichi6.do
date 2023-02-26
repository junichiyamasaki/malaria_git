clear all

set matsize 10000
set memory 1g

local N=1000
drawnorm e,n(`N')
drawnorm x1,n(`N')
drawnorm x2,n(`N')
gen y=1+x1*x2+x2*exp(-x1^2)+e

mkmat x1 x2


forvalue i =1/`N'{

*generate x1-s, x2-t
gen x1c`i'=(x1-x1[`i',1])
gen x2c`i'=(x2-x2[`i',1])

* y on local polynomial to get e and beta
gen weight`i'=normalden(x1c`i')*normalden(x2c`i')
quietly:reg y (c.x1c`i' c.x2c`i')##(c.x1c`i' c.x2c`i')##(c.x1c`i' c.x2c`i')  [iweight=weight`i']
predict ehat`i', residual
mkmat ehat`i'
matrix ehattotal=(nullmat(ehattotal),ehat`i')
matrix beta`i'=e(b)
matrix betatotal=(nullmat(betatotal),beta`i'')

* kernel reg to get f 

egen f`i'=mean(weight`i')

* kernel reg to get f'
gen d1_`i'=-x1c`i'*normalden(x1c`i')*normalden(x2c`i')
gen d2_`i'=-x2c`i'*normalden(x1c`i')*normalden(x2c`i')
gen d12_`i'=x1c`i'*x2c`i'*normalden(x1c`i')*normalden(x2c`i')

egen d1f`i'=mean(d1_`i')
egen d2f`i'=mean(d2_`i')
egen d12f`i'=mean(d12_`i')

mkmat d1f`i' d2f`i' d12f`i' f`i'


matrix ftotal=(nullmat(ftotal),f`i')
matrix d1ftotal=(nullmat(d1ftotal),d1f`i')
matrix d2ftotal=(nullmat(d2ftotal),d2f`i')
matrix d12ftotal=(nullmat(d12ftotal),d12f`i')

drop weight`i' x1c`i' x2c`i' ehat`i' d1_`i' d2_`i' d1f`i' d2f`i' d12f`i' d12_`i' f`i'
matrix drop ehat`i' beta`i' d1f`i' d2f`i' d12f`i'  
}

matrix I=J(`N',1,1/`N')
matrix bave=betatotal*I
matrix list bave

*to get beta's variance
* first, get  betahat- beta for each sample
matrix betadevi=betatotal-bave*J(1,`N',1)

*we only need the first two beta (coeffecient of x1 and x2)
matrix betadevi=betadevi[1..2,1..`N']'
svmat betadevi
gen  betadevi1sqrd= betadevi1^2
gen  betadevi2sqrd= betadevi2^2
gen  betadevi12= betadevi1*betadevi2

egen  varbetadevi1=total(betadevi1sqrd)
egen  varbetadevi2=total(betadevi2sqrd)
egen  varbetadevi12=total(betadevi12)

gen  varbeta1=varbetadevi1/(`N'-1)
gen  varbeta2=varbetadevi2/(`N'-1)
gen  varbeta12=varbetadevi12/(`N'-1)

*obtain the diagonal
matrix ftotal=(vecdiag(ftotal))'
matrix d1ftotal=(vecdiag(d1ftotal))'
matrix d2ftotal=(vecdiag(d2ftotal))'
matrix d12ftotal=(vecdiag(d12ftotal))'
matrix ehattotal=(vecdiag(ehattotal))'

*make the matrix into stata
svmat ftotal
svmat d1ftotal
svmat d2ftotal
svmat d12ftotal
svmat ehattotal

gen var1x=(ehattotal^2*d1ftotal^2)/(ftotal^2)
gen var2x=(ehattotal^2*d2ftotal^2)/(ftotal^2)
gen var12x=(ehattotal^2*d12ftotal^2)/(ftotal^2)

egen var1x2=mean(var1x)
egen var2x2=mean(var2x)
egen var12x2=mean(var12x)

gen var1=(var1x2+ varbeta1)
gen var2=(var2x2+ varbeta2)
gen var12=(var12x2+varbeta12)

matrix list bave
exit
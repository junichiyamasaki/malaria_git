program nlsim
	version 11
	syntax varlist(min==3 max==3) [if],at(name)
	local y: word 1 of `varlist'
	local n : word count `varlist'
	local x1= word 2 of `varlist'
	local x2= word 3 of `varlist'
	 
	tempname b2
	scalar `b2'=`at'[1,1]

	tempvar xb
	generate double `xb'=`x1'+`x2'*`b2' `if'
	
	tempname xb yhattotal
	mkmat xb
	
	
	forvalue i =1/_N{
		tempvar xb`i' weight`i' yhat`i'
		tempname yhat`i'
		gen xb`i'=(xb-xb[`i',1])
		gen weight`i'=normalden(xb`i')
		quietly:reg y xb`i' [iweight=weight`i']
		predict yhat`i'
		mkmat yhat`i'
		matrix yhattotal=(nullmat(yhattotal),yhat`i')
	}
	
	matrix yhattotal=(vecdiag(yhattotal))'
	svmat yhattotal
	replace `y'= yhatotal `if'
end
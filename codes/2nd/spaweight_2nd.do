* Spatial weighting
    keep if mhlon!=.&mhlat!=.&miid09!=.
	local lon mhlon
	local lat mhlat
	local max1   250000
	local max2 1000000
	local max3 4000000
	*put the maximum distance (m) in squared value
	tempvar scalar
	local n _N
	tempname ma mb mad mbd mad2 mbd2 

	mkmat mhlon, matrix(`ma')
	mkmat mhlat, matrix(`mb')
	matrix `ma'=`ma'#J(1,_N,1)
	matrix `mb'=`mb'#J(1,_N,1)
	matrix `mad'=(`ma'-`ma'')*1000*600/7.5
	matrix `mbd'=(`mb'-`mb'')*1000*600/5

	matrix `mad2' = hadamard(`mad',`mad')
	matrix `mbd2' = hadamard(`mbd',`mbd')
	matrix distsq=`mad2'+`mbd2'
	
	matrix dist1=J(_N,_N,1)
	matrix dist2=J(_N,_N,1)
	matrix dist3=J(_N,_N,1)
	
	forvalues j =1/`=_N'{
	forvalues k =1/`=_N'{
		matrix dist1[`j',`k']= cond(`max1'-distsq[`j',`k']>=0,1,0) 
		matrix dist2[`j',`k']= cond(`max2'-distsq[`j',`k']>=0,1,0) 
		matrix dist3[`j',`k']= cond(`max3'-distsq[`j',`k']>=0,1,0) 
	}
	}
	
	forvalue j = 1/`=_N'{
	matrix dist1[`j' ,`j' ]=0
	matrix dist2[`j' ,`j' ]=0
	matrix dist3[`j' ,`j' ]=0
	}
	
	matrix pop1=dist1*J(`=_N',1,1)
	svmat long pop1, name(pop1) 
	matrix pop2=dist2*J(`=_N',1,1)
	svmat long pop2, name(pop2) 
	matrix pop3=dist3*J(`=_N',1,1)
	svmat long pop3, name(pop3) 
	
	foreach var of varlist rdt mqnid{
	replace  `var'=0 if `var'==.
	mkmat `var', matrix(varmat)
	matrix spvar1=dist1*varmat
	matrix spvar2=dist2*varmat
	matrix spvar3=dist3*varmat
	svmat long spvar1, name(spatial`var'1) 
	svmat long spvar2, name(spatial`var'2) 
	svmat long spvar3, name(spatial`var'3) 
	matrix drop varmat spvar1 spvar2 spvar3
	}
	matrix drop dist1 dist2 dist3 distsq pop1 pop2 pop3
	clear matrix
	*drop the dropped
drop if (r0dx==2 | r0dx==3 | r0dx==4| r0dx==5|r0dx==9)
drop if (mh3ax==2|mh3ax==3)
	keep miid09 spatial* pop*
	*ma is column vector longitude


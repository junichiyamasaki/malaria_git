use balance, clear
replace h2=0 if h1==2

collapse (max)rdt h17 h16 h2 h3, by (mhid)
tab rdt h16,r
tab rdt h17,r
tab h2 h16,r
tab h2 h17,r


exit
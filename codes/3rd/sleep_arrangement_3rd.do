*

use data/rawdata/3rd/e_sleep_arrangement_3rd.dta,replace
set more off
for num 1/15: gen spw1X=0
for num 1/15: replace spw1X=sp4a if sp4a==X|sp4b==X|sp4c==X|sp4d==X|sp4e==X
for num 1/15: gen spw2X=0
for num 1/15: replace spw2X=sp4b if sp4a==X|sp4b==X|sp4c==X|sp4d==X|sp4e==X
for num 1/15: gen spw3X=0
for num 1/15: replace spw3X=sp4c if sp4a==X|sp4b==X|sp4c==X|sp4d==X|sp4e==X
for num 1/15: gen spw4X=0
for num 1/15: replace spw4X=sp4d if sp4a==X|sp4b==X|sp4c==X|sp4d==X|sp4e==X
for num 1/15: gen spw5X=0
for num 1/15: replace spw5X=sp4e if sp4a==X|sp4b==X|sp4c==X|sp4d==X|sp4e==X


for num 1/15: gen bedidX=.
for num 1/15: replace bedidX=sp3 if sp4a==X|sp4b==X|sp4c==X|sp4d==X|sp4e==X
for num 1/15: bysort  mhid: egen bedX =max( bedidX )


for num 1/15: gen bedmqnidX=.
for num 1/15: replace bedmqnidX=sp5 if sp4a==X|sp4b==X|sp4c==X|sp4d==X|sp4e==X
for num 1/15: bysort  mhid: egen bedmqnX =max( bedmqnidX )

collapse (max) spw11-spw115 spw21-spw215 spw31-spw315  spw41-spw415 spw51-spw515 bedid1-bedid15 bedmqn1-bedmqn15, by(mhid)

reshape long bedid bedmqn spw1 spw2 spw3 spw4 spw5, i(mhid) j(hl1)

save data/intermediate/3rd/e_sleep_arrangementcov_3rd.dta,replace


use data/rawdata/3rd/e_sleep_arrangement_3rd.dta,replace
drop if sp3==.
drop if sp3==4
egen nofbed=count(sp3), by(mhid)
keep mhid nofbed
collapse nofbed, by(mhid)
save data/intermediate/3rd/nofbed_3rd.dta,replace

exit
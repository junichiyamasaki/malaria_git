use mqnidver,clear
collapse (sum) mqnidh ntrnmqnidh, by (mhid)
save numinnets, replace


use LISTE_INDIVIDU_MENAGE ,clear

collapse (count) hl1, by (mhid)
rename hl1 numhh
save numhh, replace



use MENAGE.dta, clear

merge 1:m  mhid using numhh

graph twoway scatter numhh h3

rename _merge _merge2

merge 1:m  mhid using numinnets
label var mqnidh "the number of members in nets"
label var ntrnmqnidh "the number of members in nets not torn"
tab mqnidh numhh
tab ntrnmqnidh numhh
exit
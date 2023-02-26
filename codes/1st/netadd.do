
use LISTE_INDIVIDU_MENAGE.dta, clear

merge 1:m mhid hl1 using mqnidver

tab 
exit
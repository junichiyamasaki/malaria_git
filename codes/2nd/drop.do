cd C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\1st
do combine
cd C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\2nd
do combine_2nd

use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\1st\e_combine.dta,clear
rename mhid mhid09
rename miid miid09
save e_drop_2nd, replace

use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\2nd\e_combine_2nd.dta,clear

//���ڂł��Ȃ��Ȃ����l�͍��
drop if (r0dx==2 | r0dx==3 | r0dx==4| r0dx==5|r0dx==9)
//���ڂœ����Ȃ������l�����
drop if (mh3ax==2|mh3ax==3)

//���ڂ���̐V�����l�́A���ڂ�id(miid)��10�{������id(miid09)�ɂ���@�������Ⴄ�̂ł��Ԃ�Ȃ��B
replace miid09=10*miid if miid09==.

merge 1:1 miid09 using e_drop_2nd, gen(second)

gen seconddrop=(second==2)

keep if second>=2
keep miid09 seconddrop 
save e_drop_2nd, replace

use pre_2nd,clear
merge m:1 miid09 using e_drop_2nd, gen(checkdrop)
exit
use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\1st\e_combine.dta,clear
merge 1:1 miid using e_drop_2nd, gen(checkdrop)

reg  seconddrop (c.mqnid c.rdt c.cschool c.female)#c.G mqnid rdt cschool female if phase==1, robust
eststo

esttab using drop_2nd.tex,  dropped style(tex) replace   substitute(# and) p 
eststo clear

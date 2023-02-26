cd C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\1st
do combine
cd C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\2nd
do combine_2nd

use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\1st\e_combine.dta,clear
rename mhid mhid09
rename miid miid09
append using e_combine_2nd, generate(fs) 


rename d G
gen D=(G==1&phase==2)

save e_crosssection_2nd, replace

//���ڂł��Ȃ��Ȃ����l�͍��
drop if (r0dx==2 | r0dx==3 | r0dx==4| r0dx==5|r0dx==9)
//���ڂœ����Ȃ������l�����
drop if (mh3ax==2|mh3ax==3)

drop if mi1==.
tostring miid,replace
gen miidtest=reverse(substr(reverse(miid),1,2)+substr(reverse(miid),4,.))
destring miidtest,replace
replace miid09=miidtest if miid09==.
destring miid,replace


*//���ڂ���̐V�����l�́A���ڂ�id(miid)��10�{������id(miid09)�ɂ���@�������Ⴄ�̂ł��Ԃ�Ȃ��B
*replace miid09=10*miid if miid09==.

xtset miid09 phase

save e_panel_2nd, replace

exit
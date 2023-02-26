set more off

use data/rawdata/2nd/e_crosssection_2nd.dta,clear
append using data/intermediate/3rd/e_combine_3rd, generate(fs2) 

save e_crosssection_3rd, replace


use data/rawdata/2nd/e_panel_2nd.dta,clear
append using data/intermediate/3rd/e_combine_3rd, generate(fs2) 


//���ڂł��Ȃ��Ȃ����l�͍��
drop if (r0dx==2 | r0dx==3 | r0dx==4| r0dx==5|r0dx==9)
//���ڂœ����Ȃ������l�����
drop if (mh3ax==2|mh3ax==3)

//3rd����̐V�����l�𗎂Ƃ�
drop if miid09==.

//������Ɨǂ������l������
drop if  miid09==411901
//drop if  miid09 == 414103
//drop if  miid09 == 414101

drop if mi1==.




xtset miid09 phase

//�x�b�g�̐��͋��ʂƂ���
replace nofbed=F.nofbed if phase==2
replace nofbed=F2.nofbed if phase==1


//1nd2nd��2nd3rd�̑؍݊���
gen stay1st2nd=r0caxx
replace stay1st2nd=F.stay1st2nd if phase==2
replace stay1st2nd=F2.stay1st2nd if phase==1


gen stay2nd3rd=r0faxx
replace stay2nd3rd=F.stay2nd3rd if phase==2
replace stay2nd3rd=F2.stay2nd3rd if phase==1

//2nd3rd��id��1st�ɓK��
replace miid=F.miid if phase==1

merge m:1 miid using data/rawdata/4th/experimentcoded,generate(_mergeexperiment)

sort miid09 phase
label define freemqn 1 "purchased" 2 "free" 3"big campaign" 9 "missing",replace
label value freemqn freemqn

save data/intermediate/e_panel_3rd,replace


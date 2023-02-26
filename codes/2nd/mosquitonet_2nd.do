set more off
do mosquitonetlabel_2nd


//�l�l��camp�̉ᒠ�ŐQ�Ă��邩�ǂ���
gen campnet=0
replace campnet=1 if (h5==2&(h6==1|h6==3)&h4==2009&h4ax==12)|(h5==2&(h6==1|h6==3)&h4==2010&h4ax==1)
for num 1/15: gen campmqnidX=0
for num 1/15: replace campmqnidX=1 if campnet==1&(h71==X|h72==X|h73==X|h74==X|h75==X)
for num 1/15: bysort  mhid: egen campmqnidhX =total( campmqnidX )




// �l�l���ᒠ�ŐQ�Ă��邩�ǂ���
for num 1/15: gen mqnidX=0
for num 1/15: replace mqnidX=1 if h71==X|h72==X|h73==X|h74==X|h75==X
for num 1/15: bysort  mhid: egen mqnidhX =total( mqnidX )

//�l�l��LLITN�ŐQ�Ă��邩
for num 1/15: gen llitnidX=0
for num 1/15: replace llitnidX=1 if (h71==X&h10<=5)|(h72==X&h10<=5)|(h73==X&h10<=5)|(h74==X&h10<=5)|(h75==X&h10<=5)
for num 1/15: bysort  mhid: egen llitnidhX =total( llitnidX )

//�l�l���j��Ă��Ȃ��ᒠ�ŐQ�Ă��邩�ǂ���
for num 1/15: gen ntmqnidX=0
for num 1/15: replace ntmqnidX=1 if (h71==X&h9==2&h10<=5)|(h72==X&h9==2)|(h73==X&h9==2)|(h74==X&h9==2)|(h75==X&h9==2)
for num 1/15: bysort  mhid: egen ntmqnidhX =total( ntmqnidX )

//�l�l���j��Ă��Ȃ�LLITN�ŐQ�Ă��邩�ǂ���
for num 1/15: gen ntllitnidX=0
for num 1/15: replace ntllitnidX=1 if (h71==X&h9==2&h10<=5)|(h72==X&h9==2&h10<=5)|(h73==X&h9==2&h10<=5)|(h74==X&h9==2&h10<=5)|(h75==X&h9==2&h10<=5)
for num 1/15: bysort  mhid: egen ntllitnidhX =total( ntllitnidX )

//���������ᒠ�ŐQ�Ă��邩
for num 1/15: gen netyearidX=.
for num 1/15: replace netyearidX=h4 if h71==X|h72==X|h73==X|h74==X|h75==X
for num 1/15: bysort  mhid: egen netyearhX =max( netyearidX )

////�ǉ���
//��������ᒠ�ŐQ�Ă��邩
for num 1/15: gen freemqnX=.
for num 1/15: replace freemqnX=h5 if h71==X|h72==X|h73==X|h74==X|h75==X
for num 1/15: bysort  mhid: egen freemqnhX =max( freemqnX )


//�ǂ��Ŕ������ᒠ�ŐQ�Ă��邩
for num 1/15: gen mqnshopX=.
for num 1/15: replace mqnshopX=h6 if h71==X|h72==X|h73==X|h74==X|h75==X
for num 1/15: bysort  mhid: egen mqnshophX =max( mqnshopX )

////�����܂�


// �l�l���N�ƐQ�Ă��邩
for num 1/15: gen mqnw1X=0
for num 1/15: replace mqnw1X=h71 if h71==X|h72==X|h73==X|h74==X|h75==X
for num 1/15: gen mqnw2X=0
for num 1/15: replace mqnw2X=h72 if h71==X|h72==X|h73==X|h74==X|h75==X
for num 1/15: gen mqnw3X=0
for num 1/15: replace mqnw3X=h73 if h71==X|h72==X|h73==X|h74==X|h75==X
for num 1/15: gen mqnw4X=0
for num 1/15: replace mqnw4X=h74 if h71==X|h72==X|h73==X|h74==X|h75==X
for num 1/15: gen mqnw5X=0
for num 1/15: replace mqnw5X=h75 if h71==X|h72==X|h73==X|h74==X|h75==X

collapse (max) campmqnidh1-campmqnidh15 mqnidh1-mqnidh15 llitnidh1-llitnidh15 ntmqnidh1-ntmqnidh15 ntllitnidh1-ntllitnidh15 netyearh1-netyearh15  mqnw11-mqnw115 mqnw21-mqnw215 mqnw31-mqnw315 mqnw41-mqnw415 mqnw51-mqnw515 freemqnh* mqnshoph*, by (mhid)


reshape long campmqnidh mqnidh llitnidh ntmqnidh ntllitnidh netyearh mqnw1 mqnw2 mqnw3 mqnw4 mqnw5 freemqnh mqnshoph, i(mhid) j(hl1)
rename mqnidh mqnid
label var mqnid "sleep in a net"
rename llitnidh llitnid
label var llitnid "sleep in a LLITN"
rename ntllitnidh ntllitnid
label var ntmqnid "sleep in a not broken net"
rename ntmqnidh ntmqnid
label var ntllitnid "sleep in a not broken LLITN"
rename netyearh netyear
label var netyear "when the net you sleeping in was bought"
rename campmqnidh campmqnid
label var mqnid "sleep in a net distributed in the campaign"
rename freemqnh freemqn
label var freemqn "Free or purchased net"
rename mqnshoph mqnshop

label define freemqn 1 "purchased" 2 "free" 9 "missing"
label value freemqn freemqn
label var mqnshop "Using net come from"
label define mqnshop 1 "health center" 2 "pharmacy / shop / ngo" 3 "city / community room or house" 4 "issued by ngos" 5 "issued by midwife" 6 "parents / friends" 7 "other" 8 "do not know" 9 "missing"
label value mqnshop mqnshop
save e_MQNCONVERT_2nd,replace

*�L�����y�[���Ŕz��ꂽ�ᒠ���ۂ� net distribution in Ambalahasina and Mahatsara fokontany was done on December 22th. 
use e_MOUSTIQUAIRE_2nd,clear 
gen campnet=0
replace campnet=1 if (h5==2&(h6==1|h6==3)&h4==2009&h4ax==12)|(h5==2&(h6==1|h6==3)&h4==2010&h4ax==1)
gen campnet0912=0
replace campnet0912=1 if (h5==2&(h6==1|h6==3)&h4==2009&h4ax==12)
gen campnet1001=0
replace campnet1001=1 if (h5==2&(h6==1|h6==3)&h4==2010&h4ax==1)

*�L�����y�[���Ŕz��ꂽ�ᒠ���g���Ă��邩

gen campnetuse=0
replace campnetuse=1 if campnet==1&(h71!=.|h72!=.|h73!=.|h74!=.|h75!=. )
gen campnetnotuse=0
replace campnetnotuse=1 if campnet==1&(h71==.&h72==.&h73==.&h74==.&h75==. )
egen bedmember=rownonmiss(h71 h72 h73 h74 h75)

*�j��Ă���ᒠ�̖���
gen noftorned=.
replace noftorned=1 if h9==1

*�N���j�b�N�������͏��Y�w�ɖ��������
gen nofpregnet=.
replace nofpregnet=1 if h6==1|h6==5


collapse (sum) campnet campnet0912 campnet1001 noftorned campnetnotuse nofpregnet campnetuse, by (mhid)
label define campnet 0 0 1 1 2 2 3 3 4 4 5 5 6 6 7 7
label value campnet campnet0912 campnet1001 noftorned campnet
save e_MQNHHCONVERT_2nd,replace
exit
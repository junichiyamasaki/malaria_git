cd C:\Users\J.YAMASAKI\Documents\stata11data\malaria\2nd
set more off

use e_combine_2nd.dta,replace

log using codebook_2nd,replace
codebook ,  tabulate(20) 
log close 


log using codebookid_2nd,replace
codebook micom mifkt miloc mhid miid hl1 r0bx r0cx r0dx r2 r3 r4 r5 r6 r7y r7ax  r8 r9 r9ax r10 r10ax r11* r12* r13* e1 e2 e2ax e3 e4ax e5 e6 e7y e8x e9x e10x t1-t16 h18a h18b h19a h19b h20a h20b h21-h29 h31 h32 h33 h34x h35x h36x i1x-i10x flr7a flr7b flr8a flr8b flr9a flr9b flr10a flr10b flr11a flr11b flr12a flr12b flr13a flr13b flr14x  flr15x ,  tabulate(20) 
log close 


log using codebookhh_2nd,replace
codebook micom mifkt miloc tail k1 h1ax   k2a k2b k2c k2d k2e k2f k2h k2i k2j k2k k2l k2m  k3a k3b k3c k3d k3e k3f k3g k4 k4aax k4abx k4acx k5a k5b k5c k5d k5e k5f k5g k5h k5i k5x k6 k7a k7b k7c k7d k7e k7f k7g k7x k8a k8b k8c k8d k8e k8f k8g k8h k8i k8j k8k k8x  k9 k10 k11 k12 k13a k13b k13c k13d k13e k13f k14a k14b k14c k14d k14e k14f k14g k14h k14i h1 h2 h3 h14 h15 h16 h17 h17ax h17bx ea1-ea6 ea7x eb1-eb6 ec1-ec6 ec7x ecax1 ecax2 ecax3 ecax4 ecax5 ecax6 eca7x ed1-ed4 c1 c2 a1-a28 if r3==1 ,  tabulate(20) 
log close 



log2html codebook_2nd,replace
log2html codebookid_2nd,replace
log2html codebookhh_2nd,replace

use e_MOUSTIQUAIRE_2nd,replace
log using codebookmqn_2nd,replace
codebook h4-h6bx h8-h13
log close 
log2html codebookmqn_2nd,replace
exit

r11* r12* r13* e8x i1x i3x i5x i8x missing
h1ax   

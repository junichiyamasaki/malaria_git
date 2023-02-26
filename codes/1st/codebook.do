cd C:\Users\J.YAMASAKI\Documents\stata11data\malaria\1st
set more off

use e_combine.dta,replace

log using codebook,replace
codebook ,  tabulate(20) 
log close 


log using codebookid,replace
codebook micom mifkt miloc mhid miid hl1 r2 r3 r4 r5 r6 r7 r8 r9 r10 e1 e2 e3 e4a e4b e4c e5 e6 e7 t1-t16 h18a h18b h19a h19b h20a h20b h21-h29 h31 h32 h33 flr7a flr7b flr8a flr8b flr9a flr9b flr10a flr10b flr11a flr11b flr12a flr12b flr13a flr13b,  tabulate(20) 
log close 


log using codebookhh,replace
codebook micom mifkt miloc tail k1  k2a k2b k2c k2d k2e k2f k2h k2i k2j k2k k2l k2m  k3a k3b k3c k3d k3e k3f k3g k4 k5a k5b k5c k5d k5e k5f k5g k5h k5i k5x k6 k7a k7b k7c k7d k7e k7f k7g k7x k8a k8b k8c k8d k8e k8f k8g k8h k8i k8j k8k k8x  k9 k10 k11 k12  k13a k13b k13c k13d k13e k13f k14a k14b k14c k14d k14e k14f k14g k14h k14i h1 h2 h3 h14 h15 h16 h17 ea1-ea6 eb1-eb6 ec1-ec6 ed1-ed4 c1 c2 a1-a28 if r3==1 ,  tabulate(20) 
log close 



log2html codebook,replace
log2html codebookid,replace
log2html codebookhh,replace

use e_MOUSTIQUAIRE,replace
log using codebookmqn,replace
codebook h4-h6 h8-h13
log close 
log2html codebookmqn,replace
exit

r5 r9 r10 e4b e5 t1 t4-t16 h18a h24 e2f e2ff e2m e2mm   ‚±‚±‚Ü‚Å k1 k3a k3c k5 k5i k5j k8 k12 k14

ee117013
3s9xi2nmWt
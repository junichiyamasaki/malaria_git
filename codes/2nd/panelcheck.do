use e_panel_2nd,replace
gen dr4=D.r4
gen dr2=D.r2
gen de1=D.e1
gen de3=D.e3
gen lhl1=L.hl1

drop if phase==1
drop if  r0cx==2
keep miid miid09 hl1 lhl1 dr4 r4 dr2 r2  de1 e1 de3 e3 hl1 mih2ax flr1x
drop if (dr4==0|dr4==1)&(dr2==0|dr2==.)&(de1==0|de1==.)
order miid miid09 hl1 lhl1 dr4 r4 dr2 r2 de1 e1 de3 e3 dr2 r2 mih2ax flr1x
exit


use data/intermediate/forpaper/foranalysis,clear


gen info=k14g
replace info=0 if k14g==2

gen cons=1
label var G "Treatment"
label var cons "Control - Treatment"

label var mqnid "Sleep in a Net"
label var info "Knowledge of Usefulness"
label var hhsize "HH Size"
label var mqnhh "Members Using Net"
label var nofnet "N. of Possesed Net"
label var mhalt "Altitude"
label var info "Knowledge of Usefulness"
label var age60 "Age"
label var e1 "School Enrollment Experience"

gen fullbound=0
replace fullbound=1 if bound==1
label define fullbound 0 "Full Sample" 1 "Seaside Sample"
label value fullbound fullbound
qui: eststo clear


estpost ttest rdt mqnid  absence absence2   if phase==1&(teen==1|underteen==1),by(G)
esttab using "draft/descriptive_children.tex",cell("mu_1(label(Untreated)) mu_2(label(Treated)) b(label(Diff)) se(label(s.e.)) N_1(label(Untreated N)) N_2(label(Treated N))") nonumber label replace
eststo clear

estpost ttest rdt mqnid  absence absence2 if phase==1&bound==1&(teen==1|underteen==1),by(G)
esttab using "draft/descriptiveb_children.tex",cell("mu_1(label(Untreated)) mu_2(label(Treated)) b(label(Diff)) se(label(s.e.)) N_1(label(Untreated N)) N_2(label(Treated N)) ") nonumber label replace
eststo clear


**Household level

estpost ttest nofnet hhsize mqnhh info mhalt   if phase==1&r3==1,by(G)
esttab using "draft/descriptiveh.tex", cell("mu_1(label(Untreated)) mu_2(label(Treated)) b(label(Diff)) se(label(s.e.)) N_1(label(Untreated N)) N_2(label(Treated N))") nonumber label replace
eststo clear

estpost ttest nofnet hhsize mqnhh info mhalt  if phase==1&r3==1&bound==1,by(G)
esttab using "draft/descriptivehb.tex",cell("mu_1(label(Untreated)) mu_2(label(Treated)) b(label(Diff)) se(label(s.e.)) N_1(label(Untreated N)) N_2(label(Treated N))") nonumber label replace
eststo clear

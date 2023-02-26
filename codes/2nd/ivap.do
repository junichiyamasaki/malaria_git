use pre_2nd,clear


eststo clear

ivregress  2sls rdt teen cschool female lmqnid lvillagerdt (mqnid mqnidandteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlvillagerdt=D Dandteen Dandfemale Dandcschool Dandlmqnid Dandlvillagerdt), vce(bootstrap, seed(1)  cluster(migrap) idcluster(newid) group(miid09) reps(100)   reject( abs(_b[teen])>10 | abs(_b[cschool])>10 | abs(_b[female])>10 | abs(_b[lmqnid])>10 | abs(_b[lvillagerdt])>10| abs(_b[mqnid])>10 | abs(_b[mqnidandteen])>10 | abs(_b[mqnidandfemale])>10| abs(_b[mqnidandcschool])>10 | abs(_b[mqnidandlmqnid])>10 | abs(_b[mqnidandlvillagerdt])>10))  
eststo

ivregress  2sls drdt teen cschool female lmqnid lvillagerdt (mqnid mqnidandteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlvillagerdt=D Dandteen Dandfemale Dandcschool Dandlmqnid Dandlvillagerdt), vce(bootstrap, seed(1)  cluster(migrap) idcluster(newid) group(miid09) reps(100)   reject( abs(_b[teen])>10 | abs(_b[cschool])>10 | abs(_b[female])>10 | abs(_b[lmqnid])>10 | abs(_b[lvillagerdt])>10| abs(_b[mqnid])>10 | abs(_b[mqnidandteen])>10 | abs(_b[mqnidandfemale])>10| abs(_b[mqnidandcschool])>10 | abs(_b[mqnidandlmqnid])>10 | abs(_b[mqnidandlvillagerdt])>10))  
eststo


ivregress  2sls rdt teen cschool female lmqnid lrdtotherhh (mqnid mqnidandteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh=D Dandteen Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh), vce(bootstrap, seed(1)  cluster(migrap) idcluster(newid) group(miid09) reps(100)   reject( abs(_b[teen])>10 | abs(_b[cschool])>10 | abs(_b[female])>10 | abs(_b[lmqnid])>10 | abs(_b[lrdtotherhh])>10| abs(_b[mqnid])>10 | abs(_b[mqnidandteen])>10 | abs(_b[mqnidandfemale])>10| abs(_b[mqnidandcschool])>10 | abs(_b[mqnidandlmqnid])>10 | abs(_b[mqnidandlrdtotherhh])>10))  
eststo

ivregress  2sls drdt teen cschool female lmqnid lrdtotherhh (mqnid mqnidandteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh=D Dandteen Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh), vce(bootstrap, seed(1)  cluster(migrap) idcluster(newid) group(miid09) reps(100)   reject( abs(_b[teen])>10 | abs(_b[cschool])>10 | abs(_b[female])>10 | abs(_b[lmqnid])>10 | abs(_b[lrdtotherhh])>10| abs(_b[mqnid])>10 | abs(_b[mqnidandteen])>10 | abs(_b[mqnidandfemale])>10| abs(_b[mqnidandcschool])>10 | abs(_b[mqnidandlmqnid])>10 | abs(_b[mqnidandlrdtotherhh])>10))  
eststo




*ivregress  2sls rdt teen cschool female lmqnid lvillagerdt (mqnid mqnidandteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlvillagerdt=D Dandteen Dandfemale Dandcschool Dandlmqnid Dandlvillagerdt) if bound==1, vce(bootstrap, seed(1)  cluster(migrap) idcluster(newid) group(miid09) reps(100)   reject( abs(_b[teen])>10 | abs(_b[cschool])>10 | abs(_b[female])>10 | abs(_b[lmqnid])>10 | abs(_b[lvillagerdt])>10| abs(_b[mqnid])>10 | abs(_b[mqnidandteen])>10 | abs(_b[mqnidandfemale])>10| abs(_b[mqnidandcschool])>10 | abs(_b[mqnidandlmqnid])>10 | abs(_b[mqnidandlvillagerdt])>10))  
eststo

ivregress  2sls drdt teen cschool female lmqnid lvillagerdt (mqnid mqnidandteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlvillagerdt=D Dandteen Dandfemale Dandcschool Dandlmqnid Dandlvillagerdt) if bound==1, vce(bootstrap, seed(1)  cluster(migrap) idcluster(newid) group(miid09) reps(100)   reject( abs(_b[teen])>10 | abs(_b[cschool])>10 | abs(_b[female])>10 | abs(_b[lmqnid])>10 | abs(_b[lvillagerdt])>10| abs(_b[mqnid])>10 | abs(_b[mqnidandteen])>10 | abs(_b[mqnidandfemale])>10| abs(_b[mqnidandcschool])>10 | abs(_b[mqnidandlmqnid])>10 | abs(_b[mqnidandlvillagerdt])>10))  
eststo


ivregress  2sls rdt teen cschool female lmqnid lrdtotherhh (mqnid mqnidandteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh=D Dandteen Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) if bound==1, vce(bootstrap, seed(1)  cluster(migrap) idcluster(newid) group(miid09) reps(100)   reject( abs(_b[teen])>10 | abs(_b[cschool])>10 | abs(_b[female])>10| abs(_b[lmqnid])>10 | abs(_b[lrdtotherhh])>10| abs(_b[mqnid])>10 | abs(_b[mqnidandteen])>10 | abs(_b[mqnidandfemale])>10| abs(_b[mqnidandcschool])>10 | abs(_b[mqnidandlmqnid])>10 | abs(_b[mqnidandlrdtotherhh])>10))  
eststo

ivregress  2sls drdt teen cschool female lmqnid lrdtotherhh (mqnid mqnidandteen mqnidandfemale mqnidandcschool mqnidandlmqnid mqnidandlrdtotherhh=D Dandteen Dandfemale Dandcschool Dandlmqnid Dandlrdtotherhh) if bound==1, vce(bootstrap, seed(1)  cluster(migrap) idcluster(newid) group(miid09) reps(100)   reject( abs(_b[teen])>10 | abs(_b[cschool])>10 | abs(_b[female])>10| abs(_b[lmqnid])>10 | abs(_b[lrdtotherhh])>10| abs(_b[mqnid])>10 | abs(_b[mqnidandteen])>10 | abs(_b[mqnidandfemale])>10| abs(_b[mqnidandcschool])>10 | abs(_b[mqnidandlmqnid])>10 | abs(_b[mqnidandlrdtotherhh])>10))  
eststo





esttab using ivappendixcl_2nd.tex,  dropped  style(tex) p  replace  mtitles("rdt2nd"   "D.rdt" "rdt2nd"  "D.rdt" "rdt2nd"   "D.rdt" "rdt2nd"  "D.rdt") note(p-value in parentheses. It is calculated by bootstrap of 1000 iterations, dropping a replication when any absolute value of coefficients exceed 10.)


use pre_2nd,clear


eststo clear

ivregress  2sls rdt teen lmqnid lvillagerdt (mqnid mqnidandteen mqnidandlmqnid mqnidandlvillagerdt=D Dandteen Dandlmqnid Dandlvillagerdt), vce(bootstrap, seed(1)  cluster(migrap) idcluster(newid) group(miid09) reps(100)   reject( abs(_b[teen])>10 | | abs(_b[lmqnid])>10 | abs(_b[lvillagerdt])>10| abs(_b[mqnid])>10 | abs(_b[mqnidandteen])>10 | | abs(_b[mqnidandlmqnid])>10 | abs(_b[mqnidandlvillagerdt])>10))  
eststo
ivregress  2sls drdt teen lmqnid lvillagerdt (mqnid mqnidandteen mqnidandlmqnid mqnidandlvillagerdt=D Dandteen Dandlmqnid Dandlvillagerdt), vce(bootstrap, seed(1)  cluster(migrap) idcluster(newid) group(miid09) reps(100)   reject( abs(_b[teen])>10 | | abs(_b[lmqnid])>10 | abs(_b[lvillagerdt])>10| abs(_b[mqnid])>10 | abs(_b[mqnidandteen])>10 | | abs(_b[mqnidandlmqnid])>10 | abs(_b[mqnidandlvillagerdt])>10))  
eststo


ivregress  2sls rdt teen lmqnid lrdtotherhh (mqnid mqnidandteen  mqnidandlmqnid mqnidandlrdtotherhh=D Dandteen Dandlmqnid Dandlrdtotherhh), vce(bootstrap, seed(1)  cluster(migrap) idcluster(newid) group(miid09) reps(100)   reject( abs(_b[teen])>10 | abs(_b[lmqnid])>10 | abs(_b[lrdtotherhh])>10 | abs(_b[mqnid])>10 | abs(_b[mqnidandteen])>10 | abs(_b[mqnidandlmqnid])>10 | abs(_b[mqnidandlrdtotherhh])>10))
eststo


ivregress  2sls drdt teen lmqnid lrdtotherhh (mqnid mqnidandteen  mqnidandlmqnid mqnidandlrdtotherhh=D Dandteen Dandlmqnid Dandlrdtotherhh), vce(bootstrap, seed(1)  cluster(migrap) idcluster(newid) group(miid09) reps(100)   reject( abs(_b[teen])>10 | abs(_b[lmqnid])>10 | abs(_b[lrdtotherhh])>10 | abs(_b[mqnid])>10 | abs(_b[mqnidandteen])>10 | abs(_b[mqnidandlmqnid])>10 | abs(_b[mqnidandlrdtotherhh])>10))
eststo







esttab using ivappendixcl2_2nd.tex,  dropped  style(tex) p  replace  mtitles("rdt2nd"   "D.rdt" "rdt2nd"  "D.rdt" "rdt2nd"   "D.rdt" "rdt2nd"  "D.rdt") note(p-value in parentheses. It is calculated by bootstrap of 1000 iterations, dropping a replication when any absolute value of coefficients exceed 10.)


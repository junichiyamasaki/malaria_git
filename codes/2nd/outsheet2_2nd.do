*output
use pre_2nd,clear
drop if migrap==14|migrap==8|migrap==2
gen cons=1
egen migrap_drop=group(migrap ) 




outsheet drdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\drdt_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet rdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\rdt_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet mqnid using C:\Users\J.YAMASAKI\Documents\MATLAB\master\mqnid_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet mqnidandlmqnid mqnidandteen mqnidandrdtotherhh  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\int_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace


outsheet mqnidandlmqnid mqnidandteen mqnidandlrdtotherhh  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\intl_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace


outsheet mqnidandlmqnid mqnidandteen mqnidandcschool mqnidandfemale mqnidandrdtotherhh using C:\Users\J.YAMASAKI\Documents\MATLAB\master\int2_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet mqnidandlmqnid mqnidandteen mqnidandcschool mqnidandfemale mqnidandlrdtotherhh using C:\Users\J.YAMASAKI\Documents\MATLAB\master\int2l_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet mqnidandlmqnid mqnidandteen mqnidandcschool mqnidandfemale mqnidandvillagerdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\int3_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet mqnidandlmqnid mqnidandteen mqnidandcschool mqnidandfemale mqnidandlvillagerdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\int3l_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet mqnidandlmqnid mqnidandteen mqnidandvillagerdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\int4_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet mqnidandlmqnid mqnidandteen mqnidandlvillagerdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\int4l_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet cons lmqnid teen  rdtotherhh  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\cova_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace



outsheet cons lmqnid teen  lrdtotherhh  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\coval_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace

outsheet cons lmqnid teen  cschool female rdtotherhh using C:\Users\J.YAMASAKI\Documents\MATLAB\master\cova2_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace

outsheet cons lmqnid teen  cschool female lrdtotherhh using C:\Users\J.YAMASAKI\Documents\MATLAB\master\cova2l_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace

outsheet cons lmqnid teen  cschool female villagerdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\cova3_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace

outsheet cons lmqnid teen  cschool female lvillagerdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\cova3l_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace

outsheet cons lmqnid teen  villagerdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\cova4_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace

outsheet cons lmqnid teen  lvillagerdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\cova4l_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Documents\MATLAB\master\iv_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace


outsheet migrap_drop using C:\Users\J.YAMASAKI\Documents\MATLAB\master\cl_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace




outsheet migrap2 using C:\Users\J.YAMASAKI\Documents\MATLAB\master\cl2_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace

egen mhid09cl=group(mhid09)

egen miid09cl=group(miid09)

outsheet miid09cl using C:\Users\J.YAMASAKI\Documents\MATLAB\master\cl3_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace


outsheet mqnidandlmqnid   using C:\Users\J.YAMASAKI\Documents\MATLAB\master\lmqn_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace




*bound

egen migrap_b=group(migrap )if bound==1
egen mhid09clb=group(mhid09)if bound==1
egen miid09clb=group(miid09)if bound==1
outsheet migrap_b using C:\Users\J.YAMASAKI\Documents\MATLAB\master\clb_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet miid09clb using C:\Users\J.YAMASAKI\Documents\MATLAB\master\cl3b_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace


outsheet drdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\drdtb_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet rdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\rdtb_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet mqnid using C:\Users\J.YAMASAKI\Documents\MATLAB\master\mqnidb_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet mqnidandlmqnid  mqnidandteen  mqnidandcschool mqnidandfemale mqnidandrdtotherhh  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\intb2_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet mqnidandlmqnid  mqnidandteen  mqnidandcschool mqnidandfemale mqnidandlrdtotherhh  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\intb2l_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet mqnidandlmqnid  mqnidandteen  mqnidandcschool mqnidandfemale mqnidandvillagerdt  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\intb3_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet mqnidandlmqnid  mqnidandteen  mqnidandcschool mqnidandfemale mqnidandlvillagerdt  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\intb3l_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet mqnidandlmqnid  mqnidandteen   mqnidandvillagerdt  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\intb4_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet mqnidandlmqnid  mqnidandteen  mqnidandlvillagerdt  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\intb4l_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet mqnidandlmqnid mqnidandteen  mqnidandrdtotherhh   using C:\Users\J.YAMASAKI\Documents\MATLAB\master\intb_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet mqnidandlmqnid mqnidandteen  mqnidandlrdtotherhh   using C:\Users\J.YAMASAKI\Documents\MATLAB\master\intbl_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace



outsheet cons lmqnid teen  rdtotherhh  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\covab_drop.csv  if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace


outsheet cons lmqnid teen  lrdtotherhh  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\covabl_drop.csv  if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet cons lmqnid teen  cschool female rdtotherhh using C:\Users\J.YAMASAKI\Documents\MATLAB\master\covab2_drop.csv  if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet cons lmqnid teen  cschool female lrdtotherhh using C:\Users\J.YAMASAKI\Documents\MATLAB\master\covab2l_drop.csv  if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet cons lmqnid teen  cschool female villagerdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\covab3_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet cons lmqnid teen  cschool female lvillagerdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\covab3l_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet cons lmqnid teen  villagerdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\covab4_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet cons lmqnid teen  lvillagerdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\covab4l_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Documents\MATLAB\master\ivb_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace


outsheet mqnidandlmqnid  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\lmqnb_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace


*bite—p
egen flrhhtotal=total(flr) , by (mhid09 phase)
egen flrvillage=mean(flr),by (migrap phase)

gen flrhh=flrhhtotal/hhsize
gen mqnidandlflr=mqnid*L.flrvillage
gen lflr=L.flrvillage

outsheet bite using C:\Users\J.YAMASAKI\Documents\MATLAB\master\bite_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet dbite using C:\Users\J.YAMASAKI\Documents\MATLAB\master\dbite_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet mqnid using C:\Users\J.YAMASAKI\Documents\MATLAB\master\mqnidbite_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet mqnidandteen  mqnidandcschool mqnidandfemale  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\intbite_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet cons teen cschool female using C:\Users\J.YAMASAKI\Documents\MATLAB\master\covabite_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace



outsheet mqnidandteen  mqnidandcschool mqnidandfemale  mqnidandlflr using C:\Users\J.YAMASAKI\Documents\MATLAB\master\int2bite_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet cons teen cschool female lflr using C:\Users\J.YAMASAKI\Documents\MATLAB\master\cova2bite_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Documents\MATLAB\master\ivbite_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace



outsheet migrap_drop using C:\Users\J.YAMASAKI\Documents\MATLAB\master\clbite_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

*bite on bound


outsheet bite using C:\Users\J.YAMASAKI\Documents\MATLAB\master\bite2_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet dbite using C:\Users\J.YAMASAKI\Documents\MATLAB\master\dbite2_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet mqnid using C:\Users\J.YAMASAKI\Documents\MATLAB\master\mqnidbite2_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet mqnidandteen mqnidandcschool mqnidandfemale  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\intbite2_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet cons teen cschool female  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\covabite2_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace




outsheet mqnidandteen  mqnidandcschool mqnidandfemale  mqnidandlflr    using C:\Users\J.YAMASAKI\Documents\MATLAB\master\int2bite2_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet cons teen cschool female lflr using C:\Users\J.YAMASAKI\Documents\MATLAB\master\cova2bite2_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace




outsheet D using C:\Users\J.YAMASAKI\Documents\MATLAB\master\ivbite2_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet migrap_b using C:\Users\J.YAMASAKI\Documents\MATLAB\master\clbite2_drop.csv if dbite!=.& outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace



*flr—p

outsheet flr using C:\Users\J.YAMASAKI\Documents\MATLAB\master\flr_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet dflr using C:\Users\J.YAMASAKI\Documents\MATLAB\master\dflr_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace



outsheet mqnid using C:\Users\J.YAMASAKI\Documents\MATLAB\master\mqnidflr_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet mqnidandteen  mqnidandcschool mqnidandfemale  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\intflr_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet cons teen cschool female using C:\Users\J.YAMASAKI\Documents\MATLAB\master\covaflr_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace



outsheet mqnidandteen  mqnidandcschool mqnidandfemale mqnidandlflr using C:\Users\J.YAMASAKI\Documents\MATLAB\master\int2flr_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet cons teen cschool female lflr using C:\Users\J.YAMASAKI\Documents\MATLAB\master\cova2flr_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet D using C:\Users\J.YAMASAKI\Documents\MATLAB\master\ivflr_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace



outsheet migrap_drop using C:\Users\J.YAMASAKI\Documents\MATLAB\master\clflr_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

*flr on bound


outsheet flr using C:\Users\J.YAMASAKI\Documents\MATLAB\master\flr2_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet dflr using C:\Users\J.YAMASAKI\Documents\MATLAB\master\dflr2_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet mqnid using C:\Users\J.YAMASAKI\Documents\MATLAB\master\mqnidflr2_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet mqnidandteen mqnidandcschool mqnidandfemale  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\intflr2_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet cons teen cschool female  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\covaflr2_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace



outsheet mqnidandteen  mqnidandcschool mqnidandfemale mqnidandlflr  using C:\Users\J.YAMASAKI\Documents\MATLAB\master\int2flr2_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet cons teen cschool female lflr using C:\Users\J.YAMASAKI\Documents\MATLAB\master\cova2flr2_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace



outsheet D using C:\Users\J.YAMASAKI\Documents\MATLAB\master\ivflr2_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet migrap_b using C:\Users\J.YAMASAKI\Documents\MATLAB\master\clflr2_drop.csv if dflr!=.& outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace



*ntmqnid


outsheet rdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\rdtnt_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet drdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\drdtnt_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet ntmqnid using C:\Users\J.YAMASAKI\Documents\MATLAB\master\mqnidnt_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet ntmqnidandlntmqnid ntmqnidandteen ntmqnidandcschool ntmqnidandfemale ntmqnidandrdtotherhh using C:\Users\J.YAMASAKI\Documents\MATLAB\master\intnt_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=., comma nolabel noname replace



outsheet lntmqnid teen  cschool female rdtotherhh using C:\Users\J.YAMASAKI\Documents\MATLAB\master\covant_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=. , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Documents\MATLAB\master\ivnt_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=. , comma nolabel noname replace


outsheet migrap using C:\Users\J.YAMASAKI\Documents\MATLAB\master\clnt_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=. , comma nolabel noname replace


*bound

outsheet rdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\rdtntb_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet drdt using C:\Users\J.YAMASAKI\Documents\MATLAB\master\drdtntb_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet ntmqnid using C:\Users\J.YAMASAKI\Documents\MATLAB\master\mqnidntb_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet ntmqnidandlntmqnid ntmqnidandteen ntmqnidandcschool ntmqnidandfemale ntmqnidandrdtotherhh using C:\Users\J.YAMASAKI\Documents\MATLAB\master\intntb_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace



outsheet lntmqnid teen  cschool female rdtotherhh using C:\Users\J.YAMASAKI\Documents\MATLAB\master\covantb_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Documents\MATLAB\master\ivntb_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=. &bound==1, comma nolabel noname replace


outsheet migrap using C:\Users\J.YAMASAKI\Documents\MATLAB\master\clntb_drop.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

exit



*output
use pre_2nd,clear
*drop if migrap==14|migrap==8|migrap==2
gen cons=1
*egen migrap_drop=group(migrap ) if




outsheet drdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\drdt.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet rdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\rdt.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\mqnid.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace




*********


outsheet mqnidandlmqnid mqnidandteen mqnidandrdtotherhh  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\int.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace


outsheet mqnidandlmqnid mqnidandteen mqnidandlrdtotherhh  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\intl.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace


outsheet mqnidandlmqnid mqnidandteen mqnidandcschool mqnidandfemale mqnidandrdtotherhh using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\int2.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet mqnidandlmqnid mqnidandteen mqnidandcschool mqnidandfemale mqnidandlrdtotherhh using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\int2l.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet mqnidandlmqnid mqnidandteen mqnidandcschool mqnidandfemale mqnidandvillagerdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\int3.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet mqnidandlmqnid mqnidandteen mqnidandcschool mqnidandfemale mqnidandlvillagerdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\int3l.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet mqnidandlmqnid mqnidandteen mqnidandvillagerdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\int4.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet mqnidandlmqnid mqnidandteen mqnidandlvillagerdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\int4l.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet cons lmqnid teen  rdtotherhh  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cova.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace



outsheet cons lmqnid teen  lrdtotherhh  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\coval.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace

outsheet cons lmqnid teen  cschool female rdtotherhh using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cova2.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace

outsheet cons lmqnid teen  cschool female lrdtotherhh using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cova2l.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace

outsheet cons lmqnid teen  cschool female villagerdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cova3.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace

outsheet cons lmqnid teen  cschool female lvillagerdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cova3l.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace

outsheet cons lmqnid teen  villagerdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cova4.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace

outsheet cons lmqnid teen  lvillagerdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cova4l.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\iv.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace


outsheet migrap using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cl.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace




outsheet migrap2 using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cl2.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace

egen mhid09cl=group(mhid09)

egen miid09cl=group(miid09)

outsheet miid09cl using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cl3.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace


outsheet mqnidandlmqnid   using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\lmqn.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. , comma nolabel noname replace




*bound

egen migrap_b=group(migrap )if bound==1
egen mhid09clb=group(mhid09)if bound==1
egen miid09clb=group(miid09)if bound==1
outsheet migrap_b using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\clb.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet miid09clb using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cl3b.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace


outsheet drdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\drdtb.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet rdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\rdtb.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\mqnidb.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet mqnidandlmqnid  mqnidandteen  mqnidandcschool mqnidandfemale mqnidandrdtotherhh  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\intb2.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet mqnidandlmqnid  mqnidandteen  mqnidandcschool mqnidandfemale mqnidandlrdtotherhh  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\intb2l.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet mqnidandlmqnid  mqnidandteen  mqnidandcschool mqnidandfemale mqnidandvillagerdt  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\intb3.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet mqnidandlmqnid  mqnidandteen  mqnidandcschool mqnidandfemale mqnidandlvillagerdt  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\intb3l.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet mqnidandlmqnid  mqnidandteen   mqnidandvillagerdt  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\intb4.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet mqnidandlmqnid  mqnidandteen  mqnidandlvillagerdt  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\intb4l.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet mqnidandlmqnid mqnidandteen  mqnidandrdtotherhh   using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\intb.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet mqnidandlmqnid mqnidandteen  mqnidandlrdtotherhh   using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\intbl.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace



outsheet cons lmqnid teen  rdtotherhh  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\covab.csv  if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace


outsheet cons lmqnid teen  lrdtotherhh  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\covabl.csv  if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet cons lmqnid teen  cschool female rdtotherhh using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\covab2.csv  if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet cons lmqnid teen  cschool female lrdtotherhh using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\covab2l.csv  if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet cons lmqnid teen  cschool female villagerdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\covab3.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet cons lmqnid teen  cschool female lvillagerdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\covab3l.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet cons lmqnid teen  villagerdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\covab4.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet cons lmqnid teen  lvillagerdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\covab4l.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\ivb.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace


outsheet mqnidandlmqnid  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\lmqnb.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace


*bite—p

outsheet bite using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\bite.csv if outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace



outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\mqnidbite.csv if outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet mqnidandteen  mqnidandcschool mqnidandfemale  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\intbite.csv if outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet cons teen cschool female using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\covabite.csv if outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\ivbite.csv if outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace



outsheet migrap using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\clbite.csv if outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

*bite on bound


outsheet bite using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\bite2.csv if outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\mqnidbite2.csv if outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet mqnidandteen mqnidandcschool mqnidandfemale  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\intbite2.csv if outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet cons teen cschool female  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\covabite2.csv if outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\ivbite2.csv if outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet migrap_b using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\clbite2.csv if outside==0&L.outside==0&bite!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace



*flr—p

outsheet flr using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\flr.csv if outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace



outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\mqnidflr.csv if outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet mqnidandteen  mqnidandcschool mqnidandfemale  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\intflr.csv if outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet cons teen cschool female using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\covaflr.csv if outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\ivflr.csv if outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace



outsheet migrap using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\clflr.csv if outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=., comma nolabel noname replace

*flr on bound


outsheet flr using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\flr2.csv if outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\mqnidflr2.csv if outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet mqnidandteen mqnidandcschool mqnidandfemale  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\intflr2.csv if outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet cons teen cschool female  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\covaflr2.csv if outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\ivflr2.csv if outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet migrap_b using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\clflr2.csv if outside==0&L.outside==0&flr!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace



*ntmqnid


outsheet rdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\rdtnt.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=., comma nolabel noname replace


outsheet drdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\drdtnt.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet ntmqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\mqnidnt.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=., comma nolabel noname replace

outsheet ntmqnidandlntmqnid ntmqnidandteen ntmqnidandcschool ntmqnidandfemale ntmqnidandrdtotherhh using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\intnt.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=., comma nolabel noname replace



outsheet lntmqnid teen  cschool female rdtotherhh using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\covant.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=. , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\ivnt.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=. , comma nolabel noname replace


outsheet migrap using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\clnt.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=. , comma nolabel noname replace


*bound

outsheet rdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\rdtntb.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace


outsheet drdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\drdtntb.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet ntmqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\mqnidntb.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace

outsheet ntmqnidandlntmqnid ntmqnidandteen ntmqnidandcschool ntmqnidandfemale ntmqnidandrdtotherhh using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\intntb.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=.&bound==1, comma nolabel noname replace



outsheet lntmqnid teen  cschool female rdtotherhh using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\covantb.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\ivntb.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=. &bound==1, comma nolabel noname replace


outsheet migrap using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\clntb.csv if outside==0&L.outside==0&drdt!=.& dmqnid!=.& ntmqnidandteen!=.&ntmqnidandunderteen!=.& ntmqnidandfemale !=.&ntmqnidandcschool!=.& D!=.&bound==1 , comma nolabel noname replace



*****
use C:\Users\J.YAMASAKI\Documents\stata11data\Malaria\forpaper\allcheck,clear
egen migrap_b=group(migrap )if bound==1
egen mhid09clb=group(mhid09)if bound==1
egen miid09clb=group(miid09)if bound==1
gen cons=1
*‹v‚µ‚Ô‚è‚ÉŽŽ‚·
outsheet mqnidandteen    using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\int0.csv if drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&L.rdt==0 , comma nolabel noname replace
outsheet mqnidandteen  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\int0b.csv if drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. &bound==1&L.rdt==0, comma nolabel noname replace

outsheet cons teen  outside using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cova0.csv if drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. &L.rdt==0, comma nolabel noname replace
outsheet cons teen  outside using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cova0b.csv if drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1&L.rdt==0 , comma nolabel noname replace



outsheet rdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\rdt0.csv if drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&L.rdt==0 , comma nolabel noname replace
outsheet rdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\rdt0b.csv if drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1&L.rdt==0 , comma nolabel noname replace


outsheet migrap using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cl0.csv if drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&L.rdt==0 , comma nolabel noname replace
outsheet migrap_b using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cl0b.csv if drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1&L.rdt==0 , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\iv0.csv if drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&L.rdt==0, comma nolabel noname replace
outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\iv0b.csv if drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1&L.rdt==0, comma nolabel noname replace

outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\mqnid0.csv if drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&L.rdt==0, comma nolabel noname replace
outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\mqnid0b.csv if drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1&L.rdt==0, comma nolabel noname replace

*Q‚Ä‚¢‚éŽžŠÔ‚È‚Ç‚ðŒÅ’è
outsheet mqnidandteen   using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\int010.csv if flr14>=10&secondsettle==6&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. &L.rdt==0, comma nolabel noname replace
outsheet mqnidandteen   using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\int010b.csv if flr14>=10&secondsettle==6&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. &bound==1&L.rdt==0, comma nolabel noname replace

outsheet cons teen outside using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cova010.csv if flr14>=10&secondsettle==6&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=. &L.rdt==0, comma nolabel noname replace
outsheet cons teen outside using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cova010b.csv if flr14>=10&secondsettle==6&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1&L.rdt==0 , comma nolabel noname replace



outsheet rdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\rdt010.csv if flr14>=10&secondsettle==6&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&L.rdt==0 , comma nolabel noname replace
outsheet rdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\rdt010b.csv if flr14>=10&secondsettle==6&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1&L.rdt==0 , comma nolabel noname replace


outsheet migrap using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cl010.csv if flr14>=10&secondsettle==6&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&L.rdt==0 , comma nolabel noname replace
outsheet migrap_b using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\cl010b.csv if flr14>=10&secondsettle==6&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1&L.rdt==0 , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\iv010.csv if flr14>=10&secondsettle==6&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&L.rdt==0, comma nolabel noname replace
outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\iv010b.csv if flr14>=10&secondsettle==6&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1&L.rdt==0, comma nolabel noname replace

outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\mqnid010.csv if flr14>=10&secondsettle==6&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&L.rdt==0, comma nolabel noname replace
outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\master\mqnid010b.csv if flr14>=10&secondsettle==6&drdt!=.& dmqnid!=.& dmqnidandteen!=.&dmqnidandunderteen!=.& dmqnidandfemale !=.&dmqnidandcschool!=.& D!=.&bound==1&L.rdt==0, comma nolabel noname replace


exit



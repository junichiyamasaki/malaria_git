*output
use allcheck,clear
gen cons=1



*absence

outsheet absence62 using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\absence6.csv if phase==2&absence62!=.&absence2!=.&r4>=6&r4<=19&migrap!=.&mqnid!=., comma nolabel noname replace

outsheet absence2 using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\absence.csv if phase==2&absence62!=.&absence2!=.&r4>=6&r4<=19&migrap!=.&mqnid!=., comma nolabel noname replace

outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\mqnid_a.csv if phase==2&absence62!=.&absence2!=.&r4>=6&r4<=19&migrap!=.&mqnid!=., comma nolabel noname replace


*********


outsheet mqnidandteen using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\int_a.csv  if phase==2&absence62!=.&absence2!=.&r4>=6&r4<=19&migrap!=.&mqnid!=. , comma nolabel noname replace

outsheet cons   teen 	 using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\cova_a.csv  if phase==2&absence62!=.&absence2!=.&r4>=6&r4<=19&migrap!=.&mqnid!=. , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\iv_a.csv  if phase==2&absence62!=.&absence2!=.&r4>=6&r4<=19&migrap!=.&mqnid!=. , comma nolabel noname replace

outsheet migrap using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\cl_a.csv  if phase==2&absence62!=.&absence2!=.&r4>=6&r4<=19&migrap!=.&mqnid!=. , comma nolabel noname replace




*absencebound

egen migrap_ab=group(migrap )if bound==1
egen mhid09clb=group(mhid09)if bound==1
egen miid09clb=group(miid09)if bound==1




outsheet absence62 using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\absence6_b.csv  if phase==2&absence62!=.&absence2!=.&r4>=6&r4<=19&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace

outsheet absence2 using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\absence_b.csv  if phase==2&absence62!=.&absence2!=.&r4>=6&r4<=19&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace

outsheet  mqnidandteen using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\int_ab.csv  if phase==2&absence62!=.&absence2!=.&r4>=6&r4<=19&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace

outsheet cons teen  using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\cova_ab.csv  if phase==2&absence62!=.&absence2!=.&r4>=6&r4<=19&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\iv_ab.csv  if phase==2&absence62!=.&absence2!=.&r4>=6&r4<=19&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace

outsheet migrap_ab using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\cl_ab.csv  if phase==2&absence62!=.&absence2!=.&r4>=6&r4<=19&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace

outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\mqnid_ab.csv if phase==2&absence62!=.&absence2!=.&r4>=6&r4<=19&migrap!=.&mqnid!=.&bound==1, comma nolabel noname replace




	


*rdt

outsheet rdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\rdt.csv if phase==2&rdt!=.&migrap!=.&mqnid!=., comma nolabel noname replace

outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\mqnid.csv if phase==2&rdt!=.&migrap!=.&mqnid!=., comma nolabel noname replace


*********


outsheet mqnidandunderteen mqnidandteen using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\int.csv  if phase==2&rdt!=.&migrap!=.&mqnid!=. , comma nolabel noname replace

outsheet cons  underteen teen outside using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\cova.csv  if phase==2&rdt!=.&migrap!=.&mqnid!=. , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\iv.csv  if phase==2&rdt!=.&migrap!=.&mqnid!=. , comma nolabel noname replace

outsheet migrap using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\cl.csv  if phase==2&rdt!=.&migrap!=.&mqnid!=. , comma nolabel noname replace




*rdtbound

outsheet rdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\rdt_b.csv if phase==2&rdt!=.&migrap!=.&mqnid!=.&bound==1, comma nolabel noname replace

outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\mqnid_b.csv if phase==2&rdt!=.&migrap!=.&mqnid!=.&bound==1, comma nolabel noname replace


outsheet mqnidandunderteen mqnidandteen using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\int_b.csv  if phase==2&rdt!=.&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace

outsheet cons  under teen outside	 using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\cova_b.csv  if phase==2&rdt!=.&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\iv_b.csv  if phase==2&rdt!=.&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace

outsheet migrap_ab using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\cl_b.csv  if phase==2&rdt!=.&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace




*rdt nooutside

outsheet rdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\rdto0.csv if phase==2&rdt!=.&outside==0&migrap!=.&mqnid!=., comma nolabel noname replace

outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\mqnido0.csv if phase==2&rdt!=.&outside==0&migrap!=.&mqnid!=., comma nolabel noname replace


*********


outsheet mqnidandunderteen mqnidandteen using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\into0.csv  if phase==2&rdt!=.&outside==0&migrap!=.&mqnid!=. , comma nolabel noname replace

outsheet cons  underteen teen using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\covao0.csv  if phase==2&rdt!=.&outside==0&migrap!=.&mqnid!=. , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\ivo0.csv  if phase==2&rdt!=.&outside==0&migrap!=.&mqnid!=. , comma nolabel noname replace

outsheet migrap using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\clo0.csv  if phase==2&rdt!=.&outside==0&migrap!=.&mqnid!=. , comma nolabel noname replace




*rdtbound nooutside

outsheet rdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\rdto0_b.csv if phase==2&rdt!=.&outside==0&migrap!=.&mqnid!=.&bound==1, comma nolabel noname replace

outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\mqnido0_b.csv if phase==2&rdt!=.&outside==0&migrap!=.&mqnid!=.&bound==1, comma nolabel noname replace


outsheet mqnidandunderteen mqnidandteen using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\into0_b.csv  if phase==2&rdt!=.&outside==0&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace

outsheet cons  under teen 	 using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\covao0_b.csv  if phase==2&rdt!=.&outside==0&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\ivo0_b.csv  if phase==2&rdt!=.&outside==0&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace

outsheet migrap_ab using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\clo0_b.csv  if phase==2&rdt!=.&outside==0&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace



*rdt all

outsheet rdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\rdtoa.csv if phase==2&rdt!=.&migrap!=.&mqnid!=., comma nolabel noname replace

outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\mqnidoa.csv if phase==2&rdt!=.&migrap!=.&mqnid!=., comma nolabel noname replace


*********


outsheet mqnidandunderteen mqnidandteen using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\intoa.csv  if phase==2&rdt!=.&migrap!=.&mqnid!=. , comma nolabel noname replace

outsheet cons  underteen teen using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\covaoa.csv  if phase==2&rdt!=.&migrap!=.&mqnid!=. , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\ivoa.csv  if phase==2&rdt!=.&migrap!=.&mqnid!=. , comma nolabel noname replace

outsheet migrap using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\cloa.csv  if phase==2&rdt!=.&migrap!=.&mqnid!=. , comma nolabel noname replace




*rdtbound all
outsheet rdt using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\rdtoa_b.csv if phase==2&rdt!=.&migrap!=.&mqnid!=.&bound==1, comma nolabel noname replace

outsheet mqnid using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\mqnidoa_b.csv if phase==2&rdt!=.&migrap!=.&mqnid!=.&bound==1, comma nolabel noname replace


outsheet mqnidandunderteen mqnidandteen using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\intoa_b.csv  if phase==2&rdt!=.&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace

outsheet cons  under teen 	 using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\covaoa_b.csv  if phase==2&rdt!=.&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace

outsheet D using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\ivoa_b.csv  if phase==2&rdt!=.&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace

outsheet migrap_ab using C:\Users\J.YAMASAKI\Dropbox\MATLAB\malariapaper\cloa_b.csv  if phase==2&rdt!=.&migrap!=.&mqnid!=.&bound==1 , comma nolabel noname replace




exit



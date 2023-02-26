
use MOUSTIQUAIRE ,clear

gen numinanet=0
replace numinanet=1 if h71<100
replace numinanet=2 if h71<100&h72<100
replace numinanet=3 if h71<100&h72<100&h73<100
replace numinanet=4 if h71<100&h72<100&h73<100&h74<100
replace numinanet=5 if h71<100&h72<100&h73<100&h74<100&h75<100
tab numinanet

merge m:1  mhid using numhh
exit
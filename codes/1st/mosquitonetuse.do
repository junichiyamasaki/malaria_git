

do mosquitonetlabel

 gen nonuse=0
replace nonuse=1 if h71==.&h72==.&h73==.&h74==.&h75==.
collapse (sum) nonuse, by (mhid)


exit
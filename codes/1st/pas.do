use balance,clear

replace h18a=0 if h18a==2
replace h19a=0 if h19a==2
replace h20a=0 if h20a==2

gen feverwithpositive=.

replace feverwithpositive=1 if rdt==1&h18a==1
replace feverwithpositive=0 if (rdt==0&h18a==0)|(rdt==1&h18a==0)|(rdt==0&h18a==1)


gen feverwithnegative=.
replace feverwithnegative=1 if rdt==0&h18a==1
replace feverwithnegative=0 if (rdt==0&h18a==0)|(rdt==1&h18a==0)|(rdt==1&h18a==1)

gen diarrheawithpositive=.
replace diarrheawithpositive=1 if rdt==1&h19a==1
replace diarrheawithpositive=0 if (rdt==0&h19a==0)|(rdt==1&h19a==0)|(rdt==0&h19a==1)

gen diarrheawithnegative=.
replace diarrheawithnegative=1 if rdt==0&h19a==1
replace diarrheawithnegative=0 if (rdt==0&h19a==0)|(rdt==1&h19a==0)|(rdt==1&h19a==1)


gen dizzinesswithpositive=.
replace dizzinesswithpositive=1 if rdt==1&h20a==1
replace dizzinesswithpositive=0 if (rdt==0&h20a==0)|(rdt==1&h20a==0)|(rdt==0&h20a==1)



gen dizzinesswithnegative=.
replace dizzinesswithnegative=1 if rdt==0&h20a==1
replace dizzinesswithnegative=0 if (rdt==0&h20a==0)|(rdt==1&h20a==0)|(rdt==1&h20a==1)


collapse (sum) rdt feverwithpositive feverwithnegative  h18a diarrheawithpositive diarrheawithnegative h19a dizzinesswithpositive dizzinesswithnegative h20a (count) miid, by (miloc migrap)

exit
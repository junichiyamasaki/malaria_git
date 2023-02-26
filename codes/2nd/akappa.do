set obs 20000
gen z=(_n<=10000)
gen x=(_n<=6000|(_n<=14000&_n>=10000))
gen d=(_n<=4000|(_n<=9000&_n>6000))
gen dx=d*x
drawnorm e
gen u=e
replace u=e+0.5 if d==1
gen y=1+d+2*dx+x+u

outsheet y using C:\Users\J.YAMASAKI\Documents\MATLAB\master\ytest.csv ,comma nolabel noname replace


outsheet d using C:\Users\J.YAMASAKI\Documents\MATLAB\master\dtest.csv ,comma nolabel noname replace


outsheet z using C:\Users\J.YAMASAKI\Documents\MATLAB\master\ztest.csv ,comma nolabel noname replace


outsheet dx using C:\Users\J.YAMASAKI\Documents\MATLAB\master\dxtest.csv ,comma nolabel noname replace

outsheet x using C:\Users\J.YAMASAKI\Documents\MATLAB\master\xtest.csv ,comma nolabel noname replace
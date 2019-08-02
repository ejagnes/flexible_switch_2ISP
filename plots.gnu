working_directory = system('cat plots_tmp.txt')."/"

set terminal qt size 1024,1024 enhanced font "Times, 15" persist

set border linewidth 1.5

unset key

set border 1+2
set ytics nomirror out
set xtics nomirror out

set rmargin 10

set multiplot

set origin 0,0
set size 1,0.3422
set xrange[0:2000]
set ytics -70,20
set yrange[-70:-30]
set xtics 500
set ylabel "u [mV]" #offset -2
set xlabel "time [ms]" 
p working_directory."data01.dat" u 1:2 w l lw 2 lc -1


set origin 0,0.34
set size 1,0.2683
unset label
unset xlabel
set key horizontal left
set ylabel "current [nA]"
set yrange[-60:60]
set ytics 30
set xtics format ""
#set border 2
p working_directory."data04.dat" u 1:($2/100) w l lw 2 lc rgb "#de2e26" title "E", "" u 1:($3/100) w l lw 2 lc rgb "#3182bd" title "I1", "" u 1:($4/100) w l lw 2 lc rgb "#08306b" title "I2",  "" u 1:(($2+$3+$4)/100) w l lw 2 lc -1 title "E+I1+I2"


set origin 0,0.6
unset label
set size 1,0.2683
set yrange[0:75]
set ytics 25
set ylabel "neuron" offset 0
p working_directory."data02.dat" w l lw 2 lc rgb "#e78ac3" title "non-pref", "" u 1:10 w l lw 2 lc rgb "#66c2a5" title "pref", "" u 1:17 w l lw 2 lc rgb "#e5c494" title "non-pref", "" u 1:(($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14+$15+$16+$17)/16) w l lw 3 lc -1 title "avg"

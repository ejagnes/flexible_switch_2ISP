working_directory = system('cat plots_tmp.txt')."/"

set terminal qt size 1024,1024 enhanced font "Arial, 15" persist

set linetype 1 lc rgb "#a6cee3" lw 2

set linetype 2 lc rgb "#f0f0f0" lw 2
set linetype 3 lc rgb "#d9d9d9" lw 2
set linetype 4 lc rgb "#bdbdbd" lw 2
set linetype 5 lc rgb "#969696" lw 2
set linetype 6 lc rgb "#737373" lw 2
set linetype 7 lc rgb "#525252" lw 2
set linetype 8 lc rgb "#252525" lw 2
set linetype 9 lc rgb "#000000" lw 2

set linetype 12 lc rgb "#fee6ce" lw 2
set linetype 13 lc rgb "#fdd0a2" lw 2
set linetype 14 lc rgb "#fdae6b" lw 2
set linetype 15 lc rgb "#fd8d3c" lw 2
set linetype 16 lc rgb "#f16913" lw 2
set linetype 17 lc rgb "#d94801" lw 2
set linetype 18 lc rgb "#a63603" lw 2
set linetype 19 lc rgb "#7f2704" lw 2

set linetype 22 lc rgb "#deebf8" lw 2
set linetype 23 lc rgb "#c7dbf0" lw 2
set linetype 24 lc rgb "#9ec9e1" lw 2
set linetype 25 lc rgb "#6badd6" lw 2
set linetype 26 lc rgb "#4291c7" lw 2
set linetype 27 lc rgb "#2170b5" lw 2
set linetype 28 lc rgb "#08529b" lw 2
set linetype 29 lc rgb "#08306b" lw 2

set linetype 31 lc rgb "#646464" lw 2
set linetype 32 lc rgb "#d94801" lw 2
set linetype 33 lc rgb "#215ad4" lw 2

set border linewidth 1.5

unset key

set border 1+2
set ytics nomirror out
set xtics nomirror out

set rmargin 10

set multiplot

#######################################################

set origin 0,0
set size 0.5,0.3
set xrange [1:16]
set mxtics 3
set xtics out nomirror 1,3
set xlabel "signal input"
set yrange [0:20]
set ylabel "output (Hz)"
set label "strong inhibition" at 15,22 textcolor lt 33
p working_directory."data01.dat" every ::32::47 u 1:2 w l lt 22, "" every ::32::47 u 1:3 w l lt 23, "" every ::32::47 u 1:4 w l lt 24, "" every ::32::47 u 1:5 w l lt 25, "" every ::32::47 u 1:6 w l lt 26, "" every ::32::47 u 1:7 w l lt 27, "" every ::32::47 u 1:8 w l lt 28, "" every ::32::47 u 1:9 w l lt 29

set origin 0.4,0
set size 0.45,0.3
set format y ""
unset ylabel
unset label
p working_directory."data02.dat" every ::32::47 u 1:2 w l lt 22, "" every ::32::47 u 1:3 w l lt 23, "" every ::32::47 u 1:4 w l lt 24, "" every ::32::47 u 1:5 w l lt 25, "" every ::32::47 u 1:6 w l lt 26, "" every ::32::47 u 1:7 w l lt 27, "" every ::32::47 u 1:8 w l lt 28, "" every ::32::47 u 1:9 w l lt 29

#######################################################

set origin 0,0.35
set size 0.5,0.25
set format x ""
set yrange[0:60]
set format y
set ylabel "output (Hz)"
unset xlabel
set label "weak inhibition" at 15,66 textcolor lt 32
p working_directory."data01.dat" every ::16::31 u 1:2 w l lt 12, "" every ::16::31 u 1:3 w l lt 13, "" every ::16::31 u 1:4 w l lt 14, "" every ::16::31 u 1:5 w l lt 15, "" every ::16::31 u 1:6 w l lt 16, "" every ::16::31 u 1:7 w l lt 17, "" every ::16::31 u 1:8 w l lt 18, "" every ::16::31 u 1:9 w l lt 19

set origin 0.4,0.35
set size 0.45,0.25
set format y ""
unset ylabel
unset label
p working_directory."data02.dat" every ::16::31 u 1:2 w l lt 12, "" every ::16::31 u 1:3 w l lt 13, "" every ::16::31 u 1:4 w l lt 14, "" every ::16::31 u 1:5 w l lt 15, "" every ::16::31 u 1:6 w l lt 16, "" every ::16::31 u 1:7 w l lt 17, "" every ::16::31 u 1:8 w l lt 18, "" every ::16::31 u 1:9 w l lt 19

#######################################################

set origin 0,0.65
set size 0.5,0.25
set format x ""
set yrange[0:30]
set format y
set ylabel "output (Hz)"
unset xlabel
set label "Phasic" at 7,40
set label "control" at 16.2,33 textcolor lt 31
p working_directory."data01.dat" every ::0::15 u 1:2 w l lt 2, "" every ::0::15 u 1:3 w l lt 3, "" every ::0::15 u 1:4 w l lt 4, "" every ::0::15 u 1:5 w l lt 5, "" every ::0::15 u 1:6 w l lt 6, "" every ::0::15 u 1:7 w l lt 7, "" every ::0::15 u 1:8 w l lt 8, "" every ::0::15 u 1:9 w l lt 9


set origin 0.4,0.65
set size 0.45,0.25
set format y ""
unset ylabel
unset label
set label "Tonic" at 7,40
p working_directory."data02.dat" every ::0::15 u 1:2 w l lt 2, "" every ::0::15 u 1:3 w l lt 3, "" every ::0::15 u 1:4 w l lt 4, "" every ::0::15 u 1:5 w l lt 5, "" every ::0::15 u 1:6 w l lt 6, "" every ::0::15 u 1:7 w l lt 7, "" every ::0::15 u 1:8 w l lt 8, "" every ::0::15 u 1:9 w l lt 9

# Codes for generation of simulations and plots of panel B of figures 2,3 and 4

## Parameters

Parameters for models are in "config.f90" file, in the vector "pr" and other specific variable names. All data generated is written in a folder defined in this file, which also contains the source code after running.

## Initial conditions and receptive field profiles

Initial conditions are in "initial_conditions.f90" file. There the user can choose the level of the firing-rate of each inhibitory population pr(205) and pr(206). The combination of receptive field profiles is also chosen in this file by changing the argument of subroutine "connectivity(x)" with x being x=1 for one population (as in figure 2), x=2 for two populations (co-tuned + flat; as in figure 3) and x=3 for two populations (co-tuned + counter-tuned; as in figure 4).

## Files (main code and additional subroutines)

Main code is "attentional_switch_simple.F90", which calls other subroutines that can be modified from same folder ("config.f90", "initial_conditions.f90", and "simulation.f90").

## Plot script (gnuplot)

Script for plotting is file "plots.gnu", which calls gnuplot.

## Runnin script

Script for compiling, running and generating a figure is "run.sh".

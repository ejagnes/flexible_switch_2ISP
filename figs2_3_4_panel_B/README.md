Parameters for models are in "config.f90" file, in the vector "pr".

Initial conditions are in "initial_conditions.f90" file. There the user can choose the level of the firing-rate of each inhibitory population pr(205) and pr(206). The combination of receptive field profiles is also chosen in this file by changing the argument of subroutine "connectivity(x)" with x being x=1 for one population (as in figure 2), x=2 for two populations (co-tuned + flat; as in figure 3) and x=3 for two populations (co-tuned + counter-tuned; as in figure 4).

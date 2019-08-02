!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!                       ALLOCATION OF VECTORS                                !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE allocation()
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE
	INTEGER		::	tot_n

	tot_n = ne_input+ni_input1+ni_input2

	ALLOCATE(msynw(tot_n),patt_time(n_pw),inp_patt(tot_n))
	ALLOCATE(spk(tot_n),spkr(tot_n),spkt(tot_n))
	ALLOCATE(tmp_inp(tot_n))
	ALLOCATE(activity(n_pw))
	ALLOCATE(cond_e(n_pw),cond_i1(n_pw),cond_i2(n_pw))
	ALLOCATE(curr_e(n_pw),curr_i1(n_pw),curr_i2(n_pw))

	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

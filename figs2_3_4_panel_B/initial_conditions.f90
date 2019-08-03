!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!                  FILE WITH INITAL CONDITIONS FOR SIMULATION                !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE initial_conditions()
!	USE IFPORT
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE
	INTEGER			::	i
	INTEGER 		::	n,clock
	INTEGER,ALLOCATABLE	::	seed(:)

!===================== SEED INITIALISATION TO BE THE SAME =================================!
	CALL RANDOM_SEED(size = n)
        ALLOCATE(seed(n))
	seed = 399393317 + 37 * (/ (i - 1, i = 1, n) /)
	CALL RANDOM_SEED(PUT = seed)
	DEALLOCATE(seed)
!==========================================================================================!
!======================== FIRING RATE OF INHIBITORY POPULATIONS ===========================!
	!population 1 -> as a function of control firing-rate
	pr(205) = 3.5d0
	!population 2 -> as a function of control firing-rate
	pr(206) = 0.0d0
!==========================================================================================!
!=========================== CONNECTIVITY SCHEMES =========================================!
	!1 -> one population; 2-> co-tuned+flat; 3-> co-tuned+counter-tuned
	CALL connectivity(3)
!==========================================================================================!
!========================= VARIABLES INITIALISATION =======================================!
	x = 0.0d0
	CALL RANDOM_NUMBER(x(1))
	x(1) = pr(2)
	tr = 0.0d0
	spkt_post = -10.0d0
	spk_post = .FALSE.
	patt_time = 0.0d0
	activity = 0.0d0
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE connectivity(q)
!	USE IFPORT
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE
	INTEGER			::	q,pw,j0,jf,j
	REAL*8			::	r,rand_vec(ne_input+ni_input1+ni_input2),w_init,w_init0

	IF(q.EQ.1) THEN
		DO pw = 1,n_pw
			CALL RANDOM_NUMBER(rand_vec)

			!EXCITATORY POPULATION
			j0 = ((pw-1)*ne_pw)+1
			jf = pw*ne_pw
			w_init0 = pr(91) + (4.0d0*pr(91)/(1.0d0+0.25d0*(DBLE(pw-pref_pw))**2))
			msynw(j0:jf) = w_init0 + 0.02d0*rand_vec(j0:jf) - 0.01d0

			!INHIBITORY POPULATION 2 (CO-TUNED)
			j0 = ((pw-1)*ni_pw2)+ne_input+ni_input1+1
			jf = pw*ni_pw2+ne_input+ni_input1
			msynw(j0:jf) = 2.09d0*w_init0 + 0.02d0*rand_vec(j0:jf) - 0.01d0

			!INHIBITORY POPULATION 1 (CO-TUNED)
			j0 = ((pw-1)*ni_pw1)+ne_input+1
			jf = pw*ni_pw1+ne_input
			msynw(j0:jf) = 2.09d0*w_init0 + 0.02d0*rand_vec(j0:jf) - 0.01d0
		END DO
	END IF

	IF(q.EQ.2) THEN
		DO pw = 1,n_pw
			CALL RANDOM_NUMBER(rand_vec)

			!EXCITATORY POPULATION
			j0 = ((pw-1)*ne_pw)+1
			jf = pw*ne_pw
			w_init0 = pr(91) + (4.0d0*pr(91)/(1.0d0+0.25d0*(DBLE(pw-pref_pw))**2))
			msynw(j0:jf) = w_init0 + 0.02d0*rand_vec(j0:jf) - 0.01d0

			!INHIBITORY POPULATION 2 (FLAT)
			j0 = ((pw-1)*ni_pw2)+ne_input+ni_input1+1
			jf = pw*ni_pw2+ne_input+ni_input1
			w_init = -0.5d0*w_init0 + 1.5d0*( pr(91) + (4.0d0*pr(91)/(1.0d0+0.25d0*(DBLE(1-pref_pw))**2)) )
			IF(w_init.LT.0.0d0) w_init = 0.0d0
			msynw(j0:jf) = 4.3d0*w_init + 0.02d0*rand_vec(j0:jf) - 0.01d0

			!INHIBITORY POPULATION 1 (CO-TUNED)
			j0 = ((pw-1)*ni_pw1)+ne_input+1
			jf = pw*ni_pw1+ne_input
			w_init = 1.5d0*( w_init0 - (pr(91) + (4.0d0*pr(91)/(1.0d0+0.25d0*(DBLE(1-pref_pw))**2))) )
			IF(w_init.GT.w_init0) w_init = w_init0
			msynw(j0:jf) = 4.3d0*w_init + 0.02d0*rand_vec(j0:jf) - 0.01d0
		END DO
	END IF

	IF(q.EQ.3) THEN
		DO pw = 1,n_pw
			CALL RANDOM_NUMBER(rand_vec)

			!EXCITATORY POPULATION
			j0 = ((pw-1)*ne_pw)+1
			jf = pw*ne_pw
			w_init0 = pr(91) + (4.0d0*pr(91)/(1.0d0+0.25d0*(DBLE(pw-pref_pw))**2))
			msynw(j0:jf) = w_init0 + 0.02d0*rand_vec(j0:jf) - 0.01d0

			!INHIBITORY POPULATION 2 (COUNTER-TUNED)
			j0 = ((pw-1)*ni_pw2)+ne_input+ni_input1+1
			jf = pw*ni_pw2+ne_input+ni_input1
			w_init = (pr(91) + (4.0d0*pr(91)/(1.0d0+0.25d0*(DBLE(1-pref_pw))**2)))
			msynw(j0:jf) = 4.2d0*w_init + 0.02d0*rand_vec(j0:jf) - 0.01d0

			!INHIBITORY POPULATION 1 (CO-TUNED)
			j0 = ((pw-1)*ni_pw1)+ne_input+1
			jf = pw*ni_pw1+ne_input
			msynw(j0:jf) = 4.2d0*(w_init0-w_init) + 0.02d0*rand_vec(j0:jf) - 0.01d0
		END DO
	END IF

	WHERE(msynw.LE.0.0d0) msynw = 0.00001d0

	END SUBROUTINE

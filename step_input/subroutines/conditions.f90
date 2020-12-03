!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        PARAMETERS AND SUBROUTINE FOR THREE CASES IN SIMS                   !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!         INHIBITORY FIRING-RATE FOR EACH CASE AND CALL OF MAIN SIMS         !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE conditions(k)
	USE VARIABLES
	USE PARAMETERS
	USE TEMP
	IMPLICIT NONE
	INTEGER		::	k

!============================ main simulation - control ===================================!
	IF(k.EQ.1) THEN
	!------------------------ FIRING RATE OF INHIBITORY POPULATIONS ---------------------------!
		pr(205) = 1.0d0		!population 1 -> as a function of control firing-rate
		pr(206) = 1.0d0		!population 2 -> as a function of control firing-rate
	!------------------------------------------------------------------------------------------!
	END IF
!==========================================================================================!
!============================ main simulation - 2nd case ==================================!
	IF(k.EQ.2) THEN
	!------------------------ FIRING RATE OF INHIBITORY POPULATIONS ---------------------------!
		IF(sims_type.EQ.1) THEN
			pr(205) = 1.0d0		!population 1 -> as a function of control firing-rate
			pr(206) = 0.8d0		!population 2 -> as a function of control firing-rate
		END IF
		IF(sims_type.EQ.2) THEN
			pr(205) = 0.0d0		!population 1 -> as a function of control firing-rate
			pr(206) = 2.8d0		!population 2 -> as a function of control firing-rate
		END IF
		IF(sims_type.EQ.3) THEN
			pr(205) = 0.0d0		!population 1 -> as a function of control firing-rate
			pr(206) = 4.1d0		!population 2 -> as a function of control firing-rate
		END IF
	!------------------------------------------------------------------------------------------!
	END IF
!==========================================================================================!
!============================ main simulation - 3rd case ==================================!
	IF(k.EQ.3) THEN
	!------------------------ FIRING RATE OF INHIBITORY POPULATIONS ---------------------------!
		IF(sims_type.EQ.1) THEN
			pr(205) = 1.0d0		!population 1 -> as a function of control firing-rate
			pr(206) = 1.2d0		!population 2 -> as a function of control firing-rate
		END IF
		IF(sims_type.EQ.2) THEN
			pr(205) = 6.9d0		!population 1 -> as a function of control firing-rate
			pr(206) = 0.0d0		!population 2 -> as a function of control firing-rate
		END IF
		IF(sims_type.EQ.3) THEN
			pr(205) = 2.3d0		!population 1 -> as a function of control firing-rate
			pr(206) = 0.0d0		!population 2 -> as a function of control firing-rate
		END IF
	!------------------------------------------------------------------------------------------!
	END IF
!==========================================================================================!
!=============================== sequence of trials =======================================!
	CALL step_sims()
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!         INHIBITORY FIRING-RATE FOR EACH CASE AND CALL OF MAIN SIMS         !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE step_sims()
	USE VARIABLES
	USE PARAMETERS
	USE TEMP
	IMPLICIT NONE
	INTEGER					:: i,pw,n,j,jj
	INTEGER, DIMENSION(:), ALLOCATABLE	:: seed
!========= simulation without plasticity for membrane potential dynamics ==================!
!--------------------------- reset variables for different cases --------------------------!
	phasic = 0.0d0						!spike count for phasic period
	tonic = 0.0d0						!spike count for tonic period
	inp_fr = -1.0d0*pr(77)					!initial step firing rate
!------------------------------------------------------------------------------------------!
!------------------------- loop over 9 step rates (from 0 to 40) --------------------------!
	DO j = 1,9
		inp_fr = inp_fr + pr(77)				!step increase in rate
	!--------------------- SEED INITIALISATION TO BE THE SAME ---------------------------------!
		CALL RANDOM_SEED(size = n)
		ALLOCATE(seed(n))
		seed = seed0 + 37 * (/ (i - 1, i = 1, n) /)
		CALL RANDOM_SEED(PUT = seed)
		DEALLOCATE(seed)
	!------------------------------------------------------------------------------------------!
	!---------------------------- trials for smoother plot ------------------------------------!
		DO jj = 1,n_trials
		!---------------------------- loop over input signals -------------------------------------!
			DO pw = 1,n_pw
				CALL initial_conditions2()		!implement initial conditions
				CALL simulation0(10.0d0)		!argument is simulated time in milliseconds
				x(5) = 0.0d0				!reset spike count
				CALL simulation(pr(78),pw)		!argument is simulated time in milliseconds
				phasic(j,pw) = phasic(j,pw) + x(5)	!add spike count of trial to main counter
				x(5) = 0.0d0				!reset spike count
				CALL simulation(pr(78),pw)		!argument is simulated time in milliseconds
				tonic(j,pw) = tonic(j,pw) + x(5)	!add spike count of trial to main counter
			END DO
		!------------------------------------------------------------------------------------------!
		END DO
	!------------------------------------------------------------------------------------------!
	END DO
!------------------------------------------------------------------------------------------!
!--------------------------- from spike count to firing-rate (Hz) -------------------------!
	phasic = (1000.0d0/pr(78))*phasic/DBLE(n_trials)
	tonic = (1000.0d0/pr(78))*tonic/DBLE(n_trials)
!------------------------------------------------------------------------------------------!
!----------------------------- discounting spikes without step input ----------------------!
	DO pw = 1,n_pw
		phasic_f(:,pw) = phasic(2:9,pw)-phasic(1,pw)
		WHERE(phasic_f(:,pw).LT.0.0d0) phasic_f(:,pw) = 0.0d0
		tonic_f(:,pw) = tonic(2:9,pw)-tonic(1,pw)
		WHERE(tonic_f(:,pw).LT.0.0d0) tonic_f(:,pw) = 0.0d0
	END DO
!------------------------------------------------------------------------------------------!
!------------------------------------ output for plots ------------------------------------!
	DO pw = 1,n_pw
		WRITE(1,"(I10,8F20.10)")pw,phasic_f(:,pw)
		WRITE(2,"(I10,8F20.10)")pw,tonic_f(:,pw)
	END DO
!------------------------------------------------------------------------------------------!
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

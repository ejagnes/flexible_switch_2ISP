!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!                  MAIN FILE WITH SIMULATION CODE                            !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!============================ files with subroutines ======================================!
	INCLUDE 'subroutines/modules.f90'		!modules
	INCLUDE 'subroutines/allocation.f90'		!allocation of vector sizes

	INCLUDE 'config.f90'				!configuration - parameters
	INCLUDE 'initial_conditions.f90'		!values for initial conditions
	INCLUDE 'initial_conditions2.f90'		!values for initial conditions

	INCLUDE 'subroutines/simulation.f90'
	INCLUDE 'subroutines/LIF.f90'			!leaky integrate-and-fire implementation
	INCLUDE 'subroutines/input_gaussian.f90'	!inputs from OU
!==========================================================================================!
	PROGRAM COMPLEMENTARY_ISTDP
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE
	INTEGER					:: i,pw,n
	INTEGER, DIMENSION(:), ALLOCATABLE	:: seed
	CHARACTER(len=1)			:: arg
!======================== getting value from user for sims ================================!
	CALL get_command_argument(1, arg)
	READ(arg,'(I1)')sims_type
!======================== initialising subroutines ========================================!
	CALL config()					!call config file with parameters
	CALL allocation()				!allocate vectors and matrices based on parameters
	CALL initial_conditions()			!implement initial conditions
!==========================================================================================!


!============================ main simulation - control ===================================!
!------------------------ FIRING RATE OF INHIBITORY POPULATIONS ---------------------------!
	!population 1 -> as a function of control firing-rate
	pr(205) = 1.0d0
	!population 2 -> as a function of control firing-rate
	pr(206) = 1.0d0
!==========================================================================================!
!===================== SEED INITIALISATION TO BE THE SAME =================================!
	CALL RANDOM_SEED(size = n)
	ALLOCATE(seed(n))
	seed = seed0 + 37 * (/ (i - 1, i = 1, n) /)
	CALL RANDOM_SEED(PUT = seed)
	DEALLOCATE(seed)
!==========================================================================================!
!--------- simulation without plasticity for membrane potential dynamics ------------------!
	CALL initial_conditions2()	!implement initial conditions
	CALL simulation(20.0d0)		!argument is simulated time in minutes
!------------------------------------------------------------------------------------------!
!==========================================================================================!

!============================ main simulation - 2nd case ==================================!
!------------------------ FIRING RATE OF INHIBITORY POPULATIONS ---------------------------!
	IF(sims_type.EQ.1) THEN
		!population 1 -> as a function of control firing-rate
		pr(205) = 1.0d0
		!population 2 -> as a function of control firing-rate
		pr(206) = 0.8d0
	END IF
	IF(sims_type.EQ.2) THEN
		!population 1 -> as a function of control firing-rate
		pr(205) = 0.0d0
		!population 2 -> as a function of control firing-rate
		pr(206) = 2.8d0
	END IF
	IF(sims_type.EQ.3) THEN
		!population 1 -> as a function of control firing-rate
		pr(205) = 0.0d0
		!population 2 -> as a function of control firing-rate
		pr(206) = 4.1d0
	END IF
!==========================================================================================!
!===================== SEED INITIALISATION TO BE THE SAME =================================!
	CALL RANDOM_SEED(size = n)
	ALLOCATE(seed(n))
	seed = seed0 + 37 * (/ (i - 1, i = 1, n) /)
	CALL RANDOM_SEED(PUT = seed)
	DEALLOCATE(seed)
!==========================================================================================!
!--------- simulation without plasticity for membrane potential dynamics ------------------!
	CALL initial_conditions2()	!implement initial conditions
	CALL simulation(20.0d0)		!argument is simulated time in minutes
!------------------------------------------------------------------------------------------!
!==========================================================================================!

!============================ main simulation - 3rd case ==================================!
!------------------------ FIRING RATE OF INHIBITORY POPULATIONS ---------------------------!
	IF(sims_type.EQ.1) THEN
		!population 1 -> as a function of control firing-rate
		pr(205) = 1.0d0
		!population 2 -> as a function of control firing-rate
		pr(206) = 1.2d0
	END IF
	IF(sims_type.EQ.2) THEN
		!population 1 -> as a function of control firing-rate
		pr(205) = 6.9d0
		!population 2 -> as a function of control firing-rate
		pr(206) = 0.0d0
	END IF
	IF(sims_type.EQ.3) THEN
		!population 1 -> as a function of control firing-rate
		pr(205) = 2.3d0
		!population 2 -> as a function of control firing-rate
		pr(206) = 0.0d0
	END IF
!==========================================================================================!
!===================== SEED INITIALISATION TO BE THE SAME =================================!
	CALL RANDOM_SEED(size = n)
	ALLOCATE(seed(n))
	seed = seed0 + 37 * (/ (i - 1, i = 1, n) /)
	CALL RANDOM_SEED(PUT = seed)
	DEALLOCATE(seed)
!==========================================================================================!
!--------- simulation without plasticity for membrane potential dynamics ------------------!
	CALL initial_conditions2()	!implement initial conditions
	CALL simulation(20.0d0)		!argument is simulated time in minutes
!------------------------------------------------------------------------------------------!
!==========================================================================================!
	END PROGRAM
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

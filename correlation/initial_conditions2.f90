!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                  FILE WITH INITAL CONDITIONS FOR SIMULATION                !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE initial_conditions2()
	USE PARAMETERS
	USE VARIABLES
	USE TEMP
	IMPLICIT NONE
!========================= VARIABLES INITIALISATION =======================================!
	x = 0.0d0			!all variables to zero
	x(1) = pr(2)			!membrane potential to resting membrane potential
	tr = 0.0d0			!simulation time to zero
	spk_post = .FALSE.		!no spike at t=0
	patt_time = 0.0d0		!input rate envelope to zero
	spkt = -1000.0d0
!------------------------------ spike times for LIF ---------------------------------------!
	spkt_post = -1000.0d0
!------------------------------------------------------------------------------------------!
	x(5:9) = 0.0d0			!output averages
	activity = 0.0d0		!input average
	activity_av = 0.0d0		!input average
	activity_av2 = 0.0d0		!input average
	activity_av_t = 0.0d0		!input average
	activity_av_t2 = 0.0d0		!input average
	cross_activity = 0.0d0		!cross term (input*output) average
	cross_activity_t = 0.0d0	!cross term (input*output) average
!==========================================================================================!
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

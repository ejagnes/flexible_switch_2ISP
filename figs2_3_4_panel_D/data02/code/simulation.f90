!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        MAIN SIMULATION -> CALLS ROUTINES FOR INPUT, NEURON AND DATA OUTPUT !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE simulation0(tot_time_r)		!tot_time_r = time in seconds
	USE VARIABLES
	USE PARAMETERS
	IMPLICIT NONE
	INTEGER 		::	t,tt,tot_time,pw
	REAL*8			::	tot_time_r

!========================== TOTAL SIMULATION TIME =========================================!
	tot_time = INT(tot_time_r*60.0d0)
!==========================================================================================!
	activity_avg = 0.0d0
	x(7) = 0.0d0
	x(8) = 0.0d0
!================================ MAIN LOOP ===============================================!
	DO tt = 1,tot_time
		WRITE(*,*)tot_time-tt
	!---------------------------loop over one second of neuronal time--------------------------!
		DO t = 1,one_sec
		!---------------------------from iteration to neuronal time--------------------------------!
			tr = tr + dt
		!-------------------------inhomogeneous input onto postsynaptic neuron---------------------!
			CALL input_g(t)
		!----------------------------leaky integrate-and-fire neuron-------------------------------!
			CALL lif()
		!--------------------------------output data for plots-------------------------------------!
!			CALL output()

			activity_avg(1,:) = activity_avg(1,:) + (activity/200.0d0)
			activity_avg(2,:) = activity_avg(2,:) + ((activity/200.0d0)**2)
			x(7) = x(7) + x(6)
			x(8) = x(8) + x(6)**2
			activity_avg(3,:) = activity_avg(3,:) + x(6)*(activity/200.0d0)

		END DO
	!------------------------------------------------------------------------------------------!
		WRITE(2,*)tr,x(6)
	END DO
!==========================================================================================!
	activity_avg = activity_avg/DBLE(tot_time*one_sec)
	x(7:8) = x(7:8)/DBLE(tot_time*one_sec)
	sigmapatt = DSQRT(activity_avg(2,:)-activity_avg(1,:)**2)
	sigmarate = DSQRT(x(8)-(x(7)**2))

	WRITE(3,*)x(7),sigmarate

	DO pw = 1,n_pw
		WRITE(1,*)pw,(activity_avg(3,pw)-x(7)*activity_avg(1,pw))/(sigmarate*sigmapatt(pw))
	END DO
	END SUBROUTINE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


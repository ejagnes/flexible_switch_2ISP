!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        FILE WITH PARAMETERS FOR SIMULATION                                 !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!        pr(#) -> parameter real                                             !!!!!!!!
!!!!!!!!                                                                            !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	SUBROUTINE config()
	USE PARAMETERS
	IMPLICIT NONE

!====================== FOLDER NAME - 6 CHARACTERS ========================================!
	folder = "data03"
!======================== PRE-SYNAPTIC NEURONS (PATHWAYS)==================================!
	!number of pathways
	n_pw = 16
	!number of excitatory neurons per pathway
	ne_pw = 200
	!number of inhibitory neurons type 1 per pathway
	ni_pw1 = 25
	!number of inhibitory neurons type 2 per pathway
	ni_pw2 = 25
	!total number of pre-synaptic neurons
	ne_input = n_pw*ne_pw
	ni_input1 = n_pw*ni_pw1
	ni_input2 = n_pw*ni_pw2
	!preferred input signal number
	pref_pw = 9
!==========================================================================================!
!============================== SIMULATION PARAMETERS =====================================!
	!integration time step [ms]
	dt = 0.1d0
	!one second in iterations
	one_sec = INT(1000.0d0/dt)
!==========================================================================================!
!========================== NEURON PARAMETERS =============================================!
	!neuron membrane potential time constant, tau_m [ms]
	pr(1) = 30.0d0
	!resting membrane potential [mV]
	pr(2) = -65.0d0
	!refractory period excitatory [ms]
	pr(3) = 5.0d0
	!spiking threshold [mV]
	pr(4) = -50.0d0
	!reset potential [mV]
	pr(9) = -60.0d0
!==========================================================================================!
!========================== SYNAPSE PARAMETERS ============================================!
	!reversal potential - excitatory - AMPA [mV] -> not explicitly used
	pr(31) = 0.0d0
	!reversal potential - inhibitory - GABA_A [mV]
	pr(32) = -80.0d0
	!synaptic time constant - AMPA [ms]
	pr(35) = 5.0d0
	pr(35) = DEXP(-1.0d0*dt/pr(35))
	!synaptic time constant - GABA_A [ms]
	pr(36) = 10.0d0
	pr(36) = DEXP(-1.0d0*dt/pr(36))
!==========================================================================================!
!================================ EXTERNAL INPUT ==========================================!
	!background firing-rate -> excitatory neurons [Hz]
	pr(75) = 2.0d0
	pr(75) = (dt*pr(75))/1000.0d0
	!background firing-rate -> inhibitory neurons [Hz]
	pr(76) = 4.0d0
	pr(76) = (dt*pr(76))/1000.0d0

	!tau for OU process [ms]
	pr(80) = 50.0d0
	pr(80) = pr(80)/10.0d0
	pr(80) = DEXP(-dt/pr(80))
	!decay time 2
	pr(81) = 1.0d0 - pr(80)
	!amplitude (max) [Hz]
	pr(82) = 250.0d0
!==========================================================================================!
!========================== CONNECTION WEIGHTS ============================================!
	!synaptic weight - excitatory -> postsynaptic neuron [g_leak]
	pr(91) = 0.1d0
	!synaptic weight - inhibitory -> postsynaptic neuron [g_leak]
	pr(93) = 0.45d0
!==========================================================================================!
!============================ SMOOTHING OF EXTERNAL INPUT RATE ============================!
	!smoothing time constant [ms]
	pr(101) = 10.0d0
	!increment for smoothed version of rate input
	pr(102) = 1000.0d0/pr(101)
	!decay of smoothed curve
	pr(101) = DEXP(-dt/pr(101))
!==========================================================================================!
!============================ SMOOTHING OF OUTPUT RATE ====================================!
	!smoothing time constant [ms]
	pr(106) = 250.0d0
	!increment for smoothed version of rate input
	pr(107) = 1000.0d0/pr(106)
	!decay of smoothed curve
	pr(106) = DEXP(-dt/pr(106))
!==========================================================================================!
!======================== FILES WITH DATA FROM SIMULATION =================================!
	OPEN(100,file="plots_tmp.txt")
	WRITE(100,"(A6)")folder
	CLOSE(100)

	CALL SYSTEM('mkdir '//folder)
	OPEN(1,file=folder//'/data01.dat')
	OPEN(2,file=folder//'/data02.dat')
	OPEN(3,file=folder//'/data03.dat')
	OPEN(4,file=folder//'/data04.dat')
!	OPEN(5,file=folder//'/data05.dat')
!	OPEN(6,file=folder//'/data06.dat')
!	OPEN(7,file=folder//'/data07.dat')
!	OPEN(8,file=folder//'/data08.dat')
!	OPEN(9,file=folder//'/data09.dat')
!	OPEN(10,file=folder//'/data10.dat')
!	OPEN(11,file=folder//'/data11.dat')
!	OPEN(12,file=folder//'/data12.dat')
!	OPEN(13,file=folder//'/data13.dat')
!	OPEN(14,file=folder//'/data14.dat')
!	OPEN(15,file=folder//'/data15.dat')
!==========================================================================================!
!============================= BACKUP OF CODE =============================================!
	CALL SYSTEM('mkdir '//folder//'/code')
	CALL SYSTEM('cp *f90 '//folder//'/code/')
	CALL SYSTEM('cp subroutines/*f90 '//folder//'/code/')
!==========================================================================================!
	!pi
	dpi = 2.0d0*(4.0d0*ATAN(1.0d0))

	END SUBROUTINE


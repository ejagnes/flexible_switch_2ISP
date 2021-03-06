!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!        DECLARATION OF SHARED VARIABLES (PARAMETERS, VARIABLES, TEMP)       !!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	MODULE PARAMETERS
	IMPLICIT NONE
	INTEGER			:: ne,ni1,ni2,tot_n,total_time,ne_pw,ni_pw1,ni_pw2,n_pw,one_sec,pref_pw
	INTEGER			:: n_trials
	REAL*8			:: pr(300),dt,dpi,seed0
	CHARACTER*6		:: folder
	END MODULE

	MODULE VARIABLES
	IMPLICIT NONE
	REAL*8,ALLOCATABLE	:: msynw(:),spkt(:)
	LOGICAL,ALLOCATABLE	:: spk(:)
	LOGICAL			:: spk_post
	REAL*8			:: x(30),tr,spkt_post,inp_fr
	REAL*8,ALLOCATABLE	:: patt_time(:),inp_patt(:),spkr(:)
	INTEGER			:: sims_type
	REAL,ALLOCATABLE	:: phasic(:,:),tonic(:,:),phasic_f(:,:),tonic_f(:,:)
	END MODULE

	MODULE TEMP
	IMPLICIT NONE
	REAL*8,ALLOCATABLE	:: tmp_inp(:),tmpi1(:),tmpi2(:)
	END MODULE
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

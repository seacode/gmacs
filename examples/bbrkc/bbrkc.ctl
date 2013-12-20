# Gmacs Control File Version 1.02

## npar
8
## ######################################################################### ##
## Prior:
##       0 = uniform
##       1 = normal
##       2 = lognormal
##       3 = beta
##       4 = gamma

## ######################################################################### ##

## _________________________________________________________________________ ##
## ival		lb		ub		phz		prior		p1		p2		#Parameter   ##
   7.5		0		15		 1		0			-10		20		#log_ddot_r
   7.5		0		15		 1		0			-10		20		#log_bar_r
   0.20		0.01	0.50	 1		0			-2.5257	0.50	#m_infty
   36.0		20.0	60.0	-3		1			36.46	38.58	#l_infty
   0.18		0.01	0.90	-3		1			0.243	0.23	#vbk
   0.75		0.00	2.00	-4		0			0.00	2.00	#beta
   10.0		3.00	20.0	 2		2			2.30258	0.20	#mu_r
   0.20		0.00	1.00	 2		3			20.0	80.0    #cv_r
## ------------------------------------------------------------------------- ##

## _________________________________________________________________________ ##
## SELEX_PARS                                                                ##
##      sig=0.05 0.10 0.15 0.20 0.30 0.40 0.50                               ##
##      wt =200. 50.0 22.2 12.5 5.56 3.12 2.00                               ##
## ------------------------------------------------------------------------- ##
## GILL           HOOP                                                       ##
   1              1            ## sel_type(1=logistic,2=eplogis,3=linapprox) ##
  -2             -2            ## estimation phase                           ##
   15             10           ## length-at-50% vulnerability                ##
   3              30           ## std in length-at-50% vulnerabilty          ##
   15             15           ## number of nodes for linear interpolation   ##
   50.0           50.0         ## penalty for 2nd derivatives in linapprox   ##
   200.           200.         ## penalty for dome-shape                     ##
## ------------------------------------------------------------------------- ##

## _________________________________________________________________________ ##
## nflags
6
## flags
15.0		# 2) Minimum size (cm) of individual fish that can be tagged.
0.100		# 3) Std deviation in total catch in first phase.
0.050		# 4) Std deviation in total catch in last phase.
0			# 5) Case value of Size Transition (0=Estimate single P, 1=Estimate time varying linf, 2=use Size transitions)
0.0			# 6) Std deviation in simulated recruitment variation.
0.0			# 7) Std deviation in simulation deviations in capture probabilities.

999 # EOF check.
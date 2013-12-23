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

# BBRKC STUFF FROM HERE ONWARD.

# # Time-varying fishery selectivity
# # 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10
   # 1  1  1  1  1  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2
   # 3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3
   # 4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4

# # Time-varying survey selectivity   
# # 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10 11
   # 5  5  6  6  6  7  7  7  7  7  7  7  7  7  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8 
   # 9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9 
    
# # Selectivity types
 # 1 2 0  
 # 2 2 0
 # 3 2 0
 # 4 2 0  
 # 5 2 0
 # 6 2 0
 # 7 2 0  
 # 8 2 0
 # 9 2 0

# # Is selectivity specified by fleet (1) or for all fleets (0)
# 1
      
# # Specifications for selex (fishery)
# 46.0517019 -100 1000 -1
 # 0.0       -100 1000 1  
 # 0.0       -100 1000 1
 # 0.0       -100 1000 1
# -4.5951199 -100 1000 -1
# 46.0517019 -100 1000 -1
 # 0.0       -100 1000 1  
 # 0.0       -100 1000 1
 # 0.0       -100 1000 1
# -4.5951199 -100 1000 -1
# 23.0258509 -100 1000 1
 # 0.0       -100 1000 1
 # 0.0       -100 1000 1
 # 0.0       -100 1000 1
# -4.5951199 -100 1000 -1
 # 4.5951199 -100 1000 -1
 # 0.0       -100 1000 1
 # 0.0       -100 1000 1
 # 0.0       -100 1000 1
 # 0.0       -100 1000 1
  # 0.0          -1000 1000 1           # Survey
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
  # 0.0          -1000 1000 1
# 100.0          -1000 1000 -1
# 100.0          -1000 1000 -1
   # 1.0986123.0 -1000 1000 -1
# -100.0         -1000 1000 -1
# -100.0         -1000 1000 -1

# # Time-varying fishery retention
# # 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10
   # 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1

# # Specifications the retained probability
 # 0 -100 1000 3
 # 0 -100 1000 3
 # 0 -100 1000 3
 # 0 -100 1000 3
 # 0 -100 1000 3

# # Time-varying Q
# # 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10 11
   # 1  1  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2
   # 3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3
   
# # Number of survey fleets which are within other
# 0                                     # Number of cases
   
 # # Specifications for survey Q
 # -0.1          -100     0  1     0   -100
 # -0.10981487   -100     0 -1  0.896   0.03  
  # 0.0          -100     1 -1     0   -100
 
 # # Specifications for recruitment
 # 14 -10 40 1
 
 # # Specifications for M
 # 00.18 0 1  -2 0.18 1000

 # # Specifications for Madd
 # 0.5 0 1 -2
 # 0.5 0 1 2
 # 0.5 0 1 2
 
 # # Specifications for the initial Ns
 # 0 -10 10 2
 # 0 -10 10 2
 # 0 -10 10 2
 # 0 -10 10 2
 # 0 -10 10 2
 
 # # Specifications for the Transition probabilities
 # 0 -20 50 4
 # 0 -20 50 4
 # 0 -20 50 4
 # 0 -20 50 4
  
# # Objective Fn weights
# # Priors
# # Devs
# 0.00001 100.000 100.000
# # Rec_devs
# 1.0000 
# # parameters
# 0.0001 0.0001 0.0001 0.0001 
# # SurveyQ
# 1.000 1.000 1.000
# # Prior on M
# 1.000
# # 2nd Derviative prior
# 1.000

# # data 
# # Disc-Catch;  Ret-Catch; Twl-Catch; Tan-Catch 
     # 10.00        100.00      10.00      10.00
# # NMFS Survey BSFRF Survey 
        # 1.000        1.000  
# # Effort (Pot) Effort (Trawl) Effort (Tan)
        # 0.000        0.000  10.000
# # Disc-LF ret-LF Trawl-LF Tanner-LF 
   # 0.100   1.000    0.100     0.100      
# # Survey-LF (NMFS)     BSFRF
           # 1.00         1.00

# # Lag to recruitment
# 6

# # SR_Act
# 3

999 # EOF check.
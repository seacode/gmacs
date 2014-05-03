#========================================================================================================
# Gmacs Control File Version 1.02
# General parameter specifications *(only 4 for now):
#========================================================================================================
# Init   Lower   Upper  Phase   Prior   Pmean    Psd   Cov.   Dev.   Dsd   Dmin  Dmax   Block
 0.18	    0	      1	    -1	    0	  0.18  1000     0	    0	  0	    0	   0	   1	#M
 9.76518  -10	     40	     1	    0	    0	   0	 0	    0	  0	    0	   0	   0	#R0
 8.9    	5	     15		-3	    0	  	0  	   0     0	    0	  0	    0	   0	   0	#Recruitment mBeta
 2.0    	1		  5		-3	    0	  	0  	   0     0	    0	  0	    0	   0	     0	#Recruitment m50
#========================================================================================================

# Time-varying natural mortality blocks
# 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10
  1  1  1  1  1  1  1  1  3  3  3  3  2  2  2  2  2  3  3  3  3  3  3  3  3  3  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1

# Specifications for Madd parameters
# Init, Lower, Upper, Phase
0.585 	0 1 2
0.0001 	0 1 2

1	# Form of stock-recruitment relationship (placeholder)
6	# Lag to recruitment (placeholder)

# Specifications for the growth transition matrix
# Time-varying growth (one line per sex) one pattern in this case
# 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10
  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
 #2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2 

# Type of growth estimation (1 = simple parameter-per-class, 2 = linear growth increment, gamma distribution about mean) 
# Pattern, GrowthType, OffsetType
 1 2 0
#2 2 0

# Growth parameters for growthtyp 1, specified for each model size class minus one
# Init, Lower, Upper, Phase
#4.36 	-20 50  5 # Parameter-per-class
# 0.12 	-20 50  5
# 0.95 	-20 50  5
# 1.86 	-20 50  5

# 4.36 	-20 50  5 # Parameter-per-class
# 0.12 	-20 50  5
# 0.95 	-20 50  5
# 1.86 	-20 50  5

# Growth parameters for GrowthType 2
   0.39     0.1	1	 5  # Linear growth increment a 
   0.93     0.1	2	 5	# Linear growth increment b
   0.75	   0.0	1	-5	# Gamma distribution beta
  
# 0.37     0.1	1	-5  # Linear growth increment a 
# 0.93     0.1	2	-5	# Linear growth increment b
# 0.75	   0.0	1	-5	# Gamma distribution beta

# Time-varying molting probability, one for each sex and maturity stage
# 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10
  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1

# Molting types
1 1 0   
 
# Specifications for the molting probability
# Init, Lower, Upper, Phase
 110   70  130  -3      
 160  135  175  -3   

4	# Form of initial numbers (1 = estimate initial size structure, 2 = estimate early recruitment, build from R0, 3 = as for 2, but build from N0)
7   # Number of initial recruitments to estimate (conditional)
 
# Specifications for the initial numbers parameters
# Init, Lower, Upper, Phase
0.8133    -10  10   -2
1.1774    -10  10   -2
0.1239    -10  10   -2
-0.84     -10  10   -2
-1.02     -10  10   -2
0.8133 		-10  10   -2
1.1774 		-10  10   -2
0.1239 		-10  10   -2
-0.84 		-10  10   -2
-1.02 		-10  10   -2

# Time-varying fishery selectivity blocks
# 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10
  1  1  1  1  1  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2
  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3
  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4

# Time-varying survey selectivity blocks
# 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10 11
  5  5  6  6  6  7  7  7  7  7  7  7  7  7  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8 
  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9  9 
   
# Selectivity types
# Pattern, SelType, Offset
1 2 0  
2 2 0
3 2 0
4 2 0  
5 2 0
6 2 0
7 2 0  
8 2 0
9 2 0
# Specifications for Selectivity (Fishing Fleets) parameters
# Init, Lower, Upper, Phase
# Block 1:00  1968-72 for Fleet 2
110   70  130  3      
160  135  175  3 
# Block 2:00  1973+ for Fleet 2
110   70  130  3      
160  135  175  3 
# Block 3:00  1968+ for Fleet 3
110   70  130  3      
160  135  175  3 
# Block 4:00  1968+ for Fleet 4
110   70  130  3      
160  135  175  3 

# Specifications  for Selectivity (Surveys) parameters  
# Init, Lower,  Upper,  Phase   
# Block 5:00  1968-69 for Survey 1
110   70  130  3      
160  135  175  3 
# Block 6:00  1970-72 for Survey 1
110   70  130  3      
160  135  175  3 
# Block 7:00  1973-81 for Survey 1
110   70  130  3      
160  135  175  3 
# Block 8:00  1982+ for Survey 1
110   70  130  3      
160  135  175  3 
# Block 9:00  1968+ for Survey 2
110   70  130  -3      
160  135  175  -3 

# Time-varying fishery retention
# 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10
  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1

# Retention types
1 2 0   
 
# Specifications for the retained probability (one parm per size-class, per fleet)
# Init, Lower, Upper, Phase
110   70  130  3      
160  135  175  3   

# Time-varying Q
# 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10 11
  1  1  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2
  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3
  
# Number of survey fleets which are in a sub-area of the main survey
0  # Number of cases
  
# Specifications for survey Q parameters
# Init, Lower, Upper, Phase, Prior, Pmean, Psd
-2.6e-8  	  -50     1      4   1	0   	-100
-0.10981487   -50     1 	-1   1	0.896   0.03  
 0.0          -50     1 	-1   1	0   	-100

# Objective Fn weights
# (1) Priors
# F Devs
  0.00001 100.000 100.000
# Rec_devs
  1.0000 
# Parameters (Growth, Selex, Reten)
  0.1001 0.1001 0.1001 
# Survey q
  1.000 1.000 1.000
# Prior on M
  1.000
# 2nd Derviative Penalty on Selex Parms
  1.000

# Objective Fn weights
# (2) Data 
# Catch: PotDisc, PotRet, Trawl, Tanner 
  10.00  100.00   10.00   10.00
# LF: PotDisc, PotRet, Trawl, Tanner
  0.100  1.000  0.100  0.100      
# Effort: PotRet, Trawl, Tanner
  0.000  0.000  10.000
# Survey: NMFS, BSFRF 
  1.000  1.000  
# Survey-LF: NMFS, BSFRF
  1.00   1.00
  
#========================================================================================================
#EOF
999
#========================================================================================================


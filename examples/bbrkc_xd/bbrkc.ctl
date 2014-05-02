# Gmacs Control File Version 1.02
# General parameter specifications *(only two for now):
#========================================================================================================
# Init   Lower   Upper  Phase   Prior   Pmean    Psd   Cov.   Dev.   Dsd   Dmin  Dmax   Block
 9.76518  -10	    40	    1	    0	    0	   0	 0	    0	  0	    0	   0	   0	#R0
 0.18	    0	     1	   -1	    0	  0.18  1000     0	    0	  0	    0	   0	   1	#M
#========================================================================================================

1	# Form of stock-recruitment relationship (placeholder)
6	# Lag to recruitment (placeholder)

# Time-varying natural mortality blocks
# 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10
  1  1  1  1  1  1  1  1  3  3  3  3  2  2  2  2  2  3  3  3  3  3  3  3  3  3  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1

# Specifications for Madd parameters
# Init, Lower, Upper, Phase
0.585 	0 1 2
0.0001 	0 1 2

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
1 1 0  
2 1 0
3 1 0
4 1 0  
5 1 0
6 1 0
7 1 0  
8 1 0
9 1 0

# Specifications for Selectivity (Fishing Fleets) parameters
# Init, Lower, Upper, Phase
# Block 1:00  1968-72 for Fleet 2
46.0517019  	-100  1000  -1      
7.93719501  	-100  1000   2     
-0.617569645  	-100  1000   2     
-0.981484548  	-100  1000   2     
-4.5951199  	-100  1000  -1      
# Block 2:00  1973+ for Fleet 2
46.0517019  	-100  1000  -1      
2.743604047 	-100  1000   2     
0.967349593 	-100  1000   2     
-1.965728316  	-100  1000 	 2     
-4.5951199  	-100  1000  -1      
# Block 3:00  1968+ for Fleet 3
3.171179741 	-100  1000   1     
2.699082027 	-100  1000   3     
0.957124967 	-100  1000   3     
-1.472148417  	-100  1000   3     
-4.5951199  	-100  1000  -1      
# Block 4:00  1968+ for Fleet 4
4.5951199 		-100  1000  -1      
3.712349783 	-100  1000   3     
2.884812932 	-100  1000   3     
1.895795309 	-100  1000   3     
0.980092568 	-100  1000   3     

# Specifications  for Selectivity (Surveys) parameters  
# Init, Lower,  Upper,  Phase   
# Block 5:00  1968-69 for Survey 1
1.951350344 	-1000 1000   2     
1.378166653 	-1000 1000   2     
0.567513036 	-1000 1000   2     
-0.698241465  	-1000 1000   2     
-0.83158641 	-1000 1000   2     
# Block 6:00  1970-72 for Survey 1
2.521822408 	-1000 1000   2     
2.034452369 	-1000 1000   2     
1.303003082 	-1000 1000   2     
-0.328685749  	-1000 1000   2     
-1.28138964 	-1000 1000   2     
# Block 7:00  1973-81 for Survey 1
1.018708293 	-1000 1000   2     
0.778642437 	-1000 1000   2     
-0.054054721  	-1000 1000   2     
-0.745344082  	-1000 1000   2     
-0.046671702  	-1000 1000   2  			   
# Block 8:00  1982+ for Survey 1
1.230433954 	-1000 1000   3     
1.059279433 	-1000 1000   3     
0.03830702  	-1000 1000   3     
-0.945483854 	-1000 1000   3     
0.154878154 	-1000 1000   3     
# Block 9:00  1968+ for Survey 2
100 			-1000 1000  -1      
100 			-1000 1000  -1      
1.0986123 		-1000 1000  -1      
-100  			-1000 1000  -1      
-100  			-1000 1000  -1        

# Time-varying fishery retention
# 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10
  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1

# Retention types
1 1 0   
 
# Specifications for the retained probability (one parm per size-class, per fleet)
# Init, Lower, Upper, Phase
50    	-100 100 -4
12.2  	-100 100  4
5.5   	-100 100  4
-0.1  	-100 100  4
-6.7  	-100 100  4

# 110   70  130  3      
# 160  135  175  3   

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

4	# Form of initial numbers (1 = estimate initial size structure, 2 = estimate early recruitment, build from R0, 3 = as for 2, but build from N0)
7   # Number of initial recruitments to estimate (conditional)
 
# Specifications for the initial numbers parameters
# Init, Lower, Upper, Phase
0.8133 		-10  10   -2
1.1774 		-10  10   -2
0.1239 		-10  10   -2
-0.84 		-10  10   -2
-1.02 		-10  10   -2

# Specifications for the growth transition matrix
# Time-varying growth (one line per sex)
# 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10
  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
  #2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2 

# Type of growth estimation (1 = simple parameter-per-class, 2 = linear growth increment, gamma distribution about mean) 
1 2 0
#2 2 0

# Growth parameters for option 1
# Init, Lower, Upper, Phase
# 4.36 	-20 50  5
# 0.12 	-20 50  5
# 0.95 	-20 50  5
# 1.86 	-20 50  5

# 4.36 	-20 50  5
# 0.12 	-20 50  5
# 0.95 	-20 50  5
# 1.86 	-20 50  5

# Growth parameters for option 2
0.37     0.1	1	 5  # Linear growth increment a 
0.93     0.1	2	 5	# Linear growth increment b
0.75	 0.0	1	-5	# Gamma distribution beta
 
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

#EOF
999

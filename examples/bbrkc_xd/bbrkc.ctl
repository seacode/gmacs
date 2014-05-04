#========================================================================================================
# Gmacs Control File Version 1.02
# General parameter specifications *(only 4 for now):
#========================================================================================================
# Init   Lower   Upper  Phase   Prior   Pmean    Psd   Cov.   Dev.   Dsd   Dmin  Dmax   Block
 0.18	    0	      1	    -1	    0	  0.18  1000     0	    0	  0	    0	   0	   1	#M
 9.76518  -10	     40	     1	    0	    0	   0	 0	    0	  0	    0	   0	   0	#R0
 8.9    	5	     15		 3	    0	  	0  	   0     0	    0	  0	    0	   0	   0	#Recruitment mBeta
 2.5    	1		  5		-3	    0	  	0  	   0     0	    0	  0	    0	   0	   0	#Recruitment m50
#========================================================================================================

# Time-varying natural mortality blocks
# 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10
  1  1  1  1  1  1  1  1  3  3  3  3  2  2  2  2  2  3  3  3  3  3  3  3  3  3  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1

# Specifications for Madd parameters
# Init, Lower, Upper, Phase
0.585 	0 1   2
0.0001 	0 1   2

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
  0.39     0.1	2	 5  # Linear growth increment a 
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

4	 # Form of initial numbers (1 = estimate initial size structure, 2 = estimate early recruitment, build from R0, 3 = as for 2, but build from N0)
15   # Number of initial recruitments to estimate (conditional)
 
# Specifications for the initial numbers parameters
# Init, Lower, Upper, Phase
	0.8133    	-10  10   -2
	0.8133 		-10  10   -2
	1.1774 		-10  10   -2
	1.1774    	-10  10   -2
	0.1239 		-10  10   -2
	0.1239    	-10  10   -2
	-0.840 		-10  10   -2
	-0.840    	-10  10   -2
	-1.020    	-10  10   -2
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
1 1 0  
2 1 0
3 1 0
4 1 0  
5 1 0
6 1 0
7 1 0  
8 1 0
9 2 0
# Specifications for Selectivity (Fishing Fleets) parameters
# Init, Lower, Upper, Phase
# Block 1:00  1968-72 for Fleet 2
# 110   50  120  2      
# 155  120  180 -2 
# # Block 2:00  1973+ for Fleet 2
# 110   50  120  2      
# 155  120  180 -2  
# # Block 3:00  1968+ for Fleet 3
# 122   90  135  3      
# 155  135  180 -3 
# # Block 4:00  1968+ for Fleet 4
# 130   80  150  3      
# 155  155  180 -3

# Block 1:00  1968-72 for Fleet 2
46.0517019  	-100  1000  -1
46.0517019  	-100  1000   1       
7.93719501  	-100  1000   2
7.93719501  	-100  1000   2      
-0.617569645  	-100  1000   2
-0.617569645  	-100  1000   2     
-0.981484548  	-100  1000   2
-0.981484548  	-100  1000   2     
-4.5951199  	-100  1000   1
-4.5951199  	-100  1000  -1
# Block 2:00  1973+ for Fleet 2
46.0517019  	-100  1000  -1
46.0517019  	-100  1000   1      
2.743604047 	-100  1000   2
2.743604047 	-100  1000   2     
0.967349593 	-100  1000   2 
0.967349593 	-100  1000   2     
-1.965728316  	-100  1000   2 
-1.965728316  	-100  1000   2     
-4.5951199  	-100  1000   1
-4.5951199  	-100  1000  -1      
# Block 3:00  1968+ for Fleet 3
3.171179741 	-100  1000   1
3.171179741 	-100  1000   1     
2.699082027 	-100  1000   3     
2.699082027 	-100  1000   3
0.957124967 	-100  1000   3
0.957124967 	-100  1000   3     
-1.472148417  	-100  1000   3
-1.472148417  	-100  1000   3
-4.5951199  	-100  1000   1    
-4.5951199  	-100  1000  -1      
# Block 4:00  1968+ for Fleet 4
4.5951199 		-100  1000  -1
4.5951199 		-100  1000   1      
3.712349783 	-100  1000   3
3.712349783 	-100  1000   3     
2.884812932 	-100  1000   3
2.884812932 	-100  1000   3     
1.895795309 	-100  1000   3
1.895795309 	-100  1000   3     
0.980092568 	-100  1000   3 
0.980092568 	-100  1000   3    

# Specifications  for Selectivity (Surveys) parameters  
# Init, Lower,  Upper,  Phase   
#	Block	5:00	1968-69
5.459579149		-1000	1000	2
6.662955939		-1000	1000	2
5.852543626		-1000	1000	2
5.104537505		-1000	1000	2
5.03920472		-1000	1000	2
4.630798234		-1000	1000	2
3.8646481		-1000	1000	2
4.133892845		-1000	1000	2
2.215065987		-1000	1000	2
-2.71124116		-1000	1000	2
# Block 6:00  1970-72 for Survey  1
5.996744923		-1000	1000	2
5.550408981		-1000	1000	2
4.814085399		-1000	1000	2
4.1626688		-1000	1000	2
3.502306398		-1000	1000	2
2.736644655		-1000	1000	2
1.581597701		-1000	1000	2
0.5115531		-1000	1000	2
-0.307125637	-1000	1000	2
-2.408541991	-1000	1000	2
# Block 7:00  1973-81 for Survey  1
4.349913701		-1000	1000	2
4.847710171		-1000	1000	2
4.158845167		-1000	1000	2
3.529600754		-1000	1000	2
2.828326513		-1000	1000	2
2.146152441		-1000	1000	2
1.394673774		-1000	1000	2
0.606391491		-1000	1000	2
-0.057781571	-1000	1000	2
-2.295824329	-1000	1000	2
# Block 8:00  1982+ for Survey  1
2.999196037		-1000	1000	3
2.632337643		-1000	1000	3
2.10814007		-1000	1000	3
1.607167023		-1000	1000	3
1.031093859		-1000	1000	3
0.185767284		-1000	1000	3
-0.723790681	-1000	1000	3
-1.641429316	-1000	1000	3
-0.733155126	-1000	1000	3
0.154878154		-1000	1000	3
# Block 9:00  1968+ for Survey 2
117  110  120  -3      
123  121  130  -3 

# Time-varying fishery retention
# 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10
  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1

# Retention types (option 1: one parm per size-class, option 2: logistic [s50, s95]
1 2 0   
 
# Specifications for the retained probability (one row, per directed fleet)
# Init, Lower, Upper, Phase
135  130  140  3      
145  141  155  4    

# Time-varying Q
# 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10 11
  1  1  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2
  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3  3
  
# Number of survey fleets which are in a sub-area of the main survey
0  # Number of cases
  
# Specifications for survey Q parameters
# Init, 	Lower, Upper, Phase, Prior, Pmean, Psd
-0.001	 	  -50     1      4   1	0   	-100
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


# —————————————————————————————————————————————————————————————————————————————————————— #
# Controls for leading parameter vector theta   
# LEGEND FOR PRIOR:
#                  0 -> uniform
#                  1 -> normal
#                  2 -> lognormal
# —————————————————————————————————————————————————————————————————————————————————————— #
# ntheta
7
# —————————————————————————————————————————————————————————————————————————————————————— #
# ival        lb        ub        phz   prior     p1      p2         # parameter         #                            
# —————————————————————————————————————————————————————————————————————————————————————— #
  0.18      0.01         1          3       2   0.18    0.02         # M
   3.0       -10        20         -1       1    3.0     1.0         # logR0
   3.0       -10        20          1       1    3.0     1.0         # logR1      
   3.0       -10        20          1       1    3.0     1.0         # logRbar      
  72.5        65       150          2       0      0       0         # Recruitment mBeta
  0.50         0         5          2       0      0       0         # Recruitment m50
 -0.51       -10        0.75       -1       0      0       0         # ln(sigma_R)
# —————————————————————————————————————————————————————————————————————————————————————— #

## ———————————————————————————————————————————————————————————————————————————————————— ##
## SELECTIVITY CONTROLS                                                                 ##
##    -Each gear must have a selectivity and a retention selectivity                    ##
## LEGEND sel_type:1=coefficients,2=logistic,3=logistic95                               ##
##        Index: use +ve for selectivity, -ve for retention
## ———————————————————————————————————————————————————————————————————————————————————— ##
## ivector for number of year blocks or nodes                                           ##
## Gear-1    Gear-2    Gear-3   Gear-4    
   1         1         1        1         #Selectivity blocks
   1         1         1        1         #Retention blocks 
## ———————————————————————————————————————————————————————————————————————————————————— ##
##        sel   sel  sel sex  size   year  phz                                          ##
## Index  type  mu   sd  dep  nodes  nodes mirror lam1  lam2  lam3 | blocks             ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## Selectivity P(capture of all sizes)
   1      2    180   10  0    1      1     2      12.5  12.5  12.5   1975
   2      2     90   10  0    1      1     2      12.5  12.5  12.5   1975 
   3      2     80   10  0    1      1     2      12.5  12.5  12.5   1975
   4      2     80   10  0    1      1     2      12.5  12.5  12.5   1975
## ———————————————————————————————————————————————————————————————————————————————————— ##
## Retained
  -1      2    135    2  0    1      1     2      12.5  12.5  12.5   1975
  -2      2     95   10  0    1      1     2      12.5  12.5  12.5   1975
  -3      2     90   10  0    1      1     2      12.5  12.5  12.5   1975
  -4      2     90   10  0    1      1     2      12.5  12.5  12.5   1975
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## PENALTIES FOR AVERAGE FISHING MORTALITY RATE FOR EACH GEAR
## ———————————————————————————————————————————————————————————————————————————————————— ##
## Trap  Trawl NMFS  BSFRF
## Mean_F  STD_PHZ1  STD_PHZ2  PHZ
     0.40      0.10      0.10    1
     0.10      0.10      0.10    1
     0.00      2.00      2.00   -1
     0.00      2.00      2.00   -1
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## OPTIONS FOR SIZE COMPOSTION DATA (COLUMN FOR EACH MATRIX)
## LIKELIHOOD OPTIONS:
##          -1) multinomial with fixed sample size
##          -2) multinomial with estimated sample size
##          -3) logistic normal
##          -4) multivariate-t
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## OTHER CONTROLS
## ———————————————————————————————————————————————————————————————————————————————————— ##
  3       # Estimated rec_dev phase
  0       # VERBOSE FLAG (0 = off, 1 = on)
  0       # INITIALIZE MODEL AT UNFISHED RECRUITS (0=FALSE, 1=TRUE)



# Time-varying natural mortality blocks
# 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10 11 12 13
  1  3  3  3  3  2  2  2  2  2  3  3  3  3  3  3  3  3  3  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1

# Specifications for Madd parameters
# Init, Lower, Upper, Phase
0.585   0 1   2
0.0001  0 1   2

1 # Form of stock-recruitment relationship (placeholder)
1 # Lag to recruitment (placeholder)

# Specifications for the growth transition matrix
# Time-varying growth (one line per sex) one pattern in this case
# 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10 11 12 13
  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
 #2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2  2   

# Type of growth estimation (1 = simple parameter-per-class, 2 = linear growth increment, gamma distribution about mean) 
# Pattern, GrowthType, OffsetType
 1 2 0
#2 2 0

# Growth parameters for growthtyp 1, specified for each model size class minus one
# Init, Lower, Upper, Phase
#4.36   -20 50  5 # Parameter-per-class
# 0.12  -20 50  5
# 0.95  -20 50  5
# 1.86  -20 50  5

# 4.36  -20 50  5 # Parameter-per-class
# 0.12  -20 50  5
# 0.95  -20 50  5
# 1.86  -20 50  5

# Growth parameters for GrowthType 2
  0.39     0.1  2  5  # Linear growth increment a 
  0.93     0.1  2  5  # Linear growth increment b
  0.75     0.0  1 -5  # Gamma distribution beta
  
# 0.37     0.1  1 -5  # Linear growth increment a 
# 0.93     0.1  2 -5  # Linear growth increment b
# 0.75     0.0  1 -5  # Gamma distribution beta

# Time-varying molting probability, one for each sex
# 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10 11 12 13
  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  
  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  

# Molting types
1 1 0   
 
# Specifications for the molting probability
# Init, Lower, Upper, Phase
 110   70  130  -3      
 160  135  175  -3   

4  # Form of initial numbers (1 = estimate initial size structure, 2 = estimate early recruitment, build from R0, 3 = as with 2 but build from N0, 4 = as with 2 but use dummy growth trans matrix)
15   # Number of initial recruitments to estimate (conditional)
 
# Specifications for the initial numbers parameters
# Init, Lower, Upper, Phase
  0.8133    -10  10   -2
  0.8133    -10  10   -2
  1.1774    -10  10   -2
  1.1774    -10  10   -2
  0.1239    -10  10   -2
  0.1239    -10  10   -2
  -0.840    -10  10   -2
  -0.840    -10  10   -2
  -1.020    -10  10   -2
  -1.02     -10  10   -2

## TOBE DEPRECATED
# Time-varying fishery selectivity blocks (one row per active fleet)
# 75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99  0 1 2 3 4 5 6 7 8 9 10  11  12  13  
   1  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 
   2  2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 

## TOBE DEPRECATED
# Time-varying survey selectivity blocks (one row per survey)
# 75  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99  0 1 2 3 4 5 6 7 8 9 10  11  12  13  14
   3  3 3 3 3 3 3 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
   5  5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5

## TOBE DEPRECATED
# Selectivity types
# Pattern, SelType, Offset
1 1 0  
2 1 0
3 1 0
4 1 0  
5 2 0

## ———————————————————————————————————————————————————————————————————————————————————— ##
## SELECTIVITY CONTROLS                                                                 ##
## LEGEND sel_type:1=coefficients,2=logistic,3=logistic95                               ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## ivector for number of year blocks or nodes                                           ##
## Gear-1    Gear-2    Gear-3   Gear-4    Gear-5
   1         1         1        1         1 
## ———————————————————————————————————————————————————————————————————————————————————— ##
##        sel   sel  sel  size   year  phz                                              ##
## Index  type  mu   sd   nodes  nodes mirror lam1  lam2  lam3 | blocks                 ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
   1      1     80   10   1      1     2      12.5  12.5  12.5   1975
   1      1     80   10   1      1     2      12.5  12.5  12.5   1975
   1      1     80   10   1      1     2      12.5  12.5  12.5   1975
   1      1     80   10   1      1     2      12.5  12.5  12.5   1975
   1      2     80   10   1      1     2      12.5  12.5  12.5   1975
## ———————————————————————————————————————————————————————————————————————————————————— ##


## TOBE DEPRECATED
# Specifications for Selectivity (Fishing Fleets) parameters
# Init, Lower, Upper, Phase
# # Block 1:  1973+ for Fleet 1
# 110   50  120  2      
# 155  120  180 -2  
# # Block 2:  1968+ for Fleet 2
# 122   90  135  3      
# 155  135  180 -3 

# Block 1:  1973+ for Fleet 1
46.0517019    -100  1000  -1
46.0517019    -100  1000   1      
2.743604047   -100  1000   2
2.743604047   -100  1000   2     
0.967349593   -100  1000   2 
0.967349593   -100  1000   2     
-1.965728316    -100  1000   2 
-1.965728316    -100  1000   2     
-4.5951199    -100  1000   1
-4.5951199    -100  1000  -1      
# Block 2:  1968+ for Fleet 2
3.171179741   -100  1000   1
3.171179741   -100  1000   1     
2.699082027   -100  1000   3     
2.699082027   -100  1000   3
0.957124967   -100  1000   3
0.957124967   -100  1000   3     
-1.472148417    -100  1000   3
-1.472148417    -100  1000   3
-4.5951199    -100  1000   1    
-4.5951199    -100  1000  -1      
  
# Specifications  for Selectivity (Surveys) parameters  
# Init, Lower,  Upper,  Phase   
# Block 3:  1973-81 for Survey  1
4.349913701   -1000 1000  2
4.847710171   -1000 1000  2
4.158845167   -1000 1000  2
3.529600754   -1000 1000  2
2.828326513   -1000 1000  2
2.146152441   -1000 1000  2
1.394673774   -1000 1000  2
0.606391491   -1000 1000  2
-0.057781571  -1000 1000  2
-2.295824329  -1000 1000  2
# Block 4:  1982+ for Survey  1
2.999196037   -1000 1000  3
2.632337643   -1000 1000  3
2.10814007    -1000 1000  3
1.607167023   -1000 1000  3
1.031093859   -1000 1000  3
0.185767284   -1000 1000  3
-0.723790681  -1000 1000  3
-1.641429316  -1000 1000  3
-0.733155126  -1000 1000  3
0.154878154   -1000 1000  3
# Block 5:  1968+ for Survey 2
117  110  120  -3      
123  121  130  -3 

# Time-varying fishery retention (one row per directed fleet)
# 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 00 01 02 03 04 05 06 07 08 09 10 11 12 13
   1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1

# Retention types (option 1: one parm per size-class, option 2: 2 parameter logistic [s50, s95])
1 2 0   
 
# Specifications for the retained probability 
# Init, Lower, Upper, Phase
135  130  140  3      
145  141  155  4    

# Time-varying Q
#  75 76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99  0 1 2 3 4 5 6 7 8 9 10  11  12  13  14
  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
  2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2

# Number of survey fleets which are in a sub-area of the main survey
0  # Number of cases
  
# Specifications for survey Q parameters
# Init,   Lower, Upper, Phase, Prior, Pmean, Psd
-0.10981487   -50     1   -4   1  0.896   0.03  
 0.0          -50     1   -1   1  0     -100

# Objective Fn weights
# (1) Priors
# F Devs
  0.00001 100.000
# Rec_devs
  1.0000 
# Parameters (Growth, Selex, Reten)
  0.1001 0.1001 0.1001 
# Survey q
  1.000 1.000
# Prior on M
  1.000
# 2nd Derviative Penalty on Selex Parms
  1.000

# Objective Fn weights
# (2) Data 
# Catch: PotRet, PotDisc, Trawl
  10.00  100.00   10.00
# LF: PotRet, PotDisc, Trawl
  0.100  1.000  0.100
# Effort: PotRet, Trawl
  0.000  0.000
# Survey: NMFS, BSFRF 
  1.000  1.000  
# Survey-LF: NMFS, BSFRF
  1.00   1.00
  
#========================================================================================================
#EOF
999


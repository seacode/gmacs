## ———————————————————————————————————————————————————————————————————————————————————— ##
## LEADING PARAMETER CONTROLS                                                           ##
##     Controls for leading parameter vector (theta)                                    ##
## LEGEND                                                                               ##
##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## ntheta
   91
## ———————————————————————————————————————————————————————————————————————————————————— ##
## ival        lb        ub        phz   prior     p1      p2         # parameter       ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
    0.18        0.15    0.2         -4       2    0.18    0.04        # M
  # 0.18        0.15    0.4          4       2    0.18    0.03        # M
    0.0        -0.4     0.4          4       1    0.0     0.03        # M
   16.5       -10        18         -2       0  -10.0    20.0         # logR0
   19.5       -10        25          3       0   10.0    25.0         # logRini, to estimate if NOT initialized at unfished (n68)
   16.5       -10        25          1       0   10.0    20.0   #1      # logRbar, to estimate if NOT initialized at unfished      #1
   72.5        55       100         -4       1   72.5     7.25        # recruitment expected value (males or combined)
    0.726149   0.32      1.64        3       0    0.1     5.0         # recruitment scale (variance component) (males or combined)
    0.00       -5         5         -4       0   0.0     20.00        # recruitment expected value (females)
    0.00       -1.69      0.40       3       0    0.0    20.0         # recruitment scale (variance component) (females)
   -0.10536     -10         0.75      -4       0  -10.0     0.75        # ln(sigma_R)
   #-0.10        -5         5.0       4       0   -10.0     10.0        # ln(sigma_R)
    0.75        0.20      1.00      -2       3    3.0     2.00        # steepness
    0.01        0.00      1.00      -3       3    1.01    1.01        # recruitment autocorrelation
#   0.00      -10         4          2       0   10.0    20.00        # Deviation for size-class 1 (normalization class)
    1.107962885630      -10         4          9       0   10.0    20.00        # Deviation for size-class 2
    0.563229168219      -10         4          9       0   10.0    20.00        # Deviation for size-class 3
    0.681928313426      -10         4          9       0   10.0    20.00        # Deviation for size-class 4
    0.491057364532      -10         4          9       0   10.0    20.00        # Deviation for size-class 5
    0.407911777560      -10         4          9       0   10.0    20.00        # Deviation for size-class 6
    0.436516142684      -10         4          9       0   10.0    20.00        # Deviation for size-class 7
    0.40612675395550    -10         4          9       0   10.0    20.00        # Deviation for size-class 8
    0.436145974880      -10         4          9       0   10.0    20.00        # Deviation for size-class 9
    0.40494522852708     -10         4         9        0   10.0    20.00        # Deviation for size-class 10
    0.30401970466854     -10         4         9        0   10.0    20.00        # Deviation for size-class 11
    0.2973752673022     -10         4          9       0   10.0    20.00        # Deviation for size-class 12
    0.1746800712364   -10         4          9       0   10.0    20.00        # Deviation for size-class 13
    0.0845298456942     -10         4          9       0   10.0    20.00        # Deviation for size-class 14
    0.0107462399193     -10         4          9       0   10.0    20.00        # Deviation for size-class 15
    -0.190468322904     -10         4          9       0   10.0    20.00        # Deviation for size-class 16
    -0.376312503735     -10         4          9       0   10.0    20.00        # Deviation for size-class 17
    -0.699162895473     -10         4          9       0   10.0    20.00        # Deviation for size-class 18
    -1.15881771530      -10         4          9       0   10.0    20.00        # Deviation for size-class 19
    -1.17311583316      -10         4          9       0   10.0    20.00        # Deviation for size-class 20
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 1
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 2
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 3
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 4
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 5
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 6
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 7
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 8
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 9
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 10
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 11
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 12
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 13
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 14
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 15
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 16
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 17
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 18
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 19
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 20
    0.425704202053      -10         4          9       0   10.0    20.00        # Deviation for size-class 1
    2.268408592660      -10         4          9       0   10.0    20.00        # Deviation for size-class 2
    1.810451373080      -10         4          9       0   10.0    20.00        # Deviation for size-class 3
    1.37035725111       -10         4          9       0   10.0    20.00        # Deviation for size-class 4
    1.158258087990      -10         4          9       0   10.0    20.00        # Deviation for size-class 5
    0.596196784439      -10         4          9       0   10.0    20.00        # Deviation for size-class 6
    0.225756761257      -10         4          9       0   10.0    20.00        # Deviation for size-class 7
    -0.0247857565368    -10         4          9       0   10.0    20.00        # Deviation for size-class 8
    -0.214045895269     -10         4          9       0   10.0    20.00        # Deviation for size-class 9
    -0.560539577780     -10         4          9       0   10.0    20.00        # Deviation for size-class 10
    -0.974218300021     -10         4          9       0   10.0    20.00        # Deviation for size-class 11
    -1.24580072031      -10         4          9       0   10.0    20.00        # Deviation for size-class 12
    -1.49292897450      -10         4          9       0   10.0    20.00        # Deviation for size-class 13
    -1.94135821253      -10         4          9       0   10.0    20.00        # Deviation for size-class 14
    -2.05101560679      -10         4          9       0   10.0    20.00        # Deviation for size-class 15
    -1.94956606430      -10         4          9       0   10.0    20.00        # Deviation for size-class 16
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 17
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 18
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 19
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 20
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 1
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 2
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 3
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 4
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 5
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 6
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 7
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 8
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 9
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 10
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 11
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 12
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 13
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 14
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 15
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 16
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 17
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 18
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 19
 -100.00      -101         5         -2       0   10.0    20.00        # Deviation for size-class 20

#	weight-at-length input	method	(1 = allometry	[w_l = a*l^b],	2 = vector by sex)																												
2																																										
##	Males																																									
0.000224781	0.000281351	0.000346923	0.000422209	0.000507927	0.000604802	0.000713564	0.00083495	0.0009697	0.00111856	0.00128229	0.00146163	0.00165736	0.00187023	0.00210101	0.00235048	0.00261942	0.00290861	0.00321882	0.0039059
##	Females																																									
0.0002151	0.00026898	0.00033137	0.00040294	0.00048437	0.00062711	0.0007216	0.00082452	0.00093615	0.00105678	0.00118669	0.00132613	0.00147539	0.00163473	0.00180441	0.00218315	0.00218315	0.00218315	0.00218315	0.0021831
# Proportion mature by sex
0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	1	1	1	1	1
0	0	0	0	0	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1
# Proportion legal by sex
0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	1	1	1	1	1
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0

## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## GROWTH PARAMETER CONTROLS                                                            ##
##     Two lines for each parameter if split sex, one line if not                       ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
# Use growth transition matrix option (1=read in growth-increment matrix; 2=read in size-transition; 3=gamma distribution for size-increment; 4=gamma distribution for size after increment)
3
# growth increment model (1=alpha/beta; 2=estimated by size-class;3=pre-specified/emprical)
3
# molt probability function (0=pre-specified; 1=flat;2=declining logistic)
2
# Maximum size-class for recruitment(males then females)
7 5
## number of size-increment periods
1 3
## Year(s) size-incremnt period changes (blank if no changes)
1983 1994
## number of molt periods
2 2
## Year(s) molt period changes (blank if no changes)
1980 1980
## Beta parameters are relative (1=Yes;0=no)
1

## ———————————————————————————————————————————————————————————————————————————————————— ##
## ival       lb        ub        phz   prior     p1      p2          # parameter       ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
16.5	0	20	-33	0	0	999		# Males
16.5	0	20	-33	0	0	999		# Males
16.4	0	20	-33	0	0	999		# Males
16.3	0	20	-33	0	0	999		# Males
16.3	0	20	-33	0	0	999		# Males
16.2	0	20	-33	0	0	999		# Males
16.2	0	20	-33	0	0	999		# Males
16.1	0	20	-33	0	0	999		# Males
16.1	0	20	-33	0	0	999		# Males
16	    0	20	-33	0	0	999		# Males
16	    0	20	-33	0	0	999		# Males
15.9	0	20	-33	0	0	999		# Males
15.8	0	20	-33	0	0	999		# Males
15.8	0	20	-33	0	0	999		# Males
15.7	0	20	-33	0	0	999		# Males
15.7	0	20	-33	0	0	999		# Males
15.6	0	20	-33	0	0	999		# Males
15.6	0	20	-33	0	0	999		# Males
15.5	0	20	-33	0	0	999		# Males
15.5	0	20	-33	0	0	999		# Males
#1.38403  0.5	3.7	7	0	0	999		# Males (beta)
1.0     0.5 3.0  6  0   0   999     # Males (beta)
13.8	0	20	-33	0	0	999		# Females
12.2	0	20	-33	0	0	999		# Females
10.5	0	20	-33	0	0	999		# Females
8.4	0	20	-33	0	0	999		# Females
7.5	0	20	-33	0	0	999		# Females
7	0	20	-33	0	0	999		# Females
6.6	0	20	-33	0	0	999		# Females
6.1	0	20	-33	0	0	999		# Females
5.6	0	20	-33	0	0	999		# Females
5.1	0	20	-33	0	0	999		# Females
4.6	0	20	-33	0	0	999		# Females
4.1	0	20	-33	0	0	999		# Females
3.6	0	20	-33	0	0	999		# Females
3.2	0	20	-33	0	0	999		# Females
2.7	0	20	-33	0	0	999		# Females
2.2	0	20	-33	0	0	999		# Females
1.7	0	20	-33	0	0	999		# Females
1.2	0	20	-33	0	0	999		# Females
0.7	0	20	-33	0	0	999		# Females
0.4	0	20	-33	0	0	999		# Females
#1.38403	0.5	3.0	 7	0	0	999		# Females (beta)
1.5 0.5  3.0  6  0   0   999     # Females (beta)
15.4	0	20	-33	0	0	999		# Females
13.8	0	20	-33	0	0	999		# Females
12.2	0	20	-33	0	0	999		# Females
10.5	0	20	-33	0	0	999		# Females
8.9	0	20	-33	0	0	999		# Females
7.9	0	20	-33	0	0	999		# Females
7.2	0	20	-33	0	0	999		# Females
6.6	0	20	-33	0	0	999		# Females
6.1	0	20	-33	0	0	999		# Females
5.6	0	20	-33	0	0	999		# Females
5.1	0	20	-33	0	0	999		# Females
4.6	0	20	-33	0	0	999		# Females
4.1	0	20	-33	0	0	999		# Females
3.6	0	20	-33	0	0	999		# Females
3.2	0	20	-33	0	0	999		# Females
2.7	0	20	-33	0	0	999		# Females
2.2	0	20	-33	0	0	999		# Females
1.7	0	20	-33	0	0	999		# Females
1.2	0	20	-33	0	0	999		# Females
0.7	0	20	-33	0	0	999		# Females
0.0     -1.0	1.0	 -7	0	0	999		# Females (beta)
#1.38403	0.5	3.7	 -7	0	0	999		# Females (beta)
15.1	0	20	-33	0	0	999		# Females
14	0	20	-33	0	0	999		# Females
12.9	0	20	-33	0	0	999		# Females
11.8	0	20	-33	0	0	999		# Females
10.6	0	20	-33	0	0	999		# Females
8.7	0	20	-33	0	0	999		# Females
7.4	0	20	-33	0	0	999		# Females
6.6	0	20	-33	0	0	999		# Females
6.1	0	20	-33	0	0	999		# Females
5.6	0	20	-33	0	0	999		# Females
5.1	0	20	-33	0	0	999		# Females
4.6	0	20	-33	0	0	999		# Females
4.1	0	20	-33	0	0	999		# Females
3.6	0	20	-33	0	0	999		# Females
3.2	0	20	-33	0	0	999		# Females
2.7	0	20	-33	0	0	999		# Females
2.2	0	20	-33	0	0	999		# Females
1.7	0	20	-33	0	0	999		# Females
1.2	0	20	-33	0	0	999		# Females
0.7	0	20	-33	0	0	999		# Females
0.0     -1.0	1.0	 -7	0	0	999		# Females (beta)
#1.38403	0.5	3.7	 -7	0	0	999		# Females (beta)
## ——————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## MOLTING PROBABILITY CONTROLS                                                         ##
##     Two lines for each parameter if split sex, one line if not                       ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## ival       lb        ub        phz   prior     p1      p2          # parameter       ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## males and combined
  145.0386     100.     500.0       3       0    0.0    999.0         # molt_mu males
    0.053036     0.02     2.0       3       0    0.0    999.0         # molt_cv males
  145.0386     100.     500.0       3       0    0.0    999.0         # molt_mu males
    0.053036     0.02     2.0       3       0    0.0    999.0         # molt_cv males
## females
  300.0000       5.     500.0      -4       0    0.0    999.0         # molt_mu females (molt every year)
    0.01         0.001    9.0      -4       0    0.0    999.0         # molt_cv females (molt every year)
  300.0000       5.     500.0      -4       0    0.0    999.0         # molt_mu females (molt every year)
    0.01         0.001    9.0      -4       0    0.0    999.0         # molt_cv females (molt every year)
## ——————————————————————————————————————————————————————————————————————————————————— ##

# The custom growth-increment matrix

# custom molt probability matrix


## ———————————————————————————————————————————————————————————————————————————————————— ##
## SELECTIVITY CONTROLS                                                                 ##
##     Selectivity P(capture of all sizes). Each gear must have a selectivity and a     ##
##     retention selectivity. If a uniform prior is selected for a parameter then the   ##
##     lb and ub are used (p1 and p2 are ignored)                                       ##
## LEGEND                                                                               ##
##     sel type: 0 = parametric, 1 = coefficients (NIY), 2 = logistic, 3 = logistic95,  ##
##               4 = double normal (NIY)                                                ##
##     gear index: use +ve for selectivity, -ve for retention                           ##
##     sex dep: 0 for sex-independent, 1 for sex-dependent                              ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## Gear-1   Gear-2   Gear-3   Gear-4   Gear-5   Gear-6
## PotFshry TrawlByc TCFshry  FixedGr  NMFS     BSFRF
   1        1        1        1        2        1         # selectivity periods
   1        0        1        0        0        0         # sex specific selectivity
   2        2        2        2        2        2         # male selectivity type
   2        2        2        2        2        2         # female selectivity type
   0        0        0        0        6        0   #6      # within another gear
   5        0        0        0        0        0         #-NEW: extra parameters for each pattern by fleet, males
   0        0        0        0        0        0         #-NEW: extra parameters for each pattern by fleet, females
## Gear-1   Gear-2   Gear-3   Gear-4   Gear-5   Gear-6
   2        1        1        1        1        1         # retention periods
   1        0        0        0        0        0         # sex specific retention
   2        6        6         6        6        6         # male   retention type
   6        6        6        6        6        6         # female retention type
   1        0        0        0        0        0         # male   retention flag (0 = no, 1 = yes)
   0        0        0        0        0        0         # female retention flag (0 = no, 1 = yes)
   0        0        0        0        0        0         #-NEW: extra parameters for each pattern by fleet, males
   0        0        0        0        0        0         #-NEW: extra parameters for each pattern by fleet, females

## ———————————————————————————————————————————————————————————————————————————————————— ##
## gear  par   sel                                                   start  end         ##
## index index par sex  ival  lb    ub     prior   p1   p2     phz   period period      ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
   # Gear-1
   1      1    1   1    125.0000    5    190    0       1    999    4     1975   2018  #4
   1      2    2   1      8.0      0.1   20    0       1    999    4     1975   2018  #4
 # Gear-1
#  1      1    1   1      67.5       0   200    0       1    999   -999     1975   2018  #4
#  1      2    2   1      87.5       0   200    0       1    999   -999     1975   2018  #4
#  1      3    3   1      97.5       0   200    0       1    999   -999     1975   2018  #4
#  1      4    4   1     112.5       0   200    0       1    999   -999     1975   2018  #4
#  1      5    5   1     162.5       0   200    0       1    999   -999     1975   2018  #4
#  1      6    6   1     0.001       0.00001  0.99999    0       1    999    4     1975   2018  #4
#  1      6    7   1     0.1         0.00001  0.99999    0       1    999    4     1975   2018  #4
#  1      6    8   1     0.3         0.00001  0.99999    0       1    999    4    1975   2018  #4
#  1      6    9   1     0.7         0.00001  0.99999    0       1    999    4     1975   2018  #4
#  1      6   10   1     0.99999     0.00001  1.01       0       1    999   -4     1975   2018  #4
  1      3    1   2     84.00      5    150    0       1    999    4     1975   2018
  1      4    2   2      4.0000    0.1   20    0       1    999    4     1975   2018
# Gear-2
   2      5    1   0    165.0        5    190    0       1    999    4     1975   2018
   2      6    2   0     15.0000    0.1   25    0       1    999    4     1975   2018
# Gear-3-
   3      7    1   1    115.0        5    190    0       1    999    4     1975   2018
   3      8    2   1     15.0       0.1   25    0       1    999    4     1975   2018
   3      9    1   2     95.0        5    190    0       1    999    4     1975   2018  # dummy
   3     10    2   2     2.5        0.1   25    0       1    999    4     1975   2018
# Gear-4
   4     11    1   0    115.0        5    190    0       1    999    4     1975   2018  # dummy
   4     12    2   0    9.0         0.1   25    0       1    999    4     1975   2018
# Gear-5
   5     13    1   0     75.0       30   190    0       1    999    5     1975   1981  #5
   5     14    2   0      6.0       1     50    0       1    999    5     1975   1981  #5
   5     15    1   0     75.0       30   190    0       1    999    5     1982   2019  #5
   5     16    2   0      7.0      1     50    0       1    999    5     1982   2019  #5
# Gear-6
   6     17    1   0      80.0       1    180    0       1    999    5     1975   2019  # 5
   6     18    2   0      9.0       1     50    0       1    999    5     1975   2019  # 5
## ———————————————————————————————————————————————————————————————————————————————————— ##
## Retained                                                                             ##
## gear  par   sel                                                   start  end         ##
## index index par sex  ival  lb    ub     prior   p1   p2     phz   period period      ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
# Gear-1
  -1     19    1   1    135    1    999    0       1    999    4     1975   2004
  -1     20    2   1    2.0    1     20    0       1    999    4     1975   2004
  -1     21    1   1    140    1    999    0       1    999    4     2005   2018
  -1     22    2   1    2.5    1     20    0       1    999    4     2005   2018
  -1     23    1   2    591    1    999    0       1    999   -3     1975   2003
  -1     24    1   2    591    1    999    0       1    999   -3     2004   2018
# Gear-2
  -2     25    1   0    595    1    999    0       1    999   -3     1975   2018
# Gear-3
 -3     26    1   0    595    1    999    0       1    999   -3     1975   2018    #Dummy
# Gear-4
  -4     27    1   0    595    1    999    0       1    999   -3     1975   2018
# Gear-5
  -5     28    1   0    590    1    999    0       1    999   -3     1975   2019
# Gear-6
  -6     29    1   0    580    1    999    0       1    999   -3     1975   2019
## ———————————————————————————————————————————————————————————————————————————————————— ##

# Number of asyptotic parameters
1
# Fleet   Sex     Year       ival  lb   ub    phz
       1     1     1975   0.000001   0    1     -3
#      1     1     2006   0.044000   0    1     -3
#      1     1     2007   0.019700   0    1     -3
#      1     1     2008   0.019875   0    1     -3
#      1     1     2009   0.032750   0    1     -3
#      1     1     2010   0.015320   0    1     -3
#      1     1     2011   0.011250   0    1     -3
#      1     1     2012   0.024045   0    1     -3
#      1     1     2013   0.063200   0    1     -3
#      1     1     2014   0.160500   0    1     -3
#      1     1     2015   0.070950   0    1     -3
#      1     1     2016   0.082600   0    1     -3



## ———————————————————————————————————————————————————————————————————————————————————— ##
## PRIORS FOR CATCHABILITY
##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ##
##     and p2 are ignored). ival must be > 0                                            ##
## LEGEND                                                                               ##
##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## ival     lb       ub    phz   prior  p1        p2     Analytic?   LAMBDA Emphasis
#   0.896     0        2     6    1      0.843136  0.03   0           1             1
   0.896     0        2     6    1      0.896     0.03   0           1             1
   1.0       0        5    -6    0      0.001     5.00   0           1             1   # BSFRF
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## ADDITIONAL CV FOR SURVEYS/INDICES                                                    ##
##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ##
##     and p2 are ignored). ival must be > 0                                            ##
## LEGEND                                                                               ##
##     prior type: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma          ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## ival        lb        ub        phz   prior     p1      p2
   0.0001      0.00001   10.0      -4    4         1.0     100   # NMFS
#  0.002      0.00001   10.0       -1    4         1.0     100   # BSFRF
#   0.1235     0.00001   10.0        9    1         0.12353 0.2   # BSFRF
  0.25      0.00001   10.0        9    0         0.001   1.00   # BSFRF
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## PENALTIES FOR AVERAGE FISHING MORTALITY RATE FOR EACH GEAR
## ———————————————————————————————————————————————————————————————————————————————————— ##
## Mean_F   Female Offset STD_PHZ1   STD_PHZ2   PHZ_M   PHZ_F
 # 0.22313         0.0505      0.5      45.50      1       1   # Pot
 # 0.0183156          1.0      0.5      45.50      1       -1   # Trawl
 # 0.011109           1.0      0.5      45.50      1       1   # Tanner (-1 -5)
 # 0.011109           1.0      0.5      45.50      1       -1   # Fixed
 # 0.00               0.0     2.00      20.00     -1      -1   # NMFS trawl survey (0 catch)
 # 0.00               0.0     2.00      20.00     -1      -1   # BSFRF (0)
 # 2.95                                                        # Upper bound value for male directed fishig mortality deviations
   0.22313         0.0505      0.5      45.50      1       1     -12      4    -10   2.95     -10    10  # Pot
   0.0183156          1.0      0.5      45.50      1      -1     -12      4    -10     10     -10    10   # Trawl
   0.011109           1.0      0.5      45.50      1       1     -12      4    -10     10     -10    10   # Tanner (-1 -5)
   0.011109           1.0      0.5      45.50      1      -1     -12      4    -10     10     -10    10   # Fixed
   0.00               0.0     2.00      20.00     -1      -1     -12      4    -10     10     -10    10   # NMFS trawl survey (0 catch)
   0.00               0.0     2.00      20.00     -1      -1     -12      4    -10     10     -10    10   # BSFRF (0)
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## OPTIONS FOR SIZE COMPOSTION DATA                                                     ##
##     One column for each data matrix                                                  ##
## LEGEND                                                                               ##
##     Likelihood: 1 = Multinomial with estimated/fixed sample size                     ##
##                 2 = Robust approximation to multinomial                              ##
##                 3 = logistic normal (NIY)                                            ##
##                 4 = multivariate-t (NIY)                                             ##
##                 5 = Dirichlet                                                        ##
## AUTO TAIL COMPRESSION                                                                ##
##     pmin is the cumulative proportion used in tail compression                       ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
#  Pot         Trawl   Tanner  Fixed   NMFS    BSFRF
   2   2   2   2   2   2   2   2   2   2   2   2  2   # Type of likelihood
   0   0   0   0   0   0   0   0   0   0   0   0  0   # Auto tail compression (pmin)
   1   1   1   1   1   1   1   1   1   1   1   1  1   # Initial value for effective sample size multiplier
  -4  -4  -4  -4  -4  -4  -4  -4  -4  -4  -4  -4 -4   # Phz for estimating effective sample size (if appl.)
   1   2   3   4   4   5   5   6   6   7   7   8  8   # Composition aggregator
  #1   2   3   4   5   6   7   8   9  10  11  12 13   # Composition aggregator
   1   1   1   1   1   1   1   1   1   1   1   1  1   # LAMBDA
   1   1   1   1   1   1   1   1   1   1   1   1  1   # Emphasis AEP
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## TIME VARYING NATURAL MORTALIIY RATES                                                 ##
## LEGEND                                                                               ##
## Type: 0 = constant natural mortality                                                 ##
##       1 = Random walk (deviates constrained by variance in M)                        ##
##       2 = Cubic Spline (deviates constrained by nodes & node-placement)              ##
##       3 = Blocked changes (deviates constrained by variance at specific knots)       ##
##       4 = Time blocks                                                                ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## Type
6
## M is relative (YES=1; NO=0)
1
## Phase of estimation
3
## STDEV in m_dev for Random walk
0.25
## Number of nodes for cubic spline or number of step-changes for option 3
2
2
## Year position of the knots (vector must be equal to the number of nodes)
1980 1985
1980 1985
# number of breakpoints in M by size
0
## Specific initial values for the natural mortality devs (0-no, 1=yes)
1
## ——————————————————————————————————————————————————————————————————————————————————————————— ##
## ival        lb        ub        phz   extra    prior     p1      p2         # parameter     ##
## ——————————————————————————————————————————————————————————————————————————————————————————— ##
 1.5342575       0         2          8      0
 0.000000      -2          2        -99      0
# 0.22           0          2          8      0
 1.780586       0          2          -8      -1
# 9.262792       0          2          -8     -3
 0.000000      -2          2        -99      0
 #0.506          0        1.5          8      0
 #0.000000      -2          2        -99      0
 #0.086          0          2          8      0
 #0.804          0          2          8      0
 #9.262792       0          2          8     -3
 #0.000000      -2          2        -99      0

## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## OTHER CONTROLS
## ———————————————————————————————————————————————————————————————————————————————————— ##
1975       # First rec_dev
2018       # last rec_dev
   2       # Estimated rec_dev phase
   2       # Estimated sex_ratio
 0.5       # initial sex-ratio  
  -3       # Estimated rec_ini phase
   1       # VERBOSE FLAG (0 = off, 1 = on, 2 = objective func; 3 diagnostics)
   3       # Initial conditions (0 = Unfished, 1 = Steady-state fished, 2 = Free parameters, 3 = Free parameters (revised))
   1       # Lambda (proportion of mature male biomass for SPR reference points).
   0       # Stock-Recruit-Relationship (0 = none, 1 = Beverton-Holt)
   10       # Maximum phase (stop the estimation after this phase).
   -1       # Maximum number of function calls

## ———————————————————————————————————————————————————————————————————————————————————— ##
## EMPHASIS FACTORS (CATCH)
## ———————————————————————————————————————————————————————————————————————————————————— ##
#Ret_male Disc_male Disc_female Disc_trawl Disc_Tanner_male Disc_Tanner_female Disc_fixed
        1         1           1          1                1                  1          1
#     500       100         100         50              100                100         50

## ———————————————————————————————————————————————————————————————————————————————————— ##
## EMPHASIS FACTORS (Priors)
## ———————————————————————————————————————————————————————————————————————————————————— ##
# Log_fdevs   meanF       Mdevs  Rec_devs Initial_devs Fst_dif_dev Mean_sex-Ratio
      10000       0        1.0         2            0           0             10             #(10000)

## EOF
9999

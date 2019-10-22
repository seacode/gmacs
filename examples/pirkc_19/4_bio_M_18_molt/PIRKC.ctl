## ================================================= ##																																		
## LEADING PARAMETER CONTROLS                                                           ##																																		
##     Controls for leading parameter vector (theta)                                    ##																																		
## LEGEND                                                                               ##																																		
##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ##"																																		
## ================================================= ##																																		
## ntheta																																		
43																																		
## ================================================= ##																																		
## ival        lb        ub        phz   prior     p1      p2         # parameter       ##																																		
## ================================================= ##																																		
    0.18        0.15    0.2         -4       2    0.18    0.04      # M																																		
   16.5       -10        18         -1       0  -10.0    20.0       # logR0																																		
   12.0       -10        25         1       0   10.0    20.0        # logRini, to estimate if NOT initialized at unfished (n68)"																																		
   12.5       -10        25         1       0   10.0    20.0        # logRbar, to estimate if NOT initialized at unfished      #1"																																		
   32.5        25        75         -4       1   72.5     7.25      # recruitment expected value (males or combined)																																		
0.8	  0.32      1.64        -3       0    0.1     5.0       # recruitment scale (variance component) (males or combined)																																	
    0.9        -10         11     	-4       0  -10.0     0.75      # ln(sigma_R)																																	
    0.75      0.20      1.00      	-2       3    3.0     2.00      #  steepness																																	
    0.01      0.00      1.00      	-3       3    1.01    1.01      # recruitment autocorrelation																																	
 #  -0.63      -10         30          1       0   10.0    20.00        # Deviation for size-class 1 (normalization class)																																		
   0       -10         30          1       0   10.0    20.00        # Deviation for size-class 2																																		
   0       -10         30          1       0   10.0    20.00        # Deviation for size-class 3																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 4																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 5																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 6																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 7																																		
   0     -10         30          1       0   10.0    20.00        # Deviation for size-class 8																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 9																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 10																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 11																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 12																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 13																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 14																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 15																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 16																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 17																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 18																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 19																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 20																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 21																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 22																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 23																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 24																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 25																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 26																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 27																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 28																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 29																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 30																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 31																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 32																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 33																																		
   0      -10         30          1       0   10.0    20.00        # Deviation for size-class 34																																		
   0     -10          30          1       0   10.0    20.00        # Deviation for size-class 35																																		
# Use custom natural mortality (0=no, 1=yes, by"	sex and year)																																	
0																																		
# weight-at-length input	method	(1 = allometry	"[w_l = a*l^b],"	2 = vector by sex)																														
1																																		
# weight parameters (male) A																																		
0.000361																																		
# weight parameter (male) B																																		
3.16																																		
# Proportion mature by sex																																		
0.00E+00	0.00E+00	0.00E+00	0.00E+00	0.00E+00	0.00E+00	0.00E+00	0.00E+00	0.00E+00	0.00E+00	0.00E+00	0.00E+00	0.00E+00	0.00E+00	0.00E+00	0.00E+00	0.5	1	1	1	1	1	1	1	1	1	1	0.9999998	1	1	1	1	1	1	1
# Proportion legal by sex																																		
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	1	1	1	1	1
## ================================================= ##																																		
## ================================================= ##																																		
## GROWTH PARAMETER CONTROLS                                                            ##																																		
##     Two lines for each parameter if split sex, one line if not                       ##"																																		
## ================================================= ##																																		
# Use growth transition matrix option (1=read in growth-increment matrix; 2=read in size-transition; 3=gamma distribution for size-increment; 4=gamma distribution for size after increment)																																		
8																																		
# growth increment model (1=alpha/beta; 2=estimated by size-class;3=pre-specified/emprical)																																		
1																																		
# molt probability function (0=pre-specified; 1=flat;2=declining logistic)																																		
2																																		
# maximum size-class (males then females)																																		
35																																		
# Maximum size-class for recruitment(males then females)																																		
7																																		
## number of size-increment periods																																		
1																																		
## Year(s) size-incremnt period changes (blank if no changes)																																		

## number of molt periods																																		
1																																		
## Year(s) molt period changes (blank if no changes)																																		

## Beta parameters are relative (1=Yes;0=no)																																		
0																																		
## ================================================= ##																																		
## ival       lb        ub        phz   prior     p1      p2          # parameter       ##																																		
## ================================================= ##																																		
5.8	 	-100	100	 	2	0	0	999 # males alpha growth (linear)																										
-0.13	-2		2		2	0	0	999 # males beta growth (linear)																										
1		0.5		3.7	 	-3	0	0	999		# Males (beta)																							
## ================================================= ##																																		
## MOLTING PROBABILITY CONTROLS                                                         ##																																		
##     Two lines for each parameter if split sex, one line if not                       ##"																																		
## ================================================= ##																																		
## ival       lb        ub        phz   prior     p1      p2          # parameter       ##																																		
## ================================================= ##    																																		
## males and combined																																		
   129.77     100.     500.0       -3       0    0.0    999.0         # molt_mu males																																		
   0.093      0.02     2.0         -3       0    0.0    999.0         # molt_cv males																																		
  # 145.0386     100.     500.0       3       0    0.0    999.0       # molt_mu males																																		
  # 0.053036     0.02     2.0       3       0    0.0    999.0         # molt_cv males																																		
## ================================================= ##  																																		
# The custom growth-increment matrix (if available)																																		
#																																		
# custom molt probability matrix (if available)																																		
#																																		
## ================================================= ##																																		
## SELECTIVITY CONTROLS                                                                 ##																																		
##     Selectivity P(capture of all sizes). Each gear must have a selectivity and a     ##																																		
##     retention selectivity. If a uniform prior is selected for a parameter then the   ##																																		
##     lb and ub are used (p1 and p2 are ignored)                                       ##																																		
## LEGEND                                                                               ##																																		
##     sel type: 0 = parametric, 1 = coefficients (NIY), 2 = logistic, 3 = logistic95,  ##"																																		
##               4 = double normal (NIY)                                                ##																																		
##     gear index: use +ve for selectivity, -ve for retention                           ##"																																		
##     sex dep: 0 for sex-independent, 1 for sex-dependent                              ##"																																		
## ================================================= ##																																		
## Gear-1   Gear-2   Gear-3   																																		
## PotFshry TrawlByc NMFS                                                                                  																																		
   1        1        1        # selectivity periods																																		
   0        0        0        # sex specific selectivity																																		
   2        2        2        # male selectivity type																																		
   #2        2        2        # female selectivity type																																		
   0        0        0        # within another gear																																		
## Gear-1   Gear-2   Gear-3   																																		
   1        1        1        # retention periods																																		
   0        0        0        # sex specific retention																																		
   2        6        6        # male   retention type																																		
   #6        6        6        # female retention type																																		
   1        0        0        # male   retention flag (0 = no, 1 = yes)"																																		
   #0        0        0        # female retention flag (0 = no, 1 = yes)"																																		
## ================================================= ##																																		
## gear  par   sel                                                   start  end         ##																																		
## index index par sex  ival  		lb    ub    prior   p1   p2     phz   period period      ##																																
## ================================================= ##																																		
# Gear-1																																		
   1      1    1   1    138.00    5    186    0       1    999   -4     1976   2019  #4																																		
   1      2    2   1      0.1    0.1   20    0       1    999   -4     1976   2019  #4																																		
# Gear-2																																		
   2      3    1   1    150.0000    5    185    0       1    999   -4     1976   2019																																		
   2      4    2   1     10.0000    0.1   20    0       1    999   -4     1976   2019																																		
# Gear-3-																																		
   3      5    1   1    106.3990    5    300    0       1    999    4     1976   2019																																		
   3      6    2   1      14.053    0.1   20    0       1    999    4     1976   2019																																		
## ================================================= ##																																		
## Retained                                                                             ##																																		
## gear  par   sel                                                   start  end         ##																																		
## index index par sex  ival  lb    ub     prior   p1   p2     phz   period period      ##																																		
## ================================================= ##																																		
# Gear-1																																		
  -1     7    1   1    138    1    999    0       1    999    -4     1976   2019																																		
  -1     8    2   1    .1    0.1   20    0       1    999    -4     1976   2019																																		
  # Gear-2																																		
  -2     9    1   1    595    1    999    0       1    999   -3     1976   2019																																		
    # Gear-3																																		
  -3     10    1   1    595    1    999    0       1    999   -3     1976   2019																																		
 ## ================================================= ##																																		
# Number of asyptotic parameters																																		
#1																																		
0																																		
# Fleet   Sex     Year       ival  lb   ub    phz  																																		
#    1     1     1976   0.000001   0    1     -3																																		
## ================================================= ##																																		
## PRIORS FOR CATCHABILITY																																		
##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ##																																		
##     and p2 are ignored). ival must be > 0                                            ##																																		
## LEGEND                                                                               ##																																		
##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ##"																																		
## ================================================= ##																																		
## ival     lb       ub    phz   prior  p1        p2     Analytic?   LAMBDA Emphasis																																		
   0.925     0        2    -6    1      0.925   0.03   0           1             1   # NMFS, 0.896 is the magic number * 0.941 (Jies max selex)"																																		
## ================================================= ##																																		
## ================================================= ##																																		
## ADDITIONAL CV FOR SURVEYS/INDICES                                                    ##																																		
##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ##																																		
##     and p2 are ignored). ival must be > 0                                            ##																																		
## LEGEND                                                                               ##																																		
##     prior type: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma          ##"																																		
## ================================================= ##																																		
## ival        lb        ub        phz   prior     p1      p2																																		
   0.0001      0.00001   10.0      -4    4         1.0     100   # NMFS																																		
## ================================================= ##																																		
## ================================================= ##																																		
## PENALTIES FOR AVERAGE FISHING MORTALITY RATE FOR EACH GEAR																																		
## ================================================= ##																																		
## Mean_F   Female Offset STD_PHZ1   STD_PHZ2   PHZ_M   PHZ_F																																		
   0.22313         0.0505      0.5      45.50      1       1   # Pot																																		
   0.0183156          1.0      0.5      45.50      1      -1   # Trawl																																		
   0.00               0.0     2.00      20.00     -1      -1   # NMFS trawl survey (0 catch)																																		
## ================================================= ##																																		
## ================================================= ##																																		
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
## ================================================= ##																																		
#  NMFS 																																		
    2    # Type of likelihood																																		
    0    # Auto tail compression (pmin)																																		
    1    # Initial value for effective sample size multiplier																																		
   -4    # Phz for estimating effective sample size (if appl.)																																		
    1    # Composition aggregator																																		
    1    # LAMBDA																																		
    1    # Emphasis AEP																																		
## ================================================= ##																																		
## ================================================= ##																																		
## TIME VARYING NATURAL MORTALIIY RATES                                                 ##																																		
## ================================================= ##																																		
## TYPE: 																																		
##      0 = constant natural mortality																																		
##      1 = Random walk (deviates constrained by variance in M)																																		
##      2 = Cubic Spline (deviates constrained by nodes & node-placement)																																		
##      3 = Blocked changes (deviates constrained by variance at specific knots)																																		
##      4 = Time blocks																																		
## ================================================= ##																																		
## Type																																		
0																																		
## Phase of estimation (only use if parameters are default)																																		
3																																		
## STDEV in m_dev for Random walk																																		
10																																		
## Number of nodes for cubic spline or number of step-changes for option 3																																		
2																																		
## Year position of the knots (vector must be equal to the number of nodes)																																		
1998 1999																																		
## Number of Breakpoints in M by size																																		
0																																		
## Size-class of breakpoint																																		
#3																																		
## Specific initial values for the natural mortality devs (0-no, 1=yes)"																																		
1																																		
### ================================================================================================== ##  																																		
## ival        lb        ub        phz   extra    prior     p1      p2         # parameter     ##																																		
## ================================================================================================== ##  																																		
# 1.600000       0          2          3      0                        # Males																																		
# 0.000000      -2          2        -99      0                        # Dummy to retun to base value																																		
# 2.000000       0          4         -1      0                        # Size-specific M                       																																		
## ================================================= ##																																		
## ================================================= ##																																		
## ================================================= ##																																		
## OTHER CONTROLS																																		
## ================================================= ##																																		
1977       # First rec_dev																																		
2019       # last rec_dev																																		
   1       # Estimated rec_dev phase																																		
  -3       # Estimated rec_ini phase																																		
   1       # VERBOSE FLAG (0 = off, 1 = on, 2 = objective func; 3 diagnostics)"																																		
   3       # Initial conditions (0 = Unfished, 1 = Steady-state fished, 2 = Free parameters, 3 = Free parameters (revised))"																																		
   1       # Lambda (proportion of mature male biomass for SPR reference points).																																		
   0       # Stock-Recruit-Relationship (0 = none, 1 = Beverton-Holt)"																																		
   10       # Maximum phase (stop the estimation after this phase).																																		
   -1       # Maximum number of function calls																																		
## ================================================= ##																																		
## EMPHASIS FACTORS (CATCH)																																		
## ================================================= ##																																		
#Ret_male Disc_trawl 																																		
    1         1             																																		
#     500       100         100         50              100                100         50     																																		
## ================================================= ##																																		
## EMPHASIS FACTORS (Priors)																																		
## ================================================= ##																																		
# Log_fdevs   meanF       Mdevs  Rec_devs Initial_devs Fst_dif_dev Mean_sex-Ratio																																		
    10000       0           1         2            0           0             10             #(10000)																																		
## EOF																																		
9999																																		

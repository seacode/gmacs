## ———————————————————————————————————————————————————————————————————————————————————— ##
## LEADING PARAMETER CONTROLS                                                           ##
##     Controls for leading parameter vector (theta)                                    ##
## LEGEND                                                                               ##
##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## ntheta
   9
## ———————————————————————————————————————————————————————————————————————————————————— ##
## ival        lb        ub        phz   prior     p1      p2         # parameter       ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
    0.18        0.01      1         -4       2    0.18    0.04        # M
    7.0       -10        20         -2       1   10.0    30.0         # logR0 
   11.0       -10        20          2       1   10.0    30.0         # logR1, to estimate if NOT initialized at unfished
   10.0       -10        20          1       1   10.0    30.0         # logRbar, to estimate if NOT initialized at unfished
   72.0        55       100         -4       1   72.5     7.25        # recruitment expected value
    0.561       0.1       5         -3       0    0.1     5.0         # recruitment scale (variance component)
   -0.40      -10         0.75      -4       0  -10.0     0.75        # ln(sigma_R)
    0.75        0.20      1.00      -2       3    3.0     2.00        # steepness
    0.01        0.00      1.00      -3       3    1.01    1.01        # recruitment autocorrelation
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## GROWTH PARAMETER CONTROLS                                                            ##
##     Two lines for each parameter if split sex, one line if not                       ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## ival       lb        ub        phz   prior     p1      p2          # parameter       ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
   17.5       1.0      90.0        -3       0    0.0    999.0         # alpha males or combined
   17.5       1.0      90.0        -3       0    0.0    999.0         # alpha
    0.10      0.0       0.9        -3       0    0.0    999.0         # beta males or combined
    0.10      0.0       0.9        -3       0    0.0    999.0         # beta
    0.30      0.0      90.0        -4       0    0.0    999.0         # gscale males or combined
    0.30      0.15     90.0        -4       0    0.0    999.0         # gscale
  140.5       1.0     195.0        -3       0    0.0    999.0         # molt_mu males or combined
  400.0       1.0     999.0        -4       0    0.0    999.0         # molt_mu
    0.071     0.0001    9.0        -4       0    0.0    999.0         # molt_cv males or combined
    0.1       0.0001    9.0        -4       0    0.0    999.0         # molt_cv
## ——————————————————————————————————————————————————————————————————————————————————— ##

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
## Gear-1   Gear-2   Gear-3   Gear-4
   1        1        2        1         # selectivity periods
   1        0        1        1         # sex specific selectivity
   3        3        3        3         # male selectivity type
   3        3        3        3         # female selectivity type
## Gear-1   Gear-2   Gear-3   Gear-4
   1        1        1        1         # retention periods
   1        0        0        0         # sex specific retention
   3        2        2        2         # male   retention type
   2        2        2        2         # female retention type
   1        0        0        0         # male   retention flag (0 = no, 1 = yes)
   0        0        0        0         # female retention flag (0 = no, 1 = yes)
## ———————————————————————————————————————————————————————————————————————————————————— ##
## gear  par   sel                                                   start  end         ##
## index index par sex  ival  lb    ub     prior   p1   p2     phz   period period      ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
# Gear-1
   1      1    1   1    100    5    185    0       1    999    3     1975   2014
   1      2    2   1    120    5    185    0       1    999    3     1975   2014
   1      3    1   2     80   60    150    0       1    999    3     1975   2014
   1      4    2   2     95   60    150    0       1    999    3     1975   2014
# Gear-2
   2      5    1   0    110    5    185    0       1    999    3     1975   2014
   2      6    2   0    150    5    185    0       1    999    3     1975   2014
# Gear-3
   3      7    1   1     74   60    150    0       1    999   -3     1975   1981
   3      8    2   1     95   60    150    0       1    999   -3     1975   1981
   3      9    1   1     95   60    200    0       1    999   -3     1982   2014
   3     10    2   1    140   60    200    0       1    999   -3     1982   2014
   3     11    1   2     90   60    200    0       1    999   -3     1975   1981
   3     12    2   2    160   60    200    0       1    999   -3     1975   1981
   3     13    1   2    100   60    200    0       1    999   -3     1982   2014
   3     14    2   2    170   60    200    0       1    999   -3     1982   2014
# Gear-4
   4     15    1   1     70    1    200    0       1    999    4     1975   2014
   4     16    2   1     90    1    200    0       1    999    4     1975   2014
   4     17    1   2    110    1    200    0       1    999    4     1975   2014
   4     18    2   2    190    1    200    0       1    999    4     1975   2014
## ———————————————————————————————————————————————————————————————————————————————————— ##
## Retained                                                                             ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
# Gear-1
  -1     19    1   1    133    1    999    0       1    999   -4     1975   2014
  -1     20    2   1    137    1    999    0       1    999   -4     1975   2014
  -1     21    1   2    591    1    999    0       1    999   -3     1975   2014
  -1     22    2   2     11    1    999    0       1    999   -3     1975   2014
# Gear-2
  -2     23    1   0    595    1    999    0       1    999   -3     1975   2014
  -2     24    2   0     10    1    999    0       1    999   -3     1975   2014
# Gear-3
  -3     25    1   0    590    1    999    0       1    999   -3     1975   1981
  -3     26    2   0     10    1    999    0       1    999   -3     1982   2014
# Gear-4
  -4     27    1   0    580    1    999    0       1    999   -3     1975   2014
  -4     28    2   0     20    1    999    0       1    999   -3     1975   2014
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## PRIORS FOR CATCHABILITY
##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ##
##     and p2 are ignored). ival must be > 0                                            ##
## LEGEND                                                                               ##
##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## ival    lb       ub    phz   prior   p1       p2    Analytic?   LAMBDA
   0.843136  0        2     -4    1     0.843136 0.03   0           1       # NMFS, 0.896 is the magic number * 0.941 (Jies max selex)
   1.0       0        5      4    0     0.001    5.00   0           1       # BSFRF
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
   0.0001      0.00001   10.0      -4    4         1.0     100   # BSFRF
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## PENALTIES FOR AVERAGE FISHING MORTALITY RATE FOR EACH GEAR
## ———————————————————————————————————————————————————————————————————————————————————— ##
## Mean_F   STD_PHZ1   STD_PHZ2   PHZ
   0.20     0.05       45.50      1   # Pot
   0.05     0.05       45.50      1   # Trawl
   0.00     2.00       20.00     -1   # NMFS trawl survey (0 catch)
   0.00     2.00       20.00     -1   # BSFRF (0)
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
#  0   0   0   0   0   1   1   1   1  1  # Type of likelihood
   1   1   1   1   1   1   1   1   1  1  # Type of likelihood
   0   0   0   0   0   0   0   0   0  0  # Auto tail compression (pmin)
   1   1   1   1   1   1   1   1   1  1  # Initial value for effective sample size multiplier
  -4  -4  -4  -4  -4  -4  -4  -4  -4 -4  # Phz for estimating effective sample size (if appl.)
   1   2   2   3   3   4   4   4   5  5  # Composition aggregator
   1   1   1   1   1   1   1   1   1  1  # LAMBDA
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
   3
## Phase of estimation
   3
## STDEV in m_dev for Random walk
   0.80
## Number of nodes for cubic spline or number of step-changes for option 3
   2
## Year position of the knots (vector must be equal to the number of nodes)
   1980 1985 
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## OTHER CONTROLS
## ———————————————————————————————————————————————————————————————————————————————————— ##
   3       # Estimated rec_dev phase
   0       # VERBOSE FLAG (0 = off, 1 = on, 2 = objective func)
   0       # # Initial conditions (0 = Unfished, 1 = Steady-state fished, 2 = Free parameters)
   1984    # First year for average recruitment for Bspr calculation.
   2014    # Last year for average recruitment for Bspr calculation.
   0.35    # Target SPR ratio for Bmsy proxy.
   1       # Gear index for SPR calculations (i.e., directed fishery).
   1       # Lambda (proportion of mature male biomass for SPR reference points).
   1       # Use empirical molt increment data (0=FALSE, 1=TRUE)
   0       # Stock-Recruit-Relationship (0 = none, 1 = Beverton-Holt)
## EOF
9999

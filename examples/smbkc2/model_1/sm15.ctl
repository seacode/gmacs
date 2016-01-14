# Set up to do Stock Reduction Analysis using Catch data and informative priors.
# Controls for leading parameter vector theta
# LEGEND FOR PRIOR:
#                  0 -> uniform
#                  1 -> normal
#                  2 -> lognormal
#                  3 -> beta
#                  4 -> gamma
# ntheta
  9
# ival        lb        ub        phz   prior     p1      p2         # parameter         #
  0.18      0.01         1        -4       2   0.18    0.02          # M
  9.0       -7         20          2       1    7.1     30.1         # logR0
  8.0       -7         20          1       1    7.0     35.0         # logR1
  8.0       -7         20         -1       1    7.0     35.0         # logRbar
  95.0      30         310        -2       1    72.5    7.25         # Recruitment Expected Value
  0.15       0.1         5        -4       0    0.1     5.0          # Recruitment scale (variance component)
 -0.40       -10      0.75        -4       0  -10.0    0.75          # ln(sigma_R)
  0.75      0.20      1.00        -2       3    3.0    2.00          # steepness
  0.01      0.00      1.00        -3       3    1.01   1.01          # recruitment autocorrelation

## GROWTH PARAM CONTROLS                                                                ##
## nGrwth
##                                                                                      ##
## Two lines for each parameter if split sex, one line if not                           ##
# ival        lb        ub         phz  prior     p1      p2         # parameter         #
  14.1      10.0      30.0         -3       0    0.0   999.0         # alpha males or combined
   0.0001    0.0       0.01        -3       0    0.0   999.0         # beta males or combined
   0.26130   0.01      1.0         -3       0    0.0   999.0         # gscale males or combined
 115.5      65.0     145.0         -4       0    0.0   999.0         # molt_mu males or combined
   0.0621    0.0       1.0         -3       0    0.0   999.0         # molt_cv males or combined

## ———————————————————————————————————————————————————————————————————————————————————— ##
## SELECTIVITY CONTROLS                                                                 ##
##     Each gear must have a selectivity and a retention selectivity. If a uniform      ##
##     prior is selected for a parameter then the lb and ub are used (p1 and p2 are     ##
##     ignored)                                                                         ##
## LEGEND                                                                               ##
##     sel type: 0 = parametric, 1 = coefficients, 2 = logistic, 3 = logistic95,        ##
##               4 = double normal (NIY)                                                ##
##     gear index: use +ve for selectivity, -ve for retention                           ##
##     sex dep: 0 for sex-independent, 1 for sex-dependent                              ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## ivector for number of year periods or nodes                                          ##
## POT       TBycatch FBycatch  NMFS_S   ADFG_pot
## Gear-1    Gear-2   Gear-3    Gear-4   Gear-5
   2         1        1         1        1         # Selectivity periods
   0         0        0         0        0         # sex specific selectivity
   0         3        3         0        0         # male selectivity type
## Gear-1    Gear-2   Gear-3    Gear-4   Gear-5
   1         1        1         1        1         # Retention periods
   0         0        0         0        0         # sex specific retention
   3         2        2         2        2         # male retention type
   1         0        0         0        0         # male retention flag (0 -> no, 1 -> yes)
## gear  par   sel                                             phz    start  end        ##
## index index par sex  ival  lb    ub     prior p1     p2     mirror period period     ##
# Gear-1
   1     1     1   0    0.3     0.01  0.99    0       0      1    4     1978   2008
   1     2     2   0    0.8     0.01  0.99    0       0      1    4     1978   2008
   1     3     3   0    0.8     0.01  0.99    0       0      1    4     1978   2008
   1     1     1   0    0.3     0.1  0.5    0       0      1    4     2009   2015
   1     2     2   0    0.8     0.1  0.99    0       0      1    4     2009   2015
   1     3     3   0    0.8     0.1  0.99    0       0      1    4     2009   2015
# Gear-2
   2     4     1   0    40     10   200    0      10    200    -2     1978   2015
   2     5     2   0    60     10   200    0      10    200    -2     1978   2015
# Gear-3
   3     6     1   0    40     10   200    0      10    200    -3     1978   2015
   3     7     2   0    60     10   200    0      10    200    -3     1978   2015
# Gear-4
   4     8     1   0    0.3     0.1  0.5    0       0      1    4     1978   2015
   4     9     2   0    0.8     0.1  0.99    0       0      1    4     1978   2015
   4     10    3   0    0.8     0.1  0.99    0       0      1    4     1978   2015
# Gear-5
   5     11    1   0    0.3     0.1  0.5    0       0      1    4     1978   2015
   5     12    2   0    0.8     0.1  0.99    0       0      1    4     1978   2015
   5     13    3   0    0.8     0.1  0.99    0       0      1    4     1978   2015
## Retained
# Gear-1
  -1     14    1   0    120   100   200    0      1    900   -1     1978   2015
  -1     15    2   0    123   110   200    0      1    900   -1     1978   2015
# Gear-2
  -2     16    1   0    595    1    700    0      1    900   -3     1978   2015
  -2     17    2   0     10    1    700    0      1    900   -3     1978   2015
# Gear-3
  -3     18    1   0    590    1    700    0      1    900   -3     1978   2015
  -3     19    2   0     10    1    700    0      1    900   -3     1978   2015
# Gear-4
  -4     20    1   0    580    1    700    0      1    900   -3     1978   2015
  -4     21    2   0     20    1    700    0      1    900   -3     1978   2015
# Gear-5
  -5     22    1   0    580    1    700    0      1    900   -3     1978   2015
  -5     23    2   0     20    1    700    0      1    900   -3     1978   2015

## ———————————————————————————————————————————————————————————————————————————————————— ##
## PRIORS FOR CATCHABILITY
## ———————————————————————————————————————————————————————————————————————————————————— ##
##  TYPE: 0 = UNIFORM, 1 = NORMAL (log-space), 2 = time-varying (nyi)
##  LAMBDA: Arbitrary relative weights for each series, 0 = do not fit.
## SURVEYS/INDICES ONLY
## TYPE    Mean_q    SD_q    LAMBDA
   0       0.01      2.0     1      # NMFS
   0       0.01      2.0     1      # ADF&G
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## ADDITIONAL CV FOR SURVEYS/INDICES                                                    ##
##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ##
##     and p2 are ignored). ival must be > 0                                            ##
## LEGEND                                                                               ##
##     prior type: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma          ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## ival        lb        ub        phz   prior     p1      p2
   0.0001      0.0       10.0      -4    0         0.0     100   # NMFS
   0.001       0.0001    10.0       4    0         0.0     100   # ADF&G
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## PENALTIES FOR AVERAGE FISHING MORTALITY RATE FOR EACH GEAR
## ———————————————————————————————————————————————————————————————————————————————————— ##
## Mean_F  STD_PHZ1  STD_PHZ2     PHZ
     0.20      0.05     45.50      1  # Pot
     0.001     0.05     45.50      1  # Trawl
     0.001     0.05     45.50      1  # Fixed
     0.00      2.00     20.00     -1  # NMFS
     0.00      2.00     20.00     -1  # ADF&G
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## OPTIONS FOR SIZE COMPOSTION DATA (COLUMN FOR EACH MATRIX)
## ———————————————————————————————————————————————————————————————————————————————————— ##
## LIKELIHOOD OPTIONS
##   -1) Multinomial with estimated/fixed sample size
##   -2) Robust approximation to multinomial
##   -3) logistic normal (NIY)
##   -4) multivariate-t (NIY)
##   -5) Dirichlet
## AUTOTAIL COMPRESSION
##   pmin is the cumulative proportion used in tail compression.
## ———————————————————————————————————————————————————————————————————————————————————— ##
#  0   0   0  # Type of likelihood
#  1   1   1  # Type of likelihood
#  2   2   2  # Type of likelihood
  5   5   5   # Type of likelihood
  0   0   0   # Auto tail compression (pmin)
  1   1   1   # Initial value for effective sample size multiplier
  4   4   4   # Phz for estimating effective sample size (if appl.)
  1   2   3   # Composition aggregator
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## TIME VARYING NATURAL MORTALIIY RATES                                                 ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## TYPE: 
##      0 = constant natural mortality
##      1 = Random walk (deviates constrained by variance in M)
##      2 = Cubic Spline (deviates constrained by nodes & node-placement)
##      3 = Blocked changes (deviates constrained by variance AT specific knots)
##      4 = Time blocks
## ———————————————————————————————————————————————————————————————————————————————————— ##
  0
## Phase of estimation
  2
## STDEV in m_dev for Random walk
  0.01
## Number of nodes for cubic spline or number of step-changes for option 3
  1
## Year position of the knots (vector must be equal to the number of nodes)
  1978
## ———————————————————————————————————————————————————————————————————————————————————— ##

## OTHER CONTROLS
  2       # Estimated rec_dev phase
  0       # VERBOSE FLAG (0 = off, 1 = on, 2 = objective func)
  0       # INITIALIZE MODEL AT UNFISHED RECRUITS (0=FALSE, 1=TRUE)
  1978    # First year for average recruitment for Bspr calculation.
  2015    # Last year for average recruitment for Bspr calculation.
  0.35    # Target SPR ratio for Bmsy proxy.
  1       # Gear index for SPR calculations (i.e., directed fishery).
  1       # Lambda (proportion of mature male biomass for SPR reference points.)
  1       # Use empirical molt increment data (0=FALSE, 1=TRUE)
  0       # Stock-Recruit-Relationship (0 = none, 1 = Beverton-Holt)
## EOF
9999

# Set up to do Stock Reduction Analysis using Catch data and informative priors.
# —————————————————————————————————————————————————————————————————————————————————————— #
# Controls for leading parameter vector theta   
# LEGEND FOR PRIOR: #                  0 -> uniform #                  1 -> normal #                  2 -> lognormal #                  3 -> beta
#                  4 -> gamma
# —————————————————————————————————————————————————————————————————————————————————————— #
# ntheta
  9
# —————————————————————————————————————————————————————————————————————————————————————— #
# ival        lb        ub        phz   prior     p1      p2         # parameter         #                            
# —————————————————————————————————————————————————————————————————————————————————————— #
  0.18      0.01         1         -4       2   0.18    0.02         # M
  10.0       -10        20          2       1   10.1    30.1         # logR0
  10.0       -10        20         -2       1   10.0    35.0         # logR1      
  10.0       -10        20          1       1   10.0    35.0         # logRbar      
  72.0        55       100         -2       1   72.5    7.25         # Recruitment Expected Value
  0.561      0.1         5         -3       0    0.1     5.0         # Recruitment scale (variance component)
 -0.40       -10      0.75         -4       0  -10.0    0.75         # ln(sigma_R)
  0.75      0.20      1.00         -2       3    3.0    2.00         # steepness
  0.01      0.00      1.00         -3       3    1.01   1.01         # recruitment autocorrelation
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## GROWTH PARAM CONTROLS                                                                ##
## nGrwth
##                                                                                      ##
## Two lines for each parameter if split sex, one line if not                           ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
# ival        lb        ub        phz   prior     p1      p2         # parameter         #                            
# —————————————————————————————————————————————————————————————————————————————————————— #
  17.5      10.0      30.0         -3       0    0.0   999.0         # alpha males or combined
  0.10       0.0       0.5         -3       0    0.0   999.0         # beta males or combined
  0.30       0.01      1.0         -3       0    0.0   999.0         # gscale males or combined
 140.5      65.0     165.0         -4       0    0.0   999.0         # molt_mu males or combined
  0.071      0.0       1.0         -3       0    0.0   999.0         # molt_cv males or combined
# ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## SELECTIVITY CONTROLS                                                                 ##
##    -Each gear must have a selectivity and a retention selectivity                    ##
## LEGEND sel_type:1=coefficients,2=logistic,3=logistic95                               ##
##        Index: use +ve for selectivity, -ve for retention
##        sex dep: 0 for sex-independent, 1 for sex-dependent.
## ———————————————————————————————————————————————————————————————————————————————————— ##
## ivector for number of year blocks or nodes
## POT       TBycatch  NMFS_S   BSFR_S
## Gear-1    Gear-2    Gear-3   Gear-4
   1         1         2        1         # Selectivity periods
   0         0         0        0         # sex specific selectivity
   3         3         3        3         # male selectivity type
## Gear-1    Gear-2    Gear-3   Gear-4
   1         1         1        1         # Retention periods 
   0         0         0        0         # sex specific retention
   3         2         2        2         # male retention type
   1         0         0        0         # male retention flag (0 -> no, 1 -> yes)
## ———————————————————————————————————————————————————————————————————————————————————— ##
## gear  par   sel                                             phz    start  end        ##
## index index par sex  ival  lb    ub     prior p1     p2     mirror period period     ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
# Gear-1
   1     1     1   0    129    1    200    0      1     200   -1     1975   2014
   1     2     2   0    156    1    200    0      1     200   -1     1975   2014
# Gear-2
   2     3     1   0    090    10   200    0      10    200   -2     1975   2014
   2     4     2   0    180    10   200    0      10    200   -2     1975   2014
# Gear-3
   3     5     1   0    136   60    200    0       1    200   -3     1975   1981
   3     6     2   0    182   60    200    0       1    200   -4     1975   1981
   3     7     1   0     95   60    200    0       1    200   -3     1982   2014
   3     8     2   0    140   60    200    0       1    200   -4     1982   2014
# Gear-4
   4     9     1   0     80    1    200    0       1    200    4     1975   2014
   4     10    2   0     90    1    200    0       1    200    4     1975   2014
## ———————————————————————————————————————————————————————————————————————————————————— ##
## Retained
## gear  par   sel                                             phz    start  end        ##
## index index par sex  ival  lb    ub     prior p1     p2     mirror period period     ##
# Gear-1
  -1     11    1   0    133   50    200    0      1    900   -1     1975   2014
  -1     12    2   0    137   50    200    0      1    900   -1     1975   2014
# Gear-2
  -2     15    1   0    595    1    700    0      1    900   -3     1975   2014
  -2     16    2   0     10    1    700    0      1    900   -3     1975   2014
# Gear-3
  -3     17    1   0    590    1    700    0      1    900   -3     1975   1981
  -3     18    2   0     10    1    700    0      1    900   -3     1982   2014
# Gear-4
  -4     19    1   0    580    1    700    0      1    900   -3     1975   2014
  -4     20    2   0     20    1    700    0      1    900   -3     1975   2014
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## PRIORS FOR CATCHABILITY
##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ##
##     and p2 are ignored). ival must be > 0                                            ##
## LEGEND                                                                               ##
##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
##  LAMBDA: Arbitrary relative weights for each series, 0 = do not fit.
## SURVEYS/INDICES ONLY
## ival    lb       ub    phz   prior   p1       p2    Analytic?   LAMBDA
   0.843136  0.001   2      4    1  0.843136     0.01   0           1       # NMFS trawl
   1.0       0.001   5      4    0  0.001         5     0           1       # BSFRF
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## ADDITIONAL CV FOR SURVEYS/INDICES
##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ##
##     and p2 are ignored). ival must be > 0                                            ##
## LEGEND                                                                               ##
##     prior type: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma          ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## ival        lb        ub        phz   prior     p1      p2
   0.001       0.0       10.0      -4    4         1.0     100   # NMFS
   0.001       0.0       10.0      -4    4         1.0     100   # BSFRF
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## PENALTIES FOR AVERAGE FISHING MORTALITY RATE FOR EACH GEAR
## ———————————————————————————————————————————————————————————————————————————————————— ##
## Mean_F  STD_PHZ1  STD_PHZ2     PHZ
     0.20      0.05     45.50      1  # Trap
     0.05      0.05     45.50      1  # Trawl
     0.00      2.00     20.00     -1  # NMFS
     0.00      2.00     20.00     -1  # BSFRF
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## OPTIONS FOR SIZE COMPOSTION DATA (COLUMN FOR EACH MATRIX)
## LIKELIHOOD OPTIONS:
##  • 0 ignore composition data in model fitting.
##  • 1 multinomial with estimated/fixed sample size
##  • 2 robust_multi. Robust approximation to multinomial
##  • 3 logistic normal  (NIY)
##  • 4 multivariate-t   (NIY)
## AUTOTAIL COMPRESSION:
##   - pmin is the cumulative proportion used in tail compression.
## ———————————————————————————————————————————————————————————————————————————————————— ##
# 1   1   1   1   1   1 # Type of likelihood.
 2   2   2   2   2   2 # Type of likelihood.
 0   0   0   0   0   0 # Auto tail compression (pmin)
 1   1   1   1   1   1 # Initial value for effective sample size multiplier
-4  -4  -4  -4  -4  -4 # Phz for estimating effective sample size (if appl.)
 1   2   3   4   4   5 # Composition aggregator
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## TIME VARYING NATURAL MORTALIIY RATES                                                 ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## TYPE:
##      0 = constant natural mortality
##      1 = Random walk (deviates constrained by variance in M)
##      2 = Cubic Spline (deviates constrained by nodes & node-placement)
##      3 = Blocked changes (deviates constrained by variance AT specific knots)
##      5 = Blocked changes (deviates constrained by variance AT specific knots relative to base)
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
## OTHER CONTROLS
## ———————————————————————————————————————————————————————————————————————————————————— ##
   3       # Estimated rec_dev phase
   0       # VERBOSE FLAG (0 = off, 1 = on, 2 = objective func)
   1       # Initial conditions (0 = Unfished, 1 = Steady-state fished, 2 = Free parameters)
   1984    # First year for average recruitment for Bspr calculation.
   2014    # Last year for average recruitment for Bspr calculation.
   0.35    # Target SPR ratio for Bmsy proxy.
   1       # Gear index for SPR calculations (i.e., directed fishery).
   1       # Lambda (proportion of mature male biomass for SPR reference points.)
   1       # Use empirical molt increment data (0=FALSE, 1=TRUE)
   0       # Stock-Recruit-Relationship (0 = none, 1 = Beverton-Holt)
## EOF
9999

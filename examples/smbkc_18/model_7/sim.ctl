# ntheta
  12
# ival        lb        ub        phz   prior     p1      p2         # parameter         #
  0.18      0.01         1        -4       2   0.18    0.02          # M
  14.3      -7.0        30        -2       0    -7       30          # log(R0)
  10.0      -7.0        20        -1       1   -10.0     20          # log(Rini)
  13.39      -7.0        20         1       0    -7       20          # log(Rbar)
  80.0      30.0       310        -2       1    72.5    7.25         # Recruitment size distribution expected value
  0.25       0.1         7        -4       0    0.1     9.0          # Recruitment size scale (variance component)
  0.2      -10.0      0.75        -4       0  -10.0    0.75          # log(sigma_R)
  0.75      0.20      1.00        -2       3    3.0    2.00          # steepness
  0.01      0.00      1.00        -3       3    1.01   1.01          # recruitment autocorrelation
 14.5       5.00     20.00         1       0    5.00  20.00          # logN0 vector of initial numbers at length
 14.0       5.00     20.00         1       0    5.00  20.00          # logN0 vector of initial numbers at length
 13.5       5.00     20.00         1       0    5.00  20.00          # logN0 vector of initial numbers at length
## number of molt periods
1
## Year(s) molt period changes (blank if no changes)

## ———————————————————————————————————————————————————————————————————————————————————— ##
  14.1      10.0      30.0         -3       0    0.0   999.0         # alpha males or combined
   0.0001    0.0       0.01        -3       0    0.0   999.0         # beta males or combined
   0.45      0.01      1.0         -3       0    0.0   999.0         # gscale males or combined
 121.5      65.0     145.0         -4       0    0.0   999.0         # molt_mu males or combined
   0.060     0.0       1.0         -3       0    0.0   999.0         # molt_cv males or combined
## Gear-1    Gear-2   Gear-3    Gear-4   Gear-5
   2         1        1         1        1         # Selectivity periods

   0         0        0         0        0         # sex specific selectivity

   0         3        3         0        0         # male selectivity type
## Gear-1    Gear-2   Gear-3    Gear-4   Gear-5
   1         1        1         1        1         # Retention periods

   0         0        0         0        0         # sex specific retention

   3         2        2         2        2         # male retention type

   1         0        0         0        0         # male retention flag (0 -> no, 1 -> yes)
# Gear-1
   1     1     1   0    0.490680567427 0.001 2.0    0       0      1    -2     1978   2008
   1     2     2   0    0.785300542244 0.001 2.0    0       0      1    -2     1978   2008
   1     3     3   0    1.0            0.001 2.0    0       0      1    -2     1978   2008
   1     1     1   0    0.402423912257 0.001 2.0    0       0      1    -2     2009   2017
   1     2     2   0    0.981647895824 0.001 2.0    0       0      1    -2     2009   2017
   1     3     3   0    1.0            0.001 2.0    0       0      1    -2     2009   2017
   2     7     1   0    40       10.0  200    0      10    200    -3     1978   2017
   2     8     2   0    60       10.0  200    0      10    200    -3     1978   2017
   3     9     1   0    40       10.0  200    0      10    200    -3     1978   2017
   3    10     2   0    60       10.0  200    0      10    200    -3     1978   2017
   4     8     1   0    0.793562338771 0.001 2.0    0       0      1    -2     1978   2017
   4     9     2   0    1.08339465666 0.001 2.0    0       0      1    -2     1978   2017
   4     10    3   0    1.0           0.001 2.0    0       0      1    -2     1978   2017
   5     11    1   0    0.411256448303 0.001 2.0    0       0      1    -2     1978   2017
   5     12    2   0    0.861094630732 0.001 2.0    0       0      1    -2     1978   2017
   5     13    3   0    1.0            0.001 2.0    0       0      1    -2     1978   2017
  -1     14    1   0   120   100   200    0      1    900   -1     1978   2017
  -1     15    2   0   123   110   200    0      1    900   -1     1978   2017
  -2     16    1   0   595    1    700    0      1    900   -3     1978   2017
  -2     17    2   0    10    1    700    0      1    900   -3     1978   2017
  -3     18    1   0   590    1    700    0      1    900   -3     1978   2017
  -3     19    2   0    10    1    700    0      1    900   -3     1978   2017
  -4     20    1   0   580    1    700    0      1    900   -3     1978   2017
  -4     21    2   0    20    1    700    0      1    900   -3     1978   2017
  -5     22    1   0   580    1    700    0      1    900   -3     1978   2017
  -5     23    2   0    20    1    700    0      1    900   -3     1978   2017
## ival    lb       ub    phz   prior   p1       p2    Analytic?   LAMBDA
   1.0     0        2     -1    0       0        9.0   0           1       # NMFS trawl
0.00411135867487 0 5      -1    0       0        9.0   0           1       # ADF&G pot
## ival        lb        ub        phz   prior     p1      p2
   0.0000001      0.00000001   10.0      -4    4         1.0     100   # NMFS
   0.0000001      0.00000001   10.0      -4    4         1.0     100   # ADF&G
## Mean_F  STD_PHZ1  STD_PHZ2     PHZ
   0.2       0.05     50.0       1   # Pot
   0.001     0.05     10.0       1   # Trawl
   0.001     0.05     10.0       1   # Fixed
   0.00      2.00     20.00     -1   # NMFS
   0.00      2.00     20.00     -1   # ADF&G

  2   2   2  # Type of likelihood

  0   0   0   # Auto tail compression (pmin)

  1   1   1   # Initial value for effective sample size multiplier

 -4  -4  -4   # Phz for estimating effective sample size (if appl.)

  1   2   3   # Composition aggregator

  1   1   1   # LAMBDA
## Sex-specific? (0=no, 1=yes)
0
## Type
3
## Phase of estimation
4
## STDEV in m_dev for Random walk
10.0
## Number of nodes for cubic spline or number of step-changes for option 3
2
0 # Females (ignored if single sex...)
## Year position of the knots (vector must be equal to the number of nodes)
1998 1999
## ———————————————————————————————————————————————————————————————————————————————————— ##
  3       # Estimated rec_dev phase
  3       # Estimated rec_ini phase
  0       # VERBOSE FLAG (0 = off, 1 = on, 2 = objective func)
  2       # Initial conditions (0 = Unfished, 1 = Steady-state fished, 2 = Free parameters)
  1978    # First year for average recruitment for Bspr calculation
  2016    # Last year for average recruitment for Bspr calculation
  0.35    # Target SPR ratio for Bmsy proxy
  1       # Gear index for SPR calculations (i.e. directed fishery)
  1       # Lambda (proportion of mature male biomass for SPR reference points)
  1       # Use empirical molt increment data (0 = FALSE, 1 = TRUE)
  0       # Stock-Recruit-Relationship (0 = None, 1 = Beverton-Holt)
## EOF
9999

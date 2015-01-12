# Model 1, fixed multinomial sample sizes
# —————————————————————————————————————————————————————————————————————————————————————— #
# Controls for leading parameter vector theta   
# LEGEND FOR PRIOR:
#                  0 -> uniform
#                  1 -> normal
#                  2 -> lognormal
#                  3 -> beta
#                  4 -> gamma
# —————————————————————————————————————————————————————————————————————————————————————— #
# ntheta
  7
# —————————————————————————————————————————————————————————————————————————————————————— #
# ival        lb        ub        phz   prior     p1      p2         # parameter         #                            
# —————————————————————————————————————————————————————————————————————————————————————— #
  0.18      0.01         1         -2       2   0.18    0.04         # M
   7.0       -10        20         -1       1    3.0     5.0         # logR0
   7.0       -10        20          2       1    3.0     5.0         # logR1      
   7.0       -10        20          2       1    3.0     5.0         # logRbar      
  72.5        55       100         -4       1   72.5    7.25         # Recruitment Expected Value
  0.40       0.1         5         -3       0    0.1       5         # Recruitment scale (variance component)
 -0.51       -10      0.75         -4       0    -10    0.75         # ln(sigma_R)
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## GROWTH PARAM CONTROLS                                                                ##
# nGrwth
##                                                                                      ##
## Two lines for each parameter if split sex, one line if not                           ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
# ival        lb        ub        phz   prior     p1      p2         # parameter         #                            
# —————————————————————————————————————————————————————————————————————————————————————— #
  17.5      10.0      30.0         -3       0    0.0    20.0         # alpha males or combined
  17.5      10.0      30.0         -3       0    0.0    20.0         # alpha
  0.10       0.0       0.5         -3       0    0.0    10.0         # beta males or combined
  0.10       0.0       0.5         -3       0    0.0    10.0         # beta
  16.0      05.0      30.0         -3       0    0.0     3.0         # gscale males or combined
   6.0      05.0      30.0         -3       0    0.0     3.0         # gscale
  115.      65.0     165.0          2       0    0.0     3.0         # molt_mu males or combined
  159.      65.0     165.0         -2       0    0.0     3.0         # molt_mu
   0.2       0.0       1.0          3       0    0.0     3.0         # molt_cv males or combined
   0.01      0.0       1.0         -3       0    0.0     3.0         # molt_cv
# ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## SELECTIVITY CONTROLS                                                                 ##
##    -Each gear must have a selectivity and a retention selectivity                    ##
## LEGEND sel_type:1=coefficients,2=logistic,3=logistic95                               ##
##        Index: use +ve for selectivity, -ve for retention
## ———————————————————————————————————————————————————————————————————————————————————— ##
## ivector for number of year blocks or nodes                                           ##
## Gear-1    Gear-2    Gear-3   Gear-4    
   1         1         2        1         #Selectivity blocks
   1         1         1        1         #Retention blocks 
   1         0         0        0         #male   retention flag (0 -> no, 1 -> yes)
   0         0         0        0         #female retention flag (0 -> no, 1 -> yes)
## ———————————————————————————————————————————————————————————————————————————————————— ##
##        sel   sel  sel sex  size   year  phz                       start  end         ##
## Index  type  mu   sd  dep  nodes  nodes mirror lam1  lam2  lam3 | block  block       ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## Selectivity P(capture of all sizes)
   1      2    180   10  0    1      1     2      12.5  12.5  12.5   1975   2013
   2      2     90   10  0    1      1     2      12.5  12.5  12.5   1975   2013 
   3      2     80   10  1    1      1     2      12.5  12.5  12.5   1975   1981
   3      2     80   10  1    1      1     2      12.5  12.5  12.5   1982   2013
   4      2     80   10  0    1      1    -2      12.5  12.5  12.5   1975   2013
## ———————————————————————————————————————————————————————————————————————————————————— ##
## Retained
  -1      2    135    2  0    1      1    -2      12.5  12.5  12.5   1975   2013
  -2      2     95   10  0    1      1    -2      12.5  12.5  12.5   1975   2013
  -3      2     90   10  0    1      1    -2      12.5  12.5  12.5   1975   2013
  -4      2     90   10  0    1      1    -2      12.5  12.5  12.5   1975   2013
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## PRIORS FOR CATCHABILITY
##  TYPE: 0 = UNINFORMATIVE, 1 - NORMAL (log-space), 2 = time-varying (nyi)
## ———————————————————————————————————————————————————————————————————————————————————— ##
## SURVEYS/INDICES ONLY
## NMFS  BSFRF
## TYPE     Mean_q    SD_q       
     1      0.896     0.03      
     0      0.00      0.00      
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## PENALTIES FOR AVERAGE FISHING MORTALITY RATE FOR EACH GEAR
## ———————————————————————————————————————————————————————————————————————————————————— ##
## Trap  Trawl NMFS  BSFRF
## Mean_F  STD_PHZ1  STD_PHZ2  PHZ
     0.20      0.10      1.10    1
     0.10      0.10      1.10    1
     0.00      2.00      2.00   -1
     0.00      2.00      2.00   -1
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## OPTIONS FOR SIZE COMPOSTION DATA (COLUMN FOR EACH MATRIX)
## LIKELIHOOD OPTIONS:
##   -1) multinomial with estimated/fixed sample size
##   -2) robust_multi. Robust approximation to multinomial
##   -3) logistic normal  (NIY)
##   -4) multivariate-t   (NIY)
## AUTOTAIL COMPRESSION:
##   - pmin is the cumulative proportion used in tail compression.
## ———————————————————————————————————————————————————————————————————————————————————— ##
 2   2   2   2   2   2   2   2   2   # Type of likelihood.
 0   0   0   0   0   0   0   0   0   # Auto tail compression (pmin)
-4  -4  -4  -4  -4  -4  -4  -4  -4   # Phz for estimating effective sample size (if appl.)
## ———————————————————————————————————————————————————————————————————————————————————— ##

## ———————————————————————————————————————————————————————————————————————————————————— ##
## TIME VARYING NATURAL MORTALIIY RATES                                                 ##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## TYPE: 
##      0 = constant natural mortality
##      1 = Random walk (deviates constrained by variance in M)
##      2 = Cubic Spline (deviates constrained by nodes & node-placement)
##      3 = Blocked changes (deviates constrained by variance AT specific knots)
  3
## Phase of estimation
  3
## STDEV in m_dev for Random walk
  0.60
## Number of nodes for cubic spline or number of step-changes for option 3
  2
## Year position of the knots (vector must be equal to the number of nodes)
   1980 1985 



## ———————————————————————————————————————————————————————————————————————————————————— ##
## OTHER CONTROLS
## ———————————————————————————————————————————————————————————————————————————————————— ##
  3       # Estimated rec_dev phase
  0       # VERBOSE FLAG (0 = off, 1 = on, 2 = objective func)
  0       # INITIALIZE MODEL AT UNFISHED RECRUITS (0=FALSE, 1=TRUE)
  1984    # First year for average recruitment for Bspr calculation.
  2013    # Last year for average recruitment for Bspr calculation.
  0.35    # Target SPR ratio for Bmsy proxy.
  1       # Gear index for SPR calculations (i.e., directed fishery).
  1       # Lambda (proportion of mature male biomass for SPR reference points.)
  1       # Use empirical molt increment data (0=FALSE, 1=TRUE)
## EOF
9999

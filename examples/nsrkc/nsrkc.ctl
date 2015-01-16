#
#  ——————————————————————————————————————————————————————————————————————————————————————  #                                
#  Controls  for  leading  parameter  vector  theta                        
#  LEGEND  FOR  PRIOR:                              
#  0  ->  uniform                              
#  1  ->  normal                              
#  2  ->  lognormal                              
#  3  ->  beta                              
#  4  ->  gamma                              
#  ——————————————————————————————————————————————————————————————————————————————————————  #                                
#  ntheta                                  
7
# —————————————————————————————————————————————————————————————————————————————————————— #
# ival        lb        ub        phz   prior     p1      p2         # parameter         #                            
# —————————————————————————————————————————————————————————————————————————————————————— #
  0.18      0.01         1          5       2   0.18    0.04         # M
   7.0       -10        20         -1       1    3.0     5.0         # logR0
   7.0       -10        20          2       1    3.0     5.0         # logR1      
   7.0       -10        20          2       1    3.0     5.0         # logRbar      
  72.5        65       150          4       1   72.5    7.25         # Recruitment mBeta
  1.50       0.1         5          4       0    0.1       5         # Recruitment m50
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
  0.10       0.0       0.5         -3       0    0.0    10.0         # beta males or combined
   0.75      1.0      30.0         -3       0    0.0     3.0         # gscale males or combined
  115.      65.0     165.0          2       0    0.0     3.0         # molt_mu males or combined
   0.2       0.0       1.0          3       0    0.0     3.0         # molt_cv males or combined
# ———————————————————————————————————————————————————————————————————————————————————— ##
##  ————————————————————————————————————————————————————————————————————————————————————  ##                                
##  SELECTIVITY  CONTROLS  ##                              
##  -Each  gear  must  have  a  selectivity  and  a  retention  selectivity  ##              
##  LEGEND  sel_type:1=coefficients  2=logistic  3=logistic95  ##                          
##  Index:  use  #NAME?  for  selectivity  #NAME?  for  retention                    
##  ————————————————————————————————————————————————————————————————————————————————————  ##                                
##  ivector  for  number  of  year  blocks  or  nodes  ##                  
##  Gear-1  Gear-2  Gear-3  ...                            
  1  1 1 1 1 1   #Selectivity  blocks                        
  0  0 0 0 0 0   #Retention  blocks                        
  1  0 0 0 0 0   #male   retention flag (0 -> no, 1 -> yes)
##  ————————————————————————————————————————————————————————————————————————————————————  ##                                
##  sel  sel  sel  sex  size  year  phz  start  end  ##                
##  Index  type  mu  sd  dep  nodes  nodes  mirror  lam1  lam2  lam3  |  block  block  ##      
##  ————————————————————————————————————————————————————————————————————————————————————  ##                                
##  Selectivity  P(capture  of  all  sizes)                          
  1  2  180  10  0  1  1  2  12.5  12.5  12.5  1976  2014          
  2  2  90  10  0  1  1  2  12.5  12.5  12.5  1976  2014          
  3  2  90  10  0  1  1  2  12.5  12.5  12.5  1976  2014          
  4  2  90  10  0  1  1  2  12.5  12.5  12.5  1976  2014          
  5  2  90  10  0  1  1  2  12.5  12.5  12.5  1976  2014          
  6  2  90  10  0  1  1  2  12.5  12.5  12.5  1976  2014          
##
##
##  Retained                                  
##
 # -1  2  180  10  0  1  1  2  12.5  12.5  12.5  1976  2014          
 # -2  2  90  10  0  1  1  2  12.5  12.5  12.5  1976  2014          
 # -3  2  90  10  0  1  1  2  12.5  12.5  12.5  1976  2014          
 # -4  2  90  10  0  1  1  2  12.5  12.5  12.5  1976  2014          
 # -5  2  90  10  0  1  1  2  12.5  12.5  12.5  1976  2014          
 # -6  2  90  10  0  1  1  2  12.5  12.5  12.5  1976  2014          
##
## ———————————————————————————————————————————————————————————————————————————————————— ##
## PRIORS FOR CATCHABILITY
##  TYPE: 0 = UNINFORMATIVE, 1 - NORMAL (log-space), 2 = time-varying (nyi)
## ———————————————————————————————————————————————————————————————————————————————————— ##
## SURVEYS/INDICES ONLY
## NMFS_Trawl:ADFG:STCPUE                                        
## TYPE     Mean_q    SD_q       
     1      0.896      0.23      
     1      0.896     10.23      
##  ————————————————————————————————————————————————————————————————————————————————————  ##                                

##  ————————————————————————————————————————————————————————————————————————————————————  ##                                
##  PENALTIES  FOR  AVERAGE  FISHING  MORTALITY  RATE  FOR  EACH  GEAR                  
##  ————————————————————————————————————————————————————————————————————————————————————  ##                                
##  Trap  Trawl  NMFS  BSFRF                            
##  Mean_F  STD_PHZ1  STD_PHZ2  PHZ                            
  0.2         0.1       1.1      1                            
  0.1         0.1       1.1      1                            
  0.01        2         2        1                            
  0.01        2         2        1                            
  0.01        2         2       -1                            
  0.01        2         2       -1                            
##  ————————————————————————————————————————————————————————————————————————————————————  ##                                
##  OPTIONS  FOR  SIZE  COMPOSTION  DATA  (COLUMN  FOR  EACH  MATRIX)                  
##  LIKELIHOOD  OPTIONS:                                
##  -1)  multinomial  with  estimated/fixed  sample  size                        
##  -2)  logistic  normal                              
##  -3)  multivariate-t                                
##  AUTOTAIL  COMPRESSION:                                
##  -  pmin  is  the  cumulative  proportion  used  in  tail  compression.                
##  ————————————————————————————————————————————————————————————————————————————————————  ##                                
  1  1  1  1  # 1  1  #1  1  1  #  Type  of  likelihood.          
  0  0  0  0  # 0  0  #0  0  0  #  Auto  tail  compression  (pmin)        
  4  4  4  4  # 4  4  #4  4  4  #  Phz  for  estimating  effective  sample  size  (if  appl.)
##  ————————————————————————————————————————————————————————————————————————————————————  ##                                
##  TIME  VARYING  NATURAL  MORTALIIY  RATES  ##                        
##  ————————————————————————————————————————————————————————————————————————————————————  ##                                
##  TYPE:                                  
##  0  =  constant  natural  mortality                          
##  1  =  Random  walk  (deviates  constrained  by  variance  in  M)                
##  2  =  Cubic  Spline  (deviates  constrined  by  nodes  &  node-placement)                
  0                                  
##  Phase  of  estimation                              
-3                                  
##  STDEV  in  m_dev  for  Random  walk                        
  0.01                                  
##  Number  of  nodes  for  cubic  spline                        
  6                                  
##  Year  position  of  the  knots  (vector  must  be  equal  to  the  number  of  nodes)        
  1976  1982  1985  1991  2002  2014                        
##  ————————————————————————————————————————————————————————————————————————————————————  ##                                
##  OTHER  CONTROLS                                
##  ————————————————————————————————————————————————————————————————————————————————————  ##                                
  3  #  Estimated  rec_dev  phase                          
  0  #  VERBOSE  FLAG  (0  =  off  1  =  on  2  =  objective  func)        
  0  #  INITIALIZE  MODEL  AT  UNFISHED  RECRUITS  (0=FALSE  1=TRUE)                  
  1984  #  First  year  for  average  recruitment  for  Bspr  calculation.                
  2013  #  Last  year  for  average  recruitment  for  Bspr  calculation.                
  0.35  #  Target  SPR  ratio  for  Bmsy  proxy.                    
  1  #  Gear  index  for  SPR  calculations  (i.e.  directed  fishery).                
  1  #  Lambda  (proportion  of  mature  male  biomass  for  SPR  reference  points.)            
  1  #  Lambda  (proportion  of  mature  male  biomass  for  SPR  reference  points.)            
##  EOF                                  
9999                                    

---
title: "Appendix to Gmacs SMBKC Stock Assessment"
output:
  pdf_document:
    highlight: zenburn
    toc: yes
  html_document:
    theme: flatly
    toc: yes
  word_document: default
bibliography: 
---

\newpage\clearpage

## The base model data file:


```
<<<<<<< HEAD
## Warning in file(con, "r"): cannot open file '../../examples/smbkc2/model_1/
## sm15.dat': No such file or directory
```

```
## Error in file(con, "r"): cannot open the connection
```

```
## Error in ts[i]: object of type 'closure' is not subsettable
=======
## #======================================================================================================== 
## # Gmacs Main  Data  File  Version 1.1:  SM15 example 
## # GEAR_INDEX   DESCRIPTION 
## #    1        : Pot fishery retained catch. 
## #    1        : Pot fishery with discarded catch. 
## #    2        : Trawl bycatch 
## #    3        : Fixed bycatch 
## #    4        : Trawl survey 
## #    5        : Pot survey 
##  
## # Fisheries:  1 Pot Fishery,  2 Pot Discard,  3 Trawl by-catch, 3 Fixed by-catch 
## # Surveys:    4 NMFS Trawl Survey, 5 Pot Survey 
## #======================================================================================================== 
##  
## 1978  # Start year 
## 2015  # End year 
## 4     # Number of seasons 
## 5     # Number of distinct data groups (among fishing fleets and surveys) 
## 1     # Number of sexes 
## 1     # Number of shell condition types 
## 1     # Number of maturity types 
## 3     # Number of size-classes in the model 
## 4     # Season recruitment occurs 
## 4     # Season molting and growth occurs 
## 3     # Season to calculate SSB 
## # size_breaks (a vector giving the break points between size intervals with dimension nclass+1) 
## 90  105  120  135 
## # weight-at-length input method (1 = allometry i.e. w_l = a*l^b, 2 = vector by sex) 
## 2 
## # weight-at-length allometry w_l = a*l^b 
## 4.03E-07 
## # b (male, female) 
## 3.141334 
## # Male weight-at-length 
## # 1.65 2.57 4.26 (lbs) 
## # 0.7484274 1.165732 1.932303 (kgs) 
## 0.000748  0.001165732  0.001932303 # (tonnes) 
## # Male mature weight-at-length (weight * proportion  mature) 
## #0 1.166 1.932 
## 0  0.001165732  0.001932303 
## # Proportion mature by sex 
## 0  1  1 
## # Proportion of the total natural mortality to be applied each season (must add to 1) 
## 0  0.440  0.185  0.375 
## # Fishing fleet names (delimited with : no spaces in names) 
## Pot_Fishery:Trawl_Bycatch:Fixed_bycatch 
## # Survey names (delimited with : no spaces in names) 
## NMFS_Trawl:ADFG_Pot 
## # Number  of  catch data  frames 
## 4 
## # Number  of  rows  in  each  data  frame 
## 26  14  24  24 
## ##  CATCH DATA 
## ##  Type of catch: 1 = retained, 2 = discard 
## ##  Units of catch: 1 = biomass, 2 = numbers 
## ##  for SMBKC Units are in number of crab for landed & 1000 kg for discards. 
## ##  Male Retained 
## ##  year  seas  fleet sex obs     cv    type  units mult  effort  discard_mortality 
##     1978  2 1 1 436126  0.03  1 2 1 0 0 
##     1979  2 1 1 52966   0.03  1 2 1 0 0 
##     1980  2 1 1 33162   0.03  1 2 1 0 0 
##     1981  2 1 1 1045619 0.03  1 2 1 0 0 
##     1982  2 1 1 1935886 0.03  1 2 1 0 0 
##     1983  2 1 1 193199  0.03  1 2 1 0 0 
##     1984  2 1 1 841017  0.03  1 2 1 0 0 
##     1985  2 1 1 436021  0.03  1 2 1 0 0 
##     1986  2 1 1 219548  0.03  1 2 1 0 0 
##     1987  2 1 1 227447  0.03  1 2 1 0 0 
##     1988  2 1 1 280401  0.03  1 2 1 0 0 
##     1989  2 1 1 247641  0.03  1 2 1 0 0 
##     1990  2 1 1 391405  0.03  1 2 1 0 0 
##     1991  2 1 1 726519  0.03  1 2 1 0 0 
##     1992  2 1 1 545222  0.03  1 2 1 0 0 
##     1993  2 1 1 630353  0.03  1 2 1 0 0 
##     1994  2 1 1 827015  0.03  1 2 1 0 0 
##     1995  2 1 1 666905  0.03  1 2 1 0 0 
##     1996  2 1 1 660665  0.03  1 2 1 0 0 
##     1997  2 1 1 939822  0.03  1 2 1 0 0 
##     1998  2 1 1 635370  0.03  1 2 1 0 0 
##     2009  2 1 1 103376  0.03  1 2 1 0 0 
##     2010  2 1 1 298669  0.03  1 2 1 0 0 
##     2011  2 1 1 437862  0.03  1 2 1 0 0 
##     2012  2 1 1 379386  0.03  1 2 1 0 0 
##     2014  2 1 1 69109   0.03  1 2 1 0 0 
## ##  Male  discards  Pot fishery 
##   1990  2 1 1  254.979  0.60  2 1 1 0 0.2 
##   1991  2 1 1  531.448  0.60  2 1 1 0 0.2 
##   1992  2 1 1 1050.387  0.60  2 1 1 0 0.2 
##   1993  2 1 1  951.463  0.60  2 1 1 0 0.2 
##   1994  2 1 1 1210.765  0.60  2 1 1 0 0.2 
##   1995  2 1 1  363.112  0.60  2 1 1 0 0.2 
##   1996  2 1 1  528.524  0.60  2 1 1 0 0.2 
##   1997  2 1 1 1382.825  0.60  2 1 1 0 0.2 
##   1998  2 1 1  781.103  0.60  2 1 1 0 0.2 
##   2009  2 1 1  123.371  0.20  2 1 1 0 0.2 
##   2010  2 1 1  304.656  0.20  2 1 1 0 0.2 
##   2011  2 1 1  481.357  0.20  2 1 1 0 0.2 
##   2012  2 1 1  437.336  0.20  2 1 1 0 0.2 
##   2014  2 1 1   45.484  0.20  2 1 1 0 0.2 
## ##  Trawl fishery discards 
##   1991  2 2 1 3.538  0.310 2 1 1 0 0.8 
##   1992  2 2 1 1.996  0.310 2 1 1 0 0.8 
##   1993  2 2 1 1.542  0.310 2 1 1 0 0.8 
##   1994  2 2 1 0.318  0.310 2 1 1 0 0.8 
##   1995  2 2 1 0.635  0.310 2 1 1 0 0.8 
##   1996  2 2 1 0.0001 0.310 2 1 1 0 0.8 
##   1997  2 2 1 0.0001 0.310 2 1 1 0 0.8 
##   1998  2 2 1 0.0001 0.310 2 1 1 0 0.8 
##   1999  2 2 1 0.0001 0.310 2 1 1 0 0.8 
##   2000  2 2 1 0.0001 0.310 2 1 1 0 0.8 
##   2001  2 2 1 0.0001 0.310 2 1 1 0 0.8 
##   2002  2 2 1 0.726  0.310 2 1 1 0 0.8 
##   2003  2 2 1 0.998  0.310 2 1 1 0 0.8 
##   2004  2 2 1 0.091  0.310 2 1 1 0 0.8 
##   2005  2 2 1 0.0001 0.310 2 1 1 0 0.8 
##   2006  2 2 1 2.812  0.310 2 1 1 0 0.8 
##   2007  2 2 1 0.045  0.310 2 1 1 0 0.8 
##   2008  2 2 1 0.272  0.310 2 1 1 0 0.8 
##   2009  2 2 1 0.635  0.310 2 1 1 0 0.8 
##   2010  2 2 1 0.363  0.310 2 1 1 0 0.8 
##   2011  2 2 1 0.181  0.310 2 1 1 0 0.8 
##   2012  2 2 1 0.590  0.310 2 1 1 0 0.8 
##   2013  2 2 1 0.181  0.310 2 1 1 0 0.8 
##   2014  2 2 1 0.0001 0.310 2 1 1 0 0.8 
## ##  Fixed fishery discards 
##   1991  2 3 1 0.045    0.310 2 1 1 0 0.5 
##   1992  2 3 1 2.268    0.310 2 1 1 0 0.5 
##   1993  2 3 1 0.0001   0.310 2 1 1 0 0.5 
##   1994  2 3 1 0.091    0.310 2 1 1 0 0.5 
##   1995  2 3 1 0.136    0.310 2 1 1 0 0.5 
##   1996  2 3 1 0.045    0.310 2 1 1 0 0.5 
##   1997  2 3 1 0.181    0.310 2 1 1 0 0.5 
##   1998  2 3 1 0.907    0.310 2 1 1 0 0.5 
##   1999  2 3 1 1.361    0.310 2 1 1 0 0.5 
##   2000  2 3 1 0.0001   0.310 2 1 1 0 0.5 
##   2001  2 3 1 0.862    0.310 2 1 1 0 0.5 
##   2002  2 3 1 0.408    0.310 2 1 1 0 0.5 
##   2003  2 3 1 1.134    0.310 2 1 1 0 0.5 
##   2004  2 3 1 0.635    0.310 2 1 1 0 0.5 
##   2005  2 3 1 0.590    0.310 2 1 1 0 0.5 
##   2006  2 3 1 1.451    0.310 2 1 1 0 0.5 
##   2007  2 3 1 69.717   0.310 2 1 1 0 0.5 
##   2008  2 3 1 6.622    0.310 2 1 1 0 0.5 
##   2009  2 3 1 7.530    0.310 2 1 1 0 0.5 
##   2010  2 3 1 9.571    0.310 2 1 1 0 0.5 
##   2011  2 3 1 0.590    0.310 2 1 1 0 0.5 
##   2012  2 3 1 0.0001   0.310 2 1 1 0 0.5 
##   2013  2 3 1 0.272    0.310 2 1 1 0 0.5 
##   2014  2 3 1 0.136    0.310 2 1 1 0 0.5 
## ##  RELATIVE  ABUNDANCE DATA 
## ##  Units of abundance: 1 = biomass, 2 = numbers 
## ##  for SMBKC Units are in  crabs for Abundance. 
## ##  Number  of  relative  abundance indicies 
## 2 
## ##  Number  of  rows  in  each  index 
## 38  8 
## # Survey data (abundance indices, units are mt for trawl survey and crab/potlift for pot survey) 
## # Year, Seas, Fleet,  Sex,  Abundance,  CV     units 
##   1978  1     4       1     6832.824  0.394  1 
##   1979  1     4       1     7989.887  0.463  1 
##   1980  1     4       1     9986.838  0.507  1 
##   1981  1     4       1     6551.137  0.402  1 
##   1982  1     4       1    16221.946  0.344  1 
##   1983  1     4       1     9634.257  0.298  1 
##   1984  1     4       1     4071.221  0.179  1 
##   1985  1     4       1     3110.544  0.210  1 
##   1986  1     4       1     1416.851  0.388  1 
##   1987  1     4       1     2278.918  0.291  1 
##   1988  1     4       1     3158.172  0.252  1 
##   1989  1     4       1     6338.627  0.271  1 
##   1990  1     4       1     6730.136  0.274  1 
##   1991  1     4       1     6948.190  0.248  1 
##   1992  1     4       1     7093.277  0.201  1 
##   1993  1     4       1     9548.466  0.169  1 
##   1994  1     4       1     6539.139  0.176  1 
##   1995  1     4       1     5703.596  0.178  1 
##   1996  1     4       1     9410.411  0.241  1 
##   1997  1     4       1    10924.116  0.337  1 
##   1998  1     4       1     7976.846  0.355  1 
##   1999  1     4       1     1594.548  0.182  1 
##   2000  1     4       1     2096.797  0.310  1 
##   2001  1     4       1     2831.442  0.245  1 
##   2002  1     4       1     1732.601  0.320  1 
##   2003  1     4       1     1566.677  0.336  1 
##   2004  1     4       1     1523.870  0.305  1 
##   2005  1     4       1     1642.018  0.371  1 
##   2006  1     4       1     3893.879  0.334  1 
##   2007  1     4       1     6470.779  0.385  1 
##   2008  1     4       1     4654.477  0.284  1 
##   2009  1     4       1     6301.475  0.256  1 
##   2010  1     4       1    11130.907  0.466  1 
##   2011  1     4       1    10931.241  0.558  1 
##   2012  1     4       1     6200.224  0.339  1 
##   2013  1     4       1     2287.559  0.217  1 
##   2014  1     4       1     6029.225  0.449  1 
##   2015  1     4       1     5877.438  0.770  1 
##   1995  1     5       1     12.042     0.13  2 
##   1998  1     5       1     12.531     0.06  2 
##   2001  1     5       1     8.477      0.08  2 
##   2004  1     5       1     1.667      0.15  2 
##   2007  1     5       1     8.643      0.09  2 
##   2010  1     5       1     10.209     0.13  2 
##   2013  1     5       1     5.643      0.19  2 
##   2015  1     5       1     2.805      0.18  2 
## ##  Number  of  length  frequency matrices 
## 3 
## ##  Number  of  rows  in  each  matrix 
## 14  38  8 
## ##  Number  of  bins  in  each  matrix  (columns  of  size  data) 
## 3  3  3 
## ##  SIZE  COMPOSITION DATA  FOR ALL FLEETS 
## ##  SIZE  COMP  LEGEND 
## ##  Sex:  1 = male, 2 = female, 0 = both  sexes combined 
## ##  Type  of  composition:  1 = retained, 2 = discard,  0 = total composition 
## ##  Maturity  state:  1 = immature, 2 = mature, 0 = both  states  combined 
## ##  Shell condition:  1 = new shell,  2 = old shell,  0 = both  shell types combined 
## ##length  proportions of  pot discarded males 
## ##Year, Seas, Fleet,  Sex,  Type, Shell,  Maturity, Nsamp,  DataVec 
##   1990  2 1 1 0 0 0 15  0.1133  0.3933  0.4933 
##   1991  2 1 1 0 0 0 25  0.1329  0.1768  0.6902 
##   1992  2 1 1 0 0 0 25  0.1905  0.2677  0.5417 
##   1993  2 1 1 0 0 0 25  0.2807  0.2097  0.5096 
##   1994  2 1 1 0 0 0 25  0.2942  0.2714  0.4344 
##   1995  2 1 1 0 0 0 25  0.1478  0.2127  0.6395 
##   1996  2 1 1 0 0 0 25  0.1595  0.2229  0.6176 
##   1997  2 1 1 0 0 0 25  0.1818  0.2053  0.6128 
##   1998  2 1 1 0 0 0 25  0.1927  0.2162  0.5911 
##   2009  2 1 1 0 0 0 50  0.1413  0.3235  0.5352 
##   2010  2 1 1 0 0 0 50  0.1314  0.3152  0.5534 
##   2011  2 1 1 0 0 0 50  0.1314  0.3051  0.5636 
##   2012  2 1 1 0 0 0 50  0.1417  0.3178  0.5406 
##   2014  2 1 1 0 0 0 50  0.0939  0.2275  0.6786 
## ##length  proportions of  trawl survey  males 
## ##Year, Seas, Fleet,  Sex,  Type, Shell,  Maturity, Nsamp,  DataVec 
##   1978  1 4 1 0 0 0 50   0.3865  0.3478  0.2657 
##   1979  1 4 1 0 0 0 50   0.4281  0.3190  0.2529 
##   1980  1 4 1 0 0 0 50   0.3588  0.3220  0.3192 
##   1981  1 4 1 0 0 0 50   0.1219  0.3065  0.5716 
##   1982  1 4 1 0 0 0 50   0.1671  0.2435  0.5893 
##   1983  1 4 1 0 0 0 50   0.1752  0.2726  0.5522 
##   1984  1 4 1 0 0 0 50   0.1823  0.2085  0.6092 
##   1985  1 4 1 0 0 0 46.5 0.2023  0.2010  0.5967 
##   1986  1 4 1 0 0 0 23   0.1984  0.4364  0.3652 
##   1987  1 4 1 0 0 0 35.5 0.1944  0.3779  0.4277 
##   1988  1 4 1 0 0 0 40.5 0.1879  0.3737  0.4384 
##   1989  1 4 1 0 0 0 50   0.4246  0.2259  0.3496 
##   1990  1 4 1 0 0 0 50   0.2380  0.2332  0.5288 
##   1991  1 4 1 0 0 0 50   0.2274  0.3300  0.4426 
##   1992  1 4 1 0 0 0 50   0.2263  0.2911  0.4826 
##   1993  1 4 1 0 0 0 50   0.2296  0.2759  0.4945 
##   1994  1 4 1 0 0 0 50   0.1989  0.2926  0.5085 
##   1995  1 4 1 0 0 0 50   0.2593  0.3005  0.4403 
##   1996  1 4 1 0 0 0 50   0.1998  0.3054  0.4948 
##   1997  1 4 1 0 0 0 50   0.1622  0.3102  0.5275 
##   1998  1 4 1 0 0 0 50   0.1276  0.3212  0.5511 
##   1999  1 4 1 0 0 0 26   0.2224  0.2214  0.5562 
##   2000  1 4 1 0 0 0 30.5 0.2154  0.2180  0.5665 
##   2001  1 4 1 0 0 0 45.5 0.2253  0.2699  0.5048 
##   2002  1 4 1 0 0 0 19   0.1127  0.2346  0.6527 
##   2003  1 4 1 0 0 0 32.5 0.3762  0.2345  0.3893 
##   2004  1 4 1 0 0 0 24   0.2488  0.1848  0.5663 
##   2005  1 4 1 0 0 0 21   0.2825  0.2744  0.4431 
##   2006  1 4 1 0 0 0 50   0.3276  0.2293  0.4431 
##   2007  1 4 1 0 0 0 50   0.4394  0.3525  0.2081 
##   2008  1 4 1 0 0 0 50   0.3745  0.2219  0.4036 
##   2009  1 4 1 0 0 0 50   0.3057  0.4202  0.2741 
##   2010  1 4 1 0 0 0 50   0.4081  0.3371  0.2548 
##   2011  1 4 1 0 0 0 50   0.2179  0.3940  0.3881 
##   2012  1 4 1 0 0 0 50   0.1573  0.4393  0.4034 
##   2013  1 4 1 0 0 0 37   0.2100  0.2834  0.5065 
##   2014  1 4 1 0 0 0 50   0.1738  0.3912  0.4350 
##   2015  1 4 1 0 0 0 50   0.2340  0.2994  0.4666 
##   ##length  proportions of  pot survey 
##   ##Year, Seas, Fleet,  Sex,  Type, Shell,  Maturity, Nsamp,  DataVec 
##   1995  1 5 1 0 0 0 100 0.1594  0.2656  0.5751 
##   1998  1 5 1 0 0 0 100  0.0769  0.2205  0.7026 
##   2001  1 5 1 0 0 0 100  0.1493  0.2049  0.6457 
##   2004  1 5 1 0 0 0 100  0.0672  0.2484  0.6845 
##   2007  1 5 1 0 0 0 100  0.1257  0.3148  0.5595 
##   2010  1 5 1 0 0 0 100  0.1299  0.3209  0.5492 
##   2013  1 5 1 0 0 0 100  0.1556  0.2477  0.5967 
##   2015  1 5 1 0 0 0 100  0.0706  0.2431  0.6859 
## ##  Growth data (increment) 
## # nobs_growth 
## 3 
## # MidPoint Sex Increment CV 
##  97.5  1  14.1  0.2197 
## 112.5  1  14.1  0.2197 
## 127.5  1  14.1  0.2197 
## #  97.5   1 13.8 0.2197 
## #  112.5  1 14.1 0.2197 
## #  127.5  1 14.4 0.2197 
## ##  eof 
## 9999
>>>>>>> develop
```

## The base model control file:


```
## # Set up to do Stock Reduction Analysis using Catch data and informative priors. 
## # Controls for leading parameter vector theta 
## # LEGEND FOR PRIOR: 
## #                  0 -> uniform 
## #                  1 -> normal 
## #                  2 -> lognormal 
## #                  3 -> beta 
## #                  4 -> gamma 
## # ntheta 
##   12 
## # ival        lb        ub        phz   prior     p1      p2         # parameter         # 
##   0.18      0.01         1        -4       2   0.18    0.02          # M 
<<<<<<< HEAD
##   14.3      -7.0        30        -2       0    -7       30          # log(R0) 
##   10.0      -7.0        20        -1       1   -10.0     20.0        # log(Rini) 
##   13.7222   -7.0        20         1       0    -7       30          # log(Rbar) 
##   80.0      30.0       310        -2       1    72.5    7.25         # Recruitment size distribution expected value 
##   0.25       0.1         7        -4       0    0.1     9.0          # Recruitment size scale (variance component) 
##   0.2      -10.0      0.75        -4       0  -10.0    0.75          # log(sigma_R) 
##   0.75      0.20      1.00        -2       3    3.0    2.00          # steepness 
##   0.01      0.00      1.00        -3       3    1.01   1.01          # recruitment autocorrelation 
##  14.5       5.00     18.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
##  14.0       5.00     18.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
##  13.5       5.00     18.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
=======
##   14.3      -7.0        30         2       0    -7       30          # logR0 
##   10.0      -7.0        20        -1       1   -10.0     20.0        # logRini 
##   10.0      -7.0        20         1       0    -7       30          # logRbar 
##   80.0      30.0       310        -2       1    72.5    7.25         # Recruitment size distribution expected value 
##   0.25       0.1         7        -4       0    0.1     9.0          # Recruitment size scale (variance component) 
##  -0.40     -10.0      0.75        -4       0  -10.0    0.75          # ln(sigma_R) 
##   0.75      0.20      1.00        -2       3    3.0    2.00          # steepness 
##   0.01      0.00      1.00        -3       3    1.01   1.01          # recruitment autocorrelation 
##  14.0       5.00     15.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
##  14.0       5.00     15.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
##  14.0       5.00     15.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
>>>>>>> develop
## ## GROWTH PARAM CONTROLS                                                                ## 
## ## Two lines for each parameter if split sex, one line if not                           ## 
## # ival        lb        ub         phz  prior     p1      p2         # parameter         # 
##   14.1      10.0      30.0         -3       0    0.0   999.0         # alpha males or combined 
##    0.0001    0.0       0.01        -3       0    0.0   999.0         # beta males or combined 
##    0.45      0.01      1.0         -3       0    0.0   999.0         # gscale males or combined 
##  121.5      65.0     145.0         -4       0    0.0   999.0         # molt_mu males or combined 
##    0.060     0.0       1.0         -3       0    0.0   999.0         # molt_cv males or combined 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## SELECTIVITY CONTROLS                                                                 ## 
## ##     Each gear must have a selectivity and a retention selectivity. If a uniform      ## 
## ##     prior is selected for a parameter then the lb and ub are used (p1 and p2 are     ## 
## ##     ignored)                                                                         ## 
## ## LEGEND                                                                               ## 
## ##     sel type: 0 = parametric, 1 = coefficients, 2 = logistic, 3 = logistic95,        ## 
## ##               4 = double normal (NIY)                                                ## 
## ##     gear index: use +ve for selectivity, -ve for retention                           ## 
## ##     sex dep: 0 for sex-independent, 1 for sex-dependent                              ## 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## ivector for number of year periods or nodes                                          ## 
## ## POT       TBycatch FBycatch  NMFS_S   ADFG_pot 
## ## Gear-1    Gear-2   Gear-3    Gear-4   Gear-5 
##    2         1        1         1        1         # Selectivity periods 
##    0         0        0         0        0         # sex specific selectivity 
##    0         3        3         0        0         # male selectivity type 
## ## Gear-1    Gear-2   Gear-3    Gear-4   Gear-5 
##    1         1        1         1        1         # Retention periods 
##    0         0        0         0        0         # sex specific retention 
##    3         2        2         2        2         # male retention type 
##    1         0        0         0        0         # male retention flag (0 -> no, 1 -> yes) 
## ## gear  par   sel                                             phz    start  end        ## 
## ## index index par sex  ival  lb    ub     prior p1     p2     mirror period period     ## 
## # Gear-1 
<<<<<<< HEAD
##    1     1     1   0    0.416198 0.001 2.0    0       0      1    -2     1978   2008 
##    1     2     2   0    0.657528 0.001 2.0    0       0      1    -2     1978   2008 
##    1     3     3   0    1.0      0.001 2.0    0       0      1    -2     1978   2008 
##    1     1     1   0    0.326889 0.001 2.0    0       0      1    -2     2009   2015 
##    1     2     2   0    0.806548 0.001 2.0    0       0      1    -2     2009   2015 
##    1     3     3   0    1.0      0.001 2.0    0       0      1    -2     2009   2015 
## # Gear-2 
##    2     7     1   0    40       10.0  200    0      10    200    -3     1978   2015 
##    2     8     2   0    60       10.0  200    0      10    200    -3     1978   2015 
=======
##    1     1     1   0    0.416198 0.001 2.0    0       0      1    -4     1978   2008 
##    1     2     2   0    0.657528 0.001 2.0    0       0      1    -4     1978   2008 
##    1     3     3   0    1.0      0.001 1.0    0       0      1    -4     1978   2008 
##    1     1     1   0    0.326889 0.001 2.0    0       0      1    -4     2009   2015 
##    1     2     2   0    0.806548 0.001 2.0    0       0      1    -4     2009   2015 
##    1     3     3   0    1.0      0.001 1.0    0       0      1    -4     2009   2015 
## # Gear-2 
##    2     7     1   0    40       10.0  200    0      10    200    -2     1978   2015 
##    2     8     2   0    60       10.0  200    0      10    200    -2     1978   2015 
>>>>>>> develop
## # Gear-3 
##    3     9     1   0    40       10.0  200    0      10    200    -3     1978   2015 
##    3    10     2   0    60       10.0  200    0      10    200    -3     1978   2015 
## # Gear-4 
<<<<<<< HEAD
##    4     8     1   0    0.655565 0.001 2.0    0       0      1    -2     1978   2015 
##    4     9     2   0    0.912882 0.001 2.0    0       0      1    -2     1978   2015 
##    4     10    3   0    1.0      0.001 2.0    0       0      1    -2     1978   2015 
## # Gear-5 
##    5     11    1   0    0.347014 0.001 2.0    0       0      1    -2     1978   2015 
##    5     12    2   0    0.720493 0.001 2.0    0       0      1    -2     1978   2015 
##    5     13    3   0    1.0      0.001 2.0    0       0      1    -2     1978   2015 
=======
##    4     8     1   0    0.655565 0.001 2.0    0       0      1    -4     1978   2015 
##    4     9     2   0    0.912882 0.001 2.0    0       0      1    -4     1978   2015 
##    4     10    3   0    1.0      0.001 1.0    0       0      1    -4     1978   2015 
## # Gear-5 
##    5     11    1   0    0.347014 0.001 2.0    0       0      1    -4     1978   2015 
##    5     12    2   0    0.720493 0.001 2.0    0       0      1    -4     1978   2015 
##    5     13    3   0    1.0      0.001 1.0    0       0      1    -4     1978   2015 
>>>>>>> develop
## ## Retained 
## # Gear-1 
##   -1     14    1   0   120   100   200    0      1    900   -1     1978   2015 
##   -1     15    2   0   123   110   200    0      1    900   -1     1978   2015 
## # Gear-2 
##   -2     16    1   0   595    1    700    0      1    900   -3     1978   2015 
##   -2     17    2   0    10    1    700    0      1    900   -3     1978   2015 
## # Gear-3 
##   -3     18    1   0   590    1    700    0      1    900   -3     1978   2015 
##   -3     19    2   0    10    1    700    0      1    900   -3     1978   2015 
## # Gear-4 
##   -4     20    1   0   580    1    700    0      1    900   -3     1978   2015 
##   -4     21    2   0    20    1    700    0      1    900   -3     1978   2015 
## # Gear-5 
##   -5     22    1   0   580    1    700    0      1    900   -3     1978   2015 
##   -5     23    2   0    20    1    700    0      1    900   -3     1978   2015 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## PRIORS FOR CATCHABILITY 
## ##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ## 
## ##     and p2 are ignored). ival must be > 0                                            ## 
## ## LEGEND                                                                               ## 
## ##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ## 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ##  LAMBDA: Arbitrary relative weights for each series, 0 = do not fit. 
## ## SURVEYS/INDICES ONLY 
## ## ival    lb       ub    phz   prior   p1       p2    Analytic?   LAMBDA 
<<<<<<< HEAD
##    1.0     0        2     -1    0       0        9.0   0           1       # NMFS trawl 
## 3.98688533089e-06 0 5      1    0       0        9.0   0           1       # ADF&G pot 
=======
##    1.0     0        2     -4    0       0        9.0   0           1       # NMFS trawl 
##    3.98689 0        5      4    0       0        9.0   0           1       # ADF&G pot 
>>>>>>> develop
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## ADDITIONAL CV FOR SURVEYS/INDICES                                                    ## 
## ##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ## 
## ##     and p2 are ignored). ival must be > 0                                            ## 
## ## LEGEND                                                                               ## 
## ##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ## 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## ival        lb        ub        phz   prior     p1      p2 
<<<<<<< HEAD
##    0.00001      0.000001   10.0      -4    4         1.0     100   # NMFS 
##    0.00001      0.000001   10.0      -4    4         1.0     100   # ADF&G 
=======
##    0.0001      0.00001   10.0      -4    4         1.0     100   # NMFS 
##    0.0001      0.00001   10.0      -4    4         1.0     100   # ADF&G 
>>>>>>> develop
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## PENALTIES FOR AVERAGE FISHING MORTALITY RATE FOR EACH GEAR 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## Mean_F  STD_PHZ1  STD_PHZ2     PHZ 
<<<<<<< HEAD
##    0.3       0.05     50.0       1   # Pot 
##    0.001     0.05     50.0       1   # Trawl 
##    0.001     0.05     50.0       1   # Fixed 
=======
##    0.3       0.05     45.50      1   # Pot 
##    0.001     0.05     4.050      1   # Trawl 
##    0.001     0.05     4.020      1   # Fixed 
>>>>>>> develop
##    0.00      2.00     20.00     -1   # NMFS 
##    0.00      2.00     20.00     -1   # ADF&G 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ——————————————————————————————————————————————————————————————————————————————————— ## 
## ## OPTIONS FOR SIZE COMPOSTION DATA (COLUMN FOR EACH MATRIX) 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## LIKELIHOOD OPTIONS 
## ##   -1) Multinomial with estimated/fixed sample size 
## ##   -2) Robust approximation to multinomial 
## ##   -3) logistic normal (NIY) 
## ##   -4) multivariate-t (NIY) 
## ##   -5) Dirichlet 
## ## AUTOTAIL COMPRESSION 
## ##   pmin is the cumulative proportion used in tail compression. 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
<<<<<<< HEAD
=======
## #  0   0   0  # Type of likelihood 
>>>>>>> develop
## #  1   1   1  # Type of likelihood 
##   2   2   2  # Type of likelihood 
## #  5   5   5   # Type of likelihood 
##   0   0   0   # Auto tail compression (pmin) 
##   1   1   1   # Initial value for effective sample size multiplier 
##  -4  -4  -4   # Phz for estimating effective sample size (if appl.) 
##   1   2   3   # Composition aggregator 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## TIME VARYING NATURAL MORTALIIY RATES                                                 ## 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## TYPE:  
## ##      0 = constant natural mortality 
## ##      1 = Random walk (deviates constrained by variance in M) 
## ##      2 = Cubic Spline (deviates constrained by nodes & node-placement) 
## ##      3 = Blocked changes (deviates constrained by variance at specific knots) 
## ##      4 = Time blocks 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
<<<<<<< HEAD
## ## Type 
## 3 
## ## Phase of estimation 
## 4 
## ## STDEV in m_dev for Random walk 
## 10.0 
## ## Number of nodes for cubic spline or number of step-changes for option 3 
## 2 
## ## Year position of the knots (vector must be equal to the number of nodes) 
## 1998 1999 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## OTHER CONTROLS 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##   3       # Estimated rec_dev phase 
=======
##   3 
## ## Phase of estimation 
##   2 
## ## STDEV in m_dev for Random walk 
## #  0.55 
##   10.0 
## ## Number of nodes for cubic spline or number of step-changes for option 3 
##   2 
## ## Year position of the knots (vector must be equal to the number of nodes) 
##   1998 1999 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## OTHER CONTROLS 
##   2       # Estimated rec_dev phase 
>>>>>>> develop
##   0       # VERBOSE FLAG (0 = off, 1 = on, 2 = objective func) 
##   2       # Initial conditions (0 = Unfished, 1 = Steady-state fished, 2 = Free parameters) 
##   1978    # First year for average recruitment for Bspr calculation 
##   2015    # Last year for average recruitment for Bspr calculation 
##   0.35    # Target SPR ratio for Bmsy proxy 
##   1       # Gear index for SPR calculations (i.e. directed fishery) 
##   1       # Lambda (proportion of mature male biomass for SPR reference points) 
##   1       # Use empirical molt increment data (0 = FALSE, 1 = TRUE) 
##   0       # Stock-Recruit-Relationship (0 = None, 1 = Beverton-Holt) 
## ## EOF 
## 9999
```

\newpage\clearpage

## The selex model control file:


```
## # Set up to do Stock Reduction Analysis using Catch data and informative priors. 
## # Controls for leading parameter vector theta 
## # LEGEND FOR PRIOR: 
## #                  0 -> uniform 
## #                  1 -> normal 
## #                  2 -> lognormal 
## #                  3 -> beta 
## #                  4 -> gamma 
## # ntheta 
##   12 
## # ival        lb        ub        phz   prior     p1      p2         # parameter         # 
##   0.18      0.01         1        -4       2   0.18    0.02          # M 
<<<<<<< HEAD
##   14.3      -7.0        30        -2       0    -7       30          # log(R0) 
##   10.0      -7.0        20        -1       1   -10.0     20.0        # log(Rini) 
##   13.7222   -7.0        20         1       0    -7       30          # log(Rbar) 
##   80.0      30.0       310        -2       1    72.5    7.25         # Recruitment size distribution expected value 
##   0.25       0.1         7        -4       0    0.1     9.0          # Recruitment size scale (variance component) 
##   0.2      -10.0      0.75        -4       0  -10.0    0.75          # log(sigma_R) 
##   0.75      0.20      1.00        -2       3    3.0    2.00          # steepness 
##   0.01      0.00      1.00        -3       3    1.01   1.01          # recruitment autocorrelation 
##  14.5       5.00     18.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
##  14.0       5.00     18.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
##  13.5       5.00     18.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
=======
##   14.3      -7.0        30         2       0    -7       30          # logR0 
##   10.0      -7.0        20        -1       1   -10.0     20.0        # logRini 
##   10.0      -7.0        20         1       0    -7       30          # logRbar 
##   80.0      30.0       310        -2       1    72.5    7.25         # Recruitment size distribution expected value 
##   0.25       0.1         7        -4       0    0.1     9.0          # Recruitment size scale (variance component) 
##  -0.40     -10.0      0.75        -4       0  -10.0    0.75          # ln(sigma_R) 
##   0.75      0.20      1.00        -2       3    3.0    2.00          # steepness 
##   0.01      0.00      1.00        -3       3    1.01   1.01          # recruitment autocorrelation 
##  14.0       5.00     15.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
##  14.0       5.00     15.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
##  14.0       5.00     15.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
>>>>>>> develop
## ## GROWTH PARAM CONTROLS                                                                ## 
## ## Two lines for each parameter if split sex, one line if not                           ## 
## # ival        lb        ub         phz  prior     p1      p2         # parameter         # 
##   14.1      10.0      30.0         -3       0    0.0   999.0         # alpha males or combined 
##    0.0001    0.0       0.01        -3       0    0.0   999.0         # beta males or combined 
##    0.45      0.01      1.0         -3       0    0.0   999.0         # gscale males or combined 
##  121.5      65.0     145.0         -4       0    0.0   999.0         # molt_mu males or combined 
##    0.060     0.0       1.0         -3       0    0.0   999.0         # molt_cv males or combined 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## SELECTIVITY CONTROLS                                                                 ## 
## ##     Each gear must have a selectivity and a retention selectivity. If a uniform      ## 
## ##     prior is selected for a parameter then the lb and ub are used (p1 and p2 are     ## 
## ##     ignored)                                                                         ## 
## ## LEGEND                                                                               ## 
## ##     sel type: 0 = parametric, 1 = coefficients, 2 = logistic, 3 = logistic95,        ## 
## ##               4 = double normal (NIY)                                                ## 
## ##     gear index: use +ve for selectivity, -ve for retention                           ## 
## ##     sex dep: 0 for sex-independent, 1 for sex-dependent                              ## 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## ivector for number of year periods or nodes                                          ## 
## ## POT       TBycatch FBycatch  NMFS_S   ADFG_pot 
## ## Gear-1    Gear-2   Gear-3    Gear-4   Gear-5 
##    2         1        1         1        1         # Selectivity periods 
##    0         0        0         0        0         # sex specific selectivity 
##    0         3        3         0        0         # male selectivity type 
## ## Gear-1    Gear-2   Gear-3    Gear-4   Gear-5 
##    1         1        1         1        1         # Retention periods 
##    0         0        0         0        0         # sex specific retention 
##    3         2        2         2        2         # male retention type 
##    1         0        0         0        0         # male retention flag (0 -> no, 1 -> yes) 
## ## gear  par   sel                                             phz    start  end        ## 
## ## index index par sex  ival  lb    ub     prior p1     p2     mirror period period     ## 
## # Gear-1 
<<<<<<< HEAD
##    1     1     1   0    0.416198 0.001 2.0    0       0      1     2     1978   2008 
##    1     2     2   0    0.657528 0.001 2.0    0       0      1     2     1978   2008 
##    1     3     3   0    1.0      0.001 2.0    0       0      1    -2     1978   2008 
##    1     1     1   0    0.326889 0.001 2.0    0       0      1     2     2009   2015 
##    1     2     2   0    0.806548 0.001 2.0    0       0      1     2     2009   2015 
##    1     3     3   0    1.0      0.001 2.0    0       0      1    -2     2009   2015 
## # Gear-2 
##    2     7     1   0    40       10.0  200    0      10    200    -3     1978   2015 
##    2     8     2   0    60       10.0  200    0      10    200    -3     1978   2015 
=======
##    1     1     1   0    0.416198 0.001 2.0    0       0      1     4     1978   2008 
##    1     2     2   0    0.657528 0.001 2.0    0       0      1     4     1978   2008 
##    1     3     3   0    1.0      0.001 1.0    0       0      1    -4     1978   2008 
##    1     1     1   0    0.326889 0.001 2.0    0       0      1     4     2009   2015 
##    1     2     2   0    0.806548 0.001 2.0    0       0      1     4     2009   2015 
##    1     3     3   0    1.0      0.001 1.0    0       0      1    -4     2009   2015 
## # Gear-2 
##    2     7     1   0    40       10.0  200    0      10    200    -2     1978   2015 
##    2     8     2   0    60       10.0  200    0      10    200    -2     1978   2015 
>>>>>>> develop
## # Gear-3 
##    3     9     1   0    40       10.0  200    0      10    200    -3     1978   2015 
##    3    10     2   0    60       10.0  200    0      10    200    -3     1978   2015 
## # Gear-4 
<<<<<<< HEAD
##    4     8     1   0    0.655565 0.001 2.0    0       0      1     2     1978   2015 
##    4     9     2   0    0.912882 0.001 2.0    0       0      1     2     1978   2015 
##    4     10    3   0    1.0      0.001 2.0    0       0      1    -2     1978   2015 
## # Gear-5 
##    5     11    1   0    0.347014 0.001 2.0    0       0      1     2     1978   2015 
##    5     12    2   0    0.720493 0.001 2.0    0       0      1     2     1978   2015 
##    5     13    3   0    1.0      0.001 2.0    0       0      1    -2     1978   2015 
=======
##    4     8     1   0    0.655565 0.001 2.0    0       0      1     4     1978   2015 
##    4     9     2   0    0.912882 0.001 2.0    0       0      1     4     1978   2015 
##    4     10    3   0    1.0      0.001 1.0    0       0      1    -4     1978   2015 
## # Gear-5 
##    5     11    1   0    0.347014 0.001 2.0    0       0      1     4     1978   2015 
##    5     12    2   0    0.720493 0.001 2.0    0       0      1     4     1978   2015 
##    5     13    3   0    1.0      0.001 1.0    0       0      1    -4     1978   2015 
>>>>>>> develop
## ## Retained 
## # Gear-1 
##   -1     14    1   0   120   100   200    0      1    900   -1     1978   2015 
##   -1     15    2   0   123   110   200    0      1    900   -1     1978   2015 
## # Gear-2 
##   -2     16    1   0   595    1    700    0      1    900   -3     1978   2015 
##   -2     17    2   0    10    1    700    0      1    900   -3     1978   2015 
## # Gear-3 
##   -3     18    1   0   590    1    700    0      1    900   -3     1978   2015 
##   -3     19    2   0    10    1    700    0      1    900   -3     1978   2015 
## # Gear-4 
##   -4     20    1   0   580    1    700    0      1    900   -3     1978   2015 
##   -4     21    2   0    20    1    700    0      1    900   -3     1978   2015 
## # Gear-5 
##   -5     22    1   0   580    1    700    0      1    900   -3     1978   2015 
##   -5     23    2   0    20    1    700    0      1    900   -3     1978   2015 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## PRIORS FOR CATCHABILITY 
## ##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ## 
## ##     and p2 are ignored). ival must be > 0                                            ## 
## ## LEGEND                                                                               ## 
## ##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ## 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ##  LAMBDA: Arbitrary relative weights for each series, 0 = do not fit. 
## ## SURVEYS/INDICES ONLY 
## ## ival    lb       ub    phz   prior   p1       p2    Analytic?   LAMBDA 
<<<<<<< HEAD
##    1.0     0        2     -1    0       0        9.0   0           1       # NMFS trawl 
## 3.98688533089e-06 0 5      1    0       0        9.0   0           1       # ADF&G pot 
=======
##    1.0     0        2     -4    0       0        9.0   0           1       # NMFS trawl 
##    3.98689 0        5      4    0       0        9.0   0           1       # ADF&G pot 
>>>>>>> develop
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## ADDITIONAL CV FOR SURVEYS/INDICES                                                    ## 
## ##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ## 
## ##     and p2 are ignored). ival must be > 0                                            ## 
## ## LEGEND                                                                               ## 
## ##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ## 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## ival        lb        ub        phz   prior     p1      p2 
<<<<<<< HEAD
##    0.00001      0.000001   10.0      -4    4         1.0     100   # NMFS 
##    0.00001      0.000001   10.0      -4    4         1.0     100   # ADF&G 
=======
##    0.0001      0.00001   10.0      -4    4         1.0     100   # NMFS 
##    0.0001      0.00001   10.0      -4    4         1.0     100   # ADF&G 
>>>>>>> develop
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## PENALTIES FOR AVERAGE FISHING MORTALITY RATE FOR EACH GEAR 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## Mean_F  STD_PHZ1  STD_PHZ2     PHZ 
<<<<<<< HEAD
##    0.3       0.05     50.0       1   # Pot 
##    0.001     0.05     50.0       1   # Trawl 
##    0.001     0.05     50.0       1   # Fixed 
=======
##    0.3       0.05     45.50      1   # Pot 
##    0.001     0.05     4.050      1   # Trawl 
##    0.001     0.05     4.020      1   # Fixed 
>>>>>>> develop
##    0.00      2.00     20.00     -1   # NMFS 
##    0.00      2.00     20.00     -1   # ADF&G 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ——————————————————————————————————————————————————————————————————————————————————— ## 
## ## OPTIONS FOR SIZE COMPOSTION DATA (COLUMN FOR EACH MATRIX) 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## LIKELIHOOD OPTIONS 
## ##   -1) Multinomial with estimated/fixed sample size 
## ##   -2) Robust approximation to multinomial 
## ##   -3) logistic normal (NIY) 
## ##   -4) multivariate-t (NIY) 
## ##   -5) Dirichlet 
## ## AUTOTAIL COMPRESSION 
## ##   pmin is the cumulative proportion used in tail compression. 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
<<<<<<< HEAD
## #  1   1   1  # Type of likelihood 
##  2   2   2  # Type of likelihood 
## #  5   5   5   # Type of likelihood 
##  0   0   0   # Auto tail compression (pmin) 
##  1   1   1   # Initial value for effective sample size multiplier 
## -4  -4  -4   # Phz for estimating effective sample size (if appl.) 
##  1   2   3   # Composition aggregator 
=======
## #  0   0   0  # Type of likelihood 
## #  1   1   1  # Type of likelihood 
##   2   2   2  # Type of likelihood 
## #  5   5   5   # Type of likelihood 
##   0   0   0   # Auto tail compression (pmin) 
##   1   1   1   # Initial value for effective sample size multiplier 
##  -4  -4  -4   # Phz for estimating effective sample size (if appl.) 
##   1   2   3   # Composition aggregator 
>>>>>>> develop
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## TIME VARYING NATURAL MORTALIIY RATES                                                 ## 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## TYPE:  
## ##      0 = constant natural mortality 
## ##      1 = Random walk (deviates constrained by variance in M) 
## ##      2 = Cubic Spline (deviates constrained by nodes & node-placement) 
## ##      3 = Blocked changes (deviates constrained by variance at specific knots) 
## ##      4 = Time blocks 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
<<<<<<< HEAD
## ## Type 
## 3 
## ## Phase of estimation 
## 4 
## ## STDEV in m_dev for Random walk 
## 10.0 
## ## Number of nodes for cubic spline or number of step-changes for option 3 
## 2 
## ## Year position of the knots (vector must be equal to the number of nodes) 
## 1998 1999 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## OTHER CONTROLS 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##   3       # Estimated rec_dev phase 
=======
##   3 
## ## Phase of estimation 
##   2 
## ## STDEV in m_dev for Random walk 
## #  0.55 
##   10.0 
## ## Number of nodes for cubic spline or number of step-changes for option 3 
##   2 
## ## Year position of the knots (vector must be equal to the number of nodes) 
##   1998 1999 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## OTHER CONTROLS 
##   2       # Estimated rec_dev phase 
>>>>>>> develop
##   0       # VERBOSE FLAG (0 = off, 1 = on, 2 = objective func) 
##   2       # Initial conditions (0 = Unfished, 1 = Steady-state fished, 2 = Free parameters) 
##   1978    # First year for average recruitment for Bspr calculation 
##   2015    # Last year for average recruitment for Bspr calculation 
##   0.35    # Target SPR ratio for Bmsy proxy 
##   1       # Gear index for SPR calculations (i.e. directed fishery) 
##   1       # Lambda (proportion of mature male biomass for SPR reference points) 
##   1       # Use empirical molt increment data (0 = FALSE, 1 = TRUE) 
##   0       # Stock-Recruit-Relationship (0 = None, 1 = Beverton-Holt) 
## ## EOF 
## 9999
```

\newpage\clearpage

## The add CV model control file:


```
## # Set up to do Stock Reduction Analysis using Catch data and informative priors. 
## # Controls for leading parameter vector theta 
## # LEGEND FOR PRIOR: 
## #                  0 -> uniform 
## #                  1 -> normal 
## #                  2 -> lognormal 
## #                  3 -> beta 
## #                  4 -> gamma 
## # ntheta 
##   12 
## # ival        lb        ub        phz   prior     p1      p2         # parameter         # 
##   0.18      0.01         1        -4       2   0.18    0.02          # M 
<<<<<<< HEAD
##   14.3      -7.0        30        -2       0    -7       30          # log(R0) 
##   10.0      -7.0        20        -1       1   -10.0     20.0        # log(Rini) 
##   13.7222   -7.0        20         1       0    -7       30          # log(Rbar) 
##   80.0      30.0       310        -2       1    72.5    7.25         # Recruitment size distribution expected value 
##   0.25       0.1         7        -4       0    0.1     9.0          # Recruitment size scale (variance component) 
##   0.2      -10.0      0.75        -4       0  -10.0    0.75          # log(sigma_R) 
##   0.75      0.20      1.00        -2       3    3.0    2.00          # steepness 
##   0.01      0.00      1.00        -3       3    1.01   1.01          # recruitment autocorrelation 
##  14.5       5.00     18.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
##  14.0       5.00     18.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
##  13.5       5.00     18.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
=======
##   14.3      -7.0        30         2       0    -7       30          # logR0 
##   10.0      -7.0        20        -1       1   -10.0     20.0        # logRini 
##   10.0      -7.0        20         1       0    -7       30          # logRbar 
##   80.0      30.0       310        -2       1    72.5    7.25         # Recruitment size distribution expected value 
##   0.25       0.1         7        -4       0    0.1     9.0          # Recruitment size scale (variance component) 
##  -0.40     -10.0      0.75        -4       0  -10.0    0.75          # ln(sigma_R) 
##   0.75      0.20      1.00        -2       3    3.0    2.00          # steepness 
##   0.01      0.00      1.00        -3       3    1.01   1.01          # recruitment autocorrelation 
##  14.0       5.00     15.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
##  14.0       5.00     15.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
##  14.0       5.00     15.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
>>>>>>> develop
## ## GROWTH PARAM CONTROLS                                                                ## 
## ## Two lines for each parameter if split sex, one line if not                           ## 
## # ival        lb        ub         phz  prior     p1      p2         # parameter         # 
##   14.1      10.0      30.0         -3       0    0.0   999.0         # alpha males or combined 
##    0.0001    0.0       0.01        -3       0    0.0   999.0         # beta males or combined 
##    0.45      0.01      1.0         -3       0    0.0   999.0         # gscale males or combined 
##  121.5      65.0     145.0         -4       0    0.0   999.0         # molt_mu males or combined 
##    0.060     0.0       1.0         -3       0    0.0   999.0         # molt_cv males or combined 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## SELECTIVITY CONTROLS                                                                 ## 
## ##     Each gear must have a selectivity and a retention selectivity. If a uniform      ## 
## ##     prior is selected for a parameter then the lb and ub are used (p1 and p2 are     ## 
## ##     ignored)                                                                         ## 
## ## LEGEND                                                                               ## 
## ##     sel type: 0 = parametric, 1 = coefficients, 2 = logistic, 3 = logistic95,        ## 
## ##               4 = double normal (NIY)                                                ## 
## ##     gear index: use +ve for selectivity, -ve for retention                           ## 
## ##     sex dep: 0 for sex-independent, 1 for sex-dependent                              ## 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## ivector for number of year periods or nodes                                          ## 
## ## POT       TBycatch FBycatch  NMFS_S   ADFG_pot 
## ## Gear-1    Gear-2   Gear-3    Gear-4   Gear-5 
##    2         1        1         1        1         # Selectivity periods 
##    0         0        0         0        0         # sex specific selectivity 
##    0         3        3         0        0         # male selectivity type 
## ## Gear-1    Gear-2   Gear-3    Gear-4   Gear-5 
##    1         1        1         1        1         # Retention periods 
##    0         0        0         0        0         # sex specific retention 
##    3         2        2         2        2         # male retention type 
##    1         0        0         0        0         # male retention flag (0 -> no, 1 -> yes) 
## ## gear  par   sel                                             phz    start  end        ## 
## ## index index par sex  ival  lb    ub     prior p1     p2     mirror period period     ## 
## # Gear-1 
<<<<<<< HEAD
##    1     1     1   0    0.416198 0.001 2.0    0       0      1     2     1978   2008 
##    1     2     2   0    0.657528 0.001 1.0    0       0      1     2     1978   2008 
##    1     3     3   0    1.0      0.001 2.0    0       0      1    -2     1978   2008 
##    1     1     1   0    0.326889 0.001 2.0    0       0      1     2     2009   2015 
##    1     2     2   0    0.806548 0.001 1.0    0       0      1     2     2009   2015 
##    1     3     3   0    1.0      0.001 2.0    0       0      1    -2     2009   2015 
## # Gear-2 
##    2     7     1   0    40       10.0  200    0      10    200    -3     1978   2015 
##    2     8     2   0    60       10.0  200    0      10    200    -3     1978   2015 
=======
##    1     1     1   0    0.416198 0.001 2.0    0       0      1     4     1978   2008 
##    1     2     2   0    0.657528 0.001 2.0    0       0      1     4     1978   2008 
##    1     3     3   0    1.0      0.001 1.0    0       0      1    -4     1978   2008 
##    1     1     1   0    0.326889 0.001 2.0    0       0      1     4     2009   2015 
##    1     2     2   0    0.806548 0.001 2.0    0       0      1     4     2009   2015 
##    1     3     3   0    1.0      0.001 1.0    0       0      1    -4     2009   2015 
## # Gear-2 
##    2     7     1   0    40       10.0  200    0      10    200    -2     1978   2015 
##    2     8     2   0    60       10.0  200    0      10    200    -2     1978   2015 
>>>>>>> develop
## # Gear-3 
##    3     9     1   0    40       10.0  200    0      10    200    -3     1978   2015 
##    3    10     2   0    60       10.0  200    0      10    200    -3     1978   2015 
## # Gear-4 
<<<<<<< HEAD
##    4     8     1   0    0.655565 0.001 2.0    0       0      1     2     1978   2015 
##    4     9     2   0    0.912882 0.001 1.0    0       0      1     2     1978   2015 
##    4     10    3   0    1.0      0.001 2.0    0       0      1    -2     1978   2015 
## # Gear-5 
##    5     11    1   0    0.347014 0.001 2.0    0       0      1     2     1978   2015 
##    5     12    2   0    0.720493 0.001 2.0    0       0      1     2     1978   2015 
##    5     13    3   0    1.0      0.001 2.0    0       0      1    -2     1978   2015 
=======
##    4     8     1   0    0.655565 0.001 2.0    0       0      1     4     1978   2015 
##    4     9     2   0    0.912882 0.001 2.0    0       0      1     4     1978   2015 
##    4     10    3   0    1.0      0.001 1.0    0       0      1    -4     1978   2015 
## # Gear-5 
##    5     11    1   0    0.347014 0.001 2.0    0       0      1     4     1978   2015 
##    5     12    2   0    0.720493 0.001 2.0    0       0      1     4     1978   2015 
##    5     13    3   0    1.0      0.001 1.0    0       0      1    -4     1978   2015 
>>>>>>> develop
## ## Retained 
## # Gear-1 
##   -1     14    1   0   120   100   200    0      1    900   -1     1978   2015 
##   -1     15    2   0   123   110   200    0      1    900   -1     1978   2015 
## # Gear-2 
##   -2     16    1   0   595    1    700    0      1    900   -3     1978   2015 
##   -2     17    2   0    10    1    700    0      1    900   -3     1978   2015 
## # Gear-3 
##   -3     18    1   0   590    1    700    0      1    900   -3     1978   2015 
##   -3     19    2   0    10    1    700    0      1    900   -3     1978   2015 
## # Gear-4 
##   -4     20    1   0   580    1    700    0      1    900   -3     1978   2015 
##   -4     21    2   0    20    1    700    0      1    900   -3     1978   2015 
## # Gear-5 
##   -5     22    1   0   580    1    700    0      1    900   -3     1978   2015 
##   -5     23    2   0    20    1    700    0      1    900   -3     1978   2015 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## PRIORS FOR CATCHABILITY 
## ##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ## 
## ##     and p2 are ignored). ival must be > 0                                            ## 
## ## LEGEND                                                                               ## 
## ##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ## 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ##  LAMBDA: Arbitrary relative weights for each series, 0 = do not fit. 
## ## SURVEYS/INDICES ONLY 
## ## ival    lb       ub    phz   prior   p1       p2    Analytic?   LAMBDA 
<<<<<<< HEAD
##    1.0     0        2     -1    0       0        9.0   0           1       # NMFS trawl 
## 3.98688533089e-06 0 5      1    0       0        9.0   0           1       # ADF&G pot 
=======
##    1.0     0        2     -4    0       0        9.0   0           1       # NMFS trawl 
##    3.98689 0        5      4    0       0        9.0   0           1       # ADF&G pot 
>>>>>>> develop
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## ADDITIONAL CV FOR SURVEYS/INDICES                                                    ## 
## ##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ## 
## ##     and p2 are ignored). ival must be > 0                                            ## 
## ## LEGEND                                                                               ## 
## ##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ## 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## ival        lb        ub        phz   prior     p1      p2 
<<<<<<< HEAD
##    0.00001      0.000001   10.0      -4    4         1.0     100   # NMFS 
##    0.00001      0.000001   10.0      -4    4         1.0     100   # ADF&G 
=======
##    0.0001      0.00001   10.0      -4    4         1.0     100   # NMFS 
##    0.0001      0.00001   10.0       4    4         1.0     100   # ADF&G 
>>>>>>> develop
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## PENALTIES FOR AVERAGE FISHING MORTALITY RATE FOR EACH GEAR 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## Mean_F  STD_PHZ1  STD_PHZ2     PHZ 
<<<<<<< HEAD
##    0.3       0.05     50.0       1   # Pot 
##    0.001     0.05     50.0       1   # Trawl 
##    0.001     0.05     50.0       1   # Fixed 
=======
##    0.3       0.05     45.50      1   # Pot 
##    0.001     0.05     4.050      1   # Trawl 
##    0.001     0.05     4.020      1   # Fixed 
>>>>>>> develop
##    0.00      2.00     20.00     -1   # NMFS 
##    0.00      2.00     20.00     -1   # ADF&G 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ——————————————————————————————————————————————————————————————————————————————————— ## 
## ## OPTIONS FOR SIZE COMPOSTION DATA (COLUMN FOR EACH MATRIX) 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## LIKELIHOOD OPTIONS 
## ##   -1) Multinomial with estimated/fixed sample size 
## ##   -2) Robust approximation to multinomial 
## ##   -3) logistic normal (NIY) 
## ##   -4) multivariate-t (NIY) 
## ##   -5) Dirichlet 
## ## AUTOTAIL COMPRESSION 
## ##   pmin is the cumulative proportion used in tail compression. 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
<<<<<<< HEAD
=======
## #  0   0   0  # Type of likelihood 
>>>>>>> develop
## #  1   1   1  # Type of likelihood 
##   2   2   2  # Type of likelihood 
## #  5   5   5   # Type of likelihood 
##   0   0   0   # Auto tail compression (pmin) 
##   1   1   1   # Initial value for effective sample size multiplier 
##  -4  -4  -4   # Phz for estimating effective sample size (if appl.) 
##   1   2   3   # Composition aggregator 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## TIME VARYING NATURAL MORTALIIY RATES                                                 ## 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## TYPE:  
## ##      0 = constant natural mortality 
## ##      1 = Random walk (deviates constrained by variance in M) 
## ##      2 = Cubic Spline (deviates constrained by nodes & node-placement) 
## ##      3 = Blocked changes (deviates constrained by variance at specific knots) 
## ##      4 = Time blocks 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
<<<<<<< HEAD
## ## Type 
## 3 
## ## Phase of estimation 
## 4 
## ## STDEV in m_dev for Random walk 
## 10.0 
## ## Number of nodes for cubic spline or number of step-changes for option 3 
## 2 
## ## Year position of the knots (vector must be equal to the number of nodes) 
## 1998 1999 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## OTHER CONTROLS 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##   3       # Estimated rec_dev phase 
=======
##   3 
## ## Phase of estimation 
##   2 
## ## STDEV in m_dev for Random walk 
## #  0.55 
##   10.0 
## ## Number of nodes for cubic spline or number of step-changes for option 3 
##   2 
## ## Year position of the knots (vector must be equal to the number of nodes) 
##   1998 1999 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## OTHER CONTROLS 
##   2       # Estimated rec_dev phase 
>>>>>>> develop
##   0       # VERBOSE FLAG (0 = off, 1 = on, 2 = objective func) 
##   2       # Initial conditions (0 = Unfished, 1 = Steady-state fished, 2 = Free parameters) 
##   1978    # First year for average recruitment for Bspr calculation 
##   2015    # Last year for average recruitment for Bspr calculation 
##   0.35    # Target SPR ratio for Bmsy proxy 
##   1       # Gear index for SPR calculations (i.e. directed fishery) 
##   1       # Lambda (proportion of mature male biomass for SPR reference points) 
##   1       # Use empirical molt increment data (0 = FALSE, 1 = TRUE) 
##   0       # Stock-Recruit-Relationship (0 = None, 1 = Beverton-Holt) 
## ## EOF 
## 9999
```

\newpage\clearpage

## The no $M_{1998}$ model control file:


```
## # Set up to do Stock Reduction Analysis using Catch data and informative priors. 
## # Controls for leading parameter vector theta 
## # LEGEND FOR PRIOR: 
## #                  0 -> uniform 
## #                  1 -> normal 
## #                  2 -> lognormal 
## #                  3 -> beta 
## #                  4 -> gamma 
## # ntheta 
##   12 
## # ival        lb        ub        phz   prior     p1      p2         # parameter         # 
##   0.18      0.01         1        -4       2   0.18    0.02          # M 
<<<<<<< HEAD
##   14.3      -7.0        30        -2       0    -7       30          # log(R0) 
##   10.0      -7.0        20        -1       1   -10.0     20.0        # log(Rini) 
##   13.7222   -7.0        20         1       0    -7       30          # log(Rbar) 
##   80.0      30.0       310        -2       1    72.5    7.25         # Recruitment size distribution expected value 
##   0.25       0.1         7        -4       0    0.1     9.0          # Recruitment size scale (variance component) 
##   0.2      -10.0      0.75        -4       0  -10.0    0.75          # log(sigma_R) 
##   0.75      0.20      1.00        -2       3    3.0    2.00          # steepness 
##   0.01      0.00      1.00        -3       3    1.01   1.01          # recruitment autocorrelation 
##  14.5       5.00     18.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
##  14.0       5.00     18.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
##  13.5       5.00     18.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
=======
##   14.3      -7.0        30         2       0    -7       30          # logR0 
##   10.0      -7.0        20        -1       1   -10.0     20.0        # logRini 
##   10.0      -7.0        20         1       0    -7       30          # logRbar 
##   80.0      30.0       310        -2       1    72.5    7.25         # Recruitment size distribution expected value 
##   0.25       0.1         7        -4       0    0.1     9.0          # Recruitment size scale (variance component) 
##  -0.40     -10.0      0.75        -4       0  -10.0    0.75          # ln(sigma_R) 
##   0.75      0.20      1.00        -2       3    3.0    2.00          # steepness 
##   0.01      0.00      1.00        -3       3    1.01   1.01          # recruitment autocorrelation 
##  14.0       5.00     15.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
##  14.0       5.00     15.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
##  14.0       5.00     15.00         1       0    5.00  15.00          # logN0 vector of initial numbers at length 
>>>>>>> develop
## ## GROWTH PARAM CONTROLS                                                                ## 
## ## Two lines for each parameter if split sex, one line if not                           ## 
## # ival        lb        ub         phz  prior     p1      p2         # parameter         # 
##   14.1      10.0      30.0         -3       0    0.0   999.0         # alpha males or combined 
##    0.0001    0.0       0.01        -3       0    0.0   999.0         # beta males or combined 
##    0.45      0.01      1.0         -3       0    0.0   999.0         # gscale males or combined 
##  121.5      65.0     145.0         -4       0    0.0   999.0         # molt_mu males or combined 
##    0.060     0.0       1.0         -3       0    0.0   999.0         # molt_cv males or combined 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## SELECTIVITY CONTROLS                                                                 ## 
## ##     Each gear must have a selectivity and a retention selectivity. If a uniform      ## 
## ##     prior is selected for a parameter then the lb and ub are used (p1 and p2 are     ## 
## ##     ignored)                                                                         ## 
## ## LEGEND                                                                               ## 
## ##     sel type: 0 = parametric, 1 = coefficients, 2 = logistic, 3 = logistic95,        ## 
## ##               4 = double normal (NIY)                                                ## 
## ##     gear index: use +ve for selectivity, -ve for retention                           ## 
## ##     sex dep: 0 for sex-independent, 1 for sex-dependent                              ## 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## ivector for number of year periods or nodes                                          ## 
## ## POT       TBycatch FBycatch  NMFS_S   ADFG_pot 
## ## Gear-1    Gear-2   Gear-3    Gear-4   Gear-5 
##    2         1        1         1        1         # Selectivity periods 
##    0         0        0         0        0         # sex specific selectivity 
##    0         3        3         0        0         # male selectivity type 
## ## Gear-1    Gear-2   Gear-3    Gear-4   Gear-5 
##    1         1        1         1        1         # Retention periods 
##    0         0        0         0        0         # sex specific retention 
##    3         2        2         2        2         # male retention type 
##    1         0        0         0        0         # male retention flag (0 -> no, 1 -> yes) 
## ## gear  par   sel                                             phz    start  end        ## 
## ## index index par sex  ival  lb    ub     prior p1     p2     mirror period period     ## 
## # Gear-1 
<<<<<<< HEAD
##    1     1     1   0    0.416198 0.001 2.0    0       0      1     2     1978   2008 
##    1     2     2   0    0.657528 0.001 1.0    0       0      1     2     1978   2008 
##    1     3     3   0    1.0      0.001 2.0    0       0      1    -2     1978   2008 
##    1     1     1   0    0.326889 0.001 2.0    0       0      1     2     2009   2015 
##    1     2     2   0    0.806548 0.001 1.0    0       0      1     2     2009   2015 
##    1     3     3   0    1.0      0.001 2.0    0       0      1    -2     2009   2015 
## # Gear-2 
##    2     7     1   0    40       10.0  200    0      10    200    -3     1978   2015 
##    2     8     2   0    60       10.0  200    0      10    200    -3     1978   2015 
=======
##    1     1     1   0    0.416198 0.001 2.0    0       0      1     4     1978   2008 
##    1     2     2   0    0.657528 0.001 2.0    0       0      1     4     1978   2008 
##    1     3     3   0    1.0      0.001 1.0    0       0      1    -4     1978   2008 
##    1     1     1   0    0.326889 0.001 2.0    0       0      1     4     2009   2015 
##    1     2     2   0    0.806548 0.001 2.0    0       0      1     4     2009   2015 
##    1     3     3   0    1.0      0.001 1.0    0       0      1    -4     2009   2015 
## # Gear-2 
##    2     7     1   0    40       10.0  200    0      10    200    -2     1978   2015 
##    2     8     2   0    60       10.0  200    0      10    200    -2     1978   2015 
>>>>>>> develop
## # Gear-3 
##    3     9     1   0    40       10.0  200    0      10    200    -3     1978   2015 
##    3    10     2   0    60       10.0  200    0      10    200    -3     1978   2015 
## # Gear-4 
<<<<<<< HEAD
##    4     8     1   0    0.655565 0.001 2.0    0       0      1     2     1978   2015 
##    4     9     2   0    0.912882 0.001 1.0    0       0      1     2     1978   2015 
##    4     10    3   0    1.0      0.001 2.0    0       0      1    -2     1978   2015 
## # Gear-5 
##    5     11    1   0    0.347014 0.001 2.0    0       0      1     2     1978   2015 
##    5     12    2   0    0.720493 0.001 1.0    0       0      1     2     1978   2015 
##    5     13    3   0    1.0      0.001 2.0    0       0      1    -2     1978   2015 
=======
##    4     8     1   0    0.655565 0.001 2.0    0       0      1     4     1978   2015 
##    4     9     2   0    0.912882 0.001 2.0    0       0      1     4     1978   2015 
##    4     10    3   0    1.0      0.001 1.0    0       0      1    -4     1978   2015 
## # Gear-5 
##    5     11    1   0    0.347014 0.001 2.0    0       0      1     4     1978   2015 
##    5     12    2   0    0.720493 0.001 2.0    0       0      1     4     1978   2015 
##    5     13    3   0    1.0      0.001 1.0    0       0      1    -4     1978   2015 
>>>>>>> develop
## ## Retained 
## # Gear-1 
##   -1     14    1   0   120   100   200    0      1    900   -1     1978   2015 
##   -1     15    2   0   123   110   200    0      1    900   -1     1978   2015 
## # Gear-2 
##   -2     16    1   0   595    1    700    0      1    900   -3     1978   2015 
##   -2     17    2   0    10    1    700    0      1    900   -3     1978   2015 
## # Gear-3 
##   -3     18    1   0   590    1    700    0      1    900   -3     1978   2015 
##   -3     19    2   0    10    1    700    0      1    900   -3     1978   2015 
## # Gear-4 
##   -4     20    1   0   580    1    700    0      1    900   -3     1978   2015 
##   -4     21    2   0    20    1    700    0      1    900   -3     1978   2015 
## # Gear-5 
##   -5     22    1   0   580    1    700    0      1    900   -3     1978   2015 
##   -5     23    2   0    20    1    700    0      1    900   -3     1978   2015 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## PRIORS FOR CATCHABILITY 
## ##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ## 
## ##     and p2 are ignored). ival must be > 0                                            ## 
## ## LEGEND                                                                               ## 
## ##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ## 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ##  LAMBDA: Arbitrary relative weights for each series, 0 = do not fit. 
## ## SURVEYS/INDICES ONLY 
## ## ival    lb       ub    phz   prior   p1       p2    Analytic?   LAMBDA 
<<<<<<< HEAD
##    1.0     0        2     -1    0       0        9.0   0           1       # NMFS trawl 
## 3.98688533089e-06 0 5      1    0       0        9.0   0           1       # ADF&G pot 
=======
##    1.0     0        2     -4    0       0        9.0   0           1       # NMFS trawl 
##    3.98689 0        5      4    0       0        9.0   0           1       # ADF&G pot 
>>>>>>> develop
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## ADDITIONAL CV FOR SURVEYS/INDICES                                                    ## 
## ##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ## 
## ##     and p2 are ignored). ival must be > 0                                            ## 
## ## LEGEND                                                                               ## 
## ##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ## 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## ival        lb        ub        phz   prior     p1      p2 
<<<<<<< HEAD
##    0.00001      0.000001   10.0       4    4         1.0     100   # NMFS 
##    0.00001      0.000001   10.0       4    4         1.0     100   # ADF&G 
=======
##    0.0001      0.00001   10.0      -4    4         1.0     100   # NMFS 
##    0.0001      0.00001   10.0      -4    4         1.0     100   # ADF&G 
>>>>>>> develop
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## PENALTIES FOR AVERAGE FISHING MORTALITY RATE FOR EACH GEAR 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## Mean_F  STD_PHZ1  STD_PHZ2     PHZ 
<<<<<<< HEAD
##    0.3       0.05     50.0       1   # Pot 
##    0.001     0.05     50.0       1   # Trawl 
##    0.001     0.05     50.0       1   # Fixed 
=======
##    0.3       0.05     45.50      1   # Pot 
##    0.001     0.05     4.050      1   # Trawl 
##    0.001     0.05     4.020      1   # Fixed 
>>>>>>> develop
##    0.00      2.00     20.00     -1   # NMFS 
##    0.00      2.00     20.00     -1   # ADF&G 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ——————————————————————————————————————————————————————————————————————————————————— ## 
## ## OPTIONS FOR SIZE COMPOSTION DATA (COLUMN FOR EACH MATRIX) 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## LIKELIHOOD OPTIONS 
## ##   -1) Multinomial with estimated/fixed sample size 
## ##   -2) Robust approximation to multinomial 
## ##   -3) logistic normal (NIY) 
## ##   -4) multivariate-t (NIY) 
## ##   -5) Dirichlet 
## ## AUTOTAIL COMPRESSION 
## ##   pmin is the cumulative proportion used in tail compression. 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
<<<<<<< HEAD
=======
## #  0   0   0  # Type of likelihood 
>>>>>>> develop
## #  1   1   1  # Type of likelihood 
##   2   2   2  # Type of likelihood 
## #  5   5   5   # Type of likelihood 
##   0   0   0   # Auto tail compression (pmin) 
##   1   1   1   # Initial value for effective sample size multiplier 
##  -4  -4  -4   # Phz for estimating effective sample size (if appl.) 
##   1   2   3   # Composition aggregator 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## TIME VARYING NATURAL MORTALIIY RATES                                                 ## 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## TYPE:  
## ##      0 = constant natural mortality 
## ##      1 = Random walk (deviates constrained by variance in M) 
## ##      2 = Cubic Spline (deviates constrained by nodes & node-placement) 
## ##      3 = Blocked changes (deviates constrained by variance at specific knots) 
## ##      4 = Time blocks 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
<<<<<<< HEAD
## ## Type 
## 3 
## ## Phase of estimation 
## 4 
## ## STDEV in m_dev for Random walk 
## 10.0 
## ## Number of nodes for cubic spline or number of step-changes for option 3 
## 2 
## ## Year position of the knots (vector must be equal to the number of nodes) 
## 1998 1999 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## OTHER CONTROLS 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##   3       # Estimated rec_dev phase 
=======
##   0 
## ## Phase of estimation 
##   2 
## ## STDEV in m_dev for Random walk 
## #  0.55 
##   10.0 
## ## Number of nodes for cubic spline or number of step-changes for option 3 
##   2 
## ## Year position of the knots (vector must be equal to the number of nodes) 
##   1998 1999 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## OTHER CONTROLS 
##   2       # Estimated rec_dev phase 
>>>>>>> develop
##   0       # VERBOSE FLAG (0 = off, 1 = on, 2 = objective func) 
##   2       # Initial conditions (0 = Unfished, 1 = Steady-state fished, 2 = Free parameters) 
##   1978    # First year for average recruitment for Bspr calculation 
##   2015    # Last year for average recruitment for Bspr calculation 
##   0.35    # Target SPR ratio for Bmsy proxy 
##   1       # Gear index for SPR calculations (i.e. directed fishery) 
##   1       # Lambda (proportion of mature male biomass for SPR reference points) 
##   1       # Use empirical molt increment data (0 = FALSE, 1 = TRUE) 
##   0       # Stock-Recruit-Relationship (0 = None, 1 = Beverton-Holt) 
## ## EOF 
## 9999
```

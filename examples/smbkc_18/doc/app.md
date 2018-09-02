---
title: "Appendix B: SMBKC Stock Assessment Input Files"
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
\pagenumbering{gobble}

##The data file used for the reference model (16.0) control file:

\fontsize{8}{10}


```
#======================================================================================================== 
# Gmacs Main  Data  File  Version 1.1:  SM18 with all new data 
# GEAR_INDEX   DESCRIPTION 
#    1        : Pot fishery retained catch. 
#    1        : Pot fishery with discarded catch. 
#    2        : Trawl bycatch 
#    3        : Fixed bycatch 
#    4        : Trawl survey 
#    5        : Pot survey 
 
# Fisheries:  1 Pot Fishery,  2 Pot Discard,  3 Trawl by-catch, 3 Fixed by-catch 
# Surveys:    4 NMFS Trawl Survey, 5 Pot Survey 
#======================================================================================================== 
1978  # Start year 
2018  # End year 
2019  # Projection year 
5     # Number of seasons 
5     # Number of distinct data groups (among fishing fleets and surveys) 
1     # Number of sexes 
1     # Number of shell condition types 
1     # Number of maturity types 
3     # Number of size-classes in the model 
5     # Season recruitment occurs 
5     # Season molting and growth occurs 
4     # Season to calculate SSB 
1     # Season for N output 
# size_breaks (a vector giving the break points between size intervals with dimension nclass+1) 
90  105  120  135 
# weight-at-length input method (1 = allometry i.e. w_l = a*l^b, 2 = vector by sex, 3 = matrix by sex) 
3 
# weight-at-length allometry w_l = a*l^b 
4.03E-07 
# b (male, female) 
3.141334 
# Male weight-at-length 
0.000748427     0.001165731     0.001930510 
0.000748427     0.001165731     0.001688886 
0.000748427     0.001165731     0.001922246 
0.000748427     0.001165731     0.001877957 
0.000748427     0.001165731     0.001938634 
0.000748427     0.001165731     0.002076413 
0.000748427     0.001165731     0.001899330 
0.000748427     0.001165731     0.002116687 
0.000748427     0.001165731     0.001938784 
0.000748427     0.001165731     0.001939764 
0.000748427     0.001165731     0.001871067 
0.000748427     0.001165731     0.001998295 
0.000748427     0.001165731     0.001870418 
0.000748427     0.001165731     0.001969415 
0.000748427     0.001165731     0.001926859 
0.000748427     0.001165731     0.002021492 
0.000748427     0.001165731     0.001931318 
0.000748427     0.001165731     0.002014407 
0.000748427     0.001165731     0.001977471 
0.000748427     0.001165731     0.002099246 
0.000748427     0.001165731     0.001982478 
0.000748427     0.001165731     0.001930932 
0.000748427     0.001165731     0.001930932 
0.000748427     0.001165731     0.001930932 
0.000748427     0.001165731     0.001930932 
0.000748427     0.001165731     0.001930932 
0.000748427     0.001165731     0.001930932 
0.000748427     0.001165731     0.001930932 
0.000748427     0.001165731     0.001930932 
0.000748427     0.001165731     0.001930932 
0.000748427     0.001165731     0.001930932 
0.000748427     0.001165731     0.001891628 
0.000748427     0.001165731     0.001795721 
0.000748427     0.001165731     0.001823113 
0.000748427     0.001165731     0.001807433 
0.000748427     0.001165731     0.001930932 
0.000748427     0.001165731     0.001894627 
0.000748427     0.001165731     0.001850611 
0.000748427     0.001165731     0.001930932 
0.000748427     0.001165731     0.001930932 
0.000748427     0.001165731     0.001930932 
# Male mature weight-at-length (weight * proportion  mature) 
0 0.001165732 0.001945911 
# Proportion mature by sex 
0 1 1 
# Natural mortality per season input type (1 = vector by season, 2 = matrix by season/year) 
2 
# Proportion of the total natural mortality to be applied each season (each row must add to 1) 
#0  0.0025  0  0.6245  0.373 
   0.0000   0.0700   0.0000   0.5600   0.3700 
   0.0000   0.0600   0.0000   0.5700   0.3700 
   0.0000   0.0700   0.0000   0.5600   0.3700 
   0.0000   0.0500   0.0000   0.5800   0.3700 
   0.0000   0.0700   0.0000   0.5600   0.3700 
   0.0000   0.1200   0.0000   0.5100   0.3700 
   0.0000   0.1000   0.0000   0.5300   0.3700 
   0.0000   0.1400   0.0000   0.4900   0.3700 
   0.0000   0.1400   0.0000   0.4900   0.3700 
   0.0000   0.1400   0.0000   0.4900   0.3700 
   0.0000   0.1400   0.0000   0.4900   0.3700 
   0.0000   0.1400   0.0000   0.4900   0.3700 
   0.0000   0.1400   0.0000   0.4900   0.3700 
   0.0000   0.1800   0.0000   0.4500   0.3700 
   0.0000   0.1400   0.0000   0.4900   0.3700 
   0.0000   0.1800   0.0000   0.4500   0.3700 
   0.0000   0.1800   0.0000   0.4500   0.3700 
   0.0000   0.1800   0.0000   0.4500   0.3700 
   0.0000   0.1800   0.0000   0.4500   0.3700 
   0.0000   0.1800   0.0000   0.4500   0.3700 
   0.0000   0.1800   0.0000   0.4500   0.3700 
   0.0000   0.1800   0.0000   0.4500   0.3700 
   0.0000   0.1800   0.0000   0.4500   0.3700 
   0.0000   0.1800   0.0000   0.4500   0.3700 
   0.0000   0.1800   0.0000   0.4500   0.3700 
   0.0000   0.1800   0.0000   0.4500   0.3700 
   0.0000   0.1800   0.0000   0.4500   0.3700 
   0.0000   0.1800   0.0000   0.4500   0.3700 
   0.0000   0.1800   0.0000   0.4500   0.3700 
   0.0000   0.1800   0.0000   0.4500   0.3700 
   0.0000   0.1800   0.0000   0.4500   0.3700 
   0.0000   0.4400   0.0000   0.1900   0.3700 
   0.0000   0.4400   0.0000   0.1900   0.3700 
   0.0000   0.4400   0.0000   0.1900   0.3700 
   0.0000   0.4400   0.0000   0.1900   0.3700 
   0.0000   0.4400   0.0000   0.1900   0.3700 
   0.0000   0.4400   0.0000   0.1900   0.3700 
   0.0000   0.4400   0.0000   0.1900   0.3700 
   0.0000   0.4400   0.0000   0.1900   0.3700 
   0.0000   0.4400   0.0000   0.1900   0.3700 
   0.0000   0.4400   0.0000   0.1900   0.3700 
# Fishing fleet names (delimited with : no spaces in names) 
Pot_Fishery:Trawl_Bycatch:Fixed_bycatch 
# Survey names (delimited with : no spaces in names) 
NMFS_Trawl:ADFG_Pot 
# Number  of  catch data  frames 
4 
# Number  of  rows  in  each  data  frame 
28  16  27  27 
##  CATCH DATA 
##  Type of catch: 1 = retained, 2 = discard 
##  Units of catch: 1 = biomass, 2 = numbers 
##  for SMBKC Units are in number of crab for landed & 1000 kg for discards. 
##  Male Retained 
# year  seas    fleet   sex     obs     cv      type    units   mult    effort  discard_mortality 
1978    2       1       1       436126  0.03    1       2       1       0       0 
1979    2       1       1       52966   0.03    1       2       1       0       0 
1980    2       1       1       33162   0.03    1       2       1       0       0 
1981    2       1       1       1045619 0.03    1       2       1       0       0 
1982    2       1       1       1935886 0.03    1       2       1       0       0 
1983    2       1       1       1931990 0.03    1       2       1       0       0 
1984    2       1       1       841017  0.03    1       2       1       0       0 
1985    2       1       1       436021  0.03    1       2       1       0       0 
1986    2       1       1       219548  0.03    1       2       1       0       0 
1987    2       1       1       227447  0.03    1       2       1       0       0 
1988    2       1       1       280401  0.03    1       2       1       0       0 
1989    2       1       1       247641  0.03    1       2       1       0       0 
1990    2       1       1       391405  0.03    1       2       1       0       0 
1991    2       1       1       726519  0.03    1       2       1       0       0 
1992    2       1       1       545222  0.03    1       2       1       0       0 
1993    2       1       1       630353  0.03    1       2       1       0       0 
1994    2       1       1       827015  0.03    1       2       1       0       0 
1995    2       1       1       666905  0.03    1       2       1       0       0 
1996    2       1       1       660665  0.03    1       2       1       0       0 
1997    2       1       1       939822  0.03    1       2       1       0       0 
1998    2       1       1       635370  0.03    1       2       1       0       0 
2009    2       1       1       103376  0.03    1       2       1       0       0 
2010    2       1       1       298669  0.03    1       2       1       0       0 
2011    2       1       1       437862  0.03    1       2       1       0       0 
2012    2       1       1       379386  0.03    1       2       1       0       0 
2014    2       1       1       69109   0.03    1       2       1       0       0 
2015    2       1       1       24407   0.03    1       2       1       0       0 
2016    2       1       1       24.407   0.03    1       2       1       0       0 
# Male  discards  Pot fishery 
1990    2       1       1     254.9787861     0.6     2       1       1       0       0.2 
1991    2       1       1     531.4483252     0.6     2       1       1       0       0.2 
1992    2       1       1     1050.387026     0.6     2       1       1       0       0.2 
1993    2       1       1     951.4626128     0.6     2       1       1       0       0.2 
1994    2       1       1     1210.764588     0.6     2       1       1       0       0.2 
1995    2       1       1     363.112032      0.6     2       1       1       0       0.2 
1996    2       1       1     528.5244687     0.6     2       1       1       0       0.2 
1997    2       1       1     1382.825328     0.6     2       1       1       0       0.2 
1998    2       1       1     781.1032977     0.6     2       1       1       0       0.2 
2009    2       1       1     123.3712279     0.2     2       1       1       0       0.2 
2010    2       1       1     304.6562225     0.2     2       1       1       0       0.2 
2011    2       1       1     481.3572126     0.2     2       1       1       0       0.2 
2012    2       1       1     437.3360731     0.2     2       1       1       0       0.2 
2014    2       1       1     45.4839749      0.2     2       1       1       0       0.2 
2015    2       1       1     21.19378597     0.2     2       1       1       0       0.2 
2016    2       1       1     0.021193786     0.2     2       1       1       0       0.2 
#	Trawl	fishery	discards							 
1991	2	2	1	3.538	0.31	2	1	1	0	0.8 
1992	2	2	1	1.996	0.31	2	1	1	0	0.8 
1993	2	2	1	1.542	0.31	2	1	1	0	0.8 
1994	2	2	1	0.318	0.31	2	1	1	0	0.8 
1995	2	2	1	0.635	0.31	2	1	1	0	0.8 
1996	2	2	1	0.5	0.31	2	1	1	0	0.8 
1997	2	2	1	0.5	0.31	2	1	1	0	0.8 
1998	2	2	1	0.5	0.31	2	1	1	0	0.8 
1999	2	2	1	0.5	0.31	2	1	1	0	0.8 
2000	2	2	1	0.5	0.31	2	1	1	0	0.8 
2001	2	2	1	0.5	0.31	2	1	1	0	0.8 
2002	2	2	1	0.726	0.31	2	1	1	0	0.8 
2003	2	2	1	0.998	0.31	2	1	1	0	0.8 
2004	2	2	1	0.091	0.31	2	1	1	0	0.8 
2005	2	2	1	0.5	0.31	2	1	1	0	0.8 
2006	2	2	1	2.812	0.31	2	1	1	0	0.8 
2007	2	2	1	0.045	0.31	2	1	1	0	0.8 
2008	2	2	1	0.272	0.31	2	1	1	0	0.8 
2009	2	2	1	0.638	0.31	2	1	1	0	0.8 
2010	2	2	1	0.36	0.31	2	1	1	0	0.8 
2011	2	2	1	0.17	0.31	2	1	1	0	0.8 
2012	2	2	1	0.011	0.31	2	1	1	0	0.8 
2013	2	2	1	0.163	0.31	2	1	1	0	0.8 
2014	2	2	1	0.01	0.31	2	1	1	0	0.8 
2015	2	2	1	0.01	0.31	2	1	1	0	0.8 
2016	2	2	1	0.229	0.31	2	1	1	0	0.8 
2017	2	2	1	0.052	0.31	2	1	1	0	0.8 
#	Fixed	fishery	discards							 
1991	2	3	1	0.045	0.31	2	1	1	0	0.5 
1992	2	3	1	2.268	0.31	2	1	1	0	0.5 
1993	2	3	1	0.5	0.31	2	1	1	0	0.5 
1994	2	3	1	0.091	0.31	2	1	1	0	0.5 
1995	2	3	1	0.136	0.31	2	1	1	0	0.5 
1996	2	3	1	0.045	0.31	2	1	1	0	0.5 
1997	2	3	1	0.181	0.31	2	1	1	0	0.5 
1998	2	3	1	0.907	0.31	2	1	1	0	0.5 
1999	2	3	1	1.361	0.31	2	1	1	0	0.5 
2000	2	3	1	0.5	0.31	2	1	1	0	0.5 
2001	2	3	1	0.862	0.31	2	1	1	0	0.5 
2002	2	3	1	0.408	0.31	2	1	1	0	0.5 
2003	2	3	1	1.134	0.31	2	1	1	0	0.5 
2004	2	3	1	0.635	0.31	2	1	1	0	0.5 
2005	2	3	1	0.59	0.31	2	1	1	0	0.5 
2006	2	3	1	1.451	0.31	2	1	1	0	0.5 
2007	2	3	1	69.717	0.31	2	1	1	0	0.5 
2008	2	3	1	6.622	0.31	2	1	1	0	0.5 
2009	2	3	1	7.522	0.31	2	1	1	0	0.5 
2010	2	3	1	9.564	0.31	2	1	1	0	0.5 
2011	2	3	1	0.796	0.31	2	1	1	0	0.5 
2012	2	3	1	0.739	0.31	2	1	1	0	0.5 
2013	2	3	1	0.341	0.31	2	1	1	0	0.5 
2014	2	3	1	0.49	0.31	2	1	1	0	0.5 
2015	2	3	1	0.711	0.31	2	1	1	0	0.5 
2016	2	3	1	1.633	0.31	2	1	1	0	0.5 
2017	2	3	1	6.032	0.31	2	1	1	0	0.5 
##  RELATIVE  ABUNDANCE DATA 
##  Units of abundance: 1 = biomass, 2 = numbers 
##  for SMBKC Units are in  crabs for Abundance. 
##  Number  of  relative  abundance indicies 
2 
##  Number  of  rows  in  each  index 
41  11 
# Survey data (abundance indices, units are mt for trawl survey and crab/potlift for pot survey) 
# Year, Seas, Fleet,  Sex,  Abundance,  CV     units 
1978  1 4 1 6832.819  0.394 1 
1979  1 4 1 7989.881  0.463 1 
1980  1 4 1 9986.830  0.507 1 
1981  1 4 1 6551.132  0.402 1 
1982  1 4 1 16221.933 0.344 1 
1983  1 4 1 9634.250  0.298 1 
1984  1 4 1 4071.218  0.179 1 
1985  1 4 1 3110.541  0.210 1 
1986  1 4 1 1416.849  0.388 1 
1987  1 4 1 2278.917  0.291 1 
1988  1 4 1 3158.169  0.252 1 
1989  1 4 1 6338.622  0.271 1 
1990  1 4 1 6730.130  0.274 1 
1991  1 4 1 6948.184  0.248 1 
1992  1 4 1 7093.272  0.201 1 
1993  1 4 1 9548.459  0.169 1 
1994  1 4 1 6539.133  0.176 1 
1995  1 4 1 5703.591  0.178 1 
1996  1 4 1 9410.403  0.241 1 
1997  1 4 1 10924.107 0.337 1 
1998  1 4 1 7976.839  0.355 1 
1999  1 4 1 1594.546  0.182 1 
2000  1 4 1 2096.795  0.310 1 
2001  1 4 1 2831.440  0.245 1 
2002  1 4 1 1732.599  0.320 1 
2003  1 4 1 1566.675  0.336 1 
2004  1 4 1 1523.869  0.305 1 
2005  1 4 1 1642.017  0.371 1 
2006  1 4 1 3893.875  0.334 1 
2007  1 4 1 6470.773  0.385 1 
2008  1 4 1 4654.473  0.284 1 
2009  1 4 1 6301.470  0.256 1 
2010  1 4 1 11130.898 0.466 1 
2011  1 4 1 10931.232 0.558 1 
2012  1 4 1 6200.219  0.339 1 
2013  1 4 1 2287.557  0.217 1 
2014  1 4 1 6029.220  0.449 1 
2015  1 4 1 5877.433  0.770 1 
2016  1 4 1 3485.909  0.393 1 
2017  1 4 1 1793.760  0.599 1 
2018  1 4 1 1730.74   0.281 1 
1995  1 5 1 12042.000 0.130 2 
1998  1 5 1 12531.000 0.060 2 
2001  1 5 1 8477.000  0.080 2 
2004  1 5 1 1667.000  0.150 2 
2007  1 5 1 8643.000  0.090 2 
2010  1 5 1 10209.000 0.130 2 
2013  1 5 1 5643.000  0.190 2 
2015  1 5 1 2805.000  0.180 2 
2016  1 5 1 2378.000  0.186 2 
2017  1 5 1 1689.000  0.250 2 
2018  1 5 1  745.000  0.140 2 
##  Number  of  length  frequency matrices 
3 
##  Number  of  rows  in  each  matrix 
15  41  11 
##  Number  of  bins  in  each  matrix  (columns  of  size  data) 
3  3  3 
##  SIZE  COMPOSITION DATA  FOR ALL FLEETS 
##  SIZE  COMP  LEGEND 
##  Sex:  1 = male, 2 = female, 0 = both  sexes combined 
##  Type  of  composition:  1 = retained, 2 = discard,  0 = total composition 
##  Maturity  state:  1 = immature, 2 = mature, 0 = both  states  combined 
##  Shell condition:  1 = new shell,  2 = old shell,  0 = both  shell types combined 
##length  proportions of  pot discarded males 
##Year, Seas, Fleet,  Sex,  Type, Shell,  Maturity, Nsamp,  DataVec 
  1990  2 1 1 0 0 0 15  0.1133  0.3933  0.4933 
  1991  2 1 1 0 0 0 25  0.1329  0.1768  0.6902 
  1992  2 1 1 0 0 0 25  0.1905  0.2677  0.5417 
  1993  2 1 1 0 0 0 25  0.2807  0.2097  0.5096 
  1994  2 1 1 0 0 0 25  0.2942  0.2714  0.4344 
  1995  2 1 1 0 0 0 25  0.1478  0.2127  0.6395 
  1996  2 1 1 0 0 0 25  0.1595  0.2229  0.6176 
  1997  2 1 1 0 0 0 25  0.1818  0.2053  0.6128 
  1998  2 1 1 0 0 0 25  0.1927  0.2162  0.5911 
  2009  2 1 1 0 0 0 50  0.1413  0.3235  0.5352 
  2010  2 1 1 0 0 0 50  0.1314  0.3152  0.5534 
  2011  2 1 1 0 0 0 50  0.1314  0.3051  0.5636 
  2012  2 1 1 0 0 0 50  0.1417  0.3178  0.5406 
  2014  2 1 1 0 0 0 50  0.0939  0.2275  0.6786 
  2015  2 1 1 0 0 0 50  0.1148  0.2518  0.6333 
##length  proportions of  trawl survey  males 
##Year, Seas, Fleet,  Sex,  Type, Shell,  Maturity, Nsamp,  DataVec 
  1978  1 4 1 0 0 0 50   0.3865  0.3478  0.2657 
  1979  1 4 1 0 0 0 50   0.4281  0.3190  0.2529 
  1980  1 4 1 0 0 0 50   0.3588  0.3220  0.3192 
  1981  1 4 1 0 0 0 50   0.1219  0.3065  0.5716 
  1982  1 4 1 0 0 0 50   0.1671  0.2435  0.5893 
  1983  1 4 1 0 0 0 50   0.1752  0.2726  0.5522 
  1984  1 4 1 0 0 0 50   0.1823  0.2085  0.6092 
  1985  1 4 1 0 0 0 46.5 0.2023  0.2010  0.5967 
  1986  1 4 1 0 0 0 23   0.1984  0.4364  0.3652 
  1987  1 4 1 0 0 0 35.5 0.1944  0.3779  0.4277 
  1988  1 4 1 0 0 0 40.5 0.1879  0.3737  0.4384 
  1989  1 4 1 0 0 0 50   0.4246  0.2259  0.3496 
  1990  1 4 1 0 0 0 50   0.2380  0.2332  0.5288 
  1991  1 4 1 0 0 0 50   0.2274  0.3300  0.4426 
  1992  1 4 1 0 0 0 50   0.2263  0.2911  0.4826 
  1993  1 4 1 0 0 0 50   0.2296  0.2759  0.4945 
  1994  1 4 1 0 0 0 50   0.1989  0.2926  0.5085 
  1995  1 4 1 0 0 0 50   0.2593  0.3005  0.4403 
  1996  1 4 1 0 0 0 50   0.1998  0.3054  0.4948 
  1997  1 4 1 0 0 0 50   0.1622  0.3102  0.5275 
  1998  1 4 1 0 0 0 50   0.1276  0.3212  0.5511 
  1999  1 4 1 0 0 0 26   0.2224  0.2214  0.5562 
  2000  1 4 1 0 0 0 30.5 0.2154  0.2180  0.5665 
  2001  1 4 1 0 0 0 45.5 0.2253  0.2699  0.5048 
  2002  1 4 1 0 0 0 19   0.1127  0.2346  0.6527 
  2003  1 4 1 0 0 0 32.5 0.3762  0.2345  0.3893 
  2004  1 4 1 0 0 0 24   0.2488  0.1848  0.5663 
  2005  1 4 1 0 0 0 21   0.2825  0.2744  0.4431 
  2006  1 4 1 0 0 0 50   0.3276  0.2293  0.4431 
  2007  1 4 1 0 0 0 50   0.4394  0.3525  0.2081 
  2008  1 4 1 0 0 0 50   0.3745  0.2219  0.4036 
  2009  1 4 1 0 0 0 50   0.3057  0.4202  0.2741 
  2010  1 4 1 0 0 0 50   0.4081  0.3371  0.2548 
  2011  1 4 1 0 0 0 50   0.2179  0.3940  0.3881 
  2012  1 4 1 0 0 0 50   0.1573  0.4393  0.4034 
  2013  1 4 1 0 0 0 37   0.2100  0.2834  0.5065 
  2014  1 4 1 0 0 0 50   0.1738  0.3912  0.4350 
  2015  1 4 1 0 0 0 50   0.2340  0.2994  0.4666 
  2016  1 4 1 0 0 0 50   0.2255  0.2780  0.4965 
  2017  1 4 1 0 0 0 50   0.0849  0.2994  0.6157 
  2018  1 4 1 0 0 0 50   0.1475  0.2219  0.6306 
  ##length  proportions of  pot survey 
  ##Year, Seas, Fleet,  Sex,  Type, Shell,  Maturity, Nsamp,  DataVec 
  1995  1 5 1 0 0 0 100 0.1594  0.2656  0.5751 
  1998  1 5 1 0 0 0 100  0.0769  0.2205  0.7026 
  2001  1 5 1 0 0 0 100  0.1493  0.2049  0.6457 
  2004  1 5 1 0 0 0 100  0.0672  0.2484  0.6845 
  2007  1 5 1 0 0 0 100  0.1257  0.3148  0.5595 
  2010  1 5 1 0 0 0 100  0.1299  0.3209  0.5492 
  2013  1 5 1 0 0 0 100  0.1556  0.2477  0.5967 
  2015  1 5 1 0 0 0 100  0.0706  0.2431  0.6859 
  2016  1 5 1 0 0 0 100  0.0832  0.1917  0.7251 
  2017  1 5 1 0 0 0 100  0.1048  0.2540  0.6412 
  2018  1 5 1 0 0 0 100  0.10201	0.21611	0.68188 
##  Growth data (increment) 
# nobs_growth 
3 
# MidPoint Sex Increment CV 
 97.5  1  14.1  0.2197 
112.5  1  14.1  0.2197 
127.5  1  14.1  0.2197 
#  97.5   1 13.8 0.2197 
#  112.5  1 14.1 0.2197 
#  127.5  1 14.4 0.2197 
# Use custom transition matrix (0=no, 1=growth matrix, 2=transition matrix, i.e. growth and molting) 
0 
# The custom growth matrix (if not using just fill with zeros) 
# Alternative TM (loosely) based on Otto and Cummiskey (1990) 
0.2  0.7  0.1 
0.0  0.4  0.6 
0.0  0.0  1.0 
#  Use  custom  natural  mortality  (0=no,  1=yes,  by  sex  and  year)       
0 
0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12  0.12 .12 .12 
## eof 
9999 
 
```
## The reference model (16.0) control file:


```
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## LEADING PARAMETER CONTROLS                                                           ## 
# Controls for leading parameter vector theta 
# LEGEND FOR PRIOR: 
#                  0 -> uniform #                  1 -> normal #                  2 -> lognormal 
#                  3 -> beta 
#                  4 -> gamma 
# ntheta 
  12 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
# ival        lb        ub        phz   prior     p1      p2         # parameter         # 
  0.18      0.01         1        -4       2   0.18    0.02          # M 
  14.3      -7.0        30        -2       0    -7       30          # log(R0) 
  10.0      -7.0        20        -1       1   -10.0     20          # log(Rini) 
  13.39     -7.0        20         1       0    -7       20          # log(Rbar) 
  80.0      30.0       310        -2       1    72.5    7.25         # Recruitment size distribution expected value 
  0.25       0.1         7        -4       0    0.1     9.0          # Recruitment size scale (variance component) 
  0.2      -10.0      0.75        -4       0  -10.0    0.75          # log(sigma_R) 
  0.75      0.20      1.00        -2       3    3.0    2.00          # steepness 
  0.01      0.00      1.00        -3       3    1.01   1.01          # recruitment autocorrelation 
 14.5       5.00     20.00         1       0    5.00  20.00          # logN0 vector of initial numbers at length 
 14.0       5.00     20.00         1       0    5.00  20.00          # logN0 vector of initial numbers at length 
 13.5       5.00     20.00         1       0    5.00  20.00          # logN0 vector of initial numbers at length 
## GROWTH PARAM CONTROLS                                                                ## 
## Two lines for each parameter if split sex, one line if not                           ## 
## number of molt periods 
1 
## Year(s) molt period changes (blank if no changes) 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
# ival        lb        ub         phz  prior     p1      p2         # parameter         # 
  14.1      10.0      30.0         -3       0    0.0   999.0         # alpha males or combined 
   0.0001    0.0       0.01        -3       0    0.0   999.0         # beta males or combined 
   0.45      0.01      1.0         -3       0    0.0   999.0         # gscale males or combined 
 121.5      65.0     145.0         -4       0    0.0   999.0         # molt_mu males or combined 
   0.060     0.0       1.0         -3       0    0.0   999.0         # molt_cv males or combined 
 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## SELECTIVITY CONTROLS                                                                 ## 
##     Each gear must have a selectivity and a retention selectivity. If a uniform      ## 
##     prior is selected for a parameter then the lb and ub are used (p1 and p2 are     ## 
##     ignored)                                                                         ## 
## LEGEND                                                                               ## 
##     sel type: 0 = parametric, 1 = coefficients, 2 = logistic, 3 = logistic95,        ## 
##               4 = double normal (NIY)                                                ## 
##     gear index: use +ve for selectivity, -ve for retention                           ## 
##     sex dep: 0 for sex-independent, 1 for sex-dependent                              ## 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
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
   1     1     1   0    0.4    0.001 1.0    0       0      1     3     1978   2008 
   1     2     2   0    0.7    0.001 1.0    0       0      1     3     1978   2008 
   1     3     3   0    1.0    0.001 2.0    0       0      1    -2     1978   2008 
   1     1     1   0    0.4    0.001 1.0    0       0      1     3     2009   2018 
   1     2     2   0    0.4    0.001 1.0    0       0      1     3     2009   2018 
   1     3     3   0    1.0    0.001 2.0    0       0      1    -2     2009   2018 
# Gear-2 
   2     7     1   0    40      10.0  200    0      10    200   -3     1978   2018 
   2     8     2   0    60      10.0  200    0      10    200   -3     1978   2018 
# Gear-3 
   3     9     1   0    40      10.0  200    0      10    200   -3     1978   2018 
   3    10     2   0    60      10.0  200    0      10    200   -3     1978   2018 
# Gear-4 
   4     8     1   0    0.7     0.001 1.0    0       0      1    4     1978   2018 
   4     9     2   0    0.7     0.001 1.0    0       0      1    4     1978   2018 
   4     10    3   0    0.9     0.001 1.0    0       0      1   -2     1978   2018 
# Gear-5 
   5     11    1   0    0.4     0.001 1.0    0       0      1    4     1978   2018 
   5     12    2   0    0.7     0.001 1.0    0       0      1    4     1978   2018 
   5     13    3   0    1.0     0.001 2.0    0       0      1   -2     1978   2018 
## Retained 
# Gear-1 
  -1     14    1   0   120   100   200    0      1    900   -1     1978   2018 
  -1     15    2   0   123   110   200    0      1    900   -1     1978   2018 
# Gear-2 
  -2     16    1   0   595    1    700    0      1    900   -3     1978   2018 
  -2     17    2   0    10    1    700    0      1    900   -3     1978   2018 
# Gear-3 
  -3     18    1   0   590    1    700    0      1    900   -3     1978   2018 
  -3     19    2   0    10    1    700    0      1    900   -3     1978   2018 
# Gear-4 
  -4     20    1   0   580    1    700    0      1    900   -3     1978   2018 
  -4     21    2   0    20    1    700    0      1    900   -3     1978   2018 
# Gear-5 
  -5     22    1   0   580    1    700    0      1    900   -3     1978   2018 
  -5     23    2   0    20    1    700    0      1    900   -3     1978   2018 
 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## PRIORS FOR CATCHABILITY 
##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ## 
##     and p2 are ignored). ival must be > 0                                            ## 
## LEGEND                                                                               ## 
##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ## 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
##  LAMBDA: Arbitrary relative weights for each series, 0 = do not fit. 
## SURVEYS/INDICES ONLY 
## ival    lb       ub    phz   prior   p1       p2    Analytic?   LAMBDA 
   1.0     0.5      1.2   -4    0       0        9.0   0           1       # NMFS trawl 
4.11135867487e-4 0 5       3    0       0        9.0   0           1       # ADF&G pot 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## ADDITIONAL CV FOR SURVEYS/INDICES                                                    ## 
##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ## 
##     and p2 are ignored). ival must be > 0                                            ## 
## LEGEND                                                                               ## 
##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ## 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## ival        lb        ub        phz   prior     p1      p2 
   0.0000001      0.00000001   10.0      -4    4         1.0     100   # NMFS 
   0.0000001      0.00000001   10.0      -4    4         1.0     100   # ADF&G 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## PENALTIES FOR AVERAGE FISHING MORTALITY RATE FOR EACH GEAR 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## Mean_F  STD_PHZ1  STD_PHZ2     PHZ 
   0.2       0.05     50.0       1   # Pot 
   0.0001     0.05     50.0       1   # Trawl 
   0.0001     0.05     50.0       1   # Fixed 
   0.00      2.00     20.00     -1   # NMFS 
   0.00      2.00     20.00     -1   # ADF&G 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## OPTIONS FOR SIZE COMPOSTION DATA (COLUMN FOR EACH MATRIX) 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## LIKELIHOOD OPTIONS 
##   -1) Multinomial with estimated/fixed sample size 
##   -2) Robust approximation to multinomial 
##   -3) logistic normal (NIY) 
##   -4) multivariate-t (NIY) 
##   -5) Dirichlet 
## AUTOTAIL COMPRESSION 
##   pmin is the cumulative proportion used in tail compression. 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
#  1   1   1  # Type of likelihood 
  2   2   2  # Type of likelihood 
#  5   5   5   # Type of likelihood 
  0   0   0   # Auto tail compression (pmin) 
  1   1   1   # Initial value for effective sample size multiplier 
 -4  -4  -4   # Phz for estimating effective sample size (if appl.) 
  1   2   3   # Composition aggregator 
  1   1   1   # LAMBDA 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## TIME VARYING NATURAL MORTALIIY RATES                                                 ## 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## TYPE:  
##      0 = constant natural mortality 
##      1 = Random walk (deviates constrained by variance in M) 
##      2 = Cubic Spline (deviates constrained by nodes & node-placement) 
##      3 = Blocked changes (deviates constrained by variance at specific knots) 
##      4 = Time blocks 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
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
# 1976 1980 1985 1994 # Females (ignored if single sex...) 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## OTHER CONTROLS 
## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
  3       # Estimated rec_dev phase 
  3       # Estimated rec_ini phase 
  0       # VERBOSE FLAG (0 = off, 1 = on, 2 = objective func) 
  2       # Initial conditions (0 = Unfished, 1 = Steady-state fished, 2 = Free parameters) 
  1978    # First year for average recruitment for Bspr calculation 
  2017    # Last year for average recruitment for Bspr calculation 
  0.35    # Target SPR ratio for Bmsy proxy 
  1       # Gear index for SPR calculations (i.e. directed fishery) 
  1       # Lambda (proportion of mature male biomass for SPR reference points) 
  1       # Use empirical molt increment data (0 = FALSE, 1 = TRUE) 
  0       # Stock-Recruit-Relationship (0 = None, 1 = Beverton-Holt) 
## EOF 
9999 
```
<!-- 
## The no $M_{1998}$ model control file:


```
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## ## LEADING PARAMETER CONTROLS                                                           ## 
## # Controls for leading parameter vector theta 
## # LEGEND FOR PRIOR: 
## #                  0 -> uniform #                  1 -> normal #                  2 -> lognormal 
## #                  3 -> beta 
## #                  4 -> gamma 
## # ntheta 
##   12 
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## # ival        lb        ub        phz   prior     p1      p2         # parameter         # 
##   0.18      0.01         1        -4       2   0.18    0.02          # M 
##   14.3      -7.0        30        -2       0    -7       30          # log(R0) 
##   10.0      -7.0        20        -1       1   -10.0     20          # log(Rini) 
##   14.13979   7.0        16         1       0     7.0     16.         # log(Rbar) 
##   80.0      30.0       310        -2       1    72.5    7.25         # Recruitment size distribution expected value 
##   0.25       0.1         7        -4       0    0.1     9.0          # Recruitment size scale (variance component) 
##   0.2      -10.0      0.75        -4       0  -10.0    0.75          # log(sigma_R) 
##   0.75      0.20      1.00        -2       3    3.0    2.00          # steepness 
##   0.01      0.00      1.00        -3       3    1.01   1.01          # recruitment autocorrelation 
##  14.9      10.00     15.00         3       0    5.00  20.00          # logN0 vector of initial numbers at length 
##  14.5      10.00     15.00         3       0    5.00  20.00          # logN0 vector of initial numbers at length 
##  14.3      10.00     15.00         3       0    5.00  20.00          # logN0 vector of initial numbers at length 
## ## GROWTH PARAM CONTROLS                                                                ## 
## ## Two lines for each parameter if split sex, one line if not                           ## 
## ## number of molt periods 
## 1 
## ## Year(s) molt period changes (blank if no changes) 
##  
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## # ival        lb        ub         phz  prior     p1      p2         # parameter         # 
##   14.1      10.0      30.0         -3       0    0.0   999.0         # alpha males or combined 
##    0.0001    0.0       0.01        -3       0    0.0   999.0         # beta males or combined 
##    0.45      0.01      1.0         -3       0    0.0   999.0         # gscale males or combined 
##  121.5      65.0     145.0         -4       0    0.0   999.0         # molt_mu males or combined 
##    0.060     0.0       1.0         -3       0    0.0   999.0         # molt_cv males or combined 
##  
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## ## SELECTIVITY CONTROLS                                                                 ## 
## ##     Each gear must have a selectivity and a retention selectivity. If a uniform      ## 
## ##     prior is selected for a parameter then the lb and ub are used (p1 and p2 are     ## 
## ##     ignored)                                                                         ## 
## ## LEGEND                                                                               ## 
## ##     sel type: 0 = parametric, 1 = coefficients, 2 = logistic, 3 = logistic95,        ## 
## ##               4 = double normal (NIY)                                                ## 
## ##     gear index: use +ve for selectivity, -ve for retention                           ## 
## ##     sex dep: 0 for sex-independent, 1 for sex-dependent                              ## 
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
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
## ## gear  par   sel                                                      phz    start  end    ## 
## ## index index par sex  ival           lb    ub  prior     p1     p2  mirror period period   ## 
## # Gear-1 
##    1     1     1   0    0.4    0.001 1.0    0       0      1     3     1978   2008 
##    1     2     2   0    0.7    0.001 1.0    0       0      1     3     1978   2008 
##    1     3     3   0    1.0    0.001 2.0    0       0      1    -2     1978   2008 
##    1     1     1   0    0.4    0.001 1.0    0       0      1     3     2009   2017 
##    1     2     2   0    0.4    0.001 1.0    0       0      1     3     2009   2017 
##    1     3     3   0    1.0    0.001 2.0    0       0      1    -2     2009   2017 
## # Gear-2 
##    2     7     1   0    40      10.0  200    0      10    200   -3     1978   2017 
##    2     8     2   0    60      10.0  200    0      10    200   -3     1978   2017 
## # Gear-3 
##    3     9     1   0    40      10.0  200    0      10    200   -3     1978   2017 
##    3    10     2   0    60      10.0  200    0      10    200   -3     1978   2017 
## # Gear-4 
##    4     8     1   0    0.7     0.001 1.0    0       0      1    4     1978   2017 
##    4     9     2   0    0.7     0.001 1.0    0       0      1    4     1978   2017 
##    4     10    3   0    0.9     0.001 1.0    0       0      1   -2     1978   2017 
## # Gear-5 
##    5     11    1   0    0.4     0.001 1.0    0       0      1    4     1978   2017 
##    5     12    2   0    0.7     0.001 1.0    0       0      1    4     1978   2017 
##    5     13    3   0    1.0     0.001 2.0    0       0      1   -2     1978   2017 
## ## Retained 
## # Gear-1 
##   -1     14    1   0   120   100   200    0      1    900   -1     1978   2017 
##   -1     15    2   0   123   110   200    0      1    900   -1     1978   2017 
## # Gear-2 
##   -2     16    1   0   595    1    700    0      1    900   -3     1978   2017 
##   -2     17    2   0    10    1    700    0      1    900   -3     1978   2017 
## # Gear-3 
##   -3     18    1   0   590    1    700    0      1    900   -3     1978   2017 
##   -3     19    2   0    10    1    700    0      1    900   -3     1978   2017 
## # Gear-4 
##   -4     20    1   0   580    1    700    0      1    900   -3     1978   2017 
##   -4     21    2   0    20    1    700    0      1    900   -3     1978   2017 
## # Gear-5 
##   -5     22    1   0   580    1    700    0      1    900   -3     1978   2017 
##   -5     23    2   0    20    1    700    0      1    900   -3     1978   2017 
##  
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## ## PRIORS FOR CATCHABILITY 
## ##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ## 
## ##     and p2 are ignored). ival must be > 0                                            ## 
## ## LEGEND                                                                               ## 
## ##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ## 
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## ##  LAMBDA: Arbitrary relative weights for each series, 0 = do not fit. 
## ## SURVEYS/INDICES ONLY 
## ## ival    lb       ub    phz   prior   p1       p2    Analytic?   LAMBDA 
##    1.0     0        2     -1    0       0        9.0   0           1       # NMFS trawl 
## 0.00411135867487 0 5       1    0       0        9.0   0           1       # ADF&G pot 
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
##  
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## ## ADDITIONAL CV FOR SURVEYS/INDICES                                                    ## 
## ##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ## 
## ##     and p2 are ignored). ival must be > 0                                            ## 
## ## LEGEND                                                                               ## 
## ##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ## 
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## ## ival        lb        ub        phz   prior     p1      p2 
##    0.0000001      0.00000001   10.0      -4    4         1.0     100   # NMFS 
##    0.0000001      0.00000001   10.0      -4    4         1.0     100   # ADF&G 
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
##  
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## ## PENALTIES FOR AVERAGE FISHING MORTALITY RATE FOR EACH GEAR 
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## ## Mean_F  STD_PHZ1  STD_PHZ2     PHZ 
##    0.2       0.05     50.0       1   # Pot 
##    0.001     0.05     50.0       1   # Trawl 
##    0.001     0.05     50.0       1   # Fixed 
##    0.00      2.00     20.00     -1   # NMFS 
##    0.00      2.00     20.00     -1   # ADF&G 
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
##  
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## ## OPTIONS FOR SIZE COMPOSTION DATA (COLUMN FOR EACH MATRIX) 
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## ## LIKELIHOOD OPTIONS 
## ##   -1) Multinomial with estimated/fixed sample size 
## ##   -2) Robust approximation to multinomial 
## ##   -3) logistic normal (NIY) 
## ##   -4) multivariate-t (NIY) 
## ##   -5) Dirichlet 
## ## AUTOTAIL COMPRESSION 
## ##   pmin is the cumulative proportion used in tail compression. 
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## #  1   1   1  # Type of likelihood 
##   2   2   2  # Type of likelihood 
## #  5   5   5   # Type of likelihood 
##   0   0   0   # Auto tail compression (pmin) 
##   1   1   1   # Initial value for effective sample size multiplier 
##  -4  -4  -4   # Phz for estimating effective sample size (if appl.) 
##   1   2   3   # Composition aggregator 
##   1   1   1   # LAMBDA 
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
##  
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## ## TIME VARYING NATURAL MORTALIIY RATES                                                 ## 
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## ## TYPE:  
## ##      0 = constant natural mortality 
## ##      1 = Random walk (deviates constrained by variance in M) 
## ##      2 = Cubic Spline (deviates constrained by nodes & node-placement) 
## ##      3 = Blocked changes (deviates constrained by variance at specific knots) 
## ##      4 = Time blocks 
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## ## Sex-specific? (0=no, 1=yes) 
## 0 
## ## Type 
## 3 
## ## Phase of estimation 
## 4 
## ## STDEV in m_dev for Random walk 
## 10.0 
## ## Number of nodes for cubic spline or number of step-changes for option 3 
## 2 
## 0 # Females (ignored if single sex...) 
## ## Year position of the knots (vector must be equal to the number of nodes) 
## 1998 1999 
## # 1976 1980 1985 1994 # Females (ignored if single sex...) 
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
##  
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
## ## OTHER CONTROLS 
## ## <U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD><U+FFFD> ## 
##   3       # Estimated rec_dev phase 
##   3       # Estimated rec_ini phase 
##   0       # VERBOSE FLAG (0 = off, 1 = on, 2 = objective func) 
##   2       # Initial conditions (0 = Unfished, 1 = Steady-state fished, 2 = Free parameters) 
##   1978    # First year for average recruitment for Bspr calculation 
##   2016    # Last year for average recruitment for Bspr calculation 
##   0.35    # Target SPR ratio for Bmsy proxy 
##   1       # Gear index for SPR calculations (i.e. directed fishery) 
##   1       # Lambda (proportion of mature male biomass for SPR reference points) 
##   1       # Use empirical molt increment data (0 = FALSE, 1 = TRUE) 
##   0       # Stock-Recruit-Relationship (0 = None, 1 = Beverton-Holt) 
## ## EOF 
## 9999
```
--> 


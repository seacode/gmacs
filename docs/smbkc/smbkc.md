---
title: "Saint Matthew Island Blue King Crab Stock Assessment 2016"
author: "The Gmacs development team"
date: "May 2015"
output:
  pdf_document:
    highlight: zenburn
    toc: yes
  html_document:
    theme: flatly
    toc: yes
  word_document: default
bibliography: Gmacs.bib
---





# Executive Summary

1. **Stock**: Blue king crab, *Paralithodes platypus*, Saint Matthew Island (SMBKC), Alaska.

2. **Catches**: Peak historical harvest was 9.454 million pounds (4,288 t) in 1983/84. The fishery was closed for 10 years after the stock was declared overfished in 1999. Fishing resumed in 2009/10 with a fishery-reported retained catch of 0.461 million pounds (209 t), less than half the 1.167 million pound (529.3 t) TAC. Following three more years of modest harvests supported by a fishery CPUE of around 10 crab per pot lift, the fishery was again closed in 2013/14 due to declining trawl-survey estimates of abundance and concerns about the health of the stock. The directed fishery resumed again in 2014/15 with a TAC of 0.655 million pounds (300 t), but the fishery performance was relatively poor with the retained catch of 0.309 million pounds (140 t).

3. **Stock biomass**: Following a period of low numbers after the stock was declared overfished in 1999, trawl-survey indices of SMBKC stock abundance and biomass generally increased in subsequent years, with survey estimated mature male biomass reaching 20.98 million pounds (9,516 t; CV == 0.55) in 2011, the second highest in the 37-year time series used in this assessment. Survey mature male biomass then declined to 12.46 million pounds (5,652 t; CV = 0.33) in 2012 and to 4.459 million pounds (2,202 t; CV = 0.22) in 2013 before going back up to 12.06 million pounds (5,472 t; CV = 0.44) in 2014 and 11.32 million pounds (5,134 t; CV = 0.76).

4. **Recruitment**: Because little information about the abundance of small crab is available for this stock, recruitment has been assessed in terms of the number of male crab within the 90-104 mm CL size class in each year. The 2013 trawl-survey area-swept estimate of 0.335 million male SMBKC in this size class marked a three-year decline and was the lowest since 2005. That decline did not continue with the 2014 survey with an estimate of 0.723 million. The survey recruitment is 0.992 million in 2015, but the majority of them came from one tow with a great deal of uncertainty.

5. **Management performance**: In recent assessments, estimated total male catch has been determined as the sum of fishery-reported retained catch, estimated male discard mortality in the directed fishery, and estimated male bycatch mortality in the groundfish fisheries, as these have been the only sources of non-negligible fishing mortality to consider.

The stock was above MSST in 2014/15 and is hence not overfished. Overfishing did not occur.

6. **Basis for the OFL**: Estimated Feb 15 mature-male biomass ($MMB_\text{mating}$) is used as the measure of biomass for this Tier 4 stock, with males measuring 105 mm CL or more considered mature. The $B_{MSY}$ proxy is obtained by averaging estimated $MMB_\text{mating}$ over a specific reference time period, and current CPT/SSC guidance recommends using the full assessment time frame as the default reference time period.


# A. Summary of Major Changes

## Changes in Management of the Fishery

There are no new changes in management of the fishery.

## Changes to the Input Data

All time series used in the assessment have been updated to include the most recent fishery and survey results. This assessment makes use of an updated full trawl-survey time series supplied by R. Foy in August 2015 (new time series), updated groundfish bycatch estimates based on 1999-2014 NMFS AKRO data also supplied by R. Foy, and the ADF&G pot survey data in 2015.

Spatial trawl survey and bottom temperatures from 1978 to 2015 are used in this assessment as well.

## Changes in Assessment Methodology

This assessment is done using Gmacs. The model is based upon the 3-stage length-based assessment model first presented in May 2011 by Bill Gaeuman and accepted by the CPT in May 2012. The model was developed to replace a similar 4-stage model used prior to 2011. During the assessment in May 2015 and this assessment, many combinations of molting probability and trawl survey selectivities were evaluated to address the residual bias problems in the previous model. We also considered bottom temperature data and spatial abundance density in station R-24 in the assessment in May 2015. In September 2015, twenty scenarios were investigated. The detailed changes to the model parameters are described in details in E (Analytic Approach).

## Changes in Assessment Results

Changes in assessment results depend on model scenarios. Many model scenarios in this assessment have satisfactorily addressed the problems of biased residual patterns on ????.


# B. Responses to SSC and CPT Comments

## CPT and SSC Comments on Assessments in General

## CPT and SSC Comments Specific to SMBKC Stock Assessment


# C. Introduction

## Scientific Name

The blue king crab is a lithodid crab, *Paralithodes platypus* (Brant 1850).

## Distribution

Blue king crab are sporadically distributed throughout the North Pacific Ocean from Hokkaido, Japan, to southeastern Alaska (Figure 1). In the eastern Bering Sea small populations are distributed around St. Matthew Island, the Pribilof Islands, St. Lawrence Island, and Nunivak Island. Isolated populations also exist in some other cold water areas of the Gulf of Alaska (NPFMC 1998). The St. Matthew Island Section for blue king crab is within Area Q2 (Figure 2), which is the Northern District of the Bering Sea king crab registration area and includes the waters north of Cape Newenham (58°39’ N. lat.) and south of Cape Romanzof (61°49’ N. lat.).

## Stock Structure

The Alaska Department of Fish and Game (ADF&G) Gene Conservation Laboratory division has detected regional population differences between blue king crab collected from St. Matthew Island and the Pribilof Islands^[NOAA grant Bering Sea Crab Research II, NA16FN2621, 1997.]. NMFS tag-return data from studies on blue king crab in the Pribilof Islands and St. Matthew Island support the idea that legal-sized males do not migrate between the two areas (Otto and Cummiskey 1990). St. Matthew Island blue king crab tend to be smaller than their Pribilof conspecifics, and the two stocks are managed separately.

## Life History

Like the red king crab, *Paralithodes camtshaticus*, the blue king crab is considered a shallow water species by comparison with other lithodid such as golden king crab, *Lithodes aequispinus*, and the scarlet king crab, *Lithodes couesi* (Donaldson and Byersdorfer 2005). Adult male blue king crab are found at an average depth of 70m (NPFMC 1998). The reproductive cycle appears to be annual for the first two reproductive cycles and biennial thereafter (cf. Jensen and Armstrong, 1989) and mature crab seasonally migrate inshore where they molt and mate. Unlike red king crab, juvenile blue king crab do not form pods, but instead rely on cryptic coloration for protection from predators and require suitable habitat such as cobble and shell hash. Somerton and MacIntosh (1983) estimated SMBKC male size at sexual maturity to be 77.0 mm carapace length (CL). Paul et al. (1991) found that spermatophores were present in the vas deferens of 50% of the St. Matthew Island blue king crab males examined with sizes of 40–49 mm CL and in 100% of the males at least 100 mm CL. Spermataphore diameter also increased with increasing CL with an asymptote at ~ 100 mm CL. They noted, however, that although spermataphore presence indicates physiological sexual maturity, it may not be an indicator of functional sexual maturity. For purposes of management of the St. Matthew Island blue king crab fishery, the State of Alaska uses 105 mm CL to define the lower size bound of functionally mature males (Pengilly and Schmidt 1995). Otto and Cummiskey (1990) report an average growth increment of 14.1 mm CL for adult SMBKC males.

## Management History

The SMBKC fishery developed subsequent to baseline ecological studies associated with oil exploration (Otto 1990). Ten U.S. vessels harvested 1.202 million pounds in 1977, and harvests peaked in 1983 when 164 vessels landed 9.454 million pounds (Fitch et al. 2012; Table 1). The fishing seasons were generally short, often lasting only a few days. The fishery was declared overfished and closed in 1999 when the stock biomass estimate was below the minimum stock- size threshold (MSST) of 11.0 million pounds as defined by the Fishery Management Plan for the Bering Sea/Aleutian Islands King and Tanner crabs (NPFMC 1999). Zheng and Kruse (2002) hypothesized a high level of SMBKC natural mortality from 1998 to 1999 as an explanation for the low catch per unit effort (CPUE) in the 1998/99 commercial fishery and the low numbers across all male crab size groups caught in the annual NMFS eastern Bering Sea trawl survey from 1999 to 2005 (Table 2). In Nov 2000, Amendment 15 to the FMP for Bering Sea/Aleutian Islands king and Tanner crabs was approved to implement a rebuilding plan for the SMBKC stock (NPFMC 2000). The rebuilding plan included a regulatory harvest strategy (5 AAC 34.917), area closures, and gear modifications. In addition, commercial crab fisheries near St. Matthew Island were scheduled in fall and early winter to reduce the potential for bycatch mortality of vulnerable molting and mating crab.

NMFS declared the stock rebuilt on Sept 21, 2009, and the fishery was reopened after a 10-year closure on Oct 15, 2009 with a TAC of 1.167 million pounds, closing again by regulation on Feb 1, 2010. Seven participating vessels landed a catch of 460,859 pounds with a reported effort of 10,697 pot lifts and an estimated CPUE of 9.9 retained number of crab per pot lift. The fishery remained open the next three years with modest harvests and similar CPUE, but large declines in the NMFS trawl-survey estimate of stock abundance raised concerns about the health of the stock, prompting ADF&G to close the fishery again for the 2013/14 season. Due to abundance above thresholds, the fishery was reopen for the 2014/15 season with a low TAC 0.655 million pounds.

Though historical observer data are limited due to very limited samplings, bycatch of female and sublegal male crab from the directed blue king crab fishery off St. Matthew Island was relatively high historically, with estimated total bycatch in terms of number of crab captured sometimes twice or more as high as the catch of legal crab (Moore et al. 2000; ADF&G Crab Observer Database). Pot-lift sampling by ADF&G crab observers (Gaeuman 2013; ADF&G Crab Observer Database) indicates similar bycatch rates of discarded male crab since the reopening of the fishery (Table 3), with total male discard mortality in the 2012/13 directed fishery estimated at about 12% (0.193 million pounds) of the reported retained catch weight, assuming 20% handling mortality. On the other hand, these same data suggest a significant reduction in the bycatch of females, which may be attributable to the later timing of the contemporary fishery^[D. Pengilly, ADF&G, pers. comm.]. Some bycatch of discarded blue king crab has also been observed historically in the eastern Bering Sea snow crab fishery, but in recent years it has generally been negligible, and observers recorded no bycatch of blue king crab in sampled pot lifts during 2013/14. The St. Matthew Island golden king crab fishery, the third commercial crab fishery to have taken place in the area, typically occurred in areas with depths exceeding blue king crab distribution. NMFS observer data suggest that variable but mostly limited SMBKC bycatch has also occurred in the eastern Bering Sea groundfish fisheries (Table 5).


# D. Data

## Summary of New Information

Data used in this assessment have been updated to include the most recently available fishery and survey numbers. In addition, this assessment makes use an updated trawl-survey time series provided by R. Foy in August 2015 (new time series), as well as updated 1993-2014 groundfish bycatch estimates based on AKRO data also supplied by R. Foy. The new and old time series of trawl survey area-swept estimates were compared in May 2015 and only the new time series was used in this assessment. The data extent and availability is shown in Figure \ref{fig:data_extent}).


```
## [1] "../../examples/smbkc/gmacs.rep"
```

![Data extent for the gmacs model configuration.\label{fig:data_extent}](figure/data_extent-1.png) 

```
##  [1] 1975 1980 1980 1980 1980 1980 1985 1985 1985 1985 1985 1990 1990 1990
## [15] 1990 1990 1995 1995 1995 1995 1995 2000 2000 2000 2000 2000 2005 2005
## [29] 2005 2005 2005 2010 2010 2010 2010 2010 2015 2015 2015 2015
```

## Major Data Sources

Major data sources used in this assessment are annual directed-fishery retained-catch statistics from fish tickets (1978/79-1998/99, 2009/10-2012/13, and 2014/15; Table 1); results from the annual NMFS eastern Bering Sea trawl survey (1978-2015; Table 2); results from the triennial ADF&G SMBKC pot survey (every third year during 1995-2013) and 2015 pot survey (Table 4); size-frequency information from ADF&G crab-observer pot-lift sampling (1990/91-1998/99, 2009/10-2012/13, and 2014/15; Table3); and NMFS groundfish-observer bycatch biomass estimates (1992/93-2014/15; Table 5). Figure 3 maps stations from which SMBKC trawl-survey and pot-survey data were obtained. Further information concerning the NMFS trawl survey as it relates to commercial crab species is available in Daly et al. (2014); see Gish et al. (2012) for a description of ADF&G SMBKC pot-survey methods. It should be noted that the two surveys cover different geographic regions and that each has in some years encountered proportionally large numbers of male blue king crab in areas where the other is not represented (Figure 4). Crab-observer sampling protocols are detailed in the crab-observer training manual (ADF&G 2013). Groundfish SMBKC bycatch data come from NMFS Bering Sea reporting areas 521 and 524 (Figure 5). Note that for this assessment the newly available NMFS groundfish observer data reported by ADF&G statistical area was not used.

## Other Data Sources

The alternative model configuration developed for this assessment makes use of a growth transition matrix based on Otto and Cummiskey (1990). Other relevant data sources, including assumed population and fishery parameters, are presented in Appendix A, which provides a detailed description of the base-model configuration used for the 2012 and 2013 assessments.

## Major Excluded Data Sources

Groundfish bycatch size-frequency data available for selected years, though used in the model-based assessment in place prior to 2011, play no direct role in this analysis. This is because these data tend to be severely limited: for example, 2012/13 data include a total of just 4 90-mm+ CL male blue king crab from reporting areas 521 and 524.


# E. Analytic Approach

## History of Modeling Approaches for this Stock

A four-stage catch-survey-analysis (CSA) assessment model was used before 2011 to estimate abundance and biomass and prescribe fishery quotas for the SMBKC stock (2010 SAFE; Zheng et al. 1997). The four-stage CSA is similar to a full length-based analysis, the major difference being coarser length groups, which are more suited to a small stock with consistently low survey catches. In this approach, the abundance of male crab with a CL of 90 mm or above is modeled in terms of four crab stages: stage 1: 90-104 mm CL; stage 2: 105-119 mm CL; stage 3: newshell 120-133 mm CL; and stage 4: oldshell $\ge$ 120 mm CL and newshell $\ge$ 134 mm CL. Motivation for these stage definitions comes from the fact that for management of the SMBKC stock, male crab measuring at least 105 mm CL are considered mature, whereas 120 mm CL is considered a proxy for the legal size of 5.5 in carapace width, including spines. Additional motivation for these stage definitions derives from an estimated average growth increment of about 14 mm per molt for SMBKC (Otto and Cummiskey 1990).

Concerns about the pre-2011 assessment model led to CPT and SSC recommendations that included development of an alternative model with provisional assessment based on survey biomass or some other index of abundance. An alternative 3-stage model was proposed to the CPT in May 2011 but was requested to proceed with a survey-based approach for the Fall 2011 assessment. In May 2012 the CPT approved a slightly revised and better documented version of the alternative model for assessment.

## Assessment Methodology

The current SMBKC stock assessment model, first used in Fall 2012, is a variant of the previous four-stage SMBKC CSA model (2010 SAFE; Zheng et al. 1997) and similar in complexity to that described by Collie et al. (2005). Like the earlier model, it considers only male crab at least 90 mm in CL, but it combines stages 3 and 4 of the earlier model resulting in just three stages (male size classes) determined by carapace length measurements of (1) 90-104 mm, (2) 105-119 mm, and (3) 120 mm+ (i.e., 120 mm and above). This consolidation was driven by concern about the accuracy and consistency of shell-condition information, which had been used in distinguishing stages 3 and 4 of the earlier model. A detailed description of the base model and its implementation in the software AD Model Builder (Fournier et al. 2012) is presented in Appendix A.

## Model Selection and Evaluation

In May 2015, eight model scenarios were considered. In this (September 2015) assessment, twenty scenarios are examined:

## Results

Additional results are presented for model scenarios 3, 8, 10, 11, and 10-4, as these scenarios represent different approaches. We recommend scenario 10-4 to be used for the overfishing determination in 2015, based on the fit of the data, plausibility of parameter estimates, and quality of area-swept abundance estimates.


# F. Calculation of the OFL and ABC

The overfishing level (OFL) is the fishery-related mortality biomass associated with fishing mortality $F_{OFL}$. The SMBKC stock is currently managed as Tier 4 (2013 SAFE), and only a Tier 4 analysis is presented here. Thus given stock estimates or suitable proxy values of $B_{MSY}$ and $F_{MSY}$, along with two additional parameters $\alpha$ and $\beta$, $F_{OFL}$ is determined by the control rule

$$\text{a) } F_{OFL} = F_{MSY}, \quad \text{when } B/B_{MSY} > 1$$

$$\text{b) } F_{OFL} = F_{MSY} \frac{\left( B/B_{MSY} - \alpha \right)}{(1 - \alpha)}, \quad \text{when } \beta < B/B_{MSY} \le 1$$

$$\text{c) } F_{OFL} < F_{MSY} \text{ with directed fishery } F = 0, \quad \text{when } B/B_{MSY} \le \beta$$

where $B$ is quantified as mature-male biomass $MMB_\text{mating}$, at mating with time of mating assigned a nominal date of Feb 15. Note that as $B$ itself is a function of the fishing mortality $F_{OFL}$ , in case b) numerical approximation of $F_{OFL}$ is required. As implemented for this assessment, all calculations proceed according to the model equations given in Appendix A. In particular, the OFL catch is computed using equations A3, A4, and A5, with $F_{OFL}$ taken to be full-selection fishing mortality in the directed pot fishery and groundfish trawl and fixed-gear fishing mortalities set at their model geometric mean values over years for which there are data-based estimates of bycatch-mortality biomass.

The currently recommended Tier 4 convention is to use the full assessment period, currently 1978-2015, to define a $B_{MSY}$ proxy in terms of average estimated MMB mating and to put $\gamma$ = 1.0 with assumed stock natural mortality $M$ = 0.18 yr-1 in setting the $F_{MSY}$ proxy value $\gamma M$. The parameters $\alpha$ and $\beta$ are assigned their default values $\alpha$ = 0.10 and $\beta$ = 0.25. The $F_{OFL}$, OFL, and MMB in 2015 for 18 scenarios are summarized in Table 10. Figures 23 and 24 illustrate respectively the MMB and OFL probabilities in 2015 for scenarios 10 and 10-4 using the mcmc appproach. ABC is 80% of the OFL.

OFL, ABC, retained catch and bycatches for 2015 are summarized for scenarios 10 and 10-4 below:


# G. Rebuilding Analysis

This stock is not currently subject to a rebuilding plan.


# H. Data Gaps and Research Priorities

  1. Growth increments and molting probabilities as a function of size.
  2. Trawl survey catchability and selectivities.
  3. Temporal changes in spatial distributions near the island.
  4. Natural mortality.


# I. Projections and Future Outlook

With the decline of estimated population biomass during recent years, outlook for this stock is not promising. If the decline continues, the stock will fall to depleted status soon.


# J. Acknowledgements

We thank the Crab Plan Team, Joel Webb and Shareef Siddeek for reviewing the earlier draft of this manuscript. Some materials in the report are from the SAFE report prepared by Bill Gaeuman in 2014.


\newpage

Table 1. The 1978/79 – 2014/15 directed St. Matthew Island blue king crab pot fishery. Source: Fitch et al. 2012; ADF&G Dutch Harbor staff, pers. comm.

Table 2a. NMFS EBS trawl-survey area-swept estimates of male crab abundance (10 6 crab) and of mature male biomass (10 6 lbs). Total number of captured male crab $\ge$ 90 mm CL is also given. Source: R.Foy, NMFS. The “+” refers to plus group.

\begin{table}[ht]
\centering
\caption{Population abundances (N) by crab stage in millions of crab, mature male biomasses at survey (MMB) in millions of pounds on Feb. 15 for scenario 1. All abundances are at time of survey.} 
\label{tab:pop_abundance}
\begin{tabular}{rrrrr}
  \hline
Year & N1 & N2 & N3 & MMB \\ 
  \hline
1978 & 603.46 & 4765.24 & 1885.25 & 7566.91 \\ 
  1979 & 927.42 & 7364.05 & 2882.40 & 8498.15 \\ 
  1980 & 585.24 & 4941.82 & 3940.67 & 13077.44 \\ 
  1981 & 513.21 & 4231.08 & 2981.79 & 12357.05 \\ 
  1982 & 351.93 & 2958.41 & 2448.59 & 9879.95 \\ 
  1983 & 177.65 & 1549.03 & 1718.98 & 7557.31 \\ 
  1984 & 104.42 & 897.69 & 964.60 & 4736.82 \\ 
  1985 & 146.96 & 1176.58 & 606.78 & 2688.70 \\ 
  1986 & 169.04 & 1363.06 & 694.32 & 2350.47 \\ 
  1987 & 208.23 & 1673.24 & 810.68 & 2707.59 \\ 
  1988 & 505.13 & 3948.49 & 1139.61 & 3249.40 \\ 
  1989 & 380.88 & 3159.11 & 2099.65 & 6287.45 \\ 
  1990 & 351.08 & 2879.42 & 1864.58 & 7150.68 \\ 
  1991 & 424.03 & 3414.39 & 1755.53 & 6429.83 \\ 
  1992 & 438.85 & 3563.05 & 1983.11 & 6811.45 \\ 
  1993 & 421.44 & 3440.94 & 2067.47 & 7377.80 \\ 
  1994 & 303.18 & 2534.79 & 1954.33 & 7396.83 \\ 
  1995 & 480.57 & 3820.36 & 1651.21 & 6218.77 \\ 
  1996 & 493.06 & 4002.14 & 2178.79 & 7062.58 \\ 
  1997 & 186.58 & 1687.44 & 2143.46 & 8200.06 \\ 
  1998 & 105.06 & 911.92 & 1081.33 & 5643.57 \\ 
  1999 & 284.91 & 2226.32 & 723.71 & 2941.66 \\ 
  2000 & 147.94 & 1273.91 & 1154.43 & 3689.97 \\ 
  2001 & 76.94 & 670.40 & 753.68 & 3432.80 \\ 
  2002 & 88.36 & 716.25 & 444.69 & 2067.41 \\ 
  2003 & 35.45 & 317.65 & 392.07 & 1565.28 \\ 
  2004 & 194.18 & 1495.82 & 306.86 & 1041.99 \\ 
  2005 & 225.33 & 1812.07 & 827.63 & 2159.03 \\ 
  2006 & 228.01 & 1853.85 & 1035.80 & 3429.23 \\ 
  2007 & 280.85 & 2257.82 & 1113.23 & 3845.77 \\ 
  2008 & 334.26 & 2690.68 & 1331.55 & 4419.15 \\ 
  2009 & 285.87 & 2352.60 & 1519.89 & 5275.11 \\ 
  2010 & 268.40 & 2197.05 & 1386.96 & 5247.09 \\ 
  2011 & 232.57 & 1914.52 & 1280.11 & 4842.26 \\ 
  2012 & 136.24 & 1163.95 & 1085.01 & 4347.19 \\ 
  2013 & 104.55 & 872.62 & 713.20 & 3190.45 \\ 
  2014 & 52.95 & 461.10 & 506.17 & 2212.98 \\ 
  2015 & 232.92 & 1799.65 & 407.70 & 1400.15 \\ 
   \hline
\end{tabular}
\end{table}


Figure 1. Distribution of blue king crab *Paralithodes platypus* in the Gulf of Alaska, Bering Sea, and Aleutian Islands waters. Shown in blue.

Figure 2. King crab Registration Area Q (Bering Sea).

Figure 3. Trawl and pot-survey stations used in the SMBKC stock assessment.

Figure 4. Catches of 181 male blue king crab measuring at least 90 mm CL from the 2014 NMFS trawl-survey at the 56 stations used to assess the SMBKC stock. Note that the area north of St. Matthew Island, which includes the large catch of 67 crab at station R-24, is not represented in the ADF&G pot-survey data used in the assessment.

Figure 5. NFMS Bering Sea reporting areas. Estimates of SMBKC bycatch in the groundfish fisheries are based on NMFS observer data from reporting areas 524 and 521.

![Estimated stage-1 and stage-2 selectivities for different scenarios (the stage-3 selectivities are fixed at 1). Estimated selectivities are shown for the directed pot fishery, the trawl bycatch fishery, the fixed bycatch fishery, the NMFS trawl survey, and the ADF&G pot survey.\label{fig:selectivity}](figure/selectivity-1.png) 

![Estimated molting probabilities for stage-1 crab for different scenarios.\label{fig:molt_prob}](figure/molt_prob-1.png) 

![Comparisons of area-swept estimates of total male survey biomass and model predictions for 2016 model estimates under 18 scenarios. The error bars are plus and minus 2 standard deviations.\label{fig:trawl_survey_biomass}](figure/trawl_survey_biomass-1.png) 

![Comparisons of total male pot survey CPUEs and model predictions for 2016 model estimates under 9 scenarios without additional CV for the pot survey CPUE. The error bars are plus and minus 2 standard deviations of scenario 10. Comparisons of area-swept estimates of total male survey biomasses and model predictions for 2015 model estimates under 18 scenarios. The error bars are plus and minus 2 standard deviations.\label{fig:pot_survey_cpue}](figure/pot_survey_cpue-1.png) 

Figure 11b. Comparisons of total male pot survey CPUEs and model predictions for 2015 model estimates under 7 scenarios with additional CV for the pot survey CPUE. The error bars are plus and minus 2 standard deviations of scenario 9.

Figure 12(3). Standardized residuals for total trawl survey biomass for scenario 3.

Figure 12(8). Standardized residuals for total trawl survey biomass for scenario 8.

Figure 13(3). Bubble plots of residuals of stage compositions for scenario 3 for St. Mathew Island blue king crab. Empty circles indicate negative residuals, filled circles indicate positive residuals, and differences in bubble size indicate relative differences in the magnitude of residuals. Upper, middle, and lower plots are trawl survey, pot survey, and observer data.

![Comparison of observed and model predicted retained catch and bycatches with scenario 10.\label{fig:fit_to_catch}](figure/fit_to_catch-1.png) 

![Estimated recruitment time series during 1979-2015 with 18 scenarios. Estimated recruitment time series ($R_t$) in the OneSex, TwoSex and BBRKC models. Note that recruitment in the OneSex model represents recruitment of males only.\label{fig:recruitment}](figure/recruitment-1.png) 

![Estimated mature male biomass time series on Feb. 15 during 1978-2015 with 18 scenarios. Mature male biomass (MMB) predicted in the two versions of the Gmacs model (OneSex and TwoSex) and the Zheng model.\label{fig:mmb}](figure/mature_male_biomass-1.png) 

Figure 17. Retrospective plot of model-estimated mature male biomass for 2015 model scenario 10 (top panel) on Feb. 15 and scenario 10-4 (bottom panel) at time of survey with terminal years 2007-2015. Estimates are based on all available data up to and including terminal-year trawl and pot surveys.



![Observed and model estimated size-frequencies of male BBRKC by year retained in the directed pot fishery.\label{fig:sc_pot_m}](figure/sc_pot_m-1.png) 

![Observed and model estimated size-frequencies of discarded male BBRKC by year in the directed pot fishery.\label{fig:sc_pot_discarded_m}](figure/sc_pot_discarded_m-1.png) 

![Observed and model estimated size-frequencies of discarded female BBRKC by year in the directed pot fishery.\label{fig:sc_pot_discarded_f}](figure/sc_pot_discarded_f-1.png) 

![Relationship between carapace width (mm) and weight (kg) by sex in each of the models (provided as a vector of weights at length to Gmacs so lines all overlap).\label{fig:length-weight}](figure/length_weight-1.png) 

![Distribution of carapace width (mm) at recruitment.\label{fig:init_rec}](figure/init_rec-1.png) 

![Growth increment (mm) each molt by sex in the OneSex and TwoSex models.\label{fig:growth_inc}](figure/growth_inc-1.png) 

![Growth transitions.\label{fig:growth_trans}](figure/growth_trans-1.png) 

![Size transitions.\label{fig:size_trans}](figure/size_trans-1.png) 

![Numbers at length in 1953, 1975 and 2014 in each of the models. The first year of the OneSex model is 1953. The first year of the Zheng and TwoSex models in 1975.\label{fig:init_N}](figure/init_N-1.png) 

![Time-varying natural mortality ($M_t$). Periods begin at 1976, 1980, 1985 and 1994.\label{fig:M_t}](figure/natural_mortality-1.png) 


\newpage

# Appendix A: SMBKC Model Description

## 1. Introduction

The model accounts only for male crab at least 90 mm in carapace length (CL). These are partitioned into three stages (male size classes) determined by CL measurements of (1) 90-104 mm, (2) 105-119 mm, and (3) 120+ mm. For management of the St. Matthew Island blue king crab (SMBKC) fishery, 120 mm CL is used as the proxy value for the legal measurement of 5.5 in carapace width (CW), whereas 105 mm CL is the management proxy for mature-male size (5 AAC 34.917 (d)). Accordingly, within the model only stage-3 crab are retained in the directed fishery, and stage-2 and stage-3 crab together comprise the collection of mature males. Some justification for the 105 mm value is presented in Pengilly and Schmidt (1995), who used it in developing the current regulatory SMBKC harvest strategy. The term “recruit” here designates recruits to the model, i.e., annual new stage-1 crab, rather than recruits to the fishery. The following description of model structure reflects the base-model configuration.

## 2. Model Population Dynamics

Within the model framework, the beginning of the crab year is assumed contemporaneous with the NMFS trawl survey, nominally assigned a date of July 1. With boldface letters indicating vector quantities, let $\boldsymbol{N}_t = \left[ N_{1,t}, N_{2,t}, N_{3,t} \right]^\top$ designate the vector of stage abundances at the start of year $t$. Then the basic population dynamics underlying model construction are described by the linear equation

$$\boldsymbol{N}_{t+1} = \boldsymbol{G} e^{-M_t} \boldsymbol{N}_t + \boldsymbol{N}^\text{new}_{t+1}$$

where the scalar factor $e^{-M_t}$ accounts for the effect of year-t natural mortality $M_t$ and the
hypothesized transition matrix $\boldsymbol{G}$ has the simple structure

\begin{equation}
  \boldsymbol{G} = \left[ \begin{array}{ccc}
    1 - \pi_{12} & \pi_{12} & 0 \\
    0 & 1 - \pi_{23} & \pi_{23} \\
    0 & 0 & 1 \end{array} \right]
\end{equation}

with $\pi_{jk}$ equal to the proportion of stage-j crab that molt and grow into stage k from any one year to the next. The vector $N newt+1 = [ N new 1 , t+1 , 0 ,0 ] T$ registers the number $N new1, t+1$ of new crab, or "recruits", entering the model at the start of year $t+1$, all of which are assumed to go into stage 1. Aside from natural mortality and molting and growth, only the directed fishery and some limited bycatch mortality in the groundfish fisheries are assumed to affect the stock. Nontrivial bycatch mortality with another fishery, as occurred in 2012/13, is assumed to be accounted for in the model in the estimate of groundfish bycatch mortality.) The directed fishery is modeled as a mid-season pulse occurring at time $\pi_t$ with full-selection fishing mortality $F_t$ relative to stage-3 crab. Year-t directed-fishery removals from the stock are computed as

$$R^{df}_t = H^{df} S^{df} (1 - e^{F^{df}_t}) e^{-\tau_t M} N_t$$

\newpage

# K. References

---
title: "Saint Matthew Island Blue King Crab Stock Assessment 2016"
author:
- D'Arcy Webber
- Jie Zheng
- James Ianelli
institute: "Quantifish, ADF&G, NOAA"
date: "May 2016"
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

2. **Catches**: Peak historical harvest was 4288 tonnes (9.454 million pounds) in 1983/84^[1983/84 refers to a fishing year that extends from 1 July 1983 to 30 June 1984.]. The fishery was closed for 10 years after the stock was declared overfished in 1999. Fishing resumed in 2009/10 with a fishery-reported retained catch of 209 tonnes (0.461 million pounds), less than half the 529.3 tonnes (1.167 million pound) TAC. Following three more years of modest harvests supported by a fishery catch per unit effort (CPUE) of around 10 crab per pot lift, the fishery was again closed in 2013/14 due to declining trawl-survey estimates of abundance and concerns about the health of the stock. The directed fishery resumed again in 2014/15 with a TAC of 300 tonnes (0.655 million pounds), but the fishery performance was relatively poor with a retained catch of 140 tonnes (0.309 million pounds).

3. **Stock biomass**: Following a period of low numbers after the stock was declared overfished in 1999, trawl-survey indices of SMBKC stock abundance and biomass generally increased in subsequent years, with survey estimated mature male biomass reaching 9516 tonnes (20.98 million pounds; CV = 0.55) in 2011, the second highest in the 37-year time series used in this assessment. Survey mature male biomass then declined to 5652 tonnes (12.46 million pounds; CV = 0.33) in 2012 and to 2202 tonnes (4.459 million pounds; CV = 0.22) in 2013 before going back up to 5472 tonnes (12.06 million pounds; CV = 0.44) in 2014 and 5134 tonnes (11.32 million pounds; CV = 0.76).

4. **Recruitment**: Because little information about the abundance of small crab is available for this stock, recruitment has been assessed in terms of the number of male crab within the 90-104 mm CL size class in each year. The 2013 trawl-survey area-swept estimate of 0.335 million male SMBKC in this size class marked a three-year decline and was the lowest since 2005. That decline did not continue as the 2014 survey estimate is 0.723 million. The survey recruitment is 0.992 million in 2015, but the majority of this survey estimate is from one tow with a great deal of uncertainty.

5. **Management performance**: In recent assessments, estimated total male catch has been determined as the sum of fishery-reported retained catch, estimated male discard mortality in the directed fishery, and estimated male bycatch mortality in the groundfish fisheries, as these have been the only sources of non-negligible fishing mortality to consider.

\begin{table}[ht]
\centering
\caption{Status and catch specifications (1000 tonnes) (scenario 1). MSST is minimum stock-size threshold, MMB is mature male biomass, TAC is total allowable catch, OFL is over fishing limit, ABC is the annual b catch.} 
\label{tab:status}
\begin{tabular}{lrrrrrrr}
  \hline
Year & MSST & Biomass (MMB) & TAC & Retained catch & Total male catch & OFL & ABC \\ 
  \hline
2011/12 & 1.50 & 5.03 & 1.15 & 0.85 & 0.95 & 1.70 & 1.54 \\ 
  2012/13 & 1.80 & 2.85 & 0.74 & 0.73 & 0.82 & 1.02 & 0.92 \\ 
  2013/14 & 1.50 & 3.01 & 0.00 & 0.00 & 0.00 & 0.56 & 0.45 \\ 
  2014/15 & 1.86 & 2.48 & 0.30 & 0.14 & 0.15 & 0.43 & 0.34 \\ 
  2015/16 &  & 2.45 &  &  &  & 0.28 & 0.22 \\ 
   \hline
\end{tabular}
\end{table}

The stock was above the minimum stock-size threshold (MSST) in 2014/15 and is hence not overfished. Overfishing did not occur in 2014/15.

6. **Basis for the OFL**: Estimated mature-male biomass (MMB) on 15 February is used as the measure of biomass for this Tier 4 stock, with males measuring 105 mm CL or more considered mature. The $B_\mathit{MSY}$ proxy is obtained by averaging estimated $MMB$ over a specific reference time period, and current CPT/SSC guidance recommends using the full assessment time frame as the default reference period.


# A. Summary of Major Changes

## Changes in Management of the Fishery

There are no new changes in management of the fishery.

## Changes to the Input Data

All of the time series used in this assessment have been updated to include the most recent fishery and survey results. This assessment makes use of an updated full trawl-survey time series supplied by R. Foy in August 2015, updated groundfish bycatch estimates based on 1999-2014 NMFS AKRO data also supplied by R. Foy, and the ADF&G pot survey data in 2015.

## Changes in Assessment Methodology

This assessment is done using Gmacs. The model is based upon the 3-stage length-based assessment model first presented in May 2011 by Bill Gaeuman and accepted by the CPT in May 2012. There are several differences between the Gmacs assessment and the previous model. One of the major differences being that natural and fishing mortality are continuous within any number of discrete seasons. Season length in Gmacs is controlled simply by changing the proportion of natural mortality that is applied during each season. For example, in this assessment four seasons are defined and the proportion of natural mortality that is applied each season is 0, 0.44, 0.185, and 0.375 in the final season. In Gmacs the proportion of natural mortality that is applied each season is fixed (i.e. it can not change from year to year). The previous model allowed the proportion of natural mortality to change seasonally each year (i.e. during the second season natural mortality ranged from 0.05 to 0.18 before the year 2000 and was constant at 0.44 after 2000).

In Gmacs the size transition matrix is a combination of the growth matrix and the molting probability. The growth matrix is derived from empirical molt increment data and the molting probability for each size class in the model is derived from an inverse logistic curve. Put simply, Gmacs does not allow the user to specify the size transition matrix directly, thus getting our size transition matrix to match that used in the previous model exactly was not possible. However, it is close:

\begin{equation}
  \left[ \begin{array}{ccc}
    0.2056 & 0.6799 & 0.1144 \\
    0 & 0.3963 & 0.6037 \\
    0 & 0 & 1 \end{array} \right]
\end{equation}

Also see Figure \ref{fig:size_trans}. Further details of the Gmacs model and configuration used are provided in Appendix A (SMBKC Model Description).

## Changes in Assessment Results

Changes in assessment results depend on model scenario. The Gmacs base model scenario attempts to match the 2015 assessment by specifying the same (or similar) dynamics and parameter values. However, a different Gmacs scenario (Gmacs selex) provides a much better match to the 2015 model assessment.


# B. Responses to SSC and CPT Comments

## CPT and SSC Comments on Assessments in General

Spring 2016 CPT

Comment: *comments*

Response:

## CPT and SSC Comments Specific to SMBKC Stock Assessment

Spring 2016 CPT

Comment: *comments*

Response:


# C. Introduction

## Scientific Name

The blue king crab is a lithodid crab, *Paralithodes platypus* (Brant 1850).

## Distribution

Blue king crab are sporadically distributed throughout the North Pacific Ocean from Hokkaido, Japan, to southeastern Alaska (Figure \ref{fig:distribution}). In the eastern Bering Sea small populations are distributed around St. Matthew Island, the Pribilof Islands, St. Lawrence Island, and Nunivak Island. Isolated populations also exist in some other cold water areas of the Gulf of Alaska (NPFMC 1998). The St. Matthew Island Section for blue king crab is within Area Q2 (Figure \ref{fig:registration_area}), which is the Northern District of the Bering Sea king crab registration area and includes the waters north of Cape Newenham (58°39’ N. lat.) and south of Cape Romanzof (61°49’ N. lat.).

![Distribution of blue king crab (*Paralithodes platypus*) in the Gulf of Alaska, Bering Sea, and Aleutian Islands waters (shown in blue).\label{fig:distribution}](figure/Fig1.png)

![King crab Registration Area Q (Bering Sea).\label{fig:registration_area}](figure/Fig2.png)

## Stock Structure

The Alaska Department of Fish and Game (ADF&G) Gene Conservation Laboratory division has detected regional population differences between blue king crab collected from St. Matthew Island and the Pribilof Islands^[NOAA grant Bering Sea Crab Research II, NA16FN2621, 1997.]. NMFS tag-return data from studies on blue king crab in the Pribilof Islands and St. Matthew Island support the idea that legal-sized males do not migrate between the two areas (Otto and Cummiskey 1990). St. Matthew Island blue king crab tend to be smaller than their Pribilof conspecifics, and the two stocks are managed separately.

## Life History

Like the red king crab, *Paralithodes camtshaticus*, the blue king crab is considered a shallow water species by comparison with other lithodids such as golden king crab, *Lithodes aequispinus*, and the scarlet king crab, *Lithodes couesi* (Donaldson and Byersdorfer 2005). Adult male blue king crab are found at an average depth of 70 m (NPFMC 1998). The reproductive cycle appears to be annual for the first two reproductive cycles and biennial thereafter (cf. Jensen and Armstrong 1989) and mature crab seasonally migrate inshore where they molt and mate. Unlike red king crab, juvenile blue king crab do not form pods, but instead rely on cryptic coloration for protection from predators and require suitable habitat such as cobble and shell hash. Somerton and MacIntosh (1983) estimated SMBKC male size at sexual maturity to be 77.0 mm carapace length (CL). Paul et al. (1991) found that spermatophores were present in the vas deferens of 50% of the St. Matthew Island blue king crab males examined with sizes of 40-49 mm CL and in 100% of the males at least 100 mm CL. Spermataphore diameter also increased with increasing CL with an asymptote at ~ 100 mm CL. They noted, however, that although spermataphore presence indicates physiological sexual maturity, it may not be an indicator of functional sexual maturity. For purposes of management of the St. Matthew Island blue king crab fishery, the State of Alaska uses 105 mm CL to define the lower size bound of functionally mature males (Pengilly and Schmidt 1995). Otto and Cummiskey (1990) report an average growth increment of 14.1 mm CL for adult SMBKC males.

## Management History

The SMBKC fishery developed subsequent to baseline ecological studies associated with oil exploration (Otto 1990). Ten U.S. vessels harvested 545 tonnes (1.202 million pounds) in 1977, and harvests peaked in 1983 when 164 vessels landed 4288 tonnes (9.454 million pounds) (Fitch et al. 2012; Table 1XX). The fishing seasons were generally short, often lasting only a few days. The fishery was declared overfished and closed in 1999 when the stock biomass estimate was below the minimum stock-size threshold (MSST) of 4990 tonnes (11.0 million pounds) as defined by the Fishery Management Plan for the Bering Sea/Aleutian Islands King and Tanner crabs (NPFMC 1999). Zheng and Kruse (2002) hypothesized a high level of SMBKC natural mortality from 1998 to 1999 as an explanation for the low catch per unit effort (CPUE) in the 1998/99 commercial fishery and the low numbers across all male crab size groups caught in the annual NMFS eastern Bering Sea trawl survey from 1999 to 2005 (Table XX2a). In November 2000, Amendment 15 to the FMP for Bering Sea/Aleutian Islands king and Tanner crabs was approved to implement a rebuilding plan for the SMBKC stock (NPFMC 2000). The rebuilding plan included a regulatory harvest strategy (5 AAC 34.917), area closures, and gear modifications. In addition, commercial crab fisheries near St. Matthew Island were scheduled in fall and early winter to reduce the potential for bycatch mortality of vulnerable molting and mating crab.

NMFS declared the stock rebuilt on 21 September 2009, and the fishery was reopened after a 10-year closure on 15 October 2009 with a TAC of 529 tonnes (1.167 million pounds), closing again by regulation on 1 February 2010. Seven participating vessels landed a catch of 209 tonnes (460859 pounds) with a reported effort of 10697 pot lifts and an estimated CPUE of 9.9 retained individual crab per pot lift. The fishery remained open the next three years with modest harvests and similar CPUE, but large declines in the NMFS trawl-survey estimate of stock abundance raised concerns about the health of the stock, prompting ADF&G to close the fishery again for the 2013/14 season. Due to abundance an above thresholds, the fishery was reopened for the 2014/15 season with a low TAC of 297 tonnes (0.655 million pounds) and in 2015/16 the TAC was further reduced to 186 tonnes (0.411 million pounds).

Though historical observer data are limited due to very limited sampling, bycatch of female and sublegal male crab from the directed blue king crab fishery off St. Matthew Island was relatively high historically, with estimated total bycatch in terms of number of crab captured sometimes more than twice as high as the catch of legal crab (Moore et al. 2000; ADF&G Crab Observer Database). Pot-lift sampling by ADF&G crab observers (Gaeuman 2013; ADF&G Crab Observer Database) indicates similar bycatch rates of discarded male crab since the reopening of the fishery (Table 3XX), with total male discard mortality in the 2012/13 directed fishery estimated at about 12% (88 tonnes or 0.193 million pounds) of the reported retained catch weight, assuming 20% handling mortality. On the other hand, these same data suggest a significant reduction in the bycatch of females, which may be attributable to the later timing of the contemporary fishery and the more offshore distribution of fishery effort since reopening in 2009/10^[D. Pengilly, ADF&G, pers. comm.]. Some bycatch of discarded blue king crab has also been observed historically in the eastern Bering Sea snow crab fishery, but in recent years it has generally been negligible, and observers recorded no bycatch of blue king crab in sampled pot lifts during 2013/14. The St. Matthew Island golden king crab fishery, the third commercial crab fishery to have taken place in the area, typically occurred in areas with depths exceeding blue king crab distribution. NMFS observer data suggest that variable but mostly limited SMBKC bycatch has also occurred in the eastern Bering Sea groundfish fisheries (Table 5XX).


# D. Data

## Summary of New Information

Data used in this assessment have been updated to include the most recently available fishery and survey numbers. In addition, this assessment makes use of an updated trawl-survey time series provided by R. Foy in August 2015, as well as updated 1993-2014 groundfish bycatch estimates based on AKRO data also supplied by R. Foy. The data extent and availability used in each of the Gmacs models is shown in Figure \ref{fig:data_extent}).

![Data extent for the SMBKC assessment.\label{fig:data_extent}](figure/data_extent-1.png)

## Major Data Sources

Major data sources used in this assessment include annual directed-fishery retained-catch statistics from fish tickets (1978/79-1998/99, 2009/10-2012/13, and 2014/15; Table 1XX); results from the annual NMFS eastern Bering Sea trawl survey (1978-2015; Table 2XX); results from the triennial ADF&G SMBKC pot survey (every third year during 1995-2013) and 2015 pot survey (Table \ref{tab:stage_cpue}); size-frequency information from ADF&G crab-observer pot-lift sampling (1990/91-1998/99, 2009/10-2012/13, and 2014/15; Table XX3); and NMFS groundfish-observer bycatch biomass estimates (1992/93-2014/15; Table XX5). Figure \ref{fig:stations} maps stations from which SMBKC trawl-survey and pot-survey data were obtained. Further information concerning the NMFS trawl survey as it relates to commercial crab species is available in Daly et al. (2014); see Gish et al. (2012) for a description of ADF&G SMBKC pot-survey methods. It should be noted that the two surveys cover different geographic regions and that each has in some years encountered proportionally large numbers of male blue king crab in areas where the other is not represented (Figure \ref{fig:catch181}). Crab-observer sampling protocols are detailed in the crab-observer training manual (ADF&G 2013). Groundfish SMBKC bycatch data come from NMFS Bering Sea reporting areas 521 and 524 (Figure \ref{fig:reporting_areas}). Note that for this assessment the newly available NMFS groundfish observer data reported by ADF&G statistical area was not used.

![Trawl and pot-survey stations used in the SMBKC stock assessment.\label{fig:stations}](figure/Fig3.png)

\begin{table}[ht]
\centering
\caption{Size-class and total CPUE (90+ mm CL) with estimated CV and total number of captured crab (90+ mm CL) from the 96 common stations surveyed during the six triennial ADF\&G SMBKC pot surveys. Source: D. Pengilly and R. Gish, ADF\&G.} 
\label{tab:stage_cpue}
\begin{tabular}{rrrrrrr}
  \hline
Year & Stage-1 (90-104 mm) & Stage-2 (105-119 mm) & Stage-3 (120+ mm) & Total CPUE & CV & Number of crabs \\ 
  \hline
1995 & 1.919 & 3.198 & 6.922 & 12.042 & 0.13 & 4624 \\ 
  1998 & 0.964 & 2.763 & 8.804 & 12.531 & 0.06 & 4812 \\ 
  2001 & 1.266 & 1.737 & 5.487 & 8.477 & 0.08 & 3255 \\ 
  2004 & 0.112 & 0.414 & 1.141 & 1.667 & 0.15 & 640 \\ 
  2007 & 1.086 & 2.721 & 4.836 & 8.643 & 0.09 & 3319 \\ 
  2010 & 1.326 & 3.276 & 5.607 & 10.209 & 0.13 & 3920 \\ 
  2013 & 0.878 & 1.398 & 3.367 & 5.643 & 0.19 & 2167 \\ 
  2015 & 0.198 & 0.682 & 1.924 & 2.805 & 0.18 & 1077 \\ 
   \hline
\end{tabular}
\end{table}

## Other Data Sources

As with the most recent model configuration developed for this assessment, this version makes use of a growth transition matrix based on Otto and Cummiskey (1990). Other relevant data sources, including assumed population and fishery parameters, are presented in Appendix A, which provides a detailed description of the Gmacs model configuration used for this assessment.

## Excluded Data Sources

Groundfish bycatch size-frequency data are available for selected years. These data were used in model-based assessments prior to 2011. However, they have since been excluded because these data tend to be severely limited: for example, 2012/13 data include a total of just 4 90-mm+ CL male blue king crab from reporting areas 521 and 524.


# E. Analytic Approach

## History of Modeling Approaches for this Stock

A four-stage catch-survey-analysis (CSA) assessment model was used before 2011 to estimate abundance and biomass and prescribe fishery quotas for the SMBKC stock (2010 SAFE; Zheng et al. 1997). The four-stage CSA is similar to a full length-based analysis, the major difference being coarser length groups, which are more suited to a small stock with consistently low survey catches. In this approach, the abundance of male crab with a CL of 90 mm or above is modeled in terms of four crab stages: stage 1: 90-104 mm CL; stage 2: 105-119 mm CL; stage 3: newshell 120-133 mm CL; and stage 4: oldshell $\ge$ 120 mm CL and newshell $\ge$ 134 mm CL. Motivation for these stage definitions comes from the fact that for management of the SMBKC stock, male crab measuring at least 105 mm CL are considered mature, whereas 120 mm CL is considered a proxy for the legal size of 5.5 in carapace width, including spines. Additional motivation for these stage definitions comes from an estimated average growth increment of about 14 mm per molt for SMBKC (Otto and Cummiskey 1990).

Concerns about the pre-2011 assessment model led to the CPT and SSC recommendations that included development of an alternative model with provisional assessment based on survey biomass or some other index of abundance. An alternative 3-stage model was proposed to the CPT in May 2011 but was requested to proceed with a survey-based approach for the Fall 2011 assessment. In May 2012 the CPT approved a slightly revised and better documented version of the alternative model for assessment.

The 2015 SMBKC stock assessment model, first used in Fall 2012, was a variant of the previous four-stage SMBKC CSA model and similar in complexity to that described by Collie et al. (2005). Like the earlier model, it considered only male crab at least 90 mm in CL, but it combined stages 3 and 4 of the earlier model resulting in just three stages (male size classes) determined by CL measurements of (1) 90-104 mm, (2) 105-119 mm, and (3) 120 mm+ (i.e., 120 mm and above). This consolidation was driven by concern about the accuracy and consistency of shell-condition information, which had been used in distinguishing stages 3 and 4 of the earlier model.

## Assessment Methodology

The 2016 SMBKC assessment model makes use of the modeling framework Gmacs. The aim when developing this model was to provide a fit to the data that best matched the 2015 SMBKC stock assessment model. A detailed description of the Gmacs model and its implementation is presented in Appendix A.

## Model Selection and Evaluation

Four different Gmacs model scenarios were considered. In this document results from these models and the 2015 model are compared.

1. **2015 Model**: model output from 2015 provided by Jie.

2. **Gmacs base**: tries to match as closely as possible the 2015 Model.

3. **Gmacs selex**: directed pot, NMFS trawl survey and ADF&G pot survey selectivities are estimated for stage-1 and stage-2 crab.

4. **Gmacs CV**: additional CV is estimated for the ADF&G pot survey as well as estimating the directed pot, NMFS trawl survey and ADF&G pot survey selectivities for stage-1 and stage-2 crab.

5. **Gmacs M**: natural mortality ($M$) is fixed at 0.18 $yr^{-1}$ during all years as well as estimating the directed pot, NMFS trawl survey and ADF&G pot survey selectivities for stage-1 and stage-2 crab.

## Results

Preliminary results for the Gmacs configuration are provided here with comparisons to the 2015 model.

a. Effective sample sizes.

Observed and estimated effective sample sizes are compared in Table XX.

b. Tables of estimates.

Model parameter estimates are summarized in Tables \ref{tab:est_pars_base}, \ref{tab:est_pars_selex}, \ref{tab:est_pars_cv}, and \ref{tab:est_pars_M}. Negative log likelihood values and management measures for the four Gmacs scenarios are compared in Table \ref{tab:likelihood_components}. Estimated abundances by stage and mature male biomasses for three of the scenarios are listed in Tables \ref{tab:pop_abundance_2015}, \ref{tab:pop_abundance_base}, and \ref{tab:pop_abundance_selex}.

The scenarios that estimated selectivities fit the data better. Scenarios with additional CV for the pot survey CPUE fit the trawl survey data better and result in higher abundance and biomass estimates in most recent years. Estimated directed pot and trawl survey selectivities > 1.0 for stage-2 crab are also troublesome.

c. Graphs of estimates.

Estimated (and fixed) selectivities are compared in Figure \ref{fig:selectivity} and molting probabilities are shown in Figure \ref{fig:molt_prob}. The various model fits to total male ($>$ 89 mm CL) trawl survey biomass are compared in Figure \ref{fig:trawl_survey_biomass}, and the fits to pot survey CPUE are compared in Figure \ref{fig:pot_survey_cpue}. Standardized residuals of total male trawl survey biomass and pot survey CPUE are plotted in Figure \ref{fig:bts_resid}. Fits to stage compositions for trawl survey, pot survey, and commercial observer data are shown in Figures \ref{fig:sc_pot}, \ref{fig:sc_pot_discarded}, and \ref{fig:sc_trawl_discarded} for the all scenarios. Bubble plots of stage composition residuals for trawl survey, pot survey, and commercial observer data are shown in Figures \ref{fig:sc_pot_res}, \ref{fig:sc_pot_discarded_res}, and \ref{fig:sc_trawl_discarded_res} for the Gmacs base model. Fits to retained catch biomass and bycatch death biomass are shown for all Gmacs scenarios in Figure \ref{fig:fit_to_catch}. Estimated recruitment and mature male biomass are compared in Figures \ref{fig:recruitment} and \ref{fig:mmb}, respectively.

d. Graphic evaluation of the fit to the data.

Model estimated relative survey biomasses are different in each of the scenarios. The Gmacs base model has a comparatively low biomass in the early years compared with the other scenarios, including the 2015 model (Figure \ref{fig:trawl_survey_biomass}). The Gmacs CV scenario that includes additional CV for the pot survey CPUE results in much higher biomass estimates in recent years (Figure \ref{fig:trawl_survey_biomass}). Estimated pot survey CPUEs are also dependent on scenarios, and the difference among scenarios are very similar to the relative survey biomasses (Figure \ref{fig:pot_survey_cpue}).

There are strong temporal patterns for residuals of total trawl survey biomass and stage composition data for scenarios T, 0, 00, 1, 2, and 3 (showing only scenario 3), and no apparent residual patterns occur for other scenarios with two levels of trawl selectivities or molting probabilities over time (Figures XX and XX). The stage compositions for observer data were not fit very well before 2000 for all scenarios, because the data are low quality and effective sample size is assumed small accordingly. The absolute values of standardized residuals of survey biomass are relatively small for scenarios 10-4, 10-3, 10-2, and 10-0 than those for scenario 10 (Figure XX). All scenarios fit well to retained catch biomass and fits to bycatch biomass are generally good.

Estimated recruitment to the model is variable over time (Figure \ref{fig:recruitment}). Estimated recruitment during recent years is generally low in all scenarios. Estimated mature male biomasses on 15 February also fluctuates strongly over time; the high biomass estimates in recent years for the Gmacs CV scenario is quite different to the other scenarios (Figure \ref{fig:mmb}).

e. Retrospective and historic analyses.

Gmacs can not do retrospective analysis yet.

f. Uncertainty and sensitivity analyses.

Estimated standard deviations of parameters for the four Gmacs scenarios are summarized in Tables \ref{tab:est_pars_base}, \ref{tab:est_pars_selex}, \ref{tab:est_pars_cv}, and \ref{tab:est_pars_M}. Probabilities for mature male biomass and OFL in 2015 are illustrated in section “F. Calculation of the OFL”.

g. Comparison of alternative model scenarios.

Among the 20 scenarios, scenario T was used in 2014 and scenarios 0, 00, and 1 have some corrections and some modifications to scenario T. The results among scenarios T, 0, 00 and 1 do not have large differences, and strong temporal residual patterns occur for both survey biomass and stage composition data. Scenarios 2 and 3 are similar, and with an additional CV for the pot survey CPUE, these two scenarios result in not only strong temporal residual patterns but also an opposite trend of biomass relative to the pot survey CPUE during recent years. Scenarios 4 - 7 have either different molting probabilities or trawl survey selectivities for two periods, thus solving the problems of temporal residual patterns. However, with an additional CV for the pot survey CPUE, scenarios 4-7 also down weight the pot survey data and result in biomass estimates quite different from the pot survey CPUE during recent years. With the poor performance of the commercial fishery during 2014/15 season and the trawl survey issue in station R-24 in 2015, the low pot survey CPUE in 2015 seems to be more reasonable than the high abundance estimated by the trawl survey in 2015. Scenario 9 has the same problem with scenarios 4 - 7, but with different pot survey selectivities for two periods, it fits the pot survey data better than scenarios 4 - 7.

Considering all the problems for scenarios T - 7 and 9 above, we would consider only the remaining scenarios for overfishing/overfished determination. With two different molting probabilities for two periods and without an additional CV for the pot survey CPUE, Scenario 8 has no temporal residual pattern issue and fits the data reasonable well. If we think that change in molting probability between two periods is real, then our choice will be scenario 8. However, it seems easier to explain the change in survey selectivities than molting probability over time and scenario 10 fits the data better than scenario 8 (Table 10XX). Therefore, scenario 10 is a better choice than scenario 8. Scenario 11 shows the annual change in trawl survey selectivities over time and fits the data well. Considering there are 35 more estimated parameters with scenario 11 than with scenario 10, statistically, scenario 10 fits the data better than scenario 11 (Table 10XX).

We also used the Gmacs CV scenario to show the impact of estimating an additional CV parameter for the pot survey CPUE. The reduction of trawl survey CPUE in station R-24 results in lower biomass estimates during recent years with scenarios 9-4 and 9-0 than with scenario 9 (Figures 21XX and 22XX).

Among scenarios 10-4, 10-3, 10-2 and 10-0, completely throwing out the data in R-24 provides an interesting comparison but seems not a valid option. Therefore, we will eliminate scenario 10-0 for consideration for overfishing/overfished determination. Choice among scenarios 10-4, 10-3, and 10-2 depends on high density area definition in station R-24. Based on Table 7, it seems more reasonable to define 40% of pot survey stations as high density area rather than 20% or 30%. So, we select scenario 10-4 as an option to compare with scenario 10. Estimates of biomass and OFL are almost the same between these two scenarios, primarily due to the pot survey data in 2015 and change in trawl survey biomass CV estimates between them. Without the pot survey in 2015, the difference exists as shown in the retrospective analysis (Figures 17 and 18). The fit to data other than the trawl survey data is slightly better with scenario 10-4 than with scenario 10 (Table 10). Estimated trawl survey selectivities during 2000-2015 are lower for scenario 10-4 than scenario 10 (Figures 8XX and 9XX; Table 9XX). Although both scenario 10 and 10-4 are a good choice for using for overfishing/overfished determination, we would prefer scenario 10-4 over scenario 10, based on the reasons above.

The remaining question is what causes the trawl survey selectivities greater than 1 when selecting scenario 10 or scenario 10-4. Since we assume trawl survey catchability to be 1, the trawl survey selectivities are a combination of the catchability and selectivities. If the catchability is greater than 1, then selectivities can be less than 1. Trawl survey catchability was estimated to be greater than 1 in the past for this stock (Collie et al. 2005). During our past modeling experience with this stock, the catchability would be greater than 1 if estimated in the model like Collie et al. (2005). The spatial distribution of blue king crab around the island and the systematic design of survey stations may be the reason for catchability greater than 1. The area-swept estimate of abundance in station R-24 is an example for abundance overestimation. Much more field work may be needed to completely answer this question.

In summary, we recommend scenario 10-4 be used for overfishing/overfished determination for this stock in 2015. The CPT selected scenario 1 in September 2015.


# F. Calculation of the OFL and ABC

The overfishing level (OFL) is the fishery-related mortality biomass associated with fishing mortality $F_\mathit{OFL}$. The SMBKC stock is currently managed as Tier 4 (2013 SAFE), and only a Tier 4 analysis is presented here. Thus given stock estimates or suitable proxy values of $B_\mathit{MSY}$ and $F_\mathit{MSY}$, along with two additional parameters $\alpha$ and $\beta$, $F_\mathit{OFL}$ is determined by the control rule

\begin{align}
    F_\mathit{OFL} &= 
    \begin{cases}
        F_\mathit{MSY}, &\text{ when } B/B_\mathit{MSY} > 1\\
        F_\mathit{MSY} \frac{\left( B/B_\mathit{MSY} - \alpha \right)}{(1 - \alpha)}, &\text{ when } \beta < B/B_\mathit{MSY} \le 1
    \end{cases}\\
    F_\mathit{OFL} &< F_\mathit{MSY} \text{ with directed fishery } F = 0, \text{ when } B/B_\mathit{MSY} \le \beta \notag
\end{align}

where $B$ is quantified as mature-male biomass (MMB) at mating with time of mating assigned a nominal date of 15 February. Note that as $B$ itself is a function of the fishing mortality $F_\mathit{OFL}$, in case b) numerical approximation of $F_\mathit{OFL}$ is required. As implemented for this assessment, all calculations proceed according to the model equations given in Appendix A. In particular, the OFL catch is computed using equations A3, A4, and A5, with $F_\mathit{OFL}$ taken to be full-selection fishing mortality in the directed pot fishery and groundfish trawl and fixed-gear fishing mortalities set at their model geometric mean values over years for which there are data-based estimates of bycatch-mortality biomass.

The currently recommended Tier 4 convention is to use the full assessment period, currently 1978-2015, to define a $B_\mathit{MSY}$ proxy in terms of average estimated MMB and to put $\gamma$ = 1.0 with assumed stock natural mortality $M$ = 0.18 $\text{yr}^{-1}$ in setting the $F_\mathit{MSY}$ proxy value $\gamma M$. The parameters $\alpha$ and $\beta$ are assigned their default values $\alpha$ = 0.10 and $\beta$ = 0.25. The $F_\mathit{OFL}$, OFL, and MMB in 2015 for 18 scenarios are summarized in Table 10XX. ABC is 80% of the OFL.

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

We thank the Crab Plan Team, Doug Pengilly for reviewing the earlier draft of this manuscript. Some materials in the report are from the SAFE report prepared by Bill Gaeuman in 2014.

# K. References

Alaska Department of Fish and Game (ADF&G). 2013. Crab observer training and deployment manual. Alaska Department of Fish and Game Shellfish Observer Program, Dutch Harbor. Unpublished.

Collie, J.S., A.K. Delong, and G.H. Kruse. 2005. Three-stage catch-survey analysis applied to blue king crabs. Pages 683-714 [In] Fisheries assessment and management in data-limited situations. University of Alaska Fairbanks, Alaska Sea Grant Report 05-02, Fairbanks.

Daly, B., R. Foy, and C. Armistead. 2014. The 2013 eastern Bering Sea continental shelf bottom trawl survey: results for commercial crab species. NOAA Technical Memorandum, NMFS-AFSC.

Donaldson, W.E., and S.C. Byersdorfer. 2005. Biological field techniques for lithodid crabs. University of Alaska Fairbanks, Alaska Sea Grant Report 05-03, Fairbanks.

Fitch, H., M. Deiman, J. Shaishnikoff, and K. Herring. 2012. Annual management report for the commercial and subsistence shellfish fisheries of the Bering Sea, 2010/11. Pages 75-1776 [In] Fitch, H., M. Schwenzfeier, B. Baechler, T. Hartill, M. Salmon, M. Deiman, E.

Evans, E. Henry, L. Wald, J. Shaishnikoff, K. Herring, and J. Wilson. 2012. Annual management report for the commercial and subsistence shellfish fisheries of the Aleutian Islands, Bering Sea and the Westward Region’s Shellfish Observer Program, 2010/11. Alaska Department of Fish and Game, Fishery Management Report No. 12-22, Anchorage.

Fournier, D.A., H.J. Skaug, J. Ancheta, J. Ianelli, A. Magnusson, M.N. Maunder, A. Nielsen, and J. Sibert. 2012. AD Model Builder: using automatic differentiation for statistical inference of highly parameterized complex nonlinear models. Optim. Methods Softw. 27:233-249.

Francis, R.I.C.C. 2011. Data weighting in statistical fisheries stock assessment models. Can. J. Fish. Aquat. Sci. 68: 1124-1138.

Gaeuman, W.B. 2013. Summary of the 2012/13 mandatory crab observer program database for the Bering Sea/Aleutian Islands commercial crab fisheries. Alaska Department of Fish and Game, Fishery Data Series No. 13-54, Anchorage. Gish, R.K., V.A. Vanek, and D. Pengilly. 2012. Results of the 2010 triennial St. Matthew Island blue king crab pot survey and 2010/11 tagging study. Alaska Department of Fish and Game, Fishery Management Report No. 12-24, Anchorage.

Jensen, G.C. and D.A. Armstrong. 1989. Biennial reproductive cycle of blue king crab, Paralithodes platypus, at the Pribilof Islands, Alaska and comparison to a congener, P. camtschatica. Can. J. Fish. Aquat. Sci. 46: 932-940.

Moore, H., L.C. Byrne, and D. Connolly. 2000. Alaska Department of Fish and Game summary of the 1998 mandatory shellfish observer program database. Alaska Dept. Fish and Game, Commercial Fisheries Division, Reg. Inf. Rep. 4J00-21, Kodiak.

North Pacific Fishery Management Council (NPFMC). 1998. Fishery Management Plan for Bering Sea/Aleutian Islands king and Tanner crabs. North Pacific Fishery Management Council, Anchorage.

North Pacific Fishery Management Council (NPFMC). 1999. Environmental assessment/regulatory impact review/initial regulatory flexibility analysis for Amendment 11 to the Fishery Management Plan for Bering Sea/Aleutian Islands king and Tanner crabs. North Pacific Fishery Management Council, Anchorage.

North Pacific Fishery Management Council (NPFMC). 2000. Environmental assessment/regulatoryimpact review/initial regulatory flexibility analysis for proposed Amendment 15 to the Fishery Management Plan for king and Tanner crab fisheries in the Bering Sea/Aleutian Islands and regulatory amendment to the Fishery Management Plan for the groundfish fishery of the Bering Sea and Aleutian Islands area: A rebuilding plan for the St. Matthew blue king crab stock. North Pacific Fishery Management Council, Anchorage. Draft report.

North Pacific Fishery Management Council (NPFMC). 2007. Public Review Draft: Environmental assessment for proposed Amendment 24 to the Fishery Management Plan for Bering Sea and Aleutian Islands king and Tanner crabs to revise overfishing definitions. 14 November 2007. North Pacific Fishery Management Council, Anchorage.

Otto, R.S. 1990. An overview of eastern Bering Sea king and Tanner crab fisheries. Pages 9-26 [In] Proceedings of the international symposium on king and Tanner crabs. University of Alaska Fairbanks, Alaska Sea Grant Program Report 90-4, Fairbanks.

Otto, R.S., and P.A. Cummiskey. 1990. Growth of adult male blue king crab (Paralithodes platypus). Pages 245-258 [In] Proceedings of the international symposium on king and Tanner crabs. University of Alaska Fairbanks, Alaska Sea Grant Report 90-4, Fairbanks.

Paul, J.M., A. J. Paul, R.S. Otto, and R.A. MacIntosh. 1991. Spermatophore presence in relation to carapace length for eastern Bering Sea blue king crab (Paralithodes platypus, Brandt, 1850) and red king crab (P. Camtschaticus, Tilesius, 1815). J. Shellfish Res. 10: 157-163.

Pengilly, D. and D. Schmidt. 1995. Harvest Strategy for Kodiak and Bristol Bay Red king Crab and St. Matthew Island and Pribilof Blue King Crab. Alaska Department of Fish and Game, Commercial Fisheries Management and Development Division, Special Publication Number 7, Juneau.

Schirripa, M.J., C.P. Goodyear, and R.M. Methot. 2009. Testing different methods of incorporating climate data into the assessment of US West Coast sablefish. ICES Journal of Marine Science, 66: 1605–1613. Somerton, D.A., and R.A. MacIntosh. 1983. The size at sexual maturity of blue king crab, Paralithodes platypus, in Alaska. Fishery Bulletin 81: 621-828.

Wilderbuer, T., D. G. Nichol, and J. Ianelli. 2013. Assessment of the yellowfin sole stock in the Bering Sea and Aleutian Islands. Pages 619-708 in 2013 North Pacific Groundfish Stock Assessment and Fishery Evaluation Reports for 2014. North Pacific Fishery Management Council, Anchorage.

Zheng, J. 2005. A review of natural mortality estimation for crab stocks: data-limited for every stock? Pages 595-612 [In] Fisheries Assessment and Management in Data-Limited Situations. University of Alaska Fairbanks, Alaska Sea Grant Program Report 05-02, Fairbanks.

Zheng, J., and G.H. Kruse. 2002. Assessment and management of crab stocks under uncertainty of massive die-offs and rapid changes in survey catchability. Pages 367-384 [In] A.J. Paul,E.G. Dawe, R. Elner, G.S. Jamieson, G.H. Kruse, R.S. Otto, B. Sainte-Marie, T.C. Shirley, and D. Woodby (eds.). Crabs in Cold Water Regions: Biology, Management, and Economics. University of Alaska Fairbanks, Alaska Sea Grant Report 02-01, Fairbanks.

Zheng, J., M.C. Murphy, and G.H. Kruse. 1997. Application of catch-survey analysis to blue king crab stocks near Pribilof and St. Matthew Islands. Alaska Fish. Res. Bull. 4:62-74.


\newpage\clearpage

Table 1XX. The 1978/79 - 2014/15 directed St. Matthew Island blue king crab pot fishery. Source: Fitch et al. 2012; ADF&G Dutch Harbor staff, pers. comm.

Table 2aXX. NMFS EBS trawl-survey area-swept estimates of male crab abundance (10 6 crab) and of mature male biomass (10 6 lbs). Total number of captured male crab $\ge$ 90 mm CL is also given. Source: R.Foy, NMFS. The “+” refers to plus group.

\begin{table}[ht]
\centering
\caption{Model parameter estimates and standard deviations for the {\bf Gmacs base} model.} 
\label{tab:est_pars_base}
\begin{tabular}{lrr}
  \hline
Parameter & Estimate & SD \\ 
  \hline
Natural mortality ($M$) deviation in 1998 & 1.8054000 & 0.1074600 \\ 
  $\log (R_0)$ & 13.5960000 & 0.0519520 \\ 
  $\log (\bar{R})$ & 13.6910000 & 0.1229600 \\ 
  $\log (N_1)$ & 14.6210000 & 0.1684500 \\ 
  $\log (N_2)$ & 14.1760000 & 0.1899200 \\ 
  $\log (N_3)$ & 13.8250000 & 0.2055600 \\ 
  ADF\&G pot survey catchability ($q$) & 0.0000043 & 0.0000003 \\ 
  $\bar{F}_\text{pot}$ & -1.3747000 & 0.0536940 \\ 
  $\bar{F}_\text{trawl bycatch}$ & -11.6890000 & 0.0833040 \\ 
  $\bar{F}_\text{fixed bycatch}$ & -9.5781000 & 0.0835810 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Model parameter estimates and standard deviations for the {\bf Gmacs selex} model that estimates stage-1 and stage-2 selectivity.} 
\label{tab:est_pars_selex}
\begin{tabular}{lrr}
  \hline
Parameter & Estimate & SD \\ 
  \hline
Natural mortality ($M$) deviation in 1998 & 1.5947000 & 0.1354000 \\ 
  $\log (R_0)$ & 13.5320000 & 0.0538760 \\ 
  $\log (\bar{R})$ & 13.6250000 & 0.1238100 \\ 
  $\log (N_1)$ & 14.7360000 & 0.1699300 \\ 
  $\log (N_2)$ & 14.3040000 & 0.2017300 \\ 
  $\log (N_3)$ & 14.2290000 & 0.2084800 \\ 
  ADF\&G pot survey catchability ($q$) & 0.0000040 & 0.0000003 \\ 
  $\log(\bar{F}_\text{pot})$ & -1.4963000 & 0.0563790 \\ 
  $\log(\bar{F}_\text{trawl bycatch})$ & -11.6930000 & 0.0828660 \\ 
  $\log(\bar{F}_\text{fixed bycatch})$ & -9.5847000 & 0.0830210 \\ 
  Stage-1 directed pot selectivity 1978-2008 & -0.7176300 & 0.1759200 \\ 
  Stage-2 directed pot selectivity 1978-2008 & -0.3821800 & 0.1269500 \\ 
  Stage-1 directed pot selectivity 2009-2015 & -0.7424500 & 0.1879900 \\ 
  Stage-2 directed pot selectivity 2009-2015 & 0.1526600 & 0.0955460 \\ 
  Stage-1 NMFS trawl selectivity & -0.1540100 & 0.0714200 \\ 
  Stage-2 NMFS trawl selectivity & 0.1827200 & 0.0587180 \\ 
  Stage-1 ADF\&G pot selectivity & -0.8813900 & 0.1383800 \\ 
  Stage-2 ADF\&G pot selectivity & -0.0695420 & 0.0819370 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Model parameter estimates and standard deviations for the {\bf Gmacs CV} model that estimates stage-1 and stage-2 selectivity.} 
\label{tab:est_pars_cv}
\begin{tabular}{lrr}
  \hline
Parameter & Estimate & SD \\ 
  \hline
Natural mortality ($M$) deviation in 1998 & 1.8464000 & 0.1718500 \\ 
  $\log (R_0)$ & 13.6500000 & 0.0598450 \\ 
  $\log (\bar{R})$ & 13.7430000 & 0.1265400 \\ 
  $\log (N_1)$ & 14.7180000 & 0.1695900 \\ 
  $\log (N_2)$ & 14.2700000 & 0.2007900 \\ 
  $\log (N_3)$ & 14.1570000 & 0.2092000 \\ 
  ADF\&G pot survey catchability ($q$) & 0.0000034 & 0.0000004 \\ 
  logAddCV & -1.7807000 & 0.1827300 \\ 
  $\log(\bar{F}_\text{pot})$ & -1.5200000 & 0.0562760 \\ 
  $\log(\bar{F}_\text{trawl bycatch})$ & -11.7250000 & 0.0845790 \\ 
  $\log(\bar{F}_\text{fixed bycatch})$ & -9.6169000 & 0.0846910 \\ 
  Stage-1 directed pot selectivity 1978-2008 & -0.7201700 & 0.1759500 \\ 
  Stage-2 directed pot selectivity 1978-2008 & -0.3855500 & 0.1274000 \\ 
  Stage-1 directed pot selectivity 2009-2015 & -0.9639300 & 0.1902100 \\ 
  Stage-2 directed pot selectivity 2009-2015 & 0.0341370 & 0.0955080 \\ 
  Stage-1 NMFS trawl selectivity & -0.2131800 & 0.0681820 \\ 
  Stage-2 NMFS trawl selectivity & 0.1420300 & 0.0566140 \\ 
  Stage-1 ADF\&G pot selectivity & -1.0710000 & 0.1344600 \\ 
  Stage-2 ADF\&G pot selectivity & -0.1620700 & 0.0813780 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Model parameter estimates and standard deviations for the {\bf Gmacs M} model that estimates stage-1 and stage-2 selectivity.} 
\label{tab:est_pars_M}
\begin{tabular}{lrr}
  \hline
Parameter & Estimate & SD \\ 
  \hline
$\log (R_0)$ & 13.3650000 & 0.0523920 \\ 
  $\log (\bar{R})$ & 13.4580000 & 0.1231200 \\ 
  $\log (N_1)$ & 14.7670000 & 0.1699600 \\ 
  $\log (N_2)$ & 14.3540000 & 0.2027600 \\ 
  $\log (N_3)$ & 14.3890000 & 0.2024100 \\ 
  ADF\&G pot survey catchability ($q$) & 0.0000047 & 0.0000003 \\ 
  $\log(\bar{F}_\text{pot})$ & -1.4553000 & 0.0574300 \\ 
  $\log(\bar{F}_\text{trawl bycatch})$ & -11.6130000 & 0.0811320 \\ 
  $\log(\bar{F}_\text{fixed bycatch})$ & -9.5048000 & 0.0812590 \\ 
  Stage-1 directed pot selectivity 1978-2008 & -0.5798400 & 0.1835900 \\ 
  Stage-2 directed pot selectivity 1978-2008 & -0.3456700 & 0.1280600 \\ 
  Stage-1 directed pot selectivity 2009-2015 & -0.7206600 & 0.1889300 \\ 
  Stage-2 directed pot selectivity 2009-2015 & 0.1360500 & 0.0951510 \\ 
  Stage-1 NMFS trawl selectivity & -0.0350400 & 0.0702790 \\ 
  Stage-2 NMFS trawl selectivity & 0.2851200 & 0.0629400 \\ 
  Stage-1 ADF\&G pot selectivity & -0.8312000 & 0.1428100 \\ 
  Stage-2 ADF\&G pot selectivity & 0.0187320 & 0.0817210 \\ 
   \hline
\end{tabular}
\end{table}


```
## Error in data.frame(Parameter, Estimate, SD): arguments imply differing number of rows: 7, 17
```

\begin{table}[ht]
\centering
\caption{Model parameter estimates and standard deviations for the {\bf Gmacs M} model that estimates stage-1 and stage-2 selectivity.} 
\label{tab:est_pars_M}
\begin{tabular}{lrr}
  \hline
Parameter & Estimate & SD \\ 
  \hline
$\log (R_0)$ & 13.3650000 & 0.0523920 \\ 
  $\log (\bar{R})$ & 13.4580000 & 0.1231200 \\ 
  $\log (N_1)$ & 14.7670000 & 0.1699600 \\ 
  $\log (N_2)$ & 14.3540000 & 0.2027600 \\ 
  $\log (N_3)$ & 14.3890000 & 0.2024100 \\ 
  ADF\&G pot survey catchability ($q$) & 0.0000047 & 0.0000003 \\ 
  $\log(\bar{F}_\text{pot})$ & -1.4553000 & 0.0574300 \\ 
  $\log(\bar{F}_\text{trawl bycatch})$ & -11.6130000 & 0.0811320 \\ 
  $\log(\bar{F}_\text{fixed bycatch})$ & -9.5048000 & 0.0812590 \\ 
  Stage-1 directed pot selectivity 1978-2008 & -0.5798400 & 0.1835900 \\ 
  Stage-2 directed pot selectivity 1978-2008 & -0.3456700 & 0.1280600 \\ 
  Stage-1 directed pot selectivity 2009-2015 & -0.7206600 & 0.1889300 \\ 
  Stage-2 directed pot selectivity 2009-2015 & 0.1360500 & 0.0951510 \\ 
  Stage-1 NMFS trawl selectivity & -0.0350400 & 0.0702790 \\ 
  Stage-2 NMFS trawl selectivity & 0.2851200 & 0.0629400 \\ 
  Stage-1 ADF\&G pot selectivity & -0.8312000 & 0.1428100 \\ 
  Stage-2 ADF\&G pot selectivity & 0.0187320 & 0.0817210 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Comparisons of negative log-likelihood values and management measures for the four Gmacs model scenarios. Biomass and OFL are in tonnes.} 
\label{tab:likelihood_components}
\begin{tabular}{lrrrr}
  \hline
Component & Gmacs base & Gmacs selex & Gmacs CV & Gmacs M \\ 
  \hline
Pot Retained Catch & -66.34 & -66.87 & -67.07 & -66.63 \\ 
  Pot Discarded Catch & 8.86 & 3.89 & 4.13 & 4.15 \\ 
  Trawl bycatch Discarded Catch & -6.61 & -6.61 & -6.61 & -6.61 \\ 
  Fixed bycatch Discarded Catch & -6.55 & -6.59 & -6.60 & -6.60 \\ 
  NMFS Trawl Survey & 24.60 & 26.48 & 24.82 & 34.06 \\ 
  ADF\&G Pot Survey CPUE & 68.94 & 57.18 & 9.36 & 60.89 \\ 
  Directed Pot LF & -11.41 & -11.86 & -12.01 & -11.60 \\ 
  NMFS Trawl LF & 19.74 & 12.70 & 0.73 & 14.03 \\ 
  ADF\&G Pot LF & -1.30 & -4.98 & -7.80 & -3.89 \\ 
  Recruitment deviations & 38.02 & 38.64 & 36.17 & 42.13 \\ 
  F penalty & 9.53 & 9.53 & 9.53 & 9.52 \\ 
  M penalty & 6.48 & 6.47 & 6.48 & 0.00 \\ 
  Prior & 16.43 & 21.97 & 34.22 & 21.97 \\ 
  Total & 100.39 & 79.94 & 25.35 & 91.44 \\ 
  Total estimated parameters & 276.00 & 284.00 & 285.00 & 282.00 \\ 
  MMB2015 & 3294.92 & 2612.73 & 4088.82 & 2122.75 \\ 
  Fofl & 0.37 & 0.36 & 0.37 & 0.32 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Population abundances (N) by crab stage in numbers of crab and mature male biomass (MMB) at survey in tonnes on 15 February for the {\bf 2015 model}. All abundances are at time of survey (season 1).} 
\label{tab:pop_abundance_2015}
\begin{tabular}{rrrrr}
  \hline
Year & N1 & N2 & N3 & MMB \\ 
  \hline
1978 & 3255149 & 1745630 & 1402666 & 4562 \\ 
  1979 & 2644323 & 2426526 & 2316986 & 6295 \\ 
  1980 & 1126235 & 2304998 & 3382846 & 9501 \\ 
  1981 & 992395 & 1402492 & 3189705 & 9721 \\ 
  1982 & 738746 & 1027667 & 1793731 & 7070 \\ 
  1983 & 686101 & 759715 & 1919257 & 4368 \\ 
  1984 & 904924 & 641076 & 1323143 & 3067 \\ 
  1985 & 1195419 & 726109 & 1136628 & 2826 \\ 
  1986 & 1247549 & 919252 & 1239376 & 2845 \\ 
  1987 & 1177020 & 1012785 & 1420834 & 3415 \\ 
  1988 & 2478039 & 1003699 & 1567211 & 3835 \\ 
  1989 & 1624299 & 1739571 & 1837592 & 4405 \\ 
  1990 & 1753294 & 1498261 & 2229010 & 4853 \\ 
  1991 & 1844115 & 1490948 & 2156035 & 4531 \\ 
  1992 & 2110962 & 1540151 & 2254818 & 4689 \\ 
  1993 & 1667104 & 1708314 & 2314273 & 5095 \\ 
  1994 & 1774896 & 1512107 & 2237756 & 5034 \\ 
  1995 & 1643871 & 1508342 & 2226850 & 4911 \\ 
  1996 & 1051184 & 1432808 & 2207393 & 4502 \\ 
  1997 & 726449 & 1071149 & 1855845 & 3901 \\ 
  1998 & 411807 & 307249 & 602573 & 1923 \\ 
  1999 & 447247 & 335454 & 697335 & 1623 \\ 
  2000 & 380578 & 365047 & 794366 & 1775 \\ 
  2001 & 185139 & 336910 & 883787 & 1913 \\ 
  2002 & 315210 & 216591 & 925447 & 2031 \\ 
  2003 & 260489 & 250556 & 911773 & 1970 \\ 
  2004 & 453670 & 230839 & 912654 & 2012 \\ 
  2005 & 792862 & 334026 & 921958 & 1980 \\ 
  2006 & 462221 & 560227 & 1013160 & 2150 \\ 
  2007 & 983955 & 441893 & 1157051 & 2492 \\ 
  2008 & 984234 & 704348 & 1281965 & 2748 \\ 
  2009 & 953135 & 791217 & 1427153 & 3024 \\ 
  2010 & 922034 & 802140 & 1416114 & 2821 \\ 
  2011 & 605101 & 789025 & 1286841 & 2454 \\ 
  2012 & 755064 & 604702 & 1194961 & 2106 \\ 
  2013 & 718195 & 628941 & 1375098 & 2440 \\ 
  2014 & 571248 & 616058 & 1474058 & 2482 \\ 
  2015 & 798892 & 528358 & 1596489 & 2680 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Population abundances (N) by crab stage in numbers of crab, mature male biomass (MMB) at survey in tonnes on 15 February for the {\bf Gmacs base} model. All abundances are at time of survey (season 1).} 
\label{tab:pop_abundance_base}
\begin{tabular}{rrrrr}
  \hline
Year & N1 & N2 & N3 & MMB \\ 
  \hline
1978 & 3255149 & 1745630 & 1402666 & 2540 \\ 
  1979 & 2644323 & 2426526 & 2316986 & 4286 \\ 
  1980 & 1126235 & 2304998 & 3382846 & 6688 \\ 
  1981 & 992395 & 1402492 & 3189705 & 6585 \\ 
  1982 & 738746 & 1027667 & 1793731 & 3630 \\ 
  1983 & 686101 & 759715 & 1919257 & 3950 \\ 
  1984 & 904924 & 641076 & 1323143 & 2687 \\ 
  1985 & 1195419 & 726109 & 1136628 & 2244 \\ 
  1986 & 1247549 & 919252 & 1239376 & 2404 \\ 
  1987 & 1177020 & 1012785 & 1420834 & 2781 \\ 
  1988 & 2478039 & 1003699 & 1567211 & 3108 \\ 
  1989 & 1624299 & 1739571 & 1837592 & 3420 \\ 
  1990 & 1753294 & 1498261 & 2229010 & 4431 \\ 
  1991 & 1844115 & 1490948 & 2156035 & 4249 \\ 
  1992 & 2110962 & 1540151 & 2254818 & 4441 \\ 
  1993 & 1667104 & 1708314 & 2314273 & 4514 \\ 
  1994 & 1774896 & 1512107 & 2237756 & 4441 \\ 
  1995 & 1643871 & 1508342 & 2226850 & 4396 \\ 
  1996 & 1051184 & 1432808 & 2207393 & 4381 \\ 
  1997 & 726449 & 1071149 & 1855845 & 3751 \\ 
  1998 & 411807 & 307249 & 602573 & 2050 \\ 
  1999 & 447247 & 335454 & 697335 & 1406 \\ 
  2000 & 380578 & 365047 & 794366 & 1606 \\ 
  2001 & 185139 & 336910 & 883787 & 1811 \\ 
  2002 & 315210 & 216591 & 925447 & 1940 \\ 
  2003 & 260489 & 250556 & 911773 & 1884 \\ 
  2004 & 453670 & 230839 & 912654 & 1897 \\ 
  2005 & 792862 & 334026 & 921958 & 1878 \\ 
  2006 & 462221 & 560227 & 1013160 & 2003 \\ 
  2007 & 983955 & 441893 & 1157051 & 2379 \\ 
  2008 & 984234 & 704348 & 1281965 & 2539 \\ 
  2009 & 953135 & 791217 & 1427153 & 2849 \\ 
  2010 & 922034 & 802140 & 1416114 & 2832 \\ 
  2011 & 605101 & 789025 & 1286841 & 2561 \\ 
  2012 & 755064 & 604702 & 1194961 & 2430 \\ 
  2013 & 718195 & 628941 & 1375098 & 2784 \\ 
  2014 & 571248 & 616058 & 1474058 & 3003 \\ 
  2015 & 798892 & 528358 & 1596489 & 3295 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Population abundances (N) by crab stage in numbers of crab, mature male biomass (MMB) at survey in tonnes on 15 February for {\bf Gmacs selex} model. All abundances are at time of survey (season 1).} 
\label{tab:pop_abundance_selex}
\begin{tabular}{rrrrr}
  \hline
Year & N1 & N2 & N3 & MMB \\ 
  \hline
1978 & 3465373 & 1964705 & 1947297 & 3648 \\ 
  1979 & 2536619 & 2618435 & 2902462 & 5494 \\ 
  1980 & 1051793 & 2307355 & 3958354 & 7940 \\ 
  1981 & 940958 & 1361011 & 3665119 & 7617 \\ 
  1982 & 697350 & 984761 & 2166901 & 4438 \\ 
  1983 & 660298 & 722005 & 2205414 & 4570 \\ 
  1984 & 906428 & 613951 & 1542269 & 3161 \\ 
  1985 & 1250828 & 717992 & 1306748 & 2607 \\ 
  1986 & 1246128 & 948035 & 1382828 & 2699 \\ 
  1987 & 1173316 & 1021507 & 1555205 & 3069 \\ 
  1988 & 2713984 & 1004487 & 1683754 & 3358 \\ 
  1989 & 1713304 & 1873833 & 1958062 & 3630 \\ 
  1990 & 1749939 & 1593249 & 2406435 & 4792 \\ 
  1991 & 1897122 & 1520517 & 2353506 & 4671 \\ 
  1992 & 2123490 & 1580072 & 2440744 & 4828 \\ 
  1993 & 1513175 & 1728658 & 2492652 & 4892 \\ 
  1994 & 1708295 & 1431431 & 2385679 & 4788 \\ 
  1995 & 1523346 & 1443828 & 2305282 & 4577 \\ 
  1996 & 846351 & 1343005 & 2231059 & 4456 \\ 
  1997 & 608756 & 925099 & 1815520 & 3706 \\ 
  1998 & 375028 & 321482 & 695554 & 2117 \\ 
  1999 & 410848 & 319294 & 778655 & 1587 \\ 
  2000 & 382349 & 339026 & 850663 & 1734 \\ 
  2001 & 199403 & 329307 & 917857 & 1883 \\ 
  2002 & 333229 & 222176 & 951435 & 1992 \\ 
  2003 & 252872 & 262636 & 938020 & 1937 \\ 
  2004 & 504902 & 230513 & 939940 & 1957 \\ 
  2005 & 766339 & 363012 & 949483 & 1926 \\ 
  2006 & 591479 & 554782 & 1048223 & 2084 \\ 
  2007 & 997149 & 513201 & 1196986 & 2438 \\ 
  2008 & 879583 & 735450 & 1352537 & 2687 \\ 
  2009 & 843386 & 742152 & 1492631 & 3010 \\ 
  2010 & 712037 & 723663 & 1438516 & 2902 \\ 
  2011 & 460293 & 643783 & 1250433 & 2526 \\ 
  2012 & 533679 & 474383 & 1080360 & 2214 \\ 
  2013 & 464877 & 460078 & 1192498 & 2439 \\ 
  2014 & 413692 & 416296 & 1212432 & 2496 \\ 
  2015 & 725639 & 372754 & 1262169 & 2613 \\ 
   \hline
\end{tabular}
\end{table}

\newpage\clearpage

![Catches of 181 male blue king crab measuring at least 90 mm CL from the 2014 NMFS trawl-survey at the 56 stations used to assess the SMBKC stock. Note that the area north of St. Matthew Island, which includes the large catch of 67 crab at station R-24, is not represented in the ADF&G pot-survey data used in the assessment.\label{fig:catch181}](figure/Fig4.png)

![NFMS Bering Sea reporting areas. Estimates of SMBKC bycatch in the groundfish fisheries are based on NMFS observer data from reporting areas 524 and 521.\label{fig:reporting_areas}](figure/Fig5.png)

\newpage\clearpage

![Estimated stage-1 and stage-2 selectivities for each of the different model scenarios (the stage-3 selectivities are all fixed at 1). Estimated selectivities are shown for the directed pot fishery, the trawl bycatch fishery, the fixed bycatch fishery, the NMFS trawl survey, and the ADF&G pot survey. Two selectivity periods are estimated in the directed pot fishery, from 1978-2008 and 2009-2015.\label{fig:selectivity}](figure/selectivity-1.png)

![Molting probabilities by stage used in each of the Gmacs model scenarios. The 2015 model did not use a molting probability curve directly (the size transition matrix was specified instead).\label{fig:molt_prob}](figure/molt_prob-1.png)

\newpage\clearpage

![Comparisons of area-swept estimates of total male survey biomass (tonnes) and model predictions for the 2015 and 2016 Gmacs model. The error bars are plus and minus 2 standard deviations.\label{fig:trawl_survey_biomass}](figure/trawl_survey_biomass-1.png)

![Comparisons of total male pot survey CPUEs and model predictions for 2016 model estimates without additional CV for the pot survey CPUE. The error bars are plus and minus 2 standard deviations.\label{fig:pot_survey_cpue}](figure/pot_survey_cpue-1.png)

![Standardized residuals for area-swept estimates of total male survey biomass and total male pot survey CPUEs for Gmacs configuration. \label{fig:bts_resid}](figure/bts_resid-1.png)

\newpage\clearpage

![Observed and model estimated size-frequencies of male BBRKC by year retained in the directed pot fishery.\label{fig:sc_pot}](figure/sc_pot-1.png)

![Observed and model estimated size-frequencies of discarded male BBRKC by year in the NMFS trawl survey.\label{fig:sc_pot_discarded}](figure/sc_pot_discarded-1.png)

![Observed and model estimated size-frequencies of discarded female BBRKC by year in the ADF&G pot survey.\label{fig:sc_trawl_discarded}](figure/sc_trawl_discarded-1.png)

![Bubble plots of residuals by stage and year for the directed pot fishery size composition data for St. Mathew Island blue king crab (SMBKC).\label{fig:sc_pot_res}](figure/sc_pot_res-1.png)

![Bubble plots of residuals by stage and year for the NMFS trawl survey size composition data for St. Mathew Island blue king crab (SMBKC).\label{fig:sc_pot_discarded_res}](figure/sc_pot_discarded_res-1.png)

![Bubble plots of residuals by stage and year for the ADF&G pot survey size composition data for St. Mathew Island blue king crab (SMBKC).\label{fig:sc_trawl_discarded_res}](figure/sc_trawl_discarded_res-1.png)

\newpage\clearpage

![Comparison of observed and model predicted retained catch and bycatches in each of the Gmacs models. Note that difference in units between each of the panels.\label{fig:fit_to_catch}](figure/fit_to_catch-1.png)

![Estimated recruitment time series during 1979-2015 with 18 scenarios. Estimated recruitment time series ($R_t$) in the OneSex, TwoSex and BBRKC models. Note that recruitment in the OneSex model represents recruitment of males only.\label{fig:recruitment}](figure/recruitment-1.png)

![Estimated mature male biomass (MMB) time series on 15 February during 1978-2015 for each of the model scenarios.\label{fig:mmb}](figure/mature_male_biomass-1.png)

![Relationship between carapace width (mm) and weight (kg) by sex in each of the models (provided as a vector of weights at length to Gmacs).\label{fig:length-weight}](figure/length_weight-1.png)

![Distribution of carapace width (mm) at recruitment.\label{fig:init_rec}](figure/init_rec-1.png)

![Growth increment (mm) each molt by sex in the OneSex and TwoSex models.\label{fig:growth_inc}](figure/growth_inc-1.png)

![Probability of growth transition by stage. Each of the panels represent the stage before growth. The x-axes represent the stage after a growth (ignoring the probability of molting).\label{fig:growth_trans}](figure/growth_trans-1.png)

![Probability of size transition by stage (i.e. the combination of the growth matrix and molting probabilities). Each of the panels represent the stage before a transition. The x-axes represent the stage after a transition.\label{fig:size_trans}](figure/size_trans-1.png)

![Numbers by stage each year (15 February) in each of the models including the 2015 model.\label{fig:init_N}](figure/init_N-1.png)

![Time-varying natural mortality ($M_t$). Estimated pulse period occurs in 1998 (i.e. $M_{1998}$). \label{fig:M_t}](figure/natural_mortality-1.png)


\newpage\clearpage

# Appendix A: SMBKC Model Description

## 1. Introduction

The Gmacs model has been specified to account only for male crab at least 90 mm in carapace length (CL). These are partitioned into three stages (size-classes) determined by CL measurements of (1) 90-104 mm, (2) 105-119 mm, and (3) 120+ mm. For management of the St. Matthew Island blue king crab (SMBKC) fishery, 120 mm CL is used as the proxy value for the legal measurement of 5.5 mm in carapace width (CW), whereas 105 mm CL is the management proxy for mature-male size (5 AAC 34.917 (d)). Accordingly, within the model only stage-3 crab are retained in the directed fishery, and stage-2 and stage-3 crab together comprise the collection of mature males. Some justification for the 105 mm value is presented in Pengilly and Schmidt (1995), who used it in developing the current regulatory SMBKC harvest strategy. The term “recruit” here designates recruits to the model, i.e., annual new stage-1 crab, rather than recruits to the fishery. The following description of model structure reflects the Gmacs base model configuration.

## 2. Model Population Dynamics

Each model year is split into four seasons.

Within the model, the beginning of the crab year is assumed contemporaneous with the NMFS trawl survey, nominally assigned a date of 1 July. With boldface lowercase letters indicating vector quantities we designate the vector of stage abundances during season $t$ and year $y$ as
\begin{equation}
    \boldsymbol{n}_{t,y} = \left[ n_{1,t,y}, n_{2,t,y}, n_{3,t,y} \right]^\top.
\end{equation}
Using boldface uppercase letters to indicate a matrix, we describe the size transition matrix $\boldsymbol{G}$ as
\begin{equation}
  \boldsymbol{G} = \left[ \begin{array}{ccc}
    1 - \pi_{12} - \pi_{13} & \pi_{12} & \pi_{13} \\
    0 & 1 - \pi_{23} & \pi_{23} \\
    0 & 0 & 1 \end{array} \right],
\end{equation}
with $\pi_{jk}$ equal to the proportion of stage-$j$ crab that molt and grow into stage-$k$ within a season or year. Similarly, the survival matrix $\boldsymbol{S}_{t,y}$ during season $t$ and year $y$ is
\begin{equation}
  \boldsymbol{S}_{t,y} = \left[ \begin{array}{ccc}
    1-e^{-Z_{1,t,y}} & 0 & 0 \\
    0 & 1-e^{-Z_{2,t,y}} & 0 \\
    0 & 0 & 1-e^{-Z_{3,t,y}} \end{array} \right],
\end{equation}
where $Z_{l,t,y}$ represents the combination of natural mortality $M_{t,y}$ and fishing mortality $F_{t,y}$ during season $t$ and year $y$. The number of new crab, or recruits, of each stage entering the model each season $t$ and year $y$ is represented as the vector $\boldsymbol{r}_{t,y}$. The SMBKC formulation of Gmacs specifies recruitment to stage-1 only, thus
\begin{equation}
    \boldsymbol{r}_{t,y} = \left[ \bar{R}, 0, 0 \right]^\top.
\end{equation}
In this formulation of the model, all recruits are assumed to be to stage-1. The basic population dynamics underlying Gmacs can thus be described as
\begin{align}
    \boldsymbol{n}_{t+1,y} &= \boldsymbol{S}_{t,y} \boldsymbol{n}_{t,y}, &\text{ if } t<4 \notag\\
    \boldsymbol{n}_{t,y+1} &= \boldsymbol{G}_t \boldsymbol{S}_{t,y} \boldsymbol{n}_{t,y} + \boldsymbol{r}_{t,y}, &\text{ if } t=4
\end{align}

Aside from natural mortality and molting and growth, only the directed fishery and some limited bycatch mortality in the groundfish fisheries are assumed to affect the stock. Nontrivial bycatch mortality with another fishery, as occurred in 2012/13, is assumed to be accounted for in the model in the estimate of groundfish bycatch mortality. The directed fishery is modeled as a mid-season pulse occurring at time $\pi_t$ with full-selection fishing mortality $F_t$ relative to stage-3 crab. Year-t directed-fishery removals from the stock are computed as

$$R^{df}_t = H^{df} S^{df} (1 - e^{F^{df}_t}) e^{-\tau_t M} N_t$$
where the diagonal matrices
\begin{equation}
  \boldsymbol{H}^\text{df} = \left[ \begin{array}{ccc}
    h^\text{df} & 0 & 0 \\
    0 & h^\text{df} & 0 \\
    0 & 0 & 1 \end{array} \right]
\end{equation}
account for stage selectivities $s_1^\text{df}$ and $s_2^\text{df}$ and discard handling mortality $h^\text{df}$ in the directed fishery, both assumed constant over time. Yearly stage removals resulting from bycatch mortality in the groundfish trawl and fixed-gear fisheries are calculated as Feb 15 (0.63 yr) pulse effects in terms of the respective fishing mortalities $F_t^\text{gt}$ and $F_t^\text{gf}$ by

## 3. Model Data

Data inputs used in model estimation are listed in Table 1XX. All quantities relate to male SMBKC $\le$ 90mm CL.

## 4. Model Parameters

Estimated parameters with scenarios 8 and 10 are listed in Table 2XX and include an estimated parameter for natural mortality ($M$) in 1998/99 assuming an anomalous mortality event in that year, as hypothesized by Zheng and Kruse (2002), with natural mortality otherwise fixed at 0.18 $\text{yr}^{-1}$.

In any year with no directed fishery, and hence zero retained catch, $F_t^\text{df}$ is set to zero rather than model estimated. Similarly, for years in which no groundfish bycatch data are available, $F_t^\text{gf}$ and $F_t^\text{gt}$ are imputed to be the geometric means of the estimates from years for which there are data. Table 3XX lists additional externally determined parameters used in model computations.

In all scenarios, the stage-transition matrix is
\begin{equation}
  \left[ \begin{array}{ccc}
    0.2 & 0.7 & 0.1 \\
    0 & 0.4 & 0.6 \\
    0 & 0 & 1 \end{array} \right]
\end{equation}
which includes molting probabilities.

The combination of the growth matrix and molting probabilities results in the stage-transition matrix for scenarios 3-11. Molting probability for stage 1 for scenarios 8, 9, 10, 11 during 1978-2000 is assumed to be 0.91 estimated from the tagging data and ratio of molting probabilities of stages 2 to stage 1 is fixed as 0.69231 from the tagging data as well. For scenarios 0 and 1, stage-transition matrix

Both surveys are assigned a nominal date of 1 July, the start of the crab year. The directed fishery is treated as a season midpoint pulse. Groundfish bycatch is likewise modeled as a pulse effect, occurring at the nominal time of mating, February 15, which is also the reference date for calculation of federal management biomass quantities.

\begin{table}[ht]
\centering
\caption{Model bounds, initial values, priors and estimation phase.} 
\label{tab:bounds_pars}
\begin{tabular}{lrrrlrrr}
  \hline
Parameter & LB & Initial value & UB & Prior type & Prior par1 & Prior par2 & Phase \\ 
  \hline
$Mdev_{1998}$ & 0 & 0.0 &  & Random walk & 0 & 10 & 2 \\ 
  $\log (R_0)$ & -7 & 14.3 & 30 & Uniform & -7 & 30 & 2 \\ 
  $\log (\bar{R})$ & -7 & 10.0 & 20 & Uniform & -7 & 20 & 1 \\ 
  $\log (N_1)$ & 5 & 14.0 & 15 & Uniform & 5 & 15 & 1 \\ 
  $\log (N_2)$ & 5 & 14.0 & 15 & Uniform & 5 & 15 & 1 \\ 
  $\log (N_3)$ & 5 & 14.0 & 15 & Uniform & 5 & 15 & 1 \\ 
  $q_{pot}$ & 0 & 4.0 & 5 & Uniform & 0 & 5 & 4 \\ 
  Add CV ADFG pot & 0 & 0.0 & 10 & Gamma & 1 & 100 & 4 \\ 
  Stage-1 1978-2008 & 0 & 0.4 & 2 & Uniform & 0 & 2 & 4 \\ 
  Stage-2 1978-2008 & 0 & 0.7 & 2 & Uniform & 0 & 2 & 4 \\ 
  Stage-1 2009-2015 & 0 & 0.3 & 2 & Uniform & 0 & 2 & 4 \\ 
  Stage-2 2009-2015 & 0 & 0.8 & 2 & Uniform & 0 & 2 & 4 \\ 
  Stage-1 NMFS & 0 & 0.7 & 2 & Uniform & 0 & 2 & 4 \\ 
  Stage-2 NMFS & 0 & 0.9 & 2 & Uniform & 0 & 2 & 4 \\ 
  Stage-1 ADFG & 0 & 0.3 & 2 & Uniform & 0 & 2 & 4 \\ 
  Stage-2 ADFG & 0 & 0.7 & 2 & Uniform & 0 & 2 & 4 \\ 
   \hline
\end{tabular}
\end{table}


## 5. Model Objective Function and Weighting Scheme

The objective function consists of a sum of eight "negative log-likelihood" terms characterizing the hypothesized error structure of the principal data inputs with respect to their true, i.e., model-predicted, values and four "penalty" terms associated with year-to-year variation in model recruit abundance and fishing mortality in the directed fishery and groundfish trawl and fixed-gear fisheries. See Table \ref{tab:stage_cpue}, where upper and lower case letters designate model-predicted and data-computed quantities, respectively, and boldface letters again indicate vector quantities. Sample sizes $n_t$ (observed number of male SMBKC $\le$ 90 mm CL) and estimated coefficients of variation $\widehat{cv}_t$ were used to develop appropriate variances for stage-proportion and abundance-index components. The weights $\lambda_j$ appearing in the objective function component expressions in Table \ref{tab:stage_cpue} play the role of "tuning" parameters in the modeling procedure.

Table 4XX. Log-likelihood and penalty components of base-model objective function. The $\lambda_k$ are weights, described in text; the neff t are effective sample sizes, also described in text. All summations are with respect to years over each data series.

| Component | Distribution | Form |
|-----------|--------------|------|
| Legal retained-catch biomass | Lognormal | $-0.5 \sum \left( \log (c_t/C_t)^2 / \log (1+cv^2_c) \right)$ |
| Dis. Pot bycatch biomass | Lognormal | |



## 6. Estimation

The model was implemented using the software AD Model Builder (Fournier et al. 2012), with parameter estimation by minimization of the model objective function using automatic differentiation. Parameter estimates and standard deviations provided in this document are AD Model Builder reported values assuming maximum likelihood theory asymptotics.

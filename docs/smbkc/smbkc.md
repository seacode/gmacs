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

2. **Catches**: Peak historical harvest was 4288 tonnes (9.454 million pounds) in 1983/84^[1983/84 refers to a fishing year that extends from 1 July 1983 to 30 June 1984.]. The fishery was closed for 10 years after the stock was declared overfished in 1999. Fishing resumed in 2009/10 with a fishery-reported retained catch of 209 tonnes (0.461 million pounds), less than half the 529.3 tonnes (1.167 million pounds) TAC. Following three more years of modest harvests supported by a fishery catch per unit effort (CPUE) of around 10 crab per pot lift, the fishery was again closed in 2013/14 due to declining trawl-survey estimates of abundance and concerns about the health of the stock. The directed fishery resumed again in 2014/15 with a TAC of 300 tonnes (0.655 million pounds), but the fishery performance was relatively poor with a retained catch of 140 tonnes (0.309 million pounds).

3. **Stock biomass**: Following a period of low numbers after the stock was declared overfished in 1999, trawl-survey indices of SMBKC stock abundance and biomass generally increased in subsequent years, with survey estimated mature male biomass reaching 9516 tonnes (20.98 million pounds; CV = 0.55) in 2011, the second highest in the 37-year time series used in this assessment. Survey mature male biomass then declined to 5652 tonnes (12.46 million pounds; CV = 0.33) in 2012 and to 2202 tonnes (4.459 million pounds; CV = 0.22) in 2013 before going back up to 5472 tonnes (12.06 million pounds; CV = 0.44) in 2014 and 5134 tonnes (11.32 million pounds; CV = 0.76).

4. **Recruitment**: Because little information about the abundance of small crab is available for this stock, recruitment has been assessed in terms of the number of male crab within the 90-104 mm CL size class in each year. The 2013 trawl-survey area-swept estimate of 0.335 million male SMBKC in this size class marked a three-year decline and was the lowest since 2005. That decline did not continue as the 2014 survey estimate is 0.723 million. The survey recruitment is 0.992 million in 2015, but the majority of this survey estimate is from one tow with a great deal of uncertainty.

5. **Management performance**: In recent assessments, estimated total male catch has been determined as the sum of fishery-reported retained catch, estimated male discard mortality in the directed fishery, and estimated male bycatch mortality in the groundfish fisheries, as these have been the only sources of non-negligible fishing mortality to consider.



The stock was above the minimum stock-size threshold (MSST) in 2014/15 and is hence not overfished. Overfishing did not occur in 2014/15.

6. **Basis for the OFL**: Estimated mature-male biomass (MMB) on 15 February is used as the measure of biomass for this Tier 4 stock, with males measuring 105 mm CL or more considered mature. The $B_\mathit{MSY}$ proxy is obtained by averaging estimated MMB over a specific reference time period, and current CPT/SSC guidance recommends using the full assessment time frame as the default reference period.


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

Groundfish bycatch size-frequency data are available for selected years. These data were used in model-based assessments prior to 2011. However, they have since been excluded because these data tend to be severely limited: for example, 2012/13 data include a total of just 4 90 mm+ CL male blue king crab from reporting areas 521 and 524.


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

| Scenario | Selectivity estimated | Additional CV | Estimate $M_{1998}$ |
|-|-|-|-|
| Gmacs base | No | No | Yes |
| Gmacs selex | Yes | No | Yes |
| Gmacs CV | Yes | Yes | Yes |
| Gmacs M | Yes | No | No |


## Results

Preliminary results for the Gmacs configuration are provided here with comparisons to the 2015 model.

a. Effective sample sizes.

Observed and estimated effective sample sizes are compared in Table XX.

b. Tables of estimates.

Model parameter estimates are summarized in Tables \ref{tab:est_pars_base}, \ref{tab:est_pars_selex}, \ref{tab:est_pars_cv}, and \ref{tab:est_pars_M}. Negative log likelihood values and management measures for the four Gmacs scenarios are compared in Table \ref{tab:likelihood_components}. Estimated abundances by stage and mature male biomasses for three of the scenarios are listed in Tables \ref{tab:pop_abundance_2015}, \ref{tab:pop_abundance_base}, and \ref{tab:pop_abundance_selex}.

The scenarios that estimated stage-1 and stage-2 selectivities fit the data better. The scenario with additional CV for the pot survey CPUE fit the trawl survey data better and resulted in higher abundance and biomass estimates in the most recent years. Estimated directed pot and trawl survey selectivities > 1.0 for stage-2 crab are troublesome.

c. Graphs of estimates.

Estimated (and fixed) selectivities are compared in Figure \ref{fig:selectivity} and molting probabilities are shown in Figure \ref{fig:molt_prob}. The various model fits to total male ($>$ 89 mm CL) trawl survey biomass are compared in Figure \ref{fig:trawl_survey_biomass}, and the fits to pot survey CPUE are compared in Figure \ref{fig:pot_survey_cpue}. Standardized residuals of total male trawl survey biomass and pot survey CPUE are plotted in Figure \ref{fig:bts_resid}. Fits to stage compositions for trawl survey, pot survey, and commercial observer data are shown in Figures \ref{fig:sc_pot}, \ref{fig:sc_pot_discarded}, and \ref{fig:sc_trawl_discarded} for the all scenarios. Bubble plots of stage composition residuals for trawl survey, pot survey, and commercial observer data are shown in Figures \ref{fig:sc_pot_res}, \ref{fig:sc_pot_discarded_res}, and \ref{fig:sc_trawl_discarded_res} for the Gmacs base model. Fits to retained catch biomass and bycatch death biomass are shown for all Gmacs scenarios in Figure \ref{fig:fit_to_catch}. Estimated recruitment and mature male biomass are compared in Figures \ref{fig:recruitment} and \ref{fig:mmb}, respectively.

d. Graphic evaluation of the fit to the data.

Model estimated relative survey biomasses are different in each of the scenarios. The Gmacs base model has a comparatively low biomass in the early years compared with the other scenarios, including the 2015 model (Figure \ref{fig:trawl_survey_biomass}). The Gmacs CV scenario that includes additional CV for the pot survey CPUE results in much higher biomass estimates in recent years (Figure \ref{fig:trawl_survey_biomass}). Estimated pot survey CPUEs are also dependent on scenarios, and the difference among scenarios are very similar to the relative survey biomasses (Figure \ref{fig:pot_survey_cpue}).

Estimated recruitment to the model is variable over time (Figure \ref{fig:recruitment}). Estimated recruitment during recent years is generally low in all scenarios. Estimated mature male biomass on 15 February also fluctuates strongly over time. The high biomass estimates in recent years for the Gmacs CV scenario is quite different to the other scenarios (Figure \ref{fig:mmb}).

e. Retrospective and historic analyses.

Gmacs retrospective analyses under development.

f. Uncertainty and sensitivity analyses.

Estimated standard deviations of parameters for the four Gmacs scenarios are summarized in Tables \ref{tab:est_pars_base}, \ref{tab:est_pars_selex}, \ref{tab:est_pars_cv}, and \ref{tab:est_pars_M}. Probabilities for mature male biomass and OFL in 2015 are illustrated in section “F. Calculation of the OFL”.

g. Comparison of alternative model scenarios.

Discussion to come.

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


```
## Error in data.frame(Parameter, Estimate, SD): arguments imply differing number of rows: 10, 4
```

\begin{table}[ht]
\centering
\caption{Model parameter estimates and standard deviations (SD) for the {\bf Gmacs base} model.} 
\label{tab:est_pars_base}
\begin{tabular}{rrrrrrr}
  \hline
Year & Stage-1 (90-104 mm) & Stage-2 (105-119 mm) & Stage-3 (120+ mm) & Total CPUE & CV & Number of crabs \\ 
  \hline
1995.0000000 & 1.9190000 & 3.1980000 & 6.9220000 & 12.0420000 & 0.1300000 & 4624.0000000 \\ 
  1998.0000000 & 0.9640000 & 2.7630000 & 8.8040000 & 12.5310000 & 0.0600000 & 4812.0000000 \\ 
  2001.0000000 & 1.2660000 & 1.7370000 & 5.4870000 & 8.4770000 & 0.0800000 & 3255.0000000 \\ 
  2004.0000000 & 0.1120000 & 0.4140000 & 1.1410000 & 1.6670000 & 0.1500000 & 640.0000000 \\ 
  2007.0000000 & 1.0860000 & 2.7210000 & 4.8360000 & 8.6430000 & 0.0900000 & 3319.0000000 \\ 
  2010.0000000 & 1.3260000 & 3.2760000 & 5.6070000 & 10.2090000 & 0.1300000 & 3920.0000000 \\ 
  2013.0000000 & 0.8780000 & 1.3980000 & 3.3670000 & 5.6430000 & 0.1900000 & 2167.0000000 \\ 
  2015.0000000 & 0.1980000 & 0.6820000 & 1.9240000 & 2.8050000 & 0.1800000 & 1077.0000000 \\ 
   \hline
\end{tabular}
\end{table}


```
## Error in M[[3]]: subscript out of bounds
```

```
## Error in data.frame(Parameter, Estimate, SD): arguments imply differing number of rows: 18, 4
```

\begin{table}[ht]
\centering
\caption{Model parameter estimates and standard deviations (SD) for the {\bf Gmacs selex} model that estimates stage-1 and stage-2 selectivity.} 
\label{tab:est_pars_selex}
\begin{tabular}{rrrrrrr}
  \hline
Year & Stage-1 (90-104 mm) & Stage-2 (105-119 mm) & Stage-3 (120+ mm) & Total CPUE & CV & Number of crabs \\ 
  \hline
1995.0000000 & 1.9190000 & 3.1980000 & 6.9220000 & 12.0420000 & 0.1300000 & 4624.0000000 \\ 
  1998.0000000 & 0.9640000 & 2.7630000 & 8.8040000 & 12.5310000 & 0.0600000 & 4812.0000000 \\ 
  2001.0000000 & 1.2660000 & 1.7370000 & 5.4870000 & 8.4770000 & 0.0800000 & 3255.0000000 \\ 
  2004.0000000 & 0.1120000 & 0.4140000 & 1.1410000 & 1.6670000 & 0.1500000 & 640.0000000 \\ 
  2007.0000000 & 1.0860000 & 2.7210000 & 4.8360000 & 8.6430000 & 0.0900000 & 3319.0000000 \\ 
  2010.0000000 & 1.3260000 & 3.2760000 & 5.6070000 & 10.2090000 & 0.1300000 & 3920.0000000 \\ 
  2013.0000000 & 0.8780000 & 1.3980000 & 3.3670000 & 5.6430000 & 0.1900000 & 2167.0000000 \\ 
  2015.0000000 & 0.1980000 & 0.6820000 & 1.9240000 & 2.8050000 & 0.1800000 & 1077.0000000 \\ 
   \hline
\end{tabular}
\end{table}


```
## Error in M[[4]]: subscript out of bounds
```

```
## Error in data.frame(Parameter, Estimate, SD): arguments imply differing number of rows: 19, 4
```

\begin{table}[ht]
\centering
\caption{Model parameter estimates and standard deviations (SD) for the {\bf Gmacs CV} model that estimates stage-1 and stage-2 selectivity.} 
\label{tab:est_pars_cv}
\begin{tabular}{rrrrrrr}
  \hline
Year & Stage-1 (90-104 mm) & Stage-2 (105-119 mm) & Stage-3 (120+ mm) & Total CPUE & CV & Number of crabs \\ 
  \hline
1995.0000000 & 1.9190000 & 3.1980000 & 6.9220000 & 12.0420000 & 0.1300000 & 4624.0000000 \\ 
  1998.0000000 & 0.9640000 & 2.7630000 & 8.8040000 & 12.5310000 & 0.0600000 & 4812.0000000 \\ 
  2001.0000000 & 1.2660000 & 1.7370000 & 5.4870000 & 8.4770000 & 0.0800000 & 3255.0000000 \\ 
  2004.0000000 & 0.1120000 & 0.4140000 & 1.1410000 & 1.6670000 & 0.1500000 & 640.0000000 \\ 
  2007.0000000 & 1.0860000 & 2.7210000 & 4.8360000 & 8.6430000 & 0.0900000 & 3319.0000000 \\ 
  2010.0000000 & 1.3260000 & 3.2760000 & 5.6070000 & 10.2090000 & 0.1300000 & 3920.0000000 \\ 
  2013.0000000 & 0.8780000 & 1.3980000 & 3.3670000 & 5.6430000 & 0.1900000 & 2167.0000000 \\ 
  2015.0000000 & 0.1980000 & 0.6820000 & 1.9240000 & 2.8050000 & 0.1800000 & 1077.0000000 \\ 
   \hline
\end{tabular}
\end{table}


```
## Error in M[[5]]: subscript out of bounds
```

```
## Error in data.frame(Parameter, Estimate, SD): arguments imply differing number of rows: 17, 3
```

\begin{table}[ht]
\centering
\caption{Model parameter estimates and standard deviations (SD) for the {\bf Gmacs M} model that estimates stage-1 and stage-2 selectivity.} 
\label{tab:est_pars_M}
\begin{tabular}{rrrrrrr}
  \hline
Year & Stage-1 (90-104 mm) & Stage-2 (105-119 mm) & Stage-3 (120+ mm) & Total CPUE & CV & Number of crabs \\ 
  \hline
1995.0000000 & 1.9190000 & 3.1980000 & 6.9220000 & 12.0420000 & 0.1300000 & 4624.0000000 \\ 
  1998.0000000 & 0.9640000 & 2.7630000 & 8.8040000 & 12.5310000 & 0.0600000 & 4812.0000000 \\ 
  2001.0000000 & 1.2660000 & 1.7370000 & 5.4870000 & 8.4770000 & 0.0800000 & 3255.0000000 \\ 
  2004.0000000 & 0.1120000 & 0.4140000 & 1.1410000 & 1.6670000 & 0.1500000 & 640.0000000 \\ 
  2007.0000000 & 1.0860000 & 2.7210000 & 4.8360000 & 8.6430000 & 0.0900000 & 3319.0000000 \\ 
  2010.0000000 & 1.3260000 & 3.2760000 & 5.6070000 & 10.2090000 & 0.1300000 & 3920.0000000 \\ 
  2013.0000000 & 0.8780000 & 1.3980000 & 3.3670000 & 5.6430000 & 0.1900000 & 2167.0000000 \\ 
  2015.0000000 & 0.1980000 & 0.6820000 & 1.9240000 & 2.8050000 & 0.1800000 & 1077.0000000 \\ 
   \hline
\end{tabular}
\end{table}


```
## Error in M[[ii]]: subscript out of bounds
```

```
## Error in data.frame(Model, Parameter, Estimate): arguments imply differing number of rows: 4, 65
```

```
## Error: Key column 'Model' does not exist in input.
```

\begin{table}[ht]
\centering
\caption{Comparisons of model parameter estimates for the four Gmacs model scenarios.} 
\label{tab:est_pars_all}
\begin{tabular}{rrrrrrr}
  \hline
Year & Stage-1 (90-104 mm) & Stage-2 (105-119 mm) & Stage-3 (120+ mm) & Total CPUE & CV & Number of crabs \\ 
  \hline
1995.000 & 1.919 & 3.198 & 6.922 & 12.042 & 0.130 & 4624.000 \\ 
  1998.000 & 0.964 & 2.763 & 8.804 & 12.531 & 0.060 & 4812.000 \\ 
  2001.000 & 1.266 & 1.737 & 5.487 & 8.477 & 0.080 & 3255.000 \\ 
  2004.000 & 0.112 & 0.414 & 1.141 & 1.667 & 0.150 & 640.000 \\ 
  2007.000 & 1.086 & 2.721 & 4.836 & 8.643 & 0.090 & 3319.000 \\ 
  2010.000 & 1.326 & 3.276 & 5.607 & 10.209 & 0.130 & 3920.000 \\ 
  2013.000 & 0.878 & 1.398 & 3.367 & 5.643 & 0.190 & 2167.000 \\ 
  2015.000 & 0.198 & 0.682 & 1.924 & 2.805 & 0.180 & 1077.000 \\ 
   \hline
\end{tabular}
\end{table}




```
## Error in M[[ii]]: subscript out of bounds
```

```
## Error in names(df) <- c("Component", "Gmacs base", "Gmacs selex", "Gmacs CV", : 'names' attribute [5] must be the same length as the vector [2]
```

\begin{table}[ht]
\centering
\caption{Comparisons of negative log-likelihood values and management measures for the four Gmacs model scenarios. Biomass and OFL are in tonnes.} 
\label{tab:likelihood_components}
\begin{tabular}{lr}
  \hline
rownames.df. & v \\ 
  \hline
Pot Retained Catch & -67.01 \\ 
  Pot Discarded Catch & 13.13 \\ 
  Trawl bycatch Discarded Catch & -6.61 \\ 
  Fixed bycatch Discarded Catch & -6.59 \\ 
  NMFS Trawl Survey & 20.78 \\ 
  ADF\&G Pot Survey CPUE & 82.59 \\ 
  Directed Pot LF & 12.52 \\ 
  NMFS Trawl LF & 63.35 \\ 
  ADF\&G Pot LF & 4.65 \\ 
  Recruitment deviations & 27.05 \\ 
  F penalty & 9.56 \\ 
  M penalty & 6.48 \\ 
  Prior & 2.30 \\ 
  Total & 162.22 \\ 
  Total estimated parameters & 267.00 \\ 
  \$MMB\_2015\$ & 9516.57 \\ 
  Fofl & 0.37 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Population abundances (N) by crab stage in numbers of crab and mature male biomass (MMB) at survey in tonnes on 15 February for the {\bf 2015 model}. All abundances are at time of survey (season 3).} 
\label{tab:pop_abundance_2015}
\begin{tabular}{rrrrr}
  \hline
Year & $N_1$ & $N_2$ & $N_3$ & MMB \\ 
  \hline
1978 & 3782 & 2419 & 1678 & 10058 \\ 
  1979 & 4842 & 2943 & 2203 & 13877 \\ 
  1980 & 4219 & 3805 & 3266 & 20946 \\ 
  1981 & 1756 & 3734 & 4604 & 21430 \\ 
  1982 & 1876 & 2217 & 4780 & 15587 \\ 
  1983 & 1013 & 1760 & 3410 & 9631 \\ 
  1984 & 866 & 1107 & 2021 & 6761 \\ 
  1985 & 1279 & 838 & 1499 & 6231 \\ 
  1986 & 1896 & 998 & 1282 & 6272 \\ 
  1987 & 1865 & 1418 & 1372 & 7529 \\ 
  1988 & 1653 & 1538 & 1646 & 8454 \\ 
  1989 & 2649 & 1455 & 1889 & 9711 \\ 
  1990 & 1719 & 2009 & 2082 & 10700 \\ 
  1991 & 2467 & 1643 & 2390 & 9989 \\ 
  1992 & 2717 & 1931 & 2163 & 10338 \\ 
  1993 & 2970 & 2176 & 2269 & 11233 \\ 
  1994 & 1745 & 2394 & 2399 & 11099 \\ 
  1995 & 1848 & 1752 & 2432 & 10826 \\ 
  1996 & 2151 & 1619 & 2311 & 9926 \\ 
  1997 & 1306 & 1747 & 2144 & 8600 \\ 
  1998 & 852 & 1284 & 1800 & 4240 \\ 
  1999 & 456 & 415 & 691 & 3579 \\ 
  2000 & 479 & 405 & 785 & 3914 \\ 
  2001 & 479 & 416 & 859 & 4218 \\ 
  2002 & 215 & 419 & 926 & 4478 \\ 
  2003 & 454 & 266 & 983 & 4343 \\ 
  2004 & 293 & 354 & 954 & 4435 \\ 
  2005 & 656 & 290 & 974 & 4365 \\ 
  2006 & 970 & 481 & 958 & 4740 \\ 
  2007 & 717 & 727 & 1040 & 5493 \\ 
  2008 & 1252 & 647 & 1205 & 6058 \\ 
  2009 & 1130 & 947 & 1329 & 6666 \\ 
  2010 & 1058 & 968 & 1483 & 6220 \\ 
  2011 & 896 & 920 & 1432 & 5410 \\ 
  2012 & 582 & 803 & 1231 & 4643 \\ 
  2013 & 682 & 586 & 1062 & 5379 \\ 
  2014 & 619 & 594 & 1180 & 5472 \\ 
  2015 & 496 & 557 & 1218 & 5907 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Population abundances (N) by crab stage in numbers of crab, mature male biomass (MMB) at survey in tonnes on 15 February for the {\bf Gmacs base} model. All abundances are at time of survey (season 3).} 
\label{tab:pop_abundance_base}
\begin{tabular}{rrrrr}
  \hline
Year & $N_1$ & $N_2$ & $N_3$ & MMB \\ 
  \hline
1978 & 3377 & 2160 & 1106 & 11346 \\ 
  1979 & 3567 & 2917 & 2535 & 16937 \\ 
  1980 & 2423 & 2986 & 3890 & 24158 \\ 
  1981 & 1435 & 2394 & 5049 & 22489 \\ 
  1982 & 1289 & 1608 & 4681 & 15546 \\ 
  1983 & 1151 & 1435 & 2426 & 8716 \\ 
  1984 & 965 & 1237 & 1210 & 6222 \\ 
  1985 & 855 & 961 & 896 & 6128 \\ 
  1986 & 1057 & 818 & 1339 & 6517 \\ 
  1987 & 1272 & 871 & 1262 & 7533 \\ 
  1988 & 1135 & 778 & 928 & 8298 \\ 
  1989 & 1360 & 985 & 1169 & 9771 \\ 
  1990 & 1376 & 1099 & 1327 & 11301 \\ 
  1991 & 2320 & 1175 & 1840 & 11169 \\ 
  1992 & 1712 & 1706 & 2142 & 11457 \\ 
  1993 & 1529 & 1523 & 1560 & 11776 \\ 
  1994 & 1712 & 1487 & 1692 & 10967 \\ 
  1995 & 1780 & 1474 & 1805 & 11228 \\ 
  1996 & 2002 & 1537 & 2483 & 11046 \\ 
  1997 & 1759 & 1646 & 2506 & 9914 \\ 
  1998 & 1570 & 1469 & 1489 & 6994 \\ 
  1999 & 1732 & 1494 & 1664 & 3187 \\ 
  2000 & 1598 & 1478 & 1663 & 3956 \\ 
  2001 & 1261 & 1443 & 2362 & 4647 \\ 
  2002 & 987 & 1193 & 2027 & 5149 \\ 
  2003 & 435 & 525 & 582 & 5285 \\ 
  2004 & 556 & 301 & 567 & 5529 \\ 
  2005 & 531 & 415 & 679 & 5645 \\ 
  2006 & 496 & 453 & 854 & 6114 \\ 
  2007 & 349 & 432 & 989 & 7200 \\ 
  2008 & 312 & 385 & 883 & 8258 \\ 
  2009 & 447 & 330 & 1042 & 8586 \\ 
  2010 & 385 & 363 & 1080 & 8255 \\ 
  2011 & 618 & 350 & 1159 & 7836 \\ 
  2012 & 983 & 467 & 1203 & 7296 \\ 
  2013 & 877 & 416 & 1073 & 8464 \\ 
  2014 & 894 & 683 & 1279 & 8738 \\ 
  2015 & 1107 & 733 & 1497 & 9517 \\ 
   \hline
\end{tabular}
\end{table}


```
## Error in M[[3]]: subscript out of bounds
```

\begin{table}[ht]
\centering
\caption{Population abundances (N) by crab stage in numbers of crab, mature male biomass (MMB) at survey in tonnes on 15 February for {\bf Gmacs selex} model. All abundances are at time of survey (season 3).} 
\label{tab:pop_abundance_selex}
\begin{tabular}{rrrrr}
  \hline
Year & $N_1$ & $N_2$ & $N_3$ & MMB \\ 
  \hline
1978 & 3377 & 2160 & 1106 & 11346 \\ 
  1979 & 3567 & 2917 & 2535 & 16937 \\ 
  1980 & 2423 & 2986 & 3890 & 24158 \\ 
  1981 & 1435 & 2394 & 5049 & 22489 \\ 
  1982 & 1289 & 1608 & 4681 & 15546 \\ 
  1983 & 1151 & 1435 & 2426 & 8716 \\ 
  1984 & 965 & 1237 & 1210 & 6222 \\ 
  1985 & 855 & 961 & 896 & 6128 \\ 
  1986 & 1057 & 818 & 1339 & 6517 \\ 
  1987 & 1272 & 871 & 1262 & 7533 \\ 
  1988 & 1135 & 778 & 928 & 8298 \\ 
  1989 & 1360 & 985 & 1169 & 9771 \\ 
  1990 & 1376 & 1099 & 1327 & 11301 \\ 
  1991 & 2320 & 1175 & 1840 & 11169 \\ 
  1992 & 1712 & 1706 & 2142 & 11457 \\ 
  1993 & 1529 & 1523 & 1560 & 11776 \\ 
  1994 & 1712 & 1487 & 1692 & 10967 \\ 
  1995 & 1780 & 1474 & 1805 & 11228 \\ 
  1996 & 2002 & 1537 & 2483 & 11046 \\ 
  1997 & 1759 & 1646 & 2506 & 9914 \\ 
  1998 & 1570 & 1469 & 1489 & 6994 \\ 
  1999 & 1732 & 1494 & 1664 & 3187 \\ 
  2000 & 1598 & 1478 & 1663 & 3956 \\ 
  2001 & 1261 & 1443 & 2362 & 4647 \\ 
  2002 & 987 & 1193 & 2027 & 5149 \\ 
  2003 & 435 & 525 & 582 & 5285 \\ 
  2004 & 556 & 301 & 567 & 5529 \\ 
  2005 & 531 & 415 & 679 & 5645 \\ 
  2006 & 496 & 453 & 854 & 6114 \\ 
  2007 & 349 & 432 & 989 & 7200 \\ 
  2008 & 312 & 385 & 883 & 8258 \\ 
  2009 & 447 & 330 & 1042 & 8586 \\ 
  2010 & 385 & 363 & 1080 & 8255 \\ 
  2011 & 618 & 350 & 1159 & 7836 \\ 
  2012 & 983 & 467 & 1203 & 7296 \\ 
  2013 & 877 & 416 & 1073 & 8464 \\ 
  2014 & 894 & 683 & 1279 & 8738 \\ 
  2015 & 1107 & 733 & 1497 & 9517 \\ 
   \hline
\end{tabular}
\end{table}

\newpage\clearpage

![Catches of 181 male blue king crab measuring at least 90 mm CL from the 2014 NMFS trawl-survey at the 56 stations used to assess the SMBKC stock. Note that the area north of St. Matthew Island, which includes the large catch of 67 crab at station R-24, is not represented in the ADF&G pot-survey data used in the assessment.\label{fig:catch181}](figure/Fig4.png)

![NFMS Bering Sea reporting areas. Estimates of SMBKC bycatch in the groundfish fisheries are based on NMFS observer data from reporting areas 524 and 521.\label{fig:reporting_areas}](figure/Fig5.png)

\newpage\clearpage

![Comparisons of the estimated (and fixed to match the 2015 model selectivities in the Gmacs base scenario) stage-1 and stage-2 selectivities for each of the different model scenarios (the stage-3 selectivities are all fixed at 1). Estimated selectivities are shown for the directed pot fishery, the trawl bycatch fishery, the fixed bycatch fishery, the NMFS trawl survey, and the ADF&G pot survey. Two selectivity periods are estimated in the directed pot fishery, from 1978-2008 and 2009-2015.\label{fig:selectivity}](figure/selectivity-1.png)

![Molting probabilities by stage used in all of the Gmacs model scenarios.\label{fig:molt_prob}](figure/molt_prob-1.png)

![Comparisons of area-swept estimates of total male survey biomass (tonnes) and model predictions for the 2015 model and each of the Gmacs model scenarios. The error bars are plus and minus 2 standard deviations.\label{fig:trawl_survey_biomass}](figure/trawl_survey_biomass-1.png)

\newpage\clearpage

![Comparisons of total male pot survey CPUEs and model predictions for the 2015 model and each of the Gmacs model scenarios. The additional CV for the pot survey CPUE in the Gmacs CV scenario is not shown. The error bars are plus and minus 2 standard deviations.\label{fig:pot_survey_cpue}](figure/pot_survey_cpue-1.png)

![Comparisons of total male pot survey CPUEs and model predictions for the 2015 model and each of the Gmacs model scenarios. The additional CV for the pot survey CPUE is shown. The error bars are plus and minus 2 standard deviations.\label{fig:pot_survey_cpue_CV}](figure/pot_survey_cpue_CV-1.png)

![Standardized residuals for area-swept estimates of total male survey biomass and total male pot survey CPUEs for each of the Gmacs model scenarios. \label{fig:bts_resid}](figure/bts_resid-1.png)

\newpage\clearpage

![Observed and model estimated size-frequencies of SMBKC by year retained in the directed pot fishery for the 2015 model and each of the Gmacs model scenarios.\label{fig:sc_pot}](figure/sc_pot-1.png)

![Observed and model estimated size-frequencies of discarded male SMBKC by year in the NMFS trawl survey for the 2015 model and each of the Gmacs model scenarios.\label{fig:sc_pot_discarded}](figure/sc_pot_discarded-1.png)

![Observed and model estimated size-frequencies of discarded SMBKC by year in the ADF&G pot survey for the 2015 model and each of the Gmacs model scenarios.\label{fig:sc_trawl_discarded}](figure/sc_trawl_discarded-1.png)

![Bubble plots of residuals by stage and year for the directed pot fishery size composition data for St. Mathew Island blue king crab (SMBKC) in the **Gmacs base** model.\label{fig:sc_pot_res}](figure/sc_pot_res-1.png)


```
## Error in .get_sizeComps_df(M): object 'Mselex' not found
```

![Bubble plots of residuals by stage and year for the NMFS trawl survey size composition data for St. Mathew Island blue king crab (SMBKC) in the **Gmacs base** model.\label{fig:sc_pot_discarded_res}](figure/sc_pot_discarded_res-1.png)


```
## Error in .get_sizeComps_df(M): object 'Mselex' not found
```

![Bubble plots of residuals by stage and year for the ADF&G pot survey size composition data for St. Mathew Island blue king crab (SMBKC) in the **Gmacs base** model.\label{fig:sc_trawl_discarded_res}](figure/sc_trawl_discarded_res-1.png)


```
## Error in .get_sizeComps_df(M): object 'Mselex' not found
```

\newpage\clearpage

![Comparison of observed and model predicted retained catch and bycatches in each of the Gmacs models. Note that difference in units between each of the panels.\label{fig:fit_to_catch}](figure/fit_to_catch-1.png)

![Estimated recruitment time series during 1979-2015 in each of the scenarios.\label{fig:recruitment}](figure/recruitment-1.png)

![Estimated mature male biomass (MMB) time series on 15 February during 1978-2015 for each of the model scenarios.\label{fig:mmb}](figure/mature_male_biomass-1.png)


```
## Error in `colnames<-`(`*tmp*`, value = c("Male", NA)): length of 'dimnames' [2] not equal to array extent
```

![Distribution of carapace width (mm) at recruitment.\label{fig:init_rec}](figure/init_rec-1.png)

![Growth increment (mm) each molt.\label{fig:growth_inc}](figure/growth_inc-1.png)

![Probability of growth transition by stage. Each of the panels represent the stage before growth. The x-axes represent the stage after a growth (ignoring the probability of molting).\label{fig:growth_trans}](figure/growth_trans-1.png)

![Probability of size transition by stage (i.e. the combination of the growth matrix and molting probabilities). Each of the panels represent the stage before a transition. The x-axes represent the stage after a transition.\label{fig:size_trans}](figure/size_trans-1.png)

![Numbers by stage each year (15 February) in each of the models including the 2015 model.\label{fig:init_N}](figure/init_N-1.png)

![Time-varying natural mortality ($M_t$). Estimated pulse period occurs in 1998/99 (i.e. $M_{1998}$). \label{fig:M_t}](figure/natural_mortality-1.png)


\newpage\clearpage

# Appendix A: SMBKC Model Description

## 1. Introduction

The Gmacs model has been specified to account only for male crab at least 90 mm in carapace length (CL). These are partitioned into three stages (size-classes) determined by CL measurements of (1) 90-104 mm, (2) 105-119 mm, and (3) 120+ mm. For management of the St. Matthew Island blue king crab (SMBKC) fishery, 120 mm CL is used as the proxy value for the legal measurement of 5.5 mm in carapace width (CW), whereas 105 mm CL is the management proxy for mature-male size (5 AAC 34.917 (d)). Accordingly, within the model only stage-3 crab are retained in the directed fishery, and stage-2 and stage-3 crab together comprise the collection of mature males. Some justification for the 105 mm value is presented in Pengilly and Schmidt (1995), who used it in developing the current regulatory SMBKC harvest strategy. The term “recruit” here designates recruits to the model, i.e., annual new stage-1 crab, rather than recruits to the fishery. The following description of model structure reflects the Gmacs base model configuration.

## 2. Model Population Dynamics

Within the model, the beginning of the crab year is assumed contemporaneous with the NMFS trawl survey, nominally assigned a date of 1 July. MMB is measured 15 February. To accomodate this, each model year is split into four seasons:
\begin{enumerate}
    \item Season 1
    \begin{itemize}
        \item Beginning of the SMBKC fishing year (1 July)
        \item Surveys
    \end{itemize}
    \item Season 2
    \begin{itemize}
        \item $M = 0.44$ and catch
    \end{itemize}
    \item Season 3
    \begin{itemize}
        \item $M = 0.185$
        \item Calculate MMB (15 February)
    \end{itemize}
    \item Season 4
    \begin{itemize}
        \item $M = 0.375$
        \item Growth and molting
        \item Recruitment (all to stage-1)
    \end{itemize}
\end{enumerate}

With boldface lowercase letters indicating vector quantities we designate the vector of stage abundances during season $t$ and year $y$ as
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
    \boldsymbol{r}_{t,y} = \left[ \bar{R}, 0, 0 \right]^\top,
\end{equation}
where $\bar{R}$ is the average annual recruitment. The basic population dynamics underlying Gmacs can thus be described as
\begin{align}
    \boldsymbol{n}_{t+1,y} &= \boldsymbol{S}_{t,y} \boldsymbol{n}_{t,y}, &\text{ if } t<4 \notag\\
    \boldsymbol{n}_{t,y+1} &= \boldsymbol{G} \boldsymbol{S}_{t,y} \boldsymbol{n}_{t,y} + \boldsymbol{r}_{t,y}, &\text{ if } t=4
\end{align}

The natural mortality
\begin{equation}
    M_{t,y} = \bar{M}_t + \delta_y^M \text{ where } \delta_y^M \sim \mathcal{N} \left( 0, \sigma_M^2 \right)
\end{equation}
where $\bar{M}_t = 0, 0.44$ and

The fishing mortality by year $y$ and season $t$ is denoted $F_{t,y}$ and calculated as
\begin{equation}
    F_{t,y} = F_{t,y}^\text{df} + F_{t,y}^\text{tb} + F_{t,y}^\text{fb}
\end{equation}
where $F_{t,y}^\text{df}$ is the fishing mortality associated with the directed fishery, $F_{t,y}^\text{tb}$ is the fishing mortality associated with the trawl bycatch fishery, $F_{t,y}^\text{fb}$ is the fishing mortality associated with the fixed bycatch fishery.

Aside from natural mortality and molting and growth, only the directed fishery and some limited bycatch mortality in the groundfish fisheries are assumed to affect the stock. Nontrivial bycatch mortality with another fishery, as occurred in 2012/13, is assumed to be accounted for in the model in the estimate of groundfish bycatch mortality. The directed fishery is not modeled as a mid-season pulse occurring at time $\pi_t$ with full-selection fishing mortality $F_t$ relative to stage-3 crab. Year-t directed-fishery removals from the stock are computed as
$$R^{df}_t = H^{df} S^{df} (1 - e^{F^{df}_t}) e^{-\tau_t M} N_t$$
where the diagonal matrices
\begin{equation}
  \boldsymbol{H}^\text{df} = \left[ \begin{array}{ccc}
    h^\text{df} & 0 & 0 \\
    0 & h^\text{df} & 0 \\
    0 & 0 & 1 \end{array} \right]
\end{equation}
account for stage selectivities $s_1^\text{df}$ and $s_2^\text{df}$ and discard handling mortality $h^\text{df}$ in the directed fishery, both assumed constant over time. Yearly stage removals resulting from bycatch mortality in the groundfish trawl and fixed-gear fisheries are calculated as 15 February (0.63 yr) pulse effects in terms of the respective fishing mortalities $F_t^\text{gt}$ and $F_t^\text{gf}$ by

## 3. Model Data

Data inputs used in model estimation are listed in Table 1XX. All quantities relate to male SMBKC $\le$ 90mm CL.

$y = \{ catch, cpue, lfs \}$

## 4. Model Parameters

$\theta = \{ R_0, \bar{R}, \boldsymbol{n}_0, q_\text{pot}, cv, Mdev, sel \}$

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

The combination of the growth matrix and molting probabilities results in the stage-transition matrix for scenarios 3-11. Molting probability for stage 1 for scenarios 8, 9, 10, 11 during 1978-2000 is assumed to be 0.91 estimated from the tagging data and ratio of molting probabilities of stages 2 to stage 1 is fixed as 0.69231 from the tagging data as well.

Both surveys are assigned a nominal date of 1 July, the start of the crab year. The directed fishery is not treated as a season midpoint pulse. Groundfish bycatch is likewise not modeled as a pulse effect, occurring at the nominal time of mating, 15 February, which is also the reference date for calculation of federal management biomass quantities.

\begin{table}[ht]
\centering
\caption{Model bounds, initial values, priors and estimation phase.} 
\label{tab:bounds_pars}
\begin{tabular}{lrrrlrrr}
  \hline
Parameter & LB & Initial value & UB & Prior type & Prior par1 & Prior par2 & Phase \\ 
  \hline
$Mdev_{1998}$ & 0 & 0.0 & - & Random walk & 0 & 10 & 2 \\ 
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

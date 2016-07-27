---
title: "Saint Matthew Island Blue King Crab Stock Assessment 2016"
author:
- D'Arcy Webber
- Jie Zheng
- James Ianelli
institute: "Quantifish, ADF&G, NOAA"
date: "July 2016"
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

This assessment is done using Gmacs. The model is based upon the 3-stage length-based assessment model first presented in May 2011 by Bill Gaeuman and accepted by the CPT in May 2012. There are several differences between the Gmacs assessment and the previous model. One of the major differences being that natural and fishing mortality are continuous within any number of discrete seasons. Season length in Gmacs is controlled simply by changing the proportion of natural mortality that is applied during each season. 

## Changes in Assessment Results

Changes in assessment results depend on model scenario. The Gmacs match model scenario attempts to match the 2015 assessment by specifying the same (or similar) dynamics and parameter values. However, a different Gmacs scenario (Gmacs selex) provides a much better match to the 2015 model assessment.


# B. Responses to SSC and CPT Comments

## CPT and SSC Comments on Assessments in General
No general comments relative to crab assessments were applied in this draft preliminary assessment.

## CPT and SSC Comments Specific to SMBKC Stock Assessment
Comment:       
*The SSC and CPT requested the following models for review at the spring  2016 meeting:*   
  1. Base: try to match 2015 model but prevent dome shaped selex      
  2. Base + add CV for both surveys      
  3. Above + Francis re-weighting      
  4. Above + remove M spike      

Response:    
*Models 1, 2, and 4 above are included and evaluated in this document. The software to implement the 3rd model 
requesting Francis re-weighting is incomplete but should be available for the September 2016 meeting. *

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

1. **2015 Model**: the 2015 provided by Jie (note that an error was found in the code, this error was fixed before making comparisons).

2. **Gmacs match**: tries to match as closely as possible the 2015 Model.

3. **Gmacs base**: directed pot, NMFS trawl survey and ADF&G pot survey selectivities are estimated for stage-1 and stage-2 crab. These selectivities are bounded so that they cannot be greater than 1.

4. **Gmacs CV**: additional CV is estimated for both the NMFS trawl survey and the ADF&G pot survey as well as estimating the directed pot, NMFS trawl survey and ADF&G pot survey selectivities for stage-1 and stage-2 crab. These selectivities are bounded so that they cannot be greater than 1.

5. **Gmacs M**: natural mortality ($M$) is fixed at 0.18 $yr^{-1}$ during all years as well as estimating additional CV is estimated for both the NMFS trawl survey and the ADF&G pot survey and estimating the directed pot, NMFS trawl survey and ADF&G pot survey selectivities for stage-1 and stage-2 crab. These selectivities are bounded so that they cannot be greater than 1.

| Scenario | Selectivity estimated | Additional CV | Estimate $M_{1998}$ |
|-|-|-|-|
| Gmacs match | No  | No  | Yes |
| Gmacs base  | Yes | No  | Yes |
| Gmacs CV    | Yes | Yes | Yes |
| Gmacs M     | Yes | Yes | No  |


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

\begin{table}[ht]
\centering
\caption{Model parameter estimates and standard deviations (SD) for the {\bf Gmacs match} model.} 
\label{tab:est_pars_base}
\begin{tabular}{lrr}
  \hline
Parameter & Estimate & SD \\ 
  \hline
Natural mortality ($M$) deviation in 1998/99 & 1.6550000 & 0.1265000 \\ 
  $\log (\bar{R})$ & 13.3940000 & 0.0589080 \\ 
  $\log (N_1)$ & 14.8560000 & 0.1698400 \\ 
  $\log (N_2)$ & 14.4260000 & 0.1947500 \\ 
  $\log (N_3)$ & 14.2250000 & 0.2028600 \\ 
  ADF\&G pot survey catchability ($q$) & 0.0044854 & 0.0003114 \\ 
  $\bar{F}_\text{pot}$ & -1.3700000 & 0.0514600 \\ 
  $\bar{F}_\text{trawl bycatch}$ & -11.6660000 & 0.2112600 \\ 
  $\bar{F}_\text{fixed bycatch}$ & -9.5487000 & 0.2084600 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Model parameter estimates and standard deviations (SD) for the {\bf Gmacs base} model that estimates stage-1 and stage-2 selectivity.} 
\label{tab:est_pars_selex}
\begin{tabular}{lrr}
  \hline
Parameter & Estimate & SD \\ 
  \hline
Natural mortality ($M$) deviation in 1998/99 & 1.6747000 & 0.1294300 \\ 
  $\log (\bar{R})$ & 13.4150000 & 0.0602520 \\ 
  $\log (N_1)$ & 14.8210000 & 0.1708900 \\ 
  $\log (N_2)$ & 14.4200000 & 0.1998300 \\ 
  $\log (N_3)$ & 14.1240000 & 0.2116100 \\ 
  ADF\&G pot survey catchability ($q$) & 0.0042635 & 0.0003299 \\ 
  $\log(\bar{F}_\text{pot})$ & -1.3669000 & 0.0546850 \\ 
  $\log(\bar{F}_\text{trawl bycatch})$ & -11.6950000 & 0.2116600 \\ 
  $\log(\bar{F}_\text{fixed bycatch})$ & -9.5787000 & 0.2087800 \\ 
  Stage-1 directed pot selectivity 1978-2008 & -0.7543000 & 0.1744000 \\ 
  Stage-2 directed pot selectivity 1978-2008 & -0.4120300 & 0.1267100 \\ 
  Stage-1 directed pot selectivity 2009-2015 & -0.7642800 & 0.1824600 \\ 
  Stage-2 directed pot selectivity 2009-2015 & -0.0000000 & 0.0000280 \\ 
  Stage-1 NMFS trawl selectivity & -0.2707700 & 0.0662120 \\ 
  Stage-2 NMFS trawl selectivity & -0.0000000 & 0.0000088 \\ 
  Stage-1 ADF\&G pot selectivity & -0.8577800 & 0.1468500 \\ 
  Stage-2 ADF\&G pot selectivity & -0.1042300 & 0.0842600 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Model parameter estimates and standard deviations (SD) for the {\bf Gmacs CV} model that estimates stage-1 and stage-2 selectivity.} 
\label{tab:est_pars_cv}
\begin{tabular}{lrr}
  \hline
Parameter & Estimate & SD \\ 
  \hline
Natural mortality ($M$) deviation in 1998/99 & 1.9910000 & 0.1553600 \\ 
  $\log (R_0)$ & 13.5630000 & 0.0653290 \\ 
  $\log (\bar{R})$ & 14.8200000 & 0.1701800 \\ 
  $\log (N_1)$ & 14.3890000 & 0.2002500 \\ 
  $\log (N_2)$ & 14.1020000 & 0.2105800 \\ 
  $\log (N_3)$ & 0.0035442 & 0.0004397 \\ 
  ADF\&G pot survey catchability ($q$) & -13.8090000 & 26.0030000 \\ 
  logAddCV & -1.7541000 & 0.1815000 \\ 
  $\log(\bar{F}_\text{pot})$ & -1.4204000 & 0.0556580 \\ 
  $\log(\bar{F}_\text{trawl bycatch})$ & -11.7510000 & 0.2125500 \\ 
  $\log(\bar{F}_\text{fixed bycatch})$ & -9.6389000 & 0.2093800 \\ 
  Stage-1 directed pot selectivity 1978-2008 & -0.7704000 & 0.1748300 \\ 
  Stage-2 directed pot selectivity 1978-2008 & -0.4196900 & 0.1272100 \\ 
  Stage-1 directed pot selectivity 2009-2015 & -1.0194000 & 0.1941800 \\ 
  Stage-2 directed pot selectivity 2009-2015 & -0.0079593 & 0.0979160 \\ 
  Stage-1 NMFS trawl selectivity & -0.3073500 & 0.0643110 \\ 
  Stage-2 NMFS trawl selectivity & -0.0000000 & 0.0000118 \\ 
  Stage-1 ADF\&G pot selectivity & -1.0905000 & 0.1434700 \\ 
  Stage-2 ADF\&G pot selectivity & -0.2016800 & 0.0829760 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Model parameter estimates and standard deviations (SD) for the {\bf Gmacs M} model that estimates stage-1 and stage-2 selectivity.} 
\label{tab:est_pars_M}
\begin{tabular}{lrr}
  \hline
Parameter & Estimate & SD \\ 
  \hline
$\log (\bar{R})$ & 13.4320000 & 0.0620940 \\ 
  $\log (N_1)$ & 14.8260000 & 0.1724300 \\ 
  $\log (N_2)$ & 14.4680000 & 0.1982800 \\ 
  $\log (N_3)$ & 14.1590000 & 0.2131800 \\ 
  ADF\&G pot survey catchability ($q$) & 0.0039705 & 0.0005124 \\ 
  $\log(\bar{F}_\text{pot})$ & -1.3571000 & 0.0574230 \\ 
  $\log(\bar{F}_\text{trawl bycatch})$ & -11.6700000 & 0.2124900 \\ 
  $\log(\bar{F}_\text{fixed bycatch})$ & -9.5584000 & 0.2093100 \\ 
  Stage-1 directed pot selectivity 1978-2008 & -0.6308200 & 0.1799900 \\ 
  Stage-2 directed pot selectivity 1978-2008 & -0.3728000 & 0.1279900 \\ 
  Stage-1 directed pot selectivity 2009-2015 & -0.9814600 & 0.1930700 \\ 
  Stage-2 directed pot selectivity 2009-2015 & -0.0000001 & 0.0002349 \\ 
  Stage-1 NMFS trawl selectivity & -0.2169300 & 0.0618870 \\ 
  Stage-2 NMFS trawl selectivity & -0.0000000 & 0.0000074 \\ 
  Stage-1 ADF\&G pot selectivity & -0.9952800 & 0.1425400 \\ 
  Stage-2 ADF\&G pot selectivity & -0.1518900 & 0.0826700 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Comparisons of model parameter estimates for the four Gmacs model scenarios.} 
\label{tab:est_pars_all}
\begin{tabular}{llr}
  \hline
Model & Parameter & Estimate \\ 
  \hline
Gmacs match & Natural mortality ($M$) deviation in 1998/99 & 1.655 \\ 
  Gmacs match & $\log (\bar{R})$ & 13.394 \\ 
  Gmacs match & $\log (N_1)$ & 14.856 \\ 
  Gmacs match & $\log (N_2)$ & 14.426 \\ 
  Gmacs match & $\log (N_3)$ & 14.225 \\ 
  Gmacs match & ADF\&G pot survey catchability ($q$) & 0.004 \\ 
  Gmacs match & logAddCV & -1.370 \\ 
  Gmacs match & $\log(\bar{F}_\text{trawl bycatch})$ & -11.666 \\ 
  Gmacs match & $\log(\bar{F}_\text{fixed bycatch})$ & -9.549 \\ 
  Gmacs base & Stage-1 directed pot selectivity 1978-2008 & 1.675 \\ 
  Gmacs base & Natural mortality ($M$) deviation in 1998/99 & 13.415 \\ 
  Gmacs base & $\log (\bar{R})$ & 14.821 \\ 
  Gmacs base & $\log (N_1)$ & 14.420 \\ 
  Gmacs base & $\log (N_2)$ & 14.124 \\ 
  Gmacs base & $\log (N_3)$ & 0.004 \\ 
  Gmacs base & ADF\&G pot survey catchability ($q$) & -1.367 \\ 
  Gmacs base & logAddCV & -11.695 \\ 
  Gmacs base & $\log(\bar{F}_\text{trawl bycatch})$ & -9.579 \\ 
  Gmacs base & $\log(\bar{F}_\text{fixed bycatch})$ & -0.754 \\ 
  Gmacs base & Stage-1 directed pot selectivity 1978-2008 & -0.412 \\ 
  Gmacs base & Stage-2 directed pot selectivity 1978-2008 & -0.764 \\ 
  Gmacs base & Stage-1 directed pot selectivity 2009-2015 & -0.000 \\ 
  Gmacs base & Stage-2 directed pot selectivity 2009-2015 & -0.271 \\ 
  Gmacs base & Stage-1 NMFS trawl selectivity & -0.000 \\ 
  Gmacs base & Stage-2 NMFS trawl selectivity & -0.858 \\ 
  Gmacs base & Stage-1 ADF\&G pot selectivity & -0.104 \\ 
  Gmacs CV & Stage-2 ADF\&G pot selectivity & 1.991 \\ 
  Gmacs CV & - & 13.563 \\ 
  Gmacs CV & Natural mortality ($M$) deviation in 1998/99 & 14.820 \\ 
  Gmacs CV & $\log (\bar{R})$ & 14.389 \\ 
  Gmacs CV & $\log (N_1)$ & 14.102 \\ 
  Gmacs CV & $\log (N_2)$ & 0.004 \\ 
  Gmacs CV & $\log (N_3)$ & -13.809 \\ 
  Gmacs CV & ADF\&G pot survey catchability ($q$) & -1.754 \\ 
  Gmacs CV & logAddCV & -1.420 \\ 
  Gmacs CV & $\log(\bar{F}_\text{pot})$ & -11.751 \\ 
  Gmacs CV & $\log(\bar{F}_\text{trawl bycatch})$ & -9.639 \\ 
  Gmacs CV & $\log(\bar{F}_\text{fixed bycatch})$ & -0.770 \\ 
  Gmacs CV & Stage-1 directed pot selectivity 1978-2008 & -0.420 \\ 
  Gmacs CV & Stage-2 directed pot selectivity 1978-2008 & -1.019 \\ 
  Gmacs CV & Stage-1 directed pot selectivity 2009-2015 & -0.008 \\ 
  Gmacs CV & Stage-2 directed pot selectivity 2009-2015 & -0.307 \\ 
  Gmacs CV & Stage-1 NMFS trawl selectivity & -0.000 \\ 
  Gmacs CV & Stage-2 NMFS trawl selectivity & -1.091 \\ 
  Gmacs CV & Stage-1 ADF\&G pot selectivity & -0.202 \\ 
  Gmacs M & Stage-2 ADF\&G pot selectivity & - \\ 
  Gmacs M & Natural mortality ($M$) deviation in 1998/99 & 13.432 \\ 
  Gmacs M & $\log (\bar{R})$ & 14.826 \\ 
  Gmacs M & $\log (N_1)$ & 14.468 \\ 
  Gmacs M & $\log (N_2)$ & 14.159 \\ 
  Gmacs M & $\log (N_3)$ & 0.004 \\ 
  Gmacs M & ADF\&G pot survey catchability ($q$) & -4.321 \\ 
  Gmacs M & logAddCV & -1.658 \\ 
  Gmacs M & $\log(\bar{F}_\text{trawl bycatch})$ & -1.357 \\ 
  Gmacs M & $\log(\bar{F}_\text{fixed bycatch})$ & -11.670 \\ 
  Gmacs M & Stage-1 directed pot selectivity 1978-2008 & -9.558 \\ 
  Gmacs M & Stage-2 directed pot selectivity 1978-2008 & -0.631 \\ 
  Gmacs M & Stage-1 directed pot selectivity 2009-2015 & -0.373 \\ 
  Gmacs M & Stage-2 directed pot selectivity 2009-2015 & -0.981 \\ 
  Gmacs M & Stage-1 NMFS trawl selectivity & -0.000 \\ 
  Gmacs M & Stage-2 NMFS trawl selectivity & -0.217 \\ 
  Gmacs M & Stage-1 ADF\&G pot selectivity & -0.000 \\ 
  Gmacs M & Stage-2 ADF\&G pot selectivity & -0.995 \\ 
  Gmacs M & - & -0.152 \\ 
   \hline
\end{tabular}
\end{table}



\begin{table}[ht]
\centering
\caption{Comparisons of negative log-likelihood values and management measures for the four Gmacs model scenarios. Biomass and OFL are in tonnes.} 
\label{tab:likelihood_components}
\begin{tabular}{lrrrr}
  \hline
Component & Gmacs match & Gmacs base & Gmacs CV & Gmacs M \\ 
  \hline
Pot Retained Catch & -66.70 & -66.81 & -67.09 & -67.05 \\ 
  Pot Discarded Catch & 5.08 & 4.47 & 4.08 & 3.60 \\ 
  Trawl bycatch Discarded Catch & 22.05 & 22.05 & 22.05 & 22.05 \\ 
  Fixed bycatch Discarded Catch & 20.88 & 20.88 & 20.86 & 20.86 \\ 
  NMFS Trawl Survey & 23.46 & 21.87 & -14.64 & -8.77 \\ 
  ADF\&G Pot Survey CPUE & 58.33 & 56.14 & 9.70 & 10.90 \\ 
  Directed Pot LF & -11.96 & -12.05 & -12.18 & -11.39 \\ 
  NMFS Trawl LF & 15.31 & 20.76 & 5.99 & 7.77 \\ 
  ADF\&G Pot LF & -5.40 & -4.97 & -8.33 & -7.97 \\ 
  Recruitment deviations & 55.67 & 55.58 & 54.30 & 54.68 \\ 
  F penalty & 14.49 & 14.49 & 14.49 & 14.49 \\ 
  M penalty & 6.47 & 6.47 & 6.48 & 0.00 \\ 
  Prior & 12.82 & 15.59 & 23.68 & 26.75 \\ 
  Total & 150.52 & 154.47 & 59.38 & 65.92 \\ 
  Total estimated parameters & 272.00 & 280.00 & 282.00 & 280.00 \\ 
  \$MMB\_2015\$ & 2602.55 & 2643.80 & 4399.47 & 4082.34 \\ 
  Fofl & 0.32 & 0.32 & 0.36 & 0.36 \\ 
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
1978 & 3032380 & 1959650 & 1609350 & 4105 \\ 
  1979 & 3935440 & 2351410 & 2162280 & 5838 \\ 
  1980 & 3483360 & 3078760 & 3263590 & 9125 \\ 
  1981 & 1399440 & 3061830 & 4529080 & 9304 \\ 
  1982 & 1395390 & 1786860 & 4497980 & 6427 \\ 
  1983 & 726237 & 1329510 & 3064220 & 3382 \\ 
  1984 & 683934 & 775568 & 1553320 & 1989 \\ 
  1985 & 2205160 & 605801 & 984896 & 1669 \\ 
  1986 & 1303830 & 1410240 & 904641 & 2670 \\ 
  1987 & 1387260 & 1197070 & 1354150 & 3290 \\ 
  1988 & 1263250 & 1187840 & 1635410 & 3613 \\ 
  1989 & 2252400 & 1113040 & 1810310 & 4105 \\ 
  1990 & 1424190 & 1664200 & 2032870 & 4603 \\ 
  1991 & 1988020 & 1357180 & 2293490 & 4250 \\ 
  1992 & 2333220 & 1553010 & 2098930 & 4368 \\ 
  1993 & 2503120 & 1824300 & 2215840 & 4826 \\ 
  1994 & 1446940 & 2001220 & 2380110 & 4771 \\ 
  1995 & 1553850 & 1443750 & 2334010 & 4623 \\ 
  1996 & 1759330 & 1342640 & 2201930 & 4209 \\ 
  1997 & 1044040 & 1423500 & 2056840 & 3531 \\ 
  1998 & 656793 & 1013930 & 1642390 & 1717 \\ 
  1999 & 364932 & 338232 & 632065 & 1516 \\ 
  2000 & 400439 & 326253 & 727657 & 1681 \\ 
  2001 & 369769 & 343135 & 804742 & 1840 \\ 
  2002 & 165003 & 330775 & 874845 & 1956 \\ 
  2003 & 329593 & 206912 & 909941 & 1891 \\ 
  2004 & 231656 & 261670 & 890695 & 1913 \\ 
  2005 & 509789 & 222831 & 894291 & 1880 \\ 
  2006 & 778720 & 372468 & 901109 & 2046 \\ 
  2007 & 580634 & 579094 & 1003240 & 2390 \\ 
  2008 & 1005230 & 519548 & 1147060 & 2652 \\ 
  2009 & 919126 & 760501 & 1301030 & 2920 \\ 
  2010 & 868450 & 782376 & 1441940 & 2684 \\ 
  2011 & 712542 & 745364 & 1374460 & 2271 \\ 
  2012 & 446333 & 632141 & 1149010 & 1870 \\ 
  2013 & 517648 & 445721 & 939761 & 2196 \\ 
  2014 & 449804 & 451532 & 1051450 & 2229 \\ 
  2015 & 377699 & 410207 & 1076110 & 2410 \\ 
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
1978 & 2526261 & 1643998 & 953299 & 4296 \\ 
  1979 & 4072200 & 2192749 & 2015765 & 6195 \\ 
  1980 & 3484765 & 3033094 & 3139989 & 9988 \\ 
  1981 & 1346370 & 3020921 & 4542146 & 10440 \\ 
  1982 & 1408932 & 1764508 & 4569757 & 7406 \\ 
  1983 & 1257885 & 1574970 & 2345088 & 4351 \\ 
  1984 & 672334 & 1354005 & 1249246 & 2933 \\ 
  1985 & 586888 & 832810 & 966431 & 2615 \\ 
  1986 & 866786 & 620050 & 1306584 & 2605 \\ 
  1987 & 1239328 & 697492 & 1118610 & 3063 \\ 
  1988 & 1106464 & 622658 & 800548 & 3348 \\ 
  1989 & 1192873 & 911375 & 964702 & 3831 \\ 
  1990 & 1096956 & 979059 & 1103456 & 4792 \\ 
  1991 & 2534987 & 971267 & 1559025 & 4776 \\ 
  1992 & 1639666 & 1761178 & 1825468 & 4946 \\ 
  1993 & 1463883 & 1572206 & 1277779 & 5133 \\ 
  1994 & 1651750 & 1465013 & 1457146 & 4851 \\ 
  1995 & 1766327 & 1432567 & 1590509 & 4805 \\ 
  1996 & 2043439 & 1515065 & 2276362 & 4607 \\ 
  1997 & 1481188 & 1661695 & 2325916 & 3951 \\ 
  1998 & 1322337 & 1483203 & 1329484 & 2678 \\ 
  1999 & 1577779 & 1346430 & 1502427 & 1582 \\ 
  2000 & 1454398 & 1341546 & 1439542 & 1729 \\ 
  2001 & 818682 & 1311892 & 2084353 & 1892 \\ 
  2002 & 570388 & 899084 & 1689562 & 2007 \\ 
  2003 & 315058 & 496505 & 553924 & 1911 \\ 
  2004 & 327174 & 280693 & 607655 & 1931 \\ 
  2005 & 374366 & 278728 & 680369 & 1883 \\ 
  2006 & 347236 & 314918 & 769146 & 2032 \\ 
  2007 & 125181 & 301387 & 834265 & 2406 \\ 
  2008 & 111719 & 268976 & 744548 & 2602 \\ 
  2009 & 303061 & 165245 & 832488 & 2760 \\ 
  2010 & 194649 & 226775 & 807496 & 2582 \\ 
  2011 & 453537 & 191728 & 834024 & 2258 \\ 
  2012 & 723391 & 321005 & 836555 & 1987 \\ 
  2013 & 645088 & 286258 & 746003 & 2343 \\ 
  2014 & 432675 & 493400 & 887159 & 2403 \\ 
  2015 & 929244 & 408604 & 1030026 & 2603 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Population abundances (N) by crab stage in numbers of crab, mature male biomass (MMB) at survey in tonnes on 15 February for {\bf Gmacs selex} model. All abundances are at time of survey (season 3).} 
\label{tab:pop_abundance_selex}
\begin{tabular}{rrrrr}
  \hline
Year & $N_1$ & $N_2$ & $N_3$ & MMB \\ 
  \hline
1978 & 2441183 & 1633375 & 824040 & 3987 \\ 
  1979 & 3993698 & 2135313 & 1881186 & 5886 \\ 
  1980 & 3512873 & 2969612 & 2991380 & 9609 \\ 
  1981 & 1372100 & 3015807 & 4386748 & 10124 \\ 
  1982 & 1466492 & 1777426 & 4439615 & 7153 \\ 
  1983 & 1309274 & 1586489 & 2228038 & 4180 \\ 
  1984 & 706056 & 1390139 & 1152960 & 2848 \\ 
  1985 & 599904 & 864018 & 906835 & 2561 \\ 
  1986 & 862417 & 638094 & 1273190 & 2570 \\ 
  1987 & 1255015 & 700982 & 1099269 & 3048 \\ 
  1988 & 1120469 & 625772 & 783241 & 3356 \\ 
  1989 & 1211261 & 921187 & 952041 & 3863 \\ 
  1990 & 1118853 & 992749 & 1099515 & 4858 \\ 
  1991 & 2574268 & 988668 & 1564875 & 4839 \\ 
  1992 & 1634308 & 1789247 & 1842841 & 5009 \\ 
  1993 & 1459100 & 1597266 & 1293171 & 5209 \\ 
  1994 & 1661353 & 1471071 & 1483898 & 4954 \\ 
  1995 & 1787216 & 1440088 & 1616833 & 4912 \\ 
  1996 & 2085931 & 1529784 & 2304847 & 4711 \\ 
  1997 & 1488217 & 1690700 & 2360992 & 4088 \\ 
  1998 & 1328613 & 1509103 & 1360530 & 2789 \\ 
  1999 & 1590294 & 1359597 & 1544883 & 1619 \\ 
  2000 & 1499861 & 1353019 & 1482449 & 1784 \\ 
  2001 & 839695 & 1342485 & 2131837 & 1956 \\ 
  2002 & 597888 & 921147 & 1746269 & 2081 \\ 
  2003 & 326373 & 502726 & 577591 & 1984 \\ 
  2004 & 352196 & 285646 & 622941 & 1993 \\ 
  2005 & 386880 & 294578 & 698026 & 1938 \\ 
  2006 & 366116 & 327678 & 793871 & 2123 \\ 
  2007 & 130298 & 316333 & 863158 & 2527 \\ 
  2008 & 116287 & 282318 & 770343 & 2732 \\ 
  2009 & 300327 & 172846 & 863620 & 2899 \\ 
  2010 & 198296 & 227739 & 837070 & 2682 \\ 
  2011 & 506565 & 194199 & 860402 & 2327 \\ 
  2012 & 759441 & 351937 & 864903 & 2048 \\ 
  2013 & 677272 & 313858 & 771324 & 2406 \\ 
  2014 & 451235 & 523115 & 928650 & 2458 \\ 
  2015 & 964292 & 428983 & 1081445 & 2644 \\ 
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

![Bubble plots of residuals by stage and year for the directed pot fishery size composition data for St. Mathew Island blue king crab (SMBKC) in the **Gmacs match** model.\label{fig:sc_pot_res}](figure/sc_pot_res-1.png)

![Bubble plots of residuals by stage and year for the directed pot fishery size composition data for St. Mathew Island blue king crab (SMBKC) in the **Gmacs base** model.\label{fig:sc_pot_res_selex}](figure/sc_pot_res_selex-1.png)

![Bubble plots of residuals by stage and year for the NMFS trawl survey size composition data for St. Mathew Island blue king crab (SMBKC) in the **Gmacs base** model.\label{fig:sc_pot_discarded_res}](figure/sc_pot_discarded_res-1.png)

![Bubble plots of residuals by stage and year for the NMFS trawl survey size composition data for St. Mathew Island blue king crab (SMBKC) in the **Gmacs selex** model.\label{fig:sc_pot_discarded_res_selex}](figure/sc_pot_discarded_res_selex-1.png)

![Bubble plots of residuals by stage and year for the ADF&G pot survey size composition data for St. Mathew Island blue king crab (SMBKC) in the **Gmacs base** model.\label{fig:sc_trawl_discarded_res}](figure/sc_trawl_discarded_res-1.png)

![Bubble plots of residuals by stage and year for the ADF&G pot survey size composition data for St. Mathew Island blue king crab (SMBKC) in the **Gmacs selex** model.\label{fig:sc_trawl_discarded_res_selex}](figure/sc_trawl_discarded_res_selex-1.png)

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

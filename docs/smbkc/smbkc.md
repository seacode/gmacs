---
title: "Saint Matthew Island Blue King Crab Stock Assessment 2016"
author: "D'Arcy Webber, Jie Zheng, James Ianelli"
institute: "Affiliation"
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

2. **Catches**: Peak historical harvest was 9.454 million pounds (4,288 t) in 1983/84. The fishery was closed for 10 years after the stock was declared overfished in 1999. Fishing resumed in 2009/10 with a fishery-reported retained catch of 0.461 million pounds (209 t), less than half the 1.167 million pound (529.3 t) TAC. Following three more years of modest harvests supported by a fishery CPUE of around 10 crab per pot lift, the fishery was again closed in 2013/14 due to declining trawl-survey estimates of abundance and concerns about the health of the stock. The directed fishery resumed again in 2014/15 with a TAC of 0.655 million pounds (300 t), but the fishery performance was relatively poor with the retained catch of 0.309 million pounds (140 t).

3. **Stock biomass**: Following a period of low numbers after the stock was declared overfished in 1999, trawl-survey indices of SMBKC stock abundance and biomass generally increased in subsequent years, with survey estimated mature male biomass reaching 20.98 million pounds (9,516 t; CV == 0.55) in 2011, the second highest in the 37-year time series used in this assessment. Survey mature male biomass then declined to 12.46 million pounds (5,652 t; CV = 0.33) in 2012 and to 4.459 million pounds (2,202 t; CV = 0.22) in 2013 before going back up to 12.06 million pounds (5,472 t; CV = 0.44) in 2014 and 11.32 million pounds (5,134 t; CV = 0.76).

4. **Recruitment**: Because little information about the abundance of small crab is available for this stock, recruitment has been assessed in terms of the number of male crab within the 90-104 mm CL size class in each year. The 2013 trawl-survey area-swept estimate of 0.335 million male SMBKC in this size class marked a three-year decline and was the lowest since 2005. That decline did not continue with the 2014 survey with an estimate of 0.723 million. The survey recruitment is 0.992 million in 2015, but the majority of them came from one tow with a great deal of uncertainty.

5. **Management performance**: In recent assessments, estimated total male catch has been determined as the sum of fishery-reported retained catch, estimated male discard mortality in the directed fishery, and estimated male bycatch mortality in the groundfish fisheries, as these have been the only sources of non-negligible fishing mortality to consider.

\begin{table}[ht]
\centering
\caption{Status and catch specifications (1,000 t) (scenario 1).} 
\label{tab:status}
\begin{tabular}{lrrrrrrr}
  \hline
Year & MSST & Biomass (MMB mating) & TAC & Retained catch & Total male catch & OFL & ABC \\ 
  \hline
2011/12 & 1.50 & 5.03 & 1.15 & 0.85 & 0.95 & 1.70 & 1.54 \\ 
  2012/13 & 1.80 & 2.85 & 0.74 & 0.73 & 0.82 & 1.02 & 0.92 \\ 
  2013/14 & 1.50 & 3.01 & 0.00 & 0.00 & 0.00 & 0.56 & 0.45 \\ 
  2014/15 & 1.86 & 2.48 & 0.30 & 0.14 & 0.15 & 0.43 & 0.34 \\ 
  2015/16 &  & 2.45 &  &  &  & 0.28 & 0.22 \\ 
   \hline
\end{tabular}
\end{table}

The stock was above MSST in 2014/15 and is hence not overfished. Overfishing did not occur.

6. **Basis for the OFL**: Estimated Feb 15 mature-male biomass ($MMB_\text{mating}$) is used as the measure of biomass for this Tier 4 stock, with males measuring 105 mm CL or more considered mature. The $B_{MSY}$ proxy is obtained by averaging estimated $MMB_\text{mating}$ over a specific reference time period, and current CPT/SSC guidance recommends using the full assessment time frame as the default reference period.


# A. Summary of Major Changes

## Changes in Management of the Fishery

There are no new changes in management of the fishery.

## Changes to the Input Data

All time series used in the assessment have been updated to include the most recent fishery and survey results. This assessment makes use of an updated full trawl-survey time series supplied by R. Foy in August 2015 (new time series), updated groundfish bycatch estimates based on 1999-2014 NMFS AKRO data also supplied by R. Foy, and the ADF&G pot survey data in 2015.

## Changes in Assessment Methodology

This assessment is done using Gmacs. The model is based upon the 3-stage length-based assessment model first presented in May 2011 by Bill Gaeuman and accepted by the CPT in May 2012. The model was developed to replace a similar 4-stage model used prior to 2011. During the assessment in May 2015 and this assessment, many combinations of molting probability and trawl survey selectivities were evaluated to address the residual bias problems in the previous model. In September 2015, twenty scenarios were investigated. The detailed changes to the model parameters are described in details in E (Analytic Approach).

There are several differences between the Gmacs assessment and the previous model. One of the major differences being that natural and fishing mortality are continuous within each season. Depite this structural difference in the model, the differences between these two methods is likely to be small.

Season length in Gmacs is controlled simply by changing the proportion of natural mortality that is applied each season. For example, in this assessment four seasons are defined and the proportion of natural mortality that is applied each season is 0.000, 0.440, 0.185, and 0.375 in the final season. In Gmacs the proportion of natural mortality that is applied each season is fixed (i.e. it does not change each year). The previous model allowed the proportion of natural mortality to change each year (i.e. in the second season it ranged from 0.05 to 0.18 before the year 2000 and was 0.44 after 2000).

Finally, in Gmacs the size transition matrix is a combination of the growth matrix and the molting probability. The growth matrix is derived from empirical molt increment data and the molting probability for each size class is the model is derived from an inverse logistic curve. Put simply, we cannot specify the size transition matrix directly, thus getting our size transition matrix to match that used in the previous model exactly was not possible. However, it is close:

\begin{equation}
  \left[ \begin{array}{ccc}
    0.2056 & 0.6799 & 0.1144 \\
    0 & 0.3963 & 0.6037 \\
    0 & 0 & 1 \end{array} \right]
\end{equation}

Also see Figure \ref{fig:size_trans}.

Also, selecitivitiy is fixed to match the previous model.

## Changes in Assessment Results

Changes in assessment results depend on model scenarios. 


# B. Responses to SSC and CPT Comments

## CPT and SSC Comments on Assessments in General

## CPT and SSC Comments Specific to SMBKC Stock Assessment


# C. Introduction

## Scientific Name

The blue king crab is a lithodid crab, *Paralithodes platypus* (Brant 1850).

## Distribution

Blue king crab are sporadically distributed throughout the North Pacific Ocean from Hokkaido, Japan, to southeastern Alaska (Figure 1). In the eastern Bering Sea small populations are distributed around St. Matthew Island, the Pribilof Islands, St. Lawrence Island, and Nunivak Island. Isolated populations also exist in some other cold water areas of the Gulf of Alaska (NPFMC 1998). The St. Matthew Island Section for blue king crab is within Area Q2 (Figure 2), which is the Northern District of the Bering Sea king crab registration area and includes the waters north of Cape Newenham (58°39’ N. lat.) and south of Cape Romanzof (61°49’ N. lat.).

![Distribution of blue king crab *Paralithodes platypus* in the Gulf of Alaska, Bering Sea, and Aleutian Islands waters. Shown in blue.](figure/Fig1.png)

![King crab Registration Area Q (Bering Sea).](figure/Fig2.png)

## Stock Structure

The Alaska Department of Fish and Game (ADF&G) Gene Conservation Laboratory division has detected regional population differences between blue king crab collected from St. Matthew Island and the Pribilof Islands^[NOAA grant Bering Sea Crab Research II, NA16FN2621, 1997.]. NMFS tag-return data from studies on blue king crab in the Pribilof Islands and St. Matthew Island support the idea that legal-sized males do not migrate between the two areas (Otto and Cummiskey 1990). St. Matthew Island blue king crab tend to be smaller than their Pribilof conspecifics, and the two stocks are managed separately.

## Life History

Like the red king crab, *Paralithodes camtshaticus*, the blue king crab is considered a shallow water species by comparison with other lithodid such as golden king crab, *Lithodes aequispinus*, and the scarlet king crab, *Lithodes couesi* (Donaldson and Byersdorfer 2005). Adult male blue king crab are found at an average depth of 70m (NPFMC 1998). The reproductive cycle appears to be annual for the first two reproductive cycles and biennial thereafter (cf. Jensen and Armstrong, 1989) and mature crab seasonally migrate inshore where they molt and mate. Unlike red king crab, juvenile blue king crab do not form pods, but instead rely on cryptic coloration for protection from predators and require suitable habitat such as cobble and shell hash. Somerton and MacIntosh (1983) estimated SMBKC male size at sexual maturity to be 77.0 mm carapace length (CL). Paul et al. (1991) found that spermatophores were present in the vas deferens of 50% of the St. Matthew Island blue king crab males examined with sizes of 40-49 mm CL and in 100% of the males at least 100 mm CL. Spermataphore diameter also increased with increasing CL with an asymptote at ~ 100 mm CL. They noted, however, that although spermataphore presence indicates physiological sexual maturity, it may not be an indicator of functional sexual maturity. For purposes of management of the St. Matthew Island blue king crab fishery, the State of Alaska uses 105 mm CL to define the lower size bound of functionally mature males (Pengilly and Schmidt 1995). Otto and Cummiskey (1990) report an average growth increment of 14.1 mm CL for adult SMBKC males.

## Management History

The SMBKC fishery developed subsequent to baseline ecological studies associated with oil exploration (Otto 1990). Ten U.S. vessels harvested 1.202 million pounds in 1977, and harvests peaked in 1983 when 164 vessels landed 9.454 million pounds (Fitch et al. 2012; Table 1). The fishing seasons were generally short, often lasting only a few days. The fishery was declared overfished and closed in 1999 when the stock biomass estimate was below the minimum stock- size threshold (MSST) of 11.0 million pounds as defined by the Fishery Management Plan for the Bering Sea/Aleutian Islands King and Tanner crabs (NPFMC 1999). Zheng and Kruse (2002) hypothesized a high level of SMBKC natural mortality from 1998 to 1999 as an explanation for the low catch per unit effort (CPUE) in the 1998/99 commercial fishery and the low numbers across all male crab size groups caught in the annual NMFS eastern Bering Sea trawl survey from 1999 to 2005 (Table 2). In Nov 2000, Amendment 15 to the FMP for Bering Sea/Aleutian Islands king and Tanner crabs was approved to implement a rebuilding plan for the SMBKC stock (NPFMC 2000). The rebuilding plan included a regulatory harvest strategy (5 AAC 34.917), area closures, and gear modifications. In addition, commercial crab fisheries near St. Matthew Island were scheduled in fall and early winter to reduce the potential for bycatch mortality of vulnerable molting and mating crab.

NMFS declared the stock rebuilt on Sept 21, 2009, and the fishery was reopened after a 10-year closure on Oct 15, 2009 with a TAC of 1.167 million pounds, closing again by regulation on Feb 1, 2010. Seven participating vessels landed a catch of 460,859 pounds with a reported effort of 10,697 pot lifts and an estimated CPUE of 9.9 retained number of crab per pot lift. The fishery remained open the next three years with modest harvests and similar CPUE, but large declines in the NMFS trawl-survey estimate of stock abundance raised concerns about the health of the stock, prompting ADF&G to close the fishery again for the 2013/14 season. Due to abundance above thresholds, the fishery was reopen for the 2014/15 season with a low TAC 0.655 million pounds.

Though historical observer data are limited due to very limited samplings, bycatch of female and sublegal male crab from the directed blue king crab fishery off St. Matthew Island was relatively high historically, with estimated total bycatch in terms of number of crab captured sometimes twice or more as high as the catch of legal crab (Moore et al. 2000; ADF&G Crab Observer Database). Pot-lift sampling by ADF&G crab observers (Gaeuman 2013; ADF&G Crab Observer Database) indicates similar bycatch rates of discarded male crab since the reopening of the fishery (Table 3), with total male discard mortality in the 2012/13 directed fishery estimated at about 12% (0.193 million pounds) of the reported retained catch weight, assuming 20% handling mortality. On the other hand, these same data suggest a significant reduction in the bycatch of females, which may be attributable to the later timing of the contemporary fishery^[D. Pengilly, ADF&G, pers. comm.]. Some bycatch of discarded blue king crab has also been observed historically in the eastern Bering Sea snow crab fishery, but in recent years it has generally been negligible, and observers recorded no bycatch of blue king crab in sampled pot lifts during 2013/14. The St. Matthew Island golden king crab fishery, the third commercial crab fishery to have taken place in the area, typically occurred in areas with depths exceeding blue king crab distribution. NMFS observer data suggest that variable but mostly limited SMBKC bycatch has also occurred in the eastern Bering Sea groundfish fisheries (Table 5).


# D. Data

## Summary of New Information

Data used in this assessment have been updated to include the most recently available fishery and survey numbers. In addition, this assessment makes use an updated trawl-survey time series provided by R. Foy in August 2015 (new time series), as well as updated 1993-2014 groundfish bycatch estimates based on AKRO data also supplied by R. Foy. The new and old time series of trawl survey area-swept estimates were compared in May 2015 and only the new time series was used in this assessment. The data extent and availability is shown in Figure \ref{fig:data_extent}).

![Data extent for the SMBKC assessment.\label{fig:data_extent}](figure/data_extent-1.png) 

## Major Data Sources

Major data sources used in this assessment are annual directed-fishery retained-catch statistics from fish tickets (1978/79-1998/99, 2009/10-2012/13, and 2014/15; Table 1); results from the annual NMFS eastern Bering Sea trawl survey (1978-2015; Table 2); results from the triennial ADF&G SMBKC pot survey (every third year during 1995-2013) and 2015 pot survey (Table 4); size-frequency information from ADF&G crab-observer pot-lift sampling (1990/91-1998/99, 2009/10-2012/13, and 2014/15; Table3); and NMFS groundfish-observer bycatch biomass estimates (1992/93-2014/15; Table 5). Figure 3 maps stations from which SMBKC trawl-survey and pot-survey data were obtained. Further information concerning the NMFS trawl survey as it relates to commercial crab species is available in Daly et al. (2014); see Gish et al. (2012) for a description of ADF&G SMBKC pot-survey methods. It should be noted that the two surveys cover different geographic regions and that each has in some years encountered proportionally large numbers of male blue king crab in areas where the other is not represented (Figure 4). Crab-observer sampling protocols are detailed in the crab-observer training manual (ADF&G 2013). Groundfish SMBKC bycatch data come from NMFS Bering Sea reporting areas 521 and 524 (Figure 5). Note that for this assessment the newly available NMFS groundfish observer data reported by ADF&G statistical area was not used.

![Trawl and pot-survey stations used in the SMBKC stock assessment.](figure/Fig3.png)

## Other Data Sources

As with the most recent model configuration developed for this assessment, this version
 makes use of a growth transition matrix based on Otto and Cummiskey (1990). Other relevant data sources, including assumed population and fishery parameters, are presented in Appendix A, which provides a detailed description of the base-model configuration used for the 2012 and 2013 assessments.

## Excluded Data Sources

Groundfish bycatch size-frequency data available for selected years, though used in the model-based assessment in place prior to 2011, play no direct role in this analysis. This is because these data tend to be severely limited: for example, 2012/13 data include a total of just 4 90-mm+ CL male blue king crab from reporting areas 521 and 524.


# E. Analytic Approach

## History of Modeling Approaches for this Stock

A four-stage catch-survey-analysis (CSA) assessment model was used before 2011 to estimate abundance and biomass and prescribe fishery quotas for the SMBKC stock (2010 SAFE; Zheng et al. 1997). The four-stage CSA is similar to a full length-based analysis, the major difference being coarser length groups, which are more suited to a small stock with consistently low survey catches. In this approach, the abundance of male crab with a CL of 90 mm or above is modeled in terms of four crab stages: stage 1: 90-104 mm CL; stage 2: 105-119 mm CL; stage 3: newshell 120-133 mm CL; and stage 4: oldshell $\ge$ 120 mm CL and newshell $\ge$ 134 mm CL. Motivation for these stage definitions comes from the fact that for management of the SMBKC stock, male crab measuring at least 105 mm CL are considered mature, whereas 120 mm CL is considered a proxy for the legal size of 5.5 in carapace width, including spines. Additional motivation for these stage definitions derives from an estimated average growth increment of about 14 mm per molt for SMBKC (Otto and Cummiskey 1990).

Concerns about the pre-2011 assessment model led to CPT and SSC recommendations that included development of an alternative model with provisional assessment based on survey biomass or some other index of abundance. An alternative 3-stage model was proposed to the CPT in May 2011 but was requested to proceed with a survey-based approach for the Fall 2011 assessment. In May 2012 the CPT approved a slightly revised and better documented version of the alternative model for assessment.

## Assessment Methodology
The 2015 SMBKC stock assessment model, first used in Fall 2012, is a variant of the previous four-stage SMBKC CSA model (2010 SAFE; Zheng et al. 1997) and similar in complexity to that described by Collie et al. (2005). Like the earlier model, it considers only male crab at least 90 mm in CL, but it combines stages 3 and 4 of the earlier model resulting in just three stages (male size classes) determined by carapace length measurements of (1) 90-104 mm, (2) 105-119 mm, and (3) 120 mm+ (i.e., 120 mm and above). This consolidation was driven by concern about the accuracy and consistency of shell-condition information, which had been used in distinguishing stages 3 and 4 of the earlier model. 

Each model year is split into four seasons.

A detailed description of the base model and its implementation in the software AD Model Builder (Fournier et al. 2012) is presented in Appendix A.

## Model Selection and Evaluation

In May 2015, eight model scenarios were considered followed by 20 scenarios examined in September 2015. In this presentation results from the selected model in September was used for contrast with the current implementation.

## Results
Preliminary results for the gmacs configuration is provided here with comparisons shown in Fig XX.

# F. Calculation of the OFL and ABC

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

Table 1. The 1978/79 - 2014/15 directed St. Matthew Island blue king crab pot fishery. Source: Fitch et al. 2012; ADF&G Dutch Harbor staff, pers. comm.

Table 2a. NMFS EBS trawl-survey area-swept estimates of male crab abundance (10 6 crab) and of mature male biomass (10 6 lbs). Total number of captured male crab $\ge$ 90 mm CL is also given. Source: R.Foy, NMFS. The “+” refers to plus group.

\begin{table}[ht]
\centering
\caption{Population abundances (N) by crab stage in millions of crab, mature male biomasses at survey (MMB) in millions of pounds on Feb. 15 for scenario 1. All abundances are at time of survey.} 
\label{tab:pop_abundance}
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

\newpage\clearpage

![Catches of 181 male blue king crab measuring at least 90 mm CL from the 2014 NMFS trawl-survey at the 56 stations used to assess the SMBKC stock. Note that the area north of St. Matthew Island, which includes the large catch of 67 crab at station R-24, is not represented in the ADF&G pot-survey data used in the assessment.](figure/Fig4.png)

![NFMS Bering Sea reporting areas. Estimates of SMBKC bycatch in the groundfish fisheries are based on NMFS observer data from reporting areas 524 and 521.](figure/Fig5.png)

![ADF&G 1998 pot survey catch of male blue king crab $\ge$ 90 mm CL for the 10 standard (Stratum 1) stations fished during 17–19 August 1998 within NMFS trawl survey station R-24.  Size (area) of circle is proportional to catch (largest = 43 crab). Black circles denote catch at a station was greater than the average catch for the 10 stations (10 crab); white circles denote catch at a station was less than the average catch for the 10 stations. Red circle is the centroid ("center of gravity") of distribution computed from the 10 stations. Red X is midpoint of the NMFS trawl survey tow performed in R-24 on 20 July 1998.](figure/Fig6a.png)

![ADF&G 2013 pot survey catch of male blue king crab $\ge$ 90 mm CL for the 10 standard (Stratum 1) stations fished during 21–25 September 2013 within NMFS trawl survey station R-24.  Size (area) of circle is proportional to catch (largest = 76 crab). Black circles denote catch at a station was greater than the average catch for the 10 stations (17 crab); white circles denote catch at a station was less than the average catch for the 10 stations. Red circle is the centroid ("center of gravity") of distribution computed from the 10 stations. Red X is midpoint of the NMFS trawl survey tow performed in R-24 on 12 July 2013.](figure/Fig6b.png)

![ADF&G 2013 pot survey catch of male blue king crab $\ge$ 90 mm CL for the 20 special (Stratum 2) stations fished during 20–25 September 2013 within NMFS trawl survey station R-24.  Size (area) of circle is proportional to catch (largest = 63 crab). Black circles denote catch at a station was greater than the average catch for the 20 stations (17 crab); white circles denote catch at a station was less than the average catch for the 20 stations. Red circle is the centroid ("center of gravity") of distribution computed from the 20 stations. Red X is midpoint of the NMFS trawl survey tow performed in R-24 on 12 July 2013.](figure/Fig6c.png)

\newpage\clearpage

![Estimated stage-1 and stage-2 selectivities for different scenarios (the stage-3 selectivities are all fixed at 1). Estimated selectivities are shown for the directed pot fishery, the trawl bycatch fishery, the fixed bycatch fishery, the NMFS trawl survey, and the ADF&G pot survey.\label{fig:selectivity}](figure/selectivity-1.png) 

![Molting probabilities by stage used in the Gmacs model.\label{fig:molt_prob}](figure/molt_prob-1.png) 

\newpage\clearpage

![Comparisons of area-swept estimates of total male survey biomass and model predictions for 2016 model. The error bars are plus and minus 2 standard deviations.\label{fig:trawl_survey_biomass}](figure/trawl_survey_biomass-1.png) 

![Comparisons of total male pot survey CPUEs and model predictions for 2016 model estimates without additional CV for the pot survey CPUE. The error bars are plus and minus 2 standard deviations.\label{fig:pot_survey_cpue}](figure/pot_survey_cpue-1.png) 

![Standardized residuals for area-swept estimates of total male survey biomass and total male pot survey CPUEs for Gmacs configuration. \label{fig:bts_resid}](figure/bts_resid-1.png) 

\newpage\clearpage

![Observed and model estimated size-frequencies of male BBRKC by year retained in the directed pot fishery.\label{fig:sc_pot}](figure/sc_pot-1.png) 

![Observed and model estimated size-frequencies of discarded male BBRKC by year in the NMFS trawl survey.\label{fig:sc_pot_discarded}](figure/sc_pot_discarded-1.png) 

![Observed and model estimated size-frequencies of discarded female BBRKC by year in the ADF&G pot survey.\label{fig:sc_trawl_discarded}](figure/sc_trawl_discarded-1.png) 

![Bubble plots of residuals of stage compositions for St. Mathew Island blue king crab.\label{fig:sc_pot_res}](figure/sc_pot_res-1.png) 

![Bubble plots of residuals of stage compositions for St. Mathew Island blue king crab.\label{fig:sc_pot_discarded_res}](figure/sc_pot_discarded_res-1.png) 

![Bubble plots of residuals of stage compositions for St. Mathew Island blue king crab.\label{fig:sc_trawl_discarded_res}](figure/sc_trawl_discarded_res-1.png) 

\newpage\clearpage

![Comparison of observed and model predicted retained catch and bycatches with scenario 10.\label{fig:fit_to_catch}](figure/fit_to_catch-1.png) 

![Estimated recruitment time series during 1979-2015 with 18 scenarios. Estimated recruitment time series ($R_t$) in the OneSex, TwoSex and BBRKC models. Note that recruitment in the OneSex model represents recruitment of males only.\label{fig:recruitment}](figure/recruitment-1.png) 

![Estimated mature male biomass time series on Feb. 15 during 1978-2015 with 18 scenarios. Mature male biomass (MMB) predicted in the two versions of the Gmacs model (OneSex and TwoSex) and the Zheng model.\label{fig:mmb}](figure/mature_male_biomass-1.png) 

![Relationship between carapace width (mm) and weight (kg) by sex in each of the models (provided as a vector of weights at length to Gmacs).\label{fig:length-weight}](figure/length_weight-1.png) 

![Distribution of carapace width (mm) at recruitment.\label{fig:init_rec}](figure/init_rec-1.png) 

![Growth increment (mm) each molt by sex in the OneSex and TwoSex models.\label{fig:growth_inc}](figure/growth_inc-1.png) 

![Growth transitions.\label{fig:growth_trans}](figure/growth_trans-1.png) 

![Size transitions (i.e. the combination of the growth matrix and molting probabilities).\label{fig:size_trans}](figure/size_trans-1.png) 

![Numbers at length in 1953, 1975 and 2014 in each of the models. The first year of the OneSex model is 1953. The first year of the Zheng and TwoSex models in 1975.\label{fig:init_N}](figure/init_N-1.png) 

![Time-varying natural mortality ($M_t$). Specified pulse period occurs in 1998. \label{fig:M_t}](figure/natural_mortality-1.png) 


\newpage\clearpage

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

where the diagonal matrices 

\begin{equation}
  \boldsymbol{S}^\text{df} = \left[ \begin{array}{ccc}
    s_1^\text{df} & 0 & 0 \\
    0 & s_2^\text{df} & 0 \\
    0 & 0 & 1 \end{array} \right]
\end{equation}

and

\begin{equation}
  \boldsymbol{H}^\text{df} = \left[ \begin{array}{ccc}
    h^\text{df} & 0 & 0 \\
    0 & h^\text{df} & 0 \\
    0 & 0 & 1 \end{array} \right]
\end{equation}

account for stage selectivities $s_1^\text{df}$ and $s_2^\text{df}$ and discard handling mortality $h^\text{df}$ in the directed fishery, both assumed constant over time. Yearly stage removals resulting from bycatch mortality in the groundfish trawl and fixed-gear fisheries are calculated as Feb 15 (0.63 yr) pulse effects in terms of the respective fishing mortalities $F_t^\text{gt}$ and $F_t^\text{gf}$ by


## 3. Model Data

Data inputs used in model estimation are listed in Table 1. All quantities relate to male SMBKC $\le$ 90mm CL.


## 4. Model Parameters

Estimated parameters with scenarios 8 and 10 are listed in Table 2 and include an estimated parameter for natural mortality in 1998/99 assuming of an anomalous mortality event in that year, as hypothesized by Zheng and Kruse (2002), with natural mortality otherwise fixed at 0.18 $\text{yr}^{-1}$.

In any year with no directed fishery, and hence zero retained catch, $F_t^\text{df}$ is set to zero rather than model estimated. Similarly, for years in which no groundfish bycatch data are available, $F_t^\text{gf}$ and $F_t^\text{gt}$ are imputed to be the geometric means of the estimates from years for which there are data. Table 3 lists additional externally determined parameters used in model computations.

For scenarios 0 and 1, the stage-transition matrix is

\begin{equation}
  \left[ \begin{array}{ccc}
    0.2 & 0.7 & 0.1 \\
    0 & 0.4 & 0.6 \\
    0 & 0 & 1 \end{array} \right]
\end{equation}

which includes molting probabilities. For scenarios 3-11, the growth matrix with molting crab is

\begin{equation}
  \left[ \begin{array}{ccc}
    0.11 & 0.83 & 0.06 \\
    0 & 0.11 & 0.89 \\
    0 & 0 & 1 \end{array} \right]
\end{equation}

The combination of the growth matrix and molting probabilities results in the stage-transition matrix for scenarios 3-11. Molting probability for stage 1 for scenarios 8, 9, 10, 11 during 1978-2000 is assumed to be 0.91 estimated from the tagging data and ratio of molting probabilities of stages 2 to stage 1 is fixed as 0.69231 from the tagging data as well. For scenarios 0 and 1, stage-transition matrix

Both surveys are assigned a nominal date of July 1, the start of the crab year. The directed fishery is treated as a season midpoint pulse. Groundfish bycatch is likewise modeled as a pulse effect, occurring at the nominal time of mating, Feb 15, which is also the reference date for calculation of federal management biomass quantities.

\begin{table}[ht]
\centering
\caption{Model estimated parameters for scenarios 0 and 4.} 
\label{tab:est_pars}
\begin{tabular}{lr}
  \hline
Parameter & Estimate \\ 
  \hline
R0 & 802911.68 \\ 
  Rbar & 882928.94 \\ 
  ralpha & 14.62 \\ 
  rbeta & 14.18 \\ 
   \hline
\end{tabular}
\end{table}



## 5. Model Objective Function and Weighting Scheme

The objective function consists of a sum of eight "negative loglikelihood" terms characterizing the hypothesized error structure of the principal data inputs with respect to their true, i.e., model-predicted, values and four "penalty" terms associated with year-to-year variation in model recruit abundance and fishing mortality in the directed fishery and groundfish trawl and fixed-gear fisheries. See Table 4, where upper and lower case letters designate model-predicted and data-computed quantities, respectively, and boldface letters again indicate vector quantities. Sample sizes $n_t$ (observed number of male SMBKC $\le$ 90 mm CL) and estimated coefficients of variation $\widehat{cv}_t$ were used to develop appropriate variances for stage-proportion and abundance-index components. The weights $\lambda_j$ appearing in the objective function component expressions in Table 4 play the role of "tuning" parameters in the modeling procedure.

Table 4. Loglikelihood and penalty components of base-model objective function. The $\lambda_k$ are weights, described in text; the neff t are effective sample sizes, also described in text. All summations are with respect to years over each data series.

| Component | Distribution | Form |
|-----------|--------------|------|
| Legal retained-catch biomass | Lognormal | $-0.5 \sum \left( \log (c_t/C_t)^2 / \log (1+cv^2_c) \right)$ |
| Dis. Pot bycatch biomass | Lognormal | |



## 6. Estimation

The model was implemented using the software AD Model Builder (Fournier et al. 2012), with parameter estimation by minimization of the model objective function using automatic differentiation. Parameter estimates and standard deviations provided in this document are AD Model Builder reported values assuming maximum likelihood theory asymptotics.


\newpage

# K. References

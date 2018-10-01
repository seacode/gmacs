---
title: "Saint Matthew Island Blue King Crab Stock Assessment 2018"
author: |
  | Jie Zheng$^1$ and James Ianelli$^2$ 
  | $^1$Alaska Department of Fish and Game, jie.zheng@alaska.gov
  | $^2$NOAA, jim.ianelli@noaa.gov
date: "September 2018"
output:
  pdf_document:
    includes:
    highlight: zenburn
  html_document:
    theme: flatly
    toc: yes
  word_document: default
bibliography: references/Gmacs.bib
---





\pagenumbering{gobble}

# Executive Summary

1. **Stock**: Blue king crab, *Paralithodes platypus*, Saint Matthew Island (SMBKC), Alaska.

2. **Catches**: Peak historical harvest was 4,288 t (9.454 million pounds) in 1983/84^[1983/84 refers to a fishing
year that extends from 1 July 1983 to 30 June 1984.]. The fishery was closed for 10 years after the stock was declared
overfished in 1999. Fishing resumed in 2009/10 with a fishery-reported retained catch of 209 t (0.461 million
pounds), less than half the 529.3 t (1.167 million pound) TAC. Following three more years of modest harvests
supported by a fishery catch per unit effort (CPUE) of around 10 crab per pot lift, the fishery was again closed in
2013/14 due to declining trawl-survey estimates of abundance and concerns about the health of the stock. The directed
fishery resumed again in 2014/15 with a TAC of 300 t (0.655 million pounds), but the fishery performance was
relatively poor with a retained catch of 140 t (0.309 million pounds). The retained catch in 2015/16 was even lower
at 48 t (0.105 million pounds) and the fishery has remained closed since 2016/17.

3. **Stock biomass**: The 1975-2018 NMFS trawl survey mean biomass is 5,664 t with the 2018 value being the
5th lowest (1,731 t; the third lowest since 2000). This 2018 biomass of $\ge$ 90 mm carapace length (CL) male crab is 
31% of the long term mean  at 3.814 million pounds (with a CV of 28%) is 31% of the long term mean.
The most recent 3-year average of the NMFS survey is 41% of the mean value, further indicating a decline in biomass compared to
historical survey estimates, notably  in 2010 and 2011 that were over six times the current average. 
The ADFG pot survey was repeated in 2018 and the relative biomass in this index was the lowest
in the time series (12% of the mean from the 11 surveys conducted since 1995).
The assessment model estimates dampen the interannual variability observed in the survey biomass and suggest that the stock (in survey biomass units) is presently at about
28% 
of the long term model-predicted survey biomass average. The trend from these values suggests a slight decline.

4. **Recruitment**: Recruitment is based on estimated number of male crab within the 90-104 mm CL size class
in each year. The 2018 trawl-survey area-swept estimate of 0.154 million male SMBKC in this size class is the third lowest in 
the 41 years since 1978 and follows the lowest previously observed in 2017. The recent six-year (2013 - 2018) average recruitment 
is only 45% of this mean. 
In the pot-survey, the abundance of this size group in 2017 was also the second-lowest in the time series (22% of the mean for the 
available pot-survey data) whereas in 2018 the value was the lowest observed at only 10% of the mean value.

5. **Management performance**: In this assessment estimated total male catch is the sum of fishery-reported retained
catch, estimated male discard mortality in the directed fishery, and estimated male bycatch mortality in the groundfish
fisheries.  Based on the reference model for SMBKC, the estimate for mature male biomass is below the minimum stock-size 
threshold (MSST) in 2017/18 and is hence is in an "overfished" condition, despite fishery closures in the last two years 
(and hence overfishing has not occurred) (Tables \ref{tab:status} and \ref{tab:status_pounds}). 
Computations which indicate the relative impact of fishing 
(i.e., the "dynamic $B_0$") suggests that the current spawning stock biomass has been reduced to 
 60% of what it would have been in the absence of
fishing. 

\begin{table}[ht]
\centering
\caption{Status and catch specifications (1000 t) for the reference model.
A - calculated from the assessment reviewed by the Crab Plan Team in September 2014,    
B - calculated from the assessment reviewed by the Crab Plan Team in September 2015,    
C - calculated from the assessment reviewed by the Crab Plan Team in September 2016,   
D - calculated from the assessment reviewed by the Crab Plan Team in September 2017,   
E - calculated from the assessment reviewed by the Crab Plan Team in September 2018. 
}
\label{tab:status}
\begin{tabular}{lccccccc}
  \hline
  & & Biomass & & Retained & Total & & \\ 
  Year & MSST & ($\mathit{MMB}_\text{mating}$) & TAC & catch & male catch & OFL & ABC \\ 
  \hline
  2013/14 & 1.50$^A$ & 3.01$^A$ & 0.00 & 0.00 & 0.00 & 0.56 & 0.45 \\ 
  2014/15 & 1.86$^B$ & 2.48$^B$ & 0.30 & 0.14 & 0.15 & 0.43 & 0.34 \\ 
  2015/16 & 1.84$^C$ & 2.11$^C$ & 0.19 & 0.05 & 0.05 & 0.28 & 0.22 \\ 
  2016/17 & 1.97$^D$ & 2.23$^D$ & 0.00 & 0.00 & 0.05 & 0.14 & 0.11 \\ 
  2017/18 & 1.85$^E$ & 1.29$^E$ & 0.00 & 0.00 & 0.05 & 0.12 & 0.10 \\
  2018/19 & & 1.31$^E$ & & & & 0.04 & 0.03 \\
 \\
  \hline
\end{tabular}
\end{table}
  <!-- \multicolumn{8}{p{\linewidth}}{l}{ -->
\begin{table}[ht]
\centering
\caption{Status and catch specifications (million pounds) for the reference model.} 
\label{tab:status_pounds}
\begin{tabular}{lccccccc}
  \hline
  & & Biomass & & Retained & Total & & \\ 
  Year & MSST & ($\mathit{MMB}_\text{mating}$) & TAC & catch & male catch & OFL & ABC \\ 
  \hline
  2013/14 & 3.4$^A$ & 6.64$^A$ & 0.000 & 0.000 & 0.0006 & 1.24 & 0.99 \\ 
  2014/15 & 4.1$^B$ & 5.47$^B$ & 0.655 & 0.309 & 0.329  & 0.94 & 0.75 \\ 
  2015/16 & 4.1$^C$ & 4.65$^C$ & 0.419 & 0.110 & 0.110  & 0.62 & 0.49 \\ 
  2016/17 & 4.3$^D$ & 4.91$^D$ & 0.410 & 0.000 & 0.000  & 0.31 & 0.25 \\ 
  2017/18 & 4.1$^E$ & 2.85$^E$ & 0.41 & 0.000 & 0.000 & 0.27 & 0.22 \\
  2018/19 & & 2.89$^E$ & & & & 0.08 & 0.07 \\
  \hline
\end{tabular}
\end{table}

6. **Basis for the OFL**: Estimated mature-male biomass (MMB) on 15 February is used as the measure of 
 biomass for this Tier 4 stock, with males measuring $\ge$ 105 mm CL 
 considered mature. The $B_\mathit{MSY}$ proxy is obtained by averaging estimated MMB over a specific reference period, and current CPT/SSC guidance recommends using the full assessment time frame as the default reference period (Table \ref{tab:ofl_basis}).
\begin{table}[ht]
\centering
\caption{Basis for the OFL (1000 t) from the reference model.} 
\label{tab:ofl_basis}
\begin{tabular}{lcccccccc}
  \hline
  & & & Biomass & & & & & Natural \\ 
  Year & Tier & $B_\mathit{MSY}$ & ($\mathit{MMB}_\text{mating}$) & $B/B_\mathit{MSY}$ & $F_\mathit{OFL}$ & $\gamma$ & Basis for $B_\mathit{MSY}$ & mortality \\ 
  \hline
  2013/14 & 4b & 3.06 & 3.01 & 0.98 & 0.18 & 1 & 1978-2013 & 0.18 \\ 
  2014/15 & 4b & 3.28 & 2.71 & 0.82 & 0.14 & 1 & 1978-2014 & 0.18 \\ 
  2015/16 & 4b & 3.71 & 2.45 & 0.66 & 0.11 & 1 & 1978-2015 & 0.18 \\ 
  2016/17 & 4b & 3.67 & 2.23 & 0.61 & 0.09 & 1 & 1978-2016 & 0.18 \\ 
  2017/18 & 4b & 3.86 & 2.05 & 0.53 & 0.08 & 1 & 1978-2017 & 0.18 \\ 
  2018/19 & 4b & 3.7 & 
  1.31 & 
  0.35 & 
  0.043 & 
  1 & 1978-2018 & 0.18 \\ 
  \hline
\end{tabular}
\end{table}


# A. Summary of Major Changes

## Changes in Management of the Fishery

There are no new changes in management of the fishery.

## Changes to the Input Data

Data used in this assessment have been updated to include the most recently
available fishery and survey numbers. This assessment makes use of two new
survey data points including the 2018 NMFS trawl-survey estimate of abudance,
and the 2018 ADF&G pot survey CPUE. Both of these surveys have associated size
compositon data. The assessment also uses updated 2010-2017 groundfish and
fixed gear bycatch estimates based on NMFS Alaska Regional Office (AKRO) data. 
The directed fishery has been closed since 2016/17 so fishery data in recent years are unavailable.

## Changes in Assessment Methodology

This assessment uses the General model for Alasks crab stocks (Gmacs) framework. The
model is configured to track three stages of length categories and was 
first presented in May 2011 by Bill Gaeuman and accepted by the CPT in May 2012. 
A difference from the original approach, and that used here, is  that natural and fishing mortality are
continuous within 5 discrete seasons (using the appropriate
catch equation rather than assuming an applied pulse removal). Season length in Gmacs
is controlled by changing the proportion of natural mortality that is applied
each season. Diagnostic output includes estimates of the "dynamic $B_0$" which simply
computes the ratio of the spawning biomass as estimated relative to the spawning biomass that would have occurred 
had there been no historical fishing mortality. 
Details of this implementation and other model details are provided in Appendix A.

## Changes in Assessment Results

Both surveys indicate a decline over the past few years. The "reference" model is that which was selected for use in 2017.  The
addition of new data introduced this year area are presented sequentially. Two alternative models are presented for
sensitivity. One involves a re-analysis of the NMFS trawl survey data using a spatio-temporal Delta-GLMM approach (VAST
model; Thorson and Barnett 2017) and the other configuration (named "Fit survey") simply adds emphasis on 
the design-based survey data
(by assuming a lower input variance). The VAST model suggests a modest increase from the 2017 survey estimate. However,
 the model tends to moderate the noise in the survey observations and declines 


# B. Responses to SSC and CPT Comments

## CPT and SSC Comments on Assessments in General

Comment: *Regarding general code development, the SSC and CPT outstanding requests continue to be as follows:*

  1. *add the ability to conduct retrospective analyses*

     Progress was limited in implementing this feature.

  1. *add ability to estimate bycatch fishing mortality rates when observer data are missing but effort data is available*

     This was completed.

  1. *Continued exploration of data weighting (Francis and other approaches) and evaluation of models with and without the 
     1998 natural mortality spike. The authors are encouraged to bring other models forward for CPT and SSC consideration*

      We continued to include an alternative time series estimated from the NMFS trawl survey using the VAST spatiotemporal Delta GLMM model 
      and continued with the iterative re-weighting for composition data.


# C. Introduction

## Scientific Name

The blue king crab is a lithodid crab, *Paralithodes platypus* (Brant 1850).

## Distribution

Blue king crab are sporadically distributed throughout the North Pacific Ocean from Hokkaido, Japan, to southeastern
Alaska (Figure \ref{fig:distribution}).  In the eastern Bering Sea small populations are distributed around St. Matthew
Island, the Pribilof Islands, St. Lawrence Island, and Nunivak Island. Isolated populations also exist in some other
cold water areas of the Gulf of Alaska (NPFMC 1998). The St. Matthew Island Section for blue king crab is within Area Q2
(Figure \ref{fig:registration_area}), which is the Northern District of the Bering Sea king crab registration area and
includes the waters north of Cape Newenham (58&deg;39' N. lat.) and south of Cape Romanzof (61&deg;49' N. lat.).

## Stock Structure

The Alaska Department of Fish and Game (ADF&G) Gene Conservation Laboratory, has detected regional population
differences between blue king crab collected from St. Matthew Island and the Pribilof Islands^[NOAA grant Bering Sea
Crab Research II, NA16FN2621, 1997.]. NMFS tag-return data from studies on blue king crab in the Pribilof Islands and
St. Matthew Island support the idea that legal-sized males do not migrate between the two areas (Otto and Cummiskey
1990). St. Matthew Island blue king crab tend to be smaller than their Pribilof conspecifics, and the two stocks are
managed separately.

## Life History

Like the red king crab, *Paralithodes camtshaticus*, the blue king crab is considered a shallow water species by
comparison with other lithodids such as golden king crab, *Lithodes aequispinus*, and the scarlet king crab, 
*Lithodes couesi* (Donaldson and Byersdorfer 2005). Adult male blue king crab are found at an average depth of 70 m (NPFMC 1998).
The reproductive cycle appears to be annual for the first two reproductive cycles and biennial thereafter (Jensen
and Armstrong 1989), and mature crab seasonally migrate inshore where they molt and mate. Unlike red king crab, juvenile
blue king crab do not form pods, but instead rely on cryptic coloration for protection from predators and require
suitable habitat such as cobble and shell hash. Somerton and MacIntosh (1983) estimated SMBKC male size at sexual
maturity to be 77 mm carapace length (CL). Paul et al. (1991) found that spermatophores were present in the vas deferens
of 50% of the St. Matthew Island blue king crab males examined with sizes of 40-49 mm CL and in 100% of the males at
least 100 mm CL. Spermataphore diameter also increased with increasing CL with an asymptote at ~ 100 mm CL. It was noted,
however, that although spermataphore presence indicates physiological sexual maturity, it may not be an indicator of
functional sexual maturity. For purposes of management of the St. Matthew Island blue king crab fishery, the State of
Alaska uses 105 mm CL to define the lower size bound of functionally mature males (Pengilly and Schmidt 1995). Otto and
Cummiskey (1990) report an average growth increment of 14.1 mm CL for adult SMBKC males.

## Management History

The SMBKC fishery developed subsequent to baseline ecological studies associated with oil exploration (Otto 1990). Ten
U.S. vessels harvested 545 t (1.202 million pounds) in 1977, and harvests peaked in 1983 when 164 vessels landed 4,288 t
(9.454 million pounds) (Fitch et al. 2012; Table \ref{tab:smbkc_fishery}).

The fishing seasons were generally short, often lasting only a few days. The fishery was declared overfished and closed
in 1999 when the stock biomass estimate was below the minimum stock-size threshold (MSST) of 4,990 t (11.0 million
pounds) as defined by the Fishery Management Plan (FMP) for the Bering Sea/Aleutian Islands King and Tanner crabs (NPFMC
1999). Zheng and Kruse (2002) hypothesized a high level of SMBKC natural mortality from 1998 to 1999 as an explanation
for the low catch per unit effort (CPUE) in the 1998/99 commercial fishery and the low numbers across all male crab size
groups caught in the annual NMFS eastern Bering Sea trawl survey from 1999 to 2005 (see survey data in next section). In
November 2000, Amendment 15 to the FMP for Bering Sea/Aleutian Islands king and Tanner crabs was approved to implement a
rebuilding plan for the SMBKC stock (NPFMC 2000). The rebuilding plan included a State of Alaska regulatory harvest strategy 
(*5 AAC 34.917*), area closures, and gear modifications. In addition, commercial crab fisheries near St. Matthew Island were
scheduled in fall and early winter to reduce the potential for bycatch mortality of vulnerable molting and mating crab.

NMFS declared the stock rebuilt on 21 September 2009, and the fishery was reopened after a 10-year closure on 15 October
2009 with a TAC of 529 t (1.167 million pounds), closing again by regulation on 1 February 2010. Seven participating
vessels landed a catch of 209 t (0.461 million pounds) with a reported effort of 10,697 pot lifts and an estimated CPUE of
9.9 retained individual crab per pot lift. The fishery remained open the next three years with modest harvests and
similar CPUE, but large declines in the NMFS trawl-survey estimate of stock abundance raised concerns about the health
of the stock. This prompted ADF&G to close the fishery again for the 2013/14 season. 
The fishery was reopened for the 2014/15 season with a low TAC of 297 t (0.655 million pounds) and in 2015/16 the TAC
was further reduced to 186 t (0.411 million pounds) then completely closed during the 2016/17 season.

Although historical observer data are limited due to low sampling effort, bycatch of female and sublegal male crab from
the directed blue king crab fishery off St. Matthew Island was relatively high historically, with estimated total
bycatch in terms of number of crab captured sometimes more than twice as high as the catch of legal crab (Moore et al.
2000; ADF&G Crab Observer Database). Pot-lift sampling by ADF&G crab observers (Gaeuman 2013; ADF&G Crab Observer
Database) indicates similar bycatch rates of discarded male crab since the reopening of the fishery (Table
\ref{tab:stage_cpue_1}), with total male discard mortality in the 2012/13 directed fishery estimated at about 12% (88
t or 0.193 million pounds) of the reported retained catch weight, assuming 20% handling mortality.

These data suggest a reduction in the bycatch of females, which may be attributable to the later timing of the
contemporary fishery and the more offshore distribution of fishery effort since reopening in 2009/10^[D. Pengilly,
ADF&G, pers. comm.]. Some bycatch of discarded blue king crab has also been observed historically in the eastern Bering
Sea snow crab fishery, but in recent years it has generally been negligible.  The St. Matthew Island golden king crab
fishery, the third commercial crab fishery to have taken place in the area,  typically occurred in areas with depths
exceeding blue king crab distribution. The NMFS observer data suggest that variable, but mostly limited, SMBKC bycatch has
also occurred in the eastern Bering Sea groundfish fisheries (Table \ref{tab:smbkc_groundfish_bycatch}).

# D. Data

## Summary of New Information

Data used in this assessment were updated to include the most recently available fishery and survey numbers. This
assessment makes use of two new survey data points including the 2018 NMFS trawl-survey estimate of abudance, and the
2018 ADF&G pot survey CPUE. Both of these surveys have associated size compositon data. The assessment also uses updated
1993-2016 groundfish and fixed gear bycatch estimates based on AKRO data. The fishery was closed in 2016/17 so no
directed fishery catch data were available. The data used in each of the new models is shown in Figure
\ref{fig:data_extent}.

## Major Data Sources

Major data sources used in this assessment include annual directed-fishery retained-catch statistics from fish tickets
(1978/79-1998/99, 2009/10-2012/13, and 2014/15-2015/16; Table \ref{tab:smbkc_fishery}); results from the annual NMFS
eastern Bering Sea trawl survey (1978-2018; Table \ref{tab:stage_cpue_nmfs}); results from the ADF&G SMBKC pot
survey (every third year during 1995-2013, then 2015-2018; Table \ref{tab:stage_cpue});
mean somatic mass given length category by year (Table \ref{tab:length_weight}); 
size-frequency information from ADF&G crab-observer pot-lift sampling (1990/91-1998/99, 2009/10-2012/13, and
2014/15-2016/17; Table \ref{tab:stage_cpue_1}); and the NMFS groundfish-observer bycatch biomass estimates (1992/93-2016/17;
Table \ref{tab:smbkc_groundfish_bycatch}).

Figure \ref{fig:stations} maps stations from which SMBKC trawl-survey and pot-survey data were obtained. Further
information concerning the NMFS trawl survey as it relates to commercial crab species is available in Daly et al.
(2014); see Gish et al. (2012) for a description of ADF&G SMBKC pot-survey methods. It should be noted that the two
surveys cover different geographic regions and that each has in some years encountered proportionally large numbers of
male blue king crab in areas not covered by the other survey (Figure \ref{fig:catch181}). Crab-observer sampling
protocols are detailed in the crab-observer training manual (ADF&G 2013). Groundfish SMBKC bycatch data come from the NMFS
Regional office and have been compiled to coincide with the 
SMBKC management area.


## Other Data Sources

The growth transition matrix used is based on Otto and Cummiskey (1990), as in the past. Other relevant data sources,
including assumed population and fishery parameters, are presented in Appendix A, which also provides a detailed
description of the model configuration used for this assessment.

# E. Analytic Approach

## History of Modeling Approaches for this Stock

A four-stage catch-survey-analysis (CSA) assessment model was used before 2011 to estimate abundance and biomass and
prescribe fishery quotas for the SMBKC stock. The four-stage CSA is similar to a full
length-based analysis, the major difference being coarser length groups, which are more suited to a small stock with
consistently low survey catches. In this approach, the abundance of male crab with a CL $\ge$ 90 mm is modeled in
terms of four crab stages: stage 1: 90-104 mm CL; stage 2: 105-119 mm CL; stage 3: newshell 120-133 mm CL; and stage 4:
oldshell $\ge$ 120 mm CL and newshell $\ge$ 134 mm CL. Motivation for these stage definitions comes from the fact that
for management of the SMBKC stock, male crab measuring $\ge$ 105 mm CL are considered mature, whereas 120 mm CL is
considered a proxy for the legal size of 5.5 in carapace width, including spines. Additional motivation for these stage
definitions comes from an estimated average growth increment of about 14 mm per molt for SMBKC (Otto and Cummiskey
1990).

Concerns about the pre-2011 assessment model led to the CPT and SSC recommendations that included development of an
alternative model with provisional assessment based on survey biomass or some other index of abundance. An alternative
3-stage model was proposed to the CPT in May 2011, but a survey-based approach was requested for the Fall
2011 assessment. In May 2012 the CPT approved a slightly revised and better documented version of the alternative model
for assessment. Subsequently, the model developed and used since  2012 was a variant of the previous four-stage SMBKC
CSA model and similar in complexity to that described by Collie et al. (2005). Like the earlier model, it considered
only male crab $\ge$ 90 mm in CL, but combined stages 3 and 4 of the earlier model, resulting in three stages
(male size classes) defined by CL measurements of (1) 90-104 mm, (2) 105-119 mm, and (3) 120 mm+ (i.e., 120 mm and
above). This consolidation was driven by concern about the accuracy and consistency of shell-condition information,
which had been used in distinguishing stages 3 and 4 of the earlier model.

In 2016 the accepted SMBKC assessment model made use of the modeling framework Gmacs (Webber et al. 2016). In that
assessment,  an effort was made to match the 2015 SMBKC stock assessment model to bridge a framework which 
provided greater flexibility and opportunity to evaluate model assumptions more fully.

## Assessment Methodology

This assessment model again uses the modeling framework Gmacs and is detailed in Appendix A.

## Model Selection and Evaluation

Five models were presented in the previous assessment. This year, four models are presented with the  reference model
being the same configuration as approved last year (Ianelli et al. 2017), two sensitivities are considered, one with a  different treatment of NMFS
bottom trawl survey (BTS) data using a geo-spatial model (VAST; Thorson and Barnett 2017; Appendix C). A second 
sensitivity was constructed which weights the
survey data more heavily. In addition to these sensitivities, we evaluated the impacts of adding new data 
to the reference model. In summary, the following lists the models presented and the naming convention  used:

1. **2017 Model**: the 2017 recommended model without any new data

2. **BTS**: adds in the 2018 bottom trawl survey (BTS) data

3. **BTS and pot**: as with previous but including the 2018 ADFG pot survey data (Model 16.0 or "reference case")

3. **VAST**: applies a geo-spatial delta-GLMM model (Thorson and Barnett 2017) to the BTS data which provides a different BTS index. See appendix B for 
  details and diagnostics. This is a preliminary examination as more work is needed to ensure options for the BTS CPUE data
   were specified appropriately.

3. **Fit survey**: an exploratory scenario that's the same as the reference model except the NMFS trawl survey is up-weighted by
   $\lambda^\text{NMFS}=$ 2 and the ADF&G pot survey is 
   up-weighted by $\lambda^\text{ADFG}=$ 2. 

Note that SSC convention would label these (item 3 above) as model 16.0 (the
model first developed in that year). Since only a few models are presented here, for simplicity
we labeled model 16.0 as "reference" and for the others, we used the  simple naming convention
presented above.

## Results

### a. Sensitivity to new data
Results for scenarios are provided with comparisons to the 2017 model and sensitivity new data are shown in Figures
\ref{fig:surv1} and \ref{fig:surv2} with recruitment and spawning biomass shown in Figures \ref{fig:rec1} and \ref{fig:ssb1}, respectively. 
 The fits to survey CPUEs and spawning biomass show that the addition of new data results in more of a decline than
 in the 2017 assessment, especially with the addition of the pot survey. 

### b. Alternative NMFS bottom-trawl survey index
Results comparing model fits between the VAST model and the reference case show different time-series
of data and a different model fit (Figure \ref{fig:surv3}). The effect on spawning biomass suggests estimates were consistently
higher since 1990 compared to the reference model (Figure  \ref{fig:ssb2}).

### c. Effective sample sizes and weighting factors
Observed and estimated effective sample sizes are compared in Table \ref{tab:effn}. 
Data weighting factors, standard deviation of normalized residuals (SDNRs), and median absolute residual (MAR) are 
presented in Table \ref{tab:data_weighting}. The SDNR for the trawl survey
is acceptable at 1.66 in the reference model. Francis (2011) weighting was applied in 2017
but given the relatively few size
bins in this assessment, this application was suspended this year.  
The SDNRs for the pot surveys show a similar pattern in each of the
scenarios, but are much higher suggesting an inconsistency between 
the pot survey data and the model structure and other data
components. Rather than re-weighting, we chose to retain the values 
as specified, noting that down-weighting these data would effectively 
exclude the signal from this series. 
The MAR values for the trawl and pot surveys shows the same pattern among each of the
scenarios as the SDNR. The SDNR and MAR values for the trawl survey and pot survey size compositions were relatively good,
ranging from 0.54 to 0.73 for the reference case.
The SDNRs for the directed pot fishery and other size compositions were  similar to previous estimates.

### d. Parameter estimates
Model parameter estimates for each of the Gmacs scenarios are summarized in Tables \ref{tab:est_pars_ref},
\ref{tab:est_pars_vast}, and \ref{tab:est_pars_all}. These parameter
estimates are compared in Table \ref{tab:est_pars_all}. Negative log-likelihood values and management measures for each
of the model configurations are compared in Tables \ref{tab:management_quants} through \ref{tab:likelihood_components}.

There are some differences in parameter estimates among models as 
reflected in the log-likelihood components and the management quantities. 
The parameter estimates in the "fit survey" scenario differ the most, as expected, particularly the estimate of the ADF&G pot survey
catchability ($q$) (see Table \ref{tab:est_pars_all}). Also, the residuals for recruitment in the first size group are large for these
model runs, presumably because higher estimates of recruits in some years are required by the model
 to match the observed biomass trends. 

Selectivity estimates show some variability between models (Figure \ref{fig:selectivity}). Estimated recruitment is
variable over time for all models and in recent years is well below average (Figure \ref{fig:recruitment}).  Estimated
mature male biomass on 15 February also fluctuates considerably (Figure \ref{fig:mmb}). Estimated natural mortality each
year ($M_t$) is presented in Figure \ref{fig:M_t}.

### e. Evaluation of the fit to the data.
The model fits to total male ($\ge$ 90 mm CL) trawl survey biomass tend to miss the recent peak around 2010 and is
slightly above the 2017 value for the key sensitivities (Figures \ref{fig:trawl_survey_biomass}).  All of the models fit
the pot survey CPUE poorly (Figure \ref{fig:pot_survey_cpue}. For both surveys the standardized residuals tend to have
similar patterns with some improvement (generally) for the  VAST model (Figures \ref{fig:bts_resid_nmfs} and
\ref{fig:bts_resid_adfg}).

Fits to the size compositions for trawl survey, pot survey, and commercial observer data are reasonable but miss the largest
size category in some years (Figures \ref{fig:sc_pot}, \ref{fig:sc_pot_discarded}, and \ref{fig:sc_trawl_discarded}) 
for all scenarios. Representative
residual  plots of the composition data fits are generally poor (Figures \ref{fig:sc_res_ref} and \ref{fig:sc_res_fit_survey}).
The model fits to different types of retained and discarded catch values performed as expected given the assumed levels
of uncertainty on the input data (Figure  \ref{fig:fit_to_catch} ).

Unsurprisingly, the **Fit surveys** model fits the 
the NMFS survey biomass and ADF&G pot survey CPUE  data better but still has a similar residual pattern
(Figures \ref{fig:trawl_survey_biomass} and \ref{fig:pot_survey_cpue}). 
It is worth noting that that this scenario (included for exploratory purposes) resulted in worse SDNR and MAR values for the two abundance indices.

### f. Retrospective and historical analyses
This is only the second year a formal assessment model developed for this stock. As such, retrospective patterns and 
historical analyses relative to fisheries impacts are limited.

### g. Uncertainty and sensitivity analyses.
Estimated standard deviations of parameters and selected management measures for the models are summarized in
Tables \ref{tab:est_pars_ref}, \ref{tab:est_pars_vast}, and \ref{tab:est_pars_fit_survey} 
(compiled in Table \ref{tab:est_pars_all}). Probabilities for mature male biomass and OFL in 2017 are
presented in Section F.


### h. Comparison of alternative model scenarios.
The estimates of mature male biomass (Figure \ref{fig:mmb}), for the **Fit survey** sensitivity 
differs from the other models due to a low value for pot survey catchability being estimated (which tends to scale the population
estimate). This existng scenario results in a lower MMB from the mid-1980s
through to the late-1990s, and is again lower in the most recent 5 years. This scenario upweights both the trawl 
and pot surveys abundance indices  and represents a model run
that places greater emphasis on the abundance indices.

In summary, the use of the reference model for management purposes is preferred since it provides the best fit to the
data and is consistent with previous model specifications.  Research on alternative model specifications (e.g., natural
mortality variability) was limited this year. The VAST model may take better account of spatial
processes but requires more research to ensure it has been appropriately applied and the assumptions are reasonable.
Consequently, the reference model appears reasonable and appropriate for ACL and OFL  determinations for this stock in
2017. Nonetheless, the **Fit surveys** model, while difficult to statistically justify, portends a more dire stock status
(see below) and should highlight the caution needed in managing this resource.


# F. Calculation of the OFL and ABC
The overfishing level (OFL) is the fishery-related mortality biomass associated with fishing mortality $F_\mathit{OFL}$. The SMBKC stock is currently managed as Tier 4, and only a Tier 4 analysis is presented here. Thus given stock estimates or suitable proxy values of $B_\mathit{MSY}$ and $F_\mathit{MSY}$, along with two additional parameters $\alpha$ and $\beta$, $F_\mathit{OFL}$ is determined by the control rule
\begin{align}
    F_\mathit{OFL} &= 
    \begin{cases}
        F_\mathit{MSY}, &\text{ when } B/B_\mathit{MSY} > 1\\
        F_\mathit{MSY} \frac{\left( B/B_\mathit{MSY} - \alpha \right)}{(1 - \alpha)}, &\text{ when } \beta < B/B_\mathit{MSY} \le 1
    \end{cases}\\
    F_\mathit{OFL} &< F_\mathit{MSY} \text{ with directed fishery } F = 0 \text{ when } B/B_\mathit{MSY} \le \beta \notag
\end{align}
where $B$ is quantified as mature-male biomass (MMB) at mating with time of mating assigned a nominal date of 15
February. Note that as $B$ itself is a function of the fishing mortality $F_\mathit{OFL}$ (therefore numerical
approximation of $F_\mathit{OFL}$ is required). As implemented for this assessment, all calculations proceed according
to the model equations given in Appendix A. $F_\mathit{OFL}$ is taken to be full-selection fishing mortality in the
directed pot fishery and groundfish trawl and fixed-gear fishing mortalities set at their model geometric mean values
over years for which there are data-based estimates of bycatch-mortality biomass.

The currently recommended Tier 4 convention is to use the full assessment period, currently 1978-
2018, to define a $B_\mathit{MSY}$ proxy in terms of average estimated MMB and to set $\gamma$ = 1.0 with
assumed stock natural mortality $M$ = 0.18 $\text{yr}^{-1}$ in setting the $F_\mathit{MSY}$ proxy value $\gamma M$. The
parameters $\alpha$ and $\beta$ are assigned their default values $\alpha$ = 0.10 and $\beta$ = 0.25. The
$F_\mathit{OFL}$, OFL, ABC, and MMB in 2018 for all scenarios are summarized in Table \ref{tab:management_quants}. The ABC
is 80% of the OFL.
\begin{table}[ht]
\centering
\caption{Comparisons of management measures for the model scenarios. Biomass and OFL are in tons.} 
\label{tab:management_quants}
\begin{tabular}{lrrr}
  \hline
Component & Reference & VAST & Fit surveys \\ 
  \hline
$\text{MMB}_{2018}$ & 1309.025 & 2257.996 & 4038.448 \\ 
  $B_\text{MSY}$ & 3698.941 & 4240.714 & 9161.159 \\ 
  $F_\text{OFL}$ & 0.043 & 0.075 & 0.059 \\ 
  $\text{OFL}_{2018}$ & 38.464 & 117.589 & 191.950 \\ 
  $\text{ABC}_{2018}$ & 30.771 & 94.072 & 153.560 \\ 
   \hline
\end{tabular}
\end{table}


# G. Rebuilding Analysis

This stock is not currently subject to a rebuilding plan. However, interpretation of the point estimate for the reference case
suggests that the mature male biomass is below 50% of $B_\mathit{MSY}$ but slightly above for the "VAST" model configuration (Table \ref{tab:management_quants} ).

# H. Data Gaps and Research Priorities

The following topics have been listed as areas where more research on SMBKC is needed:

  1. Growth increments and molting probabilities as a function of size.

  2. Trawl survey catchability and selectivities.

  3. Temporal changes in spatial distributions near the island.

  4. Natural mortality.

# I. Projections and outlook

The outlook for recruitment is pessimistic and the abundance relative to the proxy $B_\mathit{MSY}$ is low. 
The NMFS survey results in 2018 noted ocean conditions warmer than 
normal with an absence of a "cold pool" in the region. This could have detrimental effects on the SMBKC stocks and
should be carefully monitored. Relative to the impact of historical fishing, we again conducted a
 "dynamic-$B_0$" analysis. This procedure simply projects
the population based on estimated recruitment but removes the effect of fishing. For the reference case,
this suggests that the impact of fishing has reduced to stock to about
  60% of what it would have been in the absence of
  fishing (Figure \ref{fig:dynB0}) . The other non-fishing contributors to the observed depleted stock trend (ignoring stock-recruit
  relationship) may reflect variable  survival rates due to environmental conditions and also range shifts. 

# J. Acknowledgements

We thank the Crab Plan Team and AFSC staff for reviewing an earlier draft of this report 
and Andre Punt for his input into refinements to the Gmacs model code.

# K. References

Alaska Department of Fish and Game (ADF&G). 2013. Crab observer training and deployment manual. Alaska Department of Fish and Game Shellfish Observer Program, Dutch Harbor. Unpublished.

Collie, J.S., A.K. Delong, and G.H. Kruse. 2005. Three-stage catch-survey analysis applied to blue king crabs. Pages 683-714 [In] Fisheries assessment and management in data-limited situations. University of Alaska Fairbanks, Alaska Sea Grant Report 05-02, Fairbanks.

Daly, B., R. Foy, and C. Armistead. 2014. The 2013 eastern Bering Sea continental shelf bottom trawl survey: results for commercial crab species. NOAA Technical Memorandum 295, NMFS-AFSC.

Donaldson, W.E., and S.C. Byersdorfer. 2005. Biological field techniques for lithodid crabs. University of Alaska Fairbanks, Alaska Sea Grant Report 05-03, Fairbanks.

Fitch, H., M. Deiman, J. Shaishnikoff, and K. Herring. 2012. Annual management report for the commercial and subsistence shellfish fisheries of the Bering Sea, 2010/11. Pages 75-1776 [In] Fitch, H., M. Schwenzfeier, B. Baechler, T. Hartill, M. Salmon, and M. Deiman, E.

Evans, E. Henry, L. Wald, J. Shaishnikoff, K. Herring, and J. Wilson. 2012. Annual management report for the commercial and subsistence shellfish fisheries of the Aleutian Islands, Bering Sea and the Westward Region’s Shellfish Observer Program, 2010/11. Alaska Department of Fish and Game, Fishery Management Report No. 12-22, Anchorage.

Fournier, D.A., H.J. Skaug, J. Ancheta, J. Ianelli, A. Magnusson, M.N. Maunder, A. Nielsen, and J. Sibert. 2012. AD Model Builder: using automatic differentiation for statistical inference of highly parameterized complex nonlinear models. Optim. Methods Softw. 27:233-249.

Francis, R.I.C.C. 2011. Data weighting in statistical fisheries stock assessment models. Can. J. Fish. Aquat. Sci. 68: 1124-1138.

Gaeuman, W.B. 2013. Summary of the 2012/13 mandatory crab observer program database for the Bering Sea/Aleutian Islands commercial crab fisheries. Alaska Department of Fish and Game, Fishery Data Series No. 13-54, Anchorage. 

Gish, R.K., V.A. Vanek, and D. Pengilly. 2012. Results of the 2010 triennial St. Matthew Island blue king crab pot survey and 2010/11 tagging study. Alaska Department of Fish and Game, Fishery Management Report No. 12-24, Anchorage.

Ianelli, J., D. Webber, and J. Zheng, 2017. Stock assessment of Saint Matthews Island blue king crab. North Pacific Fishery Management Council. Anchorage AK.

Jensen, G.C., and D.A. Armstrong. 1989. Biennial reproductive cycle of blue king crab, *Paralithodes platypus*, at the Pribilof Islands, Alaska and comparison to a congener, *P. camtschatica*. Can. J. Fish. Aquat. Sci. 46: 932-940.

Moore, H., L.C. Byrne, and D. Connolly. 2000. Alaska Department of Fish and Game summary of the 1998 mandatory shellfish observer program database. Alaska Dept. Fish and Game, Commercial Fisheries Division, Reg. Inf. Rep. 4J00-21, Kodiak.

North Pacific Fishery Management Council (NPFMC). 1998. Fishery Management Plan for Bering Sea/Aleutian Islands king and Tanner crabs. North Pacific Fishery Management Council, Anchorage.

North Pacific Fishery Management Council (NPFMC). 1999. Environmental assessment/regulatory impact review/initial regulatory flexibility analysis for Amendment 11 to the Fishery Management Plan for Bering Sea/Aleutian Islands king and Tanner crabs. North Pacific Fishery Management Council, Anchorage.

North Pacific Fishery Management Council (NPFMC). 2000. Environmental assessment/regulatory impact review/initial regulatory flexibility analysis for proposed Amendment 15 to the Fishery Management Plan for king and Tanner crab fisheries in the Bering Sea/Aleutian Islands and regulatory amendment to the Fishery Management Plan for the groundfish fishery of the Bering Sea and Aleutian Islands area: A rebuilding plan for the St. Matthew blue king crab stock. North Pacific Fishery Management Council, Anchorage. Draft report.

North Pacific Fishery Management Council (NPFMC). 2007. Public Review Draft: Environmental assessment for proposed Amendment 24 to the Fishery Management Plan for Bering Sea and Aleutian Islands king and Tanner crabs to revise overfishing definitions. 14 November 2007. North Pacific Fishery Management Council, Anchorage.

Otto, R.S. 1990. An overview of eastern Bering Sea king and Tanner crab fisheries. Pages 9-26 [In] Proceedings of the international symposium on king and Tanner crabs. University of Alaska Fairbanks, Alaska Sea Grant Program Report 90-4, Fairbanks.

Otto, R.S., and P.A. Cummiskey. 1990. Growth of adult male blue king crab (*Paralithodes platypus*). Pages 245-258 [In] Proceedings of the international symposium on king and Tanner crabs. University of Alaska Fairbanks, Alaska Sea Grant Report 90-4, Fairbanks.

Paul, J.M., A. J. Paul, R.S. Otto, and R.A. MacIntosh. 1991. Spermatophore presence in relation to carapace length for eastern Bering Sea blue king crab (*Paralithodes platypus*, Brandt, 1850) and red king crab (*P. camtschaticus*, Tilesius, 1815). J. Shellfish Res. 10: 157-163.

Pengilly, D. and D. Schmidt. 1995. Harvest Strategy for Kodiak and Bristol Bay red king crab and St. Matthew Island and Pribilof blue king crab. Alaska Department of Fish and Game, Commercial Fisheries Management and Development Division, Special Publication Number 7, Juneau.

Somerton, D.A., and R.A. MacIntosh. 1983. The size at sexual maturity of blue king crab, Paralithodes platypus, in Alaska. Fishery Bulletin 81: 621-828.

Thorson, J.T., and L.A.K. Barnett. 2017. Comparing estimates of abundance trends and distribution shifts using single- and multispecies models of fishes and biogenic habitat. ICES Journal of Marine Science 75:1311-1321.

Thorson, J.T., J.N. Ianelli, E. Larsen, L. Ries, M.D. Scheuerell, C. Szuwalski, and E. Zipkin. 2016. Joint dynamic species distribution models: a tool for community ordination and spatiotemporal monitoring. Glob. Ecol. Biogeogr. 25(9): 1144–1158. geb.12464. 

Thorson, J.T., Scheuerell, M.D., Shelton, A.O., See, K.E., Skaug, H.J., and Kristensen, K. 2015. Spatial factor analysis: a new tool for estimating joint species distributions and correlations in species range. Methods Ecol. Evol. 6(6): 627–637. doi:10.1111/2041-210X.12359. 

Webber, D., J. Zheng, and J. Ianelli, 2016. Stock assessment of Saint Matthews Island Blue King Crab. North Pacific Fishery Managment Council. Anchorage AK.

Zheng, J. 2005. A review of natural mortality estimation for crab stocks: data-limited for every stock? Pages 595-612 [In] Fisheries Assessment and Management in Data-Limited Situations. University of Alaska Fairbanks, Alaska Sea Grant Program Report 05-02, Fairbanks.

Zheng, J., and G.H. Kruse. 2002. Assessment and management of crab stocks under uncertainty of massive die-offs and rapid changes in survey catchability. Pages 367-384 [In] A.J. Paul,E.G. Dawe, R. Elner, G.S. Jamieson, G.H. Kruse, R.S. Otto, B. Sainte-Marie, T.C. Shirley, and D. Woodby (eds.). Crabs in Cold Water Regions: Biology, Management, and Economics. University of Alaska Fairbanks, Alaska Sea Grant Report 02-01, Fairbanks.

Zheng, J., M.C. Murphy, and G.H. Kruse. 1997. Application of catch-survey analysis to blue king crab stocks near Pribilof and St. Matthew Islands. Alaska Fish. Res. Bull. 4:62-74.



\newpage\clearpage

# Tables

\begin{table}[ht]
\centering
\caption{Observed proportion of crab by size class during the ADF\&G crab observer pot-lift sampling. Source: ADF\&G Crab Observer Database.} 
\label{tab:stage_cpue_1}
\begin{tabular}{lrrrrrr}
  \hline
  Year & Total pot lifts & Pot lifts sampled & Number of crab (90 mm+ CL) & Stage 1 & Stage 2 & Stage 3 \\
  \hline
  1990/91 & 26,264 &  10 &   150 & 0.113 & 0.393 & 0.493 \\
  1991/92 & 37,104 & 125 & 3,393 & 0.133 & 0.177 & 0.690 \\
  1992/93 & 56,630 &  71 & 1,606 & 0.191 & 0.268 & 0.542 \\
  1993/94 & 58,647 &  84 & 2,241 & 0.281 & 0.210 & 0.510 \\
  1994/95 & 60,860 & 203 & 4,735 & 0.294 & 0.271 & 0.434 \\
  1995/96 & 48,560 &  47 &   663 & 0.148 & 0.212 & 0.640 \\
  1996/97 & 91,085 &  96 &   489 & 0.160 & 0.223 & 0.618 \\
  1997/98 & 81,117 & 133 & 3,195 & 0.182 & 0.205 & 0.613 \\
  1998/99 & 91,826 & 135 & 1.322 & 0.193 & 0.216 & 0.591 \\
  \multicolumn{2}{l}{1999/00 - 2008/09} & \multicolumn{5}{c}{FISHERY CLOSED} \\
  2009/10 & 10,484 & 989   & 19,802 & 0.141 & 0.324 & 0.535 \\
  2010/11 & 29,356 & 2,419 & 45,466 & 0.131 & 0.315 & 0.553 \\
  2011/12 & 48,554 & 3,359 & 58,666 & 0.131 & 0.305 & 0.564 \\
  2012/13 & 37,065 & 2,841 & 57,298 & 0.141 & 0.318 & 0.541 \\
  \multicolumn{2}{l}{2013/14} & \multicolumn{5}{c}{FISHERY CLOSED} \\
  2014/15 & 10,133 & 895 & 9,906 & 0.094 & 0.228 & 0.679 \\
  2015/16 &  5,475 & 419 & 3,248 & 0.115 & 0.252 & 0.633 \\
  \multicolumn{2}{l}{2016/17} & \multicolumn{5}{c}{FISHERY CLOSED} \\
  \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Groundfish SMBKC male bycatch biomass (t) estimates. Trawl includes pelagic trawl and non-pelagic trawl types. Source: J. Zheng, ADF\&G, and author estimates based on data from R. Foy, NMFS. Estimates used after 2008/09 are from NMFS Alaska Regional Office.} 
\label{tab:smbkc_groundfish_bycatch}
\begin{tabular}{rrr}
  \hline
Year & Trawl bycatch & Fixed gear bycatch \\ 
  \hline
1978 & 0.000 & 0.000 \\ 
  1979 & 0.000 & 0.000 \\ 
  1980 & 0.000 & 0.000 \\ 
  1981 & 0.000 & 0.000 \\ 
  1982 & 0.000 & 0.000 \\ 
  1983 & 0.000 & 0.000 \\ 
  1984 & 0.000 & 0.000 \\ 
  1985 & 0.000 & 0.000 \\ 
  1986 & 0.000 & 0.000 \\ 
  1987 & 0.000 & 0.000 \\ 
  1988 & 0.000 & 0.000 \\ 
  1989 & 0.000 & 0.000 \\ 
  1990 & 0.000 & 0.000 \\ 
  1991 & 3.538 & 0.045 \\ 
  1992 & 1.996 & 2.268 \\ 
  1993 & 1.542 & 0.500 \\ 
  1994 & 0.318 & 0.091 \\ 
  1995 & 0.635 & 0.136 \\ 
  1996 & 0.500 & 0.045 \\ 
  1997 & 0.500 & 0.181 \\ 
  1998 & 0.500 & 0.907 \\ 
  1999 & 0.500 & 1.361 \\ 
  2000 & 0.500 & 0.500 \\ 
  2001 & 0.500 & 0.862 \\ 
  2002 & 0.726 & 0.408 \\ 
  2003 & 0.998 & 1.134 \\ 
  2004 & 0.091 & 0.635 \\ 
  2005 & 0.500 & 0.590 \\ 
  2006 & 2.812 & 1.451 \\ 
  2007 & 0.045 & 69.717 \\ 
  2008 & 0.272 & 6.622 \\ 
  2009 & 0.638 & 7.522 \\ 
  2010 & 0.360 & 9.564 \\ 
  2011 & 0.170 & 0.796 \\ 
  2012 & 0.011 & 0.739 \\ 
  2013 & 0.163 & 0.341 \\ 
  2014 & 0.010 & 0.490 \\ 
  2015 & 0.010 & 0.711 \\ 
  2016 & 0.229 & 1.633 \\ 
  2017 & 0.052 & 6.032 \\ 
   \hline
\end{tabular}
\end{table}

\clearpage

\begin{table}[ht]
\centering
\caption{Fishery characteristics and update. Columns include the 1978/79 to 2015/16 directed St. Matthew Island blue king crab pot fishery. The Guideline Harvest Level (GHL) and Total Allowable Catch (TAC) are in millions of pounds. Harvest includes deadloss. Catch per unit effort (CPUE) in this table is simply the harvest number / pot lifts. The average weight is the harvest weight / harvest number in pounds. The average CL is the average of retained crab in mm from dockside sampling of delivered crab. Source: Fitch et al 2012; ADF\&G Dutch Harbor staff, pers. comm. Note that management (GHL) units are in pounds, for conserving space, conversion to tons is ommitted.} 
\label{tab:smbkc_fishery}
\begin{tabular}{lrrrrrrrr}
  \hline
  & & & \multicolumn{2}{c}{Harvest} & & & & \\
  \cline{4-5}
  Year & Dates & GHL/TAC & Crab & Pounds & Pot lifts & CPUE & avg wt & avg CL \\
  \hline
  1978/79 & 07/15 - 09/03 &  & 436,126 & 1,984,251 & 43,754 & 10 & 4.5 & 132.2 \\
  1979/80 & 07/15 - 08/24 &  &  52,966 &   210,819 &  9,877 &  5 & 4.0 & 128.8 \\
  1980/81 & 07/15 - 09/03 & \multicolumn{7}{c}{CONFIDENTIAL} \\
  1981/82 & 07/15 - 08/21 &  & 1,045,619 & 4,627,761 &  58,550 &  18 & 4.4 & NA \\
  1982/83 & 08/01 - 08/16 &  & 1,935,886 & 8,844,789 & 165,618 &  12 & 4.6 & 135.1 \\
  1983/84 & 08/20 - 09/06 & 8.0     & 1,931,990 & 9,454,323 & 133,944 &  14 & 4.9 & 137.2 \\
  1984/85 & 09/01 - 09/08 & 2.0-4.0 &   841,017 & 3,764,592 &  73,320 &  11 & 4.5 & 135.5 \\
  1985/86 & 09/01 - 09/06 & 0.9-1.9 &   436,021 & 2,175,087 &  46,988 &   9 & 5.0 & 139.0 \\
  1986/87 & 09/01 - 09/06 & 0.2-0.5 &   219,548 & 1,003,162 &  22,073 &  10 & 4.6 & 134.3 \\
  1987/88 & 09/01 - 09/05 & 0.6-1.3 &   227,447 & 1,039,779 &  28,230 &   8 & 4.6 & 134.1 \\
  1988/89 & 09/01 - 09/05 & 0.7-1.5 &   280,401 & 1,236,462 &  21,678 &  13 & 4.4 & 133.3 \\
  1989/90 & 09/01 - 09/04 & 1.7     &   247,641 & 1,166,258 &  30,803 &   8 & 4.7 & 134.6 \\
  1990/91 & 09/01 - 09/07 & 1.9     &   391,405 & 1,725,349 &  26,264 &  15 & 4.4 & 134.3 \\
  1991/92 & 09/16 - 09/20 & 3.2     &   726,519 & 3,372,066 &  37,104 &  20 & 4.6 & 134.1 \\
  1992/93 & 09/04 - 09/07 & 3.1     &   545,222 & 2,475,916 &  56,630 &  10 & 4.5 & 134.1 \\
  1993/94 & 09/15 - 09/21 & 4.4     &   630,353 & 3,003,089 &  58,647 &  11 & 4.8 & 135.4 \\
  1994/95 & 09/15 - 09/22 & 3.0     &   827,015 & 3,764,262 &  60,860 &  14 & 4.9 & 133.3 \\
  1995/96 & 09/15 - 09/20 & 2.4     &   666,905 & 3,166,093 &  48,560 &  14 & 4.7 & 135.0 \\
  1996/97 & 09/15 - 09/23 & 4.3     &   660,665 & 3,078,959 &  91,085 &   7 & 4.7 & 134.6 \\
  1997/98 & 09/15 - 09/22 & 5.0     &   939,822 & 4,649,660 &  81,117 &  12 & 4.9 & 139.5 \\
  1998/99 & 09/15 - 09/26 & 4.0     &   635,370 & 2,968,573 &  91,826 &   7 & 4.7 & 135.8 \\
  \multicolumn{2}{l}{1999/00 - 2008/09} & \multicolumn{7}{c}{FISHERY CLOSED} \\
  2009/10 & 10/15 - 02/01 & 1.17    &   103,376 &   460,859 &  10,697 &  10 & 4.5 & 134.9 \\
  2010/11 & 10/15 - 02/01 & 1.60    &   298,669 & 1,263,982 &  29,344 &  10 & 4.2 & 129.3 \\
  2011/12 & 10/15 - 02/01 & 2.54    &   437,862 & 1,881,322 &  48,554 &   9 & 4.3 & 130.0 \\
  2012/13 & 10/15 - 02/01 & 1.63    &   379,386 & 1,616,054 &  37,065 &  10 & 4.3 & 129.8 \\
  \multicolumn{2}{l}{2013/14} & \multicolumn{7}{c}{FISHERY CLOSED} \\
  2014/15 & 10/15 - 02/05 & 0.66    &    69,109 &   308,582 &  10,133 &   7 & 4.5 & 132.3 \\
  2015/16 & 10/19 - 11/28 & 0.41    &    24,076 &   105,010 &   5,475 &   4 & 4.4 & 132.6 \\
  \multicolumn{2}{l}{2016/17} & \multicolumn{7}{c}{FISHERY CLOSED} \\
  \multicolumn{2}{l}{2017/18} & \multicolumn{7}{c}{FISHERY CLOSED} \\
  \hline
\end{tabular}
\end{table}

\newpage

\begin{table}[ht]
\centering
\caption{NMFS EBS trawl-survey area-swept estimates of male crab abundance ($10^6$ crab) and male ($\ge90$ mm CL) biomass ($10^6$ lbs). Total number of captured male crab $\ge$ 90 mm CL is also given. Source: R. Foy, NMFS. The "+" refer to plus group.} 
\label{tab:stage_cpue_nmfs}
\begin{tabular}{lccccccccc}
  \hline
       & \multicolumn{5}{c}{Abundance}                       & & \multicolumn{2}{c}{Biomass} & \\
  \cline{2-6}\cline{8-9}
       & Stage-1     & Stage-2      & Stage-3   &       &    & & Total       &               & Number \\ 
  Year & (90-104 mm) & (105-119 mm) & (120+ mm) & Total & CV & & (90+ mm CL) & CV            & of crabs \\ 
  \hline
  1978  & 2.213 & 1.991 & 1.521 & 5.726 & 0.411 & & 15.064  & 0.394 & 157 \\
1979  & 3.061 & 2.281 & 1.808 & 7.150 & 0.472 & & 17.615  & 0.463 & 178 \\
1980  & 2.856 & 2.563 & 2.541 & 7.959 & 0.572 & & 22.017  & 0.507 & 185 \\
1981  & 0.483 & 1.213 & 2.263 & 3.960 & 0.368 & & 14.443  & 0.402 & 140 \\
1982  & 1.669 & 2.431 & 5.884 & 9.984 & 0.401 & & 35.763  & 0.344 & 271 \\
1983  & 1.061 & 1.651 & 3.345 & 6.057 & 0.332 & & 21.240  & 0.298 & 231 \\
1984  & 0.435 & 0.497 & 1.452 & 2.383 & 0.175 & & 8.976 & 0.179 & 105 \\
1985  & 0.379 & 0.376 & 1.117 & 1.872 & 0.216 & & 6.858 & 0.210 & 93  \\
1986  & 0.203 & 0.447 & 0.374 & 1.025 & 0.428 & & 3.124 & 0.388 & 46  \\
1987  & 0.325 & 0.631 & 0.715 & 1.671 & 0.302 & & 5.024 & 0.291 & 71  \\
1988  & 0.410 & 0.816 & 0.957 & 2.183 & 0.285 & & 6.963 & 0.252 & 81  \\
1989  & 2.169 & 1.154 & 1.786 & 5.109 & 0.314 & & 13.974  & 0.271 & 208 \\
1990  & 1.053 & 1.031 & 2.338 & 4.422 & 0.302 & & 14.837  & 0.274 & 170 \\
1991  & 1.147 & 1.665 & 2.233 & 5.046 & 0.259 & & 15.318  & 0.248 & 197 \\
1992  & 1.074 & 1.382 & 2.291 & 4.746 & 0.206 & & 15.638  & 0.201 & 220 \\
1993  & 1.521 & 1.828 & 3.276 & 6.626 & 0.185 & & 21.051  & 0.169 & 324 \\
1994  & 0.883 & 1.298 & 2.257 & 4.438 & 0.187 & & 14.416  & 0.176 & 211 \\
1995  & 1.025 & 1.188 & 1.741 & 3.953 & 0.187 & & 12.574  & 0.178 & 178 \\
1996  & 1.238 & 1.891 & 3.064 & 6.193 & 0.263 & & 20.746  & 0.241 & 285 \\
1997  & 1.165 & 2.228 & 3.789 & 7.182 & 0.367 & & 24.084  & 0.337 & 296 \\
1998  & 0.660 & 1.661 & 2.849 & 5.170 & 0.373 & & 17.586  & 0.355 & 243 \\
1998  & 0.223 & 0.222 & 0.558 & 1.003 & 0.192 & & 3.515 & 0.182 & 52  \\
2000  & 0.282 & 0.285 & 0.740 & 1.307 & 0.303 & & 4.623 & 0.310 & 61  \\
2001  & 0.419 & 0.502 & 0.938 & 1.859 & 0.243 & & 6.242 & 0.245 & 91  \\
2002  & 0.111 & 0.230 & 0.640 & 0.981 & 0.311 & & 3.820 & 0.320 & 38  \\
2003  & 0.449 & 0.280 & 0.465 & 1.194 & 0.399 & & 3.454 & 0.336 & 65  \\
2004  & 0.247 & 0.184 & 0.562 & 0.993 & 0.369 & & 3.360 & 0.305 & 48  \\
2005  & 0.319 & 0.310 & 0.501 & 1.130 & 0.403 & & 3.620 & 0.371 & 42  \\
2006  & 0.917 & 0.642 & 1.240 & 2.798 & 0.339 & & 8.585 & 0.334 & 126 \\
2007  & 2.518 & 2.020 & 1.193 & 5.730 & 0.420 & & 14.266  & 0.385 & 250 \\
2008  & 1.352 & 0.801 & 1.457 & 3.609 & 0.289 & & 10.261  & 0.284 & 167 \\
2009  & 1.573 & 2.161 & 1.410 & 5.144 & 0.263 & & 13.892  & 0.256 & 251 \\
2010  & 3.937 & 3.253 & 2.458 & 9.648 & 0.544 & & 24.539  & 0.466 & 388 \\
2011  & 1.800 & 3.255 & 3.207 & 8.263 & 0.587 & & 24.099  & 0.558 & 318 \\
2012  & 0.705 & 1.970 & 1.808 & 4.483 & 0.361 & & 13.669  & 0.339 & 193 \\
2013  & 0.335 & 0.452 & 0.807 & 1.593 & 0.215 & & 5.043 & 0.217 & 74  \\
2014  & 0.723 & 1.627 & 1.809 & 4.160 & 0.503 & & 13.292  & 0.449 & 181 \\
2015  & 0.992 & 1.269 & 1.979 & 4.240 & 0.774 & & 12.958  & 0.770 & 153 \\
2016  & 0.535 & 0.660 & 1.178 & 2.373 & 0.447 & & 7.685 & 0.393 & 108 \\
2017  & 0.091 & 0.323 & 0.663 & 1.077 & 0.657 & & 3.955 & 0.600 & 42  \\
2018  & 0.154 & 0.232 & 0.660 & 1.047 & 0.298 & & 3.816 & 0.281 & 62  \\
  \hline
\end{tabular}
\end{table}


\begin{table}[ht]
\centering
\caption{Size-class and total CPUE (90+ mm CL) with estimated CV and total number of captured crab (90+ mm CL) 
from the 96 common stations surveyed during the ADF\&G SMBKC pot surveys. Source: ADF\&G.} 
\label{tab:stage_cpue}
\begin{tabular}{lcccrrr}
  \hline
       & Stage-1     & Stage-2      & Stage-3   &            &    & \\ 
  Year & (90-104 mm) & (105-119 mm) & (120+ mm) & Total CPUE & CV & Number of crabs \\ 
  \hline
  1995 & 1.919 & 3.198 & 6.922 & 12.042 & 0.13 & 4624 \\ 
  1998 & 0.964 & 2.763 & 8.804 & 12.531 & 0.06 & 4812 \\ 
  2001 & 1.266 & 1.737 & 5.487 & 8.477 & 0.08 & 3255 \\ 
  2004 & 0.112 & 0.414 & 1.141 & 1.667 & 0.15 & 640 \\ 
  2007 & 1.086 & 2.721 & 4.836 & 8.643 & 0.09 & 3319 \\ 
  2010 & 1.326 & 3.276 & 5.607 & 10.209 & 0.13 & 3920 \\ 
  2013 & 0.878 & 1.398 & 3.367 & 5.643 & 0.19 & 2167 \\ 
  2015 & 0.198 & 0.682 & 1.924 & 2.805 & 0.18 & 1077 \\ 
  2016 & 0.198 & 0.456 & 1.724 & 2.378 & 0.19 & 777 \\ 
  2017 & 0.177 & 0.429 & 1.083 & 1.689 & 0.25 & 643 \\ 
  2018 & 0.076 & 0.161 & 0.508 & 0.745 & 0.14 &   286\\
   \hline
\end{tabular}
\end{table}


\begin{table}[ht]
\centering
\caption{Mean weight (kg) by stage in used in all of the models (provided as a vector of weights at length each year to Gmacs).} 
\label{tab:length_weight}
\begin{tabular}{rrrr}
  \hline
Year & Stage-1 & Stage-2 & Stage-3 \\ 
  \hline
1978 & 0.7 & 1.2 & 1.9 \\ 
  1979 & 0.7 & 1.2 & 1.7 \\ 
  1980 & 0.7 & 1.2 & 1.9 \\ 
  1981 & 0.7 & 1.2 & 1.9 \\ 
  1982 & 0.7 & 1.2 & 1.9 \\ 
  1983 & 0.7 & 1.2 & 2.1 \\ 
  1984 & 0.7 & 1.2 & 1.9 \\ 
  1985 & 0.7 & 1.2 & 2.1 \\ 
  1986 & 0.7 & 1.2 & 1.9 \\ 
  1987 & 0.7 & 1.2 & 1.9 \\ 
  1988 & 0.7 & 1.2 & 1.9 \\ 
  1989 & 0.7 & 1.2 & 2.0 \\ 
  1990 & 0.7 & 1.2 & 1.9 \\ 
  1991 & 0.7 & 1.2 & 2.0 \\ 
  1992 & 0.7 & 1.2 & 1.9 \\ 
  1993 & 0.7 & 1.2 & 2.0 \\ 
  1994 & 0.7 & 1.2 & 1.9 \\ 
  1995 & 0.7 & 1.2 & 2.0 \\ 
  1996 & 0.7 & 1.2 & 2.0 \\ 
  1997 & 0.7 & 1.2 & 2.1 \\ 
  1998 & 0.7 & 1.2 & 2.0 \\ 
  1999 & 0.7 & 1.2 & 1.9 \\ 
  2000 & 0.7 & 1.2 & 1.9 \\ 
  2001 & 0.7 & 1.2 & 1.9 \\ 
  2002 & 0.7 & 1.2 & 1.9 \\ 
  2003 & 0.7 & 1.2 & 1.9 \\ 
  2004 & 0.7 & 1.2 & 1.9 \\ 
  2005 & 0.7 & 1.2 & 1.9 \\ 
  2006 & 0.7 & 1.2 & 1.9 \\ 
  2007 & 0.7 & 1.2 & 1.9 \\ 
  2008 & 0.7 & 1.2 & 1.9 \\ 
  2009 & 0.7 & 1.2 & 1.9 \\ 
  2010 & 0.7 & 1.2 & 1.8 \\ 
  2011 & 0.7 & 1.2 & 1.8 \\ 
  2012 & 0.7 & 1.2 & 1.8 \\ 
  2013 & 0.7 & 1.2 & 1.9 \\ 
  2014 & 0.7 & 1.2 & 1.9 \\ 
  2015 & 0.7 & 1.2 & 1.9 \\ 
  2016 & 0.7 & 1.2 & 1.9 \\ 
  2017 & 0.7 & 1.2 & 1.9 \\ 
  2018 & 0.7 & 1.2 & 1.9 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Observed and input sample sizes for observer data from the directed pot fishery, the NMFS trawl survey, and the ADF\&G pot survey.} 
\label{tab:effn}
\begin{tabular}{lccccccc}
  \hline
  & \multicolumn{3}{c}{Number measured} & \multicolumn{3}{c}{Input sample sizes} \\
  \cline{2-4}\cline{6-8}
  Year & Observer pot & NMFS trawl & ADF\&G pot & & Observer pot & NMFS trawl & ADF\&G pot \\ 
  \hline
  1978 &              & 157        &          & &              & 50         & \\
  1979 &              & 178        &          & &              & 50         & \\
  1980 &              & 185        &          & &              & 50         & \\
  1981 &              & 140        &          & &              & 50         & \\
  1982 &              & 271        &          & &              & 50         & \\
  1983 &              & 231        &          & &              & 50         & \\
  1984 &              & 105        &          & &              & 50         & \\
  1985 &              &  93        &          & &              & 46.5       & \\
  1986 &              &  46        &          & &              & 23         & \\
  1987 &              &  71        &          & &              & 35.5       & \\
  1988 &              &  81        &          & &              & 40.5       & \\
  1989 &              & 208        &          & &              & 50         & \\
  1990 &  150         & 170        &          & & 15           & 50         & \\
  1991 &  3393        & 197        &          & & 25           & 50         & \\
  1992 &  1606        & 220        &          & & 25           & 50         & \\
  1993 &  2241        & 324        &          & & 25           & 50         & \\
  1994 &  4735        & 211        &          & & 25           & 50         & \\
  1995 &  663         & 178        &  4624    & & 25           & 50         & 100 \\
  1996 &  489         & 285        &          & & 25           & 50         & \\
  1997 &  3195        & 296        &          & & 25           & 50         & \\
  1998 &  1323        & 243        &  4812    & & 25           & 50         & 100 \\
  1999 &              &  52        &          & &              & 26         & \\
  2000 &              &  61        &          & &              & 30.5       & \\
  2001 &              &  91        &  3255    & &              & 45.5       & 100 \\
  2002 &              &  38        &          & &              & 19         & \\
  2003 &              &  65        &          & &              & 32.5       & \\
  2004 &              &  48        &  640     & &              & 24         & 100 \\
  2005 &              &  42        &          & &              & 21         & \\
  2006 &              & 126        &          & &              & 50         & \\
  2007 &              & 250        &  3319    & &              & 50         & 100 \\
  2008 &              & 167        &          & &              & 50         & \\
  2009 &  19802       & 251        &          & & 50           & 50         & \\
  2010 &  45466       & 388        &  3920    & & 50           & 50         & 100 \\
  2011 &  58667       & 318        &          & & 50           & 50         & \\
  2012 &  57282       & 193        &          & & 50           & 50         & \\
  2013 &              &  74        &  2167    & &              & 37         & 100 \\
  2014 &  9906        & 181        &          & & 50           & 50         & \\
  2015 &  3248        & 153        &  1077    & & 50           & 50         & 100 \\
  2016 &              & 108        &   777    & &              & 50         & 100 \\
  2017 &              & 42         &   643    & &              & 21         & 100 \\
  2018 &              & 62         &   286    & &              & 31         & 100 \\
  \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Model parameter estimates, selected derived quantities, and their standard deviations (SD) for the reference model.} 
\label{tab:est_pars_ref}
\begin{tabular}{lrr}
  \hline
Parameter & Estimate & SD \\ 
  \hline
Natural mortality deviation in 1998/99 ($\delta^M_{1998})$ & 1.622 & 0.127 \\ 
  $\log (\bar{R})$ & 13.915 & 0.060 \\ 
  $\log (n^0_1)$ & 14.932 & 0.171 \\ 
  $\log (n^0_2)$ & 14.551 & 0.202 \\ 
  $\log (n^0_3)$ & 14.366 & 0.206 \\ 
  $q_{pot}$ & 3.535 & 0.265 \\ 
  $\log (\bar{F}^\text{df})$ & -2.166 & 0.055 \\ 
  $\log (\bar{F}^\text{tb})$ & -9.330 & 0.081 \\ 
  $\log (\bar{F}^\text{fb})$ & -8.245 & 0.081 \\ 
  log Stage-1 directed pot selectivity 1978-2008 & -0.638 & 0.173 \\ 
  log Stage-2 directed pot selectivity 1978-2008 & -0.321 & 0.126 \\ 
  log Stage-1 directed pot selectivity 2009-2017 & -0.000 & 0.002 \\ 
  log Stage-2 directed pot selectivity 2009-2017 & -0.000 & 0.001 \\ 
  log Stage-1 NMFS trawl selectivity & -0.258 & 0.064 \\ 
  log Stage-2 NMFS trawl selectivity & -0.000 & 0.002 \\ 
  log Stage-1 ADF\&G pot selectivity & -0.792 & 0.124 \\ 
  log Stage-2 ADF\&G pot selectivity & -0.003 & 0.024 \\ 
  $F_\text{OFL}$ & 0.043 & 0.007 \\ 
  OFL & 38.464 & 10.360 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Model parameter estimates, selected derived quantities, and their standard deviations (SD) for the VAST model.} 
\label{tab:est_pars_vast}
\begin{tabular}{lrr}
  \hline
Parameter & Estimate & SD \\ 
  \hline
Natural mortality deviation in 1998/99 ($\delta^M_{1998})$ & 1.708 & 0.107 \\ 
  $\log (\bar{R})$ & 14.118 & 0.055 \\ 
  $\log (n^0_1)$ & 14.952 & 0.167 \\ 
  $\log (n^0_2)$ & 14.558 & 0.191 \\ 
  $\log (n^0_3)$ & 14.369 & 0.198 \\ 
  $q_{pot}$ & 2.483 & 0.155 \\ 
  $\log (\bar{F}^\text{df})$ & -2.280 & 0.044 \\ 
  $\log (\bar{F}^\text{tb})$ & -9.628 & 0.074 \\ 
  $\log (\bar{F}^\text{fb})$ & -8.556 & 0.074 \\ 
  log Stage-1 directed pot selectivity 1978-2008 & -0.750 & 0.171 \\ 
  log Stage-2 directed pot selectivity 1978-2008 & -0.356 & 0.123 \\ 
  log Stage-1 directed pot selectivity 2009-2017 & -0.001 & 0.101 \\ 
  log Stage-2 directed pot selectivity 2009-2017 & -0.000 & 0.000 \\ 
  log Stage-1 NMFS trawl selectivity & -0.264 & 0.065 \\ 
  log Stage-2 NMFS trawl selectivity & -0.015 & 0.020 \\ 
  log Stage-1 ADF\&G pot selectivity & -0.582 & 0.116 \\ 
  log Stage-2 ADF\&G pot selectivity & -0.010 & 0.022 \\ 
  $F_\text{OFL}$ & 0.075 & 0.008 \\ 
  OFL & 117.590 & 22.383 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Model parameter estimates, selected derived quantities, and their standard deviations (SD) for the "Fit survey" model.} 
\label{tab:est_pars_fit_survey}
\begin{tabular}{lrr}
  \hline
Parameter & Estimate & SD \\ 
  \hline
Natural mortality deviation in 1998/99 ($\delta^M_{1998})$ & 2.014 & 0.072 \\ 
  $\log (\bar{R})$ & 14.544 & 0.048 \\ 
  $\log (n^0_1)$ & 15.358 & 0.199 \\ 
  $\log (n^0_2)$ & 15.184 & 0.208 \\ 
  $\log (n^0_3)$ & 14.989 & 0.207 \\ 
  $q_{pot}$ & 1.051 & 0.041 \\ 
  $\log (\bar{F}^\text{df})$ & -3.158 & 0.031 \\ 
  $\log (\bar{F}^\text{tb})$ & -10.364 & 0.066 \\ 
  $\log (\bar{F}^\text{fb})$ & -9.278 & 0.066 \\ 
  log Stage-1 directed pot selectivity 1978-2008 & -0.323 & 0.177 \\ 
  log Stage-2 directed pot selectivity 1978-2008 & -0.058 & 0.145 \\ 
  log Stage-1 directed pot selectivity 2009-2017 & -0.000 & 0.000 \\ 
  log Stage-2 directed pot selectivity 2009-2017 & -0.000 & 0.000 \\ 
  log Stage-1 NMFS trawl selectivity & -0.000 & 0.001 \\ 
  log Stage-2 NMFS trawl selectivity & -0.000 & 0.000 \\ 
  log Stage-1 ADF\&G pot selectivity & -0.000 & 0.000 \\ 
  log Stage-2 ADF\&G pot selectivity & -0.000 & 0.000 \\ 
  $F_\text{OFL}$ & 0.059 & 0.003 \\ 
  OFL & 191.950 & 19.291 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Comparisons of parameter estimates for the model scenarios.} 
\label{tab:est_pars_all}
\begin{tabular}{lrrr}
  \hline
Parameter & Ref & VAST & FitSurvey \\ 
  \hline
$\log (\bar{F}^\text{df})$ & -2.166 & -2.280 & -3.158 \\ 
  $\log (\bar{F}^\text{fb})$ & -8.245 & -8.556 & -9.278 \\ 
  $\log (\bar{F}^\text{tb})$ & -9.330 & -9.628 & -10.364 \\ 
  $\log (\bar{R})$ & 13.915 & 14.118 & 14.544 \\ 
  $\log (n^0_1)$ & 14.932 & 14.952 & 15.358 \\ 
  $\log (n^0_2)$ & 14.551 & 14.558 & 15.184 \\ 
  $\log (n^0_3)$ & 14.366 & 14.369 & 14.989 \\ 
  $F_\text{OFL}$ & 0.043 & 0.075 & 0.059 \\ 
  $q_{pot}$ & 3.535 & 2.483 & 1.051 \\ 
  log Stage-1 ADF\&G pot selectivity & -0.792 & -0.582 & -0.000 \\ 
  log Stage-1 directed pot selectivity 1978-2008 & -0.638 & -0.750 & -0.323 \\ 
  log Stage-1 directed pot selectivity 2009-2017 & -0.000 & -0.001 & -0.000 \\ 
  log Stage-1 NMFS trawl selectivity & -0.258 & -0.264 & -0.000 \\ 
  log Stage-2 ADF\&G pot selectivity & -0.003 & -0.010 & -0.000 \\ 
  log Stage-2 directed pot selectivity 1978-2008 & -0.321 & -0.356 & -0.058 \\ 
  log Stage-2 directed pot selectivity 2009-2017 & -0.000 & -0.000 & -0.000 \\ 
  log Stage-2 NMFS trawl selectivity & -0.000 & -0.015 & -0.000 \\ 
  Natural mortality deviation in 1998/99 ($\delta^M_{1998})$ & 1.622 & 1.708 & 2.014 \\ 
  OFL & 38.464 & 117.590 & 191.950 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Comparisons of data weights, Francis LF weights (i.e. the new weights that should be applied to the LFs), SDNR and MAR (standard deviation of normalized residuals and median absolute residual) values for the model scenarios.} 
\label{tab:data_weighting}
\begin{tabular}{lrrr}
  \hline
Component & Reference & VAST & Fit surveys \\ 
  \hline
NMFS trawl survey weight & 1.00 & 1.00 & 2.00 \\ 
  ADF\&G pot survey weight & 1.00 & 1.00 & 2.00 \\ 
  Directed pot LF weight & 1.00 & 1.00 & 1.00 \\ 
  NMFS trawl survey LF weight & 1.00 & 1.00 & 1.00 \\ 
  ADF\&G pot survey LF weight & 1.00 & 1.00 & 1.00 \\ 
   \hline
Fancis weight for directed pot LF & 1.47 & 1.43 & 1.15 \\ 
  Francis weight for NMFS trawl survey LF & 0.42 & 0.38 & 0.30 \\ 
  Francis weight for ADF\&G pot survey LF & 1.01 & 0.88 & 0.18 \\ 
   \hline
SDNR NMFS trawl survey & 1.66 & 1.97 & 2.66 \\ 
  SDNR ADF\&G pot survey & 4.51 & 4.82 & 7.83 \\ 
  SDNR directed pot LF & 0.90 & 0.93 & 1.19 \\ 
  SDNR NMFS trawl survey LF & 1.35 & 1.44 & 1.93 \\ 
  SDNR ADF\&G pot survey LF & 1.02 & 1.08 & 2.35 \\ 
   \hline
MAR NMFS trawl survey & 1.21 & 1.10 & 1.99 \\ 
  MAR ADF\&G pot survey & 2.81 & 2.74 & 4.75 \\ 
  MAR directed pot LF & 0.70 & 0.64 & 0.68 \\ 
  MAR NMFS trawl survey LF & 0.54 & 0.67 & 1.06 \\ 
  MAR ADF\&G pot survey LF & 0.70 & 0.97 & 2.03 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Comparisons of negative log-likelihood values for the selected model scenarios. It is important to note that comparisons among models may be limited since the assumed variances are modified (e.g., {\bf Fit surveys} model).} 
\label{tab:likelihood_components}
\begin{tabular}{lrrr}
  \hline
Component & Reference & VAST & Fit surveys \\ 
  \hline
Pot Retained Catch & -73.35 & -72.70 & -68.87 \\ 
  Pot Discarded Catch & 33.61 & 16.32 & 112.35 \\ 
  Trawl bycatch Discarded Catch & -7.43 & -7.36 & -7.43 \\ 
  Fixed bycatch Discarded Catch & -7.41 & -7.33 & -7.40 \\ 
  NMFS Trawl Survey & 12.32 & 9.05 & 80.05 \\ 
  ADF\&G Pot Survey CPUE & 92.53 & 110.62 & 317.70 \\ 
  Directed Pot LF & -5.07 & -3.89 & 24.31 \\ 
  NMFS Trawl LF & 26.33 & 40.25 & 121.33 \\ 
  ADF\&G Pot LF & -2.78 & -0.48 & 47.58 \\ 
  Recruitment deviations & 57.16 & 55.13 & 60.17 \\ 
  F penalty & 9.66 & 9.66 & 9.66 \\ 
  M penalty & 6.47 & 6.47 & 6.48 \\ 
  Prior & 12.66 & 12.66 & 13.61 \\ 
  Total & 154.70 & 168.40 & 709.54 \\ 
  Total estimated parameters & 142.00 & 142.00 & 142.00 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Population abundances ($\boldsymbol{n}$) by crab stage in numbers of crab at the time of the survey and mature male biomass (MMB) in tons on 15 February for the {\bf model configuration used in 2017}.} 
\label{tab:pop_abundance_2017}
\begin{tabular}{rrrrrr}
  \hline
Year & $n_1$ & $n_2$ & $n_3$ & MMB & CV MMB \\ 
  \hline
1978 & 3023781 & 2049075 & 1702338 & 4768 & 0.170 \\ 
  1979 & 4243623 & 2395504 & 2377772 & 6646 & 0.119 \\ 
  1980 & 3602053 & 3203035 & 3555172 & 10372 & 0.083 \\ 
  1981 & 1357467 & 3105955 & 4901100 & 10757 & 0.065 \\ 
  1982 & 1475563 & 1798956 & 4913154 & 7752 & 0.076 \\ 
  1983 & 773712 & 1433358 & 3526836 & 4848 & 0.102 \\ 
  1984 & 665874 & 913703 & 2117136 & 3416 & 0.121 \\ 
  1985 & 941768 & 680553 & 1585505 & 3136 & 0.135 \\ 
  1986 & 1400419 & 760107 & 1389117 & 3070 & 0.129 \\ 
  1987 & 1353705 & 1046932 & 1491960 & 3577 & 0.118 \\ 
  1988 & 1238729 & 1115338 & 1711452 & 3874 & 0.113 \\ 
  1989 & 2797116 & 1072696 & 1873823 & 4383 & 0.108 \\ 
  1990 & 1754660 & 1943624 & 2164515 & 5438 & 0.088 \\ 
  1991 & 1821352 & 1639841 & 2626200 & 5454 & 0.089 \\ 
  1992 & 1949025 & 1576546 & 2579597 & 5600 & 0.081 \\ 
  1993 & 2189645 & 1628140 & 2673947 & 5817 & 0.075 \\ 
  1994 & 1535697 & 1782114 & 2728665 & 5547 & 0.072 \\ 
  1995 & 1805851 & 1461927 & 2624902 & 5457 & 0.074 \\ 
  1996 & 1607645 & 1509341 & 2540504 & 5289 & 0.077 \\ 
  1997 & 905249 & 1412491 & 2479049 & 4703 & 0.096 \\ 
  1998 & 678831 & 981495 & 2076444 & 3286 & 0.108 \\ 
  1999 & 400143 & 330674 & 800288 & 1868 & 0.103 \\ 
  2000 & 443486 & 336548 & 873018 & 2011 & 0.088 \\ 
  2001 & 410226 & 363174 & 941043 & 2168 & 0.081 \\ 
  2002 & 145725 & 353078 & 1008033 & 2282 & 0.077 \\ 
  2003 & 333277 & 199574 & 1033616 & 2156 & 0.078 \\ 
  2004 & 235025 & 255197 & 995281 & 2148 & 0.078 \\ 
  2005 & 512012 & 217920 & 982315 & 2082 & 0.078 \\ 
  2006 & 768757 & 362826 & 979052 & 2237 & 0.081 \\ 
  2007 & 525023 & 556119 & 1073083 & 2602 & 0.083 \\ 
  2008 & 942465 & 476388 & 1211965 & 2800 & 0.070 \\ 
  2009 & 740685 & 692255 & 1341278 & 2896 & 0.069 \\ 
  2010 & 721575 & 649030 & 1447778 & 2574 & 0.075 \\ 
  2011 & 589723 & 623688 & 1340120 & 2146 & 0.094 \\ 
  2012 & 338049 & 541129 & 1101914 & 1752 & 0.121 \\ 
  2013 & 443928 & 370924 & 889881 & 1986 & 0.113 \\ 
  2014 & 349998 & 374790 & 972470 & 1979 & 0.118 \\ 
  2015 & 342929 & 322745 & 974238 & 1969 & 0.119 \\ 
  2016 & 468871 & 301480 & 987479 & 2084 & 0.119 \\ 
  2017 & 289905 & 365759 & 1020732 & 2215 & 0.121 \\ 
  2018 & 667955 & 285723 & 1064712 & 2207 & 0.124 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Population abundances ($\boldsymbol{n}$) by crab stage in numbers of crab at the time of the survey (1 July, season 1) and mature male biomass (MMB) in tons on 15 February for the reference model.} 
\label{tab:pop_abundance_base}
\begin{tabular}{rrrrrr}
  \hline
Year & $n_1$ & $n_2$ & $n_3$ & MMB & CV MMB \\ 
  \hline
1978 & 3055234 & 2086108 & 1734507 & 4866 & 0.168 \\ 
  1979 & 4257442 & 2425626 & 2423713 & 6757 & 0.118 \\ 
  1980 & 3598122 & 3220853 & 3609886 & 10496 & 0.083 \\ 
  1981 & 1393219 & 3109621 & 4955215 & 10850 & 0.064 \\ 
  1982 & 1478218 & 1820475 & 4958541 & 7843 & 0.075 \\ 
  1983 & 780696 & 1441989 & 3567176 & 4896 & 0.102 \\ 
  1984 & 662579 & 920526 & 2138027 & 3447 & 0.121 \\ 
  1985 & 941431 & 680941 & 1599201 & 3151 & 0.136 \\ 
  1986 & 1398365 & 760044 & 1395461 & 3077 & 0.131 \\ 
  1987 & 1375810 & 1045746 & 1494783 & 3575 & 0.120 \\ 
  1988 & 1249940 & 1127499 & 1712417 & 3883 & 0.115 \\ 
  1989 & 2871869 & 1083089 & 1878810 & 4399 & 0.110 \\ 
  1990 & 1772504 & 1989518 & 2178735 & 5506 & 0.088 \\ 
  1991 & 1855773 & 1665166 & 2658312 & 5523 & 0.088 \\ 
  1992 & 1967394 & 1604535 & 2613415 & 5680 & 0.080 \\ 
  1993 & 2233267 & 1647885 & 2711451 & 5893 & 0.074 \\ 
  1994 & 1552353 & 1813449 & 2765581 & 5626 & 0.070 \\ 
  1995 & 1772244 & 1481762 & 2661725 & 5530 & 0.074 \\ 
  1996 & 1640690 & 1496832 & 2568650 & 5305 & 0.077 \\ 
  1997 & 911676 & 1427124 & 2489066 & 4708 & 0.096 \\ 
  1998 & 664027 & 989997 & 2079572 & 3217 & 0.109 \\ 
  1999 & 386325 & 338975 & 804976 & 1886 & 0.102 \\ 
  2000 & 444883 & 331450 & 879792 & 2018 & 0.086 \\ 
  2001 & 409179 & 362279 & 944263 & 2173 & 0.079 \\ 
  2002 & 143080 & 352188 & 1010174 & 2285 & 0.075 \\ 
  2003 & 337248 & 197779 & 1034707 & 2156 & 0.076 \\ 
  2004 & 214735 & 256857 & 995667 & 2151 & 0.076 \\ 
  2005 & 524236 & 206948 & 981535 & 2068 & 0.076 \\ 
  2006 & 772777 & 366135 & 974037 & 2232 & 0.076 \\ 
  2007 & 386826 & 559490 & 1070944 & 2601 & 0.075 \\ 
  2008 & 886023 & 399837 & 1198460 & 2689 & 0.064 \\ 
  2009 & 566036 & 634887 & 1285999 & 2731 & 0.058 \\ 
  2010 & 513068 & 530956 & 1352570 & 2266 & 0.067 \\ 
  2011 & 391462 & 466386 & 1169874 & 1652 & 0.088 \\ 
  2012 & 206041 & 376581 & 842952 & 1112 & 0.133 \\ 
  2013 & 268807 & 241573 & 562999 & 1264 & 0.123 \\ 
  2014 & 171187 & 232582 & 617641 & 1200 & 0.133 \\ 
  2015 & 185938 & 174176 & 586573 & 1144 & 0.135 \\ 
  2016 & 304931 & 163212 & 573050 & 1197 & 0.132 \\ 
  2017 & 189110 & 227051 & 589688 & 1294 & 0.128 \\ 
  2018 & 135140 & 182181 & 623814 & 1309 & 0.128 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Population abundances ($\boldsymbol{n}$) by crab stage in numbers of crab at the time of the survey (1 July, season 1) and mature male biomass (MMB) in tons on 15 February for the model that uses the VAST BTS index.} 
\label{tab:pop_abundance_vast}
\begin{tabular}{rrrrrr}
  \hline
Year & $n_1$ & $n_2$ & $n_3$ & MMB & CV MMB \\ 
  \hline
1978 & 3115589 & 2101690 & 1739151 & 4886 & 0.152 \\ 
  1979 & 4245149 & 2465063 & 2438549 & 6827 & 0.102 \\ 
  1980 & 3495583 & 3226925 & 3640655 & 10562 & 0.071 \\ 
  1981 & 1400316 & 3053397 & 4974270 & 10826 & 0.055 \\ 
  1982 & 1403527 & 1805901 & 4948868 & 7803 & 0.065 \\ 
  1983 & 768712 & 1394751 & 3542238 & 4788 & 0.088 \\ 
  1984 & 644044 & 898093 & 2091002 & 3323 & 0.105 \\ 
  1985 & 884197 & 662990 & 1541757 & 3010 & 0.117 \\ 
  1986 & 1156489 & 721595 & 1332084 & 2913 & 0.114 \\ 
  1987 & 1361692 & 895651 & 1399045 & 3225 & 0.111 \\ 
  1988 & 1268964 & 1069802 & 1556458 & 3531 & 0.109 \\ 
  1989 & 2952458 & 1074794 & 1720430 & 4081 & 0.107 \\ 
  1990 & 1926237 & 2032541 & 2049636 & 5323 & 0.081 \\ 
  1991 & 2010839 & 1766715 & 2588514 & 5504 & 0.081 \\ 
  1992 & 2271322 & 1726149 & 2620661 & 5837 & 0.074 \\ 
  1993 & 2524916 & 1860671 & 2810045 & 6329 & 0.068 \\ 
  1994 & 1797600 & 2049489 & 2984629 & 6296 & 0.064 \\ 
  1995 & 1981816 & 1699175 & 2984717 & 6407 & 0.064 \\ 
  1996 & 2171903 & 1687825 & 2969005 & 6282 & 0.066 \\ 
  1997 & 1287692 & 1792037 & 2968533 & 6095 & 0.076 \\ 
  1998 & 861162 & 1324336 & 2700596 & 4499 & 0.079 \\ 
  1999 & 482750 & 410980 & 1048751 & 2423 & 0.094 \\ 
  2000 & 569663 & 410052 & 1128931 & 2573 & 0.076 \\ 
  2001 & 518006 & 459164 & 1203922 & 2768 & 0.068 \\ 
  2002 & 158654 & 446063 & 1286310 & 2907 & 0.063 \\ 
  2003 & 467661 & 237700 & 1314172 & 2724 & 0.064 \\ 
  2004 & 227302 & 344128 & 1261691 & 2747 & 0.064 \\ 
  2005 & 884111 & 242979 & 1248943 & 2608 & 0.064 \\ 
  2006 & 1038396 & 582426 & 1249969 & 2992 & 0.066 \\ 
  2007 & 563303 & 781930 & 1435907 & 3533 & 0.062 \\ 
  2008 & 1235648 & 573282 & 1631919 & 3695 & 0.054 \\ 
  2009 & 855319 & 890854 & 1768939 & 3850 & 0.055 \\ 
  2010 & 713124 & 779941 & 1912604 & 3463 & 0.065 \\ 
  2011 & 551612 & 662414 & 1782194 & 2888 & 0.080 \\ 
  2012 & 364563 & 532437 & 1464980 & 2306 & 0.107 \\ 
  2013 & 412392 & 383213 & 1169945 & 2500 & 0.105 \\ 
  2014 & 336213 & 361024 & 1209753 & 2374 & 0.109 \\ 
  2015 & 301365 & 310420 & 1161469 & 2274 & 0.113 \\ 
  2016 & 379614 & 273872 & 1133038 & 2315 & 0.105 \\ 
  2017 & 264416 & 306139 & 1120348 & 2326 & 0.100 \\ 
  2018 & 189768 & 251211 & 1114103 & 2258 & 0.099 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Population abundances ($\boldsymbol{n}$) by crab) stage in numbers of crab at the time of the survey (1 July, season 1) and mature male biomass (MMB) in tons on 15 February for the {\bf fit surveys} model.} 
\label{tab:pop_abundance_force}
\begin{tabular}{rrrrr}
  \hline
Year & $n_1$ & $n_2$ & $n_3$ & MMB \\ 
  \hline
1978 & 4677797 & 3931215 & 3233480 & 9847.621 \\ 
  1979 & 5679580 & 3957870 & 4761422 & 12429.887 \\ 
  1980 & 4358175 & 4535723 & 6470984 & 17440.543 \\ 
  1981 & 1550583 & 3976517 & 8080689 & 17667.453 \\ 
  1982 & 1771589 & 2196807 & 8020714 & 14103.998 \\ 
  1983 & 1110443 & 1733193 & 6327543 & 10774.815 \\ 
  1984 & 927307 & 1204239 & 4596325 & 8346.268 \\ 
  1985 & 1186602 & 925224 & 3815633 & 8001.730 \\ 
  1986 & 1650986 & 980157 & 3392512 & 7101.786 \\ 
  1987 & 2226342 & 1262092 & 3297483 & 7230.783 \\ 
  1988 & 2382673 & 1682172 & 3408749 & 7607.552 \\ 
  1989 & 6435258 & 1910040 & 3683373 & 8854.045 \\ 
  1990 & 3174076 & 4286999 & 4442908 & 12246.472 \\ 
  1991 & 3423526 & 3221651 & 5841869 & 13342.566 \\ 
  1992 & 3587881 & 3010182 & 6204095 & 14023.149 \\ 
  1993 & 4268479 & 3033588 & 6573651 & 15008.615 \\ 
  1994 & 3342537 & 3428049 & 6882154 & 15134.784 \\ 
  1995 & 2525485 & 3032932 & 7080947 & 15892.025 \\ 
  1996 & 4861574 & 2438146 & 7111327 & 15060.520 \\ 
  1997 & 3292361 & 3567980 & 7064527 & 16409.957 \\ 
  1998 & 1540701 & 3050706 & 7203276 & 12728.373 \\ 
  1999 & 1039257 & 585643 & 2182516 & 4739.948 \\ 
  2000 & 1819898 & 783942 & 2217206 & 5029.007 \\ 
  2001 & 1681408 & 1292948 & 2420978 & 5984.209 \\ 
  2002 & 358473 & 1382745 & 2834538 & 6858.585 \\ 
  2003 & 472151 & 661228 & 3098790 & 6537.758 \\ 
  2004 & 212213 & 486929 & 2966306 & 6094.289 \\ 
  2005 & 1357220 & 281699 & 2743319 & 5445.624 \\ 
  2006 & 2380434 & 863978 & 2562915 & 5763.848 \\ 
  2007 & 1840517 & 1637276 & 2802824 & 7056.285 \\ 
  2008 & 1319399 & 1580307 & 3328015 & 8001.663 \\ 
  2009 & 1402575 & 1271943 & 3701339 & 7635.693 \\ 
  2010 & 1274346 & 1217025 & 3770188 & 7008.231 \\ 
  2011 & 743295 & 1125918 & 3604064 & 6443.673 \\ 
  2012 & 503022 & 794749 & 3232990 & 5529.164 \\ 
  2013 & 527615 & 548703 & 2786488 & 5561.484 \\ 
  2014 & 546449 & 481256 & 2654458 & 5030.626 \\ 
  2015 & 450669 & 469626 & 2448183 & 4644.903 \\ 
  2016 & 587170 & 411375 & 2302053 & 4548.767 \\ 
  2017 & 248210 & 469551 & 2185962 & 4402.360 \\ 
  2018 & 112647 & 296202 & 2085007 & 4038.448 \\ 
   \hline
\end{tabular}
\end{table}

\newpage\clearpage

# Figures
\newpage\clearpage

![Distribution of blue king crab (*Paralithodes platypus*) in the Gulf of Alaska, Bering Sea, and Aleutian Islands
waters (shown in blue).\label{fig:distribution}](figure/Fig1.png)

![King crab Registration Area Q (Bering Sea).\label{fig:registration_area}](figure/Fig2.png)

<!--Data extent  -->

![Data extent for the SMBKC assessment (with the 2017 Pot survey included).\label{fig:data_extent}](figure/data_extent-1.png)

<!--  stations -->

![Trawl and pot-survey stations used in the SMBKC stock assessment.\label{fig:stations}](figure/Fig3.png)

<!--  -->

![Catches (in numbers) of male blue king crab $/ge$ 90 mm CL from the 2012-2017 NMFS trawl-survey at the 56 stations used
to assess the SMBKC stock. Note that the area north of St. Matthew Island, which often shows large catches of crab
at station R-24 is not covered in the ADF&G pot-survey data used in the
assessment.\label{fig:catch181}](../figure/CrabN_Station.png)

<!-- Survey NMFS -->

![Fits to NMFS area-swept trawl estimates of total ($/ge$ 90mm) male survey biomass with the addition of new data (the Reference Model is with all new data while 2018 BTS is just with the 2018 NMFS trawl survey data added). Error bars are plus and minus 2 standard deviations.\label{fig:surv1}](figure/surv1-1.png)

<!--  Survey pot-->

![Comparisons of fits to CPUE from the ADF&G pot surveys with the addition of new data (note that for the 2018 BTS model the prediction for the 2018 pot survey year is ommitted from plotting routine). Error bars are plus and minus 2 standard deviations.\label{fig:surv2}](figure/surv2-1.png)

<!--  -->


![Sensitivity of new data in 2018 on estimated recruitment ; 1978-2018. \label{fig:rec1}](figure/rec1-1.png)

<!--  -->

![Sensitivity of new data in 2018 on estimated mature male biomass (MMB); 1978-2018. \label{fig:ssb1}](figure/ssb1-1.png)

\clearpage
<!--  -->

![Comparisons of fits to area-swept estimates of total (>90mm) male survey biomass (t) for the standard design-based estimate and for estimates derived from the VAST spatio-temporal model of Thorson and Barnett (2017). Error bars are plus and minus 2 standard deviations.\label{fig:surv3}](figure/surv3-1.png)

<!--  -->

![Sensitivity of new data in 2018 on estimated mature male biomass (MMB); 1978-2018 comparing the reference model with that fitted to the VAST BTS estimates. \label{fig:ssb2}](figure/ssb2-1.png)

\clearpage
<!--  -->

![Comparisons of the estimated stage-1 and stage-2 selectivities for the different model scenarios (the stage-3 selectivities are all fixed at 1). Estimated selectivities are shown for the directed pot fishery, the trawl bycatch fishery, the fixed bycatch fishery, the NMFS trawl survey, and the ADF&G pot survey. Two selectivity periods are estimated in the directed pot fishery, from 1978-2008 and 2009-2017.\label{fig:selectivity}](figure/selectivity-1.png)

\clearpage
<!--  -->

![Estimated recruitment 1979-2017 comparing model alternatives. The solid horizontal lines in the background represent the estimate of the average recruitment parameter ($\bar{R}$) in each model scenario.\label{fig:recruitment}](figure/recruitment-1.png)

<!--  -->

![Comparisons of estimated mature male biomass (MMB) time series on 15 February during 1978-2018 for each of the model scenarios.\label{fig:mmb}](figure/mature_male_biomass-1.png)

\clearpage
<!--  -->

![Time-varying natural mortality ($M_t$). Estimated pulse period occurs in 1998/99 (i.e. $M_{1998}$). \label{fig:M_t}](figure/natural_mortality-1.png)

\clearpage
<!--  -->

![Comparisons of area-swept estimates of total (90+ mm CL) male survey biomass (tons) and model predictions for the model scenarios. The error bars are plus and minus 2 standard deviations.\label{fig:trawl_survey_biomass}](figure/trawl_survey_biomass-1.png)

<!--  -->

![Comparisons of total (90+ mm CL) male pot survey CPUEs and model predictions for the model scenarios. The error bars are plus and minus 2 standard deviations.\label{fig:pot_survey_cpue}](figure/pot_survey_cpue-1.png)

\clearpage
<!--  -->

![Standardized residuals for area-swept estimates of total male survey biomass for the model scenarios. \label{fig:bts_resid_nmfs}](figure/bts_resid_nmfs-1.png)

<!--  -->

![Standardized residuals for total male pot survey CPUEs for each of the Gmacs model scenarios.\label{fig:bts_resid_adfg}](figure/bts_resid_adfg-1.png)

\clearpage

![Observed and model estimated size-frequencies of SMBKC by year retained in the directed pot fishery for the model scenarios. \label{fig:sc_pot}](figure/sc_pot-1.png)

<!--  -->

![Observed and model estimated size-frequencies of discarded male SMBKC by year in the NMFS trawl survey for the model scenarios. \label{fig:sc_pot_discarded}](figure/sc_pot_discarded-1.png)

\clearpage

![Observed and model estimated size-frequencies of discarded SMBKC by year in the ADF&G pot survey for the model scenarios.\label{fig:sc_trawl_discarded}](figure/sc_trawl_discarded-1.png)

<!--  -->

![Bubble plots of residuals by stage and year for the directed pot fishery size composition data for SMBKC in the reference model.\label{fig:sc_res_ref}](figure/sc_pot_res_selex-1.png)

\clearpage

![Bubble plots of residuals by stage and year for the ADF&G pot survey size composition data for SMBKC in the **fit surveys** model.\label{fig:sc_res_fit_survey}](figure/sc_trawl_discarded_res-1.png)

<!-- \clearpage -->

![Comparison of observed and model predicted retained catch and bycatches in each of the Gmacs models. Note that difference in units between each of the panels, some panels are expressed in numbers of crab, some as biomass (tons).\label{fig:fit_to_catch}](figure/fit_to_catch-1.png)

\clearpage

![Comparisons of mature male biomass relative to the dynamic $B_0$ value, (15 February, 1978-2018) for  each of the model scenarios.\label{fig:dynB0}](figure/Dynamic_Bzero-1.png)

\clearpage

\newpage\clearpage

# Appendix A: SMBKC Model Description

## 1. Introduction

The Gmacs model has been specified to account only for male crab $\ge$ 90 mm in carapace length (CL). These are
partitioned into three stages (size- classes) determined by CL measurements of (1) 90-104 mm, (2) 105-119 mm, and (3)
120+ mm. For management of the St. Matthew Island blue king crab (SMBKC) fishery, 120 mm CL is used as the proxy value
for the legal measurement of 5.5 inch carapace width (CW), whereas 105 mm CL is the management proxy for mature-male
size (state regulation *5 AAC 34.917 (d)*). Accordingly, within the model only stage-3 crab are retained in the directed fishery, and
stage-2 and stage-3 crab together comprise the collection of mature males. Some justification for the 105 mm value is
presented in Pengilly and Schmidt (1995), who used it in developing the current regulatory SMBKC harvest strategy. The
term "recruit" here designates recruits to the model, i.e., annual new stage-1 crab, rather than recruits to the
fishery. The following description of model structure reflects the Gmacs base model configuration.

## 2. Model Population Dynamics

Within the model, the beginning of the crab year is assumed contemporaneous
with the NMFS trawl survey, nominally assigned a date of 1 July. Although the
timing of the fishery is different each year, MMB is estimated at 15 February,
which is the reference date for calculation of federal management biomass
quantities. To accommodate this, each model year is split into 5 
seasons ($t$) and a proportion of the natural mortality
($\tau_t$), scaled relative to the portions of the year, 
is applied in each of these seasons where $\sum_{t=1}^{t=5} \tau_t = 1$. 
Each model year consists of the following processes with time-breaks denoted here by "Seasons." 
However, it is important to note that actual seasons are survey-to-fishery, fishery-to Feb 15, and Feb 15 to July 1.
The following breakdown accounts for events and fishing mortality treatments:

\begin{enumerate}
    \item Season 1 (survey period)
    \begin{itemize}
        \item Beginning of the SMBKC fishing year (1 July)
        \item $\tau_1 = 0$
        \item Surveys
    \end{itemize}
    \item Season 2 (natural mortality until pulse fishery)
    \begin{itemize}
        \item $\tau_2$ ranges from 0.05 to 0.44 depending on the time of year the fishery begins each year (i.e., a higher value indicates the fishery begins later in the year; see Table \ref{tab:smbkc_fishery})
    \end{itemize}
    \item Season 3 (pulse fishery)
    \begin{itemize}
        \item $\tau_3 = 0$
        \item fishing mortality applied
    \end{itemize}
    \item Season 4 (natural mortality until spawning)
    \begin{itemize}
        \item $\tau_4 = 0.63 - \sum_{i=1}^{i=4} \tau_i$
        \item Calculate MMB (15 February)
    \end{itemize}
    \item Season 5 (natural mortality and somatic growth through to June 30th)
    \begin{itemize}
        \item $\tau_5 = 0.37$
        \item Growth and molting
        \item Recruitment (all to stage-1)
    \end{itemize}
\end{enumerate}
The proportion of natural mortality ($\tau_t$) applied during each season in the model is provided in Table \ref{tab:m_prop}. The beginning of the year (1 July) to the date that MMB is measured (15 February) is 63% of the year. Therefore 63% of the natural mortality must be applied before the MMB is calculated. Because the timing of the fishery is different each year, $\tau_2$ varies and thus $\tau_4$ varies also.

\begin{table}[ht]
\centering
\caption{Proportion of the natural mortality ($\tau_t$) that is applied during each season ($t$) in the model.} 
\label{tab:m_prop}
\begin{tabular}{rrrrrr}
  \hline
Year & Season 1 & Season 2 & Season 3 & Season 4 & Season 5 \\ 
  \hline
1978 & 0.00 & 0.07 & 0.00 & 0.56 & 0.37 \\ 
  1979 & 0.00 & 0.06 & 0.00 & 0.57 & 0.37 \\ 
  1980 & 0.00 & 0.07 & 0.00 & 0.56 & 0.37 \\ 
  1981 & 0.00 & 0.05 & 0.00 & 0.58 & 0.37 \\ 
  1982 & 0.00 & 0.07 & 0.00 & 0.56 & 0.37 \\ 
  1983 & 0.00 & 0.12 & 0.00 & 0.51 & 0.37 \\ 
  1984 & 0.00 & 0.10 & 0.00 & 0.53 & 0.37 \\ 
  1985 & 0.00 & 0.14 & 0.00 & 0.49 & 0.37 \\ 
  1986 & 0.00 & 0.14 & 0.00 & 0.49 & 0.37 \\ 
  1987 & 0.00 & 0.14 & 0.00 & 0.49 & 0.37 \\ 
  1988 & 0.00 & 0.14 & 0.00 & 0.49 & 0.37 \\ 
  1989 & 0.00 & 0.14 & 0.00 & 0.49 & 0.37 \\ 
  1990 & 0.00 & 0.14 & 0.00 & 0.49 & 0.37 \\ 
  1991 & 0.00 & 0.18 & 0.00 & 0.45 & 0.37 \\ 
  1992 & 0.00 & 0.14 & 0.00 & 0.49 & 0.37 \\ 
  1993 & 0.00 & 0.18 & 0.00 & 0.45 & 0.37 \\ 
  1994 & 0.00 & 0.18 & 0.00 & 0.45 & 0.37 \\ 
  1995 & 0.00 & 0.18 & 0.00 & 0.45 & 0.37 \\ 
  1996 & 0.00 & 0.18 & 0.00 & 0.45 & 0.37 \\ 
  1997 & 0.00 & 0.18 & 0.00 & 0.45 & 0.37 \\ 
  1998 & 0.00 & 0.18 & 0.00 & 0.45 & 0.37 \\ 
  1999 & 0.00 & 0.18 & 0.00 & 0.45 & 0.37 \\ 
  2000 & 0.00 & 0.18 & 0.00 & 0.45 & 0.37 \\ 
  2001 & 0.00 & 0.18 & 0.00 & 0.45 & 0.37 \\ 
  2002 & 0.00 & 0.18 & 0.00 & 0.45 & 0.37 \\ 
  2003 & 0.00 & 0.18 & 0.00 & 0.45 & 0.37 \\ 
  2004 & 0.00 & 0.18 & 0.00 & 0.45 & 0.37 \\ 
  2005 & 0.00 & 0.18 & 0.00 & 0.45 & 0.37 \\ 
  2006 & 0.00 & 0.18 & 0.00 & 0.45 & 0.37 \\ 
  2007 & 0.00 & 0.18 & 0.00 & 0.45 & 0.37 \\ 
  2008 & 0.00 & 0.18 & 0.00 & 0.45 & 0.37 \\ 
  2009 & 0.00 & 0.44 & 0.00 & 0.19 & 0.37 \\ 
  2010 & 0.00 & 0.44 & 0.00 & 0.19 & 0.37 \\ 
  2011 & 0.00 & 0.44 & 0.00 & 0.19 & 0.37 \\ 
  2012 & 0.00 & 0.44 & 0.00 & 0.19 & 0.37 \\ 
  2013 & 0.00 & 0.44 & 0.00 & 0.19 & 0.37 \\ 
  2014 & 0.00 & 0.44 & 0.00 & 0.19 & 0.37 \\ 
  2015 & 0.00 & 0.44 & 0.00 & 0.19 & 0.37 \\ 
  2016 & 0.00 & 0.44 & 0.00 & 0.19 & 0.37 \\ 
  2017 & 0.00 & 0.44 & 0.00 & 0.19 & 0.37 \\ 
  2018 & 0.00 & 0.44 & 0.00 & 0.19 & 0.37 \\ 
   \hline
\end{tabular}
\end{table}

With boldface lower-case letters indicating vector quantities we designate the vector of stage abundances during season $t$ and year $y$ as
\begin{equation}
    \boldsymbol{n}_{t,y} = n_{l,t,y} = \left[ n_{1,t,y}, n_{2,t,y}, n_{3,t,y} \right]^\top.
\end{equation}
The number of new crab, or recruits, of each stage entering the model each season $t$ and year $y$ is represented as the vector $\boldsymbol{r}_{t,y}$. The SMBKC formulation of Gmacs specifies recruitment to stage-1 only during season $t=5$, thus the recruitment size distribution is
\begin{equation}
    \phi_l = \left[ 1, 0, 0 \right]^\top,
\end{equation}
and the recruitment is
\begin{equation}
  \boldsymbol{r}_{t,y} = 
  \begin{cases}
    0 &\text{for} \quad t<5\\
    \bar{R} \phi_l \delta^R_y &\text{for} \quad t=5.
  \end{cases}
\end{equation}
where $\bar{R}$ is the average annual recruitment and $\delta^R_y$ are the recruitment deviations each year $y$
\begin{equation}
    \delta^R_y \sim \mathcal{N} \left( 0, \sigma_R^2 \right).
\end{equation}
Using boldface upper-case letters to indicate a matrix, we describe the size transition matrix $\boldsymbol{G}$ as
\begin{equation}
  \boldsymbol{G} = \left[ \begin{array}{ccc}
    1 - \pi_{12} - \pi_{13} & \pi_{12} & \pi_{13} \\
    0 & 1 - \pi_{23} & \pi_{23} \\
    0 & 0 & 1 \end{array} \right],
\end{equation}
with $\pi_{jk}$ equal to the proportion of stage-$j$ crab that molt and grow into stage-$k$ within a season or year. 

The natural mortality each season $t$ and year $y$ is
\begin{equation}
    M_{t,y} = \bar{M} \tau_t + \delta_y^M \text{ where } \delta_y^M \sim \mathcal{N} \left( 0, \sigma_M^2 \right)
\end{equation}
Fishing mortality by year $y$ and season $t$ is denoted $F_{t,y}$ and calculated as
\begin{equation}
    F_{t,y} = F_{t,y}^\text{df} + F_{t,y}^\text{tb} + F_{t,y}^\text{fb}
\end{equation}
where $F_{t,y}^\text{df}$ is the fishing mortality associated with the directed fishery, $F_{t,y}^\text{tb}$ is the fishing mortality associated with the trawl bycatch fishery, $F_{t,y}^\text{fb}$ is the fishing mortality associated with the fixed bycatch fishery. Each of these are derived as
\begin{align}
    F_{t,y}^\text{df} &= \bar{F}^\text{df} + \delta^\text{df}_{t,y} \quad \text{where} \quad \delta^\text{df}_{t,y} \sim \mathcal{N} \left( 0, \sigma^2_\text{df} \right), \notag\\
    F_{t,y}^\text{tb} &= \bar{F}^\text{tb} + \delta^\text{tb}_{t,y} \quad \text{where} \quad \delta^\text{df}_{t,y} \sim \mathcal{N} \left( 0, \sigma^2_\text{tb} \right), \notag\\
    F_{t,y}^\text{fb} &= \bar{F}^\text{fb} + \delta^\text{fb}_{t,y} \quad \text{where} \quad \delta^\text{df}_{t,y} \sim \mathcal{N} \left( 0, \sigma^2_\text{fb} \right),
\end{align}
where $\delta^\text{df}_{t,y}$, $\delta^\text{tb}_{t,y}$, and $\delta^\text{fb}_{t,y}$ are the fishing mortality deviations for each of the fisheries, each season $t$ during each year $y$, $\bar{F}^\text{df}$, $\bar{F}^\text{tb}$, and $\bar{F}^\text{fb}$ are the average fishing mortalities for each fishery. The total mortality $Z_{l,t,y}$ represents the combination of natural mortality $M_{t,y}$ and fishing mortality $F_{t,y}$ during season $t$ and year $y$
\begin{equation}
    \boldsymbol{Z}_{t,y} = Z_{l,t,y} = M_{t,y} + F_{t,y}.
\end{equation}
The survival matrix $\boldsymbol{S}_{t,y}$ during season $t$ and year $y$ is
\begin{equation}
  \boldsymbol{S}_{t,y} = \left[ \begin{array}{ccc}
    1-e^{-Z_{1,t,y}} & 0 & 0 \\
    0 & 1-e^{-Z_{2,t,y}} & 0 \\
    0 & 0 & 1-e^{-Z_{3,t,y}} \end{array} \right].
\end{equation}

The basic population dynamics underlying Gmacs can thus be described as
\begin{align}
    \boldsymbol{n}_{t+1,y} &= \boldsymbol{S}_{t,y} \boldsymbol{n}_{t,y}, &\text{ if } t<5 \notag\\
    \boldsymbol{n}_{t,y+1} &= \boldsymbol{G} \boldsymbol{S}_{t,y} \boldsymbol{n}_{t,y} + \boldsymbol{r}_{t,y} &\text{ if } t=5.
\end{align}


## 3. Model Data

Data inputs used in model estimation are listed in Table \ref{tab:model_data}.
\begin{table}[ht]
\centering
\caption{Data inputs used in model estimation.} 
\label{tab:model_data}
\begin{tabular}{lll}
  \hline
  Data & Years & Source \\
  \hline
  Directed pot-fishery retained-catch number & 1978/79 - 1998/99 & Fish tickets \\
  (not biomass) & 2009/10 - 2015/16 & (fishery closed 1999/00 - 2008/09 and 2016/17)\\
  \hline
  Groundfish trawl bycatch biomass & 1992/93 - 2016/17 & NMFS groundfish observer program \\
  \hline
  Groundfish fixed-gear bycatch biomass & 1992/93 - 2016/17 & NMFS groundfish observer program \\
  \hline
  NMFS trawl-survey biomass index & & \\
  (area-swept estimate) and CV & 1978-2018 & NMFS EBS trawl survey \\
  \hline
  ADF\&G pot-survey abundance index & & \\
  (CPUE) and CV & 1995-2017 & ADF\&G SMBKC pot survey \\
  \hline
  NMFS trawl-survey stage proportions & & \\
  and total number of measured crab & 1978-2018 & NMFS EBS trawl survey \\
  \hline
  ADF\&G pot-survey stage proportions & & \\
  and total number of measured crab & 1995-2017 & ADF\&G SMBKC pot survey \\
  \hline
  Directed pot-fishery stage proportions & 1990/91 - 1998/99 & ADF\&G crab observer program \\
  and total number of measured crab & 2009/10 - 2015/16 & (fishery closed 1999/00 - 2008/09 and 2016/17) \\
  \hline
\end{tabular}
\end{table}


## 4. Model Parameters

Table \ref{tab:fixed_pars} lists fixed (externally determined) parameters used in model computations. In all scenarios, the stage-transition matrix is
\begin{equation}
  \label{eq:size_transition}
  \boldsymbol{G} =
  \left[ \begin{array}{ccc}
    0.2 & 0.7 & 0.1 \\
    0 & 0.4 & 0.6 \\
    0 & 0 & 1 \end{array} \right]
\end{equation}
which is the combination of the growth matrix and molting probabilities.
\begin{table}[ht]
\centering
\caption{Fixed model parameters for all scenarios.} 
\label{tab:fixed_pars}
\begin{tabular}{lccl}
  \hline
  Parameter & Symbol & Value & Source/rationale \\
  \hline
  Trawl-survey catchability & $q$ & 1.0 & Default \\
  Natural mortality & $M$ & 0.18 $\text{yr}^{-1}$ & NPFMC (2007) \\
  Size transition matrix & $\boldsymbol{G}$ & Equation \ref{eq:size_transition} & Otto and Cummiskey (1990) \\
  Stage-1 and stage-2 & $w_{1}$, $w_{2}$ & 0.7, 1.2 kg & Length-weight equation (B. Foy, NMFS) \\
  mean weights & & & applied to stage midpoints \\
  Stage-3 mean weight & $w_{3,y}$ & Depends on year & Fishery reported average retained weight \\
  & & Table \ref{tab:length_weight} & from fish tickets, or its average, and \\
  & & & mean weights of legal males \\
  Recruitment SD & $\sigma_R$ & 1.2 & High value \\
  Natural mortality SD & $\sigma_M$ & 10.0 & High value (basically free parameter) \\
  Directed fishery & & 0.2 & 2010 Crab SAFE \\
  handling mortality & & & \\
  Groundfish trawl & & 0.8 & 2010 Crab SAFE \\
  handling mortality & & & \\
  Groundfish fixed-gear & & 0.5 & 2010 Crab SAFE \\
  handling mortality & & & \\
  \hline
\end{tabular}
\end{table}

Estimated parameters are listed in Table \ref{tab:bounds_pars} and include an estimated natural mortality deviation parameter in 1998/99 ($\delta^M_{1998}$) assuming an anomalous mortality event in that year, as hypothesized by Zheng and Kruse (2002), with natural mortality otherwise fixed at 0.18 $\text{yr}^{-1}$.
\begin{table}[ht]
\centering
\caption{The lower bound (LB), upper bound (UB), initial value, prior, and estimation phase for each estimated model parameter.} 
\label{tab:bounds_pars}
\begin{tabular}{lrrrlr}
  \hline
  Parameter & LB & Initial value & UB & Prior & Phase \\ 
  \hline
  Average recruitment $\log (\bar{R})$ & -7 & 10.0 & 20 & Uniform(-7,20) & 1 \\ 
  Stage-1 initial numbers $\log (n^0_1)$ & 5 & 14.5 & 20 & Uniform(5,20) & 1 \\ 
  Stage-2 initial numbers $\log (n^0_2)$ & 5 & 14.0 & 20 & Uniform(5,20) & 1 \\ 
  Stage-3 initial numbers $\log (n^0_3)$ & 5 & 13.5 & 20 & Uniform(5,20) & 1 \\ 
  ADF\&G pot survey catchability $q$ & 0 & 3.0 & 5 & Uniform(0,5) & 1 \\ 
  Stage-1 directed fishery selectivity 1978-2008 & 0 & 0.4 & 1 & Uniform(0,1) & 3 \\ 
  Stage-2 directed fishery selectivity 1978-2008 & 0 & 0.7 & 1 & Uniform(0,1) & 3 \\ 
  Stage-1 directed fishery selectivity 2009-2017 & 0 & 0.4 & 1 & Uniform(0,1) & 3 \\ 
  Stage-2 directed fishery selectivity 2009-2017 & 0 & 0.7 & 1 & Uniform(0,1) & 3 \\ 
  Stage-1 NMFS trawl survey selectivity & 0 & 0.4 & 1 & Uniform(0,1) & 4 \\ 
  Stage-2 NMFS trawl survey selectivity & 0 & 0.7 & 1 & Uniform(0,1) & 4 \\ 
  Stage-1 ADF\&G pot survey selectivity & 0 & 0.4 & 1 & Uniform(0,1) & 4 \\ 
  Stage-2 ADF\&G pot survey selectivity & 0 & 0.7 & 1 & Uniform(0,1) & 4 \\ 
  Natural mortality deviation during 1998 $\delta^M_{1998}$ & -3 & 0.0 & 3 & Normal(0, $\sigma^2_M$) & 4 \\ 
  Recruitment deviations $\delta^R_y$ & -7 & 0.0 & 7 & Normal(0, $\sigma_R^2$) & 3 \\ 
  Average directed fishery fishing mortality $\bar{F}^\text{df}$                 & -  & 0.2 & - & - & 1 \\
  Average trawl bycatch fishing mortality $\bar{F}^\text{tb}$                 & -  & 0.001 & - & - & 1 \\
  Average fixed gear bycatch fishing mortality $\bar{F}^\text{fb}$                 & -  & 0.001 & - & - & 1 \\
  \hline
\end{tabular}
\end{table}


## 5. Model Objective Function and Weighting Scheme

The objective function consists of the sum of several "negative log-likelihood" terms characterizing the hypothesized error structure of the principal data inputs (Table \ref{tab:likelihood_components}). A lognormal distribution is assumed to characterize the catch data and is modelled as
\begin{align}
  \sigma_{t,y}^\text{catch} &= \sqrt{\log \left( 1 + \left( \mathit{CV}_{t,y}^\text{catch} \right)^2 \right)}\\
  \delta_{t,y}^\text{catch} &= \mathcal{N} \left( 0, \left( \sigma_{t,y}^\text{catch} \right)^2 \right)
\end{align}
where $\delta_{t,y}^\text{catch}$ is the residual catch. The relative abudance data is also assumed to be lognormally distributed
\begin{align}
  \sigma_{t,y}^\text{I} &= \frac{1}{\lambda} \sqrt{\log \left( 1 + \left( \mathit{CV}_{t,y}^\text{I} \right)^2 \right)}\\
  \delta_{t,y}^\text{I} &= \log \left( I^\text{obs} / I^\text{pred} \right) / \sigma_{t,y}^\text{I} + 0.5 \sigma_{t,y}^\text{I}
\end{align}
and the likelihood is
\begin{equation}
  \sum \log \left( \delta_{t,y}^\text{I} \right) + \sum 0.5 \left( \sigma_{t,y}^\text{I} \right)^2
\end{equation}

Gmacs calculates standard deviation of the normalised residual (SDNR) values
and median of the absolute residual (MAR) values for all abundance indices and
size compositions to help the user come up with resonable likelihood weights.
For an abundance data set to be well fitted, the SDNR should not be much
greater than 1 (a value much less than 1, which means that the data set is
fitted better than was expected, is not a cause for concern). What is meant by
"much greater than 1" depends on $m$ (the number of years in the data set).
Francis (2011) suggests upper limits of 1.54, 1.37, and 1.26 for $m$ = 5, 10,
and 20, respectively. Although an SDNR not much greater than 1 is a necessary
condition for a good fit, it is not sufficient. It is important to plot the
observed and expected abundances to ensure that the fit is good.

Gmacs also calculates Francis weights for each of the size composition data
sets supplied (Francis 2011). If the user wishes to use the Francis iterative
re-weighting method, first the weights applied to the abundance indices should
be adjusted by trial and error until the SDNR (and/or MAR) are adequte. Then
the Francis weights supplied by Gmacs should be used as the new likelihood
weights for each of the size composition data sets the next time the model is
run. The user can then iteratively adjust the abudance index and size
composition weights until adequate SDNR (and/or MAR) values are achieved,
given the Francis weights.


## 6. Estimation

The model was implemented using the software AD Model Builder (Fournier et al.
2012), with parameter estimation by minimization of the model objective
function using automatic differentiation. Parameter estimates and standard
deviations provided in this document are AD Model Builder reported values
assuming maximum likelihood theory asymptotics.



# Appendix B. Data files for the reference model (16.0) 
## The reference model (16.0) data file

\fontsize{7}{9}

```
#======================================================================================================== 
# Gmacs Main  Data  File  Version 1.1:  SM18 with all new data 
# GEAR_INDEX  DESCRIPTION 
#   1      : Pot fishery retained catch. 
#   1      : Pot fishery with discarded catch. 
#   2      : Trawl bycatch 
#   3      : Fixed bycatch 
#   4      : Trawl survey 
#   5      : Pot survey 
#======================================================================================================== 
# Fisheries:  1 Pot Fishery,  2 Pot Discard,  3 Trawl by-catch, 3 Fixed by-catch 
# Surveys:   4 NMFS Trawl Survey, 5 Pot Survey 
#======================================================================================================== 
1978  # Start year 
2018  # End year 
2019  # Projection year 
5    # Number of seasons 
5    # Number of distinct data groups (among fishing fleets and surveys) 
1    # Number of sexes 
1    # Number of shell condition types 
1    # Number of maturity types 
3    # Number of size-classes in the model 
5    # Season recruitment occurs 
5    # Season molting and growth occurs 
4    # Season to calculate SSB 
1    # Season for N output 
# size_breaks (a vector giving the break points between size intervals with dimension nclass+1) 
90  105  120  135 
# weight-at-length input method (1 = allometry i.e. w_l = a*l^b, 2 = vector by sex, 3 = matrix by sex) 
3 
# weight-at-length allometry w_l = a*l^b 
4.03E-07 
# b (male, female) 
3.141334 
# Male weight-at-length 
0.000748427    0.001165731    0.001930510 
0.000748427    0.001165731    0.001688886 
0.000748427    0.001165731    0.001922246 
0.000748427    0.001165731    0.001877957 
0.000748427    0.001165731    0.001938634 
0.000748427    0.001165731    0.002076413 
0.000748427    0.001165731    0.001899330 
0.000748427    0.001165731    0.002116687 
0.000748427    0.001165731    0.001938784 
0.000748427    0.001165731    0.001939764 
0.000748427    0.001165731    0.001871067 
0.000748427    0.001165731    0.001998295 
0.000748427    0.001165731    0.001870418 
0.000748427    0.001165731    0.001969415 
0.000748427    0.001165731    0.001926859 
0.000748427    0.001165731    0.002021492 
0.000748427    0.001165731    0.001931318 
0.000748427    0.001165731    0.002014407 
0.000748427    0.001165731    0.001977471 
0.000748427    0.001165731    0.002099246 
0.000748427    0.001165731    0.001982478 
0.000748427    0.001165731    0.001930932 
0.000748427    0.001165731    0.001930932 
0.000748427    0.001165731    0.001930932 
0.000748427    0.001165731    0.001930932 
0.000748427    0.001165731    0.001930932 
0.000748427    0.001165731    0.001930932 
0.000748427    0.001165731    0.001930932 
0.000748427    0.001165731    0.001930932 
0.000748427    0.001165731    0.001930932 
0.000748427    0.001165731    0.001930932 
0.000748427    0.001165731    0.001891628 
0.000748427    0.001165731    0.001795721 
0.000748427    0.001165731    0.001823113 
0.000748427    0.001165731    0.001807433 
0.000748427    0.001165731    0.001930932 
0.000748427    0.001165731    0.001894627 
0.000748427    0.001165731    0.001850611 
0.000748427    0.001165731    0.001930932 
0.000748427    0.001165731    0.001930932 
0.000748427    0.001165731    0.001930932 
# Male mature weight-at-length (weight * proportion  mature) 
0 0.001165732 0.001945911 
# Proportion mature by sex 
0 1 1 
# Natural mortality per season input type (1 = vector by season, 2 = matrix by season/year) 
2 
# Proportion of the total natural mortality to be applied each season (each row must add to 1) 
0.000	0.070	0.000	0.560	0.370 
0.000	0.060	0.000	0.570	0.370 
0.000	0.070	0.000	0.560	0.370 
0.000	0.050	0.000	0.580	0.370 
0.000	0.070	0.000	0.560	0.370 
0.000	0.120	0.000	0.510	0.370 
0.000	0.100	0.000	0.530	0.370 
0.000	0.140	0.000	0.490	0.370 
0.000	0.140	0.000	0.490	0.370 
0.000	0.140	0.000	0.490	0.370 
0.000	0.140	0.000	0.490	0.370 
0.000	0.140	0.000	0.490	0.370 
0.000	0.140	0.000	0.490	0.370 
0.000	0.180	0.000	0.450	0.370 
0.000	0.140	0.000	0.490	0.370 
0.000	0.180	0.000	0.450	0.370 
0.000	0.180	0.000	0.450	0.370 
0.000	0.180	0.000	0.450	0.370 
0.000	0.180	0.000	0.450	0.370 
0.000	0.180	0.000	0.450	0.370 
0.000	0.180	0.000	0.450	0.370 
0.000	0.180	0.000	0.450	0.370 
0.000	0.180	0.000	0.450	0.370 
0.000	0.180	0.000	0.450	0.370 
0.000	0.180	0.000	0.450	0.370 
0.000	0.180	0.000	0.450	0.370 
0.000	0.180	0.000	0.450	0.370 
0.000	0.180	0.000	0.450	0.370 
0.000	0.180	0.000	0.450	0.370 
0.000	0.180	0.000	0.450	0.370 
0.000	0.180	0.000	0.450	0.370 
0.000	0.440	0.000	0.190	0.370 
0.000	0.440	0.000	0.190	0.370 
0.000	0.440	0.000	0.190	0.370 
0.000	0.440	0.000	0.190	0.370 
0.000	0.440	0.000	0.190	0.370 
0.000	0.440	0.000	0.190	0.370 
0.000	0.440	0.000	0.190	0.370 
0.000	0.440	0.000	0.190	0.370 
0.000	0.440	0.000	0.190	0.370 
0.000	0.440	0.000	0.190	0.370 
#0  0.0025  0  0.6245  0.373 
# Fishing fleet names (delimited with : no spaces in names) 
Pot_Fishery:Trawl_Bycatch:Fixed_bycatch 
# Survey names (delimited with : no spaces in names) 
NMFS_Trawl:ADFG_Pot 
# Number  of  catch data  frames 
4 
# Number  of  rows  in  each  data  frame 
29  17  27  27 
##  CATCH DATA 
##  Type of catch: 1 = retained, 2 = discard 
##  Units of catch: 1 = biomass, 2 = numbers 
##  for SMBKC Units are in number of crab for landed & 1000 kg for discards. 
##  Male Retained 
# year  seas   fleet  sex   obs    cv type  units mult effort  discard_mortality 
1978   3     1     1     436126  0.03   1     2     1     0     0 
1979   3     1     1     52966   0.03   1     2     1     0     0 
1980   3     1     1     33162   0.03   1     2     1     0     0 
1981   3     1     1     1045619 0.03   1     2     1     0     0 
1982   3     1     1     1935886 0.03   1     2     1     0     0 
1983   3     1     1     1931990 0.03   1     2     1     0     0 
1984   3     1     1     841017  0.03   1     2     1     0     0 
1985   3     1     1     436021  0.03   1     2     1     0     0 
1986   3     1     1     219548  0.03   1     2     1     0     0 
1987   3     1     1     227447  0.03   1     2     1     0     0 
1988   3     1     1     280401  0.03   1     2     1     0     0 
1989   3     1     1     247641  0.03   1     2     1     0     0 
1990   3     1     1     391405  0.03   1     2     1     0     0 
1991   3     1     1     726519  0.03   1     2     1     0     0 
1992   3     1     1     545222  0.03   1     2     1     0     0 
1993   3     1     1     630353  0.03   1     2     1     0     0 
1994   3     1     1     827015  0.03   1     2     1     0     0 
1995   3     1     1     666905  0.03   1     2     1     0     0 
1996   3     1     1     660665  0.03   1     2     1     0     0 
1997   3     1     1     939822  0.03   1     2     1     0     0 
1998   3     1     1     635370  0.03   1     2     1     0     0 
2009   3     1     1     103376  0.03   1     2     1     0     0 
2010   3     1     1     298669  0.03   1     2     1     0     0 
2011   3     1     1     437862  0.03   1     2     1     0     0 
2012   3     1     1     379386  0.03   1     2     1     0     0 
2014   3     1     1     69109   0.03   1     2     1     0     0 
2015   3     1     1     24407   0.03   1     2     1     0     0 
2016   3     1     1     10.000  0.03   1     2     1     0     0 
2017   3     1     1     10.000  0.03   1     2     1     0     0 
# Male  discards  Pot fishery 
1990   3     1     1    254.9787861    0.6    2     1     1     0     0.2 
1991   3     1     1    531.4483252    0.6    2     1     1     0     0.2 
1992   3     1     1    1050.387026    0.6    2     1     1     0     0.2 
1993   3     1     1    951.4626128    0.6    2     1     1     0     0.2 
1994   3     1     1    1210.764588    0.6    2     1     1     0     0.2 
1995   3     1     1    363.112032     0.6    2     1     1     0     0.2 
1996   3     1     1    528.5244687    0.6    2     1     1     0     0.2 
1997   3     1     1    1382.825328    0.6    2     1     1     0     0.2 
1998   3     1     1    781.1032977    0.6    2     1     1     0     0.2 
2009   3     1     1    123.3712279    0.2    2     1     1     0     0.2 
2010   3     1     1    304.6562225    0.2    2     1     1     0     0.2 
2011   3     1     1    481.3572126    0.2    2     1     1     0     0.2 
2012   3     1     1    437.3360731    0.2    2     1     1     0     0.2 
2014   3     1     1    45.4839749     0.2    2     1     1     0     0.2 
2015   3     1     1    21.19378597    0.2    2     1     1     0     0.2 
2016   3     1     1    0.021193786    0.2    2     1     1     0     0.2 
2017   3     1     1    0.021193786    0.2    2     1     1     0     0.2 
#	Trawl	fishery	discards							 
1991	2	2	1	3.538	0.31	2	1	1	0	0.8 
1992	2	2	1	1.996	0.31	2	1	1	0	0.8 
1993	2	2	1	1.542	0.31	2	1	1	0	0.8 
1994	2	2	1	0.318	0.31	2	1	1	0	0.8 
1995	2	2	1	0.635	0.31	2	1	1	0	0.8 
1996	2	2	1	0.500	0.31	2	1	1	0	0.8 
1997	2	2	1	0.500	0.31	2	1	1	0	0.8 
1998	2	2	1	0.500	0.31	2	1	1	0	0.8 
1999	2	2	1	0.500	0.31	2	1	1	0	0.8 
2000	2	2	1	0.500	0.31	2	1	1	0	0.8 
2001	2	2	1	0.500	0.31	2	1	1	0	0.8 
2002	2	2	1	0.726	0.31	2	1	1	0	0.8 
2003	2	2	1	0.998	0.31	2	1	1	0	0.8 
2004	2	2	1	0.091	0.31	2	1	1	0	0.8 
2005	2	2	1	0.500	0.31	2	1	1	0	0.8 
2006	2	2	1	2.812	0.31	2	1	1	0	0.8 
2007	2	2	1	0.045	0.31	2	1	1	0	0.8 
2008	2	2	1	0.272	0.31	2	1	1	0	0.8 
2009	2	2	1	0.638	0.31	2	1	1	0	0.8 
2010	2	2	1	0.360	0.31	2	1	1	0	0.8 
2011	2	2	1	0.170	0.31	2	1	1	0	0.8 
2012	2	2	1	0.011	0.31	2	1	1	0	0.8 
2013	2	2	1	0.163	0.31	2	1	1	0	0.8 
2014	2	2	1	0.010	0.31	2	1	1	0	0.8 
2015	2	2	1	0.010	0.31	2	1	1	0	0.8 
2016	2	2	1	0.229	0.31	2	1	1	0	0.8 
2017	2	2	1	0.052	0.31	2	1	1	0	0.8 
#	Fixed	fishery	discards							 
1991	2	3	1	0.045	0.31	2	1	1	0	0.5 
1992	2	3	1	2.268	0.31	2	1	1	0	0.5 
1993	2	3	1	0.500	0.31	2	1	1	0	0.5 
1994	2	3	1	0.091	0.31	2	1	1	0	0.5 
1995	2	3	1	0.136	0.31	2	1	1	0	0.5 
1996	2	3	1	0.045	0.31	2	1	1	0	0.5 
1997	2	3	1	0.181	0.31	2	1	1	0	0.5 
1998	2	3	1	0.907	0.31	2	1	1	0	0.5 
1999	2	3	1	1.361	0.31	2	1	1	0	0.5 
2000	2	3	1	0.500	0.31	2	1	1	0	0.5 
2001	2	3	1	0.862	0.31	2	1	1	0	0.5 
2002	2	3	1	0.408	0.31	2	1	1	0	0.5 
2003	2	3	1	1.134	0.31	2	1	1	0	0.5 
2004	2	3	1	0.635	0.31	2	1	1	0	0.5 
2005	2	3	1	0.590	0.31	2	1	1	0	0.5 
2006	2	3	1	1.451	0.31	2	1	1	0	0.5 
2007	2	3	1	69.717	0.31	2	1	1	0	0.5 
2008	2	3	1	6.622	0.31	2	1	1	0	0.5 
2009	2	3	1	7.522	0.31	2	1	1	0	0.5 
2010	2	3	1	9.564	0.31	2	1	1	0	0.5 
2011	2	3	1	0.796	0.31	2	1	1	0	0.5 
2012	2	3	1	0.739	0.31	2	1	1	0	0.5 
2013	2	3	1	0.341	0.31	2	1	1	0	0.5 
2014	2	3	1	0.490	0.31	2	1	1	0	0.5 
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
# Year, Seas, Fleet,  Sex,  Abundance,  CV    units 
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
2018  1 4 1 1730.74  0.281 1 
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
  1990  3 1 1 0 0 0 15  0.1133  0.3933  0.4933 
  1991  3 1 1 0 0 0 25  0.1329  0.1768  0.6902 
  1992  3 1 1 0 0 0 25  0.1905  0.2677  0.5417 
  1993  3 1 1 0 0 0 25  0.2807  0.2097  0.5096 
  1994  3 1 1 0 0 0 25  0.2942  0.2714  0.4344 
  1995  3 1 1 0 0 0 25  0.1478  0.2127  0.6395 
  1996  3 1 1 0 0 0 25  0.1595  0.2229  0.6176 
  1997  3 1 1 0 0 0 25  0.1818  0.2053  0.6128 
  1998  3 1 1 0 0 0 25  0.1927  0.2162  0.5911 
  2009  3 1 1 0 0 0 50  0.1413  0.3235  0.5352 
  2010  3 1 1 0 0 0 50  0.1314  0.3152  0.5534 
  2011  3 1 1 0 0 0 50  0.1314  0.3051  0.5636 
  2012  3 1 1 0 0 0 50  0.1417  0.3178  0.5406 
  2014  3 1 1 0 0 0 50  0.0939  0.2275  0.6786 
  2015  3 1 1 0 0 0 50  0.1148  0.2518  0.6333 
##length  proportions of  trawl survey  males 
##Year, Seas, Fleet,  Sex,  Type, Shell,  Maturity, Nsamp,  DataVec 
  1978  1 4 1 0 0 0 50  0.3865  0.3478  0.2657 
  1979  1 4 1 0 0 0 50  0.4281  0.3190  0.2529 
  1980  1 4 1 0 0 0 50  0.3588  0.3220  0.3192 
  1981  1 4 1 0 0 0 50  0.1219  0.3065  0.5716 
  1982  1 4 1 0 0 0 50  0.1671  0.2435  0.5893 
  1983  1 4 1 0 0 0 50  0.1752  0.2726  0.5522 
  1984  1 4 1 0 0 0 50  0.1823  0.2085  0.6092 
  1985  1 4 1 0 0 0 46.5 0.2023  0.2010  0.5967 
  1986  1 4 1 0 0 0 23  0.1984  0.4364  0.3652 
  1987  1 4 1 0 0 0 35.5 0.1944  0.3779  0.4277 
  1988  1 4 1 0 0 0 40.5 0.1879  0.3737  0.4384 
  1989  1 4 1 0 0 0 50  0.4246  0.2259  0.3496 
  1990  1 4 1 0 0 0 50  0.2380  0.2332  0.5288 
  1991  1 4 1 0 0 0 50  0.2274  0.3300  0.4426 
  1992  1 4 1 0 0 0 50  0.2263  0.2911  0.4826 
  1993  1 4 1 0 0 0 50  0.2296  0.2759  0.4945 
  1994  1 4 1 0 0 0 50  0.1989  0.2926  0.5085 
  1995  1 4 1 0 0 0 50  0.2593  0.3005  0.4403 
  1996  1 4 1 0 0 0 50  0.1998  0.3054  0.4948 
  1997  1 4 1 0 0 0 50  0.1622  0.3102  0.5275 
  1998  1 4 1 0 0 0 50  0.1276  0.3212  0.5511 
  1999  1 4 1 0 0 0 26  0.2224  0.2214  0.5562 
  2000  1 4 1 0 0 0 30.5 0.2154  0.2180  0.5665 
  2001  1 4 1 0 0 0 45.5 0.2253  0.2699  0.5048 
  2002  1 4 1 0 0 0 19  0.1127  0.2346  0.6527 
  2003  1 4 1 0 0 0 32.5 0.3762  0.2345  0.3893 
  2004  1 4 1 0 0 0 24  0.2488  0.1848  0.5663 
  2005  1 4 1 0 0 0 21  0.2825  0.2744  0.4431 
  2006  1 4 1 0 0 0 50  0.3276  0.2293  0.4431 
  2007  1 4 1 0 0 0 50  0.4394  0.3525  0.2081 
  2008  1 4 1 0 0 0 50  0.3745  0.2219  0.4036 
  2009  1 4 1 0 0 0 50  0.3057  0.4202  0.2741 
  2010  1 4 1 0 0 0 50  0.4081  0.3371  0.2548 
  2011  1 4 1 0 0 0 50  0.2179  0.3940  0.3881 
  2012  1 4 1 0 0 0 50  0.1573  0.4393  0.4034 
  2013  1 4 1 0 0 0 37  0.2100  0.2834  0.5065 
  2014  1 4 1 0 0 0 50  0.1738  0.3912  0.4350 
  2015  1 4 1 0 0 0 50  0.2340  0.2994  0.4666 
  2016  1 4 1 0 0 0 50  0.2255  0.2780  0.4965 
  2017  1 4 1 0 0 0 21  0.0849  0.2994  0.6157 
  2018  1 4 1 0 0 0 31  0.1475  0.2219  0.6306 
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
#  97.5  1 13.8 0.2197 
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
0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12  
0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12  
0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12  
0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 0.12 
## eof 
9999 
 
```
## The reference model (16.0) control file

```
## ———————————————————————————————————————————————————————————————————————————————————— ## 
## LEADING PARAMETER CONTROLS                                                           ## 
# Controls for leading parameter vector theta 
# LEGEND FOR PRIOR: 
#                  0 -> uniform #                  1 -> normal #                  2 -> lognormal 
#                  3 -> beta 
#                  4 -> gamma 
# ntheta 
  12 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
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
## ———————————————————————————————————————————————————————————————————————————————————— ## 
# ival        lb        ub         phz  prior     p1      p2         # parameter         # 
  14.1      10.0      30.0         -3       0    0.0   999.0         # alpha males or combined 
   0.0001    0.0       0.01        -3       0    0.0   999.0         # beta males or combined 
   0.45      0.01      1.0         -3       0    0.0   999.0         # gscale males or combined 
 121.5      65.0     145.0         -4       0    0.0   999.0         # molt_mu males or combined 
   0.060     0.0       1.0         -3       0    0.0   999.0         # molt_cv males or combined 
 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
## SELECTIVITY CONTROLS                                                                 ## 
##     Each gear must have a selectivity and a retention selectivity. If a uniform      ## 
##     prior is selected for a parameter then the lb and ub are used (p1 and p2 are     ## 
##     ignored)                                                                         ## 
## LEGEND                                                                               ## 
##     sel type: 0 = parametric, 1 = coefficients, 2 = logistic, 3 = logistic95,        ## 
##               4 = double normal (NIY)                                                ## 
##     gear index: use +ve for selectivity, -ve for retention                           ## 
##     sex dep: 0 for sex-independent, 1 for sex-dependent                              ## 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
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
   4     10    3   0    0.9     0.001 1.0    0       0      1   -5     1978   2018 
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
 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
## PRIORS FOR CATCHABILITY 
##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ## 
##     and p2 are ignored). ival must be > 0                                            ## 
## LEGEND                                                                               ## 
##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ## 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  LAMBDA: Arbitrary relative weights for each series, 0 = do not fit. 
## SURVEYS/INDICES ONLY 
## ival    lb       ub    phz   prior   p1       p2    Analytic?   LAMBDA 
   1.0     0.5      1.2   -4    0       0        9.0   0           1       # NMFS trawl 
 0.003      0        5     3    0       0        9.0   0           1       # ADF&G pot 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ADDITIONAL CV FOR SURVEYS/INDICES                                                    ## 
##     If a uniform prior is selected for a parameter then the lb and ub are used (p1   ## 
##     and p2 are ignored). ival must be > 0                                            ## 
## LEGEND                                                                               ## 
##     prior: 0 = uniform, 1 = normal, 2 = lognormal, 3 = beta, 4 = gamma               ## 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ival        lb        ub        phz   prior     p1      p2 
   0.0000001      0.00000001   10.0      -4    4         1.0     100   # NMFS 
   0.0000001      0.00000001   10.0      -4    4         1.0     100   # ADF&G 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
## PENALTIES FOR AVERAGE FISHING MORTALITY RATE FOR EACH GEAR 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
## Mean_F  STD_PHZ1  STD_PHZ2     PHZ 
   0.2       0.05     50.0       1   # Pot 
   0.0001     0.05     50.0       1   # Trawl 
   0.0001     0.05     50.0       1   # Fixed 
   0.00      2.00     20.00     -1   # NMFS 
   0.00      2.00     20.00     -1   # ADF&G 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
 
## ——————————————————————————————————————————————————————————————————————————————————— ## 
## OPTIONS FOR SIZE COMPOSTION DATA (COLUMN FOR EACH MATRIX) 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
## LIKELIHOOD OPTIONS 
##   -1) Multinomial with estimated/fixed sample size 
##   -2) Robust approximation to multinomial 
##   -3) logistic normal (NIY) 
##   -4) multivariate-t (NIY) 
##   -5) Dirichlet 
## AUTOTAIL COMPRESSION 
##   pmin is the cumulative proportion used in tail compression. 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
#  1   1   1  # Type of likelihood 
  2   2   2  # Type of likelihood 
#  5   5   5   # Type of likelihood 
  0   0   0   # Auto tail compression (pmin) 
  1   1   1   # Initial value for effective sample size multiplier 
 -4  -4  -4   # Phz for estimating effective sample size (if appl.) 
  1   2   3   # Composition aggregator 
  1   1   1   # LAMBDA 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
## TIME VARYING NATURAL MORTALIIY RATES                                                 ## 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
## TYPE:  
##      0 = constant natural mortality 
##      1 = Random walk (deviates constrained by variance in M) 
##      2 = Cubic Spline (deviates constrained by nodes & node-placement) 
##      3 = Blocked changes (deviates constrained by variance at specific knots) 
##      4 = Time blocks 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
## Sex-specific? (0=no, 1=yes) 
0 
## Type 
3 
## Phase of estimation 
3 
## STDEV in m_dev for Random walk 
10.0 
## Number of nodes for cubic spline or number of step-changes for option 3 
2 
0 # Females (ignored if single sex...) 
## Year position of the knots (vector must be equal to the number of nodes) 
1998 1999 
# 1976 1980 1985 1994 # Females (ignored if single sex...) 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
## OTHER CONTROLS 
## ———————————————————————————————————————————————————————————————————————————————————— ## 
  3       # Estimated rec_dev phase 
  3       # Estimated rec_ini phase 
  0       # VERBOSE FLAG (0 = off, 1 = on, 2 = objective func) 
  2       # Initial conditions (0 = Unfished, 1 = Steady-state fished, 2 = Free parameters) 
  1978    # First year for average recruitment for Bspr calculation 
  2018    # Last year for average recruitment for Bspr calculation 
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
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## LEADING PARAMETER CONTROLS                                                           ## 
## # Controls for leading parameter vector theta 
## # LEGEND FOR PRIOR: 
## #                  0 -> uniform #                  1 -> normal #                  2 -> lognormal 
## #                  3 -> beta 
## #                  4 -> gamma 
## # ntheta 
##   12 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
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
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
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
##    1.0     0        2     -1    0       0        9.0   0           1       # NMFS trawl 
## 0.00411135867487 0 5       1    0       0        9.0   0           1       # ADF&G pot 
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
##    0.0000001      0.00000001   10.0      -4    4         1.0     100   # NMFS 
##    0.0000001      0.00000001   10.0      -4    4         1.0     100   # ADF&G 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## PENALTIES FOR AVERAGE FISHING MORTALITY RATE FOR EACH GEAR 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## Mean_F  STD_PHZ1  STD_PHZ2     PHZ 
##    0.2       0.05     50.0       1   # Pot 
##    0.001     0.05     50.0       1   # Trawl 
##    0.001     0.05     50.0       1   # Fixed 
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
## #  1   1   1  # Type of likelihood 
##   2   2   2  # Type of likelihood 
## #  5   5   5   # Type of likelihood 
##   0   0   0   # Auto tail compression (pmin) 
##   1   1   1   # Initial value for effective sample size multiplier 
##  -4  -4  -4   # Phz for estimating effective sample size (if appl.) 
##   1   2   3   # Composition aggregator 
##   1   1   1   # LAMBDA 
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
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
##  
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
## ## OTHER CONTROLS 
## ## ———————————————————————————————————————————————————————————————————————————————————— ## 
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



# Appendix C. Spatio-temporal analysis of NMFS bottom-trawl survey SMBKC data

## Overview
This application of `VAST` was configured to model a subset of NMFS/AFSC bottom trawl
survey data.  Specifically, the station-specific CPUE (kg per hectare) for male crab great than or equal to 90mm CW 
were compiled from 1978-2018. Further details can be found at the [GitHub repo](https://github.com/james- thorson/VAST/#description)
mainpage, wiki, and glossary.  The R help files, e.g., `?Data_Fn` for explanation of data inputs, or `?Param_Fn` for explanation of parameters.
VAST has involved many publications for developing individual features (see references section below). What follows is intended as 
a step by step documentation of applying the model to these data.

## Model configuration
The following loads in the main libraries.





### Spatial settings 

The following settings define the spatial resolution for the model, and
whether to use a grid or mesh approximation as well as specific model settings.




## Data preparation
### Data-frame for catch-rate data
The following extracts a subset of the data file downloaded from AKFIN.




## Build and run model

To estimate parameters, first create a list of data-inputs used for parameter
estimation.  `Data_Fn` has some simple checks for buggy inputs, but also
please read the help file `?Data_Fn`.



## Diagnostic plots


 
### Convergence
Diagnostics generated during parameter estimation can confirm that 
parameter estimates are away from upper or lower bounds and that the final gradient for
each fixed-effect is close to zero.  For explanation of parameters, please see
references (and specifically `Data_Fn` in R).

\begin{table}[ht]
\centering
\caption{SMBKC parameter estimates, bounds, and final gradients as derived from the VAST modeling framework. } 
\label{tab:params}
\begin{tabular}{lrrrr}
  \hline
Param & Lower & MLE & Upper & final\_gradient \\ 
  \hline
ln\_H\_input & -50.0 & -0.157 & 50.0 & 0.00001 \\ 
  ln\_H\_input & -50.0 & -0.637 & 50.0 & -0.00006 \\ 
  beta1\_ct & -50.0 & 1.068 & 50.0 & 0.00001 \\ 
  beta1\_ct & -50.0 & -1.381 & 50.0 & 0.00001 \\ 
  beta1\_ct & -50.0 & -2.306 & 50.0 & -0.00002 \\ 
  beta1\_ct & -50.0 & -0.486 & 50.0 & 0.00001 \\ 
  beta1\_ct & -50.0 & 0.556 & 50.0 & 0.00001 \\ 
  beta1\_ct & -50.0 & -0.774 & 50.0 & 0.00001 \\ 
  beta1\_ct & -50.0 & -0.643 & 50.0 & -0.00004 \\ 
  beta1\_ct & -50.0 & -0.616 & 50.0 & 0.00000 \\ 
  beta1\_ct & -50.0 & -1.786 & 50.0 & 0.00000 \\ 
  beta1\_ct & -50.0 & -3.240 & 50.0 & -0.00000 \\ 
  beta1\_ct & -50.0 & -2.464 & 50.0 & 0.00001 \\ 
  beta1\_ct & -50.0 & -2.955 & 50.0 & 0.00002 \\ 
  beta1\_ct & -50.0 & -2.080 & 50.0 & 0.00001 \\ 
  beta1\_ct & -50.0 & -1.924 & 50.0 & -0.00001 \\ 
  beta1\_ct & -50.0 & -0.402 & 50.0 & -0.00002 \\ 
  beta1\_ct & -50.0 & -0.534 & 50.0 & -0.00001 \\ 
  beta1\_ct & -50.0 & -0.867 & 50.0 & -0.00001 \\ 
  beta1\_ct & -50.0 & -1.032 & 50.0 & -0.00001 \\ 
  beta1\_ct & -50.0 & 0.265 & 50.0 & -0.00002 \\ 
  beta1\_ct & -50.0 & -0.869 & 50.0 & -0.00001 \\ 
  beta1\_ct & -50.0 & -1.201 & 50.0 & -0.00001 \\ 
  beta1\_ct & -50.0 & -1.061 & 50.0 & -0.00004 \\ 
  beta1\_ct & -50.0 & -1.742 & 50.0 & 0.00001 \\ 
  beta1\_ct & -50.0 & -2.691 & 50.0 & -0.00001 \\ 
  beta1\_ct & -50.0 & -3.145 & 50.0 & -0.00001 \\ 
  beta1\_ct & -50.0 & -3.401 & 50.0 & -0.00004 \\ 
  beta1\_ct & -50.0 & -3.412 & 50.0 & 0.00002 \\ 
  beta1\_ct & -50.0 & -3.214 & 50.0 & 0.00002 \\ 
  beta1\_ct & -50.0 & -3.797 & 50.0 & -0.00001 \\ 
  beta1\_ct & -50.0 & -1.776 & 50.0 & 0.00000 \\ 
  beta1\_ct & -50.0 & -1.032 & 50.0 & -0.00002 \\ 
  beta1\_ct & -50.0 & -1.630 & 50.0 & -0.00001 \\ 
  beta1\_ct & -50.0 & 0.157 & 50.0 & 0.00001 \\ 
  beta1\_ct & -50.0 & 0.141 & 50.0 & 0.00001 \\ 
  beta1\_ct & -50.0 & -1.206 & 50.0 & -0.00003 \\ 
  beta1\_ct & -50.0 & 0.143 & 50.0 & 0.00001 \\ 
  beta1\_ct & -50.0 & -0.956 & 50.0 & 0.00005 \\ 
  beta1\_ct & -50.0 & -2.236 & 50.0 & 0.00001 \\ 
  beta1\_ct & -50.0 & -2.546 & 50.0 & -0.00001 \\ 
  beta1\_ct & -50.0 & -3.100 & 50.0 & -0.00000 \\ 
  beta1\_ct & -50.0 & -3.756 & 50.0 & 0.00002 \\ 
  L\_omega1\_z & -50.0 & 2.282 & 50.0 & 0.00007 \\ 
  L\_epsilon1\_z & -50.0 & 0.683 & 50.0 & -0.00009 \\ 
  logkappa1 & -4.7 & -3.695 & -1.9 & -0.00003 \\ 
  beta2\_ct & -50.0 & -8.669 & 50.0 & 0.00004 \\ 
  beta2\_ct & -50.0 & -7.498 & 50.0 & 0.00008 \\ 
  beta2\_ct & -50.0 & -7.295 & 50.0 & 0.00011 \\ 
  beta2\_ct & -50.0 & -7.582 & 50.0 & 0.00008 \\ 
  beta2\_ct & -50.0 & -7.801 & 50.0 & -0.00014 \\ 
  beta2\_ct & -50.0 & -6.802 & 50.0 & 0.00000 \\ 
  beta2\_ct & -50.0 & -7.813 & 50.0 & 0.00013 \\ 
  beta2\_ct & -50.0 & -8.131 & 50.0 & -0.00000 \\ 
  beta2\_ct & -50.0 & -8.362 & 50.0 & -0.00010 \\ 
  beta2\_ct & -50.0 & -8.978 & 50.0 & -0.00006 \\ 
  beta2\_ct & -50.0 & -8.486 & 50.0 & 0.00001 \\ 
  beta2\_ct & -50.0 & -8.395 & 50.0 & -0.00005 \\ 
  beta2\_ct & -50.0 & -7.845 & 50.0 & -0.00005 \\ 
  beta2\_ct & -50.0 & -7.838 & 50.0 & -0.00014 \\ 
  beta2\_ct & -50.0 & -7.881 & 50.0 & 0.00016 \\ 
  beta2\_ct & -50.0 & -7.763 & 50.0 & -0.00004 \\ 
  beta2\_ct & -50.0 & -7.515 & 50.0 & 0.00018 \\ 
  beta2\_ct & -50.0 & -7.891 & 50.0 & -0.00008 \\ 
  beta2\_ct & -50.0 & -8.162 & 50.0 & 0.00001 \\ 
  beta2\_ct & -50.0 & -7.718 & 50.0 & 0.00002 \\ 
  beta2\_ct & -50.0 & -7.656 & 50.0 & -0.00026 \\ 
  beta2\_ct & -50.0 & -7.870 & 50.0 & 0.00002 \\ 
  beta2\_ct & -50.0 & -8.767 & 50.0 & -0.00001 \\ 
  beta2\_ct & -50.0 & -8.751 & 50.0 & 0.00005 \\ 
  beta2\_ct & -50.0 & -8.249 & 50.0 & 0.00009 \\ 
  beta2\_ct & -50.0 & -8.820 & 50.0 & 0.00008 \\ 
  beta2\_ct & -50.0 & -8.854 & 50.0 & 0.00005 \\ 
  beta2\_ct & -50.0 & -9.064 & 50.0 & -0.00025 \\ 
  beta2\_ct & -50.0 & -8.506 & 50.0 & -0.00015 \\ 
  beta2\_ct & -50.0 & -8.519 & 50.0 & 0.00009 \\ 
  beta2\_ct & -50.0 & -8.129 & 50.0 & 0.00005 \\ 
  beta2\_ct & -50.0 & -8.322 & 50.0 & 0.00001 \\ 
  beta2\_ct & -50.0 & -8.136 & 50.0 & 0.00001 \\ 
  beta2\_ct & -50.0 & -8.006 & 50.0 & 0.00004 \\ 
  beta2\_ct & -50.0 & -7.794 & 50.0 & 0.00002 \\ 
  beta2\_ct & -50.0 & -8.183 & 50.0 & 0.00002 \\ 
  beta2\_ct & -50.0 & -8.765 & 50.0 & 0.00005 \\ 
  beta2\_ct & -50.0 & -8.088 & 50.0 & -0.00013 \\ 
  beta2\_ct & -50.0 & -8.574 & 50.0 & 0.00004 \\ 
  beta2\_ct & -50.0 & -8.388 & 50.0 & -0.00000 \\ 
  beta2\_ct & -50.0 & -8.873 & 50.0 & 0.00017 \\ 
  L\_omega2\_z & -50.0 & -0.767 & 50.0 & 0.00009 \\ 
  L\_epsilon2\_z & -50.0 & 0.454 & 50.0 & -0.00038 \\ 
  logkappa2 & -4.7 & -2.952 & -1.9 & -0.00001 \\ 
  logSigmaM & -50.0 & -0.352 & 10.0 & -0.00081 \\ 
   \hline
\end{tabular}
\end{table}

### Encounter-probability component
One can check to ensure that observed encounter frequencies for either low or high
probability samples are within the 95% predictive interval for predicted
encounter probability (Figure \ref{fig:encounter}. 
Diagnostics for positive-catch-rate component was evaluated using a standard Q-Q plot. 
Qualitatively, the fits to SMBKC are reasonable but could stand some more evaluation for improvement as only
one configuration was tested here (Figures \ref{fig:eq1} and \ref{fig:qq2}.

### Pearson residuals
Spatially the residual pattern can be evaluated over time. Results for SMBKC shows that consistent positive or negative 
residuals accross or within years is limited for the encounter probability component of the model and 
for the positive catch rate component (Figures \ref{fig:pearson1} and \ref{fig:pearson2}, respectively).
Some VAST plots for visualizing results can be seen by examining the
direction of faster or slower spatial decorrelation (termed "geometric anisotropy"; Figure \ref{fig:aniso}).




\begin{figure} \centerline{ \label{fig:encounter}
\includegraphics[width=0.5\textwidth] {map/VAST_output_wtge90/Diag--Encounter_prob.png}}
\caption{ Observed encounter rates and predicted probabilities for SMBKC. }
\end{figure}

\begin{figure} \centerline{ \label{fig:qq1}
\includegraphics[width=0.5\textwidth] {map/VAST_output_wtge90/Q-Q_hist.jpg}}
\caption{ Plot indicating distribution of quantiles for "positive catch rate" component. }
\end{figure}

\begin{figure} \centerline{ \label{fig:qq2}
\includegraphics[width=0.5\textwidth] {map/VAST_output_wtge90/Q-Q_plot.jpg}}
\caption{Quantile-quantile plot of residuals for "positive catch rate" component. }
\end{figure}




![Pearson residuals of the encounter probability component at SMBKC stations, 1976-2018. \label{fig:pearson1}](map/VAST_output_wtge90/maps--encounter_pearson_resid.png)

![Pearson residuals of the positive catch rate component for SMBKC stations, 1976-2018. \label{fig:pearson2}](map/VAST_output_wtge90/maps--catchrate_pearson_resid.png)



![Directional decorrelation for SMBKC stations, 1978-2018. \label{fig:aniso}](map/VAST_output_wtge90/Aniso.png)


![St. Matthews Island blue king crab (males >89mm) density maps as predicted
using the VAST model approach, 1976-2018. \label{fig:density}](map/VAST_output_wtge90/Dens.png)

### Densities and biomass estimates 
Relative densities over time suggests that the biomass of males >89mm are generally concentrated within the central part of the
survey region (Figure \ref{fig:density}). For the application to SMBKC, the biomass index was scaled
to have the same mean as that from the design-based estimate (5,764 t) of abundance (Table \ref{tab:smbkc_biomass}).

\begin{table}[ht]
\centering
\caption{SMBKC male >89mm biomass (t) estimates as derived from the VAST modeling framework.} 
\label{tab:smbkc_biomass}
\begin{tabular}{rrr}
  \hline
Year & Estimate & CV \\ 
  \hline
1977 & 4149.9 & 0.933 \\ 
  1978 & 8257.2 & 0.204 \\ 
  1979 & 11852.5 & 0.255 \\ 
  1980 & 10570.5 & 0.172 \\ 
  1981 & 8714.3 & 0.168 \\ 
  1982 & 20910.3 & 0.186 \\ 
  1983 & 9646.5 & 0.145 \\ 
  1984 & 4824.5 & 0.154 \\ 
  1985 & 4017.3 & 0.173 \\ 
  1986 & 1435.4 & 0.232 \\ 
  1987 & 2894.2 & 0.203 \\ 
  1988 & 3131.6 & 0.198 \\ 
  1989 & 6685.3 & 0.180 \\ 
  1990 & 6882.2 & 0.178 \\ 
  1991 & 7448.5 & 0.151 \\ 
  1992 & 7835.2 & 0.144 \\ 
  1993 & 10445.3 & 0.145 \\ 
  1994 & 7084.7 & 0.151 \\ 
  1995 & 6202.7 & 0.132 \\ 
  1996 & 9390.2 & 0.150 \\ 
  1997 & 9335.1 & 0.149 \\ 
  1998 & 6917.6 & 0.147 \\ 
  1999 & 2260.9 & 0.181 \\ 
  2000 & 2237.3 & 0.197 \\ 
  2001 & 3305.7 & 0.233 \\ 
  2002 & 1767.8 & 0.239 \\ 
  2003 & 1714.8 & 0.222 \\ 
  2004 & 1812.2 & 0.219 \\ 
  2005 & 1773.7 & 0.273 \\ 
  2006 & 3862.7 & 0.169 \\ 
  2007 & 5607.0 & 0.149 \\ 
  2008 & 4587.6 & 0.165 \\ 
  2009 & 6419.3 & 0.132 \\ 
  2010 & 7902.4 & 0.132 \\ 
  2011 & 7510.2 & 0.154 \\ 
  2012 & 5958.9 & 0.135 \\ 
  2013 & 2702.6 & 0.155 \\ 
  2014 & 4759.7 & 0.175 \\ 
  2015 & 2719.7 & 0.192 \\ 
  2016 & 2905.8 & 0.209 \\ 
  2017 & 1325.5 & 0.259 \\ 
  2018 & 2281.2 & 0.264 \\ 
   \hline
\end{tabular}
\end{table}

![St. Matthews Island blue king crab (males >89mm) relative abundance as predicted using the VAST model approach.\label{fig:Index}](map/VAST_output_wtge90/Index.png)


## Appendix C references


Please cite 2016 (ICES J. Mar. Sci. J.
Cons.) if using the package; 2016 (Glob.
Ecol. Biogeogr) if exploring factor
decomposition of spatio-temporal variation;
2015 (ICES J. Mar. Sci. J. Cons.) if
calculating an index of abundance; 2016
(Methods Ecol. Evol.) if using the
center-of-gravity metric; 2016 (Fish. Res.)
if using the bias-correction feature; 2016
(Proc R Soc B) if using the
effective-area-occupied metric.

  Thorson, J.T., and Barnett, L.A.K. In
  press. Comparing estimates of abundance
  trends and distribution shifts using
  single- and multispecies models of fishes
  and biogenic habitat. ICES J. Mar. Sci. J.
  Cons

  Thorson, J.T., Ianelli, J.N., Larsen, E.,
  Ries, L., Scheuerell, M.D., Szuwalski, C.,
  and Zipkin, E. 2016. Joint dynamic species
  distribution models: a tool for community
  ordination and spatiotemporal monitoring.
  Glob. Ecol. Biogeogr. 25(9): 1144-1158.
  doi:10.1111/geb.12464. url:
  http://onlinelibrary.wiley.com/doi/10.1111/geb.12464/abstract

  Thorson, J.T., Shelton, A.O., Ward, E.J.,
  Skaug, H.J., 2015. Geostatistical
  delta-generalized linear mixed models
  improve precision for estimated abundance
  indices for West Coast groundfishes. ICES
  J. Mar. Sci. J. Cons. 72(5), 1297-1310.
  doi:10.1093/icesjms/fsu243. URL:
  http://icesjms.oxfordjournals.org/content/72/5/1297

  Thorson, J.T., and Kristensen, K. 2016.
  Implementing a generic method for bias
  correction in statistical models using
  random effects, with spatial and
  population dynamics examples. Fish. Res.
  175: 66-74.
  doi:10.1016/j.fishres.2015.11.016. url:
  http://www.sciencedirect.com/science/article/pii/S0165783615301399

  Thorson, J.T., Pinsky, M.L., Ward, E.J.,
  2016. Model-based inference for estimating
  shifts in species distribution, area
  occupied, and center of gravity. Methods
  Ecol. Evol. 7(8), 990-1008.
  doi:10.1111/2041-210X.12567.  URL:
  http://onlinelibrary.wiley.com/doi/10.1111/2041-210X.12567/full

  Thorson, J.T., Rindorf, A., Gao, J.,
  Hanselman, D.H., and Winker, H. 2016.
  Density-dependent changes in effective
  area occupied for sea-bottom-associated
  marine fishes. Proc R Soc B 283(1840):
  20161853. doi:10.1098/rspb.2016.1853. URL:
  http://rspb.royalsocietypublishing.org/content/283/1840/20161853.

To see these entries in BibTeX format, use
'print(<citation>, bibtex=TRUE)',
'toBibtex(.)', or set
'options(citation.bibtex.max=999)'.

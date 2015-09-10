---
title: "Gmacs Example Stock Assessment"
author: "The Gmacs development team"
date: "September 2015"
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






# Introduction

Gmacs is a generalized size-structured stock assessment modeling framework for
molting crustacean species. Gmacs can make use of a wide variety of data,
including fishery- and survey-based size-composition data, and fishery-
dependent and -independent indices of abundance. Gmacs is coded using AD Model
Builder [@Fournier2012b].

Crab stocks of Alaska are managed by the North Pacific Fisheries Management
Council ([NPFMC](http://npfmc.org)). Some stocks are assessed with integrated
size-structured assessment models of the form described in @punt_review_2013.
Currently, each stock is assessed using a stock-specific assessment model
(e.g. @zheng_bristol_2014). The Gmacs project aims to provide software that
will allow each stock to be assessed independently but using a single flexible
modeling framework.

This application is developed to compare with the current assessment model for
the Bristol Bay Red King Crab (BBRKC) stock. The example assessment is
intended to match closely with a model scenario presented to the Fall 2014
BSAI Crab Plan Team Meeting by @zheng_bristol_2014. The following summarizes
the outcome of some comparisons between the existing BBRKC stock assessment
model [@zheng_bristol_2014] and an emulated version using the Gmacs platform.

An important component of the Gmacs framework is the provision of software for
plotting Gmacs model outputs and incorporating model outputs directly into
documentation. In what follows, we demonstrate the use of the `gmr` package to
process the output of the Gmacs-BBRKC model and produce plots that can be used
in assessment reports.

The Gmacs-BBRKC model presented here is intended to be an example comparison
which may  follow for application to other crab stocks. We provide some direct
model comparisons to  illustrate the efficacy of Gmacs and show how
alternative models can be specified (but please see
[Wiki](https://github.com/seacode/gmacs/wiki) for up to date details of model
specification and estimation).


## New features

New features added to Gmacs since the CIE review include:

  * Improved **control over selectivity specification** including: sex-specific parameter
   specification (allowing sex-specific retention as well); lower and upper bound specification for 
   each selectivity parameter; priors for each selectivity parameter; provision for additional 
   selectivity types (i.e. coefficient selectivity and double normal).
  * Improved **control over fitting of size composition** data including: the ability to aggregate size 
  compositions (e.g. male and female size compositions from the same fishery) and fit them 
  simultaneously within the multivariate distribution of choice; improvements to output files that are read into R for 
  automated plotting of the observed and expected size compositions.
  * **Prior specification explicit** now for all model parameters.
  * Option to provide a **vector of weight at size** rather than parameters.
  * Diagnostic "gradient.dat" at run completion has been added to help isolate parameters that are resulting in poor estimation properties.
  * A reference list `Gmacs.bib` containing references important to crab modeling and length-structured models in general.

These new features have greatly improved the flexibility of the Gmacs modeling framework.


## In development
Some other features requested by the NPFMC Crab Plan Team (CPT) and CIE reviews 
that are presently under development include:

  * Double-normal and non-parametric selectivity types
  * Additional time-varying options for molt, growth and maturity
  * Dirichlet size composition option for likelihoods
  * Allowing additional variances to be estimated for abundance indices
  * Fully Bayesian MCMC functionality
  * A new series of MCMC diagnostic plots including plots of MCMC traces, histograms with priors 
  overlayed, correlation plots, data and posterior predictive distributions
  * Adding diagnostics of likelihood fitting properties


## Summary of analytical approach

To reduce annual measurement errors associated with abundance estimates
derived from the area-swept method, the ADFG developed a length-based analysis
(LBA) in 1994 that incorporates multiple years of data and multiple data
sources in the estimation procedure (Zheng et al. 1995a). Annual abundance
estimates of the BBRKC stock from the LBA have been used to manage the
directed crab fishery and to set crab bycatch limits in the groundfish
fisheries since 1995. An alternative LBA (research model) was developed in
2004 to include small size groups for federal overfishing limits. The crab
abundance declined sharply during the early 1980s. The LBA estimated natural
mortality for different periods of years, whereas the research model estimated
additional mortality beyond a basic constant natural mortality during
1976-1993.

The original LBA model was described in detail by Zheng et al. (1995a, 1995b)
and Zheng and Kruse (2002). The model combines multiple sources of survey,
catch, and bycatch data using a maximum likelihood approach to estimate
abundance, recruitment, catchabilities, catches, and bycatch of the commercial
pot fisheries and groundfish trawl fisheries.

Critical assumptions of the model include:

  * The base natural mortality is constant over shell condition and size and was
    estimated assuming a maximum age of 25 and applying the 1% rule (Zheng
    2005).
  * Survey and fisheries selectivities are a function of size and were constant
    over shell condition.  Selectivities are a function of sex except for trawl
    bycatch selectivities, which are the same for both sexes. Two different
    survey selectivities were estimated: (1) 1975-1981 and (2) 1982-2013 based
    on modifications to the trawl gear used in the assessment survey. _Note: in 
    the current assessment the survey selectivity asymptotes at 0.94 which may affect
    interpretation of the survey catchability_
  * Growth is a function of size and is constant over time for males. For
    females, three growth increments per molt as a function of size were
    estimated based on sizes at maturity (1975-1982, 1983-1993, and
    1994-2013). Once mature, female red king crabs grow with a much smaller
    growth increment per molt. _Note: this feature for dimorphic time-varying growth
    is currently unavailable in Gmacs_
  * Molting probabilities are an inverse logistic function of size for
    males. Females molt annually.
  * Annual fishing seasons for the directed fishery are short. _Note: Gmacs uses
    the Baranov catch equation though options for developing pulse sequential forms are 
    in development_
  * Survey catchability ($q$) was estimated to be 0.896, based on a trawl
    experiment by Weinberg et al. (2004) with a standard deviation
    of 0.025. Survey catchability was assumed to be constant over time. Some
    scenarios estimate $q$ in the model.
  * Males mature at sizes = 120 mm CL. For convenience, female abundance was
    summarized at sizes = 90 mm CL as an index of mature females. For
    summer trawl survey data, shell ages of newshell crabs were 12 months or
    less, and shell ages of oldshell and very oldshell crabs were more than 12
    months.
  * Measurement errors were assumed to be normally distributed for size
    compositions and log-normally distributed for biomasses.


# Gmacs model configurations

The data and model specifications used in the Gmacs-BBRKC model were patterned
after those in the '4nb' scenario developed by @zheng_bristol_2014, herein
referred to as the BBRKC model. The BBRKC model treats recruits independently
by sex along with sex-specific natural mortality ($M$) and fishing mortality
($F$). Presently, the split-sex options in Gmacs only allows the  assumption
that the sex ratio at recruitment is 50:50. After recruiting, sexual dimorphic
growth and mortality along with fishery effects can play a role in changes in
sex ratio over time.  In an attempt to provide a comparison with the male-
component of the BBRKC model,  we drafted one Gmacs configuration as a "male-
only" or single sex model in addition to  the split two-sex Gmacs
configuration. Also for illustration purposes, the period and extent of data
for the single-sex model was extended back to 1953. A full comparison of the
approaches are shown in the following table:

Specification        | Parameter | ADFG Value | Gmacs OneSex | Gmacs TwoSex
-------------------- | --------- | ---------- | ------------ | ------------
Start year           | $t=0$     | 1975       | 1953         | 1975        
End year             | $t=T$     | 2014       | 2014         | 2014        
No. sexes            | $s$       | 2          | 1            | 2           
No. shell conditions | $\nu$     | 2          | 2            | 2           
No. maturity classes | $m$       | 2          | 1            | 1           
No. size-classes     | $\ell$    | 20         | 20           | 20          
No. Fleets           | $k$       | 5          | 2            | 5            


# Comparison of model results
The following plots summarize plots made using `gmr` based on output from
@zheng_bristol_2014 and Gmacs. Two Gmacs models are presented, the OneSex model
and the TwoSex model.


## Fit to survey abundance indices
In both the OneSex and TwoSex models priors were placed on $q$ for the NMFS
and BSFRF trawl surveys. A normal prior for the NMFS trawl survey was used
with $\mu = 0.843136$ (i.e. $0.896 \times 0.941$ which is the maximum
selectivity of the NMFS survey in Jies model) and $\sigma = 0.01$. A normal
prior is also used for the BSFRF trawl survey with  $\mu = 1$ and $\sigma =
0.03$.

The Gmacs model fits to survey biomass was somewhat better in the @zheng_bristol_2014
model (at least visually) than for either of the current implementations of
Gmacs (Figure \ref{fig:survey_biomass}).

![Model fits to sex-specific NMFS trawl survey biomass (tons) from 1975 to 2014. The error bars represent plus and minus 2 standard deviations.\label{fig:survey_biomass}](figure/survey_biomass-1.png) 


## Estimated retained catch and discards 

There are four fisheries defined in each of the models: the directed pot
fishery, the groundfish trawl bycatch, the NMFS trawl surveys, and the BSFRF
surveys. Each fishery has a mean fishing mortality with annual deviations. The
observed and predicted catches by gear type are summarized in (Figure
\ref{fig:fit_to_catch}). Data for discard fisheries were read in with 100%
mortality (as clarified in Table 1 of @zheng_bristol_2014).

![Observed and predicted catch (tons) by gear type for the two Gmacs models. The OneSex model includes catch data from 1953 to 2013. The TwoSex model includes catch data from 1975 to 2013.\label{fig:fit_to_catch}](figure/fit_to_catch-1.png) 

## Fit to size composition data

The fit of the Gmacs models to the BBRKC size composition data are shown in
the following plots. These include fits to the directed pot fishery for males
(Figure \ref{fig:sc_pot_m}), male crabs discarded in the directed pot fishery
(Figure \ref{fig:sc_pot_discarded_m}), female crabs discarded in the directed
pot fishery (Figure \ref{fig:sc_pot_discarded_f}), the groundfish trawl
bycatch fisheries for males (Figure \ref{fig:sc_trawl_bycatch_m}) and females
(Figure \ref{fig:sc_trawl_bycatch_f}), the NMFS trawl survey for newshell
males (Figure \ref{fig:sc_NMFS_nm}), oldshell males (Figure
\ref{fig:sc_NMFS_om}) and females (Figure \ref{fig:sc_NMFS_f}), and the BSFRF
survey (Figure \ref{fig:sc_BSFRF}).

All size composition data were fitted using the robust multinomial
distribution. In the OneSex model, new shell and old shell males were fitted
simultaneously. In the TwoSex model the following size compositions were
fitted simultaneously: discarded males and females; trawl bycatch males and
females; NMFS trawl survey new shell males together with old shell males and
females. The plots shown below have been normalized for display purposes. _In
future plotting versions the scales will be retained as an option_.

![Observed and model estimated size-frequencies of male BBRKC by year retained in the directed pot fishery.\label{fig:sc_pot_m}](figure/sc_pot_m-1.png) 

![Observed and model estimated size-frequencies of discarded male BBRKC by year in the directed pot fishery.\label{fig:sc_pot_discarded_m}](figure/sc_pot_discarded_m-1.png) 

![Observed and model estimated size-frequencies of discarded female BBRKC by year in the directed pot fishery.\label{fig:sc_pot_discarded_f}](figure/sc_pot_discarded_f-1.png) 

![Observed and model estimated size-frequencies of male BBRKC by year in the groundfish trawl bycatch fisheries.\label{fig:sc_trawl_bycatch_m}](figure/sc_trawl_bycatch_m-1.png) 

![Observed and model estimated size-frequencies of female BBRKC by year in the groundfish trawl bycatch fisheries.\label{fig:sc_trawl_bycatch_f}](figure/sc_trawl_bycatch_f-1.png) 

![Observed and model estimated size-frequencies of new shell male BBRKC by year in the NMFS trawl survey.\label{fig:sc_NMFS_nm}](figure/sc_NMFS_nm-1.png) 

![Observed and model estimated size-frequencies of old shell male BBRKC by year in the NMFS trawl survey.\label{fig:sc_NMFS_om}](figure/sc_NMFS_om-1.png) 

![Observed and model estimated size-frequencies of female BBRKC by year in the NMFS trawl survey.\label{fig:sc_NMFS_f}](figure/sc_NMFS_f-1.png) 

![Observed and model estimated size-frequencies of both male and female BBRKC by year in the BSFRF trawl surveys.\label{fig:sc_BSFRF}](figure/sc_BSFRF-1.png) 


## Mean weight-at-size

The mean weight-at-size ($w_\ell$) is defined in kg and the carapace length
($\ell$, CL) in mm. The mean weight-at-size used in all models is set to be
identical to that of the BBRKC model (Figure \ref{fig:length-weight}).

There are differences between immature and mature females hence the unusual
shape of the length-weight relationship for females [@zheng_bristol_2014].
Given a size, once females mature with eggs, they are heavier than immature
females. BBRKC uses immature mean weight-at-size for females < 90 mm and mature
mean weight- at- size for females > 89 mm. The last four values of mean
weight-at-size for females are effectively excluded (they exceed the last
observed length group),  so the plus group value is simply repeated.  In
future versions, when the immature and mature females are modeled separately,
two mean weight- at-size functions can be used. The mean weights for both male
and female plus length groups are higher than the function values to reflect
that there are more crabs larger than the plus group mid sizes. This
adjustment is based on the survey length frequency data over time.

![Relationship between carapace width (mm) and weight (kg) by sex in each of the models (provided as a vector of weights at length to Gmacs so lines all overlap).\label{fig:length-weight}](figure/length_weight-1.png) 


## Initial recruitment size distribution
Gmacs was configured to match the @zheng_bristol_2014 model recruitment size
distribution closely (Figure \ref{fig:init_rec}).

![Distribution of carapace width (mm) at recruitment.\label{fig:init_rec}](figure/init_rec-1.png) 


## Molting increment and probability

In the BBRKC model one functional for for growth increment per molt is used
for males and three functions for females (due to changing sizes at maturity).

Options to fit relationship based on data were developed within Gmacs but for
the BBRKC system, a size-specific vector was used to determine molt increments
as shown below (Figure \ref{fig:growth_inc}). Fixed parameters in gmacs were
set to match assumptions in @zheng_bristol_2014 (Figure \ref{fig:molt_prob}).

![Growth increment (mm) each molt by sex in the OneSex and TwoSex models.\label{fig:growth_inc}](figure/growth_inc-1.png) 

In the BBRKC model, females are specified to molt annually consistent with
their biology. This means that molting probability is always 1 for females and
was replicated in the Gmacs model by fixing the logistic curves parameters to
values that result in the molting probability being 1 for females across all
modeled length classes. Male BBRKC molting patterns differ from females. As
such, the BBRKC  model was specified to have two molting probability curves,
one during 1975-78 and another from 1979 to the present. _For the current
version of Gmacs, only a single molting probability curve is allowed_.

![Molting probability for each of the models by sex. The molting probability for females is fixed at 1 as females molt every year.\label{fig:molt_prob}](figure/molt_prob-1.png) 

## Transition processes

The first set of figures is the growth probabilities (for all crabs that molt)
(Figure \ref{fig:growth_trans}). The second set of figures is the combination
of growth and molting probabilities and represents the size transition (Figure
\ref{fig:size_trans}).

![Growth transitions.\label{fig:growth_trans}](figure/growth_trans-1.png) 

![Size transitions.\label{fig:size_trans}](figure/size_trans-1.png) 


## Numbers at length in the first and last year

Total abundance and the proportions by length and sex are estimated in 1975
(the models initial year).

The number of crabs in each size class (${\bf n}$) in the initial year ($t=1$)
and final year ($t=T$) in each model differ substantially (Figure
\ref{fig:init_N}). The scale of these results differ significantly and may be
related to the interaction with natural mortality estimates and how the initial
population-at-lengths were established (the BBRKC model assumes all new-shell).

![Numbers at length in 1953, 1975 and 2014 in each of the models. The first year of the OneSex model is 1953. The first year of the Zheng and TwoSex models in 1975.\label{fig:init_N}](figure/init_N-1.png) 


## Selectivity

The selectivity by size ($S_\ell$) for each of the fisheries (Figure
\ref{fig:selectivity}). In the TwoSex model, selectivity in the directed pot
fishery is sex-specific. In the remaining fisheries, selectivity is constant
by sex. In the NMFS trawl fishery, a different selectivity curve is estimated
for the 1975-1981 period and for the 1982-2014 period.

![Estimated selectivity at size, sex and fishery in the OneSex, TwoSex and Zheng models. Estimated selectivities are shown for the directed pot fishery, the trawl bycatch fishery, the NMFS trawl survey, and the BSFRF survey.\label{fig:selectivity}](figure/selectivity-1.png) 


## Natural mortality

The figure below illustrates implementation of four step changes in $M_t$
(freely estimated) in gmacs relative to the estimates from Zheng et al. 2014
(Figure \ref{fig:M_t}). In both the ADFG-BBRKC and Gmacs-BBRKC models, time-
varying natural mortality ($M_t$) is freely estimated with four step changes
through time. The years ($t$) that each of these steps cover are fixed a
priori. The pattern in time-varying natural mortality is reasonably similar
between the two models (Figure \ref{fig:M_t}), however the peak in natural
mortality during the early 1980 is not as high in the Gmacs-BBRKC model. _In
the Gmacs model, a spline function for natural mortality changes over time is
an available as an option._

![Time-varying natural mortality ($M_t$). Periods begin at 1976, 1980, 1985 and 1994.\label{fig:M_t}](figure/natural_mortality-1.png) 


## Recruitment

Recruitment ($R_t$) patterns are similar among models, but differences in
natural mortality schedules will affect these matches. The figure below shows
that the values have roughly the same mean (Figure \ref{fig:recruitment}).

![Estimated recruitment time series ($R_t$).\label{fig:recruitment}](figure/recruitment-1.png) 


## Mature male biomass (MMB)

The spawning stock biomass (tons) of mature males, termed the mature male
biomass ($\mathit{MMB}_t$), varies some between the models (Figure
\ref{fig:ssb}).

![Mature male biomass (MMB) predicted in the two versions of the Gmacs model (OneSex and TwoSex) and the Zheng model.\label{fig:ssb}](figure/spawning_stock_biomass-1.png) 


## Comparison of likelihoods between models

I had a quick hack at one one we could produce the comparative table using
R and the xtable environment to do this.


```
## Error in `row.names<-.data.frame`(`*tmp*`, value = value): invalid 'row.names' length
```

\begin{table}[ht]
\centering
\caption{Likelihoods in log-space.} 
\begin{tabular}{rlll}
  \hline
 & OneSex & TwoSex & NA \\ 
  \hline
1 & Abundance1 & 1998 & 1998 \\ 
  2 & Abundance10 & 0 & 0 \\ 
  3 & Abundance11 & 0.8 & 0.8 \\ 
  4 & Abundance2 & 1 & 1 \\ 
  5 & Abundance3 & 2 & 2 \\ 
  6 & Abundance4 & 0 & 0 \\ 
  7 & Abundance5 & 159.848 & 159.848 \\ 
  8 & Abundance6 & 0.0707 & 0.0707 \\ 
  9 & Abundance7 & 2 & 2 \\ 
  10 & Abundance8 & 2 & 2 \\ 
  11 & Abundance9 & 1 & 1 \\ 
  12 & Catch1 & 1997 & 1997 \\ 
  13 & Catch1 & 1997 & 0 \\ 
  14 & Catch10 & 0 & 1094.04 \\ 
  15 & Catch10 & 0 & 0 \\ 
  16 & Catch11 & 0.8 & 390.061 \\ 
  17 & Catch11 & 0.8 & 0.8 \\ 
  18 & Catch2 & 1 & 1 \\ 
  19 & Catch2 & 1 & 682.795 \\ 
  20 & Catch3 & 2 & 1249.85 \\ 
  21 & Catch3 & 2 & 2 \\ 
  22 & Catch4 & 0 & 0 \\ 
  23 & Catch4 & 0 & 1320.62 \\ 
  24 & Catch5 & 73.4005 & 1331.94 \\ 
  25 & Catch5 & 73.4005 & 73.4005 \\ 
  26 & Catch6 & 0.0707 & 0.0707 \\ 
  27 & Catch6 & 0.0707 & 1036.5 \\ 
  28 & Catch7 & 2 & 2 \\ 
  29 & Catch7 & 2 & 219.383 \\ 
  30 & Catch8 & 2 & 574.888 \\ 
  31 & Catch8 & 2 & 2 \\ 
  32 & Catch9 & 1 & 420.443 \\ 
  33 & Catch9 & 1 & 1 \\ 
  34 & Growth increment1 & 2001 & 2001 \\ 
  35 & Growth increment1 & 2001 & 25575.3786 \\ 
  36 & Growth increment10 & 0 & 0 \\ 
  37 & Growth increment10 & 0 & 21185.2811 \\ 
  38 & Growth increment11 & 0.8 & 0.8 \\ 
  39 & Growth increment11 & 0.8 & 14872.2125 \\ 
  40 & Growth increment2 & 1 & 53037.8475 \\ 
  41 & Growth increment2 & 1 & 1 \\ 
  42 & Growth increment3 & 2 & 71468.8639 \\ 
  43 & Growth increment3 & 2 & 2 \\ 
  44 & Growth increment4 & 0 & 0 \\ 
  45 & Growth increment4 & 0 & 98134.4466 \\ 
  46 & Growth increment5 & 164.565 & 164.565 \\ 
  47 & Growth increment5 & 164.565 & 133691.142 \\ 
  48 & Growth increment6 & 0.0707 & 224133.5224 \\ 
  49 & Growth increment6 & 0.0707 & 0.0707 \\ 
  50 & Growth increment7 & 2 & 141610.5656 \\ 
  51 & Growth increment7 & 2 & 2 \\ 
  52 & Growth increment8 & 2 & 2 \\ 
  53 & Growth increment8 & 2 & 27873.2596 \\ 
  54 & Growth increment9 & 1 & 1 \\ 
  55 & Growth increment9 & 1 & 15.9581 \\ 
  56 & Recruitment deviations1 & 2000 & 2000 \\ 
  57 & Recruitment deviations1 & 2000 & 580.5969 \\ 
  58 & Recruitment deviations10 & 0 & 1452.5688 \\ 
  59 & Recruitment deviations10 & 0 & 0 \\ 
  60 & Recruitment deviations11 & 0.8 & 0.8 \\ 
  61 & Recruitment deviations11 & 0.8 & 1494.1358 \\ 
  62 & Recruitment deviations2 & 1 & 3051.0025 \\ 
  63 & Recruitment deviations2 & 1 & 1 \\ 
  64 & Recruitment deviations3 & 2 & 6285.0139 \\ 
  65 & Recruitment deviations3 & 2 & 2 \\ 
  66 & Recruitment deviations4 & 0 & 11746.2985 \\ 
  67 & Recruitment deviations4 & 0 & 0 \\ 
  68 & Recruitment deviations5 & 100.354 & 13848.353 \\ 
  69 & Recruitment deviations5 & 100.354 & 100.354 \\ 
  70 & Recruitment deviations6 & 0.0707 & 15892.2769 \\ 
  71 & Recruitment deviations6 & 0.0707 & 0.0707 \\ 
  72 & Recruitment deviations7 & 2 & 2 \\ 
  73 & Recruitment deviations7 & 2 & 8194.955 \\ 
  74 & Recruitment deviations8 & 2 & 1445.8374 \\ 
  75 & Recruitment deviations8 & 2 & 2 \\ 
  76 & Recruitment deviations9 & 1 & 0.8966 \\ 
  77 & Recruitment deviations9 & 1 & 1 \\ 
  78 & Size composition1 & 1999 & 14193.2092 \\ 
  79 & Size composition1 & 1999 & 1999 \\ 
  80 & Size composition10 & 0 & 0 \\ 
  81 & Size composition10 & 0 & 1683.4623 \\ 
  82 & Size composition11 & 0.8 & 0.8 \\ 
  83 & Size composition11 & 0.8 & 1596.3958 \\ 
  84 & Size composition2 & 1 & 20982.0861 \\ 
  85 & Size composition2 & 1 & 1 \\ 
  86 & Size composition3 & 2 & 2 \\ 
  87 & Size composition3 & 2 & 22386.0088 \\ 
  88 & Size composition4 & 0 & 28391.2455 \\ 
  89 & Size composition4 & 0 & 0 \\ 
  90 & Size composition5 & 201.575 & 37748.2974 \\ 
  91 & Size composition5 & 201.575 & 201.575 \\ 
  92 & Size composition6 & 0.0707 & 0.0707 \\ 
  93 & Size composition6 & 0.0707 & 45366.8326 \\ 
  94 & Size composition7 & 2 & 2 \\ 
  95 & Size composition7 & 2 & 13587.4 \\ 
  96 & Size composition8 & 2 & 1328.487 \\ 
  97 & Size composition8 & 2 & 2 \\ 
  98 & Size composition9 & 1 & 1.0039 \\ 
  99 & Size composition9 & 1 & 1 \\ 
  100 & Catch12 &  & 200.606 \\ 
  101 & Catch13 &  & 186.436 \\ 
  102 & Catch14 &  & 597.816 \\ 
  103 & Catch15 &  & 174.066 \\ 
  104 & Catch16 &  & 247.553 \\ 
  105 & Catch17 &  & 315.959 \\ 
  106 & Catch18 &  & 335.39 \\ 
  107 & Catch19 &  & 426.564 \\ 
  108 & Catch20 &  & 88.9147 \\ 
  109 & Catch21 &  & 194.24 \\ 
  110 & Catch22 &  & 106.509 \\ 
  111 & Catch23 &  & 73.4005 \\ 
  112 & Catch24 &  & 159.848 \\ 
  113 & Catch25 &  & 201.575 \\ 
  114 & Catch26 &  & 100.354 \\ 
  115 & Catch27 &  & 164.565 \\ 
  116 & Catch28 &  & 155.091 \\ 
  117 & Catch29 &  & 172.32 \\ 
  118 & Catch30 &  & 119.557 \\ 
  119 & Catch31 &  & 155.222 \\ 
  120 & Catch32 &  & 116.676 \\ 
  121 & Catch33 &  & 138.486 \\ 
  122 & Catch34 &  & 159.516 \\ 
  123 & Catch35 &  & 103.743 \\ 
  124 & Catch36 &  & 89.0308 \\ 
  125 & Catch37 &  & 69.2305 \\ 
  126 & Catch38 &  & 62.2251 \\ 
  127 & Catch39 &  & 126.832 \\ 
  128 & Growth increment12 &  & 22601.9338 \\ 
  129 & Growth increment13 &  & 16452.6066 \\ 
  130 & Growth increment14 &  & 6741.5119 \\ 
  131 & Growth increment15 &  & 6398.551 \\ 
  132 & Growth increment16 &  & 655.0192 \\ 
  133 & Growth increment17 &  & 75.3031 \\ 
  134 & Growth increment18 &  & 422.3743 \\ 
  135 & Growth increment19 &  & 643.7567 \\ 
  136 & Growth increment20 &  & 1.8653 \\ 
  137 & Growth increment21 &  & 1.6129 \\ 
  138 & Growth increment22 &  & 1.0292 \\ 
  139 & Growth increment23 &  & 19.6735 \\ 
  140 & Growth increment24 &  & 875.31 \\ 
  141 & Growth increment25 &  & 8.8472 \\ 
  142 & Growth increment26 &  & 40.5669 \\ 
  143 & Growth increment27 &  & 173.2765 \\ 
  144 & Growth increment28 &  & 7.2643 \\ 
  145 & Growth increment29 &  & 431.6295 \\ 
  146 & Growth increment30 &  & 187.8347 \\ 
  147 & Growth increment31 &  & 500.5929 \\ 
  148 & Growth increment32 &  & 36.6365 \\ 
  149 & Growth increment33 &  & 187.0521 \\ 
  150 & Growth increment34 &  & 147.7655 \\ 
  151 & Growth increment35 &  & 85.062 \\ 
  152 & Growth increment36 &  & 122.1231 \\ 
  153 & Growth increment37 &  & 24.0528 \\ 
  154 & Growth increment38 &  & 12.2952 \\ 
  155 & Growth increment39 &  & 99.695 \\ 
  156 & Recruitment deviations12 &  & 2747.6651 \\ 
  157 & Recruitment deviations13 &  & 2169.2739 \\ 
  158 & Recruitment deviations14 &  & 892.8118 \\ 
  159 & Recruitment deviations15 &  & 823.9982 \\ 
  160 & Recruitment deviations16 &  & 744.2598 \\ 
  161 & Recruitment deviations17 &  & 540.4608 \\ 
  162 & Recruitment deviations18 &  & 461.3055 \\ 
  163 & Recruitment deviations19 &  & 776.1702 \\ 
  164 & Recruitment deviations20 &  & 4.7891 \\ 
  165 & Recruitment deviations21 &  & 3.3783 \\ 
  166 & Recruitment deviations22 &  & 223.6849 \\ 
  167 & Recruitment deviations23 &  & 337.131 \\ 
  168 & Recruitment deviations24 &  & 992.8002 \\ 
  169 & Recruitment deviations25 &  & 523.6807 \\ 
  170 & Recruitment deviations26 &  & 374.0069 \\ 
  171 & Recruitment deviations27 &  & 407.0197 \\ 
  172 & Recruitment deviations28 &  & 515.8374 \\ 
  173 & Recruitment deviations29 &  & 878.7255 \\ 
  174 & Recruitment deviations30 &  & 559.7382 \\ 
  175 & Recruitment deviations31 &  & 1319.9289 \\ 
  176 & Recruitment deviations32 &  & 838.8427 \\ 
  177 & Recruitment deviations33 &  & 1273.8664 \\ 
  178 & Recruitment deviations34 &  & 1445.6859 \\ 
  179 & Recruitment deviations35 &  & 1074.0894 \\ 
  180 & Recruitment deviations36 &  & 822.5743 \\ 
  181 & Recruitment deviations37 &  & 345.4237 \\ 
  182 & Recruitment deviations38 &  & 240.3815 \\ 
  183 & Recruitment deviations39 &  & 346.6002 \\ 
  184 & Size composition12 &  & 3858.139 \\ 
  185 & Size composition13 &  & 4279.5853 \\ 
  186 & Size composition14 &  & 2882.5256 \\ 
  187 & Size composition15 &  & 3829.9957 \\ 
  188 & Size composition16 &  & 5060.7501 \\ 
  189 & Size composition17 &  & 4899.9376 \\ 
  190 & Size composition18 &  & 3636.2754 \\ 
  191 & Size composition19 &  & 4742.8402 \\ 
  192 & Size composition20 &  & 33.5409 \\ 
  193 & Size composition21 &  & 35.0981 \\ 
  194 & Size composition22 &  & 2430.826 \\ 
  195 & Size composition23 &  & 2519.3853 \\ 
  196 & Size composition24 &  & 4705.0166 \\ 
  197 & Size composition25 &  & 2825.583 \\ 
  198 & Size composition26 &  & 3209.6601 \\ 
  199 & Size composition27 &  & 3432.503 \\ 
  200 & Size composition28 &  & 3247.3905 \\ 
  201 & Size composition29 &  & 5844.8957 \\ 
  202 & Size composition30 &  & 3796.4672 \\ 
  203 & Size composition31 &  & 6962.3315 \\ 
  204 & Size composition32 &  & 4411.351 \\ 
  205 & Size composition33 &  & 6932.2102 \\ 
  206 & Size composition34 &  & 6857.3349 \\ 
  207 & Size composition35 &  & 5830.5623 \\ 
  208 & Size composition36 &  & 6427.9045 \\ 
  209 & Size composition37 &  & 3929.9557 \\ 
  210 & Size composition38 &  & 2997.8702 \\ 
  211 & Size composition39 &  & 3545.4033 \\ 
   \hline
\end{tabular}
\end{table}

\begin{table}[ht]
\centering
\caption{Penalties in log-space.} 
\begin{tabular}{rrr}
  \hline
 & OneSex & TwoSex \\ 
  \hline
log\_fdev & 0.03 & 0.11 \\ 
  mean F & 9.47 & 9.47 \\ 
  M & 7.19 & 18.91 \\ 
  rec\_dev & 0.00 & 0.00 \\ 
  rec\_ini & 0.00 & 0.00 \\ 
  rec\_dev\_ & 86.29 & 213.11 \\ 
   \hline
\end{tabular}
\end{table}




# Discussion

Comparisons of likelihood function components are available from the output
but more  detailed evaluation is needed. Simulation testing is also slated for
evaluating alternative model specifications for robustness (e.g., constant
natural mortality over time, time-varying selectivity, etc).

The current Gmacs models require that many of the key model parameters be fixed to
obtain model fits that look similar to the BBRKC model.


```
##   |                                                                         |                                                                 |   0%  |                                                                         |.............                                                    |  20%
##   ordinary text without R code
## 
##   |                                                                         |..........................                                       |  40%
## label: unnamed-chunk-1 (with options) 
## List of 2
##  $ eval   : logi TRUE
##  $ include: logi FALSE
## 
##   |                                                                         |.......................................                          |  60%
##   ordinary text without R code
## 
##   |                                                                         |....................................................             |  80%
## label: unnamed-chunk-2 (with options) 
## List of 2
##  $ eval   : logi TRUE
##  $ include: logi FALSE
## 
##   |                                                                         |.................................................................| 100%
##   ordinary text without R code
```

```
## [1] "app.md"
```

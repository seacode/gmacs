---
title: "Appendix comparing aspects of gmacs configured to be similar to that of Zheng et al. 2014"
output: pdf_document
bibliography: gmacs.bib
---

The following summarizes the outcome of some comparisons between the existing
Bristol Bay red king crab (BBRKC) stock assessment model [@zheng_bristol_2014]
(Zheng et al. 2014) and an emulated version using the gmacs platform.  Since the
BBRKC model from Zheng et al. (2014) treats recruits by sex along with
sex-specific natural mortality and fishing mortality, results from the male
components are compared with results from a `gmacs` model implementation tuned
to male-only data.







# Size specific schedules

## Mean weight-at-length

The mean weight-at-length ($w_\ell$) of crabs is defined in grams and the
carapace length ($\ell$, CL) in mm. The mean weight-at-length used in both
models is nearly identical (Figure \ref{fig:mean_wt}). The only difference
between the two models is in the final length class (160mm) where the mean
weight is greater in Zheng's model than in gmacs.

The length-weight relationships used in Zheng's model for males and females were
$$W = 0.000408 L^{3.127956} \quad \text{immature females},$$
$$W = 0.003593 L^{2.666076} \quad \text{ovigerous females},$$
$$W = 0.0004031 L^{3.141334} \quad \text{males}.$$

![Mean weight-at-length.\label{fig:mean_wt}](Figs/mean_wt-1.png) 

  
## Initial recruitment size distribution

Gmacs was configured to match the Zheng et al. (2014) model closely and this was
achieved (Figure \ref{fig:init_rec}).

![Length at recruitment.\label{fig:init_rec}](Figs/init_rec-1.png) 

## Molting increment width

Options to fit relationship based on data was developed but for the BBRKC
system, a size-specific vector was used to determine molt increments as show
below (Figure \ref{fig:growth_inc}).

![Growth increment.\label{fig:growth_inc}](Figs/growth_inc-1.png) 

## Molting probability

Fixed parameters in gmacs were easily set to represent that assumed from Zheng
et al. (2014) (Figure \ref{fig:molt_prob}).

![Molting probability.\label{fig:molt_prob}](Figs/molt_prob-1.png) 

## Transition processes

The first set of figures is the growth probabilities (for all crabs that molt)
(Figure \ref{fig:growth_trans}).

![Growth transitions.\label{fig:growth_trans}](Figs/growth_trans-1.png) 

The second set of figures is the combination of growth and molting and
represents the size transition (Figure \ref{fig:size_trans}).

![Growth transitions.\label{fig:size_trans}](Figs/size_trans-1.png) 

## Numbers at length in 1975

The scale of these results differ significantly and may be related to the
interaction with natural mortality estimates and how the initial
population-at-lengths were established (the BBRKC model assumes all new-shell)
(Figure \ref{fig:init_N}).

![Initial numbers.\label{fig:init_N}](Figs/init_N-1.png) 
 
# Time series results/comparisons

## Natural mortality

The figure below illustrates implementation of four step changes in $M_t$
(freely estimated) in gmacs relative to the estimates from Zheng et al. 2014
(Figure \ref{fig:M_t}).

![Time-varying natural mortality.\label{fig:M_t}](Figs/M_t-1.png) 


## Recruitment

Recruitment patterns are similar, but differences in natural mortality schedules
will affect these matches. The figure below plots the values to have the same
mean (Figure \ref{fig:recruits}).

![Recruitment ($R_t$).\label{fig:recruits}](Figs/recruits-1.png) 


## Fit to survey abundance indices

The model fit to survey biomass (males) was better for the current model (at
least visually) than for the current implementation of gmacs (Figure
\ref{fig:survey_biomass}).

![Survey biomass.\label{fig:survey_biomass}](Figs/survey_biomass-1.png) 

 
## Estimated retained catch and discards, for whole period

This figure summarizes the observed (horizontal) and predicted (vertical)
catches by gear type. Data for discard fisheries were read in with 100%
mortality (as clarified in Table 1 of Zheng et al. 2014) (Figure
\ref{fig:fit_to_catch}).

![Fit to catch.\label{fig:fit_to_catch}](Figs/fit_to_catch-1.png) 



# Other diagnostics

## Fit to size frequency data

The subsequent figures provide fits to the male BBRKC data based on gmacs
(Figure \ref{fig:sizecomps}).

![Size comps.\label{fig:sizecomps}](Figs/sizecomps-1.png) ![Size comps.\label{fig:sizecomps}](Figs/sizecomps-2.png) ![Size comps.\label{fig:sizecomps}](Figs/sizecomps-3.png) ![Size comps.\label{fig:sizecomps}](Figs/sizecomps-4.png) ![Size comps.\label{fig:sizecomps}](Figs/sizecomps-5.png) ![Size comps.\label{fig:sizecomps}](Figs/sizecomps-6.png) 



# Summary

Comparisons of actual likelihood function values and year-specific fits using
the robust-multinomial would be the next step after selectivity issues are
resolved. Subsequent to that, it would be worth exploring aspects of alternative
model specifications (e.g., constant natural mortality over time, time-varying
selectivity, etc) to evaluate sensitivities.


# References

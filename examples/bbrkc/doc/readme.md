---
title: "Appendix comparing aspects of gmacs configured to be similar to that of Zheng et al. 2014"
output: pdf_document
---
## Results culminating from the mid-January 2015 crab modeling workshop

The following summarizes the outcome of some rudimentary comparisons between the existing BBRKC model and an emulated version using the gmacs platform.
Since the BBRKC model from Zheng et al. (2014) treats recruits by sex along with sex-specific natural mortality and fishing mortality, results from the male components are compared with
results from a `gmacs` model implementation tuned to male-only data. 







# Size specific schedules

## Mean weight-at-length
The values used in both models are nearly identical:

![plot of chunk mean_wt](Figs/mean_wt-1.png) 

  
## Initial recruitment size distribution
Gmacs was configured to match the Zheng et al. (2014) model closely and this was achieved: 

![plot of chunk init_rec](Figs/init_rec-1.png) 

## Molting increment width
Options to fit relationship based on data was developed but for the BBRKC system, a size-specific vector was used to determine molt increments as show below.

![plot of chunk growth_inc](Figs/growth_inc-1.png) 

## Molting probability
Fixed parameters in gmacs were easily set to represent that assumed from Zheng et al. (2014).

![plot of chunk molt_prob](Figs/molt_prob-1.png) 

## Transition processes

The first set of figures is the growth probabilities (for all crabs that molt)

![plot of chunk growth_trans](Figs/growth_trans-1.png) 

The second set of figures is the combination of growth and molting and represents the size transition:

![plot of chunk size_trans](Figs/size_trans-1.png) 

## Numbers at length in 1975
The scale of these results differ significantly and may be related to the interaction with natural mortality estimates and how the initial population-at-lengths were established (the BBRKC model assumes all new-shell).

![plot of chunk init_N](Figs/init_N-1.png) 
 
# Time series results/comparisons
## Natural mortality
The figure below illustrates implementation of 4 step changes in M (freely estimated) in gmacs relative to the estimates from Zheng et al. 2014.


![plot of chunk M_t](Figs/M_t-1.png) 
 
## Recruitment
Recruitment patterns are similar, but differences in natural mortality schedules will affect these matches. The figure below plots the values to have the same mean.

![plot of chunk recruits](Figs/recruits-1.png) 

## Fit to survey abundance indices
The model fit to survey biomass (males) was better for the current model (at least visually) than for the current implementation of gmacs:


![plot of chunk survey_biomass](Figs/survey_biomass-1.png) 

 
## Estimated retained catch and discards, for whole period
This figure summarizes the observed (horizontal) and predicted (vertical) catches by gear type. Data for discard fisheries were read in with 100% mortality (as clarified in Table 1 of Zheng et al. 2014).

![plot of chunk fit_to_catch](Figs/fit_to_catch-1.png) 



# Other diagnostics

## Fit to size frequency data

The subsequent figures provide fits to the male BBRKC data based on gmacs.


```
## [[1]]
```

![plot of chunk sizecomps](Figs/sizecomps-1.png) 

```
## [[1]]
```

![plot of chunk sizecomps](Figs/sizecomps-2.png) 

```
## [[1]]
```

![plot of chunk sizecomps](Figs/sizecomps-3.png) 

```
## [[1]]
```

![plot of chunk sizecomps](Figs/sizecomps-4.png) 

```
## [[1]]
```

![plot of chunk sizecomps](Figs/sizecomps-5.png) 

```
## [[1]]
```

![plot of chunk sizecomps](Figs/sizecomps-6.png) 



# Summary
Comparisons of actual likelihood function values and year-specific fits using the robust-multinomial would be the next step after selectivity issues are resolved. Subsequent to that,
it would be worth exploring aspects of alternative model specifications (e.g., constant natural mortality over time, time-varying selectivity, etc) to evaluate sensitivities.




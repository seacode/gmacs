---
title: "Saint Matthew Island Blue King Crab Stock Assessment 2016"
author:
- D'Arcy Webber
- Jie Zheng
- James Ianelli
institute: "Quantifish, ADF&G, NOAA"
date: "`r format(Sys.time(), '%B %Y')`"
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

```{r global_options, include=FALSE}
library(knitr)
opts_chunk$set(fig.width = 12, fig.height = 7, echo = FALSE, warning = FALSE, message = FALSE)
```

```{r, load_packages, include=FALSE}
library(gmr)
library(xtable)
options(xtable.comment = FALSE)

# The model specs
.MODELDIR = c("../../examples/smbkc2/model_1/", "../../examples/smbkc2/model_1/", "../../examples/smbkc2/model_2/", "../../examples/smbkc2/model_3/", "../../examples/smbkc2/model_4/")
.THEME    = theme_bw(base_size = 12, base_family = "")
.OVERLAY  = TRUE
.SEX      = c("Aggregate","Male")
.FLEET    = c("Pot","Trawl bycatch","Fixed bycatch","NMFS Trawl","ADF&G Pot")
.TYPE     = c("Retained & Discarded","Retained","Discarded")
.SHELL    = c("Aggregate")
.MATURITY = c("Aggregate")
.SEAS     = c("1","2","3","4")

# Read report file and create gmacs report object (a list):
fn       <- paste0(.MODELDIR, "gmacs")
M        <- lapply(fn, read_admb)
names(M) <- c("2015 Model", "Gmacs base","Gmacs selex","Gmacs CV","Gmacs M")

jj <- 1 # The position in the list that Jies model outputs sit

# Add numbers at length data
nmult <- 1e+06
M[[jj]]$N_len[,1] <- nmult * c(3.78235,4.84166,4.21852,1.7556,1.8762,1.01266,0.866184,1.2789,1.89578,1.86503,1.65332,2.64882,1.71918,2.46729,2.71706,2.96956,1.74463,1.84754,2.15061,1.30642,0.852401,0.45627,0.479496,0.479076,0.215485,0.453805,0.293347,0.656367,0.970389,0.716526,1.25167,1.12962,1.05771,0.896425,0.58185,0.681566,0.61932,0.496048,NA)
M[[jj]]$N_len[,2] <- nmult * c(2.41947,2.94323,3.80508,3.73373,2.21668,1.76026,1.1071,0.837916,0.998129,1.41795,1.53813,1.45469,2.00878,1.64349,1.93093,2.17626,2.39386,1.75195,1.61891,1.74673,1.28364,0.41512,0.405329,0.415779,0.418944,0.265868,0.353951,0.289723,0.480511,0.727161,0.646712,0.946953,0.967554,0.919677,0.802819,0.586163,0.594288,0.557095,NA)
M[[jj]]$N_len[,3] <- nmult * c(1.67834,2.20341,3.26581,4.60382,4.7799,3.40968,2.0207,1.49864,1.28226,1.37185,1.6461,1.88861,2.08216,2.38952,2.16295,2.26905,2.39884,2.43188,2.31067,2.14367,1.79981,0.691298,0.785188,0.858978,0.925671,0.98279,0.953565,0.973699,0.958382,1.04024,1.20501,1.32928,1.48274,1.43165,1.23077,1.06162,1.18039,1.21812,NA)

# Add MMB data - I think Jie has recorded this in millions of pounds so need to convert to pounds then to tonnes
ii <- which(M[[jj]]$fit$names %in% "sd_log_ssb")
M[[jj]]$ssb <- 0.000453592 * 1e+6 * c(10.0578,13.8772,20.9465,21.4302,15.587,9.63072,6.76121,6.23052,6.27224,7.52934,8.45448,9.71117,10.6995,9.98854,10.338,11.2326,11.0988,10.8259,9.92555,8.59999,4.23953,3.57858,3.9142,4.21781,4.47775,4.34261,4.43547,4.36487,4.74001,5.49302,6.05754,6.66583,6.21993,5.41045,4.64299,5.37923,5.47191,5.90738)
M[[jj]]$fit$est[ii] <- log(0.000453592 * 1e+6 * c(10.0578,13.8772,20.9465,21.4302,15.587,9.63072,6.76121,6.23052,6.27224,7.52934,8.45448,9.71117,10.6995,9.98854,10.338,11.2326,11.0988,10.8259,9.92555,8.59999,4.23953,3.57858,3.9142,4.21781,4.47775,4.34261,4.43547,4.36487,4.74001,5.49302,6.05754,6.66583,6.21993,5.41045,4.64299,5.37923,5.47191,5.90738))
M[[jj]]$fit$std[ii] <- NA

# Add natural mortality data
ii <- which(M[[jj]]$mod_yrs == 1998)
M[[jj]]$M[ii,] <- 0.937813
#M[[jj]]$M[21,] <- M[[jj]]$M[1,]

# Add recruitment data - It looks like Jie has recorded this as millions of individuals
ii <- which(M[[jj]]$fit$names %in% "sd_log_recruits")
M[[jj]]$fit$est[ii] <- log(1e+6 * c(NA,4.22369,3.4114,1.05153,1.58853,0.709932,0.705147,1.1393,1.68745,1.55298,1.34618,2.37665,1.28166,2.18467,2.31576,2.5257,1.26052,1.56477,1.84916,0.95593,0.642419,0.391891,0.403301,0.398974,0.135469,0.417821,0.217583,0.607371,0.860754,0.554587,1.13471,0.920731,0.870296,0.722566,0.435444,0.586532,0.505472,0.393023))
M[[jj]]$fit$std[ii] <- NA

# Add estimated trawl survey biomass (million of lbs)
M[[jj]]$pre_cpue[1,] <- 1e+03 * 0.453592 * c(16.9107,20.3464,27.3302,29.7194,27.6591,20.8337,11.9956,10.3426,9.8731,11.2107,12.1871,14.5983,15.1584,16.8995,16.6574,18.4302,17.7172,16.9087,16.198,15.4322,11.7999,4.41029,4.81213,5.15032,5.15653,5.29834,5.20702,5.53472,6.25679,6.90932,8.00088,8.98708,9.28411,8.88151,7.41716,6.63175,6.99459,7.02906)
M[[jj]]$pre_cpue[2,1:8] <- c(17.2843,12.0422,5.28179,5.22433,7.22742,10.1542,6.85929,7.14304)

#Estimated pot survey length compositions
M[[jj]]$d3_pre_size_comps_out[53:60,] <- t(matrix(c(0.147886,0.0979305,0.125489,0.0776841,0.137161,0.144113,0.137471,0.0960776,0.291162,0.306197,0.226123,0.194615,0.289009,0.273711,0.245472,0.224032,0.560952,0.595872,0.648388,0.727701,0.57383,0.582176,0.617057,0.679891), nrow = 3, byrow = TRUE))
M[[jj]]$d3_pre_size_comps_out[15:52,] <- t(matrix(c(0.389466,0.393592,0.290957,0.125601,0.153106,0.116868,0.157769,0.270281,0.361676,0.314393,0.262176,0.350587,0.223486,0.293695,0.312116,0.313866,0.199677,0.231037,0.271211,0.186399,0.158282,0.218432,0.213903,0.202283,0.0974652,0.195338,0.130912,0.257895,0.312885,0.216089,0.313673,0.252375,0.226645,0.205558,0.162655,0.218646,0.19071,0.158486,0.346918,0.333177,0.365452,0.371972,0.251893,0.282883,0.2808,0.246592,0.265166,0.332849,0.339648,0.268111,0.363629,0.272423,0.308875,0.320304,0.381522,0.305075,0.284293,0.347045,0.331919,0.276737,0.25179,0.244465,0.263869,0.159361,0.219958,0.158518,0.215745,0.305372,0.225683,0.294607,0.288704,0.293667,0.312516,0.261849,0.254832,0.247853,0.263616,0.273231,0.343592,0.502426,0.595,0.600248,0.561432,0.483127,0.373158,0.352759,0.398177,0.381302,0.412884,0.433882,0.379009,0.365831,0.418801,0.463888,0.444496,0.466556,0.509799,0.50483,0.534306,0.553251,0.638666,0.645301,0.64913,0.583587,0.47137,0.478539,0.460644,0.453019,0.484651,0.500775,0.52483,0.519505,0.554458,0.593661), nrow = 3, byrow = TRUE))

# Add selectivity data
# year, sex, fleet, vec
ind <- which(M[[jj]]$slx_capture[,3] %in% 1)[1:31]
for (i in ind)
{
    M[[jj]]$slx_capture[i,4:6] <- c(0.416198,0.657528,1) # Directed pot fisheries
}
ind <- which(M[[jj]]$slx_capture[,3] %in% 1)[32:38]
for (i in ind)
{
    M[[jj]]$slx_capture[i,4:6] <- c(0.326889,0.806548,1) # Directed pot fisheries
}
ind <- which(M[[jj]]$slx_capture[,3] %in% 4)
for (i in ind)
{
    M[[jj]]$slx_capture[i,4:6] <- c(0.655565,0.912882,1) # ADFG pot survey
}
ind <- which(M[[jj]]$slx_capture[,3] %in% 5)
for (i in ind)
{
    M[[jj]]$slx_capture[i,4:6] <- c(0.347014,0.720493,1) # Trawl survey
}

# Add size-weight data
#M[[jj]]$mid_points <- j_len$Size
#M[[jj]]$mean_wt <- rbind(j_len$MaleWt, j_len$FemaleWt)

# Add growth transition data
#M[[jj]]$growth_transition <- rbind(j_ltr, j_ltr)
#M[[jj]]$growth_transition <- rbind(j_ltr)

# Add size transition data
M[[jj]]$size_transition_M <- matrix(c(0.2,0.7,0.1,0,0.4,0.6,0,0,1), nrow = 3, ncol = 3, byrow = TRUE)

# Add molting probability data
#M[[jj]]$molt_probability <- rbind(j_len$MP_1987, rep(1, length(j_len$MP_1987)))

# Add recruitment size distribution data - in Jies model all recruit to first size class, in gmacs almost all to first size class (i.e. 0.9945 0.0055 0.0000).
M[[jj]]$rec_sdd <- c(1,0,0)

# The .rep files for each of the Gmacs models. Used for making tables of the likelihood components
like <- list()
like[[1]] <- readLines("../../examples/bbrkc/OneSex/gmacs.rep")
like[[2]] <- readLines("../../examples/bbrkc/TwoSex/gmacs.rep")

fn <- paste0(.MODELDIR[2], "gmacs")
Mbase <- lapply(fn, read_admb)
names(Mbase) <- c("SMBKC")
```

# Executive Summary

1. **Stock**: Blue king crab, *Paralithodes platypus*, Saint Matthew Island (SMBKC), Alaska.

2. **Catches**: Peak historical harvest was 9.454 million pounds (4288 tonnes) in 1983/84^[1983/84 refers to a fishing year that extends from 1 July 1983 to 30 June 1984.]. The fishery was closed for 10 years after the stock was declared overfished in 1999. Fishing resumed in 2009/10 with a fishery-reported retained catch of 0.461 million pounds (209 tonnes), less than half the 1.167 million pound (529.3 tonnes) TAC. Following three more years of modest harvests supported by a fishery CPUE of around 10 crab per pot lift, the fishery was again closed in 2013/14 due to declining trawl-survey estimates of abundance and concerns about the health of the stock. The directed fishery resumed again in 2014/15 with a TAC of 0.655 million pounds (300 tonnes), but the fishery performance was relatively poor with the retained catch of 0.309 million pounds (140 tonnes).

3. **Stock biomass**: Following a period of low numbers after the stock was declared overfished in 1999, trawl-survey indices of SMBKC stock abundance and biomass generally increased in subsequent years, with survey estimated mature male biomass reaching 20.98 million pounds (9516 tonnes; CV = 0.55) in 2011, the second highest in the 37-year time series used in this assessment. Survey mature male biomass then declined to 12.46 million pounds (5652 tonnes; CV = 0.33) in 2012 and to 4.459 million pounds (2202 tonnes; CV = 0.22) in 2013 before going back up to 12.06 million pounds (5472 tonnes; CV = 0.44) in 2014 and 11.32 million pounds (5134 tonnes; CV = 0.76).

4. **Recruitment**: Because little information about the abundance of small crab is available for this stock, recruitment has been assessed in terms of the number of male crab within the 90-104 mm CL size class in each year. The 2013 trawl-survey area-swept estimate of 0.335 million male SMBKC in this size class marked a three-year decline and was the lowest since 2005. That decline did not continue with the 2014 survey with an estimate of 0.723 million. The survey recruitment is 0.992 million in 2015, but the majority of them came from one tow with a great deal of uncertainty.

5. **Management performance**: In recent assessments, estimated total male catch has been determined as the sum of fishery-reported retained catch, estimated male discard mortality in the directed fishery, and estimated male bycatch mortality in the groundfish fisheries, as these have been the only sources of non-negligible fishing mortality to consider.

```{r status, results = "asis"}
df <- data.frame(c("2011/12","2012/13","2013/14","2014/15","2015/16"),
                 c(1.5, 1.8, 1.5, 1.86, NA),
                 c(5.03, 2.85, 3.01, 2.48, 2.45),
                 c(1.15, 0.74, 0, 0.3, NA),
                 c(0.85, 0.73, 0, 0.14, NA),
                 c(0.95, 0.82, 0.0003, 0.15, NA),
                 c(1.7, 1.02, 0.56, 0.43, 0.28),
                 c(1.54, 0.92, 0.45, 0.34, 0.22))
names(df) <- c("Year","MSST","Biomass (MMB)","TAC","Retained catch","Total male catch","OFL","ABC")

#M[[2]]$spr_fspr
#M[[2]]$spr_fofl

tab <- xtable(df, caption = "Status and catch specifications (1000 tonnes) (scenario 1). MSST is minimum stock-size threshold, MMB is mature male biomass, TAC is total allowable catch, OFL is over fishing limit, ABC is the annual b catch.", label = "tab:status")
print(tab, caption.placement = "top", include.rownames = FALSE)
```

The stock was above the minimum stock-size threshold (MSST) in 2014/15 and is hence not overfished. Overfishing did not occur.

6. **Basis for the OFL**: Estimated 15 February mature-male biomass ($MMB_\text{mating}$) is used as the measure of biomass for this Tier 4 stock, with males measuring 105 mm CL or more considered mature. The $B_{MSY}$ proxy is obtained by averaging estimated $MMB_\text{mating}$ over a specific reference time period, and current CPT/SSC guidance recommends using the full assessment time frame as the default reference period.


# A. Summary of Major Changes

## Changes in Management of the Fishery

There are no new changes in management of the fishery.

## Changes to the Input Data

All time series used in the assessment have been updated to include the most recent fishery and survey results. This assessment makes use of an updated full trawl-survey time series supplied by R. Foy in August 2015, updated groundfish bycatch estimates based on 1999-2014 NMFS AKRO data also supplied by R. Foy, and the ADF&G pot survey data in 2015.

## Changes in Assessment Methodology

This assessment is done using Gmacs. The model is based upon the 3-stage length-based assessment model first presented in May 2011 by Bill Gaeuman and accepted by the CPT in May 2012. There are several differences between the Gmacs assessment and the previous model. One of the major differences being that natural and fishing mortality are continuous within any number of discrete seasons. Season length in Gmacs is controlled simply by changing the proportion of natural mortality that is applied during each season. For example, in this assessment four seasons are defined and the proportion of natural mortality that is applied each season is 0, 0.44, 0.185, and 0.375 in the final season. In Gmacs the proportion of natural mortality that is applied each season is fixed (i.e. it can not change from year to year). The previous model allowed the proportion of natural mortality to change each year (i.e. during the second season natural mortality ranged from 0.05 to 0.18 before the year 2000 and was constant at 0.44 after 2000).

In Gmacs the size transition matrix is a combination of the growth matrix and the molting probability. The growth matrix is derived from empirical molt increment data and the molting probability for each size class in the model is derived from an inverse logistic curve. Put simply, Gmacs does not allow the user to specify the size transition matrix directly, thus getting our size transition matrix to match that used in the previous model exactly was not possible. However, it is close:

\begin{equation}
  \left[ \begin{array}{ccc}
    0.2056 & 0.6799 & 0.1144 \\
    0 & 0.3963 & 0.6037 \\
    0 & 0 & 1 \end{array} \right]
\end{equation}

Also see Figure \ref{fig:size_trans}. Further details of the Gmacs model and cofiguration used are provided in Appendix A (SMBKC Model Description).

## Changes in Assessment Results

Changes in assessment results depend on model scenario. The Gmacs base model scenario attepmts to match the 2015 assessment by specifying the same (or similar) dynamics and parameter values. However, a different Gmacs scenario (Gmacs selex) provides a much better match to the 2015 model assessment.


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

![Distribution of blue king crab (*Paralithodes platypus*) in the Gulf of Alaska, Bering Sea, and Aleutian Islands waters. Shown in blue.\label{fig:distribution}](figure/Fig1.png)

![King crab Registration Area Q (Bering Sea).\label{fig:registration_area}](figure/Fig2.png)

## Stock Structure

The Alaska Department of Fish and Game (ADF&G) Gene Conservation Laboratory division has detected regional population differences between blue king crab collected from St. Matthew Island and the Pribilof Islands^[NOAA grant Bering Sea Crab Research II, NA16FN2621, 1997.]. NMFS tag-return data from studies on blue king crab in the Pribilof Islands and St. Matthew Island support the idea that legal-sized males do not migrate between the two areas (Otto and Cummiskey 1990). St. Matthew Island blue king crab tend to be smaller than their Pribilof conspecifics, and the two stocks are managed separately.

## Life History

Like the red king crab, *Paralithodes camtshaticus*, the blue king crab is considered a shallow water species by comparison with other lithodids such as golden king crab, *Lithodes aequispinus*, and the scarlet king crab, *Lithodes couesi* (Donaldson and Byersdorfer 2005). Adult male blue king crab are found at an average depth of 70m (NPFMC 1998). The reproductive cycle appears to be annual for the first two reproductive cycles and biennial thereafter (cf. Jensen and Armstrong, 1989) and mature crab seasonally migrate inshore where they molt and mate. Unlike red king crab, juvenile blue king crab do not form pods, but instead rely on cryptic coloration for protection from predators and require suitable habitat such as cobble and shell hash. Somerton and MacIntosh (1983) estimated SMBKC male size at sexual maturity to be 77.0 mm carapace length (CL). Paul et al. (1991) found that spermatophores were present in the vas deferens of 50% of the St. Matthew Island blue king crab males examined with sizes of 40-49 mm CL and in 100% of the males at least 100 mm CL. Spermataphore diameter also increased with increasing CL with an asymptote at ~ 100 mm CL. They noted, however, that although spermataphore presence indicates physiological sexual maturity, it may not be an indicator of functional sexual maturity. For purposes of management of the St. Matthew Island blue king crab fishery, the State of Alaska uses 105 mm CL to define the lower size bound of functionally mature males (Pengilly and Schmidt 1995). Otto and Cummiskey (1990) report an average growth increment of 14.1 mm CL for adult SMBKC males.

## Management History

The SMBKC fishery developed subsequent to baseline ecological studies associated with oil exploration (Otto 1990). Ten U.S. vessels harvested 1.202 million pounds in 1977, and harvests peaked in 1983 when 164 vessels landed 9.454 million pounds (Fitch et al. 2012; Table 1XX). The fishing seasons were generally short, often lasting only a few days. The fishery was declared overfished and closed in 1999 when the stock biomass estimate was below the minimum stock-size threshold (MSST) of 11.0 million pounds as defined by the Fishery Management Plan for the Bering Sea/Aleutian Islands King and Tanner crabs (NPFMC 1999). Zheng and Kruse (2002) hypothesized a high level of SMBKC natural mortality from 1998 to 1999 as an explanation for the low catch per unit effort (CPUE) in the 1998/99 commercial fishery and the low numbers across all male crab size groups caught in the annual NMFS eastern Bering Sea trawl survey from 1999 to 2005 (Table XX2a). In Nov 2000, Amendment 15 to the FMP for Bering Sea/Aleutian Islands king and Tanner crabs was approved to implement a rebuilding plan for the SMBKC stock (NPFMC 2000). The rebuilding plan included a regulatory harvest strategy (5 AAC 34.917), area closures, and gear modifications. In addition, commercial crab fisheries near St. Matthew Island were scheduled in fall and early winter to reduce the potential for bycatch mortality of vulnerable molting and mating crab.

NMFS declared the stock rebuilt on 21 September 2009, and the fishery was reopened after a 10-year closure on 15 October 2009 with a TAC of 1.167 million pounds, closing again by regulation on 1 February 2010. Seven participating vessels landed a catch of 460,859 pounds with a reported effort of 10,697 pot lifts and an estimated CPUE of 9.9 retained number of crab per pot lift. The fishery remained open the next three years with modest harvests and similar CPUE, but large declines in the NMFS trawl-survey estimate of stock abundance raised concerns about the health of the stock, prompting ADF&G to close the fishery again for the 2013/14 season. Due to abundance above thresholds, the fishery was reopened for the 2014/15 season with a low TAC of 0.655 million pounds and in 2015/16 the TAC was further reduced to 0.411 million pounds.

Though historical observer data are limited due to very limited sampling, bycatch of female and sublegal male crab from the directed blue king crab fishery off St. Matthew Island was relatively high historically, with estimated total bycatch in terms of number of crab captured sometimes twice or more as high as the catch of legal crab (Moore et al. 2000; ADF&G Crab Observer Database). Pot-lift sampling by ADF&G crab observers (Gaeuman 2013; ADF&G Crab Observer Database) indicates similar bycatch rates of discarded male crab since the reopening of the fishery (Table 3XX), with total male discard mortality in the 2012/13 directed fishery estimated at about 12% (0.193 million pounds) of the reported retained catch weight, assuming 20% handling mortality. On the other hand, these same data suggest a significant reduction in the bycatch of females, which may be attributable to the later timing of the contemporary fishery and the more offshore distribution of fishery effort since re-opening in 2009/10^[D. Pengilly, ADF&G, pers. comm.]. Some bycatch of discarded blue king crab has also been observed historically in the eastern Bering Sea snow crab fishery, but in recent years it has generally been negligible, and observers recorded no bycatch of blue king crab in sampled pot lifts during 2013/14. The St. Matthew Island golden king crab fishery, the third commercial crab fishery to have taken place in the area, typically occurred in areas with depths exceeding blue king crab distribution. NMFS observer data suggest that variable but mostly limited SMBKC bycatch has also occurred in the eastern Bering Sea groundfish fisheries (Table 5XX).


# D. Data

## Summary of New Information

Data used in this assessment have been updated to include the most recently available fishery and survey numbers. In addition, this assessment makes use of an updated trawl-survey time series provided by R. Foy in August 2015 (new time series), as well as updated 1993-2014 groundfish bycatch estimates based on AKRO data also supplied by R. Foy. The data extent and availability used in each of the Gmacs models is shown in Figure \ref{fig:data_extent}).

```{r data_extent, fig.cap = "Data extent for the SMBKC assessment.\\label{fig:data_extent}"}
plot_datarange(Mbase)
```

## Major Data Sources

Major data sources used in this assessment include annual directed-fishery retained-catch statistics from fish tickets (1978/79-1998/99, 2009/10-2012/13, and 2014/15; Table 1XX); results from the annual NMFS eastern Bering Sea trawl survey (1978-2015; Table 2XX); results from the triennial ADF&G SMBKC pot survey (every third year during 1995-2013) and 2015 pot survey (Table \ref{tab:stage_cpue}); size-frequency information from ADF&G crab-observer pot-lift sampling (1990/91-1998/99, 2009/10-2012/13, and 2014/15; Table XX3); and NMFS groundfish-observer bycatch biomass estimates (1992/93-2014/15; Table XX5). Figure \ref{fig:stations} maps stations from which SMBKC trawl-survey and pot-survey data were obtained. Further information concerning the NMFS trawl survey as it relates to commercial crab species is available in Daly et al. (2014); see Gish et al. (2012) for a description of ADF&G SMBKC pot-survey methods. It should be noted that the two surveys cover different geographic regions and that each has in some years encountered proportionally large numbers of male blue king crab in areas where the other is not represented (Figure \ref{fig:catch181}). Crab-observer sampling protocols are detailed in the crab-observer training manual (ADF&G 2013). Groundfish SMBKC bycatch data come from NMFS Bering Sea reporting areas 521 and 524 (Figure \ref{fig:reporting_areas}). Note that for this assessment the newly available NMFS groundfish observer data reported by ADF&G statistical area was not used.

![Trawl and pot-survey stations used in the SMBKC stock assessment.\label{fig:stations}](figure/Fig3.png)

```{r stage_cpue, results = "asis"}
df <- data.frame(c(1995,1998,2001,2004,2007,2010,2013,2015),
                 c(1.919,0.964,1.266,0.112,1.086,1.326,0.878,0.198),
                 c(3.198,2.763,1.737,0.414,2.721,3.276,1.398,0.682),
                 c(6.922,8.804,5.487,1.141,4.836,5.607,3.367,1.924),
                 c(12.042,12.531,8.477,1.667,8.643,10.209,5.643,2.805),
                 c(0.13,0.06,0.08,0.15,0.09,0.13,0.19,0.18),
                 c(4624,4812,3255,640,3319,3920,2167,1077))
names(df) <- c("Year","Stage-1 (90-104 mm)","Stage-2 (105-119 mm)","Stage-3 (120+ mm)","Total CPUE","CV","Number of crabs")
tab <- xtable(df, caption = "Size-class and total CPUE (90+ mm CL) with estimated CV and total number of captured crab (90+ mm CL) from the 96 common stations surveyed during the six triennial ADF\\&G SMBKC pot surveys. Source: D. Pengilly and R. Gish, ADF\\&G.", label = "tab:stage_cpue", digits = c(0,0,3,3,3,3,2,0))
print(tab, caption.placement = "top", include.rownames = FALSE)
```

## Other Data Sources

As with the most recent model configuration developed for this assessment, this version makes use of a growth transition matrix based on Otto and Cummiskey (1990). Other relevant data sources, including assumed population and fishery parameters, are presented in Appendix A, which provides a detailed description of the base-model configuration used for the 2012 and 2013 assessments.

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

Four model scenarios were considered. In this document results from these models and the 2015 model are compared.

1. **2015 Model**: model output from 2015 provided by Jie.

2. **Gmacs base**: tries to match as closely as possible the 2015 Model.

3. **Gmacs selex**: directed pot, NMFS trawl survey and ADF&G pot survey selectivities are estimated for stage-1 and stage-2 crab.

4. **Gmacs CV**: Additional CV is estimated for the ADF&G pot survey.

5. **Gmacs M**: Natural mortality ($M$) is fixed at 0.18 $yr^{-1}$ during all years.

## Results

Preliminary results for the Gmacs configuration are provided here with comparisons to the 2015 model.

a. Effective sample sizes.

Observed and estimated effective sample sizes are compared in Table XX.

b. Tables of estimates.

Model parameter estimates are summarized in Tables \ref{tab:est_pars_base}, \ref{tab:est_pars_selex}. Negative log likelihood values and management measures for the four Gmacs scenarios are compared in Table \ref{tab:likelihood_components}. Estimated abundances by stage and mature male biomasses are listed in Table XX for four scenarios.

Generally, scenarios with different molting probabilities or survey selectivities for two periods fit the data better. Scenarios with additional CV for the pot survey CPUE fit the trawl survey data better and result in higher abundance and biomass estimates in most recent years. Like the results in May 2015, large differences exist for estimated molting probabilities or survey selectivities during the two periods. Plausible biological reasons have not yet been found to explain large differences in molting probabilities. Estimated trawl survey selectivities > 1.0 for both stages 1 and 2 during 2000-2015 are also troublesome, but might be possible due to changes in crab spatial distributions, based on the examination on pot survey data presented by Doug Pengilly to the CPT in May 2015. Differences of estimated trawl survey selectivities between two periods decrease with scenarios 10-4, 10-3, 10-2, and 10-0. The high estimated trawl survey selectivities imply that the catchability of trawl surveys during recent years is greater than the assumed value of 1.0.

c. Graphs of estimates.

Estimated (and fixed) selectivities are compared in Figure \ref{fig:selectivity} and molting probabilities are shown in Figure \ref{fig:molt_prob}. The various model fits to total male ($>$ 89 mm CL) trawl survey biomass are compared in Figure \ref{fig:trawl_survey_biomass}, and the fits to pot survey CPUE are compared in Figure \ref{fig:pot_survey_cpue}. Standardized residuals of total male trawl survey biomass and pot survey CPUE are plotted in Figure \ref{fig:bts_resid}. Fits to stage compositions for trawl survey, pot survey, and commercial observer data are shown in Figures \ref{fig:sc_pot}, \ref{fig:sc_pot_discarded}, and \ref{fig:sc_trawl_discarded} for the all scenarios. Bubble plots of stage composition residuals for trawl survey, pot survey, and commercial observer data are shown in Figures \ref{fig:sc_pot_res}, \ref{fig:sc_pot_discarded_res}, and \ref{fig:sc_trawl_discarded_res} for the Gmacs base model. Fits to retained catch biomass and bycatch death biomass are shown for all scenarios in Figure \ref{fig:fit_to_catch}. Estimated recruitment and mature male biomass are compared in Figures \ref{fig:recruitment} and \ref{fig:mmb}, respectively.

Estimated trawl survey selectivities and molting probabilities are generally confounded. For example, the estimated lower molting probabilities after 1999 are associated with lower trawl survey selectivity estimates for scenario 8, and the assumed higher molting probabilities result in higher estimated trawl survey selectivities for scenario 10 (Figures XX and XX; Table XX). To reduce the confounding, molting probabilities are fixed at the values estimated from tagging data during the same period for scenarios 9, 10, and 11.

d. Graphic evaluation of the fit to the data.

Model estimated relative survey biomasses are different in each of the scenarios. Scenarios T, 0, 00, and 1 have relatively high biomass in the early period and during recent years (Figure \ref{fig:trawl_survey_biomass}). Scenarios 2 and 3 with constant molting probabilities and trawl survey selectivities over time and with an additional CV for the pot survey CPUE result in much higher biomass estimates in recent years; the trend of the biomass estimates also differ from other scenarios (Figure XX). Estimated pot survey CPUEs are also dependent on scenarios, and the difference among scenarios are very similar to the relative survey biomasses (Figure \ref{fig:pot_survey_cpue}).

There are strong temporal patterns for residuals of total trawl survey biomass and stage composition data for scenarios T, 0, 00, 1, 2, and 3 (showing only scenario 3), and no apparent residual patterns occur for other scenarios with two levels of trawl selectivities or molting probabilities over time (Figures XX and XX). The stage compositions for observer data were not fit very well before 2000 for all scenarios, because the data are low quality and effective sample size is assumed small accordingly. The absolute values of standardized residuals of survey biomass are relatively smaller for scenarios 10-4, 10-3, 10-2, and 10-0 than those for scenario 10 (Figure XX). All scenarios fit well to retained catch biomass and fits to bycatch biomass are generally good.

Estimated recruitment to the model is variable over time (Figure \ref{fig:recruitment}). Estimated recruitment during recent years is generally low in all scenarios. Estimated mature male biomasses on 15 February also fluctuates strongly over time; the high biomass estimates in recent years for scenarios 2 and 3 show an opposite trend from the other scenarios (Figure \ref{fig:mmb}).

e. Retrospective and historic analyses.

Gmacs does can not do retrospective analysis yet.

f. Uncertainty and sensitivity analyses.

Estimated standard deviations of parameters are summarized in Table 9XX for six scenarios. Probabilities for mature male biomass and OFL in 2015 are illustrated in the section “F. Calculation of the OFL”

g. Comparison of alternative model scenarios.


# F. Calculation of the OFL and ABC

The overfishing level (OFL) is the fishery-related mortality biomass associated with fishing mortality $F_{OFL}$. The SMBKC stock is currently managed as Tier 4 (2013 SAFE), and only a Tier 4 analysis is presented here. Thus given stock estimates or suitable proxy values of $B_{MSY}$ and $F_{MSY}$, along with two additional parameters $\alpha$ and $\beta$, $F_{OFL}$ is determined by the control rule

\begin{align}
    F_{OFL} &= 
    \begin{cases}
        F_{MSY}, &\text{ when } B/B_{MSY} > 1\\
        F_{MSY} \frac{\left( B/B_{MSY} - \alpha \right)}{(1 - \alpha)}, &\text{ when } \beta < B/B_{MSY} \le 1
    \end{cases}\\
    F_{OFL} &< F_{MSY} \text{ with directed fishery } F = 0, \text{ when } B/B_{MSY} \le \beta \notag
\end{align}

where $B$ is quantified as mature-male biomass $MMB_\text{mating}$, at mating with time of mating assigned a nominal date of 15 February. Note that as $B$ itself is a function of the fishing mortality $F_{OFL}$, in case b) numerical approximation of $F_{OFL}$ is required. As implemented for this assessment, all calculations proceed according to the model equations given in Appendix A. In particular, the OFL catch is computed using equations A3, A4, and A5, with $F_{OFL}$ taken to be full-selection fishing mortality in the directed pot fishery and groundfish trawl and fixed-gear fishing mortalities set at their model geometric mean values over years for which there are data-based estimates of bycatch-mortality biomass.

The currently recommended Tier 4 convention is to use the full assessment period, currently `r M[[2]]$syr`-`r M[[2]]$nyr`, to define a $B_{MSY}$ proxy in terms of average estimated $MMB_\text{mating}$ and to put $\gamma$ = 1.0 with assumed stock natural mortality $M$ = 0.18 $\text{yr}^{-1}$ in setting the $F_{MSY}$ proxy value $\gamma M$. The parameters $\alpha$ and $\beta$ are assigned their default values $\alpha$ = 0.10 and $\beta$ = 0.25. The $F_{OFL}$, OFL, and MMB in 2015 for 18 scenarios are summarized in Table 10XX. ABC is 80% of the OFL.

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

```{r est_pars_base, results = "asis"}
x <- M[[2]]$fit
i <- c(grep("m_dev", x$names)[1],
       grep("theta", x$names),
       grep("survey_q", x$names),
       grep("log_fbar", x$names))
#i <- grep("rec_dev", x$names)
Parameter <- x$names[i]
Estimate <- x$est[i]
SD <- x$std[i]
Parameter <- c("Natural mortality ($M$) deviation in 1998","$\\log (R_0)$","$\\log (\\bar{R})$","$\\log (N_1)$","$\\log (N_2)$","$\\log (N_3)$","ADF\\&G pot survey catchability ($q$)","$\\bar{F}_\\text{pot}$","$\\bar{F}_\\text{trawl bycatch}$","$\\bar{F}_\\text{fixed bycatch}$")
df <- data.frame(Parameter, Estimate, SD)
tab <- xtable(df, caption = "Model parameter estimates and standard deviations for the {\\bf Gmacs base} model.", label = "tab:est_pars_base", digits = 7)
print(tab, caption.placement = "top", include.rownames = FALSE, sanitize.text.function = function(x){x})
```

```{r est_pars_selex, results = "asis"}
x <- M[[3]]$fit
i <- c(grep("m_dev", x$names)[1],
       grep("theta", x$names),
       grep("survey_q", x$names),
       grep("log_fbar", x$names),
       grep("log_slx_pars", x$names))
Parameter <- x$names[i]
Estimate <- x$est[i]
SD <- x$std[i]
Parameter <- c("Natural mortality ($M$) deviation in 1998","$\\log (R_0)$","$\\log (\\bar{R})$","$\\log (N_1)$","$\\log (N_2)$","$\\log (N_3)$","ADF\\&G pot survey catchability ($q$)","$\\log(\\bar{F}_\\text{pot})$","$\\log(\\bar{F}_\\text{trawl bycatch})$","$\\log(\\bar{F}_\\text{fixed bycatch})$",
               "Stage-1 directed pot selectivity 1978-2008","Stage-2 directed pot selectivity 1978-2008","Stage-1 directed pot selectivity 2009-2015","Stage-2 directed pot selectivity 2009-2015","Stage-1 NMFS trawl selectivity","Stage-2 NMFS trawl selectivity","Stage-1 ADF\\&G pot selectivity","Stage-2 ADF\\&G pot selectivity")
df <- data.frame(Parameter, Estimate, SD)
tab <- xtable(df, caption = "Model parameter estimates and standard deviations for the {\\bf Gmacs selex} model that estimates stage-1 and stage-2 selectivity.", label = "tab:est_pars_selex", digits = 7)
print(tab, caption.placement = "top", include.rownames = FALSE, sanitize.text.function = function(x){x})
```

```{r est_pars_cv, results = "asis"}
x <- M[[4]]$fit
i <- c(grep("m_dev", x$names)[1],
       grep("theta", x$names),
       grep("survey_q", x$names),
       grep("log_add_cv", x$names),
       grep("log_fbar", x$names),
       grep("log_slx_pars", x$names))
Parameter <- x$names[i]
Estimate <- x$est[i]
SD <- x$std[i]
Parameter <- c("Natural mortality ($M$) deviation in 1998","$\\log (R_0)$","$\\log (\\bar{R})$","$\\log (N_1)$","$\\log (N_2)$","$\\log (N_3)$",
               "ADF\\&G pot survey catchability ($q$)","logAddCV","$\\log(\\bar{F}_\\text{pot})$","$\\log(\\bar{F}_\\text{trawl bycatch})$","$\\log(\\bar{F}_\\text{fixed bycatch})$",
               "Stage-1 directed pot selectivity 1978-2008","Stage-2 directed pot selectivity 1978-2008","Stage-1 directed pot selectivity 2009-2015","Stage-2 directed pot selectivity 2009-2015","Stage-1 NMFS trawl selectivity","Stage-2 NMFS trawl selectivity","Stage-1 ADF\\&G pot selectivity","Stage-2 ADF\\&G pot selectivity")
df <- data.frame(Parameter, Estimate, SD)
tab <- xtable(df, caption = "Model parameter estimates and standard deviations for the {\\bf Gmacs CV} model that estimates stage-1 and stage-2 selectivity.", label = "tab:est_pars_cv", digits = 7)
print(tab, caption.placement = "top", include.rownames = FALSE, sanitize.text.function = function(x){x})
```

```{r est_pars_M, results = "asis"}
x <- M[[5]]$fit
i <- c(grep("theta", x$names),
       grep("survey_q", x$names),
       grep("log_fbar", x$names),
       grep("log_slx_pars", x$names))
Parameter <- x$names[i]
Estimate <- x$est[i]
SD <- x$std[i]
Parameter <- c("$\\log (R_0)$","$\\log (\\bar{R})$","$\\log (N_1)$","$\\log (N_2)$","$\\log (N_3)$","ADF\\&G pot survey catchability ($q$)","$\\log(\\bar{F}_\\text{pot})$","$\\log(\\bar{F}_\\text{trawl bycatch})$","$\\log(\\bar{F}_\\text{fixed bycatch})$",
               "Stage-1 directed pot selectivity 1978-2008","Stage-2 directed pot selectivity 1978-2008","Stage-1 directed pot selectivity 2009-2015","Stage-2 directed pot selectivity 2009-2015","Stage-1 NMFS trawl selectivity","Stage-2 NMFS trawl selectivity","Stage-1 ADF\\&G pot selectivity","Stage-2 ADF\\&G pot selectivity")
df <- data.frame(Parameter, Estimate, SD)
tab <- xtable(df, caption = "Model parameter estimates and standard deviations for the {\\bf Gmacs M} model that estimates stage-1 and stage-2 selectivity.", label = "tab:est_pars_M", digits = 7)
print(tab, caption.placement = "top", include.rownames = FALSE, sanitize.text.function = function(x){x})
```

```{r likelihood_components, results = "asis"}
df <- NULL
for (ii in 2:5)
{
    x <- M[[ii]]
    # Catch
    ll_catch <- x$nloglike[1,]
    dc <- .get_catch_df(Mbase)
    names(ll_catch) <- unique(paste0(dc$fleet, " ", dc$type, " Catch"))
    # Abundance indices
    ll_cpue <- x$nloglike[2,1:2]
    names(ll_cpue) <- c("NMFS Trawl Survey","ADF&G Pot Survey CPUE")
    # Size compositions
    ll_lf <- x$nloglike[3,1:3]
    names(ll_lf) <- c("Directed Pot LF","NMFS Trawl LF","ADF&G Pot LF")
    # Recruitment deviations
    ll_rec <- sum(x$nloglike[4,], na.rm = TRUE)
    names(ll_rec) <- "Recruitment deviations"
    # Penalties
    F_pen <- x$nlogPenalty[2]; names(F_pen) <- "F penalty"
    M_pen <- x$nlogPenalty[3]; names(M_pen) <- "M penalty"
    # Priors
    prior <- sum(x$priorDensity); names(prior) <- "Prior"
    v <- c(ll_catch, ll_cpue, ll_lf, ll_rec, F_pen, M_pen, prior)
    sv <- sum(v); names(sv) <- "Total"
    npar <- x$fit$npar; names(npar) <- "Total estimated parameters"
    mmb <- x$ssb[length(x$ssb)]; names(mmb) <- paste0("MMB", x$mod_yrs[length(x$mod_yrs)])
    fofl <- x$spr_fofl; names(fofl) <- "Fofl"
    v <- c(v, sv, npar, mmb, fofl)
    df <- cbind(df, v)
}
df <- data.frame(rownames(df), df, row.names = NULL)
names(df) <- c("Component","Gmacs base","Gmacs selex","Gmacs CV","Gmacs M")

tab <- xtable(df, caption = "Comparisons of negative log-likelihood values and management measures for the four Gmacs model scenarios. Biomass and OFL are in tonnes.", label = "tab:likelihood_components")
print(tab, caption.placement = "top", include.rownames = FALSE)
```

```{r pop_abundance_2015, results = "asis"}
A <- M[[1]]
df <- data.frame(Year = as.integer(A$mod_yrs), N1 = A$d4_N[seq(5,156,4),1], N2 = A$d4_N[seq(5,156,4),2], N3 = A$d4_N[seq(5,156,4),3], MMB = A$ssb)
tab <- xtable(df, digits = 0, caption = "Population abundances (N) by crab stage in numbers of crab and mature male biomass (MMB) at survey in tonnes on 15 February for the 2015 model. All abundances are at time of survey (season 1).", label = "tab:pop_abundance_2015")
print(tab, caption.placement = "top", include.rownames = FALSE ,format.args = list(big.mark = c("",",",",",",","," )) )
```

```{r pop_abundance_base, results = "asis"}
A <- M[[2]]
df <- data.frame(Year = as.integer(A$mod_yrs), N1 = A$d4_N[seq(5,156,4),1], N2 = A$d4_N[seq(5,156,4),2], N3 = A$d4_N[seq(5,156,4),3], MMB = A$ssb)
tab <- xtable(df, digits = 0, caption = "Population abundances (N) by crab stage in numbers of crab, mature male biomass (MMB) at survey in tonnes on 15 February for the Gmacs base model. All abundances are at time of survey (season 1).", label = "tab:pop_abundance_base")
print(tab, caption.placement = "top", include.rownames = FALSE ,format.args = list(big.mark = c("",",",",",",","," )) )
```

```{r pop_abundance_selex, results = "asis"}
A <- M[[3]]
df <- data.frame(Year = as.integer(A$mod_yrs), N1 = A$d4_N[seq(5,156,4),1], N2 = A$d4_N[seq(5,156,4),2], N3 = A$d4_N[seq(5,156,4),3], MMB = A$ssb)
tab <- xtable(df, digits = 0, caption = "Population abundances (N) by crab stage in numbers of crab, mature male biomass (MMB) at survey in tonnes on 15 February for scenario 1. All abundances are at time of survey (season 1).", label = "tab:pop_abundance_selex")
print(tab, caption.placement = "top", include.rownames = FALSE ,format.args = list(big.mark = c("",",",",",",","," )) )
```

\newpage\clearpage

![Catches of 181 male blue king crab measuring at least 90 mm CL from the 2014 NMFS trawl-survey at the 56 stations used to assess the SMBKC stock. Note that the area north of St. Matthew Island, which includes the large catch of 67 crab at station R-24, is not represented in the ADF&G pot-survey data used in the assessment.\label{fig:catch181}](figure/Fig4.png)

![NFMS Bering Sea reporting areas. Estimates of SMBKC bycatch in the groundfish fisheries are based on NMFS observer data from reporting areas 524 and 521.\label{fig:reporting_areas}](figure/Fig5.png)

```{r ADFG_pot_1998_s1, fig.cap = "ADF&G 1998 pot survey catch of male blue king crab $\\ge$ 90 mm CL for the 10 standard (Stratum 1) stations fished during 17–19 August 1998 within NMFS trawl survey station R-24.  Size (area) of circle is proportional to catch (largest = 43 crab). Black circles denote catch at a station was greater than the average catch for the 10 stations (10 crab); white circles denote catch at a station was less than the average catch for the 10 stations. Red circle is the centroid (\"center of gravity\") of distribution computed from the 10 stations. Red X is midpoint of the NMFS trawl survey tow performed in R-24 on 20 July 1998.\\label{fig:ADFG_pot_1998_s1}", fig.height = 5}
knitr::include_graphics("figure/Fig6a.png")
```

```{r ADFG_pot_2013_s1, fig.cap = "ADF&G 2013 pot survey catch of male blue king crab $\\ge$ 90 mm CL for the 10 standard (Stratum 1) stations fished during 21–25 September 2013 within NMFS trawl survey station R-24.  Size (area) of circle is proportional to catch (largest = 76 crab). Black circles denote catch at a station was greater than the average catch for the 10 stations (17 crab); white circles denote catch at a station was less than the average catch for the 10 stations. Red circle is the centroid (\"center of gravity\") of distribution computed from the 10 stations. Red X is midpoint of the NMFS trawl survey tow performed in R-24 on 12 July 2013.\\label{fig:ADFG_pot_2013_s1}", fig.height = 5}
knitr::include_graphics("figure/Fig6b.png")
```

```{r ADFG_pot_2013_s2, fig.cap = "ADF&G 2013 pot survey catch of male blue king crab $\\ge$ 90 mm CL for the 20 special (Stratum 2) stations fished during 20–25 September 2013 within NMFS trawl survey station R-24.  Size (area) of circle is proportional to catch (largest = 63 crab). Black circles denote catch at a station was greater than the average catch for the 20 stations (17 crab); white circles denote catch at a station was less than the average catch for the 20 stations. Red circle is the centroid (\"center of gravity\") of distribution computed from the 20 stations. Red X is midpoint of the NMFS trawl survey tow performed in R-24 on 12 July 2013.\\label{fig:ADFG_pot_2013_s2}", fig.height = 5}
knitr::include_graphics("figure/Fig6c.png")
```

```{r without_R24, fig.cap = "Comparisons of area-swept estimates of male (>89 mm CL) abundance with and without trawl survey station R-24 for St. Matthew Island blue king crab.\\label{fig:without_R24}"}
knitr::include_graphics("figure/Fig7a.png")
```

```{r without_R24_375, fig.cap = "Comparisons of area-swept estimates of male (>89 mm CL) abundance without trawl survey station R-24 and with a reduction factor of 0.4*(401-25)/401 (or 37.5%) applied to station R-24 for St. Matthew Island blue king crab.\\label{fig:without_R24_375}"}
knitr::include_graphics("figure/Fig7b.png")
```

\newpage\clearpage

```{r selectivity, fig.cap = "Estimated stage-1 and stage-2 selectivities for each of the different model scenarios (the stage-3 selectivities are all fixed at 1). Estimated selectivities are shown for the directed pot fishery, the trawl bycatch fishery, the fixed bycatch fishery, the NMFS trawl survey, and the ADF&G pot survey. Two selectivity periods are estimated in the directed pot fishery, from 1978-2008 and 2009-2015.\\label{fig:selectivity}", fig.height = 15}
plot_selectivity(M, ncol = 5)
```

```{r molt_prob, fig.cap = "Molting probabilities by stage used in each of the Gmacs model scenarios. The 2015 model did not use a molting probabilty curve directly (the size transition matrix was specified instead).\\label{fig:molt_prob}"}
plot_molt_prob(Mbase, xlab = "Carapace width (mm)")
```

\newpage\clearpage

```{r trawl_survey_biomass, fig.cap = "Comparisons of area-swept estimates of total male survey biomass (tonnes) and model predictions for the 2015 and 2016 Gmacs model. The error bars are plus and minus 2 standard deviations.\\label{fig:trawl_survey_biomass}"}
plot_cpue(M, "NMFS Trawl", ylab = "Survey biomass (tonnes)")
```

```{r pot_survey_cpue, fig.cap = "Comparisons of total male pot survey CPUEs and model predictions for 2016 model estimates without additional CV for the pot survey CPUE. The error bars are plus and minus 2 standard deviations.\\label{fig:pot_survey_cpue}"}
plot_cpue(M, "ADF&G Pot", ylab = "Pot survey CPUE (crab/potlift)")
```

```{r bts_resid, fig.cap = "Standardized residuals for area-swept estimates of total male survey biomass and total male pot survey CPUEs for Gmacs configuration. \\label{fig:bts_resid}"}
A <- M; A[[jj]] <- NULL
plot_cpue_res(A)
```

\newpage\clearpage

```{r sc_pot, fig.cap = "Observed and model estimated size-frequencies of male BBRKC by year retained in the directed pot fishery.\\label{fig:sc_pot}"}
plot_size_comps(M, 1)
```

```{r sc_pot_discarded, fig.cap = "Observed and model estimated size-frequencies of discarded male BBRKC by year in the NMFS trawl survey.\\label{fig:sc_pot_discarded}"}
plot_size_comps(M, 2)
```

```{r sc_trawl_discarded, fig.cap = "Observed and model estimated size-frequencies of discarded female BBRKC by year in the ADF&G pot survey.\\label{fig:sc_trawl_discarded}"}
plot_size_comps(M, 3)
```

```{r sc_pot_res, fig.cap = "Bubble plots of residuals by stage and year for the directed pot fishery size composition data for St. Mathew Island blue king crab (SMBKC).\\label{fig:sc_pot_res}"}
#A <- M; A[[jj]] <- NULL
#plot_size_comps(A, 1, res = TRUE)
plot_size_comps(Mbase, 1, res = TRUE)
```

```{r sc_pot_discarded_res, fig.cap = "Bubble plots of residuals by stage and year for the NMFS trawl survey size composition data for St. Mathew Island blue king crab (SMBKC).\\label{fig:sc_pot_discarded_res}"}
#plot_size_comps(A, 2, res = TRUE)
plot_size_comps(Mbase, 2, res = TRUE)
```

```{r sc_trawl_discarded_res, fig.cap = "Bubble plots of residuals by stage and year for the ADF&G pot survey size composition data for St. Mathew Island blue king crab (SMBKC).\\label{fig:sc_trawl_discarded_res}"}
#plot_size_comps(A, 3, res = TRUE)
plot_size_comps(Mbase, 3, res = TRUE)
```

\newpage\clearpage

```{r fit_to_catch, fig.cap = "Comparison of observed and model predicted retained catch and bycatches in each of the Gmacs models. Note that difference in units between each of the panels.\\label{fig:fit_to_catch}"}
A <- M; A[[jj]] <- NULL
plot_catch(A)
```

```{r recruitment, fig.cap = "Estimated recruitment time series during 1979-2015 with 18 scenarios. Estimated recruitment time series ($R_t$) in the OneSex, TwoSex and BBRKC models. Note that recruitment in the OneSex model represents recruitment of males only.\\label{fig:recruitment}"}
plot_recruitment(M)
```

```{r mature_male_biomass, fig.cap = "Estimated mature male biomass (MMB) time series on 15 February during 1978-2015 for each of the model scenarios.\\label{fig:mmb}"}
plot_ssb(M, ylab = "Mature male biomass (tonnes) on 15 February")
```

```{r length_weight, fig.cap = "Relationship between carapace width (mm) and weight (kg) by sex in each of the models (provided as a vector of weights at length to Gmacs).\\label{fig:length-weight}"}
plot_length_weight(Mbase, xlab = "Carapace width (mm)", ylab = "Weight (kg)")
```

```{r init_rec, fig.cap = "Distribution of carapace width (mm) at recruitment.\\label{fig:init_rec}"}
plot_recruitment_size(M, xlab = "Carapace width (mm)")
```

```{r growth_inc, fig.cap = "Growth increment (mm) each molt by sex in the OneSex and TwoSex models.\\label{fig:growth_inc}"}
plot_growth_inc(Mbase)
```

```{r growth_trans, fig.cap = "Probability of growth transition by stage. Each of the panels represent the stage before growth. The x-axes represent the stage after a growth (ignoring the probability of molting).\\label{fig:growth_trans}"}
plot_growth_transition(Mbase, xlab = "Carapace width (mm)")
```

```{r size_trans, fig.cap = "Probability of size transition by stage (i.e. the combination of the growth matrix and molting probabilities). Each of the panels represent the stage before a transition. The x-axes represent the stage after a transition.\\label{fig:size_trans}"}
A <- M; A[[5]] <- NULL; A[[4]] <- NULL; A[[3]] <- NULL
plot_size_transition(A, xlab = "Carapace width after transition (mm)")
```

```{r init_N, fig.cap = "Numbers at length in 1953, 1975 and 2014 in each of the models. The first year of the OneSex model is 1953. The first year of the Zheng and TwoSex models in 1975.\\label{fig:init_N}"}
#plot_numbers(M, c("1977","1980","1990","2000","2010","2015"))
plot_numbers(M)
```

```{r natural_mortality, fig.cap = "Time-varying natural mortality ($M_t$). Estimated pulse period occurs in 1998 (i.e. $M_{1998}$). \\label{fig:M_t}"}
plot_natural_mortality(M, knots = NULL, slab = "Model")
```


\newpage\clearpage

# Appendix A: SMBKC Model Description

## 1. Introduction

The Gmacs model has been specified to account only for male crab at least 90 mm in carapace length (CL). These are partitioned into three stages (size-classes) determined by CL measurements of (1) 90-104 mm, (2) 105-119 mm, and (3) 120+ mm. For management of the St. Matthew Island blue king crab (SMBKC) fishery, 120 mm CL is used as the proxy value for the legal measurement of 5.5 mm in carapace width (CW), whereas 105 mm CL is the management proxy for mature-male size (5 AAC 34.917 (d)). Accordingly, within the model only stage-3 crab are retained in the directed fishery, and stage-2 and stage-3 crab together comprise the collection of mature males. Some justification for the 105 mm value is presented in Pengilly and Schmidt (1995), who used it in developing the current regulatory SMBKC harvest strategy. The term “recruit” here designates recruits to the model, i.e., annual new stage-1 crab, rather than recruits to the fishery. The following description of model structure reflects the Gmacs base model configuration.

## 2. Model Population Dynamics

Within the model, the beginning of the crab year is assumed contemporaneous with the NMFS trawl survey, nominally assigned a date of 1 July. With boldface lowercase letters indicating vector quantities we designate the vector of stage abundances during season $t$ and year $y$ as
\begin{equation}
    \boldsymbol{n}_{t,y} = \left[ n_{1,t,y}, n_{2,t,y}, n_{3,t,y} \right]^\top.
\end{equation}
Using boldface uppercase letters to indicate a matrix, we describe the size transition matrix $\boldsymbol{G}_t$ during season $t$ as
\begin{equation}
  \boldsymbol{G}_t = \left[ \begin{array}{ccc}
    1 - \pi_{12} - \pi_{13} & \pi_{12} & \pi_{13} \\
    0 & 1 - \pi_{23} & \pi_{23} \\
    0 & 0 & 1 \end{array} \right],
\end{equation}
with $\pi_{jk}$ equal to the proportion of stage-$j$ crab that molt and grow into stage-$k$ within a season or year. Similarly, the survival matrix $\boldsymbol{S}_{t,y}$ during season $t$ and year $y$ is
\begin{equation}
  \boldsymbol{S} = \left[ \begin{array}{ccc}
    1-e^{-Z_{1,t,y}} & 0 & 0 \\
    0 & 1-e^{-Z_{2,t,y}} & 0 \\
    0 & 0 & 1-e^{-Z_{3,t,y}} \end{array} \right],
\end{equation}
where $Z_{l,t,y}$ represents the combination of natural mortality $M_{t,y}$ and fishing mortality $F_{t,y}$ during season $t$ and year $y$. The number of new crab, or recruits, of each stage entering the model each season $t$ and year $y$ is represented as the vector $\boldsymbol{r}_{t,y}$ and may be defined using an inverse logistic curve
\begin{equation}
    \boldsymbol{r}_{t,y} = ...
\end{equation}
In this formulation of the model, all recruits are assumed to be to stage-1. The basic population dynamics underlying Gmacs can thus be described as
\begin{align}
    \boldsymbol{n}_{t+1,y} &= \boldsymbol{G}_t \boldsymbol{S}_{t,y} \boldsymbol{n}_{t,y} + \boldsymbol{r}_{t,y}, \text{ if } t<T \notag\\
    \boldsymbol{n}_{t,y+1} &= \boldsymbol{G}_t \boldsymbol{S}_{t,y} \boldsymbol{n}_{t,y} + \boldsymbol{r}_{t,y}, \text{ if } t=T
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

Estimated parameters with scenarios 8 and 10 are listed in Table 2XX and include an estimated parameter for natural mortality ($M$) in 1998/99 assuming of an anomalous mortality event in that year, as hypothesized by Zheng and Kruse (2002), with natural mortality otherwise fixed at 0.18 $\text{yr}^{-1}$.

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

Both surveys are assigned a nominal date of 1 July, the start of the crab year. The directed fishery is treated as a season midpoint pulse. Groundfish bycatch is likewise modeled as a pulse effect, occurring at the nominal time of mating, Feb 15, which is also the reference date for calculation of federal management biomass quantities.

```{r limits_pars, results = "asis"}
Parameter <- c("$Mdev_{1998}$", "$\\log (R_0)$","$\\log (\\bar{R})$",
               "$\\log (N_1)$","$\\log (N_2)$","$\\log (N_3)$",
               "$q_{pot}$",
               "Add CV ADFG pot",
               "Stage-1 1978-2008","Stage-2 1978-2008","Stage-1 2009-2015","Stage-2 2009-2015",
               "Stage-1 NMFS","Stage-2 NMFS","Stage-1 ADFG","Stage-2 ADFG")
ival <- c(0,14.3,10,14,14,14,3.98689,0.0001,0.416198,0.657528,0.326889,0.806548,0.655565,0.912882,0.347014,0.720493)
LB <- c(0,-7,-7,5,5,5,0,0.00001,0.001,0.001,0.001,0.001,0.001,0.001,0.001,0.001)
UB <- c(NA,30,20,15,15,15,5,10,2,2,2,2,2,2,2,2)
prior <- c("Random walk","Uniform","Uniform","Uniform","Uniform","Uniform","Uniform","Gamma","Uniform","Uniform","Uniform","Uniform","Uniform","Uniform","Uniform","Uniform")
p1 <- c(0,-7,-7,5,5,5,0,1,0.001,0.001,0.001,0.001,0.001,0.001,0.001,0.001)
p2 <- c(10,30,20,15,15,15,5,100,2,2,2,2,2,2,2,2)
phz <- c(2,2,1,1,1,1,4,4,4,4,4,4,4,4,4,4)
df <- data.frame(Parameter, LB, ival, UB, prior, p1, p2, phz)
names(df) <- c("Parameter","LB","Initial value","UB","Prior type","Prior par1","Prior par2","Phase")
tab <- xtable(df, caption = "Model bounds, initial values, priors and estimation phase.", label = "tab:bounds_pars", digits = c(1,0,0,1,0,0,0,0,0))
print(tab, caption.placement = "top", include.rownames = FALSE, sanitize.text.function = function(x){x})
```


## 5. Model Objective Function and Weighting Scheme

The objective function consists of a sum of eight "negative loglikelihood" terms characterizing the hypothesized error structure of the principal data inputs with respect to their true, i.e., model-predicted, values and four "penalty" terms associated with year-to-year variation in model recruit abundance and fishing mortality in the directed fishery and groundfish trawl and fixed-gear fisheries. See Table \ref{tab:stage_cpue}, where upper and lower case letters designate model-predicted and data-computed quantities, respectively, and boldface letters again indicate vector quantities. Sample sizes $n_t$ (observed number of male SMBKC $\le$ 90 mm CL) and estimated coefficients of variation $\widehat{cv}_t$ were used to develop appropriate variances for stage-proportion and abundance-index components. The weights $\lambda_j$ appearing in the objective function component expressions in Table \ref{tab:stage_cpue} play the role of "tuning" parameters in the modeling procedure.

Table 4XX. Loglikelihood and penalty components of base-model objective function. The $\lambda_k$ are weights, described in text; the neff t are effective sample sizes, also described in text. All summations are with respect to years over each data series.

| Component | Distribution | Form |
|-----------|--------------|------|
| Legal retained-catch biomass | Lognormal | $-0.5 \sum \left( \log (c_t/C_t)^2 / \log (1+cv^2_c) \right)$ |
| Dis. Pot bycatch biomass | Lognormal | |



## 6. Estimation

The model was implemented using the software AD Model Builder (Fournier et al. 2012), with parameter estimation by minimization of the model objective function using automatic differentiation. Parameter estimates and standard deviations provided in this document are AD Model Builder reported values assuming maximum likelihood theory asymptotics.

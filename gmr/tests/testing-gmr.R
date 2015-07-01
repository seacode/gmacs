#require(devtools)
#devtools::install_github("seacode/gmacs", subdir = "/gmr", ref = "develop")
require(gmr)
source("reload.R")
reload()

# ----------------------------------------------------------------------------- #
# OneSex
# ----------------------------------------------------------------------------- #
.MODELDIR = c("../../examples/bbrkc/OneSex/")
.OVERLAY  = TRUE
.SEX      = c("Aggregate","Male")
.FLEET    = c("Pot","Trawl bycatch","NMFS Trawl","BSFRF")
.TYPE     = c("Retained & Discarded","Retained","Discarded")
.SHELL    = c("Aggregate","New Shell","Old Shell")
.MATURITY = c("Aggregate","Immature","Mature")
.THEME    = theme_bw(base_size = 12, base_family = "")
.SEAS     = c("Annual")

fn       <- paste0(.MODELDIR, "gmacs")
M        <- lapply(fn, read_admb)
names(M) <- basename(.MODELDIR)
length(M)

sum(M[[1]]$nloglike, na.rm = TRUE) + sum(M[[1]]$nlogPenalty, na.rm = TRUE) + sum(M[[1]]$priorDensity, na.rm = TRUE)
M[[1]]$fit$nlogl

M[[1]]$nloglike
M[[1]]$nlogPenalty
M[[1]]$priorDensity

#fn <- paste0(.MODELDIR, "bbrkc_ss.ctl")
#read_ctl(fn)

plot_datarange(M)
plot_catch(M)
plot_cpue(M)
plot_cpue_res(M)
plot_cpue(M, "BSFRF")
plot_cpue(M, "NMFS Trawl")
plot_natural_mortality(M)
plot_ssb(M)
plot_recruitment(M)
plot_size_comps(M, 1)
plot_size_comps(M, 2)
plot_size_comps(M, 3)
plot_size_comps(M, 4)
plot_size_comps(M, 5)
plot_size_comps(M, 6)
plot_selectivity(M)
plot_growth_transition(M)
plot_size_transition(M)
plot_growth_inc(M)
plot_molt_prob(M)


# ----------------------------------------------------------------------------- #
# TwoSex
# ----------------------------------------------------------------------------- #
.MODELDIR = c("../../examples/bbrkc/TwoSex/")
.THEME    = theme_bw(base_size = 12, base_family = "")
.OVERLAY  = TRUE
.SEX      = c("Aggregate","Male","Female")
.FLEET    = c("Pot","Trawl bycatch","NMFS Trawl","BSFRF")
.TYPE     = c("Retained & Discarded","Retained","Discarded")
.SHELL    = c("Aggregate","New Shell","Old Shell")
.MATURITY = c("Aggregate","Immature","Mature")
.SEAS     = c("Annual")

fn       <- paste0(.MODELDIR, "gmacs")
M        <- lapply(fn, read_admb)
names(M) <- basename(.MODELDIR)
length(M)

table_spr(M)
plot_datarange(M)
plot_catch(M)
plot_cpue(M)
plot_cpue_res(M)
plot_cpue(M, "BSFRF")
plot_cpue(M, "NMFS Trawl")
plot_natural_mortality(M)
plot_ssb(M)
plot_recruitment(M)
plot_size_comps(M, 1)
plot_size_comps(M, 2)
plot_size_comps(M, 3)
plot_size_comps(M, 4)
plot_size_comps(M, 5)
plot_size_comps(M, 6)
plot_size_comps(M, 7)
plot_size_comps(M, 8)
plot_size_comps(M, 9)
plot_size_comps(M, 10)
plot_selectivity(M)
plot_size_transition(M)
plot_growth_inc(M[[1]])


# ----------------------------------------------------------------------------- #
# OneSex and TwoSex
# ----------------------------------------------------------------------------- #
.MODELDIR = c("../../examples/bbrkc/OneSex/", "../../examples/bbrkc/TwoSex/")
.OVERLAY  = TRUE
.SEX      = c("Aggregate","Male","Female")
.FLEET    = c("Pot","Trawl bycatch","NMFS Trawl","BSFRF")
.TYPE     = c("Retained & Discarded","Retained","Discarded")
.SHELL    = c("Aggregate","New Shell","Old Shell")
.MATURITY = c("Aggregate","Immature","Mature")
.THEME    = theme_bw(base_size = 12, base_family = "")
.SEAS     = c("Annual")

fn       <- paste0(.MODELDIR, "gmacs")
M        <- lapply(fn, read_admb)
names(M) <- basename(.MODELDIR)
length(M)

table_spr(M)
table_priors(M)
table_likelihoods(M)
table_penalties(M)

plot_datarange(M) # not right
plot_catch(M)
plot_cpue(M)
plot_cpue(M, "BSFRF")
plot_cpue(M, "NMFS Trawl")
plot_natural_mortality(M)
plot_ssb(M)
plot_recruitment(M)
plot_size_comps(M, 1)
plot_size_comps(M, 2)
plot_size_comps(M, 3)
plot_size_comps(M, 4)
plot_size_comps(M, 5)
plot_size_comps(M, 6)
plot_size_comps(M, 7)
plot_size_comps(M, 8)
plot_size_comps(M, 9)
plot_size_comps(M, 10)
plot_selectivity(M)
plot_size_transition(M)
plot_growth_inc(M)


# ----------------------------------------------------------------------------- #
# TwoSex and Zheng
# ----------------------------------------------------------------------------- #
.MODELDIR = c("../../examples/bbrkc/TwoSex/","../../examples/bbrkc/TwoSex/")
.OVERLAY  = TRUE
.SEX      = c("Aggregate","Male","Female")
.FLEET    = c("Pot","Trawl bycatch","NMFS Trawl","BSFRF")
.TYPE     = c("Retained & Discarded","Retained","Discarded")
.SHELL    = c("Aggregate","New Shell","Old Shell")
.MATURITY = c("Aggregate","Immature","Mature")
.THEME    = theme_bw(base_size = 12, base_family = "")
.SEAS     = c("Annual")

fn       <- paste0(.MODELDIR, "gmacs")
M        <- lapply(fn, read_admb)
names(M) <- c(basename(.MODELDIR)[1], "Zheng")

# Read in Jie's file
j_mmb = read.table("../../examples/bbrkc/jieOutput/jie_mmb.rep", header=T)
j_surv = read.table("../../examples/bbrkc/jieOutput/jie_survb.rep", header=T)
j_len = read.table("../../examples/bbrkc/jieOutput/jie_len_sched.rep", header=T)
j_ltr = read.table("../../examples/bbrkc/jieOutput/jie_lentrans.rep", header=F)

head(j_mmb)
head(j_surv)
head(j_len)
head(j_ltr)
names(M[[2]])

# Add mmb data
#M[[2]]$mmb <- j_mmb$mmb
ii <- which(M[[2]]$fit$names %in% "sd_log_mmb")
M[[2]]$fit$est[ii] <- log(j_mmb$mmb*1000)
#M[[2]]$fit$std[ii] <- log(j_mmb$mmb_sd)

# Add natural mortality data
M[[2]]$M <- matrix(c(j_mmb$M, j_mmb$M), nrow = 80, ncol = 20)

# Add size-weight data
M[[2]]$mid_points <- j_len$Size
M[[2]]$mean_wt <- rbind(j_len$MaleWt, j_len$FemaleWt)

# Add cpue data
M[[2]]$obs_cpue[1,] <- j_surv$obs
M[[2]]$pre_cpue[1,] <- j_surv$pred

# Add numbers data
M[[2]]$N_len[41,] <- (j_len$N2014_female + j_len$N2014_male_n + j_len$N2014_male_o)/1000
ii <- which(M[[2]]$mod_yrs == 1975) + 1
M[[2]]$N_len[ii,] <- (j_len$N1975_female + j_len$N1975_male_n + j_len$N1976_male_o)/1000

# Add recruitment data
ii <- which(M[[2]]$fit$names %in% "sd_log_recruits")
M[[2]]$fit$est[ii] <- log(j_mmb$R*1000)
M[[2]]$fit$std[ii] <- rep(0, length(j_mmb$R))

# Test the plots
plot_recruitment(M)
plot_length_weight(M)
plot_cpue(M)
plot_cpue(M, "BSFRF")
plot_cpue(M, "NMFS Trawl")
plot_numbers(M, subsetby = c("1975","2014"))
plot_natural_mortality(M)
plot_ssb(M)
plot_catch(M)
plot_selectivity(M)
plot_size_transition(M)
plot_growth_inc(M)


# ----------------------------------------------------------------------------- #
# OneSex, TwoSex and Zheng
# ----------------------------------------------------------------------------- #
.MODELDIR = c("../../examples/bbrkc/OneSex/","../../examples/bbrkc/TwoSex/","../../examples/bbrkc/TwoSex/")
.OVERLAY  = TRUE
.SEX      = c("Aggregate","Male","Female")
.FLEET    = c("Pot","Trawl bycatch","NMFS Trawl","BSFRF")
.TYPE     = c("Retained & Discarded","Retained","Discarded")
.SHELL    = c("Aggregate","New Shell","Old Shell")
.MATURITY = c("Aggregate","Immature","Mature")
.THEME    = theme_bw(base_size = 12, base_family = "")
.SEAS     = c("Annual")

fn       <- paste0(.MODELDIR, "gmacs")
M        <- lapply(fn, read_admb)
names(M) <- c(basename(.MODELDIR)[1:2], "Zheng")

# Read in Jie's file
j_mmb = read.table("../../examples/bbrkc/jieOutput/jie_mmb.rep", header=T)
j_surv = read.table("../../examples/bbrkc/jieOutput/jie_survb.rep", header=T)
j_len = read.table("../../examples/bbrkc/jieOutput/jie_len_sched.rep", header=T)
j_ltr = read.table("../../examples/bbrkc/jieOutput/jie_lentrans.rep", header=F)

head(j_mmb)
head(j_surv)
head(j_len)
head(j_ltr)
names(M[[2]])

# Add mmb data
# 1 lb = 0.453592 kg
# 1 kg = 2.20462 lb
jj <- 3
#M[[jj]]$mmb <- j_mmb$mmb*1000
ii <- which(M[[jj]]$fit$names %in% "sd_log_mmb")
M[[jj]]$fit$est[ii] <- log(j_mmb$mmb*10000)
M[[jj]]$fit$std[ii] <- 0
#M[[jj]]$fit$std[ii] <- log(j_mmb$mmb_sd)

# Add natural mortality data
M[[jj]]$M <- matrix(c(j_mmb$M, j_mmb$M), nrow = 80, ncol = 20)

# Add size-weight data
M[[jj]]$mid_points <- j_len$Size
M[[jj]]$mean_wt <- rbind(j_len$MaleWt, j_len$FemaleWt)

# Add cpue data
M[[jj]]$obs_cpue[1,] <- j_surv$obs
M[[jj]]$pre_cpue[1,] <- j_surv$pred

# Add numbers data
M[[jj]]$N_len[41,] <- (j_len$N2014_female + j_len$N2014_male_n + j_len$N2014_male_o)/1000
ii <- which(M[[jj]]$mod_yrs == 1975) + 1
M[[jj]]$N_len[ii,] <- (j_len$N1975_female + j_len$N1975_male_n + j_len$N1976_male_o)/1000

# Add recruitment data
ii <- which(M[[jj]]$fit$names %in% "sd_log_recruits")
M[[jj]]$fit$est[ii] <- log(j_mmb$R*1e+3)
M[[jj]]$fit$std[ii] <- rep(0, length(j_mmb$R))

# Add growth transition data
M[[jj]]$growth_transition <- rbind(j_ltr, j_ltr)
M[[jj]]$tG                <- rbind(j_ltr, j_ltr)

# Add size transition data
m <- diag(20)
diag(m) <- j_len$MP_1987
m <- as.matrix(j_ltr) %*% m
diag(m) <- diag(m)+(1-j_len$MP_1987)
M[[jj]]$size_transition_M <- m
M[[jj]]$size_transition_F <- m
M[[jj]]$tS <- rbind(m, m)

# Add molting probability data
M[[jj]]$molt_probability <- rbind(j_len$MP_1987, j_len$MP_1987)

# Add recruitment size distribution data
M[[jj]]$mid_points <- j_len$Size
M[[jj]]$rec_sdd <- j_len$Male_R_sd #j_len$Female_R_sd

reload()

A <- M; A[[2]] <- NULL
plot_growth_transition(A)

# Test the plots
plot_recruitment(M)
plot_recruitment_size(M)
.OVERLAY = FALSE
plot_length_weight(M)
.OVERLAY = TRUE
plot_molt_prob(M)
plot_cpue(M)
plot_cpue(M, "BSFRF")
plot_cpue(M, "NMFS Trawl")
plot_numbers(M, subsetby = c("1975","2014"))
plot_natural_mortality(M)
plot_ssb(M)
plot_catch(M)
plot_selectivity(M, ncol = 4)
plot_growth_transition(M)
plot_size_transition(M)
plot_growth_inc(M)

A <- M; A[[3]] <- NULL
plot_recruitment(A)








#.PWD      = "/Users/stevenmartell1/Documents/CURRENT PROJECTS/GMACS/gmr/R4GMACS"
.LIB      = "./LIB"
.RFILES   = list.files(.LIB,pattern="\\.[Rr]$")
#.MODELDIR = c("../../examples/bbrkc/OneSex/", "../../examples/bbrkc/TwoSex/")#,"../../examples/bbrkc/")
#.MODELDIR = c(paste0("../../examples/bbrkc/M",c(1,2,3,4),"/"))#,"../../examples/bbrkc/OneSex/")
# .MODELDIR = c("../../examples/pirkc/")
# SOURCE R_SRCIPTS FROM .LIB
#setwd(.PWD)
for(nm in .RFILES) source(file.path(.LIB, nm), echo = FALSE)

# PLOT ROUTINES	
#hh <- 8.5
#ww <- 11
#.FIGS = ""


#===============================================================================#
# Data range
#===============================================================================#
#source("../R/plot-datarange.R")
plot_datarange(M)
# Not quite doing what we want for two models, good for one model

#===============================================================================#
# Catch
#===============================================================================#
#M[[1]]$ob_catch <- M[[1]]$obs_catch * 1000
#plot.catch(M)
#ggsave(paste0(.FIGS, "figCatch.png"), width=1.0*ww, height=0.6*hh, bg="white")
source("../R/plot-catch.R")
plot_catch(M)

#===============================================================================#
# Abundance index
#===============================================================================#
#M[[1]]$pre_cpue <- M[[1]]$pre_cpue * 1000
#M[[1]]$obs_cpue <- M[[1]]$obs_cpue * 1000
#plot.cpue(M , "NMFS Trawl")
#ggsave(paste0(.FIGS, "figCPUE.png"), width=0.5*ww, height=0.5*hh, bg="white")
source("../R/plot-cpue.R")
plot_cpue(M)
plot_cpue(M, "BSFRF")
plot_cpue(M, "NMFS Trawl")

#===============================================================================#
# Natural mortality
#===============================================================================#
source("../R/plot-natural-mortality.R")
plot_natural_mortality(M)
#ggsave(paste0(.FIGS, "figNaturalMortality.png" ), width=ww, height=hh, bg="white")


#===============================================================================#
# Biomass
#===============================================================================#
#M[[1]]$mmb <- M[[1]]$mmb * 10000
#plot.ssb(M)
#ggsave(paste0(.FIGS, "figMMB.png"), width=0.5*ww, height=0.5*hh, bg="white")
source("../R/plot-ssb.R")
plot_ssb(M)


#===============================================================================#
# Recruitment
#===============================================================================#
#plot.Recruitment(M)
#ggsave(paste0(.FIGS, "figRecruits.png"), width=0.5*ww, height=0.5*hh, bg="white")
source("../R/plot-recruitment.R")
plot_recruitment(M)


#===============================================================================#
# Size Comps
#===============================================================================#
#plot.sizeComps(M, 4)
#ggsave(paste0(.FIGS, "figSizeComps.png"), width=ww, height=hh, bg="white")
#source("../R/plot-size-comps.R")
plot_size_comps(M, 1)
plot_size_comps(M, 2)
plot_size_comps(M, 3)
plot_size_comps(M, 4)
plot_size_comps(M, 5)
plot_size_comps(M, 6)
plot_size_comps(M, 7)
plot_size_comps(M, 8)
plot_size_comps(M, 9)
plot_size_comps(M, 10)


#===============================================================================#
# Selectivity
#===============================================================================#
source("../R/plot-selectivity.R")
plot_selectivity(M)


#===============================================================================#
# Size transition
#===============================================================================#
#source("../R4GMACS/LIB/plotSizeTransition.R")
#plotSizeTransition(M)
#source("../R4GMACS/LIB/plotGrowthTransition.R")
#plotGrowthTransition( M )
#plot_growthTransition(M)
source("../R/plot-size-transition.R")
plot_size_transition(M)


#===============================================================================#
# Growth increments
#===============================================================================#
source("../R/plot-growth-inc.R")
plot_growth_inc(M)

source("../R/plot-length-weight.R")
plot_length_weight(M)


#===============================================================================#
# Numbers
#===============================================================================#
source("../R/plot-numbers.R")
plot_numbers(M)
plot_numbers(M, subsetby = c("1975","2014"))
plot_numbers(M, subsetby = 1975:2014)

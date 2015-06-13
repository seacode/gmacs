require(devtools)
devtools::install_github("seacode/gmacs", subdir = "/gmr", ref = "develop")
require(gmr)

myTheme <- theme_bw(base_size = 12) + theme(
	panel.background  = element_rect(fill = "transparent",colour = NA), # or theme_blank()
	legend.background = element_blank(),
	legend.key        = element_blank(),
        #panel.grid.minor = element_blank(), 
        #panel.grid.major = element_blank(),
        plot.background   = element_rect(fill = "transparent",colour = NA)) 

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
#.THEME    = myTheme #theme_bw(base_size = 12, base_family = "")
.SEAS     = c("Annual")

fn       <- paste0(.MODELDIR, "gmacs")
M        <- lapply(fn, read_admb)
names(M) <- basename(.MODELDIR)
length(M)

plot_datarange(M)
plot_catch(M) # broken
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
plot_selectivity(M)
plot_size_transition(M)
plot_growth_inc(M[[1]])


# ----------------------------------------------------------------------------- #
# TwoSex
# ----------------------------------------------------------------------------- #
.MODELDIR = c("../../examples/bbrkc/TwoSex/")
.OVERLAY  = TRUE
.SEX      = c("Aggregate","Male","Female")
.FLEET    = c("Pot","Trawl bycatch","NMFS Trawl","BSFRF")
.TYPE     = c("Retained & Discarded","Retained","Discarded")
.SHELL    = c("Aggregate","New Shell","Old Shell")
.MATURITY = c("Aggregate","Immature","Mature")
.THEME    = myTheme #theme_bw(base_size = 12, base_family = "")
.SEAS     = c("Annual")

fn       <- paste0(.MODELDIR, "gmacs")
M        <- lapply(fn, read_admb)
names(M) <- basename(.MODELDIR)
length(M)

plot_datarange(M)
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
.THEME    = myTheme #theme_bw(base_size = 12, base_family = "")
.SEAS     = c("Annual")

fn       <- paste0(.MODELDIR, "gmacs")
M        <- lapply(fn, read_admb)
names(M) <- basename(.MODELDIR)
length(M)

plot_datarange(M) # not right
plot_catch(M) # broken for OneSex
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
plot_growth_inc(M[[1]])














#.PWD      = "/Users/stevenmartell1/Documents/CURRENT PROJECTS/GMACS/gmr/R4GMACS"
#.LIB      = "./LIB"
#.RFILES   = list.files(.LIB,pattern="\\.[Rr]$")
#.MODELDIR = c("../../examples/bbrkc/OneSex/", "../../examples/bbrkc/TwoSex/")#,"../../examples/bbrkc/")
#.MODELDIR = c(paste0("../../examples/bbrkc/M",c(1,2,3,4),"/"))#,"../../examples/bbrkc/OneSex/")
# .MODELDIR = c("../../examples/pirkc/")
# SOURCE R_SRCIPTS FROM .LIB
#setwd(.PWD)
#for(nm in .RFILES) source(file.path(.LIB, nm), echo = FALSE)

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
#plotGrowthTransition( M )
#plotSizeTransition( M )
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

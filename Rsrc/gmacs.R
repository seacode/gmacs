#=========================================================================================================
#
#  gmr Script for Gmacs: Example for BBRKC Demonstration Model
#  Authors: Athol Whitten, Jim Ianelli
#  Info: https://github.com/seacode/gmr
#
#=========================================================================================================

# LIBRARIES
library(ggplot2)
library(reshape2)
library(dplyr)
library(gmr)


# GLOBAL CONSTS
.OVERLAY  = TRUE
.PWD      = "/Users/stevenmartell1/Documents/CURRENT PROJECTS/GMACS/Rsrc/R4GMACS"
.PWD      = "/Users/jim/_mymods/seacode/gmacs/Rsrc/R4GMACS"
.PWD      = "/Users/jim/_mymods/seacode/gmacs/Rsrc/R"
.LIB      = "./"
.RFILES   = list.files(.LIB,pattern="\\.[Rr]$")
.MODELDIR = c("../../examples/bbrkc/OneSex/","../../examples/bbrkc/TwoSex/")
.THEME    = theme_bw(base_size = 12, base_family = "")
.FLEET    = c("Pot","Trawl bycatch","NMFS Trawl","BSFRF")
.SEX      = c("Aggregate","Male","Female")
.SHELL    = c("Aggregate","New Shell","Old Shell")
.MATURITY = c("Aggregate","Immature","Mature")
.TYPE     = c("Total catch","Retained","Discarded")
.SEAS     = c("Annual")

# SOURCE R_SRCIPTS FROM .LIB
setwd(.PWD)
for(nm in .RFILES) source(file.path(.LIB, nm), echo=FALSE)
# READ MODEL OUTPUTS FROM .MODELDIR
fn       <- paste0(.MODELDIR,"gmacs")
M        <- lapply(fn,read_admb)
names(M) <- basename(.MODELDIR)

# PLOT ROUTINES
	plot_ssb( M )
	plot_recruitment( M )
	plot_recruitment( M[1] )
	plot_cpue( M )
	plot_growthTransition( M )
	plot_sizeTransition( M )
	plot_selectivity( M )
	plot_sizeComps( M[1], 1 )
	plot_sizeComps( M, 1 )

# Set working directory to that containing Gmacs model results:
# setwd("c:/seacode/gmacs/examples/demo")
# setwd("~/_mymods/seacode/gmacs/examples/demo")
# setwd("~/_mymods/seacode/gmacs/examples/bbrkc")
setwd("/Users/stevenmartell1/Documents/CURRENT PROJECTS/GMACS/examples/bbrkc")
# setwd("c:/Users/Crab2015/gmacs/examples/bbrkc")
# Set theme for ggplot2 (works for themes classic, minimal, gray, bw):
set_ggtheme('bw')

# Read report file and create gmacs report object (a list):
gmrep <- read_admb('gmacs')

# Get plots of interest:
plot_catch(gmrep)
plot_growth(gmrep)
plot_catch(gmrep,plot_res=TRUE)
names(gmrep$fit)
plot_growth_inc(gmrep)
plot_cpue(gmrep)

plot_sizecomp(gmrep,which_plots=c(1))
plot_sizecomp(gmrep)
plot_sizecomp_res(gmrep, which_plots=c(1))


plot_sizecomp(gmrep,which_plots=c(1))
plot_sizecomp(gmrep,which_plots=c(2))
plot_sizecomp(gmrep,which_plots=c(5))


plot_sizecomp(gmrep,which_plots=c(7))
plot_sizecomp(gmrep,which_plots=c(8))



plot_sizecomp_res(gmrep)
plot_sizetransition(gmrep)

plot_selectivity(gmrep)
plot_recruitment(gmrep)
plot_datarange(gmrep)
plot_ssb(gmrep)
plot_naturalmortality(gmrep)

shiny_gmacs(gmrep)

#=========================================================================================================

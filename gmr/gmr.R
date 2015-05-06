#=========================================================================================================
#
#  gmr Script for Gmacs: Example for BBRKC Demonstration Model
#  Authors: Steve Martell, Jim Ianelli, Athol Whitten
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
#.PWD      = "/Users/stevenmartell1/Documents/CURRENT PROJECTS/GMACS/Rsrc/R4GMACS"
#.PWD      = "/Users/jim/_mymods/seacode/gmacs/Rsrc/R4GMACS"
#.PWD      = "/Users/jim/_mymods/seacode/gmacs/Rsrc/R"
#.LIB      = "./"
#.RFILES   = list.files(.LIB,pattern="\\.[Rr]$")
#.MODELDIR = c("../../examples/bbrkc/OneSex/","../../examples/bbrkc/TwoSex/")
.MODELDIR = c("../examples/bbrkc/OneSex/")
#.MODELDIR = c("../../examples/pirkc/")
.THEME    = theme_bw(base_size = 12, base_family = "")
.FLEET    = c("Pot","Trawl bycatch","NMFS Trawl","BSFRF")
.SEX      = c("Aggregate","Male","Female")
.SHELL    = c("Aggregate","New Shell","Old Shell")
.MATURITY = c("Aggregate","Immature","Mature")
.TYPE     = c("Total catch","Retained","Discarded")
.SEAS     = c("Annual")

# SOURCE R_SRCIPTS FROM .LIB
#setwd(.PWD)
#for(nm in .RFILES) source(file.path(.LIB, nm), echo=FALSE)

# READ MODEL OUTPUTS FROM .MODELDIR
fn       <- paste0(.MODELDIR, "gmacs")
M        <- lapply(fn, read_admb)
names(M) <- basename(.MODELDIR)

# PLOT ROUTINES
plot_gmr(M, target_dir = .MODELDIR)

	plot_recruitment( M[1] )
	plot_growthTransition( M )
	plot_sizeComps( M[1], 1 )
	plot_sizeComps( M, 1 )
  source("plot-naturalmortality.R")
  plot_naturalmortality(M)
  plot_growth_inc(M)
  plot_growth_inc(M[[1]])
 #shiny_gmacs(gmrep)
#=========================================================================================================

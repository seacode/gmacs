# -------------------------------------------------------------------------------------- #
# -------------------------------------------------------------------------------------- #
#                                    R4GMACS.R                                           #
#                                     VER 0.1                                            #
# -------------------------------------------------------------------------------------- #
# -------------------------------------------------------------------------------------- #

# LIBRARIES
library(ggplot2)
library(reshape2)
library(dplyr)


# GLOBAL CONSTS
.OVERLAY  = TRUE
.PWD      = "/Users/stevenmartell1/Documents/CURRENT PROJECTS/GMACS/Rsrc/R4GMACS"
.LIB      = "./LIB"
.RFILES   = list.files(.LIB,pattern="\\.[Rr]$")
.MODELDIR = c("../../examples/bbrkc/OneSex/","../../examples/bbrkc/TwoSex/")
.THEME    = theme_bw(base_size = 12, base_family = "")
.FLEET    = c("Pot","Trawl bycatch","NMFS Trawl","BSFRF")
.SEX      = c("Aggregate","Male","Female")
.SHELL    = c("Aggregate","New Shell","Old Shell")
.MATURITY = c("Aggregate","Immature","Mature")
.TYPE     = c("Total catch","Retained","Discarded")
.SEAS     = c("Annaul")

# SOURCE R_SRCIPTS FROM .LIB
setwd(.PWD)
for(nm in .RFILES) source(file.path(.LIB, nm), echo=FALSE)

# READ MODEL OUTPUTS FROM .MODELDIR
fn       <- paste0(.MODELDIR,"gmacs")
M        <- lapply(fn,read.admb)
names(M) <- basename(.MODELDIR)

# PLOT ROUTINES
	plot.ssb( M )
	plot.cpue( M )
	plot.growthTransition( M )
	plot.sizeTransition( M )
	plot.selex  ( M )
	plot.sizeComps ( M, 1 )
	plot.SizeCompRes ( M, 1 ) 

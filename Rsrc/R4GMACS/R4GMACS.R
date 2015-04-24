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
# .MODELDIR = c("../../examples/bbrkc/OneSex/","../../examples/bbrkc/")
.MODELDIR = c("../../examples/bbrkc/SRA-1/")
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
M        <- lapply(fn,read.admb)
names(M) <- basename(.MODELDIR)

# PLOT ROUTINES	
	png("figCatch.png",width=600,height=300,units="px",bg="transparent")
	plot.catch( M[1] ); 			#ggsave("figCatch.png",bg="transparent")
	dev.off();
	plot.ssb( M )
	plot.cpue( M )
	plotGrowthTransition( M )
	plotSizeTransition( M )
	plot.selex  ( M )
	plot.sizeComps ( M, 1 );   ggsave("figSizeComps.png")
	plot.SizeCompRes ( M, 1 ); ggsave("figSizeCompResdiuals.png")

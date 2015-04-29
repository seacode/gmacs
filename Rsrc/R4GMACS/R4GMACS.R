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
library(readADMB)

myTheme <- theme_bw(base_size = 12) +
	theme(
    panel.background = element_rect(fill = "transparent",colour = NA), # or theme_blank()
    legend.background = element_blank(),
    legend.key= element_blank(),
    # panel.grid.minor = element_blank(), 
    # panel.grid.major = element_blank(),
    plot.background = element_rect(fill = "transparent",colour = NA)
	) 

# GLOBAL CONSTS
.OVERLAY  = TRUE
.PWD      = "/Users/stevenmartell1/Documents/CURRENT PROJECTS/GMACS/Rsrc/R4GMACS"
.LIB      = "./LIB"
.RFILES   = list.files(.LIB,pattern="\\.[Rr]$")
# .MODELDIR = c("../../examples/bbrkc/OneSex/","../../examples/bbrkc/")
.MODELDIR = c("../../examples/bbrkc/M1/","../../examples/bbrkc/M2/")
.THEME    = myTheme #theme_bw(base_size = 12, base_family = "")
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
	hh <- 8.5
	ww <- 11

	plot.catch( M );        ggsave("figCatch.png",width=ww,height=hh,bg="transparent")			
	plot.ssb( M );			   ggsave("figMMB.png",  width=ww,height=hh,bg="transparent")	
	plot.cpue( M );			   ggsave("figCPUE.png", width=ww,height=hh,bg="transparent")
	# plotGrowthTransition( M )
	# plotSizeTransition( M )
	# plot.selex  ( M )
	plot.sizeComps ( M, 1 );   ggsave("figSizeComps.png",width=ww,height=hh,bg="transparent")
	plot.SizeCompRes ( M, 1 ); ggsave("figSizeCompResdiuals.png",width=ww,height=hh,bg="transparent")

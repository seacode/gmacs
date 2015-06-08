# -------------------------------------------------------------------------------------- #
# -------------------------------------------------------------------------------------- #
#                                    R4GMACS.R                                           #
#                                     VER 0.1                                            #
# -------------------------------------------------------------------------------------- #
# -------------------------------------------------------------------------------------- #

# LIBRARIES
library(gmr)

myTheme <- theme_bw(base_size = 12) +
	theme(
	panel.background  = element_rect(fill = "transparent",colour = NA), # or theme_blank()
	legend.background = element_blank(),
	legend.key        = element_blank(),
    # panel.grid.minor = element_blank(), 
    # panel.grid.major = element_blank(),
    plot.background   = element_rect(fill = "transparent",colour = NA)
	) 

# GLOBAL CONSTS
.OVERLAY  = TRUE
.PWD      = "/Users/stevenmartell1/Documents/CURRENT PROJECTS/GMACS/gmr/R4GMACS"
.LIB      = "./LIB"
.RFILES   = list.files(.LIB,pattern="\\.[Rr]$")
#.MODELDIR = c("../../examples/bbrkc/OneSex/")#,"../../examples/bbrkc/")
.MODELDIR = c("../../examples/bbrkc/OneSex/", "../../examples/bbrkc/TwoSex/")#,"../../examples/bbrkc/")
#.MODELDIR = c(paste0("../../examples/bbrkc/M",c(1,2,3,4),"/"))#,"../../examples/bbrkc/OneSex/")
# .MODELDIR = c("../../examples/pirkc/")
.THEME    = myTheme #theme_bw(base_size = 12, base_family = "")
.FLEET    = c("Pot","Trawl bycatch","NMFS Trawl","BSFRF")
.SEX      = c("Aggregate","Male","Female")
.SHELL    = c("Aggregate","New Shell","Old Shell")
.MATURITY = c("Aggregate","Immature","Mature")
.TYPE     = c("Retained & Discarded","Retained","Discarded")
.SEAS     = c("Annual")

# SOURCE R_SRCIPTS FROM .LIB
setwd(.PWD)
for(nm in .RFILES) source(file.path(.LIB, nm), echo=FALSE)

# READ MODEL OUTPUTS FROM .MODELDIR
fn       <- paste0(.MODELDIR, "gmacs")
M        <- lapply(fn, read_admb)
names(M) <- basename(.MODELDIR)


# PLOT ROUTINES	
hh <- 8.5
ww <- 11
.FIGS = ""


#===============================================================================#
# Data range
#===============================================================================#
source("../R/plot-datarange.R")
plot_datarange(M[[1]])
plot_datarange(M)
# Not done

#===============================================================================#
# Catch
#===============================================================================#
M[[1]]$ob_catch <- M[[1]]$obs_catch * 1000
plot.catch(M)
ggsave(paste0(.FIGS, "figCatch.png"), width=1.0*ww, height=0.6*hh, bg="white")
source("../R/plot-catch.R")
plot_catch(M)

#===============================================================================#
# Abundance index
#===============================================================================#
M[[1]]$pre_cpue <- M[[1]]$pre_cpue * 1000
M[[1]]$obs_cpue <- M[[1]]$obs_cpue * 1000
plot.cpue(M , "NMFS Trawl")
#ggsave(paste0(.FIGS, "figCPUE.png"), width=0.5*ww, height=0.5*hh, bg="white")
source("../R/plot-cpue.R")
plot_cpue(M)

#===============================================================================#
# Natural mortality
#===============================================================================#
source("../R/plot-naturalmortality.R")
plot_naturalmortality(M)
ggsave(paste0(.FIGS, "figNaturalMortality.png" ), width=ww, height=hh, bg="white")




M[[1]]$mmb <- M[[1]]$mmb * 10000
plot.ssb(M)
ggsave(paste0(.FIGS, "figMMB.png"), width=0.5*ww, height=0.5*hh, bg="white")

plot.Recruitment(M)
ggsave(paste0(.FIGS, "figRecruits.png"), width=0.5*ww, height=0.5*hh, bg="white")


plot.sizeComps(M, 4)
ggsave(paste0(.FIGS, "figSizeComps.png"), width=ww, height=hh, bg="white")



table.SPRrefPoints(M)

	# plotGrowthTransition( M )
	# plotSizeTransition( M )
	# plot.selex  ( M )
	# plot.SizeCompRes ( M ); ggsave("figSizeCompResdiuals.png",width=ww,height=hh,bg="transparent")

	plot_catch( M )
	plot_ssb( M )
	plot_recruitment( M )
	plot_recruitment( M[1] )
	plot_cpue( M )
	plot_growthTransition( M )
	plot_sizeTransition( M )
	plot_selectivity( M )
	plot_sizeComps( M[1], 1 )
	plot_sizeComps( M, 1 )
  plot_growth_inc(M[[1]])

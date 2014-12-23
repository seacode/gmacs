#=========================================================================================================
#
#  gmr Script for Gmacs: Example for BBRKC Demonstration Model
#  Authors: Athol Whitten, Jim Ianelli
#  Info: https://github.com/seacode/gmr
#
#=========================================================================================================

# Load gmr package for Gmacs:
library(gmr)

# Set working directory to that containing Gmacs model results:
setwd("c:/seacode/gmacs/examples/demo")
setwd("~/_mymods/seacode/gmacs/examples/demo")

# Set theme for ggplot2 (works for themes classic, minimal, gray, bw):
set_ggtheme('bw')

# Read report file and create gmacs report object (a list):
gmrep <- read_admb('gmacs')
gmrep2 <- read_admb('gmacs')

# Get plots of interest:
plot_catch(gmrep)
plot_growth(gmrep)
plot_catch(gmrep,plot_res=T)

plot_sizecomp(gmrep,which_plots=c(1))
plot_sizecomp(gmrep)
plot_sizecomp_res(gmrep, which_plots=c(1))


plot_sizecomp(gmrep,which_plots=c(11))
plot_sizecomp_res(gmrep)
plot_sizetransition(gmrep)

plot_selectivity(gmrep)
plot_recruitment(gmrep)
p <- plot_ssb(gmrep)
dftmp = get_ssb(gmrep2)
  p <- p + geom_line(aes(x=year,y=exp(log_mmb)),data=dftmp)
  plot(p)
names(gmrep2$mmb)
(gmrep2$mmb)
lines(gmrep2$mod_yrs,gmrep2$mmb)
  p <- p + geom_line(aes(x=year,y=exp(log_mmb)))
plot_naturalmortality(gmrep)
plot_naturalmortality(gmrep)

shiny_gmacs(gmrep)

#=========================================================================================================

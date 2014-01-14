# Script to get plots from AEP_Simple Crab Model.

source('plot_simple.r')
windows(record=TRUE)

Plots <- c(T,F)
if (Plots[1] == TRUE) cases <- c(T,T,T,T,T,T)
if (Plots[2] == TRUE) cases <- c(T,T,T,T,T,T)

# BBRKC
FishFleets <- c("Discard catch","Pot retained","Groundfish trawl discards","Tanner fishery")
SurvFleets <- c("NMFS trawl","BSFRF trawl")
Dirn <- getwd()
Figs(Dirn,"/simple.rep","/simple.std",85,208,FishFleets,SurvFleets,PlotAll=T,IsStdDev=T,cases=cases)


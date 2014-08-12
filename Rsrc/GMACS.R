# GLOBAL SETTINGS
#.THEME <- theme_classic()
.THEME <- theme_bw()
#.THEME <- theme_minimal()

# REPORT FILE
source("./lib/read.admb.R")
repfile <- "../examples/demo/gmacs"
A <- read.admb(repfile)

# SOURCE R-scripts
.LIB        <- "./lib"
.RFILES     <- list.files(.LIB,pattern="\\.[Rr]$")
for(nm in .RFILES) source(file.path(.LIB, nm), echo=FALSE)



#  Very Simple functions such that you can build a shiny app
#  or a tck/tk interface to plot results.
# Plot catch
print(pCatch + .THEME)

# Plot catch residuals
print(pCatchRes + .THEME)

# Plot cpue
print(pCPUE + .THEME)

# Plot fit to CPUE
print(pCPUEfit + .THEME)

# Plot CPUE residuals
print(pCPUEres + .THEME)

# Plot Size comps
print(pSizeComps[1])

# Plot Size Comp bubbles
print(pSizeCompResid[1])

# Plot Mature Male Biomass
print(pMMB + .THEME)

# Plot size-transition matrix
print(pSizeTransition + .THEME)

# Plot recruitment
print(pRecruitment + .THEME)










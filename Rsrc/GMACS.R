# REPORT FILE
repfile <- "../examples/demo/gsmac"
A <- read.admb(repfile)

# SOURCE R-scripts
.LIB        <- "./lib"
.RFILES     <- list.files(.LIB,pattern="\\.[Rr]$")
for(nm in .RFILES) source(file.path(.LIB, nm), echo=FALSE)

# GLOBAL SETTINGS
#.THEME <- theme_classic()
.THEME <- theme_bw()
#.THEME <- theme_minimal()

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
print(pSizeComps[1] + .THEME)

# Plot Size Comp bubbles
print(pSizeCompResid[1] + .THEME)

# Plot Mature Male Biomass
print(pMMB + .THEME)

# Plot size-transition matrix


# Plot recruitment








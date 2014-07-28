# REPORT FILE
repfile <- "../examples/demo/gsmac"
A <- read.admb(repfile)

# SOURCE R-scripts
.LIB        <- "./lib"
.RFILES     <- list.files(.LIB,pattern="\\.[Rr]$")
for(nm in .RFILES) source(file.path(.LIB, nm), echo=FALSE)



#  PLOT RESULTS
# Plot catch
print(pCatch)

# Plot catch residuals
print(pCatchRes)

# Plot cpue
print(pCPUE)

# Plot fit to CPUE
print(pCPUEfit)

# Plot CPUE residuals
print(pCPUEres)

# Plot Size comps
print(pSizeComps[1])

# Plot Size Comp bubbles
print(pSizeCompResid[1])





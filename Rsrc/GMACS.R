# REPORT FILE
.LIB        <- "./lib"
.RFILES     <- list.files(.LIB,pattern="\\.[Rr]$")
for(nm in .RFILES) source(file.path(.LIB, nm), echo=FALSE)
repfile <- "../examples/demo/gsmac"

A <- read.admb(repfile)



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
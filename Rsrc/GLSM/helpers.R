.THEME <- theme_bw()

# SOURCE R-scripts
.LIB        <- "lib"
.RFILES     <- list.files(.LIB,pattern="\\.[Rr]$")
for(nm in .RFILES) source(file.path(.LIB, nm), echo=FALSE)


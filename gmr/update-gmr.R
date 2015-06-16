#===============================================================
# UPDATE HELP FILES
#===============================================================

require(roxygen2)
roxygen2::roxygenize("../gmr")

#===============================================================
# UPDATE DESCRIPTION FILE
#===============================================================

VERSION <- "1.00"
DATE    <- Sys.Date()

DESCRIPTION <- readLines("DESCRIPTION")
DESCRIPTION[3] <- paste("Version:", VERSION)
DESCRIPTION[4] <- paste("Date:", DATE)
writeLines(DESCRIPTION, "DESCRIPTION")

# Write gmr.version()
filename <- "R/gmr.version.R"
cat("#' Function to return version number\n", file = filename)
cat("#'\n", file = filename, append = TRUE)
cat("#' @export\n",file = filename, append = TRUE)
cat("#'\n", file = filename, append = TRUE)
cat("gmr.version <- function()\n", file = filename, append = TRUE)
cat("{\n", file = filename, append = TRUE)
cat(paste("    return(\"Version: ", VERSION, "\\n", "Compile date: ", DATE, "\\n\")\n", sep = ""), file = filename, append = TRUE)
cat("}\n", file = filename, append = TRUE)

#===============================================================

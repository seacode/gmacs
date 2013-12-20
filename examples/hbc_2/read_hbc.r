#==============================================================================
#
#	read_hbc.r : (November 2013)
# 	R script to import content from HBC example model.
#
# 	Returns: A list containing elements of gmacs.rep and/or gmacs.cor,
# 	formatted as R objects, and optional summary statistics to R console.
#
# 	Author: Athol R. Whitten <whittena@uw.edu>
#
#==============================================================================

source("C:/Dropbox/Github/gmacs/scripts/gmacs.r")

hbc.replist <- GMRead.Rep(dir="C:/Dropbox/Github/gmacs/examples", model="hbc")

hbc.fit <- GMOutput(dir="C:/Dropbox/Github/gmacs/examples", model="hbc",covar=TRUE)

#TODO (Athol): Add some plotting functionality to Gmacs.r as required.
#==============================================================================
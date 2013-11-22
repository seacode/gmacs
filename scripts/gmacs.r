#=========================================================================================================
#
#	Gmacs.r : Version 1.0 (November 2013)
# 	R functions to import content from a Gmacs model run, and produce plots.
#
# 	Returns: A list containing elements of gmacs.rep and/or gmacs.cor,
# 	formatted as R objects, and optional summary statistics to R console.
#
# 	Plots: Various fits to data, summary statistics, and model functions.
#
# 	Author: Athol R. Whitten <whittena@uw.edu>
# 	and other contributors at https:/github.com/awhitten/gmacs
#
# 	Acknowledgements: 'Read' functions based on code developed for ADMB by Steve Martell
#	Some plotting functions based on code developed for Stock Synthesis by Ian Taylor annd Others (r4ss).
#
#=========================================================================================================


# Function [GMOutput]: Wrapper function to read output files, create lists, and get fits to data.
# --------------------------------------------------------------------------------------------------------
GMOutput <- function(dir="C:/Dropbox/Github/gmacs/examples",
		model="model", repfile="gmacs.rep", parfile="gmacs.par", corfile="gmacs.cor", 
		psvfile="gmacs.psv", covar=TRUE, forecast=FALSE){

		replist <- GMRead.Rep(model=model)
		
		fit <- GMRead.Fit(model=model,covar=covar)
		replist$fit <- fit
		
		#pfn <- file.path(dir,model,psvfile)
		#if(file.exists(pfn)) replist$post.samp <- GMRead.PSV(pfn)
		
		return(replist)
	}


# Function [GMRead.Rep]: Read in a Gmacs report file (gmacs.rep)
# --------------------------------------------------------------------------------------------------------
GMRead.Rep <- function(dir="C:/Dropbox/Github/gmacs/examples",
		model="model", repfile="gmacs.rep"){
		
		repfile <- file.path(dir,model,repfile)
		
		options(warn=-1)  # Suppress NA message when coercing to double
		
		repscan <- scan(repfile, what="character", flush=TRUE, blank.lines.skip=FALSE, quiet=TRUE)
		na.check <- sapply(as.double(repscan), is.na)
		vnames <- repscan[na.check] # List of names in scan
		vnumber <- length(vnames)   # Number of components in scan
		
		replist <- list()
		imatch <- 0
		for(i in 1:vnumber)
		{
			imatch <- match(vnames[i],repscan)
			if(i!=vnumber) kmatch <- match(vnames[i+1],repscan) else kmatch <- length(repscan)+1 # Get next row
			
			value <- NA
			if(kmatch-imatch == 2) value <- as.double(scan(repfile, skip=imatch ,nlines=1, quiet=TRUE, what=""))
			if(kmatch-imatch >  2) value <- as.matrix(read.table(repfile, skip=imatch, nrow=kmatch-imatch-1, fill=TRUE))

			if(is.numeric(value)) # Logical test to ensure dealing with numbers
			{
				replist[[vnames[i]]] <- value
			}
		}
		options(warn=0)
		
		return(replist)
	}

# Function [GMRead.Fit]: Read in Gmacs parameter and correlation files (gmacs.par, gmacs.cor)
# --------------------------------------------------------------------------------------------------------
	
GMRead.Fit <- function(dir="C:/Dropbox/Github/gmacs/examples",
		model="model", parfile="gmacs.par", corfile="gmacs.cor", covar=TRUE){
		
		parfile <- file.path(dir,model,parfile)
		corfile <- file.path(dir,model,corfile)
		
		fitlist <- list()		
		
		parscan <- as.numeric(scan(parfile, what='', n=16, quiet=TRUE)[c(6,11,16)]) 
		fitlist$nopar <- as.integer(parscan[1]) 
		fitlist$nlogl <- parscan[2] 
		fitlist$maxgrad <- parscan[3] 
		
		if(covar==TRUE){
			corlines <- readLines(corfile) 
			fitlist$npar <- length(corlines)-2 
			fitlist$logDetHess <- as.numeric(strsplit(corlines[1], '=')[[1]][2]) 
			
			sublines <- lapply(strsplit(corlines[1:fitlist$npar+2], ' '),function(x)x[x!='']) 
			fitlist$names <- unlist(lapply(sublines,function(x)x[2])) 
			fitlist$est <- as.numeric(unlist(lapply(sublines,function(x)x[3]))) 
			fitlist$std <- as.numeric(unlist(lapply(sublines,function(x)x[4]))) 
			fitlist$cor <- matrix(NA, fitlist$npar, fitlist$npar) 
			
			corvec <- unlist(sapply(1:length(sublines), function(i)sublines[[i]][5:(4+i)])) 
			fitlist$cor[upper.tri(fitlist$cor, diag=TRUE)] <- as.numeric(corvec) 
			fitlist$cor[lower.tri(fitlist$cor)] <- t(fitlist$cor)[lower.tri(fitlist$cor)] 
			fitlist$cov <- fitlist$cor*(fitlist$std%o%fitlist$std)
		}
		
		return(fitlist)
	}

# Function [GMRead.PSV]: Read binary output from Gmacs -mcsave option (gmacs.psv)
# --------------------------------------------------------------------------------------------------------

GMRead.PSV <- function(dir="C:/Dropbox/Github/gmacs/examples",
		model="model", psvfile="gmacs.psv", nsamples=10000){
		
		psvfile <- file.path(dir,model,psvfile)

		read.file <- file(psvfile, open="rb")
		num.par <- readBin(read.file, what = integer(), n = 1)
		mcmc <- readBin(read.file, what = numeric(), n = nopar * nsamples)
		mcmc <- matrix(mcmc, byrow = TRUE, ncol = nopar)
		close(read.file)
		return(mcmc)
	}

#=========================================================================================================
# EOF
#' Read ADMB output files
#'
#' Read ADMB output files .rep, .par, and .cor and return an R object of type 'list'
#'
#' @author Steve Martell, Anders Nielsen, Athol Whitten, D'Arcy N. Webber
#' @param repfile ADMB output files to be read (no extension needed)
#' @return object of type 'list' with ADMB outputs as list elements
#' @export
#' 
read_admb <- function(repfile)
{
    ret <- read_fit(repfile)
    fn <- paste0(repfile, ".rep")
    A <- read_rep(fn)
    A$fit <- ret
    A$run_name <- fn
    pfn <- paste0(repfile, ".psv")
    if (file.exists(pfn)) A$post.samp <- read_psv(pfn)
    return(A)
}


#' Read ADMB .par, .std, and .cor file and return an R object of type 'list' of estimates and correlations
#'
#' @author Steve Martell, Anders Nielsen, Athol Whitten, D'Arcy N. Webber
#' @param repfile name of ADMB output file to be read (no extension needed)
#' @return object of type 'list' with ADMB outputs therein
#' @export
#' 
read_fit <- function(repfile)
{
    ret <- list()
    parfile <- as.numeric(scan(paste0(repfile, ".par"), what = '', n=16, quiet=TRUE)[c(6,11,16)])
    ret$nopar <- as.integer(parfile[1])
    ret$nlogl <- parfile[2]
    ret$maxgrad <- parfile[3]
    file <- paste0(repfile, ".cor")
    if (file.exists(file))
    {
        lin <- readLines(file)
        ret$npar <- length(lin)-2
        ret$logDetHess <- as.numeric(strsplit(lin[1], '=')[[1]][2])
        sublin <- lapply(strsplit(lin[1:ret$npar+2], ' '),function(x)x[x!=''])
        ret$names <- unlist(lapply(sublin,function(x)x[2]))
        ret$est <- as.numeric(unlist(lapply(sublin,function(x)x[3])))
        ret$std <- as.numeric(unlist(lapply(sublin,function(x)x[4])))
        ret$cor <- matrix(NA, ret$npar, ret$npar)
        corvec <- unlist(sapply(1:length(sublin), function(i)sublin[[i]][5:(4+i)]))
        ret$cor[upper.tri(ret$cor, diag=TRUE)] <- as.numeric(corvec)
        ret$cor[lower.tri(ret$cor)]  <-  t(ret$cor)[lower.tri(ret$cor)]
        ret$cov <- ret$cor*(ret$std%o%ret$std)
    }
    return(ret)
}


#' Read ADMB .rep file
#'
#' Read ADMB .rep file and return an R object of type 'list'
#'
#' @author Steve Martell, D'Arcy N. Webber
#' @param fn name of ADMB output file to be read (no extension needed)
#' @return object of type "list" with ADMB outputs therein
#' @export
#' 
read_rep <- function(fn)
{
    options(warn = -1) # Suppress the NA message in the coercion to double
    repfile <- scan(fn, what = "character", flush = TRUE, blank.lines.skip = FALSE, quiet = TRUE, na.strings = c("nan","-nan"))
    #repfile <- scan(fn, what = "character", flush = TRUE, blank.lines.skip = FALSE, quiet = TRUE)
    inan <- which(is.na(repfile)) # Identify any nan entries so that they are not picked up as objects
    idx <- sapply(as.double(repfile), is.na)
    idx[inan] <- FALSE
    vnam <- repfile[idx] # list names
    nv <- length(vnam) # number of objects
    A <- list()
    ir <- 0
    for (i in 1:nv)
    {
        ir <- match(vnam[i], repfile)
        if (i != nv)
        {
            irr <- match(vnam[i+1], repfile)
        } else {
            irr <- length(repfile) + 1 # next row
        }
        dum <- NA
        if (irr-ir == 2)
        {
            dum <- as.double(scan(fn, skip = ir, nlines = 1, quiet = TRUE, what = ""))
        }
        if (irr-ir > 2)
        {
			# ncols <- 0
			# irows <- ir:irr-1
			# for(j in irows)
			# {
			# 	tmp=as.double(scan(fn,skip=j,nlines=1,quiet=TRUE,what=""))
			# 	if(length(tmp)>ncols) ncols <- length(tmp)
			# 	#print(paste(1:ncols))
			# }
			# cname <- paste(1:ncols)
			# dum=as.matrix(read.table(fn,skip=ir,nrow=irr-ir-1,fill=TRUE,col.names=cname))
			# cat("\n ir ",ir," irr ",irr)
            dum <- as.matrix(read.table(fn, skip = ir, nrow = irr-ir-1, fill = TRUE, row.names = NULL))
        }
        if (is.numeric(dum)) # Logical test to ensure dealing with numbers
        {
            A[[vnam[i]]] <- dum
        }
    }
    options(warn = 0)
    return(A)
}


#' Read ADMB .psv file
#'
#' Read ADMB .psv file and return an R object of type 'list'
#'
#' @author Steve Martell
#' @param repfile name of ADMB output file to be read (no extension needed)
#' @return object of type 'list' with ADMB outputs therein
#' @export
#' 
read_psv <- function(fn, nsamples=10000)
{
	#This function reads the binary output from ADMB
	#-mcsave command line option.
	#fn = paste(repfile,'.psv',sep='')
	filen <- file(fn, "rb")
	nopar <- readBin(filen, what = integer(), n = 1)
	mcmc 	<- readBin(filen, what = numeric(), n = nopar * nsamples)
	mcmc 	<- matrix(mcmc, byrow = TRUE, ncol = nopar)
	close(filen)
	return(mcmc)
}


#' Read ADMB .ctl file
#'
#' Read ADMB .ctl file and return an R object of type 'list'. DOES NOT WORK
#'
#' @author D'Arcy N. Webber
#' @param repfile name of ADMB output file to be read
#' @return object of type 'list' with ADMB outputs therein
#' @export
#' 
read_ctl <- function(fn)
{
    options(warn = -1) # Suppress the NA message in the coercion to double
    repfile <- scan(fn, what = "character", flush = TRUE, blank.lines.skip = FALSE,
                    quiet = TRUE)
    idx <- sapply(as.double(repfile), is.na)
    vnam <- repfile[idx] #list names
    # cat(vnam)
    nv 		<- length(vnam) #number of objects
    A 		<- list()
    ir 		<- 0
    for(i in 1:nv)
    {
        ir <- match(vnam[i],repfile)
        if(i!=nv) irr=match(vnam[i+1],repfile) else irr=length(repfile)+1 #next row
        dum=NA
        if(irr-ir==2) dum=as.double(scan(fn,skip=ir,nlines=1,quiet=TRUE,what=""))
        if(irr-ir>2)
        {
            dum=as.matrix(read.table(fn,skip=ir,nrow=irr-ir-1,fill=TRUE,row.names = NULL))
        }
        if(is.numeric(dum))#Logical test to ensure dealing with numbers
        {
            A[[vnam[i]]]=dum
        }
    }
    options(warn=0)
    return(A)
}


# A simple function for creating transparent colors
# Author: Nathan Stephens (hacks package)
colr <- function(col.pal=1,a=1)
{
    col.rgb<-col2rgb(col.pal)/255
    rgb(t(col.rgb),alpha=a)
}

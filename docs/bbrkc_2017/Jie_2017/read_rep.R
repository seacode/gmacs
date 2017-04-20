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
                        #       tmp=as.double(scan(fn,skip=j,nlines=1,quiet=TRUE,what=""))
                        #       if(length(tmp)>ncols) ncols <- length(tmp)
                        #       #print(paste(1:ncols))
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

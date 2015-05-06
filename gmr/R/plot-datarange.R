#' Plot data range by fleet and year 
#'
#' @param M List object(s) created by read_admb function
#' @return Plot of data range 
#' @author Ian Taylor, Huihua Lee, Jim Ianelli
#' @export
plot_datarange <-function(M)
{
  n  <- length(M)
  mdf<- NULL
  for(i in 1:n)
  {
    A <- M[[i]]
    #repfile   <- paste(deparse(substitute(M)),".rep",sep="")
    repfile   <- A$run_name
    print(repfile)
    narepfile <- strsplit(scan(repfile,what="character",flush=TRUE,blank.lines.skip=FALSE,quiet=TRUE)[1:4],':')
    
    startyr       <- A$mod_yrs[1]
    endyr         <- A$mod_yrs[length(A$mod_yrs)]
    nfleets       <- length(narepfile[[2]]) + length(narepfile[[4]])
    nfishfleets   <- length(narepfile[[2]]) 
    fleetnames    <- c(narepfile[[2]], narepfile[[4]])
    
    df <- as.data.frame(A$dCatchData)
    colnames(df)<- c("year","seas","fleet","sex","obs","cv","type","units","mult","effort","discard_mort")
    
    retainedcatch <- df[df$type==1,]
    discards <- df[df$type==2,]
    cpue <- as.data.frame(A$dSurveyData)
    colnames(cpue)<- c("year","seas","fleet","sex","obs","cv","units")
    size <- as.data.frame(A$d3_SizeComps)
    colnames(size)<- c("year","seas","fleet","sex","type","shell","maturity","Nsamp",as.character(A$mid_points))
    
    typetable <- matrix(c("retainedcatch",    "Retained_Catch",         
                          "discards",    "Discards",         
                          "cpue",     "Abundance indices",                          
                          "size",     "Size compositions"),ncol=2,byrow=TRUE)       
    
    typenames <- typetable[,1]
    typelabels <- typetable[,2]
    
    # loop over types to make a database of years with comp data
    ntypes <- 0
    # replace typetable object with empty table
    typetable <- NULL
    # now loop over typenames looking for presence of this data type
    for(itype in 1:length(typenames)){        
        dat <- get(typenames[itype])
        typename <- typenames[itype]
        if(!is.null(dat) && !is.na(dat) && nrow(dat)>0){
            ntypes <- ntypes+1
            for(ifleet in 1:nfleets){                
                allyrs <- NULL
                # identify years from different data types
                #if(typename=="catch" & ifleet<=nfishfleets) allyrs <- dat$Yr[dat[,ifleet]>0]
                if(typename %in%  c("retainedcatch","discards") & ifleet<=nfishfleets) 
                {
                    allyrs <- dat$year[dat$fleet==ifleet]
                }
                
                if(typename %in% "cpue") allyrs <- dat$year[dat$fleet==ifleet]
                if(typename %in% "size") allyrs <- dat$year[dat$fleet==ifleet]
                # expand table of years with data
                if(!is.null(allyrs) & length(allyrs)>0){
                    yrs <- sort(unique(floor(allyrs)))
                    typetable <- rbind(typetable,
                                       data.frame(yr=yrs,fleet=ifleet,
                                                  itype=ntypes,typename=typename,
                                                  stringsAsFactors=FALSE))
                }
            }
        }
    }
    
    ntypes <- max(typetable$itype)
    fleets <- sort(unique(typetable$fleet))
  }
    
    plotdata <-  function()
    {
        margins=c(5.1,2.1,4.1,8.1)  
        par(mar=margins) # multi-panel plot
        xlim <- c(-1,1)+range(typetable$yr,na.rm=TRUE)
        yval <- 0
        # count number of unique combinations of fleet and data type
        ymax <- sum(as.data.frame(table(typetable$fleet,typetable$itype))$Freq>0)
        plot(0,xlim=xlim,ylim=c(0,ymax+ntypes+.5),axes=FALSE,xaxs='i',yaxs='i',
             type="n",xlab="Year",ylab="",main="Data by type and year",cex.main=1.5)
        xticks <- 5*round(xlim[1]:xlim[2]/5)
        abline(v=xticks,col='grey',lty=3)
        axistable <- data.frame(fleet=rep(NA,ymax),yval=NA)
        itick <- 1
        for(itype in rev(unique(typetable$itype))){
            typename <- unique(typetable$typename[typetable$itype==itype])
            #fleets <- sort(unique(typetable2$fleet[typetable2$itype==itype]))
            for(ifleet in rev(fleets)){                
                yrs <- typetable$yr[typetable$fleet==ifleet & typetable$itype==itype]
                if(length(yrs)>0){
                    yval <- yval+1
                    x <- min(yrs):max(yrs)
                    n <- length(x)
                    y <- rep(yval,n)
                    y[!x%in%yrs] <- NA
                    # identify solo points (no data from adjacent years)
                    solo <- rep(FALSE,n)
                    if(n==1) solo <- 1
                    if(n==2 & yrs[2]!=yrs[1]+1) solo <- rep(TRUE,2)
                    if(n>=3){
                        for(i in 2:(n-1)) if(is.na(y[i-1]) & is.na(y[i+1])) solo[i] <- TRUE
                        if(is.na(y[2])) solo[1] <- TRUE
                        if(is.na(y[n-1])) solo[n] <- TRUE
                    }
                    # add points and lines
                    points(x[solo], y[solo], pch=16, cex=2,col=rainbow(nfleets)[ifleet])
                    lines(x, y, lwd=12,col=rainbow(nfleets)[ifleet])
                    axistable[itick,] <- c(ifleet,yval)
                    itick <- itick+1
                }
            }
            
            yval <- yval+1
            if(itype!=1) abline(h=yval,col='grey',lty=3)
            text(mean(xlim),yval-.3,typelabels[typenames==typename],font=2)
        }
        
        axis(4,at=axistable$yval,labels=fleetnames[axistable$fleet],las=1)
        box()
        axis(1,at=xticks)        
    }
    pdatarange <- plotdata()
	return(pdatarange)
}

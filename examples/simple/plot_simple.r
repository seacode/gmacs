Figs <- function(Dirn,File1,File2,Iskip,Jskip,FishFleets,SurvFleets,PlotAll=T,DiagOut=T,IsStdDev=T,cases=c(T,T,T,T,T,T),Nclass=5)
{
 File1 <- paste(Dirn,File1,sep="")
 File2 <- paste(Dirn,File2,sep="")

 AA <- scan(File1,n=4,quiet=T)
 Yr1 <- AA[1]
 Yr2 <- AA[2]
 Nfleet <- AA[3] + 1
 Nsurvey <- AA[4] 
 LFs <- scan(File1,skip=1,n=Nfleet,quiet=T)
 SLFs <- scan(File1,skip=2,n=Nsurvey,quiet=T)
 print(File1)
 cat(Yr1,Yr2,Nfleet,Nsurvey,"\n")
 cat("Number of fishery LFs: ",LFs,"\n")
 cat("Number of survey LFS: ",SLFs,"\n")
 cat("Initial Skip ",Iskip,"\n")
 YrRange <- Yr1:Yr2
 
 Nyrs <- (Yr2-Yr1+1)
 NyrsS <- (Yr2-Yr1+1) + 1
 NfleetE <- Nfleet - 1

 CLenf <- array(0,dim=c(Nfleet,100,7))
 SLenf <- array(0,dim=c(Nsurvey,100,7))

 # Natural mortality
 Skip <- Iskip
 M <- scan(File1,skip=Skip,n=Nyrs,quiet=T)  
 Skip <- Skip + 5+Nclass
 
 #Selex input
 Retain <- matrix(scan(File1,skip=Skip,n=(Nclass+1)*Nyrs,quiet=T),ncol=(Nclass+1),byrow=T)[,2:(Nclass+1)]
 Skip <- Skip + Nyrs + 1
 FishSelex <- array(NA,dim=c(Nfleet-1,Nyrs,Nclass))
 for (Ifleet in 1:(Nfleet-1))
  {
   FishSelex[Ifleet,,] <- matrix(scan(File1,skip=Skip+1,n=(Nclass+1)*Nyrs,quiet=T),ncol=(Nclass+1),byrow=T)[,2:(Nclass+1)]
   Skip <- Skip + Nyrs + 1
  }
 Skip <- Skip + 1
 SurvSelex <- array(NA,dim=c(Nsurvey,Nyrs+1,Nclass))
 for (Ifleet in 1:Nsurvey)
  {
   SurvSelex[Ifleet,,] <- matrix(scan(File1,skip=Skip+1,n=(Nclass+1)*(Nyrs+1),quiet=T),ncol=(Nclass+1),byrow=T)[,2:(Nclass+1)]
   Skip <- Skip + Nyrs + 2
  }
 Skip <- Skip + 1
 
 # Exploition rate
 Skip <- Skip + 2 + Nyrs + 2
 Exploit <- matrix(scan(File1,skip=Skip,n=Nfleet*Nyrs,quiet=T),ncol=Nfleet,byrow=T)
 Skip <- Skip + Nyrs + 2
 
 TheCatch <- matrix(scan(File1,skip=Skip,n=Nyrs*(Nfleet*2+1),quiet=T),ncol=Nfleet*2+1,byrow=T)
 Skip <- Skip + Nyrs+2
 TheSurvey <- matrix(scan(File1,skip=Skip,n=NyrsS*(Nsurvey*3+1),quiet=T),ncol=Nsurvey*3+1,byrow=T)
 Skip <- Skip + NyrsS+2
 TheEffort <- matrix(scan(File1,skip=Skip,n=Nyrs*(NfleetE*2+1),quiet=T),ncol=NfleetE*2+1,byrow=T)
 Skip <- Skip + Nyrs + 2
 
 Recs <- scan(File1,skip=Skip,n=Nyrs,quiet=T)
 Skip <- Skip + 3
 MMB <- scan(File1,skip=Skip,n=Nyrs,quiet=T)
 
 Skip <- Skip + 3 + Nfleet+ sum(LFs)+ Nsurvey + sum(SLFs)
 cat("Catch, Index and Effort entered",Skip,"\n")

 if (IsStdDev == T)
  {
   Skip2 <- Jskip
   LogMMB <- read.table(File2,skip=Skip2,nrow=Nyrs)
   Skip2 <- Jskip + Nyrs
   LogRec <- read.table(File2,skip=Skip2,nrow=Nyrs)
  }

 for (Ifleet in 1:Nfleet)
  {
   cat("Fleet: ",Ifleet,Skip,"\n")
   if (LFs[Ifleet] > 0)
    for (Iyr in 1:(LFs[Ifleet]*2))
     CLenf[Ifleet,Iyr,] <- scan(File1,skip=Skip+(Iyr-1),n=7,quiet=T)
   Skip <- Skip + LFs[Ifleet]*2+1
  }
 
 for (Ifleet in 1:Nsurvey)
  {
   cat("Survey: ",Ifleet,Skip,"\n")
   if (SLFs[Ifleet] > 0)
    {
     for (Iyr in 1:(SLFs[Ifleet]*2))
      SLenf[Ifleet,Iyr,] <- scan(File1,skip=Skip+(Iyr-1),n=7,quiet=T)
    }  
   Skip <- Skip + SLFs[Ifleet]*2+1
  }
 cat("Catch, and Index LF data entered",Skip,"\n")

 # Basic outputs
 if (cases[1] == TRUE)
  {
   par(mfrow=c(2,2))
   ymax <- max(M)*1.1
   plot(YrRange,M,type='l',lwd=1,lty=1,xlab="Year",ylab="M",ylim=c(0,ymax))
   ymax <- max(Recs)*1.05
   plot(YrRange,Recs,type='l',lwd=2,lty=1,xlab="Year",ylab="Recruitment",ylim=c(0,ymax))
   if (IsStdDev==T)
    {
     for (II in 1:length(Recs))
      lines(c(YrRange[II],YrRange[II]),c(Recs[II]*exp(-1.96*LogRec[II,4]),Recs[II]*exp(1.96*LogRec[II,4])),lty=1)
    }
   ymax <- max(MMB)*1.05
   plot(YrRange,MMB,type='l',lwd=2,lty=1,xlab="Year",ylab="MMB",ylim=c(0,ymax))
   if (IsStdDev==T)
    {
     for (II in 1:length(Recs))
      lines(c(YrRange[II],YrRange[II]),c(MMB[II]*exp(-1.96*LogMMB[II,4]),MMB[II]*exp(1.96*LogMMB[II,4])),lty=1)
    }
   } 

 # Selex
 if (cases[2] == TRUE)
  {
   op <- par()
   par(mfrow=c(2,2))
   plotSelex(Yr1,Yr2,Nclass,Retain,"Probability of Retention")
   for (Ifleet in 1:(Nfleet-1))
    {
     ymax <- max(FishSelex)*1.05
     plotSelex(Yr1,Yr2,Nclass,FishSelex[Ifleet,,],"Selectivity")
     title(paste("Fishery ",Ifleet))
    }
   for (Ifleet in 1:Nsurvey)
    {
     ymax <- max(SurvSelex)*1.05
     plotSelex(Yr1,Yr2+1,Nclass,SurvSelex[Ifleet,,],"Selectivity")
     title(paste("Survey ",Ifleet))
    }
   par(op) 
  } 

 if (cases[3] == TRUE)
  {
   par(mfrow=c(3,2))
   yrs <- TheCatch[,1]
   for (Ifleet in 1:Nfleet)
    {
     ymax <- max(TheCatch[,Ifleet*2],TheCatch[,Ifleet*2+1])*1.1
     Use <- TheCatch[,Ifleet*2] > 0
     plot(yrs[Use],TheCatch[Use,Ifleet*2],pch=16,xlab="Year",ylab="Catch (t)",ylim=c(0.01,ymax),xlim=c(min(yrs),max(yrs)))
     lines(yrs,TheCatch[,Ifleet*2+1],lty=1)
     title(FishFleets[Ifleet])
    }
   if (DiagOut==T) cat("Catch plots completed","\n") 
  } 

 if (cases[4] == TRUE)
  {
   par(mfrow=c(2,2))
   yrs <- TheSurvey[,1]
   for (Ifleet in 1:Nsurvey)
    {
     ymax <- max(TheSurvey[,(Ifleet-1)*3+2]*exp(1.96*TheSurvey[,(Ifleet-1)*3+3]),TheSurvey[,(Ifleet-1)*3+4])*1.1
     Use <- TheSurvey[,(Ifleet-1)*3+2] > 0
     plot(yrs[Use],TheSurvey[Use,(Ifleet-1)*3+2],pch=16,xlab="Year",ylab="Survey index",ylim=c(0.01,ymax),xlim=c(min(yrs),max(yrs)),yaxs="i")
     lines(yrs,TheSurvey[,(Ifleet-1)*3+4],lty=1)
     title(SurvFleets[Ifleet])
     for (II in 1:length(yrs))
      if (Use[II]==T)
       {
        Est <- TheSurvey[II,(Ifleet-1)*3+2]
        CV <- TheSurvey[II,(Ifleet-1)*3+3]
        if (Est > 0)
         {
          cat(II,yrs[II],CV,Est*exp(-1.96*CV),Est*exp(1.96*CV),"\n")
          lines(rep(yrs[II],2),c(Est*exp(-1.96*CV),Est*exp(1.96*CV)),lty=1)
         } 
       }
    }
   if (DiagOut==T) cat("Survey plots completed","\n") 
  }  

 if (cases[5] == TRUE)
  {
   par(mfrow=c(3,2))
   yrs <- TheEffort[,1]
   for (Ifleet in 1:NfleetE)
    {
     ymax <- max(TheEffort[,Ifleet*2],TheEffort[,Ifleet*2+1])*1.1
     Use <- TheEffort[,Ifleet*2] > 0
     plot(yrs[Use],TheEffort[Use,Ifleet*2],pch=16,xlab="Year",ylab="Effort",ylim=c(0.01,ymax),xlim=c(min(yrs),max(yrs)))
     lines(yrs,TheEffort[,Ifleet*2+1],lty=1)
     title(FishFleets[Ifleet+1])
    }
   if (DiagOut==T) cat("Effort plots completed","\n") 
  } 

 if (cases[6] == T)
  {
   for (Ifleet in 1:Nfleet)
    PlotLF(CLenf[Ifleet,,],LFs[Ifleet],5,Ifleet,FishFleets,All=PlotAll)
   if (DiagOut==T) cat("Catch LF plots completed","\n") 

   for (Ifleet in 1:Nsurvey)
    PlotLF(SLenf[Ifleet,,],SLFs[Ifleet],5,Ifleet,SurvFleets,All=PlotAll)
   if (DiagOut==T) cat("Survey LF plots completed","\n") 
  }  


}
# =======================================================================
plotSelex <- function(Yr1,Yr2,Nclass,Selex,ylabb)
{
  print(Selex)

  xx <- seq(from=Yr1,to=Yr2,by=1)
  yy <- seq(from=1,to=Nclass,by=1)
  zz <- Selex
  zmax <- max(1.0,zz)*1.05
  persp(x=xx,y=yy,z=zz,ticktype="detailed",ntick=4,xlab="\n\nYear",ylab="\nSize-class",zlab=paste("\n\n",ylabb,sep=""),zlim=c(0,zmax),phi=30,theta=60,shade=0.00001)
} 
# =======================================================================

PlotLF <- function(Lenf,NlenY,Nlen,Ifleet,FleetNames,All=T)
{
 
 op <- par(no.readonly = TRUE)
 if (All==F)
  par(mfrow=c(2,2))
 else
  par(mfrow=c(4,3),mar=c(4, 4, 2, 1) + 0.05)
 lens <- 1:Nlen
 TotObs <- rep(0,Nlen)
 TotPred <- rep(0,Nlen)
 SSInp <- NULL
 SSOut <- NULL
 Resid <- matrix(0,nrow=42,ncol=Nlen)
 if (NlenY <= 0) return()
 for (Iyr in 1:NlenY)
  {
   Obs <- Lenf[(Iyr-1)*2+1,3:(Nlen+2)]
   Pred <- Lenf[(Iyr-1)*2+2,3:(Nlen+2)] 
   SSInp <- c(SSInp,Lenf[(Iyr-1)*2+1,2])
   SSOut <- c(SSOut,Lenf[(Iyr-1)*2+2,2])
   TotObs <- TotObs + Obs
   TotPred <- TotPred + Pred
   Yr <- Lenf[(Iyr-1)*2+1,1]
   Nobs <- Lenf[(Iyr-1)*2+1,2]
   
   if (All==T) plot(lens,rep(1,length(lens)),xlab="Length-class",ylab="Proportion",ylim=c(0,1.05),xlim=c(0.5,Nlen+0.5),xaxs="i",yaxs="i",type='n')
   for (Ilen in 1:Nlen)
    {
     xx <- c(Ilen-0.5,Ilen-0.5,Ilen+0.5,Ilen+0.5,Ilen-0.5)
     yy <- c(0,Obs[Ilen],Obs[Ilen],0,0)
     Varn <- Pred[Ilen]*(1-Pred[Ilen])/Nobs
     if (Varn == 0) Varn <- 0.001
     Resid[Yr-1970+1,Ilen] <- (Obs[Ilen]-Pred[Ilen])/sqrt(Varn)
     if (All==T) polygon(xx,yy,lty=1,lwd=2) 
    }   
   if (All==T) lines(lens,Pred)   
   if (All==T) title(Yr)
  }
 plot(lens,rep(1,length(lens)),xlab="Length-class",ylab="Proportion",ylim=c(0,1.05),xlim=c(0.5,Nlen+0.5),xaxs="i",yaxs="i",type='n')
 points(lens,TotObs/NlenY,pch=16)
 lines(lens,TotPred/NlenY)   
 title("Overall") 

 xmax <- max(SSOut,SSInp)
 hist(SSOut,xlab="Effective sample size",xaxs="i",main="",xlim=c(0,xmax))
 abline(v=median(SSInp),lwd=5)
 plot(SSInp,SSOut,xlab="Input sample size",ylab="Output sample size")

 Inc <- 0.01
 Jpnt <- 0
 xx <- matrix(0,ncol=3,nrow=1000)
 for (Ilen in 1:Nlen)
  for (Iyear in 1970:2011) 
   if (Resid[Iyear-1970+1,Ilen] > 0)
    {
     Jpnt <- Jpnt + 1
     xx[Jpnt,1] <- Ilen
     xx[Jpnt,2] <- Iyear
     xx[Jpnt,3] <- Resid[Iyear-1970+1,Ilen]
    }
 xx <- xx[1:Jpnt,]   
 Kpnt <- 0
 yy <- matrix(0,ncol=3,nrow=1000)
 for (Ilen in 1:Nlen)
  for (Iyear in 1970:2011) 
   if (Resid[Iyear-1970+1,Ilen] < 0)
    {
     Kpnt <- Kpnt + 1
     yy[Kpnt,1] <- Ilen
     yy[Kpnt,2] <- Iyear
     yy[Kpnt,3] <- -Resid[Iyear-1970+1,Ilen]
    }
 yy <- yy[1:Kpnt,]   
 if (Jpnt+Kpnt > 0)
  {
   symbols(xx[,1],xx[,2],circles=xx[,3],inches=0.1,bg="black",ylim=c(1972,2011),xlim=c(0.5,Nlen+0.5),xlab="Size-class",ylab="Year",axes=F)
   box()
   axis(2)
   axis(1)
   symbols(yy[,1],yy[,2],circles=yy[,3],inches=0.1,add=T)
   title(FleetNames[Ifleet])
  }    

 par(op) 
} 

# =======================================================================


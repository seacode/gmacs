setwd("D:\\Research\\gmacs\\gmacs-develop\\src13\\build\\St Matt\\")

yrs <- 1978:2017
Nyear <- length(yrs)
par(mfrow=c(3,3))

File1 <- read.table("mcoutRec.rep")
plot(File1[,1],xlab="cycle",ylab="Recruitment (1978)",pch=16)
plot(File1[,40],xlab="cycle",ylab="Recruitment (2017)",pch=16)

quant <- matrix(0,ncol=Nyear,nrow=5)
for (Icol in 1:Nyear)
 quant[,Icol] <- quantile(File1[,Icol],prob=c(0.05,0.25,0.5,0.75,0.95))
ymax <- max(quant)*1.05
plot(yrs,quant[3,],xlab="Year",ylab="Recruitment",ylim=c(0,ymax),yaxs="i",type="l") 
xx <- c(yrs,rev(yrs))
yy <- c(quant[1,],rev(quant[5,]))
polygon(xx,yy,col="gray50")
xx <- c(yrs,rev(yrs))
yy <- c(quant[2,],rev(quant[4,]))
polygon(xx,yy,col="gray90")
lines(yrs,quant[3,],lwd=2,col="red")

File1 <- read.table("mcoutSSB.rep")
print(File1)
plot(File1[,1],xlab="cycle",ylab="Mature Male Biomass (1978)",pch=16)
plot(File1[,40],xlab="cycle",ylab="Mature Male Biomass (2017)",pch=16)

quant <- matrix(0,ncol=Nyear,nrow=5)
for (Icol in 1:Nyear)
  quant[,Icol] <- quantile(File1[,Icol],prob=c(0.05,0.25,0.5,0.75,0.95))
ymax <- max(quant)*1.05
plot(yrs,quant[3,],xlab="Year",ylab="Mature Male Biomass",ylim=c(0,ymax),yaxs="i",type="l") 
xx <- c(yrs,rev(yrs))
yy <- c(quant[1,],rev(quant[5,]))
polygon(xx,yy,col="gray50")
xx <- c(yrs,rev(yrs))
yy <- c(quant[2,],rev(quant[4,]))
polygon(xx,yy,col="gray90")
lines(yrs,quant[3,],lwd=2,col="red")

ssbEst <- scan("Gmacsall.out",skip=3540,n=Nyear)
print(ssbEst)
lines(yrs,ssbEst,lty=2,lwd=2,col="blue")

plot(log(File1[,1]),xlab="cycle",ylab="log(Mature Male Biomass) (1978)",pch=16)
plot(log(File1[,40]),xlab="cycle",ylab="log(Mature Male Biomass) (2017)",pch=16)

quant <- log(quant)
ymax <- max(quant)*1.05
plot(yrs,quant[3,],xlab="Year",ylab="Mature Male Biomass",ylim=c(6,ymax),yaxs="i",type="l") 
xx <- c(yrs,rev(yrs))
yy <- c(quant[1,],rev(quant[5,]))
polygon(xx,yy,col="gray50")
xx <- c(yrs,rev(yrs))
yy <- c(quant[2,],rev(quant[4,]))
polygon(xx,yy,col="gray90")
lines(yrs,quant[3,],lwd=2,col="red")

ssbEst <- scan("Gmacsall.out",skip=3540,n=Nyear)
lines(yrs,log(ssbEst),lty=2,lwd=2,col="blue")

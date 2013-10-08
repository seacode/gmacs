# Rscript for GCM.R
# --------------------------------------------------------------------------- #
# List of Figures:
# 	plot.mmb() 	-> mature male biomass
# 	plot.ft()	-> fishing mortality rate
# 	plot.ct()	-> plot observed & predicted catch
# --------------------------------------------------------------------------- #

require(PBSmodelling)
source("gcmView.R")
source("read.admb.r")
A=read.admb("GCM")

.plotMMB	<- function(A)
{
	par(mfcol=c(1, 1), mar=c(4, 4, 1, 1))
	with(A, {
		plot(yrs, mmb, type="l", xlab="Year", ylab="Mature male biomass (t)", 
			ylim=c(0, max(mmb)))
	})
}

plot.ft		<- function(A)
{
	with(A, {
		matplot(yr, F, type="l", xlab="Year", ylab="Fishing mortality rate")
	})
}

.plotCatch		<- function(A)
{
	opar <- par(no.readonly=T)
	par(mfrow=c(2, 2), mar=c(4, 5, 1, 1))
	with(A, {
		matplot(t(yrs_ct), t(obs_ct), type="o", xlab="Year", 
		ylab="Retained catch\n(metric tons)", pch=1:2)
		
		matplot(t(yrs_ct), t(obs_ct_dis), type="o", xlab="Year", 
		ylab="Discarded catch\n(metric tons)", pch=1:2)
	})
	
	.plot.epsilon(A)
	.plot.delta(A)
	
	par(opar)
}

.plotCPUE		<- function(A)
{
	# plot observed and predicted cpue, 
	# and residual below and qqplot below that.
	# Must standardize the residuals
	opar <- par(no.readonly=T)
	with(A, {
		n <- dim(obs_it)[1]
		par(mfcol=c(3, n), mar=c(4, 4, 1, 1))
		for(i in 1:n)
		{
			xx = yrs_it[i, ]
			yy = cbind(obs_it[i, ], pred_it[i, ])
			matplot(xx , yy, type="o", pch=c(19, 1), lty=c(0, 1)
				, xlab="Year", ylab="CPUE" , col=1, ylim=c(0,1.5*max(yy, na.rm=T)))
			legend("topleft", c("Observed","Predicted"), bty="n"
				, pch=c(19, 1), lty=c(0, 1))
				
			se <- 1.96*cpue_sig[i]/rwt_it[i, ]*yy[, 1]
			arrows(xx, yy[, 1]-se, xx, yy[, 1]+se, code=3, angle=90, length=0.025)
			
			sig <- cpue_sig[i]/rwt_it[i, ]
			sdnr<-round(sd(nu[i, ]/sig, na.rm=T), 3)
			print(mean(nu[i, ], na.rm=T))
			plot( yrs_it[i, ], nu[i, ]/sig, type="h", pch=19 
				, xlab="Year", ylab="Residual (CPUE))" )
			legend("topleft", paste("SDNR =", sdnr), bty="n")
			
			qqnorm(nu[i, ]/sig)
			qqline(nu[i, ]/sig)
		}
		
	})
	par(opar)
}

.plot.epsilon	<- function(A)
{
	# plot catch residuals
	with(A, {
		matplot(t(yrs_ct), t(epsilon), type="h", xlab="Year", ylab="Catch residuals")
		matpoints(t(yrs_ct), t(epsilon), pch=1:2)
	})
}

.plot.delta	<- function(A)
{
	# plot catch residuals
	with(A, {
		matplot(t(yrs_ct), t(delta), type="h", xlab="Year", ylab="Discard residuals")
		matpoints(t(yrs_ct), t(delta), pch=1:2)
	})
}


plot.nu	<- function(A)
{
	# plot residuals in cpue series
	with(A, {
		matplot(t(yrs_it), t(nu), type="h", xlab="Year", ylab="CPUE residuals")
	})
}

.plotLF		<- function(A)
{
	# plot observed and predicted length frequencies by gear and year
	opar <- par(no.readonly=T)
	with(A, {
		ii=1; jj=cumsum(n_lf_rows)
		for(i in 1:length(n_lf_rows))
		{
			ir <- which(lf_data[, 2]==i)
			ir <- ii:jj[i]; ii=jj[i]+1
			ob <- obs_lf[ir, ]
			pr <- pred_lf[ir, ]
			
			n  <- length(ir)
			nc <- 4
			if(n%%nc) nr <- as.integer(n/nc) + 1 else nr <- n/nc
			
			
			par(mfcol=c(nr, nc), las=1, mar=c(1, 2, 1, 1), oma=c(3, 3, 1, 1))
			for(j in 1:n)
			{
				plot(xbin, ob[j, ], ylim=c(0, 0.5), ylab="", xlab="")
				lines(xbin, pr[j, ])
				title(main=lf_data[ir[j], 1], line=-1)
			}
		}
	})
	par <- opar
}

.plotLFR	<- function(A)
{
	# plot residuals between observed and predicted lfs
	par(mfcol=c(1, 1))
	with(A, {
		ii = 1; jj=cumsum(n_lf_rows)
		for(i in 1:length(n_lf_rows))
		{
			ir <- ii:jj[i]; ii=jj[i]+1
			xx <- lf_data[ir, 1]
			plotBubbles(t(eta[ir, ]), x=xx, y=xbin,
			xlab="Year", ylab="Carapace width (mm)", hide0=T)
		}
	})
	
}

# plot spawning stock biomass

plot.ssb  <- function(M)
{
	n   <- length(M)
	mdf <- NULL
	for(i in 1:n)
	{
		A  <- M[[i]]
		df <- data.frame(Model=names(M)[i],
		                 par = A$fit$names,
		                 log_mmb=A$fit$est,
		                 log_sd=A$fit$std)
		df      <- subset(df,par == "sd_log_mmb")
		df$year <- A$mod_yrs
		df$mmb  <- exp(df$log_mmb)
		df$lb   <- exp(df$log_mmb - 1.96*df$log_sd)
		df$ub   <- exp(df$log_mmb + 1.96*df$log_sd)
		mdf     <- rbind(mdf,df)
	}

	p <- ggplot(mdf)
	p <- p + geom_line(aes(x=year,y=mmb,col=Model))
	p <- p + geom_ribbon(aes(x=year,ymax=ub,ymin=lb,fill=Model),alpha=0.3)
	p <- p + labs(x="Year",y="Spawning biomass")

	if(!.OVERLAY) p <- p + facet_wrap(~Model)

	print(p + .THEME)
}


  
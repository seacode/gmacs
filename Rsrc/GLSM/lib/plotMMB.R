require(ggplot2)
dfpar 	<- data.frame(par=A$fit$names,log_mmb=A$fit$est,log_sd=A$fit$std)
df 			<- subset(dfpar,par=="sd_log_mmb")[,-1]
df$year <- A$mod_yrs
df$lb   <- exp(df$log_mmb - 1.96*df$log_sd)
df$ub   <- exp(df$log_mmb + 1.96*df$log_sd)

p <- ggplot(df)
p <- p + geom_line(aes(x=year,y=exp(log_mmb)))
p <- p + geom_ribbon(aes(x=year,ymax=ub,ymin=lb),alpha=0.3)
p <- p + labs(x="Year",y="Mature Male Biomass")
pMMB <- p

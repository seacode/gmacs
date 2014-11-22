require(ggplot2)
dfpar 	<- data.frame(par=A$fit$names,log_rec=A$fit$est,log_sd=A$fit$std)
df 			<- subset(dfpar,par=="sd_log_recruits")[,-1]
df$year <- A$mod_yrs
df$lb   <- exp(df$log_rec - 1.96*df$log_sd)
df$ub   <- exp(df$log_rec + 1.96*df$log_sd)

p <- ggplot(df,aes(x=factor(year),y=exp(log_rec)))
p <- p + geom_bar(stat = "identity", alpha=0.4)
p <- p + geom_pointrange(aes(factor(year),exp(log_rec),ymax=ub,ymin=lb))
p <- p + labs(x="Year",y="Recruitment")
pRecruitment <- p
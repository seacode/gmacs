require(ggplot2)

# Observed CPUE
df <- as.data.frame(A$dSurveyData)
colnames(df) <- c("year","seas","fleet","sex","cpue","cv","units")
sd <- sqrt(log(1+df$cv^2))
df$lb <- exp(log(df$cpue)-1.96*sd)
df$ub <- exp(log(df$cpue)+1.96*sd)

p  <- ggplot(df,aes(year,cpue))
# p  <- p + geom_point(aes(col=sex))
p  <- p + geom_pointrange(aes(year,cpue,ymax=ub,ymin=lb,col=sex))
p  <- p + labs(x="Year",y="CPUE",col="Sex")
pCPUE  <- p + facet_wrap(~fleet,scales="free")


# Fitted CPUE
df$pred <- na.exclude(as.vector(t(A$pre_cpue)))
pCPUEfit <- pCPUE + geom_line(data=df,aes(year,pred))


# CPUE residuals
df$resd <- na.exclude(as.vector(t(A$res_cpue)))
p  <- ggplot(df,aes(factor(year),resd))
p  <- p + geom_bar(aes(fill=factor(sex)),stat = "identity", position="dodge")
p  <- p + scale_x_discrete(breaks=pretty(df$year))
p  <- p + labs(x="Year",y="CPUE Residuals",fill="Sex")
pCPUEres  <- p + facet_wrap(~fleet,scales="free_x")

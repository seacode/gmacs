# plt_cpue.R

.getCPUEdf <- function( M )
{
	n   <- length(M)
	mdf <- NULL
	for(i in 1:n)
	{
		A  <- M[[i]]
		df <- data.frame(Model=names(M)[i],
		             as.data.frame(A$dSurveyData))
		colnames(df) <- c("Model","year","seas","fleet","sex","cpue","cv","units")	
		df$sex = .SEX[df$sex+1]
		df$fleet = .FLEET[df$fleet]
		sd <- sqrt(log(1+df$cv^2))
		df$lb <- exp(log(df$cpue)-1.96*sd)
		df$ub <- exp(log(df$cpue)+1.96*sd)
		df$pred <- na.exclude(as.vector(t(A$pre_cpue)))
		df$resd <- na.exclude(as.vector(t(A$res_cpue)))

		mdf <- rbind(mdf,df)
	} 

	return(mdf)	
}


plot.cpue <- function( M )
{
	
	mdf <- .getCPUEdf( M )

	p  <- ggplot(mdf,aes(year,cpue,col=factor(sex)))
	p  <- p + geom_pointrange(aes(year,cpue,ymax=ub,ymin=lb,col=factor(sex)))
	if(.OVERLAY)
	{
		p  <- p + geom_line(data=mdf,aes(year,pred,linetype=Model))
		p  <- p + facet_wrap(~fleet+sex,scales="free_y")
	}
	else 
	{
		p  <- p + geom_line(data=mdf,aes(year,pred))
		p  <- p + facet_wrap(~fleet+sex+Model,scales="free_y")
	}
	p  <- p + labs(x="Year",y="CPUE",col="Sex")
	print(p + .THEME)

}

plot.cpue.res <- function( M )
{
	
	mdf <- .getCPUEdf( M )

	p  <- ggplot(mdf,aes(year,resd))
	if(.OVERLAY)
	{
		p  <- p + geom_bar(aes(fill=factor(Model)),stat = "identity", position="dodge")
		p  <- p + facet_wrap(~ sex + fleet)		
	}
	else
	{
		p  <- p + geom_bar(aes(fill=factor(sex)),stat = "identity", position="dodge")
		p  <- p + facet_wrap(~Model + sex + fleet)		
	}
	p  <- p + labs(x="Year",y="Residual (Observed - Predicted)",fill="Sex")
	print(p + .THEME)

}

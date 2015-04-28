# plt_catch.R

plot.catch <- function( M )
{
	n  <- length(M)
	mdf<- NULL
	for( i in 1:n )
	{
		A <- M[[i]]
		df <- data.frame(Model=names(M)[i],A$dCatchData)
		                   #       year  seas  fleet sex obs cv  type  units mult  effort  discard_mortality                                                         
		colnames(df) <- c("model","year","seas","fleet","sex","obs","cv","type","units","mult","effort","discard.mortality")
		df$observed  <- na.omit(as.vector(t(A$obs_catch)))
		df$predicted <- na.omit(as.vector(t(A$pre_catch)))
		df$residuals <- na.omit(as.vector(t(A$res_catch)))
		df$sex       <- .SEX[df$sex+1]
		df$fleet     <- .FLEET[df$fleet]
		df$type      <- .TYPE[df$type+1]
		
		sd    <- sqrt(log(1+df$cv^2))
		df$lb <- exp(log(df$observed)-1.96*sd)
		df$ub <- exp(log(df$observed)+1.96*sd)
		mdf = rbind(mdf,df)
	}

	p <- ggplot(mdf,aes(x=as.integer(year),y=observed,fill=sex))
	p <- p + geom_bar(stat="identity",position="dodge",alpha=0.5)
	p <- p + geom_pointrange(aes(as.integer(year),observed,ymax=ub,ymin=lb,position="dodge"),size=0.5,alpha=0.5)
	p <- p + geom_line(aes(x=as.integer(year),y=predicted),alpha=0.8)
	p <- p + labs(x="Year",y="Catch (kt)",fill="Sex")
	p <- p + facet_wrap(~model+sex+fleet+type,scales="free_y")
	print(p + .THEME)

}
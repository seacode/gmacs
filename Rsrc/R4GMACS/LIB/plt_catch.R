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
		df$predicted <- na.omit(as.vector(t(A$pre_catch)))
		df$residuals <- na.omit(as.vector(t(A$res_catch)))
		df$sex       <- .SEX[df$sex+1]
		df$fleet     <- .FLEET[df$fleet]
		df$type      <- .TYPE[df$type+1]
		mdf = rbind(mdf,df)
	}

	p <- ggplot(mdf,aes(x=factor(year),y=obs,fill=sex))
	p <- p + geom_bar(stat="identity",position="dodge")
	p <- p + scale_x_discrete(breaks=pretty(mdf$year))
	p <- p + labs(x="Year",y="Catch (kt)",fill="Sex",col="Type")
	p <- p + facet_wrap(~model+fleet+type,scales="free_y")
	print(p + .THEME)

}
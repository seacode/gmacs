# plt_GrowthTransition.R
# Must use the transpose of the G matrix for ggplot


plot.growthTransition <- function( M )
{
	n   <- length(M)
	mdf <- NULL
	for(i in 1:n)
	{
		x = M[[i]]$mid_points
		G = M[[i]]$tG
		h = dim(G)[1]/dim(G)[2]
		colnames(G) = paste(x)
		s  = .SEX[as.vector(sapply(1:h,rep,20))+1]
		df = data.frame(Model=names(M)[i],mp=x,sex=s,G)

		mdf <- rbind(mdf,df)
	}
	mdf = melt(mdf,id.var=c("Model","sex","mp"))

	p <- ggplot(mdf,aes(x=mp,y=value,col=Model,linetype=factor(sex)))
	p <- p + geom_line() 
	p <- p + labs(x="Size Bin (mm)",y="P(growth transition)",linetype="Sex")
	p <- p + facet_wrap(~variable)
	# if(!.OVERLAY) p <- p + facet_wrap(~Model)

	print(p + .THEME)
}
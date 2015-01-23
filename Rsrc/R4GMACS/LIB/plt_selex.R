# plt_selex.R

plot.selex <- function( M )
{
	n   <- length(M)
	mdf <- NULL
	for(i in 1:n)
	{
		df <- data.frame(Model=names(M)[i],
		                 M[[i]]$slx_capture)
		colnames(df) <- c("Model","year","sex","fleet",as.character(A$mid_points))
		df$sex = .SEX[df$sex+1]
		df$fleet = .FLEET[df$fleet]

		blkyr <- M[[i]]$slx_control[,12]
		df    <- filter(df,year %in% blkyr)

		mdf <- rbind(mdf,melt(df,id.var=1:4))
	}


	p <- ggplot(mdf)
	if(.OVERLAY)
	{
		p <- p + geom_line(aes(as.numeric(variable),value,col=Model,linetype=factor(year)))
		p <- p + facet_wrap(~sex+fleet)
	}
	else
	{
		p <- p + geom_line(aes(as.numeric(variable),value,col=sex,linetype=factor(year)))
		p <- p + facet_wrap(~Model+fleet)
	}
	p <- p + labs(y="Selectivity",
	              x="Mid point of size class (mm)",
	              col="Sex",
	              linetype="Block Year")


	print(p + .THEME)
}
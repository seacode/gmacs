# plt_sizeComps.R

get.df <- function(M) 
{
	n   <- length(M)
	mdf <- list()
	for(i in 1:n)
	{
		A  <- M[[i]]
		df <- data.frame(Model=names(M)[i],
		                 cbind(A$d3_SizeComps[,1:8],A$d3_obs_size_comps))
		pf <- data.frame(Model=names(M)[i],
		                 cbind(A$d3_SizeComps[,1:8],A$d3_pre_size_comps))
		rf <- data.frame(Model=names(M)[i],
		                 cbind(A$d3_SizeComps[,1:8],A$d3_res_size_comps))
		colnames(df) <- tolower(c("Model",
		                        "Year", "Seas",
		                        "Fleet", "Sex",
		                        "Type", "Shell",
								"Maturity", "Nsamp",
								as.character(A$mid_points)))
		colnames(pf) <- colnames(rf) <- colnames(df)

		df$fleet    <- pf$fleet    <- rf$fleet    <- .FLEET[df$fleet]
		df$sex      <- pf$sex      <- rf$sex      <- .SEX[df$sex+1]
		df$shell    <- pf$shell    <- rf$shell    <- .SHELL[df$shell+1]
		df$maturity <- pf$maturity <- rf$maturity <- .MATURITY[df$maturity+1]
		df$type     <- pf$type     <- rf$type     <- .TYPE[df$type+1]
		df$seas     <- pf$seas     <- rf$seas     <- .SEAS[df$seas]

		df <- melt(df,id.var=1:9)
		pf <- melt(pf,id.var=1:9)
		rf <- melt(rf,id.var=1:9)
		i  <- 1
		for(k in unique(df$fleet))
		for(h in unique(df$sex))
		for(t in unique(df$type))
		for(s in unique(df$shell))
		{
			tdf <- df %>% filter(fleet==k) %>% filter(sex==h) %>% filter(type==t) %>% filter(shell==s)
			tpf <- pf %>% filter(fleet==k) %>% filter(sex==h) %>% filter(type==t) %>% filter(shell==s)
			trf <- rf %>% filter(fleet==k) %>% filter(sex==h) %>% filter(type==t) %>% filter(shell==s)
			if(dim(tdf)[1]!=0)
			{
				mdf[[i]] <-cbind(tdf,pred=tpf$value,resd=trf$value)
				i <- i + 1
			}
		}
	}

	return(mdf)
}	


plot.sizeComps <- function( M, which.plot="all" )
{

	mdf <- get.df( M )
	p <- ggplot(mdf[[1]])
	p <- p + geom_bar(aes(variable,value),stat="identity")
	p <- p + geom_line(aes(as.numeric(variable),pred),col="red")
	p <- p + scale_x_discrete(breaks=pretty(A$mid_points)) 
	p <- p + labs(x="Size (mm)",y="proportion ")
	p <- p + facet_wrap(~year) + .THEME

	plist <- lapply(mdf,FUN = function(x,p){p %+% x},p=p)
	

	if ( which.plot == "all" )
	{
		print( plist )
	}
	else 
	{
		print( plist[[which.plot]] )
	}

}







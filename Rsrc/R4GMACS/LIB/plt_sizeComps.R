# plt_sizeComps.R

# Agorithm for sorting factors so plots descend in rows.
# 1. get length of 1d ribbon (n)
# 2. determine ncol = ceiling(n/sqrt(n))
# 3. determine nrow = ceiling(n/ncol)
# 4. convert year vector into matrix with nrow & ncol
# 5. transpose & vectorize as.vector(t(matrix(yr,nrow,ncol)))
# 6. Use this as levels for years factor.
get.df <- function(M) 
{
	n   <- length(M)
	ldf <- list()
	mdf <- mpf <- mrf <-NULL
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

		
		mdf <- rbind(mdf,df)
		mpf <- rbind(mpf,pf)
		mrf <- rbind(mrf,rf)
	}
	mdf <- melt(mdf,id.var=1:9)
	mpf <- melt(mpf,id.var=1:9)
	mrf <- melt(mrf,id.var=1:9)

	for(i in 1:n)
	{
		j  <- 1
		for(k in unique(df$fleet))
		for(h in unique(df$sex))
		for(t in unique(df$type))
		for(s in unique(df$shell))
		{
			tdf <- mdf %>% filter(fleet==k) %>% filter(sex==h) %>% filter(type==t) %>% filter(shell==s)
			tpf <- mpf %>% filter(fleet==k) %>% filter(sex==h) %>% filter(type==t) %>% filter(shell==s)
			trf <- mrf %>% filter(fleet==k) %>% filter(sex==h) %>% filter(type==t) %>% filter(shell==s)
			if(dim(tdf)[1]!=0)
			{
				# deterimin row & column.
				# fyr = unique(tdf$year)
				# syr = min(fyr); nyr = max(fyr)
				# nn  = (nyr-syr+1)
				# nc  = ceiling(nn/sqrt(nn))
				# irow = icol = rep(1,length=nn)

				# ii = ic = ir = 1
				# for(iyr in fyr)
				# {
				# 	icol[ii] <- ic
				# 	irow[ii] <- ir

				# 	ic = ic + 1
				# 	ii = ii + 1

				# 	if(ic > nc)
				# 	{
				# 		ic = 1
				# 		ir = ir + 1	
				# 	} 
				# }
				# tdf$irow = irow[tdf$year-syr+1]
				# tdf$icol = icol[tdf$year-syr+1]
				# cat(" n = ",nn,"\n")
				# print(tdf$year - syr + 1)

				ldf[[j]] <-cbind(tdf,pred=tpf$value,resd=trf$value)
				j <- j + 1
			}
		}
	}

	return(ldf)
}	


plot.sizeComps <- function( M, which.plot="all" )
{
	
	mdf <- get.df( M )
	ix <- pretty(1:length(M[[1]]$mid_points))
	p <- ggplot(data=mdf[[1]])
	p <- p + geom_bar(aes(variable,value),stat="identity",position="dodge",alpha=0.5,fill="grey")
	p <- p + geom_line(aes(as.numeric(variable),pred,col=model),alpha=0.85)
	p <- p + scale_x_discrete(breaks=M[[1]]$mid_points[ix]) 
	p <- p + labs(x="Size (mm)",y="Proportion",col="Model",fill="Sex",linetype="Fleet")
	p <- p + ggtitle("title")
	p <- p + facet_wrap(~year) + .THEME
	# p <- p + facet_grid(irow~icol,labeller=label_both) + .THEME
	p <- p + theme(axis.text.x = element_text(angle=45,vjust=0.5))

	fun <- function(x,p)
	{
		p$labels$title = paste("Gear =",unique(x$fleet),"\n Sex =",unique(x$sex),", Type =",unique(x$type))
		p %+% x
	}
	plist <- lapply(mdf,fun,p=p)
	

	if ( which.plot == "all" )
	{
		print( plist )
	}
	else 
	{
		print( plist[[which.plot]] )
	}

}


# Residual bubble plots
plot.SizeCompRes <- function( M, which.plot="all" )
{
	mdf <- get.df( M )
	p <- ggplot(data=mdf[[1]])
	p <- p + geom_point(aes(factor(year),variable,col=factor(sign(resd)),size=abs(resd)),alpha=0.6)
	p <- p + scale_size_area(max_size=10)
	p <- p + labs(x="Year",y="Length",col="Sign",size="Residual")
	p <- p + scale_x_discrete(breaks=pretty(mdf[[1]]$mod_yrs))
  	p <- p + scale_y_discrete(breaks=pretty(mdf[[1]]$mid_points))
  	p <- p + facet_wrap(~model)+ .THEME

  	fun <- function(x,p)
  	{
  		p$labels$title = paste("Gear =",unique(x$fleet),"\n Sex =",unique(x$sex),", Type =",unique(x$type))
  		p %+% x
  	}
  	plist <- lapply(mdf,fun,p=p)
  	if ( which.plot == "all" )
  	{
  		print( plist )
  	}
  	else
  	{
  		print( plist[[which.plot]] )
  	}
}






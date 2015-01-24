#' Get observed and predicted size composition values
#'
#' @param replist List object created by read_admb function
#' @return List of observed and predicted size composition values
#' @export
.get_sizecomp_df <- function( M )
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
				ldf[[j]] <-cbind(tdf,pred=tpf$value,resd=trf$value)
				j <- j + 1
			}
		}
	}

	return(ldf)
}	


#' Plot observed and predicted size composition
#'
#'
#' @param replist List object created by read_admb function
#' @return Plot of observed and predicted size composition
#' @author SJD Martell
#' @export
plot_sizeComps <- function( M, which.plot="all" )
{
	
	mdf <- .get_sizecomp_df( M )
	ix <- pretty(1:length(M[[1]]$mid_points))
	p <- ggplot(mdf[[1]])
	p <- p + geom_bar(aes(variable,value),stat="identity",fill="grey",position="dodge")
	p <- p + geom_line(aes(as.numeric(variable),pred,col=model))
	p <- p + scale_x_discrete(breaks=M[[1]]$mid_points[ix]) 
	p <- p + labs(x="Size (mm)",y="Proportion",col="Model")
	# p <- p + ggtitle(fleet)
	p <- p + facet_wrap(~year) + .THEME
	# p <- p + theme(axis.text.x = element_text(angle=90,vjust=0.5))

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

#' Plot size composition residuals
#'
#' TODO: Insert more information here.
#'
#' @param replist List object created by read_admb function
#' @return Bubble plot of size composition residuals
#' @export
plot_sizecomp_res <- function( M ,which_plots="all"){
  A <-  M 
  sdf <- .get_sizecomp_df( M )

  p <- ggplot(data=sdf[[1]])
  p <- p + geom_point(aes(x=factor(year),variable,col=factor(sign(resid)),size=abs(resid))
                      ,alpha=0.6)
  p <- p + scale_size_area(max_size=10)
  p <- p + labs(x="Year",y="Length",col="Sign",size="Residual")
  p <- p + scale_x_discrete(breaks=pretty(A$mod_yrs))
  p <- p + scale_y_discrete(breaks=pretty(A$mid_points))
  p <- p + ggtheme
  if (which_plots=="all")
    pSizeComps <- lapply(sdf,FUN = function(x,p){p %+% x},p=p)
  else
  {
    if (!is.numeric(which_plots)) 
      {
        print("Error, need numeric argument for which_plots=") 
        stop()
      }
    pSizeComps <- lapply(sdf,FUN = function(x,p){p %+% x},p=p)[which_plots]
  }
  return(pSizeComps)
}

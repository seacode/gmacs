#' Get the selectivity data
#'
#' @param M list object created by read_admb function
#' @return list of selectivities
#' @author SJD Martell, DN Webber
#' @export
#' 
.get_selectivity_df <- function(M)
{
	n   <- length(M)
	mdf <- NULL
	for(i in 1:n)
	{
		A  <- M[[i]]
		# capture
		df <- data.frame(Model=names(M)[i],
		         type = .TYPE[1],
                 M[[i]]$slx_capture)
		# retained 
		dr <- data.frame(Model=names(M)[i],
	             type = .TYPE[2],
                 M[[i]]$slx_retaind)	
		colnames(df) <- c("Model","type","year","sex","fleet",as.character(A$mid_points))
		colnames(dr) <- colnames(df)
		df$sex   = .SEX[df$sex+1]
		df$fleet = .FLEET[df$fleet]
		dr$sex   = .SEX[dr$sex+1]
		dr$fleet = .FLEET[dr$fleet]
		blkyr <- M[[i]]$slx_control[,12]
		df    <- filter(df,year %in% blkyr)
		dr    <- filter(dr,year %in% blkyr)
		mdf <- rbind(mdf,melt(df,id.var=1:5),melt(dr,id.var=1:5))
	}
  return(mdf)  
}


#' Plot selectivity
#'
#' @param replist List object created by read_admb function
#' @return Plot of selectivity
#' @author SJD Martell, DN Webber
#' @export
#' 
plot_selectivity <- function(M)
{
    mdf <- .get_selectivity_df(M)
    p <- ggplot(mdf) + expand_limits(y = 0)
    if(.OVERLAY)
    {
        p <- p + geom_line(aes(as.numeric(variable),value,col=type,linetype=factor(year)))
        p <- p + facet_wrap(~Model+sex+fleet)
    } else {
        p <- p + geom_line(aes(as.numeric(variable),value,col=sex,linetype=factor(year)))
        p <- p + facet_wrap(~Model + fleet + type)
    }
    p <- p + labs(y = "Selectivity\n",
                  x = "\nMid-point of size class (mm)",
                  col = "Type", linetype = "Block Year")
    print(p + .THEME)
}

#' Plot fishing mortality (F)
#'
#' @param M list of object(s) created by read_admb function
#' @param xlab the x-axis label for the plot
#' @param ylab the y-axis label for the plot
#' @return plot of fishing mortality (F)
#' @author JN Ianelli, SJD Martell, DN Webber
#' @export
#' 
plot_fishing_mortality <- function(M)
{
    n <- length(M)
    mdf <- NULL
    for(i in 1:n)
    {
        A  <- M[[i]]
        df <- data.frame(Model = names(M)[i], A$dCatchData)
        colnames(df) <- c("model","year","seas","fleet","sex","obs","cv","type","units","mult","effort","discard.mortality")
	# Get Fishing mortality rate parameters.
        odf <- data.frame(par = A$fit$names, log_est = A$fit$est, log_std = A$fit$std)
        ifbar <- grep("log_fbar", odf$par)
        efbar <- odf$log_est[ifbar]
        sfbar <- odf$log_std[ifbar]
	# devs
        idev <- grep("log_fdev", odf$par)
        edev <- odf$log_est[idev]
        sdev <- odf$log_std[idev]
    }
        p <- ggplot(data=mdf[[1]])
        p <- p + geom_point(aes(factor(year), variable, col = factor(sign(resd)), size = abs(resd)), alpha = 0.6)
        p <- p + scale_size_area(max_size = 10)
        p <- p + labs(x="Year",y="Length",col="Sign",size="Residual")
        p <- p + scale_x_discrete(breaks=pretty(mdf[[1]]$mod_yrs))
        p <- p + scale_y_discrete(breaks=pretty(mdf[[1]]$mid_points))
        p <- p + facet_wrap(~model) + .THEME
        p <- p + theme(axis.text.x = element_text(angle = 45, vjust = 0.5))

}

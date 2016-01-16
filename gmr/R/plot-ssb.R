#' Extract spawning stock biomass (ssb) from gmacs run
#'
#' Spawning biomass may be defined as all males or some combination of males and
#' females
#'
#' @param M list object created by read_admb function
#' @return dataframe of spawning biomass
#' @author SJD Martell, D'Arcy N. Webber
#' @export
#' 
.get_ssb_df <- function(M)
{
    n <- length(M)
    mdf <- NULL
    for (i in 1:n)
    {
        A <- M[[i]]
        df <- data.frame(Model = names(M)[i],
                           par = A$fit$names,
	                     log_ssb = A$fit$est,
                        log_sd = A$fit$std)
        df      <- subset(df, par == "sd_log_ssb")
        df$year <- A$mod_yrs
        df$ssb  <- exp(df$log_ssb)
        df$lb   <- exp(df$log_ssb - 1.96*df$log_sd)
        df$ub   <- exp(df$log_ssb + 1.96*df$log_sd)
        mdf     <- rbind(mdf, df)
    }
    return(mdf)
}


#' Plot predicted spawning stock biomass (ssb)
#'
#' Spawning biomass may be defined as all males or some combination of males and
#' females
#'
#' @param M List object(s) created by read_admb function
#' @param ylim is the upper limit for figure
#' @return Plot of model estimates of spawning stock biomass 
#' @author SJD Martell, D'Arcy N. Webber
#' @export
#' 
plot_ssb <- function(M, xlab = "Year", ylab = "SSB (tonnes)", ylim = NULL)
{
    xlab <- paste0("\n", xlab)
    ylab <- paste0(ylab, "\n")
    
    mdf <- .get_ssb_df(M)
    
    p <- ggplot(mdf) + labs(x = xlab, y = ylab)
    if (is.null(ylim))
    {
        p <- p + expand_limits(y = 0)
    } else {
        p <- p + ylim(ylim[1], ylim[2])        
    }
    if (length(M) == 1)
    {
        p <- p + geom_line(aes(x = year, y = ssb)) +
            geom_ribbon(aes(x = year, ymax = ub, ymin = lb), alpha = 0.3)
    } else {
        p <- p + geom_line(aes(x = year, y = ssb, col = Model)) +
            geom_ribbon(aes(x = year, ymax = ub, ymin = lb, fill = Model), alpha = 0.3)
    }
    if(!.OVERLAY) p <- p + facet_wrap(~Model)
    print(p + .THEME)
}

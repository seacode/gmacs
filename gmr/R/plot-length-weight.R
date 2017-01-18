#' Get length-weight data
#'
#' @param M List object created by read_admb function
#' @return dataframe of the length-weight relationship used in the model
#' @export
#'
.get_length_weight_df <- function(M)
{
    n   <- length(M)
    mdf <- NULL
    for ( i in 1:n )
    {
        A  <- M[[i]]
        nsex <- A$nsex
        if ( is.matrix(A$mean_wt) && nsex == 2 )
        {
            wt <- t(A$mean_wt)
            #colnames(wt) <- .SEX[1:nsex+1]
            colnames(wt) <- rep(A$mod_yrs, nsex)
        } else if ( is.matrix(A$mean_wt) && nsex == 1 ) {
            wt <- t(A$mean_wt)
            colnames(wt) <- A$mod_yrs
        } else {
            wt <- data.frame(A$mean_wt)
        }
        df <- data.frame(Model = names(M)[i], Length = A$mid_points, wt)
        df1 <- reshape2::melt(df, id.var = c("Model", "Length"))
        mdf <- rbind(mdf, df1)
    }
    mdf$variable <- gsub("X", "", mdf$variable)
    names(mdf) <- c("Model", "Length", "Year", "Weight")
    #names(mdf) <- c("Model", "Length", "Sex", "Weight")
    #mdf$Sex <- factor(mdf$Sex, levels = sort(levels(mdf$Sex)))
    mdf$Year <- factor(mdf$Year)
    mdf$Sex <- .SEX[1:nsex+1]
    return(mdf)
}


#' Plot length-weight relationship
#'
#' @param M list object created by read_admb function
#' @param xlab the x-axis label for the plot
#' @param ylab the y-axis label for the plot
#' @return plot of the length-weight relationship
#' @export
#' 
plot_length_weight <- function(M, xlab = "Mid-point of size class (mm)", ylab = "Weight (tonnes)")
{
    xlab <- paste0("\n", xlab)
    ylab <- paste0(ylab, "\n")
    
    mdf <- .get_length_weight_df(M)
    
    p <- ggplot(mdf, aes(x = Length, y = Weight)) +
        expand_limits(y = 0) +
        labs(x = xlab, y = ylab)
    
    #if (length(M) == 1)
    #{
    #    p <- p + geom_line(aes(linetype = Sex)) +
    #        geom_point(aes(linetype = Sex, col = Model))
    #} else {
    #    if (.OVERLAY)
    #    {
    #        p <- p + geom_line(aes(linetype = Sex, col = Model)) +
    #            geom_point(aes(linetype = Sex, col = Model))
    #    } else {
    #        p <- p + geom_line(aes(col = Model)) +
    #            geom_point(aes(linetype = Sex, col = Model)) +
    #            facet_wrap(~Sex)
    #    }
    #}
    
    if (length(M) == 1 && length(unique(mdf$Sex)) == 1)
    {
        p <- p + geom_line() + geom_point()
    } else if (length(M) != 1 && length(unique(mdf$Sex)) == 1) {
        p <- p + geom_line(aes(col = Model)) + geom_point(aes(col = Model))
    } else if (length(M) == 1 && length(unique(mdf$Sex)) != 1) {
        p <- p + geom_line(aes(linetype = Sex))
    } else {
        p <- p + geom_line(aes(linetype = Sex, col = Model)) + geom_point(aes(col = Model))
    }
    
    print(p + .THEME)
}

#' Get molting probability data
#'
#' @param M List object created by read_admb function
#' @return dataframe of the molting probability data
#' @author DN Webber
#' @export
#'
.get_molt_prob_df <- function(M)
{
    n   <- length(M)
    mdf <- NULL
    for(i in 1:n)
    {
        A  <- M[[i]]
        nsex <- 1
        if (is.matrix(A$molt_probability))
        {
            nsex <- 2
            mp <- t(A$molt_probability)
        } else {
            mp <- data.frame(A$molt_probability)
        }
        colnames(mp) <- .SEX[1:nsex+1]
        df <- data.frame(Model = names(M)[i], Length = A$mid_points, mp)
        df1 <- melt(df, id.var = c("Model", "Length"))
        mdf <- rbind(mdf, df1)
    }
    names(mdf) <- c("Model", "Length", "Sex", "MP")
    mdf$Sex <- factor(mdf$Sex, levels = sort(levels(mdf$Sex)))
    return(mdf)	
}


#' Plot molting probability relationship
#'
#' @param M list object created by read_admb function
#' @param xlab the x-axis label for the plot
#' @param ylab the y-axis label for the plot
#' @return plot of the molting probability relationship
#' @author DN Webber
#' @export
#' 
plot_molt_prob <- function(M, xlab = "Length", ylab = "Probability")
{
    xlab <- paste0("\n", xlab)
    ylab <- paste0(ylab, "\n")
    mdf <- .get_molt_prob_df(M)
    p <- ggplot(mdf, aes(x = Length, y = MP)) + labs(x = xlab, y = ylab)
    if (length(M) == 1)
    {
        p <- p + geom_line(aes(linetype = Sex))
    } else {
        p <- p + geom_line(aes(linetype = Sex, col = Model))
    }
    print(p + .THEME)
}

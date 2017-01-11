#' Get molting probability data
#'
#' @param M a list of lists created by the read_admb function
#' @return dataframe of the molting probability data
#' @author D'Arcy N. Webber
#' @export
#'
.get_molt_prob_df <- function(M)
{
    n   <- length(M)
    mdf <- NULL
    for(i in 1:n)
    {
        A  <- M[[i]]
        mp <- A$molt_probability
        rownames(mp) <- rep(.SEX[1:A$nsex+1], each = length(A$syr:A$nyr))
        colnames(mp) <- A$mid_points
        df <- reshape2::melt(mp)
        df$Year <- rep(A$syr:A$nyr, by = A$nsex)
        df$Model <- names(M)[i]
        names(df) <- c("Sex", "Length", "MP", "Year", "Model")
        df <- dplyr::distinct(df, Sex, Length, MP, Model, .keep_all = TRUE)
        mdf <- rbind(mdf, df)
    }
    mdf$Sex <- factor(mdf$Sex, levels = sort(levels(mdf$Sex)))
    mdf$Year <- as.factor(mdf$Year)
    return(mdf)	
}


#' Plot molting probability relationship
#'
#' @param M list object created by read_admb function
#' @param xlab the x-axis label for the plot
#' @param ylab the y-axis label for the plot
#' @return plot of the molting probability relationship
#' @author D'Arcy N. Webber
#' @export
#' 
plot_molt_prob <- function(M, xlab = "Mid-point of size class (mm)", ylab = "Probability of molting")
{
    xlab <- paste0("\n", xlab)
    ylab <- paste0(ylab, "\n")
    
    mdf <- .get_molt_prob_df(M)
    
    p <- ggplot(mdf, aes(x = Length, y = MP)) +
        expand_limits(y = c(0,1)) +
        labs(x = xlab, y = ylab)
    
    if (length(M) == 1 && length(unique(mdf$Sex)) == 1)
    {
        p <- p + geom_line() + geom_point()
    } else if (length(M) != 1 && length(unique(mdf$Sex)) == 1) {
        p <- p + geom_line(aes(col = Model)) + geom_point(aes(col = Model))
    } else if (length(M) == 1 && length(unique(mdf$Sex)) != 1) {
        p <- p + geom_line(aes(linetype = Sex, col = Year))
    } else {
        p <- p + geom_line(aes(linetype = Sex, col = Model)) + geom_point(aes(col = Model))
    }
    print(p + .THEME)
}

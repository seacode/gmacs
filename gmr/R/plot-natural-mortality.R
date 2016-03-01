#' Get natural mortality data
#'
#' @param M list object created by read_admb function
#' @author J Ianelli, SJD Martell, DN Webber
#' @export
#' 
.get_M_df <-function(M)
{
    n <- length(M)
    ldf <- list()
    mdf <- NULL
    for (i in 1:n)
    {
        A <- M[[i]]
        nrow <- dim(A$M)[1]
        nsex <- nrow / length(A$mod_yrs)
        A$sex <- rep(1, length = nrow/nsex)
        if (nsex > 1) A$sex <- c(A$sex,rep(2,length=nrow/nsex))
        df <- data.frame(Model=names(M)[i],(cbind(as.numeric(A$mod_yrs), .SEX[A$sex+1], as.numeric(M[[i]]$M[,1])) ),stringsAsFactors=FALSE)
        colnames(df) <- c("Model", "Year", "Sex", "M")
        df$M <- as.numeric(df$M)
        df$Year <- as.numeric(df$Year)
        if (nsex == 2)
        {
            ss <- split(df, df$Sex)
            if (all(ss[[1]]$M == ss[[2]]$M))
            {
                df$Sex <- "Male"
            }
        }
        mdf <- rbind(mdf, df)
    }
    return(mdf)
}


#' Plot natural mortality
#'
#' @param M list object created by read_admb function
#' @param plt_knots if the knots should be plotted or not
#' @return plot of natural mortality
#' @author J Ianelli, SJD Martell, DN Webber
#' @export
#' 
plot_natural_mortality <- function(M, plt_knots = TRUE, knots = c(1976, 1980, 1985, 1994))
{
    mdf <- .get_M_df(M)
    if (length(M) == 1)
    {
        p <- ggplot(mdf, aes(x = Year, y = M))
    } else {
        p <- ggplot(mdf, aes(x = Year, y = M, colour = Model))
    }
    if (length(unique(mdf$Sex)) == 1)
    {
        p <- p + geom_line()
    } else {
        p <- p + geom_line(aes(linetype = Sex))
    }
    if (plt_knots)
    {
        mdf$Knot <- NA
        mdf$Knot[mdf$Year %in% knots] <- mdf$M[mdf$Year %in% knots]
        p <- p + geom_point(data = mdf, aes(x = Year, y = Knot, colour = Model)) +
            labs(col = "Knot")
    }
    p <- p + expand_limits(y = 0) + labs(x = "\nYear", y = "Natural mortality (M)\n")
    print(p + .THEME)
}

#' Get numbers at length data
#' 
#' @param M list object(s) created by read_admb function
#' @return dataframe of numbers at length
#' @author D'Arcy N. Webber
#' @export
#' 
.get_numbers_df <- function(M)
{
    n <- length(M)
    mdf <- NULL
    for (i in 1:n)
    {
        A  <- M[[i]]
        df <- data.frame(Model = names(M)[i], mp = A$mid_points, t(A$N_len))
        names(df) <- c("Model", "mp", A$mod_yrs, max(A$mod_yrs))
        df <- melt(df, id.vars = c("Model", "mp"))
        names(df) <- c("Model", "mp", "Year", "N")
        mdf <- rbind(mdf, df)
    }
    return(mdf)
}


#' Plot numbers at length
#'
#' @param M list object created by read_admb function
#' @param subsetby a selection of the years to restrict plotting of
#' @return plot of numbers of individuals in each size-class each year in the model
#' @author D'Arcy N. Webber
#' @export
#' 
plot_numbers <- function(M, subsetby = "")
{
    mdf <- .get_numbers_df(M)
    if (all(subsetby != "")) mdf <- mdf[mdf$Year %in% subsetby,]
    p <- ggplot(mdf, aes(x = mp, y = N)) + labs(x = "\nMid-point of size-class (mm)", y = "Number of inidividuals\n")
    if (length(M) == 1)
    {
        p <- p + geom_line()
    } else {
        p <- p + geom_line(aes(col = Model))
    }
    p <- p + facet_wrap(~Year)
    print(p + .THEME)
}

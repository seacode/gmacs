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
        for (s in 1:A$nsex)
        {
            for (o in 1:A$nshell)
            {
                if (s == 1) {
                    if (o == 1) df <- data.frame(Model = names(M)[i], mp = A$mid_points, sex = s, shell = o, t(A$N_males_new))
                    if (o == 2) df <- data.frame(Model = names(M)[i], mp = A$mid_points, sex = s, shell = o, t(A$N_males_old))
                } else {
                    if (o == 1) df <- data.frame(Model = names(M)[i], mp = A$mid_points, sex = s, shell = o, t(A$N_females_new))
                    if (o == 2) df <- data.frame(Model = names(M)[i], mp = A$mid_points, sex = s, shell = o, t(A$N_females_old))
                }
                names(df) <- c("Model", "mp", "Sex", "Shell", A$mod_yrs)
                df <- reshape2::melt(df, id.vars = c("Model", "mp", "Sex", "Shell"))
                names(df) <- c("Model", "mp", "Sex", "Shell","Year", "N")
                mdf <- rbind(mdf, df)
            }
        }
    }
    mdf$Sex <- .SEX[mdf$Sex+1]
    mdf$Shell <- .SHELL[mdf$Shell+1]
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
plot_numbers <- function(M, subsetby = "", nrow = 2, ncol = NULL)
{
    mdf <- .get_numbers_df(M)
    if (all(subsetby != "")) mdf <- mdf[mdf$Year %in% subsetby,]
    p <- ggplot(mdf, aes(x = mp, y = N)) + labs(x = "\nMid-point of size-class (mm)", y = "Number of inidividuals\n")
    if (length(M) == 1)
    {
        p <- p + geom_line(aes(col = Sex, linetype = Shell))
    } else {
        p <- p + geom_line(aes(col = Model, linetype = Shell))
    }
    p <- p + facet_wrap(Model + Sex ~ Year, nrow = nrow, ncol = ncol)
    print(p + .THEME)
}

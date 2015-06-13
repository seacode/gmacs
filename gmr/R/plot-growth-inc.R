#' Get growth increment data
#'
#' @param M list object(s) created by read_admb function
#' @return dataframe of growth increments
#' @author DN Webber, SJD Martell
#' @export
#' 
.get_gi_df <- function(M)
{
    n  <- length(M)
    mdf <- NULL
    for(i in 1:n)
    {
        A <- M[[i]]
        df <- data.frame(Model = names(M)[i], sex = A$iMoltIncSex, obs = A$pMoltInc, pred = A$dMoltInc, size = A$dPreMoltSize)
        df$sex <- .SEX[df$sex + 1]
        mdf <- rbind(mdf, df)
    }
    return(mdf)
}


#' Plot growth from arbitrary start age
#'
#' @param replist list object created by read_admb function
#' @return plot growth increment for given pre-molt size, including model predictions and data
#' @author SJD Martell, DN Webber
#' @export
#' 
plot_growth_inc <- function(M)
{
    mdf <- .get_gi_df(M)
    p <- ggplot(mdf) +
        labs(x = "\nPre-molt size (mm)", y = "Molting increment (mm)\n", col = "Sex")
    p <- p + geom_line(aes(x = size, y = obs, colour = sex))
    #p <- p + geom_point(aes(x = size, y = pred, colour = sex))
    if (!length(M) == 1)
    {
        p <- p + facet_wrap(~Model)
    }
    return(p + .THEME)
}

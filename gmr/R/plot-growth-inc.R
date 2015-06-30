#' Get growth increment data
#'
#' @param M list object(s) created by read_admb function
#' @return dataframe of growth increments
#' @author D'Arcy N. Webber, SJD Martell
#' @export
#' 
.get_gi_df <- function(M)
{
    n  <- length(M)
    mdf <- NULL
    for(i in 1:n)
    {
        A <- M[[i]]
        df <- data.frame(Model = names(M)[i],
                         sex   = A$iMoltIncSex,
                         obs   = A$pMoltInc,
                         pred  = A$dMoltInc,
                         size  = A$dPreMoltSize)
        df$sex <- .SEX[df$sex + 1]
        mdf <- rbind(mdf, df)
    }
    return(mdf)
}


#' Plot growth from arbitrary start age
#'
#' @param replist list object created by read_admb function
#' @param xlab the x-axis label for the plot
#' @param ylab the y-axis label for the plot
#' @param slab the sex label for the plot that appears above the key
#' @return plot growth increment for given pre-molt size, including model predictions and data
#' @author SJD Martell, D'Arcy N. Webber
#' @export
#' 
plot_growth_inc <- function(M, xlab = "Pre-molt size (mm)", ylab = "Molting increment (mm)",
                            slab = "Sex")
{
    xlab <- paste0("\n", xlab)
    ylab <- paste0(ylab, "\n")
    
    mdf <- .get_gi_df(M)
    
    p <- ggplot(mdf) + labs(x = xlab, y = ylab, col = slab)
    p <- p + geom_point(aes(x = size, y = obs, colour = sex))
    p <- p + geom_line(aes(x = size, y = pred, colour = sex))
    if (!length(M) == 1)
    {
        p <- p + facet_wrap(~Model)
    }
    return(p + .THEME)
}

#' Plot growth from arbitrary start age
#'
#' @param replist List object created by read_admb function
#' @return Plot growth increment for given pre-molt size, including model predictions and data
#' @export
#' 
plot_growth_inc <- function(M)
{
    A <- M
    df <- data.frame(sex = as.factor(A$iMoltIncSex), obs = A$pMoltInc, pred = A$dMoltInc, size = A$dPreMoltSize)
    p <- ggplot(df)
    p <- p + geom_line(aes(x = size, y = obs, colour = sex))
    p <- p + geom_point(aes(x = size, y = pred, colour = sex))
    p <- p + labs(x = "\nPre-molt size", y = "Molting increment\n")
    return(p)
}

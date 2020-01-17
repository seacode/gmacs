#' Create a table of SPR reference points
#'
#' @param M List object(s) created by read_admb function
#' @return dataframe of SPR reference points
#' @author SJD Martell, DN Webber
#' @export
#' 
table_spr <- function(M)
{
    n <- length(M)
    mdf <- NULL
    for(i in 1:n)
    {
        A  <- M[[i]]
        df <- data.frame(Model = names(M)[i],
                         FSPR  = round(A$spr_fspr, 2),
                         BSPR  = round(A$spr_bspr, 2),
                         FOFL  = round(A$spr_fofl, 2),
                         OFL   = round(A$spr_cofl, 2),
                         RSPR  = round(A$spr_rbar, 2))
        mdf <- rbind(mdf, df)
    }
    return(mdf)
}

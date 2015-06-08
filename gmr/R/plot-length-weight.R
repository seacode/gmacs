#' Get length-weight
#'
#' @param replist List object created by read_admb function
#' @return dataframe of the length-weight relationship used in the model
#' @author DN Webber
#' @export
#'
.get_length_weight_df <- function(M)
{
    n   <- length(M)
    mdf <- NULL
    for(i in 1:n)
    {
        A  <- M[[i]]
        nsex <- 1
        if (is.matrix(A$mean_wt)) nsex <- 2
        df <- data.frame(Model = names(M)[i], Length = A$mid_points, t(A$mean_wt))
        #colnames(df) <- c("Model", "length", "weight")
        #df$sex = .SEX[df$sex+1]
        #sd <- sqrt(log(1+df$cv^2))
        #df$lb <- exp(log(df$cpue)-1.96*sd)
        #df$ub <- exp(log(df$cpue)+1.96*sd)
        #df$pred <- na.exclude(as.vector(t(A$pre_cpue)))
        mdf <- rbind(mdf, df)
    } 
    return(mdf)	
}


plot(gmrep$mid_points, (gmrep$mean_wt), type="b", ylab="Mean weight at length", xlab="Carapace width (mm)", ylim=c(0,4))
lines(j_len$Size, j_len$MaleWt, col="red")
legend(130,1.2,c("gmacs","bbrkc"), pch=c(1,-1), lty=c(1,1), col=c(1,"red"))

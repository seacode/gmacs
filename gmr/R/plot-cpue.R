#' Get cpue or other indices
#'
#' @param replist List object created by read_admb function
#' @return dataframe of observed and predicted indices and residuals
#' @author SJD Martell, DN Webber
#' @export
#' 
.get_cpue_df <- function(M)
{
	n   <- length(M)
	mdf <- NULL
	for(i in 1:n)
	{
		A  <- M[[i]]
		df <- data.frame(Model=names(M)[i], as.data.frame(A$dSurveyData))
		colnames(df) <- c("Model","year","seas","fleet","sex","cpue","cv","units")	
		df$sex = .SEX[df$sex+1]
		df$fleet = .FLEET[df$fleet]
		sd <- sqrt(log(1+df$cv^2))
		df$lb <- exp(log(df$cpue)-1.96*sd)
		df$ub <- exp(log(df$cpue)+1.96*sd)
		df$pred <- na.exclude(as.vector(t(A$pre_cpue)))
		df$resd <- na.exclude(as.vector(t(A$res_cpue)))
		mdf <- rbind(mdf,df)
	} 
	return(mdf)	
}

#' Plot cpue or other indices
#'
#' @param M list object created by read_admb function
#' @return plot of all observed and predicted incices
#' @author SJD Martell, DN Webber
#' @export
#' 
plot_cpue <- function(M, subsetby = "")
{
    mdf <- .get_cpue_df(M)
    if (subsetby != "") mdf <- subset(mdf, fleet == subsetby)
    
    p  <- ggplot(mdf, aes(year, cpue))
    #p  <- ggplot(mdf, aes(year, cpue, col = factor(sex)))
    #p  <- p + geom_pointrange(aes(year, cpue, ymax = ub, ymin = lb, col = factor(sex)))
    p  <- p + geom_pointrange(aes(year, cpue, ymax = ub, ymin = lb), col = "black", alpha = 0.5)

    if(.OVERLAY)
    {
        if (length(M) == 1)
        {
            p  <- p + geom_line(data = mdf, aes(year, pred, color = sex)) + labs(col = "Sex")
        } else {
            p  <- p + geom_line(data = mdf, aes(year, pred, color = Model))
        }
        p  <- p + facet_wrap(~fleet + sex, scales = "free_y")
    } else {
        p  <- p + geom_line(data = mdf, aes(year, pred))
        p  <- p + facet_wrap(~fleet + sex + Model, scales = "free_y")
    }
    #p  <- p + labs(x = "Year", y = "CPUE", col = "Sex")
    #p  <- p + labs(x = "\nYear", y = "CPUE\n", col = "Model")
    p  <- p + labs(x = "\nYear", y = "CPUE\n")
    print(p + .THEME)
}


#' Plot residuals of cpue or other indices
#'
#' @param replist List object created by read_admb function
#' @return Plot of fit indices residuals
#' @author SJD Martell, DN Webber
#' @export
#' 
plot_cpue_res <- function(M)
{
	
	mdf <- .get_cpue_df( M )

	p  <- ggplot(mdf,aes(year,resd))
	if(.OVERLAY)
	{
		p  <- p + geom_bar(aes(fill=factor(Model)),stat = "identity", position="dodge")
		p  <- p + facet_wrap(~ sex + fleet)		
	}
	else
	{
		p  <- p + geom_bar(aes(fill=factor(sex)),stat = "identity", position="dodge")
		p  <- p + facet_wrap(~Model + sex + fleet)		
	}
	p  <- p + labs(x="Year",y="Residual (Observed - Predicted)",fill="Sex")
	print(p + .THEME)
}

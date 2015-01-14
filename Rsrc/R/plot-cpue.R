#' Plot cpue or other indices
#'
#' @param replist List object created by read_admb function
#' @return Plot of all observed and predicted incices
#' @export
plot_cpue <- function(replist){
	df <- get_cpue(replist)
	p  <- ggplot(df,aes(year,cpue))
# p  <- p + geom_point(aes(col=sex))
	p  <- p + geom_pointrange(aes(year,cpue,ymax=ub,ymin=lb,col=sex))
	p  <- p + labs(x="Year",y="CPUE",col="Sex")
	pCPUE  <- p + facet_wrap(~fleet+sex,scales="free")
# Fitted CPUE
	pCPUEfit <- pCPUE + geom_line(data=df,aes(year,pred))
  return(pCPUEfit)
}

#' Plot residuals of cpue or other indices
#'
#' @param replist List object created by read_admb function
#' @return Plot of fit indices residuals
#' @export
plot_cpue_res <- function(replist){
# CPUE residuals
	df <- get_cpue(replist)
	p  <- ggplot(df,aes(factor(year),resd))
	p  <- p + geom_bar(aes(fill=factor(sex)),stat = "identity", position="dodge")
	p  <- p + scale_x_discrete(breaks=pretty(df$year))
	p  <- p + labs(x="Year",y="CPUE Residuals",fill="Sex")
	pCPUEres  <- p + facet_wrap(~fleet,scales="free_x")
  return(pCPUEres)
}
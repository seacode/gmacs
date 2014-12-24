#' Plot cpue or other indices
#'
#' @param replist List object created by read_admb function
#' @return dataframe of observed and predicted indices and residuals
#' @export
get_cpue <- function(replist){
	A <- replist
	df <- as.data.frame(A$dSurveyData)
	colnames(df) <- c("year","seas","fleet","sex","cpue","cv","units")
	sd <- sqrt(log(1+df$cv^2))
	df$lb <- exp(log(df$cpue)-1.96*sd)
	df$ub <- exp(log(df$cpue)+1.96*sd)
	df$pred <- na.exclude(as.vector(t(A$pre_cpue)))
	df$resd <- na.exclude(as.vector(t(A$res_cpue)))
  return(df)
}
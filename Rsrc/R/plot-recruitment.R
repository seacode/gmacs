#' Plot predicted recruitment and approximate asymptotic error-bars
#'
#'
#' @param replist List object created by read_admb function
#' @return Plot of predicted recruitment
#' @export
plot_recruitment <- function(replist){
  A <- replist
  df <- get_recruitment(replist)
  p <- ggplot(df,aes(x=factor(year),y=exp(log_rec)))
  p <- p + geom_bar(stat = "identity", alpha=0.4)
  p <- p + geom_pointrange(aes(factor(year),exp(log_rec),ymax=ub,ymin=lb))
  p <- p + labs(x="Year",y="Recruitment")
  pRecruitment <- p + ggtheme
  return(pRecruitment)
}

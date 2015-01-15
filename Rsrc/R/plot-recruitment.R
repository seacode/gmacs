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

#' Plot predicted recruitment across model runs
#'
#'
#' @param data A list of multiple objects created by read_admb function
#' @param modnames A vector of model names included in \code{data}
#' @return Plot of predicted recruitment compared across models
#' @author Cole Monnahan Kelli Johnson
#' @export
plot_models_recruitment <- function(data, modnames){
    recs <- lapply(data, get_recruitment)
    df <- do.call("rbind", Map(cbind, recs, modname = modnames))

  p <- ggplot(df,aes(x=factor(year),y=exp(log_rec), group=modname, colour=modname))
  p <- p + geom_line(stat = "identity", alpha=0.4)
  p <- p + geom_pointrange(aes(factor(year),exp(log_rec),ymax=ub,ymin=lb))
  p <- p + labs(x="Year", y="Recruitment")
  pRecruitment <- p + ggtheme
  return(pRecruitment)
}
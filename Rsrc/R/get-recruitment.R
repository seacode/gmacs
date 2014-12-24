#' Plot predicted recruitment and approximate asymptotic error-bars
#'
#'
#' @param replist List object created by read_admb function
#' @return Dataframe of recruitment
#' @export
get_recruitment <- function(replist){
  A <- replist
  dfpar   <- data.frame(par=A$fit$names,log_rec=A$fit$est,log_sd=A$fit$std)
  df      <- subset(dfpar,par=="sd_log_recruits")[,-1]
  df$year <- A$mod_yrs
  df$lb   <- exp(df$log_rec - 1.96*df$log_sd)
  df$ub   <- exp(df$log_rec + 1.96*df$log_sd)
  return(df)
}

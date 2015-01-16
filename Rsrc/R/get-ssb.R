#' Plot predicted spawning stock biomass (ssb)
#'
#' Spawning biomass may be defined as all males or some combination of males and females
#'
#' @param replist List object created by read_admb function
#' @return Dataframe of spawning biomass
#' @export
get_ssb <- function(replist){
  A <- replist
  dfpar   <- data.frame(par=A$fit$names,log_mmb=A$fit$est,log_sd=A$fit$std)
  df      <- subset(dfpar,par=="sd_log_mmb")[,-1]
  df$year <- A$mod_yrs
  df$lb   <- exp(df$log_mmb - 1.96*df$log_sd)
  df$ub   <- exp(df$log_mmb + 1.96*df$log_sd)
  return(df)
}

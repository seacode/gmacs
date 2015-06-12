#' .get_recruitment_df
#' Extracts predicted recruitment and approximate asymptotic error-bars
#'
#' @param M List object(s) created by read_admb function
#' @return Dataframe of recruitment
#' @author SJD Martell
#' @export
#' 
.get_recruitment_df <- function(M)
{
  n   <- length(M)
  mdf <- NULL
  for(i in 1:n)
  {
    A  <- M[[i]]
    if(is.null(A$fit$logDetHess)) {
      stop("Appears that the Hessian was not positive definite\n
            thus estimates of recruitment do not exist.\n
            See this in replist$fit.") }
    df <- data.frame(Model=names(M)[i],
                     par = A$fit$names,
                     log_rec=A$fit$est,
                     log_sd=A$fit$std)
    df      <- subset(df,par == "sd_log_recruits")
    df$year <- A$mod_yrs
    df$mmb  <- exp(df$log_rec)
    df$lb   <- exp(df$log_rec - 1.96*df$log_sd)
    df$ub   <- exp(df$log_rec + 1.96*df$log_sd)
    mdf     <- rbind(mdf,df)
  }
  return(mdf)
}


#' Plot predicted recruitment and approximate asymptotic error-bars
#'
#'
#' @param M List object created by read_admb function
#' @author SJD Martell
#' @return Plot of predicted recruitment
#' @export
#' 
plot_recruitment <- function(M)
{
  mdf <- .get_recruitment_df(M)
  p <- ggplot(mdf,aes(x=(year),y=exp(log_rec),col=Model,group=Model))
  p <- p + geom_bar(stat = "identity", alpha=0.4,aes(fill=Model),position="dodge")
  p <- p + geom_pointrange(aes((year),exp(log_rec),col=Model,ymax=ub,ymin=lb),
           position=position_dodge(width=.9))
  p <- p + labs(x = "\nYear", y = "Recruitment\n")

  if(!.OVERLAY) p <- p + facet_wrap(~Model)

  print(p + .THEME)
}


#' Plot predicted recruitment across model runs
#'
#' @param data A list of multiple objects created by read_admb function
#' @param modnames A vector of model names included in \code{data}
#' @return Plot of predicted recruitment compared across models
#' @author Cole Monnahan Kelli Johnson
#' @export
#' 
plot_models_recruitment <- function(data, modnames=NULL )
{
  if (is.null(modnames))
    modnames = paste("Model ",1:length(data))
  if (length(data)!=length(modnames)) 
    stop("Holy moly, unequal object lengths") 

  recs <- lapply(data, get_recruitment)
  df <- do.call("rbind", Map(cbind, recs, modname = modnames))

  p <- ggplot(df,aes(x=factor(year),y=exp(log_rec), group=modname, colour=modname))
  p <- p + geom_line(stat = "identity", alpha=0.4)
  p <- p + geom_pointrange(aes(factor(year),exp(log_rec),ymax=ub,ymin=lb))
  p <- p + labs(x="Year", y="Recruitment")
  pRecruitment <- p + ggtheme
  return(pRecruitment)
}

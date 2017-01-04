#' Get recruitment data
#' 
#' Extracts predicted recruitment and approximate asymptotic error-bars
#'
#' @param M list object(s) created by read_admb function
#' @return dataframe of recruitment
#' @author SJD Martell, DN Webber
#' @export
#' 
.get_recruitment_df <- function(M)
{
    n <- length(M)
    mdf <- NULL
    for (i in 1:n)
    {
        A  <- M[[i]]
        if (is.null(A$fit$logDetHess))
        {
            stop("Appears that the Hessian was not positive definite\n
                  thus estimates of recruitment do not exist.\n
                  See this in replist$fit.")
        }
        df <- data.frame(Model   = names(M)[i],
                         par     = A$fit$names,
                         log_rec = A$fit$est,
                         log_sd  = A$fit$std)
        df <- subset(df, par == "sd_log_recruits")
        df$year <- rep(A$mod_yrs, by = A$nsex)
        df$sex <- rep(1:A$nsex, each = length(A$mod_yrs))
        df$sex <- .SEX[df$sex + 1]
        df$lb <- exp(df$log_rec - 1.96*df$log_sd)
        df$ub <- exp(df$log_rec + 1.96*df$log_sd)
        j <- which(M[[i]]$fit$names %in% c("theta[4]"))
        #rstd <- M[[i]]$fit$std[j]
        if (length(j) > 0)
        {
            df$rbar = exp(M[[i]]$fit$est[j])
        } else {
            df$rbar = NA
        }
        mdf <- rbind(mdf, df)
    }
    return(mdf)
}


#' Get recruitment size distribution data
#' 
#' @param M list object(s) created by read_admb function
#' @return dataframe of recruitment size distribution
#' @author DN Webber
#' @export
#' 
.get_recruitment_size_df <- function(M)
{
    n <- length(M)
    mdf <- NULL
    for(i in 1:n)
    {
        A  <- M[[i]]
        if(is.null(A$fit$logDetHess))
        {
            stop("Appears that the Hessian was not positive definite\n
                  thus estimates of recruitment do not exist.\n
                  See this in replist$fit.")
        }
        df <- data.frame(Model = names(M)[i],
                         mid_points = A$mid_points,
                         rec_sdd = A$rec_sdd,
                         rec_ini = A$rec_ini)
        mdf <- rbind(mdf, df)
    }
    return(mdf)
}


#' Plot predicted recruitment and approximate asymptotic error-bars
#'
#' @param M list object created by read_admb function
#' @param xlab the x-axis label for the plot
#' @param ylab the y-axis label for the plot
#' @return Plot of predicted recruitment
#' @author SJD Martell, DN Webber
#' @export
#' 
plot_recruitment <- function(M, xlab = "Year", ylab = "Recruitment (millions of individuals)")
{
    xlab <- paste0("\n", xlab)
    ylab <- paste0(ylab, "\n")
    mdf <- .get_recruitment_df(M)
    if (length(M) == 1)
    {
        p <- ggplot(mdf, aes(x = year, y = exp(log_rec)/1e+06)) +
            geom_bar(stat = "identity", alpha = 0.4, position = "dodge") +
            geom_pointrange(aes(year, exp(log_rec)/1e+6, ymax = ub/1e+06, ymin = lb/1e+06), position = position_dodge(width = 0.9))
    } else {
        p <- ggplot(mdf, aes(x = year, y = exp(log_rec)/1e+06, col = Model, group = Model)) +
            geom_hline(aes(yintercept = rbar/1e+6, col = Model)) +
            geom_bar(stat = "identity", alpha = 0.4, aes(fill = Model), position = "dodge") +
            geom_pointrange(aes(year, exp(log_rec)/1e+6, col = Model, ymax = ub/1e+06, ymin = lb/1e+06), position = position_dodge(width = 0.9))
    }
    p <- p + labs(x = xlab, y = ylab)
    if (!.OVERLAY) p <- p + facet_wrap(~Model)
    if (length(unique(mdf$sex)) > 1) p <- p + facet_wrap(~sex, ncol = 1)
    print(p + .THEME)
}


#' Plot recruitment size distribution
#'
#' @param M list object created by read_admb function
#' @param xlab the x-axis label for the plot
#' @param ylab the y-axis label for the plot
#' @return plot of recruitment size distribution
#' @author DN Webber
#' @export
#' 
plot_recruitment_size <- function(M, xlab = "Mid-point of size class (mm)", ylab = "Proportion")
{
    xlab <- paste0("\n", xlab)
    ylab <- paste0(ylab, "\n")
    mdf <- .get_recruitment_size_df(M)
    p <- ggplot(mdf, aes(x = mid_points, y = rec_sdd)) +
        expand_limits(y = c(0,1)) +
        labs(x = xlab, y = ylab)
    if (length(M) == 1)
    {
        p <- p + geom_line() + geom_point()
    } else {
        p <- p + geom_line(aes(col = Model)) + geom_point(aes(col = Model))
    }
    if (!.OVERLAY) p <- p + facet_wrap(~Model)
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
plot_models_recruitment <- function(data, modnames = NULL)
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

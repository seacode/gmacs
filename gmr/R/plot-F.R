#' Get observed and predicted catch values
#'
#' @param M List object(s) created by read_admb function
#' @return dataframe of catch history (observed) and predicted values
#' @author SJD Martell, D'Arcy N. Webber
#' @export
#' 
.get_catch_df <- function(M)
{
    n <- length(M)
    mdf <- NULL
    for ( i in 1:n )
    {
        A <- M[[i]]
        df <- data.frame(Model = names(M)[i], A$dCatchData_out)
        colnames(df) <- c("model","year","seas","fleet","sex","obs","cv","type","units","mult","effort","discard.mortality")
        df$observed  <- na.omit(as.vector(t(A$obs_catch_out)))
        df$predicted <- na.omit(as.vector(t(A$pre_catch_out)))
        #df$residuals <- na.omit(as.vector(t(A$res_catch_out)))
        df$residuals <- (as.vector(t(A$res_catch_out)))
        df$sex       <- .SEX[df$sex+1]
        df$fleet     <- .FLEET[df$fleet]
        df$type      <- .TYPE[df$type+1]
        df$sd        <- sqrt(log(1+df$cv^2))
        df$lb        <- exp(log(df$obs)-1.96*df$sd)
        df$ub        <- exp(log(df$obs)+1.96*df$sd)
        mdf <- rbind(mdf, df)
        if ( !all(df$observed == df$obs) )
        {
            stop("Error: observed catch data is buggered.")
        }
    }
    mdf$year <- as.integer(mdf$year)
    mdf$sex <- factor(mdf$sex, levels = .SEX)
    mdf$type <- factor(mdf$type, levels = .TYPE)
    mdf$fleet <- factor(mdf$fleet, levels = .FLEET)
    return(mdf)
}


#' Plot observed and predicted catch values
#'
#' @param M list object created by read_admb function
#' @param plot_res plot residuals only (default = FALSE)
#' @param xlab the x-axis label for the plot
#' @param ylab the y-axis label for the plot
#' @param mlab the model label for the plot that appears above the key
#' @return plot of catch history (observed) and predicted values
#' @author SJD Martell, D'Arcy N. Webber
#' @export
#' 
plot_catch <- function(M, plot_res = FALSE, scales = "free_y",
                       xlab = "Year", ylab = "Catch", mlab = "Model")
{
    xlab <- paste0("\n", xlab)
    ylab <- paste0(ylab, "\n")

    mdf <- .get_catch_df(M)
    mdf$units[mdf$units == 1] <- "Units: biomass"
    mdf$units[mdf$units == 2] <- "Units: numbers"
    
    #if (plot_res)
    #{
      ## Residuals
      #p <- ggplot(df,aes(x=factor(year),y=residuals,fill=factor(sex)))
      #p <- p + geom_bar(stat = "identity", position="dodge")
      #p <- p + scale_x_discrete(breaks=pretty(df$year))
      #p <- p + labs(x="Year",y="Residuals ln(kt)",fill="Sex")
      #p <- p + facet_wrap(~fleet~type,scales="free")
    #}
    #else
    #p <- ggplot(mdf, aes(x = as.integer(year), y = observed, fill = sex))
    
    p <- ggplot(mdf, aes(x = year, y = observed)) +
        geom_bar(stat = "identity", position = "dodge", alpha = 0.15) +
        geom_linerange(aes(year, observed, ymax = ub, ymin = lb, position = "dodge"), size = 0.2, alpha = 0.5, col = "black") +
        labs(x = xlab, y = ylab)
    
    if (.OVERLAY)
    {
        if (length(M) == 1 && length(unique(mdf$sex)) == 1)
        {
            p <- p + geom_line(aes(x = as.integer(year), y = predicted), alpha = 0.4) +
                facet_wrap(~fleet + type + units, scales = scales)
        } else if (length(M) != 1 && length(unique(mdf$sex)) == 1) {
            p <- p + geom_line(aes(x = as.integer(year), y = predicted, col = model), alpha = 0.4) +
                facet_wrap(~fleet + type + units, scales = scales) +
                labs(col = mlab)
        } else if (length(M) == 1 && length(unique(mdf$sex)) != 1) {
            p <- p + geom_line(aes(x = as.integer(year), y = predicted), alpha = 0.4) +
                facet_wrap(~sex + fleet + type + units, scales = scales)
        } else {
            p <- p + geom_line(aes(x = as.integer(year), y = predicted, col = model), alpha = 0.4) +
                facet_wrap(~sex + fleet + type + units, scales = scales) +
                labs(col = mlab)
        }
    } else {
        p <- p + geom_line(aes(x = as.integer(year), y = predicted, col = model), alpha = 0.4)
        p <- p + facet_wrap(~model + sex + fleet + type, scales = scales)
    }
    print(p + .THEME)
}




.get_F_df <- function(M)
{
    n <- length(M)
    mdf <- NULL
    for ( i in 1:n )
    {
        A <- M[[i]]
        nyear <- length(M[[i]]$mod_yrs)
        nseason <- length(M[[i]]$m_prop)
        nclass <- length(M[[i]]$mid_points)
        df <- data.frame(Model = names(M)[i], A$F)
        colnames(df) <- c("model", M[[i]]$mid_points)
        df$year <- rep(M[[i]]$mod_yrs, each = nseason)
        df$season <- rep(1:nseason, nyear)
        df <- tidyr::gather(df, "mid_point", "F", 2:(nclass+1))
        mdf <- rbind(mdf, df)
    }
    mdf$year <- as.integer(mdf$year)
    return(mdf)
}

#.get_F_df(M)

#ggplot(filter(mdf, season != 2)) +
#    geom_line(aes(year, F, group = 1)) +
#    facet_grid(mid_point ~ season, scales = "free_y")


#        plot(A$F[seq(2,114,3),1], type = "l")
#        plot(A$F[seq(2,114,3),2], type = "l", col = 2)
#        plot(A$F[seq(2,114,3),3], type = "l", col = 3)

#        plot(A$F[seq(2,114,3),1], type = "l", ylim = c(0,2))
#        lines(A$F[seq(2,114,3),2], col = 2)
#        lines(A$F[seq(2,114,3),3], col = 3)

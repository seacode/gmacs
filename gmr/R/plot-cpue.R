#' Get cpue or other indices
#'
#' @param M List object created by read_admb function
#' @return dataframe of observed and predicted indices and residuals
#' @author SJD Martell, D'Arcy N. Webber
#' @export
#' 
.get_cpue_df <- function(M)
{
    n   <- length(M)
    mdf <- NULL
    for (i in 1:n)
    {
        A        <- M[[i]]
        df       <- data.frame(Model = names(M)[i], as.data.frame(A$dSurveyData))
        colnames(df) <- c("Model","year","seas","fleet","sex","cpue","cv","units")
        df$sex   <- .SEX[df$sex+1]
        df$fleet <- .FLEET[df$fleet]
        sd       <- sqrt(log(1 + df$cv^2))
        df$lb    <- exp(log(df$cpue) - 1.96*sd)
        df$ub    <- exp(log(df$cpue) + 1.96*sd)

        df$cvest <- na.exclude(as.vector(t(A$cpue_cv_add)))
        sde      <- sqrt(log(1 + df$cvest^2))
        df$lbe   <- exp(log(df$cpue) - 1.96*sde)
        df$ube   <- exp(log(df$cpue) + 1.96*sde)

        df$pred  <- na.exclude(as.vector(t(A$pre_cpue)))
        df$resd  <- na.exclude(as.vector(t(A$res_cpue)))
        mdf      <- rbind(mdf, df)
    }
    return(mdf)
}


#' Plot cpue or other indices
#'
#' @param M list object created by read_admb function
#' @param subsetby the fleet to subset the data to
#' @param xlab the x-axis label for the plot
#' @param ylab the y-axis label for the plot
#' @param ShowEstErr Shows errorbars from estimated CVs as well
#' @param logy Plot the CPUE in log-space
#' @param slab the sex label for the plot that appears above the key
#' @return plot of all observed and predicted incices
#' @author SJD Martell, D'Arcy N. Webber
#' @export
#' 
plot_cpue <- function(M, subsetby = "", xlab = "Year", ylab = "CPUE", slab = "Sex", ShowEstErr = FALSE, logy = FALSE)
{
    mdf <- .get_cpue_df(M)
    if (subsetby != "") mdf <- subset(mdf, fleet == subsetby)
    
    if (logy) {
        mdf$cpue <- log(mdf$cpue)
        mdf$lb <- log(mdf$lb)
        mdf$ub <- log(mdf$ub)
        mdf$lbe <- log(mdf$lbe)
        mdf$ube <- log(mdf$ube)
        mdf$pred <- log(mdf$pred)
        ylab <- paste0("log(", ylab, ")")
    }

    xlab <- paste0("\n", xlab)
    ylab <- paste0(ylab, "\n")

    p  <- ggplot(mdf, aes(year, cpue))
    p  <- p + geom_pointrange(aes(year, cpue, ymax = ub, ymin = lb), col = "black")
    
    if (ShowEstErr) {
        if (length(M) == 1 && length(unique(mdf$sex)) == 1) {
            p  <- p + geom_pointrange(aes(year, cpue, ymax = ube, ymin = lbe), color = "red", shape = 1, linetype = "dotted", position = position_dodge(width = 1))
        } else if (length(M) != 1 && length(unique(mdf$sex)) == 1) {
            p  <- p + geom_pointrange(aes(year, cpue, ymax = ube, ymin = lbe, col = Model), shape = 1, linetype = "dotted", position = position_dodge(width = 1))
        } else if (length(M) == 1 && length(unique(mdf$sex)) != 1) {
            p  <- p + geom_pointrange(aes(year, cpue, ymax = ube, ymin = lbe, col = sex), shape = 1, linetype = "dotted", position = position_dodge(width = 1))
        } else {
            p  <- p + geom_pointrange(aes(year, cpue, ymax = ube, ymin = lbe, col = Model), shape = 1, linetype = "dotted", position = position_dodge(width = 1))
        }
    }
    
    if (.OVERLAY) {
        if (length(M) == 1 && length(unique(mdf$sex)) == 1) {
            p <- p + geom_line(data = mdf, aes(year, pred)) +
                facet_wrap(~fleet, scales = "free_y")
        } else if (length(M) != 1 && length(unique(mdf$sex)) == 1) {
            p <- p + geom_line(data = mdf, aes(year, pred, color = Model, linetype = Model)) +
                facet_wrap(~fleet, scales = "free_y")
        } else if (length(M) == 1 && length(unique(mdf$sex)) != 1) {
            p <- p + geom_line(data = mdf, aes(year, pred, color = sex)) + labs(col = slab) +
                facet_wrap(~fleet + sex, scales = "free_y")
        } else {
            p <- p + geom_line(data = mdf, aes(year, pred, color = Model, linetype = Model)) +
                facet_wrap(~fleet + sex, scales = "free_y")
        }
    } else {
        p  <- p + geom_line(data = mdf, aes(year, pred))
        p  <- p + facet_wrap(~fleet + sex + Model, scales = "free_y")
    }

    p  <- p + labs(x = xlab, y = ylab)
    print(p + .THEME)
}


#' Plot residuals of cpue or other indices
#'
#' @param replist List object created by read_admb function
#' @param xlab the x-axis label for the plot
#' @param ylab the y-axis label for the plot
#' @param slab the sex label for the plot that appears above the key
#' @return plot of fit indices residuals
#' @author SJD Martell, D'Arcy N. Webber
#' @export
#' 
plot_cpue_res <- function(M, subsetby = "", xlab = "Year", ylab = "Residual", slab = "Sex")
{
    xlab <- paste0("\n", xlab)
    ylab <- paste0(ylab, "\n")
    
    mdf <- .get_cpue_df(M)
    if (subsetby != "") mdf <- subset(mdf, fleet == subsetby)
    
    p  <- ggplot(data = mdf, aes(year, resd)) +
        geom_hline(aes(yintercept = 0))
    if (length(M) == 1 && length(unique(mdf$sex)) == 1)
    {
        p <- p + geom_point(data = mdf, aes(year, resd)) +
            geom_segment(aes(x = year, xend = year, y = 0, yend = resd)) +
            facet_wrap(~fleet, scales = "free_y")
    } else if (length(M) != 1 && length(unique(mdf$sex)) == 1) {
        p <- p + geom_point(data = mdf, aes(year, resd, color = Model)) +
            geom_segment(aes(x = year, xend = year, y = 0, yend = resd, color = Model)) +
            facet_wrap(~fleet, scales = "free_y")
    } else if (length(M) == 1 && length(unique(mdf$sex)) != 1) {
        p <- p + geom_point(data = mdf, aes(year, resd, color = sex)) + labs(col = slab) +
            geom_segment(aes(x = year, xend = year, y = 0, yend = resd, color = sex)) +
            facet_wrap(~fleet + sex, scales = "free_y")
    } else {
        p <- p + geom_point(data = mdf, aes(year, resd, color = Model)) +
            geom_segment(aes(x = year, xend = year, y = 0, yend = resd, color = Model)) +
            facet_wrap(~fleet + sex, scales = "free_y")
    }

    p  <- p + labs(x = xlab, y = ylab, fill = slab)
    print(p + .THEME)
}

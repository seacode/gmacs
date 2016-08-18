#' Get the selectivity data
#'
#' @param M list object created by read_admb function
#' @return list of selectivities
#' @author SJD Martell, D'Arcy N. Webber
#' @export
#' 
.get_selectivity_df <- function(M)
{
    n   <- length(M)
    mdf <- NULL
    for (i in 1:n)
    {
        A <- M[[i]]
        # captured
        df <- data.frame(Model = names(M)[i], type = .TYPE[1], M[[i]]$slx_capture)
        # retained
        dr <- data.frame(Model = names(M)[i], type = .TYPE[2], M[[i]]$slx_retaind)
        colnames(df) <- c("Model", "type", "year", "sex", "fleet", as.character(A$mid_points))
        colnames(dr) <- colnames(df)
        df$sex   = .SEX[df$sex + 1]
        df$fleet = .FLEET[df$fleet]
        dr$sex   = .SEX[dr$sex + 1]
        dr$fleet = .FLEET[dr$fleet]
        Mslx <- M[[i]][["slx_control"]]
        blkyr <- Mslx[Mslx[,1] > 0, 12]
        df <- filter(df, year %in% blkyr)
        blkyr <- Mslx[Mslx[,1] < 0, 12]
        dr <- filter(dr, year %in% blkyr)
        mdf <- rbind(mdf, melt(df, id.var = 1:5), melt(dr, id.var = 1:5))
        mdf$variable <- as.numeric(as.character(mdf$variable))
    }
    mdf$fleet <- factor(mdf$fleet, levels = .FLEET)
    mdf$sex <- factor(mdf$sex, levels = .SEX)
    return(mdf)
}


#' Plot selectivity
#'
#' This function takes a list of lists created by the read_admb function plots
#' the selectivity by fishing fleet, sex, year, type (retained or discarded) and
#' model.
#' 
#' @param M list of lists created by the read_admb function
#' @param xlab the x-axis label for the plot
#' @param ylab the y-axis label for the plot
#' @param tlab the type (retained or discarded) label for the plot that appears above the key
#' @param ilab the year label for the plot that appears above the key
#' @param nrow the number of rows in the facet grid
#' @param ncol the number of columns in the facet grid
#' @return plot of selectivity
#' @author SJD Martell, D'Arcy N. Webber
#' @export
#' 
plot_selectivity <- function(M,
                             xlab = "Mid-point of size class (mm)",
                             ylab = "Selectivity",
                             tlab = "Type", ilab = "Period year",
                             nrow = NULL, ncol = NULL)
{
    xlab <- paste0("\n", xlab)
    ylab <- paste0(ylab, "\n")
    
    mdf <- .get_selectivity_df(M)
    
    p <- ggplot(mdf) + expand_limits(y = c(0,1))
    if (.OVERLAY)
    {
        p <- p + geom_line(aes(variable, value, col = factor(year), linetype = type))
        if (length(M) == 1 && length(unique(mdf$sex)) == 1)
        {
            p <- p + facet_wrap(~fleet, nrow = nrow, ncol = ncol)
        } else if (length(M) != 1 && length(unique(mdf$sex)) == 1) {
            p <- p + facet_wrap(~Model + fleet, nrow = nrow, ncol = ncol)
        } else if (length(M) == 1 && length(unique(mdf$sex)) != 1) {
            p <- p + facet_wrap(~sex + fleet, nrow = nrow, ncol = ncol)
        } else {
            p <- p + facet_wrap(~Model + sex + fleet, nrow = nrow, ncol = ncol)
        }
    } else {
        p <- p + geom_line(aes(variable, value, col = factor(year), linetype = sex))
        p <- p + facet_wrap(~Model + fleet + type, nrow = nrow, ncol = ncol)
    }
    p <- p + labs(y = ylab, x = xlab, col = ilab, linetype = tlab)
    print(p + .THEME)
}


#' Plot selectivity 3D
#'
#' @param M list object created by read_admb function
#' @param plt_surface include a panel with surface over size-time 
#' @return 3D plot of selectivity
#' @author D'Arcy N. Webber
#' @export
#' 
plot_selectivity_3d <- function(M, plt_surface = FALSE)
{
    mdf <- .get_selectivity_df(M)
    df3 <- subset(mdf, unique(year) > 1)
    
    p <- ggplot(mdf) + expand_limits(y = 0)
    if(.OVERLAY)
    {
        p <- p + geom_line(aes(as.numeric(variable),value,col=type,linetype=factor(year)))
        p <- p + facet_wrap(~Model+sex+fleet)
    } else {
        p <- p + geom_line(aes(as.numeric(variable),value,col=sex,linetype=factor(year)))
        p <- p + facet_wrap(~Model + fleet + type)
    }
    p <- p + labs(y = "Selectivity\n",
                  x = "\nMid-point of size class (mm)",
                  col = "Type", linetype = "Block Year")
    print(p + .THEME)
}

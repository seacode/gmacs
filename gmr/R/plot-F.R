#' Get F parameters
#'
#' @param M List object(s) created by read_admb function
#' @return dataframe of Fs
#' @author D'Arcy N. Webber
#' @export
#'
.get_F_df <- function(M)
{
    n <- length(M)
    fdf <- NULL
    fbar <- NULL
    for ( i in 1:n )
    {
        A <- M[[i]]
        nyear <- length(A$mod_yrs)
        nseas <- nseason <- A$nseason
        nclass <- length(A$mid_points)
        nfleet <- A$nfleet
        df <- data.frame(A$ft, Model = names(M)[i])
        colnames(df) <- c(1:nseason, "model")
        df$year <- rep(A$mod_yrs, by = nfleet)
        df$fleet <- rep(.FLEET, each = nyear*A$nsex)
        df$sex <- rep("Sex",nrow(df))
        if(A$nsex==2)
          df$sex <- rep(rep(c("Male","Female"),each = nyear),nfleet)
        del <- NULL
        for ( j in 1:nseason )
        {
            if (all(df[,j] == 0))
            {
                del <- c(del, j)
                nseas <- nseas - 1
            }
        }
        df <- df[,-del]
        df <- tidyr::gather(df, "season", "F", 1:nseas)
        for ( j in unique(df$model) )
        {
            for ( k in unique(df$season) )
            {
                for ( l in unique(df$fleet) )
                {
                    if (all(df[df$model %in% j & df$season %in% k & df$fleet %in% l,]$F == 0)) df <- df[-which(df$model %in% j & df$season %in% k & df$fleet %in% l),]
                }
            }
        }
        fdf <- rbind(fdf, df)

        df <- data.frame(Model = names(M)[i], fbar = exp(A$log_fbar))
        df$fleet <- .FLEET
        df <- df[which(df$fleet %in% unique(fdf$fleet)),]
        fbar <- rbind(fbar, df)
    }
    fdf$year <- as.integer(fdf$year)
    fdf$fleet <- factor(fdf$fleet, levels = .FLEET)
    fbar$fleet <- factor(fbar$fleet, levels = .FLEET)
    return(list(F = fdf, fbar = fbar))
}


#' Plot fishing mortality
#'
#' @param M list object created by read_admb function
#' @param xlab the x-axis label for the plot
#' @param ylab the y-axis label for the plot
#' @param mlab the model label for the plot that appears above the key
#' @return plot of fishing mortality and mean Fs
#' @author D'Arcy N. Webber
#' @export
#' 
plot_F <- function(M, scales = "free_y",
                   xlab = "Year", ylab = "F", mlab = "Model",
                   in_leg_x=.7,in_leg_y=.9)
{
    xlab <- paste0("\n", xlab)
    ylab <- paste0(ylab, "\n")

    m <- .get_F_df(M)
    mdf<-m$F
    mdf$season <- paste0("Season: ", mdf$season)
    fbar <- m$fbar

    p <- ggplot(data = mdf) +         geom_line(aes(year, F,col=model))
        #geom_hline(data = fbar, aes(yintercept = fbar, color = Model), linetype = "dashed", alpha = 0.5) +

        if(length(unique(mdf$sex))==1)
         p <- p + facet_grid(fleet ~ season, scales = scales) + labs(x = xlab, y = ylab)
  
        if(length(unique(mdf$sex))>1)
         p <- p + facet_grid(fleet ~ season + sex, scales = scales) + labs(x = xlab, y = ylab)
    #dcast( mdf , year~fleet+model  ,value.var="F")
      
    # if (.OVERLAY)
    # {
    #     if (length(M) == 1 && length(unique(mdf$sex)) == 1)
    #     {
    #         p <- p + geom_line(aes(x = as.integer(year), y = predicted), alpha = 0.4) +
    #             facet_wrap(~fleet + type + units, scales = scales)
    #     } else if (length(M) != 1 && length(unique(mdf$sex)) == 1) {
    #         p <- p + geom_line(aes(x = as.integer(year), y = predicted, col = model), alpha = 0.4) +
    #             facet_wrap(~fleet + type + units, scales = scales) +
    #             labs(col = mlab)
    #     } else if (length(M) == 1 && length(unique(mdf$sex)) != 1) {
    #         p <- p + geom_line(aes(x = as.integer(year), y = predicted), alpha = 0.4) +
    #             facet_wrap(~sex + fleet + type + units, scales = scales)
    #     } else {
    #         p <- p + geom_line(aes(x = as.integer(year), y = predicted, col = model), alpha = 0.4) +
    #             facet_wrap(~sex + fleet + type + units, scales = scales) +
    #             labs(col = mlab)
    #     }
    # } else {
    #     #p <- p + geom_line(aes(x = as.integer(year), y = predicted, col = model), alpha = 0.4)
    #     p <- p + facet_wrap(~model + fleet + type, scales = scales)
    # }
    print(p + .THEME+ theme(legend.position=c(in_leg_x,in_leg_y)))
}

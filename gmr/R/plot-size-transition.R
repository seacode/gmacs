#' Plot size transition
#'
#' @param M list of object(s) created by read_admb function
#' @return plot of size transition matrix
#' @author SJD Martell, DN Webber
#' @export
#' 
plot_size_transition <- function(M)
{
    n   <- length(M)
    mdf <- NULL
    for(i in 1:n)
    {
        x <- M[[i]]$mid_points
        G <- M[[i]]$tS
        h <- dim(G)[1]/dim(G)[2]
        colnames(G) <- paste(x)
        s  <- .SEX[as.vector(sapply(1:h,rep,20))+1]
        df <- data.frame(Model = names(M)[i], mp = x, sex = s, G)
        mdf <- rbind(mdf, df)
    }
    mdf <- melt(mdf, id.var = c("Model", "sex", "mp"))
    mdf$variable <- as.character(mdf$variable)
    mdf$variable <- as.factor(gsub("X", "", mdf$variable))
    mdf$variable <- factor(mdf$variable, levels = sort(as.numeric(levels(mdf$variable))))

    p <- ggplot(mdf, aes(x = mp, y = value, col = Model, linetype = factor(sex)))
    p <- p + geom_line()
    p <- p + labs(x = "\nSize-class (mm)", y = "P(size transition | molt)\n", linetype = "Sex")
    p <- p + facet_wrap(~variable)
    #if(!.OVERLAY) p <- p + facet_wrap(~Model)
    print(p + .THEME)
}


#' Plot growth transition
#'
#' @param M list of object(s) created by read_admb function
#' @return plot of size transition matrix
#' @author SJD Martell, DN Webber
#' @export
#' 
plot_growth_transition <- function(M)
{
    n   <- length(M)
    mdf <- NULL
    for(i in 1:n)
    {
        x <- M[[i]]$mid_points
        G <- M[[i]]$tG
        h <- dim(G)[1]/dim(G)[2]
        colnames(G) <- paste(x)
        s  <- .SEX[as.vector(sapply(1:h,rep,20))+1]
        df <- data.frame(Model = names(M)[i], mp = x, sex = s, G)
        mdf <- rbind(mdf, df)
    }
    mdf <- melt(mdf, id.var = c("Model", "sex", "mp"))
    mdf$variable <- as.character(mdf$variable)
    mdf$variable <- as.factor(gsub("X", "", mdf$variable))
    mdf$variable <- factor(mdf$variable, levels = sort(as.numeric(levels(mdf$variable))))

    p <- ggplot(mdf, aes(x = mp, y = value, col = Model, linetype = factor(sex)))
    p <- p + geom_line()
    p <- p + labs(x = "\nSize-class (mm)", y = "P(size transition | molt)\n", linetype = "Sex")
    p <- p + facet_wrap(~variable)
    #if(!.OVERLAY) p <- p + facet_wrap(~Model)
    print(p + .THEME)
}

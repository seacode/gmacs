#' Plot growth transition
#'
#' The sex-specific growth transition probabilities (G_h, for all crabs that molt)
#'
#' @param M a list of object(s) created by read_admb function
#' @param xlab the x-axis label for the plot
#' @param ylab the y-axis label for the plot
#' @param slab the sex label for the plot that appears above the key
#' @return plot of size transition matrix
#' @author SJD Martell, D'Arcy N. Webber
#' @export
#' 
plot_growth_transition <- function(M, xlab = "Size-class", ylab = "P(size transition | molt)", slab = "Sex")
{
    xlab <- paste0("\n", xlab)
    ylab <- paste0(ylab, "\n")
    
    n <- length(M)
    mdf <- NULL
    for (i in 1:n)
    {
        x <- M[[i]]$mid_points
        G <- M[[i]]$growth_transition
        #G <- M[[i]]$tG
        h <- dim(G)[1] / dim(G)[2]
        colnames(G) <- paste(x)
        #s <- .SEX[as.vector(sapply(1:h, rep, 20)) + 1]
        s <- .SEX[as.vector(sapply(1:h, rep, length(x))) + 1]
        df <- data.frame(Model = names(M)[i], mp = x, sex = s, G)
        mdf <- rbind(mdf, df)
    }
    
    mdf <- melt(mdf, id.var = c("Model", "sex", "mp"))
    mdf$variable <- as.character(mdf$variable)
    mdf$variable <- as.factor(gsub("X", "", mdf$variable))
    mdf$variable <- factor(mdf$variable, levels = sort(as.numeric(levels(mdf$variable))))
    mdf$sex <- factor(mdf$sex, levels = sort(levels(mdf$sex)))

    p <- ggplot(mdf, aes(x = mp, y = value, col = Model, linetype = factor(sex)))
    p <- p + geom_line()
    p <- p + labs(x = xlab, y = ylab, linetype = slab)
    p <- p + facet_wrap(~variable)
    #if(!.OVERLAY) p <- p + facet_wrap(~Model)
    print(p + .THEME)
}


#' Plot size transition
#'
#' The combination of growth transitions (G_h) and molting probability (P_h)
#' represents the size transition.
#' 
#' @param M list of object(s) created by read_admb function
#' @param xlab the x-axis label for the plot
#' @param ylab the y-axis label for the plot
#' @param slab the sex label for the plot that appears above the key
#' @param females logical indicating if the females are to be plotted or not
#' @return plot of size transition matrix
#' @author SJD Martell, D'Arcy N. Webber
#' @export
#' 
plot_size_transition <- function(M, xlab = "Size-class", ylab = "P(size transition | molt)",
                                 slab = "Sex", females = FALSE)
{
    xlab <- paste0("\n", xlab)
    ylab <- paste0(ylab, "\n")
    
    n <- length(M)
    mdf <- NULL
    for (i in 1:n)
    {
        x <- M[[i]]$mid_points
        G <- M[[i]]$size_transition_M
        if (females) G <- rbind(G, M[[i]]$size_transition_F)
        #G <- M[[i]]$tS
        #G <- M[[i]]$growth_matrix
        h <- dim(G)[1] / dim(G)[2]
        colnames(G) <- paste(x)
        #s <- .SEX[as.vector(sapply(1:h, rep, 20)) + 1]
        s <- .SEX[as.vector(sapply(1:h, rep, length(x))) + 1]
        df <- data.frame(Model = names(M)[i], mp = x, sex = s, G)
        mdf <- rbind(mdf, df)
    }
    mdf <- melt(mdf, id.var = c("Model", "sex", "mp"))
    mdf$variable <- as.character(mdf$variable)
    mdf$variable <- as.factor(gsub("X", "", mdf$variable))
    mdf$variable <- factor(mdf$variable, levels = sort(as.numeric(levels(mdf$variable))))
    mdf$sex <- factor(mdf$sex, levels = sort(levels(mdf$sex)))

    p <- ggplot(mdf, aes(x = mp, y = value, col = Model, linetype = factor(sex)))
    p <- p + geom_line()
    p <- p + labs(x = xlab, y = ylab, linetype = slab)
    p <- p + facet_wrap(~variable)
    #if(!.OVERLAY) p <- p + facet_wrap(~Model)
    print(p + .THEME)
}

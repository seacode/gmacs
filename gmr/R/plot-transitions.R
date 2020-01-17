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
plot_growth_transition <- function(M, xlab = "Mid-point of size-class (mm)", ylab = "P(growth transition)", slab = "Sex")
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
    mdf$variable <- gsub("X", "", as.character(mdf$variable))
    mdf$variable <- as.numeric(mdf$variable)
    mdf$sex <- factor(mdf$sex, levels = sort(levels(mdf$sex)))
    mdf$mp <- factor(mdf$mp)

    if (length(unique(mdf$sex)) == 1 && length(unique(mdf$Model)) == 1)
    {
        p <- ggplot(mdf, aes(x = variable, y = value))
    } else if (length(unique(mdf$sex)) != 1 && length(unique(mdf$Model)) == 1) {
        p <- ggplot(mdf, aes(x = variable, y = value, linetype = factor(sex)))
    } else if (length(unique(mdf$sex)) == 1 && length(unique(mdf$Model)) != 1) {
        p <- ggplot(mdf, aes(x = variable, y = value, col = Model))
    } else {
        p <- ggplot(mdf, aes(x = variable, y = value, col = Model, linetype = factor(sex)))
    }
    p <- p + geom_line()
    p <- p + labs(x = xlab, y = ylab, linetype = slab)
    p <- p + facet_wrap(~mp)
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
#' @return plot of size transition matrix
#' @author SJD Martell, D'Arcy N. Webber
#' @export
#' 
plot_size_transition <- function(M, xlab = "Mid-point of size-class after transition (mm)", ylab = "P(growth transition | molt)",
                                 slab = "Sex")
{
    xlab <- paste0("\n", xlab)
    ylab <- paste0(ylab, "\n")
    
    n <- length(M)
    mdf <- NULL
    for (i in 1:n)
    {
        x <- M[[i]]$mid_points
        G <- M[[i]]$size_transition_M
        if (!is.null(M[[i]]$size_transition_F)) G <- rbind(G, M[[i]]$size_transition_F)
        h <- dim(G)[1] / dim(G)[2]
        colnames(G) <- paste(x)
        s <- .SEX[as.vector(sapply(1:h, rep, length(x))) + 1]
        df <- data.frame(Model = names(M)[i], mp = x, sex = s, G)
        mdf <- rbind(mdf, df)
    }
    mdf <- melt(mdf, id.var = c("Model", "sex", "mp"))
    mdf$variable <- gsub("X", "", as.character(mdf$variable))
    mdf$variable <- as.numeric(mdf$variable)
    mdf$sex <- factor(mdf$sex, levels = sort(levels(mdf$sex)))
    mdf$mp <- factor(mdf$mp)

    if (length(unique(mdf$sex)) == 1 && length(unique(mdf$Model)) == 1)
    {
        p <- ggplot(data = mdf, aes(x = variable, y = value))
    } else if (length(unique(mdf$sex)) != 1 && length(unique(mdf$Model)) == 1) {
        p <- ggplot(data = mdf, aes(x = variable, y = value, linetype = factor(sex)))
    } else if (length(unique(mdf$sex)) == 1 && length(unique(mdf$Model)) != 1) {
        p <- ggplot(data = mdf, aes(x = variable, y = value, col = Model))
    } else {
        p <- ggplot(data = mdf, aes(x = variable, y = value, col = Model, linetype = factor(sex)))
    }
    p <- p + geom_line()
    p <- p + labs(x = xlab, y = ylab, linetype = slab)
    p <- p + facet_wrap(~mp)
    #if(!.OVERLAY) p <- p + facet_wrap(~Model)
    print(p + .THEME)
}

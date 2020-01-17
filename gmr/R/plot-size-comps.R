#' Get observed and predicted size composition values
#'
#' @param M a list of lists created by the read_admb function
#' @return a list of observed and predicted size composition values
#' @export
#'
.get_sizeComps_df <- function(M)
{
    n <- length(M)
    ldf <- list()
    mdf <- mpf <- mrf <- NULL
    for (i in 1:n)
    {
        A <- M[[i]]
        df <- data.frame(Model = names(M)[i], cbind(A$d3_SizeComps[,1:8], A$d3_obs_size_comps_out))
        pf <- data.frame(Model = names(M)[i], cbind(A$d3_SizeComps[,1:8], A$d3_pre_size_comps_out))
        rf <- data.frame(Model = names(M)[i], cbind(A$d3_SizeComps[,1:8], A$d3_res_size_comps_out))
        
        colnames(df) <- tolower(c("Model", "Year", "Seas", "Fleet", "Sex", "Type", "Shell", "Maturity", "Nsamp", as.character(A$mid_points)))
        colnames(pf) <- colnames(rf) <- colnames(df)
        
        df$fleet    <- pf$fleet    <- rf$fleet    <- .FLEET[df$fleet]
        df$sex      <- pf$sex      <- rf$sex      <- .SEX[df$sex+1]
        df$shell    <- pf$shell    <- rf$shell    <- .SHELL[df$shell+1]
        df$maturity <- pf$maturity <- rf$maturity <- .MATURITY[df$maturity+1]
        df$type     <- pf$type     <- rf$type     <- .TYPE[df$type+1]
        df$seas     <- pf$seas     <- rf$seas     <- .SEAS[df$seas]
	
        mdf <- rbind(mdf, df)
        mpf <- rbind(mpf, pf)
        mrf <- rbind(mrf, rf)
    }
    
    mdf <- reshape2::melt(mdf, id.var = 1:9)
    mpf <- reshape2::melt(mpf, id.var = 1:9)
    mrf <- reshape2::melt(mrf, id.var = 1:9)
    
    for(i in 1:n)
    {
        j  <- 1
        for(k in unique(df$fleet))
        {
            for(h in unique(df$sex))
            {
		for(t in unique(df$type))
                {
                    for(s in unique(df$shell))
                    {
			tdf <- mdf %>% filter(fleet==k) %>% filter(sex==h) %>% filter(type==t) %>% filter(shell==s)
			tpf <- mpf %>% filter(fleet==k) %>% filter(sex==h) %>% filter(type==t) %>% filter(shell==s)
			trf <- mrf %>% filter(fleet==k) %>% filter(sex==h) %>% filter(type==t) %>% filter(shell==s)
			if(dim(tdf)[1]!=0)
			{
				# deterimin row & column.
				# fyr = unique(tdf$year)
				# syr = min(fyr); nyr = max(fyr)
				# nn  = (nyr-syr+1)
				# nc  = ceiling(nn/sqrt(nn))
				# irow = icol = rep(1,length=nn)

				# ii = ic = ir = 1
				# for(iyr in fyr)
				# {
				# 	icol[ii] <- ic
				# 	irow[ii] <- ir

				# 	ic = ic + 1
				# 	ii = ii + 1

				# 	if(ic > nc)
				# 	{
				# 		ic = 1
				# 		ir = ir + 1	
				# 	} 
				# }
				# tdf$irow = irow[tdf$year-syr+1]
				# tdf$icol = icol[tdf$year-syr+1]
				# cat(" n = ",nn,"\n")
				# print(tdf$year - syr + 1)
                            ldf[[j]] <- cbind(tdf, pred = tpf$value, resd = trf$value)
                            j <- j + 1
			}
                    }
                }
            }
        }
    }   
    return(ldf)
}


#' Plot fits to size composition data
#' 
#' Get observed and predicted size composition values
#'
#' @param M List object(s) created by read_admb function
#' @param which_plots the size composition fits that you want to plot
#' @param xlab the x-axis label for the plot
#' @param ylab the y-axis label for the plot
#' @param slab the sex label for the plot that appears above the key
#' @param mlab the model label for the plot that appears above the key
#' @param tlab the fleet label for the plot that appears above the key
#' @param res boolean if residual or observed and predicted
#' @return Plots of observed and predicted size composition values
#' @export
#'
plot_size_comps <- function(M, which_plots = "all", xlab = "Mid-point of size-class (mm)", ylab = "Proportion",
                            slab = "Sex", mlab = "Model", tlab = "Fleet", res = FALSE,legend_loc=c(1,1),ylim_max=0.3)
{
    ylab <- paste0(ylab, "\n")

    mdf <- .get_sizeComps_df(M)
    ix <- pretty(1:length(M[[1]]$mid_points))
    
    p <- ggplot(data = mdf[[1]])
    
    if (res)
    {
        xlab <- paste0(xlab, "\n")
        p <- p + geom_point(aes(factor(year), variable, col = factor(sign(resd)), size = abs(resd)), alpha = 0.6)
        p <- p + scale_size_area(max_size = 10)
        p <- p + labs(x = "\nYear", y = xlab, col = "Sign", size = "Residual")
        #p <- p + scale_x_discrete(breaks = pretty(mdf[[1]]$mod_yrs))
        #p <- p + scale_y_discrete(breaks = pretty(mdf[[1]]$mid_points))
        if (length(unique(do.call(rbind.data.frame, mdf)$model)) != 1)
        {
            p <- p + facet_wrap(~model)
        }
        p <- p + .THEME + theme(axis.text.x = element_text(angle = 45, vjust = 0.5))
    } else {
        xlab <- paste0("\n", xlab)
        p <- p + geom_bar(aes(variable, value), stat = "identity", position = "dodge", alpha = 0.5, fill = "grey")
        if (length(unique(do.call(rbind.data.frame, mdf)$model)) == 1)
        {
            p <- p + geom_line(aes(as.numeric(variable), pred), alpha = 0.85)
        } else {
            p <- p + geom_line(aes(as.numeric(variable), pred, col = model), alpha = 0.85)
        }
        p <- p + scale_x_discrete(breaks=M[[1]]$mid_points[ix]) 
        p <- p + labs(x = xlab, y = ylab, col = mlab, fill = slab, linetype = tlab)
        p <- p + ggtitle("title")
        p <- p + facet_wrap(~year,dir="v") + .THEME + ylim(0,ylim_max)
        p <- p + theme(axis.text.x = element_text(angle = 45, vjust = 0.5, size = 6),
                       strip.text.x = element_text(margin= margin(1,0,1,0)),
                       panel.grid.major = element_blank(), 
                       panel.grid.minor = element_blank(),
                       legend.position=legend_loc,
                       panel.border = element_blank(),
                       strip.background = element_rect(color="white",fill="white"))
        #p <- p + geom_text(aes(label = paste0("N = ", nsamp)), x = -Inf, y = Inf, hjust = -0.2, vjust = 1.5)
    }
    #print(p)
    fun <- function(x, p)
    {
        if (length(unique(do.call(rbind.data.frame, mdf)$fleet)) == 1 && length(unique(do.call(rbind.data.frame, mdf)$sex)) == 1 && length(unique(do.call(rbind.data.frame, mdf)$seas)) == 1)
        {
            p$labels$title <- ""
        } else if (length(unique(do.call(rbind.data.frame, mdf)$fleet)) != 1 && length(unique(do.call(rbind.data.frame, mdf)$sex)) == 1 && length(unique(do.call(rbind.data.frame, mdf)$seas)) == 1) {
            p$labels$title <- paste("Gear =", unique(x$fleet))
        } else if (length(unique(do.call(rbind.data.frame, mdf)$fleet)) == 1 && length(unique(do.call(rbind.data.frame, mdf)$sex)) != 1 && length(unique(do.call(rbind.data.frame, mdf)$seas)) == 1) {
            p$labels$title <- paste("Sex =", unique(x$sex))
        } else if (length(unique(do.call(rbind.data.frame, mdf)$fleet)) == 1 && length(unique(do.call(rbind.data.frame, mdf)$sex)) == 1 && length(unique(do.call(rbind.data.frame, mdf)$seas)) != 1) {
            p$labels$title <- paste("Season =", unique(x$seas))
        } else if (length(unique(do.call(rbind.data.frame, mdf)$fleet)) != 1 && length(unique(do.call(rbind.data.frame, mdf)$sex)) != 1 && length(unique(do.call(rbind.data.frame, mdf)$seas)) == 1) {
            p$labels$title <- paste("Gear =", unique(x$fleet), ", Sex =", unique(x$sex))
        } else if (length(unique(do.call(rbind.data.frame, mdf)$fleet)) != 1 && length(unique(do.call(rbind.data.frame, mdf)$sex)) == 1 && length(unique(do.call(rbind.data.frame, mdf)$seas)) != 1) {
            p$labels$title <- paste("Gear =", unique(x$fleet), ", Season =", unique(x$seas))
        } else if (length(unique(do.call(rbind.data.frame, mdf)$fleet)) == 1 && length(unique(do.call(rbind.data.frame, mdf)$sex)) != 1 && length(unique(do.call(rbind.data.frame, mdf)$seas)) != 1) {
            p$labels$title <- paste("Sex =", unique(x$sex), ", Season =", unique(x$seas))
        } else {
            p$labels$title <- paste("Gear =", unique(x$fleet), ", Sex =", unique(x$sex), ", Season =", unique(x$seas))
        }
        p %+% x
    }
    
    plist <- lapply(mdf, fun, p = p)
    
    if (which_plots == "all")
    {
        print(plist)
    } else {
        print(plist[[which_plots]])
    }
}



#' Plot fits to size composition data
#' 
#' Get observed and predicted size composition values
#'
#' @param M List object(s) created by read_admb function
#' @param xlab the x-axis label for the plot
#' @param ylab the y-axis label for the plot
#' @return Plots of observed and predicted size composition values
#' @export
#'
plot_size_comps_res <- function(M, ncol = 1, xlab = "Year", ylab = "Mid-point of size-class (mm)")
{
    xlab <- paste0(xlab, "\n")
    ylab <- paste0(ylab, "\n")

    mdf <- .get_sizeComps_df(M) %>%
        reshape2::melt(id = c("model", "year", "seas", "fleet", "sex", "type", "shell", "maturity", "nsamp", "variable", "value", "pred", "resd")) %>%
        dplyr::mutate(seas = paste("Season", seas))
    
    p <- ggplot(data = mdf) +
        geom_point(aes(factor(year), variable, col = factor(sign(resd)), size = abs(resd)), alpha = 0.6) +
        scale_size_area(max_size = 10) +
        labs(x = xlab, y = xlab, col = "Sign", size = "Residual") +
        facet_wrap(fleet ~ seas, scales = "free_x", ncol = ncol) +
        .THEME + theme(axis.text.x = element_text(angle = 45, vjust = 0.5))
    print(p)
}

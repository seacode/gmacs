# plt_ft.R


plot.ft <- function( M )
{
	n <- length(M)
	mdf <- NULL
	for(i in 1:n)
	{
		A  <- M[[i]]
		df <- data.frame(Model=names(M)[i],A$dCatchData)
		colnames(df) <- c("model","year","seas","fleet","sex","obs","cv","type","units","mult","effort","discard.mortality")


		# Get Fishing mortality rate parameters.
		odf <- data.frame(par=A$fit$names,log_est=A$fit$est,log_std=A$fit$std)
		ifbar <- grep("log_fbar",odf$par)
		efbar <- odf$log_est[ifbar]
		sfbar <- odf$log_std[ifbar]

		# devs
		idev <- grep("log_fdev",odf$par)
		edev <- odf$log_est[idev]
		sdev <- odf$log_std[idev]
		
	}
}


# plot.ft <- function(M)
# {
# 	n   <- length(M)
# 	mdf <- NULL
# 	for (i in 1:n)
# 	{
# 		A  <- M[[i]]
# 		df <- data.frame(Model   = names(M)[i],
# 		                 par     = A$fit$names,
# 		                 log_est = A$fit$est,
# 		                 log_std = A$fit$std)
# 		ir <- grep("^log_f",df$par)
# 		df <- df[ir,]
# 		par <- df$par
# 		log_fbar <- df[grep("^log_fbar",par),]$log_est
# 		log_foff <- df[grep("^log_foff",par),]$log_est
# 		# log_fdev <- df[grep("^log_fd",df$par),]$log_est

# 		nf <- length(log_fbar)
# 		for (j in 1:nf) 
# 		{
# 			idx <- par[grep(j,par[grep("fdev",par)])]
# 		}

		
# 	}
# }
#plotSizeComps.R
require(reshape2)
df <- as.data.frame(cbind(A$d3_SizeComps[,1:8],A$d3_obs_size_comps))
pf <- as.data.frame(cbind(A$d3_SizeComps[,1:8],A$d3_pre_size_comps))
rf <- as.data.frame(cbind(A$d3_SizeComps[,1:8],A$d3_res_size_comps))
colnames(df) <- tolower(c("Year", "Seas", "Fleet", "Sex", "Type", "Shell",
							 "Maturity", "Nsamp", as.character(A$mid_points)))
colnames(rf) <- colnames(pf) <- colnames(df)
mdf <- melt(df,id=1:8)
mpf <- melt(pf,id=1:8)
mrf <- melt(rf,id=1:8)

fleet <- unique(mdf$fleet)
sex   <- unique(mdf$sex)
type  <- unique(mdf$type)
shell <- unique(mdf$shell)

i   <- 1
sdf <- list()

for(k in fleet)
{
	for(h in sex)
	{
		for(t in type)
		{
			for(s in shell)
			{
				tmpdf <- subset(mdf,fleet %in% k & sex %in% h & type %in% t & shell %in% s)
				tmppf <- subset(mpf,fleet %in% k & sex %in% h & type %in% t & shell %in% s)
				tmprf <- subset(mrf,fleet %in% k & sex %in% h & type %in% t & shell %in% s)
				if(dim(tmpdf)[1]!=0)
				{
					sdf[[i]] <- cbind(tmpdf,pred=tmppf$value,resid=tmprf$value)
					i <- i+1
				}
			}
		}
	}
}

# Observed & predicted size distribution.
p <- ggplot(data=sdf[[1]])
p <- p + geom_bar(aes(variable,value),stat="identity")
p <- p + geom_line(aes(as.numeric(variable),pred),col="red")
p <- p + scale_x_discrete(breaks=pretty(A$mid_points)) 
p <- p + facet_wrap(~year) + .THEME

pSizeComps <- lapply(sdf,FUN = function(x,p){p %+% x},p=p)

# Bubble plots for residuals
p <- ggplot(data=sdf[[1]])
p <- p + geom_point(aes(x=factor(year),variable,col=factor(sign(resid)),size=abs(resid))
                    ,alpha=0.6)
p <- p + scale_size_area(max_size=10)
p <- p + labs(x="Year",y="Length",col="Sign",size="Residual")
p <- p + scale_x_discrete(breaks=pretty(A$mod_yrs))
p <- p + scale_y_discrete(breaks=pretty(A$mid_points))
p <- p + .THEME

pSizeCompResid <- lapply(sdf,FUN = function(x,p){p %+% x},p=p)


















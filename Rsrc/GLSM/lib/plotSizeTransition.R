require(ggplot2)
df     <- data.frame(stm = A$size_transition)
colnames(df) <- A$mid_points
nrow   <- dim(A$size_transition)[2]
df$sex <- c(rep(1,length=nrow),rep(2,length=nrow))
df$col <- A$mid_points
mdf    <- melt(df,id=c("sex","col"))

p <- ggplot(mdf)
p <- p + geom_point(aes(variable,col,size=value),alpha=0.4,col="red")
p <- p + scale_size_area(max_size=10)
p <- p + labs(x="Post-molt carapace width",y="Pre-molt carapace width",size="Probability")
p <- p + facet_wrap(~sex)
pSizeTransition <- p

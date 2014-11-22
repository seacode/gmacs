require(ggplot2)


# Observed catch
df <- as.data.frame(A$dCatchData)
colnames(df)<- c("year","seas","fleet","sex","obs","cv","type","units","mult","effort")
df$residuals <- na.omit(as.vector(t(A$res_catch)))

#Loop over retained and discarded catch.
type = unique(df$type)
ldf  = list()
for(i in type)
{
	ldf[[i]] <- subset(df,type %in% i)
}

p <- ggplot(ldf[[1]],aes(x=factor(year),y=obs,fill=factor(sex)))
p <- p + geom_bar(stat = "identity")
p <- p + scale_x_discrete(breaks=pretty(df$year))
p <- p + labs(x="Year",y="Catch (million lbs)",fill="Sex")
p <- p + facet_wrap(~fleet,scales="free")

pCatch <- lapply(ldf,FUN = function(x,p){p %+% x},p=p)


# Residuals
p <- ggplot(ldf[[1]],aes(x=factor(year),y=residuals,fill=factor(sex)))
p <- p + geom_bar(stat = "identity", position="dodge")
p <- p + scale_x_discrete(breaks=pretty(df$year))
p <- p + labs(x="Year",y="Residuals ln(million lbs)",fill="Sex")
p <- p + facet_wrap(~fleet~type,scales="free")

pCatchRes <- lapply(ldf,FUN = function(x,p){p %+% x},p=p)
require(ggplot2)

# Observed catch
df <- as.data.frame(A$dCatchData)
colnames(df)<- c("year","seas","fleet","sex","obs","cv","type","units","mult","effort")
p <- ggplot(df,aes(x=factor(year),y=obs,fill=factor(sex)))
p <- p + geom_bar(stat = "identity")
p <- p + scale_x_discrete(breaks=pretty(df$year))
p <- p + labs(x="Year",y="Catch (million lbs)",fill="Sex")
pCatch <- p + facet_wrap(~fleet,scales="free")


# Residuals
df$residuals <- A$res_catch
p <- ggplot(df,aes(x=factor(year),y=residuals,fill=factor(sex)))
p <- p + geom_bar(stat = "identity", position="dodge")
p <- p + scale_x_discrete(breaks=pretty(df$year))
p <- p + labs(x="Year",y="Residuals ln(million lbs)",fill="Sex")
pCatchRes <- p + facet_wrap(~fleet,scales="free")
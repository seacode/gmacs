# REPORT FILE
source("./lib/read.admb.R")
repfile <- "../examples/demo/gsmac"

A <- read.admb(repfile)




# Plot catch
require(ggplot2)
df <- as.data.frame(A$dCatchData)
colnames(df)<- c("year","seas","fleet","sex","obs","cv","type","units","mult","effort")
p <- ggplot(df,aes(x=factor(year),y=obs,fill=factor(sex)))
p <- p + geom_bar(stat = "identity")
p <- p + scale_x_discrete(breaks=pretty(df$year))
p <- p + labs(x="Year",y="Catch (million lbs)",fill="Sex")
pCatch <- p + facet_wrap(~fleet,scales="free")
print(pCatch)

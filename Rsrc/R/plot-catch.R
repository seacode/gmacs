#' Plot observed and predicted catch values
#'
#' @param replist List object created by read_admb function
#' @param plot_res plot residuals only (default=F)
#' @return Plot of catch history (observed) and predicted values
#' @export
plot_catch <- function(replist, plot_res=FALSE)
{
  A  <- replist
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
  if (plot_res)
  {
    # Residuals
    p <- ggplot(df,aes(x=factor(year),y=residuals,fill=factor(sex)))
    p <- p + geom_bar(stat = "identity", position="dodge")
    p <- p + scale_x_discrete(breaks=pretty(df$year))
    p <- p + labs(x="Year",y="Residuals ln(kt)",fill="Sex")
    p <- p + facet_wrap(~fleet~type,scales="free")
  }
  else
  {
    p <- ggplot(df,aes(x=factor(year),y=obs,fill=factor(sex)))
    p <- p + geom_bar(stat = "identity")
    p <- p + scale_x_discrete(breaks=pretty(df$year))
    p <- p + labs(x="Year",y="Catch (kt)",fill="Sex")
    p <- p + facet_wrap(~fleet,scales="free")
  }
  # This line applies the plotting over all unique types...
  pCatch <- lapply(ldf,FUN = function(x,p){p %+% x},p=p)
  pCatch <- p + ggtheme
  return(pCatch)
}

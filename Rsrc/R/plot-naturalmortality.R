#' Plot natural mortality
#'
#' @param replist List object created by read_admb function
#' @return Plot natural mortality over time and size
#' @export
plot_naturalmortality <- function(replist){
  A    <- replist
  df   <- data.frame(A$M)
  colnames(df) <- A$mid_points
  nrow   <- dim(A$M)[1]
  # Always saves for both sexes???
  df$sex <- c(rep(1,length=nrow/2),rep(2,length=nrow/2))
  df$Year <- A$mod_yrs
  mdf    <- melt(df,id=c("sex","Year"))
  
  p <- ggplot(mdf,aes(x=Year,y=as.double(variable),z=value))
  p <- p + geom_tile(aes(fill = value)) 
  p <- p + stat_contour(geom="polygon", aes(fill=(value)))
  p <- p + labs(x="Year",y="size bin",fill="M")
  p <- p + facet_wrap(~sex,scale="free")
  p2 <- ggplot(mdf,aes(x=Year,y=value))
  p2 <- p2 + geom_line() + ggtheme + labs(y="Natural mortality")
  plot_multiple(p2,p)
}

#' Get selectivity
#'
#' @param replist List object created by read_admb function
#' @param type =1 Capture, =2 Retained, =3 Discarded selectivity 
#' @return List of selectivities
#' @export
get_selectivity <- function(replist,type=1){
  A  <- replist
  df <- as.data.frame(cbind(A$slx_capture))
  colnames(df) <- c("year", "sex", "fleet", as.character(A$mid_points))
  mdf <- melt(df,id=1:3)
  return(mdf)  
}

#' Plot selectivity
#'
#' @param replist List object created by read_admb function
#' @return Plot of selectivity
#' @export
plot_selectivity <- function(replist){
  sdf <- get_selectivity(replist)
  # Just do for last year
  sdf <- subset(sdf,year==max(sdf$year))

  # Still sucks because crappy x-axis label
  p <- ggplot(data=sdf,x=factor(variable))
  p <- p + geom_line(aes(as.numeric(variable),value),stat="identity")
  p <- p + labs(y="Selectivity",x="size bin")
  p <- p + facet_wrap(~fleet+sex) + ggtheme
  print(p)
  
  pSelectivity <- lapply(sdf,FUN = function(x,p){p %+% x},p=p)

  return(pSelectivity)
}

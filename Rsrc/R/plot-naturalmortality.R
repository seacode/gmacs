#' Plot natural mortality
#'
#' @param M List object created by read_admb function
#' @param plt_surface Include a panel with surface over size-time 
#' @return Plot natural mortality over time (and size)
#' @export
plot_naturalmortality <- function(M,plt_surface=FALSE)
{
  n    <- length(M)
  mdf  <- NULL
  for (i in 1:n)
  {
    A      <- M[[i]]
    nrow   <- dim(A$M)[1]
    nsex   <- nrow / length(A$mod_yrs)
    A$sex <- rep(1,length=nrow/nsex)
    if (nsex >1) A$sex <- c(A$sex,rep(2,length=nrow/nsex))
    df <- data.frame(Model=names(M)[i],cbind(A$mod_yrs, .SEX[A$sex+1], M[[i]]$M))
    colnames(df) <- c("Model","Year","sex",as.character(A$mid_points))
    mdf    <- melt(df,id=c("Model","sex","Year"))
  }
  
  #p <- ggplot(mdf,aes(x=Year,y=as.double(variable),z=value))
  #p <- p + geom_tile(aes(fill = value)) 
  #p <- p + stat_contour(geom="polygon", aes(fill=(value)))
  #p <- p + labs(x="Year",y="size bin",fill="M")
  #p <- p + facet_wrap(~sex,scale="free")
  p <- ggplot(mdf,aes(x=Year,y=value))
  p <- ggplot(mdf)
  p <- p + geom_line(aes(x=Year,value,col=sex))
  p <- p + facet_wrap(~Model)
  p <- p + geom_line() + ggtheme + labs(y="Natural mortality")
  print(p)
  plot_multiple(p2,p)
  }
}
    

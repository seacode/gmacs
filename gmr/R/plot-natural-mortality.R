#' Get natural mortality data
#'
#' @param M list object created by read_admb function
#' @author J Ianelli, SJD Martell, DN Webber
#' @export
#' 
.get_M_df <-function(M)
{
    n <- length(M)
    ldf <- list()
    mdf <- NULL
    for (i in 1:n)
    {
        A      <- M[[i]]
        nrow   <- dim(A$M)[1]
        nsex   <- nrow / length(A$mod_yrs)
        A$sex <- rep(1,length=nrow/nsex)
        if (nsex >1) A$sex <- c(A$sex,rep(2,length=nrow/nsex))
        df <- data.frame(Model=names(M)[i],(cbind(as.numeric(A$mod_yrs), 
                         .SEX[A$sex+1], as.numeric(M[[i]]$M[,1])) ),stringsAsFactors=FALSE)
        colnames(df) <- c("Model", "Year", "Sex", "M")
        df$M <- as.numeric(df$M)
        df$Year <- as.numeric(df$Year)
        mdf <- rbind(mdf, df)
    }
    mdf <- melt(mdf, id = c("Model", "Sex", "Year"), value.name = "M") 
    return(mdf)
}


#' Plot natural mortality
#'
#' @param M list object created by read_admb function
#' @param plt_surface include a panel with surface over size-time 
#' @return Plot natural mortality over time (and size)
#' @author J Ianelli, SJD Martell, DN Webber
#' @export
#' 
plot_natural_mortality <- function(M, plt_surface = FALSE)
{
  mdf <- .get_M_df(M)
  if (length(M) == 1)
  {
      p <- ggplot(mdf, aes(x = Year, y = M))
  } else {
      p <- ggplot(mdf, aes(x = Year, y = M, colour = Model))
  }
  if (length(unique(mdf$Sex)) == 1)
  {
      p <- p + geom_line()
  } else {
      p <- p + geom_line(aes(linetype = Sex))
  }
  p <- p + expand_limits(y = 0) + labs(x = "\nYear", y = "Natural mortality\n")
  print(p + .THEME)
  #p <- ggplot(mdf,aes(x=Year,y=as.double(variable),z=value))
  #p <- p + geom_tile(aes(fill = value)) 
  #p <- p + stat_contour(geom="polygon", aes(fill=(value)))
  #p <- p + labs(x="Year",y="size bin",fill="M")
  #p <- p + facet_wrap(~sex,scale="free")
  #ggplot(mdf, aes(x=Year, y=M, colour=sex, group=Model,stat="identity")) +
  #ggplot(mdf, aes(x=as.numeric(Year), y=M)) + geom_line() + expand_limits(y=0)
  #plot(mdf$Year,mdf$M,typ="b")
  #, aes(x=Year, y=M)) + geom_line(stat="identity") + expand_limits(y=0)
  # print(cbind(mdf$Year,mdf$value))
  #p <- p + facet_wrap(~Model)
  #plot_multiple(p2,p)
}


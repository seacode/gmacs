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
  #fleet <- unique(mdf$fleet)
  #sex   <- unique(mdf$sex)
  #i   <- 1
  #sdf <- list()
  #for(k in fleet)
  #{
    #for(h in sex)
    #{
      #tmpdf <- subset(mdf,fleet %in% k & sex %in% h)
      #if(dim(tmpdf)[1]!=0)
      #{
        #sdf[[i]] <- cbind(tmpdf)
        #i <- i+1
        #print(i)
      #}
    #}
  #}
  return(mdf)  
}

#' Plot selectivity
#'
#' @param replist List object created by read_admb function
#' @return Plot of selectivity
#' @export
plot_selectivity <- function(replist){
  A <- replist
  sdf <- get_selectivity(replist)

  p <- ggplot(data=sdf,x=mid_points)
  p <- p + geom_line(aes(as.numeric(variable),value),stat="identity")
  # p <- p + geom_line(aes(as.numeric(variable),pred),col="red")
  p <- p + labs(y="Selectivity",x="size bin")
  p <- p + facet_wrap(~fleet+sex) + ggtheme
  #p <- p + facet_wrap(~fleet) + ggtheme
  print(p)
  
  pSelectivity <- lapply(sdf,FUN = function(x,p){p %+% x},p=p)
  #n <- length(M)
  #mdf <- NULL
  #for(i in 1:n)
  #{
    #df <- data.frame(Model=names(M)[i],logSel=M[[i]]$log_sel)
    #colnames(df)<-c("Model","Gear","Sex","Year",M[[i]]$age)
#
    #mdf <- rbind(mdf,melt(df,id=c("Model","Gear","Sex","Year")))
  #}
#
  #p <- ggplot(mdf,aes(x=Year,y=as.double(variable),z=exp(value)/max(exp(value))))
  #p <- p + stat_contour(aes(colour = ..level..))
  #p <- p + labs(x="Year",y="Age",colour="Selectivity")
  ## p <- p + stat_contour(geom="polygon", aes(fill=exp(value)))
  #p <- p + facet_wrap(~Model+Gear+Sex,scale="free")
  #print(p + .THEME)

  return(pSelectivity)
}

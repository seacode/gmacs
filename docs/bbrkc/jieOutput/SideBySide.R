source("../../Rsrc/sourcethis.r")
# Load gmr package for Gmacs:
library(gmr)
library(devtools)
library(ggplot2)
# Set theme for ggplot2 (works for themes classic, minimal, gray, bw):
set_ggtheme('bw')

# Set working directory to that containing Gmacs model results:
setwd("~/_mymods/seacode/gmacs/examples/bbrkc")

# Read in Jie's file
j_mmb = read.table("jie_mmb.rep",header=T)
j_surv = read.table("jie_survb.rep",header=T)
j_len = read.table("jie_len_sched.rep",header=T)

# Read report file and create gmacs report object (a list):
gmrep <- read_admb('gmacs')

# Sex ratio
plot(apply(gmrep$N_males,1,sum)/apply(gmrep$N_len,1,sum))
gmrep$N_len

plot_catch(gmrep)
plot(gmrep$mid_points,gmrep$N_len[1,],typ="b",xlab="size",ylab="density",main="N at length in 1975")
Nbeg = (j_len$N1975_female + j_len$N1975_male_n)/1e3
lines(j_len$Size,Nbeg,col="red")

plot(gmrep$mid_points,gmrep$N_len[40,],ylim=c(0,18000),typ="b",xlab="size",ylab="density",main="N at length in 2014")
Nend = (j_len$N2014_female + j_len$N2014_male_n + j_len$N2014_male_o )/1e3
lines(j_len$Size,Nend,col="red")
summary(Nbeg)
summary(gmrep$N_len[1,])
Nbeg
plot(gmrep$mid_points,gmrep$rec_sdd,typ="b",xlab="size",ylab="density",main="Recruitment size distribution")
lines(j_len$Size,j_len$Female_R_sd,col="red")
lines(j_len$Size,j_len$Male_R_sd,col="blue")
plot(gmrep$mid_points,gmrep$molt_probability,typ="b",xlab="size",ylab="probability",main="Molting probability ")
plot(gmrep$mid_points,gmrep$molt_probability[1,],typ="b",xlab="size",ylab="density",main="Recruitment size distribution")
lines(gmrep$mid_points,gmrep$molt_probability[2,],typ="b",col="red")

names(gmrep)
plot_recruitment(gmrep)
plot_naturalmortality(gmrep)
plot_sizetransition(gmrep)
plot_cpue(gmrep)
plot_growth(gmrep)
plot_growth_inc(gmrep)
plot_selectivity(gmrep)

plot_catch(gmrep,plot_res=T)

plot_sizecomp(gmrep,which_plots=c(1))
plot_sizecomp(gmrep,which_plots=c(2))
plot_sizecomp(gmrep,which_plots=c(3))
plot_sizecomp(gmrep,which_plots=c(4))
plot_sizecomp(gmrep,which_plots=c(5))
plot_sizecomp(gmrep,which_plots=c(6))
plot_sizecomp(gmrep,which_plots=c(7))
plot_sizecomp(gmrep,which_plots=c(8))
plot_sizecomp(gmrep,which_plots=c(9))
plot_sizecomp(gmrep,which_plots=c(10))

plot_sizecomp(gmrep)
plot_sizecomp_res(gmrep, which_plots=c(2))


plot_sizecomp(gmrep,which_plots=c(11))
plot_sizecomp_res(mod1)


r1=get_recruitment(gmrep)
plot(r1$year,exp(r1$log_rec),ylab="Recruits",xlab="Year")
lines(j_mmb$yr,j_mmb$R*1000)
p=plot_recruitment(gmrep)
  p <- p + geom_line(aes(x=factor(yr[2:40]),y=R[1:39]),data=jie1)
  plot(p)
plot_ssb(gmrep)
 plot_datarange(gmrep)
 plot_datarange(mod1)
p <- plot_ssb(gmrep)
names(j_mmb)
dftmp = get_ssb(gmrep2)
  p <- p + geom_line(aes(x=yr,y=mmb*1e3),data=j_mmb,color="red")
  plot(p)

plot_naturalmortality(gmrep)
shiny_gmacs(gmrep)
A=gmrep
df   <- data.frame(sex=as.factor(A$iMoltIncSex),obs=A$pMoltInc, pred=A$dMoltInc,size=A$dPreMoltSize)
p <- ggplot(df)
p <- p + geom_line(aes(x=size,y=obs, colour=sex))
p <- p + geom_point(aes(x=size,y=pred, colour=sex))
p <- p + labs(x="Pre-molt size",y="Molting increment")
print(p)
#=========================================================================================================
names(jie1)
	A <- gmrep
	df <- as.data.frame(A$dSurveyData)
	colnames(df) <- c("year","seas","fleet","sex","cpue","cv","units")
	sd <- sqrt(log(1+df$cv^2))
	df$lb <- exp(log(df$cpue)-1.96*sd)
	df$ub <- exp(log(df$cpue)+1.96*sd)
	df$pred <- na.exclude(as.vector(t(A$pre_cpue)))
	df$resd <- na.exclude(as.vector(t(A$res_cpue)))
	df <-subset(df, df$fleet==3)
# p  <- p + geom_point(aes(col=sex))
	p  <- ggplot(df,aes(year,cpue))
	p  <- p + geom_pointrange(aes(year,cpue,ymax=ub,ymin=lb,col=sex))
	p  <- p + labs(x="Year",y="CPUE",col="Sex")
	#p <- p + facet_wrap(~fleet,scales="free")
# Fitted CPUE
	p<- p + geom_line(data=df,aes(year,pred))
	p<- p + geom_line(data=j_surv,aes(year,pred/1e3),col="red")
#	p <- p + geom_point(data=j_surv,aes(year,obs,col="red"))
	p <- p + geom_point(data=j_surv,aes(year,obs/1e3),col="red")
	print(p)

# Make a dataframe for plotting
df = data.frame( "year"=c(gmrep$mod_yrs,2015), "Pmales"=apply(gmrep$N_males,1,sum)/apply(gmrep$N_len,1,sum),
"Pmales_old"=apply(gmrep$N_males_old,1,sum)/apply(gmrep$N_males,1,sum),
"Nmm"=apply(gmrep$N_mm,1,sum), "Ntot"=apply(gmrep$N_len,1,sum))
	p  <- ggplot(df,aes(year,Ntot))
  p  <- p + geom_line(aes(col="blue"))
  p  <- p + geom_line(aes(year,Nmm,col="red"))
	p  <- p + labs(x="Year",y="numbers")
	print(p)
	pCPUE  <- p + facet_wrap(~fleet+sex,scales="free")

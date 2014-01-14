#=========================================================================================================
#
#  Gmacs.r : Version 1.0 (January 2014)
#  R script: Import content from Gmacs model output; produce plots.
#  Authors: Athol R. Whitten, James N. Ianelli 
#  Updated: January 2014
#
#  Acknowledgements: 'Read' functions based on code developed for ADMB by Steve Martell
#  Some plotting functions based on code developed for Stock Synthesis by Ian Taylor (r4ss).  
#
#  Returns: A list containing elements of gmacs_r.rep
#  Plots: Various fits to data, summary statistics.
#
#=========================================================================================================

# Remove previous R console objects; load required packages:
rm(list=ls())

#=======================================
# Set and load directories/files
#=======================================
layout(matrix(1:8, 4, 2, byrow = TRUE))
# Set directory and source read-in script:
#rootdir <- "C:/Dropbox/Gmacs"
#setwd(rootdir)
source('reptoRlist.r')
?layout

# Read and assign gmacs_r.rep output file:
gmout <- reptoRlist('gmacs_r.rep')
names(gmout)
summary(gmout)
# --------------------------------------------------------------------------------------------------------

# Plot fits to catch data (main fisheries):
plot(1, type="n", main="Fit to catch data", xlab="Years", ylab ="Catch (tonnes)", xlim=(c(min(gmout$years),max(gmout$years)+1)), ylim=c(0,max(gmout$catch_biom_obs[2, ])), cex.main=1.2)
nfleet_ret <- 2
for(ifleet in nfleet_ret)
 {
  abline(h=0)
  lines(gmout$years, gmout$catch_biom_obs[ifleet, ], type="p", pch=20, col=ifleet, cex=1.2)
  lines(gmout$years, gmout$catch_biom_pred[ifleet, ], type= "l", col=ifleet+2, lwd=2)
  legend("topright", legend=c("Observed","Predicted"), pch=20, col=c(ifleet,ifleet+2), bty="n")
 }
# Plot fits to catch data (main fisheries):
plot(1, type="n", main="Fit to catch data", xlab="Years", ylab ="Catch (tonnes)", xlim=(c(min(gmout$years),max(gmout$years)+1)), ylim=c(0,max(gmout$catch_biom_obs[3, ])), cex.main=1.2)
nfleet_ret <- 3
for(ifleet in nfleet_ret)
{
  abline(h=0)
  lines(gmout$years, gmout$catch_biom_obs[ifleet, ], type="p", pch=20, col=ifleet, cex=1.2)
  lines(gmout$years, gmout$catch_biom_pred[ifleet, ], type= "l", col=ifleet+2, lwd=2)
  legend("topright", legend=c("Observed","Predicted"), pch=20, col=c(ifleet,ifleet+2), bty="n")
}

# Plot fits to survey data:
plot(1, type="n", main="Fit to survey data", xlab="Years", ylab ="Survey Observation", xlim=(c(min(gmout$years),max(gmout$years)+1)), ylim=c(0,max(c(gmout$survey_num_pred[1, ],gmout$survey_num_obs[1, ]))), cex.main=1.2)

# Survey 1 (NMFS) 
nsurvey <- 1
for(isrv in 1:nsurvey)
{
  lines(gmout$yr_survey[isrv,], gmout$survey_num_obs[isrv, ], type="p", pch=20, col=isrv, cex=1.2)
  lines(gmout$yr_survey[isrv,], gmout$survey_num_pred[isrv, ], type= "l", col=isrv+2, lwd=2)
  legend("topright", legend=c("Observed","Predicted"), pch=20, col=c(isrv,isrv+2), bty='n')
}

# Survey 2 (BRSF)  
nsurvey <- 2
for(isrv in 1:nsurvey)
{
  lines(gmout$yr_survey[isrv,], gmout$survey_num_obs[isrv, ], type="p", pch=20, col=isrv, cex=1.2)
  lines(gmout$yr_survey[isrv,], gmout$survey_num_pred[isrv, ], type= "l", col=isrv+2, lwd=2)
  legend("topright", legend=c("Observed","Predicted"), pch=20, col=c(isrv,isrv+2), bty='n')
}

 
# Plot Selectivity      
plot(1:5,gmout$select_fish_2[43,2:6], type="b", main="Selectivity", xlab="Size bin", ylab ="selectivity" , pch=19,col="blue",cex.main=1.2)
for(i in 1:43)
{
#  lines(1:5, gmout$select_fish_2[i,2:6])
  lines(1:5, gmout$select_fish_1[i,2:6],col="salmon")
  lines(1:5, gmout$select_fish_3[i,2:6],col="grey")
}
# Plot Natural mortality
plot(gmout$years,gmout$M, type="b", main="Natural mortality", xlab="Years", ylab ="M", xlim=(c(min(gmout$years),max(gmout$years)+1)), ylim=c(0,max(gmout$M)), pch=19,col="blue",cex.main=1.2)

# Plot Recruitment
plot(gmout$years,gmout$recruits, type="b", main="Recruits", xlab="Years", ylab ="Recruits", xlim=(c(min(gmout$years),max(gmout$years)+1)), ylim=c(0,max(gmout$recruits)), pch=19,col="blue",cex.main=1.2)

# Plot Fishign mortality rate
plot(gmout$exp_rate_2[,1], gmout$exp_rate_2[,2], type="b", main="Exploitation rate", xlab="Years", ylab ="rate", xlim=(c(min(gmout$years),max(gmout$years)+1)), ylim=c(0,max(gmout$exp_rate_2[,2])), pch=19,col="red",cex.main=1.2)
#=========================================================================================================
# EOF

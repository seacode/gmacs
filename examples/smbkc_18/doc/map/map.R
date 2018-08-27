# ---------------------------------------------------------------------------- #
# Adding Bathymetry line to a map
# ---------------------------------------------------------------------------- #
library(marmap)
library(maptools)
library(leaflet)
#install.packages("leaflet.extras")
library(leaflet.extras)
library(tidyverse)
library(ggmap)
hnames
#w/o zeros

# m.df <- data.frame(read.csv("pos.csv",header=T,as.is=T)) %>% filter(SIZE_GROUP=="MALE_GE90")
#w/ zeros
setwd("map")
hnames <- read.csv("hdr.csv",header=T)
#m.df <- data.frame(read.csv("mge90_2017.csv",header=F,as.is=T)) 

getwd()
names(m.df) <- names(hnames)
str(m.df)
dim(m.df)
names(m.df)
unique(m.df$SIZE_GROUP)
summary(m.df$CRAB_NUM)
m.df <- data.frame(read.csv("male_ge90.csv",header=F,as.is=T)) 
p.df <- transmute(m.df,yr=as.numeric(SURVEY_YEAR), loc = STRATUM_NAME, lat= as.numeric(MID_LATITUDE), long=as.numeric(MID_LONGITUDE),CrabN=as.numeric(CRAB_NUM),cpueN=as.numeric(CRAB_CPUENUM),cpueKG=as.numeric(CRAB_CPUEWGT_MT)/1e3)
str(p.df)
max(p.df$yr)
# ---------------------------------------------------------------------------- #
# Step 1. Get Bathymetry data
# ---------------------------------------------------------------------------- #
# The marmap package is a good resource to get 1 minute data
# Use the getNOAA.bathy function with the coordinates & resolution.
# Bathymetry units are in meters (I'm assuming)
dat <- marmap::getNOAA.bathy(lon1 = -178, lon2 = -152,
                     lat1 = 54.0, lat2 = 59.0,
                     resolution = 1, keep = TRUE)

# Have a quick look
plot(dat,image=FALSE, bpal=NULL, land=FALSE,
     deepest.isobath=-300, shallowest.isobath=0, step=10,
     lwd=1, lty=1, col="black", default.col="white", drawlabels = FALSE,
     xlab="Longitude", ylab="Latitude", asp=1)
scaleBathy(dat, deg = 1.0, x = "bottomleft", inset = 5)

# ---------------------------------------------------------------------------- #
# Step 2. Extract the depth contours of interest
# ---------------------------------------------------------------------------- #
.M2FM  <- 0.546807  #Meter to fathoms conversion
.FM2M  <- 1.0/.M2FM

levels <- c(-50,-75,-100,-200,-500,-1000) #* .FM2M
levels <- seq(-10,-300,by=-10)
cls <- contourLines(y=as.numeric(colnames(dat)),x=as.numeric(rownames(dat)),dat,levels=levels)
                                #buoy,47.63028, -122.9446
spot <- read.csv(textConnection("loc,lat,long
                                buoy,57.62928, -172.9446 "))

names(p.df)
spot
#Next use maptools to convert to a shapefile
s <- ContourLines2SLDF(cls)


mytheme <- theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank(), panel.grid.major.y = element_line(colour="grey80", linetype="dashed"))
mytheme <- mytheme + theme(text=element_text(size=18)) + theme(axis.title.x=element_text(size=22) ,axis.title.y=element_text(size=22))
mytheme <- mytheme + theme(panel.background = element_rect(fill="white"), panel.border = element_rect(colour="black",fill=NA,size=1.0))
nByYear<- group_by(p.df,yr) %>% summarise(sum(CrabN))
(nByYear)

loc   <- c(-178.5, 57.5,-169.5,62)
akmap <- get_map(location=loc, source="google", maptype="satellite")
m.df <- filter(p.df,yr>=2010)
ggmap(akmap) +  mytheme + geom_text(aes(x= long, y=lat, label=as.character(CrabN)),size=3,col="yellow",data=m.df ) + facet_wrap( ~yr ) + ylab("Latitude") + xlab("Longitude")
ggsave("../../figure/CrabN_Station.png",dpi=300, width=8, height=8,units="in")
  
  
  #addPolygons(color = heat.colors(NLEV, NULL)[LEVS])
  #addProviderTiles("providers$CartoDB.Positron") %>% 
filter(p.df,yr==2016) %>% leaflet() %>% addProviderTiles("Esri.OceanBasemap", group = "Ocean Basemap") %>%
  addLabelOnlyMarkers(lng=~long,lat=~lat,label=~as.character(CrabN), labelOptions= labelOptions(noHide=T,direction="top",textOnly=T, textsize = "20px")) %>%
  #addCircles(lng=~long, lat=~lat,label=~loc,radius = ~sqrt(cpueN)*100,fill=FALSE, weight = 1) %>% 
  #addMarkers(lng=~long, lat=~lat,label=~loc,clusterOptions = markerClusterOptions()) %>% 
  addWebGLHeatmap(lng=~long, lat=~lat, intensity = ~cpueN) %>% 
addSimpleGraticule(interval = 1.0,showOriginLabel = TRUE,
                   redraw = "move", hidden = FALSE, zoomIntervals = list(),
                   layerId = NULL, group = NULL)
#%>% addPolylines(data=s, weight=0.5,color="grey")

# Getting started

#devtools::install_github("james-thorson/VAST") 
#devtools::install_github("james-thorson/utilities")
```
library(TMB)               # Can instead load library(TMBdebug)
library(VAST)

## Further information
## Related tools
## How to cite VAST
Data_Set = c("Chatham_rise_hake", "Iceland_cod", "WCGBTS_canary", "GSL_american_plaice", "BC_pacific_cod", "EBS_pollock", "GOA_Pcod", "GOA_pollock", "GB_spring_haddock", "GB_fall_haddock", "SAWC_jacopever", "Aleutian_islands_POP")[12]
Version = get_latest_version( package="VAST" )

## Spatial settings
The following settings define the spatial resolution for the model, and whether to use a grid or mesh approximation
Method = c("Grid", "Mesh", "Spherical_mesh")[2]
grid_size_km = 25
n_x = c(50, 250, 500, 1000, 2000)[1] # Number of stations

Kmeans_Config = list( "randomseed"=1, "nstart"=100, "iter.max"=1e3 )    
getwd()
```

## Model settings
FieldConfig = c("Omega1"=1, "Epsilon1"=1, "Omega2"=1, "Epsilon2"=1) 
RhoConfig = c("Beta1"=0, "Beta2"=0, "Epsilon1"=0, "Epsilon2"=0) 
OverdispersionConfig = c("Vessel"=0, "VesselYear"=0)
ObsModel = c(2,0)  

## Potential outputs The following settings define what types of output we want to calculate
Options =  c("SD_site_density"=0, "S_Dsite_logdensity"=0, "Calculate_Range"=1, "Calculate_evenness"=0, "Calculate_effective_area"=1, "Calculate_Cov_SE"=0, 'Calculate_Synchrony'=0, 'Calculate_Coherence'=0, 'normalize_GMRF_in_CPP'=TRUE)

## Stratification for results
# We also define any potential stratification of results, and settings specific to any case-study data set
# Default
  strata.limits <- data.frame('STRATA'="All_areas")
  # Override default settings for vessels
  VesselConfig = c("Vessel"=0, "VesselYear"=1)

## Save settings
  setwd("..")
DateFile = paste0(getwd(),'/VAST_output_wtge90/')
  dir.create(DateFile)

#I also like to save all settings for later reference, although this is not necessary.
Record = ThorsonUtilities::bundlelist( c("Data_Set","Version","Method","grid_size_km","n_x","FieldConfig","RhoConfig","OverdispersionConfig","ObsModel","Kmeans_Config") )
save( Record, file=file.path(DateFile,"Record.RData"))
capture.output( Record, file=paste0(DateFile,"Record.txt"))

# Prepare the data
## Data-frame for catch-rate data
m.df <- data.frame(read.csv("male_ge90.csv",header=F,as.is=T)) 
p.df <- transmute(m.df,yr=as.numeric(SURVEY_YEAR), loc = STRATUM_NAME, lat= as.numeric(MID_LATITUDE), long=as.numeric(MID_LONGITUDE),CrabN=as.numeric(CRAB_NUM),cpueN=as.numeric(CRAB_CPUENUM),cpueKG=as.numeric(CRAB_CPUEWGT_MT)/1e3)
#Depending upon the `Data_Set` chosen, we load archived data sets that are distributed with the package. Each archived data set is then reformatted to create a data-frame `Data_Geostat` with a standardized set of columns. For a new data set, the user is responsible for formatting `Data_Geostat` appropriately to match this format.  We show the first six rows of `Data_Geostat` given that Data_Set = `Data_Set`.  
  data( p.df, package="SpatialDeltaGLMM" )
 # Data_Geostat <- p.df %>% mutate( "Catch_NO"=cpueN, "Year"=yr, "Vessel"="missing", "AreaSwept_km2"=1, "Lat"=lat, "Lon"=long, "Pass"=0)
  Data_Geostat <- p.df %>% mutate( "Catch_KG"=cpueKG, "Year"=yr, "Vessel"="missing", "AreaSwept_km2"=1, "Lat"=lat, "Lon"=long, "Pass"=0)

## Extrapolation grid We also generate the extrapolation grid appropriate for a given region.  For new regions, we use `Region="Other"`.

posLL <- p.df %>% select(Lat=lat,Lon = long)
  Extrapolation_List = SpatialDeltaGLMM::Prepare_Extrapolation_Data_Fn( Region="Other", observations_LL = posLL ,strata.limits=strata.limits )
  Region <- "Other"
  Extrapolation_List = make_extrapolation_info( Region=Region, strata.limits=strata.limits, observations_LL=Data_Geostat[,c('Lat','Lon')], maximum_distance_from_sample=15 )
  max(p.df$yr)

## Derived objects for spatio-temporal estimation
#And we finally generate the information used for conducting spatio-temporal parameter estimation, bundled in list `Spatial_List`
#Spatial_List = SpatialDeltaGLMM::Spatial_Information_Fn( grid_size_km=grid_size_km, n_x=n_x, Method=Method, Lon=Data_Geostat[,'Lon'], Lat=Data_Geostat[,'Lat'], Extrapolation_List=Extrapolation_List, randomseed=Kmeans_Config[["randomseed"]], nstart=Kmeans_Config[["nstart"]], iter.max=Kmeans_Config[["iter.max"]], DirPath=DateFile, Save_Results=FALSE )
Spatial_List = make_spatial_info( grid_size_km=grid_size_km, n_x=n_x, Method=Method, Lon=Data_Geostat[,'Lon'], Lat=Data_Geostat[,'Lat'], Extrapolation_List=Extrapolation_List, randomseed=Kmeans_Config[["randomseed"]], nstart=Kmeans_Config[["nstart"]], iter.max=Kmeans_Config[["iter.max"]], DirPath=DateFile, Save_Results=FALSE )
# Add knots to Data_Geostat
Data_Geostat = cbind( Data_Geostat, "knot_i"=Spatial_List$knot_i )

# Build and run model
## Build model
#To estimate parameters, we first build a list of data-inputs used for parameter estimation.  `Data_Fn` has some simple checks for buggy inputs, but also please read the help file `?Data_Fn`.  
#TmbData = Data_Fn("Version"=Version, "FieldConfig"=FieldConfig, "OverdispersionConfig"=OverdispersionConfig, "RhoConfig"=RhoConfig, "ObsModel"=ObsModel, "c_i"=rep(0,nrow(Data_Geostat)), "b_i"=Data_Geostat[,'Catch_NO'], "a_i"=Data_Geostat[,'AreaSwept_km2'], "v_i"=as.numeric(Data_Geostat[,'Vessel'])-1, "s_i"=Data_Geostat[,'knot_i']-1, "t_i"=Data_Geostat[,'Year'], "a_xl"=Spatial_List$a_xl, "MeshList"=Spatial_List$MeshList, "GridList"=Spatial_List$GridList, "Method"=Spatial_List$Method, "Options"=Options )
TmbData = Data_Fn("Version"=Version, "FieldConfig"=FieldConfig, "OverdispersionConfig"=OverdispersionConfig, "RhoConfig"=RhoConfig, "ObsModel"=ObsModel, "c_i"=rep(0,nrow(Data_Geostat)), "b_i"=Data_Geostat[,'Catch_KG'], "a_i"=Data_Geostat[,'AreaSwept_km2'], "v_i"=as.numeric(Data_Geostat[,'Vessel'])-1, "s_i"=Data_Geostat[,'knot_i']-1, "t_i"=Data_Geostat[,'Year'], "a_xl"=Spatial_List$a_xl, "MeshList"=Spatial_List$MeshList, "GridList"=Spatial_List$GridList, "Method"=Spatial_List$Method, "Options"=Options )

#We then build the TMB object.
TmbList = Build_TMB_Fn("TmbData"=TmbData, "RunDir"=DateFile, "Version"=Version, "RhoConfig"=RhoConfig, "loc_x"=Spatial_List$loc_x, "Method"=Method)
Obj = TmbList[["Obj"]]

## Estimate fixed effects and predict random effects
#Next, we use a gradient-based nonlinear minimizer to identify maximum likelihood estimates for fixed-effects
#Opt = TMBhelper::Optimize( obj=Obj, lower=TmbList[["Lower"]], upper=TmbList[["Upper"]], getsd=TRUE, savedir=DateFile, bias.correct=FALSE )
 Opt = TMBhelper::Optimize( obj=Obj, lower=TmbList[["Lower"]], upper=TmbList[["Upper"]], getsd=TRUE, savedir=DateFile, bias.correct=TRUE, newtonsteps=1, bias.correct.control=list(sd=FALSE, split=NULL, nsplit=1, vars_to_correct="Index_cyl") )

#Finally, we bundle and save output
Report = Obj$report()
Save = list("Opt"=Opt, "Report"=Report, "ParHat"=Obj$env$parList(Opt$par), "TmbData"=TmbData)
save(Save, file=paste0(DateFile,"Save.RData"))

# Diagnostic plots
## Plot data
plot_data(Extrapolation_List=Extrapolation_List, Spatial_List=Spatial_List, Data_Geostat=Data_Geostat, PlotDir=DateFile )
pander::pandoc.table( Opt$diagnostics[,c('Param','Lower','MLE','Upper','final_gradient')] ) 
Enc_prob = plot_encounter_diagnostic( Report=Report, Data_Geostat=Data_Geostat, DirName=DateFile)
Q = plot_quantile_diagnostic( TmbData=TmbData, Report=Report, FileName_PP="Posterior_Predictive",
FileName_Phist="Posterior_Predictive-Histogram", 
FileName_QQ="Q-Q_plot", FileName_Qhist="Q-Q_hist", DateFile=DateFile )
MapDetails_List = make_map_info( "Region"=Region, "NN_Extrap"=Spatial_List$PolygonList$NN_Extrap, "Extrapolation_List"=Extrapolation_List )
# Decide which years to plot                                                   
Year_Set = seq(min(Data_Geostat[,'Year']),max(Data_Geostat[,'Year']))
Years2Include = which( Year_Set %in% sort(unique(Data_Geostat[,'Year'])))
plot_residuals(Lat_i=Data_Geostat[,'Lat'], Lon_i=Data_Geostat[,'Lon'], TmbData=TmbData, Report=Report, Q=Q, savedir=DateFile, MappingDetails=MapDetails_List[["MappingDetails"]], PlotDF=MapDetails_List[["PlotDF"]], MapSizeRatio=MapDetails_List[["MapSizeRatio"]], Xlim=MapDetails_List[["Xlim"]], Ylim=MapDetails_List[["Ylim"]], FileName=DateFile, Year_Set=Year_Set, Years2Include=Years2Include, Rotate=MapDetails_List[["Rotate"]], Cex=MapDetails_List[["Cex"]], Legend=MapDetails_List[["Legend"]], zone=MapDetails_List[["Zone"]], mar=c(0,0,2,0), oma=c(3.5,3.5,0,0), cex=1.8)
plot_anisotropy( FileName=paste0(DateFile,"Aniso.png"), Report=Report, TmbData=TmbData )
Dens_xt = plot_maps(plot_set=c(3), MappingDetails=MapDetails_List[["MappingDetails"]], Report=Report, Sdreport=Opt$SD, PlotDF=MapDetails_List[["PlotDF"]], MapSizeRatio=MapDetails_List[["MapSizeRatio"]], Xlim=MapDetails_List[["Xlim"]], Ylim=MapDetails_List[["Ylim"]], FileName=DateFile, Year_Set=Year_Set, Years2Include=Years2Include, Rotate=MapDetails_List[["Rotate"]], Cex=MapDetails_List[["Cex"]], Legend=MapDetails_List[["Legend"]], zone=MapDetails_List[["Zone"]], mar=c(0,0,2,0), oma=c(3.5,3.5,0,0), cex=1.8, plot_legend_fig=FALSE)
Dens_DF = cbind( "Density"=as.vector(Dens_xt), "Year"=Year_Set[col(Dens_xt)], "E_km"=Spatial_List$MeshList$loc_x[row(Dens_xt),'E_km'], "N_km"=Spatial_List$MeshList$loc_x[row(Dens_xt),'N_km'] )
Index = plot_biomass_index( DirName=DateFile, TmbData=TmbData, Sdreport=Opt[["SD"]], Year_Set=Year_Set, Years2Include=Years2Include, use_biascorr=TRUE )
pander::pandoc.table( Index$Table[,c("Year","Fleet","Estimate_metric_tons","SD_log","SD_mt")] ) 
plot_range_index(Report=Report, TmbData=TmbData, Sdreport=Opt[["SD"]], Znames=colnames(TmbData$Z_xm), PlotDir=DateFile, Year_Set=Year_Set)

## Convergence
#Here I print the diagnostics generated during parameter estimation, and I confirm that (1) no parameter is hitting an upper or lower bound and (2) the final gradient for each fixed-effect is close to zero. For explanation of parameters, please see `?Data_Fn`.
pander::pandoc.table( Opt$diagnostics[,c('Param','Lower','MLE','Upper','final_gradient')] ) 

## Diagnostics for encounter-probability component
# Next, we check whether observed encounter frequencies for either low or high probability samples are within the 95% predictive interval for predicted encounter probability
Enc_prob = SpatialDeltaGLMM::Check_encounter_prob( Report=Report, Data_Geostat=Data_Geostat, DirName=DateFile)

## Diagnostics for positive-catch-rate component
#We can visualize fit to residuals of catch-rates given encounters using a Q-Q plot.  A good Q-Q plot will have residuals along the one-to-one line.  
Q = SpatialDeltaGLMM::QQ_Fn( TmbData=TmbData, Report=Report, FileName_PP=paste0(DateFile,"Posterior_Predictive.jpg"), FileName_Phist=paste0(DateFile,"Posterior_Predictive-Histogram.jpg"), FileName_QQ=paste0(DateFile,"Q-Q_plot.jpg"), FileName_Qhist=paste0(DateFile,"Q-Q_hist.jpg")) # SpatialDeltaGLMM::
```
![Quantile-quantile plot indicating residuals for "positive catch rate" component](VAST_output/Q-Q_plot.jpg) 

## Diagnostics for plotting residuals on a map

# Get region-specific settings for plots
Region="Eastern_Bering_Sea"
MapDetails_List = SpatialDeltaGLMM::MapDetails_Fn( "Region"="Other", "NN_Extrap"=Spatial_List$PolygonList$NN_Extrap, "Extrapolation_List"=Extrapolation_List )
# Decide which years to plot                                                   
Year_Set = seq(min(Data_Geostat[,'Year']),max(Data_Geostat[,'Year']))
Years2Include = which( Year_Set %in% sort(unique(Data_Geostat[,'Year'])))

#We then plot Pearson residuals.  If there are visible patterns (areas with consistently positive or negative residuals accross or within years) then this is an indication of the model "overshrinking" results towards the intercept, and model results should then be treated with caution.  
SpatialDeltaGLMM:::plot_residuals(Lat_i=Data_Geostat[,'Lat'], Lon_i=Data_Geostat[,'Lon'], TmbData=TmbData, Report=Report, Q=Q, savedir=DateFile, MappingDetails=MapDetails_List[["MappingDetails"]], PlotDF=MapDetails_List[["PlotDF"]], MapSizeRatio=MapDetails_List[["MapSizeRatio"]], Xlim=MapDetails_List[["Xlim"]], Ylim=MapDetails_List[["Ylim"]], FileName=DateFile, Year_Set=Year_Set, Years2Include=Years2Include, Rotate=MapDetails_List[["Rotate"]], Cex=MapDetails_List[["Cex"]], Legend=MapDetails_List[["Legend"]], zone=MapDetails_List[["Zone"]], mar=c(0,0,2,0), oma=c(3.5,3.5,0,0), cex=1.8)
## Model selection
#To select among models, we recommend using the Akaike Information Criterion, AIC, via `Opt$AIC=` ``r Opt$AIC``. 

# Model output

Last but not least, we generate pre-defined plots for visualizing results
## Direction of "geometric anisotropy"
#We can visualize which direction has faster or slower decorrelation (termed "geometric anisotropy")
SpatialDeltaGLMM::PlotAniso_Fn( FileName=paste0(DateFile,"Aniso.png"), Report=Report, TmbData=TmbData )

## Density surface for each year

#We can visualize many types of output from the model.  Here I only show
#predicted density, but other options are obtained via other integers passed
#to `plot_set` as described in `
?PlotResultsOnMap_Fn


SpatialDeltaGLMM::PlotResultsOnMap_Fn(plot_set=c(3), MappingDetails=MapDetails_List[["MappingDetails"]], Report=Report, Sdreport=Opt$SD, PlotDF=MapDetails_List[["PlotDF"]], MapSizeRatio=MapDetails_List[["MapSizeRatio"]], Xlim=MapDetails_List[["Xlim"]], Ylim=MapDetails_List[["Ylim"]], FileName=DateFile, Year_Set=Year_Set, Years2Include=Years2Include, Rotate=MapDetails_List[["Rotate"]], Cex=MapDetails_List[["Cex"]], Legend=MapDetails_List[["Legend"]], zone=MapDetails_List[["Zone"]], mar=c(0,0,2,0), oma=c(3.5,3.5,0,0), cex=1.8, plot_legend_fig=FALSE)
SpatialDeltaGLMM::PlotResultsOnMap_Fn(plot_set=c(3), MappingDetails=MapDetails_List[["MappingDetails"]], Report=Report, Sdreport=Opt$SD, PlotDF=MapDetails_List[["PlotDF"]], MapSizeRatio=MapDetails_List[["MapSizeRatio"]], Xlim=MapDetails_List[["Xlim"]], Ylim=MapDetails_List[["Ylim"]], FileName=DateFile, Year_Set=Year_Set, Years2Include=Years2Include, Rotate=MapDetails_List[["Rotate"]], Cex=MapDetails_List[["Cex"]], Legend=MapDetails_List[["Legend"]], zone=MapDetails_List[["Zone"]], mar=c(0,0,2,0), oma=c(3.5,3.5,0,0), cex=1.8, plot_legend_fig=FALSE,Res=300)

## Index of abundance
#The index of abundance is generally most useful for stock assessment models.
Year_Set
Years2Include
<-1:length(Year_Set)
Opt[["SD"]]
 Index = SpatialDeltaGLMM::PlotIndex_Fn( DirName=DateFile, TmbData=TmbData, Sdreport=Opt[["SD"]], Year_Set=Year_Set, Years2Include=Years2Include, use_biascorr=TRUE )
pander::pandoc.table( Index$Table[,c("Year","Fleet","Estimate_metric_tons","SD_log","SD_mt")] ) 
pander::pandoc.table( Index$Table[,c("Year","Fleet","Estimate_metric_tons","SD_log","SD_mt")] ) 
![Index of abundance plus/minus 1 standard error](VAST_output/Index.png) 

## Center of gravity and range expansion/contraction

We can detect shifts in distribution or range expansion/contraction.  
SpatialDeltaGLMM::Plot_range_shifts(Report=Report, TmbData=TmbData, Sdreport=Opt[["SD"]], Znames=colnames(TmbData$Z_xm), PlotDir=DateFile, Year_Set=Year_Set)
```
![Center of gravity (COG) indicating shifts in distribution plus/minus 1 standard error](VAST_output/center_of_gravity.png) 

![Effective area occupied indicating range expansion/contraction plus/minus 1 standard error](VAST_output/Effective_Area.png) 



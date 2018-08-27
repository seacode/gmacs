R
# Getting started

#devtools::install_github("james-thorson/VAST") 
#devtools::install_github("james-thorson/utilities")
```
library(TMB)               # Can instead load library(TMBdebug)
library(VAST)
library(dplyr)

## Further information
## Related tools
## How to cite VAST
Data_Set = c("Chatham_rise_hake", "Iceland_cod", "WCGBTS_canary", "GSL_american_plaice", "BC_pacific_cod", "EBS_pollock", "GOA_Pcod", "GOA_pollock", "GB_spring_haddock", "GB_fall_haddock", "SAWC_jacopever", "Aleutian_islands_POP")[12]
Version = get_latest_version( package="VAST" )

## Spatial settings
#The following settings define the spatial resolution for the model, and whether to use a grid or mesh approximation
Method = c("Grid", "Mesh", "Spherical_mesh")[2]
grid_size_km = 25
n_x = c(50, 250, 500, 1000, 2000)[1] # Number of stations

Kmeans_Config = list( "randomseed"=1, "nstart"=100, "iter.max"=1e3 )    

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
DateFile = paste0(getwd(),'/VAST_output_wtge90/')
  dir.create(DateFile)

#I also like to save all settings for later reference, although this is not necessary.
Record = ThorsonUtilities::bundlelist( c("Data_Set","Version","Method","grid_size_km","n_x","FieldConfig","RhoConfig","OverdispersionConfig","ObsModel","Kmeans_Config") )
save( Record, file=file.path(DateFile,"Record.RData"))
capture.output( Record, file=paste0(DateFile,"Record.txt"))

# Prepare the data
## Data-frame for catch-rate data
m.df <- data.frame(read.csv("male_ge90.csv",header=T,as.is=T)) 
p.df <- transmute(m.df,yr=as.numeric(SURVEY_YEAR), loc = STRATUM_NAME, lat= as.numeric(MID_LATITUDE), long=as.numeric(MID_LONGITUDE),CrabN=as.numeric(CRAB_NUM),cpueN=as.numeric(CRAB_CPUENUM),cpueKG=as.numeric(CRAB_CPUEWGT_MT))
 # Data_Geostat <- p.df %>% mutate( "Catch_NO"=cpueN, "Year"=yr, "Vessel"="missing", "AreaSwept_km2"=1, "Lat"=lat, "Lon"=long, "Pass"=0)
  Data_Geostat <- p.df %>% mutate( "Catch_KG"=cpueKG, "Year"=yr, "Vessel"="missing", "AreaSwept_km2"=1, "Lat"=lat, "Lon"=long, "Pass"=0)

## Extrapolation grid We also generate the extrapolation grid appropriate for a given region.  For new regions, we use `Region="Other"`.
  posLL <- p.df %>% select(Lat=lat,Lon = long)
  Extrapolation_List = SpatialDeltaGLMM::Prepare_Extrapolation_Data_Fn( Region="Other", observations_LL = posLL ,strata.limits=strata.limits )
  Region <- "Other"
  Extrapolation_List = make_extrapolation_info( Region=Region, strata.limits=strata.limits, observations_LL=Data_Geostat[,c('Lat','Lon')], maximum_distance_from_sample=15 )

## Derived objects for spatio-temporal estimation
#And we finally generate the information used for conducting spatio-temporal parameter estimation, bundled in list `Spatial_List`
#Spatial_List = SpatialDeltaGLMM::Spatial_Information_Fn( grid_size_km=grid_size_km, n_x=n_x, Method=Method, Lon=Data_Geostat[,'Lon'], Lat=Data_Geostat[,'Lat'], Extrapolation_List=Extrapolation_List, randomseed=Kmeans_Config[["randomseed"]], nstart=Kmeans_Config[["nstart"]], iter.max=Kmeans_Config[["iter.max"]], DirPath=DateFile, Save_Results=FALSE )
Spatial_List = make_spatial_info( grid_size_km=grid_size_km, n_x=n_x, Method=Method, Lon=Data_Geostat[,'Lon'], Lat=Data_Geostat[,'Lat'], Extrapolation_List=Extrapolation_List, randomseed=Kmeans_Config[["randomseed"]], nstart=Kmeans_Config[["nstart"]], iter.max=Kmeans_Config[["iter.max"]], DirPath=DateFile, Save_Results=FALSE )
# Add knots to Data_Geostat
Data_Geostat = cbind( Data_Geostat, "Vessel"="missing", "knot_i"=Spatial_List$knot_i )
OverdispersionConfig = c("Vessel"=0, "VesselYear"=0)
# Build and run model
## Build model
#To estimate parameters, we first build a list of data-inputs used for parameter estimation.  `Data_Fn` has some simple checks for buggy inputs, but also please read the help file `?Data_Fn`.  
TmbData = Data_Fn("Version"=Version, "FieldConfig"=FieldConfig, "OverdispersionConfig"=OverdispersionConfig, "RhoConfig"=RhoConfig, "ObsModel"=ObsModel, "c_i"=rep(0,nrow(Data_Geostat)), "b_i"=Data_Geostat[,'Catch_KG'], "a_i"=Data_Geostat[,'AreaSwept_km2'], "s_i"=Data_Geostat[,'knot_i']-1, "t_i"=Data_Geostat[,'Year'], "a_xl"=Spatial_List$a_xl, "MeshList"=Spatial_List$MeshList, "GridList"=Spatial_List$GridList, "Method"=Spatial_List$Method, "Options"=Options )

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

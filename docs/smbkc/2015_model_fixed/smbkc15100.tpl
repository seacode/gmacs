// Basic three-stage catch-survey-analysis (CSA) model for
// St Matthew Island blue king crab

// Constructed by Bill Gaeuman Spring 2012
// Revised Aug-Sept 2013 for Fall 2013 Assessment

// Data: all with respect to male >=90mm CL and 3 model stages
//  1a) trawl survey composition and total abundance + CV; OR
//  1b) trawl survey composition and total biomass + CV;
//  2) pot survey composition and CPUE*1000 (catch per 1000 pots) + CV;
//  3) fishery retained catch number;
//  4) crab observer composition data from observed count proportions;
//  5) groundfish trawl and fixed-gear bycatch biomass data;

// Trawl-survey assumed to occur July 1 = start of crab year
// Directed fishery assumed to occur as pulse at midpoint of season.
// Groundfish fishery assumed to occur as a Feb 15 pulse.
// Abundances in 1000s of crab.
// Biomasses in 1000s of pounds.
// Effort in 1000s of pot lifts (not used).

//*******************************
// Model T
//*******************************

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

DATA_SECTION

 init_int start_yr			// Beginning year, e.g. 1978
 init_int nyrs 				// Model time frame in years, e.g. 35 [years through last trawl survey]
 init_vector wt(1,3)			// Stage mean weights for necessary biomass computations (yearly DF value for stage 3)
 init_number rret    //geomean ratio of retained mean weight to legal mean weight
 init_vector hm(1,3)			// Directed and groundfish fixed-gear and trawl fishery handling mortalities

 init_int nyrs_ts			// Number of years of trawl survey data
 init_ivector yid_ts(1,nyrs_ts)		// Trawl survey data year indices
 init_matrix ts_data(1,nyrs_ts,1,8)	// Sample size, stage abundance indices, total abundance, CV, model biomass, CV

 init_int nyrs_ps			// Number of years of pot survey data
 init_ivector yid_ps(1,nyrs_ps)		// Pot survey data year indices
 init_matrix ps_data(1,nyrs_ps,1,6)	// Sample size, stage abundance indices, total abundance, CV

 init_int nyrs_pf			// Number of years of directed pot fishery data (other than zero catch)
 init_ivector yid_pf(1,nyrs_pf)		// Fishery data year indices
 init_matrix pf_data(1,nyrs_pf,1,4)	// Catch number, time to midpoint of fishery, effort (not used), catch weight

 init_int nyrs_ob			// Number of years of observer data
 init_ivector yid_ob(1,nyrs_ob)		// Observer data year indices
 init_matrix ob_data(1,nyrs_ob,1,3)	// Observed stage counts, discout bio, and legal discard rate
 init_vector x_ob(1,nyrs_ob)
 init_vector dstr0(1,nyrs_ob)

 init_int nyrs_gf			// Number of years of groundfish bycatch biomass data
 !! cout<<"nyrs_gf "<<nyrs_gf<<endl;
 init_vector yid_gf(1,nyrs_gf)	        // Groundfish data year indices
 init_matrix gf_data(1,nyrs_gf,1,2)	// Trawl and fixed-gear male bycatch biomass [NOT mortality]
 //----------------------------------

 //Error trap to ensure data properly digested
 init_int eof;
 !! if(eof != 999){cout<<"DATA READING ERROR"<<endl; exit(1);};
 //----------------------------------

 ivector yrs(1,nyrs)			// Model years, e.g. 1978, 1979,..., 2012

 vector n_ts(1,nyrs_ts)			// Survey and observer data sample sizes [number of male crab >= 90mm CL]
 vector n_ps(1,nyrs_ps)
 vector n_ob(1,nyrs_ob)

 vector x_ts(1,nyrs_ts)			// Survey estimated total abundances/biomass,ret catch number/biomass & pot discard biomass
 vector x_ps(1,nyrs_ps)			
 vector x_ret(1,nyrs_pf)
 vector x_ret_b(1,nyrs_pf)
 vector x_ob1(1,9)
 vector x_ob2(10,nyrs_ob)

 vector b_ts(1,nyrs_ts)			// Trawl survey model biomass and CV
 vector cv_ts_b(1,nyrs_ts)

 vector eff(1,nyrs_pf)			// Directed fishery effort
 vector lag_pf(1,nyrs)			// Time to pot fishery [= zero if no fishery]
 !!lag_pf.initialize();
 vector ret_wt(1,nyrs)			// Retained catch weight [considered known; =0 if no fishery]
 !!ret_wt.initialize();
 vector avg_ret_wt(1,nyrs);		// Avg retained weight for biomass computations [obvious quotients or their average]
 vector dstr(1,nyrs)     //legal discard rates
 !!dstr.initialize();

 vector cv_ts(1,nyrs_ts)		// Survey estimated CVs
 vector cv_ps(1,nyrs_ps)

 matrix p_ts(1,nyrs_ts,1,3) // Survey and fishery (from observer data) stage proportions
 matrix p_ps(1,nyrs_ps,1,3)
 matrix p_ob(1,nyrs_ob,1,3)

 vector gft_mort(1,nyrs_gf)		// Groundfish bycatch mortality (from NMFS groundfish obs data)
 vector gff_mort(1,nyrs_gf)

 // Between-year relative variances for ts and ps abundance and ts biomass likelihood components
 vector sig_ts(1,nyrs_ts);
 vector sig_ps(1,nyrs_ps);
 vector sig_ts_b(1,nyrs_ts);

 // Effective sample sizes for composition data
 vector effn_ts(1,nyrs_ts);
 vector effn_ps(1,nyrs_ps);
 vector effn_ob(1,nyrs_ob);

 !! ad_comm::change_datafile_name("smbkc151.ctl");
 // Phases
 init_int ph_M
 init_int ph_M98
 init_int ph_Qts
 init_int ph_Qps
 init_int ph_logN1o
 init_int ph_logN2o
 init_int ph_logN3o
 init_int ph_logit_p12
 init_int ph_logit_p23
 init_int ph_s_ts
 init_int ph_s_ps
 init_int ph_s_pf
 init_int ph_mean_log_Fpf
 init_int ph_log_Fpf_dev
 init_int ph_mean_log_New
 init_int ph_log_New_dev

 // Objective function likelihood and penalty weights
 init_vector Lw(1,10)
 init_vector Pw(1,4)

 // Starting values
 init_number M_start
 init_number M98_start
 init_number Qts_start
 init_number Qps_start
 init_number logN1o_start
 init_number logN2o_start
 init_number logN3o_start
 init_number logit_p12_start
 init_number logit_p23_start
 init_number s_ts_start
 init_number s_ps_start
 init_number s_pf_start
 init_number mean_log_Fpf_start
 init_number mean_log_New_start

 // Max effective sample sizes for compostion data
 init_number Nmax_ts
 init_number Nmax_ps
 init_number Nmax_ob1
 init_number Nmax_ob
 !! cout<<"Nmax_ob "<<Nmax_ob<<endl;

 //Error trap to ensure all data have been read
 init_int eof_ctl;
 !! if(eof_ctl != 999){cout<<"CTL DATA READING ERROR"<<endl; exit(1);};
//____________________________________________________________________________


PARAMETER_SECTION

 // Natural mortality
 init_number M(ph_M)		
 init_number M98(ph_M98)

 // M deviations for years other than terminal year (stop estimation of M98 when using this)
 init_bounded_dev_vector log_M_dev(1,nyrs-1,-2,2,-1)

 // Trawl survey "catchability"
 init_number Qts(ph_Qts)

  // Pot survey proportionality constant
 init_bounded_number Qps(1.0,7.0,ph_Qps)

 // Trawl-survey stage 1 and 2 selectivies (or 1 and 3; or 1 and 2-and-3),
 // relative to Qts
 init_bounded_vector s_ts(1,2,0.01,2.0,ph_s_ts)

 // Pot-survey stage 1 and 2 selectivities
 init_bounded_vector s_ps(1,2,0.01,2.0,ph_s_ps)

 // Pot_fishery stage 1 and 2 slectivities for two periods
 init_bounded_vector s_pf1(1,2,0.01,2.0,ph_s_pf)
 init_bounded_vector s_pf2(1,2,0.01,2.0,ph_s_pf)

 // Log initial stage abundances
 init_bounded_number logN1o(5.0,10.0,ph_logN1o)			
 init_bounded_number logN2o(5.0,10.0,ph_logN2o)
 init_bounded_number logN3o(5.0,10.0,ph_logN3o)

 // Logit p12 and p23 transition probabilities
 init_number logit_p12(ph_logit_p12)			
 init_number logit_p23(ph_logit_p23)

 // Mean log fishing mortality and deviations
 init_bounded_number mean_log_Fpf(-3.0,0.0,ph_mean_log_Fpf)		
 init_bounded_dev_vector log_Fpf_dev(1,nyrs_pf,-10.0,10.0,ph_log_Fpf_dev)	

 // Mean log recruitment and deviations
 init_bounded_number mean_log_New(5.0,10.0,ph_mean_log_New)				
 init_bounded_dev_vector log_New_dev(2,nyrs,-5.0,3.0,ph_log_New_dev)

 // Mean log groundfish fishing mortalities and deviations
 init_bounded_number mean_log_Fgft(-12.0,-4.0,4)
 init_bounded_number mean_log_Fgff(-12.0,-4.0,4)
 init_bounded_dev_vector log_Fgft_dev(1,nyrs_gf,-6.0,6.0,5)
 init_bounded_dev_vector log_Fgff_dev(1,nyrs_gf,-6.0,6.0,5)
 //----------------------------------------------------------------

 // Yearly natural mortality [= M98 in year 21 and otherwise = M]
 vector MM(1,nyrs)

 // Row-stage-to-column-stage transition matrix (molting + growth)
 matrix TM(1,3,1,3)

 // Fishing mortalitites [= 0 in years with no fishery]
 vector Fpf(1,nyrs)
 !! Fpf.initialize();

 // Groundfish fishing mortalities [= geometric mean in years with no data]
 vector Fgft(1,nyrs);
 vector Fgff(1,nyrs);

 // Model recruitment [note: New(t) contributes to N1(t)]
 vector New(2,nyrs)

 // Yearly stage abundances at beginning of year [survey time]
 matrix N(1,nyrs,1,3)	

 // Model predicted fishery stage removal (mortality) numbers [= 0 in years with no fishery]
 matrix R_pf(1,nyrs,1,3)
 !! R_pf.initialize();
// vector Ret_b(1,nyrs)

 // Model predicted groundfish bycatch removal (mortality) numbers and biomasses
 matrix R_gft(1,nyrs,1,3)
 matrix R_gff(1,nyrs,1,3)
 vector B_gft(1,nyrs)	// Only years nyrs_gf used in likelihood; based on mean_log_Fgf otherwise
 vector B_gff(1,nyrs)

 // Directed fishery discard mortality [= 0 in years with no fishery; function of df fishing mort otherwise]
 vector Dis_mort(1,nyrs);
 !! Dis_mort.initialize();

 // Model predicted abundance indices and ret catch
 vector X_ts(1,nyrs_ts)
 vector X_ps(1,nyrs_ps)
 vector X_ret(1,nyrs_pf)
 vector X_ret_b(1,nyrs_pf)
 vector X_ob(1,nyrs_ob)
 vector X_ob1(1,9)
 vector X_ob2(10,nyrs_ob)
 matrix s_pf(1,2,1,nyrs)

 // Model predicted survey biomass
 vector B_ts(1,nyrs_ts)

 // Model predicted composition measures
 matrix P_ts(1,nyrs_ts,1,3)
 matrix P_ps(1,nyrs_ps,1,3)
 matrix P_ob(1,nyrs_ob,1,3)
 matrix Like_ts(1,nyrs_ts,1,3)
 matrix Like_ps(1,nyrs_ps,1,3)
 matrix Like_ob(1,nyrs_ob,1,3)
 number t1
 number t0


 // Model predicted Feb 15 mature male biomass [assumes no fishing in assessment projection year]
 vector MMB215(1,nyrs)

 objective_function_value f

 // Components of objective function for model diagnostics
 vector LogLike(1,10)
 vector Pen(1,4)

 //Federal management quantities
 number FF // Working variable for OFL computations
 number Bmsy // Calculated as average MMB215 over reference period
 number Fmsy // Constant = M
 number FOFL
 number OFL //Total male catch OFL is sum of four following components
 number Bret_proj
 number Bdis_proj
 number Bgft_proj
 number Bgff_proj
 number mmb215_proj // Assessment year projected mmb215 and catches given FF (and ultimately Fofl)
 sdreport_number logOFL

 number SBPR // Equilibrium spawning biomass per 1000 recruits given directed fishing mortality FF
 number F35
 number Bmsy35

 //State management quantities
 sdreport_number LMA
 sdreport_number LMB
 sdreport_number MMA
 sdreport_number MMB
 sdreport_number S2A
//_____________________________________________________________________

INITIALIZATION_SECTION
 M M_start
 M98 M98_start
 Qts Qts_start
 Qps Qps_start
 logN1o logN1o_start
 logN2o logN2o_start
 logN3o logN3o_start
 logit_p12 logit_p12_start
 logit_p23 logit_p23_start
 s_ts s_ts_start
 s_ps s_ps_start
 s_pf1 s_pf_start
 s_pf2 s_pf_start
 mean_log_Fpf mean_log_New_start
 mean_log_New mean_log_New_start
//______________________________________________________________________

PRELIMINARY_CALCS_SECTION
 int k;

 // Vector of years
 yrs.fill_seqadd(start_yr,1);

 //Extract data
 // Trawl Survey Data
 n_ts=column(ts_data,1);
 x_ts=column(ts_data,5);
 cv_ts=column(ts_data,6);
 for(k=1;k<=nyrs_ts;k++)
   p_ts(k)=--ts_data(k)(2,4)/sum(ts_data(k)(2,4));
 b_ts=column(ts_data,7);
 cv_ts_b=column(ts_data,8);

 // Pot Survey Data
 n_ps=column(ps_data,1);
 x_ps=column(ps_data,5);
 cv_ps=column(ps_data,6);
 for(k=1;k<=nyrs_ps;k++)
   p_ps(k)=--ps_data(k)(2,4)/sum(ps_data(k)(2,4));

 // Pot Fishery Data
 x_ret = column(pf_data,1);
 x_ret_b = column(pf_data,4);
 eff = column(pf_data,3);		
 for(k=1;k<=nyrs_pf;k++)
 {
   lag_pf(yid_pf(k)) = pf_data(k,2); 	// = 0 in years with no fishery
   ret_wt(yid_pf(k)) = pf_data(k,4);     // = 0 in years with no fishery
 }

 // Observer Data
//  cout<<"1a "<<endl;
 n_ob=rowsum(ob_data);
 for(k=1;k<=nyrs_ob;k++) p_ob(k)=ob_data(k)/n_ob(k);
 for(k=1;k<=nyrs_ob;k++) dstr(yid_ob(k))= dstr0(k);
 x_ob = x_ob*hm(1);
 for(k=1;k<=9;k++) x_ob1(k) = x_ob(k);
 for(k=10;k<=nyrs_ob;k++) x_ob2(k) = x_ob(k);

//  cout<<"1c "<<endl;


 // Avg retained weights for biomass computations [=obvious quotients or their average]
 avg_ret_wt = sum(elem_div(ret_wt(yid_pf),x_ret))/double(nyrs_pf)/rret;    //adjust from retained weight to legal weight with rret
 for(k=1;k<=nyrs_pf;k++)
   avg_ret_wt(yid_pf(k)) = ret_wt(yid_pf(k))/x_ret(k)/rret;

 // Groundfish bycatch mortality after adjusting for handling mortalities [= geometric mean in years with no data]
 gft_mort = column(gf_data,1)*hm(3);
 gff_mort = column(gf_data,2)*hm(2);

 // Between-year relative variances for ts and ps abundance likelihood components
 sig_ts = sqrt( log(square(cv_ts) + 1.0) );
 sig_ps = sqrt( log(square(cv_ps) + 1.0) );
 sig_ts_b = sqrt( log(square(cv_ts_b) + 1.0) );
 Lw(1) = 1.0/log(Lw(1)*Lw(1)+1.0);
 Lw(7) = 1.0/log(Lw(7)*Lw(7)+1.0);
 Lw(8) = 1.0/log(Lw(8)*Lw(8)+1.0);
 Lw(9) = 1.0/log(Lw(9)*Lw(9)+1.0);
 Lw(10) = 1.0/log(Lw(10)*Lw(10)+1.0);

 // Effective sample sizes for composition data
 for(k=1;k<=nyrs_ts;k++)
 //effn_ts(k)=min(Nmax_ts,0.5*n_ts(k))*min(1.0,0.3/ts_data(k,8));
    effn_ts(k)=min(Nmax_ts,0.5*n_ts(k));
   //effn_ts(k) = mfexp(.5*log(n_ts(k)));
 for(k=1;k<=nyrs_ps;k++)
  // effn_ps(k)= min(Nmax_ps,0.5*n_ps(k))*min(1.0,0.13/ps_data(k,6));
    effn_ps(k)= min(Nmax_ps,0.5*n_ps(k));
   //effn_ps(k) = mfexp(.5*log(n_ps(k)));
 for(k=1;k<=nyrs_ob;k++)
 {
    if (k<10) effn_ob(k)=min(Nmax_ob1,0.1*n_ob(k));
    else effn_ob(k)=min(Nmax_ob,0.1*n_ob(k));
  }
   //effn_ob(k) = mfexp(.5*log(n_ob(k)));
//________________________________________________________________________	
 	
PROCEDURE_SECTION
//  cout<<"1 "<<endl;
 get_numbers();
//  cout<<"2 "<<endl;
 run_pop_dynamics();
//  cout<<"3 "<<endl;
 predict_data();
//  cout<<"4 "<<endl;
 calculate_obj_function();
//  cout<<"5 "<<endl;

 // Tier 4 stuff
   Bmsy = sum(MMB215(1,nyrs-1))/(nyrs-1);
   //Bmsy=;
   Fmsy = M;
   //Fmsy=;
   get_FOFL();
   OFL = Bret_proj + Bdis_proj + Bgff_proj + Bgft_proj;
   logOFL = log(OFL);

 // State quantitites
   LMA = N(nyrs)(3); LMB = N(nyrs)(3)*avg_ret_wt(nyrs);
   MMA = N(nyrs)(2) + N(nyrs)(3); MMB = N(nyrs)(2)*wt(2)+N(nyrs)(3)*avg_ret_wt(nyrs);
   S2A = N(nyrs)(2);
//________________________________________________________________________
FUNCTION get_numbers
 int j;

 // Natural mortality for years 1 to nyrs
 // (Adjust this section for base-model vs model C. Need also to include M deviations
 // penalty in objective function for model C.)

 MM = M; MM(21) = M98;
 //for(j=1;j<nyrs;j++){

 //MM(j) = M*mfexp(log_M_dev(j));

 //if(j<21) MM(j) = M*mfexp(log_M_dev(j));
 //if(j==21) MM(j) = M98;
 //if(j>21) MM(j) = M*mfexp(log_M_dev(j-1));
 //}

 //MM(nyrs)=M;

 //Transition matrix depends on 2 parameters logit_p12, logit_p23
 dvariable p12, p23;
 //p12 = 1.0/( 1.0+mfexp(-logit_p12) );
 //p23 = 1.0/( 1.0+mfexp(-logit_p23) );

 // Alternative TM (loosely) based on Otto and Cummiskey (1990)
 TM(1,1)=0.2;	    TM(1,2)=0.7;     TM(1,3)=0.1;
 TM(2,1)=0.0;     TM(2,2)=0.4;     TM(2,3)=0.6;
 TM(3,1)=0.0;     TM(3,2)=0.0;     TM(3,3)=1.0;

 // Directed fishing mortalities [= 0 in years with no fishery]
 for(j=1;j<=nyrs_pf;j++)
   Fpf(yid_pf(j)) = mfexp(mean_log_Fpf+log_Fpf_dev(j));

 // Estimated model recruitment [New(t) contributes to (and is, if p12=1) N(t,1)]
 for(j=2;j<=nyrs;j++)
   New(j) = mfexp(mean_log_New+log_New_dev(j));

 // Initial stage abundances
 N(1,1)=mfexp(logN1o); N(1,2)=mfexp(logN2o); N(1,3)=mfexp(logN3o);

// Ret_b = elem_prod(elem_div(elem_prod(column(R_pf,3),1.0-dstr),(1.0-dstr+dstr*hm(1))),avg_ret_wt*rret);

 // Groundfish killing constants same for all stages [= geometric mean in years with no data]
 Fgft = exp(mean_log_Fgft);
 Fgff = exp(mean_log_Fgff);
 for(j=1;j<=nyrs_gf;j++)
 {
   Fgft(yid_gf(j)) = mfexp(mean_log_Fgft + log_Fgft_dev(j));
   Fgff(yid_gf(j)) = mfexp(mean_log_Fgff + log_Fgff_dev(j));
 }

//________________________________________________________________________

FUNCTION run_pop_dynamics
 int t;
 dvar_vector NN(1,3);
 dvariable S,D;

 s_pf(1) = s_pf1(1); s_pf(2) = s_pf1(2);
 for(t=29;t<=nyrs;t++)
 {
   s_pf(1,t) = s_pf2(1); s_pf(2,t) = s_pf2(2);
 }

 for(t=1;t<=nyrs;t++)
 {
   // Survival to directed pot fishery, df full-selection exploitation rate
   S=mfexp(-lag_pf(t)*MM(t));
   D=(1.0-mfexp(-Fpf(t)));

   // Calculate fishery removals
   R_pf(t,1)=N(t,1)*S*D*s_pf(1,t)*hm(1);
   R_pf(t,2)=N(t,2)*S*D*s_pf(2,t)*hm(1);
   R_pf(t,3)=N(t,3)*S*D*((1.0-dstr(t))+dstr(t)*hm(1));             //Adjust for legal discard

   // Take out fishery removals and discount to Feb 15
   NN = (N(t)*S-R_pf(t))*mfexp(-(0.63-lag_pf(t))*MM(t));

   // Calculate and take out groundfish removals wrt Feb 15 a la Baranof
   R_gft(t) = Fgft(t)/(Fgft(t)+Fgff(t))*NN*(1.0-mfexp(-(Fgft(t)+Fgff(t))));
   R_gff(t) = Fgff(t)/(Fgft(t)+Fgff(t))*NN*(1.0-mfexp(-(Fgft(t)+Fgff(t))));
   NN = NN-R_gft(t)-R_gff(t);

   // Calculate Feb 15 mature male biomass
   MMB215(t) = NN(2)*wt(2)+NN(3)*avg_ret_wt(t);

   // Discount who's left to end of year
   NN = NN*mfexp(-(0.37*MM(t)));

   // Calculate next year's abundances only thru assessment year t+1 = nyrs
   if(t<nyrs)
   {
     N(t+1,1)=TM(1,1)*NN(1)+New(t+1);
     N(t+1,2)=TM(1,2)*NN(1)+TM(2,2)*NN(2);
     N(t+1,3)=TM(1,3)*NN(1)+TM(2,3)*NN(2)+NN(3);
   }
 }
//________________________________________________________________________

FUNCTION predict_data
 int j;

 // Predicted retained catch number (of "legals")
 for(j=1;j<=nyrs_pf;j++)
 {
   X_ret(j) = R_pf(yid_pf(j),3)*(1.0-dstr(j))/(1.0-dstr(j)+dstr(j)*hm(1));
//   X_ret_b(j) = Ret_b(yid_pf(j));
   X_ret_b(j) = X_ret(j)*avg_ret_wt(yid_pf(j))*rret;
 }

 // Predicted trawl survey total abundance and proportions
 // (adjust this and next sections for alternative TS selectivity parametrizations)
 for(j=1;j<=nyrs_ts;j++)
 {
   X_ts(j) = N(yid_ts(j),1)*s_ts(1) + N(yid_ts(j),2)*s_ts(2)+ N(yid_ts(j),3);
   P_ts(j,1)= N(yid_ts(j),1)*s_ts(1)/X_ts(j);
   P_ts(j,2)= N(yid_ts(j),2)*s_ts(2)/X_ts(j);
   P_ts(j,3)= N(yid_ts(j),3)/X_ts(j);
 }
 X_ts = Qts*X_ts;

 // Predicted trawl survey biomass
 for(j=1;j<=nyrs_ts;j++)
 B_ts(j)=Qts*( wt(1)*N(yid_ts(j),1)*s_ts(1)+wt(2)*N(yid_ts(j),2)*s_ts(2)+avg_ret_wt(yid_ts(j))*N(yid_ts(j),3));

 // Predicted pot-survey total abundance and proportions
 for(j=1;j<=nyrs_ps;j++)
 {
   X_ps(j) = N(yid_ps(j),1)*s_ps(1) + N(yid_ps(j),2)*s_ps(2) + N(yid_ps(j),3);

   P_ps(j,1)= N(yid_ps(j),1)*s_ps(1)/X_ps(j);
   P_ps(j,2)= N(yid_ps(j),2)*s_ps(2)/X_ps(j);
   P_ps(j,3)= N(yid_ps(j),3)/X_ps(j);
 }
   X_ps = Qps*X_ps;

 // Directed fishery discard mortality weight and retained catch weight
 Dis_mort = column(R_pf,1)*wt(1)+column(R_pf,2)*wt(2)+elem_prod(elem_div(elem_prod(column(R_pf,3),dstr*hm(1)),((1.0-dstr)+dstr*hm(1))),avg_ret_wt);

 // Predicted observer proportions at fishery based on 1/2 fishery stage removals
 for(j=1;j<=nyrs_ob;j++)
 {
   P_ob(j,1) = s_pf(1,yid_ob(j))*(N(yid_ob(j),1)*mfexp(-lag_pf(yid_ob(j))*MM(yid_ob(j)))-0.5*R_pf(yid_ob(j),1));
   P_ob(j,2) = s_pf(2,yid_ob(j))*(N(yid_ob(j),2)*mfexp(-lag_pf(yid_ob(j))*MM(yid_ob(j)))-0.5*R_pf(yid_ob(j),2));
   P_ob(j,3) = N(yid_ob(j),3)*mfexp(-lag_pf(yid_ob(j))*MM(yid_ob(j)))-0.5*R_pf(yid_ob(j),3);
   P_ob(j) = P_ob(j) / sum(P_ob(j));
   X_ob(j) = Dis_mort(yid_ob(j));
   if (j<10) X_ob1(j) = Dis_mort(yid_ob(j));
   else X_ob2(j) = Dis_mort(yid_ob(j));
 }

 // Groundfish mortality biomass (1000 lb) from predicted removals and stage weights [assume equal stage selectivities]
 for(j=1;j<=nyrs;j++)
 {
   B_gft(j) = R_gft(j)(1,2)*wt(1,2)+R_gft(j,3)*avg_ret_wt(j);
   B_gff(j) = R_gff(j)(1,2)*wt(1,2)+R_gff(j,3)*avg_ret_wt(j);
 }
//___________________________________________________________________________

FUNCTION calculate_obj_function
 int j, i, ii;
 LogLike.initialize();

 // Loglikelihoods (less additive constants)

 // 1a. Retained catch number of "legals"
 // LogLike(1) = -0.5*norm2(log(x_ret + 0.001) - log(X_ret + 0.001));

 // 1b. Retained catch biomass
  LogLike(1) = -0.5*norm2(log(x_ret_b + 0.001) - log(X_ret_b + 0.001));

 // 2a. Trawl suvey abundance lognormally distributed about predicted value
 //LogLike(2) = -0.5*norm2(elem_div(log(x_ts)-log(X_ts),sig_ts));

 // 2b. Trawl survey biomass lognormally distributed about predicted value
 LogLike(2) = -0.5*norm2(elem_div(log(b_ts)-log(B_ts),sig_ts_b));

 // 3. Pot survey abundance lognormally distributed about predicted value
 LogLike(3) = -0.5*norm2(elem_div(log(x_ps)-log(X_ps),sig_ps));

 // 4. Trawl survey proportions are multinomial wrt predicted proportions
   // LogLike(4) = effn_ts*rowsum(elem_prod(p_ts,log(P_ts+0.01)));
 for (j=1;j<=nyrs_ts;j++)
 {
   for(i=1;i<=3;i++)
   {
     t1  = p_ts(j,i)*(1.0-p_ts(j,i))+0.1/3.0;
     t0 = log(mfexp(-1.*square(p_ts(j,i)-P_ts(j,i))*effn_ts(j)/(2.0*t1))+0.01);
 //    Like_ts(j,i) = (p_ts(j,i)-P_ts(j,i))*sqrt(effn_ts(j)/(2.0*t1));
     LogLike(4) += (-0.5)*log(6.29*t1)-log(sqrt(1.0/effn_ts(j)))+t0;
   }
 }

 // 5. Pot survey proportions are multinomial wrt predicted proportions
   //  LogLike(5) = effn_ps*rowsum(elem_prod(p_ps,log(P_ps+0.01)));
 for (j=1;j<=nyrs_ps;j++)
 {
   for(i=1;i<=3;i++)
   {
     t1  = p_ps(j,i)*(1.0-p_ps(j,i))+0.1/3.0;
     t0 = log(mfexp(-1.*square(p_ps(j,i)-P_ps(j,i))*effn_ps(j)/(2.0*t1))+0.01);
 //    Like_ps(j,i) = (p_ps(j,i)-P_ps(j,i))*sqrt(effn_ps(j)/(2.0*t1));
     LogLike(5) += (-0.5)*log(6.29*t1)-log(sqrt(1.0/effn_ps(j)))+t0;
   }
 }

 // 6. Observer proportions are multinomial wrt predicted proportions
   //LogLike(6) = effn_ob*rowsum(elem_prod(p_ob,log(P_ob+0.01)));
 for (j=1;j<=nyrs_ob;j++)
 {
   for(i=1;i<=3;i++)
   {
     t1  = p_ob(j,i)*(1.0-p_ob(j,i))+0.1/3.0;
     t0 = log(mfexp(-1.*square(p_ob(j,i)-P_ob(j,i))*effn_ob(j)/(2.0*t1))+0.01);
 //    Like_ob(j,i) = (p_ob(j,i)-P_ob(j,i))*sqrt(effn_ob(j)/(2.0*t1));
     LogLike(6) += (-0.5)*log(6.29*t1)-log(sqrt(1.0/effn_ob(j)))+t0;
   }
 }
 //7. Pot discard male biomass
  LogLike(7) = -0.5*norm2(log(x_ob1 + 0.001) - log(X_ob1 + 0.001));
  LogLike(8) = -0.5*norm2(log(x_ob2 + 0.001) - log(X_ob2 + 0.001));

 // 9. + 10. Groundfish trawl and fixed-gear mortality biomass
 LogLike(9) = 0.0; LogLike(10) = 0.0;
 for(j=1;j<=nyrs_gf;j++)
 {
   LogLike(9) += -0.5*square(log(gft_mort(j)+0.01) - log(B_gft(yid_gf(j))+0.01));
   LogLike(10) += -0.5*square(log(gff_mort(j)+0.01) - log(B_gff(yid_gf(j))+0.01));
 }

 // Quadratic (normal) penalties

 // 1. Model recruit deviations
 Pen(1) = 0.5*norm2(log_New_dev);

 // 2. Directed fishery log fishing mortality deviations
 Pen(2) = 0.5*norm2(log_Fpf_dev);

 // 3. + 4. Gft and Gff log fishing mortality deviations
 Pen(3) = 0.5*norm2(log_Fgft_dev);
 Pen(4) = 0.5*norm2(log_Fgff_dev);


 // Objective function
 f = Pw*Pen - Lw*LogLike;

 // Mortality deviation penalty for model configuration C and its hybrids
 //f = f + 8*0.5*norm2(log_M_dev);
//____________________________________________________________________

FUNCTION project_biomasses
 // Project mmb215 and catches based on directed fishery fishing mortality FF
 // and assuming geometric mean fishing mortalities in gf fixed-gear and trawl
 // fisheries.
   dvar_vector n(1,3);
   dvar_vector nn(1,3);
   dvar_vector Rpf(1,3);
   dvar_vector Rgft(1,3);
   dvar_vector Rgff(1,3);
   dvariable S,D;
   dvariable avg_Fgft, avg_Fgff;
   dvariable mmb215;

   avg_Fgft=mfexp(mean_log_Fgft);avg_Fgff=mfexp(mean_log_Fgff);
   n=N(nyrs);
   // Survival to directed pot fishery, full-selection fishery mortality fraction,
   S=mfexp(-lag_pf(nyrs)*MM(nyrs));
   D=(1.0-mfexp(-FF));

   // Calculate fishery removals
   Rpf(1)=n(1)*S*D*s_pf(1,nyrs)*hm(1);
   Rpf(2)=n(2)*S*D*s_pf(2,nyrs)*hm(1);
   Rpf(3)=n(3)*S*D*(1.0-dstr(nyrs)+dstr(nyrs)*hm(1));

   // Take out fishery removals and discount to Feb 15
   nn = (n*S-Rpf)*mfexp(-(0.63-lag_pf(nyrs))*MM(nyrs));

   // Calculate and take out groundfish removals wrt Feb 15
   Rgft = avg_Fgft/(avg_Fgft+avg_Fgff)*nn*(1.0-mfexp(-(avg_Fgft+avg_Fgff)));
   Rgff = avg_Fgff/(avg_Fgft+avg_Fgff)*nn*(1.0-mfexp(-(avg_Fgft+avg_Fgff)));
   nn = nn-Rgft-Rgff;

   // Calculate and return projected biomasses
   mmb215_proj = nn(2)*wt(2)+nn(3)*avg_ret_wt(nyrs);
   Bret_proj = Rpf(3)*(1.0-dstr(nyrs))/(1.0-dstr(nyrs)+dstr(nyrs)*hm(1))*avg_ret_wt(nyrs)*rret;      //adjust legal weight to retained weight with rret and legal discard
   Bdis_proj = Rpf(1)*wt(1)+Rpf(2)*wt(2)+Rpf(3)/(1.0-dstr(nyrs)+dstr(nyrs)*hm(1))*dstr(nyrs)*hm(1)*avg_ret_wt(nyrs);
   Bgft_proj = Rgft(1)*wt(1)+Rgft(2)*wt(2)+Rgft(3)*avg_ret_wt(nyrs);
   Bgff_proj = Rgff(1)*wt(1)+Rgff(2)*wt(2)+Rgff(3)*avg_ret_wt(nyrs);
//_____________________________________________________________________

FUNCTION get_FOFL
// Assumes Bmsy and Fmsy are already available and defined;
// returns FOFL value
 int k;
 dvariable a,b,B;
 double alpha = 0.10;
 double beta = 0.25;

 FF=Fmsy;
 project_biomasses();
 B=mmb215_proj;

 //------
 //if(B>Bmsy) FF=Fmsy; else
 //{
 //  a=0.0;b=2.0*Fmsy;
 //  for(k=1;k<=10;k++)
 //  {
 //    FF=(a+b)/2.0;
 //    project_biomasses();
 //    B=mmb215_proj;
 //    if(FF > Fmsy*(B/Bmsy-alpha)/(1-alpha)) b=FF; else a=FF;
 //  }
 //}
 //------

 //Alternately:
 //-------
 if(B>Bmsy) FF=Fmsy; else

 for(k=1;k<=10;k++)
 {
   FF = Fmsy*(B/Bmsy-alpha)/(1-alpha);
   project_biomasses();
   B=mmb215_proj;
 }
 //-------

 if(B<0.25*Bmsy) FF=0.0;

 FOFL=FF;

//_____________________________________________________________________
FUNCTION get_SBPR
// Finds equilibrium mmb215/1000 recruits SBPR given directed-fishery
// full-selection fishing mortality FF. Assumes harmonic mean of estimated
// fishing mortalities in groundfish trawl and fixed-gear fisheries,
// final-year fishery timing, and average average retained weight.

  dvariable avg_Fgft, avg_Fgff;
  dvar_vector n(1,3);
  int t;
  dvariable S,D;
  dvar_vector Rpf(1,3);
  dvariable mmb215;
  dvar_vector nn(1,3);

  avg_Fgft = mfexp(mean_log_Fgft); avg_Fgff = mfexp(mean_log_Fgff);

  // Survival to directed pot fishery and full-selection fishery mortality fraction:
    S=mfexp(-lag_pf(nyrs)*MM(nyrs));
    D=(1.0-mfexp(-FF));

  // Start with 1000 crab in each stage.
  n = 1.0;
  for(t=1;t<=200;t++)
  {
    // Fishery removals
    Rpf(1) = n(1)*S*D*s_pf(1,nyrs)*hm(1);
    Rpf(2) = n(2)*S*D*s_pf(2,nyrs)*hm(1);
    Rpf(3) = n(3)*S*D;
    // Pull fishery removals and discount to Feb 15
    n = (n*S-Rpf)*mfexp(-(0.63-lag_pf(nyrs))*MM(nyrs));
    // Pull groundfish removals wrt Feb 15 and calcuate mmb
    n = n*mfexp(-(avg_Fgft+avg_Fgff));
    mmb215 = n(2)*wt(2)+n(3)*avg_ret_wt(nyrs);
    // Discount what's left to end of year
    nn = n*mfexp(-0.37*MM(nyrs));
    // Calculate next year's abundances assuming 1000 stage-1 recruits
    n = nn*TM;
    n(1) += 1.0;
   }

   SBPR = mmb215;
//_____________________________________________________________________

FUNCTION get_F35
 int k;
 dvariable a,b,target;

 FF=0.0;
 get_SBPR();
 target=0.35*SBPR;
 a=0.0;b=0.5;
 for(k=1;k<=10;k++)
 {
   FF=(a+b)/2.0;
   get_SBPR();
   if(SBPR>target) a=FF;else b=FF;
  }
 F35=FF;

//______________________________________________________________________

GLOBALS_SECTION
 #include <math.h>
 #include <admodel.h>
//_____________________________________________________________________

REPORT_SECTION
 //Output stuff for graphing etc
   int j,i;

   // Estimated effective sample sizes for compostion data
   dvector estNeff_ts, estNeff_ps, estNeff_ob;
   estNeff_ts = value( elem_div( rowsum(elem_prod(P_ts,1-P_ts)), rowsum(elem_prod(P_ts-p_ts,P_ts-p_ts)) ) );
   estNeff_ps = value( elem_div( rowsum(elem_prod(P_ps,1-P_ps)), rowsum(elem_prod(P_ps-p_ps,P_ps-p_ps)) ) );
   estNeff_ob = value( elem_div( rowsum(elem_prod(P_ob,1-P_ob)), rowsum(elem_prod(P_ob-p_ob,P_ob-p_ob)) ) );
   report<<"estNeff_ts"<<estNeff_ts<<endl;
   report<<"estNeff_ps"<<estNeff_ps<<endl;
   report<<"estNeff_ob"<<estNeff_ob<<endl;

   report<<"tsRMSE"<<endl;
   report<<sqrt(norm2(elem_div(x_ts-X_ts,elem_prod(column(ts_data,8),x_ts)))/nyrs_ts)<<endl; // For biomass need column 8 (not 6)
   report<<"psRMSE"<<endl;
   report<<sqrt(norm2(elem_div(x_ps-X_ps,elem_prod(column(ps_data,6),x_ps)))/nyrs_ps)<<endl;
   report<<"init_N"<<endl;
   report<<N(1)/1000.0<<endl;
   report<<"sel_ts"<<endl;
   report<<s_ts<<endl;
   report<<"sel_ps"<<endl;
   report<<s_ps<<endl;
   report<<"sel_pf"<<endl;
   report<<s_pf1<<"  "<<s_pf2<<endl;
   report<<"trans_mat"<<endl;
   report<<TM<<endl;
   report<<"M98"<<endl;
   report<<M98<<endl;
   report<<"Qps"<<endl;
   report<<Qps<<endl;

   report<<"years"<<endl;
   report<<yrs<<endl;
   report<<"N1"<<endl;
   report<<column(N,1)/1000.0<<endl;
   report<<"N2"<<endl;
   report<<column(N,2)/1000.0<<endl;
   report<<"N3"<<endl;
   report<<column(N,3)/1000.0<<endl;
   report<<"Fpf"<<endl;
   report<<Fpf<<endl;
   report<<"recs"<<endl;
   report<<New/1000.0<<endl;
   report<<"ret_wt"<<endl;
   report<<ret_wt/1000.0<<endl;
   report<<"Dis_mort"<<endl;
   report<<Dis_mort/1000.0<<endl;
   report<<"GFT_mort"<<endl;
   report<<B_gft/1000.0<<endl;
   report<<"GFF_mort"<<endl;
   report<<B_gff/1000.0<<endl;

   report<<"yrs_pf"<<endl;
   report<<yid_pf+1977<<endl;
   report<<"x_ret"<<endl;
   report<<x_ret/1000.0<<endl;
   report<<"X_ret"<<endl;
   report<<X_ret/1000.0<<endl;
   report<<"x_ret_b"<<endl;
   report<<x_ret_b/1000.0<<endl;
   report<<"X_ret_b"<<endl;
   report<<X_ret_b/1000.0<<endl;

   report<<"yrs_ob"<<endl;
   report<<yid_ob+1977<<endl;
   report<<"p_ob"<<endl;
   report<<column(p_ob,1)<<endl;
   report<<column(p_ob,2)<<endl;
   report<<column(p_ob,3)<<endl;
//   report<<p_ob<<endl;
   report<<"P_ob"<<endl;
   report<<column(P_ob,1)<<endl;
   report<<column(P_ob,2)<<endl;
   report<<column(P_ob,3)<<endl;
   report<<"effn_ob"<<endl;
   report<<effn_ob<<endl;
   report<<"x_ob"<<endl;
   report<<x_ob/1000.0<<endl;
   report<<"X_ob"<<endl;
   report<<X_ob/1000.0<<endl;

   report<<"yrs_ts"<<endl;
   report<<yid_ts+1977<<endl;
   report<<"x_ts"<<endl;
   report<<x_ts/1000.0<<endl;
   report<<"X_ts"<<endl;
   report<<X_ts/1000.0<<endl;
   report<<"b_ts"<<endl;
 //  report<<b_ts*0.45359237/1000.0<<endl;
   report<<b_ts/1000.0<<endl;
   report<<"B_ts"<<endl;
   report<<B_ts/1000.0<<endl;
   report<<"p_ts"<<endl;
   report<<column(p_ts,1)<<endl;
   report<<column(p_ts,2)<<endl;
   report<<column(p_ts,3)<<endl;
   report<<"P_ts"<<endl;
   report<<column(P_ts,1)<<endl;
   report<<column(P_ts,2)<<endl;
   report<<column(P_ts,3)<<endl;
   report<<"effn_ts"<<endl;
   report<<effn_ts<<endl;

   report<<"yrs_ps"<<endl;
   report<<yid_ps+1977<<endl;
   report<<"x_ps"<<endl;
   report<<x_ps/1000.0<<endl;
   report<<"X_ps"<<endl;
   report<<X_ps/1000.0<<endl;
   report<<"p_ps"<<endl;
   report<<column(p_ps,1)<<endl;
   report<<column(p_ps,2)<<endl;
   report<<column(p_ps,3)<<endl;
   report<<"P_ps"<<endl;
   report<<column(P_ps,1)<<endl;
   report<<column(P_ps,2)<<endl;
   report<<column(P_ps,3)<<endl;
   report<<"effn_ps"<<endl;
   report<<effn_ps<<endl;

   report<<"MMB215"<<endl;
   report<<MMB215/1000.0<<endl;

   // Objective function components and weights
   report<<"Loglikes, Pens, and total"<<endl;
   report<<-1.0*elem_prod(LogLike,Lw)<<"  "<<elem_prod(Pen,Pw)<<"  "<<f<<endl;
 //  report<<"Pens"<<endl;
   report<<" "<<endl;
   report<<" "<<endl;
   report<<"Loglike_wghts"<<endl;
   report<<Lw<<endl;
   report<<"Pen_wghts"<<endl;
   report<<Pw<<endl;


   //For index CVs
   report<<"tsCV"<<endl;
   report<<column(ts_data,6)<<endl;
   report<<"psCV"<<endl;
   report<<column(ps_data,6)<<endl;
   report<<"tsCVb"<<endl;
   report<<column(ts_data,8)<<endl;
   report<<"M"<<endl;
   report<<MM<<endl;
   report<<"avg_ret_wts"<<endl;
   //report<<0.0004535923*avg_ret_wt<<endl;
   report<<avg_ret_wt<<endl;

//Standard residuals
   report<<"ts biomass residuals"<<endl;
   report<<elem_div(log(b_ts+0.001)-log(B_ts+0.001),sqrt(2*sig_ts_b))<<endl;
   report<<2.0*elem_prod(b_ts,column(ts_data,8))/1000.0<<endl;
   report<<"ps index abudnance residuals"<<endl;
   report<<elem_div(log(x_ps+0.001)-log(X_ps+0.001),sqrt(2*sig_ps))<<endl;
   report<<2.0*elem_prod(x_ps,column(ps_data,6))/1000.0<<endl;
   report<<"ts proportion residuals"<<endl;
   for (j=1;j<=nyrs_ts;j++)
   {
     for(i=1;i<=3;i++)
     {
       t1  = p_ts(j,i)*(1.0-p_ts(j,i))+0.1/3.0;
       Like_ts(j,i) = (p_ts(j,i)-P_ts(j,i))*sqrt(effn_ts(j)/(2.0*t1));
     }
   }
   report<<column(Like_ts,1)<<endl;
   report<<column(Like_ts,2)<<endl;
   report<<column(Like_ts,3)<<endl;
   report<<"ps proportion residuals"<<endl;
   for (j=1;j<=nyrs_ps;j++)
   {
     for(i=1;i<=3;i++)
     {
       t1  = p_ps(j,i)*(1.0-p_ps(j,i))+0.1/3.0;
       Like_ps(j,i) = (p_ps(j,i)-P_ps(j,i))*sqrt(effn_ps(j)/(2.0*t1));
     }
   }
   report<<column(Like_ps,1)<<endl;
   report<<column(Like_ps,2)<<endl;
   report<<column(Like_ps,3)<<endl;
   report<<"ob proportion residuals"<<endl;
   for (j=1;j<=nyrs_ob;j++)
   {
     for(i=1;i<=3;i++)
     {
       t1  = p_ob(j,i)*(1.0-p_ob(j,i))+0.1/3.0;
       Like_ob(j,i) = (p_ob(j,i)-P_ob(j,i))*sqrt(effn_ob(j)/(2.0*t1));
     }
   }
   report<<column(Like_ob,1)<<endl;
   report<<column(Like_ob,2)<<endl;
   report<<column(Like_ob,3)<<endl;
//Catch and biomass biomass
   dvar_vector X_ret_b_tot(1, nyrs);
   dvector x_ob_tot(1, nyrs);
   dvector x_gft_tot(1, nyrs);
   dvector x_gff_tot(1, nyrs);
   X_ret_b_tot.initialize(); x_ob_tot.initialize(); x_gft_tot.initialize(); x_gff_tot.initialize();
   for (j=1;j<=nyrs_pf;j++) X_ret_b_tot(yid_pf(j)) = X_ret_b(j);
   for (j=1;j<=nyrs_ob;j++) x_ob_tot(yid_ob(j)) = x_ob(j);
   for (j=1;j<=nyrs_gf;j++) x_gft_tot(yid_gf(j)) = gft_mort(j);
   for (j=1;j<=nyrs_gf;j++) x_gff_tot(yid_gf(j)) = gff_mort(j);
   report<<"Observed and predicted retained catch biomass"<<endl;
   report<<ret_wt/1000.0<<endl;
   report<<X_ret_b_tot/1000.0<<endl;
   report<<"Observed and predicted pot discarded death biomass"<<endl;
   report<<x_ob_tot/1000.0<<endl;
   report<<Dis_mort/1000.0<<endl;
   report<<"Observed and predicted GFT discarded death biomass"<<endl;
   report<<x_gft_tot/1000.0<<endl;
   report<<B_gft/1000.0<<endl;
   report<<"Observed and predicted GFF discarded death biomass"<<endl;
   report<<x_gff_tot/1000.0<<endl;
   report<<B_gff/1000.0<<endl;
 //_____________________________________________________

FINAL_SECTION

  ofstream report1("refp15100.out");

  // F35% stuff
  get_F35();
  FF = F35;
  get_SBPR();
  Bmsy35 = SBPR*sum(New)/(nyrs-1.0);
  report1<<"\n Tier 3 \n"<<"F35 "<<F35<<endl;
  report1<<"Bmsy35 "<<Bmsy35/1000.0<<endl;

 // Tier 4 OFL quantities
 report1<<"\n Tier 4 \n"<<"Fmsy"<<" "<<Fmsy<<endl;
 report1<<"Bmsy"<<" "<<Bmsy/1000.0<<endl;
 report1<<"FOFL"<<" "<<FOFL<<endl;
 report1<<"OFL"<<" "<<OFL/1000.0<<endl;
 report1<<"mmb215_OFL"<<" "<<mmb215_proj/1000.0<<endl;
 report1<<"Bret_proj"<<" "<<Bret_proj/1000.0<<" "<<"Bdis_proj"<<" "<<Bdis_proj/1000.0<<" "<<"Bgft_proj"<<" "<<
 Bgft_proj/1000.0<<" "<<"Bgff_proj"<<" "<<Bgff_proj/1000.0<<endl;


 // Other stuff
 report1<<"legal male abundance at survey "<<LMA/1000.0<<endl;
 report1<<"legal male biomass at survey "<<LMB/1000.0<<endl;
 report1<<"mature male abundance at survey "<<MMA/1000.0<<endl;
 report1<<"mature male biomass at survey "<<MMB/1000.0<<endl;
 report1<<"S2A "<<S2A/1000.0<<endl;
 report1<<"avg avg legal weight "<<avg_ret_wt(nyrs)<<endl;


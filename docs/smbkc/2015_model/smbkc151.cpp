 #include <math.h>
 #include <admodel.h>
#include <admodel.h>
#include <contrib.h>

  extern "C"  {
    void ad_boundf(int i);
  }
#include <smbkc151.htp>

model_data::model_data(int argc,char * argv[]) : ad_comm(argc,argv)
{
  start_yr.allocate("start_yr");
  nyrs.allocate("nyrs");
  wt.allocate(1,3,"wt");
  rret.allocate("rret");
  hm.allocate(1,3,"hm");
  nyrs_ts.allocate("nyrs_ts");
  yid_ts.allocate(1,nyrs_ts,"yid_ts");
  ts_data.allocate(1,nyrs_ts,1,8,"ts_data");
  nyrs_ps.allocate("nyrs_ps");
  yid_ps.allocate(1,nyrs_ps,"yid_ps");
  ps_data.allocate(1,nyrs_ps,1,6,"ps_data");
  nyrs_pf.allocate("nyrs_pf");
  yid_pf.allocate(1,nyrs_pf,"yid_pf");
  pf_data.allocate(1,nyrs_pf,1,4,"pf_data");
  nyrs_ob.allocate("nyrs_ob");
  yid_ob.allocate(1,nyrs_ob,"yid_ob");
  ob_data.allocate(1,nyrs_ob,1,3,"ob_data");
  x_ob.allocate(1,nyrs_ob,"x_ob");
  dstr0.allocate(1,nyrs_ob,"dstr0");
  nyrs_gf.allocate("nyrs_gf");
 cout<<"nyrs_gf "<<nyrs_gf<<endl;
  yid_gf.allocate(1,nyrs_gf,"yid_gf");
  gf_data.allocate(1,nyrs_gf,1,2,"gf_data");
  eof.allocate("eof");
 if(eof != 999){cout<<"DATA READING ERROR"<<endl; exit(1);};
  yrs.allocate(1,nyrs);
  n_ts.allocate(1,nyrs_ts);
  n_ps.allocate(1,nyrs_ps);
  n_ob.allocate(1,nyrs_ob);
  x_ts.allocate(1,nyrs_ts);
  x_ps.allocate(1,nyrs_ps);
  x_ret.allocate(1,nyrs_pf);
  x_ret_b.allocate(1,nyrs_pf);
  x_ob1.allocate(1,9);
  x_ob2.allocate(10,nyrs_ob);
  b_ts.allocate(1,nyrs_ts);
  cv_ts_b.allocate(1,nyrs_ts);
  eff.allocate(1,nyrs_pf);
  lag_pf.allocate(1,nyrs);
lag_pf.initialize();
  ret_wt.allocate(1,nyrs);
ret_wt.initialize();
  avg_ret_wt.allocate(1,nyrs);
  dstr.allocate(1,nyrs);
dstr.initialize();
  cv_ts.allocate(1,nyrs_ts);
  cv_ps.allocate(1,nyrs_ps);
  p_ts.allocate(1,nyrs_ts,1,3);
  p_ps.allocate(1,nyrs_ps,1,3);
  p_ob.allocate(1,nyrs_ob,1,3);
  gft_mort.allocate(1,nyrs_gf);
  gff_mort.allocate(1,nyrs_gf);
  sig_ts.allocate(1,nyrs_ts);
  sig_ps.allocate(1,nyrs_ps);
  sig_ts_b.allocate(1,nyrs_ts);
  effn_ts.allocate(1,nyrs_ts);
  effn_ps.allocate(1,nyrs_ps);
  effn_ob.allocate(1,nyrs_ob);
 ad_comm::change_datafile_name("smbkc151.ctl");
  ph_M.allocate("ph_M");
  ph_M98.allocate("ph_M98");
  ph_Qts.allocate("ph_Qts");
  ph_Qps.allocate("ph_Qps");
  ph_logN1o.allocate("ph_logN1o");
  ph_logN2o.allocate("ph_logN2o");
  ph_logN3o.allocate("ph_logN3o");
  ph_logit_p12.allocate("ph_logit_p12");
  ph_logit_p23.allocate("ph_logit_p23");
  ph_s_ts.allocate("ph_s_ts");
  ph_s_ps.allocate("ph_s_ps");
  ph_s_pf.allocate("ph_s_pf");
  ph_mean_log_Fpf.allocate("ph_mean_log_Fpf");
  ph_log_Fpf_dev.allocate("ph_log_Fpf_dev");
  ph_mean_log_New.allocate("ph_mean_log_New");
  ph_log_New_dev.allocate("ph_log_New_dev");
  Lw.allocate(1,10,"Lw");
  Pw.allocate(1,4,"Pw");
  M_start.allocate("M_start");
  M98_start.allocate("M98_start");
  Qts_start.allocate("Qts_start");
  Qps_start.allocate("Qps_start");
  logN1o_start.allocate("logN1o_start");
  logN2o_start.allocate("logN2o_start");
  logN3o_start.allocate("logN3o_start");
  logit_p12_start.allocate("logit_p12_start");
  logit_p23_start.allocate("logit_p23_start");
  s_ts_start.allocate("s_ts_start");
  s_ps_start.allocate("s_ps_start");
  s_pf_start.allocate("s_pf_start");
  mean_log_Fpf_start.allocate("mean_log_Fpf_start");
  mean_log_New_start.allocate("mean_log_New_start");
  Nmax_ts.allocate("Nmax_ts");
  Nmax_ps.allocate("Nmax_ps");
  Nmax_ob1.allocate("Nmax_ob1");
  Nmax_ob.allocate("Nmax_ob");
 cout<<"Nmax_ob "<<Nmax_ob<<endl;
  eof_ctl.allocate("eof_ctl");
 if(eof_ctl != 999){cout<<"CTL DATA READING ERROR"<<endl; exit(1);};
}

model_parameters::model_parameters(int sz,int argc,char * argv[]) : 
 model_data(argc,argv) , function_minimizer(sz)
{
  initializationfunction();
  M.allocate(ph_M,"M");
  M98.allocate(ph_M98,"M98");
  log_M_dev.allocate(1,nyrs-1,-2,2,-1,"log_M_dev");
  Qts.allocate(ph_Qts,"Qts");
  Qps.allocate(1.0,7.0,ph_Qps,"Qps");
  s_ts.allocate(1,2,0.01,2.0,ph_s_ts,"s_ts");
  s_ps.allocate(1,2,0.01,2.0,ph_s_ps,"s_ps");
  s_pf1.allocate(1,2,0.01,2.0,ph_s_pf,"s_pf1");
  s_pf2.allocate(1,2,0.01,2.0,ph_s_pf,"s_pf2");
  logN1o.allocate(5.0,10.0,ph_logN1o,"logN1o");
  logN2o.allocate(5.0,10.0,ph_logN2o,"logN2o");
  logN3o.allocate(5.0,10.0,ph_logN3o,"logN3o");
  logit_p12.allocate(ph_logit_p12,"logit_p12");
  logit_p23.allocate(ph_logit_p23,"logit_p23");
  mean_log_Fpf.allocate(-3.0,0.0,ph_mean_log_Fpf,"mean_log_Fpf");
  log_Fpf_dev.allocate(1,nyrs_pf,-10.0,10.0,ph_log_Fpf_dev,"log_Fpf_dev");
  mean_log_New.allocate(5.0,10.0,ph_mean_log_New,"mean_log_New");
  log_New_dev.allocate(2,nyrs,-5.0,3.0,ph_log_New_dev,"log_New_dev");
  mean_log_Fgft.allocate(-12.0,-4.0,4,"mean_log_Fgft");
  mean_log_Fgff.allocate(-12.0,-4.0,4,"mean_log_Fgff");
  log_Fgft_dev.allocate(1,nyrs_gf,-6.0,6.0,5,"log_Fgft_dev");
  log_Fgff_dev.allocate(1,nyrs_gf,-6.0,6.0,5,"log_Fgff_dev");
  MM.allocate(1,nyrs,"MM");
  #ifndef NO_AD_INITIALIZE
    MM.initialize();
  #endif
  TM.allocate(1,3,1,3,"TM");
  #ifndef NO_AD_INITIALIZE
    TM.initialize();
  #endif
  Fpf.allocate(1,nyrs,"Fpf");
  #ifndef NO_AD_INITIALIZE
    Fpf.initialize();
  #endif
 Fpf.initialize();
  Fgft.allocate(1,nyrs,"Fgft");
  #ifndef NO_AD_INITIALIZE
    Fgft.initialize();
  #endif
  Fgff.allocate(1,nyrs,"Fgff");
  #ifndef NO_AD_INITIALIZE
    Fgff.initialize();
  #endif
  New.allocate(2,nyrs,"New");
  #ifndef NO_AD_INITIALIZE
    New.initialize();
  #endif
  N.allocate(1,nyrs,1,3,"N");
  #ifndef NO_AD_INITIALIZE
    N.initialize();
  #endif
  R_pf.allocate(1,nyrs,1,3,"R_pf");
  #ifndef NO_AD_INITIALIZE
    R_pf.initialize();
  #endif
 R_pf.initialize();
  R_gft.allocate(1,nyrs,1,3,"R_gft");
  #ifndef NO_AD_INITIALIZE
    R_gft.initialize();
  #endif
  R_gff.allocate(1,nyrs,1,3,"R_gff");
  #ifndef NO_AD_INITIALIZE
    R_gff.initialize();
  #endif
  B_gft.allocate(1,nyrs,"B_gft");
  #ifndef NO_AD_INITIALIZE
    B_gft.initialize();
  #endif
  B_gff.allocate(1,nyrs,"B_gff");
  #ifndef NO_AD_INITIALIZE
    B_gff.initialize();
  #endif
  Dis_mort.allocate(1,nyrs,"Dis_mort");
  #ifndef NO_AD_INITIALIZE
    Dis_mort.initialize();
  #endif
 Dis_mort.initialize();
  X_ts.allocate(1,nyrs_ts,"X_ts");
  #ifndef NO_AD_INITIALIZE
    X_ts.initialize();
  #endif
  X_ps.allocate(1,nyrs_ps,"X_ps");
  #ifndef NO_AD_INITIALIZE
    X_ps.initialize();
  #endif
  X_ret.allocate(1,nyrs_pf,"X_ret");
  #ifndef NO_AD_INITIALIZE
    X_ret.initialize();
  #endif
  X_ret_b.allocate(1,nyrs_pf,"X_ret_b");
  #ifndef NO_AD_INITIALIZE
    X_ret_b.initialize();
  #endif
  X_ob.allocate(1,nyrs_ob,"X_ob");
  #ifndef NO_AD_INITIALIZE
    X_ob.initialize();
  #endif
  X_ob1.allocate(1,9,"X_ob1");
  #ifndef NO_AD_INITIALIZE
    X_ob1.initialize();
  #endif
  X_ob2.allocate(10,nyrs_ob,"X_ob2");
  #ifndef NO_AD_INITIALIZE
    X_ob2.initialize();
  #endif
  s_pf.allocate(1,2,1,nyrs,"s_pf");
  #ifndef NO_AD_INITIALIZE
    s_pf.initialize();
  #endif
  B_ts.allocate(1,nyrs_ts,"B_ts");
  #ifndef NO_AD_INITIALIZE
    B_ts.initialize();
  #endif
  P_ts.allocate(1,nyrs_ts,1,3,"P_ts");
  #ifndef NO_AD_INITIALIZE
    P_ts.initialize();
  #endif
  P_ps.allocate(1,nyrs_ps,1,3,"P_ps");
  #ifndef NO_AD_INITIALIZE
    P_ps.initialize();
  #endif
  P_ob.allocate(1,nyrs_ob,1,3,"P_ob");
  #ifndef NO_AD_INITIALIZE
    P_ob.initialize();
  #endif
  Like_ts.allocate(1,nyrs_ts,1,3,"Like_ts");
  #ifndef NO_AD_INITIALIZE
    Like_ts.initialize();
  #endif
  Like_ps.allocate(1,nyrs_ps,1,3,"Like_ps");
  #ifndef NO_AD_INITIALIZE
    Like_ps.initialize();
  #endif
  Like_ob.allocate(1,nyrs_ob,1,3,"Like_ob");
  #ifndef NO_AD_INITIALIZE
    Like_ob.initialize();
  #endif
  t1.allocate("t1");
  #ifndef NO_AD_INITIALIZE
  t1.initialize();
  #endif
  t0.allocate("t0");
  #ifndef NO_AD_INITIALIZE
  t0.initialize();
  #endif
  MMB215.allocate(1,nyrs,"MMB215");
  #ifndef NO_AD_INITIALIZE
    MMB215.initialize();
  #endif
  f.allocate("f");
  prior_function_value.allocate("prior_function_value");
  likelihood_function_value.allocate("likelihood_function_value");
  LogLike.allocate(1,10,"LogLike");
  #ifndef NO_AD_INITIALIZE
    LogLike.initialize();
  #endif
  Pen.allocate(1,4,"Pen");
  #ifndef NO_AD_INITIALIZE
    Pen.initialize();
  #endif
  FF.allocate("FF");
  #ifndef NO_AD_INITIALIZE
  FF.initialize();
  #endif
  Bmsy.allocate("Bmsy");
  #ifndef NO_AD_INITIALIZE
  Bmsy.initialize();
  #endif
  Fmsy.allocate("Fmsy");
  #ifndef NO_AD_INITIALIZE
  Fmsy.initialize();
  #endif
  FOFL.allocate("FOFL");
  #ifndef NO_AD_INITIALIZE
  FOFL.initialize();
  #endif
  OFL.allocate("OFL");
  #ifndef NO_AD_INITIALIZE
  OFL.initialize();
  #endif
  Bret_proj.allocate("Bret_proj");
  #ifndef NO_AD_INITIALIZE
  Bret_proj.initialize();
  #endif
  Bdis_proj.allocate("Bdis_proj");
  #ifndef NO_AD_INITIALIZE
  Bdis_proj.initialize();
  #endif
  Bgft_proj.allocate("Bgft_proj");
  #ifndef NO_AD_INITIALIZE
  Bgft_proj.initialize();
  #endif
  Bgff_proj.allocate("Bgff_proj");
  #ifndef NO_AD_INITIALIZE
  Bgff_proj.initialize();
  #endif
  mmb215_proj.allocate("mmb215_proj");
  #ifndef NO_AD_INITIALIZE
  mmb215_proj.initialize();
  #endif
  logOFL.allocate("logOFL");
  SBPR.allocate("SBPR");
  #ifndef NO_AD_INITIALIZE
  SBPR.initialize();
  #endif
  F35.allocate("F35");
  #ifndef NO_AD_INITIALIZE
  F35.initialize();
  #endif
  Bmsy35.allocate("Bmsy35");
  #ifndef NO_AD_INITIALIZE
  Bmsy35.initialize();
  #endif
  LMA.allocate("LMA");
  LMB.allocate("LMB");
  MMA.allocate("MMA");
  MMB.allocate("MMB");
  S2A.allocate("S2A");
}

void model_parameters::initializationfunction(void)
{
  M.set_initial_value(M_start);
  M98.set_initial_value(M98_start);
  Qts.set_initial_value(Qts_start);
  Qps.set_initial_value(Qps_start);
  logN1o.set_initial_value(logN1o_start);
  logN2o.set_initial_value(logN2o_start);
  logN3o.set_initial_value(logN3o_start);
  logit_p12.set_initial_value(logit_p12_start);
  logit_p23.set_initial_value(logit_p23_start);
  s_ts.set_initial_value(s_ts_start);
  s_ps.set_initial_value(s_ps_start);
  s_pf1.set_initial_value(s_pf_start);
  s_pf2.set_initial_value(s_pf_start);
  mean_log_Fpf.set_initial_value(mean_log_New_start);
  mean_log_New.set_initial_value(mean_log_New_start);
}

void model_parameters::preliminary_calculations(void)
{

#if defined(USE_ADPVM)

  admaster_slave_variable_interface(*this);

#endif
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
 n_ob=rowsum(ob_data);
 for(k=1;k<=nyrs_ob;k++) p_ob(k)=ob_data(k)/n_ob(k);
 for(k=1;k<=nyrs_ob;k++) dstr(yid_ob(k))= dstr0(k);
 x_ob = x_ob*hm(1);
 for(k=1;k<=9;k++) x_ob1(k) = x_ob(k);
 for(k=10;k<=nyrs_ob;k++) x_ob2(k) = x_ob(k);
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
 	
}

void model_parameters::userfunction(void)
{
  f =0.0;
 get_numbers();
 run_pop_dynamics();
 predict_data();
 calculate_obj_function();
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
   MMA = N(nyrs)(2) + N(nyrs)(3); 
   MMB = N(nyrs)(2)*wt(2)+N(nyrs)(3)*avg_ret_wt(nyrs);
   S2A = N(nyrs)(2);
}

void model_parameters::get_numbers(void)
{
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
 // Groundfish killing constants same for all stages [= geometric mean in years with no data]
 Fgft = exp(mean_log_Fgft);
 Fgff = exp(mean_log_Fgff);
 for(j=1;j<=nyrs_gf;j++)
 {
   Fgft(yid_gf(j)) = mfexp(mean_log_Fgft + log_Fgft_dev(j));
   Fgff(yid_gf(j)) = mfexp(mean_log_Fgff + log_Fgff_dev(j));
 }
}

void model_parameters::run_pop_dynamics(void)
{
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
   //NN = N(t)*mfexp(-MM(t));
   // Calculate next year's abundances only thru assessment year t+1 = nyrs
   if(t<nyrs)
   {
     N(t+1,1)=TM(1,1)*NN(1)+New(t+1);
     N(t+1,2)=TM(1,2)*NN(1)+TM(2,2)*NN(2);
     N(t+1,3)=TM(2,3)*NN(2)+NN(3);
   }
 }
}

void model_parameters::predict_data(void)
{
 int j;
 // Predicted retained catch number (of "legals")
 for(j=1;j<=nyrs_pf;j++)
 {
   X_ret(j) = R_pf(yid_pf(j),3)*(1.0-dstr(j))/(1.0-dstr(j)+dstr(j)*hm(1));
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
}

void model_parameters::calculate_obj_function(void)
{
 int j, i, ii;
 LogLike.initialize();
 // Loglikelihoods (less additive constants)
 // 1a. Retained catch number of "legals"
 // LogLike(1) = -0.5*norm2(log(x_ret + 0.001) - log(X_ret + 0.001));
 // 1b. Retained catch biomass
  LogLike(1) = -0.5*norm2(log(x_ret_b + 0.001) - log(X_ret_b + 0.001));
  //cout << "x_ret_b: " << x_ret_b << endl;
  //cout << "X_ret_b: " << X_ret_b << endl;
  //exit(1);
  //LogLike(1) = dnorm(res_catch(k), catch_sd);
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
}

void model_parameters::project_biomasses(void)
{
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
}

void model_parameters::get_FOFL(void)
{
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
}

void model_parameters::get_SBPR(void)
{
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
}

void model_parameters::get_F35(void)
{
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
}

void model_parameters::report(const dvector& gradients)
{
 adstring ad_tmp=initial_params::get_reportfile_name();
  ofstream report((char*)(adprogram_name + ad_tmp));
  if (!report)
  {
    cerr << "error trying to open report file"  << adprogram_name << ".rep";
    return;
  }
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
   report<<avg_ret_wt<<endl;
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
   report << N << endl;
   report << New << endl;
   report << MM << endl;
   report << Fgft << endl;
   report << Fgff << endl;
   report << dstr << endl;
   
   
 //_____________________________________________________
}

void model_parameters::final_calcs()
{
  ofstream report1("refp151.out");
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
}

model_data::~model_data()
{}

model_parameters::~model_parameters()
{}

void model_parameters::set_runtime(void){}

#ifdef _BORLANDC_
  extern unsigned _stklen=10000U;
#endif


#ifdef __ZTC__
  extern unsigned int _stack=10000U;
#endif

  long int arrmblsize=0;

int main(int argc,char * argv[])
{
    ad_set_new_handler();
  ad_exit=&ad_boundf;
    gradient_structure::set_NO_DERIVATIVES();
    gradient_structure::set_YES_SAVE_VARIABLES_VALUES();
    if (!arrmblsize) arrmblsize=15000000;
    model_parameters mp(arrmblsize,argc,argv);
    mp.iprint=10;
    mp.preliminary_calculations();
    mp.computations(argc,argv);
    return 0;
}

extern "C"  {
  void ad_boundf(int i)
  {
    /* so we can stop here */
    exit(i);
  }
}

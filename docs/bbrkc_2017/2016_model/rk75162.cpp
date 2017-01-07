#ifdef DEBUG
  #ifndef __SUNPRO_C
    #include <cfenv>
    #include <cstdlib>
  #endif
#endif
#include <admodel.h>
#include <contrib.h>

  extern "C"  {
    void ad_boundf(int i);
  }
#include <rk75162.htp>

model_data::model_data(int argc,char * argv[]) : ad_comm(argc,argv)
{
  styr.allocate("styr");
  endyr.allocate("endyr");
  nirec.allocate("nirec");
  nlenm.allocate("nlenm");
  nlenf.allocate("nlenf");
  nr.allocate("nr");
  slt.allocate("slt");
  ilen1.allocate("ilen1");
  nobs_fish.allocate("nobs_fish");
  yrs_fish.allocate(1,nobs_fish,"yrs_fish");
  nsamples_fish.allocate(1,nobs_fish,"nsamples_fish");
  nobs_fish_discf.allocate("nobs_fish_discf");
  yrs_fish_discf.allocate(1,nobs_fish_discf,"yrs_fish_discf");
  nsamples_fish_discf.allocate(1,nobs_fish_discf,"nsamples_fish_discf");
  nobs_fish_discm.allocate("nobs_fish_discm");
  yrs_fish_discm.allocate(1,nobs_fish_discm,"yrs_fish_discm");
  nsamples_fish_discm.allocate(1,nobs_fish_discm,"nsamples_fish_discm");
  nobs_trawl.allocate("nobs_trawl");
  yrs_trawl.allocate(1,nobs_trawl,"yrs_trawl");
  nsamples_trawl.allocate(1,2,1,nobs_trawl,"nsamples_trawl");
  nobs_srv1.allocate("nobs_srv1");
  yrs_srv1.allocate(1,nobs_srv1,"yrs_srv1");
  nsamples_srv1.allocate(1,2,1,nobs_srv1,"nsamples_srv1");
  obs_p_srv1_len_f.allocate(1,nobs_srv1,1,nlenm,"obs_p_srv1_len_f");
  obs_p_srv1_len_m.allocate(1,2,1,nobs_srv1,1,nlenm,"obs_p_srv1_len_m");
  obs_p_fish_ret.allocate(1,nobs_fish,1,nlenm,"obs_p_fish_ret");
  obs_p_fish_discf.allocate(1,nobs_fish_discf,1,nlenm,"obs_p_fish_discf");
  obs_p_fish_discm.allocate(1,nobs_fish_discm,1,nlenm,"obs_p_fish_discm");
  obs_p_trawl.allocate(1,2,1,nobs_trawl,1,nlenm,"obs_p_trawl");
  catch_numbers.allocate(styr,endyr,"catch_numbers");
  catch_ret.allocate(styr,endyr,"catch_ret");
  catch_disc.allocate(1,2,styr,endyr,"catch_disc");
  catch_trawl.allocate(styr,endyr,"catch_trawl");
  obs_srv1.allocate(1,nobs_srv1,"obs_srv1");
  cv_srv1.allocate(1,2,1,nobs_srv1,"cv_srv1");
  wt.allocate(1,2,1,nlenm,"wt");
  length_bins.allocate(1,nlenm,"length_bins");
  g.allocate(1,4,1,nlenm,"g");
  ggf.allocate(1,2,1,nlenm,"ggf");
  ggm.allocate(1,2,1,nlenm,"ggm");
  cm.allocate(styr,endyr,"cm");
  p68.allocate(1,3,1,nlenm,"p68");
  fc.allocate(styr,styr+4,"fc");
  s_bsfrf.allocate(1,nlenm,"s_bsfrf");
  nobs_bsfrf.allocate("nobs_bsfrf");
  yrs_bsfrf.allocate(1,nobs_bsfrf,"yrs_bsfrf");
  obs_s_bsfrf.allocate(1,2,1,nobs_bsfrf,"obs_s_bsfrf");
  nsamples_bsfrf.allocate(1,2,1,nobs_bsfrf,"nsamples_bsfrf");
  obs_n_bsfrf.allocate(1,nobs_bsfrf,"obs_n_bsfrf");
  cv_bsfrf.allocate(1,nobs_bsfrf,"cv_bsfrf");
  obs_p_bsfrf_f.allocate(1,nobs_bsfrf,1,nlenm,"obs_p_bsfrf_f");
  obs_p_bsfrf_m.allocate(1,nobs_bsfrf,1,nlenm,"obs_p_bsfrf_m");
  obs_cp_bsfrf_f.allocate(3,nobs_bsfrf,1,nlenm,"obs_cp_bsfrf_f");
  obs_cp_bsfrf_m.allocate(3,nobs_bsfrf,1,nlenm,"obs_cp_bsfrf_m");
  obs_cv_bsfrf_f.allocate(3,nobs_bsfrf,1,nlenm,"obs_cv_bsfrf_f");
  obs_cv_bsfrf_m.allocate(3,nobs_bsfrf,1,nlenm,"obs_cv_bsfrf_m");
  sur_q.allocate(1,2,"sur_q");
ad_comm::change_datafile_name("tc7516s.dat");
  nobs_tc.allocate("nobs_tc");
  yrs_tc.allocate(1,nobs_tc,"yrs_tc");
  nsamples_tc.allocate(1,2,1,nobs_tc,"nsamples_tc");
  obs_p_tc_len_f.allocate(1,nobs_tc,1,nlenm,"obs_p_tc_len_f");
  obs_p_tc_len_m.allocate(1,nobs_tc,1,nlenm,"obs_p_tc_len_m");
  catch_tc.allocate(1,2,1,nobs_tc,"catch_tc");
  m_tc.allocate("m_tc");
  tc_e.allocate(styr,endyr,"tc_e");
  tc_cm.allocate(styr,endyr,"tc_cm");
ad_comm::change_datafile_name("rksize16s.dat");
  obs_s_srv1.allocate(1,2,1,nobs_srv1,"obs_s_srv1");
  obs_s_fish_ret.allocate(1,nobs_fish,"obs_s_fish_ret");
  obs_s_fish_discf.allocate(1,nobs_fish_discf,"obs_s_fish_discf");
  obs_s_fish_discm.allocate(1,nobs_fish_discm,"obs_s_fish_discm");
  obs_s_trawl.allocate(1,2,1,nobs_trawl,"obs_s_trawl");
  obs_s_tc.allocate(1,2,1,nobs_tc,"obs_s_tc");
ad_comm::change_datafile_name("rk75161.ctl");
  alphar1.allocate("alphar1");
  alphar2.allocate("alphar2");
  Mn.allocate(1,2,styr,endyr,"Mn");
  mo.allocate(styr,endyr,"mo");
  survsel_phase.allocate("survsel_phase");
  nsellen.allocate("nsellen");
  nsellen_srv1.allocate("nsellen_srv1");
  phase_logistic_sel.allocate("phase_logistic_sel");
  like_wght.allocate(1,7,"like_wght");
  like_wght_rec.allocate("like_wght_rec");
  like_wght_sexr.allocate("like_wght_sexr");
  like_wght_sel50.allocate("like_wght_sel50");
  m_disc.allocate("m_disc");
  m_trawl.allocate("m_trawl");
  bycatch_w.allocate("bycatch_w");
  mat.allocate(1,nlenm,"mat");
  flast.allocate(1,3,"flast");
  vb.allocate("vb");
  b35.allocate("b35");
  fprj.allocate(1,3,"fprj");
  y_bsfrf.allocate("y_bsfrf");
  ryear.allocate(1,2,"ryear");
  // cout<<"to local calcs"<<endl;
   if(nsellen>nlenm) nsellen=nlenm;           //make sure nselages not greater than nages
   if(nsellen_srv1>nlenm) nsellen_srv1=nlenm; //same as above for survey
   obs_srv1=obs_srv1*1000000;                 //survey numbers read in are millions of crab
   catch_numbers=catch_numbers*1000000;       //total catch numbers read in are millions of crab
   catch_disc=catch_disc*1000000;             //total discard numbers read in are millions of crab
   catch_tc=catch_tc*1000000;                 //total discard numbers read in are millions of crab
   catch_trawl=catch_trawl*1000000;           //trawl trawl bycatch numbers read in are millions of crab
   wt=wt*.001;                                //change weights to tons
   catch_ret=catch_ret*907.18474/2.0;         //change retained catch from million lbs to tons
   obs_n_bsfrf=obs_n_bsfrf*1000000;               //bsfrf survey numbers read in are millions of crab
}

void model_parameters::initializationfunction(void)
{
  mean_log_rec.set_initial_value(16.5);
  log_avg_fmort.set_initial_value(-1.5);
  log_avg_fmortt.set_initial_value(-4.0);
  log_avg_sel50.set_initial_value(4.92);
  moltp_am.set_initial_value(0.13);
  log_moltp_bm.set_initial_value(4.977);
  fish_disc_slope_f.set_initial_value(0.25);
  log_fish_disc_sel50_f.set_initial_value(4.43);
  fish_disc_slope_t.set_initial_value(0.10);
  log_fish_disc_sel50_t.set_initial_value(5.0106);
  qm2.set_initial_value(0.896);
}

model_parameters::model_parameters(int sz,int argc,char * argv[]) : 
 model_data(argc,argv) , function_minimizer(sz)
{
  initializationfunction();
  M0.allocate(0.1,0.26,-1,"M0");
  Mm.allocate(0.184,1.0,6,"Mm");
  Mf.allocate(0.276,1.5,4,"Mf");
  Mm1.allocate(0.0,0.00000001,-1,"Mm1");
  Mf1.allocate(0.0,0.1082,4,"Mf1");
  M.allocate(1,2,styr,endyr,"M");
  #ifndef NO_AD_INITIALIZE
    M.initialize();
  #endif
  log_betal.allocate(1,2,-0.67,1.32,4,"log_betal");
  betal.allocate("betal");
  #ifndef NO_AD_INITIALIZE
  betal.initialize();
  #endif
  log_betar.allocate(1,2,-1.14,0.5,4,"log_betar");
  betar.allocate("betar");
  #ifndef NO_AD_INITIALIZE
  betar.initialize();
  #endif
  a_bsfrf.allocate(0.0,0.4,6,"a_bsfrf");
  moltp_am.allocate(1,2,0.01,0.259,4,"moltp_am");
  log_moltp_bm.allocate(1,2,4.445,5.519,4,"log_moltp_bm");
  n68.allocate(15.0,21.0,1,"n68");
  log_avg_sel50.allocate(4.78,5.05,phase_logistic_sel,"log_avg_sel50");
  sel50_dev.allocate(styr,endyr,-30,30,-4,"sel50_dev");
  fish_slope.allocate(.05,.7,phase_logistic_sel,"fish_slope");
  ret_a.allocate(-0.40,0.0,4,"ret_a");
  ret_b.allocate(0.0,0.005,4,"ret_b");
  ret_c.allocate(-0.025,0.0,4,"ret_c");
  fish_disc_slope_f.allocate(.05,.43,phase_logistic_sel,"fish_disc_slope_f");
  log_fish_disc_sel50_f.allocate(4.20,4.66,phase_logistic_sel,"log_fish_disc_sel50_f");
  fish_disc_sel50_dev_f.allocate(1,nobs_fish_discf,-30,30,-1,"fish_disc_sel50_dev_f");
  fish_disc_slope_t.allocate(.01,.2,phase_logistic_sel,"fish_disc_slope_t");
  log_fish_disc_sel50_t.allocate(4.5,5.4,phase_logistic_sel,"log_fish_disc_sel50_t");
  fish_disc_sel50_dev_tm.allocate(1,nobs_trawl,-30,30,-4,"fish_disc_sel50_dev_tm");
  log_srv1_sel50_m.allocate(3.59,5.48,survsel_phase,"log_srv1_sel50_m");
  srv1_slope_f.allocate(.01,.4351,survsel_phase,"srv1_slope_f");
  log_srv1_sel50_f.allocate(4.09,5.539,survsel_phase,"log_srv1_sel50_f");
  log_srv2_sel50_m.allocate(4.09,4.5539,survsel_phase,"log_srv2_sel50_m");
  srv2_slope_f.allocate(.01,.303,survsel_phase,"srv2_slope_f");
  log_srv2_sel50_f.allocate(4.09,4.7,survsel_phase,"log_srv2_sel50_f");
  log_srv3_sel50_m.allocate(4.09,5.1,survsel_phase,"log_srv3_sel50_m");
  srv3_slope_f.allocate(.01,.3,survsel_phase,"srv3_slope_f");
  log_srv3_sel50_f.allocate(4.09,4.9,survsel_phase,"log_srv3_sel50_f");
  srv1_slope_m.allocate("srv1_slope_m");
  #ifndef NO_AD_INITIALIZE
  srv1_slope_m.initialize();
  #endif
  fish_tc_slope_f.allocate(.02,.4,phase_logistic_sel,"fish_tc_slope_f");
  log_fish_tc_sel50_f.allocate(4.24,4.9,phase_logistic_sel,"log_fish_tc_sel50_f");
  fish_tc_slope_m.allocate(.05,.9,phase_logistic_sel,"fish_tc_slope_m");
  log_fish_tc_sel50_m.allocate(4.25,5.14,phase_logistic_sel,"log_fish_tc_sel50_m");
  log_Ftcm.allocate(1,nobs_tc,-10.0,1.0,2,"log_Ftcm");
  log_Ftcf.allocate(1,nobs_tc,-10.0,1.0,2,"log_Ftcf");
  qf2.allocate("qf2");
  #ifndef NO_AD_INITIALIZE
  qf2.initialize();
  #endif
  qm2.allocate(0.592,1.20,6,"qm2");
  qm3.allocate(0.6,1.4,-6,"qm3");
  mean_log_rec.allocate(13.0,20.0,1,"mean_log_rec");
  rec_devf.allocate(styr+1,endyr,-15,15,2,"rec_devf");
  rec_devm.allocate(styr+1,endyr,-15,15,2,"rec_devm");
  log_avg_fmort.allocate(-3.0,0.0,1,"log_avg_fmort");
  fmort_dev.allocate(styr,endyr,-15.0,2.42598,1,"fmort_dev");
  factor_fmortdf.allocate(0.001,0.10,1,"factor_fmortdf");
  fmortdf_dev.allocate(1990,endyr,-6,3.5,1,"fmortdf_dev");
  fmortdm_dev.allocate(1990,endyr,-7,7,-1,"fmortdm_dev");
  log_avg_fmortt.allocate(-8.5,-0.5,1,"log_avg_fmortt");
  fmortt_dev.allocate(1976,endyr,-10,10.0,1,"fmortt_dev");
  first_males.allocate(1,nlenm,-0.01,0.01,-6,"first_males");
  first_females.allocate(1,nlenf,-0.01,0.01,-6,"first_females");
  f_year.allocate(1,nlenm+nlenf-1,-5.0,5.0,6,"f_year");
  f_year_p.allocate(1,nlenm+nlenf,"f_year_p");
  #ifndef NO_AD_INITIALIZE
    f_year_p.initialize();
  #endif
  f_year_e.allocate(1,nlenm+nlenf,"f_year_e");
  #ifndef NO_AD_INITIALIZE
    f_year_e.initialize();
  #endif
  hg1.allocate(0.057,0.500,-3,"hg1");
  hg2.allocate(0.001,0.087,-3,"hg2");
  hg3.allocate(0.001,0.0384,-3,"hg3");
  hg4.allocate(0.001,0.03875,-3,"hg4");
  hg5.allocate(0.001,0.0645,-3,"hg5");
  hg6.allocate(0.001,0.02964,-3,"hg6");
  hg7.allocate(0.001,0.02150,-3,"hg7");
  hg8.allocate(0.001,0.04709,-3,"hg8");
  hg9.allocate(0.001,0.1254,-3,"hg9");
  hg10.allocate(0.001,0.320,-3,"hg10");
  hg11.allocate(0.001,0.1409,-3,"hg11");
  sel.allocate(styr,endyr,1,nlenm,"sel");
  #ifndef NO_AD_INITIALIZE
    sel.initialize();
  #endif
  sel_discf.allocate(styr,endyr,1,nlenm,"sel_discf");
  #ifndef NO_AD_INITIALIZE
    sel_discf.initialize();
  #endif
  sel_fit.allocate(styr,endyr,1,nlenm,"sel_fit");
  #ifndef NO_AD_INITIALIZE
    sel_fit.initialize();
  #endif
  sel_ret.allocate(1,nlenm,"sel_ret");
  #ifndef NO_AD_INITIALIZE
    sel_ret.initialize();
  #endif
  sel_ret0.allocate(1,nlenm,"sel_ret0");
  #ifndef NO_AD_INITIALIZE
    sel_ret0.initialize();
  #endif
  mat1.allocate(1,nlenm,"mat1");
  #ifndef NO_AD_INITIALIZE
    mat1.initialize();
  #endif
  mat2.allocate(1,nlenm,"mat2");
  #ifndef NO_AD_INITIALIZE
    mat2.initialize();
  #endif
  ftem1.allocate(1,nlenm,"ftem1");
  #ifndef NO_AD_INITIALIZE
    ftem1.initialize();
  #endif
  sel_trawl_f.allocate(styr,endyr,1,nlenm,"sel_trawl_f");
  #ifndef NO_AD_INITIALIZE
    sel_trawl_f.initialize();
  #endif
  sel_trawl_m.allocate(styr,endyr,1,nlenm,"sel_trawl_m");
  #ifndef NO_AD_INITIALIZE
    sel_trawl_m.initialize();
  #endif
  sel_srv1.allocate(1,2,1,nlenm,"sel_srv1");
  #ifndef NO_AD_INITIALIZE
    sel_srv1.initialize();
  #endif
  sel_srv2.allocate(1,2,1,nlenm,"sel_srv2");
  #ifndef NO_AD_INITIALIZE
    sel_srv2.initialize();
  #endif
  sel_srv3.allocate(1,2,1,nlenm,"sel_srv3");
  #ifndef NO_AD_INITIALIZE
    sel_srv3.initialize();
  #endif
  sel_srv.allocate(1,2,styr,endyr,1,nlenm,"sel_srv");
  #ifndef NO_AD_INITIALIZE
    sel_srv.initialize();
  #endif
  totn_srv1.allocate(1,2,styr,endyr,"totn_srv1");
  #ifndef NO_AD_INITIALIZE
    totn_srv1.initialize();
  #endif
  totn_trawl.allocate(1,2,styr,endyr,"totn_trawl");
  #ifndef NO_AD_INITIALIZE
    totn_trawl.initialize();
  #endif
  explbiom.allocate(styr,endyr,"explbiom");
  #ifndef NO_AD_INITIALIZE
    explbiom.initialize();
  #endif
  pred_bio.allocate(styr,endyr,"pred_bio");
  #ifndef NO_AD_INITIALIZE
    pred_bio.initialize();
  #endif
  pred_srv1.allocate(1,2,styr,endyr,1,nlenm,"pred_srv1");
  #ifndef NO_AD_INITIALIZE
    pred_srv1.initialize();
  #endif
  pred_p_fish.allocate(styr,endyr,1,nlenm,"pred_p_fish");
  #ifndef NO_AD_INITIALIZE
    pred_p_fish.initialize();
  #endif
  pred_p_fish_fit.allocate(styr,endyr,1,nlenm,"pred_p_fish_fit");
  #ifndef NO_AD_INITIALIZE
    pred_p_fish_fit.initialize();
  #endif
  pred_p_fish_discm.allocate(styr,endyr,1,nlenm,"pred_p_fish_discm");
  #ifndef NO_AD_INITIALIZE
    pred_p_fish_discm.initialize();
  #endif
  pred_p_fish_discf.allocate(styr,endyr,1,nlenm,"pred_p_fish_discf");
  #ifndef NO_AD_INITIALIZE
    pred_p_fish_discf.initialize();
  #endif
  pred_p_trawl.allocate(1,2,styr,endyr,1,nlenm,"pred_p_trawl");
  #ifndef NO_AD_INITIALIZE
    pred_p_trawl.initialize();
  #endif
  pred_p_srv1_len_m.allocate(1,2,styr,endyr,1,nlenm,"pred_p_srv1_len_m");
  #ifndef NO_AD_INITIALIZE
    pred_p_srv1_len_m.initialize();
  #endif
  pred_p_srv1_len_f.allocate(styr,endyr,1,nlenm,"pred_p_srv1_len_f");
  #ifndef NO_AD_INITIALIZE
    pred_p_srv1_len_f.initialize();
  #endif
  pred_catch.allocate(styr,endyr,"pred_catch");
  #ifndef NO_AD_INITIALIZE
    pred_catch.initialize();
  #endif
  pred_catch_ret.allocate(styr,endyr,"pred_catch_ret");
  #ifndef NO_AD_INITIALIZE
    pred_catch_ret.initialize();
  #endif
  pred_catch_disc.allocate(styr,endyr,"pred_catch_disc");
  #ifndef NO_AD_INITIALIZE
    pred_catch_disc.initialize();
  #endif
  pred_catch_trawl.allocate(styr,endyr,"pred_catch_trawl");
  #ifndef NO_AD_INITIALIZE
    pred_catch_trawl.initialize();
  #endif
  catch_male_ret.allocate(styr,endyr,1,nlenm,"catch_male_ret");
  #ifndef NO_AD_INITIALIZE
    catch_male_ret.initialize();
  #endif
  catch_lmale.allocate(styr,endyr,1,nlenm,"catch_lmale");
  #ifndef NO_AD_INITIALIZE
    catch_lmale.initialize();
  #endif
  catch_discp.allocate(styr,endyr,1,nlenm,"catch_discp");
  #ifndef NO_AD_INITIALIZE
    catch_discp.initialize();
  #endif
  na.allocate(styr,endyr,1,nlenm,"na");
  #ifndef NO_AD_INITIALIZE
    na.initialize();
  #endif
  na_f.allocate(styr,endyr,1,nlenm,"na_f");
  #ifndef NO_AD_INITIALIZE
    na_f.initialize();
  #endif
  na_m.allocate(1,2,styr,endyr,1,nlenm,"na_m");
  #ifndef NO_AD_INITIALIZE
    na_m.initialize();
  #endif
  len_len.allocate(1,4,1,nlenm,1,nlenm,"len_len");
  #ifndef NO_AD_INITIALIZE
    len_len.initialize();
  #endif
  len_len0.allocate(1,nlenm,1,nlenm,"len_len0");
  #ifndef NO_AD_INITIALIZE
    len_len0.initialize();
  #endif
  moltp.allocate(styr,endyr,1,nlenm,"moltp");
  #ifndef NO_AD_INITIALIZE
    moltp.initialize();
  #endif
  Ftot.allocate(1,2,styr,endyr,1,nlenm,"Ftot");
  #ifndef NO_AD_INITIALIZE
    Ftot.initialize();
  #endif
  F.allocate(styr,endyr,1,nlenm,"F");
  #ifndef NO_AD_INITIALIZE
    F.initialize();
  #endif
  F_ret.allocate(styr,endyr,1,nlenm,"F_ret");
  #ifndef NO_AD_INITIALIZE
    F_ret.initialize();
  #endif
  Fdiscm.allocate(styr,endyr,1,nlenm,"Fdiscm");
  #ifndef NO_AD_INITIALIZE
    Fdiscm.initialize();
  #endif
  Fdiscf.allocate(styr,endyr,1,nlenm,"Fdiscf");
  #ifndef NO_AD_INITIALIZE
    Fdiscf.initialize();
  #endif
  Fdisct.allocate(1,2,styr,endyr,1,nlenm,"Fdisct");
  #ifndef NO_AD_INITIALIZE
    Fdisct.initialize();
  #endif
  S.allocate(1,2,styr,endyr,1,nlenm,"S");
  #ifndef NO_AD_INITIALIZE
    S.initialize();
  #endif
  fmort.allocate(styr,endyr,"fmort");
  #ifndef NO_AD_INITIALIZE
    fmort.initialize();
  #endif
  fmortret.allocate(styr,endyr,"fmortret");
  #ifndef NO_AD_INITIALIZE
    fmortret.initialize();
  #endif
  fmortdf.allocate(styr,endyr,"fmortdf");
  #ifndef NO_AD_INITIALIZE
    fmortdf.initialize();
  #endif
  fmortdm.allocate(styr,endyr,"fmortdm");
  #ifndef NO_AD_INITIALIZE
    fmortdm.initialize();
  #endif
  fmortt.allocate(styr,endyr,"fmortt");
  #ifndef NO_AD_INITIALIZE
    fmortt.initialize();
  #endif
  fmort_dsisc.allocate(styr,endyr,"fmort_dsisc");
  #ifndef NO_AD_INITIALIZE
    fmort_dsisc.initialize();
  #endif
  fish_sel50.allocate(styr,endyr,"fish_sel50");
  #ifndef NO_AD_INITIALIZE
    fish_sel50.initialize();
  #endif
  ff_tem.allocate(1,13,"ff_tem");
  #ifndef NO_AD_INITIALIZE
    ff_tem.initialize();
  #endif
  mbio215.allocate(styr,endyr,"mbio215");
  mbio2151.allocate(styr,endyr,"mbio2151");
  #ifndef NO_AD_INITIALIZE
    mbio2151.initialize();
  #endif
  mbio2152.allocate(styr,endyr,"mbio2152");
  #ifndef NO_AD_INITIALIZE
    mbio2152.initialize();
  #endif
  rec_like.allocate("rec_like");
  #ifndef NO_AD_INITIALIZE
  rec_like.initialize();
  #endif
  catch_like1.allocate("catch_like1");
  #ifndef NO_AD_INITIALIZE
  catch_like1.initialize();
  #endif
  catch_like2.allocate("catch_like2");
  #ifndef NO_AD_INITIALIZE
  catch_like2.initialize();
  #endif
  catch_liket.allocate("catch_liket");
  #ifndef NO_AD_INITIALIZE
  catch_liket.initialize();
  #endif
  catch_likef.allocate("catch_likef");
  #ifndef NO_AD_INITIALIZE
  catch_likef.initialize();
  #endif
  len_likeyr.allocate(1,3,1,nobs_srv1,"len_likeyr");
  #ifndef NO_AD_INITIALIZE
    len_likeyr.initialize();
  #endif
  len_like.allocate(1,8,"len_like");
  #ifndef NO_AD_INITIALIZE
    len_like.initialize();
  #endif
  sel_like.allocate(1,4,"sel_like");
  #ifndef NO_AD_INITIALIZE
    sel_like.initialize();
  #endif
  sel_like_50m.allocate("sel_like_50m");
  #ifndef NO_AD_INITIALIZE
  sel_like_50m.initialize();
  #endif
  surv_like.allocate("surv_like");
  #ifndef NO_AD_INITIALIZE
  surv_like.initialize();
  #endif
  cpue_like.allocate("cpue_like");
  #ifndef NO_AD_INITIALIZE
  cpue_like.initialize();
  #endif
  sexr_like.allocate("sexr_like");
  #ifndef NO_AD_INITIALIZE
  sexr_like.initialize();
  #endif
  like_srv1_m.allocate(1,2,styr,endyr,1,nlenm,"like_srv1_m");
  #ifndef NO_AD_INITIALIZE
    like_srv1_m.initialize();
  #endif
  like_srv1_f.allocate(styr,endyr,1,nlenm,"like_srv1_f");
  #ifndef NO_AD_INITIALIZE
    like_srv1_f.initialize();
  #endif
  endbiom.allocate("endbiom");
  #ifndef NO_AD_INITIALIZE
  endbiom.initialize();
  #endif
  mature1.allocate("mature1");
  mature2.allocate("mature2");
  qm2p.allocate("qm2p");
  f.allocate("f");
  prior_function_value.allocate("prior_function_value");
  likelihood_function_value.allocate("likelihood_function_value");
  obs_p_fish_tot.allocate(1,nobs_fish_discm,1,nlenm,"obs_p_fish_tot");
  #ifndef NO_AD_INITIALIZE
    obs_p_fish_tot.initialize();
  #endif
  maxsel_fish.allocate("maxsel_fish");
  #ifndef NO_AD_INITIALIZE
  maxsel_fish.initialize();
  #endif
  catch_tot.allocate(styr,endyr,"catch_tot");
  #ifndef NO_AD_INITIALIZE
    catch_tot.initialize();
  #endif
  legal_males.allocate(styr,endyr,"legal_males");
  #ifndef NO_AD_INITIALIZE
    legal_males.initialize();
  #endif
  legal_srv_males.allocate(styr,endyr,"legal_srv_males");
  #ifndef NO_AD_INITIALIZE
    legal_srv_males.initialize();
  #endif
  popn.allocate(styr,endyr,"popn");
  #ifndef NO_AD_INITIALIZE
    popn.initialize();
  #endif
  popn_fit.allocate(styr,endyr,"popn_fit");
  #ifndef NO_AD_INITIALIZE
    popn_fit.initialize();
  #endif
  obs_srv1_num.allocate(1,2,1,nobs_srv1,1,nlenm,"obs_srv1_num");
  #ifndef NO_AD_INITIALIZE
    obs_srv1_num.initialize();
  #endif
  tmpo.allocate(1,2,1,nobs_srv1,"tmpo");
  #ifndef NO_AD_INITIALIZE
    tmpo.initialize();
  #endif
  tmpp.allocate(1,2,1,nobs_srv1,"tmpp");
  #ifndef NO_AD_INITIALIZE
    tmpp.initialize();
  #endif
  obs_srv1_bioms.allocate(1,2,1,nobs_srv1,"obs_srv1_bioms");
  #ifndef NO_AD_INITIALIZE
    obs_srv1_bioms.initialize();
  #endif
  obs_srv1_biom.allocate(1,nobs_srv1,"obs_srv1_biom");
  #ifndef NO_AD_INITIALIZE
    obs_srv1_biom.initialize();
  #endif
  pred_srv1_biom.allocate(styr,endyr,"pred_srv1_biom");
  #ifndef NO_AD_INITIALIZE
    pred_srv1_biom.initialize();
  #endif
  pred_srv1_bioms.allocate(1,2,styr,endyr,"pred_srv1_bioms");
  #ifndef NO_AD_INITIALIZE
    pred_srv1_bioms.initialize();
  #endif
  obs_catchdm_biom.allocate(1990,endyr,"obs_catchdm_biom");
  #ifndef NO_AD_INITIALIZE
    obs_catchdm_biom.initialize();
  #endif
  obs_catchdf_biom.allocate(1990,endyr,"obs_catchdf_biom");
  #ifndef NO_AD_INITIALIZE
    obs_catchdf_biom.initialize();
  #endif
  obs_catcht_biom.allocate(styr,endyr,"obs_catcht_biom");
  #ifndef NO_AD_INITIALIZE
    obs_catcht_biom.initialize();
  #endif
  obs_catchtot_biom.allocate(1990,endyr,"obs_catchtot_biom");
  #ifndef NO_AD_INITIALIZE
    obs_catchtot_biom.initialize();
  #endif
  tem_01.allocate(1,nobs_srv1,"tem_01");
  #ifndef NO_AD_INITIALIZE
    tem_01.initialize();
  #endif
  tem_02.allocate(styr,endyr,"tem_02");
  #ifndef NO_AD_INITIALIZE
    tem_02.initialize();
  #endif
  bio_01.allocate(1990,endyr,"bio_01");
  #ifndef NO_AD_INITIALIZE
    bio_01.initialize();
  #endif
  bio_02.allocate(1990,endyr,"bio_02");
  #ifndef NO_AD_INITIALIZE
    bio_02.initialize();
  #endif
  bio_03.allocate(styr,endyr,"bio_03");
  #ifndef NO_AD_INITIALIZE
    bio_03.initialize();
  #endif
  avgp.allocate(1,nlenm,"avgp");
  #ifndef NO_AD_INITIALIZE
    avgp.initialize();
  #endif
  avgpf.allocate(1,nlenm,"avgpf");
  #ifndef NO_AD_INITIALIZE
    avgpf.initialize();
  #endif
  avgpm.allocate(1,nlenm,"avgpm");
  #ifndef NO_AD_INITIALIZE
    avgpm.initialize();
  #endif
  sel_tem1.allocate(1,nlenm,"sel_tem1");
  #ifndef NO_AD_INITIALIZE
    sel_tem1.initialize();
  #endif
  sel_tem2.allocate(1,nlenm,"sel_tem2");
  #ifndef NO_AD_INITIALIZE
    sel_tem2.initialize();
  #endif
  biom_tmp.allocate(1,2,1,nobs_srv1,"biom_tmp");
  #ifndef NO_AD_INITIALIZE
    biom_tmp.initialize();
  #endif
  like_var_g.allocate("like_var_g");
  #ifndef NO_AD_INITIALIZE
  like_var_g.initialize();
  #endif
  like_var_rec.allocate("like_var_rec");
  #ifndef NO_AD_INITIALIZE
  like_var_rec.initialize();
  #endif
  q_tem.allocate(styr,endyr,"q_tem");
  #ifndef NO_AD_INITIALIZE
    q_tem.initialize();
  #endif
  qf_tem.allocate(styr,endyr,"qf_tem");
  #ifndef NO_AD_INITIALIZE
    qf_tem.initialize();
  #endif
  rec_len.allocate(1,2,1,nlenm,"rec_len");
  #ifndef NO_AD_INITIALIZE
    rec_len.initialize();
  #endif
  avg_rec.allocate(1,2,"avg_rec");
  #ifndef NO_AD_INITIALIZE
    avg_rec.initialize();
  #endif
  obs_lmales.allocate(1,nobs_srv1,"obs_lmales");
  #ifndef NO_AD_INITIALIZE
    obs_lmales.initialize();
  #endif
  obs_mmales.allocate(1,nobs_srv1,"obs_mmales");
  #ifndef NO_AD_INITIALIZE
    obs_mmales.initialize();
  #endif
  obs_mfemales.allocate(1,nobs_srv1,"obs_mfemales");
  #ifndef NO_AD_INITIALIZE
    obs_mfemales.initialize();
  #endif
  pre_mmales.allocate(styr,endyr,"pre_mmales");
  #ifndef NO_AD_INITIALIZE
    pre_mmales.initialize();
  #endif
  pre_mfemales.allocate(styr,endyr,"pre_mfemales");
  #ifndef NO_AD_INITIALIZE
    pre_mfemales.initialize();
  #endif
  rec_dev.allocate(1,2,styr+1,endyr,"rec_dev");
  #ifndef NO_AD_INITIALIZE
    rec_dev.initialize();
  #endif
  na_fishtime.allocate(1,2,styr,endyr,1,nlenm,"na_fishtime");
  #ifndef NO_AD_INITIALIZE
    na_fishtime.initialize();
  #endif
  popn_lmale.allocate(styr,endyr,"popn_lmale");
  #ifndef NO_AD_INITIALIZE
    popn_lmale.initialize();
  #endif
  popn_lmale_bio.allocate(styr,endyr,"popn_lmale_bio");
  #ifndef NO_AD_INITIALIZE
    popn_lmale_bio.initialize();
  #endif
  sumrecf.allocate("sumrecf");
  #ifndef NO_AD_INITIALIZE
  sumrecf.initialize();
  #endif
  sumrecm.allocate("sumrecm");
  #ifndef NO_AD_INITIALIZE
  sumrecm.initialize();
  #endif
  cv_rec.allocate(1,2,"cv_rec");
  #ifndef NO_AD_INITIALIZE
    cv_rec.initialize();
  #endif
  len_like_srv.allocate(1,3,"len_like_srv");
  #ifndef NO_AD_INITIALIZE
    len_like_srv.initialize();
  #endif
  tem_rf.allocate(styr,styr+5,"tem_rf");
  #ifndef NO_AD_INITIALIZE
    tem_rf.initialize();
  #endif
  tem_rm.allocate(styr,styr+5,"tem_rm");
  #ifndef NO_AD_INITIALIZE
    tem_rm.initialize();
  #endif
  catch_t.allocate(styr,endyr,"catch_t");
  #ifndef NO_AD_INITIALIZE
    catch_t.initialize();
  #endif
  catch_m.allocate(styr,endyr,"catch_m");
  #ifndef NO_AD_INITIALIZE
    catch_m.initialize();
  #endif
  catch_r.allocate(styr,endyr,"catch_r");
  #ifndef NO_AD_INITIALIZE
    catch_r.initialize();
  #endif
  t0.allocate("t0");
  #ifndef NO_AD_INITIALIZE
  t0.initialize();
  #endif
  t1.allocate("t1");
  #ifndef NO_AD_INITIALIZE
  t1.initialize();
  #endif
  t11.allocate(1,70,"t11");
  #ifndef NO_AD_INITIALIZE
    t11.initialize();
  #endif
  t2.allocate("t2");
  #ifndef NO_AD_INITIALIZE
  t2.initialize();
  #endif
  t3.allocate("t3");
  #ifndef NO_AD_INITIALIZE
  t3.initialize();
  #endif
  t4.allocate("t4");
  #ifndef NO_AD_INITIALIZE
  t4.initialize();
  #endif
  tt1.allocate(1,70,"tt1");
  #ifndef NO_AD_INITIALIZE
    tt1.initialize();
  #endif
  tt2.allocate(1,nlenm,"tt2");
  #ifndef NO_AD_INITIALIZE
    tt2.initialize();
  #endif
  tt3.allocate(1,nlenm,1,55,"tt3");
  #ifndef NO_AD_INITIALIZE
    tt3.initialize();
  #endif
  ttt.allocate(1,nlenm,1,nlenm+10,"ttt");
  #ifndef NO_AD_INITIALIZE
    ttt.initialize();
  #endif
  tt4.allocate("tt4");
  #ifndef NO_AD_INITIALIZE
  tt4.initialize();
  #endif
  tt5.allocate("tt5");
  #ifndef NO_AD_INITIALIZE
  tt5.initialize();
  #endif
  blast.allocate("blast");
  ref_na_fishtime.allocate(1,100,1,nlenm,"ref_na_fishtime");
  #ifndef NO_AD_INITIALIZE
    ref_na_fishtime.initialize();
  #endif
  ref_catch_male_ret.allocate(1,100,1,nlenm,"ref_catch_male_ret");
  #ifndef NO_AD_INITIALIZE
    ref_catch_male_ret.initialize();
  #endif
  ref_catch_lmale.allocate(1,100,1,nlenm,"ref_catch_lmale");
  #ifndef NO_AD_INITIALIZE
    ref_catch_lmale.initialize();
  #endif
  ref_na.allocate(1,100,1,nlenm,"ref_na");
  #ifndef NO_AD_INITIALIZE
    ref_na.initialize();
  #endif
  ref_na_m.allocate(1,2,1,100,1,nlenm,"ref_na_m");
  #ifndef NO_AD_INITIALIZE
    ref_na_m.initialize();
  #endif
  ref_catch.allocate(1,100,"ref_catch");
  #ifndef NO_AD_INITIALIZE
    ref_catch.initialize();
  #endif
  ref_catch_ret.allocate(1,100,"ref_catch_ret");
  #ifndef NO_AD_INITIALIZE
    ref_catch_ret.initialize();
  #endif
  ref_catch_disc.allocate(1,100,"ref_catch_disc");
  #ifndef NO_AD_INITIALIZE
    ref_catch_disc.initialize();
  #endif
  ref_catch_m.allocate(1,100,"ref_catch_m");
  #ifndef NO_AD_INITIALIZE
    ref_catch_m.initialize();
  #endif
  ref_F.allocate("ref_F");
  #ifndef NO_AD_INITIALIZE
  ref_F.initialize();
  #endif
  ref_Fret.allocate(1,nlenm,"ref_Fret");
  #ifndef NO_AD_INITIALIZE
    ref_Fret.initialize();
  #endif
  ref_Ftot.allocate(1,nlenm,"ref_Ftot");
  #ifndef NO_AD_INITIALIZE
    ref_Ftot.initialize();
  #endif
  ref_S.allocate(1,nlenm,"ref_S");
  #ifndef NO_AD_INITIALIZE
    ref_S.initialize();
  #endif
  ref_mbio.allocate(1,101,"ref_mbio");
  #ifndef NO_AD_INITIALIZE
    ref_mbio.initialize();
  #endif
  ref_mbio1.allocate(1,101,"ref_mbio1");
  #ifndef NO_AD_INITIALIZE
    ref_mbio1.initialize();
  #endif
  ref_mbio2.allocate(1,101,"ref_mbio2");
  #ifndef NO_AD_INITIALIZE
    ref_mbio2.initialize();
  #endif
  ref_mbio215.allocate(1,100,"ref_mbio215");
  #ifndef NO_AD_INITIALIZE
    ref_mbio215.initialize();
  #endif
  ref_mbio2151.allocate(1,100,"ref_mbio2151");
  #ifndef NO_AD_INITIALIZE
    ref_mbio2151.initialize();
  #endif
  ref_mbio2152.allocate(1,100,"ref_mbio2152");
  #ifndef NO_AD_INITIALIZE
    ref_mbio2152.initialize();
  #endif
  ref_totc.allocate(1,101,"ref_totc");
  #ifndef NO_AD_INITIALIZE
    ref_totc.initialize();
  #endif
  ref_catch_trawl.allocate(1,100,"ref_catch_trawl");
  #ifndef NO_AD_INITIALIZE
    ref_catch_trawl.initialize();
  #endif
  ref_retc.allocate(1,101,"ref_retc");
  #ifndef NO_AD_INITIALIZE
    ref_retc.initialize();
  #endif
  ref_moltp.allocate(1,nlenm,"ref_moltp");
  #ifndef NO_AD_INITIALIZE
    ref_moltp.initialize();
  #endif
  eb35.allocate("eb35");
  #ifndef NO_AD_INITIALIZE
  eb35.initialize();
  #endif
  f35.allocate("f35");
  #ifndef NO_AD_INITIALIZE
  f35.initialize();
  #endif
  f40.allocate("f40");
  #ifndef NO_AD_INITIALIZE
  f40.initialize();
  #endif
  i35.allocate("i35");
  #ifndef NO_AD_INITIALIZE
  i35.initialize();
  #endif
  i40.allocate("i40");
  #ifndef NO_AD_INITIALIZE
  i40.initialize();
  #endif
  ref_Ft.allocate("ref_Ft");
  #ifndef NO_AD_INITIALIZE
  ref_Ft.initialize();
  #endif
  ref_Ftc.allocate("ref_Ftc");
  #ifndef NO_AD_INITIALIZE
  ref_Ftc.initialize();
  #endif
  ref_sel_fit.allocate(1,nlenm,"ref_sel_fit");
  #ifndef NO_AD_INITIALIZE
    ref_sel_fit.initialize();
  #endif
  ref_sel_ret.allocate(1,nlenm,"ref_sel_ret");
  #ifndef NO_AD_INITIALIZE
    ref_sel_ret.initialize();
  #endif
  ref_sel_trawl.allocate(1,nlenm,"ref_sel_trawl");
  #ifndef NO_AD_INITIALIZE
    ref_sel_trawl.initialize();
  #endif
  tem_S.allocate(1,nlenm,"tem_S");
  #ifndef NO_AD_INITIALIZE
    tem_S.initialize();
  #endif
  tem_Stc.allocate(1,nlenm,"tem_Stc");
  #ifndef NO_AD_INITIALIZE
    tem_Stc.initialize();
  #endif
  ref_f.allocate("ref_f");
  #ifndef NO_AD_INITIALIZE
  ref_f.initialize();
  #endif
  ofl_f.allocate("ofl_f");
  #ifndef NO_AD_INITIALIZE
  ofl_f.initialize();
  #endif
  ref_sel_f.allocate(1,nlenm,"ref_sel_f");
  #ifndef NO_AD_INITIALIZE
    ref_sel_f.initialize();
  #endif
  ref_catch_f.allocate("ref_catch_f");
  #ifndef NO_AD_INITIALIZE
  ref_catch_f.initialize();
  #endif
  ofl_catch.allocate("ofl_catch");
  last_mmb.allocate("last_mmb");
  prj_na_fishtime.allocate(1,10,1,nlenm,"prj_na_fishtime");
  #ifndef NO_AD_INITIALIZE
    prj_na_fishtime.initialize();
  #endif
  prj_catch_male_ret.allocate(1,10,1,nlenm,"prj_catch_male_ret");
  #ifndef NO_AD_INITIALIZE
    prj_catch_male_ret.initialize();
  #endif
  prj_catch_lmale.allocate(1,10,1,nlenm,"prj_catch_lmale");
  #ifndef NO_AD_INITIALIZE
    prj_catch_lmale.initialize();
  #endif
  prj_na.allocate(1,10,1,nlenm,"prj_na");
  #ifndef NO_AD_INITIALIZE
    prj_na.initialize();
  #endif
  prj_na_f.allocate(1,10,1,nlenm,"prj_na_f");
  #ifndef NO_AD_INITIALIZE
    prj_na_f.initialize();
  #endif
  prj_na_m.allocate(1,2,1,10,1,nlenm,"prj_na_m");
  #ifndef NO_AD_INITIALIZE
    prj_na_m.initialize();
  #endif
  prj_catch.allocate(1,10,1,1000,"prj_catch");
  #ifndef NO_AD_INITIALIZE
    prj_catch.initialize();
  #endif
  prj_catch_ret.allocate(1,10,1,1000,"prj_catch_ret");
  #ifndef NO_AD_INITIALIZE
    prj_catch_ret.initialize();
  #endif
  prj_catch_disc.allocate(1,10,"prj_catch_disc");
  #ifndef NO_AD_INITIALIZE
    prj_catch_disc.initialize();
  #endif
  prj_catch_m.allocate(1,100,"prj_catch_m");
  #ifndef NO_AD_INITIALIZE
    prj_catch_m.initialize();
  #endif
  prj_F.allocate("prj_F");
  #ifndef NO_AD_INITIALIZE
  prj_F.initialize();
  #endif
  prj_Fret.allocate(1,nlenm,"prj_Fret");
  #ifndef NO_AD_INITIALIZE
    prj_Fret.initialize();
  #endif
  prj_Ft.allocate(1,nlenm,"prj_Ft");
  #ifndef NO_AD_INITIALIZE
    prj_Ft.initialize();
  #endif
  prj_Ftot.allocate(1,nlenm,"prj_Ftot");
  #ifndef NO_AD_INITIALIZE
    prj_Ftot.initialize();
  #endif
  prj_S.allocate(1,nlenm,"prj_S");
  #ifndef NO_AD_INITIALIZE
    prj_S.initialize();
  #endif
  prj_S0.allocate(1,nlenm,"prj_S0");
  #ifndef NO_AD_INITIALIZE
    prj_S0.initialize();
  #endif
  prj_Sf.allocate(1,nlenm,"prj_Sf");
  #ifndef NO_AD_INITIALIZE
    prj_Sf.initialize();
  #endif
  prj_Sret.allocate(1,nlenm,"prj_Sret");
  #ifndef NO_AD_INITIALIZE
    prj_Sret.initialize();
  #endif
  prj_mbio215.allocate(1,10,1,1000,"prj_mbio215");
  #ifndef NO_AD_INITIALIZE
    prj_mbio215.initialize();
  #endif
  prj_cf_totc.allocate(1,10,1,9,"prj_cf_totc");
  #ifndef NO_AD_INITIALIZE
    prj_cf_totc.initialize();
  #endif
  prj_catch_trawl.allocate(1,10,"prj_catch_trawl");
  #ifndef NO_AD_INITIALIZE
    prj_catch_trawl.initialize();
  #endif
  prj_cf_retc.allocate(1,10,1,9,"prj_cf_retc");
  #ifndef NO_AD_INITIALIZE
    prj_cf_retc.initialize();
  #endif
  prj_cf_mbio.allocate(1,10,1,9,"prj_cf_mbio");
  #ifndef NO_AD_INITIALIZE
    prj_cf_mbio.initialize();
  #endif
  prj_mean_mbio.allocate(1,10,"prj_mean_mbio");
  #ifndef NO_AD_INITIALIZE
    prj_mean_mbio.initialize();
  #endif
  prj_mean_retc.allocate(1,10,"prj_mean_retc");
  #ifndef NO_AD_INITIALIZE
    prj_mean_retc.initialize();
  #endif
  prj_mean_totc.allocate(1,10,"prj_mean_totc");
  #ifndef NO_AD_INITIALIZE
    prj_mean_totc.initialize();
  #endif
  tt6.allocate("tt6");
  #ifndef NO_AD_INITIALIZE
  tt6.initialize();
  #endif
  tt7.allocate("tt7");
  #ifndef NO_AD_INITIALIZE
  tt7.initialize();
  #endif
  tt8.allocate("tt8");
  #ifndef NO_AD_INITIALIZE
  tt8.initialize();
  #endif
  tt9.allocate("tt9");
  #ifndef NO_AD_INITIALIZE
  tt9.initialize();
  #endif
  tt10.allocate("tt10");
  #ifndef NO_AD_INITIALIZE
  tt10.initialize();
  #endif
  tt11.allocate("tt11");
  #ifndef NO_AD_INITIALIZE
  tt11.initialize();
  #endif
  www.allocate(1,1000,"www");
  #ifndef NO_AD_INITIALIZE
    www.initialize();
  #endif
  mate.allocate(1,nlenm,"mate");
  #ifndef NO_AD_INITIALIZE
    mate.initialize();
  #endif
  b25.allocate("b25");
  #ifndef NO_AD_INITIALIZE
  b25.initialize();
  #endif
  Ftcf.allocate(styr,endyr,"Ftcf");
  #ifndef NO_AD_INITIALIZE
    Ftcf.initialize();
  #endif
  Ftcm.allocate(styr,endyr,"Ftcm");
  #ifndef NO_AD_INITIALIZE
    Ftcm.initialize();
  #endif
  Stc.allocate(1,2,styr,endyr,1,nlenm,"Stc");
  #ifndef NO_AD_INITIALIZE
    Stc.initialize();
  #endif
  pred_catchtcm_biom.allocate(styr,endyr,"pred_catchtcm_biom");
  #ifndef NO_AD_INITIALIZE
    pred_catchtcm_biom.initialize();
  #endif
  pred_catchtcf_biom.allocate(styr,endyr,"pred_catchtcf_biom");
  #ifndef NO_AD_INITIALIZE
    pred_catchtcf_biom.initialize();
  #endif
  obs_catchtcm_biom.allocate(1,nobs_tc,"obs_catchtcm_biom");
  #ifndef NO_AD_INITIALIZE
    obs_catchtcm_biom.initialize();
  #endif
  obs_catchtcf_biom.allocate(1,nobs_tc,"obs_catchtcf_biom");
  #ifndef NO_AD_INITIALIZE
    obs_catchtcf_biom.initialize();
  #endif
  tem_catchtcm_biom.allocate(1,nobs_tc,"tem_catchtcm_biom");
  #ifndef NO_AD_INITIALIZE
    tem_catchtcm_biom.initialize();
  #endif
  tem_catchtcf_biom.allocate(1,nobs_tc,"tem_catchtcf_biom");
  #ifndef NO_AD_INITIALIZE
    tem_catchtcf_biom.initialize();
  #endif
  pred_p_tc_len_f.allocate(1,nobs_tc,1,nlenm,"pred_p_tc_len_f");
  #ifndef NO_AD_INITIALIZE
    pred_p_tc_len_f.initialize();
  #endif
  pred_p_tc_len_m.allocate(1,nobs_tc,1,nlenm,"pred_p_tc_len_m");
  #ifndef NO_AD_INITIALIZE
    pred_p_tc_len_m.initialize();
  #endif
  sel_tcf.allocate(1,nlenm,"sel_tcf");
  #ifndef NO_AD_INITIALIZE
    sel_tcf.initialize();
  #endif
  sel_tcm.allocate(1,nlenm,"sel_tcm");
  #ifndef NO_AD_INITIALIZE
    sel_tcm.initialize();
  #endif
  na_fishtime_tc.allocate(1,2,styr,endyr,1,nlenm,"na_fishtime_tc");
  #ifndef NO_AD_INITIALIZE
    na_fishtime_tc.initialize();
  #endif
  catch_like_tcm.allocate("catch_like_tcm");
  #ifndef NO_AD_INITIALIZE
  catch_like_tcm.initialize();
  #endif
  catch_like_tcf.allocate("catch_like_tcf");
  #ifndef NO_AD_INITIALIZE
  catch_like_tcf.initialize();
  #endif
  ttc.allocate("ttc");
  #ifndef NO_AD_INITIALIZE
  ttc.initialize();
  #endif
  ttc1.allocate("ttc1");
  #ifndef NO_AD_INITIALIZE
  ttc1.initialize();
  #endif
  n_bsfrf.allocate(1,2,1,nobs_bsfrf,"n_bsfrf");
  #ifndef NO_AD_INITIALIZE
    n_bsfrf.initialize();
  #endif
  am_bsfrf.allocate(1,nlenm,"am_bsfrf");
  #ifndef NO_AD_INITIALIZE
    am_bsfrf.initialize();
  #endif
  af_bsfrf.allocate(1,nlenm,"af_bsfrf");
  #ifndef NO_AD_INITIALIZE
    af_bsfrf.initialize();
  #endif
  bsfrf_like.allocate("bsfrf_like");
  #ifndef NO_AD_INITIALIZE
  bsfrf_like.initialize();
  #endif
  q_like.allocate("q_like");
  #ifndef NO_AD_INITIALIZE
  q_like.initialize();
  #endif
  q_tem1.allocate("q_tem1");
  #ifndef NO_AD_INITIALIZE
  q_tem1.initialize();
  #endif
  q_tem2.allocate("q_tem2");
  #ifndef NO_AD_INITIALIZE
  q_tem2.initialize();
  #endif
  q_tem3.allocate("q_tem3");
  #ifndef NO_AD_INITIALIZE
  q_tem3.initialize();
  #endif
  cp_f.allocate(3,nobs_bsfrf,1,nlenm,"cp_f");
  #ifndef NO_AD_INITIALIZE
    cp_f.initialize();
  #endif
  cp_m.allocate(3,nobs_bsfrf,1,nlenm,"cp_m");
  #ifndef NO_AD_INITIALIZE
    cp_m.initialize();
  #endif
  pred_p_bsfrf_f.allocate(1,nobs_bsfrf,1,nlenm,"pred_p_bsfrf_f");
  #ifndef NO_AD_INITIALIZE
    pred_p_bsfrf_f.initialize();
  #endif
  pred_p_bsfrf_m.allocate(1,nobs_bsfrf,1,nlenm,"pred_p_bsfrf_m");
  #ifndef NO_AD_INITIALIZE
    pred_p_bsfrf_m.initialize();
  #endif
  obs_b_bsfrf.allocate(1,2,1,nobs_bsfrf,"obs_b_bsfrf");
  #ifndef NO_AD_INITIALIZE
    obs_b_bsfrf.initialize();
  #endif
  size_srv.allocate(1,2,1,nobs_srv1,"size_srv");
  #ifndef NO_AD_INITIALIZE
    size_srv.initialize();
  #endif
  size_fish_ret.allocate(1,nobs_fish,"size_fish_ret");
  #ifndef NO_AD_INITIALIZE
    size_fish_ret.initialize();
  #endif
  size_fish_discf.allocate(1,nobs_fish_discf,"size_fish_discf");
  #ifndef NO_AD_INITIALIZE
    size_fish_discf.initialize();
  #endif
  size_fish_discm.allocate(1,nobs_fish_discm,"size_fish_discm");
  #ifndef NO_AD_INITIALIZE
    size_fish_discm.initialize();
  #endif
  s_srv.allocate(1,2,1,nobs_srv1,"s_srv");
  #ifndef NO_AD_INITIALIZE
    s_srv.initialize();
  #endif
  s_fish.allocate(1,nobs_fish,"s_fish");
  #ifndef NO_AD_INITIALIZE
    s_fish.initialize();
  #endif
  s_fish_discf.allocate(1,nobs_fish_discf,"s_fish_discf");
  #ifndef NO_AD_INITIALIZE
    s_fish_discf.initialize();
  #endif
  s_fish_discm.allocate(1,nobs_fish_discm,"s_fish_discm");
  #ifndef NO_AD_INITIALIZE
    s_fish_discm.initialize();
  #endif
  s_trawl.allocate(1,2,1,nobs_trawl,"s_trawl");
  #ifndef NO_AD_INITIALIZE
    s_trawl.initialize();
  #endif
  s_tc.allocate(1,2,1,nobs_tc,"s_tc");
  #ifndef NO_AD_INITIALIZE
    s_tc.initialize();
  #endif
  s_bsfrf.allocate(1,2,1,nobs_bsfrf,"s_bsfrf");
  #ifndef NO_AD_INITIALIZE
    s_bsfrf.initialize();
  #endif
  ep68.allocate(1,3,1,nlenm,"ep68");
  #ifndef NO_AD_INITIALIZE
    ep68.initialize();
  #endif
  first_yr_like.allocate("first_yr_like");
  #ifndef NO_AD_INITIALIZE
  first_yr_like.initialize();
  #endif
  lbio.allocate("lbio");
}

void model_parameters::preliminary_calculations(void)
{

#if defined(USE_ADPVM)

  admaster_slave_variable_interface(*this);

#endif
  cout<<"starting prelim calcs"<<endl;
 for (i=1;i<=nobs_srv1;i++)
 {
   s_srv(1,i) = 0.5*obs_s_srv1(1,i);
   if (s_srv(1,i)>nsamples_srv1(1,i)) s_srv(1,i) = nsamples_srv1(1,i);
   s_srv(2,i) = 0.5*obs_s_srv1(2,i);
   if (s_srv(2,i)>nsamples_srv1(2,i)) s_srv(2,i) = nsamples_srv1(2,i);
 }
 for (i=1;i<=nobs_bsfrf;i++)
 {
   s_bsfrf(1,i) = 0.5*obs_s_bsfrf(1,i);
   if (s_bsfrf(1,i)>nsamples_bsfrf(1,i)) s_bsfrf(1,i) = nsamples_bsfrf(1,i);
   s_bsfrf(2,i) = 0.5*obs_s_bsfrf(2,i);
   if (s_bsfrf(2,i)>nsamples_bsfrf(2,i)) s_bsfrf(2,i) = nsamples_bsfrf(2,i);
 }
 for (i=1;i<=nobs_fish;i++)
 {
   s_fish(i) = 0.1*obs_s_fish_ret(i);
   if (s_fish(i)>nsamples_fish(i))  s_fish(i) = nsamples_fish(i);
 }
 for (i=1;i<=nobs_fish_discm;i++)
 {
   s_fish_discm(i) = 0.1*obs_s_fish_discm(i);
   if (s_fish_discm(i)>nsamples_fish_discm(i)) s_fish_discm(i) = nsamples_fish_discm(i);
 }
 for (i=1;i<=nobs_fish_discf;i++)
 {
   s_fish_discf(i) = 0.1*obs_s_fish_discf(i);
   if (s_fish_discf(i)>nsamples_fish_discf(i)) s_fish_discf(i) = nsamples_fish_discf(i);
 }
 for (i=1;i<=nobs_trawl;i++)
 {
   s_trawl(1,i) = 0.1*obs_s_trawl(1,i);
   if (s_trawl(1,i)>nsamples_trawl(1,i)) s_trawl(1,i) = nsamples_trawl(1,i);
   s_trawl(2,i) = 0.1*obs_s_trawl(2,i);
   if (s_trawl(2,i)>nsamples_trawl(2,i)) s_trawl(2,i) = nsamples_trawl(2,i);
 }
 for (i=1;i<=nobs_tc;i++)
 {
   s_tc(1,i) = 0.1*obs_s_tc(1,i);
   if (s_tc(1,i)>nsamples_tc(1,i)) s_tc(1,i) = nsamples_tc(1,i);
   s_tc(2,i) = 0.1*obs_s_tc(2,i);
   if (s_tc(2,i)>nsamples_tc(2,i)) s_tc(2,i) = nsamples_tc(2,i);
 }
 q_tem1 = sur_q(2)*sur_q(2);                                  //variance estimates for maximum catchability
 q_tem2 = 0.0625*0.0625;
 cp_f = elem_prod(obs_cv_bsfrf_f,obs_cv_bsfrf_f);
 cp_m = elem_prod(obs_cv_bsfrf_m,obs_cv_bsfrf_m);
 b25 = 0.25*b35;
 mat1 = mat;
 mat1(12) = 0.0; mat1(13) = 0.0;
 mat2 = mat;
 mat2(10) = 1.0; mat2(11) = 1.0;
 for(i=styr; i<=endyr; i++)
 {
   catch_trawl(i)=catch_trawl(i)*m_trawl;
   catch_disc(1,i)=catch_disc(1,i)*m_disc;
   catch_disc(2,i)=catch_disc(2,i)*m_disc;
   catch_tot(i)=catch_numbers(i)+catch_disc(2,i);
 }
 for(i=1; i<=nobs_tc; i++)
 {
    catch_tc(1,i)=catch_tc(1,i)*m_tc;
    catch_tc(2,i)=catch_tc(2,i)*m_tc;
 }
 for (i=1; i<= nobs_trawl; i++)
 {
   obs_catcht_biom(yrs_trawl(i))=(obs_p_trawl(1,i)*catch_trawl(yrs_trawl(i)))*wt(1)+(obs_p_trawl(2,i)*catch_trawl(yrs_trawl(i)))*wt(2);
 }
 avgpf=0;
 avgpm=0;
 for(i=1; i<= nobs_trawl; i++)
 {
   avgpf+=obs_p_trawl(1,i);
   avgpm+=obs_p_trawl(2,i);
 }
 avgpf=avgpf/nobs_trawl;
 avgpm=avgpm/nobs_trawl;
 obs_catcht_biom(1993)=avgpf*catch_trawl(1993)*wt(1)+avgpm*catch_trawl(1993)*wt(2);
 obs_srv1_num.initialize();
 obs_srv1_biom.initialize();
 obs_srv1_bioms.initialize();
 for (i=1; i<=nobs_srv1; i++)
 {
   obs_srv1_num(1,i) += obs_p_srv1_len_f(i)*obs_srv1(i);
   obs_srv1_num(2,i) += (obs_p_srv1_len_m(1,i)+obs_p_srv1_len_m(2,i))*obs_srv1(i);
   obs_srv1_bioms(1,i) += obs_p_srv1_len_f(i)*obs_srv1(i)*wt(1);
   obs_srv1_bioms(2,i) += (obs_p_srv1_len_m(1,i)+obs_p_srv1_len_m(2,i))*obs_srv1(i)*wt(2);
   obs_srv1_biom(i) = obs_srv1_bioms(1,i)+obs_srv1_bioms(2,i);
 }
 for (i=1; i<= nobs_srv1; i++)
 {
   for (j=1; j<=nlenm; j++)
   {
      obs_p_srv1_len_m(1,i,j)= obs_p_srv1_len_m(1,i,j)+obs_p_srv1_len_m(2,i,j);
      obs_p_srv1_len_m(2,i,j) = 0.0;
   }
 }
 obs_catchdm_biom.initialize();
 obs_catchdf_biom.initialize();
 avgp.initialize();
 avgpf.initialize();
 for(i=1;i<=nobs_fish_discm;i++)
 {
   obs_catchdf_biom(yrs_fish_discm(i))=catch_disc(1,yrs_fish_discm(i))*obs_p_fish_discf(i)*wt(1);
   obs_catchdm_biom(yrs_fish_discm(i))=catch_disc(2,yrs_fish_discm(i))*obs_p_fish_discm(i)*wt(2);
 }
 obs_catchdf_biom(1994)=1.87659459; obs_catchdf_biom(1995)=1.611640408; obs_catchdm_biom(1994)=3.81193721; obs_catchdm_biom(1995)=3.273734281;
 for(i=yrs_fish_discf(1);i<=endyr;i++)
 {
   obs_catchtot_biom(i)=obs_catchdm_biom(i)+catch_ret(i);
 }
 obs_catchtcm_biom.initialize();
 obs_catchtcf_biom.initialize();
 for(i=1;i<=nobs_tc;i++)
 {
   obs_catchtcf_biom(i)=catch_tc(1,i)*obs_p_tc_len_f(i)*wt(1);
   obs_catchtcm_biom(i)=catch_tc(2,i)*obs_p_tc_len_m(i)*wt(2);
 }
 q_tem = 1.0;     //setting maximum survey catchability to be 1 for all years until estimated later.
 qf_tem = 1.0;     //setting maximum survey catchability to be 1 for all years until estimated later.
   sel_srv1(1) = 1.0/(1.0+exp(-(0.354+0.0054*length_bins)));     //female survey catchability 1970-1972
   sel_srv1(2) = 1.0/(1.0+exp(-(-0.7366+0.0178*length_bins)));   //male survey catchability   1970-1972
 sel_srv2(1) = 1.0/(1.0+exp(-(0.354+0.0054*length_bins)));     //female survey catchability 1973-1981
 sel_srv2(2) = 1.0/(1.0+exp(-(-0.7366+0.0178*length_bins)));   //male survey catchability   1973-1981
 sel_srv3(1) = 1.0/(1.0+exp(-(0.354+0.0054*length_bins)));     //female survey catchability 1982-2008
 sel_srv3(2) = 1.0/(1.0+exp(-(-0.7366+0.0178*length_bins)));   //male survey catchability   1982-2008
 sel_ret=0.0;
 for(i=1;i<=nobs_bsfrf;i++)
 {
   obs_b_bsfrf(1,i)=obs_n_bsfrf(i)*obs_p_bsfrf_f(i)*wt(1);
   obs_b_bsfrf(2,i)=obs_n_bsfrf(i)*obs_p_bsfrf_m(i)*wt(2);
 }
  cout<<"end prelim calcs"<<endl;
}

void model_parameters::userfunction(void)
{
  f =0.0;
   get_moltingp_maturep();
   get_growth();
   get_selectivity();
   get_mortality();
   get_numbers_at_len();
   get_catch_at_len();
  if (current_phase()>5)
  {
   get_effective_sample_sizes();
  }
  if (sd_phase())
  {
   get_reference_points();
 //projection();
  }
   evaluate_the_objective_function();
}

void model_parameters::get_growth(void)
{
  len_len.initialize();
  rec_len.initialize();
  t11.initialize();
      betar = mfexp(log_betar(1));
      ii = (nr-2)*slt;
      ilen = slt;
      t2 = 0.0;
      t4 = alphar1/betar;
      t3 = (t4-1.0)*log(alphar1)-alphar1/betar-t4*log(betar);
      for (j = 1; j<=ii;j++)
      {
        tt5 = double(j-1)+ilen1;
        t11(j) = (t4-1.0)*log(tt5)-tt5/betar-t4*log(betar)-t3;
        if (t11(j) < -1.0e30) t11(j)=-1.0e30;
        t11(j) = mfexp(t11(j));
        t2 = t2 + t11(j);
      }
      for (j=1;j<=nr-0;j++)
      {
        for (i=1;i<=ilen;i++) rec_len(1,j) += t11((j-1)*ilen+i)/t2;
      }
      betar = mfexp(log_betar(2));
      ii = nr*slt;
      ilen = slt;
      t2 = 0.0;
      t4 = alphar2/betar;
      t3 = (t4-1.0)*log(alphar2)-alphar2/betar-t4*log(betar);
      for (j = 1; j<=ii;j++)
      {
        tt5 = double(j-1)+ilen1;
        t11(j) = (t4-1.0)*log(tt5)-tt5/betar-t4*log(betar)-t3;
        if (t11(j) < -1.0e30) t11(j)=-1.0e30;
        t11(j) = mfexp(t11(j));
        t2 = t2 + t11(j);
      }
      for (j=1;j<=nr;j++)
      {
        for (i=1;i<=ilen;i++) rec_len(2,j) += t11((j-1)*ilen+i)/t2;
      }
   tt3.initialize();
   ttt.initialize();
   betal = mfexp(log_betal(1));
   for (j=1;j<=nlenf;j++)
   {
     tt1(j) = g(1,j)/betal;
     tt2(j) = 0.0;
     tt4 = (tt1(j)-1.0)*log(g(1,j))-g(1,j)/betal-tt1(j)*log(betal);
     for (i=ggf(1,j);i<=ggf(2,j);i++)
     {
       tt5 = double(i);
       tt3(j,i)=(tt1(j)-1.0)*log(tt5)-tt5/betal-tt1(j)*log(betal)-tt4;
       if (tt3(j,i) < -1.0e30) tt3(j,i) = -1.0e30;
       tt3(j,i) = mfexp(tt3(j,i));
       tt2(j) = tt2(j) + tt3(j,i);
     }
   }
   for (j=1;j<=nlenf;j++)
   {
     for (i=ggf(1,j);i<=ggf(2,j);i++) tt3(j,i) = tt3(j,i)/tt2(j);
   }
   for (j=1;j<=nlenf;j++)
   {
     for (i=j;i<=j+10;i++)
     {
       ii = (i-j)*slt;
       if (ii == 0)
       {
         ttt(j,i)=tt3(j,1)+tt3(j,2)+tt3(j,3)*0.5;
       }
       else
       {
         ttt(j,i) = tt3(j,ii-2)*0.5+tt3(j,ii-1)+tt3(j,ii)+tt3(j,ii+1)+tt3(j,ii+2)+tt3(j,ii+3)*0.5;
       }
     }
     for (i=nlenf+1;i<=nlenf+10;i++) ttt(j,nlenf) = ttt(j,nlenf) + ttt(j,i);
   }
   for (j=1;j<=nlenf;j++)
   {
     for (i=1; i<=nlenf;i++) len_len(1,j,i) = ttt(j,i);
   }
   tt3.initialize();
   ttt.initialize();
   betal = mfexp(log_betal(1));
   for (j=1;j<=nlenf;j++)
   {
     tt1(j) = g(2,j)/betal;
     tt2(j) = 0.0;
     tt4 = (tt1(j)-1.0)*log(g(2,j))-g(2,j)/betal-tt1(j)*log(betal);
     for (i=ggf(1,j);i<=ggf(2,j);i++)
     {
       tt5 = double(i);
       tt3(j,i)=(tt1(j)-1.0)*log(tt5)-tt5/betal-tt1(j)*log(betal)-tt4;
       if (tt3(j,i) < -1.0e30) tt3(j,i) = -1.0e30;
       tt3(j,i) = mfexp(tt3(j,i));
       tt2(j) = tt2(j) + tt3(j,i);
     }
   }
   for (j=1;j<=nlenf;j++)
   {
     for (i=ggf(1,j);i<=ggf(2,j);i++) tt3(j,i) = tt3(j,i)/tt2(j);
   }
   for (j=1;j<=nlenf;j++)
   {
     for (i=j;i<=j+10;i++)
     {
       ii = (i-j)*slt;
       if (ii == 0)
       {
         ttt(j,i)=tt3(j,1)+tt3(j,2)+tt3(j,3)*0.5;
       }
       else
       {
         ttt(j,i) = tt3(j,ii-2)*0.5+tt3(j,ii-1)+tt3(j,ii)+tt3(j,ii+1)+tt3(j,ii+2)+tt3(j,ii+3)*0.5;
       }
     }
     for (i=nlenf+1;i<=nlenf+10;i++) ttt(j,nlenf) = ttt(j,nlenf) + ttt(j,i);
   }
   for (j=1;j<=nlenf;j++)
   {
     for (i=1; i<=nlenf;i++) len_len(2,j,i) = ttt(j,i);
   }
   tt3.initialize();
   ttt.initialize();
   betal = mfexp(log_betal(1));
   for (j=1;j<=nlenf;j++)
   {
     tt1(j) = g(3,j)/betal;
     tt2(j) = 0.0;
     tt4 = (tt1(j)-1.0)*log(g(3,j))-g(3,j)/betal-tt1(j)*log(betal);
     for (i=ggf(1,j);i<=ggf(2,j);i++)
     {
       tt5 = double(i);
       tt3(j,i)=(tt1(j)-1.0)*log(tt5)-tt5/betal-tt1(j)*log(betal)-tt4;
       if (tt3(j,i) < -1.0e30) tt3(j,i) = -1.0e30;
       tt3(j,i) = mfexp(tt3(j,i));
       tt2(j) = tt2(j) + tt3(j,i);
     }
   }
   for (j=1;j<=nlenf;j++)
   {
     for (i=ggf(1,j);i<=ggf(2,j);i++) tt3(j,i) = tt3(j,i)/tt2(j);
   }
   for (j=1;j<=nlenf;j++)
   {
     for (i=j;i<=j+10;i++)
     {
       ii = (i-j)*slt;
       if (ii == 0)
       {
         ttt(j,i)=tt3(j,1)+tt3(j,2)+tt3(j,3)*0.5;
       }
       else
       {
         ttt(j,i) = tt3(j,ii-2)*0.5+tt3(j,ii-1)+tt3(j,ii)+tt3(j,ii+1)+tt3(j,ii+2)+tt3(j,ii+3)*0.5;
       }
     }
     for (i=nlenf+1;i<=nlenf+10;i++) ttt(j,nlenf) = ttt(j,nlenf) + ttt(j,i);
   }
   for (j=1;j<=nlenf;j++)
   {
     for (i=1; i<=nlenf;i++) len_len(3,j,i) = ttt(j,i);
   }
   tt3.initialize();
   ttt.initialize();
   betal = mfexp(log_betal(2));
   for (j=1;j<=nlenm;j++)
   {
     tt1(j) = g(4,j)/betal;
     tt2(j) = 0.0;
     tt4 = (tt1(j)-1.0)*log(g(4,j))-g(4,j)/betal-tt1(j)*log(betal);
     for (i=ggm(1,j);i<=ggm(2,j);i++)
     {
       tt5 = double(i);
       tt3(j,i)=(tt1(j)-1.0)*log(tt5)-tt5/betal-tt1(j)*log(betal)-tt4;
       if (tt3(j,i) < -1.0e30) tt3(j,i) = -1.0e30;
       tt3(j,i) = mfexp(tt3(j,i));
       tt2(j) = tt2(j) + tt3(j,i);
     }
   }
   for (j=1;j<=nlenm;j++)
   {
     for (i=ggm(1,j);i<=ggm(2,j);i++) tt3(j,i) = tt3(j,i)/tt2(j);
   }
   for (j=1;j<=nlenm;j++)
   {
     for (i=j;i<=j+10;i++)
     {
       ii = (i-j)*slt;
       if (ii == 0)
       {
         ttt(j,i)=tt3(j,1)+tt3(j,2)+tt3(j,3)*0.5;
       }
       else
       {
         ttt(j,i) = tt3(j,ii-2)*0.5+tt3(j,ii-1)+tt3(j,ii)+tt3(j,ii+1)+tt3(j,ii+2)+tt3(j,ii+3)*0.5;
       }
     }
     for (i=nlenm+1;i<=nlenm+10;i++) ttt(j,nlenm) = ttt(j,nlenm) + ttt(j,i);
   }
   for (j=1;j<=nlenm;j++)
   {
     for (i=1; i<=nlenm;i++) len_len(4,j,i) = ttt(j,i);
   }
}

void model_parameters::get_moltingp_maturep(void)
{
 for (iy=styr;iy<=endyr;iy++)
 {
   for(j=1;j<=nlenm;j++)
   {
    moltp(iy,j)=1-(1./(1.+mfexp(-1.*moltp_am(mo(iy))*(length_bins(j)-mfexp(log_moltp_bm(mo(iy)))))));
   }
 }
}

void model_parameters::get_selectivity(void)
{
  for (j=6;j<=13;j++) sel_ret0(j) = ret_a  + ret_b*length_bins(j);
  sel_ret0(14)=sel_ret0(13)+ret_c*5.0; sel_ret0(15)=sel_ret0(14)+ret_c*5.0; sel_ret0(16)=sel_ret0(15)+ret_c*5.0;
  for (j=6;j<=16;j++) if (sel_ret0(j) < 0.0) sel_ret0(j) = 0.0;
  for (j=6;j<=14;j++) sel_ret(j) = ret_a  + ret_b*length_bins(j);
  sel_ret(15)=sel_ret(14)+ret_c*5.0; sel_ret(16)=sel_ret(15)+ret_c*5.0;
  for (j=6;j<=16;j++) if (sel_ret(j) < 0.0) sel_ret(j) = 0.0;
  for (iy=styr;iy<=endyr;iy++)
  {
     fish_sel50(iy)=mfexp(log_avg_sel50)+sel50_dev(iy);
     for (j=1;j<=nlenm;j++)
     {
       sel_fit(iy,j)=1./(1.+mfexp(-1.*fish_slope*(length_bins(j)-fish_sel50(iy))));
       sel(iy,j)=sel_ret(j)+sel_fit(iy,j);
     }
  }
  for (j=1;j<=nlenm;j++)
  {
     sel_tem1(j)=1./(1.+mfexp(-1.*fish_disc_slope_f*(length_bins(j)-mfexp(log_fish_disc_sel50_f))));
     sel_tem2(j)=1./(1.+mfexp(-1.*fish_disc_slope_t*(length_bins(j)-mfexp(log_fish_disc_sel50_t))));
     sel_tcf(j)=1./(1.+mfexp(-1.*fish_tc_slope_f*(length_bins(j)-mfexp(log_fish_tc_sel50_f))));
     sel_tcm(j)=1./(1.+mfexp(-1.*fish_tc_slope_m*(length_bins(j)-mfexp(log_fish_tc_sel50_m))));
  }
    maxsel_fish = max(sel_tem1);
    sel_tem1 = sel_tem1/maxsel_fish;
    maxsel_fish = max(sel_tem2);
    sel_tem2 = sel_tem2/maxsel_fish;
    maxsel_fish = max(sel_tcf);
    sel_tcf = sel_tcf/maxsel_fish;
    maxsel_fish = max(sel_tcm);
    sel_tcm = sel_tcm/maxsel_fish;
  for(iy=styr;iy<=endyr;iy++)
  {
     maxsel_fish=max(sel(iy));
     sel(iy)=sel(iy)/maxsel_fish;
     maxsel_fish=max(sel_fit(iy));
     sel_fit(iy)=sel_fit(iy)/maxsel_fish;
     if (iy==2005)  sel_fit(iy) = sel_fit(iy) - hg1*m_disc*sel_fit(iy);
     if (iy==2006)  sel_fit(iy) = sel_fit(iy) - hg2*m_disc*sel_fit(iy);
     if (iy==2007)  sel_fit(iy) = sel_fit(iy) - hg3*m_disc*sel_fit(iy);
     if (iy==2008)  sel_fit(iy) = sel_fit(iy) - hg4*m_disc*sel_fit(iy);
     if (iy==2009)  sel_fit(iy) = sel_fit(iy) - hg5*m_disc*sel_fit(iy);
     if (iy==2010)  sel_fit(iy) = sel_fit(iy) - hg6*m_disc*sel_fit(iy);
     if (iy==2011)  sel_fit(iy) = sel_fit(iy) - hg7*m_disc*sel_fit(iy);
     if (iy==2012)  sel_fit(iy) = sel_fit(iy) - hg8*m_disc*sel_fit(iy);
     if (iy==2013)  sel_fit(iy) = sel_fit(iy) - hg9*m_disc*sel_fit(iy);
     if (iy==2014)  sel_fit(iy) = sel_fit(iy) - hg10*m_disc*sel_fit(iy);
     if (iy==2015)  sel_fit(iy) = sel_fit(iy) - hg11*m_disc*sel_fit(iy);
     for (j=1;j<=nlenm;j++)
     {
        if (sel(iy,j)<sel_fit(iy,j))
        {
           sel(iy,j)=sel_fit(iy,j);
           if (j<15) sel(iy,j)=sel_fit(iy,j)+0.005;
        }
     }
     sel_discf(iy) = sel_tem1;
     sel_trawl_f(iy) = sel_tem2;
     sel_trawl_m(iy) = sel_tem2;
  }
  for(iy=1;iy<=nobs_fish_discf;iy++)
  {
     t0=mfexp(log_fish_disc_sel50_f)+fish_disc_sel50_dev_f(iy);
     for (j=1;j<=nlenm;j++)
     {
       sel_discf(yrs_fish_discf(iy),j)=1./(1.+mfexp(-1.*fish_disc_slope_f*(length_bins(j)-t0)));
     }
     maxsel_fish = max(sel_discf(yrs_fish_discf(iy)));
     sel_discf(yrs_fish_discf(iy)) = sel_discf(yrs_fish_discf(iy))/maxsel_fish;
  }
  for(iy=1;iy<=nobs_trawl;iy++)
  {
     t2=mfexp(log_fish_disc_sel50_t)+fish_disc_sel50_dev_tm(iy);
     for (j=1;j<=nlenm;j++)
     {
       sel_trawl_m(yrs_trawl(iy),j)=1./(1.+mfexp(-1.*fish_disc_slope_t*(length_bins(j)-t2)));
     }
     maxsel_fish = max(sel_trawl_m(yrs_trawl(iy)));
     sel_trawl_m(yrs_trawl(iy)) = sel_trawl_m(yrs_trawl(iy))/maxsel_fish;
     sel_trawl_f(yrs_trawl(iy)) = sel_trawl_m(yrs_trawl(iy));
  }
 qf2 = qm2;
 srv1_slope_m = log(1.0/1.0*(1.0+exp(-1.0*srv1_slope_f*(67.5-mfexp(log_srv1_sel50_f))))-1.0)/(mfexp(log_srv2_sel50_m)-67.5);
 if (srv1_slope_m < 0.0) srv1_slope_m = srv1_slope_f;
 sel_srv1(1) = 1.0/(1.0+exp(-1.*srv1_slope_f*(length_bins-mfexp(log_srv1_sel50_f))));     //female survey catchability
 sel_srv1(2) = 1.0/(1.0+exp(-1.*srv1_slope_m*(length_bins-mfexp(log_srv1_sel50_m))));     //male survey catchability
 srv1_slope_m = log(qm2/qf2*(1.0+exp(-1.0*srv2_slope_f*(67.5-mfexp(log_srv2_sel50_f))))-1.0)/(mfexp(log_srv2_sel50_m)-67.5);
 if (srv1_slope_m < 0.0) srv1_slope_m = srv2_slope_f;
 sel_srv2(1) = 1.0/(1.0+exp(-1.*srv2_slope_f*(length_bins-mfexp(log_srv2_sel50_f))));     //female survey catchability
 sel_srv2(2) = 1.0/(1.0+exp(-1.*srv1_slope_m*(length_bins-mfexp(log_srv2_sel50_m))));     //male survey catchability
 srv1_slope_m = log(qm2/qf2*(1.0+exp(-1.0*srv3_slope_f*(67.5-mfexp(log_srv3_sel50_f))))-1.0)/(mfexp(log_srv3_sel50_m)-67.5);
 if (srv1_slope_m < 0.0) srv1_slope_m = srv3_slope_f;
 sel_srv3(1) = 1.0/(1.0+exp(-1.*srv3_slope_f*(length_bins-mfexp(log_srv3_sel50_f))));     //female survey catchability
 sel_srv3(2) = 1.0/(1.0+exp(-1.*srv1_slope_m*(length_bins-mfexp(log_srv3_sel50_m))));     //male survey catchability
 maxsel_fish = max(sel_srv1(1));
 sel_srv1(1) = sel_srv1(1)*qm3/maxsel_fish;
 maxsel_fish = max(sel_srv1(2));
 sel_srv1(2) = sel_srv1(2)*qm3/maxsel_fish;
 maxsel_fish = max(sel_srv2(1));
 sel_srv2(1) = sel_srv2(1)*qf2/maxsel_fish;
 maxsel_fish = max(sel_srv2(2));
 sel_srv2(2) = sel_srv2(2)*qm2/maxsel_fish;
 maxsel_fish = max(sel_srv3(1));
 sel_srv3(1) = sel_srv3(1)*qf2/maxsel_fish;
 maxsel_fish = max(sel_srv3(2));
 sel_srv3(2) = sel_srv3(2)*qm2/maxsel_fish;
 if (current_phase()<survsel_phase)
 {
    sel_srv2(1) = 1.0/(1.0+exp(-(0.354+0.0054*length_bins)));
    sel_srv2(2) = 1.0/(1.0+exp(-(-0.7366+0.0178*length_bins)));
    sel_srv3(1) = 1.0/(1.0+exp(-(0.354+0.0054*length_bins)));
    sel_srv3(2) = 1.0/(1.0+exp(-(-0.7366+0.0178*length_bins)));
 }
 for(iy=styr;iy<=styr+6;iy++)
 {
   sel_srv(1,iy) = sel_srv2(1);
   sel_srv(2,iy) = sel_srv2(2);
             //   if (current_phase()>4) sel_srv(1,iy) = sel_srv(1,iy)*sf(iy);
 }
 for(iy=styr+7;iy<=endyr;iy++)
 {
   sel_srv(1,iy) = sel_srv3(1);
   sel_srv(2,iy) = sel_srv3(2);
             //   if (current_phase()>4) sel_srv(1,iy) = sel_srv(1,iy)*sf(iy);
     if (current_phase()>survsel_phase)
     {
        sel_srv(1,iy) = elem_prod(sel_srv3(1),sel_srv1(1));
        sel_srv(2,iy) = elem_prod(sel_srv3(2),sel_srv1(2));
     }
 }
}

void model_parameters::get_mortality(void)
{
 M = M0;
 for (i=styr;i<=endyr;i++)
 {
    if (Mn(1,i)==2) M(1,i) = M0 + Mf;     //high natural mortality for females during the early 1980s
    if (Mn(2,i)==2) M(2,i) = M0 + Mm;     //high natural mortality for males during the early 1980s
    if (Mn(1,i)==3) M(1,i) = M0 + Mf1;     //high natural mortality for females during late 1970s, late 1980s and early 1990s
    if (Mn(2,i)==3) M(2,i) = M0 + Mm1;     //high natural mortality for males during late 1970s, late 1980s and early 1990s
 }
 fmort = mfexp(log_avg_fmort+fmort_dev);
 for (i=yrs_fish_discf(1); i<=endyr; i++) fmortdf(i)=mfexp(log_avg_fmort+fmort_dev(i)+fmortdf_dev(i))*factor_fmortdf;
 for (i=yrs_fish_discf(1); i<=endyr; i++) fmortdm(i)=mfexp(log_avg_fmort+fmort_dev(i)+fmortdm_dev(i));
 for (i=1; i<=13; i++) ff_tem(i) = fmortdf(yrs_fish_discf(i))/fmort(yrs_fish_discf(i));
 for (i=1; i<=12; i++)
 {
   for (j=i+1; j<=13; j++)
   {
     if (ff_tem(j) < ff_tem(i))
     {
       t0 = ff_tem(i);
       ff_tem(i) = ff_tem(j);
       ff_tem(j) = t0;
     }
   }
 }
 t0 = 0.0;
 t0 = ff_tem(7);
 for (i=1; i<=13; i++) ff_tem(i) = fmortdm(yrs_fish_discf(i))/fmort(yrs_fish_discf(i));
 for (i=1; i<=12; i++)
 {
   for (j=i+1; j<=13; j++)
   {
     if (ff_tem(j) < ff_tem(i))
     {
       t1 = ff_tem(i);
       ff_tem(i) = ff_tem(j);
       ff_tem(j) = t1;
     }
   }
 }
 t1 = 0.0;
  t1 = ff_tem(7);
 for (i=styr; i<yrs_fish_discf(1); i++)
 {
   fmortdf(i) = t0*fmort(i);   //assuming female bycatch mortality from 1975 to 1989.
   fmortdm(i) = t1*fmort(i);   //assuming male bycatch mortality from 1975 to 1989.
 }
 for (i=yrs_trawl(1); i<=endyr; i++) fmortt(i)=mfexp(log_avg_fmortt+fmortt_dev(i));
   fmortt(styr) = 0.0;     //no trawl bycatch before 1976.
 for (i=styr;i<=endyr;i++)
 {
   Fdiscf(i)=sel_discf(i)*fmortdf(i);
   Fdisct(1,i)=sel_trawl_f(i)*fmortt(i);
   Fdisct(2,i)=sel_trawl_m(i)*fmortt(i);
   F(i) = sel_fit(i)*fmort(i)+sel_ret*fmortdm(i);
   if (i==2005)  F(i) = sel_fit(i)*fmort(i)+(sel_ret+hg1*m_disc*sel_fit(i))*fmortdm(i);
   if (i==2006)  F(i) = sel_fit(i)*fmort(i)+(sel_ret+hg2*m_disc*sel_fit(i))*fmortdm(i);
   if (i==2007)  F(i) = sel_fit(i)*fmort(i)+(sel_ret+hg3*m_disc*sel_fit(i))*fmortdm(i);
   if (i==2008)  F(i) = sel_fit(i)*fmort(i)+(sel_ret+hg4*m_disc*sel_fit(i))*fmortdm(i);
   if (i==2009)  F(i) = sel_fit(i)*fmort(i)+(sel_ret+hg5*m_disc*sel_fit(i))*fmortdm(i);
   if (i==2010)  F(i) = sel_fit(i)*fmort(i)+(sel_ret+hg6*m_disc*sel_fit(i))*fmortdm(i);
   if (i==2011)  F(i) = sel_fit(i)*fmort(i)+(sel_ret+hg7*m_disc*sel_fit(i))*fmortdm(i);
   if (i==2012)  F(i) = sel_fit(i)*fmort(i)+(sel_ret+hg8*m_disc*sel_fit(i))*fmortdm(i);
   if (i==2013)  F(i) = sel_fit(i)*fmort(i)+(sel_ret+hg9*m_disc*sel_fit(i))*fmortdm(i);
   if (i==2014)  F(i) = sel_fit(i)*fmort(i)+(sel_ret+hg10*m_disc*sel_fit(i))*fmortdm(i);
   if (i==2015)  F(i) = sel_fit(i)*fmort(i)+(sel_ret+hg11*m_disc*sel_fit(i))*fmortdm(i);
   F_ret(i)=sel_fit(i)*fmort(i);
   Ftot(1,i)=Fdiscf(i) + Fdisct(1,i);
   Ftot(2,i)= F(i) + Fdisct(2,i);
   S(1,i)=mfexp(-1.0*Ftot(1,i));
   S(2,i)=mfexp(-1.0*Ftot(2,i));
 }
 for (i=1; i<=nobs_tc; i++)
 {
   Ftcm(yrs_tc(i)) = mfexp(log_Ftcm(i));
   Ftcf(yrs_tc(i)) = mfexp(log_Ftcf(i));
 }
  ttc = (Ftcm(1991)/tc_e(1991)+Ftcm(1992)/tc_e(1992)+Ftcm(1993)/tc_e(1993))/3.0;
  ttc1 = (Ftcf(1991)/tc_e(1991)+Ftcf(1992)/tc_e(1992)+Ftcf(1993)/tc_e(1993))/3.0;
 for (i=styr; i<1991; i++)
 {
   Ftcm(i) = ttc*tc_e(i);
   Ftcf(i) = ttc1*tc_e(i);
 }
 for (i=1994; i<=endyr; i++)
 {
   Ftcm(i) = ttc*tc_e(i);
   Ftcf(i) = ttc1*tc_e(i);
 }
 for (i=1; i<=nobs_tc; i++)
 {
   Ftcm(yrs_tc(i)) = mfexp(log_Ftcm(i));
   Ftcf(yrs_tc(i)) = mfexp(log_Ftcf(i));
 }
 for (i=styr;i<=endyr;i++)
 {
   Stc(1,i)=mfexp(-1.0*Ftcf(i)*sel_tcf);
   Stc(2,i)=mfexp(-1.0*Ftcm(i)*sel_tcm);
 }
}

void model_parameters::get_numbers_at_len(void)
{
  int itmp;
  na_f.initialize();
  na_m.initialize();
  na.initialize();
  rec_dev(1)=rec_devf+rec_devm;
  rec_dev(2)=rec_devm;
  if (current_phase()<6)
  {
    for (j=1; j<=nlenf; j++) ep68(1,j) = p68(1,j) + first_females(j);
    ep68(2) = p68(2)+first_males;
    ep68(3) = ep68(2)*elem_div(p68(3),p68(2));
    t0 = 0.0;
    for (j=1; j<=nlenm; j++)
    {
       if (ep68(1,j) < 0.0) ep68(1,j) = 0.0;
       if (j>16) ep68(1,j) = 0.0;
       if (ep68(2,j) < 0.0) ep68(2,j) = 0.0;
       if (ep68(3,j) < 0.0) ep68(3,j) = 0.0;
    }
    t0 = sum(ep68);
    ep68 = ep68/t0;
    t0 = sum(elem_div(ep68(1),sel_srv(1,styr)))+sum(elem_div(ep68(2),sel_srv(2,styr)))+sum(elem_div(ep68(3),sel_srv(2,styr)));
    na_f(styr) = mfexp(n68)*elem_div(ep68(1),sel_srv(1,styr))/t0;
    na_m(1,styr) = mfexp(n68)*elem_div(ep68(2),sel_srv(2,styr))/t0;
    na_m(2,styr) = mfexp(n68)*elem_div(ep68(3),sel_srv(2,styr))/t0;
    na(styr)     = na_m(1,styr)  + na_m(2,styr);
  }
  else
  {
    f_year_e(nlenm+nlenf) = mfexp(-sum(f_year));               //make sure the sum to be 0, or exp = 1
    for(j = 1; j < nlenm+nlenf; j++)
    {
      f_year_e(j) = mfexp(f_year(j));
    }
    f_year_p = f_year_e/sum(f_year_e);      //f_year_p is the estimated proportions of the first year population abundance.
    t0 = mfexp(n68);
    for(j = 1; j <= nlenm; j++)
    {
      na_m(1,styr,j) = f_year_p(j)*t0;
      na_m(2,styr,j) = 0.0;                           //set first-year old-shell male abundance to be 0.0
    }
    for(j = nlenm+1; j <= nlenm+nlenf; j++) na_f(styr,j-nlenm) = f_year_p(j)*t0;
    na(styr)     = na_m(1,styr)  + na_m(2,styr);
  }
  for (i=styr+1;i<=endyr;i++)
  {
     na_f(i) += mfexp(mean_log_rec+rec_dev(1,i))*rec_len(1);
     na_m(1,i) += mfexp(mean_log_rec+rec_dev(2,i))*rec_len(2);
  }
 for (i=styr;i<endyr;i++)
 {
   if (i<1983)
   {
      len_len0 = len_len(1);
   }
   else if (i<1994)
   {
      len_len0 = len_len(2);
   }
   else if (i > 1993)
   {
      len_len0 = len_len(3);
   }
   dvar_vector tmpf = mfexp(-(1-tc_cm(i))*M(1,i))*elem_prod(mfexp(-(tc_cm(i)-cm(i))*M(1,i))*elem_prod(S(1,i),mfexp(-cm(i)*M(1,i))*na_f(i)),Stc(1,i));
   na_f(i+1) +=  tmpf * len_len0;
   dvar_vector tmp = elem_prod(moltp(i)*mfexp(-(1-tc_cm(i))*M(2,i)),elem_prod(mfexp(-(tc_cm(i)-cm(i))*M(2,i))*elem_prod(S(2,i),mfexp(-cm(i)*M(2,i))*na(i)),Stc(2,i)));
   na_m(1,i+1) +=  tmp * len_len(4);
   na_m(2,i+1) = elem_prod((1.0-moltp(i))*mfexp(-(1-tc_cm(i))*M(2,i)),elem_prod(mfexp(-(tc_cm(i)-cm(i))*M(2,i))*elem_prod(S(2,i),mfexp(-cm(i)*M(2,i))*na(i)),Stc(2,i)));
   na(i+1)     = na_m(1,i+1)  + na_m(2,i+1);
   na_fishtime(1,i) = mfexp(-cm(i)*M(1,i))*na_f(i);
   na_fishtime(2,i) = mfexp(-cm(i)*M(2,i))*na(i);
   na_fishtime_tc(1,i) = elem_prod(na_fishtime(1,i),mfexp(-1.0*Fdiscf(i)))*mfexp(-(tc_cm(i)-cm(i))*M(1,i));
   na_fishtime_tc(2,i) = elem_prod(na_fishtime(2,i),mfexp(-1.0*F(i)))*mfexp(-(tc_cm(i)-cm(i))*M(2,i));
   popn_lmale(i) = na_fishtime(2,i)*sel(i);
   popn_lmale_bio(i) = elem_prod(na_fishtime(2,i),sel(i))*wt(2);
   popn_fit(i) = na_fishtime(2,i)*sel_fit(i);
   mbio215(i) = (elem_prod(mfexp(-(0.694-tc_cm(i))*M(2,i))*mat,elem_prod(mfexp(-(tc_cm(i)-cm(i))*M(2,i))*elem_prod(S(2,i),mfexp(-cm(i)*M(2,i))*na(i)),Stc(2,i))))*wt(2);
   mbio2151(i) = (elem_prod(mfexp(-(0.694-tc_cm(i))*M(2,i))*mat1,elem_prod(mfexp(-(tc_cm(i)-cm(i))*M(2,i))*elem_prod(S(2,i),mfexp(-cm(i)*M(2,i))*na(i)),Stc(2,i))))*wt(2);
   mbio2152(i) = (elem_prod(mfexp(-(0.694-tc_cm(i))*M(2,i))*mat2,elem_prod(mfexp(-(tc_cm(i)-cm(i))*M(2,i))*elem_prod(S(2,i),mfexp(-cm(i)*M(2,i))*na(i)),Stc(2,i))))*wt(2);
 }
   ftem1 = (sel_fit(endyr)+sel_ret)*flast(1);
   ftem1 = ftem1 + Fdisct(2,endyr);
   ftem1 = mfexp(-1.0*ftem1);
   mbio215(endyr) = (elem_prod(mfexp(-(0.694-tc_cm(endyr))*M(2,endyr))*mat,elem_prod(mfexp(-(tc_cm(i)-cm(i))*M(2,i))*elem_prod(ftem1,mfexp(-cm(endyr)*M(2,endyr))*na(endyr)),Stc(2,i))))*wt(2);
   ftem1 = (sel_fit(endyr)+sel_ret)*flast(2);
   ftem1 = ftem1 + Fdisct(2,endyr);
   ftem1 = mfexp(-1.0*ftem1);
   mbio2151(endyr) = (elem_prod(mfexp(-(0.694-tc_cm(endyr))*M(2,endyr))*mat1,elem_prod(mfexp(-(tc_cm(i)-cm(i))*M(2,i))*elem_prod(ftem1,mfexp(-cm(endyr)*M(2,endyr))*na(endyr)),Stc(2,i))))*wt(2);
   ftem1 = (sel_fit(endyr)+sel_ret)*flast(3);
   ftem1 = ftem1 + Fdisct(2,endyr);
   ftem1 = mfexp(-1.0*ftem1);
   mbio2152(endyr) = (elem_prod(mfexp(-(0.694-tc_cm(endyr))*M(2,endyr))*mat2,elem_prod(mfexp(-(tc_cm(i)-cm(i))*M(2,i))*elem_prod(ftem1,mfexp(-cm(endyr)*M(2,endyr))*na(endyr)),Stc(2,i))))*wt(2);
  na_fishtime(1,endyr) = mfexp(-cm(endyr)*M(2,endyr))*na_f(endyr);
  na_fishtime(2,endyr) = mfexp(-cm(endyr)*M(2,endyr))*na(endyr);
  na_fishtime_tc(1,endyr) = elem_prod(na_fishtime(1,endyr),mfexp(-1.0*Fdiscf(endyr)))*mfexp(-(tc_cm(endyr)-cm(endyr))*M(1,endyr));
  na_fishtime_tc(2,endyr) = elem_prod(na_fishtime(2,endyr),mfexp(-1.0*F(endyr)))*mfexp(-(tc_cm(endyr)-cm(endyr))*M(2,endyr));
  popn_lmale(endyr)  = na_fishtime(2,endyr)*sel(endyr);
  popn_lmale_bio(endyr)  = elem_prod(na_fishtime(2,endyr),sel(endyr))*wt(2);
  popn_fit(endyr)  = na_fishtime(2,endyr)*sel_fit(endyr);
 //predicted survey values
 for (i=styr;i<=endyr;i++)
 {
    totn_srv1(1,i) = na_f(i)*sel_srv(1,i);
    totn_srv1(2,i) = na(i)*sel_srv(2,i);
 }
    popn.initialize();
    explbiom.initialize();
    pred_bio.initialize();
    pred_srv1.initialize();
    pred_srv1_biom.initialize();
    pred_srv1_bioms.initialize();
    n_bsfrf.initialize();
 for (i=styr;i<=endyr;i++)
 {
     pred_srv1(1,i) += elem_prod(na_f(i),sel_srv(1,i));
     pred_srv1(2,i) += elem_prod(na(i),sel_srv(2,i));
     pred_srv1_bioms(1,i)+=(na_f(i)*elem_prod(sel_srv(1,i),wt(1)));
     pred_srv1_bioms(2,i)+=(na(i)*elem_prod(sel_srv(2,i),wt(2)));
     pred_srv1_biom(i) = pred_srv1_bioms(1,i)+pred_srv1_bioms(2,i);
     explbiom(i) += na(i)*elem_prod(sel(i),wt(2));
     pred_bio(i) += na_f(i)*wt(1)+na(i)*wt(2);
     popn(i) = sum(na(i))+sum(na_f(i));
     pred_p_srv1_len_m(1,i)=elem_prod(sel_srv(2,i),na_m(1,i))/(totn_srv1(1,i)+totn_srv1(2,i));
     pred_p_srv1_len_m(2,i)=elem_prod(sel_srv(2,i),na_m(2,i))/(totn_srv1(1,i)+totn_srv1(2,i));
     pred_p_srv1_len_f(i)=elem_prod(sel_srv(1,i),na_f(i))/(totn_srv1(1,i)+totn_srv1(2,i));
 }
  for (i=1;i<=nobs_bsfrf;i++)
  {
     n_bsfrf(1,i) += na_f(yrs_bsfrf(i))*elem_prod(sel_srv1(1),wt(1));
     n_bsfrf(2,i) += na(yrs_bsfrf(i))*elem_prod(sel_srv1(2),wt(2));
     pred_p_bsfrf_f(i)=elem_prod(sel_srv1(1),na_f(yrs_bsfrf(i)))/(sum(elem_prod(sel_srv1(1),na_f(yrs_bsfrf(i))))+sum(elem_prod(sel_srv1(2),na(yrs_bsfrf(i)))));
     pred_p_bsfrf_m(i)=elem_prod(sel_srv1(2),na(yrs_bsfrf(i)))/(sum(elem_prod(sel_srv1(1),na_f(yrs_bsfrf(i))))+sum(elem_prod(sel_srv1(2),na(yrs_bsfrf(i)))));
  }
  // for (i=styr; i<= styr+9; i++)
  // {
  //   for (j=1; j<=nlenm; j++)
  //   {
  //      pred_p_srv1_len_m(1,i,j) = pred_p_srv1_len_m(1,i,j)+pred_p_srv1_len_m(2,i,j);
  //   }
  // }
  pred_p_srv1_len_m(1) = pred_p_srv1_len_m(1)+pred_p_srv1_len_m(2);
  pred_p_srv1_len_m(2) = 0.0;
  endbiom=pred_bio(endyr);
  lbio=mbio215(endyr);
  blast = popn(endyr);
  mature1 = popn_lmale(endyr);
  mature2 = popn_lmale_bio(endyr);
  if (active(qm2)) qm2p = qm2;
 // cout<<blast<<endl;
}

void model_parameters::get_catch_at_len(void)
{
 //cout<<" begin catch at len"<<endl;
 pred_catch.initialize();
 pred_catch_ret.initialize();
 pred_catch_disc.initialize();
 catch_r.initialize();
 catch_m.initialize();
 for (i=styr;i<=endyr;i++)
 {
    totn_trawl(1,i)= na_fishtime(1,i)*sel_trawl_f(i);                   //used for estimating proportion of trawl bycatch by length only.
    totn_trawl(2,i)= na_fishtime(2,i)*sel_trawl_m(i);
    catch_t(i) = totn_trawl(1,i)+totn_trawl(2,i);
    if (catch_t(i) < 0.000001) catch_t(i) = 0.000001;
    for (j = 1; j<= nlenm; j++)
    {
       catch_lmale(i,j) = na_fishtime(2,i,j)*(1.0-mfexp(-1.0*F(i,j)));
       pred_catch(i) += catch_lmale(i,j)*wt(2,j);
       catch_male_ret(i,j) = na_fishtime(2,i,j)*(1.0-mfexp(-1.0*F_ret(i,j)));
       catch_r(i) += catch_male_ret(i,j);
       pred_catch_ret(i) += catch_male_ret(i,j)*wt(2,j);
       catch_discp(i,j) = na_fishtime(1,i,j)*(1.0-mfexp(-1.0*Fdiscf(i,j)));
       catch_m(i) += catch_lmale(i,j) - catch_male_ret(i,j);
    }
    pred_catch_disc(i) += catch_discp(i)*wt(1);
   pred_catch_trawl(i)= na_fishtime(1,i)*elem_prod(1.0-exp(-1.0*Fdisct(1,i)),wt(1))+
                        na_fishtime(2,i)*elem_prod(1.0-exp(-1.0*Fdisct(2,i)),wt(2));
   pred_catchtcf_biom(i) = na_fishtime_tc(1,i)*elem_prod(1.0-Stc(1,i),wt(1));
   pred_catchtcm_biom(i) = na_fishtime_tc(2,i)*elem_prod(1.0-Stc(2,i),wt(2));
   pred_p_fish_fit(i)=elem_prod(sel_fit(i),na_fishtime(2,i))/popn_fit(i);
   pred_p_fish(i)=elem_prod(sel(i),na_fishtime(2,i))/popn_lmale(i);
   pred_p_fish_discm(i)=elem_prod((sel(i)-sel_fit(i)),na_fishtime(2,i))/((sel(i)-sel_fit(i))*na_fishtime(2,i));
   pred_p_fish_discf(i)=elem_prod(sel_discf(i),na_fishtime(1,i))/(na_fishtime(1,i)*sel_discf(i));
   pred_p_trawl(1,i)=elem_prod(sel_trawl_f(i),na_fishtime(1,i))/catch_t(i);
   pred_p_trawl(2,i)=elem_prod(sel_trawl_m(i),na_fishtime(2,i))/catch_t(i);
 }
 for (i=1;i<=nobs_tc;i++)
 {
   pred_p_tc_len_f(i) = elem_prod(sel_tcf,na_fishtime_tc(1,yrs_tc(i)))/(na_fishtime_tc(1,yrs_tc(i))*sel_tcf);
   pred_p_tc_len_m(i) = elem_prod(sel_tcm,na_fishtime_tc(2,yrs_tc(i)))/(na_fishtime_tc(2,yrs_tc(i))*sel_tcm);
 }
}

void model_parameters::get_reference_points(void)
{
  dvariable mr;
  ref_Ft = 0.0;
  ref_Ftc = 0.0;
  ref_sel_fit.initialize();
  ref_sel_ret.initialize();
  ref_moltp.initialize();
  ref_sel_trawl.initialize();
  mr = 0;
  for(i=ryear(1); i<=ryear(2); i++)
  {
     mr += mfexp(mean_log_rec+rec_dev(1,i))+mfexp(mean_log_rec+rec_dev(2,i));
  }
  mr = mr/((ryear(2)-ryear(1)+1.0)*2.0);           //mean recruitment for B35 estimation
  for (i = endyr-9; i<=endyr; i++)
  {
    ref_Ft += fmortt(i);
    ref_Ftc += Ftcm(i);
    for (k=1; k<=nlenm; k++)
    {
       ref_sel_trawl(k) += sel_trawl_m(i,k);
       ref_moltp(k) += moltp(i-1,k);
    }
  }
  for (i = endyr-2; i<=endyr-1; i++)
  {
    for (k=1; k<=nlenm; k++)
    {
      ref_sel_fit(k) += sel_fit(i,k);
      ref_sel_ret(k) += sel(i,k)-sel_fit(i,k);
    }
  }
  ref_Ft = ref_Ft/10.0;
  ref_Ftc = ref_Ftc/10.0;
  ref_sel_trawl = ref_sel_trawl/10.0;
  ref_moltp = ref_moltp/10.0;
  ref_sel_fit = ref_sel_fit/2.0;
  ref_sel_ret = ref_sel_ret/2.0;
  for (j = 1; j<= 101; j++)
 {
   ref_F = 0.01*j-0.01;
   ref_Ftot = ref_sel_trawl*ref_Ft +ref_sel_fit*ref_F+ref_sel_ret*ref_F;
   if (j==1) ref_Ftot = ref_sel_fit*ref_F+ref_sel_ret*ref_F;
   ref_Fret=ref_sel_fit*ref_F;
   ref_S = mfexp(-1.0*ref_Ftot);
   tem_S = ref_S;
   tem_Stc = mfexp(-1.0*ref_Ftc*sel_tcm);
   if (j==1)
   {
     tem_S = 1.0;
     tem_Stc = 1.0;
   }
   ref_catch.initialize();
   ref_catch_ret.initialize();
   ref_catch_m.initialize();
   ref_na_m.initialize();
   ref_na.initialize();
   ref_na_m(1,1) = na_m(1,endyr);
   ref_na_m(2,1) = na_m(2,endyr);
   ref_na(1)     = ref_na_m(1,1)  + ref_na_m(2,1);
   for (i=2;i<=100;i++)
   {
      ref_na_m(1,i) += 1000000.0 *rec_len(2);
   }
   for (i=1;i<100;i++)
   {
     dvar_vector ref_tmp = elem_prod(ref_moltp*mfexp(-(1.0-0.34)*M(2,endyr)),elem_prod(tem_S,mfexp(-0.34*M(2,endyr))*ref_na(i)));
     ref_na_m(1,i+1) +=  ref_tmp * len_len(4);
     ref_na_m(2,i+1) = elem_prod((1.0-ref_moltp)*mfexp(-(1-0.34)*M(2,endyr)),elem_prod(tem_S,mfexp(-0.34*M(2,endyr))*ref_na(i)));
     ref_na(i+1)     = ref_na_m(1,i+1)  + ref_na_m(2,i+1);
     ref_na_fishtime(i) = mfexp(-0.34*M(2,endyr))*ref_na(i);
     ref_mbio215(i) = (elem_prod(mfexp(-(0.694-0.34)*M(2,endyr))*mat,elem_prod(tem_S,mfexp(-0.34*M(2,endyr))*ref_na(i))))*wt(2);
     ref_mbio2151(i) = (elem_prod(mfexp(-(0.694-0.34)*M(2,endyr))*mat1,elem_prod(tem_S,mfexp(-0.34*M(2,endyr))*ref_na(i))))*wt(2);
     ref_mbio2152(i) = (elem_prod(mfexp(-(0.694-0.34)*M(2,endyr))*mat2,elem_prod(tem_S,mfexp(-0.34*M(2,endyr))*ref_na(i))))*wt(2);
    for (k = 1; k<= nlenm; k++)
    {
       ref_catch_lmale(i,k) = ref_na_fishtime(i,k)*(1.0-ref_S(k));
       ref_catch(i) += ref_catch_lmale(i,k)*wt(2,k);
       ref_catch_male_ret(i,k) = ref_na_fishtime(i,k)*(1.0-mfexp(-1.0*ref_Fret(k)));
       ref_catch_ret(i) += ref_catch_male_ret(i,k)*wt(2,k);
    }
    ref_catch_m(i) = ref_catch(i) - ref_catch_ret(i);
    ref_catch_trawl(i)= ref_na_fishtime(i)*elem_prod(1.0-exp(-1.0*ref_sel_trawl*ref_Ft),wt(2));
   }
   ref_na_fishtime(99) = mfexp(-0.34*M(2,endyr))*ref_na(99);
   ref_mbio(j) = ref_mbio215(99)/1000.0;                    //kg/R
   ref_mbio1(j) = ref_mbio2151(99)/1000.0;
   ref_mbio2(j) = ref_mbio2152(99)/1000.0;
   ref_totc(j) = ref_catch(99)/1000.0;
   ref_retc(j) = ref_catch_ret(99)/1000.0;
 }
    i35 = 0;
    i40 = 0;
  for (j = 1; j<= 101; j++)
 {
    if (i35 < 1.0)
    {
      if (ref_mbio(j) <= 0.35*ref_mbio(1))
      {
         f35 = 0.01*j-0.01;
         eb35 = ref_mbio(j)*mr/1000.0;
         b25 = 0.25*eb35;
         i35 = 2.0;
      }
    }
    if (i40 < 1.0)
    {
      if (ref_mbio(j) <= 0.40*ref_mbio(1))
      {
         f40 = 0.01*j-0.01;
         i40 = 2.0;
      }
    }
 }
  ref_f = 0.0;
  ref_sel_f = 0.0;
  for (i = endyr-2; i<=endyr-1; i++)
  {
    ref_f += fmortdf(i);
    for (k=1; k<=nlenm; k++)
    {
      ref_sel_f(k) += sel_discf(i,k);
    }
  }
  ref_sel_f = ref_sel_f/2.0;
  ref_f = ref_f/2.0;
  ofl_f = f35;
  ref_Ftot = ref_sel_trawl*ref_Ft + ref_sel_fit*ofl_f+ref_sel_ret*ofl_f;
  ref_S = mfexp(-1.0*ref_Ftot);
  last_mmb = (elem_prod(mfexp(-(0.694-0.34)*M(2,endyr))*mat,elem_prod(ref_S,mfexp(-0.34*M(2,endyr))*na(endyr))))*wt(2);
  if (last_mmb < eb35)
  {
     for (k = 1; k<10; k++)
     {
        ref_Ftot = ref_sel_trawl*ref_Ft + ref_sel_fit*ofl_f+ref_sel_ret*ofl_f;
        ref_S = mfexp(-1.0*ref_Ftot);
        last_mmb = (elem_prod(mfexp(-(0.694-0.34)*M(2,endyr))*mat,elem_prod(ref_S,mfexp(-0.34*M(2,endyr))*na(endyr))))*wt(2);
        if (last_mmb < b25)
        {
           ofl_f = 0.0;
        }
        else
        {
            ofl_f = f35*(last_mmb/eb35-0.1)/0.9;
        }
     }
  }
   ref_Ftot = ref_sel_fit*ofl_f+ref_sel_ret*ofl_f;
   ref_Fret=ref_sel_fit*ofl_f;
   ref_S = mfexp(-1.0*ref_Ftot);
   ref_f = ref_f * ofl_f/f35;
   ref_catch(1) = 0.0;
   ref_catch_ret(1) = 0.0;
   for (k = 1; k<= nlenm; k++)
   {
      ref_catch_lmale(1,k) = na_fishtime(2,endyr,k)*(1.0-ref_S(k));
      ref_catch(1) += ref_catch_lmale(1,k)*wt(2,k);
      ref_catch_male_ret(1,k) = na_fishtime(2,endyr,k)*(1.0-mfexp(-1.0*ref_Fret(k)));
      ref_catch_ret(1) += ref_catch_male_ret(1,k)*wt(2,k);
   }
   ref_catch_m(1) = ref_catch(1) - ref_catch_ret(1);
   ref_catch_trawl(1)= na_fishtime(2,endyr)*elem_prod(1.0-exp(-1.0*ref_sel_trawl*ref_Ft),wt(2));
   ref_catch_trawl(1) += na_fishtime(1,endyr)*elem_prod(1.0-exp(-1.0*ref_sel_trawl*ref_Ft),wt(1));
   ref_catch_f = na_fishtime(1,endyr)*elem_prod(1.0-exp(-1.0*ref_sel_f*ref_f),wt(1));
   ref_catch(1) += ref_catch_f + ref_catch_trawl(1);
   ofl_catch = ref_catch(1);
  ofstream report1("refp75162.out");
  report1 <<eb35<<"  "<<last_mmb<<"  "<<ref_catch(1)<<endl;
  report1 <<"Total MMB (>119mm) 2/15 as F = 0.00, 0.01, ... 1.0"<<endl;
  report1 << ref_mbio<<endl;
  report1 <<"Total MMB (>129mm) 2/15 as F = 0.00, 0.01, ... 1.0"<<endl;
  report1 << ref_mbio1<<endl;
  report1 <<"Total MMB (>109mm) 2/15 as F = 0.00, 0.01, ... 1.0"<<endl;
  report1 << ref_mbio2<<endl;
  report1 <<"Total catch as F = 0.00, 0.01, ... 1.0"<<endl;
  report1 << ref_totc<<endl;
  report1 <<"Retained catch as F = 0.00, 0.01, ... 1.0"<<endl;
  report1 << ref_retc<<endl;
  report1 <<"F35: "<<f35<<"  B35: "<<eb35<<" Mean R: "<<mr<<endl;
  report1 <<"F40: "<<f40<<endl;
  report1 <<"ref_Ft = (mean of 10 years)  "<<endl;
  report1 <<ref_Ft<<endl;
  report1 <<"ref_sel_trawl = (mean of 10 years)  "<<endl;
  report1 <<ref_sel_trawl<<endl;
  report1 <<"ref_sel_retained = (mean of 2 years)  "<<endl;
  report1 <<ref_sel_fit<<endl;
  report1 <<"ref_sel_discarded = (mean of 2 years)  "<<endl;
  report1 <<ref_sel_ret<<endl;
  report1 <<"ref_sel_disc_females = (mean of 2 years)  "<<endl;
  report1 <<ref_sel_f<<endl;
   report1 <<"OFL =  "<<ref_catch(1)<<endl;
   report1 <<"Retained catch =  "<<ref_catch_ret(1)<<endl;
   report1 <<"Male pot bycatch =  "<<ref_catch_m(1)<<endl;
   report1 <<"Female pot bycatch =  "<<ref_catch_f<<endl;
   report1 <<"Trawl bycatch =  "<<ref_catch_trawl(1)<<endl;
   report1 <<"OFL F =  "<<ofl_f<<endl;
   report1 <<"MMB at terminal year =  "<<last_mmb<<endl;
}

void model_parameters::projection(void)
{
  mate = 0.0; mate(12)=1.0;mate(13)=1.2;mate(14)=1.4;mate(15)=1.6;mate(16)=1.8;mate(17)=2.1;mate(18)=2.4;mate(19)=2.7;mate(20)=3.0;
   random_number_generator r1(1000);
   random_number_generator r2(1100);
   dmatrix vu(2,10,1,1000);
   dvector vn(1,1000);
   vn.fill_randn(r1);
   vu.fill_randu(r2);
  ofstream report2("prj75162.out");
 for(int kk=1; kk<=3; kk++)         //F=0, F40%, & F35%
 {
   prj_Ft = ref_sel_trawl*ref_Ft;
   prj_Ftot = prj_Ft +ref_sel_fit*fprj(kk)+ref_sel_ret*fprj(kk);
   prj_S = mfexp(-1.0*prj_Ftot);
   prj_S0 = mfexp(-1.0*(prj_Ft));
   prj_catch.initialize();
   prj_catch_ret.initialize();
   for(j=1; j<=1000; j++)
   {
     prj_na_m.initialize();
     prj_na.initialize();
     t0 = vn(j)*vb+blast;            //selecting an abundance in terminal year
     t0 = t0/blast;
     prj_na_m(1,1) = t0*na_m(1,endyr);
     prj_na_m(2,1) = t0*na_m(2,endyr);
     prj_na(1)     = prj_na_m(1,1)  + prj_na_m(2,1);
     for (i=2;i<=10;i++)
     {
       int ii = (endyr-1984+1)*vu(i,j)+1.0/(endyr-1984+1);
       prj_na_m(1,i) += mfexp(mean_log_rec+rec_dev(2,1983+ii))*rec_len(2); //randomly select recruits from 1984-endyr.
     }
     for (i=1;i<10;i++)
     {
       t2 = (elem_prod(mfexp(-(0.694-0.34)*M(2,endyr))*mat,elem_prod(prj_S0,mfexp(-0.34*M(2,endyr))*prj_na(i))))*wt(2);
       t3 = (elem_prod(mfexp(-(0.694-0.34)*M(2,endyr))*mat,elem_prod(prj_S,mfexp(-0.34*M(2,endyr))*prj_na(i))))*wt(2);
       if (t3 >= eb35)
       {
         t4 = fprj(kk);   //set F to be maximum.
       }
       else if (t2 < b25)
       {
         t4 = 0.0;        //set F to 0 when B below B25.
       }
       else
       {                 //need to iterate to find F
         t4 = fprj(kk)*(t3/eb35-0.1)/0.9;
         tt2 = mfexp(-1.0*(prj_Ft+ref_sel_fit*t4+ref_sel_ret*t4));
         t3 = (elem_prod(mfexp(-(0.694-0.34)*M(2,endyr))*mat,elem_prod(tt2,mfexp(-0.34*M(2,endyr))*prj_na(i))))*wt(2);
         t4 = fprj(kk)*(t3/eb35-0.1)/0.9;
         tt2 = mfexp(-1.0*(prj_Ft+ref_sel_fit*t4+ref_sel_ret*t4));
         t3 = (elem_prod(mfexp(-(0.694-0.34)*M(2,endyr))*mat,elem_prod(tt2,mfexp(-0.34*M(2,endyr))*prj_na(i))))*wt(2);
         t4 = fprj(kk)*(t3/eb35-0.1)/0.9;
       }
       tt2 = mfexp(-1.0*(prj_Ft+ref_sel_fit*t4+ref_sel_ret*t4));
       prj_Sret=mfexp(-1.0*(ref_sel_fit*t4));
       dvar_vector prj_tmp = elem_prod(ref_moltp*mfexp(-(1.0-0.34)*M(2,endyr)),elem_prod(tt2,mfexp(-0.34*M(2,endyr))*prj_na(i)));
       prj_na_m(1,i+1) +=  prj_tmp * len_len(4);
       prj_na_m(2,i+1) = elem_prod((1.0-ref_moltp)*mfexp(-(1-0.34)*M(2,endyr)),elem_prod(tt2,mfexp(-0.34*M(2,endyr))*prj_na(i)));
       prj_na(i+1)     = prj_na_m(1,i+1)  + prj_na_m(2,i+1);
       prj_na_fishtime(i) = mfexp(-0.34*M(2,endyr))*prj_na(i);
       prj_mbio215(i,j) = (elem_prod(mfexp(-(0.694-0.34)*M(2,endyr))*mat,elem_prod(tt2,mfexp(-0.34*M(2,endyr))*prj_na(i))))*wt(2);
       for (k = 1; k<= nlenm; k++)
       {
         prj_catch_lmale(i,k) = prj_na_fishtime(i,k)*(1.0-tt2(k));
         prj_catch(i,j) += prj_catch_lmale(i,k)*wt(2,k);
         prj_catch_male_ret(i,k) = prj_na_fishtime(i,k)*(1.0-prj_Sret(k));
         prj_catch_ret(i,j) += prj_catch_male_ret(i,k)*wt(2,k);
       }
     }
     t2 = (elem_prod(mfexp(-(0.694-0.34)*M(2,endyr))*mat,elem_prod(prj_S0,mfexp(-0.34*M(2,endyr))*prj_na(10))))*wt(2);
     t3 = (elem_prod(mfexp(-(0.694-0.34)*M(2,endyr))*mat,elem_prod(prj_S,mfexp(-0.34*M(2,endyr))*prj_na(10))))*wt(2);
     if (t3 >= eb35)
     {
       t4 = fprj(kk);   //set F to be maximum.
     }
     else if (t2 < b25)
     {
       t4 = 0.0;        //set F to 0 when B below B25.
     }
     else
     {                 //need to iterate to find F
       t4 = fprj(kk)*(t3/eb35-0.1)/0.9;
       tt2 = mfexp(-1.0*(prj_Ft+ref_sel_fit*t4+ref_sel_ret*t4));
       t3 = (elem_prod(mfexp(-(0.694-0.34)*M(2,endyr))*mat,elem_prod(tt2,mfexp(-0.34*M(2,endyr))*prj_na(10))))*wt(2);
       t4 = fprj(kk)*(t3/eb35-0.1)/0.9;
       tt2 = mfexp(-1.0*(prj_Ft+ref_sel_fit*t4+ref_sel_ret*t4));
       t3 = (elem_prod(mfexp(-(0.694-0.34)*M(2,endyr))*mat,elem_prod(tt2,mfexp(-0.34*M(2,endyr))*prj_na(10))))*wt(2);
       t4 = fprj(kk)*(t3/eb35-0.1)/0.9;
     }
 //    cout<<j<<" "<<i<<"  "<<t4<<endl;
     tt2 = mfexp(-1.0*(prj_Ft+ref_sel_fit*t4+ref_sel_ret*t4));
     prj_Sret=mfexp(-1.0*(ref_sel_fit*t4));
     prj_na_fishtime(10) = mfexp(-0.34*M(2,endyr))*prj_na(10);
     for (k = 1; k<= nlenm; k++)
     {
       prj_catch_lmale(10,k) = prj_na_fishtime(10,k)*(1.0-tt2(k));
       prj_catch(10,j) += prj_catch_lmale(10,k)*wt(2,k);
       prj_catch_male_ret(10,k) = prj_na_fishtime(10,k)*(1.0-prj_Sret(k));
       prj_catch_ret(10,j) += prj_catch_male_ret(10,k)*wt(2,k);
     }
     prj_mbio215(10,j) = (elem_prod(mfexp(-(0.694-0.34)*M(2,endyr))*mat,elem_prod(tt2,mfexp(-0.34*M(2,endyr))*prj_na(10))))*wt(2);
   }
   prj_mean_mbio = 0.0;
   prj_mean_totc = 0.0;
   prj_mean_retc = 0.0;
   for (i=1;i<=10;i++)
   {
      for(j=1; j<=1000; j++)
      {
         prj_mean_mbio(i) += prj_mbio215(i,j);
         prj_mean_totc(i) += prj_catch(i,j);
         prj_mean_retc(i) += prj_catch_ret(i,j);
      }
      prj_mean_mbio(i) = prj_mean_mbio(i)/1000.0;
      prj_mean_totc(i) = prj_mean_totc(i)/1000.0;
      prj_mean_retc(i) = prj_mean_retc(i)/1000.0;
   }
   report2 <<"MMB         Retained Catch         Total Catch for 10 years "<<endl;
   report2 <<prj_mean_mbio<<endl;
   report2 <<prj_mean_retc<<endl;
   report2 <<prj_mean_totc<<endl;
   for (i=1;i<=10;i++)
   {
    www = prj_mbio215(i);
    for (j=1; j<=999; j++)
    {
       for (k=j+1; k<=1000; k++)
       {
         if (www(k) < www(j))
         {
           t1 = www(j);
           www(j) = www(k);
           www(k) = t1;
         }
       }
    }
    prj_cf_mbio(i,1) = www(1);
    prj_cf_mbio(i,2) = www(25);
    prj_cf_mbio(i,3) = www(50);
    prj_cf_mbio(i,4) = www(100);
    prj_cf_mbio(i,5) = (www(500)+www(501))/2.0;
    prj_cf_mbio(i,6) = www(900);
    prj_cf_mbio(i,7) = www(950);
    prj_cf_mbio(i,8) = www(975);
    prj_cf_mbio(i,9) = www(1000);
    www = prj_catch(i);
    for (j=1; j<=999; j++)
    {
       for (k=j+1; k<=1000; k++)
       {
         if (www(k) < www(j))
         {
           t1 = www(j);
           www(j) = www(k);
           www(k) = t1;
         }
       }
    }
    prj_cf_totc(i,1) = www(1);
    prj_cf_totc(i,2) = www(25);
    prj_cf_totc(i,3) = www(50);
    prj_cf_totc(i,4) = www(100);
    prj_cf_totc(i,5) = (www(500)+www(501))/2.0;
    prj_cf_totc(i,6) = www(900);
    prj_cf_totc(i,7) = www(950);
    prj_cf_totc(i,8) = www(975);
    prj_cf_totc(i,9) = www(1000);
    www = prj_catch_ret(i);
    for (j=1; j<=999; j++)
    {
       for (k=j+1; k<=1000; k++)
       {
         if (www(k) < www(j))
         {
           t1 = www(j);
           www(j) = www(k);
           www(k) = t1;
         }
       }
    }
    prj_cf_retc(i,1) = www(1);
    prj_cf_retc(i,2) = www(25);
    prj_cf_retc(i,3) = www(50);
    prj_cf_retc(i,4) = www(100);
    prj_cf_retc(i,5) = (www(500)+www(501))/2.0;
    prj_cf_retc(i,6) = www(900);
    prj_cf_retc(i,7) = www(950);
    prj_cf_retc(i,8) = www(975);
    prj_cf_retc(i,9) = www(1000);
   }
   report2 <<"F = "<<fprj(kk)<<endl;
   report2 <<"MMB 0.001, 0.025, 0.05 0.1 0.5, 0.9 0.95, 0.975 1.0 for 10 years "<<endl;
   report2 <<prj_cf_mbio<<endl;
   report2 <<"Total yield 0.001, 0.025, 0.05 0.1 0.5, 0.9 0.95, 0.975 1.0 for 10 years "<<endl;
   report2 <<prj_cf_totc<<endl;
   report2 <<"Retained yield 0.001, 0.025, 0.05 0.1 0.5, 0.9 0.95, 0.975 1.0 for 10 years "<<endl;
   report2 <<prj_cf_retc<<endl;
 }
}

void model_parameters::get_effective_sample_sizes(void)
{
  dvariable ts1, ts2, ts3, ts4, ts5, ts6;
  int ii; int ij;
  for (i=1; i<= nobs_fish; i++)
  {
    ii=yrs_fish(i);
    ts1 = 0.0; ts2 = 0.0;
    for (j=11; j<=nlenm; j++)       //no retained crabs in the first 10 length groups
    {
       ts1 += pred_p_fish_fit(ii,j)*(1.0-pred_p_fish_fit(ii,j));
       ts2 += (obs_p_fish_ret(i,j)-pred_p_fish_fit(ii,j))*(obs_p_fish_ret(i,j)-pred_p_fish_fit(ii,j));
    }
    size_fish_ret(i) = ts1/ts2;
    if (size_fish_ret(i) < 1.0) size_fish_ret(i) = 1.0;
  }
  for (i=1; i<= nobs_fish_discm; i++)
  {
    ii=yrs_fish_discm(i);
    ij=nlenm - 4;
    ts1 = 0.0; ts2 = 0.0;
    for (j=1; j<=ij; j++)
    {
       ts1 += pred_p_fish_discm(ii,j)*(1.0-pred_p_fish_discm(ii,j));
       ts2 += (obs_p_fish_discm(i,j)-pred_p_fish_discm(ii,j))*(obs_p_fish_discm(i,j)-pred_p_fish_discm(ii,j));
    }
    size_fish_discm(i) = ts1/ts2;
    if (size_fish_discm(i) < 1.0) size_fish_discm(i) = 1.0;
  }
  for (i=1; i<= nobs_fish_discf; i++)
  {
    ii=yrs_fish_discf(i);
    ts1 = 0.0; ts2 = 0.0;
    for (j=1; j<=nlenf; j++)
    {
       ts1 += pred_p_fish_discf(ii,j)*(1.0-pred_p_fish_discf(ii,j));
       ts2 += (obs_p_fish_discf(i,j)-pred_p_fish_discf(ii,j))*(obs_p_fish_discf(i,j)-pred_p_fish_discf(ii,j));
    }
    size_fish_discf(i) = ts1/ts2;
    if (size_fish_discf(i) < 1.0) size_fish_discf(i) = 1.0;
  }
  for (i=1; i<=nobs_srv1; i++)
  {
    ii=yrs_srv1(i);
    ts1=0.0; ts2=0.0; ts3=0.0; ts4=0.0; ts5=0.0; ts6=0.0;
    for (j=1; j<=nlenm; j++)
    {
      if (j<=nlenf)
      {
        ts1 += pred_p_srv1_len_f(ii,j)*(1.0-pred_p_srv1_len_f(ii,j));
        ts2 += (obs_p_srv1_len_f(i,j)-pred_p_srv1_len_f(ii,j))*(obs_p_srv1_len_f(i,j)-pred_p_srv1_len_f(ii,j));
      }
      ts3 += (pred_p_srv1_len_m(2,ii,j)+pred_p_srv1_len_m(1,ii,j))*(1.0-pred_p_srv1_len_m(2,ii,j)-pred_p_srv1_len_m(1,ii,j));
      ts4 += (obs_p_srv1_len_m(2,i,j)+obs_p_srv1_len_m(1,i,j)-pred_p_srv1_len_m(1,ii,j)-pred_p_srv1_len_m(2,ii,j))*(obs_p_srv1_len_m(2,i,j)+obs_p_srv1_len_m(1,i,j)-pred_p_srv1_len_m(1,ii,j)-pred_p_srv1_len_m(2,ii,j));
    }
    size_srv(1,i) = ts1/ts2;
    size_srv(2,i) = ts3/ts4;
  }
}

void model_parameters::evaluate_the_objective_function(void)
{
 //cout<<" to begin obj fun"<<endl;
 dvar_matrix cv_tem(1,2,1,nobs_bsfrf);
 len_likeyr.initialize();
 len_like.initialize();
 len_like_srv.initialize();
 sel_like=0.;
 rec_like=.0;
 surv_like=.0;
 q_like = .0;
 catch_like1=.0;
 catch_like2=.0;
 catch_likef=.0;
 catch_liket=.0;
 sexr_like.initialize();
 sumrecf.initialize();
 sumrecm.initialize();
 sel_like_50m.initialize();
 f=.0;
 if (active(rec_devf))
 {
    rec_like = 0.5*like_wght_rec*norm2(rec_devf)+like_wght_rec*norm2(rec_devm);
    f += rec_like;
    f += 0.2*norm2(fmortdf_dev)+ 0.1*norm2(fmortt_dev);
    for(i=styr+1; i<=endyr; i++)
    {
       sumrecf += mfexp(mean_log_rec+rec_devm(i)+rec_devf(i));
       sumrecm += mfexp(mean_log_rec+rec_devm(i));
    }
    sexr_like = square(log(sumrecf/(endyr-styr))-log(sumrecm/(endyr-styr)));
    f += like_wght_sexr*sexr_like;
 }
 sel_like_50m = norm2(first_difference(sel50_dev))+norm2(first_difference(fish_disc_sel50_dev_f))+norm2(first_difference(fish_disc_sel50_dev_tm));
 f +=like_wght_sel50*sel_like_50m;
 int ii;
 int ij;
 int ik;
 for (i=1; i<= nobs_fish; i++)
 {
   ii=yrs_fish(i);
   for (j=11; j<=nlenm; j++)       //no retained crabs in the first 10 length groups
   {
    t1 = obs_p_fish_ret(i,j)*(1.0-obs_p_fish_ret(i,j))+0.1/double(nlenm);
    len_like(1) += (-0.5)*log(6.29*t1)-log(sqrt(1.0/s_fish(i)))+log(mfexp(-1.*square(obs_p_fish_ret(i,j)-pred_p_fish_fit(ii,j))*s_fish(i)/(2.0*t1))+0.01);
   }
 }
 for (i=1; i<= nobs_fish_discm; i++)
 {
   ij=yrs_fish_discm(i);
   ii=nlenm - 4;
   for (j=1; j<=ii; j++)
   {
     t1 = obs_p_fish_discm(i,j)*(1.0-obs_p_fish_discm(i,j))+0.1/double(nlenm);
    len_like(2) += (-0.5)*log(6.29*t1)-log(sqrt(1.0/s_fish_discm(i)))+log(mfexp(-1.*square(obs_p_fish_discm(i,j)-pred_p_fish_discm(ij,j))*s_fish_discm(i)/(2.0*t1))+0.01);
   }
 }
 for (i=1; i<= nobs_fish_discf; i++)
 {
   ik=yrs_fish_discf(i);
   for (j=1; j<=nlenf; j++)
   {
     t1 = obs_p_fish_discf(i,j)*(1.0-obs_p_fish_discf(i,j))+0.1/double(nlenf);
   len_like(3) += (-0.5)*log(6.29*t1)-log(sqrt(1.0/s_fish_discf(i)))+log(mfexp(-1.*square(obs_p_fish_discf(i,j)-pred_p_fish_discf(ik,j))*s_fish_discf(i)/(2.0*t1))+0.01);
   }
 }
 for (i=1; i<= nobs_trawl; i++)
 {
   ij=yrs_trawl(i);
   for (j=1; j<=nlenf; j++)
   {
     t1 = obs_p_trawl(1,i,j)*(1.0-obs_p_trawl(1,i,j))+0.1/double(nlenf);
    len_like(3) += (-0.5)*log(6.29*t1)-log(sqrt(1.0/s_trawl(1,i)))+log(mfexp(-1.*square(obs_p_trawl(1,i,j)-pred_p_trawl(1,ij,j))*s_trawl(1,i)/(2.0*t1))+0.01);
   }
   for (j=1; j<=nlenm; j++)
   {
     t1 = obs_p_trawl(2,i,j)*(1.0-obs_p_trawl(2,i,j))+0.1/double(nlenm);
     len_like(5) += (-0.5)*log(6.29*t1)-log(sqrt(1.0/s_trawl(2,i)))+log(mfexp(-1.*square(obs_p_trawl(2,i,j)-pred_p_trawl(2,ij,j))*s_trawl(2,i)/(2.0*t1))+0.01);
   }
 }
 for (i=1; i<=nobs_srv1; i++)
 {
   ii=yrs_srv1(i);
   for (j=1; j<=nlenm; j++)
   {
     if (j<=nlenf)
     {
       t1 = obs_p_srv1_len_f(i,j)*(1.0-obs_p_srv1_len_f(i,j))+0.1/double(nlenf);
       like_srv1_f(ii,j) = (obs_p_srv1_len_f(i,j)-pred_p_srv1_len_f(ii,j))*sqrt(s_srv(1,i)/(2.0*t1));
       t0 = log(mfexp(-1.*square(obs_p_srv1_len_f(i,j)-pred_p_srv1_len_f(ii,j))*s_srv(1,i)/(2.0*t1))+0.01);
       len_likeyr(1,i) += (-0.5)*log(6.29*t1)-log(sqrt(1.0/s_srv(1,i)))+t0;
       len_like(4) += len_likeyr(1,i);
       len_like_srv(1) += len_likeyr(1,i);
     }
     t2 = obs_p_srv1_len_m(1,i,j)*(1.0-obs_p_srv1_len_m(1,i,j))+0.1/double(nlenm);
     like_srv1_m(1,ii,j) = (obs_p_srv1_len_m(1,i,j)-pred_p_srv1_len_m(1,ii,j))*sqrt(s_srv(2,i)/(2.0*t2));
     len_likeyr(2,i) += (-0.5)*log(6.29*t2)-log(sqrt(1.0/s_srv(2,i)))+log(mfexp(-1.*square(obs_p_srv1_len_m(1,i,j)-pred_p_srv1_len_m(1,ii,j))*s_srv(2,i)/(2.0*t2))+0.01);
     len_like(4) += len_likeyr(2,i);
     len_like_srv(2) += len_likeyr(2,i);
   }
 }
 for (i=1; i<=nobs_bsfrf; i++)
 {
   for (j=1; j<=nlenm; j++)
   {
     if (j<=nlenf)
     {
       t1 = obs_p_bsfrf_f(i,j)*(1.0-obs_p_bsfrf_f(i,j))+0.1/double(nlenf);
       t0 = log(mfexp(-1.*square(obs_p_bsfrf_f(i,j)-pred_p_bsfrf_f(i,j))*s_bsfrf(1,i)/(2.0*t1))+0.01);
        len_like(8) += (-0.5)*log(6.29*t1)-log(sqrt(1.0/s_bsfrf(1,i)))+t0;
     }
     t2 = obs_p_bsfrf_m(i,j)*(1.0-obs_p_bsfrf_m(i,j))+0.1/double(nlenm);
     len_like(8) += (-0.5)*log(6.29*t2)-log(sqrt(1.0/s_bsfrf(2,i)))+log(mfexp(-1.*square(obs_p_bsfrf_m(i,j)-pred_p_bsfrf_m(i,j))*s_bsfrf(2,i)/(2.0*t2))+0.01);
   }
 }
 for (i=1; i<= nobs_tc; i++)
 {
   for (j=1; j<=nlenf; j++)
   {
     t1 = obs_p_tc_len_f(i,j)*(1.0-obs_p_tc_len_f(i,j))+0.1/double(nlenf);
     len_like(6) += (-0.5)*log(6.29*t1)-log(sqrt(1.0/s_tc(1,i)))+log(mfexp(-1.*square(obs_p_tc_len_f(i,j)-pred_p_tc_len_f(i,j))*s_tc(1,i)/(2.0*t1))+0.01);
   }
   for (j=1; j<=nlenm; j++)
   {
     t1 = obs_p_tc_len_m(i,j)*(1.0-obs_p_tc_len_m(i,j))+0.1/double(nlenm);
     len_like(7) += (-0.5)*log(6.29*t1)-log(sqrt(1.0/s_tc(2,i)))+log(mfexp(-1.*square(obs_p_tc_len_m(i,j)-pred_p_tc_len_m(i,j))*s_tc(2,i)/(2.0*t1))+0.01);
   }
 }
 f-=like_wght(1)*len_like(1);     // Retained fishery
 f-=like_wght(2)*len_like(2);     // Discard males
 f-=like_wght(3)*len_like(3);     // Female
 f-=like_wght(4)*len_like(4);     // Survey
 f-=like_wght(7)*len_like(5);     // Trawl
 f-=like_wght(3)*len_like(6);     // Discard-TC, females
 f-=like_wght(2)*len_like(7);     // Discard-TC, males
 f-=len_like(8);     // Bsfrf
 for(k=1;k<=2;k++)
 {
   for(i=1;i<=nobs_srv1;i++)
   {
      biom_tmp(k,i)=pred_srv1_bioms(k,yrs_srv1(i));
   }
 }
 for(k=1;k<=2;k++)
 {
   surv_like += norm2(elem_div(log(obs_srv1_bioms(k)+1.0)-log(biom_tmp(k)+1.0),
               sqrt(2.0)*sqrt(log(elem_prod(cv_srv1(k),cv_srv1(k))+1.0))));
 }
 cv_tem(1) = (cv_bsfrf+ a_bsfrf)*(cv_bsfrf+ a_bsfrf);
 cv_tem(2) = cv_tem(1);
 bsfrf_like = sum(log(sqrt(log((cv_tem+1.0)))))+norm2(elem_div(log(obs_b_bsfrf+1.0)-log(n_bsfrf+1.0),
              sqrt(2.0)*sqrt(log((cv_tem+1.0)))));
 if (active(qm2))
 {
   q_like = pow((qm2-sur_q(1)),2)/(2.0*q_tem1);
 //  q_like = log(pow((qm2-sur_q(1)),2)/(2.0*q_tem1)+0.00001);
 //  q_like = pow((log(qm2+0.0001)-log(sur_q(1)+0.0001)),2)/(2.0*log(1.0+sur_q(2)/sur_q(1)*sur_q(2)/sur_q(1)));
 }
 for(k=1;k<=2;k++)
 {
   for(i=1;i<=nobs_srv1;i++)
   {
     tmpo(k,i)=sum(obs_srv1_num(k,i));
     tmpp(k,i)=sum(pred_srv1(k,yrs_srv1(i)));
   }
 }
 for(i=yrs_trawl(1);i<=endyr;i++)
 {
    bio_03(i)=pred_catch_trawl(i);
 }
 for(i=yrs_fish_discf(1);i<=endyr;i++)
 {
    bio_01(i)=pred_catch_disc(i);
    bio_02(i)=pred_catch(i)-pred_catch_ret(i);
 }
 catch_like1 = norm2(log(obs_catchdm_biom+1.0)-log(bio_02+1.0));
 catch_likef = norm2(log(obs_catchdf_biom+1.0)-log(bio_01+1.0));
 catch_like2 = norm2(log(catch_ret+1.0)-log(pred_catch_ret+1.0));
 catch_liket = norm2(log(obs_catcht_biom+1.0)-log(bio_03+1.0));
 for(i=1;i<=nobs_tc;i++)
 {
    tem_catchtcf_biom(i)=pred_catchtcf_biom(yrs_tc(i));
    tem_catchtcm_biom(i)=pred_catchtcm_biom(yrs_tc(i));
 }
 catch_like_tcf = norm2(log(obs_catchtcf_biom+1.0)-log(tem_catchtcf_biom+1.0));
 catch_like_tcm = norm2(log(obs_catchtcm_biom+1.0)-log(tem_catchtcm_biom+1.0));
 f += bycatch_w*catch_like1;
 f += like_wght(6)*catch_like2;
 f += 0.5*bycatch_w*catch_liket;
 f += bycatch_w*catch_likef;
 f += like_wght(5)*surv_like;
 f += bycatch_w*catch_like_tcf;
 f += bycatch_w*catch_like_tcm;
 f += like_wght(5)*2.0*cpue_like;
 f += y_bsfrf*bsfrf_like;
 f += q_like;
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
   obs_lmales.initialize();
   obs_mmales.initialize();
   obs_mfemales.initialize();
   legal_males.initialize();
   legal_srv_males.initialize();
   pre_mmales.initialize();
   pre_mfemales.initialize();
   for(i=1;i<=nobs_srv1;i++)
    {
      for(j=15;j<=nlenm;j++)
        {
          obs_lmales(i)+=obs_srv1_num(2,i,j);
        }
      for(j=12;j<=nlenm;j++)
        {
          obs_mmales(i)+=obs_srv1_num(2,i,j);
        }
      for(j=6;j<=nlenf;j++)
        {
          obs_mfemales(i)+=obs_srv1_num(1,i,j);
        }
    }
     for(i=styr;i<=endyr;i++)
      {
        for(j=15;j<=nlenm;j++)
        {
          legal_males(i)+=na(i,j);
          legal_srv_males(i)+=na(i,j)*sel_srv(2,i,j)*q_tem(i);
        }
        for(j=12;j<=nlenm;j++)
        {
          pre_mmales(i)+=na(i,j)*sel_srv(2,i,j)*q_tem(i);
        }
        for(j=6;j<=nlenf;j++)
        {
          pre_mfemales(i)+=na_f(i,j)*sel_srv(1,i,j)*qf_tem(i);
        }
      }
  report << "growth matrix: " << endl;
  report << len_len << endl;
  report << "growth increment per molt: " << endl;
  report << g << endl;
  report << "obs_srv1_bioms: " << endl;  
  report << obs_srv1_bioms << endl;
  report << "observed retained catch biomass  : seq(1968,2008)" << endl;
  report << catch_ret << endl;
  report << "predicted retained catch biomass : seq(1968,2008)" << endl;
  report << pred_catch_ret<<endl;
  report << "observed discard male catch biomass : seq(1990,2008)" << endl;
  report << obs_catchdm_biom << endl;
  report << "predicted discard male catch biomass : seq(1990,2008)" << endl;
  report << bio_02<<endl;
  report << "observed female discard mortality biomass : seq(1990,2008)" << endl;
  report << obs_catchdf_biom << endl;
  report << "predicted female discard mortality biomass  : seq(1990,2008)" << endl;
  report << bio_01<<endl;
  report << "observed trawl catch biomass  : seq(1968,2008)"<<endl;
  report << obs_catcht_biom<<endl;
  report << "predicted trawl catch biomass : seq(1968,2008)"<<endl;
  report << bio_03<<endl;
  tem_02.initialize();
  for(i=1;i<=nobs_srv1;i++) { tem_02(yrs_srv1(i))=obs_srv1_biom(i);}
  report << tem_02<<endl;
  report << pred_srv1_biom<<endl;
  report << tmpo(1)<<endl;
  report << tmpp(1)<<endl;
  report << tmpo(2)<<endl;
  report << tmpp(2)<<endl;
  report << "Observed survey mature male abundance: seq(1968,2008)"<<endl;
  tem_02.initialize();
  for(i=1;i<=nobs_srv1;i++) { tem_02(yrs_srv1(i))=obs_mmales(i);}
  report << tem_02<<endl;
  report << "Predicted survey mature male abundance : seq(1968,2008) " << endl;
  report << pre_mmales<<endl;
  report << "Observed survey mature female abundance: seq(1968,2008)"<<endl;
  tem_02.initialize();
  for(i=1;i<=nobs_srv1;i++) { tem_02(yrs_srv1(i))=obs_mfemales(i);}
  report << tem_02<<endl;
  report << "Predicted survey mature female abundance : seq(1968,2008) " << endl;
  report << pre_mfemales<<endl;
  report << "molting probs male:67.5-162.5"<< endl;
  report << moltp(1975)<<endl;
  report << moltp(1982)<<endl;
  report << moltp(1987)<<endl;
  report<<" length - length transition matrix Females :67.5-162.5"<< endl;
  report<<len_len(2)<<endl;
  report<<" length - length transition matrix Males :67.5-162.5"<< endl;
  report<<len_len(4)<<endl;
  report << "estimated annual total fishing mortality : seq(1968,2008)" << endl;
  report << mfexp(log_avg_fmort+fmort_dev) << endl;
  report << "estimated number of recruitments female: seq(1968,2008)" << endl;
    for(i=styr+1; i<=endyr; i++)
    {
      report << mfexp(mean_log_rec+rec_dev(1,i))/1000000.0<<" ";
    }
  report <<endl<< "estimated number of recruitments male: seq(1968,2008)" << endl;
    for(i=styr+1; i<=endyr; i++)
    {
      report << mfexp(mean_log_rec+rec_dev(2,i))/1000000.0<<" " ;
    }
  report <<endl<< "estimated proportions of recruitments by length" << endl;
  report <<rec_len(1)<<"  "<<rec_len(2)<<endl;
  report <<mfexp(log_avg_sel50)+sel50_dev<<endl;
  report << "selectivity fishery total males: '67.5-162.5'"<< endl;
  report << sel(styr) << endl;
  report <<" Proportion difference between total males and retention males: '67.5-162.5'"<< endl;
  report <<sel_ret<<endl;
  report << "selectivity discard females: '67.5-162.5'"<< endl;
  report <<sel_discf(styr)<<endl;
  report << "selectivity trawl females:'67.5-162.5'"<< endl;
  report <<sel_trawl_f(styr)<<endl;
  report << "selectivity trawl males:'67.5-162.5'"<< endl;
  report <<sel_trawl_m(styr)<<endl;
  report << "selectivity survey females (1975-81): '67.5-162.5'"<< endl;
  report << sel_srv2(1) << endl;
  report << "selectivity survey males (1975-81): '67.5-162.5'"<< endl;
  report << sel_srv2(2) << endl;
  report << "selectivity survey females (1982-12): '67.5-162.5'"<< endl;
  report << sel_srv3(1) << endl;
  report << "selectivity survey males (1982-12): '67.5-162.5'"<< endl;
  report << sel_srv3(2) << endl;
  report <<"likelihood : 'rec_like','len_like_ret','len_like_discmale','len_like_fem','len_like_surv','len_like_trawl','len_like_Tanner F then M','len_like_bsfrf','catch ret','catch_disc-males','catch fem','catch trawl','Tanner bio','surv_like','bsfrf_bio', 'q_like','total likelihood','sexr_like','change_sel_like'"<<endl;
  report <<rec_like<<"  "<<-1.0*len_like<<" "<<catch_like2*like_wght(6)<<" "<<catch_like1*bycatch_w<<" "<<catch_likef*bycatch_w<<" "<<catch_liket*0.5*bycatch_w<<" "<<(catch_like_tcf+catch_like_tcm)*bycatch_w<<" "<<surv_like<<" "<<bsfrf_like<<" "<<q_like<<" "<<f<<"  "<<sexr_like*like_wght_sexr<<"  "<<sel_like_50m<<endl;
  report <<"survey length likelihoods: 'female','new male','old male', Bycatch from TC, BSFRF like., q like. BSFRF-len"<<endl;
  report <<len_like_srv<<" "<<(catch_like_tcf+catch_like_tcm)*bycatch_w<<" "<<bsfrf_like<<" "<<q_like<<" "<<len_like(8)<<endl;
  report << "Availability of females for BSFRF survey: '67.5-162.5'"<< endl;
  report << af_bsfrf << endl;
  report << "Availability of males for BSFRF survey: '67.5-162.5'"<< endl;
  report << am_bsfrf << endl;
  report << "selectivity of TC bycatch: females: '67.5-162.5'"<< endl;
  report << sel_tcf << endl;
  report << "selectivity of TC bycatch: males: '67.5-162.5'"<< endl;
  report << sel_tcm << endl;
  report << "Pred. discard female biomass from TC fishery: "<< endl;
  report << pred_catchtcf_biom<< endl;
  report << "Pred. discard male biomass from TC fishery: "<< endl;
  report << pred_catchtcm_biom<< endl;
 report << "Observed Length Prop survey females: 'year','67.5-162.5'" << endl;
    for (i=1; i<=nobs_srv1; i++)
    {
        report << yrs_srv1(i) <<" " <<obs_p_srv1_len_f(i) << endl;
    }
  report << "Predicted length prop survey females: 'year','67.5-162.5'" << endl;
    for (i=1; i<=nobs_srv1; i++)
    {
        ii=yrs_srv1(i);
        report << ii << " " << pred_p_srv1_len_f(ii) << endl;
    }
  report << "Observed Length Prop survey males: 'year','67.5-162.5'" << endl;
    for (i=1; i<=nobs_srv1; i++)
    {
        report << yrs_srv1(i) <<" " <<obs_p_srv1_len_m(1,i) << endl;
    }
  report << "Predicted length prop survey males: 'year','67.5-162.5'" << endl;
    for (i=1; i<=nobs_srv1; i++)
    {
        ii=yrs_srv1(i);
        report << ii << " " << pred_p_srv1_len_m(1,ii) << endl;
    }
  report << "Observed Prop fishery ret males:'year','67.5-162.5'"<< endl;
      for (i=1; i<=nobs_fish; i++)
        {
          report << yrs_fish(i) << " " << obs_p_fish_ret(i) << endl;
        }
    report << "Predicted length prop fishery ret males : 'year','67.5-162.5'" << endl;
       for (i=1; i<=nobs_fish; i++)
        {
          ii=yrs_fish(i);
          report <<  ii  <<  " "  <<  pred_p_fish_fit(ii)  << endl;
        }
  report << "Observed Prop fishery discard males:'year','67.5-162.5'"<< endl;
      for (i=1; i<=nobs_fish_discm; i++)
        {
          report << yrs_fish_discm(i) << " " << obs_p_fish_discm(i) << endl;
        }
    report << "Predicted length prop fishery discard males : 'year','67.5-162.5'" << endl;
       for (i=1; i<=nobs_fish_discm; i++)
        {
          ii=yrs_fish_discm(i);
          report <<  ii  <<  " "  <<  pred_p_fish_discm(ii)  << endl;
        }
    report << "Observed length prop fishery discard all females : 'year','67.5-162.5'" << endl;
    for (i=1; i<=nobs_fish_discf; i++)
    {
      report <<  yrs_fish_discf(i) <<  " "  <<  obs_p_fish_discf(i)  << endl;
    }
    report << "Predicted length prop fishery discard all females : 'year','67.5-162.5'" << endl;
    for (i=1; i<=nobs_fish_discf; i++)
    {
      ii=yrs_fish_discf(i);
      report <<  ii  <<  " "  <<  pred_p_fish_discf(ii)  << endl;
    }
 report << "Observed Length Prop trawl bycatch females: 'year','67.5-162.5'" << endl;
    for (i=1; i<=nobs_trawl; i++)
    {
       report << yrs_trawl(i) <<" " <<obs_p_trawl(1,i) << endl;
    }
 report << "Predicted length prop trawl bycatch females: 'year','67.5-162.5'" << endl;
    for (i=1; i<=nobs_trawl; i++)
    {
      ii=yrs_trawl(i);
      report << ii << " " << pred_p_trawl(1,ii) << endl;
    }
 report << "Observed Length Prop trawl bycatch males: 'year','67.5-162.5'" << endl;
    for (i=1; i<=nobs_trawl; i++)
    {
       report << yrs_trawl(i) <<" " <<obs_p_trawl(2,i) << endl;
    }
 report << "Predicted length prop trawl bycatch males: 'year','67.5-162.5'" << endl;
    for (i=1; i<=nobs_trawl; i++)
    {
      ii=yrs_trawl(i);
      report << ii << " " << pred_p_trawl(2,ii) << endl;
    }
  report<<"Residuals of survey female length frequency"<<endl;
  for (i=1; i<=nobs_srv1; i++)
    {
      ii=yrs_srv1(i);
      report << ii << " " << like_srv1_f(ii) << endl;
    }
  report<<"Residuals of survey male length frequency"<<endl;
  for (i=1; i<=nobs_srv1; i++)
    {
      ii=yrs_srv1(i);
      report << ii << " " << like_srv1_m(1,ii) << endl;
    }
 report << "Estimated numbers of female crab by length: 'year','67.5-162.5'"<< endl;
     for(i=styr;i<=endyr;i++)
      {
       report << i<<" "<<na_f(i) << endl;
      }
 report << "Estimated numbers of new shell male crab by length: 'year','67.5-162.5'"<< endl;
     for(i=styr;i<=endyr;i++)
      {
        report << i<<" "<<na_m(1,i) << endl;
      }
 report << "Estimated numbers of old shell male crab by length: 'year','67.5-162.5'"<< endl;
     for(i=styr;i<=endyr;i++)
      {
        report << i<<" "<<na_m(2,i) << endl;
      }
  report << "Observed Survey Numbers by length females:  '67.5-162.5'"<< endl;
    for(i=1;i<=nobs_srv1;i++) { report<<yrs_srv1(i)<<" "<<obs_srv1_num(1,i) <<endl;}
  report << "Observed Survey Numbers by length males:  '67.5-162.5'"<< endl;
    for(i=1;i<=nobs_srv1;i++) { report<<yrs_srv1(i)<<" "<<obs_srv1_num(2,i) <<endl;}
  report << "Predicted Survey Numbers by length females: '67.5-162.5'"<< endl;
    for(i=1;i<=nobs_srv1;i++) { report<<yrs_srv1(i)<<" "<<pred_srv1(1,yrs_srv1(i)) <<endl;}
  report << "Predicted Survey Numbers by length males:  '67.5-162.5'"<< endl;
    for(i=1;i<=nobs_srv1;i++) { report<<yrs_srv1(i)<<" "<<pred_srv1(2,yrs_srv1(i)) <<endl;}
  report<<" observed number of legal males: seq(1968,2008)"<<endl;
  report<<yrs_srv1<<endl;
  report<<obs_lmales<<endl;
    for(i=1;i<=nobs_srv1;i++) { tem_01(i)=legal_srv_males(yrs_srv1(i));}
  report<<" Estimated survey numbers of legal males : seq(1968,2008) "<<endl;
  report<<tem_01<<endl;
  report<<" Pop estimate umnbers of legal males: seq(1968,2008)"<<endl;
  report<<legal_males<<endl;
  report << "Predicted Biomass : seq(1985,2004)" << endl;
  report << pred_bio << endl;
  report << "Predicted total population numbers: seq(1968,2008) "<<endl;
  report <<popn<<endl;
  report << "Predicted fishery total males:'year','67.5-162.5'"<< endl;
      for (i=1; i<=nobs_fish_discm; i++)
        {
          ii=yrs_fish_discm(i);
          report << yrs_fish_discm(i) << " " << pred_p_fish(ii) << endl;
        }
  report << "selectivity fishery total males: '67.5-162.5'"<< endl;
  report << sel << endl;
  report << "selectivity fishery ret males: '67.5-162.5'"<< endl;
  report << sel_fit << endl;
  report <<"likelihood weights: 'retained length','total catch length','female catch','survey length','survey biomass','catch biomass','trawl length'"<<endl;
  report <<like_wght<<endl;
  report <<"likelihood weights:  'rec devs','sex ratio','fishery 50%','fmort phase 1','fmort phase>1','fmort devs'"<<endl;
  report <<like_wght_rec<<"  "<<like_wght_sexr<<"  "<<like_wght_sel50<<endl;
  report<<"male total pot fishery exploitation rates"<<endl;
  report<<1-mfexp(-1.0*F)<<endl;
  report<<"numbers females at time of pop fishery"<<endl;
  report<<na_fishtime(1)<<endl;
  report<<"numbers males at time of pop fishery"<<endl;
  report<<na_fishtime(2)<<endl;
  report<<"total catch in numbers males"<<endl;
  report<<catch_lmale<<endl;
  report<<"retained catch in numbers males"<<endl;
  report<<catch_male_ret<<endl;
  report << "predicted discarded male biomass : seq(1968,2008)" << endl;
  report << pred_catch - pred_catch_ret<<endl;
  report << "predicted discarded female biomass : seq(1968,2008)" << endl;
  report << pred_catch_disc<<endl;
  report << "predicted trawl discarded biomass : seq(1968,2008)" << endl;
  report << pred_catch_trawl<<endl;
  report << "Male fishing mortality" << endl;
  report << fmort<<endl;
  report << "Discarded female fishing mortality" << endl;
  report << fmortdf<<endl;
  report << "Trawl fishing mortality" << endl;
  report << fmortt<<endl;
  report << "Discarded male fishing mortality" << endl;
  report << fmortdm<<endl;
  report << "Discarded male catch" << endl;
  report << catch_m/m_disc<<endl;
  report << "Retained catch" << endl;
  report << catch_r<<endl;
  report << "Natural mortality for males: " << endl;
  report << M << endl;
  report << "mbi0215 " <<mbio215<<endl;
  report << "mbio2151 " <<mbio2151<<endl;
  report << "mbio2512 " <<mbio2152<<endl;
  report << "selectivity bsfrf survey females: '67.5-162.5'"<< endl;
  report << sel_srv1(1) << endl;
  report << "selectivity bsfrf survey males: '67.5-162.5'"<< endl;
  report << sel_srv1(2) << endl;
  report << "Obs. discard female biomass from TC fishery: "<< endl;
  report << obs_catchtcf_biom<< endl;
  report << "Obs. discard male biomass from TC fishery: "<< endl;
  report << obs_catchtcm_biom<< endl;
  report << Ftcf<< endl;
  report << Ftcm<< endl;
  report << "Pred. discard female length frequency from TC fishery: "<< endl;
  report << pred_p_tc_len_f<< endl;
  report << "Obs. discard female length frequency from TC fishery: "<< endl;
  report << obs_p_tc_len_f<< endl;
  report << "Pred. discard male length frequency from TC fishery: "<< endl;
  report << pred_p_tc_len_m<< endl;
  report << "Obs. discard male length frequency from TC fishery: "<< endl;
  report << obs_p_tc_len_m<< endl;
  report << "Pred. bsfrf female length frequency: "<< endl;
  report << pred_p_bsfrf_f<< endl;
  report << "Obs. bsfrf female length frequency: "<< endl;
  report << obs_p_bsfrf_f<< endl;
  report << "Pred. bsfrf male length frequency: "<< endl;
  report << pred_p_bsfrf_m<< endl;
  report << "Obs. bsfrf male length frequency: "<< endl;
  report << obs_p_bsfrf_m<< endl;
  report << "Pred. bsfrf survey biomass: "<< endl;
  report << n_bsfrf<< endl;
  report << "Obs. bsfrf survey biomass: "<< endl;
  report << obs_b_bsfrf<< endl;
  report << s_srv<< endl;
  report << s_fish<< endl;
  report << s_fish_discf<< endl;
  report << s_fish_discm<< endl;
  report << s_trawl<< endl;
  report << s_tc<< endl;
  report << size_srv<< endl;
  report << size_fish_ret<< endl;
  report << size_fish_discf<< endl;
  report << size_fish_discm<< endl;
  ofstream report3("m2.rep");
  report3 << "styr" << endl << styr << endl;   //start year of the model
  report3 << "endyr" << endl << endyr << endl;  //end year of the model
  report3 << "nlenm" << endl << nlenm << endl;   //number of length bins for males in the model
  report3 << "nlenf" << endl << nlenf << endl;   //number of length bins for females in the model
  report3 << "slt" << endl << slt << endl;      //length interval (mm)
  report3 << "ilen1" << endl << ilen1 << endl;   //minimum length (mm)
  report3 << "nobs_fish" << endl << nobs_fish << endl;   //number of years of fishery retained length data
  report3 << "yrs_fish" << endl << yrs_fish << endl;  //years when have fishery retained length data
  report3 << "nobs_fish_discf" << endl << nobs_fish_discf << endl;   //number of years of fishery female discard length data
  report3 << "yrs_fish_discf" << endl << yrs_fish_discf << endl;   //years when have fishery discard length data
  report3 << "nobs_fish_discm" << endl << nobs_fish_discm << endl;  //number of years of fishery male discard length data
  report3 << "yrs_fish_discm" << endl << yrs_fish_discm << endl;  //years when have fishery discard length data
  report3 << "nobs_trawl" << endl << nobs_trawl << endl;            //number of years of trawl bycatch length data
  report3 << "yrs_trawl" << endl << yrs_trawl << endl;          //years when have trawl bycatch data
  report3 << "nobs_tc" << endl << nobs_tc << endl;            //number of years of Tanner crab fishery bycatch
  report3 << "yrs_tc" << endl << yrs_tc << endl;          //years when have Tanner crab bycatch data
  report3 << "nobs_srv1" << endl << nobs_srv1 << endl;          //number of years of biomass data
  report3 << "yrs_srv1" << endl << yrs_srv1 << endl;            //years when have biomass estimates
  report3 << "length_bins" << endl << length_bins << endl;
  report3 << "nobs_bsfrf" << endl << nobs_bsfrf << endl;  //number of years of BSFRF survey
  report3 << "yrs_bsfrf" << endl << yrs_bsfrf << endl;    //years when having BSFRF survey
  report3 << "sur_bsfrf_cv" << endl << cv_bsfrf << endl;  //survey biomass cv from BSFRF surveys
  report3 << "sur_nmfs_cv" << endl << cv_srv1(1) << endl;   //NMFS survey cv
  report3 << "obs_catch_ret" << endl << catch_ret << endl;
  report3 << "pred_catch_ret" << endl << pred_catch_ret<<endl;
  report3 << "obs_catchdm_biom" << endl << obs_catchdm_biom << endl;
  report3 << "pred_catchdm_biom" << endl << bio_02<<endl;
  report3 << "obs_catchdf_biom" << endl << obs_catchdf_biom << endl;
  report3 << "pred_catchdf_biom" << endl << bio_01<<endl;
  report3 << "obs_catcht_biom" <<endl << obs_catcht_biom <<endl;
  report3 << "pred_catcht_biom" <<endl << bio_03<<endl;
  report3 << "obs_srv1_biom" <<endl << obs_srv1_biom <<endl;
  report3 << "pred_srv1_biom" <<endl << pred_srv1_biom <<endl;
  report3 << "obs_mmales"<<endl << obs_mmales <<endl;
  report3 << "pre_mmales" << endl << pre_mmales <<endl;
  report3 << "obs_mfemales" <<endl << obs_mfemales <<endl;
  report3 << "pre_mfemales" << endl << pre_mfemales<<endl;
  report3 << "molting-probs 1975-1979" << endl << moltp(1975)<<endl;
  report3 << "molting-probs 1980-present" << endl << moltp(1987)<<endl;
  report3 << "tot_fishing_mort" << endl << mfexp(log_avg_fmort+fmort_dev) << endl;
  report3 << "female_rec" << endl;
    for(i=styr+1; i<=endyr; i++)
    {
      report3 << mfexp(mean_log_rec+rec_dev(1,i))/1000000.0<<" ";
    }
  report3 <<endl<< "male_rec" << endl;
    for(i=styr+1; i<=endyr; i++)
    {
      report3 << mfexp(mean_log_rec+rec_dev(2,i))/1000000.0<<" " ;
    }
  report3 <<endl<< "proportions_rec_f" << endl <<rec_len(1)<<endl;
  report3 << "proportions_rec_m" << endl <<rec_len(2)<<endl;
  report3 << "sel_fish_totm_1975" << endl << sel(styr) << endl;
  report3 <<" sel_discm" << endl <<sel_ret<<endl;
  report3 << "sel_discf" << endl <<sel_discf(styr)<<endl;
  report3 << "sel_trawlf" << endl <<sel_trawl_f(styr)<<endl;
  report3 << "sel_trawlm" << endl <<sel_trawl_m(styr)<<endl;
  report3 << "sel_surf_1975-81" << endl << sel_srv2(1) << endl;
  report3 << "sel_surm_1975-81" << endl << sel_srv2(2) << endl;
  report3 << "sel_surf_1982-present" << endl << sel_srv3(1) << endl;
  report3 << "sel_surma_1982-present" << endl << sel_srv3(2) << endl;
  report3 << "sel_TC_bycatchf" << endl << sel_tcf << endl;
  report3 << "sel_TC_bycatchm"<< endl << sel_tcm << endl;
  report3 << "Pred_discf_bio_TC" << endl << pred_catchtcf_biom<< endl;
  report3 << "Pred_discm_bio_TC" << endl << pred_catchtcm_biom<< endl;
  report3 <<"Res_surf_length" <<endl;
  for (i=1; i<=nobs_srv1; i++)
    {
      ii=yrs_srv1(i);
      report3 << like_srv1_f(ii) << endl;
    }
  report3 <<"Res_surm_length" <<endl;
  for (i=1; i<=nobs_srv1; i++)
    {
      ii=yrs_srv1(i);
      report3 << like_srv1_m(1,ii) << endl;
    }
  report3 << "sel_fish_totm" << endl << sel << endl;
  report3 << "sel_fish_retm" << endl << sel_fit << endl;
  report3 <<"expl_rate_totm" <<endl <<1-mfexp(-1.0*F) <<endl;
  report3 << "pred_discm_bio" << endl << pred_catch - pred_catch_ret << endl;
  report3 << "pred_discf_bio" << endl << pred_catch_disc << endl;
  report3 << "pred_trawl_disc_bio" << endl << pred_catch_trawl << endl;
  report3 << "fish_mortm" << endl << fmort << endl;
  report3 << "fish_mortf" << endl << fmortdf << endl;
  report3 << "fish_mort_trawl" << endl << fmortt << endl;
  report3 << "fish_mort_Discm" << endl << fmortdm << endl;
  report3 << "Discm_catch" << endl << catch_m/m_disc << endl;
  report3 << "Ret_catch" << endl << catch_r << endl;
  report3 << "M_males" << endl << M(2) << endl;
  report3 << "M_females" << endl << M(1) << endl;
  report3 << "mbi0215" << endl << mbio215 << endl;
  report3 << "sel_bsfrff" << endl << sel_srv1(1) << endl;
  report3 << "sel_bsfrfm" << endl << sel_srv1(2) << endl;
  report3 << "obs_discf_bio_TC" << endl << obs_catchtcf_biom<< endl;
  report3 << "obs_discm_bio_TC" << endl << obs_catchtcm_biom<< endl;
  report3 << "Pred_b_bsfrf" << endl << n_bsfrf << endl;
  report3 << "obs_b_bsfrf" << endl << obs_b_bsfrf << endl;
  report3 << "s_srv" << endl << s_srv << endl;
  report3 << "s_fish" << endl << s_fish << endl;
  report3 << "s_fish_discf" << endl << s_fish_discf << endl;
  report3 << "s_fish_discm" << endl << s_fish_discm << endl;
  report3 << "s_trawl" << endl << s_trawl << endl;
  report3 << "s_tc" << endl << s_tc << endl;
  report3 << "size_srv" << endl << size_srv << endl; //eff.sizes estimated in the model. This is plot against s_srv.
  report3 << "size_fish_ret" << endl << size_fish_ret << endl;
  report3 << "size_fish_discf" << endl << size_fish_discf << endl;
  report3 << "size_fish_discm" << endl << size_fish_discm << endl;
  report3 << "obs_p_srv1_len_f" << endl << obs_p_srv1_len_f << endl;        // Length Prop survey females
  report3 << "pred_p_srv1_len_f" << endl << pred_p_srv1_len_f << endl;     //Predicted length prop survey females
  report3 << "obs_p_srv1_len_m" << endl << obs_p_srv1_len_m(1) << endl;    //Observed Length Prop survey males
  report3 << "pred_p_srv1_len_m" << endl << pred_p_srv1_len_m(1)<< endl;    //Predicted length prop survey males
  report3 << "obs_p_bsfrf_f" << endl << obs_p_bsfrf_f << endl;
  report3 << "pred_p_bsfrf_f" << endl << pred_p_bsfrf_f << endl;
  report3 << "obs_p_bsfrf_m" << endl << obs_p_bsfrf_m << endl;
  report3 << "pred_p_bsfrf_m" << endl << pred_p_bsfrf_m << endl;
  report3 << "pred_p_tc_len_f" << endl << pred_p_tc_len_f<< endl;
  report3 << "obs_p_tc_len_f" << endl << obs_p_tc_len_f << endl;
  report3 << "pred_p_tc_len_m" << endl << pred_p_tc_len_m << endl;
  report3 << "obs_p_tc_len_m" << endl << obs_p_tc_len_m << endl;
  report3 << "obs_fish_ret" << endl;
  for (i=1; i<=nobs_fish; i++)
  {
       report3 << obs_p_fish_ret(i) << endl;   //Observed Prop fishery ret males
  }
  report3 << "pred_fish_ret" << endl;
  for (i=1; i<=nobs_fish; i++)
  {
       ii=yrs_fish(i);
       report3 <<  pred_p_fish_fit(ii)  << endl;   //Predicted length prop fishery ret males
  }
  report3 << "obs_fish_discm" << endl;
  for (i=1; i<=nobs_fish_discm; i++)
  {
       report3 << obs_p_fish_discm(i) << endl;    //Observed Prop fishery discard males
  }
  report3 << "pred_fish_discm" << endl;
  for (i=1; i<=nobs_fish_discm; i++)
  {
       ii=yrs_fish_discm(i);
       report3 <<  pred_p_fish_discm(ii)  << endl;    //Predicted length prop fishery discard males
  }
  report3 << "obs_fish_discf" << endl;
  for (i=1; i<=nobs_fish_discf; i++)
  {
      report3 <<  obs_p_fish_discf(i)  << endl;     //Observed length prop fishery discard all females
  }
  report3 << "pred_fish_discf" << endl;
  for (i=1; i<=nobs_fish_discf; i++)
  {
      ii=yrs_fish_discf(i);
      report3 <<  pred_p_fish_discf(ii)  << endl;   //Predicted length prop fishery discard all females
  }
  report3 << "obs_p_trawlf" << endl;
  for (i=1; i<=nobs_trawl; i++)
  {
      report3 <<obs_p_trawl(1,i) << endl;   //Observed Length Prop trawl bycatch females
  }
  report3 << "pred_p_trawlf" << endl;
  for (i=1; i<=nobs_trawl; i++)
  {
      ii=yrs_trawl(i);
      report3 << pred_p_trawl(1,ii) << endl;    //Predicted length prop trawl bycatch females
  }
  report3 << "obs_p_trawlm" << endl;
  for (i=1; i<=nobs_trawl; i++)
  {
      report3 <<obs_p_trawl(2,i) << endl;   //Observed Length Prop trawl bycatch males
  }
  report3 << "pred_p_trawlm" << endl;
  for (i=1; i<=nobs_trawl; i++)
  {
      ii=yrs_trawl(i);
      report3 << pred_p_trawl(2,ii) << endl;    //Predicted length prop trawl bycatch males
  }
}

void model_parameters::set_runtime(void)
{
  dvector temp1("{300,1000,1000,1000,3000,3000,3000}");
  maximum_function_evaluations.allocate(temp1.indexmin(),temp1.indexmax());
  maximum_function_evaluations=temp1;
  dvector temp("{1,1,1,1,0.00001 0.000001 0.000001 0.000001 1e-5,1e-5,1e-5,1e-5}");
  convergence_criteria.allocate(temp.indexmin(),temp.indexmax());
  convergence_criteria=temp;
}

model_data::~model_data()
{}

model_parameters::~model_parameters()
{}

void model_parameters::final_calcs(void){}

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
  arrmblsize = 1000000;
    gradient_structure::set_NO_DERIVATIVES();
#ifdef DEBUG
  #ifndef __SUNPRO_C
std::feclearexcept(FE_ALL_EXCEPT);
  #endif
#endif
    gradient_structure::set_YES_SAVE_VARIABLES_VALUES();
    if (!arrmblsize) arrmblsize=15000000;
    model_parameters mp(arrmblsize,argc,argv);
    mp.iprint=10;
    mp.preliminary_calculations();
    mp.computations(argc,argv);
#ifdef DEBUG
  #ifndef __SUNPRO_C
bool failedtest = false;
if (std::fetestexcept(FE_DIVBYZERO))
  { cerr << "Error: Detected division by zero." << endl; failedtest = true; }
if (std::fetestexcept(FE_INVALID))
  { cerr << "Error: Detected invalid argument." << endl; failedtest = true; }
if (std::fetestexcept(FE_OVERFLOW))
  { cerr << "Error: Detected overflow." << endl; failedtest = true; }
if (std::fetestexcept(FE_UNDERFLOW))
  { cerr << "Error: Detected underflow." << endl; }
if (failedtest) { std::abort(); } 
  #endif
#endif
    return 0;
}

extern "C"  {
  void ad_boundf(int i)
  {
    /* so we can stop here */
    exit(i);
  }
}

DATA_SECTION
//Bering Sea Tanner crab model
//********
//********
//to run mcmc 
//scmysr2003bayes -nox -mcmc 1000000 -mcsave 200
// then have to run  scmysr2003bayes -mceval to get output
//whatever is in sd report file will have a distribution and output will go to eval.csv
//for whatever have written to post later in program in the mcmc function part
  number p_const
  int call_no;
  int Nsex;
  int Nmat
  int Nshell
  number spmo // spawning month
  !! spmo=2./12.;
  !!CLASS ofstream post("eval.csv");
  !! p_const = 0.001;
  !! call_no = 0;
  !! Nsex = 2;                                                      // Number of sex
  !! Nmat = 2;                                                      // Number of maturity states
  !! Nshell = 2;                                                    // Number of shell types

  init_int styr                                                      // start year of the model
  init_int endyr                                                    // end year of the model
  init_int nirec                                                    // number of intial recruitments to estimate 
  init_int nlenbins                                                 // number of length bins for males in the model
  !! log_input(styr);
  !! log_input(endyr);
  !! log_input(nirec);
  !! log_input(nlenbins);

  // Data stuff only from here
// Fishery specifics
  init_int nfsh                                   //Number of fisheries
  imatrix pfshname(1,nfsh,1,2)
  init_adstring fshnameread;
 LOCAL_CALCS
  for(int k=1;k<=nfsh;k++) 
  {
    pfshname(k,1)=1; 
    pfshname(k,2)=1;
  }    // set whole array to equal 1 in case not enough names are read
  adstring_array CRLF;   // blank to terminate lines
  CRLF+="";
  int k=1;
  for(int i=1;i<=strlen(fshnameread);i++)
  if(adstring(fshnameread(i))==adstring("%")) {
    pfshname(k,2)=i-1; 
    k++;  
    pfshname(k,1)=i+1;
  }
  pfshname(nfsh,2)=strlen(fshnameread);
  for(k=1;k<=nfsh;k++)
  {
    fshname += fshnameread(pfshname(k,1),pfshname(k,2))+CRLF(1);
  }
  log_input(nfsh);
  log_input(fshname);
  // exit(1);
 END_CALCS
  init_matrix obs_catch(1,nfsh,styr,endyr)     // Catch by fishery and year
  init_matrix obs_catch_cv(1,nfsh,styr,endyr)     // Catch CV by fishery and year
  matrix obs_catch_lambda(1,nfsh,styr,endyr)     // Catch CV by fishery and year
  !! obs_catch_lambda = 0.5/square(obs_catch_cv);
  init_matrix    obs_effort(1,nfsh,styr,endyr)     // Effort by fishery and year
  !! obs_effort *= 1000;
  init_matrix obs_effort_cv(1,nfsh,styr,endyr)     // Effort CV by fishery and year
  matrix effort_lambda(1,nfsh,styr,endyr)     // Catch CV by fishery and year
  !! effort_lambda = 0.5/square(obs_effort_cv);
  init_ivector isex(1,nfsh)               // Index for sex by fishery 
  init_imatrix ieff(1,nfsh,styr,endyr)    // Index for effort dev by fishery and year
  init_imatrix iqfsh(1,nfsh,styr,endyr)   // Index for catchability dev by fishery and year
  init_imatrix iselfsh(1,nfsh,styr,endyr) // Index for selectivity dev by fishery and year
  init_matrix  F_midpt(1,nfsh,styr,endyr) // Midpoint of fishing effort (fraction of year) 
  !! log_input(obs_catch);
  !! obs_catch /= 2.2045;                         // Convert to tons
  !! log_input(obs_catch);
  !! log_input(obs_catch_cv);
  !! log_input(obs_effort);
  !! log_input(obs_effort_cv);
  !! log_input(isex);
  !! log_input(ieff);
  !! log_input(iqfsh);
  !! log_input(iselfsh);
  !! log_input(F_midpt);
  int neff_devs;
  int nqfsh;     
  int nselfsh;     
  !! neff_devs = max(ieff);   log_input(neff_devs);
  !! nqfsh     = max(iqfsh);  log_input(nqfsh);
  !! nselfsh   = max(iselfsh);log_input(nselfsh);
  init_ivector n_fsh_len(1,nfsh)                 // Number of length observations for each fishery
  init_imatrix  yrs_fsh_len(1,nfsh,1,n_fsh_len)  // Years of length observations for each fishery 
  init_matrix   nsam_fsh_len(1,nfsh,1,n_fsh_len) // sample sizes of length observations for each fishery 
  init_3darray  obs_fsh_len(1,nfsh,1,n_fsh_len,1,nlenbins) // sample sizes of length observations for each fishery 
 LOCAL_CALCS
  //normalize length freq to proportions
  for (int ifsh=1;ifsh<=nfsh;ifsh++)
    for (int i=1;i<=n_fsh_len(ifsh);i++)
      obs_fsh_len(ifsh,i) /= sum(obs_fsh_len(ifsh,i)); 
  log_input(n_fsh_len);
  log_input(n_fsh_len);
  log_input(yrs_fsh_len);
  log_input(nsam_fsh_len);
  log_input(obs_fsh_len);
 END_CALCS

  // Years and sample weights
  init_number nobs_srv                                // number of years of survey biomass data
  init_ivector yrs_srv(1,nobs_srv)                   // years which have survey biomass estimates
  init_int nobs_srv_length                            // number of years of survey male length data
  init_ivector yrs_srv_length(1,nobs_srv_length)     // years which have male length data
  init_4darray nsamples_srv_length(1,Nmat,1,Nshell,1,Nsex,1,nobs_srv_length) // number of samples for each length comp by immat,mat,new/old,sex,year
  // for length data
  // first index,1 immat, 2 mature,1 new shell, 2 old shell, then female 1 male 2
  init_5darray obs_p_srv_lend(1,Nmat,1,Nshell,1,Nsex,1,nobs_srv_length,1,nlenbins)  // immat,mat,new, old survey length data,female,male,year then bin
  init_vector obs_srv(1,nobs_srv)                    // survey numbers (total) in millions of crab
  init_matrix cv_srvo(1,Nsex,1,nobs_srv)             // survey cv
  matrix       sigma_srv(1,2,1,nobs_srv);
  matrix         var_srv(1,2,1,nobs_srv);
  
  LOCAL_CALCS
   log_input(nobs_srv);
   log_input(yrs_srv);
   log_input(nobs_srv_length);
   log_input(yrs_srv_length);
   log_input(nsamples_srv_length);
   log_input(obs_p_srv_lend);
   obs_srv /= 1000.;
   log_input(obs_srv);
   log_input(cv_srvo);
 END_CALCS
  init_matrix wtf(1,Nmat,1,nlenbins)                   // weight at length juvenile and mature females (from kodiak program)
  init_vector wtm(1,nlenbins)                          // weight at length males (same as used in kodiak)
  
  init_vector maturity_logistic(1,nlenbins)            // logistic maturity probability curve for new shell immature males
  init_matrix maturity_average(1,2,1,nlenbins)         // probability mature for new immature females, avearge proportion mature by length for new males
  init_matrix maturity_old_average(1,2,1,nlenbins)     // average proportion mature by length for old shell females, males
  init_matrix cv_mean_length_obs(1,2,1,2)              // cv of mean length for female and male min and max age (NOT USED)
  init_vector length_bins(1,nlenbins)                  // Midpoints of length bins
  init_number eof
 LOCAL_CALCS
   log_input(wtf);
   log_input(wtm);
   log_input(maturity_logistic);
   log_input(maturity_average);
   log_input(maturity_old_average);
   log_input(cv_mean_length_obs);
   log_input(length_bins);
   log_input(eof);
   if (eof!=123456789) {cout<<"Data read failed"<<endl;exit(1);}
  // End of reading normal data file 
    cout << "Completed reading data file" << endl;
  // Open control file....
    ad_comm::change_datafile_name("tc.ctl");
 END_CALCS
  // This should go in ctl file (number of years to 2nd-difference early recruits)
  int nyrs_2nd_diff
  !! nyrs_2nd_diff=30;
  init_int styr_fut                                                 // start year of future projections
  init_int endyr_fut                                                // end year of future projections
  init_number qsrv                                                    // Q  mult by pop biomass to get survey biomass
  init_vector M_in(1,Nsex)                                          // natural mortality females then males
  init_vector M_matn_in(1,Nsex)                                     // natural mortality mature new shell female/male
  init_vector M_mato_in(1,Nsex)                                     // natural mortality mature old shell female/male
  init_int phase_moltingp                                           // phase to estimate molting prob for mature males
  init_int phase_fishsel                                            // phase to estimate dome shape parameters for fishery selectivities
  init_int growth_switch                                            // switch for which growth function to use
  init_int survsel_som_phase                                        // switch for which survey selectivty to use for 1989 to present - positive estimated negative fixed at somerton and otto
  init_int survsel_phase                                           // switch for fixing all survey sel to somerton and otto - <0 fix, >0 estimate
  int survq_phase
  !! survq_phase = survsel_phase+1;
  init_int phase_fut                                                // phase to do F40% and future projection calculations
  init_vector median_rec(1,2)                                       // median recruitment value to use for last years in model (NOT USED)
  init_int median_rec_yrs                                           // median recruitment fixed for endyr to endyr-median_rec_yrs+1 (NOT USED)
  init_int nsellen                                                  // selectivity is set to the selectivity at nselages-1 after age nselages (NOT USED)
  init_int nsellen_srv                                             // same as above for survey selectivities
  init_int monot_sel                                                // switch for monotonically increasing selectivities (1 on 0 off) (NOT USED)
  init_int monot_sel_srv                                           // sames as above for survey (NOT USED)
  init_int phase_logistic_sel                                       // phase to estimate selectivities using logistic function
  init_int phase_selcoffs                                           // phase to estimate smooth selectivities (NOT USED)
  init_vector sel_som(1,5)                                          // parameters for somerton-otto selectivity curve
  
  init_vector wt_like(1,8)                                          // weights for selectivity likelihoods 1 fishery female, 2 survey female, 3 fishery male, 4 survey male
  init_vector like_wght(1,7)                                        // likelihood weights for fishery length data, survey length, age data, catch likelihood, survey biomass likelihood,growth like
  init_number like_wght_mbio                                        // likelihood weight for male biomass fit
  init_number like_wght_rec                                         // ??
  init_number like_wght_recf                                        // ??
  init_number like_wght_sexr                                        // ??
  init_number like_wght_sel50                                       // ??
  init_number like_wght_fph1                                        // ??
  init_number like_wght_fph2                                        // ??
  init_number like_wght_fdev                                        // ??
    //weights for constraint on monotonicity 1 fishery female, 2 fishery male, 3 survey female, 4 survey male

  init_number m_disc                                                // fraction of pot discards that die (.5)
  init_number m_trawl                                               // fraction of trawl discards that die(.8)
  
  init_number linff_obs                                             // Growth pars #1 (NOT USED
  init_number sd_linff                                              // Growth pars #1
  init_number linfm_obs                                             // Growth pars #1
  init_number sd_linfm                                              // Growth pars #1
  init_number growthkf_obs                                          // Growth pars #1
  init_number sd_growthkf                                           // Growth pars #1
  init_number growthkm_obs                                          // Growth pars #1
  init_number sd_growthkm                                           // Growth pars #1
  
  init_number af1_obs                                                // A-female
  init_number af2_obs                                                // A-female
  init_number sd_af                                                 // SD (A)
  init_number am1_obs                                                // A-male
  init_number am2_obs                                                // A-male
  init_number sd_am                                                 // SD (A)
  init_number bf1_obs                                                // B-female
  init_number bf2_obs                                                // B-female
  init_number sd_bf                                                 // SD (B) 
  init_number bm1_obs                                                // B-male
  init_number bm2_obs                                                // B-male
  init_number sd_bm                                                 // SD (B)
  
  init_number var_rec_obs                                           // (NOT USED)
  init_number sd_var_rec                                            // (NOT USED)
  init_number var_last_obs                                          // (NOT USED)
  init_number sd_var_last                                           // (NOT USED)
  init_number mate_ratio                                            // mating ratio (USED)
  init_number fraction_new_error                                    // accounts for shell error
  init_number maturity_switch                                       // Set > 0 for logistic maturity instead of fractions by year (males)
  init_int nages                                                    // number of ages to track for mature old shell 
  init_number wght_total_catch                                      // weight for total catch biomass (WHY here!)
  init_number wght_female_potcatch                                  // weight for female pot bycatch
  init_number cpue_cv                                               // cv for fit to fishery pot cpue
  init_number  wt_lmlike
  init_int     q_prior_switch
  init_int     extra_m_switch
  init_int     n_qs                                                  // number of catchability periods
  init_ivector yrs_q(1,n_qs)                                     // years in which catchability changed
  init_vector matestf_in(1,16);
  init_vector matestm_in(1,nlenbins);
  init_number  end_of_ctl;
  int phase_extra_m;
  !! if (extra_m_switch==1) phase_extra_m==8; else phase_extra_m==-8;
  !!cout<<"end of data reading"<<endl;
  int styr_rec;                                                     // rest are working variables 

 LOCAL_CALCS
  log_input(styr_fut);
  log_input(endyr_fut);
  log_input(qsrv);
  log_input(M_in(1,Nsex));
  log_input(M_matn_in(1,Nsex));
  log_input(M_mato_in(1,Nsex));
  log_input(phase_moltingp);
  log_input(phase_fishsel);
  log_input(growth_switch );
  log_input(survsel_som_phase  );
  log_input(survsel_phase);
  log_input(phase_fut);
  log_input(median_rec(1,2));
  log_input(median_rec_yrs);
  log_input(nsellen);
  log_input(nsellen_srv);
  log_input(monot_sel);
  log_input(monot_sel_srv);
  log_input(phase_logistic_sel);
  log_input(phase_selcoffs);
  log_input(sel_som(1,5));
  log_input(wt_like(1,8));
  log_input(like_wght(1,7));
  log_input(like_wght_mbio);
  log_input(like_wght_rec);
  log_input(like_wght_recf);
  log_input(like_wght_sexr);
  log_input(like_wght_sel50);
  log_input(like_wght_fph1);
  log_input(like_wght_fph2);
  log_input(like_wght_fdev);
  log_input(cpue_cv);
  log_input(wt_lmlike);
  log_input(end_of_ctl);
  log_input(nages);
  log_input(phase_extra_m);
   styr_rec = styr-nirec;                                           // year to start estimating recruits to get initial age comp
   if(nsellen>nlenbins) nsellen=nlenbins;                                 // make sure nselages not greater than nages
   if(nsellen_srv>nlenbins) nsellen_srv=nlenbins;                       // same as above for survey
   obs_srv=obs_srv*1000000;                                       // survey numbers read in are millions of crab
   wtf=wtf*0.001;                                                   // change weights to tons
   wtm=wtm*0.001;                                                    // change weights to tons
 END_CALCS

  vector tmps(1,nlenbins)                                              // Temporrary variable
  vector sumsrv(1,nobs_srv_length)                                 // Total survey numbers
  
  vector catch_tot(styr,endyr);                                     // Total catches
  matrix catch_disc(1,2,styr,endyr)                                 // Discard catch
  5darray obs_p_srv_len(1,2,1,2,1,2,1,nobs_srv_length,1,nlenbins)    // Length-frequency (survey)
  5darray obs_p_srv_len1(1,2,1,2,1,2,1,nobs_srv_length,1,nlenbins) 
  matrix obs_srv_spbiom(1,2,styr,endyr)                            // Survey biomass (by sex)
  3darray obs_srv_spnum(1,2,1,2,styr,endyr)                        // Survey number (by sex)
  vector obs_lmales(1,nobs_srv_length)                             // Large males in survey
  vector obs_lmales_bio(1,nobs_srv_length)                         // Male biomass
  
  3darray obs_srv_num(1,2,styr,endyr,1,nlenbins)                      // Survey numbers
  vector obs_srvt(styr,endyr)                                      // ???
  matrix obs_srv_bioms(1,2,styr,endyr)                             // Survey biomass by sex
  vector obs_srv_biom(styr,endyr)                                  // Total survey biomass

  vector avgpf(1,nlenbins)
  vector avgpm(1,nlenbins)
  vector avgp(1,nlenbins)
  vector obs_catcht_biom(styr,endyr)                                // Total catch  
  vector obs_catchdm_biom(styr,endyr)                               // Male discards
  vector obs_catchdf_biom(styr,endyr)                               // Female discards
  vector obs_catchtot_biom(styr,endyr)                              // Total catch (discard and retained_
  number avgwt2
  number avgwtall
  vector avgwt(styr,endyr)

// =======================================================================

INITIALIZATION_SECTION
  mean_log_rec 7.4
  logselfsh_a -2.5
  selfsh_b 110
  af1 0.5656
  bf1 0.913266
  am1 0.437941
  bm1 0.9487
// =======================================================================

PARAMETER_SECTION
  init_bounded_number af1(0.4,0.77,-8)                       // Female growth-increment
  init_bounded_number bf1(0.6,1.2,-8)                       // Female growth-increment
  init_bounded_number am1(0.3,0.6,-8)                       // Male growth-increment
  init_bounded_number bm1(0.7,1.2,-8)                       // Male growth-increment
  init_bounded_vector growth_beta(1,Nsex,0.75000,0.75001,-2)   // Growth beta
  init_bounded_vector matestf(1,16,-15.0,0.0,-5)
  init_bounded_vector matestm(1,nlenbins,-15.0,0.0,-5)
  init_bounded_number Mmult_imat(0.2,2.0,-7)                   // natural mortality females and males
  init_bounded_number Mmultm(0.1,1.9,-7)                       // natural mortality mature new and old shell male
  init_bounded_number Mmultf(0.1,1.9,-7)                       // natural mortality mature new and old shell female
  init_bounded_vector mat_big(1,2,0.1,10.0,phase_extra_m)      // mult. on 1983 M for mature males and females                     
  init_bounded_number alpha1_rec(11.49,11.51,-8)               // Parameters related to fraction recruiting
  init_bounded_number beta_rec(3.99,4.01,-8)                   // Parameters related to fraction recruiting
  
  init_bounded_number moltp_af(0.04,3.0,-6)                    // paramters for logistic function molting
  init_bounded_number moltp_bf(130.,300.,-6)                   // female
  init_bounded_number moltp_am(0.04,3.0,-5)                    // paramters for logistic function molting
  init_bounded_number moltp_bm(130.0,300.0,-5)                 // immature males
  init_bounded_number moltp_ammat(.0025,3.0,phase_moltingp)    // logistic molting prob for mature males
  init_bounded_number moltp_bmmat(1,120,phase_moltingp)        // logistic molting prob for mature males

  init_number mean_log_rec(1);   
  init_bounded_dev_vector rec_dev(styr,endyr,-15,15,2)      // Deviations about mean recruitment

  // Fundamental equation for fishing mortality------------------------------------
  // Fmort(ifsh,iyr) = Effort(ifsh,iyr)*qfsh(ifsh,iyr);
  matrix  Fmort(1,nfsh,styr,endyr)
  3darray F(1,nfsh,styr,endyr,1,nlenbins)              // F by fishery
  3darray Ftot(1,2,styr,endyr,1,nlenbins)              // F by sex    
  matrix  pred_effort(1,nfsh,styr,endyr)               // Effort (E w/ eff_devs)
  3darray    S(1,2,styr,endyr,1,nlenbins)              // Survival Jim
  init_vector eff_devs(1,neff_devs,3);
  init_vector qfsh(1,nqfsh,1);
  init_vector logselfsh_a(1,nselfsh,3);
  init_vector selfsh_b(1,nselfsh,2);
  matrix selfsh(1,nselfsh,1,nlenbins);

  init_bounded_number srv_sel95_m(70.0,200.,survsel_phase)
  init_bounded_number srv_sel50_m(0.0,90.,survsel_phase)
  init_bounded_number srv_sel95_f(70.0,200.,survsel_phase)
  init_bounded_number srv_sel50_f(0.0,90.,survsel_phase)
  init_vector         srv_sel95_m_dev(1,n_qs-1,survsel_phase+1)
  init_vector         srv_sel50_m_dev(1,n_qs-1,survsel_phase+1)
  init_vector         srv_sel95_f_dev(1,n_qs-1,survsel_phase+1)
  init_vector         srv_sel50_f_dev(1,n_qs-1,survsel_phase+1)
    
  init_bounded_number srv_q_f_par(0.0,1.2,survsel_phase)
  init_bounded_number srv_q_m_par(0.0,1.2,survsel_phase)
  init_vector         srv_q_f_dev(1,n_qs-1,survq_phase)
  init_vector         srv_q_m_dev(1,n_qs-1,survq_phase)
  ////end of estimated parameters///////////////

  matrix sel_srv_f(styr,endyr,1,nlenbins)                            // Survey selectivity 1
  matrix sel_srv_m(styr,endyr,1,nlenbins)                            // Survey selectivity 1
  vector srv_q_f(styr,endyr)                                      // Survey q 
  vector srv_q_m(styr,endyr)                                      // Survey q 

  vector popn(styr,endyr)                                  // Total population numbers (output)
  vector M(1,2)
  vector M_matn(1,2)
  vector M_mato(1,2)
  
  vector pred_bio(styr,endyr)                                       // Predicted biomass (determines depletion)
  
  matrix totn_srv(1,2,styr,endyr)                                  // total survey abundance
  vector fspbio(styr,endyr)                                         // Predicted female survey biomass
  vector mspbio(styr,endyr)                                         // Predicted male survey biomass
  vector legal_males(styr,endyr)                                    // Legal number of males
  vector legal_males_bio(styr,endyr)                                // Legal biomass (output)
  vector legal_srv_males(styr,endyr)                                // Survey-selected males (output)
  vector legal_srv_males_n(styr,endyr)                              // Survey-selected males (output)
  vector legal_srv_males_o(styr,endyr)                              // Survey-selected males (output)
  vector legal_srv_males_bio(styr,endyr)                            // Survey-selected males (output)
  matrix biom_tmp(1,2,styr,endyr);                                  // Predicted survey indices
  matrix pred_srv_spbiom(1,2,styr,endyr)                                    // Female survey biomass
  matrix fspbio_srv_num(1,2,styr,endyr)                            // Survey biomass (females) - output
  matrix mspbio_srv_num(1,2,styr,endyr)                            // Survey biomass (males) - output
  matrix pred_srv_bioms(1,2,styr,endyr)                            // Survey biomass (an output)
  3darray pred_srv(1,2,styr,endyr,1,nlenbins)                         // Predicted survey - output
  4darray pred_p_srv_len_new(1,2,1,2,styr,endyr,1,nlenbins)           // Predicted new shell length-frequency
  4darray pred_p_srv_len_old(1,2,1,2,styr,endyr,1,nlenbins)           // Predicted old shell length-frequency
  
  matrix  pred_catch(1,nfsh,styr,endyr)                            // Total catch (males, directed)
  3darray pred_fsh_len(1,nfsh,styr,endyr,1,nlenbins)             // Total catch (males, directed)

  3darray nal(1,2,styr,endyr,1,nlenbins)                            // Total numbers by sex, length, and year
  3darray nal_n(1,2,styr,endyr,1,nlenbins)                            // Total numbers by sex, length, and year
  3darray nal_o(1,2,styr,endyr,1,nlenbins)                            // Total numbers by sex, length, and year
  3darray nal_ma(1,2,styr,endyr,1,nlenbins)                            // Total numbers by sex, length, and year
  3darray nal_im_n(1,2,styr,endyr,1,nlenbins)                       // Total numbers by sex, length, and year
  3darray nal_im_o(1,2,styr,endyr,1,nlenbins)                       // Total numbers by sex, length, and year
  3darray nal_ma_n(1,2,styr,endyr,1,nlenbins)                       // Total numbers by sex, length, and year
  3darray nal_ma_o(1,2,styr,endyr,1,nlenbins)                       // Total numbers by sex, length, and year

  3darray len_len(1,2,1,nlenbins,1,nlenbins)                        // length to length growth array
  matrix     moltp(1,2,1,nlenbins)                                  // molting probabilities for female, male by length bin 
  matrix moltp_mat(1,2,1,nlenbins)                                  // molting probs for mature female, male by length bin
  matrix mean_length(1,2,1,nlenbins)                                // Predicted post-moult sizes
  vector rec_len(1,nlenbins)                                        // Recruitment length
  
  vector predpop_sexr(styr,endyr)                                   // Population sex-ratio - output
  4darray effn_srv(1,2,1,2,1,2,styr,endyr)                         // Survey effetive sample sizes
  matrix effn_fish_ret(1,2,styr,endyr)                              // Effective sample sizes:
  matrix effn_fish_tot(1,2,styr,endyr)                              // Effective sample sizes:
  
  // Offsets
  vector fsh_offset(1,nfsh)
  vector srv_offset(1,2)
  vector Fout(1,27);                                                // LIkelihoods and penalties
  
  // Penalties
  number nat_penalty
  number penal_rec                                                  // Recruitment
  number initsmo_penal                                              // Initial size-structure
  number initnum_penal                                              // Low size penalty
  number fpen                                                       // Penalties (misc)
  vector fmort_pen(1,7)                                             // vector of fmort dev penalties
  number sel_50m_penal                                              // Penalties on selectivity
  number af_penal                                                   // Prior on af 
  number srv3q_penalty
  number am_penal                                                   // Prior on am
  number bf_penal                                                   // Prior on bf
  number bm_penal                                                   // Prior on bm
  number penal_sexr                                                 // Penalty of sex ratio of recruitment            
  
  // Likelihood components
  vector fsh_len_like(1,nfsh)                                       // length data
  vector srv_len_like(1,4)                                       // length data
  vector catch_like(1,nfsh)                                         // Catch  likelihood components
  vector effort_like(1,nfsh)                                        // Effort likelihood components
  number srv_like                                                  // Survey biomass data
  number like_initn
  
  matrix maturity_est(1,2,1,nlenbins)                                  // Maturity-at-length

  // Outputs (not in the likelihood function)
  vector num_males_gt101(styr,endyr)
  vector bio_males_gt101(styr,endyr)
  vector pred_catch_gt101(styr,endyr)
  vector pred_catch_no_gt101(styr,endyr)

  number like_mat
  
  sdreport_vector fspbios(1974,endyr)                                // Sd_report stuff
  sdreport_vector mspbios(1974,endyr)
  sdreport_vector legal_malesd(1974,endyr)
  sdreport_number depletion
  objective_function_value obj_fun

 LOCAL_CALCS
   cout << "Phase: Moulting probabilities:       " << phase_moltingp << endl;
   cout << "Phase: Logistic selectivity pattern: " << phase_logistic_sel << endl;
   cout << "Phase: Dome-shaped selectivity:      " << phase_fishsel << endl;
   cout << "Phase: Survey selectivity #1         " << survq_phase << endl;
   cout << "Phase: Survey selectivity #2         " << survsel_phase << endl;
   cout << "Maturity switch:                     " << maturity_switch << endl;
   cout << "Growth switch:                       " << growth_switch << endl;
 END_CALCS

//  ========================================================================

PRELIMINARY_CALCS_SECTION
  int mat,shell,sex,l,ll,j,i,k,ii;  
  matestf = matestf_in;
  matestm = matestm_in;
  double ratio,sumtrawl,sumfishdiscf,sumPropn,sumfishdiscm,sumfishret,vall;
  // use logistic maturity curve for new shell males instead of fractions by year if switch>0
  // this would be for initial population not probability of moving to mature
  if(maturity_switch > 0)
  {
    maturity_average(2) = maturity_logistic;
  }
//Compute offset for multinomial
  srv_offset.initialize();
  sumsrv.initialize();
  for(ll=1; ll<=nobs_srv_length; ll++)
   for(mat=1;mat<=2;mat++)
    for(sex=1; sex<=2; sex++)
     for(j=1; j<=2; j++)
      sumsrv(ll) += sum(obs_p_srv_lend(mat,sex,j,ll));

  // Survey data  
  for(mat=1; mat<=2; mat++) //maturity
   for(shell=1; shell<=2; shell++) //shell condition
    for(sex=1; sex<=2;sex++) //sex
     for (i=1; i <= nobs_srv_length; i++)
      for (j=1; j<=nlenbins; j++)
       {
        // only do new/old shell correction for mature crab
        if(mat < 2)
         obs_p_srv_len1(mat,shell,sex,i,j) = obs_p_srv_lend(mat,shell,sex,i,j)/sumsrv(i);
        else
         if( shell < 2)
          obs_p_srv_len1(mat,shell,sex,i,j)=(obs_p_srv_lend(mat,shell,sex,i,j)*fraction_new_error)/sumsrv(i);
         else
          obs_p_srv_len1(mat,shell,sex,i,j)=(obs_p_srv_lend(mat,shell,sex,i,j)+obs_p_srv_lend(mat,1,sex,i,j)*(1.-fraction_new_error))/sumsrv(i);
       }

  // use logistic maturity curve for new and old shell male survey data if switch>0 instead of yearly samples
  // old shell already uses ok maturity curve (AEP only applies to OLD SHELL?)
  if(maturity_switch > 0)
   for(i=1; i <= nobs_srv_length; i++)
   {
     tmps = (obs_p_srv_len1(1,2,2,i)+obs_p_srv_len1(2,2,2,i));
     obs_p_srv_len1(2,2,2,i) = elem_prod(maturity_old_average(2),tmps);
     obs_p_srv_len1(1,2,2,i) = elem_prod(1.0-maturity_old_average(2),tmps);
   }
   
  // Store results
  obs_p_srv_len(1) = obs_p_srv_len1(1);
  obs_p_srv_len(2) = obs_p_srv_len1(2);

  // for maturity and shell condition together in survey length comp fits
  for(sex=1; sex<=2;sex++) //sex
    for (i=1; i <= nobs_srv_length; i++)
      for (j=1; j<=nlenbins; j++)
      { 
        vall = obs_p_srv_len(1,1,sex,i,j)+obs_p_srv_len(1,2,sex,i,j);
        srv_offset(1) -= nsamples_srv_length(2,1,sex,i)*vall*log(vall+p_const);
        vall = obs_p_srv_len(2,1,sex,i,j)+obs_p_srv_len(2,2,sex,i,j);
        srv_offset(2) -= nsamples_srv_length(2,2,sex,i)*vall*log(vall+p_const);
      } 
                            
  for (int ifsh=1; ifsh <= nfsh; ifsh++)
    for (int i=1;i<=n_fsh_len(ifsh);i++)
      fsh_offset(ifsh) -= nsam_fsh_len(ifsh,i)*obs_fsh_len(ifsh,i)*log(obs_fsh_len(ifsh,i)+p_const);
   
  log_input(srv_offset);
  log_input(fsh_offset);
  Couti(srv_offset);
  Couti(fsh_offset);
  obs_srv_num.initialize();
  obs_srv_biom.initialize();
  obs_srv_bioms.initialize();
  obs_srv_spbiom.initialize();
  obs_srv_spnum.initialize();
  for(i=1;i<=nobs_srv;i++) 
    obs_srvt(yrs_srv(i)) = obs_srv(i);
  
  // Compute survey biomass
  for(mat=1;mat<=2;mat++)  //maturity status
  {
   for(l=1;l<=2;l++)  //shell condition
   {
    for(sex=1;sex<=2;sex++)  //sex
    {
     for (i=1; i <= nobs_srv_length; i++)
     {
       obs_srv_num(sex,yrs_srv_length(i)) += obs_p_srv_len(mat,l,sex,i)*obs_srvt(yrs_srv_length(i));
       if(sex<2)
       {
         obs_srv_bioms(sex,yrs_srv_length(i)) += obs_p_srv_len(mat,l,sex,i)*obs_srvt(yrs_srv_length(i))*wtf(mat);
         obs_srv_biom(yrs_srv_length(i))      += obs_p_srv_len(mat,l,sex,i)*obs_srvt(yrs_srv_length(i))*wtf(mat);
       }
       else
       {
         obs_srv_bioms(sex,yrs_srv_length(i)) += obs_p_srv_len(mat,l,sex,i)*obs_srvt(yrs_srv_length(i))*wtm;
         obs_srv_biom(yrs_srv_length(i))    += obs_p_srv_len(mat,l,sex,i)*obs_srvt(yrs_srv_length(i))*wtm;
       }        

       //  sum to get mature biomass by sex (AEP index is mature animals only?)
       if(mat>1)
       {
         if(sex<2)
           obs_srv_spbiom(sex,yrs_srv_length(i)) += obs_p_srv_len(mat,l,sex,i)*obs_srvt(yrs_srv_length(i))*wtf(mat);
         else
           obs_srv_spbiom(sex,yrs_srv_length(i)) += obs_p_srv_len(mat,l,sex,i)*obs_srvt(yrs_srv_length(i))*wtm;
         
         obs_srv_spnum(l,sex,yrs_srv_length(i)) += sum(obs_p_srv_len(mat,l,sex,i)*obs_srvt(yrs_srv_length(i)));
         sigma_srv(sex,i) = cv_srvo(sex,i);
         var_srv(sex,i)   = sigma_srv(sex,i) * sigma_srv(sex,i);
       }
     }
     } //sex
     } //shell condition
     } // End of maturity loop?
     log_input(sigma_srv);
     log_input(var_srv);

  // Number of large males
  obs_lmales.initialize();
  obs_lmales_bio.initialize();
  for(i=1;i<=nobs_srv_length;i++)
   {
    // take 1/2 of the 100-104 bin, 
    obs_lmales(i) = 0.5*obs_srv_num(2,yrs_srv_length(i),23);
    obs_lmales_bio(i) = obs_lmales(i)*wtm(23);
    for(j=24;j<=nlenbins;j++)
     {
      obs_lmales(i) += obs_srv_num(2,yrs_srv_length(i),j);
      obs_lmales_bio(i) += obs_srv_num(2,yrs_srv_length(i),j)*wtm(j);
     }
   }
  // Historical approximation to observed catch biomass
  // Compute the moulting probabilities
  get_moltingp();
  // estimate growth function
  get_growth();
  // Set maturity
  get_maturity();
  cout<<"end prelim calcs"<<endl;
// ============================================================================

PROCEDURE_SECTION
  // Update growth (if the parameters are being estimated)
  if (active(moltp_af) || active(moltp_bf) || active(moltp_am) || active(moltp_bm) || active(moltp_ammat) || active(moltp_bmmat)) 
     get_moltingp();
  // growth estimated in prelimn calcs if growth parameters estimated in the model
  // then will redo growth matrix, otherwise not
   if(active(am1) || active(bm1) || active(af1) || active(bf1) || active(growth_beta)) 
     get_growth();
   get_maturity();
   get_selectivity();
   get_mortality();
   get_numbers_at_len_jim();
   get_catch_at_len_jim();
   get_survey_predictions();
   evaluate_the_objective_function();
// ----------------------------------------------------------------------
FUNCTION get_maturity
  int j;
  if(active(matestm))
  {
    maturity_est(1)(1,16) = mfexp(matestf);
    maturity_est(1)(17,nlenbins) = 1.;
    maturity_est(2) = mfexp(matestm);
  }
  else
  {    
    maturity_est(1) = maturity_average(1);
    maturity_est(2) = maturity_average(2);
  }
// --------------------------------------------------------------------------

FUNCTION get_growth
  int ilen,il2,sex;
  dvariable devia, alpha_rec,alpha,lensum;
  dvariable growinc_67, growinc_90;
  len_len.initialize();
//  growinc_90 = am2 + bm2 * 90.0 - 90.0;
//  growinc_67 = am1 + bm1 * 67.5 - 67.5;
  for(ilen=1;ilen<=nlenbins;ilen++)
  { 
    //linear growth curve
    if(growth_switch==1)
    {
      mean_length(1,ilen)= mfexp(af1)* pow(length_bins(ilen),bf1);
     if(ilen<17){    
        mean_length(2,ilen)= mfexp(am1)* pow(length_bins(ilen),bm1);
      }
      else{
        mean_length(2,ilen)= mfexp(am1)* pow(length_bins(ilen),bm1);
      }
    }
   }
// using Gamma function for transition matrix
// devia is the bounds of growth bins to evaluate
// the gamma function (x) in prop = integral(i1 to i2) g(x|alpha,beta) dx
// alpha and growth_beta are parameters 
// alpha is the mean growth increment per molt for some premolt length class
// alpha = mean growth increment per molt divided by beta
// beta is the shape parameter - larger beta - more variance 
  for (sex=1;sex<=2;sex++)
  {
    for(ilen=1;ilen<=nlenbins;ilen++)
    {
     // subract the 2.5 from the midpoint of the length bin to get the lower bound
      alpha = (mean_length(sex,ilen)-(length_bins(ilen)-2.5))/growth_beta(sex);
      lensum = 0;
// this statement non-truncated growth transition
// for(il2=ilen;il2<=nlenbins;il2++)
//    truncate growth transition to max=10 bins
      for(il2=ilen;il2<=ilen+min(10,nlenbins-ilen);il2++)
      {
          devia = length_bins(il2)+2.5-length_bins(ilen);
          len_len(sex,ilen,il2) = pow(devia,(alpha-1.))*exp(-devia/growth_beta(sex));
//        len_len(sex,ilen,il2) = mfexp( log(devia)*(alpha-1.) - devia/growth_beta(sex));
          lensum += len_len(sex,ilen,il2);
      }  
      len_len(sex,ilen) /= sum(len_len(sex,ilen));
    }
  }
 // Fraction recruiting
  alpha_rec=alpha1_rec/beta_rec;
  for(ilen=1;ilen<=nlenbins;ilen++)
  {
    devia = length_bins(ilen)+2.5-length_bins(1);
//    rec_len(ilen) =  mfexp( log(devia)*(alpha_rec-1.) - devia/beta_rec);
    rec_len(ilen) =  pow(devia,alpha_rec-1.)*mfexp(-devia/beta_rec);
  }
  //standardize so each row sums to 1.0
  rec_len /= sum(rec_len);
// -------------------------------------------------------------------------
FUNCTION get_moltingp
  int j;
  //assuming a declining logistic function
  for(j=1;j<=nlenbins;j++)
  {
    // logistic molting females then males
    moltp(1,j)=1-(1./(1.+mfexp(-1.*moltp_af*(length_bins(j)-moltp_bf))));
    moltp(2,j)=1-(1./(1.+mfexp(-1.*moltp_am*(length_bins(j)-moltp_bm))));

    // set molting prob for mature females at 0.0
    moltp_mat(1,j)=0.0;
    // molting probability can be one (or estimated)
    if(phase_moltingp > 0)
     moltp_mat(2,j) = 1-(1./(1.+mfexp(-1.*moltp_ammat*(length_bins(j)-moltp_bmmat))));
    else
     moltp_mat(2,j) = 0.0;
  }

// -------------------------------------------------------------------------
FUNCTION get_selectivity
  for (int i=1;i<=nselfsh;i++)
    selfsh(i) = 1./(1.+mfexp(-mfexp(logselfsh_a(i))*(length_bins-selfsh_b(i))));
  get_srv_selectivity();

FUNCTION get_srv_selectivity
    // somerton and otto curve for survey selectivities
    // need to get time-periods for selectivity
    if (survsel_som_phase<0)
      // This would need fixing...to work with tc version 2
      sel_srv_m(styr) = 1./(1.+sel_som(2)*mfexp(-1.*sel_som(3)*length_bins));
    else
    {
      for (int iyr=styr;iyr<yrs_q(1);iyr++)
      {
        srv_q_f(iyr) = srv_q_f_par;
        srv_q_m(iyr) = srv_q_m_par;
        sel_srv_f(iyr) = srv_q_f(iyr) /(1.+mfexp(-1.*log(19.)*(length_bins-srv_sel50_f)/(srv_sel95_f-srv_sel50_f)));
        sel_srv_m(iyr) = srv_q_m(iyr) /(1.+mfexp(-1.*log(19.)*(length_bins-srv_sel50_m)/(srv_sel95_m-srv_sel50_m)));
      }
      dvariable srvq_f_tmp ;
      dvariable srvq_m_tmp ;
      dvariable srv50_f_tmp ;
      dvariable srv50_m_tmp ;
      dvariable srv95_f_tmp ;
      dvariable srv95_m_tmp ;
      for (int iq=1;iq<=n_qs;iq++)
      {
        if (iq>1)
        {
          srvq_f_tmp = srv_q_f_par*mfexp(srv_q_f_dev(iq-1));
          srvq_m_tmp = srv_q_m_par*mfexp(srv_q_m_dev(iq-1));
          srv50_f_tmp = srv_sel50_f*mfexp(srv_sel50_f_dev(iq-1));
          srv50_m_tmp = srv_sel50_m*mfexp(srv_sel50_m_dev(iq-1));
          srv95_f_tmp = srv_sel95_f*mfexp(srv_sel95_f_dev(iq-1));
          srv95_m_tmp = srv_sel95_m*mfexp(srv_sel95_m_dev(iq-1));
        }
        else
        {
          srvq_f_tmp = srv_q_f_par;
          srvq_m_tmp = srv_q_m_par;
          srv50_f_tmp = srv_sel50_f;
          srv50_m_tmp = srv_sel50_m;
          srv95_f_tmp = srv_sel95_f;
          srv95_m_tmp = srv_sel95_m;
        }
        int period_end;
        if (iq<n_qs)
          period_end=yrs_q(iq+1);
        else
          period_end=endyr+1;
        // In between years of q's
        for (int iyr=yrs_q(iq);iyr<period_end;iyr++)
        {
          // Set q, then selectivity 
          srv_q_f(iyr) = srvq_f_tmp;
          srv_q_m(iyr) = srvq_m_tmp;
          sel_srv_f(iyr) = srv_q_f(iyr) / (1.+mfexp(-1.*log(19.)*(
                           length_bins-srv50_f_tmp)/(srv95_f_tmp-srv50_f_tmp)));
          sel_srv_m(iyr) = srv_q_m(iyr) / (1.+mfexp(-1.*log(19.)*(
                           length_bins-srv50_m_tmp)/(srv95_m_tmp-srv50_m_tmp)));
        }
      }
    }
// -------------------------------------------------------------------------

FUNCTION get_mortality
  int i,shell;
  int inc,ii; inc=0;
  M(1)= M_in(1)*Mmult_imat;
  M(2)= M_in(2)*Mmult_imat;
  M_matn(2)= M_matn_in(2)*Mmultm;
  M_mato(2)= M_mato_in(2)*Mmultm;
  M_matn(1)= M_matn_in(1)*Mmultf;
  M_mato(1)= M_mato_in(1)*Mmultf;
  // New Fmort specification.......................................
  F.initialize();
  Ftot.initialize();
  int isx;
  for (int ifsh=1;ifsh<=nfsh;ifsh++)
  {
    // This is the annual component of effort: E*q*e^eff_devs
    isx=isex(ifsh);
    for (int iyr=styr;iyr<=endyr;iyr++)
    {
      pred_effort(ifsh,iyr) = obs_effort(ifsh,iyr)*mfexp(eff_devs(ieff(ifsh,iyr)));
      Fmort(ifsh,iyr)  = pred_effort(ifsh,iyr) * mfexp(qfsh(iqfsh(ifsh,iyr)));
      F(ifsh,iyr)   += Fmort(ifsh,iyr) * selfsh(iselfsh(ifsh,iyr)) ;
      Ftot(isx,iyr) += F(ifsh,iyr);
      S(isx,iyr)     = mfexp(-Ftot(isx,iyr));
    }
  }

FUNCTION get_numbers_at_len_jim
  //numbers at length from styr to endyr
  dvar_vector tmpi_n(1,nlenbins);tmpi_n.initialize();
  dvar_vector tmpi_o(1,nlenbins);tmpi_o.initialize();
  dvar_vector tmpm_n(1,nlenbins);tmpm_n.initialize();
  dvar_vector tmpm_o(1,nlenbins);tmpm_o.initialize();
  dvar_vector surv_fsh(1,nlenbins);
  nal.initialize();
  nal_n.initialize();
  nal_o.initialize();
  nal_im_n.initialize();
  nal_im_o.initialize();
  nal_ma_n.initialize();
  nal_ma_o.initialize();
  for(int sex=1;sex<=2;sex++)
  {
    dvariable surv_nat=mfexp(-M(sex));
    nal_im_n(sex,styr) = mfexp(mean_log_rec + rec_dev(styr) ) * rec_len ;
    for (int iyr=styr;iyr< endyr;iyr++)
    {
      // Set survival due to fishing...
      surv_fsh = S(sex,iyr);
      // Survive fishing, molt, survive beginning of the year
    // Immatures....................
      // Numbers advancing to new shell...(new to new)
      tmpi_n = elem_prod(moltp(sex),elem_prod(surv_fsh,nal_im_n(sex,iyr)));
      nal_im_n(sex,iyr+1)  = surv_nat * tmpi_n * len_len(sex);
      // Old shells becoming new
      tmpi_o = elem_prod(moltp(sex),elem_prod(surv_fsh,nal_im_o(sex,iyr)));
      nal_im_n(sex,iyr+1) += surv_nat * tmpi_o * len_len(sex);
      nal_n(sex,iyr+1)  += nal_im_n(sex,iyr+1) ;
      // dvar_vector tmpo = Surv1*elem_prod(moltp(sex),elem_prod(Smat(sex,2,i),natlength_iold(sex,i)));
      // natlength_new(sex,i+1) +=  tmpo * len_len(sex);

      // Subtract off molters Jim "AFTER SURVIVING????"  Had to do this to avoid negative numbers....
      nal_im_o(sex,iyr+1)  = surv_nat * (elem_prod(surv_fsh,nal_im_n(sex,iyr)) + 
                                         elem_prod(surv_fsh,nal_im_o(sex,iyr)) - tmpi_n - tmpi_o);
    // Matures....................
      tmpm_n = elem_prod(moltp_mat(sex),elem_prod(surv_fsh,nal_ma_n(sex,iyr)));
      nal_ma_n(sex,iyr+1)  = surv_nat * tmpm_n * len_len(sex);
      // Old shells becoming new
      tmpm_o = elem_prod(moltp_mat(sex),elem_prod(surv_fsh,nal_ma_o(sex,iyr)));
      nal_ma_n(sex,iyr+1) += surv_nat * tmpm_o * len_len(sex);

      // Subtract off molters Jim "AFTER SURVIVING????"  Had to do this to avoid negative numbers....
      nal_ma_o(sex,iyr+1) = surv_nat * (elem_prod(surv_fsh,nal_ma_n(sex,iyr)) + 
                                        elem_prod(surv_fsh,nal_ma_o(sex,iyr)) - tmpm_n - tmpm_o);

      // this is for estimating the fraction of new shell that move to old shell to fit
      // the survey data that is split by immature and mature
      // natlength_mnew(sex,i+1) += elem_prod(maturity_est(sex),natlength_new(sex,i+1));
      nal_ma_n(sex,iyr+1) += elem_prod(maturity_est(sex),nal_n(sex,iyr+1));
      // natlength_inew(sex,i+1) = elem_prod(1.0-maturity_est(sex),natlength_new(sex,i+1));
      nal_im_n(sex,iyr+1)  = elem_prod(1.0-maturity_est(sex),nal_n(sex,iyr+1));

      nal_im_n(sex,iyr+1) = mfexp(mean_log_rec + rec_dev(iyr) ) * rec_len ;

      nal_n(sex,iyr+1)    = nal_im_n(sex,iyr+1) + nal_ma_n(sex,iyr+1);
      nal_o(sex,iyr+1)    = nal_im_o(sex,iyr+1) + nal_ma_o(sex,iyr+1);
      // natlength_mat(sex,i+1)     = natlength_mnew(sex,i+1) + natlength_mold(sex,i+1);
      // natlength_i(sex,i+1)       = natlength_inew(sex,i+1) + natlength_iold(sex,i+1);
      // natlength(sex,i+1)         = natlength_mat(sex,i+1)  + natlength_i(sex,i+1);
      nal_ma(sex,iyr+1)     = nal_ma_n(sex,iyr+1) + nal_ma_o(sex,iyr+1);
      nal(sex,iyr+1) = nal_im_n(sex,iyr+1) +nal_im_o(sex,iyr+1) + nal_ma(sex,iyr+1)    ;
    }
  }
FUNCTION get_catch_at_len_jim
  double increm;
  pred_fsh_len.initialize();
  pred_catch.initialize();
  dvar_vector ratio1(1,nlenbins);
  for(int ifsh=1;ifsh<=nfsh;ifsh++)
  {
    int isx=isex(ifsh);
    dvector wt_tmp(1,nlenbins);
    if (isx==1) wt_tmp=wtm; else wt_tmp=wtf(2); 
    for (int iyr=styr;iyr< endyr;iyr++)
    {
      if (obs_effort(ifsh,iyr)>0)
      {
        increm = F_midpt(ifsh,iyr);
        ratio1 = elem_prod(elem_div( F(ifsh,iyr),Ftot(isx,iyr)+1e-6) , (1-S(isx,iyr)));
        //Cout(ratio1);
        pred_fsh_len(ifsh,iyr)    = ratio1*(nal(isx,iyr)*exp(-increm*M(isx)));
        pred_catch(ifsh,iyr)        = wt_tmp * pred_fsh_len(ifsh,iyr);
        // cout<<ifsh<<" "<<iyr<<" "<<Ftot(isx,iyr)<<endl;
        pred_fsh_len(ifsh,iyr) /= sum(pred_fsh_len(ifsh,iyr)  ); 
      }
    }
  }       

// -------------------------------------------------------------------------
FUNCTION get_survey_predictions
  int itmp, jk, sex, j, i;
  dvar_matrix tmpo(1,2,styr,endyr);
  dvariable tmpi,Surv1,Surv2,Surv3,Surv4,Surv5,Surv6;
  dvariable totSrvNum;
  pred_bio.initialize();
  fspbio.initialize();
  mspbio.initialize(); 
  legal_males.initialize();
  legal_srv_males.initialize();
  for (i=styr;i<=endyr;i++)
  {
    totn_srv(1,i) = nal(1,i)*srv_q_f(i)*sel_srv_f(i);
    totn_srv(2,i) = nal(2,i)*srv_q_m(i)*sel_srv_m(i);
    // Jim Unsure why this is done here
    // this is predicted survey in numbers not biomass-don't adjust by max selectivity 
    totn_srv(1,i) = nal(1,i)*sel_srv_f(i);
    totn_srv(2,i) = nal(2,i)*sel_srv_m(i);

    totSrvNum = totn_srv(1,i) + totn_srv(2,i)+1e-7;
    pred_p_srv_len_new(1,1,i) = elem_prod(sel_srv_f(i),nal_im_n(1,i))/totSrvNum;
    pred_p_srv_len_old(1,1,i) = elem_prod(sel_srv_f(i),nal_im_o(1,i))/totSrvNum;
    pred_p_srv_len_new(2,1,i) = elem_prod(sel_srv_f(i),nal_ma_n(1,i))/totSrvNum;
    pred_p_srv_len_old(2,1,i) = elem_prod(sel_srv_f(i),nal_ma_o(1,i))/totSrvNum;

    pred_p_srv_len_new(1,2,i) = elem_prod(sel_srv_m(i),nal_im_n(2,i))/totSrvNum;
    pred_p_srv_len_old(1,2,i) = elem_prod(sel_srv_m(i),nal_im_o(2,i))/totSrvNum;
    pred_p_srv_len_new(2,2,i) = elem_prod(sel_srv_m(i),nal_ma_n(2,i))/totSrvNum;
    pred_p_srv_len_old(2,2,i) = elem_prod(sel_srv_m(i),nal_ma_o(2,i))/totSrvNum;

    fspbio(i) = nal_ma(1,i)*wtf(2);
    mspbio(i) = nal_ma(2,i)*wtm;
    // Selection pattern
    // if (i<1974) sel_srv_use = sel_srv;
    pred_srv_spbiom(1,i) = qsrv*nal_ma(1,i)*elem_prod(wtf(2),sel_srv_f(i));
    pred_srv_spbiom(2,i) = qsrv*nal_ma(2,i)*elem_prod(wtm   ,sel_srv_m(i));

//  im_new x femwt_im + (mat_new + mat_old) x femwt_mat  
    pred_bio(i) += nal_im_n(1,i)*wtf(1)+(nal_ma_n(1,i)+nal_ma_o(1,i))*wtf(2)+
                  (nal_im_n(2,i)+nal_ma_n(2,i)+nal_ma_o(2,i))*wtm;
    // legal is >=138mm take half the numbers in the 135-139 bin
    legal_males(i)=0.5*nal(2,i,23);
    legal_males(i) += sum(nal(2,i)(24,nlenbins));
    legal_srv_males(i)  = 0.5*nal(2,i,23)*sel_srv_m(i,23);
    legal_srv_males(i) += sum(elem_prod(nal(2,i)(24,nlenbins),sel_srv_m(i)(24,nlenbins)));
  }
  depletion = pred_bio(endyr) / pred_bio(styr);
  fspbios = fspbio(1974,endyr);
  mspbios = mspbio(1974,endyr);
  legal_malesd = legal_males(1974,endyr);
// ---------------------------------------------------------------------------

FUNCTION evaluate_the_objective_function
  Fout.initialize();
  penal_rec.initialize();
  if (active(rec_dev))
  {
    //recruitment likelihood - norm2 is sum of square values   
    penal_rec  = 1.0*like_wght_recf*norm2(rec_dev); 
    penal_rec += 1.0*norm2(first_difference(rec_dev(styr,styr+nyrs_2nd_diff)));
    obj_fun += penal_rec; 
    Fout(1) = penal_rec; 
    // Couti(penal_rec);
  } 
  // LIKELIHOODS
  // Fishery length likelihood (old and new shell together)
  fsh_len_like.initialize();
  for (int ifsh=1; ifsh <= nfsh; ifsh++)
  {
    // Vector (sample size) x matrix (yr,length)
    for (int i=1; i <= n_fsh_len(ifsh); i++)
    {
      fsh_len_like(ifsh) -= nsam_fsh_len(ifsh,i) * obs_fsh_len(ifsh,i) *
                            log(pred_fsh_len(ifsh,yrs_fsh_len(ifsh,i)) + p_const);
    }
    //Add the offset to the likelihood   
    fsh_len_like(ifsh) -= fsh_offset(ifsh);
  }
  Fout(4) = sum(fsh_len_like);
  obj_fun += Fout(4);

  // survey likelihood
  srv_len_like.initialize();
  for(int k=1;k<=2;k++){  //sex
    for (int i=1; i <=nobs_srv_length; i++)
    {
      int ii=yrs_srv_length(i);
      for (int j=1; j<=nlenbins; j++)
      {
        // obs(maturity, SC, sex, year), pred(maturity,sex, year)
        // this is for mature new and old shell together
        srv_len_like(2) -= nsamples_srv_length(2,1,k,i)*(
                       obs_p_srv_len(2,1,k,i,j)+
                       obs_p_srv_len(2,2,k,i,j))*
                       log(pred_p_srv_len_new(2,k,ii,j)+
                           pred_p_srv_len_old(2,k,ii,j)+p_const);
        // immature new and old together
        srv_len_like(1) -= nsamples_srv_length(2,2,k,i)*(
                       obs_p_srv_len(1,1,k,i,j)+
                       obs_p_srv_len(1,2,k,i,j))*
                       log(pred_p_srv_len_new(1,k,ii,j)+
                           pred_p_srv_len_old(1,k,ii,j)+p_const);
       }  //j loop     
     }// year loop
   } //sex loop
   // cout << pred_p_srv_len_new(2,1)<<endl;
   srv_len_like(2) -= srv_offset(2);
   srv_len_like(1) -= srv_offset(1);
  
  obj_fun += sum(srv_len_like) + sum(fsh_len_like);
  // Couti(srv_len_like);
  // Couti(fsh_len_like);

  // this fits mature biomass separate male and female
  //female biomass only for 1974 to endyr, male biomass from 1969 to endyr
  srv_like.initialize();
  for (int i=1;i<=nobs_srv;i++)
  {
    srv_like += 0.5*square(log(obs_srv_spbiom(1,yrs_srv(i))+.000001)-log(pred_srv_spbiom(1,yrs_srv(i))+.000001))/
                 var_srv(1,i);
    srv_like += 0.5*square(log(obs_srv_spbiom(2,yrs_srv(i))+.000001)-log(pred_srv_spbiom(2,yrs_srv(i))+.000001))/
                 var_srv(2,i);
  }

  Fout(19) = srv_like;  
  // Couti(srv_like);
  obj_fun += srv_like; 

  // ===============================================================
  // catch likelihoods
  // don't include last year as that would be endyr+1 fishery season
  // ===============================================================
  catch_like.initialize();
  effort_like.initialize();
  dvar_vector devtmp(styr,endyr);
  for (int ifsh=1; ifsh <= nfsh; ifsh++)
  {
    devtmp            = square(log(pred_catch(ifsh)+1e-5)-log(obs_catch(ifsh)+1e-5));
    catch_like(ifsh)  = sum(elem_prod(obs_catch_lambda(ifsh),devtmp));
    devtmp            = square(log(pred_effort(ifsh)+1e-5)-log(obs_effort(ifsh)+1e-5));
    effort_like(ifsh) = sum(elem_prod(effort_lambda(ifsh),devtmp));
  }
  Fout(5)=sum(catch_like);
  obj_fun += Fout(5);
  Fout(6)=sum(effort_like);
  obj_fun += Fout(6);
  // Cout(effort_like); Cout(catch_like);

FUNCTION Biological_Priors
  //nat Mort. penalty
  if(active(Mmult_imat))
  {  
    nat_penalty = 0.5 * square((Mmult_imat - 1.0) / 0.05);
    obj_fun += nat_penalty; Fout(27) += nat_penalty;
  }
  if(active(Mmultm))
  {  
    nat_penalty = 0.5 * square((Mmultm - 1.0) / 0.05);
    obj_fun += nat_penalty; Fout(27) += nat_penalty;
  }
  if(active(Mmultf))
  {  
    nat_penalty = 0.5 * square((Mmultf - 1.0) / 0.05);
    obj_fun += nat_penalty; Fout(27) += nat_penalty;
  }

  //penalty on survey Q
  if (q_prior_switch==1) { }
  // Bayesian part - likelihood on growth parameters af,am,bf,bm
  // not used in this case
  af_penal = 0; bf_penal = 0; am_penal = 0; bm_penal = 0;
  if(active(af1))
  {  
    bf_penal = 0.5 * square((bf1 - 0.9132661) / 0.025);
    obj_fun += bf_penal; Fout(5) = bf_penal;
    af_penal = 0.5 * square((af1 - 0.56560241)    / 0.1);
    obj_fun += af_penal; Fout(5) += af_penal;
  }
  if(active(am1))
  {
    am_penal   = 0.5 * square((am1 - 0.437941)/0.025);
    obj_fun += am_penal; Fout(6) = am_penal;
  }
  if(active(bm1))
  {
    //am_penal   = 0.5 * square((am1 - 0.437941)/0.025);
    bm_penal = 0.5 * square((bm1 - 0.9487) /0.1);
    obj_fun += bm_penal; Fout(7) = bm_penal;
  }
  if(active(matestm))
  {
    like_mat  = 1.0*norm2(first_difference(first_difference(matestf)));
    like_mat += 0.5*norm2(first_difference(first_difference(matestm)));
//    like_mat += 2.0*norm2(maturity_est(2)-maturity_logistic)/(0.05*0.05);
//    like_mat += 1.0*norm2(maturity_est(1)-maturity_average(1))/(0.05*0.05);
    obj_fun += like_mat;
    Fout(3)= like_mat;
  }
  
// ========================y==================================================
 /*
FUNCTION Misc_output
  int i,j,ii,ij,k,sex;
  dvariable tmpi;
  dvar_matrix sel_srv_use(1,2,1,nlenbins);
  dvar_matrix cv_srv_nowt(1,2,styr,endyr);
 //legal size for tanner is 138mm
  pred_catch_gt101.initialize();
  pred_catch_no_gt101.initialize();
//   cout<<" to misc output "<<endl;
  //weight each years estimate by 1/(2*variance) - use cv of biomass in sqrt(log(cv^2+1)) as sd of log(biomass) 
  for(i=1;i<=nobs_srv;i++)
  {
    cv_srv_nowt(1,yrs_srv(i)) = cv_srvo(1,i);
    cv_srv_nowt(2,yrs_srv(i)) = cv_srvo(2,i);
    biom_tmp(1,yrs_srv(i)) = fspbio_srv(yrs_srv(i));
    biom_tmp(2,yrs_srv(i)) = mspbio_srv(yrs_srv(i));
  }
  
  // Combined likelihood
  for (i=styr;i<=endyr;i++)
    for (j = 23 ; j<= nlenbins; j++)
    {
       pred_catch_no_gt101(i) += (F(1,i,j)/(F(1,i,j)+Fdisct(2,i,j)))*natl_inew_fishtime(2,i,j)*(1-Smat(2,1,i,j)) + 
                               (F(1,i,j)/(F(1,i,j)+Fdisct(2,i,j)))*natl_mnew_fishtime(2,i,j)*(1-Smat(2,1,i,j))+ 
                               (F(2,i,j)/(F(2,i,j)+Fdisct(2,i,j)))*natl_iold_fishtime(2,i,j)*(1-Smat(2,2,i,j))+
                               (F(2,i,j)/(F(2,i,j)+Fdisct(2,i,j)))*natl_mold_fishtime(2,i,j)*(1-Smat(2,2,i,j));
       pred_catch_gt101(i)+= (F(1,i,j)/(F(1,i,j)+Fdisct(2,i,j)))*natl_inew_fishtime(2,i,j)*(1-Smat(2,1,i,j)) + 
                           (F(1,i,j)/(F(1,i,j)+Fdisct(2,i,j)))*natl_mnew_fishtime(2,i,j)*(1-Smat(2,1,i,j))+ 
                           (F(2,i,j)/(F(2,i,j)+Fdisct(2,i,j)))*natl_iold_fishtime(2,i,j)*(1-Smat(2,2,i,j))+
                           (F(2,i,j)/(F(2,i,j)+Fdisct(2,i,j)))*natl_mold_fishtime(2,i,j)*(1-Smat(2,2,i,j)) * wtm(j);
     if (j<24) // AEP???
       {
        pred_catch_gt101(i)=pred_catch_gt101(i)*0.5;
        pred_catch_no_gt101(i)=pred_catch_no_gt101(i)*0.5;
       }
    }
// cout<<" to large males "<<endl;
  bio_males_gt101.initialize();
  num_males_gt101.initialize();
  for (i=styr;i<=endyr;i++)
   for(j=23;j<=nlenbins;j++)
    {
     num_males_gt101(i)+= natl_inew_fishtime(2,i,j) + natl_iold_fishtime(2,i,j) + natl_mnew_fishtime(2,i,j) + natl_mold_fishtime(2,i,j);
     bio_males_gt101(i)+= (natl_inew_fishtime(2,i,j) + natl_iold_fishtime(2,i,j) + natl_mnew_fishtime(2,i,j) + natl_mold_fishtime(2,i,j))*wtm(j);
     if (j<24)
      {
       num_males_gt101(i)=num_males_gt101(i)*0.5;
       bio_males_gt101(i)=bio_males_gt101(i)*0.5;
      }
    }
//  cout<<" to eff N "<<endl;
  // Effective N's
  for (i=1; i <= nobs_fish; i++)
  {
    for(k=1;k<=2;k++)
    {
      ii=yrs_fish(i);
      if(sum(obs_p_fish_ret(k,i))<0.00001)
        effn_fish_ret(k,ii)=1/(norm2(pred_p_fish_fit(k,ii)-obs_p_fish_ret(k,i))/(pred_p_fish_fit(1,ii)*(1-pred_p_fish_fit(1,ii))+pred_p_fish_fit(2,ii)*(1-pred_p_fish_fit(2,ii))));
    } 
  } 
  for (i=1; i <= nobs_fish_discm; i++)
  {
    ij=yrs_fish_discm(i);
    for(k=1;k<=2;k++)
      if(sum(obs_p_fish_tot(k,i))<0.00001)
        effn_fish_tot(k,ij)=1/(norm2(pred_p_fish(k,ij)-obs_p_fish_tot(k,i))/(pred_p_fish(1,ij)*(1-pred_p_fish(1,ij))+pred_p_fish(2,ij)*(1-pred_p_fish(2,ij))));
  }
  for(k=1;k<=2;k++)  //sex
    for (i=1; i <=nobs_srv_length; i++)
    {
      ii=yrs_srv_length(i);
      effn_srv(1,1,k,ii)=1./(norm2(pred_p_srv_len_new(1,k,ii)-obs_p_srv_len(1,1,k,i))/(pred_p_srv_len_new(1,1,ii)*(1-pred_p_srv_len_new(1,1,ii))+pred_p_srv_len_new(1,2,ii)*(1-pred_p_srv_len_new(1,2,ii))+pred_p_srv_len_old(1,1,ii)*(1-pred_p_srv_len_old(1,1,ii))+pred_p_srv_len_old(1,2,ii)*(1-pred_p_srv_len_old(1,2,ii))));
      if(k > 1) 
        effn_srv(1,2,k,ii)=0.0;
      else
        effn_srv(1,2,k,ii)=0.0;
      effn_srv(2,1,k,ii)=1./(norm2(pred_p_srv_len_new(2,k,ii)-(obs_p_srv_len(2,1,k,i)))/(pred_p_srv_len_new(2,1,ii)*(1-pred_p_srv_len_new(2,1,ii))+pred_p_srv_len_new(2,2,ii)*(1-pred_p_srv_len_new(2,2,ii))+pred_p_srv_len_old(2,1,ii)*(1-pred_p_srv_len_old(2,1,ii))+pred_p_srv_len_old(2,2,ii)*(1-pred_p_srv_len_old(2,2,ii))));
      effn_srv(2,2,k,ii)=1./(norm2(pred_p_srv_len_old(2,k,ii)-(obs_p_srv_len(2,2,k,i)))/(pred_p_srv_len_new(2,1,ii)*(1-pred_p_srv_len_new(2,1,ii))+pred_p_srv_len_new(2,2,ii)*(1-pred_p_srv_len_new(2,2,ii))+pred_p_srv_len_old(2,1,ii)*(1-pred_p_srv_len_old(2,1,ii))+pred_p_srv_len_old(2,2,ii)*(1-pred_p_srv_len_old(2,2,ii))));
    } // year loop

  // spawning biomass and related outputs
  efspbio_matetime.initialize();
  emspbio_matetime.initialize();
  mspbio_old_matetime.initialize();
  fspbio_new_matetime.initialize();
  efspbio_new_matetime.initialize();
  fspnum_new_matetime.initialize();
  efspnum_matetime.initialize();
  emspnum_old_matetime.initialize();
  mspnum_matetime.initialize();
  for (i=styr;i<= endyr;i++)
  {
    mspbio_matetime(i) = (elem_prod(Smat(2,1,i)*mfexp(-spmo*M_matn(2)),mfexp(-F_midpt(i)*M_matn(2))*natlength_mnew(2,i))+elem_prod(Smat(2,2,i)*mfexp(-spmo*M_mato(2)),mfexp(-F_midpt(i)*M_mato(2))*natlength_mold(2,i)))*wtm;
    fspbio_matetime(i) = (elem_prod(Smat(1,1,i)*mfexp(-spmo*M_matn(1)),mfexp(-F_midpt(i)*M_matn(1))*natlength_mnew(1,i))+elem_prod(Smat(1,2,i)*mfexp(-spmo*M_mato(1)),mfexp(-F_midpt(i)*M_mato(1))*natlength_mold(1,i)))*wtf(2);
    // Extra mortality
    if(i==1983 && extra_m_switch==1)
    {
      mspbio_matetime(i) = (elem_prod(Smat(2,1,i)*mfexp(-spmo*M_matn(2)*mat_big(2)),mfexp(-F_midpt(i)*M_matn(2)*mat_big(2))*natlength_mnew(2,i))+elem_prod(Smat(2,2,i)*mfexp(-spmo*M_mato(2)*mat_big(2)),mfexp(-F_midpt(i)*M_mato(2)*mat_big(2))*natlength_mold(2,i)))*wtm;
      fspbio_matetime(i) = (elem_prod(Smat(1,1,i)*mfexp(-spmo*M_matn(1)*mat_big(1)),mfexp(-F_midpt(i)*M_matn(1)*mat_big(1))*natlength_mnew(1,i))+elem_prod(Smat(1,2,i)*mfexp(-spmo*M_mato(1)*mat_big(1)),mfexp(-F_midpt(i)*M_mato(1)*mat_big(1))*natlength_mold(1,i)))*wtf(2);
    }
    else
    {
      mspbio_fishtime(i) = (natl_mnew_fishtime(2,i)+natl_mold_fishtime(2,i))*wtm;
      fspbio_fishtime(i) = (natl_mnew_fishtime(1,i)+natl_mold_fishtime(1,i))*wtf(2);
    }
    
    if(i==1983 && extra_m_switch==1)
    {
      for(j=1;j<=nlenbins;j++)
      {
        emspnum_old_matetime(i)+= Smat(2,2,i,j)*mfexp(-spmo*M_mato(2)*mat_big(2))*mfexp(-F_midpt(i)*M_mato(2)*mat_big(2))*natlength_mold(2,i,j);
        mspnum_matetime(i)     += Smat(2,1,i,j)*mfexp(-spmo*M_matn(2)*mat_big(2))*mfexp(-F_midpt(i)*M_matn(2)*mat_big(2))*natlength_mnew(2,i,j) + 
                                   Smat(2,2,i,j)*mfexp(-spmo*M_mato(2)*mat_big(2))*mfexp(-F_midpt(i)*M_mato(2)*mat_big(2))*natlength_mold(2,i,j);
        mspbio_old_matetime(i) += (Smat(2,2,i,j)*mfexp(-spmo*M_mato(2)*mat_big(2))*mfexp(-F_midpt(i)*M_mato(2)*mat_big(2))*natlength_mold(2,i,j))*wtm(j);
        fspnum_new_matetime(i) += (Smat(1,1,i,j)*mfexp(-spmo*M_matn(1)*mat_big(1))*mfexp(-F_midpt(i)*M_matn(1)*mat_big(1))*natlength_mnew(1,i,j));
        fspbio_new_matetime(i) += (Smat(1,1,i,j)*mfexp(-spmo*M_matn(1)*mat_big(1))*mfexp(-F_midpt(i)*M_matn(1)*mat_big(1))*natlength_mnew(1,i,j))*wtf(2,j);
        efspnum_matetime(i)    += (Smat(1,1,i,j)*mfexp(-spmo*M_matn(1)*mat_big(1))*mfexp(-F_midpt(i)*M_matn(1)*mat_big(1))*natlength_mnew(1,i,j)+Smat(1,2,i,j)*mfexp(-spmo*M_mato(1)*mat_big(1))*mfexp(-F_midpt(i)*M_mato(1)*mat_big(1))*natlength_mold(1,i,j));
      }
    }
    else
    {
      for(j=1;j<=nlenbins;j++)
      {
        emspnum_old_matetime(i) += Smat(2,2,i,j)*mfexp(-spmo*M_mato(2))*mfexp(-F_midpt(i)*M_mato(2))*natlength_mold(2,i,j);
        mspnum_matetime(i)      += Smat(2,1,i,j)*mfexp(-spmo*M_matn(2))*mfexp(-F_midpt(i)*M_matn(2))*natlength_mnew(2,i,j) + 
                                   Smat(2,2,i,j)*mfexp(-spmo*M_mato(2))*mfexp(-F_midpt(i)*M_mato(2))*natlength_mold(2,i,j);
        mspbio_old_matetime(i)  += (Smat(2,2,i,j)*mfexp(-spmo*M_mato(2))*mfexp(-F_midpt(i)*M_mato(2))*natlength_mold(2,i,j))*wtm(j);
        fspnum_new_matetime(i)  += (Smat(1,1,i,j)*mfexp(-spmo*M_matn(1))*mfexp(-F_midpt(i)*M_matn(1))*natlength_mnew(1,i,j));
        fspbio_new_matetime(i)  += (Smat(1,1,i,j)*mfexp(-spmo*M_matn(1))*mfexp(-F_midpt(i)*M_matn(1))*natlength_mnew(1,i,j))*wtf(2,j);
        efspnum_matetime(i)     += (Smat(1,1,i,j)*mfexp(-spmo*M_matn(1))*mfexp(-F_midpt(i)*M_matn(1))*natlength_mnew(1,i,j)+Smat(1,2,i,j)*mfexp(-spmo*M_mato(1))*mfexp(-F_midpt(i)*M_mato(1))*natlength_mold(1,i,j));
      }
    }
    // effective sp numbers
    emspbio_matetime(i) = mspbio_old_matetime(i);
      
    // for male old shell mating only (AEP ERROR IN OLD CODE HAS >=)
    efspbio_matetime(i) = fspbio_matetime(i);
    if (emspnum_old_matetime(i) < (efspnum_matetime(i)/mate_ratio))
      efspbio_matetime(i) = fspbio_matetime(i)*((emspnum_old_matetime(i)*mate_ratio)/efspnum_matetime(i));
       
    // effective sp numbers for new shell females
    efspbio_new_matetime(i) = fspbio_new_matetime(i);
    if (emspnum_old_matetime(i) < fspnum_new_matetime(i)/mate_ratio)
      efspbio_new_matetime(i) = fspbio_new_matetime(i)*((emspnum_old_matetime(i)*mate_ratio)/fspnum_new_matetime(i));
   }
  // Sex ratio
  for (i=styr;i<=endyr;i++)
    if((sum(natlength(1,i))+sum(natlength(2,i)))<0.01)
    { 
      predpop_sexr(i)=0.0;
    }
    else
    {
      predpop_sexr(i)=sum(natlength(1,i))/(sum(natlength(1,i))+sum(natlength(2,i)));
    }
  // Age-structure
  natlength_mold_age.initialize();
  
  // initialize
  tmpi = 1.0;
  for(j=1;j<=(nages-3);j++) 
    tmpi += mfexp(-j*M_mato(1));
  natlength_mold_age(1,styr,1) = natlength_mold(1,styr)/(tmpi+(mfexp(-(nages-2)*M_mato(1))/(1-mfexp(-M_mato(1)))));

  for(j=1;j<=(nages-2);j++)
    natlength_mold_age(1,styr,j+1) = natlength_mold_age(1,styr,1)*mfexp(-j*M_mato(1));

  natlength_mold_age(1,styr,nages) = natlength_mold_age(1,styr,1)*(mfexp(-(nages-2)*M_mato(1))/(1-mfexp(-M_mato(1))));

  tmpi = 1.0;
  for(j=1;j<=(nages-3);j++) 
    tmpi += mfexp(-j*M_mato(2));
  natlength_mold_age(2,styr,1) = natlength_mold(2,styr)/(tmpi+(mfexp(-(nages-2)*M_mato(2))/(1-mfexp(-M_mato(2)))));
  for(j=1;j<=(nages-2);j++)
    natlength_mold_age(2,styr,j+1) = natlength_mold_age(2,styr,1)*mfexp(-j*M_mato(2));
  natlength_mold_age(2,styr,nages) = natlength_mold_age(2,styr,1)*(mfexp(-(nages-2)*M_mato(2))/(1-mfexp(-M_mato(2))));

  //numbers at length from styr to endyr
  for(sex=1;sex<=2;sex++)
  {
    for (i=styr;i< endyr;i++)
    {
     // for numbers by length and age assumes no molting after maturity
      natlength_mold_age(sex,i+1,1) = mfexp(-(1-F_midpt(i))*M_matn(sex)) * 
                                       elem_prod(Smat(sex,1,i),mfexp(-F_midpt(i)*M_matn(sex))*natlength_mnew(sex,i));
      for(j=1;j<=(nages-1);j++)
        natlength_mold_age(sex,i+1,j+1) = (mfexp(-(1-F_midpt(i))*M_mato(sex)) * 
                                           elem_prod(Smat(sex,2,i),mfexp(-F_midpt(i)*M_mato(sex))*
                                           natlength_mold_age(sex,i,j)));

      natlength_mold_age(sex,i+1,nages) += (mfexp(-(1-F_midpt(i))*M_mato(sex)) * 
                                   elem_prod(Smat(sex,2,i),mfexp(-F_midpt(i)*M_mato(sex))*natlength_mold_age(sex,i,nages)));
                                   
    }
  }
  // Legal males
  popn.initialize();
  legal_srv_males_n.initialize();
  legal_srv_males_o.initialize();
  pred_srv.initialize();
  pred_srv_bioms.initialize();
  for (i=styr;i<=endyr;i++)
  {
    // Selection pattern
    // if (i<1978) sel_srv_use = sel_srv;
    // legal is >102mm take half the numbers in the 100-105 bin
    legal_males_bio(i) = legal_males(i)*wtm(23);
    legal_srv_males_n(i) = 0.5*natlength_new(2,i,23)*sel_srv_m(i,23);
    legal_srv_males_o(i) = 0.5*natlength_old(2,i,23)*sel_srv_m(i,23);
    legal_srv_males_bio(i) = legal_srv_males(i)*wtm(23);
    for(j=24;j<=nlenbins;j++)
    {
      legal_males_bio(i) += natlength(2,i,j)*wtm(j);
      legal_srv_males_n(i) += natlength_new(2,i,j)*sel_srv_use(1,j);
      legal_srv_males_o(i) += natlength_old(2,i,j)*sel_srv_use(1,j);
      legal_srv_males_bio(i) += natlength(2,i,j)*sel_srv_use(1,j)*wtm(j);
    }
    
    // survey numbers
    fspbio_srv_num(1,i) = qsrv*natlength_mnew(1,i)*sel_srv_use(1);
    mspbio_srv_num(1,i) = qsrv*natlength_mnew(2,i)*sel_srv_use(2);
    fspbio_srv_num(2,i) = qsrv*natlength_mold(1,i)*sel_srv_use(1);
    mspbio_srv_num(2,i) = qsrv*natlength_mold(2,i)*sel_srv_use(2);
    
    // total survey summaries
    for(sex=1;sex<=2;sex++)
    {
      if(sex<2)
        pred_srv_bioms(sex,i) = qsrv*((natlength_inew(sex,i)*elem_prod(sel_srv_use(sex),wtf(1)))+
                                 ((natlength_mnew(sex,i)+natlength_mold(sex,i))*elem_prod(sel_srv_use(sex),wtf(2))));
      else
        pred_srv_bioms(sex,i) = qsrv*(natlength(sex,i)*elem_prod(sel_srv_use(sex),wtm));

      pred_srv(sex,i) = qsrv*elem_prod(natlength(sex,i),sel_srv_use(sex));
      popn(i) += sum(natlength(sex,i));
    } 
  }
  // Survey likelihood (by year)
  srv_len_like.initialize();
  for(sex=1;sex<=2;sex++) 
  {
    for (i=1; i <=nobs_srv_length; i++)
    {
      ii=yrs_srv_length(i);
     
      for (j=1; j<=nlenbins; j++)
      {
       // immature new and old together in likelihood indices are (mat,shell,sex,year,length)
        surv_len_like(1,1,sex) -= nsamples_srv_length(1,1,sex,i)*(1e-9+obs_p_srv_len(1,1,sex,i,j)+obs_p_srv_len(1,2,sex,i,j))*log(pred_p_srv_len_new(1,sex,ii,j)+pred_p_srv_len_old(1,sex,ii,j)+1e-9);
        surv_len_like(1,2,sex) = 0.0;
        
       // mature
        surv_len_like(2,1,sex) -= nsamples_srv_length(2,1,sex,i)*(1e-9+obs_p_srv_len(2,1,sex,i,j))*log(pred_p_srv_len_new(2,sex,ii,j)+1e-9);
        len_like_srv(2,2,sex) -= nsamples_srv_length(2,2,sex,i)*(1e-9+obs_p_srv_len(2,2,sex,i,j))*log(pred_p_srv_len_old(2,sex,ii,j)+1e-9);

      }  //j loop     
    } // year loop
  } // sex loop
// ==========================================================================
 */

REPORT_SECTION
  Report(nal_ma);
  Report(srv_q_f);
  Report(srv_q_m);
  Report(sel_srv_f);
  Report(sel_srv_m);
  Report(yrs_srv);
  Report(obs_srv_spbiom(1)(yrs_srv));
  Report(pred_srv_spbiom(1)(yrs_srv));
  Report(obs_srv_spbiom(2)(yrs_srv));
  Report(pred_srv_spbiom(1)(yrs_srv));
  for (int ifsh=1; ifsh <= nfsh; ifsh++)
  {
    Report(obs_catch(ifsh));
    Report(pred_catch(ifsh));
    Report(obs_effort(ifsh));
    Report(pred_effort(ifsh));
    Report(obs_fsh_len(ifsh));
    Report(pred_fsh_len(ifsh));
  }
  Report(Fout);
  Report(srv_like);
  Report(srv_len_like);
  Report(fsh_len_like);
  Report(effort_like);
  Report(catch_like);
  Report(selfsh);
  Report(nal);
  Report(nal_im_n);
  Report(nal_im_o);
  Report(nal_ma_n);
  Report(nal_ma_o);
  Report(Fmort);
  /*
  int ii,i,k,j;
  dvar_vector preds_sexr(styr,endyr);
  dvar_matrix tmpo(1,2,styr,endyr);
  dvar_matrix tmpp(1,2,styr,endyr);
  dvar_vector obs_tmp(styr,endyr);
  dvariable ghl,ghl_number;
  dvariable hrate;
    
  Misc_output();
  dvar_vector tmpp1(1,nlenbins);
  dvar_vector tmpp2(1,nlenbins);
  dvar_vector tmpp3(1,nlenbins);
  dvar_vector tmpp4(1,nlenbins);
  tmpp1.initialize();
  tmpp2.initialize();
  tmpp3.initialize();
  tmpp4.initialize();
  report << Fout << " "<<fmort_pen<<endl;
  for (i=styr;i<=endyr;i++)
    if((totn_srv(1,i)+totn_srv(2,i))<0.01) {
      preds_sexr(i)=0.0;}
    else{
      preds_sexr(i)=totn_srv(1,i)/(totn_srv(1,i)+totn_srv(2,i));
    }
  report << "Estimated numbers of immature new shell female crab by length: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for(i=styr;i<=endyr;i++) report <<  i<<" "<<natlength_inew(1,i) << endl;
  report << "Estimated numbers of immature old shell female crab by length: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for(i=styr;i<=endyr;i++) report <<  i<<" "<<natlength_iold(1,i) << endl;
  report << "Estimated numbers of mature new shell female crab by length: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for(i=styr;i<=endyr;i++) report <<  i<<" "<<natlength_mnew(1,i) << endl;
  report << "Estimated numbers of mature old shell female crab by length: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for(i=styr;i<=endyr;i++)report <<  i<<" "<<natlength_mold(1,i) << endl;

  report << "Estimated numbers of immature new shell male crab by length: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for(i=styr;i<=endyr;i++) report << i<<" "<<natlength_inew(2,i) << endl;
  report << "Estimated numbers of immature old shell male crab by length: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for(i=styr;i<=endyr;i++) report << i<<" "<<natlength_iold(2,i) << endl;
  report << "Estimated numbers of mature new shell male crab by length: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for(i=styr;i<=endyr;i++) report << i<<" "<<natlength_mnew(2,i) << endl;
  report << "Estimated numbers of mature old shell male crab by length: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for(i=styr;i<=endyr;i++) report << i<<" "<<natlength_mold(2,i) << endl;
 
  report << "Observed numbers of immature new shell female crab by length: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for (i=1; i <= nobs_srv_length; i++) report<<yrs_srv_length(i)<<" "<<obs_p_srv_len(1,1,1,i)*obs_srvt(yrs_srv_length(i))<<endl;
  report << "Observed numbers of mature new shell female crab by length: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for (i=1; i <= nobs_srv_length; i++) report<<yrs_srv_length(i)<<" "<<obs_p_srv_len(2,1,1,i)*obs_srvt(yrs_srv_length(i))<<endl;
  report << "Observed numbers of mature old shell female crab by length: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for (i=1; i <= nobs_srv_length; i++) report<<yrs_srv_length(i)<<" "<<obs_p_srv_len(2,2,1,i)*obs_srvt(yrs_srv_length(i))<<endl;
  report << "Observed numbers of immature new shell male crab by length: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for (i=1; i <= nobs_srv_length; i++) report<<yrs_srv_length(i)<<" "<<obs_p_srv_len(1,1,2,i)*obs_srvt(yrs_srv_length(i))<<endl;
  report << "Observed numbers of immature old shell male crab by length: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for (i=1; i <= nobs_srv_length; i++) report<<yrs_srv_length(i)<<" "<<obs_p_srv_len(1,2,2,i)*obs_srvt(yrs_srv_length(i))<<endl;
  report << "Observed numbers of mature new shell male crab by length: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for (i=1; i <= nobs_srv_length; i++) report<<yrs_srv_length(i)<<" "<<obs_p_srv_len(2,1,2,i)*obs_srvt(yrs_srv_length(i))<<endl;
  report << "Observed numbers of mature old shell male crab by length: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for (i=1; i <= nobs_srv_length; i++) report<<yrs_srv_length(i)<<" "<<obs_p_srv_len(2,2,2,i)*obs_srvt(yrs_srv_length(i))<<endl;
  report << "Observed Survey Numbers by length females:  'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for (i=1; i <= nobs_srv_length; i++) report<<yrs_srv_length(i)<<" " << obs_srv_num(1,yrs_srv_length(i)) << endl;
  report << "Observed Survey Numbers by length males: 'year', '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for (i=1; i <= nobs_srv_length; i++) report<<yrs_srv_length(i)<<" " << obs_srv_num(2,yrs_srv_length(i))<< endl;
  
  report << "Predicted Survey Numbers by length females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for (i=1; i <= nobs_srv_length; i++) report<<yrs_srv_length(i)<<" "  << pred_srv(1,yrs_srv_length(i)) << endl;
  report << "Predicted Survey Numbers by length males: 'year', '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for (i=1; i <= nobs_srv_length; i++) report<<yrs_srv_length(i)<<" "  << pred_srv(2,yrs_srv_length(i)) << endl;
  report << "Predicted pop Numbers by length females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for(i=styr;i<=endyr;i++) report<<i<<" "<< natlength(1,i)<< endl;
  report << "Predicted pop Numbers by length males: 'year', '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for(i=styr;i<=endyr;i++) report<<i<<" "<< natlength(2,i)<< endl;
 
    //actual years for obs survey male are 1969,1970,1972-2009
   report<<"observed number of males greater than 101 mm: seq(1974,"<<endyr<<")"<<endl;
  report<<obs_lmales<<endl;
  report<<"observed biomass of males greater than 101 mm: seq(1974,"<<endyr<<")"<<endl;
  report<<obs_lmales_bio<<endl;
  report<<"pop estimate numbers of males >101: seq("<<styr<<","<<endyr<<")"<<endl;
  report<<legal_males<<endl;
  report<<"estimated population biomass of males > 101: seq("<<styr<<","<<endyr<<") "<<endl;
  report<<legal_males_bio<<endl;
  report<<"estimated survey numbers of males > 101: seq("<<styr<<","<<endyr<<") "<<endl;
  report<<legal_srv_males<<endl;
  report<<"estimated survey biomass of males > 101: seq("<<styr<<","<<endyr<<") "<<endl;
  report<<legal_srv_males_bio<<endl;
  report << "Observed survey biomass: seq(1974,"<<endyr<<")"<<endl;
  report << obs_srv_biom(1974,endyr)<<endl;
  report << "predicted survey biomass: seq("<<styr<<","<<endyr<<")"<<endl;
  report << pred_srv_bioms(1)+pred_srv_bioms(2)<<endl;
  
  //survey numbers
  for(k=1;k<=2;k++)
   for(i=styr;i<=endyr;i++)
    {
     tmpo(k,i)=sum(obs_srv_num(k,i));
     tmpp(k,i)=sum(pred_srv(k,i));
    }
  report << "Observed survey numbers female: seq("<<styr<<","<<endyr<<")"<<endl;
  report << tmpo(1)<<endl;
  report << "Observed survey numbers male: seq("<<styr<<","<<endyr<<")"<<endl;
  report << tmpo(2)<<endl;
  report << "predicted survey numbers female: seq("<<styr<<","<<endyr<<")"<<endl;
  report << tmpp(1)<<endl;
  report << "predicted survey numbers male: seq("<<styr<<","<<endyr<<")"<<endl;
  report << tmpp(2)<<endl;
  report << "Observed survey female spawning biomass: seq("<<styr<<","<<endyr<<")"<<endl;
  report << obs_srv_spbiom(1)<<endl;
  report << "Observed survey male spawning biomass: seq("<<styr<<","<<endyr<<")"<<endl;
  report << obs_srv_spbiom(2)<<endl;
  report << "Observed survey female new spawning numbers: seq("<<styr<<","<<endyr<<")"<<endl;
  report << obs_srv_spnum(1,1)<<endl;
  report << "Observed survey female old spawning numbers: seq("<<styr<<","<<endyr<<")"<<endl;
  report << obs_srv_spnum(2,1)<<endl;
  report << "Observed survey male new spawning numbers: seq("<<styr<<","<<endyr<<")"<<endl;
  report << obs_srv_spnum(1,2)<<endl;
  report << "Observed survey male old spawning numbers: seq("<<styr<<","<<endyr<<")"<<endl;
  report << obs_srv_spnum(2,2)<<endl;
  report << "Observed survey female biomass: seq("<<styr<<","<<endyr<<")"<<endl;
  report << obs_srv_bioms(1)<<endl;
  report << "Observed survey male biomass: seq("<<styr<<","<<endyr<<")"<<endl;
  report << obs_srv_bioms(2)<<endl;
  report << "natural mortality immature females, males: 'FemM','MaleM'" << endl;
  report << M << endl;
  report << "natural mortality mature females, males: 'FemMm','MaleMm'" << endl;
  report << M_matn << endl;
  report << "natural mortality mature old shell females, males: 'FemMmo','MaleMmo'" << endl;
  report << M_mato << endl;
  report << "Predicted Biomass: seq("<<styr<<","<<endyr<<")" << endl;
  report << pred_bio << endl;
  report << "Predicted total population numbers: seq("<<styr<<","<<endyr<<") "<<endl;
  report <<popn<<endl;
  report << "Female Spawning Biomass: seq("<<styr<<","<<endyr<<") " << endl;
  report << fspbio << endl;
  report << "Male Spawning Biomass: seq("<<styr<<","<<endyr<<") " << endl;
  report << mspbio << endl;
  report << "Total Spawning Biomass: seq("<<styr<<","<<endyr<<") " << endl;
  report << fspbio+mspbio << endl;
  report << "Female Spawning Biomass at fish time: seq("<<styr<<","<<endyr<<") " << endl;
  report << fspbio_fishtime << endl;
  report << "Male Spawning Biomass at fish time: seq("<<styr<<","<<endyr<<") " << endl;
  report << mspbio_fishtime << endl;
  report << "Total Spawning Biomass at fish time: seq("<<styr<<","<<endyr<<") " << endl;
  report << fspbio_fishtime+mspbio_fishtime << endl;
  report << "Mating time Female Spawning Biomass: seq("<<styr<<","<<endyr<<") " << endl;
  report << fspbio_matetime << endl;
  report << "Mating time Male Spawning Biomass: seq("<<styr<<","<<endyr<<") " << endl;
  report << mspbio_matetime << endl;
  report << "Mating time Male old shell Spawning Biomass: seq("<<styr<<","<<endyr<<") " << endl;
  report << mspbio_old_matetime << endl;
  report << "Mating time female new shell Spawning Biomass: seq("<<styr<<","<<endyr<<") " << endl;
  report << fspbio_new_matetime << endl;
  report << "Mating time Total Spawning Biomass : seq("<<styr<<","<<endyr<<") " << endl;
  report << fspbio_matetime+mspbio_matetime << endl;
  report << "Mating time effective Female Spawning Biomass: seq("<<styr<<","<<endyr<<") " << endl;
  report << efspbio_matetime << endl;
  report << "Mating time effective Male Spawning Biomass(old shell only): seq("<<styr<<","<<endyr<<") " << endl;
  report << emspbio_matetime << endl;
  report << "Mating time Total effective Spawning Biomass: seq("<<styr<<","<<endyr<<") " << endl;
  report << efspbio_matetime+emspbio_matetime << endl;
  report << "Mating time male Spawning numbers: seq("<<styr<<","<<endyr<<") " << endl;
  report << mspnum_matetime << endl;
  report << "Mating time Female Spawning numbers: seq("<<styr<<","<<endyr<<") " << endl;
  report << efspnum_matetime << endl;
  report << "Mating time Male Spawning numbers(old shell only): seq("<<styr<<","<<endyr<<") " << endl;
  report << emspnum_old_matetime << endl;
//  report << "ratio Mating time Female Spawning numbers to male old shell mature numbers : seq("<<styr<<","<<endyr<<") " << endl;
//  report << elem_div(efspnum_matetime,emspnum_old_matetime) << endl;
  report << "Mating time effective Female new shell Spawning biomass: seq("<<styr<<","<<endyr<<") " << endl;
  report <<efspbio_new_matetime << endl;
  report << "Mating time Female new shell Spawning numbers: seq("<<styr<<","<<endyr<<") " << endl;
  report << fspnum_new_matetime << endl;
//  report << "ratio Mating time Female new shell Spawning numbers to male old shell mature numbers : seq("<<styr<<","<<endyr<<") " << endl;
//            for(i=styr;i<=endyr;i++){if(emspnum_old_matetime(i)<0.001) emspnum_old_matetime(i)=1.0; }
//  report << elem_div(fspnum_new_matetime,emspnum_old_matetime) << endl;
  report << "Predicted Female survey Biomass: seq("<<styr<<","<<endyr<<") " << endl;
  report << pred_srv_bioms(1) << endl;
  report << "Predicted Male survey Biomass: seq("<<styr<<","<<endyr<<") " << endl;
  report << pred_srv_bioms(2)<< endl;
  report << "Predicted Female survey mature Biomass: seq("<<styr<<","<<endyr<<") " << endl;
  report << fspbio_srv << endl;
  report << "Predicted Male survey mature Biomass: seq("<<styr<<","<<endyr<<") " << endl;
  report << mspbio_srv<< endl;
  report << "Predicted total survey mature Biomass: seq("<<styr<<","<<endyr<<") " << endl;
  report << fspbio_srv+mspbio_srv<< endl;
  report << "Predicted Female survey new mature numbers: seq("<<styr<<","<<endyr<<") " << endl;
  report << fspbio_srv_num(1) << endl;
  report << "Predicted Female survey old mature numbers: seq("<<styr<<","<<endyr<<") " << endl;
  report << fspbio_srv_num(2) << endl;
  report << "Predicted Male survey new mature numbers: seq("<<styr<<","<<endyr<<") " << endl;
  report << mspbio_srv_num(1)<< endl;
  report << "Predicted Male survey old mature numbers: seq("<<styr<<","<<endyr<<") " << endl;
  report << mspbio_srv_num(2)<< endl;

  report << "Observed Prop fishery ret new males:'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for (i=1; i<=nobs_fish; i++) report << yrs_fish(i) << " " << obs_p_fish_ret(1,i)<< endl;
  report << "Predicted length prop fishery ret new males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_fish; i++) 
   {
    ii=yrs_fish(i);  
    report <<  ii  <<  " "  <<  pred_p_fish_fit(1,ii)  << endl;
   }
  report << "Observed Prop fishery ret old males:'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for (i=1; i<=nobs_fish; i++) report << yrs_fish(i) << " " << obs_p_fish_ret(2,i)<< endl;
  report << "Predicted length prop fishery ret old males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_fish; i++)
   {
    ii=yrs_fish(i);  
    report <<  ii  <<  " "  <<  pred_p_fish_fit(2,ii)  << endl;
   }

  report << "Observed Prop fishery total new males:'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for (i=1; i<=nobs_fish_discm; i++) report << yrs_fish_discm(i) << " " << obs_p_fish_tot(1,i) << endl;
  report << "Predicted length prop fishery total new males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_fish_discm; i++)
   {
    ii=yrs_fish_discm(i);  
    report <<  ii  <<  " "  <<  pred_p_fish(1,ii)  << endl;
   }
  report << "Observed Prop fishery total old males:'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for (i=1; i<=nobs_fish_discm; i++) report << yrs_fish_discm(i) << " " << obs_p_fish_tot(2,i) << endl;
  report << "Predicted length prop fishery total old males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_fish_discm; i++)
   {
    ii=yrs_fish_discm(i);  
    report <<  ii  <<  " "  <<  pred_p_fish(2,ii)  << endl;
   }
  report << "Observed Prop fishery discard new males:'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for (i=1; i<=nobs_fish_discm; i++) report << yrs_fish_discm(i) << " " << obs_p_fish_discm(1,i) << endl;
  report << "Observed Prop fishery discard old males:'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for (i=1; i<=nobs_fish_discm; i++) report << yrs_fish_discm(i) << " " << obs_p_fish_discm(2,i)<< endl;

  report << "Observed length prop fishery discard all females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_fish_discf; i++) report <<  yrs_fish_discf(i)  <<  " "  <<  obs_p_fish_discf(i)  << endl;
  report << "Predicted length prop fishery discard all females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_fish_discf; i++)
   {
    ii=yrs_fish_discf(i);  
    report <<  ii  <<  " "  <<  pred_p_fish_discf(ii)  << endl;
   }
  report << "Observed length prop snow fishery females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_snowfish_discf; i++)
   {
    report <<  yrs_snowfish_discf(i)  <<  " "  <<  obs_p_snow(1,i)  << endl;
   }
  report << "Predicted length prop snow fishery females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_snowfish_discf; i++)
   {
    ii=yrs_snowfish_discf(i);  
    report <<  ii  <<  " "  <<  pred_p_snow(1,ii)  << endl;
   }
  report << "Observed length prop snow fishery males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_snowfish_discm; i++)
   {
    report <<  yrs_snowfish_discm(i)  <<  " "  <<  obs_p_snow(2,i)  << endl;
   }
  report << "Predicted length prop snow fishery males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_snowfish_discm; i++)
   {
    ii=yrs_snowfish_discm(i);  
    report <<  ii  <<  " "  <<  pred_p_snow(2,ii)  << endl;
   }
  report << "Observed length prop redk fishery females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_rkfish_discf; i++)
   {
    report <<  yrs_rkfish_discf(i)  <<  " "  <<  obs_p_rk(1,i)  << endl;
   }
  report << "Predicted length prop redk fishery females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_rkfish_discf; i++)
   {
    ii=yrs_rkfish_discf(i);  
    report <<  ii  <<  " "  <<  pred_p_rk(1,ii)  << endl;
   }
  report << "Observed length prop redk fishery males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_rkfish_discm; i++)
   {
    report <<  yrs_rkfish_discm(i)  <<  " "  <<  obs_p_rk(2,i)  << endl;
   }
  report << "Predicted length prop redk fishery males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_rkfish_discm; i++)
   {
    ii=yrs_rkfish_discm(i);  
    report <<  ii  <<  " "  <<  pred_p_rk(2,ii)  << endl;
   }

  report << "Predicted length prop trawl females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_trawl; i++)
   {
    ii=yrs_trawl(i);  
    report <<  ii  <<  " "  <<  pred_p_trawl(1,ii)  << endl;
   }
  report << "Observed length prop trawl females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_trawl; i++) report <<  yrs_trawl(i)  <<  " "  <<  obs_p_trawl(1,i)  << endl;
  report << "Predicted length prop trawl males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_trawl; i++)
   {
    ii=yrs_trawl(i);  
    report <<  ii  <<  " "  <<  pred_p_trawl(2,ii)  << endl;
   }
  report << "Observed length prop trawl males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_trawl; i++) report <<  yrs_trawl(i)  <<  " "  <<  obs_p_trawl(2,i)  << endl;

  report << "Observed Length Prop survey immature new females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);
    report << ii <<" " <<obs_p_srv_len(1,1,1,i) << endl;
   }
  report << "Predicted length prop survey immature new females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    report << ii << " " << pred_p_srv_len_new(1,1,ii) << endl;
   }
  report << "Observed Length Prop survey immature old females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);
    report << ii <<" " <<obs_p_srv_len(1,2,1,i) << endl;
   }
  report << "Predicted length prop survey immature old females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    report << ii << " " << pred_p_srv_len_old(1,1,ii) << endl;
   }
 
  report << "Observed Length Prop survey immature new males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++) report << yrs_srv_length(i) <<" " <<obs_p_srv_len(1,1,2,i) << endl;
  report << "Predicted length prop survey immature new males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    report << ii << " " << pred_p_srv_len_new(1,2,ii) << endl;
   }
  report << "Observed Length Prop survey immature old males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++) report << yrs_srv_length(i) <<" " <<obs_p_srv_len(1,2,2,i) << endl;
  report << "Predicted length prop survey immature old males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++)
  {
   ii=yrs_srv_length(i);  
   report << ii << " " << pred_p_srv_len_old(1,2,ii) << endl;
  }
  report << "Observed Length Prop survey mature new females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);
    report << ii <<" " <<obs_p_srv_len(2,1,1,i) << endl;
   }
  report << "Predicted length prop survey mature new females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    report << ii << " " << pred_p_srv_len_new(2,1,ii) << endl;
   }
  report << "Observed Length Prop survey mature old females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);
    report << ii <<" " <<obs_p_srv_len(2,2,1,i) << endl;
   }
  report << "Predicted length prop survey mature old females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    report << ii << " " << pred_p_srv_len_old(2,1,ii) << endl;
   }
 
  report << "Observed Length Prop survey mature new males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++) report << yrs_srv_length(i) <<" " <<obs_p_srv_len(2,1,2,i) << endl;
  report << "Predicted length prop survey mature new males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    report << ii << " " << pred_p_srv_len_new(2,2,ii) << endl;
   }
  report << "Observed Length Prop survey mature old males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++) report << yrs_srv_length(i) <<" " <<obs_p_srv_len(2,2,2,i) << endl;
  report << "Predicted length prop survey mature old males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    report << ii << " " << pred_p_srv_len_old(2,2,ii) << endl;
   }
//for females don't have length data in first four years first year is 1974
     report << "Observed Length Prop survey all females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);
    report << ii <<" " <<obs_p_srv_len(1,1,1,i)+obs_p_srv_len(2,1,1,i)+obs_p_srv_len(2,2,1,i)<< endl;
              tmpp4+=obs_p_srv_len(1,1,1,i)+obs_p_srv_len(2,1,1,i)+obs_p_srv_len(2,2,1,i);
   }
  report << "Predicted length prop survey all females: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    report << ii << " " << pred_p_srv_len_new(1,1,ii)+pred_p_srv_len_new(2,1,ii)+pred_p_srv_len_old(2,1,ii) << endl;
    tmpp1+=pred_p_srv_len_new(1,1,ii)+pred_p_srv_len_new(2,1,ii)+pred_p_srv_len_old(2,1,ii);
   }
  report << "Observed Length Prop survey all males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);
    report << ii <<" " <<obs_p_srv_len(1,1,2,i)+obs_p_srv_len(1,2,2,i)+obs_p_srv_len(2,1,2,i)+obs_p_srv_len(2,2,2,i)<< endl;
         tmpp2+=obs_p_srv_len(1,1,2,i)+obs_p_srv_len(1,2,2,i)+obs_p_srv_len(2,1,2,i)+obs_p_srv_len(2,2,2,i);
   }
  report << "Predicted length prop survey all males: 'year','27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    report << ii << " " << pred_p_srv_len_new(1,2,ii)+pred_p_srv_len_new(2,2,ii)+pred_p_srv_len_old(2,2,ii) << endl;
  tmpp3+=pred_p_srv_len_new(1,2,ii)+pred_p_srv_len_new(2,2,ii)+pred_p_srv_len_old(2,2,ii);
   }
  report << "Sum of predicted prop survey all females: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
            report <<tmpp1<<endl;
  report << "Sum of predicted prop survey all males: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
            report <<tmpp3<<endl;
  report << "Sum of Observed prop survey all females: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
            report <<tmpp4<<endl;
  report << "Sum of Observed prop survey all males: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'" << endl;
            report <<tmpp2<<endl;

  report << "Predicted mean postmolt length females:  '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report << mean_length(1) << endl;
  report << "Predicted mean postmolt length males:  '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report << mean_length(2)<<endl; 
  report << "af1: 'females'" << endl;
  report << af1 << endl;
//  report << "af2: 'females'" << endl;
//  report << af2 << endl;
  report << "am1: 'males'" << endl;
  report << am1 << endl;
//  report << "am2: 'males'" << endl;
//  report << am2 << endl;
  report << "bf1: 'females'" << endl;
  report << bf1 << endl;
//  report << "bf2: 'females'" << endl;
//  report << bf2 << endl;
  report << "bm1: 'males'" << endl;
  report << bm1 << endl;
//  report << "bm2: 'males'" << endl;
//  report << bm2 << endl;
  report<<"Predicted probability of maturing females: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<<endl;
  report<<maturity_est(1)<<endl;
  report<<"Predicted probability of maturing males: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<<endl;
  report<<maturity_est(2)<<endl;
  report<<"molting probs female: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<<endl;
  report<<moltp(1)<<endl;
  report<<"molting probs male:'27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report<<moltp(2)<<endl;
  report <<"Molting probability mature males: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report <<moltp_mat(2)<<endl;
  report << "observed pot fishery cpue 1979 fishery to endyr fishery: seq(1970,"<<endyr<<")" << endl;
  report <<cpue(1969,endyr-1)<<endl;
  report << "predicted pot fishery cpue 1978 to endyr-1 survey: seq("<<styr+1<<","<<endyr<<")" << endl;
  report <<cpue_pred(styr,endyr-1)<<endl;
  report << "observed retained catch biomass: seq(1965,"<<endyr-1<<")" << endl;
  report << catch_ret(1965,endyr-1) << endl;
  report << "predicted retained catch biomass: seq("<<styr+1<<","<<endyr<<")" << endl;
  report << pred_catch_ret(styr,endyr-1)<<endl;
  report << "predicted retained new catch biomass: seq("<<styr+1<<","<<endyr<<")" << endl;
  report << (catch_male_ret_new*wtm)(styr,endyr-1)<<endl;
  report << "predicted retained old catch biomass: seq("<<styr+1<<","<<endyr<<")" << endl;
  report << (catch_male_ret_old*wtm)(styr,endyr-1)<<endl;
  report << "observed retained+discard male catch biomass: seq(1992,"<<endyr-1<<")" << endl;
  report << obs_catchtot_biom(1992,endyr-1) << endl;
  report << "predicted retained+discard male catch biomass: seq("<<styr+1<<","<<endyr<<")" << endl;
  report << pred_catch(styr,endyr-1) << endl;
  report << "predicted retained+discard new male catch biomass: seq("<<styr+1<<","<<endyr<<")" << endl;
  report << (catch_lmale_new*wtm)(styr,endyr-1) << endl;
  report << "predicted retained+discard old male catch biomass: seq("<<styr+1<<","<<endyr<<")" << endl;
  report << (catch_lmale_old*wtm)(styr,endyr-1) << endl;
  report << "observed discard male mortality biomass: seq(1992,"<<endyr-1<<")"<<endl;
  report << (obs_catchtot_biom(1992,endyr-1)-catch_ret(1992,endyr-1)) <<endl;
  report << "predicted discard male catch biomass: seq("<<styr<<","<<endyr-1<<")" << endl;
  report << pred_catch(styr,endyr-1) -pred_catch_ret(styr,endyr-1)<< endl;
  report << "observed female discard mortality biomass: seq(1992,"<<endyr-1<<")" << endl;
  report << obs_catchdf_biom(1992,endyr-1) << endl;
  report << "predicted female discard mortality biomass: seq("<<styr+1<<","<<endyr<<")" << endl;
  report << pred_catch_disc(1)(styr,endyr-1) << endl;
  report << "observed male discard mortality biomass: seq(1992,"<<endyr-1<<")" << endl;
  report << obs_catchdm_biom(1992,endyr-1) << endl;
  report << "observed trawl catch biomass: seq("<<yrs_trawl_c(1)<<","<<yrs_trawl_c(nobs_trawl_c)<<")"<<endl;
  report << obs_catcht_biom(yrs_trawl_c)<<endl;
  report << "predicted trawl catch biomass: seq("<<styr<<","<<endyr<<")"<<endl;
  report <<pred_catch_trawl<<endl;
  report << "observed snow female discard mortality biomass: seq(1992,"<<endyr-1<<")" << endl;
   for (i=1; i<=nobs_discardc; i++)
    {
      report << catch_snowodisc(1)(i)<<" ";
     }
      report<< endl;
  report << "predicted snow female discard mortality biomass: seq("<<styr<<","<<endyr<<")" << endl;
  report << pred_catch_female_snowd << endl;
  report << "observed snow male discard mortality biomass: seq(1992,"<<endyr-1<<")" << endl;
   for (i=1; i<=nobs_discardc; i++)
    {
      report << catch_snowodisc(2)(i) <<" ";
     }
      report<< endl;
  report << "predicted snow male discard mortality biomass: seq("<<styr<<","<<endyr<<")" << endl;
  report << pred_catch_snowd << endl;  
  report << "observed redk female discard mortality biomass: seq(1992,"<<endyr-1<<")" << endl;
   for (i=1; i<=nobs_discardc; i++)
    {
      report << catch_rkodisc(1)(i) <<" ";
     }
  report << endl;
  report << "predicted redk female discard mortality biomass: seq("<<styr<<","<<endyr<<")" << endl;
  report << pred_catch_female_rkd << endl;
  report << "observed redk male discard mortality biomass: seq(1992,"<<endyr-1<<")" << endl;
   for (i=1; i<=nobs_discardc; i++)
    {
      report << catch_rkodisc(2)(i) <<" ";
     }
  report << endl;
  report << "predicted redk male discard mortality biomass: seq("<<styr<<","<<endyr<<")" << endl;
  report << pred_catch_rkd << endl;
  report << "predicted total male catch biomass: seq("<<styr+1<<","<<endyr<<")" << endl;
  report<<pred_catch(styr,endyr-1)+pred_catch_rkd(styr,endyr-1)+pred_catch_snowd(styr,endyr-1)+pred_catch_trawl(styr,endyr-1)/2.0<<endl;
  report << "predicted total female catch biomass: seq("<<styr+1<<","<<endyr<<")" << endl;
  report<<pred_catch_disc(1)(styr,endyr-1)+pred_catch_female_rkd(styr,endyr-1)+pred_catch_female_snowd(styr,endyr-1)+pred_catch_trawl(styr,endyr-1)/2.0<<endl;
  report << "estimated annual total directed fishing mortality: seq("<<styr+1<<","<<endyr<<")" << endl;
  report << fmort(styr,endyr-1) << endl;
  report << "estimated annual snow fishing mortality: seq("<<styr+1<<","<<endyr<<")" << endl;
  report << fmortd_snow(styr,endyr-1) << endl;
  report << "estimated annual red king fishing mortality: seq("<<styr+1<<","<<endyr<<")" << endl;
  report << fmortd_rk(styr,endyr-1) << endl;
  report << "estimated annual total fishing mortality: seq("<<styr+1<<","<<endyr<<")" << endl;
  for(i=styr;i<=(endyr-1);i++) report << F(1,i)(nlenbins)+ Fdisct(2,i)(nlenbins)+Fdisc_snow(2,i)(nlenbins)+Fdisc_rk(2,i)(nlenbins) <<" "; report<< endl;
  report <<"retained F: seq("<<styr+1<<","<<endyr<<")" << endl;
  for(i=styr;i<=(endyr-1);i++) report <<F_ret(1,i)(nlenbins)<<" "; report<<endl;
  report <<"ghl: seq(1979,"<<endyr<<")" << endl;
  report <<catch_ghl/2.2<<endl;
  report << "estimated annual fishing mortality females pot: seq("<<styr+1<<","<<endyr<<")" << endl;
  for(i=styr;i<=(endyr-1);i++) report << Fdiscf(i)(nlenbins) <<" "; report<<endl;
  report << "estimated annual fishing mortality trawl bycatch: seq("<<styr+1<<","<<endyr<<")" << endl;
  report << fmortt(styr,endyr-1) <<endl;
//recruits in the model are 1978 to 2004, the 1978 recruits are those that enter the population
//in spring of 1979, before the 1979 survey - since using the survey as the start of the year
// in the model spring 1979 is stil 1978.  the last recruits are 2003 that come in spring 2004
  report << "estimated number of recruitments female: seq("<<styr+1<<","<<endyr<<")" << endl;
  for(i=styr; i<=1973; i++) report << mfexp(mean_log_rec1_early+rec_devf_early(i))<<" ";
  for(i=1974; i<=(endyr-1); i++) report << mfexp(mean_log_rec(1)+rec_dev(1,i))<<" ";
  report <<endl<< "estimated number of recruitments male: seq("<<styr+1<<","<<endyr<<")" << endl;
  for(i=styr; i<=1973; i++) report << mfexp(mean_log_rec1_early+rec_devf_early(i))<<" ";
  for(i=1974; i<=(endyr-1); i++) report << mfexp(mean_log_rec(2)+rec_dev(2,i))<<" ";
  for(i=1;i<=median_rec_yrs;i++)report<<2*median_rec<<" "; report<<endl;
  
  report<<"distribution of recruits to length bins: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<<endl;
  report<<rec_len<<endl;
//  report<<"fishery total selectivity new shell 50% parameter: seq("<<1981+1<<","<<endyr<<")"<<endl;
//  report <<fish_sel50_mn(1981,endyr-1)<<endl;
//  report <<"fishery total selectivity old shell 50% parameter: seq("<<styr+1<<","<<endyr<<")"<<endl;
//  report <<mfexp(log_avg_sel50_mo+log_sel50_dev_mo)(styr,endyr-1)<<endl;
  report << "selectivity fishery total new males styr to 1991: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report << sel(1,1990) << endl;
//  report << "selectivity fishery total new males 1992 to 1996: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
//  report << sel(1,1991) << endl;
  report << "selectivity fishery total new males 1991 to 1996: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
   for(i=1991;i<=1996; i++) 
   { report << sel(1,i) << endl;}
  report << "selectivity fishery total new males 2005 to present: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
   for(i=2005;i<=endyr; i++) 
   { report << sel(1,i) << endl;}
//  report << "selectivity fishery total old males: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
//  report << sel(2) << endl;
  report << "selectivity fishery ret new males styr to 1991: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;  
  report << sel_fit(1,1990) << endl;
//  report << "selectivity fishery ret new males 1992 to 1996: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;  
//  report << sel_fit(1,1991) << endl;
  report << "selectivity fishery ret new males 1991 to 1996: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;  
  for(i=1991;i<=1996; i++) 
   { for(j=1; j<=nlenbins; j++){report <<sel_fit(1,i,j)<<" ";
   }
      report<<endl;
   }
  report << "selectivity fishery ret new males 2005 to present: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;  
  for(i=2005;i<=endyr; i++) 
   { for(j=1; j<=nlenbins; j++){report <<sel_fit(1,i,j)<<" ";
   }
      report<<endl;
   }
//  report << "selectivity fishery ret new males: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
//  report << sel_fit(1) << endl;
//  report << "selectivity fishery ret old males: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
//  report << sel_fit(2) << endl;
//  report <<"retention curve males new: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
//  report <<sel_ret<<endl;
  report <<"retention curve males new: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report <<sel_ret(1,endyr-1)<<endl;
  report <<"retention curve males old: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report <<sel_ret(2,endyr-1)<<endl;
  report << "selectivity discard females: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report <<sel_discf<<endl;
  report << "selectivity trawl females:'27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report <<sel_trawl(1,1)<<endl;
  report <<sel_trawl(2,1)<<endl;
  report <<sel_trawl(3,1)<<endl;
  report << "selectivity trawl males:'27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report <<sel_trawl(1,2)<<endl;
  report <<sel_trawl(2,2)<<endl;
  report <<sel_trawl(3,2)<<endl;
  report << "selectivity snow females:'27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report <<sel_disc_snow(1,1)<<endl;
  report <<sel_disc_snow(2,1)<<endl;
  report <<sel_disc_snow(3,1)<<endl;
  report << "selectivity snow males:'27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report <<sel_disc_snow(1,2)<<endl;
  report <<sel_disc_snow(2,2)<<endl;
  report <<sel_disc_snow(3,2)<<endl;
  report << "selectivity redk females:'27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report <<sel_disc_rkc(1,1)<<endl;
  report <<sel_disc_rkc(2,1)<<endl;
  report <<sel_disc_rkc(3,1)<<endl;
  report << "selectivity redk males:'27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report <<sel_disc_rkc(1,2)<<endl;
  report <<sel_disc_rkc(2,2)<<endl;
  report <<sel_disc_rkc(3,2)<<endl;
//  report << "selectivity survey females 1969 1973: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
//  report << sel_srv(1) << endl;
//  report << "selectivity survey males 1969 1973: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
//  report << sel_srv(2) << endl;
  report << "selectivity survey females 1974 to 1981: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report << "selectivity survey males 1974 to 1981: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report << "selectivity survey females 1982 to 1987: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report << "selectivity survey males 1982 to 1987: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report << "selectivity survey females 1988 to endyr: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report << "selectivity survey males 1988 to endyr: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report << "numbers of mature females by age and length: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for(i=styr;i<=endyr;i++)
   { report << natlength_mnew(1,i)<<endl; report << natlength_mold_age(1,i)<<endl; }
  
  report << "numbers of mature males by age and length: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  for(i=styr;i<=endyr;i++) 
   { report << natlength_mnew(2,i)<<endl; report << natlength_mold_age(2,i)<<endl; }
  report << "pred_sexr population: seq("<<styr<<","<<endyr<<")" << endl;
  report << predpop_sexr <<endl;
  report << "pred_sexr survey: seq("<<styr<<","<<endyr<<")" << endl;
  report << preds_sexr <<endl;
  report <<"likelihood: 'penal_rec','penal_sexr','change_sel_like','len_like_ret','len_like_tot','len_like_fem','len_like_surv','len_like_trawl', 'fpen',  'catch_like tot','catch ret', 'catch fem','catch trawl', 'surv_like','surv_like_nowt','largemale_like','initnum_penal','initsmo_penal','total likelihood'"<<endl;
  report <<penal_rec<<"  "<<penal_sexr<<"  "<<sel_50m_penal<<"  "
           <<like_wght(1)*len_like(1)<<" "<<like_wght(2)*len_like(2)<<" "<<like_wght(3)*len_like(3)<<" "<<like_wght(4)*len_like(4)<<" "<<like_wght(7)*len_like(5)<<" "<< " "
           <<fpen<<" "<<wght_total_catch*catch_like1<<" "<<like_wght(6)*catch_like2<<" "<<wght_female_potcatch*catch_likef<<" "<<like_wght(6)*0.01*catch_liket<<" "<<surv_like<<" "<<surv_like_nowt<<" "<<wt_lmlike*largemale_like<<" "<<initnum_penal<<" "<<initsmo_penal<<" "<<f<<endl;
  report <<"offset for survey lengths"<<endl;
  report <<offset(4)<<endl;
  report <<"survey length likelihoods: 'immature new female','immature new male','immature old female','immature old male','mature new female','mature new male','mature old female','mature old male'"<<endl;
  report <<len_like_srv<<endl;
  report <<"likelihood weights: 'retained length','total catch length','female catch','survey length','survey biomass','catch biomass','trawl length'"<<endl;
  report <<like_wght<<"  "<<like_wght_mbio<<endl;
  report <<"likelihood weights:  'rec devs','sex ratio','fishery 50%','fmort phase 1','fmort phase>1','fmort devs'"<<endl;
  report <<like_wght_rec<<"  "<<like_wght_sexr<<"  "<<like_wght_sel50<<"  "<<like_wght_fph1<<"  "<<like_wght_fph2<<"  "<<like_wght_fdev<<endl;
  report <<"likes bayesian: 'like_mmat','af_penal','bf_penal','am_penal','bm_penal'"<<endl;
  report <<af_penal<<" "<<bf_penal<<" "<<am_penal<<" "<<bm_penal<<endl;
  report<<"length - length transition matrix Females:'27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report<<len_len(1)<<endl;  
  report<<"length - length transition matrix Males:'27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  report<<len_len(2)<<endl;  
  report<<"effective N survey lengths immature new shell female "<<endl;
  report<<effn_srv(1,1,1)<<endl;
  report<<" effective N survey lengths mature new shell female "<<endl;
  report<<effn_srv(2,1,1)<<endl;
  report<<" effective N survey lengths mature old shell female "<<endl;
  report<<effn_srv(2,2,1)<<endl;
  report<<" effective N survey lengths immature new shell male "<<endl;
  report<<effn_srv(1,1,2)<<endl;
  report<<" effective N survey lengths immature old shell male "<<endl;
  report<<effn_srv(1,2,2)<<endl;
  report<<" effective N survey lengths mature new shell male "<<endl;
  report<<effn_srv(2,1,2)<<endl;
  report<<" effective N survey lengths mature old shell male "<<endl;
  report<<effn_srv(2,2,2)<<endl;
  report<<" effective N retained lengths new, old shell "<<endl;
  report<<effn_fish_ret<<endl;
  report<<" effective N total lengths new, old shell"<<endl;
  report<<effn_fish_tot<<endl;
  report<<"male new shell total pot fishery exploitation rates"<<endl;
  report<<1-mfexp(-1.0*F(1))<<endl;
  report<<"male old shell total pot fishery exploitation rates"<<endl;
  report<<1-mfexp(-1.0*F(2))<<endl;
  report<<"numbers new shell males at time of pop fishery"<<endl;
  report<<natl_new_fishtime(2)<<endl;
  report<<"numbers old shell males at time of pop fishery"<<endl;
  report<<natl_old_fishtime(2)<<endl;
  report<<"total catch in numbers new shell males"<<endl;
  report<<catch_lmale_new<<endl;
  report<<"total catch in numbers old shell males"<<endl;
  report<<catch_lmale_old<<endl;
  report<<"retained catch in numbers new shell males"<<endl;
  report<<catch_male_ret_new<<endl;
  report<<"retained catch in numbers old shell males"<<endl;
  report<<catch_male_ret_old<<endl;
  report<<"observed retained catch new shell males"<<endl;
  for (i=1; i<=nobs_fish; i++) 
   report<<yrs_fish(i)<<" "<<obs_p_fish_ret(1,i)*catch_numbers(yrs_fish(i))<<endl;
  report<<"observed retained catch old shell males"<<endl;
  for (i=1; i<=nobs_fish; i++) 
   report<<yrs_fish(i)<<" "<<obs_p_fish_ret(2,i)*catch_numbers(yrs_fish(i))<<endl;
  
  //compute GHL 
  for(i=2000;i<=endyr;i++)
  {
    hrate=0.1+(((mspbio_srv(i)+fspbio_srv(i))*2.2-230.4)*(0.125/691.2));
    if((mspbio_srv(i)+fspbio_srv(i))<=(230.4/2.2)) hrate=0.0;
    if((mspbio_srv(i)+fspbio_srv(i))>(921.6/2.2)) hrate=0.225;
    ghl=hrate*2.2*mspbio_srv(i);
    // get numbers by dividing by average weight of crabs greater than 102 from 2003 survey
    ghl_number=ghl/1.27;
    // cap of 58% of exploitable males = new shell>101 + 25% of old shell>101
    if((1000.*ghl_number)> (0.58*(legal_srv_males_n(i)+(0.25*legal_srv_males_o(i)))))
     {
      ghl_number = (0.58*(legal_srv_males_n(i)+(0.25*legal_srv_males_o(i))))/1000.;
      ghl = ghl_number*1.27;
     }

    report <<"year, harvest rate, GHL in 1000 tons then 1000's of crabs: 'year','hrate','ghl','ghl_nos'";
    report <<i<<"  "<<hrate<<"  "<<ghl<<"  "<<ghl_number<<endl;
    report <<" estimated survey mature female biomass "<<fspbio_srv(i)<<endl;
    report <<" estimated survey mature male biomass "<<mspbio_srv(i)<<endl;
    report <<"number of estimated survey new males > 101mm "<<legal_srv_males_n(i)<<endl;
    report <<"number of estimated survey old males > 101mm "<<legal_srv_males_o(i)<<endl;

   }
  // stuff for input to projection model
  report<<"#number of length bins"<<endl;
  report<<nlenbins<<endl;
  report<<"#Nat mort immature female/male"<<endl;
  report<<M<<endl;
  report<<"#nat mort mature new shell female/male"<<endl;
  report<<M_matn<<endl;
  report<<"#nat mort mature old shell female/male"<<endl;
  report<<M_mato<<endl;
  report<<"#constant recruitment"<<endl;
  report<<"1000000"<<endl;
  report<<"#average of last 4 years sel total male new old shell"<<endl;
  report<<(sel(1,endyr-4)+sel(1,endyr-3)+sel(1,endyr-2)+sel(1,endyr-1))/4.0<<endl;
  report<<(sel(1,endyr-4)+sel(2,endyr-3)+sel(2,endyr-2)+sel(2,endyr-1))/4.0<<endl;
  report<<"#average of last 4 years sel retained curve male new old shell"<<endl;
  report<<(sel_fit(1,endyr-3)+sel_fit(1,endyr-2)+sel_fit(1,endyr-1))/3.0<<endl;
  report<<(sel_fit(2,endyr-3)+sel_fit(2,endyr-2)+sel_fit(2,endyr-1))/3.0<<endl;
  report<<"#trawl selectivity female male"<<endl;
  report<<sel_trawl(3)<<endl;
  report<<"#female pot discard selectivity"<<endl;
  report<<sel_discf<<endl;
  report <<"#selectivity snow females"<< endl;
  report <<sel_disc_snow(3,1)<<endl;
  report << "#selectivity snow males"<< endl;
  report <<sel_disc_snow(3,2)<<endl;
  report <<"#selectivity redk females"<< endl;
  report <<sel_disc_rkc(3,1)<<endl;
  report <<"#selectivity redk males"<< endl;
  report <<sel_disc_rkc(3,2)<<endl; 
  report<<"#maturity curve new shell female male"<<endl;
  report<<maturity_est(1)<<endl;
  report<<maturity_est(2)<<endl;
  report<<"#maturity curve old shell female male"<<endl;
  report<<maturity_old_average<<endl;
  report<<"#molting probability immature female male"<<endl;
  report<<moltp<<endl;
  report<<"#molting probability mature female male"<<endl;
  report<<moltp_mat<<endl;
  report<<"#prop recruits to new shell"<<endl;
  report<<proprecn<<endl;
  report<<"#distribution of recruits to length bins"<<endl;
  report<<rec_len<<endl;
  report<<"#time of catch in fraction of year from survey - 7 months"<<endl;
  report<<F_midpt(endyr)<<endl;
  report<<"#number at length new shell females males at time of fishery endyr from model"<<endl;
  report<<natl_new_fishtime(1,endyr)<<endl;
  report<<natl_new_fishtime(2,endyr)<<endl;
  report<<"#number at length old shell females males at time of fishery endyr from model"<<endl;
  report<<natl_old_fishtime(1,endyr)<<endl;
  report<<natl_old_fishtime(2,endyr)<<endl;
  report<<"#last year male spawning biomass"<<endl;
  report<<mspbio(endyr)<<endl;
  report<<"#last year female spawning biomass"<<endl;
  report<<fspbio(endyr)<<endl;
  report<<"#last year male spawning biomass at matingtime"<<endl;
  report<<mspbio_matetime(endyr)<<endl;
  report<<"#last year female spawning biomass at matingtime"<<endl;
  report<<fspbio_matetime(endyr)<<endl;
  report<<"#numbers at length immature new shell female male last year"<<endl;
  report<<natlength_inew(1,endyr)<<endl;
  report<<natlength_inew(2,endyr)<<endl;
  report<<"#numbers at length immature old shell female male last year"<<endl;
  report<<natlength_iold(1,endyr)<<endl;
  report<<natlength_iold(2,endyr)<<endl;
  report<<"#numbers at length mature new shell female male last year"<<endl;
  report<<natlength_mnew(1,endyr)<<endl;
  report<<natlength_mnew(2,endyr)<<endl;
  report<<"#numbers at length mature old shell female male last year"<<endl;
  report<<natlength_mold(1,endyr)<<endl;
  report<<natlength_mold(2,endyr)<<endl;
  report<<"#weight at length female juvenile"<<endl;
  report<<wtf(1)<<endl;
  report<<"#weight at length female mature"<<endl;
  report<<wtf(2)<<endl;
  report<<"#weight at length male"<<endl;
  report<<wtm<<endl;
  report<<"#length-length transition matrix"<<endl;
  report<<len_len<<endl;
  report<<"#female discard pot fishing F"<<endl;
  report<<mean(fmortdf(endyr-5,endyr-1))<<endl;
  report<<"#trawl fishing F female male average last 5 yrs"<<endl;
  report<<mean(fmortt(endyr-5,endyr-1))<<endl;
  report<<"#snow fishing F female male average last 5 yrs"<<endl;
  report<<mean(fmortd_snow(endyr-5,endyr-1))<<endl;
  report<<"#red king fishing F female male average last 5 yrs"<<endl;
  report<<mean(fmortd_rk(endyr-5,endyr-1))<<endl;
  report<<"#number of recruits from the model styr to endyr-1"<<endl;
  report<<endyr-styr<<endl;
  report<<"#number of recruits for avg to estimate B35%"<<endl;
  report<<endyr-1960<<endl;
  report <<"#recruitments female, male start year to endyr-1 from model" << endl;
  for(i=styr; i<=1973; i++) report << mfexp(mean_log_rec1_early+rec_devf_early(i))<<" ";
  for(i=1974; i<=(endyr-1); i++) report << mfexp(mean_log_rec(1)+rec_dev(1,i))<<" ";
  report <<endl<< "#recruitments male, male start 1960 to endyr-1 from model" << endl;
  for(i=styr; i<=1973; i++) report << mfexp(mean_log_rec1_early+rec_devf_early(i))<<" ";
  for(i=1974; i<endyr; i++) report << mfexp(mean_log_rec(2)+rec_dev(2,i))<<" "; report<<endl;
  
  report<<"#male spawning biomass at matetime for endyr-5 to endyr-1 for spawner recruit curve to estimate recruitments"<<endl;
  report<<mspbio_matetime(endyr-5,endyr-1)<<endl;
  report<<"#male spawning biomass at matetime for str year to endyr-1 for spawner recruit curve to estimate recruitments"<<endl;
  report<<mspbio_matetime(styr,endyr-1)<<endl;
  report <<"#selectivity survey males 1989 to endyr: '27.5','32.5','37.5','42.5','47.5','52.5','57.5','62.5','67.5','72.5','77.5','82.5','87.5','92.5','97.5','102.5','107.5','112.5','117.5','122.5','127.5','132.5','137.5','142.5','147.5','152.5','157.5','162.5','167.5','172.5','177.5','182.5'"<< endl;
  if (last_phase()) Write_R();

FUNCTION Write_R
  int ii,i,k,j;
  dvar_vector preds_sexr(styr,endyr);
  dvar_matrix tmpo(1,2,styr,endyr);
  dvar_matrix tmpp(1,2,styr,endyr);
  dvar_vector obs_tmp(styr,endyr);
  dvariable ghl,ghl_number;
  dvariable hrate;
  dvar_vector tmpp1(1,nlenbins);
  dvar_vector tmpp2(1,nlenbins);
  dvar_vector tmpp3(1,nlenbins);
  dvar_vector tmpp4(1,nlenbins);
  tmpp1.initialize();
  tmpp2.initialize();
  tmpp3.initialize();
  tmpp4.initialize();
    
  Misc_output();
  R_out <<"$Fout"<<endl<< Fout << endl<<"$fmort_pen"<<endl<<fmort_pen<<endl;
  for (i=styr;i<=endyr;i++)
    if((totn_srv(1,i)+totn_srv(2,i))<0.01) {
      preds_sexr(i)=0.0;}
    else{
      preds_sexr(i)=totn_srv(1,i)/(totn_srv(1,i)+totn_srv(2,i));
    }
    R_out << "$Estimated.numbers.of.immature.new.shell.female.crab.by.length"<< endl;
    for(i=styr;i<=endyr;i++) R_out <<  i<<" "<<natlength_inew(1,i) << endl;
    R_out << "$Estimated.numbers.of.immature.old.shell.female.crab.by.length"<< endl;
    for(i=styr;i<=endyr;i++) R_out <<  i<<" "<<natlength_iold(1,i) << endl;
    R_out << "$Estimated.numbers.of.mature.new.shell.female.crab.by.length"<< endl;
    for(i=styr;i<=endyr;i++) R_out <<  i<<" "<<natlength_mnew(1,i) << endl;
    R_out << "$Estimated.numbers.of.mature.old.shell.female.crab.by.length"<< endl;
    for(i=styr;i<=endyr;i++)R_out <<  i<<" "<<natlength_mold(1,i) << endl;
  
    R_out << "$Estimated.numbers.of.immature.new.shell.male.crab.by.length"<< endl;
    for(i=styr;i<=endyr;i++) R_out << i<<" "<<natlength_inew(2,i) << endl;
    R_out << "$Estimated.numbers.of.immature.old.shell.male.crab.by.length"<< endl;
    for(i=styr;i<=endyr;i++) R_out << i<<" "<<natlength_iold(2,i) << endl;
    R_out << "$Estimated.numbers.of.mature.new.shell.male.crab.by.length"<< endl;
    for(i=styr;i<=endyr;i++) R_out << i<<" "<<natlength_mnew(2,i) << endl;
    R_out << "$Estimated.numbers.of.mature.old.shell.male.crab.by.length"<< endl;
    for(i=styr;i<=endyr;i++) R_out << i<<" "<<natlength_mold(2,i) << endl;
   
    R_out << "$Observed.numbers.of.immature.new.shell.female.crab.by.length"<< endl;
    for (i=1; i <= nobs_srv_length; i++) R_out<<yrs_srv_length(i)<<" "<<obs_p_srv_len(1,1,1,i)*obs_srvt(yrs_srv_length(i))<<endl;
    R_out << "$Observed.numbers.of.mature.new.shell.female.crab.by.length"<< endl;
    for (i=1; i <= nobs_srv_length; i++) R_out<<yrs_srv_length(i)<<" "<<obs_p_srv_len(2,1,1,i)*obs_srvt(yrs_srv_length(i))<<endl;
    R_out << "$Observed.numbers.of.mature.old.shell.female.crab.by.length"<< endl;
    for (i=1; i <= nobs_srv_length; i++) R_out<<yrs_srv_length(i)<<" "<<obs_p_srv_len(2,2,1,i)*obs_srvt(yrs_srv_length(i))<<endl;
    R_out << "$Observed.numbers.of.immature.new.shell.male.crab.by.length"<< endl;
    for (i=1; i <= nobs_srv_length; i++) R_out<<yrs_srv_length(i)<<" "<<obs_p_srv_len(1,1,2,i)*obs_srvt(yrs_srv_length(i))<<endl;
  R_out << "$Observed.numbers.of.immature.old.shell.male.crab.by.length"<< endl;
  for (i=1; i <= nobs_srv_length; i++) R_out<<yrs_srv_length(i)<<" "<<obs_p_srv_len(1,2,2,i)*obs_srvt(yrs_srv_length(i))<<endl;
  R_out << "$Observed.numbers.of.mature.new.shell.male.crab.by.length"<< endl;
  for (i=1; i <= nobs_srv_length; i++) R_out<<yrs_srv_length(i)<<" "<<obs_p_srv_len(2,1,2,i)*obs_srvt(yrs_srv_length(i))<<endl;
  R_out << "$Observed.numbers.of.mature.old.shell.male.crab.by.length"<< endl;
  for (i=1; i <= nobs_srv_length; i++) R_out<<yrs_srv_length(i)<<" "<<obs_p_srv_len(2,2,2,i)*obs_srvt(yrs_srv_length(i))<<endl;
  R_out << "$Observed.Survey.Numbers.by.length.females"<< endl;
  for (i=1; i <= nobs_srv_length; i++) R_out<<yrs_srv_length(i)<<" " << obs_srv_num(1,yrs_srv_length(i)) << endl;
  R_out << "$Observed.Survey.Numbers.by.length.males"<< endl;
  for (i=1; i <= nobs_srv_length; i++) R_out<<yrs_srv_length(i)<<" " << obs_srv_num(2,yrs_srv_length(i))<< endl;
  
  R_out << "$Predicted.Survey.Numbers.by.length.females"<< endl;
  for (i=1; i <= nobs_srv_length; i++) R_out<<yrs_srv_length(i)<<" "  << pred_srv(1,yrs_srv_length(i)) << endl;
  R_out << "$Predicted.Survey.Numbers.by.length.males"<< endl;
  for (i=1; i <= nobs_srv_length; i++) R_out<<yrs_srv_length(i)<<" "  << pred_srv(2,yrs_srv_length(i)) << endl;
  R_out << "$Predicted.pop.Numbers.by.length.females"<< endl;
  for(i=styr;i<=endyr;i++) R_out<<i<<" "<< natlength(1,i)<< endl;
  R_out << "$Predicted.pop.Numbers.by.length.males"<< endl;
  for(i=styr;i<=endyr;i++) R_out<<i<<" "<< natlength(2,i)<< endl;
 
    //actual years for obs survey male are 1969,1970,1972-2009
   R_out<<"$observed.number.of.males.greater.than.101.mm"<<endl;
  R_out<<obs_lmales<<endl;
  R_out<<"$observed.biomass.of.males.greater.than.101.mm"<<endl;
  R_out<<obs_lmales_bio<<endl;
  R_out<<"$pop.estimate.numbers.of.males.101"<<endl;
  R_out<<legal_males<<endl;
  R_out<<"$estimated.population.biomass.of.males.101"<<endl;
  R_out<<legal_males_bio<<endl;
  R_out<<"$estimated.survey.numbers.of.males.101"<<endl;
  R_out<<legal_srv_males<<endl;
  R_out<<"$estimated.survey.biomass.of.males.101"<<endl;
  R_out<<legal_srv_males_bio<<endl;
  R_out << "$Observed.survey.biomass"<<endl;
  R_out << obs_srv_biom(1969,endyr)<<endl;
  R_out << "$predicted.survey.biomass"<<endl;
  R_out << pred_srv_bioms(1)+pred_srv_bioms(2)<<endl;
  
  //survey numbers
  for(k=1;k<=2;k++)
   for(i=styr;i<=endyr;i++)
    {
     tmpo(k,i)=sum(obs_srv_num(k,i));
     tmpp(k,i)=sum(pred_srv(k,i));
    }
  R_out << "$Observed.survey.numbers.female"<<endl;
  R_out << tmpo(1)<<endl;
  R_out << "$Observed.survey.numbers.male"<<endl;
  R_out << tmpo(2)<<endl;
  R_out << "$predicted.survey.numbers.female"<<endl;
  R_out << tmpp(1)<<endl;
  R_out << "$predicted.survey.numbers.male"<<endl;
  R_out << tmpp(2)<<endl;
  R_out << "$Observed.survey.female.spawning.biomass"<<endl;
  R_out << obs_srv_spbiom(1)<<endl;
  R_out << "$Observed.survey.male.spawning.biomass"<<endl;
  R_out << obs_srv_spbiom(2)<<endl;
  R_out << "$Observed.survey.female.new.spawning.numbers"<<endl;
  R_out << obs_srv_spnum(1,1)<<endl;
  R_out << "$Observed.survey.female.old.spawning.numbers"<<endl;
  R_out << obs_srv_spnum(2,1)<<endl;
  R_out << "$Observed.survey.male.new.spawning.numbers"<<endl;
  R_out << obs_srv_spnum(1,2)<<endl;
  R_out << "$Observed.survey.male.old.spawning.numbers"<<endl;
  R_out << obs_srv_spnum(2,2)<<endl;
  R_out << "$Observed.survey.female.biomass"<<endl;
  R_out << obs_srv_bioms(1)<<endl;
  R_out << "$Observed.survey.male.biomass"<<endl;
  R_out << obs_srv_bioms(2)<<endl;
  R_out << "$natural.mortality.immature.females.males" << endl;
  R_out << M << endl;
  R_out << "$natural.mortality.mature.females.males" << endl;
  R_out << M_matn << endl;
  R_out << "$natural.mortality.mature.old.shell.females.males" << endl;
  R_out << M_mato << endl;
  R_out << "$Predicted.Biomass" << endl;
  R_out << pred_bio << endl;
  R_out << "$Predicted.total.population.numbers"<<endl;
  R_out <<popn<<endl;
  R_out << "$Female.Spawning.Biomass" << endl;
  R_out << fspbio << endl;
  R_out << "$Male.Spawning.Biomass" << endl;
  R_out << mspbio << endl;
  R_out << "$Total.Spawning.Biomass" << endl;
  R_out << fspbio+mspbio << endl;
  R_out << "$Female.Spawning.Biomass.at.fish.time" << endl;
  R_out << fspbio_fishtime << endl;
  R_out << "$Male.Spawning.Biomass.at.fish.time" << endl;
  R_out << mspbio_fishtime << endl;
  R_out << "$Total.Spawning.Biomass.at.fish.time" << endl;
  R_out << fspbio_fishtime+mspbio_fishtime << endl;
  R_out << "$Mating.time.Female.Spawning.Biomass" << endl;
  R_out << fspbio_matetime << endl;
  R_out << "$Mating.time.Male.Spawning.Biomass" << endl;
  R_out << mspbio_matetime << endl;
  R_out << "$Mating.time.Male.old.shell.Spawning.Biomasss" << endl;
  R_out << mspbio_old_matetime << endl;
  R_out << "$Mating.time.female.new.shell.Spawning.Biomass" << endl;
  R_out << fspbio_new_matetime << endl;
  R_out << "$Mating.time.Total.Spawning.Biomass" << endl;
  R_out << fspbio_matetime+mspbio_matetime << endl;
  R_out << "$Mating.time.effective.Female.Spawning.Biomass" << endl;
  R_out << efspbio_matetime << endl;
  R_out << "$Mating.time.effective.Male.Spawning.Biomass.old.shell.only" << endl;
  R_out << emspbio_matetime << endl;
  R_out << "$Mating.time.Total.effective.Spawning.Biomass" << endl;
  R_out << efspbio_matetime+emspbio_matetime << endl;
  R_out << "$Mating.time.male.Spawning.numbers" << endl;
  R_out << mspnum_matetime << endl;
  R_out << "$Mating.time.Female.Spawning.numbers" << endl;
  R_out << efspnum_matetime << endl;
  R_out << "$Mating.time.Male.Spawning.numbers.old.shell.only" << endl;
  R_out << emspnum_old_matetime << endl;
//  R_out << "$ratio.Mating.time.Female.Spawning.numbers.to.male.old.shell.mature.numbers" << endl;
//  R_out << elem_div(efspnum_matetime,emspnum_old_matetime) << endl;
  R_out << "$Mating.time.effective.Female.new.shell.Spawning.biomass" << endl;
  R_out <<efspbio_new_matetime << endl;
  R_out << "$Mating.time.Female.new.shell.Spawning.numbers" << endl;
  R_out << fspnum_new_matetime << endl;
//  R_out << "$ratio Mating time Female new shell Spawning numbers to male old shell mature numbers " << endl;
//            for(i=styr;i<=endyr;i++){if(emspnum_old_matetime(i)<0.001) emspnum_old_matetime(i)=1.0; }
//  R_out << elem_div(fspnum_new_matetime,emspnum_old_matetime) << endl;
  R_out << "$Predicted.Female.survey.Biomass" << endl;
  R_out << pred_srv_bioms(1) << endl;
  R_out << "$Predicted.Male.survey.Biomass" << endl;
  R_out << pred_srv_bioms(2)<< endl;
  R_out << "$Predicted.Female.survey.mature.Biomass" << endl;
  R_out << fspbio_srv << endl;
  R_out << "$Predicted.Male.survey.mature.Biomass" << endl;
  R_out << mspbio_srv<< endl;
  R_out << "$Predicted.total.survey.mature.Biomass" << endl;
  R_out << fspbio_srv+mspbio_srv<< endl;
  R_out << "$Predicted.Female.survey.new.mature.numbers" << endl;
  R_out << fspbio_srv_num(1) << endl;
  R_out << "$Predicted.Female.survey.old.mature.numbers" << endl;
  R_out << fspbio_srv_num(2) << endl;
  R_out << "$Predicted.Male.survey.new.mature.numbers" << endl;
  R_out << mspbio_srv_num(1)<< endl;
  R_out << "$Predicted.Male.survey.old.mature.numbers" << endl;
  R_out << mspbio_srv_num(2)<< endl;

  R_out << "$Observed.Prop.fishery.ret.new.males"<< endl;
  for (i=1; i<=nobs_fish; i++) R_out << yrs_fish(i) << " " << obs_p_fish_ret(1,i)<< endl;
  R_out << "$Predicted.length.prop.fishery.ret.new.males" << endl;
  for (i=1; i<=nobs_fish; i++) 
   {
    ii=yrs_fish(i);  
    R_out <<  ii  <<  " "  <<  pred_p_fish_fit(1,ii)  << endl;
   }
  R_out << "$Observed.Prop.fishery.ret.old.males"<< endl;
  for (i=1; i<=nobs_fish; i++) R_out << yrs_fish(i) << " " << obs_p_fish_ret(2,i)<< endl;
  R_out << "$Predicted.length.prop.fishery.ret.old.males" << endl;
  for (i=1; i<=nobs_fish; i++)
   {
    ii=yrs_fish(i);  
    R_out <<  ii  <<  " "  <<  pred_p_fish_fit(2,ii)  << endl;
   }

  R_out << "$Observed.Prop.fishery.total.new.males"<< endl;
  for (i=1; i<=nobs_fish_discm; i++) R_out << yrs_fish_discm(i) << " " << obs_p_fish_tot(1,i) << endl;
  R_out << "$Predicted.length.prop.fishery.total.new.males" << endl;
  for (i=1; i<=nobs_fish_discm; i++)
   {
    ii=yrs_fish_discm(i);  
    R_out <<  ii  <<  " "  <<  pred_p_fish(1,ii)  << endl;
   }
  R_out << "$Observed.Prop.fishery.total.old.males"<< endl;
  for (i=1; i<=nobs_fish_discm; i++) R_out << yrs_fish_discm(i) << " " << obs_p_fish_tot(2,i) << endl;
  R_out << "$Predicted.length.prop.fishery.total.old.males" << endl;
  for (i=1; i<=nobs_fish_discm; i++)
   {
    ii=yrs_fish_discm(i);  
    R_out <<  ii  <<  " "  <<  pred_p_fish(2,ii)  << endl;
   }
  R_out << "$Observed.Prop.fishery.discard.new.males"<< endl;
  for (i=1; i<=nobs_fish_discm; i++) R_out << yrs_fish_discm(i) << " " << obs_p_fish_discm(1,i) << endl;
  R_out << "$Observed.Prop.fishery.discard.old.males"<< endl;
  for (i=1; i<=nobs_fish_discm; i++) R_out << yrs_fish_discm(i) << " " << obs_p_fish_discm(2,i)<< endl;

  R_out << "$Observed.length.prop.fishery.discard.all.females" << endl;
  for (i=1; i<=nobs_fish_discf; i++) R_out <<  yrs_fish_discf(i)  <<  " "  <<  obs_p_fish_discf(i)  << endl;
  R_out << "$Predicted.length.prop.fishery.discard.all.females" << endl;
  for (i=1; i<=nobs_fish_discf; i++)
   {
    ii=yrs_fish_discf(i);  
    R_out <<  ii  <<  " "  <<  pred_p_fish_discf(ii)  << endl;
   }
  R_out << "$Observed.length.prop.snow.fishery.females" << endl;
  for (i=1; i<=nobs_snowfish_discf; i++)
   {
    R_out <<  yrs_snowfish_discf(i)  <<  " "  <<  obs_p_snow(1,i)  << endl;
   }
  R_out << "$Predicted.length.prop.snow.fishery.females" << endl;
  for (i=1; i<=nobs_snowfish_discf; i++)
   {
    ii=yrs_snowfish_discf(i);  
    R_out <<  ii  <<  " "  <<  pred_p_snow(1,ii)  << endl;
   }
  R_out << "$Observed.length.prop.snow.fishery.males" << endl;
  for (i=1; i<=nobs_snowfish_discm; i++)
   {
    R_out <<  yrs_snowfish_discm(i)  <<  " "  <<  obs_p_snow(2,i)  << endl;
   }
  R_out << "$Predicted.length.prop.snow.fishery.males" << endl;
  for (i=1; i<=nobs_snowfish_discm; i++)
   {
    ii=yrs_snowfish_discm(i);  
    R_out <<  ii  <<  " "  <<  pred_p_snow(2,ii)  << endl;
   }
  R_out << "$Observed.length.prop.redk.fishery.females" << endl;
  for (i=1; i<=nobs_rkfish_discf; i++)
   {
    R_out <<  yrs_rkfish_discf(i)  <<  " "  <<  obs_p_rk(1,i)  << endl;
   }
  R_out << "$Predicted.length.prop.redk.fishery.females" << endl;
  for (i=1; i<=nobs_rkfish_discf; i++)
   {
    ii=yrs_rkfish_discf(i);  
    R_out <<  ii  <<  " "  <<  pred_p_rk(1,ii)  << endl;
   }
  R_out << "$Observed.length.prop.redk.fishery.males" << endl;
  for (i=1; i<=nobs_rkfish_discm; i++)
   {
    R_out <<  yrs_rkfish_discm(i)  <<  " "  <<  obs_p_rk(2,i)  << endl;
   }
  R_out << "$Predicted.length.prop.redk.fishery.males" << endl;
  for (i=1; i<=nobs_rkfish_discm; i++)
   {
    ii=yrs_rkfish_discm(i);  
    R_out <<  ii  <<  " "  <<  pred_p_rk(2,ii)  << endl;
   }

  R_out << "$Predicted.length.prop.trawl.females" << endl;
  for (i=1; i<=nobs_trawl; i++)
   {
    ii=yrs_trawl(i);  
    R_out <<  ii  <<  " "  <<  pred_p_trawl(1,ii)  << endl;
   }
  R_out << "$Observed.length.prop.trawl.females" << endl;
  for (i=1; i<=nobs_trawl; i++) R_out <<  yrs_trawl(i)  <<  " "  <<  obs_p_trawl(1,i)  << endl;
  R_out << "$Predicted.length.prop.trawl.males" << endl;
  for (i=1; i<=nobs_trawl; i++)
   {
    ii=yrs_trawl(i);  
    R_out <<  ii  <<  " "  <<  pred_p_trawl(2,ii)  << endl;
   }
  R_out << "$Observed.length.prop.trawl.males" << endl;
  for (i=1; i<=nobs_trawl; i++) R_out <<  yrs_trawl(i)  <<  " "  <<  obs_p_trawl(2,i)  << endl;

  R_out << "$Observed.Length.Prop.survey.immature.new.females" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);
    R_out << ii <<" " <<obs_p_srv_len(1,1,1,i) << endl;
   }
  R_out << "$Predicted.length.prop.survey.immature.new.females" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    R_out << ii << " " << pred_p_srv_len_new(1,1,ii) << endl;
   }
  R_out << "$Observed.Length.Prop.survey.immature.old.females" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);
    R_out << ii <<" " <<obs_p_srv_len(1,2,1,i) << endl;
   }
  R_out << "$Predicted.length.prop.survey.immature.old.females" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    R_out << ii << " " << pred_p_srv_len_old(1,1,ii) << endl;
   }
 
  R_out << "$Observed.Length.Prop.survey.immature.new.males" << endl;
  for (i=1; i<=nobs_srv_length; i++) R_out << yrs_srv_length(i) <<" " <<obs_p_srv_len(1,1,2,i) << endl;
  R_out << "$Predicted.length.prop.survey.immature.new.males" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    R_out << ii << " " << pred_p_srv_len_new(1,2,ii) << endl;
   }
  R_out << "$Observed.Length.Prop.survey.immature.old.males" << endl;
  for (i=1; i<=nobs_srv_length; i++) R_out << yrs_srv_length(i) <<" " <<obs_p_srv_len(1,2,2,i) << endl;
  R_out << "$Predicted.length.prop.survey.immature.old.males" << endl;
  for (i=1; i<=nobs_srv_length; i++)
  {
   ii=yrs_srv_length(i);  
   R_out << ii << " " << pred_p_srv_len_old(1,2,ii) << endl;
  }
  R_out << "$Observed.Length.Prop.survey.mature.new.females" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);
    R_out << ii <<" " <<obs_p_srv_len(2,1,1,i) << endl;
   }
  R_out << "$Predicted.length.prop.survey.mature.new.females" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    R_out << ii << " " << pred_p_srv_len_new(2,1,ii) << endl;
   }
  R_out << "$Observed.Length.Prop.survey.mature.old.females" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);
    R_out << ii <<" " <<obs_p_srv_len(2,2,1,i) << endl;
   }
  R_out << "$Predicted.length.prop.survey.mature.old.females" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    R_out << ii << " " << pred_p_srv_len_old(2,1,ii) << endl;
   }
 
  R_out << "$Observed.Length.Prop.survey.mature.new.males" << endl;
  for (i=1; i<=nobs_srv_length; i++) R_out << yrs_srv_length(i) <<" " <<obs_p_srv_len(2,1,2,i) << endl;
  R_out << "$Predicted.length.prop.survey.mature.new.males" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    R_out << ii << " " << pred_p_srv_len_new(2,2,ii) << endl;
   }
  R_out << "$Observed.Length.Prop.survey.mature.old.males" << endl;
  for (i=1; i<=nobs_srv_length; i++) R_out << yrs_srv_length(i) <<" " <<obs_p_srv_len(2,2,2,i) << endl;
  R_out << "$Predicted.length.prop.survey.mature.old.males" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    R_out << ii << " " << pred_p_srv_len_old(2,2,ii) << endl;
   }
//for females don't have length data in first four years first year is 1974
     R_out << "$Observed.Length.Prop.survey.all.females" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);
    R_out << ii <<" " <<obs_p_srv_len(1,1,1,i)+obs_p_srv_len(2,1,1,i)+obs_p_srv_len(2,2,1,i)<< endl;
              tmpp4+=obs_p_srv_len(1,1,1,i)+obs_p_srv_len(2,1,1,i)+obs_p_srv_len(2,2,1,i);
   }
  R_out << "$Predicted.length.prop.survey.all.females" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    R_out << ii << " " << pred_p_srv_len_new(1,1,ii)+pred_p_srv_len_new(2,1,ii)+pred_p_srv_len_old(2,1,ii) << endl;
    tmpp1+=pred_p_srv_len_new(1,1,ii)+pred_p_srv_len_new(2,1,ii)+pred_p_srv_len_old(2,1,ii);
   }
  R_out << "$Observed.Length.Prop.survey.all.males" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);
    R_out << ii <<" " <<obs_p_srv_len(1,1,2,i)+obs_p_srv_len(1,2,2,i)+obs_p_srv_len(2,1,2,i)+obs_p_srv_len(2,2,2,i)<< endl;
         tmpp2+=obs_p_srv_len(1,1,2,i)+obs_p_srv_len(1,2,2,i)+obs_p_srv_len(2,1,2,i)+obs_p_srv_len(2,2,2,i);
   }
  R_out << "$Predicted.length.prop.survey.all.males" << endl;
  for (i=1; i<=nobs_srv_length; i++)
   {
    ii=yrs_srv_length(i);  
    R_out << ii << " " << pred_p_srv_len_new(1,2,ii)+pred_p_srv_len_new(2,2,ii)+pred_p_srv_len_old(2,2,ii) << endl;
  tmpp3+=pred_p_srv_len_new(1,2,ii)+pred_p_srv_len_new(2,2,ii)+pred_p_srv_len_old(2,2,ii);
   }
  R_out << "$Sum.of.predicted.prop.survey.all.females" << endl;
            R_out <<tmpp1<<endl;
  R_out << "$Sum.of.predicted.prop.survey.all.males" << endl;
            R_out <<tmpp3<<endl;
  R_out << "$Sum.of.Observed.prop.survey.all.females" << endl;
            R_out <<tmpp4<<endl;
  R_out << "$Sum.of.Observed.prop.survey.all.males" << endl;
            R_out <<tmpp2<<endl;

  R_out << "$Predicted.mean.postmolt.length.females"<< endl;
  R_out << mean_length(1) << endl;
  R_out << "$Predicted.mean.postmolt.length.males"<< endl;
  R_out << mean_length(2)<<endl; 
  R_out << "$af1" << endl;
  R_out << af1 << endl;
//  R_out << "$af2" << endl;
//  R_out << af2 << endl;
  R_out << "$am1" << endl;
  R_out << am1 << endl;
//  R_out << "$am2" << endl;
//  R_out << am2 << endl;
  R_out << "$bf1" << endl;
  R_out << bf1 << endl;
//  R_out << "$bf2" << endl;
//  R_out << bf2 << endl;
  R_out << "$bm1" << endl;
  R_out << bm1 << endl;
//  R_out << "$bm2" << endl;
//  R_out << bm2 << endl;
  R_out<<"$Predicted.probability.of.maturing.females"<<endl;
  R_out<<maturity_est(1)<<endl;
  R_out<<"$Predicted.probability.of.maturing.males"<<endl;
  R_out<<maturity_est(2)<<endl;
  R_out<<"$molting.probs.female"<<endl;
  R_out<<moltp(1)<<endl;
  R_out<<"$molting.probs.male"<< endl;
  R_out<<moltp(2)<<endl;
  R_out <<"$Molting.probability.mature.males"<< endl;
  R_out <<moltp_mat(2)<<endl;
  R_out << "$observed.pot.fishery.cpue.1979.fishery.to.endyr.fishery" << endl;
  R_out <<cpue(1969,endyr-1)<<endl;
  R_out << "$predicted.pot.fishery.cpue.1978.to.endyr1.survey" << endl;
  R_out <<cpue_pred(styr,endyr-1)<<endl;
  R_out << "$observed.retained.catch.biomass" << endl;
  R_out << catch_ret(1965,endyr-1) << endl;
  R_out << "$predicted.retained.catch.biomass" << endl;
  R_out << pred_catch_ret(styr,endyr-1)<<endl;
  R_out << "$predicted.retained.new.catch.biomass" << endl;
  R_out << (catch_male_ret_new*wtm)(styr,endyr-1)<<endl;
  R_out << "$predicted.retained.old.catch.biomass" << endl;
  R_out << (catch_male_ret_old*wtm)(styr,endyr-1)<<endl;
  R_out << "$observed.retained.discard.male.catch.biomass" << endl;
  R_out << obs_catchtot_biom(1992,endyr-1) << endl;
  R_out << "$predicted.retained.discard.male.catch.biomass" << endl;
  R_out << pred_catch(styr,endyr-1) << endl;
  R_out << "$predicted.retained.discard.new.male.catch.biomass" << endl;
  R_out << (catch_lmale_new*wtm)(styr,endyr-1) << endl;
  R_out << "$predicted.retained.discard.old.male.catch.biomass" << endl;
  R_out << (catch_lmale_old*wtm)(styr,endyr-1) << endl;
  R_out << "$observed.discard.male.mortality.biomass"<<endl;
  R_out << (obs_catchtot_biom(1992,endyr-1)-catch_ret(1992,endyr-1)) <<endl;
  R_out << "$predicted.discard.male.catch.biomass" << endl;
  R_out << pred_catch(styr,endyr-1) -pred_catch_ret(styr,endyr-1)<< endl;
  R_out << "$observed.female.discard.mortality.biomass" << endl;
  R_out << obs_catchdf_biom(1992,endyr-1) << endl;
  R_out << "$predicted.female.discard.mortality.biomass" << endl;
  R_out << pred_catch_disc(1)(styr,endyr-1) << endl;
  R_out << "$observed.male.discard.mortality.biomass" << endl;
  R_out << obs_catchdm_biom(1992,endyr-1) << endl;
  R_out << "$observed.trawl.catch.biomass"<<endl;
  R_out << obs_catcht_biom(yrs_trawl_c)<<endl;
  R_out << "$predicted.trawl.catch.biomass"<<endl;
  R_out <<pred_catch_trawl<<endl;
  R_out << "$observed.snow.female.discard.mortality.biomass" << endl;
  R_out << catch_snowodisc(1) << endl;
  R_out << "$predicted.snow.female.discard.mortality.biomass" << endl;
  R_out << pred_catch_female_snowd << endl;
  R_out << "$observed.snow.male.discard.mortality.biomass" << endl;
  R_out << catch_snowodisc(2) << endl;
  R_out << "$predicted.snow.male.discard.mortality.biomass" << endl;
  R_out << pred_catch_snowd << endl;  
  R_out << "$observed.redk.female.discard.mortality.biomass" << endl;
  R_out << catch_rkodisc(1) << endl;
  R_out << "$predicted.redk.female.discard.mortality.biomass" << endl;
  R_out << pred_catch_female_rkd << endl;
  R_out << "$observed.redk.male.discard.mortality.biomass" << endl;
  R_out << catch_rkodisc(2) << endl;
  R_out << "$predicted.redk.male.discard.mortality.biomass" << endl;
  R_out << pred_catch_rkd << endl;
  R_out << "$predicted.total.male.catch.biomass" << endl;
  R_out<<pred_catch(styr,endyr-1)+pred_catch_rkd(styr,endyr-1)+pred_catch_snowd(styr,endyr-1)+pred_catch_trawl(styr,endyr-1)/2.0<<endl;
  R_out << "$predicted.total.female.catch.biomass" << endl;
  R_out<<pred_catch_disc(1)(styr,endyr-1)+pred_catch_female_rkd(styr,endyr-1)+pred_catch_female_snowd(styr,endyr-1)+pred_catch_trawl(styr,endyr-1)/2.0<<endl;
//  R_out<<"$Estimated total catch div. by male spawing biomass at fishtime"<<endl;
//  R_out<<elem_div(pred_catch(styr,endyr-1)+pred_catch_rkd(styr,endyr-1)+pred_catch_snowd(styr,endyr-1)+pred_catch_trawl(styr,endyr-1)/2.0,mspbio_fishtime(styr,endyr-1))<<endl;
//  R_out << "$estimated retained catch div. by male spawning biomass at fishtime" << endl;
//  R_out <<elem_div(pred_catch_ret,mspbio_fishtime)(styr,endyr-1) << endl;
//  R_out << "$estimated total catch div. by male spawning biomass at fishtime" << endl;
//  R_out <<elem_div(pred_catch,mspbio_fishtime)(styr,endyr-1) << endl;
//  R_out << "$estimated total catch of legal males by legal males at fishtime" << endl;
//   R_out <<elem_div(pred_catch_gt101(styr,endyr-1),bio_males_gt101(styr,endyr-1)) << endl;
//  R_out << "$estimated total catch numbers of males >101 div. by males numbers >101 at fishtime" << endl;
//  R_out <<elem_div(pred_catch_no_gt101(styr,endyr-1),num_males_gt101(styr,endyr-1)) << endl;
//  R_out << "$estimated total catch numbers of males 101 div. by survey estimate males numbers >101 at fishtime" << endl;
//  for(i=styr;i<endyr;i++) obs_tmp(i) = obs_lmales(i-(styr-1));
//  R_out <<elem_div(pred_catch_no_gt101(styr,endyr-1),obs_tmp(styr,endyr-1)*mfexp(-M_matn(2)*(7/12))) << endl;
//  for(i=styr;i<endyr;i++) obs_tmp(i) = obs_lmales_bio(i-(styr-1));

//  R_out << "$estimated total catch biomass of males >101 div. by survey estimate male biomass >101 at fishtime" << endl;
//  R_out <<elem_div(pred_catch_gt101(styr,endyr-1),obs_tmp(styr,endyr-1)*mfexp(-M_matn(2)*(7/12)) ) << endl;

//  R_out << "$estimated total catch biomass div. by survey estimate male mature biomass at fishtime" << endl;
//  R_out <<elem_div(pred_catch(styr,endyr-1),((obs_srv_spbiom(2))(styr,endyr-1))*mfexp(-M_matn(2)*(7/12))) << endl;

  R_out << "$estimated.annual.total.directed.fishing.mortality" << endl;
  R_out << fmort(styr,endyr-1) << endl;
  R_out << "$estimated.annual.snow.fishing.mortality" << endl;
  R_out << fmortd_snow(styr,endyr-1) << endl;
  R_out << "$estimated.annual.red.king.fishing.mortality" << endl;
  R_out << fmortd_rk(styr,endyr-1) << endl;
  R_out << "$estimated.annual.total.fishing.mortality" << endl;
  for(i=styr;i<=(endyr-1);i++) R_out << F(1,i)(nlenbins)+ Fdisct(2,i)(nlenbins)+Fdisc_snow(2,i)(nlenbins)+Fdisc_rk(2,i)(nlenbins) <<" "; R_out<< endl;
  R_out <<"$retained.F" << endl;
  for(i=styr;i<=(endyr-1);i++) R_out <<F_ret(1,i)(nlenbins)<<" "; R_out<<endl;
  R_out <<"$ghl" << endl;
  R_out <<catch_ghl/2.2<<endl;
  R_out << "$estimated.annual.fishing.mortality.females.pot" << endl;
  for(i=styr;i<=(endyr-1);i++) R_out << Fdiscf(i)(nlenbins) <<" "; R_out<<endl;
  R_out << "$estimated.annual.fishing.mortality.trawl.bycatch" << endl;
  R_out << fmortt(styr,endyr-1) <<endl;
//recruits in the model are 1978 to 2004, the 1978 recruits are those that enter the population
//in spring of 1979, before the 1979 survey - since using the survey as the start of the year
// in the model spring 1979 is stil 1978.  the last recruits are 2003 that come in spring 2004
  R_out << "$estimated.number.of.recruitments.female" << endl;
  for(i=styr; i<=1973; i++) R_out << mfexp(mean_log_rec1_early+rec_devf_early(i))<<" ";
  for(i=1974; i<=(endyr-1); i++) R_out << mfexp(mean_log_rec(1)+rec_dev(1,i))<<" ";
  R_out <<endl<< "$estimated.number.of.recruitments.male" << endl;
  for(i=styr; i<=1973; i++) R_out << mfexp(mean_log_rec1_early+rec_devf_early(i))<<" ";
  for(i=1974; i<=(endyr-1); i++) R_out << mfexp(mean_log_rec(2)+rec_dev(2,i))<<" ";
  for(i=1;i<=median_rec_yrs;i++)R_out<<2*median_rec<<" "; R_out<<endl;
  
  R_out<<"$distribution.of.recruits.to.length.bins"<<endl;
  R_out<<rec_len<<endl;
  R_out<<"$len_bins"<<endl;
  R_out<< "27.5 32.5 37.5 42.5 47.5 52.5 57.5 62.5 67.5 72.5 77.5 82.5 87.5 92.5 97.5 102.5 107.5 112.5 117.5 122.5 127.5 132.5 137.5 142.5 147.5 152.5 157.5 162.5 167.5 172.5 177.5 182.5"<<  endl;
  R_out << "$sel_fsh_m_n"<< endl;
  R_out << sel(1) << endl;
  R_out << "$sel_fsh_m_o"<< endl;
  R_out << sel(2) << endl;
  R_out << "$selectivity.fishery.ret.new.males"<< endl;
  R_out << sel_fit(1) << endl;
  R_out << "$selectivity.fishery.ret.old.males"<< endl;
  R_out << sel_fit(2) << endl;
  R_out <<"$retention.curve.males.new"<< endl;
  R_out <<sel_ret(1,endyr-1)<<endl;
  R_out <<"$retention.curve.males.old"<< endl;
  R_out <<sel_ret(2,endyr-1)<<endl;
  R_out << "$selectivity.discard.females"<< endl;
  R_out <<sel_discf<<endl;
  R_out << "$selectivity.trawl.females"<< endl;
  R_out <<sel_trawl(1,1)<<endl;
  R_out <<sel_trawl(2,1)<<endl;
  R_out <<sel_trawl(3,1)<<endl;  
  R_out << "$selectivity.trawl.males"<< endl;
//  R_out <<sel_trawl(2)<<endl;
  R_out <<sel_trawl(1,2)<<endl;
  R_out <<sel_trawl(2,2)<<endl;
  R_out <<sel_trawl(3,2)<<endl;
  R_out << "$selectivity.snow.females"<< endl;
  R_out <<sel_disc_snow(1,1)<<endl;
  R_out <<sel_disc_snow(2,1)<<endl;
  R_out <<sel_disc_snow(3,1)<<endl;  
  R_out << "$selectivity.snow.males"<< endl;
  R_out <<sel_disc_snow(1,2)<<endl;
  R_out <<sel_disc_snow(2,2)<<endl;
  R_out <<sel_disc_snow(3,2)<<endl;
  R_out << "$selectivity.redk.females"<< endl;
  R_out <<sel_disc_rkc(1,1)<<endl;
  R_out <<sel_disc_rkc(2,1)<<endl;
  R_out <<sel_disc_rkc(3,1)<<endl;  
  R_out << "$selectivity.redk.males"<< endl;
  R_out <<sel_disc_rkc(1,2)<<endl;
  R_out <<sel_disc_rkc(2,2)<<endl;
  R_out <<sel_disc_rkc(3,2)<<endl;  
  R_out << "$srv_sel_m"<<endl;
  R_out << sel_srv_m << endl;
  R_out << "$srv_sel_f"<<endl;
  R_out << sel_srv_f << endl;
  R_out.close();

// --------------------------------------------------------------------------
FUNCTION WriteMCMC
 post<<
 // srv_slope <<","<<
 // srv_sel50 <<","<<
  fish_slope_mn <<","<<
  fish_sel50_mn <<","<<
 // fish_fit_slope_mn <<","<<
 // fish_fit_sel50_mn <<","<<
  fish_disc_slope_f <<","<<
  fish_disc_sel50_f <<","<<
  //fish_disc_slope_tf <<","<<
  //fish_disc_sel50_tf <<","<<
  endl;

  */
// ===============================================================================
GLOBALS_SECTION
 #include <math.h>
 #include <fenv.h> // must appear before admodel.h
 #include <admodel.h>
  #include <time.h>
  ofstream R_out;
 #undef log_input
 #define log_input(object) CheckFile << "$"#object "\n" << object << endl;
 #undef Report
 #define Report(object) report << "$"#object "\n" << object << endl;
 #undef Cout
 #define Cout(object) cout << "$"#object "\n" << object << endl;
 #undef Couti
 #define Couti(object) cout << "$"#object " " << object << endl;
  ofstream CheckFile("Check.Out");
  adstring_array fshname;
  time_t start,finish;
  long hour,minute,second;
  double elapsed_time;
// ===============================================================================

RUNTIME_SECTION
 //one number for each phase, if more phases then uses the last number
  maximum_function_evaluations 500,1000,3000,3000,5000,5000,5000
  convergence_criteria 1,1,.01,.001,1e-5

TOP_OF_MAIN_SECTION
  arrmblsize = 3000000;
  gradient_structure::set_GRADSTACK_BUFFER_SIZE(4000000); // this may be incorrect in
  // the AUTODIF manual.
  gradient_structure::set_CMPDIF_BUFFER_SIZE(150000000);
  gradient_structure::set_NUM_DEPENDENT_VARIABLES(400);
  time(&start);
  R_out.open("R_results.rep");
  // feenableexcept(FE_DIVBYZERO); // to trap division by zero

FINAL_SECTION
 time(&finish); 
 elapsed_time = difftime(finish,start);
 hour = long(elapsed_time)/3600;
 minute = long(elapsed_time)%3600/60;
 second = (long(elapsed_time)%3600)%60;
 cout << endl << endl << "Starting time: " << ctime(&start);
 cout << "Finishing time: " << ctime(&finish);
 cout << "This run took: " << hour << " hours, " << minute << " minutes, " << second << " seconds." << endl << endl;



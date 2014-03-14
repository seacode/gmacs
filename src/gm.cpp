  #include <admodel.h>
  #include <time.h>
  #include <contrib.h>
  time_t start,finish;
  long hour,minute,second;
  double elapsed_time;
  // Define objects for report file, echoinput, etc.
  /**
  \def report(object)
  Prints name and value of \a object on ADMB report %ofstream file.
  */
  #undef REPORT
  #define REPORT(object) report << #object "\n" << object << endl;
  /**
  \def echo(object)
  Prints name and value of \a object on ADMB echoinput %ofstream file.
  */
  #define echo(object) echoinput << #object << "\n" << object << endl;
  #define echotxt(object,text) echoinput << object << "\t" << text << endl;
  /**
  \def check(object)
  Prints name and value of \a object on ADMB check %ofstream file.
  */
  #define check(object) checkfile << #object << "\n" << object << endl;
  // Open output files using ofstream
  ofstream echoinput("echoinput.gm");
  ofstream checkfile("checkfile.gm");
  ofstream warning("warning.gm");
  // Define some adstring variables for use in output files:
  adstring version;
  adstring version_short;
  
#include <admodel.h>
#include <contrib.h>

  extern "C"  {
    void ad_boundf(int i);
  }
#include <gm.htp>

model_data::model_data(int argc,char * argv[]) : ad_comm(argc,argv)
{
version+="Gmacs_V1.02_2014/01/02_by_Athol_Whitten_(UW)_using_ADMB_11.1";
version_short+="Gmacs V1.02";
 echoinput << version << endl;
 echoinput << ctime(&start) << endl;
 incc = 0.00001; ///< some constant for likelihoods
 incd = 0.0001;  ///< som other constant used
 ad_comm::change_datafile_name("starter.gm"); 
 cout << " Reading information from starter file" << endl;
 echoinput << " Start reading starter file" << endl;
  data_file.allocate("data_file");
  control_file.allocate("control_file");
  size_trans_file.allocate("size_trans_file");
 echotxt(data_file, "data file");
 echotxt(control_file, "control file");
  verbose.allocate("verbose");
  final_phase.allocate("final_phase");
  use_pin.allocate("use_pin");
  read_growth.allocate("read_growth");
 echotxt(verbose, " display detail");
 echotxt(final_phase, " final phase");
 echotxt(use_pin, " use parameter in file (*.pin)");
 echotxt(read_growth, " read growth transition matrix data file");
  eof_starter.allocate("eof_starter");
 if(eof_starter!=999) {cout << " Error reading starter file \n EOF = "<< eof_starter << endl; exit(1);}
 cout << " Finished reading starter file \n" << endl;
 echotxt(eof_starter," EOF: finished reading starter file \n");
 ad_comm::change_datafile_name(data_file);
 cout << " Reading main data file" << endl;
 echoinput << " Start reading main data file" << endl;
  styr.allocate("styr");
  endyr.allocate("endyr");
  tstep.allocate("tstep");
 echotxt(styr,  " Start year");
 echotxt(endyr, " End year");
 echotxt(tstep, " Time-step");
  nsex.allocate("nsex");
  nfleet.allocate("nfleet");
  nsurvey.allocate("nsurvey");
  nclass.allocate("nclass");
  ndclass.allocate("ndclass");
  class_link.allocate(1,nclass,1,2,"class_link");
 echotxt(nsex,    " Number of sexes");
 echotxt(nfleet,  " Number of fleets");
 echotxt(nsurvey, " Number of surveys")
 echotxt(nclass,  " Number of size classes");
 echotxt(ndclass, " Number of size classes for data");
 echo(class_link);
  catch_units.allocate(1,nfleet,"catch_units");
  catch_multi.allocate(1,nfleet,"catch_multi");
  survey_units.allocate(1,nsurvey,"survey_units");
  survey_multi.allocate(1,nsurvey,"survey_multi");
  ncatch_obs.allocate("ncatch_obs");
  nsurvey_obs.allocate("nsurvey_obs");
  survey_time.allocate("survey_time");
  fleet_control.allocate(1,nfleet,1,3,"fleet_control");
    nfleet_ret = 0;
    nfleet_dis = 0;
    nfleet_byc = 0;
    for (ifleet=1; ifleet<=nfleet; ifleet++)
    {
      switch (fleet_control(ifleet,2)) 
      {
        case 1 : 
          nfleet_ret += 1;
          break;
        case 2 : 
          nfleet_dis += 1;
          break;
        case 3 : 
          nfleet_byc += 1;
          break;
      } 
    } 
    nfleet_act = nfleet_ret + nfleet_byc;         ///< Determine number of active distinct fleets
  catch_data.allocate(1,ncatch_obs,1,5,"catch_data");
  catch_biom_obs.allocate(1,nfleet,styr,endyr);
  catch_num_obs.allocate(1,nfleet,styr,endyr);
  survey_data.allocate(1,nsurvey_obs,1,6,"survey_data");
  nobs_survey.allocate(1,nsurvey);
  // Fishery data
  catch_biom_obs.initialize();
  catch_num_obs.initialize();
  for (int i=1;i<=ncatch_obs;i++)
  {
    catch_biom_obs(catch_data(i,3),catch_data(i,1)) = catch_data(i,5);
    catch_num_obs(catch_data(i,3),catch_data(i,1))  = catch_data(i,5);
  }
  // survey data
  nobs_survey.initialize();
  for (i=1;i<=nsurvey_obs;i++)
  {
    nobs_survey(survey_data(i,3))++;
  }
  check(nobs_survey);
  yr_survey.allocate(1,nsurvey,1,nobs_survey);
  survey_biom_obs.allocate(1,nsurvey,1,nobs_survey);
  survey_num_obs.allocate(1,nsurvey,1,nobs_survey);
  survey_var.allocate(1,nsurvey,1,nobs_survey);
  survey_var.initialize();
  survey_biom_obs.initialize();
  survey_num_obs.initialize();
  ivector iobs_sv(1,nsurvey);                                  ///< Counter for number of obs within each survey
  iobs_sv.initialize();
  for (i=1;i<=nsurvey_obs;i++)
  {
    int isrv=survey_data(i,3);
    iobs_sv(isrv)++;
    yr_survey(isrv,iobs_sv(isrv)) = survey_data(i,1);
    if (survey_units(isrv)==1)
      survey_biom_obs(isrv,iobs_sv(isrv)) = survey_data(i,5);
    else 
      survey_num_obs(isrv,iobs_sv(isrv)) = survey_data(i,5);
    survey_var(isrv,iobs_sv(isrv)) = log(1+square(survey_data(i,6))); // for likelihood, compute input variance here ASSUMES CV input
  }
 echotxt(catch_units,  " Catch units");
 echotxt(catch_multi,  " Catch multipliers");
 echotxt(survey_units, " Survey units");
 echotxt(survey_multi, " Survey multipliers")
 echotxt(ncatch_obs,   " Number of lines of catch data");
 echotxt(nsurvey_obs,  " Number of lines of survey data")
 echotxt(survey_time,  " Time between survey and fishery");
 echo(catch_data);
 echo(survey_data);
  discard_mort.allocate(1,nfleet,"discard_mort");
  hg.allocate(styr,endyr,"hg");
  catch_time.allocate(1,nfleet_act,styr,endyr,"catch_time");
  effort.allocate(1,nfleet_act,styr,endyr,"effort");
  f_new.allocate(1,nfleet_act,1,5,"f_new");
 echo(discard_mort);
 echo(hg);
 echo(catch_time);
 echo(effort);
 echo(f_new);
  ncatch_f.allocate(1,nfleet_act);
  for (ifleet=1; ifleet<=nfleet_act; ifleet++)
  {
    ncatch_f(ifleet) = 0;
    for (iyr=styr; iyr<=endyr; iyr++) 
      if (effort(ifleet,iyr) > 0) 
      {
        if (f_new(ifleet,1) == 0 | iyr < f_new(ifleet,2) | iyr > f_new(ifleet,3))
          ncatch_f(ifleet) += 1;
      }
  }
 echotxt(ncatch_f, " Number of F's (calculated)")
  nlf_obs.allocate("nlf_obs");
  lf_data.allocate(1,nlf_obs,1,ndclass+7,"lf_data");
  nlf_fleet.allocate(1,nfleet);
  nlf_fleet.initialize();
  for (i=1; i<=nlf_obs; i++) 
  {
    nlf_fleet(int(lf_data(i,3)))++ ;
  }
  yr_fleet_lf.allocate(1,nfleet,1,nlf_fleet);
  ss_fleet_lf.allocate(1,nfleet,1,nlf_fleet);
  fleet_lf.allocate(1,nfleet,1,nlf_fleet,1,ndclass);
  fleet_lf_obs.allocate(1,nfleet,1,nlf_fleet,1,nclass);
  ivector iobs_fl(1,nfleet);                                ///< Counter for number of obs within each fleet
  iobs_fl.initialize();
  for (i=1; i<=nlf_obs; i++) 
  {
    ifleet = int(lf_data(i,3));
    iobs_fl(ifleet)++;
    yr_fleet_lf(ifleet,iobs_fl(ifleet)) = (lf_data(i,1));
    ss_fleet_lf(ifleet,iobs_fl(ifleet)) = lf_data(i,7);
    
    for (iclass=1; iclass<=nclass; iclass++)
      fleet_lf_obs(ifleet,iobs_fl(ifleet),iclass) = sum(lf_data(i)(7+class_link(iclass,1),7+class_link(iclass,2)));
      // FIX: fleet_lf(ifleet,iobs_fl(ifleet),iclass) = lf_data(i)(8,(ndclass+7)).shift(1);
  }
 echotxt(nlf_obs,  " Number of length freq lines to read");
 echo(lf_data);
 echo(nlf_fleet);
 echo(yr_fleet_lf);
 echo(ss_fleet_lf);
 echo(fleet_lf_obs);
  nlfs_obs.allocate("nlfs_obs");
  lfs_data.allocate(1,nlfs_obs,1,ndclass+5,"lfs_data");
  nlf_survey.allocate(1,nsurvey);
  nlf_survey.initialize();
  for (i=1; i<=nlfs_obs; i++) 
  {
    nlf_survey(int(lfs_data(i,3)))++ ;
  }
  yr_survey_lf.allocate(1,nsurvey,1,nlf_survey);
  ss_survey_lf.allocate(1,nsurvey,1,nlf_survey);
  survey_lf.allocate(1,nsurvey,1,nlf_survey,1,ndclass);
  survey_lf_obs.allocate(1,nsurvey,1,nlf_survey,1,nclass);
  iobs_sv.initialize();
  for (i=1; i<=nlfs_obs; i++) 
  {
    isurvey = int(lfs_data(i,3));
    iobs_sv(isurvey)++;
    yr_survey_lf(isurvey,iobs_sv(isurvey)) = (lfs_data(i,1));
    ss_survey_lf(isurvey,iobs_sv(isurvey)) = lfs_data(i,5);
    for (iclass=1; iclass<=nclass; iclass++)
    {
      survey_lf_obs(isurvey,iobs_sv(isurvey),iclass) = sum(lfs_data(i)(5+class_link(iclass,1),5+class_link(iclass,2)));
    }
    survey_lf(isurvey,iobs_sv(isurvey)) = lfs_data(i)(6,(ndclass+5)).shift(1);
  }
 echotxt(nlfs_obs, " Number of survey length freq lines to read");
 echo(lfs_data);
 echo(nlf_survey);
 echo(yr_survey_lf);
 echo(ss_survey_lf);
 echo(survey_lf_obs);
  mean_length.allocate(1,ndclass,"mean_length");
  mean_weight.allocate(1,ndclass,"mean_weight");
  fecundity_inp.allocate(1,ndclass,"fecundity_inp");
 echo(mean_length);
 echo(mean_weight);
 echo(fecundity);
  length.allocate(1,nclass);
  weight.allocate(1,nclass);
  fecundity.allocate(1,nclass);
  surv_lf_store.allocate(1,ndclass);
 checkfile << "Class length, weight, and fecundity" << endl;
  int total;
  total = 0;
  for (iclass=1; iclass<=ndclass; iclass++)
  {
    surv_lf_store(iclass) = 0;
    for (iyr=1; iyr<=nlfs_obs; iyr++) surv_lf_store(iclass) += survey_lf(1,iyr,iclass);
    total += surv_lf_store(iclass);
  }
  if (verbose == 1) cout << "Survey sample sizes stored" << endl; // CHECK: WTF? Not storing sample sizes.
  for (iclass=1; iclass<=nclass; iclass++)
  {
    length(iclass) = 0; 
    weight(iclass) = 0; 
    fecundity(iclass) = 0; 
    total = 0;
    for (jclass=class_link(iclass,1); jclass<=class_link(iclass,2); jclass++)
    {
      length(iclass) += mean_length(jclass)*surv_lf_store(jclass);
      weight(iclass) += mean_weight(jclass)*surv_lf_store(jclass);
      fecundity(iclass) += fecundity_inp(jclass)*surv_lf_store(jclass);
      total += surv_lf_store(jclass);
    }
    length(iclass) /= total;
    weight(iclass) /= total;
    fecundity(iclass) /= total;
    checkfile << iclass << " " << length(iclass) << " " << weight(iclass) << " " << fecundity(iclass) << endl;
  }
  if (verbose == 1) cout << " Lengths, weights, and fecundity specified" << endl;
  ncapture_obs.allocate("ncapture_obs");
  nmark_obs.allocate("nmark_obs");
  nrecapture_obs.allocate("nrecapture_obs");
  capture_data.allocate(1,ncapture_obs,1,ndclass+3,"capture_data");
  mark_data.allocate(1,nmark_obs,1,ndclass+3,"mark_data");
  recapture_data.allocate(1,nrecapture_obs,1,ndclass+3,"recapture_data");
 echotxt(ncapture_obs,   " Number of capture data lines");
 echotxt(nmark_obs,      " Number of mark data lines");
 echotxt(nrecapture_obs, " Number of recapture data lines")
  if(ncapture_obs > 0) 
  {
    echo(capture_data);
    echo(mark_data);
    echo(recapture_data);
  }
  eof_data.allocate("eof_data");
 if(eof_data!=999) {cout << " Error reading main data file \n EOF = "<< eof_data << endl; exit(1);}
 cout << " Finished reading main data file \n" << endl;
 echotxt(eof_data," EOF: finished reading main data file \n");
 ndclass_growth = 0;
  if(read_growth==1)
  {  
    // Open size transition file (*.dat) //
    ad_comm::change_datafile_name(size_trans_file);
    cout << " Reading size transition file" << endl;
    echoinput << " Start reading size transition file" << endl;
    // Read input from growth data file:
    *(ad_comm::global_datafile) >> styr_growth;
    *(ad_comm::global_datafile) >> endyr_growth;
    *(ad_comm::global_datafile) >> ndclass_growth;
    echotxt(styr_growth, " Start year for growth data");
    echotxt(endyr_growth, " End year for growth data");
    echotxt(ndclass_growth, " Number of growth data classes");
  }
  growth_bins.allocate(1,ndclass_growth);
  growth_data.allocate(styr_growth,endyr_growth,1,ndclass_growth-1,1,ndclass_growth-1);
  if(read_growth==1)
  {  
    *(ad_comm::global_datafile) >> growth_bins;
    *(ad_comm::global_datafile) >> growth_data;
    echo(growth_bins);
    echo(growth_data);
    *(ad_comm::global_datafile) >> eof_growth;
    
    // Print EOF confirmation to screen and echoinput, warn otherwise:
    if(eof_growth!=999) {cout << " Error reading size transition file\n EOF = " << eof_growth << endl; exit(1);}
    cout << " Finished reading size transition file \n" << endl;
    echotxt(eof_growth," EOF: finished reading size transition file \n");
  }
 ad_comm::change_datafile_name(control_file);
 cout << " Reading control file" << endl;
 echoinput << " Start reading control file" << endl;
 ntheta = 2;
  theta_control.allocate(1,ntheta,1,13,"theta_control");
  trans_theta_control.allocate(1,13,1,ntheta);
  theta_init.allocate(1,ntheta);
  theta_lbnd.allocate(1,ntheta);
  theta_ubnd.allocate(1,ntheta);
  theta_phz.allocate(1,ntheta);
  theta_prior.allocate(1,ntheta);
  theta_pmean.allocate(1,ntheta);
  theta_psd.allocate(1,ntheta);
  theta_cov.allocate(1,ntheta);
  theta_dev.allocate(1,ntheta);
  theta_dsd.allocate(1,ntheta);
  theta_dmin.allocate(1,ntheta);
  theta_dmax.allocate(1,ntheta);
  theta_blk.allocate(1,ntheta);
 echo(theta_control);
    trans_theta_control = trans(theta_control);
    theta_init          = trans_theta_control(1);
    theta_lbnd          = trans_theta_control(2);
    theta_ubnd          = trans_theta_control(3);
    theta_phz           = ivector(trans_theta_control(4));
    theta_prior         = ivector(trans_theta_control(5));
    theta_pmean         = trans_theta_control(6);
    theta_psd           = trans_theta_control(7);
    theta_cov           = ivector(trans_theta_control(8));
    theta_dev           = ivector(trans_theta_control(9));
    theta_dsd           = trans_theta_control(10);
    theta_dmin          = ivector(trans_theta_control(11));
    theta_dmax          = ivector(trans_theta_control(12));
    theta_blk           = ivector(trans_theta_control(13));
  sr_lag.allocate("sr_lag");
  sr_type.allocate("sr_type");
 echotxt(sr_lag, " Lag to recruitment (years)");
 echotxt(sr_type, " Form of stock-recruitment relationship");
  M_pnt.allocate(styr,endyr,"M_pnt");
 nMadd_parms = max(M_pnt);                   
 echo(M_pnt);
 echotxt(nMadd_parms, " Number of additional natural mortality parameters");
  madd_control.allocate(1,nMadd_parms,1,4,"madd_control");
  trans_madd_control.allocate(1,4,1,nMadd_parms);
  madd_init.allocate(1,nMadd_parms);
  madd_lbnd.allocate(1,nMadd_parms);
  madd_ubnd.allocate(1,nMadd_parms);
  madd_phz.allocate(1,nMadd_parms);
 echo(madd_control);
    trans_madd_control = trans(madd_control);
    madd_init = trans_madd_control(1);
    madd_lbnd = trans_madd_control(2);
    madd_ubnd = trans_madd_control(3);
    madd_phz = ivector(trans_madd_control(4));
  selex_fleet_pnt.allocate(1,nfleet_act,styr,endyr,"selex_fleet_pnt");
  selex_survey_pnt.allocate(1,nsurvey,styr,endyr+1,"selex_survey_pnt");
 echo(selex_fleet_pnt);
 echo(selex_survey_pnt);
 nselex_pats = max(selex_survey_pnt);
 echotxt(nselex_pats, " Total number of selectivity patterns");
  selex_type.allocate(1,nselex_pats,1,4);
  nselex = 0;
  for (i=1; i<=nselex_pats; i++)
  {
    *(ad_comm::global_datafile) >> selex_type(i,1) >> selex_type(i,2) >> selex_type(i,3);
    if (selex_type(i,2) == 1) nselex += 2;
    if (selex_type(i,2) == 2) nselex += nclass;
    if (selex_type(i,2) == 3) nselex += 1;
  }
  nselex_pars = nselex;
  echo(selex_type);
  echotxt(nselex_pars, " Total number of selectivity parameters");
  // Fill last column of selex_type matrix, for use in Set_selex function.
  i = 0;
  for (j=1; j<=nselex_pats; j++)
   {
    selex_type(j,4) = i;
    if (selex_type(j,2)==1) last = 2;
    if (selex_type(j,2)==2) last = nclass;
    if (selex_type(j,2)==3) last = 1;
    i += last;
   }
  check(selex_type);
  selex_control.allocate(1,nselex_pars,1,4,"selex_control");
  trans_selex_control.allocate(1,4,1,nselex_pars);
  selex_init.allocate(1,nselex_pars);
  selex_lbnd.allocate(1,nselex_pars);
  selex_ubnd.allocate(1,nselex_pars);
  selex_phz.allocate(1,nselex_pars);
 echo(selex_control);
    trans_selex_control = trans(selex_control);
    selex_init = trans_selex_control(1);
    selex_lbnd = trans_selex_control(2);
    selex_ubnd = trans_selex_control(3);
    selex_phz = ivector(trans_selex_control(4));
  reten_fleet_pnt.allocate(1,nfleet_ret,styr,endyr,"reten_fleet_pnt");
 nreten_pars = reten_fleet_pnt.indexmax();
 nreten_pars *= nclass;
 echotxt(nreten_pars, " Total number of retention parameters");
  reten_control.allocate(1,nreten_pars,1,4,"reten_control");
  trans_reten_control.allocate(1,4,1,nreten_pars);
  reten_init.allocate(1,nreten_pars);
  reten_lbnd.allocate(1,nreten_pars);
  reten_ubnd.allocate(1,nreten_pars);
  reten_phz.allocate(1,nreten_pars);
 echo(reten_control);
  trans_reten_control = trans(reten_control);
  reten_init = trans_reten_control(1);
  reten_lbnd = trans_reten_control(2);
  reten_ubnd = trans_reten_control(3);
  reten_phz = ivector(trans_reten_control(4));
  surveyq_pnt.allocate(1,nsurvey,styr,endyr+1,"surveyq_pnt");
 nsurveyq_pars = max(surveyq_pnt);
 echo(surveyq_pnt);
 echotxt(nsurveyq_pars, " Total number of survey Q patterns");
  nsubsurvey.allocate("nsubsurvey");
  subsurvey.allocate(1,nsubsurvey,1,2,"subsurvey");
 echotxt(nsubsurvey, " Number of sub-surveys");
 if(nsubsurvey > 0) echo(subsurvey);
  surveyq_control.allocate(1,nsurveyq_pars,1,7,"surveyq_control");
  trans_surveyq_control.allocate(1,7,1,nsurveyq_pars);
  surveyq_init.allocate(1,nsurveyq_pars);
  surveyq_lbnd.allocate(1,nsurveyq_pars);
  surveyq_ubnd.allocate(1,nsurveyq_pars);
  surveyq_phz.allocate(1,nsurveyq_pars);
  surveyq_prior.allocate(1,nsurveyq_pars);
  surveyq_pmean.allocate(1,nsurveyq_pars);
  surveyq_psd.allocate(1,nsurveyq_pars);
 echo(surveyq_control);
    trans_surveyq_control = trans(surveyq_control);
    surveyq_init          = trans_surveyq_control(1);
    surveyq_lbnd          = trans_surveyq_control(2);
    surveyq_ubnd          = trans_surveyq_control(3);
    surveyq_phz           = ivector(trans_surveyq_control(4));
    surveyq_prior         = ivector(trans_surveyq_control(5));
    surveyq_pmean         = trans_surveyq_control(6);
    surveyq_psd           = trans_surveyq_control(7);  
  lognin_control.allocate(1,nclass,1,4,"lognin_control");
  trans_lognin_control.allocate(1,4,1,nclass);
  lognin_init.allocate(1,nclass);
  lognin_lbnd.allocate(1,nclass);
  lognin_ubnd.allocate(1,nclass);
  lognin_phz.allocate(1,nclass);
 echo(lognin_control);
    trans_lognin_control = trans(lognin_control);
    lognin_init          = trans_lognin_control(1);
    lognin_lbnd          = trans_lognin_control(2);
    lognin_ubnd          = trans_lognin_control(3);
    lognin_phz           = ivector(trans_lognin_control(4));  
  gtrans_control.allocate(1,nclass-1,1,4,"gtrans_control");
  trans_gtrans_control.allocate(1,4,1,nclass-1);
  gtrans_init.allocate(1,nclass-1);
  gtrans_lbnd.allocate(1,nclass-1);
  gtrans_ubnd.allocate(1,nclass-1);
  gtrans_phz.allocate(1,nclass-1);
 echo(gtrans_control);
    trans_gtrans_control = trans(gtrans_control);
    gtrans_init = trans_gtrans_control(1);
    gtrans_lbnd = trans_gtrans_control(2);
    gtrans_ubnd = trans_gtrans_control(3);
    gtrans_phz = ivector(trans_gtrans_control(4));  
 nprior_terms = (nfleet_act) + 1 + nfleet + nsurveyq_pars + 1 + 1;  
 nlike_terms = (nfleet)*2+ (nfleet_act) + (nsurvey)*2;
 echotxt(nprior_terms, " Number of prior terms");
 echotxt(nlike_terms, " Number of likelihood terms");
  prior_weight.allocate(1,nprior_terms,"prior_weight");
  data_weight.allocate(1,nlike_terms,"data_weight");
 echo(prior_weight);
 echo(data_weight);
  eof_control.allocate("eof_control");
 if(eof_control!=999) {cout << " Error reading control file\n EOF = " << eof_control << endl; exit(1);}
 cout << " Finished reading control file \n" << endl;
 echotxt(eof_data," EOF: finished reading control file \n");
 ad_comm::change_datafile_name("forecast.gm");
 cout << " Reading forecast file" << endl;
 echoinput << " Start reading forecast file" << endl;
  bmsy_start.allocate("bmsy_start");
  bmsy_end.allocate("bmsy_end");
 echotxt(bmsy_start, " BMSY start year");
 echotxt(bmsy_end, " BMSY end year");
  eof_forecast.allocate("eof_forecast");
 if(eof_forecast!=999) {cout << " Error reading forecast file\n EOF = " << eof_forecast << endl; exit(1);}
 cout << " Finished reading forecast file \n" << endl;
 echotxt(eof_data," EOF: finished reading forecast file \n");
 cout << " Successfully read all input files. \n" << endl;
  active_parm.allocate(0,ntheta);
 dummy_datum = 1;
 if(final_phase<=0) {dummy_phase=0;} else {dummy_phase=-6;}
  cout << " Count parameters and get max phase, adjust phases if required" << endl;
  max_phase=1;
  active_count=0;
  par_count=0;
  active_parm(0,ntheta)=0;
    
  for(i=1; i<=ntheta; i++)
  { 
    par_count++;
    if(theta_phz(i) > final_phase) theta_phz(i)=-1;
    if(theta_phz(i) > max_phase) max_phase=theta_phz(i);
    if(theta_phz(i) >= 0)
      active_count++; active_parm(active_count)=par_count;
  }
  active_parms=active_count;
 cout << " Number of active parameters is " << active_parms << endl;
 cout << " Maximum phase for estimation is " << max_phase << "\n" << endl;
 check (theta_phz);
 check (ntheta);
 check (par_count); 
 check (active_parm);
 check (active_parms);
}

model_parameters::model_parameters(int sz,int argc,char * argv[]) : 
 model_data(argc,argv) , function_minimizer(sz)
{
  initializationfunction();
  dummy_parm.allocate(0,2,dummy_phase,"dummy_parm");
 check(dummy_parm);
  theta_parms.allocate(1,ntheta,theta_lbnd,theta_ubnd,theta_phz,"theta_parms");
  logRbar.allocate("logRbar");
  #ifndef NO_AD_INITIALIZE
  logRbar.initialize();
  #endif
  M0.allocate("M0");
  #ifndef NO_AD_INITIALIZE
  M0.initialize();
  #endif
 check(theta_parms);
  Madd_parms.allocate(1,nMadd_parms,madd_lbnd,madd_ubnd,madd_phz,"Madd_parms");
  gtrans_parms.allocate(1,nclass-1,gtrans_lbnd,gtrans_ubnd,gtrans_phz,"gtrans_parms");
  selex_parms.allocate(1,nselex_pars,selex_lbnd,selex_ubnd,selex_phz,"selex_parms");
  reten_parms.allocate(1,nreten_pars,reten_lbnd,reten_ubnd,reten_phz,"reten_parms");
  surveyq_parms.allocate(1,nsurveyq_pars,surveyq_lbnd,surveyq_ubnd,surveyq_phz,"surveyq_parms");
  lognin_parms.allocate(1,nclass,lognin_lbnd,lognin_ubnd,lognin_phz,"lognin_parms");
 check(Madd_parms);
 check(gtrans_parms);
 check(selex_parms);
 check(reten_parms);
 check(surveyq_parms);
 check(lognin_parms);
 check(ncatch_f);
  f_est.allocate(1,nfleet_act,1,ncatch_f,0,1,1,"f_est");
  recdev.allocate(styr,endyr,1,"recdev");
 cout << " All parameters declared \n" << endl;
 checkfile << " All parameters declared" << endl;
  f_all.allocate(1,nfleet_act,styr,endyr,"f_all");
  #ifndef NO_AD_INITIALIZE
    f_all.initialize();
  #endif
  N.allocate(styr,endyr+1,1,nclass,"N");
  #ifndef NO_AD_INITIALIZE
    N.initialize();
  #endif
  S.allocate(styr,endyr,1,nclass,"S");
  #ifndef NO_AD_INITIALIZE
    S.initialize();
  #endif
  S_fleet.allocate(1,nfleet_act,styr,endyr,1,nclass,"S_fleet");
  #ifndef NO_AD_INITIALIZE
    S_fleet.initialize();
  #endif
  exp_rate.allocate(1,nfleet,styr,endyr,"exp_rate");
  #ifndef NO_AD_INITIALIZE
    exp_rate.initialize();
  #endif
  strans.allocate(1,nclass,1,nclass,"strans");
  #ifndef NO_AD_INITIALIZE
    strans.initialize();
  #endif
  reten.allocate(styr,endyr,1,nclass,"reten");
  #ifndef NO_AD_INITIALIZE
    reten.initialize();
  #endif
  selex_fleet.allocate(1,nfleet_act,styr,endyr,1,nclass,"selex_fleet");
  #ifndef NO_AD_INITIALIZE
    selex_fleet.initialize();
  #endif
  selex_survey.allocate(1,nsurvey,styr,endyr+1,1,nclass,"selex_survey");
  #ifndef NO_AD_INITIALIZE
    selex_survey.initialize();
  #endif
  surveyq.allocate(1,nsurvey,"surveyq");
  #ifndef NO_AD_INITIALIZE
    surveyq.initialize();
  #endif
  selex_all.allocate(1,nselex_pats,1,nclass,"selex_all");
  #ifndef NO_AD_INITIALIZE
    selex_all.initialize();
  #endif
  fleet_lf_pred.allocate(1,nfleet,1,nlf_fleet,1,nclass,"fleet_lf_pred");
  #ifndef NO_AD_INITIALIZE
    fleet_lf_pred.initialize();
  #endif
  catch_biom_pred.allocate(1,nfleet,styr,endyr,"catch_biom_pred");
  #ifndef NO_AD_INITIALIZE
    catch_biom_pred.initialize();
  #endif
  catch_num_pred.allocate(1,nfleet,styr,endyr,"catch_num_pred");
  #ifndef NO_AD_INITIALIZE
    catch_num_pred.initialize();
  #endif
  survey_lf_pred.allocate(1,nsurvey,1,nlf_survey,1,nclass,"survey_lf_pred");
  #ifndef NO_AD_INITIALIZE
    survey_lf_pred.initialize();
  #endif
  survey_biom_pred.allocate(1,nsurvey,1,nobs_survey,"survey_biom_pred");
  #ifndef NO_AD_INITIALIZE
    survey_biom_pred.initialize();
  #endif
  survey_num_pred.allocate(1,nsurvey,1,nobs_survey,"survey_num_pred");
  #ifndef NO_AD_INITIALIZE
    survey_num_pred.initialize();
  #endif
  q_effort.allocate(1,nfleet_act,"q_effort");
  #ifndef NO_AD_INITIALIZE
    q_effort.initialize();
  #endif
  M.allocate(styr,endyr,"M");
  #ifndef NO_AD_INITIALIZE
    M.initialize();
  #endif
  f_direct.allocate(styr,endyr,"f_direct");
  #ifndef NO_AD_INITIALIZE
    f_direct.initialize();
  #endif
  prior_val.allocate(1,nprior_terms,"prior_val");
  #ifndef NO_AD_INITIALIZE
    prior_val.initialize();
  #endif
  like_val.allocate(1,nlike_terms,"like_val");
  #ifndef NO_AD_INITIALIZE
    like_val.initialize();
  #endif
  fobj.allocate("fobj");
  prior_function_value.allocate("prior_function_value");
  likelihood_function_value.allocate("likelihood_function_value");
  f_multi.allocate("f_multi");
  #ifndef NO_AD_INITIALIZE
  f_multi.initialize();
  #endif
  mbio_out.allocate("mbio_out");
  #ifndef NO_AD_INITIALIZE
  mbio_out.initialize();
  #endif
  f_35.allocate("f_35");
  #ifndef NO_AD_INITIALIZE
  f_35.initialize();
  #endif
  sbpr_35.allocate("sbpr_35");
  #ifndef NO_AD_INITIALIZE
  sbpr_35.initialize();
  #endif
  rec_out.allocate("rec_out");
  #ifndef NO_AD_INITIALIZE
  rec_out.initialize();
  #endif
  catch_out.allocate("catch_out");
  #ifndef NO_AD_INITIALIZE
  catch_out.initialize();
  #endif
  mbio_proj.allocate(1,1000,"mbio_proj");
  #ifndef NO_AD_INITIALIZE
    mbio_proj.initialize();
  #endif
  f_mort.allocate(1,nfleet_byc,"f_mort");
  #ifndef NO_AD_INITIALIZE
    f_mort.initialize();
  #endif
  rec_zero.allocate("rec_zero");
  #ifndef NO_AD_INITIALIZE
  rec_zero.initialize();
  #endif
  steep.allocate("steep");
  #ifndef NO_AD_INITIALIZE
  steep.initialize();
  #endif
  mbio_zero.allocate("mbio_zero");
  #ifndef NO_AD_INITIALIZE
  mbio_zero.initialize();
  #endif
  mbio.allocate(styr,endyr,"mbio");
  #ifndef NO_AD_INITIALIZE
    mbio.initialize();
  #endif
  logmbio.allocate(styr,endyr,"logmbio");
  recruits.allocate(styr,endyr,"recruits");
  #ifndef NO_AD_INITIALIZE
    recruits.initialize();
  #endif
  logrecruits.allocate(styr,endyr,"logrecruits");
  logrecmbio.allocate(styr,endyr-sr_lag,"logrecmbio");
}

void model_parameters::preliminary_calculations(void)
{

#if defined(USE_ADPVM)

  admaster_slave_variable_interface(*this);

#endif
  // Initialize the dummy parameter as needed:
  if(final_phase<=0) {dummy_parm=0.5;} else {dummy_parm=1.0;}
  // Set the initial values of parameters:
  int j;
  for (j=1; j<=ntheta; j++) theta_parms(j) = theta_init(j);
  for (j=1; j<=nMadd_parms; j++) Madd_parms(j) = madd_init(j);  
  for (j=1; j<=nclass-1; j++) gtrans_parms(j) = gtrans_init(j);
  for (j=1; j<=nselex_pars; j++) selex_parms(j) = selex_init(j);
  for (j=1; j<=nreten_pars; j++) reten_parms(j) = reten_init(j);
  for (j=1; j<=nsurveyq_pars; j++) surveyq_parms(j) = surveyq_init(j);
  for (j=1; j<=nclass; j++) lognin_parms(j) = lognin_init(j);
    
  for (ifleet=1; ifleet<=nfleet_act; ifleet++)
    for (iyr=1; iyr<=ncatch_f(ifleet); iyr++) f_est(ifleet,iyr) = 0.1;
  recdev.initialize();
  logRbar = theta_parms(1);
  M0 = theta_parms(2);
}

void model_parameters::userfunction(void)
{
  fobj =0.0;
  pad();
  fobj += square(dummy_datum-dummy_parm);
  Set_effort();
  Set_growth();
  Initial_size_structure();
  Set_selectivity();
  Set_survival();
  Update_population(); 
  ObjFunction();
}

void model_parameters::Set_effort(void)
{
  // Convert to Fs
  int count, ifleet, iyear;
  dvariable ratio, ratio_2, delta;
  for (ifleet=1; ifleet<=nfleet_act; ifleet++)
  {
    count = 0;
    for (iyear=styr; iyear<=endyr; iyear++)
    {
      if (effort(ifleet,iyear) > 0)
      {
        if (f_new(ifleet,1) == 0 | iyear < f_new(ifleet,2) | iyear > f_new(ifleet,3))
          { count += 1; f_all(ifleet,iyear) = f_est(ifleet,count); }
        else
         f_all(ifleet,iyear) = -100;
      }  
      else
        f_all(ifleet,iyear) = 0;
    }
  }  
  // Fill in missing values using a ratio estimator:
  for (ifleet=1; ifleet<=nfleet_act; ifleet++)
    if (f_new(ifleet,1) > 0)
    {
     ratio = 0; ratio_2 = 0;
     for (iyear=f_new(ifleet,4); iyear<=f_new(ifleet,5); iyear++)
     {
       if (effort(ifleet,iyear) > 0)
       {
        ratio += -log(1.0-f_all(ifleet,iyear))/effort(ifleet,iyear);
        ratio_2 += 1;
       }
     }
     delta = ratio/ratio_2;
     for (iyear=f_new(ifleet,2); iyear<=f_new(ifleet,3); iyear++)
       f_all(ifleet,iyear) = 1.0-mfexp(-delta*effort(ifleet,iyear));
    }
}

void model_parameters::Set_growth(void)
{
  int iclass, jclass;
  dvariable total;
  strans.initialize();
  for (iclass=1; iclass<nclass; iclass++)
  {
    total = (1+mfexp(gtrans_parms(iclass)));
    strans(iclass,iclass) = 1/total;
    strans(iclass,iclass+1) = mfexp(gtrans_parms(iclass))/total;
  }
  strans(nclass,nclass) = 1;  // Special case for final diagonal entry.
}

void model_parameters::Initial_size_structure(void)
{
  int iclass;
  N.initialize();
  for (iclass=1;iclass<=nclass;iclass++)
    N(styr,iclass) = mfexp(logRbar)*mfexp(lognin_parms(iclass));
}

void model_parameters::Set_selectivity(void)
{
  int iclass, iyr, isurv, ifleet, ipnt, jpnt;
  dvariable qq, temp, slope_par;
  // Produce all selectivities:
  // TODO: Check the ipnt pointer is correct here; inherits 0 from selex_type for fleet 1, could be made to be 1 if required in selex_type setup.
  for (ifleet=1; ifleet<=nselex_pats; ifleet++)
  {
    ipnt = selex_type(ifleet,4);
    if (selex_type(ifleet,2) == 1)
    {
      slope_par = selex_parms(ipnt+2);
      temp = -log(19.0)/slope_par;
      for (iclass=1; iclass<=nclass; iclass++)
       selex_all(ifleet,iclass) = 1.0/(1.0+mfexp(temp*(length(iclass)-selex_parms(ipnt+1))));
      temp =  selex_all(ifleet,nclass);
      for (iclass=1;iclass<=nclass;iclass++) selex_all(ifleet,iclass) /= temp;
    }
    if (selex_type(ifleet,2) == 2)
    {
      for (iclass=1; iclass<=nclass; iclass++)
        selex_all(ifleet,iclass) = 1.0/(1.0+mfexp(selex_parms(ipnt+iclass)));
      temp =  selex_all(ifleet,nclass);
      for (iclass=1; iclass<=nclass; iclass++) selex_all(ifleet,iclass) /= temp;
    }
    if (selex_type(ifleet,2) == 3)
    {
      jpnt = selex_type(selex_type(ifleet,2),4);
      slope_par = selex_parms(jpnt+2);
      temp = -log(19.0)/slope_par;
      for (iclass=1; iclass<=nclass; iclass++)
        selex_all(ifleet,iclass) = 1.0/(1.0+mfexp(temp*(length(iclass)-selex_parms(ipnt+1))));
      temp =  selex_all(ifleet,nclass);
      for (iclass=1; iclass<=nclass; iclass++) selex_all(ifleet,iclass) /= temp;
    }
  } 
  // Fishery and bycatch selectivity
  for (ifleet=1; ifleet<=nfleet_act; ifleet++)
   for (iyr=styr; iyr<=endyr; iyr++)
    {
     ipnt = selex_fleet_pnt(ifleet,iyr);
     for (iclass=1; iclass<=nclass; iclass++)
       selex_fleet(ifleet,iyr,iclass) = selex_all(ipnt,iclass) ;
    }  
  // Retention in the pot fishery
  for (ifleet=1; ifleet<=nfleet_ret; ifleet++)
    for (iyr=styr; iyr<=endyr; iyr++)
      for (iclass=1; iclass<=nclass; iclass++)
      {
        ipnt = (reten_fleet_pnt(ifleet,iyr)-1)*nclass;
        reten(iyr,iclass) = (1-hg(iyr))/(1.0+mfexp(reten_parms(ipnt+iclass)));
      } 
  // Survey selectivity
  for (isurv=1; isurv<=nsurvey; isurv++)
   for (iyr=styr; iyr<=endyr+1; iyr++)
    {
     ipnt = surveyq_pnt(isurv,iyr);
     qq = exp(surveyq_parms(ipnt));
     ipnt = selex_survey_pnt(isurv,iyr);
     for (iclass=1; iclass<=nclass; iclass++)
      selex_survey(isurv,iyr,iclass) = qq*selex_all(ipnt,iclass);
    }  
  // Nest one survey within another
  for (ipnt=1; ipnt<=nsubsurvey; ipnt++)
   for (iyr=styr; iyr<=endyr+1; iyr++)
    for (iclass=1; iclass<=nclass; iclass++)
     selex_survey(subsurvey(ipnt,1),iyr,iclass) *= selex_survey(subsurvey(ipnt,2),iyr,iclass);
}

void model_parameters::Set_survival(void)
{
  int iyr,iclass,ifleet;
  // Check which fleets this applies to...  
  // Specify natural mortality:
  M = M0;
  for (iyr=styr; iyr<=endyr; iyr++) if (M_pnt(iyr)>1) M(iyr) += Madd_parms(M_pnt(iyr)); 
  for (iyr=styr; iyr<=endyr; iyr++)
    for (iclass=1; iclass<=nclass; iclass++)
    {
     S(iyr,iclass) = mfexp(-M(iyr));
     for (ifleet=1; ifleet<=nfleet_act; ifleet++)
      {
       S_fleet(ifleet,iyr,iclass) = (1-selex_fleet(ifleet,iyr,iclass)*f_all(ifleet,iyr));
       exp_rate(ifleet,iyr) = f_all(ifleet,iyr);
       S(iyr,iclass) *= S_fleet(ifleet,iyr,iclass);
      } 
     f_direct(iyr) = selex_fleet(1,iyr,nclass)*f_all(1,iyr); // FIX: This may have to loop over fleet as well?
    }
}

void model_parameters::Update_population(void)
{
  int iyr, iclass, jclass;
  dvariable mbio_out;
  for (iyr=styr; iyr<=endyr; iyr++)
  {
    // Grow individuals for one time-step:
    for (iclass=1; iclass<=nclass; iclass++)
      for (jclass=1; jclass<=nclass; jclass++)
        N(iyr+1,iclass) += strans(jclass,iclass)*N(iyr,jclass)*S(iyr,jclass);
    // Add recruitment for next year:
    recruits(iyr) = mfexp(logRbar+recdev(iyr));
    N(iyr+1,1) += recruits(iyr);
    mbio_out = 0;
    for (iclass=1; iclass<=nclass; iclass++) 
      mbio_out += N(iyr,iclass)*fecundity(iclass)*(1-selex_fleet(1,iyr,iclass)*f_all(1,iyr))*exp(-(catch_time(1,iyr)+2/12)*M(iyr));
    mbio(iyr) = mbio_out;
   }
   // TODO: Check why only selex_fleet(1) is used for mbio_calc.
   // TODO: Check 2/12 here in mbio calculation, is this a timing fraction that needs to be generalised?
}

void model_parameters::ObjFunction(void)
{
  prior_val.initialize(); 
  like_val.initialize();
  Get_Likes();
  // Get_Priors();
  fobj = sum(like_val) ; // + sum(prior_val);
 cout << prior_val << endl;
 cout << like_val << endl;  
}

void model_parameters::Get_Likes(void)
{
  int ilike=0;
  // Likelihood for Catch biomass (or number)-----------------------
  // This could be re-written withoutiff statement
  for (int ifl=1;ifl<=nfleet;ifl++)
  {
    ilike++; ///< Increment the likelihood index
    if(catch_units(ifl) == 1)
      like_val(ilike) += norm2(log((catch_biom_pred(ifl)+incd)-log(catch_biom_obs(ifl)+incd)));
    else
      like_val(ilike) += norm2(log((catch_num_pred(ifl)+incd)-log(catch_num_obs(ifl)+incd)));
  }
  // Catch LFs-----------------------
  for (ifl=1;ifl<=nfleet;ifl++)
  {
    ilike++; ///< Increment the likelihood index
    for (int i=1;i<=nlf_fleet(ifl);i++)
    {
      dvar_vector phat = fleet_lf_pred(ifl,i)/sum(fleet_lf_pred(ifl,i));
      dvector pobs     = fleet_lf_obs(ifl,i)/sum(fleet_lf_obs(ifl,i)); // this should probably be done once in beginning
      // Andre's version waste time w/ constants
      //dvariable Error  = elem_div((phat+Incc),(pobs+Incc));
      // like_val(ilike)  += -ss_fleet_lf(ifl,i)*pobs*log(Error);
      // ignores constant, vector x vector returns a scalar
      like_val(ilike)  += -ss_fleet_lf(ifl,i)*pobs*log(phat);
    } 
  } 
  // Effort indices-----------------------
  /*
  q_effort.initialize();
  for (ifl=1;ifl<=nfleet;ifl++)
  {
    ilike++; ///< Increment the likelihood index
    double nn= 0;
    // TODO: figure out how effort is used
    for (iyr=Yr1;iyr<=endyr;iyr++)
      if (Effort(Ifleet,iyr) > 0) 
      {
        if (FOverWrite(Ifleet,0) == 0 |iyr<FOverWrite(Ifleet,1) | iyr>FOverWrite(Ifleet,2))
        { 
          nn++ ; 
          qEff(Ifleet) += log((Effort(Ifleet,iyr)+Incd)/(ExplRates(Ifleet,iyr)+Incd)); 
        }
      }  
    qEff(Ifleet) = mfexp(qEff(Ifleet)/nn); 
    for (iyr=Yr1;iyr<=endyr;iyr++)
     if (Effort(Ifleet,iyr) > 0)
      if (FOverWrite(Ifleet,0) == 0 |iyr<FOverWrite(Ifleet,1) | iyr>FOverWrite(Ifleet,2))
       like_val(ilike) += square(log((Effort(Ifleet,iyr)+Incd)/(qEff(Ifleet)*(ExplRates(Ifleet,iyr)+Incd))));
   }  
    */
  // Survey indices 
  // !!    SurveyEst(DIfleet,DIyr,2) = sqrt(log(square(SurveyEst(DIfleet,DIyr,2))+1.0));
  for (int isrv=1;isrv<=nsurvey;isrv++)
  {
    ilike++; ///< Increment the likelihood index
    for (int i=1;i<=nobs_survey(isrv);i++)
    {
      if(survey_units(isrv) == 1)
        like_val(ilike) += 0.5*square(log((survey_biom_obs(isrv,i)+incd)/(survey_biom_pred(isrv,i)+incd))) /(survey_var(isrv,i));
      else 
        like_val(ilike) += 0.5*square(log((survey_num_obs(isrv,i)+incd)/(survey_num_pred(isrv,i)+incd))) /(survey_var(isrv,i));
    }  
  // Survey LF
    ilike++; 
    for (i=1;i<=nlf_survey(isrv);i++)
    {
      dvar_vector phat = survey_lf_pred(isrv,i)/sum(survey_lf_pred(isrv,i));
      dvector pobs     = survey_lf_obs(isrv,i) /sum(survey_lf_obs(isrv,i)); // this should probably be done once in beginning
      like_val(ilike)  -= ss_survey_lf(isrv,i)*pobs*log(phat);
      /* for(Iclass=1;Iclass<=Nclass;Iclass++) if (SurveyObsLF(isrv,Icnt,Iclass) > 0) // Jim says this seems to imply that a zero means no data...UNTRUE{ Error = (PredSurvey(isrv,iyr,Iclass)+Incc)/(SurveyObsLF(isrv,Icnt,Iclass)+Incc); like_val(ilike) += -1*SSSurveyLF(isrv,Icnt)*SurveyObsLF(isrv,Icnt,Iclass)*log(Error); } */
    } 
  } 
}

void model_parameters::Get_Priors(void)
{
  int iprior = 0;
  double nn = 0;
  dvariable mean_F=0;
  // Prior on F-devs 
  /*
  */
  for (int ifl=1;ifl<=nfleet_act;ifl++)
  {
    iprior++;
    mean_F = 0; nn = 0;
    for (iyr=styr;iyr<=endyr;iyr++) 
    {
      if (effort(ifl,iyr) > 0) 
      { 
        mean_F += f_all(ifl,iyr); 
        nn++; 
      }
      mean_F /= nn;
    }
    for (iyr=styr;iyr<=endyr;iyr++) 
      if (effort(ifl,iyr) > 0) 
        prior_val(iprior) += square(f_all(ifl,iyr)-mean_F);
  } 
  iprior++;
  // Prior on Rec Devs
  for (i=styr;i<=endyr;i++) 
  {
    prior_val(iprior) += square(recdev(i));
  }
  iprior++;
  // penalties on parameters
  prior_val(iprior) = sum(square(gtrans_parms));
  iprior++;
  for (int i=1;i<=nselex_pars;i++)
    if (selex_phz(i) > 0)
      prior_val(iprior) += square(selex_parms(i));
  iprior++;
  prior_val(iprior) = sum(square(reten_parms));
  iprior++;
  // q - prior
  for (int isrv=1;isrv<=nsurveyq_pars;isrv++)
    if (surveyq_psd(isrv) > 0)
      prior_val(iprior) = square(mfexp(surveyq_parms(isrv))-surveyq_pmean(isrv))/(2.0*square(surveyq_psd(isrv)));
  iprior++;
  // M-prior
  // prior_val(iprior) = square(M0-MPriorMean)/(2.0*square(MPriorSD));
  // prior_val(iprior) = square(theta-MPriorMean)/(2.0*square(MPriorSD));
  // iprior++;
  // 2nd derivative penalty
  /*
  Penal = 0;
  for (Iselex=1;Iselex<=NSelexPat;Iselex++)
   if (SelexType(Iselex,1) == 2)
    for (Iclass=2;Iclass<=Nclass-1;Iclass++)
     Penal += square(SelexAll(Iselex,Iclass-1)-2.0*SelexAll(Iselex,Iclass)+SelexAll(Iselex,Iclass+1));
  prior_val(iprior) = Penal;   
  */
}

void model_parameters::Get_Catch_Pred(void)
{
  dvar_vector S1(1,nclass);                              
  dvar_vector N_tmp(1,nclass);                              // Numbers at fishery
  fleet_lf_pred.initialize();
  catch_biom_pred.initialize();
  catch_num_pred.initialize();
  N_tmp.initialize();
  for (int iyr=styr;iyr<=endyr;iyr++)
  {
    // Need to loop over number of directred fisheries (presently fixed at 1) fleet control matrix
    N_tmp = N(iyr)*mfexp(-catch_time(1,iyr)*M(iyr));
    for (int ifl=1;ifl<=nfleet_act;ifl++)
    {
      S1 = S_fleet(ifl,iyr);
      // Main retained fishery
      if (fleet_control(ifl,2)==1) 
        fleet_lf_pred(ifl,iyr) = elem_prod(N_tmp , elem_prod((1.-S1),reten(iyr)));
      if (fleet_control(ifl, 2)==2) // Discard fishery
        fleet_lf_pred(ifl,iyr) = elem_prod(N_tmp , elem_prod((1.-S1),(1.-reten(iyr))));
      if (fleet_control(ifl, 2)==3) // Main retained fishery
        fleet_lf_pred(ifl,iyr) = elem_prod(N_tmp , (1.-S1));
      N_tmp = elem_prod(N_tmp,S1);
    }
     // Accumulate totals 
     catch_biom_pred(iyr) = fleet_lf_pred(ifl,iyr) * weight;
     catch_num_pred(iyr) = sum(fleet_lf_pred(ifl,iyr) );
  } 
     /*
   for (Iclass=1;Iclass<=Nclass;Iclass++)
    {
     SurvNo = N(iyr,Iclass)*mfexp(-tc(0,iyr)*M(iyr));
     S1 = SF(0,iyr,Iclass);
     CatFleet(0,iyr,Iclass) = SurvNo*(1-S1)*RetCatMale(iyr,Iclass);
     CatFleet(-1,iyr,Iclass) = SurvNo*(1-S1)*(1-RetCatMale(iyr,Iclass));
     SurvNo *= S1;
     for (Ifleet=1;Ifleet<=Nfleet;Ifleet++)
      {
       S2 = SF(Ifleet,iyr,Iclass);
       CatFleet(Ifleet,iyr,Iclass) = SurvNo*(1-S2);
       SurvNo *= S2;
      }
     // Accumulate totals 
     for (Ifleet=-1; Ifleet<=Nfleet;Ifleet++)
      {
       CatFleetWghtPred(Ifleet,iyr) += CatFleet(Ifleet,iyr,Iclass) * Wght(Iclass);
       CatFleetNumPred(Ifleet,iyr) += CatFleet(Ifleet,iyr,Iclass);
      } 
    }
  // Special case for fleet -1
  if (DiscardsOrTotal == 1)
   for (iyr=Yr1;iyr<=endyr;iyr++)
    for (Iclass=1;Iclass<=Nclass;Iclass++)
     CatFleet(-1,iyr,Iclass) = CatFleet(-1,iyr,Iclass) + CatFleet(0,iyr,Iclass);
     */
}

void model_parameters::Get_Survey(void)
{
  survey_lf_pred.initialize();
  survey_biom_pred.initialize();
  survey_num_pred.initialize();
  for (int isrv=1;isrv<=nsurvey;isrv++)
  {
    for (int i=1;i<=nlf_survey(isrv);i++)
    {
      int iyr                  = yr_survey_lf(isrv,i);
      survey_lf_pred(isrv,i)   = elem_prod(N(iyr),selex_survey(isrv,iyr)); // note use if iyr here...t
      survey_lf_pred(isrv,i)  /= sum(survey_lf_pred(isrv,i));
    }
    for (int i=1;i<=nobs_survey(isrv);i++)
    {
      int iyr                  = yr_survey(isrv,i);
      dvar_vector N_tmp        = elem_prod(N(iyr),selex_survey(isrv,iyr)); // note use if iyr here...t
      survey_biom_pred(isrv,i) = N_tmp * weight;
      survey_num_pred(isrv,i)  = sum(N_tmp);
    }
  }
  /*
  PredSurveyNum.initialize();
  PredSurveyWght.initialize();
  for (Isurv=1;Isurv<=Nsurvey;Isurv++)
   for (iyr=Yr1;iyr<=endyr+1;iyr++)
    for (Iclass=1;Iclass<=Nclass;Iclass++)
     {
      PredSurveyWght(Isurv,iyr) += PredSurvey(Isurv,iyr,Iclass)*Wght(Iclass);
      PredSurveyNum(Isurv,iyr) += PredSurvey(Isurv,iyr,Iclass);
     }
  */
}

void model_parameters::report()
{
 adstring ad_tmp=initial_params::get_reportfile_name();
  ofstream report((char*)(adprogram_name + ad_tmp));
  if (!report)
  {
    cerr << "error trying to open report file"  << adprogram_name << ".rep";
    return;
  }
  check(logRbar);
  check(M);
  check(f_all);
  check(strans);
  check(N);
  check(selex_survey);
  check(selex_fleet);
  check(reten);
  check(S);
  check(S_fleet);
  check(exp_rate);
  check(f_direct);
  check(recruits);
  check(N);
  check(mbio);
  exit(1);
}

void model_parameters::final_calcs()
{
  // Exit here, to test code up to this point.
  // Create final time stamp and determine runtime:
  time(&finish);
  elapsed_time=difftime(finish,start);
  hour=long(elapsed_time)/3600;
  minute=long(elapsed_time)%3600/60;
  second=(long(elapsed_time)%3600)%60;
  // Print runtime records to screen:
  cout << endl << endl << "*******************************************"   << endl;
  cout <<         "--Start time: "    <<  ctime(&start)    << endl;
  cout <<          "--Finish time: "    <<   ctime(&finish)    << endl;
  cout <<          "--Runtime: ";
  cout <<  hour <<" hours, "<<minute<<" minutes, "<<second<<" seconds"    << endl;
  cout <<          "*******************************************"  << endl;
}

void model_parameters::set_runtime(void)
{
  dvector temp1("{500,1500,2500,25000,25000}");
  maximum_function_evaluations.allocate(temp1.indexmin(),temp1.indexmax());
  maximum_function_evaluations=temp1;
  dvector temp("{0.01,1.e-4,1.e-5,1.e-5}");
  convergence_criteria.allocate(temp.indexmin(),temp.indexmax());
  convergence_criteria=temp;
}

model_data::~model_data()
{}

model_parameters::~model_parameters()
{}

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
  time(&start);
  arrmblsize = 50000000;
  gradient_structure::set_GRADSTACK_BUFFER_SIZE(1.e7);
  gradient_structure::set_CMPDIF_BUFFER_SIZE(1.e7);
  gradient_structure::set_MAX_NVAR_OFFSET(5000);
  gradient_structure::set_NUM_DEPENDENT_VARIABLES(5000);
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

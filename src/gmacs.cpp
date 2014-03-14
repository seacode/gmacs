  #include <admodel.h>
  #include <time.h>
  #include <contrib.h>
  #include <../../cstar/src/cstar.h>
 
  time_t start,finish;
  long hour,minute,second;
  double elapsed_time;
  // This is an example change.
  // This is an example change.
  // Define objects for report file, echoinput, etc.
  /**
  \def report(object)
  Prints name and value of \a object on ADMB report %ofstream file.
  */
  #undef REPORT
  #define REPORT(object) report << #object "\n" << object << endl;
  /**
  \def echo(object)
  Prints name and value of \a object on echoinput %ofstream file.
  */
  #define echo(object) echoinput << #object << "\n" << object << endl;
  #define echotxt(object,text) echoinput << object << "\t" << text << endl;
  /**
  \def writeR(object)
  Prints name and value of \a object on R_out (gmacs_r.rep) %ofstream file.
  */
  #define writeR(object) R_out << #object << "\n" << object << endl;
  
  /**
  \def check(object)
  Prints name and value of \a object on checkfile %ofstream output file.
  */
  #define check(object) checkfile << #object << "\n" << object << endl;
  // Open output files using ofstream
  ofstream echoinput("echoinput.gm");
  ofstream checkfile("checkfile.gm");
  ofstream warning("warning.gm");
  ofstream R_out("gmacs_r.rep");
  // Define some adstring variables for use in output files:
  adstring version;
  adstring version_short;
  adstring_array fleet_names;
  adstring_array survey_names;
  adstring_array like_names;
  adstring_array prior_names;
  
#include <admodel.h>
#include <contrib.h>

  extern "C"  {
    void ad_boundf(int i);
  }
#include <gmacs.htp>

model_data::model_data(int argc,char * argv[]) : ad_comm(argc,argv)
{
version+="Gmacs_V1.03_2014/01/02_by_Athol_Whitten_and_Jim_Ianelli_using_ADMB_11.1";
version_short+="Gmacs V1.03";
 echoinput << version << endl;
 echoinput << ctime(&start) << endl;
 incc = 0.00001; ///< Constant for likelihoods
 incd = 0.0001;  ///< Constant for likelihoods
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
 if(eof_starter!=999) {cerr << " Error reading starter file \n EOF = "<< eof_starter << endl; exit(1);}
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
  iname_flt.allocate(1,nfleet,1,2);
  iname_srv.allocate(1,nfleet,1,2);
  name_read_flt.allocate("name_read_flt");
  name_read_srv.allocate("name_read_srv");
   // Convert read in strings of fishery and survey names to a string array (so they can be indexed):
   // TODO: Create way to return an error if not formatted properly.
  int k;
  for(k=1;k<=nfleet;k++) 
  {
    iname_flt(k,1)=1; 
    iname_flt(k,2)=1;
  }    
  // Set whole array equal to 1 in case not enough names are read:
  adstring_array CRLF;   // Blank to terminate lines (not sure why this is needed...)
  CRLF+="";
  k=1;
  for(i=1;i<=strlen(name_read_flt);i++)
  {
    if(adstring(name_read_flt(i))==adstring(":")) 
    {
      iname_flt(k,2)=i-1; 
      k++;  
      iname_flt(k,1)=i+1;
    }
  }
  iname_flt(nfleet,2)=strlen(name_read_flt);
  for(k=1;k<=nfleet;k++)
  {
    fleet_names += name_read_flt(iname_flt(k,1),iname_flt(k,2))+CRLF(1);
  }
  for(k=1;k<=nsurvey;k++) 
  {
    iname_srv(k,1)=1; 
    iname_srv(k,2)=1;
  }    
  // Set whole array equal to 1 in case not enough names are read
  // Read in survey names
  k=1;
  for(i=1;i<=strlen(name_read_srv);i++)
  {
    if(adstring(name_read_srv(i))==adstring(":")) 
    {
      iname_srv(k,2) =i-1; 
      k++;  
      iname_srv(k,1) =i+1;
    }
  }
  iname_srv(nsurvey,2)=strlen(name_read_srv);
  for(k=1;k<=nsurvey;k++)
  {
    survey_names += name_read_srv(iname_srv(k,1),iname_srv(k,2))+CRLF(1);
  }
  // TODO: Macro doesn't work perfectly for printing these out...unsure why. Test and fix.
  echotxt(fleet_names,  "Fleetnames");
  echotxt(survey_names, "Surveynames");
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
 echotxt(catch_units,  " Catch units");
 echotxt(catch_multi,  " Catch multipliers");
 echotxt(survey_units, " Survey units");
 echotxt(survey_multi, " Survey multipliers")
 echotxt(ncatch_obs,   " Number of lines of catch data");
 echotxt(nsurvey_obs,  " Number of lines of survey data")
 echotxt(survey_time,  " Time between survey and fishery");
  fleet_control.allocate(1,nfleet,1,2,"fleet_control");
    nfleet_ret = 0;
    nfleet_dis = 0;
    nfleet_byc = 0;
    for (ifleet=1; ifleet<=nfleet; ifleet++)
    {
      switch (fleet_control(ifleet,1)) 
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
  fleet_ind_act.allocate(1,nfleet_act);
 int iact=0;for (int i=1;i<=nfleet;i++) if(fleet_control(i,1)!=2) {iact++;fleet_ind_act(iact)=i;}
 echo(fleet_control);
  catch_data.allocate(1,ncatch_obs,1,5,"catch_data");
  catch_biom_obs.allocate(1,nfleet,styr,endyr);
  catch_num_obs.allocate(1,nfleet,styr,endyr);
  survey_data.allocate(1,nsurvey_obs,1,6,"survey_data");
  nobs_survey.allocate(1,nsurvey);
 echo(catch_data);
 echo(survey_data);  
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
  for (int i=1;i<=nsurvey_obs;i++)
    nobs_survey(survey_data(i,3))++;
  check(nobs_survey);
  yr_survey.allocate(1,nsurvey,1,nobs_survey);
  survey_biom_obs.allocate(1,nsurvey,1,nobs_survey);
  survey_num_obs.allocate(1,nsurvey,1,nobs_survey);
  survey_var.allocate(1,nsurvey,1,nobs_survey);
  survey_var.initialize();
  survey_biom_obs.initialize();
  survey_num_obs.initialize();
  ivector iobs_sv(1,nsurvey);  ///< Counter for number of obs within each survey
  iobs_sv.initialize();
  for (int i=1;i<=nsurvey_obs;i++)
  {
    int isrv=survey_data(i,3);
    iobs_sv(isrv)++;
    yr_survey(isrv,iobs_sv(isrv)) = survey_data(i,1); 
    if (survey_units(isrv)==1)
      survey_biom_obs(isrv,iobs_sv(isrv)) = survey_data(i,5);
    else 
      survey_num_obs(isrv,iobs_sv(isrv)) = survey_data(i,5);
    survey_var(isrv,iobs_sv(isrv)) = log(1+square(survey_data(i,6))); // For likelihood, compute input variance here, assumes input as CV.
  }  
  for (isurvey=1; isurvey<=nsurvey; isurvey++)  
  {
    for (int i=1; i<=nobs_survey(isurvey); i++)
    { 
      survey_biom_obs(isurvey,i) *= survey_multi(isurvey);
      survey_num_obs(isurvey,i)  *= survey_multi(isurvey);
    }
  }
  check(survey_var);
  check(survey_num_obs);
  check(survey_var);
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
  check(catch_biom_obs);
  check(catch_num_obs);
  for (ifleet=1; ifleet<=nfleet; ifleet++)
  {
    for (iyr=styr; iyr<=endyr; iyr++)
    { 
     catch_biom_obs(ifleet,iyr) *= discard_mort(ifleet) * catch_multi(ifleet);
     catch_num_obs(ifleet,iyr) *= discard_mort(ifleet) * catch_multi(ifleet);
    }
  }
  ncatch_f.allocate(1,nfleet_act);
  for (ifleet=1; ifleet<=nfleet_act; ifleet++)
  {
    ncatch_f(ifleet) = 0;
    for (iyr=styr; iyr<=endyr; iyr++) 
      if (effort(ifleet,iyr) > 0) 
      {
        if (f_new(ifleet,1) == 0 || iyr < f_new(ifleet,2) || iyr > f_new(ifleet,3))
          ncatch_f(ifleet) += 1;
      }
  }
 echotxt(ncatch_f, " Number of F's (calculated)")
  nlf_obs.allocate("nlf_obs");
  lf_data.allocate(1,nlf_obs,1,ndclass+7,"lf_data");
  nlf_fleet.allocate(1,nfleet);
  nlf_fleet.initialize();
  for (int i=1; i<=nlf_obs; i++) 
  {
    nlf_fleet(int(lf_data(i,3)))++ ;
  }
  yr_fleet_lf.allocate(1,nfleet,1,nlf_fleet);
  ss_fleet_lf.allocate(1,nfleet,1,nlf_fleet);
  fleet_lf.allocate(1,nfleet,1,nlf_fleet,1,ndclass);
  fleet_lf_obs.allocate(1,nfleet,1,nlf_fleet,1,nclass);
  ivector iobs_fl(1,nfleet);                                ///< Counter for number of obs within each fleet
  iobs_fl.initialize();
  for (int i=1; i<=nlf_obs; i++) 
  {
    ifleet = int(lf_data(i,3));
    iobs_fl(ifleet)++;
    yr_fleet_lf(ifleet,iobs_fl(ifleet)) = (lf_data(i,1));
    ss_fleet_lf(ifleet,iobs_fl(ifleet)) = lf_data(i,7);
    
    if(nclass!=ndclass)
    {
      for (iclass=1; iclass<=nclass; iclass++)
        fleet_lf_obs(ifleet,iobs_fl(ifleet),iclass) = sum(lf_data(i)(7+class_link(iclass,1),7+class_link(iclass,2)));      
    }
    else
      fleet_lf_obs(ifleet,iobs_fl(ifleet)) = lf_data(i)(8,7+ndclass).shift(1);
    fleet_lf_obs(ifleet,iobs_fl(ifleet)) /= sum(fleet_lf_obs(ifleet,iobs_fl(ifleet)) ); // normalize LF to sum to 1
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
  for (int i=1; i<=nlfs_obs; i++) 
  {
    nlf_survey(int(lfs_data(i,3)))++ ;
  }
  yr_survey_lf.allocate(1,nsurvey,1,nlf_survey);
  ss_survey_lf.allocate(1,nsurvey,1,nlf_survey);
  survey_lf.allocate(1,nsurvey,1,nlf_survey,1,ndclass);
  survey_lf_obs.allocate(1,nsurvey,1,nlf_survey,1,nclass);
  iobs_sv.initialize();
  for (int i=1; i<=nlfs_obs; i++) 
  {
    isurvey = int(lfs_data(i,3));
    iobs_sv(isurvey)++;
    yr_survey_lf(isurvey,iobs_sv(isurvey)) = (lfs_data(i,1));
    ss_survey_lf(isurvey,iobs_sv(isurvey)) = lfs_data(i,5);
    
    if(nclass!=ndclass)
    {
      for (iclass=1; iclass<=nclass; iclass++)
      {
        survey_lf_obs(isurvey,iobs_sv(isurvey),iclass) = sum(lfs_data(i)(5+class_link(iclass,1),5+class_link(iclass,2)));
      }
    }
    else
    {
      survey_lf_obs(isurvey,iobs_sv(isurvey)) = lfs_data(i)(6,5+ndclass).shift(1);
    }
    survey_lf_obs(isurvey,iobs_sv(isurvey)) /= sum(survey_lf_obs(isurvey,iobs_sv(isurvey))); // normalize to sum to 1
    survey_lf(isurvey,iobs_sv(isurvey)) = lfs_data(i)(6,(ndclass+5)).shift(1);               // Retain full dimension for length and weight calcs
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
 echo(fecundity_inp);
  length.allocate(1,nclass);
  weight.allocate(1,nclass);
  fecundity.allocate(1,nclass);
  surv_lf_store.allocate(1,ndclass);
 checkfile << "Class-specific length, weight, and fecundity" << endl;
  if(nclass!=ndclass)
  {
    int total;
    total = 0;
    for (iclass=1; iclass<=ndclass; iclass++)
    {
      surv_lf_store(iclass) = 0;
      for (iyr=1; iyr<=nlfs_obs; iyr++) surv_lf_store(iclass) += survey_lf(1,iyr,iclass);
      total += surv_lf_store(iclass);
    }
    if (verbose == 1) cout << "Survey sample sizes stored" << endl; // CHECK: ? Not storing sample sizes.
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
    if (verbose == 1) cout << " Lengths, weights, and fecundity recalculated" << endl;
  }
  else
  {
    length = mean_length;
    weight = mean_weight;
    fecundity = fecundity_inp;
    check(length);
    check(weight);
    check(fecundity);
  }  
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
  else // Set to some values so as not to cause allocation issues for public variables:
  {
    ndclass_growth = ndclass;
    styr_growth    = styr;
    endyr_growth   = endyr;
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
  M_pnt.allocate(styr,endyr);
    M_pnt.initialize(); 
    if (theta_blk(2)>0)  
    {
      *(ad_comm::global_datafile) >> M_pnt ;
      M_pnt -= 1;
      nMadd_parms = max(M_pnt) ;                   
    }
    else
      nMadd_parms = 1; // just to have some value (will be unestimated)
    echo(M_pnt);
    echotxt(nMadd_parms, " Number of additional natural mortality parameters");
  madd_control.allocate(1,nMadd_parms,1,4);
  trans_madd_control.allocate(1,4,1,nMadd_parms);
  madd_init.allocate(1,nMadd_parms);
  madd_lbnd.allocate(1,nMadd_parms);
  madd_ubnd.allocate(1,nMadd_parms);
  madd_phz.allocate(1,nMadd_parms);
    if (theta_blk(2)>0)
    {
      for (int i=1;i<=nMadd_parms;i++) *(ad_comm::global_datafile) >> madd_control(i) ;
      trans_madd_control = trans(madd_control);
      madd_init = trans_madd_control(1);
      madd_lbnd = trans_madd_control(2);
      madd_ubnd = trans_madd_control(3);
      madd_phz = ivector(trans_madd_control(4));
    }
    else
    {
      nMadd_parms = 1;
      madd_lbnd = 0.;
      madd_ubnd = 1.;
      madd_phz   = -1;
      madd_init = 0.0;
      madd_control.initialize();
    }
  echo(madd_control);
  echo(madd_init);
  echo(madd_ubnd);
  echo(madd_lbnd);
  echo(madd_phz);
  selex_fleet_pnt.allocate(1,nfleet_act,styr,endyr,"selex_fleet_pnt");
  selex_survey_pnt.allocate(1,nsurvey,styr,endyr+1,"selex_survey_pnt");
 echo(selex_fleet_pnt);
 echo(selex_survey_pnt);
 nselex_pats = max(selex_survey_pnt);
 echotxt(nselex_pats, " Total number of selectivity patterns");
  selex_type.allocate(1,nselex_pats,1,4);
  nselex = 0;
  for (int i=1; i<=nselex_pats; i++)
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
  int i = 0;
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
    echo(selex_phz);
  reten_fleet_pnt.allocate(1,nfleet_ret,styr,endyr,"reten_fleet_pnt");
 nreten_pars = max(reten_fleet_pnt);
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
 nprior_terms = (nfleet_act) + 1 + 3 + nsurveyq_pars + 1 + 1;  
 nlike_terms = (nfleet)*2+ (nfleet_act) + (nsurvey)*2;
  mn_offset.allocate(1,nlike_terms);
  trans_gtrans_control = trans(gtrans_control);
  gtrans_init = trans_gtrans_control(1);
  gtrans_lbnd = trans_gtrans_control(2);
  gtrans_ubnd = trans_gtrans_control(3);
  gtrans_phz = ivector(trans_gtrans_control(4));  
  for (int ifl=1;ifl<=nfleet_act;ifl++)
    prior_names  += fleet_names(fleet_ind_act(ifl))+"_Fpen"+CRLF(1);
  prior_names  += "rec_devs" +CRLF(1);
  prior_names  += "trans_parms" +CRLF(1);
  prior_names  += "Selex"+CRLF(1);
  prior_names  += "reten_parms" +CRLF(1);
  for (int ifl=1;ifl<=nsurveyq_pars;ifl++) 
    prior_names  += "Survey_q_parms" +CRLF(1);
  prior_names  += "M" +CRLF(1);
  prior_names  += "SelPen" +CRLF(1);
    
  // TODO: Check this section works in the general sense when applying to other species.
  echotxt(nprior_terms, " Number of prior terms");
  echotxt(nlike_terms, " Number of likelihood terms");
  mn_offset.initialize();
  // Fill in names of likelihood and prior components:
  int ilike=0;
  for (int ifl=1;ifl<=nfleet;ifl++)
  {
    ilike++; 
    like_names  += fleet_names(ifl)+"_catch"+CRLF(1);
  }
   // Catch LFs
  for (int ifl=1;ifl<=nfleet;ifl++)
  {
    ilike++; 
    for (int i=1;i<=nlf_fleet(ifl);i++)
    {
      dvector pobs      = incd + fleet_lf_obs(ifl,i);
              pobs     /= sum(pobs);
      mn_offset(ilike) -= ss_fleet_lf(ifl,i)*pobs*log(pobs);
    } 
    like_names += fleet_names(ifl)+"_LF"+CRLF(1);
  } 
  // Effort indices
  for (int ifl=1;ifl<=nfleet_act;ifl++)
  {
    ilike++; ///< Increment the likelihood index
    like_names += "Fish_effort"+CRLF(1);
  } 
  // Survey indices 
  for (int isrv=1;isrv<=nsurvey;isrv++)
  {
    ilike++; ///< Increment the likelihood index
    like_names += survey_names(isrv)+"_Index"+CRLF(1);
    ilike++; 
    like_names += survey_names(isrv)+"_LF"+CRLF(1);
    // Survey LF
    for (int i=1;i<=nlf_survey(isrv);i++)
    {
      dvector pobs      = incd + survey_lf_obs(isrv,i);
              pobs     /= sum(pobs);
      mn_offset(ilike) -= ss_survey_lf(isrv,i)*pobs*log(pobs);
    }
  } 
  check(mn_offset);
  echo(mn_offset);
  echo(nlike_terms);
  echo(nprior_terms);
  prior_weight.allocate(1,nprior_terms,"prior_weight");
  like_weight.allocate(1,nlike_terms,"like_weight");
 echo(prior_weight);
 echo(like_weight);
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
  cout << " Count parameters and get max phase, adjust phases if required" << endl;
  max_phase=1;
  active_count=0;
  par_count=0;
  active_parm(0,ntheta)=0;
    
  for(int i=1; i<=ntheta; i++)
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

void model_parameters::initializationfunction(void)
{
  theta_parms.set_initial_value(theta_init);
  gtrans_parms.set_initial_value(gtrans_init);
  selex_parms.set_initial_value(selex_init);
  reten_parms.set_initial_value(reten_init);
  surveyq_parms.set_initial_value(surveyq_init);
  lognin_parms.set_initial_value(lognin_init);
  f_est.set_initial_value(0.1);
}

model_parameters::model_parameters(int sz,int argc,char * argv[]) : 
 model_data(argc,argv) , function_minimizer(sz)
{
  initializationfunction();
  theta_parms.allocate(1,ntheta,theta_lbnd,theta_ubnd,theta_phz,"theta_parms");
  Madd_parms.allocate(1,nMadd_parms,madd_lbnd,madd_ubnd,madd_phz,"Madd_parms");
  gtrans_parms.allocate(1,nclass-1,gtrans_lbnd,gtrans_ubnd,gtrans_phz,"gtrans_parms");
  selex_parms.allocate(1,nselex_pars,selex_lbnd,selex_ubnd,selex_phz,"selex_parms");
  reten_parms.allocate(1,nreten_pars,reten_lbnd,reten_ubnd,reten_phz,"reten_parms");
  surveyq_parms.allocate(1,nsurveyq_pars,surveyq_lbnd,surveyq_ubnd,surveyq_phz,"surveyq_parms");
  lognin_parms.allocate(1,nclass,lognin_lbnd,lognin_ubnd,lognin_phz,"lognin_parms");
  recdev.allocate(styr,endyr,1,"recdev");
  f_est.allocate(1,nfleet_act,1,ncatch_f,0,1,1,"f_est");
 check(Madd_parms);
 check(madd_phz);
 check(gtrans_parms);
 check(gtrans_phz);
 check(selex_parms);
 check(selex_phz);
 check(reten_parms);
 check(reten_phz);
 check(surveyq_parms);
 check(surveyq_phz);
 check(lognin_parms);
 check(lognin_phz);
 cout << " All parameters declared \n" << endl;
 checkfile << " All parameters declared" << endl;
  logRbar.allocate("logRbar");
  #ifndef NO_AD_INITIALIZE
  logRbar.initialize();
  #endif
  M0.allocate("M0");
  #ifndef NO_AD_INITIALIZE
  M0.initialize();
  #endif
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
  exp_rate.allocate(1,nfleet_act,styr,endyr,"exp_rate");
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
  fleet_lf_pred.allocate(1,nfleet,styr,endyr,1,nclass,"fleet_lf_pred");
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
  mbio_zero.allocate("mbio_zero");
  #ifndef NO_AD_INITIALIZE
  mbio_zero.initialize();
  #endif
  mbio.allocate(styr,endyr,"mbio");
  recruits.allocate(styr,endyr,"recruits");
  prior_val.allocate(1,nprior_terms,"prior_val");
  #ifndef NO_AD_INITIALIZE
    prior_val.initialize();
  #endif
  like_val.allocate(1,nlike_terms,"like_val");
  #ifndef NO_AD_INITIALIZE
    like_val.initialize();
  #endif
  ObjFun.allocate("ObjFun");
  prior_function_value.allocate("prior_function_value");
  likelihood_function_value.allocate("likelihood_function_value");
}

void model_parameters::userfunction(void)
{
  ObjFun =0.0;
  logRbar = theta_parms(1);
  M0      = theta_parms(2);
  Set_effort();
  Set_selectivity();
  Set_survival();
  Initial_size_structure();
  Set_growth();
  Update_population(); 
  Get_Survey();
  Get_Catch_Pred();
  Get_ObjFunction();
  if (last_phase()) 
    Get_Dependent_Vars();
}

void model_parameters::Set_effort(void)
{
  f_all.initialize(); // Initialize all Fs to zero
  // Convert to Fs
  int count, ifl, iyear;
  dvariable ratio, ratio_2, delta;
  for (ifl=1; ifl<=nfleet_act; ifl++)
  {
    count = 0;
    for (iyear=styr; iyear<=endyr; iyear++)
    {
      if (effort(ifl,iyear) > 0)
      {
        if (f_new(ifl,1) == 0 || iyear < f_new(ifl,2) || iyear > f_new(ifl,3))
        { 
          count++; 
          f_all(ifl,iyear) = f_est(ifl,count); 
        }
        else
          f_all(ifl,iyear) = -100; // not sure why this is needed?
      }  
    }
  }  
  // Fill in missing values using a ratio estimator:
  for (ifl=1; ifl<=nfleet_act; ifl++)
  {
    if (f_new(ifl,1) > 0) // Not used for BBRKC case...
    {
      ratio = 0; ratio_2 = 0;
      for (iyear=f_new(ifl,4); iyear<=f_new(ifl,5); iyear++)
      {
        if (effort(ifl,iyear) > 0)
        {
          ratio += -log(1.0-f_all(ifl,iyear))/effort(ifl,iyear);
          ratio_2 += 1;
        }
      }
      delta = ratio/ratio_2;
      for (iyear=f_new(ifl,2); iyear<=f_new(ifl,3); iyear++)
        f_all(ifl,iyear) = 1.0-mfexp(-delta*effort(ifl,iyear));
    }
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
  N.initialize();
  N(styr) = mfexp(logRbar+lognin_parms);
}

void model_parameters::Set_selectivity(void)
{
  // Produce all selectivities:
  int ipnt; 
  // Loop over selectivity patterns:
  for (int isel=1; isel<=nselex_pats; isel++)
    selex_all(isel) = Get_Sel(isel);
  // Fishery and bycatch selectivity:
  for (int ifl=1; ifl<=nfleet_act; ifl++)
  {
    for (iyr=styr; iyr<=endyr; iyr++)
    {
      ipnt = selex_fleet_pnt(ifl,iyr);
      selex_fleet(ifl,iyr) = selex_all(ipnt) ;
    }  
  }
  // Retention in the pot fishery:
  for (int ifl=1; ifl<=nfleet_ret; ifl++)
    for (iyr=styr; iyr<=endyr; iyr++)
    {
      ipnt = (reten_fleet_pnt(ifl,iyr)-1)*nclass;
      for (iclass=1; iclass<=nclass; iclass++)
      {
        reten(iyr,iclass) = (1-hg(iyr))/(1.0+mfexp(reten_parms(ipnt+iclass)));
      } 
    } 
  // Survey selectivity:
  dvariable qq ;
  for (int isurv=1; isurv<=nsurvey; isurv++)
    for (int iyr=styr; iyr<=endyr+1; iyr++)
    {
      ipnt = surveyq_pnt(isurv,iyr);
      qq = mfexp(surveyq_parms(ipnt));
      ipnt = selex_survey_pnt(isurv,iyr);
      selex_survey(isurv,iyr) = qq*selex_all(ipnt);
    }  
  // Nest one survey within another:
  for (ipnt=1; ipnt<=nsubsurvey; ipnt++)
    for (int iyr=styr; iyr<=endyr+1; iyr++)
      for (int iclass=1; iclass<=nclass; iclass++)
        selex_survey(subsurvey(ipnt,1),iyr,iclass) *= selex_survey(subsurvey(ipnt,2),iyr,iclass); 
}

dvar_vector model_parameters::Get_Sel(const int& isel)
{
  RETURN_ARRAYS_INCREMENT();
  dvar_vector seltmp(1,nclass);
  dvariable slope_par;
  dvariable temp;
  int  ipnt    = selex_type(isel,4);
  int  seltype = selex_type(isel,2); 
  switch (seltype)
  {
    case 1 : ///< Logistic parameterized to be the location of 5 and 95% selectivity
      slope_par = -log(19)* selex_parms(ipnt +2);
      seltmp    = 1.0 / (1.0 + mfexp(slope_par) * (length-selex_parms(ipnt +1)));
      temp      = seltmp(nclass);
      seltmp    /= temp;
      break;
    case 2 : ///< One selectivity parameter per size class
      for (int iclass=1; iclass<=nclass; iclass++)
        seltmp(iclass) = 1.0 / (1.0+mfexp(selex_parms(ipnt + iclass)));
      temp   = seltmp(nclass);
      seltmp /= temp;
      break;
    case 3 : ///< Template for a new pattern (presently identical to type==1)
      slope_par = -log(19)* selex_parms(ipnt +2);
      seltmp    = 1.0 / (1.0 + mfexp(slope_par) * (length-selex_parms(ipnt +1)));
      temp      = seltmp(nclass);
      seltmp    /= temp;
      break;
  } 
  RETURN_ARRAYS_DECREMENT();
  return seltmp;
}

void model_parameters::Set_survival(void)
{
  int iyr,iclass,ifl;
  // Specify natural mortality:
  M = M0;
  for (iyr=styr; iyr<=endyr; iyr++) 
    if (M_pnt(iyr)>0)  // TODO Check to see the logic here
      M(iyr) += Madd_parms(M_pnt(iyr)); 
  for (iyr=styr; iyr<=endyr; iyr++)
  {
    S(iyr) = mfexp(-M(iyr));
    for (ifl=1; ifl<=nfleet_act; ifl++)
    {
      S_fleet(ifl,iyr) = (1.-selex_fleet(ifl,iyr)*f_all(ifl,iyr));
      exp_rate(ifl,iyr) = f_all(ifl,iyr);
      S(iyr) = elem_prod(S(iyr),S_fleet(ifl,iyr));
    } 
  }
}

void model_parameters::Update_population(void)
{
  for (int iyr=styr; iyr<=endyr; iyr++)
  {
    // Grow individuals for one time-step:
    for (int iclass=1; iclass<=nclass; iclass++)
      for (int jclass=1; jclass<=nclass; jclass++)
        N(iyr+1,iclass) += strans(jclass,iclass)*N(iyr,jclass)*S(iyr,jclass);
    // Add recruitment for next year:
    recruits(iyr) = mfexp(logRbar+recdev(iyr));
    N(iyr+1,1) += recruits(iyr);
  }
}

void model_parameters::Get_Dependent_Vars(void)
{
   // TODO: Check why only selex_fleet(1) is used for mbio_calc.
   // TODO: Check 2/12 here in mbio calculation, is this a timing fraction that needs to be generalised?
  mbio.initialize();
  for (int iyr=styr; iyr<=endyr; iyr++)
     mbio(iyr) += N(iyr)*elem_prod(fecundity,(1-selex_fleet(1,iyr)*f_all(1,iyr))) *
                    mfexp(-(catch_time(1,iyr)+2/12)*M(iyr));
}

void model_parameters::Get_ObjFunction(void)
{
  Get_Likes();
  Get_Priors();
  ObjFun  = like_weight*like_val  + prior_weight * prior_val;
}

void model_parameters::Get_Likes(void)
{
  like_val.initialize();
  int ilike=0;
  // Likelihood for Catch biomass (or number)
  for (int ifl=1;ifl<=nfleet;ifl++)
  {
    ilike++; ///< Increment the likelihood index
    for (int iyr=styr;iyr<=endyr;iyr++)
    {
      if (catch_biom_obs(ifl,iyr)>0.)
      {
        if(catch_units(ifl) == 1)
          like_val(ilike) += square(log(catch_biom_pred(ifl,iyr)+incd)-log(catch_biom_obs(ifl,iyr)+incd));
        else
          like_val(ilike) += square(log(catch_num_pred(ifl,iyr)+incd)-log(catch_num_obs(ifl,iyr)+incd));
      }
    }
  }
  // Likelihood for catch LFs
  for (int ifl=1;ifl<=nfleet;ifl++)
  {
    ilike++; ///< Increment the likelihood index
    for (int i=1;i<=nlf_fleet(ifl);i++)
    {
      int iyr = yr_fleet_lf(ifl,i);
      dvar_vector phat(1,nclass);
      phat  = incd + fleet_lf_pred(ifl,iyr);
      phat /= sum(phat);
      dvector pobs(1,nclass);
      pobs      = incd + fleet_lf_obs(ifl,i);
      pobs     /= sum(pobs);
      like_val(ilike)  -= ss_fleet_lf(ifl,i)*pobs*log(phat);
    } 
    like_val(ilike) -= mn_offset(ilike);
  } 
  // Likelihood for effort indices
  q_effort.initialize();
  for (int ifl=1;ifl<=nfleet_act;ifl++)
  {
    ilike++; ///< Increment the likelihood index
    double nn= 0;
    for (iyr=styr;iyr<=endyr;iyr++)
      if (effort(ifl,iyr) > 0) 
      {
        if (f_new(ifl,1) == 0 || iyr<f_new(ifl,2) || iyr>f_new(ifl,3))
        { 
          nn++ ; 
          q_effort(ifl) += log((effort(ifl,iyr)+incd)/(exp_rate(ifl,iyr)+incd)); 
        }
      }  
    q_effort(ifl) = mfexp(q_effort(ifl)/nn); 
    for (iyr=styr;iyr<=endyr;iyr++)
     if (effort(ifl,iyr) > 0)
      if (f_new(ifl,1) == 0 || iyr<f_new(ifl,2) || iyr > f_new(ifl,3))
       like_val(ilike) += square(log((effort(ifl,iyr)+incd)/(q_effort(ifl)*(exp_rate(ifl,iyr)+incd))));
  }  
  // Likelihood for survey indices 
  for (int isrv=1;isrv<=nsurvey;isrv++)
  {
    ilike++; ///< Increment the likelihood index
    for (int i=1;i<=nobs_survey(isrv);i++)
    {
      if(survey_units(isrv) == 1)
        like_val(ilike) += 0.5*square(log((survey_biom_obs(isrv,i)+incd)/(survey_biom_pred(isrv,i)+incd))) /survey_var(isrv,i);
      else 
        like_val(ilike) += 0.5*square(log((survey_num_obs(isrv,i)+incd)/(survey_num_pred(isrv,i)+incd))) /survey_var(isrv,i);
    }  
  // Likelihood for survey LF
    ilike++; 
    for (int i=1;i<=nlf_survey(isrv);i++)
    {
      dvar_vector phat(1,nclass);
      phat  = incd + survey_lf_pred(isrv,i);
      phat /= sum(phat);
      dvector pobs(1,nclass);
      pobs      = incd + survey_lf_obs(isrv,i);
      pobs     /= sum(pobs); 
      like_val(ilike)  -= ss_survey_lf(isrv,i)*pobs*log(phat);
      /* for(Iclass=1;Iclass<=Nclass;Iclass++) if (SurveyObsLF(isrv,Icnt,Iclass) > 0) // Jim says this seems to imply that a zero means no data...UNTRUE{ Error = (PredSurvey(isrv,iyr,Iclass)+Incc)/(SurveyObsLF(isrv,Icnt,Iclass)+Incc); like_val(ilike) += -1*SSSurveyLF(isrv,Icnt)*SurveyObsLF(isrv,Icnt,Iclass)*log(Error); } */
    } 
    like_val(ilike) -= mn_offset(ilike);
  } 
}

void model_parameters::Get_Priors(void)
{
  prior_val.initialize(); 
  int iprior = 0;
  double nn = 0;
  dvariable mean_F=0;
  // Prior on F-devs 
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
  prior_val(iprior) = norm2(recdev);
  iprior++;
  // Penalties on parameters
  prior_val(iprior) = sum(square(gtrans_parms));
  iprior++;
  for (int i=1;i<=nselex_pars;i++)
    if (selex_phz(i) > 0)
      prior_val(iprior) += square(selex_parms(i));
  iprior++;
  prior_val(iprior) = sum(square(reten_parms));
  iprior++;
  // Prior on Catchability (q)
  for (int isrv=1;isrv<=nsurveyq_pars;isrv++)
  {
    if (surveyq_psd(isrv) > 0)
    {
      prior_val(iprior) = square(mfexp(surveyq_parms(isrv))-surveyq_pmean(isrv))/(2.0*square(surveyq_psd(isrv)));
    }
    iprior++;
  }
  // M-prior
  prior_val(iprior) = square(M0-theta_pmean(2))/(2.0*square(theta_psd(2)));
  // 2nd derivative penalty
  iprior++;
  dvariable penal = 0.;
  for (int isel=1;isel<=nselex_pats;isel++)
   if (selex_type(isel,1) == 2)
    for (iclass=2;iclass<=nclass-1;iclass++)
     penal += square(selex_all(isel,iclass-1)-2.0*selex_all(isel,iclass)+selex_all(isel,iclass+1));
  prior_val(iprior) = penal;   
}

void model_parameters::Get_Catch_Pred(void)
{
  dvar_vector S1(1,nclass);                              
  dvar_vector N_tmp(1,nclass);   ///< Numbers per fishery (temporary accumulator)
  int ifl_act;
  fleet_lf_pred.initialize();
  catch_biom_pred.initialize();
  catch_num_pred.initialize();
  N_tmp.initialize();
  for (int iyr=styr;iyr<=endyr;iyr++)
  {
    // TODO: Need to loop over number of directed fisheries (presently fixed at 1) fleet control matrix
    N_tmp = N(iyr)*mfexp(-catch_time(1,iyr)*M(iyr));
    for (int ifl=1;ifl<=nfleet;ifl++)
    {
      switch (fleet_control(ifl,1)) 
      {
        case 1 : // Main retained fishery
          ifl_act = fleet_control(ifl,2);
          S1 = S_fleet(ifl_act,iyr);
          fleet_lf_pred(ifl,iyr) = elem_prod(N_tmp , elem_prod((1.-S1),reten(iyr)));
          break;
        case 2 : // Discard fishery
          ifl_act = fleet_control(ifl,2);
          S1 = S_fleet(ifl_act,iyr);
          fleet_lf_pred(ifl,iyr) = elem_prod(N_tmp , elem_prod((1.-S1),(1.-reten(iyr))));
          break;
        case 3 : // Fishery w/ no discard component (can be a bycatch fishery)
          ifl_act = fleet_control(ifl,2);
          S1 = S_fleet(ifl_act,iyr);
          fleet_lf_pred(ifl,iyr) = elem_prod(N_tmp , (1.-S1));
          break;
      }
      N_tmp = elem_prod(N_tmp,S1);
      // Accumulate totals 
      catch_biom_pred(ifl,iyr) = fleet_lf_pred(ifl,iyr) * weight;
      catch_num_pred(ifl,iyr)  = sum(fleet_lf_pred(ifl,iyr) );
      if (catch_num_pred(ifl,iyr) >0.)
        fleet_lf_pred(ifl,iyr)  /= catch_num_pred(ifl,iyr) ;
    }
  } 
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
  cout << "-----End of phase "<<current_phase()<<" ----------------------------------"<<endl;
  if (last_phase())
    Do_R_Output();
  report << "Likelihood components"<<endl;
  for (int i=1;i<=nlike_terms;i++)
    report << like_names(i)<<" " << like_val(i)<<" "<<like_weight(i)<<" "<<like_val(i)*like_weight(i)<<endl;
  REPORT(like_val);
  REPORT(like_weight);
  report << "prior components"<<endl;
  for (int i=1;i<=nprior_terms;i++)
    report << prior_names(i)<<" " << prior_val(i)<<" "<<prior_weight(i)<<" "<<prior_val(i)*prior_weight(i)<<endl;
  REPORT(prior_val);
  REPORT(prior_weight);
  REPORT(logRbar);
  REPORT(M);
  REPORT(f_all);
  REPORT(strans);
  REPORT(N);
  REPORT(selex_survey);
  REPORT(selex_fleet);
  REPORT(reten);
  REPORT(S);
  REPORT(S_fleet);
  REPORT(exp_rate);
  REPORT(f_direct);
  REPORT(recruits);
  REPORT(N);
  REPORT(mbio);
}

void model_parameters::Do_R_Output(void)
{
  writeR(ObjFun);
  writeR(like_weight);
  writeR(like_val);
  dvar_vector like_wt_val = elem_prod(like_weight,like_val);
  writeR(like_wt_val);
  writeR(prior_weight);
  writeR(prior_val);
  dvar_vector prior_wt_val = elem_prod(prior_weight,prior_val);
  writeR(prior_wt_val);
  ivector years(styr,endyr);
  years.fill_seqadd(styr,1);
  writeR(years);
  writeR(mean_length);
  writeR(nclass);
  writeR(M);
  writeR(recruits);
  writeR(N);
  writeR(nfleet);
  writeR(fleet_control);
  writeR(yr_survey);
  // writeR(fleet_names);
  writeR(catch_biom_pred);
  writeR(catch_biom_obs);
  writeR(catch_data);
  writeR(lf_data);
  writeR(survey_data);
  writeR(lfs_data);
  writeR(catch_num_pred);
  writeR(catch_num_obs);
  writeR(catch_num_obs);
  writeR(yr_fleet_lf);
  writeR(nlf_fleet);
  R_out<<"fleet_lf_obs"<<endl;
  for (int ifl=1; ifl<=nfleet; ifl++)
  {
    for (i=1; i<=nlf_fleet(ifl); i++)
    {
      iyr = yr_fleet_lf(ifl,i);
      R_out << iyr << " "
            << ifl << " "
            << fleet_lf_obs(ifl,i)<<endl;
    }
  }    
  R_out<<"fleet_lf_pred"<<endl;
  for (int ifl=1; ifl<=nfleet; ifl++)
  {
    for (i=1; i<=nlf_fleet(ifl); i++)
    {
      iyr = yr_fleet_lf(ifl,i);
      R_out << iyr << " "
            << ifl << " "
            << fleet_lf_pred(ifl,iyr)<<endl;
    }
  }    
  R_out<<"fleet_lf_effN"<<endl;
  for (int ifl=1; ifl<=nfleet; ifl++)
  {
    for (i=1; i<=nlf_fleet(ifl); i++)
    {
      iyr = yr_fleet_lf(ifl,i);
      R_out << iyr << " "
            << ifl << " "
            << eff_N(fleet_lf_obs(ifl,i),fleet_lf_pred(ifl,iyr) )<<endl;
    }
  }    
  R_out << "norm_res_fleet_lf"<<endl;
  dvector nr(1,nclass);
  dvector ep(1,nclass);
  for (int ifl=1; ifl<=nfleet; ifl++)
  {
    for (i=1; i<=nlf_fleet(ifl); i++)
    {
      iyr = yr_fleet_lf(ifl,i);
      ep  = value(fleet_lf_pred(ifl,iyr)) ;
      nr  = norm_res( ep , fleet_lf_obs(ifl,i) , ss_fleet_lf(ifl,i) ) ;
      R_out << iyr       << " "
            << ifl       << " "
            << std_dev(nr) << " "
            << nr        << " "
            << endl;
    }
  }
  /*R_out << "sdnr_fleet"<<endl;
  for (int ifl=1; ifl<=nfleet; ifl++)
  {
    for (i=1; i<=nlf_fleet(ifl); i++)
    {
      iyr = yr_fleet_lf(ifl,i);
      R_out << sdnr( fleet_lf_pred(ifl,iyr) , fleet_lf_obs(ifl,i) , ss_fleet_lf(ifl,i) ) << endl;
    }
  }
  */
  writeR(nsurvey);
  writeR(yr_survey_lf);
  writeR(survey_num_pred);
  writeR(survey_num_obs);
  writeR(survey_biom_pred);
  writeR(survey_biom_obs);
  writeR(nlf_survey);
  // writeR(survey_names);
  // writeR(survey_lf_obs);
  R_out<<"survey_lf_obs"<<endl;
  for (int ifl=1; ifl<=nsurvey; ifl++)
  {
    for (i=1; i<=nlf_survey(ifl); i++)
    {
      iyr = yr_survey_lf(ifl,i);
      R_out << iyr << " "
            << ifl << " "
            << survey_lf_obs(ifl,i)<<endl;
    }
  }
  R_out<<"survey_lf_pred"<<endl;
  for (int ifl=1; ifl<=nsurvey; ifl++)
  {
    for (i=1; i<=nlf_survey(ifl); i++)
    {
      iyr = yr_survey_lf(ifl,i);
      R_out << iyr << " "
            << ifl << " "
            << survey_lf_pred(ifl,i)<<endl;
    }
  }
  // writeR(survey_lf_pred);
  for (int ifl=1; ifl<=nfleet_act; ifl++)
  {
    R_out<<"exp_rate_"<<fleet_ind_act(ifl)<<endl;
    for (iyr=styr; iyr<=endyr; iyr++)
      R_out << iyr<<" "<< exp_rate(ifl,iyr)<<endl;;
  }  
  for (int ifl=1; ifl<=nfleet_act; ifl++)
  {
    R_out<<"select_fish_"<<fleet_ind_act(ifl)<<endl;
    for (iyr=styr; iyr<=endyr; iyr++)
      R_out << iyr<<" "<< selex_fleet(ifl,iyr)<<endl;;
    }  
}

void model_parameters::final_calcs()
{
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
  // Additional R output: needs Hessian to print
  R_out<<"Recruits"<<endl; for (iyr=styr;iyr<=endyr;iyr++) 
  {
    double lb=value(recruits(iyr)/exp(2.*sqrt(log(1+square(recruits.sd(iyr))/square(recruits(iyr))))));
    double ub=value(recruits(iyr)*exp(2.*sqrt(log(1+square(recruits.sd(iyr))/square(recruits(iyr))))));
    R_out << iyr <<" "<<recruits(iyr)<<" "<<recruits.sd(iyr)<<" "<<lb<<" "<<ub<<endl;
  }
  R_out<<"mmbio"<<endl; for (iyr=styr;iyr<=endyr;iyr++) 
  {
    double lb=value(mbio(iyr)/exp(2.*sqrt(log(1+square(mbio.sd(iyr))/square(mbio(iyr))))));
    double ub=value(mbio(iyr)*exp(2.*sqrt(log(1+square(mbio.sd(iyr))/square(mbio(iyr))))));
    R_out << iyr <<" "<<mbio(iyr)<<" "<<mbio.sd(iyr)<<" "<<lb<<" "<<ub<<endl;
  }
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

void model_parameters::preliminary_calculations(void){
#if defined(USE_ADPVM)

  admaster_slave_variable_interface(*this);

#endif
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

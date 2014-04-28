// =========================================================================================================                                   
//   Gmacs: Generalized Modeling for Alaskan Crab Stocks.
//
//   Authors: Athol Whitten and Jim Ianelli
//            University of Washington, Seattle
//            and Alaska Fisheries Science Centre, NOAA, Seattle
//
//   Info: https://github.com/awhitten/gmacs or write to whittena@uw.edu
//   Copyright (c) 2014. All rights reserved.
//
//   Acknowledgement: The format of this code, and many of the details,
//   were adapted from code developed for the NPFMC by Andre Punt (2012), 
//   and on the 'LSMR' model by Steven Martell (2011).
//
//  TO DO LIST:
//  - Extend numbers-at-length matrix...dimensioned by year, maturity, shell condition, sex, size bin
//  - Add routine to calculate reference points
//  - Add forecast routine
//  - Add warning section: use macro for warning(object,text)
//  - Add section to write new data/control files (enable easy labelling after first model attempt)
//  - Add simulation option, see LSMR model for demonstration
// =========================================================================================================

GLOBALS_SECTION
  #include <admodel.h>
  #include <time.h>
  #include <contrib.h>
  #include <../../cstar/src/cstar.h>
 
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

  
// =========================================================================================================
TOP_OF_MAIN_SECTION
  time(&start);
  arrmblsize = 50000000;
  gradient_structure::set_GRADSTACK_BUFFER_SIZE(1.e7);
  gradient_structure::set_CMPDIF_BUFFER_SIZE(1.e7);
  gradient_structure::set_MAX_NVAR_OFFSET(5000);
  gradient_structure::set_NUM_DEPENDENT_VARIABLES(5000);

// =========================================================================================================
DATA_SECTION
  // Create strings with version information:
  !! version+="Gmacs_V1.05_2014/03/31_by_Athol_Whitten_and_Jim_Ianelli_using_ADMB_11.1";
  !! version_short+="Gmacs V1.05";
  !! echoinput << version << endl;
  !! echoinput << ctime(&start) << endl;

  // Declare global increment values for likelihoods calculations:
  number incc 
  number incd 
  !! incc = 0.00001; ///< Constant for likelihoods
  !! incd = 0.0001;  ///< Constant for likelihoods

// ---------------------------------------------------------------------------------------------------------
// STARTER FILE
  // Open Starter file (starter.gm)
  !! ad_comm::change_datafile_name("starter.gm"); 
  !! cout << " Reading information from starter file" << endl;
  !! echoinput << " Start reading starter file" << endl;

  // Read data, control, and size transition file names, then echo:
  init_adstring data_file;
  init_adstring control_file;
  init_adstring size_trans_file;

  !! echotxt(data_file, "data file");
  !! echotxt(control_file, "control file");

  // Read various option values, then echo:
  init_int verbose;            // Display detail to screen (option 1/0)
  init_int final_phase;        // Stop estimation after this phase
  init_int use_pin;            // Use a .pin file to get initial parameters (option 1/0)
  init_int read_growth;        // Read growth transition matrix file (option 1/0)

  !! echotxt(verbose, " display detail");
  !! echotxt(final_phase, " final phase");
  !! echotxt(use_pin, " use parameter in file (*.pin)");
  !! echotxt(read_growth, " read growth transition matrix data file");

  // Print EOF confirmation to screen and echoinput, warn otherwise:
  init_int eof_starter;

  !! if(eof_starter!=999) {cerr << " Error reading starter file \n EOF = "<< eof_starter << endl; exit(1);}
  !! cout << " Finished reading starter file \n" << endl;
  !! echotxt(eof_starter," EOF: finished reading starter file \n");

// ---------------------------------------------------------------------------------------------------------
// DATA FILE (MAIN)
  // Open main data file (*.dat):
  !! ad_comm::change_datafile_name(data_file);
  !! cout << " Reading main data file" << endl;
  !! echoinput << " Start reading main data file" << endl;

  // Initialize some counters:
  int i; 
  int j;
  int iyr;
  int iclass;
  int jclass;
  int ifleet;
  int isurvey;
  int last;
  
  // ......................................................................
  // Read input from main data file, establish dimensions:
  
  init_int styr;        ///< Start year
  init_int endyr;       ///< End year
  init_number tstep;    ///< Time-step
  init_int ndata;       ///< Number of data groups
  
  !! echotxt(styr,    " Start year");
  !! echotxt(endyr,   " End year");
  !! echotxt(tstep,   " Time-step");
  !! echotxt(ndata,    " Number of fleet data groups");
  
  init_int nsex;        ///< Number of sexes  
  init_int nshell;      ///< Number of shell condition types
  init_int nmature;     ///< Number of maturity types

  init_int nclass;      ///< Number of size classes (in the model)
  init_int ndclass;     ///< Number of size classes (in the data)

  !! echotxt(nsex,    " Number of sexes");
  !! echotxt(nshell,  " Number of shell types");
  !! echotxt(nmature, " Number of maturity types");

  !! echotxt(nclass,  " Number of size classes for model");
  !! echotxt(ndclass, " Number of size classes for data");

  // Determine number of columns for wide N matrix, and positions of sex, shell, and maturity sections.
  !! int ncol = nsex * nshell * nmature * nclass;
  !! int npshell = nsex * nshell;
  !! int npmature = nsex * nshell * nmature;

  ivector psex(1,nsex);
  ivector pshell(1,npshell);
  ivector pmature(1,npmature);

  !! psex.fill_seqadd(1,(ncol/nsex));
  !! pshell.fill_seqadd(1,(ncol/npshell));
  !! pmature.fill_seqadd(1,(ncol/npmature));

  !! echo(ncol);
  !! echo(psex);
  !! echo(pshell);
  !! echo(pmature);

  // ......................................................................    
  // Initialize class link matrix and fill as necessary:
  matrix class_link(1,nclass,1,2);      ///< Matrix of links between model and data size-classes
 
  // If number of data classes is not equal to, or a factor of model classes, read class link matrix from data file.
 LOC_CALCS  
  double class_div = double(ndclass)/double(nclass);
  int class_int = class_div;

  if(class_div!=class_int)
  {
    *(ad_comm::global_datafile) >> class_link;
  }
  // Otherwise, fill each column of class link matrix with sequential numbers.
  else
  {
    // Links are 1:1 when ndclass is equal to nclass:
    if(ndclass==nclass)
    {
      ivector class_link_col(1,nclass);       
      class_link_col.fill_seqadd(1,1);    
      class_link.colfill(1,class_link_col);
      class_link.colfill(2,class_link_col);
    }
    
    // Else, links are function of the number of data vs. model classes:
    else
    {
      ivector class_link_col_a(1,nclass);       
      ivector class_link_col_b(1,nclass);
      class_link_col_a.fill_seqadd(1,class_int);    
      class_link_col_b.fill_seqadd(class_int,class_int);
      class_link.colfill(1,class_link_col_a);
      class_link.colfill(2,class_link_col_b); 
    }
  }
 END_CALCS

  !! echotxt(class_div, " Class divisor");
  !! echotxt(class_int, " Rounded class divisor");
  !! echo(class_link);

  // ......................................................................    
  // Read fleet control matrix and determine data vs. fleet specs:  
  // Column 1 = Data group, 2 = Data type, 3 = Units, 4 = Multiplier.
  // NOTE: Each 'data component' needs to be indexed separately, for input data file indexing.
  
  init_imatrix fleet_control(1,ndata,1,4);  ///< Fleet control matrix

  int nfleet_ret;                           ///< Number of fleets for retained catch data
  int nfleet_dis;                           ///< Number of fleets for discarded catch data (with link to above retained catch)
  int nfleet_byc;                           ///< Number of fleets for bycatch data only
  int nfleet_sur;                           ///< Number of survey fleets (with index of abundance data)
  int nfleet_act;                           ///< Number of active distinct fleets
  int nfleet_cat;                           ///< Number of fleets with catch

 LOC_CALCS
    nfleet_ret = 0;
    nfleet_dis = 0;
    nfleet_byc = 0;
    nfleet_sur = 0;

    for (int idata=1; idata<=ndata; idata++)
    {
      switch (fleet_control(idata,2)) 
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
        case 4 :
          nfleet_sur += 1;
          break;
      } 
    } 
    
    nfleet_act = nfleet_ret + nfleet_byc;       ///< Number of active distinct fishing fleets
    nfleet_cat = nfleet_act + nfleet_dis;       ///< Number of fleets with catch      
  echo(fleet_control);
  echo(nfleet_cat);
  echo(nfleet_ret);
  echo(nfleet_byc);
  echo(nfleet_act);
  echo(nfleet_sur);

 END_CALCS

  // TODO: Check 'fleet numbers' and use of those: Mapping for 'fleets with surveys' and 'surveys with catch' required. 

  // ......................................................................
  // Get data group numbers for fishing, active, and survey fleets:

  ivector fleet_cat_ind(1,nfleet_cat);     ///< Fleet index to map active fleet to all fleets
  !! int icat=0; 
  !! for (i=1; i<=ndata; i++) if(fleet_control(i,2)!=4) {icat++; fleet_cat_ind(icat)=i;}
  !! echo(fleet_cat_ind);

  ivector fleet_act_ind(1,nfleet_act);    ///< Fleet index to map active fleet to all fleets
  !! int iact=0; 
  !! for (i=1; i<=ndata; i++) if(fleet_control(i,2)==1 || fleet_control(i,2)==3) {iact++; fleet_act_ind(iact)=i;}
  !! echo(fleet_act_ind);

  ivector fleet_sur_ind(1,nfleet_sur);    ///< Fleet index to map survey fleets to all fleets
  !! int isur=0; 
  !! for (i=1; i<=ndata; i++) if(fleet_control(i,2)==4) {isur++; fleet_sur_ind(isur)=i;}
  !! echo(fleet_sur_ind);

  // ......................................................................
  // Create fleet/survey counter objects.
  // Get catch/survey units and multipliers (from fleet control matrix):
  
  int nfleet;                         ///< Number of fleets with catch data (fishing fleets)
  int nsurvey;                        ///< Number of fleets with survey data (survey fleets)
  !!  nfleet = nfleet_cat;         
  !!  nsurvey = nfleet_sur;       

  ivector catch_units(1,nfleet);      ///< Catch units (fleets with discard or retained catch) [1=biomass (tons); 2=numbers]
  ivector catch_multi(1,nfleet);      ///< Additional catch scaling multipliers [1 for no effect]
  ivector survey_units(1,nsurvey);    ///< Survey units [1=biomass (tons); 2=numbers]
  ivector survey_multi(1,nsurvey);    ///< Additional survey scaling multipliers [1 for no effect]

 LOC_CALCS
  for(ifleet=1; ifleet<=nfleet; ifleet++)
  {
    catch_units(ifleet) = fleet_control(fleet_cat_ind(ifleet),3);
    catch_multi(ifleet) = fleet_control(fleet_cat_ind(ifleet),4);
  }
  
  for(isurvey=1; isurvey<=nsurvey; isurvey++)
  {
    survey_units(isurvey) = fleet_control(fleet_sur_ind(isurvey),3);
    survey_multi(isurvey) = fleet_control(fleet_sur_ind(isurvey),4);
  }

  echo(catch_units);
  echo(catch_multi);
  echo(survey_units);
  echo(survey_multi);
 END_CALCS

  // TODO: Make it possible for fishing fleets to have survey data, and survey fleets to have catch. 
  // Tricky with selectivity and survey_q etc. 
  // This is possible now but selectivity types need to be entered for each group. 
  // Selectivity can be the same for those fleets by using the same block numbers (mirroring).

  // ......................................................................
  // Get fishing fleet names and survey names and process text strings:

  imatrix iname_flt(1,nfleet,1,2);    ///< Fleet names
  imatrix iname_srv(1,nfleet,1,2);    ///< Survey names
  init_adstring name_read_flt;        
  init_adstring name_read_srv;   
 
  // Convert read-in strings of fishery and survey names to a string array (so they can be indexed).
  // Set whole array equal to 1 in case not enough names are read:
 LOC_CALCS
  int k;
  for(k=1; k<=nfleet; k++) 
  {
    iname_flt(k,1)=1; 
    iname_flt(k,2)=1;
  }    
  
  // Blank to terminate lines (check why this is needed...)
  adstring_array CRLF;   
  CRLF+="";
  
  k=1;
  for(i=1; i<=strlen(name_read_flt); i++)
  {
    if(adstring(name_read_flt(i))==adstring(":")) 
    {
      iname_flt(k,2)=i-1; 
      k++;  
      iname_flt(k,1)=i+1;
    }
  }
  
  iname_flt(nfleet,2)=strlen(name_read_flt);
  for(k=1; k<=nfleet; k++)
  {
    fleet_names += name_read_flt(iname_flt(k,1), iname_flt(k,2))+CRLF(1);
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
 END_CALCS

  // TODO: Create way to return an error if names not formatted properly.
  !! echo(fleet_names);
  !! echo(survey_names);

  // ......................................................................  
  // Read in catch and survey data:
  // TODO: Catch data could also include catches from 'survey fleets', code needs updating to reflect this.

  init_int ncatch_obs;                        ///< Number of catch lines to read
  init_int nsurvey_obs;                       ///< Number of survey lines to read
  init_number survey_time;                    ///< Time between survey and fishery (for projections)

  !! echotxt(ncatch_obs,   " Number of lines of catch data");
  !! echotxt(nsurvey_obs,  " Number of lines of survey data")
  !! echotxt(survey_time,  " Time between survey and fishery");

  init_matrix catch_data(1,ncatch_obs,1,5);       ///< Catch data matrix, one line per ncatch_obs, requires year, season, fleet, observation
  init_matrix survey_data(1,nsurvey_obs,1,6);     ///< Survey data matrix, one line per nsurvey_obs, requires year, season, survey, observation, and error
  
  !! echo(catch_data);
  !! echo(survey_data);  
  
  // ......................................................................  
  // Fill catch observations objects:
  // TODO: Currently survey data is read in ragged, but catch data assumes zeros where years have no data. 
  // Make catch ragged too: Requires nobs_catch as per nobs_survey.
  // Survey data is also read conditionally for object specified (num or bio), repeat for catch.

  matrix catch_biom_obs(1,nfleet,styr,endyr) ;
  matrix catch_num_obs(1,nfleet,styr,endyr) ;

 LOC_CALCS
  catch_biom_obs.initialize();
  catch_num_obs.initialize();
  for (int i=1;i<=ncatch_obs;i++)
  {
    catch_biom_obs(catch_data(i,3),catch_data(i,1)) = catch_data(i,5);
    catch_num_obs(catch_data(i,3),catch_data(i,1))  = catch_data(i,5);
  }
  check(catch_biom_obs);
  check(catch_num_obs);
 END_CALCS

  // ......................................................................  
  // Fill survey observation objects:

  ivector nobs_survey(1,nsurvey);                       ///< Total counter for number of obs. within each survey
 
 LOC_CALCS
  nobs_survey.initialize();
  for (int i=1; i<=nsurvey_obs; i++)
    nobs_survey(survey_data(i,3))++;
  check(nobs_survey);
 END_CALCS

  imatrix yr_survey(1,nsurvey,1,nobs_survey);           ///< Years for each survey observation
  matrix survey_biom_obs(1,nsurvey,1,nobs_survey);      ///< Survey observations (biomass)
  matrix survey_num_obs(1,nsurvey,1,nobs_survey);       ///< Survey obeservation (numbers)
  matrix survey_var(1,nsurvey,1,nobs_survey);           ///< Survey variance values
 
 LOC_CALCS
  survey_var.initialize();
  survey_biom_obs.initialize();
  survey_num_obs.initialize(); 
  ivector iobs_sv(1,nsurvey);                           ///< Incremental counter for obs. no. within each survey
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
    survey_var(isrv,iobs_sv(isrv)) = log(1+square(survey_data(i,6))); 
    // For likelihood, compute input variance here, assumes input as CV.
  }  

  for (isurvey=1; isurvey<=nsurvey; isurvey++)
  {
    for (int i=1; i<=nobs_survey(isurvey); i++)
    { 
      survey_biom_obs(isurvey,i) *= survey_multi(isurvey);
      survey_num_obs(isurvey,i)  *= survey_multi(isurvey);
    }
  }
  check(iobs_sv);
  check(survey_var);
  check(survey_num_obs);
  check(survey_biom_obs);
 END_CALCS

  // ......................................................................  
  // Read in fishing related objects:

  init_vector discard_mort(1,nfleet);               ///< Discard mortality (per fishery)
  init_vector hg(styr,endyr);                       ///< Retention value for each year (highgrading)
  init_matrix catch_time(1,nfleet_act,styr,endyr);  ///< Timing of each fishery (as fraction of time-step)
  init_matrix effort(1,nfleet_act,styr,endyr);      ///< Effort by fishery
  init_imatrix f_new(1,nfleet_act,1,5);             ///< Alternative f estimators (overwrite others)

 LOC_CALCS
  echo(discard_mort);
  echo(hg);
  echo(catch_time);
  echo(effort);
  echo(f_new);

  for (ifleet=1; ifleet<=nfleet; ifleet++)
  {
    for (iyr=styr; iyr<=endyr; iyr++)
    { 
     catch_biom_obs(ifleet,iyr) *= discard_mort(ifleet) * catch_multi(ifleet);
     catch_num_obs(ifleet,iyr) *= discard_mort(ifleet) * catch_multi(ifleet);
    }
  }
 END_CALCS

  // Determine which F values will be computed using effort (f_new) if applicable: 
  ivector ncatch_f(1,nfleet_act);
 
 LOC_CALCS
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
 END_CALCS
  
  !! echotxt(ncatch_f, " Number of F's (calculated)")
  
  // ......................................................................  
  // Read in LF data:

  init_int nlf_obs;                                      ///< Number of length frequency lines to read for fishing fleets 
  init_matrix lf_data(1,nlf_obs,1,ndclass+7);            ///< Length frequency data, one line per nlf_obs, requires year, season, fleet, sex, maturity, shell cond., effective sample size, then data vector 
  ivector nlf_fleet(1,nfleet);                           ///< Number of years of lf data per fleet
 
 LOC_CALCS 
  nlf_fleet.initialize();
  for (int i=1; i<=nlf_obs; i++) 
  {
    nlf_fleet(int(lf_data(i,3)))++ ;
  }
 END_CALCS
  
  imatrix yr_fleet_lf(1,nfleet,1,nlf_fleet);             ///< Years with lf data, by fleet
  matrix ss_fleet_lf(1,nfleet,1,nlf_fleet);              ///< Effective sample sizes, by fleet
  3darray fleet_lf(1,nfleet,1,nlf_fleet,1,ndclass);      ///< Length-frequency data (ndclass), by fleet (can be ragged array)
  3darray fleet_lf_obs(1,nfleet,1,nlf_fleet,1,nclass);   ///< Length-frequency data (nclass), by fleet (can be ragged array)
 
// TODO DIMS: The counter for fleets below may need to be extended to sexes, shell conds, and mat stages.
// Some type of counter will be required to determine which types of data are present for each fishery (with which dimensions).
// This will mean data can be entered into Gmacs in a flat format.

 LOC_CALCS 
  ivector iobs_fl(1,nfleet);                             ///< Incremental counter for obs. no. within each fleet
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
 END_CALCS

  // TODO: Simple.tpl down-weighted sample sizes w/in the code. Check this.

  !! echotxt(nlf_obs,  " Number of length freq lines to read");
  !! echo(lf_data);
  !! echo(nlf_fleet);
  !! echo(yr_fleet_lf);
  !! echo(ss_fleet_lf);
  !! echo(fleet_lf_obs);
  
  // ......................................................................  
  // Read in LF data (survey):

  init_int nlfs_obs;                                ///< Number of survey length frequency lines to read
  init_matrix lfs_data(1,nlfs_obs,1,ndclass+5);     ///< Survey length frequency data, one line per nlfs_obs, requires year, season, survey, sex, effective sample size, then data vector
  ivector nlf_survey(1,nsurvey);                    ///< Number of years of survey lf data per survey

 LOC_CALCS 
  nlf_survey.initialize();
  for (int i=1; i<=nlfs_obs; i++) 
  {
    nlf_survey(int(lfs_data(i,3)))++ ;
  }
 END_CALCS
  
  imatrix yr_survey_lf(1,nsurvey,1,nlf_survey);                ///< Years with lf data, by survey
  matrix ss_survey_lf(1,nsurvey,1,nlf_survey);                 ///< Effective sample sizes, by survey
  3darray survey_lf(1,nsurvey,1,nlf_survey,1,ndclass);         ///< Length-frequency data (ndclass), by survey (can be ragged array)
  3darray survey_lf_obs(1,nsurvey,1,nlf_survey,1,nclass);      ///< Length-frequency data (nclass), by survey (can be ragged array)
 
 LOC_CALCS 
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
 END_CALCS

  !! echotxt(nlfs_obs, " Number of survey length freq lines to read");
  !! echo(lfs_data);
  !! echo(nlf_survey);
  !! echo(yr_survey_lf);
  !! echo(ss_survey_lf);
  !! echo(survey_lf_obs);

  // ......................................................................  
  // Read in length, weight, fecundity vectors, then calculate equivalent vectors with nclass number of size-classes:
  
  init_vector mean_length(1,ndclass);       ///< Mean length vector input
  init_vector mean_weight(1,ndclass);       ///< Mean weight vector input
  init_vector fecundity_inp(1,ndclass);     ///< Fecundity vector input

  !! echo(mean_length);
  !! echo(mean_weight);
  !! echo(fecundity_inp);

  // Recaclulate length, weight, and fecundity vectors to specified number of model size-classes:
  vector length(1,nclass);                  ///< Length vector (mm) for model
  vector weight(1,nclass);                  ///< Weight (kg) vector for model
  vector fecundity(1,nclass);               ///< Fecundity (kg) vector for model
  vector surv_lf_store(1,ndclass);          ///< Survey lf total by data class
   
 LOC_CALCS
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
    check(surv_lf_store);
    if (verbose == 1) cout << "Survey total frequency samples by length-class stored" << endl;

    checkfile << "class-specific length, weight, and fecundity (columns)" << endl;
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
 END_CALCS

  // NOTE: surv_lf_store is the sum over all years of LF data for each of ndclasses.
  // Thus it stores the aggregated length-frequency information over all years.
  // It is used to weight averages among size-classes during re-calculation between ndclasses and nclasses. 
  // CHECK: If mean-length increases linearly with size-class, should this feature be retained with the new mean-length numbers?

  // ......................................................................  
  // Read in capture, mark, recapture data:
  
  init_int ncapture_obs;                           ///< Number of capture data lines to read    
  init_int nmark_obs;                              ///< Number of mark data lines to read
  init_int nrecapture_obs;                         ///< Number of recapture data lines to read

  init_matrix capture_data(1,ncapture_obs,1,ndclass+3);         ///< Capture data, one line per ncapture_obs, requires years, fleet, sex, then data vector
  init_matrix mark_data(1,nmark_obs,1,ndclass+3);               ///< Mark data, one line per nmark_obs, requires years, fleet, sex, then data vector
  init_matrix recapture_data(1,nrecapture_obs,1,ndclass+3);     ///< Recapture data, one line per nrecapture_obs, requires years, fleet, sex, then data vector

  !! echotxt(ncapture_obs,   " Number of capture data lines");
  !! echotxt(nmark_obs,      " Number of mark data lines");
  !! echotxt(nrecapture_obs, " Number of recapture data lines")

  // Echo capture, mark, recapture data when appropriate:
 LOC_CALCS
  if(ncapture_obs > 0) 
  {
    echo(capture_data);
    echo(mark_data);
    echo(recapture_data);
  }
 END_CALCS
  
  // ......................................................................  
  // Print EOF confirmation to screen and echoinput, warn otherwise:
  init_int eof_data;
  
  !! if(eof_data!=999) {cout << " Error reading main data file \n EOF = "<< eof_data << endl; exit(1);}
  !! cout << " Finished reading main data file \n" << endl;
  !! echotxt(eof_data," EOF: finished reading main data file \n");

  
// ---------------------------------------------------------------------------------------------------------
// DATA FILE (GROWTH)
// This section is conditional on starter file flag (read growth matrix data file).
  
  // Declare objects to read in from growth data file:
  int styr_growth;        ///< Start year for growth data
  int endyr_growth;       ///< End year for growth data
  int ndclass_growth;     ///< Number of data classes for growth data

  !! ndclass_growth = 0;

 LOC_CALCS
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
 END_CALCS
  
  // Declare objects dependent on previous objects:
  ivector growth_bins(1,ndclass_growth);                                                  ///< Vector of growth data bins (lower length of each bin)
  3darray growth_data(styr_growth,endyr_growth,1,ndclass_growth-1,1,ndclass_growth-1);    ///< Array of year specific growth transition matrices  
  
  int eof_growth;    // Declare EOF check

 LOC_CALCS
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
 END_CALCS

// ---------------------------------------------------------------------------------------------------------
// CONTROL FILE

  // Open control file (*.ctl) //
  !! ad_comm::change_datafile_name(control_file);
  !! cout << " Reading control file" << endl;
  !! echoinput << " Start reading control file" << endl;
  
  // Specifiy number of general parameters to be read in:
  int ntheta;
  !! ntheta = 2;
  // TODO: When extending theta control options, remember to change this number.
  
  // Read general input from control file:
  init_matrix theta_control(1,ntheta,1,13);     ///< General parameter matrix, with specifications
  matrix trans_theta_control(1,13,1,ntheta);    ///< Transpose of general parameter matrix
  vector theta_init(1,ntheta);                  ///< Vector of general parameter specs - initial values
  vector theta_lbnd(1,ntheta);                  ///< Vector of general parameter specs - lower bound values
  vector theta_ubnd(1,ntheta);                  ///< Vector of general parameter specs - upper bound values        
  ivector theta_phz(1,ntheta);                  ///< Vector of general parameter specs - phase values
  ivector theta_prior(1,ntheta);                ///< Vector of general parameter specs - prior type
  vector theta_pmean(1,ntheta);                 ///< Vector of general parameter specs - prior mean values
  vector theta_psd(1,ntheta);                   ///< Vector of general parameter specs - prior s.d. values
  ivector theta_cov(1,ntheta);                  ///< Vector of general parameter specs - covariate type
  ivector theta_dev(1,ntheta);                  ///< Vector of general parameter specs - deviation type
  vector theta_dsd(1,ntheta);                   ///< Vector of general parameter specs - deviation s.d.
  ivector theta_dmin(1,ntheta);                 ///< Vector of general parameter specs - deviation min. year
  ivector theta_dmax(1,ntheta);                 ///< Vector of general parameter specs - deviation max. year
  ivector theta_blk(1,ntheta);                  ///< Vector of general parameter specs - block number (for time-varying paramters)

  !! echo(theta_control);

  // Fill matrices and vectors created above:
 LOC_CALCS
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
 END_CALCS

  // Read in specifications relating to initial population and recruitment:
  init_int init_n;                              ///< Form of initial numbers routine (estimate numbers or early recruits)
  init_int sr_type;                             ///< Form of stock recruitment relationship
  init_int sr_lag;                              ///< Lag to recruitment
  
  !! echotxt(init_n,   " Form of initial numbers routine");
  !! echotxt(sr_type,  " Form of stock-recruitment relationship");
  !! echotxt(sr_lag,   " Lag to recruitment (years)");

  // Determine years over which to estimate recruitment:
  int rinit;                                  ///< Number of initial recruitments to estimate
  int rstyr;                                  ///< Year to start estimating recruitments
  
 LOC_CALCS
  rinit=0;
  rstyr=styr;
  if(init_n==2 || init_n==3 || init_n==4)
  {
    *(ad_comm::global_datafile) >> rinit;
    rstyr -= rinit;
  }
  echotxt(rinit,  " Number of initial recruitments");
  echotxt(rstyr,  " Start year for estimated recruitment");
 END_CALCS

  // Read in pointers for time-varying natural mortality:
  vector M_pnt(styr,endyr);                     ///< Pointers to blocks for time-varying natural mortality
  int nMadd_parms;                              ///< Number of M additional parameters
 LOC_CALCS
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
 END_CALCS
  
  // Read in naturaly mortality parameter specifications:
  matrix Madd_control(1,nMadd_parms,1,4);       ///< Natural mort. parameter matrix, with speciifications           
  // init_matrix Madd_control(1,nMadd_parms,1,4);       ///< Natural mort. parameter matrix, with speciifications           
  matrix trans_Madd_control(1,4,1,nMadd_parms);      ///< Transponse of natural mort. parameter matrix    
  vector Madd_init(1,nMadd_parms);                   ///< Vector of natural mort. parameter specs - initial values  
  vector Madd_lbnd(1,nMadd_parms);                   ///< Vector of natural mort. parameter specs - lower bounds
  vector Madd_ubnd(1,nMadd_parms);                   ///< Vector of natural mort. parameter specs - upper bounds      
  ivector Madd_phz(1,nMadd_parms);                   ///< Vector of natural mort. parameter specs - phase values


  // Fill matrices and vectors created above:
 LOC_CALCS
    if (theta_blk(2)>0)
    {
      for (int i=1;i<=nMadd_parms;i++) *(ad_comm::global_datafile) >> Madd_control(i) ;
      trans_Madd_control = trans(Madd_control);
      Madd_init = trans_Madd_control(1);
      Madd_lbnd = trans_Madd_control(2);
      Madd_ubnd = trans_Madd_control(3);
      Madd_phz = ivector(trans_Madd_control(4));
    }
    else
    {
      nMadd_parms = 1;
      Madd_lbnd = 0.;
      Madd_ubnd = 1.;
      Madd_phz   = -1;
      Madd_init = 0.0;
      Madd_control.initialize();
    }
  echo(Madd_control);
  echo(Madd_init);
  echo(Madd_ubnd);
  echo(Madd_lbnd);
  echo(Madd_phz);
 END_CALCS

  // Read in pointers for time-varying fishery and survey selectivity:
  init_imatrix selex_fleet_pnt(1,nfleet_act,styr,endyr);          ///< Pointers to blocks for time-varying fishing selectivity
  init_imatrix selex_survey_pnt(1,nsurvey,styr,endyr+1);          ///< Pointers to blocks for time-varying survey selectivity

  !! echo(selex_fleet_pnt);
  !! echo(selex_survey_pnt);

  // Determine number of different selectivity functions/patterns to estimate:
  int nselex;
  int nselex_pats;
  int nselex_pars;

  !! nselex_pats = max(selex_survey_pnt);
  !! echotxt(nselex_pats, " Total number of selectivity patterns");

  // Read in specifications for each selectivity pattern and determine number of parameters to estimate:
  matrix selex_type(1,nselex_pats,1,4);    ///< Selectivity types for each fleet/survey by time-block
  
LOC_CALCS
  nselex = 0;
  selex_type = 0;
  for (int i=1; i<=nselex_pats; i++)
  {
    *(ad_comm::global_datafile) >> selex_type(i,1) >> selex_type(i,2) >> selex_type(i,3);
    if (selex_type(i,2) == 1) nselex += nclass;
    if (selex_type(i,2) == 2) nselex += 2;
    if (selex_type(i,2) == 3) nselex += 2;
  }
  nselex_pars = nselex;
  echo(selex_type);
  echotxt(nselex_pars, " Total number of selectivity parameters");

  // Fill last column of selex_type matrix, for use in Set_selex function.
  last = 0;
  int psel = 0;
  for (j=1; j<=nselex_pats; j++)
  {
    selex_type(j,4) = psel;
    if (selex_type(j,2)==1) last = nclass;
    if (selex_type(j,2)==2) last = 2;
    if (selex_type(j,2)==3) last = 2;
    psel += last;
  }
  check(selex_type);
 END_CALCS

  // Read in selectivity parameter specifications:
  init_matrix selex_control(1,nselex_pars,1,4);      ///< Selectivity parameter matrix, with specifications
  matrix trans_selex_control(1,4,1,nselex_pars);     ///< Transpose of selectivity parameter matrix
  vector selex_init(1,nselex_pars);                  ///< Vector of selex parameter specs - initial values
  vector selex_lbnd(1,nselex_pars);                  ///< Vector of selex parameter specs - lower bounds
  vector selex_ubnd(1,nselex_pars);                  ///< Vector of selex parameter specs - upper bounds
  ivector selex_phz(1,nselex_pars);                  ///< Vector of selex parameter specs - phase values
  
  !! echo(selex_control);

  // Fill matrices and vectors created above:
 LOC_CALCS
    trans_selex_control = trans(selex_control);
    selex_init = trans_selex_control(1);
    selex_lbnd = trans_selex_control(2);
    selex_ubnd = trans_selex_control(3);
    selex_phz = ivector(trans_selex_control(4));
    echo(selex_phz);
 END_CALCS

  // Read in pointers for time-varying fishery retention:
  init_imatrix reten_fleet_pnt(1,nfleet_ret,styr,endyr);

  // Determine number of different retention functions/patterns to estimate:
  int nreten;
  int nreten_pats;
  int nreten_pars;

  !! nreten_pats = max(reten_fleet_pnt);
  !! echotxt(nreten_pats, " Total number of retention patterns");

  // Read in specifications for each retention pattern and determine number of parameters to estimate:
  matrix reten_type(1,nreten_pats,1,4);    ///< Retention types for each relevant fleet by time-block
  
LOC_CALCS
  nreten = 0;
  reten_type = 0;
  for (int i=1; i<=nreten_pats; i++)
  {
    *(ad_comm::global_datafile) >> reten_type(i,1) >> reten_type(i,2) >> reten_type(i,3);
    if (reten_type(i,2) == 1) nreten += nclass;
    if (reten_type(i,2) == 2) nreten += 2;
  }

  nreten_pars = nreten;
  echo(reten_type);
  echotxt(nreten_pars, " Total number of retention parameters");

  // Fill last column of reten_type matrix, starting parameter for each retention pattern:
  last = 0;
  int preten = 0;
  for (j=1; j<=nreten_pats; j++)
  {
    reten_type(j,4) = preten;
    if (reten_type(j,2)==1) last = nclass;
    if (reten_type(j,2)==2) last = 2;
    preten += last;
  }
  check(reten_type);
 END_CALCS
  
  // Read in retention parameter specifications:
  init_matrix reten_control(1,nreten_pars,1,4);       ///< Retention parameter matrix, with speciifications           
  matrix trans_reten_control(1,4,1,nreten_pars);      ///< Transponse of retention parameter matrix    
  vector reten_init(1,nreten_pars);                   ///< Vector of retention parameter specs - initial values  
  vector reten_lbnd(1,nreten_pars);                   ///< Vector of retention parameter specs - lower bounds
  vector reten_ubnd(1,nreten_pars);                   ///< Vector of retention parameter specs - upper bounds      
  ivector reten_phz(1,nreten_pars);                   ///< Vector of retention parameter specs - phase values

  !! echo(reten_control);

  // Fill matrices and vectors created above:
 LOC_CALCS
  trans_reten_control = trans(reten_control);
  reten_init = trans_reten_control(1);
  reten_lbnd = trans_reten_control(2);
  reten_ubnd = trans_reten_control(3);
  reten_phz = ivector(trans_reten_control(4));
 END_CALCS

  // Read in pointers for time-varying survey catchability:
  int nsurveyq_pars;
  init_imatrix surveyq_pnt(1,nsurvey,styr,endyr+1);

  !! nsurveyq_pars = max(surveyq_pnt);

  !! echo(surveyq_pnt);
  !! echotxt(nsurveyq_pars, " Total number of survey Q patterns");

  // Read in flag for number of surveys in a sub-area of the main survey area:
  init_int nsubsurvey;
  init_imatrix subsurvey(1,nsubsurvey,1,2);

  !! echotxt(nsubsurvey, " Number of sub-surveys");
  !! if(nsubsurvey > 0) echo(subsurvey);

  // Read in survey catchability parameter specifications:
  init_matrix surveyq_control(1,nsurveyq_pars,1,7);         ///< Survey Q parameter matrix, with speciifications           
    matrix trans_surveyq_control(1,7,1,nsurveyq_pars);      ///< Transponse of survey Q parameter matrix    
    vector surveyq_init(1,nsurveyq_pars);                   ///< Vector of survey Q parameter specs - initial values  
    vector surveyq_lbnd(1,nsurveyq_pars);                   ///< Vector of survey Q parameter specs - lower bounds
    vector surveyq_ubnd(1,nsurveyq_pars);                   ///< Vector of survey Q parameter specs - upper bounds      
    ivector surveyq_phz(1,nsurveyq_pars);                   ///< Vector of survey Q parameter specs - phase values
    ivector surveyq_prior(1,nsurveyq_pars);                 ///< Vector of survey Q parameter specs - prior types
    vector surveyq_pmean(1,nsurveyq_pars);                  ///< Vector of survey Q parameter specs - prior mean values
    vector surveyq_psd(1,nsurveyq_pars);                    ///< Vector of survey Q parameter specs - prior s.d. values

   !! echo(surveyq_control);

  // Fill matrices and vectors created above:
 LOC_CALCS
    trans_surveyq_control = trans(surveyq_control);
    surveyq_init          = trans_surveyq_control(1);
    surveyq_lbnd          = trans_surveyq_control(2);
    surveyq_ubnd          = trans_surveyq_control(3);
    surveyq_phz           = ivector(trans_surveyq_control(4));
    surveyq_prior         = ivector(trans_surveyq_control(5));
    surveyq_pmean         = trans_surveyq_control(6);
    surveyq_psd           = trans_surveyq_control(7);  
 END_CALCS

  // Read in initial N parameter specifications:
  init_matrix lognin_control(1,nclass,1,4);         ///< Initial N parameter matrix, with specifications
  matrix trans_lognin_control(1,4,1,nclass);        ///< Transpose of initial N parameter matrix
  vector lognin_init(1,nclass);                     ///< Vector of initial N parameter specs - initial values
  vector lognin_lbnd(1,nclass);                     ///< Vector of initial N parameter specs - lower bounds
  vector lognin_ubnd(1,nclass);                     ///< Vector of initial N parameter specs - upper bounds
  ivector lognin_phz(1,nclass);                     ///< Vector of initial N parameter specs - phase values
  
  !! echo(lognin_control);

  // Fill matrices and vectors created above:
 LOC_CALCS
    trans_lognin_control = trans(lognin_control);
    lognin_init          = trans_lognin_control(1);
    lognin_lbnd          = trans_lognin_control(2);
    lognin_ubnd          = trans_lognin_control(3);
    lognin_phz           = ivector(trans_lognin_control(4));  
 END_CALCS

  // Read in selectivity parameter specifications:
  init_matrix gtrans_control(1,nclass-1,1,4);        ///< Growth transition parameter matrix, with specifications
  matrix trans_gtrans_control(1,4,1,nclass-1);       ///< Transpose of initial N parameter matrix
  vector gtrans_init(1,nclass-1);                    ///< Vector of growth trans. parameter specs - initial values
  vector gtrans_lbnd(1,nclass-1);                    ///< Vector of growth trans. parameter specs - lower bounds
  vector gtrans_ubnd(1,nclass-1);                    ///< Vector of growth trans. parameter specs - upper bounds
  ivector gtrans_phz(1,nclass-1);                    ///< Vector of growth trans. parameter specs - phase values
  
  !! echo(gtrans_control);

  int nprior_terms;                                                 ///< Number of terms in the prior components
  int nlike_terms;                                                  ///< Number of terms in the likelihood components
  // Determine number of prior terms, and create objects to hold these values:
  !! nprior_terms = (nfleet_act) + 1 + 3 + nsurveyq_pars + 1 + 1;  
  !! nlike_terms = (nfleet)*2+ (nfleet_act) + (nsurvey)*2;
  vector mn_offset(1,nlike_terms);                                  ///< Offset for multinomial calculations
  
  // TODO: Generalise this section to deal with different numbers of fleets.

  // Fill matrices and vectors created above:
 LOC_CALCS
  trans_gtrans_control = trans(gtrans_control);
  gtrans_init = trans_gtrans_control(1);
  gtrans_lbnd = trans_gtrans_control(2);
  gtrans_ubnd = trans_gtrans_control(3);
  gtrans_phz = ivector(trans_gtrans_control(4));  

  for (int ifl=1;ifl<=nfleet_act;ifl++)
    prior_names  += fleet_names(fleet_act_ind(ifl))+"_Fpen"+CRLF(1);
  prior_names  += "recdevs" +CRLF(1);
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

 END_CALCS
    
  // Read in prior and data re-weighting values:  
  init_vector prior_weight(1,nprior_terms);        ///< Weights on the priors
  init_vector like_weight(1,nlike_terms);          ///< Weights on the data

  !! echo(prior_weight);
  !! echo(like_weight);

  // Print EOF confirmation to screen and echoinput, warn otherwise:
  init_int eof_control;

  !! if(eof_control!=999) {cout << " Error reading control file\n EOF = " << eof_control << endl; exit(1);}
  !! cout << " Finished reading control file \n" << endl;
  !! echotxt(eof_data," EOF: finished reading control file \n");

// ---------------------------------------------------------------------------------------------------------
// FORECAST FILE

  // Open forecast file (forecast.gm):
  !! ad_comm::change_datafile_name("forecast.gm");
  !! cout << " Reading forecast file" << endl;
  !! echoinput << " Start reading forecast file" << endl;
  
  init_int bmsy_start;
  init_int bmsy_end;

  !! echotxt(bmsy_start, " BMSY start year");
  !! echotxt(bmsy_end, " BMSY end year");

  // Print EOF confirmation to screen and echoinput, warn otherwise:
  init_int eof_forecast;

  !! if(eof_forecast!=999) {cout << " Error reading forecast file\n EOF = " << eof_forecast << endl; exit(1);}
  !! cout << " Finished reading forecast file \n" << endl;
  !! echotxt(eof_data," EOF: finished reading forecast file \n");

  !! cout << " Successfully read all input files. \n" << endl;

// =========================================================================================================
// GENERAL CALCS SECTION

  // Create count of active parameters and derived quantities:
  int par_count;
  int active_count;
  int active_parms;
  ivector active_parm(0,ntheta);  ///<  Pointer from active list to the element of the full parameter list to get label.
  // TODO: Add active_parm pointer list for labelling active parameters in report file.

  // Adjust the phases to negative if beyond final_phase and find resultant max_phase:
  int max_phase;
 
 LOC_CALCS
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
 END_CALCS
  // TODO: Adjust this section to include other parameters not specified in the general paramter matrix 'theta'.

// =========================================================================================================
INITIALIZATION_SECTION
  theta_parms  theta_init
  // Madd_parms Madd_init;  
  gtrans_parms gtrans_init;
  selex_parms selex_init;
  reten_parms reten_init;
  surveyq_parms surveyq_init;
  lognin_parms lognin_init;
  f_est  0.1;

// =========================================================================================================
PARAMETER_SECTION
  // Initialize general parameter matrix:
  init_bounded_number_vector theta_parms(1,ntheta,theta_lbnd,theta_ubnd,theta_phz);                   ///< Vector of general parameters
  
  // Initialize other parameter matrices:
  init_bounded_number_vector Madd_parms(1,nMadd_parms,Madd_lbnd,Madd_ubnd,Madd_phz);                  ///< Vector of increments in M parameters
  init_bounded_number_vector gtrans_parms(1,nclass-1,gtrans_lbnd,gtrans_ubnd,gtrans_phz);             ///< Vector of growth transition parameters
  init_bounded_number_vector selex_parms(1,nselex_pars,selex_lbnd,selex_ubnd,selex_phz);              ///< Vector of selectivity parameters
  init_bounded_number_vector reten_parms(1,nreten_pars,reten_lbnd,reten_ubnd,reten_phz);              ///< Vector of retention parameters
  init_bounded_number_vector surveyq_parms(1,nsurveyq_pars,surveyq_lbnd,surveyq_ubnd,surveyq_phz);    ///< Vector of survey Q parameters
  init_bounded_number_vector lognin_parms(1,nclass,lognin_lbnd,lognin_ubnd,lognin_phz);               ///< Vector of initial N parameters
  init_bounded_vector_vector f_est(1,nfleet_act,1,ncatch_f,0,1,1);                                    ///< Matrix of predicted F values
  init_vector recdev(rstyr,endyr,1);                                                                  ///< Vector of recruitment deviations
  
  // TODO: Check recdevs as unbounded parameters, these might be better as bounded parameters.
   
  !! check(Madd_parms);
  !! check(Madd_phz);
  !! check(gtrans_parms);
  !! check(gtrans_phz);
  !! check(selex_parms);
  !! check(selex_phz);
  !! check(reten_parms);
  !! check(reten_phz);
  !! check(surveyq_parms);
  !! check(surveyq_phz);
  !! check(lognin_parms);
  !! check(lognin_phz);

  !! cout << " All parameters declared \n" << endl;
  !! checkfile << " All parameters declared" << endl;

  number logRbar;
  number M0;
  // Create model vectors, matrices, and arrays:
  matrix f_all(1,nfleet_act,styr,endyr);                      ///< Fishing mortality matrix 

  matrix N(rstyr,endyr+1,1,nclass);                           ///< Numbers-at-age matrix
  matrix N0(1,nclass*2,1,nclass);                             ///< equilibrium numbers matrix (calculated)
  matrix S(rstyr,endyr,1,nclass);                             ///< Survival matrix (general)
  3darray S_fleet(1,nfleet_act,styr,endyr,1,nclass);          ///< Survival matrices (one for each distinct fishery)
  matrix exp_rate(1,nfleet_act,styr,endyr);                   ///< Exploitation rate matrix
  matrix strans(1,nclass,1,nclass);                           ///< Size-transition matrix
  matrix xtrans(1,nclass,1,nclass);                           ///< Temp size-trans matrix (diagonal only) for testing [!REMOVE!]  
  
  3darray reten(1,nfleet_ret,styr,endyr,1,nclass);            ///< Directed fishery (male) retention array 
  matrix reten_all(1,nreten_pats,1,nclass);                   ///< All retention matrix

  // TODO: The above matrix was retain_males in AEP code. Check if need sex-distinct object(s) for multi-sex model.

  3darray selex_fleet(1,nfleet_act,styr,endyr,1,nclass);      ///< Distinct fishery selectivity array
  3darray selex_survey(1,nsurvey,styr,endyr+1,1,nclass);      ///< Survey selectivity array
  vector surveyq(1,nsurvey);                                  ///< Survey Q vector
  matrix selex_all(1,nselex_pats,1,nclass);                   ///< All selectivity matrix

  3darray fleet_lf_pred(1,nfleet,styr,endyr,1,nclass);        ///< Predicted catches (numbers) by class
  matrix catch_biom_pred(1,nfleet,styr,endyr);                ///< Predicted catch weights
  matrix catch_num_pred(1,nfleet,styr,endyr);                 ///< Predicted catch numbers
  
  3darray survey_lf_pred(1,nsurvey,1,nlf_survey,1,nclass);    ///< Survey LF from the model
  matrix survey_biom_pred(1,nsurvey,1,nobs_survey);           ///< Predicted survey weights
  matrix survey_num_pred(1,nsurvey,1,nobs_survey);            ///< Predicted survey numbers
  vector q_effort(1,nfleet_act);                              ///< Effort q
  vector M(rstyr,endyr);                                      ///< Natural mortality
  vector f_direct(styr,endyr);                                ///< Fishing mortality

  // Values related to the SR relationship
  number f_multi;                                             ///< Passed F multiplier
  number mbio_out;                                            ///< Predicted mature male biomass (MMB)
  number f_35;                                                ///< F35
  number sbpr_35;                                             ///< SBPR35 (used to define BMSY)
  number rec_out;                                             ///< Predicted recruitment  
  number catch_out;                                           ///< Predicted catch
  // vector mbio_proj(1,100);                                 ///< Future MMB (projected)
  // vector f_mort(1,nfleet_byc);                             ///< Bycatch (kill) fleet Fs

  // number rec_zero;                                         ///< Virgin recruitment 
  // number steep;                                            ///< Stock-recruit steepness 
  number mbio_zero;                                           ///< Virgin MMB 
  sdreport_vector mbio(styr,endyr);                           ///< Mature male biomass 
  // vector logmbio(styr,endyr);                              ///< Log of MMB
  sdreport_vector recruits(rstyr,endyr);                      ///< Recruitment vector
  // vector logrecruits(styr,endyr);                          ///< Log of recruitment vector
  // vector logrecmbio(styr,endyr-sr_lag);                    ///< Log of recruits-per-spawner
 
  // Initialize the components of the objective function:
  vector prior_val(1,nprior_terms);                           ///< Objective function prior values
  vector like_val(1,nlike_terms);                             ///< Objective function likelihood values
  objective_function_value ObjFun;                            ///< Objective function value to be minimised

// =========================================================================================================
PROCEDURE_SECTION
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

// ---------------------------------------------------------------------------------------------------------
FUNCTION Set_effort
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

// ---------------------------------------------------------------------------------------------------------
FUNCTION Set_growth
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

// ---------------------------------------------------------------------------------------------------------
FUNCTION Initial_size_structure
  N.initialize();
  N0.initialize();

  // Calculate N0 (initial numbers) from equilibrium recruitment:
  N0(1,1) = mfexp(logRbar);
  for (int irow=1; irow<(nclass*2); irow++)
  {
    // Grow individuals over nclass time-steps:
    for(int iclass=1; iclass<=nclass; iclass++)
      for (int jclass=1; jclass<=nclass; jclass++)
        N0(irow+1,iclass) += strans(jclass,iclass) * N0(irow,jclass) * mfexp(-M0);
  
    // Add recruitment (R0) each time-step:
    N0(irow+1,1) += mfexp(logRbar);   
  }
  // TODO: Is this a good estimate of an equilibrium population? How many years required to get smooth distribution?
  
  // Get initial numbers:
  switch(init_n)
  {
    case 1: // Initial numbers type 1 (estimate initial numbers, one parameter per size-class):
    {  
      N(styr) = mfexp(logRbar+lognin_parms);
      break;
    }

    case 2: // Initial numbers type 2 (estimate early recruits, build initial population from R0):
    {
      // Start build up from single recruitment:
      N(rstyr,1) = mfexp(logRbar);

      for (int iyr=rstyr; iyr<styr; iyr++)
      {
        // Grow individuals over each time step of initial period: 
        for (int iclass=1; iclass<=nclass; iclass++) 
          for (int jclass=1; jclass<=nclass; jclass++)
            N(iyr+1,iclass) += strans(jclass,iclass) * N(iyr,jclass) * S(iyr,jclass);
     
        // Add recruitment for next year:
        recruits(iyr) = mfexp(logRbar+recdev(iyr));
        N(iyr+1,1) += recruits(iyr); 
      }
      break;
    }

    case 3: // Initial numbers type 3 (estimate early recruits, build initial population from N0):
    {      
      // Start build up from equilibrium numbers:
      N(rstyr) = N0(nclass*2);

      for (int iyr=rstyr; iyr<styr; iyr++)
      {
        // Grow individuals over each time step of initial period: 
        for (int iclass=1; iclass<=nclass; iclass++) 
          for (int jclass=1; jclass<=nclass; jclass++)
            N(iyr+1,iclass) += strans(jclass,iclass) * N(iyr,jclass) * S(iyr,jclass);
     
        // Add recruitment for next year:
        recruits(iyr) = mfexp(logRbar+recdev(iyr));
        N(iyr+1,1) += recruits(iyr); 
      }
      break;
    }

    case 4: // Initial numbers type 4 (estimate early recruits, build initial population from R0, no est. growth in pre-model years):
    {      
      // Start build up from single recruitment:
      N(rstyr,1) = mfexp(logRbar);

      xtrans(nclass, nclass) = 1;
      for (int i=1; i<nclass; i++)
        xtrans(i,i+1) = 1;

      for (int iyr=rstyr; iyr<styr; iyr++)
      {
        // Grow individuals over each time step of initial period: 
        for (int iclass=1; iclass<=nclass; iclass++) 
          for (int jclass=1; jclass<=nclass; jclass++)
            N(iyr+1,iclass) += xtrans(jclass,iclass) * N(iyr,jclass) * S(iyr,jclass);
     
        // Add recruitment for next year:
        recruits(iyr) = mfexp(logRbar+recdev(iyr));
        N(iyr+1,1) += recruits(iyr); 
      }
      break;
    }
  }

  // TODO: Check if numbers into N(styr) from different options give same values? Should they?

// ---------------------------------------------------------------------------------------------------------
FUNCTION Set_selectivity
  // Produce all selectivities:
  int ipnt; 

  // Loop over selectivity patterns:
  for (int isel=1; isel<=nselex_pats; isel++)
    selex_all(isel) = Get_Sel(isel);

  // Fishery and bycatch selectivities:
  for (int ifl=1; ifl<=nfleet_act; ifl++)
  {
    for (iyr=styr; iyr<=endyr; iyr++)
    {
      ipnt = selex_fleet_pnt(ifl,iyr);
      selex_fleet(ifl,iyr) = selex_all(ipnt) ;
    }  
  }
  
  // Loop over retention patterns:
  for (int ireten=1; ireten<=nreten_pats; ireten++)
    reten_all(ireten) = Get_Reten(ireten);

  // Retention in directed fisheries:
  for (int ifl=1; ifl<=nfleet_ret; ifl++)
  {
    for (iyr=styr; iyr<=endyr; iyr++)
    {
      ipnt = reten_fleet_pnt(ifl,iyr);
      reten(ifl,iyr) = reten_all(ipnt) ;
    }  
  }

  /*
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
    */

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

// ---------------------------------------------------------------------------------------------------------
FUNCTION dvar_vector Get_Sel(const int& isel);
  RETURN_ARRAYS_INCREMENT();
  
  int  ipnt    = selex_type(isel,4);
  int  seltype = selex_type(isel,2); 
  dvar_vector seltmp(1,nclass);

  switch (seltype)
  {
    case 1 : ///< Nonparametric from Cstar: One selectivity parameter per size class.
    {
      dvar_vector classes(1,nclass);
      dvar_vector selparms(1,nclass);
      for(int iclass=1; iclass<=nclass; iclass++)
        selparms(iclass) = selex_parms(ipnt + iclass); 
      cstar::Selex<dvar_vector> * ptr1;  // Pointer to Selex base class
      ptr1 = new cstar::ParameterPerClass<dvar_vector>(selparms);
      seltmp = ptr1->Selectivity(classes);
      delete ptr1;
      break;
    }

    case 2 : ///< Logistic from Cstar: Two parameters, length at 50% and 95% selectivity.
    {  
      dvariable s50 = selex_parms(ipnt +1);
      dvariable s95 = selex_parms(ipnt +2);
      cstar::Selex<dvar_vector> * ptr2;  // Pointer to Selex base class
      ptr2 = new cstar::LogisticCurve95<dvar_vector,dvariable>(s50,s95);
      seltmp = ptr2->Selectivity(length);
      delete ptr2;
      break;
    }

    case 3 : ///< Logistic from Cstar: Two parameters, mean and standard deviation.
    {  
      dvariable mu = selex_parms(ipnt +1);
      dvariable sd = selex_parms(ipnt +2);
      cstar::Selex<dvar_vector> * ptr3;  // Pointer to Selex base class
      ptr3 = new cstar::LogisticCurve<dvar_vector,dvariable>(mu,sd);
      seltmp = ptr3->Selectivity(length);
      delete ptr3;
      break;
    }

    case 4 : ///< Log-logistic from Cstar functions (*not yet implemented, needs testing):
    {  
      dvariable mu = selex_parms(ipnt +1);
      dvariable sd = selex_parms(ipnt +2);
      cstar::Selex<dvar_vector> * ptr4;  // Pointer to Selex base class
      ptr4 = new cstar::LogisticCurve<dvar_vector,dvariable>(mu,sd);
      seltmp = ptr4->logSelectivity(length);
      delete ptr4;
      break;
    }
  } 
  RETURN_ARRAYS_DECREMENT();
  return seltmp;

// ---------------------------------------------------------------------------------------------------------
FUNCTION dvar_vector Get_Reten(const int& ireten);
  RETURN_ARRAYS_INCREMENT();
  
  int  ipnt    = reten_type(ireten,4);
  int  retentype = reten_type(ireten,2); 
  dvar_vector retentmp(1,nclass);

  switch (retentype)
  {
    case 1 : ///< Nonparametric: One retention parameter per size class. 
    // TODO: Move to Cstar.
    {
      for (iclass=1; iclass<=nclass; iclass++)
        retentmp(iclass) = 1/(1.0 + mfexp(reten_parms(ipnt + iclass)));
      break;
    }

    case 2 : ///< Logistic from Cstar: Two parameters, length at 50% and 95% retention.
    {  
      dvariable r50 = reten_parms(ipnt +1);
      dvariable r95 = reten_parms(ipnt +2);
      cstar::Selex<dvar_vector> * ptr2;  // Pointer to Selex base class
      ptr2 = new cstar::LogisticCurve95<dvar_vector,dvariable>(r50,r95);
      retentmp = ptr2->Selectivity(length);
      delete ptr2;
      break;
    }
  }   
  RETURN_ARRAYS_DECREMENT();
  return retentmp;

// ---------------------------------------------------------------------------------------------------------
FUNCTION Set_survival
  int iyr,iclass,ifl;
  // Specify natural mortality:
  M = M0;
  for (iyr=styr; iyr<=endyr; iyr++) 
    if (M_pnt(iyr)>0)  // TODO Check to see the logic here
      M(iyr) += Madd_parms(M_pnt(iyr)); 
  
  for (iyr=rstyr; iyr<styr; iyr++)
  {
    S(iyr) = mfexp(-M(iyr));
  }

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

// ---------------------------------------------------------------------------------------------------------
FUNCTION Update_population
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

// ---------------------------------------------------------------------------------------------------------
FUNCTION Get_Dependent_Vars
   // TODO: Check why only selex_fleet(1) is used for mbio_calc.
   // TODO: Check 2/12 here in mbio calculation, is this a timing fraction that needs to be generalised?
  mbio.initialize();
  for (int iyr=styr; iyr<=endyr; iyr++)
     mbio(iyr) += N(iyr)*elem_prod(fecundity,(1-selex_fleet(1,iyr)*f_all(1,iyr))) *
                    mfexp(-(catch_time(1,iyr)+2/12)*M(iyr));

// ---------------------------------------------------------------------------------------------------------
FUNCTION Get_ObjFunction
  Get_Likes();
  Get_Priors();
  ObjFun  = like_weight*like_val + prior_weight*prior_val;

// ---------------------------------------------------------------------------------------------------------
FUNCTION Get_Likes
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
                                                    
// ---------------------------------------------------------------------------------------------------------
FUNCTION Get_Priors
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
  
// ---------------------------------------------------------------------------------------------------------
FUNCTION Get_Catch_Pred;
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
    N_tmp = N(iyr) * mfexp(-catch_time(1,iyr) * M(iyr));
    for (int ifl=1; ifl<=nfleet; ifl++)
    {
      switch (fleet_control(ifl,2)) 
      {
        case 1 : // Main retained fisheries
          ifl_act = fleet_control(ifl,1);
          S1 = S_fleet(ifl_act,iyr);
          fleet_lf_pred(ifl,iyr) = elem_prod(N_tmp , elem_prod((1.-S1), reten(ifl_act,iyr)));
          break;
        
        case 2 : // Discard fisheries
          ifl_act = fleet_control(ifl,1);
          S1 = S_fleet(ifl_act,iyr);
          fleet_lf_pred(ifl,iyr) = elem_prod(N_tmp , elem_prod((1.-S1), (1.-reten(ifl_act,iyr))));
          break;
        
        case 3 : // Fisheries w/ no discard component (e.g. bycatch fisheries)
          ifl_act = fleet_control(ifl,1);
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

// ---------------------------------------------------------------------------------------------------------
FUNCTION Get_Survey
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

// =========================================================================================================
REPORT_SECTION
  cout << "-----End of phase "<<current_phase()<<" ----------------------------------"<<endl;
  if (last_phase())
    Do_R_Output();

  REPORT(ObjFun);
  REPORT(like_val);  
  REPORT(like_weight);
  report << "Likelihood components"<<endl;
  for (int i=1;i<=nlike_terms;i++)
    report << like_names(i)<<" " << like_val(i)<<" "<<like_weight(i)<<" "<<like_val(i)*like_weight(i)<<endl;
  
  report << "prior components"<<endl;
  for (int i=1;i<=nprior_terms;i++)
    report << prior_names(i)<<" " << prior_val(i)<<" "<<prior_weight(i)<<" "<<prior_val(i)*prior_weight(i)<<endl;
  REPORT(prior_val);
  REPORT(prior_weight);
  
  REPORT(logRbar);
  REPORT(recdev);
  REPORT(M);
  REPORT(f_all);
  REPORT(strans);
  REPORT(xtrans);
  REPORT(N0);
  REPORT(N);
  REPORT(mbio);
  REPORT(selex_survey);
  REPORT(selex_fleet);
  REPORT(reten);
  REPORT(S);
  REPORT(S_fleet);
  REPORT(exp_rate);
  REPORT(f_direct);
  REPORT(recruits);

FUNCTION Do_R_Output
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
  
  ivector early_years(rstyr,endyr);
  years.fill_seqadd(rstyr,1);
  writeR(early_years);

  writeR(mean_length);
  writeR(nclass);
  writeR(M);
  writeR(recruits);
  writeR(N);
  
  writeR(fleet_control);
  writeR(nfleet);
  writeR(fleet_names);
  writeR(nsurvey);
  writeR(survey_names);
  writeR(yr_survey);
  
  writeR(catch_units);
  writeR(catch_data);
  writeR(catch_biom_obs);
  writeR(catch_biom_pred);
  writeR(catch_num_obs);
  writeR(catch_num_pred);
  writeR(lf_data);
  
  writeR(survey_data);
  writeR(lfs_data);
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
  
  writeR(nsurvey);
  writeR(yr_survey_lf);
  writeR(survey_num_pred);
  writeR(survey_num_obs);
  writeR(survey_biom_pred);
  writeR(survey_biom_obs);
  writeR(nlf_survey);

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
    R_out<<"exp_rate_"<<fleet_act_ind(ifl)<<endl;
    for (iyr=styr; iyr<=endyr; iyr++)
      R_out << iyr<<" "<< exp_rate(ifl,iyr)<<endl;;
  }  
  
  for (int ifl=1; ifl<=nfleet_act; ifl++)
  {
    R_out<<"select_fish_"<<fleet_act_ind(ifl)<<endl;
    for (iyr=styr; iyr<=endyr; iyr++)
      R_out << iyr<<" "<< selex_fleet(ifl,iyr)<<endl;;
    }  

// TODO: Clean up writeR section; Work outr problems with wrteR function and fix.

// =========================================================================================================
FINAL_SECTION
  // Create final time stamp and determine runtime:
  time(&finish);
  elapsed_time=difftime(finish,start);
  hour=long(elapsed_time)/3600;
  minute=long(elapsed_time)%3600/60;
  second=(long(elapsed_time)%3600)%60;
  
  // Print runtime records to screen:
  cout << endl << endl << "*******************************************"   << endl;
  cout <<                 "--Start time: "                                << ctime(&start)  << endl;
  cout <<                 "--Finish time: "                               << ctime(&finish) << endl;
  cout <<                 "--Runtime: ";
  cout << hour <<         " hours, "  <<minute<<" minutes, "<<second<<" seconds"            << endl;
  cout <<                 "*******************************************"                     << endl;

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

// ---------------------------------------------------------------------------------------------------------
RUNTIME_SECTION
    maximum_function_evaluations 500,1500,2500,25000,25000
    convergence_criteria 0.01,1.e-4,1.e-5,1.e-5
  
// =========================================================================================================
//																			 
// 	Gmacs: Generalized Modelling for Alaskan Crab Stocks.
//
// 	Created by Athol Whitten, University of Washington 	
// 	Info: https://github.com/awhitten/gmacs or write to whittena@uw.edu
// 	Copyright (c) 2014. All rights reserved.
//
// 	Acknowledgement: The format of this code, and many of the details,
// 	were adapted from code developed for the NPFMC by Andre Punt (2012), and on the 
//	'LSMR' model by Steven Martell (2011).
//
// 	TO DO LIST:
//	- Calculate Reference Points (add routine for this)
//	- Add forecast section (add routine for this)
//  - Add warning section: maybe use macro for warning(object,text)
//  - Add section to write new data file (enable easy labelling after first model attempt)
//  - Look at numbers-at-length matrix...dimensioned by year, maturity, shell condition, sex-size bin
//  - Add simulation option, see LSMR model for demonstration 
//
//	=========================================================================================================

GLOBALS_SECTION
	
	#include <admodel.h>
	#include <time.h>
	#include <contrib.h>
	#include <C:/Dropbox/Github/cstar/src/cstar.hpp>

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

	// Open output files using ofstream
	ofstream echoinput("echoinput.gm");
	ofstream warning("warning");

	// Define some adstring variables for use in output files:
	adstring version;
	adstring version_short;
	
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
	!!version+="Gmacs_V1.02_2014/01/02_by_Athol_Whitten_(UW)_using_ADMB_11.1";
	!!version_short+="Gmacs V1.02";

	!! echoinput << version << endl;
	!! echoinput << ctime(&start) << endl;


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
	init_int verbose;						// Display detail to screen (option 1/0)
	init_int final_phase;					// Stop estimation after this phase
	init_int use_pin;						// Use a .pin file to get initial parameters (option 1/0)
	init_int read_growth;					// Read growth transition matrix file (option 1/0)

	!! echotxt(verbose, " display detail");
	!! echotxt(final_phase, " final phase");
	!! echotxt(use_pin, " use parameter in file (*.pin)");
	!! echotxt(read_growth, " read growth transition matrix data file");


	// Print EOF confirmation to screen and echoinput, warn otherwise:
	init_int eof_starter;

	!! if(eof_starter!=999) {cout << " Error reading starter file \n EOF = "<< eof_starter << endl; exit(1);}
	!! cout << " Finished reading starter file \n" << endl;
	!! echotxt(eof_starter," EOF: finished reading starter file \n");


// ---------------------------------------------------------------------------------------------------------
// DATA FILE (MAIN)

	// Open main data file (*.dat):
	!! ad_comm::change_datafile_name(data_file);
	!! cout << " Reading main data file" << endl;
	!! echoinput << " Start reading main data file" << endl;
	
	// Read input from main data file:
	init_int styr;   	 ///< Start year
	init_int endyr;   	 ///< End year
	init_number tstep; 	 ///< Time-step

	!! echotxt(styr,  " Start year");
	!! echotxt(endyr, " End year");
	!! echotxt(tstep, " Time-step");
	
	init_int nsex;		 ///< Number of sexes	
	init_int nfleet;	 ///< Number of fishing fleets
	init_int nsurvey;	 ///< Number of surveys
	init_int nclass;	 ///< Number of size classes
	init_int ndclass;	 ///< Number of size classes (in the data)
	
	init_imatrix class_link(1,nclass,1,2);  ///< Link between data size-classes and model size-classs
	 
	!! echotxt(nsex,    " Number of sexes");
	!! echotxt(nfleet,  " Number of fleets");
	!! echotxt(nsurvey, " Number of surveys")
	!! echotxt(nclass,  " Number of size classes");
	!! echotxt(ndclass, " Number of size classes for data");
	
	!! echo(class_link);

	init_vector catch_units(1,nfleet);   			///< Catch units (pot discards; + other fleets) [1=biomass (tons);2=numbers]
	init_vector catch_multi(1,nfleet);	  			///< Additional catch scaling multipliers [1 for no effect]
	init_vector survey_units(1,nsurvey);  			///< Survey units [1=biomass (tons);2=numbers]
  	init_vector survey_multi(1,nsurvey);  			///< Additional survey scaling multipliers [1 for no effect]
  	init_int ncatch_obs; 							///< Number of catch lines to read
	init_int nsurvey_obs;							///< Number of survey lines to read
	init_number survey_time;                		///< Time between survey and fishery (for projections)
	

	// Read fleet specifications and determine number with catch retained or discarded etc:
	init_imatrix fleet_control(1,nfleet,1,3);		///< Fleet control matrix

	int nfleet_ret;									///< Number of fleets for retained catch data
	int nfleet_dis;									///< Number of fleets for discarded catch data (with link to above retained catch)
	int nfleet_byc;									///< Number of fleets for bycatch data only

	LOCAL_CALCS

	  nfleet_ret = 0;
	  nfleet_dis = 0;
	  nfleet_byc = 0;

	  for (fleet=1; fleet<=nfleet; fleet++)
	    {
	  	  if(fleet_control(fleet,2)==1) nfleet_ret += 1
	  	  if(fleet_control(fleet,2)==2) nfleet_dis += 1
	  	  if(fleet_control(fleet,2)==3) nfleet_byc += 1
	  	} 

	END_CALCS

	init_matrix catch_data(1,ncatch_obs,1,5);	 	///< Catch data matrix, one line per ncatch_obs, requires year, season, fleet, observation
	init_matrix survey_data(1,nsurvey_obs,1,6);	 	///< Survey data matrix, one line per nsurvey_obs, requires year, season, survey, observation, and error

	// Q: Some pre-processing of these data required. See simple.tpl for example.

  	!! echotxt(catch_units,  " Catch units");
	!! echotxt(catch_multi,  " Catch multipliers");
	!! echotxt(survey_units, " Survey units");
	!! echotxt(survey_multi, " Survey multipliers")
	!! echotxt(ncatch_obs,   " Number of lines of catch data");
	!! echotxt(nsurvey_obs,  " Number of lines of survey data")
	!! echotxt(survey_time,  " Time between survey and fishery");
			
	!! echo(catch_data);
	!! echo(survey_data);

	init_vector discard_mort(1,nfleet);				///< Discard mortality (per fishery)
	init_vector retention(styr,endyr);				///< Retention value for each year
	init_matrix catch_time(1,nfleet,styr,endyr);	///< Timing of each fishery (as fraction of time-step)
	init_matrix effort(1,nfleet,styr,endyr);		///< effort by fishery
	init_imatrix f_new(1,nfleet,1,5);				///< Alternative f estimators (overwrite others)

	!! echo(discard_mort);
	!! echo(retention);
	!! echo(catch_time);
	!! echo(effort);
	!! echo(f_new);

	// TODO: Check if al neccessary components from Simple example have been read in. 
	// 		Highgrading vs. Retention, which is best? Retention function is distinct from the highgrading vector, so maybe change name and data input point.

	// Determine which F values will be computed using effort (f_new) if applicable: 

 	int yr;
 	int fleet;
 	ivector ncatch_f(1,nfleet);
 
 	LOCAL_CALCS
      
      for (fleet=1; fleet<=nfleet; fleet++)
       {
        ncatch_f(fleet) = 0;
        for (yr=styr; yr<=endyr; yr++) 
         if (effort(fleet,yr) > 0) 
          {
           if (f_new(fleet,1) == 0 | yr < f_new(fleet,2) | yr > f_new(fleet,3))
            ncatch_f(fleet) += 1;
          }
       }
    
	END_CALCS

	!! echotxt(ncatch_f, " Number of F's (calculated)")

	init_vector mean_length(1,ndclass); 			///< Mean length vector
	init_vector mean_weight(1,ndclass); 			///< Mean weight vector
	init_vector fecundity(1,ndclass);				///< Fecundity vector

	!! echo(nat_mort);
	!! echo(mean_length);
	!! echo(mean_weight);
	!! echo(fecundity);

	// TODO: These mean length and weight vectors probably have to be converted to be suitable for the nclass number of size-classes.

	init_int nlf_obs;								///< Number of length frequency lines to read	
	init_matrix lf_data(1,nlf_obs,1,ndclass+7);		///< Length frequency data, one line per nlf_obs, requires year, season, fleet, sex, maturity, shell cond., effective sample size, then data vector 

	init_int nlfs_obs;								///< Number of survey length frequency lines to read
	init_matrix lfs_data(1,nlfs_obs,1,ndclass+5);	///< Survey length frequency data, one line per nlfs_obs, requires year, season, survey, sex, effective sample size, then data vector

   	!! echotxt(nlf_obs,  " Number of length freq lines to read");
  	!! echo(lf_data);

  	!! echotxt(nlfs_obs, " Number of survey length freq lines to read");
  	!! echo(lfs_data);
  	
 	init_int ncapture_obs;										///< Number of capture data lines to read		
 	init_int nmark_obs;											///< Number of mark data lines to read
 	init_int nrecapture_obs;									///< Number of recapture data lines to read

	init_matrix capture_data(1,ncapture_obs,1,ndclass+3);		///< Capture data, one line per ncapture_obs, requires years, fleet, sex, then data vector
	init_matrix mark_data(1,nmark_obs,1,ndclass+3);				///< Mark data, one line per nmark_obs, requires years, fleet, sex, then data vector
	init_matrix recapture_data(1,nrecapture_obs,1,ndclass+3);	///< Recapture data, one line per nrecapture_obs, requires years, fleet, sex, then data vector

	!! echotxt(ncapture_obs,   " Number of capture data lines");
	!! echotxt(nmark_obs,      " Number of mark data lines");
	!! echotxt(nrecapture_obs, " Number of recapture data lines")

	// Echo capture, mark, and recapture data when appropriate:
	LOCAL_CALCS

      if(ncapture_obs > 0) 
	    {
	      echo(capture_data);
	      echo(mark_data);
	      echo(recapture_data);
	    }

	END_CALCS
	
	// Print EOF confirmation to screen and echoinput, warn otherwise:
	init_int eof_data;
	
	!! if(eof_data!=999) {cout << " Error reading main data file \n EOF = "<< eof_data << endl; exit(1);}
	!! cout << " Finished reading main data file \n" << endl;
	!! echotxt(eof_data," EOF: finished reading main data file \n");

	
// ---------------------------------------------------------------------------------------------------------
// DATA FILE (GROWTH)
// This section is conditional on starter file flag (read growth matrix data file).
	
	// Declare objects to read in from growth data file:
	int styr_growth;				///< Start year for growth data
	int endyr_growth;				///< End year for growth data
	int ndclass_growth;				///< Number of data classes for growth data

	LOCAL_CALCS

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

	END_CALCS
	
	// Declare objects dependent on previous objects:
	ivector growth_bins(1,ndclass_growth);													///< Vector of growth data bins (lower length of each bin)
	3darray growth_data(styr_growth,endyr_growth,1,ndclass_growth-1,1,ndclass_growth-1);	///< Array of year specific growth transition matrices	
	
	int eof_growth;		// Declare EOF check

	LOCAL_CALCS

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
	
	// Read general input from control file:
	init_matrix theta_control(1,ntheta,1,13);		///< General parameter matrix, with specifications
	matrix trans_theta_control(1,13,1,ntheta);		///< Transpose of general parameter matrix
	vector theta_init(1,ntheta);					///< Vector of general parameter specs - initial values
	vector theta_lbnd(1,ntheta);					///< Vector of general parameter specs - lower bound values
	vector theta_ubnd(1,ntheta);					///< Vector of general parameter specs - upper bound values				
	ivector theta_phz(1,ntheta);					///< Vector of general parameter specs - phase values
	ivector theta_prior(1,ntheta);					///< Vector of general parameter specs - prior type
	vector theta_pmean(1,ntheta);					///< Vector of general parameter specs - prior mean values
	vector theta_psd(1,ntheta);						///< Vector of general parameter specs - prior s.d. values
	ivector theta_cov(1,ntheta);					///< Vector of general parameter specs - covariate type
	ivector theta_dev(1,ntheta);					///< Vector of general parameter specs - deviation type
	vector theta_dsd(1,ntheta);						///< Vector of general parameter specs - deviation s.d.
	ivector theta_dmin(1,ntheta);					///< Vector of general parameter specs - deviation min. year
	ivector theta_dmax(1,ntheta);					///< Vector of general parameter specs - deviation max. year
	ivector theta_blk(1,ntheta);					///< Vector of general parameter specs - block number (for time-varying paramters)

	!! echo(theta_control);

	// Fill matrices and vectors created above:
	LOC_CALCS

		trans_theta_control = trans(theta_control);
		theta_init = trans_theta_control(1);
		theta_lbnd = trans_theta_control(2);
		theta_ubnd = trans_theta_control(3);
		theta_phz  = ivector(trans_theta_control(4));
		theta_prior = ivector(trans_theta_control(5));
		theta_pmean = trans_theta_control(6);
		theta_psd = trans_theta_control(7);
		theta_cov = ivector(trans_theta_control(8));
		theta_dev =	ivector(trans_theta_control(9));
		theta_dsd = trans_theta_control(10);
		theta_dmin = ivector(trans_theta_control(11));
		theta_dmax = ivector(trans_theta_control(12));
		theta_blk = ivector(trans_theta_control(13));
	
	END_CALCS

	// Read in specifications relating to recruitment:
	init_int sr_lag;                                       		///< Lag to recruitment
  	init_int sr_type;                                 			///< Form of stock recruitment relationship

	// Read in pointers for time-varying natural mortality:
	init_vector nat_mort_pnt(styr,endyr);						///< Pointers to blocks for time-varying natural mortality

	int nmadd_pars;												///< Number of M additional parameters
	!! nmadd_pars = nat_mort_pnt.indexmax();									 

	!! echo(nat_mort_pnt);
	!! echotxt(nmadd_pars, " Total number of additional natural mortality parameters");
	
   	// Read in naturaly mortality parameter specifications:
	init_matrix madd_control(1,nmadd_pars,1,4);     			///< Natural mort. parameter matrix, with speciifications           
  	matrix trans_madd_control(1,4,1,nmadd_pars);				///< Transponse of natural mort. parameter matrix		
  	vector madd_init(1,nmadd_pars);								///< Vector of natural mort. parameter specs - initial values	
  	vector madd_lbnd(1,nmadd_pars);								///< Vector of natural mort. parameter specs - lower bounds
  	vector madd_ubnd(1,nmadd_pars);								///< Vector of natural mort. parameter specs - upper bounds			
  	ivector madd_phz(1,nmadd_pars);								///< Vector of natural mort. parameter specs - phase values

 	!! echo(madd_control);

	// Fill matrices and vectors created above:
	LOCAL_CALCS

	  trans_madd_control = trans(madd_control);
	  madd_init = trans_madd_control(1);
	  madd_lbnd = trans_madd_control(2);
	  madd_ubnd = trans_madd_control(3);
	  madd_phz = ivector(trans_madd_control(4));
	
	END_CALCS

	// Read in pointers for time-varying fishery and survey selectivity:
	init_imatrix selex_fleet_pnt(1,nfleet,styr,endyr);						///< Pointers to blocks for time-varying fishing selectivity
	init_imatrix selex_survey_pnt(1,nsurvey,styr,endyr+1);					///< Pointers to blocks for time-varying survey selectivity

	!! echo(selex_fleet_pnt);
	!! echo(selex_survey_pnt);

	// Determine number of different selectivity functions/patterns to estimate:
	int nselex;
	int nselex_pat;

	// TODO: Should be able to use selex_survey_pnt.indexmax() below instead of loop. See PG: 192 ADMB Manual.

	LOCAL_CALCS
	
		nselex = 0;
		  for (fleet=0; fleet<=nfleet; fleet++)
		    for (yr=styr; yr<=endyr; yr++)
			  if (selex_fleet_pnt(fleet,yr) > nselex) nselex = selex_fleet_pnt(fleet,yr);
		
		nselex = 0;
		  for (fleet=0; fleet<=nfleet; fleet++)
		    for (yr=styr; yr<=endyr; yr++)
		      if (selex_survey_pnt(fleet,yr) > nselex) nselex = selex_survey_pnt(fleet,yr);

		nselex_pat = nselex;
		echotxt(nselex_pat, " Total number of selectivity patterns");

	END_CALCS

	// TODO: For selex types, check AEP BBRKC document for what each type is.
	// Read in specifications for each selectivity pattern and determine number of parameters to estimate:
	matrix selex_type(1,nselex_pat,1,4);		///< Selectivity types for each fleet/survey by time-block
	
	// TODO: The selex_type matrix can probably be read in directly, then the loop over the columns should work the same.
	LOCAL_CALCS

		nselex = 0;
		 for (i=1; i<=nselex_pat; i++)
		  {
		   *(ad_comm::global_datafile) >> selex_type(i,1) >> selex_type(i,2) >> selex_type(i,3);
		   if (selex_type(i,2) == 1) nselex += 2;
		   if (selex_type(i,2) == 2) nselex += nclass;
		   if (selex_type(i,2) == 3) nselex += 1;
		  }

		nselex_par = nselex;
		echotxt(nselex_par, " Total number of selectivity parameters");

	END_CALCS

	//TODO: Add more selectivity options above as necessary for next example models. See LSMR code for example.

	// Read in selectivity parameter specifications:
	init_matrix selex_control(1,nselex_par,1,4);		///< Selectivity parameter matrix, with specifications
	matrix trans_selex_control(1,4,1,nselex_par);		///< Transpose of selectivity parameter matrix
	vector selex_init(1,nselex_par);					///< Vector of selex parameter specs - initial values
	vector selex_lbnd(1,nselex_par);					///< Vector of selex parameter specs - lower bounds
	vector selex_ubnd(1,nselex_par);					///< Vector of selex parameter specs - upper bounds
	ivector selex_phz(1,nselex_par);					///< Vector of selex parameter specs - phase values
	
	!! echo(selex_control);

	// Fill matrices and vectors created above:
	LOCAL_CALCS

	  trans_selex_control = trans(selex_control);
	  selex_init = trans_selex_control(1);
	  selex_lbnd = trans_selex_control(2);
	  selex_ubnd = trans_selex_control(3);
	  selex_phz = ivector(trans_selex_control(4));
	
	END_CALCS

	// Read in pointers for time-varying fishery retention:
	int nreten_pars;
	init_imatrix reten_fleet_pnt(1,nfleet_ret,styr,endyr);

	//TODO: Check if above row for retention applies to discard fishery or to linked retained fishery:
	
	!! nreten_pars = reten_fleet_pnt.indexmax();
	!! nreten_pars *= nclass;

	//TODO: This code assumes only one type of retention function at the moment. Update as necessary.
	
	echotxt(nreten_pars, " Total number of retention parameters");

	// Read in retention parameter specifications:
	init_matrix reten_control(1,nreten_pars,1,4);     	///< Retention parameter matrix, with speciifications           
  	matrix trans_reten_control(1,4,1,nreten_pars);		///< Transponse of retention parameter matrix		
  	vector reten_init(1,nreten_pars);					///< Vector of retention parameter specs - initial values	
  	vector reten_lbnd(1,nreten_pars);					///< Vector of retention parameter specs - lower bounds
  	vector reten_ubnd(1,nreten_pars);					///< Vector of retention parameter specs - upper bounds			
  	ivector reten_phz(1,nreten_pars);					///< Vector of retention parameter specs - phase values

 	!! echo(reten_control);

	// Fill matrices and vectors created above:
	LOCAL_CALCS

	  trans_reten_control = trans(reten_control);
	  reten_init = trans_reten_control(1);
	  reten_lbnd = trans_reten_control(2);
	  reten_ubnd = trans_reten_control(3);
	  reten_phz = ivector(trans_reten_control(4));
	
	END_CALCS

	// Read in pointers for time-varying survey catchability:
	int nsurveyq_pars;
	init_imatrix q_survey_pnt(1,nsurvey,styr,endyr+1);

	!! nsurveyq_pars = q_survey_pnt.indexmax()

	!! echo(q_survey_pnt);
	!! echotxt(nsurveyq_pars, " Total number of retention parameters");

  	// Read in flag for number of surveys in a sub-area of the main survey area:
  	init_int nsubsurvey;
 	init_imatrix subsurvey(1,nsubsurvey,1,2);

 	!! echotxt(nsubsurvey, " Number of sub-surveys");
 	!! echo(subsurvey);

	// Read in survey catchability parameter specifications:
	init_matrix surveyq_control(1,nsurveyq_pars,1,4);     	///< Survey Q parameter matrix, with speciifications           
  	matrix trans_surveyq_control(1,4,1,nsurveyq_pars);		///< Transponse of survey Q parameter matrix		
  	vector surveyq_init(1,nsurveyq_pars);					///< Vector of survey Q parameter specs - initial values	
  	vector surveyq_lbnd(1,nsurveyq_pars);					///< Vector of survey Q parameter specs - lower bounds
  	vector surveyq_ubnd(1,nsurveyq_pars);					///< Vector of survey Q parameter specs - upper bounds			
  	ivector surveyq_phz(1,nsurveyq_pars);					///< Vector of survey Q parameter specs - phase values
  	ivector surveyq_prior(1,nsurveyq_pars);					///< Vector of survey Q parameter specs - prior types
  	vector surveyq_pmean(1,nsurveyq_pars);					///< Vector of survey Q parameter specs - prior mean values
  	vector surveyq_psd(1,nsurveyq_pars);					///< Vector of survey Q parameter specs - prior s.d. values

 	!! echo(surveyq_control);

	// Fill matrices and vectors created above:
	LOCAL_CALCS

	  trans_surveyq_control = trans(surveyq_control);
	  surveyq_init = trans_surveyq_control(1);
	  surveyq_lbnd = trans_surveyq_control(2);
	  surveyq_ubnd = trans_surveyq_control(3);
	  surveyq_phz = ivector(trans_surveyq_control(4));
	  surveyq_prior = ivector(trans_surveyq_control(5));
	  surveyq_pmean = trans_surveyq_control(6);
	  surveyq_psd = trans_surveyq_control(7);
	
	END_CALCS

	// Read in initial N parameter specifications:
	init_matrix lognin_control(1,nclass,1,4);				///< Initial N parameter matrix, with specifications
	matrix trans_lognin_control(1,4,1,nclass);				///< Transpose of initial N parameter matrix
	vector lognin_init(1,nclass);							///< Vector of initial N parameter specs - initial values
	vector lognin_lbnd(1,nclass);							///< Vector of initial N parameter specs - lower bounds
	vector lognin_ubnd(1,nclass);							///< Vector of initial N parameter specs - upper bounds
	ivector lognin_phz(1,nclass);							///< Vector of initial N parameter specs - phase values
	
	!! echo(lognin_control);

	// Fill matrices and vectors created above:
	LOCAL_CALCS

	  trans_lognin_control = trans(lognin_control);
	  lognin_init = trans_lognin_control(1);
	  lognin_lbnd = trans_lognin_control(2);
	  lognin_ubnd = trans_lognin_control(3);
	  lognin_phz = ivector(trans_lognin_control(4));
	
	END_CALCS

	// Read in selectivity parameter specifications:
	init_matrix gtrans_control(1,nclass-1,1,4);				///< Growth transition parameter matrix, with specifications
	matrix trans_gtrans_control(1,4,1,nclass-1);			///< Transpose of initial N parameter matrix
	vector gtrans_init(1,nclass-1);							///< Vector of growth trans. parameter specs - initial values
	vector gtrans_lbnd(1,nclass-1);							///< Vector of growth trans. parameter specs - lower bounds
	vector gtrans_ubnd(1,nclass-1);							///< Vector of growth trans. parameter specs - upper bounds
	ivector gtrans_phz(1,nclass-1);							///< Vector of growth trans. parameter specs - phase values
	
	!! echo(gtrans_control);

	// Fill matrices and vectors created above:
	LOCAL_CALCS

	  trans_gtrans_control = trans(gtrans_control);
	  gtrans_init = trans_gtrans_control(1);
	  gtrans_lbnd = trans_gtrans_control(2);
	  gtrans_ubnd = trans_gtrans_control(3);
	  gtrans_phz = ivector(trans_gtrans_control(4));
	
	END_CALCS

  	// Determine number of prior terms, and create objects to hold these values:
  	int nprior_terms;
  	int nlike_terms;
  	
  	!! nprior_terms = (nfleet+1) + 5 + nsurveyq_pars + 1 + 1;	
  	!! nlike_terms = (nfleet+2)*2 + (nfleet+1) + (nsurvey)*2;
  	// TODO: Seems like this section may have to be generalised further. See the control file for more.
  	

  	!! echotxt(nprior_terms, " Number of prior terms");
  	!! echotxt(nlike_terms, " Number of likelihood terms");
    
  	// Read in prior and data re-weighting values:	

  	init_vector prior_weight(1,nprior_terms);             		///< Weights on the priors
  	init_vector data_weight(1,nlike_terms);               		///< Weights on the data

  	!! echo(prior_weight);
  	!! echo(data_weight);

  	// Print EOF confirmation to screen and echoinput, warn otherwise:
	init_int eof_control;

	!! if(eof_control!=999) {cout << " Error reading control file\n EOF = " << eof_control << endl; exit(1);}
	!! cout << " Finished reading control file \n" << endl;
	!! echotxt(eof_data," EOF: finished reading control file \n");

	// TODO: Check these extra objects below, and make them Gmacs format is required.

  	3darray FleetObsLF(-1,nfleet,1,maxFleetLF,1,nclass)        // Catch/bycatch Lfs (by model classes)
  	3darray SurveyObsLF(1,nsurvey,1,maxSurveyLF,1,nclass)      // Survey Lfs (by model classes)
  
  	// Stuff related to the SR relationship
  	int IsB0;                                         // Constant recruitment?
  	int SR_rel;                                       // Form of SR_Relationship

  	// Exit here, to test read-in of data and control objects.
  	!!exit(1);
  	  

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

	// Create count of active parameters and derived quantities
	int par_count;
	int active_count;
	int active_parms;
	ivector active_parm(1,ntheta);  //  Pointer from active list to the element of the full parameter list to get label

	// TODO: Add active_parm pointer list for labelling active parameters in report.gm output file.
	// TODO: Extend this code below to sort through other parameter lists (anything with *_phz).

	// Create dummy datum for use when max phase == 0
	number dummy_datum;
	int dummy_phase;
	!! dummy_datum=1.;
	!! if(final_phase<=0) {dummy_phase=0;} else {dummy_phase=-6;}

	// Adjust the phases to negative if beyond final_phase and find resultant max_phase
	int max_phase;
 
 	LOC_CALCS
  		cout << " Adjust phases \n" << endl;
  		max_phase=1;
  		active_count=0;
  		active_parm(1,ntheta)=0;
  		par_count=0;
  
		for(i=1;i<=ntheta;i++)
		{ 
		  	par_count++;
		  	if(theta_phz(i) > final_phase) theta_phz(i)=-1;
		  	if(theta_phz(i) > max_phase) max_phase=theta_phz(i);
		  	if(theta_phz(i) >= 0)
		  	{
		  	  active_count++; active_parm(active_count)=par_count;
		  	}
		}

		active_parms=active_count;
	END_CALCS

	!!cout << "Number of active parameters is " << active_parms << endl;
	!!cout << "Maximum phase for estimation is " << max_phase << endl << endl;

	// TODO: Adjust this section to include other parameters not specified in the general paramter matrix 'theta'.

// =========================================================================================================

PARAMETER_SECTION

	// Initialize general parameter matrix:
  	init_bounded_number_vector theta(1,ntheta,theta_lbnd,theta_ubnd,theta_phz);						///< Vector of general parameters
	
  	// Initialize other parameter matrices:
	init_bounded_number_vector madd(1,nmadd_pars,madd_lbnd,madd_ubnd,madd_phz);                     ///< Vector of increments in M parameters
	init_bounded_number_vector gtrans(1,nclass-1,gtrans_lbnd,gtrans_ubnd,gtrans_phz);               ///< Vector of growth transition parameters
	init_bounded_number_vector selex(1,nselex_par,selex_lbnd,selex_ubnd,selex_phz);                 ///< Vector of selectivity parameters
	init_bounded_number_vector reten(1,nreten_pars,reten_lbnd,reten_ubnd,reten_phz)                 ///< Vector of retention parameters
	init_bounded_number_vector surveyq(1,nsurveyq_pars,surveyq_lbnd,surveyq_ubnd,surveyq_phz)       ///< Vector of survey Q parameters
	init_bounded_number_vector lognin(1,nclass,lognin_lbnd,lognin_ubnd,lognin_phz)             		///< Vector of initial N parameters
 	
 	// Initialize predicted catch and recruitment parameters:
  	init_bounded_vector_vector f_est(1,nfleet,1,ncatch_f,0,1,1);									///< Vector of predicted f values
  	init_vector recdev(styr,endyr,1);                        										///< Vector of recruitment deviations
  
  	!! cout << "All parameters declared" << endl;

  	matrix f_all(0,nfleet,styr,endyr);                        	// Fishing mortality by year  

	matrix N(styr,endyr+1,1,nclass);             				// Numbers-at-age Matrix
	matrix S(styr,endyr,1,nclass);               				// Survival matrix
	3darray SF(0,nfleet,styr,endyr,1,nclass);    				// Survival matrices (0=Pot; 1+ bycatch and discard)
	matrix ExplRates(0,nfleet,styr,endyr);       				// Exploitation rates (0=Pot; 1+ bycatch and discard_
	matrix Trans(1,nclass,1,nclass);          					// Size-transition matrix
  
	matrix RetCatMale(styr,endyr,1,nclass);               		// Male Retention
	3darray FleetSelex(0,nfleet,styr,endyr,1,nclass)      	 	// Catch/bycatchSelectivity
	3darray SelexSurvey(1,nsurvey,styr,endyr+1,1,nclass);   	// Survey selectivity
 	vector SurveyQ(1,nsurvey);                           		// Survey Q
	matrix SelexAll(1,NSelexPat,1,nclass);               		// All selectivity pattern
  
	3darray CatFleet(-1,nfleet,styr,endyr,1,nclass);   	   		// Catches (numbers by class)
	matrix CatFleetWghtPred(-1,nfleet,styr,endyr);     	   		// Predicted catch weights
	matrix CatFleetNumPred(-1,nfleet,styr,endyr);       	   	// Predicted catch numbers
  

	3darray PredSurvey(1,nsurvey,styr,endyr+1,1,nclass);    		// Survey LF from the model
	matrix PredSurveyWght(1,nsurvey,styr,endyr+1);          		// Predicted survey 
	matrix PredSurveyNum(1,nsurvey,styr,endyr+1);           		// Predicted survey 
	vector qEff(0,nfleet);                               			// effort q
	vector M(styr,endyr);                       			   		// Natural mortality
	vector Fdirect(styr,endyr);                 			   		// Fishing mortality
  
	// Initialize the components of the objective function:
	vector prior_value(1,nprior_terms);       // Objective function prior values
	vector like_value(1,nlike_terms);         // Objective function likelihood values
	objective_function_value fobj;            // Objective function value to be minimised

  

  // Stuff related to the SR relationship
  number Fmult;                             // Passed Fmultiplier
  number MMBOut;                            // Mature male biomass
  number F35;                               // F35%
  number SBPR35;                            // SBPR35 (used to define BMSY)
  number RecOut;                            // Recruitment  
  number CatchOut;                          // Predicted catch
  vector mbio(1,1000);                      // Future MMB
  vector MortF(1,nfleet);                   // Other fleet Fs

  number R0;                                // Virgin recruitment 
  number Steep;                             // Stock-recruit steepness 
  number MMB0;                              // Virgin MMB 
  vector MMB(styr,endyr);                      // Mature male biomass
  sdreport_vector LogMMB(styr,endyr);          // Mature male biomass (logged)
  vector Recruits(styr,endyr);                 // Recruitments
  sdreport_vector LogRecruits(styr,endyr);     // Recruitments
  sdreport_vector LogRMMB(styr,endyr-Lag);     // Recruits-per-spawner

	// TODO: See example for more complicated selectivity options from LSMR.tpl.

	// Create dummy parameter that will be estimated when turn_off_phase is set to 0
  	init_bounded_number dummy_parm(0,2,dummy_phase)  //  Dummy parameter estimated in phase 0 

	
// =========================================================================================================
	
INITIALIZATION_SECTION
	theta     theta_init;
	log_bar_f -3.5;
	log_tau   1.1;

// =========================================================================================================

PRELIMINARY_CALCS_SECTION
  
// Initialize the dummy parameter as needed:
  if(turn_off_phase<=0) {dummy_parm=0.5;} else {dummy_parm=1.0;}


  int iyr,iclass,Jclass,ifleet,isurv,j,Ipnt,Jpnt,Last,SelType;
  float Total,NumSS,Scalar;
  dvector TotalSS(-1,nfleet);
  dmatrix SSFStore(-1,nfleet,1,maxFleetLF);
  dmatrix SSSStore(1,nsurvey,1,maxSurveyLF);
  dvector SurvLFStore(1,NallClass);

  cout << "Started Preliminary Calcs Section" << endl;
  cout << Diag << endl;
  
  if (IgnorePINFile==1) 
   {
    logRbar = R0init;
    M0 = Minit;
    for (j=1;j<=MMvals;j++) Mm(j) = Maddinit(j);  
    for (j=1;j<=nclass-1;j++) TransPars(j) = TransParsInit(j);
    for (j=1;j<=nselex;j++) SelexPar(j) = selex_init(j);
    for (j=1;j<=NRetPars;j++) RetainPar(j) = RetainParInit(j);
    for (j=1;j<=NSurveyQ;j++) LogSurveyQ(j) = SurveyQInit(j);
    for (j=1;j<=nclass;j++) logNinitial(j) = logNinitialInit(j);
    for (ifleet=0;ifleet<=nfleet;ifleet++)
     for (iyr=1;iyr<=NcatchF(ifleet);iyr++) FEst(ifleet,iyr) = 0.1;
    for (iyr=styr;iyr<=endyr;iyr++) RecDev(iyr) = 0; 
   }
  if (Diag == 1) cout << "PIN File specified" << endl; 

  Total = 0;
  for (iclass=1;iclass<=NallClass;iclass++)
   {
    SurvLFStore(iclass) = 0;
    for (iyr=1;iyr<=NLFsurvey(1);iyr++) SurvLFStore(iclass) += SurveyLF(1,iyr,iclass);
    Total += SurvLFStore(iclass);
   }
  if (Diag == 1) cout << "Survey sample sizes stored" << endl; 

  CheckFile << "Class Length, Weight Fecundity" << endl;
  for (iclass=1;iclass<=nclass;iclass++)
   {
    Length(iclass) = 0; Wght(iclass) = 0; fecu(iclass) = 0; Total = 0;
    for (Jclass=ClassLink(iclass,1);Jclass<=ClassLink(iclass,2);Jclass++)
     {
      Length(iclass) += Length_inp(Jclass)*SurvLFStore(Jclass);
      Wght(iclass) += Wght_inp(Jclass)*SurvLFStore(Jclass);
      fecu(iclass) += fecu_inp(Jclass)*SurvLFStore(Jclass);
      Total += SurvLFStore(Jclass);
     }
     Length(iclass) /= Total;
     Wght(iclass) /= Total;
     fecu(iclass) /= Total;
     CheckFile << iclass << " " << Length(iclass) << " " << Wght(iclass) << " " << fecu(iclass) << endl;
    }
  if (Diag == 1) cout << "Lengths and weights specified" << endl; 
  
  FleetObsLF.initialize();
  for (ifleet=-1;ifleet<=nfleet;ifleet++)
   {
    TotalSS(ifleet) = 0; NumSS = 0;
    for (iyr=1;iyr<=NLFfleet(ifleet);iyr++)
     {
      for (iclass=1;iclass<=nclass;iclass++)
       for (Jclass=ClassLink(iclass,1);Jclass<=ClassLink(iclass,2);Jclass++)
        FleetObsLF(ifleet,iyr,iclass) += FleetLF(ifleet,iyr,Jclass);
      Total = 0;
      for (iclass=1;iclass<=nclass;iclass++) Total += FleetObsLF(ifleet,iyr,iclass);
      SSFStore(ifleet,iyr) = Total;
      TotalSS(ifleet) += Total; NumSS += 1;
      for (iclass=1;iclass<=nclass;iclass++) FleetObsLF(ifleet,iyr,iclass) /= Total;
     }
    TotalSS(ifleet) /= NumSS; 
   }
 Scalar = TotalSS(0);
 for (ifleet=-1;ifleet<=nfleet;ifleet++)
  for (iyr=1;iyr<=NLFfleet(ifleet);iyr++) 
   {
    SSFleetLF(ifleet,iyr) = 200*SSFStore(ifleet,iyr) / Scalar;
    if (SSFleetLF(ifleet,iyr) > 200) SSFleetLF(ifleet,iyr) = 200;
    if (SSFleetLF(ifleet,iyr) < 4) SSFleetLF(ifleet,iyr) = 4;
   }  
 if (Diag == 1) cout << "Fishery effective sample sizes specified" << endl; 
    
 CheckFile << "Used Fishery LF" << endl;
 CheckFile << FleetObsLF << endl;
  
 SurveyObsLF.initialize();
 for (isurv=1;isurv<=nsurvey;isurv++)
  {
   for (iyr=1;iyr<=NLFsurvey(isurv);iyr++)
    {
     for (iclass=1;iclass<=nclass;iclass++)
      for (Jclass=ClassLink(iclass,1);Jclass<=ClassLink(iclass,2);Jclass++)
       SurveyObsLF(isurv,iyr,iclass) += SurveyLF(isurv,iyr,Jclass);
     Total = 0;
     for (iclass=1;iclass<=nclass;iclass++) Total += SurveyObsLF(isurv,iyr,iclass);
     SSSStore(isurv,iyr) = Total;
     for (iclass=1;iclass<=nclass;iclass++) SurveyObsLF(isurv,iyr,iclass) /= Total;
    }
  } 
 if (Diag == 1) cout << "Survey effective sample sizes specified" << endl; 
 CheckFile << "Used Survey LF" << endl;
 CheckFile << SurveyObsLF << endl;
  
 Ipnt = 0;
 for (Jpnt=1;Jpnt<=nselex_pat;Jpnt++)
  {
   selex_type(int,4) = Ipnt;
   if (selex_type(int,2)==1) Last = 2;
   if (selex_type(int,2)==2) Last = nclass;
   if (selex_type(int,2)==3) Last = 1;
   Ipnt += Last;
  } 
 CheckFile << selex_type i endl;
   
 cout << "Completed Preliminary Calcs Section" << endl;

// =========================================================================================================

PROCEDURE_SECTION
 int i, Cnt, ifleet, IY;
  dvariable Ratio1,Ratio2,Delta;
  
  // Convert to Fs
  for (ifleet=0;ifleet<=nfleet;ifleet++)
   {
    Cnt = 0;
    for (i=styr;i<=endyr;i++)
     {
      if (effort(ifleet,i) > 0)
       {
        if (FOverWrite(ifleet,0) == 0 |i<FOverWrite(ifleet,1) | i>FOverWrite(ifleet,2))
         { Cnt += 1; FAll(ifleet,i) = FEst(ifleet,Cnt); }
        else
         FAll(ifleet,i) = -100;
       }  
      else
       FAll(ifleet,i) = 0;
     }
   }  
  
  // Fill in missing values using a ratio estimator
  for (ifleet=0;ifleet<=nfleet;ifleet++)
   if (FOverWrite(ifleet,0) > 0)
    {
     Ratio1 = 0; Ratio2 = 0;
     for (i=FOverWrite(ifleet,3);i<=FOverWrite(ifleet,4);i++)
      if (effort(ifleet,i) > 0)
       {
        Ratio1 += -log(1.0-FAll(ifleet,i))/effort(ifleet,i);
        Ratio2 += 1;
       }
     Delta = Ratio1/Ratio2;
     for (i=FOverWrite(ifleet,1);i<=FOverWrite(ifleet,2);i++)
      FAll(ifleet,i) = 1.0-mfexp(-Delta*effort(ifleet,i));
        
    }  

  // Set the growth matrix
  Set_growth();

  // Set the selectivity patterns
  Set_selex();
  
  // Set the initial size structure
  Initial_size_structure();

  // Specify survival rates
  Set_survival();
  
  // Population dynamics
  Update_population(); 

  Get_Catch_Pred();
  Get_Survey();

  ObjFunction();

  fobj = 0;
  for (i=1;i<=NPriorTerms;i++) fobj += prior_value(i)*PriorWeight(i);
  for (i=1;i<=NLikeTerms;i++) fobj += like_value(i)*DataWeight(i);
  
  LogMMB = log(MMB);
  LogRecruits = log(Recruits);
  for (IY=styr;IY<=endyr-Lag;IY++)
   LogRMMB(IY) = log(Recruits(IY+Lag)/MMB(IY));

// --------------------------------------------------------------------

FUNCTION Initial_size_structure
  int iclass;

  N.initialize();
  for (iclass=1;iclass<=nclass;iclass++)
   N(styr,iclass) = exp(logRbar)*exp(logNinitial(iclass));

// --------------------------------------------------------------------
					
FUNCTION Update_population
  int iyr,iclass,Jclass;
  dvariable MMBOut;

  for (iyr=styr;iyr<=endyr;iyr++)
   {
    // Allow animals to grow
    for (iclass=1;iclass<=nclass;iclass++)
     for (Jclass=1;Jclass<=nclass;Jclass++)
      N(iyr+1,iclass) += Trans(Jclass,iclass)*N(iyr,Jclass)*S(iyr,Jclass);
   
    // Add in recruitment
    Recruits(iyr) = mfexp(logRbar+RecDev(iyr));
    N(iyr+1,1) += Recruits(iyr);

    MMBOut = 0;
    for (iclass=1;iclass<=nclass;iclass++) 
     MMBOut += N(iyr,iclass)*fecu(iclass)*(1-FleetSelex(0,iyr,iclass)*FAll(0,iyr))*exp(-(tc(0,iyr)+2/12)*M(iyr));
    MMB(iyr) = MMBOut;
   }

// --------------------------------------------------------------------

FUNCTION Set_growth
  int iclass,Jclass;
  dvariable Total;
  
  Trans.initialize();

  for (iclass=1;iclass<nclass;iclass++)
   {
    Total = (1+mfexp(TransPars(iclass)));
    Trans(iclass,iclass) = 1/Total;
    Trans(iclass,iclass+1) =mfexp(TransPars(iclass))/Total;
   }
  Trans(nclass,nclass) = 1;                 // Special case

// --------------------------------------------------------------------

FUNCTION Set_selex
  int iclass,iyr,isurv,ifleet,Ipnt,Jpnt;
  dvariable QQ,Temp,SlopePar;
    
  // Produce all selectivities
  for (ifleet=1;ifleet<=nselex_pat;ifleet++)
   {
    Ipnt = selex_type(fleet,3);
    if (selex_type(fleet,1) == 1)
     {
      SlopePar = SelexPar(Ipnt+2);
      Temp = -log(19.0)/SlopePar;
      for (iclass=1;iclass<=nclass;iclass++)
       SelexAll(ifleet,iclass) = 1.0/(1.0+mfexp(Temp*(Length(iclass)-SelexPar(Ipnt+1))));
      Temp =  SelexAll(ifleet,nclass);
      for (iclass=1;iclass<=nclass;iclass++) SelexAll(ifleet,iclass) /= Temp;
     }
    if (selex_type(fleet,1) == 2)
     {
      for (iclass=1;iclass<=nclass;iclass++)
       SelexAll(ifleet,iclass) = 1.0/(1.0+mfexp(SelexPar(Ipnt+iclass)));
      Temp =  SelexAll(ifleet,nclass);
      for (iclass=1;iclass<=nclass;iclass++) SelexAll(ifleet,iclass) /= Temp;
     }
    if (selex_type(fleet,1) == 3)
     {
      Jpnt = selex_type(ilex_type(fleet,2),3);
      SlopePar = SelexPar(Jpnt+2);
      Temp = -log(19.0)/SlopePar;
      for (iclass=1;iclass<=nclass;iclass++)
       SelexAll(ifleet,iclass) = 1.0/(1.0+mfexp(Temp*(Length(iclass)-SelexPar(Ipnt+1))));
      Temp =  SelexAll(ifleet,nclass);
      for (iclass=1;iclass<=nclass;iclass++) SelexAll(ifleet,iclass) /= Temp;
     }
   } 

  // Fishery and bycatch selectivity
  for (ifleet=0;ifleet<=nfleet;ifleet++)
   for (iyr=styr;iyr<=endyr;iyr++)
    {
     Ipnt = FleetSelexPnt(ifleet,iyr);
     for (iclass=1;iclass<=nclass;iclass++)
      FleetSelex(ifleet,iyr,iclass) = SelexAll(Ipnt,iclass) ;
    }  
  
  // Retention in the pot fishery
  for (iyr=styr;iyr<=endyr;iyr++)
   for (iclass=1;iclass<=nclass;iclass++)
    {
     Ipnt = (FleetRetPnt(iyr)-1)*nclass;
     RetCatMale(iyr,iclass) = (1-hg(iyr))/(1.0+mfexp(RetainPar(Ipnt+iclass)));
    } 

  // Survey selectivity
  for (isurv=1;isurv<=nsurvey;isurv++)
   for (iyr=styr;iyr<=endyr+1;iyr++)
    {
     Ipnt = SurveyQPnt(isurv,iyr);
     QQ = exp(LogSurveyQ(Ipnt));
     Ipnt = SurveySelexPnt(isurv,iyr);
     for (iclass=1;iclass<=nclass;iclass++)
      SelexSurvey(isurv,iyr,iclass) = QQ*SelexAll(Ipnt,iclass);
    }  
   
  // Nest one survey within another
  for (Ipnt=1;Ipnt <=NsubSurveyFleets;Ipnt++)
   for (iyr=styr;iyr<=endyr+1;iyr++)
    for (iclass=1;iclass<=nclass;iclass++)
     SelexSurvey(SubFltSpec(Ipnt,1),iyr,iclass) *= SelexSurvey(SubFltSpec(Ipnt,2),iyr,iclass);

// --------------------------------------------------------------------

FUNCTION Set_survival;
  int iyr,iclass,ifleet;

  // Specify M
  M = M0;
  for (iyr=styr;iyr<=endyr;iyr++) if (Mpnt(iyr)>1) M(iyr) += Mm(Mpnt(iyr)); 
  
  for (iyr=styr;iyr<=endyr;iyr++)
   for (iclass=1;iclass<=nclass;iclass++)
    {
     S(iyr,iclass) = mfexp(-M(iyr));
     for (ifleet=0;ifleet<=nfleet;ifleet++)
      {
       SF(ifleet,iyr,iclass) = (1-FleetSelex(ifleet,iyr,iclass)*FAll(ifleet,iyr));
       ExplRates(ifleet,iyr) = FAll(ifleet,iyr);
       S(iyr,iclass) *= SF(ifleet,iyr,iclass);
      } 
     Fdirect(iyr) = FleetSelex(0,iyr,nclass)*FAll(0,iyr);
    }

// --------------------------------------------------------------------

FUNCTION Get_Catch_Pred;
  int iyr,iclass,ifleet;
  dvariable S1,S2;
  dvariable SurvNo;                              // Numbers at fishery
  
  CatFleet.initialize();
  CatFleetWghtPred.initialize();
  CatFleetNumPred.initialize();
  
  for (iyr=styr;iyr<=endyr;iyr++)
   for (iclass=1;iclass<=nclass;iclass++)
    {
     SurvNo = N(iyr,iclass)*mfexp(-tc(0,iyr)*M(iyr));
     S1 = SF(0,iyr,iclass);
     CatFleet(0,iyr,iclass) = SurvNo*(1-S1)*RetCatMale(iyr,iclass);
     CatFleet(-1,iyr,iclass) = SurvNo*(1-S1)*(1-RetCatMale(iyr,iclass));
     SurvNo *= S1;
     for (ifleet=1;ifleet<=nfleet;ifleet++)
      {
       S2 = SF(ifleet,iyr,iclass);
       CatFleet(ifleet,iyr,iclass) = SurvNo*(1-S2);
       SurvNo *= S2;
      }
      
     // Accumulate totals 
     for (ifleet=-1; ifleet<=nfleet;ifleet++)
      {
       CatFleetWghtPred(ifleet,iyr) += CatFleet(ifleet,iyr,iclass) * Wght(iclass);
       CatFleetNumPred(ifleet,iyr) += CatFleet(ifleet,iyr,iclass);
      } 
      
    }
   
  // Special case for fleet -1
  if (DiscardsOrTotal == 1)
   for (iyr=styr;iyr<=endyr;iyr++)
    for (iclass=1;iclass<=nclass;iclass++)
     CatFleet(-1,iyr,iclass) = CatFleet(-1,iyr,iclass) + CatFleet(0,iyr,iclass);
  
// =====================================================================

FUNCTION Get_Survey
  int iyr,iclass,isurv;
  
  for (isurv=1;isurv<=nsurvey;isurv++)
   for (iyr=styr;iyr<=endyr+1;iyr++)
    for (iclass=1;iclass<=nclass;iclass++)
     PredSurvey(isurv,iyr,iclass) = N(iyr,iclass)*SelexSurvey(isurv,iyr,iclass);
    
  PredSurveyNum.initialize();
  PredSurveyWght.initialize();
  for (isurv=1;isurv<=nsurvey;isurv++)
   for (iyr=styr;iyr<=endyr+1;iyr++)
    for (iclass=1;iclass<=nclass;iclass++)
     {
      PredSurveyWght(isurv,iyr) += PredSurvey(isurv,iyr,iclass)*Wght(iclass);
      PredSurveyNum(isurv,iyr) += PredSurvey(isurv,iyr,iclass);
     }
  

// =====================================================================

FUNCTION calc_objective_function
  
  int iyr,icnt,iclass,ifleet,isurv,jpnt,iselex;
  dvariable incc,incd,total,error,penal;
  dvariable meanf, nn;
  
  incc = 0.00001;
  incd = 0.0001;

  prior_value.initialize(); 
  like_value.initialize();
  
  // PRIORS
  //================================================================================
  
  // Prior on F-devs 
  for (ifleet=0; ifleet<=nfleet; ifleet++)
   {
    MeanF = 0; nn = 0;
    for (iyr=styr; iyr<=endyr; iyr++) 
     if (effort(ifleet,iyr) > 0) { MeanF += f_all(ifleet,iyr); nn+= 1; }
    MeanF /= nn;
    for (iyr=styr;iyr<=endyr;iyr++) 
     if (effort(ifleet,iyr) > 0) prior_value(ifleet+1) += square(FAll(ifleet,iyr)-MeanF);
    } 
  Jpnt = nfleet+1;
  
  // Prior on Rec Devs
  for (iyr=styr;iyr<=endyr;iyr++) prior_value(Jpnt+1) += square(RecDev(iyr));
    
  // penalties on parameters
  prior_value(Jpnt+2) = sum(square(TransPars));
  for (ifleet=1;ifleet<=nselex;ifleet++)
   if (selex_phz(ifleet) > 0)
    prior_value(Jpnt+3) += square(SelexPar(ifleet));
  prior_value(Jpnt+4) = sum(square(RetainPar));
  prior_value(Jpnt+5) = 0;
  
  // q - prior
  for (isurv=1;isurv<=NSurveyQ;isurv++)
   if (SurveyQPSD(isurv) > 0)
     prior_value(Jpnt+5+isurv) = square(exp(LogSurveyQ(isurv))-SurveyQPMean(isurv))/(2.0*square(SurveyQPSD(isurv)));
  Jpnt = Jpnt+5+NSurveyQ;
  
  // M-prior
  prior_value(Jpnt+1) = square(M0-MPriorMean)/(2.0*square(MPriorSD));
  Jpnt += 1;

  // 2nd derivative penalty
  Penal = 0;
  for (Iselex=1;Iselex<=nselex_pat;Iselex++)
   if (selex_type(ielex,1) == 2)
    for (iclass=2;iclass<=nclass-1;iclass++)
     Penal += square(SelexAll(Iselex,iclass-1)-2.0*SelexAll(Iselex,iclass)+SelexAll(Iselex,iclass+1));
  prior_value(Jpnt+1) = Penal;   
      
  // DATA COMPONENTS
  //================================================================================

  // Likelihood for Catches
  for (ifleet=-1;ifleet<=nfleet;ifleet++)
   for (iyr=styr;iyr<=endyr;iyr++)
    if (CatchAndDiscard(ifleet,iyr) > 0)
     {
      if(CatchUnit(ifleet) == 1)
       like_value(ifleet+2) += square(log((CatFleetWghtPred(ifleet,iyr)+incd)/(CatchAndDiscard(ifleet,iyr)+incd)));
      else
       like_value(ifleet+2) += square(log((CatFleetNumPred(ifleet,iyr)+incd)/(CatchAndDiscard(ifleet,iyr)+incd)));
     }  
  Jpnt = nfleet+2;
 
  // Survey indices 
  for (isurv=1;isurv<=nsurvey;isurv++)
   for (iyr=styr;iyr<=endyr;iyr++)
    if (SurveyEst(isurv,iyr,1) > 0)
     {
      if(SurveyUnit(isurv) == 1)
       like_value(Jpnt+isurv) += 0.5*square(log((SurveyEst(isurv,iyr,1)+incd)/(PredSurveyWght(isurv,iyr)+incd)))/square(SurveyEst(isurv,iyr,2));
      else 
       like_value(Jpnt+isurv) += 0.5*square(log((SurveyEst(isurv,iyr,1)+incd)/(PredSurveyNum(isurv,iyr)+incd)))/square(SurveyEst(isurv,iyr,2));
      }  
   Jpnt = Jpnt + nsurvey;   
  
  // effort indices
  qEff.initialize();
  for (ifleet=0;ifleet<=nfleet;ifleet++)
   {
    nn= 0;
    for (iyr=styr;iyr<=endyr;iyr++)
     if (effort(ifleet,iyr) > 0) 
      {
       if (FOverWrite(ifleet,0) == 0 |iyr<FOverWrite(ifleet,1) | iyr>FOverWrite(ifleet,2))
        { nn += 1; qEff(ifleet) += log((effort(ifleet,iyr)+incd)/(ExplRates(ifleet,iyr)+incd)); }
      }  
    qEff(ifleet) = mfexp(qEff(ifleet)/nn); 
    for (iyr=styr;iyr<=endyr;iyr++)
     if (effort(ifleet,iyr) > 0)
      if (FOverWrite(ifleet,0) == 0 |iyr<FOverWrite(ifleet,1) | iyr>FOverWrite(ifleet,2))
       like_value(Jpnt+ifleet+1) += square(log((effort(ifleet,iyr)+incd)/(qEff(ifleet)*(ExplRates(ifleet,iyr)+incd))));
   }  
  Jpnt = Jpnt + (nfleet+1); 

  // Catch LFs
  for (ifleet=-1;ifleet<=nfleet;ifleet++)
   for (Icnt=1;Icnt<=NLFfleet(ifleet);Icnt++)
    {
     iyr = YrFleetLF(ifleet,Icnt);
     Total = 0;
     for (iclass=1;iclass<=nclass;iclass++) Total += CatFleet(ifleet,iyr,iclass);
     for (iclass=1;iclass<=nclass;iclass++) CatFleet(ifleet,iyr,iclass) /= Total;
     for (iclass=1;iclass<=nclass;iclass++)
      if (FleetObsLF(ifleet,Icnt,iclass) > 0)
       {
        Error = (CatFleet(ifleet,iyr,iclass)+incc)/(FleetObsLF(ifleet,Icnt,iclass)+incc);
        like_value(Jpnt+2+ifleet) += -1*SSFleetLF(ifleet,Icnt)*FleetObsLF(ifleet,Icnt,iclass)*log(Error);
       }
    } 
   Jpnt = Jpnt + (nfleet+2);
     
  // Survey LF
  for (isurv=1;isurv<=nsurvey;isurv++)
   for (Icnt=1;Icnt<=NLFsurvey(isurv);Icnt++)
    {
     iyr = YrSurveyLF(isurv,Icnt);
     Total = 0;
     for (iclass=1;iclass<=nclass;iclass++) Total += PredSurvey(isurv,iyr,iclass);
     for (iclass=1;iclass<=nclass;iclass++) PredSurvey(isurv,iyr,iclass) /= Total;
     for (iclass=1;iclass<=nclass;iclass++)
      if (SurveyObsLF(isurv,Icnt,iclass) > 0)
       {
        Error = (PredSurvey(isurv,iyr,iclass)+incc)/(SurveyObsLF(isurv,Icnt,iclass)+incc);
        like_value(Jpnt+isurv) += -1*SSSurveyLF(isurv,Icnt)*SurveyObsLF(isurv,Icnt,iclass)*log(Error);
       }
    } 
 // cout << prior_value << endl;
 // cout << like_value << endl;  

 // TODO: Include dummy phase in above Objective Function Calc: For like_value

       obj_fun += square(dummy_datum-dummy_parm);
//   cout<<" obj_fun dummy "<<obj_fun<<endl;
                                                    
 // =====================================================================

FUNCTION Find_F35
 int i;
 dvariable SBPR0,Fmin,Fmax,Ratio;

 // Find virgin SPR
 IsB0 = -1;
 SR_rel = 1;
 Fmult = 0;
 ProjConstF();
 SBPR0 = MMBOut;
 cout << " SSBPR0 " << SBPR0 << endl;

 // Step through the Fs
 IsB0 = 1;
 for (i=1;i<=10000;i=i+10)
  {
   Fmult = float(i)*0.001;
   ProjConstF();
   Ratio = MMBOut/SBPR0;
   if (Ratio < 0.35) i = 20000;
  }

 // Bisect
 Fmax = Fmult;
 Fmin = Fmult-0.1;
 for (i=1;i<=20;i++)
  {
   Fmult = (Fmin+Fmax)/2.0;
   ProjConstF();
   Ratio = MMBOut/SBPR0;
   if (Ratio > 0.35)
    Fmin = Fmult;
   else
    Fmax = Fmult; 
  }
 if (fabs(Ratio-0.35) > 0.001) cout << "Problem" << endl; 

 // Set F35%
 F35 = Fmult;

 // Find SBPR35%
 Fmult = F35;
 ProjConstF();
 SBPR35 = MMBOut/RecOut;
 cout << "F35 " << F35 << " " << SBPR35 << " " << Ratio << " " << CatchOut << endl;

// =====================================================================

FUNCTION Get_Steepness
  dvariable RbarFmsy, nn, BmsyProx, SBPR;
  dvariable DerivMin,DerivMax,MaxSteep,MinSteep,Cat1,Cat2,Deriv,Term1,Term2;
  dvariable BioDep;
  int iy,i,ISteep;

  // Get initial R0
  IsB0 = -1;
  SR_rel = 1;
  Fmult = 0;
  ProjConstF();
  SBPR = MMBOut / RecOut;
  MMB0 = MMBOut;
  R0 = RecOut;
  IsB0 = 1;
  
  // Find recruitment at BMSY
  RbarFmsy = 0; nn = 0;
  for (iy=BMSY_Y1;iy<=BMSY_Y2;iy++){ RbarFmsy += Recruits(iy); nn += 1; }
  RbarFmsy /= nn;
  
  // Find the BMSY proxy
  BmsyProx = SBPR35 * RbarFmsy;
  MMB0 = BmsyProx / 0.35;
  R0 = MMB0 / SBPR;

  SR_rel = SR_RelAct;
  if (SR_rel == 2)
   {  MinSteep = 0.21; MaxSteep = 0.99; ISteep = 99; }
  if (SR_rel == 3)
   {  MinSteep = 0.21; MaxSteep = 5.00; ISteep = 500; }
  DerivMin = -1.0e20; DerivMax = 1.0e20;
  for (i=21;i<=ISteep;i++)
   {
    Steep = float(i)*0.01;
    Fmult = F35 + 0.001;
    ProjConstF();
    Cat1 = CatchOut;
    Fmult = F35 - 0.001;
    ProjConstF();
    Cat2 = CatchOut;
    Deriv = (Cat1-Cat2)/0.002;
    if (Deriv < 0 & Deriv > DerivMin) { MinSteep = Steep; DerivMin = Deriv; }
    if (Deriv > 0 & Deriv < DerivMax) { MaxSteep = Steep; DerivMax = Deriv; }
 //   cout << Steep << " " <<  Cat1 << " " << Cat2 << " " << (Cat1-Cat2)/0.002 << " " << MinSteep << " " << 
 //    DerivMin << " " << MaxSteep << " " << DerivMax << endl;  
   }

 // Solve for FMSY (fine search)
 for (i=1;i<=40;i++)
  {
   Steep = value((MinSteep+MaxSteep)/2.0);
   R0 = MMB0 / SBPR;
   Fmult = F35 + 0.001;
   ProjConstF();
   Cat1 = CatchOut;
   Fmult = F35 - 0.001;
   ProjConstF();
   Cat2 = CatchOut;
   Deriv = (Cat1-Cat2)/0.001;
   if (Deriv < 0) MinSteep = Steep; else MaxSteep = Steep; 
  }
 Fmult = F35; 
 ProjConstF();
 BioDep = MMBOut/MMB0;
 
  // Now compute B0 given R at BMSY;
 if (SR_rel == 2)
  {
   Term1 = (1-Steep) + (5*Steep-1)*BioDep;
   Term2 = 4*Steep*BioDep;
   R0 = RbarFmsy*Term1/Term2;
  }
 if (SR_rel == 3)
  {
   Term1 = exp(5.0/4.0*log(5*Steep-1)*BioDep);
   R0 = RbarFmsy / BioDep / Term1;
  }
 MMB0 = R0*SBPR;
 cout << "Final: " << Steep << " " << R0 << " " << MMB0 << " " << BioDep << " " << Deriv << endl;
 cout << "Recruit/spawner at FMSY: " << 1/SBPR35 << " " << RbarFmsy << " " << BmsyProx << endl;

 for(i=1;i<=141;i++)
  {
   Fmult = (float(i)/21.0)*F35;
   ProjConstF();
   cout << "T " << Fmult/F35 << " " << CatchOut << " " << MMBOut/MMB0 << " "  << MMBOut/BmsyProx << endl;
  }

// =====================================================================

FUNCTION ProjConstF
 dvariable AveRec,MMB,S1,SurvNo,CatRetTmp,Term1,Term2,TheMort;
 dvar_vector SF1F(1,nclass),SF2F(1,nclass),SF3F(1,nclass),SF(1,nclass);
 dvar_matrix NFut(1,100,1,nclass);
 int iy,iclass,Jclass,FutYr,ifleet;

 NFut.initialize();

 // Mortality due to other fleets
 for (ifleet=1;ifleet<=nfleet;ifleet++)
  {
   TheMort = 0;
   for (iy=endyr-4;iy<=endyr;iy++) TheMort += FAll(ifleet, iy);
   MortF(ifleet) = TheMort / 5;
  }
 
 if (IsB0 == -1) { MortF.initialize(); }
 
 // Average recruitment
 AveRec = 0;
 for (iy=endyr-4;iy<=endyr;iy++) AveRec += mfexp(logRbar+RecDev(iy));
 AveRec /= 5;
 AveRec = 1;

 // Survival
 for (iclass=1;iclass<=nclass;iclass++)
  {
   SF1F(iclass) = 1-FleetSelex(0,endyr,iclass)*Fmult;
   SF(iclass) = mfexp(-M(endyr))*SF1F(iclass);
   for (ifleet=1;ifleet<=nfleet;ifleet++)
    SF(iclass) *= (1- FleetSelex(ifleet,endyr,iclass)*MortF(ifleet));
  }
 
 // Copy Ns (irrelevant)
 for (iclass=1;iclass<=nclass;iclass++) NFut(1,iclass) = N(endyr+1,iclass);
 for (iclass=1;iclass<=nclass;iclass++) NFut(1,iclass) = 1;

 for (FutYr=1;FutYr<=99;FutYr++)
  {
    // Stock-recruitment relationship
    if (SR_rel == 2)
     {
      if (FutYr-Lag <= 1) 
       MMB = MMB0;
      else
       MMB = mbio(FutYr-Lag); 
      Term1 = 4*R0*Steep*MMB/MMB0;
      Term2 = (1-Steep) + (5*Steep-1)*MMB/MMB0;
      RecOut = Term1/Term2;
     }
    else
     if (SR_rel == 3)
      {
       if (FutYr-Lag <= 1) 
        MMB = MMB0;
       else
        MMB = mbio(FutYr-Lag); 
       Term1 = R0*MMB/MMB0;
       Term2 = 5.0/4.0*log(5*Steep)*(1-MMB/MMB0);
       RecOut = Term1*mfexp(Term2);
      }
     else
      RecOut = AveRec;
  
   // Compute catch
   CatchOut = 0;
   for (iclass=1;iclass<=nclass;iclass++)
    {
     S1 = 0.9999*SF1F(iclass);
     SurvNo = NFut(FutYr,iclass)*mfexp(-gamma*M(endyr));
     CatRetTmp = SurvNo*(1-S1)*RetCatMale(endyr-5,iclass);
     CatchOut += CatRetTmp* Wght(iclass);
    }
 
   // Allow animals to grow
   for (iclass=1;iclass<=nclass;iclass++)
    for (Jclass=1;Jclass<=nclass;Jclass++)
     NFut(FutYr+1,iclass) += Trans(Jclass,iclass)*NFut(FutYr,Jclass)*SF(Jclass);
   
   // Add in recruitment
   NFut(FutYr+1,1) += RecOut;

   // Compute MMB
   MMBOut = 0;
   for (iclass=1;iclass<=nclass;iclass++) 
    MMBOut += NFut(FutYr,iclass)*fecu(iclass)*(1-FleetSelex(0,endyr,iclass)*Fmult)*mfexp(-(gamma+2.0/12.0)*M(endyr));
   mbio(FutYr) = MMBOut;
  }

FUNCTION initParameters
  {
	/* Leading parameters */
	log_ddot_r = theta(1);
	log_bar_r  = theta(2);	
	m_infty    = theta(3);
	l_infty    = theta(4);
	vbk        = theta(5);
	beta       = theta(6);
	mu_r       = theta(7);
	cv_r       = theta(8);
  }
//


// =========================================================================================================

REPORT_SECTION
	int i,j,im;
	REPORT(f          );
	REPORT(log_ddot_r );
	REPORT(log_bar_r  );
	REPORT(m_infty    );
	REPORT(l_infty    );
	REPORT(vbk        );
	REPORT(beta       );
	REPORT(mu_r       );
	REPORT(cv_r       );
	REPORT(log_bar_f  );
	REPORT(tau        );
	
	ivector yr(styr,endyr);
	yr.fill_seqadd(styr,1);
	REPORT(yr);
	REPORT(ngear);
	REPORT(irow);
	REPORT(jcol);
	REPORT(xmid);
	REPORT(mx);
	REPORT(sx);
	
	REPORT(delta);
	
	dvector Nt = value(rowsum(N));
	dvector Tt = value(rowsum(T));
	dvector Rt(styr,endyr);
	for(i=styr;i<=endyr;i++)
	{
		if(i==styr) Rt(i) = value(mfexp(log_ddot_r+ddot_r_devs(nx)));
		else       Rt(i) = value(mfexp(log_rt(i)));
	}
	REPORT(Nt);
	REPORT(Tt);
	REPORT(Rt);
	
	REPORT(log_rt);
	REPORT(fi);
	REPORT(effort);
	REPORT(bar_f_devs);
	
	REPORT(N);
	REPORT(T);
	REPORT(i_C);
	REPORT(i_M);
	REPORT(i_R);
	REPORT(Chat);
	REPORT(Mhat);
	REPORT(Rhat);
	REPORT(A);
	if(SimFlag)
	{
		REPORT(true_Nt);
		REPORT(true_Rt);
		REPORT(true_Tt);
		REPORT(true_fi);
	}

// =========================================================================================================

FINAL_SECTION
	
	// Create final time stamp and determe runtime:
	time(&finish);
	elapsed_time=difftime(finish,start);
	hour=long(elapsed_time)/3600;
	minute=long(elapsed_time)%3600/60;
	second=(long(elapsed_time)%3600)%60;
	
	// Print runtime records to screen:
	cout << endl << endl << "*******************************************" 	<< endl;
	cout << 				"--Start time: "		<<	ctime(&start)		<< endl;
	cout <<					"--Finish time: "		<< 	ctime(&finish)		<< endl;
	cout <<					"--Runtime: ";
	cout <<	hour <<" hours, "<<minute<<" minutes, "<<second<<" seconds"		<< endl;
	cout <<					"*******************************************"	<< endl;

// =========================================================================================================

RUNTIME_SECTION
    maximum_function_evaluations 500,1500,2500,25000,25000
    convergence_criteria 0.01,1.e-4,1.e-5,1.e-5

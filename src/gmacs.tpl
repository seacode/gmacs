// =========================================================================================================
//																			 
// 	Gmacs: Generalized Modelling for Alaskan Crab Stocks.
//
// 	Created by Athol Whitten, University of Washington 	
// 	Info: https://github.com/awhitten/gmacs or write to whittena@uw.edu
// 	Copyright (c) 2014. All rights reserved.
//
// 	Acknowledgement: The format for this code, and many of the details,
// 		were adapted from the 'LSMR' model by Steven Martell (2011).
//
// 	TO DO LIST:
//  -Model numbers-at-length on an annual time step, then in the observation
//   submodel, grow and survive numbers-at-length upto the time step samples
//   were collected.  This will require transition matrix for dt and annual
//   transition matrix.
//	
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
	!! echotxt(tstep, " Eime-step");
	
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

	init_matrix catch_data(1,ncatch_obs,1,4);	 	///< Catch data matrix, one line per ncatch_obs, requires year, season, fleet, observation
	init_matrix survey_data(1,nsurvey_obs,1,5);	 	///< Survey data matrix, one line per nsurvey_obs, requires year, season, survey, observation, and error

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
	init_matrix effort(1,nfleet,styr,endyr);		///< Effort by fishery
	init_imatrix f_new(1,nfleet,1,5);				///< Alternative f estimators (overwrite others)

	!! echo(discard_mort);
	!! echo(retention);
	!! echo(catch_time);
	!! echo(effort);
	!! echo(f_new);

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

	init_vector nat_mort(styr,endyr);				///< Natural mortality pointer
	init_vector mean_length(1,ndclass); 			///< Mean length vector
	init_vector mean_weight(1,ndclass); 			///< Mean weight vector
	init_vector fecundity(1,ndclass);				///< Fecundity vector

	!! echo(nat_mort);
	!! echo(mean_length);
	!! echo(mean_weight);
	!! echo(fecundity);

	init_int lf_flag; 								///< Length comp data for discard fleet (-1): total catch (1) or  discards (2)
  	
  	!! echotxt(lf_flag,  " Length freq data for discard fleet: flag for catch or discards");

	init_int nlf_obs;								///< Number of length frequency lines to read	
	init_matrix lf_data(1,nlf_obs,1,ndclass+5);		///< Length frequency data, one line per nlf_obs, requires year, season, fleet, sex, effective sample size, then data vector 

	init_int nlfs_obs;								///< Number or survey length frequency lines to read
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

	//TODO: Check if above row for retenion applies to discard fishery or to linked retained fishery:
	
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

	// PICK UP FROM HERE: FINISH CONTROL FILES SPECS, Remember to place Madd section in general parameters matrix.
  

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

	// Create count of active parameters and derived quantities
	int par_count;
	int active_count;
	int active_parms;
	ivector active_parm(1,ntheta);  //  Pointer from active list to the element of the full parameter list to get label (TODO: ADD THIS)

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

	//TODO: Adjust this section to include other parameters not specified in the general paramter matrix 'theta'

// =========================================================================================================

PARAMETER_SECTION
	init_bounded_number_vector theta(1,ntheta,theta_lbnd,theta_ubnd,theta_phz);
	number log_ddot_r;
	number log_bar_r;
	number m_infty;

	//Variables for growth.
	number l_infty;
	number vbk;
	number beta;
	
	//Variables for size distribution of new recruits
	number mu_r;
	number cv_r
	
	//Mean fishing mortality rates
	init_vector log_bar_f(1,ngear,-2);
	
	//Overdispersion
	init_vector log_tau(1,ngear,-5);
	
	//Selectivity parameters
	init_bounded_vector_vector sel_par(1,ngear,1,isel_npar,-5.,5.,sel_phz);
	LOC_CALCS
		int k;
		for(k=1;k<=ngear;k++)
		{
			if( sel_type(k)==1 )
			{
				sel_par(k,1) = log(lx_ival(k));
				sel_par(k,2) = log(gx_ival(k));
			}
			if( sel_type(k)==2 )
			{
				sel_par(k,1) = log(lx_ival(k));
				sel_par(k,2) = log(gx_ival(k));
				sel_par(k,3) = -4.0;
			}
		}
	END_CALCS
	
	init_bounded_dev_vector ddot_r_devs(1,nx,-15,15,-2);
	init_bounded_dev_vector bar_r_devs(styr+1,endyr,-15,15,-2);
	!! int phz;
	!! if(flag(4)==1) phz=3; else phz=-3;
	init_bounded_dev_vector l_infty_devs(styr,endyr-1,-5,5,phz);
	
	
	//TODO Fix this so there is a dev vector for each gear, otherwise biased estimates of log_bar_f
	init_bounded_matrix bar_f_devs(1,ngear,1,fi_count,-5.0,5.0,-2);
	
	sdreport_number sd_l_infty;
	
	objective_function_value f;
	
	number m_linf;
	number fpen;
	vector tau(1,ngear);	// over-dispersion parameters >1.0
	vector qk(1,ngear);		// catchability of gear k
	vector mx(1,nx);		// Mortality rate at length xmid
	vector rx(1,nx);		// size pdf for new recruits
	
	vector log_rt(styr+1,endyr);
	matrix fi(1,ngear,1,irow);	// capture probability in period i.
	matrix sx(1,ngear,1,jcol);	// Selectivity at length xmid
	matrix N(styr,endyr,1,nx);		// Numbers(time step, length bins)
	matrix T(styr,endyr,1,nx);		// Marks-at-large (time step, length bins)
	matrix A(1,nx,1,nx);		// Size-transitin matrix (annual step)
	//matrix P(1,nx,1,nx);		// Size-Transition Matrix for step dt
	
	// Predicted observations
	matrix hat_ct(1,ngear,1,irow);			  // Predicted total catch
	matrix delta(1,ngear,1,irow);			    // residuals in total catch
	3darray Chat(1,ngear,1,irow,1,jcol);	// Predicted catch-at-length
	3darray Mhat(1,ngear,1,irow,1,jcol);	// Predicted new marks-at-length
	3darray Rhat(1,ngear,1,irow,1,jcol);	// Predicted recaptures-at-length
	3darray iP(styr,endyr,1,nx,1,nx);			// Size transition matrix for year i;

	//  Create dummy parameter that will be estimated when final_phase is set to 0
  	init_bounded_number dummy_parm(0,2,dummy_phase)  //  Estimate in phase 0

	
// =========================================================================================================
	
INITIALIZATION_SECTION
	theta     theta_init;
	log_bar_f -3.5;
	log_tau   1.1;

// =========================================================================================================

PRELIMINARY_CALCS_SECTION
  int Iyr,Iclass,Jclass,Ifleet,Isurv,j,Ipnt,Jpnt,Last,SelType;
  float Total,NumSS,Scalar;
  dvector TotalSS(-1,Nfleet);
  dmatrix SSFStore(-1,Nfleet,1,maxFleetLF);
  dmatrix SSSStore(1,Nsurvey,1,maxSurveyLF);
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
    for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
     for (Iyr=1;Iyr<=NcatchF(Ifleet);Iyr++) FEst(Ifleet,Iyr) = 0.1;
    for (Iyr=Yr1;Iyr<=Yr2;Iyr++) RecDev(Iyr) = 0; 
   }
  if (Diag == 1) cout << "PIN File specified" << endl; 

  Total = 0;
  for (Iclass=1;Iclass<=NallClass;Iclass++)
   {
    SurvLFStore(Iclass) = 0;
    for (Iyr=1;Iyr<=NLFsurvey(1);Iyr++) SurvLFStore(Iclass) += SurveyLF(1,Iyr,Iclass);
    Total += SurvLFStore(Iclass);
   }
  if (Diag == 1) cout << "Survey sample sizes stored" << endl; 

  CheckFile << "Class Length, Weight Fecundity" << endl;
  for (Iclass=1;Iclass<=nclass;Iclass++)
   {
    Length(Iclass) = 0; Wght(Iclass) = 0; fecu(Iclass) = 0; Total = 0;
    for (Jclass=ClassLink(Iclass,1);Jclass<=ClassLink(Iclass,2);Jclass++)
     {
      Length(Iclass) += Length_inp(Jclass)*SurvLFStore(Jclass);
      Wght(Iclass) += Wght_inp(Jclass)*SurvLFStore(Jclass);
      fecu(Iclass) += fecu_inp(Jclass)*SurvLFStore(Jclass);
      Total += SurvLFStore(Jclass);
     }
     Length(Iclass) /= Total;
     Wght(Iclass) /= Total;
     fecu(Iclass) /= Total;
     CheckFile << Iclass << " " << Length(Iclass) << " " << Wght(Iclass) << " " << fecu(Iclass) << endl;
    }
  if (Diag == 1) cout << "Lengths and weights specified" << endl; 
  
  FleetObsLF.initialize();
  for (Ifleet=-1;Ifleet<=Nfleet;Ifleet++)
   {
    TotalSS(Ifleet) = 0; NumSS = 0;
    for (Iyr=1;Iyr<=NLFfleet(Ifleet);Iyr++)
     {
      for (Iclass=1;Iclass<=nclass;Iclass++)
       for (Jclass=ClassLink(Iclass,1);Jclass<=ClassLink(Iclass,2);Jclass++)
        FleetObsLF(Ifleet,Iyr,Iclass) += FleetLF(Ifleet,Iyr,Jclass);
      Total = 0;
      for (Iclass=1;Iclass<=nclass;Iclass++) Total += FleetObsLF(Ifleet,Iyr,Iclass);
      SSFStore(Ifleet,Iyr) = Total;
      TotalSS(Ifleet) += Total; NumSS += 1;
      for (Iclass=1;Iclass<=nclass;Iclass++) FleetObsLF(Ifleet,Iyr,Iclass) /= Total;
     }
    TotalSS(Ifleet) /= NumSS; 
   }
 Scalar = TotalSS(0);
 for (Ifleet=-1;Ifleet<=Nfleet;Ifleet++)
  for (Iyr=1;Iyr<=NLFfleet(Ifleet);Iyr++) 
   {
    SSFleetLF(Ifleet,Iyr) = 200*SSFStore(Ifleet,Iyr) / Scalar;
    if (SSFleetLF(Ifleet,Iyr) > 200) SSFleetLF(Ifleet,Iyr) = 200;
    if (SSFleetLF(Ifleet,Iyr) < 4) SSFleetLF(Ifleet,Iyr) = 4;
   }  
 if (Diag == 1) cout << "Fishery effective sample sizes specified" << endl; 
    
 CheckFile << "Used Fishery LF" << endl;
 CheckFile << FleetObsLF << endl;
  
 SurveyObsLF.initialize();
 for (Isurv=1;Isurv<=Nsurvey;Isurv++)
  {
   for (Iyr=1;Iyr<=NLFsurvey(Isurv);Iyr++)
    {
     for (Iclass=1;Iclass<=nclass;Iclass++)
      for (Jclass=ClassLink(Iclass,1);Jclass<=ClassLink(Iclass,2);Jclass++)
       SurveyObsLF(Isurv,Iyr,Iclass) += SurveyLF(Isurv,Iyr,Jclass);
     Total = 0;
     for (Iclass=1;Iclass<=nclass;Iclass++) Total += SurveyObsLF(Isurv,Iyr,Iclass);
     SSSStore(Isurv,Iyr) = Total;
     for (Iclass=1;Iclass<=nclass;Iclass++) SurveyObsLF(Isurv,Iyr,Iclass) /= Total;
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
 int i, Cnt, Ifleet, IY;
  dvariable Ratio1,Ratio2,Delta;
  
  // Convert to Fs
  for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
   {
    Cnt = 0;
    for (i=Yr1;i<=Yr2;i++)
     {
      if (Effort(Ifleet,i) > 0)
       {
        if (FOverWrite(Ifleet,0) == 0 |i<FOverWrite(Ifleet,1) | i>FOverWrite(Ifleet,2))
         { Cnt += 1; FAll(Ifleet,i) = FEst(Ifleet,Cnt); }
        else
         FAll(Ifleet,i) = -100;
       }  
      else
       FAll(Ifleet,i) = 0;
     }
   }  
  
  // Fill in missing values using a ratio estimator
  for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
   if (FOverWrite(Ifleet,0) > 0)
    {
     Ratio1 = 0; Ratio2 = 0;
     for (i=FOverWrite(Ifleet,3);i<=FOverWrite(Ifleet,4);i++)
      if (Effort(Ifleet,i) > 0)
       {
        Ratio1 += -log(1.0-FAll(Ifleet,i))/Effort(Ifleet,i);
        Ratio2 += 1;
       }
     Delta = Ratio1/Ratio2;
     for (i=FOverWrite(Ifleet,1);i<=FOverWrite(Ifleet,2);i++)
      FAll(Ifleet,i) = 1.0-mfexp(-Delta*Effort(Ifleet,i));
        
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

  fout = 0;
  for (i=1;i<=NPriorTerms;i++) fout += PriorVal(i)*PriorWeight(i);
  for (i=1;i<=NLikeTerms;i++) fout += LikeVal(i)*DataWeight(i);
  //cout << PriorVal << endl;
  //cout << LikeVal << endl;
  //cout << fout << endl;
  // exit(1);

  LogMMB = log(MMB);
  LogRecruits = log(Recruits);
  for (IY=Yr1;IY<=Yr2-Lag;IY++)
   LogRMMB(IY) = log(Recruits(IY+Lag)/MMB(IY));

// --------------------------------------------------------------------

FUNCTION Initial_size_structure
  int Iclass;

  N.initialize();
  for (Iclass=1;Iclass<=nclass;Iclass++)
   N(Yr1,Iclass) = exp(logRbar)*exp(logNinitial(Iclass));

// --------------------------------------------------------------------
					
FUNCTION Update_population
  int Iyr,Iclass,Jclass;
  dvariable MMBOut;

  for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
   {
    // Allow animals to grow
    for (Iclass=1;Iclass<=nclass;Iclass++)
     for (Jclass=1;Jclass<=nclass;Jclass++)
      N(Iyr+1,Iclass) += Trans(Jclass,Iclass)*N(Iyr,Jclass)*S(Iyr,Jclass);
   
    // Add in recruitment
    Recruits(Iyr) = mfexp(logRbar+RecDev(Iyr));
    N(Iyr+1,1) += Recruits(Iyr);

    MMBOut = 0;
    for (Iclass=1;Iclass<=nclass;Iclass++) 
     MMBOut += N(Iyr,Iclass)*fecu(Iclass)*(1-FleetSelex(0,Iyr,Iclass)*FAll(0,Iyr))*exp(-(tc(0,Iyr)+2/12)*M(Iyr));
    MMB(Iyr) = MMBOut;
   }

// --------------------------------------------------------------------

FUNCTION Set_growth
  int Iclass,Jclass;
  dvariable Total;
  
  Trans.initialize();

  for (Iclass=1;Iclass<nclass;Iclass++)
   {
    Total = (1+mfexp(TransPars(Iclass)));
    Trans(Iclass,Iclass) = 1/Total;
    Trans(Iclass,Iclass+1) =mfexp(TransPars(Iclass))/Total;
   }
  Trans(nclass,nclass) = 1;                 // Special case

// --------------------------------------------------------------------

FUNCTION Set_selex
  int Iclass,Iyr,Isurv,Ifleet,Ipnt,Jpnt;
  dvariable QQ,Temp,SlopePar;
    
  // Produce all selectivities
  for (Ifleet=1;Ifleet<=nselex_pat;Ifleet++)
   {
    Ipnt = selex_type(fleet,3);
    if (selex_type(fleet,1) == 1)
     {
      SlopePar = SelexPar(Ipnt+2);
      Temp = -log(19.0)/SlopePar;
      for (Iclass=1;Iclass<=nclass;Iclass++)
       SelexAll(Ifleet,Iclass) = 1.0/(1.0+mfexp(Temp*(Length(Iclass)-SelexPar(Ipnt+1))));
      Temp =  SelexAll(Ifleet,nclass);
      for (Iclass=1;Iclass<=nclass;Iclass++) SelexAll(Ifleet,Iclass) /= Temp;
     }
    if (selex_type(fleet,1) == 2)
     {
      for (Iclass=1;Iclass<=nclass;Iclass++)
       SelexAll(Ifleet,Iclass) = 1.0/(1.0+mfexp(SelexPar(Ipnt+Iclass)));
      Temp =  SelexAll(Ifleet,nclass);
      for (Iclass=1;Iclass<=nclass;Iclass++) SelexAll(Ifleet,Iclass) /= Temp;
     }
    if (selex_type(fleet,1) == 3)
     {
      Jpnt = selex_type(ilex_type(fleet,2),3);
      SlopePar = SelexPar(Jpnt+2);
      Temp = -log(19.0)/SlopePar;
      for (Iclass=1;Iclass<=nclass;Iclass++)
       SelexAll(Ifleet,Iclass) = 1.0/(1.0+mfexp(Temp*(Length(Iclass)-SelexPar(Ipnt+1))));
      Temp =  SelexAll(Ifleet,nclass);
      for (Iclass=1;Iclass<=nclass;Iclass++) SelexAll(Ifleet,Iclass) /= Temp;
     }
   } 

  // Fishery and bycatch selectivity
  for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
   for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
    {
     Ipnt = FleetSelexPnt(Ifleet,Iyr);
     for (Iclass=1;Iclass<=nclass;Iclass++)
      FleetSelex(Ifleet,Iyr,Iclass) = SelexAll(Ipnt,Iclass) ;
    }  
  
  // Retention in the pot fishery
  for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
   for (Iclass=1;Iclass<=nclass;Iclass++)
    {
     Ipnt = (FleetRetPnt(Iyr)-1)*nclass;
     RetCatMale(Iyr,Iclass) = (1-hg(Iyr))/(1.0+mfexp(RetainPar(Ipnt+Iclass)));
    } 

  // Survey selectivity
  for (Isurv=1;Isurv<=Nsurvey;Isurv++)
   for (Iyr=Yr1;Iyr<=Yr2+1;Iyr++)
    {
     Ipnt = SurveyQPnt(Isurv,Iyr);
     QQ = exp(LogSurveyQ(Ipnt));
     Ipnt = SurveySelexPnt(Isurv,Iyr);
     for (Iclass=1;Iclass<=nclass;Iclass++)
      SelexSurvey(Isurv,Iyr,Iclass) = QQ*SelexAll(Ipnt,Iclass);
    }  
   
  // Nest one survey within another
  for (Ipnt=1;Ipnt <=NsubSurveyFleets;Ipnt++)
   for (Iyr=Yr1;Iyr<=Yr2+1;Iyr++)
    for (Iclass=1;Iclass<=nclass;Iclass++)
     SelexSurvey(SubFltSpec(Ipnt,1),Iyr,Iclass) *= SelexSurvey(SubFltSpec(Ipnt,2),Iyr,Iclass);

// --------------------------------------------------------------------

FUNCTION Set_survival;
  int Iyr,Iclass,Ifleet;

  // Specify M
  M = M0;
  for (Iyr=Yr1;Iyr<=Yr2;Iyr++) if (Mpnt(Iyr)>1) M(Iyr) += Mm(Mpnt(Iyr)); 
  
  for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
   for (Iclass=1;Iclass<=nclass;Iclass++)
    {
     S(Iyr,Iclass) = mfexp(-M(Iyr));
     for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
      {
       SF(Ifleet,Iyr,Iclass) = (1-FleetSelex(Ifleet,Iyr,Iclass)*FAll(Ifleet,Iyr));
       ExplRates(Ifleet,Iyr) = FAll(Ifleet,Iyr);
       S(Iyr,Iclass) *= SF(Ifleet,Iyr,Iclass);
      } 
     Fdirect(Iyr) = FleetSelex(0,Iyr,nclass)*FAll(0,Iyr);
    }

// --------------------------------------------------------------------

FUNCTION Get_Catch_Pred;
  int Iyr,Iclass,Ifleet;
  dvariable S1,S2;
  dvariable SurvNo;                              // Numbers at fishery
  
  CatFleet.initialize();
  CatFleetWghtPred.initialize();
  CatFleetNumPred.initialize();
  
  for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
   for (Iclass=1;Iclass<=nclass;Iclass++)
    {
     SurvNo = N(Iyr,Iclass)*mfexp(-tc(0,Iyr)*M(Iyr));
     S1 = SF(0,Iyr,Iclass);
     CatFleet(0,Iyr,Iclass) = SurvNo*(1-S1)*RetCatMale(Iyr,Iclass);
     CatFleet(-1,Iyr,Iclass) = SurvNo*(1-S1)*(1-RetCatMale(Iyr,Iclass));
     SurvNo *= S1;
     for (Ifleet=1;Ifleet<=Nfleet;Ifleet++)
      {
       S2 = SF(Ifleet,Iyr,Iclass);
       CatFleet(Ifleet,Iyr,Iclass) = SurvNo*(1-S2);
       SurvNo *= S2;
      }
      
     // Accumulate totals 
     for (Ifleet=-1; Ifleet<=Nfleet;Ifleet++)
      {
       CatFleetWghtPred(Ifleet,Iyr) += CatFleet(Ifleet,Iyr,Iclass) * Wght(Iclass);
       CatFleetNumPred(Ifleet,Iyr) += CatFleet(Ifleet,Iyr,Iclass);
      } 
      
    }
   
  // Special case for fleet -1
  if (DiscardsOrTotal == 1)
   for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
    for (Iclass=1;Iclass<=nclass;Iclass++)
     CatFleet(-1,Iyr,Iclass) = CatFleet(-1,Iyr,Iclass) + CatFleet(0,Iyr,Iclass);
  
// =====================================================================

FUNCTION Get_Survey
  int Iyr,Iclass,Isurv;
  
  for (Isurv=1;Isurv<=Nsurvey;Isurv++)
   for (Iyr=Yr1;Iyr<=Yr2+1;Iyr++)
    for (Iclass=1;Iclass<=nclass;Iclass++)
     PredSurvey(Isurv,Iyr,Iclass) = N(Iyr,Iclass)*SelexSurvey(Isurv,Iyr,Iclass);
    
  PredSurveyNum.initialize();
  PredSurveyWght.initialize();
  for (Isurv=1;Isurv<=Nsurvey;Isurv++)
   for (Iyr=Yr1;Iyr<=Yr2+1;Iyr++)
    for (Iclass=1;Iclass<=nclass;Iclass++)
     {
      PredSurveyWght(Isurv,Iyr) += PredSurvey(Isurv,Iyr,Iclass)*Wght(Iclass);
      PredSurveyNum(Isurv,Iyr) += PredSurvey(Isurv,Iyr,Iclass);
     }
  

// =====================================================================

FUNCTION ObjFunction
  int Iyr,Icnt,Iclass,Ifleet,Isurv,Jpnt,Iselex;
  dvariable Incc,Incd,Total,Error,Penal;
  dvariable MeanF, nn;
  
  Incc = 0.00001;
  Incd = 0.0001;

  PriorVal.initialize(); 
  LikeVal.initialize();
  
  // PRIORS
  //================================================================================
  
  // Prior on F-devs 
  for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
   {
    MeanF = 0; nn = 0;
    for (Iyr=Yr1;Iyr<=Yr2;Iyr++) 
     if (Effort(Ifleet,Iyr) > 0) { MeanF += FAll(Ifleet,Iyr); nn+= 1; }
    MeanF /= nn;
    for (Iyr=Yr1;Iyr<=Yr2;Iyr++) 
     if (Effort(Ifleet,Iyr) > 0) PriorVal(Ifleet+1) += square(FAll(Ifleet,Iyr)-MeanF);
    } 
  Jpnt = Nfleet+1;
  
  // Prior on Rec Devs
  for (Iyr=Yr1;Iyr<=Yr2;Iyr++) PriorVal(Jpnt+1) += square(RecDev(Iyr));
    
  // penalties on parameters
  PriorVal(Jpnt+2) = sum(square(TransPars));
  for (Ifleet=1;Ifleet<=NSelex;Ifleet++)
   if (selex_phz(Ifleet) > 0)
    PriorVal(Jpnt+3) += square(SelexPar(Ifleet));
  PriorVal(Jpnt+4) = sum(square(RetainPar));
  PriorVal(Jpnt+5) = 0;
  
  // q - prior
  for (Isurv=1;Isurv<=NSurveyQ;Isurv++)
   if (SurveyQPSD(Isurv) > 0)
     PriorVal(Jpnt+5+Isurv) = square(exp(LogSurveyQ(Isurv))-SurveyQPMean(Isurv))/(2.0*square(SurveyQPSD(Isurv)));
  Jpnt = Jpnt+5+NSurveyQ;
  
  // M-prior
  PriorVal(Jpnt+1) = square(M0-MPriorMean)/(2.0*square(MPriorSD));
  Jpnt += 1;

  // 2nd derivative penalty
  Penal = 0;
  for (Iselex=1;Iselex<=nselex_pat;Iselex++)
   if (selex_type(ielex,1) == 2)
    for (Iclass=2;Iclass<=nclass-1;Iclass++)
     Penal += square(SelexAll(Iselex,Iclass-1)-2.0*SelexAll(Iselex,Iclass)+SelexAll(Iselex,Iclass+1));
  PriorVal(Jpnt+1) = Penal;   
      
  // DATA COMPONENTS
  //================================================================================

  // Likelihood for Catches
  for (Ifleet=-1;Ifleet<=Nfleet;Ifleet++)
   for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
    if (CatchAndDiscard(Ifleet,Iyr) > 0)
     {
      if(CatchUnit(Ifleet) == 1)
       LikeVal(Ifleet+2) += square(log((CatFleetWghtPred(Ifleet,Iyr)+Incd)/(CatchAndDiscard(Ifleet,Iyr)+Incd)));
      else
       LikeVal(Ifleet+2) += square(log((CatFleetNumPred(Ifleet,Iyr)+Incd)/(CatchAndDiscard(Ifleet,Iyr)+Incd)));
     }  
  Jpnt = Nfleet+2;
 
  // Survey indices 
  for (Isurv=1;Isurv<=Nsurvey;Isurv++)
   for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
    if (SurveyEst(Isurv,Iyr,1) > 0)
     {
      if(SurveyUnit(Isurv) == 1)
       LikeVal(Jpnt+Isurv) += 0.5*square(log((SurveyEst(Isurv,Iyr,1)+Incd)/(PredSurveyWght(Isurv,Iyr)+Incd)))/square(SurveyEst(Isurv,Iyr,2));
      else 
       LikeVal(Jpnt+Isurv) += 0.5*square(log((SurveyEst(Isurv,Iyr,1)+Incd)/(PredSurveyNum(Isurv,Iyr)+Incd)))/square(SurveyEst(Isurv,Iyr,2));
      }  
   Jpnt = Jpnt + Nsurvey;   
  
  // Effort indices
  qEff.initialize();
  for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
   {
    nn= 0;
    for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
     if (Effort(Ifleet,Iyr) > 0) 
      {
       if (FOverWrite(Ifleet,0) == 0 |Iyr<FOverWrite(Ifleet,1) | Iyr>FOverWrite(Ifleet,2))
        { nn += 1; qEff(Ifleet) += log((Effort(Ifleet,Iyr)+Incd)/(ExplRates(Ifleet,Iyr)+Incd)); }
      }  
    qEff(Ifleet) = mfexp(qEff(Ifleet)/nn); 
    for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
     if (Effort(Ifleet,Iyr) > 0)
      if (FOverWrite(Ifleet,0) == 0 |Iyr<FOverWrite(Ifleet,1) | Iyr>FOverWrite(Ifleet,2))
       LikeVal(Jpnt+Ifleet+1) += square(log((Effort(Ifleet,Iyr)+Incd)/(qEff(Ifleet)*(ExplRates(Ifleet,Iyr)+Incd))));
   }  
  Jpnt = Jpnt + (Nfleet+1); 

  // Catch LFs
  for (Ifleet=-1;Ifleet<=Nfleet;Ifleet++)
   for (Icnt=1;Icnt<=NLFfleet(Ifleet);Icnt++)
    {
     Iyr = YrFleetLF(Ifleet,Icnt);
     Total = 0;
     for (Iclass=1;Iclass<=nclass;Iclass++) Total += CatFleet(Ifleet,Iyr,Iclass);
     for (Iclass=1;Iclass<=nclass;Iclass++) CatFleet(Ifleet,Iyr,Iclass) /= Total;
     for (Iclass=1;Iclass<=nclass;Iclass++)
      if (FleetObsLF(Ifleet,Icnt,Iclass) > 0)
       {
        Error = (CatFleet(Ifleet,Iyr,Iclass)+Incc)/(FleetObsLF(Ifleet,Icnt,Iclass)+Incc);
        LikeVal(Jpnt+2+Ifleet) += -1*SSFleetLF(Ifleet,Icnt)*FleetObsLF(Ifleet,Icnt,Iclass)*log(Error);
       }
    } 
   Jpnt = Jpnt + (Nfleet+2);
     
  // Survey LF
  for (Isurv=1;Isurv<=Nsurvey;Isurv++)
   for (Icnt=1;Icnt<=NLFsurvey(Isurv);Icnt++)
    {
     Iyr = YrSurveyLF(Isurv,Icnt);
     Total = 0;
     for (Iclass=1;Iclass<=nclass;Iclass++) Total += PredSurvey(Isurv,Iyr,Iclass);
     for (Iclass=1;Iclass<=nclass;Iclass++) PredSurvey(Isurv,Iyr,Iclass) /= Total;
     for (Iclass=1;Iclass<=nclass;Iclass++)
      if (SurveyObsLF(Isurv,Icnt,Iclass) > 0)
       {
        Error = (PredSurvey(Isurv,Iyr,Iclass)+Incc)/(SurveyObsLF(Isurv,Icnt,Iclass)+Incc);
        LikeVal(Jpnt+Isurv) += -1*SSSurveyLF(Isurv,Icnt)*SurveyObsLF(Isurv,Icnt,Iclass)*log(Error);
       }
    } 
 // cout << PriorVal << endl;
 // cout << LikeVal << endl;  
                                                    
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
 int iy,Iclass,Jclass,FutYr,Ifleet;

 NFut.initialize();

 // Mortality due to other fleets
 for (Ifleet=1;Ifleet<=Nfleet;Ifleet++)
  {
   TheMort = 0;
   for (iy=Yr2-4;iy<=Yr2;iy++) TheMort += FAll(Ifleet, iy);
   MortF(Ifleet) = TheMort / 5;
  }
 
 if (IsB0 == -1) { MortF.initialize(); }
 
 // Average recruitment
 AveRec = 0;
 for (iy=Yr2-4;iy<=Yr2;iy++) AveRec += mfexp(logRbar+RecDev(iy));
 AveRec /= 5;
 AveRec = 1;

 // Survival
 for (Iclass=1;Iclass<=nclass;Iclass++)
  {
   SF1F(Iclass) = 1-FleetSelex(0,Yr2,Iclass)*Fmult;
   SF(Iclass) = mfexp(-M(Yr2))*SF1F(Iclass);
   for (Ifleet=1;Ifleet<=Nfleet;Ifleet++)
    SF(Iclass) *= (1- FleetSelex(Ifleet,Yr2,Iclass)*MortF(Ifleet));
  }
 
 // Copy Ns (irrelevant)
 for (Iclass=1;Iclass<=nclass;Iclass++) NFut(1,Iclass) = N(Yr2+1,Iclass);
 for (Iclass=1;Iclass<=nclass;Iclass++) NFut(1,Iclass) = 1;

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
   for (Iclass=1;Iclass<=nclass;Iclass++)
    {
     S1 = 0.9999*SF1F(Iclass);
     SurvNo = NFut(FutYr,Iclass)*mfexp(-gamma*M(Yr2));
     CatRetTmp = SurvNo*(1-S1)*RetCatMale(Yr2-5,Iclass);
     CatchOut += CatRetTmp* Wght(Iclass);
    }
 
   // Allow animals to grow
   for (Iclass=1;Iclass<=nclass;Iclass++)
    for (Jclass=1;Jclass<=nclass;Jclass++)
     NFut(FutYr+1,Iclass) += Trans(Jclass,Iclass)*NFut(FutYr,Jclass)*SF(Jclass);
   
   // Add in recruitment
   NFut(FutYr+1,1) += RecOut;

   // Compute MMB
   MMBOut = 0;
   for (Iclass=1;Iclass<=nclass;Iclass++) 
    MMBOut += NFut(FutYr,Iclass)*fecu(Iclass)*(1-FleetSelex(0,Yr2,Iclass)*Fmult)*mfexp(-(gamma+2.0/12.0)*M(Yr2));
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
	REPORT(Effort);
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

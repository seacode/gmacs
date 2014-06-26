// ==================================================================================== //
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
//  NOTE: This is current development version. As at 6pm Seattle time, June 6th 2014.
//
//  INDEXES:
//    g = group
//    h = sex
//    i = year
//    j = time step (years)
//    k = gear or fleet
//    l = index for length class
//    m = index for maturity state
//    n = index for shell condition.
// ==================================================================================== //

GLOBALS_SECTION
	#include <admodel.h>
	#include <time.h>
	#include <contrib.h>
	#include "../../CSTAR/include/cstar.h"

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
	 *
	 * \def COUT(object)
	 * Prints object to screen during runtime.
	 */
	 #undef COUT
	 #define COUT(object) cout << #object "\n" << object << endl;

DATA_SECTION
	// |------------------------|
	// | DATA AND CONTROL FILES |
	// |------------------------|
	init_adstring datafile;
	init_adstring controlfile;



	!! ad_comm::change_datafile_name(datafile);

	// |------------------|
	// | MODEL DIMENSIONS |
	// |------------------|
	init_int syr;		// initial year
	init_int nyr;		// terminal year
	init_number jstep;  // time step (years)
	init_int nfleet;	// number of gears
	init_int nsex;		// number of sexes
	init_int nshell;	// number of shell conditions
	init_int nmature;	// number of maturity types
	init_int nclass;	// number of size-classes

	init_vector size_breaks(1,nclass+1);
	vector       mid_points(1,nclass);
	!! mid_points = size_breaks(1,nclass) + first_difference(size_breaks);

	// |-------------|
	// | FLEET NAMES |
	// |-------------|
	init_adstring name_read_flt;        
	init_adstring name_read_srv;

	// |--------------|
	// | CATCH SERIES |
	// |--------------|
	init_int nCatchRows;						// number of rows in dCatchData
	init_matrix dCatchData(1,nCatchRows,1,9);	// array of catch data

	// |----------------------------|
	// | RELATIVE ABUNDANCE INDICES |
	// |----------------------------|
	init_int nSurveyRows;
	init_matrix dSurveyData(1,nSurveyRows,1,6);


	!! ad_comm::change_datafile_name(controlfile);
	init_int ntheta;
	init_matrix theta_control(1,ntheta,1,7);
	vector theta_ival(1,ntheta);
	vector theta_lb(1,ntheta);
	vector theta_ub(1,ntheta);
	ivector theta_phz(1,ntheta);
	LOC_CALCS
		theta_ival = column(theta_control,1);
		theta_lb   = column(theta_control,2);
		theta_ub   = column(theta_control,3);
		theta_phz  = ivector(column(theta_control,4));
	END_CALCS
	!! COUT(theta_ival);
	!! cout<<"end of control section"<<endl;
	

INITIALIZATION_SECTION
  //theta theta_ival;
  

PARAMETER_SECTION

	// Leading parameters
	//      M = theta(1)
	// ln(Ro) = theta(2)
	init_bounded_number_vector theta(1,ntheta,theta_lb,theta_ub,theta_phz);                   ///< Vector of general parameters
	
	objective_function_value objfun;

	number M0;				// natural mortality rate
	number logRbar;			// logarithm of unfished recruits
	number ra;				// shape parameter for recruitment distribution
	number rbeta;			// rate parameter for recruitment distribution

	vector rec_sdd(1,nclass);	// recruitment size_density_distribution

PROCEDURE_SECTION
	initialize_model_parameters();
	calc_recruitment_size_distribution();



  /**
   * @brief Initialize model parameters
   * @details Set global variable equal to the estimated parameter vectors.
   */
FUNCTION initialize_model_parameters
   // Get parameters from theta control matrix:
  M0      = theta(1);
  logRbar = theta(2);
  ra      = theta(3);
  rbeta   = theta(4);



  /**
   * @brief calculate size distribution for new recuits.
   * @details Based on the gamma distribution, calculates the probability
   * of a new recruit being in size-interval size
   */
FUNCTION calc_recruitment_size_distribution
  dvariable ralpha = ra / rbeta;

  for(int l=1; l<=nclass; l++)
  {
    dvariable x1 = size_breaks(l) / rbeta;
    dvariable x2 = size_breaks(l+1) / rbeta;
    rec_sdd(l) = cumd_gamma(x2, ralpha) 
                   - cumd_gamma(x1, ralpha);
  }
  rec_sdd /= sum(rec_sdd);   // Standardize so each row sums to 1.0


REPORT_SECTION





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

TOP_OF_MAIN_SECTION
	time(&start);
	arrmblsize = 50000000;
	gradient_structure::set_GRADSTACK_BUFFER_SIZE(1.e7);
	gradient_structure::set_CMPDIF_BUFFER_SIZE(1.e7);
	gradient_structure::set_MAX_NVAR_OFFSET(5000);
	gradient_structure::set_NUM_DEPENDENT_VARIABLES(5000);
	gradient_structure::set_MAX_DLINKS(50000);

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
	init_int syr;		///> initial year
	init_int nyr;		///> terminal year
	init_number jstep;  ///> time step (years)
	init_int nfleet;	///> number of gears
	init_int nsex;		///> number of sexes
	init_int nshell;	///> number of shell conditions
	init_int nmature;	///> number of maturity types
	init_int nclass;	///> number of size-classes

	init_vector size_breaks(1,nclass+1);
	vector       mid_points(1,nclass);
	!! mid_points = size_breaks(1,nclass) + first_difference(size_breaks);

	// |-----------|
	// | ALLOMETRY |
	// |-----------|
	init_vector lw_alfa(1,nsex);
	init_vector lw_beta(1,nsex);
	matrix mean_wt(1,nsex,1,nclass);
	LOC_CALCS
		for(int h = 1; h <= nsex; h++ )
		{
			mean_wt(h) = lw_alfa(h) * pow(mid_points,lw_beta(h));
		}
	END_CALCS

	// |-------------|
	// | FLEET NAMES |
	// |-------------|
	init_adstring name_read_flt;        
	init_adstring name_read_srv;

	// |--------------|
	// | CATCH SERIES |
	// |--------------|
	init_int nCatchRows;						// number of rows in dCatchData
	init_matrix dCatchData(1,nCatchRows,1,10);	// array of catch data
	vector obs_catch(1,nCatchRows);
	vector  catch_cv(1,nCatchRows);
	!! obs_catch = column(dCatchData,5);
	!!  catch_cv = column(dCatchData,6);

	// |----------------------------|
	// | RELATIVE ABUNDANCE INDICES |
	// |----------------------------|
	init_int nSurveys;
	init_ivector nSurveyRows(1,nSurveys);
	init_3darray dSurveyData(1,nSurveys,1,nSurveyRows,1,7);
	matrix obs_cpue(1,nSurveys,1,nSurveyRows);
	matrix  cpue_cv(1,nSurveys,1,nSurveyRows);
	LOC_CALCS
		for(int k = 1; k <= nSurveys; k++ )
		{
			obs_cpue(k) = column(dSurveyData(k),5);
			 cpue_cv(k) = column(dSurveyData(k),6);
		}
	END_CALCS




	// |------------------|
	// | END OF DATA FILE |
	// |------------------|
	init_int eof;
	!! if (eof != 9999) {cout<<"Error reading data"<<endl; exit(1);}













	!! ad_comm::change_datafile_name(controlfile);
	// |----------------------------|
	// | LEADING PARAMETER CONTROLS |
	// |----------------------------|
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
	

	// |--------------------------------|
	// | SELECTIVITY PARAMETER CONTROLS |
	// |--------------------------------|
	int nslx;
	!! nslx = 2 * nfleet;
	init_ivector slx_nsel_blocks(1,nslx);
 	ivector nc(1,nslx);
 	!! nc = 11 + slx_nsel_blocks;
 	init_matrix slx_control(1,nslx,1,nc);
 	ivector slx_indx(1,nslx);
 	ivector slx_type(1,nslx);
 	ivector slx_phzm(1,nslx);
 	ivector slx_bsex(1,nslx);			// boolean 0 sex-independent, 1 sex-dependent
 	ivector slx_xnod(1,nslx);
 	ivector slx_inod(1,nslx);
 	ivector slx_rows(1,nslx);
 	ivector slx_cols(1,nslx);
 	 vector slx_mean(1,nslx);
 	 vector slx_stdv(1,nslx);
 	 vector slx_lam1(1,nslx);
 	 vector slx_lam2(1,nslx);
 	 vector slx_lam3(1,nslx);
 	imatrix slx_blks(1,nslx,1,slx_nsel_blocks);

	LOC_CALCS
		slx_indx = ivector(column(slx_control,1));
		slx_type = ivector(column(slx_control,2));
		slx_mean = column(slx_control,3);
		slx_stdv = column(slx_control,4);
		slx_bsex = ivector(column(slx_control,5));
		slx_xnod = ivector(column(slx_control,6));
		slx_inod = ivector(column(slx_control,7));
		slx_phzm = ivector(column(slx_control,8));
		slx_lam1 = column(slx_control,9);
		slx_lam2 = column(slx_control,10);
		slx_lam3 = column(slx_control,11);

		// count up number of parameters required
		slx_rows.initialize();
		slx_cols.initialize();
		for(int k = 1; k <= nslx; k++ )
		{
			/* multiplier for sex dependent selex */
			int bsex = 1;
			if(slx_bsex(k)) bsex = 2;	
			
			switch (slx_type(k))
			{
				case 1:	// coefficients
					slx_cols(k) = nclass - 1;
					slx_rows(k) = bsex * slx_nsel_blocks(k);
				break;

				case 2: // logistic
					slx_cols(k) = 2;
					slx_rows(k) = bsex * slx_nsel_blocks(k);
				break;

				case 3: // logistic95
					slx_cols(k) = 2;
					slx_rows(k) = bsex * slx_nsel_blocks(k);
				break;
			}
			ivector tmp = ivector(slx_control(k).sub(12,11+slx_nsel_blocks(k)));
			slx_blks(k) = tmp.shift(1);
		}
	END_CALCS

	!! cout<<"end of control section"<<endl;
	

INITIALIZATION_SECTION
	//theta theta_ival;
	alpha     3.733;
	beta      0.2;
	scale    50.1;
 	

PARAMETER_SECTION

	// Leading parameters
	//      M = theta(1)
	// ln(Ro) = theta(2)
	// ra     = theta(3)
	// rbeta  = theta(4)
	init_bounded_number_vector theta(1,ntheta,theta_lb,theta_ub,theta_phz);

	// Molt increment parameters
	init_bounded_vector alpha(1,nsex,0,100,-1);
	init_bounded_vector beta(1,nsex,0,10,-1);
	init_bounded_vector scale(1,nsex,1,100,-1);

	// Molt probability parameters
	init_bounded_vector molt_mu(1,nsex,0,200,1);
	init_bounded_vector molt_cv(1,nsex,0,1,1);

	// Selectivity parameters
	init_bounded_matrix_vector log_slx_pars(1,nslx,1,slx_rows,1,slx_cols,-25,25,slx_phzm);
	LOC_CALCS
		for(int k = 1; k <= nslx; k++ )
		{
			if(slx_type(k) == 2)
			{
				for(int j = 1; j <= slx_rows(k); j++ )
				{
					log_slx_pars(k)(j,1) = log(slx_mean(k));
					log_slx_pars(k)(j,2) = log(slx_stdv(k));
				}
			}
		}

	END_CALCS

	// Fishing mortality rate parameters
	init_bounded_number_vector log_fbar(1,nfleet,-300.0,30.0,1);

	!! for(int k = 1; k <= nfleet; k++) log_fbar(k) = log(0.01);
	!! ivector f_phz(1,nfleet);
	!! f_phz = 1;
	!! ivector isyr(1,nfleet);
	!! isyr = syr;
	!! ivector inyr(1,nfleet);
	!! inyr = nyr;
	init_bounded_vector_vector log_fdev(1,nfleet,isyr,inyr,-10.,10.,f_phz);

	
	objective_function_value objfun;

	number M0;				///> natural mortality rate
	number logRbar;			///> logarithm of unfished recruits
	number ra;				///> shape parameter for recruitment distribution
	number rbeta;			///> rate parameter for recruitment distribution

	vector rec_sdd(1,nclass);			///> recruitment size_density_distribution
	vector survey_q(1,nSurveys);		///> scalers for relative abundance indices (q)

	vector pre_catch(1,nCatchRows);		///> predicted catch from Barnov catch equatoin
	vector res_catch(1,nCatchRows);		///> catch residuals in log-space

	matrix pre_cpue(1,nSurveys,1,nSurveyRows);	///> predicted relative abundance index
	matrix res_cpue(1,nSurveys,1,nSurveyRows);	///> relative abundance residuals
	
	matrix molt_increment(1,nsex,1,nclass);		///> linear molt increment
	matrix molt_probability(1,nsex,1,nclass); 	///> probability of molting

	3darray size_transition(1,nsex,1,nclass,1,nclass);
	3darray M(1,nsex,syr,nyr,1,nclass);		// Natural mortality
	3darray Z(1,nsex,syr,nyr,1,nclass);		// Total mortality
	3darray S(1,nsex,syr,nyr,1,nclass);		// Surival Rate (S=exp(-Z))
	3darray F(1,nsex,syr,nyr,1,nclass);		// Fishing mortality

	3darray N(1,nsex,syr,nyr+1,1,nclass);		// Numbers-at-length
	3darray log_ft(1,nfleet,1,nsex,syr,nyr);	// Fishing mortality by gear

	4darray log_slx_capture(1,nfleet,1,nsex,syr,nyr,1,nclass);
	4darray log_slx_retaind(1,nfleet,1,nsex,syr,nyr,1,nclass);
	4darray log_slx_discard(1,nfleet,1,nsex,syr,nyr,1,nclass);

PROCEDURE_SECTION
	initialize_model_parameters();

	// Fishing fleet dynamics ...
	calc_selectivities();
	calc_fishing_mortality();



	// Population dynamics ...
	calc_growth_increments();
	calc_size_transition_matrix();
	calc_natural_mortality();
	calc_total_mortality();
	calc_molting_probability();
	calc_recruitment_size_distribution();
	calc_initial_numbers_at_length();
	update_population_numbers_at_length();



	// observation models ...
	calc_predicted_catch();
	calc_relative_abundance();



	// objective function ...
	calc_objective_function();


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
   * @brief Calculate selectivies for each gear.
   * @author Steve Martell
   * @details Three selectivities must be accounted for by each fleet.
   * 1) capture probability, 2) retention probability, and 3) release probability.
   * 
   * Maintain the possibility of estimating selectivity independently for
   * each sex; assumes there are data to estimate female selex.
   * 
   * Psuedocode:
   * 	-# Loop over each gear:
   * 	-# Create a pointer array with length = number of blocks
   * 	-# Based on slx_type, fill pointer with parameter estimates.
   * 	-# Loop over years and block-in the log_selectivity at mid points.
   * 	
   */
FUNCTION calc_selectivities
	int h,i,j,k;
	int block;
	dvariable p1,p2;
	dvar_vector pv;
	log_slx_capture.initialize();
	log_slx_discard.initialize();
	log_slx_retaind.initialize();

	for( k = 1; k <= nslx; k++ )
	{	
		
		block = 1;
		cstar::Selex<dvar_vector> *pSLX[slx_rows(k)-1];
		for( j = 0; j < slx_rows(k); j++ )
		{

			switch (slx_type(k))
			{
			case 1:  //coefficients
				pv   = mfexp(log_slx_pars(k)(block));
				pSLX[j] = new cstar::SelectivityCoefficients<dvar_vector>(pv);
			break;

			case 2:  //logistic
				p1 = mfexp(log_slx_pars(k,block,1));
				p2 = mfexp(log_slx_pars(k,block,2));
				pSLX[j] = new cstar::LogisticCurve<dvar_vector,dvariable>(p1,p2);
			break;

			case 3:  // logistic95
				p1 = mfexp(log_slx_pars(k,block,1));
				p2 = mfexp(log_slx_pars(k,block,2));
				pSLX[j] = new cstar::LogisticCurve95<dvar_vector,dvariable>(p1,p2);
			break;
			}

			block ++;
			
		}
		
		
		// fill array with selectivity coefficients
		j = -1;
		block = 1;
		for( h = 1; h <= nsex; h++ )
		{
			for( i = syr; i <= nyr; i++ )
			{
				if(i == slx_blks(k)(block))
				{
					j ++;
					if(block != slx_nsel_blocks(k)) block ++;
				}
				
				int kk = fabs(slx_indx(k));
				
				if(slx_indx(k) > 0)
				{
					log_slx_capture(kk)(h)(i) = pSLX[j]->logSelectivity(mid_points);
				}
				else
				{
					log_slx_retaind(kk)(h)(i) = pSLX[j]->logSelectivity(mid_points);
					log_slx_discard(kk)(h)(i) = log(1.0 - exp(log_slx_retaind(kk)(h)(i)));
				}
			}
			
			if(!slx_bsex(k)){
				j-= slx_nsel_blocks(k);
				block = 1;
			} 
		}

		// delete pointers
		delete *pSLX;
	}
	









  /**
   * @brief Calculate fishing mortality rates for each fleet.
   * @details For each fleet estimate scaler log_fbar and deviates (f_devs).
   * 
   * In the event that there is effort data and catch data, then it's possible
   * to estimate a catchability coefficient and predict the catch for the
   * period of missing catch/discard data.  Best option for this would be
   * to use F = q*E, where q = F/E.  Then in the objective function, minimize
   * the variance in the estimates of q, and use the mean q to predict catch.
   * Or minimize the first difference and assume a random walk in q.
   * 
   * Note that this function calculates the fishing mortality rate including
   * deaths due to discards.  Where lambda is the discard mortality rate.
   */
FUNCTION calc_fishing_mortality
	int h,i,k;
	double lambda = 0.5;  // discard mortality rate from control file
	F.initialize();
	log_ft.initialize();
	dvar_vector sel(1,nclass);
	dvar_vector ret(1,nclass);
	dvar_vector tmp(1,nclass);

	for( k = 1; k <= nfleet; k++ )
	{
		for( h = 1; h <= nsex; h++ )
		{
			for( i = syr; i <= nyr; i++ )
			{
				log_ft(k)(h)(i) = log_fbar(k) + log_fdev(k,i);
				sel = exp(log_slx_capture(k)(h)(i));
				ret = exp(log_slx_retaind(k)(h)(i));
				tmp = elem_prod(sel,ret+(1.0 - ret)*lambda);
				F(h)(i) += mfexp(log_ft(k,h,i)) * tmp;
			}
		}
	}










  /**
   * @brief Molt increment as a linear function of pre-molt size.
   */
FUNCTION calc_growth_increments
	int h,l;

	for( h = 1; h <= nsex; h++ )
	{
		for( l = 1; l <= nclass; l++ )
		{
			molt_increment(h)(l) = alpha(h) + beta(h) * mid_points(l);
		}
	}
	






  /**
   * \brief Calclate the size transtion matrix.
   * \Authors Steven Martell
   * \details Calculates the size transition matrix for each sex based on
   * growth increments, which is a linear function of the size interval, and
   * the scale parameter for the gamma distribution.  This function does the 
   * proper integration from the lower to upper size bin, where the mode of 
   * the growth increment is scaled by the scale parameter.
   * 
   * This function loops over sex, then loops over the rows of the size
   * transition matrix for each sex.  The probability of transitioning from 
   * size l to size ll is based on the vector molt_increment and the 
   * scale parameter. In all there are three parameters that define the size
   * transition matrix (alpha, beta, scale) for each sex.
   */
FUNCTION calc_size_transition_matrix
	int h,l,ll;
	dvariable tmp;
	dvar_vector psi(1,nclass+1);
	size_transition.initialize();

	for( h = 1; h <= nsex; h++ )
	{
		for( l = 1; l <= nclass; l++ )
		{
			tmp = molt_increment(h)(l)/scale(h);
			psi.initialize();
			for( ll = l; ll <= nclass+1; ll++ )
			{
				psi(ll) = cumd_gamma(size_breaks(ll)/scale(h),tmp);
			}
			size_transition(h)(l)(l,nclass)  = first_difference(psi(l,nclass+1));
			size_transition(h)(l)(l,nclass) /= sum(size_transition(h)(l)(l,nclass));
		}
	}

	







  /**
   * @brief Calculate natural mortality array
   * @details Natural mortality (M) is a 3d array for sex, year and size.
   * @return NULL
   * 
   * todo:  
   * 		- Add time varying components
   * 		- Size-dependent mortality
   * 
   */
FUNCTION calc_natural_mortality
	int h;
	M.initialize();
	for( h = 1; h <= nsex; h++ )
	{
		M(h) = M0;
	}






  /**
   * @brief Calculate total instantaneous mortality rate and survival rate
   * @details \f$ S = exp(-Z) \f$
   * @return NULL
   * 
   * 
   */
FUNCTION calc_total_mortality
	int h;
	Z.initialize();
	S.initialize();
	for( h = 1; h <= nsex; h++ )
	{
		 Z(h) = M(h) + F(h);
		 S(h) = mfexp(-Z(h));
	}






  /**
   * \brief Calculate the probability of moulting vs carapace width.
   * \details Note that the parameters molt_mu and molt cv can only be
   * estimated in cases where there is new shell and old shell data.
   */
FUNCTION calc_molting_probability
	int h;
	molt_probability.initialize();

	for( h = 1; h <= nsex; h++ )
	{
		dvariable mu = molt_mu(h);
		dvariable sd = mu* molt_cv(h);
		molt_probability(h) = 1.0 - plogis(mid_points,mu,sd);
	}







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





  /**
   * @brief initialiaze populations numbers-at-length in syr
   * @author Steve Martell
   * @details This function initializes the populations numbers-at-length
   * in the initial year of the model.  
   * 
   * Psuedocode:
   * 
   * 	
   */
FUNCTION calc_initial_numbers_at_length
	int h,i;
	N.initialize();

	// Option 1: spin up from constant recruitment.
	dvar_vector rt = 0.5 * mfexp(logRbar) * rec_sdd;
	for( h = 1; h <= nsex; h++ )
	{
		for( i = 1; i <= 50; i++ )
		{	
			N(h)(syr) = elem_prod(N(h)(syr),S(h)(syr)) * size_transition(h) + rt;
		}
	}




  /**
   * @brief Update numbers-at-length
   * @author Steve Martell
   */
FUNCTION update_population_numbers_at_length
	int h,i;

	for( h = 1; h <= nsex; h++ )
	{
		for( i = syr; i <= nyr; i++ )
		{
			N(h)(i+1)  = 0.5 * mfexp(logRbar) * rec_sdd;
			N(h)(i+1) += elem_prod(N(h)(i),S(h)(i)) * size_transition(h);
		}
	}






  /**
   * @brief Calculate predicted catch observations
   * @details The function uses the Baranov catch equation to predict the retained
   * and discarded catch.
   * 
   * @param  [description]
   * @return [description]
   */
FUNCTION calc_predicted_catch
	int h,i,j,k;
	int type,unit;
	pre_catch.initialize();
	dvariable ft;
	dvar_vector sel(1,nclass);
	dvar_vector nal(1,nclass);		// numbers or biomass at length.
	


	for( j = 1; j <= nCatchRows; j++ )
	{	
		i = dCatchData(j,1);		// year index
		k = dCatchData(j,3);		// gear index
		h = dCatchData(j,4); 		// sex index

		// Type of catch (retained = 1, discard = 2)
		type = int(dCatchData(j,7));

		// Units of catch equation (1 = biomass, 2 = numbers)
		unit = int(dCatchData(j,8));
		
		// Total catch
		if(h)	// sex specific 
		{
			switch(type)
			{
				case 1:		// retained catch
					sel = exp( log_slx_capture(k)(h)(i) );
				break;

				case 2:		// discard catch
					sel = 1.0 - exp( log_slx_retaind(k)(h)(i) );
				break;
			}
			ft = mfexp( log_ft(k)(h)(i) );
			unit==1?nal=elem_prod(N(h)(i),mean_wt(h)):N(h)(i);

			pre_catch(j) = nal * elem_div(elem_prod(ft*sel,1.0-exp(-Z(h)(i))),Z(h)(i));
		}
		else 	// sexes combibed
		{
			for( h = 1; h <= nsex; h++ )
			{
				switch(type)
				{
					case 1:		// retained catch
						sel = exp( log_slx_capture(k)(h)(i) );
					break;

					case 2:		// discard catch
						sel = 1.0 - exp( log_slx_retaind(k)(h)(i) );
					break;
				}
				ft = mfexp( log_ft(k)(h)(i) );
				unit==1?nal=elem_prod(N(h)(i),mean_wt(h)):N(h)(i);

				pre_catch(j) += nal * elem_div(elem_prod(ft*sel,1.0-exp(-Z(h)(i))),Z(h)(i));
			}
		}
	}

	// Catch residuals
	res_catch = log(obs_catch) - log(pre_catch);








  /**
   * @brief Calculate predicted relative abundance and residuals
   * @author Steve Martell
   * 
   * @details This function uses the conditional mle for q to scale
   * the population to the relative abundance index.  Assumed errors in 
   * relative abundance are lognormal.
   */
FUNCTION calc_relative_abundance
	int g,h,i,j,k;
	int unit;
	dvar_vector nal(1,nclass);	// numbers at length
	dvar_vector sel(1,nclass);	// selectivity at length

	for( k = 1; k <= nSurveys; k++ )
	{
		dvar_vector V(1,nSurveyRows(k));	
		nal.initialize();
		V.initialize();
		for( j = 1; j <= nSurveyRows(k); j++ )
		{
			i = dSurveyData(k)(j)(1);		// year index
			g = dSurveyData(k)(j)(3);		// gear index
			h = dSurveyData(k)(j)(4);		//  sex index
			unit = dSurveyData(k)(j)(7);	// units 1==biomass

			if(h)
			{
				sel = exp(log_slx_capture(g)(h)(i));
				unit==1?nal=elem_prod(N(h)(i),mean_wt(h)):N(h)(i);
				V(j) = nal * sel;
			}
			else
			{
				for( h = 1; h <= nsex; h++ )
				{
					sel = exp(log_slx_capture(g)(h)(i));
					unit==1?nal=elem_prod(N(h)(i),mean_wt(h)):N(h)(i);
					V(j) += nal * sel;
				}
			}
		} // nSurveyRows(k)
		dvar_vector zt = log(obs_cpue(k)) - log(V);
		dvariable zbar = mean(zt);
		res_cpue(k)    = zt - zbar;
		survey_q(k)    = mfexp(zbar);
		pre_cpue(k)    = survey_q(k) * V;
	}









  /**
   * @brief calculate objective function
   * @details 
   * 
   * Likelihood components
   * 	-# likelihood of the catch data (assume lognormal error)
   * 	-# likelihood of relative abundance data
   * 
   * Penalty components
   * 	-# Penalty on log_fdev to ensure they sum to zero.
   * 
   */
FUNCTION calc_objective_function
	dvar_vector nloglike(1,2);
	dvar_vector nlogPenalty(1,2);

	nloglike.initialize();
	nlogPenalty.initialize();

	// 1) Likelihood of the catch data.
	nloglike(1) = dnorm(res_catch,catch_cv);

	// Penalty on log_fdev to ensure they sum to zero 
	for(int k = 1; k <= nfleet; k++ )
	{
		dvariable s    = mean(log_fdev(k));
		nlogPenalty(1) += 10000.0*s*s;
	}

	// 2) Likelihood of the relative abundance data.
	for(int k = 1; k <= nSurveys; k++ )
	{
		nloglike(2) += dnorm(res_cpue(k),cpue_cv(k));
	}



	objfun = sum(nloglike) + sum(nlogPenalty);



REPORT_SECTION
	REPORT(obs_catch);
	REPORT(pre_catch);
	REPORT(res_catch);
	REPORT(obs_cpue);
	REPORT(pre_cpue);
	REPORT(res_cpue);
	REPORT(log_slx_capture);
	REPORT(log_slx_retaind);
	REPORT(log_slx_discard);





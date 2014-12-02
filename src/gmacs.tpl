// ==================================================================================== //
//   Gmacs: A generalized size-structured stock assessment modeling framework.
//
//   Authors: Athol Whitten and Jim Ianelli
//            University of Washington, Seattle
//            and Alaska Fisheries Science Centre, Seattle
//
//   Info: https://github.com/seacode/gmacs Copyright (C) 2014. All rights reserved.
//
//  INDEXES:
//    g = group
//    h = sex
//    i = year
//    j = time step (years)
//    k = gear or fleet
//    l = index for length class
//    m = index for maturity state
//    o = index for shell condition.

// ==================================================================================== //

DATA_SECTION
	
	// |---------------------|
	// | SIMULATION CONTROLS |
	// |---------------------|
	int simflag;
	int rseed
	LOC_CALCS
		simflag = 0;
		rseed   = 0;
		int opt,on;
		if((on=option_match(ad_comm::argc,ad_comm::argv,"-sim",opt))>-1)
		{
			simflag = 1;
			rseed   = atoi(ad_comm::argv[on+1]);
		}
	END_CALCS

	// |------------------------|
	// | DATA AND CONTROL FILES |
	// |------------------------|
	init_adstring datafile;
	init_adstring controlfile;

	!! ad_comm::change_datafile_name(datafile); ECHO(datafile);ECHO(controlfile);

	// |------------------|
	// | MODEL DIMENSIONS |
	// |------------------|
	init_int syr;				///> initial year
	init_int nyr;				///> terminal year
	init_number jstep;  ///> time step (years)
	init_int nfleet;		///> number of gears
	init_int nsex;			///> number of sexes
	init_int nshell;		///> number of shell conditions
	init_int nmature;		///> number of maturity types
	init_int nclass;		///> number of size-classes

	init_vector size_breaks(1,nclass+1);
	vector       mid_points(1,nclass);
	!! mid_points = size_breaks(1,nclass) + first_difference(size_breaks);
	!! ECHO(syr); ECHO(nyr); ECHO(nfleet); ECHO(nsex); ECHO(nshell);ECHO(nmature); ECHO(nclass);

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
	!! ECHO(lw_alfa); ECHO(lw_beta); ECHO(mean_wt);

	// |-------------------------------|
	// | FECUNDITY FOR MMB CALCULATION |
	// |-------------------------------|
	init_vector fecundity(1,nclass);
  init_matrix maturity(1,nsex,1,nclass);

	// |-------------|
	// | FLEET NAMES |
	// |-------------|
	init_adstring name_read_flt;        
	init_adstring name_read_srv;
	!! ECHO(name_read_srv); ECHO(name_read_flt);

	// |--------------|
	// | CATCH SERIES |
	// |--------------|
	//init_int nCatchRows;						// number of rows in dCatchData
	init_int nCatchDF;
	init_ivector nCatchRows(1,nCatchDF);
	init_3darray dCatchData(1,nCatchDF,1,nCatchRows,1,11);	// array of catch data
	matrix obs_catch(1,nCatchDF,1,nCatchRows);
	matrix  catch_cv(1,nCatchDF,1,nCatchRows);
	matrix  catch_dm(1,nCatchDF,1,nCatchRows);
	LOC_CALCS
		for(int k = 1; k <= nCatchDF; k++ )
		{
			obs_catch(k) = column(dCatchData(k),5);
			catch_cv(k)  = column(dCatchData(k),6);
			catch_dm(k)  = column(dCatchData(k),11);
		}
	END_CALCS
	//!! ECHO(obs_catch); ECHO(catch_cv);

	// From the catch series determine the number of fishing mortality
	// rate parameters that need to be estimated.  Note that  there is
	// a number of combinations which require a F to be estimated. The
	// ivector nFparams is the number of deviations required for each 
	// fleet, and nYparams is the number of deviations for female Fs.
	ivector nFparams(1,nfleet);
	ivector nYparams(1,nfleet);
	ivector foff_phz(1,nfleet);
	imatrix fhit(syr,nyr,1,nfleet);
	imatrix yhit(syr,nyr,1,nfleet);
	matrix  dmr(syr,nyr,1,nfleet);


	LOC_CALCS
		nFparams.initialize();
		nYparams.initialize();
		fhit.initialize();
		yhit.initialize();
		dmr.initialize();
		foff_phz = -1;
		for(int k = 1; k <= nCatchDF; k++ )
		{
			for(int i = 1; i <= nCatchRows(k); i++ )
			{
				int g = dCatchData(k)(i,3);
				int y = dCatchData(k)(i,1);
				int h = dCatchData(k)(i,4);
				if(!fhit(y,g))
				{
					fhit(y,g)   ++;
					nFparams(g) ++;
					dmr(y,g) = catch_dm(k)(i);
				}
				if(!yhit(y,g) && h == 2)
				{
					yhit(y,g)   ++;
					nYparams(g) ++;
					foff_phz(g) = 1;
					dmr(y,g) = catch_dm(k)(i);
				}
			}
		}
	END_CALCS

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
		ECHO(obs_cpue); ECHO(cpue_cv); 
	END_CALCS

	// |-----------------------|
	// | SIZE COMPOSITION DATA |
	// |-----------------------|

	init_int nSizeComps;
	init_ivector nSizeCompRows(1,nSizeComps);
	init_ivector nSizeCompCols(1,nSizeComps);
	init_3darray d3_SizeComps(1,nSizeComps,1,nSizeCompRows,-7,nSizeCompCols);
	3darray d3_obs_size_comps(1,nSizeComps,1,nSizeCompRows,1,nSizeCompCols);
	3darray d3_res_size_comps(1,nSizeComps,1,nSizeCompRows,1,nSizeCompCols);
	matrix size_comp_sample_size(1,nSizeComps,1,nSizeCompRows);
	LOC_CALCS
		for(int k = 1; k <= nSizeComps; k++ )
		{
			dmatrix tmp = trans(d3_SizeComps(k)).sub(1,nSizeCompCols(k));
			d3_obs_size_comps(k) = trans(tmp);
			size_comp_sample_size(k) = column(d3_SizeComps(k),0);
		}
		ECHO(nSizeComps); 
		ECHO(d3_obs_size_comps); 
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
	int nr;
	int nc;
	int nslx;
	!! nr = 2 * nfleet;
	!! nc = 13;
	init_ivector slx_nsel_blocks(1,nr);
	!! nslx = sum(slx_nsel_blocks);
	init_imatrix slx_nret(1,nsex,1,nfleet);

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
	ivector slx_styr(1,nslx);
	ivector slx_edyr(1,nslx);

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
		slx_styr = ivector(column(slx_control,12));
		slx_edyr = ivector(column(slx_control,13));

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
					slx_rows(k) = bsex;
				break;

				case 2: // logistic
					slx_cols(k) = 2;
					slx_rows(k) = bsex;
				break;

				case 3: // logistic95
					slx_cols(k) = 2;
					slx_rows(k) = bsex;
				break;
			}
			// ivector tmp = ivector(slx_control(k).sub(12,11+slx_nsel_blocks(k)));
			// slx_blks(k) = tmp.shift(1);
		}
	END_CALCS


	// |---------------------------------------------------------|
	// | PENALTIES FOR MEAN FISHING MORTALITY RATE FOR EACH GEAR |
	// |---------------------------------------------------------|
	init_matrix f_controls(1,nfleet,1,4);
	ivector f_phz(1,nfleet);
	vector pen_fbar(1,nfleet);
	vector log_pen_fbar(1,nfleet);
	matrix pen_fstd(1,2,1,nfleet);
	LOC_CALCS
		pen_fbar = column(f_controls,1);
		log_pen_fbar = log(pen_fbar+1.0e-14);
		for(int i=1; i<=2; i++)
			pen_fstd(i) = trans(f_controls)(i+1);
		f_phz    = ivector(column(f_controls,4));
		// Set foff_phz to f_phz
		for(int k = 1; k <= nfleet; k++ )
		{
			for(int i = syr; i <= nyr; i++ )
			{
				if( yhit(i,k) ) 
				{
					foff_phz(k) = f_phz(k);
					break;
				}
			}			
		}
	END_CALCS


	// |-----------------------------------|
	// | OPTIONS FOR SIZE COMPOSITION DATA |
	// |-----------------------------------|
	init_ivector nAgeCompType(1,nSizeComps);
	init_ivector bTailCompression(1,nSizeComps);
	init_ivector nvn_phz(1,nSizeComps);



	// |--------------------------------------------------|
	// | OPTIONS FOR TIME-VARYING NATURAL MORTALITY RATES |
	// |--------------------------------------------------|
	int nMdev;
	init_int m_type;
	init_int Mdev_phz;
	init_number m_stdev;
	init_int m_nNodes;
	init_ivector m_nodeyear(1,m_nNodes);
	LOC_CALCS
		switch( m_type )
		{
			case 0:
				nMdev = 0; 
				Mdev_phz = -1;
			break;
			case 1: 
				nMdev = nyr-syr; 
			break;
			case 2:
				nMdev = m_nNodes;
			break;
		}
	END_CALCS


	// |---------------------------------------------------------|
	// | OTHER CONTROLS                                          |
	// |---------------------------------------------------------|
	init_vector model_controls(1,8);
	int rdv_phz; 										///> Estimated rec_dev phase
	int verbose;										///> Flag to print to screen
	int bInitializeUnfished;				///> Flag to initialize at unfished conditions
	int spr_syr;
	int spr_nyr;
	number spr_target;
	int spr_fleet;
	number spr_lambda;
	LOC_CALCS
		rdv_phz             = int(model_controls(1));
		verbose             = int(model_controls(2));
		bInitializeUnfished = int(model_controls(3));
		spr_syr             = int(model_controls(4));
		spr_nyr             = int(model_controls(5));
		spr_target          =     model_controls(6);
		spr_fleet           = int(model_controls(7));
		spr_lambda          =     model_controls(8);
	END_CALCS

	init_int eof_ctl;
	!! if(eof_ctl!=9999){cout<<"Error reading control file"<<endl; exit(1);}

	!! cout<<"end of control section"<<endl;

	int nf;
	!! nf = 0;

	// |----------------------|
	// | SPR Reference points |
	// |----------------------|
	number spr_fspr;
	number spr_bspr;
	number spr_rbar;
	number spr_cofl;
	number spr_fofl;

INITIALIZATION_SECTION
	theta     theta_ival;
	alpha     16.56211;  //16.56211     -0.05496
	beta      0.05496;
	scale     12.1;
	log_fbar  log_pen_fbar;
	

PARAMETER_SECTION
	
	// Leading parameters
	// M        = theta(1)
	// ln(Ro)   = theta(2)
	// ln(R1)   = theta(3)
	// ln(Rbar) = theta(4)
	// ra       = theta(5)
	// rbeta    = theta(6)
	init_bounded_number_vector theta(1,ntheta,theta_lb,theta_ub,theta_phz);

	// Molt increment parameters
	// Need molt increment data to estimate these parameters
	init_bounded_vector alpha(1,nsex,0,20.,-3);
	init_bounded_vector beta(1,nsex,0,10,-3);
	init_bounded_vector scale(1,nsex,1,20.,-4);

	// Molt probability parameters
	init_bounded_vector molt_mu(1,nsex,0,100,-1);
	init_bounded_vector molt_cv(1,nsex,0,50,-1);

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
		//COUT(log_slx_pars(k));
		}
	END_CALCS

	// Fishing mortality rate parameters
	init_number_vector log_fbar(1,nfleet,f_phz);
	init_vector_vector log_fdev(1,nfleet,1,nFparams,f_phz);
	init_number_vector log_foff(1,nfleet,foff_phz);
	init_vector_vector log_fdov(1,nfleet,1,nYparams,foff_phz);

	// Recruitment deviation parameters
	init_bounded_dev_vector rec_ini(1,nclass,-5.0,5.0,rdv_phz);  ///> initial size devs
	init_bounded_dev_vector rec_dev(syr+1,nyr,-5.0,5.0,rdv_phz); ///> recruitment deviations

	// Time-varying natural mortality rate devs.
	init_bounded_dev_vector m_dev(1,nMdev,-3.0,3.0,Mdev_phz);

	// Effective sample size parameter for multinomial
	init_number_vector log_vn(1,nSizeComps,nvn_phz);

	vector nloglike(1,4);
	vector nlogPenalty(1,4);
	vector priorDensity(1,ntheta);

	objective_function_value objfun;

	number M0;				///> natural mortality rate
	number logR0;			///> logarithm of unfished recruits.
	number logRbar;		///> logarithm of average recruits(syr+1,nyr)
	number logRini;   ///> logarithm of initial recruitment(syr).
	number ra;				///> shape parameter for recruitment distribution
	number rbeta;			///> rate parameter for recruitment distribution
	number logSigmaR; ///> standard deviation of recruitment deviations.

	vector rec_sdd(1,nclass);			///> recruitment size_density_distribution
	vector recruits(syr,nyr);			///> vector of estimated recruits
	vector survey_q(1,nSurveys);	///> scalers for relative abundance indices (q)

	matrix pre_catch(1,nCatchDF,1,nCatchRows);		///> predicted catch (Baranov eq)
	matrix res_catch(1,nCatchDF,1,nCatchRows);		///> catch residuals in log-space

	matrix pre_cpue(1,nSurveys,1,nSurveyRows);	///> predicted relative abundance index
	matrix res_cpue(1,nSurveys,1,nSurveyRows);	///> relative abundance residuals
	
	matrix molt_increment(1,nsex,1,nclass);		///> linear molt increment
	matrix molt_probability(1,nsex,1,nclass); ///> probability of molting

	3darray size_transition(1,nsex,1,nclass,1,nclass);
	3darray M(1,nsex,syr,nyr,1,nclass);		///> Natural mortality
	3darray Z(1,nsex,syr,nyr,1,nclass);		///> Total mortality
	3darray S(1,nsex,syr,nyr,1,nclass);		///> Surival Rate (S=exp(-Z))
	3darray F(1,nsex,syr,nyr,1,nclass);		///> Fishing mortality

	3darray N(1,nsex,syr,nyr+1,1,nclass);		///> Numbers-at-length
	3darray ft(1,nfleet,1,nsex,syr,nyr);		///> Fishing mortality by gear
	3darray d3_pre_size_comps(1,nSizeComps,1,nSizeCompRows,1,nSizeCompCols);
	3darray d3_res_size_comps(1,nSizeComps,1,nSizeCompRows,1,nSizeCompCols);

	4darray log_slx_capture(1,nfleet,1,nsex,syr,nyr,1,nclass);
	4darray log_slx_retaind(1,nfleet,1,nsex,syr,nyr,1,nclass);
	4darray log_slx_discard(1,nfleet,1,nsex,syr,nyr,1,nclass);

	sdreport_vector sd_log_recruits(syr,nyr);
	sdreport_vector sd_log_mmb(syr,nyr);


PRELIMINARY_CALCS_SECTION
	if( simflag )
	{
		if(!global_parfile)
		{
			cerr << "Must have a gmacs.pin file to use the -sim command line option"<<endl;
			ad_exit(1);
		}
		cout<<"|———————————————————————————————————————————|"<<endl;
		cout<<"|*** RUNNING SIMULATION WITH RSEED = "<<rseed<<" ***|"<<endl;
		cout<<"|———————————————————————————————————————————|"<<endl;
		
		simulation_model();
		//exit(1);
	}
	// Must declare the abstract base class in GLOBALS_SECTION
	// acl::negativeLogLikelihood *agecomplike;
	// agecomplike = new acl::multinomial(d3_obs_size_comps(1));
	

PROCEDURE_SECTION
	// Initialize model parameters
	initialize_model_parameters();
	if( verbose ) cout<<"Ok after initializing model parameters ..."<<endl;
	
	// Fishing fleet dynamics ...
	calc_selectivities();
	calc_fishing_mortality();
	if( verbose ) cout<<"Ok after fleet dynamics ..."<<endl;

	// Population dynamics ...
	calc_growth_increments();
	calc_size_transition_matrix();
	calc_natural_mortality();
	calc_total_mortality();
	calc_molting_probability();
	calc_recruitment_size_distribution();
	calc_initial_numbers_at_length();
	update_population_numbers_at_length();
	if( verbose ) cout<<"Ok after population dynamcs ..."<<endl;

	// observation models ...
	calc_predicted_catch();
	calc_relative_abundance();
	calc_predicted_composition();
	if( verbose ) cout<<"Ok after observation models ..."<<endl;

	// objective function ...
	calculate_prior_densities();
	calc_objective_function();
	if( verbose ) cout<<"Ok after objective function ..."<<endl;
	// sd_report variables
	if( last_phase() ) 
	{
		calc_sdreport();
	}
	nf++;


	/**
	 * @brief calculate sdreport variables in final phase
	 */
FUNCTION calc_sdreport
	sd_log_recruits = log(recruits);
	int h = 1;
	for(int i = syr; i <= nyr; i++ )
	{
		// sd_log_mmb(i) = log( N(h)(i) * fecundity );
		sd_log_mmb(i) = log(N(h)(i)*elem_prod(mean_wt(h),maturity(h)));
	}
	
	

	/**
	 * @brief Initialize model parameters
	 * @details Set global variable equal to the estimated parameter vectors.
	 */
FUNCTION initialize_model_parameters
	 // Get parameters from theta control matrix:
	M0        = theta(1);
	logR0     = theta(2);
	logRini   = theta(3);
	logRbar   = theta(4);
	ra        = theta(5);
	rbeta     = theta(6);
	logSigmaR = theta(7);


	/**
	 * @brief Calculate selectivies for each gear.
	 * @author Steve Martell
	 * @details Three selectivities must be accounted for by each fleet.
	 * 1) capture probability, 2) retention probability, and 3) release probability.
	 * 
	 * Maintain the possibility of estimating selectivity independently for
	 * each sex; assumes there are data to estimate female selex.
	 * 
	 * BUG: There should be no retention of female crabs in the directed fishery.
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
		j = 0;
		for( h = 1; h <= nsex; h++ )
		{
			for( i = slx_styr(k); i <= slx_edyr(k); i++ )
			{
				int kk = fabs(slx_indx(k));   // gear index
				
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
			
			// Increment counter if sex-specific selectivity curves are defined.
			if(slx_bsex(k))  j++;
		}
		
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
	 * 
	 * Note also that Jie estimates F for retained fishery, f for male discards and
	 * f for female discards.  Not recommended to have separate F' for retained and 
	 * discard fisheries, but might be ok to have sex-specific F's.  
	 * 
	 * TODO fix discard mortality rate.
	 */
FUNCTION calc_fishing_mortality
	int h,i,k,ik,yk;
	double lambda = 0.2;  // discard mortality rate from control file
	F.initialize();
	ft.initialize();
	dvariable log_ftmp;
	dvar_vector sel(1,nclass);
	dvar_vector ret(1,nclass);
	dvar_vector tmp(1,nclass);

	for( k = 1; k <= nfleet; k++ )
	{
		for( h = 1; h <= nsex; h++ )
		{
			ik=1; yk=1;
			for( i = syr; i <= nyr; i++ )
			{
				if(fhit(i,k))
				{
					log_ftmp    = log_fbar(k) + log_fdev(k,ik++);
					if(yhit(i,k))
					{
						log_ftmp   += (h-1) * (log_foff(k) + log_fdov(k,yk++));
					}
					ft(k)(h)(i) = mfexp(log_ftmp);
					
					lambda = dmr(i,k);

					sel = exp(log_slx_capture(k)(h)(i));
					ret = exp(log_slx_retaind(k)(h)(i)) * slx_nret(h,k);
					tmp = elem_prod(sel,ret + (1.0 - ret) * lambda);

					F(h)(i) += ft(k,h,i) * tmp;
				}
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
			molt_increment(h)(l) = alpha(h) - beta(h) * mid_points(l);
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
	//cout<<"Start of calc_size_transition_matrix"<<endl;
	int h,l,ll;
	dvariable tmp;
	dvar_vector psi(1,nclass+1);
	dvar_matrix At(1,nclass,1,nclass);
	size_transition.initialize();

	
	for( h = 1; h <= nsex; h++ )
	{
		At.initialize();
		for( l = 1; l <= nclass; l++ )
		{
			tmp = molt_increment(h)(l)/scale(h);
			
			psi.initialize();
			for( ll = l; ll <= nclass+1; ll++ )
			{
				if( ll<=nclass+1 )
				{
					psi(ll) = cumd_gamma(size_breaks(ll)/scale(h),tmp);
				}
			}
			
			At(l)(l,nclass)  = first_difference(psi(l,nclass+1));
			At(l)(l,nclass) /= sum(At(l));
		}
		size_transition(h) = At;
	}
	
	//cout<<"End of calc_size_transition_matrix"<<endl;
	


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

	// Add random walk to natural mortality rate.
	if (active( m_dev ))
	{
		dvar_vector delta(syr+1,nyr);
		delta.initialize();

		switch( m_type )
		{
			case 0:  // constant natural mortality
				delta = 0;
			break;

			case 1:  // random walk in natural mortality
				delta = m_dev.shift(syr+1);
			break;

			case 2:  // cubic splines
				dvector iyr = (m_nodeyear -syr) / (nyr-syr);
				dvector jyr(syr+1,nyr);
				jyr.fill_seqadd(0,1./(nyr-syr-1));
				vcubic_spline_function csf(iyr,m_dev);
				delta = csf(jyr);
			break;
		}

		// Update M by year.
		for(int h = 1; h <= nsex; h++ )
		{
			for(int i = syr+1; i <= nyr; i++ )
			{
				M(h)(i)  = M(h)(i-1) * mfexp(delta(i));
			}
		}
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
		 //COUT(F(h)(syr));
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
		//molt_probability(h) = 1.0 - plogis(mid_points,mu,sd);
		molt_probability(h) = 1.0 - 1.0/(1+exp((mid_points-mu)/sd));
	}



	/**
	 * @brief calculate size distribution for new recuits.
	 * @details Based on the gamma distribution, calculates the probability
	 * of a new recruit being in size-interval size.
	 * @param ra is the mean of the distribution.
	 * @param rbeta scales the variance of the distribution
	 */
FUNCTION calc_recruitment_size_distribution
	//cout<<"Start of calc_recruitment_size_distribution"<<endl;
	dvariable ralpha = ra / rbeta;
	dvar_vector x(1,nclass+1);
	for(int l = 1; l <= nclass+1; l++ )
	{
		x(l) = cumd_gamma(size_breaks(l)/rbeta,ralpha);
	}
	rec_sdd  = first_difference(x);
	rec_sdd /= sum(rec_sdd);   // Standardize so each row sums to 1.0
	//COUT(ra);
	//COUT(rbeta);
	//COUT(ralpha);
	//COUT(rec_sdd);
	//cout<<"End of calc_recruitment_size_distribution"<<endl;



	/**
	 * @brief initialiaze populations numbers-at-length in syr
	 * @author Steve Martell
	 * @details This function initializes the populations numbers-at-length
	 * in the initial year of the model.  
	 * 
	 * Psuedocode:  See note from Dave Fournier.
	 * 
	 * Athol, I think a better option here is to estimate a vector of 
	 * deviates, one for each size class, and have the option to initialize
	 * the model at unfished equilibrium, or some other steady state condition.
	 * 	
	 */
FUNCTION calc_initial_numbers_at_length
	dvariable log_initial_recruits;
	N.initialize();
	// Initial recrutment.
	if ( bInitializeUnfished )
	{
		log_initial_recruits = logR0;
	}
	else
	{
		log_initial_recruits = logRini;
	}
	recruits(syr) = exp(log_initial_recruits);
	// COUT(log_initial_recruits);
	dvar_vector rt = 0.5 * mfexp( log_initial_recruits ) * rec_sdd;

	// Equilibrium soln.
	dmatrix Id=identity_matrix(1,nclass);
	dvar_vector x(1,nclass);
	dvar_matrix At(1,nclass,1,nclass);
	dvar_matrix  A(1,nclass,1,nclass);
	for(int h = 1; h <= nsex; h++ )
	{
		At = size_transition(h);
		for(int l = 1; l <= nclass; l++ )
		{
			At(l) *= S(h)(syr)(l);
		}
		A = trans(At);
		x = -solve(A-Id,rt);
		N(h)(syr) = elem_prod(x,exp(rec_ini));
	}
	
	if(verbose) COUT(N(1)(syr));
	

	/**
	 * @brief Update numbers-at-length
	 * @author Steve Martell
	 * @details  Numbers at length are propagated each year for each sex based on the 
	 * size transition matrix and a vector of size-specifc survival rates. The columns
	 * of the size-transition matrix are multiplied by the size-specific survival rate
	 * (a sclaer).  New recruits are added based on the estimated aveerage recruitment and 
	 * annual deviate, multiplied by a vector of size-proportions (rec_sdd).
	 */
FUNCTION update_population_numbers_at_length
	int h,i,l;
	dvar_matrix At(1,nclass,1,nclass);
	recruits(syr+1,nyr) = mfexp(logRbar);

	for( i = syr; i <= nyr; i++ )
	{
		if( i > syr ) 
			recruits(i) *= mfexp(rec_dev(i));

		for( h = 1; h <= nsex; h++ )
		{
			At = size_transition(h);
			for( l = 1; l <= nclass; l++ )
			{
				//A(l) = elem_prod( A(l), S(h)(i) );
				At(l) *= S(h)(i)(l);
			}
			N(h)(i+1)   = (0.5 * recruits(i)) * rec_sdd;
			N(h)(i+1)   += N(h)(i) * At;
		}
	}
	
	if(verbose) COUT(N(1)(nyr));




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
	dvariable tmp_ft;
	dvar_vector sel(1,nclass);
	dvar_vector nal(1,nclass);		// numbers or biomass at length.
	

	for(int kk = 1; kk <= nCatchDF; kk++ )
	{
		for( j = 1; j <= nCatchRows(kk); j++ )
		{	
			i = dCatchData(kk)(j,1);		// year index
			k = dCatchData(kk)(j,3);		// gear index
			h = dCatchData(kk)(j,4); 		// sex index

			// Type of catch (retained = 1, discard = 2)
			type = int(dCatchData(kk)(j,7));

			// Units of catch equation (1 = biomass, 2 = numbers)
			unit = int(dCatchData(kk)(j,8));
			
			// Total catch
			if(h)	// sex specific 
			{
				sel = log_slx_capture(k)(h)(i);
				switch(type)
				{
					case 1:		// retained catch
						sel = exp( sel + log_slx_retaind(k)(h)(i) );
					break;

					case 2:		// discard catch
						sel = elem_prod(exp(sel),1.0 - exp( log_slx_retaind(k)(h)(i) ));
					break;
				}
				tmp_ft = ft(k)(h)(i);
				nal = (unit==1) ? elem_prod(N(h)(i),mean_wt(h)):N(h)(i);

				pre_catch(kk)(j) = nal * elem_div(elem_prod(tmp_ft*sel,1.0-exp(-Z(h)(i))),Z(h)(i));
			}
			else 	// sexes combibed
			{
				for( h = 1; h <= nsex; h++ )
				{
					sel = log_slx_capture(k)(h)(i);
					switch(type)
					{
						case 1:		// retained catch
							sel = exp( sel + log_slx_retaind(k)(h)(i) );
						break;

						case 2:		// discard catch
							sel = elem_prod(exp(sel),1.0 - exp( log_slx_retaind(k)(h)(i) ));
						break;
					}
					tmp_ft = ft(k)(h)(i);
					nal = (unit==1) ? elem_prod(N(h)(i),mean_wt(h)):N(h)(i);

					pre_catch(kk)(j) += nal * elem_div(elem_prod(tmp_ft*sel,1.0-exp(-Z(h)(i))),Z(h)(i));
				}
			}
		}
		// Catch residuals
		res_catch(kk) = log(obs_catch(kk)) - log(pre_catch(kk));
		if(verbose)COUT(pre_catch(kk)(1));
	}









	/**
	 * @brief Calculate predicted relative abundance and residuals
	 * @author Steve Martell
	 * 
	 * @details This function uses the conditional mle for q to scale
	 * the population to the relative abundance index.  Assumed errors in 
	 * relative abundance are lognormal.  Currently assumes that the CPUE
	 * index is made up of both retained and discarded crabs.
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
			unit = dSurveyData(k)(j)(7);	// units 1==biomass 2==Numbers

			if(h)
			{
				sel = exp(log_slx_capture(g)(h)(i));
				switch(unit)
				{
					case 1:
						nal=elem_prod(N(h)(i),mean_wt(h));
					break;
					case 2:
						nal=N(h)(i);
					break;
				}
				V(j) = nal * sel;
			}
			else
			{
				for( h = 1; h <= nsex; h++ )
				{
					sel = exp(log_slx_capture(g)(h)(i));
					switch(unit)
					{
						case 1:
							nal=elem_prod(N(h)(i),mean_wt(h));
						break;
						case 2:
							nal=N(h)(i);
						break;
					}
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
	 * @brief Calculate predicted size composition data.
	 * @details   Predicted size composition data are given in proportions.
	 * Size composition strata:
	 * 	- sex
	 * 	- type (retained or discard)
	 * 	- shell condition
	 * 	- mature or immature
	 * 
	 * NB Sitting in a campground on the Orgeon Coast writing this code,
	 * with baby Tabitha sleeping on my back.
	 * 
	 * TODO: 
	 * 	- add pointers for shell type.   DONE
	 * 	- add pointers for maturity state. DONE
   *  - need to come proper way to handle shell condition.
   *    I think there should just be newshell/old shell.
	 */
FUNCTION calc_predicted_composition
	int h,i,j,k;
	int type,shell,bmature ;
	d3_pre_size_comps.initialize();
	dvar_vector dNtmp(1,nclass);


	for(int ii = 1; ii <= nSizeComps; ii++ )
	{
		for(int jj = 1; jj <= nSizeCompRows(ii); jj++ )
		{
			dNtmp.initialize();
			i        = d3_SizeComps(ii)(jj,-7);		// year
			j        = d3_SizeComps(ii)(jj,-6);		// seas
			k        = d3_SizeComps(ii)(jj,-5);		// gear
			h        = d3_SizeComps(ii)(jj,-4);		// sex
			type     = d3_SizeComps(ii)(jj,-3);		
			shell    = d3_SizeComps(ii)(jj,-2);	
			bmature  = d3_SizeComps(ii)(jj,-1);

			if(h) // sex specific
			{
				dvar_vector sel = exp(log_slx_capture(k)(h)(i));
				dvar_vector ret = exp(log_slx_retaind(k)(h)(i));
				dvar_vector dis = exp(log_slx_discard(k)(h)(i));
				dvar_vector tmp = N(h)(i);
        
        if( shell   ) tmp = elem_prod(tmp,molt_probability(h));
        if( bmature ) tmp = elem_prod(tmp,maturity(h));
        
				switch (type)
				{
					case 1:		// retained
						dNtmp = elem_prod(tmp,elem_prod(sel,ret));
					break;
					case 2: 	// discarded
						dNtmp = elem_prod(tmp,elem_prod(sel,dis));
					break;
					default:  // both retained and discarded
						dNtmp = elem_prod(tmp,sel);
					break;
				}

			}
			else
			{
				for( h = 1; h <= nsex; h++ )
				{
					dvar_vector sel = exp(log_slx_capture(k)(h)(i));
					dvar_vector ret = exp(log_slx_retaind(k)(h)(i));
					dvar_vector dis = exp(log_slx_discard(k)(h)(i));
					dvar_vector tmp = N(h)(i);

					switch (type)
					{
						case 1:
							dNtmp += elem_prod(tmp,ret);
						break;
						case 2:
							dNtmp += elem_prod(tmp,dis);
						break;
						default:
							dNtmp += elem_prod(tmp,sel);
						break;
					}
				}
			}
			d3_pre_size_comps(ii)(jj) = dNtmp / sum(dNtmp);
		}
	}




	/**
	 * @brief Calculate prior density functions for leading parameters.
	 * @details 
	 * 	- case 0 is a uniform density between the lower and upper bounds.
	 * 	- case 1 is a normal density with mean = p1 and sd = p2
	 * 	- case 2 is a lognormal density with mean = log(p1) and sd = p2
	 * 	- case 3 is a beta density bounded between lb-ub with p1 and p2 as alpha & beta
	 * 	- case 4 is a gamma density with parameters p1 and p2.
	 */
FUNCTION calculate_prior_densities
	double p1,p2;
	double lb,ub;
	priorDensity.initialize();
	
	for(int i = 1; i <= ntheta; i++ )
	{
		int priorType = theta_control(i,5);
		p1 = theta_control(i,6);
		p2 = theta_control(i,7);
		switch(priorType)
		{
			// uniform
			case 0: 
				p1 = theta_control(i,2);
				p2 = theta_control(i,3);
				priorDensity(i) = -log(1.0 / (p2-p1));
			break;

			// normal
			case 1:
				priorDensity(i) = dnorm(theta(i),p1,p2);
			break;

			// lognormal
			case 2:
				priorDensity(i) = dlnorm(theta(i),log(p1),p2);
			break;

			// beta
			case 3:
				lb = theta_control(i,2);
				ub = theta_control(i,3);
				priorDensity(i) = dbeta((theta(i)-lb)/(ub-lb),p1,p2);
			break;

			// gamma
			case 4:
				priorDensity(i) = dgamma(theta(i),p1,p2);
			break;
		}
	}









	/**
	 * @brief calculate objective function
	 * @details 
	 * 
	 * Likelihood components
	 * 	-# likelihood of the catch data (assume lognormal error)
	 * 	-# likelihood of relative abundance data
	 * 	-# likelihood of size composition data
	 * 
	 * Penalty components
	 * 	-# Penalty on log_fdev to ensure they sum to zero.
	 * 	-# Penalty to regularize values of log_fbar.
	 * 	-# Penalty to constrain random walk in natural mortaliy rates
	 * 
	 */
FUNCTION calc_objective_function

	// |---------------------------------------------------------------------------------|
	// | NEGATIVE LOGLIKELIHOOD COMPONENTS FOR THE OBJECTIVE FUNCTION                    |
	// |---------------------------------------------------------------------------------|
	nloglike.initialize();
	
	// 1) Likelihood of the catch data.
	if(verbose) COUT(res_catch(1));
	for(int k = 1; k <= nCatchDF; k++ )
	{
		dvector catch_sd = sqrt( log( 1.0+square(catch_cv(k)) ) );
		nloglike(1) += dnorm(res_catch(k),catch_sd);
	}




	// 2) Likelihood of the relative abundance data.
  if(verbose) COUT(res_cpue(1));
	for(int k = 1; k <= nSurveys; k++ )
	{
		dvector cpue_sd = sqrt(log(1.0 + square(cpue_cv(k))));
		nloglike(2) += dnorm(res_cpue(k),cpue_sd(k));
	}




	// 3) Likelihood for size composition data.
	for(int ii = 1; ii <= nSizeComps; ii++)
	{
		dmatrix     O = d3_obs_size_comps(ii);
		dvar_matrix P = d3_pre_size_comps(ii);
		dvar_vector log_effn  = log(exp(log_vn(ii)) * size_comp_sample_size(ii));

		bool bCmp = bTailCompression(ii);
		acl::negativeLogLikelihood *ploglike;
		switch(nAgeCompType(ii))
		{
			case 1: // multinomial with fixed or estimated n
				ploglike = new acl::multinomial(O,bCmp);
				
				nloglike(3) 				 += ploglike->nloglike(log_effn,P);
				d3_res_size_comps(ii) = ploglike->residual(log_effn,P);
			break;

		}
		

		//likelihoods::nloglike myfun(O,P);
		//nloglike(3)  += myfun.multinomial(size_comp_sample_size(ii));

		//if(last_phase())
		//{
		//	d3_res_size_comps(ii) = myfun.residuals(size_comp_sample_size(ii));
		//}

		//nloglike(3)  += myfun.dmvlogistic();
	}


	// 4) Likelihood for recruitment deviations.
	dvariable sigR = mfexp(logSigmaR);
	nloglike(4)    = dnorm(rec_dev,sigR);




	// |---------------------------------------------------------------------------------|
	// | PENALTIES AND CONSTRAINTS                                                       |
	// |---------------------------------------------------------------------------------|
	nlogPenalty.initialize();

	// 1) Penalty on log_fdev to ensure they sum to zero 
	for(int k = 1; k <= nfleet; k++ )
	{
		dvariable s    = mean(log_fdev(k));
		nlogPenalty(1) += 10000.0*s*s;

		          s    = mean(log_fdov(k));
		nlogPenalty(1) += 10000.0*s*s;		       
	}


	// 2) Penalty on mean F to regularize the solution.
	int irow=1;
	if(last_phase()) irow=2;
	dvariable fbar;
	for(int k = 1; k <= nfleet; k++ )
	{
		fbar = mean(ft(k));
		nlogPenalty(2) += dnorm(fbar,pen_fbar(k),pen_fstd(irow,k));
	}


	// 3) Penalty to constrain M in random walk
	if( active(m_dev) )
	{
			nlogPenalty(3) = dnorm(m_dev,m_stdev);
	}


	objfun = sum(nloglike) + sum(nlogPenalty) + sum(priorDensity);
	if( verbose==2 ) 
	{
		COUT(objfun);
		COUT(nloglike);
		COUT(nlogPenalty);
		COUT(priorDensity);
	}

	/**
	 * @brief Simulation model
	 * @details Uses many of the same routines as the assessment
	 * model, over-writes the observed data in memory with simulated 
	 * data.
	 * 
	 */
FUNCTION simulation_model
	// random number generator
	random_number_generator rng(rseed);
	
	// Initialize model parameters
	initialize_model_parameters();

	// Fishing fleet dynamics ...
	calc_selectivities();
	calc_fishing_mortality();

	
	dvector drec_dev(syr+1,nyr);
	drec_dev.fill_randn(rng);
	rec_dev = exp(logSigmaR) * drec_dev;

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
	calc_predicted_composition();

	
	// add observation errors to catch.
	dmatrix err_catch(1,nCatchDF,1,nCatchRows);
	err_catch.fill_randn(rng);
	dmatrix catch_sd(1,nCatchDF,1,nCatchRows);
	for(int k = 1; k <= nCatchDF; k++ )
	{
		catch_sd(k)  = sqrt(log(1.0 + square(catch_cv(k))));
		obs_catch(k) = value(pre_catch(k));
		err_catch(k) = elem_prod(catch_sd(k),err_catch(k)) - 0.5*square(catch_sd(k));
		obs_catch(k) = elem_prod(obs_catch(k),exp(err_catch(k)));
	}
	

	// add observation errors to cpue. & fill in dSurveyData column 5
	dmatrix err_cpue(1,nSurveys,1,nSurveyRows);
	dmatrix cpue_sd = sqrt(log(1.0 + square(cpue_cv)));
	err_cpue.fill_randn(rng);
	obs_cpue = value(pre_cpue);
	err_cpue = elem_prod(cpue_sd,err_cpue) - 0.5*square(cpue_sd);
	obs_cpue = elem_prod(obs_cpue,exp(err_cpue));
	for(int k = 1; k <= nSurveys; k++ )
	{
		for(int i = 1; i <= nSurveyRows(k); i++ )
		{
			dSurveyData(k)(i,5) = obs_cpue(k,i);
		}
	}
	

	// add sampling errors to size-composition.
	// 3darray d3_obs_size_comps(1,nSizeComps,1,nSizeCompRows,1,nSizeCompCols);
	double tau;
	for(int k = 1; k <= nSizeComps; k++ )
	{
		for(int i = 1; i <= nSizeCompRows(k); i++ )
		{
			tau = sqrt(1.0 / size_comp_sample_size(k)(i));
			dvector p = value(d3_pre_size_comps(k)(i)); 
			d3_obs_size_comps(k)(i) = rmvlogistic(p,tau,rseed+k+i);
		}
	}
	// COUT(d3_pre_size_comps(1)(1));
	// COUT(d3_obs_size_comps(1)(1));

REPORT_SECTION
	dvector mod_yrs(syr,nyr); 
	mod_yrs.fill_seqadd(syr,1);
	REPORT(name_read_flt);
	REPORT(name_read_srv);
	REPORT(mod_yrs);
	REPORT(mid_points); 
	REPORT(nloglike);
	REPORT(nlogPenalty);
	REPORT(dCatchData);
	REPORT(obs_catch);
	REPORT(pre_catch);
	REPORT(res_catch);
	REPORT(dSurveyData);
	REPORT(obs_cpue);
	REPORT(pre_cpue);
	REPORT(res_cpue);
	report << "slx_capture"<<endl;
	for (int i=syr;i<=nyr;i++) for (int h=1;h<=nsex;h++) for (int j=1;j<=nfleet;j++)
	 	report << i << " " << h << " " << j << " " << exp(log_slx_capture(j,h,i)) <<endl;
	report << "slx_retaind"<<endl;
	for (int i=syr;i<=nyr;i++) for (int h=1;h<=nsex;h++) for (int j=1;j<=nfleet;j++)
	 	report << i << " " << h << " " << j << " " << exp(log_slx_retaind(j,h,i)) <<endl;
	report << "slx_discard"<<endl;
	for (int i=syr;i<=nyr;i++) for (int h=1;h<=nsex;h++) for (int j=1;j<=nfleet;j++)
	 	report << i << " " << h << " " << j << " " << exp(log_slx_discard(j,h,i)) <<endl;
	REPORT(log_slx_capture);
	REPORT(log_slx_retaind);
	REPORT(log_slx_discard);
	REPORT(d3_SizeComps);

	REPORT(d3_obs_size_comps);
	REPORT(d3_pre_size_comps);
	REPORT(d3_res_size_comps);
	REPORT(ft);
	REPORT(rec_sdd);
	REPORT(size_transition);
	REPORT(rec_dev);
	REPORT(recruits);
	REPORT(N);
	REPORT(M);
	REPORT(mean_wt);
	dvector mmb = calc_mmb();
	REPORT(mmb);

	if(last_phase())
	{
		int refyear = nyr-1;
		calc_spr_reference_points(refyear,spr_fleet);
		//calc_ofl(refyear,spr_fspr);
		REPORT(spr_fspr);
		REPORT(spr_bspr);
		REPORT(spr_rbar);
		REPORT(spr_fofl);
		REPORT(spr_cofl);
  	dvar_matrix mean_size(1,nsex,1,nclass);
  	///>  matrix to get distribution of size at say, nclass "ages" (meaning years since initial recruitment)
  	dvar3_array growth_matrix(1,nsex,1,nclass,1,nclass);
  	for (int isex=1;isex<=nsex;isex++)
  	{
  		int iage=1;
  		// Set the initial size frequency
    	growth_matrix(isex,iage) = size_transition(isex,iage);
  	  mean_size(isex,iage)  = growth_matrix(isex,iage) * mid_points /sum(growth_matrix(isex,iage));
  	  for (iage=2;iage<=nclass;iage++)
  	  {
  	  	growth_matrix(isex,iage)     = growth_matrix(isex,iage-1)*size_transition(isex);
  	  	mean_size(isex,iage) = growth_matrix(isex,iage) * mid_points / sum(growth_matrix(isex,iage));
  	  }
  	}
  	REPORT(growth_matrix);
  	REPORT(mean_size);
	}



	/**
	 * @brief Calculate mature male biomass
	 * @details Calculate mature male biomass based on numbers N array.
	 * 
	 * TODO correct for timing of when the MMB is calculated
	 */
FUNCTION dvector calc_mmb()
	dvector mmb(syr,nyr);
	mmb.initialize();

	int h = 1;  // males
	for(int i = syr; i <= nyr; i++ )
	{
		mmb(i) = value(N(h)(i)) * elem_prod(mean_wt(h),maturity(h));
	}
	return(mmb);



	/**
	 * @brief calculate spr-based reference points.
	 * @details Calculate the SPR-ration for a given value of F.
	 * 
	 * Psuedocode:
	 * 	-# calculate average recruitment over reference period.
	 * 	-# compute the ratio of F's based on reference year (nyr)
	 * 	-# calculate fishing mortality vector.
	 * 	-# calculate equibrium total mortality vector.
	 * 	-# calculate growth/survival transition matrix.
	 * 	
	 * 	ARGS:
	 * 	@param iyr Reference year for selectivity and fishing mortality ratios
	 * 	@param ifleet index for gear to compute SPR values, other fleets with const F
	 * 	
	 * 	got response from andre, “The convention is to fix F for all 
	 * 	non-directed fisheries to a recent average and to solve for 
	 * 	the F for the directed fishery so that you achieve B35%.” but 
	 * 	I think he meant F35
	 * 	
	 * 	Use bisection method to find SPR_target.
	 */
FUNCTION void calc_spr_reference_points(const int iyr,const int ifleet)
	
	// Average recruitment
	spr_rbar = 0.5 * mean(value(recruits(spr_syr,spr_nyr)));

	double   _r = spr_rbar;
	dvector _rx = value(rec_sdd);
	dmatrix _M(1,nsex,1,nclass);
	dmatrix _N(1,nsex,1,nclass);
	dmatrix _wa(1,nsex,1,nclass);
	d3_array _A = value(size_transition);
	for(int h = 1; h <= nsex; h++ )
	{
		_M(h) = value(M(h)(iyr));
		_N(h) = value(N(h)(nyr));
		_wa(h) = elem_prod(mean_wt(h),maturity(h));
	}
	
	dmatrix  _fhk(1,nsex,1,nfleet);
	d3_array _sel(1,nsex,1,nfleet,1,nclass);
	d3_array _ret(1,nsex,1,nfleet,1,nclass);
	for(int h = 1; h <= nsex; h++ )
	{
		for(int k=1;k<=nfleet;k++)
		{
			_fhk(h)(k) = value(ft(k)(h)(iyr));
			_sel(h)(k) = exp(value(log_slx_capture(k)(h)(iyr)));
			_ret(h)(k) = exp(value(log_slx_retaind(k)(h)(iyr)));
		}
	}

	// Discard Mortality rates
	dvector  _dmr(1,nfleet);
	_dmr.initialize();
	for(int k = 1; k <= nfleet; k++ )
	{
		_dmr(k) = dmr(iyr,k);
	}
	

	// SPR reference points
	spr c_spr(_r,spr_lambda,_rx,_M,_wa,_A);
	spr_fspr = c_spr.get_fspr(ifleet,spr_target,_fhk,_sel,_ret,_dmr);
	spr_bspr = c_spr.get_bspr();

	// OFL Calculations
	dvector mmb = calc_mmb();
	double cuttoff = 0.1;
	double limit = 0.25;
	spr_fofl = c_spr.get_fofl(cuttoff,limit,mmb(nyr));
	spr_cofl = c_spr.get_cofl(_N);
	COUT("Finished SPR Calcs")
	
	
	
	

RUNTIME_SECTION
    maximum_function_evaluations 500,  500,   1500, 25000, 25000
    convergence_criteria        1.e-4, 1.e-4, 1.e-4, 1.e-4, 1.e-4, 


GLOBALS_SECTION
	#include <admodel.h>
	#include <time.h>
	
	#if defined __APPLE__ || defined __linux
	#include "./include/libgmacs.h"
	#endif

	#if defined _WIN32 || defined _WIN64
	#include "\include\libgmacs.h"
	#endif


	
	
	time_t start,finish;
	long hour,minute,second;
	double elapsed_time;

	// Define objects for report file, echoinput, etc.
	/**
	\def report(object)
	Prints name and value of \a object on ADMB report %ofstream file.
	*/
	#undef REPORT
	#define REPORT(object) report << #object "\n" << setw(8) \
	<< setprecision(4) << setfixed() << object << endl;

	/**
	 *
	 * \def COUT(object)
	 * Prints object to screen during runtime.
	 * cout <<setw(6) << setprecision(3) << setfixed() << x << endl;
	 */
	 #undef COUT
	 #define COUT(object) cout << #object "\n" << setw(6) \
	 << setprecision(3) << setfixed() << object << endl;
	/**

	\def ECHO(object)
	Prints name and value of \a object on echoinput %ofstream file.
	*/
	 #undef ECHO
	 #define ECHO(object) echoinput << #object << "\n" << object << endl;
	 // #define ECHO(object,text) echoinput << object << "\t" << text << endl;
 
	#undef MAXIT
	#undef TOL
 	#define MAXIT 100
 	#define TOL 1.0e-4
	 /**
	 \def check(object)
	 Prints name and value of \a object on checkfile %ofstream output file.
	 */
	 #define check(object) checkfile << #object << "\n" << object << endl;
	 // Open output files using ofstream
	 ofstream echoinput("echoinput.rep");
	 ofstream checkfile("checkfile.rep");

TOP_OF_MAIN_SECTION
	time(&start);
	arrmblsize = 50000000;
	gradient_structure::set_GRADSTACK_BUFFER_SIZE(1.e7);
	gradient_structure::set_CMPDIF_BUFFER_SIZE(1.e7);
	gradient_structure::set_MAX_NVAR_OFFSET(5000);
	gradient_structure::set_NUM_DEPENDENT_VARIABLES(5000);
	gradient_structure::set_MAX_DLINKS(50000); 


FINAL_SECTION
	//  Print run time statistics to the screen.
	time(&finish);
	elapsed_time=difftime(finish,start);
	hour=long(elapsed_time)/3600;
	minute=long(elapsed_time)%3600/60;
	second=(long(elapsed_time)%3600)%60;
	cout<<endl<<endl<<"*******************************************"<<endl;
	cout<<endl<<endl<<"-------------------------------------------"<<endl;
	cout<<"--Start time: "<<ctime(&start)<<endl;
	cout<<"--Finish time: "<<ctime(&finish)<<endl;
	cout<<"--Runtime: ";
	cout<<hour<<" hours, "<<minute<<" minutes, "<<second<<" seconds"<<endl;
	cout<<"--Number of function evaluations: "<<nf<<endl;
	cout<<"*******************************************"<<endl;

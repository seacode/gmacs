/// ==================================================================================== //
//   seltest: A way to test out selectivity forms and template librarying...
// ==================================================================================== //

///
///@file seltest.tpl
///@authors Steve Martell, Jim Ianelli
///

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

		if((on=option_match(ad_comm::argc,ad_comm::argv,"-i",opt))>-1)
		{
			cout<<"  |----------------------------------------------------------|\n";
			cout<<"  | CONTRIBUTIONS (Code and intellectual)                    |\n";
			cout<<"  |----------------------------------------------------------|\n";
			cout<<"  | Name:                        Organization:               |\n";
			cout<<"  | Steven Martell,              IPHC                        |\n";
			cout<<"  | James Ianelli,               NOAA-NMFS                   |\n";
			cout<<"  |----------------------------------------------------------|\n";

			cout<<"\n";
			cout<<"  |----------------------------------------------------------|\n";
			cout<<"  | FINANCIAL SUPPORT                                        |\n";
			cout<<"  |----------------------------------------------------------|\n";
			cout<<"  | Financial support for this project was provided by the   |\n";
			cout<<"  | National Marine Fisheries Service, the Bering Sea        |\n";
			cout<<"  | Fisheries Research Foundation,....                       |\n";
			cout<<"  |----------------------------------------------------------|\n";
			cout<<"\n";

			cout<<"\n";
			cout<<"  |----------------------------------------------------------|\n";
			cout<<"  | DOCUMENTATION                                            |\n";
			cout<<"  |----------------------------------------------------------|\n";
			cout<<"  | online api: http://seacode.github.io/gmacs/index.html    |\n";
			cout<<"  |----------------------------------------------------------|\n";

			cout<<"\n";
			exit(1);
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
	init_int syr
	init_int nyr
	init_int nclass;           ///> initial year
	init_int nobs;           ///> terminal year
	init_int nsex;
	init_int nlikes;
	init_int nfleet;

	// |--------------------------------|
	// | SELECTIVITY PARAMETER CONTROLS |
	// |--------------------------------|
	int nr;
	int nc;
	int nslx;
	// This seems off by a factor of 2...for single sex models...???but maybe not...
	!! nr = 2 * nfleet;
	// !! nr = nsex * nfleet;
	!! nc = 13;
	init_ivector slx_nsel_blocks(1,nr);
	!! nslx = sum(slx_nsel_blocks);
	init_imatrix slx_nret(1,nsex,1,nfleet);

	init_matrix slx_control(1,nslx,1,nc);
	!! 	ECHO(slx_nsel_blocks); ECHO(slx_nret); ECHO(slx_control);

	ivector slx_indx(1,nslx);
	ivector slx_type(1,nslx);
	ivector slx_phzm(1,nslx);
	ivector slx_bsex(1,nslx);           // boolean 0 sex-independent, 1 sex-dependent
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
				case 1: // coefficients
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

INITIALIZATION_SECTION
	

PARAMETER_SECTION
	// Selectivity parameters
	init_bounded_matrix_vector log_slx_pars(1,nslx,1,slx_rows,1,slx_cols,0.,5.2,slx_phzm);
	LOC_CALCS
		for(int k = 1; k <= nslx; k++ )
		{
			if(slx_type(k) == 2 || slx_type(k) == 3)
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

	// Effective sample size parameter for multinomial
	init_number_vector log_vn(1,nSizeComps,nvn_phz);

	matrix nloglike(1,nlikes,1,ilike_vector);
	vector nlogPenalty(1,4);

	objective_function_value objfun;

	//3darray N(1,nsex,syr,nyr+1,1,nclass);     ///> Numbers-at-length
	4darray log_slx_capture(1,nfleet,1,nsex,syr,nyr,1,nclass);
	4darray log_slx_retaind(1,nfleet,1,nsex,syr,nyr,1,nclass);
	4darray log_slx_discard(1,nfleet,1,nsex,syr,nyr,1,nclass);


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


PROCEDURE_SECTION
	calc_selectivities();

	// observation models ...
	calc_predicted_composition();
	// objective function ...
	calculate_prior_densities();
	calc_objective_function();

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
	 *  -# Loop over each gear:
	 *  -# Create a pointer array with length = number of blocks
	 *  -# Based on slx_type, fill pointer with parameter estimates.
	 *  -# Loop over years and block-in the log_selectivity at mid points.
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
	 * @brief Calculate predicted size composition data.
	 * @details   Predicted size composition data are given in proportions.
	 * Size composition strata:
	 *  - sex
	 *  - type (retained or discard)
	 *  - shell condition
	 *  - mature or immature
	 * 
	 * NB Sitting in a campground on the Orgeon Coast writing this code,
	 * with baby Tabitha sleeping on my back.
	 * 
	 * TODO: 
	 *  - add pointers for shell type.   DONE
	 *  - add pointers for maturity state. DONE
	 *  
	 *  Jan 5, 2015.
	 *  Size compostion data can come in a number of forms.
	 *  Given sex, maturity and 3 shell conditions, there are 12 possible
	 *  combinations for adding up the numbers at length (nal).
	 *                          Shell
	 *    Sex     Maturity        condition   Description
	 *    _____________________________________________________________
	 *    Male    0               1           immature, new shell
	 * !  Male    0               2           immature, old shell
	 * !  Male    0               0           immature, new & old shell               1               Male, immature, new shell
	 *    Male    1               1             mature, new shell
	 *    Male    1               2             mature, old shell
	 *    Male    1               0             mature, new & old shell
	 *  Female    0               1           immature, new shell
	 * !Female    0               2           immature, old shell
	 * !Female    0               0           immature, new & old shell
	 *  Female    1               1             mature, new shell
	 *  Female    1               2             mature, old shell
	 *  Female    1               0             mature, new & old shell
	 *    _____________________________________________________________
	 *  
	 *  Call function to get the appropriate numbers-at-length.
	 *  
	 *  TODO:
	 *  [x] Check to ensure new shell old shell is working.
	 *  [ ] Add maturity component for data sets with mature old and mature new.
	 *  [ ] Issue 53, comps/total(sex,shell cond) 
	 */
FUNCTION calc_predicted_composition
	int h,i,j,k,ig;
	int type,shell,bmature ;
	d3_pre_size_comps.initialize();
	dvar_vector dNtmp(1,nclass);
	dvar_vector dNtot(1,nclass);
	dvar_vector   nal(1,nclass);

	for(int ii = 1; ii <= nSizeComps; ii++ )
	{
		for(int jj = 1; jj <= nSizeCompRows(ii); jj++ )
		{
			dNtmp.initialize();
			dNtot.initialize();
			nal.initialize();
			i        = d3_SizeComps(ii)(jj,-7);     // year
			j        = d3_SizeComps(ii)(jj,-6);     // seas
			k        = d3_SizeComps(ii)(jj,-5);     // gear
			h        = d3_SizeComps(ii)(jj,-4);     // sex
			type     = d3_SizeComps(ii)(jj,-3);     // retained or discard
			shell    = d3_SizeComps(ii)(jj,-2);     // shell condition
			bmature  = d3_SizeComps(ii)(jj,-1);     // boolean for maturity
				
			
			if(h) // sex specific
			{
				dvar_vector sel = exp(log_slx_capture(k)(h)(i));
				dvar_vector ret = exp(log_slx_retaind(k)(h)(i));
				dvar_vector dis = exp(log_slx_discard(k)(h)(i));
				// dvar_vector tmp = N(h)(i);

				for(int m = 1; m <= nmature; m++ )
				{
					for(int o = 1; o <= nshell; o++ )
					{
						ig   = pntr_hmo(h,m,o);
						if(shell == 0) nal += d3_N(ig)(i);
						if(shell == o) nal += d3_N(ig)(i);
					}
				}
				dvar_vector tmp = nal;
				
				switch (type)
				{
					case 1:     // retained
						dNtmp = elem_prod(tmp,elem_prod(sel,ret));
					break;
					case 2:     // discarded
						dNtmp = elem_prod(tmp,elem_prod(sel,dis));
					break;
					default:	// both retained and discarded
						dNtmp = elem_prod(tmp,sel);
					break;
				}

			}
			else // sexes combined in the observations
			{
				for( h = 1; h <= nsex; h++ )
				{
					dvar_vector sel = exp(log_slx_capture(k)(h)(i));
					dvar_vector ret = exp(log_slx_retaind(k)(h)(i));
					dvar_vector dis = exp(log_slx_discard(k)(h)(i));
					// dvar_vector tmp = N(h)(i);

					for(int m = 1; m <= nmature; m++ )
					{
						for(int o = 1; o <= nshell; o++ )
						{
							ig   = pntr_hmo(h,m,o);
							if(shell == 0) nal += d3_N(ig)(i);
							if(shell == o) nal += d3_N(ig)(i);
						}
					}
					dvar_vector tmp = nal;

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
	 * @brief calculate objective function
	 * @details 
	 * 
	 * Likelihood components
	 *  -# likelihood of the catch data (assume lognormal error)
	 *  -# likelihood of relative abundance data
	 *  -# likelihood of size composition data
	 * 
	 * Penalty components
	 *  -# Penalty on log_fdev to ensure they sum to zero.
	 *  -# Penalty to regularize values of log_fbar.
	 *  -# Penalty to constrain random walk in natural mortaliy rates
	 * 
	 */
FUNCTION calc_objective_function

	// |---------------------------------------------------------------------------------|
	// | NEGATIVE LOGLIKELIHOOD COMPONENTS FOR THE OBJECTIVE FUNCTION                    |
	// |---------------------------------------------------------------------------------|
	nloglike.initialize();
	
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
			case 1:  // multinomial with fixed or estimated n
				ploglike = new acl::multinomial(O,bCmp);
			break;

			case 2:  // robust approximation to the multinomial
				if( current_phase() <= 3 || !last_phase() )
					ploglike = new acl::multinomial(O,bCmp);
				else
					ploglike = new acl::robust_multi(O,bCmp);
			break;
		}
		// Compute residuals in the last phase.
		if(last_phase()) 
		{
		  d3_res_size_comps(ii) = ploglike->residual(log_effn,P);
		}

		// now compute the likelihood.
		nloglike(3,ii) += ploglike->nloglike(log_effn,P);
	}
	objfun = sum(nloglike) + sum(nlogPenalty) + sum(priorDensity);
	if( verbose==2 ) { COUT(objfun); COUT(nloglike); COUT(nlogPenalty); COUT(priorDensity); }

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

	// Population dynamics ...

	// observation models ...
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
	REPORT(priorDensity);
	REPORT(dCatchData);
	REPORT(obs_catch);
	REPORT(pre_catch);
	REPORT(res_catch);
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
	REPORT(F);
	REPORT(d3_SizeComps);

	REPORT(d3_obs_size_comps);
	REPORT(d3_pre_size_comps);
	REPORT(d3_res_size_comps);
	REPORT(ft);
	REPORT(rec_sdd);
	REPORT(growth_transition);
	REPORT(rec_ini);
	REPORT(rec_dev);
	REPORT(recruits);
	REPORT(d3_N);
	REPORT(M);
	REPORT(mean_wt);
	REPORT(molt_probability);
	dvector mmb = value(calc_mmb());
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
			growth_matrix(isex,iage) = growth_transition(isex,iage);
			mean_size(isex,iage)     = growth_matrix(isex,iage) * mid_points /sum(growth_matrix(isex,iage));
			for (iage=2;iage<=nclass;iage++)
			{
				growth_matrix(isex,iage) = growth_matrix(isex,iage-1)*growth_transition(isex);
				mean_size(isex,iage)     = growth_matrix(isex,iage) * mid_points / sum(growth_matrix(isex,iage));
			}
		}
		REPORT(growth_matrix);
		REPORT(mean_size);
		for(int ii = 1; ii <= nSizeComps; ii++)
		{
			// Set final sample-size for composition data for comparisons
			size_comp_sample_size(ii) = value(exp(log_vn(ii))) * size_comp_sample_size(ii);
		}
		REPORT(size_comp_sample_size);
	}
	// Print total numbers at length
	dvar_matrix N_len(syr,nyr+1,1,nclass);
	dvar_matrix N_mm(syr,nyr+1,1,nclass);
	dvar_matrix N_males(syr,nyr+1,1,nclass);
	dvar_matrix N_males_old(syr,nyr+1,1,nclass);
	N_len.initialize();
	N_males.initialize();
	N_mm.initialize();
	N_males_old.initialize();
	for (int i=syr;i<=nyr+1;i++)
	  for (int j=1;j<=nclass;j++)
	    for (int k=1;k<=n_grp;k++)
	    {	
				if (isex(k)==1)
	    	{
	    		N_males(i,j) += d3_N(k,i,j);
					if (ishell(k)==2)
		    		N_males_old(i,j) += d3_N(k,i,j);
					if (imature(k)==1)
		    		N_mm(i,j) += d3_N(k,i,j);
	    	}
	    	N_len(i,j) += d3_N(k,i,j);
	    }

	REPORT(N_len);
	REPORT(N_mm);
	REPORT(N_males);
	REPORT(N_males_old);
	REPORT(molt_increment);
	REPORT(dPreMoltSize);
	REPORT(iMoltIncSex);
	REPORT(dMoltInc);
	if(bUseEmpiricalGrowth)
	{
		dvector pMoltInc = dMoltInc;
		REPORT(pMoltInc);
	}
	else
	{
		dvar_vector pMoltInc = calc_growth_increments(dPreMoltSize,iMoltIncSex);
		REPORT(pMoltInc);
	}
	REPORT(P);
	REPORT(growth_transition);
	dmatrix size_transition_M(1,nclass,1,nclass);
	dmatrix size_transition_F(1,nclass,1,nclass);

	size_transition_M = value(P(1) * growth_transition(1));
	for (int i=1;i<=nclass;i++)
	  size_transition_M(i,i) += value(1.-P(1,i,i));

	REPORT(size_transition_M);
	
	if (nsex==2)
	{
  	size_transition_F = value(P(2) * growth_transition(2));
  	for (int i=1;i<=nclass;i++)
	    size_transition_M(i,i) += value(1.-P(2,i,i));
  	REPORT(size_transition_F);
	}

	/**
	 * @brief Calculate mature male biomass
	 
	 * 
	 * 
	 * TODO correct for timing of when the MMB is calculated
	 * 
	 * @return dvar_vector
	 */
FUNCTION dvar_vector calc_mmb()
	dvar_vector mmb(syr,nyr);
	mmb.initialize();
	int ig,m,o;
	int h = 1;  // males
	for(int i = syr; i <= nyr; i++ )
	{
		if( nmature == 1 )      // continous molt
		{
			m = 1;
		}
		else if( nmature == 2 ) // terminal molt males only
		{
			m = 2;
		}
		for( o = 1; o <= nshell; o++ )
		{
			ig = pntr_hmo(h,m,o);
			mmb(i) += d3_N(ig)(i) * elem_prod(mean_wt(h),maturity(h));
		}
	}
	return(mmb);


// To be deprecated?
//FUNCTION dvariable robust_multi(const dmatrix O, const dvar_matrix P, const dvar_vector lnN)
//  /**
//   * @brief Robustified Multinomial likleihood for composition data.
//   * @details Follows Fournier's approach
//   * 
//   * @param lnN The assumed log of sample size 
//   * @return returns the negative log likelihood.
//   * 
//   * TO BE Deprecated, now lives in robust_multi.cpp
//   */   
//	if( lnN.indexmin() != O.rowmin() || lnN.indexmax() != O.rowmax() )
//	{
//		cerr<<"Sample size index do not match row index in\
//			   observed size composition matrix."<<endl;
//		ad_exit(1);
//	}
//	RETURN_ARRAYS_INCREMENT();
//	dvariable nll = 0;
//	double tiny = 1.e-14;
//	double  a  = .1/size_count(O(1));
//	dvar_vector b  = exp(lnN);
//
//	for(int i = O.rowmin(); i <= O.rowmax(); i++ )
//	{
//		dvector      o =  O(i) + tiny;
//		dvar_vector  p =  P(i) + tiny;
//		o /= sum(o);
//		p /= sum(p);
//
//		dvar_vector v = a  + 2. * elem_prod(o ,1.  - o );
//		dvar_vector l  =  elem_div(square(p - o), v );
//		nll -= sum(log(mfexp(-1.* b(i) * l) + .01));  
//		nll += 0.5 * sum(log(v));
//
//	}
//	RETURN_ARRAYS_DECREMENT();
//	return nll;


	/**
	 * @brief calculate spr-based reference points.
	 * @details Calculate the SPR-ratio for a given value of F.
	 * 
	 * Psuedocode:
	 *  -# calculate average recruitment over reference period.
	 *  -# compute the ratio of F's based on reference year (nyr)
	 *  -# calculate fishing mortality vector.
	 *  -# calculate equibrium total mortality vector.
	 *  -# calculate growth/survival transition matrix.
	 *  
	 *  ARGS:
	 *  @param iyr Reference year for selectivity and fishing mortality ratios
	 *  @param ifleet index for gear to compute SPR values, other fleets with const F
	 *  
	 *  got response from andre, “The convention is to fix F for all 
	 *  non-directed fisheries to a recent average and to solve for 
	 *  the F for the directed fishery so that you achieve B35%.” but 
	 *  I think he meant F35
	 *  
	 *  Use bisection method to find SPR_target.
	 *  
	 *  Three possible states
	 *  nshell = 1,
	 *  nshell = 2 && nmaturity = 1,
	 *  nshell = 2 && nmaturity = 2.
	 *  
	 */
FUNCTION void calc_spr_reference_points(const int iyr,const int ifleet)
	
	// Average recruitment
	spr_rbar =  mean(value(recruits(spr_syr,spr_nyr)));

	double   _r = spr_rbar;
	dvector _rx = value(rec_sdd);
	d3_array _M(1,nsex,1,nclass,1,nclass);
	_M.initialize();
	dmatrix _N(1,nsex,1,nclass);
	dmatrix _wa(1,nsex,1,nclass);
	d3_array _A = value(growth_transition);
	d3_array _P = value(P);
	for(int h = 1; h <= nsex; h++ )
	{
		for(int l = 1; l <= nclass; l++ )
		{
			_M(h)(l,l) = value(M(h)(iyr)(l));
		}
		//todo fix me.
		_N(h) = value(d3_N(1)(iyr));
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
	

	//spr *ptrSPR=nullptr;
	spr *ptrSPR=0;



	// SPR reference points for a single shell condition.
	if(nshell == 1)
	{
		spr c_spr(_r,spr_lambda,_rx,_wa,_M,_A);
		ptrSPR = &c_spr;
	}
	// SPR reference points for new and old shell condition.
	if(nshell == 2)
	{
		spr c_spr(_r,spr_lambda,_rx,_wa,_M,_P,_A);
		ptrSPR = &c_spr;    
	}
	spr_fspr = ptrSPR->get_fspr(ifleet,spr_target,_fhk,_sel,_ret,_dmr);
	spr_bspr = ptrSPR->get_bspr();

	// OFL Calculations
	dvector mmb = value(calc_mmb());
	double cuttoff = 0.1;
	double limit = 0.25;
	spr_fofl = ptrSPR->get_fofl(cuttoff,limit,mmb(nyr));
	spr_cofl = ptrSPR->get_cofl(_N);

	


	
	
	

RUNTIME_SECTION
  maximum_function_evaluations 500,  500,   1500, 25000, 25000
  convergence_criteria        1.e-4, 1.e-4, 1.e-4, 1.e-4, 1.e-4, 


GLOBALS_SECTION
	#include <admodel.h>
	#include <time.h>
	//#include <contrib.h>
	#if defined __APPLE__ || defined __linux
	#include "../../src/include/libgmacs.h"
	#endif

	#if defined _WIN32 || defined _WIN64
	#include "include\libgmacs.h"
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
	 \def CHECK(object)
	 Prints name and value of \a object on checkfile %ofstream output file.
	 */
	 #define CHECK(object) checkfile << #object << "\n" << object << endl;
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

	/**
	\def REPORT(object)
	Prints name and value of \a object on ADMB report %ofstream file.
	*/
	#undef REPORT
	#define REPORT(object) report << #object "\n" << object << endl;
	
	#undef CHECK
	#define CHECK(object) strCheckFile << #object "\n" << object << endl;
	
	#include <admodel.h>
	#include <time.h>
	#include <stats.cxx>
	
	//#include <martool.cxx>
	time_t start,finish;
	long hour,minute,second;
	double elapsed_time;
	ofstream strCheckFile;
	
#include <admodel.h>
#include <contrib.h>

  extern "C"  {
    void ad_boundf(int i);
  }
#include <gcm.htp>

model_data::model_data(int argc,char * argv[]) : ad_comm(argc,argv)
{
  data_file.allocate("data_file");
  control_file.allocate("control_file");
		simFlag=0;
		rseed=999;
		int on,opt;
		//the following line checks for the "-SimFlag" command line option
		//if it exists the if statement retreives the random number seed
		//that is required for the simulation model
		if((on=option_match(ad_comm::argc,ad_comm::argv,"-sim",opt))>-1)
		{
			simFlag=1;
			rseed=atoi(ad_comm::argv[on+1]);
			//if(SimFlag)exit(1);
		}
 ad_comm::change_datafile_name(data_file);
  syr.allocate("syr");
  nyr.allocate("nyr");
  ngear.allocate("ngear");
  nbin.allocate("nbin");
  lm50.allocate("lm50");
  lm95.allocate("lm95");
  mx.allocate(1,nbin);
  xbin.allocate(1,nbin,"xbin");
  wx.allocate(1,nbin,"wx");
  n_ct.allocate("n_ct");
  n_ct_rows.allocate(1,n_ct,"n_ct_rows");
  disc_mort.allocate(1,n_ct,"disc_mort");
  catch_data.allocate(1,n_ct,1,n_ct_rows,1,5,"catch_data");
  obs_ct.allocate(1,n_ct,1,n_ct_rows);
  obs_ct_dis.allocate(1,n_ct,1,n_ct_rows);
  yrs_ct.allocate(1,n_ct,1,n_ct_rows);
		int k;
		for(k=1;k<=n_ct;k++)
		{
			obs_ct(k) = column(catch_data(k),4);
			obs_ct_dis(k) = column(catch_data(k),5);
			yrs_ct(k) = ivector(column(catch_data(k),1));
		}
  n_q.allocate("n_q");
  n_it.allocate("n_it");
  n_it_rows.allocate(1,n_it,"n_it_rows");
  it_data.allocate(1,n_it,1,n_it_rows,1,7,"it_data");
  obs_it.allocate(1,n_it,1,n_it_rows);
  rwt_it.allocate(1,n_it,1,n_it_rows);
  yrs_it.allocate(1,n_it,1,n_it_rows);
  fyr_it.allocate(1,n_it,1,n_it_rows);
		for(k=1;k<=n_it;k++)
		{
			obs_it(k) = column(it_data(k),5);
			rwt_it(k) = column(it_data(k),6)+1.e-10; //add small constant to allow 0 weight
			yrs_it(k) = ivector(column(it_data(k),1));
			fyr_it(k) = column(it_data(k),7)/365.25; 
		}
  n_lf.allocate("n_lf");
  n_lf_rows.allocate(1,n_lf,"n_lf_rows");
  lf_data.allocate(1,n_lf,1,n_lf_rows,-3,nbin,"lf_data");
  obs_lf.allocate(1,n_lf,1,n_lf_rows,1,nbin);
		int i;
		for(k=1;k<=n_lf;k++)
		{
			obs_lf(k) = trans(trans(lf_data(k)).sub(1,nbin));
			for(i=1;i<=n_lf_rows(k);i++)
			{
				obs_lf(k)(i) /= sum(obs_lf(k)(i));
			}
		}
  eof.allocate("eof");
 cout<<eof<<endl;
 if(eof != 999){ cout<<"!!! Error reading data file !!!"<<endl; exit(1); }
 ad_comm::change_datafile_name(control_file);
  npar.allocate("npar");
  theta_control.allocate(1,npar,1,7,"theta_control");
  theta_ival.allocate(1,npar);
  theta_lb.allocate(1,npar);
  theta_ub.allocate(1,npar);
  theta_phz.allocate(1,npar);
  theta_prior.allocate(1,npar);
		theta_ival  = column(theta_control,1);
		theta_lb    = column(theta_control,2);
		theta_ub    = column(theta_control,3);
		theta_phz   = ivector(column(theta_control,4));
		theta_prior = ivector(column(theta_control,5));
  isel_type.allocate(1,ngear,"isel_type");
  l_hat.allocate(1,ngear,"l_hat");
  g_hat.allocate(1,ngear,"g_hat");
  l_nodes.allocate(1,ngear,"l_nodes");
  yr_nodes.allocate(1,ngear,"yr_nodes");
  sel_phz.allocate(1,ngear,"sel_phz");
  sel_2nd_diff_wt.allocate(1,ngear,"sel_2nd_diff_wt");
  sel_dome_wt.allocate(1,ngear,"sel_dome_wt");
  isel_npar.allocate(1,ngear);
  jsel_npar.allocate(1,ngear);
		//Determin the number of selectivity parameters
		isel_npar.initialize();
		for(int i=1;i<=ngear;i++)
		{
			jsel_npar(i)=1;
			switch(isel_type(i))
			{
				case 1:
					isel_npar(i)=2;
				break;
				case 2: //AE Punt's logistic parameterization L50 & L95
					isel_npar(i)=2;
				break;
				//Need to implement other cases
			}
		}
  isel_type_ret.allocate(1,ngear,"isel_type_ret");
  l_hat_ret.allocate(1,ngear,"l_hat_ret");
  g_hat_ret.allocate(1,ngear,"g_hat_ret");
  l_nodes_ret.allocate(1,ngear,"l_nodes_ret");
  yr_nodes_ret.allocate(1,ngear,"yr_nodes_ret");
  sel_phz_ret.allocate(1,ngear,"sel_phz_ret");
  sel_2nd_diff_wt_ret.allocate(1,ngear,"sel_2nd_diff_wt_ret");
  sel_dome_wt_ret.allocate(1,ngear,"sel_dome_wt_ret");
  isel_npar_ret.allocate(1,ngear);
  jsel_npar_ret.allocate(1,ngear);
		//Determine the number of selectivity parameters
		isel_npar_ret.initialize();
		for(int i=1;i<=ngear;i++)
		{
			jsel_npar_ret(i)=1;
			switch(isel_type_ret(i))
			{
				case 1:
					isel_npar_ret(i)=2;
				break;
				case 2: //AE Punt's logistic parameterization L50 & L95
					isel_npar_ret(i)=2;
				break;
				//Need to implement other cases
			}
		}
  n_it_q.allocate("n_it_q");
  q_prior.allocate(1,n_it_q,"q_prior");
  q_mu.allocate(1,n_it_q,"q_mu");
  q_sd.allocate(1,n_it_q,"q_sd");
 cout<<"q Prior mean & sd \n"<<q_mu<<endl<<q_sd<<endl;
  cntrl.allocate(1,14,"cntrl");
  eocf.allocate("eocf");
 cout<<eocf<<endl;
}

model_parameters::model_parameters(int sz,int argc,char * argv[]) : 
 model_data(argc,argv) , function_minimizer(sz)
{
  initializationfunction();
  theta.allocate(1,npar,theta_lb,theta_ub,theta_phz,"theta");
 for(int i=1;i<=npar;i++) theta(i)=theta_ival(i);
  log_fbar.allocate(1,n_ct,-30,2.5,"log_fbar");
  log_ft_dev.allocate(1,n_ct,1,n_ct_rows,-5.0,5.0,2,"log_ft_dev");
 log_fbar = log(0.1);
  log_q.allocate(1,n_q,-50.,10,1,"log_q");
  log_sig.allocate(1,n_q,-50,10,5,"log_sig");
 log_sig=log(0.05);
  log_rt_dev.allocate(syr,nyr,-5.0,5.0,3,"log_rt_dev");
  log_init_n_dev.allocate(1,nbin,-5.0,5.0,1,"log_init_n_dev");
  sel_par.allocate(1,n_ct,1,jsel_npar,1,isel_npar,-15.,15.,sel_phz,"sel_par");
		// initial values for logistic selectivity parameters
		// set phase to -1 for fixed selectivity.
		for(int i=1;i<=n_ct;i++)
		{
			if( isel_type(i)<=2 )
			{
				sel_par(i,1,1) = log(l_hat(i));
				sel_par(i,1,2) = log(g_hat(i));
			}
		}
  sel_par_ret.allocate(1,n_ct,1,jsel_npar_ret,1,isel_npar_ret,-15.,15.,sel_phz_ret,"sel_par_ret");
		// initial values for logistic selectivity parameters
		// set phase to -1 for fixed selectivity.
		for(int i=1;i<=n_ct;i++)
		{
			if( isel_type_ret(i)<=2 )
			{
				sel_par_ret(i,1,1) = log(l_hat_ret(i));
				sel_par_ret(i,1,2) = log(g_hat_ret(i));
			}
		}
  f.allocate("f");
  prior_function_value.allocate("prior_function_value");
  likelihood_function_value.allocate("likelihood_function_value");
  log_rbar.allocate("log_rbar");
  #ifndef NO_AD_INITIALIZE
  log_rbar.initialize();
  #endif
  rec_mu.allocate("rec_mu");
  #ifndef NO_AD_INITIALIZE
  rec_mu.initialize();
  #endif
  rec_cv.allocate("rec_cv");
  #ifndef NO_AD_INITIALIZE
  rec_cv.initialize();
  #endif
  log_init_n.allocate("log_init_n");
  #ifndef NO_AD_INITIALIZE
  log_init_n.initialize();
  #endif
  m.allocate("m");
  #ifndef NO_AD_INITIALIZE
  m.initialize();
  #endif
  a.allocate("a");
  #ifndef NO_AD_INITIALIZE
  a.initialize();
  #endif
  b.allocate("b");
  #ifndef NO_AD_INITIALIZE
  b.initialize();
  #endif
  beta.allocate("beta");
  #ifndef NO_AD_INITIALIZE
  beta.initialize();
  #endif
  x_rec.allocate(1,nbin,"x_rec");
  #ifndef NO_AD_INITIALIZE
    x_rec.initialize();
  #endif
  rt.allocate(syr,nyr,"rt");
  #ifndef NO_AD_INITIALIZE
    rt.initialize();
  #endif
  q.allocate(1,n_q,"q");
  #ifndef NO_AD_INITIALIZE
    q.initialize();
  #endif
  cpue_sig.allocate(1,n_it,"cpue_sig");
  #ifndef NO_AD_INITIALIZE
    cpue_sig.initialize();
  #endif
  LTM.allocate(1,nbin,1,nbin,"LTM");
  #ifndef NO_AD_INITIALIZE
    LTM.initialize();
  #endif
  Z.allocate(syr,nyr,1,nbin,"Z");
  #ifndef NO_AD_INITIALIZE
    Z.initialize();
  #endif
  F.allocate(syr,nyr,1,n_ct,"F");
  #ifndef NO_AD_INITIALIZE
    F.initialize();
  #endif
  N.allocate(syr,nyr+1,1,nbin,"N");
  #ifndef NO_AD_INITIALIZE
    N.initialize();
  #endif
  pred_ct.allocate(1,n_ct,1,n_ct_rows,"pred_ct");
  #ifndef NO_AD_INITIALIZE
    pred_ct.initialize();
  #endif
  pred_ct_dis.allocate(1,n_ct,1,n_ct_rows,"pred_ct_dis");
  #ifndef NO_AD_INITIALIZE
    pred_ct_dis.initialize();
  #endif
  epsilon.allocate(1,n_ct,1,n_ct_rows,"epsilon");
  #ifndef NO_AD_INITIALIZE
    epsilon.initialize();
  #endif
  delta.allocate(1,n_ct,1,n_ct_rows,"delta");
  #ifndef NO_AD_INITIALIZE
    delta.initialize();
  #endif
  pred_it.allocate(1,n_it,1,n_it_rows,"pred_it");
  #ifndef NO_AD_INITIALIZE
    pred_it.initialize();
  #endif
  nu.allocate(1,n_it,1,n_it_rows,"nu");
  #ifndef NO_AD_INITIALIZE
    nu.initialize();
  #endif
  sel.allocate(1,ngear,syr,nyr,1,nbin,"sel");
  #ifndef NO_AD_INITIALIZE
    sel.initialize();
  #endif
  ret.allocate(1,ngear,syr,nyr,1,nbin,"ret");
  #ifndef NO_AD_INITIALIZE
    ret.initialize();
  #endif
  pred_lf.allocate(1,n_lf,1,n_lf_rows,1,nbin,"pred_lf");
  #ifndef NO_AD_INITIALIZE
    pred_lf.initialize();
  #endif
  eta.allocate(1,n_lf,1,n_lf_rows,1,nbin,"eta");
  #ifndef NO_AD_INITIALIZE
    eta.initialize();
  #endif
}

void model_parameters::preliminary_calculations(void)
{

  admaster_slave_variable_interface(*this);
    if(simFlag)
	{
		cout<<"Simulation mode"<<endl;
		simulation_model();
		//exit(1);
	}
	
}

void model_parameters::userfunction(void)
{
  f =0.0;
	/***********************************/
	initialize_parameters();
	calc_recruitment();
	calc_ltm();
	calc_selectivity();
	calc_selectivity_ret();
	calc_mortality();
	population_dynamics();
	catch_observations();
	catch_at_length();
	calc_relative_abundance();
	calc_objective_function();
	/***********************************/
}

void model_parameters::initialize_parameters(void)
{
	log_rbar   = theta(1);
	rec_mu     = mfexp(theta(2));
	rec_cv     = mfexp(theta(3));
	log_init_n = theta(4);
	m          = mfexp(theta(5));
	a          = theta(6);
	b          = theta(7);
	beta       = mfexp(theta(8));
	cpue_sig   = mfexp(log_sig);
}

void model_parameters::calc_recruitment(void)
{
	/*
	Use the gamma density function to calculate the 
	distribution of new recruits over the length intervals.
	gamma_density(xbin,r,mu)
	r is given by E(x)^2/V(x)
	mu is given by E(x)/V(x)
	Estimated parameter are the expected mean length in log space: log(E(x))
	and the variance in the expected mean length in log space:     log(V(x))
	*/
	int i;
	dvariable std = rec_mu*rec_cv;
	dvariable r   = square(rec_mu)/(std*std);
	dvariable mu  = rec_mu/(std*std);
	for(i=1;i<=nbin;i++)
	{
		x_rec(i) = gamma_density(xbin(i),r,mu);
	}
	x_rec /= sum(x_rec);
	// annual recruitment
	rt = mfexp( log_rbar + log_rt_dev );
}

void model_parameters::calc_ltm(void)
{
	/*
	This routine calculates the length transition matrix based on the 
	mean growth increment parameter that is estimated.
	Use the cumd_gamma(x,alpha), where x is the change in length 
	interval from x(i) to x(j) and alpha = dx/beta, where alpha > 0
	*/
	int i,j;
	double dx,bw;
	bw = 0.5*(xbin(2)-xbin(1));
	dvariable t1,t2;
	LTM.initialize();
	dvar_vector dl(1,nbin);
	//cout<<beta<<endl;
	dl = ( a + b*xbin ) / beta;  //linear growth model
	//dl = (pow(a*xbin,b)-xbin)/beta; //non-linear, but use posfun
	for(i=1;i<=nbin;i++)
	{
		for(j=i;j<=nbin;j++)
		{
			dx = (xbin(j) - xbin(i));
			t1 = cumd_gamma(dx-bw,dl(i));
			t2 = cumd_gamma(dx+bw,dl(i));
			LTM(i,j)=t2-t1;
		}
		LTM(i) /= sum(LTM(i));
	}
}

void model_parameters::calc_selectivity(void)
{
	/*
	This routine calculates the length-based selectivities for each
	gear type. Currently only using the logistic function
	*/
	int i,j,k;
	dvariable p1,p2,p3;
	sel.initialize();
	for(k=1;k<=ngear;k++)
	{
		switch(isel_type(k))
		{
			case 1:
				p1 = mfexp(sel_par(k,1,1));
				p2 = mfexp(sel_par(k,1,2));
				for(j=syr;j<=nyr;j++)
				{
					sel(k)(j) = plogis(xbin,p1,p2);
				}
			break;
			case 2:
				p1 = mfexp(sel_par(k,1,1));
				p2 = mfexp(sel_par(k,1,2));
				for(j=syr;j<=nyr;j++)
				{
					sel(k)(j) = aplogis(xbin,p1,p2);
				}
			break;
		}
	}
}

void model_parameters::calc_selectivity_ret(void)
{
	/*
	This routine calculates the length-based selectivities for each
	gear type discards. Currently only using the logistic function
	*/
	int i,j,k;
	dvariable p1,p2,p3;
	ret.initialize();
	for(k=1;k<=ngear;k++)
	{
		if(sel_phz_ret(k)>0)  //if negative assume 0 retention
		{
			switch(isel_type_ret(k))
			{
				case 1:
					p1 = mfexp(sel_par_ret(k,1,1));
					p2 = mfexp(sel_par_ret(k,1,2));
					for(j=syr;j<=nyr;j++)
					{
						ret(k)(j) = plogis(xbin,p1,p2);
					}
				break;
				case 2:
					p1 = mfexp(sel_par_ret(k,1,1));
					p2 = mfexp(sel_par_ret(k,1,2));
					for(j=syr;j<=nyr;j++)
					{
						ret(k)(j) = aplogis(xbin,p1,p2);
					}
				break;
			}
		}
	}
}

void model_parameters::calc_mortality(void)
{
	/*
	This routine calculates the Z(j,i) in year j for length interval i.
	To do so Z (j,i) = M(i) + sum_k ( F(j,k)*sel(k,j,i) ), where
	F(j,k) = exp( log_fbar(k) + ft_dev(k,j) )
	The mortality is based on the the retained and discarded catch
	that dies after being thrown overboard.  Must specify dicard_mort_rate
	in the calculation of discarded catch.
	*/
	int i,j,k;
	Z.initialize();
	F.initialize();
	Z = m;
	for(k=1;k<=n_ct;k++)
	{
		for(i=1;i<=n_ct_rows(k);i++)
		{
			j = catch_data(k,i,1);	// index for year
			F(j,k) = mfexp( log_fbar(k) + log_ft_dev(k,i) );
			Z(j) += F(j,k) * sel(k)(j);
		}
	}
}

void model_parameters::population_dynamics(void)
{
	/*
	This routine initializes the numbers at length and then
	updates the numbers at length each year based on toal 
	mortality (Z(j,i)) and annual recruitment (rt(j))
	*/
	int i,j,k;
	// initialize numbers at length.
	N(syr) = mfexp( log_init_n + log_init_n_dev );
	// update numbers at length 
	for(j=syr;j<=nyr;j++)
	{
		N(j+1) = elem_prod( N(j),mfexp(-Z(j)) ) * LTM + rt(j)*x_rec;
	}
}

void model_parameters::catch_observations(void)
{
	/*
	Calculate predicted catches and residuals.
	SM: Changed to accomodate bycath in directed & non-directed
	fisheries.  In this case, calc total catch then subtract
	off the by catch-at-length.
	Ctot = F*sel/Z*(1-exp(-Z))*N
	Cret = F*sel*ret_sel/Z*(1-exp(-Z))*N
	Cdis = (Ctot-Cret)*discard_mortality
	*/
	int g,h,i,j,k;
	epsilon.initialize();
	delta.initialize();
	for(k=1;k<=n_ct;k++)
	{
		for(i=1;i<=n_ct_rows(k);i++)
		{
			j = catch_data(k,i,1);	// index for year
			g = catch_data(k,i,2);	// index for gear (selectivity)
			h = catch_data(k,i,3);	// swtich for type of catch 0=catch biomass
			// calculate total catch at length for gear k.
			dvar_vector ft = F(j,k) * sel(g)(j);
			dvar_vector st = 1.-mfexp(-Z(j));
			dvar_vector ct = elem_prod( N(j),elem_div(elem_prod(ft,st),Z(j)) );
			// calculate retained catch at length for gear k.
			// FIXME: should only calculate ct_ret if obs_ct_ret > 0
			dvar_vector ct_ret(1,nbin);
			ct_ret.initialize();
			if(obs_ct(k)(i)>0)
				ct_ret = elem_prod( ct,ret(g)(j) );
			// calculate discarded catch at length
			dvar_vector ct_dis = ct - ct_ret;
			// total catch (ct = tons, wx in grams, N is millions of crabs)
			if(!h)
			{
				pred_ct(k,i)     = ct_ret * wx;
				pred_ct_dis(k,i) = disc_mort(k) * ct_dis * wx;
			}
			else
			{
				pred_ct(k,i)     = sum(ct_ret);
				pred_ct_dis(k,i) = sum(disc_mort(k) * ct_dis);
			}
			// residuals
			if(obs_ct(k)(i)>0)
				epsilon(k,i) = log( obs_ct(k,i) ) - log( pred_ct(k,i) );
			if(obs_ct_dis(k)(i)>0)
				delta(k,i)   = log(obs_ct_dis(k,i)) - log(pred_ct_dis(k,i));
		}
	}
}

void model_parameters::catch_at_length(void)
{
	/*
	Calculated predicted catches at length and residuals.
	Total catch-at-length is the average abundance at length
	during the year, where the retained portion is the total
	catch times the retained at length.  The discard catch at
	length is the difference between the total and retained.
	*/
	int g,h,i,j,k;
	dvar_vector fi(1,nbin);
	dvar_vector ci(1,nbin);
	dvar_vector si(1,nbin);
	dvar_vector ri(1,nbin);
	dvar_vector di(1,nbin);
	for(k=1;k<=n_lf;k++)
	{
		for(i=1;i<=n_lf_rows(k);i++)
		{
			j  = lf_data(k,i,-3);	// index for year
			g  = lf_data(k,i,-2);	// index for gear (selectivity)
			h  = lf_data(k,i, 0);	// switch for type of lf (1=catch-at-length, 2=discard-at-length)
			// calculate total vulnerable numbers at length for gear (g)
			fi = sel(g)(j);
			si = 1.-mfexp(-Z(j));
			ci = elem_prod(N(j), elem_div( elem_prod(fi,si), Z(j) ));
			ri = elem_prod( ci, ret(g)(j) );
			di = ci - ri;
			if(h==1)  // retained catch at length
			{
				pred_lf(k)(i) = ri/sum(ri);
			}
			else      // discarded catch at length
			{
				pred_lf(k)(i) = di/sum(di);
			}
			//residual in lf... this should be the proper residual not here.
			eta(k)(i) = obs_lf(k)(i) - pred_lf(k)(i);  
		}
	}
}

void model_parameters::calc_relative_abundance(void)
{
	/*
	This routine calculates the predicted relative abundance
	indicies, and uses the conditional maximum likelihood estimates
	for the catchability coefficients (q) and residuals nu.
	FIXME v: change calculation, where the same q is used for both
	retained and estimated cpue. Also need to check the likelihood 
	components for hte relative abundance data (number of pars.)
	                                retained cpue=q*N*sel*ret
	                                 discard cpue=q*N*sel*(1.-ret)
	TODO: modify the code to allow for CPUE by weight.
	CHANGED: change to retained and discard cpue
	CHANGED: change so that cpue is based on average N, not start of year N
	*/
	int g,h,i,j,k,l;
	dvariable lnq;
	dvar_vector nj(1,nbin);
	q = exp(log_q);
	for(k=1;k<=n_it;k++)
	{
		dvar_vector zt(1,n_it_rows(k));
		dvar_vector nt(1,n_it_rows(k));
		for(i=1;i<=n_it_rows(k);i++)
		{
			j     = it_data(k,i,1);	//index for year
			g     = it_data(k,i,2);	//index for gear
			l     = it_data(k,i,3); //inded for q
			h     = it_data(k,i,4); //flag for type 1=retained cpue, 2=discard cpue
			// nj is numbers for all sizes after fyr_it fraction of Z
			nj    = q(l)*elem_prod( N(j), exp(-fyr_it(k)(i)*Z(j)) );
			switch(h)
			{
				case 1:  // retained cpue
					nt(i) = nj * elem_prod(sel(g)(j),ret(g)(j));
				break;
				case 2:  // discard cpue
					nt(i) = nj * elem_prod(sel(g)(j),1.-ret(g)(j));
				break;
			}
			zt(i) = (log(obs_it(k,i)) - log(nt(i)));
		}
		nu(k) = zt;			// residual
		pred_it(k) = nt;	// predicted cpue
	}
}

void model_parameters::calc_objective_function(void)
{
	/*
	This routine calculates the objective function which consists of
	a seris of:
		nllvec -> a vector of negative loglikelihoods for the data
	*/
	int i,j,k,kk;
	int n = 2*n_ct + n_it + n_lf;
	dvar_vector nllvec(1,n);
	dvar_vector penvec(1,n);
	nllvec.initialize();
	penvec.initialize();
	kk=1;
	// Likelihoods of retained and discard catch data
	double std_ct;
	if(!last_phase()) std_ct=cntrl(3); else std_ct=cntrl(4);
	for(k=1;k<=n_ct;k++)
	{
		if(sum(obs_ct(k))!=0)
		{
			epsilon(k) /= std_ct;
			nllvec(kk++) = dnorm(epsilon(k),1.0);
		}
	}
	for(k=1;k<=n_ct;k++)
	{
		if(sum(obs_ct_dis(k))!=0)
		{
			delta(k) /= std_ct;
			nllvec(kk++) = dnorm(delta(k),1.0);
		}
	}
	// Likelihoods for the relative abundance data
	// Treat the std_it as relative weights not a standard deviation.  FIXED
	// Estimate the observation error standard deviation.
	int l;
	dvariable sig;
	for(k=1;k<=n_it;k++)
	{
		for(i=1;i<=n_it_rows(k);i++)
		{
			l   = it_data(k)(i)(3);
			sig = cpue_sig(l)/rwt_it(k,i);
			nllvec(kk) += dnorm(nu(k,i),0,sig);
		}
		kk++;
	}
	// Likelihoods for the lf data
	double tau2;
	for(k=1;k<=n_lf;k++) 
	{
		dvector n = column(lf_data(k),-1);
		switch(int(cntrl(14)))
		{
			case 1:
				nllvec(kk) = dmvlogistic(obs_lf(k),pred_lf(k),tau2);
			break;
			case 2:
				nllvec(kk) = dmultinom(obs_lf(k),pred_lf(k),eta(k),n);
			break;
			case 3:
				dmatrix obs= mean(n)*obs_lf(k);
				nllvec(kk) = dmultinom(obs,pred_lf(k),eta(k),tau2,cntrl(6));
			break;
		}
		kk++;
	}
	// **** Penalties to regularize the model **** //
	// Penalty in fishing mortalities
	kk = 1;
	double fbar = cntrl(7);
	double std_fbar;
	if(!last_phase())
	{
		std_fbar = cntrl(8);
		for(k=1;k<=n_ct;k++)
		{
			penvec(kk++) = dnorm(log_fbar(k),log(fbar),std_fbar);
			penvec(kk)  += 12.5*norm2(log_ft_dev(k));
		}
	}
	else
	{
		std_fbar = cntrl(9);
		for(k=1;k<=n_ct;k++)
		{
			penvec(kk++) = dnorm(log_fbar(k),log(fbar),std_fbar);
			penvec(kk)  += 0.1*norm2(log_ft_dev(k));
		}
	}
	// Penalty to ensure log_ft_dev sum to zero for each gear
	for(k=1;k<=n_ct;k++)
	{
		dvariable mu = mean(log_ft_dev(k));
		penvec(kk) += 1000.*mu*mu;
	}
	kk++;
	// Penalty to for rec_devs
	// SM: This needs work, would need to estimate process error  variance.
	penvec(kk++) = dnorm(log_rt_dev,5.0);
	penvec(kk++) = dnorm(log_init_n_dev,5.0);
	/*
	PRIORS for estimated model parameters from the control file.
	*/
	dvar_vector priors(1,npar);
	dvariable ptmp; priors.initialize();
	for(i=1;i<=npar;i++)
	{
		if(active(theta(i)))
		{
			switch(theta_prior(i))
			{
			case 1:		//normal
				ptmp=dnorm(theta(i),theta_control(i,6),theta_control(i,7));
				break;
			case 2:		//lognormal CHANGED RF found an error in dlnorm prior. rev 116
				ptmp=dlnorm(theta(i),theta_control(i,6),theta_control(i,7));
				break;
			case 3:		//beta distribution (0-1 scale)
				double lb,ub;
				lb=theta_lb(i);
				ub=theta_ub(i);
				ptmp=dbeta((theta(i)-lb)/(ub-lb),theta_control(i,6),theta_control(i,7));
				break;
			case 4:		//gamma distribution
				ptmp=dgamma(theta(i),theta_control(i,6),theta_control(i,7));
				break;
			default:	//uniform density
				ptmp=1./(theta_control(i,3)-theta_control(i,2));
				break;
			}
			priors(i)=ptmp;	
		}
	}
	//cout<<"Negative loglikelihood\t"<<nllvec<<endl;
	//cout<<"Penalty componets     \t"<<penvec<<endl;
	f = sum(nllvec) + sum(penvec) + sum(priors);
}

dvariable model_parameters::dmvlogistic(const dmatrix o, const dvar_matrix& p, double& tau2)
{
	//returns the negative loglikelihood using the MLE for the variance
	RETURN_ARRAYS_INCREMENT();
	int a = o.colmin();
	int A=o.colmax();
	double tiny=0.001/(A-a+1);
	int t=o.rowmin();
	int T=o.rowmax();
	dvariable tau_hat2;		//mle of the variance
	dvar_matrix nu(t,T,a,A);
	for(int i=t; i<=T; i++)
	{
		dvector o1=o(i)/sum(o(i));
		dvar_vector p1=p(i)/sum(p(i));
		nu(i) = log(o1+tiny)-log(p1+tiny) - mean(log(o1+tiny)-log(p1+tiny));
	}
	tau_hat2 = 1./((A-a)*(T-t+1))*norm2(nu);
	dvariable nloglike =((A-a)*(T-t+1))*log(tau_hat2);
	tau2=value(tau_hat2); //mle of the variance 
	RETURN_ARRAYS_DECREMENT();
	return(nloglike);
}

dvariable model_parameters::drnorm(const dvector& o, const dvar_vector& p, const double& ns)
{
	/*
		This function calculates the robust normal likelihood.
		Written by Martell, intended to replace the redundant code in the
		objective_function routine.
	*/
	RETURN_ARRAYS_INCREMENT();
	double n           = size_count(o);
	dvector oo         = o/sum(o);
	dvar_vector pp     = p/sum(p);
	dvar_vector sig2   = (elem_prod((1.-oo),oo)+0.1/n)/ns;
	double twopi       = 6.283185;
	dvar_vector t1     = 0.5*log( twopi*sig2 );
	dvar_vector resid2 = elem_div( square(oo-pp),2.*sig2 );
	dvar_vector t6     = t1 - log(mfexp( (-1.)*resid2 )+0.01);
	RETURN_ARRAYS_DECREMENT();
	return( sum(t6) );
}

dvariable model_parameters::dnorm(const dvariable& x, const double& mu, const double& std)
{
	{
		double pi=3.141593;
		return 0.5*log(2.*pi)+log(std)+0.5*square(x-mu)/(std*std);
	}
}

dvariable model_parameters::dnorm(const dvariable& x, const double& mu, const dvariable& std)
{
	{
		double pi=3.141593;
		return 0.5*log(2.*pi)+log(std)+0.5*square(x-mu)/(std*std);
	}
}

dvariable model_parameters::dnorm(const dvar_vector& residual, const dvariable std)
{
	{
		RETURN_ARRAYS_INCREMENT();
		double pi=3.141593;
		long n=size_count(residual);
		dvariable SS=norm2(residual);
		RETURN_ARRAYS_DECREMENT();
		return(n*(0.5*log(2.*pi)+log(std))+0.5*SS/(std*std));
	}
}

dvariable model_parameters::dnorm(const dvar_vector& residual, const double std)
{
	{   
		RETURN_ARRAYS_INCREMENT();
		double pi=3.141593;
		long n=size_count(residual);
		dvariable SS=norm2(residual);
		RETURN_ARRAYS_DECREMENT();
		return(n*(0.5*log(2.*pi)+log(std))+0.5*SS/(std*std));
	}
}

dvariable model_parameters::dlnorm(const dvariable& x, const double& mu, const double& std)
{
	{
		double pi=3.141593;
		return 0.5*log(2.*pi)+log(std)+log(x)+square(log(x)-mu)/(2.*std*std);
	}
}

dvariable model_parameters::dbeta(const dvariable& x, const double a, const double b)
{
	{
		//E(x)=a/(a+b)
		//V(x)=ab/((a+b)^2(a+b+1))
		//b=(E(x)-1)(E(x)^2-E(x)+V(x))/V(x)
		//a=(E(x)b)/(1-E(x)) 
		return - gammln(a+b)+(gammln(a)+gammln(b))-(a-1.)*log(x)-(b-1.)*log(1.-x);
	}
}

dvariable model_parameters::dgamma(const dvariable &x, const double a, const double b)
{
	{
		//E(x)=a/b;
		//V(x)=a/b^2
		return -a*log(b)+gammln(a)-(a-1)*log(x)+b*x;
	}
}

dvar_vector model_parameters::plogis(const dvector& x, const dvariable& mu, const dvariable& sd)
{
	return 1./(1.+mfexp(-1.*(x-mu)/sd));
}

dvar_vector model_parameters::aplogis(const dvector& x, const dvariable& lam1, const dvariable & lam2)
{
	return 1./(1.+mfexp(-1.*log(19.)*(x-lam1)/(lam2-lam1)));
}

dvector model_parameters::aplogis(const dvector& x, const double& lam1, const double& lam2)
{
	return 1./(1.+mfexp(-1.*log(19.)*(x-lam1)/(lam2-lam1)));
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
	ivector yr(syr,nyr);
	yr.fill_seqadd(syr,1);
	ivector yrs(syr,nyr+1);
	yrs.fill_seqadd(syr,1);
	REPORT(yr);
	REPORT(yrs);
	REPORT(yrs_ct);
	REPORT(yrs_it);
	REPORT(xbin);
	mx = aplogis(xbin,lm50,lm95);
	dvector mmb(syr,nyr+1);
	mmb = value(N) * elem_prod(wx,mx);
	REPORT(mmb);
	REPORT(m);
	REPORT(F);
	REPORT(N);
	REPORT(sel);
	REPORT(ret);
	REPORT(epsilon);
	REPORT(delta);
	REPORT(nu);
	REPORT(eta);
	REPORT(LTM);
	REPORT(obs_ct);
	REPORT(pred_ct);
	REPORT(obs_ct_dis);
	REPORT(pred_ct_dis);
	REPORT(cpue_sig);
	REPORT(obs_it);
	REPORT(rwt_it);
	REPORT(pred_it);
	REPORT(n_lf_rows);
	REPORT(obs_lf);
	REPORT(pred_lf);
	REPORT(lf_data);
}

void model_parameters::set_runtime(void)
{
  dvector temp1("{500,500,2000,25000,25000}");
  maximum_function_evaluations.allocate(temp1.indexmin(),temp1.indexmax());
  maximum_function_evaluations=temp1;
  dvector temp("{0.0001,0.0001,1.e-4,1.e-5,1.e-5}");
  convergence_criteria.allocate(temp.indexmin(),temp.indexmax());
  convergence_criteria=temp;
}

void model_parameters::final_calcs()
{
	time(&finish);
	elapsed_time=difftime(finish,start);
	hour=long(elapsed_time)/3600;
	minute=long(elapsed_time)%3600/60;
	second=(long(elapsed_time)%3600)%60;
	cout<<endl<<endl<<"*******************************************"<<endl;
	cout<<"--Start time: "<<ctime(&start)<<endl;
	cout<<"--Finish time: "<<ctime(&finish)<<endl;
	cout<<"--Runtime: ";
	cout<<hour<<" hours, "<<minute<<" minutes, "<<second<<" seconds"<<endl;
	cout<<"*******************************************"<<endl;
}

void model_parameters::simulation_model(void)
{
	/*
	This is a simulation model for over-writing fake data for simulation
	purposes. The true parameter values are those that are specified in 
	the control file and the initial values.
	*/
	random_number_generator rng(rseed);
	dvector rt_dev(syr,nyr);
	rt_dev.fill_randn(rng);
	rt_dev*=0.6;
	initialize_parameters();
	cout<<"True parameters \n"<<theta<<endl;
	log_rt_dev = rt_dev;
	calc_recruitment();
	cout<<setprecision(3)<<"Recruitment\n"<<rt<<endl;
	calc_ltm();
	cout<<"Length transition\n"<<LTM<<endl;
	calc_selectivity();
	calc_mortality();
	cout<<"Fishing mortality\n"<<F<<endl;
	//initialize numbers at age based on log_rbar
	N(syr) = mfexp( log_rbar ) * x_rec;
	for(int i=1;i<=50;i++)
	{
		N(syr) = N(syr)*exp(-m)*LTM + mfexp( log_rbar ) * x_rec;
	}
	log_init_n = mean(log(N(syr)));
	log_init_n_dev = log(N(syr))-log_init_n;
	cout<<"Initial numbers at length\n"<<N(syr)<<endl;
	population_dynamics();
	cout<<"Numbers at length\n"<<N<<endl;
	catch_observations();
	obs_ct = value(pred_ct);
	cout<<"Predicted catch\n"<<pred_ct<<endl;
	catch_at_length();
	obs_lf = value(pred_lf);
	cout<<"Predicted length\n"<<pred_lf<<endl;
	calc_relative_abundance();
	obs_it = value(pred_it);
	cout<<"END OF SIMULATION MODEL"<<endl;
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
	strCheckFile.open("Check.Out");
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

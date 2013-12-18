	
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
	\def echoinput(object)
	Prints name and value of \a object on ADMB echoinput %ofstream file.
	*/
	#define echo(object) echoinput << #object "\n" << object << endl;
	// Open output files using ofstream
	ofstream echoinput("echoinput.gm");
	// Define some adstring variables for use in output files
	adstring version;
	adstring version_short;
	
#include <admodel.h>
#include <contrib.h>

  extern "C"  {
    void ad_boundf(int i);
  }
#include <gmacs.htp>

model_data::model_data(int argc,char * argv[]) : ad_comm(argc,argv)
{
version+="Gmacs_V1.00_2013/11/27_by_Athol_Whitten_(UW)_using_ADMB_11.1";
version_short+="Gmacs V1.00";
 echo(version)
 ad_comm::change_datafile_name("starter.gm"); 
 cout<<" Reading information from starter.gm"<<endl;
  data_file.allocate("data_file");
  control_file.allocate("control_file");
  size_trans_file.allocate("size_trans_file");
 echo(data_file);
 echo(control_file);
  verbose.allocate("verbose");
  turn_off_phase.allocate("turn_off_phase");
 ad_comm::change_datafile_name(data_file);
 cout<<" TOP OF DATA_SECTION "<<endl;
  syr.allocate("syr");
  nyr.allocate("nyr");
  dt.allocate("dt");
  ngear.allocate("ngear");
  nbin.allocate("nbin");
  xbin.allocate(1,nbin,"xbin");
 nr = int((nyr-syr+1)/dt);
 nx = nbin;
  xmid.allocate(1,nbin);
 xmid = xbin + 0.5*(xbin(2)-xbin(1));
  dim_array.allocate(1,ngear,1,2,"dim_array");
  irow.allocate(1,ngear);
  ncol.allocate(1,ngear);
  jcol.allocate(1,ngear);
		irow = column(dim_array,1);
		ncol = column(dim_array,2);
		jcol = ncol - 1;
  fi_count.allocate(1,ngear);
  effort.allocate(1,ngear,1,irow,"effort");
  mean_effort.allocate(1,ngear);
		/* Calculate mean effort for each gear, ignore 0*/
		/* number of capture probability deviates fi_count(k) */
		int i,k,n;
		fi_count.initialize();
		for(k=1;k<=ngear;k++)
		{
			n=0;
			for(i=1;i<=irow(k);i++)
			{
				if(effort(k,i)>0)
				{
					mean_effort(k) += effort(k,i);
					n++;
				}
			}
			fi_count(k)     = n;
			mean_effort(k) /= n;
		}
  i_C.allocate(1,ngear,1,irow,1,ncol,"i_C");
  i_M.allocate(1,ngear,1,irow,1,ncol,"i_M");
  i_R.allocate(1,ngear,1,irow,1,ncol,"i_R");
  C.allocate(1,ngear,1,irow,1,jcol);
  M.allocate(1,ngear,1,irow,1,jcol);
  R.allocate(1,ngear,1,irow,1,jcol);
  eof.allocate("eof");
 if(eof!=999){cout<<" Error reading data\n eof = "<<eof<<endl; exit(1);}
 cout<<" - END OF READING DATA"<<endl;
  ct.allocate(1,ngear,1,irow);
		for(k=1;k<=ngear;k++)
		{
			for(i=1;i<=irow(k);i++)
			{
				C(k)(i) = i_C(k)(i)(2,ncol(k)).shift(1);
				M(k)(i) = i_M(k)(i)(2,ncol(k)).shift(1);
				R(k)(i) = i_R(k)(i)(2,ncol(k)).shift(1);
				ct(k,i) = sum( C(k)(i) );
			}
		}
 ad_comm::change_datafile_name(size_trans_file);
  nj.allocate("nj");
  syr_L.allocate("syr_L");
  nyr_L.allocate("nyr_L");
  jbin.allocate(1,nj,"jbin");
  L.allocate(syr_L,nyr_L,1,nj-1,1,nj-1,"L");
  eof2.allocate("eof2");
 if(eof2!=999){cout<<"Error reading Size Transitions "<<eof2<<endl; ad_exit(1);}
 ad_comm::change_datafile_name(control_file);
  npar.allocate("npar");
  theta_control.allocate(1,npar,1,7,"theta_control");
  trans_theta_control.allocate(1,7,1,npar);
  theta_ival.allocate(1,npar);
  theta_lbnd.allocate(1,npar);
  theta_ubnd.allocate(1,npar);
  theta_phz.allocate(1,npar);
  theta_prior.allocate(1,npar);
		trans_theta_control = trans(theta_control);
		theta_ival = trans_theta_control(1);
		theta_lbnd = trans_theta_control(2);
		theta_ubnd = trans_theta_control(3);
		theta_phz  = ivector(trans_theta_control(4));
		theta_prior = ivector(trans_theta_control(5));
  sel_type.allocate(1,ngear,"sel_type");
  sel_phz.allocate(1,ngear,"sel_phz");
  lx_ival.allocate(1,ngear,"lx_ival");
  gx_ival.allocate(1,ngear,"gx_ival");
  x_nodes.allocate(1,ngear,"x_nodes");
  sel_pen1.allocate(1,ngear,"sel_pen1");
  sel_pen2.allocate(1,ngear,"sel_pen2");
  isel_npar.allocate(1,ngear);
		/* Determine the number of selectivity parameters to estimate */
		for(k=1;k<=ngear;k++)
		{
			switch(sel_type(k))
			{
				case 1:  // logistic
					isel_npar(k) = 2;
				break;
				case 2:  // eplogis
					isel_npar(k) = 3;
				break;
				case 3:  // linapprox
					isel_npar(k) = x_nodes(k);
				break;
			}
		}
  nflags.allocate("nflags");
  flag.allocate(1,nflags,"flag");
  min_tag_j.allocate(1,ngear,1,irow);
		int j;
		for(k=1;k<=ngear;k++)
		{
			for(i=1;i<=irow(k);i++)
			{
				for(j=1;j<=jcol(k);j++)
				{
					if( M(k)(i,j)>0 || xbin(j)>flag(1) )
					//if( xbin(j)>flag(1) )
					{
						min_tag_j(k,i) = j;
						break;
					}
				}	
			}
		}
		SimFlag = 0;
		rseed   = 1;
		int on,opt;
		//the following line checks for the "-SimFlag" command line option
		//if it exists the if statement retreives the random number seed
		//that is required for the simulation model
		if((on=option_match(ad_comm::argc,ad_comm::argv,"-sim",opt))>-1)
		{
			SimFlag = 1;
			rseed   = atoi(ad_comm::argv[on+1]);
			if(SimFlag) cout<<"In Simulation Mode\n";
		}
		
  true_Nt.allocate(syr,nyr);
  true_Rt.allocate(syr,nyr);
  true_Tt.allocate(syr,nyr);
  true_fi.allocate(1,ngear,1,irow);
 cout<< " END OF DATA_SECTION \n"<<endl;
  active_parm.allocate(1,npar);
 dummy_datum=1.;
 if(turn_off_phase<=0) {dummy_phase=0;} else {dummy_phase=-6;}
  		cout<< " Adjust phases \n"<<endl;
  		max_phase=1;
  		active_count=0;
  		active_parm(1,npar)=0;
  		par_count=0;
  
		for(i=1;i<=npar;i++)
		{ 
		  	par_count++;
		  	if(theta_phz(i) > turn_off_phase) theta_phz(i)=-1;
		  	if(theta_phz(i) > max_phase) max_phase=theta_phz(i);
		  	if(theta_phz(i) >= 0)
		  	{
		  	  active_count++; active_parm(active_count)=par_count;
		  	}
		}
		active_parms=active_count;
cout<< "Number of active parameters is "<<active_parms<<endl;
cout<< "Maximum phase for estimation is "<<max_phase<<endl;
}

model_parameters::model_parameters(int sz,int argc,char * argv[]) : 
 model_data(argc,argv) , function_minimizer(sz)
{
  initializationfunction();
  theta.allocate(1,npar,theta_lbnd,theta_ubnd,theta_phz,"theta");
  log_ddot_r.allocate("log_ddot_r");
  #ifndef NO_AD_INITIALIZE
  log_ddot_r.initialize();
  #endif
  log_bar_r.allocate("log_bar_r");
  #ifndef NO_AD_INITIALIZE
  log_bar_r.initialize();
  #endif
  m_infty.allocate("m_infty");
  #ifndef NO_AD_INITIALIZE
  m_infty.initialize();
  #endif
  l_infty.allocate("l_infty");
  #ifndef NO_AD_INITIALIZE
  l_infty.initialize();
  #endif
  vbk.allocate("vbk");
  #ifndef NO_AD_INITIALIZE
  vbk.initialize();
  #endif
  beta.allocate("beta");
  #ifndef NO_AD_INITIALIZE
  beta.initialize();
  #endif
  mu_r.allocate("mu_r");
  #ifndef NO_AD_INITIALIZE
  mu_r.initialize();
  #endif
  cv_r.allocate("cv_r");
  #ifndef NO_AD_INITIALIZE
  cv_r.initialize();
  #endif
  log_bar_f.allocate(1,ngear,-2,"log_bar_f");
  log_tau.allocate(1,ngear,-5,"log_tau");
  sel_par.allocate(1,ngear,1,isel_npar,-5.,5.,sel_phz,"sel_par");
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
  ddot_r_devs.allocate(1,nx,-15,15,-2,"ddot_r_devs");
  bar_r_devs.allocate(syr+1,nyr,-15,15,-2,"bar_r_devs");
 int phz;
 if(flag(4)==1) phz=3; else phz=-3;
  l_infty_devs.allocate(syr,nyr-1,-5,5,phz,"l_infty_devs");
  bar_f_devs.allocate(1,ngear,1,fi_count,-5.0,5.0,-2,"bar_f_devs");
  sd_l_infty.allocate("sd_l_infty");
  f.allocate("f");
  prior_function_value.allocate("prior_function_value");
  likelihood_function_value.allocate("likelihood_function_value");
  m_linf.allocate("m_linf");
  #ifndef NO_AD_INITIALIZE
  m_linf.initialize();
  #endif
  fpen.allocate("fpen");
  #ifndef NO_AD_INITIALIZE
  fpen.initialize();
  #endif
  tau.allocate(1,ngear,"tau");
  #ifndef NO_AD_INITIALIZE
    tau.initialize();
  #endif
  qk.allocate(1,ngear,"qk");
  #ifndef NO_AD_INITIALIZE
    qk.initialize();
  #endif
  mx.allocate(1,nx,"mx");
  #ifndef NO_AD_INITIALIZE
    mx.initialize();
  #endif
  rx.allocate(1,nx,"rx");
  #ifndef NO_AD_INITIALIZE
    rx.initialize();
  #endif
  log_rt.allocate(syr+1,nyr,"log_rt");
  #ifndef NO_AD_INITIALIZE
    log_rt.initialize();
  #endif
  fi.allocate(1,ngear,1,irow,"fi");
  #ifndef NO_AD_INITIALIZE
    fi.initialize();
  #endif
  sx.allocate(1,ngear,1,jcol,"sx");
  #ifndef NO_AD_INITIALIZE
    sx.initialize();
  #endif
  N.allocate(syr,nyr,1,nx,"N");
  #ifndef NO_AD_INITIALIZE
    N.initialize();
  #endif
  T.allocate(syr,nyr,1,nx,"T");
  #ifndef NO_AD_INITIALIZE
    T.initialize();
  #endif
  A.allocate(1,nx,1,nx,"A");
  #ifndef NO_AD_INITIALIZE
    A.initialize();
  #endif
  hat_ct.allocate(1,ngear,1,irow,"hat_ct");
  #ifndef NO_AD_INITIALIZE
    hat_ct.initialize();
  #endif
  delta.allocate(1,ngear,1,irow,"delta");
  #ifndef NO_AD_INITIALIZE
    delta.initialize();
  #endif
  Chat.allocate(1,ngear,1,irow,1,jcol,"Chat");
  #ifndef NO_AD_INITIALIZE
    Chat.initialize();
  #endif
  Mhat.allocate(1,ngear,1,irow,1,jcol,"Mhat");
  #ifndef NO_AD_INITIALIZE
    Mhat.initialize();
  #endif
  Rhat.allocate(1,ngear,1,irow,1,jcol,"Rhat");
  #ifndef NO_AD_INITIALIZE
    Rhat.initialize();
  #endif
  iP.allocate(syr,nyr,1,nx,1,nx,"iP");
  #ifndef NO_AD_INITIALIZE
    iP.initialize();
  #endif
  dummy_parm.allocate(0,2,dummy_phase,"dummy_parm");
}

void model_parameters::initializationfunction(void)
{
  theta.set_initial_value(theta_ival);
  log_bar_f.set_initial_value(-3.5);
  log_tau.set_initial_value(1.1);
}

void model_parameters::preliminary_calculations(void)
{

#if defined(USE_ADPVM)

  admaster_slave_variable_interface(*this);

#endif
	if(SimFlag)
	{
		cout<<"******************************"<<endl;
		cout<<"**                          **"<<endl;
		cout<<"** Running Simulation Model **"<<endl;
		cout<<"** Random seed = "<<rseed<<"        **"<<endl;
		cout<<"**                          **"<<endl;
		cout<<"******************************"<<endl;
		runSimulationModel(rseed);
	}
}

void model_parameters::userfunction(void)
{
  f =0.0;
	if( verbose ) cout<<"\n TOP OF PROCEDURE_SECTION "<<endl;
	fpen.initialize();
	initParameters();  
	calcSurvivalAtLength(); 
	calcSizeTransitionMatrix(); 
	initializeModel();
	calcCaptureProbability();
	calcNumbersAtLength();
	calcSelectivityAtLength();
	calcObservations();
	calc_objective_function();
	sd_l_infty = l_infty;
	if( verbose ) cout<<"\n END OF PROCEDURE_SECTION "<<endl;
}

void model_parameters::runSimulationModel(const int& seed)
{
  {
	int i,j,k,im;
	random_number_generator rng(seed);
	dvector tmp_ddot_r_devs = value(ddot_r_devs);
	dvector tmp_bar_r_devs  = value(bar_r_devs);
	dmatrix tmp_bar_f_devs  = value(bar_f_devs);
	tmp_ddot_r_devs.fill_randn(rng);
	tmp_bar_r_devs.fill_randn(rng);
	tmp_bar_f_devs.fill_randn(rng);
	double sig_r = flag(5);
	ddot_r_devs = sig_r*tmp_ddot_r_devs;
	bar_r_devs  = sig_r*tmp_bar_r_devs;
	/* Capture probabilities */
	double sig_f = flag(6);
	for(k=1;k<=ngear;k++)
	{
		bar_f_devs(k) = sig_f*tmp_bar_f_devs(k);
	}
	initParameters();
	calcSurvivalAtLength();
	calcSizeTransitionMatrix();
	initializeModel();
	calcCaptureProbability();
	calcNumbersAtLength();
	calcSelectivityAtLength();
	calcObservations();
	/* Overwrite observations and draw from multinomial distribution */
	C=value(Chat);
	M=value(Mhat);
	R=value(Rhat);
	for(k=1;k<=ngear;k++)
	{
		for(i=1;i<=irow(k);i++)
		{
			if(effort(k,i)>0)
			{
				for(j=1;j<=nx;j++)
				{
					if(flag(6))
					{
						C(k)(i)(j) = randnegbinomial(1.e-5+C(k)(i)(j),2.0,rng);
						M(k)(i)(j) = randnegbinomial(1.e-5+M(k)(i)(j),2.0,rng);
						R(k)(i)(j) = randnegbinomial(1.e-5+R(k)(i)(j),2.0,rng);
					}
				}
			}
			i_C(k)(i)(2,ncol(k)) = C(k)(i)(1,nx).shift(2);
			i_M(k)(i)(2,ncol(k)) = M(k)(i)(1,nx).shift(2);
			i_R(k)(i)(2,ncol(k)) = R(k)(i)(1,nx).shift(2);
		}		
	}
	/*Save true data*/
	true_Nt.initialize();
	true_Tt.initialize();
	true_Rt.initialize();
	true_fi = value(fi);
	true_Nt = value(rowsum(N));
	true_Tt = value(rowsum(T));
	for(i=syr;i<=nyr;i++)
	{
		if(i==syr) true_Rt(i) = value(mfexp(log_ddot_r+ddot_r_devs(nx)));
		else       true_Rt(i) = value(mfexp(log_rt(i)));
	}
  }
}

void model_parameters::initParameters(void)
{
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
}

void model_parameters::calcSizeTransitionMatrix(void)
{
  {
	/*
	This function calls the necessary routines to compute the Size Transition Matrix (P)
	*/
	int t,im;
	dvariable linf;
	switch(int(flag(4)))
	{
		case 0:
			A = calcLTM(xmid,l_infty,vbk,beta);
			for(t=syr;t<nyr;t++)
			{
				iP(t) = A;
			}
		break;
		//
		case 1:
			if(!active(l_infty_devs))
			{
				A = calcLTM(xmid,l_infty,vbk,beta);
			}
			else
			for(t=syr;t<nyr;t++)
			{
				if(active(l_infty_devs))
				{
					linf = l_infty*exp(l_infty_devs(t));
					A = calcLTM(xmid,linf,vbk,beta);
				}
				iP(t) = A;
			}
		break;
		//
		case 2: // use externally estimated Size transition matrices 
			for(t=syr;t<nyr;t++)
			{
				im = t;
				if(t < syr_L) im = syr_L;
				if(t > nyr_L) im = nyr_L;
				iP(t) = L(im);
			}
		break;
	}
  }
}

void model_parameters::initializeModel(void)
{
  {
	int i,ii,k,ik;
	//Set up the initial states.
	N.initialize();
	T.initialize();
	/* Initialize numbers at length at the first time step. */
	dvar_vector init_r(1,nx);
	dvar_matrix phi_X(1,nx,1,nx);
	dvariable a=1/(cv_r*cv_r);  //a=1/cv^2
	dvariable b=mu_r/a;		  //b=mu/a
	rx  = dgamma(xmid,a,b);
	rx /= sum(rx);
	/* Calculate per-recruit survivorship at length */
	phi_X(1) = rx;
	ii = 0;
	for(i=2;i<=nx;i++)
	{
		phi_X(i) = elem_prod(phi_X(i-1),mfexp(-mx)) * iP(syr);
		if( i==nx )
		{
			phi_X(i) = phi_X(i) + elem_div(phi_X(i),1.-mfexp(-mx));
		}
	}
	/* Initial numbers at length */
	init_r = mfexp(log_ddot_r + ddot_r_devs);
	N(syr)   = init_r * phi_X;
	/* Annual recruitment */
	log_rt = log_bar_r + bar_r_devs;
  }
}

void model_parameters::calcCaptureProbability(void)
{
  {
	/* Catchability */
	qk         = elem_div(mfexp(log_bar_f),mean_effort);
	/* Capture probability at each time step. */
	int i,k;
	ivector ik(1,ngear);
	ik = 1;
	fi.initialize();
	for(k=1;k<=ngear;k++)
	{
		for(i=1;i<=irow(k);i++)
		{
			if( effort(k,i)>0 )
			{
				fi(k,i) = qk(k)*effort(k,i)*mfexp(bar_f_devs(k)(ik(k)++));
			}
		}
	}
  }
}

void model_parameters::calcSurvivalAtLength(void)
{
  {
	/*
	This function calculates the length-specific survival rate
	based on the Lorenzen function, where survival increases
	with increasing length.
	mortality rate at length x  mx=m.linf*linf/xbin
	note that m_linf is an annual rate.
	*/
	mx = m_infty * l_infty/xmid;
  }
}

void model_parameters::calcSelectivityAtLength(void)
{
  {
	/*
	This function calculates the length-specific selectivity.
	The parametric option is a logistic curve (plogis(x,lx,gx))
	*/
	int k;
	double dx;
	dvariable p1,p2,p3;
	sx.initialize();
	Selex cSelex;
	dmatrix xi(1,ngear,1,x_nodes);
	dvar_matrix yi(1,ngear,1,x_nodes);
	/*
	dvariable gamma = 0.1;
	dvariable x1 = 30.0;
	dvariable x2 = 49.0;
	cout<<cSelex.eplogis(xmid,x1,x2,gamma)<<endl;
	dvector x = ("{5, 10, 15, 20, 25, 30, 35, 40, 45, 50}");
	dvar_vector y = ("{0.03, 0.16, 0.50, 0.84, 0.97, 0.99, 1.00, 1.00, 1.00, 1.00}");
	cout<<"Linear interpolation"<<endl;	
	cout<<cSelex.linapprox(x,y,xmid)<<endl;
	*/
	for(k=1;k<=ngear;k++)
	{
		switch(sel_type(k))
		{
			case 1:  //logistic
				p1 = mfexp(sel_par(k,1));
				p2 = mfexp(sel_par(k,2));
				sx(k) = log( cSelex.logistic(xmid,p1,p2) );
			break;
			case 2: //eplogis
				p1 = mfexp(sel_par(k,1));
				p2 = mfexp(sel_par(k,2));
				p3 = mfexp(sel_par(k,3))/(1.+mfexp(sel_par(k,3)));
				sx(k) = log( cSelex.eplogis(xmid,p1,p2,p3) );
			break;
			case 3: //linapprox
				dx = (double(nbin)-1.)/(double(x_nodes(k)-1.));
				xi(k).fill_seqadd( min(xmid),dx );
				yi(k)= sel_par(k);
				sx(k) = cSelex.linapprox(xi(k),yi(k),xmid);
			break;
		}
		sx(k) = mfexp( sx(k) - log( mean( mfexp(sx(k))+1.e-30 ) ) );
	}
  }
}

void model_parameters::calcNumbersAtLength(void)
{
  {
	/*	This function updates the numbers at length
		at the start of each year as a function of the 
		numbers at length times the survival rate * size transition
		and add new recuits-at-length.
	  	N_{t+1} = elem_prod(N_{t},mfexp(-mx*dt)) * P + rt*rx
	  	These are the total number of fish (tagged + untagged)
		at large in the population.  N is used in the observation
		models to determine number of captures and recaptures is
		based on T.
		The function also does the accounting for the predicted number
		of marked individuals at large (T).
		t = index for year
	*/
	int i,k,t;
	i = 0;
	dvariable rt;
	dvector mt(1,nx);
	for(t=syr;t<nyr;t++)
	{
		/* TOTAL NUMBERS AT LARGE */
		rt     = mfexp(log_rt(t+1));
		N(t+1) = elem_prod(N(t),mfexp(-mx)) * iP(t) + rt*rx;
		/* MARKED NUMBERS AT LARGE */
		i++;
		mt = 0;
		for(k=1;k<=ngear;k++)
		{
			mt += M(k)(i);
		}
		T(t+1) = elem_prod(T(t) + mt,mfexp(-mx)) * iP(t);
	}
	if( verbose==2 ) cout<<"Nt\n"<<rowsum(N)<<endl;
	if( verbose==2 ) cout<<"Tt\n"<<rowsum(T)<<endl;
  }
}

void model_parameters::calcObservations(void)
{
  {
	/*
		Calculate the predicted total catch-at-length (Chat)
		Calculate the predicted total recaptures-at-length (Rhat)
		Calculate the predicted total new markes released-at-length (Mhat)
		t   = index for year
		its = index for time step
		k   = index for gear
		TRYING A SIMPLE DISCRETE MODEL FOR OBSERVATIONS.
	*/
	int t,its,k,i,lb;
	Chat.initialize();
	Mhat.initialize();
	Rhat.initialize();
	dvar_vector Ntmp(1,nx);
	dvar_vector Ttmp(1,nx);
	dvar_vector Utmp(1,nx);
	dvar_vector Mtmp(1,nx);
	dvar_vector zx(1,nx);
	dvar_vector ox(1,nx);
	dvar_vector ux(1,nx);
	i=0;
	zx = mx*dt;
	ox = elem_div(1.0-mfexp(-zx),zx);
	for(t=syr;t<=nyr;t++)
	{
		Ntmp = N(t);
		Ttmp = T(t);
		Utmp = Ntmp-Ttmp;//posfun(Ntmp - Ttmp,0.01,fpen);
		Mtmp.initialize();
		i++;
		for(k=1;k<=ngear;k++)
		{
			if( effort(k,i)>0 )
			{
				ux           = 1.0 - mfexp(-fi(k,i)*sx(k));
				Chat(k)(i)   = elem_prod(ux,Ntmp);
				Mhat(k)(i)   = elem_prod(ux,Utmp);
				Rhat(k)(i)   = elem_prod(ux,Ttmp);
			}
			//if( effort(k,i)>0 )
			//{
			//	lb           = min_tag_j(k,i);
			//	ux           = 1.0 - mfexp(-fi(k,i)*sx(k));
			//	Chat(k)(i)   = elem_prod(ux,elem_prod(Ntmp,ox));
			//	Mhat(k)(i)(lb,nx)   = elem_prod(ux,elem_prod(Utmp,ox))(lb,nx);
			//	Rhat(k)(i)   = elem_prod(ux,elem_prod(Ttmp,ox));
			//	Mtmp(lb,nx) += Mhat(k)(i)(lb,nx);
			//}
		}
		/* Survive and grow tags-at-large and add new tags */
		//if( t < nyr )
		//{
		//	T(t+1) = elem_prod(T(t),mfexp(-mx*dt))*iP(t) + Mtmp;
		//}
	}
	if( verbose==2 ) cout<<"Tt\n"<<rowsum(T)<<endl;
  }
}

void model_parameters::calc_objective_function(void)
{
  {
	int i,j,k;
	/* PENALTIES TO ENSURE REGULAR SOLUTION */
	dvar_vector pvec(1,4);
	pvec.initialize();
	if(!last_phase())
	{
		pvec(1) = dnorm(first_difference(ddot_r_devs),0,0.2);
		pvec(1)+= norm2(ddot_r_devs);
		pvec(2) = dnorm(bar_r_devs,0,0.4);
		for(k=1;k<=ngear;k++)
		{
			dvariable mean_f = sum(fi(k))/fi_count(k);
			pvec(3) += dnorm(mean_f,0.1,0.01);
			pvec(4) += dnorm(bar_f_devs(k),0,1.0);
		}
	}
	else
	{
		pvec(1) = dnorm(first_difference(ddot_r_devs),0,0.4);
		pvec(1)+= norm2(ddot_r_devs);
		pvec(2) = dnorm(bar_r_devs,0,0.6);
		for(k=1;k<=ngear;k++)
		{
			dvariable mean_f = sum(fi(k))/fi_count(k);
			pvec(3) += dnorm(mean_f,0.1,2.5);
			pvec(4) += dnorm(bar_f_devs(k),0,1.0);
		}
		//pvec(3) = dnorm(log_bar_f,log(0.1108032),2.5);
	}
	if( verbose ) cout<<"Average fi = "<<mfexp(log_bar_f)<<endl;
	/* PENALTIES TO INSURE DEV VECTORS HAVE A MEAN O */
	dvar_vector dev_pen(1,ngear);
	for(k=1;k<=ngear;k++)
	{
		dvariable s = mean(bar_f_devs(k)); 
		dev_pen(k)  = 1.e7 * s*s;
	}
	/* LIKELIHOODS */
	/*
		fvec(1) = likelihood of the total catch-at-length.
		fvec(2) = likelihood of the total marks-at-length.
		fvec(3) = likelihood of the total recap-at-length.
	*/
	dvar_vector fvec(1,4);
	fvec.initialize();
	double tiny = 1.e-10;
	tau = mfexp(log_tau)+1.01;
	for(k=1;k<=ngear;k++)
	{
		for(i=1;i<=irow(k);i++)
		{
			if( effort(k,i)>0 )
			{
				for(j=1;j<=nx;j++)
				{
					if(active(log_tau))
					{
						fvec(1) -= log_negbinomial_density(C(k)(i)(j),Chat(k)(i)(j)+tiny,tau(k));
						fvec(2) -= log_negbinomial_density(M(k)(i)(j),Mhat(k)(i)(j)+tiny,tau(k));
						fvec(3) -= log_negbinomial_density(R(k)(i)(j),Rhat(k)(i)(j)+tiny,tau(k));
					} 
					else
					{
						fvec(1) += square(C(k)(i)(j)-Chat(k)(i)(j));
						fvec(2) += square(M(k)(i)(j)-Mhat(k)(i)(j));
						fvec(3) += square(R(k)(i)(j)-Rhat(k)(i)(j));
					}
				}
			}
		}
	}
	if(active(l_infty_devs))
	{
		fvec(4) = dnorm(l_infty_devs,0,0.2);
	}
	/*
	PRIORS for estimated model parameters from the control file.
	*/
	dvar_vector priors(1,npar);
	priors.initialize();
	dvariable ptmp; 
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
				lb=theta_lbnd(i);
				ub=theta_ubnd(i);
				ptmp=dbeta((theta(i)-lb)/(ub-lb),theta_control(i,6),theta_control(i,7));
				break;
			case 4:		//gamma distribution
				ptmp=dgamma(theta(i),theta_control(i,6),theta_control(i,7));
				break;
			default:	//uniform density
				ptmp=-log(1./(theta_control(i,3)-theta_control(i,2)));
				break;
			}
			priors(i)=ptmp;	
		}
	}
	/*
	PENALTIES FOR SELECTIVITY COEFFICIENTS
	*/
	dvar_vector sel_pen(1,ngear);
	sel_pen.initialize();
	for(k=1;k<=ngear;k++)
	{
		if( sel_type(k)==3 )
		{
			sel_pen(k) = sel_pen1(k)/nx * norm2(first_difference(first_difference(sx(k))));
			for(j=1;j<nx;j++)
			{
				if(sx(k,j+1)<sx(k,j))
					sel_pen(k) += sel_pen2(k) * square(sx(k,j+1)-sx(k,j));
			}
		}
	}
	if( verbose ) cout<<"Fvec\t"<<setprecision(4)<<fvec<<endl;
	if(fpen > 0) cout<<"Fpen = "<<fpen<<endl;
	f  = sum(fvec); 
	//f += sum(pvec); 
	//f += sum(priors); 
	//f += sum(dev_pen); 
	//f += sum(sel_pen); 
	f += 1.e5*fpen;
  }
}

dvar_matrix model_parameters::calcLTM(dvector& x, const dvariable &linf, const dvariable &k, const dvariable &beta)
{
  {
	/*This function computes the length transition matrix.*/
	/*
	- x is the mid points of the length interval vector.
	- cumd_gamma(x,a) is the same as Igamma(a,x) in R.
	- If length interval > linf, then assume now further growth.
	- Note the use of posfun to ensure differentiable.
	*/
	RETURN_ARRAYS_INCREMENT();
	int i,j;
	double dx;
	double bw = 0.5*(x(2)-x(1));
	int n = size_count(x);     //number of length intervals
	dvar_vector alpha(1,n);
	dvar_matrix P(1,n,1,n);
	P.initialize();
	//Growth increment
	dvar_vector dl(1,n);
	for(j=1;j<=n;j++)
	{
		dl(j) = log(mfexp( (linf-x(j))*(1.-mfexp(-k)) )+1.0);
	}
	alpha = dl/beta;
	/* Size transition probability */
	for(i=1;i<=n;i++)
	{
		dvar_vector t1(i,n);
		for(j=i;j<=n;j++)
		{
			dx = x(j)-x(i);
			P(i)(j) = cumd_gamma(dx+bw,alpha(i)) - cumd_gamma(dx-bw,alpha(i));
			//cout<<j<<" "<<x(i)<<" "<<x(j)<<" "<<P(i)(j)<<endl;
		}
		//P(i)(i,n-1) = first_difference(t1);
		P(i) /= sum(P(i));
	}
	RETURN_ARRAYS_DECREMENT();
	//cout<<P<<endl;
	return(P);
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
	ivector yr(syr,nyr);
	yr.fill_seqadd(syr,1);
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
	dvector Rt(syr,nyr);
	for(i=syr;i<=nyr;i++)
	{
		if(i==syr) Rt(i) = value(mfexp(log_ddot_r+ddot_r_devs(nx)));
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

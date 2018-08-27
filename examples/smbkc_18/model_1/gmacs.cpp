#ifdef DEBUG
  #ifndef __SUNPRO_C
    #include <cfenv>
    #include <cstdlib>
  #endif
#endif
	/**
	 * @file gmacs.cpp
	 * @authors Steve Martell, Jim Ianelli, D'Arcy Webber
	**/
	#include <admodel.h>
	#include <time.h>
	adstring like_names;
	adstring prior_names;
	//#include "./test/comm.h"
	//#include <contrib.h>
	#if defined __APPLE__ || defined __linux
	#include "./include/libgmacs.h"
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
	 * \def COUT(object)
	 * Prints object to screen during runtime.
	 * cout <<setw(6) << setprecision(3) << setfixed() << x << endl;
	**/
	#undef COUT
	#define COUT(object) cout << #object "\n" << setw(6) \
	 << setprecision(3) << setfixed() << object << endl;
	#undef MAXIT
	#undef TOL
	#define MAXIT 100
	#define TOL 1.0e-4
	/**
	\def MCout(object)
	Prints name and value of \a object on echoinput %ofstream file.
	*/
	#undef MCout
	#define MCout(object) mcout << #object << " " << object << endl;
	/**
	\def ECHO(object)
	Prints name and value of \a object on echoinput %ofstream file.
	*/
	#undef ECHO
	#define ECHO(object) echoinput << #object << "\n" << object << endl;
	/**
	\def WriteFileName(object)
	Prints name and value of \a object on control %ofstream file.
	*/
	#undef WriteFileName
	#define WriteFileName(object) ECHO(object); gmacs_files << "# " << #object << "\n" << object << endl;
	/**
	\def WriteCtl(object)
	Prints name and value of \a object on control %ofstream file.
	*/
	#undef WriteCtl
	#define WriteCtl(object) ECHO(object); gmacs_ctl << "# " << #object << "\n" << object << endl;
	/**
	\def WRITEDAT(object)
	Prints name and value of \a object on data %ofstream file.
	*/
	#undef WRITEDAT
	#define WRITEDAT(object) ECHO(object); gmacs_data << "# " << #object << "\n" << object << endl;
	// Open output files using ofstream
	// This one for easy reading all input to R
	ofstream mcout("mcout.rep");
	ofstream echoinput("checkfile.rep");
	// These ones for compatibility with ADMB (# comment included)
	ofstream gmacs_files("gmacs_files_in.dat");
	ofstream gmacs_data("gmacs_in.dat");
	ofstream gmacs_ctl("gmacs_in.ctl");
#include <admodel.h>
#include <contrib.h>

  extern "C"  {
    void ad_boundf(int i);
  }
#include <gdbprintlib.cpp>

#include <gmacs.htp>

model_data::model_data(int argc,char * argv[]) : ad_comm(argc,argv)
{
		simflag = 0;
		rseed = 0;
		int opt,on;
		/**
		 * @brief command line option for simulating data.
		**/
		if ( (on=option_match(ad_comm::argc,ad_comm::argv,"-sim",opt))>-1 )
		{
			simflag = 1;
			rseed = atoi(ad_comm::argv[on+1]);
		}
		if ( (on=option_match(ad_comm::argc,ad_comm::argv,"-i",opt))>-1 )
		{
			cout << "\n";
			cout << "  +----------------------------------------------------------+\n";
			cout << "  | CONTRIBUTIONS (code and intellectual)                    |\n";
			cout << "  +----------------------------------------------------------+\n";
			cout << "  | Name:                        Organization:               |\n";
			cout << "  | James Ianelli                NOAA-NMFS                   |\n";
			cout << "  | D'Arcy Webber                Quantifish                  |\n";
			cout << "  | Steven Martell               IPHC                        |\n";
			cout << "  | Jack Turnock                 NOAA-NMFS                   |\n";
			cout << "  | Jie Zheng                    ADF&G                       |\n";
			cout << "  | Hamachan Hamazaki            ADF&G                       |\n";
			cout << "  | Athol Whitten                University of Washington    |\n";
			cout << "  | André Punt                   University of Washington    |\n";
			cout << "  | Dave Fournier                Otter Research              |\n";
			cout << "  | John Levitt                  Mathemetician               |\n";
			cout << "  +----------------------------------------------------------+\n";
			cout << "\n";
			cout << "  +----------------------------------------------------------+\n";
			cout << "  | FINANCIAL SUPPORT                                        |\n";
			cout << "  +----------------------------------------------------------+\n";
			cout << "  | Financial support for this project was provided by the   |\n";
			cout << "  | National Marine Fisheries Service, the Bering Sea        |\n";
			cout << "  | Fisheries Research Foundation, ...                       |\n";
			cout << "  +----------------------------------------------------------+\n";
			cout << "\n";
			cout << "  +----------------------------------------------------------+\n";
			cout << "  | DOCUMENTATION                                            |\n";
			cout << "  +----------------------------------------------------------+\n";
			cout << "  | online api: http://seacode.github.io/gmacs/index.html    |\n";
			cout << "  +----------------------------------------------------------+\n";
			cout << "\n";
			exit(1);
		}
		// Command line option here to do retrospective analysis
		if ( (on=option_match(ad_comm::argc,ad_comm::argv, "-retro", opt))>-1 )
		{
			cout << "\n";
			cout << "  +----------------------------------------------------------+\n";
			cout << "  | Running retrospective model with " << ad_comm::argv[on+1] << " recent yrs removed |\n";
			cout << "  +----------------------------------------------------------+\n";
			cout << "  | YET TO BE IMPLEMENTED                                    |\n";
			cout << "  +----------------------------------------------------------+\n";
			exit(1);
		}
  datafile.allocate("datafile");
  controlfile.allocate("controlfile");
 ad_comm::change_datafile_name(datafile); WriteFileName(datafile); WriteFileName(controlfile);
 cout << "+----------------------+" << endl;
 cout << "| Reading data file    |" << endl;
 cout << "+----------------------+" << endl;
 cout << " * Model dimensions" << endl;
  syr.allocate("syr");
  nyr.allocate("nyr");
  pyr.allocate("pyr");
  nseason.allocate("nseason");
  nfleet.allocate("nfleet");
  nsex.allocate("nsex");
  nshell.allocate("nshell");
  nmature.allocate("nmature");
  nclass.allocate("nclass");
  season_recruitment.allocate("season_recruitment");
  season_growth.allocate("season_growth");
  season_ssb.allocate("season_ssb");
  season_N.allocate("season_N");
		n_grp = nsex * nshell * nmature;
		nproj = pyr - nyr;
		nlikes = 5; // catch, cpue, size comps, recruits, molt increments
		WRITEDAT(syr); WRITEDAT(nyr);  WRITEDAT(pyr);
		WRITEDAT(nseason);
		WRITEDAT(nfleet); WRITEDAT(nsex); WRITEDAT(nshell); WRITEDAT(nmature); WRITEDAT(nclass);
		WRITEDAT(season_recruitment); WRITEDAT(season_growth); 
		WRITEDAT(season_ssb); WRITEDAT(season_N); 
  isex.allocate(1,n_grp);
  ishell.allocate(1,n_grp);
  imature.allocate(1,n_grp);
  pntr_hmo.allocate(1,nsex,1,nmature,1,nshell);
		int h,m,o;
		int hmo=1;
		for ( h = 1; h <= nsex; h++ )
		{
			for ( m = 1; m <= nmature; m++ )
			{
				for ( o = 1; o <= nshell; o++ )
				{
					isex(hmo) = h;
					ishell(hmo) = o;
					imature(hmo) = m;
					pntr_hmo(h,m,o) = hmo++;
				}
			}
		}
  size_breaks.allocate(1,nclass+1,"size_breaks");
  mid_points.allocate(1,nclass);
 cout << " * Allometry" << endl;
  lw_type.allocate("lw_type");
		lw_dim = nsex;
		if ( lw_type == 3 )
		{
			lw_dim = nsex * (nyr - syr + 1);
		}
  lw_alfa.allocate(1,nsex,"lw_alfa");
  lw_beta.allocate(1,nsex,"lw_beta");
  mean_wt_in.allocate(1,lw_dim,1,nclass,"mean_wt_in");
  mean_wt.allocate(1,nsex,syr,nyr,1,nclass);
		mid_points = size_breaks(1,nclass) + 0.5 * first_difference(size_breaks);
		switch ( lw_type )
		{
			// allometry
			case 1:
				for ( int h = 1; h <= nsex; h++ )
				{
					for ( int i = syr; i <= nyr; i++ )
					{
						mean_wt(h,i) = lw_alfa(h) * pow(mid_points, lw_beta(h));
					}
				}
			break;
			// vector by sex
			case 2:
				for ( int h = 1; h <= nsex; h++ )
				{
					for ( int i = syr; i <= nyr; i++ )
					{
						for ( int l = 1; l <= nclass; l++ )
						{
							mean_wt(h,i,l) = mean_wt_in(h,l);
						}
					}
				}
			break;
			// matrix by sex
			case 3:
				for ( int h = 1; h <= nsex; h++ )
				{
					for ( int i = syr; i <= nyr; i++ )
					{
						for ( int l = 1; l <= nclass; l++ )
						{
							mean_wt(h,i,l) = mean_wt_in(i-syr+1,l);
						}
					}
				}
			break;
		}
		WRITEDAT(size_breaks); WRITEDAT(lw_type); WRITEDAT(lw_alfa); WRITEDAT(lw_beta); WRITEDAT(mean_wt_in); ECHO(mean_wt);
 cout << " * Maturity and natural mortality" << endl;
  fecundity.allocate(1,nclass,"fecundity");
  maturity.allocate(1,nsex,1,nclass,"maturity");
  m_prop_type.allocate("m_prop_type");
	WRITEDAT(fecundity);
	WRITEDAT(maturity);
	WRITEDAT(m_prop_type);
		m_dim = 1;
		if ( m_prop_type == 2 )
		{
			m_dim = nyr - syr + 1;
		}
  m_prop_in.allocate(1,m_dim,1,nseason,"m_prop_in");
	WRITEDAT(m_prop_in);
  m_prop.allocate(syr,nyr,1,nseason);
		switch ( m_prop_type )
		{
			// vector by season
			case 1:
				for ( int i = syr; i <= nyr; i++ )
				{
					for ( int j = 1; j <= nseason; j++ )
					{
						m_prop(i,j) = m_prop_in(1,j);
					}
				}
			break;
			// matrix by year and season
			case 2:
				for ( int i = syr; i <= nyr; i++ )
				{
					for ( int j = 1; j <= nseason; j++ )
					{
						m_prop(i,j) = m_prop_in(i-syr+1,j);
					}
				}
			break;
		}
		for ( int i = syr; i <= nyr; i++ )
		{
			if ( sum(m_prop(i)) > 1.0000001 || sum(m_prop(i)) < 0.999999 )
			{
				cout << "Error: the proportion of natural mortality applied each season (in the .dat file) does not sum to 1! It sums to " << sum(m_prop(i)) << endl;
				exit(1);
			}
		}
  name_read_flt.allocate("name_read_flt");
  name_read_srv.allocate("name_read_srv");
 WRITEDAT(name_read_flt);
 WRITEDAT(name_read_srv); 
 cout << " * Catch data" << endl;
  nCatchDF.allocate("nCatchDF");
  nCatchRows.allocate(1,nCatchDF,"nCatchRows");
  dCatchData.allocate(1,nCatchDF,1,nCatchRows,1,11,"dCatchData");
 WRITEDAT(nCatchDF); WRITEDAT(nCatchRows); WRITEDAT(dCatchData); 
  obs_catch.allocate(1,nCatchDF,1,nCatchRows);
  obs_effort.allocate(1,nCatchDF,1,nCatchRows);
  dCatchData_out.allocate(1,nCatchDF,syr,nyr-1,1,11);
  obs_catch_out.allocate(1,nCatchDF,syr,nyr-1);
  catch_cv.allocate(1,nCatchDF,1,nCatchRows);
  catch_dm.allocate(1,nCatchDF,1,nCatchRows);
  catch_mult.allocate(1,nCatchDF,1,nCatchRows);
		for ( int k = 1; k <= nCatchDF; k++ )
		{
			catch_mult(k) = column(dCatchData(k),9);
			obs_catch(k)  = column(dCatchData(k),5);
			catch_cv(k)   = column(dCatchData(k),6);
			catch_dm(k)   = column(dCatchData(k),11);
			obs_catch(k)  = elem_prod(obs_catch(k), catch_mult(k)); // rescale catch by multiplier
			obs_effort(k) = column(dCatchData(k),10);
			// If the catch is zero then add a small constant
   /*
			for ( int i = 1; i <= nCatchRows(k); i++ )
			{
				if ( obs_catch(k,i) < 1e-4 )
				{
					obs_catch(k,i) = 1e-4;
				}
			}
   */
		}
		ECHO(obs_catch); ECHO(catch_cv);
  nFparams.allocate(1,nfleet);
  nYparams.allocate(1,nfleet);
  foff_phz.allocate(1,nfleet);
  fhit.allocate(syr,nyr,1,nseason,1,nfleet);
  yhit.allocate(syr,nyr,1,nseason,1,nfleet);
  dmr.allocate(syr,nyr,1,nfleet);
		nFparams.initialize();
		nYparams.initialize();
		fhit.initialize();
		yhit.initialize();
		dmr.initialize();
		foff_phz = -1;
		for ( int k = 1; k <= nCatchDF; k++ )
		{
			for ( int i = 1; i <= nCatchRows(k); i++ )
			{
				int y = dCatchData(k)(i,1); // year
				int j = dCatchData(k)(i,2); // season
				int g = dCatchData(k)(i,3); // fleet
				int h = dCatchData(k)(i,4); // sex
				if ( !fhit(y,j,g) )
				{
					fhit(y,j,g) ++;
					nFparams(g) ++;
					dmr(y,g) = catch_dm(k)(i);
				}
				if ( !yhit(y,j,g) && h == 2 )
				{
					yhit(y,j,g) ++;
					nYparams(g) ++;
					foff_phz(g) = 1;
					dmr(y,g) = catch_dm(k)(i);
				}
			}
		}
		ECHO(nFparams); ECHO(nYparams); ECHO(fhit); ECHO(yhit); ECHO(dmr);
		// Create the dCatchData_out object for output and plotting in R, this object simply fills in the years that don't have data with zero catch
		dCatchData_out.initialize();
		obs_catch_out.initialize();
		for ( int k = 1; k <= nCatchDF; k++ )
		{
			for ( int i = syr; i <= nyr-1; i++ )
			{
				dCatchData_out(k,i,1) = i; // Year
				int j = 1;
				for ( int ii = 1; ii <= nCatchRows(k); ii++ )
				{
					if ( i == dCatchData(k,ii,1) ) // year index
					{
						j = ii;
						obs_catch_out(k,i)    = dCatchData(k,ii,5); // Obs
						dCatchData_out(k,i,5) = dCatchData(k,ii,5); // Obs
						dCatchData_out(k,i,6) = dCatchData(k,ii,6); // CV
						dCatchData_out(k,i,9)  = dCatchData(k,j,9); // Mult
						dCatchData_out(k,i,10) = dCatchData(k,j,10); // Effort
						dCatchData_out(k,i,11) = dCatchData(k,j,11); // Discard mortality
					}
				}
				// Replicate these variables
				dCatchData_out(k,i,2) = dCatchData(k,j,2); // Season
				dCatchData_out(k,i,3) = dCatchData(k,j,3); // Fleet
				dCatchData_out(k,i,4) = dCatchData(k,j,4); // Sex
				dCatchData_out(k,i,7) = dCatchData(k,j,7); // Type
				dCatchData_out(k,i,8) = dCatchData(k,j,8); // Units
			}
		}
 cout << " * Abundance data" << endl;
  nSurveys.allocate("nSurveys");
  nSurveyRows.allocate(1,nSurveys,"nSurveyRows");
  dSurveyData.allocate(1,nSurveys,1,nSurveyRows,1,7,"dSurveyData");
  obs_cpue.allocate(1,nSurveys,1,nSurveyRows);
  cpue_cv.allocate(1,nSurveys,1,nSurveyRows);
  cpue_sd.allocate(1,nSurveys,1,nSurveyRows);
  cpue_cv_add.allocate(1,nSurveys,1,nSurveyRows);
		for ( int k = 1; k <= nSurveys; k++ )
		{
			obs_cpue(k) = column(dSurveyData(k),5);
			cpue_cv(k)  = column(dSurveyData(k),6);
			cpue_sd(k)  = sqrt(log(1.0 + square(cpue_cv(k))));
		}
		WRITEDAT(nSurveys); WRITEDAT(nSurveyRows); WRITEDAT(dSurveyData);
		ECHO(obs_cpue); ECHO(cpue_cv); ECHO(cpue_sd);
 cout << " * Size composition data" << endl;
  nSizeComps_in.allocate("nSizeComps_in");
  nSizeCompRows_in.allocate(1,nSizeComps_in,"nSizeCompRows_in");
  nSizeCompCols_in.allocate(1,nSizeComps_in,"nSizeCompCols_in");
  d3_SizeComps_in.allocate(1,nSizeComps_in,1,nSizeCompRows_in,-7,nSizeCompCols_in,"d3_SizeComps_in");
  d3_obs_size_comps_in.allocate(1,nSizeComps_in,1,nSizeCompRows_in,1,nSizeCompCols_in);
  size_comp_sample_size_in.allocate(1,nSizeComps_in,1,nSizeCompRows_in);
  size_comp_year_in.allocate(1,nSizeComps_in,1,nSizeCompRows_in);
		for ( int kk = 1; kk <= nSizeComps_in; kk++ )
		{
			dmatrix tmp = trans(d3_SizeComps_in(kk)).sub(1,nSizeCompCols_in(kk));
			d3_obs_size_comps_in(kk) = trans(tmp);
			size_comp_sample_size_in(kk) = column(d3_SizeComps_in(kk),0);
			size_comp_year_in(kk) = column(d3_SizeComps_in(kk),-7);
		}
		WRITEDAT(nSizeComps_in); WRITEDAT(nSizeCompRows_in); WRITEDAT(nSizeCompCols_in); WRITEDAT(d3_SizeComps_in);
		ECHO(d3_obs_size_comps_in);
 cout << " * Growth data" << endl;
  nGrowthObs.allocate("nGrowthObs");
  dGrowthData.allocate(1,nGrowthObs,1,4,"dGrowthData");
  dPreMoltSize.allocate(1,nGrowthObs);
  iMoltIncSex.allocate(1,nGrowthObs);
  dMoltInc.allocate(1,nGrowthObs);
  dMoltIncCV.allocate(1,nGrowthObs);
  mle_alpha.allocate(1,nsex);
  mle_beta.allocate(1,nsex);
		dPreMoltSize = column(dGrowthData,1);
		iMoltIncSex  = ivector(column(dGrowthData,2));
		dMoltInc     = column(dGrowthData,3);
		dMoltIncCV   = column(dGrowthData,4);
		dvector xybar(1,nsex);
		dvector xx(1,nsex);
		dvector xbar(1,nsex);
		dvector ybar(1,nsex);
		ivector nh(1,nsex);
		nh.initialize();
		xybar.initialize();
		xbar.initialize();
		ybar.initialize();
		xx.initialize();
		// MLE estimates for alpha and beta for the linear growth increment model.
		if ( nGrowthObs )
		{
			for ( int i = 1; i <= nGrowthObs; i++ )
			{
				int h = iMoltIncSex(i);
				nh(h)++;
				xybar(h) += dPreMoltSize(i) * dMoltInc(i);
				xbar(h)  += dPreMoltSize(i);
				ybar(h)  += dMoltInc(i);
				xx(h)    += square(dPreMoltSize(i));
			}
			for ( h = 1; h <= nsex; h++ )
			{
				xybar(h) /= nh(h);
				xbar(h) /= nh(h);
				ybar(h) /= nh(h);
				xx(h) /= nh(h);
				double slp = (xybar(h) - xbar(h)*ybar(h)) / (xx(h) - square(xbar(h)));
				double alp = ybar(h) - slp*xbar(h);
				mle_alpha(h) = alp;
				mle_beta(h) = -slp;
			}
		}
		WRITEDAT(nGrowthObs); 
		WRITEDAT(dGrowthData);
		ECHO(dPreMoltSize); ECHO(iMoltIncSex); ECHO(dMoltInc); ECHO(dMoltIncCV);
 cout << " * Custom data" << endl;
  bUseCustomGrowthMatrix.allocate("bUseCustomGrowthMatrix");
 WRITEDAT(bUseCustomGrowthMatrix);
  CustomGrowthMatrix.allocate(1,nsex,1,nclass,1,nclass,"CustomGrowthMatrix");
 WRITEDAT( CustomGrowthMatrix);
  bUseCustomNaturalMortality.allocate("bUseCustomNaturalMortality");
 WRITEDAT( bUseCustomNaturalMortality);
  CustomNaturalMortality.allocate(1,nsex,syr,nyr,"CustomNaturalMortality");
 WRITEDAT( CustomNaturalMortality);
  eof.allocate("eof");
 WRITEDAT(eof);
 if ( eof != 9999 ) {cout << "Error reading data" << endl; exit(1);}
 ad_comm::change_datafile_name(controlfile);
 cout << "+----------------------+" << endl;
 cout << "| Reading control file |" << endl;
 cout << "+----------------------+" << endl;
 cout << " * Key parameter controls" << endl;
  ntheta.allocate("ntheta");
  theta_control.allocate(1,ntheta,1,7,"theta_control");
  theta_ival.allocate(1,ntheta);
  theta_lb.allocate(1,ntheta);
  theta_ub.allocate(1,ntheta);
  theta_phz.allocate(1,ntheta);
		theta_ival = column(theta_control,1);
		theta_lb   = column(theta_control,2);
		theta_ub   = column(theta_control,3);
		theta_phz  = ivector(column(theta_control,4));
 cout << " * Growth parameter controls" << endl;
  nMoltVaries.allocate("nMoltVaries");
  nMoltChanges = nMoltVaries-1;
  iYrsMoltChanges.allocate(1,nMoltChanges,"iYrsMoltChanges");
 nGrwth = (nsex * 3) + (nsex * nMoltVaries * 2);
  Grwth_control.allocate(1,nGrwth,1,7,"Grwth_control");
  Grwth_ival.allocate(1,nGrwth);
  Grwth_lb.allocate(1,nGrwth);
  Grwth_ub.allocate(1,nGrwth);
  Grwth_phz.allocate(1,nGrwth);
		Grwth_ival = column(Grwth_control,1);
		Grwth_lb   = column(Grwth_control,2);
		Grwth_ub   = column(Grwth_control,3);
		Grwth_phz  = ivector(column(Grwth_control,4));
		WriteCtl(ntheta); WriteCtl(theta_control); 
		WriteCtl(nMoltVaries);
		WriteCtl(iYrsMoltChanges);
		WriteCtl(Grwth_control);
 cout << " * Selectivity parameter controls" << endl;
 nslx_cols_in = 13; // number of columns in the control file to be read in
  slx_nsel_period_in.allocate(1,nfleet,"slx_nsel_period_in");
  slx_bsex_in.allocate(1,nfleet,"slx_bsex_in");
  slx_type_in.allocate(1,nsex,1,nfleet,"slx_type_in");
  ret_nret_period_in.allocate(1,nfleet,"ret_nret_period_in");
  ret_bsex_in.allocate(1,nfleet,"ret_bsex_in");
  ret_type_in.allocate(1,nsex,1,nfleet,"ret_type_in");
  slx_nret.allocate(1,nsex,1,nfleet,"slx_nret");
		WriteCtl(slx_nsel_period_in); 
		WriteCtl(slx_bsex_in); 
		WriteCtl(slx_type_in); 
		WriteCtl(ret_nret_period_in); 
		WriteCtl(ret_bsex_in); 
		WriteCtl(ret_type_in); 
		WriteCtl(slx_nret); 
		// Work out how many selectivities we are dealing with, nfleet * nsex, plus any additonal sex-specific or time period selectivities
		nslx = 0;
		for ( int k = 1; k <= nfleet; k++ )
		{
			nslx += slx_nsel_period_in(k) * (1 + slx_bsex_in(k));
			nslx += ret_nret_period_in(k) * (1 + ret_bsex_in(k));
		}
		// Work out how many rows are in the selectivity/retention control inputs matrix based on the type of each selectivity and the number of blocks
		nslx_rows_in = 0;
		for ( int k = 1; k <= nfleet; k++ )
		{
			// Selectivity
			for ( int h = 1; h <= slx_bsex_in(k)+1; h++ )
			{
				switch ( slx_type_in(h,k) )
				{
					case 0: // parametric
						nslx_rows_in += nclass * slx_nsel_period_in(k);
					break;
					case 1: // coefficients
						nslx_rows_in += (nclass - 0) * slx_nsel_period_in(k);
					break;
					case 2: // logistic has 2 parameters
						nslx_rows_in += 2 * slx_nsel_period_in(k);
					break;
					case 3: // logistic95 has 2 parameters
						nslx_rows_in += 2 * slx_nsel_period_in(k);
					break;
					case 4: // double normal has 3 parameters
						nslx_rows_in += 3 * slx_nsel_period_in(k);
					break;
				}
			}
			// Retention
			for ( int h = 1; h <= ret_bsex_in(k)+1; h++ )
			{
				switch ( ret_type_in(h,k) )
				{
					case 0: // parametric
						nslx_rows_in += nclass * ret_nret_period_in(k);
					break;
					case 1: // coefficients
						nslx_rows_in += (nclass - 0) * ret_nret_period_in(k);
					break;
					case 2: // logistic
						nslx_rows_in += 2 * ret_nret_period_in(k);
					break;
					case 3: // logistic95
						nslx_rows_in += 2 * ret_nret_period_in(k);
					break;
					case 4: // double normal
						nslx_rows_in += 3 * ret_nret_period_in(k);
					break;
				}
			}
		}
  slx_control_in.allocate(1,nslx_rows_in,1,nslx_cols_in,"slx_control_in");
 WriteCtl(slx_control_in);
  slx_control.allocate(1,nslx,1,nslx_cols_in);
  slx_indx.allocate(1,nslx);
  slx_gear.allocate(1,nslx);
  slx_type.allocate(1,nslx);
  slx_isex.allocate(1,nslx);
  slx_styr.allocate(1,nslx);
  slx_edyr.allocate(1,nslx);
  slx_cols.allocate(1,nslx);
  slx_npar.allocate(1,nslx);
		// Work out the type of each selectivity and place in the ivector slx_type
		int kk = 1;
		for ( int k = 1; k <= nfleet; k++ )
		{
			for ( int i = 1; i <= slx_nsel_period_in(k); i++ )
			{
				int hh = 1 + slx_bsex_in(k);
				for ( int h = 1; h <= hh; h++ )
				{
					slx_type(kk) = slx_type_in(h,k);
					kk ++;
				}
			}
		}
		for ( int k = 1; k <= nfleet; k++ )
		{
			for ( int i = 1; i <= ret_nret_period_in(k); i++ )
			{
				int hh = 1 + ret_bsex_in(k);
				for ( int h = 1; h <= hh; h++ )
				{
					slx_type(kk) = ret_type_in(h,k);
					kk ++;
				}
			}
		}
		// count up number of parameters required
		slx_cols.initialize();
		for ( int k = 1; k <= nslx; k++ )
		{
			switch ( slx_type(k) )
			{
				case 0: // parametric
					slx_cols(k) = nclass;
					slx_npar(k) = nclass;
				break;
				case 1: // coefficients
					slx_cols(k) = nclass - 0;
					slx_npar(k) = nclass - 0;
				break;
				case 2: // logistic
					slx_cols(k) = 2;
					slx_npar(k) = 2;
				break;
				case 3: // logistic95
					slx_cols(k) = 2;
					slx_npar(k) = 2;
				break;
				case 4: // double normal
					slx_cols(k) = 3;
					slx_npar(k) = 3;
				break;
			}
		}
		// slx_indx is an ivector of the index for the first parameter of each nslx in the slx_control_in matrix
		kk = 1;
		for ( int k = 1; k <= nslx; k++ )
		{
			slx_indx(k) = kk;
			kk += slx_cols(k);
		}
		// Store a version of the control file that only records the first parameter of each selectivity type - this is useful for R plots. Also extract vectors of elements from this matrix
		for ( int k = 1; k <= nslx; k++ )
		{
			int kk = slx_indx(k);
			for ( int i = 1; i <= nslx_cols_in; i++ )
			{
				slx_control(k,i) = slx_control_in(kk,i);
			}
			slx_gear(k) = slx_control_in(kk,1);
			slx_isex(k) = slx_control_in(kk,4);
			slx_styr(k) = slx_control_in(kk,12);
			slx_edyr(k) = slx_control_in(kk,13);
		}
		nslx_pars = sum(slx_cols);
  slx_par.allocate(1,nslx,1,slx_npar);
  slx_priors.allocate(1,nslx,1,slx_cols,1,3);
  slx_lb.allocate(1,nslx_pars);
  slx_ub.allocate(1,nslx_pars);
  slx_phzm.allocate(1,nslx_pars);
		for ( int k = 1; k <= nslx; k++ )
		{
			int kk = slx_indx(k);
			for ( int j = 1; j <= slx_cols(k); j++ )
			{
				int jj = kk + (j - 1);
				slx_par(k,j)      = slx_control_in(jj,5); // init
				slx_priors(k,j,1) = slx_control_in(jj,8); // prior
				// If a uniform prior is specified then use the lb and ub rather than p1 and p2
				if ( slx_priors(k,j,1) == 0 )
				{
					slx_priors(k,j,2) = slx_control_in(jj,6); // p1
					slx_priors(k,j,3) = slx_control_in(jj,7); // p2
				} else {
					slx_priors(k,j,2) = slx_control_in(jj,9);  // p1
					slx_priors(k,j,3) = slx_control_in(jj,10); // p2
				}
				//if ( slx_type(k) == 0 || slx_type(k) == 1 )
				//{
				//	slx_lb(jj) = log(slx_control_in(jj,6) / (1 - slx_control_in(jj,6)));
				//	slx_ub(jj) = log(slx_control_in(jj,7) / (1 - slx_control_in(jj,7)));
				//} else {
					slx_lb(jj) = log(slx_control_in(jj,6));
					slx_ub(jj) = log(slx_control_in(jj,7));
				//}
				slx_phzm(jj) = slx_control_in(jj,11);
			}
			//if ( slx_type(k) == 1 )
			//{
				//slx_par(k,1) = 0.001;
				//for ( int j = 2; j <= slx_npar(k)-1; j++ )
				//for ( int j = 1; j <= slx_cols(k); j++ )
				//{
				//	slx_par(k,j) = slx_par(k,j-1) + 1.0/nclass;
				//}
				//slx_par(k,slx_npar(k)) = 0.999;
			//}
		}
		ECHO(slx_priors);
 cout << " * Catchability parameter controls" << endl;
  q_controls.allocate(1,nSurveys,1,9,"q_controls");
  q_ival.allocate(1,nSurveys);
  q_lb.allocate(1,nSurveys);
  q_ub.allocate(1,nSurveys);
  q_phz.allocate(1,nSurveys);
  prior_qtype.allocate(1,nSurveys);
  prior_p1.allocate(1,nSurveys);
  prior_p2.allocate(1,nSurveys);
  q_anal.allocate(1,nSurveys);
  cpue_lambda.allocate(1,nSurveys);
		WriteCtl(q_controls);
		q_ival      = column(q_controls,1);
		q_lb        = column(q_controls,2);
		q_ub        = column(q_controls,3);
		q_phz       = ivector(column(q_controls,4));
		prior_qtype = ivector(column(q_controls,5));
		prior_p1    = column(q_controls,6);
		prior_p2    = column(q_controls,7);
		q_anal      = ivector(column(q_controls,8));
		cpue_lambda = column(q_controls,9);
		for ( int k = 1; k <= nSurveys; k++ )
		{
			// If a uniform prior is specified then use the lb and ub rather than p1 and p2.
			if ( prior_qtype(k) == 0 )
			{
				prior_p1(k) = q_lb(k);
				prior_p2(k) = q_ub(k);
			}
			if ( q_anal(k) == 1 )
			{
				if ( prior_qtype(k) != 0 || prior_qtype(k) != 2 )
				{
					cout << "Error: you're only allowed to use a uniform or lognormal prior if the analytic q option is being used," << endl;
					cout << "       you can either specify a uniform or lognormal prior for q or switch analytic q off." << endl;
					exit(1);
				}
				// If we are using analytic q then turn off estimating this parameter by changing the estimation phase to be -ve.
				q_phz(k) = -1;
			}
		}
		ECHO(prior_qtype); ECHO(prior_p1); ECHO(prior_p2); ECHO(cpue_lambda);
 cout << " * Additional CV controls" << endl;
  cv_controls.allocate(1,nSurveys,1,7,"cv_controls");
 WriteCtl(cv_controls);
  add_cv_ival.allocate(1,nSurveys);
  add_cv_lb.allocate(1,nSurveys);
  add_cv_ub.allocate(1,nSurveys);
  prior_add_cv_type.allocate(1,nSurveys);
  prior_add_cv_p1.allocate(1,nSurveys);
  prior_add_cv_p2.allocate(1,nSurveys);
  cv_phz.allocate(1,nSurveys);
  log_add_cv_ival.allocate(1,nSurveys);
  log_add_cv_lb.allocate(1,nSurveys);
  log_add_cv_ub.allocate(1,nSurveys);
		add_cv_ival       = column(cv_controls,1);
		add_cv_lb         = column(cv_controls,2);
		add_cv_ub         = column(cv_controls,3);
		cv_phz            = ivector(column(cv_controls,4));
		prior_add_cv_type = ivector(column(cv_controls,5));
		prior_add_cv_p1   = column(cv_controls,6);
		prior_add_cv_p2   = column(cv_controls,7);
		log_add_cv_ival   = log(add_cv_ival);
		log_add_cv_lb     = log(add_cv_lb);
		log_add_cv_ub     = log(add_cv_ub);
		for ( int k = 1; k <= nSurveys; k++ )
		{
			// If a uniform prior is specified then use the lb and ub rather than p1 and p2.
			if ( prior_add_cv_type(k) == 0 )
			{
				prior_add_cv_p1(k) = add_cv_lb(k);
				prior_add_cv_p2(k) = add_cv_ub(k);
			}
		}
		ECHO(prior_add_cv_type); ECHO(prior_add_cv_p1); ECHO(prior_add_cv_p2);
 cout << " * Fishing mortality controls" << endl;
  f_controls.allocate(1,nfleet,1,4,"f_controls");
  f_phz.allocate(1,nfleet);
  pen_fbar.allocate(1,nfleet);
  log_pen_fbar.allocate(1,nfleet);
  pen_fstd.allocate(1,2,1,nfleet);
		WriteCtl(f_controls);
		pen_fbar = column(f_controls,1);
		log_pen_fbar = log(pen_fbar + 1.0e-14);
		for ( int i = 1; i <= 2; i++ )
		{
			pen_fstd(i) = trans(f_controls)(i+1);
		}
		f_phz = ivector(column(f_controls,4));
		// Set foff_phz to f_phz
		for ( int k = 1; k <= nfleet; k++ )
		{
			for ( int i = syr; i <= nyr; i++ )
			{
				for ( int j = 1; j <= nseason; j++ )
				{
					if ( yhit(i,j,k) )
					{
						foff_phz(k) = f_phz(k);
						break;
					}
				}
			}
		}
		ECHO(f_phz);
 cout << " * Size composition controls" << endl;
  nAgeCompType_in.allocate(1,nSizeComps_in,"nAgeCompType_in");
  bTailCompression_in.allocate(1,nSizeComps_in,"bTailCompression_in");
  nvn_ival_in.allocate(1,nSizeComps_in,"nvn_ival_in");
  nvn_phz_in.allocate(1,nSizeComps_in,"nvn_phz_in");
  iCompAggregator.allocate(1,nSizeComps_in,"iCompAggregator");
  lf_lambda_in.allocate(1,nSizeComps_in,"lf_lambda_in");
 nSizeComps = max(iCompAggregator);
  nSizeCompRows.allocate(1,nSizeComps);
  nSizeCompCols.allocate(1,nSizeComps);
  nAgeCompType.allocate(1,nSizeComps);
  bTailCompression.allocate(1,nSizeComps);
  log_nvn_ival.allocate(1,nSizeComps);
  nvn_phz.allocate(1,nSizeComps);
  lf_lambda.allocate(1,nSizeComps);
		WriteCtl(nAgeCompType_in);
		WriteCtl(bTailCompression_in);
		WriteCtl(nvn_ival_in);
		WriteCtl(nvn_phz_in);
		WriteCtl(iCompAggregator);
	  WriteCtl(lf_lambda_in);
		nSizeCompCols.initialize();
		for ( int kk = 1; kk <= nSizeComps_in; kk++ )
		{
			int k = iCompAggregator(kk);
			// Currently this only works if the number of rows in each size composition group are the same and have the same years. If not then gmacs throws an error.
			nSizeCompRows(k) = nSizeCompRows_in(kk);
			// We are appending the arrays horizontally.
			nSizeCompCols(k) += nSizeCompCols_in(kk);
			// Again, we are using only the last specification here, may want to add a check to ensure the user specifies that these are the same and throw an error if not.
			nAgeCompType(k) = nAgeCompType_in(kk);
			bTailCompression(k) = bTailCompression_in(kk);
			log_nvn_ival(k) = log(nvn_ival_in(kk));
			nvn_phz(k) = nvn_phz_in(kk);
			lf_lambda(k) = lf_lambda_in(kk);
		}
		// Do the checks mentioned above
		for ( int kk = 1; kk <= nSizeComps_in; kk++ )
		{
			int k = iCompAggregator(kk);
			if ( nSizeCompRows(k) != nSizeCompRows_in(kk) )
			{
				cout << "Error: dimension mismatch in size-compositons being aggregated" << endl;
				exit(1);
			}
			if ( nAgeCompType(k) != nAgeCompType_in(kk) )
			{
				cout << "Error: mismatch in type of likelihood for size-compositons being aggregated" << endl;
				exit(1);
			}
			if ( bTailCompression(k) != bTailCompression_in(kk) )
			{
				cout << "Error: mismatch in auto tail compression for size-compositons being aggregated" << endl;
				exit(1);
			}
			if ( log_nvn_ival(k) != log(nvn_ival_in(kk)) )
			{
				cout << "Error: mismatch in initial value of effctive sample size for size-compositons being aggregated" << endl;
				exit(1);
			}
			if ( nvn_phz(k) != nvn_phz_in(kk) )
			{
				cout << "Error: mismatch in phase for estimation of effctive sample size for size-compositons being aggregated" << endl;
				exit(1);
			}
		}
  d3_SizeComps.allocate(1,nSizeComps,1,nSizeCompRows,-7,nSizeCompCols);
  d3_obs_size_comps.allocate(1,nSizeComps,1,nSizeCompRows,1,nSizeCompCols);
  size_comp_sample_size.allocate(1,nSizeComps,1,nSizeCompRows);
  size_comp_year.allocate(1,nSizeComps,1,nSizeCompRows);
		int i,j;
		int oldk = 9999;
		// This aggregates the size composition data by appending size comps horizontally
		for ( int kk = 1; kk <= nSizeComps_in; kk++ )
		{
			int k = iCompAggregator(kk);
			if ( oldk != k )
			{
				j = 0;
			}
			oldk = k;
			for ( int jj = 1; jj <= nSizeCompCols_in(kk); jj++ )
			{
				j += 1;
				for ( int ii = 1; ii <= nSizeCompRows_in(kk); ii++ )
				{
					i = ii;
					d3_obs_size_comps(k,i,j) = d3_obs_size_comps_in(kk,ii,jj);
				}
			}
		}
		// The size composition sample sizes are calculated as the sum of the aggregated sample sizes
		size_comp_sample_size.initialize();
		for ( int kk = 1; kk <= nSizeComps_in; kk++ )
		{
			int k = iCompAggregator(kk);
			size_comp_year(k) = size_comp_year_in(kk);
			for ( int ii = 1; ii <= nSizeCompRows_in(kk); ii++ )
			{
				size_comp_sample_size(k,ii) += size_comp_sample_size_in(kk,ii);
			}
		}
		for ( int kk = 1; kk <= nSizeComps_in; kk++ )
		{
			int k = iCompAggregator(kk);
			for ( int ii = 1; ii <= nSizeCompRows_in(kk); ii++ )
			{
				if ( size_comp_year(k,ii) != size_comp_year_in(kk,ii) )
				{
					cout << "Error: mismatch in years for size-compositons being aggregated" << endl;
					cout << "       see the " << size_comp_year_in(kk,ii) << " year in size composition " << kk << " in the .dat file" << endl;
					exit(1);
				}
			}
		}
		// This normalizes all observations by row
		for ( int k = 1; k <= nSizeComps; k++ )
		{
			for ( int i = 1; i <= nSizeCompRows(k); i++ )
			{
			   d3_obs_size_comps(k,i) /= sum(d3_obs_size_comps(k,i));
			}
		}
		ECHO(d3_obs_size_comps);
  ilike_vector.allocate(1,nlikes);
		ilike_vector(1) = nCatchDF;
		like_names      =  adstring("Catch ");
		ilike_vector(2) = nSurveys;
		like_names      = like_names + adstring("Survey_Indices ");
		ilike_vector(3) = nSizeComps;
		like_names      = like_names + adstring("SizeComps ");
		ilike_vector(4) = 1;
		ilike_vector(5) = 1;
 cout << " * Natural mortality controls" << endl;
  m_females.allocate("m_females");
  m_type.allocate("m_type");
  Mdev_phz.allocate("Mdev_phz");
  m_stdev.allocate("m_stdev");
  m_nNodes.allocate("m_nNodes");
  m_nNodes_females.allocate("m_nNodes_females");
  m_nodeyear.allocate(1,m_nNodes,"m_nodeyear");
  m_nodeyear_females.allocate(1,m_nNodes_females,"m_nodeyear_females");
		WriteCtl(m_females);
		WriteCtl(m_type);
		WriteCtl(Mdev_phz); 
		WriteCtl(m_stdev); 
		WriteCtl(m_nNodes); 
		WriteCtl(m_nNodes_females); 
		WriteCtl(m_nodeyear);
	  WriteCtl(m_nodeyear_females);
		if ( m_females == 1 )
		{
			Mdev_phz_females = Mdev_phz;
		} else {
			Mdev_phz_females = -1;
		}
		switch ( m_type )
		{
			case 0:
				nMdev = 0;
				nMdev_females = 0;
				Mdev_phz = -1;
				Mdev_phz_females = -1;
			break;
			case 1:
				nMdev = nyr - syr;
				nMdev_females = nyr - syr;
			break;
			case 2:
				nMdev = m_nNodes;
				nMdev_females = m_nNodes_females;
			break;
			case 3:
				nMdev = m_nNodes;
				nMdev_females = m_nNodes_females;
			break;
			case 4:                 //add by Jie Zheng
				nMdev = m_nNodes / 2;
				nMdev_females = m_nNodes_females / 2;
		    break;
		}
 cout << " * Other controls" << endl;
  model_controls.allocate(1,11,"model_controls");
		rdv_phz             = int(model_controls(1));
		if (nsex==1) 
			rec_prop_phz = -1;
		else
			rec_prop_phz = rdv_phz;
		rec_ini_phz         = int(model_controls(2));
		verbose             = int(model_controls(3));
		bInitializeUnfished = int(model_controls(4));
		spr_syr             = int(model_controls(5));
		spr_nyr             = int(model_controls(6));
		spr_target          =     model_controls(7);
		spr_fleet           = int(model_controls(8));
		spr_lambda          =     model_controls(9);
		bUseEmpiricalGrowth = int(model_controls(10));
		nSRR_flag           = int(model_controls(11));
		if ( bInitializeUnfished == 2 )
		{
			rec_ini_phz  = -1; // If free parameters is selected then don't use deviations for initial numbers.
			theta_phz(3) = -1; // Also don't use log(Rini) i.e. initial recruitment(syr). Instead we will use log(N0(1)).
		}
		WriteCtl(model_controls);
		//if ( bInitializeUnfished == 1 && theta_phz(3) > 0 )
		//{
		//	cout << "Error: cannot initialize unfished and estimate the logRini parameter" << endl; 
		//	exit(1);
		//}
		if ( bInitializeUnfished == 2 && theta_phz(3) > 0 )
		{
			cout << "Error: cannot estimate initial numbers and the logRini parameter" << endl; 
			exit(1);
		}
  eof_ctl.allocate("eof_ctl");
 WriteCtl(eof_ctl);
 if ( eof_ctl != 9999 ){cout << "Error reading control file" << endl; exit(1);}
 cout << "end of control section" << endl;
		// ensure the phase for alpha & beta is -ve for GrowhtPars if bUseEmpiricalGrowth
		COUT(Grwth_phz);
		if ( bUseEmpiricalGrowth )
		{
			cerr << "Warning:\n \tUsing empirical growth increment data,\n";
			cerr << "\talpha & beta parameters will not be estimated." << endl;
			for ( int h = 1; h <= nsex; h++ )
			{
				int icnt = h;
				Grwth_phz(icnt) = -1;
				icnt += nsex;
				Grwth_phz(icnt) = -1;
			}
		}
 nf = 0;
}

void model_parameters::initializationfunction(void)
{
  theta.set_initial_value(theta_ival);
  Grwth.set_initial_value(Grwth_ival);
  log_fbar.set_initial_value(log_pen_fbar);
  log_vn.set_initial_value(log_nvn_ival);
  survey_q.set_initial_value(q_ival);
  log_add_cv.set_initial_value(log_add_cv_ival);
  logit_rec_prop.set_initial_value(0.0);
}

model_parameters::model_parameters(int sz,int argc,char * argv[]) : 
 model_data(argc,argv) , function_minimizer(sz)
{
  initializationfunction();
 cout << "+----------------------+" << endl;
 cout << "| Parameter section    |" << endl;
 cout << "+----------------------+" << endl;
  theta.allocate(1,ntheta,theta_lb,theta_ub,theta_phz,"theta");
  Grwth.allocate(1,nGrwth,Grwth_lb,Grwth_ub,Grwth_phz,"Grwth");
  log_slx_pars.allocate(1,nslx_pars,slx_lb,slx_ub,slx_phzm,"log_slx_pars");
		// Selectivity
		int j = 1;
		for ( int k = 1; k <= nslx; k++ )
		{
			// Logit transform if using parametric or coefficients selectivity type, otherwise just log transform
			//if ( slx_type(k) == 0 || slx_type(k) == 1 )
			//{
			//	for ( int i = 1; i <= slx_npar(k); i++ )
			//	{
			//		log_slx_pars(j) = log(slx_par(k,i) / (1 - slx_par(k,i)));
			//		j++;
			//	}
			//} else {
				for ( int i = 1; i <= slx_npar(k); i++ )
				{
					log_slx_pars(j) = log(slx_par(k,i));
					j++;
				}
			//}
			//COUT(exp(log_slx_pars(k)));
			//COUT(log_slx_pars(k));
		}
  log_fbar.allocate(1,nfleet,f_phz,"log_fbar");
  log_fdev.allocate(1,nfleet,1,nFparams,f_phz,"log_fdev");
  log_foff.allocate(1,nfleet,foff_phz,"log_foff");
  log_fdov.allocate(1,nfleet,1,nYparams,foff_phz,"log_fdov");
  rec_ini.allocate(1,nclass,-14.0,14.0,rec_ini_phz,"rec_ini");
  rec_dev.allocate(syr,nyr,-8.0,8.0,rdv_phz,"rec_dev");
  logit_rec_prop.allocate(syr,nyr,-100,100,rec_prop_phz,"logit_rec_prop");
  m_dev.allocate(1,nMdev,-3.0,3.0,Mdev_phz,"m_dev");
  m_dev_females.allocate(1,nMdev_females,-3.0,3.0,Mdev_phz_females,"m_dev_females");
  log_vn.allocate(1,nSizeComps,nvn_phz,"log_vn");
  survey_q.allocate(1,nSurveys,q_lb,q_ub,q_phz,"survey_q");
  log_add_cv.allocate(1,nSurveys,log_add_cv_lb,log_add_cv_ub,cv_phz,"log_add_cv");
  priorDensity.allocate(1,ntheta+nGrwth+nSurveys+nSurveys+nslx_pars,"priorDensity");
  #ifndef NO_AD_INITIALIZE
    priorDensity.initialize();
  #endif
  nloglike.allocate(1,nlikes,1,ilike_vector,"nloglike");
  #ifndef NO_AD_INITIALIZE
    nloglike.initialize();
  #endif
  nlogPenalty.allocate(1,6,"nlogPenalty");
  #ifndef NO_AD_INITIALIZE
    nlogPenalty.initialize();
  #endif
  sdnr_MAR_cpue.allocate(1,nSurveys,1,2,"sdnr_MAR_cpue");
  #ifndef NO_AD_INITIALIZE
    sdnr_MAR_cpue.initialize();
  #endif
  sdnr_MAR_lf.allocate(1,nSizeComps,1,2,"sdnr_MAR_lf");
  #ifndef NO_AD_INITIALIZE
    sdnr_MAR_lf.initialize();
  #endif
  Francis_weights.allocate(1,nSizeComps,"Francis_weights");
  #ifndef NO_AD_INITIALIZE
    Francis_weights.initialize();
  #endif
  objfun.allocate("objfun");
  prior_function_value.allocate("prior_function_value");
  likelihood_function_value.allocate("likelihood_function_value");
  fpen.allocate("fpen");
  #ifndef NO_AD_INITIALIZE
  fpen.initialize();
  #endif
  M0.allocate("M0");
  #ifndef NO_AD_INITIALIZE
  M0.initialize();
  #endif
  logR0.allocate("logR0");
  #ifndef NO_AD_INITIALIZE
  logR0.initialize();
  #endif
  logRbar.allocate("logRbar");
  #ifndef NO_AD_INITIALIZE
  logRbar.initialize();
  #endif
  logRini.allocate("logRini");
  #ifndef NO_AD_INITIALIZE
  logRini.initialize();
  #endif
  ra.allocate("ra");
  #ifndef NO_AD_INITIALIZE
  ra.initialize();
  #endif
  rbeta.allocate("rbeta");
  #ifndef NO_AD_INITIALIZE
  rbeta.initialize();
  #endif
  logSigmaR.allocate("logSigmaR");
  #ifndef NO_AD_INITIALIZE
  logSigmaR.initialize();
  #endif
  steepness.allocate("steepness");
  #ifndef NO_AD_INITIALIZE
  steepness.initialize();
  #endif
  rho.allocate("rho");
  #ifndef NO_AD_INITIALIZE
  rho.initialize();
  #endif
  logN0.allocate(1,nclass,"logN0");
  #ifndef NO_AD_INITIALIZE
    logN0.initialize();
  #endif
  alpha.allocate(1,nsex,"alpha");
  #ifndef NO_AD_INITIALIZE
    alpha.initialize();
  #endif
  beta.allocate(1,nsex,"beta");
  #ifndef NO_AD_INITIALIZE
    beta.initialize();
  #endif
  gscale.allocate(1,nsex,"gscale");
  #ifndef NO_AD_INITIALIZE
    gscale.initialize();
  #endif
  molt_mu.allocate(1,nsex,1,nMoltVaries,"molt_mu");
  #ifndef NO_AD_INITIALIZE
    molt_mu.initialize();
  #endif
  molt_cv.allocate(1,nsex,1,nMoltVaries,"molt_cv");
  #ifndef NO_AD_INITIALIZE
    molt_cv.initialize();
  #endif
  rec_sdd.allocate(1,nclass,"rec_sdd");
  #ifndef NO_AD_INITIALIZE
    rec_sdd.initialize();
  #endif
  recruits.allocate(1,nsex,syr,nyr,"recruits");
  #ifndef NO_AD_INITIALIZE
    recruits.initialize();
  #endif
  res_recruit.allocate(syr,nyr,"res_recruit");
  #ifndef NO_AD_INITIALIZE
    res_recruit.initialize();
  #endif
  xi.allocate(syr,nyr,"xi");
  #ifndef NO_AD_INITIALIZE
    xi.initialize();
  #endif
  pre_catch.allocate(1,nCatchDF,1,nCatchRows,"pre_catch");
  #ifndef NO_AD_INITIALIZE
    pre_catch.initialize();
  #endif
  res_catch.allocate(1,nCatchDF,1,nCatchRows,"res_catch");
  #ifndef NO_AD_INITIALIZE
    res_catch.initialize();
  #endif
  pre_catch_out.allocate(1,nCatchDF,syr,nyr-1,"pre_catch_out");
  #ifndef NO_AD_INITIALIZE
    pre_catch_out.initialize();
  #endif
  res_catch_out.allocate(1,nCatchDF,syr,nyr-1,"res_catch_out");
  #ifndef NO_AD_INITIALIZE
    res_catch_out.initialize();
  #endif
  log_q_catch.allocate(1,nCatchDF,"log_q_catch");
  #ifndef NO_AD_INITIALIZE
    log_q_catch.initialize();
  #endif
  pre_cpue.allocate(1,nSurveys,1,nSurveyRows,"pre_cpue");
  #ifndef NO_AD_INITIALIZE
    pre_cpue.initialize();
  #endif
  res_cpue.allocate(1,nSurveys,1,nSurveyRows,"res_cpue");
  #ifndef NO_AD_INITIALIZE
    res_cpue.initialize();
  #endif
  molt_increment.allocate(1,nsex,1,nclass,"molt_increment");
  #ifndef NO_AD_INITIALIZE
    molt_increment.initialize();
  #endif
  molt_probability.allocate(1,nsex,syr,nyr,1,nclass,"molt_probability");
  #ifndef NO_AD_INITIALIZE
    molt_probability.initialize();
  #endif
  P.allocate(1,nsex,1,nclass,1,nclass,"P");
  #ifndef NO_AD_INITIALIZE
    P.initialize();
  #endif
  growth_transition.allocate(1,nsex,1,nclass,1,nclass,"growth_transition");
  #ifndef NO_AD_INITIALIZE
    growth_transition.initialize();
  #endif
  size_transition.allocate(1,nsex,1,nclass,1,nclass,"size_transition");
  #ifndef NO_AD_INITIALIZE
    size_transition.initialize();
  #endif
  M.allocate(1,nsex,syr,nyr,1,nclass,"M");
  #ifndef NO_AD_INITIALIZE
    M.initialize();
  #endif
  F.allocate(1,nsex,syr,nyr,1,nseason,1,nclass,"F");
  #ifndef NO_AD_INITIALIZE
    F.initialize();
  #endif
  Z.allocate(1,nsex,syr,nyr,1,nseason,1,nclass,"Z");
  #ifndef NO_AD_INITIALIZE
    Z.initialize();
  #endif
  S.allocate(1,nsex,syr,nyr,1,nseason,1,nclass,1,nclass,"S");
  #ifndef NO_AD_INITIALIZE
    S.initialize();
  #endif
  d4_N.allocate(1,n_grp,syr,nyr,1,nseason,1,nclass,"d4_N");
  #ifndef NO_AD_INITIALIZE
    d4_N.initialize();
  #endif
  ft.allocate(1,nfleet,1,nsex,syr,nyr,1,nseason,"ft");
  #ifndef NO_AD_INITIALIZE
    ft.initialize();
  #endif
  d3_newShell.allocate(1,nsex,syr,nyr+1,1,nclass,"d3_newShell");
  #ifndef NO_AD_INITIALIZE
    d3_newShell.initialize();
  #endif
  d3_oldShell.allocate(1,nsex,syr,nyr+1,1,nclass,"d3_oldShell");
  #ifndef NO_AD_INITIALIZE
    d3_oldShell.initialize();
  #endif
  d3_pre_size_comps_in.allocate(1,nSizeComps_in,1,nSizeCompRows_in,1,nSizeCompCols_in,"d3_pre_size_comps_in");
  #ifndef NO_AD_INITIALIZE
    d3_pre_size_comps_in.initialize();
  #endif
  d3_res_size_comps_in.allocate(1,nSizeComps_in,1,nSizeCompRows_in,1,nSizeCompCols_in,"d3_res_size_comps_in");
  #ifndef NO_AD_INITIALIZE
    d3_res_size_comps_in.initialize();
  #endif
  d3_obs_size_comps_out.allocate(1,nSizeComps_in,1,nSizeCompRows_in,1,nSizeCompCols_in,"d3_obs_size_comps_out");
  #ifndef NO_AD_INITIALIZE
    d3_obs_size_comps_out.initialize();
  #endif
  d3_pre_size_comps_out.allocate(1,nSizeComps_in,1,nSizeCompRows_in,1,nSizeCompCols_in,"d3_pre_size_comps_out");
  #ifndef NO_AD_INITIALIZE
    d3_pre_size_comps_out.initialize();
  #endif
  d3_res_size_comps_out.allocate(1,nSizeComps_in,1,nSizeCompRows_in,1,nSizeCompCols_in,"d3_res_size_comps_out");
  #ifndef NO_AD_INITIALIZE
    d3_res_size_comps_out.initialize();
  #endif
  d3_pre_size_comps.allocate(1,nSizeComps,1,nSizeCompRows,1,nSizeCompCols,"d3_pre_size_comps");
  #ifndef NO_AD_INITIALIZE
    d3_pre_size_comps.initialize();
  #endif
  d3_res_size_comps.allocate(1,nSizeComps,1,nSizeCompRows,1,nSizeCompCols,"d3_res_size_comps");
  #ifndef NO_AD_INITIALIZE
    d3_res_size_comps.initialize();
  #endif
  log_slx_capture.allocate(1,nfleet,1,nsex,syr,nyr,1,nclass,"log_slx_capture");
  #ifndef NO_AD_INITIALIZE
    log_slx_capture.initialize();
  #endif
  log_slx_retaind.allocate(1,nfleet,1,nsex,syr,nyr,1,nclass,"log_slx_retaind");
  #ifndef NO_AD_INITIALIZE
    log_slx_retaind.initialize();
  #endif
  log_slx_discard.allocate(1,nfleet,1,nsex,syr,nyr,1,nclass,"log_slx_discard");
  #ifndef NO_AD_INITIALIZE
    log_slx_discard.initialize();
  #endif
  spr_rbar.allocate("spr_rbar");
  #ifndef NO_AD_INITIALIZE
  spr_rbar.initialize();
  #endif
  spr_fspr.allocate("spr_fspr");
  #ifndef NO_AD_INITIALIZE
  spr_fspr.initialize();
  #endif
  spr_bspr.allocate("spr_bspr");
  #ifndef NO_AD_INITIALIZE
  spr_bspr.initialize();
  #endif
  spr_cofl.allocate("spr_cofl");
  #ifndef NO_AD_INITIALIZE
  spr_cofl.initialize();
  #endif
  spr_fofl.allocate("spr_fofl");
  #ifndef NO_AD_INITIALIZE
  spr_fofl.initialize();
  #endif
  spr_ssbo.allocate("spr_ssbo");
  #ifndef NO_AD_INITIALIZE
  spr_ssbo.initialize();
  #endif
  sd_rbar.allocate("sd_rbar");
  sd_fofl.allocate("sd_fofl");
  sd_ofl.allocate("sd_ofl");
  sd_fbar.allocate(syr,nyr-1,"sd_fbar");
  sd_log_recruits.allocate(1,nsex,syr,nyr,"sd_log_recruits");
  sd_log_ssb.allocate(syr,nyr,"sd_log_ssb");
  sd_log_dyn_Bzero.allocate(syr+1,nyr,"sd_log_dyn_Bzero");
}

void model_parameters::preliminary_calculations(void)
{

#if defined(USE_ADPVM)

  admaster_slave_variable_interface(*this);

#endif
	cout << "+----------------------+" << endl;
	cout << "| Preliminary section  |" << endl;
	cout << "+----------------------+" << endl;
	if ( simflag )
	{
		if ( !global_parfile )
		{
			cerr << "Must have a gmacs.pin file to use the -sim command line option" << endl;
			ad_exit(1);
		}
		cout << "|———————————————————————————————————————————|" << endl;
		cout << "|*** RUNNING SIMULATION WITH RSEED = " << rseed << " ***|" << endl;
		cout << "|———————————————————————————————————————————|" << endl;
		simulation_model();
		//exit(1);
	}
	
	if ( bUseEmpiricalGrowth )
	{
		int l = 1;
		for( int i = 1; i <= nGrowthObs; i++ )
		{
			int h = dGrowthData(i,2);
			molt_increment(h)(l++) = dGrowthData(i,3);
			if ( l > nclass ) l = 1;
		}
	}
	cout << "+----------------------+" << endl;
	cout << "| Procedure section    |" << endl;
	cout << "+----------------------+" << endl;
}

void model_parameters::userfunction(void)
{
  objfun =0.0;
	// Initialize model parameters
	initialize_model_parameters(); if ( verbose == 1 ) cout << "Ok after initialize_model_parameters ..." << endl;
	
	// Fishing fleet dynamics ...
	calc_selectivities(); if ( verbose == 1 ) cout << "Ok after calc_selectivities ..." << endl;
	calc_fishing_mortality(); if ( verbose == 1 ) cout << "Ok after calc_fishing_mortality ..." << endl;
	// Population dynamics ...
	if ( !bUseEmpiricalGrowth )
	{
		calc_growth_increments(); if ( verbose == 1 ) cout << "Ok after calc_growth_increments ..." << endl;
	}
	calc_molting_probability(); if ( verbose == 1 ) cout << "Ok after calc_molting_probability ..." << endl;
	calc_growth_transition();   if ( verbose == 1 ) cout << "Ok after calc_growth_transition ..." << endl;
	calc_natural_mortality();   if ( verbose == 1 ) cout << "Ok after calc_natural_mortality ..." << endl;
	calc_total_mortality();     if ( verbose == 1 ) cout << "Ok after calc_total_mortality ..." << endl;
	calc_recruitment_size_distribution();  if ( verbose == 1 ) cout << "Ok after calc_recruitment_size_distribution ..." << endl;
	calc_initial_numbers_at_length();      if ( verbose == 1 ) cout << "Ok after calc_initial_numbers_at_length ..." << endl;
	update_population_numbers_at_length(); if ( verbose == 1 ) cout << "Ok after update_population_numbers_at_length ..." << endl;
	calc_stock_recruitment_relationship(); if ( verbose == 1 ) cout << "Ok after calc_stock_recruitment_relationship ..." << endl;
	// observation models ...
	calc_predicted_catch();       if ( verbose == 1 ) cout << "Ok after calc_predicted_catch ..." << endl;
	calc_relative_abundance();    if ( verbose == 1 ) cout << "Ok after calc_relative_abundance ..." << endl;
	calc_predicted_composition(); if ( verbose == 1 ) cout << "Ok after calc_predicted_composition ..." << endl;
	if ( verbose == 1 ) cout << "Ok after observation models ..." << endl;
	// objective function ...
	calc_prior_densities();    if ( verbose == 1 ) cout << "Ok after calc_prior_densities ..." << endl;
	calc_objective_function(); if ( verbose == 1 ) cout << "Ok after calc_objective_function ..." << endl;
	// sd_report variables
	if ( last_phase() )
	{
		int refyear = nyr-1;
		calc_spr_reference_points2(refyear, spr_fleet);
		if ( verbose == 1 ) cout << "Ok after calc_spr_reference_points ..." << endl;
		calc_sdreport();
		if ( verbose == 1 ) cout << "Ok after calc_sdreport ..." << endl;
	}
	nf++;
	if ( mceval_phase() )
	{
		write_eval();
	}
	/**
	 * @brief write MCMC stuff
	**/
}

void model_parameters::write_eval(void)
{
	MCout(theta);
	/**
	 * @brief calculate sd_report variables in final phase
	**/
}

void model_parameters::calc_sdreport(void)
{
	sd_log_recruits = log(recruits);
	sd_log_ssb = log(calc_ssb());
	// F(1,nsex,syr,nyr,1,nclass);             ///> Fishing mortality
	for ( int i = syr; i <= nyr-1; i++ )
	{
		sd_fbar(i) = mean(F(1,i));
	}
	sd_rbar = spr_rbar;
	sd_fofl = spr_fofl;
	sd_ofl = spr_cofl;
	//reset_Z_to_M();
  // 	3darray M(1,nsex,syr,nyr,1,nclass);                    ///> Natural mortality
	dvar4_array ftmp(1,nsex,syr,nyr,1,nseason,1,nclass);          ///> Fishing mortality
	ftmp = F;
	F.initialize();
	calc_total_mortality();
	calc_initial_numbers_at_length();
	update_population_numbers_at_length();
	sd_log_dyn_Bzero = log(calc_ssb())(syr+1,nyr);
	sd_log_dyn_Bzero = (sd_log_ssb(syr+1,nyr)) - (sd_log_dyn_Bzero);
	F = ftmp;
	calc_total_mortality();
	calc_initial_numbers_at_length();
	update_population_numbers_at_length();
	/**
	 * @brief Initialize model parameters
	 * @details Set global variable equal to the estimated parameter vectors.
	 *
	 * SM: Note if using empirical growth increment data, then alpha and beta growth parameters should not be estimated. Need to warn the user if the following condition is true:
	 * if( bUseEmpiricalGrowth && ( acitve(alpha) || active(beta) ) )
	**/
}

void model_parameters::initialize_model_parameters(void)
{
	// Get parameters from theta control matrix:
	M0        = theta(1);
	logR0     = theta(2);
	logRini   = theta(3);
	logRbar   = theta(4);
	ra        = theta(5);
	rbeta     = theta(6);
	logSigmaR = theta(7);
	steepness = theta(8);
	rho       = theta(9);
	if ( bInitializeUnfished == 2 )
	{
		for ( int l = 1; l <= nclass; l++ )
		{
			logN0(l) = theta(9+l);
		}
	}
	// init_bounded_number_vector Grwth(1,nGrwth,Grwth_lb,Grwth_ub,Grwth_phz);
	// Get Growth & Molting parameters
	int icnt = 1;
	for ( int h = 1; h <= nsex; h++ )
	{
		// Note that for 2 sexes, the odd numbered rows of "Grwth" are for males, even for females
		alpha(h)   = Grwth(icnt);
		icnt++;
	}
	for ( int h = 1; h <= nsex; h++ )
	{
		beta(h)    = Grwth(icnt);
		icnt++;
	}
	for ( int h = 1; h <= nsex; h++ )
	{
		gscale(h)  = Grwth(icnt);
		icnt++;
	}
	for (int igrow=1;igrow<=nMoltVaries;igrow++)
	{
		for ( int h = 1; h <= nsex; h++ )
		{
	    molt_mu(h,igrow) = Grwth(icnt);
		  icnt++;
	  }
		for ( int h = 1; h <= nsex; h++ )
		{
	    molt_cv(h,igrow) = Grwth(icnt);
		  icnt++;
	  }
	}
	// molt_mu(1,1) = Grwth(7);
	// molt_mu(2,1) = Grwth(8);
	// molt_cv(1,1) = Grwth(9);
	// molt_cv(2,1) = Grwth(10);
	// molt_mu(1,2) = Grwth(11);
	// molt_mu(2,2) = Grwth(12);
	// molt_cv(1,2) = Grwth(13);
	// molt_cv(2,2) = Grwth(14);
	if ( !bUseEmpiricalGrowth )
	{
		alpha = mle_alpha;
		beta  = mle_beta;
	}
	if ( verbose == 1 ) cout << "theta: " << theta << endl;
	/**
	 * @brief Calculate selectivies for each gear.
	 * @author Steve Martell, D'Arcy N. Webber
	 * @details Three selectivities must be accounted for by each fleet.
	 * 1) capture probability, 2) retention probability, and 3) release/discard probability.
	 * Only the parameters for capture probability and retention probability are estimated.
	 * The discard probability is calculated from these two probabilities.
	 *
	 * Maintain the possibility of estimating selectivity independently for each sex; assumes there are data to estimate female selex.
	 *
	 * Psuedocode:
	 *  -# Loop over each gear:
	 *  -# Create a pointer array with length = number of blocks
	 *  -# Based on slx_type, fill pointer with parameter estimates.
	 *  -# Loop over years and block-in the log_selectivity at mid points.
	 *
	 * Need to deprecate the abstract class for selectivity, 7X slower.
	**/
}

void model_parameters::calc_selectivities(void)
{
	int h,i,k;
	dvar_vector pv;
	dvariable p1, p2, p3;
	log_slx_capture.initialize();
	log_slx_discard.initialize();
	log_slx_retaind.initialize();
	dvar_vector temp_slx(1,3);
	int j = 1;
	for ( k = 1; k <= nslx; k++ )
	{
		class gsm::Selex<dvar_vector> *pSLX;
		switch ( slx_type(k) )
		{
			case 0: // parametric
				//pv = elem_div(mfexp(log_slx_pars(k)), 1 + mfexp(log_slx_pars(k)));
				for (i = 1; i <= 3; i++)
				{
					temp_slx(i) = log_slx_pars(j);
					j++;
				}
				//pv = log_slx_pars(j); // NEEDS FIXING
				pv = temp_slx;
				pSLX = new class gsm::ParameterPerClass<dvar_vector>(pv);
			break;
			case 1: // coefficients
				//pv = elem_div(mfexp(log_slx_pars(k)), 1 + mfexp(log_slx_pars(k)));
				pv = log_slx_pars(j);
				pSLX = new class gsm::SelectivityCoefficients<dvar_vector>(pv);
			break;
			case 2: // logistic
				p1 = mfexp(log_slx_pars(j));
				j++;
				p2 = mfexp(log_slx_pars(j));
				j++;
				pSLX = new class gsm::LogisticCurve<dvar_vector,dvariable>(p1,p2);
			break;
			case 3: // logistic95
				p1 = mfexp(log_slx_pars(j));
				j++;
				p2 = mfexp(log_slx_pars(j));
				j++;
				pSLX = new class gsm::LogisticCurve95<dvar_vector,dvariable>(p1,p2);
			break;
			case 4: // double normal
				p1 = mfexp(log_slx_pars(j));
				j++;
				p2 = mfexp(log_slx_pars(j));
				j++;
				p3 = mfexp(log_slx_pars(j));
				j++;
				//pSLX = new class gsm::DoubleNormal<dvar_vector,dvariable>(p1,p2,p3);
			break;
		}
		int h1 = 1;
		int h2 = nsex;
		if ( slx_isex(k) == 1 ) { h2 = 1; } // males only
		if ( slx_isex(k) == 2 ) { h1 = 2; } // females only
		for ( h = h1; h <= h2; h++ )
		{
			for ( i = slx_styr(k); i <= slx_edyr(k); i++ )
			{
				int kk = abs(slx_gear(k)); // gear index
				if ( slx_gear(k) > 0 )
				{
					//log_slx_capture(kk)(h)(i) = pSLX[j]->logSelectivity(mid_points);
					log_slx_capture(kk,h,i) = pSLX->logSelectivity(mid_points);
				} else {
					//log_slx_retaind(kk,h,i) = pSLX[j]->logSelectivity(mid_points);
					log_slx_retaind(kk,h,i) = pSLX->logSelectivity(mid_points);
					log_slx_discard(kk,h,i) = log(1.0 - exp(log_slx_retaind(kk,h,i)) + TINY);
				}
			}
		}
		delete pSLX;
	}
	/**
	 * @brief Calculate fishing mortality rates for each fleet.
	 * @details For each fleet estimate scaler log_fbar and deviates (f_devs). This function calculates the fishing mortality rate including deaths due to discards. Where xi is the discard mortality rate.
	 *
	 * In the event that there is effort data and catch data, then it's possible to estimate a catchability coefficient and predict the catch for the period of missing catch/discard data.  Best option for this would be to use F = q*E, where q = F/E.  Then in the objective function, minimize the variance in the estimates of q, and use the mean q to predict catch. Or minimize the first difference and assume a random walk in q.
	 *
	 * Note also that Jie estimates F for retained fishery, f for male discards and f for female discards. Not recommended to have separate F's for retained and discard fisheries, but might be ok to have sex-specific F's.
	 *
	 * @param log_fbar are the mean fishing mortality of males parameters with dimension (1,nfleet,f_phz)
	 * @param log_fdev are the male fdevs parameters with dimension (1,nfleet,1,nFparams,f_phz)
	 * @param log_foff are the offset to the male fishing mortality parameters with dimension (1,nfleet,foff_phz)
	 * @param log_fdov are the female fdev offset parameters with dimension (1,nfleet,1,nYparams,foff_phz)
	 * @param dmr is the discard mortality rate
	 * @param F is the fishing mortality with dimension (1,nsex,syr,nyr,1,nseason,1,nclass)
	**/
}

void model_parameters::calc_fishing_mortality(void)
{
	int h,i,j,k,ik,yk;
	double xi; // discard mortality rate
	F.initialize();
	ft.initialize();
	dvariable log_ftmp;
	dvar_vector sel(1,nclass);
	dvar_vector ret(1,nclass);
	dvar_vector vul(1,nclass);
	for ( k = 1; k <= nfleet; k++ )
	{
		for ( h = 1; h <= nsex; h++ )
		{
			ik = 1; yk = 1;
			for ( i = syr; i <= nyr; i++ )
			{
				for ( j = 1; j <= nseason; j++ )
				{
					if ( fhit(i,j,k) )
					{
						// Jim notes that this next line results in walking out of an array at log_fdev(k,ik++), 
						// seems fine to me - if we start off with k=1 and ik=1, then log_fdev(k,ik++) returns log_fdev(1,1). After returning that value then ik++ iterates ik so that ik=2. 
						// In what you produced below you've iterated ik out of bounds then tried to evaluate.
						log_ftmp = log_fbar(k) + log_fdev(k,ik++);
						// Jim for checking error...
						//cout << "k=" << k << ", log_fbar(k)=" << log_fbar(k) << ", log_fdev(k,ik-1)=" << log_fdev(k,ik-1) << ", ik=" << ik << ", nFparams(k)=" << nFparams(k) << ", log_fdev(k)=" << log_fdev(k) << endl;
						if ( yhit(i,j,k) )
						{
							log_ftmp += double(h-1) * (log_foff(k) + log_fdov(k,yk++));
						}
						ft(k,h,i,j) = mfexp(log_ftmp);
						xi  = dmr(i,k);                                      // Discard mortality rate
						sel = exp(log_slx_capture(k,h,i));                 // Selectivity
						ret = exp(log_slx_retaind(k,h,i)) * slx_nret(h,k); // Retension
						vul = elem_prod(sel, ret + (1.0 - ret) * xi);        // Vulnerability
						/*if(sum(tmp)==0 || min(tmp) < 0)
						{
							cerr <<"Selectivity vector for gear "<<k<<" is all 0's ";
							cerr <<"Please fix the selectivity controls."<<endl;
							COUT(vul);
							exit(1);
						}
						*/
						F(h,i,j) += ft(k,h,i,j) * vul;
					}
				}
			}
		}
	}
	//cout << "log_fbar" << endl;
	//cout << log_fbar << endl;
	//cout << "log_fdev" << endl;
	//cout << log_fdev << endl;
	//cout << "F" << endl;
	//cout << F << endl;
	//exit(1);
	/**
	 * @brief Compute growth increments
	 * @details Presently based on liner form
	 *
	 * @param vSizes is a vector of doubles of size data from which to compute predicted values
	 * @param iSex is an integer vector indexing sex (1 = male, 2 = female)
	 *
	 * @return dvar_vector of predicted growth increments
	**/
}

dvar_vector model_parameters::calc_growth_increments(const dvector vSizes, const ivector iSex)
{
	{
		if ( vSizes.indexmin() != iSex.indexmin() || vSizes.indexmax() != iSex.indexmax() )
		{
			cerr << "indices don't match..." << endl;
			ad_exit(1);
		}
		RETURN_ARRAYS_INCREMENT();
		dvar_vector pMoltInc(1,vSizes.indexmax());
		pMoltInc.initialize();
		int h,i;
		for ( i = 1; i <= nGrowthObs; i++ )
		{
			h = iSex(i);
			pMoltInc(i) = alpha(h) - beta(h) * vSizes(i);
		}
		RETURN_ARRAYS_DECREMENT();
		return pMoltInc;
	}
	/**
	 * @brief Molt increment as a linear function of pre-molt size.
	 *
	 * TODO: Option for empirical molt increments.
	 *
	 * @param alpha
	 * @param beta
	 * @param mid_points
	 *
	 * @return molt_increment
	**/
}

void model_parameters::calc_growth_increments(void)
{
	int h,l;
	for ( h = 1; h <= nsex; h++ )
	{
		for ( l = 1; l <= nclass; l++ )
		{
			molt_increment(h,l) = alpha(h) - beta(h) * mid_points(l);
		}
	}
	/**
	 * @brief Calclate the growth and size transtion matrix
	 * @details Calculates the size transition matrix for each sex based on growth increments, which is a linear function of the size interval, and the scale parameter for the gamma distribution.  This function does the proper integration from the lower to upper size bin, where the mode of the growth increment is scaled by the scale parameter.
	 *
	 * This function loops over sex, then loops over the rows of the size transition matrix for each sex.  The probability of transitioning from size l to size ll is based on the vector molt_increment and the scale parameter. In all there are three parameters that define the size transition matrix (alpha, beta, scale) for each sex. Issue 112 details some of evolution of code development here
	 *
	 * @param gscale
	 * @param P a 3D array of molting probabilities with dimension (1,nsex,1,nclass,1,nclass)
	**/
}

void model_parameters::calc_growth_transition(void)
{
	int h,l,ll;
	dvariable mean_size_after_molt;
	dvar_vector psi(1,nclass+1);
	dvar_vector sbi(1,nclass+1);
	dvar_matrix gt(1,nclass,1,nclass);
	if ( bUseCustomGrowthMatrix == 2 )
	{
		for ( h = 1; h <= nsex; h++ )
		{
			growth_transition(h) = CustomGrowthMatrix(h);
			size_transition(h) = CustomGrowthMatrix(h);
		}
	} else {
		for ( h = 1; h <= nsex; h++ )
		{
			gt.initialize();
			sbi = size_breaks / gscale(h);
			for ( l = 1; l <= nclass; l++ )
			{
				mean_size_after_molt = (mid_points(l) + molt_increment(h,l)) / gscale(h);
				for ( ll = l; ll <= nclass+1; ll++ )
				{
					if ( ll <= nclass+1 )
					{
						psi(ll) = cumd_gamma(sbi(ll), mean_size_after_molt);
					}
				}
				gt(l)(l,nclass) = first_difference(psi(l,nclass+1));
				gt(l)(l,nclass) = gt(l)(l,nclass) / sum(gt(l));
			}
			if ( bUseCustomGrowthMatrix == 1 )
			{
				growth_transition(h) = CustomGrowthMatrix(h);
			} else {
				growth_transition(h) = gt;
			}
			size_transition(h) = P(h) * growth_transition(h);
			for ( int l = 1; l <= nclass; l++ )
			{
				size_transition(h)(l,l) += value(1.0 - P(h)(l,l));
			}
		}
	}
	/*
	} else if ( bUseCustomGrowthMatrix == 2 ) {
		for ( h = 1; h <= nsex; h++ )
		{
			gt.initialize();
			sbi = size_breaks / gscale(h);
			for ( l = 1; l <= nclass; l++ )
			{
				mean_size_after_molt = (mid_points(l) + molt_increment(h,l)) / gscale(h);
				for ( ll = l; ll <= nclass+1; ll++ )
				{
					if ( ll <= nclass+1 )
					{
						psi(ll) = cumd_gamma(sbi(ll), mean_size_after_molt);
					}
				}
				gt(l)(l,nclass) = first_difference(psi(l,nclass+1));
				gt(l)(l,nclass) = gt(l)(l,nclass) / sum(gt(l));
			}
			if ( bUseCustomGrowthMatrix == 1 )
			{
				growth_transition(h) = CustomGrowthMatrix(h);
			} else {
				growth_transition(h) = gt;
			}
			size_transition(h) = P(h) * growth_transition(h);
			for ( int l = 1; l <= nclass; l++ )
			{
				size_transition(h)(l,l) += value(1.0 - P(h)(l,l));
			}
		}
	*/
	/**
	 * @brief Calculate natural mortality array
	 * @details Natural mortality (M) is a 3d array for sex, year and size.
	 *
	 * todo: Size-dependent mortality
	**/
}

void model_parameters::calc_natural_mortality(void)
{
	M.initialize();
	for ( int h = 1; h <= nsex; h++ )
	{
		M(h) = M0;
	}
	// Add random walk to natural mortality rate
	if ( active(m_dev) )
	{
		dvar_vector delta(syr+1,nyr);
		delta.initialize();
		switch( m_type )
		{
			// case 0 not here as this is not evaluated if m_dev is not active
			case 1: // random walk in natural mortality
				delta = m_dev.shift(syr+1);
			break;
			case 2: // cubic splines
			{
				dvector iyr = (m_nodeyear - syr) / (nyr - syr);
				dvector jyr(syr+1,nyr);
				jyr.fill_seqadd(0, 1.0 / (nyr - syr - 1));
				vcubic_spline_function csf(iyr, m_dev);
				delta = csf(jyr);
			}
			break;
			case 3: // Specific break points
				for ( int idev = 1; idev <= nMdev; idev++ )
				{
					delta(m_nodeyear(idev)) = m_dev(idev);
				}
			break;
			// Modifying by Jie Zheng for specific time blocks
			case 4: // time blocks
				for ( int idev = 1; idev <= nMdev; idev++ )
				{
					// Is this syntax for split sex?
					for ( int i = m_nodeyear(1+(idev-1)*2); i <= m_nodeyear(2+(idev-1)*2); i++ )
					{
						delta(i) = m_dev(idev);
						for ( int h = 1; h <= nsex; h++ )
						{
							M(h)(i) = mfexp(m_dev(idev));
						}
					}
				}
			break;
			// Case for specific years
			case 5: // time blocks
				for ( int idev = 1; idev <= nMdev; idev++ )
				{
					delta(m_nodeyear(idev)) = m_dev(idev);
				}
				for ( int h = 1; h <= nsex; h++ )
				{
					for ( int i = syr+1; i <= nyr; i++ )
					{
						M(h)(i) = M(h)(syr) * mfexp(delta(i)); // Deltas are devs from base value (not a walk)
					}
				}
			break;
		}
		// Update M by year.
		if ( m_type < 4 )
		{
			//for ( int h = 1; h <= nsex; h++ )
			//{
				for ( int i = syr+1; i <= nyr; i++ )
				{
					M(1)(i) = M(1)(i-1) * mfexp(delta(i));
				}
			//}
		}
	}
	if ( active(m_dev_females) && nsex > 1)
	{
		dvar_vector delta(syr+1,nyr);
		delta.initialize();
		switch( m_type )
		{
			// case 0 not here as this is not evaluated if m_dev is not active
			case 1: // random walk in natural mortality
				delta = m_dev_females.shift(syr+1);
			break;
			case 2: // cubic splines
			{
				dvector iyr = (m_nodeyear_females - syr) / (nyr - syr);
				dvector jyr(syr+1,nyr);
				jyr.fill_seqadd(0, 1.0 / (nyr - syr - 1));
				vcubic_spline_function csf(iyr, m_dev);
				delta = csf(jyr);
			}
			break;
			case 3: // Specific break points
				for ( int idev = 1; idev <= nMdev_females; idev++ )
				{
					delta(m_nodeyear_females(idev)) = m_dev_females(idev);
				}
			break;
			// Modifying by Jie Zheng for specific time blocks
			case 4: // time blocks
				for ( int idev = 1; idev <= nMdev_females; idev++ )
				{
					// Is this syntax for split sex?
					for ( int i = m_nodeyear_females(1+(idev-1)*2); i <= m_nodeyear_females(2+(idev-1)*2); i++ )
					{
						delta(i) = m_dev_females(idev);
						for ( int h = 1; h <= nsex; h++ )
						{
							M(h)(i) = mfexp(m_dev_females(idev));
						}
					}
				}
			break;
			// Case for specific years
			case 5: // time blocks
				for ( int idev = 1; idev <= nMdev_females; idev++ )
				{
					delta(m_nodeyear_females(idev)) = m_dev_females(idev);
				}
				for ( int h = 1; h <= nsex; h++ )
				{
					for ( int i = syr+1; i <= nyr; i++ )
					{
						M(h)(i) = M(h)(syr) * mfexp(delta(i)); // Deltas are devs from base value (not a walk)
					}
				}
			break;
		}
		// Update M by year.
		if ( m_type < 4 )
		{
			for ( int i = syr+1; i <= nyr; i++ )
			{
				M(2)(i) = M(2)(i-1) * mfexp(delta(i));
			}
		}
	}
	// Custom natural mortality input
	if ( bUseCustomNaturalMortality == 1 )
	{
		for ( int h = 1; h <= nsex; h++ )
		{
			for ( int i = syr; i <= nyr; i++ )
			{
				M(h)(i) = CustomNaturalMortality(h)(i);
			}
		}
	}
	/**
	 * @brief Calculate total instantaneous mortality rate and survival rate
	 * @details \f$ S = exp(-Z) \f$
	 *
	 * ISSUE, for some reason the diagonal of S goes to NAN if linear growth model is used. Due to F.
	 *
	 * @param m_prop is a vector specifying the proportion of natural mortality (M) to be applied each season
	 * @return NULL
	**/
}

void model_parameters::calc_total_mortality(void)
{
	Z.initialize();
	S.initialize();
	for ( int h = 1; h <= nsex; h++ )
	{
		for ( int i = syr; i <= nyr; i++ )
		{
			for ( int j = 1; j <= nseason; j++ )
			{
				Z(h)(i)(j) = (m_prop(i)(j) * M(h)(i)) + F(h)(i)(j);
				for ( int l = 1; l <= nclass; l++ )
				{
					S(h,i,j)(l,l) = mfexp(-Z(h,i,j)(l));
				}
			}
		}
	}
	//if ( verbose == 1 ) COUT(S);
	/**
	 * @brief Calculate total instantaneous mortality rate and survival rate for dynamic Bzero
	 * @details \f$ S = exp(-Z) \f$
	 *
	 * @param m_prop is a vector specifying the proportion of natural mortality (M) to be applied each season
	 * @return NULL
	**/
}

void model_parameters::reset_Z_to_M(void)
{
	Z.initialize();
	S.initialize();
	for ( int h = 1; h <= nsex; h++ )
	{
		for ( int i = syr; i <= nyr; i++ )
		{
			for ( int j = 1; j <= nseason; j++ )
			{
				Z(h,i,j) = m_prop(i,j) * M(h,i);
				for ( int l = 1; l <= nclass; l++ )
				{
					S(h,i,j)(l,l) = mfexp(-Z(h)(i)(j)(l));
				}
			}
		}
	}
	/**
	 * @brief Calculate the probability of moulting by carapace width.
	 * @details Note that the parameters molt_mu and molt_cv can only be estimated in cases where there is new shell and old shell data. Note that the diagonal of the P matrix != 0, otherwise the matrix is singular in inv(P).
	 *
	 * @param molt_mu is the mean of the distribution
	 * @param molt_cv scales the variance of the distribution
	**/
}

void model_parameters::calc_molting_probability(void)
{
	molt_probability.initialize();
	P.initialize();
	double tiny = 0.000;
	for (int igrow=1;igrow<=nMoltVaries;igrow++)
	{
		for ( int h = 1; h <= nsex; h++ )
		{
		  dvariable mu = molt_mu(h,igrow);
		  dvariable sd = mu * molt_cv(h,igrow);
			for ( int i = syr; i <= nyr; i++ )
			{
				if ( igrow>1 && i >= iYrsMoltChanges(igrow-1) ) 
				{
					mu = molt_mu(h,igrow);
					sd = mu * molt_cv(h,igrow);
				} 
				molt_probability(h)(i) = 1.0 - ((1.0 - 2.0 * tiny) * plogis(mid_points, mu, sd) + tiny);
				for ( int l = 1; l <= nclass; l++ )
				{
					P(h,l,l) = molt_probability(h,i,l);
				}
			}
		}
	}
	/**
	 * @brief calculate size distribution for new recuits.
	 * @details Based on the gamma distribution, calculates the probability of a new recruit being in size-interval size.
	 *
	 * @param ra is the mean of the distribution
	 * @param rbeta scales the variance of the distribution
	 * @return rec_sdd the recruitment size distribution vector
	**/
}

void model_parameters::calc_recruitment_size_distribution(void)
{
	dvariable ralpha = ra / rbeta;
	dvar_vector x(1,nclass+1);
	for ( int l = 1; l <= nclass+1; l++ )
	{
		x(l) = cumd_gamma(size_breaks(l) / rbeta, ralpha);
	}
	rec_sdd = first_difference(x);
	rec_sdd /= sum(rec_sdd); // Standardize so each row sums to 1.0
	/**
	 * @brief initialiaze populations numbers-at-length in syr
	 * @author Steve Martell
	 * @details This function initializes the populations numbers-at-length in the initial year of the model.
	 *
	 * Psuedocode: See note from Dave Fournier.
	 *
	 * For the initial numbers-at-length a vector of deviates is estimated, one for each size class, and have the option to initialize the model at unfished equilibrium, or some other steady state condition.
	 *
	 *  Dec 11, 2014. Martell & Ianelli at snowgoose.  We had a discussion regarding how to deal with the joint probability of molting and growing to a new size
	 *  interval for a given length, and the probability of not molting.  We settled on using the size-tranistion matrix to represent this joint probability, where the diagonal of the matrix to represent the probability of surviving and molting to a new size interval. The upper diagonal of the size-transition matrix represent the probability of growing to size interval j' given size interval j.
	 *
	 *  Oldshell crabs are then the column vector of 1-molt_probabiltiy times the numbers-at-length, and the Newshell crabs is the column vector of molt_probability times the number-at-length.
	 *
	 *  Jan 1, 2015.  Changed how the equilibrium calculation is done. Use a numerical approach to solve the newshell oldshell initial abundance.
	 *
	 *  Jan 3, 2015.  Working with John Levitt on analytical solution instead of the numerical approach.  Think we have a soln.
	 *
	 *  Notation:
	 *      n = vector of newshell crabs
	 *      o = vector of oldshell crabs
	 *      P = diagonal matrix of molting probabilities by size
	 *      S = diagonal matrix of survival rates by size
	 *      A = Size transition matrix.
	 *      r = vector of new recruits (newshell)
	 *      I = identity matrix.
	 *
	 *  The following equations represent the dynamics of newshell and oldshell crabs.
	 *      n = nSPA + oSPA + r                     (1)
	 *      o = oS(I-P)A + nS(I-P)A                 (2)
	 *  Objective is to solve the above equations for n and o repsectively. Starting with o:
	 *      o = n(I-P)S[I-(I-P)S]^(-1)              (3)
	 *  next substitute (3) into (1) and solve for n
	 *      n = nPSA + n(I-P)S[I-(I-P)S]^(-1)PSA + r
	 *  let B = [I-(I-P)S]^(-1)
	 *      n - nPSA - n(I-P)SBPSA = r
	 *      n(I - PSA - (I-P)SBPSA) = r
	 *  let C = (I - PSA - (I-P)SBPSA)
	 *  then n = C^(-1) r                           (4)
	 *
	 *  April 28, 2015. There is no case here for initializing the model at unfished equilibrium conditions. Need to fix this for SRA purposes. SJDM.
	 *
	 * @param bInitializeUnfished
	 * @param logR0
	 * @param logRini
	 * @param rec_sdd is the vector of recruitment size proportions. It has dimension (1,nclass)
	 * @param rec_ini is the vector of initial size deviations. It has dimension (1,nclass)
	 * @param M is a 3D array of the natural mortality. It has dimension (1,nsex,syr,nyr,1,nclass)
	 * @param S is a 5D array of the survival rate (where S=exp(-Z)). It has dimension (1,nsex,syr,nyr,1,nseason,1,nclass,1,nclass)
	 * @param d4_N is the numbers in each group (sex/maturity/shell), year, season and length. It has dimension (1,n_grp,syr,nyr+1,1,nseason,1,nclass)
	**/
}

void model_parameters::calc_initial_numbers_at_length(void)
{
	dvariable log_initial_recruits;
	d3_newShell.initialize();
	d3_oldShell.initialize();
	// Initial recruitment
	switch( bInitializeUnfished )
	{
		case 0: // Unfished conditions
			log_initial_recruits = logR0;
		break;
		case 1: // Steady-state fished conditions
			log_initial_recruits = logRini;
		break;
		case 2: // Free parameters
			log_initial_recruits = logN0(1);
		break;
	}
	for ( int h = 1; h <= nsex; h++ )
	{
		recruits(h)(syr) = mfexp(log_initial_recruits);
	}
	//dvar_vector rt = 1.0 / nsex * recruits(h)(syr) * rec_sdd;
	// Analytical equilibrium soln
	int ig;
	d4_N.initialize();
	dmatrix Id = identity_matrix(1,nclass);
	dvar_matrix  x(1,n_grp,1,nclass);
	dvar_vector  y(1,nclass);
	dvar_matrix  A(1,nclass,1,nclass);
	dvar_matrix _S(1,nclass,1,nclass);
	_S.initialize();
	//for ( int h = 1; h <= nsex; h++ )
	//{
		//A = growth_transition(h); // 2016-04-29 I THINK THIS OUGHT TO BE size_transition??
		switch( bInitializeUnfished )
		{
			case 0: // Unfished conditions
				//cout << "The unfished conditions options is broke!" << endl; exit(1);
				//for ( int i = 1; i <= nclass; i++ )
				//{
				//	_S(i,i) = mfexp(-M(h)(syr)(i));
				//}
				// Single shell condition
				if ( nshell == 1 && nmature == 1 )
				{
					x = calc_brute_equilibrium();
					for ( int ig = 1; ig <= n_grp; ig++ )
					{
						d4_N(ig)(syr)(1) = x(ig);
					}
					// SHOULD I ADD REC_INI TO THIS NOW?
					//calc_equilibrium(x,A,_S,rt);
					//ig = pntr_hmo(h,1,1);
					//x = calc_brute_equilibrium();
					//d4_N(1,n_grp)(syr)(1) = x;
					//d4_N(ig)(syr)(1) = elem_prod(x, mfexp(rec_ini));
				}
				// Continuous molt (newshell/oldshell)
				if ( nshell == 2 && nmature == 1 )
				{
					//ig = pntr_hmo(h,1,1);
					x = calc_brute_equilibrium();
					for ( int ig = 1; ig <= n_grp; ig++ )
					{
						d4_N(ig)(syr)(1) = x(ig);
					}
					//calc_equilibrium(x,y,A,_S,P(h),rt);
					//ig = pntr_hmo(h,1,1);
					//d4_N(ig)(syr)(1) = elem_prod(x, mfexp(rec_ini));;
					//d4_N(ig+1)(syr)(1) = elem_prod(y, mfexp(rec_ini));;
				}
				// Insert terminal molt case here.
			break;
			case 1: // Steady-state fished conditions
				//cout << "The steady-state fished conditions options is broke!" << endl; exit(1);
				// Single shell condition
				if ( nshell == 1 && nmature == 1 )
				{
					x = calc_brute_equilibrium();
					for ( int ig = 1; ig <= n_grp; ig++ )
					{
						d4_N(ig)(syr)(1) = x(ig);
					}
					// SHOULD I ADD REC_INI TO THIS NOW?
					//calc_equilibrium(x,A,_S,rt);
					//ig = pntr_hmo(h,1,1);
					//x = calc_brute_equilibrium();
					//d4_N(1,n_grp)(syr)(1) = x;
					//d4_N(ig)(syr)(1) = elem_prod(x, mfexp(rec_ini));
				}
				// Continuous molt (newshell/oldshell)
				if ( nshell == 2 && nmature == 1 )
				{
					//ig = pntr_hmo(h,1,1);
					x = calc_brute_equilibrium();
					for ( int ig = 1; ig <= n_grp; ig++ )
					{
						d4_N(ig)(syr)(1) = elem_prod(x(ig), mfexp(rec_ini));
					}
					//calc_equilibrium(x,y,A,_S,P(h),rt);
					//ig = pntr_hmo(h,1,1);
					//d4_N(ig)(syr)(1) = elem_prod(x, mfexp(rec_ini));;
					//d4_N(ig+1)(syr)(1) = elem_prod(y, mfexp(rec_ini));;
				}				//_S = S(h)(syr)(1);
				// Single shell condition
				if ( nshell == 1 && nmature == 1 )
				{
					//calc_equilibrium(x,A,_S,rt);
					//ig = pntr_hmo(h,1,1);
					//d4_N(ig)(syr)(1) = elem_prod(x, mfexp(rec_ini));
				}
				// Continuous molt (newshell/oldshell)
				if ( nshell == 2 && nmature == 1 )
				{
					//calc_equilibrium(x,y,A,_S,P(h),rt);
					//ig = pntr_hmo(h,1,1);
					//d4_N(ig)(syr)(1) = elem_prod(x, mfexp(rec_ini));;
					//d4_N(ig+1)(syr)(1) = elem_prod(y, mfexp(rec_ini));;
				}
				// Insert terminal molt case here.
			break;
			case 2: // Free parameters
				//calc_equilibrium(x,A,_S,rt);
				//ig = pntr_hmo(h,1,1);
				//d4_N(ig)(syr)(1) = elem_prod(x, mfexp(rec_ini));
				//cout << "Unfished: " << d4_N(ig)(syr)(1) << endl;
				//_S = S(h)(syr)(1);
				//calc_equilibrium(x,A,_S,rt);
				//ig = pntr_hmo(h,1,1);
				//d4_N(ig)(syr)(1) = elem_prod(x, mfexp(rec_ini));
				//cout << "Fished: " << d4_N(ig)(syr)(1) << endl;
				// Single shell condition
				if ( nshell == 1 && nmature == 1 )
				{
					int h=1;
					int ig = pntr_hmo(h,1,1);
					d4_N(ig)(syr)(1) = mfexp(logN0);
				}
				//cout << "Free: " << d4_N(ig)(syr)(1) << endl;
				//cout << "Brute: " << calc_brute_equilibrium() << endl;
				// Continuous molt (newshell/oldshell)
				if ( nshell == 2 && nmature == 1 )
				{
					//ig = pntr_hmo(h,1,1);
					//d4_N(ig)(syr)(1) = elem_prod(x, mfexp(rec_ini));;
					//d4_N(ig+1)(syr)(1) = elem_prod(y, mfexp(rec_ini));;
				}
				// Insert terminal molt case here.
			break;
		}
		//if ( verbose == 1 ) COUT(x);
		//if ( verbose == 1 ) COUT(y);
	//}
	if ( verbose == 1 ) 
	{
		for ( int h = 1; h <= nsex; h++ )
		{
			COUT(P(h));
		}
		for ( int ig = 1; ig <= n_grp; ig++ )
		{
			COUT(d4_N(ig)(syr)(1));
		}
	}
	//d4_N(ig)(syr)(1) = x(ig);
    /*
	// male newshell
    d4_N(1)(syr)(1)(1) = 27987700;
    d4_N(1)(syr)(1)(2) = 28795300;
    d4_N(1)(syr)(1)(3) = 14848500;
    d4_N(1)(syr)(1)(4) = 16048300;
    d4_N(1)(syr)(1)(5) = 13312600;
    d4_N(1)(syr)(1)(6) = 11007400;
    d4_N(1)(syr)(1)(7) = 11088900;
    d4_N(1)(syr)(1)(8) = 8969550;
    d4_N(1)(syr)(1)(9) = 9684750;
    d4_N(1)(syr)(1)(10) = 11032400;
    d4_N(1)(syr)(1)(11) = 9030270;
    d4_N(1)(syr)(1)(12) = 9403100;
    d4_N(1)(syr)(1)(13) = 8644670;
    d4_N(1)(syr)(1)(14) = 8526260;
    d4_N(1)(syr)(1)(15) = 7705410;
    d4_N(1)(syr)(1)(16) = 6804960;
    d4_N(1)(syr)(1)(17) = 5640800;
    d4_N(1)(syr)(1)(18) = 4001730;
    d4_N(1)(syr)(1)(19) = 2343550;
    d4_N(1)(syr)(1)(20) = 2292990;
	// male oldshell
	d4_N(2)(syr)(1) = 0.0001;
	// females newshell
    d4_N(3)(syr)(1)(1) = 45234000;
    d4_N(3)(syr)(1)(2) = 40950300;
    d4_N(3)(syr)(1)(3) = 39428100;
    d4_N(3)(syr)(1)(4) = 33387700;
    d4_N(3)(syr)(1)(5) = 31708300;
    d4_N(3)(syr)(1)(6) = 20033100;
    d4_N(3)(syr)(1)(7) = 13834700;
    d4_N(3)(syr)(1)(8) = 10330000;
    d4_N(3)(syr)(1)(9) = 8845460;
    d4_N(3)(syr)(1)(10) = 7000700;
    d4_N(3)(syr)(1)(11) = 3895850;
    d4_N(3)(syr)(1)(12) = 3524640;
    d4_N(3)(syr)(1)(13) = 2660370;
    d4_N(3)(syr)(1)(14) = 1073200;
    d4_N(3)(syr)(1)(15) = 1053050;
    d4_N(3)(syr)(1)(16) = 2061060;
    d4_N(3)(syr)(1)(17) = 0;
    d4_N(3)(syr)(1)(18) = 0;
    d4_N(3)(syr)(1)(19) = 0;
    d4_N(3)(syr)(1)(20) = 0;
	// female oldshell
	d4_N(4)(syr)(1) = 0.0001;
	// male newshell
    d4_N(1)(syr)(1)(1) = 27162400;
    d4_N(1)(syr)(1)(2) = 28113900;
    d4_N(1)(syr)(1)(3) = 14580300;
    d4_N(1)(syr)(1)(4) = 15833800;
    d4_N(1)(syr)(1)(5) = 13186000;
    d4_N(1)(syr)(1)(6) = 10927400;
    d4_N(1)(syr)(1)(7) = 11024700;
    d4_N(1)(syr)(1)(8) = 8936730;
    d4_N(1)(syr)(1)(9) = 9664040;
    d4_N(1)(syr)(1)(10) = 11022500;
    d4_N(1)(syr)(1)(11) = 9009240;
    d4_N(1)(syr)(1)(12) = 9327550;
    d4_N(1)(syr)(1)(13) = 8537520;
    d4_N(1)(syr)(1)(14) = 8354120;
    d4_N(1)(syr)(1)(15) = 7403640;
    d4_N(1)(syr)(1)(16) = 6428180;
    d4_N(1)(syr)(1)(17) = 5310070;
    d4_N(1)(syr)(1)(18) = 3752060;
    d4_N(1)(syr)(1)(19) = 2157450;
    d4_N(1)(syr)(1)(20) = 2059100;
	// male oldshell
	d4_N(2)(syr)(1) = 0.0001;
	// females newshell
    d4_N(3)(syr)(1)(1) = 42928800;
    d4_N(3)(syr)(1)(2) = 38964600;
    d4_N(3)(syr)(1)(3) = 37577200;
    d4_N(3)(syr)(1)(4) = 31883000;
    d4_N(3)(syr)(1)(5) = 30353900;
    d4_N(3)(syr)(1)(6) = 19281000;
    d4_N(3)(syr)(1)(7) = 13370300;
    d4_N(3)(syr)(1)(8) = 10002700;
    d4_N(3)(syr)(1)(9) = 8592430;
    d4_N(3)(syr)(1)(10) = 6807350;
    d4_N(3)(syr)(1)(11) = 3773530;
    d4_N(3)(syr)(1)(12) = 3414650;
    d4_N(3)(syr)(1)(13) = 2561850;
    d4_N(3)(syr)(1)(14) = 1012200;
    d4_N(3)(syr)(1)(15) = 982444;
    d4_N(3)(syr)(1)(16) = 1904020;
    d4_N(3)(syr)(1)(17) = 0;
    d4_N(3)(syr)(1)(18) = 0;
    d4_N(3)(syr)(1)(19) = 0;
    d4_N(3)(syr)(1)(20) = 0;
	// female oldshell
	d4_N(4)(syr)(1) = 0.0001;
	*/
	
	/**
	 * @brief Update numbers-at-length
	 * @author Team
	 * @details Numbers at length are propagated each year for each sex based on the size transition matrix and a vector of size-specifc survival rates. The columns of the size-transition matrix are multiplied by the size-specific survival rate (a scalar). New recruits are added based on the estimated average recruitment and annual deviate, multiplied by a vector of size-proportions (rec_sdd).
	 *
	 * @param bInitializeUnfished
	 * @param logR0
	 * @param logRbar
	 * @param d4_N is the numbers in each group (sex/maturity/shell), year, season and length. It has dimension (1,n_grp,syr,nyr+1,1,nseason,1,nclass)
	 * @param recruits is the vector of average recruits each year. It has dimension (syr,nyr)
	 * @param rec_dev is an init_bounded_dev_vector of recruitment deviation parameters. It has dimension (syr+1,nyr,-7.0,7.0,rdv_phz)
	 * @param rec_sdd is the vector of recruitment size proportions. It has dimension (1,nclass)
	**/
}

void model_parameters::update_population_numbers_at_length(void)
{
	int h,i,ig,o,m;
	dmatrix Id = identity_matrix(1,nclass);
	dvar_vector rt(1,nclass);
	dvar_vector  x(1,nclass);
	dvar_vector  y(1,nclass);
	dvar_vector  z(1,nclass);
	
	dvar_matrix t1(1,nclass,1,nclass);
	dvar_matrix  A(1,nclass,1,nclass);
	dvar_matrix At(1,nclass,1,nclass);
	//switch( bInitializeUnfished )
	//{
	//	case 0: // Unfished conditions
	//		log_initial_recruits = logR0;
	//	break;
	//	case 1: // Steady-state fished conditions
	//		log_initial_recruits = logRini;
	//	break;
	//	case 2: // Free parameters
	//		//log_initial_recruits = logRini;
	//		log_initial_recruits = logN0(1); // only for SMBKC
	//	break;
	//}
	//if ( bInitializeUnfished == 0 )
	//{
	//	recruits(syr+1,nyr) = mfexp(logR0);
	//} else {
	//	recruits(syr+1,nyr) = mfexp(logRbar);
	//}
	//recruits(syr,nyr) = mfexp(logRbar);
	// this is what should be used because recruitment is not always during the first season (i.e. during the initial conditions)
	for ( i = syr; i <= nyr; i++ )
	{
		for ( h = 1; h <= nsex; h++ )
		{
			if ( bInitializeUnfished == 0 )
			{
				recruits(h)(i) = mfexp(logR0);
			} else {
				recruits(h)(i) = mfexp(logRbar);
			}
			// This splits recruitment out proportionately into males and females
			if (h ==1) recruits(h)(i) *= mfexp(rec_dev(i)) * 1 / (1 + mfexp(-logit_rec_prop(i)));
			if (h ==2) recruits(h)(i) *= mfexp(rec_dev(i)) * (1 - 1 / (1 + mfexp(-logit_rec_prop(i))));
		}
	}
	for ( i = syr; i <= nyr; i++ )
	{
		// if ( i > syr )
		//{
		//recruits(i) *= mfexp(rec_dev(i));
		//}
		//rt = (1.0 / nsex * recruits(i)) * rec_sdd;
		//rt = recruits(i) * rec_sdd;
		//rtf = recruitsf(i) * rec_sdd;
		for ( int j = 1; j <= nseason; j++ )
		{
			for ( ig = 1; ig <= n_grp; ig++ )
			{
				h = isex(ig);
				m = imature(ig);
				o = ishell(ig);
				if ( nshell == 1 )
				{
					//if ( verbose == 1 ) cout << "Single shell type dynamics" << endl;
					x = d4_N(ig)(i)(j);
					// Mortality (natural and fishing)
					x = x * S(h)(i)(j);
					// Molting and growth
					if (j == season_growth)
					{
						x = x * size_transition(h);
					}
					// Recruitment
					if (j == season_recruitment)
					{
						x += recruits(h)(i) * rec_sdd;
						//if (h == 1) x += recruits(h)(i) * mfexp(rec_dev(i)) * rec_prop(i) * rec_sdd;
						//if (h == 2) x += recruits(h)(i) * mfexp(rec_dev(i)) * (1 - rec_prop(i)) * rec_sdd;
					}
					if (j == nseason)
					{
						if (i != nyr)
						{
							d4_N(ig)(i+1)(1) = x;
						}
					} else {
						d4_N(ig)(i)(j+1) = x;
					}
				} else {
					//if ( verbose == 1 ) cout << "Multiple shell type dynamics" << endl;
					if ( o == 1 ) // newshell
					{
						x = d4_N(ig)(i)(j);
						// Mortality (natural and fishing)
						x = x * S(h)(i)(j);
						//cout << x << endl << endl;
						//cout << sum(x) << endl;
						// Molting and growth
						if (j == season_growth)
						{
							y = elem_prod(x, 1 - molt_probability(h)(i)); // did not molt, become oldshell
							x = elem_prod(x, molt_probability(h)(i)) * growth_transition(h); // molted and grew, stay newshell
						}
						//cout << diagonal(P(h)) << endl;
						//cout << 1-diagonal(P(h)) << endl << endl;
						//cout << "x: " << x << endl;
						//cout << "y: " << y << endl << endl;
						//cout << x+y << endl;
						//cout << sum(x+y) << endl;
						//exit(1);
						// Recruitment
						if (j == season_recruitment)
						{
							//if (h == 1) x += recruits(h)(i) * mfexp(rec_dev(i)) * rec_prop(i) * rec_sdd;
							//if (h == 2) x += recruits(h)(i) * mfexp(rec_dev(i)) * (1 - rec_prop(i)) * rec_sdd;
							x += recruits(h)(i) * rec_sdd;
							//x += recruits(h)(i) * mfexp(rec_dev(h)(i));
							//if (h==1) x += rt;
							//if (h==2) x += rtf;
						}
						if (j == nseason)
						{
							if (i != nyr)
							{
								d4_N(ig)(i+1)(1) = x;
							}
						} else {
							d4_N(ig)(i)(j+1) = x;
						}
					}
					if ( o == 2 ) // oldshell
					{
						//d4_N(ig)(i)(j) = x * (1 - P(h));
						//y  = d3_N(ig-1)(i);
						//t1 = (Id - P(h)) * S(h)(i);
						//x = d3_N(ig)(i)(j);
						// add oldshell non-terminal molts to newshell
						//d3_N(ig-1)(i+1)(j) += elem_prod(x,diagonal(P(h)));
						// oldshell
						//d3_N(ig)(i+1) = (x+d3_N(ig-1)(i)) * t1;
						// add oldshell non-terminal molts to newshell
						x = d4_N(ig)(i)(j);
						// Mortality (natural and fishing)
						x = x * S(h)(i)(j);
						// Molting and growth
						z.initialize();
						if (j == season_growth)
						{
							z = elem_prod(x, molt_probability(h)(i)) * growth_transition(h); // molted and grew, become newshell
							x = elem_prod(x, 1 - molt_probability(h)(i)) + y; // did not molt, remain oldshell and add the newshell that become oldshell
						}
						if (j == nseason)
						{
							if (i != nyr)
							{
								d4_N(ig-1)(i+1)(1) += z;
								d4_N(ig)(i+1)(1) = x;
							}
						} else {
							d4_N(ig-1)(i)(j+1) += z;
							d4_N(ig)(i)(j+1) = x;
						}
						//if (j == nseason && j == season_growth)
						//{
						//	d4_N(ig-1)(i+1)(1) = x;
						//} else if (j != nseason && j == season_growth) {
						//	d4_N(ig-1)(i)(j+1) = x;
						//} else if (j == nseason && j != season_growth) {
						//	d4_N(ig)(i+1)(j) = x;
						//} else {
						//	d4_N(ig)(i)(j+1) = x;
						//}
						// oldshell
						//y = d4_N(ig)(i)(j) + d4_N(ig-1)(i)(j);
						// Mortality
						//y = y * S(h)(i)(j);
						// Molting and growth
						//if (j == season_growth)
						//{
						//	y = y * size_transition(h);
						//}
						//if (j == 3) y = y * (Id - P(h));
						// MOLTING NOT DONE FOR BBRKC
						//if (j == nseason)
						//{
						//	d4_N(ig-1)(i+1)(1) = y;
						//} else {
						//	d4_N(ig-1)(i)(j+1) = y;
						//}
					}
				}
				if ( o == 1 && m == 2 ) // terminal molt to new shell.
				{
				}
				if ( o == 2 && m == 2 ) // terminal molt newshell to oldshell.
				{
				}
			}
		}
		//if (i == syr+2) exit(1);
	}
	/**
	 * @brief Calculate stock recruitment relationship.
	 * @details  Assuming a Beverton-Holt relationship between the mature biomass (user defined) and the annual recruits. Note that we derive so and bb in R = so MB / (1 + bb * Mb) from Ro and steepness (leading parameters defined in theta).
	 *
	 * NOTES: if nSRR_flag == 1 then use a Beverton-Holt model to compute the recruitment deviations for minimization.
	**/
}

void model_parameters::calc_stock_recruitment_relationship(void)
{
	dvariable so, bb;
	dvariable ro = mfexp(logR0);
	dvariable phiB;
	dvariable reck = 4.*steepness/(1.-steepness);
	dvar_matrix _A(1,nclass,1,nclass);
	dvar_matrix _S(1,nclass,1,nclass);
	_A.initialize();
	_S.initialize();
	// get unfished mature male biomass per recruit.
	phiB = 0.0;
	for( int h = 1; h <= nsex; h++ )
	{
		for ( int l = 1; l <= nclass; ++l )
		{
			_S(l,l) = mfexp(-M(h)(syr)(l));
		}
		_A = growth_transition(h);
		dvar_vector x(1,nclass);
		dvar_vector y(1,nclass);
		double lam;
		h <= 1 ? lam = spr_lambda: lam = (1.0 - spr_lambda);
		// Single shell condition
		if ( nshell == 1 && nmature == 1 )
		{
			calc_equilibrium(x,_A,_S,rec_sdd);
			phiB += lam * x * elem_prod(mean_wt(h)(syr), maturity(h));
		}
		// Continuous molt (newshell/oldshell)
		if ( nshell == 2 && nmature == 1 )
		{
			calc_equilibrium(x,y,_A,_S,P(h),rec_sdd);
			phiB += lam * x * elem_prod(mean_wt(h)(syr), maturity(h)) +  lam * y * elem_prod(mean_wt(h)(syr), maturity(h));
		}
		// Insert terminal molt case here
	}
	dvariable bo = ro * phiB;
	so = reck * ro / bo;
	bb = (reck - 1.0) / bo;
	dvar_vector ssb = calc_ssb().shift(syr+1);
	dvar_vector rhat = elem_div(so * ssb , 1.0 + bb* ssb);
	
	// residuals
	int byr = syr + 1;
	res_recruit.initialize();
	dvariable sigR = mfexp(logSigmaR);
	dvariable sig2R = 0.5 * sigR * sigR;
	switch ( nSRR_flag )
	{
		case 0: // NO SRR
			//res_recruit(syr) = log(recruits(syr)) - logRbar;
			res_recruit(byr,nyr) = log(recruits(1)(byr,nyr)) - (1.0-rho) * logRbar - rho * log(++recruits(1)(byr-1,nyr-1)) + sig2R;
		break;
		case 1: // SRR model
			//xi(byr,nyr) = log(recruits(byr,nyr)) - log(rhat(byr,nyr)) + sig2R;
			res_recruit(byr,nyr) = log(recruits(1)(byr,nyr)) - (1.0-rho) * log(rhat(byr,nyr)) - rho * log(++recruits(1)(byr-1,nyr-1)) + sig2R;
		break;
	}
	
	/**
	 * @brief Calculate predicted catch observations
	 * @details The function uses the Baranov catch equation to predict the retained and discarded catch.
	 *
	 * Assumptions:
	 *  1) retained (landed catch) is assume to be newshell male only.
	 *  2) discards are all females (new and old) and male only crab.
	 *  3) Natural and fishing mortality occur simultaneously.
	 *  4) discard is the total number of crab caught and discarded.
	**/
}

void model_parameters::calc_predicted_catch(void)
{
	int h,i,j,k,ig,type,unit,nhit;
	double cobs, effort;
	pre_catch.initialize();
	res_catch.initialize();
	log_q_catch.initialize();
	dvariable tmp_ft;
	dvar_vector sel(1,nclass);
	dvar_vector nal(1,nclass); // numbers or biomass at length.
    // First need to calculate a catchability (q) for each catch data frame if there is any catch and effort (must be both)
	for ( int kk = 1; kk <= nCatchDF; kk++ )
	{
		nhit = 0;
		for ( int jj = 1; jj <= nCatchRows(kk); jj++ )
		{
			cobs =   dCatchData(kk,jj,5);  // catch data
			effort = dCatchData(kk,jj,10); // Effort data
			if (cobs > 0.0 && effort > 0.0)
			{
				i    =     dCatchData(kk,jj,1);  // year index
				j    =     dCatchData(kk,jj,2);  // season index
				k    =     dCatchData(kk,jj,3);  // fleet/gear index
				h    =     dCatchData(kk,jj,4);  // sex index
				type = int(dCatchData(kk,jj,7)); // Type of catch (retained = 1, discard = 2)
				unit = int(dCatchData(kk,jj,8)); // Units of catch equation (1 = biomass, 2 = numbers)
				if ( h ) // sex specific
				{
					nal.initialize();
					sel = log_slx_capture(k)(h)(i);
					switch ( type )
					{
						case 1: // retained catch
							sel = mfexp(sel + log_slx_retaind(k)(h)(i));
						break;
						case 2: // discarded catch
							sel = elem_prod(mfexp(sel), 1.0 - mfexp(log_slx_retaind(k)(h)(i)));
						break;
					}
					for ( int m = 1; m <= nmature; m++ )
					{
						for ( int o = 1; o <= nshell; o++ )
						{
							ig = pntr_hmo(h,m,o);
							nal += d4_N(ig)(i)(j);
						}
					}
					tmp_ft = ft(k)(h)(i)(j);
					nal = (unit == 1) ? elem_prod(nal, mean_wt(h)(i)) : nal;
					log_q_catch(kk) += log(cobs / effort) - log(nal * elem_div(elem_prod(tmp_ft * sel, 1.0 - mfexp(-Z(h)(i)(j))), Z(h)(i)(j)));
					nhit += 1;
				} else {
					// sexes combibed
					for ( h = 1; h <= nsex; h++ )
					{
						nal.initialize();
						sel = log_slx_capture(k)(h)(i);
						switch( type )
						{
							case 1: // retained catch
								sel = mfexp(sel + log_slx_retaind(k)(h)(i));
							break;
							case 2: // discarded catch
								sel = elem_prod(mfexp(sel), 1.0 - mfexp(log_slx_retaind(k)(h)(i)));
							break;
						}
						for ( int m = 1; m <= nmature; m++ )
						{
							for ( int o = 1; o <= nshell; o++ )
							{
								ig = pntr_hmo(h,m,o);
								nal += d4_N(ig)(i)(j);
							}
						}
						tmp_ft = ft(k)(h)(i)(j);
						nal = (unit == 1) ? elem_prod(nal, mean_wt(h)(i)) : nal;
						log_q_catch(kk) += log(cobs / effort) - log(nal * elem_div(elem_prod(tmp_ft * sel, 1.0 - mfexp(-Z(h)(i)(j))), Z(h)(i)(j)));
						nhit += 1;
					}
				}
			}
		}
		if ( nhit > 0 ) log_q_catch(kk) /= nhit;
	}
	if ( verbose == 1 ) COUT(log_q_catch);
	for ( int kk = 1; kk <= nCatchDF; kk++ )
	{
		for ( int jj = 1; jj <= nCatchRows(kk); jj++ )
		{
			i    =     dCatchData(kk,jj,1);  // year index
			j    =     dCatchData(kk,jj,2);  // season index
			k    =     dCatchData(kk,jj,3);  // fleet/gear index
			h    =     dCatchData(kk,jj,4);  // sex index
			type = int(dCatchData(kk,jj,7)); // Type of catch (retained = 1, discard = 2)
			unit = int(dCatchData(kk,jj,8)); // Units of catch equation (1 = biomass, 2 = numbers)
			effort =   dCatchData(kk,jj,10); // Effort data
			if ( h ) // sex specific
			{
				nal.initialize();
				sel = log_slx_capture(k)(h)(i);
				switch ( type )
				{
					case 1: // retained catch
						sel = mfexp(sel + log_slx_retaind(k)(h)(i));
					break;
					case 2: // discarded catch
						sel = elem_prod(mfexp(sel), 1.0 - mfexp(log_slx_retaind(k)(h)(i)));
					break;
				}
				for ( int m = 1; m <= nmature; m++ )
				{
					for ( int o = 1; o <= nshell; o++ )
					{
						ig = pntr_hmo(h,m,o);
						nal += d4_N(ig)(i)(j);
					}
				}
				tmp_ft = ft(k)(h)(i)(j);
				nal = (unit == 1) ? elem_prod(nal, mean_wt(h)(i)) : nal;
				if (effort > 0.0)
				{
					pre_catch(kk,jj) += mfexp(log_q_catch(kk)) * effort * nal * elem_div(elem_prod(tmp_ft * sel, 1.0 - mfexp(-Z(h)(i)(j))), Z(h)(i)(j));
					// COUT(kk);
					// COUT(jj);
					// COUT(mfexp(log_q_catch(kk)));
					// COUT(effort);
					// COUT(nal);
					// COUT(tmp_ft);
					// COUT(ft(k)(h));
					// COUT(sel);
					// COUT(elem_div(elem_prod(tmp_ft * sel, 1.0 - mfexp(-Z(h)(i)(j))), Z(h)(i)(j)));
					// COUT(pre_catch(kk,jj));
				} else {
					pre_catch(kk,jj) += nal * elem_div(elem_prod(tmp_ft * sel, 1.0 - mfexp(-Z(h)(i)(j))), Z(h)(i)(j));
				}
				// If calculating using effort then do this, if no effort then effort = 1 and q = 1.
			} else {
				// sexes combibed
				for ( h = 1; h <= nsex; h++ )
				{
					nal.initialize();
					sel = log_slx_capture(k)(h)(i);
					switch( type )
					{
						case 1: // retained catch
							sel = mfexp(sel + log_slx_retaind(k)(h)(i));
						break;
						case 2: // discarded catch
							sel = elem_prod(mfexp(sel), 1.0 - mfexp(log_slx_retaind(k)(h)(i)));
						break;
					}
					for ( int m = 1; m <= nmature; m++ )
					{
						for ( int o = 1; o <= nshell; o++ )
						{
							ig = pntr_hmo(h,m,o);
							nal += d4_N(ig)(i)(j);
						}
					}
					tmp_ft = ft(k)(h)(i)(j);
					nal = (unit == 1) ? elem_prod(nal, mean_wt(h)(i)) : nal;
					if (effort > 0.0)
					{
						pre_catch(kk,jj) += mfexp(log_q_catch(kk)) * effort * nal * elem_div(elem_prod(tmp_ft * sel, 1.0 - mfexp(-Z(h)(i)(j))), Z(h)(i)(j)); 
					} else {
						pre_catch(kk,jj) += nal * elem_div(elem_prod(tmp_ft * sel, 1.0 - mfexp(-Z(h)(i)(j))), Z(h)(i)(j));
					}
				}
			}
			// Catch residuals
			// In first case (obs_catch > 0) then if there is only catch data, calculate the residual as per usual; if there is catch and effort data, then still use observed catch to calculate the residual, despite the predicted catch being calculated differently.
			// In second case, when effort > 0 then the residual is the pred catch using Fs - pred catch using q
			if ( obs_catch(kk,jj) > 0.0 )
			{
				res_catch(kk,jj) = log(obs_catch(kk,jj)) - log(pre_catch(kk,jj));
			} else if (effort > 0.0) {
				res_catch(kk,jj) = log(nal * elem_div(elem_prod(tmp_ft * sel, 1.0 - mfexp(-Z(h)(i)(j))), Z(h)(i)(j))) - log(pre_catch(kk,jj));
			}
		}
		if ( verbose == 1 ) COUT(pre_catch(kk)(1));
	}
  /**
   * @brief Calculate predicted catch for all years (not just data years)
   * @author D'Arcy N. Webber
   * @details The function uses the Baranov catch equation to predict the retained and discarded catch for all model years (not just those years for which we have observations). This is used for plotting purposes only.
  **/
}

void model_parameters::calc_predicted_catch_out(void)
{
	int h,i,j,k,ig,type,unit;
	double effort;
	pre_catch_out.initialize();
	res_catch_out.initialize();
	dvariable tmp_ft;
	dvar_vector sel(1,nclass);
	dvar_vector nal(1,nclass); // numbers or biomass at length.
	for ( int kk = 1; kk <= nCatchDF; kk++ )
	{
		for ( i = syr; i <= nyr-1; i++ )
		{
			j    =     dCatchData_out(kk,i,2);  // season index
			k    =     dCatchData_out(kk,i,3);  // gear index
			h    =     dCatchData_out(kk,i,4);  // sex index
			type = int(dCatchData_out(kk,i,7)); // Type of catch (retained = 1, discard = 2)
			unit = int(dCatchData_out(kk,i,8)); // Units of catch equation (1 = biomass, 2 = numbers)
			effort =   dCatchData_out(kk,i,10); // Effort data
			if ( h ) // sex specific
			{
				nal.initialize();
				sel = log_slx_capture(k)(h)(i);
				switch ( type )
				{
					case 1: // retained catch
						sel = mfexp(sel + log_slx_retaind(k)(h)(i));
					break;
					case 2: // discarded catch
						sel = elem_prod(mfexp(sel), 1.0 - mfexp(log_slx_retaind(k)(h)(i)));
					break;
				}
				for ( int m = 1; m <= nmature; m++ )
				{
					for ( int o = 1; o <= nshell; o++ )
					{
						ig = pntr_hmo(h,m,o);
						nal += d4_N(ig)(i)(j);
					}
				}
				tmp_ft = ft(k)(h)(i)(j);
				nal = (unit == 1) ? elem_prod(nal, mean_wt(h)(i)) : nal;
				if (effort > 0.0)
				{
					pre_catch_out(kk,i) += mfexp(log_q_catch(kk)) * effort * nal * elem_div(elem_prod(tmp_ft * sel, 1.0 - mfexp(-Z(h)(i)(j))), Z(h)(i)(j)); 
				} else {
					pre_catch_out(kk,i) += nal * elem_div(elem_prod(tmp_ft * sel, 1.0 - mfexp(-Z(h)(i)(j))), Z(h)(i)(j));
				}
			} else {
				// sexes combibed
				for ( h = 1; h <= nsex; h++ )
				{
					nal.initialize();
					sel = log_slx_capture(k)(h)(i);
					switch( type )
					{
						case 1: // retained catch
							sel = mfexp(sel + log_slx_retaind(k)(h)(i));
						break;
						case 2: // discarded catch
							sel = elem_prod(mfexp(sel), 1.0 - mfexp(log_slx_retaind(k)(h)(i)));
						break;
					}
					for ( int m = 1; m <= nmature; m++ )
					{
						for ( int o = 1; o <= nshell; o++ )
						{
							ig = pntr_hmo(h,m,o);
							nal += d4_N(ig)(i)(j);
						}
					}
					tmp_ft = ft(k)(h)(i)(j);
					nal = (unit == 1) ? elem_prod(nal, mean_wt(h)(i)) : nal;
					if (effort > 0.0)
					{
						pre_catch_out(kk,i) += mfexp(log_q_catch(kk)) * effort * nal * elem_div(elem_prod(tmp_ft * sel, 1.0 - mfexp(-Z(h)(i)(j))), Z(h)(i)(j)); 
					} else {
						pre_catch_out(kk,i) += nal * elem_div(elem_prod(tmp_ft * sel, 1.0 - mfexp(-Z(h)(i)(j))), Z(h)(i)(j));
					}
				}
			}
		}
		for ( i = syr; i <= nyr-1; i++ )
		{
			if ( obs_catch_out(kk,i) > 0.0 && pre_catch_out(kk,i) > 0.0 )
			{
				res_catch_out(kk,i) = log(obs_catch_out(kk,i)) - log(pre_catch_out(kk,i)); // Catch residuals
			}
		}
	}
	/**
	 * @brief Calculate predicted relative abundance and residuals
	 * @author Steve Martell, D'Arcy Webber
	 *
	 * @details This function uses the conditional mle for q to scale the population to the relative abundance index. Assumed errors in relative abundance are lognormal.  Currently assumes that the CPUE index is made up of both retained and discarded crabs.
	 *
	 * Question regarding use of shell condition in the relative abundance index. Currenlty there is no shell condition information in the CPUE data, should there be? Similarly, there is no mature immature information, should there be?
	**/
}

void model_parameters::calc_relative_abundance(void)
{
	int g,h,i,j,k,ig;
	int unit;
	dvar_vector nal(1,nclass); // numbers at length
	dvar_vector sel(1,nclass); // selectivity at length
	for ( k = 1; k <= nSurveys; k++ )
	{
		dvar_vector V(1,nSurveyRows(k));
		V.initialize();
		for ( int jj = 1; jj <= nSurveyRows(k); jj++ )
		{
			nal.initialize();
			i = dSurveyData(k)(jj)(1);       // year index
			j = dSurveyData(k)(jj)(2);       // season index
			g = dSurveyData(k)(jj)(3);       // gear index
			h = dSurveyData(k)(jj)(4);       // sex index
			unit = dSurveyData(k)(jj)(7);    // units 1 = biomass 2 = numbers
			if ( h )
			{
				sel = mfexp(log_slx_capture(g)(h)(i));
				for ( int m = 1; m <= nmature; m++ )
				{
					for ( int o = 1; o <= nshell; o++ )
					{
						ig = pntr_hmo(h,m,o);
						nal += ( unit == 1 ) ? elem_prod(d4_N(ig)(i)(j), mean_wt(h)(i)) : d4_N(ig)(i)(j);
					}
				}
				V(jj) = nal * sel;
			} else {
				for ( h = 1; h <= nsex; h++ )
				{
					sel = mfexp(log_slx_capture(g)(h)(i));
					for ( int m = 1; m <= nmature; m++ )
					{
						for ( int o = 1; o <= nshell; o++ )
						{
							ig = pntr_hmo(h,m,o);
							nal += ( unit == 1 ) ? elem_prod(d4_N(ig)(i)(j), mean_wt(h)(i)) : d4_N(ig)(i)(j);
						}
					}
					V(jj) += nal * sel;
				}
			}
		} // nSurveyRows(k)
		switch ( q_anal(k) )
		{
			case 0: // q as a parameter
				pre_cpue(k) = survey_q(k) * V;
				res_cpue(k) = log(obs_cpue(k)) - log(pre_cpue(k));
			break;
			case 1:	// analytic q
				dvar_vector zt = log(obs_cpue(k)) - log(V);
				dvariable zbar = mean(zt);
				res_cpue(k)    = zt - zbar;
				survey_q(k)    = mfexp(zbar);
				pre_cpue(k)    = survey_q(k) * V;
			break;
		}
	}
	/**
	 * @brief Calculate predicted size composition data.
	 *
	 * @details Predicted size composition data are given in proportions.
	 * Size composition strata:
	 *  - sex  (0 = both sexes, 1 = male, 2 = female)
	 *  - type (0 = all catch, 1 = retained, 2 = discard)
	 *  - shell condition (0 = all, 1 = new shell, 2 = oldshell)
	 *  - mature or immature (0 = both, 1 = immature, 2 = mature)
	 *
	 *  Jan 5, 2015.
	 *  Size compostion data can come in a number of forms.
	 *  Given sex, maturity and 3 shell conditions, there are 12 possible
	 *  combinations for adding up the numbers at length (nal).
	 *
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
	 *  [ ] Add maturity component for data sets with mature old and mature new.
	**/
}

void model_parameters::calc_predicted_composition(void)
{
	int h,i,j,k,ig;
	int type,shell,bmature;
	d3_pre_size_comps_in.initialize();
	d3_pre_size_comps.initialize();
	dvar_vector dNtmp(1,nclass);
	dvar_vector   nal(1,nclass);
	for ( int ii = 1; ii <= nSizeComps_in; ii++ )
	{
		int nbins = nSizeCompCols_in(ii);
		for ( int jj = 1; jj <= nSizeCompRows_in(ii); jj++ )
		{
			dNtmp.initialize();
			i       = d3_SizeComps_in(ii)(jj,-7); // year
			j       = d3_SizeComps_in(ii)(jj,-6); // seas
			k       = d3_SizeComps_in(ii)(jj,-5); // gear (a.k.a. fleet)
			h       = d3_SizeComps_in(ii)(jj,-4); // sex
			type    = d3_SizeComps_in(ii)(jj,-3); // retained or discard
			shell   = d3_SizeComps_in(ii)(jj,-2); // shell condition
			bmature = d3_SizeComps_in(ii)(jj,-1); // boolean for maturity
			
			if ( h ) // sex specific
			{
				nal.initialize();
				dvar_vector sel = mfexp(log_slx_capture(k)(h)(i));
				dvar_vector ret = mfexp(log_slx_retaind(k)(h)(i));
				dvar_vector dis = mfexp(log_slx_discard(k)(h)(i));
				for ( int m = 1; m <= nmature; m++ )
				{
					for ( int o = 1; o <= nshell; o++ )
					{
						ig = pntr_hmo(h,m,o);
						if ( shell == 0 ) nal += d4_N(ig)(i)(j);
						if ( shell == o ) nal += d4_N(ig)(i)(j);
					}
				}
				switch ( type )
				{
					case 1: // retained
						dNtmp += elem_prod(nal, elem_prod(sel, ret));
					break;
					case 2: // discarded
						dNtmp += elem_prod(nal, elem_prod(sel, dis));
					break;
					default: // both retained and discarded
						dNtmp += elem_prod(nal, sel);
					break;
				}
			} else { // sexes combined in the observations
				for ( h = 1; h <= nsex; h++ )
				{
					nal.initialize();
					dvar_vector sel = mfexp(log_slx_capture(k)(h)(i));
					dvar_vector ret = mfexp(log_slx_retaind(k)(h)(i));
					dvar_vector dis = mfexp(log_slx_discard(k)(h)(i));
					for ( int m = 1; m <= nmature; m++ )
					{
						for ( int o = 1; o <= nshell; o++ )
						{
							ig = pntr_hmo(h,m,o);
							if ( shell == 0 ) nal += d4_N(ig)(i)(j);
							if ( shell == o ) nal += d4_N(ig)(i)(j);
						}
					}
					switch ( type )
					{
						case 1:
							dNtmp += elem_prod(nal, elem_prod(sel, ret));
							//dNtmp += elem_prod(tmp, ret);
						break;
						case 2:
							dNtmp += elem_prod(nal, elem_prod(sel, dis));
							//dNtmp += elem_prod(tmp, dis);
						break;
						default:
							dNtmp += elem_prod(nal, sel);
						break;
					}
				}
			}
			d3_pre_size_comps_in(ii)(jj)        = dNtmp(1,nbins);
			d3_pre_size_comps_in(ii)(jj)(nbins) = sum(dNtmp(nbins,nclass));
		}
	}
	// This aggregates the size composition data by appending size compositions horizontally
	int oldk = 9999;
	for ( int kk = 1; kk <= nSizeComps_in; kk++ )
	{
		int k = iCompAggregator(kk);
		if ( oldk != k )
		{
			j = 0;
		}
		oldk = k;
		for ( int jj = 1; jj <= nSizeCompCols_in(kk); jj++ )
		{
			j += 1;
			for ( int ii = 1; ii <= nSizeCompRows_in(kk); ii++ )
			{
				i = ii;
				d3_pre_size_comps(k,i,j) = d3_pre_size_comps_in(kk,ii,jj);
			}
		}
	}
	// This normalizes all observations by row
	for ( int k = 1; k <= nSizeComps; k++ )
	{
		for ( int i = 1; i <= nSizeCompRows(k); i++ )
		{
		   d3_pre_size_comps(k,i) /= sum(d3_pre_size_comps(k,i));
		}
	}
  /**
   * @brief Calculate sdnr and MAR
  **/
}

void model_parameters::get_all_sdnr_MAR()
{
	{
		//           CPUEsigmafixed_ri(ireg,ind1)=data_in(ireg,ii,6);
        //   if(iy<CPUEprocerr2_yr) CPUEsigmafixed_ri(ireg,ind1)=sqrt(square(CPUEsigmafixed_ri(ireg,ind1))+square(CPUEprocerr)); = 0.25
        //   if(iy>=CPUEprocerr2_yr) CPUEsigmafixed_ri(ireg,ind1)=sqrt(square(CPUEsigmafixed_ri(ireg,ind1))+square(CPUEprocerr2)); = 0.25
		for ( int k = 1; k <= nSurveys; k++ )
		{
			dvector stdtmp = cpue_sd(k) * 1.0 / cpue_lambda(k);
			dvar_vector restmp = elem_div(log(elem_div(obs_cpue(k), pre_cpue(k))), stdtmp) + 0.5 * stdtmp;
			sdnr_MAR_cpue(k) = calc_sdnr_MAR(value(restmp));
		}
		for ( int k = 1; k <= nSizeComps; k++ )
		{
			//dvector sdtmp = cpue_sd(k) * 1.0 / cpue_lambda(i);
			sdnr_MAR_lf(k) = calc_sdnr_MAR(value(d3_res_size_comps(k)));
		}
		Francis_weights = calc_Francis_weights();
	}
}

dvector model_parameters::calc_sdnr_MAR(dvector tmpVec)
{
	{
		dvector out(1,2);
		dvector tmp = fabs(tmpVec);
		dvector w = sort(tmp);
		out(1) = std_dev(tmpVec);                 // sdnr
		out(2) = w(floor(0.5*(size_count(w)+1))); // MAR
		return out;
	}
}

dvector model_parameters::calc_sdnr_MAR(dmatrix tmpMat)
{
	{
		dvector tmpVec(1,size_count(tmpMat));
		dvector out(1,2);
		int dmin,dmax;
		dmin = 1;
		for ( int ii = tmpMat.indexmin(); ii <= tmpMat.indexmax(); ii++ )
		{
			dmax = dmin + size_count(tmpMat(ii)) - 1;
			tmpVec(dmin,dmax) = tmpMat(ii).shift(dmin);
			dmin = dmax + 1;
		}
		dvector tmp = fabs(tmpVec);
		dvector w = sort(tmp);
		out(1) = std_dev(tmpVec);                 // sdnr
		out(2) = w(floor(0.5*(size_count(w)+1))); // MAR
		return out;
	}
  /**
   * @brief Calculate Francis weights
   * @details this code based on equation TA1.8 in Francis(2011) should be changed so separate weights if by sex
   *
   * Produces the new weight that should be used.
  **/
}

dvector model_parameters::calc_Francis_weights()
{
	{
		int j,nobs;
		double Obs, Pre, Var;
		dvector lfwt(1,nSizeComps);
		for ( int k = 1; k <= nSizeComps; k++ )
		{
			nobs = nSizeCompRows(k);
			dvector resid(1,nobs);
			j = 1;
			resid.initialize();
			for ( int i = 1; i <= nSizeCompRows(k); i++ )
			{
				//if ( sum(d3_obs_size_comps(k,i)) > 0 )
				//{
					//cout << "k= " << k << " i=" << i << endl;
					//cout << d3_obs_size_comps(k,i) << endl;
					Obs = sum(elem_prod(d3_obs_size_comps(k,i), mid_points));
					Pre = sum(elem_prod(value(d3_pre_size_comps(k,i)), mid_points));
					Var = sum(elem_prod(value(d3_pre_size_comps(k,i)), square(mid_points)));
	        		//P_yj+= sum(elem_prod(value(Plfrq_risl(ireg,ii,isx)(bins(ireg,isx,1),bins(ireg,isx,2))), Size(bins(ireg,isx,1),bins(ireg,isx,2))));
				//}
				Var -= square(Pre);
        		//lfrqwt_ri(ireg,jj)=lfrq_in(ireg,jj,4);
				//Lfsigma_risl(ireg,ii,isx)=sigmatilde/(lfrqwt_ri(ireg,ii)*LF_Like_wt(ireg,isx));
				//dvar_vector log_effn = log(mfexp(log_vn(ii)) * size_comp_sample_size(ii));
				resid(j++) = (Obs - Pre) / sqrt(Var * 1.0 / (size_comp_sample_size(k,i) * lf_lambda(k)));
				//resid(j++) = (Obs - Pre) / sqrt(Var * value(1.0 / (size_comp_sample_size(k,i) * 1.0)));
			}
			//lfwt(k) = 1.0 / (var(resid)*((nobs-1.0)/nobs*1.0));
			lfwt(k) = 1.0 / (square(std_dev(resid)) * ((nobs - 1.0) / nobs * 1.0));
			lfwt(k) *= lf_lambda(k);
		}
		return lfwt;
	}
  /**
   * @brief Calculate prior pdf
   * @details Function to calculate prior pdf
   * @param pType the type of prior
   * @param theta the parameter
   * @param p1 the first prior parameter
   * @param p2 the second prior parameter
  **/
}

dvariable model_parameters::get_prior_pdf(const int &pType, const dvariable &_theta, const double &p1, const double &p2)
{
	{
		dvariable prior_pdf;
		switch(pType)
		{
			case 0: // uniform
				prior_pdf = dunif(_theta,p1,p2);
				/*
				if ( (p2-p1) > 0 )
				{
					prior_pdf = -log(1.0 / (p2-p1));
				} else {
					cerr << "Error in uniform prior, p1 > p2.\n";
					ad_exit(1);
				}
				*/
			break;
			case 1: // normal
				// COUT(p1);COUT(p2);
				prior_pdf = dnorm(_theta,p1,p2);
				// COUT(prior_pdf);
			break;
			case 2: // lognormal
				prior_pdf = dlnorm(_theta,log(p1),p2);
			break;
			case 3: // beta
				//lb = _theta_control(i,2);
				//ub = _theta_control(i,3);
				//prior_pdf = dbeta((_theta-lb)/(ub-lb),p1,p2);
				prior_pdf = dbeta(_theta,p1,p2);
			break;
			case 4: // gamma
				prior_pdf = dgamma(_theta,p1,p2);
			break;
		}
		return prior_pdf;
	}
	/**
	 * @brief Calculate prior density functions for leading parameters.
	 * @details
	 *  - case 0 is a uniform density between the lower and upper bounds.
	 *  - case 1 is a normal density with mean = p1 and sd = p2
	 *  - case 2 is a lognormal density with mean = log(p1) and sd = p2
	 *  - case 3 is a beta density bounded between lb-ub with p1 and p2 as alpha & beta
	 *  - case 4 is a gamma density with parameters p1 and p2.
	 *
	 *  TODO
	 *  Make this a generic function.
	 *  Agrs would be vector of parameters, and matrix of controls
	 *  @param theta a vector of parameters
	 *  @param C matrix of controls (priorType, p1, p2, lb, ub)
	 *  @return vector of prior densities for each parameter
	**/
}

void model_parameters::calc_prior_densities(void)
{
	double p1,p2;
	double lb,ub;
	int iprior,itype;
	dvariable x;
	priorDensity.initialize();
	// Key parameter priors
	for ( int i = 1; i <= ntheta; i++ )
	{
		if ( active(theta(i)) )
		{
			itype = int(theta_control(i,5));
			p1 = theta_control(i,6);
			p2 = theta_control(i,7);
			dvariable x = theta(i);
			if ( itype == 3 )
			{
				lb = theta_control(i,2);
				ub = theta_control(i,3);
				x = (x - lb) / (ub - lb);
			}
			priorDensity(i) = get_prior_pdf(itype, x, p1, p2);
		}
	}
	// Growth parameter priors
	for ( int i = 1; i <= nGrwth; i++ )
	{
		if ( active(Grwth(i)) )
		{
			itype = int(Grwth_control(i,5));
			p1 = Grwth_control(i,6);
			p2 = Grwth_control(i,7);
			dvariable x = Grwth(i);
			if ( itype == 3 )
			{
				lb = Grwth_control(i,2);
				ub = Grwth_control(i,3);
				x = (x - lb) / (ub - lb);
			}
			priorDensity(ntheta+i) = get_prior_pdf(itype, x, p1, p2);
		}
	}
	// Catchability parameter priors
	iprior = ntheta + nGrwth + 1;
	for ( int i = 1; i <= nSurveys; i++ )
	{
		//itype = int(prior_qtype(i));
		priorDensity(iprior) = get_prior_pdf(prior_qtype(i), survey_q(i), prior_p1(i), prior_p2(i));
		//switch ( itype )
		//{
		//	case 0: // Analytical soln, no prior (uniform, uniformative)
		//		//priorDensity(iprior) = dunif(log(survey_q(i)), log(prior_qbar(i)), prior_qsd(i));
		//	break;
		//	case 1: // Prior on analytical soln, log-normal
		//		//priorDensity(iprior) = dnorm(log(survey_q(i)), log(prior_qbar(i)), prior_qsd(i));
		//		// cout << "q, density " << survey_q(i) << " " << priorDensity(iprior) << endl;
		//	break;
		//}
		if ( last_phase() )
		{
			priorDensity(iprior) = priorDensity(iprior) ;
		} else {
			priorDensity(iprior) = 0.1 * priorDensity(iprior) ;
		}
		iprior++;
	}
	// Additional CV parameter priors
	for ( int i = 1; i <= nSurveys; i++ )
	{
		if ( active(log_add_cv(i)) )
		{
			itype = int(prior_add_cv_type(i));
			if (itype == 0)
			{
				p1 = add_cv_lb(i);
				p2 = add_cv_ub(i);
			} else {
				p1 = prior_add_cv_p1(i);
				p2 = prior_add_cv_p2(i);
			}
			priorDensity(iprior) = get_prior_pdf(itype, mfexp(log_add_cv(i)), p1, p2);
		}
		iprior++;
	}
	// Selctivity parameter priors
	int j = 1;
	for ( int k = 1; k <= nslx; k++ )
	{
		for ( int i = 1; i <= slx_cols(k); i++ )
		{
			if ( active(log_slx_pars(j)) )
			{
				itype = int(slx_priors(k,i,1));
				p1 = slx_priors(k,i,2);
				p2 = slx_priors(k,i,3);
				if ( slx_type(k) == 0 || slx_type(k) == 1 )
				{
					x = mfexp(log_slx_pars(j)) / (1 + mfexp(log_slx_pars(j)));
				} else {
					x = mfexp(log_slx_pars(j));
				}
				// Above is a change of variable so an adjustment is required - DOUBLE CHECK THIS
				//priorDensity(iprior) = get_prior_pdf(itype, x, p1, p2) + log_slx_pars(k,j);
				priorDensity(iprior) = get_prior_pdf(itype, x, p1, p2);
				if ( verbose == 2 ) cout << " Prior no, val, dens " << iprior << " " << x << " " << priorDensity(iprior) << endl;
			}
			j++;
			iprior++;
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
	**/
}

void model_parameters::calc_objective_function(void)
{
	// |---------------------------------------------------------------------------------|
	// | NEGATIVE LOGLIKELIHOOD COMPONENTS FOR THE OBJECTIVE FUNCTION                    |
	// |---------------------------------------------------------------------------------|
	nloglike.initialize();
	
	// 1) Likelihood of the catch data.
	if ( verbose == 1 ) COUT(res_catch(1));
	for ( int k = 1; k <= nCatchDF; k++ )
	{
		dvector catch_sd = sqrt(log(1.0 + square(catch_cv(k))));
		nloglike(1,k) += dnorm(res_catch(k), catch_sd);
	}
	// 2) Likelihood of the relative abundance data.
	if ( verbose == 1 ) COUT(res_cpue(1));
	for ( int k = 1; k <= nSurveys; k++ )
	{
		if ( active(log_add_cv(k)) )
		{
			for ( int i = 1; i <= nSurveyRows(k); i++ )
			{
				dvariable stdtmp = sqrt(log(1.0 + square(cpue_cv(k,i) + mfexp(log_add_cv(k)))));
				nloglike(2,k) += log(stdtmp) + 0.5 * square(res_cpue(k,i) / stdtmp);
			}
		} else {
			//nloglike(2,k) += cpue_lambda(k) * dnorm(res_cpue(k), cpue_sd(k));
			dvector stdtmp = cpue_sd(k) * 1.0 / cpue_lambda(k);
			dvar_vector restmp = elem_div(log(elem_div(obs_cpue(k), pre_cpue(k))), stdtmp) + 0.5 * stdtmp;
			nloglike(2,k) += sum(log(stdtmp)) + sum(0.5 * square(restmp));
			//CPUEsigma_ri=CPUEsigmafixed_ri*sigmatilde/Like_wt(3);
			//resid=elem_div(log(elem_div(obs,pred)),std)+0.5*std;
			//return sum(log(std))+sum(0.5*square(resid)) ;
		}
	}
	// 3) Likelihood for size composition data.
	d3_res_size_comps.initialize();
	for ( int ii = 1; ii <= nSizeComps; ii++ )
	{
		dmatrix O = d3_obs_size_comps(ii);
		dvar_matrix P = d3_pre_size_comps(ii);
		dvar_vector log_effn = log(mfexp(log_vn(ii)) * size_comp_sample_size(ii) * lf_lambda(ii));
		bool bCmp = bTailCompression(ii);
		class acl::negativeLogLikelihood *ploglike;
		
		switch ( nAgeCompType(ii) )
		{
			case 0: // ignore composition data in model fitting.
				ploglike = NULL;
			break;
			case 1: // multinomial with fixed or estimated n
				ploglike = new class acl::multinomial(O, bCmp);
			break;
			case 2: // robust approximation to the multinomial
				if ( current_phase() <= 3 || !last_phase() )
				{
					ploglike = new class acl::multinomial(O, bCmp);
				} else {
					ploglike = new class acl::robust_multi(O, bCmp);
				}
			break;
			case 5: // Dirichlet
				ploglike = new class acl::dirichlet(O, bCmp);
			break;
		}
		// Compute residuals in the last phase.
		if ( last_phase() && ploglike != NULL )
		{
			d3_res_size_comps(ii) = ploglike->residual(log_effn, P);
		}
		// Now compute the likelihood.
		if ( ploglike != NULL )
		{
			nloglike(3,ii) += ploglike->nloglike(log_effn, P);
			delete ploglike;
		}
	}
	// 4) Likelihood for recruitment deviations.
	if ( active(rec_dev) )
	{
		dvariable sigR = mfexp(logSigmaR);
		nloglike(4,1) = dnorm(res_recruit, sigR);
		switch ( nSRR_flag )
		{
			case 0:
				//nloglike(4,1) = dnorm(res_recruit, sigR);
				//nloglike(4,1) += dnorm(rec_ini, sigR);
			break;
			case 1:
				//nloglike(4,1) = dnorm(res_recruit, sigR);
			break;
		}
	}
	if ( active(logit_rec_prop) )
	{
		nloglike(4,1) += dnorm(logit_rec_prop, 1.0);
	}
	// 5) Likelihood for growth increment data
	if ( !bUseEmpiricalGrowth && (active(Grwth(1)) || active(Grwth(2))) )
	{
		dvar_vector MoltIncPred = calc_growth_increments(dPreMoltSize, iMoltIncSex);
		nloglike(5,1) = dnorm(log(dMoltInc) - log(MoltIncPred), dMoltIncCV);
	}
	// |---------------------------------------------------------------------------------|
	// | PENALTIES AND CONSTRAINTS                                                       |
	// |---------------------------------------------------------------------------------|
	nlogPenalty.initialize();
	// 1) Penalty on log_fdev to ensure they sum to zero
	for ( int k = 1; k <= nfleet; k++ )
	{
		dvariable s     = mean(log_fdev(k));
		nlogPenalty(1) += 10000.0*s*s;
		dvariable r     = mean(log_fdov(k));
		nlogPenalty(1) += 10000.0*r*r;
	}
	// 2) Penalty on mean F to regularize the solution.
	int irow = 1;
	if ( last_phase() ) irow = 2;
	dvariable fbar;
	dvariable ln_fbar;
	for ( int k = 1; k <= nfleet; k++ )
	{
		// Jim made penalty apply only to season 2 for Fbar ft(1,nfleet,1,nsex,syr,nyr,1,nseason);            ///> Fishing mortality by gear
		fbar = mean( trans(ft(k,1))(2) );
		// fbar = mean(ft(k,1) );
		if ( pen_fbar(k) > 0  && fbar != 0 )
		{
			ln_fbar = log(fbar);
			nlogPenalty(2) += dnorm(ln_fbar, log(pen_fbar(k)), pen_fstd(irow,k));
		}
	}
	// 3) Penalty to constrain M in random walk
	if ( active(m_dev) )
	{
		nlogPenalty(3) += dnorm(m_dev, m_stdev);
	}
	if ( active(m_dev_females) )
	{
		nlogPenalty(3) += dnorm(m_dev_females, m_stdev);
	}
	// 4 Penalty on recruitment devs.
	if ( !last_phase() )
	{
		if ( active(rec_dev) && nSRR_flag !=0 )
		{
			//nlogPenalty(4) = dnorm(rec_dev, 1.0);
		}
		if ( active(rec_ini) && nSRR_flag !=0 )
		{
			nlogPenalty(5) = dnorm(rec_ini, 1.0);
		}
		if ( active(rec_dev) )
		{
			nlogPenalty(6) = dnorm(first_difference(rec_dev), 1.0);
		}
	}
	objfun = sum(nloglike) + sum(nlogPenalty) + sum(priorDensity);
	if ( verbose == 2 )
	{
		cout << "------------------------" << endl;
		COUT(objfun); cout << " Phase: " << current_phase() << endl; COUT(like_names); COUT(nloglike); COUT(nlogPenalty);
		cout << "priortheta  " << priorDensity(1, ntheta) << endl;;
		cout << "priorGrowth " << priorDensity(1 + ntheta, ntheta+nGrwth) << endl;;
		cout << "priorSrvQ   " << priorDensity(1 + ntheta + nGrwth, ntheta + nGrwth + nSurveys) << endl;
		cout << "priorselex  " << priorDensity(1 + ntheta + nGrwth + nSurveys, ntheta + nGrwth + nSurveys + nslx_pars) << endl;
	}
  /**
   * @brief Simulation model
   * @details Uses many of the same routines as the assessment model, over-writes the observed data in memory with simulated data.
  **/
}

void model_parameters::simulation_model(void)
{
	// random number generator
	random_number_generator rng(rseed);
	
	// Initialize model parameters
	initialize_model_parameters();
	// Fishing fleet dynamics ...
	calc_selectivities();
	calc_fishing_mortality();
	
	dvector drec_dev(syr+1,nyr);
	drec_dev.fill_randn(rng);
	rec_dev = mfexp(logSigmaR) * drec_dev;
	// Population dynamics ...
	calc_growth_increments();
	calc_molting_probability();
	calc_growth_transition();
	calc_natural_mortality();
	calc_total_mortality();
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
	for ( int k = 1; k <= nCatchDF; k++ )
	{
		catch_sd(k)  = sqrt(log(1.0 + square(catch_cv(k))));
		obs_catch(k) = value(pre_catch(k));
		err_catch(k) = elem_prod(catch_sd(k), err_catch(k)) - 0.5*square(catch_sd(k));
		obs_catch(k) = elem_prod(obs_catch(k), mfexp(err_catch(k)));
		for ( int i = syr; i <= nyr-1; i++ )
		{
			for ( int ii = 1; ii <= nCatchRows(k); ii++ )
			{
				if ( dCatchData(k,ii,1) == dCatchData_out(k,i,1) ) // year index
				{
					obs_catch_out(k,i) = obs_catch(k,ii);
					dCatchData_out(k,i,5) = obs_catch(k,ii);
				}
			}
		}
	}
	// add observation errors to cpue & fill in dSurveyData column 5
	dmatrix err_cpue(1,nSurveys,1,nSurveyRows);
	dmatrix cpue_sd_sim = sqrt(log(1.0 + square(cpue_cv))); // Note if this should include add_cv
	err_cpue.fill_randn(rng);
	obs_cpue = value(pre_cpue);
	err_cpue = elem_prod(cpue_sd_sim,err_cpue) - 0.5*square(cpue_sd_sim);
	obs_cpue = elem_prod(obs_cpue,mfexp(err_cpue));
	for ( int k = 1; k <= nSurveys; k++ )
	{
		for ( int i = 1; i <= nSurveyRows(k); i++ )
		{
			dSurveyData(k,i,5) = obs_cpue(k,i);
		}
	}
	
	// add sampling errors to size-composition.
	// 3darray d3_obs_size_comps(1,nSizeComps,1,nSizeCompRows,1,nSizeCompCols);
	double tau;
	for ( int k = 1; k <= nSizeComps; k++ )
	{
		for ( int i = 1; i <= nSizeCompRows(k); i++ )
		{
			tau = sqrt(1.0 / size_comp_sample_size(k)(i));
			dvector p = value(d3_pre_size_comps(k)(i));
			d3_obs_size_comps(k)(i) = rmvlogistic(p,tau,rseed+k+i);
		}
	}
	// COUT(d3_pre_size_comps(1)(1));
	// COUT(d3_obs_size_comps(1)(1));
}

void model_parameters::report(const dvector& gradients)
{
 adstring ad_tmp=initial_params::get_reportfile_name();
  ofstream report((char*)(adprogram_name + ad_tmp));
  if (!report)
  {
    cerr << "error trying to open report file"  << adprogram_name << ".rep";
    return;
  }
	cout << "+--------------------------+" << endl;
	cout << "| Beginning report section |" << endl;
	cout << "+--------------------------+" << endl;
	save_gradients(gradients);
	calc_predicted_catch_out();
	REPORT(name_read_flt);
	REPORT(name_read_srv);
	REPORT(nfleet);
	REPORT(n_grp);
	REPORT(nsex);
	REPORT(nshell);
	REPORT(syr);
	REPORT(nseason);
	REPORT(nyr);
	REPORT(isex);
	REPORT(imature);
	REPORT(ishell);
	dvector mod_yrs(syr,nyr);
	mod_yrs.fill_seqadd(syr,1);
	REPORT(mod_yrs);
	REPORT(mid_points);
	REPORT(m_prop);
	REPORT(nloglike);
	REPORT(nlogPenalty);
	REPORT(priorDensity);
	get_all_sdnr_MAR();
	REPORT(sdnr_MAR_cpue);
	REPORT(cpue_lambda);
	REPORT(sdnr_MAR_lf);
	REPORT(Francis_weights);
	REPORT(lf_lambda);
	REPORT(dCatchData);
	REPORT(obs_catch);
	REPORT(obs_effort);
	REPORT(pre_catch);
	REPORT(res_catch);
	REPORT(log_q_catch);
	REPORT(obs_catch_out);
	REPORT(pre_catch_out);
	REPORT(res_catch_out);
	REPORT(dCatchData_out);
	REPORT(dSurveyData);
	for ( int k = 1; k <= nSurveys; k++ )
	{
		if ( cpue_lambda(k) != 1.0 )
		{
			cpue_cv_add(k) = sqrt(exp(square(cpue_sd(k) * 1.0 / cpue_lambda(k))) - 1.0);
		} else {
			cpue_cv_add(k) = cpue_cv(k) + value(mfexp(log_add_cv(k)));
		}
	}
	REPORT(cpue_cv_add);
	REPORT(obs_cpue);
	REPORT(pre_cpue);
	REPORT(res_cpue);
	report << "slx_capture" << endl;
	for ( int i = syr; i <= nyr; i++ ) for ( int h = 1; h <= nsex; h++ ) for ( int j = 1; j <= nfleet; j++ )
		report << i << " " << h << " " << j << " " << mfexp(log_slx_capture(j,h,i)) << endl;
	report << "slx_retaind" << endl;
	for ( int i = syr; i <= nyr; i++ ) for ( int h = 1; h <= nsex; h++ ) for ( int j = 1; j <= nfleet; j++ )
		report << i << " " << h << " " << j << " " << mfexp(log_slx_retaind(j,h,i)) << endl;
	report << "slx_discard" << endl;
	for ( int i = syr; i <= nyr; i++ ) for ( int h = 1; h <= nsex; h++ ) for ( int j = 1; j <= nfleet; j++ )
		report << i << " " << h << " " << j << " " << mfexp(log_slx_discard(j,h,i)) << endl;
	REPORT(slx_control_in);
	REPORT(slx_control);
	REPORT(log_slx_capture);
	REPORT(log_slx_retaind);
	REPORT(log_slx_discard);
	
	REPORT(log_fbar);
	//REPORT(log_fdev);
	//REPORT(log_foff);
	//REPORT(log_fdov);
	REPORT(ft);
	REPORT(F);
	REPORT(d3_pre_size_comps);
	REPORT(d3_obs_size_comps);
	dmatrix effN(1,nSizeComps,1,nSizeCompRows);
	dmatrix effN2(1,nSizeComps,1,nSizeCompRows);
	dmatrix pre_mn_size(1,nSizeComps,1,nSizeCompRows);
	dmatrix obs_mn_size(1,nSizeComps,1,nSizeCompRows);
	dmatrix lb_mn_size(1,nSizeComps,1,nSizeCompRows);
	dmatrix ub_mn_size(1,nSizeComps,1,nSizeCompRows);
	/*
                 << " "<<mn_length(olc_ind(k,i))
                 << " "<<mn_length(elc_ind(k,i))
                 << " "<<sda_tmp
                 << " "<<mn_length(olc_ind(k,i)) - sda_tmp *2. / sqrt(n_sample_ind_length(k,i))
                 << " "<<mn_length(olc_ind(k,i)) + sda_tmp *2. / sqrt(n_sample_ind_length(k,i))
                 <<endl;
      }
    }
	}
	*/
	cout << "pos 1" << endl;
	// Compute effective N's
	for ( int kk = 1; kk <= nSizeComps; kk++ )
	{
		for ( int ii = 1; ii <= nSizeCompRows(kk); ii++ )
		{
			double sdl_tmp     = Sd_length(d3_obs_size_comps(kk,ii));
			effN(kk,ii)        = Eff_N(d3_obs_size_comps(kk,ii), d3_pre_size_comps(kk,ii));
			effN2(kk,ii)       = Eff_N2(d3_obs_size_comps(kk,ii), d3_pre_size_comps(kk,ii));
			pre_mn_size(kk,ii) = mn_length(d3_pre_size_comps(kk,ii));
			obs_mn_size(kk,ii) = mn_length(d3_obs_size_comps(kk,ii));
			lb_mn_size(kk,ii)  = obs_mn_size(kk,ii) - sdl_tmp * 2.0 / sqrt(size_comp_sample_size(kk,ii));
			ub_mn_size(kk,ii)  = obs_mn_size(kk,ii) + sdl_tmp * 2.0 / sqrt(size_comp_sample_size(kk,ii));
			/*
			*/
		}
	}
	cout << "pos 2" << endl;
	REPORT(effN);
	REPORT(effN2);
	REPORT(pre_mn_size);
	REPORT(obs_mn_size);
	REPORT(lb_mn_size);
	REPORT(ub_mn_size);
	for ( int kk = 1; kk <= nSizeComps_in; kk++ )
	{
		for ( int ii = 1; ii <= nSizeCompRows_in(kk); ii++ )
		{
			d3_obs_size_comps_out(kk,ii) = d3_obs_size_comps_in(kk,ii) / sum(d3_obs_size_comps_in(kk,ii));
			d3_pre_size_comps_out(kk,ii) = d3_pre_size_comps_in(kk,ii) / sum(d3_pre_size_comps_in(kk,ii));
			d3_res_size_comps_out(kk,ii) = d3_obs_size_comps_out(kk,ii) - d3_pre_size_comps_out(kk,ii); // WRONG, DARCY 29 jULY 2016
		}
	}
	REPORT(d3_SizeComps_in);
	REPORT(d3_obs_size_comps_out);
	REPORT(d3_pre_size_comps_out);
	REPORT(d3_res_size_comps_out);
	REPORT(d3_res_size_comps);
	REPORT(rec_sdd);
	REPORT(rec_ini);
	REPORT(rec_dev);
	REPORT(logit_rec_prop);
	REPORT(recruits);
	REPORT(xi);
	//REPORT(d4_N);
	REPORT(M);
	REPORT(Z);
	REPORT(mean_wt);
	REPORT(maturity);
	REPORT(molt_probability); ///> vector of molt probabilities
	dvector ssb = value(calc_ssb());
	REPORT(ssb);
	if ( last_phase() )
	{
		int refyear = nyr-1;
		int refseason = 1; // I ADDED THIS AS A TEMP FIX, NEEDS TO BE CHANGED
		//calc_spr_reference_points(refyear, refseason, spr_fleet);
		//calc_spr_reference_points2(refyear, refseason, spr_fleet);
		//d4_array d4_N_proj(1,n_grp,1,nproj,1,nseason,1,nclass);
		//d4_N_proj = project_population_numbers_at_length(nproj, 1, log(1.0));
		//REPORT(d4_N_proj);
		//calc_ofl(refyear,spr_fspr);
		REPORT(spr_syr);
		REPORT(spr_nyr);
		REPORT(spr_fleet);
		REPORT(spr_fspr);
		REPORT(spr_bspr);
		REPORT(spr_rbar);
		REPORT(spr_fofl);
		REPORT(spr_cofl);
		REPORT(spr_ssbo);
		dvar_matrix mean_size(1,nsex,1,nclass);
		///>  matrix to get distribution of size at say, nclass "ages" (meaning years since initial recruitment)
		dvar3_array growth_matrix(1,nsex,1,nclass,1,nclass);
		for ( int isex = 1; isex <= nsex; isex++ )
		{
			int iage=1;
			// Set the initial size frequency
			growth_matrix(isex,iage) = growth_transition(isex,iage);
			mean_size(isex,iage)     = growth_matrix(isex,iage) * mid_points /sum(growth_matrix(isex,iage));
			for ( iage = 2; iage <= nclass; iage++ )
			{
				growth_matrix(isex,iage) = growth_matrix(isex,iage-1) * growth_transition(isex);
				mean_size(isex,iage)     = growth_matrix(isex,iage) * mid_points / sum(growth_matrix(isex,iage));
			}
		}
		REPORT(growth_matrix);
		REPORT(mean_size);
		for ( int ii = 1; ii <= nSizeComps; ii++ )
		{
			// Set final sample-size for composition data for comparisons
			size_comp_sample_size(ii) = value(mfexp(log_vn(ii))) * size_comp_sample_size(ii);
		}
		REPORT(size_comp_sample_size);
	}
	// Print total numbers at length
	dvar_matrix N_initial(1,n_grp,1,nclass);
	dvar_matrix N_brute(1,n_grp,1,nclass);
	dvar_matrix N_total(syr,nyr,1,nclass);
	dvar_matrix N_males(syr,nyr,1,nclass);
	dvar_matrix N_females(syr,nyr,1,nclass);
	dvar_matrix N_males_new(syr,nyr,1,nclass);
	dvar_matrix N_females_new(syr,nyr,1,nclass);
	dvar_matrix N_males_old(syr,nyr,1,nclass);
	dvar_matrix N_females_old(syr,nyr,1,nclass);
	dvar_matrix N_males_mature(syr,nyr,1,nclass);
	dvar_matrix N_females_mature(syr,nyr,1,nclass);
	N_total.initialize();
	N_males.initialize();
	N_females.initialize();
	N_males_new.initialize();
	N_females_new.initialize();
	N_males_old.initialize();
	N_females_old.initialize();
	N_males_mature.initialize();
	N_females_mature.initialize();
	for ( int i = syr; i <= nyr; i++ )
	{
		for ( int l = 1; l <= nclass; l++ )
		{
			for ( int k = 1; k <= n_grp; k++ )
			{
				if ( isex(k) == 1 )
				{
					N_males(i,l) += d4_N(k,i,season_N,l);
					if ( ishell(k) == 1 )
					{
						N_males_new(i,l) += d4_N(k,i,season_N,l);
					}
					if ( ishell(k) == 2 )
					{
						N_males_old(i,l) += d4_N(k,i,season_N,l);
					}
					if ( imature(k) == 1 )
					{
						N_males_mature(i,l) += d4_N(k,i,season_N,l);
					}
				} else {
					N_females(i,l) += d4_N(k,i,season_N,l);
					if ( ishell(k) == 1 )
					{
						N_females_new(i,l) += d4_N(k,i,season_N,l);
					}
					if ( ishell(k) == 2 )
					{
						N_females_old(i,l) += d4_N(k,i,season_N,l);
					}
					if ( imature(k) == 1 )
					{
						N_females_mature(i,l) += d4_N(k,i,season_N,l);
					}
				}
				N_total(i,l) += d4_N(k,i,season_N,l);
			}
		}
	}
	for ( int k = 1; k <= n_grp; k++ )
	{
		N_initial(k) = d4_N(k)(syr)(1);
	}
	N_brute = calc_brute_equilibrium();
	REPORT(N_initial);
	REPORT(N_brute);
	REPORT(N_total);
	REPORT(N_males);
	REPORT(N_females);
	REPORT(N_males_new);
	REPORT(N_females_new);
	REPORT(N_males_old);
	REPORT(N_females_old);
	REPORT(N_males_mature);
	REPORT(N_females_mature);
	REPORT(molt_increment);
	REPORT(dPreMoltSize);
	REPORT(iMoltIncSex);
	REPORT(dMoltInc);
	if ( bUseEmpiricalGrowth )
	{
		dvector pMoltInc = dMoltInc;
		REPORT(pMoltInc);
	} else {
		dvar_vector pMoltInc = calc_growth_increments(dPreMoltSize, iMoltIncSex);
		REPORT(pMoltInc);
	}
	REPORT(survey_q);
	
	// Molting probability
	//dvector molt_prob_M(1,nclass);
	//dvector	molt_prob_F(1,nclass);
	//molt_prob_M = value(diagonal(P(1)));
	//REPORT(P);
	//REPORT(molt_prob_M);
	//if ( nsex == 2 )
	//{
	//	molt_prob_F = value(diagonal(P(2)));
	//	REPORT(molt_prob_F);
	//}
	// Growth and size transition.
	REPORT(growth_transition);
	REPORT(size_transition);
	dmatrix size_transition_M(1,nclass,1,nclass);
	dmatrix size_transition_F(1,nclass,1,nclass);
	size_transition_M = value(size_transition(1));
	REPORT(size_transition_M);
	if ( nsex == 2 )
	{
		size_transition_F = value(size_transition(2));
		REPORT(size_transition_F);
	}
	/**
	 * @brief Calculate mature male biomass (MMB)
	 * @details Calculation of the mature male biomass is based on the numbers-at-length summed over each shell condition.
	 *
	 * TODO: Add female component if lamda < 1
	 *
	 * @return dvar_vector ssb (model mature biomass).
	**/
}

dvar_vector model_parameters::calc_ssb()
{
	int ig,h,m,o;
	dvar_vector ssb(syr,nyr);
	ssb.initialize();
	for ( int i = syr; i <= nyr; i++ )
	{
		for ( ig = 1; ig <= n_grp; ig++ )
		{
			h = isex(ig);
			o = ishell(ig);
			m = imature(ig);
			double lam;
			h <= 1 ? lam = spr_lambda : lam = (1.0 - spr_lambda);
			ssb(i) += lam * d4_N(ig)(i)(season_ssb) * elem_prod(mean_wt(h)(i), maturity(h));
		}
	}
	return(ssb);
	/**
	 * @brief calculate spr-based reference points.
	 * @details Calculate the SPR-ratio for a given value of F.
	 *
	 * Psuedocode:
	 * - calculate average recruitment over reference period.
	 * - compute the ratio of F's based on reference year (nyr)
	 * - calculate fishing mortality vector.
	 * - calculate equibrium total mortality vector.
	 * - calculate growth/survival transition matrix.
	 *
	 * Got response from andre, “The convention is to fix F for all non-directed fisheries to a recent average and to solve for the F for the directed fishery so that you achieve B35%.” but I think he meant F35.
	 *
	 * Use bisection method to find SPR_target.
	 *
	 * Three possible states
	 * nshell = 1,
	 * nshell = 2 && nmaturity = 1,
	 * nshell = 2 && nmaturity = 2.
	 *
	 * @param iyr Reference year for selectivity and fishing mortality ratios
	 * @param ifleet index for gear to compute SPR values, other fleets with const F
	 * @return void
	**/
}

void model_parameters::calc_spr_reference_points_old(const int iyr, const int iseason, const int ifleet)
{
	// Average recruitment
	spr_rbar = mean(recruits(1)(spr_syr,spr_nyr));
	double _r = value(spr_rbar);
	dvector _rx = value(rec_sdd);
	d3_array _M(1,nsex,1,nclass,1,nclass);
	_M.initialize();
	dmatrix _N(1,nsex,1,nclass);
	dmatrix _wa(1,nsex,1,nclass);
	d3_array _A = value(growth_transition);
	d3_array _P = value(P);
	for ( int h = 1; h <= nsex; h++ )
	{
		for ( int l = 1; l <= nclass; l++ )
		{
			_M(h)(l,l) = value(M(h)(iyr)(l));
		}
		//todo fix me.
		_N(h) = value(d4_N(1)(iyr)(season_ssb));
		_wa(h) = elem_prod(mean_wt(h)(syr), maturity(h));
	}
	
	dmatrix _fhk(1,nsex,1,nfleet);
	d3_array _sel(1,nsex,1,nfleet,1,nclass);
	d3_array _ret(1,nsex,1,nfleet,1,nclass);
	for ( int h = 1; h <= nsex; h++ )
	{
		for ( int k = 1; k <= nfleet; k++ )
		{
			_fhk(h)(k) = value(ft(k)(h)(iyr)(iseason));
			_sel(h)(k) = mfexp(value(log_slx_capture(k)(h)(iyr)));
			_ret(h)(k) = mfexp(value(log_slx_retaind(k)(h)(iyr)));
		}
	}
	// Discard Mortality rates
	dvector _dmr(1,nfleet);
	_dmr.initialize();
	for ( int k = 1; k <= nfleet; k++ )
	{
		_dmr(k) = dmr(iyr,k);
	}
	
	//spr *ptrSPR=nullptr;
	spr *ptrSPR = 0;
	
	// SPR reference points for a single shell condition.
	if ( nshell == 1 )
	{
		spr c_spr(_r,spr_lambda,_rx,_wa,_M,_A);
		ptrSPR = &c_spr;
	}
	// SPR reference points for new and old shell condition.
	if ( nshell == 2 )
	{
		spr c_spr(_r,spr_lambda,_rx,_wa,_M,_P,_A);
		ptrSPR = &c_spr;
	}
	// This class needs a setter for season
	spr_fspr = ptrSPR->get_fspr(ifleet,spr_target,_fhk,_sel,_ret,_dmr);
	spr_bspr = ptrSPR->get_bspr();
	spr_ssbo = ptrSPR->get_ssbo();
	// OFL Calculations
	dvector ssb = value(calc_ssb());
	double cuttoff = 0.1;
	double limit = 0.25;
	spr_fofl = ptrSPR->get_fofl(cuttoff,limit,ssb(nyr));
	spr_cofl = ptrSPR->get_cofl(_N);
	/**
	 * @brief Calculate equilibrium initial conditions
	 *
	 * @return dvar_matrix
	**/
}

dvar_matrix model_parameters::calc_brute_equilibrium()
{
	int h,i,j,k,l,m,o,ig;
	int ninit = 25;
	dvar_matrix rtt(1,nsex,1,nclass);
	dvar4_array d4_N_init(1,n_grp,1,ninit,1,nseason,1,nclass);
	d4_N_init.initialize();
	dvar_matrix equilibrium_numbers(1,n_grp,1,nclass);
	dvar_vector x(1,nclass);
	dvar_vector y(1,nclass);
	dvar_vector z(1,nclass);
	dvar3_array FF(1,nsex,1,nseason,1,nclass);          ///> Fishing mortality
	dvar3_array ZZ(1,nsex,1,nseason,1,nclass);          ///> Total mortality
	dvar4_array SS(1,nsex,1,nseason,1,nclass,1,nclass); ///> Surival Rate (S=exp(-Z))
	double xi; // discard mortality rate
	dvariable log_ftmp;
	dvar_vector sel(1,nclass);
	dvar_vector ret(1,nclass);
	dvar_vector vul(1,nclass);
	
	FF.initialize();
	ZZ.initialize();
	SS.initialize();
	for ( k = 1; k <= nfleet; k++ )
	{
		for ( h = 1; h <= nsex; h++ )
		{
			for ( j = 1; j <= nseason; j++ )
			{
				if ( fhit(syr,j,k) )
				{
					log_ftmp = log_fbar(k);// + log_fini(k);
					if ( yhit(syr,j,k) )
					{
						log_ftmp += double(h-1);// * log_fini(k);
					}
					xi  = dmr(syr,k);                                      // Discard mortality rate
					sel = exp(log_slx_capture(k)(h)(syr));                 // Selectivity
					ret = exp(log_slx_retaind(k)(h)(syr)) * slx_nret(h,k); // Retension
					vul = elem_prod(sel, ret + (1.0 - ret) * xi);        // Vulnerability
					FF(h)(j) += mfexp(log_ftmp) * vul;
				}
			}
		}
	}
	for ( h = 1; h <= nsex; h++ )
	{
		for ( j = 1; j <= nseason; j++ )
		{
			ZZ(h)(j) = (m_prop(syr)(j) * M(h)(syr)) + FF(h)(j);
			for ( l = 1; l <= nclass; l++ )
			{
				SS(h)(j)(l,l) = mfexp(-ZZ(h)(j)(l));
			}
		}
	}
  if (nsex>1)
  {
		// Initial recruitment
		switch( bInitializeUnfished )
		{
			case 0: // Unfished conditions
				//rtt = (1.0/nsex * mfexp(logR0)) * rec_sdd;
				rtt(1) = mfexp(logR0) * 1 / (1 + mfexp(-logit_rec_prop(syr))) * rec_sdd;
				rtt(2) = mfexp(logR0) * (1 - 1 / (1 + mfexp(-logit_rec_prop(syr)))) * rec_sdd;
			break;
			case 1: // Steady-state fished conditions
				//rtt = (1.0/nsex * mfexp(logRbar)) * rec_sdd;
				rtt(1) = mfexp(logRbar) * 1 / (1 + mfexp(-logit_rec_prop(syr))) * rec_sdd;
				rtt(2) = mfexp(logRbar) * (1 - 1 / (1 + mfexp(-logit_rec_prop(syr)))) * rec_sdd;
			break;
			case 2: // Free parameters
				rtt(1) = mfexp(logRbar) * 1 / (1 + mfexp(-logit_rec_prop(syr))) * rec_sdd;
				rtt(2) = mfexp(logRbar) * (1 - 1 / (1 + mfexp(-logit_rec_prop(syr)))) * rec_sdd;
			break;
		}
  }
  else
  {
  	rtt(1) = 1.;
  }
	//if ( bInitializeUnfished == 0 )
	//{
	//	rtt = (1.0/nsex * mfexp(logR0)) * rec_sdd;
	//} else {
	//	rtt = (1.0/nsex * mfexp(logRbar)) * rec_sdd;
	//}
	for ( i = 1; i < ninit; i++ )
	{
		for ( int j = 1; j <= nseason; j++ )
		{
			for ( ig = 1; ig <= n_grp; ig++ )
			{
				h = isex(ig);
				m = imature(ig);
				o = ishell(ig);
				if ( nshell == 1 )
				{
					x = d4_N_init(ig)(i)(j);
					// Mortality (natural and fishing)
					x = x * SS(h)(j);
					//x = x * S(h)(syr)(j);
					// Molting and growth
					if (j == season_growth)
					{
						x = x * size_transition(h);
					}
					// Recruitment
					if (j == season_recruitment)
					{
						x += rtt(h);
					}
					if (j == nseason)
					{
						d4_N_init(ig)(i+1)(1) = x;
					} else {
						d4_N_init(ig)(i)(j+1) = x;
					}
				} else {
					if ( o == 1 ) // newshell
					{
						x = d4_N_init(ig)(i)(j);
						//cout << "d4_N_init(ig)(i)(j):" << endl;
						//cout << d4_N_init(ig)(i)(j) << endl;
						// Mortality (natural and fishing)
						x = x * SS(h)(j);
						//x = x * S(h)(syr)(j);
						// Molting and growth
						if (j == season_growth)
						{
							y = elem_prod(x, 1 - diagonal(P(h))); // did not molt, becomes oldshell
							x = elem_prod(x, diagonal(P(h))) * growth_transition(h); // molted and grew, stay newshell
						}
						// Recruitment
						if (j == season_recruitment)
						{
							x += rtt(h);
						}
						if (j == nseason)
						{
							d4_N_init(ig)(i+1)(1) = x;
						} else {
							d4_N_init(ig)(i)(j+1) = x;
						}
					}
					if ( o == 2 ) // oldshell
					{
						x = d4_N_init(ig)(i)(j);
						// Mortality (natural and fishing)
						x = x * SS(h)(j);
						///x = x * S(h)(syr)(j);
						// Molting and growth
						z.initialize();
						if (j == season_growth)
						{
							z = elem_prod(x, diagonal(P(h))) * growth_transition(h); // molted and grew, become newshell
							x = elem_prod(x, 1 - diagonal(P(h))) + y; // did not molt, remain oldshell and add the newshell that become oldshell
							y.initialize();
						}
						if (j == nseason)
						{
							d4_N_init(ig-1)(i+1)(1) += z;
							d4_N_init(ig)(i+1)(1) = x;
						} else {
							d4_N_init(ig-1)(i)(j+1) += z;
							d4_N_init(ig)(i)(j+1) = x;
						}
					}
				}
			}
		}
	}
	for ( ig = 1; ig <= n_grp; ig++ )
	{
		equilibrium_numbers(ig) = d4_N_init(ig)(ninit)(1);
	}
	return(equilibrium_numbers);
}

dvector model_parameters::calc_brute_equilibrium2(const dmatrix& SS, const double& rbar, const int& sex, const int& seas)
{
	int h,i,ig,o,m;
	int ninit = 100;
	dvector rtt;
	d4_array d4_N_init(1,n_grp,1,ninit,1,nseason,1,nclass);
	d4_N_init.initialize();
	dvector x(1,nclass);
	dvector y(1,nclass);
	dvector z(1,nclass);
	
	rtt = value(1.0/nsex * rbar * rec_sdd);
	for ( i = 1; i < ninit; i++ )
	{
		for ( int j = 1; j <= nseason; j++ )
		{
			for ( ig = 1; ig <= n_grp; ig++ )
			{
				h = isex(ig);
				m = imature(ig);
				o = ishell(ig);
				if ( nshell == 1 )
				{
					x = d4_N_init(ig)(i)(j);
					// Mortality (natural and fishing)
					x = x * SS;
					// Molting and growth
					if (j == season_growth)
					{
						x = value(x * size_transition(h));
					}
					// Recruitment
					if (j == season_recruitment)
					{
						x += rtt;
					}
					if (j == nseason)
					{
						d4_N_init(ig)(i+1)(1) = x;
					} else {
						d4_N_init(ig)(i)(j+1) = x;
					}
				} else {
					if ( o == 1 ) // newshell
					{
						x = d4_N_init(ig)(i)(j);
						// Mortality (natural and fishing)
						x = x * SS;
						// Molting and growth
						if (j == season_growth)
						{
							y = value(elem_prod(x,1-diagonal(P(h)))); // did not molt, become oldshell
							x = value(elem_prod(x,diagonal(P(h))) * growth_transition(h)); // molted and grew, stay newshell
						}
						// Recruitment
						if (j == season_recruitment)
						{
							x += rtt;
						}
						if (j == nseason)
						{
							d4_N_init(ig)(i+1)(1) = x;
						} else {
							d4_N_init(ig)(i)(j+1) = x;
						}
					}
					if ( o == 2 ) // oldshell
					{
						// add oldshell non-terminal molts to newshell
						x = d4_N_init(ig)(i)(j);
						// Mortality (natural and fishing)
						x = x * SS;
						// Molting and growth
						z.initialize();
						if (j == season_growth)
						{
							z = value(elem_prod(x,diagonal(P(h))) * growth_transition(h)); // molted and grew, become newshell
							x = value(elem_prod(x,1-diagonal(P(h))) + y); // did not molt, remain oldshell and add the newshell that become oldshell
						}
						if (j == nseason)
						{
							d4_N_init(ig-1)(i+1)(1) += z;
							d4_N_init(ig)(i+1)(1) = x;
						} else {
							d4_N_init(ig-1)(i)(j+1) += z;
							d4_N_init(ig)(i)(j+1) = x;
						}
					}
				}
			}
		}
	}
	dvector equilibrium_numbers = d4_N_init(sex)(ninit-1)(seas);
	return(equilibrium_numbers);
}

void model_parameters::calc_spr_reference_oldagain()
{
	// Average recruitment
	//spr_rbar = mean(value(recruits(spr_syr,spr_nyr)));
	/*
	double _r = spr_rbar;
	dvector _rx = value(rec_sdd);
	d3_array _M(1,nsex,1,nclass,1,nclass);
	_M.initialize();
	dmatrix _N(1,nsex,1,nclass);
	dmatrix _wa(1,nsex,1,nclass);
	//d3_array _A = value(growth_transition);
	//d3_array _P = value(P);
	for ( int h = 1; h <= nsex; h++ )
	{
		for ( int l = 1; l <= nclass; l++ )
		{
			_M(h)(l,l) = value(M(h)(iyr)(l));
		}
		//todo fix me.
		_N(h) = value(d4_N(h)(iyr)(season_ssb));
		_wa(h) = elem_prod(mean_wt(h)(iyr), maturity(h));
	}
	
	dmatrix _fhk(1,nsex,1,nfleet);
	d3_array _sel(1,nsex,1,nfleet,1,nclass);
	d3_array _ret(1,nsex,1,nfleet,1,nclass);
	for ( int h = 1; h <= nsex; h++ )
	{
		for ( int k = 1; k <= nfleet; k++ )
		{
			_fhk(h)(k) = value(ft(k)(h)(iyr)(iseason));
			_sel(h)(k) = mfexp(value(log_slx_capture(k)(h)(iyr)));
			_ret(h)(k) = mfexp(value(log_slx_retaind(k)(h)(iyr)));
		}
	}
	// Discard Mortality rates
	dvector _dmr(1,nfleet);
	_dmr.initialize();
	for ( int k = 1; k <= nfleet; k++ )
	{
		_dmr(k) = dmr(iyr,k);
	}
	double  m_ssb0;
	double  m_ssb;
	double  m_spr;
	double  m_fspr;
	double  m_bspr;
	double  m_fofl;
	double  m_cofl;
	// SPR reference points for a single shell condition.
	if ( nshell == 1 )
	{
		//spr c_spr(_r,spr_lambda,_rx,_wa,_M,_A);
		//ptrSPR = &c_spr;
		//m_nshell = 1;
		//m_nsex   = m_M.slicemax();
		//m_nclass = m_rx.indexmax();
		dmatrix _S(1,nclass,1,nclass);
		_S.initialize();
		// get unfished mature male biomass per recruit.
		m_ssb0 = 0.0;
		for ( int h = 1; h <= nsex; h++ )
		{
			for ( int l = 1; l <= nclass; ++l )
			{
				_S(l,l) = exp(-_M(h)(l,l));
			}
			dvector x = calc_brute_equilibrium2(_S,_r,h,season_ssb);
			double lam;
			h <= 1 ? lam=spr_lambda: lam=(1.-spr_lambda);
			m_ssb0 += lam * x * elem_prod(mean_wt(h)(iyr), maturity(h));
		}
	}
	// SPR reference points for new and old shell condition.
	if ( nshell == 2 )
	{
		//spr c_spr(_r,spr_lambda,_rx,_wa,_M,_P,_A);
		//ptrSPR = &c_spr;
	}
	// Get Fspr
	int iter  = 0;
	double fa = 0.00;
	double fb = 2.00;
	double fc = 0.5*(fa+fb);
	dmatrix _F = _fhk;
	dvector fratio(1,nfleet);
	dmatrix _Z(1,nclass,1,nclass);
	dmatrix _S(1,nclass,1,nclass);
	_S.initialize();
	_Z.initialize();
	do
	{
		m_ssb = 0;
		for ( int h = 1; h <= nsex; h++ )
		{
			_F(h)(ifleet) = fc;
			for ( int k = 1; k <= nfleet; k++ )
			{
				fratio(k) = _F(h)(k)/_F(h)(ifleet);
			}
			dmatrix sel = _sel(h);
			dmatrix ret = _ret(h);
			
			_Z = _M(h);
			for ( int k = 1; k <= nfleet; k++ )
			{
				dvector vul = elem_prod(sel(k),ret(k)+(1.0-ret(k))*_dmr(k));
				for ( int l = 1; l <= nclass; ++l )
				{
					_Z(l,l) += (fc * fratio(k)) * vul(l);
				}
			}
			
			for ( int l = 1; l <= nclass; ++l )
			{
				_S(l,l) = exp(-diagonal(_Z)(l));
			}
			if ( nshell == 1 )
			{
				dvector x = calc_brute_equilibrium2(_S,_r,h,season_ssb);
				double lam;
				h <= 1 ? lam=spr_lambda: lam=(1.-spr_lambda);
				m_ssb += lam * x * _wa(h);
			}
			
			if ( nshell == 2 )
			{
				//dvector r = m_rbar/m_nsex * m_rx;
				//calc_equilibrium(n,o,m_A(h),S,m_P(h),r);
				//double lam;
				//h <= 1 ? lam=m_lambda: lam=(1.-m_lambda);
				//m_ssb += lam * (n+o) * m_wa(h);
			}
		}	
		// spawning potential ratio
		m_spr = m_ssb/m_ssb0;
		
		// test for convergence
		double t1 = m_spr - spr_target;
		if ( t1==0 || 0.5*(fb-fa) < TOL )
		{
			m_fspr = fc;
			m_bspr = m_ssb;
			cout << "SPR calculations have converged. :)" << endl;
			break;
		}
		// bisection update
		if(t1 > 0)
		{
			fa = fc;
		} else {
			fb = fc;
		}
		cout<<"iter = "<<iter<<"\tfc = "<<fc<<"\t(spr-spr_target)="<<m_spr<<" - "<<spr_target<<" "<<t1<<endl;
		fc = 0.5*(fa+fb);
	} while (iter++ < MAXIT);
	// Get Fofl
	dvector ssb = value(calc_ssb());
	double cuttoff = 0.1;
	double limit = 0.25;
	//spr_fofl = ptrSPR->get_fofl(cuttoff,limit,ssb(nyr));
	//double spr::get_fofl(const double& alpha, const double& limit, const double& ssb)
	double depletion = ssb(nyr)/m_bspr;
	m_fofl = 0;
	if ( depletion > 1.0 )
	{
		m_fofl = m_fspr;
	}
	if ( limit < depletion && depletion <= 1.0 )
	{
		m_fofl = m_fspr * (depletion - cuttoff)/(1.0 - cuttoff);
	}
	// Get Cofl
	double ctmp = 0;
	double ftmp;
	for ( int h = 1; h <= nsex; h++ )
	{
		for ( int k = 1; k <= nfleet; k++ )
		{
			ftmp = _fhk(h)(k);
			if (k == ifleet) ftmp = m_fofl;
			dvector vul = elem_prod(_sel(h)(k),_ret(h)(k)+(1.0-_ret(h)(k))*_dmr(k));
			dvector f = ftmp * vul;
			dvector z = diagonal(_M(h)) + f;
			dvector o = 1.0-exp(-z);
			ctmp += elem_prod(_N(h),_wa(h)) * elem_div(elem_prod(f,o),z);
		}
	}
	m_cofl = ctmp;
	*/
}

dvar_vector model_parameters::project_biomass(const int iproj, const int ifleet, const dvariable log_F, dvar4_array numbers_proj_gytl)
{
	dvariable log_ftmp;
	dvar_vector rt(1,nclass);
	dvar_vector  x(1,nclass);
	dvar_vector  y(1,nclass);
	dvar_vector  z(1,nclass);
	//dvar4_array numbers_proj_gytl(1,n_grp,1,iproj,1,nseason,1,nclass);
	dvar3_array _F(1,nsex,1,nseason,1,nclass);          ///> Fishing mortality
	dvar3_array _Z(1,nsex,1,nseason,1,nclass);          ///> Total mortality
	dvar4_array _S(1,nsex,1,nseason,1,nclass,1,nclass); ///> Surival Rate (S=exp(-Z))
	dvar3_array _ft(1,nfleet,1,nsex,1,nseason);            ///> Fishing mortality by gear
	_F.initialize();
	_Z.initialize();
	_S.initialize();
	_ft.initialize();
	for ( int k = 1; k <= nfleet; k++ )
	{
		for ( int h = 1; h <= nsex; h++ )
		{
			int i = nyr;
			for ( int j = 1; j <= nseason; j++ )
			{
				if ( fhit(i,j,k) )
				{
					if (k == ifleet)
					{
						log_ftmp = log_F;
					} else {
						log_ftmp = log_fbar(k);
					}
					if ( yhit(i,j,k) )
					{
						log_ftmp += double(h-1) * log_foff(k);
					}
					_ft(k)(h)(j) = mfexp(log_ftmp);
					double xi = dmr(i,k);                                      // Discard mortality rate
					dvar_vector sel = exp(log_slx_capture(k)(h)(i));                 // Selectivity
					dvar_vector ret = exp(log_slx_retaind(k)(h)(i)) * slx_nret(h,k); // Retension
					dvar_vector vul = elem_prod(sel, ret + (1.0 - ret) * xi);        // Vulnerability
					_F(h)(j) += _ft(k,h,j) * vul;
				}
			}
		}
	}
	for ( int h = 1; h <= nsex; h++ )
	{
		for ( int j = 1; j <= nseason; j++ )
		{
			_Z(h)(j) = (m_prop(nyr)(j) * M(h)(nyr)) + _F(h)(j);
			for ( int l = 1; l <= nclass; l++ )
			{
				_S(h)(j)(l,l) = mfexp(-_Z(h)(j)(l));
			}
		}
	}
	for ( int ig = 1; ig <= n_grp; ig++ )
	{
		numbers_proj_gytl(ig)(1)(1) = d4_N(ig)(nyr)(nseason);
	}
	for ( int i = 1; i <= iproj; i++ )
	{
		//rt = value((1.0/nsex * mfexp(logRbar)) * rec_sdd);
		rt = (1.0/nsex * spr_rbar) * rec_sdd;
		for ( int j = 1; j <= nseason; j++ )
		{
			for ( int ig = 1; ig <= n_grp; ig++ )
			{
				int h = isex(ig);
				int m = imature(ig);
				int o = ishell(ig);
				if ( nshell == 1 )
				{
					x = numbers_proj_gytl(ig)(i)(j);
					// Mortality (natural and fishing)
					x = x * _S(h)(j);
					// Molting and growth
					if (j == season_growth)
					{
						x = x * size_transition(h);
					}
					// Recruitment
					if (j == season_recruitment)
					{
						x += rt;
					}
					if (j == nseason)
					{
						if (i != iproj)
						{ 
							numbers_proj_gytl(ig)(i+1)(1) = x;
						}
					} else {
						numbers_proj_gytl(ig)(i)(j+1) = x;
					}
				} else {
					if ( o == 1 ) // newshell
					{
						x = numbers_proj_gytl(ig)(i)(j);
						// Mortality (natural and fishing)
						x = x * _S(h)(j);
						// Molting and growth
						if (j == season_growth)
						{
							y = elem_prod(x, 1 - diagonal(P(h))); // did not molt, become oldshell
							x = elem_prod(x, diagonal(P(h))) * growth_transition(h); // molted and grew, stay newshell
						}
						// Recruitment
						if (j == season_recruitment)
						{
							x += rt;
						}
						if (j == nseason)
						{
							if (i != iproj)
							{
								numbers_proj_gytl(ig)(i+1)(1) = x;
							}
						} else {
							numbers_proj_gytl(ig)(i)(j+1) = x;
						}
					}
					if ( o == 2 ) // oldshell
					{
						// add oldshell non-terminal molts to newshell
						x = numbers_proj_gytl(ig)(i)(j);
						// Mortality (natural and fishing)
						x = x * _S(h)(j);
						// Molting and growth
						z.initialize();
						if (j == season_growth)
						{
							z = elem_prod(x, diagonal(P(h))) * growth_transition(h); // molted and grew, become newshell
							x = elem_prod(x, 1 - diagonal(P(h))) + y; // did not molt, remain oldshell and add the newshell that become oldshell
						}
						if (j == nseason)
						{
							if (i != iproj)
							{
								numbers_proj_gytl(ig-1)(i+1)(1) += z;
								numbers_proj_gytl(ig)(i+1)(1) = x;
							}
						} else {
							numbers_proj_gytl(ig-1)(i)(j+1) += z;
							numbers_proj_gytl(ig)(i)(j+1) = x;
						}
					}
				}
			}
		}
	}
	dvar_vector ssb(1,iproj);
	ssb.initialize();
	for ( int i = 1; i <= iproj; i++ )
	{
		for ( int ig = 1; ig <= n_grp; ig++ )
		{
			int h = isex(ig);
			int o = ishell(ig);
			int m = imature(ig);
			double lam;
			h <= 1 ? lam = spr_lambda: lam = (1.0 - spr_lambda);
			ssb(i) += lam * numbers_proj_gytl(ig)(i)(season_ssb) * elem_prod(mean_wt(h)(nyr), maturity(h));
		}
	}
	return(ssb);
}

void model_parameters::calc_spr_reference_points2(const int iyr, const int ifleet)
{
	dvar4_array numbers_proj_gytl(1,n_grp,1,1,1,nseason,1,nclass);
	dvariable Bmsy;
	dvariable Bproj;
	dvariable FF;
	dvariable Fmsy;
	double alpha = 0.10; // cutoff
	double beta = 0.25; // limit
	double gamma = 1.0;
	spr_rbar = mean(recruits(1)(spr_syr,spr_nyr));
	Bmsy = mean(calc_ssb()(spr_syr,spr_nyr)); // Jies code: Bmsy = sum(MMB215(1,nyrs-1))/(nyrs-1);
	spr_bspr = Bmsy;
	Fmsy = gamma * M0;
	FF = Fmsy;
	Bproj = project_biomass(1, ifleet, log(FF), numbers_proj_gytl)(1);
	if (Bproj > Bmsy)
	{
		FF = Fmsy;
	} else {
		// Adjust F if below target since it's a function biomass needs to be interated
		for( int k = 1; k <= 10; k++)
		{
			FF = Fmsy * (Bproj / Bmsy - alpha) / (1 - alpha);
			Bproj = project_biomass(1, ifleet, log(FF), numbers_proj_gytl)(1);
		}
	}
	if (Bproj < 0.25 * Bmsy)
	{
		FF = 0.0;
	}
	spr_fofl = FF;
	dvariable ctmp = 0;
	dvariable log_ftmp;
	for ( int h = 1; h <= nsex; h++ )
	{
		for ( int j = 1; j <= nseason; j++ )
		{
			for ( int k = 1; k <= nfleet; k++ )
			{
				if ( fhit(iyr,j,k) )
				{
					// Use SPR Fofl for target fleet
					if (k == ifleet)
					{
						log_ftmp = log(spr_fofl);
					} else {
						log_ftmp = log_fbar(k);
					}
					if ( yhit(iyr,j,k) )
					{
						log_ftmp += double(h-1) * log_foff(k);
					}
					dvariable ftmp = mfexp(log_ftmp);
					double xi = dmr(nyr,k);                                      // Discard mortality rate
					dvar_vector sel = exp(log_slx_capture(k)(h)(nyr));                 // Selectivity
					dvar_vector ret = exp(log_slx_retaind(k)(h)(nyr)) * slx_nret(h,k); // Retension
					dvar_vector vul = elem_prod(sel, ret + (1.0 - ret) * xi);        // Vulnerability
					dvar_vector f = ftmp * vul;
					dvar_vector z = M(h)(iyr) + f;
					dvar_vector o = 1.0 - exp(-z);
					ctmp += elem_prod(numbers_proj_gytl(h)(1)(j), mean_wt(h)(nyr)) * elem_div(elem_prod(f, o), z);
				}
			}
		}
	}
	spr_cofl = ctmp; 
	// Jies code: spr_cofl = Bret_proj + Bdis_proj + Bgff_proj + Bgft_proj;
   //Bret_proj = Rpf(3)*(1.0-dstr(nyrs))/(1.0-dstr(nyrs)+dstr(nyrs)*hm(1))*avg_ret_wt(nyrs)*rret;      //adjust legal weight to retained weight with rret and legal discard
   //Bdis_proj = Rpf(1)*wt(1)+Rpf(2)*wt(2)+Rpf(3)/(1.0-dstr(nyrs)+dstr(nyrs)*hm(1))*dstr(nyrs)*hm(1)*avg_ret_wt(nyrs);
   //Bgft_proj = Rgft(1)*wt(1)+Rgft(2)*wt(2)+Rgft(3)*avg_ret_wt(nyrs);
   //Bgff_proj = Rgff(1)*wt(1)+Rgff(2)*wt(2)+Rgff(3)*avg_ret_wt(nyrs);
					// Mortality (natural and fishing)
					//x = x * S(h)(i)(j);
	/**
	 * @brief calculate effective sample size 
	 * @details Calculate the effective sample size 
	 *
	 * @param observed proportions
	 * @param predicted proportions
	**/
}

double model_parameters::Eff_N(const dvector& pobs, const dvar_vector& phat)
{
	dvar_vector rtmp = elem_div((pobs - phat), sqrt(elem_prod(phat, (1 - phat))));
	double vtmp;
	vtmp = value(norm2(rtmp) / size_count(rtmp));
	return 1.0 / vtmp;
}

double model_parameters::mn_length(const dvector& pobs)
{
	double mobs = (pobs*mid_points);
	return mobs;
	/**
	 * @brief calculate effective sample size 
	 * @details Calculate the effective sample size 
	 *
	 * @param observed proportions
	 * @param predicted proportions
	**/
}

double model_parameters::mn_length(const dvar_vector& pobs)
{
	double mobs = value(pobs*mid_points);
	return mobs;
	/**
	 * @brief calculate effective sample size 
	 * @details Calculate the effective sample size 
	 *
	 * @param observed proportions
	 * @param predicted proportions
	**/
}

double model_parameters::Sd_length(const dvector& pobs)
{
	double mobs = (pobs*mid_points);
	double stmp = sqrt((elem_prod(mid_points,mid_points)*pobs) - mobs*mobs);
	return stmp;
	/**
	 * @brief calculate effective sample size 
	 * @details Calculate the effective sample size 
	 *
	 * @param observed proportions
	 * @param predicted proportions
	**/
}

double model_parameters::Eff_N_adj(const double, const dvar_vector& pobs, const dvar_vector& phat)
{
	int lb1 = pobs.indexmin();
	int ub1 = pobs.indexmax();
	dvector av = mid_points;
	double mobs = value(pobs * av);
	double mhat = value(phat * av);
	double rtmp = mobs - mhat;
	double stmp = value(sqrt(elem_prod(av,av)*pobs - mobs*mobs));
	return square(stmp)/square(rtmp);
	/**
	 * @brief calculate effective sample size 
	 * @details Calculate the effective sample size 
	 *
	 * @param observed proportions
	 * @param predicted proportions
	**/
}

double model_parameters::Eff_N2(const dvector& pobs, const dvar_vector& phat)
{
	int lb1 = pobs.indexmin();
	int ub1 = pobs.indexmax();
	dvector av = mid_points;
	double mobs = (pobs * av);
	double mhat = value(phat * av);
	double rtmp = mobs - mhat;
	double stmp = sqrt(elem_prod(av,av)*pobs - mobs*mobs);
	return square(stmp)/square(rtmp);
}

void model_parameters::set_runtime(void)
{
  dvector temp1("{500,   800,   1500,  25000, 25000}");
  maximum_function_evaluations.allocate(temp1.indexmin(),temp1.indexmax());
  maximum_function_evaluations=temp1;
  dvector temp("{1.e-2, 1.e-2, 1.e-3, 1.e-4, 1.e-4}");
  convergence_criteria.allocate(temp.indexmin(),temp.indexmax());
  convergence_criteria=temp;
}

void model_parameters::final_calcs()
{
	//  Print run time statistics to the screen.
	time(&finish);
	elapsed_time = difftime(finish,start);
	hour = long(elapsed_time)/3600;
	minute = long(elapsed_time)%3600/60;
	second = (long(elapsed_time)%3600)%60;
	cout << endl << endl << "*******************************************" << endl;
	cout << endl << endl << "-------------------------------------------" << endl;
	cout << "--Start time: " << ctime(&start) << endl;
	cout << "--Finish time: " << ctime(&finish) << endl;
	cout << "--Runtime: ";
	cout << hour << " hours, " << minute << " minutes, " << second << " seconds" << endl;
	cout << "--Number of function evaluations: " << nf << endl;
	cout << "*******************************************" << endl;
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
	gradient_structure::set_MAX_DLINKS(150000);
    gradient_structure::set_NO_DERIVATIVES();
#ifdef DEBUG
  #ifndef __SUNPRO_C
std::feclearexcept(FE_ALL_EXCEPT);
  #endif
#endif
    gradient_structure::set_YES_SAVE_VARIABLES_VALUES();
    if (!arrmblsize) arrmblsize=15000000;
    model_parameters mp(arrmblsize,argc,argv);
    mp.iprint=10;
    mp.preliminary_calculations();
    mp.computations(argc,argv);
#ifdef DEBUG
  #ifndef __SUNPRO_C
bool failedtest = false;
if (std::fetestexcept(FE_DIVBYZERO))
  { cerr << "Error: Detected division by zero." << endl; failedtest = true; }
if (std::fetestexcept(FE_INVALID))
  { cerr << "Error: Detected invalid argument." << endl; failedtest = true; }
if (std::fetestexcept(FE_OVERFLOW))
  { cerr << "Error: Detected overflow." << endl; failedtest = true; }
if (std::fetestexcept(FE_UNDERFLOW))
  { cerr << "Error: Detected underflow." << endl; }
if (failedtest) { std::abort(); } 
  #endif
#endif
    return 0;
}

extern "C"  {
  void ad_boundf(int i)
  {
    /* so we can stop here */
    exit(i);
  }
}

#include <admodel.h>
#include "spr.h"


spr::spr(const double& _r, const double& _lambda,
         const dvector& _rx, 
         const dmatrix& _M, const dmatrix& _wa, 
         const d3_array& _A)
:m_rbar(_r),m_lambda(_lambda),m_rx(_rx),m_M(_M),m_wa(_wa),m_A(_A)
{
	m_nsex     = m_M.rowmax();
	m_nclass   = m_rx.indexmax();
	//dmatrix Id = identity_matrix(1,m_nclass);
	
	
	// get unfished mature male biomass per recruit.
	m_ssb0 = 0.0;
	for(int h = 1; h <= m_nsex; h++ )
	{
		dvector surv = exp(-m_M(h));
		// dmatrix At = m_A(h);
		// for(int l = 1; l <= m_nclass; l++ )
		// {
		// 	At(l) *= surv(l);
		// }
		// dmatrix A = trans(At);
		// dvector r = m_rbar/m_nsex * m_rx;
		//dvector x = -solve(A-Id,r);

		dvector x = calc_equilibrium(surv,h);

		double lam;
		h <= 1 ? lam=m_lambda: lam=(1.-m_lambda);
		m_ssb0 += lam * x * m_wa(h);
	}
	
}

spr::~spr()
{}

dvector spr::calc_equilibrium(const dvector& surv, const int& sex)
{

		int h = sex;
		dmatrix Id = identity_matrix(1,m_nclass);
		// use copy constructor for At.
		dmatrix At(1,m_nclass,1,m_nclass);
		At.initialize();
		At = m_A(h);
		for(int l = 1; l <= m_nclass; l++ )
		{
			At(l) *= surv(l);
		}
		dmatrix A = trans(At);
		dvector r = m_rbar/m_nsex * m_rx;
		dvector x = -solve(A-Id,r);
		
		return(x);
}

/**
 * @brief Calculate f_spr reference point.
 * @details Uses bisection method to determine the fishing mortality rate that will reduce
 * the spawning potential ratio to the spr_target.
 * 
 * @param ifleet [description]
 * @param spr_target [description]
 * @param _fhk [description]
 * @param _sel [description]
 * @param _ret [description]
 * @return [description]
 */
double spr::get_fspr(const int& ifleet, const double& spr_target, const dmatrix& _fhk,
	                const d3_array _sel, const d3_array _ret)
{
	m_nfleet  = _fhk.colmax();
	int iter  = 0;
	double fa = 0.00;
	double fb = 2.00;
	double fc = 0.5*(fa+fb);
	dmatrix F = _fhk;
	dvector fratio(1,m_nfleet);
	int k,h;
	m_sel.allocate(_sel);
	m_ret.allocate(_ret);
	m_sel = _sel;
	m_ret = _ret;
	COUT("ok to here")

	do
	{
		m_ssb = 0;
		for( h = 1; h <= m_nsex; h++ )
		{
			F(h)(ifleet) = fc;
			for( k = 1; k <= m_nfleet; k++ )
			{
				fratio(k) = F(h)(k)/F(h)(ifleet);
			}

			dmatrix sel = _sel(h);
			dmatrix ret = _ret(h);
			double dmr = 0.8;
			dvector ftmp(1,m_nclass);
			dvector surv(1,m_nclass);

			ftmp.initialize();
			surv.initialize();
			for( k = 1; k <= m_nfleet; k++ )
			{
				dvector vul = elem_prod(sel(k),ret(k)+(1.0-ret(k))*dmr);
				ftmp += (fc * fratio(k)) * vul;
			}
			surv = exp( -m_M(h) - ftmp);
		
			dvector x = calc_equilibrium(surv,h);
			
			double lam;
			h <= 1 ? lam=m_lambda: lam=(1.-m_lambda);
			m_ssb += lam * x * m_wa(h);

		
		}	
		// spawning potential ratio
		m_spr = m_ssb/m_ssb0;
		
		// test for convergence
		double t1 = m_spr - spr_target;
		if( t1==0 || 0.5*(fb-fa) < TOL )
		{
			m_fspr = fc;
			m_bspr = m_ssb;
			cout<<"Breaking good"<<endl;
			break;
		}

		// bisection update
		if(t1 > 0)
		{
			fa = fc;
		}
		else
		{
			fb = fc;
		}
		// cout<<"iter = "<<iter<<"\tfc = "<<fc<<"\t"<<m_spr<<" - "<<spr_target<<" "<<t1<<endl;
		fc = 0.5*(fa+fb);
	} while (iter++ < MAXIT);

	return m_fspr;
}


/**
 * @brief Calculate fishing mortality rate for OFL
 * @details Use harvest control rule to calculate Fofl
 * @param alpha is the depletion level at 0 fishing.
 * @param limit Depletion level where Fofl = 0
 * @param ssb projected spawning stock biomass
 * @return [description]
 */
double spr::get_fofl(const double& alpha, const double& limit, const double& ssb)
{
	double depletion = ssb/m_bspr;
	m_fofl = 0;
	if( depletion > 1.0 )
	{
		m_fofl = m_fspr;
	}

	if( limit < depletion && depletion <= 1.0 )
	{
		m_fofl = m_fspr * (depletion - alpha)/(1.0-alpha);
	}


	return m_fofl;
}

double spr::get_cofl(const dmatrix& N)
{
	cout<<"Get OFL"<<endl;
	double ctmp = 0;
	double dmr  = 0.8;
	for(int h = 1; h <= m_nsex; h++ )
	{
		for(int k = 1; k <= m_nfleet; k++ )
		{	
			cout<<"h = "<<h<<" k = "<<k<<endl;
			dvector vul = elem_prod(m_sel(h)(k),m_ret(h)(k)+(1.0-m_ret(h)(k))*dmr);
			dvector   f = m_fofl * vul;
			dvector   z = m_M(h) + f;
			dvector   o = 1.0-exp(-z);
			ctmp += N(h)*elem_div(elem_prod(f,o),z);
		}
	}
	m_cofl = ctmp;
	return(m_cofl);
}
















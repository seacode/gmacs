#include <admodel.h>

#ifndef _SPR_H_
#define _SPR_H_

#define MAXIT 100
#define TOL   1.e-4

#undef COUT
#define COUT(object) cout << #object "\n" << setw(6) \
<< setprecision(3) << setfixed() << object << endl;


class spr
{
private:
	int m_nsex;
	int m_nfleet;
	int m_nclass;
	int m_ifleet;

	double  m_rbar;
	double  m_lambda;
	double  m_ssb0; 
	double  m_ssb;  
	double  m_spr;
	double  m_fspr;
	double  m_bspr;
	double  m_fofl;
	double  m_cofl;

	dvector m_rx;
	dvector m_dmr;

	dmatrix m_wa;
	dmatrix m_fref;


	d3_array m_M;
	d3_array m_A;
	d3_array m_P;		// molting probability
	d3_array m_sel;
	d3_array m_ret;
public:
	// constructors
	spr();
	// constructor where nshell == 1
	spr(const double&   _r, 
	    const double&   _lambda,
	    const dvector&  _rx, 
	    const dmatrix&  _wa, 
	    const d3_array& _M, 
      	const d3_array& _A);

	// constructor where nshell == 2 & continous molting
	spr(const double&   _r, 
	    const double &  _lambda,
	    const dvector& 	_rx, 
	    const dmatrix& 	_wa,
	    const d3_array& _M, 
	    const d3_array& _P, 
      	const d3_array& _A);

	// destructor
	~spr();

	// getters
	double get_fspr(const int& ifleet, 
	                const double& spr_target, 
	                const dmatrix& _fhk,
	                const d3_array _sel, 
	                const d3_array _ret,
	                const dvector _dmr);

	double get_bspr() {return m_bspr;}

	
	double get_fofl(const double& alpha, const double& limit, const double& ssb);
	double get_cofl(const dmatrix& N);
	
	dvector calc_equilibrium(const dmatrix& M, const int& sex);
};


#endif
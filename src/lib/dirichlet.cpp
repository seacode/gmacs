/**
 * @file dirichlet.cpp
 * @author D'Arcy N. Webber
**/

// Global headers
#include <admodel.h>

// Local headers
#if defined __APPLE__ || defined __linux
	#include "../include/nloglike.h"
#endif
#if defined _WIN32 || defined _WIN64
	#include "include\nloglike.h"
#endif


/**
 * @brief Dirichlet desity function.
 * @details Negative log likelihood using the Dirichlet distribution.
 * @author D'Arcy N. Webber
 * @param alpha_0 log of effective sample size.
 * @param alpha_t log of relative sample size.
 * @param o observed proportions.
 * @param p predicted proportions
 * @return negative loglikelihood.
**/
//const dvariable acl::dirichlet::ddirichlet(const dvar_vector& alpha_o, const dvar_vector& alpha_t, const dmatrix& o, const dvar_matrix& p) const
const dvariable acl::dirichlet::ddirichlet(const dvar_vector& log_vn, const dmatrix& o, const dvar_matrix& p) const
{
	if ( o.colsize() != p.colsize() || o.rowsize() != p.rowsize() )
	{
		cerr << "Error in dirichlet.cpp, observed and predicted matrixes are not the same size" << endl;
		ad_exit(1);
	}

	dvar_vector vn = mfexp(log_vn);
	dvariable ff = 0.0;
	dvariable lmnB;
	dvariable aj;
	dvariable sj;
	dvariable alpha0;
	int r1 = o.rowmin();
	int r2 = o.rowmax();
	for ( int i = r1; i <= r2; i++ )
	{
		lmnB = 0.0;
		sj = 0.0;
		alpha0 = 0.0;
		dvar_vector alpha = vn(i) * p(i)/sum(p(i));
		dvar_vector obs = o(i)/sum(o(i));
  		int c1 = o(i).indexmin();
	  	int c2 = o(i).indexmax();
		for ( int j = c1; j <= c2; j++ )
		{
			aj = alpha(j);
			alpha0 += aj;
			lmnB += gammln(aj);
			sj += (aj - 1.0) * log(1e-10 + obs(j));
		}
		lmnB -= gammln(alpha0);
		ff += sj - lmnB;
	}
	return -ff;
}

const dmatrix acl::dirichlet::pearson_residuals(const dvar_vector& log_vn, const dmatrix& o, const dvar_matrix p) const
{
	dvector vn = value(mfexp(log_vn));
	dmatrix res = o - value(p);
	// dmatrix var = value(elem_prod(p,1.0-p)) / vn;
	for ( int i = o.rowmin(); i <= o.rowmax(); i++ )
	{
		dvector var = value(elem_prod(p(i),1.0-p(i))) / vn(i);
		res(i) = elem_div(res(i),sqrt(var+TINY));
	}
	return res;
}

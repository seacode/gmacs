/**
 * @file robust_multi.cpp
 * @author Steve Martell, D'Arcy N. Webber
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
 * @brief robust multinomial desity function with estimated effective sample size.
 * @details Robustified Multinomia likelihood for composition data following Fournier's approach.
 * @author Dave Fournier & Jim Ianelli
 * @param log_vn log of effective sample size.
 * @param o observed proportions.
 * @param p predicted proportions
 * @return negative loglikelihood.
 */
const dvariable acl::robust_multi::pdf(const dmatrix& O,
				       const dvar_matrix& P,
				       const dvar_vector& lnN) const
 {
	if( lnN.indexmin() != O.rowmin() || lnN.indexmax() != O.rowmax() )
	{
		cerr<<"Sample size index do not match row index in\
		       observed size composition matrix."<<endl;
		ad_exit(1);
	}
	RETURN_ARRAYS_INCREMENT();
	dvariable nll = 0;
	// double tiny = 1.e-14;
  	double  a  = .1/size_count(O(1));
  	dvar_vector b  = exp(lnN);

	for(int i = O.rowmin(); i <= O.rowmax(); i++ )
	{
		dvector      o =  O(i) + TINY;
		dvar_vector  p =  P(i) + TINY;
		o /= sum(o);
		p /= sum(p);

		// Old version
		//dvar_vector v = a  + 2. * elem_prod(o ,1.  - o );
		//dvar_vector l  =  elem_div(square(p - o), v );
		//nll -= sum(log(mfexp(-1.* b(i) * l) + .01));
		//nll += 0.5 * sum(log(v));

		// AEP use below
		dvar_vector v = a  + elem_prod(o ,1.  - o );
		dvar_vector l  =  0.5*elem_div(square(p - o), v );
		nll -= sum(log(mfexp(-1.* b(i) * l) + .01));
		nll += 0.5 * sum(log(v/b(i)));
	}
	RETURN_ARRAYS_DECREMENT();
	return nll;
}


const dmatrix acl::robust_multi::pearson_residuals(const dmatrix& O,
                                				const dvar_matrix P,
                                				const dvar_vector& log_vn) const
{
	dvector vn = value(mfexp(log_vn));
	dmatrix res = O - value(P);


	for(int i = O.rowmin(); i <= O.rowmax(); i++ )
	{
		dvector o   = O(i) + TINY;
		dvector p   = value(P(i)) + TINY;
		dvector var = elem_prod(o,1.0-o) / vn(i);
		res(i)      = elem_div(o - p,sqrt(var));
	}
	return res;
}

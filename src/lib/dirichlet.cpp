#include <admodel.h>
#if defined __APPLE__ || defined __linux
	#include "../include/nloglike.h"
#endif
#if defined _WIN32 || defined _WIN64
	#include "include\nloglike.h"
#endif


/**
 * @brief Dirichlet desity function.
 * @details Negative log likelihood using the Dirichlet distribution.
 * @author Darcy N. Webber
 * @param alpha_0 log of effective sample size.
 * @param alpha_t log of relative sample size.
 * @param o observed proportions.
 * @param p predicted proportions
 * @return negative loglikelihood.
 */
const dvariable acl::dirichlet::pdf(
				    const dvar_vector& alpha_o,
				    const dvar_vector& alpha_t, 
				    const dmatrix& o, 
				    const dvar_matrix& p) const
{
	if(o.colsize()!=p.colsize() || o.rowsize()!=p.rowsize())
	{
		cerr<<"Error in dirichlet.cpp, "
		" observed and predicted matrixes"
		" are not the same size"<<endl;
		ad_exit(1);
	}

	dvar_vector vn = mfexp(alpha_t);
	dvariable ff = 0;
	int r1 = o.rowmin();
	int r2 = o.rowmax();
	for(int i = r1; i <= r2; i++ )
	{
  		int c1 = o(i).indexmin();
	  	int c2 = o(i).indexmax();
		dvar_vector sobs = vn(i) * o(i)/sum(o(i));  
		ff -= gammln(vn(i));
		for(int j = c1; j <= c2; j++ )
		{
			if( value(sobs(j)) > 0.0 )
				ff += gammln(sobs(j));
		}
		ff -= sobs * log(TINY + p(i));
	}
	return ff;
}

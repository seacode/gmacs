#include "nloglike.h"
#include <admodel.h>
/**
 * @brief multinomial desity function with estimated effective sample size.
 * @details Negative log likelihood using the multinomial distribution.	
 * @author Dave Fournier
 * @param log_vn log of effective sample size.
 * @param o observed proportions
 * @param p predicted proportions
 * @return negative loglikelihood.
 */
const dvariable acl::multinomial::dmultinom(const dvariable& log_vn,
                                            const dmatrix& o, 
                                            const dvar_matrix& p) const
{
	if(o.colsize()!=p.colsize() || o.rowsize()!=p.rowsize())
	{
		cerr<<"Error in multivariate_t_likelihood, "
		" observed and predicted matrixes"
		" are not the same size"<<endl;
		ad_exit(1);
	}

	
	dvariable vn  = mfexp(log_vn);
	dvariable ff = 0;
	int r1 = o.rowmin();
	int r2 = o.rowmax();
	int c1 = o.colmin();
	int c2 = o.colmax();
	for(int i = r1; i <= r2; i++ )
	{
		//scale observed numbers by effective sample size.
		dvar_vector sobs = vn * o(i)/sum(o(i));  
		ff -= gammln(vn);
		for(int j = c1; j <= c2; j++ )
		{
			if( value(sobs(j)) > 0.0 )
				ff += gammln(sobs(j));
		}
		ff -= sobs * log(TINY + p(i));
	}

	return ff;
}


const dmatrix acl::multinomial::pearson_residuals(const dvariable& log_vn,
                                									const dmatrix& o,
                                									const dvar_matrix p) const
{
	double vn = value(mfexp(log_vn));
	dmatrix res = o - value(p);
	dmatrix var = value(elem_prod(p,1.0-p)) / vn;
	for(int i = o.rowmin(); i <= o.rowmax(); i++ )
	{
		res(i) = elem_div(res(i),sqrt(var(i)+TINY));
	}
	return res;
}



// dvariable mult_likelihood(const dmatrix &o, const dvar_matrix &p, dvar_matrix &nu, 
//                           const dvariable &log_vn)
// {

// 	// kludge to ensure observed and predicted matrixes are the same size
// 	if(o.colsize()!=p.colsize() || o.rowsize()!=p.rowsize())
// 	{
// 		cerr<<"Error in multivariate_t_likelihood, observed and predicted matrixes"
// 		" are not the same size"<<endl;
// 		ad_exit(1);
// 	}
	
// 	dvariable vn = mfexp(log_vn);
// 	dvariable ff = 0.0;
// 	int r1 = o.rowmin();
// 	int r2 = o.rowmax();
// 	int c1 = o.colmin();
// 	int c2 = o.colmax();

// 	for(int i = r1; i <= r2; i++ )
// 	{
// 		dvar_vector sobs = vn * o(i)/sum(o(i));  //scale observed numbers by effective sample size.
// 		ff -= gammln(vn);
// 		for(int j = c1; j <= c2; j++ )
// 		{
// 			if( value(sobs(j)) > 0.0 )
// 				ff += gammln(sobs(j));
// 		}
// 		ff -= sobs * log(TINY + p(i));
		
// 		dvar_vector o1=o(i)/sum(o(i));
// 		dvar_vector p1=p(i)/sum(p(i));
// 		nu(i) = elem_div(o1-p1,sqrt(elem_prod(p1,1.-p1)/vn));


// 	}
// 	// exit(1);
// 	return ff;
// }
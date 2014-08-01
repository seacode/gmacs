#include "nloglike.h"
using namespace likelihoods;


nloglike::nloglike(const dmatrix& _O, const dvar_matrix& _P)
:m_O(_O),m_P(_P)
{
	r1 = m_O.rowmin();
	r2 = m_O.rowmax();
	c1 = m_O.colmin();
	c2 = m_O.colmax();
	tail_compression();
	m_residual.allocate(r1,r2,c1,c2);
}

nloglike::~nloglike()
{

}

  /**
   * @brief Multivariate logistic likelihood
   * @details This is a modified version of the dmvlogistic negative log likelihood
		where proportions at age less than minp are pooled into the consecutive 
		age-classes.  See last paragraph in Appendix A of Richards, Schnute and
		Olsen 1997. 
   * @return negative log likelihood.
   */
dvariable nloglike::dmvlogistic()
{
	
	int n = 0;
	dvariable nll = 0;
	dvar_matrix nu;
	nu.allocate(m_Pr);
	nu.initialize();
	

	for(int i = r1; i <= r2; i++ )
	{
		if(min(m_Pr(i))==0) {cout<<"Deal with zeros"<<endl; exit(1);}
		nu(i)  = log(m_Or(i)) - log(m_Pr(i));
		nu(i) -= mean(nu(i));
		n += size_count(nu(i)) -1;
	}
	dvariable tau2 = 1/n * norm2(nu);
	nll = n * log(tau2+0.001);
	return nll;
}

/**
 * @brief Multinomial likleihood for composition data.
 * @details [long description]
 * 
 * @param dSampleSize The assumed sample size in the multinomial distribution.
 * @return returns the negative log likelihood.
 */	
dvariable nloglike::multinomial(const dvector& dSampleSize)
{
	if( dSampleSize.indexmin() != m_Or.rowmin() || dSampleSize.indexmax() != m_Or.rowmax() )
	{
		cerr<<"Sample size index do not match row index in\
		       observed size composition matrix."<<endl;
		ad_exit(1);
	}
	RETURN_ARRAYS_INCREMENT();
	dvariable nll = 0;
	double tiny = 1.e-14;
	for(int i = r1; i <= r2; i++ )
	{
		dvector o = m_Or(i) + tiny;
		dvar_vector p = m_Pr(i) + tiny;
		o /= sum(o);
		p /= sum(p);
		
		dvector n = dSampleSize(i) * o;
		nll += dmultinom(n,p);
	}
	RETURN_ARRAYS_DECREMENT();
	return nll;
}


dvariable nloglike::dmultinom(const dvector& x, const dvar_vector& p)
{
	if(x.indexmin() != p.indexmin() || x.indexmax() != p.indexmax())
	{
		cerr << "Index bounds do not macth in"
		" dmultinom(const dvector& x, const dvar_vector& p)\n";
		ad_exit(1);
	}
	
	double n=sum(x);
	return -gammln(n+1.)+sum(gammln(x+1.))-x*log(p/sum(p));
}

dmatrix nloglike::residuals(const dvector& dSampleSize)
{
	m_residual.initialize();
	for(int i = r1; i <= r2; i++ )
	{
		dvector var = value(elem_prod(m_Pr(i),1.0-m_Pr(i)) / dSampleSize(i));
		dvector res = elem_div(m_Or(i)-value(m_Pr(i)),sqrt(var + 0.01/(c2-c1)));
		m_residual(i)(jmin(i),jmax(i)) = res;
	}
	return (m_residual);
}

/**
 * @brief Tail compression
 * @details This algorithim compresses the tails of a size composition matrix, such that
 * there are no zeros at the tails of the size composition data that would interfear
 * with the likelihood calculation.  Note that the data that is less than pmin 
 * is pooled (cululative sum) into the tails of a ragged object.
 */
void nloglike::tail_compression()
{
	
	double pmin = 0.001;
	

	jmin.allocate(r1,r2);
	jmax.allocate(r1,r2);

	for(int i = r1; i <= r2; i++ )
	{
		
		dvector o = m_O(i);

		jmin(i) = c1+1;		// index for min column
		jmax(i) = c2;			// index for max column
		dvector cumsum = o/sum(o);
		for(int j = c1+1; j <= c2; j++ )
		{
			 cumsum(j) += cumsum(j-1);
			 cumsum(j) <= pmin ? jmin(i)++ : NULL;
			 j != c2 ? 1.0 - cumsum(j) < pmin ? jmax(i)-- : NULL : NULL;
		}

	}

	// now allocate ragged arrays
	m_Or.allocate(r1,r2,jmin,jmax);
	m_Pr.allocate(r1,r2,jmin,jmax);
	m_Or.initialize();
	m_Pr.initialize();

	// fill ragged arrays
	for(int i = r1; i <= r2; i++ )
	{
		dvector cso     = m_O(i)/sum(m_O(i));
		dvar_vector csp = m_P(i)/sum(m_P(i));
		m_Or(i)(jmin(i),jmax(i)) = cso(jmin(i),jmax(i));
		m_Pr(i)(jmin(i),jmax(i)) = csp(jmin(i),jmax(i));

		// add cumulative sum to tails.
		m_Or(i)(jmin(i)) = sum(cso(c1,jmin(i)));
		m_Or(i)(jmax(i)) = sum(cso(jmax(i),c2));
		m_Pr(i)(jmin(i)) = sum(csp(c1,jmin(i)));
		m_Pr(i)(jmax(i)) = sum(csp(jmax(i),c2));

	//cout<<jmin(i)<<" "<<jmax(i)<<" "<<m_Or(i)<<endl;
	}
	
}
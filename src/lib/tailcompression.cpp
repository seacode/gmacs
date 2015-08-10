/**
 *  @file tailcompression.cpp
 *  @author Steve Martell, D'Arcy N. Webber
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
 * @brief Determine non-zero array elements for tail compression.
 *
 * @details This routine fills the member variables m_jmin and m_jmax with the
 * array indexes that correpsond to the cumulative sum that is greater than
 * pmin, and 1-pmin respectively. This is then later used to construct ragged
 * objects to be used in the likelihood functions.
 *
 * @return void
 * @author Steve Martell, D'Arcy N. Webber
**/
void acl::negativeLogLikelihood::tail_compression()
{
	// cout<<"Running tail compression"<<endl;
	double pmin = 0.001;
	m_jmin.allocate(r1,r2);
	m_jmax.allocate(r1,r2);

	for( int i = r1; i <= r2; i++ )
	{
		dvector o = m_O(i);
		m_jmin(i) = c1 + 1; // index for min column
		m_jmax(i) = c2;     // index for max column
		dvector cumsum = o / sum(o);
		for ( int j = c1+1; j <= c2; j++ )
		{
			cumsum(j) += cumsum(j-1);
			//cumsum(j) <= pmin ? m_jmin(i)++ : NULL;
			//j != c2 ? 1.0 - cumsum(j) < pmin ? m_jmax(i)-- : NULL : NULL;
			if (cumsum(j) <= pmin) m_jmin(i)++;
			if (j != c2 && 1.0-cumsum(j) < pmin) m_jmax(i)--;
		}
	}
}

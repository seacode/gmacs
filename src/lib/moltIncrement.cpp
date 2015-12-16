#include <admodel.h>
#if defined __APPLE__ || defined __linux
	#include "../include/libgmacs.h"
#endif
#if defined _WIN32 || defined _WIN64
	#include "include\libgmacs.h"
#endif


/**
 * @brief Return molt increment matrix based on empirical data
 *
 * @details Fits a cubic spline to the empirical data. Note that the spline
 * function strictly requires increasing values for each of the knots.
 * 
 * @param bin a dvector of the size bins
 * @param data a dmatrix of the data
 * @return dmatrix of molt increments by sex for each size bin
**/
dmatrix get_empirical_molt_increment(const dvector& bin, const dmatrix& data)
{
	cout << "In get_empirical_molt_increment" << endl;
	int n = bin.size();
	ivector sex = ivector(column(data,2));
	int nsex = count_factor(sex);
	dmatrix mi(1,nsex,1,n);
	ivector nh(1,nsex);
	nh.initialize();
	
	// Count number of observations in each sex.
	for ( int i = 1; i <= data.rowmax(); ++i )
	{
		int h = sex(i);
		nh(h) ++;
	}
	// get male and famale arrays
	dmatrix x(1,nsex,1,nh);
	dmatrix y(1,nsex,1,nh);
	int bb=1; 
	int gg=1;
	for ( int i = 1; i <= data.rowmax(); ++i )
	{
		int h = sex(i);
		int j = h==1 ? bb++ : gg++ ;
		x(h,j) = data(i,1);
		y(h,j) = data(i,3);	
	}
	// rescale size to 0-1 over bin width
	for ( int h = 1; h <= nsex; ++h )
	{
		dvector knts = (x(h) - min(x(h))) / (max(x(h)) - min(x(h)));
		dvector pnts = (bin  - min(bin)) / (max(bin) - min(bin));
		COUT(knts);
		COUT(y(h));
		cubic_spline_function cSmooth(knts,y(h));
		dvector test = cSmooth(pnts);
		COUT(cSmooth(0.5));
		COUT(test);
	}
	cout << "leaving get_empirical_molt_increment" << endl;
	return mi;
}

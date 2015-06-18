#include <admodel.h>

#if defined __APPLE__ || defined __linux
#include "../../src/include/libgmacs.h"
#endif

#if defined _WIN32 || defined _WIN64
#include "include\libgmacs.h"
#endif
/**
 *
 * \def COUT(object)
 * Prints object to screen during runtime.
 * cout <<setw(6) << setprecision(3) << setfixed() << x << endl;
 */
#undef COUT
#define COUT(object) cout << #object "\n" << setw(6) \
<< setprecision(3) << setfixed() << object << endl;

/*
	A simple program to test the atlernative selectivity options.
*/

dvector logistic(const dvector& x, const double& p1, const double p2)
{
	cstar::Selex<dvector> *pSLX;
	pSLX = new cstar::LogisticCurve<dvector,double>(p1,p2);
	dvector sel =  pSLX -> Selectivity(x);
	delete pSLX;
	return(sel);
}

dvector logistic95(const dvector& x, const double& p1, const double p2)
{
	cstar::Selex<dvector> *pSLX;
	pSLX = new cstar::LogisticCurve95<dvector,double>(p1,p2);
	dvector sel =  pSLX -> Selectivity(x);
	delete pSLX;
	return(sel);
}

dvector selcoffs(const dvector& x, const dvector& p)
{
	cstar::Selex<dvector> *pSLX;
	pSLX = new cstar::SelectivityCoefficients<dvector>(p);
	dvector sel = pSLX -> Selectivity(x);
	delete pSLX;
	return (sel);
}


int main(int argc, char const *argv[])
{
	/* mid points of the size bins */
	dvector x(1,20);
	x.fill_seqadd(67.5,5);
	COUT(x);

	COUT(logistic(x, 115,10));
	COUT(logistic95(x,115,125));
	dvector p(1,20);
	p.fill_seqadd(-5,1);
	COUT(selcoffs(x,p));


	return 0;
}
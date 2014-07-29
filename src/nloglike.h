#include <admodel.h>

#ifndef NLOGLIKE_H
#define NLOGLIKE_H

namespace likelihoods
{

class nloglike
{
private:
	int r1;
	int r2;
	int c1;
	int c2;

	ivector jmin;
	ivector jmax;

	dmatrix m_O;
	dmatrix m_Or;
	dmatrix m_residual;

	dvar_matrix m_P;
	dvar_matrix m_Pr;

public:
	~nloglike();
	nloglike(const dmatrix& _O, const dvar_matrix& _P);

	void tail_compression();
	dvariable multinomial(const dvector& dSampleSize);
	dvariable dmultinom(const dvector& x, const dvar_vector& p);

	dvariable dmvlogistic();

	dmatrix residuals(const dvector& dSampleSize);
	
};




}
#endif
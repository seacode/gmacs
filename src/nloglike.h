#include <admodel.h>

#ifndef NLOGLIKE_H
#define NLOGLIKE_H

#define TINY     1.e-08

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

} // namespace





namespace acl
{


	// Base class for negative log likelihoods
	class negativeLogLikelihood
	{
	private:
		dmatrix m_O;

	public:
		virtual const dvariable nloglike(const dmatrix& _O) const = 0;
		virtual const   dmatrix residual(const dmatrix& _O) const = 0;
		
		//negativeLogLikelihood(){};
		 ~negativeLogLikelihood(){}
		
		dmatrix get_O()     const{ return m_O;    }
		void    set_O(dmatrix _O){ this->m_O = _O;}


	};



	

	class multinomial: public negativeLogLikelihood
	{
	private:
		int r1,r2;
		int c1,c2;
		
		dvariable   m_log_vn;
		dvar_matrix m_P;

	public:
		multinomial(const dvariable &_log_vn,const dvar_matrix &_P)
		: m_log_vn(_log_vn), m_P(_P) {}
		~multinomial();

		dvariable get_n()      const { return m_log_vn;    }
		void      set_n(dvariable _n){ this->m_log_vn = _n;}

		dvar_matrix get_P()         const { return m_P;    }
		void        set_P(dvar_matrix _P) { this->m_P = _P;}

	  
		// negative log likelihood
		const dvariable nloglike(const dmatrix& _O) const
		{
			return dmultinom(this->get_n(),_O,this->get_P());
		}

		const   dmatrix residual(const dmatrix& _O) const
		{
			return pearson_residuals(this->get_n(),_O,this->get_P());
		}
		
		
		const dvariable dmultinom(const dvariable& log_vn,
	                          const dmatrix& o, 
	                          const dvar_matrix& p) const;

		const dmatrix pearson_residuals(const dvariable& log_vn,
                  									const dmatrix& o,
                  									const dvar_matrix p) const;
	};
}

#endif


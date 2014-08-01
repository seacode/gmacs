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
		int r1,r2;
		int c1,c2;
		ivector m_jmin;
		ivector m_jmax;
		dmatrix m_O;
		dmatrix m_Or;

	public:
		//virtual const dvariable nloglike(const dmatrix& _O) const = 0;
		//virtual const   dmatrix residual(const dmatrix& _O) const = 0;
		
		virtual const dvariable nloglike(const dvariable& _n, const dvar_matrix& _P) const = 0;
		virtual const   dmatrix residual(const dvariable& _n, const dvar_matrix& _P) const = 0;

		negativeLogLikelihood(){}
		negativeLogLikelihood(const dmatrix& _O)
		:m_O(_O) 
		{
			r1 = m_O.rowmin();
			r2 = m_O.rowmax();
			c1 = m_O.colmin();
			c2 = m_O.colmax();
		}
		~negativeLogLikelihood(){}
		
		dmatrix get_O()     const{ return m_O;    }
		void    set_O(dmatrix _O){ this->m_O = _O;}

		dmatrix get_Or()     const{ return m_Or;    }
		void    set_Or(dmatrix _O){ this->m_Or = _O;}

		const ivector get_jmin() const { return m_jmin; }
		const ivector get_jmax() const { return m_jmax; }

		void tail_compression();

		template <typename T>
		const T compress(const T& _M) const;

	};

  
	template <typename T>
	const T acl::negativeLogLikelihood::compress(const T& _M) const
	{
		cout<<"In compress"<<endl;
	
		T R;
		T M = _M;
		R.allocate(r1,r2,m_jmin,m_jmax);
		R.initialize();

		// fill ragged array R
		for(int i = r1; i <= r2; i++ )
		{
			M(i) /= sum(M(i));
			R(i)(m_jmin(i),m_jmax(i)) = M(i)(m_jmin(i),m_jmax(i));

			// add cumulative sum to tails.
			R(i)(m_jmin(i)) = sum(M(i)(c1,m_jmin(i)));
			R(i)(m_jmax(i)) = sum(M(i)(m_jmax(i),c2));
		}
		return R;
	}

	

	class multinomial: public negativeLogLikelihood
	{
	private:
		bool        m_bCompress;
		dvariable   m_log_vn;
		dvar_matrix m_P;

	public:

		multinomial(const dmatrix &_O,const bool bCompress=false)
		: negativeLogLikelihood(_O),m_bCompress(bCompress) 
		{
			if(m_bCompress) tail_compression();

		}

		~multinomial();

		dvariable get_n()      const { return m_log_vn;    }
		void      set_n(dvariable _n){ this->m_log_vn = _n;}

		dvar_matrix get_P()         const { return m_P;    }
		void        set_P(dvar_matrix _P) { this->m_P = _P;}

	
		// negative log likelihood
		const dvariable nloglike(const dvariable& log_vn, const dvar_matrix& _P) const 
		{
			if(m_bCompress)
			{
				dmatrix     Or = compress(this->get_O());
				dvar_matrix Pr = compress(_P);
				return dmultinom(log_vn,Or,Pr);
			}
			else
			{
				return dmultinom(log_vn,this->get_O(),_P);	
			}
		}

		// pearson residuals
		const   dmatrix residual(const dvariable& _n, const dvar_matrix& _P) const
		{
			return pearson_residuals(_n,this->get_O(),_P);
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


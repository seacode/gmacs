
#ifndef SELEX_HPP
#define SELEX_HPP

#include <admodel.h>
// #include "cstar.h"

/**
 * @defgroup Selectivities
 * @Selectivities Alternative selectivity functions in the cstar namespace are
 * derived from the cstar::Selex base class. 
 * 
 * @file selex.hpp 
 * 
 * @author Steven Martell
 * @date   Feb 10, 2014
 * 
 * <br> Available Selectivity options are: <br><br>
 * <br>Selectivity              FUNCTIONS                Class name
 * <br>Logistic                 plogis                   LogisticCurve
 * <br>Nonparametric            nonparametric            SelectivityCoefficients
 * <br>
 */

namespace cstar {

// =========================================================================================================
// Selex: Defined Base Class for Selectivity Functions
// =========================================================================================================

	/**
	 * @ingroup Selectivities
	 * @brief An abstract class for Selectivity functions.	
	 * @details Classes that derive from this class overload the pure virtual functions:<br><br>
	 * const T Selectivity(const T &x) const <br>
	 * 
	 * @tparam x Independent variable (ie. age or size) for calculating selectivity.
	 */

	template<class T>
	class Selex
	{
	private:
		T m_x;

	public:
		virtual  const T Selectivity(const T &x) const = 0;

		virtual  const T logSelectivity(const T &x) const = 0;

		virtual  const T logSelexMeanOne(const T &x) const = 0;
		
		virtual ~Selex(){}

		void Set_x(T & x) { this-> m_x = x; }
		T    Get_x() const{ return m_x;     }
	};

// =========================================================================================================
// plogis: Base functions for logistic-based selectivity functions
// =========================================================================================================

	/* Traits for the vonBertalaffy template function*/
	template <typename T2>
	class logisticTrait;

	template<>
	class logisticTrait<double> {
	public:
		typedef dvector plogisT;
	};

	template<>
	class logisticTrait<named_dvariable> {
	public:
		typedef dvar_vector plogisT;
	};


	/**
	 * @brief Logistic function
	 * @details Basic two parameter logistic function with mean and standard deviation
	 * 
	 * @param  x Independent variable (e.g. age or size)
	 * @tparam T data vector or dvar vector
	 * @tparam T2 double or dvariable for mean and standard deviation of the logistic curve
	 * 
	 * template <typename T, typename T1>
		inline
		typename vonBtrait<T>::vonBT vonBertalanffy(const T &lmin, const T &lmax, const T &rho, const T1 &age)
		{
			typedef typename vonBtrait<T>::vonBT vonBT;
	 */

	//typename logisticTrait<T>::plogisT plogis(const T &x, const T2 &mean, const T2 &sd)
	template<class T,class T2>
	inline
	const T plogis(const T &x, const T2 &mean, const T2 &sd)
	{
		//typedef typename logisticTrait<T>::plogisT plogisT;
		T selex = T2(1.0)/(T2(1.0)+mfexp(-(x-mean)/sd));
		return selex;
	}

	
	template<class T, class T2>
	inline
	const T plogis95(const T &x, const T2 &s50, const T2 &s95)
	{
		T selex = T2(1.0)/(T2(1.0)+(exp(-log(19)*((x-s50)/(s95-s50)))));
		selex   /= selex(selex.indexmax());	
		return selex;
	}

// =========================================================================================================
// LogisticCurve: Logistic-based selectivity function with options
// =========================================================================================================

	/**
	 * @brief Logistic curve
	 * @details Uses the logistic curve (plogis) for a two parameter function
	 * 
	 * @tparam T data vector or dvar vector
	 * @tparam T2 double or dvariable for mean and standard deviation of the logistic curve
	 */

	template<class T,class T2>
	class LogisticCurve: public Selex<T>
	{
	private:
		T2 m_mean;
		T2 m_std;

	public:
		LogisticCurve(T2 mean = T2(0), T2 std = T2(1))
		: m_mean(mean), m_std(std) {}

		T2 GetMean() const { return m_mean; }
		T2 GetStd()  const { return m_std;  }

		void SetMean(T2 mean) { this->m_mean = mean;}
		void SetStd(T2 std)   { this->m_std  = std; }

		const T Selectivity(const T &x) const
		{
			return cstar::plogis(x, this->GetMean(), this->GetStd());
		}

		const T logSelectivity(const T &x) const
		{
			return log(cstar::plogis(x, this->GetMean(), this->GetStd()));
		}

		const T logSelexMeanOne(const T &x) const
		{
			T y = log(cstar::plogis(x, this->GetMean(), this->GetStd()));
			y  -= log(mean(mfexp(y)));
			return y;
		}

	};

// =========================================================================================================
// LogisticCurve95: Logistic-based selectivity function with options
// =========================================================================================================

  /**
   * @brief Logistic curve parameterised with 5% and 95% selectivity
   * @details Uses the logistic curve (plogis95) for a two parameter function
   * 
   * @tparam T data vector or dvar vector
   * @tparam T2 double or dvariable for size at 5% and 95% selectivity
   */

  template<class T,class T2>
  class LogisticCurve95: public Selex<T>
  {
  private:
    T2 m_s50;
    T2 m_s95;

  public:
    LogisticCurve95(T2 s50 = T2(1), T2 s95 = T2(1))
    : m_s50(s50), m_s95(s95) {}

    T2 GetS50()  const { return m_s50; }
    T2 GetS95()  const { return m_s95; }

    void SetS50(T2 s50) { this->m_s50 = s50; }
    void SetS95(T2 s95) { this->m_s95 = s95; }

    const T Selectivity(const T &x) const
    {
      return cstar::plogis95<T>(x, this->GetS50(), this->GetS95());
    }

    const T logSelectivity(const T &x) const
    {
      return log(cstar::plogis95<T>(x, this->GetS50(), this->GetS95()));
    }

    const T logSelexMeanOne(const T &x) const
    {
      T y = log(cstar::plogis95<T>(x, this->GetS50(), this->GetS95()));
      y  -= log(mean(mfexp(y)));
      return y;
    }

  };

// =========================================================================================================
// coefficients: Base function for non-parametric selectivity cooefficients 
// =========================================================================================================

	/**
	 * @brief Nonparametric selectivity coefficients
	 * @details Assumes that the last age/size class has the same selectivity coefficient
	 * as the terminal sel_coeffs.
	 * 
	 * @param x Independent variable
	 * @param sel_coeffs Vector of estimated selectivity coefficients.
	 * @return Selectivity coefficients.
	 */
	template<class T>
	const T coefficients(const T &x, const T &sel_coeffs)
	{
		int x1 = x.indexmin();
		int x2 = x.indexmax();
		int y2 = sel_coeffs.indexmax();
		T y(x1,x2);
		for(int i = x1; i < y2; i++ )
		{
			y(i) = sel_coeffs(i);
		}
		y(y2,x2) = sel_coeffs(y2);
		return y;
	}

// =========================================================================================================
// SelectivityCoefficients: Age/size-specific selectivity coefficients for n-1 age/size classes
// =========================================================================================================	

	/**
	 * @brief Selectivity coefficients
	 * @details Age or size-specific selectivity coefficients for n-1 age/size classes
	 * 
	 * @tparam T vector of coefficients
	 */
	template<class T>
	class SelectivityCoefficients: public Selex<T>
	{
	private:
		T m_sel_coeffs;

	public:
		SelectivityCoefficients(T params = T(1))
		:m_sel_coeffs(params) {}

		T GetSelCoeffs() const { return m_sel_coeffs;    }
		void SetSelCoeffs(T x) { this->m_sel_coeffs = x; }

		const T Selectivity(const T &x) const
		{
			// Call the age/size specific function
			return cstar::coefficients(x, this->GetSelCoeffs());
		}

		const T logSelectivity(const T &x) const
		{
			// Call the age/size specific function
			return log(cstar::coefficients(x, this->GetSelCoeffs()));
		}

		const T logSelexMeanOne(const T &x) const
		{
			T y = log(cstar::coefficients(x, this->GetSelCoeffs()));
			y  -= log(mean(mfexp(y)));
			return y;
		}
	};

// =========================================================================================================
// nonparametric: Base function for parametric selectivity option 
// =========================================================================================================

	/**
	 * @brief Nonparametric selectivity function
	 * @details Estimate one parameter per age/size class, and rescale to maximum of one.
	 * 
	 * @param x Independent variable (number of classes)
	 * @param selparms Vector of selectivity parameters (initial values).
	 * @return Selectivity values.
	 */
	template<class T>
	const T nonparametric(const T &x, const T &selparms)
	{
	  int x2 = x.indexmax();
	  dvar_vector selex(1,x2);
		for (int i=1; i<=x2; i++)
    	selex(i) = (1.0)/(1.0+mfexp(selparms(i)));
	  dvariable temp = selex(x2);
    selex /= temp;
    return selex;
	}

// =========================================================================================================
// ParameterPerClass: One age/size-specific selectivity parameter for each age/size class
// =========================================================================================================	

	/**
	 * @brief Parametric selectivity function
	 * @details One age or size-specific selectivity parameter for each age/size class.
	 * 
	 * @tparam T vector of parameters (initial values)
	 */
	template<class T>
	class ParameterPerClass: public Selex<T>
	{
	private:
		T m_selparms;

	public:
		ParameterPerClass(T selparms = T(1))
		:m_selparms(selparms) {}

		T GetSelparms() const { return m_selparms; }
		void SetSelparms(T selparms) { this->m_selparms = selparms; }

		const T Selectivity(const T &x) const
		{
			// Call the age/size specific function
			return cstar::nonparametric(x, this->GetSelparms());
		}

		const T logSelectivity(const T &x) const
		{
			// Call the age/size specific function
			return log(cstar::nonparametric(x, this->GetSelparms()));
		}

		const T logSelexMeanOne(const T &x) const
		{
			T y = log(cstar::nonparametric(x, this->GetSelparms()));
			//y  -= log(mean(mfexp(y)));
			return y;
		}
	};

}//cstar


#endif /* SELEX_HPP */   	

// EOF.
// =========================================================================================================
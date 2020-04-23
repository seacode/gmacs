/**
 * @file selex.hpp
 * @defgroup Selectivities
 * @author Steven Martell, D'Arcy N. Webber, William Stockhausen
 * @namespace gsm
 * @date Feb 10, 2014
 * @title Selectivity functions
 * @details Alternative selectivity functions in the gsm namespace are derived from the gsm::Selex base class.
 *
 * The Selex class is an abstract class that contains 3 virtual methods.
 * - **Selectivity** 	Arithmetic 0-1 values of selectivity values.
 * - **logSelectivity**	Returns selectivity vector in log-space.
 * - **logSelexMeanOne** Returns selectivity in log-space and rescaled to have mean 1
 * in arithmetic space.
 *
 * Example of how to use this class to create a selectivity vector.
 *
 * 		// Declare a pointer to the abstract base class Selex.
 * 		// Cast the <type> of variable that the class will return.
 * 		gsm::Selex<dvector> *pSLX;
 *
 * 		// Instantiate a new Logistic curve selectivity with parameters p1 & p2
 * 		pSLX = new gsm::LogisticCurve<dvector,double>(p1,p2);
 *
 * 		// Call one of the available methods in the abstract class for size bins x
 * 		sex = pSLX -> Selectivity(x);
 *
 * Table 1. List of available selectivity functions, function names, and the class
 * object.
 * | Selectivity    | Functions     | Class name              |
 * |----------------|---------------|-------------------------|
 * | Logistic       | plogis        | LogisticCurve           |
 * | Logistic95     | plogis95      | LogisticCurve95         |
 * | Coefficients   | selcoffs      | SelectivityCoefficients |
 * | Nonparameteric | nonparametric | ParameterPerClass       |
 * | Uniform        | uniform       | UniformCurve            |
**/

#ifndef SELEX_HPP
#define SELEX_HPP

// Global headers
#include <admodel.h>

#include "gsm_splines.hpp"
// #include "gsm.h"


namespace gsm {

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
    **/

    template<class T>
    class Selex
    {

    private:
            T m_x;

    public:
            virtual const T Selectivity(const T &x) const = 0;
            virtual const T logSelectivity(const T &x) const = 0;
            virtual const T logSelexMeanOne(const T &x) const = 0;
            virtual ~Selex(){}
            void Set_x(T & x) { this->m_x = x; }
            T    Get_x() const{ return m_x;     }
    };

    // =========================================================================================================
    // plogis: Base functions for logistic-based selectivity functions
    // =========================================================================================================
    /**
     * @brief Logistic function
     * @details Basic two parameter logistic function with mean and standard deviation
     *
     * @param T x - Independent variable (e.g. age or size) as data vector or dvar vector
     * @param T2 mean - size at 50% selected
     * @param T2 sd - double or dvariable for mean and standard deviation of the logistic curve
    **/
    template<class T,class T2>
    inline
    const T plogis(const T &x, const T2 &mean, const T2 &sd)
    {
        T selex = T2(1.0)/(T2(1.0)+mfexp(-(x-mean)/sd));
        return selex;
    }


    /**
     * @brief Logistic function with size at 50%, 95% selection parameterization
     * @details Alternative two parameter logistic function with mean and standard deviation
     *
     * @param T x - Independent variable (e.g. age or size) as data vector or dvar vector
     * @param T2 s50 - size at 50% selected
     * @param T2 s95 - size at 95% selected
    **/
    template<class T, class T2>
    inline
    const T plogis95(const T &x, const T2 &s50, const T2 &s95)
    {
        T selex = T2(1.0)/(T2(1.0)+(exp(-log(19)*((x-s50)/(s95-s50)))));
        return selex;
    }


    template<class T, class T2>
    inline
    const T pdubnorm(const T &x, const T2 &sL, const T2 &s50, const T2 &sR)
    {
        T2 slp  = T2(5.0);//use pretty steep slope for join
        T selLH = mfexp(-0.5*square((x-s50)/sL));// ascending limb
        T selRH = mfexp(-0.5*square((x-s50)/sR));//descending limb
        T join  = 1.0/(1.0+exp(-slp*(x-s50)));//0 for x<s50, 1 for x>s50
        T selex = elem_prod(elem_prod(1.0-join,selLH) + join,
                            elem_prod(    join,selRH) + (1.0-join));
        return selex;
    }

    template<class T, class T2>
    inline
    const T pdubnorm4(const T &x, const T2 &ascWdZ, const T2 &ascPkZ,
                                  const T2 &dscWdZ, const T2 &dscPkZ)
    {
        T2 slp = T2(5.0);
        T ascS = mfexp(-0.5*square((x-ascPkZ)/ascWdZ));
        T dscS = mfexp(-0.5*square((x-dscPkZ)/dscWdZ));
        T ascJ = 1.0/(1.0+mfexp( slp*(x-(ascPkZ))));
        T dscJ = 1.0/(1.0+mfexp(-slp*(x-(dscPkZ))));
        T s = elem_prod(elem_prod(ascJ,ascS)+(1.0-ascJ),
                        elem_prod(dscJ,dscS)+(1.0-dscJ));
        return s;
    }

    // DecliningLogisticCurve: Base function for declining logistic selectivity coefficients
    /**
     * @brief declining function
     * @details Basic two parameter logistic function with mean and standard deviation plus coefficients for the first few size-classes
     *
     * @param T x - Independent variable (e.g. age or size) as data vector or dvar vector
     * @param T2 mean - size at 50% selected
     * @param T2 sd - double or dvariable for mean and standard deviation of the logistic curve
     * @param Y3 sel_coeffs - double or dvariable for over-ride values
    **/
    template<class T, class T1, class T2, class T3>
    const T declplogis(const T &x, const T1 &mean, const T2 &sd, const T3 &sel_coeffs)
    {
        T logisticselex = T2(1.0)/(T2(1.0)+mfexp((x-mean)/sd));
        int x1 = x.indexmin();
        int y2 = sel_coeffs.indexmax();
        T selex = 1.0*logisticselex;
        for ( int i = x1; i <= y2; i++ ) selex(i) = mfexp(sel_coeffs(i));
        return selex;
    }

    // nonparametric: Base function for non-parametric selectivity option
    /**
     * @brief Nonparametric selectivity function
     * @details Estimate one parameter per age/size class, and rescale to maximum of one.
     * @param x Independent variable (number of classes)
     * @param selparms Vector of selectivity parameters (initial values).
     * @return Selectivity values.
    **/
    template<class T>
    const T nonparametric(const T &x, const T &selparms)
    {
        T selex = 0.0*x;
        for ( int i = x.indexmin(); i <= x.indexmax(); i++ )
        {
            selex(i) = mfexp(selparms(i));
        }
        return selex;
    }

    // --------------------------------------------------------------------------------------------------
    // Selectivity classes
    // --------------------------------------------------------------------------------------------------

    // LogisticCurve: Logistic-based selectivity function with options
    /**
     * @brief Logistic curve
     * @details Uses the logistic curve (plogis) for a two parameter function
     *
     * @tparam T data vector or dvar vector
     * @tparam T2 double or dvariable for mean and standard deviation of the logistic curve
    **/
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

            void SetMean(T2 &mean) { this->m_mean = mean;}
            void SetStd(T2 &std)   { this->m_std  = std; }
            void SetParams(T2 &mean, T2 &std){this->m_mean = mean;this->m_std  = std;}

            const T Selectivity(const T &x) const
            {
                    return gsm::plogis(x, m_mean, m_std);
            }

            const T logSelectivity(const T &x) const
            {
                    return log(gsm::plogis(x, m_mean, m_std));
            }

            const T logSelexMeanOne(const T &x) const
            {
                    T y = log(gsm::plogis(x, m_mean, m_std));
                    y  -= log(mean(mfexp(y)));
                    return y;
            }
    };

    // LogisticCurve95: Logistic-based selectivity function with options
    /**
     * @brief Logistic curve parameterised with 5% and 95% selectivity
     * @details Uses the logistic curve (plogis95) for a two parameter function
     *
     * @tparam T data vector or dvar vector
     * @tparam T2 double or dvariable for size at 5% and 95% selectivity
    **/
    template<class T,class T2>
    class LogisticCurve95: public Selex<T>
    {
    private:
            T2 m_s50;
            T2 m_s95;

    public:
            LogisticCurve95(T2 s50 = T2(1), T2 s95 = T2(1))
            : m_s50(s50), m_s95(s95) {}

            T2 GetS50() const { return m_s50; }
            T2 GetS95() const { return m_s95; }

            void SetS50(T2 &s50) { this->m_s50 = s50; }
            void SetS95(T2 &s95) { this->m_s95 = s95; }
            void SetParams(T2 &s50, T2 &s95){this->m_s50 = s50;this->m_s95  = s95;}

            const T Selectivity(const T &x) const
            {
                    return gsm::plogis95(x, m_s50, m_s95);
            }

            const T logSelectivity(const T &x) const
            {
                    return log(gsm::plogis95(x, m_s50, m_s95));
            }

            const T logSelexMeanOne(const T &x) const
            {
                    T y = log(gsm::plogis95(x, m_s50, m_s95));
                    y  -= log(mean(mfexp(y)));
                    return y;
            }
    };

    // DecliningLogistic: Declining Logistic-based selectivity function with options
    /**
     * @brief Declining Logistic curve
     * @details Uses the logistic curve (plogisd) for a two parameter function
     *          but overrides the first few size classes
     *
     * @tparam T data vector or dvar vector
     * @tparam T2 double or dvariable for mean and standard deviation of the logistic curve
    **/
    template<class T, class T1,class T2, class T3>
    class DeclineLogistic: public Selex<T>
    {
    private:
            T1 m_mean;
            T2 m_std;
            T3 m_sel_coeffs;

    public:
            DeclineLogistic(T1 mean = T2(0), T2 std = T2(1), T3 params = T3(1) )
            : m_mean(mean), m_std(std),m_sel_coeffs(params) {}

            T1 GetMean() const { return m_mean; }
            T2 GetStd()  const { return m_std;  }
            T3 GetSelCoeffs() const { return m_sel_coeffs; }

            void SetMean(T1 &mean) { this->m_mean = mean;}
            void SetStd(T2 &std)   { this->m_std  = std; }
            void SetSelCoeffs(T3 &x) { this->m_sel_coeffs = x; }
            void SetParams(T1 &mean, T2 &std, T3 &x){
                this->m_mean = mean;
                this->m_std  = std;
                this->m_sel_coeffs = x;
            }

            const T Selectivity(const T &x) const
            {
                    return gsm::declplogis(x, m_mean, m_std, m_sel_coeffs );
            }

            const T logSelectivity(const T &x) const
            {
                    return log(gsm::declplogis(x, m_mean, m_std, m_sel_coeffs ));
            }

            const T logSelexMeanOne(const T &x) const
            {
                    T y = log(gsm::declplogis(x, m_mean, m_std, m_sel_coeffs ));
                    y  -= log(mean(mfexp(y)));
                    return y;
            }
    };

    // DoubleNormal: 3-parameter double normal (dome shaped) selectivity
    /**
     * @brief 3-parameter double normal curve
     * @details Uses gsm::pdubnorm<T> function.
     *
     * @param T data vector or dvar vector
     * @param T2 double or dvariable for left-hand width, size at dome, right-hand width
    **/
    template<class T,class T2>
    class DoubleNormal: public Selex<T>
    {
    private:
            T2 m_sL;
            T2 m_s50;
            T2 m_sR;

    public:
        /**
         * Class constructor.
         *
         * @param sL - width of lefthand limb  (default=1)
         * @param s50 - size at dome           (default=1)
         * @param sR - width of righthand limb (default=1)
         */
            DoubleNormal(T2 sL = T2(1), T2 s50 = T2(1), T2 sR = T2(1))
            : m_sL(sL), m_s50(s50), m_sR(sR) {}

            T2 GetSL()  const { return m_sL; }
            T2 GetS50() const { return m_s50; }
            T2 GetSR()  const { return m_sR; }

            void SetSL(T2 &sL)   { this->m_sL = sL; }
            void SetS50(T2 &s50) { this->m_s50 = s50; }
            void SetSR(T2 &sR)   { this->m_sR = sR; }
            void SetParams(T2 &sL, T2 &s50, T2 &sR){
                this->m_sL = sL;
                this->m_s50 = s50;
                this->m_sR = sR;
            }

            const T Selectivity(const T &x) const
            {
                return gsm::pdubnorm(x, m_sL, m_s50, m_sR);
            }

            const T logSelectivity(const T &x) const
            {
                return log(gsm::pdubnorm(x, m_sL, m_s50, m_sR));
            }

            const T logSelexMeanOne(const T &x) const
            {
                T y = log(gsm::pdubnorm(x, m_sL, m_s50, m_sR));
                y  -= log(mean(mfexp(y)));
                return y;
            }
    };

    // DoubleNormal4: 4-parameter double normal (dome shaped) selectivity
    /**
     * @brief 4-parameter double normal curve
     * @details Uses the logistic curve (plogis95) for a two parameter function
     *
     * @param T data vector or dvar vector
     * @param T2 double or dvariable
    **/
    template<class T,class T2>
    class DoubleNormal4: public Selex<T>
    {
    private:
        T2 m_ascWdZ;//ascending limb width
        T2 m_ascPkZ;//size at which ascending limb reaches 1
        T2 m_dscWdZ;//descending limb width
        T2 m_dscPkZ;//size at which descending limb departs from 1

    public:
        /**
         *
         * @param ascWdZ - ascending limb width
         * @param ascPkZ - size at which ascending limb reaches 1
         * @param dscWdZ - descending limb width
         * @param dscPkZ - size at which descending limb departs from 1
         */
        DoubleNormal4(T2 ascWdZ = T2(1), T2 ascPkZ = T2(1),
                      T2 dscWdZ = T2(1), T2 dscPkZ = T2(1))
        : m_ascWdZ(ascWdZ), m_ascPkZ(ascPkZ), m_dscWdZ(dscWdZ), m_dscPkZ(dscPkZ) {}

        T2 GetAscWdZ()  const { return m_ascWdZ; }
        T2 GetAscPkZ()  const { return m_ascPkZ; }
        T2 GetDscWdZ()  const { return m_dscWdZ; }
        T2 GetDscPkZ()  const { return m_dscPkZ; }

        void SetAscWdZ(T2 &ascWdZ){ this->m_ascWdZ = ascWdZ; }
        void SetAscPkZ(T2 &ascPkZ){ this->m_ascPkZ = ascPkZ; }
        void SetDscWdZ(T2 &dscWdZ){ this->m_dscWdZ = dscWdZ; }
        void SetDscPkZ(T2 &dscPkZ){ this->m_dscPkZ = dscPkZ; }
        void SetParams(T2 &ascWdZ, T2 &ascPkZ, T2 &dscWdZ, T2 &dscPkZ){
            this->m_ascWdZ = ascWdZ;
            this->m_ascWdZ = ascPkZ;
            this->m_dscWdZ = dscWdZ;
            this->m_dscPkZ = dscPkZ;
        }

        const T Selectivity(const T &x) const
        {
            return gsm::pdubnorm4(x, m_ascWdZ, m_ascPkZ, m_dscWdZ, m_dscPkZ);
        }

        const T logSelectivity(const T &x) const
        {
            return log(gsm::pdubnorm4(x, m_ascWdZ, m_ascPkZ, m_dscWdZ, m_dscPkZ));
        }

        const T logSelexMeanOne(const T &x) const
        {
            T y = log(gsm::pdubnorm4(x, m_ascWdZ, m_ascPkZ, m_dscWdZ, m_dscPkZ));
            y  -= log(mean(mfexp(y)));
            return y;
        }
    };

    // Coefficients: Base function for non-parametric selectivity cooefficients
    /**
     * @brief Nonparametric selectivity coefficients
     * @details The length of the vector sel_coeffs must be less than or equal to
     * length of the independent variabls x.  If it it shorter, then it is assumed that
     * the parameters in the last element of sel_coeffs is the same for all elements in
     * the terminus of the independent vector.  Also use a logit transformation to ensure
     * that selectivities are bounded between 0-1.
     *
     * @param x Independent variable
     * @param sel_coeffs Vector of estimated selectivity coefficients logit transformed.
     * @return Selectivity coefficients.
    **/
    template<class T>
    const T coefficients(const T &x, const T &sel_coeffs)
    {
            int x1 = x.indexmin();
            int x2 = x.indexmax();
            int y2 = sel_coeffs.indexmax();
            T y = 0.0*x;
            for ( int i = x1; i < y2; i++ )
            {
                    y(i) = mfexp(sel_coeffs(i));
            }
            y(y2,x2) = mfexp(sel_coeffs(y2));
            return y;
    }

    // SelectivityCoefficients: Age/size-specific selectivity coefficients for n-1 age/size classes
    /**
     * @brief Selectivity coefficients
     * @details Age or size-specific selectivity coefficients for n-1 age/size classes
     *
     * @tparam T vector of coefficients
    **/
    template<class T>
    class SelectivityCoefficients: public Selex<T>
    {
    private:
            T m_sel_coeffs;

    public:
            SelectivityCoefficients(T params = T(1))
            :m_sel_coeffs(params) {}

            T GetSelCoeffs() const { return m_sel_coeffs; }
            void SetSelCoeffs(T &x) { this->m_sel_coeffs = x; }

            const T Selectivity(const T &x) const
            {
                    // Call the age/size specific function
                    return gsm::coefficients(x, m_sel_coeffs);
            }

            const T logSelectivity(const T &x) const
            {
                    // Call the age/size specific function
                    return log(gsm::coefficients(x, m_sel_coeffs));
            }

            const T logSelexMeanOne(const T &x) const
            {
                    T y = log(gsm::coefficients(x, m_sel_coeffs));
                    y -= log(mean(mfexp(y)));
                    return y;
            }
    };


    // ParameterPerClass: One age/size-specific selectivity parameter for each age/size class
    /**
     * @brief Parametric selectivity function
     * @details One age or size-specific selectivity parameter for each age/size class.
     *
     * Note that the same can be accomplished using the SelectivityCoefficients class but Athol wanted to have this function in CSTAR
     *
     * @tparam T vector of parameters (initial values)
    **/
    template<class T>
    class ParameterPerClass: public Selex<T>
    {
    private:
            T m_selparms;

    public:
            ParameterPerClass(T selparms = T(1))
            :m_selparms(selparms) {}

            T GetSelparms() const { return m_selparms; }
            void SetSelparms(T &selparms) { this->m_selparms = selparms; }

            const T Selectivity(const T &x) const
            {
                    // Call the age/size specific function
                    return gsm::nonparametric(x, m_selparms);
            }

            const T logSelectivity(const T &x) const
            {
                    // Call the age/size specific function
                    return log(gsm::nonparametric(x, m_selparms));
            }

            const T logSelexMeanOne(const T &x) const
            {
                    T y = log(gsm::nonparametric(x, m_selparms));
                    //y  -= log(mean(mfexp(y)));
                    return y;
            }
    };

    // UniformCurve: Uniform over a length
    /**
     * @brief Flat selectivity
     * @details All values equal 1

     *
     * @tparam T vector of parameters (initial values)
    **/
    template<class T>
    class UniformCurve: public Selex<T>
    {

    public:
            UniformCurve() {}

            const T Selectivity(const T &x) const
            {
                    T selex = 1.0 + 0.0*x;
                    return selex;
            }

            const T logSelectivity(const T &x) const
            {
                    T selex = 0.0*x;
                    return selex;
            }
            const T logSelexMeanOne(const T &x) const
            {
                    T selex = 1.0 + 0.0*x;
                    return selex;
            }

    };

    template<class T>
    class Uniform0Curve: public Selex<T>
    {

    public:
            Uniform0Curve() {}

            const T Selectivity(const T &x) const
            {
                T selex = 0.0*x;
                    return selex;
            }

            const T logSelectivity(const T &x) const
            {
                T selex = -100.0 + 0.0*x;
                    return selex;
            }
            const T logSelexMeanOne(const T &x) const
            {
                    T selex = 1.0 + 0.0*x;
                    return selex;
            }

    };


    // Cubic Spline: Age/size-specific for a cubic split
    /**
     * @brief Cubic Spline
     * @details Cubic spline
     *
     * @param y_vals T vector of values at knots
     * @param x_vals T1 vector of knots
    **/
    template<typename T, typename T1>
    class SelectivitySpline: public Selex<T> {
        public:
            static int debug;//debugging flag

        private:
            T  m_yvals; //dependent values in spline (estimated parameters)
            T1 m_xvals; //independent values in spline (knots)
            T  m_y2vals;//2nd derivatives of m_yvals at m_xvals


        public:
            /**
             * Constructor for cubic spline. Beginning and ending boundary conditions
             * on first derivatives are set to 0.
             *
             * @param yvals - values at knots
             * @param xvals - knots
             */
            SelectivitySpline(const T &yvals, const T1 &xvals){
                initSpline(yvals,xvals);
            }

            /**
             * Calculate second derivatives for spline interpolation.
             *
             * @param yvals
             * @param xvals
             */
            void initSpline(const T &yvals, const T1 &xvals) {
                if ((m_yvals.indexmin()!=yvals.indexmin())||
                    (m_yvals.indexmax()!=yvals.indexmax())){
                    if (debug) cout<<"initSpline:: deallocating arrays"<<endl;
                    m_yvals.deallocate();
                    m_xvals.deallocate();
                    m_y2vals.deallocate();
                }
                m_yvals = (T&)  yvals;//create shallow, un-const copy
                m_xvals = (T1&) xvals;//create shallow, un-const copy

                //shift arrays to start at 0
                int lb = m_xvals.indexmin();//lower bound on x and y indices
                m_xvals.shift(0);
                m_yvals.shift(0);

                //calculate second derivatives
                //cout<<"--computing 2nd derivatives"<<endl;
                int ibcbeg = 1;
                int ibcend = 1;
                double ybcbeg = 0.0;
                double ybcend = 0.0;
                m_y2vals.allocate(m_xvals);
                m_y2vals = spline_cubic_set(m_yvals, m_xvals, ibcbeg, ybcbeg, ibcend, ybcend);

                //shift arrays back to start at original lower index
                m_xvals.shift(lb);
                m_yvals.shift(lb);
                m_y2vals.shift(lb);
                //cout<<"m_xvals = "<<m_xvals<<endl;
                //cout<<"m_yvals= "<<m_yvals<<endl;
                //cout<<"y2vals  = "<<m_y2vals<<endl;
            }

            const T Selectivity(const T1 &x) const {
                // do interpolation at x values
                int mmin = x.indexmin();
                int mmax = x.indexmax();
                T selex(x.indexmin(),x.indexmax());
                T tempX(x.indexmin(),x.indexmax());
                for (int i=mmin;i<=mmax;i++){
				   {
                    tempX(i) = spline_cubic_val(x(i),m_xvals,m_yvals,m_y2vals);
                    selex(i) = mfexp(tempX(i))/(1.0+exp(tempX(i)));
				   }
                }
                return selex;
            }

            const T logSelectivity(const T1 &x) const {
                return log(Selectivity(x));
            }

            const T logSelexMeanOne(const T1 &x) const {
                T y = log(Selectivity(x));
                y -= log(mean(mfexp(y)));
                return y;
            }
    };//SelectivitySpline<T,T1>
    template<typename T, typename T1>
    int SelectivitySpline<T,T1>::debug = 0;//flag to print debugging info

} //gsm namespace

#endif /* SELEX_HPP */


/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   gsm_splines.hpp
 * Author: WilliamStockhausen
 *
 * Created on January 27, 2020, 8:53 AM
 */

#ifndef GSM_SPLINES_HPP
#define GSM_SPLINES_HPP

// Global headers
#include <fvar.hpp>

namespace gsm {

    //
    //  Purpose:
    //
    //    D3_NP_FS factors and solves a D3 system.
    //
    //  Discussion:
    //
    //    The D3 storage format is used for a tridiagonal matrix.
    //    The superdiagonal is stored in entries (1,2:N), the diagonal in
    //    entries (2,1:N), and the subdiagonal in (3,1:N-1).  Thus, the
    //    original matrix is "collapsed" vertically into the array.
    //
    //    This algorithm requires that each diagonal entry be nonzero.
    //    It does not use pivoting, and so can fail on systems that
    //    are actually nonsingular.
    //
    //  Example:
    //
    //    Here is how a D3 matrix of order 5 would be stored:
    //
    //       *  A12 A23 A34 A45
    //      A11 A22 A33 A44 A55
    //      A21 A32 A43 A54  *
    //
    //  Licensing:
    //
    //    This code is distributed under the GNU LGPL license.
    //
    //  Modified:
    //
    //    15 November 2003
    //
    //  Author:
    //
    //    John Burkardt
    //
    //  Modified By:
    //
    //    Derek Seiple (20 August 2010)
    //    William Stockhausen(27 Jan 2020)  
    //
    //  Template parameters:
    //    T - dvector or dvar_vector
    //
    //  Parameters:
    //
    //    T a: input/output. d(var_)vector with indices 0:(3*n-1).
    //          On input, the nonzero diagonals of the linear system.
    //          On output, the data in these vectors has been overwritten
    //          by factorization information.
    //
    //    T b: input. d(var_)vector with indices 0:(n-1). 
    //          The right hand side of the set of equations to solve.
    //
    //    T d3_np_fs: output. d(var_)vector with indices 0:(N-1).
    //          The solution to the linear system. This is NULL 
    //          if there was an error because one of the diagonal
    //          entries was zero.
    //
    /**
     * \ingroup cub_spline
     * factors and solves a D3 system.
     * 
     * NOTE: T is must be dvector or dvar_vector
     * 
     * \param _a T: On input, the nonzero diagonals of the linear system
     * \param _b T: the right hand side of the linear system of equations
     * \return the solution of the linear system
     */
    template<typename T>
    T d3_np_fs (const T& _a, const T& _b) {
      ADUNCONST(T,a)
      ADUNCONST(T,b)

      int n = b.size();

      int i;
      T xmult(0,0);//assumption is that T is dvar_vector or dvector

      //  Check.
      for ( i = 0; i < n; i++ ) {
        if ( a[1+i*3] == 0.0 ) {
          return NULL;
        }
      }

      T x(0,n-1);//assumption is that x and b are same size

      for ( i = 0; i < n; i++ ) {
        x[i] = b[i];
      }

      for ( i = 1; i < n; i++ ) {
        xmult[0] = a[2+(i-1)*3] / a[1+(i-1)*3];
        a[1+i*3] = a[1+i*3] - xmult[0] * a[0+i*3];
        x[i] = x[i] - xmult[0] * x[i-1];
      }

      x[n-1] = x[n-1] / a[1+(n-1)*3];
      for ( i = n-2; 0 <= i; i-- ) {
        x[i] = ( x[i] - a[0+(i+1)*3] * x[i+1] ) / a[1+i*3];
      }

      return x;
    }

    //
    //  Purpose:
    //
    //    SPLINE_CUBIC_SET computes the second derivatives of a piecewise cubic
    //    spline.
    //
    //  Discussion:
    //
    //    For data interpolation, the user must call SPLINE_SET to determine
    //    the second derivative data, passing in the data to be interpolated,
    //    and the desired boundary conditions.
    //
    //    The data to be interpolated, plus the SPLINE_SET output, defines
    //    the spline.  The user may then call SPLINE_VAL to evaluate the
    //    spline at any point.
    //
    //    The cubic spline is a piecewise cubic polynomial.  The intervals
    //    are determined by the "knots" or abscissas of the data to be
    //    interpolated.  The cubic spline has continuous first and second
    //    derivatives over the entire interval of interpolation.
    //
    //    For any point T in the interval T(IVAL), T(IVAL+1), the form of
    //    the spline is
    //
    //      SPL(T) = A(IVAL)
    //             + B(IVAL) * ( T - T(IVAL) )
    //             + C(IVAL) * ( T - T(IVAL) )**2
    //             + D(IVAL) * ( T - T(IVAL) )**3
    //
    //    If we assume that we know the values Y(*) and YPP(*), which represent
    //    the values and second derivatives of the spline at each knot, then
    //    the coefficients can be computed as:
    //
    //      A(IVAL) = Y(IVAL)
    //      B(IVAL) = ( Y(IVAL+1) - Y(IVAL) ) / ( T(IVAL+1) - T(IVAL) )
    //        - ( YPP(IVAL+1) + 2 * YPP(IVAL) ) * ( T(IVAL+1) - T(IVAL) ) / 6
    //      C(IVAL) = YPP(IVAL) / 2
    //      D(IVAL) = ( YPP(IVAL+1) - YPP(IVAL) ) / ( 6 * ( T(IVAL+1) - T(IVAL) ) )
    //
    //    Since the first derivative of the spline is
    //
    //      SPL'(T) =     B(IVAL)
    //              + 2 * C(IVAL) * ( T - T(IVAL) )
    //              + 3 * D(IVAL) * ( T - T(IVAL) )**2,
    //
    //    the requirement that the first derivative be continuous at interior
    //    knot I results in a total of N-2 equations, of the form:
    //
    //      B(IVAL-1) + 2 C(IVAL-1) * (T(IVAL)-T(IVAL-1))
    //      + 3 * D(IVAL-1) * (T(IVAL) - T(IVAL-1))**2 = B(IVAL)
    //
    //    or, setting H(IVAL) = T(IVAL+1) - T(IVAL)
    //
    //      ( Y(IVAL) - Y(IVAL-1) ) / H(IVAL-1)
    //      - ( YPP(IVAL) + 2 * YPP(IVAL-1) ) * H(IVAL-1) / 6
    //      + YPP(IVAL-1) * H(IVAL-1)
    //      + ( YPP(IVAL) - YPP(IVAL-1) ) * H(IVAL-1) / 2
    //      =
    //      ( Y(IVAL+1) - Y(IVAL) ) / H(IVAL)
    //      - ( YPP(IVAL+1) + 2 * YPP(IVAL) ) * H(IVAL) / 6
    //
    //    or
    //
    //      YPP(IVAL-1) * H(IVAL-1) + 2 * YPP(IVAL) * ( H(IVAL-1) + H(IVAL) )
    //      + YPP(IVAL) * H(IVAL)
    //      =
    //      6 * ( Y(IVAL+1) - Y(IVAL) ) / H(IVAL)
    //      - 6 * ( Y(IVAL) - Y(IVAL-1) ) / H(IVAL-1)
    //
    //    Boundary conditions must be applied at the first and last knots.
    //    The resulting tridiagonal system can be solved for the YPP values.
    //
    //  Licensing:
    //
    //    This code is distributed under the GNU LGPL license.
    //
    //  Modified:
    //
    //    06 February 2004
    //
    //  Author:
    //
    //    John Burkardt
    //
    //  Modified By:
    //
    //    Derek Seiple (20 August 2010)
    //
    //  Parameters:
    //
    //    Input, int N, the number of data points.  N must be at least 2.
    //    In the special case where N = 2 and IBCBEG = IBCEND = 0, the
    //    spline will actually be linear.
    //
    //    Input, double T[N], the knot values, that is, the points were data is
    //    specified.  The knot values should be distinct, and increasing.
    //
    //    Input, double Y[N], the data values to be interpolated.
    //
    //    Input, int IBCBEG, left boundary condition flag:
    //      0: the cubic spline should be a quadratic over the first interval;
    //      1: the first derivative at the left endpoint should be YBCBEG;
    //      2: the second derivative at the left endpoint should be YBCBEG.
    //
    //    Input, double YBCBEG, the values to be used in the boundary
    //    conditions if IBCBEG is equal to 1 or 2.
    //
    //    Input, int IBCEND, right boundary condition flag:
    //      0: the cubic spline should be a quadratic over the last interval;
    //      1: the first derivative at the right endpoint should be YBCEND;
    //      2: the second derivative at the right endpoint should be YBCEND.
    //
    //    Input, double YBCEND, the values to be used in the boundary
    //    conditions if IBCEND is equal to 1 or 2.
    //
    //    Output, double SPLINE_CUBIC_SET[N], the second derivatives of the cubic
    //    spline.
    //
    /**
     * \ingroup cub_spline
     * Computes the second derivatives of a piecewise cubic spline
     * \param T y The data values to be interpolated.
     * \param T1 t The knot values. The knot values should be distinct, and increasing.
     * \param int ibcbeg The left boundary flag,
     *        0: the cubic spline should be a quadratic over the first interval;
     *        1: the first derivative at the left endpoint should be ybcbeg;
     *        2: the second derivative at the left endpoint should be ybcbeg.
     * \param T2 ybcbeg The values to be used in the boundary conditions
     * \param int ibcend The right boundary flag,
     *        0: the cubic spline should be a quadratic over the last interval;
     *        1: the first derivative at the right endpoint should be YBCEND;
     *        2: the second derivative at the right endpoint should be YBCEND.
     * \param T2 ybcend the values to be used in the boundary conditions
     * \return the second derivatives of the cubic spline
     */
    template<typename T, typename T1, typename T2>
    T spline_cubic_set (const T& y,
                        const T1& t, 
                        int ibcbeg, 
                        T2 ybcbeg, 
                        int ibcend, 
                        T2 ybcend ) {
      int n = y.size(); 
      T a(0,3*n-1);
      T b(0,n-1);

      int i;

      //  Check.
      if ( n <= 1 )
      {
        cout << "\n";
        cout << "SPLINE_CUBIC_SET - Fatal error!\n";
        cout << "  The number of data points N must be at least 2.\n";
        cout << "  The input value is " << n << ".\n";
        //return NULL;
      }

      for ( i = 0; i < n - 1; i++ )
      {
        if ( t[i+1] <= t[i] )
        {
          cout << "\n";
          cout << "SPLINE_CUBIC_SET - Fatal error!\n";
          cout << "  The knots must be strictly increasing, but\n";
          cout << "  T(" << i   << ") = " << t[i]   << "\n";
          cout << "  T(" << i+1 << ") = " << t[i+1] << "\n";
        }
      }

      //  Set up the first equation.
      if ( ibcbeg == 0 )
      {
        b[0] = 0.0;
        a[1+0*3] = 1.0;
        a[0+1*3] = -1.0;
      }
      else if ( ibcbeg == 1 )
      {
        b[0] = ( y[1] - y[0] ) / ( t[1] - t[0] ) - ybcbeg;
        a[1+0*3] = ( t[1] - t[0] ) / 3.0;
        a[0+1*3] = ( t[1] - t[0] ) / 6.0;
      }
      else if ( ibcbeg == 2 )
      {
        b[0] = ybcbeg;
        a[1+0*3] = 1.0;
        a[0+1*3] = 0.0;
      }
      else
      {
        cout << "\n";
        cout << "SPLINE_CUBIC_SET - Fatal error!\n";
        cout << "  IBCBEG must be 0, 1 or 2.\n";
        cout << "  The input value is " << ibcbeg << ".\n";
      }

      //  Set up the intermediate equations.
      for ( i = 1; i < n-1; i++ )
      {
        b[i] = ( y[i+1] - y[i] ) / ( t[i+1] - t[i] )
             - ( y[i] - y[i-1] ) / ( t[i] - t[i-1] );
        a[2+(i-1)*3] = ( t[i] - t[i-1] ) / 6.0;
        a[1+ i   *3] = ( t[i+1] - t[i-1] ) / 3.0;
        a[0+(i+1)*3] = ( t[i+1] - t[i] ) / 6.0;
      }

      //  Set up the last equation.
      if ( ibcend == 0 )
      {
        b[n-1] = 0.0;
        a[2+(n-2)*3] = -1.0;
        a[1+(n-1)*3] = 1.0;
      }
      else if ( ibcend == 1 )
      {
        b[n-1] = ybcend - ( y[n-1] - y[n-2] ) / ( t[n-1] - t[n-2] );
        a[2+(n-2)*3] = ( t[n-1] - t[n-2] ) / 6.0;
        a[1+(n-1)*3] = ( t[n-1] - t[n-2] ) / 3.0;
      }
      else if ( ibcend == 2 )
      {
        b[n-1] = ybcend;
        a[2+(n-2)*3] = 0.0;
        a[1+(n-1)*3] = 1.0;
      }
      else
      {
        cout << "\n";
        cout << "SPLINE_CUBIC_SET - Fatal error!\n";
        cout << "  IBCEND must be 0, 1 or 2.\n";
        cout << "  The input value is " << ibcend << ".\n";
      }

      //  Solve the linear system.
      if ( n == 2 && ibcbeg == 0 && ibcend == 0 )
      {
        T ret(0,1);
        ret(0) = 0.0;
        ret(1) = 0.0;
        return ret;
      }
      else
      {
        T ypp = gsm::d3_np_fs( a, b );
        T ret(0,n-1);
        if ( !ypp )
        {
          cout << "\n";
          cout << "SPLINE_CUBIC_SET - Fatal error!\n";
          cout << "  The linear system could not be solved.\n";
        }
        ret = ypp;
        return ret;
      }
    }

    //
    //  Purpose:
    //
    //    SPLINE_CUBIC_VAL evaluates a piecewise cubic spline at a point.
    //
    //  Discussion:
    //
    //    SPLINE_CUBIC_SET must have already been called to define the values of
    //    YPP.
    //
    //    For any point T in the interval T(IVAL), T(IVAL+1), the form of
    //    the spline is
    //
    //      SPL(T) = A
    //             + B * ( T - T(IVAL) )
    //             + C * ( T - T(IVAL) )**2
    //             + D * ( T - T(IVAL) )**3
    //
    //    Here:
    //      A = Y(IVAL)
    //      B = ( Y(IVAL+1) - Y(IVAL) ) / ( T(IVAL+1) - T(IVAL) )
    //        - ( YPP(IVAL+1) + 2 * YPP(IVAL) ) * ( T(IVAL+1) - T(IVAL) ) / 6
    //      C = YPP(IVAL) / 2
    //      D = ( YPP(IVAL+1) - YPP(IVAL) ) / ( 6 * ( T(IVAL+1) - T(IVAL) ) )
    //
    //  Licensing:
    //
    //    This code is distributed under the GNU LGPL license.
    //
    //  Modified:
    //
    //    04 February 1999
    //
    //  Author:
    //
    //    John Burkardt
    //
    //  Modified By:
    //
    //    Derek Seiple (20 August 2010)
    //
    //  Parameters:
    //
    //    Input, int N, the number of knots.
    //
    //    Input, double Y[N], the data values at the knots.
    //
    //    Input, double T[N], the knot values.
    //
    //    Input, double TVAL, a point, typically between T[0] and T[n-1], at
    //    which the spline is to be evalulated.  If TVAL lies outside
    //    this range, extrapolation is used.
    //
    //    Input, double YPP[N], the second derivatives of the spline at
    //    the knots.
    //
    //    Output, double SPLINE_VAL, the value of the spline at TVAL.
    //
    /**
     * \ingroup cub_spline
     *  Evaluates a piecewise cubic spline at a point.
     * \param tval a point, typically between t[0] and t[n-1], at
     *        which the spline is to be evalulated.  If tval lies outside
     *        this range, extrapolation is used.
     * \param t the knot values
     * \param y the data values at the knots
     * \param ypp the second derivatives of the spline at the knots
     * \return the value of the spline at tval
    */
    template<typename T, typename T1, typename T2>
    T spline_cubic_val(const T tval,
                       const T1& _t, 
                       const T2& _y, 
                       const T2& _ypp) {
      int n   = _t.size();    

      int lbt = _t.indexmin();
      T1& t = (T1&)_t;
      t.shift(0);
      int lby = _y.indexmin();
      T2& y = (T2&)_y;
      y.shift(0);
      int lbypp = _ypp.indexmin();
      T2& ypp = (T2&)_ypp;
      ypp.shift(0);

      //  Determine the interval [ T(I), T(I+1) ] that contains TVAL.
      //  Values below T[0] or above T[N-1] use extrapolation.
      int ival = n - 2;

      for (int i = 0; i < n-1; i++ )
      {
        if ( tval < t[i+1] )
        {
          ival = i;
          break;
        }
      }

      //  In the interval I, the polynomial is in terms of a normalized
      //  coordinate between 0 and 1.
      T dt = tval - t[ival];
      T h = t[ival+1] - t[ival];

      T yval = y[ival]
                + dt * ( ( y[ival+1] - y[ival] ) / h
                       - ( ypp[ival+1] / 6.0 + ypp[ival] / 3.0 ) * h
                + dt * ( 0.5 * ypp[ival]
                + dt * ( ( ypp[ival+1] - ypp[ival] ) / ( 6.0 * h ) ) ) );

      t.shift(lbt);     //TODO: we have yval: do the shifts here need to be done?
      y.shift(lby);
      ypp.shift(lbypp);

      return yval;
    }

    /**
     * Description not yet available.
     * \param
     */
    template<typename T, typename T1, typename T2>
    class vcubic_spline_function
    {
       T  y; // dep variable values
       T1 x; // indep variables values
       T  y2; // second derivatives of dep values
     public:
       vcubic_spline_function(const T & _y,
                              const T1 & _x, 
                              T2 yp1 = T2(0.0), 
                              T2 ypn = T2(0.0)): y(_y), x(_x) {
        int ibcbeg, ibcend;
        T2 ybcbeg, ybcend;

        int lb = x.indexmin();//lower bound on x and y indices
        x.shift(0);
        y.shift(0);

        if(yp1 > 0.99e30 )
        {
          ibcbeg = 2;
          ybcbeg = T2(0.0);
        }
        else
        {
          ibcbeg = 1;
          ybcbeg = yp1;
        }
        if(ypn > 0.99e30 )
        {
          ibcend = 2;
          ybcend = T2(0.0);
        }
        else
        {
          ibcend = 1;
          ybcend = ypn;
        }

        y2.allocate(x);
        y2 = gsm::spline_cubic_set(y, x, ibcbeg, ybcbeg, ibcend, ybcend);

        //shift x, y, y2 back to start at original lower index
        x.shift(lb);
        y.shift(lb);
        y2.shift(lb);
       }

       /**
        * Calculate the spline at values given by u.
        * @param u - input value(s)
        * @return value(s) corresponding to u as T
        */
       T operator () (const T1 & u){
           int mmin = u.indexmin();
           int mmax = u.indexmax();
           T z(mmin,mmax);
           for (int i=mmin;i<=mmax;i++){
               z(i) = gsm::spline_cubic_val(u(i),x,y,y2);
           }
           return z;
       }
       T operator () (const T & u);
    };
}
#endif /* GSM_SPLINES_HPP */


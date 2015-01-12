/**
 * \file equilibrium.cpp
 * \author Steve Martell
 * @defgroup GMACS
 * 
 */


#include <admodel.h>
#if defined __APPLE__ || defined __linux
	#include "../include/libgmacs.h"
#endif
#if defined _WIN32 || defined _WIN64
	#include "include\libgmacs.h"
#endif



/**
 * @ingroup GMACS
 * @brief Calculate equilibrium vector n given A, S and r
 * @details Solving a matrix equation for the equilibrium number
 * of crabs in length interval.
 * 
 * 
 * 
 * @param[out] n vector of numbers at length
 * @param[in] A size transition matrix
 * @param[in] S diagonal matrix of length specific survival rates
 * @param[in] r vector of new recruits at length.
 */
void calc_equilibrium(dvar_vector& n,
                      const dvar_matrix& A,
                      const dvar_matrix& S,
                      const dvar_vector r)
{
	int nclass = n.indexmax();
	dmatrix Id = identity_matrix(1,nclass);
	dvar_matrix At(1,nclass,1,nclass);

	At = trans(A*S);
	n  = -solve(At-Id,r);

}



/**
 * @brief Get initial vector of new shell and oldshell crabs at equilibrium
 * @ingroup GMACS
 * @authors Steve Martell and John Levitt
 * @date Jan 3, 2015.
 * 
 * @param[out] n vector of numbers at length in new shell condition
 * @param[out] o vector of numbers of old shell crabs at length
 * @param[in] A size transition matrix
 * @param[in] S diagonal matrix of length specific survival rates
 * @param[in] P diagonal matrix of length specific molting probabilities
 * @param[in] r vector of new recruits at length.
 * 
 * @details 
 * Jan 3, 2015.  Working with John Levitt on analytical solution instead of the 
 * numerical approach.  Think we have a soln.
 * 	
 * Notation: \n
 * \f$n\f$ = vector of newshell crabs \n
 * \f$o\f$ = vector of oldshell crabs \n
 * \f$P\f$ = diagonal matrix of molting probabilities by size \n
 * \f$S\f$ = diagonal matrix of survival rates by size \n
 * \f$A\f$ = Size transition matrix \n
 * \f$r\f$ = vector of new recruits (newshell) \n
 * \f$I\f$ = identity matrix. \n
 *
 * 	
 * The following equations represent the dynamics of newshell \a n and oldshell crabs.
 * 		\f{align*}{
 * 		 n &= nSPA + oSPA + r	\\		
 * 		 o &= oS(I-P) + nS(I-P) 
 * 		\f}
 * Objective is to solve the above equations for \f$n\f$ and \f$o\f$ repsectively.  
 * First, lets solve the second equation for \f$o\f$:
 * 		\f{align*}{
 * 		o &= n(I-P)S[I-(I-P)S]^{-1}
 * 		\f}
 * next substitute the above expression into first equation above and solve for \f$n\f$
 * 		\f{align*}{
 * 		n &= nPSA + n(I-P)S[I-(I-P)S]^{-1}PSA + r      \\
 * 		\mbox{let} \quad \beta& = [I-(I-P)S]^{-1},       \\
 * 		r &= n - nPSA - n(I-P)S \beta PSA               \\
 * 		r &= n(I - PSA - (I-P)S \beta PSA) 					\\
 * 		\mbox{let} \quad C& = (I - PSA - (I-P)S \beta PSA),    \\
 * 		n &= (C)^{-1} (r)
 * 		\f}
 * Note that \f$C\f$ must be invertable to solve for the equilibrium solution for \f$n\f$.
 * So the diagonal elements of \f$P\f$ and \f$S\f$ must be positive non-zero numbers.
 * 	
 * 	
 */
void calc_equilibrium(dvar_vector& n,
                      dvar_vector& o,
                      const dvar_matrix& A,
                      const dvar_matrix& S,
                      const dvar_matrix& P,
                      const dvar_vector& r)
{
	int nclass = n.indexmax();
	dmatrix Id = identity_matrix(1,nclass);
	dvar_matrix B(1,nclass,1,nclass);
	dvar_matrix C(1,nclass,1,nclass);
	dvar_matrix D(1,nclass,1,nclass);

	

	B = inv(Id - (Id-P)*S);
	C = P * S * A;
	D = trans(Id - C - (Id-P)*S*B*C);

	// COUT(A);
	// COUT(inv(D)*r);

	n = solve(D,r);			// newshell
	o = n*((Id-P)*S*B);		// oldshell

}	


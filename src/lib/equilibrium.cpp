#include <admodel.h>
#if defined __APPLE__ || defined __linux
	#include "../include/libgmacs.h"
#endif
#if defined _WIN32 || defined _WIN64
	#include "include\libgmacs.h"
#endif


/**
 * @brief Calculate equilibrium vector n given A, S and r
 * @details Solving a matrix equation for the equilibrium number
 * of crabs in length interval.
 * 
 * @param n vector of numbers at length
 * @param A size transition matrix
 * @param S diagonal matrix of length specific survival rates
 * @param r vector of new recruits at length.
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
 * @details 
 *  Jan 3, 2015.  Working with John Levitt on analytical solution instead of the 
 * 	numerical approach.  Think we have a soln.  
 * 	
 * 	Notation:
 * 		n = vector of newshell crabs
 * 		o = vector of oldshell crabs
 * 		P = diagonal matrix of molting probabilities by size
 * 		S = diagonal matrix of survival rates by size
 * 		A = Size transition matrix.
 * 		r = vector of new recruits (newshell)
 * 		I = identity matrix.
 * 	
 * 	The following equations represent the dynamics of newshell and oldshell crabs.
 * 		n = nSPA + oSPA + r						(1)
 * 		o = oS(I-P) + nS(I-P)					(2)
 * 	Objective is to solve the above equations for n and o repsectively.  Starting
 * 	with o:
 * 		o = n(I-P)S[I-(I-P)S]^(-1)				(3)
 * 	next substitute (3) into (1) and solve for n
 * 		n = nPSA + n(I-P)S[I-(I-P)S]^(-1)PSA + r
 * 	
 * 	let B = [I-(I-P)S]^(-1)
 * 		
 * 		n - nPSA - n(I-P)SBPSA = r
 * 		n(I - PSA - (I-P)SBPSA) = r
 * 	
 * 	let C = (I - PSA - (I-P)SBPSA)
 * 	
 * 	then n = C^(-1) r							(4)
 * 	and calculate o using (3)
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

	n = solve(D,r);			// newshell
	o = n*((Id-P)*S*B);		// oldshell
}


#ifndef _GMACSLIB_H_
#define _GMACSLIB_H_


#include "spr.h"
#include "nloglike.h"
#include "selex.hpp"


#undef COUT
#define COUT(object) cout << #object "\n" << setw(6) \
<< setprecision(3) << setfixed() << object << endl;


void calc_equilibrium(dvar_vector& n,
                      const dvar_matrix& A,
                      const dvar_matrix& S,
                      const dvar_vector r);

void calc_equilibrium(dvar_vector& n,
                      dvar_vector& o,
                      const dvar_matrix& A,
                      const dvar_matrix& S,
                      const dvar_matrix& P,
                      const dvar_vector& r);


dmatrix get_empirical_molt_increment(const dvector& bin, const dmatrix& data);


class population_model 
{
public:
	population_model();
	~population_model();
	
};

#endif

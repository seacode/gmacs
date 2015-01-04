#ifndef _GMACSLIB_H_
#define _GMACSLIB_H_

#include "spr.h"
#include "nloglike.h"
#include "selex.hpp"

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

#endif
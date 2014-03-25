// Catch at length model: Model dimensions are years by size, sex, shell-condition, and maturity stage.
// Note: This simple example adapted from ADMB catage.tpl as a learning exercise for Gmacs model development.
// By Athol Whitten and Jim Ianelli, SAFS UW and ASFC NOAA 2014

GLOBALS_SECTION
  #include <admodel.h>

  #define echo(object) echoinput << #object << "\n" << object << endl;
  #define echotxt(object,text) echoinput << object << "\t" << text << endl;
  ofstream echoinput("echoinput.ad");

DATA_SECTION
  init_int nyrs; 
  init_int nclass;
  init_int nsex;
  init_int nshell;
  init_int nstage;

  !! int nmats = nsex * nshell * nstage;
  !! int ncol = nmats * nclass;

  matrix pmat(1,nmats,1,2);

  !! pmat.colfill_seqadd(1, 1, nclass);
  !! pmat.colfill_seqadd(2, nclass, nclass);

  !! int npshell = nsex*nshell;
  !! int npstage = nsex*nshell*nstage;

  ivector psex(1,nsex);
  ivector pshell(1,npshell);
  ivector pstage(1,npstage);

 LOC_CALCS
  int some_num = nsex*nshell;
 END_CALCS

  !! psex.fill_seqadd(1,(ncol/nsex));
  !! pshell.fill_seqadd(1,(ncol/npshell));
  !! pstage.fill_seqadd(1,(ncol/npstage));
   
  !! echo(nyrs);
  !! echo(nclass);
  !! echo(nsex);
  !! echo(nshell);
  !! echo(nstage);

  !! echo(nmats);
  !! echo(ncol);
  !! echo(pmat);
  !! echo(psex);
  !! echo(pshell);
  !! echo(pstage);

  // TODO: Work out loop structure that can use p* ivectors.
  // Loop over i for each p*(i) -> p*(i+1)-1 as i goes from 1 to np*.

  // Build N matrix with arbitrary sex values (get shape right);
  matrix N(1,nyrs,1,ncol);
  !! N.initialize();

 LOC_CALCS
  for(int yr=1; yr<=nyrs; yr++)
  {
    for(int i=1; i<=nsex; i++)
    {
      for(int j=psex(i); j<=psex(i)+(ncol/nsex)-1; j++)
      {
        N(yr,j) = i;  
      }
    }
  }
 END_CALCS

  // Build NX matrix with arbitrary values for all dimensions (get shape and positions right);
  matrix NX(1,nyrs,1,ncol);
  !! NX.initialize();

 LOC_CALCS
  for(int yr=1; yr<=nyrs; yr++)
  {
    for(int i=1; i<=npstage; i++)
    {
      for(int j=pstage(i); j<=pstage(i)+(ncol/npstage)-1; j++)
      {
        NX(yr,j) = i;  
      }
    }
  }
 END_CALCS

  !! echo(N);
  !! echo(NX);

  init_matrix obs_catch_at_size(1,nyrs,1,ncol);
  init_vector effort(1,nyrs);
  init_number M;
  vector relwt(2,nclass);

  !! echo(obs_catch_at_size);
  !! echo(effort);

  !! exit(1);

INITIALIZATION_SECTION
  log_q -1
  log_popscale 5

PARAMETER_SECTION
  init_number log_q(1);
  init_number log_popscale(1);
  init_bounded_dev_vector log_sel_coff(1,nclass-1,-15.,15.,2);
  init_bounded_dev_vector log_relpop(1,nyrs+nclass-1,-15.,15.,2);
  init_bounded_dev_vector effort_devs(1,nyrs,-5.,5.,3);
  vector log_sel(1,nclass);
  vector log_initpop(1,nyrs+nclass-1);
  matrix F(1,nyrs,1,nclass);
  matrix Z(1,nyrs,1,nclass);
  matrix S(1,nyrs,1,nclass);
  matrix N(1,nyrs,1,nclass);
  matrix C(1,nyrs,1,nclass);
  objective_function_value f;
  number recsum;
  number initsum;
  sdreport_number avg_F;
  sdreport_vector predicted_N(2,nclass);
  sdreport_vector ratio_N(2,nclass);
  likeprof_number pred_B;

PRELIMINARY_CALCS_SECTION
  // Invent some relative average weight-at-size numbers
  relwt.fill_seqadd(1.,1.);
  relwt=pow(relwt,.5);
  relwt/=max(relwt);

PROCEDURE_SECTION
  // Example of using FUNCTION to structure the procedure section
  get_mortality_and_survivial_rates();

  get_numbers_at_size();

  get_catch_at_size();

  evaluate_the_objective_function();

FUNCTION get_mortality_and_survivial_rates
  int i, j;
  // calculate the selectivity from the sel_coffs
  for (j=1;j<nclass;j++)
  {
    log_sel(j)=log_sel_coff(j);
  }
  // the selectivity is the same for the last two size classes
  log_sel(nclass)=log_sel_coff(nclass-1);

  // This is the same as F(i,j)=exp(q)*effert(i)*exp(log_sel(j));
  F=outer_prod(mfexp(log_q)*effort,mfexp(log_sel));
  if (active(effort_devs))
  {
    for (i=1;i<=nyrs;i++)
    {
      F(i)=F(i)*exp(effort_devs(i));
    }
  }
  // get the total mortality
  Z=F+M;
  // get the survival rate
  S=mfexp(-1.0*Z);

FUNCTION get_numbers_at_size
  int i, j;
  log_initpop=log_relpop+log_popscale;
  for (i=1;i<=nyrs;i++)
  {
    N(i,1)=mfexp(log_initpop(i));
  }
  for (j=2;j<=nclass;j++)
  {
    N(1,j)=mfexp(log_initpop(nyrs+j-1));
  }
  for (i=1;i<nyrs;i++)
  {
    for (j=1;j<nclass;j++)
    {
      N(i+1,j+1)=N(i,j)*S(i,j);
    }
  }
  // calculated predicted numbers at size for next year
  for (j=1;j<nclass;j++)
  {
    predicted_N(j+1)=N(nyrs,j)*S(nyrs,j);
    ratio_N(j+1)=predicted_N(j+1)/N(1,j+1);
  }
  // calculated predicted Biomass for next year for
  // adjusted profile likelihood
  pred_B=(predicted_N * relwt);

FUNCTION get_catch_at_size
  C=elem_prod(elem_div(F,Z),elem_prod(1.-S,N));

FUNCTION evaluate_the_objective_function
  // penalty functions to ``regularize '' the solution
  f+=.01*norm2(log_relpop);
  avg_F=sum(F)/double(size_count(F));
  if (last_phase())
  {
    // a very small penalty on the aversize fishing mortality
    f+= .001*square(log(avg_F/.2));
  }
  else
  {
    f+= 1000.*square(log(avg_F/.2));
  }
  f+=0.5*double(size_count(C)+size_count(effort_devs))
    * log( sum(elem_div(square(C-obs_catch_at_size),.01+C))
    + 0.1*norm2(effort_devs));

REPORT_SECTION
  report << "Estimated numbers of fish " << endl;
  report << N << endl;
  report << "Estimated numbers in catch " << endl;
  report << C << endl;
  report << "Observed numbers in catch " << endl;
  report << obs_catch_at_size << endl; 
  report << "Estimated fishing mortality " << endl;
  report << F << endl; 

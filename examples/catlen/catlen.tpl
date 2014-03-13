// Catch at length model: Calculations over size, sex, shell-condition, maturity
// Note: This simple example adapted from ADMB catage.tpl as a learning exercise for Gmacs model development.
// By Athol Whitten and James Ianelli, ASFC NOAA 2014

DATA_SECTION
  init_int nyrs  
  init_int nsizes
  init_matrix obs_catch_at_size(1,nyrs,1,nsizes)
  init_vector effort(1,nyrs)
  init_number M
  vector relwt(2,nsizes);

INITIALIZATION_SECTION
  log_q -1
  log_popscale 5

PARAMETER_SECTION
  init_number log_q(1)
  init_number log_popscale(1)
  init_bounded_dev_vector log_sel_coff(1,nsizes-1,-15.,15.,2)
  init_bounded_dev_vector log_relpop(1,nyrs+nsizes-1,-15.,15.,2)
  init_bounded_dev_vector effort_devs(1,nyrs,-5.,5.,3)
  vector log_sel(1,nsizes)
  vector log_initpop(1,nyrs+nsizes-1);
  matrix F(1,nyrs,1,nsizes)
  matrix Z(1,nyrs,1,nsizes)
  matrix S(1,nyrs,1,nsizes)
  matrix N(1,nyrs,1,nsizes)
  matrix C(1,nyrs,1,nsizes)
  objective_function_value f
  number recsum
  number initsum
  sdreport_number avg_F
  sdreport_vector predicted_N(2,nsizes)
  sdreport_vector ratio_N(2,nsizes)
  // changed from the manual because adjusted likelihood routine doesn't
  // work
  likeprof_number pred_B

PRELIMINARY_CALCS_SECTION
  // this is just to ``invent'' some relative average weight-at-size numbers
  relwt.fill_seqadd(1.,1.);
  relwt=pow(relwt,.5);
  relwt/=max(relwt);

PROCEDURE_SECTION
  // example of using FUNCTION to structure the procedure section
  get_mortality_and_survivial_rates();

  get_numbers_at_size();

  get_catch_at_size();

  evaluate_the_objective_function();

FUNCTION get_mortality_and_survivial_rates
  int i, j;
  // calculate the selectivity from the sel_coffs
  for (j=1;j<nsizes;j++)
  {
    log_sel(j)=log_sel_coff(j);
  }
  // the selectivity is the same for the last two size classes
  log_sel(nsizes)=log_sel_coff(nsizes-1);

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
  for (j=2;j<=nsizes;j++)
  {
    N(1,j)=mfexp(log_initpop(nyrs+j-1));
  }
  for (i=1;i<nyrs;i++)
  {
    for (j=1;j<nsizes;j++)
    {
      N(i+1,j+1)=N(i,j)*S(i,j);
    }
  }
  // calculated predicted numbers at size for next year
  for (j=1;j<nsizes;j++)
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

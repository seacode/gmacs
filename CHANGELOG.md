# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/) and this file inspired by http://keepachangelog.com/
## [Unreleased][unreleased]
### Changed


## [0.0.4] - 2014-12-11
### In FUNCTION calc_growth_transition
Diagonal of the matrix now represents probability
of not molting, and upper triangle is the probability of growing to the next
size interval given you molted.

## [0.0.3] - 2015-01-20
### In FUNCTION calc_growth_transition
Jim reported that cumd_gamma was not converging. Required large
number of iterations to solve the cumd_gamma function in gser in the ADMB libs.
Soln, either increase the MAXIT in gser, or rescale the problem to the maximum
of the size breaks. The latter seems to work.

## [0.0.2] - 2015-01-11
### In FUNCTION calc_growth_transition
Checked cumd_gamma function in ADMB with R. This is the same
function as pgamma with the rate parameter set at its default value 1.0. The
mean value of the function is the second argument of cumd_gamma, and the vector
of quantiles is the first argument. Both arguments are scaled by gscale.

## [0.0.1] - 2014-12-20
### In FUNCTION calc_growth_transition
Undid the below modification after correspondence with Jack Turnock.
He rightly pointed out that it is possible to molt and remain in the same bin
interval (if the intervals are sufficiently large).




## [0.0.0] - pre 2014-12-20
5.	When number of classes in the data and the model differ by an integer factor, class link matrix is automatically generated.
6.	When number of classes in the data is not a multiple of number of classes in the model, read in class_link matrix.
7.	Names of fleets and surveys now printed correctly to echoinput file: (bug fix).
8.	Functionality improved for writeR: Fleet and survey names now exported to R and used for plots.
9.	All references in model are now to size-classes rather than length classes.
10. Gmacs R Functions now wrapped in simple 'gmplot_all' function, can be used with any model.
11.	Fleet control section of data file is now extended to include surveys, catch units and multipliers, all entered in the one matrix. This is to prepare for future options where a fishing fleet might also have a 'survey' such as a CPUE index, and where a survey might have some catch.
12.	Data file now expects extra dimensions to be specified, such as number of shell and maturity types.
13. Initial numbers can now be specified by estimating early recruitments. Initial numbers options input via control file. NOTE: Currently the lognin_parms have to be entered and have phase set to -ve so as not to be estimated. Later: Make reading these lines conditional.
14. Retention function can now be selected from among multiple options. This includes a logistic function. Currently borrowed from cstar::selex functions.
15.	Growth functions can now be selected from among multiple options. This includes a linear growth relationship with a gamma distribution about each size class.
16. Internal calculations have been modified so that multiple copies of selectivity, retention, or size-transition matrix patterns are not created nor stored as before. This make the code mode efficient. NOTE: Will do the same for selectivity, but waiting until further selectivity updates are made [to selex_fleet and selex_survey]

* Many updates to Gmacs R functions: Can now be used for any Gmacs model.

---

## Priority changes for Gmacs: Development of a complete example for BBRKC.

1. A 20 size class model requires several changes from the basic structure presented in January:
  * Change to available selectivity functions, beyond 'parameter-per-class'. DONE
  * Change to initial numbers estimation from 'parameter-per-class' option to early-recruitment build-up option. DONE
  * Change to available retention functions, beyond 'parameter-per-class'. MODIFY FROM SELECTIVITY
  * Change to growth estimation from 'parameter-per-class' to parametric approach.
2. Change population dynamics calculations to include more dimensions:
  * Set-up dimensions of N matrix via input numbers of sex, shell, maturity. DONE
  * Read in data for each dimension as necessary: DONE
  * Make sure predicted and observed vales have the same generalized structure and complete calculations.
  * Change pop dynamics equations to loop over different dimensions:
3. Remove penalty E3 in the final estimation phase.

4. Include molting probability (inc. time-varying) into the calculation of the growth transition matrix.
  * Might be able to cheat at start by using growth transition matrix from Jie.

5. Create output file with estimated parameters, starting values, final estimates, bounds, phases, as well as asymptotic standard errors.
  * Automatically highlight cases where parameters are on or close to the bounds in the input.

6. Update R plots for Gmacs Assessment Report
  * Add confidence intervals to plots of data points which are considered uncertain.
    - DONE for Recruitment estimates
    - Others with SD functions?

7. Check weightings and likelihoods are working correctly with more generalised model.

8. See NPRB model for 'biological parameters' set up, which uses a counter to allow for differing numbers of parms.
  This could replace the current 'theta' block of parameters.

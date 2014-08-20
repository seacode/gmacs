# Gmacs

Gmacs is currently under development; the latest source files may or may not compile using recent versions of ADMB. A simple working release version of Gmacs is available via `Tag V1.0` and has been tested using the BBRKC model available in the examples folder. This release will remain active until the next major release, planned for September 2014.

## Table of contents
- [TODO List](#todo-list)
- [Introduction](#generalized-modeling-for-alaskan-crab-stocks)
- [Input File Structure](#input-file-structure)
- [Gmacs R Package](#r-package-for-gmacs)

## Generalized Modeling for Alaskan Crab Stocks
This repository holds source code, instructions, examples, and associated scripts for **Gmacs** (Generalized Modeling for Alaskan Crab Stocks), a generic size-based stock assessment modelling framework. 

## Modeling structure and format
Gmacs implements size-structured assessment models with flexibility similar to that provided by other general stock assessment modelling frameworks. 

### Input file structure
Data are supplied via the `model.dat` file in a *flat format* to enable easy indexing and simple preparation using spreadsheet software. Each record for catch, abundance, length-structure etc. should be held in an individual row, with information relating to year, fleet, sex and more:

####  Catch data structure
 
  * Year, Season, Fleet, Sex, Observation    

####  Survey data structure
 
  * Year, Season, Survey, Observation, Error

####  Length frequency data structure  

  * Year, Season, Fleet/Survey, Sex, Maturity, Shell Condition, No. Samples, Data

Gmacs allows for the inclusion of an optional growth data file `growth.dat` to specify a fixed growth transtion matrix or year-specific growth transtion matrices. The program also reads a control file `model.ctl` for specifications relating to parameter estimation. 

During the read-in procedure, helpful messages are printed to screen and the information read in is printed to a separate file called `echoinput.gm` allowing users to check and debug their data and control files. 

A general user-guide to the program is under development in parallel with the Gmacs Wiki and will be made available with future releases.

## Simulation Mode

A simulation-estimation procedure can be performed with Gmacs, by using the `gmacs -sim` flag. For example, try `gmacs -sim 123`, where 123 is a random number seed.

## R Package for Gmacs
An R package, called `gmr` is under development for Gmacs: a full pilot version is intended for release in September 2014, timed to coincide with the next stable release of Gmacs. Current development versions of the package can be downloaded from Github directly through R, see https://github.com/seacode/gmr for details.

## Development
This software is under development and is not yet intended for general use. If you would like to contribute to the project, please contact [Athol Whitten](mailto:whittena@uw.edu). 

<!-- TODO list created by Martell and Whitten -->
### TODO List ###

#### Project
- [x] Create makefile for building and installing Gmacs (debug & release)
  - [x] Test makefile on Windows box (batch file)
- [x] Create commandline option for simulation model (-sim seedNo.)
- [ ] Perform simulation testing
- [ ] Update documentation
  - [ ] Extend existing Doxygen comments and create Doxygen output
  - [x] Continue working on Gmacs Wiki, pdf version = user-guide
- [ ] Test scripts with simulated data and examples

#### Gmacs Executable
- [x] Get code to compile.
- [ ] Document data structures.
- [ ] Implement alternative likelihoods for composition data
- [x] Develop alternative models for time-varying parameters
- [x] Implement spline functions as alternative to 'piecewise linear' functions in current model.
- [ ] Consider cumulative normal distribution (and/or others) as alternatives to gamma function for size-at-recruitment and/or growth increment.
- [ ] Incorporate option to use tagging data to estimate growth.
- [x] Implement the capacity to change functional form for selectivity (and other factors) over time
- [ ] Implement the capacity for penalties to be placed on the extent to which parameters change over time
- [ ] Implement time-varying recruitment using deviations from a SR-relationship as alternative to using deviations from a mean
- [ ] Allow time-varying M to depdend on maturity state *and* length
- [ ] Implement **hybrid** method as an option for calculating annual fishing mortality rates
- [x] Add options for implementing cubic splines
  - [ ] splines for selectivity,
  - [ ] splines for initial size-distribution,
  - [ ] splines of time-varying parameters.
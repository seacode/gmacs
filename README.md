# Gmacs Version 1.0 #

This is the pilot release of Gmacs. Currently posted source files are compilable using ADMB 11.1 and have been tested using the BBRKC model available in the examples folder. This release will remain active until the current 'under development' version is released. **Updated February 2014, by Athol Whitten**

## Table of contents ##
- [TODO List](#todo-list)
- [Introduction](#intro)
- [Input File Structure](#input)

## Generalized Modeling for Alaskan Crab Stocks ##
This repository holds source code, instructions, examples, and associated scripts for **Gmacs** (Generalized Modeling for Alaskan Crab Stocks), a generic size-based stock assessment model. 

## Modeling structure and format ##
Gmacs implements a size-structured modelling framework with flexibility similar to that provided by other general stock assessment modelling frameworks. Some effort has been made to maintain consistency with data and control file formats familiar to users of Stock Synthesis.

### Input file structure
Data are supplied via the `model.dat` file in a *flat format* to enable easy indexing and simple preparation using spreadsheet software. Each record for catch, abundance, length-structure etc. should be held in an individual row, with information relating to year, fleet, sex and more:

####  Catch data structure
 
  * Year, Season, Fleet, Sex, Observation    

####  Survey data structure
 
  * Year, Season, Survey, Observation, Error

####  Length frequency data structure  

  * Year, Season, Fleet/Survey, Sex, Maturity, Shell Condition, No. Samples, Data

Gmacs allows for the inclusion of an optional growth data file `growth.dat` to specify a fixed growth transtion matrix or year-specific growth transtion matrices. The program also reads a `starter.gm` file for specifying the overall model run conditions, and a control file `model.ctl` for specifications relating to parameter estimation. Finally, a `forecast.gm` file is read to specify the calculation of relevant reference points. This file will allow users to specify model projection options in later versions of Gmacs.

During the read-in procedure, helpful messages are printed to screen and the information read in is printed to a separate file called `echoinput.gm` allowing users to check and debug their data and control files. 

A general user-guide to the program is under development in parallel with the Gmacs Wiki and will be made available with future releases.

## Development ##
This software is under development and is not yet intended for general use. If you would like to contribute to the project, please contact [Athol Whitten](mailto:whittena@uw.edu). 


<!-- TODO list created by Martell and Whitten -->
## TODO List ##

# Project
- [ ] Create makefile for building & installing Gmacs (debug & release).
- [ ] Test makefile on Windows box.
- [ ] Commandline option for simulation model (-sim seedNo.)
- [ ] Simulation testing.
- [ ] Documentation
	- [ ] Doxygen
	- [ ] Write up the model description (Latex) with all equations/options.

# Gmacs Executable
- [ ] 
- [ ] Implement alternative likelihoods for composition data
- [ ] Develop alternative models for time-varying parameters
- [ ] Implement spline functions as alternative to 'piecewise linear' functions in current model.
- [ ] Consider cumulative normal distribution (and/or others) as alternatives to gamma function for size-at-recruitment and/or growth increment.

# Gmacs

Gmacs is currently under development. A simple working release version of Gmacs is available via `Tag V1.0` and has been tested using the BBRKC model available in the examples folder. The next major release of Gmacs is planned for September 2014.

## Table of contents
- [Introduction](#generalized-modeling-for-alaskan-crab-stocks)
- [Input File Structure](#input-file-structure)
- [Gmacs R Package](#r-package-for-gmacs)

## Generalized Modeling for Alaskan Crab Stocks
This repository holds source code, instructions, examples, and associated scripts for **Gmacs** (Generalized Modeling for Alaskan Crab Stocks), a generic size-based stock assessment modelling framework. 

## Modeling structure and format
Gmacs implements size-structured assessment models with flexibility similar to that provided by other general stock assessment modelling frameworks. 

### Input file structure
Data are supplied via the `model.dat` file in a *flat format* to enable easy indexing and simple preparation. Each record for catch, abundance, length-structure etc. should be held in an individual row, with information relating to year, fleet, sex and more:

####  Catch data structure
 
  * Year, Season, Fleet, Sex, Observation, CV    

####  Survey data structure
 
  * Year, Season, Survey, Sex, Abundance, CV

####  Length frequency data structure  

  * Year, Season, Fleet/Survey, Sex, Type (of data), Shell Condition, Maturity, No. Samples, Data

Model specifcations are controlled through the `model.ctl` file. During the read-in procedure, helpful messages are printed to screen and information read in from both the data and control files is printed to a separate file called `echoinput.rep` allowing users to check and debug their input. For more information, see the general user-guide at: [Gmacs Wiki](https://github.com/seacode/gmacs).

## Simulation Mode

A simulation-estimation procedure can be performed with Gmacs, by using the `gmacs -sim` flag. For example, try `gmacs -sim 123`, where 123 is a random number seed.

## R Package for Gmacs
An R package, called `gmr` is under development for Gmacs: a full pilot version is intended for release in September 2014, timed to coincide with the next stable release of Gmacs. Current development versions of the package can be downloaded from Github directly through R, see https://github.com/seacode/gmr for details.

## Development
This software is under development and is not yet intended for general use. If you would like to contribute to the project, please contact [Athol Whitten](mailto:whittena@uw.edu). 
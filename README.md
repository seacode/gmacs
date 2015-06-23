# Gmacs

[![Build Status](https://travis-ci.org/seacode/gmacs.svg?branch=issue77)](https://travis-ci.org/seacode/gmacs)

A generalized size-structured stock assessment modelling framework. Gmacs includes:

  * The Gmacs model
  * A simulation model
  * An R package for working with Gmacs output files
  * Documentation

### Resources
  * **User Manual**: https://github.com/seacode/gmacs/wiki
  * **API**: http://seacode.github.io/gmacs/




The framework is designed with similar flexibility to that provided
  by age-structured stock assessment modelling frameworks like Stock Synthesis
  and [CASAL](https://www.niwa.co.nz/fisheries/tools-resources/casal). Gmacs can
  fit to a wide-variety of data for single sex or sex-specific population
  dynamics and fishery models: data can include survey and fishery indices of
  abundance and fishery- and survey-based size-composition data.

### Data Requirements

Data must be supplied via the `model.dat` file in a *flat format* to enable easy
indexing and simple preparation. Each record for catch, abundance,
length-structure etc. should be held in an individual row, with information
relating to year, fleet, sex and more.

Model specifcations are controlled through the `model.ctl` file. Information
read from files is printed to a separate file called `echoinput.rep` allowing
users to check and debug their input. For more information see the [Gmacs
Wiki](https://github.com/seacode/gmacs/wiki).

## R Package for Gmacs

An R package, called `gmr` is under development in support of Gmacs. The package
provides functions for creating plots from Gmacs output files. A full pilot
version is intended for release in September 2014, timed to coincide with the
next stable release of Gmacs. Current development versions of the package can be
downloaded from Github directly through R, see
https://github.com/seacode/gmacs/tree/develop/gmr for more details.

## Simulation Mode

A simulation-estimation procedure can be performed with Gmacs, by using the
`gmacs -sim` flag. For example, try `gmacs -sim 123`, where 123 is a random
number seed.

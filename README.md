# Gmacs

<!-- Gmacs is currently under development. A simple working release version of Gmacs is available via `Tag V1.0` and has been tested using the BBRKC model available in the examples folder. The next major release of Gmacs is planned for September 2014. -->

## Table of contents
- [About Gmacs](#about-gmacs)
- [Gmacs R Package](#r-package-for-gmacs)
- [Development](#development)

## About Gmacs
**Gmacs** is a generalized size-structured stock assessment modelling framework. The framework is designed with similar flexibility to that provided by age-structured stock assessment modelling frameworks like Stock Synthesis and CASAL. Gmacs can fit to a wide-variety of data for single sex or sex-specific population dynamics and fishery models: data can include survey and fishery indices of abundance and fishery- and survey-based size-composition data.

### Data Requirements
Data must be supplied via the `model.dat` file in a *flat format* to enable easy indexing and simple preparation. Each record for catch, abundance, length-structure etc. should be held in an individual row, with information relating to year, fleet, sex and more.

Model specifcations are controlled through the `model.ctl` file. Information read from files is printed to a separate file called `echoinput.rep` allowing users to check and debug their input. For more information see the [Gmacs Wiki](https://github.com/seacode/gmacs/wiki).

## R Package for Gmacs
An R package, called `gmr` is under development in support of Gmacs. The package provides functions for creating plots from Gmacs output files. A full pilot version is intended for release in September 2014, timed to coincide with the next stable release of Gmacs. Current development versions of the package can be downloaded from Github directly through R, see https://github.com/seacode/gmr for more details.

## Simulation Mode
A simulation-estimation procedure can be performed with Gmacs, by using the `gmacs -sim` flag. For example, try `gmacs -sim 123`, where 123 is a random number seed.

## Development
This software is under development and is not yet intended for general use. If you would like to contribute to the project, please see the [Developers Guide](https://github.com/seacode/gmacs/wiki/5.-Developers).
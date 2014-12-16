# gmr
### R code for Gmacs

The `gmr` R package is under development in support of the [Gmacs](https://github.com/seacode/gmacs) stock assessment modeling framework. More information about the package can be found on the [Gmacs Wiki](https://github.com/seacode/gmacs/wiki), under the [R Package](https://github.com/seacode/gmacs/wiki/4.-R-Package) section. 

The most recent release of the `gmr` package can be downloaded and installed from Github through R:
```S
install.packages("devtools")
devtools::install_github("seacode/gmacs",subdir="/Rsrc",ref="develop")
```

Once the `gmr` package is installed, it can be loaded in the regular manner:

```S
library(gmr)
````

To install previous release versions of `gmr`, use, for example:

```S
devtools::install_github("seacode/gmacs/Rsrc", ref = "V1.0")
````

To install current development versions of `gmr`, use:

```S
devtools::install_github("seacode/gmacs/Rsrc", ref = "develop")
```

### Useage note 
> The R code available in this package comes with no warranty or guarantee of accuracy. It merely represents an ongoing attempt to integrate output plotting with statistical and diagnostical analsyses for Gmacs. It is absolutely necessary that prior to use with a new application, the user checks the output manually to verify that there are no plotting or statistical bugs which could incorrectly represent the output files being analyzed.

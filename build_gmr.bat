R --vanilla < update-description.R
rem run roxygen
R --vanilla < roxygenize.R
Rcmd build --force gmr
Rcmd INSTALL --build gmr

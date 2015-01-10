R CMD BATCH roxygenize.R
R CMD build gmr
R CMD INSTALL gmr_*.tar.gz

R CMD BATCH roxygenize.R
R CMD build Rsrc
R CMD INSTALL gmr_*.tar.gz

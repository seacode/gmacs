R CMD BATCH gmr/update-description.R
R CMD BATCH gmr/roxygenize.R
R CMD build gmr
R CMD INSTALL gmr_*.tar.gz
rm gmr_*.tar.gz
cd gmr
chmod 777 DESCRIPTION

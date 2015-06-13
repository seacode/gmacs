cd gmr/
R CMD BATCH update-description.R
R CMD BATCH roxygenize.R
cd ../
R CMD build gmr
R CMD INSTALL gmr_*.tar.gz
rm gmr_*.tar.gz
cd gmr
chmod 777 DESCRIPTION

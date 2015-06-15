cd gmr/
R CMD BATCH update-description.R
R CMD BATCH roxygenize.R
chmod 777 DESCRIPTION

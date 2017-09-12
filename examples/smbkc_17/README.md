# Multiple model configurations for SMBKC

## Alternatives

Model         | Description
------------- | -------------
model_1       | - Basecase (last year's selected 1)      
model_2       | - Add trawl survey for 2017
model_3       | - Add both 2017 pot and trawl surveys
model_4       | - Apply VAST series
model_5       | - Fit surveys (lambda up on those)
model_6       | - Francis weights

Notice the use of a single .dat file for all of the different model runs. 
The .dat file sits in assessment root, 
each model has its own directory (i.e. model_1, ..., model_4), and in each model directory is a different control file.

# Multiple model configurations for SMBKC

## Alternatives

Model         | Description
------------- | -------------
model_1       | - Basecase (last year's model 1)      
model_2       | - Add CV to both surveys
model_3       | - Use M random walk
model_4       | - Use M and add CV

Notice the use of a single .dat file for all of the different model runs. The .dat file sits under smbkc2, each model has its own directory (i.e. model_1, ..., model_4), and in each model directory is a different control file.

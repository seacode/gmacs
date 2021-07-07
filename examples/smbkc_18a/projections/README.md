# Base model 
From Andre with projection options available. 
Model 1 from 2018a - see smbkc_18a/model_1
model for smbkc for 2018a model framework and setup are pulled from 'gmacs'

# Current model 
from gmacs/examples/smbkc_18a/model_1 
was model 3 from 2018 assessment

# GMACS version
gmacs.tpl file from Jie on 4-8-19 copied gmacs.exe from folder 
(local only: C:\Users\kjpalof\Documents\SMBKC\breakpoint_SR\breakpoint_smbkc\model_1_2018a))
gmacs.tpl in projections folder, version with Jie's edits 4-5-19 


# Projections
projections
    1 mean recruitment 1979-2017
    2 ricker recruitment
    3 B-H recruitment
    4 mean recruitment 1996-2017
    5 mean recruitment 1996-2017, Bmsy from 1996-2017
    6 mean recruitment 1999-2008
    7 mean recruitment 1989-2017

a) No bycatch mortality, NO state harvest policy implemented
b) Bycatch mortality average last 5 years, NO state harvest policy implemented
c) No bycatch mortality, state harvest policy implemented
d) Bycatch mortality average last 5 years, state harvest policy implemented

  
# Summary
Bycatch mortality does NOT influence projection results

1 Assumes mean recruitment from the entire time series (1978-2017)
Tmin - under no directed fishing - 7.5 years
        - F=0.18 not rebuilt
        - State harvest policy implemented - T min = 11.5 years

2 Assumes ricker stock recruit relationship 
Tmin - under no directed fishing - 16.5 years
        - F=0.18 not rebuilt
        - State harvest policy implemented - T min = 28.5 years

3 Assumes B-H stock recruit relationship
Tmin - under no directed fishing - 14.5 yeA ars
        - F=0.18 not rebuilt
        - State harvest policy implemented - T min = 23.5 years

4 Assumes mean recruitment from the recent break in recruitment 1996-2017
Not rebuilt in 50 years....no matter the F used. 
    e - 75 years from 4d
    f -  years from 4d - the 100 year projections aren't working...why?

5 Assumes mean recruitment from recent break 1996-2017, also uses this time frame for BMSY proxy (1996-2017)
Tmin - under no directed fishing - 10.5 years
        - F = 0.18 not rebuilt
        - State harvest policy implemented - Tmin = 10.5 years


# weighted combination


# To do / Issues
More projection models?
Weighted combinations?
# Setup for Saint Matthews Blue King Crab model
  run.sh for linux machines 
  run.bat for windows

## Notes on model
  * Adding rec_dev in first year seemed to put things closer to 2015 model...
  * Fbar_sd computed in 2015 even though no catch recorded...check with Jie if it makes any sense to use an estimate     
  * Need to check on dynamic Bzero calculations    
	* Changed F control for final phase to remove constraint on fishing mortality guesses    
	* In source file set the "average" F penalty to apply to season 2 around line 2917 of gmacs.tpl    
	* First selectivity parameters have an issue (huge gradients)                
	* LogR0 probably shouldn't be turned on since model not initialized at unfished                    
  * size at recruitment can't really be estimated with this number of bins?        


### Resources
  * **Wiki**: https://github.com/seacode/gmacs/wiki
  * **API**: http://seacode.github.io/gmacs/
  * **Model Description**: https://github.com/seacode/gmacs/blob/develop/docs/developer/ModelDescription.pdf
  * **Release Notes**: https://github.com/seacode/gmacs/blob/develop/CHANGELOG.md

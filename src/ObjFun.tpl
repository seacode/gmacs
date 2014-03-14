FUNCTION ObjFunction
  double incc = 0.00001; // to be global
  double incd = 0.0001; // to be global
  prior_val.initialize(); 
  like_val.initialize();
  Get_Likes();
  Get_Priors();
 // cout << prior_val << endl;
 // cout << like_val << endl;  
FUNCTION Get_Likes
  int ilike=0;
  // Likelihood for Catch biomass (or number)-----------------------
  // This could be re-written withoutiff statement
  for (int ifl=1;ifl<=nfleet;ifl++)
  {
    ilike++; ///< Increment the likelihood index
    if(catch_unit(ifl) == 1)
      like_val(ilike) += norm2(log((catch_biom_pred(ifl)+incd)/(catch_biom_obs(ifl)+incd)));
    else
      like_val(ilike) += norm2(log((catch_num_pred(ifl)+incd)/(catch_num_obs(ifl)+incd)));
  }
 
  // Catch LFs-----------------------
  for (ifl=1;ifl<=nfleet;ifl++)
  {
    ilike++; ///< Increment the likelihood index
    for (int i=1;i<=nlf_fleet(ifl);i++)
    {
      dvar_vector phat = fleet_lf_pred(ifl,i)/sum(fleet_lf_pred(ifl,i));
      dvector pobs     = fleet_lf_obs(ifl,i)/sum(fleet_lf_obs(ifl,i)); // this should probably be done once in beginning
      // Andre's version waste time w/ constants
      //dvariable Error  = elem_div((phat+Incc),(pobs+Incc));
      // like_val(ilike)  += -ss_fleet_lf(ifl,i)*pobs*log(Error);
      // ignores constant, vector x vector returns a scalar
      like_val(ilike)  += -ss_fleet_lf(ifl,i)*pobs*log(phat);
  } 

  // Effort indices-----------------------
  qEff.initialize();
  for (ifl=1;ifl<=nfleet;ifl++)
  {
    ilike++; ///< Increment the likelihood index
    nn= 0;
    /*
    // TODO: figure out how effort is used
    for (styr=Yr1;styr<=endyr;styr++)
      if (Effort(Ifleet,styr) > 0) 
      {
        if (FOverWrite(Ifleet,0) == 0 |styr<FOverWrite(Ifleet,1) | styr>FOverWrite(Ifleet,2))
        { 
          nn++ ; 
          qEff(Ifleet) += log((Effort(Ifleet,styr)+Incd)/(ExplRates(Ifleet,styr)+Incd)); 
        }
      }  
    qEff(Ifleet) = mfexp(qEff(Ifleet)/nn); 
    for (styr=Yr1;styr<=endyr;styr++)
     if (Effort(Ifleet,styr) > 0)
      if (FOverWrite(Ifleet,0) == 0 |styr<FOverWrite(Ifleet,1) | styr>FOverWrite(Ifleet,2))
       like_val(ilike) += square(log((Effort(Ifleet,styr)+Incd)/(qEff(Ifleet)*(ExplRates(Ifleet,styr)+Incd))));
   }  
    */

  // Survey indices 
  // !!    SurveyEst(DIfleet,DIyr,2) = sqrt(log(square(SurveyEst(DIfleet,DIyr,2))+1.0));
  for (int isrv=1;isrv<=nsurvey;isrv++)
  {
    ilike++; ///< Increment the likelihood index
    for (int i=1;i<=n_srv_obs(isrv);i++)
    {
      if(survey_unit(isrv) == 1)
        like_val(ilike) += 0.5*square(log((survey_biom_obs(isrv,i)+incd)/(survey_biom_pred(isrv,i)+incd))) /(survey_var(isrv,i));
      else 
        like_val(ilike) += 0.5*square(log((survey_num_obs(isrv,i)+incd)/(survey_num_pred(isrv,i)+incd))) /(survey_var(isrv,i));
      }  
  }
     
  // Survey LF
  for (isrv=1;isrv<=nsurvey;isrv++)
  {
   ilike++; 
   for (i=1;i<=nlfsurvey(isrv);i++)
   {
      dvar_vector phat = survey_lf_pred(ifl,i)/sum(survey_lf_pred(ifl,i));
      dvector pobs     = survey_lf_obs(ifl,i)/sum(survey_lf_obs(ifl,i)); // this should probably be done once in beginning
      like_val(ilike)  += -ss_survey_lf(ifl,i)*pobs*log(phat);
      /*
      for (Iclass=1;Iclass<=Nclass;Iclass++)
      if (SurveyObsLF(isrv,Icnt,Iclass) > 0) // Jim says this seems to imply that a zero means no data...UNTRUE
       {
        Error = (PredSurvey(isrv,styr,Iclass)+Incc)/(SurveyObsLF(isrv,Icnt,Iclass)+Incc);
        like_val(ilike) += -1*SSSurveyLF(isrv,Icnt)*SurveyObsLF(isrv,Icnt,Iclass)*log(Error);
       }
      */
    } 
  } 
                                                    
  //================================================================================
FUNCTION Get_Priors
  int iprior=0;
  // Prior on F-devs 
  for (int ifl=1;ifl<=nfleet;ifl++)
  {
    iprior++;
    mean_F = 0; nn = 0;
    for (styr=Yr1;styr<=endyr;styr++) 
      if (Effort(Ifleet,styr) > 0) { MeanF += FAll(Ifleet,styr); nn+= 1; }
    mean_F /= nn;
    for (styr=Yr1;styr<=endyr;styr++) 
      if (Effort(Ifleet,styr) > 0) prior_val(iprior) += square(FAll(Ifleet,styr)-MeanF);
  } 
  iprior++;
  // Prior on Rec Devs
  for (i=styr;i<=endyr;i++) prior_val(iprior) += square(RecDev(i));
  iprior++;
    
  // penalties on parameters
  prior_val(iprior) = sum(square(TransPars));
  iprior++;
  for (Ifleet=1;Ifleet<=NSelex;Ifleet++)
    if (SelexPhase(Ifleet) > 0)
      prior_val(iprior) += square(SelexPar(Ifleet));

  iprior++;
  prior_val(iprior) = sum(square(RetainPar));
  iprior++;
  
  // q - prior
  for (isrv=1;isrv<=NSurveyQ;isrv++)
    if (SurveyQPSD(isrv) > 0)
      prior_val(iprior) = square(exp(LogSurveyQ(isrv))-SurveyQPMean(isrv))/(2.0*square(SurveyQPSD(isrv)));
  iprior++;
  
  // M-prior
  prior_val(iprior) = square(M0-MPriorMean)/(2.0*square(MPriorSD));
  iprior++;
  // 2nd derivative penalty
  Penal = 0;
  for (Iselex=1;Iselex<=NSelexPat;Iselex++)
   if (SelexType(Iselex,1) == 2)
    for (Iclass=2;Iclass<=Nclass-1;Iclass++)
     Penal += square(SelexAll(Iselex,Iclass-1)-2.0*SelexAll(Iselex,Iclass)+SelexAll(Iselex,Iclass+1));
  prior_val(iprior) = Penal;   
  
FUNCTION Get_Catch_Pred;
  dvar_vector S1(1,nclass);                              
  dvar_vector N_tmp(1,nclass);                              // Numbers at fishery
  
  fleet_lf_pred.initialize();
  catch_biom_pred.initialize();
  catch_num_pred.initialize();
  N_tmp.initialize();
  
  for (int styr=styr;styr<=endyr;styr++)
  {
    // Need to loop over number of directred fisheries (presently fixed at 1) fleet control matrix
    N_tmp = N(styr)*mfexp(-catch_time(1,styr)*M(styr));
    for (int ifl=1;ifl<=nfleet_act;ifl++)
    {
      S1 = S_fleet(ifl,styr);
      if (fleet_control(2)==1) // Main retained fishery
        fleet_lf_pred(ifl,styr) = elem_prod(N_tmp , elem_prod((1.-S1),reten(styr)));
      if (fleet_control(2)==2) // Discard fishery
        fleet_lf_pred(ifl,styr) = elem_prod(N_tmp , elem_prod((1.-S1),(1.-reten(styr))));
      if (fleet_control(2)==3) // Main retained fishery
        fleet_lf_pred(ifl,styr) = elem_prod(N_tmp , (1.-S1));
      N_tmp = elem_prod(N_tmp,S1);
    }
     // Accumulate totals 
     catch_biom_pred(styr) = fleet_lf_pred(ifl,styr) * weight;
     catch_num_pred(styr) = sum(fleet_lf_pred(ifl,styr) );
  } 

     /*
   for (Iclass=1;Iclass<=Nclass;Iclass++)
    {
     SurvNo = N(styr,Iclass)*mfexp(-tc(0,styr)*M(styr));
     S1 = SF(0,styr,Iclass);
     CatFleet(0,styr,Iclass) = SurvNo*(1-S1)*RetCatMale(styr,Iclass);
     CatFleet(-1,styr,Iclass) = SurvNo*(1-S1)*(1-RetCatMale(styr,Iclass));
     SurvNo *= S1;
     for (Ifleet=1;Ifleet<=Nfleet;Ifleet++)
      {
       S2 = SF(Ifleet,styr,Iclass);
       CatFleet(Ifleet,styr,Iclass) = SurvNo*(1-S2);
       SurvNo *= S2;
      }
      
     // Accumulate totals 
     for (Ifleet=-1; Ifleet<=Nfleet;Ifleet++)
      {
       CatFleetWghtPred(Ifleet,styr) += CatFleet(Ifleet,styr,Iclass) * Wght(Iclass);
       CatFleetNumPred(Ifleet,styr) += CatFleet(Ifleet,styr,Iclass);
      } 
      
    }
   
  // Special case for fleet -1
  if (DiscardsOrTotal == 1)
   for (styr=Yr1;styr<=endyr;styr++)
    for (Iclass=1;Iclass<=Nclass;Iclass++)
     CatFleet(-1,styr,Iclass) = CatFleet(-1,styr,Iclass) + CatFleet(0,styr,Iclass);
     */
FUNCTION Get_Survey
  survey_lf_pred.initialize();
  survey_biom_pred.initialize();
  survey_num_pred.initialize();
  for (isrv=1;isrv<=nsurvey;isrv++)
  {
    for (int i=1;i<=nlfsurvey(isrv);i++)
    {
      int styr                  = yr_surv(isrv,i);
      survey_lf_pred(isrv,i)   = N(styr)*selex_survey(isrv,styr); // note use if styr here...t
      survey_biom_pred(isrv,i) = survey_lf_pred(isrv,i) * weight;
      survey_num_pred(isrv,i)  = sum(survey_lf_pred(isrv,i));
      survey_lf_pred(isrv,i)  /= survey_lf_pred(isrv,i);
    }
  }
  /*
    
  PredSurveyNum.initialize();
  PredSurveyWght.initialize();
  for (Isurv=1;Isurv<=Nsurvey;Isurv++)
   for (styr=Yr1;styr<=endyr+1;styr++)
    for (Iclass=1;Iclass<=Nclass;Iclass++)
     {
      PredSurveyWght(Isurv,styr) += PredSurvey(Isurv,styr,Iclass)*Wght(Iclass);
      PredSurveyNum(Isurv,styr) += PredSurvey(Isurv,styr,Iclass);
     }
  */
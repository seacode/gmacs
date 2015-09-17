// ================================================================================================================
FUNCTION Solve_HR
 // Apply the Hybrid method to solve for F by fleet
 int f,Isex,Iage,Isize,tune_F;
 dvariable vbio,temp,temp1,join1,Z_adjuster2,Z_adjuster,BioAtLength,sum1,Surv;

 // Get initial Hrate estimate
 for (f=1;f<=NfishFleet;f++)
  if (Catch(f,Year) > 0)
  {
    vbio = 0;
    for (Isex=1;Isex<=Nsex;Isex++)
     for (Iage=0;Iage<=Nage;Iage++)
       vbio += sum(elem_prod(N(Year,Isex,Iage),selretwghtUse(f,Isex,Iage)));     
    temp          = Catch(f,Year)/(vbio + Catch(f,Year));    
    join1         = 1.0/(1.0+mfexp(30.*(temp-0.95)));
    temp1         = join1*temp + (1.0-join1)*0.95;
    Hrate(f,Year) = -log(1.-temp1);
  }
  else
    if (Catch(f,Year) == 0) Hrate(f,Year) = 0;
 
 // Tune 
  for (tune_F=1;tune_F<=F_tune;tune_F++)
  {
   // Compute Z given F and M
    for (Isex=1;Isex<=Nsex;Isex++)
      for (Iage=0;Iage<=Nage;Iage++)
        for (Isize=1;Isize<=NsizeDym;Isize++)
        {
          Z_rate(Isex,Iage,Isize) = NatM(Isex,Year);
          for (f=1;f<=NfishFleet;f++)
            Z_rate(Isex,Iage,Isize) += selexS(f,Isex,Iage,Isize) * Hrate(f,Year);
          Z_rate2(Isex,Iage,Isize) = (1-mfexp(-Z_rate(Isex,Iage,Isize)))/Z_rate(Isex,Iage,Isize);  
        }
      
   // Now tune
    if (tune_F < F_tune)
    {
      Z_adjuster2 = 0;
      for (f=1;f<=NfishFleet;f++)
        if (Catch(f,Year) > 0)
        {
          for (Isex=1;Isex<=Nsex;Isex++)
            for (Iage=0;Iage<=Nage;Iage++)
              for (Isize=1;Isize<=NsizeDym;Isize++)
                Z_adjuster2 += Hrate(f,Year)*N(Year,Isex,Iage,Isize)*selretwghtUse(f,Isex,Iage,Isize)*Z_rate2(Isex,Iage,Isize);
        }
        Z_adjuster = TotalCatch(Year)/(Z_adjuster2+0.0001);
     
     // Adjust total Z
       for (Isex=1;Isex<=Nsex;Isex++)
         for (Iage=0;Iage<=Nage;Iage++)
           for (Isize=1;Isize<=NsizeDym;Isize++)
           {
              Z_rate(Isex,Iage,Isize)  = NatM(Isex,Year) + Z_adjuster*(Z_rate(Isex,Iage,Isize)-NatM(Isex,Year));
              Z_rate2(Isex,Iage,Isize) = (1-mfexp(-Z_rate(Isex,Iage,Isize)))/Z_rate(Isex,Iage,Isize);  
            }
     
     // Adjust total exploitable biomass
    for (f=1;f<=NfishFleet;f++)
      if (Catch(f,Year) > 0)
      {
        Z_adjuster2 = 0;
        for (Isex=1;Isex<=Nsex;Isex++)
          for (Iage=0;Iage<=Nage;Iage++)
            for (Isize=1;Isize<=NsizeDym;Isize++)
              Z_adjuster2  += N(Year,Isex,Iage,Isize)*selretwghtUse(f,Isex,Iage,Isize)*Z_rate2(Isex,Iage,Isize);
        temp          = Catch(f,Year)/(Z_adjuster2 + 0.00001);    
        join1         = 1.0/(1.0+mfexp(30.*(temp-0.95*max_harvest_rate)));
        Hrate(f,Year) = join1*temp + (1.0-join1)*max_harvest_rate;
      }
    }
    else
    {
      for (f=1;f<=NfishFleet;f++)
      {
        for (Isex=1;Isex<=Nsex;Isex++)
          for (Iage=0;Iage<=Nage;Iage++)
            for (Isize=1;Isize<=NsizeDym;Isize++)
            {
              // Note selretwght will not be biomass when Catch_Specs=1
              BioAtLength         = N(Year,Isex,Iage,Isize)*Z_rate2(Isex,Iage,Isize);
              CatchPred(f,Year)  += Hrate(f,Year)*BioAtLength*selretwghtUse(f,Isex,Iage,Isize);
              CatchPredN(f,Year) += Hrate(f,Year)*BioAtLength*selretwght1(f,Isex,Iage,Isize);
              CatchPredB(f,Year) += Hrate(f,Year)*BioAtLength*selretwght2(f,Isex,Iage,Isize);
              MidExpNum(f,Year)  += BioAtLength*selretwght1(f,Isex,Iage,Isize);;
              MidExpBio(f,Year)  += BioAtLength*selretwght2(f,Isex,Iage,Isize);;
            } 
      }   
    }
  } // Tune
  
  //Other fleets
  for (f=NfishFleet+1;f<=Nfleet;f++)
  {
    for (Isex=1;Isex<=Nsex;Isex++)
     for (Iage=0;Iage<=Nage;Iage++)
       if (Model_Type == AGEMODEL)
       {
         Surv = mfexp(-SurveyTime(f)*Z_rate(Isex,Iage,1));
         sum1 = 0;
         for (Isize=1;Isize<=NsizeAge;Isize++)
          sum1 += PhiGrow(Isex,Iage,Isize)*selexL(f,Isex,Isize);
         MidExpNum(f,Year) += N(Year,Isex,Iage,1)*selexA(f,Isex,Iage)*sum1*Surv;
         sum1 = 0;
         for (Isize=1;Isize<=NsizeAge;Isize++)
           sum1 += PhiGrow(Isex,Iage,Isize)*selexL(f,Isex,Isize)*wghtL(Isex,Isize);
         MidExpBio(f,Year) += N(Year,Isex,Iage,1)*selexA(f,Isex,Iage)*sum1*Surv;
       }
       else
       {
         Surv = mfexp(-SurveyTime(f)*Z_rate(Isex,Iage,Isex));
         for (Isize=1;Isize<=NsizeDym;Isize++)
           MidExpNum(f,Year) += N(Year,Isex,Iage,Isize)*selexL(f,Isex,Isize)*selexA(f,Isex,Iage)*Surv;
         for (Isize=1;Isize<=NsizeDym;Isize++)
           MidExpBio(f,Year) += N(Year,Isex,Iage,Isize)*selexL(f,Isex,Isize)*selexA(f,Isex,Iage)*Surv*wghtL(Isex,Isize);
        }
    }   
  
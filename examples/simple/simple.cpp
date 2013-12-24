  #include <admodel.h>
  ofstream CheckFile;
    
#include <admodel.h>

  extern "C"  {
    void ad_boundf(int i);
  }
#include <simple.htp>

model_data::model_data(int argc,char * argv[]) : ad_comm(argc,argv)
{
 ad_comm::change_datafile_name("Simple.Dat");
  Nfleet.allocate("Nfleet");
  Nsurvey.allocate("Nsurvey");
  Yr1.allocate("Yr1");
  Yr2.allocate("Yr2");
  BMSY_Y1.allocate("BMSY_Y1");
  BMSY_Y2.allocate("BMSY_Y2");
  Nclass.allocate("Nclass");
  NallClass.allocate("NallClass");
  ClassLink.allocate(1,Nclass,1,2,"ClassLink");
  gamma.allocate("gamma");
  Length_inp.allocate(1,NallClass,"Length_inp");
  Length.allocate(1,Nclass);
  Wght_inp.allocate(1,NallClass,"Wght_inp");
  Wght.allocate(1,Nclass);
  fecu_inp.allocate(1,NallClass,"fecu_inp");
  fecu.allocate(1,Nclass);
  fleet_mort.allocate(-1,Nfleet,"fleet_mort");
  hg.allocate(Yr1,Yr2,"hg");
  Mpnt.allocate(Yr1,Yr2,"Mpnt");
 MMvals = 0;
 for (DIyr=Yr1;DIyr<=Yr2;DIyr++) if (Mpnt(DIyr) > MMvals) MMvals = Mpnt(DIyr);
  CatchUnit.allocate(-1,Nfleet,"CatchUnit");
  MultCatFleet.allocate(-1,Nfleet,"MultCatFleet");
  SurveyUnit.allocate(1,Nsurvey,"SurveyUnit");
  MultCatSurvey.allocate(1,Nsurvey,"MultCatSurvey");
  DiscardsOrTotal.allocate("DiscardsOrTotal");
  CatchAndDiscard.allocate(-1,Nfleet,Yr1,Yr2,"CatchAndDiscard");
 CheckFile << CatchAndDiscard << endl;
 for (DIfleet=-1; DIfleet<=Nfleet; DIfleet++)
  for (DIyr=Yr1;DIyr<=Yr2;DIyr++)
   CatchAndDiscard(DIfleet,DIyr) *= fleet_mort(DIfleet) * MultCatFleet(DIfleet);
  SurveyEst.allocate(1,Nsurvey,Yr1,Yr2+1,1,2,"SurveyEst");
 for (DIfleet=1;DIfleet<=Nsurvey;DIfleet++)
  for (DIyr=Yr1;DIyr<=Yr2+1;DIyr++)
   {
    SurveyEst(DIfleet,DIyr,1) *= MultCatSurvey(DIfleet);
    SurveyEst(DIfleet,DIyr,2) = sqrt(log(square(SurveyEst(DIfleet,DIyr,2))+1.0));
   }
 CheckFile << "SurveyEst" << endl << SurveyEst << endl;
  tc.allocate(0,Nfleet,Yr1,Yr2,"tc");
  Effort.allocate(0,Nfleet,Yr1,Yr2,"Effort");
  FOverWrite.allocate(0,Nfleet,0,4,"FOverWrite");
  NcatchF.allocate(0,Nfleet);
 for (DIfleet=0;DIfleet<=Nfleet;DIfleet++)
  {
   NcatchF(DIfleet) = 0;
   for (DIyr=Yr1;DIyr<=Yr2;DIyr++) 
    if (Effort(DIfleet,DIyr) > 0) 
     {
      if (FOverWrite(DIfleet,0) == 0 |DIyr<FOverWrite(DIfleet,1) | DIyr>FOverWrite(DIfleet,2))
       NcatchF(DIfleet) += 1;
     }
  }
 CheckFile << endl << "Effort" << endl;
 CheckFile << Effort << endl;
 CheckFile << endl << "Number of Fs" << endl << NcatchF << endl;
  NLFfleet.allocate(-1,Nfleet,"NLFfleet");
 maxFleetLF = max(NLFfleet);                    // How many fleets
  YrFleetLF.allocate(-1,Nfleet,1,maxFleetLF);
  SSFleetLF.allocate(-1,Nfleet,1,maxFleetLF);
  FleetLF.allocate(-1,Nfleet,1,maxFleetLF,1,NallClass);
 CheckFile << NLFfleet << endl;
for (DIfleet=-1;DIfleet<=Nfleet;DIfleet++)
 {
  for (DIyr=1;DIyr<=NLFfleet(DIfleet);DIyr++)  *(ad_comm::global_datafile) >>  YrFleetLF(DIfleet,DIyr);
  for (DIyr=1;DIyr<=NLFfleet(DIfleet);DIyr++)  *(ad_comm::global_datafile) >>  SSFleetLF(DIfleet,DIyr);
  for (DIyr=1;DIyr<=NLFfleet(DIfleet);DIyr++)  *(ad_comm::global_datafile) >>  FleetLF(DIfleet,DIyr);
 }
 CheckFile << "YrFleetLF" << endl;
 CheckFile << YrFleetLF << endl;
  NLFsurvey.allocate(1,Nsurvey,"NLFsurvey");
 maxSurveyLF = max(NLFsurvey);                  // How many surveys
  YrSurveyLF.allocate(1,Nsurvey,1,maxSurveyLF);
  SSSurveyLF.allocate(1,Nsurvey,1,maxSurveyLF);
  SurveyLF.allocate(1,Nsurvey,1,maxSurveyLF,1,NallClass);
for (DIfleet=1;DIfleet<=Nsurvey;DIfleet++)
 {
  for (DIyr=1;DIyr<=NLFsurvey(DIfleet);DIyr++)  *(ad_comm::global_datafile) >>  YrSurveyLF(DIfleet,DIyr);
  for (DIyr=1;DIyr<=NLFsurvey(DIfleet);DIyr++)  *(ad_comm::global_datafile) >>  SSSurveyLF(DIfleet,DIyr);
  for (DIyr=1;DIyr<=NLFsurvey(DIfleet);DIyr++)  *(ad_comm::global_datafile) >>  SurveyLF(DIfleet,DIyr);
 }
 CheckFile << "YrSurveyLF" << endl;
 CheckFile << YrSurveyLF << endl;
  FleetSelexPnt.allocate(0,Nfleet,Yr1,Yr2,"FleetSelexPnt");
 CheckFile << "FleetSelexPnt " << endl << FleetSelexPnt << endl;
 NSelex = 0;
 for (DIfleet=0;DIfleet<=Nfleet;DIfleet++)
  for (DIyr=Yr1;DIyr<=Yr2;DIyr++)
   if (FleetSelexPnt(DIfleet,DIyr) > NSelex) NSelex = FleetSelexPnt(DIfleet,DIyr);
  SurveySelexPnt.allocate(1,Nsurvey,Yr1,Yr2+1,"SurveySelexPnt");
 CheckFile << "SurveySelexPnt " << endl << SurveySelexPnt << endl;
 for (DIfleet=1;DIfleet<=Nsurvey;DIfleet++)
  for (DIyr=Yr1;DIyr<=Yr2+1;DIyr++)
   if (SurveySelexPnt(DIfleet,DIyr) > NSelex) NSelex = SurveySelexPnt(DIfleet,DIyr);
  NSelexPat = NSelex;
 CheckFile << NSelexPat << " Total selectivity patterns" << endl;
  SelexType.allocate(1,NSelexPat,0,3);
 NSelex = 0;
 for (II=1;II<=NSelexPat;II++)
  {
   *(ad_comm::global_datafile) >> SelexType(II,0) >> SelexType(II,1) >> SelexType(II,2);
   if (SelexType(II,1) == 1) NSelex += 2;
   if (SelexType(II,1) == 2) NSelex += Nclass;
   if (SelexType(II,1) == 3) NSelex += 1;
  }
 CheckFile << NSelex << " Total selectivity parameters" << endl;
  SelexInit.allocate(1,NSelex);
  SelexLow.allocate(1,NSelex);
  SelexHi.allocate(1,NSelex);
  SelexPhase.allocate(1,NSelex);
  SelexSpex.allocate(1,NSelex,1,4);
  SelexInpType.allocate("SelexInpType");
if (SelexInpType == 1)
 {
  *(ad_comm::global_datafile) >> SelexSpex;    
  cout << SelexSpex << endl;
  SelexInit = column(SelexSpex,1);
  SelexLow = column(SelexSpex,2);
  SelexHi = column(SelexSpex,3);
  for (II=1;II<=NSelex;II++) SelexPhase(II) = int(SelexSpex(II,4));
 }
 if (SelexInpType == 0)
  {
   for (II=1;II<=Nclass+2;II++) 
   *(ad_comm::global_datafile) >> SelexSpex(II,1) >> SelexSpex(II,2) >> SelexSpex(II,3) >> SelexSpex(II,4);
   DIpnt = 0;
   for (II=1;II<=NSelexPat;II++)
    {
     if (SelexType(II,1) == 1)
      for (JJ=1;JJ<=2;JJ++)
       { 
        SelexInit(DIpnt+1) = SelexSpex(JJ,1);
        SelexLow(DIpnt+1) = SelexSpex(JJ,2);
        SelexHi(DIpnt+1) = SelexSpex(JJ,3);
        SelexPhase(DIpnt+1) = int(SelexSpex(JJ,4));
        DIpnt += 1;
       }
     if (SelexType(II,1) == 2)
      for (JJ=1;JJ<=Nclass;JJ++)
       { 
        SelexInit(DIpnt+1) = SelexSpex(2+JJ,1);
        SelexLow(DIpnt+1) = SelexSpex(2+JJ,2);
        SelexHi(DIpnt+1) = SelexSpex(2+JJ,3);
        SelexPhase(DIpnt+1) = int(SelexSpex(2+JJ,4));
        DIpnt += 1;
       }
     if (SelexType(II,1) == 3)
      for (JJ=1;JJ<=1;JJ++)
       { 
        SelexInit(DIpnt+1) = SelexSpex(JJ,1);
        SelexLow(DIpnt+1) = SelexSpex(JJ,2);
        SelexHi(DIpnt+1) = SelexSpex(JJ,3);
        SelexPhase(DIpnt+1) = int(SelexSpex(JJ,4));
        DIpnt += 1;
       }
    }
  }
  FleetRetPnt.allocate(Yr1,Yr2,"FleetRetPnt");
 cout << FleetRetPnt << endl;
 NRetPars = 0;
 for (DIyr=Yr1;DIyr<=Yr2;DIyr++)
  if (FleetRetPnt(DIyr) > NRetPars) NRetPars = FleetRetPnt(DIyr);
 NRetPars *= Nclass;
 CheckFile << NRetPars << " Total retension parameters" << endl;
  RetainParSpex.allocate(1,NRetPars,1,4,"RetainParSpex");
  RetainParInit.allocate(1,NRetPars);
  RetainParLow.allocate(1,NRetPars);
  RetainParHi.allocate(1,NRetPars);
  RetainParPhase.allocate(1,NRetPars);
 RetainParInit = column(RetainParSpex,1);
 RetainParLow = column(RetainParSpex,2);
 RetainParHi = column(RetainParSpex,3);
 for (II=1;II<=NRetPars;II++) RetainParPhase(II) = int(RetainParSpex(II,4));
 CheckFile << "Retained par Specs" << endl;
  SurveyQPnt.allocate(1,Nsurvey,Yr1,Yr2+1,"SurveyQPnt");
 CheckFile << "SurveyQPnt" << endl << SurveyQPnt << endl;
 NSurveyQ = 0;
 for (DIfleet=1;DIfleet<=Nsurvey;DIfleet++)
  for (DIyr=Yr1;DIyr<=Yr2+1;DIyr++)
   if (SurveyQPnt(DIfleet,DIyr) > NSurveyQ) NSurveyQ = SurveyQPnt(DIfleet,DIyr);
 CheckFile << "NSurveyQ" << endl << NSurveyQ << endl;
  NsubSurveyFleets.allocate("NsubSurveyFleets");
  SubFltSpec.allocate(1,NsubSurveyFleets,1,2,"SubFltSpec");
  SurveyQSpex.allocate(1,NSurveyQ,1,6,"SurveyQSpex");
  SurveyQInit.allocate(1,NSurveyQ);
  SurveyQLow.allocate(1,NSurveyQ);
  SurveyQHi.allocate(1,NSurveyQ);
  SurveyQPMean.allocate(1,NSurveyQ);
  SurveyQPSD.allocate(1,NSurveyQ);
  SurveyQPhase.allocate(1,NSurveyQ);
 SurveyQInit = column(SurveyQSpex,1);
 SurveyQLow = column(SurveyQSpex,2);
 SurveyQHi = column(SurveyQSpex,3);
 SurveyQPMean = column(SurveyQSpex,5);
 SurveyQPSD = column(SurveyQSpex,6);
 for (II=1;II<=NSurveyQ;II++) SurveyQPhase(II) = int(SurveyQSpex(II,4));
 CheckFile << "SurveyQSpex" << endl << SurveyQSpex << endl;
  R0init.allocate("R0init");
  R0low.allocate("R0low");
  R0hi.allocate("R0hi");
  R0Phase.allocate("R0Phase");
  Minit.allocate("Minit");
  Mlow.allocate("Mlow");
  Mhi.allocate("Mhi");
  MPhase.allocate("MPhase");
  MPriorMean.allocate("MPriorMean");
  MPriorSD.allocate("MPriorSD");
 CheckFile << "MPars" << endl << Minit << " " << Mlow << " " << Mhi << " " << MPhase << endl;
  MaddSpex.allocate(1,MMvals,1,4,"MaddSpex");
  Maddinit.allocate(1,MMvals);
  Maddlow.allocate(1,MMvals);
  Maddhi.allocate(1,MMvals);
  MaddPhase.allocate(1,MMvals);
 Maddinit = column(MaddSpex,1);
 Maddlow = column(MaddSpex,2);  
 Maddhi = column(MaddSpex,3);
 for (II=1;II<=MMvals;II++) MaddPhase(II) = int(MaddSpex(II,4));
  logNinitialSpex.allocate(1,Nclass,1,4,"logNinitialSpex");
  logNinitialInit.allocate(1,Nclass);
  logNinitialLow.allocate(1,Nclass);
  logNinitialHi.allocate(1,Nclass);
  logNinitialPhase.allocate(1,Nclass);
 logNinitialInit = column(logNinitialSpex,1);
 logNinitialLow = column(logNinitialSpex,2);
 logNinitialHi = column(logNinitialSpex,3);
 for (II=1;II<=Nclass;II++) logNinitialPhase(II) = int(logNinitialSpex(II,4));
  TransParsSpex.allocate(1,Nclass-1,1,4,"TransParsSpex");
  TransParsInit.allocate(1,Nclass-1);
  TransParsLow.allocate(1,Nclass-1);
  TransParsHi.allocate(1,Nclass-1);
  TransParsPhase.allocate(1,Nclass-1);
 TransParsInit = column(TransParsSpex,1);
 TransParsLow = column(TransParsSpex,2);
 TransParsHi = column(TransParsSpex,3);
 for (II=1;II<=Nclass-1;II++) TransParsPhase(II) = int(TransParsSpex(II,4));
 CheckFile << "TransParsSpex" << endl << TransParsSpex << endl;
 NPriorTerms = (Nfleet+1) + 5 + NSurveyQ + 1 + 1;
 NLikeTerms = (Nfleet+2)*2 + (Nfleet+1) + (Nsurvey)*2;
 CheckFile << "Number of terms: " << NPriorTerms << " " << NLikeTerms << endl;
  PriorWeight.allocate(1,NPriorTerms,"PriorWeight");
  DataWeight.allocate(1,NLikeTerms,"DataWeight");
 CheckFile << PriorWeight << endl;
 CheckFile << DataWeight << endl;
  Lag.allocate("Lag");
  SR_RelAct.allocate("SR_RelAct");
  IgnorePINFile.allocate("IgnorePINFile");
  Diag.allocate("Diag");
  Test.allocate("Test");
cout << "TEST " << Test << endl;
 if (Test != 98989) { cout << "Error in data file" << endl; exit(1); }
  FleetObsLF.allocate(-1,Nfleet,1,maxFleetLF,1,Nclass);
  SurveyObsLF.allocate(1,Nsurvey,1,maxSurveyLF,1,Nclass);
}

model_parameters::model_parameters(int sz,int argc,char * argv[]) : 
 model_data(argc,argv) , function_minimizer(sz)
{
  initializationfunction();
  logRbar.allocate(R0low,R0hi,R0Phase,"logRbar");
  M0.allocate(Mlow,Mhi,MPhase,"M0");
  Mm.allocate(1,MMvals,Maddlow,Maddhi,MaddPhase,"Mm");
  TransPars.allocate(1,Nclass-1,TransParsLow,TransParsHi,TransParsPhase,"TransPars");
  SelexPar.allocate(1,NSelex,SelexLow,SelexHi,SelexPhase,"SelexPar");
  RetainPar.allocate(1,NRetPars,RetainParLow,RetainParHi,RetainParPhase,"RetainPar");
  LogSurveyQ.allocate(1,NSurveyQ,SurveyQLow,SurveyQHi,SurveyQPhase,"LogSurveyQ");
  logNinitial.allocate(1,Nclass,logNinitialLow,logNinitialHi,logNinitialPhase,"logNinitial");
  FEst.allocate(0,Nfleet,1,NcatchF,0,1,1,"FEst");
  RecDev.allocate(Yr1,Yr2,1,"RecDev");
 CheckFile << "All parameters declared" << endl;
  FAll.allocate(0,Nfleet,Yr1,Yr2,"FAll");
  #ifndef NO_AD_INITIALIZE
    FAll.initialize();
  #endif
  PriorVal.allocate(1,NPriorTerms,"PriorVal");
  #ifndef NO_AD_INITIALIZE
    PriorVal.initialize();
  #endif
  LikeVal.allocate(1,NLikeTerms,"LikeVal");
  #ifndef NO_AD_INITIALIZE
    LikeVal.initialize();
  #endif
  fout.allocate("fout");
  N.allocate(Yr1,Yr2+1,1,Nclass,"N");
  #ifndef NO_AD_INITIALIZE
    N.initialize();
  #endif
  S.allocate(Yr1,Yr2,1,Nclass,"S");
  #ifndef NO_AD_INITIALIZE
    S.initialize();
  #endif
  SF.allocate(0,Nfleet,Yr1,Yr2,1,Nclass,"SF");
  #ifndef NO_AD_INITIALIZE
    SF.initialize();
  #endif
  ExplRates.allocate(0,Nfleet,Yr1,Yr2,"ExplRates");
  #ifndef NO_AD_INITIALIZE
    ExplRates.initialize();
  #endif
  Trans.allocate(1,Nclass,1,Nclass,"Trans");
  #ifndef NO_AD_INITIALIZE
    Trans.initialize();
  #endif
  RetCatMale.allocate(Yr1,Yr2,1,Nclass,"RetCatMale");
  #ifndef NO_AD_INITIALIZE
    RetCatMale.initialize();
  #endif
  FleetSelex.allocate(0,Nfleet,Yr1,Yr2,1,Nclass,"FleetSelex");
  #ifndef NO_AD_INITIALIZE
    FleetSelex.initialize();
  #endif
  SelexSurvey.allocate(1,Nsurvey,Yr1,Yr2+1,1,Nclass,"SelexSurvey");
  #ifndef NO_AD_INITIALIZE
    SelexSurvey.initialize();
  #endif
  SurveyQ.allocate(1,Nsurvey,"SurveyQ");
  #ifndef NO_AD_INITIALIZE
    SurveyQ.initialize();
  #endif
  SelexAll.allocate(1,NSelexPat,1,Nclass,"SelexAll");
  #ifndef NO_AD_INITIALIZE
    SelexAll.initialize();
  #endif
  CatFleet.allocate(-1,Nfleet,Yr1,Yr2,1,Nclass,"CatFleet");
  #ifndef NO_AD_INITIALIZE
    CatFleet.initialize();
  #endif
  CatFleetWghtPred.allocate(-1,Nfleet,Yr1,Yr2,"CatFleetWghtPred");
  #ifndef NO_AD_INITIALIZE
    CatFleetWghtPred.initialize();
  #endif
  CatFleetNumPred.allocate(-1,Nfleet,Yr1,Yr2,"CatFleetNumPred");
  #ifndef NO_AD_INITIALIZE
    CatFleetNumPred.initialize();
  #endif
  PredSurvey.allocate(1,Nsurvey,Yr1,Yr2+1,1,Nclass,"PredSurvey");
  #ifndef NO_AD_INITIALIZE
    PredSurvey.initialize();
  #endif
  PredSurveyWght.allocate(1,Nsurvey,Yr1,Yr2+1,"PredSurveyWght");
  #ifndef NO_AD_INITIALIZE
    PredSurveyWght.initialize();
  #endif
  PredSurveyNum.allocate(1,Nsurvey,Yr1,Yr2+1,"PredSurveyNum");
  #ifndef NO_AD_INITIALIZE
    PredSurveyNum.initialize();
  #endif
  qEff.allocate(0,Nfleet,"qEff");
  #ifndef NO_AD_INITIALIZE
    qEff.initialize();
  #endif
  M.allocate(Yr1,Yr2,"M");
  #ifndef NO_AD_INITIALIZE
    M.initialize();
  #endif
  Fdirect.allocate(Yr1,Yr2,"Fdirect");
  #ifndef NO_AD_INITIALIZE
    Fdirect.initialize();
  #endif
  Fmult.allocate("Fmult");
  #ifndef NO_AD_INITIALIZE
  Fmult.initialize();
  #endif
  MMBOut.allocate("MMBOut");
  #ifndef NO_AD_INITIALIZE
  MMBOut.initialize();
  #endif
  F35.allocate("F35");
  #ifndef NO_AD_INITIALIZE
  F35.initialize();
  #endif
  SBPR35.allocate("SBPR35");
  #ifndef NO_AD_INITIALIZE
  SBPR35.initialize();
  #endif
  RecOut.allocate("RecOut");
  #ifndef NO_AD_INITIALIZE
  RecOut.initialize();
  #endif
  CatchOut.allocate("CatchOut");
  #ifndef NO_AD_INITIALIZE
  CatchOut.initialize();
  #endif
  mbio.allocate(1,1000,"mbio");
  #ifndef NO_AD_INITIALIZE
    mbio.initialize();
  #endif
  MortF.allocate(1,Nfleet,"MortF");
  #ifndef NO_AD_INITIALIZE
    MortF.initialize();
  #endif
  R0.allocate("R0");
  #ifndef NO_AD_INITIALIZE
  R0.initialize();
  #endif
  Steep.allocate("Steep");
  #ifndef NO_AD_INITIALIZE
  Steep.initialize();
  #endif
  MMB0.allocate("MMB0");
  #ifndef NO_AD_INITIALIZE
  MMB0.initialize();
  #endif
  MMB.allocate(Yr1,Yr2,"MMB");
  #ifndef NO_AD_INITIALIZE
    MMB.initialize();
  #endif
  LogMMB.allocate(Yr1,Yr2,"LogMMB");
  Recruits.allocate(Yr1,Yr2,"Recruits");
  #ifndef NO_AD_INITIALIZE
    Recruits.initialize();
  #endif
  LogRecruits.allocate(Yr1,Yr2,"LogRecruits");
  LogRMMB.allocate(Yr1,Yr2-Lag,"LogRMMB");
}

void model_parameters::preliminary_calculations(void)
{

  admaster_slave_variable_interface(*this);
  int Iyr,Iclass,Jclass,Ifleet,Isurv,JJ,Ipnt,Jpnt,Last,SelType;
  float Total,NumSS,Scalar;
  dvector TotalSS(-1,Nfleet);
  dmatrix SSFStore(-1,Nfleet,1,maxFleetLF);
  dmatrix SSSStore(1,Nsurvey,1,maxSurveyLF);
  dvector SurvLFStore(1,NallClass);
  cout << "Started Preliminary Calcs Section" << endl;
  cout << Diag << endl;
  if (IgnorePINFile==1) 
   {
    logRbar = R0init;
    M0 = Minit;
    for (JJ=1;JJ<=MMvals;JJ++) Mm(JJ) = Maddinit(JJ);  
    for (JJ=1;JJ<=Nclass-1;JJ++) TransPars(JJ) = TransParsInit(JJ);
    for (JJ=1;JJ<=NSelex;JJ++) SelexPar(JJ) = SelexInit(JJ);
    for (JJ=1;JJ<=NRetPars;JJ++) RetainPar(JJ) = RetainParInit(JJ);
    for (JJ=1;JJ<=NSurveyQ;JJ++) LogSurveyQ(JJ) = SurveyQInit(JJ);
    for (JJ=1;JJ<=Nclass;JJ++) logNinitial(JJ) = logNinitialInit(JJ);
    for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
     for (Iyr=1;Iyr<=NcatchF(Ifleet);Iyr++) FEst(Ifleet,Iyr) = 0.1;
    for (Iyr=Yr1;Iyr<=Yr2;Iyr++) RecDev(Iyr) = 0; 
   }
  if (Diag == 1) cout << "PIN File specified" << endl; 
  Total = 0;
  for (Iclass=1;Iclass<=NallClass;Iclass++)
   {
    SurvLFStore(Iclass) = 0;
    for (Iyr=1;Iyr<=NLFsurvey(1);Iyr++) SurvLFStore(Iclass) += SurveyLF(1,Iyr,Iclass);
    Total += SurvLFStore(Iclass);
   }
  if (Diag == 1) cout << "Survey sample sizes stored" << endl; 
  CheckFile << "Class Length, Weight Fecundity" << endl;
  for (Iclass=1;Iclass<=Nclass;Iclass++)
   {
    Length(Iclass) = 0; Wght(Iclass) = 0; fecu(Iclass) = 0; Total = 0;
    for (Jclass=ClassLink(Iclass,1);Jclass<=ClassLink(Iclass,2);Jclass++)
     {
      Length(Iclass) += Length_inp(Jclass)*SurvLFStore(Jclass);
      Wght(Iclass) += Wght_inp(Jclass)*SurvLFStore(Jclass);
      fecu(Iclass) += fecu_inp(Jclass)*SurvLFStore(Jclass);
      Total += SurvLFStore(Jclass);
     }
     Length(Iclass) /= Total;
     Wght(Iclass) /= Total;
     fecu(Iclass) /= Total;
     CheckFile << Iclass << " " << Length(Iclass) << " " << Wght(Iclass) << " " << fecu(Iclass) << endl;
    }
  if (Diag == 1) cout << "Lengths and weights specified" << endl; 
  FleetObsLF.initialize();
  for (Ifleet=-1;Ifleet<=Nfleet;Ifleet++)
   {
    TotalSS(Ifleet) = 0; NumSS = 0;
    for (Iyr=1;Iyr<=NLFfleet(Ifleet);Iyr++)
     {
      for (Iclass=1;Iclass<=Nclass;Iclass++)
       for (Jclass=ClassLink(Iclass,1);Jclass<=ClassLink(Iclass,2);Jclass++)
        FleetObsLF(Ifleet,Iyr,Iclass) += FleetLF(Ifleet,Iyr,Jclass);
      Total = 0;
      for (Iclass=1;Iclass<=Nclass;Iclass++) Total += FleetObsLF(Ifleet,Iyr,Iclass);
      SSFStore(Ifleet,Iyr) = Total;
      TotalSS(Ifleet) += Total; NumSS += 1;
      for (Iclass=1;Iclass<=Nclass;Iclass++) FleetObsLF(Ifleet,Iyr,Iclass) /= Total;
     }
    TotalSS(Ifleet) /= NumSS; 
   }
 Scalar = TotalSS(0);
 for (Ifleet=-1;Ifleet<=Nfleet;Ifleet++)
  for (Iyr=1;Iyr<=NLFfleet(Ifleet);Iyr++) 
   {
    SSFleetLF(Ifleet,Iyr) = 200*SSFStore(Ifleet,Iyr) / Scalar;
    if (SSFleetLF(Ifleet,Iyr) > 200) SSFleetLF(Ifleet,Iyr) = 200;
    if (SSFleetLF(Ifleet,Iyr) < 4) SSFleetLF(Ifleet,Iyr) = 4;
   }  
 if (Diag == 1) cout << "Fishery effective sample sizes specified" << endl; 
 CheckFile << "Used Fishery LF" << endl;
 CheckFile << FleetObsLF << endl;
 SurveyObsLF.initialize();
 for (Isurv=1;Isurv<=Nsurvey;Isurv++)
  {
   for (Iyr=1;Iyr<=NLFsurvey(Isurv);Iyr++)
    {
     for (Iclass=1;Iclass<=Nclass;Iclass++)
      for (Jclass=ClassLink(Iclass,1);Jclass<=ClassLink(Iclass,2);Jclass++)
       SurveyObsLF(Isurv,Iyr,Iclass) += SurveyLF(Isurv,Iyr,Jclass);
     Total = 0;
     for (Iclass=1;Iclass<=Nclass;Iclass++) Total += SurveyObsLF(Isurv,Iyr,Iclass);
     SSSStore(Isurv,Iyr) = Total;
     for (Iclass=1;Iclass<=Nclass;Iclass++) SurveyObsLF(Isurv,Iyr,Iclass) /= Total;
    }
  } 
 if (Diag == 1) cout << "Survey effective sample sizes specified" << endl; 
 CheckFile << "Used Survey LF" << endl;
 CheckFile << SurveyObsLF << endl;
 Ipnt = 0;
 for (Jpnt=1;Jpnt<=NSelexPat;Jpnt++)
  {
   SelexType(Jpnt,3) = Ipnt;
   if (SelexType(Jpnt,1)==1) Last = 2;
   if (SelexType(Jpnt,1)==2) Last = Nclass;
   if (SelexType(Jpnt,1)==3) Last = 1;
   Ipnt += Last;
  } 
 CheckFile << SelexType << endl;
 cout << "Completed Preliminary Calcs Section" << endl;
}

void model_parameters::userfunction(void)
{
  int II, Cnt, Ifleet, IY;
  dvariable Ratio1,Ratio2,Delta;
  // Convert to Fs
  for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
   {
    Cnt = 0;
    for (II=Yr1;II<=Yr2;II++)
     {
      if (Effort(Ifleet,II) > 0)
       {
        if (FOverWrite(Ifleet,0) == 0 |II<FOverWrite(Ifleet,1) | II>FOverWrite(Ifleet,2))
         { Cnt += 1; FAll(Ifleet,II) = FEst(Ifleet,Cnt); }
        else
         FAll(Ifleet,II) = -100;
       }  
      else
       FAll(Ifleet,II) = 0;
     }
   }  
  // Fill in missing values using a ratio estimator
  for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
   if (FOverWrite(Ifleet,0) > 0)
    {
     Ratio1 = 0; Ratio2 = 0;
     for (II=FOverWrite(Ifleet,3);II<=FOverWrite(Ifleet,4);II++)
      if (Effort(Ifleet,II) > 0)
       {
        Ratio1 += -log(1.0-FAll(Ifleet,II))/Effort(Ifleet,II);
        Ratio2 += 1;
       }
     Delta = Ratio1/Ratio2;
     for (II=FOverWrite(Ifleet,1);II<=FOverWrite(Ifleet,2);II++)
      FAll(Ifleet,II) = 1.0-mfexp(-Delta*Effort(Ifleet,II));
    }  
  // Set the growth matrix
  Set_growth();
  // Set the selectivity patterns
  Set_selex();
  // Set the initial size structure
  Initial_size_structure();
  // Specify survival rates
  Set_survival();
  // Population dynamics
  Update_population(); 
  Get_Catch_Pred();
  Get_Survey();
  ObjFunction();
  fout = 0;
  for (II=1;II<=NPriorTerms;II++) fout += PriorVal(II)*PriorWeight(II);
  for (II=1;II<=NLikeTerms;II++) fout += LikeVal(II)*DataWeight(II);
  //cout << PriorVal << endl;
  //cout << LikeVal << endl;
  //cout << fout << endl;
  // exit(1);
  LogMMB = log(MMB);
  LogRecruits = log(Recruits);
  for (IY=Yr1;IY<=Yr2-Lag;IY++)
   LogRMMB(IY) = log(Recruits(IY+Lag)/MMB(IY));
}

void model_parameters::Initial_size_structure(void)
{
  int Iclass;
  N.initialize();
  for (Iclass=1;Iclass<=Nclass;Iclass++)
   N(Yr1,Iclass) = exp(logRbar)*exp(logNinitial(Iclass));
}

void model_parameters::Update_population(void)
{
  int Iyr,Iclass,Jclass;
  dvariable MMBOut;
  for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
   {
    // Allow animals to grow
    for (Iclass=1;Iclass<=Nclass;Iclass++)
     for (Jclass=1;Jclass<=Nclass;Jclass++)
      N(Iyr+1,Iclass) += Trans(Jclass,Iclass)*N(Iyr,Jclass)*S(Iyr,Jclass);
    // Add in recruitment
    Recruits(Iyr) = mfexp(logRbar+RecDev(Iyr));
    N(Iyr+1,1) += Recruits(Iyr);
    MMBOut = 0;
    for (Iclass=1;Iclass<=Nclass;Iclass++) 
     MMBOut += N(Iyr,Iclass)*fecu(Iclass)*(1-FleetSelex(0,Iyr,Iclass)*FAll(0,Iyr))*exp(-(tc(0,Iyr)+2/12)*M(Iyr));
    MMB(Iyr) = MMBOut;
   }
}

void model_parameters::Set_growth(void)
{
  int Iclass,Jclass;
  dvariable Total;
  Trans.initialize();
  for (Iclass=1;Iclass<Nclass;Iclass++)
   {
    Total = (1+mfexp(TransPars(Iclass)));
    Trans(Iclass,Iclass) = 1/Total;
    Trans(Iclass,Iclass+1) =mfexp(TransPars(Iclass))/Total;
   }
  Trans(Nclass,Nclass) = 1;                 // Special case
}

void model_parameters::Set_selex(void)
{
  int Iclass,Iyr,Isurv,Ifleet,Ipnt,Jpnt;
  dvariable QQ,Temp,SlopePar;
  // Produce all selectivities
  for (Ifleet=1;Ifleet<=NSelexPat;Ifleet++)
   {
    Ipnt = SelexType(Ifleet,3);
    if (SelexType(Ifleet,1) == 1)
     {
      SlopePar = SelexPar(Ipnt+2);
      Temp = -log(19.0)/SlopePar;
      for (Iclass=1;Iclass<=Nclass;Iclass++)
       SelexAll(Ifleet,Iclass) = 1.0/(1.0+mfexp(Temp*(Length(Iclass)-SelexPar(Ipnt+1))));
      Temp =  SelexAll(Ifleet,Nclass);
      for (Iclass=1;Iclass<=Nclass;Iclass++) SelexAll(Ifleet,Iclass) /= Temp;
     }
    if (SelexType(Ifleet,1) == 2)
     {
      for (Iclass=1;Iclass<=Nclass;Iclass++)
       SelexAll(Ifleet,Iclass) = 1.0/(1.0+mfexp(SelexPar(Ipnt+Iclass)));
      Temp =  SelexAll(Ifleet,Nclass);
      for (Iclass=1;Iclass<=Nclass;Iclass++) SelexAll(Ifleet,Iclass) /= Temp;
     }
    if (SelexType(Ifleet,1) == 3)
     {
      Jpnt = SelexType(SelexType(Ifleet,2),3);
      SlopePar = SelexPar(Jpnt+2);
      Temp = -log(19.0)/SlopePar;
      for (Iclass=1;Iclass<=Nclass;Iclass++)
       SelexAll(Ifleet,Iclass) = 1.0/(1.0+mfexp(Temp*(Length(Iclass)-SelexPar(Ipnt+1))));
      Temp =  SelexAll(Ifleet,Nclass);
      for (Iclass=1;Iclass<=Nclass;Iclass++) SelexAll(Ifleet,Iclass) /= Temp;
     }
   } 
  // Fishery and bycatch selectivity
  for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
   for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
    {
     Ipnt = FleetSelexPnt(Ifleet,Iyr);
     for (Iclass=1;Iclass<=Nclass;Iclass++)
      FleetSelex(Ifleet,Iyr,Iclass) = SelexAll(Ipnt,Iclass) ;
    }  
  // Retention in the pot fishery
  for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
   for (Iclass=1;Iclass<=Nclass;Iclass++)
    {
     Ipnt = (FleetRetPnt(Iyr)-1)*Nclass;
     RetCatMale(Iyr,Iclass) = (1-hg(Iyr))/(1.0+mfexp(RetainPar(Ipnt+Iclass)));
    } 
  // Survey selectivity
  for (Isurv=1;Isurv<=Nsurvey;Isurv++)
   for (Iyr=Yr1;Iyr<=Yr2+1;Iyr++)
    {
     Ipnt = SurveyQPnt(Isurv,Iyr);
     QQ = exp(LogSurveyQ(Ipnt));
     Ipnt = SurveySelexPnt(Isurv,Iyr);
     for (Iclass=1;Iclass<=Nclass;Iclass++)
      SelexSurvey(Isurv,Iyr,Iclass) = QQ*SelexAll(Ipnt,Iclass);
    }  
  // Nest one survey within another
  for (Ipnt=1;Ipnt <=NsubSurveyFleets;Ipnt++)
   for (Iyr=Yr1;Iyr<=Yr2+1;Iyr++)
    for (Iclass=1;Iclass<=Nclass;Iclass++)
     SelexSurvey(SubFltSpec(Ipnt,1),Iyr,Iclass) *= SelexSurvey(SubFltSpec(Ipnt,2),Iyr,Iclass);
}

void model_parameters::Set_survival(void)
{
  int Iyr,Iclass,Ifleet;
  // Specify M
  M = M0;
  for (Iyr=Yr1;Iyr<=Yr2;Iyr++) if (Mpnt(Iyr)>1) M(Iyr) += Mm(Mpnt(Iyr)); 
  for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
   for (Iclass=1;Iclass<=Nclass;Iclass++)
    {
     S(Iyr,Iclass) = mfexp(-M(Iyr));
     for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
      {
       SF(Ifleet,Iyr,Iclass) = (1-FleetSelex(Ifleet,Iyr,Iclass)*FAll(Ifleet,Iyr));
       ExplRates(Ifleet,Iyr) = FAll(Ifleet,Iyr);
       S(Iyr,Iclass) *= SF(Ifleet,Iyr,Iclass);
      } 
     Fdirect(Iyr) = FleetSelex(0,Iyr,Nclass)*FAll(0,Iyr);
    }
}

void model_parameters::Get_Catch_Pred(void)
{
  int Iyr,Iclass,Ifleet;
  dvariable S1,S2;
  dvariable SurvNo;                              // Numbers at fishery
  CatFleet.initialize();
  CatFleetWghtPred.initialize();
  CatFleetNumPred.initialize();
  for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
   for (Iclass=1;Iclass<=Nclass;Iclass++)
    {
     SurvNo = N(Iyr,Iclass)*mfexp(-tc(0,Iyr)*M(Iyr));
     S1 = SF(0,Iyr,Iclass);
     CatFleet(0,Iyr,Iclass) = SurvNo*(1-S1)*RetCatMale(Iyr,Iclass);
     CatFleet(-1,Iyr,Iclass) = SurvNo*(1-S1)*(1-RetCatMale(Iyr,Iclass));
     SurvNo *= S1;
     for (Ifleet=1;Ifleet<=Nfleet;Ifleet++)
      {
       S2 = SF(Ifleet,Iyr,Iclass);
       CatFleet(Ifleet,Iyr,Iclass) = SurvNo*(1-S2);
       SurvNo *= S2;
      }
     // Accumulate totals 
     for (Ifleet=-1; Ifleet<=Nfleet;Ifleet++)
      {
       CatFleetWghtPred(Ifleet,Iyr) += CatFleet(Ifleet,Iyr,Iclass) * Wght(Iclass);
       CatFleetNumPred(Ifleet,Iyr) += CatFleet(Ifleet,Iyr,Iclass);
      } 
    }
  // Special case for fleet -1
  if (DiscardsOrTotal == 1)
   for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
    for (Iclass=1;Iclass<=Nclass;Iclass++)
     CatFleet(-1,Iyr,Iclass) = CatFleet(-1,Iyr,Iclass) + CatFleet(0,Iyr,Iclass);
}

void model_parameters::Get_Survey(void)
{
  int Iyr,Iclass,Isurv;
  for (Isurv=1;Isurv<=Nsurvey;Isurv++)
   for (Iyr=Yr1;Iyr<=Yr2+1;Iyr++)
    for (Iclass=1;Iclass<=Nclass;Iclass++)
     PredSurvey(Isurv,Iyr,Iclass) = N(Iyr,Iclass)*SelexSurvey(Isurv,Iyr,Iclass);
  PredSurveyNum.initialize();
  PredSurveyWght.initialize();
  for (Isurv=1;Isurv<=Nsurvey;Isurv++)
   for (Iyr=Yr1;Iyr<=Yr2+1;Iyr++)
    for (Iclass=1;Iclass<=Nclass;Iclass++)
     {
      PredSurveyWght(Isurv,Iyr) += PredSurvey(Isurv,Iyr,Iclass)*Wght(Iclass);
      PredSurveyNum(Isurv,Iyr) += PredSurvey(Isurv,Iyr,Iclass);
     }
}

void model_parameters::ObjFunction(void)
{
  int Iyr,Icnt,Iclass,Ifleet,Isurv,Jpnt,Iselex;
  dvariable Incc,Incd,Total,Error,Penal;
  dvariable MeanF, nn;
  Incc = 0.00001;
  Incd = 0.0001;
  PriorVal.initialize(); 
  LikeVal.initialize();
  // PRIORS
  //================================================================================
  // Prior on F-devs 
  for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
   {
    MeanF = 0; nn = 0;
    for (Iyr=Yr1;Iyr<=Yr2;Iyr++) 
     if (Effort(Ifleet,Iyr) > 0) { MeanF += FAll(Ifleet,Iyr); nn+= 1; }
    MeanF /= nn;
    for (Iyr=Yr1;Iyr<=Yr2;Iyr++) 
     if (Effort(Ifleet,Iyr) > 0) PriorVal(Ifleet+1) += square(FAll(Ifleet,Iyr)-MeanF);
    } 
  Jpnt = Nfleet+1;
  // Prior on Rec Devs
  for (Iyr=Yr1;Iyr<=Yr2;Iyr++) PriorVal(Jpnt+1) += square(RecDev(Iyr));
  // penalties on parameters
  PriorVal(Jpnt+2) = sum(square(TransPars));
  for (Ifleet=1;Ifleet<=NSelex;Ifleet++)
   if (SelexPhase(Ifleet) > 0)
    PriorVal(Jpnt+3) += square(SelexPar(Ifleet));
  PriorVal(Jpnt+4) = sum(square(RetainPar));
  PriorVal(Jpnt+5) = 0;
  // q - prior
  for (Isurv=1;Isurv<=NSurveyQ;Isurv++)
   if (SurveyQPSD(Isurv) > 0)
     PriorVal(Jpnt+5+Isurv) = square(exp(LogSurveyQ(Isurv))-SurveyQPMean(Isurv))/(2.0*square(SurveyQPSD(Isurv)));
  Jpnt = Jpnt+5+NSurveyQ;
  // M-prior
  PriorVal(Jpnt+1) = square(M0-MPriorMean)/(2.0*square(MPriorSD));
  Jpnt += 1;
  // 2nd derivative penalty
  Penal = 0;
  for (Iselex=1;Iselex<=NSelexPat;Iselex++)
   if (SelexType(Iselex,1) == 2)
    for (Iclass=2;Iclass<=Nclass-1;Iclass++)
     Penal += square(SelexAll(Iselex,Iclass-1)-2.0*SelexAll(Iselex,Iclass)+SelexAll(Iselex,Iclass+1));
  PriorVal(Jpnt+1) = Penal;   
  // DATA COMPONENTS
  //================================================================================
  // Likelihood for Catches
  for (Ifleet=-1;Ifleet<=Nfleet;Ifleet++)
   for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
    if (CatchAndDiscard(Ifleet,Iyr) > 0)
     {
      if(CatchUnit(Ifleet) == 1)
       LikeVal(Ifleet+2) += square(log((CatFleetWghtPred(Ifleet,Iyr)+Incd)/(CatchAndDiscard(Ifleet,Iyr)+Incd)));
      else
       LikeVal(Ifleet+2) += square(log((CatFleetNumPred(Ifleet,Iyr)+Incd)/(CatchAndDiscard(Ifleet,Iyr)+Incd)));
     }  
  Jpnt = Nfleet+2;
  // Survey indices 
  for (Isurv=1;Isurv<=Nsurvey;Isurv++)
   for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
    if (SurveyEst(Isurv,Iyr,1) > 0)
     {
      if(SurveyUnit(Isurv) == 1)
       LikeVal(Jpnt+Isurv) += 0.5*square(log((SurveyEst(Isurv,Iyr,1)+Incd)/(PredSurveyWght(Isurv,Iyr)+Incd)))/square(SurveyEst(Isurv,Iyr,2));
      else 
       LikeVal(Jpnt+Isurv) += 0.5*square(log((SurveyEst(Isurv,Iyr,1)+Incd)/(PredSurveyNum(Isurv,Iyr)+Incd)))/square(SurveyEst(Isurv,Iyr,2));
      }  
   Jpnt = Jpnt + Nsurvey;   
  // Effort indices
  qEff.initialize();
  for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
   {
    nn= 0;
    for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
     if (Effort(Ifleet,Iyr) > 0) 
      {
       if (FOverWrite(Ifleet,0) == 0 |Iyr<FOverWrite(Ifleet,1) | Iyr>FOverWrite(Ifleet,2))
        { nn += 1; qEff(Ifleet) += log((Effort(Ifleet,Iyr)+Incd)/(ExplRates(Ifleet,Iyr)+Incd)); }
      }  
    qEff(Ifleet) = mfexp(qEff(Ifleet)/nn); 
    for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
     if (Effort(Ifleet,Iyr) > 0)
      if (FOverWrite(Ifleet,0) == 0 |Iyr<FOverWrite(Ifleet,1) | Iyr>FOverWrite(Ifleet,2))
       LikeVal(Jpnt+Ifleet+1) += square(log((Effort(Ifleet,Iyr)+Incd)/(qEff(Ifleet)*(ExplRates(Ifleet,Iyr)+Incd))));
   }  
  Jpnt = Jpnt + (Nfleet+1); 
  // Catch LFs
  for (Ifleet=-1;Ifleet<=Nfleet;Ifleet++)
   for (Icnt=1;Icnt<=NLFfleet(Ifleet);Icnt++)
    {
     Iyr = YrFleetLF(Ifleet,Icnt);
     Total = 0;
     for (Iclass=1;Iclass<=Nclass;Iclass++) Total += CatFleet(Ifleet,Iyr,Iclass);
     for (Iclass=1;Iclass<=Nclass;Iclass++) CatFleet(Ifleet,Iyr,Iclass) /= Total;
     for (Iclass=1;Iclass<=Nclass;Iclass++)
      if (FleetObsLF(Ifleet,Icnt,Iclass) > 0)
       {
        Error = (CatFleet(Ifleet,Iyr,Iclass)+Incc)/(FleetObsLF(Ifleet,Icnt,Iclass)+Incc);
        LikeVal(Jpnt+2+Ifleet) += -1*SSFleetLF(Ifleet,Icnt)*FleetObsLF(Ifleet,Icnt,Iclass)*log(Error);
       }
    } 
   Jpnt = Jpnt + (Nfleet+2);
  // Survey LF
  for (Isurv=1;Isurv<=Nsurvey;Isurv++)
   for (Icnt=1;Icnt<=NLFsurvey(Isurv);Icnt++)
    {
     Iyr = YrSurveyLF(Isurv,Icnt);
     Total = 0;
     for (Iclass=1;Iclass<=Nclass;Iclass++) Total += PredSurvey(Isurv,Iyr,Iclass);
     for (Iclass=1;Iclass<=Nclass;Iclass++) PredSurvey(Isurv,Iyr,Iclass) /= Total;
     for (Iclass=1;Iclass<=Nclass;Iclass++)
      if (SurveyObsLF(Isurv,Icnt,Iclass) > 0)
       {
        Error = (PredSurvey(Isurv,Iyr,Iclass)+Incc)/(SurveyObsLF(Isurv,Icnt,Iclass)+Incc);
        LikeVal(Jpnt+Isurv) += -1*SSSurveyLF(Isurv,Icnt)*SurveyObsLF(Isurv,Icnt,Iclass)*log(Error);
       }
    } 
 // cout << PriorVal << endl;
 // cout << LikeVal << endl;  
 // =====================================================================
}

void model_parameters::Find_F35(void)
{
 int ii;
 dvariable SBPR0,Fmin,Fmax,Ratio;
 // Find virgin SPR
 IsB0 = -1;
 SR_rel = 1;
 Fmult = 0;
 ProjConstF();
 SBPR0 = MMBOut;
 cout << " SSBPR0 " << SBPR0 << endl;
 // Step through the Fs
 IsB0 = 1;
 for (ii=1;ii<=10000;ii=ii+10)
  {
   Fmult = float(ii)*0.001;
   ProjConstF();
   Ratio = MMBOut/SBPR0;
   if (Ratio < 0.35) ii = 20000;
  }
 // Bisect
 Fmax = Fmult;
 Fmin = Fmult-0.1;
 for (ii=1;ii<=20;ii++)
  {
   Fmult = (Fmin+Fmax)/2.0;
   ProjConstF();
   Ratio = MMBOut/SBPR0;
   if (Ratio > 0.35)
    Fmin = Fmult;
   else
    Fmax = Fmult; 
  }
 if (fabs(Ratio-0.35) > 0.001) cout << "Problem" << endl; 
 // Set F35%
 F35 = Fmult;
 // Find SBPR35%
 Fmult = F35;
 ProjConstF();
 SBPR35 = MMBOut/RecOut;
 cout << "F35 " << F35 << " " << SBPR35 << " " << Ratio << " " << CatchOut << endl;
}

void model_parameters::Get_Steepness(void)
{
  dvariable RbarFmsy, nn, BmsyProx, SBPR;
  dvariable DerivMin,DerivMax,MaxSteep,MinSteep,Cat1,Cat2,Deriv,Term1,Term2;
  dvariable BioDep;
  int iy,II,ISteep;
  // Get initial R0
  IsB0 = -1;
  SR_rel = 1;
  Fmult = 0;
  ProjConstF();
  SBPR = MMBOut / RecOut;
  MMB0 = MMBOut;
  R0 = RecOut;
  IsB0 = 1;
  // Find recruitment at BMSY
  RbarFmsy = 0; nn = 0;
  for (iy=BMSY_Y1;iy<=BMSY_Y2;iy++){ RbarFmsy += Recruits(iy); nn += 1; }
  RbarFmsy /= nn;
  // Find the BMSY proxy
  BmsyProx = SBPR35 * RbarFmsy;
  MMB0 = BmsyProx / 0.35;
  R0 = MMB0 / SBPR;
  SR_rel = SR_RelAct;
  if (SR_rel == 2)
   {  MinSteep = 0.21; MaxSteep = 0.99; ISteep = 99; }
  if (SR_rel == 3)
   {  MinSteep = 0.21; MaxSteep = 5.00; ISteep = 500; }
  DerivMin = -1.0e20; DerivMax = 1.0e20;
  for (II=21;II<=ISteep;II++)
   {
    Steep = float(II)*0.01;
    Fmult = F35 + 0.001;
    ProjConstF();
    Cat1 = CatchOut;
    Fmult = F35 - 0.001;
    ProjConstF();
    Cat2 = CatchOut;
    Deriv = (Cat1-Cat2)/0.002;
    if (Deriv < 0 & Deriv > DerivMin) { MinSteep = Steep; DerivMin = Deriv; }
    if (Deriv > 0 & Deriv < DerivMax) { MaxSteep = Steep; DerivMax = Deriv; }
 //   cout << Steep << " " <<  Cat1 << " " << Cat2 << " " << (Cat1-Cat2)/0.002 << " " << MinSteep << " " << 
 //    DerivMin << " " << MaxSteep << " " << DerivMax << endl;  
   }
 // Solve for FMSY (fine search)
 for (II=1;II<=40;II++)
  {
   Steep = value((MinSteep+MaxSteep)/2.0);
   R0 = MMB0 / SBPR;
   Fmult = F35 + 0.001;
   ProjConstF();
   Cat1 = CatchOut;
   Fmult = F35 - 0.001;
   ProjConstF();
   Cat2 = CatchOut;
   Deriv = (Cat1-Cat2)/0.001;
   if (Deriv < 0) MinSteep = Steep; else MaxSteep = Steep; 
  }
 Fmult = F35; 
 ProjConstF();
 BioDep = MMBOut/MMB0;
  // Now compute B0 given R at BMSY;
 if (SR_rel == 2)
  {
   Term1 = (1-Steep) + (5*Steep-1)*BioDep;
   Term2 = 4*Steep*BioDep;
   R0 = RbarFmsy*Term1/Term2;
  }
 if (SR_rel == 3)
  {
   Term1 = exp(5.0/4.0*log(5*Steep-1)*BioDep);
   R0 = RbarFmsy / BioDep / Term1;
  }
 MMB0 = R0*SBPR;
 cout << "Final: " << Steep << " " << R0 << " " << MMB0 << " " << BioDep << " " << Deriv << endl;
 cout << "Recruit/spawner at FMSY: " << 1/SBPR35 << " " << RbarFmsy << " " << BmsyProx << endl;
 for(II=1;II<=141;II++)
  {
   Fmult = (float(II)/21.0)*F35;
   ProjConstF();
   cout << "T " << Fmult/F35 << " " << CatchOut << " " << MMBOut/MMB0 << " "  << MMBOut/BmsyProx << endl;
  }
}

void model_parameters::ProjConstF(void)
{
 dvariable AveRec,MMB,S1,SurvNo,CatRetTmp,Term1,Term2,TheMort;
 dvar_vector SF1F(1,Nclass),SF2F(1,Nclass),SF3F(1,Nclass),SF(1,Nclass);
 dvar_matrix NFut(1,100,1,Nclass);
 int iy,Iclass,Jclass,FutYr,Ifleet;
 NFut.initialize();
 // Mortality due to other fleets
 for (Ifleet=1;Ifleet<=Nfleet;Ifleet++)
  {
   TheMort = 0;
   for (iy=Yr2-4;iy<=Yr2;iy++) TheMort += FAll(Ifleet, iy);
   MortF(Ifleet) = TheMort / 5;
  }
 if (IsB0 == -1) { MortF.initialize(); }
 // Average recruitment
 AveRec = 0;
 for (iy=Yr2-4;iy<=Yr2;iy++) AveRec += mfexp(logRbar+RecDev(iy));
 AveRec /= 5;
 AveRec = 1;
 // Survival
 for (Iclass=1;Iclass<=Nclass;Iclass++)
  {
   SF1F(Iclass) = 1-FleetSelex(0,Yr2,Iclass)*Fmult;
   SF(Iclass) = mfexp(-M(Yr2))*SF1F(Iclass);
   for (Ifleet=1;Ifleet<=Nfleet;Ifleet++)
    SF(Iclass) *= (1- FleetSelex(Ifleet,Yr2,Iclass)*MortF(Ifleet));
  }
 // Copy Ns (irrelevant)
 for (Iclass=1;Iclass<=Nclass;Iclass++) NFut(1,Iclass) = N(Yr2+1,Iclass);
 for (Iclass=1;Iclass<=Nclass;Iclass++) NFut(1,Iclass) = 1;
 for (FutYr=1;FutYr<=99;FutYr++)
  {
    // Stock-recruitment relationship
    if (SR_rel == 2)
     {
      if (FutYr-Lag <= 1) 
       MMB = MMB0;
      else
       MMB = mbio(FutYr-Lag); 
      Term1 = 4*R0*Steep*MMB/MMB0;
      Term2 = (1-Steep) + (5*Steep-1)*MMB/MMB0;
      RecOut = Term1/Term2;
     }
    else
     if (SR_rel == 3)
      {
       if (FutYr-Lag <= 1) 
        MMB = MMB0;
       else
        MMB = mbio(FutYr-Lag); 
       Term1 = R0*MMB/MMB0;
       Term2 = 5.0/4.0*log(5*Steep)*(1-MMB/MMB0);
       RecOut = Term1*mfexp(Term2);
      }
     else
      RecOut = AveRec;
   // Compute catch
   CatchOut = 0;
   for (Iclass=1;Iclass<=Nclass;Iclass++)
    {
     S1 = 0.9999*SF1F(Iclass);
     SurvNo = NFut(FutYr,Iclass)*mfexp(-gamma*M(Yr2));
     CatRetTmp = SurvNo*(1-S1)*RetCatMale(Yr2-5,Iclass);
     CatchOut += CatRetTmp* Wght(Iclass);
    }
   // Allow animals to grow
   for (Iclass=1;Iclass<=Nclass;Iclass++)
    for (Jclass=1;Jclass<=Nclass;Jclass++)
     NFut(FutYr+1,Iclass) += Trans(Jclass,Iclass)*NFut(FutYr,Jclass)*SF(Jclass);
   // Add in recruitment
   NFut(FutYr+1,1) += RecOut;
   // Compute MMB
   MMBOut = 0;
   for (Iclass=1;Iclass<=Nclass;Iclass++) 
    MMBOut += NFut(FutYr,Iclass)*fecu(Iclass)*(1-FleetSelex(0,Yr2,Iclass)*Fmult)*mfexp(-(gamma+2.0/12.0)*M(Yr2));
   mbio(FutYr) = MMBOut;
  }
}

void model_parameters::report()
{
 adstring ad_tmp=initial_params::get_reportfile_name();
  ofstream report((char*)(adprogram_name + ad_tmp));
  if (!report)
  {
    cerr << "error trying to open report file"  << adprogram_name << ".rep";
    return;
  }
 int Icnt,Iyr,Iclass,Ifleet,Isurv,Jpnt;
 dvariable Top,Bot,Incd,MaxF;
 dvar_matrix SSFleetPred(-1,Nfleet,1,maxFleetLF);         // Effective sample sizes
 dvar_matrix SSSurveyPred(1,Nsurvey,1,maxSurveyLF);       // Effective sample sizes
 dvar_vector Temp(0,Nfleet);
 Incd = 0.0001;
 Find_F35();
 Get_Steepness();
 report << Yr1 << " " << Yr2 << " " << Nfleet+1 << " " << Nsurvey << endl;
 report << NLFfleet << endl;
 report << NLFsurvey << endl;
 report << "Fout: " << fout << endl; 
 report << "Priors" << endl;
 for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
  report << Ifleet+1 << " Effort Dev: Fleet " << Ifleet << " " << PriorVal(Ifleet+1) << " " << PriorWeight(Ifleet+1) << " " << PriorWeight(Ifleet+1)*PriorVal(Ifleet+1) << endl;
 Jpnt = Nfleet+1;
 report << Jpnt+1 << " Recruitment Devs:  " << PriorVal(Jpnt+1) << " " << PriorWeight(Jpnt+1) << " " << PriorWeight(Jpnt+1)*PriorVal(Jpnt+1) << endl;
 report << Jpnt+2 << " Penalty: Trans Pars: " << PriorVal(Jpnt+2) << " " << PriorWeight(Jpnt+2) << " " << PriorWeight(Jpnt+2)*PriorVal(Jpnt+2) << endl;
 report << Jpnt+3 << " Penalty: Selex Pars: " << PriorVal(Jpnt+3) << " " << PriorWeight(Jpnt+3) << " " << PriorWeight(Jpnt+3)*PriorVal(Jpnt+3) << endl;
 report << Jpnt+4 << " Penalty: Retain Pars: " << PriorVal(Jpnt+4) << " " << PriorWeight(Jpnt+4) << " " << PriorWeight(Jpnt+4)*PriorVal(Jpnt+4) << endl;
 for (Isurv=1;Isurv<=NSurveyQ;Isurv++)
  report << Jpnt+5+Isurv << " Q prior:  " << Isurv << " " << PriorVal(Jpnt+5+Isurv) << " " << PriorWeight(Jpnt+5+Isurv) << " " << PriorWeight(Jpnt+5+Isurv)*PriorVal(Jpnt+5+Isurv) << endl;
 Jpnt = Jpnt+5+NSurveyQ;
 report << Jpnt+1 << " M prior: " << PriorVal(Jpnt+1) << " " << PriorWeight(Jpnt+1) << " " << PriorWeight(Jpnt+1)*PriorVal(Jpnt+1) << endl;
 Jpnt += 1;
 report << Jpnt+1 << " 2nd Derivative Penalty: " << PriorVal(Jpnt+1) << " " << PriorWeight(Jpnt+1) << " " << PriorWeight(Jpnt+1)*PriorVal(Jpnt+1) << endl;
 report << "Likelihood" << endl;
 for (Ifleet=1;Ifleet<=Nfleet+2;Ifleet++)
  report << Ifleet << " Catches: Fleet " << Ifleet-2 << " " << LikeVal(Ifleet) << " " << DataWeight(Ifleet) << " " << LikeVal(Ifleet)*DataWeight(Ifleet) << endl;
 Jpnt = Nfleet + 2; 
 for (Isurv=1;Isurv<=Nsurvey;Isurv++)
  report << Jpnt+Isurv << " Indices: Survey " << Isurv << " " << LikeVal(Jpnt+Isurv) << " " << DataWeight(Jpnt+Isurv) << " " << LikeVal(Jpnt+Isurv)*DataWeight(Jpnt+Isurv) << endl;
 Jpnt = Jpnt + Nsurvey; 
 for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
  report << Jpnt+Ifleet+1 << " Effort Devs: " << Ifleet << " " << LikeVal(Jpnt+Ifleet+1) << " " << DataWeight(Jpnt+Ifleet+1) << " " << LikeVal(Jpnt+Ifleet+1)*DataWeight(Jpnt+Ifleet+1) << endl;
 Jpnt = Jpnt + (Nfleet+1); 
 for (Ifleet=-1;Ifleet<=Nfleet;Ifleet++)
  report << Jpnt+Ifleet+2 << " Catch LFs: " << Ifleet << " " << LikeVal(Jpnt+Ifleet+2) << " " << DataWeight(Jpnt+Ifleet+2) << " " << LikeVal(Jpnt+Ifleet+2)*DataWeight(Jpnt+Ifleet+2) << endl;
 Jpnt = Jpnt + (Nfleet+2);
 for (Isurv=1;Isurv<=Nsurvey;Isurv++)
  report << Jpnt+Isurv << " Survey LFs: " << Isurv<< " " << LikeVal(Jpnt+Isurv) << " " << DataWeight(Jpnt+Isurv) << " " << LikeVal(Jpnt+Isurv)*DataWeight(Jpnt+Isurv) << endl;
 report << endl; 
 report << "Priors: " << PriorVal << endl;
 report << "Likelihoods: " << LikeVal << endl;
 report << "Priors: " << elem_prod(PriorWeight,PriorVal) << endl;
 report << "Likelihoods: " << elem_prod(DataWeight,LikeVal) << endl;
 report << endl;
 for (Iyr=Yr1;Iyr<=Yr2+1;Iyr++) report << Iyr << " " << N(Iyr) << endl;
 report << endl << "Natural mortality" << endl;
 report << M << endl;
 report << endl << "Transition matrix" << endl;
 report << Trans << endl;
 report << endl;
 report << "Retained probability" << endl;
 for (Iyr=Yr1;Iyr<=Yr2;Iyr++) report << Iyr << " " << RetCatMale(Iyr) << endl;
 report << "Selectivity patterns" << endl;
 for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
  {
   report << "Fleet: " << Ifleet << endl;
  for (Iyr=Yr1;Iyr<=Yr2;Iyr++) report << Iyr << " " << FleetSelex(Ifleet,Iyr) << endl;
  }
 report << "Survey selectivity" << endl;
 for (Isurv=1;Isurv<=Nsurvey;Isurv++)
  {
   report << "Survey: " << Isurv << endl;
   for (Iyr=Yr1;Iyr<=Yr2+1;Iyr++) report << Iyr << " " << SelexSurvey(Isurv,Iyr) << endl;
  } 
 report << endl << "Survival" << endl;
 for (Iyr=Yr1;Iyr<=Yr2;Iyr++) report << Iyr << " " << S(Iyr) << endl;
 report << " " << endl;
 report << endl << "Exploitation rate" << endl;
 for (Iyr=Yr1;Iyr<=Yr2;Iyr++)
   {
    Temp.initialize();
    for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
     {
      MaxF = 1- SF(Ifleet,Iyr,1);
      for (Iclass=2;Iclass<=Nclass;Iclass++) if (MaxF < 1-SF(Ifleet,Iyr,Iclass)) MaxF = 1-SF(Ifleet,Iyr,Iclass);
      Temp(Ifleet) = MaxF;
     }
    report << Iyr << " " << Temp << endl; 
  }
 report << "Catches" << endl;
 for (Ifleet=-1;Ifleet<=Nfleet;Ifleet++) report << Ifleet << " "; report << endl;
 for (DIyr=Yr1;DIyr<=Yr2;DIyr++)
  {
   report << DIyr << " ";
   for (Ifleet=-1;Ifleet<=Nfleet;Ifleet++)
    {
     report << CatchAndDiscard(Ifleet,DIyr) << " ";
     if (CatchUnit(Ifleet) == 1)
      report << CatFleetWghtPred(Ifleet,DIyr) << " ";
     else
      report << CatFleetNumPred(Ifleet,DIyr) << " ";
    }
   report << endl;
  } 
 report << "Survey indices" << endl;
 for (Isurv=1;Isurv<=Nsurvey;Isurv++)  report << Isurv << " "; report << endl;
 for (DIyr=Yr1;DIyr<=Yr2+1;DIyr++)
  {
   report << DIyr << " ";
   for (Isurv=1;Isurv<=Nsurvey;Isurv++) 
    {
     report << SurveyEst(Isurv,DIyr,1) << " " << SurveyEst(Isurv,DIyr,2) << " ";
     if (SurveyUnit(Isurv) == 1)
      report << PredSurveyWght(Isurv,DIyr) << " ";
     else
      report << PredSurveyNum(Isurv,DIyr) << " ";
    }
   report << endl; 
  }
 report << "Effort series" << endl;
 for (Ifleet=0;Ifleet<=Nfleet;Ifleet++) report << Ifleet << " "; report << endl;
 for (DIyr=Yr1;DIyr<=Yr2;DIyr++)
  {
   report << DIyr << " ";
   for (Ifleet=0;Ifleet<=Nfleet;Ifleet++)
    report << Effort(Ifleet,DIyr) << " " << ExplRates(Ifleet,DIyr)*qEff(Ifleet) << " ";
   report << endl; 
  }
 report << " " << endl;
 report << "Recruits" << endl;
 report << Recruits << endl; 
 report << " " << endl;
 report << "MMB" << endl;
 report << MMB << endl; 
 report << " " << endl;
 for (Ifleet=-1;Ifleet<=Nfleet;Ifleet++)
  {
   report << "Effn for LF for fleet " << Ifleet << endl;
   for (Icnt=1;Icnt<=NLFfleet(Ifleet);Icnt++)
    {
     Iyr = YrFleetLF(Ifleet,Icnt);
     Top = 0; Bot = 0;
     for (Iclass=1;Iclass <=Nclass;Iclass++)
      {
       Top += square(FleetObsLF(Ifleet,Icnt,Iclass)-CatFleet(Ifleet,Iyr,Iclass));
       Bot += CatFleet(Ifleet,Iyr,Iclass)*(1.0-CatFleet(Ifleet,Iyr,Iclass));
      }
     SSFleetPred(Ifleet,Icnt) = Bot/Top;
     report << Iyr << " " << SSFleetLF(Ifleet,Icnt) << " "<< Bot/Top <<  endl;
    }
   } 
 for (Isurv=1;Isurv<=Nsurvey;Isurv++)
  {
   report << "Effn for LF for survey " << Isurv << endl;
   for (Icnt=1;Icnt<=NLFsurvey(Isurv);Icnt++)
    {
     Iyr = YrSurveyLF(Isurv,Icnt);
     Top = 0; Bot = 0;
     for (Iclass=1;Iclass <=Nclass;Iclass++)
      {
       Top += square(SurveyObsLF(Isurv,Icnt,Iclass)-PredSurvey(Isurv,Iyr,Iclass));
       Bot += PredSurvey(Isurv,Iyr,Iclass)*(1.0-PredSurvey(Isurv,Iyr,Iclass));
      }
     SSSurveyPred(Isurv,Icnt) = Bot/Top; 
     report << Iyr << " " << SSSurveyLF(Isurv,Icnt) << " " << Bot/Top <<  endl;
    }
  }  
 for (Ifleet=-1;Ifleet<=Nfleet;Ifleet++)
  {
   report << "LF for fleet " << Ifleet << endl;
   for (Icnt=1;Icnt<=NLFfleet(Ifleet);Icnt++)
    {
     Iyr = YrFleetLF(Ifleet,Icnt);
     report << Iyr << " " << SSFleetLF(Ifleet,Icnt) << " " << FleetObsLF(Ifleet,Icnt) << endl;
     report << Iyr << " " << SSFleetPred(Ifleet,Icnt) << " " << CatFleet(Ifleet,Iyr) << endl;
    } 
  }  
 for (Isurv=1;Isurv<=Nsurvey;Isurv++)
  {
   report << "LF for survey " << Isurv << endl;
   for (Icnt=1;Icnt<=NLFsurvey(Isurv);Icnt++)
    {
     Iyr = YrSurveyLF(Isurv,Icnt);
     report << YrSurveyLF(Isurv,Icnt) << " " << SSSurveyLF(Isurv,Icnt) << " " << SurveyObsLF(Isurv,Icnt) << endl;
     report << YrSurveyLF(Isurv,Icnt) << " " << SSSurveyPred(Isurv,Icnt) << " " << PredSurvey(Isurv,Iyr) << endl;
    } 
  }  
 for (Ifleet=0;Ifleet<=Nfleet; Ifleet++)
  {
   report << "Fishery " << Ifleet << endl;
   for (Iyr=Yr1;Iyr<=Yr2;Iyr++) report << Iyr << " " << SF(Ifleet,Iyr) << endl;
  }
 report << "weights" << endl;
 report << PriorWeight << endl;
 report << DataWeight << endl;
 report << "Finished Report" << endl; 
 report << endl;
 report << gamma << endl;
 report << F35 << endl;
 report << 1 << endl;
 report << M(Yr2) << endl;
 report << 1/SBPR35 << endl;
 report << 5 << endl;
 report << Trans << endl;
 report << Wght << endl;
 report << RetCatMale(Yr2-5) << endl;
 report << endl;
 report << fecu << endl;
 report << FleetSelex << endl;
 report << R0 << endl;
 report << Steep << endl;
 report << MortF << endl;
 for (Iyr=1995;Iyr<=Yr2;Iyr++)
  report << Iyr << " " << Fdirect(Iyr) << endl;
 report << " " << endl;
 report << SR_rel << endl;
}

void model_parameters::set_runtime(void)
{
  dvector temp1("{5000}");
  maximum_function_evaluations.allocate(temp1.indexmin(),temp1.indexmax());
  maximum_function_evaluations=temp1;
}

model_data::~model_data()
{}

model_parameters::~model_parameters()
{}

void model_parameters::final_calcs(void){}

#ifdef _BORLANDC_
  extern unsigned _stklen=10000U;
#endif


#ifdef __ZTC__
  extern unsigned int _stack=10000U;
#endif

  long int arrmblsize=0;

int main(int argc,char * argv[])
{
    ad_set_new_handler();
  ad_exit=&ad_boundf;
    CheckFile.open("Check.Out");
    gradient_structure::set_NO_DERIVATIVES();
    gradient_structure::set_YES_SAVE_VARIABLES_VALUES();
  #if defined(__GNUDOS__) || defined(DOS386) || defined(__DPMI32__)  || \
     defined(__MSVC32__)
      if (!arrmblsize) arrmblsize=150000;
  #else
      if (!arrmblsize) arrmblsize=25000;
  #endif
    model_parameters mp(arrmblsize,argc,argv);
    mp.iprint=10;
    mp.preliminary_calculations();
    mp.computations(argc,argv);
    return 0;
}

extern "C"  {
  void ad_boundf(int i)
  {
    /* so we can stop here */
    exit(i);
  }
}

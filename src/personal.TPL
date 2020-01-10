FUNCTION MyOutput
  int nnnn;
 

  // Likelihood summary. Added by Jie, total 10 lines.
  OutFile2 << "Catches" << endl << elem_prod(nloglike(1),catch_emphasis) << endl;
  OutFile2 << "Index" << endl << elem_prod(nloglike(2),cpue_emphasis) << endl;
  OutFile2 << "Size-compositions" << endl << elem_prod(nloglike(3),lf_emphasis) << endl;
  OutFile2 << "Recruitment_penalities" << endl << nloglike(4) << endl;
  OutFile2 << "Tagging_data" << endl << nloglike(5) << endl;
  OutFile2 << "Initial_size-structure" << endl << TempSS << endl;
  OutFile2 << "Other_penalties" << endl << elem_prod(nlogPenalty,Penalty_emphasis) << endl;
  OutFile2 << "Total" << endl << objfun << endl;
  OutFile2 << endl;

  if (datafile == "BBRKC.dat") //added by Jie: output fishing mortalities, selectivities & retained proportions to report file, total 27 lines
  { 
    dvar_matrix ft_pot(1,nsex,syr,nyr);     
    dvar_matrix ft_trawl(1,nsex,syr,nyr);   
    dvar_matrix ft_tanner(1,nsex,syr,nyr);  
    dvar_matrix ft_fixed(1,nsex,syr,nyr);   
    for (int h=1;h<=nsex;h++)               
     for (int i=syr;i<=nyr;i++)             
      {
        ft_pot(h,i) = ft(1,h,i,3);
        ft_trawl(h,i) = ft(2,h,i,5);
        ft_tanner(h,i) = ft(3,h,i,5);
        ft_fixed(h,i) = ft(4,h,i,5);               
      }
    //REPORT(ft_pot);                         
    //REPORT(ft_trawl);                       
    //REPORT(ft_tanner);                      
    //REPORT(ft_fixed); 
  }      

  OutFile2 << "selectivity" << endl; 
  for ( int h = 1; h <= nsex; h++ ) for ( int j = 1; j <= nfleet; j++ )
    OutFile2 << syr << " " << h << " " << j << " " << mfexp(log_slx_capture(j,h,syr)) << endl; 
  for ( int h = 1; h <= nsex; h++ ) for ( int j = 1; j <= nfleet; j++ )
    OutFile2 << nyr << " " << h << " " << j << " " << mfexp(log_slx_capture(j,h,nyr)) << endl; 
  OutFile2 << "retained" << endl; 
  OutFile2 << syr << " " << "1" << " " << "1" << " " << mfexp(log_slx_retaind(1,1,syr)) << endl;  
  OutFile2 << nyr << " " << "1" << " " << "1" << " " << mfexp(log_slx_retaind(1,1,nyr)) << endl;               
 
  if (nSizeComps != nSizeComps_in)              
   nnnn = nSizeComps;                           
  else                                          
   nnnn = nSizeComps_in;                        
  for ( int kk = 1; kk <= nnnn; kk++ )          
   {
    OutFile2<<"d3_obs_size_comps_"<<kk<<endl;
    OutFile2<<d3_obs_size_comps(kk)<<endl;                          
   } 
  for ( int kk = 1; kk <= nnnn; kk++ )          
   {
    OutFile2<<"d3_pre_size_comps_"<<kk<<endl;
    OutFile2<<d3_pre_size_comps(kk)<<endl;                                    
   } 
  for ( int kk = 1; kk <= nnnn; kk++ )          
   {
    OutFile2<<"d3_res_size_comps_"<<kk<<endl;
    OutFile2<<d3_res_size_comps(kk)<<endl;                                     
   }    


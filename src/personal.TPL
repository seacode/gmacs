FUNCTION MyOutput
  int nnnn;
 

  // Likelihood summary. Added by Jie, total 10 lines.
  OutFile3 << "Catches" << endl << elem_prod(nloglike(1),catch_emphasis) << endl;
  OutFile3 << "Index" << endl << elem_prod(nloglike(2),cpue_emphasis) << endl;
  OutFile3 << "Size-compositions" << endl << elem_prod(nloglike(3),lf_emphasis) << endl;
  OutFile3 << "Recruitment_penalities" << endl << nloglike(4) << endl;
  OutFile3 << "Tagging_data" << endl << nloglike(5) << endl;
  OutFile3 << "Initial_size-structure" << endl << TempSS << endl;
  OutFile3 << "Other_penalties" << endl << elem_prod(nlogPenalty,Penalty_emphasis) << endl;
  OutFile3 << "Total" << endl << objfun << endl;
  OutFile3 << endl;

  if (datafile == "BBRKC.dat") //added by Jie: output fishing mortalities, selectivities & retained proportions to report file, total 27 lines
  { 
    dvar_matrix ft_pot(1,nsex,syr,nyrRetro);     
    dvar_matrix ft_trawl(1,nsex,syr,nyrRetro);   
    dvar_matrix ft_tanner(1,nsex,syr,nyrRetro);  
    dvar_matrix ft_fixed(1,nsex,syr,nyrRetro);   
    for (int h=1;h<=nsex;h++)               
     for (int i=syr;i<=nyrRetro;i++)             
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

  OutFile3 << "selectivity" << endl; 
  for ( int h = 1; h <= nsex; h++ ) for ( int j = 1; j <= nfleet; j++ )
    OutFile3 << syr << " " << h << " " << j << " " << mfexp(log_slx_capture(j,h,syr)) << endl; 
  for ( int h = 1; h <= nsex; h++ ) for ( int j = 1; j <= nfleet; j++ )
    OutFile3 << nyrRetro << " " << h << " " << j << " " << mfexp(log_slx_capture(j,h,nyrRetro)) << endl; 
  OutFile3 << "retained" << endl; 
  OutFile3 << syr << " " << "1" << " " << "1" << " " << mfexp(log_slx_retaind(1,1,syr)) << endl;  
  OutFile3 << nyrRetro << " " << "1" << " " << "1" << " " << mfexp(log_slx_retaind(1,1,nyrRetro)) << endl;               
 
  if (nSizeComps != nSizeComps_in)              
   nnnn = nSizeComps;                           
  else                                          
   nnnn = nSizeComps_in;                        
  for ( int kk = 1; kk <= nnnn; kk++ )          
   {
    OutFile3<<"d3_obs_size_comps_"<<kk<<endl;
    OutFile3<<d3_obs_size_comps(kk)<<endl;                          
   } 
  for ( int kk = 1; kk <= nnnn; kk++ )          
   {
    OutFile3<<"d3_pre_size_comps_"<<kk<<endl;
    OutFile3<<d3_pre_size_comps(kk)<<endl;                                    
   } 
  for ( int kk = 1; kk <= nnnn; kk++ )          
   {
    OutFile3<<"d3_res_size_comps_"<<kk<<endl;
    OutFile3<<d3_res_size_comps(kk)<<endl;                                     
   }    


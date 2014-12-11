#include <admodel.h>
/*

  A little program to show how to calculate the initial
  equilbriubrium population. For fun fish are allowed to shrink a bit.
  the recruitment is normalized to 1 fish spread out over the first 5
  length intervals

  Change n to a number larger than 10 to increase the number of intervals.

*/

#undef COUT
#define COUT(object) cout << #object "\n" << setw(6) \
<< setprecision(3) << setfixed() << object << endl;


int main(int charc, char * argv[])
{
  int n=10;
  double m = 0.3;
  
  dmatrix At(1,n,1,n); // At is the transpose of the matrix A
                       // caus' easier to work with.
  dmatrix Id=identity_matrix(1,n);
  dvector x(1,n);
  dvector r(1,n);
  dvector p(1,n);      // probability of molting.
  dvector os(1,n);     // oldshell
  dvector ns(1,n);     // newshell
  x.initialize();
  r.initialize();
  p.initialize();
  At.initialize();
  dvector bin(1,n);
  bin.fill_seqadd(1,1);

  // recruitment is like a litte normal bump over the first 5 intervals
  r(1)=1.0;
  r(2)=2.0;
  r(3)=3.0;
  r(4)=2.0;
  r(5)=1.0;

  r/=sum(r); // normalize to a total recruitment of 1
  
  // probability of molting
  p = 1.0 / (1.0+exp(-(3.0-bin)/0.85));
  COUT(p);

  for (int i=1;i<=n;i++)
  {
    for (int j=i;j<=i+10;j++)   // permit a bit of shrinkage
    {
      if ( j>=1 && j<=n )
       At(i,j)=(1.0/j);
    }
    At(i)/=1.00*sum(At(i));
    // At(i)/=sum(At(i));
  }

  // Replace diagonal of size transition matrix with the probability of molting.
  for (int i = 1; i <= n; ++i)
  {
     At(i,i) = p(i);
  }

  COUT(rowsum(trans(At)));

  dmatrix A=trans(At);  // now transpose to get A
  dmatrix G=trans(At);
  COUT(A);

  //dvector lx(1,n);
  for(int i=1;i<=n;i++)
  {
    //lx(i) = exp(-m*(i-1.0));
    A(i) *= exp(-m);
    //if(i==n) A(i)/=(1.-exp(-m));
  }

  // numerical soln.
  int count = 500;
  dvector N(1,n);
  N.initialize();
  for(int iter = 1; iter <= count; iter++ )
  {
    N = A*N  + r;
  }
    
  COUT(A);
  cout << endl;
  
  COUT(rowsum(A));
  COUT(colsum(A));

  COUT(r);
  cout << endl;


  x=-solve(A-Id,r);

  ns = elem_prod(diagonal(G),x);
  os = elem_prod(1.-diagonal(G),x);

  cout << endl;
  COUT(N);
  COUT(x)
  COUT(A*x+r);
  COUT(os);
  COUT(ns);
  COUT(sum(os+ns));

  COUT(sum(N));
  COUT(sum(x));
  cout << endl;
  cout << "||A*x+r-x||^2" << endl;
  cout << "The next number should equal 0.0 it actually equals "  << norm2(A*x+r-x) << endl;

}
    	

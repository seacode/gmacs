testCode0 <- function()
{
  InitN <- c(1274.5,911.549,1467.16)
  N <- matrix(0,ncol=3,nrow=7)
  M <- 0.18
  Rec1 <- c(1150.65,725.712,256.121,425.332,317.523,322.662)
  TM <- matrix(c(0.2,0.7,0.1,0,0.4,0.6,0,0,1.0),byrow=T,ncol=3,nrow=3)
  print(TM)
  
  N[1,] <- InitN
  
  for (II in 1:6)
   {
    NN <- N[II,]*exp(-M) 
    N[II+1,1] <- TM[1,1]*NN[1] + Rec1[II]
    N[II+1,2] <- TM[1,2]*NN[1] + TM[2,2]*NN[2]
    N[II+1,3] <- TM[2,3]*NN[2] + NN[3]
    print(N[II+1,])
   }  
    
  
  
  print(N)
  
  
}

testCodeA <- function()
{
  InitN <- c(3782.35,2419.47,1678.34)
  N <- matrix(0,ncol=3,nrow=7)
  M <- 0.18
  Rec1 <- c(4223.69,3411.4,1051.53,1588.53,709.932,705.147)
  TM <- matrix(c(0.2,0.7,0.1,0,0.4,0.6,0,0,1.0),byrow=T,ncol=3,nrow=3)
  print(TM)
  
  SelFish <- c(0.416198,0.657528)
  hm1 <- 0.2
  fpf <- c(0.305351,0.0245982,0.0103358,0.259886,0.526267,0.859658)
  fg <- c(1.64416e-005,5.74921e-005)
  lags <- c(0.07,0.06,0.07,0.05,0.07,0.12)
  
  N[1,] <- InitN
  Mort <- c(0,3)
  
  for (II in 1:6)
  {
    N2 <- N[II,]*exp(-M*lags[II]) 
    SF <- 1-exp(-fpf[II])
    Mort[1] <- N2[1]*SF*SelFish[1]*hm1
    Mort[2] <- N2[2]*SF*SelFish[2]*hm1
    Mort[3] <- N2[3]*SF

    N3 <- (N2 - Mort)*exp(-M*(0.63-lags[II]))
    NN <- N3 * exp(-fg[1]-fg[2])
    NN <- NN *exp(-0.37*M)
    
    N[II+1,1] <- TM[1,1]*NN[1] + Rec1[II]
    N[II+1,2] <- TM[1,2]*NN[1] + TM[2,2]*NN[2]
    N[II+1,3] <- TM[2,3]*NN[2] + NN[3]
    print(N[II+1,])
  }  
  
  
  
  print(N)
  
  
}


testCodeA()



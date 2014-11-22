read.admb <-
function(ifile)
{	
	ret=read.fit(ifile)
	
	fn=paste(ifile,'.rep', sep='')
	A=read.rep(fn)
	A$fit=ret
	
	pfn=paste(ifile,'.psv',sep='')
	if(file.exists(pfn))
		A$post.samp=read.psv(pfn)
	
	return(A)
}

read.fit <-
function(ifile)
{
	# __Example:             
	#	file <-("~/admb/simple")
	#	A <- reptoRlist(file)
	#	Note there is no extension on the file name.
	
	## The following is a contribution from:
	## Anders Nielsen that reads the par & cor files.
	ret<-list() 
	parfile<-as.numeric(scan(paste(ifile,'.par', sep=''),   
	 what='', n=16, quiet=TRUE)[c(6,11,16)]) 
	ret$nopar<-as.integer(parfile[1]) 
	ret$nlogl<-parfile[2] 
	ret$maxgrad<-parfile[3] 
	file<-paste(ifile,'.cor', sep='')
	if(file.exists(file))
	{
		lin<-readLines(file) 
		ret$npar<-length(lin)-2 
		ret$logDetHess<-as.numeric(strsplit(lin[1], '=')[[1]][2]) 
		sublin<-lapply(strsplit(lin[1:ret$npar+2], ' '),function(x)x[x!='']) 
		ret$names<-unlist(lapply(sublin,function(x)x[2])) 
		ret$est<-as.numeric(unlist(lapply(sublin,function(x)x[3]))) 
		ret$std<-as.numeric(unlist(lapply(sublin,function(x)x[4]))) 
		ret$cor<-matrix(NA, ret$npar, ret$npar) 
		corvec<-unlist(sapply(1:length(sublin), function(i)sublin[[i]][5:(4+i)])) 
		ret$cor[upper.tri(ret$cor, diag=TRUE)]<-as.numeric(corvec) 
		ret$cor[lower.tri(ret$cor)] <- t(ret$cor)[lower.tri(ret$cor)] 
		ret$cov<-ret$cor*(ret$std%o%ret$std)		
	}
	return(ret)
}

read.rep <- 
function(fn)
{
	# The following reads a report file
	# Then the 'A' object contains a list structure
	# with all the elemements in the report file.
	# In the REPORT_SECTION of the AMDB template use 
	# the following format to output objects:
	#  	report<<"object \n"<<object<<endl;
	#
	# The part in quotations becomes the list name.
	# Created By Steven Martell

	# A slight problem with read.table for ragged objects. read.table only
	# scans the first 5 rows to determine the number of colums.  FIX developed Sep 5 2013


	options(warn=-1)  #Suppress the NA message in the coercion to double
	
	
	ifile=scan(fn,what="character",flush=TRUE,blank.lines.skip=FALSE,quiet=TRUE)
	idx=sapply(as.double(ifile),is.na)
	vnam=ifile[idx] #list names
	# cat(vnam)
	nv=length(vnam) #number of objects
	A=list()
	ir=0
	for(i in 1:nv)
	{
		ir=match(vnam[i],ifile)
		if(i!=nv) irr=match(vnam[i+1],ifile) else irr=length(ifile)+1 #next row
		dum=NA
		if(irr-ir==2) dum=as.double(scan(fn,skip=ir,nlines=1,quiet=TRUE,what=""))
		if(irr-ir>2)
		{
			# ncols <- 0
			# irows <- ir:irr-1
			# for(j in irows)
			# {
			# 	tmp=as.double(scan(fn,skip=j,nlines=1,quiet=TRUE,what=""))
			# 	if(length(tmp)>ncols) ncols <- length(tmp)
			# 	#print(paste(1:ncols))
			# }
			# cname <- paste(1:ncols)
			# dum=as.matrix(read.table(fn,skip=ir,nrow=irr-ir-1,fill=TRUE,col.names=cname))
			# cat("\n ir ",ir," irr ",irr)
			dum=as.matrix(read.table(fn,skip=ir,nrow=irr-ir-1,fill=TRUE,row.names = NULL))
		} 
			

		if(is.numeric(dum))#Logical test to ensure dealing with numbers
		{
			A[[vnam[i]]]=dum
		}
	}
	options(warn=0)
	
	return(A)
}

read.psv <-
function(fn, nsamples=10000)
{
	#This function reads the binary output from ADMB
	#-mcsave command line option.
	#fn = paste(ifile,'.psv',sep='')
	filen <- file(fn, "rb")
	nopar <- readBin(filen, what = integer(), n = 1)
	mcmc <- readBin(filen, what = numeric(), n = nopar * nsamples)
	mcmc <- matrix(mcmc, byrow = TRUE, ncol = nopar)
	close(filen)
	return(mcmc)
}

# A simple function for creating transparent colors
# Author: Nathan Stephens (hacks package)
colr <- 
function(col.pal=1,a=1)
{
    col.rgb<-col2rgb(col.pal)/255
    rgb(t(col.rgb),alpha=a)
}

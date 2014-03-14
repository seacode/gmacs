reptoRlist = function(fn)
{
	# Function to read a report file with file name fn
	# Example:             
	#	fn <-("~/admb/simple.rep")
	#	A <- reptoRlist(fn)
	#
	# Then the 'A' object contains a list structure
	# with all the elemements in the report file.
	# In the REPORT_SECTION of the AMDB template use 
	# the following format to output objects:
	#  	report<<"object \n"<<object<<endl;
	#
	# The part in quotations becomes the list name.
	#
	#/**
	#\def REPORT(object)
	#Prints name and value of \a object on ADMB report %ofstream file.
	#*/
	# Use the following macro in the GLOBALS_SECTION to
	# simplify the syntax for the Report section for outputing
	# objects to a file.  Thanks to John Sibert.
	# undef REPORT
	# define REPORT(object) report << #object "\n" << object << endl;
	
	
	# Created By Steven Martell
ifile=scan(fn,what="character",flush=T,blank.lines.skip=F,quiet=T)
idx=sapply(as.double(ifile),is.na)
vnam=ifile[idx] #list names
nv=length(vnam) #number of objects
A=list()
ir=0
for(i in 1:nv)
	{
		ir=match(vnam[i],ifile)
		if(i!=nv) irr=match(vnam[i+1],ifile) else irr=length(ifile)+1 #next row
		dum=NA
		if(irr-ir==2) dum=as.double(scan(fn,skip=ir,nlines=1,quiet=T,what=""))
		if(irr-ir>2) dum=as.matrix(read.table(fn,skip=ir,nrow=irr-ir-1,fill=T))

		if(is.numeric(dum))#Logical test to ensure dealing with numbers
		{
		A[[vnam[i]]]=dum
		}
	}
return(A)
}
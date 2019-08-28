



table_catch<-function(M)
{
#==get catch 
mdf <- .get_catch_df(M)

#==massage catch
library(reshape2)
casted = dcast( mdf , year~fleet )

#==table catch
kable(casted) 
}



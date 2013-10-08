# The following R-script is for generating a R-Gui for the
# generic crab model.

guiView <-
function()
{
	.gcmView("Generic Crab Model")
}

.gcmView <-
function( winName )
{
	# Requires PBSmodelling Library
	require(PBSmodelling)
	
	graphics.off()
	closeWin()
	
	createWin("gcmWin.txt")
}

.mpdView <-
function() 
{
	cat(".mpdView") <- getWinVal(scope="L")
	
	guiChanges <- list()
	
	# Determin appropriate plot based on plotType variable
	
	A=read.admb("GCM")
	if ( plotType=="catch" )
	{
		.plotCatch(A)
	}
	if ( plotType=="cpue" )
	{
		.plotCPUE(A)
	}
	if ( plotType=="lenf" )
	{
		.plotLF(A)
	}
	if ( plotType=="lenfr" )
	{
		.plotLFR(A)
	}
	if ( plotType=="mmb" )
	{
		.plotMMB(A)
	}
	
}

.savePDF <-
function()
{
	# save all plots to a pdf file
	pdf(file="Test.pdf")
		A=read.admb("GCM")
		.plotCatch(A)
		.plotCPUE(A)
		.plotLF(A)
		.plotLFR(A)
		.plotMMB(A)
	dev.off()
}
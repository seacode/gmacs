#' Plot Gmacs on shiny app
#'
#' @param replist List object created by read_admb function
#' @export
shiny_gmacs <- function(gmrep) {
  shinyApp( ui = pageWithSidebar(
  # Application title
  headerPanel("Gmacs Model Outputs"),
  sidebarPanel(
	  selectInput('plotType',"Select variable to plot",
	  		c(	 "Spawning Biomass",
	  	  	   "Fit to Index Data",
	  		  	 "Retained Catch",
	  	  	   "Retained Catch Residuals",
	  	  	   "Growth Transition",
             "Growth curve",
	  	  	   "Natural Mortality",
	  	  	   "Size Composition"
	  	  	   ),
	  		selected="Mature Male Biomass")),
  # Show plot 
  mainPanel( plotOutput("distPlot") ) ), 
server = function(input, output) { output$distPlot <- renderPlot(
    if(input$plotType == "Spawning Biomass")
  		plot_ssb(gmrep)
    else if(input$plotType == "Recruitment")
			plot_recruitment(gmrep)
    else if(input$plotType == "Growth Transition")
			plot_sizetransition(gmrep)
    else if(input$plotType == "Growth curve")
      plot_growth(gmrep)
    else if(input$plotType == "Natural Mortality")
			plot_naturalmortality(gmrep)
    else if(input$plotType == "Retained Catch")
      plot_catch(gmrep)
    else if(input$plotType == "Retained Catch Residuals")
      plot_catch(gmrep,plot_res=T)
    #else if(input$plotType == "Discarded Catch")
      #print(pCatch[[2]] + .THEME)
    else if(input$plotType == "Fit to Index Data")
			plot_cpue(gmrep)
    	#plot_sizecomp(gmrep,which_plots=c(1))
			#plot_sizecomp(gmrep,which_plots=c(11))
			#plot_sizecomp_res(gmrep)
			#plot_selectivity(gmrep)
    else if(input$plotType == "Size Composition")
    	plot_sizecomp(gmrep,which_plots=c(1))
    )
  }
 )
}
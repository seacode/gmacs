library(shiny)

# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(

  # Application title
  headerPanel("Generalized Model for Alaskan Crab Stocks"),

  # Sidebar with a slider input for number of observations
  sidebarPanel(
    # sliderInput("obs", 
    #             "Number of observations:", 
    #             min = 1,
    #             max = 1000, 
    #             value = 500)
	   selectInput('plotType',"Select variable to plot",
	  		c(	 "Mature Male Biomass",
	  		  	 "Retained Catch",
	  	  	   "Discarded Catch",
	  	  	   "CPUE trends",
	  	  	   "Size Composition",
	  	  	   "Retained Catch Residuals"),
	  		selected="Mature Male Biomass")
  ),

  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("distPlot")
  )
))
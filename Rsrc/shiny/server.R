library(shiny)
load("data/BBRKC.Rdata")
source("helpers.R")

# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {

  # Expression that generates a plot of the distribution. The expression
  # is wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically 
  #     re-executed when inputs change
  #  2) Its output type is a plot 
  #
  # output$distPlot <- renderPlot({

  #   # generate an rnorm distribution and plot it
  #   dist <- rnorm(input$obs)
  #   hist(dist)
  # })

  output$distPlot <- renderPlot({
    if(input$plotType == "Mature Male Biomass")
    {
      print(pMMB + .THEME)
    }
    if(input$plotType == "Retained Catch")
    {
      print(pCatch[[1]] + .THEME)
    }
    if(input$plotType == "Retained Catch Residuals")
    {
      print(pCatchRes[[1]] + .THEME)
    }
  
    if(input$plotType == "Discarded Catch")
    {
      print(pCatch[[2]] + .THEME)
    }
    if(input$plotType == "CPUE trends")
    {
      print(pCPUEfit + .THEME)
    }
    
    if(input$plotType == "Size Composition")
    {
      print(pSizeComps[1])
    }


  })

})
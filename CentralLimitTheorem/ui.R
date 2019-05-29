library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("cosmo"),
  
  titlePanel("Central limit theorem"),
  
  sidebarLayout(
    sidebarPanel(
       sliderInput("losowania",
                   "Number of replications:",
                   min = 1,
                   max = 50000,
                   value = 1000),
    sliderInput("proba",
                "Sample size:",
                min = 1,
                max = 100,
                value = 50),
    sliderInput("mu1",
                "Mean of the first population:",
                min = 0,
                max = 200,
                value = 30),
    sliderInput("sigma1",
                  "Standard deviation of the first population:",
                  min = 0,
                  max = 30,
                  value = 1),
    sliderInput("mu2",
                "Mean of the second population:",
                min = 0,
                max = 200,
                value = 30),
    sliderInput("sigma2",
                "Standard deviation of the second population:",
                min = 0,
                max = 30,
                value = 1)),
        
    # Show the plots of the generated distribution
    mainPanel(
      # h4(textOutput("title"), align='center'),
       plotOutput("wykresikCTG")
    )
  )
))

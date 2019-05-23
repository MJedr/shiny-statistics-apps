#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({

    n = input$n
    
    my_data = runif(n, 0, 1)
    
    n = length(my_data)
    
    means <- replicate(input$num,
                       mean(sample(my_data, replace = T, size = input$num_boot)))
    
    
    ci <- qnorm(c(input$ci/2, 1-(input$ci[1]/2)), mean(means), sd(means))
    print(ci)
    
    hist(means, col = 'skyblue',
         breaks = seq(min(means), max(means), by = (max(means)- min(means))/30))
    abline(v=ci[1], col='red')
    abline(v=ci[2],  col='red')
    
  })
  
})

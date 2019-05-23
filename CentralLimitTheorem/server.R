library(shiny)

shinyServer(function(input, output) {
  losowanie <- function(replikacje, n, mu, sigma) {
    sim = replicate(replikacje, {
      sample_mean = mean(rnorm(n, mu, sigma))
      
    })
    return(sim)
  }
  
  output$title <- renderText({paste(
    "n1=",
    input$proba,
    ", mu= ",
    input$mu1,
    ", sigma=",
    input$sigma1,
    "\n",
    " n2=",
    input$proba,
    ", mu= ",
    input$mu2,
    ", sigma=",
    input$sigma2
  )})

  output$wykresikCTG <- renderPlot({
    sim1 = losowanie(as.numeric(input$losowania), as.numeric(input$proba), as.numeric(input$mu1), as.numeric(input$sigma1))
    sim2 = losowanie(as.numeric(input$losowania), as.numeric(input$proba), as.numeric(input$mu2), as.numeric(input$sigma2))
    
    if (input$mu1 > input$mu2) {
      limits = c(qnorm(0.001, as.numeric(input$mu2), as.numeric(input$sigma2)),
                 qnorm(0.999, as.numeric(input$mu1), as.numeric(input$sigma1)))
    }
    else if (input$mu2 >= input$mu1) {
      limits = c(qnorm(0.001, as.numeric(input$mu1), as.numeric(input$sigma1)),
                 qnorm(0.999, as.numeric(input$mu2), as.numeric(input$sigma2)))
    }
    
    hist(
      sim1,
      prob = T,
      col = adjustcolor('red', alpha.f = 0.5),
      xlim = limits,
      xlab=NULL,
      main="")
      hist(
            sim2,
            prob = T,
            add = T,
            col = adjustcolor('blue', alpha.f = 0.5)
          )
          curve(
            dnorm(x, input$mu1, input$sigma1),
            from = -100,
            to = 300,
            col = 'red',
            add = TRUE
          )
          curve(
            dnorm(x, input$mu2, input$sigma2),
            from = -100,
            to = 300,
            col = 'blue',
            add = TRUE
          )
    })
  })


library(shiny)
library(shinyjs)
library(MASS)
library(ggplot2)


shinyServer( 
  function(input, output) {
  
    howManyLifes <- reactiveValues(countervalue = 3)
    howManyPoints <- reactiveValues(countervalue = 0)
    
    lifes <- eventReactive(input$checkButton, {
      if(as.numeric(input$corr) != randomCor()){
        howManyLifes$countervalue =  howManyLifes$countervalue-1}
    })
    
    endGame <- eventReactive(input$checkButton, {
      if(lifes()<=0){return(T)}
      else{return(F)}
    })
    
    points <- eventReactive(input$checkButton, {
      if(as.numeric(input$corr) != randomCor()){
        howManyPoints$countervalue =  howManyPoints$countervalue}
      else{howManyPoints$countervalue =  howManyPoints$countervalue+1}
    })

    observeEvent(lifes(), {
      if(lifes() <= 0){
      showModal(modalDialog(
        title = "you lose",
        "I am sorry, but this is the end of the game!",
        easyClose = TRUE
      ))}
  })

    randomCorStart<-eventReactive(input$goButton,{
      correlation=round(runif(1, 0, 1), 2)
      return(correlation)
  })
    
    randomValsStart<-eventReactive(input$goButton,{
      vals <- mvrnorm(100, c(0, 0), matrix(c(1, randomCorStart(),
      randomCor(), 1^2), nrow=2))
      return(vals)
  })
    
    output$cor_plotStart<-renderPlot({
      plot(randomValsStart())
  })
    
  randomCor<-eventReactive(input$nextButton,{
    correlation=round(runif(1, 0, 1), 2)
    return(correlation)
  })
  
  randomVals<-eventReactive(input$nextButton,{
    vals <- mvrnorm(100, c(0, 0), matrix(c(1, randomCor(), randomCor(), 1^2), nrow=2))
    vals <- data.frame(vals)
    return(vals)
  })

  output$cor_plot<-renderPlot({
    ggplot(randomVals(), aes(X1, X2)) + geom_point() + theme_minimal() +
      theme(axis.title = element_blank())
  })
  
  getCor<-eventReactive(input$checkButton, {
    return(randomCor())
  })
  
  observeEvent(input$checkButton, {
    output$guessedCorr<-renderText(paste("Your answer: ", input$corr))
  })
  
  observeEvent(input$checkButton, {
    output$trueCor<-renderText(paste("True answer: ", getCor()))
  })
  
  output$life <- renderText({
    paste("Lifes: ", lifes())
  })
  
  output$point <- renderText({
    paste("Points: ", points())
  })
  
  observeEvent(input$startButton, {
    howManyLifes$countervalue =  3
  })
  
  output$start_message<-renderText({"To show the first plot and start a round click 'next'!"})
  
  observeEvent(input$startButton,{
   {show("start_message")}
  })
  
  observeEvent(input$nextButton,{
    {hide("start_message")}
  })
 

})
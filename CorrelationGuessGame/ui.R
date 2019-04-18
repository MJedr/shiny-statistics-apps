library(shiny)
library(shinythemes)

shinyUI(navbarPage("Correlation!",
  theme = shinytheme("flatly"),
  tabPanel("About", fluidRow(
    column(2),
    column(8,
           includeMarkdown("text.md")
    ))),
  tabPanel("Let's play",
  div(id = "myapp",
  tags$br(),
  sidebarPanel(
    useShinyjs(),
    actionButton("startButton", "Start a new game!"),
    tags$br(),
    tags$br(),
    textInput('corr', 'Your answer', value = 0.0),
    tags$br(),
    actionButton("checkButton", "Check!"),
    actionButton("nextButton", "Next!"),
    tags$br(), tags$br(),
    verbatimTextOutput("guessedCorr"),
    verbatimTextOutput("trueCor"),
    textOutput("life"),
    textOutput("point"),
    hidden(
      div(id='text_div',
          verbatimTextOutput("text")
      )
  )), 
  mainPanel(
    h4(textOutput("start_message"), align='center'),
    plotOutput("cor_plot"),
    plotOutput("cor_plotStart")
    ))

))
)
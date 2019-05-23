library(shiny)
library(shinythemes)


# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("united"),
  
  navbarPage(
    "BOOT IT!",
    tabPanel("about", 
             mainPanel(align = "justify",
            h2("An app to check out bootstrap technique"),
            tags$p("One day, when I was experimenting a bit with bootstrap I came up
             with conclusion - hey, when I change the bootstrap sample size, the 
                                  confidence intervals are so different!
              It turned out that the bootstrap sample size should be as big as possible,
              so it has to have the same size as our data sample, because according to the
              bootstrap definition:"),
            tags$p(tags$strong("The bootstrap is a computer-based method for assigning measures of accuracy to statistical estimates,")), 
              tags$p("and so, accuracy depends on sample size."),
            tags$p(
            tags$a(href="https://stats.stackexchange.com/questions/263710/why-should-boostrap-sample-size-equal-the-original-sample-size", 
                   "A good explanation of such rule you might find in here!")),
            tags$p("So, in this app you have possibility to experiment a bit and find out how the
                   confidence interval is becoming bigger when decreasing sample size. Have fun!"))
               ),
    tabPanel("bootstrap it!",
    sidebarPanel(
       sliderInput("n",
                   "Sample size:",
                   min = 10,
                   max = 100,
                   value = 30),
       selectInput("dist", label = "Distribution", 
                   choices = list("Normal" = "norm", "Uniform" = "unif"), 
                   selected = "norm"),
       numericInput("num", label = "Number of replications", value = 10000),
       numericInput("num_boot", label = "Number of observations in bootstrap sample", value = 30),
       sliderInput("ci",
                   "Confidence interval:",
                   min = 0,
                   max = 0.2,
                   value = 0.05)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot"),
       tableOutput("dataTable")
    )
  )
)))

#install.packages('shiny')
library(shiny)
setwd("C:/Users/oknjav001/Documents/app")

#Building the app template
ui <- fluidPage(sliderInput(inputId = "num",label = "Choose a number",value = 10, min = 1, max = 50), plotOutput("hist"))
#ui <- fluidPage(fileInput(inputId = "text",label = "Choose MaxQuont txt folder"))
#Server <- function(input, output) {output$hist <- renderPlot({hist(rnorm(100))})}
Server <- function(input, output) {output$hist <- renderPlot({hist(rnorm(input$num))})}
shinyApp(ui=ui,server=Server)

#Installing rsconnect
#install.packages('rsconnect')
rsconnect::setAccountInfo(name='javan', token='959F388954204A2C38F5E2204567EC6F', secret='GQOFxtR3ygpEv2Ac/+z8HuWeKm72xVuZBYO2DSYs')

library(rsconnect)
rsconnect::deployApp('C:/Users/oknjav001/Desktop/app')


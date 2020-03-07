
#install.packages('shiny')
library(shiny)


#Building the app template
ui <- fluidPage(sliderInput(inputId = "num",label = "Choose a number",value = 10, min = 1, max = 50), plotOutput("hist"))
#ui <- fluidPage(fileInput(inputId = "text",label = "Choose MaxQuont txt folder"))
#Server <- function(input, output) {output$hist <- renderPlot({hist(rnorm(100))})}
Server <- function(input, output) {output$hist <- renderPlot({hist(rnorm(input$num))})}
shinyApp(ui=ui,server=Server)

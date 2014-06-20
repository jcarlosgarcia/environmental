library(shiny)
library(lattice)

data(environmental)

# Prediction function. Fits a polynomial surface using local fitting
# Predict the outcome given the ozone value
predictEnvironmental <- function(outcome, ozone) { 
  modelFit <- loess(outcome ~ environmental$ozone)
  predict(modelFit, ozone)
}

shinyServer(
  function(input, output) {
    outcome <- reactive({
      switch(input$outcome,
             "radiation" = environmental$radiation,
             "temperature" = environmental$temperature,
             "wind" = environmental$wind)
    })
    output$inputValue <- renderPrint({input$ozone})
    output$prediction <- renderPrint({predictEnvironmental(outcome(), input$ozone)})
    
    output$regressionFit <- renderPlot({
      print(xyplot(outcome() ~ ozone, data = environmental, pch = 20,
             panel = function(x, y, ...) {
               panel.xyplot(x, y, ...)
               panel.loess(x, y, lwd = 3)
               panel.points(x = input$ozone, y = predictEnvironmental(outcome(), input$ozone), col = 'darkorange', pch = 4, cex = 2, lwd = 5)
             })
      )
    })

  }
)
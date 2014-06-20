library(shiny)
library(lattice)

shinyUI(
  pageWithSidebar(

    headerPanel("Environmental prediction"),
    sidebarPanel(
      h2('Instructions'),
      p('This app predicts the radiation, temperature or wind values using the ozone as a predictor.'),
      p('Select an outcome variable from the dropdown list (radiation, temperature or wind) and move the slider to change the ozone parts per billion.'),
      p('The results of the prediction are shown on the right panel.'),
      p('A graph is displayed on the right panel with the outcome values in the y-axis and the ozone parts per billion in the x-axis.'),
      p('The orange mark is placed at the predicted value on the regression line.'),
      p('You may change your outcome variable and/or the ozone parts per billion value to see how the predicted value and the graph are updated.')
    ),
    mainPanel(
      selectInput("outcome", "Choose an outcome variable:", 
                  choices = c("radiation", "temperature", "wind")),
      sliderInput('ozone', 'Ozone (parts per billion)', value = 25, min = 10, max = 150, step = 5),
      
      h3('Prediction Results'),
      h4('Ozone'),
      p('Your ozone parts per billion selected for the prediction.'),
      verbatimTextOutput('inputValue'),
      h4('Prediction'),
      p('Value predicted based on the outcome variable and the ozone value you selected.'),
      verbatimTextOutput('prediction'),
      p('The orange mark is the predicted value according to the outcome variable and the ozone value selected.'),
      plotOutput('regressionFit')
    )
  )
)
# Amanda Busch
# Daniel Goldberg
# Jacie Shuman
## Shiny Project ##
## All shiny apps use this template ##
##  1) It initializes an empty UI and an empty server, and runs an app using 
##    these empty parts. 
##  2) Copy this template into a new file named app.R in a new folder. 
##  3) It is very important that the name of the file is app.R, 
##    otherwise it would not be recognized as a Shiny app. 
##  4) It is also very important that you place this app in its own folder, and 
##  not in a folder that already has other R scripts or files, unless those other 
##  files are used by your app.

## After saving the file, RStudio should recognize that this is a Shiny app, and
## you should see the usual Run button at the top change to Run App.

rm(list = ls())  #clears data
library(shiny)

server <- function(input, output, session) {
  sliderValues <- reactive({
    data.frame(
      Plot = c("Graph 1",
               "Graph 2"),
      r_Value = as.character(c(input$b_input - input$d_input,
                               input$b2_input - input$d2_input)))
  })
  output$values <- renderTable({
    sliderValues()
  })
  output$Logistic_plot <- renderPlot({
    initial.time = 0         # starting time of the simulation
    final.time = 150         # ending time of the simulation
    tspan = seq(initial.time, final.time, by = 1)
    
    K = input$K_input
    N = input$N_input
    b = input$b_input
    d = input$d_input
    r = input$b_input - input$d_input
    
    exact = K / (1 + (((K-N)/N) * exp( -( r ) * tspan )))
    
    K2 = input$K2_input
    N2 = input$N2_input
    b2 = input$b2_input
    d2 = input$d2_input
    r2 = input$b2_input - input$d2_input
    
    exact2 = K2 / (1 + (((K2-N2)/N2) * exp( -( r2 ) * tspan )))
    
    
    #par(mfrow = c(2,1))
    par(las = 1)
    plot(tspan,exact,
         ylim = c(0,600),
         xlab = "Time",
         ylab = "Population",
         type = "l", lwd = 3,
         col = "green"
    )
    points(tspan,exact2,
    #     ylim = c(0,500),
    #     xlab = "Time",
    #     ylab = "Population",
         type = "l", lwd = 3,
         col = "blue"
    )  
    legend("topright", legend = c("Population 1","Population 2"), 
           lwd = 3, lty = 1, col = c("green","blue"), bty = "n")
  }, height = 400, width = 500)
}
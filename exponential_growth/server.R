#' Server
#' Exponential Growth
#' Ecological Modeling Leanring Module
#' Stuart R. Borrett
#' January 2018
#' ---------------------------------------

library(shiny)

server = function(input, output){
  # solves exponental growth model
  output$exponentialPlot <- renderPlot({
    tspan <- seq(0, input$tmax, by = 0.1)
    r = input$b - input$d
    solution <- input$N0 * exp( r * tspan)
    plot(tspan, solution, lwd = 2, type = "l", col = "orange",
         ylim = c(0,(max(solution)*1.1)),
         xlab = "Time (arbitrary units)",
         ylab = "Population size (individuals)",
         main = paste("Projected Exponential Populaiton Growth when r  = ", bquote(.(r))))
    points(c(0),c(input$N0), pch = 20, col = "darkorange", cex = 2.5)
    
  })
}
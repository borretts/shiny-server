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


ui <- fluidPage(
  #titlePanel("Logistic Growth Model"),
  sidebarLayout(
    sidebarPanel(	img(src = "harborseal.png", height = 287, width = 301),
                  br(),
                  br(),
                  br(),
                  br(),
                  h4("Guided Activities", style = "color: dark gray", align = "center"),
                  h5("1) Set N = 500 and K = 50."),
                  h5("What happens when b > d? 
                     What happens when d > b? Plot these scenarios on the 2 graphs
                     for comparison", style = "color:brown"),
                  h5("2) Set K = 500 and N =50."),
                  h5("What happens when b > d? 
                     What happens when d > b? Plot these scenarios on the 2 graphs
                     for comparison", style = "color:brown"),
                  h5("3) Make r positive and play with values of N and K"),
                  h5("4) Make r negative and play with values of N and K"),
                  sliderInput("K_input", "K =",
                              min = 0, max = 500,
                              value = 0
                  ),
                  sliderInput("b_input", "b =",
                              min = 0 , max = 1,
                              value = 0,
                              step = 0.05
                  ),
                  sliderInput("d_input", "d =",
                              min = 0, max = 1,
                              value = 0,
                              step = 0.05
                  ),
                  sliderInput("N_input", "N =",
                              min = 0, max = 500,
                              value = 0
                  ),
                  
                  br(),hr(style="border-color: black;"),br(),
                  
                  sliderInput("K2_input", "K =",
                              min = 0, max = 500,
                              value = 0
                  ),
                  sliderInput("b2_input", "b =",
                              min = 0 , max = 1,
                              value = 0,
                              step = 0.05
                  ),
                  sliderInput("d2_input", "d =",
                              min = 0, max = 1,
                              value = 0,
                              step = 0.05
                  ),
                  sliderInput("N2_input", "N =",
                              min = 0, max = 500,
                              value = 0
                  )
                  ),
    mainPanel(
      h1("Logistic Growth Model", align = "center", style = "color:brown"),
      h2("dn/dt = rN * (1-(N/K))", align = "center", style = "color:dark gray"),
      h3("Harbor seals in Washington state were thought to be a ferocious predator in the early 20th century. The government started a program that mandated they be hunted. After the program was shut down the seal population has grown back in the shape of a logistic growth model."),
      h2("Let’s explore the Logistic Growth Model!", align = "center"),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      tableOutput("values"),
      plotOutput("Logistic_plot"),
      tableOutput("results")
    )
    )
  )
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
    final.time = 100         # ending time of the simulation
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
    
    
    par(mfrow = c(2,1))
    
    plot(tspan,exact,
         ylim = c(0,500),
         xlab = "Time",
         ylab = "Population",
         type = "b",
         col = "green"
    )
    plot(tspan,exact2,
         ylim = c(0,500),
         xlab = "Time",
         ylab = "Population",
         type = "b",
         col = "blue"
    )  
  }, height = 850, width = 600)
}
shinyApp(ui = ui, server = server)

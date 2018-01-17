#' UI
#' Exponential Growth
#' Ecological Modeling Leanring Module
#' Stuart R. Borrett
#' January 2018
#' ---------------------------------------

library(shiny)

ui = fluidPage(
  
  titlePanel("Exponential Growth"),
  "This is an interactive learning module designed to help you better understand the exponential growth population model.  Upon completion, you sould be able to (1) identify the three primary types of population behavior that this model can produce, and (2) describe the effects of changing the model paraemters (b, d) and initial conditions (initial populaiton size N0).  You should also be able to explain how we use the exponential growth model to project future population size.",
  br(),br(),
  "Recall that the standard form of the exponential growth model is: ",
  tags$img(src = "exponential_growth.jpeg", height = 25), br(),
  "and when we integrate this differential equation, we obtain the following solution: ", 
  tags$img(src = "exponential_growth_solution.png", height = 15), 
  br(), br(),
  "This app solves the exponential growth model for the model parameters you select with the sliders and plots the projected population dynamics.  First, investigate what happens as you change the model parameters.  Then, follow the instuctions below to guide your model investigation.",br(),br(),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("b", "Birth Rate (b)",
                  min = 0, max = 3, value = 2.5, step = 0.1),
      sliderInput("d", "Death Rate (d)", 
                  min = 0, max = 3, value = 2.4, step = 0.1),
      sliderInput("N0", "Initial Population Size (N0)",
                  min = 1, max = 50, value = 5, step = 1),
      sliderInput("tmax", "Final time of simulation", 
                  min = 5, max = 1000, value = 10, step = 1)
    ),
    
    mainPanel(
      plotOutput("exponentialPlot")
    )
  ),
  
  h4("Guided Activites"),
  HTML("<ol>
       <li> Investigate the population dynamics when b > d.  What happens to r and the population dynamics as the difference between b and d increases? </li> 
       <li> When b>d, what happens when you change the initial population size?</li> <li> Investigate the population dynamics when b = d.  Under this condition, what happens when you change the initial population size?  </li> 
       <li>  Investigate what happens when b < d. In this case, what happens to r and the population dynamics as the difference between b and d increases?</li> 
       <li>   In your own words, summarize the major types of behavior that this model can generate.  Consider what model features determine these outcomes. </li> 
       <li>   Consider, under what conditions might real biological populations exhibit exponential growth?</li>
       </ol>"),
  h4("Assessment"),
  "Successful completion of these activities will be assessed in class using the audience response system.",
  hr("Acknowledgements"),
  "The Ecological Modeling Learning Module was developed by Stuart R. Borrett with support from an ETEAL Grant from the Unviversity of North Carolina Wilmington"
  )
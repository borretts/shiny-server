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
    sidebarPanel(	img(src = "harborseal.png", height = 200.9, width = 210.7),
#                  br(),
#                  br(),
#                  br(),
                  br(),
                  h5("Population 1"),   
                  sliderInput("K_input", "K =",
                              min = 0, max = 500,
                              value = 100, step = 1
                  ),
                  sliderInput("b_input", "b =",
                              min = 0 , max = 1,
                              value = 0.25, step = 0.05
                  ),
                  sliderInput("d_input", "d =",
                              min = 0, max = 1,
                              value = 0.15, step = 0.05
                  ),
                  sliderInput("N_input", "N =",
                              min = 0, max = 500,
                              value = 5, step = 1
                  ),
                  
                   hr(style="border-color: black;"), 
                  h5("Population 2"),
                  sliderInput("K2_input", "K =",
                              min = 0, max = 500,
                              value = 200, step = 1
                  ),
                  sliderInput("b2_input", "b =",
                              min = 0 , max = 1,
                              value = 0.15, step = 0.05
                  ),
                  sliderInput("d2_input", "d =",
                              min = 0, max = 1,
                              value = 0.1, step = 0.05
                  ),
                  sliderInput("N2_input", "N =",
                              min = 0, max = 500,
                              value = 500, step = 1
                  )
                  ),
    mainPanel(
      h1("Logistic Growth Model", align = "center", style = "color:brown"),
      #tags$img(src = "logistic.png", height = 40, align = "center"),
      div(img(src = "logistic.png", height = 40),style="text-align: center;"),
      #h2("dn/dt = rN * (1-(N/K))", align = "center", style = "color:dark gray"),
      "Harbor seals in Washington state were thought to be a ferocious predator in the early 20th century. The government started a program that mandated they be hunted. After the program was shut down the seal population has grown back in the shape of a logistic growth model.",
      h2("Let’s explore the Logistic Growth Model!", align = "center"),
#      br(),
#      br(),
 #     tableOutput("values"),
      plotOutput("Logistic_plot"),
      tableOutput("results"),
 br(),
h4("Guided Activities", style = "color: dark gray", align = "center"),
h5("1)  Effect of changing the birth (b) and death (d) rates."),
"First, set N = 500 and K = 50, then investigate what happens when b > d?  When b < d? Set the first population parameter to match the first scenario, and the second population pareterms to the second condition.  Explore how the population dynamics change in reponse to altering the parameters.",
#                   for comparison", style = "color:brown"),
h5("2) Effect of initial population size"),
"Make r positive and investigate the effects of changing the initial population size (N)", 
"What happens if r is negative and the initial population size changes?",
h5("3) Effect of chaning the carrying capacity (K)"),
"Make r positive and investigate the effects of changing the carrying capcity", 
"What happens if r is negative and the carrying capacity changes?",
h5("4) Explore"),
"Continue exploring how the model responds to changing the model paraemters.  Use the scenario with two populations to compare the effect of different parameter combinations.",
 br(),
 h4("Assessment", style = "color: dark gray", align = "center"),
 "Successful completion of these activities will be assessed in class using the audience response system.",
 h4("Acknowledgements", style = "color: dark gray", align = "center"),
 "This Ecological Modeling Learning Module was intially developed by Amanda Busch, Daniel Goldberg, and Jacie Shuman, and modified by Stuart R. Borrett. The work was supported by an ETEAL Grant from the Unviversity of North Carolina Wilmington"
 
    )
    )
  )

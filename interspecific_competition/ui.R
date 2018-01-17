#' Interspecific Competition
#' Ecological Modeling Leanring Module
#' created by: David Billups, Melissa Lenentine, Tiffany Yang
#' revised by: Stuart R. Borrett
#' January 2018
#' --------------------------------------

library(shiny)
library(deSolve)



ui <- fluidPage(
  
  #app title
  titlePanel("Lotka-Volterra Interspecific Competition"),
  tags$header(HTML("Use the sliders below to model the population dynamics of two competing predator species. Species 1, the coyote (<em>Canis latrans</em>), is represented by the solid brown line. Species 2, the gray wolf (<em>Canis lupus</em>) is represented by the dashed gray line.")),
  tags$br(),
  tags$br(),
  tags$header(HTML("Case Study:
                   
                   Historically, gray wolves and coyotes have coexisted in Yellowstone National Park (YNP) until federal programs to control wolf populations were implemented. These programs resulted in the decimation of gray wolf populations by 1930, allowing coyote populations to grow in the absence of wolves for over 60 years, until their reintroduction in 1995. This reintroduction altered the dynamics of many species’ populations throughout YNP, including coyotes, as they had previously developed and adjusted to the removal of this apex predator. Coyotes may feed in an active manner, in which they pursue and consume prey items, or they may act as scavengers, opportunistically consuming dead prey. As wolf populations increase throughout YNP, they continuously feed on ungulates, a common prey choice between wolves and coyotes. Wolf-killed ungulates provide coyotes with carcasses that are potential prey, leading to an increase in interactions at carcass sites. Both species deter the other from feeding, occasionally leading to starvation or fighting-induced mortalities. The gray wolves typically initiate these interspecific encounters, outnumber coyotes, and dominate these interactions. Ultimately, the predators influence one another’s population dynamics through interspecific interference competition as they vie for a shared resource.
                   ")),
  tags$br(),
  #sidebar layout with input and output definitions
  sidebarLayout(
    
    #sidebar panel for inputs
    sidebarPanel(
      
      #Input: slider for r1
      tags$header("Intrinsic growth rate for coyotes"),
      sliderInput("r1_input", "r1 =",
                  min = -0.1,
                  max = 1,
                  value = 0.1,
                  step = 0.005),
      #Input: slider for r2
      tags$header("Intrinsic growth rate for gray wolves"),
      sliderInput("r2_input", "r2 =",
                  min = -0.1,
                  max = 1,
                  value = 0.1,
                  step = 0.005),
      #Input: slider for K1
      tags$header("Carrying capacity for coyotes"),
      sliderInput("K1_input", "K1 =",
                  min = 25,
                  max = 750,
                  value = 150),
      #Input: slider for K2
      tags$header("Carrying capacity for gray wolves"),
      sliderInput("K2_input", "K2 =",
                  min = 25,
                  max = 750,
                  value = 150),
      #Input: slider for N1
      tags$header("Initial population size of coyotes"),
      sliderInput("N1_input", "N1 =",
                  min = 0,
                  max = 1000,
                  value = 300),
      #Input: slider for N2
      tags$header("Initial population size of gray wolves"),
      sliderInput("N2_input", "N2 =",
                  min = 0,
                  max = 1000,
                  value = 100),
      #Input: slider for alpha
      tags$header("Competition coefficient that is a measure of the effect of gray wolves on the growth of coyotes"),
      sliderInput("alpha_input", "α =",
                  min = 0,
                  max = 10,
                  value = 2),
      #Input: slider for beta
      tags$header("Competition coefficient that is a measure of the effect of coyotes on the growth of gray wolves"),
      sliderInput("beta_input", "β  =",
                  min = 0,
                  max = 10,
                  value = 0.5)
    ),
    
    #Main panel for displaying results
    mainPanel(plotOutput("Interspecific_plot"),
              br(),br(),
              tableOutput("results")
              
    )
  )
  )

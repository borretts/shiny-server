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
  "This interactive learning module is designed to help you better understand the Lotka-Volterra model of interspecific competition.  Upon completion, you should be able to (1) identify the four possible cases of population dynamics, and (2) evaluate the effect of chaning the population parameters.",
  br(),br(),
  "Recall that the Lokta-Volterra interspecific competition model is:",br(),
  tags$img(src = "LVIC_Eqn.png", height = 60),br(),
  "where N is the population density, r is the intrensic growth rate, K is the carrying capcity, and alpha and beta are the competition coefficients.",
br(),
  h4("Case Study: Wolves and Coyotes"),
  HTML("Historically, gray wolves and coyotes have coexisted in Yellowstone National Park (YNP) until federal programs to control wolf populations were implemented. These programs resulted in the decimation of gray wolf populations by 1930, allowing coyote populations to grow in the absence of wolves for over 60 years, until their reintroduction in 1995. This reintroduction altered the dynamics of many species’ populations throughout YNP, including coyotes, as they had previously developed and adjusted to the removal of this apex predator. Coyotes may feed in an active manner, in which they pursue and consume prey items, or they may act as scavengers, opportunistically consuming dead prey. As wolf populations increase throughout YNP, they continuously feed on ungulates, a common prey choice between wolves and coyotes. Wolf-killed ungulates provide coyotes with carcasses that are potential prey, leading to an increase in interactions at carcass sites. Both species deter the other from feeding, occasionally leading to starvation or fighting-induced mortalities. The gray wolves typically initiate these interspecific encounters, outnumber coyotes, and dominate these interactions. Ultimately, the predators influence one another’s population dynamics through interspecific interference competition as they vie for a shared resource."),
  br(),br(),
  tags$header(HTML("Use the sliders below to model the population dynamics of two competing predator species. Species 1, the coyote (<em>Canis latrans</em>), is represented by the solid brown line. Species 2, the gray wolf (<em>Canis lupus</em>) is represented by the dashed gray line.")),
br(),br(),
br(),

  #sidebar layout with input and output definitions
  sidebarLayout(
    
    #sidebar panel for inputs
    sidebarPanel(
      #Input: slider for K1
      h6("Carrying capacity for coyotes"),
      sliderInput("K1_input", "K1 =",
                  min = 25,
                  max = 500,
                  value = 150, step = 5),
      #Input: slider for K2
      h6("Carrying capacity for gray wolves"),
      sliderInput("K2_input", "K2 =",
                  min = 25,
                  max = 500,
                  value = 400, step = 5),
      #Input: slider for N1
      h6("Initial population size of coyotes"),
      sliderInput("N1_input", "N1 =",
                  min = 0,
                  max = 500,
                  value = 300),
      #Input: slider for N2
      h6("Initial population size of gray wolves"),
      sliderInput("N2_input", "N2 =",
                  min = 0,
                  max = 500,
                  value = 100),
      #Input: slider for alpha
      h6("Competition coefficient (effect of gray wolves on coyote growth)"),
      sliderInput("alpha_input", "α =",
                  min = 0,
                  max = 10,
                  value = 2, step = 0.25),
      #Input: slider for beta
      h6("Competition coefficient (effect of coyotes on gray wolf growth)"),
      sliderInput("beta_input", "β  =",
                  min = 0,
                  max = 10,
                  value = 0.5, step = 0.25),
      #Input: slider for r1
      h6("Intrinsic growth rate for coyotes"),
      sliderInput("r1_input", "r1 =",
                  min = -1,
                  max = 1,
                  value = 0.2,
                  step = 0.05),
      #Input: slider for r2
      h6("Intrinsic growth rate for gray wolves"),
      sliderInput("r2_input", "r2 =",
                  min = -1,
                  max = 1,
                  value = 0.1,
                  step = 0.05)
    ),
    
    #Main panel for displaying results
    mainPanel(plotOutput("Interspecific_plot"),
              br(),br(),
              br(),br(),
              br(),br(),
              br(),br(),
              br(),br(),
              h4("Guided Activites"),
              HTML("<ol>
                   <li> Given the initial model parameter values, investigate the effect of changing the values of the intrinsic growth rates.  How does this effect the result of the competition?  Which species wins?  Why? </li> 
                  <li> What do the orange dots on the graph represent?</li>               
                  <li> Make sure that both intrinsic growth rates are positive, and then set both competition coefficients to zero.  What happens?  Why?</li> 
                  <li> Investigate the effect of changing the inital population values.  How does this change the outcome of the competition? </li> 
                  <li> Change the model parameters to make the two species coexist. </li> 
                  <li> Reset the inital parameters (e.g., reload the page), and then set Beta to 8.  Then, watch the temoral dynamcs and the state-space graph as you decrease the inital value of the Coyote population.  At what value does the population value qualitatively change?  </li> 
                   </ol>"),
              h4("Assessment"),
              "Successful completion of these activities will be assessed in class using the audience response system.",
              h4("Acknowledgements"),
              "This Ecological Modeling Learning Module was developed by David Billups, Melissa Lenentine, Tiffany Yang and revised by Stuart R. Borrett with support from an ETEAL Grant from the Unviversity of North Carolina Wilmington",
              
              
              
              
              tableOutput("results")
      
                      
              
    )
  )
  )

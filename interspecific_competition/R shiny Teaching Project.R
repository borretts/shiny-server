###R Shiny: Lotka-Volterra Competition Model ----------------
#Written by: David Billups, Melissa Lenentine, Tiffany Yang --------------
#Last edited: 25 October 2017 -----------------

#run libraries 
library(shiny)
library(ggplot2)
library(dplyr)
library(deSolve)

#create page 
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

#create server
server <- function(input, output, session) {
  
  #use renderPlot for reactive plot when input$bins change
  #output type is a plot
  output$Interspecific_plot <- renderPlot({
    initial.time = 0 #starting time
    final.time = 100 #ending time
    tspan = seq(initial.time,final.time, by = 1)

    
    #Specify model as a function
    
    twostate.model = function(t, state, parameters){
      with( as.list( c(state, parameters) ), {          
        
        # equations (ODE)
        dN1 = r1*N1*((K1-N1-(alpha*N2))/K1) # differential equation
        dN2 = r2*N2*((K2-N2-(beta*N1))/K2) #differential equation 
        
        return( list( c(dN1, dN2 )))	# returns the solution to the diff eq.
      })  # end with(as.list)
    }
    
    
    # -----------------------------------------------------------------------------
    # -- RUN INFORMATION --
    
    # Set Initial State Values
    state = c( N1 = input$N1_input, N2 = input$N2_input )  

    # Define Simulation Time
    initial.time = 0         # starting time of the simulation
    final.time = 100         # ending time of the simulation
    times = seq(initial.time, final.time, by = 1)  # vector of times for which you want a solution
    
    # Assign Parameter Values (using list data structure)
    parameters = c(r1 = input$r1_input,
                   r2 = input$r2_input,
                   K1 = input$K1_input,
                   K2 = input$K2_input,
                   alpha = input$alpha_input,
                   beta = input$beta_input)           # uptake of phosphorus by phytoplankton
    ## note that parameters is has the data type list.
    
    # Numerically Solve the Equation(s)
    out = ode(state,                # note that the ode() function is defined in deSolve
              times,
              twostate.model,          # ode() assumes your models is defined as a function (see above)
              parameters
    )
      
matplot(out[,2:3],
     lwd = 4,
     lty = 1:2, 
     col = c("burlywood4", "darkgray"),
     xlab = "Time (years)",
     ylab = "Population Size (individuals)",
     type = "l")
legend("topright",
legend = c("Coyote", "Gray Wolf"),
lty = c(1, 2),
lwd = 4,
col = c("burlywood4", "darkgray"),
bty = "l")
#create legend for visual identification
  })
}

#run shiny app
shinyApp(ui=ui, server=server)

#' Interspecific Competition
#' Ecological Modeling Leanring Module
#' created by: David Billups, Melissa Lenentine, Tiffany Yang
#' revised by: Stuart R. Borrett
#' January 2018
#' --------------------------------------

library(shiny)
library(deSolve)

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
    state = c( N1 = input$N1_input, 
               N2 = input$N2_input )  
    
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

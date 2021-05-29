#Yuhaniz Aly 
#A3

#load packages
library("shiny")
library("ggplot2")
library("dplyr")
library("plotly")
require(EpiModel)


## Deterministic Model ##


server <- function(input, output) {
  
# create Deterministic Model (SIR model)
  output$dcm <- renderPlot({


sd_param <- param.dcm(inf.prob = as.numeric(input$inf_pick), 
                      act.rate = as.numeric(input$sd_pick), 
                      rec.rate = 0.07)
init <- init.dcm(s.num = 999, i.num = 4,r.num = 0)
control <- control.dcm(type = "SIR", nsteps = 515, dt = 0.5)
mod_sd <- dcm(sd_param, init, control)

plot(mod_sd, alpha = 0.75, lwd = 4, main = "DCM Model") 

  })
  
  # create Stochastic/Individual Contact Model (ICM)

  output$icm <- renderPlot ({
    param.icm <- param.icm(
      inf.prob = as.numeric(input$inf_pick),
      act.rate = as.numeric(input$sd_pick), 
      rec.rate = 0.07)
    init.icm <- init.icm(s.num = 999, i.num = 4, r.num = 0)
    control.icm <- control.icm(type = "SIR", nsteps = 515, nsims = 100)
    sim <- icm(param.icm, init.icm, control.icm)
    
    plot(sim, alpha = 0.75, lwd = 4, main = "ICM Model") 
  })
  
}

# output$imc <- renderPlot({
# param.icm <- param.icm(inf.prob = as.numeric(input$sd_pick), act.rate = 0.5, rec.rate = 0.01)
# init.icm <- init.icm(s.num = 500, i.num = 1,r.num = 0)
#  control.icm <- control.icm(type = "SIR", nsims = 100, nsteps = 300)
# mod.icm <- icm(param.icm, init.icm, control.icm)

# plot(mod.icm)




#  })


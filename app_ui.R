#Yuhaniz Aly
#A3

library("shiny")
library("ggplot2")
library("dplyr")
library("tidyr")
library("plotly")


# Page one/Intro page
page_one <- tabPanel(
  "Introduction",
  tags$body(
    mainPanel(
      h1("Introduction"),
      p("Have you ever wondered how effective public health or
        policy interventions help slow the spread of COVID-19? Have you ever 
        wondered which strategies were the best? In this shiny application, you
        will explore how various social distancing interventions and if
        mandating masks influenced the spread of COVID-19 through an interactive 
        disease modeling simulation."
        )
      
  )
      
))



# widgets  
# selectInput drop down menu to select a social distancing intervention
sd_pick <- selectInput(
  inputId = "sd_pick",
  label = "Select a Social Distancing Intervention",
  choices = list(
    "None" = 0.996,
    "Small gathering cancelation" = 0.1, 
    "School closures" = 0.4,
    "Airport restriction" = 0.5
  ),
  selected = "none", 
  multiple = FALSE
)

# selectInput drop down menu to mandate mask or no mask
inf_pick <- radioButtons(
  inputId = "inf_pick",
  label = "Mandate masks in public",
  choices = list(
    "No" = 0.996,
    "Yes" = 0.33
  ),
  selected = 0.996
)
  
#create page 2 (dmc)

page_two <-
  tabPanel(
    "Deterministic Model",
    titlePanel("Deterministic Model"),
   sidebarLayout(
     sidebarPanel(sd_pick, inf_pick),
     mainPanel(
    plotOutput("dcm")
  )
)
)
  
  
  

page_three <- tabPanel(
  "Stochastic Model",
  titlePanel("Stochastic Model"),
  sidebarLayout(
    sidebarPanel(sd_pick, inf_pick),
    mainPanel(
      p("Note: This may take awhile to load."),
      plotOutput("icm")
    )
  )
)


page_four <- tabPanel(
  "Interpretation",
  titlePanel("Interpretation"),
  tags$body(
    mainPanel(
      h1("Parameters"), 
      p(
        "In this stimulation, the parameters that I’ve set are that there are 
        999 susceptible people (s.num) 4 infected people (i.num). Also, there 
        are 500 iterations (n.steps)."), 

p("Act.rate is the likelihood of encountering an infected person, so value changes 
depending on the type of social distancing policy that is in place. “None” 
(act.rate = 0.996) means that if there was no social distancing, there is a very
high chance (99.6%) of encountering an infected person. This is because COVID-19
spread very rapidly, especially within close proximity. “Small gathering 
cancelation” (act.rate = 0.1) means that if we restrict places where people 
gather in small or large places, it is 90% effective in reducing COVID-19 
transmission, or in other words, 10% chance of encountering an infected person. 
“School closures” (act.rate = 0.4) means that if we close schools and 
institutions, the chance of encountering an infected person will be 40%. Lastly,
“airport restriction” (act.rate = 0.5) means that if you have travel 
restrictions at the airport, the chance of encountering an infected person will 
be 50%. I chose those act.rate values because a", 
        a( href = "https://www.nature.com/articles/s41562-020-01009-0", "reseach
           paper"), "illustrated the effectivess of these social distancing
           interventions."),

p("Inf.prob is the probability of transmitting the disease in an interaction so 
this value changed depending if we mandated weaning masks in public. If people 
did not wear masks, then there is a 99.6% chance of transmission 
(inf.prob = 0.996). But if people do wear masks (inf.prob = 0.33) then the 
probability of transmitting the disease will be 33%. An", 
        a( href = "https://www.nature.com/articles/d41586-020-02801-8", 
           "article"), 
        "mentioned that wearing masks is 67% effective."),

p("Rec.rate is the recovery rate in days. Rec.rate =  0.07 means that it will take 
someone 14 days to recover after being infected (1/14 = 0.07)."), 

h2("Deterministic Model (DMC)"), 

p("Based on the DMC model, the number of people infected was at its highest 
  (the red line) when there was no social distancing and no mask enforced."), 

img( src = "highest-graph.png", width = "450x", height = "350px"),

p("The number of infected people decreased when any of the social distancing 
  intervention is in place compared to no social distancing intervention. 
  Similarly, when we required masks in public, the number of infected people 
  also decreased. The curve decreases even more when you combine both 
  interventons. In fact, the curve was at its flattest when we mandated masks 
  and when we canceled small gatherings." ),

img( src = "flat-graph.png", width = "450x", height = "350px"),
      
h2("Stochastic Model (IMC)"), 

p("In the IMC model, given that there was no social distancing interventions, 
  wearing a mask in public showed more variability of the number of people 
  infected compared to not wearing a mask. I expected this because there are 
  more possibilities that the infection rate could be lower when there is at 
  least one intervention. Similar to the DCM model, the curve for the infection 
  rate flattens when there is there is a more effective implementation, paired 
  with mandating masks in public."), 

p("Another observation is that when we mandate masks and school closure 
  (act.rate = 0.4), the infection curve shifted to the left, he number of 
  susceptible people shifted up, and the variability for the number of 
  susceptible people is wider compared to the airport restriction 
  (act.rate = 0.5). Below, the top graph shows the school closure intervention
  and bottom graph shows the airport restriction."), 

img( src = "imc-yes-mask-school.png", width = "450x", height = "350px"),
img( src = "imc-yes-mask-airport.png", width = "450x", height = "350px"),

p("Another observation is that the IMC model generally shows a smaller 
  curve/fewer number of infection than the DCM model."),

img( src = "imc-no-sd-yes-mask.png", width = "450x", height = "350px"),
img( src = "dmc-no-sd-yes-mask.png", width = "450x", height = "350px"),


h2("Limitations"),
p("Some limitations from in this simulation is that the numbers in this models 
  are just estimates based on the sources I have found. They are not accurate to
  the real life COVID-19 situation. This means the rate of transmission for 
  mandating masks is subject to change. Currently, some parts of the US has 
  lifted wearing mask in public if you are fully vaccinated. Though this model 
  assumes the people are not vaccinated. The likelihood of encountering an 
  infected person is also subject to change depending on the social distancing 
  policy because the model that is depicted assumed that there was initially 4 
  infected people. But we know that there could be more than 4 infected people 
  and a population greater than 999 people. With that, some people who are 
  infected with COVID-19 may appear asymptomatic, which mean there is a chance 
  that the model underestimated the number of infections. "),



      h2("Sources"), 
      p( a( href = "https://www.nature.com/articles/s41562-020-01009-0",
            "Ranking the effectiveness of worldwide COVID-19 government 
           interventions"
      ),
      "and", a( href = "https://www.nature.com/articles/d41586-020-02801-8", 
                "Face masks: what the data say"))
    )))


ui <- fluidPage(
  navbarPage(
    "COVID-19 Disease Modeling",
    page_one,
    page_two,
    page_three,
    page_four
  )
)

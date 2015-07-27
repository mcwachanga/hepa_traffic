library(shiny)

sections <- list(
  "arg-east-toward-chaka" = "arg-east-toward-chaka",
  "arg-west-toward-yaya" = "arg-west-toward-yaya",
  "chaka-south-toward-arg" = "chaka-south-toward-arg",
  "chaka-north-away-from-arg" = "chaka-north-away-from-arg",
  "uhuru-north-into-rndbt" = "uhuru-north-into-rndbt",
  "uhuru-north-out-of-rndbt" = "uhuru-north-out-of-rndbt",
  "kenyatta-ave-east-into-rndbt" = "kenyatta-ave-east-into-rndbt",
  "kenyatta-ave-west-into-rndbt" = "kenyatta-ave-west-into-rndbt",
  "uhuru-south-into-rndbt" = "uhuru-south-into-rndbt"
)

shinyUI(fluidPage(
  #application title
  titlePanel("Nairobi Traffic"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("section", 
                  label = h4("Section"), 
                  choices = sections),
      numericInput("limit", 
                   label = h4("Limit"),
                   value = 100, 
                   min = 100, 
                   max = 1000, 
                   step = 50)
    ),
    mainPanel(
      tableOutput("trafficData")
    )
  )
))
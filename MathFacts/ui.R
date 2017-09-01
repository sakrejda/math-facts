library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Math Facts For You!"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("max",
                  "Largest number:",
                  min = 1,
                  max = 30,
                  value = 5),
       textOutput("prompt"),
       textInput("answer",
                   "Answer:",
                   value = '', width="70%"),
       textOutput("feedback"),
       plotOutput("grid")

     ),
 
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("visualize", height="600px"),
      tableOutput("table")
    )
  )
))




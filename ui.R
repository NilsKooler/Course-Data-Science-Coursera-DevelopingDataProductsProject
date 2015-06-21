
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(pageWithSidebar(
  # Application title
  headerPanel("Storm Events Analysis with variable Wheather Events slider"),
  
  
  # Sidebar with a slider input for Wheather events
  sidebarPanel(helpText("This code is based on the PeerAssment Storm Events Analysis for Reproducible Research course."),
               helpText("A (reduced) dataset of the Storm event analysis is loaded in on the server."),
               helpText("Since there are an enormous amount of wheater events in the original data (900+)"),
               helpText("One has to reduce the number of (top x) events taken into account"),
               helpText("With help of the slider one can select the number of wheather events."), 
               helpText("It is possible to use the full original data file(143 MB). It will take the server several minutes to load"),
               helpText("Select here the number of wheather events you like to take into account for the analysis"),
    sliderInput("events",
                "Number of Wheather events:",
                min = 1,
                max = 25,
                value = 15)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("distPlot")
  )
))


# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

#This code is run once
library(R.utils)
library(ggplot2)
library(plyr)
library(gridExtra)
require(gridExtra)

stormData <- read.csv("repdata-data-StormData-reduced.csv", sep = ",")
fieldFilter <- function(field, data, topNbOfWheatherTypes) {
  index <- which(colnames(data) == field)
  aggregate <- aggregate(data[, index], by = list(data$EVTYPE), FUN = "sum")
  names(aggregate) <- c("EVTYPE", field)
  aggregate <- arrange(aggregate, aggregate[, 2], decreasing = T)
  aggregate <- head(aggregate, n = topNbOfWheatherTypes)
  return(within(aggregate, EVTYPE <- factor(x = EVTYPE, levels = aggregate$EVTYPE)))
}


shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # generate events based on input$events from ui.R
    x    <- faithful[, 2] 
    events <- input$events 
    
    fatalities <- fieldFilter("FATALITIES", stormData, events)
    injuries <- fieldFilter("INJURIES", stormData, events)

    fatalities_bar<-ggplot(data=fatalities, aes(x=EVTYPE,y=FATALITIES)) + geom_bar(stat='identity') + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + xlab("Weather")
    injuries_bar<-ggplot(data=injuries, aes(x=EVTYPE,y=INJURIES)) + geom_bar(stat='identity') + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + xlab("Weather")
    grid.arrange(fatalities_bar, injuries_bar, ncol = 2)
    
  })
  
})

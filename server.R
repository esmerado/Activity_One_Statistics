library(shiny)
library(shinydashboard)
library(cowplot)
library(plotly)
library(knitr)

# Data
trumpData <- read.csv("./data/TRUMPWORLD-pres.csv")

# UI configuration
firstGraph <-  plot_ly(trumpData, type = 'bar') %>%
  add_trace(x = ~year, y = ~avg) %>%
  layout(plot_bgcolor='#e5ecf6', 
         xaxis = list( 
           showlegend = F,
           zerolinecolor = '#ffff', 
           zerolinewidth = 2, 
           gridcolor = 'ffff'), 
         yaxis = list( 
           zerolinecolor = '#ffff', 
           zerolinewidth = 2, 
           gridcolor = 'ffff'))

secondGraph <- plot_ly(trumpData, type = 'scatter', mode = 'lines')%>%
  add_trace(x = ~year, y = ~Spain) %>%
  layout(showlegend = F,  
         xaxis = list(zerolinecolor = '#ffff',
                      zerolinewidth = 2,
                      gridcolor = 'ffff'),
         yaxis = list(zerolinecolor = '#ffff',
                      zerolinewidth = 2,
                      gridcolor = 'ffff'),
         plot_bgcolor='#e5ecf6')

# Operations

year_with_max_confident <- trumpData$year[which.max(trumpData$avg)]

most_confident_country <- function() {
  trumpDeleted <- select(trumpData, -avg, -year)
  medianData <- colMeans(trumpDeleted, na.rm = T,  dims = 1)
  mcc <-colnames(trumpDeleted[which.max(medianData)])
  return(mcc)
}


# Server 
shinyServer(function(input, output){
  
  output$histogram <- renderPlotly({firstGraph})
  
  output$graph_line <- renderPlotly({secondGraph})
  
  output$mostConfidentYear <- renderValueBox({
    valueBox(year_with_max_confident, "Most Confident Year", icon = icon("users"), color = "purple")
  })
  
  output$mostConfidentCountry <- renderValueBox({
    valueBox(most_confident_country(), "Most Confident Country", icon = icon("face-smile"), color = "purple")
  })
  
  output$rawDataTable <- renderDataTable({trumpData})

})
# UI
library(shiny)
library(shinydashboard)
library(plotly)
library(dplyr)

shinyUI(
  # Full page
  dashboardPage( skin = "purple",
    dashboardHeader(title="Exercise 1 Javier Esmerado",
                    dropdownMenu(
                      type = "message",
                      messageItem(from = "Excercise Owner", message = "This exercise has been done by Javier Esmerado")
                    )
                    ),
    # Sidebar
    dashboardSidebar(
      sidebarMenu(
      menuItem(text = "Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem(text = "Raw Data", tabName = "rawData" , icon = icon("database")),
      menuItem(text = "Markdown", href = "https://i2892g-javier0esmerado.shinyapps.io/RMarkDown_JavierEsmeradoVela/" , icon = icon("book"))
    )),
    # Body
    dashboardBody(
      tabItems(
        tabItem(
          tabName = "dashboard",
          fluidRow(
            valueBoxOutput("mostConfidentYear", width = 6),
            valueBoxOutput("mostConfidentCountry",width = 6)
          ),
          fluidRow(
            box(
              title = "Valor medio de la confianza por años",
              status = "success",
              solidHeader = TRUE,
              collapsible = TRUE,
              plotlyOutput("histogram", height = "400px")
              ),
            box(
              title = "Opinión de España por años",
              status = "success",
              solidHeader = TRUE,
              collapsible = TRUE,
              plotlyOutput("graph_line", height = "400px")
            )
          )
        ),
        tabItem(
          tabName = "rawData",
          fluidRow(
            column(12,dataTableOutput("rawDataTable"))
          )
        )
      )
    )
  )
)
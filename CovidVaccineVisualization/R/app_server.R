#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd

library(shiny)
library(shinythemes)
library(dplyr)
library(readr)
#library(DT)
#library(rsconnect)

# Load data
trend_data <- read_csv("/Users/vaishnavi/Downloads/COVID-19_Vaccine_Distribution_Allocations_by_Jurisdiction_-_Pfizer.csv", col_types = list(Week = col_date(format="%m/%d/%Y")))

app_server <- function(input, output, session) {

  # Your application server logic
  selected_trends <- reactive({
    req(input$date)

    validate(need(!is.na(input$date[1]) & !is.na(input$date[2]), "Error: Please provide both a start and an end date."))
    validate(need(input$date[1] < input$date[2], "Error: Start date should be earlier than end date."))
    trend_data %>%
      filter(
        Jurisdiction == input$Jurisdiction
        #Week > as.POSIXct(input$date[1]) & Week < as.POSIXct(input$date[2])
      )
  })

  output$lineplot <- renderPlot({
    color = "#434343"
      par(mar = c(4, 4, 1, 1))
      if (input$Dose == "First Dose")

        plot(x = selected_trends()$Week, y = selected_trends()$first_dose, type = "l",
             xlab = "Date", ylab = "1st Dose", col = color, fg = color, col.lab = color, col.axis = color)
      else
        plot(x = selected_trends()$Week, y = selected_trends()$second_dose, type = "h",
             xlab = "Date", ylab = "2nd Dose", col = color, fg = color, col.lab = color, col.axis = color)


  })

}

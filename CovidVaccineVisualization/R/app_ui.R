
#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic

    fluidPage(
      titlePanel("COVID Vaccine Distribution Visualization"),

      sidebarLayout(

        sidebarPanel(

          # selector for district
          selectInput(inputId = "Jurisdiction", label = strong("Choose State"),
                      choices = unique(trend_data$Jurisdiction),
                      selected = "Texas"),
          # selector for dose
          selectInput(inputId = "Dose", label = strong("Choose Dose type"),
                      choices = list("First Dose","Second Dose"),#unique(trend_data$Jurisdiction),
                      selected = "First Dose"),

          # Select date range to be plotted
          dateRangeInput("date", strong("Date range"), start = "2020-12-14", end = "2021-06-21",
                         min = "2020-12-14", max = "2021-06-21")


        ),

        mainPanel(
          plotOutput(outputId = "lineplot", height = "300px"),
          #tags$a(href = "https://www.google.com/finance/domestic_trends", "Source: Google Domestic Trends", target = "_blank")
          #textOutput("Source for COVID Vaccination Data: CDC Data, Analytics and Visualization Task Force")
        )

      )

    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "MalariaVisualization"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}

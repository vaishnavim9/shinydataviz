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


      sidebarLayout(
        sidebarPanel(

          # select gender
          selectInput(inputId = "gender", label = strong("Male/Female/Both"),
                      choices = c(
                        "Male",
                        "Female",
                        "Both"
                      )),

          # Use gender to determine cancer type
          uiOutput("CancerTypeControl")

        ),

        mainPanel(
          textOutput("main"),
          plotOutput(outputId = "bar_graph", height = "1000px"),
          plotOutput(outputId = "pie_chart", height = "1000px"),

        )

      ),




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
      app_title = "CancerPrevalenceVisualization"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}

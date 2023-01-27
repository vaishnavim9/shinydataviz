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

      # app tabs
      navbarPage(title = span("Differentially Expressed Genes Heatmap", style = "background-color: #DEEBF7; color: red"),

                 # User uploads CSV
                 tabPanel("Upload File/View Data",
                          sidebarLayout(
                            sidebarPanel(
                              fileInput("upload", "Choose CSV File",
                                                   accept = c(
                                                     "text/csv",
                                                     "text/comma-separated-values,text/plain",
                                                     ".csv")
                                         ),
                            ),
                            # display of data that user uploaded (table and summary)
                            mainPanel('main',
                                      tableOutput("table.output"),
                                      verbatimTextOutput("summary")
                            )
                          )),

                 # plot heatmap of user uploaded CSV
                 tabPanel('map',
                          sidebarLayout(
                            sidebarPanel(
                              actionButton('getHmap', 'get heatmap'),
                                         tags$hr(),
                                         checkboxInput("header", "Header", TRUE)
                            ),
                            mainPanel(
                              plotOutput("themap"),
                              tableOutput("table.output")
                            )
                          ))
      ),

      ),





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
      app_title = "project"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}

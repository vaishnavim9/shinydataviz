#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd

library(pheatmap)
app_server <- function(input, output, session) {
  # Your application server logic

  req(input$upload)


  a <- reactive({
    inFile <- input$upload
    if (is.null(inFile))
      return(NULL)
    tbl <- read.csv(inFile$datapath, header=input$header)
    return(tbl)
  })

  output$table.output <- renderTable({
    a()
  })

  plotdata <- eventReactive(input$getHmap, {
    a <- as.matrix(a())
    row.names(a) <- a()$Name
    a[is.na(a)] <- 0
    a
  })

  output$themap = renderPlot({
    pheatmap(plotdata())
  })

}

#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd

library(readr)
library(ggplot2)
library(dplyr)


male_cancer_prevalence <- read.csv("/Users/vaishnavi/Downloads/MaleCancerIncidence.csv")
female_cancer_prevalence <- read.csv("/Users/vaishnavi/Downloads/FemaleCancerIncidence.csv")
both_genders_cancer_prevalence <- read.csv("/Users/vaishnavi/Downloads/Male&FemaleCancerIncidence.csv")
# current_csv = 0 --> female
# current_csv = 1 --> male
# current_csv = 2 --> both

current_csv <- 0

app_server <- function(input, output, session) {

  # Determine which CSV depending on gender

  output$CancerTypeControl <- renderUI({

    if (input$gender == "Male")
    {
      selectInput(inputId = "cancer_type", label = strong("Type of Cancer"),
                  choices = unique(male_cancer_prevalence$Cancer))
    }
    else if (input$gender == "Female")
    {
      selectInput(inputId = "cancer_type", label = strong("Type of Cancer"),
                  choices = unique(female_cancer_prevalence$Cancer))
    }
    else if (input$gender == "Both")
    {
      selectInput(inputId = "cancer_type", label = strong("Type of Cancer"),
                  choices = unique(both_genders_cancer_prevalence$Cancer))
    }
  })

  output$bar_graph <- renderPlot({

    if (input$gender == "Male")
    {
      cancer_data = male_cancer_prevalence
    }
    else if (input$gender == "Female")
    {
      cancer_data = female_cancer_prevalence
    }
    else if (input$gender == "Both")
    {
      cancer_data = both_genders_cancer_prevalence
    }

    #render bar chat (if sll cancers selected)

    if (input$cancer_type == "All cancers*")
    {
      # if all cancers,
      ggplot(cancer_data, aes(x=Cancer, y=new_cases_2020)) +
        geom_bar(stat = "identity") +
        coord_flip() +
        geom_col(width = 0.5) +
        geom_text(aes(label = new_cases_2020), hjust = 1.5, colour = "white")
    }
    else
    {
      #get user chosen cancer type
      cancer_type = input$cancer_type

      #filter male/fem/all cancer data-frame for above cancer type
      df_c = filter(cancer_data, Cancer == input$cancer_type)

      cancer_type_pct = df_c[1,4]
      # Create pie-chart data frame
      pct_data <- data.frame(
        cancer_type=c(input$cancer_type, "Others"),
        pct=c(cancer_type_pct, 100-cancer_type_pct)
      )
      print(paste(pct_data, " $$$$"))

      ggplot(pct_data, aes(x="", y=pct, fill=cancer_type)) +
        geom_bar(stat="identity", width=1) +
        geom_text(aes(label = pct + "%"),
                  position = position_stack(vjust = 0.5))+
        coord_polar("y", start=0)
    }
  })



}

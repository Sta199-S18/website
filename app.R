library(shiny)
library(DT)
library(tidyverse)

# Define UI for data upload app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel(title = h1("Upload file and select columns", align = "center")),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select a file ----
      fileInput("uploaded_file", "Choose CSV File",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      
      # Horizontal line ----
      tags$hr(),
      
      # Input: Checkbox if file has header ----
      checkboxInput("header", "Header", TRUE),
      
      # Input: Select separator ----
      radioButtons("sep", "Separator",
                   choices = c(Semicolon = ";",
                               Comma = ",",
                               Tab = "\t"),
                   selected = ","),
      
      
      # Horizontal line ----
      tags$hr(),
      
      # Input: Select number of rows to display ----
      radioButtons("disp", "Display",
                   choices = c(All = "all",
                               Head = "head"),
                   selected = "all"),
      
      # Select variables to display ----
      uiOutput("checkbox")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      tabsetPanel(
        id = "dataset",
        tabPanel("FILE", DT::dataTableOutput("rendered_file"))
      )
    )
    
  )
)

# Define server logic to read selected file ----
server <- function(input, output, session) {
  
  # Read file ----
  df <- reactive({
    req(input$uploaded_file)
    read.csv(input$uploaded_file$datapath,
             header = input$header,
             sep = input$sep)  
    
  })
  
  # Dynamically generate UI input when data is uploaded ----
  output$checkbox <- renderUI({
    checkboxGroupInput(inputId = "select_var", 
                       label = "Select variables", 
                       choices = names(df()),
                       selected = names(df()))
  })
  
  # Select columns to print ----
  df_sel <- reactive({
    req(input$select_var)
    df_sel <- df() %>% select(input$select_var)
  })
  
  # Print data table ----  
  output$rendered_file <- DT::renderDataTable({
    if(input$disp == "head") {
      head(df_sel())
    }
    else {
      df_sel()
    }
  })
  
}

# Create Shiny app ----
shinyApp(ui, server)
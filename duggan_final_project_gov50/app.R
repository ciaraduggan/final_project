
# GOV 50 Final Project Shiny App

library(shiny)
library(shinythemes)

# Define UI for application that draws a lineplot
ui <- navbarPage(
    "Final Project Title",
    tabPanel("Model",
             fluidPage(theme = shinytheme("cerulean"),
                 titlePanel("Model Title"),
                 sidebarLayout(
                     sidebarPanel(
                         selectInput(
                             "plot_type",
                             "Plot Type",
                             c("Option A" = "a", "Option B" = "b")
                         )),
                     mainPanel(plotOutput("line_plot")))
             )),
    tabPanel("Discussion",
             titlePanel("Discussion Title"),
             p("Tour of the modeling choices I made and 
              an explanation of why I made them.")),
    tabPanel("About", 
             titlePanel("About"),
             h3("Project Background and Motivations"),
             p("Hello, this is where I talk about my project. 
               Discuss data sources here for Milestone 4."),
             p("insert repo url"),
             h3("About Me"),
             p("My name is Ciara Duggan and I am a senior at Harvard College 
             concentrating in Social Studies with a secondary field in Global 
             Health and Health Policy. 
             You can reach me at ciaraduggan@college.harvard.edu.")))

# Define server logic required to draw a lineplot
server <- function(input, output) {
    output$line_plot <- renderPlot({
        # Generate type based on input$plot_type from ui
        
        ifelse(
            input$plot_type == "a",
            
            # If input$plot_type is "a", plot histogram of "waiting" column 
            # from the faithful dataframe
            
            x   <- faithful[, 2],
            
            # If input$plot_type is "b", plot histogram of "eruptions" column
            # from the faithful dataframe
            
            x   <- faithful[, 1]
        )
        
        # Draw the histogram with the specified number of bins
        
        hist(x, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

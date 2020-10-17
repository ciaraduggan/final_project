
# GOV 50 Final Project Shiny App

# Load libraries

library(shiny)

library(shinythemes)

# Load data

county_drug_data <- readRDS("/Users/ciaraduggan/Desktop/gov_50/final_project/duggan_final_project_gov50/data/county_drug_data.rds")

# Define UI
ui <- navbarPage(
    "Opioid Prescription and Drug-Related Death Trends in the U.S.",
    tabPanel("Model",
             fluidPage(theme = shinytheme("cerulean"),
                 titlePanel("Model"),
                 sidebarLayout(
                     sidebarPanel(
                         helpText("Choose a year."),
                         selectInput(
                             "year",
                             label = "Year",
                             choices = c("2006", "2007", "2008", "2009", "2010", "2011",
                               "2012", "2013", "2014", "2015", "2016", "2017"),
                             selected = "2017"
                         )),
                     mainPanel(plotOutput("scatterPlot")))
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
             p("My Github repository can be found here: 
               https://github.com/ciaraduggan/final_project"),
             h3("About Me"),
             p("My name is Ciara Duggan and I am a senior at Harvard College 
             concentrating in Social Studies with a secondary field in Global 
             Health and Health Policy. 
             You can reach me at ciaraduggan@college.harvard.edu.")))

# Define server logic 

server <- function(input, output) {
    output$scatterPlot <- renderPlot({ 
        county_drug_data %>%
            filter(YEAR == input$year) %>%
            ggplot(aes(x = opioid_RxRate, y = drugdeathrate_est)) +
            geom_point(alpha = 0.1) +
            geom_smooth(method = lm) +
            labs(title = "title", x = "x label", y = "y label")
    })
}

# Run the application 

shinyApp(ui = ui, server = server)

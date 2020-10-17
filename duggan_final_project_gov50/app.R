
# GOV 50 Final Project Shiny App

# Load libraries

library(shiny)

library(shinythemes)

library(tidyverse)

# Load data

county_drug_data <- readRDS("data/county_drug_data.rds")

# Define UI
ui <- navbarPage(
    "Opioid Prescriptions and Drug-Related Death Trends in the U.S.",
    
    # Creating Model tab which will allow user to select a year from 2006-2017 
    # as an input and will display a scatter plot based on selection.
    
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
                             selected = "2006"
                         )),
                     mainPanel(plotOutput("scatterPlot")))
             )),
    
    # Creating a "Discussion" tab (where I will discuss modeling choices later).
    
    tabPanel("Discussion",
             titlePanel("Discussion"),
             p("This is where I will give a tour of the modeling choices I made 
             and an explanation of why I made them.")),
    
    # Creating an "About" tab (for project background and personal info)
    
    tabPanel("About", 
             titlePanel("About"),
             h3("Project Background and Motivations"),
             p("For my project, I was hoping to collaborate with the Harvard 
             School of Public Health's SHINE Initiative (Sustainability and 
               Health Initiative for Net Positive Enterprise). I have been in 
               contact with the SHINE team, and I am planning on helping them
               with analyzing a new dataset on World Bank employees globally
               and different measures of mental well-being. However, I have not 
               yet been able to gain access to this data. Ideally, I will be
               able to access the data within the next week."),
             p("In the meantime, I am working on a project which will analyze
               the relationship between opioid prescription rates and
               drug-related death rates in US counties and states using data
               from 2006-2017. I am searching for other data sets that include
               additional relevant indictors to include in my model, but for now, 
               I have started to work with several datasets from the AmfAR 
               Opioid and Health Indicators database. These various datasets 
               include data on opioid prescription rates and drug-related deaths
               at the state and county levels."),
               p("I am still working on processing all of my data, but to begin,
               I have wrangled and joined two sets of data to create one dataset
               containing opioid prescription values and drug-related death 
               values for the relevant years. Using this dataset (which I saved
               as a .rds file), I have created an interactive feature in my 
               Shiny app that generates plots of the relationship between 
                 opioid prescription rates and drug-related deaths across US 
                 counties for the year selected by the user."),
             p("The prescription indicator signifies the number of opioid 
             prescriptions per 100 persons in the county. According to AmfAR: 
             'This measure uses IQVIA data from pharmacies which dispense nearly 
             90% of all retail prescriptions in the US. It includes prescriptions 
             paid for by commercial insurance, Medicaid, Medicare, or cash or 
             equivalent. Cough and cold formulations containing opioids and
             buprenorphine products typically used to treat opioid use disorder 
             are excluded, and IQVIA data does not include methadone dispensed 
             through methadone maintenance treatment programs.'"),
             p("The age-adjusted drug-related death indicator signifies the 
             estimated rate of death from drug poisoning, including both illicit
             and prescription drugs, per 100,000 U.S. standard population for 
             2000. According to AmfAR: 'Estimates come from the Centers for 
             Disease Control and Prevention (CDC) National Center for Health 
             Statistics (NCHS) Data Visualization Gallery.It should be noted 
             that these data are estimates, and are drawn from a model designed
             to generate stable estimates of death rates where data are sparse 
             due to small population size. Specific county values should be 
             interpreted with caution, and the actual measure of drug deaths per
             100,000 should be preferred where available.'"),
             h3("Github Repo"),
             p("My Github repository can be found here: 
               https://github.com/ciaraduggan/final_project"),
             h3("About Me"),
             p("My name is Ciara Duggan. I am a senior at Harvard College 
             concentrating in Social Studies with a secondary field in Global 
             Health and Health Policy. 
             You can reach me at ciaraduggan@college.harvard.edu.")))

# Define server logic 

server <- function(input, output) {
    output$scatterPlot <- renderPlot({ 

        # This code tells Shiny to generate a scatter plot (using the opioid 
        # prescription values and drug-related death values for each county
        # for given year) based on the input year which the user selects.
        
        county_drug_data %>%
            filter(YEAR == input$year) %>%
            ggplot(aes(x = opioid_RxRate, y = drugdeathrate_est)) +
            geom_point(alpha = 0.1) +
            geom_smooth(method = lm) +
            labs(title = "Opioid Prescription Rates and Drug-Related 
                 Death Rates for U.S. Counties in Given Year", 
                 x = "Number of Opioid Prescriptions per 100 Persons in County",
                 y = "Age-Adjusted Drug Poisoning Deaths per 100,000 (Modeled)")
    })
}

# Run the application 

shinyApp(ui = ui, server = server)

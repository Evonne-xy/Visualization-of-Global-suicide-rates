library(shiny)
library(shinythemes)
library(plotly)

# Add navigation bar

navbarPage("Navbar!",
           
           #Add theme of navigation bar
           tabPanel("Global suicide rate analysis",
                    fluidPage(theme = shinytheme("flatly")),
                    tags$head(
                      tags$style(HTML(".shiny-output-error-validation{color: red;}"))
                    ),
                    
                    # Add side bar
                    pageWithSidebar(
                        headerPanel('Apply filters'),
                        sidebarPanel(
                          h3("Question 1"),
                          helpText("Which country has hightest suicide rate?"),
                          br(),
                          
                          #select option
                          selectInput("Q1Country", "Select Country", 
                                      choices =  c("Country",levels(SuicideRate$Country)), 
                                      selected = "Country"),
                          br(),
                          br(),
                          helpText("You can also choose to stop on a particular year to observe the correlation")
                        
                        
                        ),
                        #connect UI and server
                        mainPanel(plotlyOutput("GlobalSuicide",width = "100%"))
                    )
                 ),
           
           #Add theme of navigation bar
           tabPanel("Relationship between economic factors and suicide rate",
                    
                    fluidPage(theme = shinytheme("flatly")),
                    tags$head(
                      tags$style(HTML(".shiny-output-error-validation{color: red;}"))
                    ),
                    
                    # Add side bar
                    pageWithSidebar(
                      headerPanel('Apply filters'),
                      sidebarPanel(
                        h3("Question 2"),
                        helpText("whether economic changes have an impact on suicide rates."),
                        br(),
                        
                        #select option
                        selectInput("standout", "Select Country", 
                                    choices =  c("Country",levels(SuicideRate$Country)), 
                                    selected = "Country"),
                        br(),
                        br(),
                        helpText("You can also choose to stop on a particular year to observe the correlation")
                      ),
                      #connect UI and server
                      mainPanel(plotlyOutput("SuicideByCountry",width = "100%"))
                    )
                  ),
           
           #Add theme of navigation bar
           tabPanel("Proportion of male and female suicide rates",
                    
                      fluidPage(theme = shinytheme("flatly")),
                      tags$head(
                        tags$style(HTML(".shiny-output-error-validation{color: red;}"))
                      ),
                    
                    # Add side bar
                      pageWithSidebar(
                        headerPanel(''),
                        sidebarPanel(
                          h3("Question 3"),
                          helpText("whether diffrent gender has an impact on suicide rates."),
                          br(),
                          br(),
                          helpText("You can also choose to stop on a particular year to observe the correlation")
                        ),
                    #connect UI and server and show 2 plots
                        mainPanel("",
                                  fluidRow(
                                    splitLayout(cellWidths = c("40%", "60%"), plotlyOutput("SuicideBygender"), plotlyOutput("SuicideBygender2"))
                                  ))
                      )
                    
                  )
           
           
           
          )

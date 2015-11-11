#
# The UI part of the Developing Data Products Coursera Course.
#

library(shiny)

shinyUI(pageWithSidebar(
    
    # The header panel with a title
    #
    headerPanel("Various distributions plots"),
    
    # The side bar panel with controls that help adjust plots' parameters
    #
    sidebarPanel(
        
        # Select a distribution
        #
        selectInput("distName", label = "Distribution:", 
                    choices = list("Normal" = "norm", "Logistic" = "logis",
                                   "Log Normal" = "lnorm"), selected = "norm"),
        # How many values
        #
        sliderInput("n", 
                    "Observations:", 
                    min = 1,
                    max = 1000, 
                    value = 500),
        
        # The first parameter - varies depending on the distribution
        #
        strong(textOutput("arg1")),
        sliderInput("arg1", 
                    "", 
                    min = -10,
                    max = 10, 
                    value = 0),
        
        # The second parameter - varies depending on the distribution
        #
        strong(textOutput("arg2")),
        sliderInput("arg2", 
                    "", 
                    min = 0,
                    max = 10, 
                    value = 1),
        
        # Choose the function
        #
        radioButtons("funType", "Function:",
                     list("Distribution" = "r",
                          "Density" = "d",
                          "Cumulative probability" = "p"))
    ),
    
    # The main panel consists of plots and help tabs
    #
    mainPanel(
        tabsetPanel(
            tabPanel("Plot", plotOutput("thePlot")), 
            tabPanel("Help/Documentation",
                     textOutput("help1"), br(),
                     textOutput("help2"), br(),
                     textOutput("help3"), br(),
                     textOutput("help4"), br(),
                     textOutput("help5"))
        )
    )
))
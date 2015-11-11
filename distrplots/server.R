#
# The server part of the Developing Data Products Coursera Course.
#

library(shiny)
library(ggplot2) # we will be using ggplot2 for plots

shinyServer(
    function(input, output) 
    { 
        output$help1 <- renderText({
            paste("The purpose of this application is to illustrate how the selected",
                  "distributions behave depending on their parameters settings.",
                  "As one image is worth one thousand words I decided to show how the",
                  "the distribution, its probability density function and its",
                  "cumulative probability density function charts change with their",
                  "parameters change.")
        })
        
        output$help2 <- renderText({
            paste("'Distribution' select box - allows choosing the distribution we are interested in.")
        })
        
        output$help3 <- renderText({
            paste("'Observations' slider - would be used to select how many variables will be used.")
        })
        
        output$help4 <- renderText({
            paste("The next two sliders allow us to set the distribution parameters.",
                  "The parameters depend on the distribution and will be described accordingly.")
        })
        
        output$help5 <- renderText({
            paste("'Function' radio buttons - allow picking up a histogram or density or cumulative probability functions.")
        })
        
        # Display the first argument - varies depending on the distribution
        #
        output$arg1 <- renderText({
            switch(input$distName,
                   "norm" = "Mean:",
                   "logis" = "Location:",
                   "lnorm" = "Mean:",
                   "Mean:")
        })
      
        # Display the second argument - varies depending on the distribution
        #
        output$arg2 <- renderText({
            switch(input$distName,
                   "norm" = "Standard Deviation:",
                   "logis" = "Scale:",
                   "lnorm" = "Standard Deviation:",
                   "Mean:")
        })
        
        # Get the right 'r' function to generate values
        #
        output$thePlot <- renderPlot({   
            rdist <- switch(input$distName,
                            "norm" = rnorm,
                            "logis" = rlogis,
                            "unif" = rlnorm,
                            rnorm)
            
            # Generate values
            #
            values <- rdist(input$n, input$arg1, input$arg2)
            
            # Get the right density function
            #
            ddist <- switch(input$distName,
                            "norm" = dnorm,
                            "logis" = dlogis,
                            "lnorm" = dlnorm,
                            dnorm)
            
            # The basic data.frame we will use
            #
            df <- data.frame(x = values, y = ddist(values))
            
            if(input$funType == "r") # plot the histogram
            {
                g <- ggplot(df) + geom_histogram(aes(x = x), binwidth = 1) +
                    labs(title = "Distribution") +
                    xlab("Values") + ylab("Count")
                g
            }
            else if(input$funType == "d") # plot the density function
            {       
                g <- ggplot(df) + aes(x = x, y = y) +
                    geom_point() + labs(title = "Density") +
                    xlab("Values") + ylab("Probability")
                g
            }
            else if(input$funType == "p") # plot the cumulative probability
            {      
                pdist <- switch(input$distName,
                                "norm" = pnorm,
                                "logis" = plogis,
                                "lnorm" = plnorm,
                                pnorm)
                g <- ggplot(data.frame(x = values, y = pdist(values))) + aes(x = x, y = y) +
                    geom_point() + labs(title = "Cumulative probability") +
                    xlab("Values") + ylab("Probability")
                g
            }
        })
    }
)
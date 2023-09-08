library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        Distribution    <- faithful[, 2]
        bins <- seq(min(Distribution), max(Distribution), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(Distribution, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')

    })

}

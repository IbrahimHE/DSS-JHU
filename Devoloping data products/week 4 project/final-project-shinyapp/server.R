library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {

    data <- reactive({
        d <- as.data.frame(eval(parse(text = input$dataset)))
        d
    })
    
    output$table <- renderTable({
        data()
    })
    # update colnames for model
    colnamesda <- reactive({
        colnames(data())
    })
    observeEvent(input$dataset, {
            updateSelectInput(session = session,'colsx', selected = NULL,
                                    choices = colnamesda())
        }
        )
    observeEvent(input$dataset,{
                 updateSelectInput(session,'colsy', selected = NULL,
                                   choices = colnamesda()[colnamesda() != input$colsx]
                                   )
        }
        )
    
    
    
    # create a reactive value of a linear model from x and y input
    model1 <- reactive({
        data <- data()
        
        req(input$colsy)
        # mtcars <- datasets::mtcars
        lm(data[input$colsy][[1]] ~ data[input$colsx][[1]],
           data = data)
    })
    model2 <- reactive({
        data <- data()
        
        req(input$colsy)
        brushed_data <- brushedPoints(data, input$brush1,
                                      xvar = input$colsx, yvar = input$colsy)
        if(nrow(brushed_data) < 2){
            return(NULL)
        }
        lm(brushed_data[input$colsy][[1]] ~ brushed_data[input$colsx][[1]],
           data = brushed_data)
    })
    
    
    # To render the slope of the model
    output$slopeOut1 <- renderText({
        req(model1)
        if(is.null(model1())){
            "No Model Found"
        } else {
            model1()[[1]][2]
        }
    })

    # To render the coefficient
    output$intOut1 <- renderText({
        req(model1)
        if(is.null(model1())){
            "No Model Found"
        } else {
            model1()[[1]][1]
        }
    })

    # To render the slope of the model
    output$slopeOut2 <- renderText({
        req(model2)
        if(is.null(model2())){
            "No Model Found"
        } else {
            model2()[[1]][2]
        }
    })

    # To render the coefficient
    output$intOut2 <- renderText({
        req(model2)
        if(is.null(model2())){
            "No Model Found"
        } else {
            model2()[[1]][1]
        }
    })
    
    output$distPlot <- renderPlot({
        req(model1)
        req(model2)
        data <- data()
        xlab <- input$colsx
        ylab <- input$colsy
        if(input$title == T) {
            main = paste0(input$colsy, ' ~ ' , input$colsx)
        } else {main = ''}

        # draw the scatterplot with the specified x and y axis:
        x = data[input$colsx][[1]]
        y = data[input$colsy][[1]]
        # Add extra space to right of plot area; change clipping to figure
        par(oma=c(0, 0, 0, 9))
        # par(mar=c(1, 1, 1, 1), xpd=TRUE)
        plot(y ~ x, 
             main = main,
             cex = input$cex,
             pch = input$pch,
             xlab = xlab,
             ylab = ylab
             )
        abline(model1(), col = "red", lwd = 2, lty = 1)
        abline(model2(), col = "blue", lwd = 2, lty = 2)
        legend(
            par('usr')[2], par('usr')[4], bty='n', xpd=NA,
            title = "Model type",
            # x = 25, y = 400,
            legend=c("All data", "Selected data"),lwd = 2,  #bty = "n",
            col=c("red", "blue"), lty=1:2, cex=1.4)
    })

})

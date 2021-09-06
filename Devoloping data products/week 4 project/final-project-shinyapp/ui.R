library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Final project shiny app - Linear regression of mtcars datasets"),

    # Sidebar with number of inputs to the model
    sidebarLayout(
        sidebarPanel(width = 3,
            # Select data:
            selectInput(
                'dataset', 'Select dataset', selected = '',
                choices = c('iris', 'EuStockMarkets', 'Seatbelts', 'USArrests', 
                            'USJudgeRatings', 'mtcars', 'airquality', 'attitude',
                            'cars', 'faithful' ,'quakes', 'rock', 'trees', 'swiss'
                            )
                ),
            
            # select x axis
            selectInput('colsx','Select x-axis', selected = '', choices = c('')),
            
            # select y axis
            selectInput('colsy','Select y-axis', selected = '', choices = c('')),
            
            # Show the title
            checkboxInput('title','Title',TRUE),
            helpText('Write the title of the plot'),
            
            # Size of datapoints
            numericInput('cex','Size of datapoints',2, step = 0.5),
            
            # shape of datapoints
            numericInput('pch', 'Shape of datapoints',19),
            helpText('Shape from 0 to  25')
            ),
        

        # Show a plot of the selected data
        mainPanel(width = 9,
            fluidRow(align="center",
                column(width = 4,
                       plotOutput("distPlot", height = '450px', width = '630px',
                                  brush = brushOpts(id = "brush1")
                                  )
                ),
                
                column(
                        width = 4, offset = 4, 
                        br(),br(),br(),
                        wellPanel(h3(strong('Model 1:', 
                                            span('in red',style = 'color:red'))),
                            h3("Slope"),
                            textOutput("slopeOut1"),
                            h3("Intercept"),
                            textOutput("intOut1")
                        ),
                        wellPanel(h3(strong('Model 2:',
                                            span('in blue',style = 'color:blue'))),
                            h3("Slope"),
                            textOutput("slopeOut2"),
                            h3("Intercept"),
                            textOutput("intOut2")
                            )
                    )
            )
        )
    )
))

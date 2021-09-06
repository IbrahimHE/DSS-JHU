This small Shiny application demonstrates Shiny's automatic UI updates. 

In the sidebar panel you specifiy your dataset, then choose the columns within the dataset to do scatterplot. 


Change  the *Size and shape of datapoints* slider and notice how the `renderPlot` expression is automatically re-evaluated when its dependant, `input$cex`, `input$pch` changes, causing a scaterplot with a new datapoints to be rendered.

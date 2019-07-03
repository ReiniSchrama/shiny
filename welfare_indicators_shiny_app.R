library(shiny)                               


ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "xaxis", 
        label = "Choose a Variable for the X-axis of the First Graph", 
        choices = c("Service effort (as % of GDP)" = "Service.effort",
                    "Transfer effort (as % of GDP)" = "Transfer.effort",
                    "Service emphasis (as % of all benefits)" = "Service.emphasis",
                    "Social contribution (as % total receipts)" = "Contribution",
                    "Social expenditures (as % of GDP)" = "Social.expenditures",
                    "Health expenditures (as % of GDP)" = "Health.expenditures")
            ),
      selectInput(
        inputId = "yaxis", 
        label = "Choose a Variable for the Y-axis of the First Graph", 
        choices = c("Service effort (as % of GDP)" = "Service.effort",
                    "Transfer effort (as % of GDP)" = "Transfer.effort",
                    "Service emphasis (as % of all benefits)" = "Service.emphasis",
                    "Social contribution (as % total receipts)" = "Social.contribution",
                    "Social expenditures (as % of GDP)" = "Social.expenditures",
                    "Health expenditures (as % of GDP)" = "Health.expenditures")
      )
    ),
    mainPanel(
      plotOutput(outputId = "scatterplot"))
  )
) 

server <- function(input, output) {
  welfare_indicators <- read.csv("welfare_indicators_shiny.csv", header = TRUE, sep = ",", row.names=1)
  row.names(welfare_indicators) <- welfare_indicators$GEO
  welfare_indicators$GEO <- NULL
  data1 <- welfare_indicators  
  output$scatterplot <- renderPlot({
    req(input$xaxis)
    req(input$yaxis)
    ggplot(data1, aes_string(x = paste0("`", input$xaxis, "`"), 
                             y = paste0("`", input$yaxis, "`"))) + 
      geom_jitter() +
      geom_text(label=row.names(data1), nudge_x = 0.25, nudge_y = 0.5, check_overlap = TRUE, cex=5)
  })
} 

shinyApp(ui = ui, server = server)


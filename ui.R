library(shiny)

langs <- c("english","french","german","italian","portuguese","russian",
           "spanish")

shinyUI(fluidPage(
    
    headerPanel("URL Text Analysis"),
    sidebarPanel(
        
        textInput("url", "URL (with http://):", value = "http://en.wikipedia.org/wiki/Siege_of_Constantinople_(717%E2%80%9318)"),
        
        selectInput("lang", "Select the language:", choices = langs,
                    selected = "english"),
        
        sliderInput("minFreq", "Minimum frequency:", 
                    min = 1, max = 50, value = 3),
        sliderInput("maxFreq", "Maximum number of words:",
                    min = 1, max = 500, value = 100),
        
        submitButton("Go")
    ),
    
    mainPanel(
        
        h3("Word Cloud"),
        h4("Minimum frequency:"),
        verbatimTextOutput("minFreq"),
        h4("Maximum word frequency:"),
        verbatimTextOutput("maxFreq"),
        h4("Selected language:"),
        verbatimTextOutput("langSelected"),
        h4("Word cloud:"),
        plotOutput("myplot")
    )
    
))
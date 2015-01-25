library(shiny)

langs <- c("english","french","german","italian","portuguese","russian",
           "spanish")

shinyUI(fluidPage(
                   
    headerPanel("URL Text Analysis"),
    sidebarPanel(
        
        textInput("url", "URL (with http://):", value = "http://en.wikipedia.org/wiki/Siege_of_Constantinople_(717%E2%80%9318)"),
        p("Paste an URL that contains some amount of text that could be converted in a 
          wordcloud. This HTML must have paragraphs of texts, i. e., <p></p> tags to
          be processed. Try using an Wikipedia article or any BBC news"),
        
        selectInput("lang", "Select the language:", choices = langs,
                    selected = "english"),
        p("Select here tha language of the defined text. This parameter will be used to
          remove stopwords from the text, i. e., words with high frequency that don't
          aggregate any information to the text."),
        
        sliderInput("minFreq", "Minimum frequency:", 
                    min = 1, max = 50, value = 3),
        p("This parameter sets the minimum frequency whose words must have to
          be plotted in the word cloud."),
        sliderInput("maxFreq", "Maximum number of words:",
                    min = 1, max = 500, value = 100),
        p("This parameter sets the maximum number of words which will be plotted in 
          the word cloud."),
        
        submitButton("Go"),
        p("It takes some seconds to process the text, please, be patient. =)")
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
    
    
)
)
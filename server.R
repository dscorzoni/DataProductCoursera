library(shiny)
library(XML)
library(RCurl)
library(tm)
library(wordcloud)
library(RColorBrewer)


shinyServer(function(input, output, session) {
    
    terms <- reactive({
        
        #input$update
                        
                html = getURL(input$url)
                doc.html = htmlTreeParse(html, useInternal = TRUE)
                doc.text = unlist(xpathApply(doc.html, '//p', xmlValue))
                
                doc.text = gsub('\\n', ' ', doc.text)
                doc.text = gsub('\\r', ' ', doc.text)
                doc.text = gsub('\\t', ' ', doc.text)
                
                # Transforming in a Corpora
                myCorpus <- Corpus(VectorSource(doc.text))
                myCorpus <- tm_map(myCorpus, content_transformer(tolower))
                myCorpus <- tm_map(myCorpus, removePunctuation)
                myCorpus <- tm_map(myCorpus, removeNumbers)
                myCorpus <- tm_map(myCorpus, removeWords, stopwords(input$lang))
                
                # Transforming in a Term Document Matrix
                myDtm <- TermDocumentMatrix(myCorpus, 
                                            control = list(minWordLength = 3))
                
                # Building the Wordcloud
                m <- as.matrix(myDtm)
                v <- sort(rowSums(m), decreasing = TRUE)
                
                
    
        
    })
    
    
    
    
    #output$pageTitle <- renderText({html})
    output$minFreq <- renderText({input$minFreq})
    output$maxFreq <- renderText({input$maxFreq})
    output$langSelected <- renderText({input$lang})
    output$myplot <- renderPlot({
        
        v <- terms()
        wordcloud(names(v), v, min.freq = input$minFreq, 
                  max.words = input$maxFreq, colors = brewer.pal(8,"Dark2"),
                  scale=c(10,.5))
        
    })
    
    
})
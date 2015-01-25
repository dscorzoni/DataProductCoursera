---
title: "URL Text Analysis - Documentation"
author: "Danilo Scorzoni Ré"
date: "Sunday, January 25, 2015"
output: html_document
runtime: shiny
---

# Introduction

The URL Text Analysis app is a very simple app that gets the HTML code of a specified URL, process the text inside `<p></p>` tags and plots a wordcloud to the user. In the background, the app uses the **tm** package to process the text and transform it in documents and words, and the **wordcloud** package to plot the wordcloud.

More detailed explanation is below:

# Details

## HTML scraping and processing

The apps starts in the URL defined by the user. The following code download the HTML code and process using the **XML** package, to get the `<p></p>` tags using *XPATH*:


```r
# Getting and parsing the HTML
html = getURL(input$url)
doc.html = htmlTreeParse(html, useInternal = TRUE)
doc.text = unlist(xpathApply(doc.html, '//p', xmlValue))
              
# Cleaning some special chars about spacing, tabbing and line ending
doc.text = gsub('\\n', ' ', doc.text)
doc.text = gsub('\\r', ' ', doc.text)
doc.text = gsub('\\t', ' ', doc.text)
```

## Text Processing

In this phase, the **tm** package is used to transform the text in a Term-Document Matrix with the frequecy of each word in each document. Also, the following code apply some important transformations in the text, as explained in the code:


```r
# Transforming in a Corpora
myCorpus <- Corpus(VectorSource(doc.text))

# Lowering all the words to be counted as the same
myCorpus <- tm_map(myCorpus, content_transformer(tolower))

# Removes punctuation
myCorpus <- tm_map(myCorpus, removePunctuation)

# Removes numbers
myCorpus <- tm_map(myCorpus, removeNumbers)

# Removes stopwords according to the language selected
myCorpus <- tm_map(myCorpus, removeWords, stopwords(input$lang))
                
# Transforming in a Term Document Matrix
myDtm <- TermDocumentMatrix(myCorpus, control = list(minWordLength = 3))
                
# Computing the overwall frequencies
m <- as.matrix(myDtm)
v <- sort(rowSums(m), decreasing = TRUE)
```







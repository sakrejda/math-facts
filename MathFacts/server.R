library(shiny)
library(dplyr)
library(ggplot2)
library(lubridate)


# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  source("basics.R")
  question <- new('math_question', `*`, 10)
  correct <- vector(mode='logical')
  answers <- vector(mode='numeric')

  output$prompt <- renderText({
    freshMax()
    question$adjust_max(max)
    return(txt)
  })

  freshMax <- reactive({
    question$adjust_max(input$max)
  })

  output$visualize <- renderPlot({
    pl <- ggplot(
      data=question$table__ %>% mutate(prod =a*b), 
      aes(x=prod, y=timing, colour=factor(pair))
    ) + geom_line() + geom_point() + 
        xlab("Answer") + ylab("Time (s)")
    return(pl)
  })

  output$grid <- renderPlot({
    pl <- ggplot(
      data=question$table__,
      aes(x=a, y=b, fill=timing),
    ) + geom_raster() + xlab('a') + ylab('b') +
      scale_x_discrete(expand=c(0,0)) +
      scale_y_discrete(expand=c(0,0))
    return(pl)
  })

  checkAnswer <- reactive({
    if (input$answer != '') 
      test()
    
  })

  test <- reactive({
    o <- question$check(isolate(input$answer))
    answers <<- c(answers, question$answer__)
    correct <<- c(correct, o[['correct']])
    if (isTRUE(o[['correct']])) {
      updateTextInput(session, 'answer', value="")
    }
  })

  output$feedback <- renderText({
    checkAnswer()
    if (isTRUE(correct[length(correct)])) {
      return(paste("Correct!"))
    } else {
      return(paste("Go go go!"))
    }
  })

})




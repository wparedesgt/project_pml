
shinyServer(function(input, output) {
  
  output$PredictWord <- renderPrint({
   
    
    nextword_wp <- next_word(as.character(input$inputString))
    nextword_wp
     
  })
})
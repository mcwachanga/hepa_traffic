library(shiny)
library(rjson)

#base url to fetch data
baseUrl <-"http://nairobitraffic-server.elasticbeanstalk.com/api/trafficRecord/"

#shiny server to process input and output
shinyServer(function(input,output){
  
  output$trafficData <- renderTable({
    
    #url manipulation
    sectionUrl <- paste("section",input$section, sep="=")
    limitUrl <- paste("limit",input$limit,sep="=")
    url <- paste(baseUrl,paste(sectionUrl,limitUrl,sep="&"),sep="?")
    
    #JSON response from rest endpoint
    response <- scan(url, "", sep="\n")
    
    #convert response from JSON ro list
    responseList <- fromJSON(response)
    
    #get the results from the response
    results <- responseList$results
    
    #convert results from list to dataframe
    do.call(rbind, lapply(results, function(input){
      #Convert a traffic object to a row
      return(as.data.frame(input))
    }))
    
  })
})
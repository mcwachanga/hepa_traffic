library(rjson)

#REST endpoint for nairobi's traffic
url <-"http://nairobitraffic-server.elasticbeanstalk.com/api/trafficRecord/"

#JSON response from rest endpoint
response <- scan(url, "", sep="\n")

#convert response from JSON ro list
responseList <- fromJSON(response)

#get the results from the response
results <- responseList$results

#convert results from list to dataframe
trafficData <- do.call(rbind, lapply(results, function(input){
  #Convert a traffic object to a row
  row <- as.data.frame(input)
  return(row)
}))

#update the column names
names(trafficData) <- c("ID", "Section Name", "Traffic Rate", "Timestamp")





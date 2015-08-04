library(rjson)
library(lubridate)
library(zoo)
library(timeSeries)

#REST endpoint for nairobi's traffic
url <-"http://nairobitraffic-server.elasticbeanstalk.com/api/trafficRecord/?section=kenyatta-ave-west-into-rndbt&limit=1500"

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
  row$sectionName <- as.character(row$sectionName)
  row$recordedDate <- as.character(row$recordedDate)
  return(row)
}))

#remove id and section name columns
trafficData <- trafficData[,c(-1,-2)]

#convert recorded date column to DateTime
trafficData$recordedDate <- ymd_hms(trafficData$recordedDate, tz="GMT")

#create time series object
ordered <- zoo(trafficData$trafficRate , order.by = trafficData$recordedDate)

#create regular intervals of 15 minutes
regular <- aggregate(ordered, time(ordered) - as.numeric(time(ordered)) %% 900, mean)

#convert to regular timeseries
regular <- as.timeSeries(regular)

plot(regular)

#update the column names
names(trafficData) <- c("Traffic Rate", "Timestamp")


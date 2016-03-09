require(twitteR)
require(RCurl)
require(jsonlite)

#reading json data from local system
import_data <- fromJSON(paste(readLines('C:/UB Spring Semester 2016/DIC/Project 1/Question 1/Final Set/file1.json'), collapse=""))
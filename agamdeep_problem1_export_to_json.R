library(twitteR)
library(df2json)
library(jsonlite)

setup_twitter_oauth("240BBot9iFUXjMLlLSE5gD1qe", "raCdt81doEigQWzAGERJj3cJutXuGgXAwrtVZwStYoPaVO2GuJ",
                    "704839795655069696-P0dl86rlJQUU1SveJl4kRKD6y9TjqKD",
                    "KuuUKw8aNe53xFpKtVwGUzHIx3AQfyLTCcoYdkRi2janf")

tweetslst<- searchTwitter("newton", n=30, lang="en", since = as.character(Sys.Date()-7))
tweets2lst <- searchTwitter("god", n=30, lang="en", since = as.character(Sys.Date()-7))
tweetsdf <- twListToDF(tweetslst)
tweets2df <- twListToDF(tweets2lst)

#exporting and saving json file
exp1 <- toJSON(tweetsdf)
write(exp1, "C:/UB Spring Semester 2016/DIC/Project 1/Question 1/Final Set/file1.json")
exp2 <- toJSON(tweets2df)
write(exp2, "C:/UB Spring Semester 2016/DIC/Project 1/Question 1/Final Set/file2.json")

#connect all libraries
library(twitteR)
library(ROAuth)
library(plyr)
library(dplyr)
library(stringr)
library(ggplot2)


#authorizing with twitter api
setup_twitter_oauth("240BBot9iFUXjMLlLSE5gD1qe", "raCdt81doEigQWzAGERJj3cJutXuGgXAwrtVZwStYoPaVO2GuJ",
                    "704839795655069696-P0dl86rlJQUU1SveJl4kRKD6y9TjqKD", "KuuUKw8aNe53xFpKtVwGUzHIx3AQfyLTCcoYdkRi2janf")

#tweet data setup
sales_tweets_positive <- 0
sales_tweets_negative <- 0
rental_tweets_positive <- 0
rental_tweets_negative <- 0

#access tweets and create cumulative file
#sales related tweets
sale_tweets <- searchTwitter("sale property in new york city", n=100)

#rent related tweets
rent_tweets <- searchTwitter("rent property in new york city", n=100)

#list for positive and negative words
positive_words <- c(scan("C:/UB Spring Semester 2016/DIC/Project 1/Question 4/positive_words_list.txt", what='character', comment.char=';'))
negative_words <- c(scan("C:/UB Spring Semester 2016/DIC/Project 1/Question 4/negative_words_list.txt", what='character', comment.char=';'))

require(plyr)
require(stringr)

for(s in sale_tweets) {
  sentence = s$text
  sentence = gsub('[[:punct:]]', '', sentence)
  sentence = gsub('[[:cntrl:]]', '', sentence)
  sentence = gsub('\\d+', '', sentence)
  
  word.list = try(str_split(sentence, '\\s+'))
  if (inherits(word.list, "try-error")) {
    warning("error in split")
  }

  words = try(unlist(word.list))
  if (inherits(words, "try-error")) {
    warning("error in unlist")
  }

  positive_matches = match(words, positive_words)
  negative_matches = match(words, negative_words)
  positive_matches = !is.na(positive_matches)
  negative_matches = !is.na(negative_matches)
  score = sum(positive_matches) - sum(negative_matches)
  score = sum(positive_matches) - sum(negative_matches)
  
  if(score < 0) {
    sales_tweets_negative = sales_tweets_negative + 1;
  } else {
    sales_tweets_positive = sales_tweets_positive + 1;
  }
}

sales_tweets_total <- c(sales_tweets_positive, sales_tweets_negative)

require(plyr)
require(stringr)

for(s in rent_tweets) {
  sentence = s$text
  
  sentence = gsub('[[:punct:]]', '', sentence)
  sentence = gsub('[[:cntrl:]]', '', sentence)
  sentence = gsub('\\d+', '', sentence)
  
  word.list = try(str_split(sentence, '\\s+'))
  if (inherits(word.list, "try-error")) {
    warning("cannot break word anymore")
    return(0)
  }
  
  words = try(unlist(word.list))
  if (inherits(words, "try-error")) {
    warning("cannot in unlist")
    return(0)
  }
  
  positive_matches = match(words, positive_words)
  negative_matches = match(words, negative_words)
  positive_matches = !is.na(positive_matches)
  negative_matches = !is.na(negative_matches)
  score = sum(positive_matches) - sum(negative_matches)
  
  if(score < 0) {
    rental_tweets_negative = rental_tweets_negative + 1;
  } else {
    rental_tweets_positive = rental_tweets_positive + 1;
  }
}

rental_tweets_total <- c(rental_tweets_positive, rental_tweets_negative)
result_matrix <- matrix(c(rental_tweets_total[1],sales_tweets_total[1],rental_tweets_total[2],sales_tweets_total[2]),ncol = 2, byrow = T)
colnames(result_matrix) <- c("Rentals", "Sales")
rownames(result_matrix) <- c("Positive","Negative")
#plotting barpolot of resulting data
barplot(result_matrix, main="Real estate Sales vs Rental",xlab="# of tweets", col=c("green","yellow"),legend = rownames(result_matrix), beside=T, ylim = c(0,100))
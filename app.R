library (shiny)
ui<- fluidPage(
  headerPanel('USA 2016 Presidential Elections'),
  sidebarPanel(
    selectInput('xcol','States', c("New York", "California","Texas", "Arizona")),
    selectInput('ycol','Type of trend', c("Daily","Weekly"))
  ),
  mainPanel(
    plotOutput('plot1')
  )
)

server<- function(input, output) {
  selectedData<-reactive({
    iris[, c(input$xcol, input$ycol)]
  })
  output$plot1 <- renderPlot({
    state <- input$xcol
    isweekly<-input$ycol
    
    require(twitteR)
    require(RCurl)
    require(ROAuth)
    require(streamR)
    credential <- OAuthFactory$new(consumerKey='240BBot9iFUXjMLlLSE5gD1qe',
                                   consumerSecret='raCdt81doEigQWzAGERJj3cJutXuGgXAwrtVZwStYoPaVO2GuJ',
                                   requestURL='https://api.twitter.com/oauth/request_token',
                                   accessURL='https://api.twitter.com/oauth/access_token',
                                   authURL='https://api.twitter.com/oauth/authorize')
    options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
    download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")
    credential$handshake(cainfo="cacert.pem")
    
    if(isweekly == "Daily") {
      if(state == "New York")
      {
        filterStream( file.name="tweets_result1.json",
                      track="trump", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_trump <- tweet_df[which(tweet_df$location =="New York" | tweet_df$location == "NY"| tweet_df$location == "NYC"),]
        
        filterStream( file.name="tweets_result12.json",
                      track="clinton", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result12.json')
        election_tweets_clinton <- tweet_df[which(tweet_df$location =="New York" | tweet_df$location == "NY"| tweet_df$location == "NYC"),]
        
        filterStream( file.name="tweets_re3.json",
                      track="sanders", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_re3.json')
        election_tweets_sanders <- tweet_df[which(tweet_df$location =="New York" | tweet_df$location == "NY"| tweet_df$location == "NYC"),]
        
        filterStream( file.name="tweets_re4.json",
                      track="cruz", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_re4.json')
        election_tweets_cruz <- tweet_df[which(tweet_df$location =="New York" | tweet_df$location == "NY"| tweet_df$location == "NYC"),]
      }else if(state == "California")
      {
        filterStream( file.name="tweets_result1.json",
                      track="trump", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_trump <- tweet_df[which(tweet_df$location == "California"| tweet_df$location == "CA"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="clinton", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_clinton <- tweet_df[which(tweet_df$location == "California"| tweet_df$location == "CA"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="sanders", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_sanders <- tweet_df[which(tweet_df$location == "California"| tweet_df$location == "CA"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="cruz", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_cruz <- tweet_df[which(tweet_df$location == "California"| tweet_df$location == "CA"),]
      }else if(state == "Texas")
      {
        filterStream( file.name="tweets_result1.json",
                      track="trump", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_trump <- tweet_df[which(tweet_df$location == "Texas"| tweet_df$location == "TX"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="clinton", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_clinton <- tweet_df[which(tweet_df$location == "Texas"| tweet_df$location == "TX"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="sanders", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_sanders <- tweet_df[which(tweet_df$location == "Texas"| tweet_df$location == "TX"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="cruz", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_cruz <- tweet_df[which(tweet_df$location == "Texas"| tweet_df$location == "TX"),]
      }else if(state == "Arizona")
      {
        filterStream( file.name="tweets_result1.json",
                      track="trump", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_trump <- tweet_df[which(tweet_df$location == "Arizona"| tweet_df$location == "AZ"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="clinton", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_clinton <- tweet_df[which(tweet_df$location == "Arizona"| tweet_df$location == "AZ"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="sanders", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_sanders <- tweet_df[which(tweet_df$location == "Arizona"| tweet_df$location == "AZ"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="cruz", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_cruz <- tweet_df[which(tweet_df$location == "Arizona"| tweet_df$location == "AZ"),]
      }
    } else 
    {
      if(state == "New York")
      {
        filterStream( file.name="tweets_result1.json",
                      track="trump", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_trump <- tweet_df[which(tweet_df$location =="New York" | tweet_df$location == "NY"| tweet_df$location == "NYC"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="clinton", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_clinton <- tweet_df[which(tweet_df$location =="New York" | tweet_df$location == "NY"| tweet_df$location == "NYC"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="sanders", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_sanders <- tweet_df[which(tweet_df$location =="New York" | tweet_df$location == "NY"| tweet_df$location == "NYC"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="cruz", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_cruz <- tweet_df[which(tweet_df$location =="New York" | tweet_df$location == "NY"| tweet_df$location == "NYC"),]
      }else if(state == "California")
      {
        filterStream( file.name="tweets_result1.json",
                      track="trump", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_trump <- tweet_df[which(tweet_df$location == "California"| tweet_df$location == "CA"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="clinton", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_clinton <- tweet_df[which(tweet_df$location == "California"| tweet_df$location == "CA"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="sanders", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_sanders <- tweet_df[which(tweet_df$location == "California"| tweet_df$location == "CA"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="cruz", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_cruz <- tweet_df[which(tweet_df$location == "California"| tweet_df$location == "CA"),]
      }else if(state == "Texas")
      {
        filterStream( file.name="tweets_result1.json",
                      track="trump", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_trump <- tweet_df[which(tweet_df$location == "Texas"| tweet_df$location == "TX"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="clinton", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_clinton <- tweet_df[which(tweet_df$location == "Texas"| tweet_df$location == "TX"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="sanders", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_sanders <- tweet_df[which(tweet_df$location == "Texas"| tweet_df$location == "TX"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="cruz", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_cruz <- tweet_df[which(tweet_df$location == "Texas"| tweet_df$location == "TX"),]
      }else if(state == "Arizona")
      {
        filterStream( file.name="tweets_result1.json",
                      track="trump", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_trump <- tweet_df[which(tweet_df$location == "Arizona"| tweet_df$location == "AZ"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="clinton", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_clinton <- tweet_df[which(tweet_df$location == "Arizona"| tweet_df$location == "AZ"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="sanders", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_sanders <- tweet_df[which(tweet_df$location == "Arizona"| tweet_df$location == "AZ"),]
        
        filterStream( file.name="tweets_result1.json",
                      track="cruz", tweets=100000, oauth=credential, timeout=10, lang='en')
        tweet_df <- parseTweets(tweets='tweets_result1.json')
        election_tweets_cruz <- tweet_df[which(tweet_df$location == "Arizona"| tweet_df$location == "AZ"),]
      }
    }
    
    lengths <- matrix(c(length(election_tweets_trump$text),length(election_tweets_clinton$text),length(election_tweets_sanders$text),length(election_tweets_cruz$text)),ncol = 4, byrow = T)
    colnames(lengths) <- c("Trump", "Clinton", "Sanders", "Cruz")
    barplot(lengths, main = "Presidential Elections 2016", legend = T, ylab = "# of tweets", col = "green")
    
    
  } )
}
shinyApp(ui = ui, server = server)
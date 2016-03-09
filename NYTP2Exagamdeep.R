library(ggplot2)

data1 <- read.csv("C:/UB Spring Semester 2016/DIC/Project 1/Question 2/nyt1.csv")

#new column dayOfWeek
data1$dayOfWeek <- paste('2012','05',1, sep = '-')
x <- 1

while(x < 31) {
  x <- x+1
  link <- paste("C:/UB Spring Semester 2016/DIC/Project 1/Question 2/nyt",x,".csv", sep = "")
  temp <- read.csv(link)
  temp$dayOfWeek <- paste('2012','05',as.character(x), sep = '-')
  data1 <- rbind(temp, data1)
}

#plotting all graphs

monthly_impressions <- aggregate(data1$Impressions, by=list(dayOfWeek = data1$dayOfWeek), sum)
ggplot(monthly_impressions, aes(dayOfWeek, x, group=1)) + geom_line() + labs(x="Days", y= "impressions" ,title = "Impressions By Days") + geom_smooth(method=lm)
monthly_clicks <- aggregate(data1$Clicks, by=list(dayOfWeek = data1$dayOfWeek), sum)
ggplot(monthly_clicks, aes(dayOfWeek, x, group=1)) + geom_line() + labs(x="Days", y= "clicks" ,title = "Clicks By Days") + geom_smooth(method=lm)
monthly_signins <- aggregate(data1$Signed_In, by=list(dayOfWeek = data1$dayOfWeek), sum)
ggplot(monthly_impressions, aes(dayOfWeek, x, group=1)) + geom_line() + labs(x="Days", y= "sign-ins" ,title = "Sign-in By Days") + geom_smooth(method=lm)

#metrics for all data summary
attach(data1)
model <- lm(Clicks ~ Impressions + Signed_In + Age)
summary(model)
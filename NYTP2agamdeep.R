
library(gplots)
library(ggplot2)
library(corrplot)

#data fetching
data1 <- read.csv("C:/UB Spring Semester 2016/DIC/Project 1/Question 2/nyt1.csv")

#categorizing users
data1$cat <-cut(data1$Age,c(-Inf,0,18,24,34,44,54,64,Inf))

#new column has_clicked
data1$has_clicked <- ifelse(data1$Clicks>=1, 1, 0)
ggplot(subset(data1, Impressions>0), aes(x=Clicks/Impressions,colour=cat)) + geom_density()
ggplot(subset(data1, Clicks>0), aes(x=Clicks/Impressions,colour=cat)) + geom_density()
hist(data1$has_clicked, data = data1, col = c("green", "blue"), main = "Click wise users")
with(with(data1, aggregate(x=list(Y=data1$Clicks), by=list(A=data1$cat, B=data1$Gender),mean)), interaction.plot(x.factor=A, trace.factor=B, response=Y, type='b',main = "All age groups clicked",xlab = "Groups", ylab= "# of clicks"))
with(with(data1, aggregate(x=list(Y=data1$Impressions), by=list(A=data1$cat, B=data1$Gender),mean)), interaction.plot(x.factor=A, trace.factor=B, response=Y, type='b',main = "Age Group Categorized",xlab = "Groups", ylab= "# of impressions"))
res <- as.data.frame(sapply(data1[,], as.numeric))
fun <- function(x) {quantile(x, probs=0:10/10)}
ggplot(data1, aes(x=Impressions, fill=cat))+geom_histogram(binwidth=1.0)
ggplot(data1, aes(x=cat, y=Impressions, fill=cat))+geom_boxplot()
apply(res[, 1:dim(res)[2]], 2, fun)


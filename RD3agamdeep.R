library(gdata)
data1 <- read.xls("C:/UB Spring Semester 2016/DIC/Project 1/Question 3/data/rollingsales_manhattan.xls", perl = "C:/Strawberry/perl/bin/perl.exe", pattern = "BOROUGH")

#Here removing all erroneous or extra data
names(data1)<-tolower(names(data1))
#Converting sale price to numeric
data1$sale.price.n<- as.numeric(gsub("[^[:digit:]]","",data1$sale.price))

#Converting gross sqft to numeric
data1$gross.sqft<-as.numeric(gsub("[^[:digit:]]","",data1$gross.square.feet))

#Converting sqft to numeric
data1$land.sqft<-as.numeric(gsub("[^[:digit:]]","",data1$land.square.feet))

#Converting gross sqft to numeric
data1$sale.date<-as.Date(data1$sale.date)
data1$year.built<-as.numeric(as.character(data1$year.built))

attach(data1)
#plotting graphs for different scenerios
hist(land.sqft[sale.price.n == 0], col = "blue", main= "Land.sqft")
hist(gross.sqft[sale.price.n == 0], col = "pink", main = "Gross.sqft")
hist(sale.price.n, col= "purple", main = "Sale.Price.n")
hist(sale.price.n[sale.price.n > 0], col= "green", main = "Sale.Price.n")

detach(data1)
data1.sale <- data1[data1$sale.price.n != 0,]

#plotting sales price
plot(data1.sale$gross.sqft, data1.sale$sale.price.n, col= c('blue', 'green', 'red'))

#noice removal by applying log
plot(log(data1.sale$gross.sqft), log(data1.sale$sale.price.n), col = c('blue', 'green', 'red'))
plot (log(data1.sale[which(grepl("FAMILY",data1.sale$building.class.category)),]$gross.sqft),
      log(data1.sale[which(grepl("FAMILY",data1.sale$building.class.category)),]$sale.price.n),col = c('blue', 'green', 'red'))
#Combining data from all states
library(gdata)
data1 <- read.xls("C:/UB Spring Semester 2016/DIC/Project 1/Question 3/data/rollingsales_manhattan.xls", 
                  perl = "C:/Strawberry/perl/bin/perl.exe", pattern = "BOROUGH")

#data from bronx
bronx_data <- read.xls("C:/UB Spring Semester 2016/DIC/Project 1/Question 3/data/rollingsales_bronx.xls",
                       perl = "C:/Strawberry/perl/bin/perl.exe", pattern = "BOROUGH")
#appending data
data1 <- rbind(bronx_data, data1)

#data from brooklyn
brooklyn_data <- read.xls("C:/UB Spring Semester 2016/DIC/Project 1/Question 3/data/rollingsales_brooklyn.xls",
                          perl = "C:/Strawberry/perl/bin/perl.exe", pattern = "BOROUGH")
data1 <- rbind(brooklyn_data, data1)

#data from queens
queens_data <- read.xls("C:/UB Spring Semester 2016/DIC/Project 1/Question 3/data/rollingsales_queens.xls",
                        perl = "C:/Strawberry/perl/bin/perl.exe", pattern = "BOROUGH")
data1 <- rbind(queens_data, data1)

#data from statenisland
statenisland_data <- read.xls("C:/UB Spring Semester 2016/DIC/Project 1/Question 3/data/rollingsales_statenisland.xls",
                              perl = "C:/Strawberry/perl/bin/perl.exe", pattern = "BOROUGH")
data1 <- rbind(statenisland_data, data1)

#Performing EDA on combined data
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
hist(land.sqft[sale.price.n == 0],col = "blue", main= "Land.sqft")
hist(gross.sqft[sale.price.n == 0], col = "pink", main = "Gross.sqft")
hist(sale.price.n,  col= "purple", main = "Sale.Price.n")
hist(sale.price.n[sale.price.n > 0], col= "green", main = "Sale.Price.n")

detach(data1)
data1.sale <- data1[data1$sale.price.n != 0,]

#plotting sales price
plot(data1.sale$gross.sqft, data1.sale$sale.price.n, col= c('blue', 'green', 'red'))

#noice removal by applying log
plot(log(data1.sale$gross.sqft), log(data1.sale$sale.price.n),col = c('blue', 'green', 'red'))
plot (log(data1.sale[which(grepl("FAMILY",data1.sale$building.class.category)),]$gross.sqft),
      log(data1.sale[which(grepl("FAMILY",data1.sale$building.class.category)),]$sale.price.n),
      col = c('blue', 'green', 'red'))
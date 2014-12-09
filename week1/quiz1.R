# setwd("/Users/Paul/Desktop/R/Getting and Cleaning Data/")

data <- read.table( "getdata-data-ss06hid.csv", 
                    sep = ",", 
                    nrows = 6497,
                    header = TRUE )

## Answer#1: Read property more than 1M
table(data[,c("VAL")] >= 24 )

## Read data of FES
table(data[,c("FES")])

## Answer#3: Exported from excel file to CSV
## having some problems with xlsx package
data_3 <- read.csv("hw1_data_3.csv")
sum(data_3$Zip * data_3$Ext, na.rm=T) 

## Answer#4: XMLs
library(XML)
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
rootNode <- xmlRoot(doc)

table(xpathSApply(rootNode,"//zipcode",xmlValue))["21231"]

## Answer#5: DT
file_5 = "getdata-data-ss06pid.csv"
library(data.table)
DT <- fread(file_5)

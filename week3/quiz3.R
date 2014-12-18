## 1
data <- read.csv( "getdata-data-ss06hid.csv", 
                    sep = ",", 
                    nrows = 6497,
                    header = TRUE )

agricultureLogical <- data[which(data$ACR == 3 & data$VAL >= 2),data$row.name]
ans1 <- head(agricultureLogical, n = 3)

## 2
library(jpeg)
d_image <- readJPEG("getdata-jeff.jpg",
                    native = TRUE)
ans2 <- quantile(d_image,probs=c(.3,.8))

## 3
gdp_data <- read.csv( "getdata-data-GDP.csv", 
                      sep = ",", 
                      header = TRUE, skip = 4,
                      na.strings = c(""))

country_data <- read.csv( "getdata-data-EDSTATS_Country.csv", 
                          sep = ",", 
                          header = TRUE )

sort(gdp_data$X.4, desc = FALSE)
gdp_clean <- gdp_data[!is.na(gdp_data[1]),names(gdp_data) %in% c("X","X.3")]
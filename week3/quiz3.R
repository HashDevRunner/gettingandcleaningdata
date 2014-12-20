##========================================================================
## 1
data <- read.csv( "getdata-data-ss06hid.csv", 
                    sep = ",", 
                    nrows = 6497,
                    header = TRUE,
                    na.string = c(""))

agricultureLogical <- data$ACR == 3 & data$VAL >= 2
# agricultureLogical <- data[which(data$ACR == 3 & data$VAL >= 2),data$row.name]
ans1 <- head(data[which(agricultureLogical),], n = 3)

##========================================================================
## 2
library(jpeg)
d_image <- readJPEG("getdata-jeff.jpg",
                    native = TRUE)
ans2 <- quantile(d_image,probs=c(.3,.8))

##========================================================================
## 3
gdp_data <- read.csv( "getdata-data-GDP.csv", 
                      sep = ",", 
                      header = TRUE, skip = 4,
                      na.strings = c("",".."),
#                       quote = "\"",
#                       strip.white = TRUE,
                      stringsAsFactors = FALSE)

country_data <- read.csv( "getdata-data-EDSTATS_Country.csv", 
                          sep = ",", 
                          header = TRUE )

#Select only interested columns
gdp_data <- gdp_data[,c(1,2,4,5)]
names(gdp_data) <- c("CountryCode","Rank","Long.Name","GDP")

good <- complete.cases(gdp_data$CountryCode, gdp_data$GDP,gdp_data$Rank)
gdp_clean <- gdp_data[good,]

#remove ',' in the numericals
gdp_clean$GDP <- as.numeric(gsub(",","",gdp_clean$GDP)) 
merge_data <- merge(gdp_clean,
                    country_data,
                    by.x = "CountryCode", by.y = "CountryCode")
merge_data <- merge_data[order(merge_data$GDP,decreasing = FALSE),]
matches <- nrow(merge_data)
rank13 <- merge_data[c(13),which(names(merge_data)%in%c("Long.Name.y"))]
ans3 <- list(matches,as.character(rank13))

##========================================================================
## 4
merge_data$Rank <- as.numeric(merge_data$Rank)
OECD <- merge_data[merge_data$Income.Group == "High income: OECD",]
ave_rank_OECD <- mean(OECD$Rank)

non_OECD <- merge_data[merge_data$Income.Group == "High income: nonOECD",]
ave_rank_non_OECD <- mean(non_OECD$Rank)
ans4 <- c(ave_rank_OECD, ave_rank_non_OECD)

##========================================================================
## 5
# re-arrange to decreasing GDP
merge_data <- merge_data[order(merge_data$GDP,decreasing = TRUE),]

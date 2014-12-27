##1
df <- read.csv("getdata-data-ss06hid.csv")
ans1 <- unlist(strsplit(names(df)[109:188],"wgtp",fixed=TRUE))[123]
print(ans1)

##2
df_gdp <- read.csv("getdata-data-GDP.csv", 
                   skip = 4, 
                   na.strings = c("..",""))
df_gdp$X.4 <- gsub(",","",df_gdp$X.4)
ans3 <- mean(as.numeric(df_gdp$X.4), na.rm = TRUE)
print(ans3)

##3
ans4 <- df_gdp[grep("^United",df_gdp$X.3),]
print(ans4)

##4
df_country <- read.csv("getdata-data-EDSTATS_Country.csv")
ans4 <- df_country[grep("June 30",df_country$Special.Notes),"CountryCode"]
ans4 <- length(as.character(ans4))
print(ans4)

##5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
year2012 <- sampleTimes >= as.Date("2012-01-01") & sampleTimes <= as.Date("2012-12-31")
year2012 <- sampleTimes[year2012]
mondays <- table(format(year2012,"%A"))["Monday"]
ans5 <- c(data2012=length(year2012),mondays[1])
print(ans5)
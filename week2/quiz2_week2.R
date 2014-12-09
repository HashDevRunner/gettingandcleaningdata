# setwd("/Users/Paul/Desktop/R/Getting and Cleaning Data/")

#From: https://github.com/hadley/httr/blob/master/demo/oauth2-github.r
library(httr)
GITHUB_CONSUMER_SECRET <- "97b235e82834c69cbf323938cc66ec5008fdc2c6"
oauth_endpoints("github")

myapp <- oauth_app("github", "2ebf5f3f6462bff2e469", secret = GITHUB_CONSUMER_SECRET)
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
response_json <- content(req, as = "text")

library(jsonlite)

#put response req into a data frame using jsonlite
doc <- fromJSON(response_json)
ans <- doc[doc$name == "datasharing",c(2,45)]
print(ans) #answer to 1

#----------- number 2 ----------------
library(sqldf)
acs <- read.csv("getdata-data-ss06pid.csv")
query <- c("select agep,pwgtp1 from acs where AGEP < 50")
sqldf(query)

#----------- number 4 ----------------
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
html_lines <- c(10,20,30,100)
nchar(htmlCode[html_lines]) #answer to 4

#----------- number 5 ----------------
n_offsets <- c(-1,9,-5,rep(c(4,4,-5),3),4,4)
colnames = c("Week", 
             "Nino1+2 SST", "Nino1+2 SSTA",
             "Nino3 SST", "Nino3 SSTA",
             "Nino34 SST", "Nino34 SSTA",
             "Nino4 SST", "Nino4 SSTA")
df_5 <- read.fwf("getdata-wksst8110.for",
                 widths = n_offsets,
                 skip = 4,
                 col.names = colnames)

ans5 <- sum(df_5[,4])
print(cat("Answer 5:",ans5[1]))

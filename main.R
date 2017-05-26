
library(shiny)
library(ggplot2)
library(plyr)
library(googleVis)
library(shinyapps)
library(scales)
library(reshape2)
# library(rjson)
# 

### Raw Data Pre
#  setwd("C:/Users/YACAO/Documents/R/shiny/Audience Sizing/demo")
# rawdata<-read.csv("Raw_Data.csv",header=TRUE)
# save(rawdata,file="rawdata.Rdata")
load("rawdata.Rdata")
rawdata<-audeince.data
# str(rawdata)
for (i in 1:12)
{rawdata[,i]<-as.character(rawdata[,i])}
rawdata$da_flag<-ifelse(rawdata$rad_6 %in% c('6.Greenfield'),'N',rawdata$da_flag)
rawdata$dfs_segment<-ifelse(rawdata$rad_6 %in% c('6.Greenfield','4.Inquirer','5.Retail'),'None',rawdata$dfs_segment)
#  str(rawdata)

# JSON: dataframe input to json using toJSON (in list form)
# makeList<-function(x){ 
#   if(ncol(x)>2){
#     listSplit<-split(x[-1],x[1],drop=T)
#     lapply(names(listSplit),function(y){
#       if(as.character(listSplit[[y]][1,1]) > 0){
#         list(name=y,children=makeList(listSplit[[y]]))
#       } else {
#         list(name=y,size=listSplit[[y]][1,2])
#       }
#     })
#   }else{
#     lapply(seq(nrow(x[1])),function(y){list(name=x[,1][y],size=x[,2][y])})
#   }
# }

# library(rsconnect)
# rsconnect::setAccountInfo(name='yacao1991',token='6B11C714EC613C7B98E4D34CC3A1501B', secret='hvjvQvtT01OLcQLrD9dC3D/foSYTVK11WWq5880z')
# rsconnect::deployApp(account="yacao1991","C:/Users/YACAO/Documents/R/shiny/Audience Sizing/US_Audience")



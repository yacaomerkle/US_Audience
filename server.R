
library(shiny)
library(jsonlite)
source('main.R')

shinyServer(
  function(input, output,session) {
    
    observe({

    # exception handler for when action button is clicked

      #####################################################################
########################### Data Reactive###################################
###########################################################################
      
    
      passData1 <- reactive({
  
        
        if(input$Marketability==F){rawdata$marketability<-NULL}
        if(input$RAD==F){rawdata$rad_6<-NULL}
        if(input$LifeStage==F){  rawdata$life_stage<-NULL}
        if(input$PurModel==F){  rawdata$purchase_model<-NULL}  
        if(input$Segment==F){  rawdata$segment<-NULL}
        if(input$DA==F){  rawdata$da_flag<-NULL}
        if(input$DPA==F){  rawdata$dfs_segment<-NULL}
        if(input$Channel==F){ rawdata$channel<-NULL}
        if(input$ValSeg==F) {  rawdata$value_seg<-NULL}
        if(input$Gamer==F){  rawdata$gamer_decile<-NULL}
        if(input$Rec_sys_1==F){  rawdata$recom_sys_lob_1<-NULL}
        if(input$Rec_sys_2==F){  rawdata$recom_sys_lob_2<-NULL}
  
        
        
        tmp<-rawdata
        measure_cnt<-1
        dimension_cnt<-dim(tmp)[2]-measure_cnt
        Dimension_name<-names(tmp)[1:dimension_cnt]
  
        tmp<-ddply(tmp,Dimension_name,numcolwise(sum)) 
    

        finaldata<-tmp
        finaldata

      
      })
# #####################################################################
# ########################### Data Table###################################
# ###########################################################################  
      
      output$table1<-renderDataTable({
    
        thedata<-passData1()
       
        if(dim(thedata)[1] != 0)
        {thedata$pop<-formatC(thedata$pop,format="f",digits=0,big.mark=",")}
        
      
        print(thedata) 
        
        
        
      },options = list(paging = FALSE,info=FALSE,ordering=FALSE,scrollY="600px", scrollCollapse=TRUE))
      
      
      
# #####################################################################
# ########################### download report###################################
# ###########################################################################        


output$report <- downloadHandler(
     
 
     filename = function() { 
      paste('US Audeince Report', '.csv', sep='') 
                    },
     
    content = function(file) {
    write.csv(passData1(), file,row.names=F)
  }
)


# 
# #####################################################################
# ########################### Summary###################################
# ########################################################################### 
passData2 <- reactive({
  thedata<-passData1()
  
  if(input$Marketability1==F){thedata$marketability<-NULL}
  if(input$RAD1==F){thedata$rad_6<-NULL}
  if(input$LifeStage1==F){  thedata$life_stage<-NULL}
  if(input$PurModel1==F){  thedata$purchase_model<-NULL}  
  if(input$Segment1==F){  thedata$segment<-NULL}
  if(input$DA1==F){  thedata$da_flag<-NULL}
  if(input$DPA1==F){  thedata$dfs_segment<-NULL}
  if(input$Channel1==F){ thedata$channel<-NULL}
  if(input$ValSeg1==F) {  thedata$value_seg<-NULL}
  if(input$Gamer1==F){  thedata$gamer_decile<-NULL}
  if(input$Rec_sys_1_1==F){  thedata$recom_sys_lob_1<-NULL}
  if(input$Rec_sys_2_1==F){  thedata$recom_sys_lob_2<-NULL}
  
  dimension_cnt<-dim(thedata)[2]-1
  dimension_name<-names(thedata)[1:dimension_cnt]
   
  if(dimension_cnt==0){thedata<-NULL}
  if(dimension_cnt>2){thedata<-NULL}
  
  finaldata_1<-thedata
  finaldata_1
  
  
})



# output$table2<-renderDataTable({
#   
#   thedata<-passData2()
#  
#   thedata<-ddply(thedata,names(thedata)[1],summarise,Pop=sum(pop))
#  
#   if(dim(thedata)[1] != 0)
#   {thedata$Pop<-formatC(thedata$Pop,format="f",digits=0,big.mark=",")}
# 
#   print(thedata)
#   
#   
#   
# },options = list(paging = FALSE,info=FALSE,ordering=FALSE,searching=F))
# 
# 
# output$table3<-renderDataTable({
#   
#   thedata<-passData2()
#   dimension_cnt<-dim(thedata)[2]-1
# 
#   
#   thedata<-ddply(thedata,names(thedata)[2],summarise,Pop=sum(pop))
#   
#   if(dim(thedata)[1] != 0)
#   {thedata$Pop<-formatC(thedata$Pop,format="f",digits=0,big.mark=",")}
#   if(dimension_cnt==0){thedata<-NULL}
#   if(dimension_cnt>2){thedata<-NULL}
#   
#   print(thedata)
#   
#   
#   
# },options = list(paging = FALSE,info=FALSE,ordering=FALSE,searching=F))

output$table4<-renderDataTable({
  
  thedata<-passData2()
  dimension_cnt<-dim(thedata)[2]-1
  dimension_name<-names(thedata)[1:dimension_cnt]
  if(dimension_cnt<=1){thedata<-NULL}
  if(dimension_cnt>2){thedata<-NULL}
  
  if(dimension_cnt==2) {
   comb<-combn(dimension_name,2)
  
  thedata<-ddply(thedata,comb[,1],summarise,pop=sum(pop))
      temp<-thedata
      row<-unique(temp[,1])
      col<-unique(temp[,2])
      name<-names(temp)
      temp<-reshape(temp,timevar=names(temp)[2],idvar=names(temp)[1],direction = "wide")
      names(temp)[-1]<-col
      
      for (i in 1:dim(temp)[1]){
        for (j in 2:dim(temp)[2]){
          if (temp[i,j]==''||is.na(temp[i,j])==TRUE)  {temp[i,j]<-''} 
          else {temp[i,j]<-formatC(as.numeric(temp[i,j]),format="f",digits=0,big.mark=",")}
        }
        
      }
  thedata<-temp
  }
 
      
 
  
  
  print(thedata)
  
  
  
},options = list(paging = FALSE,info=FALSE,ordering=FALSE,searching=F))


# #####################################################################
# ###########################  Graph:D3 JS Graph###################################
# ########################################################################### 
passData3 <- reactive({
  
  thedata<-passData2()
  dimension_cnt<-dim(thedata)[2]-1
  dimension_name<-names(thedata)[1:dimension_cnt]
  if(dimension_cnt<=1){thedata<-NULL}
  if(dimension_cnt>2){thedata<-NULL}
  
  if(dimension_cnt==2) 
  {
    
    thedata<-ddply(thedata,dimension_name,summarise,pop=sum(pop))
    
    value<-unique(thedata[,1])
    thedata<-reshape(thedata,timevar=names(thedata)[1],idvar=names(thedata)[2],direction = "wide")
    names(thedata)<-c("State",value)
    for(i in 1:dim(thedata)[1])
    { for (j in 1:dim(thedata)[2])
    { if(is.na(thedata[i,j])==T){thedata[i,j]=0}
      
    }
    
    }
    
  }
    
  
  
  finaldata_2<-thedata
  finaldata_2
  
  
})




thedata<-passData3()
jsonOut<-toJSON(thedata)
session$sendCustomMessage(type="jsondata",jsonOut)
  
    })    
 
})


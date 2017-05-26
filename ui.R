# ui.R
# SHINY & D3JS SIMPLE BINDING

library(shiny)
library(rjson)
source('main.R')

shinyUI(
  navbarPage( 
    title="US Audience Sizing",
    
    footer='',
    
    tabPanel('Overall',
             
       
             
             sidebarPanel(width=2,
                      
                          h4("Dimension"),
                          checkboxInput("RAD", label = "RAD", value = TRUE),
                          checkboxInput("Marketability", label = "Marketability", value = TRUE),
                          checkboxInput("LifeStage", label = "Life Stage", value = T),
                          checkboxInput("Channel", label = "Channel", value = T),
                          checkboxInput("Segment", label = "Segment", value = TRUE),
                          checkboxInput("DA", label = "DA", value = F),
                          checkboxInput("DPA", label = "DPA", value = F),
                          checkboxInput("PurModel", label = "Purchase Model", value = T),
                          checkboxInput("ValSeg", label = "Vlaue Segment", value = F),
                          checkboxInput("Gamer", label = "Gamer Model", value = F),
                          checkboxInput("Rec_sys_1", label = "Top1 Procuct Recommender", value = F),
                          checkboxInput("Rec_sys_2", label = "Top2 Procuct Recommender", value = F),
                          br(),
                          downloadButton("report",  h4("Generate report"))
                          
                          
             )
  
             
             ,
             
             
             
             mainPanel(
               tabsetPanel(id='Summary',
                            
                       
                     tabPanel('Raw Data', dataTableOutput("table1")),
                   
                     tabPanel('Summary',
                              h4("CheckBox (Only select any two)"),
                              column(2,checkboxInput("RAD1", label = "RAD", value = TRUE)),
                              column(2,checkboxInput("Marketability1", label = "Marketability", value = TRUE)),
                            
                              column(2,checkboxInput("LifeStage1", label = "Life Stage", value = F)),
                              column(2,checkboxInput("Channel1", label = "Channel", value = F)),
                              column(2,checkboxInput("Segment1", label = "Segment", value = F)),
                              column(2, checkboxInput("DA1", label = "DA", value = F)),
                              column(2,checkboxInput("DPA1", label = "DPA", value = F)),
                              column(2,checkboxInput("PurModel1", label = "Purchase Model", value = F)),
                              column(2,checkboxInput("ValSeg1", label = "Vlaue Segment", value = F)),
                              column(2,checkboxInput("Gamer1", label = "Gamer Model", value = F)),
                              column(2,checkboxInput("Rec_sys_1_1", label = "Top1 Procuct Recommende", value = F)),
                              column(2,checkboxInput("Rec_sys_2_1", label = "Top2 Procuct Recommende", value = F)),

 
#                               dataTableOutput("table2"),
#                               dataTableOutput("table3"),
                               dataTableOutput("table4"),
                              br() ,
                             #h3("Graph Output:")
                            # load D3JS library
                             tags$head(tags$link(rel = "stylesheet", type = "text/css",href = "style.css")),
                             tags$script(src="http://d3js.org/d3.v3.min.js"),
                             # load javascript
                             tags$script(src="dashboard.js"),
                             tags$script(src="graph.js"),
                             # create div
                             tags$div(id="dashboard")

                              )
                
                    
               ))
               
 
  )
) )


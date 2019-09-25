library(shiny)
library(ggplot2)
library(dplyr)
library(leaflet)
library(plotly)
library(magrittr)


shinyServer(function(input,output){
  dfInput <- reactive({

    a <- total %>% filter(DISTRICT_NAME== input$District) 
    b <- a %>% filter(AGE %in% (0:input$integer))
    c <- b %>% group_by(AGE) %>% count(AGE)
    
    })
  dfInput1 <- reactive({
    
    a <- total %>% filter(DISTRICT_NAME== input$District) 
    b <- a %>% filter(AGE %in% (0:input$integer))
    c <- b %>% group_by(SEX) %>% count(SEX)
    
  })          
  dfInput2 <- reactive({
    
    c <- total %>% filter(DISTRICT_NAME== input$District1) 
    b <- c %>% filter(AGE %in% (0:input$integer1))
    d <- b %>% group_by(CASTE_NAME)%>%summarise(amount = sum(CLAIM_AMOUNT))
  })
  dfInput3 <- reactive({
    
    c <- total %>% filter(DISTRICT_NAME== input$District1) 
    b <- c %>% filter(AGE %in% (0:input$integer1))
    d <- b %>% group_by(CASTE_NAME)%>%count(CASTE_NAME)
  })
  dfInput7 <- reactive({
    
    c1 <- total %>% filter(DISTRICT_NAME== input$District1) 
    c2 <- c1 %>% filter(AGE %in% (0:input$integer1))
    c3 <- c2 %>% group_by(CATEGORY_NAME)%>%count(CATEGORY_NAME)
  })
  dfInput4 <- reactive({
    
    e <- total %>% filter(DISTRICT_NAME == input$District2) 
    f <- e %>% filter(CASTE_NAME == input$caste)
    g <- f %>% group_by(year)%>%count(year)
  })
  dfInput5 <- reactive({
    
    t1 <- total %>% filter(DISTRICT_NAME == input$District2) 
    t2 <- t1 %>% filter(CASTE_NAME == input$caste)
    t3 <- t2 %>% group_by(CATEGORY_NAME)%>%count(CATEGORY_NAME)
    t4 <- t3[order(t3$n),]
    t5 <- tail(t4)
  })
  dfInput6 <- reactive({
    
    w1 <- total %>% filter(DISTRICT_NAME == input$District2) 
    w2 <- w1 %>% filter(CASTE_NAME == input$caste)
    w3 <- w2 %>% group_by(CATEGORY_NAME)%>%count(CATEGORY_NAME)
  })
  
  output$map <- renderLeaflet({
    leaflet(my_data)%>%
      setView(lat = lat,lng = lon,zoom = 6)%>%
      addMarkers(~Longitude,~Latitude,popup = paste("District Name:", my_data$Area_name, "<br>",
                                                    "Total Population:", my_data$Population, "<br>",
                                                    "Male Population:",my_data$males, "<br>",
                                                    "Female Population:",my_data$females ),
    label =~as.character(Area_name))%>%
      addProviderTiles(providers$OpenStreetMap)
      
  })
  output$bar <- renderPlotly({
    new_data1 <- dfInput()
    plot_ly(new_data1, x = ~AGE, y = ~n, type = "bar",color = "green")%>%
      layout(title = 'Count of Age group People using the scheme',
             yaxis = list(title = "Count")) 
    
  })
  output$plot1 <- renderPlotly({
    new_data2 <- dfInput1()
    plot_ly(new_data2,labels = ~SEX,values = ~n,type = "pie")%>%
      layout(title = 'Gender Wise Benifiters of the scheme')
    
  })
  output$bar3 <- renderPlotly({
    new_data3 <- dfInput2()
    plot_ly(new_data3,x = ~CASTE_NAME, y = ~amount,type = "bar")%>%
      layout(title = 'Total amount claim caste wise')
    
  })
  output$plot2 <- renderPlotly({
    new_data4 <- dfInput3()
    plot_ly(new_data4,labels = ~CASTE_NAME,values = ~n,type = "pie")%>%
      layout(title = 'Count of people caste wise')
    
  })
  output$plot5 <- renderPlot({
    new_data8 <- dfInput7()
    wordcloud(words = new_data8$CATEGORY_NAME, freq = new_data8$n, min.freq = 1,
              max.words=1000, random.order=FALSE, rot.per=0.35, 
              colors=brewer.pal(8, "Dark2"))
  }, height = 700, width = 900)
  
  output$bar4 <- renderPlotly({
    new_data5 <- dfInput4()
    plot_ly(new_data5,x = ~year,y = ~n,type = "bar")%>%
      layout(title = 'year wise analysis',xaxis=list(tickformat=',d')) 
    
    
  })
  output$plot3 <- renderPlotly({
    new_data6 <- dfInput5()
    plot_ly(new_data6,labels = ~CATEGORY_NAME,values = ~n,type = "pie")%>%
      layout(title = 'Surgery information')
    
  })
  
  output$plot4 <- renderPlot({
    new_data7 <- dfInput6()
    wordcloud(words = new_data7$CATEGORY_NAME, freq = new_data7$n, min.freq = 1,
              max.words=1000, random.order=FALSE, rot.per=0.35, 
              colors=brewer.pal(8, "Dark2"))
  }, height = 700, width = 900)
})



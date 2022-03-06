library(plotly)
library(shiny)
library(plyr)

#Read file
SuicideRate <- read.csv("SuicideAndGDP.csv", header = TRUE)
colnames(SuicideRate)
SuicideRate$Year <- as.factor(SuicideRate$Year)
SuicideRateBothSex <- filter(SuicideRate, Sex == "Both sexes")


#pie chart data(Q3)
SuicideRateFemaleAndMale <- filter(SuicideRate, Sex %in% c("Female", "Male"))
SuicideRateBygender <- ddply(SuicideRateFemaleAndMale, c("Sex"), summarise, Suicide.Rates.100k.population=mean(Suicide.Rates.100k.population))


# Creating server 

function(input, output) {
  output$SuicideByCountry <- renderPlotly({
    
    #user input country
    SuicideRateBothSex$standout <- ifelse(SuicideRateBothSex$Country == input$standout,
                               input$standout,"Other")
    #categoty the data
    SuicideRateBothSex$standout <- SuicideRateBothSex$standout %>% 
      factor(levels = c(input$standout,"Other"))
    
    #determain the country
    pastel <- ifelse(input$standout == "Country", "Country",
                     "standout")
    #create scatter plot
    plot_ly(SuicideRateBothSex, x = ~SuicideRateBothSex$GDP_for_year...., y = ~SuicideRateBothSex$Suicide.Rates.100k.population, color = ~get(pastel),colors = "Set1",
            size = ~SuicideRateBothSex$Suicide.Rates.100k.population,frame = ~Year, alpha = 1, type = "scatter", mode = "markers") %>% 
      
      layout( title = "Plot of Yearly Suicide Rate and GDP per Capital",
              yaxis = list(zeroline = FALSE, title = "Global suicides(2000) per 100k"), 
              xaxis = list(zeroline = FALSE, title = "GDP per capital",hoverformat="$,f"))
  })
  
  output$GlobalSuicide <- renderPlotly({
   
    #user input country
    SuicideRateBothSex$Q1Country <- ifelse(SuicideRateBothSex$Country == input$Q1Country,
                                          input$Q1Country,"Other")
    #categoty the data
    SuicideRateBothSex$Q1Country <- SuicideRateBothSex$Q1Country %>% 
      factor(levels = c(input$Q1Country,"Other"))
    
    #determain the country
    pastel <- ifelse(input$Q1Country == "Country", "Country",
                     "Q1Country")
    #create bar chart
    plot_ly(SuicideRateBothSex, x = ~SuicideRateBothSex$Country, y = ~SuicideRateBothSex$Suicide.Rates.100k.population, color =~get(pastel),colors = "Set1",
            frame = ~Year, alpha = 1, type = "bar", mode = "markers") %>% 
      
      layout( title = "Global suicide rate/100k by country",
              yaxis = list(zeroline = FALSE, title = "Global suicide rate/100k by country"), 
              xaxis = list(zeroline = FALSE, title = "Country code"))
  })
  
  
  output$SuicideBygender <- renderPlotly({
  
    #create pie chart
    plot_ly(SuicideRateBygender, labels = ~Sex, values = ~Suicide.Rates.100k.population, type = 'pie',mode = "markers") %>%
      layout(title = 'Suicide rate of different gender', xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE), 
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
    
  })
  
  
  output$SuicideBygender2 <- renderPlotly({
    
    #create scatter plot
    SuicideRate %>%
      group_by(SuicideRate$Sex,SuicideRate$Year)%>%
      plot_ly(x=~SuicideRate$Suicide.Rates.100k.population, y=~SuicideRate$Sex,
              frame = ~Year,type="scatter",color=~SuicideRate$Sex, mode = "markers") %>%
    layout( title = "Suicide rate of different gender",
            xaxis = list(zeroline = FALSE, title = "Global suicide rate/100k by country"), 
            yaxis = list(zeroline = FALSE, title = "Gender"))
    
    
  })
  
  
  
}
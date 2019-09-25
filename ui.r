
#UI page creation
shinyUI(fluidPage(
  tags$head(
    tags$style(
      HTML(
        "h5 {color:red;
            font-family: 'Lobster', cursive;
            line-height: 2.0;}
        "
      )
    )
  ),
  setBackgroundColor(
    color = c("#000000","#008080"),
    gradient = "radial",
    direction = c("top", "left")
  ),
  theme = shinytheme("cerulean"),
 navbarPage("NTR AROGYA SEVA",
                   
 tabPanel("Age Analysis",

  titlePanel("GENDER WISE VISUALIZATION OF PARTICULAR DISTRICT "),
  
  fluidRow(
  column(3,
    
    selectInput(inputId = "District",
                label ="District",
                choices=area_name,
                selected = "Krishna" 
                ),
    
    br(),br(),br(),
    sliderInput("integer", "AGE",
                min = 0, max = 100,
                value = 25),
    br(),
    h5("The Side bar panel visualization which helps to filter the data based on the district and age."),
    h5("The bar chart represnts the count of people who are getting benifited in the scheme with in the district."),
      h5(" The pie chart represnts the gender wise visulaization"),
       h5("The leaflet has the information of districts, and on hover of the leaflets will be seen total 
       population of the District and Case wise people")),
    column(9,
      plotlyOutput("bar"),
      plotlyOutput("plot1"),
      leafletOutput("map"),
      br(),br(),br()
      
    )
  )
  ),
 tabPanel("Caste Based Analysis",
          
          titlePanel("DISTRICT WISE BASED ON CASTE"),
          fluidRow(
            column(3,
              selectInput(inputId = "District1",
                          label ="Choose District",
                          choices=area_name,
                          selected = "Krishna" 
              
              ),
            br(),
            sliderInput("integer1", "AGE",
                        min = 0, max = 100,
                        value = 25),
            br(),br(),br(),
            h5("The Side bar panel visualization which helps to filter the data based on the district and age."),
            h5("The bar chart represnts the sum of the amoun claimed by the different cate people for particular district."),
            h5(" The Pie Chart represents the count of people caste wise in the District"),
            h5("The word cloud shows that district wise which treatment people are getting and also age wise")
            
            ),
            column(9,
              plotlyOutput("bar3"),
              plotlyOutput("plot2"),
              plotOutput("plot5",width = "100%")
              
            )
          
 )
 ),
 tabPanel("Year wise",
          
          titlePanel("YEAR WISE VISUALIZATION"),
          fluidRow(
            column(3,
              selectInput(inputId = "District2",
                          label ="Choose District",
                          choices=area_name,
                          selected = "Krishna" 
              ),
              selectInput(inputId = "caste",
                          label ="choose caste",
                          choices=caste_name,
                          selected = "BC"
              ),
              br(),
              h5("The Side bar panel visualization which helps to filter the data based on the district and Caste."),
              h5("The bar chart represnts the count of people who are getting benifited in the scheme with in the district yearly and can see the trends."),
              h5(" The pie chart represnts count of top surgries under the scheme yearly analysis"),
              h5(" Word cloud shows the Surgery information of all based on district and caste, so that government can know where to concentrate")
              ),
          
            
            column(9,
              
              plotlyOutput("bar4"),
              plotlyOutput("plot3"),
              plotOutput("plot4")
              
            )
            
            
                   
          
            
          )
 )
)))
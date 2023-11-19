#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(rCharts) 
install.packages("rCharts")
library(datasets)
library(ISOcodes)
install.packages("ISOcodes")
data(ISO_3166_1)
require(devtools)
install_github('ramnathv/rCharts')
require(rCharts)
library(showOutput)
install.packages("showOutput")
showOutput(outputId, lib = NULL, package = "rCharts")
install.packages("htmlOutput")

library(readxl)
USStates <- read_excel("Downloads/USStates.xlsx")
View(USStates)

library(readr)
dataverbose <- read_csv("Downloads/dataverbose.csv")
View(dataverbose)

library(readr)
ObservationDataiijxxz <- read_csv("Downloads/ObservationDataiijxxz.csv")
View(ObservationDataiijxxz)


# Define UI for application that draws a histogram
shinyUI(pageWithSidebar(
  headerPanel("Body Mass Index Classification in Adults"),
  sidebarPanel(
    numericInput(inputId="heightM", label="Your height in cm", value= 0,min=0),
    numericInput(inputId="weightM", label="Your weight in kg", value= 0,min=0),
    radioButtons(inputId="gender", label="Gender", choices=c("Female","Male")),
    selectInput(inputId="country", label="Country", choices=sort(ISO_3166_1$Alpha_3),
                multiple = FALSE,selected="USA"),
    conditionalPanel(
      condition = "input.country == 'USA'",
      p("If you live in USA, please choose a state"),
      selectInput(inputId="state", label="State", choices=state.name,
                  multiple = FALSE,selected=NULL)),
    actionButton("goButton", "Go!"),
    br(),
    p(strong(em("Documentation:",a("Body Mass Index Classification in Adults",href="READMe.html")))),
    p(strong(em("Github repository:",a("Developing Data Products - Peer Assessment Project; Shiny App",href="https://github.com/CrazyFarang/DevelopingDataProducts"))))
  ),
  mainPanel(
    tabsetPanel(
      tabPanel('Your results',
               h5('Your BMI coefficient kg/m^2'),
               verbatimTextOutput("BMI"),
               verbatimTextOutput("BMIclass"),
               img(src="WHOBMI.png", height = 600, width =600),
               p("Source: ", a("WHO BMI classification", 
                               href = "http://apps.who.int/bmi/index.jsp?introPage=intro_3.html"))
      ),
      tabPanel('Data Summary',
               h5('Available data for'),
               verbatimTextOutput("country"),
               h5('Gender'),
               verbatimTextOutput("gender"),
               h5('Mean BMI (kg/m2) (crude estimate) and 95% CI'),
               verbatimTextOutput("BMIcrude"),
               p("Source: ", a("WHO Global Health Observatory Data Repository", 
                               href = "http://apps.who.int/gho/data/node.main.A903?lang=en")),
               h5('Recent BMI Indicators'),
               dataTableOutput("BMIcattable"),
               p("Source: ", a("KNOEMA-WHO Global Database on Body Mass Index (BMI)", 
                               href = "http://knoema.com/WHOGDOBMIMay/who-global-database-on-body-mass-index-bmi"))
      ),
      tabPanel('Plot: BMI Indicators',
               h5('Recent BMI Indicators'),
               p("Plotted data are for your gender for your specific country"),
               p("If there are no data for your gender, plotted data are for adults for your specific country"),
               verbatimTextOutput("PlotYear"),
               chartOutput("Plot1","highcharts"),    #showOutput function I cannot find. rCharts did not work. What can be used?
               p("Worldwide Data: ", a("KNOEMA-WHO Global Database on Body Mass Index (BMI)", href = "http://knoema.com/WHOGDOBMIMay/who-global-database-on-body-mass-index-bmi"))
      ),
      tabPanel('Plot: Mean BMI Trend',
               h5('Mean BMI Trend per Years'),
               chartOutput("Plot2","highcharts"),
               p("Source: ", a("WHO Global Health Observatory Data Repository", 
                               href = "http://apps.who.int/gho/data/node.main.A903?lang=en"))
      ),
      tabPanel('Plot: BMI Indicators for US States',
               h5('US States BMI Indicators for Adults '),
               verbatimTextOutput("State"),
               chartOutput("Plot3","highcharts"),
               p("US States Data: ", a("CDC-Behavioral Risk Factor Surveillance System; Prevalence and Trends Data; Overweight and Obesity(BMI)", href = "http://apps.nccd.cdc.gov/brfss/list.asp?cat=OB&yr=2012&qkey=8261&state=All"))
      )
    ),
    p(strong("BMI Assessment"))
  )
)
)

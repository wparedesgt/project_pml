header <- dashboardHeader(title = "CAPSTONE",
                          dropdownMenuOutput("notificaciones"))

sidebar <- dashboardSidebar(
  
  sidebarUserPanel(name = "Word Prediction Application", subtitle = "William V. Paredes"),
  
  sidebarMenu(menuItem("Prediction", tabName = "Prediction", 
                       icon = icon("bezier-curve")), 
              helpText("Enter the words and the application will try to predict the next one in English.")
              ),
  textInput("inputString", "Enter the word here",value = ""),
  width = 450
  
)

body <- dashboardBody(
  
  tabItems(
    tabItem(
      tabName = "Prediction",
      fluidRow(
        box(width = 10, 
            height = 450, 
            textOutput("PredictWord")) 
        
      ))
  )   
)


dashboardPage(header, sidebar, body)



header <- dashboardHeader(title = "COVID19",
                          dropdownMenuOutput("notificaciones"))

sidebar <- dashboardSidebar(
    
    sidebarUserPanel(name = "Data Products Project", subtitle = "William V. Paredes"),
    
    sidebarMenu(
        menuItem("Analysis", tabName = "Analisis", 
                 icon = icon("chart-bar")),
        menuItem("Predictive Model", tabName = "Forecast", 
                 icon = icon("chart-line")),
        dateRangeInput(inputId = "rngDatos", 
                       label = "Data Range:", 
                       start = "2020-03-14",
                       end = Sys.Date(), 
                       min = '2020-03-14',
                       max = Sys.Date(), 
                       language = "en", 
                       separator = "to"),
        submitButton("Renew View")
        
        
    )    
    
)


body <- dashboardBody(
    
    tabItems(
        tabItem(
            tabName = "Analisis",
            fluidRow(
                infoBoxOutput(width = 3, "infoDias"),
                infoBoxOutput(width = 3, "infoCuarentena"),
                infoBoxOutput(width = 3, "infoContagios"),
                infoBoxOutput(width = 3, "infoActivos") 
            ), 
            fluidRow(
                box(width = 10, 
                    height = 450, 
                    highchartOutput("HC_plot_01")), 
                box(width = 2, htmlOutput("gauge02"))
            ),
            fluidRow(
                box(width =10,
                    height = 450, 
                    highchartOutput("HC_plot_02")
                )
            )
        ),
        tabItem(
            tabName = "Forecast", 
            fluidRow(
                box(width = 10,
                    height = 450, 
                    highchartOutput("HC_fore_01")
                )), 
            fluidRow(
                box(width = 10,
                    height = 450,
                    highchartOutput("HC_fore_02")
                ))
        )
        
        
    )   
)


dashboardPage(header, sidebar, body)
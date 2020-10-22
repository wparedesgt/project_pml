
shinyServer(function(input, output) {

    dataInput <- reactive({
        datos_generales <- CargaDatos(input$rngDatos[1], input$rngDatos[2])
    })
    
    #Plots
    
    output$HC_plot_01 <- renderHighchart({
        
        
        withProgress(message = "Wait Please", value = 0, {
            
            incProgress(1/3, detail = "Step 1 for 2")
            Sys.sleep(0.5)
        
            datos_ca <- dataInput()
                
            incProgress(1/3, detail = "Covid en CA")
            Sys.sleep(0.5)
            
            incProgress(1/3, detail = "To step 2")
            Sys.sleep(0.5) })
        
        
        
        
        
        datos_ca %>% hchart("line", hcaes(x = date, y = total_cases_per_million, group = location)) %>% hc_title(text = "Covid19 Central America") %>% hc_subtitle(text = "Infection by Million Habitants") %>% hc_yAxis(title = list(text = "Cases per million")) %>% hc_xAxis(title = list(text = "Date"))  %>% hc_credits(enabled = TRUE, text = "Source: ourworldindata", href = "https://covid.ourworldindata.org",style = list(fontSize = "12px"))
        
    })
    
    
    output$HC_plot_02 <- renderHighchart({
        
        
       withProgress(message = "Please Wait", value = 0, {
                
                incProgress(1/3, detail = "Step 2 for 2")
                Sys.sleep(0.5)
                
                datosgt_01 <- dataInput()
                
                incProgress(1/3, detail = "Covid19 GT")
                Sys.sleep(0.5)
            
                datosgt_01 <- datosgt_01 %>% filter(iso_code == "GTM")
                    
                incProgress(1/3, detail = "Ending")
                Sys.sleep(0.5) })
            
            
            
            datosgt_01 %>% hchart("column", hcaes(x = date, y = new_cases), color = "red") %>% hc_title(text = "COVID19 Guatemala") %>% hc_subtitle(text = "Daily Infections") %>% hc_yAxis(title = list(text = "Daily Confirmed Contagions")) %>% hc_xAxis(title = list(text = "Date"))  %>% hc_credits(enabled = TRUE, text = "Source: ourworldindata", href = "https://covid.ourworldindata.org",style = list(fontSize = "12px"))
        
        
        
    })
    
    
    output$HC_fore_01 <- renderHighchart({
        
        withProgress(message = "Please Wait", value = 0, {
            
            incProgress(1/3, detail = "Step 1 for 2")
            Sys.sleep(0.5)
            
            t_arima_datosgt <- auto.arima(datosgt$total_cases)
            datosgt_forecast <- forecast(t_arima_datosgt, level = c(95,80))
            df_datosgt <- fortify(datosgt_forecast)
            
            incProgress(1/3, detail = "Total Forecast")
            Sys.sleep(0.5)
            
            inicio <- head(datosgt$date, 1)
            
            fecha_pred <- seq(as.Date(inicio), (Sys.Date() + 10), by = "day")
            
            
            df_datosgt$date <- fecha_pred
            
            incProgress(1/3, detail = "To step 2")
            Sys.sleep(0.5) })
        
        
        
        
        highchart(type = "stock") %>% 
            hc_add_series(df_datosgt, "line", hcaes(date, Data), name = "Original") %>% 
            hc_add_series(df_datosgt, "line", hcaes(date, Fitted), name = "Ajustado") %>%
            hc_add_series(df_datosgt, "line", hcaes(date, `Point Forecast`), name = "Prediccion") %>% 
            hc_add_series(df_datosgt, "arearange", hcaes(date, low = `Lo 80`, high = `Hi 80`), name = "Intervalo") %>% hc_title(text = "COVID GUATEMALA TOTAL INFECTIONS") %>% hc_subtitle(text = "Forecast: Automatic Regressive Integrated Moving Average (ARIMA)") %>% hc_yAxis(title = list(text = "Total Confirmed Contagions")) %>% hc_xAxis(title = list(text = "Date"))  %>% hc_credits(enabled = TRUE, text = "Source: ourworldindata", href = "https://covid.ourworldindata.org",style = list(fontSize = "12px"))
        
    })
    
    
    
    output$HC_fore_02 <- renderHighchart({
        
        withProgress(message = "Please Wait", value = 0, {
            
            incProgress(1/3, detail = "Step 1 for 2")
            Sys.sleep(0.5)
            
            t_arima_datosgt <- auto.arima(datosgt$new_cases)
            datosgt_forecast <- forecast(t_arima_datosgt, level = c(95,80))
            df_datosgt <- fortify(datosgt_forecast)
            
            incProgress(1/3, detail = "Daily Forecast")
            Sys.sleep(0.5)
            
            inicio <- head(datosgt$date, 1)
            
            fecha_pred <- seq(as.Date(inicio), (Sys.Date() + 10), by = "day")
            
            df_datosgt$date <- fecha_pred
            
            incProgress(1/3, detail = "End")
            Sys.sleep(0.5) })
        
        
        
        highchart(type = "stock") %>% 
            hc_add_series(df_datosgt, "line", hcaes(date, Data), name = "Original") %>% 
            hc_add_series(df_datosgt, "line", hcaes(date, Fitted), name = "Ajustado") %>%
            hc_add_series(df_datosgt, "line", hcaes(date, `Point Forecast`), name = "Prediccion") %>% 
            hc_add_series(df_datosgt, "arearange", hcaes(date, low = `Lo 80`, high = `Hi 80`), name = "Intervalo") %>% hc_title(text = "COVID19 GUATEMALA DAILY INFECTIONS") %>% hc_subtitle(text = "Forecast: Automatic Regressive Integrated Moving Average (ARIMA)") %>% hc_yAxis(title = list(text = "Daily Confirmed Contagions")) %>% hc_xAxis(title = list(text = "Date"))  %>% hc_credits(enabled = TRUE, text = "Source: ourworldindata", href = "https://covid.ourworldindata.org",style = list(fontSize = "12px"))
        
    })
    
    
    #Icons
    
    output$infoDias <- renderInfoBox({
        infoBox(
            "Days Covid19", Sys.Date() - as.Date('2020-03-14'),
            icon = icon("calendar", lib = "font-awesome"), 
            color = "blue"
        )
    })
    
    output$infoCuarentena <- renderInfoBox({
        
        total_cuarentena <- tail(datosgt$total_cases_per_million,1)
        
        infoBox(
            "Contagions X M",  prettyNum(total_cuarentena,big.mark=",",scientific=FALSE), 
            icon = icon("id-card", lib = "font-awesome"), 
            color = "purple"
        )
    })
    
    output$infoContagios <- renderInfoBox({
        
        total <- tail(datosgt$total_cases,1)
        
        infoBox(
            "Sum. Covid19", prettyNum(total,big.mark=",",scientific=FALSE), 
            icon = icon("hospital", lib = "font-awesome"), 
            color = "maroon"
        )
        
    })
    
    output$infoActivos <- renderInfoBox({
        
        total_muertos <- tail(datosgt$total_deaths, 1)
        
        infoBox(
            "Deaths", prettyNum(total_muertos,big.mark=",",scientific=FALSE),
            icon = icon("cross", lib = "font-awesome"), 
            color = "black"
        )
    })
    
    #Gauge
    
    output$gauge02 <- renderGvis({
        
        
        infoDES <- tail(datosgt$new_cases,1)
        
        df <- data.frame(Label = "Today", Value = infoDES)
        
        gvisGauge(df, 
                  options = list(min = 0, max = 1000, 
                                 greenFrom = 0, greenTo = 100, 
                                 yellowFrom = 101, yellowTo = 500,
                                 redFrom = 501, redTo = 1000))
    })

})

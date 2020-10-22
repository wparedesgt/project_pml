#Global


library(tidyverse)
library(shiny)
library(lubridate)
library(shinydashboard)
library(highcharter)
library(googleVis)
library(forecast)
library(ggfortify)

#Carga datos Covid19

CargaDatosWeb01 <- function() {
  
  data <- read.csv("https://covid.ourworldindata.org/data/owid-covid-data.csv", na.strings = "", fileEncoding = "UTF-8-BOM" )
  
  return(data)
}


datos <- CargaDatosWeb01()

datos$total_tests <- NULL
datos$new_tests <- NULL
datos$total_tests_per_thousand <- NULL
datos$new_tests_per_thousand <- NULL
datos$new_tests_smoothed <- NULL
datos$new_tests_smoothed_per_thousand <- NULL
datos$tests_units <- NULL
datos$male_smokers <- NULL
datos$female_smokers <- NULL

datos$date <- as.Date(datos$date)


datos <- datos %>% filter(iso_code %in% c("GTM","SLV","HND","NIC","CRI", "PAN"))

CargaDatos <- function(fecha_inicio, fecha_fin) {
  
  datos_filtrados <- datos  %>% filter(datos$date >= fecha_inicio & datos$date <= fecha_fin)

  return(datos_filtrados)
    
}



datosgt <- datos %>% filter(iso_code == "GTM")




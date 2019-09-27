
library(rvest)
library(tidyverse)
library(stringi)

#path to executable phantomjs(put your machine path)
#system("C:/.../phantomjs.exe scrape_page.js")

paginawebca<-read_html("data/coes.html")
selectorca<-"#contentHolder > table"
nodo_tabla<-html_node(paginawebca,selectorca)
nodo_tabla<-html_table(nodo_tabla)

#choosing data to graph
data <- nodo_tabla[1:48,]
data$Fecha <- str_replace_all(data$Fecha, "/", "-")
data$Fecha <- as.character(strptime(as.character(data$Fecha),"%d-%m-%Y %H:%M"))
data[2:4] <-data %>% select(2:4)%>%
  mutate_all(str_replace_all," ","")%>%
  mutate_all(str_replace_all,",",".")


#ploting values 
library(plotly)
library(dplyr)

dates1 <- strptime(as.character(data$Fecha), "%Y-%m-%d %H:%M:%S")
data <- data[,2:ncol(data)]  #tomamos la parte del dataframe con los valores
data <- data.frame(date=dates1,data)  #Añadimos las fechas

plot_ly(data,x = ~date)%>%
  add_lines(y=data$Ejecutado, name=colnames(data)[2])%>%
  add_lines(y=data$Prog..Diaria,name=colnames(data)[3])%>%
  add_lines(y=data$Prog..Semanal,name=colnames(data)[4])


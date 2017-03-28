############# Downloading Aptos Data 
############# 03/29/2017


http://www.tse.jus.br/eleitor/estatisticas-de-eleitorado/estatistica-do-eleitorado-por-sexo-e-faixa-etaria


#Preambule
#R Version 3.3.2
rm(list=ls())

library(tidyverse)
library(rvest)
library(RCurl)

url <- "http://www.tse.jus.br/eleitor/estatisticas-de-eleitorado/estatistica-do-eleitorado-por-sexo-e-faixa-etaria"

temp <- htmlParse(getURL(url),asText=TRUE)
temp1 <- temp %>% html_nodes(xpath="//option[@selected]")  %>% html_text()



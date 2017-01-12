############# Downloading Filiados Data 
############# 01/10/2017

#Preambule
#R Version 3.3.2
rm(list=ls())

library(tidyverse)

#Helpful functions

#Downloading
party_affiliates <-function(party, uf, url, dfolder)
{    
  try(download.file(url=paste0(url, tolower(party),"_",tolower(uf),".zip"),
                    destfile=paste0(dfolder, "filiados_", tolower(party),"_",tolower(uf),".zip"), 
                    cacheOK=F))
  
  try(unzip(zipfile=paste0(dfolder, "filiados_", tolower(party),"_",tolower(uf),".zip"),
                    exdir=paste0(dfolder, toupper(party),"/",toupper(uf), "/")))
}

#Binding
parties <- function(party, uf, files){
  br <- locale("es", encoding = "windows-1252")
  if (paste0("filiados_", tolower(party), "_", tolower(uf), ".csv")) %in% 
             list.files(paste0(dfolder ,toupper(party),"/",
             toupper(uf),"/", "aplic/sead/lista_filiados/uf/"))==TRUE){                                                             
      
    temp_sj <- read.csv(file=paste0(dfolder,
                        toupper(party),"/", toupper(uf),"/", 
                        "aplic/sead/lista_filiados/uf/fil_sub_jud_", 
                         tolower(party),"_", tolower(uf), ".csv"), sep=";", 
                         fileEncoding="windows-1252", stringsAsFactors = F,
                         header=T)
  ja <- locale("es", encoding = "windows-1252")
  tt <-  read_csv2(file=paste0(dfolder,
                         toupper(party),"/", toupper(uf),"/", 
                         "aplic/sead/lista_filiados/uf/filiados_", 
                         tolower(party),"_", tolower(uf), ".csv"), locale=ja)
   str(tt)
    
  }else{
  missing[j] <-  print(paste(partidos[j], UFs[i]))
  }
  return(list(temp, temp_sj, missing))
}

####################Downloading
#Downloading UFs
URL <- "http://agencia.tse.jus.br/estatistica/sead/eleitorado/filiados/uf/filiados_"
folder <- "~/Dropbox/TSE_FILIACAO/Jan_2017/"

UFs <- c("AC", "AL","AP","AM", "BA",
         "CE","DF","ES", "GO","MA","MT","MS",
         "MG","PA","PB","PR","PE","PI","RJ",
         "RN","RS","RO","RR","SC","SP", "SE","TO")

parties <- c("PMDB", "PTB", "PDT", "PT", "DEM",
              "PC_do_B", "PSB", "PSDB", "PTC", "PSC", 
              "PMN", "PRP", "PPS", "PV", "PT_do_B",
              "PP", "PSTU", "PCB", "PRTB", "PHS", 
              "PSDC", "PCO", "PTN", "PSL", "PRB", 
              "PSOL", "PR", "PSD", "PPL", "PEN", 
              "PROS", "SD") #check if list is complete


#Getting all states per party
for (j in 1:length(parties)){
  for(i in 1:length(UFs)){
    party_affiliates(party=parties[j], uf=UFs[i], url=URL, dfolder=folder)
  }
}

#Binding
for (j in 1:length(partidos)){
  all <- list()
  for(i in 1:length(UFs)){
    temp <- partido_brasil(partidos[j], UFs[i])
    all[[i]] <- temp
  }  
  
  all_partido <- do.call(rbind.data.frame, all) #bind_rows
  save(all_partido, file=paste("~/Dropbox/MCMV_data/filiados_122016/all_", partidos[j],".Rda", sep=""))
  print(j)
}

all_parties_countryf <- do.call(rbind.data.frame, all_parties_country)
#save(all_parties_countryf, file="~/Dropbox/MCMV_data/filiados_122016/all_parties_country.Rda")
temp <- read.csv(file=paste0(dfolder,
                             toupper(party),"/", toupper(uf),"/", 
                             "aplic/sead/lista_filiados/uf/filiados_", 
                             tolower(party),"_", tolower(uf), ".csv"), sep=";", 
                 fileEncoding="windows-1252", stringsAsFactors = F,
                 header=T)


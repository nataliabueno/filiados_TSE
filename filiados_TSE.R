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
ufs_downloaded <- list.files(paste0(dfolder, party))

parties <- function(ufs_downloaded, parties_downloaded){
  br <- locale("es", encoding = "windows-1252") 
  #this avoids encoding errors and it depends on your machine/R setup
  
  paths_judice <- as.list(paste0(dfolder, toupper(parties_downloaded),"/", toupper(ufs_downloaded),"/", 
                  "aplic/sead/lista_filiados/uf/fil_sub_jud_", tolower(parties_downloaded),
                  "_", tolower(ufs_downloaded), ".csv"))
  paths_filiados <- as.list(paste0(dfolder, toupper(parties_downloaded),"/", toupper(ufs_downloaded),"/", 
                         "aplic/sead/lista_filiados/uf/filiados_", tolower(parties_downloaded),
                         "_", tolower(ufs_downloaded), ".csv"))

  all_parties_allstates_filiados <- lapply(paths_filiados, read_csv2, locale=br) %>% bind_rows()
  all_parties_allstates_sobjudice <- lapply(paths_judice, read_csv2, locale=br) %>% bind_rows()

  return(list(all_parties_allstates_filiados, all_parties_allstates_sobjudice))
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


#Downloading all states per party
for (j in 1:length(parties)){
  for(i in 1:length(UFs)){
    party_affiliates(party=parties[j], uf=UFs[i], url=URL, dfolder=folder)
  }
}

#Binding all party affiliates
filiados <- parties(ufs_downloaded, parties_downloaded)[[1]]
sobjudice <- parties(ufs_downloaded, parties_downloaded)[[2]]



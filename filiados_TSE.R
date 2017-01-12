############# Downloading Filiados Data 
############# 01/10/2017

#Preambule
#R Version 3.3.2
rm(list=ls())

library(tidyverse)

#Downloading
party_affiliates <-function(party, uf, url, dfolder){    
  try(download.file(url=paste0(url, tolower(party),"_",tolower(uf),".zip"),
                    destfile=paste0(dfolder, "original_files/", "filiados_", tolower(party),"_",tolower(uf),".zip"), 
                    cacheOK=F))
  
  try(unzip(zipfile=paste0(dfolder, "original_files/", "filiados_", tolower(party),"_",tolower(uf),".zip"),
                    exdir=paste0(dfolder, "original_unzipped/", toupper(party),"/",toupper(uf), "/")))
}

#Binding function
parties <- function(ufs_downloaded, parties_downloaded, sobjudice=F){
  br <- locale("es", encoding = "windows-1252") 
  if(sobjudice==F){
  #this avoids encoding errors and it depends on your machine/R setup
  
  paths_filiados <- as.list(paste0(dfolder, "original_unzipped/", toupper(parties_downloaded),"/", toupper(ufs_downloaded),"/", 
                         "aplic/sead/lista_filiados/uf/filiados_", tolower(parties_downloaded),
                         "_", tolower(ufs_downloaded), ".csv"))

  party_allstates <- lapply(paths_filiados, read_csv2, locale=br, col_types = cols(.default = col_character())) %>% bind_rows()
  }
  else{
  print("Getting filiados sob judice")
  paths_judice <- as.list(paste0(dfolder, "original_unzipped/", toupper(parties_downloaded),"/", toupper(ufs_downloaded),"/", 
                                 "aplic/sead/lista_filiados/uf/fil_sub_jud_", tolower(parties_downloaded),
                                 "_", tolower(ufs_downloaded), ".csv"))
  
  party_allstates <- lapply(paths_judice, read_csv2, locale=br, col_types = cols(.default = col_character())) %>% bind_rows()
  }
  return(party_allstates)
}

####################Downloading
#Downloading UFs
url <- "http://agencia.tse.jus.br/estatistica/sead/eleitorado/filiados/uf/filiados_"
dfolder <- "~/Dropbox/TSE_FILIACAO/Jan_2017/"
ufs <- c("AC", "AL")


#UFs <- c("AC", "AL","AP","AM", "BA",
#         "CE","DF","ES", "GO","MA","MT","MS",
#         "MG","PA","PB","PR","PE","PI","RJ",
#         "RN","RS","RO","RR","SC","SP", "SE","TO")

#parties <- c("PMDB", "PTB", "PDT", "PT", "DEM",
#              "PC_do_B", "PSB", "PSDB", "PTC", "PSC", 
#              "PMN", "PRP", "PPS", "PV", "PT_do_B",
#              "PP", "PSTU", "PCB", "PRTB", "PHS", 
#              "PSDC", "PCO", "PTN", "PSL", "PRB", 
#              "PSOL", "PR", "PSD", "PPL", "PEN", 
#              "PROS", "SD", "NOVO", "PMB", "REDE") #update list as needed


#Downloading all states per party
for (j in 1:length(pparties)){
  for(i in 1:length(UFs)){
    party_affiliates(party=pparties[j], uf=ufs[i], url=url, dfolder=dfolder)
  }
}

#Checking of all expected files downloaded and unzipped
#1. Downloads
length(list.files(paste0(dfolder, "original_files/")))==length(pparties)*length(ufs)
#2. Unzips
length(list.files(paste0(dfolder, "original_unzipped/")))==length(pparties)

#Binding all party affiliates
pparties <- c("PTB", "PDT") #update list as needed
all <- list()
for (p in 1:length(pparties)){
    all[[p]] <-    parties(ufs_downloaded=list.files(paste0(dfolder, "original_unzipped/", pparties[p])),
              parties_downloaded=pparties[p], sobjudice = F) 
}
filiados_jan2017 <- bind_rows(all, .id = "all")






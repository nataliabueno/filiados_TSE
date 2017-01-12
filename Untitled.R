temp_sj <- read.csv(file=paste0(dfolder,
                                toupper(party),"/", toupper(uf),"/", 
                                "aplic/sead/lista_filiados/uf/fil_sub_jud_", 
                                tolower(party),"_", tolower(uf), ".csv"), sep=";", 
                    fileEncoding="windows-1252", stringsAsFactors = F,
                    header=T)
ja <- locale("es", encoding = "windows-1252")


if (paste0("filiados_", tolower(party), "_", tolower(uf), ".csv")) %in% 
  list.files(paste0(dfolder ,toupper(party),"/",
                    toupper(uf),"/", "aplic/sead/lista_filiados/uf/"))==TRUE){ 
                      #not all parties have filiados in all states
                      
                      
                      #getting paths for all files sob judice
                      paths_judice <- lapply(paste0(dfolder, toupper(party),"/", toupper(ufs_downloaded),"/", 
                                                    "aplic/sead/lista_filiados/uf/fil_sub_jud_", tolower(party),
                                                    "_", tolower(ufs_downloaded), ".csv"), list.files)
                      
                      #getting paths for all files filiados
                      paths_filiados <- 
                        
                        
                        
                        files.states <- list.files(paste0(dfolder, toupper(party),"/"))
                      
                      files_sobjudic <- list.files(paste0(dfolder, toupper(party),"/", toupper(ufs_downloaded),"/", 
                                                          "aplic/sead/lista_filiados/uf/fil_sub_jud_", tolower(party), ".csv"))
                      
                      
                      
                      files_fil <- list.files(paste0(dfolder, toupper(party),"/", toupper(uf),"/", 
                                                     "aplic/sead/lista_filiados/uf/"))[1]
                      lapply(paths, list.files)   
                      
                      party_allstates <- row_bind
                      tbl = lapply(files, read_csv) %>% bind_rows()
                      
                      party_allstates <- lapply(files, read_csv2(file=paste0(dfolder,
                                                                             toupper(party),"/", toupper(uf),"/", 
                                                                             "aplic/sead/lista_filiados/uf/fil_sub_jud_", 
                                                                             tolower(party),"_", tolower(files), ".csv"), locale=br))
                      
                      (read_csv2(file=paste0(dfolder,
                                             toupper(party),"/", toupper(uf),"/", 
                                             "aplic/sead/lista_filiados/uf/fil_sub_jud_", 
                                             tolower(party),"_", tolower(uf), ".csv"), locale=br)
                        
                    }else{
                      missing[j] <-  print(paste(partidos[j], UFs[i]))
                      
                      
                      all_parties_countryf <- do.call(rbind.data.frame, all_parties_country)
                      #save(all_parties_countryf, file="~/Dropbox/MCMV_data/filiados_122016/all_parties_country.Rda")
                      temp <- read.csv(file=paste0(dfolder,
                                                   toupper(party),"/", toupper(uf),"/", 
                                                   "aplic/sead/lista_filiados/uf/filiados_", 
                                                   tolower(party),"_", tolower(uf), ".csv"), sep=";", 
                                       fileEncoding="windows-1252", stringsAsFactors = F,
                                       header=T)
                      
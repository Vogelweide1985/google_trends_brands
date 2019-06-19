#INIT
source("functions.r",encoding = "UTF-8")
config <- config::get()



# Einlesen aller Individualmarken
marken   <- unlist(config$category)
#### Ziehen aller Marken über alle zeitraeume
ls <- get_all_brands(marken, config[["zeitraum_name"]], config[["zeitraum_api"]])
#Zeitreihen Dataframe über alle marken und zeitraeume,evtl. fuer bessere Datenvararbeitung


df <- get_interest(ls)
write.csv(df,"hits_by_time.csv", row.names = F)
df <- get_interest(ls, "region")
write.csv(df,"hits_by_region.csv", row.names = F)
df <- get_interest(ls, "city")
write.csv(df,"hits_by_city.csv", row.names = F)



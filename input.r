#INIT
source("functions.r",encoding = "UTF-8")
config <- config::get()



# Einlesen aller Individualmarken
marken   <- unlist(config$branchen)
#### Ziehen aller Marken über alle zeitraeume
ls <- get_all_brands(marken, config[["zeitraum_name"]], config[["zeitraum_api"]])
#Zeitreihen Dataframe über alle marken und zeitraeume,evtl. fuer bessere Datenvararbeitung


df_time <- get_interest(ls)
df_region <- get_interest(ls, "region")
df_city <- get_interest(ls, "city")



write.csv(df_time,"hits_by_time.csv", row.names = F)
write.csv(df_region,"hits_by_region.csv", row.names = F)
write.csv(df_city,"hits_by_city.csv", row.names = F)
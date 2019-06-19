#INIT
source("functions.r",encoding = "UTF-8")
config <- config::get()

query <- config$suchbegriffe

# Bilden der Querys nach Marken und Categorien
marken   <- unlist(query)
branchen <- query

# Ziehen aller Einzelmarken über alle zeitraeume
ls <- get_all_brands(marken, config[["zeitraum_name"]], config[["zeitraum_api"]])
#Zeitreihen Dataframe über alle marken und zeitraeume,evtl. fuer bessere Datenvararbeitung

# Erstmal, händischer Export
df_time <- get_interest(ls, "time", branchen)
df_region <- get_interest(ls, "region", branchen)
df_city <- get_interest(ls, "city", branchen)
write.csv(df_time,"hits_by_time.csv", row.names = F)
write.csv(df_region,"hits_by_region.csv", row.names = F)
write.csv(df_city,"hits_by_city.csv", row.names = F)



# Einlesen aller Marken je Branche, Wichtig: Maximal 5 Begriffe sind erlaubt!
ls2 <- get_all_brands(branchen, config[["zeitraum_name"]], config[["zeitraum_api"]])
#Zeitreihen Dataframe über alle marken und zeitraeume,evtl. fuer bessere Datenvararbeitung
df2_time <- get_interest(ls2, "time", branchen)
df2_region <- get_interest(ls2, "region", branchen)
df2_city <- get_interest(ls2, "city", branchen)


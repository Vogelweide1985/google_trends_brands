library(gtrendsR)
library(dplyr)


get_one_brand <- function(marke, zeitraum) {
  #print(marke)
  if (any(marke == "")) {
    return(NA)
  }
  ls <- gtrends(marke, geo = "DE", time = zeitraum)
  if(is.null(ls[[1]][[1]][[1]])) {
    print(paste("Keine Daten für", marke, "für den Zeitraum", zeitraum )) 
    return(NA)
  }
  else {
    print(paste( marke, " : ", zeitraum))
    ls
  }
}


get_all_brands <- function(marken, zeit_chr, zeit_api) {
marken.ls  <-list()
  for (m in 1: length(marken)) { 
    for (z in 1: length(zeit_chr)) {
      query <- unlist(marken[m])
      ls <- get_one_brand(query, zeit_api[z]) # Get Trends Data
      if(is.na(ls)[[1]]) {next}  #Pruefen ob woechentlcihe Daten vorhanden
      lst.name <- paste0(query,collapse = ",")
      marken.ls[[lst.name]][[zeit_chr[z]]] <- ls
    }
  }
marken.ls
}


get_interest <- function(gtrends_result, interest = "time") {
  # options: time, region, city
  if (interest == "time") {topic <- "interest_over_time"}
  else if (interest == "region") {topic <- "interest_by_region"}
  else if (interest == "city") {topic <- "interest_by_city"}
  else {
    print("Falsche Auswahl. Bitte wählen zwischen: time, region, city")
    return(NA)
  }
  
  for (m in 1: length(gtrends_result)) {
    for (z in 1: length(gtrends_result[[m]])) {
      
      if( !exists("df", inherits = F)) {
        df <- gtrends_result[[1]][[1]][[topic]]
        if(is.null(df)) {next} # prüft ob Daten vorhanden
        df[, "timerange"] <- names(gtrends_result[[m]][z])
        df[, "hits"] <- as.integer(gsub("<1", "0", df[, "hits"]))
      }
      else {
        g <- gtrends_result[[1]][[1]][[topic]]
        if(is.null(g)) {next} # prüft ob Daten vorhanden
        g[, "timerange"] <- names(gtrends_result[[m]][z])
        g[, "hits"] <- as.integer(gsub("<1", "0", g[, "hits"]))
        bind_rows(df, g)
      }
      
    }
  }
df
}




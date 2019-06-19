library(gtrendsR)
library(dplyr)


get_one_brand <- function(marke, zeitraum) {
  if (marke == "") {
    return(NA)
  }
  ls <- gtrends(c(marke), geo = "DE", time = zeitraum)
  if(is.null(ls[[1]][[1]][[1]])) {
    print(paste("Keine Daten für", marke, "für den Zeitraum", zeitraum )) 
    return(NA)
  }
  else {
    print(paste("Lese ein:", marke, ", Zeitraum:", zeitraum))
    ls
  }
}


get_all_brands <- function(marken, zeit_chr, zeit_api) {
marken.ls  <-list()
  for (m in 1: length(marken)) { 
    for (z in 1: length(zeit_chr)) {
      
      ls <- get_one_brand(marken[m], zeit_api[z]) # Get Trends Data
      if(is.na(ls)[[1]]) {next}  #Pruefen ob woechentlcihe Daten vorhanden
      marken.ls[[marken[m]]][[zeit_chr[z]]] <- ls
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
  
  
  df <- gtrends_result[[1]][[1]][[topic]]
  df[, "timerange"] <- names(gtrends_result[[1]][1])
  for (m in 1: length(gtrends_result)) {
    for (z in 1: length(gtrends_result[[m]])) {
      g <- gtrends_result[[m]][[z]][[topic]]
      print(m)
      print(z)
      print(names(gtrends_result[[m]][z]))
      g[, "timerange"] <- names(gtrends_result[[m]][z])
      if (!m==1 && z ==1) {
        df <- bind_rows(df, g) 
      }
    }
  }
  df
}



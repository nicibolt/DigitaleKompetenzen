# Analyse Script

#### Bibliotheken laden
install.packages("tidyverse")
install.packages("lubridate")
install.packages("psych")
install.packages("esquisse")
install.packages("ggthemes")
install.packages("ggplot2")

install.packages("devtools")
library(devtools)
devtools::install_github("HCIC/r-tools")

source("surveymonkey.R")


# Data Cleaning ----

filename <- "data/DigitaleMuendigkeit.csv"
raw <- load_surveymonkey_csv(filename)


#### Daten cleanen----

### Schritt 1: Unnötige Spalten löschen.
raw.short <- raw[,c(-1:-9, -12:-15, -36:-38, -46, -49:-53, -77:-136)] 

### Schritt 2: Variablen umbenennen 

## Variante 2: Eine eigene Datei mit den Variablennamen erzeugen:
#####generate_codebook(raw.short, "codebook.csv") auskommwntieren, 
                                            #####damit keine Überschreibung

# Dann codebook.csv in Excel öffnen, die Vairablennamen per Hand umbenennen, 
codebook <- read_codebook("codebook_final.csv")

#neue Namen auf die Daten anwenden:
names(raw.short) <- codebook$variable




# Skalenberechnung ----
print("Hier werden später Skalen berechnet. Thema am 09.11.2018")
# Analyse ----
print("Hier werden später statistische Analysen durchgeführt. Thema ab dem 16.11.2018")
# Graphik erstellung ---- 
print("Hier werden später Grafiken erstellt. Thema ab dem 16.11.2018")

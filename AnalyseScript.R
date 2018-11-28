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


#### Daten cleanen ----

### Schritt 1: Unnötige Spalten löschen.
raw.short <- raw[,c(-1:-9, -12:-15, -36:-38, -46, -49:-53, -77:-136)] 

### Schritt 2: Variablen umbenennen 
# Codebook mit den Variablennamen erzeugen:
## generate_codebook(raw.short, "codebook.csv") auskommwntieren, damit keine Überschreibung passiert

# Dann codebook.csv in Excel öffnen, die Vairablennamen per Hand umbenennen, 
codebook <- read_codebook("codebook_final.csv")

#neue Namen auf die Daten anwenden:
names(raw.short) <- codebook$variable




### Schritt 3: Variablen den richtigen Typen zuordnen

# Gender zu kategorialer Variable machen:
raw.short$gender <- as.factor(raw.short$gender)

# Skala für Likertskala anlegen:
scale.zustimmung <-c("stimme gar nicht zu", 
                     "stimme nicht zu", 
                     "stimme eher nicht zu", 
                     "stimme eher zu", 
                     "stimme zu", 
                     "stimme voll zu")

# Skala für Häufigkeit anlegen:
scale.rythm <-c("mehrmals täglich", 
                "täglich", 
                "wöchentlich", 
                "monatlich", 
                "seltener", 
                "nie",
                "Ich kenne dieses Netzwerk nicht")

# Likert-Items zu ordinalen levels machen:

#Häufigkeit der Nutzung von SON
raw.short$on_fb <- ordered(raw.short$on_fb, levels = scale.rythm)
raw.short$on_ig <- ordered(raw.short$on_ig, levels = scale.rythm)
raw.short$on_tw <- ordered(raw.short$on_tw, levels = scale.rythm)
raw.short$on_sc <- ordered(raw.short$on_sc, levels = scale.rythm)
raw.short$on_yt <- ordered(raw.short$on_yt, levels = scale.rythm)
raw.short$on_other <- ordered(raw.short$on_other, levels = scale.rythm)

# Technikinteresse
raw.short$tech_1 <- ordered(raw.short$tech_1, levels = scale.zustimmung)
raw.short$tech_2 <- ordered(raw.short$tech_2, levels = scale.zustimmung)
raw.short$tech_3 <- ordered(raw.short$tech_3, levels = scale.zustimmung)
raw.short$tech_4 <- ordered(raw.short$tech_4, levels = scale.zustimmung)
raw.short$tech_5 <- ordered(raw.short$tech_5, levels = scale.zustimmung)
raw.short$tech_6 <- ordered(raw.short$tech_6, levels = scale.zustimmung)

# Kontrollüberzeugung im Umgang mit Technik
raw.short$kut_1 <- ordered(raw.short$kut_1, levels = scale.zustimmung)
raw.short$kut_2 <- ordered(raw.short$kut_2, levels = scale.zustimmung)
raw.short$kut_3 <- ordered(raw.short$kut_3, levels = scale.zustimmung)
raw.short$kut_4 <- ordered(raw.short$kut_4, levels = scale.zustimmung)
raw.short$kut_5 <- ordered(raw.short$kut_5, levels = scale.zustimmung)
raw.short$kut_6 <- ordered(raw.short$kut_6, levels = scale.zustimmung)
raw.short$kut_7 <- ordered(raw.short$kut_7, levels = scale.zustimmung)
raw.short$kut_8 <- ordered(raw.short$kut_8, levels = scale.zustimmung)

# Technikverständnis, -ausführung und -orientierung
raw.short$tvv_1 <- ordered(raw.short$tvv_1, levels = scale.zustimmung)
raw.short$tva_1 <- ordered(raw.short$tva_1, levels = scale.zustimmung)
raw.short$tva_2 <- ordered(raw.short$tva_2, levels = scale.zustimmung)
raw.short$tva_3 <- ordered(raw.short$tva_3, levels = scale.zustimmung)
raw.short$tvo_2 <- ordered(raw.short$tvo_2, levels = scale.zustimmung)
raw.short$tvo_1 <- ordered(raw.short$tvo_2, levels = scale.zustimmung)
raw.short$tvo_3 <- ordered(raw.short$tvo_3, levels = scale.zustimmung)
raw.short$tva_4 <- ordered(raw.short$tva_4, levels = scale.zustimmung)
raw.short$tva_5 <- ordered(raw.short$tva_5, levels = scale.zustimmung)

# Informationsmanagement
raw.short$IMIBpl_1 <- ordered(raw.short$IMIBpl_1, levels = scale.zustimmung)
raw.short$IMIBpl_2 <- ordered(raw.short$IMIBpl_2, levels = scale.zustimmung)
raw.short$IMIBpl_3 <- ordered(raw.short$IMIBpl_3, levels = scale.zustimmung)
raw.short$IMOSImin_1 <- ordered(raw.short$IMOSIpl_1, levels = scale.zustimmung)
raw.short$IMOSImin_2 <- ordered(raw.short$IMOSImin_2, levels = scale.zustimmung)
raw.short$IMOSIpl_1 <- ordered(raw.short$IMOSImin_2, levels = scale.zustimmung)
raw.short$IMIBwertpl_1 <- ordered(raw.short$IMIBwertpl_1, levels = scale.zustimmung)
raw.short$IMIBwert_1 <- ordered(raw.short$IMIBwert_1, levels = scale.zustimmung)
raw.short$MIBwert_3 <- ordered(raw.short$MIBwert_3, levels = scale.zustimmung)
raw.short$socialbots_1 <- ordered(raw.short$socialbots_1, levels = scale.zustimmung)
raw.short$socialbots_2 <- ordered(raw.short$socialbots_2, levels = scale.zustimmung)
raw.short$blog_1 <- ordered(raw.short$blog_1, levels = scale.zustimmung)
raw.short$blog_2 <- ordered(raw.short$blog_2, levels = scale.zustimmung)
raw.short$MIBwert_4 <- ordered(raw.short$MIBwert_4, levels = scale.zustimmung)

raw.short$son_use_1 <- ordered(raw.short$son_use_1, levels = scale.zustimmung)
raw.short$son_use_2 <- ordered(raw.short$son_use_2, levels = scale.zustimmung)
raw.short$son_use_3 <- ordered(raw.short$son_use_3, levels = scale.zustimmung)
raw.short$son_use_4 <- ordered(raw.short$son_use_4, levels = scale.zustimmung)
raw.short$son_use_5 <- ordered(raw.short$son_use_5, levels = scale.zustimmung)
raw.short$son_use_6 <- ordered(raw.short$son_use_6, levels = scale.zustimmung)
raw.short$son_use_7 <- ordered(raw.short$son_use_7, levels = scale.zustimmung)
raw.short$son_use_8 <- ordered(raw.short$son_use_8, levels = scale.zustimmung)
raw.short$son_use_9 <- ordered(raw.short$son_use_9, levels = scale.zustimmung)



# Skalenberechnung ----
print("Hier werden später Skalen berechnet. Thema am 09.11.2018")
# Analyse ----
print("Hier werden später statistische Analysen durchgeführt. Thema ab dem 16.11.2018")
# Graphik erstellung ---- 
print("Hier werden später Grafiken erstellt. Thema ab dem 16.11.2018")

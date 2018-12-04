# Analyse Script

# Bibliotheken laden ----
library(tidyverse)
source("surveymonkey.R")
library(lubridate)


# Datei laden ----

filename <- "data/DigitaleMuendigkeit.csv"
raw <- load_surveymonkey_csv(filename)


#### Daten cleanen ----

### Schritt 1: Unnötige Spalten löschen.
raw.short <- raw[,c(-1:-9, -13:-15, -36:-38, -46, -49:-53, -68:-69, -77:-136)] 

### Schritt 2: Variablen umbenennen 
# Codebook mit den Variablennamen zeugen:
#generate_codebook(raw.short, "codebook.csv")


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

scale.zustimmung2 <-c("stimme gar nicht zu", 
                     "stimme nicht zu", 
                     "stimme eher nicht zu", 
                     "stimme eher zu", 
                     "stimme zu", 
                     "stimme völlig zu")

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
raw.short$tvv_1 <- ordered(raw.short$tvv_1, levels = scale.zustimmung2)
raw.short$tva_1 <- ordered(raw.short$tva_1, levels = scale.zustimmung2)
raw.short$tva_2 <- ordered(raw.short$tva_2, levels = scale.zustimmung2)
raw.short$tva_3 <- ordered(raw.short$tva_3, levels = scale.zustimmung2)
raw.short$tvo_2 <- ordered(raw.short$tvo_2, levels = scale.zustimmung2)
raw.short$tvo_1 <- ordered(raw.short$tvo_2, levels = scale.zustimmung2)
raw.short$tvo_3 <- ordered(raw.short$tvo_3, levels = scale.zustimmung2)
raw.short$tva_4 <- ordered(raw.short$tva_4, levels = scale.zustimmung2)
raw.short$tva_5 <- ordered(raw.short$tva_5, levels = scale.zustimmung2)

# Informationsmanagement
raw.short$IMIBpl_1 <- ordered(raw.short$IMIBpl_1, levels = scale.zustimmung2)
raw.short$IMIBpl_2 <- ordered(raw.short$IMIBpl_2, levels = scale.zustimmung2)
raw.short$IMIBpl_3 <- ordered(raw.short$IMIBpl_3, levels = scale.zustimmung2)
raw.short$IMOSImin_1 <- ordered(raw.short$IMOSIpl_1, levels = scale.zustimmung2)
raw.short$IMOSImin_2 <- ordered(raw.short$IMOSImin_2, levels = scale.zustimmung2)
raw.short$IMOSIpl_1 <- ordered(raw.short$IMOSImin_2, levels = scale.zustimmung2)
raw.short$IMIBwertpl_1 <- ordered(raw.short$IMIBwertpl_1, levels = scale.zustimmung2)
raw.short$IMIBwert_1 <- ordered(raw.short$IMIBwert_1, levels = scale.zustimmung2)
raw.short$MIBwert_3 <- ordered(raw.short$MIBwert_3, levels = scale.zustimmung2)
raw.short$socialbots_1 <- ordered(raw.short$socialbots_1, levels = scale.zustimmung2)
raw.short$socialbots_2 <- ordered(raw.short$socialbots_2, levels = scale.zustimmung2)
raw.short$blog_1 <- ordered(raw.short$blog_1, levels = scale.zustimmung2)
raw.short$blog_2 <- ordered(raw.short$blog_2, levels = scale.zustimmung2)
raw.short$MIBwert_4 <- ordered(raw.short$MIBwert_4, levels = scale.zustimmung2)

raw.short$son_use_1 <- ordered(raw.short$son_use_1, levels = scale.zustimmung2)
raw.short$son_use_2 <- ordered(raw.short$son_use_2, levels = scale.zustimmung2)
raw.short$son_use_3 <- ordered(raw.short$son_use_3, levels = scale.zustimmung2)
raw.short$son_use_4 <- ordered(raw.short$son_use_4, levels = scale.zustimmung2)
raw.short$son_use_5 <- ordered(raw.short$son_use_5, levels = scale.zustimmung2)
raw.short$son_use_6 <- ordered(raw.short$son_use_6, levels = scale.zustimmung2)
raw.short$son_use_7 <- ordered(raw.short$son_use_7, levels = scale.zustimmung2)



#### Schritt 4: Skalen berechnen ----

# Skalenberechnung ----

library(psych)

schluesselliste <- list(ON_SON= c("on_fb", "on_ig", "on_tw", "on_sc", "on_yt", "on_other"),
                        TECH = c("tech_1", "tech_2", "-tech_3", 
                                     "tech_4", "tech_5", "-tech_6"),
                        KUT = c("kut_1", "-kut_2", "kut_3", "kut_4", "-kut_5", "kut_6", "-kut_7", "-kut_8"),
                        TVV = c("tvv_1"),
                        TVA = c("tva_1", "tva_2", "tva_3", "tva_4", "tva_5"),
                        TVO = c("tvo_1", "tvo_2", "tvo_3"),
                        IMIBPL = c("IMIBpl_1", "IMIBpl_2", "IMIBpl_3"),
                        IMOSIMIN = c("-IMOSImin_1", "-IMOSImin_2"),
                        IMOSIPL = c("IMOSIpl_1"),
                        IMIBWERTPL = c("IMIBwertpl_1"),
                        IMIBWERT = c("IMIBwert_1"),
                        MIBWERT = c("-MIBwert_3","MIBwert_4"),
                        SOCIALBOT = c("socialbots_1","socialbots_2"),
                        BLOG = c("blog_1","blog_2"),
                        SON_USE = c("son_use_1", "-son_use_2", "-son_use_3", "son_use_4", "-son_use_5", "son_use_6", "-son_use_7"))

scores <- scoreItems(schluesselliste, raw.short, missing = TRUE, min = 1, max = 6)

data <- bind_cols(raw.short, as.tibble(scores$scores))
data <- data %>% 
  select(-starts_with("on_", ignore.case = F)) %>% 
  select(-starts_with("tech_", ignore.case = F)) %>%
  select(-starts_with("kut_", ignore.case = F)) %>%
  select(-starts_with("tvv_", ignore.case = F)) %>%
  select(-starts_with("tva_", ignore.case = F)) %>%
  select(-starts_with("tvo_", ignore.case = F)) %>%
  select(-starts_with("IMIBpl_", ignore.case = F)) %>%
  select(-starts_with("IMOSImin_", ignore.case = F)) %>% 
  select(-starts_with("IMOSIpl_", ignore.case = F)) %>% 
  select(-starts_with("IMIBwertpl_", ignore.case = F)) %>%
  select(-starts_with("IMIBwert_", ignore.case = F)) %>%
  select(-starts_with("MIBwert_", ignore.case = F)) %>%
  select(-starts_with("socialbots_", ignore.case = F)) %>%
  select(-starts_with("blog_", ignore.case = F)) %>% 
  select(-starts_with("son_use_", ignore.case = F)) 

warnings()

##### FEEDBACK Datacleaning: Alles super! Den Bildungsstand sollten Sie aber nicht löschen (direkt am Anfang), der ist wichtig für die Stichprobenbeschreibung. ----
##### Wenn inhaltlich alles korrekt ist (z.B. die richtigen Items negativ codiert sind) werden Sie im Januar wenig Arbeit haben :-) 

# Analyse ----
print("Hier werden später statistische Analysen durchgeführt. Thema ab dem 16.11.2018")
# Graphik erstellung ---- 
print("Hier werden später Grafiken erstellt. Thema ab dem 16.11.2018")

saveRDS(data,"data/DigitaleMuendigkeit2.rds")


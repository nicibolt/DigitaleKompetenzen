# Analyse Script

# Bibliotheken laden ----
library("tidyverse")
source("surveymonkey.R")
library("lubridate")


# Datei laden ----

filename <- "data/DigitaleMuendigkeit_final.csv"
raw <- load_surveymonkey_csv(filename)


#### Daten cleanen ----

### Schritt 1: Unnötige Spalten löschen.


raw.preselect <- raw[,c(-1:-9, -13:-15, -36:-38, -46, -49:-53, -68:-69, -77:-136)]

### Schritt 2: Variablen umbenennen 
# Codebook mit den Variablennamen zeugen:
generate_codebook(raw.preselect, "codebook.csv")


# Dann codebook.csv in Excel öffnen, die Vairablennamen per Hand umbenennen, 
codebook <- read_codebook("codebook_final.csv")

#neue Namen auf die Daten anwenden:
names(raw.preselect) <- codebook$variable

## Herauslöschen der Dummydatensätze (age=99)
# das ist nur ein Filter: age99 <- dplyr::filter(raw.short, age > 98)
raw.short <- filter(raw.preselect, raw.preselect$age != 99, raw.preselect$age != 1992)


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



schluesselliste <- list(ON_SON = c("on_fb", "on_ig", "on_tw", "on_sc", "on_yt"),
                        TECH = c("tech_1", "tech_2", "-tech_3", "tech_4", "tech_5", "-tech_6"),
                        KUT = c("kut_1", "-kut_2", "kut_3", "kut_4", "-kut_5", "kut_6", "-kut_7","-kut_8"),
                        TECH_VERS = c("tvv_1", "tva_1", "tva_2", "tva_3", "tva_4", "tva_5", "tvo_1","tvo_2", "tvo_3", "blog_1"),
                        INF_MAN = c("IMIBpl_1", "IMIBpl_2", "IMIBpl_3", "-IMOSImin_1", "-IMOSImin_2","IMOSIpl_1", "IMIBwertpl_1",                           "IMIBwert_1","-MIBwert_3","MIBwert_4","socialbots_1", "socialbots_2", "blog_2"),
                        SON_USE = c("son_use_1", "-son_use_2", "-son_use_3", "son_use_4","-son_use_5", "son_use_6", "-son_use_7"))

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

saveRDS(data,"data/DigitaleMuendigkeit_final.rds")

##### FEEDBACK Datacleaning: Alles super! Den Bildungsstand sollten Sie aber nicht löschen (direkt am Anfang), der ist wichtig für die Stichprobenbeschreibung. ----
##### Wenn inhaltlich alles korrekt ist (z.B. die richtigen Items negativ codiert sind) werden Sie im Januar wenig Arbeit haben :-) 

# Analyse ----
#print("Hier werden später statistische Analysen durchgeführt. Thema ab dem 16.11.2018")
# Graphik erstellung ---- 

#print("Hier werden später Grafiken erstellt. Thema ab dem 16.11.2018")


####Unterschiedshypothesen: ----

###PRÄSI (sig nur für tech_vers) Unterschiedshypothese 1: 
#H1: Es besteht ein Unterschied zwischen jüngeren und älteren Personen in deren digitalen Kompetenzen Technikverständnis und Informationsmanagement.  
#H0: Es besteht kein Unterschied zwischen jüngeren und älteren Personen in deren digitalen Kompetenzen Technikverständnis und Informationsmanagement. 
#(>> one-way Manova, da eine UV und 2 AVs)

library(jmv)
data <- transform(data, age_group=cut(data$age, breaks=c(-Inf, median(data$age), Inf), labels=c("low", "high")))
mancova(data, deps= c(TECH_VERS , INF_MAN), factors= c(age_group)) 
#--> Müssen an dieser Stelle zwei Altersgruppen definiert werden? 

###Unteschiedshypothese 2:
#H1: "Häufignutzer" (Skalenwert größer gleich ) von sozialen Online-Netzwerken, haben eine höhere Ausbildung der digitalen Kompetenz Technikverständnis, als "Wenignutzer" (Skalenwert kleiner gleich ).
#H0: "Häufignutzer" von sozialen Online-Netzwerken, haben keine höhere Ausbildung der digitalen Kompetenz Technikverständnis, als "Wenignutzer".
#(>> unverbundener T-Test)

data <- transform(data, ON_SON_group=cut(data$ON_SON, breaks=c(-Inf, median(data$ON_SON), Inf), labels=c("low", "high")))
t.test(data$TECH_VERS ~ data$ON_SON_group)
t.test(data$INF_MAN ~ data$ON_SON_group)

##Unterschiedshypothese 3:
#H1: Es liegt ein Unterschied zwischen der digitalen Kompetenz Informationsmanagement und Technikverständnis vor. 
#H0: Es liegt kein Unterschied zwischen der digitalen Kompetenz Informationsmanagement und Technikverständnis vor.  
#(>> verbundener T-Test)

t.test(data$INF_MAN, data$TECH_VERS, paired= TRUE)

####Zusammenhangshypothesen: ----

### PRÄSI sig für eines der Beiden - Zusammenhangshypothese 1: KUT und digitale Kompetenzen 
## Hypothese: Es besteht ein Zusammenhang zwischen dem KUT eines Nutzers und dessen digitalen Kompetenzen.
## H0: Es besteht kein Zusammenhang zwischen dem KUT eines Nutzers und dessen digitalen Kompetenzen.
## Lineare Regression. UV: KUT, AV: digitale Kompetenzen:


data %>% select(KUT, TECH_VERS, INF_MAN)
jmv::linReg(data=data, dep=KUT, covs=c("TECH_VERS"),
            block=list(list("TECH_VERS")),
          r2Adj=T, stdEst=T, anova=T)

#Korrelation zum Test > TECH_VERS erklärt den selben Anteil der Varianz
#cor.test(data=data,          
#        ~KUT+INF_MAN, method= "pearson")

jmv::linReg(data=data, dep=KUT, covs=c("INF_MAN"),
            block=list(list("INF_MAN")),
            r2Adj=T, stdEst=T, anova=T)

data$KUT


## Ergebnis: H0 verwerfen.
## Feedback: Man versteht, was sie meinen, aber der Code ist syntaktisch nicht ganz korrekt.
## Hinter "KUT" muss die Klammer wieder zugehen, bei den covs muss ein Komma statt des Plus und bei Blocks muss ein Vektor übergeben werden.
## Und was Sie mit den hcictools vor hatten verstehe ich nicht ganz.--> ANGEPASST 


### PRÄSI (nicht sig) Zusammenhangshypothese 2: Alter und Umgang mit sozialen Online-Netzwerken 
## Hypothese: Es besteht ein Zusammenhang zwischen dem Alter und dem Umgang mit sozialen Online-Netzwerken.
## H0: Es besteht kein Zusammenhang zwischen dem Alter und dem Umgang mit sozialen Online-Netzwerken.
## Korrelation. UV: Alter, AV: Umgang mit sozialen Online-Netzwerken:
cor.test(data=data,
         ~age+SON_USE)


## Ergebnis: H0 verwerfen.
## Feedback: Sieht super aus, aber warum kendall? --> ANGEPASST 


### Zusammenhangshypothese 3: "Technikverständnis" und "Informationsmanagement" 
## Hypothese: Ist die digitale Kompetenz “Technikverständnis” stark ausgeprägt, ist auch die digitale Kompetenz “Informationsmanagement” stark ausgeprägt.
## H0: Es besteht kein Zusammenhang in der Stärke der Ausprägung der digitalen Kompetenz “Technikverständnis” und der Stärke der Ausprägung der digitalen Kompetenz “Informationsmanagement”.
## Pearson-Korrelation. UV: Stärke der Ausprägung "Technikverständnis", AV: Stärke der Ausprägung "Informationsmanagement"
cor.test(data=data,          
         ~TECH_VERS+INF_MAN, method= "pearson")

## Ergebnis: H0 verwerfen.
## Feedback: Hier verwenden Sie z.B. Pearson. Sieht auch super aus!

## Feedback: Die Hausaufgabe war eigentlich auch, die Unterschiedshypothesen hier einzutragen. Falls Sie die Zeilen von 182 bis 194 meinen stimmt da leider gar nichts, weil sie es jeweils so aufgeschrieben haben, als sollten zwei Datensätze (nicht etwas Spalten eines einzelnen Datensatzes) miteinander verglichen werden. --> ANGEPASST


## Zusammenhangshypothese 4: 
# H1 Es gibt einen Zusammenhang zwischen der KUT eines Nutzers und seinem Umgang mit Sozialen Online-Netzwerken.
# H0 Es gibt keinen Zusammenhang zwischen dem KUT eines Nutzers und seinem Umgang mit Sozialen Online-Netzwerken. 

cor.test(data=data,
         ~KUT+SON_USE)

jmv::linReg(data=data, dep=KUT, covs=c("SON_USE"),
            block=list(list("SON_USE")),
            r2Adj=T, stdEst=T, anova=T)


## Deskriptive Auswertung des bereinigten Datensatzes
library(ggplot2)

ggplot(data = data) +
  aes(x = age) +
  geom_histogram(bins = 30, fill = "#0c4c8a") +
  labs(title = "Studentische Stichprobe",
       x = "Alter in Jahren",
       y = "Häufigkeit (absolut)",
       caption = "Histogram mit 30 Bins",
       subtitle = "Histogram des Alters") +
  theme_gray()

ggsave("alter_histogramm.png", width = 7, height = 4)

mean(data$age)
sd(data$age)
median(data$age)
min(data$age)     
max(data$age)

boxplot(data$KUT, data$TECH_VERS, data$INF_MAN, data$SON_USE,
        names=c("KUT","Technikverständnis","Informationsmanagement", "Soziale Online-Netzwerke"),
        col="#0c4c8a",
        ylab = "Likert-Skala [1-6]",
        sub= "Boxplot der unabhängigen Variable KUT sowie der abhängigen Variablen Technikverständnis, Informationsmanagement und dem Umgang mit sozialen Online Medien.",
        ylab = "Angabe auf der Likert-Skala [1-6]"
        )



age_low <- subset(data, age_group == "low")
age_high <- subset(data, age_group == "high")

### Unterschiedshypothese 1

boxplot(age_low$TECH_VERS, age_high$TECH_VERS, age_low$INF_MAN, age_high$INF_MAN,
        col="#0c4c8a",
        main = "Digitale Kompetenzen nach Altersgruppen",
        ylab = "Likert-Skala [1-6]"
        )
mtext(text=c("Technikverständnis", "Informationsmanagement", "jung", "alt", "jung", "alt"),
      side = 1, line = c(1,1,2,2,2,2), at = c(1.5,3.5,1,2,3,4))

library(ggplot2)
ggplot(data, aes(x = KUT, y = TECH_VERS)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, size = 0.5) +
  labs(x = "Kontrollüberzeugung im Umgang mit Technik (KUT)", y = "Technikverständnis",
       title = "Je höher die KUT, desto höher das Technikverständnis.")

ggplot(data, aes(x = KUT, y = INF_MAN)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, size = 0.5) +
  xlim(1, 6) +
  ylim(1, 6) +
  labs(x = "Kontrollüberzeugung im Umgang mit Technik (KUT)", y = "Informationsmanagement",
       title = "Je höher die KUT, desto höher das Informationsmanagement")


library(ggplot2)

ggplot(data = data) +
  aes(x = age, y = SON_USE) +
  geom_point(color = 'blue') +
  theme_grey() +
  labs(x = "Alter", y = "Umgang mit Sozialen Online-Netzwerken",
     title = "")

ggplot(data, aes(x = KUT, y = SON_USE)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, size = 0.5) +
  labs(x = "Kontrollüberzeugung im Umgang mit Technik (KUT)", y = "Umgang mit Sozialen Online-Netzwerken",
       title = "Je höher die KUT, desto höher der Umgang mit Sozialen Online-Netzwerken")




library(ggplot2)

mean(data$KUT)
sd(data$KUT)
median(data$KUT)
min(data$KUT)     
max(data$KUT)

mean(data$TECH_VERS)
sd(data$TECH_VERS)
median(data$TECH_VERS)
min(data$TECH_VERS)     
max(data$TECH_VERS)

mean(data$INF_MAN)
sd(data$INF_MAN)
median(data$INF_MAN)
min(data$INF_MAN)     
max(data$INF_MAN)


psych::describe(data)

table(data$gender)

## test

library(plotrix)


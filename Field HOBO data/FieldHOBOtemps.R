setwd(dir = "~/Desktop/CSUMB/Thesis/Data analysis/Scripts/")
rm( list = ls())
graphics.off()
library(ggplot2)
library(ggpubr)
require(plyr)
library(dplyr)


cannery <- read.csv("../Data/Field HOBO data/8_18_19_Cannery.csv")
head(cannery)
names(cannery) <- c("num", "date", "time", "temp", "lum")
cannery$site <- "Cannery"
head(cannery)
nrow(cannery)
max(cannery$temp)
cannery <- cannery[2:520,]

aoa <- read.csv("../Data/Field HOBO data/8_17_19_Aoa.csv")
names(aoa) <- c("num", "date", "time", "temp", "lum")
aoa$site <- "Aoa"
head(aoa)
max(aoa$temp)
nrow(aoa)
aoa <- aoa[8:485,] #remove weird beginning and end

tele <- read.csv("../Data/Field HOBO data/Faga'tele_8_20_2019.csv")
names(tele) <- c("num", "date", "time", "temp", "lum")
tele$site <- "Fagatele"
head(tele)
min(tele$temp)
nrow(tele)
tele <- tele[61:6840,] #remove weird end temps 
tele = tele[seq(1, nrow(tele), 30), ] #change so its every 30 min like the others, not every 1 min
nrow(tele)
tele$num <- c(1:226) 
head(tele)

vatia <- read.csv("../Data/Field HOBO data/Vatia_8_22_19.csv")
names(vatia) <- c("num", "date", "time", "temp", "lum")
vatia$site <- "Vatia"
head(vatia)
nrow(vatia)
max(vatia$temp)
vatia <- vatia[2:416,] #remove weird end temps 


alu <- read.csv("../Data/Field HOBO data/08_19_2019_Faga'Alu.csv")
names(alu) <- c("num", "date", "time", "temp", "lum")
alu$site <- "Fagaalu"
head(alu)
nrow(alu)
alu <- alu[2:290,]

malo <- read.csv("../Data/Field HOBO data/2019_09_08_Fagamalo.csv", check.names = F)
names(malo) <- c("num", "date", "time", "temp", "lum")
malo$site <- "Fagamalo"
head(malo)
nrow(malo)
min(malo$temp)
malo <- malo[2:285,]


data <- merge(tele, vatia, all = T)
head(data)
data <- merge(data, vatia, all = T)
data <- merge(data, alu, all = T)
data <- merge(data, cannery, all = T)
data <- merge(data, aoa, all = T)
data <- merge(data, malo, all = T)
head(data)


ggplot(data, aes(num, temp))+geom_line(aes(colour=site))+
  ggtitle("") + ylab("Temp (deg C)")+xlab("Date / Time Point") + theme_minimal()

#ggsave("../Figures - bleaching phys/hobofieldtemps.pdf")

ggplot(data, aes(num, lum))+geom_line(aes(colour=site))+
  ggtitle("") + ylab("Light")+xlab("Date and Time") + theme_minimal()

data_stats <- data %>%
  group_by(site) %>%
  summarise(mintemp = min(temp), maxtemp = max(temp), avgtemp = mean(temp)) 
head(data_stats)


shapiro.test(data$temp)
ggqqplot(data$temp)
hist(data$temp)

data$temp_log <- log(data$temp)
shapiro.test(data$temp_log)
ggqqplot(data$temp_log)
hist(data$temp_log)


m1 <- lm(temp_log ~ site, data = data)
TukeyHSD(m1)




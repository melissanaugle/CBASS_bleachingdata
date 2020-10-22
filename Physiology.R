setwd(dir = "~/Desktop/GitHub/CBASS_bleachingdata/")
rm( list = ls())
graphics.off()
library(tidyverse) 
library(reshape2) 

#combine data sheets into master data sheet 
#remove time info on row 1

can <- read.csv("raw data sheets/CanneryII_8_18_19.csv", header = T)
can <- can[-c(1),]
head(can)
coco <- read.csv("raw data sheets/CoconutPointII_8_24_19.csv")
coco <- coco[-c(1),]
vat <- read.csv("raw data sheets/Vatia_8_22_19.csv")
vat <- vat[-c(1),]
alu <- read.csv("raw data sheets/Fagaalu_8_16_19.csv")
alu <- alu[-c(1),]
tele <- read.csv("raw data sheets/Faga'Tele_8_20_19.csv")
tele <- tele[-c(1),]

d <- merge(can,coco, all = T)
d <- merge(d,vat, all = T)
d <- merge(d,alu, all = T)
d <- merge(d,tele, all = T)
head(d)
nrow(d)

#merge average red data 
d <- d %>% mutate(AverageRed = coalesce(d$Avg.Red,d$avgred,d$AVG.Red, d$avg.red))
#remove old columns
d$avg.red <- NULL
d$avgred <- NULL
d$AVG.Red <- NULL
d$Avg.Red <- NULL
head(d)


write.csv(d, "MasterASData.csv")

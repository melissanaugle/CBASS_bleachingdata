setwd(dir = "~/Desktop/GitHub/CBASS_bleachingdata/")
rm( list = ls())
graphics.off()
library(ggplot2)
require(plyr)
library(dplyr)
library(reshape2)
library(mosaic)

data <- read.csv("raw data sheets/MasterASData.csv")
head(data)

#filter out only controls
data_controls <- data %>%
  filter(data$Ramp == "28") 

ggplot(data=data_controls, aes(x=Site, y = AverageRed, fill = Time.point))+ 
  geom_boxplot() + theme_minimal()
#blue shows stress, red shows recovery
#each point is one coral 
#lower value = less bleached 
#cannery and fagaalu controls did not bleach but tele and vatia did 

data_hightemp <- data %>%
  filter(data$Ramp == "35") 

ggplot(data=data_hightemp, aes(x=Site, y = AverageRed, fill = Time.point))+ 
  geom_boxplot() + theme_minimal()
#blue shows stress, red shows recovery
#all sites bleached at high temp 

head(data)
data$Coral.Watch.Color1 <- NULL
data$Coral.Watch.Color2 <- NULL
data$Coral.Watch.Color3 <- NULL
data$PAM..Fv.Fm. <- NULL
data$X <- NULL
#if tank A-D, rep 1; if tank E-F, rep 2
data$Rep[data$Tank == "A"] <- "1"
data$Rep[data$Tank == "B"] <- "1"
data$Rep[data$Tank == "C"] <- "1"
data$Rep[data$Tank == "D"] <- "1"
data$Rep[data$Tank == "E"] <- "2"
data$Rep[data$Tank == "F"] <- "2"
data$Rep[data$Tank == "G"] <- "2"
data$Rep[data$Tank == "H"] <- "2"
data$Tank <- NULL
data_normalized <- spread(data, Ramp, AverageRed)
head(data_normalized)
data_normalized$t35_normalizedto28 <- data_normalized$`35` - data_normalized$`28`
data_normalized$t34_normalizedto28 <- data_normalized$`34` - data_normalized$`28`
data_normalized$t33_normalizedto28 <- data_normalized$`33` - data_normalized$`28`
head(data_normalized)


ggplot(data=data_normalized, aes(x=Site, y = t33_normalizedto28, fill = Time.point))+ geom_boxplot() + theme_minimal()
ggplot(data=data_normalized, aes(x=Site, y = t34_normalizedto28, fill = Time.point))+ geom_boxplot() + theme_minimal()
ggplot(data=data_normalized, aes(x=Site, y = t35_normalizedto28, fill = Time.point))+ geom_boxplot() + theme_minimal()


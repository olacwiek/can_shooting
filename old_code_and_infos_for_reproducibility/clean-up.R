## Can shooting experiment
## Date: August 2018

## Data clean-up
## Script by Aleksandra Cwiek

rm(list=ls());cat("\014") 

##### START HERE #####
## initially planned clean-up
## was done in python
## see clean-up.ipynb

##### Clean-up of redundant data #####
## see: problem 1 and 2 in readme

## A function recoding the variables in numeric variables
recode=function(dataset) {
  
  dataset[["duration"]]=as.numeric(as.character(dataset[["duration"]]))
  
  dataset[["maxF0"]]=as.numeric(as.character(dataset[["maxF0"]]))
  dataset[["meanF0"]]=as.numeric(as.character(dataset[["meanF0"]]))
  dataset[["meanF0st"]]=as.numeric(as.character(dataset[["meanF0st"]]))
  dataset[["medianF0"]]=as.numeric(as.character(dataset[["medianF0"]]))
  dataset[["minF0"]]=as.numeric(as.character(dataset[["minF0"]]))
  dataset[["sdF0"]]=as.numeric(as.character(dataset[["sdF0"]]))
  dataset[["midpointF0"]]=as.numeric(as.character(dataset[["midpointF0"]]))
  
  dataset[["slopeF0"]]=as.numeric(as.character(dataset[["slopeF0"]]))
  
  dataset[["maxInt"]]=as.numeric(as.character(dataset[["maxInt"]]))
  dataset[["meanInt"]]=as.numeric(as.character(dataset[["meanInt"]]))
  dataset[["medianInt"]]=as.numeric(as.character(dataset[["medianInt"]]))
  dataset[["minInt"]]=as.numeric(as.character(dataset[["minInt"]]))
  dataset[["sdInt"]]=as.numeric(as.character(dataset[["sdInt"]]))
  dataset[["midpointInt"]]=as.numeric(as.character(dataset[["midpointInt"]]))
  
  # dataset[["maxF1"]]=as.numeric(as.character(dataset[["maxF1"]]))
  # dataset[["meanF1"]]=as.numeric(as.character(dataset[["meanF1"]]))
  dataset[["medianF1"]]=as.numeric(as.character(dataset[["medianF1"]]))
  dataset[["medianF1Bark"]]=as.numeric(as.character(dataset[["medianF1Bark"]]))
  # dataset[["minF1"]]=as.numeric(as.character(dataset[["minF1"]]))
  # dataset[["sdF1"]]=as.numeric(as.character(dataset[["sdF1"]]))
  # dataset[["midpointF1"]]=as.numeric(as.character(dataset[["midpointF1"]]))
  
  # dataset[["maxF2"]]=as.numeric(as.character(dataset[["maxF2"]]))
  # dataset[["meanF2"]]=as.numeric(as.character(dataset[["meanF2"]]))
  dataset[["medianF2"]]=as.numeric(as.character(dataset[["medianF2"]]))
  dataset[["medianF2Bark"]]=as.numeric(as.character(dataset[["medianF2Bark"]]))
  # dataset[["minF2"]]=as.numeric(as.character(dataset[["minF2"]]))
  # dataset[["sdF2"]]=as.numeric(as.character(dataset[["sdF2"]]))
  # dataset[["midpointF2"]]=as.numeric(as.character(dataset[["midpointF2"]]))
  
  dataset[["SPLH.SPL"]]=as.numeric(as.character(dataset[["SPLH.SPL"]]))
  
  return(dataset)
}

## Load data

setwd("C:/Users/ola/OneDrive/PSIMS/2018-f0-can/data/output-tables/new/")

file_list <- list.files()

for (file in file_list){
  
  # if the merged dataset doesn't exist, create it
  if (!exists("dataset")){
    dataset <- read.table(file, header=TRUE, sep=",")
    dataset=recode(dataset)
    dataset$file=file
  }
  
  # if the merged dataset does exist, append to it
  if (exists("dataset")){
    temp_dataset <-read.table(file, header=TRUE, sep=",")
    temp_dataset=recode(temp_dataset)
    temp_dataset$file=file
    dataset<-rbind(dataset, temp_dataset)
    rm(temp_dataset)
  }
  
}
## dump the stuff we don't need anymore
rm(file)
rm(file_list)

## change the name of the dataframe
df <- dataset
rm(dataset)

## some of the annotations had space or tabs in them, they need to be replaced before subsetting
data.frame(table(df$text))
df$text <- gsub("p\037", "p", df$text)
df$text <- gsub("a\037", "a", df$text)
df$text <- gsub("I\037", "I", df$text)
df$text <- gsub("f\037", "f", df$text)
df$text <- gsub("a\037\037", "a", df$text)
df$text <- gsub("I\037\037", "I", df$text)
df$text <- gsub("p\t", "p", df$text)
df$text <- gsub("f\t", "f", df$text)
## I don't know why, but these you have to run twice to work 100%
df$text <- gsub("a\037", "a", df$text)
df$text <- gsub("I\037", "I", df$text)

ndf <- subset(df, text=='p'|text=='I'|text=='a'|text=='f')

data.frame(table(ndf$text))
data.frame(table(ndf$file))

## First file is doubled, as it was loaded first as a start to a combined dataframe,
## so delete the first n rows (here n=151, because 150 rows),
## depending on the lenght of your initial file
ndf=ndf[c(151:nrow(ndf)),]
data.frame(table(ndf$text))
data.frame(table(ndf$file))

sum(is.na(ndf))
## a lot of NAs, but it's ok :)

## make subject column out of file 
ndf$subject = substr(ndf$file, 3, nchar(ndf$file)-10)
unique(ndf$subject)
ndf$subject <- as.factor(ndf$subject)
## we could delete file (but not yet, Susanne needs that for Matlab)
#ndf$file<-NULL

summary(ndf)

#### STOP HERE ####
### Save the table
write.csv(ndf, file = "all.csv",row.names=FALSE)

### Now you have to manually add codes of the conditions! (tripled lists in readme)

### If you did that, load the file again to add conditions and clean some more

### RE-READ THE TABLE ####

rm(list=ls())
setwd("C:/Users/ola/OneDrive/PSIMS/2018-f0-can/data/output-tables/")
df=read.csv('all.csv', sep='\t', dec = ",")

library(stringr)

summary(df)
## add column for part (can be used as random factor)
df$part=str_sub(df$file,-5,-5)
## add column for can size
df$size=substr(df$condition,1,1)
unique(df$size)
## from 1=high to 5=low
df$v.pos=substr(df$condition,3,3)
## from 1=left to 5=right
df$h.pos=substr(df$condition,4,4)

df$size <- as.factor(df$size)
df$v.pos <- as.factor(df$v.pos)
df$h.pos <- as.factor(df$h.pos)
## subject is integer, so change it to factor
df$subject <- as.factor(df$subject)

#### Optimize the parameters ####

## Normalization ----
## Semitones
spkrs=unique(df$subject)

df$st_maxF0=0
df$st_minF0=0

F0_meds=tapply(df[df$text=='a'|df$text=='I' & is.na(df$maxF0)==FALSE & is.na(df$medianF0)==FALSE,]$medianF0, 
               df[df$text=='a'|df$text=='I' & is.na(df$maxF0)==FALSE & is.na(df$medianF0)==FALSE,]$subject,
               median)

semi=log(2^(1/12))

for (sp in 1:length(spkrs)) {
  df[df$subject==spkrs[sp],]$st_maxF0=(log(df[df$subject==spkrs[sp],]$maxF0)-log(F0_meds[sp]))/semi
  df[df$subject==spkrs[sp],]$st_minF0=(log(df[df$subject==spkrs[sp],]$minF0)-log(F0_meds[sp]))/semi
}

df$st_F0range=df$st_maxF0-df$st_minF0

## Gender
df$F1centroid=600
df$F2centroid=1800

#data[data$sex=='m',]$F1centroid=500
#data[data$sex=='m',]$F2centroid=1500

df$F1centroidBark=13*atan(0.00076*df$F1centroid)+3.5*atan(df$F1centroid/7500)^2
df$F2centroidBark=13*atan(0.00076*df$F2centroid)+3.5*atan(df$F2centroid/7500)^2

df$vt_expansion=sqrt(abs(df$medianF1-df$F1centroid)^2+abs(df$medianF2-df$F2centroid)^2)
df$vt_expansionBark=sqrt(abs(df$medianF1Bark-df$F1centroidBark)^2+abs(df$medianF2Bark-df$F2centroidBark)^2)

## Spectral parameters
df$SPLH.SPL.dB=10*log10(df$SPLH.SPL)
df$F0range=df$maxF0-df$minF0

summary(df$SPLH.SPL.dB)
summary(df$SPLH.SPL)

## MoCap sampling rate
df$Fs <- 200
df[df$subject=="8"|df$subject=="9"|df$subject=="10"|df$subject=="11"|df$subject=="12"|df$subject=="13"|df$subject=="14",]$Fs=120

## Handedness
df$hand<-"r"
df[df$subject=="12",]$hand="l"

## Extract all segments
write.csv(df, file = "analysis_all.csv",row.names=FALSE)

## Extract vowels only
dfv <- subset(df, text=='I'|text=='a')
write.csv(dfv, file = "analysis_vow.csv",row.names=FALSE)

## Extract consonants only
dfc <- subset(df, text=='p'|text=='f')
write.csv(dfc, file = "analysis_cons.csv",row.names=FALSE)

#### THE END ####
#### Proceed with the markdown file!


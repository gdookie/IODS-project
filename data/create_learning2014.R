# Author: Gyan Dookie
# Date: 01.02.2017
# Description: Open Datascience, R-Studio Exercise 2 - Data wrangling & analysis
install.packages("dplyr")
library(dplyr)

lrn2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt",sep="\t", header=TRUE)
# str shows the structure of the data (for example the variables' names)
str(lrn2014)
# The dim-functions shows the dimensions of the data, the number of rows and variables in the dataset
dim(lrn2014) 

#Scale variables
lrn2014$attitude <- lrn2014$Attitude/10
lrn2014$Points

# Combine questions into combination variables
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D07","D14","D22","D30")
deep_columns <- select(lrn2014, one_of(deep_questions))
lrn2014$deep <- rowMeans(deep_columns)

surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
surface_columns <- select(lrn2014, one_of(surface_questions))
lrn2014$surf <- rowMeans(surface_columns)

strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
strategic_columns<- select(lrn2014, one_of(strategic_questions))
lrn2014$stra <- rowMeans(strategic_columns)

#Choose the variables to be shown in the dataset and put them in a vector
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# create a dataframe based on the selected variables
learning2014 <- select(lrn2014, one_of(keep_columns))
# Check out the structure of the dataframe
str(learning2014)
# filter out the zero Point rows with the != operand
learning2014 <- filter(learning2014, Points != 0)
# Check out the structure of the dataframe again
str(learning2014)
# Write the created dataframe into a csv-file (in the data-folder)
write.csv(learning2014, file = "data/learning2014.csv")
# Read the csv-file and print it to the console
read.csv(file="data/learning2014.csv", header=TRUE, sep= ",")


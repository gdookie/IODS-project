# Read the “Human development” and “Gender inequality” datas into R
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
# load dplyr
library(dplyr)
# library(plyr) I chose another why to change the variable names, so I don't need the plyr package
# Explore the datasets
# Human development - structure and dimensions
str(hd)
dim(hd)

# Gender inequality - structure and dimensions
str(gii)
dim(gii)
# Create summaries of variables
# Summary of Human development data
summary(hd)
summary(gii)

#Look at the meta files and rename the variables with (shorter) descriptive names. (1 point)
# Current names of variables - Human development
names(hd)
str(hd)
# Change  Human Development dataframe variable names to the following: HumDevRank, Country, HumDevIndex, LifeExpBirth, EduExpYrs, EduMeanYrs, GNI, GNIMinusHDI

# rename(hd, c("HDI.Rank" = "HumDevRank", "Human.Development.Index..HDI." = "HumDevIndex",  "Life.Expectancy.at.Birth"="LifeExpBirth","Expected.Years.of.Education"="EduExpYrs","Mean.Years.of.Education"= "EduMeanYrs", "Gross.National.Income..GNI..per.Capita"="GNI", "GNI.per.Capita.Rank.Minus.HDI.Rank"="GNIMinusHDI"))

names(hd) <- c("HumDevRank", "Country", "HumDevIndex", "LifeExpBirth", "EduExpYrs", "EduMeanYrs", "GNI", "GNIMinusHDI")
names(hd)
str(hd)
# Current names of variables - Gender inequality
names(gii)
# Change  Human Development dataframe variable names to the following: GendIneqRank, Country, GendIneqIndex, MatMortRat, AdolBirthRate, ParlPercRepres, EduSecondFemale, EduSecondMale, LabParticipFemale, LabParticipMale
names(gii) <- c("GendIneqRank", "Country", "GendIneqIndex", "MatMortRat", "AdolBirthRate", "ParlPercRepres", "EduSecondFemale", "EduSecondMale", "LabParticipFemale", "LabParticipMale")
names(gii)
str(gii)

#Mutate the “Gender inequality” data and create two new variables. The first one should be the ratio of Female and Male populations with secondary education in each country. (i.e. edu2F / edu2M). The second new variable should be the ratio of labour force participation of females and males in each country (i.e. labF / labM). (1 point)
gii <- mutate(gii, EduF2M = EduSecondFemale/EduSecondMale, LabF2M = LabParticipFemale/LabParticipMale)
names(gii)

#join together the two datasets using the variable Country as the identifier. Keep only the countries in both data sets (Hint: inner join). Call the new joined data human and save it in your data folder. (1 point)
# Here we join the two datasets by the selected identifier
#human <- inner_join(hd, gii, by = "Country", suffix=c(".hd", ".gii")) Let's not include the suffix argument, because it wasn't asked for in the exercise
human <- inner_join(hd, gii, by = "Country")
# Let's take a look at the new joined dataset to be sure everything is ok
dim(human)
glimpse(human)


# Next we'll save the wrangled and modified data as a .csv file
write.csv(human, "/Users/gyandookie/IODS-project/data/human.csv", row.names = FALSE)
# Let's double check the saved file by loading it and printing some of it's contents back to the console
# Important: the separator is a comma (",") as the file extension .csv implies 
human <- read.csv("/Users/gyandookie/IODS-project/data/human.csv",sep=",", header=TRUE)
glimpse(human)


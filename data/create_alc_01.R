# Author: Gyan Dookie
# Date: 10.02.2017
# Description:  Data wrangling of the Student alcohol consumption dataset (https://archive.ics.uci.edu/ml/datasets/STUDENT+ALCOHOL+CONSUMPTION)
## install and load the "dplyr" package
install.packages("dplyr")
library(dplyr)

# Read student-mat.csv and student-por.csv into R
math <- read.table("/Users/gyandookie/IODS-project/data/student-mat.csv",sep=";", header=TRUE)
por <- read.table("/Users/gyandookie/IODS-project/data/student-por.csv",sep=";", header=TRUE)

# str shows the structure of the data (for example the variables' names)
str(math)
str(por)
# The dim-functions shows the dimensions of the data, the number of rows and variables in the dataset
dim(math) 
dim(por)
# combine the common columns to use as identifiers into a vector named join_by
join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")


# Here we join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix=c(".math", ".por"))

# Exploring the structure and the dimensions of the joined data
str(math_por)
dim(math_por)
colnames(math_por)
glimpse(math_por)

#The following code combines the 'duplicated' answers in the joined data


alc <- select(math_por, one_of(join_by))
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]
colnames(notjoined_columns)
notjoined_columns

for(column_name in notjoined_columns) {
  two_columns <- select(math_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else { 
    alc[column_name] <- first_column
  }
}
# Take a glimpse at the combined data
glimpse(alc)


# Here were creating the alc_use (the average of week and week end alcohol usage) and high_use (TRUE for alcohol usage over 2) columns and adding them to the alc dataframe (the joined data)
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)

# Checking out the joined data with glimpse, just to be sure everything is ok for the data analysis phase

glimpse(alc)

# Next we'll save the wrangled and modified data as a .csv file
write.csv(alc, "/Users/gyandookie/IODS-project/data/alc_mod.csv", row.names = FALSE)
# Double checking the saved file by loading it and printing some of it's contents back to the console
# Important: the separator is a comma (",") as the file extension .csv implies 
alc_mod<- read.csv("/Users/gyandookie/IODS-project/data/alc_mod.csv",sep=",", header=TRUE)

head(alc_mod)
dim(alc_mod)
str(alc_mod)


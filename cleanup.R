# Cleanup script for our data
# Removes brackets
# Removes duplicate software mentions
# Adds preprints column
# by: Adam Rector
# 3/10/2021

library(svDialogs)
library(tidyverse)

# define where you are working
setwd("C:/class/newdata")

## read in data file

filepath <- choose.files(multi=F, caption="Choose File To Import", filters = Filters[c("All"),] ) 

data <- read.csv(file = filepath)

# remove first and last characters from the software column, i.e. the brackets
data$software <- substr(data$software, 2, nchar(data$software)-1)

# check each software list for internal repeats remove
data$software <- sapply(data$software, function(x) paste(unique(unlist(strsplit(x, ", "))), collapse = ", "))

# create the column that designates preprints
# column will contain a 1 if the publication is a preprint, and 0 if it is a full publication

data$preprint <- ifelse(data$license == "arxiv" | data$license == "medrxiv" | data$license == "biorxiv", 1, 0)

# write the new dataset to a csv
write.csv(data,"software_mentions_nodups.csv", row.names = FALSE)
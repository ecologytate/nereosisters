install.packages('tidyverse')
library(tidyverse)

# List of file paths
csv_files <- list.files(path= "./data", pattern = "*.csv", full.names = TRUE)

# Get the file name without the path and extension
file_name <- basename(csv_files)
file_name <- tools::file_path_sans_ext(file_name)

# Read and combine CSV files into a single data frame
combined_df <- do.call(rbind, lapply(csv_files, read.csv))

# Rename columns using the rename() function
combined_df <- combined_df %>% 
  select(-Slice) %>% # remove the slice column
  rename(unk=Ctr.0, female=Ctr.1, male=Ctr.2, und=Ctr.3) %>% # rename counter 0 to unknown, counter 1 to female, and counter 2 to male 
  mutate(treat_wellpic=file_name) %>% # add a column for treatment and well ID named after the .csv file names 
  relocate(treat_wellpic, .before = unk) # relocate the column to the first column in the dataframe

# Sum the sub-sample counts (a,b,c) for each well to get one value for each well!
# In this code, the sub function is used with the regular expression pattern ".$".

# The .$ pattern matches the last character of the string. 
# By replacing it with an empty string in the sub command
# everything except the last character is retained.

# Split the treatwell column into well and pic
combined_df$treat_well <- sub(".$", "", combined_df$treat_wellpic)
combined_df$pic <- sub(".*(.{1})$", "\\1", combined_df$treat_wellpic)

# Identify unique names that have multiple endings
matching_names <- unique(combined_df$treat_well[duplicated(combined_df$treat_well)])

# Subset the data frame to include only the rows with matching names
subset_data <- combined_df[combined_df$treat_well %in% matching_names, ]

# Sum the rows and create a new dataframe with the summed values
summed_data <- aggregate(cbind(female, male, unk, und) ~ treat_well, data = subset_data, FUN = sum)

# Add temp column to summed-original-72 data frame
T10 <- rep("T10", 18)
T13 <- rep("T13", 18)
T15 <- rep("T15", 18)
T18 <- rep("T18", 18)
summed_data <- summed_data %>%
  mutate(temp = c(T10, T13, T15, T18)) %>%
  relocate(temp, .before = treat_well)

# Save the data frame as a CSV file
write.csv(summed_data, "./output/summed-original-72.csv")


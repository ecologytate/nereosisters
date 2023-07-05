install.packages('tidyverse')
library(tidyverse)

# List of file paths
csv_files <- list.files(pattern = "*.csv", full.names = TRUE)

print(csv_files)

# Get the file name without the path and extension
file_name <- basename(csv_files)
file_name <- tools::file_path_sans_ext(file_name)

# Read and combine CSV files into a single data frame
combined_df <- do.call(rbind, lapply(csv_files, read.csv))
# Rename columns using the rename() function
combined_df <- combined_df %>% 
  select(-Slice) %>% # remove the slice column
  rename(unk=Ctr.0, female=Ctr.1, male=Ctr.2) %>% # rename counter 0 to unknown, counter 1 to female, and counter 2 to male 
  mutate(treatwell=file_name) %>% # add a column for treatment and well ID named after the .csv file names 
  relocate(treatwell, .before = unk) # relocate the column to the first column in the dataframe

# Print the combined data frame
print(combined_df)



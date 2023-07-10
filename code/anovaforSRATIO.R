#Add T10, T13, T15, T18 data frames
# Provide the file path
file_path1 <- "C:\\Users\\FHL Guest\\Documents\\GitHub\\nereosisters\\summed data\\T10 Data.csv"

# Read the CSV file
T10Data <- read.csv(file_path1)

file_path2 <- "C:\\Users\\FHL Guest\\Documents\\GitHub\\nereosisters\\summed data\\T13 Data.csv"

# Read the CSV file
T13Data <- read.csv(file_path2)

file_path3 <- "C:\\Users\\FHL Guest\\Documents\\GitHub\\nereosisters\\summed data\\T15 Data.csv"

# Read the CSV file
T15Data <- read.csv(file_path3)

file_path4 <- "C:\\Users\\FHL Guest\\Documents\\GitHub\\nereosisters\\summed data\\T18 Data.csv"

# Read the CSV file
T18Data <- read.csv(file_path4)


# Sample data for four treatment groups
T10 <- T10Data$female / T10Data$male
T13 <- T13Data$female / T13Data$male
T15 <- T15Data$female / T15Data$male
T18 <- T18Data$female / T18Data$male

# Combine the data into a single data frame
data <- data.frame(
  Group = factor(rep(c("Group 10", "Group 13", "Group 15", "Group 18"), each = 18)),
  Value = c(T10, T13, T15, T18)
)

# Perform the ANOVA test
result <- aov(Value ~ Group, data = data)


# Print the ANOVA table
print(summary(result))

#Print summary stats
print(summary(T10))
print(summary(T13))
print(summary(T15))
print(summary(T18))
boxplot(T10)

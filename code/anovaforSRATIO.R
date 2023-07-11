#Add T10, T13, T15, T18 data frames
# Read the T10 CSV file
T10Data <- read.csv("./summed data/T10 Data.csv")

# Read the T13 CSV file
T13Data <- read.csv("./summed data/T13 Data.csv")

# Read the T15 CSV file
T15Data <- read.csv("./summed data/T13 Data.csv")

# Read the T18 CSV file
T18Data <- read.csv("./summed data/T13 Data.csv")


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

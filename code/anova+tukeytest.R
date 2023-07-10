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

# Perform Tukey's post hoc test
tukey <- TukeyHSD(result)

# Print the ANOVA table
print(summary(result))

# Print the Tukey test results
print(tukey)

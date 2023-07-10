#Chi-square test

#load library
library(tidyverse)
library(stats)

summed_original <- read_csv("./output/summed-original-72.csv")

T10 <- rep("T10", 18)
T13 <- rep("T13", 18)
T15 <- rep("T15", 18)
T18 <- rep("T18", 18)

#add temp column to summed-original-72 data frame
summed_original <- summed_original %>%
  mutate(temp = c(T10, T13, T15, T18)) %>%
  relocate(temp, .before = treat_well)

# Summing count data by treatments
sum_data_fem <- aggregate(summed_original$female ~ summed_original$temp, summed_original, sum)
sum_data_mal <- aggregate(summed_original$male ~ summed_original$temp, summed_original, sum)
sum_data_all <- aggregate(summed_original$female+summed_original$male ~ summed_original$temp, summed_original, sum)

# Display the new data frame
print(sum_data_fem)
print(sum_data_mal)
print(sum_data_all)


# Combine aggregated data into a new data frame
combined_data <- merge(merge(sum_data_fem, sum_data_mal, by = "summed_original$temp"), sum_data_all, by = "summed_original$temp")

# Display the new data frame
print(combined_data)

# Create new contingency table to run Chi-sq
observed <- matrix(c(347, 450, 456, 693, 552, 739, 632, 649), nrow = 4, ncol = 2, byrow = TRUE) #observed frequencies
colnames(observed) <- c("Female", "Male")
rownames(observed) <- c("T10", "T13", "T15", "T18")

#check matrix is correct
print(observed)

# Define expected probabilities
expected_prob <- c(0.5, 0.5)

# Run chi-squared test with expected probability of 0.5
result <- chisq.test(observed, p = expected_prob)

# Print the result
print(result)
result$expected
result$residuals

#alternative test for p = 0.5
# Specify the expected proportion
expected_proportion <- 0.5

# Calculate the expected frequencies
expected <- expected_proportion * rowSums(observed)

print(expected)

# Perform the chi-square test of independence
result2 <- chisq.test(observed, p = expected_proportion)

# Print the result
print(result2)

# Run pairwise chi-square tests for multiple comparisons
pairwise_result <- pairwise.prop.test(observed, p.adjust.method = "bonferroni")

# Print the pairwise comparison result
print(pairwise_result)

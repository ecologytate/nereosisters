#Chi-square test

#load library
library(tidyverse)

summed_original <- read_csv("./output/summed-original-72.csv")

T10 <- rep("T10", 18)
T13 <- rep("T13", 18)
T15 <- rep("T15", 18)
T18 <- rep("T18", 18)

#add temp column
summed_original <- summed_original %>%
  mutate(temp = c(T10, T13, T15, T18)) %>%
  relocate(temp, .before = treat_well)

# create ratio of female/ total, male/ total within each temp
# yates correction to modify test statistic when 2 values/ proportions
# run 4 separate chisq tests

chisq.test(x = c())